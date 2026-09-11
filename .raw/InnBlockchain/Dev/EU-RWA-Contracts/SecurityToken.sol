// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IComplianceGate, IIdentityGate, IProtocolPause, IRestrictedParty} from "./Interfaces.sol";
import {ICompliance, IERC3643, IIdentityRegistry} from "./IERC3643.sol";

/// @title SecurityToken (illustrative sample — not production code)
/// @notice C1 + C5 — the instrument itself, and the only contract in this folder that moves a
///         balance. Everything else is a registry or a rule module waiting to be called from
///         here. Until this exists, none of the other twenty contracts runs.
/// @dev    ⚠️ THIS IMPLEMENTS EIP-3643, WRITTEN FROM THE SPECIFICATION TEXT. Design §16 D0 is
///         CLOSED. **No T-REX source is used, in whole or in part** — see the provenance note
///         on `IERC3643.sol` and `ERC-3643-CONFORMANCE.md`. The standard is free to implement;
///         Tokeny's GPL-3.0 implementation of it is not free to copy, and every engagement on
///         this suite is permissive or proprietary.
/// @dev    ⚠️ THE STANDARD IS THE DELIVERY VEHICLE, NOT THE REQUIREMENT, AND READING IT THE
///         OTHER WAY IS THE ERROR THIS NOTE EXISTS TO PREVENT. The §3 capability set is what
///         this file owes. `IERC3643` delivers C1, C5 and the wiring for C2/C3/C4. **It does
///         not deliver C6 or C7.** Nothing in §4–§10 of the design moved when the standard was
///         fixed — the standard-independence check exists to prove exactly that, and a rule
///         that appears or disappears here because of conformance is a defect.
/// @dev    ⚠️ THE CONFORMANCE CLAIM IS QUALIFIED. Full on `IERC3643`. **Declared deviation on
///         the identity registry** (person-keyed storage behind a wallet-keyed interface, and
///         two GDPR questions the standard answers in a direction the design does not concede).
///         **Do not write "ERC-3643 compliant" unqualified anywhere an NCA or an investor
///         reads it** — the token standard is a Prospectus Art 6 / 16(1) content item, so an
///         overstated claim is a defect in a disclosure document. Read
///         `ERC-3643-CONFORMANCE.md` first.
/// @dev    ⚠️ C6 (PARTITIONS) IS NOT IN THIS FILE, AND CLOSING D0 DID NOT CHANGE THAT — IT
///         CONFIRMED IT. ERC-3643 has no partition model; under ERC-1400 partitions would have
///         come free from ERC-1410. So the ERC-1410-style tranche pattern stays CUSTOM work
///         and stays outside the standard. `DistributionWaterfall` shows the shape a tranched
///         instrument needs. **This token is ERC-3643-BASED, not ERC-3643-ONLY**, and a reader
///         who assumes the standard delivered the §5 and §8 machinery will under-scope the
///         build by its largest custom component.
/// @dev    ⚠️ THERE IS NO ADAPTER SHAPE FOR THIS INTERFACE. Balances, the transfer path and the
///         compliance hook must share ONE contract. Wrapping a plain token in an `IERC3643`
///         facade splits `balanceOf` across two addresses, breaks every wallet and explorer
///         integration, and breaks the **DLT Pilot Art 5(2)** integrity-of-issue invariant —
///         the number of instruments recorded must equal the number in the issue at any given
///         time, which two contracts each holding part of the answer cannot guarantee.
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
///           • `recoveryAddress` runs the record-pointer match ONLY — no identity gate, no
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
/// @dev    ⚠️ `is IERC3643` IS LOAD-BEARING. It makes the COMPILER, not a reviewer, check that
///         every function and event the standard names is present with the exact signature.
///         A conformance suite that only reads the source can be satisfied by a lookalike; the
///         inheritance cannot. The companion test asserts selectors and — the half that is
///         usually forgotten — **fails when an UNDECLARED deviation appears**, i.e. when a
///         member of the EIP set is absent or altered and not listed in
///         `ERC-3643-CONFORMANCE.md`.
contract SecurityToken is IERC3643 {
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
    /// @dev ⚠️ TYPED ON THE **STANDARD'S** INTERFACES, NOT THE SUITE'S NARROW ONES, AND THE
    ///      DIRECTION MATTERS. `IERC3643` requires `compliance()` to return `ICompliance` and
    ///      `identityRegistry()` to return `IIdentityRegistry`; a public state variable of that
    ///      type IS that getter, so conformance is satisfied by the declaration rather than by
    ///      a hand-written shim that could drift. The suite's narrower, REVERTING surfaces —
    ///      `IComplianceGate.checkTransfer` and `IIdentityGate.checkEligible` — are reached
    ///      through `_rules()` and `_gate()` below.
    /// @dev ⚠️ THE TWO VIEWS MUST BE THE SAME ADDRESS, WHICH IS WHY THEY ARE NOT TWO VARIABLES.
    ///      Holding a separate `IIdentityGate` pointer would let a governance action re-point
    ///      one and not the other, so the registry the standard reports and the registry the
    ///      hook actually consults could differ — a conformant-looking token whose disclosed
    ///      identity layer is not the enforced one. One slot, two casts.
    /// @dev ⚠️ `override` IS LOAD-BEARING ON EVERY PUBLIC STATE VARIABLE THAT STANDS IN FOR AN
    ///      `IERC3643` GETTER — here, and on `name`, `symbol`, `decimals`, `onchainID`,
    ///      `totalSupply` and `paused`. The 0.8.8 relaxation that lets an implementing FUNCTION
    ///      drop the specifier does not extend to a public state variable overriding an external
    ///      function. Delete it and the contract stops compiling, which is the good failure; the
    ///      bad one is deleting the variable's `public` visibility instead, which silently
    ///      removes a mandated getter from a conformance claim that appears in a prospectus.
    ICompliance public override compliance;
    IIdentityRegistry public override identityRegistry;

    /// @dev The suite-internal, reverting view of the same two contracts. `ModularCompliance`
    ///      and `IdentityRegistry` each implement both faces; these casts are what make the
    ///      reverting path reachable without a second storage slot to keep in sync.
    function _rules() internal view returns (IComplianceGate) {
        return IComplianceGate(address(compliance));
    }

    function _gate() internal view returns (IIdentityGate) {
        return IIdentityGate(address(identityRegistry));
    }

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
    ///         PATHS ONLY. `forcedTransfer` and `recoveryAddress` execute during a protocol pause
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

    string public override name;
    string public override symbol;
    uint8 public immutable override decimals;

    /// @notice The issuer's own on-chain identity, per `IERC3643.onchainID()`.
    /// @dev    ⚠️ THIS IS THE **ISSUER'S** IDENTITY, NOT AN INVESTOR'S, AND IT DOES NOT CARRY
    ///         THE D19 PROBLEM. An issuer is a legal person, and **GDPR does not apply to legal
    ///         persons (Recital 14)** — so a permanent, unique on-chain identifier for the
    ///         issuing entity raises none of the erasure or linkability objections that make the
    ///         per-INVESTOR identity contract a DPO decision. Setting this is safe; do not read
    ///         it as D19 having been resolved by the back door.
    /// @dev    May be `address(0)` before the issuer's identity is deployed. The standard
    ///         permits it and nothing in this contract dereferences it.
    address public override onchainID;

    /// @notice Implementation version string, per `IERC3643.version()`.
    /// @dev    ⚠️ THE STANDARD'S VERSION, NOT THE INSTRUMENT'S. A venue reads this to decide
    ///         which interface revision it is talking to. The instrument's own terms are
    ///         versioned in `DocumentRegistry`, where a new version opens a Prospectus Art 23
    ///         withdrawal window — two different clocks, and confusing them would tie an
    ///         interface upgrade to an investor withdrawal right.
    /// @dev    Written as a function rather than a `public constant` so the generated
    ///         mutability cannot drift from the interface's `view` and quietly fail conformance.
    function version() external pure returns (string memory) {
        return "1.0.0";
    }

    /// @notice The instrument's ISIN, as a hash. Not decorative: MiFIR Art 26 transaction
    ///         reports and RTS 1/2 transparency publications are keyed on it, and
    ///         `MarketEventSchema` emits it. Stored as a hash so the on-chain record cannot
    ///         drift from the reference-data record it must match.
    bytes32 public immutable isinHash;

    uint256 public override totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    /// @notice PARTIAL freeze — units immobilised while the wallet stays otherwise live.
    /// @dev    ⚠️ A partial freeze and a whole-wallet freeze are different controls and both
    ///         are needed. An AMLR asset freeze on a specific tranche, or a court order over a
    ///         disputed holding, must not stop the holder dealing with the rest — and a
    ///         sanctions designation must stop everything. Modelling only the second forces the
    ///         operator to over-freeze, which is itself a legal exposure to the holder.
    /// @dev    `getFrozenTokens()` is the standard's name for this read. The mapping stays
    ///         public because operator tooling and the holder's own UI both read it.
    mapping(address => uint256) public frozenUnits;

    /// @notice WHOLE-ADDRESS freeze — `IERC3643.setAddressFrozen` / `isFrozen`.
    /// @dev    ⚠️ THIS IS THE **OPERATIONAL** WALLET FREEZE. IT IS **NOT** THE SANCTIONS STOP,
    ///         AND THE DISTINCTION IS THE ONE MOST LIKELY TO BE LOST WHEN SOMEBODY READS THE
    ///         STANDARD WITHOUT READING THIS SUITE. A sanctions listing, an AMLR Art 75
    ///         suspicion block, a probate hold or a court attachment lives in
    ///         `RestrictedPartyRegistry`, is keyed by **person** so it follows the human across
    ///         every wallet they hold, and is read in the MANDATORY layer above the module list.
    ///         This flag is keyed by **address**, is set by an agent, and is for the operational
    ///         cases the standard was written for — a disputed key, a pending re-verification,
    ///         an account the desk has stopped. **An agent who uses this for a sanctions
    ///         designation has applied it to one address of a person who may hold five.**
    /// @dev    ⚠️ AND IT REBUILDS A LEAK THE SUITE SPENT A REVISION CLOSING, WHICH IS WHY THE
    ///         DISTINCTION ABOVE IS AN OPERATING RULE AND NOT A PREFERENCE. `isFrozen` is a
    ///         public, wallet-level, readable stop that lives OUTSIDE the restriction store. Two
    ///         stores that can each halt a wallet let an observer read WHICH one holds a person
    ///         out of public storage and infer the class, whatever the revert says — exactly the
    ///         defect that consolidated every stop into `RestrictedPartyRegistry`. The flag is
    ///         implemented because the standard requires it and venue tooling calls it; the
    ///         mitigation is procedural and unenforceable on-chain: **generic operational stops
    ///         only, never a stop whose reason is a person.** Recorded in
    ///         `ERC-3643-CONFORMANCE.md` as a residual, not as a solved problem.
    mapping(address => bool) private _addressFrozen;

    /// @notice Whole-instrument halt. Distinct from `ModularCompliance.emergencyBypass`, which
    ///         runs the token WITHOUT a rule; this stops the token entirely. Under DLT Pilot
    ///         Art 7(5) an operator must be able to do both, and must be able to say which one
    ///         it did. Also distinct from `protocolPause` — that is the platform-wide halt the
    ///         governor sets; this is the per-instrument one an agent sets. `whenLive` reads
    ///         both.
    bool public override paused;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS
    // ═══════════════════════════════════════════════════════════════════════

    // ── EIP-3643 events. Names, parameter order and indexing are NORMATIVE. ────
    //
    // ⚠️ `Transfer`, `Approval`, `ComplianceAdded`, `IdentityRegistryAdded`, `Paused`,
    //    `Unpaused`, `AddressFrozen`, `TokensFrozen`, `TokensUnfrozen`,
    //    `UpdatedTokenInformation` and `RecoverySuccess` are all declared on `IERC3643` and
    //    INHERITED, never re-declared here. A local copy with one field reordered compiles
    //    fine and silently breaks every indexer built against the standard — which is the
    //    entire value the standard was adopted for.

    /// @notice ⚠️ NO REASON FIELD, unlike the reason-carrying supplements below. Which store is
    ///         wired is an operational fact; who is in it is not this contract's to announce.
    event RestrictionsSet(address indexed restrictions);
    event ProtocolPauseChanged(address indexed previous, address indexed current);
    event AgentSet(address indexed agent, bool allowed);

    // ── suite supplements. IN ADDITION to the standard's events, never instead of. ──
    //
    // ⚠️ EVERY ONE OF THESE EXISTS BECAUSE THE STANDARD'S EVENT DROPS A FACT A SUPERVISOR
    //    NEEDS, AND NONE OF THEM MAY CARRY THE FACT IN CLEAR. `IERC3643.Paused(address)` says
    //    who halted the token and not why; `AddressFrozen` says a wallet was stopped and not
    //    on what authority; `Transfer` cannot distinguish a voluntary movement from a seizure.
    //    Under DLT Pilot Art 7(6) and DORA Art 18 the operator has to be able to answer all
    //    three. So each supplement carries a `reasonHash` — a pointer into the off-chain
    //    incident record, never the reason itself. A human-readable "sanctions hit" in a public
    //    log is simultaneously an **AMLR Art 76** tipping-off disclosure and an un-erasable
    //    personal datum about an identified person, and no retention policy reaches a log.

    event PauseReason(bytes32 reasonHash, uint64 at);
    event AddressFrozenReason(address indexed wallet, bool frozen, bytes32 reasonHash);
    event UnitsFrozenReason(address indexed wallet, uint256 amount, bytes32 reasonHash);

    /// @dev Deliberately a SEPARATE event from `Transfer`, in addition to it — never instead of
    ///      it. A forced transfer is an ordinary balance movement for accounting purposes and
    ///      an extraordinary act for supervisory purposes, and an NCA reviewer asking "which
    ///      movements were involuntary" must not have to infer it from the sender.
    /// @dev ⚠️ THE STANDARD HAS NO EQUIVALENT, which is worth stating because its absence looks
    ///      like an oversight in `IERC3643` rather than a gap this suite fills. A conforming
    ///      token emits only `Transfer` on a forced move.
    event ForcedTransfer(address indexed from, address indexed to, uint256 value, bytes32 reasonHash);

    /// @dev ⚠️ THE ONE DELIBERATE EXCEPTION TO THE EVENT-PAYLOAD RULE, AND EIP-3643 MAKES IT
    ///      WORSE RATHER THAN BETTER. This event permanently and publicly links two wallets of
    ///      ONE person — kept because that linkage is the audit fact AMLR traceability and the
    ///      §13 map both need, and because a recovery that cannot be reconstructed is worse.
    ///      The standard's own `RecoverySuccess` carries the same two wallets **plus the
    ///      investor's on-chain identity**, so a conforming recovery puts a THIRD per-person
    ///      identifier in the same log entry and in the same calldata. See `recoveryAddress`.
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
    /// @dev ⚠️ GENERIC-CLASS ON PURPOSE, AND IT IS THE ONE ERROR ON THIS CONTRACT THAT IS.
    ///      `setAddressFrozen` is reserved for operational stops, but the suite cannot enforce
    ///      that an agent obeyed the rule — so the revert must be safe for the case where they
    ///      did not. No address argument: on a two-sided check, naming the side is the
    ///      disclosure. AMLR Art 76.
    error AddressIsFrozen();
    /// @dev Batch arity. Informative-class — a caller's own input error, disclosing nothing.
    error BatchLengthMismatch(uint256 lenA, uint256 lenB);
    /// @dev ⚠️ A cap on batch size, because an unbounded batch is a gas-limit denial of service
    ///      on the operations desk's own recovery path. Every entry runs the full hook.
    error BatchTooLarge(uint256 length, uint256 maximum);
    /// @dev A forced transfer or a recovery from a wallet to itself moves nothing and would
    ///      still emit `ForcedTransfer` / `WalletRecovered` — an audit-trail entry for an act
    ///      that did not happen. Refused outright.
    error SameWallet(address wallet);
    /// @dev ⚠️ GENERIC-CLASS, AND THE FALLBACK RATHER THAN THE NORM. Reached only when the
    ///      compliance contract's boolean gate says no and its reverting gate does not say why
    ///      — either because the wired contract implements only `ICompliance`, or because the
    ///      two disagree. Argument-free for the same AMLR Art 76 reason as `AddressIsFrozen`:
    ///      the reason a specific person cannot transfer is not a fact for a public ledger.
    error TransferNotCompliant();

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
        identityRegistry = IIdentityRegistry(identity_);
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
        identityRegistry = IIdentityRegistry(identity_);
        emit IdentityRegistryAdded(identity_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // TOKEN INFORMATION — `IERC3643` administration
    // ═══════════════════════════════════════════════════════════════════════
    //
    // ⚠️ THE STANDARD LETS AN OPERATOR RENAME A LIVE SECURITY, AND THAT IS A REGULATORY ACT
    //    WEARING A COSMETIC ONE'S CLOTHES. The name and symbol of an admitted instrument are
    //    reference data a venue, an ARM and a consolidated tape all key on, and the instrument's
    //    designation is a Prospectus Art 6 / 16(1) disclosure item. So these are GOVERNANCE, not
    //    agent, and the `UpdatedTokenInformation` event is the audit entry. **`isinHash` is
    //    deliberately NOT settable by any of them** — the ISIN is what the reporting bridges
    //    join on, and a mutable one silently orphans every historical transaction report.

    function setName(string calldata name_) external onlyGovernance {
        name = name_;
        emit UpdatedTokenInformation(name, symbol, decimals, this.version(), onchainID);
    }

    function setSymbol(string calldata symbol_) external onlyGovernance {
        symbol = symbol_;
        emit UpdatedTokenInformation(name, symbol, decimals, this.version(), onchainID);
    }

    /// @notice Point the token at the ISSUER'S on-chain identity.
    /// @dev    ⚠️ The issuer is a legal person and **GDPR does not apply to legal persons
    ///         (Recital 14)**, so this raises none of the D19 objections that make the
    ///         per-investor identity contract a DPO decision. Do not read a resolution of D19
    ///         into the fact that this setter exists.
    function setOnchainID(address onchainID_) external onlyGovernance {
        onchainID = onchainID_;
        emit UpdatedTokenInformation(name, symbol, decimals, this.version(), onchainID);
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

    /// @notice Halt the instrument. `IERC3643.pause()` — conformant signature, no arguments.
    /// @dev    ⚠️ THE STANDARD'S SIGNATURE TAKES NO REASON, AND A HALT WITH NO RECORDED REASON
    ///         IS NOT ACCEPTABLE UNDER **DLT Pilot Art 7(5)–(6)** OR **DORA Art 18** — the
    ///         operator must be able to say which control it used and why, and a supervisor
    ///         asking after the fact will not accept "the interface had no field". So both
    ///         exist: this one for conformance and for tooling that calls the standard, and
    ///         `pauseWithReason` for the operations desk, which is the one an internal
    ///         procedure must name. Both emit the standard's `Paused(msg.sender)`; only the
    ///         second adds `PauseReason`.
    /// @dev    ⚠️ Calling this bare leaves a halt on the record with no incident pointer. That
    ///         is a procedural failure the contract cannot prevent and will not pretend to.
    function pause() external onlyAgent {
        paused = true;
        emit Paused(msg.sender);
    }

    /// @notice The form the operations desk uses. `reasonHash` points at the off-chain incident
    ///         record — never the reason itself (AMLR Art 76, GDPR).
    function pauseWithReason(bytes32 reasonHash) external onlyAgent {
        paused = true;
        emit Paused(msg.sender);
        emit PauseReason(reasonHash, uint64(block.timestamp));
    }

    /// @dev ⚠️ GOVERNANCE, NOT AGENT, AND THE ASYMMETRY WITH `pause` IS DELIBERATE. An agent
    ///      who can halt and resume can paper over an incident inside one block. The standard
    ///      says nothing about which role holds either; under **DORA Art 5** halting is an
    ///      operational act and resuming is an accountability one.
    function unpause() external onlyGovernance {
        paused = false;
        emit Unpaused(msg.sender);
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
    ///      is normally in the module list too. `_assertCompliant` runs a list governance
    ///      can shorten; this line runs whatever happens. Both reach the same store and the same
    ///      argument-free error, so the redundancy is a cost, not a disclosure.
    /// @dev ⚠️ `assertTransferPermitted` HANDLES BOTH SIDES ITSELF, including `address(0)`, and
    ///      is deliberately NOT split into two guarded calls the way the identity reads are. A
    ///      redemption paying out to a listed person releases value exactly as a transfer does,
    ///      so `to == 0` is not a shortcut out of the sender check.
    /// @dev ⚠️ THE WHOLE-ADDRESS FREEZE IS READ HERE, ON BOTH SIDES, AND IT IS PART OF THE
    ///      MANDATORY LAYER RATHER THAN A MODULE. `IERC3643` requires a frozen address to be
    ///      unable to transfer; a frozen address must equally be unable to RECEIVE, or the
    ///      freeze is a one-way valve an agent can be walked around by having the counterparty
    ///      push instead of pull. The standard does not say which; this suite reads both.
    ///      One generic error for either side — naming the side is the disclosure.
    function _check(address from, address to, uint256 amount) internal view {
        if (from != address(0) && _addressFrozen[from]) revert AddressIsFrozen();
        if (to != address(0) && _addressFrozen[to]) revert AddressIsFrozen();
        if (from != address(0)) _gate().checkEligible(from);
        if (to != address(0)) _gate().checkEligible(to);
        restrictions.assertTransferPermitted(from, to);
        _assertCompliant(from, to, amount);
    }

    /// @dev ⚠️ THE STANDARD'S GATE IS THE ONE THAT DECIDES; the suite's gate only supplies the
    ///      REASON. An earlier draft called `_rules().checkTransfer` directly and left
    ///      `canTransfer` as an unused read, which would have made §3a's "C1 binds to
    ///      `ICompliance.canTransfer`" a claim the code did not honour — and would have made
    ///      the token unwireable to any compliance contract implementing only the EIP.
    /// @dev The boolean is authoritative. It is also, by its own shape, reason-opaque, which is
    ///      the AMLR Art 76 limb of C1 satisfied BY the interface rather than beside it.
    function _assertCompliant(address from, address to, uint256 amount) internal view {
        if (compliance.canTransfer(from, to, amount)) return;

        // Re-run the suite's reverting gate so the holder gets the failing module's own error —
        // an unlock date or an Article, where the module's class permits it — instead of a bare
        // `false`. `IComplianceGate` is a superset of `ICompliance`; where a plain `ICompliance`
        // is wired this selector does not exist and the call reverts empty, which is a generic
        // stop and the most the standard's shape can say. That is a downgrade in explanation,
        // never in enforcement.
        _rules().checkTransfer(from, to, amount);

        // Reached only if the two gates disagree. The boolean wins, and it said no.
        revert TransferNotCompliant();
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
        _notify(from, to, amount);
    }

    /// @dev ⚠️ EXACTLY ONE NOTIFICATION PER MOVEMENT, AND IT IS THE STANDARD'S. An earlier
    ///      draft of this function called `_rules().notifyTransfer` AND the standard's trio,
    ///      on the reasoning that the two faces were different. They are not: both land on the
    ///      same contract, and `ModularCompliance` routes the trio into the same module fan-out
    ///      `notifyTransfer` performs. Calling both DOUBLE-ADVANCES every counter-keeping
    ///      module — `EltifConcentration` would book each transfer twice and breach a limit
    ///      that was never breached. Recorded because the bug was reasoned into existence, not
    ///      typed into it.
    /// @dev `IERC3643` splits the notification by movement type; the suite's `notifyTransfer`
    ///      passes mint as `from == 0` and burn as `to == 0` and lets each module decide
    ///      whether it cares. The standard's shape is the conformant one and is what a
    ///      third-party module written against the EIP listens for, so the token speaks it and
    ///      the compliance contract does the translation. `notifyTransfer` survives as
    ///      `ModularCompliance`'s internal fan-out; nothing calls it from here.
    function _notify(address from, address to, uint256 amount) internal {
        if (from == address(0)) {
            compliance.created(to, amount);
        } else if (to == address(0)) {
            compliance.destroyed(from, amount);
        } else {
            compliance.transferred(from, to, amount);
        }
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
        _voluntaryTransfer(msg.sender, to, amount);
        return true;
    }

    /// @dev ⚠️ EXISTS SO `batchTransfer` CAN REUSE THE PATH WITHOUT `this.transfer(...)`.
    ///      An external self-call would make the TOKEN the sender, so a batch would move the
    ///      token contract's own balance instead of the caller's — a silently wrong transfer,
    ///      not a revert. Worth the extra function.
    function _voluntaryTransfer(address from, address to, uint256 amount) internal {
        if (to == address(0)) revert ZeroAddress();
        _requireSpendable(from, amount);
        _move(from, to, amount);
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
    function mint(address to, uint256 amount) public onlyAgent whenLive {
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
    function burn(address from, uint256 amount) public onlyAgent whenLive {
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
    /// @dev ⚠️ RENAMED FROM `freezeUnits` FOR CONFORMANCE. `IERC3643.freezePartialTokens` is the
    ///      standard's name for exactly this control, and the standard's name for it is better
    ///      than ours was: "partial" is the property the operating rule above turns on.
    function freezePartialTokens(address wallet, uint256 amount) public onlyAgent {
        uint256 wouldFreeze = frozenUnits[wallet] + amount;
        if (wouldFreeze > _balances[wallet]) revert FrozenExceedsBalance(wallet, _balances[wallet], wouldFreeze);

        frozenUnits[wallet] = wouldFreeze;
        emit TokensFrozen(wallet, amount);
    }

    /// @notice The form the operations desk uses — carries the incident pointer the standard's
    ///         signature has nowhere to put.
    function freezePartialTokensWithReason(address wallet, uint256 amount, bytes32 reasonHash) external onlyAgent {
        freezePartialTokens(wallet, amount);
        emit UnitsFrozenReason(wallet, amount, reasonHash);
    }

    function unfreezePartialTokens(address wallet, uint256 amount) public onlyAgent {
        uint256 frozen = frozenUnits[wallet];
        if (frozen < amount) revert NotFrozenByThatMuch(wallet, frozen, amount);

        frozenUnits[wallet] = frozen - amount;
        emit TokensUnfrozen(wallet, amount);
    }

    /// @notice WHOLE-ADDRESS freeze. `IERC3643.setAddressFrozen`.
    /// @dev    ⚠️ OPERATIONAL STOPS ONLY. A sanctions listing, an AMLR Art 75 suspicion block, a
    ///         probate hold or a court attachment goes in `RestrictedPartyRegistry`, which is
    ///         keyed by PERSON and therefore follows the human across every wallet they hold.
    ///         This flag stops ONE address. An agent who designates a sanctions target here has
    ///         stopped one of five wallets and left four open — and has additionally written a
    ///         publicly readable, wallet-level stop outside the consolidated store, from which
    ///         an observer can infer the class. **Neither consequence is enforceable on-chain;
    ///         both are why this NatSpec is as long as it is.**
    /// @dev    ⚠️ NOT `whenLive`, matching every other C5 control. A freeze during a halt is
    ///         exactly when a freeze is most likely to be needed.
    /// @dev    The standard's `AddressFrozen` carries `_owner` — here `msg.sender`, the agent
    ///         who acted. That is the accountability half of **DORA Art 5**; the reason half is
    ///         `setAddressFrozenWithReason`.
    function setAddressFrozen(address wallet, bool freeze) public onlyAgent {
        _addressFrozen[wallet] = freeze;
        emit AddressFrozen(wallet, freeze, msg.sender);
    }

    function setAddressFrozenWithReason(address wallet, bool freeze, bytes32 reasonHash) external onlyAgent {
        setAddressFrozen(wallet, freeze);
        emit AddressFrozenReason(wallet, freeze, reasonHash);
    }

    /// @notice `IERC3643.isFrozen` — whole-address stop only.
    /// @dev    ⚠️ DOES **NOT** ANSWER "MAY THIS WALLET TRANSFER". It reads one of four
    ///         independent stops: this flag, `frozenUnits` (partial), `RestrictedPartyRegistry`
    ///         (person-scoped, opaque) and the two pauses. A UI that gates on this alone will
    ///         tell a restricted holder they are free to trade. `canTransfer` is the question
    ///         worth asking, and it is the only one that runs the whole gate.
    function isFrozen(address wallet) external view returns (bool) {
        return _addressFrozen[wallet];
    }

    /// @notice `IERC3643.getFrozenTokens` — the partial-freeze counter.
    function getFrozenTokens(address wallet) external view returns (uint256) {
        return frozenUnits[wallet];
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
    ///             function relied on `RestrictedPartyGate` inside the compliance gate
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
    ///             `_assertCompliant(from, to, amount)` reaches the module list and so `HoldingPeriodGate`
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
    /// @dev ⚠️ THE SENDER'S WHOLE-ADDRESS FREEZE IS BYPASSED HERE, LIKE THE PARTIAL ONE. Both
    ///      are the operator's own controls, and an operator cannot cite its own freeze as the
    ///      reason it could not execute a court order. **The RECIPIENT'S freeze is NOT
    ///      bypassed** — forcing units into a stopped wallet would make this function the route
    ///      around every freeze on the token.
    /// @dev ⚠️ `IERC3643` GIVES THIS SIGNATURE NO REASON FIELD AND A `bool` RETURN. The
    ///      conformant form is here; `forcedTransferWithReason` is the one an operations
    ///      procedure must name, because a seizure with no incident pointer is not defensible
    ///      under **DLT Pilot Art 7(6)**.
    function forcedTransfer(address from, address to, uint256 amount) public onlyAgent returns (bool) {
        if (to == address(0)) revert ZeroAddress();
        if (from == to) revert SameWallet(from);
        if (_addressFrozen[to]) revert AddressIsFrozen();

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
        _gate().checkEligible(to);
        _assertCompliant(from, to, amount);

        _balances[from] -= amount;
        _balances[to] += amount;

        emit Transfer(from, to, amount);
        _notify(from, to, amount);
        return true;
    }

    /// @notice The form the operations desk uses. Same gate, plus the incident pointer.
    function forcedTransferWithReason(
        address from,
        address to,
        uint256 amount,
        bytes32 reasonHash
    ) external onlyAgent returns (bool) {
        forcedTransfer(from, to, amount);
        emit ForcedTransfer(from, to, amount, reasonHash);
        return true;
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
    /// @dev ⚠️ THE THIRD ARGUMENT IS THE STANDARD'S, AND WHAT IT SHOULD CONTAIN IS AN OPEN
    ///      DECISION (design §16 D19), SO THIS FUNCTION DOES NOT DEREFERENCE IT.
    ///      `_investorOnchainID` is checked for CONSISTENCY against what the registry reports
    ///      for the lost wallet and is otherwise unused — the `personId` match below is the
    ///      control, not this. Treating the caller's third argument as authority would make
    ///      recovery an agent-key licence to move any holding anywhere, which is precisely what
    ///      the record-pointer match exists to prevent. **If D19 later resolves to deploying a
    ///      per-person identity contract, this check becomes stronger; it does not become the
    ///      control.**
    /// @dev ⚠️ AND IT PUTS A SECOND PER-PERSON IDENTIFIER IN THE CALLDATA OF THE ONE CALL THE
    ///      SUITE ALREADY TREATS AS A DELIBERATE PRIVACY EXCEPTION. `WalletRecovered` and the
    ///      standard's `RecoverySuccess` both permanently link two wallets of one person — kept
    ///      because that linkage is the audit fact AMLR traceability needs. The standard adds
    ///      the investor's identity to the same entry, and §10's standing rule is that calldata
    ///      is a log for this purpose. **This is a DPO question, not a spec-time one**, and it
    ///      is listed as a residual in `ERC-3643-CONFORMANCE.md` rather than mitigated here.
    function recoveryAddress(
        address lostWallet,
        address newWallet,
        address _investorOnchainID
    ) public onlyAgent returns (bool) {
        if (newWallet == address(0)) revert ZeroAddress();
        if (lostWallet == newWallet) revert SameWallet(lostWallet);

        // ⚠️ The control that makes recovery safe is the `personId` match, not the agent
        // role and not the caller-supplied identity. Both wallets must resolve to the SAME
        // off-chain investor record — without that, "recovery" is an agent-key licence to move
        // any holding to any wallet.
        (bytes32 lostPersonId, ) = _gate().personIdOf(lostWallet);
        (bytes32 newPersonId, bool newRegistered) = _gate().personIdOf(newWallet);

        if (!newRegistered) revert RecoveryTargetHasNoRecord(newWallet);
        if (newPersonId == bytes32(0) || newPersonId != lostPersonId) {
            revert RecoveryTargetNotSameInvestor(lostWallet, newWallet);
        }

        // Consistency only. A caller passing `address(0)` is accepted — see D19 option (b) —
        // and a caller passing a mismatch is refused, because a wrong identity in the audit
        // trail is worse than an absent one.
        if (_investorOnchainID != address(0)) {
            address registryIdentity = address(identityRegistry.identity(lostWallet));
            if (registryIdentity != address(0) && registryIdentity != _investorOnchainID) {
                revert RecoveryTargetNotSameInvestor(lostWallet, newWallet);
            }
        }

        uint256 bal = _balances[lostWallet];
        if (bal == 0) revert NothingToRecover(lostWallet);

        uint256 frozen = frozenUnits[lostWallet];

        _balances[lostWallet] = 0;
        frozenUnits[lostWallet] = 0;
        _balances[newWallet] += bal;
        frozenUnits[newWallet] += frozen;

        // ⚠️ THE WHOLE-ADDRESS FREEZE FOLLOWS THE UNITS, for the same reason the partial one
        // does: recovering into a clean wallet must not launder a stop. The standard says
        // nothing about this, and a conforming implementation that dropped the flag would turn
        // "I lost my key" into a freeze-removal procedure.
        if (_addressFrozen[lostWallet]) {
            _addressFrozen[newWallet] = true;
            emit AddressFrozen(newWallet, true, msg.sender);
        }

        emit Transfer(lostWallet, newWallet, bal);
        emit RecoverySuccess(lostWallet, newWallet, _investorOnchainID);
        _notify(lostWallet, newWallet, bal);
        return true;
    }

    /// @notice The form the operations desk uses. Same control, plus the incident pointer and
    ///         the recovered amount the standard's `RecoverySuccess` does not carry.
    function recoveryAddressWithReason(
        address lostWallet,
        address newWallet,
        address investorOnchainID,
        bytes32 reasonHash
    ) external onlyAgent returns (bool) {
        uint256 bal = _balances[lostWallet];
        recoveryAddress(lostWallet, newWallet, investorOnchainID);
        emit WalletRecovered(lostWallet, newWallet, bal, reasonHash);
        return true;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // BATCH FUNCTIONS — `IERC3643`
    // ═══════════════════════════════════════════════════════════════════════
    //
    // ⚠️ EVERY ENTRY RUNS THE SAME FULL GATE AS ITS SINGLE-CALL EQUIVALENT, AND THE MOMENT ONE
    //    OF THESE SHORT-CUTS THE HOOK "FOR GAS", THAT LOOP IS THE BYPASS. They are loops over
    //    the public functions, deliberately, rather than re-implementations that share an
    //    internal path — a re-implementation is where the missing check ends up.
    //
    // ⚠️ AND THEY ARE ATOMIC, WHICH IS THE RIGHT CHOICE AND AN OPERATIONALLY AWKWARD ONE. One
    //    ineligible recipient reverts a hundred-entry issuance run. The alternative — skipping
    //    failures and reporting them — means a mint batch that partially executed, which is a
    //    **DLT Pilot Art 5(2)** integrity-of-issue problem: the register and the issue would
    //    disagree until someone reconciled them by hand. `DistributionAgent` skips rather than
    //    reverts on the PAYOUT side, where the same reasoning runs the other way.

    uint256 public constant MAX_BATCH = 100;

    function _requireBatch(uint256 lenA, uint256 lenB) internal pure {
        if (lenA != lenB) revert BatchLengthMismatch(lenA, lenB);
        if (lenA > MAX_BATCH) revert BatchTooLarge(lenA, MAX_BATCH);
    }

    function batchTransfer(address[] calldata toList, uint256[] calldata amounts) external whenLive {
        _requireBatch(toList.length, amounts.length);
        for (uint256 i = 0; i < toList.length; i++) {
            _voluntaryTransfer(msg.sender, toList[i], amounts[i]);
        }
    }

    function batchForcedTransfer(
        address[] calldata fromList,
        address[] calldata toList,
        uint256[] calldata amounts
    ) external onlyAgent {
        _requireBatch(fromList.length, toList.length);
        _requireBatch(toList.length, amounts.length);
        for (uint256 i = 0; i < fromList.length; i++) {
            forcedTransfer(fromList[i], toList[i], amounts[i]);
        }
    }

    function batchMint(address[] calldata toList, uint256[] calldata amounts) external onlyAgent {
        _requireBatch(toList.length, amounts.length);
        for (uint256 i = 0; i < toList.length; i++) {
            mint(toList[i], amounts[i]);
        }
    }

    function batchBurn(address[] calldata userAddresses, uint256[] calldata amounts) external onlyAgent {
        _requireBatch(userAddresses.length, amounts.length);
        for (uint256 i = 0; i < userAddresses.length; i++) {
            burn(userAddresses[i], amounts[i]);
        }
    }

    function batchSetAddressFrozen(address[] calldata userAddresses, bool[] calldata freeze) external onlyAgent {
        _requireBatch(userAddresses.length, freeze.length);
        for (uint256 i = 0; i < userAddresses.length; i++) {
            setAddressFrozen(userAddresses[i], freeze[i]);
        }
    }

    function batchFreezePartialTokens(
        address[] calldata userAddresses,
        uint256[] calldata amounts
    ) external onlyAgent {
        _requireBatch(userAddresses.length, amounts.length);
        for (uint256 i = 0; i < userAddresses.length; i++) {
            freezePartialTokens(userAddresses[i], amounts[i]);
        }
    }

    function batchUnfreezePartialTokens(
        address[] calldata userAddresses,
        uint256[] calldata amounts
    ) external onlyAgent {
        _requireBatch(userAddresses.length, amounts.length);
        for (uint256 i = 0; i < userAddresses.length; i++) {
            unfreezePartialTokens(userAddresses[i], amounts[i]);
        }
    }
}
