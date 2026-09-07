// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ModuleAdapter} from "./ModularCompliance.sol";

/// @title HoldingPeriodLock (illustrative sample — not production code)
/// @notice Blocks transfers/redemptions for two independent reasons that a fund can run
///         separately or together: (1) a fund-wide ramp-up window before which nobody may
///         exit at all, e.g. an ELTIF still deploying capital into long-term assets
///         (Art 17(1)(c)); and (2) a per-investor minimum holding period measured from each
///         investor's own subscription date, not from a fund-wide date.
/// @dev    This is a compliance gate, not a token — it never moves a balance. A token or
///         transfer agent is expected to call `checkTransfer` before moving units and to
///         revert on failure, the same pattern as an ERC-3643 compliance module.
contract HoldingPeriodLock {
    address public immutable aifm;
    address public immutable subscriptionAgent; // records each investor's subscription date

    // ─────────────────────────── ramp-up lock (fund-wide) ─────────────────────

    uint64 public rampUpEndsAt; // 0 = no ramp-up lock configured

    // ─────────────────────────── minimum holding period (per-investor) ────────

    uint64 public minimumHoldingPeriod; // 0 = no per-investor minimum configured
    mapping(address => uint64) public subscribedAt;

    // ─────────────────────────── events ────────────────────────────────────────

    event RampUpEndSet(uint64 endsAt);
    event MinimumHoldingPeriodSet(uint64 seconds_);
    event SubscriptionRecorded(address indexed investor, uint64 subscribedAt);

    // ─────────────────────────── errors ────────────────────────────────────────

    error NotAifm();
    error NotSubscriptionAgent();
    error StillInRampUp(uint64 endsAt);
    error StillInHoldingPeriod(uint64 unlocksAt);
    error NoSubscriptionRecorded();

    modifier onlyAifm() {
        if (msg.sender != aifm) revert NotAifm();
        _;
    }

    modifier onlySubscriptionAgent() {
        if (msg.sender != subscriptionAgent) revert NotSubscriptionAgent();
        _;
    }

    constructor(address aifm_, address subscriptionAgent_) {
        aifm = aifm_;
        subscriptionAgent = subscriptionAgent_;
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

    /// @notice Called once per investor, at the moment their subscription settles — not on
    ///         every subsequent top-up, unless the fund's own rules restart the clock per
    ///         tranche (not modelled here; this contract tracks one running date per investor).
    function recordSubscription(address investor) external onlySubscriptionAgent {
        subscribedAt[investor] = uint64(block.timestamp);
        emit SubscriptionRecorded(investor, uint64(block.timestamp));
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
}
