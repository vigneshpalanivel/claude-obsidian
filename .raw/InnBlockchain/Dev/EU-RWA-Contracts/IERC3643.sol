// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title IERC3643 and the EIP-3643 registry interfaces (illustrative sample — not production code)
///
/// @notice The EIP-3643 interface set, transcribed from the **specification text** of the
///         finalised EIP. This file is the one place in the suite where a name, a parameter
///         order or an event signature is NORMATIVE rather than descriptive.
///
/// @dev    ⚠️ PROVENANCE — READ BEFORE ADDING A LINE TO THIS FILE.
///         Written from the EIP-3643 specification. **No source was taken from Tokeny's T-REX
///         implementation, from ONCHAINID, or from any other GPL-licensed implementation of
///         this standard**, and none may be added. T-REX and ONCHAINID are published under
///         GPL-3.0; GPL-3.0 is copyleft, and a derivative work must itself be GPL-3.0 with
///         source available when distributed. **Every client engagement on this suite is
///         either permissive or proprietary, so a single copied file would be a licence defect
///         in the delivered product, not a style issue.**
///
///         An EIP is a specification and is free to implement. Implementing it *is* what
///         conformance means. **The line is source code, not vocabulary** — the names below are
///         the standard and must be used exactly.
///
///         Enforcement is mechanical, not editorial: per-file SPDX headers, a dependency
///         allow-list, and a CI check that fails on any import resolving to a GPL-licensed
///         package. See `ERC-3643-CONFORMANCE.md`. The whole licence position of this codebase
///         rests on a negative claim, and a negative claim is only as good as the thing that
///         continuously tests it.
///
/// @dev    ⚠️ CONFORMANCE IS QUALIFIED AND THE QUALIFICATION IS NOT OPTIONAL READING.
///         Full on `IERC3643`, `ICompliance`, `ITrustedIssuersRegistry` and
///         `IClaimTopicsRegistry`. **Declared deviation on `IIdentityRegistry`** — the storage
///         behind it is keyed by PERSON, not by wallet, and `identity()` / `investorCountry()`
///         are resolved rather than stored. Every deviation is registered in
///         `ERC-3643-CONFORMANCE.md` **before** it is written in code.
///         **Do not write "ERC-3643 compliant" unqualified anywhere an NCA or an investor
///         reads it.** The token standard is a prospectus content item (Prospectus Arts 6 and
///         16(1)), so an overstated conformance claim is a defect in a disclosure document.
///
/// @dev    ⚠️ THE STANDARD DOES NOT DELIVER THE WHOLE DESIGN, AND ASSUMING IT DOES UNDER-SCOPES
///         THE BUILD BY ITS LARGEST CUSTOM COMPONENT. Of the seven capabilities this suite owes:
///           • C1 pre-validation, C3 trusted issuers/claims, C4 rule modularity and
///             C5 freeze/forced-transfer/recovery bind here.
///           • C2 identity binds here WITH the deviation above.
///           • **C6 partitions/tranches is not in ERC-3643** — custom, ERC-1410-style.
///           • **C7 investor covenants is not in ERC-3643** — wholly custom,
///             `CovenantRegistry`. Neither this standard nor ERC-1400 models the investor's
///             own word.
///           • **Document anchoring is not in ERC-3643** — the ERC-1643 pattern is retained,
///             `DocumentRegistry`.
///
/// @dev    ⚠️ THE NARROW INTERNAL INTERFACES IN `Interfaces.sol` ARE NOT REPLACED BY THIS FILE
///         AND MUST NOT BE COLLAPSED INTO IT. `IIdentityGate.checkEligible` REVERTS where
///         `IIdentityRegistry.isVerified` returns a boolean, and that is a compliance
///         difference rather than a taste one: the reverting form carries the informative-class
///         errors a holder can act on, while every OPAQUE stop stays in `IRestrictedParty`
///         behind one argument-free error for AMLR Art 76 (tipping-off) reasons. A consumer
///         should still depend on the smallest surface it actually calls. This file is what the
///         OUTSIDE world — a venue, a custodian, a wallet, an explorer — is entitled to assume.

