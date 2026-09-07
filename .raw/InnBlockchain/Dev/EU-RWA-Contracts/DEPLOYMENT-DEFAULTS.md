---
title: Deployment Defaults — EU-RWA-Contracts
date: 2026-09-07
status: baseline wiring for every deployment; lane columns derived from §17's inventory in eu_tokenized_securities_smart_contract_design.md
---

# Deployment Defaults

What every deployment wires before it is considered configured. This is the **baseline**, not the
full inventory — lane-conditional contracts are listed in §17a of the design document and are
added on top of what is here.

Read this alongside `REMAINING-COMPLIANCE.md`, which lists what is *missing*. This file lists what
must be *present*.

---

## 1. `SanctionsGate` is in the baseline for every lane. No exceptions.

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

### Why this is a deployment default and not a code flag

A `REMOVABLE = false` marker on the module was considered and **rejected**.

The reason is the upgrade path. Replacing this gate — a bug fix, a re-point to a new store, a
migration — runs through `ModularCompliance.removeModule`. A flag that blocks removal blocks the
replacement with it, and a control you cannot fix is not a stronger control. It also would not
have worked as written: `removeModule` does not read any such flag today, so the marker asserted a
guarantee it did not provide, which is worse than not asserting it.

**Two things carry the weight instead:**

1. **This document.** The gate is in the baseline set; leaving it out is a deviation to justify,
   not a default to fall into.
2. **`ModuleRemoved` monitoring.** `ModularCompliance` emits `ModuleRemoved(module, moduleId)` on
   every removal. Removing the sanctions gate is therefore a conspicuous, individually logged
   governance act. **Put an alert on that event for this `moduleId`** — that is the operational
   commitment replacing the code-level flag, and it belongs in the resilience runbook.

### A routine update never needs removal

Worth knowing before anyone reaches for `removeModule` at all:

| To change | Call | Removal needed |
|---|---|---|
| Point the gate at a different store | `SanctionsGate.setSanctions(impl)` | No |
| Point the store at a different identity resolver | `SanctionsRegistry.setIdentity(impl)` | No |
| Rotate the screening operator | `SanctionsRegistry.setScreeningOperator(op, bool)` | No |
| Change the tolerated sweep lag | `SanctionsRegistry.setMaxSweepLag(seconds)` | No |
| Retire the control entirely | `ModularCompliance.removeModule(gate)` | Yes — and this is the act that should be conspicuous |

---

## 2. Baseline wiring order

Dependencies are constructor-set and then held behind governance setters, so ordering matters at
deployment even though nothing is immutable afterwards.

1. `ClaimTopicsRegistry`, `TrustedIssuersRegistry`
2. `IdentityRegistry` — takes both of the above
3. `SanctionsRegistry` — takes `IdentityRegistry`
4. `ModularCompliance`
5. `SecurityToken` — takes `IdentityRegistry` and `ModularCompliance`
6. `ModularCompliance.bindToken(token)` — **one-shot, and there is no rebind**
7. `SanctionsGate` — takes `SanctionsRegistry`; then `ModularCompliance.addModule(gate)`
8. Lane-conditional modules per §17a

**Then, before the first mint:**

- `SanctionsRegistry.setScreeningOperator(...)` for the screening service.
- `SanctionsRegistry.advanceListVersion(sourceHash)` and `recordSweep(version, n)` for the initial
  screen. **Until a sweep is recorded, `screeningIsStale()` is true and every mint reverts** —
  which is the intended state for a deployment that has not yet screened anyone, but it will look
  like a bug to whoever runs the first subscription. Record the initial sweep as part of go-live.

---

## 3. The module cap is a real budget

`ModularCompliance.MAX_MODULES` is **12**, and it is deliberately low — every module is an
external call on every transfer, and an unbounded list is a denial-of-service surface on the token
itself, borne by the holder trying to exit.

The baseline consumes one slot (`SanctionsGate`). A fund instrument admitted to trading on an
operator-run venue is the densest case and should be costed against the cap **before** the first
module is added, not discovered at the eleventh.

---

## 4. What this file does not cover

- **Lane scoping.** Which contracts a given client needs is §17a of the design document.
- **Cross-chain.** An operator running both an issuer lane on a public chain and a venue lane on a
  permissioned one has **two** `SanctionsRegistry` deployments and no atomic propagation between
  them. `listVersion` / `sweptToVersion` make the lag measurable per chain; closing it is an
  operational commitment with a stated worst-case, and it needs an owner. This is unresolved, not
  handled.
