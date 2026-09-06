// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ModularCompliance} from "./ModularCompliance.sol";
import {IdentityRegistry} from "./IdentityRegistry.sol";

/// @title DistributionAgent (illustrative sample — not production code)
/// @notice C1 + C2 — pays holders. Dividends, rental income, revenue share, and the cash leg
///         of `CouponSchedule` and `DistributionWaterfall`, both of which route through here
///         rather than paying anyone themselves.
/// @dev    ⚠️ A DISTRIBUTION IS AN IDENTITY-GATED TRANSFER, NOT A PAYMENT. It runs the same
///         eligibility check as an ordinary token movement, or it is a freeze bypass: a wallet
///         that cannot receive a single unit must not be able to receive the income those
///         units produce. This is the reason the contract exists as a separate, gated agent
///         instead of the issuer sending a batch payment from a treasury wallet.
/// @dev    ⚠️ AMLR Art 76 REACHES THE PAYOUT PATH. Nothing here may disclose WHY a holder was
///         not paid. `EntitlementUnclaimed` fires identically for a frozen wallet, an expired
///         CDD record, a reverting recipient contract and a failed push — one event, four
///         causes, no reason code. That indistinguishability IS the control; an "excluded
///         from dividend" event that only ever fires for compliance reasons is a tipping-off
///         disclosure with extra steps.
/// @dev    ⚠️ NO CLIENT MONEY RESTS HERE. § Scope keeps the platform out of the payment chain:
///         the issuer funds a distribution, the contract pushes it out, and between those two
///         acts the balance is committed to identified holders rather than held on the
///         operator's own account. Same posture as `SubscriptionEscrow` on the way in. An
///         operator that lets pools sit indefinitely is running a client-money business and
///         needs the authorisation that goes with it.
contract DistributionAgent {
    // ═══════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════

    enum State {
        None,
        /// @dev Record block fixed, snapshot not yet taken. The only state in which the record
        ///      block is still in the future — which is the point of it.
        Declared,
        /// @dev Snapshot root anchored. Entitlements are now determined and immutable.
        Snapshotted,
        /// @dev Fully funded and paying.
        Open,
        /// @dev Closed to new payouts; unclaimed balances may be swept.
        Closed
    }

    struct Distribution {
        State state;
        /// @dev ⚠️ FIXED IN ADVANCE, ALWAYS IN THE FUTURE AT DECLARATION. Entitlement is
        ///      computed on balances at a block the contract committed to BEFORE anyone knew
        ///      the snapshot was coming. Choosing the record block after the fact — or
        ///      computing on balances at payment time — lets a transfer between record date
        ///      and payment date silently redirect the money.
        uint64 recordBlock;
        /// @dev Merkle root over (holder, units) at `recordBlock`.
        bytes32 snapshotRoot;
        /// @dev Units in the snapshot. Determines the pool that must be funded in full.
        uint256 totalUnits;
        /// @dev Wei per smallest token unit. Deliberately a per-unit rate rather than a total
        ///      to be divided: multiplication cannot strand a remainder, division can.
        uint256 ratePerUnit;
        uint256 funded;
        uint256 paidOut;
        uint256 unclaimed;
        /// @dev AIFMD Art 23(1) — the fee must be DISCLOSED in a document. What is on-chain is
        ///      evidence it was actually charged at the rate disclosed, which is a different
        ///      and complementary thing.
        uint16 feeBps;
        /// @dev Withholding at source where the issuing jurisdiction requires it. Tax sits
        ///      outside the compliance library; the rate is fed in, the deduction is evidenced.
        uint16 withholdingBps;
        /// @dev After this, `sweepUnclaimed` becomes available. 0 = never sweeps.
        uint64 claimDeadline;
        /// @dev See `_gate`. Off by default, and the NatSpec explains why that default is not
        ///      laziness.
        bool runComplianceModules;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ROLES & WIRING
    // ═══════════════════════════════════════════════════════════════════════

    address public immutable governance;

    /// @notice The issuer or AIFM. Declares distributions, anchors snapshots, funds pools.
    mapping(address => bool) public isAgent;

    IdentityRegistry public immutable identity;
    ModularCompliance public immutable compliance;

    /// @notice Where deducted fees and withheld tax go. Separate addresses because they are
    ///         owed to entirely different parties, and netting them into one recipient
    ///         destroys the evidence that either was correctly calculated.
    address public feeRecipient;
    address public taxRecipient;

    // ═══════════════════════════════════════════════════════════════════════
    // STATE
    // ═══════════════════════════════════════════════════════════════════════

    uint256 public nextDistributionId = 1;
    mapping(uint256 => Distribution) private _distributions;

    /// @dev Paid, or moved to unclaimed. Either way this holder is done for this distribution.
    mapping(uint256 => mapping(address => bool)) public settled;

    /// @dev Withheld entitlements, claimable later by the holder once whatever blocked them is
    ///      resolved. ⚠️ A payout that cannot be pushed is not extinguished — the issuer still
    ///      owes it. Modelling it explicitly is the difference between a liability with a name
    ///      on it and value stranded in a contract nobody will admit is theirs.
    mapping(uint256 => mapping(address => uint256)) public unclaimedOf;

    uint16 public constant MAX_BPS = 10_000;

    /// @dev Simple reentrancy guard. The push path calls out to arbitrary recipient addresses,
    ///      any of which may be a contract with a fallback.
    uint256 private _locked = 1;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS
    // ═══════════════════════════════════════════════════════════════════════

    event AgentSet(address indexed agent, bool allowed);
    event RecipientsSet(address feeRecipient, address taxRecipient);

    event DistributionDeclared(uint256 indexed id, uint64 recordBlock, uint256 ratePerUnit, uint16 feeBps);
    event SnapshotAnchored(uint256 indexed id, bytes32 snapshotRoot, uint256 totalUnits, uint256 grossRequired);
    event DistributionFunded(uint256 indexed id, uint256 amount, uint256 fundedTotal);
    event DistributionOpened(uint256 indexed id, uint256 grossRequired);
    event DistributionClosed(uint256 indexed id, uint256 paidOut, uint256 unclaimed);

    event EntitlementPaid(uint256 indexed id, address indexed holder, uint256 gross, uint256 fee, uint256 withheld);

    /// @notice ⚠️ ONE EVENT, EVERY CAUSE, NO REASON. See the AMLR Art 76 note on the contract.
    event EntitlementUnclaimed(uint256 indexed id, address indexed holder, uint256 amount);
    event UnclaimedRedeemed(uint256 indexed id, address indexed holder, uint256 amount);
    event UnclaimedSwept(uint256 indexed id, uint256 amount, address to);

    // ═══════════════════════════════════════════════════════════════════════
    // ERRORS
    // ═══════════════════════════════════════════════════════════════════════

    error NotGovernance();
    error NotAgent();
    error Reentrancy();
    error UnknownDistribution(uint256 id);
    error WrongState(uint256 id, State expected, State actual);
    error RecordBlockMustBeFuture(uint64 recordBlock);
    error RecordBlockNotReached(uint256 id, uint64 recordBlock);
    error ZeroRate();
    error ZeroUnits();
    error BpsOutOfRange(uint16 bps);
    error PoolNotFullyFunded(uint256 id, uint256 funded, uint256 required);
    error AlreadySettled(uint256 id, address holder);
    error BadProof(uint256 id, address holder);
    error NothingUnclaimed(uint256 id, address holder);
    error ClaimDeadlineNotPassed(uint256 id, uint64 deadline);
    error NoSweepConfigured(uint256 id);
    error PayoutFailed(address to, uint256 amount);
    error RecipientsNotSet();

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

    constructor(address governance_, address identity_, address compliance_) {
        governance = governance_;
        identity = IdentityRegistry(identity_);
        compliance = ModularCompliance(compliance_);
    }

    function setAgent(address agent, bool allowed) external onlyGovernance {
        isAgent[agent] = allowed;
        emit AgentSet(agent, allowed);
    }

    function setRecipients(address feeRecipient_, address taxRecipient_) external onlyGovernance {
        feeRecipient = feeRecipient_;
        taxRecipient = taxRecipient_;
        emit RecipientsSet(feeRecipient_, taxRecipient_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // LIFECYCLE
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Step 1. Commits to a record block before that block exists.
    /// @dev    ⚠️ `recordBlock` MUST BE IN THE FUTURE, and that check is the tamper-evidence.
    ///         An agent who can name a past block can look at the register, see who holds
    ///         what, and pick the block that suits. The rule is cheap here and unrecoverable
    ///         later.
    function declareDistribution(
        uint64 recordBlock,
        uint256 ratePerUnit,
        uint16 feeBps,
        uint16 withholdingBps,
        uint64 claimDeadline,
        bool runComplianceModules
    ) external onlyAgent returns (uint256 id) {
        if (recordBlock <= block.number) revert RecordBlockMustBeFuture(recordBlock);
        if (ratePerUnit == 0) revert ZeroRate();
        if (feeBps > MAX_BPS) revert BpsOutOfRange(feeBps);
        if (withholdingBps > MAX_BPS) revert BpsOutOfRange(withholdingBps);
        if (uint256(feeBps) + uint256(withholdingBps) > MAX_BPS) revert BpsOutOfRange(feeBps + withholdingBps);
        if (feeRecipient == address(0) || taxRecipient == address(0)) revert RecipientsNotSet();

        id = nextDistributionId++;
        Distribution storage d = _distributions[id];
        d.state = State.Declared;
        d.recordBlock = recordBlock;
        d.ratePerUnit = ratePerUnit;
        d.feeBps = feeBps;
        d.withholdingBps = withholdingBps;
        d.claimDeadline = claimDeadline;
        d.runComplianceModules = runComplianceModules;

        emit DistributionDeclared(id, recordBlock, ratePerUnit, feeBps);
    }

    /// @notice Step 2. Anchors the holder set as it stood at the record block.
    /// @dev    ⚠️ WHY A MERKLE ROOT AND NOT AN ON-CHAIN SNAPSHOT. Iterating every holder
    ///         on-chain is unbounded gas, and checkpointing balances inside the token makes
    ///         every ordinary transfer permanently more expensive to serve a function most
    ///         instruments use four times a year. The root is the compromise, and its
    ///         tamper-evidence is real but INDIRECT: the leaves are derived from public chain
    ///         state at a block fixed in advance, so any holder, auditor or NCA can recompute
    ///         the root independently and prove a mismatch. ⚠️ What it does NOT do is prevent
    ///         a wrong root being anchored in the first place. That is caught by
    ///         reconciliation, not by this contract — and an operator who does not actually
    ///         run that reconciliation has an unverified number wearing a cryptographic
    ///         costume.
    function anchorSnapshot(uint256 id, bytes32 snapshotRoot, uint256 totalUnits) external onlyAgent {
        Distribution storage d = _requireState(id, State.Declared);
        if (block.number <= d.recordBlock) revert RecordBlockNotReached(id, d.recordBlock);
        if (totalUnits == 0) revert ZeroUnits();

        d.snapshotRoot = snapshotRoot;
        d.totalUnits = totalUnits;
        d.state = State.Snapshotted;

        emit SnapshotAnchored(id, snapshotRoot, totalUnits, totalUnits * d.ratePerUnit);
    }

    /// @notice Step 3. Fund the pool. May be called repeatedly until it covers the snapshot.
    function fund(uint256 id) external payable onlyAgent {
        Distribution storage d = _distributions[id];
        if (d.state != State.Snapshotted && d.state != State.Open) {
            revert WrongState(id, State.Snapshotted, d.state);
        }

        d.funded += msg.value;
        emit DistributionFunded(id, msg.value, d.funded);
    }

    /// @notice Step 4. Opens payouts.
    /// @dev    ⚠️ PARTIAL FUNDING IS REFUSED, NOT TOLERATED. A distribution that pays some of
    ///         the register and runs dry is a fair-treatment failure, and in a fund it is an
    ///         investor-treatment failure with a supervisory dimension. Either the pool covers
    ///         the snapshot gross in full, or the distribution does not open. Note the test is
    ///         against GROSS — fee and withholding are deducted from each holder's entitlement
    ///         and forwarded, not skimmed off the pool to make it stretch.
    function openDistribution(uint256 id) external onlyAgent {
        Distribution storage d = _requireState(id, State.Snapshotted);

        uint256 required = d.totalUnits * d.ratePerUnit;
        if (d.funded < required) revert PoolNotFullyFunded(id, d.funded, required);

        d.state = State.Open;
        emit DistributionOpened(id, required);
    }

    function closeDistribution(uint256 id) external onlyAgent {
        Distribution storage d = _requireState(id, State.Open);
        d.state = State.Closed;
        emit DistributionClosed(id, d.paidOut, d.unclaimed);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PAYOUT
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Pushes one holder's entitlement. Permissionless on purpose — anyone may pay
    ///         anyone, because the entitlement is fixed by the snapshot and the destination is
    ///         fixed by the proof. A push restricted to the agent makes the holder's income
    ///         dependent on the operator continuing to run a batch job.
    /// @param units The holder's balance at the record block, as it appears in the leaf.
    function distribute(uint256 id, address holder, uint256 units, bytes32[] calldata proof) public nonReentrant {
        Distribution storage d = _requireState(id, State.Open);
        if (settled[id][holder]) revert AlreadySettled(id, holder);

        bytes32 leaf = keccak256(abi.encodePacked(holder, units));
        if (!_verify(proof, d.snapshotRoot, leaf)) revert BadProof(id, holder);

        settled[id][holder] = true;

        uint256 gross = units * d.ratePerUnit;

        // ── the C1 gate ──────────────────────────────────────────────────
        if (!_gate(d, holder, units)) {
            d.unclaimed += gross;
            unclaimedOf[id][holder] = gross;
            emit EntitlementUnclaimed(id, holder, gross);
            return;
        }

        _settleTo(id, d, holder, gross);
    }

    /// @notice Batch form. Same rules, one transaction.
    function distributeMany(
        uint256 id,
        address[] calldata holders,
        uint256[] calldata units,
        bytes32[][] calldata proofs
    ) external {
        for (uint256 i = 0; i < holders.length; i++) {
            distribute(id, holders[i], units[i], proofs[i]);
        }
    }

    /// @notice ⚠️ THE EQUIVALENCE THIS CONTRACT TURNS ON: "may this wallet receive?" is asked
    ///         of the payout exactly as it is asked of a transfer.
    /// @dev    ⚠️ TWO LAYERS, AND ONLY THE FIRST IS MANDATORY — a deliberate choice with a
    ///         cost. `IdentityRegistry.checkEligible` is always run: it catches the frozen
    ///         wallet, the sanctions hit, the lapsed CDD record and the missing claim, which
    ///         is the whole of what AMLR Arts 20/75 and TFS require here. The rule MODULES are
    ///         opt-in per distribution, because most of them were written to reason about a
    ///         movement of UNITS — a concentration counter or a holding-period clock asked to
    ///         adjudicate a cash payment will either misfire or answer a question nobody
    ///         asked. Turning them on for an instrument whose modules are payout-aware is
    ///         correct; turning them on by default would block income on rules that were never
    ///         about income.
    /// @dev    Returns a bool rather than reverting. A revert would abort the batch and let one
    ///         frozen wallet stop everyone else's income — and it would leak, through the
    ///         failure, exactly what AMLR Art 76 forbids disclosing.
    function _gate(Distribution storage d, address holder, uint256 units) private view returns (bool) {
        if (!identity.isEligible(holder)) return false;
        if (d.runComplianceModules && !compliance.canTransfer(address(0), holder, units)) return false;
        return true;
    }

    function _settleTo(uint256 id, Distribution storage d, address holder, uint256 gross) private {
        uint256 fee = (gross * d.feeBps) / MAX_BPS;
        uint256 withheld = (gross * d.withholdingBps) / MAX_BPS;
        // Any rounding remainder stays with the holder. Deliberate: it is their money, and a
        // fee that rounds in the operator's favour on every payout is a fee the disclosure
        // document does not describe.
        uint256 net = gross - fee - withheld;

        d.paidOut += gross;

        if (fee > 0) _send(feeRecipient, fee);
        if (withheld > 0) _send(taxRecipient, withheld);
        _send(holder, net);

        emit EntitlementPaid(id, holder, gross, fee, withheld);
    }

    /// @notice A holder whose entitlement was withheld collects it once the block is gone —
    ///         the freeze lifted, the CDD record refreshed, the recipient contract fixed.
    /// @dev    Callable by the holder themselves, deliberately. A withheld payout that only the
    ///         operator can release is an operator liability the holder cannot enforce.
    function redeemUnclaimed(uint256 id) external nonReentrant {
        Distribution storage d = _distributions[id];
        if (d.state == State.None) revert UnknownDistribution(id);

        uint256 amount = unclaimedOf[id][msg.sender];
        if (amount == 0) revert NothingUnclaimed(id, msg.sender);
        if (!_gate(d, msg.sender, 0)) revert NothingUnclaimed(id, msg.sender);

        unclaimedOf[id][msg.sender] = 0;
        d.unclaimed -= amount;

        _settleTo(id, d, msg.sender, amount);
        emit UnclaimedRedeemed(id, msg.sender, amount);
    }

    /// @notice Returns still-unclaimed value to the issuer after the deadline.
    /// @dev    ⚠️ THIS DOES NOT EXTINGUISH THE DEBT, AND THE CONTRACT CANNOT MAKE IT DO SO.
    ///         Whether an unclaimed dividend lapses is a question of the issuing Member State's
    ///         prescription and unclaimed-property law, not of this function. What the sweep
    ///         does is stop value sitting in a contract indefinitely while leaving a permanent
    ///         record of the amount and the holder it was owed to. `claimDeadline == 0` — the
    ///         safer default — disables the sweep entirely.
    function sweepUnclaimed(uint256 id, address to) external onlyAgent nonReentrant {
        Distribution storage d = _requireState(id, State.Closed);
        if (d.claimDeadline == 0) revert NoSweepConfigured(id);
        if (block.timestamp <= d.claimDeadline) revert ClaimDeadlineNotPassed(id, d.claimDeadline);

        uint256 amount = d.unclaimed;
        d.unclaimed = 0;
        _send(to, amount);
        emit UnclaimedSwept(id, amount, to);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // INTERNALS
    // ═══════════════════════════════════════════════════════════════════════

    function _send(address to, uint256 amount) private {
        (bool ok, ) = payable(to).call{value: amount}("");
        if (!ok) revert PayoutFailed(to, amount);
    }

    function _requireState(uint256 id, State expected) private view returns (Distribution storage d) {
        d = _distributions[id];
        if (d.state == State.None) revert UnknownDistribution(id);
        if (d.state != expected) revert WrongState(id, expected, d.state);
    }

    /// @dev Sorted-pair Merkle verification. Leaves are `keccak256(holder, units)`.
    function _verify(bytes32[] calldata proof, bytes32 root, bytes32 leaf) private pure returns (bool) {
        bytes32 computed = leaf;
        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 p = proof[i];
            computed = computed <= p ? keccak256(abi.encodePacked(computed, p)) : keccak256(abi.encodePacked(p, computed));
        }
        return computed == root;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS
    // ═══════════════════════════════════════════════════════════════════════

    function distribution(uint256 id) external view returns (Distribution memory) {
        return _distributions[id];
    }

    function grossRequired(uint256 id) external view returns (uint256) {
        Distribution storage d = _distributions[id];
        return d.totalUnits * d.ratePerUnit;
    }

    /// @notice What a holder would receive today, and whether the gate currently lets them.
    ///         Reviewer- and UI-facing. ⚠️ `eligible` must NOT be surfaced to the holder as a
    ///         reason — it is the same AMLR Art 76 boundary `CovenantRegistry.diagnose` draws.
    function preview(
        uint256 id,
        address holder,
        uint256 units
    ) external view returns (uint256 gross, uint256 fee, uint256 withheld, uint256 net, bool eligible) {
        Distribution storage d = _distributions[id];
        gross = units * d.ratePerUnit;
        fee = (gross * d.feeBps) / MAX_BPS;
        withheld = (gross * d.withholdingBps) / MAX_BPS;
        net = gross - fee - withheld;
        eligible = _gate(d, holder, units);
    }
}