// ═══════════════════════════════════════════════════════════════════════════
// IERC20 — the base the standard extends
// ═══════════════════════════════════════════════════════════════════════════

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transfer(address to, uint256 amount) external returns (bool);

    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

// ═══════════════════════════════════════════════════════════════════════════
// IIdentity — the on-chain identity the standard types its registry against
// ═══════════════════════════════════════════════════════════════════════════

/// @notice The per-investor on-chain identity contract EIP-3643's registry is typed against.
///
/// @dev    ⚠️ WHAT SITS BEHIND THIS TYPE IS AN OPEN DECISION (design §16 D19), AND IT IS A DATA
///         PROTECTION DECISION BEFORE IT IS AN ENGINEERING ONE. Do not resolve it by writing
///         code. The standard states that a conforming token MUST be used in combination with
///         an on-chain identity system and types the registry against a deployed per-investor
///         contract. **A deployed per-investor identity contract is a persistent, unique,
///         on-chain identifier bound to an identified natural person, and it cannot be erased.**
///         The suite discharges GDPR Art 17 by deleting the off-chain record and orphaning an
///         on-chain anchor (`PersonErasure`); a deployed contract does not degrade that way.
///         The second limb is linkability — an identity reused across issuers correlates one
///         investor across every platform they touch, which is a commercial feature of the
///         model and a data-protection problem.
///
///         Three candidate answers, none of them adopted here:
///           (a) Deploy a minimal OWN-CODE `IIdentity`-conformant contract **per person** — not
///               per wallet, which matches both the "one identity, many wallets" model and this
///               suite's person key. Full conformance; pays the erasure residual in full and
///               needs DPO sign-off plus a DPIA entry.
///           (b) Return `address(0)` and treat the third `recoveryAddress` argument as unused.
///               Cheapest and least honest: a conformant signature over an absent capability,
///               and a venue whose tooling dereferences the result breaks against us.
///               **If chosen it must be DISCLOSED in the prospectus, not defaulted into.**
///           (c) Return a non-dereferenceable person handle. Keeps the join for tooling that
///               only compares identities; still a stable per-person on-chain identifier, so it
///               inherits most of (a)'s problem while buying less.
///
///         `IdentityRegistry` currently implements **(c)**, reversibly, and says so at the call
///         site. Nothing here should be read as the decision having been made.
///
/// @dev    ⚠️ THIS IS A MINIMAL DECLARATION AND IS DELIBERATELY NOT ERC-734/ERC-735.
///         ONCHAINID implements ERC-734/735, **which were never merged as EIPs** — they are
///         abandoned 2017 proposals, a fact Tokeny's own published audit records. Transcribing
///         a withdrawn draft to look more standard would be conformance theatre. Declared here
///         is only what EIP-3643 itself needs to type against.
interface IIdentity {
    /// @notice The claim-read surface a verifier needs. Present for typing and for the
    ///         "tooling that only compares identities" case in (c) above.
    function getClaim(bytes32 _claimId)
        external
        view
        returns (
            uint256 topic,
            uint256 scheme,
            address issuer,
            bytes memory signature,
            bytes memory data,
            string memory uri
        );

    function getClaimIdsByTopic(uint256 _topic) external view returns (bytes32[] memory claimIds);
}

/// @notice A trusted issuer, as the trusted-issuers registry types it.
/// @dev    Declared for signature conformance. This suite verifies claims in
///         `IdentityRegistry` against `TrustedIssuersRegistry`, so nothing in the hot path
///         dereferences this type.
interface IClaimIssuer is IIdentity {
    function isClaimValid(
        IIdentity _identity,
        uint256 _claimTopic,
        bytes calldata _sig,
        bytes calldata _data
    ) external view returns (bool);
}

// ═══════════════════════════════════════════════════════════════════════════
// IAgentRole — the operational role the standard requires on THREE contracts
// ═══════════════════════════════════════════════════════════════════════════

