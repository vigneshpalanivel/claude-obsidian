// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title Interfaces (illustrative sample — not production code)
/// @notice Narrow, single-purpose interfaces for every inter-contract dependency in the suite.
/// @dev    ⚠️ NARROW ON PURPOSE — do not consolidate these into one fat interface per contract.
///         A consumer should depend on the smallest surface it actually calls, so that swapping
///         or reimplementing a module does not require satisfying methods the consumer never
///         uses. `SettlementEngine` already demonstrated the pattern with `IIdentityTier`:
///         it needs a tier, not the whole registry, so that is all it declares.
/// @dev    ⚠️ THESE EXIST TO BREAK CONCRETE-TYPE COUPLING. Importing `IdentityRegistry` rather
///         than `IIdentityGate` binds the consumer to one implementation and drags its entire
///         dependency tree into every deployment — including for clients who do not owe the
///         obligation that module discharges.
/// @dev    ⚠️ THIS FILE IS THE SUITE'S INTERNAL SURFACE. THE STANDARD'S SURFACE IS `IERC3643.sol`,
///         AND THE TWO ARE NOT ALTERNATIVES.
///         `IERC3643.sol` is what the OUTSIDE world — a venue, a custodian, a wallet, an
///         explorer — is entitled to assume. This file is what one contract in the suite calls
///         on another. **The names in `IERC3643.sol` are normative and must not be changed; the
///         names here are ours and bind freely.**
///
///         Where the two overlap they are deliberately different in SHAPE, and the difference
///         is a compliance one rather than a taste one:
///           • `IIdentityGate.checkEligible` **REVERTS** with an informative-class error the
///             holder can act on; `IIdentityRegistry.isVerified` returns a boolean. A consumer
///             that needs to tell a holder their record lapsed calls the former. Neither is
///             permitted to surface an OPAQUE stop — those stay in `IRestrictedParty` behind
///             one argument-free error (AMLR Art 76 tipping-off).
///           • `IComplianceGate` below carries `checkTransfer` (reverting, pre-write) and
///             `notifyTransfer` (post-write). `ICompliance` in `IERC3643.sol` carries the
///             standard's `canTransfer` / `transferred` / `created` / `destroyed`.
///             `ModularCompliance` implements BOTH — see its note on why the standard's
///             post-write trio cannot replace `notifyTransfer`.
///
///         ⚠️ A consumer should still depend on the SMALLEST surface it actually calls. Do not
///         re-type fifteen contracts onto `IERC3643.sol` because the standard now exists:
///         `CovenantRegistry` needs a tier and a jurisdiction, not a token standard.

// ═══════════════════════════════════════════════════════════════════════════
// SHARED TYPES
// ═══════════════════════════════════════════════════════════════════════════
//
// ⚠️ THESE LIVE HERE BECAUSE A DUPLICATED STRUCT IS A DIFFERENT TYPE TO THE COMPILER.
//    Three dependencies in this suite return a struct or an enum. While each type was declared
//    inside its own concrete contract, no narrow interface could describe those functions —
//    re-declaring the type in the interface produces a type the call site will not accept, so
//    the consumers stayed bound to the concrete contract and inherited its whole dependency
//    tree. Hoisting the types to one file is what makes the interfaces usable.
//
// ⚠️ THE DEFINING CONTRACT MUST IMPORT FROM HERE, NOT RE-DECLARE. The moment a contract keeps
//    a local copy "for readability", there are two types with one name and the coupling is back
//    with no compiler error to announce it.

/// @notice Which regime's clock and consequences attach to an anchored document.
/// @dev    Deliberately a SMALL enum, not an open `bytes32`: a document's regime changes what
///         the rest of the stack must do when a new version lands — a prospectus supplement
///         opens a withdrawal window, a key-information revision opens none and invalidates
///         outstanding acknowledgements instead. A new regime here is a design event, not a
///         configuration one.
enum Regime {
    Unset,
    ProspectusRegulation,
    MarDisclosure,
    EltifDisclosure,
    PriipsKid
}

