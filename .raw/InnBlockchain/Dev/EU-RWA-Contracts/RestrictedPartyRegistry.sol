// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IIdentityGate, IRestrictedParty} from "./Interfaces.sol";

/// @title RestrictedPartyRegistry (illustrative sample — not production code)
/// @notice The platform-wide, person-scoped store of **every reason a wallet may not move**.
///         One instance across every asset the operator tokenizes — the same instancing as
///         `IdentityRegistry`, and forced by the same reasoning: a restriction is against a
///         *person*, not against a product.
///
/// @dev    ⚠️ NAMING RULE, AND IT IS LOAD-BEARING — READ BEFORE RENAMING ANYTHING HERE.
///         Three different controls in this folder stop value from moving, and they were
///         colliding on the word "hold" and the word "freeze". They are now kept apart by
///         WHAT THEY ACT ON:
///
///           • **This contract — a PARTY.** A person or a wallet, for any reason, indefinitely,
///             until governance lifts it. `RestrictedParty*`.
///           • **`SecurityToken.freezeUnits` — UNITS.** A parcel inside an otherwise live
///             wallet. `freeze*` / `frozenUnits`.
///           • **`HoldingPeriodLock` / `PdmrClosedPeriodFreeze` — a PERIOD.** A date restriction
///             that expires on its own. `Holding*` / `ClosedPeriod*`.
///
///         ⚠️ THE NAME `Freeze` WAS CONSIDERED FOR THIS CONTRACT AND REJECTED. `freezeUnits`
///         already exists one file away and also stops value moving, so an agent told to
///         "freeze the wallet" would reach for `freezeUnits(wallet, fullBalance)` — which
///         compiles, works, and rebuilds the two-store observability leak this contract was
///         consolidated to remove. `Hold` was rejected because it reads as `HoldingPeriodLock`.
///
///         ⚠️ THE NAME MUST ALSO STAY CLASS-NEUTRAL. `SanctionsRegistry` — what this was called
///         until 2026-09-08 — is unusable now that one store carries every reason, because
///         membership of a store named "Sanctions" IS the disclosure, whatever the revert says.
///         The same objection kills `Watchlist`, `Suspicion` and `DeniedParty`.
///
///         In prose below, "a probate hold" and "a lost-key hold" survive as the names of real
///         legal instruments. They are never a name for this contract, its flag, or its gate.
///
/// @dev    ⚠️ ONE STORE FOR ALL RESTRICTIONS, AND THAT IS THE WHOLE DESIGN. A sanctions listing, an
///         AMLR Art 75 suspicion block, a probate hold, a court attachment, a lost-key hold and
///         an operational hold pending investigation ALL set the same flag and emit the same
///         event shape. There is no class field and no reason code anywhere in this contract.
///
///         Two of those reasons must never be disclosed — telling a customer they are under
///         analysis is an individual criminal offence in most Member States. The rest are
///         ordinary and the holder usually knows already. The tempting design is therefore to
///         split them: ordinary restrictions on `IdentityRegistry`, secret ones here.
///
///         **That fails, and it fails for a reason that has nothing to do with error messages.**
///         Contract storage is public. An observer does not need to simulate a transfer or read
///         a revert — they read the slot. Two stores means an observer sees WHICH store a person
///         is in, so the secret class is identified by the store that holds it. Worse, once both
///         exist the generic revert becomes the tell: getting `TransferNotPermitted` instead of
///         a named error is itself the disclosure. Matching the error strings does not help.
///         Indistinguishability has to come from there being nothing to compare.
///
///         So this store is not "the sanctions store". It is the only place in the suite where a
///         wallet-level stop lives, and `IdentityRegistry.freeze` was REMOVED in favour of it.
///
/// @dev    ⚠️ TWO WRITE ROLES, ONE FLAG. `isScreeningOperator` is the list-screening function —
///         typically a vendor key running daily against a consolidated list. `isRestrictionRegistrar`
///         is the ordinary operations function that records a probate hold or a court order.
///         They are separate keys because they are separate jobs with separate blast radii, and
///         the screening vendor has no business recording a death.
///
///         They write the SAME entry, into the SAME mapping, emitting the SAME event. Recording
///         which role wrote an entry would be a class field by the back door and is not done.
///         The consequence is accepted deliberately: on-chain you cannot tell an operations hold
///         from a listing, including for the purpose of deciding who may lift it. That is why
///         **removal is governance-only for both** — neither operator can lift the other's work,
///         and the segregation that a class field would have bought is bought instead by making
///         the releasing direction the privileged one.
///
/// @dev    ⚠️ WHY THIS IS A SEPARATE CONTRACT FROM `IdentityRegistry` AT ALL. Not scope —
///         `IdentityRegistry` is also one-per-platform and also person-indexed, so that argument
///         proves nothing. Three things do:
///
///         (1) NOT EVERY HELD ADDRESS HAS AN INVESTOR RECORD. `_blockedWallets` holds unhosted
///             counterparties and addresses flagged by chain analytics that were never
///             onboarded. `IdentityRegistry` is a register OF REGISTERED INVESTORS; there is no
///             `Investor` struct to hang the flag on. Hosting this there means bolting a
///             parallel non-investor mapping onto the identity registry, which is precisely the
///             thing that does not belong in it.
///
///         (2) THE SCREENING PROGRAMME IS NOT IDENTITY DATA. `listVersion`, `sweptToVersion`,
///             `sweptAt`, `maxSweepLag` and the permitted-destination register describe a
///             screening programme and a freezing-order mechanic, not a person. `screeningIsStale()`
///             blocks mints — put it on `IdentityRegistry` and the identity registry now holds
///             an opinion about whether the operator's screening vendor is up to date.
///
///         (3) WRITER BLAST RADIUS. The screening operator is a vendor key writing daily. On
///             `IdentityRegistry` that key would sit in the same contract as tier, jurisdiction
///             and claims.
///
/// @dev    ⚠️ ONE LEAK REMAINS AND IT IS NOT CLOSED HERE. `SecurityToken.freezeUnits` is an
///         amount-level freeze with its own public `frozenUnits` mapping, kept because a partial
///         freeze over a disputed or collateralised parcel is a genuinely different mechanic.
///         An agent who freezes 100% of a wallet's units through it reproduces exactly the
///         two-slot problem described above. Nothing in the code prevents that. **Wallet-level
///         stops belong here; `freezeUnits` is for partial parcels only**, and that is an
///         operational rule with no on-chain enforcement behind it.
/// @dev    ⚠️ WHAT THIS CONTRACT DOES NOT SOLVE — stated rather than papered over. The venue
///         lane is not authorisable on a public L1 and the issuer lane does not need a
///         consortium chain, so an operator running both lands on TWO chains, and "one instance
///         per platform" silently becomes two. A listing written here does not reach the other
///         deployment, and cross-chain propagation is not atomic. `listVersion` and
///         `sweptToVersion` exist so the lag is at least *measurable* per chain; closing it is
///         an operational commitment with a stated worst-case, not something a contract can do.
contract RestrictedPartyRegistry is IRestrictedParty {
    // ═══════════════════════════════════════════════════════════════════════
    // THE ENTRY — one shape for every class of person-scoped restriction
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev No class field, deliberately. See the observability note above.
    struct Entry {
        bool active;
        uint64 since;
        bytes32 caseRef; // opaque digest of the off-chain case file; never a reason
    }

    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;

    /// @notice Writes restrictions off the back of a screening run against a consolidated list.
    ///         Separate from `governance` for the same reason `IdentityRegistry` separates the
    ///         registrar: screening is a daily operational function and upgrade authority is
    ///         not. Also the only role that may advance the list version or anchor a sweep —
    ///         those are screening-programme facts and no other function owns them.
    mapping(address => bool) public isScreeningOperator;

    /// @notice Writes the ordinary restrictions: probate pending, court attachment, lost-key hold,
    ///         customer request, operational hold pending investigation.
    /// @dev    A separate key from the screening operator because it is a separate job — the
    ///         screening vendor should not be able to record a death, and the operations desk
    ///         should not be able to advance the sanctions list version. What they cannot be is
    ///         separate STORAGE; see the one-store note on the contract.
    mapping(address => bool) public isRestrictionRegistrar;

    // ─────────────────────────── dependencies ─────────────────────────────────

    /// @notice Resolves a wallet to the investor record it belongs to, so that blocking the
    ///         PERSON blocks every wallet bound to them rather than the one that was screened.
    /// @dev    Interface-typed and held behind a governance setter, never `immutable` and never
    ///         unset — the standing rule for every inter-contract reference in this suite.
    IIdentityGate public identity;

    // ─────────────────────────── state ────────────────────────────────────────

    /// @notice Person-scoped blocks, keyed by `personId`. This is
    ///         the primary store: a listing follows the person across every wallet they hold.
    mapping(bytes32 => Entry) private _blockedPersons;

    /// @notice Wallet-scoped blocks, for addresses with no investor record — an unhosted
    ///         counterparty, or an address flagged by chain analytics that was never onboarded.
    /// @dev    Both stores are consulted. Neither is a fallback for the other: a person can be
    ///         listed while a specific address is separately flagged, and clearing one must not
    ///         clear the other.
    mapping(address => Entry) private _blockedWallets;

    /// @notice Destinations a restricted position may be moved TO despite the sender being restricted.
    /// @dev    ⚠️ THIS EXISTS BECAUSE `SecurityToken.forcedTransfer` READS THIS STORE — in its
    ///         mandatory layer since 2026-09-08, not merely through the gate on the module list.
    ///         Without a carve-out, restricting a wallet also blocks the very movement the restriction's own
    ///         instrument directs — the control would prevent the operator from complying with
    ///         the order that triggered it. Two cases need it and they are the same mechanic:
    ///           • a seizure or transfer-to-frozen-account under a freezing order; and
    ///           • an ESTATE DISTRIBUTION. A probate hold ends by moving the position to an
    ///             heir, and an heir is a DIFFERENT PERSON, so the recipient limb would stop it.
    ///             Registering the estate account here is what lets probate complete.
    ///         Governance-only, `orderRef` recorded, and it relieves the SENDER limb only: a
    ///         held party can never be a recipient, so these cannot compose into an exit route.
    /// @dev    ⚠️ Registering a destination is the single most dangerous write in this contract —
    ///         it is a standing exemption from the sender check. `orderRef` is mandatory and the
    ///         set should be small, short-lived and reviewed. An unrecorded permitted
    ///         destination is indistinguishable from a backdoor.
    mapping(address => bool) public isPermittedDestination;

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
    //
    // ⚠️ AND NO EVENT HERE CARRIES THE PERSON KEY. The rule above was right and stopped one step
    //    short: withholding WHY somebody is blocked does nothing while WHO is the indexed topic.
    //    `personId` is `IdentityRegistry`'s person key — one value shared by every wallet
    //    belonging to one human. Indexed here it was a permanent, un-erasable "these addresses
    //    are the same person, and that person is sanctions-blocked": GDPR Art 10 data, in the one
    //    store `deregisterPerson` can never reach. `caseRef` replaces it as the topic. It is an
    //    opaque handle to an off-chain case file, so a supervisor joins the log to the file they
    //    already hold, and nobody else learns anything.
    //
    // ⚠️ `WalletBlocked` KEEPS its address, and the asymmetry is the point. A blocked wallet is
    //    already observable — its transfers revert — so the log discloses nothing the chain does
    //    not. What was NOT otherwise observable is the linkage between one person's wallets, and
    //    that is exactly what the record-level events were publishing.

    event PersonBlocked(bytes32 indexed caseRef, uint64 at);
    event PersonUnblocked(bytes32 indexed caseRef, uint64 at);
    event WalletBlocked(address indexed wallet, bytes32 caseRef, uint64 at);
    event WalletUnblocked(address indexed wallet, bytes32 caseRef, uint64 at);

    event ScreeningOperatorSet(address indexed operator, bool allowed);
    event RestrictionRegistrarSet(address indexed registrar, bool allowed);
    event PermittedDestinationSet(address indexed destination, bool allowed, bytes32 orderRef);
    event DependencySet(bytes32 indexed what, address impl);
    event MaxSweepLagSet(uint32 seconds_);

    event ListVersionAdvanced(uint64 indexed version, bytes32 sourceHash, uint64 at);
    event SweepCompleted(uint64 indexed version, uint256 recordsScreened, uint64 at);

    // ─────────────────────────── errors ───────────────────────────────────────

    /// @notice THE ONLY PERSON-LINKED ERROR ON THE TRANSFER PATH. One code for every restriction
    ///         there is — listing, suspicion, probate, court order, lost key, operational. A
    ///         distinct code for any one of them is the tip-off, and so is a distinct code for
    ///         any of the INNOCENT ones: if probate reverted by name, then the generic code
    ///         would mean "not probate", which narrows it to the classes that must stay silent.
    ///         Informative status goes to the operator off-chain, never to the caller.
    /// @dev    ⚠️ Note it takes no arguments. An address parameter would tell the caller WHICH
    ///         side failed, which on a two-sided check is most of the information back again.
    /// @dev    ⚠️ This is one of TWO argument-free errors `assertTransferPermitted` can raise, not
    ///         one — an earlier version of this note said "the only error on the transfer path",
    ///         which was false. The other is `ScreeningStale` below, on the mint path only.
    error TransferNotPermitted();

    /// @notice The second transfer-path error, and it is raised on MINT ONLY (`from == address(0)`).
    ///         It says the operator's re-screen of the existing base has fallen behind the current
    ///         list beyond the tolerated lag — or has never run — and so no NEW position may be
    ///         admitted. It names no person and can never fire on a path that has a sender, so
    ///         it discloses nothing about anyone; it is generic-class all the same, and stays
    ///         argument-free for that reason.
    error ScreeningStale();

    // Operational errors — write paths only, never reachable from `assertTransferPermitted`.
    error NotGovernance();
    error NotScreeningOperator();
    error NotARestrictionWriter();
    error ZeroAddress();
    error CaseRefRequired();
    error AlreadyBlocked();
    error NotBlocked();
    error StaleSweepVersion();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyScreeningOperator() {
        if (!isScreeningOperator[msg.sender]) revert NotScreeningOperator();
        _;
    }

    /// @dev Either write role may PLACE a restriction. Neither may lift one — that is governance, so
    ///      that a role which cannot tell a listing from a probate hold also cannot release one
    ///      by mistake.
    modifier onlyRestrictionWriter() {
        if (!isScreeningOperator[msg.sender] && !isRestrictionRegistrar[msg.sender]) revert NotARestrictionWriter();
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

    /// @notice The ordinary-restrictions desk. Wire at least one on every deployment: without it the
    ///         only party able to record a probate hold is the sanctions screening vendor, and
    ///         an operator faced with that will reach for a second store instead — which is the
    ///         failure this whole contract exists to prevent.
    function setRestrictionRegistrar(address registrar, bool allowed) external onlyGovernance {
        if (registrar == address(0)) revert ZeroAddress();
        isRestrictionRegistrar[registrar] = allowed;
        emit RestrictionRegistrarSet(registrar, allowed);
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

    /// @param orderRef Digest of the instrument this destination is registered under — a
    ///                 freezing order, a competent-authority direction, or a grant of probate.
    ///                 Governance-only and logged, because an unrecorded permitted destination
    ///                 is indistinguishable from a backdoor.
    function setPermittedDestination(address destination, bool allowed, bytes32 orderRef) external onlyGovernance {
        if (destination == address(0)) revert ZeroAddress();
        if (allowed && orderRef == bytes32(0)) revert CaseRefRequired();
        isPermittedDestination[destination] = allowed;
        emit PermittedDestinationSet(destination, allowed, orderRef);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // HOLD MAINTENANCE
    //
    // ⚠️ `caseRef` is REQUIRED on every write, including unblocks. A delisting is a decision
    //    with a file behind it exactly as a listing is, and an unblock with no reference is the
    //    write nobody can explain to a supervisor afterwards.
    // ═══════════════════════════════════════════════════════════════════════

    function blockPerson(bytes32 personId, bytes32 caseRef) external onlyRestrictionWriter {
        if (personId == bytes32(0)) revert ZeroAddress();
        if (caseRef == bytes32(0)) revert CaseRefRequired();
        Entry storage e = _blockedPersons[personId];
        if (e.active) revert AlreadyBlocked();

        e.active = true;
        e.since = uint64(block.timestamp);
        e.caseRef = caseRef;

        emit PersonBlocked(caseRef, uint64(block.timestamp));
    }

    /// @notice Delisting. Governance rather than the screening operator: adding a block is an
    ///         operational act that fails safe, removing one releases a frozen position and
    ///         does not.
    function unblockPerson(bytes32 personId, bytes32 caseRef) external onlyGovernance {
        if (caseRef == bytes32(0)) revert CaseRefRequired();
        Entry storage e = _blockedPersons[personId];
        if (!e.active) revert NotBlocked();

        delete _blockedPersons[personId];
        emit PersonUnblocked(caseRef, uint64(block.timestamp));
    }

    function blockWallet(address wallet, bytes32 caseRef) external onlyRestrictionWriter {
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
    /// @dev    `version == 0` is refused. Version 0 is "no list has been ingested", and a sweep
    ///         against no list is not a sweep — accepting it would let `sweptToVersion` stay 0
    ///         while `sweptAt` advanced, which is exactly the shape `screeningIsStale` treats
    ///         as "never swept". Call `advanceListVersion` first.
    function recordSweep(uint64 version, uint256 recordsScreened) external onlyScreeningOperator {
        if (version == 0 || version > listVersion || version < sweptToVersion) revert StaleSweepVersion();
        sweptToVersion = version;
        sweptAt = uint64(block.timestamp);
        emit SweepCompleted(version, recordsScreened, uint64(block.timestamp));
    }

    /// @notice True when the sweep has fallen behind the current list beyond the tolerated lag —
    ///         and TRUE UNTIL A FIRST SWEEP HAS BEEN RECORDED.
    /// @dev    ⚠️ The first clause was missing until 2026-09-08. `listVersion` and `sweptToVersion`
    ///         both start at 0, so `sweptToVersion >= listVersion` held on a fresh deployment and
    ///         a store that had never screened anyone reported itself current: every mint went
    ///         through unscreened for as long as nobody called `advanceListVersion`, and the
    ///         deployment note that said "until a sweep is recorded every mint reverts" was
    ///         describing a control that did not exist. Now `sweptToVersion == 0` — which, since
    ///         `recordSweep` refuses version 0, means exactly "no sweep has ever been recorded" —
    ///         is stale, so go-live requires `advanceListVersion` + `recordSweep` once each
    ///         before the first subscription. Fail closed on the empty state, not open.
    function screeningIsStale() public view returns (bool) {
        if (sweptToVersion == 0) return true;
        if (sweptToVersion >= listVersion) return false;
        if (maxSweepLag == 0) return true;
        return block.timestamp > uint256(sweptAt) + uint256(maxSweepLag);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS AND THE GATE
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Both stores are consulted, person first. `personIdOf` is a two-value read
    ///      rather than a struct on purpose — this contract has no business seeing the rest of
    ///      the investor record.
    function isBlocked(address wallet) public view returns (bool) {
        (bytes32 personId, bool registered) = identity.personIdOf(wallet);
        if (registered && personId != bytes32(0) && _blockedPersons[personId].active) return true;
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
        if (isPermittedDestination[to]) return;

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
    function entryForPerson(bytes32 personId) external view returns (Entry memory) {
        return _blockedPersons[personId];
    }

    function entryForWallet(address wallet) external view returns (Entry memory) {
        return _blockedWallets[wallet];
    }
}

// ⚠️ `RestrictedPartyGate` — the `IComplianceModule` adapter that makes this store reachable from the
//    C1 hook — lives in `RestrictedPartyGate.sol`. Without it registered on `ModularCompliance`, this
//    contract enforces nothing on a transfer: only a transfer agent remembering to call
//    `assertTransferPermitted` would.
//
//    ⚠️ Note this file departs from the folder's store-plus-gate-in-one-file convention, which
//    `CovenantRegistry.sol`, `HoldingPeriodLock.sol` and `PdmrClosedPeriodFreeze.sol` all still
//    follow. Deliberate, at the operator's direction (2026-09-07). If the folder is ever brought
//    to one-contract-per-file, those three are the remaining work.

