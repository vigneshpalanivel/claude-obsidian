// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ModuleAdapter} from "./ModularCompliance.sol";
import {ISanctionsCheck} from "./Interfaces.sol";

/// @title SanctionsGate (illustrative sample — not production code)
/// @notice The `IComplianceModule` face of `SanctionsRegistry`, so `ModularCompliance` can
///         register it. Without this the store is unreachable from the C1 hook and only a
///         transfer agent remembering to call it enforces anything.
/// @dev    ⚠️ THIS ADAPTER IS IN THE **GENERIC-BLOCK** CLASS, and it is the reason that
///         classification has to exist. `ModularCompliance.checkTransfer` states its
///         propagate-the-module's-own-error rule globally, which is right for a holding-period
///         lock — an unlock date is not a suspicion and telling a holder when they may exit is
///         a service. It is wrong here. Every revert this adapter can produce on the block path
///         is the single argument-free `TransferNotPermitted`, and the store is built so that
///         nothing more specific is available to leak.
/// @dev    The store holds NO reference to this gate, and the gate holds no state beyond the
///         reference. Rule evaluation stays in `ModularCompliance`: this is a store plus a
///         predicate, not a second compliance engine. Two contracts that can independently veto
///         a transfer for different reasons is how a reason code escapes the module that was
///         meant to stay silent.
/// @dev    ⚠️ NOTHING BELONGS IN THIS FILE BUT DELEGATION. The store is written against its
///         Articles and reverts with errors named for them; this adapter exists so that gate
///         never has to be widened to fit the rule engine. The moment a check is added here
///         there are two places to look for the Article, which is the one property the §13
///         Article→function audit map depends on. Split from `SanctionsRegistry.sol` on
///         2026-09-07 — see the note there.
contract SanctionsGate is ModuleAdapter {
    address public immutable governance;

    /// @dev Interface-typed and settable, per the standing rule. Never unset: a null reference
    ///      cannot distinguish "nobody wired it" from "not owed", and for this control there is
    ///      no "not owed".
    ISanctionsCheck public sanctions;

    event DependencySet(bytes32 indexed what, address impl);

    error NotGovernance();
    error ZeroAddress();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(bytes32 moduleId_, address governance_, address sanctions_) ModuleAdapter(moduleId_) {
        if (governance_ == address(0) || sanctions_ == address(0)) revert ZeroAddress();
        governance = governance_;
        sanctions = ISanctionsCheck(sanctions_);
        emit DependencySet("sanctions", sanctions_);
    }

    /// @notice Re-point the store. Swap, never unset — the operational-resilience regime requires
    ///         this reference stay swappable at the contract layer rather than hard-wired, and it
    ///         is the reason a routine update never needs `removeModule`.
    function setSanctions(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        sanctions = ISanctionsCheck(impl);
        emit DependencySet("sanctions", impl);
    }

    /// @dev Gates BOTH sides on every movement, including mint and burn. A redemption paying
    ///      out to a listed person releases value exactly as a transfer does, so `to == 0` is
    ///      not a shortcut out of the sender check.
    function checkTransfer(address from, address to, uint256) external view override {
        sanctions.assertTransferPermitted(from, to);
    }
}
