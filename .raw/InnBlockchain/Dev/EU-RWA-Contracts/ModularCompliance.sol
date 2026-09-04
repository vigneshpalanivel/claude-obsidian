// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

/// @notice The shape every rule module must present to the compliance stack. Deliberately
///         two functions with different mutability: `checkTransfer` is the pre-trade veto
///         and must be `view` so it can be called from an off-chain simulation and from a
///         UI without a transaction; `notifyTransfer` is the post-trade bookkeeping call for
///         modules that maintain counters (concentration ratios, cap registers, holding
///         clocks). A module that needs neither implements the one it needs and leaves the
///         other empty — but it must present both, because the stack calls both.
interface IComplianceModule {
    function checkTransfer(address from, address to, uint256 amount) external view;

    function notifyTransfer(address from, address to, uint256 amount) external;

    function moduleId() external view returns (bytes32);
}

/// @title ModularCompliance (illustrative sample — not production code)
/// @notice C4 — the single hook the token calls on every movement, fanning out to the
///         Article-mapped rule modules bound to this instrument. The token knows nothing
///         about ELTIF concentration or DLT Pilot member conditions; it knows one address.
/// @dev    The point of the indirection is that the regulatory surface changes on a
///         different clock from the token. Adding a module is a governance action; changing
///         the token is a re-issuance and, where a prospectus is in force, an Art 23
///         supplement with a withdrawal window. Anything that can be a module should be.
/// @dev    ⚠️ Two failure modes this sample takes seriously, because both are live:
///         (1) GAS. Every module is an external call on every transfer. `MAX_MODULES` is a
///             hard cap, and it is low. An unbounded module list is a denial-of-service
///             surface on the token itself, and the party who suffers is the holder trying
///             to exit.
///         (2) MODULE FAILURE. A module that reverts blocks all transfers. That is correct
///             for a compliance veto and catastrophic for a bug, so `emergencyBypass` exists
///             — under governance, one module at a time, logged, and never silent. It is a
///             deliberate compliance breach with an audit trail, which is the honest shape
///             for this decision. Pretending the case cannot arise is what produces the
///             unlogged private-key rescue nobody can later explain to an NCA.
contract ModularCompliance {
    // ─────────────────────────── roles ────────────────────────────────────────

    address public immutable governance;

    /// @notice The token (or transfer agent) permitted to call `notifyTransfer`. Only this
    ///         address may advance module state — otherwise anyone could inflate a
    ///         concentration counter or restart a holding clock without moving a unit.
    address public boundToken;

    // ─────────────────────────── state ────────────────────────────────────────

    address[] private _modules;
    mapping(address => bool) public isModule;
    mapping(address => bool) public bypassed;

    uint256 public constant MAX_MODULES = 12;

    // ─────────────────────────── events ───────────────────────────────────────

    event TokenBound(address indexed token);
    event ModuleAdded(address indexed module, bytes32 indexed moduleId);
    event ModuleRemoved(address indexed module, bytes32 indexed moduleId);
    event ModuleBypassed(address indexed module, bytes32 reasonHash, uint64 at);
    event ModuleBypassLifted(address indexed module, uint64 at);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotBoundToken();
    error TokenAlreadyBound();
    error ModuleAlreadyAdded(address module);
    error UnknownModule(address module);
    error TooManyModules();
    error AlreadyBypassed(address module);
    error NotBypassed(address module);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_) {
        governance = governance_;
    }

    /// @notice One-shot. Rebinding the token would silently re-point the whole compliance
    ///         stack at a different instrument, so it is not available at any price.
    function bindToken(address token) external onlyGovernance {
        if (boundToken != address(0)) revert TokenAlreadyBound();
        boundToken = token;
        emit TokenBound(token);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // MODULE MANAGEMENT
    // ═══════════════════════════════════════════════════════════════════════

    function addModule(address module) external onlyGovernance {
        if (isModule[module]) revert ModuleAlreadyAdded(module);
        if (_modules.length + 1 > MAX_MODULES) revert TooManyModules();

        isModule[module] = true;
        _modules.push(module);
        emit ModuleAdded(module, IComplianceModule(module).moduleId());
    }

    function removeModule(address module) external onlyGovernance {
        if (!isModule[module]) revert UnknownModule(module);

        isModule[module] = false;
        for (uint256 i = 0; i < _modules.length; i++) {
            if (_modules[i] == module) {
                _modules[i] = _modules[_modules.length - 1];
                _modules.pop();
                break;
            }
        }
        emit ModuleRemoved(module, IComplianceModule(module).moduleId());
    }

    // ═══════════════════════════════════════════════════════════════════════
    // EMERGENCY BYPASS — a logged, deliberate decision to run without a rule.
    // ═══════════════════════════════════════════════════════════════════════

    /// @param reasonHash Hash of the off-chain incident record. Under DORA this is also an
    ///                   ICT-incident artefact, and under DLT Pilot Art 7(6) it is evidence
    ///                   on the operator's own side of a liability question it will have to
    ///                   argue. Write it before the call, not after.
    function emergencyBypass(address module, bytes32 reasonHash) external onlyGovernance {
        if (!isModule[module]) revert UnknownModule(module);
        if (bypassed[module]) revert AlreadyBypassed(module);
        bypassed[module] = true;
        emit ModuleBypassed(module, reasonHash, uint64(block.timestamp));
    }

    function liftBypass(address module) external onlyGovernance {
        if (!bypassed[module]) revert NotBypassed(module);
        bypassed[module] = false;
        emit ModuleBypassLifted(module, uint64(block.timestamp));
    }

    // ═══════════════════════════════════════════════════════════════════════
    // THE C1 HOOK
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Pre-transfer veto. Reverts with the failing module's own error, unmodified —
    ///         no try/catch wrapper, because collapsing a specific Article breach into a
    ///         generic "transfer not compliant" is exactly the information an NCA reviewer
    ///         and a support desk both need and cannot recover afterwards.
    function checkTransfer(address from, address to, uint256 amount) public view {
        uint256 len = _modules.length;
        for (uint256 i = 0; i < len; i++) {
            address m = _modules[i];
            if (bypassed[m]) continue;
            IComplianceModule(m).checkTransfer(from, to, amount);
        }
    }

    /// @notice Non-reverting form for UIs and off-chain simulation. Deliberately NOT used by
    ///         the token — a boolean at the hook would let a caller ignore the answer.
    function canTransfer(address from, address to, uint256 amount) external view returns (bool) {
        try this.checkTransfer(from, to, amount) {
            return true;
        } catch {
            return false;
        }
    }

    /// @notice Post-transfer state advance. Called by the token AFTER the balance moves, so
    ///         modules that maintain running totals observe the settled position rather than
    ///         an intended one that may still revert.
    function notifyTransfer(address from, address to, uint256 amount) external {
        if (msg.sender != boundToken) revert NotBoundToken();

        uint256 len = _modules.length;
        for (uint256 i = 0; i < len; i++) {
            address m = _modules[i];
            if (bypassed[m]) continue;
            IComplianceModule(m).notifyTransfer(from, to, amount);
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // READS
    // ═══════════════════════════════════════════════════════════════════════

    function modules() external view returns (address[] memory) {
        return _modules;
    }

    function moduleCount() external view returns (uint256) {
        return _modules.length;
    }
}

/// @title ModuleAdapter (illustrative sample — not production code)
/// @notice Bridges a narrow, single-purpose gate — `HoldingPeriodLock.checkTransfer(address)`,
///         and the fund modules in this folder, which each carry their own bespoke signature
///         — onto the `IComplianceModule` interface the stack expects.
/// @dev    ⚠️ The adapter exists so the gates do NOT have to be widened. Each of those
///         contracts is written against one Article and reverts with errors named after it;
///         retrofitting a common signature onto all of them would blur that mapping, which
///         is the one property the §13 Article→function audit map depends on. Adapt at the
///         boundary, keep the gate legible.
abstract contract ModuleAdapter is IComplianceModule {
    bytes32 private immutable _moduleId;

    constructor(bytes32 moduleId_) {
        _moduleId = moduleId_;
    }

    function moduleId() external view returns (bytes32) {
        return _moduleId;
    }

    /// @dev Default no-op — most gates are pure vetoes with no state to advance. Override
    ///      only where the module genuinely keeps a counter.
    function notifyTransfer(address, address, uint256) external virtual {}

    function checkTransfer(address from, address to, uint256 amount) external view virtual;
}
