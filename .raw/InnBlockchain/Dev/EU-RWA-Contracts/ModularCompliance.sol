// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ICompliance} from "./IERC3643.sol";

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
/// @dev    ⚠️ IMPLEMENTS `ICompliance` FROM `IERC3643.sol`, WRITTEN FROM THE EIP TEXT. No T-REX
///         source is used, in whole or in part — see the provenance note on `IERC3643.sol` and
///         `ERC-3643-CONFORMANCE.md`. `is ICompliance` is load-bearing: it makes the compiler,
///         not a reviewer, check the seven members and two events.
/// @dev    ⚠️ THE STANDARD GAVE C1 ITS BEST PROPERTY FOR FREE, AND IT IS WORTH NAMING. The EIP's
///         pre-trade gate is `canTransfer(...) returns (bool)` — a boolean, with no reason
///         attached and no room to attach one. That is exactly what AMLR Art 76 (tipping-off)
///         demands of a stop linked to a specific person's eligibility, and here the INTERFACE
///         enforces it rather than a review convention. The token treats the boolean as
///         authoritative and only falls back to `checkTransfer` to recover a reason where the
///         failing module's class permits one. See `SecurityToken._assertCompliant`.
/// @dev    ⚠️ TWO DECLARED DEVIATIONS FROM THE EIP, BOTH IN `ERC-3643-CONFORMANCE.md`:
///           (1) `bindToken` is ONE-SHOT and `unbindToken` always reverts. The EIP's model is a
///               rebindable compliance contract. This stack holds Article-mapped RUNNING STATE —
///               concentration denominators, holding clocks, cap registers — keyed to one
///               instrument's history. Re-pointing it at a second instrument carries the first
///               one's counters onto the second, which is a compliance defect that reports
///               clean. A token that needs different rules deploys a new `ModularCompliance`
///               and calls `setCompliance`; that path stays open and is logged on the token.
///           (2) The EIP's post-trade trio (`transferred`/`created`/`destroyed`) and the suite's
///               `notifyTransfer` are ONE fan-out behind two faces, not two fan-outs. A caller
///               that invokes both double-advances every counter. The token calls the trio only.
contract ModularCompliance is ICompliance {
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

    /// @dev ⚠️ `TokenBound` AND `TokenUnbound` ARE INHERITED FROM `ICompliance`, NOT DECLARED
    ///      HERE. This contract previously declared `TokenBound(address indexed token)`;
    ///      re-declaring an inherited event is a compile error, and the EIP's parameter is
    ///      UNINDEXED. Topic0 is unchanged — indexing does not enter the signature hash — but
    ///      the token address moves from a topic to the data field, so any log filter written
    ///      against the old shape stops matching. One-shot event on a one-shot function; the
    ///      cost is a full-range scan for an entry that exists once per deployment.
    /// @dev ⚠️ `TokenUnbound` IS DECLARED AND NEVER EMITTED, because `unbindToken` always
    ///      reverts. Declared and dead is the honest state — a listener written against the EIP
    ///      will simply never see it, which is correct, and removing it is not an option because
    ///      the interface names it.
    event ModuleAdded(address indexed module, bytes32 indexed moduleId);
    event ModuleRemoved(address indexed module, bytes32 indexed moduleId);
    event ModuleBypassed(address indexed module, bytes32 reasonHash, uint64 at);
    event ModuleBypassLifted(address indexed module, uint64 at);
    /// @dev Emitted by `removeModule` when the module being removed was under an emergency
    ///      bypass. Distinct from `ModuleBypassLifted` because nothing was lifted — the module
    ///      left, and its bypass left with it — and a reviewer reconciling `ModuleBypassed`
    ///      against lifts needs the closing entry to say which of the two it was.
    event ModuleBypassCleared(address indexed module, uint64 at);

    // ─────────────────────────── errors ───────────────────────────────────────

    error NotGovernance();
    error NotBoundToken();
    error TokenAlreadyBound();
    error ZeroAddress();
    error ModuleAlreadyAdded(address module);
    error UnknownModule(address module);
    error TooManyModules();
    error AlreadyBypassed(address module);
    error NotBypassed(address module);
    /// @dev Should be unreachable — `removeModule` clears the flag — and is checked anyway,
    ///      because the failure it guards is a module that is on the list and silently skipped.
    error BypassStillSet(address module);
    /// @dev See `unbindToken`. Informative-class — this is a wiring fact about the deployment,
    ///      not a fact about any person, so it may say what it is.
    error UnbindNotSupported();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(address governance_) {
        governance = governance_;
    }

    /// @notice One-shot. Rebinding the token would silently re-point the whole compliance
    ///         stack at a different instrument, so it is not available at any price.
    /// @dev    Rejects `address(0)`: since the one-shot check is `boundToken != address(0)`,
    ///         binding zero would have consumed nothing and left the stack open to a later
    ///         bind by whoever noticed — a one-shot that has not fired.
    function bindToken(address token) external onlyGovernance {
        if (token == address(0)) revert ZeroAddress();
        if (boundToken != address(0)) revert TokenAlreadyBound();
        boundToken = token;
        emit TokenBound(token);
    }

    /// @notice ⚠️ DECLARED DEVIATION — ALWAYS REVERTS. Present because `ICompliance` names it
    ///         and the compiler must see the selector; refused because unbinding is the first
    ///         half of a rebind, and a rebind is what the one-shot exists to prevent.
    /// @dev    The modules behind this contract hold running, Article-mapped state that only
    ///         means anything against ONE instrument's history. Unbind → rebind would present a
    ///         second instrument with the first one's concentration denominators and holding
    ///         clocks — a breach that reports clean, or a clean position that reports as a
    ///         breach. Neither is recoverable from the logs afterwards.
    /// @dev    The supported route is `SecurityToken.setCompliance` pointed at a FRESH
    ///         `ModularCompliance`. That is one governance act, it emits `ComplianceAdded` on
    ///         the token, and it leaves this contract's history intact and readable. The old
    ///         contract stays bound to a token that no longer calls it, which is inert.
    /// @dev    Recorded in `ERC-3643-CONFORMANCE.md`. A reverting implementation is a deviation
    ///         and is registered as one — it is NOT "conformant because the function exists".
    function unbindToken(address) external pure {
        revert UnbindNotSupported();
    }

    /// @notice The token this compliance stack serves, or `address(0)` before `bindToken`.
    ///         `ICompliance.getTokenBound()` — conformant signature.
    /// @dev    ⚠️ THIS FUNCTION WAS MISSING UNTIL 2026-09-11 AND `isTokenBound` BELOW WAS
    ///         SILENTLY STANDING IN FOR IT. That is worth recording because of HOW it passed
    ///         review: the member count matched the EIP's, every other name matched, and the
    ///         substitute was strictly more defensive than the original — so a reviewer counting
    ///         members or reading for safety saw nothing wrong. **A substitution is not a
    ///         deviation that got declared; it is a deviation that got disguised**, and the two
    ///         are indistinguishable from inside the file. The reconciliation that would have
    ///         caught it is a diff against the EIP's own published interface, which is now what
    ///         `ERC-3643-CONFORMANCE.md` §6 test 2 requires.
    /// @dev    Returns the raw slot, including `address(0)`. A caller wanting "is this stack
    ///         live" must compare against zero itself — that is the standard's shape and the
    ///         reason `isTokenBound` was kept rather than replaced.
    function getTokenBound() external view returns (address) {
        return boundToken;
    }

    /// @notice Whether `token` is the instrument this stack serves. Never true for `address(0)`,
    ///         so an unbound stack cannot be made to answer yes by asking about zero.
    /// @dev    ⚠️ NOT AN EIP MEMBER — a suite supplement, retained IN ADDITION to
    ///         `getTokenBound()` and never instead of it. It is the `pauseWithReason` pattern:
    ///         where the suite wants a safer surface than the standard offers, it adds one
    ///         alongside the conformant signature rather than substituting it. Kept because
    ///         `getTokenBound() == someToken` invites the `address(0) == address(0)` mistake
    ///         that this function's zero-check exists to make unreachable.
    function isTokenBound(address token) external view returns (bool) {
        return token != address(0) && token == boundToken;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // MODULE MANAGEMENT
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev ⚠️ A bypass never survives a module's removal, so a module can never be ADDED under
    ///      one. Before 2026-09-08 `removeModule` left `bypassed[module]` standing: bypass →
    ///      remove → re-add produced a module on the list that `checkTransfer` skipped, with no
    ///      `ModuleBypassed` event in the window in which it mattered — a silent bypass, which
    ///      is the one shape the emergency-bypass design (logged, never silent) exists to rule
    ///      out. The check here is belt-and-braces over the clear in `removeModule`.
    function addModule(address module) external onlyGovernance {
        if (isModule[module]) revert ModuleAlreadyAdded(module);
        if (bypassed[module]) revert BypassStillSet(module);
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
        // The bypass is a property of the module's registration, not of the address. It goes
        // when the registration goes, and it is logged going — see `ModuleBypassCleared`.
        if (bypassed[module]) {
            delete bypassed[module];
            emit ModuleBypassCleared(module, uint64(block.timestamp));
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
    ///         no try/catch wrapper here. What that error may SAY is decided by the module's
    ///         class, not by this contract, and every module has exactly one class:
    ///
    ///         ⚠️ TWO CLASSES OF MODULE, AND AN AUTHOR CLASSIFIES BEFORE WRITING AN ERROR.
    ///
    ///           INFORMATIVE-block — holding period, closed period, covenant, concentration.
    ///             The stop is a fact about the instrument or the record, applies to everyone
    ///             in the same position, and is something the holder can cure or wait out. The
    ///             module's error MAY name its Article and what would satisfy it: an unlock
    ///             date is not a suspicion, and telling a holder when they may exit is a
    ///             service. Collapsing these into a generic "not compliant" throws away
    ///             exactly what an NCA reviewer and a support desk both need and cannot
    ///             recover afterwards.
    ///
    ///           GENERIC-block — anything linked to eligibility of a specific person, a freeze,
    ///             a sanctions hit, or a suspicion. The module MUST revert with ONE argument-
    ///             free error, and the same one for every reason in its class. AMLR Art 76
    ///             (tipping-off) makes disclosing that a customer is under analysis an
    ///             individual criminal offence in most Member States, and a typed revert on a
    ///             public ledger discloses it to everyone. Even an address argument is too
    ///             much on a two-sided check — it says which side failed.
    ///
    ///         `RestrictedPartyGate` is the generic-class module in this folder — the ONLY one,
    ///         and every wallet-level stop must route through it rather than beside it. Every
    ///         other adapter here is informative-class. A module that is unsure which class it
    ///         is in is generic-class: the cost of over-disclosing is a criminal offence, the
    ///         cost of under-disclosing is a support ticket.
    ///
    ///         Convention: each module carries a `/// @dev CLASS: informative` or
    ///         `/// @dev CLASS: generic` line on its contract, so the §13 audit map can be read
    ///         off the source without reading the errors.
    ///
    ///         ⚠️ Nothing here enforces the classification — a generic-class module that
    ///         reverts with a typed error compiles and runs. The rule lives in review, which is
    ///         why it is written here and not left to be inferred from `RestrictedPartyGate`.
    function checkTransfer(address from, address to, uint256 amount) public view {
        uint256 len = _modules.length;
        for (uint256 i = 0; i < len; i++) {
            address m = _modules[i];
            if (bypassed[m]) continue;
            IComplianceModule(m).checkTransfer(from, to, amount);
        }
    }

    /// @notice ⚠️ THE EIP'S GATE, AND THE AUTHORITATIVE ONE. `SecurityToken._assertCompliant`
    ///         calls this on every movement and treats the boolean as the decision; it falls
    ///         back to `checkTransfer` only to recover a REASON, and only where the failing
    ///         module's class permits one. An earlier draft of this NatSpec said the token
    ///         deliberately did not call it — that was true of the pre-conformance token and is
    ///         now wrong. A boolean at the hook does not let a caller ignore the answer; it lets
    ///         a caller ignore the explanation, which is the point (AMLR Art 76).
    /// @dev    The `try/catch` swallows the module's typed error by design. Anything that
    ///         reverts is a no. What it also swallows is an out-of-gas in a child frame under
    ///         the 63/64 rule, which would read as a compliance stop rather than a gas problem —
    ///         a reason `MAX_MODULES` is a low hard cap and not a comment.
    function canTransfer(address from, address to, uint256 amount) external view returns (bool) {
        try this.checkTransfer(from, to, amount) {
            return true;
        } catch {
            return false;
        }
    }

    // ═══════════════════════════════════════════════════════════════════════
    // POST-TRADE NOTIFICATION — ONE FAN-OUT, TWO FACES
    //
    // ⚠️ `transferred` / `created` / `destroyed` (the EIP's face) and `notifyTransfer` (the
    // suite's) ALL land on `_advanceModules`. They are not independent notifications and a
    // caller that invokes both books the movement twice — `EltifConcentration` would report a
    // breach that never happened, `HoldingPeriodLock` would restart a clock on a transfer that
    // occurred once. `SecurityToken._notify` calls the EIP trio ONLY; its NatSpec records why,
    // because the doubled version was reasoned into a draft before it was caught.
    //
    // The EIP's split by movement type is the conformant surface and the one a third-party
    // module written against the standard listens for. The suite's flat form (mint as
    // `from == 0`, burn as `to == 0`) is what `IComplianceModule` presents, because a module
    // that does not care about mint should not have to implement a third entry point to say so.
    // The translation happens here, once.
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice EIP face — a settled transfer between two holders.
    function transferred(address from, address to, uint256 amount) external {
        _advanceModules(from, to, amount);
    }

    /// @notice EIP face — a settled mint. Flattened to `from == address(0)`.
    function created(address to, uint256 amount) external {
        _advanceModules(address(0), to, amount);
    }

    /// @notice EIP face — a settled burn. Flattened to `to == address(0)`.
    function destroyed(address from, uint256 amount) external {
        _advanceModules(from, address(0), amount);
    }

    /// @notice Suite face. Retained because `IComplianceGate` names it and because the flat
    ///         shape is the one the modules speak. NOT called by the token — see the block
    ///         comment above.
    function notifyTransfer(address from, address to, uint256 amount) external {
        _advanceModules(from, to, amount);
    }

    /// @dev Post-transfer state advance. Called AFTER the balance moves, so modules that
    ///      maintain running totals observe the settled position rather than an intended one
    ///      that may still revert.
    /// @dev The `boundToken` guard is on the fan-out rather than on each face, so a face added
    ///      later cannot be added without it. Without the guard anyone could inflate a
    ///      concentration counter or restart a holding clock without moving a unit.
    function _advanceModules(address from, address to, uint256 amount) internal {
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
/// @notice Bridges a narrow, single-purpose gate carrying its own bespoke signature onto the
///         `IComplianceModule` interface the stack expects. Concrete adapters in this folder:
///         `CovenantGate` (→ `CovenantRegistry`), `HoldingPeriodGate` (→ `HoldingPeriodLock`)
///         and `PdmrClosedPeriodGate` (→ `PdmrClosedPeriodFreeze`).
/// @dev    ⚠️ The adapter exists so the gates do NOT have to be widened. Each of those
///         contracts is written against one Article and reverts with errors named after it;
///         retrofitting a common signature onto all of them would blur that mapping, which
///         is the one property the §13 Article→function audit map depends on. Adapt at the
///         boundary, keep the gate legible.
/// @dev    ⚠️ THE FUND MODULES ARE NOT ADAPTED, AND THAT IS DELIBERATE — this NatSpec
///         previously said they were, which was wrong in a way worth recording.
///         `EltifConcentration`, `UcitsFiveTenForty`, `NavBorrowingCap` and `LmtGate` have
///         no C1 veto to offer and no adapter should be written for them:
///           • A P2P transfer moves neither the capital nor the NAV denominator, so there is
///             nothing for `checkTransfer` to test.
///           • A mint RAISES the denominator, which REDUCES every concentration ratio — so
///             vetoing subscriptions on a live breach would block the remedy, the same error
///             as blocking disposals on a stale feed.
///           • Their `suspended` flag is the ELTIF Art 17(1)(c) / Art 16(3)–(4) window in
///             which a limit is RELIEVED during a capital raise. It is not a trading halt,
///             and gating mint on it would be exactly inverted.
///           • Their `onMint`/`onBurn` take a CASH amount from the subscription agent, not
///             the token's unit `amount`. The two are not interchangeable, so the token hook
///             could not advance their state correctly even if it were wired.
///         They are gated by their own reverting functions and satisfy the §11 test on that
///         basis. What is wrong is any claim that the C1 hook reads them.
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
