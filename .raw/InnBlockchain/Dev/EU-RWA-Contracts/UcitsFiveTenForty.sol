// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ValuationOracle} from "./ValuationOracle.sol";

/// @title UcitsFiveTenForty (illustrative sample — not production code)
/// @notice Tracks UCITS Art 52 concentration limits against a running NAV
///         denominator and per-bucket numerators, and enforces the active/passive
///         breach split plus the Art 56 ramp-up window.
/// @dev    NAV is mark-to-market by definition, not just a mint/burn ledger — it moves
///         from subscriptions/redemptions AND from the market price of what's already
///         held changing with no trade at all. `syncNav` and `syncLegValuation` are the
///         price-driven paths (passive); Art 49(2) names market movement explicitly as a
///         passive-breach trigger, so this isn't optional.
/// @dev    ⚠️ BOTH SIDES OF EVERY RATIO ARE ORACLE-FED, AND BOTH ARE ABSOLUTE. NAV is the
///         denominator of all seven limits here and the per-leg market values are the
///         numerators, so a feed failure corrupts the check from either direction. Earlier
///         revisions took both as `int256 delta` from a privileged valuator — a design in
///         which one dropped message leaves the book permanently and undetectably wrong.
///         The sync paths below read absolute figures and compute the delta themselves.
/// @dev    ⚠️ FAIL-CLOSED ON ACQUISITION, FAIL-OPEN ON DISPOSAL. Buying into a bucket on a
///         NAV nobody can vouch for is the harm; SELLING out of one on the same NAV is the
///         remedy, and can only move every ratio here downward. Blocking disposals on a
///         stale feed would trap the fund in breach exactly when the feed is down.
contract UcitsFiveTenForty {
    // ─────────────────────────── ceilings (basis points, 10000 = 100%) ─────────

    uint256 public constant ISSUER_HARD_CAP_BPS = 1000; // 10% per issuer
    uint256 public constant ISSUER_SOFT_CAP_BPS = 500; // 5% — above this, counts toward the 40% band
    uint256 public constant ISSUER_BAND_AGGREGATE_BPS = 4000; // 40% aggregate of issuers held >5%

    uint256 public constant BANK_DEPOSIT_CEILING_BPS = 2000; // 20% per bank
    uint256 public constant DERIVATIVE_COUNTERPARTY_CEILING_BPS = 500; // 5%
    uint256 public constant DERIVATIVE_COUNTERPARTY_CREDIT_INST_CEILING_BPS = 1000; // 10% if credit institution
    uint256 public constant COMBINED_SINGLE_ENTITY_CEILING_BPS = 2000; // 20% combined, all legs

    uint256 public constant FOF_PER_FUND_CEILING_BPS = 1000; // 10% per fund
    uint256 public constant FOF_NON_UCITS_AGGREGATE_CEILING_BPS = 3000; // 30% aggregate, non-UCITS CIUs

    uint256 public constant ALERT_BPS = 9000; // 90% of the limit's distance
    uint256 public constant BPS_DENOM = 10000;

    uint256 public constant RAMP_UP_DURATION = 180 days; // Art 56 — ~6 months, hard expiry

    enum LegType {
        Issuer,
        BankDeposit,
        DerivativeCounterparty,
        FundOfFunds
    }

    // ─────────────────────────── roles (wire up to real access control) ────────

    address public immutable manco; // management company — reports holding changes
    address public immutable subscriptionAgent; // prices subscriptions/redemptions — knows CASH amounts, not share counts

    ValuationOracle public immutable oracle; // marks NAV and holdings to market — absolute, never delta
    bytes32 public immutable navFeedId; // this fund's NAV identity in the oracle

    // ─────────────────────────── denominator ────────────────────────────────

    /// @notice The last absolute NAV the oracle published, plus the cash that has moved
    ///         since. Two components rather than one running total, because they fail
    ///         differently: the oracle figure carries a timestamp and can go stale, while
    ///         subscription cash is known exactly and needs no feed.
    uint256 public navAtValuation;

    /// @notice Net cash in (positive) or out (negative) since `navAtValuation` was set.
    ///         Reset to zero on every sync — the next published NAV already contains it.
    int256 public cashSinceValuation;

    /// @notice The denominator all seven limits in this contract divide by.
    function nav() public view returns (uint256) {
        return _applyDelta(navAtValuation, cashSinceValuation);
    }

    uint64 public immutable deployedAt;

    // ─────────────────────────── numerators ─────────────────────────────────

    mapping(bytes32 => uint256) public issuerValue; // 5/10 per-issuer, keyed by issuerId
    uint256 public issuerBandAggregateValue; // sum of issuers currently held >5%, for the 40% check

    mapping(bytes32 => uint256) public depositValue; // per-bank deposits, keyed by bankId
    mapping(bytes32 => uint256) public derivativeValue; // per-counterparty, keyed by counterpartyId
    mapping(bytes32 => bool) public isCreditInstitution; // ManCo-fed classification per counterparty

    mapping(bytes32 => uint256) public combinedEntityValue; // securities+deposit+derivative, per entityId

    mapping(bytes32 => uint256) public fundOfFundsValue; // per underlying fund, keyed by fundId
    uint256 public nonUcitsAggregateValue; // aggregate of non-UCITS CIU holdings

    // ─────────────────────────── breach state ───────────────────────────────

    struct BreachState {
        bool active;
        uint64 startedAt;
    }

    // bucket id => breach state. Buckets: the specific issuerId/bankId/counterpartyId/fundId,
    // entityId for combined, or keccak256("ISSUER_BAND")/keccak256("FOF_NON_UCITS") for aggregates.
    mapping(bytes32 => BreachState) public breach;

    // ─────────────────────────── events ─────────────────────────────────────

    event BreachStarted(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event BreachCleared(bytes32 indexed bucket);
    event ThresholdAlert(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event NavSynced(uint256 navAtValuation, int256 cashAbsorbed, uint64 at);
    event LegValuationSynced(bytes32 indexed legId, uint256 previousValue, uint256 newValue, uint64 at);

    // ─────────────────────────── errors ──────────────────────────────────────

    error ActiveBreach(bytes32 bucket, uint256 ratioBps, uint256 limitBps);
    error NotManco();
    error NotSubscriptionAgent();
    /// @dev The NAV feed, or the traded leg's own feed, is not current — so no ratio
    ///      computed here can be trusted. §5: "oracle failure must HALT issuance/
    ///      redemption, not pass a stale limit."
    error StaleValuation(bytes32 feedId);

    modifier onlyManco() {
        if (msg.sender != manco) revert NotManco();
        _;
    }

    modifier onlySubscriptionAgent() {
        if (msg.sender != subscriptionAgent) revert NotSubscriptionAgent();
        _;
    }

    modifier freshNav() {
        if (!oracle.isFresh(navFeedId)) revert StaleValuation(navFeedId);
        _;
    }

    /// @dev The asymmetry every numerator path needs. Acquiring on an unverifiable
    ///      denominator is the thing to stop; DISPOSING on one is not — a sale can only
    ///      move every ratio here downward whatever the true NAV is.
    function _requireFreshNavIfIncreasing(int256 delta) internal view {
        if (delta > 0 && !oracle.isFresh(navFeedId)) revert StaleValuation(navFeedId);
    }

    constructor(address manco_, address subscriptionAgent_, address oracle_, bytes32 navFeedId_) {
        manco = manco_;
        subscriptionAgent = subscriptionAgent_;
        oracle = ValuationOracle(oracle_);
        navFeedId = navFeedId_;
        deployedAt = uint64(block.timestamp);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // DENOMINATOR — moves on mint/burn only. Numerators do NOT move here.
    // Passive path: subscriptions/redemptions dilute or concentrate every
    // ratio without anyone trading a security, so a breach here is never
    // reverted — only flagged.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param cashAmount  The CASH consideration received, in NAV's reference currency —
    ///                    NOT the number of shares minted. UCITS units float with
    ///                    NAV/share, so those are different numbers; passing the raw
    ///                    token quantity here would silently corrupt NAV on every
    ///                    subscription. Only `subscriptionAgent` — whatever priced this
    ///                    subscription at the day's NAV/share — has this number.
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

    /// @notice NAV revaluation from price movement alone — no subscription/redemption
    ///         and no trade. This is the trigger Art 49(2) names explicitly ("breached
    ///         due to market movements"); onMint/onBurn cannot produce it, since they
    ///         only fire on capital moving, not on a held security's price moving.
    /// @dev    Permissionless on purpose. The figure it pulls is already guarded by the
    ///         oracle's own sources, quorum and deviation band, so a role check here would
    ///         protect nothing and would hand whoever holds that role the power to suppress
    ///         an Art 49(2) passive breach by simply not calling.
    function syncNav() external {
        uint256 published = oracle.value(navFeedId); // reverts on stale/halted — fail closed
        int256 absorbed = cashSinceValuation;
        navAtValuation = published;
        cashSinceValuation = 0;
        emit NavSynced(published, absorbed, uint64(block.timestamp));
        _recheckAll();
    }

    // ═══════════════════════════════════════════════════════════════════════
    // NUMERATORS — move when the ManCo trades/reclassifies a holding. This is
    // the "active" path: if THIS trade pushes a bucket over its ceiling,
    // revert. Reducing exposure is always allowed even mid-breach.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param legId       Issuer / bank / counterparty / fund identifier for this leg.
    /// @param legType     Which of the four leg categories this update belongs to.
    /// @param entityId    The single-entity grouping this leg rolls up into, for the 20%
    ///                    combined check (e.g. an issuer and its affiliate bank share an entityId).
    /// @param delta       Positive = buy/increase, negative = sell/decrease.
    /// @param counterpartyIsCreditInstitution  Only meaningful for LegType.DerivativeCounterparty.
    /// @param isNonUcits  Only meaningful for LegType.FundOfFunds.
    function recordHoldingUpdate(
        bytes32 legId,
        LegType legType,
        bytes32 entityId,
        int256 delta,
        bool counterpartyIsCreditInstitution,
        bool isNonUcits
    ) external onlyManco {
        _requireFreshNavIfIncreasing(delta);
        if (legType == LegType.DerivativeCounterparty) {
            isCreditInstitution[legId] = counterpartyIsCreditInstitution;
        }
        _applyLegDelta(legId, legType, entityId, delta, isNonUcits, true);
    }

    /// @notice Mark-to-market revaluation of a holding already on the books — no trade
    ///         occurred, only its price moved. Passive by construction: never reverts,
    ///         only flags/clears/alerts. Counterparty credit-institution status isn't
    ///         re-supplied here — it's a classification set at trade time, not something
    ///         a price move can change.
    /// @notice Pull this leg's current market value from the oracle and book the difference.
    ///         Passive by construction: never reverts on a breach, only flags/clears/alerts.
    ///         Counterparty credit-institution status isn't re-supplied here — it's a
    ///         classification set at trade time, not something a price move can change.
    /// @dev    The leg's own `legId` is its feed id in the oracle. The delta is derived here
    ///         rather than supplied by the caller, which is the whole point: a caller-supplied
    ///         delta that never arrives leaves this contract permanently wrong with nothing
    ///         on-chain to show it, while a missed absolute post just goes stale and says so.
    function syncLegValuation(
        bytes32 legId,
        LegType legType,
        bytes32 entityId,
        bool isNonUcits
    ) external {
        uint256 published = oracle.value(legId); // reverts on stale/halted — fail closed
        uint256 current = _currentLegValue(legId, legType);
        if (published == current) return;

        int256 delta = published > current
            ? int256(published - current)
            : -int256(current - published);

        _applyLegDelta(legId, legType, entityId, delta, isNonUcits, false);
        emit LegValuationSynced(legId, current, published, uint64(block.timestamp));
    }

    function _currentLegValue(bytes32 legId, LegType legType) internal view returns (uint256) {
        if (legType == LegType.Issuer) return issuerValue[legId];
        if (legType == LegType.BankDeposit) return depositValue[legId];
        if (legType == LegType.DerivativeCounterparty) return derivativeValue[legId];
        return fundOfFundsValue[legId];
    }

    /// @param active  True for a ManCo-directed trade (can revert on active breach);
    ///                false for a price-driven revaluation (never reverts).
    function _applyLegDelta(
        bytes32 legId,
        LegType legType,
        bytes32 entityId,
        int256 delta,
        bool isNonUcits,
        bool active
    ) internal {
        bool worsening = active && delta > 0;

        if (legType == LegType.Issuer) {
            uint256 before = issuerValue[legId];
            uint256 after_ = _applyDelta(before, delta);
            issuerValue[legId] = after_;

            // Track the 5-10% band aggregate incrementally as issuers cross the 5% line.
            uint256 threshold = (ISSUER_SOFT_CAP_BPS * nav()) / BPS_DENOM;
            bool wasOver = before > threshold;
            bool isOver = after_ > threshold;
            if (isOver && !wasOver) {
                issuerBandAggregateValue += after_;
            } else if (!isOver && wasOver) {
                issuerBandAggregateValue = issuerBandAggregateValue > before
                    ? issuerBandAggregateValue - before
                    : 0;
            } else if (isOver && wasOver) {
                issuerBandAggregateValue = _applyDelta(issuerBandAggregateValue, delta);
            }

            _checkCeiling(legId, after_, ISSUER_HARD_CAP_BPS, worsening);
            _checkCeiling(keccak256("ISSUER_BAND"), issuerBandAggregateValue, ISSUER_BAND_AGGREGATE_BPS, worsening);
            _rollUpCombined(entityId, delta, worsening);
        } else if (legType == LegType.BankDeposit) {
            depositValue[legId] = _applyDelta(depositValue[legId], delta);
            _checkCeiling(legId, depositValue[legId], BANK_DEPOSIT_CEILING_BPS, worsening);
            _rollUpCombined(entityId, delta, worsening);
        } else if (legType == LegType.DerivativeCounterparty) {
            derivativeValue[legId] = _applyDelta(derivativeValue[legId], delta);
            uint256 cap = isCreditInstitution[legId]
                ? DERIVATIVE_COUNTERPARTY_CREDIT_INST_CEILING_BPS
                : DERIVATIVE_COUNTERPARTY_CEILING_BPS;
            _checkCeiling(legId, derivativeValue[legId], cap, worsening);
            _rollUpCombined(entityId, delta, worsening);
        } else {
            // FundOfFunds — not part of the combined single-entity roll-up; it's a separate cap family.
            fundOfFundsValue[legId] = _applyDelta(fundOfFundsValue[legId], delta);
            _checkCeiling(legId, fundOfFundsValue[legId], FOF_PER_FUND_CEILING_BPS, worsening);
            if (isNonUcits) {
                nonUcitsAggregateValue = _applyDelta(nonUcitsAggregateValue, delta);
                _checkCeiling(
                    keccak256("FOF_NON_UCITS"),
                    nonUcitsAggregateValue,
                    FOF_NON_UCITS_AGGREGATE_CEILING_BPS,
                    worsening
                );
            }
        }
    }

    function _rollUpCombined(bytes32 entityId, int256 delta, bool worsening) internal {
        combinedEntityValue[entityId] = _applyDelta(combinedEntityValue[entityId], delta);
        _checkCeiling(entityId, combinedEntityValue[entityId], COMBINED_SINGLE_ENTITY_CEILING_BPS, worsening);
    }

    // Passive re-check after mint/burn — never reverts, only flags/clears/alerts.
    // Per-issuer/bank/counterparty/fund buckets aren't swept here (unbounded set);
    // in production, sweep the buckets actually holding a nonzero balance.
    function _recheckAll() internal {
        _checkCeiling(keccak256("ISSUER_BAND"), issuerBandAggregateValue, ISSUER_BAND_AGGREGATE_BPS, false);
        _checkCeiling(keccak256("FOF_NON_UCITS"), nonUcitsAggregateValue, FOF_NON_UCITS_AGGREGATE_CEILING_BPS, false);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CEILING CHECK
    // ═══════════════════════════════════════════════════════════════════════

    function _checkCeiling(bytes32 bucket, uint256 numerator, uint256 ceilingBps, bool causedByThisCall) internal {
        uint256 navNow = nav();
        if (navNow == 0) return;

        uint256 ratioBps = (numerator * BPS_DENOM) / navNow;
        bool isBreached = ratioBps > ceilingBps;

        // Active breach: this call moved the ratio, it's over, and the ramp-up window has expired.
        if (isBreached && causedByThisCall && !_rampUpCovers()) {
            revert ActiveBreach(bucket, ratioBps, ceilingBps);
        }

        BreachState storage b = breach[bucket];
        if (isBreached && !b.active) {
            b.active = true;
            b.startedAt = uint64(block.timestamp);
            emit BreachStarted(bucket, ratioBps, ceilingBps);
        } else if (!isBreached && b.active) {
            b.active = false;
            b.startedAt = 0;
            emit BreachCleared(bucket);
        }

        if (!isBreached && ratioBps >= (ceilingBps * ALERT_BPS) / BPS_DENOM) {
            emit ThresholdAlert(bucket, ratioBps, ceilingBps);
        }
    }

    function _applyDelta(uint256 current, int256 delta) internal pure returns (uint256) {
        if (delta >= 0) return current + uint256(delta);
        uint256 dec = uint256(-delta);
        return dec > current ? 0 : current - dec;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 56 RAMP-UP WINDOW — hard expiry, not renewable. Before it lapses,
    // an active-breach revert is suppressed (flagged instead).
    // ═══════════════════════════════════════════════════════════════════════

    function _rampUpCovers() internal view returns (bool) {
        return block.timestamp < deployedAt + RAMP_UP_DURATION;
    }
}
