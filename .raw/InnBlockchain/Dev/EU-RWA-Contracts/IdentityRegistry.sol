// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {AXIS_MIFID, IIdentityGate, Tier} from "./Interfaces.sol";
import {
    IAgentRole,
    IClaimTopicsRegistry,
    IIdentity,
    IIdentityRegistry,
    IIdentityRegistryStorage,
    ITrustedIssuersRegistry
} from "./IERC3643.sol";

/// @notice ⚠️ RENAMED FROM `IClaimTopicsRegistry` / `ITrustedIssuersRegistry` WHEN THE EIP
///         INTERFACES ARRIVED, because those two names now belong to `IERC3643.sol` and the
///         collision was a compile error rather than a style question. The `…Gate` suffix is the
///         suite's convention for a NARROW internal read surface — see `IComplianceGate` and
///         `IIdentityGate` in `Interfaces.sol`.
/// @dev    ⚠️ THESE ARE NOT SUBSETS OF THE EIP INTERFACES AND MUST NOT BE COLLAPSED INTO THEM.
///         `IClaimTopicsGate.requiredTopics` takes a JURISDICTION, which `IClaimTopicsRegistry`
///         has no concept of; `ITrustedIssuersGate.isTrustedFor` takes the claim's WRITE TIME,
///         which is what makes prospective revocation expressible and which
///         `ITrustedIssuersRegistry.hasClaimTopic` cannot carry. Re-typing this contract onto
///         the EIP interfaces would silently drop the per-jurisdiction tier and the
///         retroactive/prospective distinction — both of which are gates, not conveniences. The
///         concrete registries implement BOTH surfaces; this contract reads the narrow one.
interface IClaimTopicsGate {
    function requiredTopics(bytes32 jurisdiction) external view returns (uint256[] memory);
}

