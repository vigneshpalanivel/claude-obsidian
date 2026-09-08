// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ModuleAdapter} from "./ModularCompliance.sol";

/// @title HoldingPeriodLock (illustrative sample — not production code)
/// @notice Blocks transfers/redemptions for two independent reasons that a fund can run
///         separately or together: (1) a fund-wide ramp-up window before which nobody may
///         exit at all, e.g. an ELTIF still deploying capital into long-term assets
///         (Art 18(2)(a) — "not before the end of a minimum holding period or before the
///         investment ramp-up date"; eltif-checklist.md §9.2); and (2) a per-investor
///         minimum holding period measured from each investor's own acquisition date, not
///         from a fund-wide date.
/// @dev    This is a compliance gate, not a token — it never moves a balance. It is reached
///         from the C1 hook through `HoldingPeriodGate` below, which also feeds it every
///         transfer-in so a secondary-market buyer gets a clock (M-T8).
/// @dev    ⚠️ THE CLOCK IS SET ONCE AND NEVER MOVED FORWARD. `recordSubscription` and
///         `recordTransferIn` both write `subscribedAt[investor]` only when it is zero; a
///         top-up, a second subscription or a later transfer-in keeps the EARLIER date.
///         Before 2026-09-08 every `recordSubscription` reset the clock, which let an agent
///         extend any holder's lock indefinitely by re-recording them. A fund whose rules
///         restart the clock per tranche needs per-tranche state this contract does not
///         keep. Lost-key recovery lands units in a wallet with no clock; the gate's
///         `notifyTransfer` gives it one at recovery time — the operator who wants the
///         original date carried over calls `backdate` with it.
/// @dev    ⚠️ `subscribedAt` IS PERSONAL DATA on a public ledger (a wallet's acquisition
///         date). It is here because a `require` reads it — the on-chain gating test — and
///         it is the one date the holder already published by transacting. Nothing else
///         about the holder is stored.
contract HoldingPeriodLock {
    /// @dev NOT immutable (M-F6). Two-step, same pattern as the oracle's governance. The
    ///      review's D20 note names this key as silently load-bearing under a proxy.
    address public aifm;
    address public pendingAifm;
    address public subscriptionAgent; // records each investor's subscription date
    /// @notice The `HoldingPeriodGate` permitted to call `recordTransferIn`. Until set, every
    ///         transfer through the gate reverts `NotAuthorised` — deliberately loud, the
    ///         same posture as an unrecorded screening sweep; wire it at deployment.
    address public gate;

    // ─────────────────────────── ramp-up lock (fund-wide) ─────────────────────

    uint64 public rampUpEndsAt; // 0 = no ramp-up lock configured

    // ─────────────────────────── minimum holding period (per-investor) ────────

    uint64 public minimumHoldingPeriod; // 0 = no per-investor minimum configured
    mapping(address => uint64) public subscribedAt;

    // ─────────────────────────── events ────────────────────────────────────────

    event RampUpEndSet(uint64 endsAt);
    event MinimumHoldingPeriodSet(uint64 seconds_);
    /// @dev Fires once per wallet, on whichever of subscription / transfer-in / backdate
    ///      set the clock. A re-record that kept the earlier date emits nothing.
    event SubscriptionRecorded(address indexed investor, uint64 subscribedAt);
    event AifmTransferProposed(address indexed current, address indexed proposed);
    event AifmTransferred(address indexed previous, address indexed next);
    event SubscriptionAgentChanged(address indexed previous, address indexed next);
    event GateChanged(address indexed previous, address indexed next);

    // ─────────────────────────── errors ────────────────────────────────────────

    error NotAifm();
    error NotPendingAifm();
    error NotSubscriptionAgent();
    error NotAuthorised();
    error StillInRampUp(uint64 endsAt);
    error StillInHoldingPeriod(uint64 unlocksAt);
    /// @dev A holder with units and no clock. Reachable only for units that arrived
    ///      BEFORE `gate` was wired (the gate records every transfer-in since), or via a
    ///      path that bypassed the module list. Operator step: `recordSubscription` or
    ///      `backdate` the wallet with its true acquisition date.
    error NoSubscriptionRecorded();
    error FutureDate();
    error ZeroAddress();

    modifier onlyAifm() {
        if (msg.sender != aifm) revert NotAifm();
        _;
    }

    modifier onlySubscriptionAgent() {
        if (msg.sender != subscriptionAgent) revert NotSubscriptionAgent();
        _;
    }

    constructor(address aifm_, address subscriptionAgent_) {
        if (aifm_ == address(0) || subscriptionAgent_ == address(0)) revert ZeroAddress();
        aifm = aifm_;
        subscriptionAgent = subscriptionAgent_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ROLES — rotatable (M-F6).
    // ═══════════════════════════════════════════════════════════════════════

    function transferAifm(address next) external onlyAifm {
        if (next == address(0)) revert ZeroAddress();
        pendingAifm = next;
        emit AifmTransferProposed(aifm, next);
    }

    function acceptAifm() external {
        if (msg.sender != pendingAifm) revert NotPendingAifm();
        address previous = aifm;
        aifm = msg.sender;
        pendingAifm = address(0);
        emit AifmTransferred(previous, msg.sender);
    }

    function setSubscriptionAgent(address next) external onlyAifm {
        if (next == address(0)) revert ZeroAddress();
        emit SubscriptionAgentChanged(subscriptionAgent, next);
        subscriptionAgent = next;
    }

    function setGate(address next) external onlyAifm {
        if (next == address(0)) revert ZeroAddress();
        emit GateChanged(gate, next);
        gate = next;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CONFIGURATION
    // ═══════════════════════════════════════════════════════════════════════

    function setRampUpEnd(uint64 endsAt) external onlyAifm {
        rampUpEndsAt = endsAt;
        emit RampUpEndSet(endsAt);
    }

    function setMinimumHoldingPeriod(uint64 seconds_) external onlyAifm {
        minimumHoldingPeriod = seconds_;
        emit MinimumHoldingPeriodSet(seconds_);
    }

    /// @notice Called at the moment a subscription settles. Idempotent: a wallet that
    ///         already has a clock keeps it (see header) and nothing is emitted.
    function recordSubscription(address investor) external onlySubscriptionAgent {
        _setIfUnset(investor, uint64(block.timestamp));
    }

    /// @notice Called by the gate on every transfer-in (mint included), so a secondary-market
    ///         recipient starts a clock at the moment they acquire. Idempotent.
    function recordTransferIn(address to) external {
        if (msg.sender != gate && msg.sender != subscriptionAgent) revert NotAuthorised();
        _setIfUnset(to, uint64(block.timestamp));
    }

    /// @notice Operator correction for a wallet whose true acquisition date is earlier
    ///         than the one on record — a recovered wallet, or units that arrived before
    ///         the gate was wired. Can only move the clock EARLIER; the lock can never be
    ///         extended through this contract.
    function backdate(address investor, uint64 acquiredAt) external onlyAifm {
        if (acquiredAt > block.timestamp) revert FutureDate();
        uint64 current = subscribedAt[investor];
        if (current != 0 && acquiredAt >= current) return;
        subscribedAt[investor] = acquiredAt;
        emit SubscriptionRecorded(investor, acquiredAt);
    }

    function _setIfUnset(address investor, uint64 at) internal {
        if (subscribedAt[investor] != 0) return;
        subscribedAt[investor] = at;
        emit SubscriptionRecorded(investor, at);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // GATE — call before any transfer/redemption. Reverts if either lock is
    // still active; a fund using only one of the two locks simply leaves the
    // other at its default (0 = disabled) and this function skips it.
    // ═══════════════════════════════════════════════════════════════════════

    function checkTransfer(address investor) external view {
        if (rampUpEndsAt != 0 && block.timestamp < rampUpEndsAt) {
            revert StillInRampUp(rampUpEndsAt);
        }

        if (minimumHoldingPeriod != 0) {
            uint64 subscribed = subscribedAt[investor];
            if (subscribed == 0) revert NoSubscriptionRecorded();
            uint64 unlocksAt = subscribed + minimumHoldingPeriod;
            if (block.timestamp < unlocksAt) revert StillInHoldingPeriod(unlocksAt);
        }
    }
}

/// @title HoldingPeriodGate
/// @notice The `IComplianceModule` face of `HoldingPeriodLock`, so `ModularCompliance` can
///         actually register it. Without this the lock is unreachable from the C1 hook and
///         only a transfer agent remembering to call it enforces anything.
/// @dev    ⚠️ Gates the SENDER only, and skips mint. A holding period is a restriction on
///         exiting a position, so it binds whoever is giving up units — which makes a burn
///         (redemption, `to == 0`) squarely in scope and a mint (`from == 0`) out of it.
///         `SecurityToken._check` states the same expectation from the other side: *"a
///         holding-period lock ignores it [mint]"*.
/// @dev    ⚠️ RECORDS THE RECIPIENT on `notifyTransfer`, which the token calls after every
///         settled move — mint, transfer, forced transfer and lost-key recovery alike. That
///         is what gives a secondary-market buyer a clock (M-T8). `ModuleAdapter` exposes
///         the hook as a virtual no-op; this is the one module in the suite that overrides
///         it. The lock must have this gate set via `setGate`, or the call reverts and with
///         it the transfer — see the lock's header.
/// @dev    The lock's own errors — `StillInRampUp`, `StillInHoldingPeriod` — propagate
///         unchanged through this adapter. That is the point of adapting at the boundary
///         rather than widening the gate's signature: the §13 Article→function map still
///         resolves to the contract named against the Article.
contract HoldingPeriodGate is ModuleAdapter {
    HoldingPeriodLock public immutable lock;

    constructor(bytes32 moduleId_, address lock_) ModuleAdapter(moduleId_) {
        lock = HoldingPeriodLock(lock_);
    }

    function checkTransfer(address from, address, uint256) external view override {
        if (from == address(0)) return; // mint — nobody is exiting
        lock.checkTransfer(from);
    }

    function notifyTransfer(address, address to, uint256) external override {
        if (to == address(0)) return; // burn — nobody is acquiring
        lock.recordTransferIn(to);
    }
}
