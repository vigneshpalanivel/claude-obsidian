// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title InsiderListAnchor (illustrative sample — not production code)
/// @notice MAR Art 18 insider lists, reduced to the only two jobs a contract can honestly do
///         for them: anchor a tamper-evident hash of each list version for the ≥5-year
///         retention period, and hold the wallet-level facts that a tokenized instrument
///         generates and a paper insider list has no way to know about.
/// @dev    ⚠️ THE LIST ITSELF STAYS OFF-CHAIN, AND THAT IS NOT A SHORTCUT. Art 18(3) requires
///         names, dates of birth, personal and company telephone numbers, home addresses and
///         the reason each person is on the list. That is exactly the category of personal
///         data GDPR Art 17 gives a right to erasure over, and an immutable ledger cannot
///         honour erasure. Anchoring a hash gives you the integrity proof — the list you hand
///         the NCA is provably the list you held on the date — without writing a single
///         erasable field to a place it can never be erased from.
/// @dev    ⚠️ THE TOKENIZED-INSTRUMENT GAP IS THE PERMANENT SECTION. Multisig key holders and
///         anyone with upgrade authority hold STANDING access to undisclosed material change:
///         they see a queued upgrade, a parameter change or a freeze before the market does,
///         on every occasion, not on one deal. Art 18 calls that the permanent section — not a
///         per-event section they get added to when someone remembers. This is the mapping a
///         traditional insider list has no equivalent for, and it is derivable on-chain, which
///         is precisely why leaving it undone is indefensible after the fact.
contract InsiderListAnchor {
    /// @dev Art 18(5) — retain for ≥5 years after the list is drawn up or updated. Note the
    ///      clock runs from the UPDATE, so a list amended in year four resets to five.
    uint64 public constant RETENTION_PERIOD = 5 * 365 days;

    enum Section {
        None,
        /// Art 18(1)(a) — a section per piece of inside information, holding only the people
        /// who had access to that item.
        EventBased,
        /// Art 18(1) final subparagraph — the optional permanent section: people who, by the
        /// nature of their function, have access to all inside information at all times.
        Permanent
    }

    struct ListVersion {
        Section section;
        bytes32 eventRef; // 0 for the permanent section
        bytes32 contentHash; // hash of the off-chain list, in the ESMA Art 18(9) format
        bool reducedFormat; // Art 18(6) — SME growth market relief
        uint64 anchoredAt;
        uint64 retentionExpiresAt;
        bool purged;
    }

    // ─────────────────────────── wiring ───────────────────────────────────────

    address public immutable issuer;

    // ─────────────────────────── versions ─────────────────────────────────────

    mapping(uint256 => ListVersion) public versions;
    uint256 public versionCount;

    /// @dev The newest anchored version per section key — `keccak256(section, eventRef)`.
    mapping(bytes32 => uint256) public latestVersionOf;

    // ─────────────────────────── acknowledgments (Art 18(2)(a)) ───────────────

    /// @dev personId (salted hash) => hash of that person's written acknowledgment of the
    ///      legal and regulatory duties, and of the sanctions. Art 18(2) makes this a
    ///      condition of the list being properly maintained, not a nicety — and it is the
    ///      single most commonly missing artefact when an NCA asks for the list.
    mapping(bytes32 => bytes32) public acknowledgmentHash;
    mapping(bytes32 => uint64) public acknowledgedAt;

    // ─────────────────────────── standing access (permanent section) ──────────

    struct StandingAccess {
        bytes32 personId;
        bytes32 reasonRef; // "multisig signer", "upgrade authority", "pause guardian"
        uint64 registeredAt;
        uint64 removedAt; // 0 while live
    }

    mapping(address => StandingAccess) public standingAccess;
    address[] private _standingAccessWallets;

    // ─────────────────────────── events ───────────────────────────────────────

    event VersionAnchored(
        uint256 indexed versionId,
        Section indexed section,
        bytes32 indexed eventRef,
        bytes32 contentHash,
        bool reducedFormat,
        uint64 retentionExpiresAt
    );
    event VersionPurged(uint256 indexed versionId);
    event AcknowledgmentRecorded(bytes32 indexed personId, bytes32 acknowledgmentHash, uint64 at);
    event StandingAccessRegistered(address indexed wallet, bytes32 indexed personId, bytes32 reasonRef);
    event StandingAccessRemoved(address indexed wallet, bytes32 indexed personId, uint64 at);

    /// @dev Raised when a wallet with standing access exists but the permanent section has not
    ///      been re-anchored since it was registered — i.e. the on-chain fact and the filed
    ///      list have diverged. Emitted rather than reverted: blocking a key rotation because
    ///      paperwork lags would make the security posture worse, not better.
    event PermanentSectionStale(address indexed wallet, uint64 registeredAt, uint64 lastAnchoredAt);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotIssuer();
    error SectionRequired();
    error EventRefRequired();
    error PermanentSectionTakesNoEventRef();
    error ContentHashRequired();
    error UnknownVersion(uint256 versionId);
    error RetentionNotExpired(uint64 purgeableAt);
    error AlreadyPurged(uint256 versionId);
    error NotRegistered(address wallet);

    modifier onlyIssuer() {
        if (msg.sender != issuer) revert NotIssuer();
        _;
    }

    constructor(address issuer_) {
        issuer = issuer_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ANCHORING — one version per draw-up or update. Versions are never
    // overwritten: Art 18(4) requires the list to be kept in a form showing
    // when it changed, so an update is an append, not a mutation.
    // ═══════════════════════════════════════════════════════════════════════

    function anchorVersion(Section section, bytes32 eventRef, bytes32 contentHash, bool reducedFormat)
        external
        onlyIssuer
        returns (uint256 versionId)
    {
        if (section == Section.None) revert SectionRequired();
        if (contentHash == bytes32(0)) revert ContentHashRequired();
        if (section == Section.EventBased && eventRef == bytes32(0)) revert EventRefRequired();
        if (section == Section.Permanent && eventRef != bytes32(0)) revert PermanentSectionTakesNoEventRef();

        uint64 nowTs = uint64(block.timestamp);
        uint64 expires = nowTs + RETENTION_PERIOD;

        versionId = versionCount++;
        versions[versionId] = ListVersion({
            section: section,
            eventRef: eventRef,
            contentHash: contentHash,
            reducedFormat: reducedFormat,
            anchoredAt: nowTs,
            retentionExpiresAt: expires,
            purged: false
        });
        latestVersionOf[_sectionKey(section, eventRef)] = versionId;

        emit VersionAnchored(versionId, section, eventRef, contentHash, reducedFormat, expires);
    }

    /// @notice Clears the anchor once its retention has run. Kept as an explicit, gated step
    ///         so that "the hash is gone" is always a deliberate act with a date, never an
    ///         accident of a migration.
    function purgeVersion(uint256 versionId) external onlyIssuer {
        if (versionId >= versionCount) revert UnknownVersion(versionId);
        ListVersion storage v = versions[versionId];
        if (v.purged) revert AlreadyPurged(versionId);
        if (block.timestamp < v.retentionExpiresAt) revert RetentionNotExpired(v.retentionExpiresAt);

        v.purged = true;
        v.contentHash = bytes32(0);
        emit VersionPurged(versionId);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ART 18(2)(a) WRITTEN ACKNOWLEDGMENT
    // ═══════════════════════════════════════════════════════════════════════

    function recordAcknowledgment(bytes32 personId, bytes32 ackHash) external onlyIssuer {
        acknowledgmentHash[personId] = ackHash;
        acknowledgedAt[personId] = uint64(block.timestamp);
        emit AcknowledgmentRecorded(personId, ackHash, uint64(block.timestamp));
    }

    function hasAcknowledged(bytes32 personId) external view returns (bool) {
        return acknowledgmentHash[personId] != bytes32(0);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // STANDING ACCESS → PERMANENT SECTION
    //
    // Register a wallet here at the moment it is given multisig or upgrade
    // authority, not at the moment somebody notices. The permanent section is
    // then re-anchored to match. The `PermanentSectionStale` check exists
    // because these two steps drift: keys get rotated by engineers on a
    // release, and the insider list gets updated by compliance on a quarter.
    // ═══════════════════════════════════════════════════════════════════════

    function registerStandingAccess(address wallet, bytes32 personId, bytes32 reasonRef) external onlyIssuer {
        StandingAccess storage s = standingAccess[wallet];
        if (s.registeredAt == 0) _standingAccessWallets.push(wallet);

        s.personId = personId;
        s.reasonRef = reasonRef;
        s.registeredAt = uint64(block.timestamp);
        s.removedAt = 0;

        emit StandingAccessRegistered(wallet, personId, reasonRef);
    }

    function removeStandingAccess(address wallet) external onlyIssuer {
        StandingAccess storage s = standingAccess[wallet];
        if (s.registeredAt == 0) revert NotRegistered(wallet);

        s.removedAt = uint64(block.timestamp);
        emit StandingAccessRemoved(wallet, s.personId, s.removedAt);
    }

    /// @notice True where a live standing-access wallet was registered after the permanent
    ///         section was last anchored — the filed list is behind the ledger.
    function isPermanentSectionStale(address wallet) public view returns (bool) {
        StandingAccess storage s = standingAccess[wallet];
        if (s.registeredAt == 0 || s.removedAt != 0) return false;

        uint256 latest = latestVersionOf[_sectionKey(Section.Permanent, bytes32(0))];
        ListVersion storage v = versions[latest];
        if (v.anchoredAt == 0) return true; // no permanent section anchored at all
        return v.anchoredAt < s.registeredAt;
    }

    /// @notice Keeper entry point — emits the alert for any stale wallet. Bounded by the
    ///         number of privileged keys, which is a number the governance design already
    ///         keeps small for unrelated reasons.
    function sweepPermanentSection() external {
        uint256 latest = latestVersionOf[_sectionKey(Section.Permanent, bytes32(0))];
        uint64 lastAnchoredAt = versions[latest].anchoredAt;

        uint256 n = _standingAccessWallets.length;
        for (uint256 i = 0; i < n; ++i) {
            address wallet = _standingAccessWallets[i];
            if (isPermanentSectionStale(wallet)) {
                emit PermanentSectionStale(wallet, standingAccess[wallet].registeredAt, lastAnchoredAt);
            }
        }
    }

    function standingAccessWallets() external view returns (address[] memory) {
        return _standingAccessWallets;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // INTERNALS
    // ═══════════════════════════════════════════════════════════════════════

    function _sectionKey(Section section, bytes32 eventRef) internal pure returns (bytes32) {
        return keccak256(abi.encode(section, eventRef));
    }
}
