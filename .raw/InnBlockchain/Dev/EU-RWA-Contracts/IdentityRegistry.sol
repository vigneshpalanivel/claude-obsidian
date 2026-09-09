// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IIdentityGate, Tier} from "./Interfaces.sol";

interface IClaimTopicsRegistry {
    function requiredTopics(bytes32 jurisdiction) external view returns (uint256[] memory);
}

interface ITrustedIssuersRegistry {
    function isTrustedFor(address issuer, uint256 topic, uint64 issuedAt) external view returns (bool);

    function canIssueNow(address issuer, uint256 topic) external view returns (bool);
}

/// @title IdentityRegistry (illustrative sample — not production code)
/// @notice C2 — holds the verified investor record for a PERSON, and binds one or more wallets
///         to it: MiFID II Art 24(1)/Annex II client tier, jurisdiction, natural-vs-legal
///         person, and the claim set written against it by issuers in `TrustedIssuersRegistry`.
///         Also carries the MiFIR identifier — LEI for legal persons, national client identifier
///         for natural persons — that transaction reporting and transparency require *before
///         execution*.
/// @dev    ⚠️ PERSON-KEYED SINCE 2026-09-09, AND THAT IS A CORRECTNESS FIX, NOT A TIDY-UP.
///         Until this revision every attribute lived in a per-wallet `Investor` struct, and
///         `registerInvestor` / `updateInvestor` took `jurisdiction` and `tier` per wallet with
///         nothing anywhere checking that two wallets under one `personId` agreed. One person
///         could therefore be FR/Retail on wallet A and DE/PerSeProfessional on wallet B, both
///         records perfectly valid. `SubscriptionEscrow` reads `jurisdictionOf(msg.sender)` for
///         the Prospectus Art 3(2) per-Member-State threshold and `tierOf(msg.sender)` for the
///         Art 1(4)(b) qualified-investor carve-out, so the divergence was directly monetisable
///         in two ways: subscribe from whichever wallet's country still had headroom, or from
///         whichever wallet read as qualified and skip the 149-person headcount entirely.
///         That is the same defect as the caller-supplied jurisdiction removed from the escrow
///         on 2026-09-08, one layer down — moving the trust from the caller to the registry
///         achieves nothing while the registry hands back whatever was written per address.
///         Person-keying does not *check* the invariant, it makes it unrepresentable: there is
///         one jurisdiction per person because there is one place to put it.
/// @dev    WHERE THE WALLET-KEYED SHAPE CAME FROM, since it was not arbitrary. ERC-3643/T-REX
///         keys its identity registry by wallet because the person-level attributes live
///         elsewhere — in the investor's own ONCHAINID contract. This suite deliberately does
///         not use ONCHAINID (a per-person deployed contract whose storage and CREATE2 address
///         both outlive an Art 17 request is the wrong substrate for EU personal data), but it
///         inherited T-REX's registry shape and pushed the attributes down into the wallet
///         record to compensate. The result kept the form of a design whose other half had been
///         removed. Consumers are unaffected: `IIdentityGate` is unchanged and every read is
///         still wallet-first, one indirection deeper.
/// @dev    ⚠️ TWO DIFFERENT QUESTIONS, TWO DIFFERENT FUNCTIONS, ON PURPOSE:
///           `checkEligible()`     — may this holder hold this instrument at all? (§4 gate)
///           `checkIdentifiable()` — is this holder identifiable to the MiFIR field
///                                   standard, i.e. does the record carry an LEI or NCI a
///                                   reporting bridge can put in a reportable field?
///         A wallet can pass one and fail the other. An issuer-only deployment typically
///         runs the first; a venue must run both, and must run the second *pre-trade*, not
///         at reporting time — by then the trade has already executed unreportably.
/// @dev    GDPR — THE STORAGE/LOG SPLIT, WHICH IS THE WHOLE DESIGN:
///         This contract *does* hold personal data. `jurisdiction`, `tier` and `personType`
///         are attributes of a natural person and pretending otherwise is how these
///         registries fail their first DPA review. What makes them defensible is Art 6(1)(c)
///         necessity, and necessity is a testable claim, not a label:
///
///           An attribute may sit in STORAGE only if a `require`/`revert` on this contract
///           reads it. Nothing may be written to a LOG that is not already erasable.
///
///         `jurisdiction` passes — `checkEligible()` feeds it to `requiredTopics()` and
///         reverts on the result, and the Prospectus Art 3(2) threshold that consumes it is
///         elected per Member State (EU default EUR 12m/12mo, or EUR 5m where a state so
///         elected), so a jurisdiction-blind gate cannot enforce it at all. Storage is also
///         reachable by `delete` — `erasePerson` wipes the record, so an Art 17 erasure
///         request can actually be honoured.
///         Event data cannot. It gates nothing, `delete` cannot reach it, and every archive
///         node keeps it forever — which is why the events below carry a wallet and nothing
///         else. See the note above them.
///         Off-chain by construction: the national client identifier is held only as a
///         SALTED hash (an unsalted hash of an NCI is brute-forceable and still personal
///         data), and the verified-record detail lives off-chain behind `personId`.
///         Destroying the off-chain record and its salt is what makes the surviving on-chain
///         hash meaningless — cryptographic erasure is the Art 17 answer here, not `delete`
///         alone.
/// @dev    ⚠️ ART 17 MINIMISATION IS A SECOND REASON FOR THE PERSON KEY, INDEPENDENT OF THE
///         GATE BUG. Under the wallet-keyed shape a person with three wallets held three
///         copies of their jurisdiction, tier, person type and salted NCI hash — three copies
///         of the same personal data, three writes to keep in step on a change of residence,
///         and three places for an erasure to miss. Art 5(1)(c) is not satisfied by "we
///         deleted all the copies we remembered about". There is now one copy.
/// @dev    ⚠️ ERASURE ACROSS THE SUITE IS NOT THIS CONTRACT'S JOB ALONE. `erasePerson` reaches
///         this registry and nothing else. `PdmrRegister`, `MemberEligibility`,
///         `CovenantRegistry` and `SubscriptionEscrow` each hold person- or wallet-linked
///         state of their own, and an Art 17 request is one request, not five transactions
///         somebody remembers to send. `PersonErasure` is the coordinator that fans out, and
///         it calls THIS contract LAST — because this is the only contract that maps
///         `personId → wallets`, and the wallet-keyed targets downstream have nothing to key
///         on once it is gone.
/// @dev    Not solved here, and not solvable here: an EDPB Guidelines 02/2025 assessment,
///         the Art 30 record, and the DPIA that Art 35(3)(b) makes mandatory the moment
///         sanctions/PEP screening writes a claim against this registry. The contract is
///         evidence for those documents, never a substitute for them.
/// @dev    ⚠️ SCREENING OUTCOMES ARE NOT CLAIMS. `TOPIC_AML_SCREENED` (topic 2) was retired on
///         2026-09-08. A per-wallet screening claim beside `RestrictedPartyRegistry` is a second
///         slot an observer can read — `rawClaim` is public and `checkEligible` reverts naming
///         the missing topic — so a vendor recording a hit as `AssertedFalse` on a claim rebuilt
///         the two-store leak the restriction store was consolidated to remove. A hit is
///         `RestrictedPartyRegistry.blockPerson` / `blockWallet`. A "clear" is nothing at all.
/// @dev    Declares `is IIdentityGate` (2026-09-08) so the compiler, not a reviewer, checks
///         that the surface `SecurityToken`, `RestrictedPartyRegistry` and the escrow call
///         through the interface is actually implemented here — `personIdOf` was once missing
///         for exactly the lack of this line. `Tier` is IMPORTED from `Interfaces.sol`, never
///         re-declared: a local copy is a different type to the compiler, and every consumer
///         that named `IdentityRegistry.Tier` was bound to this file's dependency tree for it.
contract IdentityRegistry is IIdentityGate {
    // ─────────────────────────── claim value — tri-state, deliberately ────────
    //
    // `NotRecorded` is NOT the same as `AssertedFalse`. DLT Pilot Art 4(2)(c)–(f) require
    // four *negative* facts about a member, and a missing claim is not a clean record — it
    // is an unasked question. Every consumer of this registry must treat the two apart;
    // `MemberEligibility` is the sample that actually depends on it.

    enum ClaimValue {
        NotRecorded,
        AssertedTrue,
        AssertedFalse
    }

    struct Claim {
        ClaimValue value;
        address issuer;
        uint64 issuedAt;
        /// @dev ALWAYS SET, never 0, and never more than `maxClaimValiditySeconds` ahead of the
        ///      write. Until 2026-09-08 this read "0 = no expiry", which made the AMLR Art 20
        ///      refresh cadence — the thing an attestation's expiry IS — opt-in per write by
        ///      whichever issuer wrote it. A claim with `expiresAt == 0` in storage now reads as
        ///      expired (`claimValue` compares `>=` against it), so a pre-fix record fails
        ///      closed rather than living forever.
        uint64 expiresAt;
    }

    // ─────────────────────────── the person record ────────────────────────────

    enum PersonType {
        Unset,
        Natural,
        Legal
    }

    // `Tier` — MiFID II Art 24(1) + Annex II: Unset / Retail / ProfessionalOnRequest (Annex II
    // Section II, elective and revocable) / PerSeProfessional (Annex II Section I) /
    // EligibleCounterparty (Art 30) — is declared ONCE, in `Interfaces.sol`, and imported above.
    // Tier is not cosmetic: it selects the suitability regime, the PRIIPs KID duty, and — via
    // Art 16(10) — whether title-transfer collateral is available at all. It used to be
    // re-declared here "for readability", which made `IdentityRegistry.Tier` and the interface's
    // `Tier` two types with one name. Consumers name `Tier`, not `IdentityRegistry.Tier`.

    /// @notice Everything KYC established about the HUMAN (or legal entity). One record per
    ///         `personId`, however many wallets they hold.
    /// @dev    The test for whether a field belongs here rather than on the wallet binding:
    ///         *would a second address change the answer?* Residence, client tier, person type
    ///         and the MiFIR identifier are answers about the person — a second address does
    ///         not give someone a second country. Those are all here. Whether a particular
    ///         address is live is an answer about the address, and lives in `WalletBinding`.
    struct Person {
        bool exists;
        PersonType personType;
        Tier tier;
        uint64 verifiedAt;
        uint64 expiresAt; // AMLR periodic-review horizon; 0 = no scheduled refresh
        bytes20 lei; // legal persons — 20 chars, exact fit
        bytes32 jurisdiction; // ISO 3166-1 alpha-2, left-packed
        bytes32 nationalClientIdHash; // natural persons — salted hash, never the NCI itself
    }

    /// @notice One address's attachment to a person. Deliberately thin.
    /// @dev    ⚠️ `registered` is per WALLET and not per person, and that asymmetry is the
    ///         point of having two structs. A compromised key must be killable without
    ///         erasing the human behind it — `unbindWallet` detaches one address and leaves
    ///         the person, their claims and their other wallets untouched. Collapsing this
    ///         into the person record would make "revoke this address" and "forget this
    ///         person" the same operation, which is wrong in both directions: it would either
    ///         over-erase a live investor or leave a stolen key attached.
    struct WalletBinding {
        bool registered;
        uint64 boundAt;
        bytes32 personId;
    }

    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;

    /// @dev ⚠️ NOT `immutable` since 2026-09-08, and held behind a governance setter — the
    ///      standing rule for every inter-contract reference in this suite, which these two
    ///      were the last of the baseline set to violate. A constructor-set immutable cannot
    ///      be swapped after a provider failure or a catalogue re-version, and a registry
    ///      whose topic list or issuer list cannot be re-pointed is a registry that gets
    ///      redeployed instead — taking every investor record with it. Never null: the
    ///      constructor and both setters reject `address(0)`.
    IClaimTopicsRegistry public claimTopics;
    ITrustedIssuersRegistry public trustedIssuers;

    /// @notice Longest validity an issuer may put on a claim, in seconds from the write.
    /// @dev    The AMLR Art 20 periodic-refresh cadence, as a ceiling rather than a schedule:
    ///         the issuer picks the expiry, this bounds how far out it may be. Governance-set
    ///         so a risk-based tightening (a higher-risk jurisdiction, a supervisory finding)
    ///         is one call and not a redeployment. Default five years — the outer bound in
    ///         common use; most programmes run shorter and set it so.
    uint64 public maxClaimValiditySeconds = 157_680_000; // 5 × 365 days

    /// @notice Writes and updates investor records off the back of an off-chain KYC/onboarding
    ///         outcome. Separate from `governance` because record maintenance is an
    ///         operational function running daily, and upgrade authority is not.
    mapping(address => bool) public isRegistrar;

    /// @notice The `PersonErasure` coordinator, permitted to call `erasePerson` and nothing else.
    /// @dev    ⚠️ A SEPARATE ROLE FROM `isRegistrar` ON PURPOSE. The registrar is the desk that
    ///         WROTE the record; erasure is the desk that answers to the data subject. Giving
    ///         the coordinator a registrar key would also give it `registerPerson`,
    ///         `updatePerson` and `setClaim`, so a compromised erasure path could forge records
    ///         rather than only destroy them. Governance-set, single address, may be zero (the
    ///         suite runs without a coordinator, one `erasePerson` call per contract, which is
    ///         the pre-2026-09-09 behaviour and is still correct if slower).
    address public erasureCoordinator;

    // ─────────────────────────── state ────────────────────────────────────────

    mapping(bytes32 => Person) private _persons;
    mapping(address => WalletBinding) private _wallets;

    /// @dev ⚠️ CLAIMS ARE PERSON-KEYED, NOT WALLET-KEYED, SINCE 2026-09-09. "Is this human
    ///      under sanctions" and "has this human's identity been verified" are facts about the
    ///      human; an issuer attesting them against one address and not another was recording
    ///      the same fact two or three times, with the same divergence exposure as the
    ///      attributes and the same duplicated-personal-data problem under Art 5(1)(c).
    ///
    ///      ⚠️ BEHAVIOUR CHANGE, AND IT IS THE INTENDED ONE: a wallet bound to an existing
    ///      person inherits that person's claims immediately, so a `SecurityToken.recoverWallet`
    ///      replacement no longer sits blocked awaiting a re-attestation of KYC that never
    ///      lapsed. It does NOT inherit that person's covenants — those stay wallet-keyed in
    ///      `CovenantRegistry` by deliberate design, because a covenant is a statement the
    ///      SENDER made from an address rather than a fact established about a human. So a
    ///      recovered wallet clears identity and is still stopped at the covenant gate until
    ///      it declares for itself. That layering is what makes claim inheritance safe.
    mapping(bytes32 => mapping(uint256 => Claim)) private _claims;

    // ── person → wallets index ────────────────────────────────────────────────
    //
    // ⚠️ ONE HUMAN, SEVERAL WALLETS. `personId` is the person key across the suite
    //    (`SecurityToken.recoverWallet` and `MemberEligibility` both treat it as one), and two
    //    obligations need to read it in the person→wallet direction:
    //      • ERASURE. A person with three wallets must be forgettable in one act, and no
    //        off-chain list is evidence that the act was complete. An Art 17 answer built by
    //        reconciling against a spreadsheet is answered on trust; miss one wallet and the
    //        record survived the erasure it was subject to.
    //      • COUNTING PERSONS. Prospectus Art 1(4)(b) exempts an offer made to fewer than 150
    //        *persons* per Member State. Counting wallets makes one investor with three wallets
    //        into three people and burns the exemption three times as fast.
    //    Both indexes are storage, so `delete` reaches them — the linkage is exactly the fact
    //    that must never reach a log. See the GDPR note above the events.

    mapping(bytes32 => address[]) private _walletsOfPerson;

    /// @dev Position of a wallet within `_walletsOfPerson[person]`, stored as index+1 so that a
    ///      zero reads as "not linked" without a second mapping to say so.
    mapping(address => uint256) private _personSlotOf;

    // ── claim topic index ─────────────────────────────────────────────────────
    //
    // ⚠️ EXISTS ONLY SO CLAIMS CAN BE ERASED. `_claims` is a nested mapping and a nested mapping
    //    cannot be enumerated, so deleting the person record alone would leave every claim
    //    written against it fully readable through `claimValue()` and `rawClaim()` — an erased
    //    investor whose KYC and screening outcomes outlived the erasure. Topics are appended
    //    once and never removed: `clearClaim` empties the claim but leaves the topic listed, so
    //    the erase path still visits a slot that a later `setClaim` refilled.

    mapping(bytes32 => uint256[]) private _claimTopicsOf;
    mapping(bytes32 => mapping(uint256 => bool)) private _claimTopicListed;

    // ─────────────────────────── events ───────────────────────────────────────

    /// @dev ⚠️ GDPR — THESE LOGS CARRY NO INVESTOR ATTRIBUTES, ON PURPOSE. No jurisdiction,
    ///      no tier, no person type, no national client identifier hash. Event data is the
    ///      one part of this contract `erasePerson` cannot reach, so anything written
    ///      here survives every erasure request ever made against it. The rule the whole
    ///      contract is built to: an attribute may live in *storage*, where a `require`
    ///      reads it and `delete` can remove it — never in a *log*, which gates nothing and
    ///      erases never. Consumers wanting the current record call `investor()`,
    ///      `jurisdictionOf()` or `tierOf()`; those reads go empty once the record is
    ///      deleted, which is the entire point of putting them there instead of here.
    ///      `lei` is the one deliberate exception — it identifies a *legal* person, and GDPR
    ///      protects natural persons only (Art 1(1)). It is bytes20(0) for natural persons.
    ///
    ///      ⚠️ AND NO `personId` EITHER, INCLUDING ON THE PERSON-LEVEL EVENTS. It is tempting
    ///      to index `PersonRegistered` by `personId` now that one exists — an indexer would
    ///      certainly find it convenient. `personId` is the linkage between an on-chain record
    ///      and an off-chain identity file, which is precisely the fact Recital 26 makes
    ///      personal data and precisely the fact no erasure can retract from a log. The
    ///      person-level events therefore carry only a `reasonHash` or nothing; an indexer
    ///      resolves the person by reading `personIdOf(wallet)` in the same block, from
    ///      storage, which goes empty on erasure exactly as it should.
    event RegistrarSet(address indexed registrar, bool allowed);
    event ErasureCoordinatorSet(address indexed previous, address indexed current);
    event ClaimTopicsChanged(address indexed previous, address indexed current);
    event TrustedIssuersChanged(address indexed previous, address indexed current);
    event MaxClaimValidityChanged(uint64 previousSeconds, uint64 currentSeconds);
    /// @dev Carries no personId and no attributes. `wallet` is the subject of the act, and the
    ///      person behind it is a storage read away for anyone entitled to make it.
    event PersonRegistered(address indexed firstWallet);
    event PersonUpdated(address indexed anyWallet);
    event IdentifierBound(address indexed anyWallet, bytes20 lei);
    event WalletBound(address indexed wallet);
    event WalletUnbound(address indexed wallet, bytes32 reasonHash);
    /// @dev ⚠️ NO TOPIC, NO VALUE. These used to carry both, which published the claim itself:
    ///      "topic 24 (not under sanctions) = AssertedFalse" against an indexed wallet is the
    ///      screening outcome, permanently, in the store no erasure reaches. `issuer` stays
    ///      indexed — it is a firm, and GDPR protects natural persons only — so an issuer can
    ///      still watch its own writes. What was written is a storage read: `claimValue()`.
    event ClaimSet(address indexed wallet, address indexed issuer);
    event ClaimCleared(address indexed wallet);
    /// @dev One per wallet detached by the erasure, plus `PersonErased` once. The per-wallet
    ///      events are what an Art 30 record cites to evidence the scope of the act; the
    ///      wallet addresses were already in the log from `WalletBound`, so this adds no
    ///      linkage that erasure could otherwise have removed.
    event PersonErased(uint256 walletsErased, uint256 claimsErased, bytes32 reasonHash);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotRegistrar();
    error NotErasureAuthority();
    error ZeroAddress();
    error ZeroDuration();
    /// @dev Raised by `setClaim` when `expiresAt` is 0, already past, or further out than
    ///      `maxClaimValiditySeconds`. Informative-class: it is an issuer's input error at
    ///      write time, on a path no holder's transfer ever reaches.
    error ClaimExpiryOutOfRange(uint64 expiresAt, uint64 latestAllowed);
    /// @dev A record with no `personId` has no person behind it, and would sit outside
    ///      the person index — invisible to `erasePerson` and uncountable for Art 1(4)(b).
    error PersonIdRequired();
    error PersonNotRegistered(bytes32 personId);
    error PersonAlreadyRegistered(bytes32 personId);
    /// @dev ⚠️ THE GUARD THAT REPLACES THE DIVERGENCE BUG. `registerInvestor` is a convenience
    ///      that creates the person if absent and binds the wallet either way. When the person
    ///      already exists and the caller passes attributes that differ from the stored ones,
    ///      the old code silently overwrote one wallet's copy and left the others; this reverts.
    ///      Changing a person's tier or residence is `updatePerson`, which changes it once, for
    ///      all of their wallets, and cannot produce two answers.
    error PersonAttributesMismatch(bytes32 personId);
    error IssuerNotTrustedForTopic(address issuer, uint256 topic);
    error NotRegistered(address wallet);
    error AlreadyRegistered(address wallet);
    error RecordExpired(address wallet, uint64 expiredAt);
    error MissingRequiredClaim(address wallet, uint256 topic);
    error PersonTypeUnset(address wallet);
    error NoMifirIdentifier(address wallet);
    error IdentifierMismatchForPersonType(bytes32 personId);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyRegistrar() {
        if (!isRegistrar[msg.sender]) revert NotRegistrar();
        _;
    }

    /// @dev Either desk may erase: the registrar because per-contract erasure must still work
    ///      with no coordinator deployed, the coordinator because a suite-wide Art 17 answer
    ///      should not require handing it the full registrar key.
    modifier onlyErasureAuthority() {
        if (!isRegistrar[msg.sender] && msg.sender != erasureCoordinator) revert NotErasureAuthority();
        _;
    }

    constructor(address governance_, address claimTopics_, address trustedIssuers_) {
        if (governance_ == address(0) || claimTopics_ == address(0) || trustedIssuers_ == address(0)) {
            revert ZeroAddress();
        }
        governance = governance_;
        claimTopics = IClaimTopicsRegistry(claimTopics_);
        trustedIssuers = ITrustedIssuersRegistry(trustedIssuers_);
        emit ClaimTopicsChanged(address(0), claimTopics_);
        emit TrustedIssuersChanged(address(0), trustedIssuers_);
        emit MaxClaimValidityChanged(0, maxClaimValiditySeconds);
    }

    function setRegistrar(address registrar, bool allowed) external onlyGovernance {
        isRegistrar[registrar] = allowed;
        emit RegistrarSet(registrar, allowed);
    }

    /// @notice Point at the `PersonErasure` coordinator, or unset it with `address(0)`.
    function setErasureCoordinator(address coordinator) external onlyGovernance {
        address previous = erasureCoordinator;
        erasureCoordinator = coordinator;
        emit ErasureCoordinatorSet(previous, coordinator);
    }

    /// @notice Re-point the requirement list. Swap, never unset.
    /// @dev    ⚠️ Re-pointing at a registry with an empty required set is the way to relieve
    ///         every holder of every claim requirement at once. It is a logged governance act,
    ///         and the per-topic path (`ClaimTopicsRegistry.removeBaselineTopic`) is the one to
    ///         use for anything short of an implementation swap.
    function setClaimTopics(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        address previous = address(claimTopics);
        claimTopics = IClaimTopicsRegistry(impl);
        emit ClaimTopicsChanged(previous, impl);
    }

    /// @notice Re-point the issuer trust list. Swap, never unset.
    /// @dev    ⚠️ Every claim in storage is re-checked against the NEW list on its next read —
    ///         `claimValue` calls `isTrustedFor` at read time. A swap therefore silently
    ///         invalidates every claim from an issuer the new list does not carry, which is
    ///         correct (it is what retroactive revocation does) and abrupt. Migrate the issuer
    ///         set first.
    function setTrustedIssuers(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        address previous = address(trustedIssuers);
        trustedIssuers = ITrustedIssuersRegistry(impl);
        emit TrustedIssuersChanged(previous, impl);
    }

    /// @notice Set the ceiling on claim validity. Applies to writes from now on; claims already
    ///         in storage keep the expiry they were written with.
    function setMaxClaimValiditySeconds(uint64 seconds_) external onlyGovernance {
        if (seconds_ == 0) revert ZeroDuration();
        uint64 previous = maxClaimValiditySeconds;
        maxClaimValiditySeconds = seconds_;
        emit MaxClaimValidityChanged(previous, seconds_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // RECORD MAINTENANCE — PERSON LEVEL
    //
    // Everything KYC established goes through these three. There is exactly one
    // place each attribute can be written, which is what makes two wallets
    // disagreeing impossible rather than merely discouraged.
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Create the person record. No wallet is attached — `bindWallet` does that.
    /// @dev    Split from wallet binding because onboarding genuinely has two steps: KYC
    ///         completes against a human, and an address is nominated afterwards (sometimes
    ///         much later, sometimes several times). Forcing them into one call was what made
    ///         the per-wallet attribute copy feel natural in the first place.
    function registerPerson(
        bytes32 personId,
        PersonType personType,
        Tier tier,
        bytes32 jurisdiction,
        uint64 expiresAt
    ) public onlyRegistrar {
        if (personId == bytes32(0)) revert PersonIdRequired();
        if (_persons[personId].exists) revert PersonAlreadyRegistered(personId);

        _persons[personId] = Person({
            exists: true,
            personType: personType,
            tier: tier,
            verifiedAt: uint64(block.timestamp),
            expiresAt: expiresAt,
            lei: bytes20(0),
            jurisdiction: jurisdiction,
            nationalClientIdHash: bytes32(0)
        });
    }

    /// @notice Tier is mutable because Annex II Section II professional status is elective
    ///         and can be withdrawn by the client at any time — a downgrade to Retail must
    ///         be a routine registrar action, not a redeployment.
    /// @dev    ⚠️ REPLACES `updateInvestor(address wallet, …)`, which is gone. The wallet-
    ///         addressed form is what allowed a person's wallets to drift apart: it updated
    ///         one copy and had no way even to enumerate the others. This updates the single
    ///         copy, so every wallet the person holds moves together by construction. Emits
    ///         against a representative wallet purely so an indexer has an address to key on —
    ///         see the GDPR note on the events for why the `personId` is not in the log.
    function updatePerson(
        bytes32 personId,
        Tier tier,
        bytes32 jurisdiction,
        uint64 expiresAt
    ) external onlyRegistrar {
        Person storage p = _persons[personId];
        if (!p.exists) revert PersonNotRegistered(personId);

        p.tier = tier;
        p.jurisdiction = jurisdiction;
        p.expiresAt = expiresAt;
        p.verifiedAt = uint64(block.timestamp);

        emit PersonUpdated(_representativeWallet(personId));
    }

    /// @notice MiFIR identity binding. Exactly one of the two identifiers must be supplied,
    ///         matching the person type — a legal person with only an NCI hash, or a natural
    ///         person with only an LEI, is a record that will fail field validation at the
    ///         ARM and there is no reason to let it sit in the registry looking valid.
    /// @dev    Person-keyed: an LEI identifies the entity and an NCI identifies the human,
    ///         neither of which changes with the address used to trade.
    function bindMifirIdentifier(
        bytes32 personId,
        bytes20 lei,
        bytes32 nationalClientIdHash
    ) external onlyRegistrar {
        Person storage p = _persons[personId];
        if (!p.exists) revert PersonNotRegistered(personId);
        if (p.personType == PersonType.Unset) revert IdentifierMismatchForPersonType(personId);

        bool legalOk = p.personType == PersonType.Legal && lei != bytes20(0) && nationalClientIdHash == bytes32(0);
        bool naturalOk = p.personType == PersonType.Natural && lei == bytes20(0) && nationalClientIdHash != bytes32(0);
        if (!legalOk && !naturalOk) revert IdentifierMismatchForPersonType(personId);

        p.lei = lei;
        p.nationalClientIdHash = nationalClientIdHash;

        emit IdentifierBound(_representativeWallet(personId), lei);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // RECORD MAINTENANCE — WALLET LEVEL
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Attach an address to an existing person.
    /// @dev    The new wallet inherits the person's jurisdiction, tier and claims the instant
    ///         this returns — that is the point of the person key, and it is why lost-key
    ///         recovery no longer needs a KYC re-run. It does not inherit covenants; see the
    ///         note on `_claims`.
    function bindWallet(address wallet, bytes32 personId) public onlyRegistrar {
        if (wallet == address(0)) revert ZeroAddress();
        if (_wallets[wallet].registered) revert AlreadyRegistered(wallet);
        if (!_persons[personId].exists) revert PersonNotRegistered(personId);

        _wallets[wallet] = WalletBinding({registered: true, boundAt: uint64(block.timestamp), personId: personId});
        _linkToPerson(wallet, personId);

        emit WalletBound(wallet);
    }

    /// @notice Detach ONE address. The person, their claims and their other wallets survive.
    /// @dev    ⚠️ THIS IS NOT AN ART 17 ERASURE AND MUST NOT BE USED AS ONE — that is
    ///         `erasePerson`. This is the compromised-key / closed-address operation, and it
    ///         deliberately leaves every personal attribute in place because the person is
    ///         still a client. The old `deregisterInvestor` conflated the two: it was named
    ///         for the erasure case, sized for the key-rotation case, and left the other
    ///         wallets of a person it claimed to have deregistered fully live.
    function unbindWallet(address wallet, bytes32 reasonHash) external onlyRegistrar {
        WalletBinding storage b = _wallets[wallet];
        if (!b.registered) revert NotRegistered(wallet);

        _unlinkFromPerson(wallet, b.personId);
        delete _wallets[wallet];

        emit WalletUnbound(wallet, reasonHash);
    }

    /// @notice Onboarding convenience: create the person if new, bind the wallet either way.
    /// @dev    Kept because the overwhelmingly common case is one person and one wallet
    ///         arriving together, and making that two transactions invites the second to be
    ///         forgotten — leaving a person record with no wallet, invisible to every gate.
    /// @dev    ⚠️ WHEN THE PERSON ALREADY EXISTS, THE ATTRIBUTES MUST MATCH OR THIS REVERTS.
    ///         This is the whole fix in one guard. Binding a second wallet to an existing
    ///         person while passing a different `jurisdiction` or `tier` used to succeed and
    ///         create the two-country investor; it now raises `PersonAttributesMismatch`. A
    ///         caller that genuinely means to change the person's residence calls
    ///         `updatePerson` first, which changes it for every wallet at once.
    function registerInvestor(
        address wallet,
        PersonType personType,
        Tier tier,
        bytes32 jurisdiction,
        bytes32 personId,
        uint64 expiresAt
    ) external onlyRegistrar {
        Person storage p = _persons[personId];

        if (!p.exists) {
            registerPerson(personId, personType, tier, jurisdiction, expiresAt);
            bindWallet(wallet, personId);
            emit PersonRegistered(wallet);
            return;
        }

        if (p.personType != personType || p.tier != tier || p.jurisdiction != jurisdiction) {
            revert PersonAttributesMismatch(personId);
        }
        bindWallet(wallet, personId);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ERASURE — ARTICLE 17
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Erases a person: every attribute, every claim, every wallet binding. One call.
    /// @dev    ⚠️ THIS IS THE FUNCTION THAT MAKES ERASURE ANSWERABLE, AND UNDER THE PERSON KEY
    ///         IT IS FINALLY WHAT ITS NAME SAYS. A data subject asks to be forgotten as a
    ///         person, not as an address; they generally do not know how many wallets an
    ///         operator bound to them, and `SecurityToken.recoverWallet` can add one they never
    ///         chose. The attributes are now stored once, so erasing them is one `delete` and
    ///         cannot half-succeed — the wallet loop that follows removes pointers, not data.
    /// @dev    Both loops are bounded by facts the operator controls: wallets-per-person is a
    ///         handful by construction (onboarding plus recoveries), and topics-per-person by
    ///         the claim-topic catalogue. Neither is settable by an adversary. If a pathological
    ///         record ever did approach the block gas limit, `unbindWallet` still drains the
    ///         wallet list one at a time first, so this cannot become a trap that locks a
    ///         person's own erasure out.
    /// @dev    What this cannot reach, and what the DPIA must therefore say plainly: the logs.
    ///         Every `WalletBound(wallet)` ever emitted stays on every archive node, and a
    ///         wallet address is pseudonymous personal data under Recital 26. The erasure is
    ///         complete as to storage and silent as to history, which is why nothing beyond an
    ///         address was ever written to a log here.
    function erasePerson(bytes32 personId, bytes32 reasonHash) external onlyErasureAuthority {
        Person storage p = _persons[personId];
        if (!p.exists) revert PersonNotRegistered(personId);

        uint256 claimsErased = _eraseClaims(personId);

        address[] storage wallets = _walletsOfPerson[personId];
        uint256 n = wallets.length;

        // Backwards, popping as we go: erasing from the tail keeps every surviving index valid,
        // where a forward loop would renumber the entries it has not reached yet.
        for (uint256 i = n; i > 0; i--) {
            address wallet = wallets[i - 1];
            delete _personSlotOf[wallet];
            delete _wallets[wallet];
            wallets.pop();
            emit WalletUnbound(wallet, reasonHash);
        }

        delete _persons[personId];
        delete _walletsOfPerson[personId];

        emit PersonErased(n, claimsErased, reasonHash);
    }

    // ─────────────────────────── erasure internals ────────────────────────────

    /// @dev Deletes every claim ever written against `personId`, then the topic list itself.
    ///      The `_claimTopicListed` flags go too — a person re-registered later starts with a
    ///      clean list rather than inheriting topics whose claims no longer exist.
    function _eraseClaims(bytes32 personId) private returns (uint256 erased) {
        uint256[] storage topics = _claimTopicsOf[personId];
        erased = topics.length;
        for (uint256 i = 0; i < erased; i++) {
            uint256 topic = topics[i];
            delete _claims[personId][topic];
            delete _claimTopicListed[personId][topic];
        }
        delete _claimTopicsOf[personId];
    }

    function _linkToPerson(address wallet, bytes32 personId) private {
        _walletsOfPerson[personId].push(wallet);
        _personSlotOf[wallet] = _walletsOfPerson[personId].length; // index + 1
    }

    /// @dev Swap-and-pop. Order within a person's wallet list carries no meaning — nothing reads
    ///      it positionally — so moving the tail entry into the gap is free, where shifting the
    ///      remainder would make removal cost grow with the list.
    function _unlinkFromPerson(address wallet, bytes32 personId) private {
        uint256 slot = _personSlotOf[wallet];
        if (slot == 0) return;

        address[] storage wallets = _walletsOfPerson[personId];
        uint256 lastIndex = wallets.length - 1;

        if (slot - 1 != lastIndex) {
            address moved = wallets[lastIndex];
            wallets[slot - 1] = moved;
            _personSlotOf[moved] = slot;
        }

        wallets.pop();
        delete _personSlotOf[wallet];
    }

    /// @dev An address to key a person-level event on, so an indexer has something to join to
    ///      without the log carrying a `personId`. `address(0)` when the person holds no wallet
    ///      yet, which is a legitimate state between `registerPerson` and `bindWallet`.
    function _representativeWallet(bytes32 personId) private view returns (address) {
        address[] storage wallets = _walletsOfPerson[personId];
        return wallets.length == 0 ? address(0) : wallets[0];
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CLAIMS — written only by an issuer currently trusted for that topic, and
    // re-checked against the trust registry on every read, so revocation takes
    // effect without touching a single claim record.
    //
    // Addressed by WALLET on the outside and stored by PERSON on the inside: an
    // issuer knows the address it was asked about, and the fact it is attesting
    // belongs to the human behind it.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param expiresAt Mandatory. Must be in the future and no further out than
    ///                  `maxClaimValiditySeconds` from now. There is no "never expires" — an
    ///                  attestation with no refresh horizon is not an attestation the AMLR
    ///                  Art 20 review cycle recognises, and until 2026-09-08 every issuer could
    ///                  write one by passing 0.
    function setClaim(address wallet, uint256 topic, ClaimValue value, uint64 expiresAt) external {
        bytes32 personId = _requirePersonOf(wallet);
        if (!trustedIssuers.canIssueNow(msg.sender, topic)) revert IssuerNotTrustedForTopic(msg.sender, topic);

        uint64 latestAllowed = uint64(block.timestamp) + maxClaimValiditySeconds;
        if (expiresAt <= block.timestamp || expiresAt > latestAllowed) {
            revert ClaimExpiryOutOfRange(expiresAt, latestAllowed);
        }

        _claims[personId][topic] = Claim({
            value: value,
            issuer: msg.sender,
            issuedAt: uint64(block.timestamp),
            expiresAt: expiresAt
        });

        // Listed once, so the erase path can find this claim later. Guarded because a topic is
        // routinely re-issued on renewal, and an unguarded push would grow the list without
        // bound on a long-lived record.
        if (!_claimTopicListed[personId][topic]) {
            _claimTopicListed[personId][topic] = true;
            _claimTopicsOf[personId].push(topic);
        }

        emit ClaimSet(wallet, msg.sender);
    }

    function clearClaim(address wallet, uint256 topic) external {
        bytes32 personId = _requirePersonOf(wallet);
        Claim storage c = _claims[personId][topic];
        if (msg.sender != c.issuer && !isRegistrar[msg.sender]) revert NotRegistrar();
        delete _claims[personId][topic];
        // `_claimTopicListed` deliberately stays set — the topic remains on the erase path's
        // list, so a later `setClaim` that refills this slot is still reachable by erasure
        // without paying to re-list it.
        emit ClaimCleared(wallet);
    }

    /// @notice The single read every consumer should use. Collapses to `NotRecorded` when
    ///         the claim has expired or its issuer's trust has lapsed — so a stale or
    ///         orphaned claim degrades to "unasked question", never to a silent pass.
    /// @dev    Expiry is `>=`, not `>`: a claim is invalid AT its expiry second, not one second
    ///         after. Fail closed at the boundary — the second in which "still valid" and
    ///         "expired" would both be true is decided against the claim, and a consumer that
    ///         reads `expiresAt` off `rawClaim` and applies the same comparison gets the same
    ///         answer. No zero-guard: `expiresAt == 0` is unwritable since 2026-09-08 and a
    ///         pre-fix record carrying it reads as expired, which is the only safe reading of
    ///         "never expires".
    function claimValue(address wallet, uint256 topic) public view returns (ClaimValue) {
        return claimValueOfPerson(_wallets[wallet].personId, topic);
    }

    function claimValueOfPerson(bytes32 personId, uint256 topic) public view returns (ClaimValue) {
        Claim storage c = _claims[personId][topic];
        if (c.value == ClaimValue.NotRecorded) return ClaimValue.NotRecorded;
        if (block.timestamp >= c.expiresAt) return ClaimValue.NotRecorded;
        if (!trustedIssuers.isTrustedFor(c.issuer, topic, c.issuedAt)) return ClaimValue.NotRecorded;
        return c.value;
    }

    function rawClaim(address wallet, uint256 topic) external view returns (Claim memory) {
        return _claims[_wallets[wallet].personId][topic];
    }

    // ═══════════════════════════════════════════════════════════════════════
    // FREEZE — REMOVED 2026-09-08. Wallet-level stops live in `RestrictedPartyRegistry`.
    //
    // ⚠️ DO NOT REINTRODUCE A FREEZE FLAG HERE. This contract used to carry
    //    `Investor.frozen`, `freeze()`, `unfreeze()` and a `WalletIsFrozen(wallet)`
    //    revert out of `checkEligible`. It was removed, and the reason is not
    //    tidiness — it was a live tipping-off leak.
    //
    //    The suite has stops that must never be disclosed (a sanctions listing, an
    //    AMLR Art 75 suspicion block) and stops that are ordinary (probate, a court
    //    attachment, a lost key). It is tempting to keep the ordinary ones here and
    //    the secret ones in `RestrictedPartyRegistry`. That does not work: contract storage is
    //    PUBLIC. Nobody has to simulate a transfer or read a revert string — they
    //    read the slot and see which of the two contracts holds the person. Two
    //    stores hand an observer the classification directly, and once both exist,
    //    getting the generic `TransferNotPermitted` rather than a named error is
    //    itself the disclosure. Matching the error names does not close it.
    //
    //    So every wallet-level stop — secret or ordinary — goes through
    //    `RestrictedPartyRegistry.blockPerson` / `blockWallet`, which has a second write role
    //    (`isRestrictionRegistrar`) precisely so the ordinary desk has somewhere to write
    //    that is not the sanctions vendor's key. Disclosure to the customer still
    //    happens; it happens off-chain, where it always did.
    //
    //    `unbindWallet` is NOT a freeze either. It is a permanent detachment for a key that
    //    is gone, it is not reversible by re-binding the same address to a different person
    //    without the registrar saying so, and it says nothing about why.
    //
    //    `RecordExpired` and `MissingRequiredClaim` remain here and are NOT the same
    //    thing: they are eligibility facts about a record, they apply to everyone
    //    equally, and telling a holder their KYC has lapsed is a service, not a tip-off.
    // ═══════════════════════════════════════════════════════════════════════

    // ═══════════════════════════════════════════════════════════════════════
    // GATE 1 — ELIGIBILITY. "May this holder hold?"
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Every error here is INFORMATIVE-class — a fact about the record that applies to
    ///      everyone equally and that the holder can cure. Nothing person-specific and nothing
    ///      screening-linked may ever be raised from this function; that class lives behind
    ///      `IRestrictedParty` and its one argument-free error. See the freeze note above.
    /// @dev `Person.expiresAt` keeps its "0 = no scheduled refresh" meaning — it is the
    ///      registrar's review horizon on the record, not an issuer's attestation, and the
    ///      registrar is the operator's own desk. The comparison is `>=` for the same
    ///      boundary reason as `claimValue`: expired AT the second, fail closed.
    function checkEligible(address wallet) public view override {
        WalletBinding storage b = _wallets[wallet];
        if (!b.registered) revert NotRegistered(wallet);

        Person storage p = _persons[b.personId];
        // Unreachable while `bindWallet` requires the person to exist, and checked anyway: a
        // binding that outlived its person would otherwise read every attribute as zero and
        // pass a jurisdiction of `bytes32(0)` to `requiredTopics`, which is the one input most
        // likely to come back with an empty required set — i.e. fail OPEN.
        if (!p.exists) revert NotRegistered(wallet);
        if (p.expiresAt != 0 && block.timestamp >= p.expiresAt) revert RecordExpired(wallet, p.expiresAt);

        uint256[] memory required = claimTopics.requiredTopics(p.jurisdiction);
        for (uint256 i = 0; i < required.length; i++) {
            if (claimValueOfPerson(b.personId, required[i]) != ClaimValue.AssertedTrue) {
                revert MissingRequiredClaim(wallet, required[i]);
            }
        }
    }

    function isEligible(address wallet) external view override returns (bool) {
        try this.checkEligible(wallet) {
            return true;
        } catch {
            return false;
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // GATE 2 — IDENTIFIABILITY. "Can this holder be reported?"
    //
    // Run this pre-trade. Running it at reporting time tells you only that a
    // trade you have already executed cannot be reported, which is a breach
    // you can no longer prevent — MiFIR Art 26 has no "identify later" limb.
    // ═══════════════════════════════════════════════════════════════════════

    function checkIdentifiable(address wallet) public view {
        WalletBinding storage b = _wallets[wallet];
        if (!b.registered) revert NotRegistered(wallet);

        Person storage p = _persons[b.personId];
        if (!p.exists) revert NotRegistered(wallet);
        if (p.personType == PersonType.Unset) revert PersonTypeUnset(wallet);

        if (p.personType == PersonType.Legal) {
            if (p.lei == bytes20(0)) revert NoMifirIdentifier(wallet);
        } else {
            if (p.nationalClientIdHash == bytes32(0)) revert NoMifirIdentifier(wallet);
        }
    }

    /// @notice What a venue actually wants at the door: both gates, in one call.
    function checkEligibleAndIdentifiable(address wallet) external view {
        checkEligible(wallet);
        checkIdentifiable(wallet);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice The person record behind a wallet.
    /// @dev    Named `investor()` still, because that is what every consumer and document calls
    ///         it and the returned facts are unchanged. It resolves the wallet to its person
    ///         and returns the single stored copy rather than a per-wallet duplicate.
    function investor(address wallet) external view returns (Person memory) {
        return _persons[_wallets[wallet].personId];
    }

    function person(bytes32 personId) external view returns (Person memory) {
        return _persons[personId];
    }

    function walletBinding(address wallet) external view returns (WalletBinding memory) {
        return _wallets[wallet];
    }

    /// @notice The off-chain investor record a wallet resolves to.
    /// @dev    ⚠️ Added because `IIdentityGate` has always declared it and this contract never
    ///         implemented it — `SecurityToken.recoverWallet` and `RestrictedPartyRegistry.isBlocked`
    ///         both call it through the interface, so the omission was a live break, not a
    ///         missing convenience.
    /// @dev    Returns the `personId` and a registration flag rather than the whole record. Two
    ///         consumers need to prove that two wallets are the SAME investor and nothing else;
    ///         handing them the struct would couple them to this contract's storage layout and
    ///         put personal-data-adjacent fields in reach of contracts with no business reading
    ///         them.
    function personIdOf(address wallet) external view override returns (bytes32 personId, bool registered) {
        WalletBinding storage b = _wallets[wallet];
        return (b.personId, b.registered);
    }

    /// @notice Every wallet currently bound to one person.
    /// @dev    The read an Art 17 request is answered from, the read `PersonErasure` fans out
    ///         over, and the read an Art 30 record cites to show the answer was complete. Goes
    ///         empty after `erasePerson`, which is the difference between this and a log.
    function walletsOfPerson(bytes32 personId) external view returns (address[] memory) {
        return _walletsOfPerson[personId];
    }

    /// @notice How many live wallets roll up to one person.
    /// @dev    ⚠️ THE COUNT PROSPECTUS ART 1(4)(b) NEEDS IS OF PERSONS, NOT OF THIS. A consumer
    ///         counting toward the 150-per-Member-State exemption counts distinct
    ///         `personId` values it has seen — one person is one unit however many wallets
    ///         they hold. This function is how a consumer notices the difference exists.
    function walletCountOfPerson(bytes32 personId) external view returns (uint256) {
        return _walletsOfPerson[personId].length;
    }

    /// @notice Every claim topic ever written against a person, live or cleared.
    /// @dev    The erase path's worklist, exposed so an operator can evidence what
    ///         `erasePerson` will reach before calling it.
    function claimTopicsOf(bytes32 personId) external view returns (uint256[] memory) {
        return _claimTopicsOf[personId];
    }

    function tierOf(address wallet) external view override returns (Tier) {
        return _persons[_wallets[wallet].personId].tier;
    }

    function jurisdictionOf(address wallet) external view override returns (bytes32) {
        return _persons[_wallets[wallet].personId].jurisdiction;
    }

    function isRetail(address wallet) external view returns (bool) {
        return _persons[_wallets[wallet].personId].tier == Tier.Retail;
    }

    // ─────────────────────────── internals ────────────────────────────────────

    /// @dev Resolves a wallet to its person, reverting if the wallet is not bound. Used by the
    ///      claim writers, which must never create a claim under `bytes32(0)` — that slot would
    ///      be shared by every unbound address on the chain.
    function _requirePersonOf(address wallet) private view returns (bytes32) {
        WalletBinding storage b = _wallets[wallet];
        if (!b.registered) revert NotRegistered(wallet);
        return b.personId;
    }
}
