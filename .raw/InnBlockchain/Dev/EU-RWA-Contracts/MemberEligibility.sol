// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IErasable, IIdentityGate} from "./Interfaces.sol";

/// @notice The claims limb of the identity layer, plus — by inheritance — the canonical gate.
/// @dev    ⚠️ INHERITS `IIdentityGate` RATHER THAN RE-DECLARING ITS MEMBERS. This contract needs
///         the wallet → person key (`personIdOf`) and `Interfaces.sol` already defines it.
///         Copying that signature into a local interface would give one dependency two
///         definitions with no compiler error to announce a divergence — precisely the failure
///         `Interfaces.sol` says it exists to prevent.
///         The claim members stay declared here because `ClaimValue` is still declared inside
///         `IdentityRegistry` rather than hoisted to the shared-types block. Hoisting it is a
///         suite-wide change and is deliberately not bundled into this one.
interface IIdentityRegistryClaims is IIdentityGate {
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
/// @notice DLT Pilot Art 4(2) — **conditions (a) and (b) only** of the seven cumulative
///         conditions a natural or legal person must satisfy to be admitted directly as a
///         member or participant of a DLT MTF, i.e. to trade without an intermediating
///         investment firm. This is the exemption that makes retail-direct venue access
///         possible at all, and it is the only reason most operators enter the pilot.
/// @dev    ⚠️ THE SEVEN CONDITIONS HAVE TWO HOMES, AND THE SPLIT IS NOT ARBITRARY. This
///         contract holds **(a) good repute** and **(b) competence including knowledge of
///         how DLT works** — both are determinations the venue makes ABOUT the member and
///         writes back as claims, which is the C3 attestation model.
///         **(c)–(g) live in `CovenantRegistry` (C7)** and were removed from here:
///           • (c)–(f) are the member's own negative declarations — not a market maker on
///             this MTF, not running HFT on it, not providing others direct electronic
///             access to it, not dealing on own account when executing client orders. No
///             third party can attest them, and they bind the SENDER on every transfer,
///             which an attestation-about-the-investor model cannot express.
///           • (g) informed consent is given against a SPECIFIC risk disclosure and must
///             bind that document's version hash. As a boolean claim it was a live breach:
///             update the venue's risk disclosure and every stale consent still read valid.
///         ⚠️ **Admission is only compliant if BOTH surfaces are checked.** Registering this
///         module without also registering `CovenantGate` enforces two of seven conditions
///         and reports the result as a clean admission.
/// @dev    ⚠️ A MISSING CLAIM IS NOT A CLEAN RECORD. (a) and (b) must be recorded as
///         explicitly `AssertedTrue`; `NotRecorded` fails. The same principle governs the
///         negative conditions in their new home — encoding them as "absence of a bad
///         claim", the intuitive shape, silently admits every wallet nobody has yet
///         assessed, which is the whole population on day one.
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
/// @dev    ⚠️ ADMISSION AND THE DEA LIMITS ARE SCOPED TO THE **PERSON**, NOT TO THE ADDRESS.
///         Both obligations here are owed by somebody, and one person may hold several wallets —
///         the identity layer permits it and lost-key recovery requires it. Keyed per address:
///           • the Art 17(5) daily credit threshold doubled with each additional wallet, with
///             nothing reverting and no event to notice — the limit was simply not the limit; and
///           • `admittedMemberCount` counted addresses, so the DLT Pilot Art 11(4) six-monthly
///             report overstated the membership against the operator's own admission file.
///         The person key is `IdentityRegistry`'s `personId`, read through
///         `IIdentityGate.personIdOf`. It is the same key `SecurityToken.recoverWallet`
///         uses to prove two addresses are one investor, which is what makes it the right one:
///         a fix that invented a second person namespace would just move the problem.
contract MemberEligibility is IErasable {
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

    // ⚠️ TOPICS 22–26 DELETED — Art 4(2)(c)–(g) live in `CovenantRegistry`, not here.
    //    They are NOT reassigned to anything else: 22–26 stay retired in
    //    `ClaimTopicsRegistry`'s catalogue so that an identity record written against the
    //    old numbering can never be silently reinterpreted as some later topic. A retired
    //    topic number is cheaper than a reused one.
    //    Deleted rather than left declared-and-unread, because the sibling case is already
    //    on the record: `ClaimTopicsRegistry`'s `TOPIC_PRIIPS_KID_DELIVERED` was left
    //    declared after PRIIPs Art 13 moved to the covenant store, and it reads as an
    //    invitation to wire a boolean back up to an obligation that needs a version hash.

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

    /// @dev ⚠️ KEYED BY PERSON. Art 17(5) sets thresholds on a CLIENT, and the daily one it
    ///      calls a credit limit is the whole reason the article exists — a per-address key made
    ///      it additive across a participant's own wallets. `deaLimitsOf(wallet)` is the
    ///      address-shaped read for tooling.
    mapping(bytes32 => DeaLimits) public deaLimitsOfPerson;
    mapping(bytes32 => uint256) public dayNotionalUsedWei;
    mapping(bytes32 => uint64) public dayWindowStart;

    // ─────────────────────────── admission register ───────────────────────────
    //
    // Passing `checkAdmission` is necessary but not sufficient: Art 4(2) admission is an
    // operator decision, taken on a file, and the register is what the six-monthly Art 11(4)
    // report counts. A wallet that merely satisfies the conditions is not a member.

    mapping(address => bool) public isAdmittedMember;
    mapping(address => uint64) public admittedAt;

    /// @notice The person each admitted wallet was admitted under, **pinned at admission**.
    /// @dev    ⚠️ NEVER RE-RESOLVED. `personIdOf` can change under a live address —
    ///         `SecurityToken.recoverWallet` re-points one — and a person resolved at withdrawal
    ///         time would then decrement a bucket that was never incremented, underflowing one
    ///         person's count while stranding another's. It is also what the order path reads,
    ///         so a registry change cannot silently re-key a member's daily allowance mid-day.
    mapping(address => bytes32) public personOfAdmittedWallet;

    /// @dev How many live admitted wallets roll up to one person. The person leaves the member
    ///      count when the LAST of them is withdrawn, not the first.
    mapping(bytes32 => uint256) public admittedWalletsOfPerson;

    /// @notice Distinct PERSONS admitted — the figure the Art 11(4) six-monthly report gives the
    ///         NCA. Art 4(2) admits a natural or legal person; a member who adds a second wallet
    ///         does not become two members.
    uint256 public admittedMemberCount;

    /// @notice Admitted WALLETS. Both are stored because both get asked for and neither is
    ///         derivable from the other — leaving one to be recomputed off-chain is how the
    ///         reported figure and the register drift apart without either side being wrong.
    uint256 public admittedWalletCount;

    // ─────────────────────────── events ───────────────────────────────────────

    /// @notice The `PersonErasure` coordinator, permitted to call `erasePerson` and nothing else.
    /// @dev    Not `governance` and not `venue`: the desk that answers a data subject must not
    ///         also be the desk that admits members or places orders. Zero disables the path.
    address public erasureCoordinator;

    event ConditionAdded(uint256 indexed index, uint256 indexed topic, bytes32 label);
    event AdditionalConditionAdded(uint256 indexed index, uint256 indexed topic, bytes32 label, bytes32 ncaRefHash);
    /// @dev ⚠️ NO `personId` IN ANY LOG — reversed from the earlier design, which indexed it on
    ///      all three "so the Art 11(4) report can be assembled from logs alone". That
    ///      convenience was the leak. `personId` is the one value shared by every wallet a
    ///      human holds, so an indexed copy in a log is a permanent, un-erasable statement
    ///      that those addresses are the same person — the exact fact `IdentityRegistry`
    ///      keeps in storage precisely so `deregisterPerson` can delete it. The Art 11(4)
    ///      report joins wallet → person through `personOfAdmittedWallet()` instead, which
    ///      goes empty on withdrawal. Same rule for the DEA notionals: a trading limit is an
    ///      attribute of the person it binds, and lives in `deaLimitsOf()` where `delete`
    ///      can reach it. Events say THAT something changed; storage says WHAT.
    event MemberAdmitted(address indexed wallet, uint64 at);
    event MemberWithdrawn(address indexed wallet, uint64 at, bytes32 reasonHash);
    event DeaLimitsSet(address indexed setVia);
    event ErasureCoordinatorSet(address indexed previous, address indexed current);
    /// @dev Counts only. Which wallets a person held is already in the `MemberAdmitted` log and
    ///      cannot be retracted from it; restating it here would add nothing but reach.
    event MemberRecordsErased(uint256 walletsCleared);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotVenue();
    error ConditionNotMet(address wallet, uint256 topic, bytes32 label, IIdentityRegistryClaims.ClaimValue actual);
    error RetailSuitabilityUnresolved(address wallet);
    error RetailRiskWarningsNotAcknowledged(address wallet);
    error NotAMember(address wallet);
    error NotErasureCoordinator();
    /// @dev ⚠️ Raised when an erasure is attempted against a person still holding a live
    ///      admission. See `erasePerson`.
    error MemberStillAdmitted(address wallet);
    error AlreadyAMember(address wallet);
    error WalletNotRegistered(address wallet);
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

        // ⚠️ ONLY (a) AND (b) ARE CLAIMS. Conditions (c)–(g) were configured here as claim
        //    topics and have been removed — they belong in `CovenantRegistry` (C7), and
        //    having them in both places gave one obligation two on-chain enforcement points
        //    with different semantics.
        //
        //    (a) and (b) are attestations ABOUT the member — good repute, and competence
        //    including knowledge of how DLT works — determined off-chain by the venue and
        //    written back as claims. That is the C3 model and it is correct for them.
        //
        //    (c)–(f) are the member's own negative declarations (not a market maker, not
        //    running HFT, not providing DEA onward, not dealing on own account against
        //    client orders). No third party can attest them, and they bind the SENDER on
        //    every transfer — the `SEND` gate — which an attestation-about-the-investor
        //    model cannot express.
        //
        //    (g) is the one that made the duplication unsafe. Informed consent is given
        //    AGAINST A SPECIFIC RISK DISCLOSURE, so it must bind that document's version
        //    hash. As the boolean claim topic it was here, updating the venue's risk
        //    disclosure left every stale consent reading as valid — a live Art 4(2)(g)
        //    breach the contract reported as a clean admission. `CovenantRegistry`'s
        //    `invalidation = ON_NEW_DOCUMENT_VERSION` is what closes it.
        _push(TOPIC_GOOD_REPUTE, IIdentityRegistryClaims.ClaimValue.AssertedTrue, "ART_4_2_A_GOOD_REPUTE");
        _push(
            TOPIC_COMPETENCE_INCL_DLT,
            IIdentityRegistryClaims.ClaimValue.AssertedTrue,
            "ART_4_2_B_COMPETENCE_DLT"
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
    // PERSON RESOLUTION — the key both obligations in this contract are owed by
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice The off-chain investor record a wallet resolves to.
    /// @dev    ⚠️ FAILS CLOSED ON AN UNREGISTERED WALLET rather than falling back to the address.
    ///         A fallback is the tempting shape and it is the wrong one twice over: every
    ///         unregistered wallet would share the `bytes32(0)` bucket, so they would share one
    ///         daily allowance and collide on the admission counter. It costs nothing in
    ///         practice — `checkAdmission` runs `checkEligibleAndIdentifiable`, so an
    ///         unregistered wallet was never admissible.
    function _personOf(address wallet) internal view returns (bytes32) {
        (bytes32 personId, bool registered) = identity.personIdOf(wallet);
        if (!registered || personId == bytes32(0)) revert WalletNotRegistered(wallet);
        return personId;
    }

    /// @notice Address-shaped read of the person key, for operator tooling and the Art 11(4)
    ///         reconciliation. Reverts on an unregistered wallet, as the internal resolver does.
    function personOfWallet(address wallet) external view returns (bytes32) {
        return _personOf(wallet);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ADMISSION REGISTER
    // ═══════════════════════════════════════════════════════════════════════

    function admitMember(address wallet) external onlyGovernance {
        if (isAdmittedMember[wallet]) revert AlreadyAMember(wallet);
        checkAdmission(wallet);

        bytes32 personId = _personOf(wallet);

        isAdmittedMember[wallet] = true;
        admittedAt[wallet] = uint64(block.timestamp);
        personOfAdmittedWallet[wallet] = personId;
        admittedWalletCount++;

        // The person joins the member count on their FIRST live wallet only. A second wallet is
        // a second address for an existing member, not a second admission — Art 4(2) is a
        // decision taken on a person's file.
        if (admittedWalletsOfPerson[personId]++ == 0) admittedMemberCount++;

        emit MemberAdmitted(wallet, uint64(block.timestamp));
    }

    /// @dev The person is read from `personOfAdmittedWallet`, never re-resolved — see the note
    ///      on that mapping. The wallet's own admission ends immediately; the person's
    ///      membership ends only when their last admitted wallet is withdrawn, because a member
    ///      who retires one address has not left the venue.
    function withdrawMember(address wallet, bytes32 reasonHash) external onlyGovernance {
        if (!isAdmittedMember[wallet]) revert NotAMember(wallet);

        bytes32 personId = personOfAdmittedWallet[wallet];

        isAdmittedMember[wallet] = false;
        delete personOfAdmittedWallet[wallet];
        admittedWalletCount--;

        if (--admittedWalletsOfPerson[personId] == 0) admittedMemberCount--;

        emit MemberWithdrawn(wallet, uint64(block.timestamp), reasonHash);
    }

    /// @notice Point at the `PersonErasure` coordinator, or unset it with `address(0)`.
    function setErasureCoordinator(address coordinator) external onlyGovernance {
        address previous = erasureCoordinator;
        erasureCoordinator = coordinator;
        emit ErasureCoordinatorSet(previous, coordinator);
    }

    /// @notice GDPR Art 17 leg. Clears this venue's residue for one person.
    /// @dev    ⚠️ WITHDRAWAL IS NOT ERASURE, AND THE GAP BETWEEN THEM WAS REAL. `withdrawMember`
    ///         deletes `personOfAdmittedWallet` and adjusts the counts, and stops there. It has
    ///         never touched `admittedAt`, `deaLimitsOfPerson`, `dayNotionalUsedWei` or
    ///         `dayWindowStart` — so a withdrawn member left their MiFID II Art 17(5) credit
    ///         limits, their DEA agreement hash and their intraday usage in public storage
    ///         indefinitely, keyed by a `personId` that still resolved. Those are facts about a
    ///         named client's trading arrangements, and nothing in the venue's obligations
    ///         requires keeping them once the membership has ended.
    /// @dev    ⚠️ REFUSES WHILE ANY WALLET IS STILL ADMITTED, AND THE REFUSAL IS THE POINT. A
    ///         live admission is a DLT Pilot Art 4(2) decision the operator is accountable for
    ///         and a row in the Art 11(4) six-monthly report to the NCA. Erasing the record of a
    ///         member who is still trading would break the report and remove the limits the
    ///         order path enforces, which is a market-integrity failure dressed as a privacy
    ///         one. Withdraw first, then erase — and because the fan-out is atomic, this revert
    ///         stops the whole request rather than silently skipping this contract.
    function erasePerson(bytes32 personId, address[] calldata wallets) external {
        if (msg.sender != erasureCoordinator || erasureCoordinator == address(0)) revert NotErasureCoordinator();

        uint256 n = wallets.length;
        uint256 cleared;
        for (uint256 i = 0; i < n; i++) {
            address wallet = wallets[i];
            if (isAdmittedMember[wallet]) revert MemberStillAdmitted(wallet);
            if (admittedAt[wallet] != 0) {
                delete admittedAt[wallet];
                cleared++;
            }
            // Defensive: `withdrawMember` already clears this, but a wallet withdrawn by an
            // older code path or re-pointed by a registry swap could still carry it, and an
            // erasure that trusts a neighbouring function's completeness is how the claim
            // residue in `IdentityRegistry` survived deregistration for as long as it did.
            delete personOfAdmittedWallet[wallet];
        }

        delete deaLimitsOfPerson[personId];
        delete dayNotionalUsedWei[personId];
        delete dayWindowStart[personId];
        delete admittedWalletsOfPerson[personId];

        emit MemberRecordsErased(cleared);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // MiFID II ART 17(5) — DEA CONTROLS
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Pre-set trading and credit thresholds, plus the hash of the binding written
    ///         agreement. All three limbs are required together: limits without an agreement
    ///         is DEA on undocumented terms, and an agreement without limits is DEA with no
    ///         controls. Art 17(5) asks for both.
    /// @param  wallet Addressed by wallet for usability, but **the wallet is only the lookup** —
    ///         the limits are written against the person behind it and apply across every wallet
    ///         they hold. Setting them through a second address of the same member overwrites
    ///         the same record rather than granting a second allowance, which is the point.
    function setDeaLimits(
        address wallet,
        uint256 maxOrderNotionalWei,
        uint256 maxDailyNotionalWei,
        bytes32 deaAgreementHash
    ) external onlyGovernance {
        bytes32 personId = _personOf(wallet);

        deaLimitsOfPerson[personId] = DeaLimits({
            configured: true,
            maxOrderNotionalWei: maxOrderNotionalWei,
            maxDailyNotionalWei: maxDailyNotionalWei,
            deaAgreementHash: deaAgreementHash
        });
        emit DeaLimitsSet(wallet);
    }

    /// @notice Called by the venue before accepting an order. Consumes daily headroom, so it
    ///         is state-changing by design — a `view` version would have to be paired with a
    ///         separate consume call, and any gap between the two is the race a participant
    ///         uses to exceed its own credit limit.
    /// @dev The threshold and the consumed headroom are the PERSON's, so orders entered from a
    ///      member's second address draw down the same daily allowance as their first. The
    ///      person is read from `personOfAdmittedWallet` rather than resolved through the
    ///      identity registry: it saves an external call on the hot path, and it means a
    ///      registry change cannot re-key a member's spent headroom to a fresh empty bucket
    ///      part-way through a trading day.
    function checkAndConsumeOrder(address wallet, uint256 notionalWei) external onlyVenue {
        if (!isAdmittedMember[wallet]) revert NotAMember(wallet);

        bytes32 personId = personOfAdmittedWallet[wallet];

        DeaLimits storage lim = deaLimitsOfPerson[personId];
        if (!lim.configured) revert DeaLimitsNotConfigured(wallet);
        if (lim.deaAgreementHash == bytes32(0)) revert NoDeaAgreement(wallet);
        if (notionalWei > lim.maxOrderNotionalWei) {
            revert OrderExceedsPerOrderLimit(wallet, notionalWei, lim.maxOrderNotionalWei);
        }

        // Rolling 24h window. A calendar-day window would need the same off-chain business
        // calendar the settlement and prospectus samples feed in; a rolling window needs no
        // calendar and is the stricter of the two, so it is the safe default here.
        if (block.timestamp >= dayWindowStart[personId] + 1 days) {
            dayWindowStart[personId] = uint64(block.timestamp);
            dayNotionalUsedWei[personId] = 0;
        }

        uint256 wouldBe = dayNotionalUsedWei[personId] + notionalWei;
        if (wouldBe > lim.maxDailyNotionalWei) {
            revert OrderExceedsDailyLimit(wallet, wouldBe, lim.maxDailyNotionalWei);
        }
        dayNotionalUsedWei[personId] = wouldBe;
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

    /// @notice DEA limits as they apply to the person behind a wallet.
    /// @dev    Replaces the old public `deaLimits(address)` getter. Kept address-shaped because
    ///         every caller starts from an address; what changed is that two addresses of one
    ///         member now return the same record instead of two.
    function deaLimitsOf(address wallet) external view returns (DeaLimits memory) {
        return deaLimitsOfPerson[_personOf(wallet)];
    }

    /// @notice Daily notional still available to the person behind a wallet, accounting for a
    ///         rolling window that may already have expired.
    /// @dev    Reads what `checkAndConsumeOrder` would compute, so a venue pre-checking an order
    ///         and the contract enforcing it cannot disagree. Returns 0 where limits are
    ///         unconfigured — unconfigured is a hard revert on the order path, not headroom.
    function dailyHeadroomOf(address wallet) external view returns (uint256) {
        bytes32 personId = isAdmittedMember[wallet] ? personOfAdmittedWallet[wallet] : _personOf(wallet);

        DeaLimits storage lim = deaLimitsOfPerson[personId];
        if (!lim.configured) return 0;

        if (block.timestamp >= dayWindowStart[personId] + 1 days) return lim.maxDailyNotionalWei;

        uint256 used = dayNotionalUsedWei[personId];
        return used >= lim.maxDailyNotionalWei ? 0 : lim.maxDailyNotionalWei - used;
    }
}
