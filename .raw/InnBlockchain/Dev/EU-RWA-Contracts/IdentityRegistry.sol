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
/// @notice C2 — binds a wallet to a verified investor record: MiFID II Art 24(1)/Annex II
///         client tier, jurisdiction, natural-vs-legal person, and the claim set written
///         against it by issuers in `TrustedIssuersRegistry`. Also carries the MiFIR
///         identifier — LEI for legal persons, national client identifier for natural
///         persons — that transaction reporting and transparency require *before execution*.
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
///         reachable by `delete` — `deregisterInvestor` wipes the record, so an Art 17
///         erasure request can actually be honoured.
///         Event data cannot. It gates nothing, `delete` cannot reach it, and every archive
///         node keeps it forever — which is why the events below carry a wallet and nothing
///         else. See the note above them.
///         Off-chain by construction: the national client identifier is held only as a
///         SALTED hash (an unsalted hash of an NCI is brute-forceable and still personal
///         data), and the verified-record detail lives off-chain behind `personId`.
///         Destroying the off-chain record and its salt is what makes the surviving on-chain
///         hash meaningless — cryptographic erasure is the Art 17 answer here, not `delete`
///         alone.
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

    // ─────────────────────────── investor record ──────────────────────────────

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

    struct Investor {
        bool registered;
        PersonType personType;
        Tier tier;
        bytes32 jurisdiction; // ISO 3166-1 alpha-2, left-packed
        bytes20 lei; // legal persons — 20 chars, exact fit
        bytes32 nationalClientIdHash; // natural persons — salted hash, never the NCI itself
        bytes32 personId; // hash/URI digest of the off-chain verified record
        uint64 verifiedAt;
        uint64 expiresAt; // AMLR periodic-review horizon; 0 = no scheduled refresh
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

    // ─────────────────────────── state ────────────────────────────────────────

    mapping(address => Investor) private _investors;
    mapping(address => mapping(uint256 => Claim)) private _claims;

    // ── person index ──────────────────────────────────────────────────────────
    //
    // ⚠️ ONE HUMAN, SEVERAL WALLETS — and until now nothing here could say so. `personId`
    //    was already the person key (`SecurityToken.recoverWallet` and `MemberEligibility` both
    //    treat it as one), but it was only ever readable wallet-first. Nothing could go the
    //    other way, and two obligations broke on that:
    //      • ERASURE. A person with three wallets needed `deregisterInvestor` three times, and
    //        no on-chain read told you what the three were. An Art 17 request answered from an
    //        off-chain list is answered on trust; miss one wallet and the record survives the
    //        erasure that was supposed to remove it.
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
    //    cannot be enumerated, so `delete _investors[wallet]` was wiping the record and leaving
    //    every claim written against it fully readable through `claimValue()` and `rawClaim()` —
    //    a deregistered investor whose KYC and screening claims outlived the deregistration.
    //    Topics are appended once and never removed: `clearClaim` empties the claim but leaves
    //    the topic listed, so the erase path still visits a slot that a later `setClaim` refilled.

    mapping(address => uint256[]) private _claimTopicsOf;
    mapping(address => mapping(uint256 => bool)) private _claimTopicListed;

    // ─────────────────────────── events ───────────────────────────────────────

    /// @dev ⚠️ GDPR — THESE LOGS CARRY NO INVESTOR ATTRIBUTES, ON PURPOSE. No jurisdiction,
    ///      no tier, no person type, no national client identifier hash. Event data is the
    ///      one part of this contract `deregisterInvestor` cannot reach, so anything written
    ///      here survives every erasure request ever made against it. The rule the whole
    ///      contract is built to: an attribute may live in *storage*, where a `require`
    ///      reads it and `delete` can remove it — never in a *log*, which gates nothing and
    ///      erases never. Consumers wanting the current record call `investor()`,
    ///      `jurisdictionOf()` or `tierOf()`; those reads go empty once the record is
    ///      deleted, which is the entire point of putting them there instead of here.
    ///      `lei` is the one deliberate exception — it identifies a *legal* person, and GDPR
    ///      protects natural persons only (Art 1(1)). It is bytes20(0) for natural persons.
    event RegistrarSet(address indexed registrar, bool allowed);
    event ClaimTopicsChanged(address indexed previous, address indexed current);
    event TrustedIssuersChanged(address indexed previous, address indexed current);
    event MaxClaimValidityChanged(uint64 previousSeconds, uint64 currentSeconds);
    event InvestorRegistered(address indexed wallet);
    event InvestorUpdated(address indexed wallet);
    event IdentifierBound(address indexed wallet, bytes20 lei);
    /// @dev ⚠️ NO TOPIC, NO VALUE. These used to carry both, which published the claim itself:
    ///      "topic 24 (not under sanctions) = AssertedFalse" against an indexed wallet is the
    ///      screening outcome, permanently, in the store no erasure reaches. `issuer` stays
    ///      indexed — it is a firm, and GDPR protects natural persons only — so an issuer can
    ///      still watch its own writes. What was written is a storage read: `claimValue()`.
    event ClaimSet(address indexed wallet, address indexed issuer);
    event ClaimCleared(address indexed wallet);
    event InvestorDeregistered(address indexed wallet, bytes32 reasonHash);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotRegistrar();
    error ZeroAddress();
    error ZeroDuration();
    /// @dev Raised by `setClaim` when `expiresAt` is 0, already past, or further out than
    ///      `maxClaimValiditySeconds`. Informative-class: it is an issuer's input error at
    ///      write time, on a path no holder's transfer ever reaches.
    error ClaimExpiryOutOfRange(uint64 expiresAt, uint64 latestAllowed);
    /// @dev A record with no `personId` has no person behind it, and would sit outside
    ///      the person index — invisible to `deregisterPerson` and uncountable for Art 1(4)(b).
    error PersonIdRequired();
    error PersonNotRegistered(bytes32 personId);
    error IssuerNotTrustedForTopic(address issuer, uint256 topic);
    error NotRegistered(address wallet);
    error AlreadyRegistered(address wallet);
    error RecordExpired(address wallet, uint64 expiredAt);
    error MissingRequiredClaim(address wallet, uint256 topic);
    error PersonTypeUnset(address wallet);
    error NoMifirIdentifier(address wallet);
    error IdentifierMismatchForPersonType(address wallet);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyRegistrar() {
        if (!isRegistrar[msg.sender]) revert NotRegistrar();
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
    // RECORD MAINTENANCE
    // ═══════════════════════════════════════════════════════════════════════

    function registerInvestor(
        address wallet,
        PersonType personType,
        Tier tier,
        bytes32 jurisdiction,
        bytes32 personId,
        uint64 expiresAt
    ) external onlyRegistrar {
        if (_investors[wallet].registered) revert AlreadyRegistered(wallet);
        if (personId == bytes32(0)) revert PersonIdRequired();

        _investors[wallet] = Investor({
            registered: true,
            personType: personType,
            tier: tier,
            jurisdiction: jurisdiction,
            lei: bytes20(0),
            nationalClientIdHash: bytes32(0),
            personId: personId,
            verifiedAt: uint64(block.timestamp),
            expiresAt: expiresAt
        });

        _linkToPerson(wallet, personId);

        emit InvestorRegistered(wallet);
    }

    /// @notice Tier is mutable because Annex II Section II professional status is elective
    ///         and can be withdrawn by the client at any time — a downgrade to Retail must
    ///         be a routine registrar action, not a redeployment.
    function updateInvestor(
        address wallet,
        Tier tier,
        bytes32 jurisdiction,
        bytes32 personId,
        uint64 expiresAt
    ) external onlyRegistrar {
        Investor storage inv = _investors[wallet];
        if (!inv.registered) revert NotRegistered(wallet);
        if (personId == bytes32(0)) revert PersonIdRequired();

        // Re-pointing a wallet at a different person moves it between the two person lists.
        // Skipped when unchanged, which is the ordinary case — a tier or expiry refresh passes
        // the same `personId` back, and re-linking it would leave the wallet listed twice.
        if (personId != inv.personId) {
            _unlinkFromPerson(wallet, inv.personId);
            _linkToPerson(wallet, personId);
        }

        inv.tier = tier;
        inv.jurisdiction = jurisdiction;
        inv.personId = personId;
        inv.expiresAt = expiresAt;
        inv.verifiedAt = uint64(block.timestamp);

        emit InvestorUpdated(wallet);
    }

    /// @notice MiFIR identity binding. Exactly one of the two identifiers must be supplied,
    ///         matching the person type — a legal person with only an NCI hash, or a natural
    ///         person with only an LEI, is a record that will fail field validation at the
    ///         ARM and there is no reason to let it sit in the registry looking valid.
    function bindMifirIdentifier(
        address wallet,
        bytes20 lei,
        bytes32 nationalClientIdHash
    ) external onlyRegistrar {
        Investor storage inv = _investors[wallet];
        if (!inv.registered) revert NotRegistered(wallet);
        if (inv.personType == PersonType.Unset) revert PersonTypeUnset(wallet);

        bool legalOk = inv.personType == PersonType.Legal && lei != bytes20(0) && nationalClientIdHash == bytes32(0);
        bool naturalOk = inv.personType == PersonType.Natural &&
            lei == bytes20(0) &&
            nationalClientIdHash != bytes32(0);
        if (!legalOk && !naturalOk) revert IdentifierMismatchForPersonType(wallet);

        inv.lei = lei;
        inv.nationalClientIdHash = nationalClientIdHash;

        emit IdentifierBound(wallet, lei);
    }

    /// @notice GDPR erasure / AMLR record closure for ONE wallet. Wipes the investor record,
    ///         every claim written against it, and the wallet's link to its person, leaving
    ///         only the reason hash in the log.
    /// @dev    ⚠️ Claims are erased here, and previously were not. `delete _investors[wallet]`
    ///         removed the record while leaving `_claims[wallet][*]` fully readable through
    ///         `claimValue()` and `rawClaim()` — so a deregistered investor's KYC and screening
    ///         outcomes outlived the deregistration that was meant to remove them. A nested
    ///         mapping cannot be enumerated, which is why `_claimTopicsOf` exists at all.
    /// @dev    Erasing a person with more than one wallet? Use `deregisterPerson` — this
    ///         function leaves that person's other wallets registered.
    /// @dev    The log entry itself is not erasable, which is exactly why nothing personal is
    ///         written to it — `reasonHash` is a digest, and the wallet is the subject of the
    ///         action rather than an attribute of it.
    function deregisterInvestor(address wallet, bytes32 reasonHash) external onlyRegistrar {
        if (!_investors[wallet].registered) revert NotRegistered(wallet);
        _eraseWallet(wallet);
        emit InvestorDeregistered(wallet, reasonHash);
    }

    /// @notice Erases EVERY wallet registered under one person in a single call — the shape an
    ///         Art 17 request actually arrives in.
    /// @dev    ⚠️ THIS IS THE FUNCTION THAT MAKES ERASURE ANSWERABLE. A data subject asks to be
    ///         forgotten as a person, not as an address; they generally do not know how many
    ///         wallets an operator bound to them, and `SecurityToken.recoverWallet` can add one
    ///         they never chose. Answering per-wallet meant reconciling against an off-chain
    ///         list and hoping it was complete — and a missed wallet is not a partial answer, it
    ///         is a record that survived the erasure it was subject to.
    /// @dev    The loop is bounded by wallets-per-person, which is a handful by construction
    ///         (onboarding plus recoveries), not by anything an adversary sets. If a pathological
    ///         record ever did exceed the block gas limit, `deregisterInvestor` still drains it
    ///         one wallet at a time — so this is a convenience that cannot become a trap.
    function deregisterPerson(bytes32 personId, bytes32 reasonHash) external onlyRegistrar {
        address[] storage wallets = _walletsOfPerson[personId];
        uint256 n = wallets.length;
        if (n == 0) revert PersonNotRegistered(personId);

        // Backwards, popping as we go: erasing from the tail keeps every surviving index valid,
        // where a forward loop would renumber the entries it has not reached yet.
        for (uint256 i = n; i > 0; i--) {
            address wallet = wallets[i - 1];
            _eraseClaims(wallet);
            delete _personSlotOf[wallet];
            delete _investors[wallet];
            wallets.pop();
            emit InvestorDeregistered(wallet, reasonHash);
        }
    }

    // ─────────────────────────── erasure internals ────────────────────────────

    function _eraseWallet(address wallet) private {
        _eraseClaims(wallet);
        _unlinkFromPerson(wallet, _investors[wallet].personId);
        delete _investors[wallet];
    }

    /// @dev Deletes every claim ever written against `wallet`, then the topic list itself. The
    ///      `_claimTopicListed` flags go too — a wallet re-registered later starts with a clean
    ///      list rather than inheriting topics whose claims no longer exist.
    function _eraseClaims(address wallet) private {
        uint256[] storage topics = _claimTopicsOf[wallet];
        for (uint256 i = 0; i < topics.length; i++) {
            uint256 topic = topics[i];
            delete _claims[wallet][topic];
            delete _claimTopicListed[wallet][topic];
        }
        delete _claimTopicsOf[wallet];
    }

    function _linkToPerson(address wallet, bytes32 person) private {
        _walletsOfPerson[person].push(wallet);
        _personSlotOf[wallet] = _walletsOfPerson[person].length; // index + 1
    }

    /// @dev Swap-and-pop. Order within a person's wallet list carries no meaning — nothing reads
    ///      it positionally — so moving the tail entry into the gap is free, where shifting the
    ///      remainder would make removal cost grow with the list.
    function _unlinkFromPerson(address wallet, bytes32 person) private {
        uint256 slot = _personSlotOf[wallet];
        if (slot == 0) return;

        address[] storage wallets = _walletsOfPerson[person];
        uint256 lastIndex = wallets.length - 1;

        if (slot - 1 != lastIndex) {
            address moved = wallets[lastIndex];
            wallets[slot - 1] = moved;
            _personSlotOf[moved] = slot;
        }

        wallets.pop();
        delete _personSlotOf[wallet];
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CLAIMS — written only by an issuer currently trusted for that topic, and
    // re-checked against the trust registry on every read, so revocation takes
    // effect without touching a single claim record.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param expiresAt Mandatory. Must be in the future and no further out than
    ///                  `maxClaimValiditySeconds` from now. There is no "never expires" — an
    ///                  attestation with no refresh horizon is not an attestation the AMLR
    ///                  Art 20 review cycle recognises, and until 2026-09-08 every issuer could
    ///                  write one by passing 0.
    function setClaim(address wallet, uint256 topic, ClaimValue value, uint64 expiresAt) external {
        if (!_investors[wallet].registered) revert NotRegistered(wallet);
        if (!trustedIssuers.canIssueNow(msg.sender, topic)) revert IssuerNotTrustedForTopic(msg.sender, topic);

        uint64 latestAllowed = uint64(block.timestamp) + maxClaimValiditySeconds;
        if (expiresAt <= block.timestamp || expiresAt > latestAllowed) {
            revert ClaimExpiryOutOfRange(expiresAt, latestAllowed);
        }

        _claims[wallet][topic] = Claim({
            value: value,
            issuer: msg.sender,
            issuedAt: uint64(block.timestamp),
            expiresAt: expiresAt
        });

        // Listed once, so the erase path can find this claim later. Guarded because a topic is
        // routinely re-issued on renewal, and an unguarded push would grow the list without
        // bound on a long-lived record.
        if (!_claimTopicListed[wallet][topic]) {
            _claimTopicListed[wallet][topic] = true;
            _claimTopicsOf[wallet].push(topic);
        }

        emit ClaimSet(wallet, msg.sender);
    }

    function clearClaim(address wallet, uint256 topic) external {
        Claim storage c = _claims[wallet][topic];
        if (msg.sender != c.issuer && !isRegistrar[msg.sender]) revert NotRegistrar();
        delete _claims[wallet][topic];
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
        Claim storage c = _claims[wallet][topic];
        if (c.value == ClaimValue.NotRecorded) return ClaimValue.NotRecorded;
        if (block.timestamp >= c.expiresAt) return ClaimValue.NotRecorded;
        if (!trustedIssuers.isTrustedFor(c.issuer, topic, c.issuedAt)) return ClaimValue.NotRecorded;
        return c.value;
    }

    function rawClaim(address wallet, uint256 topic) external view returns (Claim memory) {
        return _claims[wallet][topic];
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
    /// @dev `Investor.expiresAt` keeps its "0 = no scheduled refresh" meaning — it is the
    ///      registrar's review horizon on the record, not an issuer's attestation, and the
    ///      registrar is the operator's own desk. The comparison is `>=` for the same
    ///      boundary reason as `claimValue`: expired AT the second, fail closed.
    function checkEligible(address wallet) public view override {
        Investor storage inv = _investors[wallet];
        if (!inv.registered) revert NotRegistered(wallet);
        if (inv.expiresAt != 0 && block.timestamp >= inv.expiresAt) revert RecordExpired(wallet, inv.expiresAt);

        uint256[] memory required = claimTopics.requiredTopics(inv.jurisdiction);
        for (uint256 i = 0; i < required.length; i++) {
            if (claimValue(wallet, required[i]) != ClaimValue.AssertedTrue) {
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
        Investor storage inv = _investors[wallet];
        if (!inv.registered) revert NotRegistered(wallet);
        if (inv.personType == PersonType.Unset) revert PersonTypeUnset(wallet);

        if (inv.personType == PersonType.Legal) {
            if (inv.lei == bytes20(0)) revert NoMifirIdentifier(wallet);
        } else {
            if (inv.nationalClientIdHash == bytes32(0)) revert NoMifirIdentifier(wallet);
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

    function investor(address wallet) external view returns (Investor memory) {
        return _investors[wallet];
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
        Investor storage inv = _investors[wallet];
        return (inv.personId, inv.registered);
    }

    /// @notice Every wallet currently registered under one person.
    /// @dev    The read an Art 17 request is answered from, and the read an Art 30 record cites
    ///         to show the answer was complete. Goes empty after `deregisterPerson`, which is
    ///         the difference between this and a log.
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

    /// @notice Every claim topic ever written against a wallet, live or cleared.
    /// @dev    The erase path's worklist, exposed so an operator can evidence what
    ///         `deregisterInvestor` will reach before calling it.
    function claimTopicsOf(address wallet) external view returns (uint256[] memory) {
        return _claimTopicsOf[wallet];
    }

    function tierOf(address wallet) external view override returns (Tier) {
        return _investors[wallet].tier;
    }

    function jurisdictionOf(address wallet) external view override returns (bytes32) {
        return _investors[wallet].jurisdiction;
    }

    function isRetail(address wallet) external view returns (bool) {
        return _investors[wallet].tier == Tier.Retail;
    }
}
