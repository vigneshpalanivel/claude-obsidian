// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IValuationFeed, IProtocolPause} from "./Interfaces.sol";

/// @title NavBorrowingCap (illustrative sample — not production code)
/// @notice Tracks borrowing/leverage against a running NAV denominator, for whichever
///         fund type this instance is deployed for, and enforces the active/passive
///         breach split plus the ELTIF Art 16(3) start date and Art 16(4) suspension.
/// @dev    One deployment = one fund = one FundType. The four regimes are mutually
///         exclusive by construction, not by branching on caller intent at call time.
///         NAV is mark-to-market — it moves from subscriptions/redemptions AND from the
///         market price of held assets changing with no trade at all. The price-driven
///         path is `syncNav`, pulling an absolute figure from the oracle; onMint/onBurn
///         alone cannot produce it.
/// @dev    ⚠️ NAV IS ORACLE-FED AND FAILS CLOSED. Every ratio here is borrowing-or-exposure
///         OVER NAV, so a wrong denominator silently passes a breach — §5 calls this the #1
///         engineering risk in the design. Three consequences visible in this file: there is
///         no privileged `valuator` who can move NAV by an arbitrary delta; every path that
///         draws leverage or opens exposure SYNCS THE ORACLE FIGURE INLINE and then reverts
///         `StaleValuation` when the feed cannot be shown to be current; and a zero NAV on
///         such a path reverts `NavZero` rather than skipping the check. Passive rechecks
///         still run on a stale figure — they only flag, and a flag computed on an old NAV
///         is better than no flag.
/// @dev    ⚠️ SYNC IS IDEMPOTENT PER ORACLE ACCEPTANCE (H6, 2026-09-08). `cashSinceValuation`
///         is zeroed ONLY when the oracle's `acceptedAt` is strictly newer than the one last
///         absorbed. Before this, any caller could erase a redemption's cash effect by calling
///         `syncNav()` while the oracle still held the pre-redemption figure, overstating NAV
///         by exactly the amount paid out.
/// @dev    ⚠️ SUSPENSION RELIEF IS THE ELTIF's ONLY. Art 16(4) suspends the ELTIF BORROWING
///         limit during a capital raise or reduction. It says nothing about UCITS Art 83 or
///         the AIFMD Art 15(4b) loan-origination caps, so `activateSuspension` reverts on
///         every non-ELTIF instance and `_checkCeiling` consults it for the BORROWING bucket
///         only. The 12-month allowance is CUMULATIVE per fund life — lift-and-reactivate does
///         not restart it. That is the conservative reading; a per-capital-event reading is
///         arguable, but the checklist gives one figure and no per-event language.
contract NavBorrowingCap {
    // ─────────────────────────── ceilings (basis points, 10000 = 100%) ─────────

    uint256 public constant ELTIF_RETAIL_BORROW_BPS = 5000; // Art 16(1)(a) — 50% of NAV
    uint256 public constant ELTIF_PROFESSIONAL_BORROW_BPS = 10000; // Art 16(1)(a) — 100% of NAV

    uint256 public constant UCITS_BUCKET_CEILING_BPS = 1000; // Art 83 — 10% per bucket
    uint256 public constant UCITS_COMBINED_CEILING_BPS = 1500; // Art 83 — 15% combined

    uint256 public constant DERIVATIVE_GLOBAL_EXPOSURE_BPS = 10000; // ≤ 100% of NAV

    uint256 public constant LOF_OPEN_LEVERAGE_BPS = 17500; // AIFMD Art 15(4b) — 175% of NAV
    uint256 public constant LOF_CLOSED_LEVERAGE_BPS = 30000; // AIFMD Art 15(4b) — 300% of NAV
    uint256 public constant LOF_CARVEOUT_CEILING_BPS = 15000; // 150% of NAV — excluded from leverage above

    uint256 public constant ALERT_BPS = 9000; // 90% of the limit's distance
    uint256 public constant BPS_DENOM = 10000;

    /// @dev Art 16(4): "maximum 12 months". Cumulative — see header.
    uint256 public constant SUSPENSION_MAX_DURATION = 365 days;

    enum FundType {
        EltifRetail,
        EltifProfessional,
        Ucits,
        LofOpenEnded,
        LofClosedEnded
    }

    // ─────────────────────────── roles ───────────────────────────────────────

    /// @dev NOT immutable (M-F6). Two-step rotation, same pattern as the oracle's governance:
    ///      a one-step transfer to a mistyped address strands `setOracle`, `setProtocolPause`
    ///      and every `record*` call — the fund could never draw or repay again.
    address public aifm; // reports borrowing/exposure changes
    address public pendingAifm;
    address public subscriptionAgent; // prices subscriptions/redemptions — knows CASH amounts, not share counts
    address public regulator; // Art 25 — may tighten the effective ceiling post-deploy

    /// @dev NOT immutable — DORA Art 28 requires the oracle stay "swappable at the contract
    ///      layer, not hard-wired", and a constructor-set immutable reference makes a
    ///      provider swap a redeploy of this module. On a live instrument that is a
    ///      re-issuance, not an upgrade. The swap is already an Art 28(3) NCA
    ///      pre-notification event; the contract layer must not add a redeploy on top.
    ///      Typed as the interface, never the concrete oracle (design §3 rev-38 rule).
    IValuationFeed public oracle; // marks NAV to market — absolute, never delta
    bytes32 public immutable navFeedId; // this fund's NAV identity in the oracle

    /// @dev The protocol pause (`DoraGovernor`). Read on DRAW paths only: a repayment must
    ///      still execute during an incident — trapping a fund in breach is not a control.
    IProtocolPause public protocolPause;

    FundType public immutable fundType;

    /// @notice ELTIF Art 16(3): the borrowing limits apply from the date in the fund rules,
    ///         no later than 3 years after marketing commencement. Fed at deployment; before
    ///         it, the BORROWING bucket's active breach is suppressed (flagged, not reverted).
    ///         Read by ELTIF instances only.
    uint64 public immutable rampUpStartsAt;

    // ─────────────────────────── denominator ────────────────────────────────

    /// @notice The last absolute NAV the oracle published, plus the cash that has moved
    ///         since. Two components rather than one running total, because they fail
    ///         differently: the oracle figure carries a timestamp and can go stale, while
    ///         subscription cash is known exactly and needs no feed. Splitting them is what
    ///         lets a subscription between valuation points be reflected without anyone
    ///         inventing a price.
    uint256 public navAtValuation;

    /// @notice Net cash in (positive) or out (negative) since `navAtValuation` was set.
    ///         Reset to zero only when a NEWER oracle acceptance is absorbed — the next
    ///         published NAV already contains it.
    int256 public cashSinceValuation;

    /// @notice The oracle `acceptedAt` that `navAtValuation` came from. The sync-currency
    ///         key: `_syncIfNewer` absorbs only when the oracle's is strictly greater.
    uint64 public lastAbsorbedAcceptedAt;

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

    bytes32 public constant BUCKET_BORROWING = keccak256("BORROWING");
    bytes32 public constant BUCKET_UCITS_A = keccak256("UCITS_BUCKET_A");
    bytes32 public constant BUCKET_UCITS_B = keccak256("UCITS_BUCKET_B");
    bytes32 public constant BUCKET_UCITS_COMBINED = keccak256("UCITS_COMBINED");
    bytes32 public constant BUCKET_DERIVATIVE = keccak256("DERIVATIVE_EXPOSURE");
    bytes32 public constant BUCKET_LOF_LEVERAGE = keccak256("LOF_LEVERAGE");
    bytes32 public constant BUCKET_LOF_CARVEOUT = keccak256("LOF_CARVEOUT");

    mapping(bytes32 => BreachState) public breach;

    // ─────────────────────────── suspension (ELTIF Art 16(4)) ────────────────

    bool public suspended;
    uint64 public suspensionStartedAt;
    /// @notice Seconds of Art 16(4) relief already consumed by CLOSED suspensions. The live
    ///         one adds `now - suspensionStartedAt` on top; the sum may not exceed
    ///         `SUSPENSION_MAX_DURATION` over the fund's life.
    uint64 public suspensionUsedSeconds;

    // ─────────────────────────── events ─────────────────────────────────────

    event BreachStarted(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event BreachCleared(bytes32 indexed bucket);
    event ThresholdAlert(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event SuspensionActivated(uint64 startedAt, uint64 budgetRemainingSeconds);
    event SuspensionLifted(uint64 endedAt, uint64 usedSecondsTotal);
    event RegulatorCeilingUpdated(uint256 oldCeilingBps, uint256 newCeilingBps);
    /// @dev Emitted only when a NEWER oracle acceptance was absorbed. A `syncNav()` that finds
    ///      nothing new rechecks silently.
    event NavSynced(uint256 navAtValuation, int256 cashAbsorbed, uint64 acceptedAt);
    /// @dev DORA Art 28 provider swap. The Register of Information entry and the NCA
    ///      pre-notification are off-chain; this is the on-chain half of the same event.
    event OracleChanged(address indexed previous, address indexed next);
    event ProtocolPauseChanged(address indexed previous, address indexed next);
    event AifmTransferProposed(address indexed current, address indexed proposed);
    event AifmTransferred(address indexed previous, address indexed next);
    event SubscriptionAgentChanged(address indexed previous, address indexed next);
    event RegulatorChanged(address indexed previous, address indexed next);

    // ─────────────────────────── errors ──────────────────────────────────────

    error ActiveBreach(bytes32 bucket, uint256 ratioBps, uint256 limitBps);
    error NotAifm();
    error NotPendingAifm();
    error NotSubscriptionAgent();
    error NotRegulator();
    /// @dev The NAV feed is not current, so no ratio computed here can be trusted. §5:
    ///      "oracle failure must HALT issuance/redemption, not pass a stale limit."
    error StaleValuation(bytes32 navFeedId);
    /// @dev A draw against a zero denominator. Passive paths skip; active paths refuse.
    error NavZero();
    /// @dev `DoraGovernor.paused()` — the oracle circuit-breaker trip, or an incident.
    error ProtocolPaused();
    error WrongFundType();
    error CeilingCanOnlyTighten();
    error SuspensionAlreadyActive();
    error SuspensionNotActive();
    /// @dev The cumulative 12 months of Art 16(4) relief are spent.
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

    modifier onlyRegulator() {
        if (msg.sender != regulator) revert NotRegulator();
        _;
    }

    /// @param rampUpStartsAt_  ELTIF Art 16(3) start date. Ignored (may be 0) for UCITS and LOF.
    constructor(
        address aifm_,
        address subscriptionAgent_,
        address regulator_,
        address oracle_,
        address protocolPause_,
        bytes32 navFeedId_,
        FundType fundType_,
        uint64 rampUpStartsAt_
    ) {
        if (
            aifm_ == address(0) || subscriptionAgent_ == address(0) || regulator_ == address(0) ||
            oracle_ == address(0) || protocolPause_ == address(0)
        ) revert ZeroAddress();
        aifm = aifm_;
        subscriptionAgent = subscriptionAgent_;
        regulator = regulator_;
        oracle = IValuationFeed(oracle_);
        protocolPause = IProtocolPause(protocolPause_);
        navFeedId = navFeedId_;
        fundType = fundType_;
        rampUpStartsAt = rampUpStartsAt_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ROLES — rotatable (M-F6). Manager role two-step; the others one-step
    // under the manager, because a wrong subscription agent or regulator is
    // recoverable by the manager and a wrong manager is recoverable by nobody.
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

    function setRegulator(address next) external onlyAifm {
        if (next == address(0)) revert ZeroAddress();
        emit RegulatorChanged(regulator, next);
        regulator = next;
    }

    /// @notice Repoint the NAV feed at a different oracle deployment.
    /// @dev    DORA Art 28 swappability. Authority sits with the AIFM because §5's
    ///         delegation note is explicit that parameter-setting authority stays with the
    ///         AIFM's own governance and the technology provider is infrastructure — in a
    ///         real deployment `aifm` is the timelock, not an operations key.
    ///         ⚠️ Deliberately does NOT re-read NAV, and resets `lastAbsorbedAcceptedAt` so
    ///         the next `_syncIfNewer` absorbs the new oracle's figure whatever its
    ///         timestamp. Adopting it silently here would move every ratio without a
    ///         valuation event; the next `syncNav()` (or the next draw) does it visibly.
    function setOracle(address oracle_) external onlyAifm {
        if (oracle_ == address(0)) revert ZeroAddress();
        emit OracleChanged(address(oracle), oracle_);
        oracle = IValuationFeed(oracle_);
        lastAbsorbedAcceptedAt = 0;
    }

    function setProtocolPause(address pause_) external onlyAifm {
        if (pause_ == address(0)) revert ZeroAddress();
        emit ProtocolPauseChanged(address(protocolPause), pause_);
        protocolPause = IProtocolPause(pause_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ORACLE SYNC
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Absorb the oracle's figure iff it is FRESH and its `acceptedAt` is strictly newer
    ///      than the one already absorbed. Never reverts: a stale or halted feed simply is
    ///      not absorbed, and the caller decides whether that matters (active paths do,
    ///      passive ones do not). Zeroing `cashSinceValuation` is tied to this condition —
    ///      that is the whole of the H6 fix.
    function _syncIfNewer() internal {
        (uint256 published, uint64 at, bool fresh, ) = oracle.peek(navFeedId);
        if (!fresh || at <= lastAbsorbedAcceptedAt) return;
        int256 absorbed = cashSinceValuation;
        navAtValuation = published;
        cashSinceValuation = 0;
        lastAbsorbedAcceptedAt = at;
        emit NavSynced(published, absorbed, at);
    }

    /// @dev Every path that draws leverage or opens exposure. Order matters: pause first
    ///      (an incident stops draws before anything is computed), sync second (adopt the
    ///      oracle's current figure — H8: the ratio must never be computed on a NAV the
    ///      oracle has since superseded), freshness third. After `_syncIfNewer` on a fresh
    ///      feed, `lastAbsorbedAcceptedAt == oracle.acceptedAt(navFeedId)` by construction.
    ///      Deliberately NOT applied to repayments: deleveraging can only move every ratio
    ///      here downward whatever the true NAV is, and blocking it on a stale feed or an
    ///      incident would trap a fund in breach precisely when it most needs to act.
    function _requireCurrentNavIfIncreasing(int256 delta) internal {
        if (delta <= 0) return;
        if (protocolPause.paused()) revert ProtocolPaused();
        _syncIfNewer();
        if (!oracle.isFresh(navFeedId)) revert StaleValuation(navFeedId);
    }

    /// @notice Pull the current NAV from the oracle if it has moved on, and recheck. This is
    ///         the price-driven path: every ratio here is borrowing-or-exposure OVER NAV, so
    ///         a pure NAV drop from a falling asset price raises every leverage ratio without
    ///         anyone drawing a loan — that case has to be reachable independently of
    ///         onMint/onBurn.
    /// @dev    Permissionless on purpose. The figure it pulls is already guarded by the
    ///         oracle's own sources, quorum and deviation band, so there is nothing left
    ///         for a role check here to protect — and gating it would hand whoever holds
    ///         that role the power to suppress a breach by simply not calling. Anyone who
    ///         can see the fund is over a limit can make this contract see it too.
    ///         Never reverts and never double-absorbs: with no newer acceptance it is a
    ///         passive recheck on the figure already held.
    function syncNav() external {
        _syncIfNewer();
        _recheckAll();
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
    /// @dev   Syncs first so the cash lands on top of the oracle's CURRENT figure rather than
    ///        on a base the next absorption would zero it out of.
    function onMint(uint256 cashAmount) external onlySubscriptionAgent {
        _syncIfNewer();
        if (!oracle.isFresh(navFeedId)) revert StaleValuation(navFeedId);
        cashSinceValuation += int256(cashAmount);
        _recheckAll();
    }

    /// @param cashAmount  The CASH consideration paid out, in NAV's reference currency —
    ///                    NOT the number of shares burned. See `onMint`.
    function onBurn(uint256 cashAmount) external onlySubscriptionAgent {
        _syncIfNewer();
        if (!oracle.isFresh(navFeedId)) revert StaleValuation(navFeedId);
        cashSinceValuation -= int256(cashAmount);
        _recheckAll();
    }

    function _recheckAll() internal {
        if (_isEltif()) {
            _checkCeiling(BUCKET_BORROWING, totalBorrowing, _eltifCeiling(), false);
        } else if (fundType == FundType.Ucits) {
            _checkCeiling(BUCKET_UCITS_A, ucitsBucketA, UCITS_BUCKET_CEILING_BPS, false);
            _checkCeiling(BUCKET_UCITS_B, ucitsBucketB, UCITS_BUCKET_CEILING_BPS, false);
            _checkCeiling(BUCKET_UCITS_COMBINED, ucitsBucketA + ucitsBucketB, UCITS_COMBINED_CEILING_BPS, false);
        } else {
            _checkCeiling(BUCKET_LOF_LEVERAGE, totalBorrowing, _lofCeiling(), false);
            _checkCeiling(BUCKET_LOF_CARVEOUT, lofCarveoutAmount, LOF_CARVEOUT_CEILING_BPS, false);
        }
        _checkCeiling(BUCKET_DERIVATIVE, derivativeExposure, DERIVATIVE_GLOBAL_EXPOSURE_BPS, false);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // NUMERATORS — move when the AIFM draws/repays a loan or opens/closes a
    // derivative position. This is the "active" path: if THIS call pushes the
    // relevant ceiling over, revert. Repaying/reducing is always allowed even
    // while a bucket is already in breach.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param delta  Positive = draw down, negative = repay.
    function recordEltifBorrowing(int256 delta) external onlyAifm {
        if (!_isEltif()) revert WrongFundType();
        _requireCurrentNavIfIncreasing(delta);
        totalBorrowing = _applyDelta(totalBorrowing, delta);
        _checkCeiling(BUCKET_BORROWING, totalBorrowing, _eltifCeiling(), delta > 0);
    }

    /// @param bucketA true = first 10% bucket, false = second 10% bucket.
    /// @param delta   Positive = draw down, negative = repay.
    function recordUcitsBorrowing(bool bucketA, int256 delta) external onlyAifm {
        if (fundType != FundType.Ucits) revert WrongFundType();
        _requireCurrentNavIfIncreasing(delta);
        bool worsening = delta > 0;

        if (bucketA) {
            ucitsBucketA = _applyDelta(ucitsBucketA, delta);
            _checkCeiling(BUCKET_UCITS_A, ucitsBucketA, UCITS_BUCKET_CEILING_BPS, worsening);
        } else {
            ucitsBucketB = _applyDelta(ucitsBucketB, delta);
            _checkCeiling(BUCKET_UCITS_B, ucitsBucketB, UCITS_BUCKET_CEILING_BPS, worsening);
        }
        _checkCeiling(BUCKET_UCITS_COMBINED, ucitsBucketA + ucitsBucketB, UCITS_COMBINED_CEILING_BPS, worsening);
    }

    /// @param delta  Positive = increase global exposure, negative = decrease.
    function recordDerivativeExposure(int256 delta) external onlyAifm {
        _requireCurrentNavIfIncreasing(delta);
        derivativeExposure = _applyDelta(derivativeExposure, delta);
        _checkCeiling(BUCKET_DERIVATIVE, derivativeExposure, DERIVATIVE_GLOBAL_EXPOSURE_BPS, delta > 0);
    }

    /// @param delta  Positive = draw down, negative = repay. Counts toward the LOF leverage cap.
    function recordLofBorrowing(int256 delta) external onlyAifm {
        if (!_isLof()) revert WrongFundType();
        _requireCurrentNavIfIncreasing(delta);
        totalBorrowing = _applyDelta(totalBorrowing, delta);
        _checkCeiling(BUCKET_LOF_LEVERAGE, totalBorrowing, _lofCeiling(), delta > 0);
    }

    /// @param delta  Positive = draw down, negative = repay. A carve-out loan (e.g. shareholder
    ///               loan) that does NOT count toward the leverage ratio above — but is itself
    ///               capped at 150% of NAV; beyond that it would need to be booked as ordinary
    ///               borrowing instead (not modelled here — reverts on this call's own cap).
    function recordLofCarveoutLoan(int256 delta) external onlyAifm {
        if (!_isLof()) revert WrongFundType();
        _requireCurrentNavIfIncreasing(delta);
        lofCarveoutAmount = _applyDelta(lofCarveoutAmount, delta);
        _checkCeiling(BUCKET_LOF_CARVEOUT, lofCarveoutAmount, LOF_CARVEOUT_CEILING_BPS, delta > 0);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CEILING CHECK — effective ceiling is min(statutory cap, regulator cap).
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Relief from an active-breach revert exists for ONE bucket: the ELTIF BORROWING
    ///      bucket, before its Art 16(3) start date or inside an Art 16(4) suspension.
    ///      Every other bucket reverts on an active breach unconditionally.
    function _checkCeiling(bytes32 bucket, uint256 numerator, uint256 statutoryCeilingBps, bool causedByThisCall)
        internal
    {
        uint256 navNow = nav();
        if (navNow == 0) {
            if (causedByThisCall) revert NavZero();
            return;
        }

        uint256 effectiveCeilingBps = statutoryCeilingBps < regulatorCeilingBps
            ? statutoryCeilingBps
            : regulatorCeilingBps;

        uint256 ratioBps = (numerator * BPS_DENOM) / navNow;
        bool isBreached = ratioBps > effectiveCeilingBps;

        if (isBreached && causedByThisCall && !_reliefCovers(bucket)) {
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

    function _reliefCovers(bytes32 bucket) internal returns (bool) {
        if (bucket != BUCKET_BORROWING || !_isEltif()) return false;
        if (block.timestamp < rampUpStartsAt) return true; // Art 16(3)
        return _suspensionCovers(); // Art 16(4)
    }

    function _isEltif() internal view returns (bool) {
        return fundType == FundType.EltifRetail || fundType == FundType.EltifProfessional;
    }

    function _isLof() internal view returns (bool) {
        return fundType == FundType.LofOpenEnded || fundType == FundType.LofClosedEnded;
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
    // ELTIF ART 16(4) SUSPENSION — capital raise/reduction window. While active,
    // the BORROWING bucket's active-breach revert is suppressed (flagged
    // instead). The 12 months are a lifetime budget: `liftSuspension` banks the
    // seconds used, `activateSuspension` refuses once they are spent, and the
    // live window auto-lifts at the budget boundary. Not an escape hatch, and
    // not renewable by lift-and-reactivate (M-F4).
    // ═══════════════════════════════════════════════════════════════════════

    function activateSuspension() external onlyAifm {
        if (!_isEltif()) revert WrongFundType();
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
