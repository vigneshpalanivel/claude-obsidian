// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title NavBorrowingCap (illustrative sample — not production code)
/// @notice Tracks borrowing/leverage against a running NAV denominator, for whichever
///         fund type this instance is deployed for, and enforces the active/passive
///         breach split plus the Art 16(3)-(4) suspension window.
/// @dev    One deployment = one fund = one FundType. The four regimes are mutually
///         exclusive by construction, not by branching on caller intent at call time.
///         NAV is mark-to-market — it moves from subscriptions/redemptions AND from the
///         market price of held assets changing with no trade at all. `recordNavValuation`
///         is the price-driven path (passive); onMint/onBurn alone cannot produce it.
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
    address public immutable valuator; // price/valuation feed — marks NAV to market

    FundType public immutable fundType;

    // ─────────────────────────── denominator ────────────────────────────────

    uint256 public nav;

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

    // ─────────────────────────── errors ──────────────────────────────────────

    error ActiveBreach(bytes32 bucket, uint256 ratioBps, uint256 limitBps);
    error NotAifm();
    error NotSubscriptionAgent();
    error NotRegulator();
    error NotValuator();
    error WrongFundType();
    error CeilingCanOnlyTighten();
    error SuspensionAlreadyActive();

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

    modifier onlyValuator() {
        if (msg.sender != valuator) revert NotValuator();
        _;
    }

    constructor(address aifm_, address subscriptionAgent_, address regulator_, address valuator_, FundType fundType_) {
        aifm = aifm_;
        subscriptionAgent = subscriptionAgent_;
        regulator = regulator_;
        valuator = valuator_;
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
    function onMint(uint256 cashAmount) external onlySubscriptionAgent {
        nav += cashAmount;
        _recheckAll();
    }

    /// @param cashAmount  The CASH consideration paid out, in NAV's reference currency —
    ///                    NOT the number of shares burned. See `onMint`.
    function onBurn(uint256 cashAmount) external onlySubscriptionAgent {
        nav -= cashAmount;
        _recheckAll();
    }

    /// @notice NAV revaluation from price movement alone — no subscription/redemption
    ///         and no new borrowing/derivative position. Every ratio here is
    ///         borrowing-or-exposure OVER NAV, so a pure NAV drop from a falling asset
    ///         price raises every leverage ratio without anyone drawing a loan — that
    ///         case has to be reachable independently of onMint/onBurn.
    /// @param  delta  Positive = holdings revalued up, negative = revalued down.
    function recordNavValuation(int256 delta) external onlyValuator {
        nav = _applyDelta(nav, delta);
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
        totalBorrowing = _applyDelta(totalBorrowing, delta);
        _checkCeiling(keccak256("BORROWING"), totalBorrowing, _eltifCeiling(), delta > 0);
    }

    /// @param bucketA true = first 10% bucket, false = second 10% bucket.
    /// @param delta   Positive = draw down, negative = repay.
    function recordUcitsBorrowing(bool bucketA, int256 delta) external onlyAifm {
        if (fundType != FundType.Ucits) revert WrongFundType();
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
        totalBorrowing = _applyDelta(totalBorrowing, delta);
        _checkCeiling(keccak256("LOF_LEVERAGE"), totalBorrowing, _lofCeiling(), delta > 0);
    }

    /// @param delta  Positive = draw down, negative = repay. A carve-out loan (e.g. shareholder
    ///               loan) that does NOT count toward the leverage ratio above — but is itself
    ///               capped at 150% of NAV; beyond that it would need to be booked as ordinary
    ///               borrowing instead (not modelled here — reverts on this call's own cap).
    function recordLofCarveoutLoan(int256 delta) external onlyAifm {
        if (fundType != FundType.LofOpenEnded && fundType != FundType.LofClosedEnded) revert WrongFundType();
        lofCarveoutAmount = _applyDelta(lofCarveoutAmount, delta);
        _checkCeiling(keccak256("LOF_CARVEOUT"), lofCarveoutAmount, LOF_CARVEOUT_CEILING_BPS, delta > 0);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CEILING CHECK — effective ceiling is min(statutory cap, regulator cap).
    // ═══════════════════════════════════════════════════════════════════════

    function _checkCeiling(bytes32 bucket, uint256 numerator, uint256 statutoryCeilingBps, bool causedByThisCall)
        internal
    {
        if (nav == 0) return;

        uint256 effectiveCeilingBps = statutoryCeilingBps < regulatorCeilingBps
            ? statutoryCeilingBps
            : regulatorCeilingBps;

        uint256 ratioBps = (numerator * BPS_DENOM) / nav;
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
