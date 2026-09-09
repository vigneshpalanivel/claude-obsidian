// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IErasable, IIdentityGate} from "./Interfaces.sol";

/// @title IPdmrRegister
/// @notice The read surface every MAR Art 19 module consumes: given a wallet, is this person
///         a manager (PDMR) or one of their closely associated persons (PCA), and whose
///         obligation does the wallet sit under.
interface IPdmrRegister {
    enum Role {
        None,
        Pdmr, // MAR Art 3(1)(25) — person discharging managerial responsibilities
        Pca // MAR Art 3(1)(26) — person closely associated with a PDMR
    }

    /// @return The wallet's current role, or `None` where it was never declared or has since
    ///         been revoked. A revoked wallet keeps its record for the retention period but
    ///         stops being flagged — a director who leaves is no longer a director.
    function roleOf(address wallet) external view returns (Role);

    /// @notice The natural person the wallet belongs to. This is the aggregation key for the
    ///         Art 19(8)/(9) threshold, which is per PERSON across all their wallets.
    function personOf(address wallet) external view returns (bytes32 personId);

    /// @notice For a PCA, the PDMR they are associated with. For a PDMR, their own id.
    function principalOf(address wallet) external view returns (bytes32 pdmrId);

    function isFlagged(address wallet) external view returns (bool);
}

