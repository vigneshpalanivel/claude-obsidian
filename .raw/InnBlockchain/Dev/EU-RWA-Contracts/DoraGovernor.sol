// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

interface IDocumentRegistry {
    /// @return exists  Whether a document with this hash is anchored.
    /// @return approvedAt Timestamp the anchoring party recorded NCA approval; 0 if none.
    function documentStatus(bytes32 documentHash) external view returns (bool exists, uint64 approvedAt);
}

/// @title DoraGovernor (illustrative sample — not production code)
/// @notice The cross-cutting governance wrapper every lane deploys: proxy-admin authority
///         behind a timelock, a pause path, a key-rotation register, and structured incident
///         events. DORA (Reg 2022/2554) is the regime this answers to for a licensed entity;
///         an unlicensed pure issuer is arguably outside DORA and still needs this wrapper,
///         because upgrade governance, a pause, and structured logging are prerequisites for
///         the security audit and the prospectus disclosure either way — and retrofitting
///         them after issuance is a re-issuance.
/// @dev    ⚠️ AN UPGRADE IS A CHANGE TO THE SECURITY, NOT A DEPLOYMENT. Where a prospectus is
///         in force, changing contract behaviour is a material change requiring an Art 23
///         supplement, filed and approved BEFORE deployment. `queueUpgrade` therefore refuses
///         to queue anything without a disclosure artefact already anchored and approved in
///         the `DocumentRegistry`. Wiring it the other way round — deploy, then disclose —
///         inverts the statutory order, and no amount of timelock fixes it.
/// @dev    ⚠️ THE NCA'S 5-WORKING-DAY SUPPLEMENT APPROVAL DOES NOT RUN CONCURRENTLY WITH THE
///         TIMELOCK. Approval and publication precede execution; the timelock then runs on
///         top. Treating them as overlapping is how a release plan ends up short by a week.
/// @dev    ⚠️ COMMIT-REVEAL EXISTS FOR MAR ART 17(1a), NOT FOR SECRECY'S SAKE. Where the
///         queued step is an intermediate stage in a protracted process, the issuer may delay
///         disclosure — but a plaintext upgrade payload sitting in a public queue IS the
///         disclosure, made early, to whoever reads the mempool first. So an intermediate
///         step is queued as a hash and revealed at execution. A final step is queued in the
///         clear, because by then there is nothing left to protect.
contract DoraGovernor {
    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance; // multisig
    IDocumentRegistry public immutable documents;

    // ─────────────────────────── timelock ─────────────────────────────────────

    uint64 public timelockDelaySeconds = 2 days;

    /// @notice Floor below which the delay cannot be set. A timelock an operator can shorten
    ///         to zero on the day it needs to is not a control, and the party it was
    ///         protecting — the holder deciding whether to exit ahead of a change — is
    ///         exactly the party who loses.
    uint64 public constant MIN_TIMELOCK_DELAY = 12 hours;

    enum StepKind {
        Intermediate, // MAR Art 17(1a) — payload committed as a hash, revealed at execution
        Final // payload queued in the clear
    }

    struct QueuedUpgrade {
        bool queued;
        bool executed;
        bool cancelled;
        StepKind kind;
        address target;
        bytes32 payloadHash; // for Intermediate: keccak256(payload, salt). For Final: keccak256(payload)
        bytes payload; // populated only for Final at queue time; for Intermediate, at reveal
        bytes32 disclosureArtefactHash;
        uint64 queuedAt;
        uint64 executableAt;
    }

    mapping(bytes32 => QueuedUpgrade) private _queue;

    // ─────────────────────────── pause ────────────────────────────────────────

    bool public paused;
    uint64 public pausedAt;

    // ─────────────────────────── key rotation register ────────────────────────
    //
    // DLT Pilot Art 7(5) asks for records of the MEANS OF ACCESS to client assets. This is
    // that record for the operator's own signing infrastructure: a hash of the signer set and
    // threshold, with a rotation history. Nothing here is a key or reveals one — the value is
    // that a rotation is timestamped and provable, so "when did the signer set change" has an
    // answer that does not depend on the operator's own files.

    struct KeySetRecord {
        bytes32 signerSetHash;
        uint16 threshold;
        uint64 rotatedAt;
        bytes32 reasonCode; // "SCHEDULED" / "COMPROMISE" / "PERSONNEL" / "CUSTODIAN_CHANGE"
    }

    KeySetRecord[] private _keyHistory;

    // ─────────────────────────── events ───────────────────────────────────────

    event UpgradeQueued(
        bytes32 indexed upgradeId,
        address indexed target,
        StepKind kind,
        bytes32 payloadHash,
        bytes32 disclosureArtefactHash,
        uint64 executableAt
    );
    event UpgradeRevealed(bytes32 indexed upgradeId, bytes payload);
    event UpgradeExecuted(bytes32 indexed upgradeId, address indexed target, bytes returndata);
    event UpgradeCancelled(bytes32 indexed upgradeId, bytes32 reasonHash);
    event TimelockDelaySet(uint64 oldSeconds, uint64 newSeconds);

    event Paused(bytes32 reasonHash, uint64 at);
    event Unpaused(uint64 at);

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
    error IsPaused();
    error NotPaused();
    error DelayBelowFloor(uint64 proposed, uint64 floor);
    error UpgradeExists(bytes32 upgradeId);
    error UnknownUpgrade(bytes32 upgradeId);
    error AlreadyExecuted(bytes32 upgradeId);
    error AlreadyCancelled(bytes32 upgradeId);
    error TimelockNotElapsed(bytes32 upgradeId, uint64 executableAt);
    error NoDisclosureArtefact(bytes32 artefactHash);
    error DisclosureNotApproved(bytes32 artefactHash);
    error PayloadMismatch(bytes32 expected, bytes32 actual);
    error PayloadNotRevealed(bytes32 upgradeId);
    error ExecutionFailed(bytes32 upgradeId);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier whenNotPaused() {
        if (paused) revert IsPaused();
        _;
    }

    constructor(address governance_, address documents_) {
        governance = governance_;
        documents = IDocumentRegistry(documents_);
    }

    function setTimelockDelay(uint64 newSeconds) external onlyGovernance {
        if (newSeconds < MIN_TIMELOCK_DELAY) revert DelayBelowFloor(newSeconds, MIN_TIMELOCK_DELAY);
        emit TimelockDelaySet(timelockDelaySeconds, newSeconds);
        timelockDelaySeconds = newSeconds;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // QUEUE — gated on a disclosure artefact that already exists AND is
    // already approved. Both checks, because an anchored-but-unapproved
    // supplement is a draft, and deploying against a draft is deploying
    // against a document the NCA may yet require you to change.
    // ═══════════════════════════════════════════════════════════════════════

    function queueUpgrade(
        bytes32 upgradeId,
        address target,
        StepKind kind,
        bytes32 payloadHash,
        bytes calldata payloadIfFinal,
        bytes32 disclosureArtefactHash
    ) external onlyGovernance whenNotPaused {
        if (_queue[upgradeId].queued) revert UpgradeExists(upgradeId);

        (bool exists, uint64 approvedAt) = documents.documentStatus(disclosureArtefactHash);
        if (!exists) revert NoDisclosureArtefact(disclosureArtefactHash);
        if (approvedAt == 0) revert DisclosureNotApproved(disclosureArtefactHash);

        bytes memory stored;
        bytes32 committedHash = payloadHash;

        if (kind == StepKind.Final) {
            // Nothing left to protect — the payload goes in the clear and its hash is
            // derived here rather than trusted from the caller.
            stored = payloadIfFinal;
            committedHash = keccak256(payloadIfFinal);
        }

        uint64 executableAt = uint64(block.timestamp) + timelockDelaySeconds;

        _queue[upgradeId] = QueuedUpgrade({
            queued: true,
            executed: false,
            cancelled: false,
            kind: kind,
            target: target,
            payloadHash: committedHash,
            payload: stored,
            disclosureArtefactHash: disclosureArtefactHash,
            queuedAt: uint64(block.timestamp),
            executableAt: executableAt
        });

        emit UpgradeQueued(upgradeId, target, kind, committedHash, disclosureArtefactHash, executableAt);
    }

    /// @notice Reveals an intermediate step's payload. Callable only once the timelock has
    ///         elapsed — revealing early defeats the Art 17(1a) delay the commit was for.
    /// @param salt The blinding value committed with the payload. Without it, a small payload
    ///             space is brute-forceable from the hash alone and the commitment protects
    ///             nothing.
    function revealUpgrade(bytes32 upgradeId, bytes calldata payload, bytes32 salt) external onlyGovernance {
        QueuedUpgrade storage u = _queue[upgradeId];
        if (!u.queued) revert UnknownUpgrade(upgradeId);
        if (u.executed) revert AlreadyExecuted(upgradeId);
        if (u.cancelled) revert AlreadyCancelled(upgradeId);
        if (block.timestamp < u.executableAt) revert TimelockNotElapsed(upgradeId, u.executableAt);

        bytes32 actual = keccak256(abi.encodePacked(payload, salt));
        if (actual != u.payloadHash) revert PayloadMismatch(u.payloadHash, actual);

        u.payload = payload;
        emit UpgradeRevealed(upgradeId, payload);
    }

    function executeUpgrade(bytes32 upgradeId) external onlyGovernance whenNotPaused {
        QueuedUpgrade storage u = _queue[upgradeId];
        if (!u.queued) revert UnknownUpgrade(upgradeId);
        if (u.executed) revert AlreadyExecuted(upgradeId);
        if (u.cancelled) revert AlreadyCancelled(upgradeId);
        if (block.timestamp < u.executableAt) revert TimelockNotElapsed(upgradeId, u.executableAt);
        if (u.payload.length == 0) revert PayloadNotRevealed(upgradeId);

        u.executed = true;

        (bool ok, bytes memory ret) = u.target.call(u.payload);
        if (!ok) revert ExecutionFailed(upgradeId);

        emit UpgradeExecuted(upgradeId, u.target, ret);
    }

    function cancelUpgrade(bytes32 upgradeId, bytes32 reasonHash) external onlyGovernance {
        QueuedUpgrade storage u = _queue[upgradeId];
        if (!u.queued) revert UnknownUpgrade(upgradeId);
        if (u.executed) revert AlreadyExecuted(upgradeId);
        u.cancelled = true;
        emit UpgradeCancelled(upgradeId, reasonHash);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // PAUSE — note it does NOT gate `pause()` itself or the incident log.
    // A pause path that can be paused, or an incident log that goes quiet
    // during an incident, is the wrong way round.
    // ═══════════════════════════════════════════════════════════════════════

    function pause(bytes32 reasonHash) external onlyGovernance {
        paused = true;
        pausedAt = uint64(block.timestamp);
        emit Paused(reasonHash, pausedAt);
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

    function currentKeySet() external view returns (KeySetRecord memory) {
        return _keyHistory[_keyHistory.length - 1];
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

    // ═══════════════════════════════════════════════════════════════════════

    function upgradeOf(bytes32 upgradeId) external view returns (QueuedUpgrade memory) {
        return _queue[upgradeId];
    }
}
