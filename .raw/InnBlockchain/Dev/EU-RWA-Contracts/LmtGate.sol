// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IValuationFeed, IProtocolPause, ISecurityToken, IIdentityGate, IRestrictedParty} from "./Interfaces.sol";

/// @title LmtGate (illustrative sample — not production code)
/// @notice Gates redemption requests through whichever Liquidity Management Tools (LMTs)
///         this fund has selected, per AIFMD Art 16 / Annex V (as inserted by AIFMD II).
///         Annex V lists nine tools; at least two from points 2–8 must be selected before
///         the fund can accept redemption requests at all, and selection is locked once
///         trading opens — real-world selection happens at authorization, not mid-crisis.
/// @dev    Suspension (Annex V point 1) is deliberately NOT part of the "select >= 2" set: it
///         stays available as a backstop regardless of which tools were chosen, because the
///         softer tools below exist to make suspension unnecessary, not to replace it.
/// @dev    ⚠️ THIS IS WHERE "HALT REDEMPTION ON ORACLE FAILURE" ACTUALLY BITES. The gate cap
///         is a percentage OF NAV, so a stale NAV sizes the window wrong in whichever
///         direction the market moved — and an over-sized window pays early redeemers out
///         of value that belongs to the ones behind them, which is precisely the dilution
///         the LMT catalogue exists to prevent. Every window-sizing and pricing path syncs
///         the oracle's current figure inline (H8) and then reverts `StaleValuation` rather
///         than transact on a figure nobody can vouch for.
/// @dev    ⚠️ DEALING-DAY MODEL, PRO-RATA (M-F2, ELTIF Art 18(2)(e), eltif-checklist.md §9.2).
///         Requests accumulate into the OPEN window. `rollWindow` CLOSES it: the cap is sized
///         off redeemable NAV at close, `payoutRatioBps = min(1, cap / requested)` is fixed,
///         and a new window opens. A closed window's requests are then processed in any
///         order, each paying `owed × ratio`; the unpaid remainder is carried into the open
///         window as a new claim at full value. First-come-first-paid is gone: within a
///         window every redeemer takes the same haircut on the same day. A window cannot be
///         rolled before `minWindowSeconds` have elapsed, so the AIFM cannot re-size after
///         every payout.
/// @dev    ⚠️ COST-BASED TOOLS ARE APPLIED ONCE, AT REQUEST. Swing pricing, dual pricing, ADL
///         and the redemption fee haircut the GROSS cash value once when the request is
///         priced; a carried remainder is already net and is never haircut again (the
///         double-haircut of the earlier revision). Net-outflow-triggered swing is not
///         modelled — the factor applies whenever the tool is selected.
/// @dev    ⚠️ WHAT `processRedemption` DOES AND DOES NOT MOVE. It burns the paid-out units
///         through the token (this contract must be a registered token agent) and records
///         the cash owed. THE CASH LEG IS OFF-CHAIN / `DistributionAgent`: the issuer-funded
///         pool pays the recorded amount. Both mandatory-layer gates run on the redeemer at
///         request AND at processing — a listed holder is not paid; their request simply
///         stays pending behind the store's own argument-free error.
/// @dev    ⚠️ NOT YET THE ELTIF RTS Art 5(5)–(6) CAP. That formula sizes the maximum
///         redeemable amount off the Art 9(1)(b) LIQUID-ASSET BUCKET plus a prudently
///         forecast 12-month cash flow (excluding new-subscription and long-term-disposal
///         proceeds), selected from the Annex I notice-period grid or the Annex II
///         minimum-liquid-assets grid. What is modelled below is the AIFMD Art 16 /
///         Annex V toolkit, capping on redeemable NAV. An ELTIF deployment needs the
///         liquid bucket and the forecast as two further fed inputs, under the same
///         staleness discipline as the NAV feed.
contract LmtGate {
    // ─────────────────────────── LMT catalogue ──────────────────────────────

    /// @dev Annex V (AIFMD, as inserted by Directive (EU) 2024/927) point numbers:
    ///        1 Suspension of subscriptions, repurchases and redemptions — `suspended`, not here
    ///        2 Redemption gates            — RedemptionGate
    ///        3 Extension of notice periods — NoticePeriod
    ///        4 Redemption fees             — RedemptionFee
    ///        5 Swing pricing               — SwingPricing
    ///        6 Dual pricing                — DualPricing
    ///        7 Anti-dilution levy          — AntiDilutionLevy
    ///        8 Redemptions in kind         — RedemptionInKind
    ///        9 Side pockets                — SidePocket
    ///      All are modelled even though some collapse to the same payout-haircut mechanic —
    ///      they are legally distinct tools (different triggers, disclosure duties) even
    ///      where the cash effect on the redeemer looks identical in this sample.
    enum LmtType {
        SwingPricing, // 5
        DualPricing, // 6
        AntiDilutionLevy, // 7
        RedemptionFee, // 4
        RedemptionGate, // 2
        NoticePeriod, // 3
        SidePocket, // 9 — does NOT count toward the selection minimum
        RedemptionInKind // 8
    }

    uint256 public constant MIN_SELECTED_TOOLS = 2;
    uint256 public constant BPS_DENOM = 10000;

    // ─────────────────────────── roles ──────────────────────────────────────

    /// @dev NOT immutable (M-F6). Two-step, same pattern as the oracle's governance.
    address public aifm;
    address public pendingAifm;
    address public regulator; // Art 25 — may force-enable a tool post-launch

    /// @dev NOT immutable — DORA Art 28 requires the oracle stay "swappable at the contract
    ///      layer, not hard-wired"; a constructor-set immutable reference makes a provider
    ///      swap a redeploy of this module, which on a live fund is a re-issuance.
    ///      Typed as the interface, never the concrete oracle (design §3 rev-38 rule).
    IValuationFeed public oracle; // marks NAV to market — absolute, never delta
    bytes32 public immutable navFeedId; // this fund's NAV identity in the oracle

    /// @dev Read on WINDOW-SIZING paths (`lockSelection`, `rollWindow`) only. A request or
    ///      a processing run is a disposal from the holder's side and executes during an
    ///      incident — the oracle halt already stops both through freshness.
    IProtocolPause public protocolPause;

    /// @dev The fund's unit token. Read for balance and supply; burned on payout.
    ISecurityToken public token;
    /// @dev Mandatory layer, both limbs, on the redeemer — at request and at processing.
    IIdentityGate public identity;
    IRestrictedParty public restrictions;

    // ─────────────────────────── selection state ─────────────────────────────

    mapping(LmtType => bool) public selected;
    uint256 public selectedCount;
    bool public selectionLocked;

    // ─────────────────────────── tool parameters (only meaningful if selected) ──

    uint256 public swingFactorBps; // SwingPricing — cost charged to redeemer
    uint256 public dualPricingSpreadBps; // DualPricing — standing bid/offer spread
    uint256 public antiDilutionLevyBps; // AntiDilutionLevy — itemised liquidation-cost fee
    uint256 public redemptionFeeBps; // RedemptionFee — flat/tiered fee, not cost-linked
    uint256 public gateCapBps; // RedemptionGate — max % of redeemable NAV payable per window
    uint64 public noticePeriodSeconds; // NoticePeriod — delay before a request becomes payable
    uint256 public sidePocketedBps; // SidePocket — % of NAV carved out of the redeemable base

    /// @notice Floor on window length. The AIFM may not close a window before this many
    ///         seconds have elapsed since it opened, so the cap cannot be re-sized after
    ///         every payout (M-F2). Governance-set; > 0.
    uint64 public minWindowSeconds;

    /// @notice The last absolute NAV the oracle published, and the cash paid out since.
    ///         Two components rather than one running total, because they fail differently:
    ///         the published figure carries a timestamp and can go stale, while a payout
    ///         this contract made is known exactly and needs no feed.
    uint256 public navAtValuation;
    /// @notice Zeroed only when a NEWER oracle acceptance is absorbed (H6).
    uint256 public payoutsSinceValuation;
    uint64 public lastAbsorbedAcceptedAt;

    /// @notice NAV reference the gate cap is sized off, in the fund's reference currency.
    function nav() public view returns (uint256) {
        return payoutsSinceValuation >= navAtValuation ? 0 : navAtValuation - payoutsSinceValuation;
    }

    // ─────────────────────────── redemption windows ──────────────────────────

    struct Window {
        uint64 openedAt;
        uint64 closedAt; // 0 while open
        uint256 cap; // fixed at close; type(uint256).max without a gate
        uint256 requested; // Σ net cashOwed of requests assigned to this window
        uint256 paid; // Σ paid out of this window so far
        uint256 payoutRatioBps; // fixed at close: min(BPS_DENOM, cap × BPS_DENOM / requested)
    }

    mapping(uint256 => Window) public windows;
    /// @notice The OPEN window. Every id below it is closed.
    uint256 public currentWindowId;

    // ─────────────────────────── suspension — independent of selection ───────

    bool public suspended;
    uint64 public suspensionStartedAt;

    // ─────────────────────────── redemption requests ─────────────────────────

    struct RedemptionRequest {
        address investor;
        uint256 sharesRemaining; // units still to be burned as cash is paid
        uint256 cashOwed; // NET remaining amount still to be paid; shrinks as windows process it
        uint256 grossCash; // pre-haircut value at request, for the record
        uint256 windowId; // the window this claim currently sits in
        uint64 requestedAt;
        uint64 payableAt;
        bool inKind;
        bool processed;
        bool cancelled;
    }

    mapping(uint256 => RedemptionRequest) public requests;
    uint256 public nextRequestId;

    // ─────────────────────────── events ───────────────────────────────────────

    event ToolSelected(LmtType indexed tool, bool enabled);
    event SelectionLocked(uint256 selectedCount);
    event RegulatorForcedTool(LmtType indexed tool);
    event WindowClosed(uint256 indexed windowId, uint256 cap, uint256 requested, uint256 payoutRatioBps);
    event WindowOpened(uint256 indexed windowId, uint64 openedAt);
    event MinWindowSecondsSet(uint64 oldValue, uint64 newValue);
    /// @dev Emitted only when a NEWER oracle acceptance was absorbed.
    event NavSynced(uint256 navAtValuation, uint256 payoutsAbsorbed, uint64 acceptedAt);
    event RedemptionRequested(
        uint256 indexed requestId,
        address indexed investor,
        uint256 shares,
        uint256 grossCash,
        uint256 netCash,
        uint256 indexed windowId,
        uint64 payableAt
    );
    /// @dev `windowId` is the closed window the payout came from; `carriedToWindow` is the
    ///      open window the remainder moved to, or 0 when nothing was carried (window 0 is
    ///      always closed by the time anything is processed, so 0 is unambiguous).
    event RedemptionProcessed(
        uint256 indexed requestId,
        uint256 indexed windowId,
        uint256 cashPaid,
        uint256 sharesBurned,
        bool inKind,
        uint256 carriedToWindow
    );
    event RedemptionCancelled(uint256 indexed requestId, uint256 cashReleased);
    event SuspensionActivated(uint64 startedAt);
    event SuspensionLifted(uint64 endedAt);
    /// @dev DORA Art 28 provider swap — the on-chain half of an event whose Register of
    ///      Information entry and NCA pre-notification sit off-chain.
    event OracleChanged(address indexed previous, address indexed next);
    event ProtocolPauseChanged(address indexed previous, address indexed next);
    event TokenChanged(address indexed previous, address indexed next);
    event IdentityChanged(address indexed previous, address indexed next);
    event RestrictionsChanged(address indexed previous, address indexed next);
    event AifmTransferProposed(address indexed current, address indexed proposed);
    event AifmTransferred(address indexed previous, address indexed next);
    event RegulatorChanged(address indexed previous, address indexed next);

    // ─────────────────────────── errors ────────────────────────────────────────

    error NotAifm();
    error NotPendingAifm();
    error NotRegulator();
    error NotInvestorOrAifm();
    error SelectionAlreadyLocked();
    error SelectionNotLocked();
    /// @dev Fewer than two tools from Annex V points 2–8 (aifmd2-checklist.md:36).
    error NotEnoughToolsSelected(uint256 countedSelections);
    /// @dev "May not select only points 5 and 6" — swing pricing and dual pricing alone
    ///      (aifmd2-checklist.md:36; the UCITS mirror at ucits-checklist.md §15.1).
    error SwingAndDualPricingAlone();
    error FundSuspended();
    error NotPayableYet(uint64 payableAt);
    /// @dev The NAV feed is not current, so the gate cap cannot be sized. §5: "oracle
    ///      failure must HALT issuance/redemption, not pass a stale limit."
    error StaleValuation(bytes32 navFeedId);
    error NavZero();
    error NoUnitsOutstanding();
    error ProtocolPaused();
    error WindowTooYoung(uint64 openedAt, uint64 minWindowSeconds);
    /// @dev A request in the OPEN window has no ratio yet; roll the window first.
    error WindowStillOpen(uint256 windowId);
    error AlreadyProcessed();
    error RequestCancelled();
    error InsufficientUnits(uint256 held, uint256 requested);
    error ZeroShares();
    error ZeroWindowFloor();
    error SuspensionAlreadyActive();
    error ZeroAddress();

    modifier onlyAifm() {
        if (msg.sender != aifm) revert NotAifm();
        _;
    }

    modifier onlyRegulator() {
        if (msg.sender != regulator) revert NotRegulator();
        _;
    }

    constructor(
        address aifm_,
        address regulator_,
        address oracle_,
        address protocolPause_,
        address token_,
        address identity_,
        address restrictions_,
        bytes32 navFeedId_,
        uint64 minWindowSeconds_
    ) {
        if (
            aifm_ == address(0) || regulator_ == address(0) || oracle_ == address(0) ||
            protocolPause_ == address(0) || token_ == address(0) || identity_ == address(0) ||
            restrictions_ == address(0)
        ) revert ZeroAddress();
        if (minWindowSeconds_ == 0) revert ZeroWindowFloor();
        aifm = aifm_;
        regulator = regulator_;
        oracle = IValuationFeed(oracle_);
        protocolPause = IProtocolPause(protocolPause_);
        token = ISecurityToken(token_);
        identity = IIdentityGate(identity_);
        restrictions = IRestrictedParty(restrictions_);
        navFeedId = navFeedId_;
        minWindowSeconds = minWindowSeconds_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ROLES AND REFERENCES — rotatable, interface-typed, never null.
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

    function setRegulator(address next) external onlyAifm {
        if (next == address(0)) revert ZeroAddress();
        emit RegulatorChanged(regulator, next);
        regulator = next;
    }

    /// @notice Repoint the NAV feed at a different oracle deployment.
    /// @dev    DORA Art 28 swappability. Authority is the AIFM's, per §5's delegation note —
    ///         parameter-setting stays with the AIFM's governance, the technology provider is
    ///         infrastructure. ⚠️ Does not re-read NAV, and resets the absorbed timestamp so
    ///         the next sync adopts the new oracle's figure whatever its `acceptedAt`.
    ///         Adopting it here would resize the gate cap with no valuation event.
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

    function setToken(address token_) external onlyAifm {
        if (token_ == address(0)) revert ZeroAddress();
        emit TokenChanged(address(token), token_);
        token = ISecurityToken(token_);
    }

    function setIdentity(address identity_) external onlyAifm {
        if (identity_ == address(0)) revert ZeroAddress();
        emit IdentityChanged(address(identity), identity_);
        identity = IIdentityGate(identity_);
    }

    function setRestrictions(address restrictions_) external onlyAifm {
        if (restrictions_ == address(0)) revert ZeroAddress();
        emit RestrictionsChanged(address(restrictions), restrictions_);
        restrictions = IRestrictedParty(restrictions_);
    }

    function setMinWindowSeconds(uint64 seconds_) external onlyAifm {
        if (seconds_ == 0) revert ZeroWindowFloor();
        emit MinWindowSecondsSet(minWindowSeconds, seconds_);
        minWindowSeconds = seconds_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ORACLE SYNC
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Absorb the oracle's NAV iff fresh and strictly newer than the one held. Never
    ///      reverts. `payoutsSinceValuation` is zeroed only inside this condition (H6):
    ///      before, anyone could erase a payout's NAV effect by calling `syncNav()` while
    ///      the oracle still held the pre-payout figure — and the next window would be
    ///      sized off NAV the fund no longer had.
    function _syncIfNewer() internal {
        (uint256 published, uint64 at, bool fresh, ) = oracle.peek(navFeedId);
        if (!fresh || at <= lastAbsorbedAcceptedAt) return;
        uint256 absorbed = payoutsSinceValuation;
        navAtValuation = published;
        payoutsSinceValuation = 0;
        lastAbsorbedAcceptedAt = at;
        emit NavSynced(published, absorbed, at);
    }

    /// @dev Sync, then insist the feed is fresh. After this the figure in `nav()` is the
    ///      oracle's current one by construction (H8).
    function _requireCurrentNav() internal {
        _syncIfNewer();
        if (!oracle.isFresh(navFeedId)) revert StaleValuation(navFeedId);
    }

    /// @notice Pull the current NAV from the oracle if it has moved on and absorb the
    ///         payouts made since.
    /// @dev    Permissionless. The figure is guarded by the oracle's own sources, quorum
    ///         and deviation band; gating this call would let whoever holds the role keep
    ///         an over-sized redemption window open by simply not refreshing it. Never
    ///         reverts; with nothing new it is a no-op.
    function syncNav() external {
        _syncIfNewer();
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SELECTION — pick >= 2 tools from Annex V points 2–8, configure their
    // parameters, then lock. Locking is one-way: this models the tools being
    // fixed at authorization, not something the AIFM reaches for mid-run once
    // redemptions spike.
    // ═══════════════════════════════════════════════════════════════════════

    function setTool(LmtType tool, bool enabled) external onlyAifm {
        if (selectionLocked) revert SelectionAlreadyLocked();
        if (selected[tool] == enabled) return;
        selected[tool] = enabled;
        selectedCount = enabled ? selectedCount + 1 : selectedCount - 1;
        emit ToolSelected(tool, enabled);
    }

    function configureSwingFactor(uint256 bps) external onlyAifm {
        swingFactorBps = bps;
    }

    function configureDualPricingSpread(uint256 bps) external onlyAifm {
        dualPricingSpreadBps = bps;
    }

    function configureAntiDilutionLevy(uint256 bps) external onlyAifm {
        antiDilutionLevyBps = bps;
    }

    function configureRedemptionFee(uint256 bps) external onlyAifm {
        redemptionFeeBps = bps;
    }

    function configureGateCap(uint256 bps) external onlyAifm {
        gateCapBps = bps;
    }

    function configureNoticePeriod(uint64 seconds_) external onlyAifm {
        noticePeriodSeconds = seconds_;
    }

    function configureSidePocket(uint256 bps) external onlyAifm {
        sidePocketedBps = bps;
    }

    /// @notice Tools that count toward the Annex V selection minimum: points 2–8.
    ///         Side pockets (point 9) and suspension (point 1) do not (M-F3).
    function countedSelections() public view returns (uint256 n) {
        if (selected[LmtType.RedemptionGate]) n++;
        if (selected[LmtType.NoticePeriod]) n++;
        if (selected[LmtType.RedemptionFee]) n++;
        if (selected[LmtType.SwingPricing]) n++;
        if (selected[LmtType.DualPricing]) n++;
        if (selected[LmtType.AntiDilutionLevy]) n++;
        if (selected[LmtType.RedemptionInKind]) n++;
    }

    /// @notice Lock the selection and open the first redemption window.
    /// @dev    Enforces the rule as the checklist states it (aifmd2-checklist.md:36, mirrored
    ///         for UCITS at ucits-checklist.md §15.1): "select at least two from Annex V
    ///         points 2 to 8; may not select only points 5 and 6". The MMF single-tool
    ///         derogation is not modelled — an MMF is a different product.
    ///         Requires a current NAV and no protocol pause because locking opens the first
    ///         window, and a window sized off an unpublished NAV is either zero-capped or
    ///         wrong. The fund does not open for redemptions before it has been valued.
    function lockSelection() external onlyAifm {
        if (selectionLocked) revert SelectionAlreadyLocked();
        uint256 counted = countedSelections();
        if (counted < MIN_SELECTED_TOOLS) revert NotEnoughToolsSelected(counted);
        if (counted == 2 && selected[LmtType.SwingPricing] && selected[LmtType.DualPricing]) {
            revert SwingAndDualPricingAlone();
        }
        if (protocolPause.paused()) revert ProtocolPaused();
        _requireCurrentNav();
        selectionLocked = true;
        _openWindow(0);
        emit SelectionLocked(selectedCount);
    }

    /// @notice Art 25 — regulator can force a tool on even after lock, if it wasn't chosen.
    ///         One-directional, same pattern as ceiling-tightening elsewhere: adds
    ///         protection, never removes a tool the AIFM already selected.
    function forceEnableTool(LmtType tool) external onlyRegulator {
        if (!selectionLocked) revert SelectionNotLocked();
        if (!selected[tool]) {
            selected[tool] = true;
            selectedCount += 1;
            emit RegulatorForcedTool(tool);
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // REDEMPTION WINDOW — dealing-day model. `rollWindow` closes the open
    // window (sizing its cap off redeemable NAV = NAV minus any SidePocket
    // carve-out, and fixing the pro-rata ratio) and opens the next.
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Window-sizing path: pause, current NAV, and the `minWindowSeconds` floor.
    function rollWindow() external onlyAifm {
        if (!selectionLocked) revert SelectionNotLocked();
        Window storage w = windows[currentWindowId];
        if (block.timestamp < w.openedAt + minWindowSeconds) revert WindowTooYoung(w.openedAt, minWindowSeconds);
        if (protocolPause.paused()) revert ProtocolPaused();
        _requireCurrentNav();

        uint256 cap = selected[LmtType.RedemptionGate]
            ? (_redeemableNav() * gateCapBps) / BPS_DENOM
            : type(uint256).max;
        uint256 ratio = BPS_DENOM;
        if (w.requested != 0 && cap < w.requested) {
            ratio = (cap * BPS_DENOM) / w.requested;
        }
        w.closedAt = uint64(block.timestamp);
        w.cap = cap;
        w.payoutRatioBps = ratio;
        emit WindowClosed(currentWindowId, cap, w.requested, ratio);

        _openWindow(currentWindowId + 1);
    }

    function _openWindow(uint256 id) internal {
        currentWindowId = id;
        windows[id].openedAt = uint64(block.timestamp);
        emit WindowOpened(id, uint64(block.timestamp));
    }

    function _redeemableNav() internal view returns (uint256) {
        uint256 navNow = nav();
        if (!selected[LmtType.SidePocket]) return navNow;
        return navNow - (navNow * sidePocketedBps) / BPS_DENOM;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // REDEMPTION REQUESTS
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Queue `shares` for redemption in the open window. Cash value is DERIVED —
    ///         `shares × nav() / totalSupply` — never supplied (M-F2), then haircut once
    ///         by every selected cost-based tool.
    /// @dev    Both mandatory-layer gates run on the caller. The restriction store's error
    ///         is argument-free by design; nothing here adds a reason.
    function requestRedemption(uint256 shares) external returns (uint256 requestId) {
        if (!selectionLocked) revert SelectionNotLocked();
        if (suspended) revert FundSuspended();
        if (shares == 0) revert ZeroShares();
        identity.checkEligible(msg.sender);
        restrictions.assertNotBlocked(msg.sender);

        uint256 held = token.balanceOf(msg.sender);
        if (held < shares) revert InsufficientUnits(held, shares);

        _requireCurrentNav();
        uint256 navNow = nav();
        if (navNow == 0) revert NavZero();
        uint256 supply = token.totalSupply();
        if (supply == 0) revert NoUnitsOutstanding();

        uint256 gross = (shares * navNow) / supply;
        uint256 net = gross - (gross * _haircutBps()) / BPS_DENOM;

        uint64 payableAt = uint64(block.timestamp) + (selected[LmtType.NoticePeriod] ? noticePeriodSeconds : 0);

        requestId = nextRequestId++;
        requests[requestId] = RedemptionRequest({
            investor: msg.sender,
            sharesRemaining: shares,
            cashOwed: net,
            grossCash: gross,
            windowId: currentWindowId,
            requestedAt: uint64(block.timestamp),
            payableAt: payableAt,
            inKind: selected[LmtType.RedemptionInKind],
            processed: false,
            cancelled: false
        });
        windows[currentWindowId].requested += net;

        emit RedemptionRequested(requestId, msg.sender, shares, gross, net, currentWindowId, payableAt);
    }

    /// @dev Σ of every selected cost-based tool's factor. A real fund picks 2 tools, not
    ///      all stacked — this sums whichever subset is active so the sample stays correct
    ///      no matter which combination was selected.
    function _haircutBps() internal view returns (uint256 bps) {
        if (selected[LmtType.SwingPricing]) bps += swingFactorBps;
        if (selected[LmtType.DualPricing]) bps += dualPricingSpreadBps;
        if (selected[LmtType.AntiDilutionLevy]) bps += antiDilutionLevyBps;
        if (selected[LmtType.RedemptionFee]) bps += redemptionFeeBps;
        if (bps > BPS_DENOM) bps = BPS_DENOM;
    }

    /// @notice Withdraw an unprocessed claim. The investor may (they still hold the units);
    ///         so may the AIFM, for a claim that can no longer settle — e.g. the holder
    ///         transferred the units away and the burn would revert forever, depressing
    ///         every other redeemer's ratio in the meantime.
    function cancelRedemption(uint256 requestId) external {
        RedemptionRequest storage r = requests[requestId];
        if (msg.sender != r.investor && msg.sender != aifm) revert NotInvestorOrAifm();
        if (r.processed) revert AlreadyProcessed();
        if (r.cancelled) revert RequestCancelled();
        r.cancelled = true;
        uint256 released = r.cashOwed;
        Window storage w = windows[r.windowId];
        // Only an OPEN window's `requested` is still shaping a ratio; a closed one's is history.
        if (w.closedAt == 0) w.requested -= released;
        r.cashOwed = 0;
        emit RedemptionCancelled(requestId, released);
    }

    /// @notice Settle a claim in a CLOSED window at that window's pro-rata ratio. Burns the
    ///         units paid for, records the cash owed, carries the remainder into the open
    ///         window. The notice-period delay is enforced by `payableAt`.
    /// @dev    Cash moves off-chain / via `DistributionAgent` against the `cashPaid` this
    ///         emits. The redeemer is re-gated here: eligibility can lapse and a listing can
    ///         land between request and processing, and a listed holder is not paid.
    function processRedemption(uint256 requestId) external onlyAifm {
        if (suspended) revert FundSuspended();

        RedemptionRequest storage r = requests[requestId];
        if (r.processed) revert AlreadyProcessed();
        if (r.cancelled) revert RequestCancelled();
        if (block.timestamp < r.payableAt) revert NotPayableYet(r.payableAt);
        uint256 fromWindow = r.windowId;
        Window storage w = windows[fromWindow];
        if (w.closedAt == 0) revert WindowStillOpen(fromWindow);

        identity.checkEligible(r.investor);
        restrictions.assertNotBlocked(r.investor);

        uint256 payout = (r.cashOwed * w.payoutRatioBps) / BPS_DENOM;
        uint256 carry = r.cashOwed - payout;
        // Units burn in the same proportion as cash pays; the last tranche takes every
        // remaining unit so rounding cannot strand dust on the holder.
        uint256 sharesPaid = carry == 0 ? r.sharesRemaining : (r.sharesRemaining * w.payoutRatioBps) / BPS_DENOM;

        w.paid += payout;
        payoutsSinceValuation += payout;
        r.cashOwed = carry;
        r.sharesRemaining -= sharesPaid;

        uint256 carriedTo;
        if (carry == 0) {
            r.processed = true;
        } else {
            // Carried at full value into the open window: already net, never haircut again.
            carriedTo = currentWindowId;
            r.windowId = carriedTo;
            windows[carriedTo].requested += carry;
        }

        if (sharesPaid != 0) token.burn(r.investor, sharesPaid);

        emit RedemptionProcessed(requestId, fromWindow, payout, sharesPaid, r.inKind, carriedTo);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SUSPENSION — Annex V point 1, independent of the selected-tools set,
    // available to the AIFM regardless of which 2+ tools were chosen.
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
}
