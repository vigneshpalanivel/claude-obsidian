// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title UcitsFiveTenForty (illustrative sample — not production code)
/// @notice Tracks UCITS Art 52 concentration limits against a running NAV
///         denominator and per-bucket numerators, and enforces the active/passive
///         breach split plus the Art 56 ramp-up window.
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
    address public immutable token; // the fund token — only it can call onMint/onBurn

    // ─────────────────────────── denominator ────────────────────────────────

    uint256 public nav;
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

    // ─────────────────────────── errors ──────────────────────────────────────

    error ActiveBreach(bytes32 bucket, uint256 ratioBps, uint256 limitBps);
    error NotManco();
    error NotToken();

    modifier onlyManco() {
        if (msg.sender != manco) revert NotManco();
        _;
    }

    modifier onlyToken() {
        if (msg.sender != token) revert NotToken();
        _;
    }

    constructor(address manco_, address token_) {
        manco = manco_;
        token = token_;
        deployedAt = uint64(block.timestamp);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // DENOMINATOR — moves on mint/burn only. Numerators do NOT move here.
    // Passive path: subscriptions/redemptions dilute or concentrate every
    // ratio without anyone trading a security, so a breach here is never
    // reverted — only flagged.
    // ═══════════════════════════════════════════════════════════════════════

    function onMint(uint256 amount) external onlyToken {
        nav += amount;
        _recheckAll();
    }

    function onBurn(uint256 amount) external onlyToken {
        nav -= amount;
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
        bool worsening = delta > 0;

        if (legType == LegType.Issuer) {
            uint256 before = issuerValue[legId];
            uint256 after_ = _applyDelta(before, delta);
            issuerValue[legId] = after_;

            // Track the 5-10% band aggregate incrementally as issuers cross the 5% line.
            uint256 threshold = (ISSUER_SOFT_CAP_BPS * nav) / BPS_DENOM;
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
            isCreditInstitution[legId] = counterpartyIsCreditInstitution;
            derivativeValue[legId] = _applyDelta(derivativeValue[legId], delta);
            uint256 cap = counterpartyIsCreditInstitution
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
        if (nav == 0) return;

        uint256 ratioBps = (numerator * BPS_DENOM) / nav;
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