/// @notice EIP-3643's agent role.
///
/// @dev    ⚠️ THIS INTERFACE WAS MISSING FROM THIS FILE UNTIL 2026-09-11, AND ITS ABSENCE WAS
///         NOT A DECLARED DEVIATION — IT WAS AN OVERSIGHT. Recording how it survived, because
///         the mechanism will hide the next one too: `IAgentRole` is the only interface in the
///         standard that has **no published asset file** in `ethereum/ERCs/assets/erc-3643/`.
///         It exists only inline in the specification body. A transcription pass driven by the
///         asset directory therefore produces a file that looks complete and is not.
///         **Read the spec body, not the asset listing.**
///
/// @dev    THE STANDARD REQUIRES THIS SURFACE ON THREE CONTRACTS, NOT ONE. The spec states, in
///         three separate places, that "any contract that fulfills the role of a Token contract
///         / an Identity Registry / an Identity Registry Storage within the context of this
///         standard must be compatible with the `IAgentRole` interface." It is also one of the
///         standard's eleven normative MUSTs: a conforming build **"MUST define an Agent role
///         and an Owner (token issuer) role."**
///
///         In this suite:
///           • `SecurityToken`    — implements it. The agent is the operations desk (mint,
///                                  burn, freeze, forced transfer, recovery — the C5 surface).
///           • `IdentityRegistry` — implements it, over the pre-existing `isRegistrar` mapping.
///                                  The registrar IS the standard's agent: the EIP says only an
///                                  agent may add or remove identities, which is exactly what
///                                  `onlyRegistrar` already gated. The role was conformant in
///                                  substance and unreachable under the standard's names.
///           • Identity Registry Storage — **not implemented, because the storage contract is
///                                  not implemented at all.** See D-I5.
///
/// @dev    ⚠️ THE OWNER HALF OF THAT MUST IS A DECLARED DEVIATION — SEE D-A2. The spec vests
///         the owner role in ERC-173 (`owner()`, `transferOwnership()`) and makes appointing and
///         removing agents the owner's responsibility. This suite's owner is `governance`, which
///         is `immutable` and has no transfer path, deliberately. The role exists and satisfies
///         the MUST; the ERC-173 *surface* does not exist and is registered as a deviation
///         rather than added — see `ERC-3643-CONFORMANCE.md` §4.5.
///
/// @dev    NOT A SUBSTITUTE FOR THE SUITE'S OWN ROLE EVENTS. `AgentSet(agent, bool)` on the
///         token and `RegistrarSet(registrar, bool)` on the registry carry the grant and the
///         revocation in ONE event with a boolean, which is what the suite's own tooling reads.
///         The standard splits them across two events and has no field for the flag. Both are
///         emitted on every role change — the standard's for its listeners, the suite's for
///         ours. **Never one instead of the other.**
interface IAgentRole {
    event AgentAdded(address indexed _agent);
    event AgentRemoved(address indexed _agent);

    function addAgent(address _agent) external;

    function removeAgent(address _agent) external;

    function isAgent(address _agent) external view returns (bool);
}

// ═══════════════════════════════════════════════════════════════════════════
// IClaimTopicsRegistry — C3, the required-claim catalogue
// ═══════════════════════════════════════════════════════════════════════════

interface IClaimTopicsRegistry {
    event ClaimTopicAdded(uint256 indexed claimTopic);
    event ClaimTopicRemoved(uint256 indexed claimTopic);

    function addClaimTopic(uint256 _claimTopic) external;

    function removeClaimTopic(uint256 _claimTopic) external;

    function getClaimTopics() external view returns (uint256[] memory);
}

// ═══════════════════════════════════════════════════════════════════════════
// ITrustedIssuersRegistry — C3, who may attest
// ═══════════════════════════════════════════════════════════════════════════