interface ITrustedIssuersGate {
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
/// @dev    ⚠️ IMPLEMENTS `IIdentityRegistry` FROM `IERC3643.sol`, WRITTEN FROM THE EIP TEXT, AND
///         THIS IS THE ONE INTERFACE IN THE SUITE WHOSE CONFORMANCE GRADE IS **DECLARED
///         DEVIATION** RATHER THAN FULL. Every function and event is present with the exact
///         signature — `is IIdentityRegistry` makes the compiler prove that — but three
///         collisions between the standard's model and this design were resolved in the design's
///         favour. They are enumerated in `ERC-3643-CONFORMANCE.md` and repeated at each call
///         site. In summary:
///
///           (1) WALLET-KEYING — **RESOLVED, no deviation.** The standard's INTERFACE is
///               wallet-keyed; this contract's STORAGE is person-keyed. Those are compatible:
///               every EIP read resolves `wallet → personId → attribute`. What the standard
///               cannot express is two wallets of one person DISAGREEING, and here that is
///               unrepresentable rather than merely checked. The distinction that makes this
///               work is storage versus interface, and it is worth holding on to — the rev 53
///               re-key was about where attributes are STORED, never about the shape of a read.
///
///           (2) `identity()` RETURNING A PER-INVESTOR `IIdentity` CONTRACT — **NOT RESOLVED.**
///               Design §16 D19 is open. See `identity()` below for what is returned today
///               (option (c), a non-dereferenceable handle) and why that is provisional.
///
///           (3) MANDATORY ON-CHAIN `uint16` ISO-3166 COUNTRY — **NOT RESOLVED.** Design §16 D21
///               is open. `investorCountry()` is implemented and is a second on-chain copy of a
///               residence fact about a natural person, in a numeric register that did not exist
///               before conformance. See `investorCountry()` and `setCountryCode()`.
///
/// @dev    ⚠️ THE WRITE SURFACE IS WHERE THE STANDARD AND THIS DESIGN ACTUALLY COLLIDE, NOT THE
///         READ SURFACE. `registerIdentity` is wallet-keyed REGISTRATION: it creates a record
///         from a wallet, a country and an identity contract, with no notion of a person. A
///         literal implementation would recreate the exact defect rev 53 removed — one person,
///         two wallets, two countries. So `registerIdentity` here BINDS A WALLET TO AN EXISTING
///         PERSON, resolved through the identity handle, and refuses to invent a person. See its
///         NatSpec. `updateIdentity` reverts outright. Both are registered deviations.
contract IdentityRegistry is IIdentityGate, IIdentityRegistry, IAgentRole {
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
    /// @dev ⚠️ `tier` IS GONE FROM THIS STRUCT AND THAT IS THE POINT, NOT A TIDY-UP. It lived
    ///      here as a single `Tier` field, which made MiFID II the only classification the suite
    ///      could express — ECSPR's sophisticated / non-sophisticated limb had nowhere to go, and
    ///      adding it as a second field would have meant a third for the next regime. The value
    ///      now lives in `_class[personId][AXIS_MIFID]`, one copy, read through both
    ///      `classificationOf` and the typed `tierOf`. Keeping a `tier` field here as well would
    ///      be two stores for one fact, which is the drift this move exists to remove.
    struct Person {
        bool exists;
        PersonType personType;
        uint64 verifiedAt;
        uint64 expiresAt; // AMLR periodic-review horizon; 0 = no scheduled refresh
        bytes20 lei; // legal persons — 20 chars, exact fit
        bytes32 jurisdiction; // ISO 3166-1 alpha-2, left-packed
        bytes32 nationalClientIdHash; // natural persons — salted hash, never the NCI itself
    }

    /// @notice One person's classification on one axis.
    /// @dev    ⚠️ PACKED INTO ONE SLOT ON PURPOSE. `uint8 + bool` is nine bytes, so this is a
    ///         single `SLOAD` on a path the transfer hook runs for every covenant on every
    ///         movement. The obvious alternative — two parallel mappings, the shape
    ///         `productAttribute` uses — doubles that read for no gain. The other alternative,
    ///         reserving `0` as "unset" and dropping the flag, is cheaper still and was rejected:
    ///         it silently forbids every future regime from ever giving zero a meaning, to save
    ///         one byte in a slot that is already padded.
    struct Classification {
        uint8 value;
        bool isSet;
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
    IClaimTopicsGate public claimTopics;
    ITrustedIssuersGate public trustedIssuers;

    // ─────────────────── ISO-3166 NUMERIC REGISTER (ERC-3643 only) ────────────
    //
    // ⚠️ THIS WHOLE BLOCK EXISTS BECAUSE THE STANDARD DEMANDS `uint16`, AND FOR NO OTHER
    // REASON. Design §16 D21 asks whether an on-chain country code survives GDPR Art 5(1)(c)
    // minimisation at all; the standard answers yes by making it mandatory, and D21 stays open.
    // Nothing in §4–§10 reads these mappings. Every gate in this contract reads
    // `Person.jurisdiction`.
    //
    // ⚠️ `Person.jurisdiction` (ISO-3166-1 alpha-2, left-packed) REMAINS THE SINGLE SOURCE OF
    // TRUTH. The numeric code is DERIVED on read, never stored per person. Storing both per
    // person would be two copies of one residence fact that could drift — and a person whose
    // alpha-2 says FR and whose numeric says 276 is a Prospectus Art 3(2) threshold counted
    // against the wrong Member State.
    //
    // ⚠️ THE TABLE IS GOVERNANCE-SET AND DELIBERATELY NOT HARD-CODED. ISO-3166 numeric
    // assignments change — codes are reassigned on state succession, and a hard-coded table is
    // a redeployment when they do. It is also deliberately SPARSE: an operator populates only
    // the Member States it admits, and an unmapped jurisdiction makes `investorCountry` return
    // 0 rather than guess.

    /// @notice ISO-3166-1 alpha-2 (left-packed `bytes32`) → ISO-3166-1 numeric.
    mapping(bytes32 => uint16) public numericOfJurisdiction;

    /// @notice The reverse, needed because `registerIdentity` and `updateCountry` arrive with a
    ///         numeric code and must write the alpha-2 that the gates read.
    /// @dev    ⚠️ MUST STAY THE EXACT INVERSE of `numericOfJurisdiction`. `setCountryCode` writes
    ///         both and clears the stale reverse entry; nothing else writes either.
    mapping(uint16 => bytes32) public jurisdictionOfNumeric;

    // ─────────────────── ERC-3643 IDENTITY HANDLES (D19, PROVISIONAL) ─────────
    //
    // ⚠️ THE HANDLE IS DERIVED FROM `personId` AND IS NOT A DEPLOYED CONTRACT. See `identity()`.
    // The reverse map exists because `registerIdentity` receives a handle and must recover the
    // person — a truncation to 160 bits is not invertible, so the pairing is stored.

    mapping(address => bytes32) private _personIdOfHandle;

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

    /// @notice Every classification the KYC process established about a person, by axis.
    /// @dev    ⚠️ THIS IS PERSONAL DATA AND `erasePerson` HAS TO REACH IT. A mapping cannot be
    ///         cleared by `delete`, so unlike the `Person` struct it does not fall out of the
    ///         erasure for free — `_axisIds` below exists so the sweep can enumerate what to
    ///         delete. A classification store that outlives an Art 17 request is the exact
    ///         failure no test catches, because every functional test passes with the rows still
    ///         there.
    mapping(bytes32 => mapping(bytes32 => Classification)) private _class;

    /// @notice The axes in use, enumerable so erasure can sweep them.
    /// @dev    ⚠️ BOUNDED, AND THE BOUND IS THE ERASURE PATH'S BUDGET, NOT A STYLE CHOICE. Every
    ///         axis registered here is one more `delete` inside `erasePerson`, which already
    ///         loops wallets and claims. An unbounded axis list hands an operator a way to make
    ///         a person's own erasure exceed the block gas limit — the trap the wallet loop was
    ///         written backwards to avoid. Eight is far beyond the regimes in scope (MiFID,
    ///         ECSPR, and room for national overlays).
    uint256 public constant MAX_AXES = 8;

    bytes32[] private _axisIds;
    mapping(bytes32 => bool) public axisRegistered;

    /// @dev ⚠️ CLAIMS ARE PERSON-KEYED, NOT WALLET-KEYED, SINCE 2026-09-09. "Is this human
    ///      under sanctions" and "has this human's identity been verified" are facts about the
    ///      human; an issuer attesting them against one address and not another was recording
    ///      the same fact two or three times, with the same divergence exposure as the
    ///      attributes and the same duplicated-personal-data problem under Art 5(1)(c).
    ///
    ///      ⚠️ BEHAVIOUR CHANGE, AND IT IS THE INTENDED ONE: a wallet bound to an existing
    ///      person inherits that person's claims immediately, so a `SecurityToken.recoveryAddress`
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
    //    (`SecurityToken.recoveryAddress` and `MemberEligibility` both treat it as one), and two
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
    /// @dev Configuration, not personal data — an alpha-2 code and its numeric, about nobody.
    event CountryCodeSet(bytes32 indexed jurisdiction, uint16 indexed country);
    /// @dev ⚠️ `ClaimTopicsRegistrySet`, `IdentityStorageSet`, `TrustedIssuersRegistrySet`,
    ///      `IdentityRegistered`, `IdentityRemoved`, `IdentityUpdated` and `CountryUpdated` are
    ///      INHERITED from `IIdentityRegistry` and must not be re-declared here.
    ///      `IdentityUpdated` and `IdentityStorageSet` are NEVER EMITTED: the first because
    ///      `updateIdentity` reverts, the second because this suite has no separate identity-
    ///      storage contract — the EIP's `IdentityRegistryStorage` split exists to share one
    ///      store across several tokens, and sharing a person register across issuers is the
    ///      linkability limb of D19 rather than an optimisation. Both are declared and dead.
    /// @dev ⚠️ THE EIP EVENTS CARRY A WALLET AND AN IDENTITY HANDLE, AND THE HANDLE IS DERIVED
    ///      FROM `personId`. That is a stable per-person identifier in a log, which is the one
    ///      thing the event design below was written to keep out. It is tolerable ONLY because
    ///      the handle is not the `personId` itself and not invertible to it — but it does make
    ///      the person→wallets join computable from logs alone, where before it required a
    ///      contract call. Residual, not solved. Recorded in `ERC-3643-CONFORMANCE.md`.
    /// @dev Carries no personId and no attributes. `wallet` is the subject of the act, and the
    ///      person behind it is a storage read away for anyone entitled to make it.
    event PersonRegistered(address indexed firstWallet);
    event PersonUpdated(address indexed anyWallet);
    /// @dev The axis is a platform-level configuration fact about nobody, so it is logged in
    ///      full. The per-person events below deliberately are not — see `_writeClass`.
    event AxisRegistered(bytes32 indexed axisId);
    event ClassificationSet(address indexed anyWallet, bytes32 indexed axisId);
    event ClassificationCleared(address indexed anyWallet, bytes32 indexed axisId);
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
    error AxisIdRequired();
    error AxisNotRegistered(bytes32 axisId);
    error TooManyAxes();
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

    // ─────────── ERC-3643 surface. All informative-class: each is a fact about
    // wiring or about a caller's own input, and none discloses anything about a
    // person's eligibility. See the error-class note above `checkEligible`.

    /// @dev `registerIdentity` was handed an identity handle no person is registered under —
    ///      usually `address(0)`, i.e. an attempt to create a person through the EIP's surface.
    error UnknownIdentity(address identityHandle);
    /// @dev A country code with no entry in `jurisdictionOfNumeric`. Fails closed rather than
    ///      writing a jurisdiction of `bytes32(0)`, which `requiredTopics` would most likely
    ///      answer with an empty set — the one failure mode that is fail-OPEN.
    error UnknownCountryCode(uint16 country);
    /// @dev `setCountryCode` was given an alpha-2 or a numeric that is already mapped elsewhere.
    ///      Silently re-pointing either direction breaks the inverse invariant on the pair.
    error CountryCodeAlreadyMapped(bytes32 jurisdiction, uint16 country);
    /// @dev See `updateIdentity`. The handle is derived from `personId` and cannot change for a
    ///      given person, so the EIP's "this investor's identity contract moved" event cannot
    ///      occur here — and re-pointing a WALLET at a different person is a different act
    ///      wearing the same name.
    error IdentityRebindingNotSupported();
    /// @dev See `setIdentityRegistryStorage`. Informative-class — a wiring fact about the
    ///      deployment, not a fact about any person, so it may say what it is.
    error IdentityStorageNotSupported();
    /// @dev Batch arity.
    error BatchLengthMismatch(uint256 lenA, uint256 lenB);

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
        claimTopics = IClaimTopicsGate(claimTopics_);
        trustedIssuers = ITrustedIssuersGate(trustedIssuers_);
        emit ClaimTopicsChanged(address(0), claimTopics_);
        emit TrustedIssuersChanged(address(0), trustedIssuers_);
        emit MaxClaimValidityChanged(0, maxClaimValiditySeconds);
        // ERC-3643 listeners. The suite's own events carry the PREVIOUS address as well, which
        // is what a reviewer reconstructing a swap needs and the EIP's have no field for.
        emit ClaimTopicsRegistrySet(claimTopics_);
        emit TrustedIssuersRegistrySet(trustedIssuers_);

        // ⚠️ REGISTERED HERE, NOT LEFT TO GOVERNANCE, AND THE REASON IS THE ERASURE SWEEP. Every
        // person carries a MiFID classification from `registerPerson` onwards, so if this axis
        // were not in `_axisIds` from block one, `erasePerson` would walk a list that does not
        // contain the one axis every record is guaranteed to hold.
        _registerAxis(AXIS_MIFID);
    }

    /// @notice Grant or revoke the registrar role. The suite's own form — one call, one boolean.
    /// @dev    ⚠️ THE REGISTRAR **IS** THE STANDARD'S AGENT, AND THAT WAS TRUE BEFORE
    ///         `IAgentRole` WAS DECLARED HERE. EIP-3643 requires that any contract acting as an
    ///         Identity Registry be `IAgentRole`-compatible, and says only an agent may add or
    ///         remove identities — which is exactly what `onlyRegistrar` has always gated. The
    ///         role was therefore conformant in SUBSTANCE and unreachable under the standard's
    ///         NAMES, which is the worst of the three possible states: a caller holding the EIP
    ///         ABI got a revert from a contract that was doing the right thing. `addAgent` /
    ///         `removeAgent` / `isAgent` below are that role under the standard's names.
    /// @dev    ⚠️ NOT RENAMED TO `agent`. The suite's vocabulary distinguishes the registrar (who
    ///         binds wallets and writes claims) from `SecurityToken`'s agent (who mints, freezes
    ///         and seizes), and under **DORA Art 5** those are different people with different
    ///         accountability. Collapsing the two names would invite collapsing the two key sets,
    ///         which is a segregation-of-duties failure that no interface asked for.
    /// @dev    Emits BOTH vocabularies on every change — `RegistrarSet` for the suite's tooling,
    ///         `AgentAdded`/`AgentRemoved` for anything built against EIP-3643. Never one
    ///         instead of the other.
    function setRegistrar(address registrar, bool allowed) external onlyGovernance {
        _setRegistrar(registrar, allowed);
    }

    /// @notice `IAgentRole.addAgent` — conformant signature. Grants the registrar role.
    function addAgent(address _agent) external onlyGovernance {
        _setRegistrar(_agent, true);
    }

    /// @notice `IAgentRole.removeAgent` — conformant signature. Revokes the registrar role.
    /// @dev    ⚠️ NO GUARD AGAINST REMOVING THE LAST REGISTRAR, DELIBERATELY — same reasoning as
    ///         `SecurityToken.removeAgent`. A registry with no registrar cannot onboard, which is
    ///         a serious operational state and not one this contract should refuse to enter;
    ///         refusing would turn a compromised last key into an unrevocable one. `governance`
    ///         can always re-grant. ⚠️ Note `erasureCoordinator` is a SEPARATE authority and is
    ///         untouched here, so GDPR Art 17 erasure survives the loss of every registrar.
    function removeAgent(address _agent) external onlyGovernance {
        _setRegistrar(_agent, false);
    }

    /// @notice `IAgentRole.isAgent` — conformant signature. True for a current registrar.
    /// @dev    A function rather than a renamed public mapping, because `isRegistrar` is read by
    ///         name in `DEPLOYMENT-DEFAULTS.md`, in `PersonErasure`'s authority check and by the
    ///         operations runbooks. Two names over one mapping, one of which is the standard's.
    function isAgent(address _agent) external view returns (bool) {
        return isRegistrar[_agent];
    }

    function _setRegistrar(address registrar, bool allowed) internal {
        if (registrar == address(0)) revert ZeroAddress();
        isRegistrar[registrar] = allowed;
        emit RegistrarSet(registrar, allowed);
        if (allowed) {
            emit AgentAdded(registrar);
        } else {
            emit AgentRemoved(registrar);
        }
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
    /// @dev ⚠️ THE EIP NAME IS THE ONLY NAME. Until 2026-09-11 this act was called
    ///      `setClaimTopics` and nothing else, which was a real defect rather than a style one:
    ///      it already emitted `ClaimTopicsRegistrySet`, so the behaviour was conformant and the
    ///      SELECTOR was not — a caller holding the EIP ABI (a venue, a custodian, an audit tool)
    ///      got a revert from a contract that implements the capability correctly. **A house-style
    ///      rename is invisible to a member count and fatal to interoperability**, which is the
    ///      one thing conformance was adopted to buy. The house name survived briefly as an alias
    ///      and was REMOVED 2026-09-15: one act, one selector, no second supported API.
    function setClaimTopicsRegistry(address _claimTopicsRegistry) public onlyGovernance {
        _setClaimTopicsRegistry(_claimTopicsRegistry);
    }

    function _setClaimTopicsRegistry(address impl) internal {
        if (impl == address(0)) revert ZeroAddress();
        address previous = address(claimTopics);
        claimTopics = IClaimTopicsGate(impl);
        emit ClaimTopicsChanged(previous, impl);
        emit ClaimTopicsRegistrySet(impl);
    }

    /// @notice Re-point the issuer trust list. Swap, never unset.
    /// @dev    ⚠️ Every claim in storage is re-checked against the NEW list on its next read —
    ///         `claimValue` calls `isTrustedFor` at read time. A swap therefore silently
    ///         invalidates every claim from an issuer the new list does not carry, which is
    ///         correct (it is what retroactive revocation does) and abrupt. Migrate the issuer
    ///         set first.
    /// @dev ⚠️ EIP NAME ONLY — the `setTrustedIssuers` house alias was removed 2026-09-15. See
    ///      `setClaimTopicsRegistry` for why the pre-2026-09-11 house name was a conformance
    ///      defect rather than a naming preference.
    function setTrustedIssuersRegistry(address _trustedIssuersRegistry) public onlyGovernance {
        _setTrustedIssuersRegistry(_trustedIssuersRegistry);
    }

    function _setTrustedIssuersRegistry(address impl) internal {
        if (impl == address(0)) revert ZeroAddress();
        address previous = address(trustedIssuers);
        trustedIssuers = ITrustedIssuersGate(impl);
        emit TrustedIssuersChanged(previous, impl);
        emit TrustedIssuersRegistrySet(impl);
    }

    /// @notice Set the ceiling on claim validity. Applies to writes from now on; claims already
    ///         in storage keep the expiry they were written with.
    function setMaxClaimValiditySeconds(uint64 seconds_) external onlyGovernance {
        if (seconds_ == 0) revert ZeroDuration();
        uint64 previous = maxClaimValiditySeconds;
        maxClaimValiditySeconds = seconds_;
        emit MaxClaimValidityChanged(previous, seconds_);
    }

    /// @notice Maps one ISO-3166-1 alpha-2 jurisdiction to its numeric code, in both directions.
    ///         Required before any wallet in that jurisdiction can be reached through
    ///         `registerIdentity` or `updateCountry`, and before `investorCountry` answers
    ///         anything but `0` for its holders.
    /// @dev    ⚠️ EXISTS ONLY TO SERVE `IIdentityRegistry`. No gate in this suite reads it.
    ///         Populate it for the Member States the programme admits and no others — an
    ///         exhaustive table is an on-chain dataset with no gating consumer, which is the
    ///         §11 test failing in the most literal way.
    /// @dev    ⚠️ NEITHER SIDE MAY BE SILENTLY RE-POINTED. Both directions are refused if either
    ///         key is already taken, because the two mappings must stay exact inverses: a stale
    ///         reverse entry would let `updateCountry(w, 250)` write a jurisdiction that
    ///         `investorCountry(w)` then reports as something else. Pass `country == 0` to
    ///         RETIRE a mapping — the only supported way to change one, and it leaves every
    ///         person in that jurisdiction reading `investorCountry() == 0` until it is remapped,
    ///         which is visible rather than wrong.
    function setCountryCode(bytes32 jurisdiction, uint16 country) external onlyGovernance {
        if (jurisdiction == bytes32(0)) revert UnknownCountryCode(country);

        uint16 existing = numericOfJurisdiction[jurisdiction];

        if (country == 0) {
            if (existing != 0) {
                delete numericOfJurisdiction[jurisdiction];
                delete jurisdictionOfNumeric[existing];
            }
            emit CountryCodeSet(jurisdiction, 0);
            return;
        }

        if (existing != 0 || jurisdictionOfNumeric[country] != bytes32(0)) {
            revert CountryCodeAlreadyMapped(jurisdiction, country);
        }

        numericOfJurisdiction[jurisdiction] = country;
        jurisdictionOfNumeric[country] = jurisdiction;
        emit CountryCodeSet(jurisdiction, country);
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
            verifiedAt: uint64(block.timestamp),
            expiresAt: expiresAt,
            lei: bytes20(0),
            jurisdiction: jurisdiction,
            nationalClientIdHash: bytes32(0)
        });

        // The signature keeps the typed `Tier` — the caller is a registrar acting on a MiFID
        // classification and should not be handed a bare `uint8` to get wrong. Only the storage
        // underneath it is generic.
        _writeTier(personId, tier);

        // ERC-3643 only. Records the handle ⇄ person pairing so `registerIdentity` can resolve a
        // wallet onto this person. Costs one slot per person and is deleted by `erasePerson`.
        _personIdOfHandle[_handleOf(personId)] = personId;
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

        _writeTier(personId, tier);
        p.jurisdiction = jurisdiction;
        p.expiresAt = expiresAt;
        p.verifiedAt = uint64(block.timestamp);

        emit PersonUpdated(_representativeWallet(personId));
        _emitCountryUpdated(personId, jurisdiction);
    }

