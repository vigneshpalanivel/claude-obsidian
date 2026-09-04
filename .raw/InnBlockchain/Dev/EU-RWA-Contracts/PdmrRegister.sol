// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title IPdmrRegister
/// @notice The read surface every MAR Art 19 module consumes: given a wallet, is this person
///         a manager (PDMR) or one of their closely associated persons (PCA), and whose
///         obligation does the wallet sit under.
interface IPdmrRegister {
    enum Role {
        None,
        Pdmr, // MAR Art 3(1)(25) — person discharging managerial responsibilities
        Pca // MAR Art 3(1)(26) — person closely associated with a PDMR
    }

    /// @return The wallet's current role, or `None` where it was never declared or has since
    ///         been revoked. A revoked wallet keeps its record for the retention period but
    ///         stops being flagged — a director who leaves is no longer a director.
    function roleOf(address wallet) external view returns (Role);

    /// @notice The natural person the wallet belongs to. This is the aggregation key for the
    ///         Art 19(1a) threshold, which is per PERSON across all their wallets.
    function personOf(address wallet) external view returns (bytes32 personId);

    /// @notice For a PCA, the PDMR they are associated with. For a PDMR, their own id.
    function principalOf(address wallet) external view returns (bytes32 pdmrId);

    function isFlagged(address wallet) external view returns (bool);
}