interface ITrustedIssuersRegistry {
    event TrustedIssuerAdded(IClaimIssuer indexed trustedIssuer, uint256[] claimTopics);
    event TrustedIssuerRemoved(IClaimIssuer indexed trustedIssuer);
    event ClaimTopicsUpdated(IClaimIssuer indexed trustedIssuer, uint256[] claimTopics);

    function addTrustedIssuer(IClaimIssuer _trustedIssuer, uint256[] calldata _claimTopics) external;

    function removeTrustedIssuer(IClaimIssuer _trustedIssuer) external;

    function updateIssuerClaimTopics(IClaimIssuer _trustedIssuer, uint256[] calldata _claimTopics) external;

    function getTrustedIssuers() external view returns (IClaimIssuer[] memory);

    function getTrustedIssuersForClaimTopic(uint256 claimTopic) external view returns (IClaimIssuer[] memory);

    function isTrustedIssuer(address _issuer) external view returns (bool);

    function getTrustedIssuerClaimTopics(IClaimIssuer _trustedIssuer) external view returns (uint256[] memory);

    function hasClaimTopic(address _issuer, uint256 _claimTopic) external view returns (bool);
}

// ═══════════════════════════════════════════════════════════════════════════
// IIdentityRegistryStorage — declared for typing. ⚠️ NOTHING IMPLEMENTS IT.
// ═══════════════════════════════════════════════════════════════════════════

/// @notice EIP-3643's shared identity-storage interface.
///
/// @dev    ⚠️ DECLARED IN FULL AND DELIBERATELY NOT IMPLEMENTED. This is D-I5, and the reason is
///         a data-protection one rather than an engineering one: the storage contract's whole
///         purpose is to let SEVERAL tokens share ONE person register, and cross-issuer sharing
///         of a person register is the **linkability limb of design §16 D19** — one address
///         correlating one investor across every platform they touch. That is a commercial
///         feature of the model and a GDPR problem, and this suite declines it.
///
/// @dev    WHY DECLARE IT AT ALL, GIVEN NOTHING IMPLEMENTS IT. Two reasons, and the first is the
///         load-bearing one. **(1)** `IIdentityRegistry.identityStorage()` is typed to return
///         this interface, so the type must exist for the registry's own conformance to compile
///         — declaring it is what lets `identityStorage()` be present-and-honest rather than
///         absent. **(2)** An operator who later accepts the linkability residual has the
///         standard's surface already written and can bind to it without re-deriving it from
///         the spec, which is where transcription errors enter.
///
/// @dev    ⚠️ THE AGENT MODEL HERE IS NOT THE TOKEN'S. The spec requires this contract to be
///         `IAgentRole`-compatible too, but its agents are the **bound identity registries**,
///         appointed through `bindIdentityRegistry` rather than through `addAgent`. A future
///         implementer must not wire this to the token's agent set.
interface IIdentityRegistryStorage {
    event IdentityStored(address indexed investorAddress, IIdentity indexed identity);
    event IdentityUnstored(address indexed investorAddress, IIdentity indexed identity);
    event IdentityModified(IIdentity indexed oldIdentity, IIdentity indexed newIdentity);
    event CountryModified(address indexed investorAddress, uint16 indexed country);
    event IdentityRegistryBound(address indexed identityRegistry);
    event IdentityRegistryUnbound(address indexed identityRegistry);

    function addIdentityToStorage(address _userAddress, IIdentity _identity, uint16 _country) external;

    function removeIdentityFromStorage(address _userAddress) external;

    function modifyStoredInvestorCountry(address _userAddress, uint16 _country) external;

    function modifyStoredIdentity(address _userAddress, IIdentity _identity) external;

    function bindIdentityRegistry(address _identityRegistry) external;

    function unbindIdentityRegistry(address _identityRegistry) external;

    function linkedIdentityRegistries() external view returns (address[] memory);

    function storedIdentity(address _userAddress) external view returns (IIdentity);

    function storedInvestorCountry(address _userAddress) external view returns (uint16);
}

