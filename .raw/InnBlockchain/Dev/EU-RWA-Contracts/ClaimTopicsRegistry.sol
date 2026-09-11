// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IClaimTopicsRegistry} from "./IERC3643.sol";

/// @title ClaimTopicsRegistry (illustrative sample — not production code)
/// @notice C3 — declares which claim topics must be present on a wallet's identity record
///         before it may hold or move the instrument. Read by `IdentityRegistry`, which
///         does the actual checking; this contract only holds the requirement list.
/// @dev    Two tiers of requirement, because EU rules are not uniform across Member States:
///         a baseline set that applies to every holder, and a per-jurisdiction *additional*
///         set. The two are unioned, never substituted — a jurisdiction can only ever add
///         requirements, not relieve the baseline. Modelling it the other way round would
///         let a jurisdiction configuration silently disable the AMLR/eIDAS baseline.
/// @dev    ⚠️ IMPLEMENTS `IClaimTopicsRegistry` FROM `IERC3643.sol`, WRITTEN FROM THE EIP TEXT.
///         No T-REX source is used, in whole or in part. All three functions and both events
///         are present with the exact signature.
/// @dev    ⚠️ AND THE STANDARD'S SURFACE CANNOT EXPRESS THE SECOND TIER, WHICH IS A DEVIATION
///         THAT UNDERSTATES THE REQUIREMENT RATHER THAN OVERSTATING IT. `IClaimTopicsRegistry`
///         models ONE global list. `getClaimTopics()` therefore returns the BASELINE ONLY. A
///         holder in a jurisdiction with additional topics must satisfy MORE than
///         `getClaimTopics()` reports, and a caller who treats that array as the full admission
///         test will build a UI that tells an investor they are eligible when they are not.
///         `requiredTopics(jurisdiction)` is the real answer and is what `IdentityRegistry`
///         reads. Registered in `ERC-3643-CONFORMANCE.md`.
/// @dev    ⚠️ THE PER-JURISDICTION TIER IS NOT DROPPABLE TO CLOSE THE DEVIATION. Collapsing it
///         into one global list would either under-require every Member State to the loosest
///         one's set, or impose one State's additions on holders everywhere. The second tier
///         exists because EU rules are not uniform; the standard predates that constraint
///         rather than rejecting it. The deviation is declared, not designed away.
contract ClaimTopicsRegistry is IClaimTopicsRegistry {
    // ─────────────────────────── well-known topic ids ─────────────────────────
    //
    // Topic ids are arbitrary uint256 identifiers, not a standard. These constants are the
    // ones the other samples in this folder reference by name so the wiring is readable.
    // A production deployment fixes its own topic catalogue and versions it — changing the
    // meaning of a live topic id silently re-scopes every claim already written against it.

    uint256 public constant TOPIC_KYC_VERIFIED = 1; // AMLR Art 20 — CDD completed
    // ⚠️ TOPIC 2 (AML/sanctions screening) IS RETIRED, NOT AVAILABLE. Retired 2026-09-08: a
    //    per-wallet screening claim beside the restriction store is the two-slot leak rev 48
    //    removed. While `TOPIC_AML_SCREENED` existed, a screening vendor could record a hit as
    //    `AssertedFalse` on topic 2 instead of `RestrictedPartyRegistry.blockPerson` — and
    //    `rawClaim` is public, `checkEligible` reverts naming the topic, so the hit was readable
    //    by anyone and typed on the revert. A hit is `RestrictedPartyRegistry.blockPerson` /
    //    `blockWallet`, never a claim. A "screening clear" claim is equally forbidden: its
    //    absence on one wallet and presence on the rest is the same disclosure.
    uint256 public constant TOPIC_EIDAS_IDENTIFIED = 3; // eIDAS 2.0 — EUDI wallet / QTSP attestation
    uint256 public constant TOPIC_TAX_RESIDENCY = 4; // per-jurisdiction tax treatment
    uint256 public constant TOPIC_SUITABILITY_ART25 = 5; // MiFID II Art 25 suitability outcome
    uint256 public constant TOPIC_APPROPRIATENESS = 6; // MiFID II Art 25(3) appropriateness
    uint256 public constant TOPIC_TARGET_MARKET = 7; // MiFID II Art 16(3)/24(2) target market
    // ⚠️ TOPIC 8 (PRIIPs Art 13 "KID delivered") IS RETIRED, NOT AVAILABLE. It was declared
    //    here and read nowhere, and a boolean topic named "KID delivered" is an invitation
    //    to wire it back up: the flag still says yes after an Art 10 revision, so the sale
    //    looks clean and breaches Art 13. Art 13 lives in `CovenantRegistry`, bound to the
    //    KID's version hash. Retired rather than reused — see the note below.

    // DLT Pilot Art 4(2) member-admission attributes.
    uint256 public constant TOPIC_GOOD_REPUTE = 20; // Art 4(2)(a)
    uint256 public constant TOPIC_COMPETENCE_INCL_DLT = 21; // Art 4(2)(b)

    // ⚠️ TOPICS 22–26 (Art 4(2)(c)–(g)) ARE RETIRED, NOT AVAILABLE. Those conditions moved
    //    to `CovenantRegistry`: (c)–(f) are the member's own negative declarations binding
    //    the SENDER on every transfer, which no attestation-about-the-investor model
    //    expresses, and (g) is consent given against a specific risk disclosure and must
    //    bind that document's version hash. As boolean claim topics, updating the venue's
    //    risk disclosure left every stale consent reading as valid.
    //
    // ⚠️ RETIRED NUMBERS ARE NEVER REASSIGNED. An identity record written against the old
    //    numbering must not be silently reinterpretable as a later topic — a stale claim
    //    that resolves to nothing fails closed, a stale claim that resolves to something
    //    else fails open, and only one of those is survivable. Next free topic is 28.
    //
    //    Retired set, as enforced by `_retired` below: 2, 8, 22, 23, 24, 25, 26.
    //    Until 2026-09-08 this rule was comment-only and `addBaselineTopic(8)` succeeded.

    uint256 public constant TOPIC_DLT_RISK_WARNINGS_ACK = 27; // retail package — incl. regime impermanence

    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;

    // ─────────────────────────── state ────────────────────────────────────────

    /// @notice Topic ids that may never be required again. Seeded once in the constructor and
    ///         never written afterwards — there is deliberately no `retireTopic` and no
    ///         `unretireTopic`. Retiring a live id is a re-scoping of every claim written
    ///         against it and belongs in a redeployment with the catalogue versioned, not in a
    ///         governance call; un-retiring one is the fail-open reinterpretation the rule
    ///         above forbids.
    /// @dev    Enforced on `addBaselineTopic` and `addAdditionalTopic`. `IdentityRegistry.setClaim`
    ///         is NOT gated on it: an issuer writing a claim on a retired topic writes into a
    ///         slot nothing reads, which fails closed on its own, and putting this registry on
    ///         the claim-write path would couple two contracts for a check with no consequence.
    mapping(uint256 => bool) private _retired;

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
    /// @dev ⚠️ `ClaimTopicAdded` / `ClaimTopicRemoved` are INHERITED from `IClaimTopicsRegistry`
    ///      and must not be re-declared. They are emitted for BASELINE changes only. A
    ///      per-jurisdiction addition deliberately does NOT emit them: the standard's event
    ///      carries no jurisdiction field, so emitting it would announce a global requirement
    ///      that does not exist, and every listener would over-require every holder. Silence
    ///      under-reports; a wrong topic id over-reports. Under-reporting is recoverable by
    ///      reading `AdditionalTopicAdded`, which is emitted and indexed on both fields.

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error TopicAlreadyRequired(uint256 topic);
    error TopicNotRequired(uint256 topic);
    error TooManyRequiredTopics(uint256 wouldBe);
    error TopicRetired(uint256 topic);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_) {
        governance = governance_;
        // The retired set. Seeded here and nowhere else — see `_retired`.
        _retired[2] = true; // AML/sanctions screening — a hit is a restriction, never a claim
        _retired[8] = true; // PRIIPs Art 13 "KID delivered" — lives in CovenantRegistry
        _retired[22] = true; // DLT Pilot Art 4(2)(c)–(g) — moved to CovenantRegistry
        _retired[23] = true;
        _retired[24] = true;
        _retired[25] = true;
        _retired[26] = true;
    }

    /// @notice Whether a topic id is in the retired set and may never be required.
    function isRetiredTopic(uint256 topic) external view returns (bool) {
        return _retired[topic];
    }

    // ═══════════════════════════════════════════════════════════════════════
    // BASELINE — applies to every holder regardless of jurisdiction
    // ═══════════════════════════════════════════════════════════════════════

    function addBaselineTopic(uint256 topic) external onlyGovernance {
        _addBaselineTopic(topic);
    }

    /// @dev Removing a baseline topic does not retroactively invalidate anything — but it
    ///      does mean wallets admitted under the old requirement set were never checked
    ///      against a rule you have since dropped, and wallets admitted after are never
    ///      checked against one you had. Neither direction is reconcilable from the ledger
    ///      alone, which is why every change emits an event with a block timestamp: the
    ///      requirement history *is* the audit trail.
    function removeBaselineTopic(uint256 topic) external onlyGovernance {
        _removeBaselineTopic(topic);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PER-JURISDICTION — additive only. There is deliberately no function that
    // relieves a holder of a baseline topic on jurisdictional grounds.
    // ═══════════════════════════════════════════════════════════════════════

    function addAdditionalTopic(bytes32 jurisdiction, uint256 topic) external onlyGovernance {
        if (_retired[topic]) revert TopicRetired(topic);
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
    // ERC-3643 SURFACE — the baseline tier under the standard's names.
    //
    // ⚠️ THE STANDARD'S THREE MEMBERS ADDRESS THE BASELINE AND NOTHING ELSE. There
    // is no conformant way to reach the per-jurisdiction tier, which is why the
    // suite's own functions remain the preferred entry points and why a reviewer
    // reading only this section will see a smaller requirement set than the one
    // `IdentityRegistry` actually enforces.
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Adds a BASELINE topic — required of every holder in every jurisdiction. Same
    ///         function as `addBaselineTopic`, under the standard's name, including the retired-
    ///         id guard: the standard's surface is not a way around the topic catalogue.
    function addClaimTopic(uint256 _claimTopic) external onlyGovernance {
        _addBaselineTopic(_claimTopic);
    }

    /// @notice Removes a BASELINE topic. Cannot reach a per-jurisdiction requirement — a caller
    ///         who removes a topic here and expects a jurisdiction's holders to stop being
    ///         checked for it will find they are still checked. `removeAdditionalTopic` is the
    ///         function for that.
    function removeClaimTopic(uint256 _claimTopic) external onlyGovernance {
        _removeBaselineTopic(_claimTopic);
    }

    /// @notice ⚠️ THE BASELINE ONLY, AND THAT IS NOT THE ADMISSION TEST. A holder in a
    ///         jurisdiction carrying additional topics must satisfy a SUPERSET of this array.
    ///         Treating it as the full requirement produces a UI that clears an investor the
    ///         registry will refuse. Call `requiredTopics(jurisdiction)` for the real answer.
    function getClaimTopics() external view returns (uint256[] memory) {
        return _baselineTopics;
    }

    // ═══════════════════════════════════════════════════════════════════════

    function _addBaselineTopic(uint256 topic) private {
        if (_retired[topic]) revert TopicRetired(topic);
        if (isBaselineTopic[topic]) revert TopicAlreadyRequired(topic);
        if (_baselineTopics.length + 1 > MAX_REQUIRED_TOPICS) {
            revert TooManyRequiredTopics(_baselineTopics.length + 1);
        }
        isBaselineTopic[topic] = true;
        _baselineTopics.push(topic);
        emit BaselineTopicAdded(topic);
        emit ClaimTopicAdded(topic);
    }

    function _removeBaselineTopic(uint256 topic) private {
        if (!isBaselineTopic[topic]) revert TopicNotRequired(topic);
        isBaselineTopic[topic] = false;
        _removeFrom(_baselineTopics, topic);
        emit BaselineTopicRemoved(topic);
        emit ClaimTopicRemoved(topic);
    }

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