/// @title PdmrRegister (illustrative sample — not production code)
/// @notice The MAR Art 19(5) declared register, mapped to wallet addresses. It is the single
///         source of the flag set that `PdmrClosedPeriodFreeze` blocks on and that
///         `PdmrThresholdMonitor` aggregates against. Nothing else in the stack knows who a
///         manager is.
/// @dev    ⚠️ THIS REGISTER IS DECLARED, NOT DERIVED — AND THAT IS THE WHOLE DIFFICULTY.
///         A PDMR you can find in your own onboarding data. A PCA you cannot: Art 3(1)(26)
///         reaches a spouse or equivalent partner, dependent children, relatives sharing the
///         household for ≥1 year, and legal persons/trusts/partnerships managed by or set up
///         for the benefit of the PDMR. None of those people need have any relationship with
///         the platform at all, and none of their wallets are discoverable from your KYC
///         records or from on-chain analysis. Art 19(5) is what makes the register exist:
///         the issuer notifies PDMRs in writing, PDMRs notify their own PCAs, and the issuer
///         keeps the list. This contract is the wallet-address mirror of that legal artefact.
///         There is no oracle for it and there never will be.
/// @dev    ⚠️ A DECLARATION IS EFFECTIVE ON ENTRY, NOT ON SELF-CONFIRMATION. `confirmWallet`
///         exists so the holder proves key control and the issuer holds evidence, but the
///         freeze applies from `declareWallet`. Gating the flag on confirmation would hand
///         every PCA a trivial opt-out: never confirm, never get frozen. Fail closed.
/// @dev    GDPR: `personId` is a salted hash held against the off-chain register, exactly as
///         `IdentityRegistry` treats the national client identifier. Names, relationships and
///         the nature of the association are Art 9-adjacent personal data and never go
///         on-chain — an address is pseudonymous, a stored family relationship is not.
contract PdmrRegister is IPdmrRegister {
    // ─────────────────────────── roles ────────────────────────────────────────

    /// @dev The issuer's company secretary / compliance function — whoever runs the Art 19(5)
    ///      notification cycle off-chain. Deliberately not the same key as the venue operator
    ///      or the token admin: this register decides who is frozen, so the party that
    ///      benefits from a freeze not applying must not be the party that maintains it.
    address public immutable registrar;

    // ─────────────────────────── retention ────────────────────────────────────

    /// @dev MAR Art 18(5) is the ≥5-year rule for insider lists; the Art 19 register is
    ///      retained on the same footing because it is the evidence that a freeze was or was
    ///      not owed on a given date. Records are revoked, then purged — never deleted live.
    uint64 public constant RETENTION_PERIOD = 5 * 365 days;

    /// @dev Nothing in MAR fixes a re-attestation cadence. The reason to have one is that a
    ///      PCA set decays silently — people marry, separate, and set up trusts without
    ///      telling the issuer, and a register nobody refreshes is a register that quietly
    ///      stops matching reality while continuing to look authoritative.
    uint64 public reattestationPeriod = 365 days;

    // ─────────────────────────── records ──────────────────────────────────────

    struct WalletRecord {
        Role role;
        bool selfConfirmed; // holder proved key control — evidence, not a precondition
        bytes32 personId; // salted hash — the Art 19(1a) aggregation key
        bytes32 pdmrId; // for a PCA, their principal; for a PDMR, == personId
        uint64 declaredAt;
        uint64 revokedAt; // 0 while live
        bytes32 declarationHash; // hash of the signed Art 19(5) declaration this came from
    }

    mapping(address => WalletRecord) private _records;

    /// @dev Enumeration for the off-chain register export and for reconciling the Art 19(1a)
    ///      aggregate. Never iterated on a transfer path — the threshold monitor keys on
    ///      `personId` directly and never needs the wallet list.
    mapping(bytes32 => address[]) private _walletsOfPerson;

    mapping(bytes32 => uint64) public lastAttestedAt;

    // ─────────────────────────── events ───────────────────────────────────────

    event WalletDeclared(
        address indexed wallet, bytes32 indexed personId, bytes32 indexed pdmrId, Role role, bytes32 declarationHash
    );
    event WalletConfirmed(address indexed wallet, bytes32 indexed personId);
    event WalletRevoked(address indexed wallet, bytes32 indexed personId, uint64 revokedAt);
    event WalletPurged(address indexed wallet);
    event PersonAttested(bytes32 indexed personId, uint64 attestedAt, bytes32 declarationHash);
    event ReattestationPeriodSet(uint64 seconds_);

    /// @dev Fires when a live person's declaration has aged past `reattestationPeriod`. An
    ///      alert, not a block: a stale declaration does not mean the person stopped being a
    ///      PDMR, and unfreezing them because paperwork lapsed is the wrong failure direction.
    event DeclarationStale(bytes32 indexed personId, uint64 lastAttestedAt);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotRegistrar();
    error NotTheDeclaredWallet();
    error RoleRequired();
    error PrincipalMismatch(bytes32 personId, bytes32 pdmrId);
    error AlreadyDeclared(address wallet);
    error NotDeclared(address wallet);
    error AlreadyRevoked(address wallet);
    error RetentionNotExpired(uint64 purgeableAt);

    modifier onlyRegistrar() {
        if (msg.sender != registrar) revert NotRegistrar();
        _;
    }

    constructor(address registrar_) {
        registrar = registrar_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // DECLARATION — the only way a wallet enters the flag set.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param pdmrId  For `Role.Pdmr` this must equal `personId`. For `Role.Pca` it is the
    ///                manager the association runs through — a PCA is only a PCA relative to
    ///                somebody, and Art 19(2) publication is filed under that manager's name.
    /// @param declarationHash  Hash of the signed Art 19(5) declaration this entry came from.
    ///                Anchoring it is what makes the register evidential rather than merely
    ///                operational: it shows the wallet was declared by the person, on a date,
    ///                against a document you still hold.
    function declareWallet(address wallet, bytes32 personId, bytes32 pdmrId, Role role, bytes32 declarationHash)
        external
        onlyRegistrar
    {
        if (role == Role.None) revert RoleRequired();
        if (role == Role.Pdmr && pdmrId != personId) revert PrincipalMismatch(personId, pdmrId);

        WalletRecord storage r = _records[wallet];
        if (r.declaredAt != 0 && r.revokedAt == 0) revert AlreadyDeclared(wallet);

        r.role = role;
        r.selfConfirmed = false;
        r.personId = personId;
        r.pdmrId = pdmrId;
        r.declaredAt = uint64(block.timestamp);
        r.revokedAt = 0;
        r.declarationHash = declarationHash;

        _walletsOfPerson[personId].push(wallet);
        lastAttestedAt[personId] = uint64(block.timestamp);

        emit WalletDeclared(wallet, personId, pdmrId, role, declarationHash);
        emit PersonAttested(personId, uint64(block.timestamp), declarationHash);
    }

    /// @notice Called by the declared wallet itself to prove key control. Evidence only — see
    ///         the contract-level note. The wallet is already frozen-eligible without it.
    function confirmWallet() external {
        WalletRecord storage r = _records[msg.sender];
        if (r.declaredAt == 0 || r.revokedAt != 0) revert NotTheDeclaredWallet();
        r.selfConfirmed = true;
        emit WalletConfirmed(msg.sender, r.personId);
    }

    /// @notice Periodic re-confirmation that the person's declared PCA set is still current.
    ///         Refreshes the clock behind `isDeclarationStale`.
    function attestPerson(bytes32 personId, bytes32 declarationHash) external onlyRegistrar {
        lastAttestedAt[personId] = uint64(block.timestamp);
        emit PersonAttested(personId, uint64(block.timestamp), declarationHash);
    }

    function setReattestationPeriod(uint64 seconds_) external onlyRegistrar {
        reattestationPeriod = seconds_;
        emit ReattestationPeriodSet(seconds_);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // REVOCATION AND PURGE — a two-step, because the record is evidence for
    // five years after the person stops being flagged.
    // ═══════════════════════════════════════════════════════════════════════

    function revokeWallet(address wallet) external onlyRegistrar {
        WalletRecord storage r = _records[wallet];
        if (r.declaredAt == 0) revert NotDeclared(wallet);
        if (r.revokedAt != 0) revert AlreadyRevoked(wallet);

        r.revokedAt = uint64(block.timestamp);
        emit WalletRevoked(wallet, r.personId, r.revokedAt);
    }

    function purgeWallet(address wallet) external onlyRegistrar {
        WalletRecord storage r = _records[wallet];
        if (r.declaredAt == 0) revert NotDeclared(wallet);
        if (r.revokedAt == 0) revert RetentionNotExpired(type(uint64).max);

        uint64 purgeableAt = r.revokedAt + RETENTION_PERIOD;
        if (block.timestamp < purgeableAt) revert RetentionNotExpired(purgeableAt);

        delete _records[wallet];
        emit WalletPurged(wallet);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READ SURFACE
    // ═══════════════════════════════════════════════════════════════════════

    function roleOf(address wallet) public view returns (Role) {
        WalletRecord storage r = _records[wallet];
        if (r.declaredAt == 0 || r.revokedAt != 0) return Role.None;
        return r.role;
    }

    function personOf(address wallet) external view returns (bytes32) {
        return _records[wallet].personId;
    }

    function principalOf(address wallet) external view returns (bytes32) {
        return _records[wallet].pdmrId;
    }

    function isFlagged(address wallet) external view returns (bool) {
        return roleOf(wallet) != Role.None;
    }

    function recordOf(address wallet) external view returns (WalletRecord memory) {
        return _records[wallet];
    }

    function walletsOfPerson(bytes32 personId) external view returns (address[] memory) {
        return _walletsOfPerson[personId];
    }

    function isDeclarationStale(bytes32 personId) public view returns (bool) {
        uint64 last = lastAttestedAt[personId];
        if (last == 0) return true;
        return block.timestamp > last + reattestationPeriod;
    }

    /// @notice Non-view twin of `isDeclarationStale` so a keeper can emit the alert. Kept
    ///         separate because the freeze path must stay `view` — surveillance observes,
    ///         it does not get to write state on somebody else's transfer.
    function flagStaleDeclaration(bytes32 personId) external {
        if (isDeclarationStale(personId)) {
            emit DeclarationStale(personId, lastAttestedAt[personId]);
        }
    }
}