/// @notice One anchored version of a document. The hash is the product, not the file.
struct Version {
    bytes32 versionHash;
    bytes32 uriHash;
    uint64 anchoredAt;
    uint64 approvedAt; // regulator approval; 0 = none recorded
    uint64 reviewDueBy; // periodic-review regimes only; 0 = no review duty
    bool revealed; // commit-reveal, where disclosing that information exists would itself leak
}

/// @notice Investor classification. Gates who may hold and on what terms.
/// @dev    ⚠️ ONE AXIS AMONG SEVERAL, NOT THE CLASSIFICATION. This is MiFID II Annex II, stored
///         and read through the generic classification machinery under `AXIS_MIFID`. It stays a
///         named enum because the MiFID limb is the one every contract in this suite reads
///         directly and a `uint8` there would lose the compiler's help — `SubscriptionEscrow`'s
///         qualified-investor test is genuinely about THESE five values. A second regime's
///         classification is a second axis with its own encoding, never a widening of this enum.
enum Tier {
    Unset,
    Retail,
    ProfessionalOnRequest, // elective, and revocable
    PerSeProfessional,
    EligibleCounterparty
}

// ⚠️ THE HIGHEST VALUE ANY CLASSIFICATION AXIS MAY USE, AND IT IS A CORRECTNESS BOUND RATHER THAN
// A BUDGET. The covenant predicate matches a classification with `classMask & uint8(1 << value)`.
// For `value >= 8` that shift is zero in a `uint8`, so the mask test passes trivially and the
// covenant reports NOT-APPLICABLE — silently switching every masked entry off for that investor.
// MiFID's `Tier` tops out at 4 so nothing hit it, but an axis opened for another purpose would.
// Enforced on write (`IdentityRegistry.setClassification`, `CovenantRegistry.setClassifier`) and
// again on read, because a value written before the write-side check must not evaluate as exempt.
uint8 constant MAX_CLASSIFICATION_VALUE = 7;

// ⚠️ THERE IS DELIBERATELY NO `AXIS_MIFID` CONSTANT. It existed briefly and was removed: a
// compile-time axis id makes MiFID the one classification the suite cannot be deployed without,
// which is the hardcoding the axis machinery exists to end. The axis carrying `Tier` is nominated
// per deployment through `IdentityRegistry.setTierAxis`, exactly like every other axis, and a
// deployment whose client is not under MiFID simply nominates a different one — or none, in which
// case `tierOf` and `isRetail` REVERT rather than answering, because both are consumed as
// positive gates and a false would fail open. See `SettlementEngine.giveReuseConsent` and
// `MemberEligibility`, which read `isRetail` as "this person needs MORE checks".

/// @notice Lifecycle of a distribution run.
enum DistributionState {
    None,
    Declared, // record block fixed and still in the future — the point of it
    Snapshotted, // entitlements determined and immutable
    Open, // funded and paying
    Closed // closed to new payouts; unclaimed may be swept
}

/// @notice A declared distribution.
/// @dev    `recordBlock` is fixed in advance and always in the future at declaration. Choosing
///         it after the fact — or computing on balances at payment time — lets a transfer
///         between record date and payment date silently redirect the money.
struct Distribution {
    DistributionState state;
    uint64 recordBlock;
    bytes32 snapshotRoot;
    uint256 totalUnits;
    uint256 ratePerUnit; // per-unit rate, not a total to divide: multiplication cannot strand a remainder
    uint256 funded;
    uint256 paidOut;
    uint256 unclaimed;
    uint16 feeBps;
    uint16 withholdingBps;
    uint64 claimDeadline; // 0 = never sweeps
    bool runComplianceModules;
}

