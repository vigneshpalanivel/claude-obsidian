// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ICompliance, IIdentityGate, IProtocolPause, IRestrictedParty} from "./Interfaces.sol";

/// @title SecurityToken (illustrative sample — not production code)
/// @notice C1 + C5 — the instrument itself, and the only contract in this folder that moves a
///         balance. Everything else is a registry or a rule module waiting to be called from
///         here. Until this exists, none of the other twenty contracts runs.
/// @dev    ⚠️ THIS IS DELIBERATELY NOT ERC-1400 AND NOT ERC-3643. §16 D0 leaves the base
///         standard to the operator, and §8 makes that choice PROSPECTUS-BLOCKING: the token
///         standard is a disclosure item under Prospectus Arts 6/16(1), so changing it after
///         approval is a material change carrying an Art 23 supplement and a withdrawal
///         window. Writing this file as T-REX or as an ERC-1410/1594/1644 assembly would
///         quietly settle a decision the design reserves — and §13's standard-independence
///         check exists precisely to prove the Articles enforced do not move when D0 moves.
///         So what is here is the §3 capability set, in plain ERC-20 shape, with the
///         compliance content that must survive either binding. Bind it at spec time.
/// @dev    ⚠️ C6 (PARTITIONS) IS NOT IN THIS FILE, AND THAT IS THE D0 DECISION SHOWING. Under
///         ERC-1400 partitions come free from ERC-1410; under ERC-3643 they are custom work.
///         Modelling them here would pick a side. `DistributionWaterfall` shows the shape a
///         tranched instrument needs when the decision is made.
/// @dev    ⚠️ EVERY VOLUNTARY MOVEMENT ROUTES THROUGH THE SAME HOOK — mint, burn, transfer and
///         transferFrom all go through `_move` → `_check`. The moment one of those paths skips
///         `_check`, that path is the bypass: a wallet that cannot receive a transfer but can
///         receive a mint is a frozen wallet that is not frozen. `DistributionAgent` exists for
///         the same reason on the payout side.
///         The two INVOLUNTARY paths run a deliberately narrower gate, stated here so nobody
///         reads "every movement" and assumes otherwise:
///           • `forcedTransfer` runs identity on the RECIPIENT, the restriction store on BOTH
///             sides (the sender limb relieved only by a governance-registered destination),
///             and the module list with the real sender. It skips the sender's eligibility and
///             the sender's partial freeze. See its own NatSpec for why each of those is so.
///           • `recoverWallet` runs the record-pointer match ONLY — no identity gate, no
///             restriction read, no module. See its NatSpec for what that leaves behind.
///         Neither involuntary path reads `paused` or the protocol pause. See `whenLive`.
/// @dev    GDPR / AMLR Art 76: freeze and forced-transfer events carry a `reasonHash`, never a
///         reason. The hash points at an off-chain incident record. A human-readable "sanctions
///         hit" in a public log is both a tipping-off disclosure and an un-erasable personal
///         datum about an identified person.
/// @dev    ⚠️ NO HARD DEPENDENCY ON ANY COMPLIANCE CONTRACT. Both references are
///         INTERFACE-TYPED and GOVERNANCE-SETTABLE, never concrete and never `immutable` —
///         the same shape ERC-3643 uses (`setIdentityRegistry` / `setCompliance`, with an
///         "Added" event on each), and the same shape an ERC-1400 assembly needs. Adopting the
///         mechanism settles nothing about D0; it is standard-neutral.
/// @dev    ⚠️ REMOVABILITY LIVES ONE LEVEL DOWN, AND THAT IS THE DESIGN, NOT A LIMITATION.
///         The token always has a compliance contract and an identity registry — there is no
///         "unset" state and no null check on the hook. A client who owes fewer obligations
///         does not detach the plumbing; they **empty the rule set**:
///           • `ModularCompliance.removeModule` for each rule that does not apply, and
///           • an empty required-claim-topic set for a jurisdiction in `ClaimTopicsRegistry`.
///         **This is deliberately safer than a detachable reference.** A nullable reference
///         cannot distinguish "nobody wired it" from "not owed", so a half-finished deployment
///         waves every transfer through with every rule silently off. Here an unwired token
///         cannot be constructed at all, and removing a rule is an explicit, individually
///         logged act against a named Article.
contract SecurityToken {
    // ═══════════════════════════════════════════════════════════════════════
    // ROLES
    // ═══════════════════════════════════════════════════════════════════════

    address public immutable governance;

    /// @notice Transfer agents. Mint, burn, freeze, forced transfer and recovery — the C5
    ///         surface. Separate from `governance` because these are daily operational acts
    ///         performed by an operations desk, while governance is upgrade authority. Under
    ///         DORA Art 5 those are different people with different accountability.
    mapping(address => bool) public isAgent;

    /// @dev ⚠️ NOT `immutable`, and not a concrete type. A constructor-set immutable reference
    ///      cannot be swapped after a provider failure — the operational-resilience regime
    ///      requires these stay swappable at the contract layer rather than hard-wired — and a
    ///      concrete type drags one implementation's whole dependency tree into every
    ///      deployment.
    ICompliance public compliance;
    IIdentityGate public identityRegistry;

    /// @notice The wallet-level restriction store. Read on EVERY movement, in the MANDATORY layer.
    /// @dev    ⚠️ A THIRD MANDATORY REFERENCE, AND IT IS NOT DUPLICATION OF `RestrictedPartyGate`. Until
    ///         2026-09-08 the whole-wallet stop was a flag on the investor record, so
    ///         `checkEligible` enforced it and no deployment could be wired without it. Moving
    ///         every stop into `RestrictedPartyRegistry` was right — one store is what keeps an observer
    ///         from reading the class out of public storage — but routing it in through
    ///         `RestrictedPartyGate` alone would have DEMOTED it from mandatory to configurable: a
    ///         governance action that never registers the module, or one `removeModule` call,
    ///         and sanctions stop being enforced on the token with nothing reverting to say so.
    ///         A sanctions stop is not a per-instrument policy choice like a concentration limit.
    ///         It is owed by every deployment, so it sits beside `identityRegistry`, above the
    ///         module list, and cannot be scoped out.
    /// @dev    `RestrictedPartyGate` still exists and is still registered. Both paths read the SAME store
    ///         and raise the SAME argument-free error, so the double read cannot disagree and
    ///         cannot leak — it costs two SLOADs. The gate is what reaches tokens and modules
    ///         that only ever wire `ModularCompliance`; this reference is what makes the control
    ///         unremovable here.
    IRestrictedParty public restrictions;

    /// @notice The protocol-level pause — `DoraGovernor.paused()` — read on every VOLUNTARY path.
    /// @dev    ⚠️ A FOURTH MANDATORY REFERENCE, ADDED 2026-09-08 BECAUSE THE TRIP HALTED NOTHING.
    ///         `ValuationOracle` trips the governor's circuit breaker on a deviation halt, the
    ///         governor sets its flag, and until this line nothing read it — the halt was an
    ///         event with no consumer, which the design's §9 explicitly forbids. Reading it here
    ///         is what turns the trip into a control on the instrument.
    /// @dev    ⚠️ IT IS READ IN `whenLive` AND NOWHERE ELSE, AND `whenLive` GUARDS VOLUNTARY
    ///         PATHS ONLY. `forcedTransfer` and `recoverWallet` execute during a protocol pause
    ///         exactly as they execute during the agent's own `paused` — a court order does not
    ///         wait for an incident to close, and an operator cannot cite its own halt as the
    ///         reason it could not comply. Same shape, same reasoning, one more flag.
    /// @dev    Interface-typed, governance-settable, never `immutable`, never null — the
    ///         standing rule. There is no "not owed" configuration: a deployment without a
    ///         governor points this at whatever contract answers `paused()` for it.
    IProtocolPause public protocolPause;

    // ═══════════════════════════════════════════════════════════════════════
    // TOKEN STATE
    // ═══════════════════════════════════════════════════════════════════════

    string public name;
    string public symbol;
    uint8 public immutable decimals;

    /// @notice The instrument's ISIN, as a hash. Not decorative: MiFIR Art 26 transaction
    ///         reports and RTS 1/2 transparency publications are keyed on it, and
    ///         `MarketEventSchema` emits it. Stored as a hash so the on-chain record cannot
    ///         drift from the reference-data record it must match.
    bytes32 public immutable isinHash;

    uint256 public totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    /// @notice PARTIAL freeze — units immobilised while the wallet stays otherwise live.
    /// @dev    ⚠️ A partial freeze and a whole-wallet freeze are different controls and both
    ///         are needed. An AMLR asset freeze on a specific tranche, or a court order over a
    ///         disputed holding, must not stop the holder dealing with the rest — and a
    ///         sanctions designation must stop everything. Modelling only the second forces the
    ///         operator to over-freeze, which is itself a legal exposure to the holder.
    mapping(address => uint256) public frozenUnits;

    /// @notice Whole-instrument halt. Distinct from `ModularCompliance.emergencyBypass`, which
    ///         runs the token WITHOUT a rule; this stops the token entirely. Under DLT Pilot
    ///         Art 7(5) an operator must be able to do both, and must be able to say which one
    ///         it did. Also distinct from `protocolPause` — that is the platform-wide halt the
    ///         governor sets; this is the per-instrument one an agent sets. `whenLive` reads
    ///         both.
    bool public paused;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS
    // ═══════════════════════════════════════════════════════════════════════

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    event ComplianceAdded(address indexed compliance);
    event IdentityRegistryAdded(address indexed identityRegistry);

    /// @notice ⚠️ NO REASON FIELD, unlike the freeze and forced-transfer events. Which store is
    ///         wired is an operational fact; who is in it is not this contract's to announce.
    event RestrictionsSet(address indexed restrictions);
    event ProtocolPauseChanged(address indexed previous, address indexed current);
    event AgentSet(address indexed agent, bool allowed);
    event Paused(bytes32 reasonHash, uint64 at);
    event Unpaused(uint64 at);

    event UnitsFrozen(address indexed wallet, uint256 amount, bytes32 reasonHash);
    event UnitsUnfrozen(address indexed wallet, uint256 amount);

    /// @dev Deliberately a SEPARATE event from `Transfer`, in addition to it — never instead of
    ///      it. A forced transfer is an ordinary balance movement for accounting purposes and
    ///      an extraordinary act for supervisory purposes, and an NCA reviewer asking "which
    ///      movements were involuntary" must not have to infer it from the sender.
    event ForcedTransfer(address indexed from, address indexed to, uint256 value, bytes32 reasonHash);
    event WalletRecovered(address indexed lostWallet, address indexed newWallet, uint256 value, bytes32 reasonHash);

    // ═══════════════════════════════════════════════════════════════════════
    // ERRORS
    // ═══════════════════════════════════════════════════════════════════════

    error NotGovernance();
    error NotAgent();
    error TokenPaused();
    error ZeroAddress();
    error InsufficientBalance(address wallet, uint256 available, uint256 required);
    error InsufficientUnfrozenBalance(address wallet, uint256 unfrozen, uint256 required);
    error InsufficientAllowance(address owner, address spender, uint256 available, uint256 required);
    error FrozenExceedsBalance(address wallet, uint256 balance, uint256 wouldFreeze);
    error NotFrozenByThatMuch(address wallet, uint256 frozen, uint256 requested);
    error RecoveryTargetNotSameInvestor(address lostWallet, address newWallet);
    error RecoveryTargetHasNoRecord(address newWallet);
    error NothingToRecover(address lostWallet);
    /// @dev A forced transfer or a recovery from a wallet to itself moves nothing and would
    ///      still emit `ForcedTransfer` / `WalletRecovered` — an audit-trail entry for an act
    ///      that did not happen. Refused outright.
    error SameWallet(address wallet);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyAgent() {
        if (!isAgent[msg.sender]) revert NotAgent();
        _;
    }

    /// @dev ⚠️ BOTH PAUSES guard the VOLUNTARY paths only — transfer, transferFrom, mint, burn.
    ///      `paused` is the agent's instrument-level halt; `protocolPause.paused()` is the
    ///      governor's platform-level halt, set by an incident or by the oracle circuit breaker.
    ///      Forced transfer and recovery must keep working under either — a court order and a
    ///      sanctions seizure do not wait for the operator to resume trading, and an operator
    ///      who halted the token cannot use its own halt as a reason it could not comply.
    ///      One revert for both: which halt is in force is an operational fact, and `paused` is
    ///      a public read for whoever needs it.
    modifier whenLive() {
        _requireLive();
        _;
    }

    function _requireLive() internal view {
        if (paused || protocolPause.paused()) revert TokenPaused();
    }

    constructor(
        address governance_,
        address compliance_,
        address identity_,
        address restrictions_,
        address protocolPause_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        bytes32 isinHash_
    ) {
        governance = governance_;
        // All four are mandatory at construction. A token cannot exist in a half-wired state
        // where the hook has nothing to call — that is the failure mode a nullable reference
        // invites. A client with no rules gets a compliance contract with an empty module list,
        // not a missing compliance contract.
        if (compliance_ == address(0) || identity_ == address(0)) revert ZeroAddress();
        if (restrictions_ == address(0) || protocolPause_ == address(0)) revert ZeroAddress();
        compliance = ICompliance(compliance_);
        identityRegistry = IIdentityGate(identity_);
        restrictions = IRestrictedParty(restrictions_);
        protocolPause = IProtocolPause(protocolPause_);
        emit ComplianceAdded(compliance_);
        emit IdentityRegistryAdded(identity_);
        emit RestrictionsSet(restrictions_);
        emit ProtocolPauseChanged(address(0), protocolPause_);
        name = name_;
        symbol = symbol_;
        decimals = decimals_;
        isinHash = isinHash_;
    }

    /// @notice Re-point the rule engine. Swap, never unset.
    /// @dev    ⚠️ Scoping rules OUT is not done here — it is `ModularCompliance.removeModule`,
    ///         one Article at a time, each individually logged. Pointing at a different
    ///         compliance contract wholesale replaces every rule at once and should be reserved
    ///         for a genuine implementation swap.
    function setCompliance(address compliance_) external onlyGovernance {
        if (compliance_ == address(0)) revert ZeroAddress();
        compliance = ICompliance(compliance_);
        emit ComplianceAdded(compliance_);
    }

    /// @notice Re-point the identity registry. Swap, never unset.
    /// @dev    ⚠️ Scoping identity requirements DOWN is not done here — it is an empty required-
    ///         claim-topic set for the jurisdiction in `ClaimTopicsRegistry`. Setting this to a
    ///         permissive registry to bypass eligibility would be a silent removal of every
    ///         §4 control at once, which is exactly what the per-topic path avoids.
    function setIdentityRegistry(address identity_) external onlyGovernance {
        if (identity_ == address(0)) revert ZeroAddress();
        identityRegistry = IIdentityGate(identity_);
        emit IdentityRegistryAdded(identity_);
    }

    /// @notice Re-point the restriction store. Swap, never unset.
    /// @dev    ⚠️ THERE IS NO WAY TO SCOPE THIS OUT AND THAT IS THE POINT. Every other control on
    ///         this token has a legitimate "not owed" configuration — an empty module list, an
    ///         empty required-topic set. Targeted financial sanctions bind irrespective of what
    ///         the client is, so the only permitted change here is pointing at a different
    ///         implementation of the same control.
    function setRestrictions(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        restrictions = IRestrictedParty(impl);
        emit RestrictionsSet(impl);
    }

    /// @notice Re-point the protocol pause. Swap, never unset.
    /// @dev    ⚠️ Pointing this at a contract whose `paused()` is always false is the way to
    ///         detach the instrument from the platform halt, and it is a governance act with an
    ///         event against it — not a silent default. There is deliberately no "no governor"
    ///         configuration for the same reason there is no "no restriction store" one.
    function setProtocolPause(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        address previous = address(protocolPause);
        protocolPause = IProtocolPause(impl);
        emit ProtocolPauseChanged(previous, impl);
    }

    function setAgent(address agent, bool allowed) external onlyGovernance {
        isAgent[agent] = allowed;
        emit AgentSet(agent, allowed);
    }

    function pause(bytes32 reasonHash) external onlyAgent {
        paused = true;
        emit Paused(reasonHash, uint64(block.timestamp));
    }

    function unpause() external onlyGovernance {
        paused = false;
        emit Unpaused(uint64(block.timestamp));
    }

    // ═══════════════════════════════════════════════════════════════════════
    // C1 — THE PRE-VALIDATION HOOK
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice The single gate. THREE layers, and the order is not arbitrary: identity first,
    ///         because a rule module asking "is this holder over the ELTIF concentration
    ///         limit" is meaningless for a wallet that has no verified record at all; holds
    ///         second, because it is the one stop that binds irrespective of what the client is;
    ///         the module list last, because everything in it is a per-instrument policy.
    /// @dev    ⚠️ MINT IS `from == address(0)` AND BURN IS `to == address(0)`. Both are passed
    ///         to the modules, which decide for themselves whether they care —
    ///         `CovenantGate` treats mint as its own gate, `EltifConcentration` counts it, a
    ///         holding-period lock ignores it. Filtering here would take that choice away from
    ///         the module that owns the Article.
    /// @dev ⚠️ NO NULL CHECKS HERE, ON PURPOSE. All three references are guaranteed non-zero by
    ///      the constructor and by the setters, so there is no branch a misconfiguration can slip
    ///      through. A client owing nothing gets an empty module list and an empty required-
    ///      claim-topic set — the calls still happen and simply pass.
    /// @dev ⚠️ THE HOLD READ IS THE MANDATORY LAYER, NOT THE MODULE LAYER, even though `RestrictedPartyGate`
    ///      is normally in the module list too. `compliance.checkTransfer` runs a list governance
    ///      can shorten; this line runs whatever happens. Both reach the same store and the same
    ///      argument-free error, so the redundancy is a cost, not a disclosure.
    /// @dev ⚠️ `assertTransferPermitted` HANDLES BOTH SIDES ITSELF, including `address(0)`, and
    ///      is deliberately NOT split into two guarded calls the way the identity reads are. A
    ///      redemption paying out to a listed person releases value exactly as a transfer does,
    ///      so `to == 0` is not a shortcut out of the sender check.
    function _check(address from, address to, uint256 amount) internal view {
        if (from != address(0)) identityRegistry.checkEligible(from);
        if (to != address(0)) identityRegistry.checkEligible(to);
        restrictions.assertTransferPermitted(from, to);
        compliance.checkTransfer(from, to, amount);
    }

    /// @notice Non-reverting form for UIs and pre-trade simulation. Never used internally — a
    ///         boolean at the hook lets a caller ignore the answer.
    function canTransfer(address from, address to, uint256 amount) external view returns (bool) {
        try this.simulate(from, to, amount) {
            return true;
        } catch {
            return false;
        }
    }

    /// @dev External only so `canTransfer` can `try` it. Not intended for direct use.
    function simulate(address from, address to, uint256 amount) external view {
        _requireLive();
        _requireSpendable(from, amount);
        _check(from, to, amount);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // BALANCE MOVEMENT
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev The one place a balance changes. Compliance runs BEFORE the write; the module
    ///      notification runs AFTER, so counter-keeping modules observe the settled position
    ///      rather than an intended one that may still revert.
    function _move(address from, address to, uint256 amount) internal {
        _check(from, to, amount);

        if (from != address(0)) {
            _balances[from] -= amount;
        } else {
            totalSupply += amount;
        }

        if (to != address(0)) {
            _balances[to] += amount;
        } else {
            totalSupply -= amount;
        }

        emit Transfer(from, to, amount);
        compliance.notifyTransfer(from, to, amount);
    }

    function _requireSpendable(address wallet, uint256 amount) internal view {
        uint256 bal = _balances[wallet];
        if (bal < amount) revert InsufficientBalance(wallet, bal, amount);

        uint256 unfrozen = bal - frozenUnits[wallet];
        if (unfrozen < amount) revert InsufficientUnfrozenBalance(wallet, unfrozen, amount);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ERC-20 SURFACE
    // ═══════════════════════════════════════════════════════════════════════

    function balanceOf(address wallet) external view returns (uint256) {
        return _balances[wallet];
    }

    /// @notice What the holder can actually move today. The number a UI should show — a holder
    ///         told they own 100 who cannot move 40 will open a support ticket, and under
    ///         AMLR Art 76 nobody may tell them why.
    function availableBalance(address wallet) external view returns (uint256) {
        uint256 bal = _balances[wallet];
        uint256 frozen = frozenUnits[wallet];
        return bal > frozen ? bal - frozen : 0;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address to, uint256 amount) external whenLive returns (bool) {
        if (to == address(0)) revert ZeroAddress();
        _requireSpendable(msg.sender, amount);
        _move(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external whenLive returns (bool) {
        if (to == address(0)) revert ZeroAddress();

        uint256 allowed = _allowances[from][msg.sender];
        if (allowed < amount) revert InsufficientAllowance(from, msg.sender, allowed, amount);
        _allowances[from][msg.sender] = allowed - amount;

        _requireSpendable(from, amount);
        _move(from, to, amount);
        return true;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ISSUANCE
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Mint. Runs the full hook with `from == address(0)`.
    /// @dev    ⚠️ THE MINT GATE IS WHERE FOUR OF THE SIX COVENANT OBLIGATIONS BITE — PRIIPs
    ///         Art 13, DLT Pilot 4(2)(g), ELTIF 18(3) and ELTIF 26 are all pre-investment
    ///         duties. A mint path that skipped compliance "because the issuer controls it"
    ///         would disable every one of them at the exact moment they apply.
    function mint(address to, uint256 amount) external onlyAgent whenLive {
        if (to == address(0)) revert ZeroAddress();
        _move(address(0), to, amount);
    }

    /// @notice Burn. Redemption, capital reduction, or the disposal leg of a buy-back where the
    ///         issuer has elected to cancel rather than hold.
    /// @dev    Burns unfrozen units only. Burning frozen units would let an agent extinguish a
    ///         holding that a court or an authority has immobilised, which is the one thing a
    ///         freeze is for.
    /// @dev    `whenLive`, like `mint` — added 2026-09-08. A burn is a VOLUNTARY exit: a
    ///         redemption, a cancellation, a buy-back disposal. None of those is a court order,
    ///         so none of them earns the involuntary-path exemption from the halt, and a
    ///         redemption paid out during an oracle deviation halt is paid at a figure the
    ///         halt exists to say is unreliable. Before this the burn path was the one
    ///         voluntary movement that ignored `paused`.
    function burn(address from, uint256 amount) external onlyAgent whenLive {
        _requireSpendable(from, amount);
        _move(from, address(0), amount);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // C5 — FREEZE, FORCED TRANSFER, RECOVERY
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Immobilises `amount` units without touching the rest of the holding.
    /// @dev    ⚠️ THIS IS A PARTIAL CONTROL AND MUST STAY ONE. Whole-wallet stops live in
    ///         `RestrictedPartyRegistry` and reach this contract through `RestrictedPartyGate` on both sides of every
    ///         movement. `IdentityRegistry.freeze` — which this note used to point at — was
    ///         removed on 2026-09-08: two stores that can each stop a wallet let an observer read
    ///         WHICH one holds a person out of public storage and infer the class, whatever the
    ///         revert says.
    /// @dev    ⚠️ AN AGENT WHO FREEZES 100% OF A WALLET'S UNITS THROUGH THIS FUNCTION REBUILDS
    ///         THAT LEAK. `frozenUnits` is public and this contract is not the restriction store, so a
    ///         full-balance entry here is a second, readable, wallet-level stop. The function is
    ///         kept because a freeze over a disputed or collateralised parcel is a genuinely
    ///         different mechanic and forcing it through the restriction store would over-freeze — but
    ///         **partial parcels only**. A whole-wallet stop goes in `RestrictedPartyRegistry`. That is an
    ///         operating rule with no on-chain enforcement, which is why it is stated twice.
    function freezeUnits(address wallet, uint256 amount, bytes32 reasonHash) external onlyAgent {
        uint256 wouldFreeze = frozenUnits[wallet] + amount;
        if (wouldFreeze > _balances[wallet]) revert FrozenExceedsBalance(wallet, _balances[wallet], wouldFreeze);

        frozenUnits[wallet] = wouldFreeze;
        emit UnitsFrozen(wallet, amount, reasonHash);
    }

    function unfreezeUnits(address wallet, uint256 amount) external onlyAgent {
        uint256 frozen = frozenUnits[wallet];
        if (frozen < amount) revert NotFrozenByThatMuch(wallet, frozen, amount);

        frozenUnits[wallet] = frozen - amount;
        emit UnitsUnfrozen(wallet, amount);
    }

    /// @notice Involuntary movement — court order, AMLR asset freeze with a designated
    ///         destination, insolvency, or correcting a settlement error.
    /// @dev    ⚠️ THE ASYMMETRY IS THE WHOLE POINT, AND IT IS NOT A SHORTCUT. Stated limb by
    ///         limb, because the previous version of this note claimed more than the code did:
    ///           • The SENDER'S PARTIAL FREEZE is bypassed. Frozen units move, and the freeze
    ///             counter is reduced to match (see below).
    ///           • The SENDER'S ELIGIBILITY is not consulted. `checkEligible(from)` is skipped:
    ///             a seizure out of a wallet whose KYC has lapsed is still a seizure, and an
    ///             estate distribution out of a dead person's wallet has, by definition, no
    ///             live record to check.
    ///           • The SENDER'S RESTRICTION IS **NOT** BYPASSED, and it is enforced in the
    ///             MANDATORY layer — `restrictions.assertTransferPermitted(from, to)` runs on
    ///             this path exactly as it runs in `_check`, above the module list, where no
    ///             `removeModule` or `emergencyBypass` reaches it. Until 2026-09-08 this
    ///             function relied on `RestrictedPartyGate` inside `compliance.checkTransfer`
    ///             for the same check, which meant a governance action on the module list
    ///             could turn forced transfer into a route that lands units on a listed person
    ///             or releases them from one. The only relief for the sender limb is
    ///             `RestrictedPartyRegistry.setPermittedDestination` — the designated frozen
    ///             account, the enforcement authority's address, the estate's heir — which is
    ///             governance-set, `orderRef`-recorded, and applied by the store itself. An
    ///             agent-key bypass of the restriction store would be a general-purpose
    ///             sanctions override; a governance-set destination allowlist is an auditable
    ///             one. A forced transfer out of a restricted wallet to an address that is NOT
    ///             a permitted destination reverts.
    ///           • THE MODULE LIST RUNS WITH THE REAL SENDER, and sender-side module rules DO
    ///             apply. This note used to say holding periods do not apply here. They do:
    ///             `compliance.checkTransfer(from, to, amount)` reaches `HoldingPeriodGate`
    ///             with `from` as written, and a seizure during a ramp-up lock reverts with
    ///             the lock's own error. The contract does not pretend otherwise. Whether a
    ///             court order overrides an ELTIF Art 18 holding period is a question for
    ///             counsel and the order, not for this function to answer silently; where the
    ///             answer is yes, the mechanism is `ModularCompliance.emergencyBypass` on that
    ///             module — logged, reasoned, governance-only — and not a hidden branch here.
    ///             Passing `address(0)` as the sender to make the modules skip the sender was
    ///             considered and rejected: the modules would then see a MINT, and a covenant
    ///             scoped to mint would bind a seizure.
    ///           • The RECIPIENT is fully checked: identity, restriction store, every module.
    ///             The destination must be an eligible holder, must not be restricted (no
    ///             carve-out exists on the recipient limb, anywhere), and must satisfy every
    ///             rule module. Otherwise "forced transfer" becomes a general-purpose route to
    ///             place units with anyone at all, and every concentration limit, cap and
    ///             covenant in this folder has a back door with an agent key.
    /// @dev    ⚠️ Frozen units are released to the extent they are moved. Leaving the freeze
    ///         counter untouched would leave the SENDER carrying a freeze over units they no
    ///         longer hold, silently immobilising an unrelated part of their holding.
    /// @dev    Not `whenLive`. Runs during the agent's `paused` and during the protocol pause —
    ///         see the `whenLive` note.
    function forcedTransfer(address from, address to, uint256 amount, bytes32 reasonHash) external onlyAgent {
        if (to == address(0)) revert ZeroAddress();
        if (from == to) revert SameWallet(from);

        uint256 bal = _balances[from];
        if (bal < amount) revert InsufficientBalance(from, bal, amount);

        uint256 frozen = frozenUnits[from];
        uint256 unfrozen = bal - frozen;
        if (amount > unfrozen) {
            frozenUnits[from] = frozen - (amount - unfrozen);
        }

        // Mandatory layer first: both sides, generic error, sender limb relieved only by the
        // store's own permitted-destination register. Then recipient identity, then modules.
        restrictions.assertTransferPermitted(from, to);
        identityRegistry.checkEligible(to);
        compliance.checkTransfer(from, to, amount);

        _balances[from] -= amount;
        _balances[to] += amount;

        emit Transfer(from, to, amount);
        emit ForcedTransfer(from, to, amount, reasonHash);
        compliance.notifyTransfer(from, to, amount);
    }

    /// @notice Lost-key recovery. Moves the entire holding, and the freeze state with it.
    /// @dev    ⚠️ THE CONTROL THAT MAKES THIS SAFE IS THE RECORD-POINTER MATCH, NOT THE AGENT
    ///         ROLE. Both wallets must resolve to the SAME off-chain investor record. Without
    ///         that check, "recovery" is an agent-key licence to move any holding to any
    ///         address and call it a lost key — and it would read identically in the logs.
    ///         With it, the operator must first have bound the new wallet to the existing
    ///         verified record in `IdentityRegistry`, which is the step where the identity
    ///         evidence is actually examined.
    /// @dev    ⚠️ THE FREEZE FOLLOWS THE UNITS. Recovering into a clean wallet must not launder
    ///         an asset freeze. If the operator wants the units unfrozen, that is a separate,
    ///         separately-logged decision.
    /// @dev    ⚠️ A WALLET-KEYED RESTRICTION DOES **NOT** FOLLOW, AND THAT IS A LIVE OPERATING RULE.
    ///         This function runs no transfer gate at all — by design, since a recovery whose
    ///         destination is provably the same investor has nothing left to check. But that
    ///         means `RestrictedPartyRegistry.blockWallet(lostWallet)` is left behind: the units land in a
    ///         second wallet of the same person that carries no restriction. `blockPerson` does follow,
    ///         because both wallets resolve to the same `personId` and the store checks the record.
    ///         **Any restriction intended to survive a key loss must be written against the RECORD, not
    ///         the wallet.** This contract cannot enforce that — it holds no write access to the
    ///         store, and giving it one would put a sanctions key on the token.
    /// @dev    Prospectus Art 6/16(1) requires the recovery procedure to be DISCLOSED. This
    ///         function is the disclosed mechanism; the operator's key-loss verification
    ///         procedure is the paper half, and the two must describe the same thing.
    function recoverWallet(address lostWallet, address newWallet, bytes32 reasonHash) external onlyAgent {
        if (newWallet == address(0)) revert ZeroAddress();
        if (lostWallet == newWallet) revert SameWallet(lostWallet);

        // ⚠️ The control that makes recovery safe is the `personId` match, not the agent
        // role. Both wallets must resolve to the SAME off-chain investor record — without that,
        // "recovery" is an agent-key licence to move any holding to any wallet.
        (bytes32 lostPersonId, ) = identityRegistry.personIdOf(lostWallet);
        (bytes32 newPersonId, bool newRegistered) = identityRegistry.personIdOf(newWallet);

        if (!newRegistered) revert RecoveryTargetHasNoRecord(newWallet);
        if (newPersonId == bytes32(0) || newPersonId != lostPersonId) {
            revert RecoveryTargetNotSameInvestor(lostWallet, newWallet);
        }

        uint256 bal = _balances[lostWallet];
        if (bal == 0) revert NothingToRecover(lostWallet);

        uint256 frozen = frozenUnits[lostWallet];

        _balances[lostWallet] = 0;
        frozenUnits[lostWallet] = 0;
        _balances[newWallet] += bal;
        frozenUnits[newWallet] += frozen;

        emit Transfer(lostWallet, newWallet, bal);
        emit WalletRecovered(lostWallet, newWallet, bal, reasonHash);
        compliance.notifyTransfer(lostWallet, newWallet, bal);
    }
}
