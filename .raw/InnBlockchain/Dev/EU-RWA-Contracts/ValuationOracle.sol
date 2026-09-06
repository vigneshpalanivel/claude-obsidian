// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @title ValuationOracle (illustrative sample — not production code)
/// @notice The NAV / price feed every quantitative limit in this folder divides by.
///         §5 calls it "the #1 engineering risk" and §17's critical path calls it the
///         tightest dependency in the build: `NavBorrowingCap`, `UcitsFiveTenForty`,
///         `EltifConcentration` and `LmtGate` all compute a ratio whose denominator or
///         numerator arrives from here, and `DltPilotCapGate` runs the same freshness
///         semantics on its own Art 3(4) aggregate register.
/// @dev    ⚠️ ABSOLUTE VALUES, NEVER DELTAS. Earlier revisions of the fund modules took
///         `recordValuation(int256 delta)` from a privileged valuator. A delta feed has a
///         failure mode an absolute feed does not: a stale absolute value self-heals on the
///         next post, but a MISSED DELTA never does — the running figure is permanently
///         wrong from that point on and no later post can detect it. Nothing on-chain can
///         tell a correct book from a book that dropped one message six months ago.
/// @dev    ⚠️ A STALE FEED IS NOT A ZERO AND NOT THE LAST VALUE. §5: "oracle failure must
///         HALT issuance/redemption, not pass a stale limit." That is what `value()` is
///         for — it reverts rather than returning a figure it cannot vouch for. `peek()`
///         exists alongside it because §9's per-consumer rule is real: a passive
///         mark-to-market recheck should skip, not block, and blocking a PDMR transfer on
///         a stale price over-enforces MAR Art 19(11) into territory Art 19(12) exists to
///         relieve. Pick the read that matches the consumer, not one global policy.
/// @dev    ⚠️ THE DEVIATION GUARD DOES NOT PUBLISH AND DOES NOT PRETEND. On a move larger
///         than the configured band the feed HALTS: the last verified value stays readable
///         through `peek()`, but `acceptedAt` does not advance, so freshness decays and
///         every fail-closed consumer stops on schedule. The alternative designs are both
///         worse — publishing the suspicious figure propagates a bad valuation into a
///         breach check, and freezing the old figure as though it were current is exactly
///         the "silently passes a stale limit" case the design document names.
/// @dev    ⚠️ AIFMD Art 19 IS THE THING THIS CONTRACT DOES NOT DO. The valuation
///         METHODOLOGY is a documented, independently-reviewed procedure off-chain. This
///         contract records what that procedure output, when, and from how many sources.
///         If the methodology is undocumented, every limit downstream rests on an
///         unauditable input and no amount of on-chain plumbing fixes it.
contract ValuationOracle {
    // ─────────────────────────── limits ──────────────────────────────────────

    /// @dev Bounded because acceptance sorts the fresh posts in memory on every write.
    uint256 public constant MAX_SOURCES = 7;

    uint256 public constant BPS_DENOM = 10000;

    // ─────────────────────────── roles ───────────────────────────────────────

    address public immutable governance;

    address[] private _sources;
    mapping(address => bool) public isSource;

    // ─────────────────────────── feeds ───────────────────────────────────────

    /// @notice One feed per valued thing. `assetId` is whatever the consumer keys on: a
    ///         fund's NAV identity for `NavBorrowingCap` / `LmtGate`, an individual asset
    ///         for `EltifConcentration`'s per-asset 20% check, an issuer or counterparty
    ///         leg for `UcitsFiveTenForty`.
    struct Feed {
        bool configured;
        /// @dev Halted by the deviation guard. Clearing it is a governance act with a
        ///      justification reference, because a 40% single-day move is either a market
        ///      event someone can point at or a broken feed, and the ledger should show
        ///      which one the operator decided it was.
        bool halted;
        /// @dev Beyond this age the feed is unknown. There is no sensible universal
        ///      default — a daily-struck fund NAV and an intraday price are different
        ///      instruments — so configuration is mandatory before a feed can be read.
        uint64 maxAgeSeconds;
        /// @dev Minimum number of fresh source posts before a value is accepted at all.
        ///      1 is legitimate for a single-administrator fund; §5's multi-source
        ///      requirement is met by raising it, not by a separate mechanism.
        uint8 quorum;
        /// @dev Move, against the last accepted value, beyond which acceptance halts.
        ///      0 disables the guard — allowed, and noted in `FeedConfigured`, because a
        ///      genuinely volatile feed with a tight band halts permanently.
        uint16 maxDeviationBps;
        uint256 value;
        uint64 acceptedAt;
        /// @dev How many sources agreed on the accepted figure. Carried because a value
        ///      that met a quorum of 3 and one that met a quorum of 1 are not equally
        ///      good evidence, and only the reader knows whether that matters.
        uint8 acceptedSourceCount;
    }

    mapping(bytes32 => Feed) private _feeds;
    bytes32[] private _feedIds;

    struct Post {
        uint256 value;
        uint64 postedAt;
    }

    mapping(bytes32 => mapping(address => Post)) private _posts;

    // ─────────────────────────── events ──────────────────────────────────────

    event SourceAdded(address indexed source);
    event SourceRemoved(address indexed source);
    event FeedConfigured(
        bytes32 indexed assetId,
        uint64 maxAgeSeconds,
        uint8 quorum,
        uint16 maxDeviationBps
    );
    event ValuationPosted(bytes32 indexed assetId, address indexed source, uint256 value, uint64 postedAt);
    event ValuationAccepted(bytes32 indexed assetId, uint256 value, uint8 sourceCount, uint64 acceptedAt);
    /// @dev Not an alert an operator can ignore: while this is latched the feed goes stale
    ///      and every fail-closed consumer stops.
    event DeviationGuardTripped(bytes32 indexed assetId, uint256 lastAccepted, uint256 proposed, uint16 bandBps);
    event HaltCleared(bytes32 indexed assetId, uint256 confirmedValue, bytes32 justificationRef);
    /// @dev Emitted on a post that could not be accepted for want of fresh agreeing
    ///      sources. Distinct from the deviation trip: nothing is wrong with the number,
    ///      there are just not enough of them yet.
    event QuorumNotMet(bytes32 indexed assetId, uint8 freshCount, uint8 quorum);

    // ─────────────────────────── errors ──────────────────────────────────────

    error NotGovernance();
    error NotSource();
    error TooManySources();
    error AlreadySource(address source);
    error UnknownSource(address source);
    error FeedNotConfigured(bytes32 assetId);
    error QuorumBelowOne();
    error QuorumExceedsSources(uint8 quorum, uint256 sourceCount);
    error MaxAgeMustBeNonZero();
    /// @dev Carries the age so a caller can tell "never posted" (acceptedAt 0) from
    ///      "posted and lapsed" without a second call.
    error StaleValuation(bytes32 assetId, uint64 acceptedAt, uint64 maxAgeSeconds);
    error FeedHalted(bytes32 assetId);
    error FeedNotHalted(bytes32 assetId);
    error ConfirmationMustMatchLastAccepted(uint256 supplied, uint256 lastAccepted);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_) {
        governance = governance_;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // SOURCES
    //
    // Removing a source does not delete its posts — they simply stop counting.
    // Deleting history would erase the record of what was fed and when, which is
    // the only thing that makes a bad valuation attributable after the fact.
    // ═══════════════════════════════════════════════════════════════════════

    function addSource(address source) external onlyGovernance {
        if (isSource[source]) revert AlreadySource(source);
        if (_sources.length >= MAX_SOURCES) revert TooManySources();
        isSource[source] = true;
        _sources.push(source);
        emit SourceAdded(source);
    }

    function removeSource(address source) external onlyGovernance {
        if (!isSource[source]) revert UnknownSource(source);
        isSource[source] = false;
        for (uint256 i = 0; i < _sources.length; i++) {
            if (_sources[i] == source) {
                _sources[i] = _sources[_sources.length - 1];
                _sources.pop();
                break;
            }
        }
        emit SourceRemoved(source);
    }

    function sources() external view returns (address[] memory) {
        return _sources;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // FEED CONFIGURATION
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Configuring an existing feed leaves its accepted value and timestamp alone —
    ///         tightening `maxAgeSeconds` can therefore make a currently-fresh feed stale
    ///         in the same transaction. That is the intended direction of travel: the new
    ///         policy applies to the value already on the books, not only to the next one.
    function configureFeed(
        bytes32 assetId,
        uint64 maxAgeSeconds,
        uint8 quorum,
        uint16 maxDeviationBps
    ) external onlyGovernance {
        if (maxAgeSeconds == 0) revert MaxAgeMustBeNonZero();
        if (quorum == 0) revert QuorumBelowOne();
        if (quorum > _sources.length) revert QuorumExceedsSources(quorum, _sources.length);

        Feed storage f = _feeds[assetId];
        if (!f.configured) {
            f.configured = true;
            _feedIds.push(assetId);
        }
        f.maxAgeSeconds = maxAgeSeconds;
        f.quorum = quorum;
        f.maxDeviationBps = maxDeviationBps;

        emit FeedConfigured(assetId, maxAgeSeconds, quorum, maxDeviationBps);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // POSTING
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Post this source's current absolute valuation for `assetId`. Acceptance is
    ///         attempted immediately: the median of every source post still inside
    ///         `maxAgeSeconds` is taken, and adopted if the quorum is met and the deviation
    ///         guard passes.
    /// @dev    Median rather than mean, because the failure this is guarding against is one
    ///         source going wrong, and a mean lets a single absurd figure drag the accepted
    ///         value with it. With quorum 1 the median is that one source and the deviation
    ///         guard is the only remaining defence — which is the honest trade-off of a
    ///         single-administrator deployment, not a gap in this contract.
    function postValuation(bytes32 assetId, uint256 absoluteValue) external {
        if (!isSource[msg.sender]) revert NotSource();
        Feed storage f = _feeds[assetId];
        if (!f.configured) revert FeedNotConfigured(assetId);

        _posts[assetId][msg.sender] = Post({value: absoluteValue, postedAt: uint64(block.timestamp)});
        emit ValuationPosted(assetId, msg.sender, absoluteValue, uint64(block.timestamp));

        if (f.halted) return; // Clearing the halt is a governance act, not a side effect of the next post.
        _tryAccept(assetId, f);
    }

    function _tryAccept(bytes32 assetId, Feed storage f) private {
        (uint256[] memory fresh, uint8 count) = _freshPosts(assetId, f.maxAgeSeconds);

        if (count < f.quorum) {
            emit QuorumNotMet(assetId, count, f.quorum);
            return;
        }

        uint256 candidate = _median(fresh, count);

        if (f.acceptedAt != 0 && f.maxDeviationBps != 0 && f.value != 0) {
            uint256 diff = candidate > f.value ? candidate - f.value : f.value - candidate;
            if ((diff * BPS_DENOM) / f.value > f.maxDeviationBps) {
                f.halted = true;
                emit DeviationGuardTripped(assetId, f.value, candidate, f.maxDeviationBps);
                return;
            }
        }

        f.value = candidate;
        f.acceptedAt = uint64(block.timestamp);
        f.acceptedSourceCount = count;
        emit ValuationAccepted(assetId, candidate, count, f.acceptedAt);
    }

    function _freshPosts(bytes32 assetId, uint64 maxAgeSeconds)
        private
        view
        returns (uint256[] memory fresh, uint8 count)
    {
        fresh = new uint256[](_sources.length);
        for (uint256 i = 0; i < _sources.length; i++) {
            Post storage p = _posts[assetId][_sources[i]];
            if (p.postedAt != 0 && block.timestamp <= p.postedAt + maxAgeSeconds) {
                fresh[count] = p.value;
                count++;
            }
        }
    }

    /// @dev Insertion sort over at most `MAX_SOURCES` entries. Even-count medians take the
    ///      lower of the two middles rather than averaging them — averaging invents a figure
    ///      no source posted, and "the valuation came from somewhere" is worth more here
    ///      than a half-unit of precision.
    function _median(uint256[] memory values, uint8 count) private pure returns (uint256) {
        for (uint256 i = 1; i < count; i++) {
            uint256 key = values[i];
            uint256 j = i;
            while (j > 0 && values[j - 1] > key) {
                values[j] = values[j - 1];
                j--;
            }
            values[j] = key;
        }
        return values[(count - 1) / 2];
    }

    // ═══════════════════════════════════════════════════════════════════════
    // HALT HANDLING
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Clear a tripped deviation guard by confirming the last accepted value is
    ///         still the right one — a "the feed was wrong, the book is fine" decision.
    ///         Freshness restarts from now, so downstream consumers resume.
    /// @param  confirmedValue    Must equal the last accepted value. This is a confirmation,
    ///                           not a write path: governance cannot set a price here.
    /// @param  justificationRef  Off-chain record of the determination.
    /// @dev    To adopt the NEW figure instead, leave the halt in place, widen the band with
    ///         `configureFeed`, and let the sources post again. That path leaves a
    ///         `FeedConfigured` event showing the band was widened to admit the move, which
    ///         is the record an auditor needs; clearing the halt straight onto the new number
    ///         would leave none.
    function clearHalt(bytes32 assetId, uint256 confirmedValue, bytes32 justificationRef)
        external
        onlyGovernance
    {
        Feed storage f = _feeds[assetId];
        if (!f.configured) revert FeedNotConfigured(assetId);
        if (!f.halted) revert FeedNotHalted(assetId);
        if (confirmedValue != f.value) revert ConfirmationMustMatchLastAccepted(confirmedValue, f.value);

        f.halted = false;
        f.acceptedAt = uint64(block.timestamp);
        emit HaltCleared(assetId, f.value, justificationRef);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS — two of them, on purpose.
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Fail-closed read. Use on any path that mints, redeems, admits, or otherwise
    ///         lets value move on the strength of the number: issuance and redemption HALT
    ///         on oracle failure rather than transacting against a figure nobody can vouch
    ///         for.
    function value(bytes32 assetId) external view returns (uint256) {
        Feed storage f = _feeds[assetId];
        if (!f.configured) revert FeedNotConfigured(assetId);
        if (f.halted) revert FeedHalted(assetId);
        if (f.acceptedAt == 0 || block.timestamp > f.acceptedAt + f.maxAgeSeconds) {
            revert StaleValuation(assetId, f.acceptedAt, f.maxAgeSeconds);
        }
        return f.value;
    }

    /// @notice Never-reverts read. Use on passive paths — a mark-to-market recheck that only
    ///         flags, a monitoring view, an alerting consumer that must not be able to brick
    ///         an unrelated transfer. The caller is expected to branch on `fresh`; ignoring
    ///         it and using the value anyway reintroduces exactly the stale-limit failure
    ///         this contract exists to stop.
    function peek(bytes32 assetId)
        external
        view
        returns (uint256 lastValue, uint64 acceptedAt, bool fresh, bool halted)
    {
        Feed storage f = _feeds[assetId];
        return (f.value, f.acceptedAt, _isFresh(f), f.halted);
    }

    function isFresh(bytes32 assetId) external view returns (bool) {
        return _isFresh(_feeds[assetId]);
    }

    function _isFresh(Feed storage f) private view returns (bool) {
        return
            f.configured &&
            !f.halted &&
            f.acceptedAt != 0 &&
            block.timestamp <= f.acceptedAt + f.maxAgeSeconds;
    }

    function feed(bytes32 assetId) external view returns (Feed memory) {
        return _feeds[assetId];
    }

    function feedIds() external view returns (bytes32[] memory) {
        return _feedIds;
    }

    function postOf(bytes32 assetId, address source) external view returns (Post memory) {
        return _posts[assetId][source];
    }

    /// @notice Operational read for a monitoring job: which configured feeds are not
    ///         currently usable by a fail-closed consumer. A non-empty answer means some
    ///         issuance or redemption path is halted right now.
    function unusableFeeds() external view returns (bytes32[] memory unusable) {
        uint256 n;
        for (uint256 i = 0; i < _feedIds.length; i++) {
            if (!_isFresh(_feeds[_feedIds[i]])) n++;
        }
        unusable = new bytes32[](n);
        uint256 k;
        for (uint256 i = 0; i < _feedIds.length; i++) {
            if (!_isFresh(_feeds[_feedIds[i]])) {
                unusable[k] = _feedIds[i];
                k++;
            }
        }
    }
}
