// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title TrustedIssuersRegistry (illustrative sample — not production code)
/// @notice C3 — the list of parties whose attestations `IdentityRegistry` will accept, and
///         the specific claim topics each of them is trusted for. A KYC provider trusted
///         for AML screening is not thereby trusted to attest MiFID II suitability; the
///         per-topic scoping is the point of this contract, not an optional refinement.
/// @dev    eIDAS 2.0 (Reg 2024/1183) is the reason this is a registry rather than a single
///         signer address: identity attestations are expected to originate from qualified
///         trust service providers on the EU Trusted List, and QTSP status is itself
///         revocable. `qtspIdentifier` anchors each issuer to its Trusted List entry so a
///         reviewer can reconcile the on-chain set against the published EU list.
/// @dev    ⚠️ Revocation here is RETROACTIVE by default. When an issuer is revoked, claims
///         it previously wrote stop counting immediately — `IdentityRegistry` re-checks
///         trust at read time, not at write time. The alternative (grandfathering claims
///         written while the issuer was still trusted) is defensible for an ordinary
///         commercial provider and indefensible for a QTSP whose qualified status was
///         withdrawn for cause, because the withdrawal reason usually reaches the past
///         attestations too. Grandfathering is available via `revokeProspectively` — use it
///         deliberately, and record why.
contract TrustedIssuersRegistry {
    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;

    // ─────────────────────────── state ────────────────────────────────────────

    struct Issuer {
        bool registered;
        /// @dev EU Trusted List / QTSP identifier, or a hash of the provider's contractual
        ///      identity where the issuer is not a QTSP. Never personal data.
        bytes32 qtspIdentifier;
        uint64 trustedFrom;
        /// @dev 0 while trusted. Once set: claims are rejected outright if
        ///      `retroactiveRevocation` is true, or accepted only where the claim was
        ///      issued strictly before this timestamp if it is false.
        uint64 revokedAt;
        bool retroactiveRevocation;
    }

    mapping(address => Issuer) public issuers;
    mapping(address => mapping(uint256 => bool)) public topicScope;

    address[] private _issuerList;

    // ─────────────────────────── events ───────────────────────────────────────

    event IssuerRegistered(address indexed issuer, bytes32 indexed qtspIdentifier, uint256[] topics);
    event IssuerTopicsUpdated(address indexed issuer, uint256[] added, uint256[] removed);
    event IssuerRevoked(address indexed issuer, uint64 revokedAt, bool retroactive, bytes32 reasonHash);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error AlreadyRegistered(address issuer);
    error UnknownIssuer(address issuer);
    error AlreadyRevoked(address issuer);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_) {
        governance = governance_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // REGISTRATION
    // ═══════════════════════════════════════════════════════════════════════

    function registerIssuer(
        address issuer,
        bytes32 qtspIdentifier,
        uint256[] calldata topics
    ) external onlyGovernance {
        if (issuers[issuer].registered) revert AlreadyRegistered(issuer);

        issuers[issuer] = Issuer({
            registered: true,
            qtspIdentifier: qtspIdentifier,
            trustedFrom: uint64(block.timestamp),
            revokedAt: 0,
            retroactiveRevocation: false
        });
        _issuerList.push(issuer);

        for (uint256 i = 0; i < topics.length; i++) {
            topicScope[issuer][topics[i]] = true;
        }

        emit IssuerRegistered(issuer, qtspIdentifier, topics);
    }

    function updateTopics(
        address issuer,
        uint256[] calldata add,
        uint256[] calldata remove
    ) external onlyGovernance {
        if (!issuers[issuer].registered) revert UnknownIssuer(issuer);

        for (uint256 i = 0; i < add.length; i++) {
            topicScope[issuer][add[i]] = true;
        }
        for (uint256 i = 0; i < remove.length; i++) {
            topicScope[issuer][remove[i]] = false;
        }

        emit IssuerTopicsUpdated(issuer, add, remove);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // REVOCATION — two shapes, chosen explicitly. Neither is the default.
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Withdraws trust and invalidates every claim this issuer ever wrote. The right
    ///         call where the issuer's own qualified status was withdrawn, where its signing
    ///         key is compromised, or where its process is found defective — in each case
    ///         the historic attestations are as suspect as the future ones.
    /// @param reasonHash Hash of the off-chain decision record. The reason is not on-chain,
    ///                   but the fact that a reason exists and is retrievable is.
    function revokeRetroactively(address issuer, bytes32 reasonHash) external onlyGovernance {
        _revoke(issuer, true, reasonHash);
    }

    /// @notice Withdraws trust going forward only; claims written before this moment keep
    ///         counting. Appropriate for a commercial wind-down or a contract that simply
    ///         ended — not for a failure. Choosing this over the retroactive form is an
    ///         assertion that the issuer's past work is still good, so make it on the
    ///         record, not by omission.
    function revokeProspectively(address issuer, bytes32 reasonHash) external onlyGovernance {
        _revoke(issuer, false, reasonHash);
    }

    function _revoke(address issuer, bool retroactive, bytes32 reasonHash) private {
        Issuer storage rec = issuers[issuer];
        if (!rec.registered) revert UnknownIssuer(issuer);
        if (rec.revokedAt != 0) revert AlreadyRevoked(issuer);

        rec.revokedAt = uint64(block.timestamp);
        rec.retroactiveRevocation = retroactive;

        emit IssuerRevoked(issuer, rec.revokedAt, retroactive, reasonHash);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS — `IdentityRegistry` calls `isTrustedFor` on every claim read, which
    // is what makes revocation take effect without rewriting any claim.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param issuedAt Timestamp the claim under test was written. Ignored under a
    ///                 retroactive revocation; decisive under a prospective one.
    function isTrustedFor(address issuer, uint256 topic, uint64 issuedAt) external view returns (bool) {
        Issuer storage rec = issuers[issuer];
        if (!rec.registered) return false;
        if (!topicScope[issuer][topic]) return false;
        if (issuedAt < rec.trustedFrom) return false;

        if (rec.revokedAt != 0) {
            if (rec.retroactiveRevocation) return false;
            if (issuedAt >= rec.revokedAt) return false;
        }
        return true;
    }

    /// @notice Whether the issuer may write NEW claims on this topic right now.
    function canIssueNow(address issuer, uint256 topic) external view returns (bool) {
        Issuer storage rec = issuers[issuer];
        return rec.registered && rec.revokedAt == 0 && topicScope[issuer][topic];
    }

    function issuerList() external view returns (address[] memory) {
        return _issuerList;
    }
}
