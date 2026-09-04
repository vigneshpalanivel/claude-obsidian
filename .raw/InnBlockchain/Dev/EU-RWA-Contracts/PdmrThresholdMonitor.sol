// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IPdmrRegister} from "./PdmrRegister.sol";

/// @notice Euro valuation of one token unit. Same feed the fund and cap-register modules
///         consume — see the blast-radius note on the contract below.
interface IValuationFeed {
    /// @return priceEurCents  Euro cents per whole token unit.
    /// @return updatedAt      When the feed last wrote — used for the staleness guard.
    function priceEurCents() external view returns (uint256 priceEurCents, uint64 updatedAt);
}

/// @title PdmrThresholdMonitor (illustrative sample — not production code)
/// @notice MAR Art 19(1)/(1a): once a manager's — or a closely associated person's —
///         transactions in the issuer's instruments reach €20,000 in a calendar year, every
///         transaction from that point must be notified within 3 business days, and Art 19(2)
///         requires the ISSUER to publish it within 3 business days OF THE TRANSACTION.
/// @dev    This is a `notifyTransfer`-shaped module, not a `checkTransfer` one. It observes
///         and raises, it never vetoes: a transaction over the threshold is perfectly legal —
///         it is the failure to notify that breaches MAR. Wiring this as a revert would block
///         lawful trading and still not file anything.
/// @dev    ⚠️ THE THRESHOLD IS PER PERSON, IN EURO, ACROSS EVERY WALLET THEY CONTROL —
///         and it does not net. Three consequences the obvious implementation gets wrong:
///         per-wallet counters undercount anyone holding two addresses; token-denominated
///         counters drift against a moving price; and subtracting sells from buys hides the
///         crossing entirely. Aggregate the ABSOLUTE euro value of each transaction, keyed on
///         `personId`, reset per calendar year.
/// @dev    ⚠️ THIS PUTS THE VALUATION FEED ON MAR'S CRITICAL PATH. §5 of the design doc
///         treats the feed as a fund and cap-register dependency; the Art 19(1a) threshold
///         extends its blast radius to §6. And the failure here is worse than a bad NAV,
///         because it FAILS OPEN AND SILENTLY: a stale or wrong price does not revert a
///         transfer, it mis-computes a threshold, and the visible result is a missing Art 19
///         filing discovered by the regulator rather than by you.
/// @dev    ⚠️ RESOLVING THE "FAIL CLOSED" / "ALERT, DO NOT BLOCK" TENSION IN §6. The design
///         doc says both, and they are reconcilable only by separating the two decisions this
///         contract makes. The TRANSFER is never blocked — alert, do not block. The REPORTING
///         determination fails closed: an unpriceable transaction is recorded as
///         indeterminate, the person-year is marked so the aggregate can never again be read
///         as authoritative, and the notification is raised as if the threshold had been
///         crossed. Over-notifying costs a filing. Under-notifying costs an Art 19 breach.
contract PdmrThresholdMonitor {
    // ─────────────────────────── thresholds ───────────────────────────────────

    /// @dev Art 19(1a) — the EU-wide floor. In euro cents.
    uint256 public constant THRESHOLD_BASE_EUR_CENTS = 20_000_00;

    /// @dev Art 19(9) — a MEMBER STATE may raise the floor to €50,000. Note it is a Member
    ///      State option exercised in national law, not an NCA-by-NCA discretion and not a
    ///      value the issuer picks: check whether your home Member State exercised it.
    uint256 public constant THRESHOLD_UPLIFT_EUR_CENTS = 50_000_00;

    /// @dev Art 19(1) allows 3 BUSINESS days; Art 19(2) gives the issuer 3 business days from
    ///      the TRANSACTION. On-chain there is no holiday calendar, so 3 calendar days is used
    ///      as a deliberately conservative floor — it can only ever fire the alert early.
    uint64 public constant NOTIFICATION_WINDOW = 3 days;

    uint256 public thresholdEurCents = THRESHOLD_BASE_EUR_CENTS;

    // ─────────────────────────── wiring ───────────────────────────────────────

    IPdmrRegister public immutable register;
    IValuationFeed public immutable valuation;
    address public immutable issuer;
    address public immutable reporter; // the token / compliance hook allowed to record trades

    // ─────────────────────────── feed guards ──────────────────────────────────

    uint64 public maxStalenessSeconds = 1 days;
    uint256 public maxDeviationBps = 2000; // 20% move between reads — a "look at this" signal
    uint256 public lastObservedPriceEurCents;

    // ─────────────────────────── aggregates ───────────────────────────────────

    /// @dev personId => calendar year => cumulative absolute euro cents.
    mapping(bytes32 => mapping(uint16 => uint256)) public annualAggregateEurCents;

    /// @dev personId => calendar year => an unpriceable transaction landed in this bucket, so
    ///      the aggregate below it is a floor, not a total. Never clears itself.
    mapping(bytes32 => mapping(uint16 => bool)) public aggregateIndeterminate;

    /// @dev personId => calendar year => threshold already crossed, so every subsequent
    ///      transaction is notifiable without re-testing.
    mapping(bytes32 => mapping(uint16 => bool)) public thresholdCrossed;

    // ─────────────────────────── events ───────────────────────────────────────

    event TransactionRecorded(
        bytes32 indexed personId,
        address indexed wallet,
        uint16 indexed year,
        uint256 valueEurCents,
        uint256 cumulativeEurCents
    );

    /// @dev Art 19(1) — the PDMR's/PCA's own filing obligation.
    event NotificationDue(bytes32 indexed personId, address indexed wallet, uint16 indexed year, uint64 dueBy);

    /// @dev Art 19(2) — the ISSUER's separate publication clock, and it runs from the
    ///      transaction, not from the notification landing. Fired on the trade for exactly
    ///      that reason: a director who files on day 3 otherwise consumes the issuer's whole
    ///      window before the issuer even learns a trade happened.
    event IssuerPublicationDue(bytes32 indexed personId, address indexed wallet, uint16 indexed year, uint64 dueBy);

    event ThresholdCrossed(bytes32 indexed personId, uint16 indexed year, uint256 cumulativeEurCents, uint256 threshold);

    /// @dev The loud one. A transaction that could not be priced has entered the aggregate.
    event ValuationUnavailable(bytes32 indexed personId, address indexed wallet, uint16 indexed year, uint64 updatedAt);
    event ValuationDeviation(uint256 previousEurCents, uint256 currentEurCents, uint256 deviationBps);

    event ThresholdSet(uint256 eurCents);
    event StalenessLimitSet(uint64 seconds_);
    event DeviationLimitSet(uint256 bps);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotIssuer();
    error NotReporter();
    error WalletNotFlagged(address wallet);
    /// @dev Art 19(1a)/19(9) offer two values and only two. An issuer that can set an
    ///      arbitrary threshold can set a threshold nobody ever crosses.
    error ThresholdNotAStatutoryValue(uint256 eurCents);

    modifier onlyIssuer() {
        if (msg.sender != issuer) revert NotIssuer();
        _;
    }

    modifier onlyReporter() {
        if (msg.sender != reporter) revert NotReporter();
        _;
    }

    constructor(address register_, address valuation_, address issuer_, address reporter_) {
        register = IPdmrRegister(register_);
        valuation = IValuationFeed(valuation_);
        issuer = issuer_;
        reporter = reporter_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CONFIGURATION
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Set at deployment from the per-jurisdiction parameter set — €20k, or €50k where
    ///         the home Member State exercised the Art 19(9) opt-up. A parameter, never a
    ///         constant: the same contract deployed in two Member States is two thresholds.
    function setThreshold(uint256 eurCents) external onlyIssuer {
        if (eurCents != THRESHOLD_BASE_EUR_CENTS && eurCents != THRESHOLD_UPLIFT_EUR_CENTS) {
            revert ThresholdNotAStatutoryValue(eurCents);
        }
        thresholdEurCents = eurCents;
        emit ThresholdSet(eurCents);
    }

    function setStalenessLimit(uint64 seconds_) external onlyIssuer {
        maxStalenessSeconds = seconds_;
        emit StalenessLimitSet(seconds_);
    }

    function setDeviationLimit(uint256 bps) external onlyIssuer {
        maxDeviationBps = bps;
        emit DeviationLimitSet(bps);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // RECORD — called on every settled transfer touching a flagged wallet.
    // Never reverts on a compliance condition; only on a wiring error.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param tokenAmount  Absolute unit count moved. Direction is deliberately not taken:
    ///                     Art 19(1a) aggregates transactions, it does not net buys against
    ///                     sells, and a netting counter is how a manager trades all year and
    ///                     never crosses.
    function recordTransaction(address wallet, uint256 tokenAmount) external onlyReporter {
        if (!register.isFlagged(wallet)) revert WalletNotFlagged(wallet);

        bytes32 personId = register.personOf(wallet);
        uint16 year = _calendarYear(uint64(block.timestamp));
        uint64 dueBy = uint64(block.timestamp) + NOTIFICATION_WINDOW;

        (uint256 valueEurCents, bool priced) = _valueOf(tokenAmount);

        if (!priced) {
            // Fail closed on the REPORTING decision — see the contract-level note.
            aggregateIndeterminate[personId][year] = true;
            emit ValuationUnavailable(personId, wallet, year, uint64(block.timestamp));
            emit NotificationDue(personId, wallet, year, dueBy);
            emit IssuerPublicationDue(personId, wallet, year, dueBy);
            emit TransactionRecorded(personId, wallet, year, 0, annualAggregateEurCents[personId][year]);
            return;
        }

        uint256 cumulative = annualAggregateEurCents[personId][year] + valueEurCents;
        annualAggregateEurCents[personId][year] = cumulative;
        emit TransactionRecorded(personId, wallet, year, valueEurCents, cumulative);

        bool alreadyCrossed = thresholdCrossed[personId][year];
        if (!alreadyCrossed && cumulative >= thresholdEurCents) {
            thresholdCrossed[personId][year] = true;
            emit ThresholdCrossed(personId, year, cumulative, thresholdEurCents);
            alreadyCrossed = true;
        }

        // Art 19(1a): the transaction that crosses the threshold is itself notifiable, and so
        // is every one after it in the same calendar year.
        if (alreadyCrossed) {
            emit NotificationDue(personId, wallet, year, dueBy);
            emit IssuerPublicationDue(personId, wallet, year, dueBy);
        }
    }

    /// @dev Reads the feed through the staleness and deviation guards. `priced == false` means
    ///      the caller must treat the transaction as unmeasured — it does NOT mean zero.
    function _valueOf(uint256 tokenAmount) internal returns (uint256, bool) {
        (uint256 price, uint64 updatedAt) = valuation.priceEurCents();

        if (price == 0 || updatedAt == 0) return (0, false);
        if (block.timestamp > updatedAt + maxStalenessSeconds) return (0, false);

        uint256 previous = lastObservedPriceEurCents;
        if (previous != 0) {
            uint256 delta = price > previous ? price - previous : previous - price;
            uint256 deviationBps = (delta * 10000) / previous;
            if (deviationBps > maxDeviationBps) {
                // An alert, not a rejection. A genuine 25% move is a market event, not a feed
                // fault, and refusing to price it would silently drop a real transaction out
                // of the aggregate — the exact failure this module exists to prevent.
                emit ValuationDeviation(previous, price, deviationBps);
            }
        }
        lastObservedPriceEurCents = price;

        return (tokenAmount * price, true);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READ SURFACE
    // ═══════════════════════════════════════════════════════════════════════

    /// @return cumulativeEurCents  The aggregate so far this calendar year.
    /// @return crossed             Whether every further transaction is notifiable.
    /// @return indeterminate       Whether an unpriceable transaction means the aggregate is
    ///                             a floor rather than a total. If true, `cumulativeEurCents`
    ///                             must not be relied on to decide that nothing is notifiable.
    function statusOf(address wallet)
        external
        view
        returns (uint256 cumulativeEurCents, bool crossed, bool indeterminate)
    {
        bytes32 personId = register.personOf(wallet);
        uint16 year = _calendarYear(uint64(block.timestamp));
        return (
            annualAggregateEurCents[personId][year],
            thresholdCrossed[personId][year],
            aggregateIndeterminate[personId][year]
        );
    }

    function currentYear() external view returns (uint16) {
        return _calendarYear(uint64(block.timestamp));
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CALENDAR
    //
    // Art 19(1a) says "within a calendar year" — 1 January to 31 December, not
    // a rolling 365 days and not the issuer's financial year. A rolling window
    // is the easy mistake and it produces a different, wrong answer every
    // January. Civil-from-days conversion (Howard Hinnant's algorithm), valid
    // for any timestamp at or after the Unix epoch.
    // ═══════════════════════════════════════════════════════════════════════

    function _calendarYear(uint64 ts) internal pure returns (uint16) {
        uint256 z = uint256(ts) / 86400 + 719468;
        uint256 era = z / 146097;
        uint256 doe = z - era * 146097;
        uint256 yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
        uint256 y = yoe + era * 400;
        uint256 doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
        uint256 mp = (5 * doy + 2) / 153;
        uint256 m = mp < 10 ? mp + 3 : mp - 9;
        if (m <= 2) y += 1;
        return uint16(y);
    }
}
