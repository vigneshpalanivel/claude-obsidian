// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

interface IIdentityRegistryClaims {
    enum ClaimValue {
        NotRecorded,
        AssertedTrue,
        AssertedFalse
    }

    function claimValue(address wallet, uint256 topic) external view returns (ClaimValue);

    function isRetail(address wallet) external view returns (bool);

    function checkEligibleAndIdentifiable(address wallet) external view;
}

/// @title MemberEligibility (illustrative sample — not production code)
/// @notice DLT Pilot Art 4(2) — the seven cumulative conditions a natural or legal person
///         must satisfy to be admitted directly as a member or participant of a DLT MTF,
///         i.e. to trade without an intermediating investment firm. This is the exemption
///         that makes retail-direct venue access possible at all, and it is the only reason
///         most operators enter the pilot.
/// @dev    ⚠️ FOUR OF THE SEVEN ARE NEGATIVE FACTS — (c) not a market maker on this MTF,
///         (d) not using high-frequency algorithmic trading on it, (e) not providing others
///         with direct electronic access to it, (f) not dealing on own account when
///         executing client orders. **A missing claim is not a clean record.** The topics
///         below are therefore the POSITIVE attribute, and admission requires each to be
///         recorded as explicitly `AssertedFalse`. `NotRecorded` fails. Encoding these as
///         "absence of a bad claim" — the intuitive shape — silently admits every wallet
///         nobody has yet assessed, which is the whole population on day one.
/// @dev    Art 4(2), 2nd subparagraph lets the NCA require additional measures proportionate
///         to the risk profile of admitted natural persons. Those arrive after authorisation,
///         from a supervisor, in a form nobody can predict at build time — hence
///         `addAdditionalCondition`, which appends to the same check rather than requiring a
///         new contract.
/// @dev    This contract also carries the MiFID II Art 17(5) DEA limits, because a public
///         order function on a DLT MTF *is* direct electronic access: a client transmitting
///         orders into the venue under the operator's membership, with none of the
///         conditions Art 17(5) attaches. The controls have to live in the contract, not in
///         a middleware layer a caller can bypass by calling the contract directly.
contract MemberEligibility {
    // ─────────────────────────── condition model ──────────────────────────────

    struct Condition {
        uint256 topic;
        IIdentityRegistryClaims.ClaimValue required;
        bytes32 label; // e.g. "ART_4_2_C_NOT_MARKET_MAKER" — surfaced in the revert
    }

    Condition[] private _conditions;

    // Art 4(2) topics. Must match `ClaimTopicsRegistry`'s catalogue.
    uint256 public constant TOPIC_GOOD_REPUTE = 20; // (a) — AssertedTrue
    uint256 public constant TOPIC_COMPETENCE_INCL_DLT = 21; // (b) — AssertedTrue
    uint256 public constant TOPIC_IS_MARKET_MAKER_ON_MTF = 22; // (c) — AssertedFalse
    uint256 public constant TOPIC_USES_HFT_ON_MTF = 23; // (d) — AssertedFalse
    uint256 public constant TOPIC_PROVIDES_DEA_TO_MTF = 24; // (e) — AssertedFalse
    uint256 public constant TOPIC_DEALS_OWN_ACCOUNT_ON_CLIENT_ORDERS = 25; // (f) — AssertedFalse
    uint256 public constant TOPIC_INFORMED_CONSENT_GIVEN = 26; // (g) — AssertedTrue

    // Retail package. Not part of Art 4(2)'s seven, but the exemption imports it: admitting
    // natural persons directly pulls in a MiFID-grade investor-protection set, and
    // suitability has to resolve BEFORE the hook passes a retail wallet — an onboarding
    // gate, not a marketing annex.
    uint256 public constant TOPIC_SUITABILITY_ART25 = 5;
    uint256 public constant TOPIC_DLT_RISK_WARNINGS_ACK = 27;

    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;
    address public immutable venue; // the matching engine / order gateway
    IIdentityRegistryClaims public immutable identity;

    // ─────────────────────────── DEA limits (MiFID II Art 17(5)) ──────────────

    struct DeaLimits {
        bool configured;
        uint256 maxOrderNotionalWei; // pre-set trading threshold, per order
        uint256 maxDailyNotionalWei; // pre-set credit threshold, per rolling day
        bytes32 deaAgreementHash; // the binding written agreement Art 17(5) requires
    }

    mapping(address => DeaLimits) public deaLimits;
    mapping(address => uint256) public dayNotionalUsedWei;
    mapping(address => uint64) public dayWindowStart;

    // ─────────────────────────── admission register ───────────────────────────
    //
    // Passing `checkAdmission` is necessary but not sufficient: Art 4(2) admission is an
    // operator decision, taken on a file, and the register is what the six-monthly Art 11(4)
    // report counts. A wallet that merely satisfies the conditions is not a member.

    mapping(address => bool) public isAdmittedMember;
    mapping(address => uint64) public admittedAt;
    uint256 public admittedMemberCount;

    // ─────────────────────────── events ───────────────────────────────────────

    event ConditionAdded(uint256 indexed index, uint256 indexed topic, bytes32 label);
    event AdditionalConditionAdded(uint256 indexed index, uint256 indexed topic, bytes32 label, bytes32 ncaRefHash);
    event MemberAdmitted(address indexed wallet, uint64 at);
    event MemberWithdrawn(address indexed wallet, uint64 at, bytes32 reasonHash);
    event DeaLimitsSet(address indexed wallet, uint256 maxOrderNotionalWei, uint256 maxDailyNotionalWei);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotVenue();
    error ConditionNotMet(address wallet, uint256 topic, bytes32 label, IIdentityRegistryClaims.ClaimValue actual);
    error RetailSuitabilityUnresolved(address wallet);
    error RetailRiskWarningsNotAcknowledged(address wallet);
    error NotAMember(address wallet);
    error AlreadyAMember(address wallet);
    error DeaLimitsNotConfigured(address wallet);
    error NoDeaAgreement(address wallet);
    error OrderExceedsPerOrderLimit(address wallet, uint256 notionalWei, uint256 limitWei);
    error OrderExceedsDailyLimit(address wallet, uint256 wouldBeWei, uint256 limitWei);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyVenue() {
        if (msg.sender != venue) revert NotVenue();
        _;
    }

    constructor(address governance_, address venue_, address identity_) {
        governance = governance_;
        venue = venue_;
        identity = IIdentityRegistryClaims(identity_);

        _push(TOPIC_GOOD_REPUTE, IIdentityRegistryClaims.ClaimValue.AssertedTrue, "ART_4_2_A_GOOD_REPUTE");
        _push(TOPIC_COMPETENCE_INCL_DLT, IIdentityRegistryClaims.ClaimValue.AssertedTrue, "ART_4_2_B_COMPETENCE_DLT");
        _push(
            TOPIC_IS_MARKET_MAKER_ON_MTF,
            IIdentityRegistryClaims.ClaimValue.AssertedFalse,
            "ART_4_2_C_NOT_MARKET_MAKER"
        );
        _push(TOPIC_USES_HFT_ON_MTF, IIdentityRegistryClaims.ClaimValue.AssertedFalse, "ART_4_2_D_NO_HFT");
        _push(TOPIC_PROVIDES_DEA_TO_MTF, IIdentityRegistryClaims.ClaimValue.AssertedFalse, "ART_4_2_E_NO_DEA_ONWARD");
        _push(
            TOPIC_DEALS_OWN_ACCOUNT_ON_CLIENT_ORDERS,
            IIdentityRegistryClaims.ClaimValue.AssertedFalse,
            "ART_4_2_F_NO_OWN_ACCOUNT"
        );
        _push(
            TOPIC_INFORMED_CONSENT_GIVEN,
            IIdentityRegistryClaims.ClaimValue.AssertedTrue,
            "ART_4_2_G_INFORMED_CONSENT"
        );
    }

    function _push(uint256 topic, IIdentityRegistryClaims.ClaimValue required, bytes32 label) private {
        _conditions.push(Condition({topic: topic, required: required, label: label}));
        emit ConditionAdded(_conditions.length - 1, topic, label);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 4(2) 2ND SUBPARA — NCA-imposed additional measures
    // ═══════════════════════════════════════════════════════════════════════

    /// @param ncaRefHash Hash of the supervisory correspondence imposing the measure. The
    ///                   condition set is not self-justifying: an auditor reading this
    ///                   contract in three years needs to know which of these seven-plus-N
    ///                   conditions came from the regulation and which came from a letter.
    function addAdditionalCondition(
        uint256 topic,
        IIdentityRegistryClaims.ClaimValue required,
        bytes32 label,
        bytes32 ncaRefHash
    ) external onlyGovernance {
        _conditions.push(Condition({topic: topic, required: required, label: label}));
        emit AdditionalConditionAdded(_conditions.length - 1, topic, label, ncaRefHash);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // THE CHECK — cumulative. Every condition, every time. Reverts naming the
    // failing limb and the value actually found, so the difference between
    // "assessed and failed" and "never assessed" survives into the error.
    // ═══════════════════════════════════════════════════════════════════════

    function checkAdmission(address wallet) public view {
        identity.checkEligibleAndIdentifiable(wallet);

        uint256 len = _conditions.length;
        for (uint256 i = 0; i < len; i++) {
            Condition storage c = _conditions[i];
            IIdentityRegistryClaims.ClaimValue actual = identity.claimValue(wallet, c.topic);
            if (actual != c.required) {
                revert ConditionNotMet(wallet, c.topic, c.label, actual);
            }
        }

        if (identity.isRetail(wallet)) {
            if (identity.claimValue(wallet, TOPIC_SUITABILITY_ART25) != IIdentityRegistryClaims.ClaimValue.AssertedTrue) {
                revert RetailSuitabilityUnresolved(wallet);
            }
            if (
                identity.claimValue(wallet, TOPIC_DLT_RISK_WARNINGS_ACK) !=
                IIdentityRegistryClaims.ClaimValue.AssertedTrue
            ) {
                revert RetailRiskWarningsNotAcknowledged(wallet);
            }
        }
    }

    function canBeAdmitted(address wallet) external view returns (bool) {
        try this.checkAdmission(wallet) {
            return true;
        } catch {
            return false;
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ADMISSION REGISTER
    // ═══════════════════════════════════════════════════════════════════════

    function admitMember(address wallet) external onlyGovernance {
        if (isAdmittedMember[wallet]) revert AlreadyAMember(wallet);
        checkAdmission(wallet);

        isAdmittedMember[wallet] = true;
        admittedAt[wallet] = uint64(block.timestamp);
        admittedMemberCount++;

        emit MemberAdmitted(wallet, uint64(block.timestamp));
    }

    function withdrawMember(address wallet, bytes32 reasonHash) external onlyGovernance {
        if (!isAdmittedMember[wallet]) revert NotAMember(wallet);
        isAdmittedMember[wallet] = false;
        admittedMemberCount--;
        emit MemberWithdrawn(wallet, uint64(block.timestamp), reasonHash);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // MiFID II ART 17(5) — DEA CONTROLS
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Pre-set trading and credit thresholds, plus the hash of the binding written
    ///         agreement. All three limbs are required together: limits without an agreement
    ///         is DEA on undocumented terms, and an agreement without limits is DEA with no
    ///         controls. Art 17(5) asks for both.
    function setDeaLimits(
        address wallet,
        uint256 maxOrderNotionalWei,
        uint256 maxDailyNotionalWei,
        bytes32 deaAgreementHash
    ) external onlyGovernance {
        deaLimits[wallet] = DeaLimits({
            configured: true,
            maxOrderNotionalWei: maxOrderNotionalWei,
            maxDailyNotionalWei: maxDailyNotionalWei,
            deaAgreementHash: deaAgreementHash
        });
        emit DeaLimitsSet(wallet, maxOrderNotionalWei, maxDailyNotionalWei);
    }

    /// @notice Called by the venue before accepting an order. Consumes daily headroom, so it
    ///         is state-changing by design — a `view` version would have to be paired with a
    ///         separate consume call, and any gap between the two is the race a participant
    ///         uses to exceed its own credit limit.
    function checkAndConsumeOrder(address wallet, uint256 notionalWei) external onlyVenue {
        if (!isAdmittedMember[wallet]) revert NotAMember(wallet);

        DeaLimits storage lim = deaLimits[wallet];
        if (!lim.configured) revert DeaLimitsNotConfigured(wallet);
        if (lim.deaAgreementHash == bytes32(0)) revert NoDeaAgreement(wallet);
        if (notionalWei > lim.maxOrderNotionalWei) {
            revert OrderExceedsPerOrderLimit(wallet, notionalWei, lim.maxOrderNotionalWei);
        }

        // Rolling 24h window. A calendar-day window would need the same off-chain business
        // calendar the settlement and prospectus samples feed in; a rolling window needs no
        // calendar and is the stricter of the two, so it is the safe default here.
        if (block.timestamp >= dayWindowStart[wallet] + 1 days) {
            dayWindowStart[wallet] = uint64(block.timestamp);
            dayNotionalUsedWei[wallet] = 0;
        }

        uint256 wouldBe = dayNotionalUsedWei[wallet] + notionalWei;
        if (wouldBe > lim.maxDailyNotionalWei) {
            revert OrderExceedsDailyLimit(wallet, wouldBe, lim.maxDailyNotionalWei);
        }
        dayNotionalUsedWei[wallet] = wouldBe;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // COMPLIANCE-MODULE SHAPE — so the same conditions can gate holding, not
    // just order entry, when the instrument is members-only.
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev Mint (`from == 0`) still checks the recipient; burn (`to == 0`) checks neither,
    ///      because a redemption must not be blocked by a member condition the holder has
    ///      since ceased to satisfy — trapping a holder in an instrument is a worse outcome
    ///      than letting a lapsed member exit.
    function checkTransfer(address from, address to, uint256) external view {
        if (to != address(0)) checkAdmission(to);
        if (from != address(0) && to != address(0)) checkAdmission(from);
    }

    function notifyTransfer(address, address, uint256) external {}

    function moduleId() external pure returns (bytes32) {
        return "DLT_PILOT_ART_4_2_MEMBER";
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS
    // ═══════════════════════════════════════════════════════════════════════

    function conditions() external view returns (Condition[] memory) {
        return _conditions;
    }

    function conditionCount() external view returns (uint256) {
        return _conditions.length;
    }
}
