// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ModuleAdapter} from "./ModularCompliance.sol";
import {IDocumentAnchor} from "./Interfaces.sol";
import {IdentityRegistry} from "./IdentityRegistry.sol";

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
contract CovenantRegistry {
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
        /// @dev Bitmask over `IdentityRegistry.Tier`. 0 = every tier.
        uint8 tierMask;
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
        /// @dev ⚠️ Concrete type retained DELIBERATELY, and it is a known gap. This dependency
    ///      returns a struct/enum, which a narrow interface cannot declare without
    ///      duplicating the type — and a duplicated struct is a DIFFERENT type to the
    ///      compiler, so every call site here would break. Closing it means moving the
    ///      shared types into `Interfaces.sol` and having the concrete contract import
    ///      them from there. Until then the `immutable` half of the rule is satisfied
    ///      (settable below) and the coupling half is not.
    IdentityRegistry public identity;

    /// @notice The fail-closed source of truth for document currency. `isCurrent` returns false
    ///         the instant a document is superseded — and, for a PRIIPs KID, also when its
    ///         Art 10 review is overdue.
        /// @dev ⚠️ Concrete type retained DELIBERATELY, and it is a known gap. This dependency
    ///      returns a struct/enum, which a narrow interface cannot declare without
    ///      duplicating the type — and a duplicated struct is a DIFFERENT type to the
    ///      compiler, so every call site here would break. Closing it means moving the
    ///      shared types into `Interfaces.sol` and having the concrete contract import
    ///      them from there. Until then the `immutable` half of the rule is satisfied
    ///      (settable below) and the coupling half is not.
    IDocumentAnchor public documents;

    /// @notice Operators may attest `OperatorAttestation` covenants. They may NEVER satisfy an
    ///         `InvestorSignature` one — see `recordAttestation`.
    mapping(address => bool) public isOperator;

    /// @notice The MiFID II Annex II Section II opt-up covenant, if configured. Its effect is
    ///         to change the tier every OTHER predicate reads, which is why it is named
    ///         separately and resolved first.
    bytes32 public optUpCovenantId;

    // ═══════════════════════════════════════════════════════════════════════
    // STATE
    // ═══════════════════════════════════════════════════════════════════════

    mapping(bytes32 => Covenant) private _covenants;
    bytes32[] private _covenantIds;

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
    event OptUpCovenantSet(bytes32 indexed covenantId);
    event OperatorSet(address indexed operator, bool allowed);
    event ProductAttributeSet(bytes32 indexed key, uint256 value);
    event RegulatoryGrantSet(bytes32 indexed grantId, bool granted);

    /// @dev The audit trail PRIIPs Art 13 and MAR Art 19(5) are evidenced from. The revert path
    ///      is deliberately silent (see `Blocked`); this is where the detail lives.
    event CovenantGiven(
        address indexed investor, bytes32 indexed covenantId, bytes32 documentVersionHash, Attestor attestorType
    );

    // ═══════════════════════════════════════════════════════════════════════
    // ERRORS
    // ═══════════════════════════════════════════════════════════════════════

    error NotGovernance();
    error NotOperator();
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
    error VersionNotCurrent(bytes32 covenantId);

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

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_, address documents_, address identity_) {
        governance = governance_;
        documents = IDocumentAnchor(documents_);
        identity = IdentityRegistry(identity_);
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

    /// @notice Names the MiFID II Annex II Section II opt-up covenant.
    /// @dev    ⚠️ ITS `scope` MUST BE `PlatformWide`, and that is not a style preference: the
    ///         tier claim it governs is itself platform-wide, and a per-asset covenant gating a
    ///         platform-wide claim is the scoping mismatch that makes an investor professional
    ///         on one asset and retail on another with no record of which is true.
    function setOptUpCovenant(bytes32 covenantId) external onlyGovernance {
        if (!_covenants[covenantId].configured) revert UnknownCovenant(covenantId);
        optUpCovenantId = covenantId;
        emit OptUpCovenantSet(covenantId);
    }

    function setOperator(address operator, bool allowed) external onlyGovernance {
        isOperator[operator] = allowed;
        emit OperatorSet(operator, allowed);
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
    function signCovenant(bytes32 covenantId, bytes32 documentVersionHash) external {
        Covenant storage c = _covenants[covenantId];
        if (!c.configured) revert UnknownCovenant(covenantId);

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

        emit CovenantGiven(investor, covenantId, versionHash, attestorType);
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
    ///         `mayUpgradeTier`, which the identity registry may call before it writes.
    function effectiveTier(address wallet) public view returns (IdentityRegistry.Tier) {
        IdentityRegistry.Tier tier = identity.tierOf(wallet);

        if (tier == IdentityRegistry.Tier.ProfessionalOnRequest && optUpCovenantId != bytes32(0)) {
            (bool ok,) = _satisfied(wallet, optUpCovenantId);
            if (!ok) return IdentityRegistry.Tier.Retail;
        }
        return tier;
    }

    /// @notice The optional contract control for predicate rule 4. The identity registry may
    ///         call this before writing an elective-professional tier, closing the ordering
    ///         hole properly instead of relying on a process the ledger cannot see.
    /// @dev    Recommended wherever retail distribution is in scope. Left as a read rather than
    ///         wired in from here, because the coupling belongs to the identity registry's
    ///         write path — this contract must not acquire the power to write tiers.
    function mayUpgradeTier(address wallet) external view returns (bool) {
        if (optUpCovenantId == bytes32(0)) return true;
        (bool ok,) = _satisfied(wallet, optUpCovenantId);
        return ok;
    }

    /// @notice Evaluates `appliesTo` as a conjunction over the four dimensions.
    /// @return applies Whether this covenant is owed by this investor right now.
    /// @return evaluable Whether the predicate could be evaluated AT ALL.
    /// @dev    ⚠️ RULE 5 — "NOT APPLICABLE" AND "APPLICABLE BUT UNSATISFIED" MUST NOT COLLAPSE
    ///         INTO ONE FALSE. If jurisdiction is absent from the identity record, or a product
    ///         attribute was never configured, a naive predicate returns false and the covenant
    ///         SILENTLY STOPS APPLYING — a fail-open wearing the costume of a passing check.
    ///         Hence two return values, and hence the caller treating `!evaluable` as
    ///         unsatisfied rather than inapplicable.
    function appliesTo(address wallet, bytes32 covenantId) public view returns (bool applies, bool evaluable) {
        Covenant storage c = _covenants[covenantId];
        if (!c.configured || !c.active) return (false, true);
        if (block.timestamp < c.effectiveFrom) return (false, true);

        Predicate storage p = c.predicate;

        // ── dimension 1: tier (platform-wide) ────────────────────────────
        IdentityRegistry.Tier tier = effectiveTier(wallet);
        if (tier == IdentityRegistry.Tier.Unset) return (false, false); // unclassified ≠ exempt
        if (p.tierMask != 0 && (p.tierMask & uint8(1 << uint8(tier))) == 0) return (false, true);

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
    function _satisfied(address wallet, bytes32 covenantId) private view returns (bool ok, bool required) {
        (bool applies, bool evaluable) = appliesTo(wallet, covenantId);

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
        uint256 len = _covenantIds.length;
        for (uint256 i = 0; i < len; i++) {
            bytes32 id = _covenantIds[i];
            Covenant storage c = _covenants[id];
            if (!c.active) continue;
            if (c.gates & gate == 0) continue;

            (bool ok,) = _satisfied(wallet, id);
            if (!ok) revert Blocked();
        }
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
        uint256 len = _covenantIds.length;
        bytes32[] memory buf = new bytes32[](len);
        uint256 n;

        for (uint256 i = 0; i < len; i++) {
            bytes32 id = _covenantIds[i];
            Covenant storage c = _covenants[id];
            if (!c.active) continue;
            if (c.gates & gate == 0) continue;

            (bool ok,) = _satisfied(wallet, id);
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
contract CovenantGate is ModuleAdapter {
    CovenantRegistry public immutable covenants;

    constructor(bytes32 moduleId_, address covenants_) ModuleAdapter(moduleId_) {
        covenants = CovenantRegistry(covenants_);
    }

    function checkTransfer(address from, address to, uint256) external view override {
        if (from == address(0)) {
            covenants.assertSatisfied(to, covenants.GATE_MINT());
            return;
        }

        covenants.assertSatisfied(from, covenants.GATE_SEND());
        covenants.assertSatisfied(to, covenants.GATE_RECEIVE());
    }

    /// @notice Re-point `identity`. Swap, never unset — the operational-resilience regime requires
    ///         this reference stay swappable at the contract layer rather than hard-wired.
    function setIdentity(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        identity = IdentityRegistry(impl);
        emit DependencySet("identity", impl);
    }
    /// @notice Re-point `documents`. Swap, never unset — the operational-resilience regime requires
    ///         this reference stay swappable at the contract layer rather than hard-wired.
    function setDocuments(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        documents = IDocumentAnchor(impl);
        emit DependencySet("documents", impl);
    }
}
