// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IMarketEventSchema, MifirClock} from "./MarketEventSchema.sol";

interface IIdentityGate {
    function checkEligibleAndIdentifiable(address wallet) external view;
}

/// @title SiQuoteEngine (illustrative sample — not production code)
/// @notice MiFIR Arts 14–20 (systematic internaliser firm quotes) and Art 39a (payment-for-
///         order-flow ban), for the dealer/SI lane — a firm dealing on own account against
///         client orders, outside a trading venue.
/// @dev    ⚠️ "FIRM" IS THE ENTIRE OBLIGATION, AND IT IS THE ONE A NAIVE ON-CHAIN QUOTE
///         BREAKS. Art 15(1) requires an SI to execute at the quoted price against any client
///         to whom the quote is available, up to standard market size. A quote a maker can
///         withdraw in the same block it is hit is not firm — it is an indication, and an SI
///         publishing indications is an SI in breach. Hence: quotes carry an explicit
///         `firmUntil`, cancellation before that moment reverts, and the only escape is a
///         governance-declared exceptional-market-conditions state under Art 15(2), which is
///         itself logged with a reason. Making withdrawal expensive and visible is the point.
/// @dev    ⚠️ MEV IS A PFOF QUESTION ON-CHAIN. Art 39a bans receiving any fee, commission or
///         non-monetary benefit from a third party for routing client orders. Priority-fee
///         rebates, validator or builder payments, and on-chain auction proceeds are exactly
///         that shape: a third party paying for order flow. `attestRouting` requires the
///         router to state, per order, that no such benefit accrued to the firm — or to
///         declare it and pass it through in full. There is no third option, and the
///         inducements register is on-chain because "we don't take PFOF" is not evidence.
/// @dev    ⚠️ Art 22c CLOCK SYNC BINDS THE DEALER LANE. Venues were already caught under
///         MiFID II; Art 22c is what newly reached SIs, DPEs, APAs and CTPs. Every quote and
///         execution here carries a `syncedTimestamp` from the firm's traceable clock, never
///         `block.timestamp` — see `MifirClock`.
contract SiQuoteEngine is IMarketEventSchema, MifirClock {
    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;
    address public immutable quotingDesk; // publishes and refreshes quotes
    address public immutable router; // submits client orders and routing attestations
    IIdentityGate public immutable identity;

    /// @notice The SI's own MIC / identifier as it appears in the reporting field. Set once:
    ///         a venue identifier that changes silently corrupts every historic report that
    ///         referenced it.
    bytes32 public immutable venueMic;

    // ─────────────────────────── quotes ───────────────────────────────────────

    struct Quote {
        bool live;
        bytes32 instrumentId;
        uint256 bidPriceWei;
        uint256 askPriceWei;
        uint256 bidSize;
        uint256 askSize;
        /// @dev Standard market size for the instrument's class, fed in. Below SMS the quote
        ///      is firm; above it Art 15(1) allows the SI to decline, so the boundary has to
        ///      be explicit rather than implied by `bidSize`/`askSize`.
        uint256 standardMarketSize;
        /// @dev The commitment. Until this moment the quote cannot be pulled, and any
        ///      incoming order up to SMS must be filled at the quoted price.
        uint64 firmUntil;
        uint64 publishedAt; // synced clock
    }

    mapping(bytes32 => Quote) private _quotes; // instrumentId => current quote

    /// @notice Art 15(1), 2nd limb — an SI may limit the number of transactions it undertakes
    ///         to enter into with any one client at a given quote, provided the policy is
    ///         non-discriminatory. A policy applied per-client at the desk's discretion is
    ///         precisely the discrimination the Article forbids, so the limit is one number
    ///         applied to everyone.
    uint256 public maxFillsPerClientPerQuote = 3;
    mapping(bytes32 => mapping(address => uint256)) public fillsAtQuote; // quoteKey => client => count

    // ─────────────────────────── exceptional market conditions (Art 15(2)) ────

    bool public exceptionalConditions;
    uint64 public exceptionalDeclaredAt;

    // ─────────────────────────── PFOF register (Art 39a) ──────────────────────

    /// @dev A routing attestation. `thirdPartyBenefitWei` is not assumed to be zero — it is
    ///      recorded. Where it is non-zero the firm must show it was passed through to the
    ///      client in full; retaining any part of it is the breach. Declaring zero and being
    ///      wrong is a false statement on the record, which is a materially different
    ///      position from never having been asked.
    struct RoutingAttestation {
        bool recorded;
        address client;
        bytes32 instrumentId;
        uint256 thirdPartyBenefitWei;
        bytes32 benefitSourceCode; // "NONE" / "MEV_REBATE" / "VALIDATOR_REBATE" / "AUCTION" / "OTHER"
        bool passedThroughInFull;
        uint64 syncedTimestamp;
    }

    mapping(bytes32 => RoutingAttestation) public routingAttestations; // orderId => attestation

    // ─────────────────────────── events ───────────────────────────────────────

    event QuotePublished(
        bytes32 indexed instrumentId,
        uint256 bidPriceWei,
        uint256 askPriceWei,
        uint256 bidSize,
        uint256 askSize,
        uint64 firmUntil,
        uint64 syncedTimestamp
    );
    event QuoteWithdrawn(bytes32 indexed instrumentId, bytes32 reasonHash, uint64 syncedTimestamp);
    event ExceptionalConditionsDeclared(bytes32 reasonHash, uint64 at);
    event ExceptionalConditionsLifted(uint64 at);
    event MaxFillsPerClientSet(uint256 limit);
    event RoutingAttested(
        bytes32 indexed orderId,
        address indexed client,
        uint256 thirdPartyBenefitWei,
        bytes32 benefitSourceCode,
        bool passedThroughInFull
    );
    /// @dev MiFID II Art 27, as amended. The five limbs are captured PER EXECUTION, and the
    ///      fifth — settlement certainty — is the one a conventional venue never had to
    ///      report and a chain cannot assume. Reorg depth is the honest on-chain proxy for it.
    event BestExecutionCaptured(
        bytes32 indexed orderId,
        uint256 priceWei,
        uint256 costWei,
        uint32 speedMillis,
        uint16 likelihoodBps,
        uint16 settlementCertaintyBps
    );

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotQuotingDesk();
    error NotRouter();
    error NoLiveQuote(bytes32 instrumentId);
    error QuoteStillFirm(bytes32 instrumentId, uint64 firmUntil);
    error QuoteExpired(bytes32 instrumentId, uint64 firmUntil);
    error PriceNotAsQuoted(uint256 offeredWei, uint256 quotedWei);
    error AboveStandardMarketSize(uint256 quantity, uint256 sms);
    error FillLimitReached(address client, uint256 limit);
    error NoRoutingAttestation(bytes32 orderId);
    error InducementRetained(bytes32 orderId, uint256 benefitWei);
    error NotInExceptionalConditions();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(
        address governance_,
        address quotingDesk_,
        address router_,
        address identity_,
        bytes32 venueMic_
    ) {
        governance = governance_;
        quotingDesk = quotingDesk_;
        router = router_;
        identity = IIdentityGate(identity_);
        venueMic = venueMic_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // QUOTING — Arts 14–15
    // ═══════════════════════════════════════════════════════════════════════

    function publishQuote(
        bytes32 instrumentId,
        uint256 bidPriceWei,
        uint256 askPriceWei,
        uint256 bidSize,
        uint256 askSize,
        uint256 standardMarketSize,
        uint64 firmUntil,
        uint64 syncedTimestamp
    ) external {
        if (msg.sender != quotingDesk) revert NotQuotingDesk();
        _requireSyncedClock(syncedTimestamp);

        // Replacing a still-firm quote is a withdrawal by another name, so it goes through
        // the same gate. Otherwise "update" becomes the cancellation path Art 15(2) closes.
        Quote storage existing = _quotes[instrumentId];
        if (existing.live && block.timestamp < existing.firmUntil && !exceptionalConditions) {
            revert QuoteStillFirm(instrumentId, existing.firmUntil);
        }

        _quotes[instrumentId] = Quote({
            live: true,
            instrumentId: instrumentId,
            bidPriceWei: bidPriceWei,
            askPriceWei: askPriceWei,
            bidSize: bidSize,
            askSize: askSize,
            standardMarketSize: standardMarketSize,
            firmUntil: firmUntil,
            publishedAt: syncedTimestamp
        });

        emit QuotePublished(instrumentId, bidPriceWei, askPriceWei, bidSize, askSize, firmUntil, syncedTimestamp);

        // Pre-trade transparency, RTS 1/RTS 2 schema. An SI quote is a pre-trade
        // publication event, not merely an internal price.
        emit OrderCreated(
            keccak256(abi.encodePacked(instrumentId, syncedTimestamp)),
            instrumentId,
            Side.Buy,
            OrderType.Quote,
            bidPriceWei,
            bidSize,
            syncedTimestamp,
            "SI_QUOTE"
        );
    }

    /// @notice Art 15(2) — withdrawal only under exceptional market conditions, and only
    ///         while that state is declared. Outside it, a firm quote runs to `firmUntil`.
    function withdrawQuote(bytes32 instrumentId, bytes32 reasonHash, uint64 syncedTimestamp) external {
        if (msg.sender != quotingDesk) revert NotQuotingDesk();
        _requireSyncedClock(syncedTimestamp);

        Quote storage q = _quotes[instrumentId];
        if (!q.live) revert NoLiveQuote(instrumentId);
        if (block.timestamp < q.firmUntil && !exceptionalConditions) {
            revert QuoteStillFirm(instrumentId, q.firmUntil);
        }

        q.live = false;
        emit QuoteWithdrawn(instrumentId, reasonHash, syncedTimestamp);
        emit OrderCancelled(keccak256(abi.encodePacked(instrumentId, q.publishedAt)), instrumentId, syncedTimestamp);
    }

    /// @notice Governance, not the desk — deliberately. The party that benefits from pulling
    ///         quotes is not the party that gets to declare it may.
    function declareExceptionalConditions(bytes32 reasonHash) external onlyGovernance {
        exceptionalConditions = true;
        exceptionalDeclaredAt = uint64(block.timestamp);
        emit ExceptionalConditionsDeclared(reasonHash, exceptionalDeclaredAt);
    }

    function liftExceptionalConditions() external onlyGovernance {
        if (!exceptionalConditions) revert NotInExceptionalConditions();
        exceptionalConditions = false;
        emit ExceptionalConditionsLifted(uint64(block.timestamp));
    }

    function setMaxFillsPerClientPerQuote(uint256 limit) external onlyGovernance {
        maxFillsPerClientPerQuote = limit;
        emit MaxFillsPerClientSet(limit);
    }

    function setClockDivergenceLimit(uint64 seconds_) external onlyGovernance {
        _setClockDivergenceLimit(seconds_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PFOF — Art 39a. Attestation FIRST, execution second. Ordering matters:
    // an attestation collected after the fill is a description of a decision
    // already taken, which is what the Article is trying to prevent.
    // ═══════════════════════════════════════════════════════════════════════

    function attestRouting(
        bytes32 orderId,
        address client,
        bytes32 instrumentId,
        uint256 thirdPartyBenefitWei,
        bytes32 benefitSourceCode,
        bool passedThroughInFull,
        uint64 syncedTimestamp
    ) external {
        if (msg.sender != router) revert NotRouter();
        _requireSyncedClock(syncedTimestamp);

        // The ban is on the firm RETAINING the benefit. A rebate passed through to the client
        // in full is outside it; anything the firm keeps is inside it, whatever it is called.
        if (thirdPartyBenefitWei > 0 && !passedThroughInFull) {
            revert InducementRetained(orderId, thirdPartyBenefitWei);
        }

        routingAttestations[orderId] = RoutingAttestation({
            recorded: true,
            client: client,
            instrumentId: instrumentId,
            thirdPartyBenefitWei: thirdPartyBenefitWei,
            benefitSourceCode: benefitSourceCode,
            passedThroughInFull: passedThroughInFull,
            syncedTimestamp: syncedTimestamp
        });

        emit RoutingAttested(orderId, client, thirdPartyBenefitWei, benefitSourceCode, passedThroughInFull);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // EXECUTION AGAINST THE FIRM QUOTE
    // ═══════════════════════════════════════════════════════════════════════

    function hitQuote(
        bytes32 orderId,
        address client,
        bytes32 instrumentId,
        Side side,
        uint256 quantity,
        uint256 offeredPriceWei,
        uint64 syncedTimestamp
    ) external returns (bytes32 tradeId) {
        if (msg.sender != router) revert NotRouter();
        _requireSyncedClock(syncedTimestamp);

        // Both gates: eligible to hold, and identifiable to the MiFIR field standard. The
        // second is pre-trade for a reason — a trade against an unidentifiable counterparty
        // is one that cannot be reported, and Art 26 has no "identify later" limb.
        identity.checkEligibleAndIdentifiable(client);

        if (!routingAttestations[orderId].recorded) revert NoRoutingAttestation(orderId);

        Quote storage q = _quotes[instrumentId];
        if (!q.live) revert NoLiveQuote(instrumentId);
        if (block.timestamp > q.firmUntil) revert QuoteExpired(instrumentId, q.firmUntil);
        if (quantity > q.standardMarketSize) revert AboveStandardMarketSize(quantity, q.standardMarketSize);

        uint256 quoted = side == Side.Buy ? q.askPriceWei : q.bidPriceWei;
        if (offeredPriceWei != quoted) revert PriceNotAsQuoted(offeredPriceWei, quoted);

        bytes32 quoteKey = keccak256(abi.encodePacked(instrumentId, q.publishedAt));
        uint256 fills = fillsAtQuote[quoteKey][client] + 1;
        if (fills > maxFillsPerClientPerQuote) revert FillLimitReached(client, maxFillsPerClientPerQuote);
        fillsAtQuote[quoteKey][client] = fills;

        tradeId = keccak256(abi.encodePacked(orderId, instrumentId, syncedTimestamp));

        // Both schemas, one execution. Transparency first (public, no counterparties),
        // reporting second (private field set, with them). Emitting only one of the two is
        // the failure this file exists to prevent.
        emit TradePublished(
            tradeId,
            instrumentId,
            quoted,
            quantity,
            syncedTimestamp,
            TradeFlags({
                benchmark: false,
                negotiated: false,
                portfolio: false,
                largeInScale: false,
                deferred: false,
                cancelled: false,
                amended: false
            })
        );

        // Counterparties as wallets. The SI is always one side (own account); which side
        // follows from the client's order direction. The bridge resolves LEI / NCI from
        // `IdentityRegistry` at this block — nothing identifying is carried in the log.
        (address buyer, address seller) = side == Side.Buy ? (client, address(this)) : (address(this), client);

        emit TradeReportable(
            tradeId,
            instrumentId,
            venueMic,
            buyer,
            seller,
            quoted,
            quantity,
            TradingCapacity.DealingOnOwnAccount, // an SI deals on own account by definition
            syncedTimestamp
        );
    }

    /// @notice MiFID II Art 27 per-execution capture. Called by the router alongside the
    ///         fill. `settlementCertaintyBps` is the limb with no conventional-venue
    ///         analogue: on-chain it degrades with reorg risk, gas spikes and oracle health,
    ///         and the execution policy has to name those three as failure modes explicitly.
    ///         A generic best-execution policy will not have them.
    function captureBestExecution(
        bytes32 orderId,
        uint256 priceWei,
        uint256 costWei,
        uint32 speedMillis,
        uint16 likelihoodBps,
        uint16 settlementCertaintyBps
    ) external {
        if (msg.sender != router) revert NotRouter();
        emit BestExecutionCaptured(orderId, priceWei, costWei, speedMillis, likelihoodBps, settlementCertaintyBps);
    }

    // ═══════════════════════════════════════════════════════════════════════

    function quoteOf(bytes32 instrumentId) external view returns (Quote memory) {
        return _quotes[instrumentId];
    }
}
