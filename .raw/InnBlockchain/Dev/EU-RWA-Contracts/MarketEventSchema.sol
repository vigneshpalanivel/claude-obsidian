// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title MarketEventSchema (illustrative sample — not production code)
/// @notice The on-chain event schemas a DLT MTF or SI emits so that MiFIR transaction
///         reporting and MiFIR transparency can both be served from the ledger.
/// @dev    ⚠️ TWO SCHEMAS, NOT ONE. This is the single most commonly collapsed distinction
///         in tokenized-venue design, and collapsing it produces a venue that can report but
///         cannot publish:
///           • RTS 22 (Del. Reg 2017/590) — TRANSACTION REPORTING to the NCA under Art 26.
///             ~65 fields, T+1, private, includes counterparty identifiers.
///           • RTS 1 (Del. Reg 2017/587, equity) / RTS 2 (Del. Reg 2017/583, non-equity) —
///             TRANSPARENCY publication to the market under Arts 3/6/8/10. Different field
///             set, public, no counterparty identifiers, and carrying TRADE FLAGS that have
///             no RTS 22 equivalent at all.
///         Transparency is not a view over the reporting event. Build both, field-complete,
///         on day one.
/// @dev    The RTS 1/RTS 2 order-lifecycle events are ALSO the event set MAR Art 8(1)
///         surveillance needs (§6 of the design doc). Build once, feed both — but do not
///         assume a settlement-only indexer covers either: settlement events carry no order
///         lifecycle, and market abuse lives in the orders that never executed.
/// @dev    ⚠️ THE DEFERRAL FLAG IS PRESENT FOR FIELD COMPLETENESS AND IS STRUCTURALLY
///         UNENFORCEABLE ON A TRANSPARENT LEDGER. MiFIR Arts 7 and 11 let a venue delay
///         publishing large-in-scale, above-SSTI, illiquid and sovereign trades. On an open
///         chain the trade is visible at settlement regardless of what this flag says, so a
///         deferral you cannot enforce is a deferral you do not have. That is a commercial
///         exclusion — institutional size will trade elsewhere — rather than a compliance
///         failure, and it is one of the reasons the chain choice is constrained.
/// @dev    GDPR: no natural-person identifier appears in any event below — in the clear OR
///         as a hash. `TradeReportable` carries the buyer and seller as WALLETS; the reporting
///         bridge resolves LEI or salted NCI hash off-chain from `IdentityRegistry.investor()`
///         at the block the trade landed, and that read goes empty after erasure.
///         ⚠️ This schema used to declare `buyerNciHash` / `sellerNciHash` slots while saying
///         in this very comment that the bridge resolves them off-chain — and the one emitter,
///         `SiQuoteEngine`, zeroed all four identity fields for exactly that reason. A schema
///         that declares a slot its implementation refuses to fill is an invitation to the
///         next implementation to fill it. The slots are gone. A salted hash is still a
///         stable per-person identifier that erasure is supposed to orphan; a log is the one
///         place it cannot be orphaned from. See §10 of the design document, event-payload
///         rule.
interface IMarketEventSchema {
    // ─────────────────────────── shared enums ─────────────────────────────────

    /// @dev RTS 22 field 29. Determines whose report the trade appears on and on what basis.
    enum TradingCapacity {
        Unset,
        DealingOnOwnAccount, // DEAL
        MatchedPrincipal, // MTCH
        AnyOtherCapacity // AOTC
    }

    enum Side {
        Buy,
        Sell
    }

    enum OrderType {
        Limit,
        Market,
        Quote, // SI firm quote — MiFIR Arts 14–20
        Rfq
    }

    /// @dev RTS 1/RTS 2 post-trade flags. No RTS 22 equivalent exists for any of these,
    ///      which is the concrete reason the two schemas cannot share one event.
    struct TradeFlags {
        bool benchmark; // BENC
        bool negotiated; // NLIQ / OILQ
        bool portfolio; // PORT
        bool largeInScale; // LRGS
        bool deferred; // ⚠️ see contract-level note — unenforceable on a transparent chain
        bool cancelled; // CANC
        bool amended; // AMND
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SCHEMA A — RTS 1 / RTS 2 TRANSPARENCY. Published by the APA or DPE
    // bridge. Also the MAR Art 8(1) surveillance feed.
    //
    // Pre-trade publication must be on a CONTINUOUS basis; post-trade AS CLOSE
    // TO REAL TIME AS TECHNICALLY POSSIBLE. Block time and finality lag are
    // therefore compliance inputs to the chain decision, to be justified in
    // writing — not performance preferences.
    // ═══════════════════════════════════════════════════════════════════════

    event OrderCreated(
        bytes32 indexed orderId,
        bytes32 indexed instrumentId,
        Side side,
        OrderType orderType,
        uint256 priceWei,
        uint256 quantity,
        uint64 syncedTimestamp,
        bytes32 participantRef
    );