    /// @dev ⚠️ ONE EIP EVENT PER WALLET, BECAUSE THE EIP HAS NO PERSON. `CountryUpdated` is
    ///      wallet-keyed, and a listener that saw it for one wallet of a person would believe
    ///      the others still hold the old country — which is exactly the divergence this
    ///      contract makes unrepresentable in storage. Emitting it for all of them is the only
    ///      way the standard's log can tell the truth. The loop is bounded by wallets-per-person,
    ///      which is a handful by construction and is not settable by an adversary.
    /// @dev Emits `country == 0` where the jurisdiction is not in the numeric register. That is
    ///      accurate — `investorCountry` will return 0 too — and is preferable to skipping the
    ///      event, which would leave a listener holding a stale non-zero code.
    function _emitCountryUpdated(bytes32 personId, bytes32 jurisdiction) private {
        uint16 country = numericOfJurisdiction[jurisdiction];
        address[] storage wallets = _walletsOfPerson[personId];
        for (uint256 i = 0; i < wallets.length; i++) {
            emit CountryUpdated(wallets[i], country);
        }
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
        emit IdentityRegistered(wallet, IIdentity(_handleOf(personId)));
    }

    /// @notice Detach ONE address. The person, their claims and their other wallets survive.
    /// @dev    ⚠️ THIS IS NOT AN ART 17 ERASURE AND MUST NOT BE USED AS ONE — that is
    ///         `erasePerson`. This is the compromised-key / closed-address operation, and it
    ///         deliberately leaves every personal attribute in place because the person is
    ///         still a client. The old `deregisterInvestor` conflated the two: it was named
    ///         for the erasure case, sized for the key-rotation case, and left the other
    ///         wallets of a person it claimed to have deregistered fully live.
    function unbindWallet(address wallet, bytes32 reasonHash) external onlyRegistrar {
        _unbindWallet(wallet, reasonHash);
    }

