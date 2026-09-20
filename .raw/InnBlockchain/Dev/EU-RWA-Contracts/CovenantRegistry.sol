// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ModuleAdapter} from "./ModularCompliance.sol";
import {IDocumentAnchor, IErasable, IIdentityGate} from "./Interfaces.sol";

/// @title CovenantRegistry (illustrative sample — not production code)
/// @notice C7 — the store of what the INVESTOR THEMSELVES has stated, agreed or acknowledged,
///         with a predicate deciding who owes what. Six obligations across five regimes route
///         through it: PRIIPs Art 13 · DLT Pilot Arts 4(2)(c)–(f) and 4(2)(g) · MAR Art 19(5)
///         and Art 18 · ELTIF Arts 18(3) and 26. Before this contract each was modelled
///         separately, and two carried a boolean defect.
/// @dev    ⚠️ NO COVENANT IS HARDCODED, AND `covenantId` IS NEVER AN ENUM. The registry knows
///         HOW a covenant behaves; it must not know WHICH covenants exist. An enum would make
///         every new regime, client requirement or national-law overlay a redeploy — and
///         § Scope item 4 defers national electronic-securities law to a separate
///         jurisdiction-specific design that must PAIR with this one. A pairing only works if
///         the socket already exists. The requirement is therefore explicit: adding a national
///         covenant must cost a configuration transaction, never a contract change, a schema
///         change or a redeploy. If any national covenant needs an eighth field, this schema
///         is wrong.
/// @dev    ⚠️ C7 IS NOT C3, AND THE DIFFERENCE IS NOT COSMETIC. A CLAIM is an attestation
///         ABOUT the investor, written by a trusted third party, revoked by its issuer,
///         platform-wide. A COVENANT is a statement BY the investor, sometimes requiring their
///         own signature, invalidated by a DOCUMENT, and often per-asset. Encoding covenants
///         as claim topics fails both available ways: a topic per version
///         (`KID_v3_delivered`) needs a governance transaction on every asset's required-topic
///         set at every revision — miss one and the stale topic still passes, fail-open — and
///         a version inside claim data rebuilds this contract inside the identity registry
///         with none of the gate or attestor semantics.
/// @dev    ⚠️ GATES ARE A SET, AND NO TWO OF THE SIX OBLIGATIONS SHARE ONE. That is the
///         finding, not a detail:
///           PRIIPs Art 13          MINT ·      · RECEIVE(dealer sale)
///           DLT Pilot 4(2)(g)      MINT ·      · RECEIVE
///           DLT Pilot 4(2)(c)–(f)  MINT · SEND · RECEIVE   ← the one that binds the sender
///           MAR Art 19(5)               · SEND ·
///           ELTIF Art 18(3)        MINT ·      ·
///           ELTIF Art 26           MINT ·      · RECEIVE(dealer sale)
///         A store with one module-wide enforcement policy is wrong for at least four of them,
///         and a store that only gates TRANSFERS cannot express MAR Art 19(5) or ELTIF
///         Art 18(3) at all.
/// @dev    ⚠️ INVALIDATION IS A READ, NEVER A SWEEP. When `DocumentRegistry` anchors a new
///         version, outstanding acknowledgements against the old hash stop satisfying the gate
///         BY COMPARISON AT CHECK TIME. Iterating holders to revoke is unbounded gas and,
///         worse, a re-anchor that silently half-completes leaves a population that looks
///         compliant and is not.
/// @dev    ⚠️ THIS IS A STORE PLUS A PREDICATE — NOT A SECOND COMPLIANCE ENGINE. Rule
///         evaluation stays in `ModularCompliance` (C4), which is why the gate lives in
///         `CovenantGate` at the bottom of this file and not in here. Two contracts that can
///         independently veto a transfer for different reasons is how a reason code leaks from
///         the module that was supposed to stay silent.
/// @dev    GDPR: hash and reference only — never the document, never the signature payload,
///         never PII. The per-investor, per-version delivery evidence PRIIPs Art 13 requires
///         lives off-chain; what is on-chain is the provable pointer to it.
contract CovenantRegistry is IErasable {
    /// @dev Emitted whenever an inter-contract reference is re-pointed.
    event DependencySet(bytes32 indexed role, address indexed impl);

    // ═══════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════

    uint8 public constant GATE_MINT = 1;
    uint8 public constant GATE_SEND = 2;
    uint8 public constant GATE_RECEIVE = 4;

    enum Attestor {
        Unset,
        /// @dev MAR Art 19(5) is FORCED to this. No operator, oracle or KYC provider can know
        ///      who a director's closely associated persons are — only the director can.
        InvestorSignature,
        OperatorAttestation
    }

    enum Invalidation {
        /// @dev PRIIPs Art 10 — a revision invalidates. Not a clock.
        OnNewDocumentVersion,
        /// @dev AMLR Art 20 periodic refresh — a clock, regardless of any document.
        OnExpiry,
        Never
    }

    /// @dev Read by exactly one `require`: `setClassifier` refuses a `PerAsset` entry. Every
    ///      other covenant's scope is carried for the audit map and emitted, never branched on —
    ///      a per-asset registry deployment IS the scoping, so the field states it rather than
    ///      enforces it.
    enum Scope {
        PerAsset, // a KID is per-product
        PlatformWide // a venue risk-disclosure consent is satisfied once
    }

    enum Comparator {
        None, // dimension unused
        Equals,
        GreaterThan,
        LessThan
    }

    enum GrantPolarity {
        Ignore,
        /// @dev The covenant applies only where the grant IS held.
        RequiresGrant,
        /// @dev The covenant applies only where the grant is NOT held — ELTIF RTS Art 5(10),
        ///      where an NCA exemption REMOVES the Art 5(8)/5(9) information duty.
        RequiresNoGrant
    }

    /// @notice The `appliesTo` predicate — a CONJUNCTION over four dimensions, evaluated at the
    ///         gate. Not a flag, and never precomputed into a stored boolean.
    /// @dev    ELTIF Art 18(3) is `[RETAIL ONLY, life > 10 years]` in its own checklist — two
    ///         dimensions in one obligation. That single row is why this is a struct.
    struct Predicate {
        /// @dev ⚠️ WAS `uint8 tierMask`, HARDCODED TO MiFID. The dimension is now "a
        ///      classification on a named axis" — the nominated tier axis for MiFID, and whatever a second
        ///      regime opens for its own. `bytes32(0)` disables the dimension.
        ///      There is deliberately ONE axis slot and not an array: a list makes the gate's gas
        ///      unbounded and gives the evaluation nowhere to stop, and no obligation in any
        ///      checklist keys on two classification regimes at once.
        bytes32 classAxisId;
        /// @dev Bitmask over the axis's own encoding — for the tier axis, over `Tier`.
        ///      0 = every classification on that axis.
        uint8 classMask;
        /// @dev A SET, not a value. ⚠️ A covenant may apply across several Member States and an
        ///      investor may carry more than one relevant jurisdiction — residence, tax
        ///      residence, nationality. A single-value field on EITHER side collapses the case
        ///      that motivates the dimension. Empty = every jurisdiction.
        bytes32[] jurisdictions;
        /// @dev ⚠️ `IdentityRegistry` exposes ONE jurisdiction today (residence). Set this
        ///      where the entry genuinely keys on more than residence: the predicate then
        ///      reports UNEVALUABLE and fails closed, rather than silently matching on
        ///      residence alone and quietly narrowing the covenant.
        bool needsMultiJurisdiction;
        /// @dev Read from the per-asset offer configuration: fund life, open/closed-ended,
        ///      token type. `Comparator.None` disables the dimension.
        bytes32 productKey;
        Comparator productCmp;
        uint256 productValue;
        bytes32 grantId;
        GrantPolarity grantPolarity;
    }

    struct Covenant {
        bool configured;
        bool active;
        bytes32 documentRef; // 0 = binds no document (a pure declaration, e.g. MAR 19(5))
        uint8 gates; // any subset of MINT | SEND | RECEIVE
        Attestor attestor;
        Invalidation invalidation;
        uint64 expiryPeriod; // Invalidation.OnExpiry only
        Scope scope;
        uint64 effectiveFrom; // the cutover lever — see `configureCovenant`
        Predicate predicate;
    }

    /// @notice What the investor gave, and against which version. Four fields, no more.
    struct Record {
        bool given;
        bytes32 documentVersionHash; // 0 where the covenant binds no document
        Attestor attestorType; // what it was given AS, not what is required now
        uint64 timestamp;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ROLES & WIRING
    // ═══════════════════════════════════════════════════════════════════════

    address public immutable governance;

    /// @notice ⚠️ THE §2a STRADDLE, MADE CONCRETE. The predicate below is the only evaluation
    ///         in the design that reads across the platform-wide / per-asset boundary in a
    ///         single check: a PLATFORM-WIDE identity record and a PER-ASSET product attribute.
    ///         A per-asset covenant store cannot see the platform-wide tier; a platform-wide
    ///         one cannot see per-asset fund life. It needs both reads, which is why the
    ///         topology decision must resolve this contract as a straddle rather than by
    ///         picking a side.
    /// @dev    Interface-typed since 2026-09-08. The D19 exception ("concrete type retained
    ///         because `tierOf` returns an enum a narrow interface cannot declare") closed the
    ///         moment `Tier` was hoisted into `Interfaces.sol`; this contract now reads
    ///         `tierOf` / `jurisdictionOf` through `IIdentityGate` and imports nothing concrete.
    IIdentityGate public identity;

    /// @notice The fail-closed source of truth for document currency. `isCurrent` returns false
    ///         the instant a document is superseded — and, for a PRIIPs KID, also when its
    ///         Art 10 review is overdue.
    /// @dev    Interface-typed; `Version` and `Regime` live in `Interfaces.sol`, so the anchor
    ///         limb needs no concrete import either.
    IDocumentAnchor public documents;

    /// @notice Operators may attest `OperatorAttestation` covenants. They may NEVER satisfy an
    ///         `InvestorSignature` one — see `recordAttestation`.
    mapping(address => bool) public isOperator;

    /// @notice The `PersonErasure` coordinator, permitted to call `erasePerson` and nothing else.
    /// @dev    Separate from `isOperator` and from `governance` for the reason given in
    ///         `PersonErasure`: the desk that erases a declaration must not be the desk that can
    ///         write one. Zero disables the erasure path entirely.
    address public erasureCoordinator;

    /// @notice A covenant whose effect is to change the classification every OTHER predicate
    ///         reads — the MiFID II Annex II Section II opt-up is one, ECSPR's opt-in to
    ///         sophisticated is another. Named separately, resolved first, and evaluated against
    ///         the RAW classification rather than the one it produces.
    /// @dev    ⚠️ `electiveValue` AND `fallbackValue` ARE WHAT MADE THIS GENERALISABLE. The
    ///         single-axis version hardcoded both — `ProfessionalOnRequest` was the value that
    ///         required the covenant and `Retail` was where it fell back to. Those are MiFID
    ///         facts, not covenant facts, so they move into configuration.
    /// @dev    ⚠️ `fallbackValue` MUST BE THE MORE PROTECTIVE CLASSIFICATION, AND NOTHING ON
    ///         CHAIN CAN CHECK THAT. The contract cannot know which of two opaque `uint8`s a
    ///         regime considers safer, so this is the one field in the schema carrying a
    ///         semantic obligation the compiler will not enforce. Configure it backwards and an
    ///         investor with no record is PROMOTED instead of demoted, which inverts the control
    ///         rather than weakening it.
    struct Classifier {
        bytes32 covenantId;
        uint8 electiveValue;
        uint8 fallbackValue;
        bool set;
    }

    mapping(bytes32 => Classifier) public classifiers;

    /// @notice Every axis any configured covenant or classifier names.
    /// @dev    ⚠️ THIS EXISTS TO PRESERVE "RESOLVE ONCE PER WALLET", WHICH WAS FREE WHEN THERE
    ///         WAS ONE AXIS. `assertSatisfied` used to call `effectiveTier` once and pass the
    ///         result down through up to `MAX_COVENANTS` iterations. With covenants naming
    ///         different axes, the naive port re-resolves inside the loop — and resolving runs a
    ///         classifier covenant, so that is an identity read plus a predicate evaluation per
    ///         covenant per transfer. Instead every axis is resolved once into memory up front
    ///         and looked up by a scan bounded at `MAX_AXES`.
    uint256 public constant MAX_AXES = 8;

    bytes32[] private _axisIds;
    mapping(bytes32 => bool) public axisKnown;

    // ═══════════════════════════════════════════════════════════════════════
    // STATE
    // ═══════════════════════════════════════════════════════════════════════

    mapping(bytes32 => Covenant) private _covenants;
    bytes32[] private _covenantIds;

    /// @dev ⚠️ KEYED BY WALLET, NOT BY PERSON — AND UNLIKE THE NEIGHBOURING CONTRACTS THAT IS
    ///      CORRECT. `RestrictedPartyRegistry` and `MemberEligibility` both key on
    ///      `IdentityRegistry`'s `personId` because a block and an admission are owed by a
    ///      PERSON and an address-keyed version of either is bypassable by onboarding a second
    ///      address. A covenant is the opposite kind of thing: it is a statement the holder
    ///      MADE, from an address, against a named document version. Nobody makes it on their
    ///      behalf and it does not travel.
    ///
    ///      Person-keying here would be the actual defect. Art 4(2)(c)–(f) are negative
    ///      declarations that bind the SENDER on every transfer, and (g) is consent given
    ///      against one risk-disclosure version; inheriting any of them across a person's
    ///      wallets would let an address that has signed nothing trade on a declaration made
    ///      somewhere else — which is the same failure as the boolean-claim shape these were
    ///      moved here to escape.
    ///
    ///      The cost is real and it is accepted: a member's second wallet holds no record and
    ///      the gate blocks it until they re-declare, so lost-key recovery has to re-collect the
    ///      set rather than carry it over. That is friction in the fail-CLOSED direction — a
    ///      holder is stopped and asked to sign, not admitted on somebody else's signature.
    mapping(address => mapping(bytes32 => Record)) private _records;

    /// @notice Per-asset product attributes and regulatory grants — dimensions 3 and 4 of the
    ///         predicate.
    /// @dev    ⚠️ THESE BELONG TO THE OFFER CONFIGURATION, NOT TO THIS CONTRACT. In a real
    ///         deployment they are read from the per-asset offer configuration — the same
    ///         surface that already holds the Prospectus Art 12 validity date, "set at offer
    ///         configuration, extendable only by a governance action recording a new approval".
    ///         They are held here so the predicate reads end-to-end in one file. **No new
    ///         contract either way** — what must not happen is a second, divergent copy of the
    ///         fund's own terms.
    /// @dev    `isSet` is tracked separately from the value on purpose. An unconfigured
    ///         attribute and an attribute configured to zero are different facts, and
    ///         collapsing them is exactly the fail-open rule 5 exists to stop.
    mapping(bytes32 => uint256) private _productAttr;
    mapping(bytes32 => bool) private _productAttrSet;
    mapping(bytes32 => bool) private _grant;
    mapping(bytes32 => bool) private _grantSet;

    /// @notice ⚠️ Each gate iterates its applicable entries on the hot path. An unbounded set
    ///         is a gas-DoS surface on the token itself and a silent ceiling change the day
    ///         someone adds one covenant too many. One constant, read by everything that
    ///         iterates.
    uint256 public constant MAX_COVENANTS = 24;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS
    // ═══════════════════════════════════════════════════════════════════════

    event CovenantConfigured(
        bytes32 indexed covenantId, bytes32 indexed documentRef, uint8 gates, Attestor attestor, Scope scope
    );
    event CovenantDeactivated(bytes32 indexed covenantId);
    event ClassifierSet(bytes32 indexed axisId, bytes32 indexed covenantId, uint8 electiveValue, uint8 fallbackValue);
    event AxisTracked(bytes32 indexed axisId);
    event OperatorSet(address indexed operator, bool allowed);
    event ProductAttributeSet(bytes32 indexed key, uint256 value);
    event RegulatoryGrantSet(bytes32 indexed grantId, bool granted);

    /// @dev The trigger the PRIIPs Art 13 and MAR Art 19(5) audit trail is assembled FROM — not
    ///      the trail itself. The revert path is deliberately silent (see `Blocked`); the detail
    ///      lives in `recordOf(wallet, covenantId)`, and this event says only that a record was
    ///      written for this wallet at this block.
    /// @dev ⚠️ `covenantId` AND `documentVersionHash` REMOVED FROM THE LOG. A covenant is a
    ///      statement the investor makes about themselves — *I am not a market maker*, *I opt
    ///      up to professional*, *these are my closely associated persons* — and an indexed
    ///      `covenantId` against an indexed wallet published each of those as it was given,
    ///      permanently. That is the same defect `IdentityRegistry.ClaimSet` carried before
    ///      rev 50, in a different vocabulary: a claim is what a third party asserts about the
    ///      investor, a covenant is what the investor asserts, and both are attributes of the
    ///      person. `documentVersionHash` goes too, because each covenant binds one document,
    ///      so the version hash names the covenant by another route. `attestorType` stays —
    ///      it says who signed (investor or operator), which is a fact about the write path,
    ///      not about the person.
    event CovenantGiven(address indexed investor, Attestor attestorType);
    event ErasureCoordinatorSet(address indexed previous, address indexed current);
    /// @dev A count, not a list. Which covenants a person had given is the fact being erased;
    ///      naming them in the log would republish it in the one store the erasure cannot reach.
    event CovenantsErased(uint256 recordsErased);

    // ═══════════════════════════════════════════════════════════════════════
    // ERRORS
    // ═══════════════════════════════════════════════════════════════════════

    error NotGovernance();
    error NotOperator();
    error NotErasureCoordinator();
    error UnknownCovenant(bytes32 covenantId);
    error CovenantAlreadyConfigured(bytes32 covenantId);
    error TooManyCovenants();
    error NoGatesSet(bytes32 covenantId);
    error AttestorNotSet(bytes32 covenantId);
    error ExpiryPeriodRequired(bytes32 covenantId);
    error DocumentRequiredForInvalidation(bytes32 covenantId);
    /// @dev ⚠️ An `InvestorSignature` covenant is satisfied by the investor's own transaction
    ///      and by nothing else. An operator route into it would make MAR Art 19(5) — a
    ///      declaration only the director can make — satisfiable by the platform.
    error SignatureRequiredFromInvestor(bytes32 covenantId);
    /// @dev The mirror image. An `OperatorAttestation` covenant — ELTIF Art 26 suitability, a
    ///      KID delivery the distributor evidences — is a statement the OPERATOR makes about
    ///      the investor. Letting the investor's own transaction satisfy it would make the
    ///      suitability assessment self-certified.
    error AttestationRequiredFromOperator(bytes32 covenantId);
    error VersionNotCurrent(bytes32 covenantId);
    /// @dev A classifier covenant must be `PlatformWide`, must name its own axis and no other,
    ///      and its `classMask` must admit the axis's elective value — see `setClassifier`.
    error ClassifierMisconfigured(bytes32 covenantId);
    error AxisIdRequired();
    error TooManyAxes();

    /// @notice ⚠️ THE ONLY REVERT THE TRANSFER PATH EVER SEES, AND IT CARRIES NOTHING. AMLR
    ///         Art 76 prohibits tipping off; a distinct "covenant missing" revert — or worse,
    ///         one naming the covenant — is a disclosure to the blocked party about why they
    ///         were blocked. Every block class returns this same empty code.
    /// @dev    ⚠️ THIS IS A DELIBERATE DEPARTURE FROM `ModularCompliance`'s no-wrapper policy,
    ///         which passes each module's own error through unmodified so an NCA reviewer can
    ///         see which Article fired. Both positions are right about different audiences.
    ///         The resolution used here: the INVESTOR-FACING revert is opaque, and the
    ///         reviewer-facing detail is recovered off-chain from `CovenantGiven` events plus
    ///         `diagnose()`, which is a view no transfer path calls. If a deployment prefers
    ///         the transparent revert, that is a governance decision to make once, in writing,
    ///         against the tipping-off risk — not a per-module default to drift into.
    error Blocked();

    error ZeroAddress();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_, address documents_, address identity_) {
        if (governance_ == address(0) || documents_ == address(0) || identity_ == address(0)) revert ZeroAddress();
        governance = governance_;
        documents = IDocumentAnchor(documents_);
        identity = IIdentityGate(identity_);
        emit DependencySet("documents", documents_);
        emit DependencySet("identity", identity_);
    }

    /// @notice Re-point `identity`. Swap, never unset — the operational-resilience regime requires
    ///         this reference stay swappable at the contract layer rather than hard-wired.
    /// @dev    ⚠️ Was pasted into `CovenantGate`, which has no `identity`, no `governance` and no
    ///         `DependencySet`, so this file did not compile at all. Restored to the contract
    ///         that owns the state.
    function setIdentity(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        identity = IIdentityGate(impl);
        emit DependencySet("identity", impl);
    }

    /// @notice Re-point `documents`. Swap, never unset — the operational-resilience regime requires
    ///         this reference stay swappable at the contract layer rather than hard-wired.
    function setDocuments(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        documents = IDocumentAnchor(impl);
        emit DependencySet("documents", impl);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CONFIGURATION — the issuer decides what exists
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Configures one covenant type. One entry per (obligation, predicate).
    /// @dev    ⚠️ NEVER BRANCH INSIDE AN ENTRY. Retail ELTIF access is Art 26; the professional
    ///         relief is Art 13(7). Two Articles, therefore TWO entries. An entry containing an
    ///         internal if-retail-else-professional cannot be mapped 1:1 to an Article, which
    ///         breaks the Article→function audit map — the one deliverable an NCA reviewer
    ///         reads before anything else.
    /// @dev    ⚠️ ADDING A COVENANT TO A LIVE ASSET IS A CUTOVER, NOT A TOGGLE. The moment an
    ///         entry goes live, every existing holder satisfies nothing — the next transfer
    ///         blocks the entire base at once. `effectiveFrom` is the lever: set it ahead,
    ///         back-record the existing base with `recordAttestation`, then let it bite.
    function configureCovenant(
        bytes32 covenantId,
        bytes32 documentRef,
        uint8 gates,
        Attestor attestor,
        Invalidation invalidation,
        uint64 expiryPeriod,
        Scope scope,
        uint64 effectiveFrom,
        Predicate calldata predicate
    ) external onlyGovernance {
        if (_covenants[covenantId].configured) revert CovenantAlreadyConfigured(covenantId);
        if (_covenantIds.length + 1 > MAX_COVENANTS) revert TooManyCovenants();
        if (gates == 0) revert NoGatesSet(covenantId);
        if (attestor == Attestor.Unset) revert AttestorNotSet(covenantId);
        if (invalidation == Invalidation.OnExpiry && expiryPeriod == 0) revert ExpiryPeriodRequired(covenantId);
        // A covenant cannot be invalidated by a document revision if it binds no document.
        // Configuring that pair produces an entry that can never be invalidated while claiming
        // it can — the most dangerous kind of passing check.
        if (invalidation == Invalidation.OnNewDocumentVersion && documentRef == bytes32(0)) {
            revert DocumentRequiredForInvalidation(covenantId);
        }

        Covenant storage c = _covenants[covenantId];
        c.configured = true;
        c.active = true;
        c.documentRef = documentRef;
        c.gates = gates;
        c.attestor = attestor;
        c.invalidation = invalidation;
        c.expiryPeriod = expiryPeriod;
        c.scope = scope;
        c.effectiveFrom = effectiveFrom;
        c.predicate = predicate;

        // ⚠️ TRACKED HERE, NOT AT FIRST READ, BECAUSE `_classFor` FAILS CLOSED ON AN UNTRACKED
        // AXIS. A covenant whose axis never reached `_axisIds` would resolve to unset and block
        // every gated movement for every holder — correct, and useless as a diagnosis. Refusing
        // the configuration transaction instead puts the failure where an operator can read it.
        if (predicate.classAxisId != bytes32(0)) _registerAxis(predicate.classAxisId);

        _covenantIds.push(covenantId);
        emit CovenantConfigured(covenantId, documentRef, gates, attestor, scope);
    }

    /// @notice Deactivation is reversible and leaves records intact — a covenant that stops
    ///         applying does not un-happen. Removal is not offered: the evidence of what was
    ///         required, and when, is the point.
    function setCovenantActive(bytes32 covenantId, bool active) external onlyGovernance {
        if (!_covenants[covenantId].configured) revert UnknownCovenant(covenantId);
        _covenants[covenantId].active = active;
        if (!active) emit CovenantDeactivated(covenantId);
    }

    /// @notice Names the covenant that resolves one axis's elective classification — the MiFID II
    ///         Annex II Section II opt-up on the nominated tier axis, ECSPR's opt-in on its
    ///         own axis.
    /// @dev    ⚠️ ITS `scope` MUST BE `PlatformWide`, and that is not a style preference: the
    ///         classification it governs is itself platform-wide, and a per-asset covenant gating
    ///         a platform-wide classification is the scoping mismatch that makes an investor
    ///         professional on one asset and retail on another with no record of which is true.
    ///         Enforced here, not merely stated.
    /// @dev    ⚠️ ITS PREDICATE MUST NAME ITS OWN AXIS AND NO OTHER, AND THAT GUARD IS THE WHOLE
    ///         REASON N AXES ARE SAFE WHERE N TIER-CHANGERS WOULD NOT BE. A classifier reading a
    ///         SECOND axis could read an axis whose own classifier reads this one — cross-axis
    ///         recursion, which is the 2026-09-08 stack overflow one level less visible. With
    ///         each classifier confined to its own axis and evaluated against that axis's RAW
    ///         value, the resolution graph has no edges at all and cannot cycle.
    /// @dev    ⚠️ ITS MASK MUST ADMIT `electiveValue`. `_effectiveClass` evaluates this covenant
    ///         against the raw classification, which at that moment is always `electiveValue`. A
    ///         mask that excludes it reports "does not apply" for every elective holder —
    ///         `_satisfied` returns `(true, notRequired)`, the classification is believed with no
    ///         record behind it, and the control fails open in the exact direction rule 6 exists
    ///         to stop. So the mask must be 0 (every value) or include `electiveValue`.
    /// @dev    ⚠️ `electiveValue == fallbackValue` IS REFUSED. It configures a classifier that
    ///         can never demote anyone — every read returns the value it started with, so the
    ///         entry looks configured, costs a predicate evaluation on every gate, and enforces
    ///         nothing. A reviewer seeing a classifier set would reasonably conclude the control
    ///         is live.
    function setClassifier(bytes32 axisId, bytes32 covenantId, uint8 electiveValue, uint8 fallbackValue)
        external
        onlyGovernance
    {
        if (axisId == bytes32(0)) revert AxisIdRequired();
        if (electiveValue == fallbackValue) revert ClassifierMisconfigured(covenantId);

        Covenant storage c = _covenants[covenantId];
        if (!c.configured) revert UnknownCovenant(covenantId);
        if (c.scope != Scope.PlatformWide) revert ClassifierMisconfigured(covenantId);
        if (c.predicate.classAxisId != bytes32(0) && c.predicate.classAxisId != axisId) {
            revert ClassifierMisconfigured(covenantId);
        }

        uint8 mask = c.predicate.classMask;
        if (mask != 0 && (mask & uint8(1 << electiveValue)) == 0) {
            revert ClassifierMisconfigured(covenantId);
        }

        _registerAxis(axisId);
        classifiers[axisId] =
            Classifier({covenantId: covenantId, electiveValue: electiveValue, fallbackValue: fallbackValue, set: true});
        emit ClassifierSet(axisId, covenantId, electiveValue, fallbackValue);
    }

    function _registerAxis(bytes32 axisId) private {
        if (axisKnown[axisId]) return;
        if (_axisIds.length >= MAX_AXES) revert TooManyAxes();
        axisKnown[axisId] = true;
        _axisIds.push(axisId);
        emit AxisTracked(axisId);
    }

    /// @notice Every axis this registry's covenants and classifiers name.
    function axisIds() external view returns (bytes32[] memory) {
        return _axisIds;
    }

    function setOperator(address operator, bool allowed) external onlyGovernance {
        isOperator[operator] = allowed;
        emit OperatorSet(operator, allowed);
    }

    /// @notice Point at the `PersonErasure` coordinator, or unset it with `address(0)`.
    function setErasureCoordinator(address coordinator) external onlyGovernance {
        address previous = erasureCoordinator;
        erasureCoordinator = coordinator;
        emit ErasureCoordinatorSet(previous, coordinator);
    }

    /// @notice GDPR Art 17 leg. Erases every covenant record held against every wallet of one
    ///         person.
    /// @dev    ⚠️ THIS CONTRACT HAD NO ERASURE PATH AT ALL UNTIL 2026-09-09. `_records` grew
    ///         monotonically and nothing ever deleted from it, so a covenant declaration — a
    ///         statement a named investor made, timestamped, against a named document version —
    ///         outlived every deregistration in the suite. The wallet-keying rationale above is
    ///         about who a declaration BINDS; it was never an argument for keeping it forever.
    /// @dev    ⚠️ `personId` IS UNUSED HERE, AND THAT IS THE WHOLE REASON THE COORDINATOR PASSES
    ///         `wallets`. This store has no person key and cannot acquire one without breaking
    ///         the binding property that makes it correct, so it is structurally incapable of
    ///         expanding a `personId` itself. Only `IdentityRegistry` can — which is why it is
    ///         erased last and this contract is erased first.
    /// @dev    Bounded by wallets × configured covenants. Both are operator-set catalogue sizes,
    ///         neither is adversary-controlled, and the covenant catalogue is the same list
    ///         every transfer already iterates in `assertSatisfied`.
    /// @dev    Returns quietly when the person holds no declarations — an investor who never
    ///         signed anything must still be erasable, and the fan-out is atomic.
    function erasePerson(bytes32 /* personId */, address[] calldata wallets) external {
        if (msg.sender != erasureCoordinator || erasureCoordinator == address(0)) revert NotErasureCoordinator();

        uint256 erased;
        uint256 walletCount = wallets.length;
        uint256 covenantCount = _covenantIds.length;

        for (uint256 w = 0; w < walletCount; w++) {
            address investor = wallets[w];
            for (uint256 c = 0; c < covenantCount; c++) {
                bytes32 covenantId = _covenantIds[c];
                if (_records[investor][covenantId].given) {
                    delete _records[investor][covenantId];
                    erased++;
                }
            }
        }

        emit CovenantsErased(erased);
    }

    /// @notice Fund life in seconds, open-vs-closed-ended, token type — whatever the configured
    ///         predicates key on. Governance-only, because ELTIF Art 18(3) turns on the answer.
    function setProductAttribute(bytes32 key, uint256 value) external onlyGovernance {
        _productAttr[key] = value;
        _productAttrSet[key] = true;
        emit ProductAttributeSet(key, value);
    }

    /// @notice Records a regulatory grant — e.g. the ELTIF RTS Art 5(10) exemption, available
    ///         only on request and only from the competent authority.
    /// @dev    Same governance path as recording a new prospectus approval, for the same
    ///         reason: it is evidence of a supervisor's decision, not a platform setting.
    function setRegulatoryGrant(bytes32 grantId, bool granted) external onlyGovernance {
        _grant[grantId] = granted;
        _grantSet[grantId] = true;
        emit RegulatoryGrantSet(grantId, granted);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // RECORDING — what the investor gave
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice The investor's own transaction. The ONLY route into an `InvestorSignature`
    ///         covenant — MAR Art 19(5), and any covenant where the platform attesting on the
    ///         investor's behalf would defeat the point of requiring it.
    /// @dev    ⚠️ AND NO ROUTE AT ALL INTO AN `OperatorAttestation` ONE. The attestor kinds are
    ///         symmetric: an operator may not sign for the investor, and the investor may not
    ///         attest for the operator. Before 2026-09-08 this function had no attestor check,
    ///         so an ELTIF Art 26 suitability covenant — a statement the distributor makes
    ///         about the investor — was satisfiable by the investor pressing a button.
    function signCovenant(bytes32 covenantId, bytes32 documentVersionHash) external {
        Covenant storage c = _covenants[covenantId];
        if (!c.configured) revert UnknownCovenant(covenantId);
        if (c.attestor == Attestor.OperatorAttestation) revert AttestationRequiredFromOperator(covenantId);

        _assertVersionCurrent(c, covenantId, documentVersionHash);
        _write(msg.sender, covenantId, documentVersionHash, Attestor.InvestorSignature);
    }

    /// @notice The operator's attestation, for covenants configured as `OperatorAttestation`.
    ///         Also the back-recording path for a cutover (see `configureCovenant`).
    function recordAttestation(address investor, bytes32 covenantId, bytes32 documentVersionHash) external {
        if (!isOperator[msg.sender]) revert NotOperator();

        Covenant storage c = _covenants[covenantId];
        if (!c.configured) revert UnknownCovenant(covenantId);
        if (c.attestor == Attestor.InvestorSignature) revert SignatureRequiredFromInvestor(covenantId);

        _assertVersionCurrent(c, covenantId, documentVersionHash);
        _write(investor, covenantId, documentVersionHash, Attestor.OperatorAttestation);
    }

    /// @dev Recording against a superseded version is rejected at WRITE time as well as read
    ///      time. It would fail the gate anyway, but failing it here turns a silent
    ///      never-satisfied record into an immediate, legible error for the operator who
    ///      handed the investor an out-of-date document.
    function _assertVersionCurrent(Covenant storage c, bytes32 covenantId, bytes32 versionHash) private view {
        if (c.documentRef == bytes32(0)) return;
        if (!documents.isCurrent(c.documentRef, versionHash)) revert VersionNotCurrent(covenantId);
    }

    function _write(address investor, bytes32 covenantId, bytes32 versionHash, Attestor attestorType) private {
        _records[investor][covenantId] = Record({
            given: true,
            documentVersionHash: versionHash,
            attestorType: attestorType,
            timestamp: uint64(block.timestamp)
        });

        emit CovenantGiven(investor, attestorType);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // THE PREDICATE
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice ⚠️ RULE 6 — DOWNGRADE IS THE DANGEROUS DIRECTION, AND THIS IS WHERE IT IS
    ///         HANDLED. An investor who has not completed the opt-up is STILL RETAIL. A
    ///         self-declaration in a sign-up form is not an opt-up. So a
    ///         `ProfessionalOnRequest` tier whose opt-up covenant is missing or stale resolves
    ///         to Retail here, and every retail covenant becomes live for them — rather than
    ///         the platform silently switching PRIIPs off for someone the regulation still
    ///         treats as retail.
    /// @dev    ⚠️ THE LIMIT, STATED RATHER THAN ASSUMED: this cannot stop the off-chain claims
    ///         service writing `ProfessionalOnRequest` in the first place. What it does is
    ///         refuse to BELIEVE it without the covenant. The complementary control is
    ///         `mayUpgrade`, which the identity registry may call before it writes.
    /// @dev    ⚠️ THE OPT-UP COVENANT IS EVALUATED AGAINST THE RAW TIER, AND THE REASON IS A
    ///         RECURSION THAT SHIPPED. Until 2026-09-08 this read
    ///         `_satisfied(wallet, optUpCovenantId)` → `appliesTo` → `effectiveTier` → … with
    ///         no base case whenever the raw tier was `ProfessionalOnRequest`, so the moment
    ///         `setClassifier` went live every `assertSatisfied`, `mayUpgrade` and
    ///         `diagnose` for an elective professional ran out of stack — every transfer of
    ///         that holder failed, in precisely the configuration recommended for retail
    ///         distribution. The fix is structural, not a guard: the predicate takes the
    ///         classification as an ARGUMENT (`_appliesTo`), the classifier covenant is evaluated
    ///         with the raw value passed in directly, and nothing on that path calls back into
    ///         this function. Which is also the semantically right answer — the question "has
    ///         this elective professional opted up" is asked OF the raw classification, not of
    ///         the resolved one.
    /// @return value The classification after the classifier has been applied.
    /// @return isSet Whether the axis carries a classification at all. ⚠️ FALSE IS UNEVALUABLE,
    ///         NOT A DEFAULT — callers fail closed on it rather than reading `value`, which is
    ///         zero and means nothing.
    function effectiveClass(address wallet, bytes32 axisId) public view returns (uint8 value, bool isSet) {
        (value, isSet) = identity.classificationOf(wallet, axisId);
        if (!isSet) return (0, false);

        Classifier storage k = classifiers[axisId];
        if (!k.set || value != k.electiveValue) return (value, true);

        // Evaluated against the RAW value — `value` here is `k.electiveValue` by the line above,
        // and the classifier's predicate is confined to this axis by `setClassifier`. No edge
        // out of this resolution, so no cycle into it.
        // `registered` is passed as true rather than read: `isSet` is already true above, and a
        // classification can only exist against a registered person — `setClassification` and
        // `registerPerson` both refuse the null `personId`, which is what an unbound wallet
        // resolves to. Reading the registry again here would be a second call for a fact the
        // line above already proved.
        (bool ok,) = _satisfiedAt(wallet, k.covenantId, value, true, true);
        if (!ok) return (k.fallbackValue, true);
        return (value, true);
    }

    /// @dev ⚠️ THERE IS NO `effectiveTier` / `mayUpgradeTier` PAIR ANY MORE, AND NOTHING LOST A
    ///      CALLER. They were typed MiFID wrappers over the two functions above. Once
    ///      `assertSatisfied` and `diagnose` moved onto `_resolveAxes`, nothing in the suite
    ///      called either of them — `IdentityRegistry` had never wired `mayUpgradeTier`, which
    ///      the 2026-09-08 review already recorded. Keeping them would have preserved a
    ///      compile-time dependency on one regime for no consumer. A caller wanting the MiFID
    ///      answer calls `effectiveClass(wallet, identity.tierAxis())` and casts.

    /// @notice The optional contract control for predicate rule 4. The identity registry may
    ///         call this before writing an elective classification, closing the ordering hole
    ///         properly instead of relying on a process the ledger cannot see.
    /// @dev    Recommended wherever retail distribution is in scope. Left as a read rather than
    ///         wired in from here, because the coupling belongs to the identity registry's
    ///         write path — this contract must not acquire the power to write classifications.
    /// @dev    Evaluated at `electiveValue` rather than at the wallet's current raw value,
    ///         because the caller is asking whether the wallet may BECOME that value — the
    ///         registry has not written it yet, so the raw read would still say Retail and a
    ///         Retail-excluding mask would answer "not applicable, so yes" for everyone.
    function mayUpgrade(address wallet, bytes32 axisId) public view returns (bool) {
        Classifier storage k = classifiers[axisId];
        if (!k.set) return true;
        (, bool registered) = identity.personIdOf(wallet);
        (bool ok,) = _satisfiedAt(wallet, k.covenantId, k.electiveValue, true, registered);
        return ok;
    }

    /// @notice Evaluates `appliesTo` as a conjunction over the four dimensions, at the wallet's
    ///         EFFECTIVE tier.
    /// @return applies Whether this covenant is owed by this investor right now.
    /// @return evaluable Whether the predicate could be evaluated AT ALL.
    /// @dev    ⚠️ RULE 5 — "NOT APPLICABLE" AND "APPLICABLE BUT UNSATISFIED" MUST NOT COLLAPSE
    ///         INTO ONE FALSE. If jurisdiction is absent from the identity record, or a product
    ///         attribute was never configured, a naive predicate returns false and the covenant
    ///         SILENTLY STOPS APPLYING — a fail-open wearing the costume of a passing check.
    ///         Hence two return values, and hence the caller treating `!evaluable` as
    ///         unsatisfied rather than inapplicable.
    function appliesTo(address wallet, bytes32 covenantId) public view returns (bool applies, bool evaluable) {
        bytes32 axisId = _covenants[covenantId].predicate.classAxisId;
        (uint8 v, bool isSet) = axisId == bytes32(0) ? (uint8(0), true) : effectiveClass(wallet, axisId);
        (, bool registered) = identity.personIdOf(wallet);
        return _appliesTo(wallet, covenantId, v, isSet, registered);
    }

    /// @dev The predicate proper. The classification is an ARGUMENT so that `effectiveClass` can
    ///      evaluate a classifier covenant at the raw value without re-entering itself — see
    ///      there. `classValue` / `classIsSet` belong to `p.classAxisId`; supplying another
    ///      axis's value is the one way to misuse this function, which is why every caller
    ///      reads the axis off the covenant first.
    function _appliesTo(address wallet, bytes32 covenantId, uint8 classValue, bool classIsSet, bool registered)
        private
        view
        returns (bool applies, bool evaluable)
    {
        Covenant storage c = _covenants[covenantId];
        if (!c.configured || !c.active) return (false, true);
        if (block.timestamp < c.effectiveFrom) return (false, true);

        Predicate storage p = c.predicate;

        // ── dimension 0: registration (platform-wide) ────────────────────
        // ⚠️ UNCONDITIONAL, AND IT REPLACES SOMETHING THAT USED TO BE FREE. While the tier was
        // mandatory the `Tier.Unset` check caught unregistered wallets for EVERY covenant,
        // including ones that did not key on tier at all. Making the classification dimension
        // optional would have quietly dropped that: a covenant with no axis would have started
        // applying to wallets the registry has never heard of. Asked directly now, of the
        // registration flag, rather than inferred from an enum's zero value — and passed IN,
        // because one identity read per covenant per transfer is what the argument-passing in
        // this function exists to avoid.
        if (!registered) return (false, false);

        // ── dimension 1: classification on a named axis (platform-wide) ──
        if (p.classAxisId != bytes32(0)) {
            if (!classIsSet) return (false, false); // unclassified ≠ exempt
            if (p.classMask != 0 && (p.classMask & uint8(1 << classValue)) == 0) return (false, true);
        }

        // ── dimension 2: jurisdiction (platform-wide, set-valued) ────────
        if (p.needsMultiJurisdiction) return (false, false); // see `Predicate.needsMultiJurisdiction`
        if (p.jurisdictions.length > 0) {
            bytes32 j = identity.jurisdictionOf(wallet);
            if (j == bytes32(0)) return (false, false); // absent ≠ not-applicable
            bool hit;
            for (uint256 i = 0; i < p.jurisdictions.length; i++) {
                if (p.jurisdictions[i] == j) {
                    hit = true;
                    break;
                }
            }
            if (!hit) return (false, true);
        }

        // ── dimension 3: product attribute (per-asset) ───────────────────
        if (p.productCmp != Comparator.None) {
            if (!_productAttrSet[p.productKey]) return (false, false);
            uint256 v = _productAttr[p.productKey];
            if (p.productCmp == Comparator.Equals && v != p.productValue) return (false, true);
            if (p.productCmp == Comparator.GreaterThan && v <= p.productValue) return (false, true);
            if (p.productCmp == Comparator.LessThan && v >= p.productValue) return (false, true);
        }

        // ── dimension 4: regulatory grant (per-asset) ────────────────────
        if (p.grantPolarity != GrantPolarity.Ignore) {
            if (!_grantSet[p.grantId]) return (false, false);
            bool granted = _grant[p.grantId];
            if (p.grantPolarity == GrantPolarity.RequiresGrant && !granted) return (false, true);
            if (p.grantPolarity == GrantPolarity.RequiresNoGrant && granted) return (false, true);
        }

        return (true, true);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SATISFACTION
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev ⚠️ RULE 3 — evaluate against the state at THIS moment, but judge the record by what
    ///      was true when it was given. A professional-only offer that later admits one retail
    ///      investor triggers the KID duty FROM THAT POINT: the gate is not a one-time check.
    ///      A tier change makes new entries applicable at the next gated action, and never
    ///      retroactively invalidates a covenant properly given.
    /// @dev Every gate resolves each axis ONCE per wallet and passes the values down, rather than
    ///      re-reading the identity registry (and re-evaluating a classifier covenant) inside
    ///      each of up to `MAX_COVENANTS` iterations. See `_axisIds`.
    function _satisfiedAt(address wallet, bytes32 covenantId, uint8 classValue, bool classIsSet, bool registered)
        private
        view
        returns (bool ok, bool required)
    {
        (bool applies, bool evaluable) = _appliesTo(wallet, covenantId, classValue, classIsSet, registered);

        if (!evaluable) return (false, true); // fail closed
        if (!applies) return (true, false);

        Covenant storage c = _covenants[covenantId];
        Record storage r = _records[wallet][covenantId];
        if (!r.given) return (false, true);

        if (c.invalidation == Invalidation.OnNewDocumentVersion) {
            // The whole mechanism, in one line: a revision invalidates every outstanding
            // acknowledgement the moment it is anchored, with zero configuration.
            if (!documents.isCurrent(c.documentRef, r.documentVersionHash)) return (false, true);
        } else if (c.invalidation == Invalidation.OnExpiry) {
            if (block.timestamp > uint256(r.timestamp) + uint256(c.expiryPeriod)) return (false, true);
        }

        // A covenant configured to need the investor's signature is not satisfied by a record
        // written as an operator attestation, even if one exists.
        if (c.attestor == Attestor.InvestorSignature && r.attestorType != Attestor.InvestorSignature) {
            return (false, true);
        }

        return (true, true);
    }

    /// @notice The gate. Reverts with `Blocked()` — carrying nothing — if any covenant
    ///         applicable to this wallet at this gate is unsatisfied or unevaluable.
    function assertSatisfied(address wallet, uint8 gate) public view {
        (uint8[] memory vals, bool[] memory sets, bool registered) = _resolveAxes(wallet);
        uint256 len = _covenantIds.length;
        for (uint256 i = 0; i < len; i++) {
            bytes32 id = _covenantIds[i];
            Covenant storage c = _covenants[id];
            if (!c.active) continue;
            if (c.gates & gate == 0) continue;

            (uint8 v, bool s) = _classFor(c.predicate.classAxisId, vals, sets);
            (bool ok,) = _satisfiedAt(wallet, id, v, s, registered);
            if (!ok) revert Blocked();
        }
    }

    /// @dev Resolves every tracked axis once, in `_axisIds` order. Bounded by `MAX_AXES`.
    function _resolveAxes(address wallet)
        private
        view
        returns (uint8[] memory vals, bool[] memory sets, bool registered)
    {
        (, registered) = identity.personIdOf(wallet);
        uint256 n = _axisIds.length;
        vals = new uint8[](n);
        sets = new bool[](n);
        for (uint256 i = 0; i < n; i++) {
            (vals[i], sets[i]) = effectiveClass(wallet, _axisIds[i]);
        }
    }

    /// @dev Looks one covenant's axis out of the resolved set. A linear scan is right here and a
    ///      mapping would not be: `MAX_AXES` is 8, so this is at most eight word comparisons in
    ///      memory against a storage read per lookup.
    /// @dev ⚠️ AN AXIS THE PREDICATE NAMES BUT `_axisIds` DOES NOT HOLD RETURNS UNSET, AND
    ///      THEREFORE FAILS CLOSED. `configureCovenant` tracks the axis, so this is unreachable
    ///      by configuration; it is written this way so that if it ever became reachable the
    ///      result is a blocked transfer and not a skipped dimension.
    function _classFor(bytes32 axisId, uint8[] memory vals, bool[] memory sets)
        private
        view
        returns (uint8 value, bool isSet)
    {
        if (axisId == bytes32(0)) return (0, true); // dimension unused
        uint256 n = _axisIds.length;
        for (uint256 i = 0; i < n; i++) {
            if (_axisIds[i] == axisId) return (vals[i], sets[i]);
        }
        return (0, false);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS — reviewer-facing, never called from a transfer path
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice The Article→function audit surface, and the support desk's answer. Returns every
    ///         covenant id blocking this wallet at this gate.
    /// @dev    Deliberately NOT reachable from `checkTransfer`. The transfer path stays opaque
    ///         for AMLR Art 76; this exists so a reviewer, a compliance officer or an
    ///         off-chain UI can recover exactly what the opaque revert concealed.
    function diagnose(address wallet, uint8 gate) external view returns (bytes32[] memory blocking) {
        (uint8[] memory vals, bool[] memory sets, bool registered) = _resolveAxes(wallet);
        uint256 len = _covenantIds.length;
        bytes32[] memory buf = new bytes32[](len);
        uint256 n;

        for (uint256 i = 0; i < len; i++) {
            bytes32 id = _covenantIds[i];
            Covenant storage c = _covenants[id];
            if (!c.active) continue;
            if (c.gates & gate == 0) continue;

            (uint8 v, bool s) = _classFor(c.predicate.classAxisId, vals, sets);
            (bool ok,) = _satisfiedAt(wallet, id, v, s, registered);
            if (!ok) {
                buf[n] = id;
                n++;
            }
        }

        blocking = new bytes32[](n);
        for (uint256 i = 0; i < n; i++) {
            blocking[i] = buf[i];
        }
    }

    function covenantIds() external view returns (bytes32[] memory) {
        return _covenantIds;
    }

    function covenantOf(bytes32 covenantId) external view returns (Covenant memory) {
        return _covenants[covenantId];
    }

    function recordOf(address wallet, bytes32 covenantId) external view returns (Record memory) {
        return _records[wallet][covenantId];
    }

    function productAttribute(bytes32 key) external view returns (uint256 value, bool isSet) {
        return (_productAttr[key], _productAttrSet[key]);
    }

    function regulatoryGrant(bytes32 grantId) external view returns (bool granted, bool isSet) {
        return (_grant[grantId], _grantSet[grantId]);
    }
}

/// @title CovenantGate (illustrative sample — not production code)
/// @notice Bridges `CovenantRegistry` onto the shape `ModularCompliance` calls, so the registry
///         stays a store plus a predicate and the compliance stack stays the only evaluator.
/// @dev    ⚠️ MINT IS `from == address(0)`, AND IT IS A DIFFERENT GATE FROM RECEIVE. Four of
///         the six obligations gate MINT without gating RECEIVE — ELTIF Art 18(3) is
///         pre-investment disclosure only, and treating a subscription as "just a receive"
///         applies the wrong covenant set to the one moment that matters most.
/// @dev    ⚠️ SEND CHECKS THE SENDER, AND THAT IS NOT SYMMETRY FOR ITS OWN SAKE. DLT Pilot
///         Arts 4(2)(c)–(f) are the one covenant set that genuinely binds the sender —
///         "enforce on admission and RE-CHECK ON ACTIVITY" — and MAR Art 19(5) is what
///         populates the closed-period freeze's flag set, which is also a sender-side control.
/// @dev    ⚠️ BURN IS `to == address(0)`, AND THE ZERO LEG IS NOT A WALLET. Until 2026-09-08
///         this adapter ran `assertSatisfied(address(0), RECEIVE)` on every burn: `tierOf(0)`
///         is `Unset`, `Unset` is unevaluable, unevaluable is `Blocked()` — so the first
///         RECEIVE-gated covenant configured (PRIIPs Art 13, ELTIF Art 26, DLT Pilot 4(2)(g)
///         are all RECEIVE) stopped every redemption, buy-back burn and maturity burn on the
///         token. A burn is an EXIT: the only party making a statement is the holder leaving,
///         so it is gated on SEND for the sender and on nothing for the zero address — the
///         same zero-leg handling `HoldingPeriodGate` and `PdmrClosedPeriodFreeze` already
///         apply.
contract CovenantGate is ModuleAdapter {
    CovenantRegistry public immutable covenants;

    constructor(bytes32 moduleId_, address covenants_) ModuleAdapter(moduleId_) {
        covenants = CovenantRegistry(covenants_);
    }

    /// @dev mint → MINT on `to`; burn → SEND on `from` only; transfer → SEND on `from` and
    ///      RECEIVE on `to`.
    function checkTransfer(address from, address to, uint256) external view override {
        if (from == address(0)) {
            covenants.assertSatisfied(to, covenants.GATE_MINT());
            return;
        }

        covenants.assertSatisfied(from, covenants.GATE_SEND());
        if (to == address(0)) return; // burn — nobody is receiving
        covenants.assertSatisfied(to, covenants.GATE_RECEIVE());
    }

    /// @dev ⚠️ NOTHING BELONGS IN THIS ADAPTER BUT DELEGATION. The `setIdentity` / `setDocuments`
    ///      pair that sat here referenced state this contract does not have and belongs to
    ///      `CovenantRegistry`; it has been moved back. The registry reference is `immutable`
    ///      here on purpose — re-pointing a gate at a different store is a module swap, which
    ///      `ModularCompliance.addModule`/`removeModule` already expresses.
}
