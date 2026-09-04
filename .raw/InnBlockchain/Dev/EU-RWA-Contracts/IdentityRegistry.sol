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
/// @dev    GDPR: no personal data is stored on-chain. The national client identifier is
///         held as a salted hash and the verified-record detail lives off-chain behind
///         `recordPointer`. An on-chain NCI is a permanent, un-erasable identifier for a
///         natural person, which no retention policy can later satisfy.
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
        bool frozen;
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

    // ─────────────────────────── events ───────────────────────────────────────

    event RegistrarSet(address indexed registrar, bool allowed);
    event InvestorRegistered(address indexed wallet, PersonType personType, Tier tier, bytes32 jurisdiction);
    event InvestorUpdated(address indexed wallet, Tier tier, bytes32 jurisdiction, uint64 expiresAt);
    event IdentifierBound(address indexed wallet, bytes20 lei, bytes32 nationalClientIdHash);
    event ClaimSet(address indexed wallet, uint256 indexed topic, ClaimValue value, address indexed issuer);
    event ClaimCleared(address indexed wallet, uint256 indexed topic);
    event WalletFrozen(address indexed wallet, bytes32 reasonHash);
    event WalletUnfrozen(address indexed wallet);
    event InvestorDeregistered(address indexed wallet, bytes32 reasonHash);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotRegistrar();
    error IssuerNotTrustedForTopic(address issuer, uint256 topic);
    error NotRegistered(address wallet);
    error AlreadyRegistered(address wallet);
    error WalletIsFrozen(address wallet);
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

        _investors[wallet] = Investor({
            registered: true,
            personType: personType,
            tier: tier,
            jurisdiction: jurisdiction,
            lei: bytes20(0),
            nationalClientIdHash: bytes32(0),
            recordPointer: recordPointer,
            verifiedAt: uint64(block.timestamp),
            expiresAt: expiresAt,
            frozen: false
        });

        emit InvestorRegistered(wallet, personType, tier, jurisdiction);
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

        inv.tier = tier;
        inv.jurisdiction = jurisdiction;
        inv.recordPointer = recordPointer;
        inv.expiresAt = expiresAt;
        inv.verifiedAt = uint64(block.timestamp);

        emit InvestorUpdated(wallet, tier, jurisdiction, expiresAt);
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

        emit IdentifierBound(wallet, lei, nationalClientIdHash);
    }

    /// @notice GDPR erasure / AMLR record closure. Wipes the record and leaves the reason
    ///         hash in the log. Note the log entry itself is not erasable — which is exactly
    ///         why nothing personal was written to it in the first place.
    function deregisterInvestor(address wallet, bytes32 reasonHash) external onlyRegistrar {
        if (!_investors[wallet].registered) revert NotRegistered(wallet);
        delete _investors[wallet];
        emit InvestorDeregistered(wallet, reasonHash);
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

        emit ClaimSet(wallet, topic, value, msg.sender);
    }

    function clearClaim(address wallet, uint256 topic) external {
        Claim storage c = _claims[wallet][topic];
        if (msg.sender != c.issuer && !isRegistrar[msg.sender]) revert NotRegistrar();
        delete _claims[wallet][topic];
        emit ClaimCleared(wallet, topic);
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
    // FREEZE — MiFID II / AMLR / MAR operational control. Distinct from
    // deregistration: the record stays, the wallet simply cannot move.
    // ═══════════════════════════════════════════════════════════════════════

    function freeze(address wallet, bytes32 reasonHash) external onlyRegistrar {
        _investors[wallet].frozen = true;
        emit WalletFrozen(wallet, reasonHash);
    }

    function unfreeze(address wallet) external onlyRegistrar {
        _investors[wallet].frozen = false;
        emit WalletUnfrozen(wallet);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // GATE 1 — ELIGIBILITY. "May this holder hold?"
    // ═══════════════════════════════════════════════════════════════════════

    function checkEligible(address wallet) public view {
        Investor storage inv = _investors[wallet];
        if (!inv.registered) revert NotRegistered(wallet);
        if (inv.frozen) revert WalletIsFrozen(wallet);
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