    event OrderModified(
        bytes32 indexed orderId,
        bytes32 indexed instrumentId,
        uint256 newPriceWei,
        uint256 newQuantity,
        uint64 syncedTimestamp
    );

    event OrderCancelled(bytes32 indexed orderId, bytes32 indexed instrumentId, uint64 syncedTimestamp);

    /// @dev Deliberately carries NO counterparty identity. Transparency data is public; the
    ///      counterparties are not. Putting an LEI in here to save building the second schema
    ///      publishes trading intent the transparency regime never asked you to disclose.
    event TradePublished(
        bytes32 indexed tradeId,
        bytes32 indexed instrumentId,
        uint256 priceWei,
        uint256 quantity,
        uint64 syncedTimestamp,
        TradeFlags flags
    );

    // ═══════════════════════════════════════════════════════════════════════
    // SCHEMA B — RTS 22 TRANSACTION REPORTING. Consumed by the ARM bridge for
    // MiFIR Art 26 at T+1.
    //
    // ⚠️ EMIT THIS EVEN IF YOU TAKE THE EXEMPTION. DLT Pilot Art 4(3) can
    // exempt a DLT MTF from Art 26 — but its condition is that the venue keeps
    // records containing all the Art 26(3) details. The exemption removes the
    // DELIVERY, not the RECORD. Field completeness is unchanged either way;
    // what changes is whether a bridge transmits or an archive retains.
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev `buyer` / `seller` are the counterparty wallets — the join key, not the identity.
    ///      RTS 22 fields 7 and 16 (buyer / seller identification code: LEI, or NCI for a
    ///      natural person) are populated by the bridge from `IdentityRegistry.investor()`,
    ///      never carried here. "Field-complete" means every RTS 22 field is *derivable* from
    ///      this event plus a storage read at the same block, not that every field is in it.
    event TradeReportable(
        bytes32 indexed tradeId,
        bytes32 indexed instrumentIsin,
        bytes32 indexed venueMic,
        address buyer,
        address seller,
        uint256 priceWei,
        uint256 quantity,
        TradingCapacity capacity,
        uint64 syncedTimestamp
    );

    /// @dev RTS 22 requires the investment decision maker and the execution decision maker
    ///      as separate fields from the client. Emitted alongside rather than inside
    ///      `TradeReportable` because most trades do not have them and a 15-field event
    ///      emitted 100% of the time to serve 5% of cases is pure gas.
    /// @dev ⚠️ The three refs are OPERATOR-MINTED OPAQUE HANDLES into the firm's own order
    ///      management records — never an NCI hash, never a `personId`. RTS 22 fields 57–59
    ///      identify natural persons (the decision-making trader, the executing trader) by
    ///      national identifier; the bridge resolves those from the ref against the firm's
    ///      staff register, off-chain. A ref that *is* the identifier would put a named
    ///      employee's every trading decision in a permanent public log.
    event TradeDecisionMakers(
        bytes32 indexed tradeId,
        bytes32 investmentDecisionRef,
        bytes32 executionDecisionRef,
        bytes32 clientRef
    );
}

/// @title MifirClock (illustrative sample — not production code)
/// @notice Business-clock synchronisation. MiFID II already imposed it on trading venues and
///         their members; MiFIR Art 22c is what NEWLY extended it to SIs, DPEs, APAs and
///         CTPs, so a dealer-lane build cites Art 22c and a venue-lane build cites MiFID II.
/// @dev    ⚠️ `block.timestamp` IS NOT A SYNCHRONISED BUSINESS CLOCK. It is a value a
///         proposer chooses within a tolerance, on a chain whose block cadence has nothing
///         to do with UTC traceability, and it is not accurate to the ESMA RTS granularity.
///         Every timestamp in the schemas above is therefore `syncedTimestamp`, fed from the
///         firm's own traceable clock. This contract's only job is to stop a broken or
///         manipulated feed from writing a timestamp that is obviously wrong: it bounds the
///         divergence from block time, which catches gross failure without pretending to
///         verify UTC traceability on-chain — that verification is an off-chain control and
///         an audit item, not something a contract can do.
abstract contract MifirClock {
    uint64 public maxClockDivergenceSeconds = 60;

    event ClockDivergenceLimitSet(uint64 seconds_);

    error ClockDivergenceTooLarge(uint64 syncedTimestamp, uint64 blockTimestamp, uint64 limit);

    function _requireSyncedClock(uint64 syncedTimestamp) internal view {
        uint64 nowTs = uint64(block.timestamp);
        uint64 delta = syncedTimestamp > nowTs ? syncedTimestamp - nowTs : nowTs - syncedTimestamp;
        if (delta > maxClockDivergenceSeconds) {
            revert ClockDivergenceTooLarge(syncedTimestamp, nowTs, maxClockDivergenceSeconds);
        }
    }

    function _setClockDivergenceLimit(uint64 seconds_) internal {
        maxClockDivergenceSeconds = seconds_;
        emit ClockDivergenceLimitSet(seconds_);
    }
}
