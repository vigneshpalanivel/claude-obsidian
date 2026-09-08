// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IValuationFeed, IProtocolPause} from "./Interfaces.sol";

/// @title UcitsFiveTenForty (illustrative sample — not production code)
/// @notice Tracks UCITS Art 52 / Art 55 concentration limits against a running NAV
///         denominator and per-bucket numerators, and enforces the active/passive
///         breach split plus the Art 56 ramp-up window.
/// @dev    NAV is mark-to-market by definition, not just a mint/burn ledger — it moves
///         from subscriptions/redemptions AND from the market price of what's already
///         held changing with no trade at all. `syncNav` and `syncLegValuation` are the
///         price-driven paths (passive); Art 49(2) names market movement explicitly as a
///         passive-breach trigger, so this isn't optional.
/// @dev    ⚠️ BOTH SIDES OF EVERY RATIO ARE ORACLE-FED, AND BOTH ARE ABSOLUTE. NAV is the
///         denominator of every limit here and the per-leg market values are the
///         numerators, so a feed failure corrupts the check from either direction. Earlier
///         revisions took both as `int256 delta` from a privileged valuator — a design in
///         which one dropped message leaves the book permanently and undetectably wrong.
///         The sync paths below read absolute figures and compute the delta themselves.
/// @dev    ⚠️ CLASSIFICATION IS PERSISTED AT TRADE TIME, NEVER SUPPLIED TO A SYNC (H5).
///         `syncLegValuation` takes a `legId` and nothing else; which mapping the value
///         lands in, which entity it rolls up into, whether the CIU is non-UCITS and
///         whether the counterparty is a credit institution all come from the `LegMeta`
///         the ManCo wrote in `recordHoldingUpdate`. Before this, anyone could call the
///         sync with a garbage `entityId` and understate the Art 52(4) roll-up, or pass the
///         wrong `legType` and book the value into a second mapping.
/// @dev    ⚠️ THE 40% BAND IS RECOMPUTED, NOT TRACKED INCREMENTALLY (H9). Membership in the
///         Art 52(2) basket — issuers held above 5% of NAV — depends on NAV, so a NAV move
///         alone can carry an issuer across the line with no trade and no sync on that leg.
///         An incrementally-maintained aggregate drifts on every such crossing. The issuer
///         set is therefore enumerable, bounded at `MAX_ISSUERS`, and the band is re-summed
///         from scratch inside every recheck and after every issuer trade. O(MAX_ISSUERS)
///         storage reads per recheck is the price; 256 is a real UCITS book, not a toy bound.
/// @dev    ⚠️ FAIL-CLOSED ON ACQUISITION, FAIL-OPEN ON DISPOSAL. Buying into a bucket on a
///         NAV nobody can vouch for is the harm; SELLING out of one on the same NAV is the
///         remedy, and can only move every ratio here downward. Blocking disposals on a
///         stale feed would trap the fund in breach exactly when the feed is down. Every
///         acquisition syncs the oracle's current NAV inline first (H8), refuses a protocol
///         pause, and refuses a zero denominator (`NavZero`).
contract UcitsFiveTenForty {
    // ─────────────────────────── ceilings (basis points, 10000 = 100%) ─────────

    uint256 public constant ISSUER_HARD_CAP_BPS = 1000; // Art 52(2) — 10% per issuer
    uint256 public constant ISSUER_SOFT_CAP_BPS = 500; // Art 52(1) — 5%; above this, counts toward the 40% band
    uint256 public constant ISSUER_BAND_AGGREGATE_BPS = 4000; // Art 52(2) — 40% aggregate of issuers held >5%

    uint256 public constant BANK_DEPOSIT_CEILING_BPS = 2000; // Art 52(1) 2nd subpara — 20% per bank
    uint256 public constant DERIVATIVE_COUNTERPARTY_CEILING_BPS = 500; // Art 52(1) 3rd subpara — 5%
    uint256 public constant DERIVATIVE_COUNTERPARTY_CREDIT_INST_CEILING_BPS = 1000; // 10% if credit institution
    uint256 public constant COMBINED_SINGLE_ENTITY_CEILING_BPS = 2000; // Art 52(4) — 20% combined, all legs

    uint256 public constant FOF_PER_UCITS_CEILING_BPS = 1000; // Art 55(1) — 10% per UCITS / eligible CIU
    uint256 public constant FOF_NON_UCITS_AGGREGATE_CEILING_BPS = 3000; // Art 55(2) — 30% aggregate, non-UCITS CIUs

    /// @notice Per-fund cap for a single eligible NON-UCITS CIU. Governance-configurable
    ///         because the checklist gives 20% flagged "Article 55(1) — interpretation;
    ///         confirm with counsel" (ucits-checklist.md §7.3). Default 2000. A ManCo whose
    ///         counsel reads Art 55(1) as 10% for every CIU sets it to 1000.
    uint256 public nonUcitsCiuLimitBps = 2000;

    uint256 public constant ALERT_BPS = 9000; // 90% of the limit's distance
    uint256 public constant BPS_DENOM = 10000;

    uint256 public constant RAMP_UP_DURATION = 180 days; // Art 56 — 6 months from authorisation, hard expiry

    /// @dev Bound on the enumerable issuer set the 40% band is re-summed over.
    uint256 public constant MAX_ISSUERS = 256;

    enum LegType {
        Issuer,
        BankDeposit,
        DerivativeCounterparty,
        FundOfFunds
    }

    /// @notice What the ManCo said this leg is, written at trade time and read by every sync.
    struct LegMeta {
        bool recorded;
        LegType legType;
        bytes32 entityId; // Art 52(4) roll-up group; unused for FundOfFunds
        bool isNonUcits; // FundOfFunds only
        bool isCreditInstitution; // DerivativeCounterparty only
    }

    // ─────────────────────────── roles ───────────────────────────────────────

    /// @dev NOT immutable (M-F6). Two-step, same pattern as the oracle's governance.
    address public manco; // management company — reports holding changes
    address public pendingManco;
    address public subscriptionAgent; // prices subscriptions/redemptions — knows CASH amounts, not share counts

    /// @dev NOT immutable — DORA Art 28 requires the oracle stay "swappable at the contract
    ///      layer, not hard-wired"; a constructor-set immutable reference makes a provider
    ///      swap a redeploy of this module, which on a live fund is a re-issuance.
    ///      Typed as the interface, never the concrete oracle (design §3 rev-38 rule).
    IValuationFeed public oracle; // marks NAV and holdings to market — absolute, never delta
    bytes32 public immutable navFeedId; // this fund's NAV identity in the oracle

    /// @dev Read on ACQUISITION only. A disposal must execute during an incident.
    IProtocolPause public protocolPause;

    /// @notice Art 56: the six months run from AUTHORISATION of the UCITS, not from the day
    ///         this contract happened to be deployed (ucits-checklist.md §14.2). Fed.
    uint64 public immutable authorisedAt;

    // ─────────────────────────── denominator ────────────────────────────────

    /// @notice The last absolute NAV the oracle published, plus the cash that has moved
    ///         since. Two components rather than one running total, because they fail
    ///         differently: the oracle figure carries a timestamp and can go stale, while
    ///         subscription cash is known exactly and needs no feed.
    uint256 public navAtValuation;

    /// @notice Net cash in (positive) or out (negative) since `navAtValuation` was set.
    ///         Reset to zero only when a NEWER oracle acceptance is absorbed (H6).
    int256 public cashSinceValuation;

    /// @notice The oracle `acceptedAt` that `navAtValuation` came from.
    uint64 public lastAbsorbedAcceptedAt;

    /// @notice The denominator every limit in this contract divides by.
    function nav() public view returns (uint256) {
        return _applyDelta(navAtValuation, cashSinceValuation);
    }

    // ─────────────────────────── numerators ─────────────────────────────────

    mapping(bytes32 => LegMeta) public legMeta;

    mapping(bytes32 => uint256) public issuerValue; // 5/10 per-issuer, keyed by issuerId
    /// @notice Σ value of issuers currently held > 5% of `nav()`. Recomputed, never nudged.
    uint256 public issuerBandAggregateValue;
    bytes32[] private _issuerIds; // issuers with a non-zero value
    mapping(bytes32 => uint256) private _issuerIndexPlusOne;

    mapping(bytes32 => uint256) public depositValue; // per-bank deposits, keyed by bankId
    mapping(bytes32 => uint256) public derivativeValue; // per-counterparty, keyed by counterpartyId

    mapping(bytes32 => uint256) public combinedEntityValue; // securities+deposit+derivative, per entityId

    mapping(bytes32 => uint256) public fundOfFundsValue; // per underlying fund, keyed by fundId
    uint256 public nonUcitsAggregateValue; // aggregate of non-UCITS CIU holdings

    // ─────────────────────────── breach state ───────────────────────────────

    struct BreachState {
        bool active;
        uint64 startedAt;
    }

    /// @dev Bucket ids. Leg buckets are keyed by (legId, legType) — the same `bytes32` can
    ///      legitimately be an issuer AND a deposit bank AND a derivative counterparty
    ///      (that is exactly why Art 52(4) exists), and keying on `legId` alone let one
    ///      leg's breach state clear another's (M-F15). Entity buckets are prefixed so an
    ///      entityId that equals a legId cannot collide either.
    bytes32 public constant BUCKET_ISSUER_BAND = keccak256("ISSUER_BAND");
    bytes32 public constant BUCKET_FOF_NON_UCITS = keccak256("FOF_NON_UCITS");

    function legBucket(bytes32 legId, LegType legType) public pure returns (bytes32) {
        return keccak256(abi.encode("LEG", legId, legType));
    }

    function entityBucket(bytes32 entityId) public pure returns (bytes32) {
        return keccak256(abi.encode("ENTITY", entityId));
    }

    mapping(bytes32 => BreachState) public breach;

    // ─────────────────────────── events ─────────────────────────────────────

    event BreachStarted(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    event BreachCleared(bytes32 indexed bucket);
    event ThresholdAlert(bytes32 indexed bucket, uint256 ratioBps, uint256 limitBps);
    /// @dev Emitted only when a NEWER oracle acceptance was absorbed.
    event NavSynced(uint256 navAtValuation, int256 cashAbsorbed, uint64 acceptedAt);
    event LegValuationSynced(bytes32 indexed legId, uint256 previousValue, uint256 newValue, uint64 at);
    event LegClassified(bytes32 indexed legId, LegType legType, bytes32 indexed entityId, bool isNonUcits, bool isCreditInstitution);
    event NonUcitsCiuLimitSet(uint256 oldBps, uint256 newBps);
    /// @dev DORA Art 28 provider swap — the on-chain half of an event whose Register of
    ///      Information entry and NCA pre-notification sit off-chain.
    event OracleChanged(address indexed previous, address indexed next);
    event ProtocolPauseChanged(address indexed previous, address indexed next);
    event MancoTransferProposed(address indexed current, address indexed proposed);
    event MancoTransferred(address indexed previous, address indexed next);
    event SubscriptionAgentChanged(address indexed previous, address indexed next);

    // ─────────────────────────── errors ──────────────────────────────────────

    error ActiveBreach(bytes32 bucket, uint256 ratioBps, uint256 limitBps);
    error NotManco();
    error NotPendingManco();
    error NotSubscriptionAgent();
    /// @dev The NAV feed, or the traded leg's own feed, is not current — so no ratio
    ///      computed here can be trusted. §5: "oracle failure must HALT issuance/
    ///      redemption, not pass a stale limit."
    error StaleValuation(bytes32 feedId);
    error NavZero();
    error ProtocolPaused();
    /// @dev A sync on a leg the ManCo never recorded: there is no classification to book
    ///      the figure under, and inventing one is the H5 defect.
    error UnknownLeg(bytes32 legId);
    /// @dev A legId is one thing; it does not change category. Use a new id.
    error LegTypeMismatch(bytes32 legId, LegType recorded, LegType supplied);
    error TooManyIssuers();
    error LimitOutOfRange();
    error ZeroAddress();

    modifier onlyManco() {
        if (msg.sender != manco) revert NotManco();
        _;
    }

    modifier onlySubscriptionAgent() {
        if (msg.sender != subscriptionAgent) revert NotSubscriptionAgent();
        _;
    }

    /// @param authorisedAt_  UCITS authorisation date — the Art 56 clock (ucits-checklist.md §14.2).
    constructor(
        address manco_,
        address subscriptionAgent_,
        address oracle_,
        address protocolPause_,
        bytes32 navFeedId_,
        uint64 authorisedAt_
    ) {
        if (
            manco_ == address(0) || subscriptionAgent_ == address(0) || oracle_ == address(0) ||
            protocolPause_ == address(0)
        ) revert ZeroAddress();
        manco = manco_;
        subscriptionAgent = subscriptionAgent_;
        oracle = IValuationFeed(oracle_);
        protocolPause = IProtocolPause(protocolPause_);
        navFeedId = navFeedId_;
        authorisedAt = authorisedAt_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ROLES — rotatable (M-F6).
    // ═══════════════════════════════════════════════════════════════════════

    function transferManco(address next) external onlyManco {
        if (next == address(0)) revert ZeroAddress();
        pendingManco = next;
        emit MancoTransferProposed(manco, next);
    }

    function acceptManco() external {
        if (msg.sender != pendingManco) revert NotPendingManco();
        address previous = manco;
        manco = msg.sender;
        pendingManco = address(0);
        emit MancoTransferred(previous, msg.sender);
    }

    function setSubscriptionAgent(address next) external onlyManco {
        if (next == address(0)) revert ZeroAddress();
        emit SubscriptionAgentChanged(subscriptionAgent, next);
        subscriptionAgent = next;
    }

    /// @notice Repoint the NAV and leg feeds at a different oracle deployment.
    /// @dev    DORA Art 28 swappability. Authority is the management company's, per §5's
    ///         delegation note. ⚠️ Does not re-read anything, and resets the absorbed
    ///         timestamp so the next sync adopts the new oracle's NAV whatever its
    ///         `acceptedAt`. Adopting it silently here would move every 5/10/40 ratio with
    ///         no valuation event; `syncNav()` and `syncLegValuation()` do it visibly.
    function setOracle(address oracle_) external onlyManco {
        if (oracle_ == address(0)) revert ZeroAddress();
        emit OracleChanged(address(oracle), oracle_);
        oracle = IValuationFeed(oracle_);
        lastAbsorbedAcceptedAt = 0;
    }

    function setProtocolPause(address pause_) external onlyManco {
        if (pause_ == address(0)) revert ZeroAddress();
        emit ProtocolPauseChanged(address(protocolPause), pause_);
        protocolPause = IProtocolPause(pause_);
    }

    /// @notice Art 55(1) per-CIU cap for NON-UCITS CIUs. Bounded to (0, 10%..20%]: it may not
    ///         be looser than the checklist's 20% interpretation nor tighter than the 10%
    ///         that applies to every CIU on the strict reading.
    function setNonUcitsCiuLimit(uint256 bps) external onlyManco {
        if (bps < FOF_PER_UCITS_CEILING_BPS || bps > 2000) revert LimitOutOfRange();
        emit NonUcitsCiuLimitSet(nonUcitsCiuLimitBps, bps);
        nonUcitsCiuLimitBps = bps;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ORACLE SYNC
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Absorb the oracle's NAV iff fresh and strictly newer than the one held. Never
    ///      reverts. `cashSinceValuation` is zeroed only inside this condition (H6).
    function _syncIfNewer() internal {
        (uint256 published, uint64 at, bool fresh, ) = oracle.peek(navFeedId);
        if (!fresh || at <= lastAbsorbedAcceptedAt) return;
        int256 absorbed = cashSinceValuation;
        navAtValuation = published;
        cashSinceValuation = 0;
        lastAbsorbedAcceptedAt = at;
        emit NavSynced(published, absorbed, at);
    }

    /// @dev The asymmetry every numerator path needs. Acquiring on an unverifiable
    ///      denominator is the thing to stop; DISPOSING on one is not — a sale can only
    ///      move every ratio here downward whatever the true NAV is. Pause, then inline
    ///      sync (H8), then freshness; after this `lastAbsorbedAcceptedAt` equals the
    ///      oracle's `acceptedAt` by construction.
    function _requireCurrentNavIfIncreasing(int256 delta) internal {
        if (delta <= 0) return;
        if (protocolPause.paused()) revert ProtocolPaused();
        _syncIfNewer();
        if (!oracle.isFresh(navFeedId)) revert StaleValuation(navFeedId);
    }

    /// @notice NAV revaluation from price movement alone — no subscription/redemption
    ///         and no trade. This is the trigger Art 49(2) names explicitly ("breached
    ///         due to market movements"); onMint/onBurn cannot produce it, since they
    ///         only fire on capital moving, not on a held security's price moving.
    /// @dev    Permissionless on purpose. The figure it pulls is already guarded by the
    ///         oracle's own sources, quorum and deviation band, so a role check here would
    ///         protect nothing and would hand whoever holds that role the power to suppress
    ///         an Art 49(2) passive breach by simply not calling. Never reverts; with
    ///         nothing new it is a passive recheck (which re-sums the 40% band).
    function syncNav() external {
        _syncIfNewer();
        _recheckAll();
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

    // ═══════════════════════════════════════════════════════════════════════
    // NUMERATORS — move when the ManCo trades/reclassifies a holding. This is
    // the "active" path: if THIS trade pushes a bucket over its ceiling,
    // revert. Reducing exposure is always allowed even mid-breach.
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Record a trade AND the leg's classification. The classification is what
    ///         every later `syncLegValuation(legId)` books under — it is never taken from
    ///         a sync caller (H5). Reclassifying a leg with a live value (new `entityId`,
    ///         flipped `isNonUcits`) MOVES that value between the affected aggregates so
    ///         the roll-ups stay exact; changing `legType` is refused.
    /// @param legId       Issuer / bank / counterparty / fund identifier for this leg. Also
    ///                    its feed id in the oracle.
    /// @param legType     Which of the four leg categories this leg belongs to. Fixed on
    ///                    first record.
    /// @param entityId    The single-entity grouping this leg rolls up into, for the 20%
    ///                    combined check (e.g. an issuer and its affiliate bank share an entityId).
    /// @param delta       Positive = buy/increase, negative = sell/decrease. Applied ON TOP
    ///                    of the oracle's current figure for this leg when increasing.
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
        _requireCurrentNavIfIncreasing(delta);
        _classify(legId, legType, entityId, isNonUcits, counterpartyIsCreditInstitution);

        // Acquisition adopts the oracle's figure for THIS leg before booking the ManCo's
        // delta on top — otherwise a nominal delta passes the active check on a value the
        // feed has since moved. A brand-new leg has no position for the feed to value, so
        // only feed liveness is required there and the delta IS the opening value.
        if (delta > 0) {
            if (!oracle.isFresh(legId)) revert StaleValuation(legId);
            if (_currentLegValue(legId, legType) != 0) _adoptLegValue(legId, oracle.value(legId));
        }
        _applyLegDelta(legId, delta, true);
    }

    /// @notice Pull this leg's current market value from the oracle and book the difference.
    ///         Passive by construction: never reverts on a breach, only flags/clears/alerts.
    ///         Classification is read from `legMeta`, never supplied.
    /// @dev    Permissionless. The figure is guarded by the oracle; the classification is
    ///         guarded by `onlyManco` at trade time; nothing is left for a caller to corrupt.
    ///         Fails closed on a stale or halted leg feed — a passive sync that adopted an
    ///         unverifiable figure would be a passive corruption.
    function syncLegValuation(bytes32 legId) external {
        if (!legMeta[legId].recorded) revert UnknownLeg(legId);
        _adoptLegValue(legId, oracle.value(legId)); // reverts on stale/halted — fail closed
    }

    function _adoptLegValue(bytes32 legId, uint256 published) internal {
        uint256 current = _currentLegValue(legId, legMeta[legId].legType);
        if (published == current) return;
        int256 delta = published > current ? int256(published - current) : -int256(current - published);
        _applyLegDelta(legId, delta, false);
        emit LegValuationSynced(legId, current, published, uint64(block.timestamp));
    }

    function _classify(bytes32 legId, LegType legType, bytes32 entityId, bool isNonUcits, bool isCreditInst)
        internal
    {
        LegMeta storage m = legMeta[legId];
        if (!m.recorded) {
            m.recorded = true;
            m.legType = legType;
            m.entityId = entityId;
            m.isNonUcits = isNonUcits;
            m.isCreditInstitution = isCreditInst;
            emit LegClassified(legId, legType, entityId, isNonUcits, isCreditInst);
            return;
        }
        if (m.legType != legType) revert LegTypeMismatch(legId, m.legType, legType);

        uint256 live = _currentLegValue(legId, legType);
        bool changed;
        if (legType != LegType.FundOfFunds && m.entityId != entityId) {
            combinedEntityValue[m.entityId] = _sub(combinedEntityValue[m.entityId], live);
            combinedEntityValue[entityId] += live;
            m.entityId = entityId;
            changed = true;
        }
        if (legType == LegType.FundOfFunds && m.isNonUcits != isNonUcits) {
            nonUcitsAggregateValue = isNonUcits ? nonUcitsAggregateValue + live : _sub(nonUcitsAggregateValue, live);
            m.isNonUcits = isNonUcits;
            changed = true;
        }
        if (legType == LegType.DerivativeCounterparty && m.isCreditInstitution != isCreditInst) {
            m.isCreditInstitution = isCreditInst;
            changed = true;
        }
        if (changed) emit LegClassified(legId, legType, m.entityId, m.isNonUcits, m.isCreditInstitution);
    }

    function _currentLegValue(bytes32 legId, LegType legType) internal view returns (uint256) {
        if (legType == LegType.Issuer) return issuerValue[legId];
        if (legType == LegType.BankDeposit) return depositValue[legId];
        if (legType == LegType.DerivativeCounterparty) return derivativeValue[legId];
        return fundOfFundsValue[legId];
    }

    /// @param active  True for a ManCo-directed trade (can revert on active breach);
    ///                false for a price-driven revaluation (never reverts).
    function _applyLegDelta(bytes32 legId, int256 delta, bool active) internal {
        LegMeta storage m = legMeta[legId];
        LegType legType = m.legType;
        bool worsening = active && delta > 0;
        bytes32 bucket = legBucket(legId, legType);

        if (legType == LegType.Issuer) {
            uint256 after_ = _applyDelta(issuerValue[legId], delta);
            issuerValue[legId] = after_;
            _trackIssuer(legId, after_);

            // A-9(b): while the band is breached, a buy that leaves this issuer at or below
            // 5% adds nothing to the basket and must pass; only a band-INCREASING buy is
            // blocked. So the aggregate is re-summed before and after, and "worsening" for
            // the band bucket means the sum actually rose.
            uint256 bandBefore = issuerBandAggregateValue;
            uint256 bandAfter = _recomputeIssuerBand();

            _checkCeiling(bucket, after_, ISSUER_HARD_CAP_BPS, worsening);
            _checkCeiling(BUCKET_ISSUER_BAND, bandAfter, ISSUER_BAND_AGGREGATE_BPS, worsening && bandAfter > bandBefore);
            _rollUpCombined(m.entityId, delta, worsening);
        } else if (legType == LegType.BankDeposit) {
            depositValue[legId] = _applyDelta(depositValue[legId], delta);
            _checkCeiling(bucket, depositValue[legId], BANK_DEPOSIT_CEILING_BPS, worsening);
            _rollUpCombined(m.entityId, delta, worsening);
        } else if (legType == LegType.DerivativeCounterparty) {
            derivativeValue[legId] = _applyDelta(derivativeValue[legId], delta);
            uint256 cap = m.isCreditInstitution
                ? DERIVATIVE_COUNTERPARTY_CREDIT_INST_CEILING_BPS
                : DERIVATIVE_COUNTERPARTY_CEILING_BPS;
            _checkCeiling(bucket, derivativeValue[legId], cap, worsening);
            _rollUpCombined(m.entityId, delta, worsening);
        } else {
            // FundOfFunds — not part of the combined single-entity roll-up; it's a separate cap family.
            fundOfFundsValue[legId] = _applyDelta(fundOfFundsValue[legId], delta);
            uint256 perFundCap = m.isNonUcits ? nonUcitsCiuLimitBps : FOF_PER_UCITS_CEILING_BPS;
            _checkCeiling(bucket, fundOfFundsValue[legId], perFundCap, worsening);
            if (m.isNonUcits) {
                nonUcitsAggregateValue = _applyDelta(nonUcitsAggregateValue, delta);
                _checkCeiling(BUCKET_FOF_NON_UCITS, nonUcitsAggregateValue, FOF_NON_UCITS_AGGREGATE_CEILING_BPS, worsening);
            }
        }
    }

    function _rollUpCombined(bytes32 entityId, int256 delta, bool worsening) internal {
        combinedEntityValue[entityId] = _applyDelta(combinedEntityValue[entityId], delta);
        _checkCeiling(entityBucket(entityId), combinedEntityValue[entityId], COMBINED_SINGLE_ENTITY_CEILING_BPS, worsening);
    }

    // ─────────────────────────── issuer set + 40% band ──────────────────────

    /// @dev Keeps `_issuerIds` = issuers with a non-zero value. Bounded at MAX_ISSUERS.
    function _trackIssuer(bytes32 issuerId, uint256 valueAfter) internal {
        uint256 idxPlusOne = _issuerIndexPlusOne[issuerId];
        if (valueAfter != 0 && idxPlusOne == 0) {
            if (_issuerIds.length >= MAX_ISSUERS) revert TooManyIssuers();
            _issuerIds.push(issuerId);
            _issuerIndexPlusOne[issuerId] = _issuerIds.length;
        } else if (valueAfter == 0 && idxPlusOne != 0) {
            uint256 last = _issuerIds.length - 1;
            bytes32 moved = _issuerIds[last];
            _issuerIds[idxPlusOne - 1] = moved;
            _issuerIndexPlusOne[moved] = idxPlusOne;
            _issuerIds.pop();
            delete _issuerIndexPlusOne[issuerId];
        }
    }

    /// @dev Σ issuerValue over issuers strictly above 5% of the CURRENT `nav()`. Written
    ///      back to `issuerBandAggregateValue` so the public view is always the last
    ///      computed figure. O(|_issuerIds|) ≤ O(MAX_ISSUERS).
    function _recomputeIssuerBand() internal returns (uint256 sum) {
        uint256 threshold = (ISSUER_SOFT_CAP_BPS * nav()) / BPS_DENOM;
        uint256 n = _issuerIds.length;
        for (uint256 i = 0; i < n; i++) {
            uint256 v = issuerValue[_issuerIds[i]];
            if (v > threshold) sum += v;
        }
        issuerBandAggregateValue = sum;
    }

    function issuerIds() external view returns (bytes32[] memory) {
        return _issuerIds;
    }

    /// @dev Passive re-check — never reverts, only flags/clears/alerts. Sweeps the two
    ///      aggregates AND every live issuer's hard cap (the issuer set is enumerable now).
    ///      Bank, counterparty, entity and CIU buckets are still touch-time only; they are
    ///      unbounded sets and their caps do not depend on each other the way the band does.
    function _recheckAll() internal {
        uint256 band = _recomputeIssuerBand();
        _checkCeiling(BUCKET_ISSUER_BAND, band, ISSUER_BAND_AGGREGATE_BPS, false);
        _checkCeiling(BUCKET_FOF_NON_UCITS, nonUcitsAggregateValue, FOF_NON_UCITS_AGGREGATE_CEILING_BPS, false);
        uint256 n = _issuerIds.length;
        for (uint256 i = 0; i < n; i++) {
            bytes32 id = _issuerIds[i];
            _checkCeiling(legBucket(id, LegType.Issuer), issuerValue[id], ISSUER_HARD_CAP_BPS, false);
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CEILING CHECK
    // ═══════════════════════════════════════════════════════════════════════

    function _checkCeiling(bytes32 bucket, uint256 numerator, uint256 ceilingBps, bool causedByThisCall) internal {
        uint256 navNow = nav();
        if (navNow == 0) {
            if (causedByThisCall) revert NavZero();
            return;
        }

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

    function _sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return b > a ? 0 : a - b;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 56 RAMP-UP WINDOW — six months from AUTHORISATION, hard expiry, not
    // renewable. Before it lapses, an active-breach revert is suppressed
    // (flagged instead).
    // ═══════════════════════════════════════════════════════════════════════

    function _rampUpCovers() internal view returns (bool) {
        return block.timestamp < authorisedAt + RAMP_UP_DURATION;
    }
}
