---
title: Deployment Defaults — EU-RWA-Contracts
date: 2026-09-07
status: baseline wiring for every deployment; lane columns derived from §17's inventory in eu_tokenized_securities_smart_contract_design.md
updated: 2026-09-11 — the suite implements ERC-3643 from the EIP text (design rev 54, §16 D0 closed); new step 2a (setCountryCode), a fourth go-live row, a third operating rule (setAddressFrozen), and the freezeUnits→freezePartialTokens / recoverWallet→recoveryAddress renames. Read ERC-3643-CONFORMANCE.md first. Prior update 2026-09-09 — IdentityRegistry re-keyed from the wallet to the person (Person / WalletBinding); PersonErasure added as the single GDPR Art 17 entry point, with erasureCoordinator setters on five contracts. Prior update 2026-09-08 — SanctionsRegistry/SanctionsGate renamed to RestrictedPartyRegistry/RestrictedPartyGate; IdentityRegistry.freeze removed; the restriction store is now a mandatory constructor argument to SecurityToken and DistributionAgent
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
| `SecurityToken.freezePartialTokens` | **units** — a parcel inside a live wallet | an agent unfreezes | `*PartialTokens` / `frozenUnits` |
| `SecurityToken.setAddressFrozen` | a **whole address** — ⚠️ see below | an agent unfreezes | `setAddressFrozen` / `isFrozen` |
| `HoldingPeriodLock`, `PdmrClosedPeriodFreeze` | a **period** — a date restriction | expires on its own | `Holding*` / `ClosedPeriod*` |

`Freeze` was considered for the store and **rejected**: `freezePartialTokens` already stops value
moving, so an agent told to "freeze the wallet" reaches for `freezePartialTokens(wallet, fullBalance)`
— which compiles, works, and rebuilds the two-store leak. `Hold` was rejected because it reads as
`HoldingPeriodLock`. And the name must stay **class-neutral** — membership of a store named
`Sanctions`, `Watchlist` or `DeniedParty` *is* the disclosure, whatever the revert says.

