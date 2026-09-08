// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IProtocolPause} from "./Interfaces.sol";

/// @title DoraGovernor (illustrative sample — not production code)
/// @notice The operational-resilience contract every lane deploys: a PROTOCOL PAUSE, the
///         oracle-driven trip into it, a structured incident log and a key-rotation register.
///         DORA (Reg 2022/2554) is the regime this answers to for a licensed entity; an
///         unlicensed pure issuer is arguably outside DORA and still needs it, because a
///         pause and structured logging are prerequisites for the security audit and the
///         prospectus disclosure either way — and retrofitting them after issuance is a
///         re-issuance.
/// @dev    ⚠️ THIS CONTRACT IS NOT ON THE UPGRADE PATH, AND THAT IS THE 2026-09-08 SWEEP. It
///         used to carry its own timelock, an upgrade queue, a commit-reveal, an arbitrary
///         `target.call` executor, and a `queueUpgrade` gated on a disclosure artefact being
///         anchored and approved in `DocumentRegistry` — all of it asserting that a contract
///         change had to be "approved BEFORE deployment". That inverted the statute: the
///         competent authority approves a SUPPLEMENT, never a deployment, and Art 23 is a
///         disclosure duty, not an authorisation regime (design rev 49). The whole limb is
///         gone. The upgrade path is stock Gnosis Safe → OpenZeppelin `TimelockController` →
///         `ProxyAdmin` → `TransparentUpgradeableProxy`, with the disclosure document's hash
///         carried as the timelock `salt` and reconciled off-chain — `UPGRADE-ARCHITECTURE.md`
///         is the whole of it. No custom code sits on that path, this contract included.
/// @dev    ⚠️ WHAT `paused()` STOPS, AND WHAT IT DELIBERATELY DOES NOT. Implements
///         `IProtocolPause`. Readers, all on VOLUNTARY or ACQUISITION paths only:
///           • `SecurityToken` — the holder-initiated transfer paths (`transfer`,
///             `transferFrom`) and mint;
///           • the four fund modules (`NavBorrowingCap`, `UcitsFiveTenForty`,
///             `EltifConcentration`, `LmtGate`) — their acquisition / draw paths.
///         Those are being wired by the token and fund agents as of the same date. Deliberate
///         NON-readers: `forcedTransfer`, `recoverWallet`, repayments, disposals, redemption
///         processing already in flight, the incident log below, and `pause()` itself. A pause
///         is an incident response; it must not be able to block a court order, trap a fund in
///         a leverage breach it is trying to cure, or silence the log that reports the incident.
///         Before this date NOTHING read the flag, so `ValuationOracle`'s deviation halt
///         "auto-tripped" a pause that halted nothing — an event wearing the costume of a
///         control.
/// @dev    ⚠️ `tripFromOracle` IS THE ONE PRIVILEGED ENTRY POINT GOVERNANCE DOES NOT HOLD, and
///         it can only pause. A compromised oracle's blast radius is a denial of service that
///         governance lifts with `unpause()`, never a loss of control — there is nothing else
///         here for it to reach.
/// @dev    DLT Pilot Art 7(5) asks for records of the MEANS OF ACCESS to client assets. The
///         key-rotation register is that record for the operator's own signing
///         infrastructure: a hash of the signer set and threshold, with a rotation history.
///         Nothing here is a key or reveals one.
contract DoraGovernor is IProtocolPause {
    // ─────────────────────────── roles ────────────────────────────────────────

    /// @notice The Safe. Rotatable in two steps — a governance key this contract cannot move
    ///         off is the operational-resilience failure the contract exists to log.
    address public governance;
    address public pendingGovernance;

    // ─────────────────────────── pause ────────────────────────────────────────

    /// @inheritdoc IProtocolPause
    bool public override paused;
    uint64 public pausedAt;

    /// @notice The `ValuationOracle` allowed to call `tripFromOracle`. address(0) disables
    ///         automatic tripping and leaves the deviation halt as an event-only signal.
    address public oracleTripSource;

    // ─────────────────────────── key rotation register ────────────────────────

    struct KeySetRecord {
        bytes32 signerSetHash;
        uint16 threshold;
        uint64 rotatedAt;
        bytes32 reasonCode; // "SCHEDULED" / "COMPROMISE" / "PERSONNEL" / "CUSTODIAN_CHANGE"
    }

    KeySetRecord[] private _keyHistory;

    // ─────────────────────────── events ───────────────────────────────────────

    event GovernanceTransferProposed(address indexed current, address indexed proposed);
    event GovernanceTransferred(address indexed previous, address indexed next);

    event Paused(bytes32 reasonHash, uint64 at);
    event Unpaused(uint64 at);
    event OracleTripSourceSet(address indexed previous, address indexed next);
    /// @dev Emitted on every trip, including ones that found the system already paused —
    ///      the second halted feed is information even when it changes no state.
    event OracleTripReceived(bytes32 indexed assetId, address indexed oracle, uint64 at);

    event KeySetRotated(bytes32 signerSetHash, uint16 threshold, bytes32 reasonCode, uint64 at);

    /// @dev DORA Arts 17–19 major-ICT-incident classification and reporting. The event is
    ///      structured rather than free-text because the initial / intermediate / final
    ///      report cycle is a fixed sequence with deadlines, and a reporting job that has to
    ///      parse prose to find the incident class will miss one.
    event IctIncident(
        bytes32 indexed incidentId,
        bytes32 indexed classification, // "MAJOR" / "SIGNIFICANT" / "MINOR"
        bytes32 indexed reportStage, // "INITIAL" / "INTERMEDIATE" / "FINAL"
        bytes32 impactCode,
        bytes32 evidenceHash,
        uint64 at
    );

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotPendingGovernance();
    error ZeroAddress();
    error NotPaused();
    error NotOracleTripSource();
    error NoKeySetRecorded();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_) {
        if (governance_ == address(0)) revert ZeroAddress();
        governance = governance_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // GOVERNANCE ROTATION — two-step, same pattern as `ValuationOracle`
    // ═══════════════════════════════════════════════════════════════════════

    function transferGovernance(address next) external onlyGovernance {
        if (next == address(0)) revert ZeroAddress();
        pendingGovernance = next;
        emit GovernanceTransferProposed(governance, next);
    }

    function acceptGovernance() external {
        if (msg.sender != pendingGovernance) revert NotPendingGovernance();
        address previous = governance;
        governance = msg.sender;
        pendingGovernance = address(0);
        emit GovernanceTransferred(previous, msg.sender);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PAUSE — note it does NOT gate `pause()` itself or the incident log.
    // A pause path that can be paused, or an incident log that goes quiet
    // during an incident, is the wrong way round.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param reasonHash Hash of the incident reference, never the reason in the clear — the
    ///                   pause is public the moment it lands; the cause may be under an Art 17
    ///                   MAR delay or an AMLR tipping-off constraint.
    function pause(bytes32 reasonHash) external onlyGovernance {
        paused = true;
        pausedAt = uint64(block.timestamp);
        emit Paused(reasonHash, pausedAt);
    }

    /// @notice `ICircuitBreaker` — the automatic trip `ValuationOracle` calls when its
    ///         deviation guard halts a feed. This is §9's "auto-trip on oracle-anomaly", and
    ///         it is a CALL rather than an event on purpose: DORA Art 19's reporting clock
    ///         runs from **detection**, so a control that waits for an operator to read an
    ///         event has already spent the budget it exists to protect.
    /// @dev    ⚠️ Restricted to the registered oracle, not to governance — an automatic trip
    ///         nobody can invoke automatically is not automatic. It can ONLY pause: it cannot
    ///         unpause, rotate governance or a key, or record an incident.
    /// @dev    Idempotent. The oracle calls this inside a try/catch and treats a revert as a
    ///         failed escalation worth paging on, so reverting merely because we are already
    ///         paused would raise a false alarm on the second halted feed.
    /// @dev    ⚠️ SIGNATURE IS LOAD-BEARING: `function tripFromOracle(bytes32) external` with
    ///         no return value is what `ValuationOracle.ICircuitBreaker` declares. Do not add a
    ///         return type without changing both sides.
    function tripFromOracle(bytes32 assetId) external {
        if (msg.sender != oracleTripSource) revert NotOracleTripSource();
        emit OracleTripReceived(assetId, msg.sender, uint64(block.timestamp));
        if (paused) return;
        paused = true;
        pausedAt = uint64(block.timestamp);
        emit Paused(keccak256(abi.encodePacked("ORACLE_DEVIATION_HALT", assetId)), pausedAt);
    }

    /// @notice Register the `ValuationOracle` permitted to trip the breaker. Set to
    ///         address(0) to disable automatic tripping.
    function setOracleTripSource(address source) external onlyGovernance {
        emit OracleTripSourceSet(oracleTripSource, source);
        oracleTripSource = source;
    }

    function unpause() external onlyGovernance {
        if (!paused) revert NotPaused();
        paused = false;
        emit Unpaused(uint64(block.timestamp));
    }

    // ═══════════════════════════════════════════════════════════════════════
    // KEY ROTATION REGISTER
    // ═══════════════════════════════════════════════════════════════════════

    function recordKeyRotation(bytes32 signerSetHash, uint16 threshold, bytes32 reasonCode) external onlyGovernance {
        _keyHistory.push(
            KeySetRecord({
                signerSetHash: signerSetHash,
                threshold: threshold,
                rotatedAt: uint64(block.timestamp),
                reasonCode: reasonCode
            })
        );
        emit KeySetRotated(signerSetHash, threshold, reasonCode, uint64(block.timestamp));
    }

    function keyHistory() external view returns (KeySetRecord[] memory) {
        return _keyHistory;
    }

    /// @dev Typed revert rather than an index-underflow panic on an empty register: a reviewer
    ///      asking "what is the current signer set" before the first rotation is recorded
    ///      should be told there is none, not handed 0x11.
    function currentKeySet() external view returns (KeySetRecord memory) {
        uint256 len = _keyHistory.length;
        if (len == 0) revert NoKeySetRecorded();
        return _keyHistory[len - 1];
    }

    // ═══════════════════════════════════════════════════════════════════════
    // DORA INCIDENT LOG — deliberately callable while paused
    // ═══════════════════════════════════════════════════════════════════════

    function recordIncident(
        bytes32 incidentId,
        bytes32 classification,
        bytes32 reportStage,
        bytes32 impactCode,
        bytes32 evidenceHash
    ) external onlyGovernance {
        emit IctIncident(incidentId, classification, reportStage, impactCode, evidenceHash, uint64(block.timestamp));
    }
}
