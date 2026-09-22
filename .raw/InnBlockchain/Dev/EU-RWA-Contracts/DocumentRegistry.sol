// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Version} from "./Interfaces.sol";

/// @title DocumentRegistry (illustrative sample — not production code)
/// @notice ERC-1643-pattern anchor: hash + URI on-chain, the document itself off-chain. This
///         is a MULTI-REGIME contract, not a prospectus contract — it serves Prospectus
///         Art 21(7) (prospectus, final terms, supplements, ≥10y), MAR Arts 17/18 (disclosed
///         information and insider-list artefacts, ≥5y), ELTIF Arts 23–24 (its own prospectus
///         regime plus the annual report), and the PRIIPs KID. Scoping it from "prospectus"
///         alone under-builds it for every fund and every retail offer.
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
/// @dev    ⚠️ THIS CONTRACT KNOWS NOTHING ABOUT REGIMES, AND THAT IS THE POINT — changed at
///         rev 65. It used to carry a `Regime` enum per slot and emit `SupplementPublished` /
///         `KidRevised` so a reader could tell an Art 23 supplement (which opens a withdrawal
///         window) from a PRIIPs Art 10 KID revision (which does not). Three findings ended it:
///           • **Contracts cannot read events.** `SupplementPublished` never opened anything.
///             `SubscriptionEscrow.publishSupplement` is a separate governance transaction that
///             someone must remember to send, and the escrow's own NatSpec says so. The event
///             was reconciliation data for an off-chain indexer, never a mechanism.
///           • **The enum's entire on-chain footprint was ONE read** — `regimeOf`, in one line
///             of one escrow function, guarding against a KID hash opening an Art 23 window.
///             That guard moved to a `docRef` allowlist in the escrow, which is per-offer,
///             never proxied, and the right home for offer-specific configuration.
///           • **A closed enum forces a redeploy to serve a new regime, and a redeploy is
///             uniquely expensive here.** Not because evidence would be lost — it lives in the
///             event log and survives at the old address (see the D20 note below) — but because
///             the anchor history would be split across two addresses with no on-chain link,
///             the new deployment would answer reads about none of the old versions, and every
///             consumer and indexer would need re-pointing and re-seeding. The regime coupling
///             was the thing most likely to force exactly that.
///         The asymmetry it documented is REAL and still matters — a supplement opens a window,
///         a KID revision invalidates acknowledgements instead. It is now a runbook fact and an
///         indexer's classification, not a `require` and not an enum. `VersionAnchored` carries
///         `supersededHash` so the indexer can still answer "which acknowledgements just died"
///         without this contract knowing why.
/// @dev    ⚠️ APPROVAL IS AN ANCHOR ARGUMENT, NOT A LATER CALL, AND THAT ENFORCES THE
///         STATUTORY ORDER. Until 2026-09-22 a separate `recordNcaApproval` let a version sit
///         anchored-but-unapproved, and `SubscriptionEscrow` carried two reverts to catch the
///         state. Art 23(1) puts approval BEFORE publication — the NCA has up to 5 working
///         days and the supplement is published after it clears — so the unapproved-anchor
///         state was never lawful in the first place. Passing `approvedAt` to `anchorVersion`
///         makes it unrepresentable rather than merely detected. Two consequences to hold:
///           • Regimes with no ex-ante approval pass 0 — a PRIIPs KID is not approved, MAR
///             disclosure is not approved, and Art 8(5) final terms are FILED, not approved.
///             `approvedAt == 0` is therefore a normal value, not an error.
///           • A wrong `approvedAt` is no longer patchable in place. Correcting one means
///             anchoring a new version, which for a Prospectus slot OPENS A WITHDRAWAL
///             WINDOW. The date is fed from the NCA's own decision notice; treat entering it
///             as part of the approval workflow, not as a field on a form.
/// @dev    ⚠️ NO DELETE FUNCTION EXISTS, AND THAT IS THE RETENTION CONTROL. Art 21(7) is ten
///         years, MAR Art 18(5) is five. Rather than store a retention date nothing enforces,
///         the version history is append-only: superseding v1 with v2 marks v1 non-current
///         and removes nothing. The retention deadline is emitted for the off-chain archive
///         that actually holds the file — on-chain, the guarantee is that the hash you
///         anchored is still provably the hash you anchored.
/// @dev    ⚠️ THE PRIIPs ART 10 REVIEW IS AN OFF-CHAIN DUTY WITH A NAMED OWNER, NOT A TIMER
///         HERE. Until 2026-09-22 this contract carried a 12-month `reviewDueBy` clock and an
///         `attestReview` call, and `isCurrent` returned false once the clock expired. It was
///         withdrawn because Art 10 has TWO limbs — at least every 12 months AND on any
///         material change — and a timer catches only the limb that does not matter. Nothing
///         on-chain can detect a material change in the underlying product, so the clock
///         bought a false assurance that the review duty was mechanised while the limb that
///         actually breaches went unwatched. This is the same trade already made on the
///         upgrade path (`UPGRADE-ARCHITECTURE.md` §5): where the judgement is human, put the
///         control in a reconciliation job with an owner, not in a `require` that can only
///         see the calendar. ⚠️ The consequence is real and must be staffed: a KID that is
///         never reviewed still satisfies `isCurrent` indefinitely. The compensating control
///         is off-chain and lives in `DEPLOYMENT-DEFAULTS.md`.
/// @dev    ⚠️ NO COMMIT-REVEAL. Until 2026-09-22 `anchorConcealed` / `revealConcealed` let the
///         issuer anchor a hash-of-a-hash for a document MAR Art 17(1a) requires to stay
///         confidential during a protracted process, then open it at announcement. Withdrawn:
///         a document that is never anchored until the final event is disclosed has no
///         confidentiality problem to solve on-chain, and the mechanism bought only a
///         PROVABLE PRE-ANNOUNCEMENT TIMESTAMP — evidence no regime actually demands here.
///         Art 17(4) delayed disclosure is evidenced by the notification to the NCA, and the
///         Art 18 insider list carries its own dated record off-chain. Anchor after the
///         announcement. If a pre-announcement timestamp is ever genuinely required, an
///         off-chain notarisation supplies it without an unrevealable-commitment failure mode
///         in the registry.
/// @dev    ⚠️ `governance` IS `immutable` AND THAT DECISION IS LOAD-BEARING ON D20. The
///         address is the Safe, so signer rotation happens inside the Safe and never moves
///         it; this matches every other contract in the suite. But moving governance to a
///         DIFFERENT address — Safe to a bare `TimelockController`, a custodian change that
///         produces a new Safe — means redeploying, and this contract cannot resume: there is
///         no rotation function.
///         ⚠️ CORRECTED 2026-09-22 (rev 68) — AN EARLIER VERSION OF THIS NOTE CLAIMED A PROXY
///         WOULD DESTROY THE ART 21(7) PROOF. IT WOULD NOT, AND THE DISTINCTION MATTERS:
///           • **The proof is in the LOGS, and no upgrade can touch them.** `VersionAnchored`
///             is written into block history when the anchor transaction is mined. An auditor
///             asking "was this hash anchored on 3 March 2027" reads that log and the block it
///             sits in. Replacing the implementation replaces CODE; it cannot rewrite a mined
///             block. **The audit trail survives a proxy intact.**
///           • **What a proxy exposes is the LIVE READS.** `versionAt`, `currentVersionHash`,
///             `isCurrent` and `documentStatus` answer from storage through the current
///             implementation, and a new implementation can write any slot. So state can be
///             made to contradict the log. The log still wins in front of an auditor — but
///             `CovenantRegistry.isCurrent` and `SubscriptionEscrow` gate on the LIVE answer,
///             so what is corruptible is the compliance gating, not the evidence.
///           • ⚠️ **And that is true of every contract in this suite, so it is NOT a special
///             argument for this one.** The honest case against proxying here is thinner than
///             it was written: one fewer moving part, no governance-capture surface on the
///             contract holding the evidence, and no upgrade mechanism to disclose as an
///             offer-document content item. That is enough; the overstated version was not
///             needed and should not be repeated.
///         **DECIDED 2026-09-22: not proxied, `governance` stays
///         `immutable`, and no rotation function is added.** The operator commits to Safe as
///         the governance holder, and a Safe's address does not move — signers rotate inside
///         it. That closes D20 for this contract.
///         ⚠️ **The residual, so nobody rediscovers it as a surprise: if the Safe ADDRESS ever
///         has to change — a custodian migration issuing a new Safe, a move to a bare
///         `TimelockController` — this registry can never be written to again.** Reads survive
///         and every existing anchor stays provable; what is lost is the ability to anchor
///         anything further, and a replacement registry starts empty and can prove nothing
///         about this one's history. The decision is that Safe-address stability is a safer
///         bet than either a proxy (which adds a disclosable upgrade mechanism and puts the
///         live read surface under governance control — NOT, as this note once claimed, which
///         destroys the evidence) or a rotation function (which adds a governance-capture
///         surface to the contract holding the evidence). Revisit only if the Safe commitment
///         changes.
/// @dev    GDPR: no document content and no personal data ever reaches storage. An insider
///         list under MAR Art 18(3) carries names, dates of birth, home addresses and
///         telephone numbers — precisely the category Art 17 gives a right of erasure over,
///         which an immutable ledger cannot honour. Anchor the hash, keep the list off-chain.
contract DocumentRegistry {
    // ═══════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice A document SLOT. Deliberately carries no regime, no type and no classification —
    ///         only what this contract needs to answer "is this hash still current", and nothing
    ///         a new regulation could invalidate. What a document IS, and what follows from
    ///         revising it, belongs to the contract that gates on it.
    struct Document {
        bool exists;
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

    /// @notice Reverse index for `documentStatus()`, the read `SubscriptionEscrow` performs
    ///         before it opens an Art 23(2) window or accepts a subscription. It asks about a
    ///         version hash it was handed, not about a slot it knows the name of. (`DoraGovernor`
    ///         used to perform the same read before queueing an upgrade; that limb was
    ///         withdrawn — see `UPGRADE-ARCHITECTURE.md`.)
    mapping(bytes32 => bytes32) private _versionHashToDocRef;
    mapping(bytes32 => bool) private _versionHashKnown;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS — generic. Classification is the indexer's job, not this contract's.
    // ═══════════════════════════════════════════════════════════════════════

    event DocumentOpened(bytes32 indexed docRef, uint64 retentionUntil);

    /// @param uri The resolvable location, emitted in full. Storage holds only its digest;
    ///            the string lives in logs, where it is cheap and permanent.
    /// @param approvedAt The NCA's approval date, or 0 in a regime with no ex-ante approval.
    ///                   Carried here rather than on a separate `NcaApprovalRecorded` so an
    ///                   indexer sees publication and approval as one fact, which is what
    ///                   Art 23(1) makes them.
    /// @param supersededHash The version this one replaced, or 0 if this is the slot's first.
    ///                       ⚠️ This is what the regime events used to carry and it is the only
    ///                       part of them worth keeping. An indexer classifying this slot as a
    ///                       PRIIPs KID needs the OLD hash to know which outstanding delivery
    ///                       acknowledgements just stopped satisfying their gate; "v2 is live"
    ///                       does not tell it that, "v1 → v2" does. Indexed, so the reconciliation
    ///                       join is a filter rather than a scan.
    event VersionAnchored(
        bytes32 indexed docRef,
        bytes32 indexed versionHash,
        bytes32 indexed supersededHash,
        uint32 index,
        string uri,
        uint64 approvedAt,
        uint64 retentionUntil
    );

    // ═══════════════════════════════════════════════════════════════════════
    // ERRORS
    // ═══════════════════════════════════════════════════════════════════════

    error NotGovernance();
    error UnknownDocument(bytes32 docRef);
    error DocumentAlreadyOpen(bytes32 docRef);
    error VersionHashAlreadyUsed(bytes32 versionHash);
    error EmptyVersionHash();

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
    function openDocument(bytes32 docRef, uint64 retentionUntil) external onlyGovernance {
        if (_documents[docRef].exists) revert DocumentAlreadyOpen(docRef);

        _documents[docRef] = Document({exists: true, currentIndex: 0});
        emit DocumentOpened(docRef, retentionUntil);
    }

    /// @notice Anchors a new version and makes it current. The previous version stays in
    ///         history and stops satisfying every covenant bound to it, immediately.
    /// @dev    ⚠️ THIS CALL HAS DOWNSTREAM STATUTORY EFFECT. For a Prospectus supplement it
    ///         opens a 3-working-day withdrawal window on every subscription accepted before
    ///         it; for a KID it invalidates outstanding acknowledgements. Under Art 23(1) the
    ///         NCA has up to 5 working days to approve a supplement, and that time does NOT
    ///         run concurrently with the §9 timelock — approval and publication precede
    ///         execution. Budget the calendar in weeks.
    /// @param approvedAt The NCA's approval date from its decision notice. Pass 0 for a regime
    ///                   with no ex-ante approval (PRIIPs KID, MAR disclosure, Art 8(5) final
    ///                   terms). Not validated here — `SubscriptionEscrow` is what decides
    ///                   that a zero is fatal on ITS path, because only the escrow knows which
    ///                   slot is the offer's prospectus. This contract records; it does not
    ///                   adjudicate another regime's preconditions.
    function anchorVersion(
        bytes32 docRef,
        bytes32 versionHash,
        bytes32 uriHash,
        string calldata uri,
        uint64 approvedAt,
        uint64 retentionUntil
    ) external onlyGovernance returns (uint32 index) {
        Document storage doc = _documents[docRef];
        if (!doc.exists) revert UnknownDocument(docRef);
        if (versionHash == bytes32(0)) revert EmptyVersionHash();
        if (_versionHashKnown[versionHash]) revert VersionHashAlreadyUsed(versionHash);

        bytes32 superseded;
        if (_versions[docRef].length > 0) {
            superseded = _versions[docRef][doc.currentIndex].versionHash;
        }

        _versions[docRef].push(
            Version({
                versionHash: versionHash,
                uriHash: uriHash,
                anchoredAt: uint64(block.timestamp),
                approvedAt: approvedAt
            })
        );

        index = uint32(_versions[docRef].length - 1);

        doc.currentIndex = index;
        _versionHashKnown[versionHash] = true;
        _versionHashToDocRef[versionHash] = docRef;

        emit VersionAnchored(docRef, versionHash, superseded, index, uri, approvedAt, retentionUntil);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS — the fail-closed surface `CovenantRegistry` depends on
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice The `IDocumentAnchor.documentStatus` read `SubscriptionEscrow` codes against.
    ///         Keyed by version hash because the escrow is handed an artefact hash, not a slot
    ///         name.
    /// @dev    ⚠️ `exists` IS NOT `isCurrent`. This answers "do you know this hash, and what
    ///         approval is on it" — it returns true for SUPERSEDED versions too, because the
    ///         escrow's Art 23 window opener is asking about a supplement that has since been
    ///         supplemented again. Callers that need currency must call `isCurrent`.
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

        return vs[doc.currentIndex].versionHash;
    }

    /// @notice ⚠️ THE FAIL-CLOSED READ. Returns false the moment the hash is superseded, which
    ///         is what makes a revision invalidate every outstanding acknowledgement bound to
    ///         the old version with no sweep and no configuration.
    /// @dev    This check is now currency ONLY. It used to also return false on an overdue
    ///         PRIIPs Art 10 review; that limb was withdrawn on 2026-09-22 — see the contract
    ///         header for why, and `DEPLOYMENT-DEFAULTS.md` for the off-chain control that
    ///         replaced it. An un-reviewed KID passes this read.
    function isCurrent(bytes32 docRef, bytes32 versionHash) external view returns (bool) {
        Document storage doc = _documents[docRef];
        if (!doc.exists || versionHash == bytes32(0)) return false;

        Version[] storage vs = _versions[docRef];
        if (vs.length == 0) return false;

        return vs[doc.currentIndex].versionHash == versionHash;
    }

    function versionCount(bytes32 docRef) external view returns (uint256) {
        return _versions[docRef].length;
    }

    function versionAt(bytes32 docRef, uint256 index) external view returns (Version memory) {
        return _versions[docRef][index];
    }

}
