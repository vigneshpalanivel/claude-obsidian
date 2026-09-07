// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ISecurityToken, IDocumentAnchor, IClosedPeriodGate, Version} from "./Interfaces.sol";

/// @title BuybackAgent (illustrative sample — not production code)
/// @notice C1 + C5 — the issuer buying back its own instrument inside the MAR Art 5 safe
///         harbour. The Article 5 conditions are carried here as on-chain parameters rather
///         than as a procedure someone follows, because mis-running a buy-back does not
///         produce a compliance finding: it converts routine treasury activity into market
///         manipulation under Art 15.
/// @dev    ⚠️ THE SAFE HARBOUR IS ALL-OR-NOTHING. Art 5 is an exemption, not a set of best
///         practices. Breach one condition — one purchase above the price cap, one trade in a
///         closed period, one late publication — and the exemption is not partially reduced,
///         it is unavailable for that trading, which is then judged on ordinary Art 12/15
///         manipulation grounds. That is why every condition below is a revert and none is a
///         warning event.
/// @dev    ⚠️ WHAT THIS CONTRACT IS NOT: A CONTINUOUS REDEMPTION FACILITY. Standing offer to
///         buy holders' units back on demand is a different animal from a disclosed, dated,
///         capped buy-back programme, and the difference is a LICENCE TRIGGER rather than a
///         parameter — continuous two-way dealing in one's own instrument raises open-ended
///         fund characterisation on the fund side and systematic-internaliser / trading-venue
///         characterisation on the market side. Nothing here should be reconfigured into one
///         by widening the dates and raising the ceiling.
/// @dev    ⚠️ STABILISATION IS A DIFFERENT SAFE HARBOUR AND IS NOT MODELLED HERE. Art 5(4)–(5)
///         has its own conditions — a designated stabilising manager, a defined stabilisation
///         period set in advance, no stabilising above the offer price. Running stabilisation
///         through a buy-back contract because both live in Art 5 is a category error.
/// @dev    ⚠️ MAR Art 16(2) ATTACHES TO THE ISSUER'S OWN ORDER FLOW. A buy-back is the issuer
///         trading, so the suspicious-order-and-transaction duty applies even to an issuer
///         with no dealer lane. `PurchaseExecuted` is the surveillance feed for that — scoped
///         to the issuer's own flow, not the whole book.
contract BuybackAgent {
    /// @dev Emitted whenever an inter-contract reference is re-pointed.
    event DependencySet(bytes32 indexed role, address indexed impl);

    // ═══════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Art 5(2) admits exactly three purposes and no others.
    /// @dev    An enum rather than a free-text field precisely because the list is closed. A
    ///         buy-back for "general corporate purposes" or to support the price is outside the
    ///         harbour, and a string field invites someone to write exactly that.
    enum Purpose {
        Unset,
        CapitalReduction, // Art 5(2)(a)
        ConvertibleDebtObligations, // Art 5(2)(b)
        EmployeeShareScheme // Art 5(2)(c)
    }

    enum Disposition {
        /// @dev Held in treasury. Still outstanding for most purposes; still the issuer's.
        Hold,
        /// @dev Cancelled. The only disposition consistent with Art 5(2)(a).
        Burn
    }

    enum State {
        None,
        /// @dev Details anchored, not yet started. Art 5(1)(a) disclosure is complete.
        Disclosed,
        Active,
        Ended
    }

    struct Programme {
        State state;
        Purpose purpose;
        Disposition disposition;
        /// @dev The Art 5(1)(a) disclosure — start, end, maximum consideration, maximum number
        ///      of units, maximum price — anchored in `DocumentRegistry` BEFORE the programme
        ///      may start. The caps below are the machine-readable half of the same document
        ///      and must agree with it.
        bytes32 disclosureRef;
        uint64 startDate;
        uint64 endDate;
        uint256 maxConsiderationWei;
        uint256 maxUnits;
        uint256 maxPricePerUnit;
        uint256 spentWei;
        uint256 boughtUnits;
        /// @dev Listing Act (Reg 2024/2809) amendment to Art 5(3): trades are reported to ONE
        ///      competent authority — the one of the most relevant market in liquidity terms
        ///      per MiFIR Art 26(1) — which then forwards on request. Pre-2024 routing filed
        ///      with every venue's NCA in parallel; an internal reporting pipeline still doing
        ///      that is running an obsolete pattern.
        bytes32 reportingNcaId;
    }

    struct Execution {
        address seller;
        uint256 units;
        uint256 pricePerUnit;
        uint64 executedAt;
        /// @dev Art 5(1)(c): public disclosure within 7 daily market sessions. 0 = still owed.
        uint64 publishedAt;
        bytes32 publicationRef;
    }

    /// @notice The Delegated Regulation (EU) 2016/1052 inputs. Fed by an oracle because none of
    ///         them are on-chain facts.
    struct MarketReference {
        /// @dev Art 3(2) of the RTS: no purchase above the higher of the last independent trade
        ///      and the highest current independent bid on the venue.
        uint256 lastIndependentTradePrice;
        uint256 highestIndependentBid;
        /// @dev Art 3(3): average daily volume over the 20 trading days preceding the purchase.
        uint256 averageDailyVolume20d;
        uint64 updatedAt;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ROLES & WIRING
    // ═══════════════════════════════════════════════════════════════════════

    address public immutable governance;
    mapping(address => bool) public isAgent;

    /// @notice ⚠️ The oracle is a critical dependency in the DORA Art 8 sense — its failure
    ///         does not degrade the buy-back, it stops it, by design (see `_marketReference`).
    ///         Designate it before signing the vendor, not after.
    mapping(address => bool) public isOracle;

        /// @dev ⚠️ Concrete type retained DELIBERATELY, and it is a known gap. This dependency
    ///      returns a struct/enum, which a narrow interface cannot declare without
    ///      duplicating the type — and a duplicated struct is a DIFFERENT type to the
    ///      compiler, so every call site here would break. Closing it means moving the
    ///      shared types into `Interfaces.sol` and having the concrete contract import
    ///      them from there. Until then the `immutable` half of the rule is satisfied
    ///      (settable below) and the coupling half is not.
    ISecurityToken public token;
        /// @dev ⚠️ Concrete type retained DELIBERATELY, and it is a known gap. This dependency
    ///      returns a struct/enum, which a narrow interface cannot declare without
    ///      duplicating the type — and a duplicated struct is a DIFFERENT type to the
    ///      compiler, so every call site here would break. Closing it means moving the
    ///      shared types into `Interfaces.sol` and having the concrete contract import
    ///      them from there. Until then the `immutable` half of the rule is satisfied
    ///      (settable below) and the coupling half is not.
    IDocumentAnchor public documents;

    /// @notice Art 19(11) reaches the issuer's own trading. Reused rather than reimplemented so
    ///         one calendar of closed periods governs both the directors and the treasury.
        /// @dev ⚠️ Concrete type retained DELIBERATELY, and it is a known gap. This dependency
    ///      returns a struct/enum, which a narrow interface cannot declare without
    ///      duplicating the type — and a duplicated struct is a DIFFERENT type to the
    ///      compiler, so every call site here would break. Closing it means moving the
    ///      shared types into `Interfaces.sol` and having the concrete contract import
    ///      them from there. Until then the `immutable` half of the rule is satisfied
    ///      (settable below) and the coupling half is not.
    IClosedPeriodGate public closedPeriods;

    address public treasury;

    // ═══════════════════════════════════════════════════════════════════════
    // STATE
    // ═══════════════════════════════════════════════════════════════════════

    uint256 public nextProgrammeId = 1;
    mapping(uint256 => Programme) private _programmes;

    uint256 public nextExecutionId = 1;
    mapping(uint256 => Execution) private _executions;
    /// @dev Executions still owing publication, in order. Bounded by the publication duty
    ///      itself — the queue cannot grow past the deadline without blocking new purchases.
    uint256[] private _unpublished;

    MarketReference private _market;

    /// @notice How long the oracle reading stays usable. ⚠️ Fail-closed: a stale reading is not
    ///         a slightly-old price cap, it is no price cap.
    uint64 public marketDataMaxAge = 15 minutes;

    /// @notice Art 5(1)(c) — "within 7 daily market sessions". ⚠️ A MARKET-SESSION CALENDAR IS
    ///         NOT DERIVABLE ON-CHAIN: sessions are not days, venues close on different
    ///         holidays, and a DLT MTF's own calendar is its own. So this is a governance-set
    ///         duration that must be configured to the conservative reading of the calendar of
    ///         the venue actually used, and re-checked when the venue changes. It is not
    ///         defaulted, because a wrong default here is a silent Art 5 breach.
    uint64 public publicationDeadlinePeriod;

    /// @notice Art 5 checklist: "no transactions during a period of self-imposed restriction
    ///         following a tender offer." Not a closed period and not a programme date — a
    ///         third, separate blackout the issuer imposes on itself and must then honour.
    uint64 public selfImposedRestrictionUntil;

    /// @dev The RTS volume condition is a share of AVERAGE DAILY volume, so it accumulates over
    ///      a day rather than applying per order. ⚠️ Keyed on a UTC calendar day, which is an
    ///      approximation of a trading day — conservative where a trading day is shorter,
    ///      WRONG WHERE A SESSION SPANS MIDNIGHT UTC. Confirm against the venue calendar.
    mapping(uint256 => uint256) public unitsBoughtOnDay;

    uint256 public constant ADV_LIMIT_NUMERATOR = 25;
    uint256 public constant ADV_LIMIT_DENOMINATOR = 100;

    uint256 private _locked = 1;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS
    // ═══════════════════════════════════════════════════════════════════════

    event AgentSet(address indexed agent, bool allowed);
    event OracleSet(address indexed oracle, bool allowed);
    event TreasurySet(address treasury);
    event MarketDataMaxAgeSet(uint64 seconds_);
    event PublicationDeadlineSet(uint64 seconds_);
    event SelfImposedRestrictionSet(uint64 until);

    event ProgrammeDisclosed(
        uint256 indexed programmeId, Purpose purpose, bytes32 disclosureRef, uint64 startDate, uint64 endDate
    );
    event ProgrammeStarted(uint256 indexed programmeId, uint64 at);
    event ProgrammeEnded(uint256 indexed programmeId, uint256 spentWei, uint256 boughtUnits);

    event MarketReferenceUpdated(uint256 lastTrade, uint256 highestBid, uint256 adv20d, uint64 at);

    /// @dev The MAR Art 16(2) surveillance feed and the Art 5(3) reporting feed in one record.
    ///      Carries the single NCA id so a reporting bridge routes it without a second lookup.
    event PurchaseExecuted(
        uint256 indexed programmeId,
        uint256 indexed executionId,
        address indexed seller,
        uint256 units,
        uint256 pricePerUnit,
        bytes32 reportingNcaId
    );
    event PurchasePublished(uint256 indexed executionId, bytes32 publicationRef, uint64 at);
    event UnitsDisposed(uint256 indexed programmeId, Disposition disposition, uint256 units);

    // ═══════════════════════════════════════════════════════════════════════
    // ERRORS — named after the condition breached, so the audit map resolves.
    // ═══════════════════════════════════════════════════════════════════════

    error NotGovernance();
    error NotAgent();
    error NotOracle();
    error Reentrancy();
    error TreasuryNotSet();
    error PublicationDeadlineNotConfigured();

    error UnknownProgramme(uint256 programmeId);
    error WrongState(uint256 programmeId, State expected, State actual);
    error PurposeNotSet();
    error PurposeRequiresBurn(Purpose purpose);
    error DatesInvalid(uint64 startDate, uint64 endDate);

    /// @dev Art 5(1)(a) — details must be disclosed BEFORE the programme starts.
    error DisclosureNotAnchored(bytes32 disclosureRef);
    error DisclosureNotCurrent(bytes32 disclosureRef);
    error DisclosureAfterStart(uint64 anchoredAt, uint64 startDate);

    error ProgrammeNotOpenYet(uint64 startDate);
    error ProgrammeExpired(uint64 endDate);
    error ConsiderationCeilingBreached(uint256 wouldSpend, uint256 ceiling);
    error UnitCeilingBreached(uint256 wouldBuy, uint256 ceiling);

    /// @dev Del. Reg (EU) 2016/1052 Art 3(2).
    error PriceAboveIndependentReference(uint256 offered, uint256 permitted);
    error PriceAboveDisclosedMaximum(uint256 offered, uint256 disclosedMaximum);
    /// @dev Del. Reg (EU) 2016/1052 Art 3(3).
    error DailyVolumeLimitBreached(uint256 wouldBuyToday, uint256 permittedToday);

    error MarketDataStale(uint64 updatedAt, uint64 maxAge);
    error MarketDataMissing();

    /// @dev MAR Art 19(11), reaching the issuer's own trading.
    error InClosedPeriod(uint256 periodId);
    error InSelfImposedRestriction(uint64 until);
    /// @dev Art 5(1)(c) — the harbour is already lost for the unpublished trade; buying more
    ///      under a programme that has left the harbour is the decision this refuses to make
    ///      silently. See the note on `_requirePublicationCurrent`.
    error PublicationOverdue(uint256 executionId, uint64 dueBy);
    error AlreadyPublished(uint256 executionId);
    error UnknownExecution(uint256 executionId);
    /// @dev "No selling of own shares during the programme."
    error SellingBlockedDuringProgramme(uint256 programmeId);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyAgent() {
        if (!isAgent[msg.sender]) revert NotAgent();
        _;
    }

    modifier nonReentrant() {
        if (_locked != 1) revert Reentrancy();
        _locked = 2;
        _;
        _locked = 1;
    }

    constructor(address governance_, address token_, address documents_, address closedPeriods_) {
        governance = governance_;
        token = ISecurityToken(token_);
        documents = IDocumentAnchor(documents_);
        closedPeriods = IClosedPeriodGate(closedPeriods_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CONFIGURATION
    // ═══════════════════════════════════════════════════════════════════════

    function setAgent(address agent, bool allowed) external onlyGovernance {
        isAgent[agent] = allowed;
        emit AgentSet(agent, allowed);
    }

    function setOracle(address oracle, bool allowed) external onlyGovernance {
        isOracle[oracle] = allowed;
        emit OracleSet(oracle, allowed);
    }

    function setTreasury(address treasury_) external onlyGovernance {
        treasury = treasury_;
        emit TreasurySet(treasury_);
    }

    function setMarketDataMaxAge(uint64 seconds_) external onlyGovernance {
        marketDataMaxAge = seconds_;
        emit MarketDataMaxAgeSet(seconds_);
    }

    function setPublicationDeadlinePeriod(uint64 seconds_) external onlyGovernance {
        publicationDeadlinePeriod = seconds_;
        emit PublicationDeadlineSet(seconds_);
    }

    /// @notice Opens a self-imposed restriction window — typically following a tender offer.
    /// @dev    Deliberately has no "cancel" that shortens an active window. A restriction the
    ///         issuer publicly imposed and then quietly lifted to trade is worse than never
    ///         having imposed it, and it is exactly the fact pattern Art 12(1)(c) describes.
    function openSelfImposedRestriction(uint64 until) external onlyGovernance {
        if (until > selfImposedRestrictionUntil) {
            selfImposedRestrictionUntil = until;
            emit SelfImposedRestrictionSet(until);
        }
    }

    function updateMarketReference(
        uint256 lastIndependentTradePrice,
        uint256 highestIndependentBid,
        uint256 averageDailyVolume20d
    ) external {
        if (!isOracle[msg.sender]) revert NotOracle();

        _market = MarketReference({
            lastIndependentTradePrice: lastIndependentTradePrice,
            highestIndependentBid: highestIndependentBid,
            averageDailyVolume20d: averageDailyVolume20d,
            updatedAt: uint64(block.timestamp)
        });

        emit MarketReferenceUpdated(
            lastIndependentTradePrice, highestIndependentBid, averageDailyVolume20d, uint64(block.timestamp)
        );
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PROGRAMME LIFECYCLE
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Art 5(1)(a). Anchors the programme against a document that must already exist in
    ///         `DocumentRegistry` and must have been anchored before the start date.
    /// @dev    ⚠️ THE CHECK IS ON THE ANCHORING TIME, NOT ON THE OPERATOR'S WORD. "Disclosed
    ///         before the start" is verifiable here because the document registry timestamps
    ///         the anchor. A boolean `disclosed` flag set by the same party that starts the
    ///         programme would evidence nothing.
    /// @dev    ⚠️ THE CAPS BELOW DUPLICATE THE DISCLOSURE DOCUMENT, AND THAT DUPLICATION IS THE
    ///         RISK. Art 5 is breached by trading outside what was disclosed, so an on-chain
    ///         ceiling that is more generous than the published one enforces nothing. Reconcile
    ///         the two at sign-off; the contract can prove the document existed, not that the
    ///         numbers in it match.
    function discloseProgramme(
        Purpose purpose,
        Disposition disposition,
        bytes32 disclosureRef,
        uint64 startDate,
        uint64 endDate,
        uint256 maxConsiderationWei,
        uint256 maxUnits,
        uint256 maxPricePerUnit,
        bytes32 reportingNcaId
    ) external onlyAgent returns (uint256 programmeId) {
        if (purpose == Purpose.Unset) revert PurposeNotSet();
        // Art 5(2)(a) is a capital reduction. Units bought to reduce capital and then held in
        // treasury have not reduced anything, and the stated purpose was therefore not the
        // actual one — which is the fact the exemption turns on.
        if (purpose == Purpose.CapitalReduction && disposition != Disposition.Burn) {
            revert PurposeRequiresBurn(purpose);
        }
        if (startDate >= endDate || startDate < block.timestamp) revert DatesInvalid(startDate, endDate);
        if (publicationDeadlinePeriod == 0) revert PublicationDeadlineNotConfigured();

        // ⚠️ Keyed on the DOCUMENT REF, not on a version hash. `documentStatus` answers a
        // different question — "is this specific version anchored, and was it NCA-approved" —
        // which is what `DoraGovernor` needs and not what Art 5(1)(a) asks.
        uint256 count = documents.versionCount(disclosureRef);
        if (count == 0) revert DisclosureNotAnchored(disclosureRef);

        Version memory v = documents.versionAt(disclosureRef, count - 1);
        if (!documents.isCurrent(disclosureRef, v.versionHash)) revert DisclosureNotCurrent(disclosureRef);
        if (v.anchoredAt >= startDate) revert DisclosureAfterStart(v.anchoredAt, startDate);

        programmeId = nextProgrammeId++;
        Programme storage p = _programmes[programmeId];
        p.state = State.Disclosed;
        p.purpose = purpose;
        p.disposition = disposition;
        p.disclosureRef = disclosureRef;
        p.startDate = startDate;
        p.endDate = endDate;
        p.maxConsiderationWei = maxConsiderationWei;
        p.maxUnits = maxUnits;
        p.maxPricePerUnit = maxPricePerUnit;
        p.reportingNcaId = reportingNcaId;

        emit ProgrammeDisclosed(programmeId, purpose, disclosureRef, startDate, endDate);
    }

    function startProgramme(uint256 programmeId) external onlyAgent {
        Programme storage p = _requireState(programmeId, State.Disclosed);
        if (block.timestamp < p.startDate) revert ProgrammeNotOpenYet(p.startDate);
        if (block.timestamp > p.endDate) revert ProgrammeExpired(p.endDate);
        if (treasury == address(0)) revert TreasuryNotSet();

        p.state = State.Active;
        emit ProgrammeStarted(programmeId, uint64(block.timestamp));
    }

    function endProgramme(uint256 programmeId) external onlyAgent {
        Programme storage p = _requireState(programmeId, State.Active);
        p.state = State.Ended;
        emit ProgrammeEnded(programmeId, p.spentWei, p.boughtUnits);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // THE PURCHASE — every Art 5 condition, in one place
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Buys `units` from `seller` at `pricePerUnit`, funded by the caller's `msg.value`.
    ///         The seller must have approved this contract on the token first.
    /// @dev    The order of checks is chosen so the cheapest categorical bars fail first — a
    ///         closed period stops everything regardless of price, so there is no reason to
    ///         read the oracle to find that out.
    function executePurchase(
        uint256 programmeId,
        address seller,
        uint256 units,
        uint256 pricePerUnit
    ) external payable onlyAgent nonReentrant returns (uint256 executionId) {
        Programme storage p = _requireState(programmeId, State.Active);

        // ── window ───────────────────────────────────────────────────────
        if (block.timestamp < p.startDate) revert ProgrammeNotOpenYet(p.startDate);
        if (block.timestamp > p.endDate) revert ProgrammeExpired(p.endDate);

        // ── MAR Art 19(11) + self-imposed restriction ────────────────────
        (bool inClosedPeriod, uint256 periodId) = closedPeriods.activePeriod();
        if (inClosedPeriod) revert InClosedPeriod(periodId);
        if (block.timestamp < selfImposedRestrictionUntil) {
            revert InSelfImposedRestriction(selfImposedRestrictionUntil);
        }

        // ── Art 5(1)(c) — the harbour must not already be lost ───────────
        _requirePublicationCurrent();

        // ── disclosed ceilings, then the RTS conditions ──────────────────
        _consumeDisclosedCeilings(p, units, pricePerUnit);
        _consumeRtsLimits(units, pricePerUnit);

        // ── settle ───────────────────────────────────────────────────────
        executionId = nextExecutionId++;
        _executions[executionId] = Execution({
            seller: seller,
            units: units,
            pricePerUnit: pricePerUnit,
            executedAt: uint64(block.timestamp),
            publishedAt: 0,
            publicationRef: bytes32(0)
        });
        _unpublished.push(executionId);

        // The token's own C1 hook runs inside `transferFrom` — a buy-back is not exempt from
        // the instrument's transfer rules, and the treasury is a holder like any other.
        token.transferFrom(seller, treasury, units);

        (bool ok, ) = payable(seller).call{value: units * pricePerUnit}("");
        if (!ok) revert PayoutFailed(seller, units * pricePerUnit);

        emit PurchaseExecuted(programmeId, executionId, seller, units, pricePerUnit, p.reportingNcaId);
    }

    error PayoutFailed(address to, uint256 amount);

    /// @dev The ceilings the issuer published under Art 5(1)(a). Split out from
    ///      `executePurchase` for stack depth, not because it is a separate concern — read the
    ///      two together.
    function _consumeDisclosedCeilings(Programme storage p, uint256 units, uint256 pricePerUnit) private {
        uint256 consideration = units * pricePerUnit;

        if (pricePerUnit > p.maxPricePerUnit) revert PriceAboveDisclosedMaximum(pricePerUnit, p.maxPricePerUnit);
        if (p.spentWei + consideration > p.maxConsiderationWei) {
            revert ConsiderationCeilingBreached(p.spentWei + consideration, p.maxConsiderationWei);
        }
        if (p.boughtUnits + units > p.maxUnits) revert UnitCeilingBreached(p.boughtUnits + units, p.maxUnits);

        p.spentWei += consideration;
        p.boughtUnits += units;
    }

    /// @dev Commission Delegated Regulation (EU) 2016/1052 — the price condition (Art 3(2)) and
    ///      the 25%-of-ADV volume condition (Art 3(3)). Both read from the same oracle snapshot
    ///      so a purchase cannot pass the price test on one reading and the volume test on
    ///      another.
    function _consumeRtsLimits(uint256 units, uint256 pricePerUnit) private {
        MarketReference memory m = _marketReference();

        uint256 priceCap = m.lastIndependentTradePrice > m.highestIndependentBid
            ? m.lastIndependentTradePrice
            : m.highestIndependentBid;
        if (pricePerUnit > priceCap) revert PriceAboveIndependentReference(pricePerUnit, priceCap);

        uint256 day = block.timestamp / 1 days;
        uint256 permittedToday = (m.averageDailyVolume20d * ADV_LIMIT_NUMERATOR) / ADV_LIMIT_DENOMINATOR;
        uint256 wouldBuyToday = unitsBoughtOnDay[day] + units;
        if (wouldBuyToday > permittedToday) revert DailyVolumeLimitBreached(wouldBuyToday, permittedToday);

        unitsBoughtOnDay[day] = wouldBuyToday;
    }

    /// @notice Art 5(1)(c) publication. Records that the trade was publicly disclosed and
    ///         reported to the single NCA, against the publication artefact.
    /// @dev    This contract cannot publish anything — publication is a filing to a venue, an
    ///         NCA and a public channel. What it does is make the on-chain record of the trade
    ///         and the record of its publication the SAME record, so the gap between them is
    ///         measurable rather than reconstructed from two systems afterwards.
    function recordPublication(uint256 executionId, bytes32 publicationRef) external onlyAgent {
        Execution storage e = _executions[executionId];
        if (e.executedAt == 0) revert UnknownExecution(executionId);
        if (e.publishedAt != 0) revert AlreadyPublished(executionId);

        e.publishedAt = uint64(block.timestamp);
        e.publicationRef = publicationRef;

        for (uint256 i = 0; i < _unpublished.length; i++) {
            if (_unpublished[i] == executionId) {
                _unpublished[i] = _unpublished[_unpublished.length - 1];
                _unpublished.pop();
                break;
            }
        }

        emit PurchasePublished(executionId, publicationRef, uint64(block.timestamp));
    }

    /// @dev ⚠️ A POLICY CHOICE, OVERRULABLE, AND WORTH ARGUING ABOUT. Missing the 7-session
    ///      publication does not retroactively make the trade unlawful — it costs the harbour
    ///      for that trade. Nothing in Art 5 says the NEXT trade is barred. This contract bars
    ///      it anyway, on the view that an issuer whose reporting pipeline has already failed
    ///      once should not keep accumulating unpublished trades under a programme that has
    ///      left the exemption. The cost is real: a stuck reporting job halts the buy-back. An
    ///      operator that prefers to keep trading and remediate should make that decision in
    ///      writing, once, rather than discover this revert mid-programme.
    function _requirePublicationCurrent() private view {
        uint256 n = _unpublished.length;
        for (uint256 i = 0; i < n; i++) {
            Execution storage e = _executions[_unpublished[i]];
            uint64 dueBy = e.executedAt + publicationDeadlinePeriod;
            if (block.timestamp > dueBy) revert PublicationOverdue(_unpublished[i], dueBy);
        }
    }

    /// @dev ⚠️ FAIL CLOSED ON ORACLE FAILURE. With no reading, or a stale one, there is no
    ///      price cap and no volume cap — the two conditions that most directly separate a
    ///      lawful buy-back from market manipulation. Buying on a "best available" number is
    ///      the failure mode this refuses.
    function _marketReference() private view returns (MarketReference memory) {
        MarketReference memory m = _market;
        if (m.updatedAt == 0) revert MarketDataMissing();
        if (block.timestamp > uint256(m.updatedAt) + uint256(marketDataMaxAge)) {
            revert MarketDataStale(m.updatedAt, marketDataMaxAge);
        }
        if (m.averageDailyVolume20d == 0) revert MarketDataMissing();
        return m;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // DISPOSITION — burn or hold
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Cancels units held in treasury under a Burn-election programme.
    /// @dev    Requires this contract to be an agent on the token. Note the sequencing: units
    ///         are bought into treasury first and burned as a separate, separately-logged act,
    ///         rather than burned on receipt. A capital reduction is a corporate act with its
    ///         own company-law steps, and collapsing it into the purchase hides the moment it
    ///         actually happened.
    function disposeUnits(uint256 programmeId, uint256 units) external onlyAgent {
        Programme storage p = _programmes[programmeId];
        if (p.state == State.None) revert UnknownProgramme(programmeId);

        if (p.disposition == Disposition.Burn) {
            token.burn(treasury, units);
        }
        emit UnitsDisposed(programmeId, p.disposition, units);
    }

    /// @notice "No selling of own shares during the programme." Any treasury disposal path must
    ///         consult this first.
    /// @dev    Exposed as a check rather than enforced by owning the treasury, because the
    ///         treasury is an ordinary wallet the issuer controls by other means too. ⚠️ THAT
    ///         IS A REAL LIMIT: this contract can refuse to sell, it cannot stop the issuer
    ///         selling from the same wallet directly. Closing that properly means freezing
    ///         treasury units on the token for the programme's duration.
    function checkIssuerMaySell(uint256 programmeId) external view {
        Programme storage p = _programmes[programmeId];
        if (p.state == State.Active) revert SellingBlockedDuringProgramme(programmeId);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS
    // ═══════════════════════════════════════════════════════════════════════

    function _requireState(uint256 programmeId, State expected) private view returns (Programme storage p) {
        p = _programmes[programmeId];
        if (p.state == State.None) revert UnknownProgramme(programmeId);
        if (p.state != expected) revert WrongState(programmeId, expected, p.state);
    }

    function programme(uint256 programmeId) external view returns (Programme memory) {
        return _programmes[programmeId];
    }

    function execution(uint256 executionId) external view returns (Execution memory) {
        return _executions[executionId];
    }

    /// @notice Executions still owing publication. The operations-desk view of an Art 5(1)(c)
    ///         clock that is running.
    function unpublishedExecutions() external view returns (uint256[] memory) {
        return _unpublished;
    }

    function marketReference() external view returns (MarketReference memory) {
        return _market;
    }

    /// @notice Headroom under both RTS conditions right now. Reviewer- and desk-facing; the
    ///         purchase path does its own checks and does not call this.
    function headroomToday() external view returns (uint256 priceCap, uint256 unitsRemainingToday) {
        MarketReference memory m = _market;
        priceCap =
            m.lastIndependentTradePrice > m.highestIndependentBid
                ? m.lastIndependentTradePrice
                : m.highestIndependentBid;

        uint256 permitted = (m.averageDailyVolume20d * ADV_LIMIT_NUMERATOR) / ADV_LIMIT_DENOMINATOR;
        uint256 bought = unitsBoughtOnDay[block.timestamp / 1 days];
        unitsRemainingToday = permitted > bought ? permitted - bought : 0;
    }

    /// @notice Re-point `token`. Swap, never unset — the operational-resilience regime requires
    ///         this reference stay swappable at the contract layer rather than hard-wired.
    function setToken(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        token = ISecurityToken(impl);
        emit DependencySet("token", impl);
    }
    /// @notice Re-point `documents`. Swap, never unset — the operational-resilience regime requires
    ///         this reference stay swappable at the contract layer rather than hard-wired.
    function setDocuments(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        documents = IDocumentAnchor(impl);
        emit DependencySet("documents", impl);
    }
    /// @notice Re-point `closedPeriods`. Swap, never unset — the operational-resilience regime requires
    ///         this reference stay swappable at the contract layer rather than hard-wired.
    function setClosedPeriods(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        closedPeriods = IClosedPeriodGate(impl);
        emit DependencySet("closedPeriods", impl);
    }
}