/// @title PdmrRegister (illustrative sample — not production code)
/// @notice The MAR Art 19(5) declared register, mapped to wallet addresses. It is the single
///         source of the flag set that `PdmrClosedPeriodFreeze` blocks on, and the wallet →
///         person join the off-chain indexer needs to aggregate the Art 19(8)/(9) threshold.
///         Nothing else in the stack knows who a manager is.
/// @dev    ⚠️ THE ART 19(8)/(9) AGGREGATION IS DELIBERATELY NOT ON-CHAIN. The Art 19(8)
///         threshold is €20,000 a calendar year, "calculated by adding without netting", and
///         Art 19(9) lets a COMPETENT AUTHORITY move it EITHER WAY — up to €50,000 or down to
///         €10,000. ⚠️ **Three values, not two, and it is not a Member-State election.** An
///         indexer hard-coded to €20k-or-€50k under-reports every manager in a jurisdiction
///         whose authority took the lower option, and under-reporting is the direction that
///         gets filed against the issuer. Whatever consumes this register's join must treat
///         the threshold as a per-jurisdiction parameter over those three values. It gates
///         nothing — crossing the threshold makes a transaction NOTIFIABLE, never unlawful —
///         so a contract computing it can only emit an alert an indexer could raise anyway,
///         while doing the job worse: it needs a price oracle to estimate a euro consideration
///         the fiat settlement leg already knows exactly, it cannot compute BUSINESS days for
///         the Art 19(1) (PDMR notifies) and Art 19(3) (issuer publishes) deadlines, and its
///         running total is immutable, so one bad oracle reading corrupts the year with no
///         correction path. The indexer recomputes. See the
///         requirements it must carry, listed in §6 of the design doc.
/// @dev    ⚠️ THIS REGISTER IS DECLARED, NOT DERIVED — AND THAT IS THE WHOLE DIFFICULTY.
///         A PDMR you can find in your own onboarding data. A PCA you cannot: Art 3(1)(26)
///         reaches a spouse or equivalent partner, dependent children, relatives sharing the
///         household for ≥1 year, and legal persons/trusts/partnerships managed by or set up
///         for the benefit of the PDMR. None of those people need have any relationship with
///         the platform at all, and none of their wallets are discoverable from your KYC
///         records or from on-chain analysis. Art 19(5) is what makes the register exist:
///         the issuer notifies PDMRs in writing, PDMRs notify their own PCAs, and the issuer
///         keeps the list. This contract is the wallet-address mirror of that legal artefact.
///         There is no oracle for it and there never will be.
/// @dev    ⚠️ A DECLARATION IS EFFECTIVE ON ENTRY, NOT ON SELF-CONFIRMATION. `confirmWallet`
///         exists so the holder proves key control and the issuer holds evidence, but the
///         freeze applies from `declareWallet`. Gating the flag on confirmation would hand
///         every PCA a trivial opt-out: never confirm, never get frozen. Fail closed.
/// @dev    GDPR: `personId` is a salted hash held against the off-chain register, exactly as
///         `IdentityRegistry` treats the national client identifier. Names, relationships and
///         the nature of the association are Art 9-adjacent personal data and never go
///         on-chain — an address is pseudonymous, a stored family relationship is not.
/// @dev    ⚠️ `personId` MUST MATCH WHAT `IdentityRegistry` HOLDS FOR THE WALLET, where a
///         record exists, and `declareWallet` enforces it. One name for one key, suite-wide:
///         the value is called `personId` in every contract and document, and there is no
///         second name for it. Two person namespaces were running in parallel —
///         this register's `personOf` and `IdentityRegistry`'s `personIdOf` — with nothing
///         tying them together, so the same human could be one person to the freeze path and a
///         different person to admission and the DEA limits. The failure is quiet and it runs in
///         the direction that matters: a manager who is also an investor gets two identities,
///         and the Art 19(8)/(9) aggregation the whole register exists to support is assembled
///         across the wrong set of wallets.
///         **An unregistered wallet is still declarable and that is deliberate** — Art 3(1)(26)
///         reaches spouses, dependent children and family trusts who need have no relationship
///         with the platform, so requiring a KYC record before a PCA can be declared would make
///         the register unable to hold the very people it was written for. Those entries are
///         marked `identityAnchored == false` rather than rejected, so a reconciliation can see
///         which `personId`s have no counterpart and which merely have not been checked.
contract PdmrRegister is IPdmrRegister, IErasable {
    // ─────────────────────────── roles ────────────────────────────────────────

    /// @dev The issuer's company secretary / compliance function — whoever runs the Art 19(5)
    ///      notification cycle off-chain. Deliberately not the same key as the venue operator
    ///      or the token admin: this register decides who is frozen, so the party that
    ///      benefits from a freeze not applying must not be the party that maintains it.
    address public immutable registrar;

    /// @dev The wiring role. Re-points `identity`; nothing else. Split from the registrar on
    ///      2026-09-08: the registrar chooses `personId` per wallet, and the identity reference
    ///      is what checks that choice against the KYC record — the party being checked should
    ///      not hold the key that picks the checker. Two-step transfer, as every other
    ///      governance key in the suite.
    address public governance;
    address public pendingGovernance;

    /// @dev Interface-typed and settable, per the standing rule — never `immutable`, never
    ///      unset. Held under `onlyGovernance`.
    IIdentityGate public identity;

    /// @notice The `PersonErasure` coordinator, permitted to call `erasePerson` and nothing else.
    /// @dev    A fourth key alongside registrar / issuer / governance, and separate from all
    ///         three for the same reason they are separate from each other: the desk answering
    ///         a data subject must not be able to declare, revoke or attest a director's wallet.
    ///         Zero disables the path, which is the correct setting until a coordinator is
    ///         deployed. See the key-separation note above.
    address public erasureCoordinator;

    // ─────────────────────────── key separation ───────────────────────────────
    //
    // ⚠️ REGISTRAR ≠ ISSUER ≠ GOVERNANCE IS AN OPERATING RULE, NOT A `require`. This contract
    //    cannot see `PdmrClosedPeriodFreeze`, so it cannot know that `revokeWallet` is being
    //    called inside a live window — and a revocation unflags the wallet, which unfreezes
    //    it, immediately. The control against a mid-window exit is therefore (i) the
    //    `reasonHash` every revocation must carry, so the exit is evidenced, and (ii) the
    //    registrar key NOT being the issuer key or any key a director controls. Recorded in
    //    `DEPLOYMENT-DEFAULTS.md` §"2026-09-08 fixes — economics/MAR layer".

    // ─────────────────────────── retention ────────────────────────────────────

    /// @dev MAR Art 18(5) is the ≥5-year rule for insider lists; the Art 19 register is
    ///      retained on the same footing because it is the evidence that a freeze was or was
    ///      not owed on a given date. Records are revoked, then purged — never deleted live.
    uint64 public constant RETENTION_PERIOD = 5 * 365 days;

    /// @dev Nothing in MAR fixes a re-attestation cadence. The reason to have one is that a
    ///      PCA set decays silently — people marry, separate, and set up trusts without
    ///      telling the issuer, and a register nobody refreshes is a register that quietly
    ///      stops matching reality while continuing to look authoritative.
    uint64 public reattestationPeriod = 365 days;

    // ─────────────────────────── records ──────────────────────────────────────

    struct WalletRecord {
        Role role;
        bool selfConfirmed; // holder proved key control — evidence, not a precondition
        bytes32 personId; // salted hash — the Art 19(8)/(9) aggregation key
        bytes32 pdmrId; // for a PCA, their principal; for a PDMR, == personId
        uint64 declaredAt;
        uint64 revokedAt; // 0 while live
        bytes32 declarationHash; // hash of the signed Art 19(5) declaration this came from
        bool identityAnchored; // personId was checked against a live IdentityRegistry record
    }

    mapping(address => WalletRecord) private _records;

    /// @dev Enumeration for the off-chain register export and for reconciling the Art 19(8)/(9)
    ///      aggregate — the indexer reads this once to learn which wallets roll up to one
    ///      person, then aggregates from `Transfer` events. Never iterated on a transfer path.
    mapping(bytes32 => address[]) private _walletsOfPerson;

    mapping(bytes32 => uint64) public lastAttestedAt;

    // ─────────────────────────── events ───────────────────────────────────────

    // ⚠️ NO `personId`, NO `pdmrId`, NO `role` IN ANY LOG. The GDPR note at the top of this
    //    file already says a stored family relationship is not pseudonymous — and then the
    //    old `WalletDeclared` put `wallet + personId + pdmrId + role` in an indexed log, which
    //    IS that relationship: "this address belongs to person X, who is the spouse or child
    //    (PCA) of manager Y", permanently, in the one store `purgeWallet` cannot reach. MAR
    //    Art 19(3) does not license it. Art 19 publishes a PDMR's or PCA's *transactions above
    //    threshold*, through the issuer, ad hoc; it does not publish a standing map of every
    //    wallet every family member holds — a PCA who never trades above threshold is never
    //    named under Art 19 at all, and was being named here on day one.
    //    `declarationHash` is the join key instead: an opaque digest of the signed Art 19(5)
    //    declaration, meaningful only to whoever holds the declaration. Who and what is a
    //    storage read — `recordOf()`, `personOf()`, `principalOf()` — and storage is what
    //    revocation and purge can empty.
    event WalletDeclared(address indexed wallet, bytes32 declarationHash);
    event WalletConfirmed(address indexed wallet);
    /// @dev `reasonHash`: the opaque digest of the registrar's record of WHY the wallet left
    ///      the register — resignation letter, divorce decree, trust wound up. Never the
    ///      reason itself. It is what lets a later investigation of a revocation that landed
    ///      inside a closed period distinguish a director who left from a director who
    ///      wanted to trade.
    event WalletRevoked(address indexed wallet, uint64 revokedAt, bytes32 reasonHash);
    event WalletPurged(address indexed wallet);
    event ErasureCoordinatorSet(address indexed previous, address indexed current);
    /// @dev Fires per wallet from `purgePerson` too; the person key never appears.
    event PersonAttested(bytes32 indexed declarationHash, uint64 attestedAt);
    event ReattestationPeriodSet(uint64 seconds_);
    event DependencySet(bytes32 indexed what, address impl);
    event GovernanceTransferStarted(address indexed from, address indexed to);
    event GovernanceTransferred(address indexed from, address indexed to);

    /// @dev Fires when a live person's declaration has aged past `reattestationPeriod`. An
    ///      alert, not a block: a stale declaration does not mean the person stopped being a
    ///      PDMR, and unfreezing them because paperwork lapsed is the wrong failure direction.
    ///      Keyed by wallet, not person — see `flagStaleDeclaration`.
    event DeclarationStale(address indexed wallet, uint64 lastAttestedAt);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotRegistrar();
    error NotErasureCoordinator();
    error NotGovernance();
    error NotPendingGovernance();
    error ReasonRequired();
    error NotTheDeclaredWallet();
    error RoleRequired();
    error PrincipalMismatch(bytes32 personId, bytes32 pdmrId);
    error AlreadyDeclared(address wallet);
    error NotDeclared(address wallet);
    error AlreadyRevoked(address wallet);
    error RetentionNotExpired(uint64 purgeableAt);
    error ZeroAddress();
    error PersonIdNotIdentityRecord(address wallet, bytes32 declared, bytes32 identityRecord);

    modifier onlyRegistrar() {
        if (msg.sender != registrar) revert NotRegistrar();
        _;
    }

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address registrar_, address identity_, address governance_) {
        if (registrar_ == address(0) || identity_ == address(0) || governance_ == address(0)) revert ZeroAddress();
        registrar = registrar_;
        governance = governance_;
        identity = IIdentityGate(identity_);
        emit DependencySet("identity", identity_);
    }

    /// @notice Re-point the identity resolver. Swap, never unset — an unset reference cannot
    ///         distinguish "nobody wired it" from "no identity layer here", and every wallet
    ///         would then read as unanchored, which turns the check below off silently.
    function setIdentity(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        identity = IIdentityGate(impl);
        emit DependencySet("identity", impl);
    }

    function transferGovernance(address to) external onlyGovernance {
        if (to == address(0)) revert ZeroAddress();
        pendingGovernance = to;
        emit GovernanceTransferStarted(governance, to);
    }

    function acceptGovernance() external {
        if (msg.sender != pendingGovernance) revert NotPendingGovernance();
        emit GovernanceTransferred(governance, msg.sender);
        governance = msg.sender;
        pendingGovernance = address(0);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // DECLARATION — the only way a wallet enters the flag set.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param pdmrId  For `Role.Pdmr` this must equal `personId`. For `Role.Pca` it is the
    ///                manager the association runs through — a PCA is only a PCA relative to
    ///                somebody, and Art 19(3) publication is filed under that manager's name.
    /// @param declarationHash  Hash of the signed Art 19(5) declaration this entry came from.
    ///                Anchoring it is what makes the register evidential rather than merely
    ///                operational: it shows the wallet was declared by the person, on a date,
    ///                against a document you still hold.
    /// @param personId  Where `wallet` is a registered investor, this MUST equal that record's
    ///                `personId` — see the namespace note on the contract. Where it is not,
    ///                any id is accepted and the entry is flagged unanchored.
    /// @dev    ⚠️ The equality check only reaches the wallet being declared. A PCA's `pdmrId`
    ///         names their manager, whose wallet is not an argument here, so that limb is
    ///         anchored when the manager's OWN wallet is declared and not before. Declaring the
    ///         PDMR first is therefore the correct order, not merely the tidy one.
    function declareWallet(address wallet, bytes32 personId, bytes32 pdmrId, Role role, bytes32 declarationHash)
        external
        onlyRegistrar
    {
        if (role == Role.None) revert RoleRequired();
        if (role == Role.Pdmr && pdmrId != personId) revert PrincipalMismatch(personId, pdmrId);

        WalletRecord storage r = _records[wallet];
        if (r.declaredAt != 0 && r.revokedAt == 0) revert AlreadyDeclared(wallet);

        // One person, one id. A registered investor's person key already exists; a second one
        // minted here would split their wallets across two aggregation sets.
        (bytes32 anchoredId, bool registered) = identity.personIdOf(wallet);
        bool anchored = registered && anchoredId != bytes32(0);
        if (anchored && personId != anchoredId) {
            revert PersonIdNotIdentityRecord(wallet, personId, anchoredId);
        }
        r.identityAnchored = anchored;

        // A wallet re-declared after revocation (retention not yet run) is still in its old
        // person's list. Move it rather than duplicate it, so purge's swap-and-pop removes
        // every trace in one pass whichever id it ends up under. Must run before `r.personId`
        // is overwritten below.
        if (r.declaredAt != 0 && r.personId != personId) _removeFromWalletsOfPerson(r.personId, wallet);
        if (!_inWalletsOfPerson(personId, wallet)) _walletsOfPerson[personId].push(wallet);

        r.role = role;
        r.selfConfirmed = false;
        r.personId = personId;
        r.pdmrId = pdmrId;
        r.declaredAt = uint64(block.timestamp);
        r.revokedAt = 0;
        r.declarationHash = declarationHash;

        lastAttestedAt[personId] = uint64(block.timestamp);

        emit WalletDeclared(wallet, declarationHash);
        emit PersonAttested(declarationHash, uint64(block.timestamp));
    }

    /// @notice Called by the declared wallet itself to prove key control. Evidence only — see
    ///         the contract-level note. The wallet is already frozen-eligible without it.
    function confirmWallet() external {
        WalletRecord storage r = _records[msg.sender];
        if (r.declaredAt == 0 || r.revokedAt != 0) revert NotTheDeclaredWallet();
        r.selfConfirmed = true;
        emit WalletConfirmed(msg.sender);
    }

    /// @notice Periodic re-confirmation that the person's declared PCA set is still current.
    ///         Refreshes the clock behind `isDeclarationStale`.
    function attestPerson(bytes32 personId, bytes32 declarationHash) external onlyRegistrar {
        lastAttestedAt[personId] = uint64(block.timestamp);
        emit PersonAttested(declarationHash, uint64(block.timestamp));
    }

    function setReattestationPeriod(uint64 seconds_) external onlyRegistrar {
        reattestationPeriod = seconds_;
        emit ReattestationPeriodSet(seconds_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // REVOCATION AND PURGE — a two-step, because the record is evidence for
    // five years after the person stops being flagged.
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Takes the wallet out of the flag set, immediately and unconditionally.
    /// @dev    ⚠️ UNCONDITIONAL INCLUDES "DURING A CLOSED PERIOD". This register cannot see the
    ///         freeze, so it cannot refuse a revocation that lands mid-window — and it should
    ///         not: a director who genuinely resigned mid-window is genuinely no longer bound.
    ///         What it CAN do is refuse an unevidenced one. `reasonHash` is mandatory; the
    ///         evidence it points at is the registrar's, and the registrar's key being
    ///         separate from the issuer's and from every director's is the operating rule
    ///         that makes the evidence worth anything (see the key-separation note above).
    function revokeWallet(address wallet, bytes32 reasonHash) external onlyRegistrar {
        if (reasonHash == bytes32(0)) revert ReasonRequired();
        WalletRecord storage r = _records[wallet];
        if (r.declaredAt == 0) revert NotDeclared(wallet);
        if (r.revokedAt != 0) revert AlreadyRevoked(wallet);

        r.revokedAt = uint64(block.timestamp);
        emit WalletRevoked(wallet, r.revokedAt, reasonHash);
    }

    /// @notice Erases the record once the retention period has run.
    /// @dev    ⚠️ ERASURE MEANS EVERY INDEX, NOT JUST THE RECORD. Until 2026-09-08 this deleted
    ///         `_records[wallet]` and left the wallet in `_walletsOfPerson[personId]` and the
    ///         person's `lastAttestedAt` in place — so `walletsOfPerson` kept answering, for a
    ///         person whose record had supposedly been erased, with the very wallet set that
    ///         `purge` exists to forget. Now: swap-and-pop out of the person's wallet list, and
    ///         when that list is empty the person's attestation clock goes too — the person is
    ///         gone from this register. While other wallets of the same person are still live
    ///         or in retention, the clock stays, because it is theirs as well.
    function purgeWallet(address wallet) external onlyRegistrar {
        _purge(wallet);
    }

    /// @notice Erases every wallet of one person. Reverts if any is still live or in
    ///         retention — a person is purged whole or not at all.
    /// @dev    The argument is a `personId` in calldata, which archive nodes keep. Acceptable
    ///         here and not in `flagStaleDeclaration` because this is a registrar-only call
    ///         made once at the end of retention, not an open keeper hook — and the id is a
    ///         salted hash the registrar already put in calldata at `declareWallet`.
    function purgePerson(bytes32 personId) external onlyRegistrar {
        address[] storage wallets = _walletsOfPerson[personId];
        uint256 n = wallets.length;
        if (n == 0) revert NotDeclared(address(0));
        // Backwards, because `_purge` pops from this array.
        for (uint256 i = n; i > 0; i--) {
            _purge(wallets[i - 1]);
        }
    }

    /// @notice Point at the `PersonErasure` coordinator, or unset it with `address(0)`.
    function setErasureCoordinator(address coordinator) external onlyGovernance {
        address previous = erasureCoordinator;
        erasureCoordinator = coordinator;
        emit ErasureCoordinatorSet(previous, coordinator);
    }

    /// @notice GDPR Art 17 leg. Same erasure as `purgePerson`, reached by the coordinator.
    /// @dev    ⚠️ MAR ART 19 SETS NO RETENTION PERIOD — VERIFIED AGAINST THE CONSOLIDATED TEXT,
    ///         BECAUSE THE OBVIOUS ASSUMPTION IS WRONG. MAR states retention where it means it:
    ///         Art 11(8) market soundings, Art 17(1) inside information on the website, and
    ///         Art 18(5) insider lists are each five years. Article 19 contains no retention or
    ///         record-keeping provision at all. `RETENTION_PERIOD` here is therefore the
    ///         OPERATOR'S policy, not a MAR requirement, and an operator running a different one
    ///         should change the constant rather than assume five years is mandated.
    /// @dev    What DOES constrain erasure is Art 19(5): the issuer "shall draw up a list of all
    ///         persons discharging managerial responsibilities and persons closely associated
    ///         with them". That list has to be complete while the person is a PDMR, so `_purge`
    ///         refuses any wallet that has not been revoked — the erasure right does not reach a
    ///         record a live regulatory obligation requires the issuer to hold (Art 17(3)(b)).
    /// @dev    Returns quietly for a person with no PDMR record, which is almost everyone. Only
    ///         a partial record — declared, not revoked, or revoked and still inside retention —
    ///         reverts, and it should: that is a genuine conflict for the DPO to answer, not a
    ///         contract to route around.
    /// @dev    `wallets` from the identity registry is deliberately IGNORED in favour of this
    ///         register's own `_walletsOfPerson`. The two can legitimately differ — a director
    ///         may declare a wallet here that was never bound there — and erasing only the
    ///         intersection would leave this register's own extras behind.
    function erasePerson(bytes32 personId, address[] calldata) external {
        if (msg.sender != erasureCoordinator || erasureCoordinator == address(0)) revert NotErasureCoordinator();

        address[] storage wallets = _walletsOfPerson[personId];
        uint256 n = wallets.length;
        if (n == 0) return;
        // Backwards, because `_purge` pops from this array.
        for (uint256 i = n; i > 0; i--) {
            _purge(wallets[i - 1]);
        }
    }

    function _purge(address wallet) private {
        WalletRecord storage r = _records[wallet];
        if (r.declaredAt == 0) revert NotDeclared(wallet);
        if (r.revokedAt == 0) revert RetentionNotExpired(type(uint64).max);

        uint64 purgeableAt = r.revokedAt + RETENTION_PERIOD;
        if (block.timestamp < purgeableAt) revert RetentionNotExpired(purgeableAt);

        bytes32 personId = r.personId;
        _removeFromWalletsOfPerson(personId, wallet);
        if (_walletsOfPerson[personId].length == 0) {
            delete _walletsOfPerson[personId];
            delete lastAttestedAt[personId];
        }

        delete _records[wallet];
        emit WalletPurged(wallet);
    }

    function _removeFromWalletsOfPerson(bytes32 personId, address wallet) private {
        address[] storage wallets = _walletsOfPerson[personId];
        uint256 n = wallets.length;
        for (uint256 i = 0; i < n; i++) {
            if (wallets[i] == wallet) {
                wallets[i] = wallets[n - 1];
                wallets.pop();
                return;
            }
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READ SURFACE
    // ═══════════════════════════════════════════════════════════════════════

    function roleOf(address wallet) public view returns (Role) {
        WalletRecord storage r = _records[wallet];
        if (r.declaredAt == 0 || r.revokedAt != 0) return Role.None;
        return r.role;
    }

    /// @dev Where `isIdentityAnchored(wallet)` is true this returns the same value as
    ///      `IIdentityGate.personIdOf(wallet)`. That equality is the point of the check in
    ///      `declareWallet`: it is what lets an Art 19(8)/(9) aggregation join this register to the
    ///      admission and DEA records without a mapping table nobody maintains.
    function personOf(address wallet) external view returns (bytes32) {
        return _records[wallet].personId;
    }

    /// @notice Whether this wallet's `personId` was verified against a live identity record at
    ///         declaration. False means the wallet had no KYC record — the ordinary case for a
    ///         PCA — so the id is this register's own and reconciles to nothing else.
    /// @dev    Answers at declaration time and is not refreshed. A PCA who later onboards as an
    ///         investor stays unanchored here, and the two ids diverge from that point. Closing
    ///         that is an operational duty on the registrar — re-declare the wallet — not
    ///         something this contract can detect, because nothing calls it when a KYC record
    ///         is created.
    function isIdentityAnchored(address wallet) external view returns (bool) {
        return _records[wallet].identityAnchored;
    }

    function principalOf(address wallet) external view returns (bytes32) {
        return _records[wallet].pdmrId;
    }

    function isFlagged(address wallet) external view returns (bool) {
        return roleOf(wallet) != Role.None;
    }

    function recordOf(address wallet) external view returns (WalletRecord memory) {
        return _records[wallet];
    }

    function walletsOfPerson(bytes32 personId) external view returns (address[] memory) {
        return _walletsOfPerson[personId];
    }

    function _inWalletsOfPerson(bytes32 personId, address wallet) private view returns (bool) {
        address[] storage wallets = _walletsOfPerson[personId];
        for (uint256 i = 0; i < wallets.length; i++) {
            if (wallets[i] == wallet) return true;
        }
        return false;
    }

    function isDeclarationStale(bytes32 personId) public view returns (bool) {
        uint64 last = lastAttestedAt[personId];
        if (last == 0) return true;
        return block.timestamp > last + reattestationPeriod;
    }

    /// @notice Non-view twin of `isDeclarationStale` so a keeper can emit the alert. Kept
    ///         separate because the freeze path must stay `view` — surveillance observes,
    ///         it does not get to write state on somebody else's transfer.
    /// @dev    ⚠️ TAKES A WALLET, NOT A `personId` — and the change is not cosmetic. This is
    ///         an open, unguarded function, so its argument is calldata anyone submits and
    ///         every archive node keeps. With `personId` as the argument, the fix to the event
    ///         above would only have moved the person key from the log into the transaction —
    ///         which is worse, not better, because `delete` reaches neither. Any one of the
    ///         person's declared wallets identifies them to the keeper; the key is resolved
    ///         in storage and never leaves it.
    function flagStaleDeclaration(address wallet) external {
        WalletRecord storage r = _records[wallet];
        if (r.declaredAt == 0 || r.revokedAt != 0) revert NotTheDeclaredWallet();
        if (isDeclarationStale(r.personId)) {
            emit DeclarationStale(wallet, lastAttestedAt[r.personId]);
        }
    }
}
