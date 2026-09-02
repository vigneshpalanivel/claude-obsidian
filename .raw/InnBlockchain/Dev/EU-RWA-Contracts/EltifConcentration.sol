// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title EltifConcentration (illustrative sample — not production code)
/// @notice Tracks ELTIF Art 13 concentration limits against a running capital
///         denominator and per-bucket numerators, and enforces the active/passive
///         breach split plus the Art 17(1)(c) suspension window.
contract EltifConcentration {
    // ─────────────────────────── ceilings (basis points, 10000 = 100%) ─────────

    uint256 public constant ELIGIBLE_FLOOR_BPS = 5500; // Art 13(1) — floor, not ceiling
    uint256 public constant PER_ASSET_CEILING_BPS = 2000; // Art 13(2)
    uint256 public constant STS_CEILING_BPS = 2000; // Art 13(3)
    uint256 public constant OTC_REPO_CEILING_BPS = 1000; // Art 13(4) — aggregate
    uint256 public constant CROSS_HOLDING_CEILING_BPS = 3000; // Art 13(5)
    uint256 public constant ALERT_BPS = 9000; // 90% of the limit's distance
    uint256 public constant BPS_DENOM = 10000;

    uint256 public constant SUSPENSION_MAX_DURATION = 365 days; // Art 17(1)(c) ~12 months

    // ─────────────────────────── roles (wire up to real access control) ────────

    address public immutable aifm; // executes/reports asset trades and valuations
    address public immutable token; // the fund token — only it can call onMint/onBurn

    // ─────────────────────────── denominator ────────────────────────────────

    uint256 public totalCapital;

    // ─────────────────────────── numerators ─────────────────────────────────

    mapping(bytes32 => uint256) public assetValue; // per-asset, for the 20% per-asset check
    uint256 public eligibleLongTermValue; // Art 13(1) numerator
    uint256 public stsValue; // Art 13(3) numerator
    uint256 public otcRepoReverseRepoValue; // Art 13(4) numerator — aggregate of 3 legs
    uint256 public crossHoldingValue; // Art 13(5) numerator

    // ─────────────────────────── breach state ───────────────────────────────

    struct BreachState {
        bool active;
        uint64 startedAt;
    }

    // bucket id => breach state. Buckets: keccak256("ELIGIBLE_FLOOR"), keccak256("STS"),
    // keccak256("OTC_REPO"), keccak256("CROSS_HOLDING"), or the assetId itself for per-asset.
    mapping(bytes32 => BreachState) public breach;

    // ─────────────────────────── suspension (Art 17(1)(c)) ──────────────────

    bool public suspended;
    uint64 public suspensionStartedAt;

    // ─────────────────────────── events ─────────────────────────────────────

    event BreachStarted(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event BreachCleared(bytes32 indexed bucket);
    event ThresholdAlert(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event SuspensionActivated(uint64 startedAt);
    event SuspensionLifted(uint64 endedAt);

    // ─────────────────────────── errors ──────────────────────────────────────

    error ActiveBreach(bytes32 bucket, uint256 ratioBps, uint256 limitBps);
    error NotAifm();
    error NotToken();
    error SuspensionAlreadyActive();
    error SuspensionExpired();

    modifier onlyAifm() {
        if (msg.sender != aifm) revert NotAifm();
        _;
    }

    modifier onlyToken() {
        if (msg.sender != token) revert NotToken();
        _;
    }

    constructor(address aifm_, address token_) {
        aifm = aifm_;
        token = token_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // DENOMINATOR — moves on mint/burn only. Numerators do NOT move here.
    // This is the "passive" path: subscriptions/redemptions are an investor
    // action, not an AIFM trade decision, so a breach caused purely by
    // capital moving is never reverted — only flagged.
    // ═══════════════════════════════════════════════════════════════════════

    function onMint(uint256 amount) external onlyToken {
        totalCapital += amount;
        _recheckAll();
    }

    function onBurn(uint256 amount) external onlyToken {
        totalCapital -= amount;
        _recheckAll();
    }

    // ═══════════════════════════════════════════════════════════════════════
    // NUMERATORS — move when the AIFM trades/reclassifies an asset. This is
    // the "active" path: if THIS trade pushes a bucket over its ceiling, or
    // pulls the eligible floor further below 55%, revert. Reducing exposure
    // is always allowed even while a bucket is already in breach.
    // ═══════════════════════════════════════════════════════════════════════

    function recordAssetTrade(
        bytes32 assetId,
        bool isEligibleLongTerm,
        bool isSts,
        bool isOtcRepoOrReverseRepo,
        bool isCrossHolding,
        int256 delta // positive = buy/increase, negative = sell/decrease
    ) external onlyAifm {
        assetValue[assetId] = _applyDelta(assetValue[assetId], delta);

        if (isEligibleLongTerm) {
            eligibleLongTermValue = _applyDelta(eligibleLongTermValue, delta);
        }
        if (isSts) {
            stsValue = _applyDelta(stsValue, delta);
        }
        if (isOtcRepoOrReverseRepo) {
            otcRepoReverseRepoValue = _applyDelta(otcRepoReverseRepoValue, delta);
        }
        if (isCrossHolding) {
            crossHoldingValue = _applyDelta(crossHoldingValue, delta);
        }

        bool worsening = delta > 0; // buying is what can push a ceiling over

        // Per-asset ceiling — keyed by the asset itself.
        _checkCeiling(assetId, assetValue[assetId], PER_ASSET_CEILING_BPS, worsening);

        if (isEligibleLongTerm) {
            // A floor: "worsening" here means the trade reduced eligible exposure.
            _checkFloor(keccak256("ELIGIBLE_FLOOR"), eligibleLongTermValue, ELIGIBLE_FLOOR_BPS, delta < 0);
        }
        if (isSts) {
            _checkCeiling(keccak256("STS"), stsValue, STS_CEILING_BPS, worsening);
        }
        if (isOtcRepoOrReverseRepo) {
            _checkCeiling(keccak256("OTC_REPO"), otcRepoReverseRepoValue, OTC_REPO_CEILING_BPS, worsening);
        }
        if (isCrossHolding) {
            _checkCeiling(keccak256("CROSS_HOLDING"), crossHoldingValue, CROSS_HOLDING_CEILING_BPS, worsening);
        }
    }

    // Passive re-check after mint/burn — never reverts, only flags/clears/alerts.
    function _recheckAll() internal {
        _checkCeiling(keccak256("STS"), stsValue, STS_CEILING_BPS, false);
        _checkCeiling(keccak256("OTC_REPO"), otcRepoReverseRepoValue, OTC_REPO_CEILING_BPS, false);
        _checkCeiling(keccak256("CROSS_HOLDING"), crossHoldingValue, CROSS_HOLDING_CEILING_BPS, false);
        _checkFloor(keccak256("ELIGIBLE_FLOOR"), eligibleLongTermValue, ELIGIBLE_FLOOR_BPS, false);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CEILING / FLOOR CHECKS
    // ═══════════════════════════════════════════════════════════════════════

    function _checkCeiling(bytes32 bucket, uint256 numerator, uint256 ceilingBps, bool causedByThisCall) internal {
        if (totalCapital == 0) return;

        uint256 ratioBps = (numerator * BPS_DENOM) / totalCapital;
        bool isBreached = ratioBps > ceilingBps;

        // Active breach: this call moved the ratio, it's over, and suspension isn't covering it.
        if (isBreached && causedByThisCall && !_suspensionCovers()) {
            revert ActiveBreach(bucket, ratioBps, ceilingBps);
        }

        _updateBreachState(bucket, isBreached, ratioBps, ceilingBps);

        if (!isBreached && ratioBps >= (ceilingBps * ALERT_BPS) / BPS_DENOM) {
            emit ThresholdAlert(bucket, ratioBps, ceilingBps);
        }
    }

    function _checkFloor(bytes32 bucket, uint256 numerator, uint256 floorBps, bool causedByThisCall) internal {
        if (totalCapital == 0) return;

        uint256 ratioBps = (numerator * BPS_DENOM) / totalCapital;
        bool isBreached = ratioBps < floorBps;

        if (isBreached && causedByThisCall && !_suspensionCovers()) {
            revert ActiveBreach(bucket, ratioBps, floorBps);
        }

        _updateBreachState(bucket, isBreached, ratioBps, floorBps);

        // Alert when drifting down toward the floor, before actually breaching it.
        uint256 alertThreshold = floorBps + ((floorBps * (BPS_DENOM - ALERT_BPS)) / BPS_DENOM);
        if (!isBreached && ratioBps <= alertThreshold) {
            emit ThresholdAlert(bucket, ratioBps, floorBps);
        }
    }

    function _updateBreachState(bytes32 bucket, bool isBreached, uint256 ratioBps, uint256 limitBps) internal {
        BreachState storage b = breach[bucket];
        if (isBreached && !b.active) {
            b.active = true;
            b.startedAt = uint64(block.timestamp);
            emit BreachStarted(bucket, ratioBps, limitBps);
        } else if (!isBreached && b.active) {
            b.active = false;
            b.startedAt = 0;
            emit BreachCleared(bucket);
        }
    }

    function _applyDelta(uint256 current, int256 delta) internal pure returns (uint256) {
        if (delta >= 0) return current + uint256(delta);
        uint256 dec = uint256(-delta);
        return dec > current ? 0 : current - dec;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 17(1)(c) SUSPENSION — capital raise/reduction window. While active,
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
