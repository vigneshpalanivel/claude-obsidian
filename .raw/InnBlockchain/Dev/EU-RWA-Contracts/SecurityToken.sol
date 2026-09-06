// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ModularCompliance} from "./ModularCompliance.sol";
import {IdentityRegistry} from "./IdentityRegistry.sol";

/// @title SecurityToken (illustrative sample — not production code)
/// @notice C1 + C5 — the instrument itself, and the only contract in this folder that moves a
///         balance. Everything else is a registry or a rule module waiting to be called from
///         here. Until this exists, none of the other twenty contracts runs.
/// @dev    ⚠️ THIS IS DELIBERATELY NOT ERC-1400 AND NOT ERC-3643. §16 D0 leaves the base
///         standard to the operator, and §8 makes that choice PROSPECTUS-BLOCKING: the token
///         standard is a disclosure item under Prospectus Arts 6/16(1), so changing it after
///         approval is a material change carrying an Art 23 supplement and a withdrawal
///         window. Writing this file as T-REX or as an ERC-1410/1594/1644 assembly would
///         quietly settle a decision the design reserves — and §13's standard-independence
///         check exists precisely to prove the Articles enforced do not move when D0 moves.
///         So what is here is the §3 capability set, in plain ERC-20 shape, with the
///         compliance content that must survive either binding. Bind it at spec time.
/// @dev    ⚠️ C6 (PARTITIONS) IS NOT IN THIS FILE, AND THAT IS THE D0 DECISION SHOWING. Under
///         ERC-1400 partitions come free from ERC-1410; under ERC-3643 they are custom work.
///         Modelling them here would pick a side. `DistributionWaterfall` shows the shape a
///         tranched instrument needs when the decision is made.
/// @dev    ⚠️ EVERY BALANCE MOVEMENT ROUTES THROUGH THE SAME HOOK — mint, burn, transfer,
///         forced transfer and recovery. The moment one path skips `_check`, that path is the
///         bypass: a wallet that cannot receive a transfer but can receive a mint is a frozen
///         wallet that is not frozen. `DistributionAgent` exists for the same reason on the
///         payout side.
/// @dev    GDPR / AMLR Art 76: freeze and forced-transfer events carry a `reasonHash`, never a
///         reason. The hash points at an off-chain incident record. A human-readable "sanctions
///         hit" in a public log is both a tipping-off disclosure and an un-erasable personal
///         datum about an identified person.
contract SecurityToken {
    // ═══════════════════════════════════════════════════════════════════════
    // ROLES
    // ═══════════════════════════════════════════════════════════════════════

    address public immutable governance;

    /// @notice Transfer agents. Mint, burn, freeze, forced transfer and recovery — the C5
    ///         surface. Separate from `governance` because these are daily operational acts
    ///         performed by an operations desk, while governance is upgrade authority. Under
    ///         DORA Art 5 those are different people with different accountability.
    mapping(address => bool) public isAgent;

    ModularCompliance public immutable compliance;
    IdentityRegistry public immutable identity;

    // ═══════════════════════════════════════════════════════════════════════
    // TOKEN STATE
    // ═══════════════════════════════════════════════════════════════════════

    string public name;
    string public symbol;
    uint8 public immutable decimals;

    /// @notice The instrument's ISIN, as a hash. Not decorative: MiFIR Art 26 transaction
    ///         reports and RTS 1/2 transparency publications are keyed on it, and
    ///         `MifirEventSchema` emits it. Stored as a hash so the on-chain record cannot
    ///         drift from the reference-data record it must match.
    bytes32 public immutable isinHash;

    uint256 public totalSupply;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    /// @notice PARTIAL freeze — units immobilised while the wallet stays otherwise live.
    /// @dev    ⚠️ A partial freeze and a whole-wallet freeze are different controls and both
    ///         are needed. An AMLR asset freeze on a specific tranche, or a court order over a
    ///         disputed holding, must not stop the holder dealing with the rest — and a
    ///         sanctions designation must stop everything. Modelling only the second forces the
    ///         operator to over-freeze, which is itself a legal exposure to the holder.
    mapping(address => uint256) public frozenUnits;

    /// @notice Whole-instrument halt. Distinct from `ModularCompliance.emergencyBypass`, which
    ///         runs the token WITHOUT a rule; this stops the token entirely. Under DLT Pilot
    ///         Art 7(5) an operator must be able to do both, and must be able to say which one
    ///         it did.
    bool public paused;

    // ═══════════════════════════════════════════════════════════════════════
    // EVENTS
    // ═══════════════════════════════════════════════════════════════════════

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    event AgentSet(address indexed agent, bool allowed);
    event Paused(bytes32 reasonHash, uint64 at);
    event Unpaused(uint64 at);

    event UnitsFrozen(address indexed wallet, uint256 amount, bytes32 reasonHash);
    event UnitsUnfrozen(address indexed wallet, uint256 amount);

    /// @dev Deliberately a SEPARATE event from `Transfer`, in addition to it — never instead of
    ///      it. A forced transfer is an ordinary balance movement for accounting purposes and
    ///      an extraordinary act for supervisory purposes, and an NCA reviewer asking "which
    ///      movements were involuntary" must not have to infer it from the sender.
    event ForcedTransfer(address indexed from, address indexed to, uint256 value, bytes32 reasonHash);
    event WalletRecovered(address indexed lostWallet, address indexed newWallet, uint256 value, bytes32 reasonHash);

    // ═══════════════════════════════════════════════════════════════════════
    // ERRORS
    // ═══════════════════════════════════════════════════════════════════════

    error NotGovernance();
    error NotAgent();
    error TokenPaused();
    error ZeroAddress();
    error InsufficientBalance(address wallet, uint256 available, uint256 required);
    error InsufficientUnfrozenBalance(address wallet, uint256 unfrozen, uint256 required);
    error InsufficientAllowance(address owner, address spender, uint256 available, uint256 required);
    error FrozenExceedsBalance(address wallet, uint256 balance, uint256 wouldFreeze);
    error NotFrozenByThatMuch(address wallet, uint256 frozen, uint256 requested);
    error RecoveryTargetNotSameInvestor(address lostWallet, address newWallet);
    error RecoveryTargetHasNoRecord(address newWallet);
    error NothingToRecover(address lostWallet);

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    modifier onlyAgent() {
        if (!isAgent[msg.sender]) revert NotAgent();
        _;
    }

    /// @dev ⚠️ `paused` guards the VOLUNTARY paths only. Forced transfer and recovery must
    ///      keep working while the instrument is halted — a court order and a sanctions
    ///      seizure do not wait for the operator to resume trading, and an operator who
    ///      halted the token cannot use its own halt as a reason it could not comply.
    modifier whenLive() {
        if (paused) revert TokenPaused();
        _;
    }

    constructor(
        address governance_,
        address compliance_,
        address identity_,
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        bytes32 isinHash_
    ) {
        governance = governance_;
        compliance = ModularCompliance(compliance_);
        identity = IdentityRegistry(identity_);
        name = name_;
        symbol = symbol_;
        decimals = decimals_;
        isinHash = isinHash_;
    }

    function setAgent(address agent, bool allowed) external onlyGovernance {
        isAgent[agent] = allowed;
        emit AgentSet(agent, allowed);
    }

    function pause(bytes32 reasonHash) external onlyAgent {
        paused = true;
        emit Paused(reasonHash, uint64(block.timestamp));
    }

    function unpause() external onlyGovernance {
        paused = false;
        emit Unpaused(uint64(block.timestamp));
    }

    // ═══════════════════════════════════════════════════════════════════════
    // C1 — THE PRE-VALIDATION HOOK
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice The single gate. Two layers, and the order is not arbitrary: identity first,
    ///         because a rule module asking "is this holder over the ELTIF concentration
    ///         limit" is meaningless for a wallet that has no verified record at all.
    /// @dev    ⚠️ MINT IS `from == address(0)` AND BURN IS `to == address(0)`. Both are passed
    ///         to the modules, which decide for themselves whether they care —
    ///         `CovenantGate` treats mint as its own gate, `EltifConcentration` counts it, a
    ///         holding-period lock ignores it. Filtering here would take that choice away from
    ///         the module that owns the Article.
    function _check(address from, address to, uint256 amount) internal view {
        if (from != address(0)) identity.checkEligible(from);
        if (to != address(0)) identity.checkEligible(to);
        compliance.checkTransfer(from, to, amount);
    }

    /// @notice Non-reverting form for UIs and pre-trade simulation. Never used internally — a
    ///         boolean at the hook lets a caller ignore the answer.
    function canTransfer(address from, address to, uint256 amount) external view returns (bool) {
        try this.simulate(from, to, amount) {
            return true;
        } catch {
            return false;
        }
    }

    /// @dev External only so `canTransfer` can `try` it. Not intended for direct use.
    function simulate(address from, address to, uint256 amount) external view {
        if (paused) revert TokenPaused();
        _requireSpendable(from, amount);
        _check(from, to, amount);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // BALANCE MOVEMENT
    // ═══════════════════════════════════════════════════════════════════════

    /// @dev The one place a balance changes. Compliance runs BEFORE the write; the module
    ///      notification runs AFTER, so counter-keeping modules observe the settled position
    ///      rather than an intended one that may still revert.
    function _move(address from, address to, uint256 amount) internal {
        _check(from, to, amount);

        if (from != address(0)) {
            _balances[from] -= amount;
        } else {
            totalSupply += amount;
        }

        if (to != address(0)) {
            _balances[to] += amount;
        } else {
            totalSupply -= amount;
        }

        emit Transfer(from, to, amount);
        compliance.notifyTransfer(from, to, amount);
    }

    function _requireSpendable(address wallet, uint256 amount) internal view {
        uint256 bal = _balances[wallet];
        if (bal < amount) revert InsufficientBalance(wallet, bal, amount);

        uint256 unfrozen = bal - frozenUnits[wallet];
        if (unfrozen < amount) revert InsufficientUnfrozenBalance(wallet, unfrozen, amount);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ERC-20 SURFACE
    // ═══════════════════════════════════════════════════════════════════════

    function balanceOf(address wallet) external view returns (uint256) {
        return _balances[wallet];
    }

    /// @notice What the holder can actually move today. The number a UI should show — a holder
    ///         told they own 100 who cannot move 40 will open a support ticket, and under
    ///         AMLR Art 76 nobody may tell them why.
    function availableBalance(address wallet) external view returns (uint256) {
        uint256 bal = _balances[wallet];
        uint256 frozen = frozenUnits[wallet];
        return bal > frozen ? bal - frozen : 0;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address to, uint256 amount) external whenLive returns (bool) {
        if (to == address(0)) revert ZeroAddress();
        _requireSpendable(msg.sender, amount);
        _move(msg.sender, to, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) external whenLive returns (bool) {
        if (to == address(0)) revert ZeroAddress();

        uint256 allowed = _allowances[from][msg.sender];
        if (allowed < amount) revert InsufficientAllowance(from, msg.sender, allowed, amount);
        _allowances[from][msg.sender] = allowed - amount;

        _requireSpendable(from, amount);
        _move(from, to, amount);
        return true;
    }

    // ═══════════════════════════════════════════════════════════════════════
    // ISSUANCE
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Mint. Runs the full hook with `from == address(0)`.
    /// @dev    ⚠️ THE MINT GATE IS WHERE FOUR OF THE SIX COVENANT OBLIGATIONS BITE — PRIIPs
    ///         Art 13, DLT Pilot 4(2)(g), ELTIF 18(3) and ELTIF 26 are all pre-investment
    ///         duties. A mint path that skipped compliance "because the issuer controls it"
    ///         would disable every one of them at the exact moment they apply.
    function mint(address to, uint256 amount) external onlyAgent whenLive {
        if (to == address(0)) revert ZeroAddress();
        _move(address(0), to, amount);
    }

    /// @notice Burn. Redemption, capital reduction, or the disposal leg of a buy-back where the
    ///         issuer has elected to cancel rather than hold.
    /// @dev    Burns unfrozen units only. Burning frozen units would let an agent extinguish a
    ///         holding that a court or an authority has immobilised, which is the one thing a
    ///         freeze is for.
    function burn(address from, uint256 amount) external onlyAgent {
        _requireSpendable(from, amount);
        _move(from, address(0), amount);
    }

    // ═══════════════════════════════════════════════════════════════════════
    // C5 — FREEZE, FORCED TRANSFER, RECOVERY
    // ═══════════════════════════════════════════════════════════════════════

    /// @notice Immobilises `amount` units without touching the rest of the holding.
    /// @dev    Whole-wallet freeze lives in `IdentityRegistry.freeze` and is checked by
    ///         `checkEligible` on both sides of every movement. Two contracts, because the two
    ///         controls have different lifetimes: an identity freeze follows the INVESTOR
    ///         across every instrument they hold, a unit freeze is about THESE units.
    function freezeUnits(address wallet, uint256 amount, bytes32 reasonHash) external onlyAgent {
        uint256 wouldFreeze = frozenUnits[wallet] + amount;
        if (wouldFreeze > _balances[wallet]) revert FrozenExceedsBalance(wallet, _balances[wallet], wouldFreeze);

        frozenUnits[wallet] = wouldFreeze;
        emit UnitsFrozen(wallet, amount, reasonHash);
    }

    function unfreezeUnits(address wallet, uint256 amount) external onlyAgent {
        uint256 frozen = frozenUnits[wallet];
        if (frozen < amount) revert NotFrozenByThatMuch(wallet, frozen, amount);

        frozenUnits[wallet] = frozen - amount;
        emit UnitsUnfrozen(wallet, amount);
    }

    /// @notice Involuntary movement — court order, AMLR asset freeze with a designated
    ///         destination, insolvency, or correcting a settlement error.
    /// @dev    ⚠️ THE ASYMMETRY IS THE WHOLE POINT, AND IT IS NOT A SHORTCUT:
    ///           • The SENDER'S locks are bypassed. Frozen units move, holding periods do not
    ///             apply, and the sender's own eligibility is not consulted. A seizure order
    ///             against a sanctioned wallet is unexecutable if the wallet's sanctioned
    ///             status blocks it — which is the absurdity a naive implementation produces.
    ///           • The RECIPIENT is still fully checked. The destination must be an eligible
    ///             holder and must satisfy every rule module. Otherwise "forced transfer"
    ///             becomes a general-purpose route to place units with anyone at all, and
    ///             every concentration limit, cap and covenant in this folder has a back door
    ///             with an agent key.
    /// @dev    ⚠️ Frozen units are released to the extent they are moved. Leaving the freeze
    ///         counter untouched would leave the SENDER carrying a freeze over units they no
    ///         longer hold, silently immobilising an unrelated part of their holding.
    function forcedTransfer(address from, address to, uint256 amount, bytes32 reasonHash) external onlyAgent {
        if (to == address(0)) revert ZeroAddress();

        uint256 bal = _balances[from];
        if (bal < amount) revert InsufficientBalance(from, bal, amount);

        uint256 frozen = frozenUnits[from];
        uint256 unfrozen = bal - frozen;
        if (amount > unfrozen) {
            frozenUnits[from] = frozen - (amount - unfrozen);
        }

        // Recipient side only — see the asymmetry note above.
        identity.checkEligible(to);
        compliance.checkTransfer(from, to, amount);

        _balances[from] -= amount;
        _balances[to] += amount;

        emit Transfer(from, to, amount);
        emit ForcedTransfer(from, to, amount, reasonHash);
        compliance.notifyTransfer(from, to, amount);
    }

    /// @notice Lost-key recovery. Moves the entire holding, and the freeze state with it.
    /// @dev    ⚠️ THE CONTROL THAT MAKES THIS SAFE IS THE RECORD-POINTER MATCH, NOT THE AGENT
    ///         ROLE. Both wallets must resolve to the SAME off-chain investor record. Without
    ///         that check, "recovery" is an agent-key licence to move any holding to any
    ///         address and call it a lost key — and it would read identically in the logs.
    ///         With it, the operator must first have bound the new wallet to the existing
    ///         verified record in `IdentityRegistry`, which is the step where the identity
    ///         evidence is actually examined.
    /// @dev    ⚠️ THE FREEZE FOLLOWS THE UNITS. Recovering into a clean wallet must not launder
    ///         an asset freeze. If the operator wants the units unfrozen, that is a separate,
    ///         separately-logged decision.
    /// @dev    Prospectus Art 6/16(1) requires the recovery procedure to be DISCLOSED. This
    ///         function is the disclosed mechanism; the operator's key-loss verification
    ///         procedure is the paper half, and the two must describe the same thing.
    function recoverWallet(address lostWallet, address newWallet, bytes32 reasonHash) external onlyAgent {
        if (newWallet == address(0)) revert ZeroAddress();

        IdentityRegistry.Investor memory lost = identity.investor(lostWallet);
        IdentityRegistry.Investor memory replacement = identity.investor(newWallet);

        if (!replacement.registered) revert RecoveryTargetHasNoRecord(newWallet);
        if (replacement.recordPointer == bytes32(0) || replacement.recordPointer != lost.recordPointer) {
            revert RecoveryTargetNotSameInvestor(lostWallet, newWallet);
        }

        uint256 bal = _balances[lostWallet];
        if (bal == 0) revert NothingToRecover(lostWallet);

        uint256 frozen = frozenUnits[lostWallet];

        _balances[lostWallet] = 0;
        frozenUnits[lostWallet] = 0;
        _balances[newWallet] += bal;
        frozenUnits[newWallet] += frozen;

        emit Transfer(lostWallet, newWallet, bal);
        emit WalletRecovered(lostWallet, newWallet, bal, reasonHash);
        compliance.notifyTransfer(lostWallet, newWallet, bal);
    }
}
