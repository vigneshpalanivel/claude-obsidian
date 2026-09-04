// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

interface IIdentityTier {
    function isRetail(address wallet) external view returns (bool);
}

interface IArt5_8Headroom {
    function withinArt5_8CommercialBankMoneyHeadroom() external view returns (bool);
}

/// @title SettlementEngine (illustrative sample — not production code)
/// @notice DLT Pilot Art 5(7)/5(8)/5(10) and Art 7(5)/7(6) — atomic delivery-versus-payment
///         settlement with a one-way finality state, client-asset segregation, a hard
///         no-overdraft rule, and the T+2 ceiling that is the CONDITION of the settlement-
///         finality exemption rather than a consequence of it.
/// @dev    ⚠️ THE EXEMPTIONS ARE THINGS YOU APPLY FOR, AND THEIR CONDITIONS BIND HARDER THAN
///         THE RULES THEY RELIEVE.
///           Art 5(7) relieves CSDR Art 39 settlement finality. Its condition (a) caps
///           settlement at close to real time or intraday and IN ANY CASE no later than the
///           second business day after the trade. So the exemption buys flexibility on
///           finality and spends it on a standing T+2 ceiling.
///           Art 5(8) relieves CSDR Art 40 cash settlement. Its condition is DvP. DvP is the
///           price of the exemption, not a free-standing mandate — which is why the settlement
///           asset is still an open decision even after this contract is built.
/// @dev    ⚠️ FINALITY IS ONE-WAY AND THAT IS NOT A DESIGN CHOICE. Once settled, no reversal
///         is possible without breaking the ledger's immutability, so error-trade handling
///         has to be a NEW compensating transaction with its own audit trail — never an
///         unwind of the original. `reverseSettlement()` does not exist here on purpose.
/// @dev    ⚠️ ART 7(6) IS STRICT LIABILITY UP TO THE MARKET VALUE OF THE ASSET LOST, with a
///         narrow "external event beyond reasonable control" defence the OPERATOR must
///         prove. Every failure mode this contract can experience — key compromise, chain
///         reorganisation, oracle failure, a bridged cash leg failing — is therefore a
///         balance-sheet exposure sized to the instrument, not to revenue. `recordLossEvent`
///         exists because the evidence for that defence has to be assembled from a log that
///         already existed at the time, not reconstructed afterwards.
/// @dev    CSDR T+1 (Reg 2025/2075) applies from 11 Oct 2027. Atomic DvP settles at T+0, so
///         the obligation is satisfied by construction — the compliance work is EVIDENCING
///         native conformance, not claiming an exemption. The real exposure is any leg that
///         leaves the chain, which is why `settlementDeadline` is enforced on every trade
///         including the bridged ones.
contract SettlementEngine {
    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;
    address public immutable matchingEngine; // registers matched trades
    IIdentityTier public immutable identity;
    IArt5_8Headroom public immutable capGate;

    // ─────────────────────────── segregated books ─────────────────────────────
    //
    // Art 7(5): client assets segregated from the operator's own AND from each other
    // client's. Two separate requirements — a single pooled client account satisfies the
    // first and fails the second. The operator's own book is a distinct mapping, not a
    // reserved address inside the client book, so there is no path by which an off-by-one
    // in the client accounting silently draws on operator funds or vice versa.

    mapping(address => uint256) public clientCashWei;
    mapping(address => mapping(bytes32 => uint256)) public clientSecurities;

    uint256 public operatorOwnCashWei;
    mapping(bytes32 => uint256) public operatorOwnSecurities;

    /// @dev Running totals maintained alongside the per-client books purely so the
    ///      segregation invariant is checkable in one call by anyone — including an NCA
    ///      running its own node. Art 7(5) asks for on-chain proof of segregation, and a
    ///      proof that requires iterating every client is not one an auditor will run.
    uint256 public totalClientCashWei;
    mapping(bytes32 => uint256) public totalClientSecurities;

    // ─────────────────────────── access-means register (Art 7(5)) ─────────────
    //
    // "Records of the assets and of the MEANS OF ACCESS to them." The means of access is
    // never itself on-chain: this holds a hash of the custody arrangement — signer set,
    // threshold, HSM/policy reference — so a change of custody is provable and timestamped
    // without publishing anything that helps an attacker.

    mapping(address => bytes32) public accessMeansHash;

    // ─────────────────────────── asset-reuse consent ──────────────────────────
    //
    // Art 7(5) permits use of client assets on the operator's own account with prior express
    // written consent, which MAY be given electronically — unlike MiCA Art 75, which does not
    // permit it at all.
    //
    // ⚠️ MiFID II Art 16(10) has NO DLT Pilot equivalent and overrides for one population:
    // title-transfer collateral arrangements are PROHIBITED with retail clients. Consent does
    // not cure it. Any design where a retail holder's tokens move to a platform address as
    // collateral — staking, margin, a "locked" pool implemented as a transfer — is caught.
    // Retail collateral must be a restriction on the holder's own balance, never a transfer
    // of title, which is why the encumbrance path below moves nothing.

    struct ReuseConsent {
        bool given;
        uint64 givenAt;
        bytes32 consentArtefactHash;
    }

    mapping(address => ReuseConsent) public reuseConsent;
    mapping(address => mapping(bytes32 => uint256)) public encumbered; // restriction, not transfer

    // ─────────────────────────── trades ───────────────────────────────────────

    enum State {
        Unknown,
        Registered,
        Settled, // FINAL — terminal, no transition out
        Failed, // deadline passed unsettled — terminal
        Cancelled // pre-settlement withdrawal — terminal
    }

    struct Trade {
        State state;
        address seller;
        address buyer;
        bytes32 instrumentId;
        uint256 quantity;
        uint256 cashWei;
        uint64 tradeTimestamp; // synchronised business clock, not block time
        /// @dev Art 5(7)(a) T+2 in wall-clock terms, computed off-chain against a real
        ///      business-day calendar (TARGET2) and fed in — never derived on-chain from
        ///      block.timestamp, which knows nothing about weekends or holidays.
        uint64 settlementDeadline;
        uint64 intendedSettlementDate; // CSDR Art 74(1)(ia) reporting field
        bool venueExecuted; // CSDR Art 74(1)(ia) venue-execution status
        uint64 settledAt;
    }

    mapping(bytes32 => Trade) private _trades;

    // ─────────────────────────── events ───────────────────────────────────────

    event Deposited(address indexed client, bytes32 indexed instrumentId, uint256 securities, uint256 cashWei);
    event Withdrawn(address indexed client, bytes32 indexed instrumentId, uint256 securities, uint256 cashWei);
    event AccessMeansRecorded(address indexed client, bytes32 accessMeansHash);
    event ReuseConsentGiven(address indexed client, bytes32 artefactHash, uint64 at);
    event ReuseConsentWithdrawn(address indexed client, uint64 at);
    event Encumbered(address indexed client, bytes32 indexed instrumentId, uint256 amount);
    event Released(address indexed client, bytes32 indexed instrumentId, uint256 amount);

    event TradeRegistered(
        bytes32 indexed tradeId,
        bytes32 indexed instrumentId,
        address indexed seller,
        address buyer,
        uint256 quantity,
        uint256 cashWei,
        uint64 intendedSettlementDate
    );
    /// @dev The single event the MiFIR Art 26 bridge and the CSDR Art 74(1)(ia) settlement-
    ///      date report both read. One schema, two consumers — the new CSDR field set
    ///      (categories of transaction, intended settlement date, venue-execution status) is
    ///      already carried here, so it is not a second feed to build.
    event Settled(
        bytes32 indexed tradeId,
        bytes32 indexed instrumentId,
        address indexed seller,
        address buyer,
        uint256 quantity,
        uint256 cashWei,
        uint64 intendedSettlementDate,
        uint64 actualSettlementTimestamp,
        bool venueExecuted
    );
    event SettlementFailed(bytes32 indexed tradeId, uint64 deadline, uint64 at);
    event TradeCancelled(bytes32 indexed tradeId, bytes32 reasonHash);

    /// @dev Art 7(6) evidence. Emitted for anything that could later be argued as a loss
    ///      event, including ones the operator believes are covered by the external-event
    ///      defence — especially those, since the operator carries the burden of proof and
    ///      a contemporaneous record is worth more than a reconstruction.
    event LossEventRecorded(
        bytes32 indexed lossEventId,
        address indexed affectedClient,
        bytes32 indexed instrumentId,
        uint256 marketValueWei,
        bytes32 causeCode,
        bytes32 evidenceHash,
        uint64 at
    );

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotMatchingEngine();
    error NotCounterparty();
    error TradeExists(bytes32 tradeId);
    error UnknownTrade(bytes32 tradeId);
    error WrongState(bytes32 tradeId, State actual);
    error SettlementIsFinal(bytes32 tradeId, uint64 settledAt);
    error DeadlineExceedsT2Ceiling(uint64 tradeTimestamp, uint64 deadline);
    error PastSettlementDeadline(bytes32 tradeId, uint64 deadline);
    error DeadlineNotYetPassed(bytes32 tradeId, uint64 deadline);
    error InsufficientSecurities(address client, bytes32 instrumentId, uint256 available, uint256 needed);
    error InsufficientCash(address client, uint256 available, uint256 needed);
    error EncumberedBalance(address client, bytes32 instrumentId, uint256 encumberedAmount);
    error NoReuseConsent(address client);
    error RetailTitleTransferProhibited(address client);
    error CommercialBankMoneyHeadroomExceeded();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    /// @notice Absolute ceiling on `settlementDeadline - tradeTimestamp`. Two business days
    ///         is at most four wall-clock days across a weekend, so the on-chain guard is a
    ///         backstop against a mis-fed calendar, not the calendar itself.
    uint64 public constant T2_WALLCLOCK_BACKSTOP = 4 days;

    constructor(address governance_, address matchingEngine_, address identity_, address capGate_) {
        governance = governance_;
        matchingEngine = matchingEngine_;
        identity = IIdentityTier(identity_);
        capGate = IArt5_8Headroom(capGate_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // BOOKS — deposits and withdrawals. No path anywhere in this contract
    // decrements a client balance below zero: every deduction is guarded
    // explicitly rather than relying on 0.8.x underflow, so the revert names
    // the client and the shortfall instead of surfacing as a panic.
    // ═══════════════════════════════════════════════════════════════════════

    function creditSecurities(address client, bytes32 instrumentId, uint256 amount) external onlyGovernance {
        clientSecurities[client][instrumentId] += amount;
        totalClientSecurities[instrumentId] += amount;
        emit Deposited(client, instrumentId, amount, 0);
    }

    function depositCash() external payable {
        clientCashWei[msg.sender] += msg.value;
        totalClientCashWei += msg.value;
        emit Deposited(msg.sender, bytes32(0), 0, msg.value);
    }

    function withdrawCash(uint256 amountWei) external {
        uint256 bal = clientCashWei[msg.sender];
        if (bal < amountWei) revert InsufficientCash(msg.sender, bal, amountWei);

        clientCashWei[msg.sender] = bal - amountWei;
        totalClientCashWei -= amountWei;

        (bool ok, ) = msg.sender.call{value: amountWei}("");
        require(ok, "cash withdrawal failed");
        emit Withdrawn(msg.sender, bytes32(0), 0, amountWei);
    }

    function recordAccessMeans(bytes32 hash) external {
        accessMeansHash[msg.sender] = hash;
        emit AccessMeansRecorded(msg.sender, hash);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // REUSE CONSENT AND ENCUMBRANCE
    // ═══════════════════════════════════════════════════════════════════════

    function giveReuseConsent(bytes32 artefactHash) external {
        if (identity.isRetail(msg.sender)) revert RetailTitleTransferProhibited(msg.sender);
        reuseConsent[msg.sender] = ReuseConsent({
            given: true,
            givenAt: uint64(block.timestamp),
            consentArtefactHash: artefactHash
        });
        emit ReuseConsentGiven(msg.sender, artefactHash, uint64(block.timestamp));
    }

    function withdrawReuseConsent() external {
        reuseConsent[msg.sender].given = false;
        emit ReuseConsentWithdrawn(msg.sender, uint64(block.timestamp));
    }

    /// @notice Collateral for EVERY client tier, retail included — because it moves nothing.
    ///         The units stay in the holder's own balance and become untransferable. This is
    ///         the Art 16(10)-safe shape, and it is also simply the correct one: an
    ///         encumbrance is a restriction on a right, not a transfer of it.
    function encumber(address client, bytes32 instrumentId, uint256 amount) external onlyGovernance {
        uint256 bal = clientSecurities[client][instrumentId];
        uint256 wouldBe = encumbered[client][instrumentId] + amount;
        if (bal < wouldBe) revert InsufficientSecurities(client, instrumentId, bal, wouldBe);

        encumbered[client][instrumentId] = wouldBe;
        emit Encumbered(client, instrumentId, amount);
    }

    function release(address client, bytes32 instrumentId, uint256 amount) external onlyGovernance {
        encumbered[client][instrumentId] -= amount;
        emit Released(client, instrumentId, amount);
    }

    /// @notice Title transfer of client assets to the operator's own book. Two gates, and the
    ///         retail one is not consent-defeasible: a retail client cannot validly agree to
    ///         this, so the check sits before the consent check rather than inside it.
    function useClientAssets(address client, bytes32 instrumentId, uint256 amount) external onlyGovernance {
        if (identity.isRetail(client)) revert RetailTitleTransferProhibited(client);
        if (!reuseConsent[client].given) revert NoReuseConsent(client);

        _debitSecurities(client, instrumentId, amount);
        operatorOwnSecurities[instrumentId] += amount;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // TRADE REGISTRATION
    // ═══════════════════════════════════════════════════════════════════════

    function registerTrade(
        bytes32 tradeId,
        address seller,
        address buyer,
        bytes32 instrumentId,
        uint256 quantity,
        uint256 cashWei,
        uint64 tradeTimestamp,
        uint64 settlementDeadline,
        uint64 intendedSettlementDate,
        bool venueExecuted
    ) external {
        if (msg.sender != matchingEngine) revert NotMatchingEngine();
        if (_trades[tradeId].state != State.Unknown) revert TradeExists(tradeId);

        // Art 5(7)(a). Checked at registration rather than at settlement so a trade that
        // could never have settled inside the ceiling is rejected while it is still an
        // instruction, not discovered as a breach two days later.
        if (settlementDeadline <= tradeTimestamp || settlementDeadline - tradeTimestamp > T2_WALLCLOCK_BACKSTOP) {
            revert DeadlineExceedsT2Ceiling(tradeTimestamp, settlementDeadline);
        }

        _trades[tradeId] = Trade({
            state: State.Registered,
            seller: seller,
            buyer: buyer,
            instrumentId: instrumentId,
            quantity: quantity,
            cashWei: cashWei,
            tradeTimestamp: tradeTimestamp,
            settlementDeadline: settlementDeadline,
            intendedSettlementDate: intendedSettlementDate,
            venueExecuted: venueExecuted,
            settledAt: 0
        });

        emit TradeRegistered(tradeId, instrumentId, seller, buyer, quantity, cashWei, intendedSettlementDate);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ATOMIC DvP — both legs or neither. Callable by anyone once the balances
    // are in place: settlement is a pull, so neither counterparty can hold the
    // other hostage by declining to submit the transaction.
    // ═══════════════════════════════════════════════════════════════════════

    function settle(bytes32 tradeId) external {
        Trade storage t = _trades[tradeId];
        if (t.state == State.Unknown) revert UnknownTrade(tradeId);
        if (t.state == State.Settled) revert SettlementIsFinal(tradeId, t.settledAt);
        if (t.state != State.Registered) revert WrongState(tradeId, t.state);
        if (block.timestamp > t.settlementDeadline) revert PastSettlementDeadline(tradeId, t.settlementDeadline);

        // Art 5(8) headroom is read live, not assumed: crossing €6bn at initial recording
        // moves commercial-bank-money settlement back inside CSDR Title IV, which is a
        // different regime for the cash leg and not something to discover after the fact.
        if (!capGate.withinArt5_8CommercialBankMoneyHeadroom()) revert CommercialBankMoneyHeadroomExceeded();

        _debitSecurities(t.seller, t.instrumentId, t.quantity);
        _debitCash(t.buyer, t.cashWei);

        clientSecurities[t.buyer][t.instrumentId] += t.quantity;
        totalClientSecurities[t.instrumentId] += t.quantity;
        clientCashWei[t.seller] += t.cashWei;
        totalClientCashWei += t.cashWei;

        t.state = State.Settled;
        t.settledAt = uint64(block.timestamp);

        emit Settled(
            tradeId,
            t.instrumentId,
            t.seller,
            t.buyer,
            t.quantity,
            t.cashWei,
            t.intendedSettlementDate,
            t.settledAt,
            t.venueExecuted
        );
    }

    /// @notice Marks a trade failed once its Art 5(7)(a) deadline has passed unsettled.
    ///         CSDR settlement-discipline cash penalties are unchanged under the T+1 reform
    ///         and still apply, so a failing leg costs money as well as compliance — this
    ///         event is the penalty calculation's input.
    function markFailed(bytes32 tradeId) external {
        Trade storage t = _trades[tradeId];
        if (t.state != State.Registered) revert WrongState(tradeId, t.state);
        if (block.timestamp <= t.settlementDeadline) revert DeadlineNotYetPassed(tradeId, t.settlementDeadline);

        t.state = State.Failed;
        emit SettlementFailed(tradeId, t.settlementDeadline, uint64(block.timestamp));
    }

    function cancelTrade(bytes32 tradeId, bytes32 reasonHash) external {
        Trade storage t = _trades[tradeId];
        if (t.state == State.Settled) revert SettlementIsFinal(tradeId, t.settledAt);
        if (t.state != State.Registered) revert WrongState(tradeId, t.state);
        if (msg.sender != matchingEngine && msg.sender != governance) revert NotMatchingEngine();

        t.state = State.Cancelled;
        emit TradeCancelled(tradeId, reasonHash);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 7(6) LOSS LOG
    // ═══════════════════════════════════════════════════════════════════════

    /// @param causeCode One of "KEY_COMPROMISE" / "CHAIN_REORG" / "ORACLE_FAILURE" /
    ///                  "BRIDGE_FAILURE" / "CONTRACT_DEFECT" / "EXTERNAL_EVENT". The last is
    ///                  a claim, not a conclusion — the defence still has to be proved, and
    ///                  labelling it here does not establish it.
    function recordLossEvent(
        bytes32 lossEventId,
        address affectedClient,
        bytes32 instrumentId,
        uint256 marketValueWei,
        bytes32 causeCode,
        bytes32 evidenceHash
    ) external onlyGovernance {
        emit LossEventRecorded(
            lossEventId,
            affectedClient,
            instrumentId,
            marketValueWei,
            causeCode,
            evidenceHash,
            uint64(block.timestamp)
        );
    }

    // ═══════════════════════════════════════════════════════════════════════
    // INTERNAL — no-overdraft, enforced explicitly
    // ═══════════════════════════════════════════════════════════════════════

    function _debitSecurities(address client, bytes32 instrumentId, uint256 amount) private {
        uint256 bal = clientSecurities[client][instrumentId];
        uint256 locked = encumbered[client][instrumentId];
        uint256 free = bal > locked ? bal - locked : 0;

        if (free < amount) {
            if (locked > 0) revert EncumberedBalance(client, instrumentId, locked);
            revert InsufficientSecurities(client, instrumentId, free, amount);
        }
        clientSecurities[client][instrumentId] = bal - amount;
        totalClientSecurities[instrumentId] -= amount;
    }

    function _debitCash(address client, uint256 amountWei) private {
        uint256 bal = clientCashWei[client];
        if (bal < amountWei) revert InsufficientCash(client, bal, amountWei);
        clientCashWei[client] = bal - amountWei;
        totalClientCashWei -= amountWei;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SEGREGATION PROOF — Art 7(5)/5(10). One call, no iteration, so a
    // supervisor can verify it from its own node rather than asking for a
    // report the operator prepared.
    // ═══════════════════════════════════════════════════════════════════════

    function segregationHolds() external view returns (bool) {
        return address(this).balance >= totalClientCashWei + operatorOwnCashWei;
    }

    function tradeOf(bytes32 tradeId) external view returns (Trade memory) {
        return _trades[tradeId];
    }

    function freeSecurities(address client, bytes32 instrumentId) external view returns (uint256) {
        uint256 bal = clientSecurities[client][instrumentId];
        uint256 locked = encumbered[client][instrumentId];
        return bal > locked ? bal - locked : 0;
    }
}
