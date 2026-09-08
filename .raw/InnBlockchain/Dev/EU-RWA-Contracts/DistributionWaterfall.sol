// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {IDistributionSink, Distribution} from "./Interfaces.sol";

/// @title DistributionWaterfall (illustrative sample — not production code)
/// @notice C4 — splits a defined income stream between tranches in contractual priority order.
///         Revenue-participation tokens, and any structure where one class is paid before
///         another.
/// @dev    ⚠️ LIKE `CouponSchedule`, THIS DISCHARGES NO NUMBERED ARTICLE. A waterfall is a
///         commercial term. Its compliance surface is entirely inherited: it feeds
///         `DistributionAgent`, and therefore sits behind the same C1 eligibility gate and the
///         same AMLR Art 76 silence. It computes; it never pays.
/// @dev    ⚠️ A TRANCHE IS A PARTITION (C6), AND C6 IS UNRESOLVED AT §16 D0. Under ERC-1400
///         tranches come from ERC-1410 and one token carries them all; under ERC-3643 the
///         usual shape is a separate token per class. This contract is written to the second —
///         each tranche names its own `DistributionAgent` distribution — because that form
///         works under either binding, where the partitioned form does not. If D0 resolves to
///         ERC-1400, this is the file to revisit first.
/// @dev    ⚠️ THE ORDER IS IMMUTABLE AFTER ISSUANCE, AND FOR THE SAME REASON THE COUPON TERMS
///         ARE. Priority ordering is the substance of what a junior holder bought. Reordering
///         steps is not a configuration change, it is an expropriation, and under Prospectus
///         Arts 6/16(1) it is a disclosed characteristic — a change would need an Art 23
///         supplement and a withdrawal window. Hence a constructor and no setter.
/// @dev    ⚠️ A BLOCKED SENIOR HOLDER MUST NOT ENRICH A JUNIOR TRANCHE. Allocation happens
///         here, at the TRANCHE level, before any holder is looked at. If a senior holder is
///         frozen, their share becomes an unclaimed balance inside `DistributionAgent` and
///         stays owed to them; it does not flow down the waterfall. A design that allocated
///         only to payable holders would quietly transfer value from a sanctioned investor to
///         the junior class, which is neither what the terms say nor a defensible thing to
///         have built.
contract DistributionWaterfall {
    /// @dev Emitted whenever an inter-contract reference is re-pointed.
    event DependencySet(bytes32 indexed role, address indexed impl);

    // ═══════════════════════════════════════════════════════════════════════
    // TYPES
    // ═══════════════════════════════════════════════════════════════════════

    enum StepType {
        Unset,
        /// @dev A rate on the tranche's outstanding capital, accruing with time. Unpaid amounts
        ///      become arrears and are carried, not forgiven — see `_accrue`.
        PreferredReturn,
        /// @dev Repayment of contributed capital, up to whatever remains outstanding.
        ReturnOfCapital,
        /// @dev A fixed share of whatever is still unallocated when this step is reached.
        ResidualShare
    }

    struct Tranche {
        bytes32 trancheId;
        /// @dev Contributed capital, in wei. Fixed at construction: it is what the class paid.
        uint256 contributedCapital;
        /// @dev Reduced by `ReturnOfCapital` steps. Drives `PreferredReturn` accrual, so
        ///      returning capital correctly reduces the preferred return owed thereafter.
        uint256 outstandingCapital;
        /// @dev Accrued-but-unpaid preferred return.
        uint256 arrears;
        uint64 lastAccrualAt;
        uint256 lifetimeAllocated;
    }

    struct Step {
        StepType stepType;
        uint16 trancheIndex;
        /// @dev PreferredReturn → annual rate in bps. ResidualShare → share in bps.
        ///      ReturnOfCapital → unused.
        uint16 bps;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // WIRING
    // ═══════════════════════════════════════════════════════════════════════

    address public immutable governance;
        /// @dev ⚠️ Concrete type retained DELIBERATELY, and it is a known gap. This dependency
    ///      returns a struct/enum, which a narrow interface cannot declare without
    ///      duplicating the type — and a duplicated struct is a DIFFERENT type to the
    ///      compiler, so every call site here would break. Closing it means moving the
    ///      shared types into `Interfaces.sol` and having the concrete contract import
    ///      them from there. Until then the `immutable` half of the rule is satisfied
    ///      (settable below) and the coupling half is not.
    IDistributionSink public distributions;

    mapping(address => bool) public isAgent;

    uint16 public constant BPS = 10_000;

    /// @notice ⚠️ Each step is an iteration on a path that must terminate cheaply, and a
    ///         waterfall long enough to hit this is one nobody can reason about anyway.
    uint256 public constant MAX_STEPS = 16;
    uint256 public constant MAX_TRANCHES = 8;

    // ═══════════════════════════════════════════════════════════════════════
    // STATE
    // ═══════════════════════════════════════════════════════════════════════

    Tranche[] private _tranches;
    Step[] private _steps;

    /// @notice Per-allocation record of what each tranche was awarded, keyed by allocation id.
    uint256 public nextAllocationId = 1;
    mapping(uint256 => mapping(uint256 => uint256)) public allocatedTo;
    /// @dev Tranche index → the `DistributionAgent` distribution carrying this allocation.
    mapping(uint256 => mapping(uint256 => uint256)) public distributionFor;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS
    // ═══════════════════════════════════════════════════════════════════════

    event AgentSet(address indexed agent, bool allowed);
    event WaterfallPublished(uint256 tranches, uint256 steps, uint16 residualBpsTotal);
    event IncomeAllocated(uint256 indexed allocationId, uint256 amount, uint256 unallocatedRemainder);
    event TrancheAllocated(uint256 indexed allocationId, uint256 indexed trancheIndex, bytes32 trancheId, uint256 amount);
    event TrancheDistributionBound(uint256 indexed allocationId, uint256 indexed trancheIndex, uint256 distributionId);
    event ArrearsCarried(uint256 indexed trancheIndex, uint256 arrears);
    event CapitalReturned(uint256 indexed trancheIndex, uint256 amount, uint256 outstandingCapital);

    // ═══════════════════════════════════════════════════════════════════════
    // ERRORS
    // ═══════════════════════════════════════════════════════════════════════

    error NotGovernance();
    error NotAgent();
    error NoTranches();
    error NoSteps();
    error TooManyTranches();
    error TooManySteps();
    error StepTypeUnset(uint256 stepIndex);
    error UnknownTranche(uint256 trancheIndex);
    error BpsOutOfRange(uint256 stepIndex, uint16 bps);
    /// @dev See `_validateResidual`.
    error ResidualSharesMustSumToFull(uint16 total);
    error NoResidualStep();
    error ZeroAmount();
    error UnknownAllocation(uint256 allocationId);
    error NothingAllocated(uint256 allocationId, uint256 trancheIndex);
    error DistributionAlreadyBound(uint256 allocationId, uint256 trancheIndex);
    error DistributionAmountMismatch(uint256 expected, uint256 actual);

    /// @dev ⚠️ Used by the dependency setter but never declared, so this file did not compile.
    ///      Guards the "swap, never unset" rule — an unset reference reads as "not owed" and
    ///      turns a control off silently.
    error ZeroAddress();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyAgent() {
        if (!isAgent[msg.sender]) revert NotAgent();
        _;
    }

    constructor(
        address governance_,
        address distributions_,
        bytes32[] memory trancheIds,
        uint256[] memory contributedCapital,
        Step[] memory steps
    ) {
        if (trancheIds.length == 0) revert NoTranches();
        if (trancheIds.length > MAX_TRANCHES) revert TooManyTranches();
        if (steps.length == 0) revert NoSteps();
        if (steps.length > MAX_STEPS) revert TooManySteps();

        governance = governance_;
        distributions = IDistributionSink(distributions_);

        for (uint256 i = 0; i < trancheIds.length; i++) {
            _tranches.push(
                Tranche({
                    trancheId: trancheIds[i],
                    contributedCapital: contributedCapital[i],
                    outstandingCapital: contributedCapital[i],
                    arrears: 0,
                    lastAccrualAt: uint64(block.timestamp),
                    lifetimeAllocated: 0
                })
            );
        }

        uint16 residualTotal;
        for (uint256 i = 0; i < steps.length; i++) {
            Step memory s = steps[i];
            if (s.stepType == StepType.Unset) revert StepTypeUnset(i);
            if (s.trancheIndex >= _tranches.length) revert UnknownTranche(s.trancheIndex);
            if (s.bps > BPS) revert BpsOutOfRange(i, s.bps);
            if (s.stepType == StepType.ResidualShare) residualTotal += s.bps;
            _steps.push(s);
        }

        _validateResidual(residualTotal);
        emit WaterfallPublished(_tranches.length, _steps.length, residualTotal);
    }

    /// @dev ⚠️ THE RESIDUAL SHARES MUST SUM TO EXACTLY 100%, AND THERE MUST BE AT LEAST ONE.
    ///      This is the check that stops value stranding. A waterfall whose residual steps sum
    ///      to 90% leaves a tenth of every distribution allocated to nobody, sitting in a
    ///      contract with no claimant and no mechanism to release it — and it will not be
    ///      noticed until the first distribution, by which time the terms are published. Over
    ///      100% is worse: the last tranche in line silently receives less than its stated
    ///      share, every time, and the arithmetic looks fine.
    function _validateResidual(uint16 total) private pure {
        if (total == 0) revert NoResidualStep();
        if (total != BPS) revert ResidualSharesMustSumToFull(total);
    }

    function setAgent(address agent, bool allowed) external onlyGovernance {
        isAgent[agent] = allowed;
        emit AgentSet(agent, allowed);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ACCRUAL
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev ⚠️ ARREARS ARE CARRIED, NOT FORGIVEN. A preferred return that goes unpaid because a
    ///      period produced no income remains owed and is paid ahead of everything junior at
    ///      the next distribution. A waterfall that computes preferred return only on the
    ///      current period silently writes off the shortfall — and does so in favour of the
    ///      junior class, which is usually the sponsor.
    /// @dev    ⚠️ SIMPLE ACCRUAL, NOT COMPOUNDING. Whether unpaid preferred return itself earns
    ///         a return is a term, and a consequential one. The terms document governs; this
    ///         models the simple case and does not silently choose the other.
    function _accrue(uint256 trancheIndex, uint16 rateBps) private {
        Tranche storage t = _tranches[trancheIndex];
        uint64 nowTs = uint64(block.timestamp);
        if (nowTs <= t.lastAccrualAt) return;

        uint256 elapsed = uint256(nowTs - t.lastAccrualAt);
        uint256 accrued = (t.outstandingCapital * rateBps * elapsed) / (uint256(BPS) * 365 days);

        t.arrears += accrued;
        t.lastAccrualAt = nowTs;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ALLOCATION
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Runs the waterfall over `amount` and records what each tranche is owed.
    /// @dev    State-advancing: it accrues preferred return, consumes arrears and reduces
    ///         outstanding capital. `previewAllocation` is the read-only twin for a desk that
    ///         wants the numbers before committing.
    function allocate(uint256 amount) external onlyAgent returns (uint256 allocationId) {
        if (amount == 0) revert ZeroAmount();

        allocationId = nextAllocationId++;
        uint256 remaining = amount;

        // Two passes over the step list. The first pays the contractual claims in priority
        // order; the second splits whatever is left. They are separate because a residual
        // share must be computed on what survives ALL the priority claims — computing it
        // inline, as each step is reached, would give an earlier residual step a share of
        // money a later preferred return is still entitled to.
        for (uint256 i = 0; i < _steps.length; i++) {
            Step storage s = _steps[i];
            if (s.stepType == StepType.ResidualShare) continue;
            if (remaining == 0) break;

            uint256 paid;

            if (s.stepType == StepType.PreferredReturn) {
                _accrue(s.trancheIndex, s.bps);
                Tranche storage t = _tranches[s.trancheIndex];
                paid = t.arrears > remaining ? remaining : t.arrears;
                t.arrears -= paid;
                if (t.arrears > 0) emit ArrearsCarried(s.trancheIndex, t.arrears);
            } else {
                Tranche storage t = _tranches[s.trancheIndex];
                paid = t.outstandingCapital > remaining ? remaining : t.outstandingCapital;
                t.outstandingCapital -= paid;
                if (paid > 0) emit CapitalReturned(s.trancheIndex, paid, t.outstandingCapital);
            }

            if (paid > 0) {
                remaining -= paid;
                _award(allocationId, s.trancheIndex, paid);
            }
        }

        // ── residual ─────────────────────────────────────────────────────
        uint256 residualPool = remaining;
        uint256 lastResidualStep = type(uint256).max;
        for (uint256 i = 0; i < _steps.length; i++) {
            if (_steps[i].stepType == StepType.ResidualShare) lastResidualStep = i;
        }

        for (uint256 i = 0; i < _steps.length; i++) {
            Step storage s = _steps[i];
            if (s.stepType != StepType.ResidualShare) continue;

            // ⚠️ The LAST residual step sweeps whatever integer division left behind, rather
            //    than taking its own computed share. Shares summing to exactly 100% still
            //    truncate on division; without this, a few wei per distribution accumulate in
            //    a contract with no claimant. Giving the remainder to the most junior claim is
            //    a choice — it is where a shortfall would land anyway — and it is stated here
            //    rather than left as an emergent property of the rounding.
            uint256 share = i == lastResidualStep ? remaining : (residualPool * s.bps) / BPS;
            if (share > remaining) share = remaining;
            if (share == 0) continue;

            remaining -= share;
            _award(allocationId, s.trancheIndex, share);
        }

        emit IncomeAllocated(allocationId, amount, remaining);
    }

    function _award(uint256 allocationId, uint256 trancheIndex, uint256 amount) private {
        allocatedTo[allocationId][trancheIndex] += amount;
        _tranches[trancheIndex].lifetimeAllocated += amount;
        emit TrancheAllocated(allocationId, trancheIndex, _tranches[trancheIndex].trancheId, amount);
    }

    /// @notice Binds a tranche's allocation to the `DistributionAgent` distribution that will
    ///         pay it out to that tranche's holders.
    /// @dev    ⚠️ THE AMOUNT IS RECONCILED, NOT TRUSTED. The agent funds and opens the
    ///         distribution separately, so nothing stops it funding a different figure. This
    ///         compares the waterfall's allocation against `totalUnits × ratePerUnit` on the
    ///         declared distribution — the one point where the two contracts' arithmetic can
    ///         be shown to agree. Without it, the waterfall is a spreadsheet nobody checks.
    function bindDistribution(uint256 allocationId, uint256 trancheIndex, uint256 distributionId) external onlyAgent {
        if (allocationId == 0 || allocationId >= nextAllocationId) revert UnknownAllocation(allocationId);
        if (trancheIndex >= _tranches.length) revert UnknownTranche(trancheIndex);

        uint256 owed = allocatedTo[allocationId][trancheIndex];
        if (owed == 0) revert NothingAllocated(allocationId, trancheIndex);
        if (distributionFor[allocationId][trancheIndex] != 0) {
            revert DistributionAlreadyBound(allocationId, trancheIndex);
        }

        Distribution memory d = distributions.distribution(distributionId);
        uint256 declared = d.totalUnits * d.ratePerUnit;
        if (declared != owed) revert DistributionAmountMismatch(owed, declared);

        distributionFor[allocationId][trancheIndex] = distributionId;
        emit TrancheDistributionBound(allocationId, trancheIndex, distributionId);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice What `allocate(amount)` would produce, without changing anything.
    /// @dev    Mirrors the allocation logic on local copies. ⚠️ Two implementations of the same
    ///         arithmetic is a divergence risk, and the honest mitigation is a differential
    ///         test that runs both over the same inputs — not a comment asking the reader to
    ///         keep them in step.
    function previewAllocation(uint256 amount) external view returns (uint256[] memory perTranche, uint256 unallocated) {
        perTranche = new uint256[](_tranches.length);
        uint256 remaining = amount;

        uint256[] memory arrears = new uint256[](_tranches.length);
        uint256[] memory capital = new uint256[](_tranches.length);
        for (uint256 i = 0; i < _tranches.length; i++) {
            arrears[i] = _tranches[i].arrears;
            capital[i] = _tranches[i].outstandingCapital;
        }

        for (uint256 i = 0; i < _steps.length; i++) {
            Step storage s = _steps[i];
            if (s.stepType == StepType.ResidualShare || remaining == 0) continue;

            uint256 paid;
            if (s.stepType == StepType.PreferredReturn) {
                Tranche storage t = _tranches[s.trancheIndex];
                uint256 elapsed = block.timestamp > t.lastAccrualAt ? block.timestamp - t.lastAccrualAt : 0;
                uint256 projected = arrears[s.trancheIndex]
                    + (capital[s.trancheIndex] * s.bps * elapsed) / (uint256(BPS) * 365 days);
                paid = projected > remaining ? remaining : projected;
                arrears[s.trancheIndex] = projected - paid;
            } else {
                paid = capital[s.trancheIndex] > remaining ? remaining : capital[s.trancheIndex];
                capital[s.trancheIndex] -= paid;
            }

            remaining -= paid;
            perTranche[s.trancheIndex] += paid;
        }

        uint256 residualPool = remaining;
        uint256 lastResidualStep = type(uint256).max;
        for (uint256 i = 0; i < _steps.length; i++) {
            if (_steps[i].stepType == StepType.ResidualShare) lastResidualStep = i;
        }

        for (uint256 i = 0; i < _steps.length; i++) {
            Step storage s = _steps[i];
            if (s.stepType != StepType.ResidualShare) continue;

            uint256 share = i == lastResidualStep ? remaining : (residualPool * s.bps) / BPS;
            if (share > remaining) share = remaining;
            remaining -= share;
            perTranche[s.trancheIndex] += share;
        }

        unallocated = remaining;
    }

    function trancheCount() external view returns (uint256) {
        return _tranches.length;
    }

    function trancheAt(uint256 index) external view returns (Tranche memory) {
        return _tranches[index];
    }

    function stepCount() external view returns (uint256) {
        return _steps.length;
    }

    function stepAt(uint256 index) external view returns (Step memory) {
        return _steps[index];
    }

    /// @notice Total arrears across every tranche, accrued to now. ⚠️ A rising number here is
    ///         the structure not paying its senior claims — visible before it becomes a
    ///         disclosure question.
    function totalArrears() external view returns (uint256 total) {
        for (uint256 i = 0; i < _steps.length; i++) {
            Step storage s = _steps[i];
            if (s.stepType != StepType.PreferredReturn) continue;

            Tranche storage t = _tranches[s.trancheIndex];
            uint256 elapsed = block.timestamp > t.lastAccrualAt ? block.timestamp - t.lastAccrualAt : 0;
            total += t.arrears + (t.outstandingCapital * s.bps * elapsed) / (uint256(BPS) * 365 days);
        }
    }

    /// @notice Re-point `distributions`. Swap, never unset — the operational-resilience regime requires
    ///         this reference stay swappable at the contract layer rather than hard-wired.
    function setDistributions(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        distributions = IDistributionSink(impl);
        emit DependencySet("distributions", impl);
    }
}
