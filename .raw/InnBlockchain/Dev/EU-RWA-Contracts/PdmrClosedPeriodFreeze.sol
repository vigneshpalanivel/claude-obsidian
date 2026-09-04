// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IPdmrRegister} from "./PdmrRegister.sol";

/// @title PdmrClosedPeriodFreeze (illustrative sample — not production code)
/// @notice MAR Art 19(11): a manager may not deal in the issuer's instruments during the
///         30 calendar days before an interim or year-end financial report is announced.
///         This gate blocks those transfers, and Art 19(12) permits them back through a
///         narrow, logged exception.
/// @dev    A compliance gate, not a token — it never moves a balance. Wire it in behind
///         `ModuleAdapter` (see `ModularCompliance.sol`); the bespoke signature stays as it
///         is so the Article→function audit map keeps resolving.
/// @dev    ⚠️ CHECK BOTH SIDES OF THE TRANSFER. Art 19(11) prohibits the manager from
///         "conducting any transactions" — acquisitions as much as disposals. A gate that
///         only inspects `from` lets a director BUY through the window on the strength of
///         the results they are about to announce, which is the abuse the article exists to
///         stop, arriving from the other direction.
/// @dev    ⚠️ THE WINDOW ENDS AT ANNOUNCEMENT, NOT AT THE SCHEDULED DATE. The naive form of
///         this contract is `block.timestamp <= reportDate`, and it fails on the ordinary
///         case of results slipping by a week: the scheduled date passes, the freeze lifts
///         itself, and every flagged wallet is free to trade during precisely the days when
///         the unpublished numbers are most certainly inside information. So the window is
///         [scheduled − 30d, ACTUAL announcement], and an unannounced period stays frozen
///         past its scheduled date indefinitely. Late results extend the freeze; they do not
///         end it.
/// @dev    ⚠️ THE FREEZE IS PROSPECTIVE ONLY. Scheduling a period whose window has already
///         opened does not — and cannot — reverse transfers that already settled inside it.
///         Publishing the financial calendar at least 30 days ahead is therefore a control,
///         not an administrative preference, and any window opened retroactively leaves a
///         gap that has to be reviewed off-chain against the Art 8 prohibitions.
contract PdmrClosedPeriodFreeze {
    /// @dev Art 19(11) says 30 CALENDAR days. Not trading days, not a month.
    uint64 public constant CLOSED_PERIOD = 30 days;

    /// @dev Art 19(12) admits exactly two grounds and no others. Modelled as an enum rather
    ///      than a free-text reason so that an override cannot be granted without naming the
    ///      limb it relies on — `None` is not a grantable value.
    enum Ground {
        None,
        /// (a) exceptional circumstances — e.g. severe financial difficulty compelling an
        /// immediate sale. Criteria in Del. Reg 2016/522 Art 8.
        ExceptionalCircumstances,
        /// (b) characteristics of the trading — employee share schemes, or transactions where
        /// the beneficial interest in the security does not change. Del. Reg 2016/522 Art 9.
        TradingCharacteristics
    }

    struct ClosedPeriod {
        uint64 scheduledAnnouncement;
        uint64 actualAnnouncement; // 0 until announced — window stays OPEN past the schedule
        bool cancelled;
        bytes32 reportRef; // which report this window protects — audit trail
    }

    struct Permission {
        Ground ground; // Ground.None == not granted
        uint64 grantedAt;
        uint64 expiresAt;
        bytes32 evidenceHash; // the issuer's written reasoning, anchored off-chain
    }

    // ─────────────────────────── wiring ───────────────────────────────────────

    IPdmrRegister public immutable register;
    address public immutable issuer; // sets the calendar and grants Art 19(12) permissions

    // ─────────────────────────── calendar ─────────────────────────────────────

    mapping(uint256 => ClosedPeriod) public periods;
    uint256 public periodCount;

    /// @dev Only periods that could still be open. Bounded by how many reports an issuer has
    ///      in flight at once — realistically one, occasionally two around a year-end — so
    ///      the loop in `_activePeriod` is bounded by the business, not by history.
    uint256[] private _openPeriods;

    // ─────────────────────────── Art 19(12) permissions ───────────────────────

    mapping(uint256 => mapping(address => Permission)) public permission;

    // ─────────────────────────── events ───────────────────────────────────────

    event PeriodScheduled(
        uint256 indexed periodId,
        uint64 scheduledAnnouncement,
        uint64 opensAt,
        bytes32 reportRef
    );
    event PeriodAnnounced(uint256 indexed periodId, uint64 actualAnnouncement);
    event PeriodCancelled(uint256 indexed periodId);
    event PeriodOverran(
        uint256 indexed periodId,
        uint64 scheduledAnnouncement,
        uint64 observedAt
    );

    event PermissionGranted(
        uint256 indexed periodId,
        address indexed wallet,
        Ground ground,
        uint64 expiresAt,
        bytes32 evidenceHash
    );
    event PermissionRevoked(uint256 indexed periodId, address indexed wallet);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotIssuer();
    error ScheduleInThePast(uint64 scheduledAnnouncement);
    error UnknownPeriod(uint256 periodId);
    error PeriodNotOpen(uint256 periodId);
    error GroundRequired();
    error WalletNotFlagged(address wallet);
    error PermissionExpiryInThePast(uint64 expiresAt);

    /// @dev Carries the period id so the caller can point at which window blocked them —
    ///      a director told only "transfer failed" will call the company secretary, and the
    ///      company secretary needs to know which report it was.
    error InClosedPeriod(
        address wallet,
        uint256 periodId,
        uint64 opensAt,
        uint64 scheduledAnnouncement
    );

    modifier onlyIssuer() {
        if (msg.sender != issuer) revert NotIssuer();
        _;
    }

    constructor(address register_, address issuer_) {
        register = IPdmrRegister(register_);
        issuer = issuer_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // CALENDAR
    // ═══════════════════════════════════════════════════════════════════════

    function schedulePeriod(
        uint64 scheduledAnnouncement,
        bytes32 reportRef
    ) external onlyIssuer returns (uint256 periodId) {
        // Guards the subtraction below and rejects a window that is already over, which is
        // the only schedule that could never bind anybody.
        if (
            scheduledAnnouncement <= CLOSED_PERIOD ||
            scheduledAnnouncement <= block.timestamp
        ) {
            revert ScheduleInThePast(scheduledAnnouncement);
        }

        periodId = periodCount++;
        periods[periodId] = ClosedPeriod({
            scheduledAnnouncement: scheduledAnnouncement,
            actualAnnouncement: 0,
            cancelled: false,
            reportRef: reportRef
        });
        _openPeriods.push(periodId);

        emit PeriodScheduled(
            periodId,
            scheduledAnnouncement,
            scheduledAnnouncement - CLOSED_PERIOD,
            reportRef
        );
    }

    /// @notice Call this when the report is actually published. This — not the passage of the
    ///         scheduled date — is what lifts the freeze.
    function recordAnnouncement(uint256 periodId) external onlyIssuer {
        ClosedPeriod storage p = _requirePeriod(periodId);
        if (p.cancelled || p.actualAnnouncement != 0)
            revert PeriodNotOpen(periodId);

        p.actualAnnouncement = uint64(block.timestamp);
        _closeOpenPeriod(periodId);

        if (block.timestamp > p.scheduledAnnouncement) {
            emit PeriodOverran(
                periodId,
                p.scheduledAnnouncement,
                uint64(block.timestamp)
            );
        }
        emit PeriodAnnounced(periodId, p.actualAnnouncement);
    }

    /// @notice For a report that will not happen at all — a cancelled interim, a changed
    ///         reporting calendar. Distinct from `recordAnnouncement`, because a cancelled
    ///         window and a published report mean different things to a later investigation.
    function cancelPeriod(uint256 periodId) external onlyIssuer {
        ClosedPeriod storage p = _requirePeriod(periodId);
        if (p.cancelled || p.actualAnnouncement != 0)
            revert PeriodNotOpen(periodId);

        p.cancelled = true;
        _closeOpenPeriod(periodId);
        emit PeriodCancelled(periodId);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 19(12) PERMISSION — the override path.
    //
    // A freeze with no exception path is not "safe by default"; it is
    // non-compliant by over-blocking, and it reverts transactions MAR
    // expressly permits. The failure mode is bad: it surfaces mid-window,
    // when the fix cannot be a redeploy. Build the override on day one, make
    // it per-wallet and per-window, and log it — the log IS the evidence that
    // the issuer granted permission deliberately and on a stated ground.
    // ═══════════════════════════════════════════════════════════════════════

    function grantPermission(
        uint256 periodId,
        address wallet,
        Ground ground,
        uint64 expiresAt,
        bytes32 evidenceHash
    ) external onlyIssuer {
        if (ground == Ground.None) revert GroundRequired();
        if (expiresAt <= block.timestamp)
            revert PermissionExpiryInThePast(expiresAt);
        if (!register.isFlagged(wallet)) revert WalletNotFlagged(wallet);

        ClosedPeriod storage p = _requirePeriod(periodId);
        if (p.cancelled || p.actualAnnouncement != 0)
            revert PeriodNotOpen(periodId);

        permission[periodId][wallet] = Permission({
            ground: ground,
            grantedAt: uint64(block.timestamp),
            expiresAt: expiresAt,
            evidenceHash: evidenceHash
        });

        emit PermissionGranted(
            periodId,
            wallet,
            ground,
            expiresAt,
            evidenceHash
        );
    }

    function revokePermission(
        uint256 periodId,
        address wallet
    ) external onlyIssuer {
        delete permission[periodId][wallet];
        emit PermissionRevoked(periodId, wallet);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // GATE — call before any transfer. Both sides are inspected.
    // ═══════════════════════════════════════════════════════════════════════

    function checkTransfer(address from, address to) external view {
        _checkSide(from);
        _checkSide(to);
    }

    function _checkSide(address wallet) internal view {
        if (wallet == address(0)) return; // mint / burn leg
        if (!register.isFlagged(wallet)) return;

        (bool active, uint256 periodId) = _activePeriod();
        if (!active) return;

        Permission storage granted = permission[periodId][wallet];
        if (
            granted.ground != Ground.None && block.timestamp < granted.expiresAt
        ) return;

        ClosedPeriod storage p = periods[periodId];
        revert InClosedPeriod(
            wallet,
            periodId,
            p.scheduledAnnouncement - CLOSED_PERIOD,
            p.scheduledAnnouncement
        );
    }

    /// @notice Returns the first currently-active window, if any. Exposed so a UI can tell a
    ///         director why they are blocked before they spend gas finding out.
    function activePeriod()
        external
        view
        returns (bool active, uint256 periodId)
    {
        return _activePeriod();
    }

    function isFrozen(address wallet) external view returns (bool) {
        if (!register.isFlagged(wallet)) return false;
        (bool active, uint256 periodId) = _activePeriod();
        if (!active) return false;

        Permission storage granted = permission[periodId][wallet];
        return
            !(granted.ground != Ground.None &&
                block.timestamp < granted.expiresAt);
    }

    function _activePeriod() internal view returns (bool, uint256) {
        uint256 n = _openPeriods.length;
        for (uint256 i = 0; i < n; ++i) {
            uint256 id = _openPeriods[i];
            if (_windowActive(periods[id])) return (true, id);
        }
        return (false, 0);
    }

    function _windowActive(
        ClosedPeriod storage p
    ) internal view returns (bool) {
        if (p.cancelled) return false;
        if (block.timestamp < p.scheduledAnnouncement - CLOSED_PERIOD)
            return false;
        // The overrun case: scheduled date gone, nothing announced, freeze holds.
        if (
            p.actualAnnouncement != 0 && block.timestamp >= p.actualAnnouncement
        ) return false;
        return true;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // INTERNALS
    // ═══════════════════════════════════════════════════════════════════════

    function _requirePeriod(
        uint256 periodId
    ) internal view returns (ClosedPeriod storage) {
        if (periodId >= periodCount) revert UnknownPeriod(periodId);
        return periods[periodId];
    }

    function _closeOpenPeriod(uint256 periodId) internal {
        uint256 n = _openPeriods.length;
        for (uint256 i = 0; i < n; ++i) {
            if (_openPeriods[i] == periodId) {
                _openPeriods[i] = _openPeriods[n - 1];
                _openPeriods.pop();
                return;
            }
        }
    }

    function openPeriods() external view returns (uint256[] memory) {
        return _openPeriods;
    }
}