/// @notice The eligibility limb of the identity layer, as the transfer hook consumes it.
/// @dev    ⚠️ `checkEligible` REVERTS rather than returning a boolean. Its errors are of the
///         INFORMATIVE class only — `NotRegistered`, `RecordExpired`, `MissingRequiredClaim` —
///         because a lapsed record or an absent claim is something the holder can cure and is
///         not an allegation about them (design §4, rev 48 note). Every OPAQUE stop — sanctions,
///         suspicion, probate, court order — lives in `IRestrictedParty` behind one argument-free
///         error, and this interface must never grow a way to express one. The anti-money-
///         laundering tipping-off prohibition makes disclosing that a customer is under analysis
///         an individual criminal offence in most Member States, and a typed revert on a public
///         ledger discloses it to everyone.
interface IIdentityGate {
    function checkEligible(address wallet) external view;

    function isEligible(address wallet) external view returns (bool);

    function jurisdictionOf(address wallet) external view returns (bytes32);

    /// @notice The off-chain investor record a wallet resolves to.
    /// @dev    Deliberately returns the `personId` and a registration flag rather than the whole
    ///         investor struct. Lost-key recovery needs to prove two wallets are the SAME
    ///         investor and nothing else; handing it the full record would couple every
    ///         consumer to the registry's storage layout and put personal-data-adjacent fields
    ///         in reach of contracts that have no business reading them.
    function personIdOf(address wallet) external view returns (bytes32 personId, bool registered);

    /// @notice This wallet's raw classification on one axis.
    /// @dev    ⚠️ `isSet` IS NOT A CONVENIENCE AND MUST NOT BE DROPPED. `value == 0` cannot carry
    ///         "unclassified" for a generic axis: the MiFID encoding happens to reserve zero
    ///         (`Tier.Unset`) but a second regime is free to give zero a meaning — a national
    ///         overlay could reasonably encode its base case as 0. Collapse the two and an unclassified
    ///         investor reads as a real classification and the covenant predicate SILENTLY
    ///         MATCHES, which is the fail-open dressed as a passing check that rule 5 exists to
    ///         stop. Consumers treat `!isSet` as unevaluable, never as not-applicable.
    function classificationOf(address wallet, bytes32 axisId) external view returns (uint8 value, bool isSet);

    /// @notice The MiFID limb of `classificationOf`, typed.
    /// @dev    A view over `classificationOf(wallet, AXIS_MIFID)`, not a second store. There is
    ///         exactly one copy of this value and both reads reach it.
    function tierOf(address wallet) external view returns (Tier);
}

/// @notice Implemented by every contract holding person- or wallet-linked state that a GDPR
///         Art 17 erasure has to reach. `PersonErasure` fans out over the registered set.
/// @dev    ⚠️ THE `wallets` ARGUMENT IS NOT A CONVENIENCE, IT IS THE REASON THE COORDINATOR
///         EXISTS. Three implementers (`CovenantRegistry`, and the wallet-side state in
///         `MemberEligibility` and `SubscriptionEscrow`) are keyed by ADDRESS and hold no
///         person key of their own, so they cannot resolve a `personId` to the addresses they
///         must clear. Only `IdentityRegistry` can, which is why the coordinator resolves the
///         list first, passes it to every target, and erases the registry LAST. Reverse that
///         order and every wallet-keyed target is handed a person it can no longer expand.
/// @dev    An implementer that finds nothing to erase MUST return quietly rather than revert:
///         the fan-out is atomic, and a person who never subscribed to an offer would
///         otherwise make their own erasure impossible. An implementer that finds state it
///         is not yet lawfully permitted to erase MUST revert — that is a real conflict and
///         it should stop the whole act until governance resolves it with `skipTarget`.
interface IErasable {
    function erasePerson(bytes32 personId, address[] calldata wallets) external;
}

/// @notice The rule-engine limb consumed by the token's transfer hook.
/// @dev    ⚠️ RENAMED FROM `ICompliance` WHEN THE SUITE ADOPTED EIP-3643. The old name now
///         belongs to the standard's interface in `IERC3643.sol`, and two interfaces with one
///         name — one of them normative — is exactly the ambiguity a conformance test cannot
///         see. `ModularCompliance` implements both; the token calls THIS one internally.
/// @dev    ⚠️ `canTransfer` HERE AND `ICompliance.canTransfer` IN THE STANDARD ARE THE SAME
///         SELECTOR, deliberately. Same name, same parameters, same `bool` return — so one
///         implementation satisfies both and there is no shim to drift. Do not "disambiguate"
///         it by renaming either side.
interface IComplianceGate {
    /// @dev Runs BEFORE the balance write, so a veto prevents the movement. Reverting rather
    ///      than boolean because the token must not be able to ignore the answer.
    function checkTransfer(address from, address to, uint256 amount) external view;

