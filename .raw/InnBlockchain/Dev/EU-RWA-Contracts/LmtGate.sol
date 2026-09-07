// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ValuationOracle} from "./ValuationOracle.sol";

/// @title LmtGate (illustrative sample — not production code)
/// @notice Gates redemption requests through whichever Liquidity Management Tools (LMTs)
///         this fund has selected, per AIFMD II Art 16(2a) / ESMA RTS on LMTs for
///         open-ended AIFs. The RTS catalogue has 8 non-suspension tools; at least 2 of
///         them must be selected before the fund can accept redemption requests at all,
///         and selection is locked once trading opens — real-world selection happens at
///         authorization, not mid-crisis.
/// @dev    Suspension (Art 16(3)-(4)) is deliberately NOT part of the "select >= 2" set: it
///         stays available as a backstop regardless of which tools were chosen, because the
///         softer tools below exist to make suspension unnecessary, not to replace it.
/// @dev    ⚠️ THIS IS WHERE "HALT REDEMPTION ON ORACLE FAILURE" ACTUALLY BITES. The gate cap
///         is a percentage OF NAV, so a stale NAV sizes the window wrong in whichever
///         direction the market moved — and an over-sized window pays early redeemers out
///         of value that belongs to the ones behind them, which is precisely the dilution
///         the LMT catalogue exists to prevent. `requestRedemption`, `processRedemption`
///         and `rollWindow` therefore revert `StaleValuation` rather than transact on a
///         figure nobody can vouch for.
/// @dev    ⚠️ AN EARLIER REVISION SET NAV ONCE IN THE CONSTRUCTOR AND ONLY EVER SUBTRACTED
///         PAYOUTS. That drifts from reality with every market move and never recovers —
///         a fund whose assets halved would still be gating against its launch-day NAV.
///         NAV is now oracle-fed and absolute; payouts are carried separately until the
///         next published figure absorbs them.
/// @dev    ⚠️ NOT YET THE ELTIF RTS Art 5(5)–(6) CAP. That formula sizes the maximum
///         redeemable amount off the Art 9(1)(b) LIQUID-ASSET BUCKET plus a prudently
///         forecast 12-month cash flow (excluding new-subscription and long-term-disposal
///         proceeds), selected from the Annex I notice-period grid or the Annex II
///         minimum-liquid-assets grid. What is modelled below is the AIFMD II Art 16(2a) /
///         RTS Annex V toolkit, capping on redeemable NAV. An ELTIF deployment needs the
///         liquid bucket and the forecast as two further fed inputs, under the same
///         staleness discipline as the NAV feed.
contract LmtGate {
    // ─────────────────────────── LMT catalogue ──────────────────────────────

    // ESMA RTS Annex V lists 8 non-suspension LMTs; all 8 are modelled here even though
    // some collapse to the same payout-haircut mechanic below — they're legally distinct
    // tools (different trigger conditions, disclosure duties) even where the cash effect
    // on the redeemer looks identical in this simplified sample.
    enum LmtType {
        SwingPricing, // NAV moved by estimated liquidation cost, triggered only on net outflow days
        DualPricing, // standing bid/offer spread, applies to every subscription/redemption, not just net-outflow days
        AntiDilutionLevy, // explicit fee sized to estimated liquidation cost, itemised separately from NAV
        RedemptionFee, // flat/tiered fee not tied to estimated liquidation cost at all
        RedemptionGate, // caps % of NAV payable per window, pro-rates/carries the rest
        NoticePeriod, // delay between request and payout
        SidePocket, // illiquid/hard-to-value assets excluded from the redeemable NAV base
        RedemptionInKind // payout in portfolio assets instead of cash
    }

    uint256 public constant MIN_SELECTED_TOOLS = 2;
    uint256 public constant BPS_DENOM = 10000;

    // ─────────────────────────── roles ──────────────────────────────────────

    address public immutable aifm;
    address public immutable regulator; // Art 25 — may force-enable a tool post-launch

    /// @dev NOT immutable — DORA Art 28 requires the oracle stay "swappable at the contract
    ///      layer, not hard-wired"; a constructor-set immutable reference makes a provider
    ///      swap a redeploy of this module, which on a live fund is a re-issuance.
    ValuationOracle public oracle; // marks NAV to market — absolute, never delta
    bytes32 public immutable navFeedId; // this fund's NAV identity in the oracle

    // ─────────────────────────── selection state ─────────────────────────────

    mapping(LmtType => bool) public selected;
    uint256 public selectedCount;
    bool public selectionLocked;

    // ─────────────────────────── tool parameters (only meaningful if selected) ──

    uint256 public swingFactorBps; // SwingPricing — cost charged to redeemer on net-outflow days
    uint256 public dualPricingSpreadBps; // DualPricing — standing bid/offer spread
    uint256 public antiDilutionLevyBps; // AntiDilutionLevy — itemised liquidation-cost fee
    uint256 public redemptionFeeBps; // RedemptionFee — flat/tiered fee, not cost-linked
    uint256 public gateCapBps; // RedemptionGate — max % of redeemable NAV payable per window
    uint64 public noticePeriodSeconds; // NoticePeriod — delay before a request becomes payable
    uint256 public sidePocketedBps; // SidePocket — % of NAV carved out of the redeemable base

    /// @notice The last absolute NAV the oracle published, and the cash paid out since.
    ///         Two components rather than one running total, because they fail differently:
    ///         the published figure carries a timestamp and can go stale, while a payout
    ///         this contract made is known exactly and needs no feed.
    uint256 public navAtValuation;
    uint256 public payoutsSinceValuation;

    /// @notice NAV reference the gate cap is sized off, in the fund's reference currency.
    function nav() public view returns (uint256) {
        return payoutsSinceValuation >= navAtValuation ? 0 : navAtValuation - payoutsSinceValuation;
    }

    // ─────────────────────────── redemption window (RedemptionGate bookkeeping) ──

    uint256 public windowCapRemaining;
    uint64 public windowStartedAt;

    // ─────────────────────────── suspension — independent of selection ───────

    bool public suspended;
    uint64 public suspensionStartedAt;

    // ─────────────────────────── redemption requests ─────────────────────────

    struct RedemptionRequest {
        address investor;
        uint256 sharesRequested;
        uint256 cashOwed; // remaining amount still to be paid; shrinks as windows process it
        uint64 requestedAt;
        uint64 payableAt;
        bool inKind;
        bool processed;
    }

    mapping(uint256 => RedemptionRequest) public requests;
    uint256 public nextRequestId;

    // ─────────────────────────── events ───────────────────────────────────────

    event ToolSelected(LmtType indexed tool, bool enabled);
    event SelectionLocked(uint256 selectedCount);
    event RegulatorForcedTool(LmtType indexed tool);
    event WindowRolled(uint64 startedAt, uint256 capRemaining);
    event NavSynced(uint256 navAtValuation, uint256 payoutsAbsorbed, uint64 at);
    event RedemptionRequested(
        uint256 indexed requestId,
        address indexed investor,
        uint256 shares,
        uint64 payableAt
    );
    event RedemptionProcessed(
        uint256 indexed requestId,
        uint256 cashPaid,
        bool inKind,
        uint256 carriedToNextWindow
    );
    event SuspensionActivated(uint64 startedAt);
    event SuspensionLifted(uint64 endedAt);
    /// @dev DORA Art 28 provider swap — the on-chain half of an event whose Register of
    ///      Information entry and NCA pre-notification sit off-chain.
    event OracleChanged(address indexed previous, address indexed next);

    // ─────────────────────────── errors ────────────────────────────────────────

    error NotAifm();
    error NotRegulator();
    error SelectionAlreadyLocked();
    error SelectionNotLocked();
    error NotEnoughToolsSelected(uint256 selectedCount);
    error FundSuspended();
    error NotPayableYet(uint64 payableAt);
    /// @dev The NAV feed is not current, so the gate cap cannot be sized. §5: "oracle
    ///      failure must HALT issuance/redemption, not pass a stale limit."
    error StaleValuation(bytes32 navFeedId);
    error AlreadyProcessed();
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

    /// @notice Repoint the NAV feed at a different `ValuationOracle` deployment.
    /// @dev    DORA Art 28 swappability. Authority is the AIFM's, per §5's delegation note —
    ///         parameter-setting stays with the AIFM's governance, the technology provider is
    ///         infrastructure. ⚠️ Does not re-read NAV: adopting a new oracle's figure inside
    ///         an administrative call would resize the gate cap with no valuation event, and
    ///         an over-sized window pays early redeemers out of the ones behind them. Call
    ///         `syncNav()` after — it fails closed if the new feed is not fresh.
    function setOracle(address oracle_) external onlyAifm {
        if (oracle_ == address(0)) revert ZeroAddress();
        emit OracleChanged(address(oracle), oracle_);
        oracle = ValuationOracle(oracle_);
    }

    modifier freshNav() {
        if (!oracle.isFresh(navFeedId)) revert StaleValuation(navFeedId);
        _;
    }

    constructor(address aifm_, address regulator_, address oracle_, bytes32 navFeedId_) {
        aifm = aifm_;
        regulator = regulator_;
        oracle = ValuationOracle(oracle_);
        navFeedId = navFeedId_;
    }

    /// @notice Pull the current NAV from the oracle and absorb the payouts made since.
    /// @dev    Permissionless. The figure is guarded by the oracle's own sources, quorum
    ///         and deviation band; gating this call would let whoever holds the role keep
    ///         an over-sized redemption window open by simply not refreshing it.
    function syncNav() external {
        uint256 published = oracle.value(navFeedId); // reverts on stale/halted — fail closed
        uint256 absorbed = payoutsSinceValuation;
        navAtValuation = published;
        payoutsSinceValuation = 0;
        emit NavSynced(published, absorbed, uint64(block.timestamp));
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SELECTION — pick >= 2 tools, configure their parameters, then lock.
    // Locking is one-way: this models the tools being fixed at authorization,
    // not something the AIFM reaches for mid-run once redemptions spike.
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

    /// @dev `freshNav` because locking rolls the first redemption window, and a window
    ///      sized off an unpublished NAV is either zero-capped or wrong. The fund does not
    ///      open for redemptions before it has been valued.
    function lockSelection() external onlyAifm freshNav {
        if (selectionLocked) revert SelectionAlreadyLocked();
        if (selectedCount < MIN_SELECTED_TOOLS)
            revert NotEnoughToolsSelected(selectedCount);
        selectionLocked = true;
        _rollWindow();
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
    // REDEMPTION WINDOW — RedemptionGate spends down a per-window cash cap
    // sized off redeemable NAV (NAV minus any SidePocket carve-out). Only
    // meaningful if RedemptionGate is selected; otherwise the cap is unbounded.
    // ═══════════════════════════════════════════════════════════════════════

    function rollWindow() external onlyAifm freshNav {
        _rollWindow();
    }

    function _rollWindow() internal {
        windowStartedAt = uint64(block.timestamp);
        windowCapRemaining = selected[LmtType.RedemptionGate]
            ? (_redeemableNav() * gateCapBps) / BPS_DENOM
            : type(uint256).max;
        emit WindowRolled(windowStartedAt, windowCapRemaining);
    }

    function _redeemableNav() internal view returns (uint256) {
        uint256 navNow = nav();
        if (!selected[LmtType.SidePocket]) return navNow;
        return navNow - (navNow * sidePocketedBps) / BPS_DENOM;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // REDEMPTION REQUESTS
    // ═══════════════════════════════════════════════════════════════════════

    /// @param cashValue  The cash value of the shares being redeemed, priced by whoever
    ///                   marks NAV/share for this fund — same convention as the cash-only
    ///                   inputs used across the other sample contracts in this folder.
    function requestRedemption(
        uint256 shares,
        uint256 cashValue
    ) external freshNav returns (uint256 requestId) {
        if (!selectionLocked) revert SelectionNotLocked();
        if (suspended) revert FundSuspended();

        uint64 payableAt = uint64(block.timestamp) +
            (selected[LmtType.NoticePeriod] ? noticePeriodSeconds : 0);

        requestId = nextRequestId++;
        requests[requestId] = RedemptionRequest({
            investor: msg.sender,
            sharesRequested: shares,
            cashOwed: cashValue,
            requestedAt: uint64(block.timestamp),
            payableAt: payableAt,
            inKind: selected[LmtType.RedemptionInKind],
            processed: false
        });

        emit RedemptionRequested(requestId, msg.sender, shares, payableAt);
    }

    /// @notice Applies whichever tools are selected: the notice-period delay is enforced by
    ///         `payableAt` above, then every active cost-based tool (swing pricing, dual
    ///         pricing, ADL, redemption fee) haircuts the payout, then the redemption gate
    ///         caps how much of it this window can actually pay. Whatever the cap can't
    ///         cover carries forward to the next window — a gated investor is queued, never
    ///         force-cashed-out below the gate and never left in front of it.
    /// @dev    A real fund picks 2 tools, not all 8 stacked — this sums whichever subset is
    ///         active so the sample stays correct no matter which combination was selected.
    function processRedemption(uint256 requestId) external onlyAifm freshNav {
        if (suspended) revert FundSuspended();

        RedemptionRequest storage r = requests[requestId];
        if (r.processed) revert AlreadyProcessed();
        if (block.timestamp < r.payableAt) revert NotPayableYet(r.payableAt);

        uint256 payout = r.cashOwed;

        uint256 haircutBps;
        if (selected[LmtType.SwingPricing]) haircutBps += swingFactorBps;
        if (selected[LmtType.DualPricing]) haircutBps += dualPricingSpreadBps;
        if (selected[LmtType.AntiDilutionLevy]) haircutBps += antiDilutionLevyBps;
        if (selected[LmtType.RedemptionFee]) haircutBps += redemptionFeeBps;
        if (haircutBps > 0) {
            payout -= (payout * haircutBps) / BPS_DENOM;
        }

        uint256 carry = 0;
        if (selected[LmtType.RedemptionGate]) {
            if (payout > windowCapRemaining) {
                carry = payout - windowCapRemaining;
                payout = windowCapRemaining;
            }
            windowCapRemaining -= payout;
        }

        r.cashOwed = carry;
        r.processed = carry == 0;
        payoutsSinceValuation += payout;

        emit RedemptionProcessed(requestId, payout, r.inKind, carry);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SUSPENSION — independent of the selected-tools set, available to the
    // AIFM regardless of which 2+ tools were chosen.
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