// ═══════════════════════════════════════════════════════════════════════════
// IIdentityRegistry — C2. ⚠️ THE DEVIATION SURFACE.
// ═══════════════════════════════════════════════════════════════════════════

/// @notice EIP-3643's identity registry interface.
///
/// @dev    ⚠️ THREE COLLISIONS WITH THIS DESIGN. ONE RESOLVES CLEANLY, TWO DO NOT, AND THE
///         DIFFERENCE IS STORAGE VERSUS INTERFACE. Registered in `ERC-3643-CONFORMANCE.md`.
///
///         **(1) The registry is wallet-keyed — RESOLVED, and reverting it is not on the
///         table.** `registerIdentity(address …)`, `identity(address)` and
///         `investorCountry(address)` all key on the wallet. This suite keys ATTRIBUTES by
///         person, because wallet-keyed attributes let one human hold two jurisdictions and two
///         client tiers across two addresses — a Prospectus **Art 3(2)** Member-State-shopping
///         surface and an **Art 1(4)(b)** headcount bypass — and because an erasure request has
///         no person record to delete. **But that fix was about where attributes are STORED,
///         not about the shape of the read.** A wallet-keyed INTERFACE over person-keyed
///         STORAGE satisfies both: `wallet → personId → attribute`, with `registerIdentity`
///         writing through to the person record and reverting `PersonAttributesMismatch` on any
///         attribute divergence. The guarantee is unweakened, behind a conformant signature.
///         **Conforming by reverting to wallet-keyed storage would re-open a control defect to
///         satisfy an interface.**
///
///         **(2) `IIdentity` per investor — NOT RESOLVED.** See `IIdentity` above and design
///         §16 D19. Owned by the DPO.
///
///         **(3) `uint16 _country` on-chain, mandatory — NOT RESOLVED.** Design §16 D21 asks
///         whether jurisdiction may sit on-chain AT ALL, or whether a derived boolean would
///         satisfy GDPR Art 5(1)(c) minimisation. **The standard answers that question in the
///         direction §10 of the design has asserted is wrong since its first revision.** If the
///         DPO rules jurisdiction off-chain, `investorCountry()` becomes a SECOND declared
///         deviation — not a bug, and not a reason to reverse the standard.
///         ⚠️ **The inference that must not be drawn is the reverse one: "the standard requires
///         it, therefore it is permitted."** A standards body cannot supply a legal basis.
interface IIdentityRegistry {
    event ClaimTopicsRegistrySet(address indexed claimTopicsRegistry);
    event IdentityStorageSet(address indexed identityStorage);
    event TrustedIssuersRegistrySet(address indexed trustedIssuersRegistry);
    event IdentityRegistered(address indexed investorAddress, IIdentity indexed identity);
    event IdentityRemoved(address indexed investorAddress, IIdentity indexed identity);
    event IdentityUpdated(IIdentity indexed oldIdentity, IIdentity indexed newIdentity);
    event CountryUpdated(address indexed investorAddress, uint16 indexed country);

    function registerIdentity(address _userAddress, IIdentity _identity, uint16 _country) external;

    function deleteIdentity(address _userAddress) external;

    /// @dev ⚠️ THE THREE SETTERS BELOW WERE MISSING FROM THIS INTERFACE UNTIL 2026-09-11. Two of
    ///      them existed on `IdentityRegistry` the whole time under the suite's OWN names
    ///      (`setClaimTopics`, `setTrustedIssuers`) and already emitted the EIP's events — so the
    ///      capability was present, conformant in behaviour, and **unreachable by any caller
    ///      holding the standard's ABI**. That is the failure mode worth naming: a house-style
    ///      rename is invisible to a member count and fatal to interoperability, which is the
    ///      one thing conformance was adopted to buy. The EIP names are now the functions and
    ///      the house names are the aliases, not the other way round.
    /// @dev These are OWNER acts in the standard, not agent acts — the spec scopes them to "the
    ///      wallet set as owner", which is `governance` here. Do not gate them `onlyAgent`.
    function setIdentityRegistryStorage(address _identityRegistryStorage) external;

