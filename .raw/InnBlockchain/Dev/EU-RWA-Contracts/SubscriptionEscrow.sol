// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IDocumentAnchor, IIdentityGate, Tier} from "./Interfaces.sol";

/// @title SubscriptionEscrow (illustrative sample — not production code)
/// @notice Prospectus Regulation Art 1(4)(b)/3(2)/6/12/17/21/23 — gates a primary token offer
///         on BOTH exemption limbs (what it may raise, and how many non-qualified persons it
///         may be offered to), holds subscriptions in escrow while any statutory withdrawal
///         window is open, and enforces the prospectus's 12-month validity.
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

    /// @notice The identity registry this offer resolves a subscriber's jurisdiction against.
    /// @dev    ⚠️ `subscribe()` used to take `jurisdiction` as a caller-supplied argument.
    ///         That was wrong twice over. As compliance: a self-declared country is a country
    ///         the subscriber picks, and in EXEMPT mode the country *selects the threshold* —
    ///         so a subscriber facing a full bucket in their own Member State could simply
    ///         name an emptier one and the Art 3(2) gate would wave them through. The
    ///         registry's `jurisdiction` is written by a registrar off the back of KYC; the
    ///         argument was written by the person being gated.
    ///         As GDPR: a calldata argument is not a way to avoid persisting an attribute.
    ///         Calldata is part of the transaction and every archive node keeps it forever —
    ///         strictly worse than storage, which `deregisterInvestor` can at least `delete`.
    ///         Reading it from the registry means the only durable copy is the erasable one.
    IIdentityGate public immutable identity;

    // ─────────────────────────── EXEMPT mode: per-jurisdiction threshold ─────

    /// @notice Each Member State's elected exemption ceiling (Art 3(2)), in wei of the
    ///         offer's reference currency. Zero means "not configured" — enforced by
    ///         requiring an explicit `setJurisdictionThreshold` call before any subscription
    ///         from that jurisdiction is accepted, rather than silently defaulting to
    ///         unlimited or to the EU baseline.
    mapping(bytes32 => uint256) public jurisdictionThresholdWei;

    mapping(bytes32 => uint256) public jurisdictionRaisedWei;

    // ── Art 1(4)(b) — the OTHER exemption limb, which was missing entirely ────
    //
    // ⚠️ THE MONEY CAP IS NOT THE ONLY CAP. Art 3(2) bounds what an offer may RAISE; Art 1(4)(b)
    //    separately bounds who it may be OFFERED TO — "fewer than 150 natural or legal persons
    //    per Member State, other than qualified investors". This contract enforced only the
    //    first, so an offer could stay comfortably under its threshold in euros and lose the
    //    exemption anyway on headcount, with nothing on-chain registering that it had.
    //
    // ⚠️ COUNTED PER PERSON, NOT PER WALLET. The key is `IdentityRegistry`'s `recordPointer`.
    //    Counting addresses would spend the allowance three times on one investor holding three
    //    wallets — and lost-key recovery hands people extra wallets whether they wanted them or
    //    not, so the miscount is not even self-inflicted.

    /// @notice "Fewer than 150" is 149. Not a Member State election — unlike the Art 3(2)
    ///         threshold, this figure is fixed EU-wide, so it is a constant rather than
    ///         governance-set.
    uint256 public constant MAX_NON_QUALIFIED_PERSONS_PER_JURISDICTION = 149;

    /// @notice Distinct non-qualified PERSONS who have subscribed from each Member State.
    mapping(bytes32 => uint256) public nonQualifiedPersonsInJurisdiction;

    /// @dev Person-in-jurisdiction seen before? Keyed both ways round because the 150 is a
    ///      per-Member-State allowance: one person subscribing from two jurisdictions consumes
    ///      one unit of each, not one unit overall.
    mapping(bytes32 => mapping(bytes32 => bool)) private _personCountedInJurisdiction;

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

    /// @notice The registry the prospectus and its supplements are anchored in.
    /// @dev    ⚠️ This link existed only in the design document until now, and its absence
    ///         was the defect. §8 describes the Art 23(2) window as opening when a
    ///         supplement is published *on `DocumentRegistry`* — but the escrow opened it on
    ///         an unrelated governance call, so the two could diverge in both directions:
    ///         anchor a supplement and forget the escrow call and **no withdrawal window
    ///         opens at all**, which is a straight Art 23(2) breach the contract reports as
    ///         a clean offer; or open a window here with nothing filed, which counts a
    ///         withdrawal period against a document no investor was ever given.
    ///         Unset (address(0)) in EXEMPT mode — there is no approved prospectus.
    IDocumentAnchor public documents;

    /// @notice The `docRef` of the prospectus this offer runs on. bytes32(0) in EXEMPT mode.
    bytes32 public prospectusDocRef;

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
    /// @dev ⚠️ GDPR — `jurisdiction` was removed from this log deliberately. It used to sit
    ///      here alongside the investor address and the amount, which bound a wallet to a
    ///      country of residence *and* a sum of money, permanently, in a record no erasure
    ///      request can reach. The threshold arithmetic never needed the log — it runs off
    ///      `jurisdictionRaisedWei`, which is an aggregate per country and personal data
    ///      about nobody. An indexer that legitimately needs one subscriber's jurisdiction
    ///      reads `IIdentityGate.jurisdictionOf()`, which goes empty when that investor is
    ///      deregistered. Same rule as `IdentityRegistry`: attributes live in storage where
    ///      a `require` reads them and `delete` can remove them, never in a log.
    event Subscribed(uint256 indexed subscriptionId, address indexed investor, uint256 amountWei);
    event SupplementPublished(uint256 indexed windowIndex, uint64 opensAt, uint64 closesAt, uint64 scopeCutoff);
    /// @dev The reconciliation key. An indexer joins these against `DocumentRegistry`'s own
    ///      anchoring events and alarms on a supplement that has no window — the failure
    ///      direction no on-chain check can catch.
    event SupplementAnchorVerified(bytes32 indexed versionHash, uint64 approvedAt);
    event FinalPricePublished(uint256 indexed windowIndex, uint64 opensAt, uint64 closesAt);
    event AcceptanceWithdrawn(uint256 indexed subscriptionId, address indexed investor, uint256 refundedWei);
    event Settled(uint256 indexed subscriptionId, address indexed investor, uint256 amountWei);
    event OfferCeilingRaised(uint256 oldCeilingWei, uint256 newCeilingWei);
    event ProspectusValidityExtended(uint64 oldValidUntil, uint64 newValidUntil);

    // ─────────────────────────── errors ────────────────────────────────────────

    error NotGovernance();
    error NotSubscriber();
    error WrongMode();
    error IdentityRegistryRequired();
    /// @dev The subscriber has no jurisdiction on the identity registry — either never
    ///      registered, or deregistered since. Deliberately distinct from
    ///      `JurisdictionThresholdNotConfigured`: that one says governance has not yet
    ///      elected a ceiling for a known country, this one says we do not know the country.
    ///      Collapsing them would report an operator configuration gap for what is actually
    ///      an unverified subscriber.
    error SubscriberJurisdictionUnknown(address investor);
    /// @dev The subscriber has a jurisdiction but no person key, which the registry no longer
    ///      permits and older records may still carry. Counting them would put an uncountable
    ///      subscriber inside a headcount exemption.
    error SubscriberPersonUnknown(address investor);
    /// @dev Art 1(4)(b) headcount exhausted for that Member State. Distinct from
    ///      `ExemptThresholdBreached`, which is the Art 3(2) money limb — the offer can be
    ///      nowhere near its euro ceiling and still be out of non-qualified investors.
    error NonQualifiedPersonCapReached(bytes32 jurisdiction, uint256 cap);
    error JurisdictionThresholdNotConfigured(bytes32 jurisdiction);
    error ExemptThresholdBreached(bytes32 jurisdiction, uint256 wouldRaiseTo, uint256 thresholdWei);
    error OfferCeilingBreached(uint256 wouldRaiseTo, uint256 ceilingWei);
    error ProspectusExpired(uint64 validUntil);
    /// @dev The supplement was not found in `DocumentRegistry`, or was found without a
    ///      recorded NCA approval. Art 23(1) gives the NCA up to 5 working days and the
    ///      supplement must be approved AND published before the window it opens means
    ///      anything — so an unapproved hash opening a withdrawal window is a window
    ///      counted against a document no investor can have been given.
    error SupplementNotAnchoredAndApproved(bytes32 versionHash);
    /// @dev The prospectus this offer runs on is no longer anchored in `DocumentRegistry`.
    error ProspectusAnchorMissing(bytes32 docRef);
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
    /// @param documents_          `DocumentRegistry` holding the prospectus and its
    ///                            supplements. PROSPECTUS mode only; pass address(0) in
    ///                            EXEMPT mode, which by definition has no approved
    ///                            prospectus to anchor.
    /// @param prospectusDocRef_   The registry `docRef` of the prospectus this offer runs on.
    /// @param identity_           `IdentityRegistry` supplying each subscriber's *verified*
    ///                            jurisdiction. Required in BOTH modes — EXEMPT mode reads it
    ///                            to pick the Art 3(2) threshold, and PROSPECTUS mode still
    ///                            needs a registered subscriber even though its ceiling is
    ///                            offer-wide rather than per-country.
    constructor(
        address issuer_,
        address governance_,
        Mode mode_,
        uint256 maxOfferAmountWei_,
        uint64 prospectusValidUntil_,
        bool finalPriceOmittedAtFiling_,
        address documents_,
        bytes32 prospectusDocRef_,
        address identity_
    ) {
        if (identity_ == address(0)) revert IdentityRegistryRequired();

        issuer = issuer_;
        governance = governance_;
        mode = mode_;
        identity = IIdentityGate(identity_);

        if (mode_ == Mode.Prospectus) {
            maxOfferAmountWei = maxOfferAmountWei_;
            prospectusValidUntil = prospectusValidUntil_;
            finalPriceOmittedAtFiling = finalPriceOmittedAtFiling_;
            documents = IDocumentAnchor(documents_);
            prospectusDocRef = prospectusDocRef_;
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

    /// @notice Takes no jurisdiction argument by design — see the `identity` @dev note. The
    ///         subscriber's country is read from the registry, where a registrar wrote it
    ///         after KYC, and never from the caller, who is the party being gated.
    function subscribe() external payable returns (uint256 subscriptionId) {
        bytes32 jurisdiction = identity.jurisdictionOf(msg.sender);
        if (jurisdiction == bytes32(0)) revert SubscriberJurisdictionUnknown(msg.sender);

        if (mode == Mode.Exempt) {
            uint256 threshold = jurisdictionThresholdWei[jurisdiction];
            if (threshold == 0) revert JurisdictionThresholdNotConfigured(jurisdiction);

            uint256 wouldRaiseTo = jurisdictionRaisedWei[jurisdiction] + msg.value;
            if (wouldRaiseTo > threshold) {
                revert ExemptThresholdBreached(jurisdiction, wouldRaiseTo, threshold);
            }

            // Art 1(4)(b) headcount, checked BEFORE the raise is committed so a subscription
            // that breaches the person cap leaves no trace in the money counter.
            _countNonQualifiedPerson(jurisdiction);

            jurisdictionRaisedWei[jurisdiction] = wouldRaiseTo;
        } else {
            if (block.timestamp > prospectusValidUntil) revert ProspectusExpired(prospectusValidUntil);
            // Art 12 has two limbs and the date is only one of them: a prospectus is valid
            // for 12 months from approval **and only while it remains the anchored, current
            // document**. Checking the clock alone accepts subscriptions against a
            // prospectus that has been withdrawn or superseded in the registry.
            if (documents.currentVersionHash(prospectusDocRef) == bytes32(0)) {
                revert ProspectusAnchorMissing(prospectusDocRef);
            }

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

        emit Subscribed(subscriptionId, msg.sender, msg.value);
    }

    /// @notice Art 1(4)(b) — spends one unit of a Member State's 149-person allowance, and
    ///         reverts once it is gone.
    /// @dev    ⚠️ QUALIFIED INVESTORS DO NOT COUNT AT ALL. Art 2(e) reads across to MiFID II
    ///         Annex II, so per-se professionals, elective professionals and eligible
    ///         counterparties sit outside the headcount entirely. `Tier.Unset` IS counted —
    ///         an unclassified subscriber is not in Annex II, and resolving that unknown in
    ///         the offer's favour is how a headcount exemption quietly stops being one.
    /// @dev    ⚠️ ONE UNIT PER PERSON PER JURISDICTION, spent on their first subscription. A
    ///         repeat subscription by someone already counted consumes nothing further: the
    ///         article counts persons the offer was made to, not tickets sold.
    /// @dev    ⚠️ NEVER DECREMENTED, INCLUDING ON WITHDRAWAL. An investor who exercises an Art
    ///         17(2) or Art 23(2) withdrawal right was still a person this offer was addressed
    ///         to, and Art 1(4)(b) counts the addressing, not the outcome. Refunding the money
    ///         does not unmake the offer.
    function _countNonQualifiedPerson(bytes32 jurisdiction) private {
        (bytes32 person, bool registered) = identity.recordPointerOf(msg.sender);
        if (!registered || person == bytes32(0)) revert SubscriberPersonUnknown(msg.sender);

        if (_isQualifiedInvestor(identity.tierOf(msg.sender))) return;
        if (_personCountedInJurisdiction[jurisdiction][person]) return;

        uint256 wouldCountTo = nonQualifiedPersonsInJurisdiction[jurisdiction] + 1;
        if (wouldCountTo > MAX_NON_QUALIFIED_PERSONS_PER_JURISDICTION) {
            revert NonQualifiedPersonCapReached(jurisdiction, MAX_NON_QUALIFIED_PERSONS_PER_JURISDICTION);
        }

        _personCountedInJurisdiction[jurisdiction][person] = true;
        nonQualifiedPersonsInJurisdiction[jurisdiction] = wouldCountTo;
    }

    /// @dev Prospectus Art 2(e) qualified investors are the MiFID II Annex II classes. Anything
    ///      outside Annex II — retail, and anything unclassified — counts toward the 150.
    function _isQualifiedInvestor(Tier tier) private pure returns (bool) {
        return
            tier == Tier.ProfessionalOnRequest ||
            tier == Tier.PerSeProfessional ||
            tier == Tier.EligibleCounterparty;
    }

    /// @notice Remaining Art 1(4)(b) headroom for a Member State.
    function nonQualifiedPersonHeadroom(bytes32 jurisdiction) external view returns (uint256) {
        uint256 used = nonQualifiedPersonsInJurisdiction[jurisdiction];
        if (used >= MAX_NON_QUALIFIED_PERSONS_PER_JURISDICTION) return 0;
        return MAX_NON_QUALIFIED_PERSONS_PER_JURISDICTION - used;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // WINDOW A — Art 23(2) supplement. Opens a >=3-working-day window covering
    // only subscriptions accepted BEFORE the supplement is published.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param supplementVersionHash  The supplement's version hash as anchored in
    ///                               `DocumentRegistry`. Checked, not trusted.
    /// @param opensAt/closesAt  Fed in off-chain against a real working-day calendar
    ///                          (TARGET2) — never computed on-chain from block.timestamp.
    /// @dev    ⚠️ The window can no longer be opened against a supplement that was never
    ///         filed or never approved. This is the same gate `DoraGovernor.queueUpgrade`
    ///         applies to a disclosure artefact, and for the same reason: Art 23(1) gives
    ///         the NCA up to 5 working days, and approval and publication precede the thing
    ///         they authorise. It does NOT close the other direction — nothing on-chain can
    ///         force this call when a supplement is anchored — so anchoring a supplement
    ///         must remain a two-transaction operational step with a named owner. Emitting
    ///         the hash here is what lets an indexer reconcile the two sets and alarm on a
    ///         supplement with no window.
    function publishSupplement(
        bytes32 supplementVersionHash,
        uint64 opensAt,
        uint64 closesAt
    ) external onlyGovernance returns (uint256 windowIndex) {
        if (mode != Mode.Prospectus) revert WrongMode();

        (bool exists, uint64 approvedAt) = documents.documentStatus(supplementVersionHash);
        if (!exists || approvedAt == 0) revert SupplementNotAnchoredAndApproved(supplementVersionHash);

        emit SupplementAnchorVerified(supplementVersionHash, approvedAt);

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
