---
title: Deployment Defaults — EU-RWA-Contracts
date: 2026-09-07
status: baseline wiring for every deployment; lane columns derived from §17's inventory in eu_tokenized_securities_smart_contract_design.md
updated: 2026-09-08 — SanctionsRegistry/SanctionsGate renamed to RestrictedPartyRegistry/RestrictedPartyGate; IdentityRegistry.freeze removed; the restriction store is now a mandatory constructor argument to SecurityToken and DistributionAgent
---

# Deployment Defaults

What every deployment wires before it is considered configured. This is the **baseline**, not the
full inventory — lane-conditional contracts are listed in §17a of the design document and are
added on top of what is here.

Read this alongside `REMAINING-COMPLIANCE.md`, which lists what is *missing*. This file lists what
must be *present*.

---

## 1. `RestrictedPartyRegistry` is in the baseline for every lane. No exceptions.

> **Renamed 2026-09-08.** `SanctionsRegistry` → `RestrictedPartyRegistry`, `SanctionsGate` → `RestrictedPartyGate`,
> `ISanctionsCheck` → `IRestrictedParty`, `setSeizureDestination` → `setPermittedDestination`. The store
> now holds **every** reason a wallet may not move — a sanctions listing, an AMLR Art 75 suspicion
> block, a probate hold, a court attachment, a lost-key hold — under one flag, and
> `IdentityRegistry.freeze` / `unfreeze` / `Investor.frozen` were **deleted**. The reason is that
> contract storage is public: two stores that can each stop a wallet let an observer read *which*
> one holds a person and infer the class, whatever the revert strings say. One store, one flag,
> one generic error.

### Three controls stop value moving. Keep them apart by what they act on.

This is the naming rule, and it is why the store is not called `FreezeRegistry` or `HoldRegistry`:

| Control | Acts on | Lifts when | Prefix |
|---|---|---|---|
| `RestrictedPartyRegistry` | a **party** — person or wallet, any reason | governance lifts it | `RestrictedParty*` |
| `SecurityToken.freezeUnits` | **units** — a parcel inside a live wallet | an agent unfreezes | `freeze*` / `frozenUnits` |
| `HoldingPeriodLock`, `PdmrClosedPeriodFreeze` | a **period** — a date restriction | expires on its own | `Holding*` / `ClosedPeriod*` |

`Freeze` was considered for the store and **rejected**: `freezeUnits` already stops value moving,
so an agent told to "freeze the wallet" reaches for `freezeUnits(wallet, fullBalance)` — which
compiles, works, and rebuilds the two-store leak. `Hold` was rejected because it reads as
`HoldingPeriodLock`. And the name must stay **class-neutral** — membership of a store named
`Sanctions`, `Watchlist` or `DeniedParty` *is* the disclosure, whatever the revert says.

"Probate hold" and "lost-key hold" remain in prose as names of real legal instruments. They are
never a name for the contract, its flag, or its gate.

**Wire it on every deployment — issuer, admitted-to-trading, venue and dealer alike — including
deployments that owe no anti-money-laundering obligation at all.**

That last clause is the whole point of this section, so it is worth stating why rather than
leaving it as a rule someone later reads as boilerplate:

- Almost every other module here answers to a regime a given client may or may not owe. A client
  outside the obliged-entity list drops the AML modules; a non-fund instrument drops the fund
  modules; an issuer that never runs a book drops the market-integrity ones. **Emptying the rule
  set is the intended way to scope a deployment down.**
- **Targeted financial sanctions do not work that way.** They bind irrespective of obliged-entity
  status. The design document says so directly at §4 and again at §17c(4): the screening a pure
  unlicensed issuer performs is grounded in sanctions law and counterparty risk, *not* in the AML
  articles — but it is still performed, and the citation is what changes, not the control.
- So the failure this section prevents is specific and quiet: a client correctly scopes out the
  AML modules and **takes sanctions enforcement out with them**, because both looked like the
  same category of thing on the module list.

### The store is a constructor argument, not just a module

**Changed 2026-09-08, and this is the substantive part of the rename.** `SecurityToken` and
`DistributionAgent` each now hold their own `IRestrictedParty` reference and read it in their
**mandatory** layer, above the module list:

- `SecurityToken._check` calls `restrictions.assertTransferPermitted(from, to)` between the identity reads
  and `compliance.checkTransfer`.
