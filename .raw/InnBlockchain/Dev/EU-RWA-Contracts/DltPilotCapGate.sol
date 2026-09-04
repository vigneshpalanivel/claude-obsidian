// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title DltPilotCapGate (illustrative sample — not production code)
/// @notice DLT Pilot Regulation (EU) 2022/858 Art 3 — the eligibility and volume caps a DLT
///         market infrastructure operates under. TWO MECHANISMS THAT LOOK LIKE ONE:
///           (1) a point-in-time, per-instrument check at admission — Art 3(1)(a)–(c);
///           (2) a continuously-maintained aggregate register — Art 3(2) €6bn and Art 3(3)
///               €9bn, which move on price alone, with zero minting.
///         An admission-time-only gate satisfies (1) and never fires for (2). That is the
///         single most common way this Article is mis-built: aggregate value can cross the
///         ceiling overnight on a revaluation while the operator admits nothing at all.
/// @dev    ⚠️ €6bn IS A BLOCK, NOT AN ALERT. Under Arts 8(12)/9(12)/10(12) the NCA **shall**
///         withdraw the specific permission where the Art 3(2) threshold is exceeded —
///         ground (d), independent of ground (e) for €9bn. Treating €6bn as the soft limit
///         and €9bn as the hard one gets the regime backwards: breaching €6bn is on its own
///         fatal to the permission. `admit()` therefore reverts at the ceiling.
/// @dev    ⚠️ A STALE FEED FREEZES ADMISSIONS. If the aggregate figure cannot be shown to be
///         current, the gate does not know whether the ceiling has been crossed, and
///         "unknown" must fail closed. The alternative — admitting on a stale number — is
///         how an operator crosses a withdrawal-ground threshold without a single alert.
/// @dev    ⚠️ THRESHOLDS ARE PARAMETERS AND MAY ONLY BE SET *DOWNWARDS*. Art 3(6) lets the
///         home NCA impose lower thresholds than the regulation's headline figures. There is
///         no mechanism anywhere for raising them, so the setters here refuse any value
///         above the statutory constant. Hard-coding €6bn/€9bn as constants would make an
///         NCA-imposed lower figure a redeployment.
/// @dev    The April 2026 Market Integration Package proposes deleting the €9bn trigger and
///         moving to a €100bn cap. Deletion is structural, not a value change — hence
///         `transitionTriggerEnabled`, so the Art 3(3) limb can be switched off without
///         redeploying the token or the settlement path. Not yet adopted; nothing here
///         assumes it passes.
contract DltPilotCapGate {
    // ─────────────────────────── statutory ceilings ───────────────────────────
    //
    // Expressed in the base unit of the venue's single reference currency (18 dp), matching
    // the `Wei` convention used across these samples. A multi-currency venue needs an FX
    // normalisation step feeding this register — the aggregate test is a single figure in
    // the regulation, so the conversion happens before the number arrives here, not inside.

    uint256 public constant REG_SHARE_MARKET_CAP_CEILING_WEI = 500_000_000e18; // Art 3(1)(a)
    uint256 public constant REG_BOND_ISSUANCE_CEILING_WEI = 1_000_000_000e18; // Art 3(1)(b)
    uint256 public constant REG_CIU_AUM_CEILING_WEI = 500_000_000e18; // Art 3(1)(c)
    uint256 public constant REG_SMALL_ISSUER_CARVE_OUT_WEI = 200_000_000e18; // Art 3(1)(b) 2nd subpara
    uint256 public constant REG_ADMISSION_CEILING_WEI = 6_000_000_000e18; // Art 3(2)
    uint256 public constant REG_TRANSITION_TRIGGER_WEI = 9_000_000_000e18; // Art 3(3)

    // ─────────────────────────── live parameters (Art 3(6)) ───────────────────

    uint256 public shareMarketCapCeilingWei = REG_SHARE_MARKET_CAP_CEILING_WEI;
    uint256 public bondIssuanceCeilingWei = REG_BOND_ISSUANCE_CEILING_WEI;
    uint256 public ciuAumCeilingWei = REG_CIU_AUM_CEILING_WEI;
    uint256 public admissionCeilingWei = REG_ADMISSION_CEILING_WEI;
    uint256 public transitionTriggerWei = REG_TRANSITION_TRIGGER_WEI;

    bool public transitionTriggerEnabled = true;

    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;
    address public immutable admissionsOfficer; // proposes admissions; cannot change parameters
    address public valuationOracle; // posts the Art 3(4) aggregate figure

    // ─────────────────────────── instrument classification ────────────────────

    enum AssetClass {
        Unset,
        Share, // Art 3(1)(a)
        BondOrSecuritisedDebt, // Art 3(1)(b)
        MoneyMarketInstrument, // Art 3(1)(b)
        CiuUnit // Art 3(1)(c)
    }

    /// @notice Everything here is a CLASSIFICATION INPUT, determined off-chain and fed in.
    ///         None of it is computable on-chain — "incorporates a structure making the risk
    ///         difficult to understand" is a legal judgement, and issuer market capitalisation
    ///         at the time of issuance is a historical fact about a company this contract has
    ///         no view of. The gate's job is to apply them consistently, not to derive them.
    struct Classification {
        AssetClass assetClass;
        /// @dev Art 3(1)(b): a bond embedding a derivative, or incorporating a structure
        ///      making the risk difficult to understand, is excluded from eligibility
        ///      OUTRIGHT — not merely counted against the €1bn figure. A separate and
        ///      stricter test than the cap, and the one most often collapsed into it.
        bool embedsDerivativeOrOpaqueStructure;
        /// @dev Art 3(1)(b) 2nd subpara: corporate bonds from an issuer whose market cap did
        ///      not exceed €200m at the time of issuance are excluded from the €1bn
        ///      calculation entirely — so such a bond is eligible at any issuance size. This
        ///      is real headroom an issuance pipeline can be designed around, which is why it
        ///      is an explicit input rather than a comment.
        bool isCorporateBond;
        uint256 issuerMarketCapAtIssuanceWei;
        /// @dev The Art 3(1) measure for the instrument's own class: issuer market cap for
        ///      shares, issuance size for debt, AUM for CIU units. One field, three meanings,
        ///      selected by `assetClass` — kept as one field because the regulation applies
        ///      exactly one test per instrument.
        uint256 classMeasureWei;
        bytes32 classificationRefHash; // the off-chain determination this record came from
    }

    struct Instrument {
        bool admitted;
        Classification classification;
        uint64 admittedAt;
        /// @dev Art 5(8) references aggregate market value AT INITIAL RECORDING, which is a
        ///      different figure from the Art 3(2)/3(3) running aggregate. Captured once,
        ///      never revalued.
        uint256 valueAtInitialRecordingWei;
    }

    mapping(bytes32 => Instrument) private _instruments;
    bytes32[] private _admittedIds;

    // ─────────────────────────── aggregate register ───────────────────────────

    /// @notice The Art 3(4) figure: a MONTHLY AVERAGE of aggregate market value, computed
    ///         off-chain to the prescribed method and posted here. Deliberately not a naive
    ///         on-chain sum of current prices — that is a spot figure, and Art 3(4) does not
    ///         ask for a spot figure.
    uint256 public monthlyAverageAggregateWei;
    uint64 public aggregatePostedAt;

    /// @notice Independent of the above and never derived from it. Art 5(8) disapplies CSDR
    ///         Title IV for commercial-bank-money settlement while this figure stays ≤ €6bn,
    ///         so crossing the ceiling changes the SETTLEMENT ASSET REGIME as well as
    ///         blocking admissions. Two consequences from one number, on two different
    ///         measurement bases.
    uint256 public aggregateAtInitialRecordingWei;

    /// @notice Beyond this age the posted aggregate is treated as unknown and admissions
    ///         fail closed. Tight by default: this figure is the only thing standing between
    ///         the operator and a withdrawal ground.
    uint64 public maxFeedAgeSeconds = 2 days;

    bool public transitionStrategyTriggered;
    uint64 public transitionTriggeredAt;

    // ─────────────────────────── events ───────────────────────────────────────

    event InstrumentAdmitted(bytes32 indexed instrumentId, AssetClass assetClass, uint256 valueAtRecordingWei);
    event InstrumentRemoved(bytes32 indexed instrumentId, bytes32 reasonHash);
    event AggregatePosted(uint256 monthlyAverageWei, uint64 postedAt, address indexed oracle);
    /// @dev Art 3(3). Latched, not repeating: the strategy activates once, and the Art 7(7)
    ///      clock starts from that moment. A repeating alert would obscure when it started.
    event TransitionStrategyTriggered(uint256 monthlyAverageWei, uint256 triggerWei, uint64 at);
    event ThresholdLowered(bytes32 indexed which, uint256 oldWei, uint256 newWei, bytes32 ncaRefHash);
    event TransitionTriggerLimbDisabled(bytes32 legalBasisHash);
    event ValuationOracleSet(address indexed oracle);
    event FeedAgeLimitSet(uint64 seconds_);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotAdmissionsOfficer();
    error NotValuationOracle();
    error AlreadyAdmitted(bytes32 instrumentId);
    error UnknownInstrument(bytes32 instrumentId);
    error AssetClassUnset(bytes32 instrumentId);
    /// @dev Art 3(1)(b) outright exclusion — deliberately NOT the same error as a cap breach.
    ///      An opaque or derivative-embedding bond is ineligible at any size; conflating it
    ///      with a cap breach invites someone to "fix" it by reducing the issuance.
    error InstrumentIneligibleByStructure(bytes32 instrumentId);
    error PerInstrumentCapBreached(bytes32 instrumentId, uint256 measureWei, uint256 ceilingWei);
    error AggregateCeilingReached(uint256 aggregateWei, uint256 ceilingWei);
    error StaleValuationFeed(uint64 postedAt, uint64 maxAgeSeconds);
    error ThresholdCanOnlyBeLowered(uint256 proposedWei, uint256 statutoryWei);
    error TransitionLimbAlreadyDisabled();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_, address admissionsOfficer_, address valuationOracle_) {
        governance = governance_;
        admissionsOfficer = admissionsOfficer_;
        valuationOracle = valuationOracle_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PARAMETERS — Art 3(6). Downward only, and each change carries the
    // supervisory reference that justified it.
    // ═══════════════════════════════════════════════════════════════════════

    function lowerAdmissionCeiling(uint256 newWei, bytes32 ncaRefHash) external onlyGovernance {
        if (newWei > REG_ADMISSION_CEILING_WEI) revert ThresholdCanOnlyBeLowered(newWei, REG_ADMISSION_CEILING_WEI);
        emit ThresholdLowered("ART_3_2_ADMISSION", admissionCeilingWei, newWei, ncaRefHash);
        admissionCeilingWei = newWei;
    }

    function lowerTransitionTrigger(uint256 newWei, bytes32 ncaRefHash) external onlyGovernance {
        if (newWei > REG_TRANSITION_TRIGGER_WEI) revert ThresholdCanOnlyBeLowered(newWei, REG_TRANSITION_TRIGGER_WEI);
        emit ThresholdLowered("ART_3_3_TRANSITION", transitionTriggerWei, newWei, ncaRefHash);
        transitionTriggerWei = newWei;
    }

    function lowerShareCeiling(uint256 newWei, bytes32 ncaRefHash) external onlyGovernance {
        if (newWei > REG_SHARE_MARKET_CAP_CEILING_WEI) {
            revert ThresholdCanOnlyBeLowered(newWei, REG_SHARE_MARKET_CAP_CEILING_WEI);
        }
        emit ThresholdLowered("ART_3_1_A_SHARE", shareMarketCapCeilingWei, newWei, ncaRefHash);
        shareMarketCapCeilingWei = newWei;
    }

    function lowerBondCeiling(uint256 newWei, bytes32 ncaRefHash) external onlyGovernance {
        if (newWei > REG_BOND_ISSUANCE_CEILING_WEI) {
            revert ThresholdCanOnlyBeLowered(newWei, REG_BOND_ISSUANCE_CEILING_WEI);
        }
        emit ThresholdLowered("ART_3_1_B_BOND", bondIssuanceCeilingWei, newWei, ncaRefHash);
        bondIssuanceCeilingWei = newWei;
    }

    function lowerCiuCeiling(uint256 newWei, bytes32 ncaRefHash) external onlyGovernance {
        if (newWei > REG_CIU_AUM_CEILING_WEI) revert ThresholdCanOnlyBeLowered(newWei, REG_CIU_AUM_CEILING_WEI);
        emit ThresholdLowered("ART_3_1_C_CIU", ciuAumCeilingWei, newWei, ncaRefHash);
        ciuAumCeilingWei = newWei;
    }

    /// @notice One-way switch for the Art 3(3) limb, held for the case where the €9bn
    ///         trigger is legislated away rather than re-tuned. Guarded by a legal-basis
    ///         hash because disabling a statutory trigger on anything less than an adopted
    ///         amendment is indefensible, and the ledger should show which it was.
    function disableTransitionTriggerLimb(bytes32 legalBasisHash) external onlyGovernance {
        if (!transitionTriggerEnabled) revert TransitionLimbAlreadyDisabled();
        transitionTriggerEnabled = false;
        emit TransitionTriggerLimbDisabled(legalBasisHash);
    }

    function setValuationOracle(address oracle) external onlyGovernance {
        valuationOracle = oracle;
        emit ValuationOracleSet(oracle);
    }

    function setFeedAgeLimit(uint64 seconds_) external onlyGovernance {
        maxFeedAgeSeconds = seconds_;
        emit FeedAgeLimitSet(seconds_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // AGGREGATE REGISTER — Art 3(2)/3(3)/3(4)
    //
    // The €9bn latch fires HERE, on revaluation, not on admission. That is the
    // whole point: aggregate value crosses on price appreciation with nothing
    // being admitted, so a trigger wired only into `admit()` never runs.
    // ═══════════════════════════════════════════════════════════════════════

    function postAggregate(uint256 monthlyAverageWei) external {
        if (msg.sender != valuationOracle) revert NotValuationOracle();

        monthlyAverageAggregateWei = monthlyAverageWei;
        aggregatePostedAt = uint64(block.timestamp);
        emit AggregatePosted(monthlyAverageWei, aggregatePostedAt, msg.sender);

        if (
            transitionTriggerEnabled &&
            !transitionStrategyTriggered &&
            monthlyAverageWei >= transitionTriggerWei
        ) {
            transitionStrategyTriggered = true;
            transitionTriggeredAt = uint64(block.timestamp);
            emit TransitionStrategyTriggered(monthlyAverageWei, transitionTriggerWei, transitionTriggeredAt);
        }
    }

    function aggregateIsFresh() public view returns (bool) {
        return aggregatePostedAt != 0 && block.timestamp <= aggregatePostedAt + maxFeedAgeSeconds;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ADMISSION — Art 3(1) per-instrument, then Art 3(2) aggregate. Both must
    // pass; neither substitutes for the other.
    // ═══════════════════════════════════════════════════════════════════════

    function admit(
        bytes32 instrumentId,
        Classification calldata c,
        uint256 valueAtRecordingWei
    ) external {
        if (msg.sender != admissionsOfficer) revert NotAdmissionsOfficer();
        if (_instruments[instrumentId].admitted) revert AlreadyAdmitted(instrumentId);

        checkPerInstrumentCap(instrumentId, c);

        if (!aggregateIsFresh()) revert StaleValuationFeed(aggregatePostedAt, maxFeedAgeSeconds);
        if (monthlyAverageAggregateWei >= admissionCeilingWei) {
            revert AggregateCeilingReached(monthlyAverageAggregateWei, admissionCeilingWei);
        }

        _instruments[instrumentId] = Instrument({
            admitted: true,
            classification: c,
            admittedAt: uint64(block.timestamp),
            valueAtInitialRecordingWei: valueAtRecordingWei
        });
        _admittedIds.push(instrumentId);
        aggregateAtInitialRecordingWei += valueAtRecordingWei;

        emit InstrumentAdmitted(instrumentId, c.assetClass, valueAtRecordingWei);
    }

    /// @notice Exposed separately so an issuance pipeline can test a candidate before it is
    ///         priced or drafted. The €200m carve-out in particular is worth querying early:
    ///         it is the difference between a €1bn ceiling and no ceiling at all.
    function checkPerInstrumentCap(bytes32 instrumentId, Classification calldata c) public view {
        if (c.assetClass == AssetClass.Unset) revert AssetClassUnset(instrumentId);

        if (c.assetClass == AssetClass.Share) {
            if (c.classMeasureWei >= shareMarketCapCeilingWei) {
                revert PerInstrumentCapBreached(instrumentId, c.classMeasureWei, shareMarketCapCeilingWei);
            }
            return;
        }

        if (c.assetClass == AssetClass.CiuUnit) {
            if (c.classMeasureWei >= ciuAumCeilingWei) {
                revert PerInstrumentCapBreached(instrumentId, c.classMeasureWei, ciuAumCeilingWei);
            }
            return;
        }

        // Debt: the outright structural exclusion is tested FIRST and is not a cap question.
        if (c.embedsDerivativeOrOpaqueStructure) revert InstrumentIneligibleByStructure(instrumentId);

        // Art 3(1)(b) 2nd subpara — small corporate issuers drop out of the €1bn calculation
        // entirely, so no size test applies to them.
        bool carvedOut = c.isCorporateBond && c.issuerMarketCapAtIssuanceWei <= REG_SMALL_ISSUER_CARVE_OUT_WEI;
        if (carvedOut) return;

        if (c.classMeasureWei >= bondIssuanceCeilingWei) {
            revert PerInstrumentCapBreached(instrumentId, c.classMeasureWei, bondIssuanceCeilingWei);
        }
    }

    function remove(bytes32 instrumentId, bytes32 reasonHash) external onlyGovernance {
        Instrument storage inst = _instruments[instrumentId];
        if (!inst.admitted) revert UnknownInstrument(instrumentId);

        aggregateAtInitialRecordingWei -= inst.valueAtInitialRecordingWei;
        inst.admitted = false;

        for (uint256 i = 0; i < _admittedIds.length; i++) {
            if (_admittedIds[i] == instrumentId) {
                _admittedIds[i] = _admittedIds[_admittedIds.length - 1];
                _admittedIds.pop();
                break;
            }
        }
        emit InstrumentRemoved(instrumentId, reasonHash);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // REPORTING READS — Art 3(5) monthly and Art 11(4) six-monthly. Two
    // separate reports; do not consolidate them. Both are derived from this
    // register rather than rebuilt by hand each cycle.
    // ═══════════════════════════════════════════════════════════════════════

    function admittedCount() external view returns (uint256) {
        return _admittedIds.length;
    }

    function admittedIds() external view returns (bytes32[] memory) {
        return _admittedIds;
    }

    function instrumentOf(bytes32 instrumentId) external view returns (Instrument memory) {
        return _instruments[instrumentId];
    }

    /// @notice True while commercial-bank-money settlement stays outside CSDR Title IV under
    ///         Art 5(8). A settlement engine should read this rather than assume it.
    function withinArt5_8CommercialBankMoneyHeadroom() external view returns (bool) {
        return aggregateAtInitialRecordingWei <= REG_ADMISSION_CEILING_WEI;
    }

    /// @notice Headroom before admissions stop. Negative headroom is not representable —
    ///         it returns 0, because past the ceiling the answer is not "how much less than
    ///         zero", it is "you are at a withdrawal ground".
    function admissionHeadroomWei() external view returns (uint256) {
        if (monthlyAverageAggregateWei >= admissionCeilingWei) return 0;
        return admissionCeilingWei - monthlyAverageAggregateWei;
    }
}