    /// @dev Non-reverting form. `DistributionAgent` uses this rather than `checkTransfer`
    ///      because a payout run must skip an ineligible holder, not abort the whole run.
    function canTransfer(address from, address to, uint256 amount) external view returns (bool);

    /// @dev Runs AFTER the write, so counter-keeping modules observe the settled position
    ///      rather than an intended one that may still revert.
    /// @dev ⚠️ NOT REPLACEABLE BY THE STANDARD'S `transferred` / `created` / `destroyed`. Those
    ///      three split one notification across three entry points by movement TYPE, which
    ///      means every counter-keeping module would have to be told which of the three it is
    ///      in. This suite passes mint as `from == address(0)` and burn as `to == address(0)`
    ///      and lets each module decide whether it cares — `CovenantGate` treats mint as its
    ///      own gate, `EltifConcentration` counts it, a holding-period lock ignores it.
    ///      `ModularCompliance` implements the standard's trio ON TOP of this one.
    function notifyTransfer(address from, address to, uint256 amount) external;
}

/// @notice The anchor limb of the document registry.
/// @dev    Consumers read a version hash or an approval status; none of them write. Anchoring is
///         a governance action on the registry itself.
interface IDocumentAnchor {
    function currentVersionHash(bytes32 docRef) external view returns (bytes32);

    function documentStatus(bytes32 documentHash) external view returns (bool exists, uint64 approvedAt);

    function isCurrent(bytes32 docRef, bytes32 versionHash) external view returns (bool);

    function versionCount(bytes32 docRef) external view returns (uint256);

    function versionAt(bytes32 docRef, uint256 index) external view returns (Version memory);

    function regimeOf(bytes32 docRef) external view returns (Regime);
}

/// @notice The closed-period limb consumed by the buy-back path.
interface IClosedPeriodGate {
    function isFrozen(address wallet) external view returns (bool);

    function activePeriod() external view returns (bool active, uint256 periodId);
}

/// @notice The declared-person register behind the closed-period freeze.
/// @dev    The register is the only possible source of the flag set — a closely associated
///         person's wallet is not derivable from onboarding data, so it must be declared.
interface IDeclaredPersonRegister {
    function isDeclared(address wallet) external view returns (bool);

    function personOf(address wallet) external view returns (bytes32);
}

/// @notice The balance and supply limb consumed by the income and buy-back modules.
/// @dev    ⚠️ NOT A SUBSET OF `IERC3643` BY ACCIDENT — KEEP IT NARROW. `BuybackAgent`,
///         `CouponSchedule` and `LmtGate` need a balance, a supply and a burn. Re-typing them
///         onto the full `IERC3643` would hand a coupon schedule `forcedTransfer`,
///         `setAddressFrozen` and `recoveryAddress`, and the reason those are agent-gated on
///         the implementation is that nothing else should be able to reach them at all.
interface ISecurityToken {
    function balanceOf(address wallet) external view returns (uint256);

    function totalSupply() external view returns (uint256);

    function transferFrom(address from, address to, uint256 amount) external returns (bool);

    /// @dev Agent-gated on the implementation. Declared here because the buy-back path burns
    ///      repurchased units rather than holding them.
    function burn(address from, uint256 amount) external;
}

/// @notice The payout limb consumed by coupon and waterfall schedules.
interface IDistributionSink {
    function distribution(uint256 id) external view returns (Distribution memory);
}