- `DistributionAgent._gate` calls `restrictions.isBlocked(holder)` unconditionally — *not* behind
  `d.runComplianceModules`, which is opt-in per distribution.

Both constructors reject `address(0)`, so **there is no wiring in which either contract exists
without a restriction store**. This closes a gap the rename would otherwise have opened: while the stop
lived on the investor record, `checkEligible` enforced it and no deployment could omit it; routing
it exclusively through `RestrictedPartyGate` would have demoted a control that binds irrespective of client
type into one governance can remove with a single call.

`RestrictedPartyGate` is still wired and still in the baseline module set. The two paths read the **same**
store and raise the **same** argument-free `TransferNotPermitted`, so the redundancy costs two
SLOADs and cannot disagree or leak. The gate is what reaches consumers that wire only
`ModularCompliance`.

### Why the module is a deployment default and not a code flag

A `REMOVABLE = false` marker on the module was considered and **rejected**.

The reason is the upgrade path. Replacing this gate — a bug fix, a re-point to a new store, a
migration — runs through `ModularCompliance.removeModule`. A flag that blocks removal blocks the
replacement with it, and a control you cannot fix is not a stronger control. It also would not
have worked as written: `removeModule` does not read any such flag today, so the marker asserted a
guarantee it did not provide, which is worse than not asserting it.

**Three things carry the weight instead:**

1. **The constructor arguments above.** Since 2026-09-08 this is the primary one: removing the
   module no longer removes the control from the token or the payout path.
2. **This document.** The gate is in the baseline set; leaving it out is a deviation to justify,
   not a default to fall into.
3. **`ModuleRemoved` monitoring.** `ModularCompliance` emits `ModuleRemoved(module, moduleId)` on
   every removal. Removing the restriction gate is therefore a conspicuous, individually logged
   governance act. **Put an alert on that event for this `moduleId`** — that is the operational
   commitment replacing the code-level flag, and it belongs in the resilience runbook.

### A routine update never needs removal

Worth knowing before anyone reaches for `removeModule` at all:

| To change | Call | Removal needed |
|---|---|---|
| Point the gate at a different store | `RestrictedPartyGate.setRestrictions(impl)` | No |
| Point the **token** at a different store | `SecurityToken.setRestrictions(impl)` | No |
| Point the **payout agent** at a different store | `DistributionAgent.setRestrictions(impl)` | No |
| Point the store at a different identity resolver | `RestrictedPartyRegistry.setIdentity(impl)` | No |
| Rotate the screening operator | `RestrictedPartyRegistry.setScreeningOperator(op, bool)` | No |
| Rotate the restriction registrar | `RestrictedPartyRegistry.setRestrictionRegistrar(addr, bool)` | No |
| Allow a seizure / estate destination | `RestrictedPartyRegistry.setPermittedDestination(addr, bool)` | No |
| Change the tolerated sweep lag | `RestrictedPartyRegistry.setMaxSweepLag(seconds)` | No |
| Retire the module | `ModularCompliance.removeModule(gate)` | Yes — conspicuous, and it does **not** retire the control: the token and the payout agent still read the store |

⚠️ **A re-point is three calls, not one.** `RestrictedPartyGate.setRestrictions`, `SecurityToken.setRestrictions` and
`DistributionAgent.setRestrictions` are independent. Doing one and not the others leaves two stores live
with different contents — which is the exact observability failure the consolidation was meant to
end. Treat them as one atomic governance action.

### Two write roles, one flag

`RestrictedPartyRegistry` has **two** writers and they are not interchangeable:

| Role | Set by | Writes | Typical holder |
|---|---|---|---|
| `isScreeningOperator` | `setScreeningOperator` | `blockRecord` / `blockWallet` | the list-screening vendor |
| `isRestrictionRegistrar` | `setRestrictionRegistrar` | `blockRecord` / `blockWallet` | the transfer agent / registrar, for probate, court orders, lost keys |

Release — `unblockRecord` / `unblockWallet` — is **governance only** for both. Placing a restriction is an
operational act that fails safe; lifting one releases a frozen position and is not delegated.

Both roles write the **same** flag, and nothing on-chain records which one wrote it. That is
deliberate: a `reason` field would be readable by anyone and would re-create the classification
leak inside a single store.

---

## 2. Baseline wiring order

Dependencies are constructor-set and then held behind governance setters, so ordering matters at
deployment even though nothing is immutable afterwards.

