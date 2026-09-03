// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

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