    function setClaimTopicsRegistry(address _claimTopicsRegistry) external;

    function setTrustedIssuersRegistry(address _trustedIssuersRegistry) external;

    function updateCountry(address _userAddress, uint16 _country) external;

    function updateIdentity(address _userAddress, IIdentity _identity) external;

    function batchRegisterIdentity(
        address[] calldata _userAddresses,
        IIdentity[] calldata _identities,
        uint16[] calldata _countries
    ) external;

    function contains(address _userAddress) external view returns (bool);

    function isVerified(address _userAddress) external view returns (bool);

    function identity(address _userAddress) external view returns (IIdentity);

    function investorCountry(address _userAddress) external view returns (uint16);

    /// @dev ⚠️ RETURNS `address(0)` IN THIS SUITE — the storage contract is not implemented and
    ///      that is D-I5, a data-protection refusal rather than an omission. Declared and
    ///      answered honestly rather than left absent: a caller that dereferences the result
    ///      fails loudly at the call site, which is strictly better than failing at ABI
    ///      resolution with no indication of why. Same reasoning as `identity()`'s option (c).
    function identityStorage() external view returns (IIdentityRegistryStorage);

    function issuersRegistry() external view returns (ITrustedIssuersRegistry);

    function topicsRegistry() external view returns (IClaimTopicsRegistry);
}

// ═══════════════════════════════════════════════════════════════════════════
// ICompliance — C4, the rule engine
// ═══════════════════════════════════════════════════════════════════════════

/// @notice EIP-3643's modular-compliance interface.
///
/// @dev    ✅ `canTransfer` RETURNING A BOOL IS A SMALL, REAL WIN AND NOT A COMPROMISE.
///         The standard's own gate discloses no reason to the caller, so the reason-opacity
///         limb of C1 — **AMLR Art 76**, where telling a customer they are under analysis is an
///         individual criminal offence in most Member States — is satisfied BY the interface
///         rather than against it. The suite's named per-module errors sit ABOVE this boolean,
///         on `IComplianceGate.checkTransfer`, and are routed to the operator. **A generic-class
///         module must never surface its reason through either path.**
interface ICompliance {
    event TokenBound(address _token);
    event TokenUnbound(address _token);

    function bindToken(address _token) external;

    function unbindToken(address _token) external;

    function transferred(address _from, address _to, uint256 _amount) external;

    function created(address _to, uint256 _amount) external;

    function destroyed(address _from, uint256 _amount) external;

    /// @dev ⚠️ THE EIP MEMBER. Missing until 2026-09-11, with `isTokenBound` below standing in
    ///      for it — a SUBSTITUTION, which is the one defect class a member count cannot see:
    ///      the totals matched, the substitute was strictly safer than the original, and the
    ///      surface was still not the standard's. See `ModularCompliance.getTokenBound`.
    function getTokenBound() external view returns (address);

    /// @dev ⚠️ NOT AN EIP MEMBER — a suite supplement, retained IN ADDITION to `getTokenBound()`.
    ///      Declaring it here is deliberate: it keeps the extension visible to anyone diffing
    ///      this file against the published interface, rather than hiding on the implementation.
    function isTokenBound(address _token) external view returns (bool);

    function canTransfer(address _from, address _to, uint256 _amount) external view returns (bool);
}

// ═══════════════════════════════════════════════════════════════════════════
// IERC3643 — the token
// ═══════════════════════════════════════════════════════════════════════════