    /// @dev ⚠️ INTERNAL SO `deleteIdentity` CAN REACH IT. An earlier draft had `deleteIdentity`
    ///      call `this.unbindWallet(...)`; that is an EXTERNAL self-call, so `msg.sender` becomes
    ///      this contract, which holds no registrar key — every call would have reverted
    ///      `NotRegistrar`. The authorisation check belongs on the entry points, not here.
    function _unbindWallet(address wallet, bytes32 reasonHash) private {
        WalletBinding storage b = _wallets[wallet];
        if (!b.registered) revert NotRegistered(wallet);

        bytes32 personId = b.personId;
        _unlinkFromPerson(wallet, personId);
        delete _wallets[wallet];

        emit WalletUnbound(wallet, reasonHash);
        emit IdentityRemoved(wallet, IIdentity(_handleOf(personId)));
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

        if (
            p.personType != personType || Tier(_class[personId][AXIS_MIFID].value) != tier
                || p.jurisdiction != jurisdiction
        ) {
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
    ///         operator bound to them, and `SecurityToken.recoveryAddress` can add one they never
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
            // ERC-3643 listeners. The handle is the EIP's identity for this person and the
            // wallet is leaving it; a listener that only reads EIP events must see the removal
            // or it keeps a record this contract no longer holds.
            emit IdentityRemoved(wallet, IIdentity(_handleOf(personId)));
        }

        // ⚠️ MAPPINGS DO NOT FALL OUT OF `delete _persons[personId]`, AND THE CLASSIFICATIONS ARE
        // A MAPPING NOW. While the MiFID tier was a field on the struct it was erased for free;
        // moving it into `_class` moved it OUT of that guarantee, and an axis left here after an
        // Art 17 request is a live regulatory classification of an erased data subject. Bounded
        // by `MAX_AXES`, for the reason given on `_axisIds`.
        uint256 axes = _axisIds.length;
        for (uint256 i = 0; i < axes; i++) {
            delete _class[personId][_axisIds[i]];
        }

        delete _persons[personId];
        delete _walletsOfPerson[personId];
        // ⚠️ THE HANDLE GOES TOO, AND THAT IS PART OF THE ART 17 ANSWER. A surviving
        // handle → personId pairing would keep a stable per-person on-chain identifier alive
        // after the person it identifies was erased — which is the objection to option (a) in
        // the first place, arrived at by accident.
        delete _personIdOfHandle[_handleOf(personId)];

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
    ///         implemented it — `SecurityToken.recoveryAddress` and `RestrictedPartyRegistry.isBlocked`
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

    /// @inheritdoc IIdentityGate
    function classificationOf(address wallet, bytes32 axisId)
        external
        view
        override
        returns (uint8 value, bool isSet)
    {
        Classification storage c = _class[_wallets[wallet].personId][axisId];
        return (c.value, c.isSet);
    }

    /// @notice Every axis in use, in registration order.
    /// @dev    The erasure path's worklist for classifications, exposed for the same reason
    ///         `claimTopicsOf` is: an operator should be able to evidence what `erasePerson`
    ///         will reach before calling it.
    function axisIds() external view returns (bytes32[] memory) {
        return _axisIds;
    }

    /// @dev ⚠️ AN UNREGISTERED WALLET READS AS `Tier.Unset` AND THAT IS LOad-BEARING DOWNSTREAM.
    ///      `_wallets[wallet].personId` is `bytes32(0)` for an unknown address, no classification
    ///      was ever written against it, so `value` is 0 — which `Tier` reserves for `Unset`.
    ///      `SubscriptionEscrow` relies on this: `Tier.Unset` IS counted toward the Art 1(4)(b)
    ///      headcount, because resolving an unknown in the offer's favour is how a headcount
    ///      exemption quietly stops being one. Generic consumers must use `classificationOf` and
    ///      read `isSet` instead of inferring absence from zero — see the interface note.
    function tierOf(address wallet) external view override returns (Tier) {
        return Tier(_class[_wallets[wallet].personId][AXIS_MIFID].value);
    }

    function jurisdictionOf(address wallet) external view override returns (bytes32) {
        return _persons[_wallets[wallet].personId].jurisdiction;
    }

    function isRetail(address wallet) external view returns (bool) {
        return Tier(_class[_wallets[wallet].personId][AXIS_MIFID].value) == Tier.Retail;
    }

    // ─────────────────────────── classification axes ──────────────────────────

    /// @notice Opens a new classification axis — ECSPR sophisticated / non-sophisticated, a
    ///         national overlay, anything a regime classifies investors by.
    /// @dev    ⚠️ GOVERNANCE, NOT THE REGISTRAR, AND THE SPLIT MATTERS. Opening an axis decides
    ///         what the platform is capable of recording about people; writing a value on an
    ///         open axis is the routine KYC action. A registrar that could do both could invent
    ///         a classification dimension and populate it, with no governance transaction
    ///         anywhere in the record — which is a data-minimisation finding under Art 5(1)(c)
    ///         before it is an access-control one.
    function registerAxis(bytes32 axisId) external onlyGovernance {
        _registerAxis(axisId);
    }

    /// @notice Writes a person's classification on an already-open axis.
    /// @dev    The MiFID limb keeps its typed path through `registerPerson` / `updatePerson`.
    ///         This is for every other axis, and it refuses an unregistered one rather than
    ///         opening it implicitly — an axis that appeared because someone wrote to it would
    ///         be outside `_axisIds`, and therefore outside the erasure sweep.
    function setClassification(bytes32 personId, bytes32 axisId, uint8 value) external onlyRegistrar {
        if (!_persons[personId].exists) revert PersonNotRegistered(personId);
        if (!axisRegistered[axisId]) revert AxisNotRegistered(axisId);
        _writeClass(personId, axisId, value);
    }

    /// @notice Clears a person's classification on one axis without erasing the person.
    /// @dev    An elective status can be withdrawn by the client at any time, and withdrawal is
    ///         not erasure — the ECSPR analogue of a Section II downgrade. Sets `isSet` false, so
    ///         the axis reads as UNEVALUABLE rather than as some default value, and every
    ///         predicate keyed on it fails closed until it is written again.
    function clearClassification(bytes32 personId, bytes32 axisId) external onlyRegistrar {
        if (!_persons[personId].exists) revert PersonNotRegistered(personId);
        delete _class[personId][axisId];
        emit ClassificationCleared(_representativeWallet(personId), axisId);
    }

    // ─────────────────────────── internals ────────────────────────────────────

    function _registerAxis(bytes32 axisId) private {
        if (axisId == bytes32(0)) revert AxisIdRequired();
        if (axisRegistered[axisId]) return;
        if (_axisIds.length >= MAX_AXES) revert TooManyAxes();
        axisRegistered[axisId] = true;
        _axisIds.push(axisId);
        emit AxisRegistered(axisId);
    }

    /// @dev ⚠️ THE EVENT CARRIES THE AXIS AND NOT THE VALUE, AND THAT IS THE §10 FIELD RULE, NOT
    ///      an oversight. A log carrying `(wallet, axisId, value)` binds an address to a
    ///      regulatory classification of the human behind it, permanently, in a record no
    ///      erasure request can reach — the same objection that took the jurisdiction out of
    ///      `SubscriptionEscrow`'s subscription log. An indexer that legitimately needs the value
    ///      reads `classificationOf`, which the erasure empties.
    function _writeClass(bytes32 personId, bytes32 axisId, uint8 value) private {
        _class[personId][axisId] = Classification({value: value, isSet: true});
        emit ClassificationSet(_representativeWallet(personId), axisId);
    }

    /// @dev ⚠️ `Tier.Unset` CLEARS THE AXIS, IT DOES NOT STORE ZERO, AND THE DIFFERENCE IS A
    ///      FAIL-OPEN. `Tier` reserves its zero as "no classification", so a registrar passing
    ///      `Tier.Unset` means *unclassified* — but the generic store has only one way to say
    ///      that, and it is `isSet == false`. Writing `{value: 0, isSet: true}` instead would
    ///      publish "this person IS classified, as Unset": the covenant predicate would then find
    ///      the axis evaluable, run the mask against bit 0, and return NOT-APPLICABLE for every
    ///      mask that excludes it. That is the covenant silently switching off for an
    ///      unclassified investor — precisely the "unclassified ≠ exempt" rule the predicate's
    ///      first dimension exists to enforce, and precisely what the old `Tier tier` field got
    ///      right for free by being checked as an enum rather than as a presence flag.
    ///      Every axis with a zero-means-absent encoding has to be mapped onto `isSet` at the
    ///      boundary like this; the generic `setClassification` cannot do it, because it cannot
    ///      know a foreign regime's encoding.
    function _writeTier(bytes32 personId, Tier tier) private {
        if (tier == Tier.Unset) {
            delete _class[personId][AXIS_MIFID];
            emit ClassificationCleared(_representativeWallet(personId), AXIS_MIFID);
            return;
        }
        _writeClass(personId, AXIS_MIFID, uint8(tier));
    }

    /// @dev Resolves a wallet to its person, reverting if the wallet is not bound. Used by the
    ///      claim writers, which must never create a claim under `bytes32(0)` — that slot would
    ///      be shared by every unbound address on the chain.
    function _requirePersonOf(address wallet) private view returns (bytes32) {
        WalletBinding storage b = _wallets[wallet];
        if (!b.registered) revert NotRegistered(wallet);
        return b.personId;
    }

    /// @dev The D19 option-(c) handle: the low 160 bits of `personId`, as an address. NOT a
    ///      deployed contract and never to be called. Deterministic, so nothing needs storing to
    ///      compute it forward; the REVERSE is stored in `_personIdOfHandle` because a
    ///      truncation cannot be inverted.
    /// @dev ⚠️ THE TRUNCATION IS NOT A COLLISION PROBLEM AND IS NOT A PRIVACY FIX. 160 bits is
    ///      ample against accidental collision. What it does NOT do is hide anything:
    ///      `personIdOf(wallet)` is already a public read returning the FULL `personId`, so the
    ///      person→wallets join was computable before this existed. The handle adds no
    ///      disclosure through storage — it adds one through the LOGS, which is the residual
    ///      recorded on the events above.
    function _handleOf(bytes32 personId) private pure returns (address) {
        return address(uint160(uint256(personId)));
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ERC-3643 SURFACE — `IIdentityRegistry`
    //
    // ⚠️ READ THE CONTRACT-LEVEL NATSPEC FIRST. The grade on this interface is
    // DECLARED DEVIATION, not full, and every deviation lives in this block.
    //
    // ⚠️ THE READS ARE FAITHFUL; THE WRITES ARE NOT AND CANNOT BE. `contains`,
    // `isVerified`, `investorCountry`, `issuersRegistry` and `topicsRegistry`
    // answer exactly what the standard means by them, resolved through the
    // person. `registerIdentity` is narrowed, `updateIdentity` reverts, and
    // `identity` returns a handle rather than a contract. None of that is
    // discoverable from the ABI, which is why `ERC-3643-CONFORMANCE.md` is a
    // deliverable and not a comment.
    //
    // ⚠️ NONE OF THESE ARE THE PREFERRED ENTRY POINTS for an operator. The
    // person-level functions above carry `personType`, `tier`, the review
    // horizon and the MiFIR identifier; the EIP's signatures carry none of them,
    // and a record created only through this block is a record that cannot pass
    // `checkIdentifiable`.
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Binds a wallet to the person the identity handle belongs to.
    /// @dev    ⚠️ DECLARED DEVIATION — THIS DOES NOT CREATE A PERSON, AND A LITERAL
    ///         IMPLEMENTATION WOULD RE-OPEN THE DEFECT REV 53 CLOSED. The EIP's
    ///         `registerIdentity` is wallet-keyed registration: wallet + country + identity, no
    ///         person anywhere. Implemented literally it would write a country PER WALLET, and
    ///         one person's two wallets could again read FR/Retail and DE/PerSeProfessional —
    ///         directly monetisable against the Prospectus Art 3(2) per-Member-State threshold
    ///         and the Art 1(4)(b) qualified-investor carve-out. `registerPerson` is how a
    ///         person comes into existence; this attaches an address to one that already does.
    /// @dev    ⚠️ `_country` IS CHECKED, NEVER WRITTEN. It must agree with the person's stored
    ///         jurisdiction or this reverts `PersonAttributesMismatch`. Accepting and discarding
    ///         it would let a caller believe they had set a country that the gates do not read;
    ///         accepting and WRITING it is the two-country defect. Agreement is the only safe
    ///         third option. A caller who genuinely means to change residence calls
    ///         `updatePerson`, which moves every wallet at once.
    /// @dev    ⚠️ AN UNMAPPED COUNTRY CODE REVERTS rather than passing. See `UnknownCountryCode`.
    function registerIdentity(address _userAddress, IIdentity _identity, uint16 _country) public onlyRegistrar {
        bytes32 personId = _personIdOfHandle[address(_identity)];
        if (personId == bytes32(0)) revert UnknownIdentity(address(_identity));

        bytes32 jurisdiction = jurisdictionOfNumeric[_country];
        if (jurisdiction == bytes32(0)) revert UnknownCountryCode(_country);
        if (_persons[personId].jurisdiction != jurisdiction) revert PersonAttributesMismatch(personId);

        bindWallet(_userAddress, personId);
    }

    /// @notice Detaches ONE address. The person, their claims and their other wallets survive.
    /// @dev    ⚠️ THIS IS NOT AN ART 17 ERASURE, WHATEVER ITS NAME SUGGESTS — that is
    ///         `erasePerson`, and it is deliberately NOT reachable from the standard's surface.
    ///         "Delete" here deletes a POINTER. Every personal attribute stays, because the
    ///         person is still a client and this is the compromised-key operation.
    /// @dev    The suite's `unbindWallet` takes a `reasonHash` pointing at the off-chain
    ///         incident record; the EIP's signature has no room for one, so this passes zero.
    ///         An unbind with no reason on the record is an operational gap, not a technical
    ///         one — prefer `unbindWallet`.
    function deleteIdentity(address _userAddress) external onlyRegistrar {
        _unbindWallet(_userAddress, bytes32(0));
    }

    /// @notice Changes the person's country of residence.
    /// @dev    ⚠️ THIS MOVES EVERY WALLET THE PERSON HOLDS, NOT JUST `_userAddress`, AND A
    ///         CALLER WHO EXPECTS OTHERWISE HAS MISREAD THE MODEL. Residence is an answer about
    ///         a person; a second address does not give someone a second country. The EIP's
    ///         signature says otherwise by keying on a wallet, and that mismatch is the reason
    ///         `_emitCountryUpdated` fans the event out across the whole wallet set.
    /// @dev    Only the jurisdiction moves. `tier`, the review horizon and the MiFIR identifier
    ///         are untouched — which is why this is not a substitute for `updatePerson`, and why
    ///         a change of residence that also changes client tier needs `updatePerson`.
    function updateCountry(address _userAddress, uint16 _country) external onlyRegistrar {
        bytes32 personId = _requirePersonOf(_userAddress);

        bytes32 jurisdiction = jurisdictionOfNumeric[_country];
        if (jurisdiction == bytes32(0)) revert UnknownCountryCode(_country);

        Person storage p = _persons[personId];
        p.jurisdiction = jurisdiction;
        p.verifiedAt = uint64(block.timestamp);

        emit PersonUpdated(_representativeWallet(personId));
        _emitCountryUpdated(personId, jurisdiction);
    }

    /// @notice ⚠️ DECLARED DEVIATION — ALWAYS REVERTS. Present because `IIdentityRegistry` names
    ///         it and the compiler must see the selector.
    /// @dev    The EIP means "this investor's identity CONTRACT address changed" — a redeploy of
    ///         their ONCHAINID. Here the handle is derived from `personId` and cannot change for
    ///         a given person, so the event the standard is describing cannot occur.
    /// @dev    ⚠️ THE REASON IT REVERTS RATHER THAN NO-OPS IS THE OTHER READING. Implemented the
    ///         obvious way — re-point `_userAddress` at whatever person `_identity` resolves to —
    ///         this becomes "move a wallet from person A to person B", which changes that
    ///         wallet's jurisdiction, tier, claims and Art 1(4)(b) headcount unit in one call,
    ///         under a name whose EIP meaning is "nothing about the person changed". Two
    ///         divergent meanings behind one selector is a trap, not a convenience. The
    ///         supported route is `unbindWallet` then `bindWallet`, which is two acts because it
    ///         IS two acts.
    function updateIdentity(address, IIdentity) external pure {
        revert IdentityRebindingNotSupported();
    }

    /// @notice Batch form of `registerIdentity`. Atomic — one bad entry reverts the whole call.
    /// @dev    Atomic because a partial batch leaves the operations desk unable to tell which
    ///         wallets were bound without replaying logs, and the failure mode of acting on that
    ///         uncertainty is binding one twice or not at all. Every entry runs the full check
    ///         path; the arity guard is the only thing this adds.
    /// @dev    ⚠️ NO SIZE CAP HERE, unlike `SecurityToken`'s batches. The bound is the block gas
    ///         limit and the caller is the registrar — the operations desk paying its own gas,
    ///         not a holder who can be griefed. If that ever stops being true, cap it.
    function batchRegisterIdentity(
        address[] calldata _userAddresses,
        IIdentity[] calldata _identities,
        uint16[] calldata _countries
    ) external onlyRegistrar {
        if (_userAddresses.length != _identities.length) {
            revert BatchLengthMismatch(_userAddresses.length, _identities.length);
        }
        if (_userAddresses.length != _countries.length) {
            revert BatchLengthMismatch(_userAddresses.length, _countries.length);
        }

        for (uint256 i = 0; i < _userAddresses.length; i++) {
            registerIdentity(_userAddresses[i], _identities[i], _countries[i]);
        }
    }

    /// @notice Whether this address is bound to a person at all.
    /// @dev    ⚠️ NOT AN ELIGIBILITY ANSWER. A bound wallet whose person's record has expired,
    ///         or who is missing a required claim, still answers `true` here. `isVerified` is
    ///         the eligibility question. Using this as a gate admits every lapsed record.
    function contains(address _userAddress) external view returns (bool) {
        return _wallets[_userAddress].registered;
    }

    /// @notice The standard's eligibility read. Identical to `isEligible` — same checks, same
    ///         answer — under the name the EIP uses.
    /// @dev    ⚠️ A SUPERSET OF WHAT THE EIP DESCRIBES, AND DELIBERATELY SO. The standard means
    ///         "holds every required claim from a trusted issuer". This also fails a record past
    ///         its AMLR Art 20 review horizon, and it resolves the required-claim set through
    ///         the holder's JURISDICTION rather than one global list. Both make it stricter, and
    ///         a stricter `isVerified` cannot admit someone the standard would exclude.
    function isVerified(address _userAddress) external view returns (bool) {
        return this.isEligible(_userAddress);
    }

    /// @notice ⚠️ NOT A DEPLOYED CONTRACT. Returns the D19 option-(c) handle — a stable,
    ///         non-dereferenceable per-person identifier derived from `personId`. Calling it
    ///         will revert; comparing two of them tells you whether two wallets are the same
    ///         investor, which is the only thing this suite's own consumers want.
    /// @dev    ⚠️ DESIGN §16 D19 IS OPEN AND THIS IS NOT THE DECISION. Option (a) — a real
    ///         per-person `IIdentity` contract — is full conformance and pays an Art 17 residual
    ///         in full: a deployed contract is a persistent on-chain identifier bound to an
    ///         identified natural person and it cannot be erased. Option (b) — return
    ///         `address(0)` — is cheapest and least honest, and must be DISCLOSED in the
    ///         prospectus if chosen. (c) is what is here. It is reversible: nothing in this
    ///         contract dereferences the result, and switching to (a) changes this function and
    ///         `_personIdOfHandle`'s population, nothing else.
    /// @dev    ⚠️ A VENUE WHOSE TOOLING DEREFERENCES THIS WILL BREAK AGAINST US. That is a
    ///         disclosure item, not a bug to paper over — the failure is loud, which is the
    ///         reason (c) was preferred to (b) as a provisional answer.
    /// @dev    Returns the zero handle for an unbound wallet, which is what the standard's
    ///         readers expect for an unknown address.
    function identity(address _userAddress) external view returns (IIdentity) {
        WalletBinding storage b = _wallets[_userAddress];
        if (!b.registered) return IIdentity(address(0));
        return IIdentity(_handleOf(b.personId));
    }

    /// @notice The holder's ISO-3166-1 NUMERIC country of residence.
    /// @dev    ⚠️ DERIVED, NEVER STORED PER PERSON. `Person.jurisdiction` (alpha-2) is the fact;
    ///         this is a lookup. Storing both would be two copies of one residence attribute
    ///         that could drift, and a person reading FR in one and 276 in the other is a
    ///         Prospectus Art 3(2) threshold counted against the wrong Member State.
    /// @dev    ⚠️ RETURNS `0` FOR AN UNMAPPED JURISDICTION AND FOR AN UNBOUND WALLET, AND THOSE
    ///         ARE NOT DISTINGUISHABLE. `0` is not a valid ISO-3166 numeric, so it cannot be
    ///         mistaken for a country — but a caller that treats it as "no restriction" rather
    ///         than "unknown" fails open. Use `contains` first.
    /// @dev    ⚠️ DESIGN §16 D21 IS OPEN. The standard makes an on-chain country code mandatory;
    ///         D21 asks whether one survives GDPR Art 5(1)(c) minimisation. No gate in this
    ///         suite reads this function — which is the §11 on-chain test being failed on the
    ///         standard's authority rather than on the design's. Recorded, not resolved.
    function investorCountry(address _userAddress) external view returns (uint16) {
        return numericOfJurisdiction[_persons[_wallets[_userAddress].personId].jurisdiction];
    }

    /// @notice The trusted-issuer registry, under the standard's type.
    /// @dev    ⚠️ THE CAST IS SAFE ONLY BECAUSE `TrustedIssuersRegistry` IMPLEMENTS BOTH
    ///         SURFACES. This contract reads the NARROW one (`ITrustedIssuersGate`) because
    ///         `isTrustedFor` takes the claim's write time and `hasClaimTopic` does not — see
    ///         the note on the gate interfaces at the top of this file. Point
    ///         `setTrustedIssuersRegistry` at something that implements only the EIP and every
    ///         claim read reverts.
    /// @notice ⚠️ DECLARED DEVIATION — ALWAYS RETURNS `address(0)`. There is no shared identity
    ///         storage contract in this suite and there is not meant to be one.
    /// @dev    D-I5. The storage contract's whole purpose is to let SEVERAL tokens share ONE
    ///         person register, and cross-issuer sharing of a person register is the
    ///         **linkability limb of design §16 D19** — one address correlating one investor
    ///         across every platform they touch. That is a commercial feature of the ONCHAINID
    ///         model and a GDPR problem, and it is declined on data-protection grounds rather
    ///         than skipped for effort.
    /// @dev    ⚠️ ANSWERED HONESTLY RATHER THAN LEFT ABSENT, which is the same choice `identity()`
    ///         makes. A caller that dereferences this fails loudly at ITS call site; a caller
    ///         that cannot resolve the selector at all fails at ABI resolution with no
    ///         indication of why. The loud failure is the disclosable one.
    function identityStorage() external pure returns (IIdentityRegistryStorage) {
        return IIdentityRegistryStorage(address(0));
    }

    /// @notice ⚠️ DECLARED DEVIATION — ALWAYS REVERTS. Present because `IIdentityRegistry` names
    ///         it and the compiler must see the selector.
    /// @dev    Reverts rather than no-ops for the same reason `updateIdentity` does: a silent
    ///         no-op lets an operator believe they have pointed this registry at a shared store
    ///         and walk away, when every read still comes from local storage. The failure must
    ///         land on the caller, at the moment of the call.
    /// @dev    ⚠️ IF D19 EVER RESOLVES TOWARD A SHARED STORE, THIS IS NOT THE ONLY EDIT. The
    ///         person record, `PersonErasure`'s reach and the DPIA all assume the register is
    ///         local and single-issuer. Implementing this function without re-opening those is
    ///         how the linkability residual arrives undeclared.
    function setIdentityRegistryStorage(address) external pure {
        revert IdentityStorageNotSupported();
    }

    /// @notice The trusted-issuer registry, under the standard's type.
    function issuersRegistry() external view returns (ITrustedIssuersRegistry) {
        return ITrustedIssuersRegistry(address(trustedIssuers));
    }

    /// @notice The claim-topics registry, under the standard's type.
    /// @dev    ⚠️ SAME CAVEAT AS `issuersRegistry`, plus one more: a caller that reads
    ///         `topicsRegistry().getClaimTopics()` gets the BASELINE tier only. The set this
    ///         contract actually enforces is `requiredTopics(jurisdiction)`, which is a superset
    ///         wherever the holder's Member State carries additional topics.
    function topicsRegistry() external view returns (IClaimTopicsRegistry) {
        return IClaimTopicsRegistry(address(claimTopics));
    }
}
