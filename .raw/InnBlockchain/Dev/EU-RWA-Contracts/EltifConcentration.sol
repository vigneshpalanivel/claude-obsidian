// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ValuationOracle} from "./ValuationOracle.sol";

/// @title EltifConcentration (illustrative sample — not production code)
/// @notice Tracks ELTIF Art 13 concentration limits against a running capital
///         denominator and per-bucket numerators, and enforces the active/passive
///         breach split plus the Art 17(1)(c) suspension window.
/// @dev    Capital (the denominator) is contribution-based, not marked to market —
///         it moves on mint/burn only. The numerators DO need marking to market, since
///         they represent the current value of assets held; `syncAssetValuation` is the
///         price-driven path (passive), separate from `recordAssetTrade` (active).
/// @dev    ⚠️ THE ORACLE FEEDS THE NUMERATORS ONLY, AND THAT IS NOT AN OVERSIGHT. Art 2(8)
///         defines capital by contribution, so `totalCapital` is an exact figure this
///         contract already knows and no price feed can improve. That makes this the one
///         module in the fund set where subscription and redemption do NOT halt on oracle
///         failure — the denominator does not depend on a price. Copying §5's "halt
///         issuance on oracle failure" rule here mechanically would block subscriptions
///         for a feed the subscription path never reads.
/// @dev    ⚠️ VALUES ARE ABSOLUTE, NEVER DELTAS. An earlier revision took
///         `recordValuation(int256 delta)` from a privileged valuator. A missed delta is
///         permanent and undetectable — the book stays wrong forever with nothing on-chain
///         to show it — whereas a missed absolute post simply goes stale and says so.
/// @dev    ⚠️ YOU MAY NOT ACQUIRE AN ASSET THIS FUND CANNOT VALUE. `recordAssetTrade`
///         requires a fresh feed for the traded asset when the position is INCREASING, so
///         a new holding needs its feed configured and posted before the first purchase.
///         Disposals stay open on a stale feed: selling can only move every ceiling here
///         downward, and blocking it would trap the fund in breach exactly when the feed
///         is down.
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

    address public immutable aifm; // executes/reports asset trades
    address public immutable subscriptionAgent; // prices subscriptions/redemptions — knows CASH amounts, not unit counts

    /// @dev NOT immutable — DORA Art 28 requires the oracle stay "swappable at the contract
    ///      layer, not hard-wired"; a constructor-set immutable reference makes a provider
    ///      swap a redeploy of this module, which on a live fund is a re-issuance.
    ValuationOracle public oracle; // marks holdings to market — absolute, never delta

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
    event AssetValuationSynced(bytes32 indexed assetId, uint256 previousValue, uint256 newValue, uint64 at);
    event SuspensionActivated(uint64 startedAt);
    event SuspensionLifted(uint64 endedAt);
    /// @dev DORA Art 28 provider swap — the on-chain half of an event whose Register of
    ///      Information entry and NCA pre-notification sit off-chain.
    event OracleChanged(address indexed previous, address indexed next);

    // ─────────────────────────── errors ──────────────────────────────────────

    error ActiveBreach(bytes32 bucket, uint256 ratioBps, uint256 limitBps);
    error NotAifm();
    error NotSubscriptionAgent();
    /// @dev The traded asset's feed is not current, so the Art 13 ratio it feeds cannot be
    ///      trusted. Only ever raised on an increasing position — see the header.
    error StaleValuation(bytes32 assetId);
    error SuspensionAlreadyActive();
    error SuspensionExpired();
    error ZeroAddress();

    modifier onlyAifm() {
        if (msg.sender != aifm) revert NotAifm();
        _;
    }

    modifier onlySubscriptionAgent() {
        if (msg.sender != subscriptionAgent) revert NotSubscriptionAgent();
        _;
    }

    /// @notice Repoint the asset feeds at a different `ValuationOracle` deployment.
    /// @dev    DORA Art 28 swappability. Authority is the AIFM's, per §5's delegation note.
    ///         ⚠️ Does not re-read any asset valuation: the new oracle may hold different
    ///         figures, and adopting them silently inside an administrative call would move
    ///         every Art 13 ratio with no valuation event. Call `syncAssetValuation()` per
    ///         asset after — it fails closed on a stale feed.
    ///         Note the subscription path is unaffected either way: the Art 13 denominator
    ///         is the fund's CAPITAL — contributions, not NAV — so it reads no price at all.
    function setOracle(address oracle_) external onlyAifm {
        if (oracle_ == address(0)) revert ZeroAddress();
        emit OracleChanged(address(oracle), oracle_);
        oracle = ValuationOracle(oracle_);
    }

    constructor(address aifm_, address subscriptionAgent_, address oracle_) {
        aifm = aifm_;
        subscriptionAgent = subscriptionAgent_;
        oracle = ValuationOracle(oracle_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // DENOMINATOR — moves on mint/burn only. Numerators do NOT move here.
    // This is the "passive" path: subscriptions/redemptions are an investor
    // action, not an AIFM trade decision, so a breach caused purely by
    // capital moving is never reverted — only flagged.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param cashAmount  The CASH consideration received, in capital's reference
    ///                    currency — NOT the number of units minted. Only
    ///                    `subscriptionAgent` — whatever priced this subscription —
    ///                    has this number; the bare token contract only knows units.
    function onMint(uint256 cashAmount) external onlySubscriptionAgent {
        totalCapital += cashAmount;
        _recheckAll();
    }

    /// @param cashAmount  The CASH consideration paid out, in capital's reference
    ///                    currency — NOT the number of units burned. See `onMint`.
    function onBurn(uint256 cashAmount) external onlySubscriptionAgent {
        totalCapital -= cashAmount;
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
        if (delta > 0 && !oracle.isFresh(assetId)) revert StaleValuation(assetId);
        _applyAssetDelta(assetId, isEligibleLongTerm, isSts, isOtcRepoOrReverseRepo, isCrossHolding, delta, true);
    }

    /// @notice Pull this asset's current market value from the oracle and book the
    ///         difference. Passive by construction: never reverts on a breach, only
    ///         flags/clears/alerts. `totalCapital` (the denominator) does NOT move here —
    ///         it is contribution-based (ELTIF Art 2(8)), not marked to market. Only the
    ///         numerators — the market value of what's already held — do.
    /// @dev    Permissionless. The figure is already guarded by the oracle's sources,
    ///         quorum and deviation band, so a role check here would protect nothing and
    ///         would let whoever holds it hide an Art 13 breach by not calling. The delta
    ///         is derived here rather than supplied, which is the entire fix: a caller can
    ///         no longer corrupt the book by getting one arithmetic step wrong.
    /// @dev    The asset's own `assetId` is its feed id in the oracle.
    function syncAssetValuation(
        bytes32 assetId,
        bool isEligibleLongTerm,
        bool isSts,
        bool isOtcRepoOrReverseRepo,
        bool isCrossHolding
    ) external {
        uint256 published = oracle.value(assetId); // reverts on stale/halted — fail closed
        uint256 current = assetValue[assetId];
        if (published == current) return;

        int256 delta = published > current
            ? int256(published - current)
            : -int256(current - published);

        _applyAssetDelta(assetId, isEligibleLongTerm, isSts, isOtcRepoOrReverseRepo, isCrossHolding, delta, false);
        emit AssetValuationSynced(assetId, current, published, uint64(block.timestamp));
    }

    /// @param active  True for an AIFM-directed trade (can revert on active breach);
    ///                false for a price-driven revaluation (never reverts).
    function _applyAssetDelta(
        bytes32 assetId,
        bool isEligibleLongTerm,
        bool isSts,
        bool isOtcRepoOrReverseRepo,
        bool isCrossHolding,
        int256 delta,
        bool active
    ) internal {
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

        // Only a trade can be blocked for causing a breach; a valuation move never is.
        bool worsening = active && delta > 0;

        // Per-asset ceiling — keyed by the asset itself.
        _checkCeiling(assetId, assetValue[assetId], PER_ASSET_CEILING_BPS, worsening);

        if (isEligibleLongTerm) {
            // A floor: "worsening" here means exposure was reduced.
            _checkFloor(keccak256("ELIGIBLE_FLOOR"), eligibleLongTermValue, ELIGIBLE_FLOOR_BPS, active && delta < 0);
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
