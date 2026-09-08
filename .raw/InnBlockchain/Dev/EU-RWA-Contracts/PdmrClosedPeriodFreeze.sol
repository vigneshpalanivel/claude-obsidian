// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IPdmrRegister} from "./PdmrRegister.sol";
import {ModuleAdapter} from "./ModularCompliance.sol";

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
/// @dev    ⚠️ A WINDOW THAT HAS OPENED CANNOT BE CANCELLED, ONLY RESCHEDULED OR ANNOUNCED.
///         Until 2026-09-08 `cancelPeriod` lifted a LIVE window with no evidence, and no
///         reschedule existed — so the ordinary "report slips a week" case required exactly
///         that call, and the log could not tell a slipped calendar from a director who
///         wanted to trade on Thursday. Now: `cancelPeriod` works only BEFORE `opensAt`;
///         `reschedulePeriod` moves the scheduled announcement LATER, against a mandatory
///         evidence hash, and a window that has started stays started — `opensAt` is fixed at
///         scheduling and a reschedule of a live window moves only its far end. The one way
///         out of a live window is `recordAnnouncement`, i.e. publishing the report.
/// @dev    ⚠️ THE FREEZE IS PROSPECTIVE ONLY. Scheduling a period whose window has already
///         opened does not — and cannot — reverse transfers that already settled inside it.
///         Publishing the financial calendar at least 30 days ahead is therefore a control,
///         not an administrative preference, and any window opened retroactively leaves a
///         gap that has to be reviewed off-chain against the Art 8 prohibitions.
/// @dev    ⚠️ TWO ROLES, BY DESIGN. `issuer` runs the calendar — it is the company secretary's
///         job to know when results land. `governance` grants the Art 19(12) override,
///         because an override is the issuer excusing its own director from a rule written
///         against that director, and the party that benefits should not hold the key alone
///         (design §6, S3 §3). Until 2026-09-08 both were `onlyIssuer`.
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
        /// @dev Fixed at scheduling as `scheduledAnnouncement − 30d`, and moved by a
        ///      reschedule ONLY while it is still in the future. Once the window has opened
        ///      this never moves again, whatever happens to the far end.
        uint64 opensAt;
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

    /// @dev Settable, never null. ⚠️ Typed as `IPdmrRegister` from `PdmrRegister.sol`, not as
    ///      `Interfaces.sol`'s `IDeclaredPersonRegister`, because that interface declares
    ///      `isDeclared`/`personOf` and this contract needs `isFlagged` — a live-role read,
    ///      which "was ever declared" is not. Switching requires `IDeclaredPersonRegister` to
    ///      grow `isFlagged` (an `Interfaces.sol` change, recorded, not made here).
    IPdmrRegister public register;

    /// @notice Sets the calendar. See the two-roles note.
    address public issuer;
    /// @notice Grants and revokes Art 19(12) permissions; re-points `register`. Two-step
    ///         transfer, so a typo cannot orphan the override path mid-window.
    address public governance;
    address public pendingGovernance;

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
    /// @dev `evidenceRef` is the hash of the issuer's record of WHY the calendar moved — a
    ///      board minute, an auditor's letter. It is what lets a later investigation
    ///      distinguish a slipped audit from a window moved to let somebody trade.
    event PeriodRescheduled(
        uint256 indexed periodId,
        uint64 oldScheduledAnnouncement,
        uint64 newScheduledAnnouncement,
        bytes32 evidenceRef
    );
    event PeriodOverran(
        uint256 indexed periodId,
        uint64 scheduledAnnouncement,
        uint64 observedAt
    );

    /// @dev ⚠️ NO `Ground` IN THE LOG. Art 19(12)(a) is "exceptional circumstances, such as
    ///      severe financial difficulty" — against a wallet whose PDMR status is a matter of
    ///      public record, that is a named director's financial distress in a permanent
    ///      public log. The ground lives in `permission[periodId][wallet]`, where the issuer
    ///      reads it and `delete` reaches it; `evidenceHash` is the opaque join to the
    ///      Del. Reg 2016/522 Art 7–9 file. That the wallet *was granted* permission is a
    ///      ledger fact — the permitted trade is visible either way.
    event PermissionGranted(uint256 indexed periodId, address indexed wallet, uint64 expiresAt, bytes32 evidenceHash);
    event PermissionRevoked(uint256 indexed periodId, address indexed wallet);

    event DependencySet(bytes32 indexed what, address impl);
    event GovernanceTransferStarted(address indexed from, address indexed to);
    event GovernanceTransferred(address indexed from, address indexed to);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotIssuer();
    error NotGovernance();
    error NotPendingGovernance();
    error ZeroAddress();
    error ScheduleInThePast(uint64 scheduledAnnouncement);
    error UnknownPeriod(uint256 periodId);
    error PeriodNotOpen(uint256 periodId);
    /// @dev The window has opened; it can be rescheduled or announced, not cancelled.
    error PeriodAlreadyOpen(uint256 periodId, uint64 opensAt);
    /// @dev A reschedule moves the announcement later, never earlier.
    error RescheduleMustBeLater(uint64 current, uint64 requested);
    error EvidenceRequired();
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

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address register_, address issuer_, address governance_) {
        if (register_ == address(0) || issuer_ == address(0) || governance_ == address(0)) revert ZeroAddress();
        register = IPdmrRegister(register_);
        issuer = issuer_;
        governance = governance_;
        emit DependencySet("register", register_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ROLES & WIRING
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Re-point the declared-person register. Swap, never unset — a null register reads
    ///         every wallet as unflagged, which is the freeze silently off.
    function setRegister(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        register = IPdmrRegister(impl);
        emit DependencySet("register", impl);
    }

    function transferGovernance(address to) external onlyGovernance {
        if (to == address(0)) revert ZeroAddress();
        pendingGovernance = to;
        emit GovernanceTransferStarted(governance, to);
    }

    function acceptGovernance() external {
        if (msg.sender != pendingGovernance) revert NotPendingGovernance();
        emit GovernanceTransferred(governance, msg.sender);
        governance = msg.sender;
        pendingGovernance = address(0);
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
        uint64 opensAt = scheduledAnnouncement - CLOSED_PERIOD;
        periods[periodId] = ClosedPeriod({
            scheduledAnnouncement: scheduledAnnouncement,
            opensAt: opensAt,
            actualAnnouncement: 0,
            cancelled: false,
            reportRef: reportRef
        });
        _openPeriods.push(periodId);

        emit PeriodScheduled(periodId, scheduledAnnouncement, opensAt, reportRef);
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
    /// @dev    ⚠️ ONLY BEFORE THE WINDOW OPENS. Once flagged wallets are frozen, the report
    ///         is either published (`recordAnnouncement`) or delayed (`reschedulePeriod`,
    ///         with evidence). A cancellation that unfreezes directors mid-window has no
    ///         honest reading.
    function cancelPeriod(uint256 periodId) external onlyIssuer {
        ClosedPeriod storage p = _requirePeriod(periodId);
        if (p.cancelled || p.actualAnnouncement != 0)
            revert PeriodNotOpen(periodId);
        if (block.timestamp >= p.opensAt) revert PeriodAlreadyOpen(periodId, p.opensAt);

        p.cancelled = true;
        _closeOpenPeriod(periodId);
        emit PeriodCancelled(periodId);
    }

    /// @notice The report slipped. Moves the scheduled announcement LATER, against evidence.
    /// @dev    Allowed while the window is live. A live window keeps its `opensAt` — directors
    ///         who are frozen stay frozen; only the far end moves. A window that has not yet
    ///         opened has its `opensAt` recomputed from the new date, so it opens 30 days
    ///         before the report it now protects. Earlier is refused: pulling a report forward
    ///         shortens a window that was published, and the way to end a window early is to
    ///         publish the report.
    function reschedulePeriod(
        uint256 periodId,
        uint64 newScheduledAnnouncement,
        bytes32 evidenceRef
    ) external onlyIssuer {
        if (evidenceRef == bytes32(0)) revert EvidenceRequired();
        ClosedPeriod storage p = _requirePeriod(periodId);
        if (p.cancelled || p.actualAnnouncement != 0)
            revert PeriodNotOpen(periodId);
        if (newScheduledAnnouncement <= p.scheduledAnnouncement) {
            revert RescheduleMustBeLater(p.scheduledAnnouncement, newScheduledAnnouncement);
        }

        uint64 old = p.scheduledAnnouncement;
        p.scheduledAnnouncement = newScheduledAnnouncement;
        if (block.timestamp < p.opensAt) {
            p.opensAt = newScheduledAnnouncement - CLOSED_PERIOD;
        }

        emit PeriodRescheduled(periodId, old, newScheduledAnnouncement, evidenceRef);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 19(12) PERMISSION — the override path. Governance-gated.
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
    ) external onlyGovernance {
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

        emit PermissionGranted(periodId, wallet, expiresAt, evidenceHash);
    }

    function revokePermission(
        uint256 periodId,
        address wallet
    ) external onlyGovernance {
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
            p.opensAt,
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
        if (block.timestamp < p.opensAt) return false;
        // The overrun case: scheduled date gone, nothing announced, freeze restrictions.
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

/// @title PdmrClosedPeriodGate
/// @notice The `IComplianceModule` face of `PdmrClosedPeriodFreeze`, so `ModularCompliance`
///         can register it. Without this the Art 19(11) freeze is unreachable from the C1
///         hook — and a closed-period freeze that only fires when a transfer agent
///         remembers to call it is the breach it exists to prevent, reported as a clean
///         transfer.
/// @dev    Passes BOTH sides through unchanged. The freeze itself already skips the
///         `address(0)` leg of a mint or burn and already applies the Art 19(12) per-wallet,
///         per-window override, so this adapter deliberately adds no logic of its own —
///         anything it decided here would be a second place to look for Art 19(11).
/// @dev    ⚠️ `freeze` IS `immutable` AND CONCRETE ON PURPOSE — the sanctioned exception to
///         the standing rule (design §3 rev 40; `CovenantGate` and `HoldingPeriodGate` are
///         the same shape). An adapter is a one-line shim over ONE module; it has no
///         behaviour of its own to preserve across a re-point, and the settable reference
///         lives one level up, in `ModularCompliance`'s module list — swap the adapter, not
///         the pointer inside it. Making this settable would create a second place the
///         freeze can be re-pointed from, with a second key.
contract PdmrClosedPeriodGate is ModuleAdapter {
    PdmrClosedPeriodFreeze public immutable freeze;

    error ZeroAddress();

    constructor(bytes32 moduleId_, address freeze_) ModuleAdapter(moduleId_) {
        if (freeze_ == address(0)) revert ZeroAddress();
        freeze = PdmrClosedPeriodFreeze(freeze_);
    }

    function checkTransfer(address from, address to, uint256) external view override {
        freeze.checkTransfer(from, to);
    }
}