1. `ClaimTopicsRegistry`, `TrustedIssuersRegistry`
2. `IdentityRegistry` — takes both of the above
3. `RestrictedPartyRegistry` — takes `IdentityRegistry`
4. `ModularCompliance`
5. `SecurityToken` — takes `(governance, ModularCompliance, IdentityRegistry, RestrictedPartyRegistry, name, symbol, decimals, isinHash)`
6. `ModularCompliance.bindToken(token)` — **one-shot, and there is no rebind**
7. `RestrictedPartyGate` — takes `RestrictedPartyRegistry`; then `ModularCompliance.addModule(gate)`
8. `DistributionAgent` — takes `(governance, IdentityRegistry, ModularCompliance, RestrictedPartyRegistry)`
9. Lane-conditional modules per §17a

⚠️ **`RestrictedPartyRegistry` moved up the order on 2026-09-08.** It was already step 3, but it was only a
dependency of the gate at step 7. It is now a constructor argument to `SecurityToken` at step 5 and
to `DistributionAgent` at step 8, so deploying it late no longer produces a token that merely lacks
a module — it produces a token that will not deploy at all.

**Three of the lane-conditional contracts take `IdentityRegistry` as well**, so it is a dependency
of far more than the transfer hook: `CovenantRegistry`, `MemberEligibility` and — since 2026-09-08
— `PdmrRegister`, which now takes `(registrar, identity)`. `PdmrRegister` needs it because a
manager's `personId` must be the identity registry's `recordPointer` where the manager is also a
registered investor; without it the register mints a second person namespace and the MAR
Art 19(1a) aggregation is assembled across the wrong set of wallets. Deploy the identity registry
before any of them.

**Then, before the first mint:**

- `RestrictedPartyRegistry.setScreeningOperator(...)` for the screening service.
- `RestrictedPartyRegistry.setRestrictionRegistrar(...)` for the transfer agent, if the deployment expects probate,
  court-ordered or lost-key restrictions — which is every deployment with natural-person holders.
- `RestrictedPartyRegistry.advanceListVersion(sourceHash)` and `recordSweep(version, n)` for the initial
  screen. **Until a sweep is recorded, `screeningIsStale()` is true and every mint reverts** —
  which is the intended state for a deployment that has not yet screened anyone, but it will look
  like a bug to whoever runs the first subscription. Record the initial sweep as part of go-live.

---

## 3. The module cap is a real budget

`ModularCompliance.MAX_MODULES` is **12**, and it is deliberately low — every module is an
external call on every transfer, and an unbounded list is a denial-of-service surface on the token
itself, borne by the holder trying to exit.

The baseline consumes one slot (`RestrictedPartyGate`). A fund instrument admitted to trading on an
operator-run venue is the densest case and should be costed against the cap **before** the first
module is added, not discovered at the eleventh.

---

## 4. Two operating rules with no on-chain enforcement

Both are consequences of the 2026-09-08 consolidation. Both need an owner in the runbook; neither
is enforced by any `require`.

1. **`SecurityToken.freezeUnits` is for partial parcels only.** Its `frozenUnits` mapping is
   public, so an agent who freezes 100% of a wallet's balance has built a second, readable,
   wallet-level stop — exactly the two-store leak the consolidation removed. A whole-wallet stop
   goes in `RestrictedPartyRegistry`. The function is kept because a freeze over a disputed or collateralised
   parcel is a genuinely different mechanic and routing it through the restriction store would
   over-freeze, which is its own exposure to the holder.

2. **A restriction that must survive a lost key goes on the RECORD, not the wallet.**
   `SecurityToken.recoverWallet` runs no transfer gate — by design, since its control is the
   record-pointer match rather than the agent role. So `RestrictedPartyRegistry.blockWallet(lostWallet)` is
   left behind and the units land in a second, unrestricted wallet of the same investor.
   `blockRecord` follows, because both wallets resolve to the same pointer. Prefer `blockRecord`
   wherever the subject is a person rather than a specific key.

---

## 5. What this file does not cover

- **Lane scoping.** Which contracts a given client needs is §17a of the design document.
- **Cross-chain.** An operator running both an issuer lane on a public chain and a venue lane on a
  permissioned one has **two** `RestrictedPartyRegistry` deployments and no atomic propagation between
  them. `listVersion` / `sweptToVersion` make the lag measurable per chain; closing it is an
  operational commitment with a stated worst-case, and it needs an owner. This is unresolved, not
  handled.
