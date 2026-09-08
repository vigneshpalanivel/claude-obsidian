// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IValuationFeed, IProtocolPause} from "./Interfaces.sol";

/// @title EltifConcentration (illustrative sample — not production code)
/// @notice Tracks ELTIF Art 13 and Art 15(1) concentration limits against a running capital
///         denominator and per-bucket numerators, and enforces the active/passive breach
///         split, the Art 17(1)(a) start date and the Art 17(1)(c) suspension window.
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
/// @dev    ⚠️ CLASSIFICATION IS PERSISTED AT TRADE TIME, NEVER SUPPLIED TO A SYNC (H5).
///         `syncAssetValuation(assetId)` takes nothing else; which buckets the oracle delta
///         lands in comes from the `AssetClass` the AIFM wrote in `recordAssetTrade`. The
///         earlier revision's header claimed "a caller can no longer corrupt the book" while
///         letting any caller pass `isEligibleLongTerm=false` on a price fall and hide a 55%
///         floor breach. The figure was guarded; the flags were not. Now both are.
/// @dev    ⚠️ VALUES ARE ABSOLUTE, NEVER DELTAS. An earlier revision took
///         `recordValuation(int256 delta)` from a privileged valuator. A missed delta is
///         permanent and undetectable — the book stays wrong forever with nothing on-chain
///         to show it — whereas a missed absolute post simply goes stale and says so.
/// @dev    ⚠️ YOU MAY NOT ACQUIRE AN ASSET THIS FUND CANNOT VALUE, AND AN ACQUISITION ADOPTS
///         THE ORACLE'S FIGURE FIRST. `recordAssetTrade` on an increasing position requires
///         a fresh feed for the asset, syncs that asset to the feed, and only then books the
///         AIFM's delta on top (M-F7) — a nominal delta can no longer pass the active check
///         on a value the feed has since moved. A first acquisition has no position for the
///         feed to value, so there only feed liveness is required and the delta IS the
///         opening value; the next sync reconciles it to the feed. Disposals stay open on a
///         stale feed: selling can only move every ceiling here downward, and blocking it
///         would trap the fund in breach exactly when the feed is down.
/// @dev    ⚠️ RELIEF IS PER RULE, NOT BLANKET (M-F4). Art 17(1)(a) and 17(1)(c) relieve the
///         55% FLOOR only (eltif-checklist.md §6.1). The 20%/10%/30% ceilings have no start
///         date and no capital-raise suspension in the Regulation, so `_checkCeiling` never
///         consults either. The 12 months of 17(1)(c) relief are cumulative per fund life.
/// @dev    NOT MODELLED — Art 15(2): for liquid assets it imports the UCITS Art 56(2)
///         issuer-side acquisition limits, whose denominator is the ISSUER's outstanding
///         securities, not this fund's capital. The checklist (§7.1) gives no figures; a
///         counter needs a per-issuer outstanding feed that does not exist in this suite.
///         Also not modelled: Art 13(7) professional-only relief and 13(6) group look-through
///         (an `assetId` is whatever consolidation level the AIFM keys on).
contract EltifConcentration {
    // ─────────────────────────── limits (basis points, 10000 = 100%) ───────────
    // Every figure below verified against eltif-checklist.md §6–§7 on 2026-09-08.

    uint256 public constant ELIGIBLE_FLOOR_BPS = 5500; // Art 13(1) — floor, not ceiling
    uint256 public constant PER_ASSET_CEILING_BPS = 2000; // Art 13(2)(a)–(c) — 20% per QPU / real asset / CIU
    uint256 public constant LIQUID_ISSUER_CEILING_BPS = 1000; // Art 13(2)(d) — 10% per issuer of Art 9(1)(b) liquid assets
    uint256 public constant STS_CEILING_BPS = 2000; // Art 13(3) — aggregate
    uint256 public constant OTC_REPO_CEILING_BPS = 1000; // Art 13(4) — aggregate
    uint256 public constant CROSS_HOLDING_CEILING_BPS = 3000; // Art 15(1) — 30% of any single investee fund's units
    uint256 public constant ALERT_BPS = 9000; // 90% of the limit's distance
    uint256 public constant BPS_DENOM = 10000;

    uint256 public constant SUSPENSION_MAX_DURATION = 365 days; // Art 17(1)(c) — 12 months, cumulative

    /// @notice What the AIFM said this asset is. Written in `recordAssetTrade`, read by
    ///         every `syncAssetValuation`. Reclassifying an asset with a live value moves
    ///         that value between the affected buckets so the aggregates stay exact.
    struct AssetClass {
        bool recorded;
        bool isEligibleLongTerm; // Art 13(1) numerator
        bool isLiquidAsset; // Art 13(2)(d): per-"asset" ceiling is 10%, keyed by issuer
        bool isSts; // Art 13(3)
        bool isOtcRepo; // Art 13(4) — OTC derivative / repo / reverse repo counterparty leg
        bool isCrossHolding; // Art 15(1) — value of investee-fund units held
    }

    // ─────────────────────────── roles ───────────────────────────────────────

    /// @dev NOT immutable (M-F6). Two-step, same pattern as the oracle's governance.
    address public aifm; // executes/reports asset trades
    address public pendingAifm;
    address public subscriptionAgent; // prices subscriptions/redemptions — knows CASH amounts, not unit counts

    /// @dev NOT immutable — DORA Art 28 requires the oracle stay "swappable at the contract
    ///      layer, not hard-wired"; a constructor-set immutable reference makes a provider
    ///      swap a redeploy of this module, which on a live fund is a re-issuance.
    ///      Typed as the interface, never the concrete oracle (design §3 rev-38 rule).
    IValuationFeed public oracle; // marks holdings to market — absolute, never delta

    /// @dev Read on ACQUISITION only. A disposal must execute during an incident.
    IProtocolPause public protocolPause;

    /// @notice Art 17(1)(a): the 55% floor applies from the date in the fund rules. Fed at
    ///         deployment. Before it the floor is not checked at all — not flagged, not
    ///         reverted — because no obligation exists yet.
    uint64 public immutable rampUpStartsAt;

    // ─────────────────────────── denominator ────────────────────────────────

    uint256 public totalCapital;

    // ─────────────────────────── numerators ─────────────────────────────────

    mapping(bytes32 => AssetClass) public assetClass;
    mapping(bytes32 => uint256) public assetValue; // per-asset, for the 20% / 10% per-asset check
    uint256 public eligibleLongTermValue; // Art 13(1) numerator
    uint256 public stsValue; // Art 13(3) numerator
    uint256 public otcRepoReverseRepoValue; // Art 13(4) numerator — aggregate of 3 legs
    uint256 public crossHoldingValue; // Art 15(1) numerator

    // ─────────────────────────── breach state ───────────────────────────────

    struct BreachState {
        bool active;
        uint64 startedAt;
    }

    bytes32 public constant BUCKET_ELIGIBLE_FLOOR = keccak256("ELIGIBLE_FLOOR");
    bytes32 public constant BUCKET_STS = keccak256("STS");
    bytes32 public constant BUCKET_OTC_REPO = keccak256("OTC_REPO");
    bytes32 public constant BUCKET_CROSS_HOLDING = keccak256("CROSS_HOLDING");

    // bucket id => breach state. Buckets: the constants above, or the assetId itself for per-asset.
    mapping(bytes32 => BreachState) public breach;

    // ─────────────────────────── suspension (Art 17(1)(c)) ──────────────────

    bool public suspended;
    uint64 public suspensionStartedAt;
    /// @notice Seconds of Art 17(1)(c) relief already consumed by CLOSED suspensions.
    uint64 public suspensionUsedSeconds;

    // ─────────────────────────── events ─────────────────────────────────────

    event BreachStarted(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event BreachCleared(bytes32 indexed bucket);
    event ThresholdAlert(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event AssetValuationSynced(bytes32 indexed assetId, uint256 previousValue, uint256 newValue, uint64 at);
    event AssetClassified(
        bytes32 indexed assetId, bool isEligibleLongTerm, bool isLiquidAsset, bool isSts, bool isOtcRepo, bool isCrossHolding
    );
    event SuspensionActivated(uint64 startedAt, uint64 budgetRemainingSeconds);
    event SuspensionLifted(uint64 endedAt, uint64 usedSecondsTotal);
    /// @dev DORA Art 28 provider swap — the on-chain half of an event whose Register of
    ///      Information entry and NCA pre-notification sit off-chain.
    event OracleChanged(address indexed previous, address indexed next);
    event ProtocolPauseChanged(address indexed previous, address indexed next);
    event AifmTransferProposed(address indexed current, address indexed proposed);
    event AifmTransferred(address indexed previous, address indexed next);
    event SubscriptionAgentChanged(address indexed previous, address indexed next);

    // ─────────────────────────── errors ──────────────────────────────────────

    error ActiveBreach(bytes32 bucket, uint256 ratioBps, uint256 limitBps);
    error NotAifm();
    error NotPendingAifm();
    error NotSubscriptionAgent();
    /// @dev The traded asset's feed is not current, so the Art 13 ratio it feeds cannot be
    ///      trusted. Only ever raised on an increasing position — see the header.
    error StaleValuation(bytes32 assetId);
    /// @dev An acquisition against zero capital. Passive paths skip; active paths refuse.
    error CapitalZero();
    error ProtocolPaused();
    /// @dev A sync on an asset the AIFM never recorded: no classification to book under.
    error UnknownAsset(bytes32 assetId);
    error SuspensionAlreadyActive();
    error SuspensionNotActive();
    error SuspensionBudgetExhausted();
    error ZeroAddress();

    modifier onlyAifm() {
        if (msg.sender != aifm) revert NotAifm();
        _;
    }

    modifier onlySubscriptionAgent() {
        if (msg.sender != subscriptionAgent) revert NotSubscriptionAgent();
        _;
    }

    /// @param rampUpStartsAt_  Art 17(1)(a) date from the fund rules.
    constructor(
        address aifm_,
        address subscriptionAgent_,
        address oracle_,
        address protocolPause_,
        uint64 rampUpStartsAt_
    ) {
        if (
            aifm_ == address(0) || subscriptionAgent_ == address(0) || oracle_ == address(0) ||
            protocolPause_ == address(0)
        ) revert ZeroAddress();
        aifm = aifm_;
        subscriptionAgent = subscriptionAgent_;
        oracle = IValuationFeed(oracle_);
        protocolPause = IProtocolPause(protocolPause_);
        rampUpStartsAt = rampUpStartsAt_;
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

    /// @notice Repoint the asset feeds at a different oracle deployment.
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
        oracle = IValuationFeed(oracle_);
    }

    function setProtocolPause(address pause_) external onlyAifm {
        if (pause_ == address(0)) revert ZeroAddress();
        emit ProtocolPauseChanged(address(protocolPause), pause_);
        protocolPause = IProtocolPause(pause_);
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

    /// @notice Record a trade AND the asset's classification. Order on an acquisition:
    ///         protocol pause → feed freshness → adopt the oracle's figure for this asset
    ///         (passive) → book the AIFM's delta (active). See the header.
    /// @param delta  Positive = buy/increase, negative = sell/decrease.
    function recordAssetTrade(
        bytes32 assetId,
        bool isEligibleLongTerm,
        bool isLiquidAsset,
        bool isSts,
        bool isOtcRepoOrReverseRepo,
        bool isCrossHolding,
        int256 delta
    ) external onlyAifm {
        _classify(assetId, isEligibleLongTerm, isLiquidAsset, isSts, isOtcRepoOrReverseRepo, isCrossHolding);

        if (delta > 0) {
            if (protocolPause.paused()) revert ProtocolPaused();
            if (!oracle.isFresh(assetId)) revert StaleValuation(assetId);
            if (assetValue[assetId] != 0) _adoptAssetValue(assetId, oracle.value(assetId));
        }
        _applyAssetDelta(assetId, delta, true);
    }

    /// @notice Pull this asset's current market value from the oracle and book the
    ///         difference under its recorded classification. Passive by construction:
    ///         never reverts on a breach, only flags/clears/alerts. `totalCapital` (the
    ///         denominator) does NOT move here — it is contribution-based (ELTIF Art 2(8)),
    ///         not marked to market. Only the numerators do.
    /// @dev    Permissionless. The figure is guarded by the oracle's sources, quorum and
    ///         deviation band; the classification is guarded by `onlyAifm` at trade time;
    ///         nothing is left for a caller to corrupt. Fails closed on a stale or halted
    ///         feed — a passive sync that adopted an unverifiable figure would be a passive
    ///         corruption. The asset's own `assetId` is its feed id in the oracle.
    function syncAssetValuation(bytes32 assetId) external {
        if (!assetClass[assetId].recorded) revert UnknownAsset(assetId);
        _adoptAssetValue(assetId, oracle.value(assetId)); // reverts on stale/halted — fail closed
    }

    function _adoptAssetValue(bytes32 assetId, uint256 published) internal {
        uint256 current = assetValue[assetId];
        if (published == current) return;
        int256 delta = published > current ? int256(published - current) : -int256(current - published);
        _applyAssetDelta(assetId, delta, false);
        emit AssetValuationSynced(assetId, current, published, uint64(block.timestamp));
    }

    /// @dev Persist, or update, the AIFM's classification. A flag that changes on an asset
    ///      with a live value moves that value in or out of the bucket in the same call, so
    ///      the aggregates are exact without a resync.
    function _classify(
        bytes32 assetId,
        bool isEligibleLongTerm,
        bool isLiquidAsset,
        bool isSts,
        bool isOtcRepo,
        bool isCrossHolding
    ) internal {
        AssetClass storage c = assetClass[assetId];
        uint256 live = assetValue[assetId];
        bool changed = !c.recorded;

        if (c.isEligibleLongTerm != isEligibleLongTerm) {
            eligibleLongTermValue = isEligibleLongTerm ? eligibleLongTermValue + live : _sub(eligibleLongTermValue, live);
            changed = true;
        }
        if (c.isSts != isSts) {
            stsValue = isSts ? stsValue + live : _sub(stsValue, live);
            changed = true;
        }
        if (c.isOtcRepo != isOtcRepo) {
            otcRepoReverseRepoValue = isOtcRepo ? otcRepoReverseRepoValue + live : _sub(otcRepoReverseRepoValue, live);
            changed = true;
        }
        if (c.isCrossHolding != isCrossHolding) {
            crossHoldingValue = isCrossHolding ? crossHoldingValue + live : _sub(crossHoldingValue, live);
            changed = true;
        }
        if (c.isLiquidAsset != isLiquidAsset) changed = true;

        c.recorded = true;
        c.isEligibleLongTerm = isEligibleLongTerm;
        c.isLiquidAsset = isLiquidAsset;
        c.isSts = isSts;
        c.isOtcRepo = isOtcRepo;
        c.isCrossHolding = isCrossHolding;
        if (changed) emit AssetClassified(assetId, isEligibleLongTerm, isLiquidAsset, isSts, isOtcRepo, isCrossHolding);
    }

    /// @param active  True for an AIFM-directed trade (can revert on active breach);
    ///                false for a price-driven revaluation (never reverts).
    function _applyAssetDelta(bytes32 assetId, int256 delta, bool active) internal {
        AssetClass storage c = assetClass[assetId];
        assetValue[assetId] = _applyDelta(assetValue[assetId], delta);

        if (c.isEligibleLongTerm) eligibleLongTermValue = _applyDelta(eligibleLongTermValue, delta);
        if (c.isSts) stsValue = _applyDelta(stsValue, delta);
        if (c.isOtcRepo) otcRepoReverseRepoValue = _applyDelta(otcRepoReverseRepoValue, delta);
        if (c.isCrossHolding) crossHoldingValue = _applyDelta(crossHoldingValue, delta);

        // Only a trade can be blocked for causing a breach; a valuation move never is.
        bool worsening = active && delta > 0;

        // Per-asset ceiling — keyed by the asset itself. 10% for a liquid-asset issuer.
        _checkCeiling(
            assetId,
            assetValue[assetId],
            c.isLiquidAsset ? LIQUID_ISSUER_CEILING_BPS : PER_ASSET_CEILING_BPS,
            worsening
        );

        if (c.isEligibleLongTerm) {
            // A floor: "worsening" here means exposure was reduced.
            _checkFloor(eligibleLongTermValue, active && delta < 0);
        }
        if (c.isSts) _checkCeiling(BUCKET_STS, stsValue, STS_CEILING_BPS, worsening);
        if (c.isOtcRepo) _checkCeiling(BUCKET_OTC_REPO, otcRepoReverseRepoValue, OTC_REPO_CEILING_BPS, worsening);
        if (c.isCrossHolding) _checkCeiling(BUCKET_CROSS_HOLDING, crossHoldingValue, CROSS_HOLDING_CEILING_BPS, worsening);
    }

    // Passive re-check after mint/burn — never reverts, only flags/clears/alerts.
    function _recheckAll() internal {
        _checkCeiling(BUCKET_STS, stsValue, STS_CEILING_BPS, false);
        _checkCeiling(BUCKET_OTC_REPO, otcRepoReverseRepoValue, OTC_REPO_CEILING_BPS, false);
        _checkCeiling(BUCKET_CROSS_HOLDING, crossHoldingValue, CROSS_HOLDING_CEILING_BPS, false);
        _checkFloor(eligibleLongTermValue, false);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CEILING / FLOOR CHECKS
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev No relief of any kind: neither Art 17(1)(a) nor 17(1)(c) touches a ceiling.
    function _checkCeiling(bytes32 bucket, uint256 numerator, uint256 ceilingBps, bool causedByThisCall) internal {
        if (totalCapital == 0) {
            if (causedByThisCall) revert CapitalZero();
            return;
        }

        uint256 ratioBps = (numerator * BPS_DENOM) / totalCapital;
        bool isBreached = ratioBps > ceilingBps;

        if (isBreached && causedByThisCall) {
            revert ActiveBreach(bucket, ratioBps, ceilingBps);
        }

        _updateBreachState(bucket, isBreached, ratioBps, ceilingBps);

        if (!isBreached && ratioBps >= (ceilingBps * ALERT_BPS) / BPS_DENOM) {
            emit ThresholdAlert(bucket, ratioBps, ceilingBps);
        }
    }

    /// @dev The one check with relief: not applied before `rampUpStartsAt` (Art 17(1)(a)),
    ///      and an active breach is suppressed inside an Art 17(1)(c) suspension.
    function _checkFloor(uint256 numerator, bool causedByThisCall) internal {
        if (block.timestamp < rampUpStartsAt) return;
        if (totalCapital == 0) {
            if (causedByThisCall) revert CapitalZero();
            return;
        }

        uint256 ratioBps = (numerator * BPS_DENOM) / totalCapital;
        bool isBreached = ratioBps < ELIGIBLE_FLOOR_BPS;

        if (isBreached && causedByThisCall && !_suspensionCovers()) {
            revert ActiveBreach(BUCKET_ELIGIBLE_FLOOR, ratioBps, ELIGIBLE_FLOOR_BPS);
        }

        _updateBreachState(BUCKET_ELIGIBLE_FLOOR, isBreached, ratioBps, ELIGIBLE_FLOOR_BPS);

        // Alert when drifting down toward the floor, before actually breaching it.
        uint256 alertThreshold = ELIGIBLE_FLOOR_BPS + ((ELIGIBLE_FLOOR_BPS * (BPS_DENOM - ALERT_BPS)) / BPS_DENOM);
        if (!isBreached && ratioBps <= alertThreshold) {
            emit ThresholdAlert(BUCKET_ELIGIBLE_FLOOR, ratioBps, ELIGIBLE_FLOOR_BPS);
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

    function _sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return b > a ? 0 : a - b;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 17(1)(c) SUSPENSION — capital raise/reduction window, relieving the
    // 55% FLOOR only. The 12 months are a lifetime budget: `liftSuspension`
    // banks the seconds used, `activateSuspension` refuses once they are
    // spent, and the live window auto-lifts at the boundary. Not renewable by
    // lift-and-reactivate (M-F4).
    // ═══════════════════════════════════════════════════════════════════════

    function activateSuspension() external onlyAifm {
        if (suspended) revert SuspensionAlreadyActive();
        if (suspensionUsedSeconds >= SUSPENSION_MAX_DURATION) revert SuspensionBudgetExhausted();
        suspended = true;
        suspensionStartedAt = uint64(block.timestamp);
        emit SuspensionActivated(suspensionStartedAt, uint64(SUSPENSION_MAX_DURATION) - suspensionUsedSeconds);
    }

    function liftSuspension() external onlyAifm {
        if (!suspended) revert SuspensionNotActive();
        _lift();
    }

    function _lift() internal {
        uint64 elapsed = uint64(block.timestamp) - suspensionStartedAt;
        uint64 used = suspensionUsedSeconds + elapsed;
        suspensionUsedSeconds = used > SUSPENSION_MAX_DURATION ? uint64(SUSPENSION_MAX_DURATION) : used;
        suspended = false;
        suspensionStartedAt = 0;
        emit SuspensionLifted(uint64(block.timestamp), suspensionUsedSeconds);
    }

    function _suspensionCovers() internal returns (bool) {
        if (!suspended) return false;
        uint256 liveUsed = suspensionUsedSeconds + (block.timestamp - suspensionStartedAt);
        if (liveUsed > SUSPENSION_MAX_DURATION) {
            // Budget boundary — auto-lift, do not silently keep covering.
            _lift();
            return false;
        }
        return true;
    }
}
