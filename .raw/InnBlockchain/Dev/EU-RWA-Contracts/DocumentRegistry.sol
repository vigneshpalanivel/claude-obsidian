// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title DocumentRegistry (illustrative sample — not production code)
/// @notice ERC-1643-pattern anchor: hash + URI on-chain, the document itself off-chain. This
///         is a MULTI-REGIME contract, not a prospectus contract — it serves Prospectus
///         Art 21(7) (prospectus, final terms, supplements, ≥10y), MAR Arts 17/18 (disclosed
///         information and insider-list artefacts, ≥5y), ELTIF Arts 23–24 (its own prospectus
///         regime plus the annual report), and the PRIIPs KID with its Art 10 review cadence.
///         Scoping it from "prospectus" alone under-builds it for every fund and every retail
///         offer.
/// @dev    ⚠️ "MULTI-REGIME" IS NOT "MULTI-ASSET". This contract serves four regimes for one
///         instrument. Whether ONE registry serves MANY tokenized assets is a separate
///         question with a different answer — it is an open topology decision, and the
///         coupling that decides it is Art 23 supplement cost, not gas. Deploy per asset
///         until that is settled; merging later is cheap, splitting later is a re-issuance.
/// @dev    ⚠️ THE VERSION HASH IS THE PRODUCT, NOT THE DOCUMENT. Every delivery, consent and
///         acknowledgement duty in the stack is discharged against a SPECIFIC VERSION —
///         PRIIPs Art 13 delivery, DLT Pilot Art 4(2)(g) informed consent, ELTIF Art 18(3).
///         `CovenantRegistry` satisfies a gate by comparing the investor's stored version
///         hash against `currentVersionHash()` here. That comparison is what makes a document
///         revision invalidate every outstanding acknowledgement THE MOMENT IT IS ANCHORED,
///         with no sweep, no configuration, and no chance to forget. Fail-closed by
///         construction. A `hasAcknowledged` boolean anywhere in that path reintroduces the
///         fail-open this design exists to remove.
/// @dev    ⚠️ ANCHORING A NEW VERSION IS NOT THE SAME EVENT IN EVERY REGIME, AND THE
///         ASYMMETRY IS LOAD-BEARING:
///           • Prospectus Art 23 supplement → OPENS a 3-working-day withdrawal window in
///             `SubscriptionEscrow`. Investors who already agreed may withdraw.
///           • PRIIPs Art 10 KID revision → opens NO window. It INVALIDATES outstanding
///             delivery acknowledgements instead.
///         Do not reuse the escrow's window machinery for a KID revision. This contract emits
///         a distinct event per regime for exactly that reason; a single generic
///         `DocumentUpdated` would force the escrow to guess.
/// @dev    ⚠️ NO DELETE FUNCTION EXISTS, AND THAT IS THE RETENTION CONTROL. Art 21(7) is ten
///         years, MAR Art 18(5) is five. Rather than store a retention date nothing enforces,
///         the version history is append-only: superseding v1 with v2 marks v1 non-current
///         and removes nothing. The retention deadline is emitted for the off-chain archive
///         that actually holds the file — on-chain, the guarantee is that the hash you
///         anchored is still provably the hash you anchored.
/// @dev    GDPR: no document content and no personal data ever reaches storage. An insider
///         list under MAR Art 18(3) carries names, dates of birth, home addresses and
///         telephone numbers — precisely the category Art 17 gives a right of erasure over,
///         which an immutable ledger cannot honour. Anchor the hash, keep the list off-chain.
contract DocumentRegistry {
    // ═══════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Which regime's clock and consequences attach to this document. Deliberately a
    ///         SMALL enum and not an open bytes32: unlike a covenant type, a document's regime
    ///         changes what the rest of the stack must do when a new version lands (window vs
    ///         no window, review cadence vs none). A new regime here is a genuine design
    ///         event, not a configuration one.
    enum Regime {
        Unset,
        ProspectusRegulation, // Arts 6/12/21(7)/23 — supplements open escrow windows
        MarDisclosure, // Arts 17, 18 — ≥5y, and the Art 17(1a) confidentiality problem
        EltifDisclosure, // Arts 23–24 — its own prospectus regime + annual report
        PriipsKid // Art 10 — ≥12-month review cadence, no withdrawal window
    }

    struct Version {
        bytes32 versionHash; // hash of the document file itself
        bytes32 uriHash; // digest of the resolvable location (IPFS CID / URL)
        uint64 anchoredAt;
        uint64 approvedAt; // NCA approval; 0 = none recorded (see `documentStatus`)
        uint64 reviewDueBy; // PRIIPs Art 10 only; 0 = no periodic review duty
        bool revealed; // MAR Art 17(1a) commit-reveal — see `anchorConcealed`
    }

    struct Document {
        bool exists;
        Regime regime;
        uint32 currentIndex; // index into `_versions[docRef]`
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ROLES
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Anchoring a document is a governance action on the same multisig/timelock path
    ///         as an upgrade (§9). It is not an operational function: a supplement anchor
    ///         opens a statutory withdrawal window, and a KID anchor invalidates every
    ///         outstanding acknowledgement. Neither belongs on a daily-operations key.
    address public immutable governance;

    // ═══════════════════════════════════════════════════════════════════════
    // STATE
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev `docRef` is a stable, issuer-chosen identifier for the DOCUMENT SLOT — "the KID
    ///      for this product", "the prospectus for this offer" — not for one version of it.
    ///      Versions accumulate underneath it.
    mapping(bytes32 => Document) private _documents;
    mapping(bytes32 => Version[]) private _versions;

    /// @notice Reverse index for `documentStatus()`, the read `DoraGovernor` performs before
    ///         it will queue an upgrade. It asks about a version hash it was handed, not about
    ///         a slot it knows the name of.
    mapping(bytes32 => bytes32) private _versionHashToDocRef;
    mapping(bytes32 => bool) private _versionHashKnown;

    /// @notice PRIIPs Art 10 default: reviewed at least every 12 months AND on any material
    ///         change. The clock is the floor, not the trigger — a material change obliges a
    ///         review immediately and no timer can detect one.
    uint64 public constant PRIIPS_REVIEW_PERIOD = 365 days;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS — one per regime, because the consequences differ
    // ═══════════════════════════════════════════════════════════════════════

    event DocumentOpened(bytes32 indexed docRef, Regime indexed regime, uint64 retentionUntil);

    /// @param uri The resolvable location, emitted in full. Storage holds only its digest;
    ///            the string lives in logs, where it is cheap and permanent.
    event VersionAnchored(
        bytes32 indexed docRef, bytes32 indexed versionHash, uint32 index, string uri, uint64 retentionUntil
    );

    /// @notice Prospectus Art 23 — the escrow listens for THIS event to open window type A.
    event SupplementPublished(bytes32 indexed docRef, bytes32 indexed versionHash, uint64 publishedAt);

    /// @notice PRIIPs Art 10 — deliberately NOT `SupplementPublished`. No window opens; the
    ///         effect is that outstanding covenant acknowledgements stop satisfying their gate.
    event KidRevised(bytes32 indexed docRef, bytes32 indexed supersededHash, bytes32 indexed newHash);

    event NcaApprovalRecorded(bytes32 indexed docRef, bytes32 indexed versionHash, uint64 approvedAt);
    event ReviewAttested(bytes32 indexed docRef, bytes32 indexed versionHash, uint64 nextDueBy);
    event ConcealedAnchored(bytes32 indexed docRef, bytes32 indexed commitHash);
    event ConcealedRevealed(bytes32 indexed docRef, bytes32 indexed versionHash);

    // ═══════════════════════════════════════════════════════════════════════
    // ERRORS
    // ═══════════════════════════════════════════════════════════════════════

    error NotGovernance();
    error UnknownDocument(bytes32 docRef);
    error DocumentAlreadyOpen(bytes32 docRef);
    error VersionHashAlreadyUsed(bytes32 versionHash);
    error EmptyVersionHash();
    error NotAPriipsKid(bytes32 docRef);
    error NoVersionAnchored(bytes32 docRef);
    error CommitMismatch(bytes32 expected, bytes32 got);
    error AlreadyRevealed(bytes32 docRef);
    error NothingConcealed(bytes32 docRef);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_) {
        governance = governance_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ANCHORING
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Opens a document slot. The regime is fixed for the life of the slot — a
    ///         prospectus does not become a KID, and letting it change would silently move a
    ///         document between "supplement opens a window" and "revision opens nothing".
    /// @param retentionUntil The off-chain archive's deadline — Art 21(7) is ≥10 years from
    ///                       publication, MAR Art 18(5) is ≥5 years. Emitted, never stored:
    ///                       nothing on-chain can enforce a duty owed by a file server, and a
    ///                       stored date no `require` reads is decoration.
    function openDocument(bytes32 docRef, Regime regime, uint64 retentionUntil) external onlyGovernance {
        if (_documents[docRef].exists) revert DocumentAlreadyOpen(docRef);

        _documents[docRef] = Document({exists: true, regime: regime, currentIndex: 0});
        emit DocumentOpened(docRef, regime, retentionUntil);
    }

    /// @notice Anchors a new version and makes it current. The previous version stays in
    ///         history and stops satisfying every covenant bound to it, immediately.
    /// @dev    ⚠️ THIS CALL HAS DOWNSTREAM STATUTORY EFFECT. For a Prospectus supplement it
    ///         opens a 3-working-day withdrawal window on every subscription accepted before
    ///         it; for a KID it invalidates outstanding acknowledgements. Under Art 23(1) the
    ///         NCA has up to 5 working days to approve a supplement, and that time does NOT
    ///         run concurrently with the §9 timelock — approval and publication precede
    ///         execution. Budget the calendar in weeks.
    function anchorVersion(bytes32 docRef, bytes32 versionHash, bytes32 uriHash, string calldata uri, uint64 retentionUntil)
        external
        onlyGovernance
        returns (uint32 index)
    {
        Document storage doc = _documents[docRef];
        if (!doc.exists) revert UnknownDocument(docRef);
        if (versionHash == bytes32(0)) revert EmptyVersionHash();
        if (_versionHashKnown[versionHash]) revert VersionHashAlreadyUsed(versionHash);

        bytes32 superseded;
        if (_versions[docRef].length > 0) {
            superseded = _versions[docRef][doc.currentIndex].versionHash;
        }

        uint64 reviewDueBy = doc.regime == Regime.PriipsKid ? uint64(block.timestamp) + PRIIPS_REVIEW_PERIOD : 0;

        _versions[docRef].push(
            Version({
                versionHash: versionHash,
                uriHash: uriHash,
                anchoredAt: uint64(block.timestamp),
                approvedAt: 0,
                reviewDueBy: reviewDueBy,
                revealed: true
            })
        );

        index = uint32(_versions[docRef].length - 1);
        doc.currentIndex = index;

        _versionHashKnown[versionHash] = true;
        _versionHashToDocRef[versionHash] = docRef;

        emit VersionAnchored(docRef, versionHash, index, uri, retentionUntil);

        if (superseded != bytes32(0)) {
            if (doc.regime == Regime.PriipsKid) {
                emit KidRevised(docRef, superseded, versionHash);
            } else if (doc.regime == Regime.ProspectusRegulation) {
                emit SupplementPublished(docRef, versionHash, uint64(block.timestamp));
            }
        }
    }

    /// @notice Records that the NCA approved this version. `DoraGovernor.queueUpgrade` reads
    ///         it and refuses to queue anything whose disclosure artefact is anchored but not
    ///         approved — deploy-then-disclose inverts the statutory order and no timelock
    ///         fixes it.
    function recordNcaApproval(bytes32 docRef, bytes32 versionHash, uint64 approvedAt) external onlyGovernance {
        Document storage doc = _documents[docRef];
        if (!doc.exists) revert UnknownDocument(docRef);

        Version[] storage vs = _versions[docRef];
        for (uint256 i = 0; i < vs.length; i++) {
            if (vs[i].versionHash == versionHash) {
                vs[i].approvedAt = approvedAt;
                emit NcaApprovalRecorded(docRef, versionHash, approvedAt);
                return;
            }
        }
        revert UnknownDocument(docRef);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // MAR ART 17(1a) — CONCEALED ANCHORING
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Anchors a commitment to a document nobody may yet see. Since the Listing Act,
    ///         Art 17(1) second sentence narrows the DISCLOSURE duty to the final event of a
    ///         protracted process, while Art 17(1a) imposes a STANDALONE duty to keep the
    ///         intermediate steps CONFIDENTIAL until then.
    /// @dev    ⚠️ THE BREACH IS CONFIDENTIALITY, NOT LATENESS, AND THAT CHANGES THE CURE. You
    ///         cannot fix a public intermediate step by disclosing earlier — Art 17(1) does not
    ///         yet require disclosure, and Art 17(4) cannot delay what the chain has already
    ///         published. The only cure is not to publish it in the clear. Commit here, reveal
    ///         when the final event is disclosed.
    function anchorConcealed(bytes32 docRef, bytes32 commitHash) external onlyGovernance {
        Document storage doc = _documents[docRef];
        if (!doc.exists) revert UnknownDocument(docRef);

        _versions[docRef].push(
            Version({
                versionHash: commitHash,
                uriHash: bytes32(0),
                anchoredAt: uint64(block.timestamp),
                approvedAt: 0,
                reviewDueBy: 0,
                revealed: false
            })
        );

        emit ConcealedAnchored(docRef, commitHash);
    }

    /// @dev The commitment is `keccak256(abi.encode(versionHash, uriHash, salt))`. A salt is
    ///      mandatory and not a nicety: without it, a document drawn from a small predictable
    ///      set is brute-forceable from its own commitment, which leaks precisely what
    ///      Art 17(1a) required to stay confidential.
    function revealConcealed(bytes32 docRef, bytes32 versionHash, bytes32 uriHash, bytes32 salt, string calldata uri)
        external
        onlyGovernance
    {
        Document storage doc = _documents[docRef];
        if (!doc.exists) revert UnknownDocument(docRef);

        Version[] storage vs = _versions[docRef];
        if (vs.length == 0) revert NoVersionAnchored(docRef);

        Version storage v = vs[vs.length - 1];
        if (v.revealed) revert AlreadyRevealed(docRef);
        if (v.uriHash != bytes32(0)) revert NothingConcealed(docRef);

        bytes32 expected = keccak256(abi.encode(versionHash, uriHash, salt));
        if (expected != v.versionHash) revert CommitMismatch(expected, v.versionHash);

        v.versionHash = versionHash;
        v.uriHash = uriHash;
        v.revealed = true;

        _versionHashKnown[versionHash] = true;
        _versionHashToDocRef[versionHash] = docRef;
        doc.currentIndex = uint32(vs.length - 1);

        emit ConcealedRevealed(docRef, versionHash);
        emit VersionAnchored(docRef, versionHash, uint32(vs.length - 1), uri, 0);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PRIIPS ART 10 — REVIEW CADENCE
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Attests that the Art 10 review happened and the KID did NOT need revision.
    ///         A review that DOES require revision goes through `anchorVersion` instead — that
    ///         is a new document, not a renewed clock.
    /// @dev    ⚠️ A REVIEW IS NOT A TIMER RESET WITH EXTRA STEPS. Art 10 requires review at
    ///         least every 12 months AND on any material change. The clock catches the first
    ///         limb only; nothing on-chain can detect a material change in the underlying
    ///         product. This function is the on-chain record of a human judgement, and the
    ///         governance path is what gives that judgement an owner.
    function attestReview(bytes32 docRef) external onlyGovernance {
        Document storage doc = _documents[docRef];
        if (!doc.exists) revert UnknownDocument(docRef);
        if (doc.regime != Regime.PriipsKid) revert NotAPriipsKid(docRef);

        Version[] storage vs = _versions[docRef];
        if (vs.length == 0) revert NoVersionAnchored(docRef);

        Version storage v = vs[doc.currentIndex];
        v.reviewDueBy = uint64(block.timestamp) + PRIIPS_REVIEW_PERIOD;

        emit ReviewAttested(docRef, v.versionHash, v.reviewDueBy);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS — the fail-closed surface `CovenantRegistry` depends on
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice The interface `DoraGovernor` already codes against. Keyed by version hash
    ///         because the governor is handed an artefact hash, not a slot name.
    function documentStatus(bytes32 documentHash) external view returns (bool exists, uint64 approvedAt) {
        if (!_versionHashKnown[documentHash]) return (false, 0);

        bytes32 docRef = _versionHashToDocRef[documentHash];
        Version[] storage vs = _versions[docRef];
        for (uint256 i = 0; i < vs.length; i++) {
            if (vs[i].versionHash == documentHash) {
                return (true, vs[i].approvedAt);
            }
        }
        return (false, 0);
    }

    /// @notice The version a covenant must match to still satisfy its gate.
    function currentVersionHash(bytes32 docRef) external view returns (bytes32) {
        Document storage doc = _documents[docRef];
        if (!doc.exists) return bytes32(0);

        Version[] storage vs = _versions[docRef];
        if (vs.length == 0) return bytes32(0);

        Version storage v = vs[doc.currentIndex];
        if (!v.revealed) return bytes32(0);
        return v.versionHash;
    }

    /// @notice ⚠️ THE FAIL-CLOSED READ. Returns false when the hash is superseded — and ALSO
    ///         when a KID's Art 10 review is overdue. An out-of-review KID is not evidence of
    ///         a discharged Art 13 duty, and treating "we forgot to review it" as equivalent
    ///         to "it is current" is the fail-open this whole mechanism exists to prevent.
    ///         Overdue therefore blocks new retail subscriptions rather than logging a warning
    ///         nobody reads.
    function isCurrent(bytes32 docRef, bytes32 versionHash) external view returns (bool) {
        Document storage doc = _documents[docRef];
        if (!doc.exists || versionHash == bytes32(0)) return false;

        Version[] storage vs = _versions[docRef];
        if (vs.length == 0) return false;

        Version storage v = vs[doc.currentIndex];
        if (!v.revealed) return false;
        if (v.versionHash != versionHash) return false;
        if (v.reviewDueBy != 0 && block.timestamp > v.reviewDueBy) return false;

        return true;
    }

    function versionCount(bytes32 docRef) external view returns (uint256) {
        return _versions[docRef].length;
    }

    function versionAt(bytes32 docRef, uint256 index) external view returns (Version memory) {
        return _versions[docRef][index];
    }

    function regimeOf(bytes32 docRef) external view returns (Regime) {
        return _documents[docRef].regime;
    }
}
