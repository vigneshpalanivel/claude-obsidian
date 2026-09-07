// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ValuationOracle} from "./ValuationOracle.sol";

/// @title NavBorrowingCap (illustrative sample — not production code)
/// @notice Tracks borrowing/leverage against a running NAV denominator, for whichever
///         fund type this instance is deployed for, and enforces the active/passive
///         breach split plus the Art 16(3)-(4) suspension window.
/// @dev    One deployment = one fund = one FundType. The four regimes are mutually
///         exclusive by construction, not by branching on caller intent at call time.
///         NAV is mark-to-market — it moves from subscriptions/redemptions AND from the
///         market price of held assets changing with no trade at all. The price-driven
///         path is `syncNav`, pulling an absolute figure from `ValuationOracle`;
///         onMint/onBurn alone cannot produce it.
/// @dev    ⚠️ NAV IS ORACLE-FED AND FAILS CLOSED. Every ratio here is borrowing-or-exposure
///         OVER NAV, so a wrong denominator silently passes a breach — §5 calls this the #1
///         engineering risk in the design. Two consequences visible in this file: there is
///         no privileged `valuator` who can move NAV by an arbitrary delta, and every path
///         that draws leverage or moves capital reverts `StaleValuation` when the feed
///         cannot be shown to be current. Passive rechecks still run on a stale figure —
///         they only flag, and a flag computed on an old NAV is better than no flag.
contract NavBorrowingCap {
    // ─────────────────────────── ceilings (basis points, 10000 = 100%) ─────────

    uint256 public constant ELTIF_RETAIL_BORROW_BPS = 5000; // 50% of NAV
    uint256 public constant ELTIF_PROFESSIONAL_BORROW_BPS = 10000; // 100% of NAV

    uint256 public constant UCITS_BUCKET_CEILING_BPS = 1000; // 10% per bucket
    uint256 public constant UCITS_COMBINED_CEILING_BPS = 1500; // 15% combined

    uint256 public constant DERIVATIVE_GLOBAL_EXPOSURE_BPS = 10000; // ≤ 100% of NAV

    uint256 public constant LOF_OPEN_LEVERAGE_BPS = 17500; // 175% of NAV
    uint256 public constant LOF_CLOSED_LEVERAGE_BPS = 30000; // 300% of NAV
    uint256 public constant LOF_CARVEOUT_CEILING_BPS = 15000; // 150% of NAV — excluded from leverage above

    uint256 public constant ALERT_BPS = 9000; // 90% of the limit's distance
    uint256 public constant BPS_DENOM = 10000;

    uint256 public constant SUSPENSION_MAX_DURATION = 365 days; // Art 16(3)-(4)

    enum FundType {
        EltifRetail,
        EltifProfessional,
        Ucits,
        LofOpenEnded,
        LofClosedEnded
    }

    // ─────────────────────────── roles (wire up to real access control) ────────

    address public immutable aifm; // reports borrowing/exposure changes
    address public immutable subscriptionAgent; // prices subscriptions/redemptions — knows CASH amounts, not share counts
    address public immutable regulator; // Art 25 — may tighten the effective ceiling post-deploy

    /// @dev NOT immutable — DORA Art 28 requires the oracle stay "swappable at the contract
    ///      layer, not hard-wired", and a constructor-set immutable reference makes a
    ///      provider swap a redeploy of this module. On a live instrument that is a
    ///      re-issuance, not an upgrade. The swap is already an Art 28(3) NCA
    ///      pre-notification event; the contract layer must not add a redeploy on top.
    ValuationOracle public oracle; // marks NAV to market — absolute, never delta
    bytes32 public immutable navFeedId; // this fund's NAV identity in the oracle

    FundType public immutable fundType;

    // ─────────────────────────── denominator ────────────────────────────────

    /// @notice The last absolute NAV the oracle published, plus the cash that has moved
    ///         since. Two components rather than one running total, because they fail
    ///         differently: the oracle figure carries a timestamp and can go stale, while
    ///         subscription cash is known exactly and needs no feed. Splitting them is what
    ///         lets a subscription between valuation points be reflected without anyone
    ///         inventing a price.
    uint256 public navAtValuation;

    /// @notice Net cash in (positive) or out (negative) since `navAtValuation` was set.
    ///         Reset to zero on every sync — the next published NAV already contains it.
    int256 public cashSinceValuation;

    /// @notice The denominator every ratio in this contract divides by.
    function nav() public view returns (uint256) {
        return _applyDelta(navAtValuation, cashSinceValuation);
    }

    // ─────────────────────────── numerators ─────────────────────────────────

    uint256 public totalBorrowing; // ELTIF, and the LOF leverage figure
    uint256 public ucitsBucketA; // UCITS — first 10% bucket (e.g. temporary borrowing)
    uint256 public ucitsBucketB; // UCITS — second 10% bucket (e.g. back-to-back arrangements)
    uint256 public derivativeExposure; // FDI global exposure, all fund types
    uint256 public lofCarveoutAmount; // LOF — e.g. shareholder loans, excluded from leverage cap

    // ─────────────────────────── Art 25 regulator ceiling ───────────────────

    /// @notice Additional ceiling the regulator can impose post-deployment, in bps.
    ///         Defaults to type(uint256).max (no additional restriction beyond the
    ///         statutory cap for this FundType). Can only ever be set <= its current
    ///         value — this is a tightening power, not a way to loosen the statutory cap.
    uint256 public regulatorCeilingBps = type(uint256).max;

    // ─────────────────────────── breach state ───────────────────────────────

    struct BreachState {
        bool active;
        uint64 startedAt;
    }

    // bucket id => breach state. Buckets: keccak256("BORROWING"), keccak256("UCITS_BUCKET_A"),
    // keccak256("UCITS_BUCKET_B"), keccak256("UCITS_COMBINED"), keccak256("DERIVATIVE_EXPOSURE"),
    // keccak256("LOF_LEVERAGE"), keccak256("LOF_CARVEOUT").
    mapping(bytes32 => BreachState) public breach;

    // ─────────────────────────── suspension (Art 16(3)-(4)) ──────────────────

    bool public suspended;
    uint64 public suspensionStartedAt;

    // ─────────────────────────── events ─────────────────────────────────────

    event BreachStarted(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event BreachCleared(bytes32 indexed bucket);
    event ThresholdAlert(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event SuspensionActivated(uint64 startedAt);
    event SuspensionLifted(uint64 endedAt);
    event RegulatorCeilingUpdated(uint256 oldCeilingBps, uint256 newCeilingBps);
    event NavSynced(uint256 navAtValuation, int256 cashAbsorbed, uint64 at);
    /// @dev DORA Art 28 provider swap. The Register of Information entry and the NCA
    ///      pre-notification are off-chain; this is the on-chain half of the same event.
    event OracleChanged(address indexed previous, address indexed next);

    // ─────────────────────────── errors ──────────────────────────────────────

    error ActiveBreach(bytes32 bucket, uint256 ratioBps, uint256 limitBps);
    error NotAifm();
    error NotSubscriptionAgent();
    error NotRegulator();
    /// @dev The NAV feed is not current, so no ratio computed here can be trusted. §5:
    ///      "oracle failure must HALT issuance/redemption, not pass a stale limit."
    error StaleValuation(bytes32 navFeedId);
    error WrongFundType();
    error CeilingCanOnlyTighten();
    error SuspensionAlreadyActive();
    error ZeroAddress();

    modifier onlyAifm() {
        if (msg.sender != aifm) revert NotAifm();
        _;
    }

    modifier onlySubscriptionAgent() {
        if (msg.sender != subscriptionAgent) revert NotSubscriptionAgent();
        _;
    }

    modifier onlyRegulator() {
        if (msg.sender != regulator) revert NotRegulator();
        _;
    }

    /// @notice Repoint the NAV feed at a different `ValuationOracle` deployment.
    /// @dev    DORA Art 28 swappability. Authority sits with the AIFM because §5's
    ///         delegation note is explicit that parameter-setting authority stays with the
    ///         AIFM's own governance and the technology provider is infrastructure — in a
    ///         real deployment `aifm` is the timelock, not an operations key.
    ///         ⚠️ Deliberately does NOT re-read NAV. The new oracle may hold a different
    ///         figure, and adopting it silently inside an administrative call would move
    ///         every ratio in this contract without a valuation event. Call `syncNav()`
    ///         after, which fails closed if the new feed is not fresh.
    function setOracle(address oracle_) external onlyAifm {
        if (oracle_ == address(0)) revert ZeroAddress();
        emit OracleChanged(address(oracle), oracle_);
        oracle = ValuationOracle(oracle_);
    }

    /// @dev Applied to every path that draws leverage, opens exposure, or moves capital.
    ///      Deliberately NOT applied to the passive rechecks: a stale feed must not be able
    ///      to suppress a breach flag that is already visible on the last known figure.
    modifier freshNav() {
        if (!oracle.isFresh(navFeedId)) revert StaleValuation(navFeedId);
        _;
    }

    /// @dev The asymmetry the numerator paths need. Drawing leverage on an unverifiable
    ///      denominator is the thing to stop; REPAYING on one is not. Deleveraging can only
    ///      move every ratio in this contract downward whatever the true NAV is, so blocking
    ///      it on a stale feed would trap a fund in breach precisely when the feed is down —
    ///      the one moment it most needs to be able to act.
    function _requireFreshNavIfIncreasing(int256 delta) internal view {
        if (delta > 0 && !oracle.isFresh(navFeedId)) revert StaleValuation(navFeedId);
    }

    constructor(
        address aifm_,
        address subscriptionAgent_,
        address regulator_,
        address oracle_,
        bytes32 navFeedId_,
        FundType fundType_
    ) {
        aifm = aifm_;
        subscriptionAgent = subscriptionAgent_;
        regulator = regulator_;
        oracle = ValuationOracle(oracle_);
        navFeedId = navFeedId_;
        fundType = fundType_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // DENOMINATOR — moves on subscription/redemption only. Numerators do NOT move here.
    // Passive path: subscriptions/redemptions move NAV without anyone drawing
    // or repaying a loan, so a breach here is never reverted — only flagged.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param cashAmount  The CASH consideration received, in NAV's reference currency —
    ///                    NOT the number of shares minted. Those are only the same number
    ///                    if 1 share is pegged to a fixed $1 of NAV forever; UCITS/ELTIF
    ///                    units float with NAV/share, so passing the raw token quantity
    ///                    here would silently corrupt NAV on every subscription. Only
    ///                    `subscriptionAgent` — whatever priced this subscription at the
    ///                    day's NAV/share — has this number; the bare token contract does not.
    function onMint(uint256 cashAmount) external onlySubscriptionAgent freshNav {
        cashSinceValuation += int256(cashAmount);
        _recheckAll();
    }

    /// @param cashAmount  The CASH consideration paid out, in NAV's reference currency —
    ///                    NOT the number of shares burned. See `onMint`.
    function onBurn(uint256 cashAmount) external onlySubscriptionAgent freshNav {
        cashSinceValuation -= int256(cashAmount);
        _recheckAll();
    }

    /// @notice Pull the current NAV from the oracle. This is the price-driven path: every
    ///         ratio here is borrowing-or-exposure OVER NAV, so a pure NAV drop from a
    ///         falling asset price raises every leverage ratio without anyone drawing a
    ///         loan — that case has to be reachable independently of onMint/onBurn.
    /// @dev    Permissionless on purpose. The figure it pulls is already guarded by the
    ///         oracle's own sources, quorum and deviation band, so there is nothing left
    ///         for a role check here to protect — and gating it would hand whoever holds
    ///         that role the power to suppress a breach by simply not calling. Anyone who
    ///         can see the fund is over a limit can make this contract see it too.
    function syncNav() external {
        uint256 published = oracle.value(navFeedId); // reverts on stale/halted — fail closed
        int256 absorbed = cashSinceValuation;
        navAtValuation = published;
        cashSinceValuation = 0;
        emit NavSynced(published, absorbed, uint64(block.timestamp));
        _recheckAll();
    }

    function _recheckAll() internal {
        if (fundType == FundType.EltifRetail || fundType == FundType.EltifProfessional) {
            _checkCeiling(keccak256("BORROWING"), totalBorrowing, _eltifCeiling(), false);
        } else if (fundType == FundType.Ucits) {
            _checkCeiling(keccak256("UCITS_BUCKET_A"), ucitsBucketA, UCITS_BUCKET_CEILING_BPS, false);
            _checkCeiling(keccak256("UCITS_BUCKET_B"), ucitsBucketB, UCITS_BUCKET_CEILING_BPS, false);
            _checkCeiling(
                keccak256("UCITS_COMBINED"),
                ucitsBucketA + ucitsBucketB,
                UCITS_COMBINED_CEILING_BPS,
                false
            );
        } else {
            _checkCeiling(keccak256("LOF_LEVERAGE"), totalBorrowing, _lofCeiling(), false);
            _checkCeiling(keccak256("LOF_CARVEOUT"), lofCarveoutAmount, LOF_CARVEOUT_CEILING_BPS, false);
        }
        _checkCeiling(keccak256("DERIVATIVE_EXPOSURE"), derivativeExposure, DERIVATIVE_GLOBAL_EXPOSURE_BPS, false);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // NUMERATORS — move when the AIFM draws/repays a loan or opens/closes a
    // derivative position. This is the "active" path: if THIS call pushes the
    // relevant ceiling over, revert. Repaying/reducing is always allowed even
    // while a bucket is already in breach.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param delta  Positive = draw down, negative = repay.
    function recordEltifBorrowing(int256 delta) external onlyAifm {
        if (fundType != FundType.EltifRetail && fundType != FundType.EltifProfessional) revert WrongFundType();
        _requireFreshNavIfIncreasing(delta);
        totalBorrowing = _applyDelta(totalBorrowing, delta);
        _checkCeiling(keccak256("BORROWING"), totalBorrowing, _eltifCeiling(), delta > 0);
    }

    /// @param bucketA true = first 10% bucket, false = second 10% bucket.
    /// @param delta   Positive = draw down, negative = repay.
    function recordUcitsBorrowing(bool bucketA, int256 delta) external onlyAifm {
        if (fundType != FundType.Ucits) revert WrongFundType();
        _requireFreshNavIfIncreasing(delta);
        bool worsening = delta > 0;

        if (bucketA) {
            ucitsBucketA = _applyDelta(ucitsBucketA, delta);
            _checkCeiling(keccak256("UCITS_BUCKET_A"), ucitsBucketA, UCITS_BUCKET_CEILING_BPS, worsening);
        } else {
            ucitsBucketB = _applyDelta(ucitsBucketB, delta);
            _checkCeiling(keccak256("UCITS_BUCKET_B"), ucitsBucketB, UCITS_BUCKET_CEILING_BPS, worsening);
        }
        _checkCeiling(
            keccak256("UCITS_COMBINED"),
            ucitsBucketA + ucitsBucketB,
            UCITS_COMBINED_CEILING_BPS,
            worsening
        );
    }

    /// @param delta  Positive = increase global exposure, negative = decrease.
    function recordDerivativeExposure(int256 delta) external onlyAifm {
        _requireFreshNavIfIncreasing(delta);
        derivativeExposure = _applyDelta(derivativeExposure, delta);
        _checkCeiling(
            keccak256("DERIVATIVE_EXPOSURE"),
            derivativeExposure,
            DERIVATIVE_GLOBAL_EXPOSURE_BPS,
            delta > 0
        );
    }

    /// @param delta  Positive = draw down, negative = repay. Counts toward the LOF leverage cap.
    function recordLofBorrowing(int256 delta) external onlyAifm {
        if (fundType != FundType.LofOpenEnded && fundType != FundType.LofClosedEnded) revert WrongFundType();
        _requireFreshNavIfIncreasing(delta);
        totalBorrowing = _applyDelta(totalBorrowing, delta);
        _checkCeiling(keccak256("LOF_LEVERAGE"), totalBorrowing, _lofCeiling(), delta > 0);
    }

    /// @param delta  Positive = draw down, negative = repay. A carve-out loan (e.g. shareholder
    ///               loan) that does NOT count toward the leverage ratio above — but is itself
    ///               capped at 150% of NAV; beyond that it would need to be booked as ordinary
    ///               borrowing instead (not modelled here — reverts on this call's own cap).
    function recordLofCarveoutLoan(int256 delta) external onlyAifm {
        if (fundType != FundType.LofOpenEnded && fundType != FundType.LofClosedEnded) revert WrongFundType();
        _requireFreshNavIfIncreasing(delta);
        lofCarveoutAmount = _applyDelta(lofCarveoutAmount, delta);
        _checkCeiling(keccak256("LOF_CARVEOUT"), lofCarveoutAmount, LOF_CARVEOUT_CEILING_BPS, delta > 0);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CEILING CHECK — effective ceiling is min(statutory cap, regulator cap).
    // ═══════════════════════════════════════════════════════════════════════

    function _checkCeiling(bytes32 bucket, uint256 numerator, uint256 statutoryCeilingBps, bool causedByThisCall)
        internal
    {
        uint256 navNow = nav();
        if (navNow == 0) return;

        uint256 effectiveCeilingBps = statutoryCeilingBps < regulatorCeilingBps
            ? statutoryCeilingBps
            : regulatorCeilingBps;

        uint256 ratioBps = (numerator * BPS_DENOM) / navNow;
        bool isBreached = ratioBps > effectiveCeilingBps;

        // Active breach: this call moved the ratio, it's over, and suspension isn't covering it.
        if (isBreached && causedByThisCall && !_suspensionCovers()) {
            revert ActiveBreach(bucket, ratioBps, effectiveCeilingBps);
        }

        BreachState storage b = breach[bucket];
        if (isBreached && !b.active) {
            b.active = true;
            b.startedAt = uint64(block.timestamp);
            emit BreachStarted(bucket, ratioBps, effectiveCeilingBps);
        } else if (!isBreached && b.active) {
            b.active = false;
            b.startedAt = 0;
            emit BreachCleared(bucket);
        }

        if (!isBreached && effectiveCeilingBps != type(uint256).max &&
            ratioBps >= (effectiveCeilingBps * ALERT_BPS) / BPS_DENOM) {
            emit ThresholdAlert(bucket, ratioBps, effectiveCeilingBps);
        }
    }

    function _eltifCeiling() internal view returns (uint256) {
        return fundType == FundType.EltifRetail ? ELTIF_RETAIL_BORROW_BPS : ELTIF_PROFESSIONAL_BORROW_BPS;
    }

    function _lofCeiling() internal view returns (uint256) {
        return fundType == FundType.LofOpenEnded ? LOF_OPEN_LEVERAGE_BPS : LOF_CLOSED_LEVERAGE_BPS;
    }

    function _applyDelta(uint256 current, int256 delta) internal pure returns (uint256) {
        if (delta >= 0) return current + uint256(delta);
        uint256 dec = uint256(-delta);
        return dec > current ? 0 : current - dec;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 25 — regulator may tighten the effective ceiling post-deployment.
    // One-directional by construction: can only ever move the value down.
    // ═══════════════════════════════════════════════════════════════════════

    function setRegulatorCeiling(uint256 newCeilingBps) external onlyRegulator {
        if (newCeilingBps >= regulatorCeilingBps) revert CeilingCanOnlyTighten();
        uint256 old = regulatorCeilingBps;
        regulatorCeilingBps = newCeilingBps;
        emit RegulatorCeilingUpdated(old, newCeilingBps);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 16(3)-(4) SUSPENSION — capital raise/reduction window. While active,
    // an active-breach revert is suppressed (flagged instead), but only until
    // the hard expiry — this is not an indefinite escape hatch.
    // ═══════════════════════════════════════════════════════════════════════

    function activateSuspension() external onlyAifm {
        if (suspended) revert SuspensionAlreadyActive();
        suspended = true;
        suspensionStartedAt = uint64(block.timestamp);
        emit SuspensionActivated(suspensionStartedAt);
    }

    function liftSuspension() external onlyAifm {
        suspended = false;
        suspensionStartedAt = 0;
        emit SuspensionLifted(uint64(block.timestamp));
    }

    function _suspensionCovers() internal returns (bool) {
        if (!suspended) return false;
        if (block.timestamp > suspensionStartedAt + SUSPENSION_MAX_DURATION) {
            // Hard expiry — auto-lift, do not silently keep covering.
            suspended = false;
            suspensionStartedAt = 0;
            emit SuspensionLifted(uint64(block.timestamp));
            return false;
        }
        return true;
    }
}
