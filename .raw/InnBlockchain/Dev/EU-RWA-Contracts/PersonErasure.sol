// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IErasable} from "./Interfaces.sol";

/// @dev The two calls only `IdentityRegistry` can serve. Not folded into `IErasable`: the
///      registry is the coordinator's *source* of the wallet list and its *last* write, which
///      is a different role from the targets it fans out over, and giving it the same interface
///      would invite someone to register it as an ordinary target and destroy the ordering.
interface IIdentityErasure {
    function walletsOfPerson(bytes32 personId) external view returns (address[] memory);

    function erasePerson(bytes32 personId, bytes32 reasonHash) external;
}

/// @title PersonErasure (illustrative sample — not production code)
/// @notice C29 — answers one GDPR Art 17 request with one transaction, across every contract in
///         the suite that holds state about the person.
/// @dev    ⚠️ WHY THIS EXISTS. Before it, each contract had its own erasure entry point and the
///         Art 17 answer was "call five functions, from three different role keys, in the right
///         order, and do not forget one". Nothing on-chain checked completeness, and a missed
///         leg is not a partial answer — it is a record that survived the erasure it was subject
///         to, which is the failure `IdentityRegistry`'s person index was added to prevent one
///         layer up. A right that is only exercised correctly when an operator remembers every
///         step is not implemented, it is aspirational.
/// @dev    ⚠️ ORDER IS THE DESIGN, NOT AN IMPLEMENTATION DETAIL. `IdentityRegistry` is erased
///         LAST and everything else first, because the registry is the only contract that maps
///         `personId → wallets`. `CovenantRegistry` is keyed purely by address; the wallet-side
///         state in `MemberEligibility` and `SubscriptionEscrow` likewise. Erase the registry
///         first — which is what a hand-written "call `erasePerson` then clean up" script does,
///         because that is the call the operator thinks of first — and every remaining target
///         is handed a `personId` it cannot expand into the addresses it needs to clear. The
///         data is then unreachable by the erasure and still fully readable by everyone else.
/// @dev    ⚠️ ATOMIC ON PURPOSE. Any leg that reverts reverts the whole act. A partial erasure
///         is worse than a failed one: the operator has told the data subject the request was
///         honoured, has probably written that into the Art 30 record, and the surviving rows
///         are now the ones nobody will look for again. The cost is that a single paused or
///         mis-wired target blocks every erasure, which is why `skipTarget` exists — a skip is
///         a governance act with a reason hash attached, so an incomplete erasure is a decision
///         somebody signed rather than a gap nobody noticed.
/// @dev    ⚠️ WHAT IS DELIBERATELY NOT A TARGET. `RestrictedPartyRegistry` is absent from this
///         contract and must never be registered. A sanctions or suspicion block exists because
///         of a legal obligation, and Art 17(3)(b) disapplies the erasure right exactly there;
///         honouring an erasure request against the restriction store would delete the record
///         that stops the person trading, at the request of the person it stops. It is not
///         skippable-by-default either — absence is stronger than a skip, because a skip can be
///         cleared by the same governance call that set it.
/// @dev    ⚠️ WHAT NO CONTRACT IN THIS SUITE CAN ERASE: the logs. Every `WalletBound(wallet)`,
///         every `Subscribed(...)`, every `MemberAdmitted(...)` ever emitted sits on every
///         archive node forever, and a wallet address is pseudonymous personal data under
///         Recital 26 — pseudonymous is not anonymous. This coordinator is complete as to
///         STORAGE and silent as to HISTORY. That is the reason nothing beyond an address was
///         ever written to a log anywhere in this suite, and it is a limitation the DPIA must
///         state in terms rather than a gap to be papered over: the operator's Art 17 response
///         should say what was erased and what remains, not claim the chain forgot.
/// @dev    ⚠️ AND THE OTHER HALF OF THE ANSWER IS OFF-CHAIN. `personId` is a digest of a
///         verified record held off-chain, and `nationalClientIdHash` is a salted hash. Neither
///         is readable without the off-chain record and its salt. Destroying those is what turns
///         the surviving log entries from pseudonymous data into noise — cryptographic erasure.
///         An operator that runs this function and keeps the salt has not completed the request.
contract PersonErasure {
    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;

    /// @notice The data-protection desk. Requests and executes erasures; can do nothing else.
    /// @dev    ⚠️ SEPARATE FROM EVERY REGISTRAR KEY, AND THAT SEPARATION IS THE POINT. The
    ///         registrar wrote the record; the eraser answers to the data subject. If the two
    ///         were one key, a compromised erasure path would also be able to forge identity
    ///         records, admit members and write claims — the blast radius of the most
    ///         destructive role in the suite would include the most creative one.
    mapping(address => bool) public isEraser;

    IIdentityErasure public identityRegistry;

    // ─────────────────────────── target set ───────────────────────────────────

    /// @dev ⚠️ A REGISTRY, NOT A HARDCODED LIST. Five addresses baked into a constructor would
    ///      be correct on deployment day and quietly wrong the day the suite grows a thirtieth
    ///      contract holding person-linked state — the coordinator would keep succeeding, keep
    ///      emitting, and keep under-erasing, with nothing failing to signal it. A registered
    ///      set makes adding a contract to the suite and adding it to the erasure path the same
    ///      governance decision, taken at the same time.
    address[] private _targets;
    mapping(address => uint256) private _targetSlot; // index + 1; 0 = not registered

    /// @notice Targets governance has explicitly excused, with the reason recorded.
    /// @dev    The escape hatch for the atomicity rule. Set it and the fan-out steps over that
    ///         contract instead of reverting on it. Deliberately NOT clearable silently: both
    ///         directions emit, so the window a target was skipped in is reconstructible from
    ///         the log — which is what an Art 30 record and a supervisor's question both need.
    mapping(address => bytes32) public skipReason;
    mapping(address => bool) public isSkipped;

    // ─────────────────────────── timelock ─────────────────────────────────────

    /// @notice Delay between requesting an erasure and being able to execute it.
    /// @dev    ⚠️ THE ONLY BRAKE ON THE MOST DESTRUCTIVE CALL IN THE SUITE. This contract can
    ///         wipe the identity registry one person at a time, and a stolen eraser key with no
    ///         delay is an instant, irreversible, un-appealable data loss. A pending request is
    ///         visible on-chain, so governance has a window to revoke the key or cancel.
    ///         GDPR Art 12(3) gives a controller one month to respond to an Art 17 request, so
    ///         a day or two costs nothing operationally.
    uint64 public executionDelay = 24 hours;

    /// @dev ⚠️ CAPPED, BECAUSE A TIMELOCK IS ALSO A WAY TO REFUSE. Without a ceiling, governance
    ///      could set the delay to ten years and defeat the erasure right entirely while
    ///      appearing to implement it. Seven days leaves the Art 12(3) month intact with room
    ///      for the request, the delay and the execution.
    uint64 public constant MAX_EXECUTION_DELAY = 7 days;

    /// @dev Keyed by `personId` and deleted on execution — storage, not a log, for the usual
    ///      reason: this mapping is itself a statement that a named person asked to be
    ///      forgotten, which is personal data about a data-protection request.
    mapping(bytes32 => uint64) public executableAt;

    // ─────────────────────────── events ───────────────────────────────────────

    /// @dev ⚠️ NO `personId` IN ANY TOPIC OR FIELD, INCLUDING HERE. The subject of an erasure
    ///      request is the single most sensitive linkage this suite handles — Art 9 territory
    ///      once you consider why people ask — and a log is the one store the erasure cannot
    ///      reach. `reasonHash` is a digest of the DPO's case file and resolves to nothing
    ///      without it.
    ///
    ///      The honest boundary, since it is easy to overclaim here: `personId` is unavoidably
    ///      in the CALLDATA of `request` and `execute`, and calldata is as permanent as a log.
    ///      It is unavoidable because a function must name its subject, and it adds no new
    ///      linkage — the same `personId` was already in the calldata of `registerPerson` when
    ///      the record was created. What IS avoidable is making it an indexed event topic,
    ///      which turns a fact buried in transaction history into one an indexer surfaces by
    ///      default. So it is not emitted. `PdmrRegister.purgePerson` reasons identically about
    ///      its own argument.
    event EraserSet(address indexed eraser, bool allowed);
    event IdentityRegistrySet(address indexed previous, address indexed current);
    event TargetRegistered(address indexed target);
    event TargetDeregistered(address indexed target);
    event TargetSkipSet(address indexed target, bool skipped, bytes32 reasonHash);
    event ExecutionDelaySet(uint64 previousSeconds, uint64 currentSeconds);
    event ErasureRequested(uint64 executableAt, bytes32 reasonHash);
    event ErasureCancelled(bytes32 reasonHash);
    /// @dev `targetsRun` versus `targetsSkipped` is the completeness evidence an Art 30 record
    ///      cites. A run where `targetsSkipped` is non-zero is an erasure with a known hole in
    ///      it, and the hole is named in the `TargetSkipSet` log that authorised it.
    event PersonErased(uint256 targetsRun, uint256 targetsSkipped, uint256 walletsCovered, bytes32 reasonHash);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotEraser();
    error ZeroAddress();
    error ReasonRequired();
    error DelayTooLong(uint64 requested, uint64 maximum);
    error AlreadyRegistered(address target);
    error NotRegistered(address target);
    error IdentityRegistryUnset();
    error NoSuchPerson(bytes32 personId);
    error NoPendingRequest(bytes32 personId);
    error RequestAlreadyPending(bytes32 personId, uint64 executableAt_);
    error TimelockNotExpired(uint64 executableAt_);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyEraser() {
        if (!isEraser[msg.sender]) revert NotEraser();
        _;
    }

    constructor(address governance_, address identityRegistry_) {
        if (governance_ == address(0) || identityRegistry_ == address(0)) revert ZeroAddress();
        governance = governance_;
        identityRegistry = IIdentityErasure(identityRegistry_);
        emit IdentityRegistrySet(address(0), identityRegistry_);
        emit ExecutionDelaySet(0, executionDelay);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // WIRING
    // ═══════════════════════════════════════════════════════════════════════

    function setEraser(address eraser, bool allowed) external onlyGovernance {
        if (eraser == address(0)) revert ZeroAddress();
        isEraser[eraser] = allowed;
        emit EraserSet(eraser, allowed);
    }

    /// @notice Re-point at a redeployed identity registry. Swap, never unset.
    function setIdentityRegistry(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        address previous = address(identityRegistry);
        identityRegistry = IIdentityErasure(impl);
        emit IdentityRegistrySet(previous, impl);
    }

    /// @notice Add a contract to the fan-out.
    /// @dev    ⚠️ NEVER REGISTER `IdentityRegistry` HERE. It is erased last by `execute`, through
    ///         `IIdentityErasure`, and registering it as an ordinary target would call it in the
    ///         middle of the run — destroying the wallet list the remaining targets depend on.
    ///         Nothing on-chain can detect the mistake, because the registry does not implement
    ///         `IErasable` and the call would simply revert with no data; this comment is the
    ///         control.
    /// @dev    ⚠️ NEVER REGISTER `RestrictedPartyRegistry` HERE either — Art 17(3)(b). See the
    ///         contract header.
    function registerTarget(address target) external onlyGovernance {
        if (target == address(0)) revert ZeroAddress();
        if (_targetSlot[target] != 0) revert AlreadyRegistered(target);

        _targets.push(target);
        _targetSlot[target] = _targets.length; // index + 1
        emit TargetRegistered(target);
    }

    /// @notice Remove a contract from the fan-out entirely.
    /// @dev    For a contract that has been retired, not for one that is temporarily awkward —
    ///         that is `setTargetSkipped`, which leaves the target registered and the gap
    ///         visible. Swap-and-pop; order carries no meaning because every target is called.
    function deregisterTarget(address target) external onlyGovernance {
        uint256 slot = _targetSlot[target];
        if (slot == 0) revert NotRegistered(target);

        uint256 lastIndex = _targets.length - 1;
        if (slot - 1 != lastIndex) {
            address moved = _targets[lastIndex];
            _targets[slot - 1] = moved;
            _targetSlot[moved] = slot;
        }
        _targets.pop();
        delete _targetSlot[target];

        emit TargetDeregistered(target);
    }

    /// @notice Excuse a target from the fan-out without removing it, or un-excuse it.
    /// @dev    `reasonHash` is mandatory in BOTH directions. Skipping a target is a decision to
    ///         answer an erasure request incompletely, and un-skipping is a decision that the
    ///         blocker is resolved; neither should be reconstructible only from an address and
    ///         a boolean.
    function setTargetSkipped(address target, bool skipped, bytes32 reasonHash) external onlyGovernance {
        if (_targetSlot[target] == 0) revert NotRegistered(target);
        if (reasonHash == bytes32(0)) revert ReasonRequired();

        isSkipped[target] = skipped;
        skipReason[target] = reasonHash;
        emit TargetSkipSet(target, skipped, reasonHash);
    }

    function setExecutionDelay(uint64 seconds_) external onlyGovernance {
        if (seconds_ > MAX_EXECUTION_DELAY) revert DelayTooLong(seconds_, MAX_EXECUTION_DELAY);
        uint64 previous = executionDelay;
        executionDelay = seconds_;
        emit ExecutionDelaySet(previous, seconds_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // THE ERASURE ITSELF
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Open the timelock window on one person's erasure.
    /// @dev    Checks the person exists NOW so that a typo in the `personId` fails here, a day
    ///         before it would otherwise fail — an erasure that reverts at execution time has
    ///         burnt the delay and the data subject's clock with it.
    function request(bytes32 personId, bytes32 reasonHash) external onlyEraser {
        if (reasonHash == bytes32(0)) revert ReasonRequired();
        if (address(identityRegistry) == address(0)) revert IdentityRegistryUnset();

        uint64 pending = executableAt[personId];
        if (pending != 0) revert RequestAlreadyPending(personId, pending);
        if (identityRegistry.walletsOfPerson(personId).length == 0) revert NoSuchPerson(personId);

        uint64 ready = uint64(block.timestamp) + executionDelay;
        executableAt[personId] = ready;
        emit ErasureRequested(ready, reasonHash);
    }

    /// @notice Withdraw a pending request. Either desk may: the eraser because requests get
    ///         raised in error, governance because a stolen eraser key is exactly the scenario
    ///         the delay exists for and revoking the key must not leave the request armed.
    function cancel(bytes32 personId, bytes32 reasonHash) external {
        if (!isEraser[msg.sender] && msg.sender != governance) revert NotEraser();
        if (executableAt[personId] == 0) revert NoPendingRequest(personId);

        delete executableAt[personId];
        emit ErasureCancelled(reasonHash);
    }

    /// @notice Erase the person everywhere, in one atomic act.
    /// @dev    The sequence, and every step of it is load-bearing:
    ///           1. resolve the wallet list from the registry — the ONLY place it exists;
    ///           2. call every registered, unskipped target with `(personId, wallets)`;
    ///           3. erase the registry itself, last, which takes the wallet list with it.
    /// @dev    A target that holds nothing for this person returns quietly; a target that holds
    ///         something it may not lawfully erase yet REVERTS, and takes the whole run with it.
    ///         `PdmrRegister` is the live example — MAR Art 19 sets no retention period of its
    ///         own (the five-year duties are Art 11(8), 17(1) and 18(5); Art 19 has none), but
    ///         the Art 19(5) list must be complete while the person is still a PDMR, so that
    ///         register refuses until the wallet is revoked and its own retention has run. That
    ///         refusal is correct and the erasure should stop: an Art 17 request does not
    ///         override a live Art 19(5) obligation, and the operator's answer to the data
    ///         subject is Art 17(3)(b), not silence.
    function execute(bytes32 personId, bytes32 reasonHash) external onlyEraser {
        if (reasonHash == bytes32(0)) revert ReasonRequired();

        uint64 ready = executableAt[personId];
        if (ready == 0) revert NoPendingRequest(personId);
        if (block.timestamp < ready) revert TimelockNotExpired(ready);

        address[] memory wallets = identityRegistry.walletsOfPerson(personId);
        if (wallets.length == 0) revert NoSuchPerson(personId);

        uint256 run;
        uint256 skipped;
        uint256 n = _targets.length;
        for (uint256 i = 0; i < n; i++) {
            address target = _targets[i];
            if (isSkipped[target]) {
                skipped++;
                continue;
            }
            IErasable(target).erasePerson(personId, wallets);
            run++;
        }

        // Last. See the ordering note in the header.
        identityRegistry.erasePerson(personId, reasonHash);

        delete executableAt[personId];
        emit PersonErased(run, skipped, wallets.length, reasonHash);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Every contract the next erasure will call.
    /// @dev    The read an Art 30 record cites to evidence the scope of the erasure path, and
    ///         the read a reviewer uses to check it against the deployed suite. If a contract
    ///         holding person-linked state is not in here, the erasure does not reach it.
    function targets() external view returns (address[] memory) {
        return _targets;
    }

    function targetCount() external view returns (uint256) {
        return _targets.length;
    }

    function isTarget(address target) external view returns (bool) {
        return _targetSlot[target] != 0;
    }

    /// @notice Whether a run right now would be complete, and over how many wallets.
    /// @dev    Deliberately does NOT simulate the targets. It answers "is the path itself whole"
    ///         — no skips, registry set, person present — which is the question an operator can
    ///         act on before opening the window. Whether a given target will refuse on
    ///         retention grounds is that target's answer to give, at execution.
    function previewErasure(
        bytes32 personId
    ) external view returns (uint256 walletCount, uint256 targetsToRun, uint256 targetsSkipped) {
        walletCount = identityRegistry.walletsOfPerson(personId).length;
        uint256 n = _targets.length;
        for (uint256 i = 0; i < n; i++) {
            if (isSkipped[_targets[i]]) targetsSkipped++;
            else targetsToRun++;
        }
    }
}
