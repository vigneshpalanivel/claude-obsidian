// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

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
///         data), and the verified-record detail lives off-chain behind `recordPointer`.
///         Destroying the off-chain record and its salt is what makes the surviving on-chain
///         hash meaningless — cryptographic erasure is the Art 17 answer here, not `delete`
///         alone.
/// @dev    Not solved here, and not solvable here: an EDPB Guidelines 02/2025 assessment,
///         the Art 30 record, and the DPIA that Art 35(3)(b) makes mandatory the moment
///         sanctions/PEP screening writes a claim against this registry. The contract is
///         evidence for those documents, never a substitute for them.
contract IdentityRegistry {
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
        uint64 expiresAt; // 0 = no expiry
    }

    // ─────────────────────────── investor record ──────────────────────────────

    enum PersonType {
        Unset,
        Natural,
        Legal
    }

    /// @dev MiFID II Art 24(1) + Annex II. Tier is not cosmetic: it selects the suitability
    ///      regime, the PRIIPs KID duty, and — via Art 16(10) — whether title-transfer
    ///      collateral is available at all.
    enum Tier {
        Unset,
        Retail,
        ProfessionalOnRequest, // Annex II Section II — elective, and revocable
        PerSeProfessional, // Annex II Section I
        EligibleCounterparty // Art 30
    }

    struct Investor {
        bool registered;
        PersonType personType;
        Tier tier;
        bytes32 jurisdiction; // ISO 3166-1 alpha-2, left-packed
        bytes20 lei; // legal persons — 20 chars, exact fit
        bytes32 nationalClientIdHash; // natural persons — salted hash, never the NCI itself
        bytes32 recordPointer; // hash/URI digest of the off-chain verified record
        uint64 verifiedAt;
        uint64 expiresAt; // AMLR periodic-review horizon; 0 = no scheduled refresh
    }

    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;
    IClaimTopicsRegistry public immutable claimTopics;
    ITrustedIssuersRegistry public immutable trustedIssuers;

    /// @notice Writes and updates investor records off the back of an off-chain KYC/onboarding
    ///         outcome. Separate from `governance` because record maintenance is an
    ///         operational function running daily, and upgrade authority is not.
    mapping(address => bool) public isRegistrar;

    // ─────────────────────────── state ────────────────────────────────────────

    mapping(address => Investor) private _investors;
    mapping(address => mapping(uint256 => Claim)) private _claims;

    // ── person index ──────────────────────────────────────────────────────────
    //
    // ⚠️ ONE HUMAN, SEVERAL WALLETS — and until now nothing here could say so. `recordPointer`
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
    /// @dev A record with no off-chain pointer has no person behind it, and would sit outside
    ///      the person index — invisible to `deregisterPerson` and uncountable for Art 1(4)(b).
    error RecordPointerRequired();
    error PersonNotRegistered(bytes32 recordPointer);
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
        governance = governance_;
        claimTopics = IClaimTopicsRegistry(claimTopics_);
        trustedIssuers = ITrustedIssuersRegistry(trustedIssuers_);
    }

    function setRegistrar(address registrar, bool allowed) external onlyGovernance {
        isRegistrar[registrar] = allowed;
        emit RegistrarSet(registrar, allowed);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // RECORD MAINTENANCE
    // ═══════════════════════════════════════════════════════════════════════

    function registerInvestor(
        address wallet,
        PersonType personType,
        Tier tier,
        bytes32 jurisdiction,
        bytes32 recordPointer,
        uint64 expiresAt
    ) external onlyRegistrar {
        if (_investors[wallet].registered) revert AlreadyRegistered(wallet);
        if (recordPointer == bytes32(0)) revert RecordPointerRequired();

        _investors[wallet] = Investor({
            registered: true,
            personType: personType,
            tier: tier,
            jurisdiction: jurisdiction,
            lei: bytes20(0),
            nationalClientIdHash: bytes32(0),
            recordPointer: recordPointer,
            verifiedAt: uint64(block.timestamp),
            expiresAt: expiresAt
        });

        _linkToPerson(wallet, recordPointer);

        emit InvestorRegistered(wallet);
    }

    /// @notice Tier is mutable because Annex II Section II professional status is elective
    ///         and can be withdrawn by the client at any time — a downgrade to Retail must
    ///         be a routine registrar action, not a redeployment.
    function updateInvestor(
        address wallet,
        Tier tier,
        bytes32 jurisdiction,
        bytes32 recordPointer,
        uint64 expiresAt
    ) external onlyRegistrar {
        Investor storage inv = _investors[wallet];
        if (!inv.registered) revert NotRegistered(wallet);
        if (recordPointer == bytes32(0)) revert RecordPointerRequired();

        // Re-pointing a wallet at a different person moves it between the two person lists.
        // Skipped when unchanged, which is the ordinary case — a tier or expiry refresh passes
        // the same pointer back, and re-linking it would leave the wallet listed twice.
        if (recordPointer != inv.recordPointer) {
            _unlinkFromPerson(wallet, inv.recordPointer);
            _linkToPerson(wallet, recordPointer);
        }

        inv.tier = tier;
        inv.jurisdiction = jurisdiction;
        inv.recordPointer = recordPointer;
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
    function deregisterPerson(bytes32 recordPointer, bytes32 reasonHash) external onlyRegistrar {
        address[] storage wallets = _walletsOfPerson[recordPointer];
        uint256 n = wallets.length;
        if (n == 0) revert PersonNotRegistered(recordPointer);

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
        _unlinkFromPerson(wallet, _investors[wallet].recordPointer);
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

    function setClaim(address wallet, uint256 topic, ClaimValue value, uint64 expiresAt) external {
        if (!_investors[wallet].registered) revert NotRegistered(wallet);
        if (!trustedIssuers.canIssueNow(msg.sender, topic)) revert IssuerNotTrustedForTopic(msg.sender, topic);

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
    function claimValue(address wallet, uint256 topic) public view returns (ClaimValue) {
        Claim storage c = _claims[wallet][topic];
        if (c.value == ClaimValue.NotRecorded) return ClaimValue.NotRecorded;
        if (c.expiresAt != 0 && block.timestamp > c.expiresAt) return ClaimValue.NotRecorded;
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
    //    `RestrictedPartyRegistry.blockRecord` / `blockWallet`, which has a second write role
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

    function checkEligible(address wallet) public view {
        Investor storage inv = _investors[wallet];
        if (!inv.registered) revert NotRegistered(wallet);
        if (inv.expiresAt != 0 && block.timestamp > inv.expiresAt) revert RecordExpired(wallet, inv.expiresAt);

        uint256[] memory required = claimTopics.requiredTopics(inv.jurisdiction);
        for (uint256 i = 0; i < required.length; i++) {
            if (claimValue(wallet, required[i]) != ClaimValue.AssertedTrue) {
                revert MissingRequiredClaim(wallet, required[i]);
            }
        }
    }

    function isEligible(address wallet) external view returns (bool) {
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
    /// @dev    Returns the pointer and a registration flag rather than the whole record. Two
    ///         consumers need to prove that two wallets are the SAME investor and nothing else;
    ///         handing them the struct would couple them to this contract's storage layout and
    ///         put personal-data-adjacent fields in reach of contracts with no business reading
    ///         them.
    function recordPointerOf(address wallet) external view returns (bytes32 pointer, bool registered) {
        Investor storage inv = _investors[wallet];
        return (inv.recordPointer, inv.registered);
    }

    /// @notice Every wallet currently registered under one person.
    /// @dev    The read an Art 17 request is answered from, and the read an Art 30 record cites
    ///         to show the answer was complete. Goes empty after `deregisterPerson`, which is
    ///         the difference between this and a log.
    function walletsOfPerson(bytes32 recordPointer) external view returns (address[] memory) {
        return _walletsOfPerson[recordPointer];
    }

    /// @notice How many live wallets roll up to one person.
    /// @dev    ⚠️ THE COUNT PROSPECTUS ART 1(4)(b) NEEDS IS OF PERSONS, NOT OF THIS. A consumer
    ///         counting toward the 150-per-Member-State exemption counts distinct
    ///         `recordPointer` values it has seen — one person is one unit however many wallets
    ///         they hold. This function is how a consumer notices the difference exists.
    function walletCountOfPerson(bytes32 recordPointer) external view returns (uint256) {
        return _walletsOfPerson[recordPointer].length;
    }

    /// @notice Every claim topic ever written against a wallet, live or cleared.
    /// @dev    The erase path's worklist, exposed so an operator can evidence what
    ///         `deregisterInvestor` will reach before calling it.
    function claimTopicsOf(address wallet) external view returns (uint256[] memory) {
        return _claimTopicsOf[wallet];
    }

    function tierOf(address wallet) external view returns (Tier) {
        return _investors[wallet].tier;
    }

    function jurisdictionOf(address wallet) external view returns (bytes32) {
        return _investors[wallet].jurisdiction;
    }

    function isRetail(address wallet) external view returns (bool) {
        return _investors[wallet].tier == Tier.Retail;
    }
}