// NOTE: a previous `IMarketEvents` interface declared here was deleted on 2026-09-08 as a
// DUPLICATE — nothing implemented it, and `IMarketEventSchema` in `MarketEventSchema.sol` is the
// one event schema. ⚠️ **It was not deleted for carrying counterparty addresses, and nothing
// should be "fixed" on that reading.** A wallet as the subject of its own action is exactly what
// the event-payload rule permits: `TradeReportable` carries `buyer` and `seller` addresses by
// design, because the reporting bridge needs a join key and the ledger already shows the transfer.
// What the rule bars is the person KEY and person ATTRIBUTES — `personId`, tier, jurisdiction,
// a national-identifier hash, a reason or a class. Those are storage reads, never log entries.

/// @notice The protocol-level pause every value-moving path reads.
/// @dev    Implemented by `DoraGovernor`. This is what makes the oracle circuit-breaker trip a
///         CONTROL rather than an event: `ValuationOracle` calls `tripFromOracle`, the governor
///         sets `paused`, and every consumer of this interface stops moving value until
///         governance lifts it. Before 2026-09-08 nothing read the flag, so the trip halted
///         nothing — the exact "satisfied only by an event" defect the design's §9 forbids.
///         ⚠️ Consumers read this on VOLUNTARY and ACQUISITION paths only. A forced transfer, a
///         lost-key recovery, a repayment or a disposal must still execute during a pause — an
///         incident is not a reason to prevent a court order or trap a fund in breach.
interface IProtocolPause {
    function paused() external view returns (bool);
}

/// @notice The person-scoped restriction limb, as the transfer hook consumes it.
/// @dev    ⚠️ NARROWER THAN IT LOOKS ON PURPOSE. The store behind this interface holds **every**
///         reason a wallet may not move — a sanctions listing, an Art 75 suspicion block, a
///         probate hold, a court attachment, a lost-key hold — under one flag, and this surface
///         exposes no way to ask which. There is no `reasonOf`, no class enum and no per-entry
///         read here, because a consumer that could distinguish the classes would put that
///         distinction on a public execution path. Operator tooling reads the concrete contract;
///         the hook reads this.
/// @dev    ⚠️ `assertTransferPermitted` REVERTS, and every revert on the restriction path is one
///         argument-free generic error. Not a style choice: tipping-off is an individual
///         criminal offence in most Member States, and a typed reason on a public ledger
///         discloses to everyone. Even an address argument is too much — on a two-sided check it
///         tells the caller which side failed.
interface IRestrictedParty {
    function assertTransferPermitted(address from, address to) external view;

    function assertNotBlocked(address wallet) external view;

    function isBlocked(address wallet) external view returns (bool);

    /// @dev The re-screening obligation runs against the WHOLE existing base on every list
    ///      update, not just new joiners. The sweep itself is off-chain and unbounded; this is
    ///      how a consumer asks whether it has fallen behind.
    function screeningIsStale() external view returns (bool);
}

/// @notice The valuation limb, as the four fund modules consume it. Implemented by
///         `ValuationOracle`; held behind an AIFM/ManCo setter in every consumer (DORA Art 28).
/// @dev    This is the oracle's REAL read surface, not a paraphrase of it. An earlier
///         declaration here (`latest` / `latestFailClosed`) was implemented by nothing, so the
///         consumers stayed typed on the concrete contract — deleted 2026-09-08.
///         Two reads, on purpose (design §9): `value` REVERTS on stale, halted or unconfigured
///         and is for anything that acquires, draws or sizes a payout; `peek` never reverts and
///         is for passive rechecks. `acceptedAt` is what a consumer stores to know whether the
///         figure it last absorbed is still the oracle's current one — the sync-currency test
///         every active path runs since 2026-09-08.
interface IValuationFeed {
    function value(bytes32 assetId) external view returns (uint256);

    function peek(bytes32 assetId)
        external
        view
        returns (uint256 lastValue, uint64 acceptedAt, bool fresh, bool halted);

    function isFresh(bytes32 assetId) external view returns (bool);

    function acceptedAt(bytes32 assetId) external view returns (uint64);
}
