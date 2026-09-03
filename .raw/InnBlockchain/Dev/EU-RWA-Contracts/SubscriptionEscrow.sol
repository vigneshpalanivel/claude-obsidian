// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title SubscriptionEscrow (illustrative sample — not production code)
/// @notice Prospectus Regulation Art 3(2)/6/12/17/21/23 — gates a primary token offer on
///         the public-offer threshold, holds subscriptions in escrow while any statutory
///         withdrawal window is open, and enforces the prospectus's 12-month validity.
/// @dev    Two independent regimes, chosen once at deploy and not switchable:
///         - EXEMPT: offer stays under the per-jurisdiction threshold (Art 3(2)) and never
///           had an NCA-approved prospectus. `subscribe()` hard-reverts once the cumulative
///           total for that jurisdiction would cross its elected threshold (EU default
///           €12m/12mo; a Member State may instead elect €5m — binary election, not a
///           sliding floor).
///         - PROSPECTUS: an NCA-approved prospectus is in force, declaring a maximum offer
///           ceiling (Art 6) and, if the final price/amount wasn't fixed at filing, a
///           second withdrawal window under Art 17(2). `subscribe()` hard-reverts past the
///           declared ceiling or past the prospectus's 12-month validity (Art 12) instead.
///         Crossing the exempt threshold does NOT auto-upgrade this contract to PROSPECTUS
///         mode — approval must precede the offer, not follow it, so that step is a
///         deliberate off-chain event (a fresh, NCA-approved prospectus) followed by a
///         fresh deployment or reconfiguration, never an automatic on-chain transition.
/// @dev    "Rolling 12-month" is a calendar concept this sample does not fully model —
///         `jurisdictionRaisedWei` is a simple non-decaying cumulative total, not a true
///         rolling window. A production version needs subscriptions to age out after 12
///         months, fed by an off-chain calendar the same way the withdrawal windows are.
contract SubscriptionEscrow {
    // ─────────────────────────── mode ────────────────────────────────────────

    enum Mode {
        Exempt, // Art 3(2) — under the national threshold, no NCA-approved prospectus
        Prospectus // Art 6 — full NCA-approved prospectus in force
    }

    Mode public immutable mode;

    // ─────────────────────────── roles ──────────────────────────────────────

    address public immutable issuer;
    address public immutable governance; // multisig/timelock — publishes supplements, final price

    // ─────────────────────────── EXEMPT mode: per-jurisdiction threshold ─────

    /// @notice Each Member State's elected exemption ceiling (Art 3(2)), in wei of the
    ///         offer's reference currency. Zero means "not configured" — enforced by
    ///         requiring an explicit `setJurisdictionThreshold` call before any subscription
    ///         from that jurisdiction is accepted, rather than silently defaulting to
    ///         unlimited or to the EU baseline.
    mapping(bytes32 => uint256) public jurisdictionThresholdWei;

    mapping(bytes32 => uint256) public jurisdictionRaisedWei;

    // ─────────────────────────── PROSPECTUS mode: ceiling + validity ─────────

    /// @notice Maximum offer size disclosed in the prospectus (Art 6) — a declared ceiling,
    ///         not a forecast of what will actually be raised. Raising it is a material
    ///         change requiring an Art 23 supplement, same governance path as any other
    ///         prospectus content change.
    uint256 public maxOfferAmountWei;
    uint256 public totalRaisedWei;

    /// @notice Art 12 — prospectus valid 12 months from approval. Past this, `subscribe()`
    ///         reverts regardless of remaining ceiling headroom: an open subscription
    ///         contract past expiry is selling without a valid prospectus — strict
    ///         liability, no ledger signal warns you on its own.
    uint64 public prospectusValidUntil;

    // ─────────────────────────── withdrawal windows ───────────────────────────

    enum WindowType {
        SupplementArt23, // Window A — opens on supplement publication, covers pre-existing subs only
        FinalPriceArt17 // Window B — opens on final price/amount publication, covers the WHOLE offer
    }

    struct Window {
        WindowType kind;
        uint64 opensAt;
        uint64 closesAt;
        uint64 scopeCutoff; // Window A only: subscriptions accepted before this are covered.
        // Ignored for Window B, which covers every subscription regardless of timing.
    }

    Window[] public windows;

    /// @notice Whether the prospectus omitted the final price/amount at filing (Art
    ///         17(1)(b)) — disclosing a maximum price or valuation method instead. If true,
    ///         Window B is expected once the final price is actually published (Art
    ///         17(2)); if the final price was fixed at filing, Window B can never open.
    bool public immutable finalPriceOmittedAtFiling;
    bool public finalPricePublished;

    // ─────────────────────────── window durations (governance-set, not hardcoded) ────

    /// @notice Art 23(2) statutory minimum is 3 working days. Configurable rather than a
    ///         constant because it is a statutory *minimum* an operator could extend, and
    ///         because working-day arithmetic (TARGET2 calendar) is computed off-chain —
    ///         `opensAt`/`closesAt` below are always fed in, never derived from
    ///         block.timestamp on-chain.
    uint64 public supplementWindowDurationSeconds = 3 days;

    /// @notice Art 17(2) base text sets >= 2 working days. Defaulted here to the safer 3
    ///         working days pending an open question on whether the Listing Act's 2->3 day
    ///         extension of Art 23(2) also reached Art 17 — see design doc §16 D10.
    uint64 public finalPriceWindowDurationSeconds = 3 days;

    // ─────────────────────────── subscriptions ────────────────────────────────

    struct Subscription {
        address investor;
        uint256 amountWei;
        uint64 acceptedAt;
        bool withdrawn;
        bool settled;
    }

    mapping(uint256 => Subscription) public subscriptions;
    uint256 public nextSubscriptionId;

    // ─────────────────────────── events ───────────────────────────────────────

    event JurisdictionThresholdSet(bytes32 indexed jurisdiction, uint256 thresholdWei);
    event Subscribed(
        uint256 indexed subscriptionId,
        address indexed investor,
        bytes32 indexed jurisdiction,
        uint256 amountWei
    );
    event SupplementPublished(uint256 indexed windowIndex, uint64 opensAt, uint64 closesAt, uint64 scopeCutoff);
    event FinalPricePublished(uint256 indexed windowIndex, uint64 opensAt, uint64 closesAt);
    event AcceptanceWithdrawn(uint256 indexed subscriptionId, address indexed investor, uint256 refundedWei);
    event Settled(uint256 indexed subscriptionId, address indexed investor, uint256 amountWei);
    event OfferCeilingRaised(uint256 oldCeilingWei, uint256 newCeilingWei);
    event ProspectusValidityExtended(uint64 oldValidUntil, uint64 newValidUntil);

    // ─────────────────────────── errors ────────────────────────────────────────

    error NotGovernance();
    error NotSubscriber();
    error WrongMode();
    error JurisdictionThresholdNotConfigured(bytes32 jurisdiction);
    error ExemptThresholdBreached(bytes32 jurisdiction, uint256 wouldRaiseTo, uint256 thresholdWei);
    error OfferCeilingBreached(uint256 wouldRaiseTo, uint256 ceilingWei);
    error ProspectusExpired(uint64 validUntil);
    error FinalPriceAlreadyPublished();
    error FinalPriceNeverOmitted();
    error NotWithdrawable(uint256 subscriptionId);
    error AlreadyWithdrawn();
    error AlreadySettled();
    error WindowsStillPending();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    /// @param mode_                       Chosen once, at deploy — see contract-level @dev.
    /// @param maxOfferAmountWei_          PROSPECTUS mode only; ignored (must pass 0) in EXEMPT mode.
    /// @param prospectusValidUntil_       PROSPECTUS mode only; ignored (must pass 0) in EXEMPT mode.
    /// @param finalPriceOmittedAtFiling_  PROSPECTUS mode only; ignored (must pass false) in EXEMPT mode.
    constructor(
        address issuer_,
        address governance_,
        Mode mode_,
        uint256 maxOfferAmountWei_,
        uint64 prospectusValidUntil_,
        bool finalPriceOmittedAtFiling_
    ) {
        issuer = issuer_;
        governance = governance_;
        mode = mode_;

        if (mode_ == Mode.Prospectus) {
            maxOfferAmountWei = maxOfferAmountWei_;
            prospectusValidUntil = prospectusValidUntil_;
            finalPriceOmittedAtFiling = finalPriceOmittedAtFiling_;
        } else {
            finalPriceOmittedAtFiling = false;
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // EXEMPT MODE — Art 3(2) per-jurisdiction threshold
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Governance declares each jurisdiction's elected exemption ceiling before any
    ///         subscription from it is accepted. Supply whichever the country in question
    ///         actually elected — do not assume the EU default applies everywhere.
    function setJurisdictionThreshold(bytes32 jurisdiction, uint256 thresholdWei) external onlyGovernance {
        if (mode != Mode.Exempt) revert WrongMode();
        jurisdictionThresholdWei[jurisdiction] = thresholdWei;
        emit JurisdictionThresholdSet(jurisdiction, thresholdWei);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PROSPECTUS MODE — Art 6 ceiling, Art 12 validity
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Raising the disclosed ceiling is itself a material change — same supplement
    ///         gate as any other prospectus content change (Art 23), never a routine
    ///         parameter tweak.
    function raiseOfferCeiling(uint256 newCeilingWei) external onlyGovernance {
        if (mode != Mode.Prospectus) revert WrongMode();
        emit OfferCeilingRaised(maxOfferAmountWei, newCeilingWei);
        maxOfferAmountWei = newCeilingWei;
    }

    /// @notice Only ever called on the back of a fresh NCA approval — never a unilateral
    ///         operator decision to keep an offer open past its statutory 12 months.
    function extendProspectusValidity(uint64 newValidUntil) external onlyGovernance {
        if (mode != Mode.Prospectus) revert WrongMode();
        emit ProspectusValidityExtended(prospectusValidUntil, newValidUntil);
        prospectusValidUntil = newValidUntil;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SUBSCRIPTION — accepted funds sit in this contract (escrow) until every
    // applicable withdrawal window has closed; mode-gated at the door.
    // ═══════════════════════════════════════════════════════════════════════

    function subscribe(bytes32 jurisdiction) external payable returns (uint256 subscriptionId) {
        if (mode == Mode.Exempt) {
            uint256 threshold = jurisdictionThresholdWei[jurisdiction];
            if (threshold == 0) revert JurisdictionThresholdNotConfigured(jurisdiction);

            uint256 wouldRaiseTo = jurisdictionRaisedWei[jurisdiction] + msg.value;
            if (wouldRaiseTo > threshold) {
                revert ExemptThresholdBreached(jurisdiction, wouldRaiseTo, threshold);
            }
            jurisdictionRaisedWei[jurisdiction] = wouldRaiseTo;
        } else {
            if (block.timestamp > prospectusValidUntil) revert ProspectusExpired(prospectusValidUntil);

            uint256 wouldRaiseTo = totalRaisedWei + msg.value;
            if (wouldRaiseTo > maxOfferAmountWei) revert OfferCeilingBreached(wouldRaiseTo, maxOfferAmountWei);
            totalRaisedWei = wouldRaiseTo;
        }

        subscriptionId = nextSubscriptionId++;
        subscriptions[subscriptionId] = Subscription({
            investor: msg.sender,
            amountWei: msg.value,
            acceptedAt: uint64(block.timestamp),
            withdrawn: false,
            settled: false
        });

        emit Subscribed(subscriptionId, msg.sender, jurisdiction, msg.value);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // WINDOW A — Art 23(2) supplement. Opens a >=3-working-day window covering
    // only subscriptions accepted BEFORE the supplement is published.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param opensAt/closesAt  Fed in off-chain against a real working-day calendar
    ///                          (TARGET2) — never computed on-chain from block.timestamp.
    function publishSupplement(
        uint64 opensAt,
        uint64 closesAt
    ) external onlyGovernance returns (uint256 windowIndex) {
        if (mode != Mode.Prospectus) revert WrongMode();

        windowIndex = windows.length;
        windows.push(
            Window({kind: WindowType.SupplementArt23, opensAt: opensAt, closesAt: closesAt, scopeCutoff: opensAt})
        );
        emit SupplementPublished(windowIndex, opensAt, closesAt, opensAt);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // WINDOW B — Art 17(2) final price/amount. Only reachable if the
    // prospectus omitted the final price/amount at filing (Art 17(1)(b)).
    // Covers the WHOLE offer, not just subscriptions before this point —
    // every investor subscribed on an incomplete price, not just early ones.
    // ═══════════════════════════════════════════════════════════════════════

    function publishFinalPrice(
        uint64 opensAt,
        uint64 closesAt
    ) external onlyGovernance returns (uint256 windowIndex) {
        if (mode != Mode.Prospectus) revert WrongMode();
        if (!finalPriceOmittedAtFiling) revert FinalPriceNeverOmitted();
        if (finalPricePublished) revert FinalPriceAlreadyPublished();
        finalPricePublished = true;

        windowIndex = windows.length;
        windows.push(
            Window({
                kind: WindowType.FinalPriceArt17,
                opensAt: opensAt,
                closesAt: closesAt,
                scopeCutoff: type(uint64).max // covers every subscription — timing is irrelevant
            })
        );
        emit FinalPricePublished(windowIndex, opensAt, closesAt);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // WITHDRAWAL — eligible if ANY currently-open window covers this
    // subscription. Windows are independent and may overlap.
    // ═══════════════════════════════════════════════════════════════════════

    function withdrawAcceptance(uint256 subscriptionId) external {
        Subscription storage s = subscriptions[subscriptionId];
        if (s.investor != msg.sender) revert NotSubscriber();
        if (s.withdrawn) revert AlreadyWithdrawn();
        if (s.settled) revert AlreadySettled();
        if (!_isCurrentlyWithdrawable(s)) revert NotWithdrawable(subscriptionId);

        s.withdrawn = true;
        uint256 refund = s.amountWei;

        (bool ok, ) = msg.sender.call{value: refund}("");
        require(ok, "refund failed");

        emit AcceptanceWithdrawn(subscriptionId, msg.sender, refund);
    }

    function _isCurrentlyWithdrawable(Subscription storage s) internal view returns (bool) {
        for (uint256 i = 0; i < windows.length; i++) {
            Window storage w = windows[i];
            bool isOpenNow = block.timestamp >= w.opensAt && block.timestamp <= w.closesAt;
            bool inScope = w.kind == WindowType.FinalPriceArt17 || s.acceptedAt < w.scopeCutoff;
            if (isOpenNow && inScope) return true;
        }
        return false;
    }

    /// @dev Broader than `_isCurrentlyWithdrawable`: also true for a window that hasn't
    ///      opened yet but will still cover this subscription once it does (e.g. Window B
    ///      queued but not yet live). Settlement must wait for these too, not just for
    ///      windows open right now.
    function _hasPendingWindow(Subscription storage s) internal view returns (bool) {
        for (uint256 i = 0; i < windows.length; i++) {
            Window storage w = windows[i];
            bool notYetClosed = block.timestamp <= w.closesAt;
            bool inScope = w.kind == WindowType.FinalPriceArt17 || s.acceptedAt < w.scopeCutoff;
            if (notYetClosed && inScope) return true;
        }
        return false;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SETTLEMENT — releases escrow to the issuer once no window covering this
    // subscription remains open or pending. Callable by anyone once the
    // condition holds — a pull, not a push, on purpose.
    // ═══════════════════════════════════════════════════════════════════════

    function settle(uint256 subscriptionId) external {
        Subscription storage s = subscriptions[subscriptionId];
        if (s.withdrawn) revert AlreadyWithdrawn();
        if (s.settled) revert AlreadySettled();
        if (_hasPendingWindow(s)) revert WindowsStillPending();

        s.settled = true;

        (bool ok, ) = issuer.call{value: s.amountWei}("");
        require(ok, "release failed");

        emit Settled(subscriptionId, s.investor, s.amountWei);
    }
}