> ⚠️ **Row 3 is new on 2026-09-11 and it is a residual, not a control you should use.**
> `setAddressFrozen` / `isFrozen` are **mandatory members of `IERC3643`** — the standard requires a
> public, wallet-keyed, whole-address stop, so implementing the interface puts one back into
> existence outside `RestrictedPartyRegistry`. That is exactly the two-store leak the 2026-09-08
> rename was written to close, reopened by the standard rather than by a naming slip.
>
> **What is and is not mitigated:** the flag is class-neutral and the revert is argument-free, so a
> reader learns *that* an address is stopped, not *why* — the AMLR Art 76 limb holds. What does not
> hold is the single-store property: `isFrozen` is a public getter, so an observer can ask "is this
> wallet stopped by the token?" separately from "is this party restricted?", and a wallet stopped by
> only one of the two narrows the class. **Operating rule: route every party-level stop through
> `RestrictedPartyRegistry`, and use `setAddressFrozen` only where a counterparty tool needs the
> standard's own surface to see the stop — in which case set both.** Nothing on-chain enforces this.
> Full statement in `ERC-3643-CONFORMANCE.md` §5.1.

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
  and `_assertCompliant` (which asks `ICompliance.canTransfer` first and only falls back to the
  suite's reverting `checkTransfer` to recover a reason — see `ERC-3643-CONFORMANCE.md` §3, C1).
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
| `isScreeningOperator` | `setScreeningOperator` | `blockPerson` / `blockWallet` | the list-screening vendor |
| `isRestrictionRegistrar` | `setRestrictionRegistrar` | `blockPerson` / `blockWallet` | the transfer agent / registrar, for probate, court orders, lost keys |

Release — `unblockPerson` / `unblockWallet` — is **governance only** for both. Placing a restriction is an
operational act that fails safe; lifting one releases a frozen position and is not delegated.

Both roles write the **same** flag, and nothing on-chain records which one wrote it. That is
deliberate: a `reason` field would be readable by anyone and would re-create the classification
leak inside a single store.

---

## 2. Baseline wiring order

Dependencies are constructor-set and then held behind governance setters, so ordering matters at
deployment. ⚠️ **"Nothing is immutable afterwards" was never true and is not true now** — 95
`immutable` declarations remain across the suite, and the ones that are load-bearing are listed
under **D20** in the design. What follows is the constructor order, not a claim about mutability.
⚠️ *Rewritten 2026-09-08 — this list was stale in three places after the code-review
fix pass, and the per-layer sections at the end of this file record the individual changes. **This
list is the authoritative order; where a later section disagrees, this one wins.***

0. **`DoraGovernor`** — takes `(governance)`. **First, because it is the protocol pause** and the
   token, the fund modules, `DistributionAgent` and `BuybackAgent` all take it as a non-zero
   constructor argument. *(New at step 0 on 2026-09-08; it used to be a lane-conditional
   afterthought, which is how the pause ended up with no readers.)*
1. `ClaimTopicsRegistry`, `TrustedIssuersRegistry` — each takes `(governance)`
2. `IdentityRegistry` — takes `(governance, claimTopics, trustedIssuers)`
2a. **`IdentityRegistry.setCountryCode(jurisdiction, country)` for every jurisdiction the deployment
   will admit** — ⚠️ **new on 2026-09-11, and it is a go-live item, not a nicety.** `IERC3643`
   requires `investorCountry(wallet)` to return an ISO-3166 numeric `uint16`. This suite stores the
   jurisdiction as an alpha-2 `bytes32` on the **person**, so the numeric is *derived* through this
   mapping and **never stored per investor** — which is what keeps the `uint16` out of per-person
   storage (see `ERC-3643-CONFORMANCE.md` §4, D-I4 and §5.4). Consequences of skipping it:
   `investorCountry` returns 0 for holders in an unmapped jurisdiction, and
   `registerIdentity(wallet, id, country)` — the standard's own registration entry point —
   **reverts `UnknownCountryCode`**. The suite's native `bindWallet` path is unaffected, so a
   deployment can run for months before a counterparty tool using the standard surface hits it.
   The mapping is **not** re-pointable in either direction; `country == 0` retires an entry.
2b. **`IdentityRegistry.setTierAxis(axisId)` — ⚠️ a go-live item, and skipping it bricks three
   contracts rather than degrading them.** There is no longer an `AXIS_MIFID` constant; the axis
   carrying the `Tier` encoding is nominated per deployment, which is what lets a non-MiFID client
   run the same contracts. Until it is set, `tierOf` and `isRetail` **revert
   `TierAxisNotConfigured`** — deliberately, because `SettlementEngine.giveReuseConsent`,
   `MemberEligibility` and `SubscriptionEscrow.subscribe` all read them as *positive* gates, and a
   registry answering `false` would switch the retail controls off for everyone rather than
   failing loudly. Pick any `bytes32`; `keccak256("axis.mifid2.annexII")` is the conventional one.
   Open further axes with `registerAxis` (a national-law overlay classifying on its own terms),
   bounded at `MAX_AXES = 8` — **the bound is `erasePerson`'s gas budget, not a style limit.**

   ⚠️ **A classification value must be 0–7 (`MAX_CLASSIFICATION_VALUE`), and this is a correctness
   bound.** The predicate matches with `classMask & uint8(1 << value)`; for `value >= 8` that shift
   is zero, the mask test passes trivially, and the covenant reports **not-applicable** — silently
   switching every masked entry off for that investor. MiFID's `Tier` tops out at 4, so nothing has
   hit it; an axis opened for another purpose would. `setClassification` and `setClassifier` now
   refuse out-of-range values, and the predicate fails **closed** on one that predates those checks.**
2c. **Classifications are no longer written by `registerPerson`.** It takes
   `(personId, personType, jurisdiction, expiresAt)` — the `Tier` argument is gone, as it is from
   `updatePerson(personId, jurisdiction, expiresAt)` and
   `registerInvestor(wallet, personType, jurisdiction, personId, expiresAt)`. A person is
   registered carrying **no** classification on any axis; write each one afterwards with
   `setClassification(personId, axisId, value)`. ⚠️ **An axis nobody wrote reads unset and every
   predicate keyed on it fails closed** — which is the intended behaviour, and the reason
   `Tier.Unset` no longer needs to exist as a stored value. Onboarding is therefore two calls, not
   one, and a deployment that forgets the second blocks transfers rather than admitting them.
3. `RestrictedPartyRegistry` — takes `(governance, identity, maxSweepLag)`
4. `ModularCompliance` — takes `(governance)`
5. `SecurityToken` — takes `(governance, compliance, identity, restrictions, protocolPause, name, symbol, decimals, isinHash)`
6. `ModularCompliance.bindToken(token)` — **one-shot, and there is no rebind.** ⚠️ `IERC3643`'s
   `ICompliance` declares `unbindToken(address)`; this suite implements it as
   `external pure { revert UnbindNotSupported(); }`. It is present because the interface requires
   the selector and **absent as a capability** because unbinding a live compliance contract from a
   live token is a state nothing in §4–§10 can recover from. A wrong `bindToken` means redeploy.
   Declared as D-C1 in `ERC-3643-CONFORMANCE.md` §4.
7. `RestrictedPartyGate` — takes `(moduleId, governance, restrictions)`; then `ModularCompliance.addModule(gate)`
7a. ⚠️ **Decide the covenant set from this asset's own terms, and have a second person check it.
   This step replaced a contract control on 2026-09-21 and is the only thing standing where that
   control used to be.** `CovenantRegistry` no longer carries a product-attribute dimension —
   there is no `setProductAttribute`, no `Comparator`, no `productKey`/`productCmp`/`productValue`.
   A covenant can no longer say *"applies where fund life > 10 years"*; **whether an obligation is
   owed is decided entirely by whether you configure its entry on this deployment.** The registry
   is per asset, so the fund's terms are fixed and known at this point — that is why the
   comparison was removed, and it is also why nothing on-chain can catch getting this wrong.

   **Configure from the fund's terms:**

   | If this asset is… | Configure |
   |---|---|
   | an ELTIF with a life **over 10 years** | **ELTIF Art 18(3)** — the written long-commitment warning |
   | an ELTIF with a life **of 10 years or less** | **not** Art 18(3) |
   | retail-accessible | PRIIPs Art 13 · ELTIF Art 26 |
   | professional-only | neither of those two — but confirm against Art 13(7), which is a separate entry |
   | admitted to a DLT market infrastructure | DLT Pilot Arts 4(2)(c)–(f) and 4(2)(g) |
   | admitted to trading (MAR in scope) | MAR Art 19(5) · Art 18 |

   ⚠️ **The failure mode, stated plainly because it is silent.** An asset that *should* carry
   Art 18(3) and does not will **pass every transfer with no warning collected and nothing
   reverting**. There is no unevaluable state to trip, no event, and `diagnose()` cannot report a
   covenant that was never configured. The old dimension would have blocked the token instead —
   that trade was made deliberately (see the note on `_grant` in `CovenantRegistry`), and the
   compensating control is this checklist plus a **recorded second-person sign-off tying the
   configured covenant set to the fund's terms**. Keep that record with the offer documents; it
   is the only evidence the decision was made rather than missed.

   ⚠️ **The ELTIF RTS Art 5(10) exemption is the second condition that left the contract (2026-09-21).**
   `GrantPolarity`, the grant store and `setRegulatoryGrant` are gone. A professional-only open-ended
   ELTIF that is exempted by its competent authority from the **Art 5(8)** and **Art 5(9)** information
   duties now expresses that with `setCovenantActive(id, false)` on **both** entries.

   | Exemption state | Both covenants |
   |---|---|
   | not applied for, or pending | **active** — the duties apply until the authority says otherwise |
   | granted | **inactive** |
   | refused, or withdrawn after review | **active** again |

   ⚠️ **Toggle the two together, in one governance batch.** A single regulator decision governs both
   entries, and the contract no longer holds them in step — activating Art 5(8) and forgetting Art 5(9)
   leaves one duty live and the other silently off. **Record the exemption reference alongside the
   toggle**; there is no longer an on-chain event naming the grant, so `CovenantDeactivated` is the only
   trace and it does not say on whose authority.

   ⚠️ **`configureCovenant` lost its `Scope` argument (2026-09-21) — deployment scripts must be
   updated.** The signature is now
   `(covenantId, documentRef, gates, attestor, invalidation, expiryPeriod, effectiveFrom, predicate)`,
   and `CovenantConfigured` no longer carries a scope. The `Scope` enum is deleted: it was read by a
   single `require` in `setClassifier` and **never at runtime**, so it enforced a label while naming
   a guarantee the contract did not provide.

   ⚠️ **What that label was promising, and what you must now do by hand.** A classification lives in
   the **shared** `IdentityRegistry`; the covenant proving it lives in **this per-asset store**. So an
   investor who signs the MiFID opt-up against Token A **resolves to the fallback (retail) against
   Token B** — they must sign once per token. That was true while the enum existed; deleting it only
   stopped the schema from implying otherwise. **Configure every classifier covenant identically on
   every deployment**, and treat "signed the opt-up" as a per-token fact in onboarding.

   ⚠️ **If acknowledgements genuinely need to span assets, the topology is the fix, not a field.**
   Deploy one registry holding only the cross-asset covenants and give each token a **second**
   `CovenantGate` pointed at it — `CovenantGate.covenants` is `immutable` per deployment and
   `ModularCompliance` takes a module list, so two gates reach two registries. Note the cost before
   choosing it: two contracts can then refuse a transfer independently, which is the reason-code leak
   the single-evaluator rule exists to prevent.

   ⚠️ **A person carries ONE jurisdiction — residence (2026-09-21).** `needsMultiJurisdiction` is gone
   from the predicate. A covenant may still name several Member States; an investor may not. **Covenants
   keying on tax residence or nationality are not supported** — do not configure one and expect it to be
   narrowed correctly. None of the six baseline obligations is jurisdiction-keyed at all, so this only
   arises with a national-law overlay, and that is the point to revisit the person record with counsel.

   ⚠️ **`mayUpgrade` is gone too, and with it the "contract option" for the classification-ordering rule.**
   There is no on-chain check that an elective classification has its covenant behind it before the identity
   registry writes it. It cannot exist in this topology: the identity registry is shared, covenant stores are
   per asset, so there is no single store to ask. **Hold the ordering as a process control** — the claims
   service must not write an elective classification without a recorded covenant, and the two must reconcile
   off-chain for audit. Name an owner for that reconciliation.

   ⚠️ **Re-check it whenever the fund's terms change.** A life extension, a change from
   professional-only to retail-accessible, or an admission to trading each change which entries
   are owed. Adding one to a live asset is a **cutover, not a toggle** — see the `effectiveFrom`
   note in §2's `CovenantRegistry` section; for an investor-signature covenant the back-record is
   a collection campaign against the whole existing base.
8. `DistributionAgent` — takes `(governance, identity, compliance, restrictions, protocolPause)`
9. **Arm the pause and the screening guard before anything can mint** — see the go-live checklist below
10. Lane-conditional modules per §17a — note `ValuationOracle` takes `(governance)` and must
    precede every fund module, and that `DoraGovernor.setOracleTripSource(oracle)` /
    `ValuationOracle.setCircuitBreaker(governor)` are a **mutual** pair: set both or the trip is
    a one-way call into nothing
11. **`PersonErasure`** — takes `(governance, identityRegistry)`. **Last, because its target list is
    every erasable contract the deployment actually has**, and a lane-conditional contract deployed
    after it will not register itself. See §5.

### Go-live: three things that are inert until someone arms them

Each fails in the safe direction, and each will read as a bug to whoever runs the first transaction.

| What | Until it is armed | Arm it with |
|---|---|---|
| **Screening staleness** | `screeningIsStale()` is **true**, so **every mint reverts** | `advanceListVersion` then `recordSweep` — both, once, after the first full base sweep |
| **Oracle circuit breaker** | A deviation halt pauses **nothing** | `DoraGovernor.setOracleTripSource(oracle)` **and** `ValuationOracle.setCircuitBreaker(governor)` |
| **Offer close (Prospectus mode)** | `settle()` reverts `OfferStillOpen` and no escrow ever releases | `SubscriptionEscrow.setOfferClose(ts)` — extend-only, so set it when the offer opens, not at the end |
| **ISO-3166 country map** | `investorCountry(wallet)` returns **0** for every holder, and `registerIdentity(...)` reverts `UnknownCountryCode`. Nothing in this suite's own gates reads either, so **no test transaction finds this** — it surfaces at the first counterparty integration against the standard surface | `IdentityRegistry.setCountryCode(jurisdiction, country)`, once per admitted jurisdiction. Not re-pointable; `country == 0` retires an entry |
| **Erasure path** | Every `erasePerson` leg reverts `NotErasureCoordinator`, so **an Art 17 request cannot be executed at all** — and unlike the three above, nobody finds this out on day one. It surfaces on the first DSAR, inside the Art 12(3) month | `IdentityRegistry.setErasureCoordinator` **and** the same setter on each of the four targets, **and** `PersonErasure.registerTarget` for each, **and** `setEraser` for at least one key. All four, or the path is broken in a way no test transaction exercises — see §5 |

⚠️ **`SubscriptionEscrow` is never deployed behind a proxy.** `mode` and `finalPriceOmittedAtFiling`
are immutable on purpose — they are disclosure items — and through a proxy an implementation's
constructor values are what every instance reads. See `UPGRADE-ARCHITECTURE.md` §10 and **D20**,
which is unresolved for the rest of the suite: **no contract here has been cleared for a proxy.**

⚠️ **`RestrictedPartyRegistry` moved up the order on 2026-09-08.** It was already step 3, but it was only a
dependency of the gate at step 7. It is now a constructor argument to `SecurityToken` at step 5 and
to `DistributionAgent` at step 8, so deploying it late no longer produces a token that merely lacks
a module — it produces a token that will not deploy at all.

**Three of the lane-conditional contracts take `IdentityRegistry` as well**, so it is a dependency
of far more than the transfer hook: `CovenantRegistry`, `MemberEligibility` and — since 2026-09-08
— `PdmrRegister`, which now takes `(registrar, identity)`. `PdmrRegister` needs it because a
manager's `personId` must be the identity registry's `personId` where the manager is also a
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

## 4. Three operating rules with no on-chain enforcement

The first two are consequences of the 2026-09-08 consolidation; the third arrived with `IERC3643`
on 2026-09-11. All three need an owner in the runbook; none is enforced by any `require`.

1. **`SecurityToken.freezePartialTokens` is for partial parcels only.** Its `frozenUnits` mapping is
   public — as is the EIP's `getFrozenTokens` accessor over it — so an agent who freezes 100% of a
   wallet's balance has built a second, readable,
   wallet-level stop — exactly the two-store leak the consolidation removed. A whole-wallet stop
   goes in `RestrictedPartyRegistry`. The function is kept because a freeze over a disputed or collateralised
   parcel is a genuinely different mechanic and routing it through the restriction store would
   over-freeze, which is its own exposure to the holder. *(Renamed from `freezeUnits` when the
   token adopted `IERC3643`. The storage mapping keeps its `frozenUnits` name — the EIP names the
   **accessor**, `getFrozenTokens`, not the slot.)*

2. **A restriction that must survive a lost key goes on the RECORD, not the wallet.**
   `SecurityToken.recoveryAddress` runs no transfer gate — by design, since its control is the
   `personId` match rather than the agent role. So `RestrictedPartyRegistry.blockWallet(lostWallet)` is
   left behind and the units land in a second, unrestricted wallet of the same investor.
   `blockPerson` follows, because both wallets resolve to the same `personId`. Prefer `blockPerson`
   wherever the subject is a person rather than a specific key. *(Renamed from `recoverWallet`.
   ⚠️ The EIP signature carries a third `IIdentity` argument this suite does not read — see
   `ERC-3643-CONFORMANCE.md` §5.2.)*

3. **⚠️ `setAddressFrozen` and `RestrictedPartyRegistry` must not be allowed to disagree.** The
   standard's whole-address stop is a second, public, wallet-keyed store, and the consolidation
   that removed the first one cannot remove this one — `IERC3643` requires it. Route every
   party-level stop through `RestrictedPartyRegistry`; use `setAddressFrozen` only where a
   counterparty tool needs the stop visible on the standard surface, and when you do, **set both**.
   A wallet stopped by exactly one of the two is the leak: it tells an observer which store holds
   the person, which is the class. See §1's row 3 and `ERC-3643-CONFORMANCE.md` §5.1.

---

## 5. `PersonErasure` — the GDPR Art 17 path, and it is inert until five things are wired

*Added 2026-09-09 with the person-keyed `IdentityRegistry` refactor.*

`PersonErasure` is the **single entry point** for an erasure request. `execute(personId, reasonHash)`
reads `walletsOfPerson` from `IdentityRegistry`, fans out to every registered `IErasable` target,
and calls `IdentityRegistry.erasePerson` **last**. The ordering is load-bearing: three of the four
targets are address-keyed and cannot expand a `personId` themselves, so they need the wallet list
the registry is about to delete.

**Wire all five, or the path does not exist:**

1. Deploy `PersonErasure(governance, identityRegistry)`.
2. `IdentityRegistry.setErasureCoordinator(personErasure)` — governance-only.
3. `setErasureCoordinator(personErasure)` on **each target**: `CovenantRegistry`,
   `MemberEligibility`, `PdmrRegister`, `SubscriptionEscrow`. Each is governance-only, and each
   leg reverts `NotErasureCoordinator` until it is set.
4. `PersonErasure.registerTarget(...)` for each of those four. **A target that is deployed but not
   registered is silently skipped** — the run succeeds and leaves that contract's residue behind.
5. `PersonErasure.setEraser(key, true)` for at least one key. ⚠️ **Do not reuse a registrar key.**
   The role that onboards must not be the role that erases; that separation is the reason the
   contract has its own role table rather than reusing `onlyRegistrar`.

Optionally `setExecutionDelay(seconds)` — default **24 hours**, hard cap `MAX_EXECUTION_DELAY`
**7 days**. It is an operator parameter, not a statutory figure, and it lives inside the GDPR
Art 12(3) one-month response window.

### ⚠️ Two contracts must NEVER be registered as targets

| Contract | Why not |
|---|---|
| `IdentityRegistry` | It is erased **last**, directly, through `IIdentityErasure`. Registering it as an ordinary target calls it mid-run and destroys the wallet list the remaining targets depend on. Nothing on-chain detects the mistake — the registry does not implement `IErasable`, so the call reverts with no data. |
| `RestrictedPartyRegistry` | **GDPR Art 17(3)(b).** The erasure right does not apply where processing is necessary for compliance with a legal obligation, and an EU sanctions listing is exactly that. Erasing it on request deletes the reason the platform must refuse the transfer. |

### The fan-out is atomic, and three legs refuse on purpose

A target that reverts stops the **whole** request — a half-erased person is worse than an un-erased
one, and a receipt for an erasure that did not happen is worse than both. Expect these:

| Leg | Reverts | Clear it by |
|---|---|---|
| `MemberEligibility` | `MemberStillAdmitted(wallet)` | `withdrawMember` first. A live admission is a DLT Pilot Art 4(2) decision and a row in the Art 11(4) report to the NCA. |
| `SubscriptionEscrow` | `OfferStillOpen()` | Wait for `offerClosesAt`. Releasing an Art 1(4)(b) headcount slot mid-offer lets the same person be counted twice. |
| `PdmrRegister` | `NotDeclared` / `RetentionNotExpired(purgeableAt)` | Revoke the declaration, then wait out `RETENTION_PERIOD`. ⚠️ **MAR Art 19 imposes no retention period** — that window is operator policy by analogy to Art 18(5); the live duty is the standing Art 19(5) list. |

`PdmrRegister` also **ignores the wallet list passed in** and uses its own `_walletsOfPerson`: a
director may declare a wallet here that was never bound in the identity registry, and the two sets
can legitimately differ.

**Use `previewErasure(personId)` before `request`.** It reports which targets would run and which
would be skipped, which is the only way to find an unregistered target before the DSAR clock is
already running.

⚠️ **Complete as to storage, silent as to history.** This coordinator reaches every `delete`-able
field in five contracts. It reaches **no event and no calldata**. That residue is a DPIA statement
(design doc §10), not something a deployment step can fix.

---

## 6. What this file does not cover

- **Lane scoping.** Which contracts a given client needs is §17a of the design document.
- **Cross-chain.** An operator running both an issuer lane on a public chain and a venue lane on a
  permissioned one has **two** `RestrictedPartyRegistry` deployments and no atomic propagation between
  them. `listVersion` / `sweptToVersion` make the lag measurable per chain; closing it is an
  operational commitment with a stated worst-case, and it needs an owner. This is unresolved, not
  handled.

---

## 2026-09-08 fixes — token/identity layer

Applied against `CODE-REVIEW-2026-09-08.md` (H1, H7b, M-T1, M-T3–M-T7, section 3 table). What
changes for a deployer:

### `SecurityToken` constructor gained a parameter — wiring order in §2 step 5 is now stale

New signature:

```
SecurityToken(governance, ModularCompliance, IdentityRegistry, RestrictedPartyRegistry, protocolPause, name, symbol, decimals, isinHash)
```

`protocolPause` is the contract answering `IProtocolPause.paused()` — `DoraGovernor` in the
baseline. It is rejected at `address(0)`, re-pointable through `setProtocolPause(impl)`
(governance, emits `ProtocolPauseChanged(old, new)`), and read by `whenLive` on **voluntary paths
only**: `transfer`, `transferFrom`, `mint`, `burn`, `simulate`. `forcedTransfer` and
`recoveryAddress` (named `recoverWallet` when this note was written) run during a protocol pause
exactly as they run during the agent's own `paused`.
**`DoraGovernor` must therefore deploy before the token** — insert it between steps 4 and 5.

### `burn` is now `whenLive`

It was the one voluntary movement that ignored `paused`. A redemption during an oracle deviation
halt is paid at a figure the halt exists to say is unreliable. Buy-back disposals
(`BuybackAgent.disposeUnits`) and redemption burns will revert while either pause is in force —
this is intended.

### `forcedTransfer` reads the restriction store in the mandatory layer (H1)

`restrictions.assertTransferPermitted(from, to)` now runs on the forced path above the module
list, so `removeModule(RestrictedPartyGate)` / `emergencyBypass(gate)` no longer opens a route
that lands units on a listed person or releases them from one. The sender limb is relieved
**only** by `RestrictedPartyRegistry.setPermittedDestination` — that is the seizure / estate
mechanism, unchanged. Also: sender-side **module** rules do apply on a forced transfer (a
`HoldingPeriodGate` lock will refuse a seizure during ramp-up). Where the order overrides the
lock, the mechanism is `ModularCompliance.emergencyBypass` on that module — logged — not a hidden
branch in the token. `forcedTransfer(w, w, …)` and `recoveryAddress(w, w, …)` revert `SameWallet`.

### Go-live: `screeningIsStale()` is now genuinely true until the first sweep (M-T3)

The §2 "before the first mint" note was describing a control that did not exist — both counters
started at 0 so a fresh store reported itself current. Now `sweptToVersion == 0` is stale and
`recordSweep(0, …)` is refused, so **every mint reverts `ScreeningStale()` until
`advanceListVersion(sourceHash)` and then `recordSweep(version, n)` have each run once.** Both
are `onlyScreeningOperator`, so `setScreeningOperator` precedes them. Voluntary transfers between
existing holders are unaffected (staleness blocks entry, not exit).

### `IdentityRegistry` — references settable, claim expiry bounded, `Tier` imported

- `claimTopics` / `trustedIssuers` are no longer `immutable`. Constructor rejects `address(0)`;
  the setters are governance-only and emit `…Changed(old, new)`. Swapping the issuer registry
  re-validates every stored claim against the new list on its next read — migrate the issuer set
  first.
  - ⚠️ **The EIP names are the only names**: `setClaimTopicsRegistry(impl)` /
    `setTrustedIssuersRegistry(impl)`. The house aliases `setClaimTopics(impl)` /
    `setTrustedIssuers(impl)` were introduced 2026-09-11 and **removed 2026-09-15** — one act,
    one selector, no second supported API. Nothing in this suite ever called them; any script
    outside it that does will now revert, which is the intended failure. Both events
    (`…Changed(old, new)` and the EIP's `…RegistrySet`) are still emitted on the one path.
  - ⚠️ **`IdentityRegistry` is now `IAgentRole`-compatible, and the registrar is the agent.**
    `addAgent(a)` / `removeAgent(a)` / `isAgent(a)` are the standard's names for
    `setRegistrar(a, true)` / `setRegistrar(a, false)` / `isRegistrar(a)` — one mapping, one
    write path, both event vocabularies emitted (`RegistrarSet` **and**
    `AgentAdded`/`AgentRemoved`). `SecurityToken` gains the same three names over its own,
    **separate** agent set. **Do not merge the two key sets** — the registrar onboards, the
    token agent mints and seizes, and DORA Art 5 wants those accountable to different people.
  - ⚠️ **`setIdentityRegistryStorage` reverts `IdentityStorageNotSupported()` and
    `identityStorage()` returns `address(0)`** — deviation D-I5, a data-protection refusal of the
    shared-store model, not a missing feature. Do not wire a storage contract expecting it to
    take effect.
- `setClaim` **rejects `expiresAt == 0`**, `expiresAt <= now`, and
  `expiresAt > now + maxClaimValiditySeconds` (default 5 × 365 days;
  `setMaxClaimValiditySeconds` governance-only, emits). There is no "never expires" claim. A claim
  is invalid **at** its expiry second (`>=`), as is an investor record's `expiresAt`.
  `Investor.expiresAt == 0` keeps its "no scheduled refresh" meaning — it is the registrar's
  horizon, not an issuer's.
- `Tier` is imported from `Interfaces.sol`; `IdentityRegistry.Tier` no longer resolves. Name
  `Tier`. `IdentityRegistry is IIdentityGate` is now declared.

### `ClaimTopicsRegistry` — topic 2 retired, retirement enforced on-chain

`TOPIC_AML_SCREENED` is gone. Retired set {2, 8, 22–26} is seeded in the constructor and
`addBaselineTopic` / `addAdditionalTopic` revert `TopicRetired(topic)` on any of them. There is no
un-retire. A screening hit is `RestrictedPartyRegistry.blockPerson` / `blockWallet`, never a
claim; a screening "clear" is not recorded anywhere on-chain.

### `ModularCompliance`

- `removeModule` clears any standing bypass and emits `ModuleBypassCleared(module, at)`;
  `addModule` reverts `BypassStillSet` if one somehow survives. Bypass → remove → re-add no longer
  yields a silently skipped module.
- `bindToken(address(0))` reverts `ZeroAddress` (it previously consumed nothing and left the
  one-shot open).
- `IComplianceGate.checkTransfer` NatSpec now carries the module classification: **informative-block** (holding
  period, closed period, covenant, concentration — may name an Article) vs **generic-block**
  (anything eligibility / freeze / sanctions / suspicion-linked — one argument-free error, AMLR
  Art 76). `RestrictedPartyGate` is the generic-class module and the only one. Each module carries
  a `/// @dev CLASS: informative | generic` line. The store raises **two** argument-free errors on
  the transfer path, not one: `TransferNotPermitted()` everywhere, `ScreeningStale()` on mint only.

---

## 2026-09-08 fixes — documents/escrow/governance layer

### `DoraGovernor` — constructor is now `(governance)`

The `documents` argument is gone with the upgrade limb. Deploy it directly (no proxy needed —
nothing in it is a disclosure item), then:

- `DoraGovernor.setOracleTripSource(ValuationOracle)` **and** `ValuationOracle.setCircuitBreaker(DoraGovernor)`
  — both directions, or the trip is refused on one side and never sent on the other.
- Pass the `DoraGovernor` address as the `protocolPause` reference to `SecurityToken` and the four
  fund modules (`NavBorrowingCap`, `UcitsFiveTenForty`, `EltifConcentration`, `LmtGate`). Until it
  is wired, `pause()` stops nothing; `UPGRADE-ARCHITECTURE.md` §9 has the reader table.
- Governance rotates in two steps (`transferGovernance` → `acceptGovernance`); the Safe is the
  initial `governance`.
- `currentKeySet()` reverts `NoKeySetRecorded()` until the first `recordKeyRotation` — record the
  go-live signer set as part of deployment, not after the first rotation.

### `SubscriptionEscrow` — constructor is now `(issuer, governance, mode, maxOfferAmountWei, prospectusValidUntil, finalPriceOmittedAtFiling, documents, prospectusDocRef, identity, restrictions)`

- **Never behind a proxy.** `mode` and `finalPriceOmittedAtFiling` are `immutable` disclosure items;
  one escrow per offer. Listed in `UPGRADE-ARCHITECTURE.md` §10.
- `restrictions` (the `RestrictedPartyRegistry`) is a required constructor argument in **both**
  modes. `subscribe()` runs `identity.checkEligible` and `restrictions.assertNotBlocked`; the refund
  path deliberately runs neither.
- `documents` is required (non-zero) in `Prospectus` mode and must stay `address(0)` in `Exempt`;
  `setDocuments` reverts `WrongMode` in `Exempt`. `setIdentity` / `setRestrictions` work in both.
- **`setOfferClose(ts)` must be called before anything can settle.** `settle()` reverts
  `OfferStillOpen()` while `offerClosesAt == 0` or not yet passed; `subscribe()` reverts
  `OfferClosed` after it. The date may be extended, never brought forward.
- In `Prospectus` mode `subscribe()` requires the current prospectus version to carry an NCA
  approval date — an anchored-but-unapproved prospectus reverts `ProspectusNotApproved`.
  ⚠️ **Changed 2026-09-22: the date is now an argument to `DocumentRegistry.anchorVersion`, not a
  follow-up `recordNcaApproval` call.** There is no second transaction and no window in which the
  prospectus is anchored but unapproved. `prospectusValidUntil` must sit within
  `versionAt(prospectusDocRef, 0).approvedAt + 365 days` (the base prospectus, not the latest
  supplement); it is checked lazily on every `subscribe()` and eagerly in
  `extendProspectusValidity`. Feed a validity date computed from the NCA's decision notice.
- `publishSupplement(docRef, versionHash, opensAt, closesAt)` now takes the slot: the hash must be
  a version in a slot on the escrow's own `isProspectusSlot` allowlist, and not index 0 of this
  offer's own prospectus. ⚠️ **Changed 2026-09-22: this check reads escrow configuration, not
  `DocumentRegistry.regimeOf`, which no longer exists.** `prospectusDocRef` is allowlisted in the
  constructor, so the common case needs no call. **Add a slot with `setProspectusSlot(docRef,
  true)` only for a base prospectus held separately — admitting a slot admits every version in it,
  past and future, so pointing it at a slot holding KIDs restores the exact defect the check
  prevents.** `opensAt >= now` and `closesAt - opensAt >= supplementWindowDurationSeconds`
  (default 3 days; setter `setSupplementWindowFloor`, zero refused). Same floor semantics on
  `publishFinalPrice` with `finalPriceWindowDurationSeconds` / `setFinalPriceWindowFloor`. The
  floors are calendar seconds — working-day arithmetic stays off-chain; the floor is a lower bound
  on what is fed in, not the computation.
- Event rename: the escrow's `SupplementPublished` is now `WithdrawalWindowOpened(windowIndex, kind,
  opensAt, closesAt, scopeCutoff)` and fires for both window kinds. Re-key any subgraph handler that
  joined on the name against `DocumentRegistry.SupplementPublished`; the reconciliation join is on
  `versionHash` via `SupplementAnchorVerified(docRef, versionHash, approvedAt)`.
- `subscribe()` with zero value reverts `ZeroSubscription()`.

### `DocumentRegistry`

- **`openDocument(docRef, retentionUntil)`** — signature changed 2026-09-22; the `Regime` argument
  is gone and **the enum no longer exists**. The registry does not classify documents: what a
  document is, and what follows from revising it, is the consuming contract's business. A slot is
  a slot.
- ⚠️ **There is no longer any on-chain record of what kind of document a slot holds.** Nothing
  reverts if you anchor a KID into the slot your runbook calls "the prospectus". **The `docRef`
  naming convention is now load-bearing documentation** — pick it deliberately, write it down, and
  make the indexer's slot-to-regime map a reviewed artefact rather than a lookup someone maintains
  from memory. The compensating control on the one path where it mattered is the escrow's
  `isProspectusSlot` allowlist.
- **`anchorVersion(docRef, versionHash, uriHash, uri, approvedAt, retentionUntil)`** — signature
  changed 2026-09-22; `approvedAt` is new and sits before `retentionUntil`. Two `uint64` arguments
  now sit adjacent and **transposing them compiles**: a retention deadline in the approval slot
  reads as an approval a decade in the future, and `_assertValidityWithinApproval` then accepts any
  validity date you feed it. Check the argument order on every anchor script.
- **`approvedAt` is write-once.** Pass the NCA's date from its decision notice for a
  `ProspectusRegulation` slot; pass `0` for PRIIPs KID, MAR disclosure and Art 8(5) final terms,
  none of which are approved ex ante. There is no setter — correcting a wrong date means anchoring
  a new version, and on a Prospectus slot **that opens an Art 23 withdrawal window on every
  subscription taken so far**. A typo here is a refund event, not a patch.

⚠️ **Removed 2026-09-22 — three functions, and one of them was a control you now owe someone.**

| Removed | Replaced by | Who owns it now |
|---|---|---|
| `recordNcaApproval` | the `approvedAt` argument on `anchorVersion` | nobody — the state it guarded is now unrepresentable |
| `anchorConcealed` / `revealConcealed` | anchor after the announcement | nobody — see `UPGRADE-ARCHITECTURE.md` §9 |
| `attestReview` + the `reviewDueBy` limb of `isCurrent` | **an off-chain calendar with a named owner** | **unassigned — assign it before a retail KID goes live** |
| `regimeOf` + the `Regime` enum + `SupplementPublished` / `KidRevised` | `SubscriptionEscrow.isProspectusSlot` for the one guard; one generic `VersionAnchored` carrying `supersededHash` for the indexer | **the indexer's slot-to-regime map — a reviewed artefact, not tribal knowledge** |

⚠️ **The PRIIPs Art 10 review is now a day-one default that does nothing, and unlike the others in
the table at the top of this file, nothing on-chain will ever surface it.** `isCurrent` used to
return `false` once a KID passed twelve months without an attested review, which blocked new retail
subscriptions. It no longer does: **a KID that is never reviewed satisfies every on-chain read
indefinitely.** That limb was withdrawn deliberately — Art 10 requires review *at least every 12
months* **and** *on any material change*, and a timer catches only the first limb while the second
is the one that actually breaches. But removing the timer does not remove the duty. Before the
first retail subscription:

1. Put the twelve-month review date for each KID slot in the compliance calendar, dated from its
   `VersionAnchored` timestamp. ⚠️ **Which slots those are is now off-chain knowledge** — the
   registry stopped carrying a regime on 2026-09-22, so this list comes from the `docRef`
   convention, not from a contract read.
2. Name the person who signs the review off. The `KidRevised` event is the only on-chain trace a
   review ever produced an outcome, and it fires only when the review results in a **revision**.
3. Wire the material-change trigger to the product-change process, not to a date. That is the limb
   the contract never covered and never could.

### `CovenantRegistry`

- `identity` is `IIdentityGate`-typed; the constructor signature is unchanged
  `(governance, documents, identity)`.
- ⚠️ **`setOptUpCovenant` is gone — it is now `setClassifier(axisId, covenantId, electiveValue,
  fallbackValue)`, and `Predicate.tierMask` is now `classAxisId` + `classMask`.** The MiFID opt-up
  is configured on `AXIS_MIFID` with `electiveValue = Tier.ProfessionalOnRequest` and
  `fallbackValue = Tier.Retail`; a national overlay's own classification is a second axis, not a schema change.
- `setClassifier` refuses a covenant whose `classMask` excludes `electiveValue`, whose predicate
  names an axis other than the one being configured, or where `electiveValue == fallbackValue`
  (all `ClassifierMisconfigured`). ⚠️ **The `PlatformWide` scope check is gone — so is the `Scope`
  enum** (2026-09-21). It enforced a label the evaluation path never read; see §2 step 7a for what
  now carries it, and note that classifier covenants must be configured identically on every
  deployment because an acknowledgement does not travel between them.
- ⚠️ **`fallbackValue` must be the MORE PROTECTIVE classification and nothing on chain checks
  it.** For MiFID that is `Tier.Retail`. Configured backwards, an investor with no record is
  promoted rather than demoted, which inverts the control instead of weakening it.
- `IdentityRegistry.registerAxis(axisId)` is **governance**, and must be called before
  `setClassification` will write on a new axis. `AXIS_MIFID` is registered in the constructor.
  Bounded at `MAX_AXES = 8` in both registries — the bound is `erasePerson`'s gas budget.
- `signCovenant` on an `OperatorAttestation` covenant reverts `AttestationRequiredFromOperator`;
  back-record those through `recordAttestation` from an operator key.
- `CovenantGate` no longer gates the zero leg on burn: a RECEIVE-gated covenant no longer blocks
  redemptions, buy-back burns or maturity burns.

## 2026-09-08 fixes — fund layer

Covers `ValuationOracle`, `NavBorrowingCap`, `UcitsFiveTenForty`, `EltifConcentration`, `LmtGate`,
`HoldingPeriodLock` / `HoldingPeriodGate`, and the `IValuationFeed` interface. Review rows H5, H6,
H8, H9, M-F1–M-F8, M-D6, M-T8, §3 reference discipline, H7b consumer side.

**Constructor signatures changed — every fund module takes `protocolPause` (the `DoraGovernor`)
and a fed start date. Nothing may be zero.**

| Contract | New constructor |
|---|---|
| `NavBorrowingCap` | `(aifm, subscriptionAgent, regulator, oracle, protocolPause, navFeedId, fundType, rampUpStartsAt)` — `rampUpStartsAt` is ELTIF Art 16(3); pass 0 for UCITS/LOF |
| `UcitsFiveTenForty` | `(manco, subscriptionAgent, oracle, protocolPause, navFeedId, authorisedAt)` — `authorisedAt` is the UCITS authorisation date, the Art 56 clock |
| `EltifConcentration` | `(aifm, subscriptionAgent, oracle, protocolPause, rampUpStartsAt)` — `rampUpStartsAt` is Art 17(1)(a) |
| `LmtGate` | `(aifm, regulator, oracle, protocolPause, token, identity, restrictions, navFeedId, minWindowSeconds)` — `minWindowSeconds > 0` |
| `HoldingPeriodLock` | `(aifm, subscriptionAgent)` unchanged, but see `setGate` below |

**Wiring steps that are now mandatory:**

- **`LmtGate` must be a registered agent on `SecurityToken`** — `processRedemption` burns the paid-out
  units through `token.burn(redeemer, shares)`, which is agent-gated. Until the role is granted every
  processing call reverts. `processRedemption` records the cash owed and burns units; **the cash leg
  is off-chain / `DistributionAgent` from the issuer-funded pool.** No ETH moves through `LmtGate`.
- **`HoldingPeriodLock.setGate(HoldingPeriodGate)`** before `ModularCompliance.addModule(gate)`. The
  gate now overrides `notifyTransfer` to call `lock.recordTransferIn(to)` on every settled move so a
  secondary-market buyer gets a holding-period clock (M-T8). Until `gate` is set that call reverts
  `NotAuthorised` **and takes the transfer with it** — same posture as the unrecorded screening sweep.
  Units that landed before the gate was wired have no clock; `backdate(wallet, acquiredAt)` (AIFM, can
  only move a clock earlier) or `recordSubscription` fixes them. `recordSubscription` is now idempotent —
  it keeps the earlier date and never resets a clock.
- **`ValuationOracle.setCircuitBreaker` refuses a codeless address.** Deploy `DoraGovernor` first; an
  EOA or a not-yet-deployed proxy is rejected (M-D6).
- **`DoraGovernor` must be deployed before any fund module** — it is a constructor argument to all four.
- **Feed ids:** every `UcitsFiveTenForty` leg and every `EltifConcentration` asset must have its own
  configured, posted, non-zero feed before the first acquisition. The oracle now rejects a post of `0`
  outright (`ZeroValuation`).

**Behaviour changes an operator will notice:**

- `syncNav()` / `syncAssetValuation()` / `syncLegValuation()` no longer take classification arguments
  and no longer zero the cash/payout counters on every call — only when the oracle's `acceptedAt`
  advanced (H5/H6). Every acquisition, draw and window roll syncs inline first, so "the AIFM never
  synced" is no longer a way to compute on an old NAV (H8). `NavSynced` fires only on an absorption.
- A protocol pause blocks: `recordAssetTrade` (buy), `recordHoldingUpdate` (buy), every
  `NavBorrowingCap.record*` draw, `LmtGate.lockSelection` / `rollWindow`. It never blocks a sell, a
  repayment, a redemption request, a processing run, `onBurn`, or a passive sync.
- `NavZero()` / `CapitalZero()` on an acquisition against a zero denominator. Passive paths still skip.
- `LmtGate` is a dealing-day model: requests accumulate in the open window; `rollWindow` (not before
  `minWindowSeconds`) closes it, fixes `payoutRatioBps = min(1, cap / requested)`, and opens the next;
  each closed-window request pays `owed × ratio` and the remainder is carried into the open window at
  full value. Cost-based tools haircut once, at request. `requestRedemption(shares)` derives cash from
  `shares × nav() / totalSupply` and checks the caller's balance; both mandatory-layer gates run on the
  redeemer at request and at processing. `cancelRedemption` exists for the investor and the AIFM.
- `lockSelection` enforces "at least two from Annex V points 2–8, not only points 5 and 6"
  (aifmd2-checklist.md:36). Side pockets (point 9) no longer count.
- `UcitsFiveTenForty.setNonUcitsCiuLimit` (default 20%, bounded 10–20%) — checklist §7.3 flags the
  20% as an interpretation. Bucket ids for legs are now `legBucket(legId, legType)` and for entities
  `entityBucket(entityId)`; the 40% band is re-summed over an enumerable issuer set capped at 256.
- Suspension relief is scoped: ELTIF Art 17(1)(c) relieves the 55% floor only; Art 16(4) relieves
  the ELTIF borrowing bucket only (`NavBorrowingCap.activateSuspension` reverts `WrongFundType` on
  UCITS/LOF). Both budgets are 365 days cumulative per fund life.
- The oracle now re-attempts acceptance while halted: widen the band with `configureFeed`, let the
  sources repost, and the halt clears on its own (`HaltRecovered`). `clearHalt` remains the other exit.
- Every AIFM / ManCo key is two-step rotatable (`transferAifm` / `acceptAifm`, `transferManco` /
  `acceptManco`); `subscriptionAgent`, `regulator`, `token`, `identity`, `restrictions`,
  `protocolPause` sit behind manager-gated setters.

**Not done in this pass:** ELTIF Art 15(2) (imports UCITS Art 56(2) issuer-side limits; no
denominator feed exists), Art 13(7) professional-only relief, ELTIF RTS Art 5(5)–(6) redemption cap
(still open, see `LmtGate` header), MMF single-tool derogation.

---

## 2026-09-08 fixes — economics/MAR layer

Files: `BuybackAgent.sol`, `DistributionAgent.sol`, `CouponSchedule.sol`, `DistributionWaterfall.sol`,
`PdmrClosedPeriodFreeze.sol` (+ `PdmrClosedPeriodGate`), `PdmrRegister.sol`. Review items M-E1–M-E8,
section 3 reference discipline, protocol pause.

### Constructor signatures changed (deployment scripts must follow)

| Contract | New signature |
|---|---|
| `BuybackAgent` | `(governance, token, documents, closedPeriods, protocolPause, InstrumentClass instrumentClass)` — every address non-zero; `instrumentClass` must be `Share` (1) or the contract can never open a programme |
| `DistributionAgent` | `(governance, identity, compliance, restrictions, protocolPause)` — all non-zero |
| `CouponSchedule` | unchanged order; `governance`, `token`, `distributions` now reject `address(0)` |
| `DistributionWaterfall` | unchanged order; `governance`, `distributions` reject `address(0)`; `trancheIds.length == contributedCapital.length` enforced |
| `PdmrClosedPeriodFreeze` | `(register, issuer, governance)` — all non-zero; `governance` grants Art 19(12) permissions and re-points `register`; `issuer` runs the calendar |
| `PdmrRegister` | `(registrar, identity, governance)` — all non-zero; `governance` owns `setIdentity`; `registrar` owns declarations |

Both new `governance` roles are two-step (`transferGovernance` → `acceptGovernance`).

### Operating rules with no on-chain enforcement (add to §4's list)

3. **`BuybackAgent` is for OWN SHARES ONLY. A debt-token or fund-unit issuer must not deploy it.**
   MAR Art 5 covers own shares for three purposes (mar-checklist §2.1); a repurchase of anything
   else is outside the harbour and judged as ordinary Art 12/15 conduct. The contract refuses to
   label such a programme (`instrumentClass != Share` → `SafeHarbourUnavailable`) and offers no
   non-harbour path. A non-share instrument's redemption mechanics belong in its own terms.

4. **"No sale of own shares during a programme" is an off-chain programme rule.**
   `BuybackAgent.checkIssuerMaySell()` was deleted — nothing read it, and the treasury is an
   ordinary wallet the issuer controls by other means, so a view on this contract could not stop a
   sale from it. If an on-chain form is wanted it is a freeze of treasury units on the token for
   the programme's duration; until then the rule needs an owner in the runbook.

5. **`PdmrRegister.registrar` ≠ `PdmrClosedPeriodFreeze.issuer` ≠ any director's key.** The
   register cannot see the freeze, so `revokeWallet` during a live closed period unfreezes the
   wallet immediately. The on-chain control is only that every revocation carries a mandatory
   `reasonHash`; the control that makes the hash mean anything is that the registrar key is held
   by the company secretary / compliance function and by nobody who benefits from a freeze
   lifting. Same for `purgePerson` / `purgeWallet`.

6. **`DistributionAgent.preview()` must not be rendered in any holder-facing UI.** Its
   `eligible` return is "is this wallet blocked?" and any address can ask it about any other.
   It is for the reconciliation desk and the auditor; a product that shows it beside a holder's
   dividend has built the AMLR Art 76 tipping-off channel on purpose.

7. **Cash funding is explicit on both agents.** `BuybackAgent.fund()` (governance) and
   `DistributionAgent.fund(id)` (agent) are the only ways cash enters; there is no `receive`.
   `withdrawSurplus` on each can take only `balance − reservedWei`. On `BuybackAgent`,
   `reservedWei` is Σ(`maxConsiderationWei − spentWei`) over Active programmes — i.e. the
   disclosed ceiling is reserved from `startProgramme`, so fund the ceiling or accept that
   surplus is unwithdrawable until `endProgramme`. On `DistributionAgent`, `reservedWei` is
   Σ(`committed − paidOut − swept`) over opened distributions.

8. **`BuybackAgent.marketDataMaxAge` is capped at `MAX_MARKET_DATA_AGE = 1 days`.** Default 15
   minutes; set to the venue's actual quote cadence, never to the cap "to be safe".

9. **`CouponSchedule.bindPeriod` / `recordRedemption` reconcile `totalUnits` against
   `token.totalSupply()` NOW, not at the record block.** Supply must not move between the record
   block and the bind; a `SupplyMismatch` is a stop, not a warning. The redemption distribution's
   `ratePerUnit` must equal `principalPerUnit` exactly — a final coupon is its own period.

10. **Zero-coupon notes:** `bindPeriod(index, 0)` settles a zero-rate period with no
    distribution. Do not declare a distribution for it (`DistributionAgent` refuses a zero rate).

11. **`DistributionWaterfall.dustCarried`:** an allocation not divisible by the tranche's
    `totalUnits` binds at `ratePerUnit = owed / totalUnits` and carries the remainder to the
    tranche's next award. The agent funds `owed` including the folded dust on that later
    distribution. A tranche that never receives another award keeps its dust on the books.

12. **A live closed period cannot be cancelled.** `cancelPeriod` works before `opensAt` only;
    after that the calendar moves through `reschedulePeriod(id, laterDate, evidenceRef)` (later
    only, evidence mandatory, `opensAt` never moves once the window has opened) or ends through
    `recordAnnouncement`. Keep the evidence file the `evidenceRef` hashes.

### Citation corrections carried into NatSpec

- The 7-daily-market-session publication is Del. Reg (EU) 2016/1052, not MAR Art 5(1)(c).
- The issuer's closed-period bar on buy-backs is a condition of the Art 5 harbour under
  Del. Reg 2016/1052 (mar-checklist §2.1 "Art 19(11) interaction"); Art 19(11) itself binds
  PDMRs. The mechanism (one calendar) is unchanged; the label was wrong.
- `PdmrRegister` cites the threshold as **Art 19(8)** and the issuer publication clock as
  **Art 19(3)** (two business days from *receipt*). ✅ **Verified 2026-09-08 against the
  consolidated text** (`EU Compliance/Checklist/mar.mhtml`, CELEX:02014R0596-20260605) — the code
  was right and the checklists were wrong; `mar-checklist.md` (rev 1.2) and
  `eu-listing-checklist.md` (rev 1.1) were corrected to match, not the other way round.
  ⚠️ **The substantive limb, which every document in the library was missing: Art 19(9) is a
  COMPETENT-AUTHORITY decision running BOTH ways — up to €50,000 or DOWN TO €10,000.** The
  threshold is a three-valued per-jurisdiction parameter. **Any notification engine built to a
  €20k floor under-reports wherever an authority took the lower option**, which is the direction
  that gets filed against the issuer. Art 19(1a) is the collective-investment-undertaking
  exemption and is not a threshold — do not let a citation pass move it back there, as one did
  at design rev 13, where it stood for 39 revisions.
- `DistributionAgent`: "AMLR Arts 20/75" → "AMLR Arts 21, 75".

### Not done (needs a change outside these files)

- `PdmrClosedPeriodFreeze.register` stays typed `IPdmrRegister` (from `PdmrRegister.sol`), not
  `Interfaces.sol`'s `IDeclaredPersonRegister`: that interface declares `isDeclared` / `personOf`
  and the freeze needs `isFlagged` (live role, not "ever declared"). Add
  `function isFlagged(address) external view returns (bool)` to `IDeclaredPersonRegister`, then
  switch the type and drop the concrete-file import.
- `Distribution` (shared struct in `Interfaces.sol`) was not widened; `committedOf`, `sweptAt`
  and `Unclaimed{amount, units}` live in `DistributionAgent` side-mappings instead.
