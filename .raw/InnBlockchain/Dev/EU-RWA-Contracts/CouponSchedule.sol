// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {SecurityToken} from "./SecurityToken.sol";
import {DistributionAgent} from "./DistributionAgent.sol";

/// @title CouponSchedule (illustrative sample — not production code)
/// @notice C4 — fixed contractual interest on a debt or note token: accrual, the payment
///         schedule, and redemption at maturity.
/// @dev    ⚠️ THIS IS THE ONE CONTRACT IN THIS FOLDER THAT DISCHARGES NO NUMBERED ARTICLE, AND
///         SAYING SO IS THE POINT. Nothing in PRIIPs, Prospectus, MAR, ELTIF, UCITS, AIFMD II,
///         DLT Pilot or MiFIR obliges a debt token to pay coupons on any particular schedule.
///         What this executes is a FINANCIAL TERM the parties agreed. It earns its place next
///         to the compliance modules for two reasons only, both below — and an audit map that
///         lists it against an Article has invented one.
/// @dev    ⚠️ REASON ONE — IT MUST NOT BECOME A FREEZE BYPASS. A coupon is income on units, so
///         it goes out through `DistributionAgent` and its C1 eligibility gate like every other
///         payout. This contract computes an amount; it never pays anyone. A coupon contract
///         that sent funds directly would let a frozen wallet collect interest on units it
///         cannot move.
/// @dev    ⚠️ REASON TWO — THE TERMS ARE A PROSPECTUS DISCLOSURE ITEM, SO THEY ARE IMMUTABLE
///         HERE. Rate, schedule, principal and maturity are all disclosed under Prospectus
///         Arts 6/16(1). Changing them after approval is a material change carrying an Art 23
///         supplement and an investor withdrawal window. That is why every term is set once in
///         the constructor and there is no setter anywhere below. A mutable coupon rate would
///         let an operations key do, in one transaction, something the regulation treats as a
///         re-offer.
/// @dev    ⚠️ THIS MODELS AN ISSUER-FUNDED LIABILITY, NOT A PASS-THROUGH. The issuer owes the
///         coupon and funds it. An instrument where the cash flow is a third-party borrower's
///         repayments and the credit loss lands on the holder — a loan participation — is the
///         mirror image and is NOT this contract, however similar the payment calendar looks.
///         Reaching for `CouponSchedule` to model one is a known miscitation.
contract CouponSchedule {
    // ═══════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice ⚠️ ILLUSTRATIVE ONLY, AND THE SHORT LIST IS ITSELF A WARNING. Real terms sheets
    ///         use ACT/ACT (ICMA), ACT/360, ACT/365F, 30/360 (US, EU, ICMA) and more, and they
    ///         produce different numbers on the same dates. The convention in the terms
    ///         document governs; two are modelled here so the arithmetic is visible, not
    ///         because a debt programme can pick from two.
    enum DayCount {
        /// @dev Actual days elapsed over 365. Period length varies with the calendar.
        Actual365Fixed,
        /// @dev Equal periods: the annual coupon divided by the number of periods per year.
        ///      Insensitive to the actual dates, which is the point of it.
        Thirty360Equal
    }

    enum PeriodState {
        Scheduled,
        /// @dev A distribution has been bound and the amount is fixed.
        Bound,
        Settled,
        /// @dev Payment not made by the end of the grace period. See `declareDefault`.
        Defaulted
    }

    struct Period {
        uint64 startsAt;
        uint64 endsAt;
        PeriodState state;
        /// @dev The `DistributionAgent` distribution carrying this period's cash.
        uint256 distributionId;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // IMMUTABLE TERMS — every one of these is a prospectus disclosure item
    // ═══════════════════════════════════════════════════════════════════════

    address public immutable governance;
    SecurityToken public immutable token;
    DistributionAgent public immutable distributions;

    /// @notice Face value of one smallest token unit, in wei.
    uint256 public immutable principalPerUnit;

    /// @notice Annual coupon, in basis points of principal. A zero-coupon note sets this to 0
    ///         and carries its return entirely in the redemption leg.
    uint16 public immutable annualCouponRateBps;

    DayCount public immutable dayCount;

    /// @notice Periods per year. Used by `Thirty360Equal`; recorded either way because it is
    ///         part of the disclosed terms.
    uint8 public immutable periodsPerYear;

    uint64 public immutable maturityDate;

    /// @notice Days after a period end within which payment is still timely. Part of the terms,
    ///         not an operational convenience — it decides when a default has occurred.
    uint64 public immutable gracePeriod;

    uint16 public constant BPS = 10_000;

    // ═══════════════════════════════════════════════════════════════════════
    // STATE
    // ═══════════════════════════════════════════════════════════════════════

    Period[] private _periods;

    /// @notice Set once, at redemption. After this the instrument pays nothing further.
    bool public redeemed;

    mapping(address => bool) public isAgent;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS
    // ═══════════════════════════════════════════════════════════════════════

    event AgentSet(address indexed agent, bool allowed);
    event TermsPublished(
        uint256 principalPerUnit, uint16 annualCouponRateBps, DayCount dayCount, uint64 maturityDate, uint256 periods
    );
    event PeriodBound(uint256 indexed index, uint256 indexed distributionId, uint256 couponPerUnit);
    event PeriodSettled(uint256 indexed index, uint256 indexed distributionId);

    /// @notice ⚠️ A MISSED COUPON IS ALMOST CERTAINLY INSIDE INFORMATION. Under MAR Art 17(1)
    ///         an issuer whose instrument is admitted must disclose it as soon as possible, and
    ///         `documentRef` is where that disclosure is anchored in `DocumentRegistry`. The
    ///         contract cannot make the issuer disclose; it can refuse to let the default be
    ///         recorded without a pointer to the announcement.
    event PaymentDefaulted(uint256 indexed index, uint64 dueBy, bytes32 documentRef);
    event Redeemed(uint256 indexed distributionId, uint256 redemptionPerUnit, uint64 at);

    // ═══════════════════════════════════════════════════════════════════════
    // ERRORS
    // ═══════════════════════════════════════════════════════════════════════

    error NotGovernance();
    error NotAgent();
    error NoPeriods();
    error PeriodsOutOfOrder(uint256 index);
    error UnknownPeriod(uint256 index);
    error WrongPeriodState(uint256 index, PeriodState expected, PeriodState actual);
    error PeriodNotEnded(uint256 index, uint64 endsAt);
    error GracePeriodNotExpired(uint256 index, uint64 dueBy);
    error DisclosureRefRequired();
    error DistributionRateMismatch(uint256 expected, uint256 actual);
    error AlreadyRedeemed();
    error NotAtMaturity(uint64 maturityDate);
    error UnsettledPeriodsRemain(uint256 index);
    error MaturityBeforeLastPeriod(uint64 maturityDate, uint64 lastPeriodEnd);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyAgent() {
        if (!isAgent[msg.sender]) revert NotAgent();
        _;
    }

    /// @dev The full schedule is fixed at construction. ⚠️ Passing the period boundaries in
    ///      rather than generating them from a frequency is deliberate: real terms sheets
    ///      adjust payment dates for business days under a stated convention (Following,
    ///      Modified Following), and a contract that generates dates arithmetically will
    ///      silently disagree with the terms document on every holiday.
    constructor(
        address governance_,
        address token_,
        address distributions_,
        uint256 principalPerUnit_,
        uint16 annualCouponRateBps_,
        DayCount dayCount_,
        uint8 periodsPerYear_,
        uint64 maturityDate_,
        uint64 gracePeriod_,
        uint64[] memory periodBoundaries
    ) {
        if (periodBoundaries.length < 2) revert NoPeriods();

        governance = governance_;
        token = SecurityToken(token_);
        distributions = DistributionAgent(distributions_);
        principalPerUnit = principalPerUnit_;
        annualCouponRateBps = annualCouponRateBps_;
        dayCount = dayCount_;
        periodsPerYear = periodsPerYear_;
        maturityDate = maturityDate_;
        gracePeriod = gracePeriod_;

        for (uint256 i = 1; i < periodBoundaries.length; i++) {
            if (periodBoundaries[i] <= periodBoundaries[i - 1]) revert PeriodsOutOfOrder(i);
            _periods.push(
                Period({
                    startsAt: periodBoundaries[i - 1],
                    endsAt: periodBoundaries[i],
                    state: PeriodState.Scheduled,
                    distributionId: 0
                })
            );
        }

        uint64 lastEnd = periodBoundaries[periodBoundaries.length - 1];
        if (maturityDate_ < lastEnd) revert MaturityBeforeLastPeriod(maturityDate_, lastEnd);

        emit TermsPublished(principalPerUnit_, annualCouponRateBps_, dayCount_, maturityDate_, _periods.length);
    }

    function setAgent(address agent, bool allowed) external onlyGovernance {
        isAgent[agent] = allowed;
        emit AgentSet(agent, allowed);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ACCRUAL
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice The coupon owed on one unit for one period, in wei.
    /// @dev    ⚠️ INTEGER DIVISION TRUNCATES, AND ON A PER-UNIT RATE THE TRUNCATION IS
    ///         MULTIPLIED BY EVERY UNIT IN ISSUE. With a small `principalPerUnit` the rounding
    ///         loss is material rather than dust, and it always falls on the holder. The
    ///         mitigation is denomination: `principalPerUnit` must be large enough in wei that
    ///         one period's coupon has many significant digits. That is a term-setting
    ///         decision made before issuance, and no arithmetic here can rescue a token
    ///         denominated too coarsely.
    function couponPerUnit(uint256 index) public view returns (uint256) {
        Period storage p = _requirePeriod(index);

        uint256 annual = (principalPerUnit * annualCouponRateBps) / BPS;

        if (dayCount == DayCount.Thirty360Equal) {
            return periodsPerYear == 0 ? 0 : annual / periodsPerYear;
        }

        uint256 elapsed = uint256(p.endsAt - p.startsAt);
        return (annual * elapsed) / 365 days;
    }

    /// @notice Accrued but unpaid interest on one unit as at now, within the current period.
    ///         What a secondary-market buyer pays the seller on top of the clean price.
    /// @dev    Informational. This contract does not settle accrued interest between
    ///         counterparties — that is a price the two of them agree, and it settles in the
    ///         cash leg, not here.
    function accruedPerUnit() external view returns (uint256) {
        for (uint256 i = 0; i < _periods.length; i++) {
            Period storage p = _periods[i];
            if (block.timestamp < p.startsAt) return 0;
            if (block.timestamp < p.endsAt) {
                uint256 full = couponPerUnit(i);
                uint256 elapsed = block.timestamp - p.startsAt;
                return (full * elapsed) / uint256(p.endsAt - p.startsAt);
            }
        }
        return 0;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SETTLEMENT — computed here, paid by DistributionAgent
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Binds a period to the `DistributionAgent` distribution that will carry its cash.
    /// @dev    ⚠️ THE RATE IS CHECKED AGAINST THE DECLARED DISTRIBUTION, NOT ASSUMED. The agent
    ///         declares the distribution — it has to, because the record block must be fixed
    ///         before the snapshot — so nothing stops it declaring the wrong rate. This is the
    ///         one place the two numbers can be compared, and comparing them is the only
    ///         reason this function exists rather than the two contracts simply ignoring each
    ///         other.
    function bindPeriod(uint256 index, uint256 distributionId) external onlyAgent {
        Period storage p = _requirePeriod(index);
        if (p.state != PeriodState.Scheduled) revert WrongPeriodState(index, PeriodState.Scheduled, p.state);
        if (block.timestamp < p.endsAt) revert PeriodNotEnded(index, p.endsAt);

        uint256 expected = couponPerUnit(index);
        DistributionAgent.Distribution memory d = distributions.distribution(distributionId);
        if (d.ratePerUnit != expected) revert DistributionRateMismatch(expected, d.ratePerUnit);

        p.state = PeriodState.Bound;
        p.distributionId = distributionId;

        emit PeriodBound(index, distributionId, expected);
    }

    function markSettled(uint256 index) external onlyAgent {
        Period storage p = _requirePeriod(index);
        if (p.state != PeriodState.Bound) revert WrongPeriodState(index, PeriodState.Bound, p.state);

        p.state = PeriodState.Settled;
        emit PeriodSettled(index, p.distributionId);
    }

    /// @notice Records a missed payment once the grace period has run.
    /// @dev    ⚠️ THE CONTRACT CANNOT CURE A DEFAULT AND DOES NOT PRETEND TO. Acceleration,
    ///         cross-default, trustee action and enforcement are all creatures of the terms and
    ///         of insolvency law, none of which live on this ledger. What it does is make the
    ///         event unambiguous and timestamped, and require the MAR Art 17 announcement to be
    ///         anchored at the same moment — because the temptation at exactly this point is to
    ///         handle the default quietly and disclose later, which is the Art 17 breach that
    ///         reliably attracts a sanction.
    function declareDefault(uint256 index, bytes32 documentRef) external onlyAgent {
        Period storage p = _requirePeriod(index);
        if (p.state == PeriodState.Settled) revert WrongPeriodState(index, PeriodState.Bound, p.state);
        if (documentRef == bytes32(0)) revert DisclosureRefRequired();

        uint64 dueBy = p.endsAt + gracePeriod;
        if (block.timestamp <= dueBy) revert GracePeriodNotExpired(index, dueBy);

        p.state = PeriodState.Defaulted;
        emit PaymentDefaulted(index, dueBy, documentRef);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // REDEMPTION
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Marks the instrument redeemed at maturity, against the distribution carrying
    ///         principal (plus the final coupon, if the terms pay them together).
    /// @dev    ⚠️ DOES NOT BURN. Cancelling the units is `SecurityToken.burn`, called
    ///         separately by an agent AFTER the redemption distribution has actually been paid
    ///         out. Burning here would destroy the holdings that the snapshot for that very
    ///         distribution is about to be read against — the holder would lose the units and
    ///         the money in one transaction.
    /// @dev    Requires every earlier period settled or defaulted. A redemption recorded over
    ///         an unresolved coupon period silently writes off a debt that is still owed.
    function recordRedemption(uint256 distributionId) external onlyAgent {
        if (redeemed) revert AlreadyRedeemed();
        if (block.timestamp < maturityDate) revert NotAtMaturity(maturityDate);

        for (uint256 i = 0; i < _periods.length; i++) {
            PeriodState s = _periods[i].state;
            if (s != PeriodState.Settled && s != PeriodState.Defaulted) revert UnsettledPeriodsRemain(i);
        }

        redeemed = true;
        emit Redeemed(distributionId, principalPerUnit, uint64(block.timestamp));
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS
    // ═══════════════════════════════════════════════════════════════════════

    function _requirePeriod(uint256 index) private view returns (Period storage p) {
        if (index >= _periods.length) revert UnknownPeriod(index);
        p = _periods[index];
    }

    function periodCount() external view returns (uint256) {
        return _periods.length;
    }

    function periodAt(uint256 index) external view returns (Period memory) {
        return _periods[index];
    }

    /// @notice Total coupon still owed on one unit across every unsettled period. The
    ///         issuer-side liability view, and the number a funding desk needs before it can
    ///         say the programme is covered.
    function outstandingCouponPerUnit() external view returns (uint256 total) {
        for (uint256 i = 0; i < _periods.length; i++) {
            if (_periods[i].state == PeriodState.Settled) continue;
            total += couponPerUnit(i);
        }
    }

    /// @notice Periods past their grace period with no settlement recorded. ⚠️ A non-empty
    ///         result is an undeclared default — the state this contract can detect and the
    ///         issuer has not yet admitted.
    function overduePeriods() external view returns (uint256[] memory overdue) {
        uint256 n = _periods.length;
        uint256[] memory buf = new uint256[](n);
        uint256 count;

        for (uint256 i = 0; i < n; i++) {
            Period storage p = _periods[i];
            if (p.state == PeriodState.Settled || p.state == PeriodState.Defaulted) continue;
            if (block.timestamp > p.endsAt + gracePeriod) {
                buf[count] = i;
                count++;
            }
        }

        overdue = new uint256[](count);
        for (uint256 i = 0; i < count; i++) {
            overdue[i] = buf[i];
        }
    }
}
