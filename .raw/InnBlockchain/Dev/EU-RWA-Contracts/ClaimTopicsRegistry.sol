// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title ClaimTopicsRegistry (illustrative sample — not production code)
/// @notice C3 — declares which claim topics must be present on a wallet's identity record
///         before it may hold or move the instrument. Read by `IdentityRegistry`, which
///         does the actual checking; this contract only holds the requirement list.
/// @dev    Two tiers of requirement, because EU rules are not uniform across Member States:
///         a baseline set that applies to every holder, and a per-jurisdiction *additional*
///         set. The two are unioned, never substituted — a jurisdiction can only ever add
///         requirements, not relieve the baseline. Modelling it the other way round would
///         let a jurisdiction configuration silently disable the AMLR/eIDAS baseline.
contract ClaimTopicsRegistry {
    // ─────────────────────────── well-known topic ids ─────────────────────────
    //
    // Topic ids are arbitrary uint256 identifiers, not a standard. These constants are the
    // ones the other samples in this folder reference by name so the wiring is readable.
    // A production deployment fixes its own topic catalogue and versions it — changing the
    // meaning of a live topic id silently re-scopes every claim already written against it.

    uint256 public constant TOPIC_KYC_VERIFIED = 1; // AMLR Art 20 — CDD completed
    uint256 public constant TOPIC_AML_SCREENED = 2; // AMLR — sanctions/PEP screening clear
    uint256 public constant TOPIC_EIDAS_IDENTIFIED = 3; // eIDAS 2.0 — EUDI wallet / QTSP attestation
    uint256 public constant TOPIC_TAX_RESIDENCY = 4; // per-jurisdiction tax treatment
    uint256 public constant TOPIC_SUITABILITY_ART25 = 5; // MiFID II Art 25 suitability outcome
    uint256 public constant TOPIC_APPROPRIATENESS = 6; // MiFID II Art 25(3) appropriateness
    uint256 public constant TOPIC_TARGET_MARKET = 7; // MiFID II Art 16(3)/24(2) target market
    uint256 public constant TOPIC_PRIIPS_KID_DELIVERED = 8; // PRIIPs Art 13 — KID version hash bound

    // DLT Pilot Art 4(2) member-admission attributes. Note (c)–(f) are stated as POSITIVE
    // attributes deliberately: `MemberEligibility` requires them to be recorded as
    // explicitly false, which is only expressible if the attribute itself is the topic.
    uint256 public constant TOPIC_GOOD_REPUTE = 20; // Art 4(2)(a)
    uint256 public constant TOPIC_COMPETENCE_INCL_DLT = 21; // Art 4(2)(b)
    uint256 public constant TOPIC_IS_MARKET_MAKER_ON_MTF = 22; // Art 4(2)(c) — must be FALSE
    uint256 public constant TOPIC_USES_HFT_ON_MTF = 23; // Art 4(2)(d) — must be FALSE
    uint256 public constant TOPIC_PROVIDES_DEA_TO_MTF = 24; // Art 4(2)(e) — must be FALSE
    uint256 public constant TOPIC_DEALS_OWN_ACCOUNT_ON_CLIENT_ORDERS = 25; // Art 4(2)(f) — must be FALSE
    uint256 public constant TOPIC_INFORMED_CONSENT_GIVEN = 26; // Art 4(2)(g)
    uint256 public constant TOPIC_DLT_RISK_WARNINGS_ACK = 27; // retail package — incl. regime impermanence

    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;

    // ─────────────────────────── state ────────────────────────────────────────

    uint256[] private _baselineTopics;
    mapping(uint256 => bool) public isBaselineTopic;

    mapping(bytes32 => uint256[]) private _additionalTopics; // ISO-3166 alpha-2, left-packed
    mapping(bytes32 => mapping(uint256 => bool)) public isAdditionalTopic;

    /// @notice Hard ceiling on the unioned requirement count. Every topic in the set is one
    ///         storage read on every transfer; an unbounded list turns the C1 hook into a
    ///         gas-denial surface on the token itself.
    uint256 public constant MAX_REQUIRED_TOPICS = 32;

    // ─────────────────────────── events ───────────────────────────────────────

    event BaselineTopicAdded(uint256 indexed topic);
    event BaselineTopicRemoved(uint256 indexed topic);
    event AdditionalTopicAdded(bytes32 indexed jurisdiction, uint256 indexed topic);
    event AdditionalTopicRemoved(bytes32 indexed jurisdiction, uint256 indexed topic);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error TopicAlreadyRequired(uint256 topic);
    error TopicNotRequired(uint256 topic);
    error TooManyRequiredTopics(uint256 wouldBe);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_) {
        governance = governance_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // BASELINE — applies to every holder regardless of jurisdiction
    // ═══════════════════════════════════════════════════════════════════════

    function addBaselineTopic(uint256 topic) external onlyGovernance {
        if (isBaselineTopic[topic]) revert TopicAlreadyRequired(topic);
        if (_baselineTopics.length + 1 > MAX_REQUIRED_TOPICS) {
            revert TooManyRequiredTopics(_baselineTopics.length + 1);
        }
        isBaselineTopic[topic] = true;
        _baselineTopics.push(topic);
        emit BaselineTopicAdded(topic);
    }

    /// @dev Removing a baseline topic does not retroactively invalidate anything — but it
    ///      does mean wallets admitted under the old requirement set were never checked
    ///      against a rule you have since dropped, and wallets admitted after are never
    ///      checked against one you had. Neither direction is reconcilable from the ledger
    ///      alone, which is why every change emits an event with a block timestamp: the
    ///      requirement history *is* the audit trail.
    function removeBaselineTopic(uint256 topic) external onlyGovernance {
        if (!isBaselineTopic[topic]) revert TopicNotRequired(topic);
        isBaselineTopic[topic] = false;
        _removeFrom(_baselineTopics, topic);
        emit BaselineTopicRemoved(topic);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PER-JURISDICTION — additive only. There is deliberately no function that
    // relieves a holder of a baseline topic on jurisdictional grounds.
    // ═══════════════════════════════════════════════════════════════════════

    function addAdditionalTopic(bytes32 jurisdiction, uint256 topic) external onlyGovernance {
        if (isAdditionalTopic[jurisdiction][topic]) revert TopicAlreadyRequired(topic);
        uint256 wouldBe = _baselineTopics.length + _additionalTopics[jurisdiction].length + 1;
        if (wouldBe > MAX_REQUIRED_TOPICS) revert TooManyRequiredTopics(wouldBe);

        isAdditionalTopic[jurisdiction][topic] = true;
        _additionalTopics[jurisdiction].push(topic);
        emit AdditionalTopicAdded(jurisdiction, topic);
    }

    function removeAdditionalTopic(bytes32 jurisdiction, uint256 topic) external onlyGovernance {
        if (!isAdditionalTopic[jurisdiction][topic]) revert TopicNotRequired(topic);
        isAdditionalTopic[jurisdiction][topic] = false;
        _removeFrom(_additionalTopics[jurisdiction], topic);
        emit AdditionalTopicRemoved(jurisdiction, topic);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS
    // ═══════════════════════════════════════════════════════════════════════

    function baselineTopics() external view returns (uint256[] memory) {
        return _baselineTopics;
    }

    function additionalTopics(bytes32 jurisdiction) external view returns (uint256[] memory) {
        return _additionalTopics[jurisdiction];
    }

    /// @notice The union a holder in `jurisdiction` must satisfy. Built fresh in memory on
    ///         every call rather than cached, so a mid-flight configuration change can never
    ///         leave a stale requirement set gating live transfers.
    function requiredTopics(bytes32 jurisdiction) external view returns (uint256[] memory out) {
        uint256[] storage extra = _additionalTopics[jurisdiction];
        out = new uint256[](_baselineTopics.length + extra.length);

        uint256 i;
        for (; i < _baselineTopics.length; i++) {
            out[i] = _baselineTopics[i];
        }
        for (uint256 j = 0; j < extra.length; j++) {
            out[i + j] = extra[j];
        }
    }

    // ═══════════════════════════════════════════════════════════════════════

    function _removeFrom(uint256[] storage arr, uint256 topic) private {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == topic) {
                arr[i] = arr[arr.length - 1];
                arr.pop();
                return;
            }
        }
    }
}
