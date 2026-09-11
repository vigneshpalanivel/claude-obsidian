// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IClaimIssuer, ITrustedIssuersRegistry} from "./IERC3643.sol";

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
/// @dev    ⚠️ IMPLEMENTS `ITrustedIssuersRegistry` FROM `IERC3643.sol`, WRITTEN FROM THE EIP
///         TEXT. No T-REX source is used, in whole or in part. Conformance grade on this
///         interface is FULL — every one of the eight functions and three events is present
///         with the exact signature — but two of them carry SEMANTIC deviations, registered in
///         `ERC-3643-CONFORMANCE.md` and repeated on the functions themselves:
///           (1) `removeTrustedIssuer` REVOKES RETROACTIVELY; it does not delete the record.
///               A deleted issuer has no revocation timestamp, and without one no claim it ever
///               wrote can be evaluated afterwards — including by an NCA reconstructing why a
///               transfer was allowed in 2027. `getTrustedIssuers()` honours the EIP's reading
///               by returning only LIVE issuers; `issuerList()` returns everything ever
///               registered, which is the audit surface and is deliberately not the EIP's.
///           (2) `addTrustedIssuer` cannot carry `qtspIdentifier` — the EIP has no field for it
///               — so it registers with an EMPTY eIDAS anchor. See its NatSpec.
/// @dev    ⚠️ THE EIP TYPES ISSUERS AS `IClaimIssuer`, A CONTRACT, AND THIS SUITE DOES NOT
///         REQUIRE ONE. Every issuer here is an ADDRESS that signs off-chain; the parameters are
///         typed `IClaimIssuer` because the compiler must see the exact signature, and the
///         implementation only ever uses `address(_trustedIssuer)`. Nothing calls
///         `isClaimValid` on it. Deploying a claim-issuer CONTRACT per provider is the
///         ONCHAINID shape, and adopting it is Design §16 D19 — open, and not decided here.
contract TrustedIssuersRegistry is ITrustedIssuersRegistry {
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

    /// @dev ⚠️ ENUMERABLE MIRROR OF `topicScope`, MAINTAINED ONLY BECAUSE THE EIP REQUIRES IT.
    ///      `getTrustedIssuerClaimTopics` and `getTrustedIssuersForClaimTopic` cannot be
    ///      answered from a mapping, so the set is kept twice. The MAPPING IS AUTHORITATIVE —
    ///      every gate reads `topicScope`, never this array — and the two are written together
    ///      in `_setTopics` so they cannot drift. A reviewer who finds a divergence should treat
    ///      the array as wrong, not the mapping.
    mapping(address => uint256[]) private _issuerTopics;

    address[] private _issuerList;

    // ─────────────────────────── events ───────────────────────────────────────

    event IssuerRegistered(address indexed issuer, bytes32 indexed qtspIdentifier, uint256[] topics);
    event IssuerTopicsUpdated(address indexed issuer, uint256[] added, uint256[] removed);
    event IssuerRevoked(address indexed issuer, uint64 revokedAt, bool retroactive, bytes32 reasonHash);
    event QtspIdentifierSet(address indexed issuer, bytes32 indexed qtspIdentifier);
    /// @dev ⚠️ `TrustedIssuerAdded`, `TrustedIssuerRemoved` and `ClaimTopicsUpdated` are
    ///      INHERITED from `ITrustedIssuersRegistry` and must not be re-declared here. They are
    ///      emitted ALONGSIDE the suite's own events rather than instead of them: the suite's
    ///      carry the eIDAS anchor and the retroactive/prospective choice, which the standard's
    ///      have no field for. A listener that reads only the EIP events sees a correct but
    ///      thinner history — the revocation SHAPE is not in it.

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
            _addTopic(issuer, topics[i]);
        }

        emit IssuerRegistered(issuer, qtspIdentifier, topics);
        emit TrustedIssuerAdded(IClaimIssuer(issuer), _issuerTopics[issuer]);
    }

    function updateTopics(
        address issuer,
        uint256[] calldata add,
        uint256[] calldata remove
    ) external onlyGovernance {
        if (!issuers[issuer].registered) revert UnknownIssuer(issuer);

        for (uint256 i = 0; i < add.length; i++) {
            _addTopic(issuer, add[i]);
        }
        for (uint256 i = 0; i < remove.length; i++) {
            _removeTopic(issuer, remove[i]);
        }

        emit IssuerTopicsUpdated(issuer, add, remove);
        emit ClaimTopicsUpdated(IClaimIssuer(issuer), _issuerTopics[issuer]);
    }

    /// @notice Attaches or corrects the EU Trusted List anchor for an already-registered issuer.
    ///         Exists because the EIP's `addTrustedIssuer` has nowhere to put one, and because
    ///         Trusted List entries genuinely change — a QTSP re-registers, a national list is
    ///         restructured. Not a revocation: it says nothing about whether the issuer is still
    ///         trusted, only about where a reviewer looks it up.
    function setQtspIdentifier(address issuer, bytes32 qtspIdentifier) external onlyGovernance {
        if (!issuers[issuer].registered) revert UnknownIssuer(issuer);
        issuers[issuer].qtspIdentifier = qtspIdentifier;
        emit QtspIdentifierSet(issuer, qtspIdentifier);
    }

    // ─────────────────────── topic-set bookkeeping ────────────────────────────

    /// @dev Mapping and array written together. Idempotent on both sides.
    function _addTopic(address issuer, uint256 topic) private {
        if (topicScope[issuer][topic]) return;
        topicScope[issuer][topic] = true;
        _issuerTopics[issuer].push(topic);
    }

    function _removeTopic(address issuer, uint256 topic) private {
        if (!topicScope[issuer][topic]) return;
        topicScope[issuer][topic] = false;

        uint256[] storage list = _issuerTopics[issuer];
        for (uint256 i = 0; i < list.length; i++) {
            if (list[i] == topic) {
                list[i] = list[list.length - 1];
                list.pop();
                return;
            }
        }
    }

    /// @dev Replaces the whole set — the EIP's `updateIssuerClaimTopics` semantics, which are
    ///      NOT the additive/subtractive semantics of `updateTopics`. Both are offered; a caller
    ///      who confuses them silently widens or narrows an issuer's scope, so the two carry
    ///      different names rather than an overload.
    function _setTopics(address issuer, uint256[] calldata topics) private {
        uint256[] storage list = _issuerTopics[issuer];
        for (uint256 i = 0; i < list.length; i++) {
            topicScope[issuer][list[i]] = false;
        }
        delete _issuerTopics[issuer];

        for (uint256 i = 0; i < topics.length; i++) {
            _addTopic(issuer, topics[i]);
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ERC-3643 SURFACE — thin, and every member routes to the machinery above.
    //
    // ⚠️ NONE OF THESE ARE THE PREFERRED ENTRY POINTS. `registerIssuer`,
    // `updateTopics`, `revokeRetroactively` and `revokeProspectively` carry the
    // eIDAS anchor and the revocation-shape choice; the EIP's members cannot. They
    // exist so a wallet, an explorer or a third-party compliance module written
    // against the standard can read and drive this registry without a bespoke ABI.
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice ⚠️ CONFORMANT, AND LOSSY. Registers with an EMPTY `qtspIdentifier`, because the
    ///         EIP's signature has no field for one. An issuer with a zero anchor cannot be
    ///         reconciled against the published EU Trusted List, which is the whole reason this
    ///         is a registry rather than a signer address — so a zero anchor is a DEPLOYMENT
    ///         DEFECT, not a supported state. `issuers(addr).qtspIdentifier == 0` is publicly
    ///         readable and is what a reviewer greps for.
    /// @dev    Either use `registerIssuer` (which takes the anchor) or follow this call with
    ///         `setQtspIdentifier` in the same governance transaction batch.
    function addTrustedIssuer(IClaimIssuer _trustedIssuer, uint256[] calldata _claimTopics) external onlyGovernance {
        address issuer = address(_trustedIssuer);
        if (issuers[issuer].registered) revert AlreadyRegistered(issuer);

        issuers[issuer] = Issuer({
            registered: true,
            qtspIdentifier: bytes32(0),
            trustedFrom: uint64(block.timestamp),
            revokedAt: 0,
            retroactiveRevocation: false
        });
        _issuerList.push(issuer);
        _setTopics(issuer, _claimTopics);

        emit IssuerRegistered(issuer, bytes32(0), _claimTopics);
        emit TrustedIssuerAdded(_trustedIssuer, _claimTopics);
    }

    /// @notice ⚠️ DECLARED DEVIATION — REVOKES, DOES NOT DELETE, and revokes RETROACTIVELY.
    ///         The EIP's reading is that a removed issuer is no longer trusted; this delivers
    ///         that (`isTrustedIssuer` goes false, `getTrustedIssuers` drops it, every claim it
    ///         wrote stops counting) while KEEPING the record. A deleted issuer has no
    ///         revocation timestamp, and without one nobody can afterwards evaluate a claim it
    ///         wrote — including the operator reconstructing, for an NCA, why a transfer in
    ///         2027 was permitted.
    /// @dev    Retroactive rather than prospective because removal through the EIP's surface
    ///         carries no reason, and an unexplained withdrawal of trust is the case where
    ///         grandfathering past attestations is least defensible. Where the past work IS
    ///         still good, the correct call is `revokeProspectively`, which says so on the
    ///         record. `reasonHash` is zero here for the same reason the anchor is: the
    ///         signature has no room for it.
    function removeTrustedIssuer(IClaimIssuer _trustedIssuer) external onlyGovernance {
        _revoke(address(_trustedIssuer), true, bytes32(0));
    }

    /// @notice ⚠️ REPLACES the issuer's topic set. This is NOT `updateTopics`, which adds and
    ///         removes against the existing set. Passing an empty array here strips the issuer
    ///         of every topic while leaving it registered and un-revoked — a state that reads as
    ///         "trusted" in `isTrustedIssuer` and accepts nothing in `hasClaimTopic`.
    function updateIssuerClaimTopics(
        IClaimIssuer _trustedIssuer,
        uint256[] calldata _claimTopics
    ) external onlyGovernance {
        address issuer = address(_trustedIssuer);
        if (!issuers[issuer].registered) revert UnknownIssuer(issuer);

        _setTopics(issuer, _claimTopics);

        emit ClaimTopicsUpdated(_trustedIssuer, _claimTopics);
    }

    /// @notice LIVE issuers only — registered and not revoked. `issuerList()` is the full
    ///         history and is the one to read for an audit.
    function getTrustedIssuers() external view returns (IClaimIssuer[] memory) {
        uint256 live;
        for (uint256 i = 0; i < _issuerList.length; i++) {
            Issuer storage rec = issuers[_issuerList[i]];
            if (rec.registered && rec.revokedAt == 0) live++;
        }

        IClaimIssuer[] memory out = new IClaimIssuer[](live);
        uint256 n;
        for (uint256 i = 0; i < _issuerList.length; i++) {
            address a = _issuerList[i];
            Issuer storage rec = issuers[a];
            if (rec.registered && rec.revokedAt == 0) out[n++] = IClaimIssuer(a);
        }
        return out;
    }

    function getTrustedIssuersForClaimTopic(uint256 claimTopic) external view returns (IClaimIssuer[] memory) {
        uint256 live;
        for (uint256 i = 0; i < _issuerList.length; i++) {
            address a = _issuerList[i];
            Issuer storage rec = issuers[a];
            if (rec.registered && rec.revokedAt == 0 && topicScope[a][claimTopic]) live++;
        }

        IClaimIssuer[] memory out = new IClaimIssuer[](live);
        uint256 n;
        for (uint256 i = 0; i < _issuerList.length; i++) {
            address a = _issuerList[i];
            Issuer storage rec = issuers[a];
            if (rec.registered && rec.revokedAt == 0 && topicScope[a][claimTopic]) out[n++] = IClaimIssuer(a);
        }
        return out;
    }

    /// @notice Whether this issuer is trusted RIGHT NOW for anything at all.
    /// @dev    ⚠️ NOT the gate. `IdentityRegistry` reads `isTrustedFor(issuer, topic, issuedAt)`
    ///         on every claim, because trust is per-topic and evaluated against the moment the
    ///         claim was WRITTEN. This answers a coarser question and is present for the
    ///         standard's readers. Using it as a gate would accept an AML provider's attestation
    ///         of MiFID II suitability.
    function isTrustedIssuer(address _issuer) external view returns (bool) {
        Issuer storage rec = issuers[_issuer];
        return rec.registered && rec.revokedAt == 0;
    }

    /// @notice The issuer's current topic set. Reflects scope, not liveness — a revoked issuer
    ///         still reports the topics it held.
    function getTrustedIssuerClaimTopics(IClaimIssuer _trustedIssuer) external view returns (uint256[] memory) {
        return _issuerTopics[address(_trustedIssuer)];
    }

    /// @notice Whether the issuer may write a NEW claim on this topic now. Same answer as
    ///         `canIssueNow`, under the name the standard uses.
    /// @dev    ⚠️ Says nothing about claims already written. A prospectively-revoked issuer
    ///         answers `false` here while its historic claims still count — which is the
    ///         intended behaviour and the reason `isTrustedFor` takes `issuedAt`.
    function hasClaimTopic(address _issuer, uint256 _claimTopic) external view returns (bool) {
        Issuer storage rec = issuers[_issuer];
        return rec.registered && rec.revokedAt == 0 && topicScope[_issuer][_claimTopic];
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
        // ⚠️ BOTH revocation shapes emit the EIP's removal event, including the PROSPECTIVE one.
        // The standard has no vocabulary for "trusted for what it already wrote, not for what it
        // writes next", and under its reading the issuer has left `getTrustedIssuers()` — which
        // is true here. A listener reading only EIP events therefore cannot tell the two shapes
        // apart; `IssuerRevoked` carries the `retroactive` flag and is the event that can.
        emit TrustedIssuerRemoved(IClaimIssuer(issuer));
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
