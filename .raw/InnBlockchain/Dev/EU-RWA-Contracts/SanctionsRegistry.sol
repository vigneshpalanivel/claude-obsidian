// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IIdentityGate, ISanctionsCheck} from "./Interfaces.sol";

/// @title SanctionsRegistry (illustrative sample — not production code)
/// @notice The platform-wide, person-scoped block store. One instance across every asset the
///         operator tokenizes — the same instancing as `IdentityRegistry`, and forced by the
///         same reasoning: a listing is against a *person*, not against a product.
/// @dev    ⚠️ WHY THIS IS NOT A CLAIM ON `IdentityRegistry`. Four reasons, and the last one is
///         the one that is usually missed:
///
///         (1) SCOPE. `IdentityRegistry` is one-per-platform; `SecurityToken`'s own freeze is
///             one-per-asset. Put the flag on the token and a single list hit becomes N
///             transactions with a window in between, during which the listed person is frozen
///             on asset A and exiting through asset B.
///
///         (2) SCOPE OF THE OBLIGATION. Every other compliance module in this suite answers to
///             a regime a given client may or may not owe, and a client who does not owe it
///             empties that part of the rule set. Targeted financial sanctions are not like
///             that: they bind irrespective of whether the entity is an obliged entity under
///             the money-laundering regime at all. Bundle this into the AML claim set and the
///             unlicensed pure issuer who *correctly* drops the AML modules silently drops
///             sanctions with them. Separated here so that dropping one cannot drop the other.
///
///             ⚠️ THE CODE DOES NOT ENFORCE THAT — DELIBERATELY, AND THIS IS THE ONE PLACE IT
///             IS RECORDED. `SanctionsGate` is an ordinary module: governance can remove it
///             exactly as it would remove an ELTIF module. A hard non-removable flag was
///             considered and rejected, because replacing this gate — a fix, a re-point, a new
///             store — goes through `removeModule`, and a flag that blocks removal blocks the
///             upgrade path with it. The control is instead a DEPLOYMENT DEFAULT: this gate is
///             in the baseline module set every deployment wires, for every lane, and removing
///             it is an explicit act with a `ModuleRemoved` event to monitor. See
///             `DEPLOYMENT-DEFAULTS.md`.
///
///             Note also that a routine update never needs removal at all: `setSanctions` on
///             the gate re-points the store, and `setIdentity` here re-points the resolver.
///             Removal is for retiring the control, which is what should be conspicuous.
///
///         (3) LIFECYCLE. A claim is revoked by its issuer and carries a refresh cadence. A
///             listing is list-driven, instant on the EXISTING base, and never expires — only
///             a delisting clears it. Modelled as "absence of a sanctions-clear claim", a list
///             update means revoking N claims, which is the unbounded sweep the covenant design
///             already rules out. Here the sweep stays off-chain and only its completion is
///             anchored.
///
///         (4) OBSERVABILITY — the tipping-off argument, and the decisive one. Public storage
///             is readable by anyone willing to simulate. If a listing lives in the token's
///             freeze slot, a lapsed refresh in claim expiry, and a suspicion block somewhere
///             third, then a single generic revert code is cosmetic: an observer reads the
///             three slots and knows which class fired. ONE STORE, ONE FLAG makes the classes
///             indistinguishable by construction rather than by developer discipline.
///
/// @dev    ⚠️ THIS STORE HOLDS THE WHOLE OPAQUE BLOCK CLASS, NOT ONLY SANCTIONS. A listing, a
///         suspicion block, and a lapsed-diligence block all set the same flag and emit the
///         same event shape. `caseRef` is mandatory and opaque for every entry precisely so
///         that entries cannot be told apart by shape. Which class an entry belongs to lives in
///         the off-chain case file the FIU reads, and nowhere else.
/// @dev    ⚠️ WHAT THIS CONTRACT DOES NOT SOLVE — stated rather than papered over. The venue
///         lane is not authorisable on a public L1 and the issuer lane does not need a
///         consortium chain, so an operator running both lands on TWO chains, and "one instance
///         per platform" silently becomes two. A listing written here does not reach the other
///         deployment, and cross-chain propagation is not atomic. `listVersion` and
///         `sweptToVersion` exist so the lag is at least *measurable* per chain; closing it is
///         an operational commitment with a stated worst-case, not something a contract can do.
contract SanctionsRegistry is ISanctionsCheck {
    // ═══════════════════════════════════════════════════════════════════════
    // THE ENTRY — one shape for every class of person-scoped block
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev No class field, deliberately. See the observability note above.
    struct Entry {
        bool active;
        uint64 since;
        bytes32 caseRef; // opaque digest of the off-chain case file; never a reason
    }

    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;

    /// @notice Writes blocks off the back of a screening run. Separate from `governance` for
    ///         the same reason `IdentityRegistry` separates the registrar: screening is a daily
    ///         operational function and upgrade authority is not.
    mapping(address => bool) public isScreeningOperator;

    // ─────────────────────────── dependencies ─────────────────────────────────

    /// @notice Resolves a wallet to the investor record it belongs to, so that blocking the
    ///         PERSON blocks every wallet bound to them rather than the one that was screened.
    /// @dev    Interface-typed and held behind a governance setter, never `immutable` and never
    ///         unset — the standing rule for every inter-contract reference in this suite.
    IIdentityGate public identity;

    // ─────────────────────────── state ────────────────────────────────────────

    /// @notice Person-scoped blocks, keyed by the off-chain investor-record pointer. This is
    ///         the primary store: a listing follows the person across every wallet they hold.
    mapping(bytes32 => Entry) private _blockedRecords;

    /// @notice Wallet-scoped blocks, for addresses with no investor record — an unhosted
    ///         counterparty, or an address flagged by chain analytics that was never onboarded.
    /// @dev    Both stores are consulted. Neither is a fallback for the other: a person can be
    ///         listed while a specific address is separately flagged, and clearing one must not
    ///         clear the other.
    mapping(address => Entry) private _blockedWallets;

    /// @notice Destinations a blocked holding may be moved TO despite the sender being blocked.
    /// @dev    ⚠️ THIS EXISTS BECAUSE `SecurityToken.forcedTransfer` RUNS THE C1 HOOK. Without
    ///         a carve-out, blocking a wallet also blocks the seizure or transfer-to-frozen-
    ///         account that the freezing order itself directs — the control would prevent the
    ///         operator from complying with the very order that triggered it. Governance-only,
    ///         `orderRef` recorded, and it relieves the SENDER limb only: a blocked party can
    ///         never be a recipient, so this cannot be turned into an exit route.
    mapping(address => bool) public isSeizureDestination;

    // ─────────────────────────── sweep anchoring ──────────────────────────────
    //
    // The obligation is to re-screen the WHOLE existing base on every list update, not just new
    // joiners. That sweep is off-chain and unbounded; what belongs on-chain is evidence that it
    // ran and how far behind it is.

    uint64 public listVersion;
    uint64 public sweptToVersion;
    uint64 public sweptAt;

    /// @notice How long the sweep may lag the current list before `screeningIsStale()` trips.
    uint32 public maxSweepLag;

    // ─────────────────────────── events ───────────────────────────────────────
    //
    // ⚠️ NO EVENT HERE CARRIES A REASON, A CLASS, OR A LIST NAME. `SecurityToken` already
    //    applies this rule at the event layer — freeze and forced transfer carry a `reasonHash`
    //    and never a reason. A reason code in an indexed topic is a disclosure to everyone.

    event RecordBlocked(bytes32 indexed recordPointer, bytes32 caseRef, uint64 at);
    event RecordUnblocked(bytes32 indexed recordPointer, bytes32 caseRef, uint64 at);
    event WalletBlocked(address indexed wallet, bytes32 caseRef, uint64 at);
    event WalletUnblocked(address indexed wallet, bytes32 caseRef, uint64 at);

    event ScreeningOperatorSet(address indexed operator, bool allowed);
    event SeizureDestinationSet(address indexed destination, bool allowed, bytes32 orderRef);
    event DependencySet(bytes32 indexed what, address impl);
    event MaxSweepLagSet(uint32 seconds_);

    event ListVersionAdvanced(uint64 indexed version, bytes32 sourceHash, uint64 at);
    event SweepCompleted(uint64 indexed version, uint256 recordsScreened, uint64 at);

    // ─────────────────────────── errors ───────────────────────────────────────

    /// @notice THE ONLY ERROR ON THE TRANSFER PATH. One code for the entire block class —
    ///         listing, suspicion, lapsed diligence. A distinct code for any one of them is the
    ///         tip-off. Informative status goes to the operator off-chain, never to the caller.
    /// @dev    ⚠️ Note it takes no arguments. An address parameter would tell the caller WHICH
    ///         side failed, which on a two-sided check is most of the information back again.
    error TransferNotPermitted();

    // Operational errors — write paths only, never reachable from `checkTransfer`.
    error NotGovernance();
    error NotScreeningOperator();
    error ZeroAddress();
    error CaseRefRequired();
    error AlreadyBlocked();
    error NotBlocked();
    error StaleSweepVersion();
    error ScreeningStale();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyScreeningOperator() {
        if (!isScreeningOperator[msg.sender]) revert NotScreeningOperator();
        _;
    }

    constructor(address governance_, address identity_, uint32 maxSweepLag_) {
        if (governance_ == address(0) || identity_ == address(0)) revert ZeroAddress();
        governance = governance_;
        identity = IIdentityGate(identity_);
        maxSweepLag = maxSweepLag_;
        emit DependencySet("identity", identity_);
        emit MaxSweepLagSet(maxSweepLag_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CONFIGURATION
    // ═══════════════════════════════════════════════════════════════════════

    function setScreeningOperator(address operator, bool allowed) external onlyGovernance {
        if (operator == address(0)) revert ZeroAddress();
        isScreeningOperator[operator] = allowed;
        emit ScreeningOperatorSet(operator, allowed);
    }

    /// @notice Re-point `identity`. Swap, never unset — the operational-resilience regime
    ///         requires this reference stay swappable at the contract layer rather than
    ///         hard-wired, and a nullable one cannot distinguish "not wired" from "not owed".
    function setIdentity(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        identity = IIdentityGate(impl);
        emit DependencySet("identity", impl);
    }

    function setMaxSweepLag(uint32 seconds_) external onlyGovernance {
        maxSweepLag = seconds_;
        emit MaxSweepLagSet(seconds_);
    }

    /// @param orderRef Digest of the freezing order or competent-authority direction this
    ///                 destination is registered under. Governance-only and logged, because an
    ///                 unrecorded seizure destination is indistinguishable from a backdoor.
    function setSeizureDestination(address destination, bool allowed, bytes32 orderRef) external onlyGovernance {
        if (destination == address(0)) revert ZeroAddress();
        if (allowed && orderRef == bytes32(0)) revert CaseRefRequired();
        isSeizureDestination[destination] = allowed;
        emit SeizureDestinationSet(destination, allowed, orderRef);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // BLOCK MAINTENANCE
    //
    // ⚠️ `caseRef` is REQUIRED on every write, including unblocks. A delisting is a decision
    //    with a file behind it exactly as a listing is, and an unblock with no reference is the
    //    write nobody can explain to a supervisor afterwards.
    // ═══════════════════════════════════════════════════════════════════════

    function blockRecord(bytes32 recordPointer, bytes32 caseRef) external onlyScreeningOperator {
        if (recordPointer == bytes32(0)) revert ZeroAddress();
        if (caseRef == bytes32(0)) revert CaseRefRequired();
        Entry storage e = _blockedRecords[recordPointer];
        if (e.active) revert AlreadyBlocked();

        e.active = true;
        e.since = uint64(block.timestamp);
        e.caseRef = caseRef;

        emit RecordBlocked(recordPointer, caseRef, uint64(block.timestamp));
    }

    /// @notice Delisting. Governance rather than the screening operator: adding a block is an
    ///         operational act that fails safe, removing one releases a frozen position and
    ///         does not.
    function unblockRecord(bytes32 recordPointer, bytes32 caseRef) external onlyGovernance {
        if (caseRef == bytes32(0)) revert CaseRefRequired();
        Entry storage e = _blockedRecords[recordPointer];
        if (!e.active) revert NotBlocked();

        delete _blockedRecords[recordPointer];
        emit RecordUnblocked(recordPointer, caseRef, uint64(block.timestamp));
    }

    function blockWallet(address wallet, bytes32 caseRef) external onlyScreeningOperator {
        if (wallet == address(0)) revert ZeroAddress();
        if (caseRef == bytes32(0)) revert CaseRefRequired();
        Entry storage e = _blockedWallets[wallet];
        if (e.active) revert AlreadyBlocked();

        e.active = true;
        e.since = uint64(block.timestamp);
        e.caseRef = caseRef;

        emit WalletBlocked(wallet, caseRef, uint64(block.timestamp));
    }

    function unblockWallet(address wallet, bytes32 caseRef) external onlyGovernance {
        if (caseRef == bytes32(0)) revert CaseRefRequired();
        Entry storage e = _blockedWallets[wallet];
        if (!e.active) revert NotBlocked();

        delete _blockedWallets[wallet];
        emit WalletUnblocked(wallet, caseRef, uint64(block.timestamp));
    }

    // ═══════════════════════════════════════════════════════════════════════
    // LIST VERSIONING AND SWEEP EVIDENCE
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Called when a new consolidated list is ingested. Advancing the version does NOT
    ///         block anything by itself — it opens a lag that `recordSweep` closes.
    function advanceListVersion(bytes32 sourceHash) external onlyScreeningOperator returns (uint64) {
        if (sourceHash == bytes32(0)) revert CaseRefRequired();
        listVersion += 1;
        emit ListVersionAdvanced(listVersion, sourceHash, uint64(block.timestamp));
        return listVersion;
    }

    /// @notice Anchors completion of a full re-screen of the existing base against `version`.
    /// @dev    `recordsScreened` is evidence, not a control — nothing on-chain can verify it.
    ///         It is here because the supervisor asks how many records the sweep covered and an
    ///         unanchored answer is a spreadsheet.
    function recordSweep(uint64 version, uint256 recordsScreened) external onlyScreeningOperator {
        if (version > listVersion || version < sweptToVersion) revert StaleSweepVersion();
        sweptToVersion = version;
        sweptAt = uint64(block.timestamp);
        emit SweepCompleted(version, recordsScreened, uint64(block.timestamp));
    }

    /// @notice True when the sweep has fallen behind the current list beyond the tolerated lag.
    function screeningIsStale() public view returns (bool) {
        if (sweptToVersion >= listVersion) return false;
        if (maxSweepLag == 0) return true;
        return block.timestamp > uint256(sweptAt) + uint256(maxSweepLag);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS AND THE GATE
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Both stores are consulted, person first. `recordPointerOf` is a two-value read
    ///      rather than a struct on purpose — this contract has no business seeing the rest of
    ///      the investor record.
    function isBlocked(address wallet) public view returns (bool) {
        (bytes32 pointer, bool registered) = identity.recordPointerOf(wallet);
        if (registered && pointer != bytes32(0) && _blockedRecords[pointer].active) return true;
        return _blockedWallets[wallet].active;
    }

    /// @notice Single-sided assertion. Reverts with the generic code and nothing else.
    function assertNotBlocked(address wallet) public view {
        if (isBlocked(wallet)) revert TransferNotPermitted();
    }

    /// @notice The composite the gate calls. Both sides, plus the two carve-outs.
    /// @dev    ⚠️ THE RECIPIENT LIMB HAS NO CARVE-OUT AT ALL. A blocked party may never receive
    ///         — not on a mint, not on a seizure, not on a redemption. Every exception in this
    ///         function relieves the SENDER limb only, which is what keeps them from composing
    ///         into a route out.
    /// @dev    ⚠️ STALENESS BLOCKS ENTRY, NOT EXIT — and the asymmetry is deliberate. Freezing
    ///         the whole book because a screening sweep is running late is a self-inflicted
    ///         outage on holders who did nothing, and under the operator's strict liability for
    ///         lost client assets it is an outage the operator owns. Refusing to admit NEW
    ///         positions against an unscreened list costs a delayed subscription. Those are not
    ///         comparable harms, so they do not get the same treatment.
    function assertTransferPermitted(address from, address to) public view {
        // Recipient — unconditional, both limbs.
        if (isBlocked(to)) revert TransferNotPermitted();

        if (from == address(0)) {
            // Mint. Nothing to screen on the sender side; this is the entry point staleness
            // guards, and it is the only path that fails on a late sweep.
            if (screeningIsStale()) revert ScreeningStale();
            return;
        }

        // Sender — relieved only where the destination is a registered seizure account, so that
        // a freezing order can actually be executed against the wallet it names.
        if (isSeizureDestination[to]) return;

        if (isBlocked(from)) revert TransferNotPermitted();
    }

    /// @notice Non-reverting form for user interfaces and off-chain simulation.
    /// @dev    Deliberately NOT used by the gate — a boolean at the hook lets a caller ignore
    ///         the answer.
    function canTransfer(address from, address to) external view returns (bool) {
        try this.assertTransferPermitted(from, to) {
            return true;
        } catch {
            return false;
        }
    }

    /// @notice Entry detail for the operator's own tooling. `caseRef` is an opaque pointer, so
    ///         exposing it discloses nothing — the file it names is where the class lives.
    function entryForRecord(bytes32 recordPointer) external view returns (Entry memory) {
        return _blockedRecords[recordPointer];
    }

    function entryForWallet(address wallet) external view returns (Entry memory) {
        return _blockedWallets[wallet];
    }
}

// ⚠️ `SanctionsGate` — the `IComplianceModule` adapter that makes this store reachable from the
//    C1 hook — lives in `SanctionsGate.sol`. Without it registered on `ModularCompliance`, this
//    contract enforces nothing on a transfer: only a transfer agent remembering to call
//    `assertTransferPermitted` would.
//
//    ⚠️ Note this file departs from the folder's store-plus-gate-in-one-file convention, which
//    `CovenantRegistry.sol`, `HoldingPeriodLock.sol` and `PdmrClosedPeriodFreeze.sol` all still
//    follow. Deliberate, at the operator's direction (2026-09-07). If the folder is ever brought
//    to one-contract-per-file, those three are the remaining work.