/// @notice The permissioned security token interface. Extends IERC20.
///
/// @dev    ⚠️ THERE IS NO ADAPTER SHAPE FOR THIS INTERFACE AND ATTEMPTING ONE IS A DEFECT.
///         Balances, the transfer path and the compliance hook must live in ONE contract.
///         Wrapping a plain token in an `IERC3643` facade splits `balanceOf` across two
///         addresses, breaks every wallet and explorer integration, and — the part that is not
///         a usability problem — **breaks the DLT Pilot Art 5(2) integrity-of-issue invariant**,
///         which requires the number of instruments recorded to equal the number in the issue
///         at any given time. `SecurityToken` implements this natively for that reason.
///
/// @dev    ⚠️ `setAddressFrozen` IS THE HOLDINGS FREEZE, NOT THE SANCTIONS STOP, AND CONFLATING
///         THEM IS THE MOST LIKELY MISREADING OF THIS INTERFACE. A sanctions listing, a probate
///         hold or a court attachment lives in `RestrictedPartyRegistry`, is keyed by PERSON so
///         it follows the human across every wallet they hold, and is read in the token's
///         MANDATORY layer — above the module list, where no governance action reaches it. The
///         standard has no equivalent and does not know the difference.
interface IERC3643 is IERC20 {
    event UpdatedTokenInformation(
        string _newName,
        string _newSymbol,
        uint8 _newDecimals,
        string _newVersion,
        address _newOnchainID
    );
    event IdentityRegistryAdded(address indexed _identityRegistry);
    event ComplianceAdded(address indexed _compliance);
    event RecoverySuccess(address indexed _lostWallet, address indexed _newWallet, address indexed _investorOnchainID);
    event AddressFrozen(address indexed _userAddress, bool indexed _isFrozen, address indexed _owner);
    event TokensFrozen(address indexed _userAddress, uint256 _amount);
    event TokensUnfrozen(address indexed _userAddress, uint256 _amount);
    event Paused(address _userAddress);
    event Unpaused(address _userAddress);

    // ── token information ──────────────────────────────────────────────────

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function decimals() external view returns (uint8);

    function onchainID() external view returns (address);

    function version() external view returns (string memory);

    function identityRegistry() external view returns (IIdentityRegistry);

    function compliance() external view returns (ICompliance);

    function paused() external view returns (bool);

    function isFrozen(address _userAddress) external view returns (bool);

    function getFrozenTokens(address _userAddress) external view returns (uint256);

    // ── administration ─────────────────────────────────────────────────────

    function setName(string calldata _name) external;

    function setSymbol(string calldata _symbol) external;

    function setOnchainID(address _onchainID) external;

    function pause() external;

    function unpause() external;

    function setAddressFrozen(address _userAddress, bool _freeze) external;

    function freezePartialTokens(address _userAddress, uint256 _amount) external;

    function unfreezePartialTokens(address _userAddress, uint256 _amount) external;

    function setIdentityRegistry(address _identityRegistry) external;

    function setCompliance(address _compliance) external;

    // ── transfer actions ───────────────────────────────────────────────────

    function forcedTransfer(address _from, address _to, uint256 _amount) external returns (bool);

    function mint(address _to, uint256 _amount) external;

    function burn(address _userAddress, uint256 _amount) external;

    function recoveryAddress(
        address _lostWallet,
        address _newWallet,
        address _investorOnchainID
    ) external returns (bool);

    // ── batch functions ────────────────────────────────────────────────────
    //
    // ⚠️ Present for conformance and genuinely useful for an operations desk, but every batch
    //    entry runs the SAME full gate as its single-call equivalent. A batch that short-cut
    //    the hook "for gas" would be the bypass — see `SecurityToken._check`.

    function batchTransfer(address[] calldata _toList, uint256[] calldata _amounts) external;

    function batchForcedTransfer(
        address[] calldata _fromList,
        address[] calldata _toList,
        uint256[] calldata _amounts
    ) external;

    function batchMint(address[] calldata _toList, uint256[] calldata _amounts) external;

    function batchBurn(address[] calldata _userAddresses, uint256[] calldata _amounts) external;

    function batchSetAddressFrozen(address[] calldata _userAddresses, bool[] calldata _freeze) external;

    function batchFreezePartialTokens(address[] calldata _userAddresses, uint256[] calldata _amounts) external;

    function batchUnfreezePartialTokens(address[] calldata _userAddresses, uint256[] calldata _amounts) external;
}
