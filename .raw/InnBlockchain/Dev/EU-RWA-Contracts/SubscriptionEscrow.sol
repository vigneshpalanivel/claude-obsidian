// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IDocumentAnchor, IErasable, IIdentityGate, IRestrictedParty, Regime, Tier, Version} from "./Interfaces.sol";

/// @title SubscriptionEscrow (illustrative sample — not production code)
/// @notice Prospectus Regulation Art 1(4)(b)/3(2)/6/12/17/21/23 — gates a primary token offer
///         on BOTH exemption limbs (what it may raise, and how many non-qualified persons it
///         may be offered to), holds subscriptions in escrow until the offer has CLOSED and
///         every statutory withdrawal window has run, and enforces the prospectus's 12-month
///         validity from its NCA approval.
/// @dev    Two independent regimes, chosen once at deploy and not switchable:
///         - EXEMPT: offer stays under the per-jurisdiction threshold (Art 3(2)) and never
///           had an NCA-approved prospectus. `subscribe()` hard-reverts once the cumulative
///           total for that jurisdiction would cross its elected threshold (EU default
///           €12m/12mo; a Member State may instead elect €5m — binary election, not a
///           sliding floor).
///         - PROSPECTUS: an NCA-approved prospectus is in force, declaring a maximum offer
///           ceiling (Art 6) and, if the final price/amount wasn't fixed at filing, a
///           second withdrawal window under Art 17(2). `subscribe()` hard-reverts past the
///           declared ceiling, past the prospectus's 12-month validity (Art 12), or against
///           a prospectus version with no recorded NCA approval.
///         Crossing the exempt threshold does NOT auto-upgrade this contract to PROSPECTUS
///         mode — approval must precede the offer, not follow it, so that step is a
///         deliberate off-chain event (a fresh, NCA-approved prospectus) followed by a
///         fresh deployment or reconfiguration, never an automatic on-chain transition.
/// @dev    ⚠️ SETTLEMENT WAITS FOR THE OFFER TO CLOSE, NOT MERELY FOR OPEN WINDOWS. Both
///         withdrawal rights arise from events that happen AFTER acceptance — a supplement is
///         published (Art 23(2)), a final price is filed (Art 17(2)) — so "no window covers
///         this subscription yet" is not "no window ever will". The earlier rule (design §8
///         rev ≤49: "with no window open and none pending, release is immediate and the
///         mechanism is a no-op") let anyone settle a subscription one block after it was
///         accepted, after which `withdrawAcceptance` reverted `AlreadySettled` — the Art 17(2)
///         right was destroyed for the whole offer whenever the final price was omitted at
///         filing, and the Art 23(2) right for everything settled before a supplement landed.
///         Now `settle()` requires `offerClosesAt` to be set and passed, the final price to be
///         published where it was omitted, and no window still pending. The design's §8 rule
///         is superseded by this contract and is being swept to match.
/// @dev    ⚠️ THIS CONTRACT MUST NOT BE DEPLOYED BEHIND A PROXY (D20). `mode` and
///         `finalPriceOmittedAtFiling` are `immutable` because they are DISCLOSURE ITEMS — the
///         prospectus states which regime the offer runs under and whether the final price
///         was fixed at filing, and neither may drift from the document after the fact. An
///         `immutable` reads the IMPLEMENTATION's constructor value through a proxy, not the
///         proxy's — so a proxied deployment would run whatever regime the implementation was
///         compiled with (enum zero = Exempt → no Art 12 gate, no Art 6 ceiling;
///         `finalPriceOmittedAtFiling == false` → window B can never open). One escrow per
///         offer, deployed directly; a new offer is a new deployment. Listed under "not
///         proxied" in `UPGRADE-ARCHITECTURE.md`.
/// @dev    "Rolling 12-month" is a calendar concept this sample does not fully model —
///         `jurisdictionRaisedWei` is a simple non-decaying cumulative total, not a true
///         rolling window. A production version needs subscriptions to age out after 12
///         months, fed by an off-chain calendar the same way the withdrawal windows are.
/// @dev    ⚠️ THIS CONTRACT MINTS NOTHING. It holds native-currency cash against a subscription
///         record; the unit mint happens at settlement through the token's own gated path, off
///         this contract. The mandatory-layer reads on `subscribe()` (`checkEligible`,
///         `assertNotBlocked`) exist BECAUSE no mint hook runs here — before 2026-09-08 the
///         escrow accepted and refunded cash from a wallet the token would have refused.
contract SubscriptionEscrow is IErasable {
    /// @dev Emitted whenever an inter-contract reference is re-pointed.
    event DependencySet(bytes32 indexed role, address indexed impl);

    // ─────────────────────────── mode ────────────────────────────────────────

    enum Mode {
        Exempt, // Art 3(2) — under the national threshold, no NCA-approved prospectus
        Prospectus // Art 6 — full NCA-approved prospectus in force
    }

    /// @dev Disclosure item — `immutable` on purpose. See the D20 note in the header.
    Mode public immutable mode;

    // ─────────────────────────── roles ──────────────────────────────────────

    address public immutable issuer;
    address public immutable governance; // multisig/timelock — publishes supplements, final price

    /// @notice The `PersonErasure` coordinator, permitted to call `erasePerson` and nothing else.
    /// @dev    Zero disables the path. See `erasePerson` for why this one is gated on the offer
    ///         having closed rather than being available on request.
    address public erasureCoordinator;

    /// @notice The identity registry this offer resolves a subscriber's jurisdiction, tier and
    ///         eligibility against.
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
    /// @dev    Settable (`setIdentity`), never null — the rev-38 reference rule. Was `immutable`.
    IIdentityGate public identity;

    /// @notice The person-scoped restriction store. Read on `subscribe()` only — see
    ///         `withdrawAcceptance` for why the refund path deliberately does not read it.
    IRestrictedParty public restrictions;

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
    // ⚠️ COUNTED PER PERSON, NOT PER WALLET. The key is `IdentityRegistry`'s `personId`.
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

    /// @notice Art 12 — prospectus valid 12 months from APPROVAL. Past this, `subscribe()`
    ///         reverts regardless of remaining ceiling headroom: an open subscription
    ///         contract past expiry is selling without a valid prospectus — strict
    ///         liability, no ledger signal warns you on its own.
    /// @dev    ⚠️ THE DATE IS FED IN, AND THE CHAIN BOUNDS IT. The value is set at construction
    ///         and moved by `extendProspectusValidity`, but on every read that matters it is
    ///         checked against `approvedAt + 365 days` of the base prospectus (the slot's
    ///         first version — a supplement's later approval does not restart Art 12). The
    ///         check is lazy — in `subscribe()` — because at construction the approval is
    ///         usually not yet recorded in the registry; `extendProspectusValidity` runs it
    ///         eagerly where the approval is already known.
    uint64 public prospectusValidUntil;

    /// @notice Art 12 in seconds. Calendar months are off-chain; 365 days is the on-chain bound.
    uint64 public constant PROSPECTUS_VALIDITY_PERIOD = 365 days;

    /// @notice The registry the prospectus and its supplements are anchored in.
    /// @dev    ⚠️ This link existed only in the design document until now, and its absence
    ///         was the defect. §8 describes the Art 23(2) window as opening when a
    ///         supplement is published *on `DocumentRegistry`* — but the escrow opened it on
    ///         an unrelated governance call, so the two could diverge in both directions:
    ///         anchor a supplement and forget the escrow call and **no withdrawal window
    ///         opens at all**, which is a straight Art 23(2) breach the contract reports as
    ///         a clean offer; or open a window here with nothing filed, which counts a
    ///         withdrawal period against a document no investor was ever given.
    ///         Unset (address(0)) in EXEMPT mode — there is no approved prospectus. Required
    ///         and settable (`setDocuments`) in PROSPECTUS mode.
    IDocumentAnchor public documents;

    /// @notice The `docRef` of the prospectus this offer runs on. bytes32(0) in EXEMPT mode.
    bytes32 public prospectusDocRef;

    // ─────────────────────────── offer close ──────────────────────────────────

    /// @notice When the offer closes to new subscriptions, and the earliest moment any
    ///         subscription may settle. 0 = not yet set, and nothing settles until it is.
    /// @dev    ⚠️ MAY BE EXTENDED, NEVER BROUGHT FORWARD. Art 23's supplement duty runs until
    ///         "the closing of the offer or the start of trading, whichever is later"; an
    ///         issuer who could retro-close an offer could end the Art 23(2) exposure of every
    ///         accepted subscription at will. Extending is the ordinary case (an offer kept
    ///         open); pulling the date in is the abuse, and `setOfferClose` refuses it.
    uint64 public offerClosesAt;

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
    ///         17(2)), and NOTHING SETTLES until it has been; if the final price was fixed at
    ///         filing, Window B can never open.
    /// @dev    Disclosure item — `immutable` on purpose. See the D20 note in the header.
    bool public immutable finalPriceOmittedAtFiling;
    bool public finalPricePublished;

    // ─────────────────────────── window duration floors (governance-set) ────

    /// @notice Art 23(2) statutory minimum is 3 working days. A FLOOR enforced on
    ///         `publishSupplement`: `closesAt - opensAt` must be at least this. Configurable
    ///         rather than a constant because it is a statutory *minimum* an operator could
    ///         extend, and because working-day arithmetic (TARGET2 calendar) is computed
    ///         off-chain — `opensAt`/`closesAt` are always fed in, never derived from
    ///         block.timestamp on-chain. This value is CALENDAR seconds: it bounds the fed-in
    ///         window from below and cannot itself express working days. Three working days
    ///         is never fewer than three calendar days, so the default is a safe floor, not
    ///         the computation.
    /// @dev    ⚠️ Until 2026-09-08 this field was read by nothing and had no setter —
    ///         governance could push `closesAt == opensAt` and the window closed as it opened.
    uint64 public supplementWindowDurationSeconds = 3 days;

    /// @notice Art 17(2) base text sets >= 2 working days. Defaulted here to the safer 3
    ///         working days pending an open question on whether the Listing Act's 2->3 day
    ///         extension of Art 23(2) also reached Art 17 — see design doc §16 D10. Same
    ///         floor semantics as `supplementWindowDurationSeconds`; enforced on
    ///         `publishFinalPrice`.
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
    event ErasureCoordinatorSet(address indexed previous, address indexed current);
    /// @dev The jurisdiction is in the log because the Art 1(4)(b) allowance it releases is a
    ///      per-Member-State figure an auditor has to be able to reconcile, and a country with
    ///      no person attached to it is not personal data. The `personId` is not.
    event NonQualifiedPersonReleased(bytes32 indexed jurisdiction, uint256 remainingCount);
    /// @notice One window record pushed. Fires for BOTH kinds.
    /// @dev    ⚠️ Renamed from `SupplementPublished` on 2026-09-08. `DocumentRegistry` emits its
    ///         own `SupplementPublished(docRef, versionHash, publishedAt)` when a second
    ///         Prospectus-slot version is anchored, and a name-keyed subgraph handler joined the
    ///         two under one name. Different topic0, so ABI decoding was never at risk — but the
    ///         reconciliation join below is exactly the query most likely written by name.
    event WithdrawalWindowOpened(
        uint256 indexed windowIndex, WindowType kind, uint64 opensAt, uint64 closesAt, uint64 scopeCutoff
    );
    /// @dev The reconciliation key. An indexer joins THIS contract's `SupplementAnchorVerified`
    ///      (and the `WithdrawalWindowOpened` it precedes) against
    ///      `DocumentRegistry.SupplementPublished(docRef, versionHash, publishedAt)` on
    ///      `versionHash`, and alarms on a registry `SupplementPublished` with no matching
    ///      escrow window — the failure direction no on-chain check can catch.
    event SupplementAnchorVerified(bytes32 indexed docRef, bytes32 indexed versionHash, uint64 approvedAt);
    event FinalPricePublished(uint256 indexed windowIndex, uint64 opensAt, uint64 closesAt);
    event AcceptanceWithdrawn(uint256 indexed subscriptionId, address indexed investor, uint256 refundedWei);
    event Settled(uint256 indexed subscriptionId, address indexed investor, uint256 amountWei);
    event OfferCeilingRaised(uint256 oldCeilingWei, uint256 newCeilingWei);
    event ProspectusValidityExtended(uint64 oldValidUntil, uint64 newValidUntil);
    event OfferCloseSet(uint64 previousClosesAt, uint64 closesAt);
    event SupplementWindowFloorSet(uint64 previousSeconds, uint64 seconds_);
    event FinalPriceWindowFloorSet(uint64 previousSeconds, uint64 seconds_);

    // ─────────────────────────── errors ────────────────────────────────────────

    error NotGovernance();
    error NotSubscriber();
    error WrongMode();
    error ZeroAddress();
    error IdentityRegistryRequired();
    error RestrictionStoreRequired();
    error DocumentRegistryRequired();
    error ZeroSubscription();
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
    /// @dev The current prospectus version is anchored but carries no recorded NCA approval.
    ///      Art 12 runs FROM approval, and an offer against an unapproved prospectus is an
    ///      offer without one. Before 2026-09-08 `subscribe()` checked only that a current
    ///      hash existed — `anchorVersion` writes `approvedAt: 0`, so subscriptions were
    ///      accepted against a draft.
    error ProspectusNotApproved(bytes32 docRef);
    /// @dev `prospectusValidUntil` sits past `approvedAt + 365 days` — the fed-in date has
    ///      outrun the statutory limit. Fix the date, or record the fresh approval first.
    error ProspectusValidityExceedsApproval(uint64 validUntil, uint64 approvedAt);
    /// @dev The supplement was not found in `DocumentRegistry`, or was found without a
    ///      recorded NCA approval. Art 23(1) gives the NCA up to 5 working days and the
    ///      supplement must be approved AND published before the window it opens means
    ///      anything — so an unapproved hash opening a withdrawal window is a window
    ///      counted against a document no investor can have been given.
    error SupplementNotAnchoredAndApproved(bytes32 versionHash);
    /// @dev The hash is not a Prospectus-Regulation supplement: wrong regime on the slot
    ///      (a KID hash opening an Art 23 window was the defect), not in that slot at all, or
    ///      the base prospectus itself rather than a supplement to it.
    error NotAProspectusSupplement(bytes32 docRef, bytes32 versionHash);
    /// @dev The prospectus this offer runs on is no longer anchored in `DocumentRegistry`.
    error ProspectusAnchorMissing(bytes32 docRef);
    error FinalPriceAlreadyPublished();
    error FinalPriceNeverOmitted();
    /// @dev `settle()` while the final price the prospectus omitted has not been published.
    ///      Window B has not opened because the event that opens it has not happened; that is
    ///      the opposite of "no window applies".
    error FinalPriceNotPublished();
    error NotWithdrawable(uint256 subscriptionId);
    error AlreadyWithdrawn();
    error AlreadySettled();
    error WindowsStillPending();
    /// @dev `settle()` before `offerClosesAt` is set and passed — see the header. Also raised by
    ///      `erasePerson`, on the identical condition and deliberately sharing the error rather
    ///      than adding a near-twin: both mean "this offer is not finished", and two errors for
    ///      one fact is how a caller ends up handling only the one it happened to hit first.
    error OfferStillOpen();
    /// @dev `subscribe()` after `offerClosesAt`. A subscription accepted after the close would
    ///      be settleable in the same block, which is the H4 hole by another door.
    error OfferClosed(uint64 closedAt);
    error NotErasureCoordinator();
    error OfferCloseInPast(uint64 proposed);
    error OfferCloseCannotMoveEarlier(uint64 current, uint64 proposed);
    /// @dev A window fed in shorter than its statutory floor, or opening in the past. The
    ///      floor is the contract's only defence against a window that closes as it opens.
    error WindowBelowFloor(uint64 opensAt, uint64 closesAt, uint64 floorSeconds);
    error ZeroDuration();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    /// @param mode_                       Chosen once, at deploy — see contract-level @dev.
    /// @param maxOfferAmountWei_          PROSPECTUS mode only; ignored (must pass 0) in EXEMPT mode.
    /// @param prospectusValidUntil_       PROSPECTUS mode only; ignored (must pass 0) in EXEMPT mode.
    ///                                    Bounded lazily against the base prospectus approval —
    ///                                    see `prospectusValidUntil`.
    /// @param finalPriceOmittedAtFiling_  PROSPECTUS mode only; ignored (must pass false) in EXEMPT mode.
    /// @param documents_          `DocumentRegistry` holding the prospectus and its
    ///                            supplements. PROSPECTUS mode: required, non-zero. EXEMPT
    ///                            mode: pass address(0) — by definition there is no approved
    ///                            prospectus to anchor.
    /// @param prospectusDocRef_   The registry `docRef` of the prospectus this offer runs on.
    /// @param identity_           `IdentityRegistry` supplying each subscriber's *verified*
    ///                            jurisdiction, tier and eligibility. Required in BOTH modes.
    /// @param restrictions_       `RestrictedPartyRegistry` — the mandatory layer. Required
    ///                            in BOTH modes: no wiring exists in which cash is accepted
    ///                            from a wallet without a restriction store in front of it.
    constructor(
        address issuer_,
        address governance_,
        Mode mode_,
        uint256 maxOfferAmountWei_,
        uint64 prospectusValidUntil_,
        bool finalPriceOmittedAtFiling_,
        address documents_,
        bytes32 prospectusDocRef_,
        address identity_,
        address restrictions_
    ) {
        if (issuer_ == address(0) || governance_ == address(0)) revert ZeroAddress();
        if (identity_ == address(0)) revert IdentityRegistryRequired();
        if (restrictions_ == address(0)) revert RestrictionStoreRequired();

        issuer = issuer_;
        governance = governance_;
        mode = mode_;
        identity = IIdentityGate(identity_);
        restrictions = IRestrictedParty(restrictions_);
        emit DependencySet("identity", identity_);
        emit DependencySet("restrictions", restrictions_);

        if (mode_ == Mode.Prospectus) {
            if (documents_ == address(0)) revert DocumentRegistryRequired();
            maxOfferAmountWei = maxOfferAmountWei_;
            prospectusValidUntil = prospectusValidUntil_;
            finalPriceOmittedAtFiling = finalPriceOmittedAtFiling_;
            documents = IDocumentAnchor(documents_);
            prospectusDocRef = prospectusDocRef_;
            emit DependencySet("documents", documents_);
        } else {
            finalPriceOmittedAtFiling = false;
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // WIRING — swap, never unset
    // ═══════════════════════════════════════════════════════════════════════

    function setIdentity(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        identity = IIdentityGate(impl);
        emit DependencySet("identity", impl);
    }

    function setRestrictions(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        restrictions = IRestrictedParty(impl);
        emit DependencySet("restrictions", impl);
    }

    /// @dev Only meaningful where a prospectus exists to anchor. In EXEMPT mode the reference
    ///      is deliberately null and stays null.
    function setDocuments(address impl) external onlyGovernance {
        if (mode != Mode.Prospectus) revert WrongMode();
        if (impl == address(0)) revert ZeroAddress();
        documents = IDocumentAnchor(impl);
        emit DependencySet("documents", impl);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // OFFER CALENDAR — close date and window floors
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Sets, or extends, the offer close. Must be in the future; once set it may only
    ///         move LATER. Both modes — an exempt offer has no Art 23 window to protect, but it
    ///         still has a close, and settlement waits for it either way.
    function setOfferClose(uint64 closesAt) external onlyGovernance {
        if (closesAt <= block.timestamp) revert OfferCloseInPast(closesAt);
        if (offerClosesAt != 0 && closesAt < offerClosesAt) revert OfferCloseCannotMoveEarlier(offerClosesAt, closesAt);
        emit OfferCloseSet(offerClosesAt, closesAt);
        offerClosesAt = closesAt;
    }

    /// @notice Raises or lowers the Art 23(2) floor — in calendar seconds, applied to windows
    ///         fed in against a working-day calendar. Lowering below the statutory minimum is
    ///         a governance decision this contract cannot second-guess; zero is refused
    ///         because it turns the check off.
    function setSupplementWindowFloor(uint64 seconds_) external onlyGovernance {
        if (seconds_ == 0) revert ZeroDuration();
        emit SupplementWindowFloorSet(supplementWindowDurationSeconds, seconds_);
        supplementWindowDurationSeconds = seconds_;
    }

    function setFinalPriceWindowFloor(uint64 seconds_) external onlyGovernance {
        if (seconds_ == 0) revert ZeroDuration();
        emit FinalPriceWindowFloorSet(finalPriceWindowDurationSeconds, seconds_);
        finalPriceWindowDurationSeconds = seconds_;
    }

    /// @dev Shared by both window openers. `opensAt` in the past would back-date a window that
    ///      an investor could not have exercised during the elapsed part.
    function _assertWindowMeetsFloor(uint64 opensAt, uint64 closesAt, uint64 floorSeconds) private view {
        if (opensAt < block.timestamp || closesAt < opensAt || closesAt - opensAt < floorSeconds) {
            revert WindowBelowFloor(opensAt, closesAt, floorSeconds);
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
    /// @dev    Bounded eagerly against the base prospectus approval where the registry already
    ///         holds one; where it does not yet, `subscribe()` bounds it lazily on every
    ///         acceptance, so a date that outruns approval + 12 months never admits a
    ///         subscription either way.
    function extendProspectusValidity(uint64 newValidUntil) external onlyGovernance {
        if (mode != Mode.Prospectus) revert WrongMode();

        uint64 approvedAt = _baseProspectusApprovedAt();
        if (approvedAt != 0) _assertValidityWithinApproval(newValidUntil, approvedAt);

        emit ProspectusValidityExtended(prospectusValidUntil, newValidUntil);
        prospectusValidUntil = newValidUntil;
    }

    /// @dev Art 12 runs from the approval of the PROSPECTUS — the slot's first version. A
    ///      supplement anchored later carries its own `approvedAt`, and measuring 12 months
    ///      from that would let each supplement quietly extend the offer. 0 when the slot is
    ///      empty or the base version has no recorded approval.
    function _baseProspectusApprovedAt() private view returns (uint64) {
        if (documents.versionCount(prospectusDocRef) == 0) return 0;
        Version memory base = documents.versionAt(prospectusDocRef, 0);
        return base.approvedAt;
    }

    function _assertValidityWithinApproval(uint64 validUntil, uint64 approvedAt) private pure {
        if (validUntil > approvedAt + PROSPECTUS_VALIDITY_PERIOD) {
            revert ProspectusValidityExceedsApproval(validUntil, approvedAt);
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SUBSCRIPTION — accepted funds sit in this contract (escrow) until the
    // offer has closed and every applicable withdrawal window has run;
    // mode-gated at the door.
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Takes no jurisdiction argument by design — see the `identity` @dev note. The
    ///         subscriber's country is read from the registry, where a registrar wrote it
    ///         after KYC, and never from the caller, who is the party being gated.
    /// @dev    ⚠️ THE MANDATORY LAYER IS READ HERE BECAUSE NO MINT HOOK RUNS HERE.
    ///         `identity.checkEligible` (registered, unexpired, required claims present) and
    ///         `restrictions.assertNotBlocked` (sanctions, suspicion, probate, court order —
    ///         one flag, one argument-free error) both run before a wei is accepted. The
    ///         token's `_move` performs the same two reads; a subscription path that did not
    ///         was accepting and refunding cash from wallets the token would refuse, and cash
    ///         out to a listed person is a release of value whatever the ledger calls it.
    function subscribe() external payable returns (uint256 subscriptionId) {
        if (msg.value == 0) revert ZeroSubscription();
        if (offerClosesAt != 0 && block.timestamp > offerClosesAt) revert OfferClosed(offerClosesAt);

        identity.checkEligible(msg.sender);
        restrictions.assertNotBlocked(msg.sender);

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
            _assertProspectusInForce();

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

    /// @dev Art 12 has three limbs and the date is only one of them. A prospectus is valid
    ///      (1) only while it remains the anchored, current document — checking the clock
    ///      alone accepts subscriptions against a prospectus withdrawn or superseded in the
    ///      registry; (2) only once the NCA has approved the version that is current —
    ///      `anchorVersion` writes `approvedAt: 0`, and a current-but-unapproved version is a
    ///      draft; (3) for 12 months FROM that approval, which bounds the fed-in date from
    ///      above. The bound is checked here rather than only at construction because the
    ///      approval is usually recorded after the escrow is deployed.
    function _assertProspectusInForce() private view {
        if (block.timestamp > prospectusValidUntil) revert ProspectusExpired(prospectusValidUntil);

        bytes32 current = documents.currentVersionHash(prospectusDocRef);
        if (current == bytes32(0)) revert ProspectusAnchorMissing(prospectusDocRef);

        (, uint64 currentApprovedAt) = documents.documentStatus(current);
        if (currentApprovedAt == 0) revert ProspectusNotApproved(prospectusDocRef);

        uint64 baseApprovedAt = _baseProspectusApprovedAt();
        if (baseApprovedAt == 0) revert ProspectusNotApproved(prospectusDocRef);
        _assertValidityWithinApproval(prospectusValidUntil, baseApprovedAt);
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
    /// @notice Point at the `PersonErasure` coordinator, or unset it with `address(0)`.
    function setErasureCoordinator(address coordinator) external onlyGovernance {
        address previous = erasureCoordinator;
        erasureCoordinator = coordinator;
        emit ErasureCoordinatorSet(previous, coordinator);
    }

    /// @notice GDPR Art 17 leg. Releases the person's slot in the Art 1(4)(b) headcount.
    /// @dev    ⚠️ THIS CONTRACT HAD NO ERASURE PATH AT ALL UNTIL 2026-09-09.
    ///         `_personCountedInJurisdiction[jurisdiction][personId]` is a permanent record that
    ///         a named person subscribed to a named offer from a named country, and nothing
    ///         anywhere deleted it. It was defensible while the offer was open and indefensible
    ///         one second after it closed, which is the distinction this function draws.
    /// @dev    ⚠️ REFUSES WHILE THE OFFER IS OPEN, AND THAT REFUSAL IS ART 17(3)(b), NOT
    ///         RELUCTANCE. The count IS the Prospectus Art 1(4)(b) control: it is what
    ///         `_countNonQualifiedPerson` reads to decide whether the 149th non-qualified
    ///         subscriber in a Member State may be admitted. Erasing an entry mid-offer would
    ///         free a slot that has genuinely been consumed and let the offer exceed the
    ///         exemption it is relying on — an investor could request erasure and thereby
    ///         enlarge the allowance. Once the offer has closed the figure is settled and the
    ///         legal obligation that justified holding it has ended.
    /// @dev    ⚠️ AND THE EVIDENTIAL TAIL IS THE OPERATOR'S CALL, NOT THIS CONTRACT'S. An issuer
    ///         may need to show a supervisor it stayed under 150 for some period after the
    ///         close, and the Prospectus Regulation fixes no retention period for that — so
    ///         rather than invent one in a constant, the timing is governed by when the operator
    ///         points the coordinator at this contract. `PersonErasure.setTargetSkipped` is the
    ///         recorded way to hold it out in the meantime; a skip is a decision with a reason
    ///         hash, which is what an Art 30 record needs and a silent omission is not.
    /// @dev    Reads the jurisdiction from the first wallet rather than taking it as an
    ///         argument: since `IdentityRegistry` became person-keyed, every wallet of a person
    ///         returns the same country, and reading it removes the last place a caller could
    ///         name a jurisdiction of their own choosing.
    function erasePerson(bytes32 personId, address[] calldata wallets) external {
        if (msg.sender != erasureCoordinator || erasureCoordinator == address(0)) revert NotErasureCoordinator();
        if (offerClosesAt == 0 || block.timestamp <= offerClosesAt) revert OfferStillOpen();
        if (wallets.length == 0) return;

        bytes32 jurisdiction = identity.jurisdictionOf(wallets[0]);
        if (jurisdiction == bytes32(0)) return;
        if (!_personCountedInJurisdiction[jurisdiction][personId]) return;

        delete _personCountedInJurisdiction[jurisdiction][personId];

        uint256 remaining = nonQualifiedPersonsInJurisdiction[jurisdiction];
        // Cannot underflow while the flag above is the only thing that increments it, and
        // guarded anyway: a decrement that wrapped would hand the offer a 2^256 allowance.
        if (remaining != 0) {
            remaining -= 1;
            nonQualifiedPersonsInJurisdiction[jurisdiction] = remaining;
        }

        emit NonQualifiedPersonReleased(jurisdiction, remaining);
    }

    function _countNonQualifiedPerson(bytes32 jurisdiction) private {
        (bytes32 person, bool registered) = identity.personIdOf(msg.sender);
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

    /// @param docRef                 The registry slot the supplement was anchored into.
    ///                               Usually `prospectusDocRef` (a supplement is a later
    ///                               version of the prospectus slot); a separately-opened
    ///                               Prospectus-Regulation slot is also accepted.
    /// @param supplementVersionHash  The supplement's version hash as anchored in
    ///                               `DocumentRegistry`. Checked, not trusted.
    /// @param opensAt/closesAt  Fed in off-chain against a real working-day calendar
    ///                          (TARGET2) — never computed on-chain from block.timestamp.
    ///                          Bounded from below by `supplementWindowDurationSeconds`.
    /// @dev    ⚠️ The window can no longer be opened against a supplement that was never
    ///         filed or never approved. The reason is Art 23(1): the NCA has up to 5 working
    ///         days, and approval and publication precede the thing they authorise.
    ///         ⚠️ Nor against a hash from the wrong REGIME. `documentStatus` is keyed by hash
    ///         across every slot in the registry, so until 2026-09-08 any approved hash —
    ///         a KID, an ELTIF annual report — opened an Art 23 window. The supplement must
    ///         sit in a `Regime.ProspectusRegulation` slot, and where that slot is this
    ///         offer's own prospectus it must not be the base prospectus (index 0) itself.
    ///         ⚠️ This is now the ONLY reverting document check left in the suite — the
    ///         equivalent gate on the upgrade path was withdrawn in favour of carrying the
    ///         document hash as the `TimelockController` salt and reconciling off-chain (see
    ///         `UPGRADE-ARCHITECTURE.md`). The asymmetry is deliberate: opening a window is a
    ///         mechanical consequence of a publication event with one answer a contract can
    ///         compute, whereas deciding that a given code change is described by a given
    ///         document is a judgement it cannot. It does NOT close the other direction — nothing on-chain can
    ///         force this call when a supplement is anchored — so anchoring a supplement
    ///         must remain a two-transaction operational step with a named owner. Emitting
    ///         the hash here is what lets an indexer reconcile the two sets and alarm on a
    ///         supplement with no window.
    function publishSupplement(
        bytes32 docRef,
        bytes32 supplementVersionHash,
        uint64 opensAt,
        uint64 closesAt
    ) external onlyGovernance returns (uint256 windowIndex) {
        if (mode != Mode.Prospectus) revert WrongMode();
        _assertWindowMeetsFloor(opensAt, closesAt, supplementWindowDurationSeconds);

        (bool exists, uint64 approvedAt) = documents.documentStatus(supplementVersionHash);
        if (!exists || approvedAt == 0) revert SupplementNotAnchoredAndApproved(supplementVersionHash);
        _assertIsProspectusSupplement(docRef, supplementVersionHash);

        emit SupplementAnchorVerified(docRef, supplementVersionHash, approvedAt);

        windowIndex = windows.length;
        windows.push(
            Window({kind: WindowType.SupplementArt23, opensAt: opensAt, closesAt: closesAt, scopeCutoff: opensAt})
        );
        emit WithdrawalWindowOpened(windowIndex, WindowType.SupplementArt23, opensAt, closesAt, opensAt);
    }

    /// @dev Bounded scan — `versionCount` is the number of anchors on one slot, which is a
    ///      handful over an offer's life. A hash found only as an unrevealed commitment does
    ///      not count: it is not yet a document.
    function _assertIsProspectusSupplement(bytes32 docRef, bytes32 versionHash) private view {
        if (documents.regimeOf(docRef) != Regime.ProspectusRegulation) {
            revert NotAProspectusSupplement(docRef, versionHash);
        }

        uint256 count = documents.versionCount(docRef);
        for (uint256 i = 0; i < count; i++) {
            Version memory v = documents.versionAt(docRef, i);
            if (v.versionHash != versionHash || !v.revealed) continue;
            // The base prospectus is not a supplement to itself.
            if (docRef == prospectusDocRef && i == 0) revert NotAProspectusSupplement(docRef, versionHash);
            return;
        }
        revert NotAProspectusSupplement(docRef, versionHash);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // WINDOW B — Art 17(2) final price/amount. Only reachable if the
    // prospectus omitted the final price/amount at filing (Art 17(1)(b)).
    // Covers the WHOLE offer, not just subscriptions before this point —
    // every investor subscribed on an incomplete price, not just early ones.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param opensAt/closesAt Fed in against the working-day calendar; bounded from below by
    ///                         `finalPriceWindowDurationSeconds`.
    function publishFinalPrice(
        uint64 opensAt,
        uint64 closesAt
    ) external onlyGovernance returns (uint256 windowIndex) {
        if (mode != Mode.Prospectus) revert WrongMode();
        if (!finalPriceOmittedAtFiling) revert FinalPriceNeverOmitted();
        if (finalPricePublished) revert FinalPriceAlreadyPublished();
        _assertWindowMeetsFloor(opensAt, closesAt, finalPriceWindowDurationSeconds);
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
        emit WithdrawalWindowOpened(windowIndex, WindowType.FinalPriceArt17, opensAt, closesAt, type(uint64).max);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // WITHDRAWAL — eligible if ANY currently-open window covers this
    // subscription. Windows are independent and may overlap.
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev ⚠️ THE REFUND PATH DELIBERATELY READS NEITHER `identity` NOR `restrictions`. A
    ///      subscriber who has become restricted since subscribing is exercising a statutory
    ///      right to take back THEIR OWN cash, which was never the issuer's; the restriction
    ///      store's rule is that a listed party may not RECEIVE units or a distribution, and
    ///      returning their own money is neither. Gating the refund would convert an
    ///      Art 17(2)/23(2) right into a confiscation on a suspicion flag — and would put the
    ///      restriction on a path where its argument-free revert tells the subscriber, by
    ///      timing, that they were listed. Where a freeze of the cash itself is warranted, it
    ///      is a court order executed off-chain against the issuer, not a `require` here.
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
    // SETTLEMENT — releases escrow to the issuer once the offer has closed,
    // the omitted final price (if any) has been published, and no window
    // covering this subscription remains open or pending. Callable by anyone
    // once the condition holds — a pull, not a push, on purpose.
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Three gates, in the order a reviewer would ask them. (1) Has the offer closed?
    ///      Art 23's supplement duty — and so the Art 23(2) right it opens — runs until the
    ///      offer closes or trading starts, so nothing accepted during the offer is final
    ///      before then. (2) Where the final price was omitted at filing, has it been
    ///      published? Window B cannot have run if it has not opened. (3) Is any window that
    ///      covers this subscription still open or yet to open? Only after all three is
    ///      "no window covers it" the same statement as "no window ever will".
    function settle(uint256 subscriptionId) external {
        Subscription storage s = subscriptions[subscriptionId];
        if (s.withdrawn) revert AlreadyWithdrawn();
        if (s.settled) revert AlreadySettled();
        if (offerClosesAt == 0 || block.timestamp <= offerClosesAt) revert OfferStillOpen();
        if (finalPriceOmittedAtFiling && !finalPricePublished) revert FinalPriceNotPublished();
        if (_hasPendingWindow(s)) revert WindowsStillPending();

        s.settled = true;

        (bool ok, ) = issuer.call{value: s.amountWei}("");
        require(ok, "release failed");

        emit Settled(subscriptionId, s.investor, s.amountWei);
    }
}
