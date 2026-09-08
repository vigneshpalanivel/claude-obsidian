// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ModuleAdapter} from "./ModularCompliance.sol";
import {IRestrictedParty} from "./Interfaces.sol";

/// @title RestrictedPartyGate (illustrative sample — not production code)
/// @notice The `IComplianceModule` face of `RestrictedPartyRegistry`, so `ModularCompliance` can
///         register it. Without this the store is unreachable from the C1 hook and only a
///         transfer agent remembering to call it enforces anything.
/// @dev CLASS: generic
/// @dev    ⚠️ THIS ADAPTER IS IN THE **GENERIC-BLOCK** CLASS, and it is the reason that
///         classification has to exist. `ModularCompliance.checkTransfer` propagates each
///         module's own error, which is right for a holding-period lock — an unlock date is
///         not a suspicion and telling a holder when they may exit is a service. It would be
///         wrong here, so the classification on `ModularCompliance.checkTransfer` carves this
///         class out: every revert this adapter can produce is argument-free. There are TWO
///         such errors, not one — `TransferNotPermitted()` on every path, and
///         `ScreeningStale()` on the MINT path only (`from == address(0)`), when the operator's
///         re-screen has fallen behind the list. Both are generic-class: `ScreeningStale` says
///         nothing about any person, only that the programme is late, and it can never be
///         raised on a path that has a sender. The store is built so that nothing more specific
///         is available to leak.
/// @dev    ⚠️ THIS IS THE ONLY *MODULE* THAT MAY STOP A WALLET OUTRIGHT.
///         `IdentityRegistry.freeze` was removed on 2026-09-08 and every wallet-level stop —
///         sanctions, suspicion, probate, court order, lost key — now runs through one store.
///         Adding a second wallet-stop anywhere else re-opens the leak: an observer who can see
///         WHICH mechanism stopped a wallet learns the class, whatever the errors say. If a new
///         reason to stop a wallet appears, it goes in `RestrictedPartyRegistry`, not beside it.
/// @dev    ⚠️ THIS ADAPTER IS NOT THE ONLY READER OF THE STORE, AND MUST NOT BE. `SecurityToken`
///         and `DistributionAgent` each hold their own `IRestrictedParty` reference and read it in
///         their MANDATORY layer, above the module list. That is deliberate: registration here
///         is a governance action, so a module list that never gains this gate — or loses it to
///         one `removeModule` call — would silently stop enforcing sanctions. A concentration
///         limit is a policy choice a client may not owe; targeted financial sanctions are not.
///         The duplicate reads hit the SAME store and raise the SAME argument-free error, so
///         they cannot disagree and cannot leak. This gate is what reaches consumers that wire
///         only `ModularCompliance`.
/// @dev    The store holds NO reference to this gate, and the gate holds no state beyond the
///         reference. Rule evaluation stays in `ModularCompliance`: this is a store plus a
///         predicate, not a second compliance engine. Two contracts that can independently veto
///         a transfer for different reasons is how a reason code escapes the module that was
///         meant to stay silent.
/// @dev    ⚠️ NOTHING BELONGS IN THIS FILE BUT DELEGATION. The store is written against its
///         Articles and reverts with errors named for them; this adapter exists so that gate
///         never has to be widened to fit the rule engine. The moment a check is added here
///         there are two places to look for the Article, which is the one property the §13
///         Article→function audit map depends on. Split from `RestrictedPartyRegistry.sol` on
///         2026-09-07 — see the note there.
contract RestrictedPartyGate is ModuleAdapter {
    address public immutable governance;

    /// @dev Interface-typed and settable, per the standing rule. Never unset: a null reference
    ///      cannot distinguish "nobody wired it" from "not owed", and for this control there is
    ///      no "not owed".
    IRestrictedParty public restrictions;

    event DependencySet(bytes32 indexed what, address impl);

    error NotGovernance();
    error ZeroAddress();

    modifier onlyGovernance() {
        if (msg.sender != governance) revert NotGovernance();
        _;
    }

    constructor(bytes32 moduleId_, address governance_, address restrictions_) ModuleAdapter(moduleId_) {
        if (governance_ == address(0) || restrictions_ == address(0)) revert ZeroAddress();
        governance = governance_;
        restrictions = IRestrictedParty(restrictions_);
        emit DependencySet("restrictions", restrictions_);
    }

    /// @notice Re-point the store. Swap, never unset — the operational-resilience regime requires
    ///         this reference stay swappable at the contract layer rather than hard-wired, and it
    ///         is the reason a routine update never needs `removeModule`.
    function setRestrictions(address impl) external onlyGovernance {
        if (impl == address(0)) revert ZeroAddress();
        restrictions = IRestrictedParty(impl);
        emit DependencySet("restrictions", impl);
    }

    /// @dev Gates BOTH sides on every movement, including mint and burn. A redemption paying
    ///      out to a listed person releases value exactly as a transfer does, so `to == 0` is
    ///      not a shortcut out of the sender check.
    function checkTransfer(address from, address to, uint256) external view override {
        restrictions.assertTransferPermitted(from, to);
    }
}
