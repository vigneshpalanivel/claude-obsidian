// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Distribution, DistributionState} from "./Interfaces.sol";

import {IComplianceGate, IIdentityGate, IRestrictedParty, IProtocolPause} from "./Interfaces.sol";

/// @title DistributionAgent (illustrative sample — not production code)
/// @notice C1 + C2 — pays holders. Dividends, rental income, revenue share, and the cash leg
///         of `CouponSchedule` and `DistributionWaterfall`, both of which route through here
///         rather than paying anyone themselves.
/// @dev    ⚠️ A DISTRIBUTION IS A GATED TRANSFER, NOT A PAYMENT. It runs the same two
///         mandatory checks as an ordinary token movement — identity eligibility and the restriction
///         register — or it is a bypass: a wallet that cannot receive a single unit must not be
///         able to receive the income those units produce. This is the reason the contract
///         exists as a separate, gated agent instead of the issuer sending a batch payment from
///         a treasury wallet.
/// @dev    ⚠️ AMLR Art 76 REACHES THE PAYOUT PATH. Nothing here may disclose WHY a holder was
///         not paid. `EntitlementUnclaimed` fires identically for a restricted wallet, an expired
///         CDD record, a module veto and a recipient whose push FAILED — one event, four causes,
///         no reason code, and the same state afterwards (held in `unclaimedOf`, redeemable).
///         That indistinguishability IS the control. ⚠️ Until 2026-09-08 this paragraph was
///         false: a failed push REVERTED with `PayoutFailed(holder, amount)` while a gate failure
///         held and emitted — so `EntitlementUnclaimed` fired ONLY for compliance reasons, which
///         is the "excluded from dividend" tell M5 §3 warns about, naming the wallet in an
///         indexed topic. Now the holder push is attempted first and a failure is held exactly
///         like a veto; `PayoutFailed` survives only for the fee and withholding legs, which name
///         the operator's own recipients and no holder. The design §5a cross-reference should
///         read: "a payout that cannot be delivered, for ANY reason, becomes an unclaimed
///         entitlement; the log does not say which."
/// @dev    ⚠️ NO CLIENT MONEY RESTS HERE. § Scope keeps the platform out of the payment chain:
///         the issuer funds a distribution, the contract pushes it out, and between those two
///         acts the balance is committed to identified holders rather than held on the
///         operator's own account. Same posture as `SubscriptionEscrow` on the way in. An
///         operator that lets pools sit indefinitely is running a client-money business and
///         needs the authorisation that goes with it.
/// @dev    ⚠️ ONE BALANCE, MANY DISTRIBUTIONS, ONE INVARIANT. Every distribution is paid from
///         the same ETH balance, so the thing that stops distribution B spending distribution
///         A's funding is arithmetic, not separation: `committedOf[id]` is fixed at open,
///         `reservedWei` is the sum of what every open-or-closed distribution can still pay, and
///         `address(this).balance >= reservedWei` is re-asserted after every movement of cash.
///         Before 2026-09-08 none of that existed — an agent that anchored `totalUnits` below
///         the leaf sum had later holders paid from another distribution's money until it ran
///         dry mid-register, the exact "partial payment" §5a says must be impossible.
contract DistributionAgent {
    // ═══════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev A withheld entitlement. `units` is the holder's record-block balance from the leaf,
    ///      kept so `redeemUnclaimed` can re-run the gate with the SAME argument `distribute`
    ///      used — a module that reasons about a unit amount must not be asked about zero.
    struct Unclaimed {
        uint256 amount;
        uint256 units;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ROLES & WIRING
    // ═══════════════════════════════════════════════════════════════════════

    address public immutable governance;

    /// @notice The issuer or AIFM. Declares distributions, anchors snapshots, funds pools.
    mapping(address => bool) public isAgent;

    /// @dev Interface-typed and settable — never concrete, never `immutable`. Scoping rules
    ///      out is `ModularCompliance.removeModule`, not a null reference here.
    IIdentityGate public identity;
    IComplianceGate public compliance;

    /// @notice The wallet-level restriction store. Read on EVERY payout, in the mandatory layer.
    /// @dev    ⚠️ ADDED 2026-09-08 AND IT IS NOT OPTIONAL. `IdentityRegistry.freeze` used to
    ///         carry the wallet stop, so `identity.isEligible` caught a restricted holder for free.
    ///         That flag was removed — every stop now lives in `RestrictedPartyRegistry` — and without a
    ///         direct read here the only thing catching a sanctioned holder would be
    ///         `d.runComplianceModules`, which is OPT-IN PER DISTRIBUTION. A payout run
    ///         configured without modules would have paid income to a listed person.
    ///         Mandatory layer, same standing as `checkEligible`.
    IRestrictedParty public restrictions;

    /// @notice The protocol pause (`DoraGovernor`). Read on `distribute`, `distributeMany` and
    ///         `redeemUnclaimed` — the paths that push value to holders. NOT read on `fund`,
    ///         `sweepUnclaimed` or `withdrawSurplus`: an incident is not a reason to trap cash.
    IProtocolPause public protocolPause;

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

    /// @notice `totalUnits × ratePerUnit`, fixed at `openDistribution`. The most this
    ///         distribution may ever pay out or hold as unclaimed; `distribute` enforces it.
    mapping(uint256 => uint256) public committedOf;

    /// @notice When the unclaimed balance was swept, 0 while it has not been. Once set,
    ///         `redeemUnclaimed` reverts `Swept` — the money left; the record of who was owed
    ///         what stays in `unclaimedOf`.
    mapping(uint256 => uint64) public sweptAt;

    /// @notice Σ over every opened distribution of `committed − paidOut − swept`. Cash this
    ///         contract must hold. See the contract note.
    uint256 public reservedWei;

    /// @dev Paid, or moved to unclaimed. Either way this holder is done for this distribution.
    mapping(uint256 => mapping(address => bool)) public settled;

    /// @dev Withheld entitlements, claimable later by the holder once whatever blocked them is
    ///      resolved. ⚠️ A payout that cannot be pushed is not extinguished — the issuer still
    ///      owes it. Modelling it explicitly is the difference between a liability with a name
    ///      on it and value stranded in a contract nobody will admit is theirs.
    mapping(uint256 => mapping(address => Unclaimed)) public unclaimedOf;

    uint16 public constant MAX_BPS = 10_000;

    /// @dev Simple reentrancy guard. The push path calls out to arbitrary recipient addresses,
    ///      any of which may be a contract with a fallback.
    uint256 private _locked = 1;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS
    // ═══════════════════════════════════════════════════════════════════════

    event AgentSet(address indexed agent, bool allowed);
    event RecipientsSet(address feeRecipient, address taxRecipient);

    /// @notice One event for every inter-contract reference, keyed by role rather than by
    ///         function name, so an operational-resilience reviewer can reconstruct which
    ///         implementation this agent was pointed at on any given block from logs alone.
    event DependencySet(bytes32 indexed what, address impl);

    event DistributionDeclared(uint256 indexed id, uint64 recordBlock, uint256 ratePerUnit, uint16 feeBps);
    event SnapshotAnchored(uint256 indexed id, bytes32 snapshotRoot, uint256 totalUnits, uint256 grossRequired);
    event DistributionFunded(uint256 indexed id, uint256 amount, uint256 fundedTotal);
    event DistributionOpened(uint256 indexed id, uint256 committed);
    event DistributionClosed(uint256 indexed id, uint256 paidOut, uint256 unclaimed);
    event SurplusWithdrawn(address indexed to, uint256 amount);

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
    error ZeroAddress();
    error Reentrancy();
    error ProtocolPaused();
    error UnknownDistribution(uint256 id);
    error WrongState(uint256 id, DistributionState expected, DistributionState actual);
    error RecordBlockMustBeFuture(uint64 recordBlock);
    error RecordBlockNotReached(uint256 id, uint64 recordBlock);
    error ZeroRate();
    error ZeroUnits();
    error BpsOutOfRange(uint16 bps);
    error PoolNotFullyFunded(uint256 id, uint256 funded, uint256 required);
    /// @dev The per-distribution spend invariant: `paidOut + unclaimed + gross > committed`.
    ///      Reached only through a snapshot whose leaves sum past `totalUnits` — it is the
    ///      on-chain half of the reconciliation `anchorSnapshot` says must happen off-chain.
    error DistributionOverspent(uint256 id, uint256 committed, uint256 wouldReach);
    /// @dev The contract-level solvency invariant: `balance < reservedWei` after a movement.
    error ReserveBreached(uint256 balance, uint256 reservedWei);
    error SurplusExceeded(uint256 requested, uint256 withdrawable);
    error AlreadySettled(uint256 id, address holder);
    error BadProof(uint256 id, address holder);
    error NothingUnclaimed(uint256 id, address holder);
    error ClaimDeadlineNotPassed(uint256 id, uint64 deadline);
    error NoSweepConfigured(uint256 id);
    error Swept(uint256 id, uint64 sweptAt);
    /// @dev Fee / withholding leg only. Names the operator's own recipient, never a holder —
    ///      a holder-side failure is held, not reverted (see the Art 76 note).
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

    constructor(
        address governance_,
        address identity_,
        address compliance_,
        address restrictions_,
        address protocolPause_
    ) {
        if (governance_ == address(0) || identity_ == address(0)) revert ZeroAddress();
        if (compliance_ == address(0) || restrictions_ == address(0)) revert ZeroAddress();
        if (protocolPause_ == address(0)) revert ZeroAddress();
        governance = governance_;
        identity = IIdentityGate(identity_);
        compliance = IComplianceGate(compliance_);
        restrictions = IRestrictedParty(restrictions_);
        protocolPause = IProtocolPause(protocolPause_);
        emit DependencySet("identity", identity_);
        emit DependencySet("compliance", compliance_);
        emit DependencySet("restrictions", restrictions_);
        emit DependencySet("protocolPause", protocolPause_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // DEPENDENCIES
    // ═══════════════════════════════════════════════════════════════════════
    //
    // ⚠️ ALL FOUR ARE SWAPPABLE AND NONE MAY BE UNSET. Every reference this agent holds is read
    //    on the payout path, so a null one is not "control not owed", it is the control silently
    //    gone. `identity` and `compliance` had no setter before 2026-09-08 — that was an oversight
    //    against the standing rule, and it meant a resilience event affecting either forced a
    //    redeploy of an agent that may be holding a funded, part-paid distribution.

    /// @notice Re-point the identity gate. Swap, never unset.
    function setIdentity(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        identity = IIdentityGate(impl);
        emit DependencySet("identity", impl);
    }

    /// @notice Re-point the rule engine. Swap, never unset.
    function setCompliance(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        compliance = IComplianceGate(impl);
        emit DependencySet("compliance", impl);
    }

    /// @notice Re-point the restriction store. Swap, never unset.
    function setRestrictions(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        restrictions = IRestrictedParty(impl);
        emit DependencySet("restrictions", impl);
    }

    /// @notice Re-point the protocol pause. Swap, never unset.
    function setProtocolPause(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        protocolPause = IProtocolPause(impl);
        emit DependencySet("protocolPause", impl);
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
        d.state = DistributionState.Declared;
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
    ///         costume. What the contract DOES now catch is the consequence: a leaf sum that
    ///         exceeds `totalUnits` trips `DistributionOverspent` on the holder that crosses
    ///         the line, instead of being paid from another distribution's funding.
    function anchorSnapshot(uint256 id, bytes32 snapshotRoot, uint256 totalUnits) external onlyAgent {
        Distribution storage d = _requireState(id, DistributionState.Declared);
        if (block.number <= d.recordBlock) revert RecordBlockNotReached(id, d.recordBlock);
        if (totalUnits == 0) revert ZeroUnits();

        d.snapshotRoot = snapshotRoot;
        d.totalUnits = totalUnits;
        d.state = DistributionState.Snapshotted;

        emit SnapshotAnchored(id, snapshotRoot, totalUnits, totalUnits * d.ratePerUnit);
    }

    /// @notice Step 3. Fund the pool. May be called repeatedly until it covers the snapshot.
    /// @dev    `funded` is PER DISTRIBUTION — every wei deposited is attributed to exactly one
    ///         id, so `openDistribution` cannot count another distribution's deposit.
    function fund(uint256 id) external payable onlyAgent {
        Distribution storage d = _distributions[id];
        if (d.state != DistributionState.Snapshotted && d.state != DistributionState.Open) {
            revert WrongState(id, DistributionState.Snapshotted, d.state);
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
    /// @dev    Two tests, both needed. `funded >= committed` says this distribution's own
    ///         deposits cover it; `balance >= reservedWei` (after adding this commitment) says
    ///         the cash is still here — a deposit that `withdrawSurplus` took back out before
    ///         open would pass the first and fail the second.
    function openDistribution(uint256 id) external onlyAgent {
        Distribution storage d = _requireState(id, DistributionState.Snapshotted);

        uint256 committed = d.totalUnits * d.ratePerUnit;
        if (d.funded < committed) revert PoolNotFullyFunded(id, d.funded, committed);

        committedOf[id] = committed;
        reservedWei += committed;
        _requireSolvent();

        d.state = DistributionState.Open;
        emit DistributionOpened(id, committed);
    }

    function closeDistribution(uint256 id) external onlyAgent {
        Distribution storage d = _requireState(id, DistributionState.Open);
        d.state = DistributionState.Closed;
        emit DistributionClosed(id, d.paidOut, d.unclaimed);
    }

    /// @notice Governance takes back cash no distribution can still pay: over-funding, and
    ///         deposits against distributions that never opened.
    function withdrawSurplus(address to, uint256 amount) external onlyGovernance nonReentrant {
        if (to == address(0)) revert ZeroAddress();
        uint256 withdrawable = _surplus();
        if (amount > withdrawable) revert SurplusExceeded(amount, withdrawable);

        (bool ok, ) = payable(to).call{value: amount}("");
        if (!ok) revert PayoutFailed(to, amount);
        _requireSolvent();
        emit SurplusWithdrawn(to, amount);
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
        if (protocolPause.paused()) revert ProtocolPaused();
        Distribution storage d = _requireState(id, DistributionState.Open);
        if (settled[id][holder]) revert AlreadySettled(id, holder);

        bytes32 leaf = keccak256(abi.encodePacked(holder, units));
        if (!_verify(proof, d.snapshotRoot, leaf)) revert BadProof(id, holder);

        settled[id][holder] = true;

        uint256 gross = units * d.ratePerUnit;

        // ── the spend invariant ──────────────────────────────────────────
        uint256 wouldReach = d.paidOut + d.unclaimed + gross;
        if (wouldReach > committedOf[id]) revert DistributionOverspent(id, committedOf[id], wouldReach);

        // ── the C1 gate, then the push; either failing lands in the same place ──
        if (!_gate(d, holder, units) || !_settleTo(id, d, holder, gross)) {
            _hold(id, d, holder, gross, units);
        }
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
    ///         cost. TWO reads are always run — `IdentityRegistry.isEligible` for the lapsed
    ///         CDD record and the missing claim, and `RestrictedPartyRegistry.isBlocked` for every
    ///         wallet-level stop there is. Together that is the whole of what AMLR Arts 21, 75
    ///         and TFS require here. The restriction read is separate because the freeze flag no
    ///         longer lives on the identity record; folding it back in would recreate the
    ///         two-store leak that removal was meant to close. The rule MODULES are
    ///         opt-in per distribution, because most of them were written to reason about a
    ///         movement of UNITS — a concentration counter or a holding-period clock asked to
    ///         adjudicate a cash payment will either misfire or answer a question nobody
    ///         asked. Turning them on for an instrument whose modules are payout-aware is
    ///         correct; turning them on by default would block income on rules that were never
    ///         about income.
    /// @dev    Returns a bool rather than reverting. A revert would abort the batch and let one
    ///         restricted wallet stop everyone else's income — and it would leak, through the
    ///         failure, exactly what AMLR Art 76 forbids disclosing.
    function _gate(Distribution storage d, address holder, uint256 units) private view returns (bool) {
        if (!identity.isEligible(holder)) return false;
        if (restrictions.isBlocked(holder)) return false;
        if (d.runComplianceModules && !compliance.canTransfer(address(0), holder, units)) return false;
        return true;
    }

    /// @dev Attempts the payout. Returns false — with NO state changed and NO cash moved — if
    ///      the holder's push fails, so the caller holds it exactly as it would a gate veto.
    ///      The holder leg goes FIRST for that reason: fee and withholding are forwarded only
    ///      once the holder has actually been paid, so a held entitlement carries its whole
    ///      gross and the deductions are taken at redemption instead.
    function _settleTo(uint256 id, Distribution storage d, address holder, uint256 gross) private returns (bool) {
        uint256 fee = (gross * d.feeBps) / MAX_BPS;
        uint256 withheld = (gross * d.withholdingBps) / MAX_BPS;
        // Any rounding remainder stays with the holder. Deliberate: it is their money, and a
        // fee that rounds in the operator's favour on every payout is a fee the disclosure
        // document does not describe.
        uint256 net = gross - fee - withheld;

        (bool ok, ) = payable(holder).call{value: net}("");
        if (!ok) return false;

        d.paidOut += gross;
        reservedWei -= gross;

        if (fee > 0) _send(feeRecipient, fee);
        if (withheld > 0) _send(taxRecipient, withheld);
        _requireSolvent();

        emit EntitlementPaid(id, holder, gross, fee, withheld);
        return true;
    }

    /// @dev One landing place for every undelivered entitlement. See the Art 76 note.
    function _hold(uint256 id, Distribution storage d, address holder, uint256 gross, uint256 units) private {
        d.unclaimed += gross;
        unclaimedOf[id][holder] = Unclaimed({amount: gross, units: units});
        emit EntitlementUnclaimed(id, holder, gross);
    }

    /// @notice A holder whose entitlement was withheld collects it once the block is gone —
    ///         the restriction lifted, the CDD record refreshed, the recipient contract fixed.
    /// @dev    Callable by the holder themselves, deliberately. A withheld payout that only the
    ///         operator can release is an operator liability the holder cannot enforce.
    /// @dev    The gate is re-run with the holder's ORIGINAL record-block units, not zero — a
    ///         payout-aware module asked about a zero-unit movement answers a different
    ///         question. One error for "nothing held", "gate still closed" and "push still
    ///         fails": the caller is the holder, so nothing is disclosed to a third party, and
    ///         a distinct error for the gate would be the reason code Art 76 forbids.
    function redeemUnclaimed(uint256 id) external nonReentrant {
        if (protocolPause.paused()) revert ProtocolPaused();
        Distribution storage d = _distributions[id];
        if (d.state == DistributionState.None) revert UnknownDistribution(id);
        if (sweptAt[id] != 0) revert Swept(id, sweptAt[id]);

        Unclaimed memory u = unclaimedOf[id][msg.sender];
        if (u.amount == 0) revert NothingUnclaimed(id, msg.sender);
        if (!_gate(d, msg.sender, u.units)) revert NothingUnclaimed(id, msg.sender);

        delete unclaimedOf[id][msg.sender];
        d.unclaimed -= u.amount;

        if (!_settleTo(id, d, msg.sender, u.amount)) revert NothingUnclaimed(id, msg.sender);
        emit UnclaimedRedeemed(id, msg.sender, u.amount);
    }

    /// @notice Returns still-unclaimed value to the issuer after the deadline.
    /// @dev    ⚠️ THIS DOES NOT EXTINGUISH THE DEBT, AND THE CONTRACT CANNOT MAKE IT DO SO.
    ///         Whether an unclaimed dividend lapses is a question of the issuing Member State's
    ///         prescription and unclaimed-property law, not of this function. What the sweep
    ///         does is stop value sitting in a contract indefinitely while leaving a permanent
    ///         record of the amount and the holder it was owed to. `claimDeadline == 0` — the
    ///         safer default — disables the sweep entirely.
    /// @dev    Per-holder `unclaimedOf` entries are NOT zeroed — the contract cannot enumerate
    ///         them, and they are the record of who was owed what. `sweptAt[id]` is the single
    ///         flag that turns every later `redeemUnclaimed` on this id into `Swept`. Before
    ///         2026-09-08 a redeem after a sweep underflowed `d.unclaimed`.
    function sweepUnclaimed(uint256 id, address to) external onlyAgent nonReentrant {
        Distribution storage d = _requireState(id, DistributionState.Closed);
        if (d.claimDeadline == 0) revert NoSweepConfigured(id);
        if (block.timestamp <= d.claimDeadline) revert ClaimDeadlineNotPassed(id, d.claimDeadline);
        if (sweptAt[id] != 0) revert Swept(id, sweptAt[id]);

        uint256 amount = d.unclaimed;
        d.unclaimed = 0;
        sweptAt[id] = uint64(block.timestamp);
        reservedWei -= amount;
        _send(to, amount);
        _requireSolvent();
        emit UnclaimedSwept(id, amount, to);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // INTERNALS
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Reverting send — fee, withholding and sweep legs only. Never a holder.
    function _send(address to, uint256 amount) private {
        (bool ok, ) = payable(to).call{value: amount}("");
        if (!ok) revert PayoutFailed(to, amount);
    }

    function _requireSolvent() private view {
        if (address(this).balance < reservedWei) revert ReserveBreached(address(this).balance, reservedWei);
    }

    function _surplus() private view returns (uint256) {
        uint256 bal = address(this).balance;
        return bal > reservedWei ? bal - reservedWei : 0;
    }

    function _requireState(uint256 id, DistributionState expected) private view returns (Distribution storage d) {
        d = _distributions[id];
        if (d.state == DistributionState.None) revert UnknownDistribution(id);
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

    /// @notice The contract-level invariant: cash every opened distribution can still pay.
    ///         `address(this).balance` must never fall below it.
    function totalCommittedOutstanding() external view returns (uint256) {
        return reservedWei;
    }

    /// @notice Cash above the reservation — what `withdrawSurplus` may take right now.
    function surplus() external view returns (uint256) {
        return _surplus();
    }

    /// @notice What a holder would receive today, and whether the gate currently lets them.
    /// @dev    ⚠️ A READ ANYONE CAN MAKE, AND IT MUST NOT BE SURFACED IN HOLDER UIs. `eligible`
    ///         is the answer to "is this wallet blocked?", and this contract cannot stop a
    ///         caller asking it about somebody else — a `view` has no caller-scoping worth the
    ///         name. It exists for the operator's reconciliation desk and for the auditor. The
    ///         design-level rule (same boundary `CovenantRegistry.diagnose` draws) is that no
    ///         investor-facing surface renders it, for the same AMLR Art 76 reason the event
    ///         carries no reason code. A product that shows a holder "eligible: false" beside
    ///         their dividend has built the tipping-off channel here on purpose.
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
