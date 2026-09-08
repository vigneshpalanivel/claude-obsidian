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
enum Tier {
    Unset,
    Retail,
    ProfessionalOnRequest, // elective, and revocable
    PerSeProfessional,
    EligibleCounterparty
}

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
/// @dev    ⚠️ `checkEligible` REVERTS rather than returning a boolean, and the revert reason is
///         a single generic code for the whole block class. That is not a style choice: the
///         anti-money-laundering tipping-off prohibition makes it an individual criminal
///         offence in most Member States to disclose that a customer is under analysis, and a
///         typed revert reason on a public ledger discloses it to everyone. Informative status
///         codes go to the operator off-chain, never to the caller.
interface IIdentityGate {
    function checkEligible(address wallet) external view;

    function isEligible(address wallet) external view returns (bool);

    function jurisdictionOf(address wallet) external view returns (bytes32);

    /// @notice The off-chain investor record a wallet resolves to.
    /// @dev    Deliberately returns the pointer and a registration flag rather than the whole
    ///         investor struct. Lost-key recovery needs to prove two wallets are the SAME
    ///         investor and nothing else; handing it the full record would couple every
    ///         consumer to the registry's storage layout and put personal-data-adjacent fields
    ///         in reach of contracts that have no business reading them.
    function recordPointerOf(address wallet) external view returns (bytes32 pointer, bool registered);

    function tierOf(address wallet) external view returns (Tier);
}

/// @notice The rule-engine limb consumed by the token's transfer hook.
interface ICompliance {
    /// @dev Runs BEFORE the balance write, so a veto prevents the movement.
    function checkTransfer(address from, address to, uint256 amount) external view;

    /// @dev Non-reverting form. `DistributionAgent` uses this rather than `checkTransfer`
    ///      because a payout run must skip an ineligible holder, not abort the whole run.
    function canTransfer(address from, address to, uint256 amount) external view returns (bool);

    /// @dev Runs AFTER the write, so counter-keeping modules observe the settled position
    ///      rather than an intended one that may still revert.
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

/// @notice The event surface off-chain surveillance and reporting read.
/// @dev    ⚠️ THIS IS THE ONE DEPENDENCY IN THE SUITE THAT IS SAFE TO DETACH SILENTLY. Nothing
///         on-chain reads what it emits — it exists so off-chain systems receive ledger facts.
///         A client that owes no market-abuse surveillance on its own trading simply declares
///         it out of scope and no consumer reverts. Every other module here is read by a
///         `require` somewhere, so detaching it removes a control.
interface IMarketEvents {
    function emitTrade(bytes32 isinHash, address buyer, address seller, uint256 amount, uint256 price) external;

    function emitOrderEvent(bytes32 isinHash, bytes32 orderId, uint8 lifecycle) external;
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

/// @notice The valuation limb. Already governance-settable across the fund modules on
///         operational-resilience grounds; declared here so the pattern is uniform.
interface IValuationFeed {
    function latest(bytes32 feedId) external view returns (uint256 value, uint64 asOf);

    function latestFailClosed(bytes32 feedId) external view returns (uint256 value, uint64 asOf);
}
