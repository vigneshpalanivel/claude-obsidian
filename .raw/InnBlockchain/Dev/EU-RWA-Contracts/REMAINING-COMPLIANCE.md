---
title: Remaining Compliance — EU-RWA-Contracts
date: 2026-09-08
status: derived from the 28 .sol files (30 contracts) in this folder + §17/§17a of eu_tokenized_securities_smart_contract_design.md (rev 52)
supersedes: the rev-36 state of this file, which stood while the design moved from rev 36 to rev 52
---

# Remaining Compliance List

**30 contracts across 28 files. §17's contract inventory and §17a's matrix are both complete.**

> ⚠️ **Re-synced 2026-09-08 to design rev 52, after the code review in `CODE-REVIEW-2026-09-08.md`.** This file had stood at rev 36 while the design moved 16 revisions, and three of its statements had gone stale in a way that mattered. **Read the review file for the full finding list; read the sweep note below for what this file used to say.**
>
> **What this file said that was wrong, and is now corrected in place:**
> - **§3 "GDPR: a design rule, not a contract. Nothing personal on-chain."** Withdrawn at design rev 43 and false in this suite: a KYC-bound wallet *is* personal data, the register is the product, and erasure is *approximated*. Rev 50–51 rewrote the event layer on that basis (wallet plus an opaque digest, never the person key or an attribute) and rev 50 added a person index so an Art 17 request can be answered per person. See §10 of the design.
> - **§3 "Venue: … done" and "Trading: … done".** Correct as code, misleading as status: the venue and dealer lanes are **parked** (see the series' PARKED note) and were reviewed at moderate depth only. `SiQuoteEngine` still needs `viaIR`, `SettlementEngine` never touches `SecurityToken`, and `DltPilotCapGate`'s €6bn test reads "already at" where the checklist says "would reach".
> - **§9 defect 5 "auto-trip on oracle-anomaly — closed."** It was not. The trip called `DoraGovernor`, which set a flag **nothing read** — an event with a different name, which is precisely what that defect was about. Closed for real on 2026-09-08: `DoraGovernor` implements `IProtocolPause`, and the flag is read by `SecurityToken` (voluntary paths), the four fund modules (acquisition paths), `DistributionAgent` (payouts) and `BuybackAgent` (purchases). Never by forced transfer, recovery, repayments, disposals or refunds.
> - **§8 "widen the band with `configureFeed` and let the sources repost".** `postValuation` returned before `_tryAccept` while halted, so that path did nothing without `clearHalt`. Now implemented as described: posts during a halt are stored and re-attempted, and acceptance inside the widened band clears the halt.
>
> **Nine HIGH defects were found and fixed on 2026-09-08** — see §11 below. The suite compiles clean (solc 0.8.22, optimizer, viaIR: 0 errors, 0 warnings). ⚠️ **There is still no test harness, so nothing here is runtime-verified.**

What is left is the open decisions in §6 and §11, and the items §11 records as deliberately not built.

---

## 1. The big one first — now closed

**The token exists.** `SecurityToken` carries C1 (the pre-validation hook every module waits on), C5 (freeze, forced transfer, wallet recovery) and the ERC-20 surface.

Two things to know about it:

- **It is deliberately neither ERC-1400 nor ERC-3643.** §16 D0 leaves that to the operator, and §8 makes it *prospectus-blocking* — the token standard is a disclosure item, so changing it after approval is a material change with a withdrawal window. Writing the file either way would have made that decision by accident. It is written at the §3 capability level and binds to either.
- **C6 (partitions) is not in it, for the same reason.** ERC-1400 gets partitions free; ERC-3643 does not. `DistributionWaterfall` shows the shape a tranched instrument needs once D0 resolves.

---

## 2. Every article this list opened with — and where it now lives

**Read this carefully.** No regulation was ever "unfinished". Each row is one *article*. All eleven now have code.

| Article | What it needs | Where it lives |
|---|---|---|
| **PRIIPs Art 13** | proof this investor got *that KID version* before buying | `CovenantRegistry` ✅ |
| **PRIIPs Art 10** | re-anchor the KID every 12 months / on material change | `DocumentRegistry` ✅ — an overdue review makes `isCurrent` false |
| **Prospectus Art 21(7)** | keep prospectus + supplements 10 years | `DocumentRegistry` ✅ — no delete function *is* the retention control |
| **MAR Art 17** | store disclosed inside information | `DocumentRegistry` ✅ — incl. the delayed-disclosure commit/reveal |
| **MAR Art 18** | insider's written acknowledgment | `CovenantRegistry` ✅ — the hole left by deleting `InsiderListAnchor` |
| **ELTIF Art 18(3)** | tell a retail investor "this fund runs >10 years" | `CovenantRegistry` ✅ — MINT gate only |
| **ELTIF Art 26** | retail access check before subscribing | `CovenantRegistry` ✅ |
| **ELTIF Arts 23–24** | store prospectus + annual report | `DocumentRegistry` ✅ |
| **DLT Pilot Art 4(2)(g)** | member's informed consent | `CovenantRegistry` ✅ |
| **MAR Art 5** | buy-back price + volume caps, closed-period block, 7-session publication | `BuybackAgent` ✅ |
| **Payout eligibility** | a restricted wallet must not get paid | `DistributionAgent` ✅ — identity + restriction read in the mandatory layer, same as a transfer |

### What MAR Art 5 actually cost

`BuybackAgent` is the densest of the five, because the Art 5 safe harbour is **all-or-nothing**. Breach one condition and the exemption is not reduced — it is gone, and the trading is judged as ordinary Art 12/15 manipulation. So every condition is a revert:

- **Art 5(2)** — three permitted purposes, an enum. "General corporate purposes" is outside the harbour, and a free-text field invites exactly that.
- **Art 5(1)(a)** — details disclosed *before* start, checked against the `DocumentRegistry` anchoring timestamp rather than a boolean the issuer sets.
- **Del. Reg 2016/1052** — price cap (higher of last independent trade / highest independent bid) and 25%-of-20-day-ADV volume cap, both from one oracle reading, **fail-closed when stale**.
- **Art 19(11)** — reuses `PdmrClosedPeriodFreeze`, so one calendar governs directors and treasury alike.
- **Art 5(3), as amended by the Listing Act** — a single NCA id, carried on every execution event. An internal pipeline still filing with every venue's NCA is running the pre-December-2024 pattern.

Two things it deliberately is **not**: a stabilisation contract (Art 5(4)–(5) is a *different* harbour with a designated manager), and a continuous redemption facility (**a licence trigger, not a parameter** — open-ended fund characterisation on one side, SI / trading-venue on the other).

### The one dead line to know about — ✅ closed at rev 36

`ClaimTopicsRegistry` declared `TOPIC_PRIIPS_KID_DELIVERED = 8` once and read it nowhere. A claim topic is a yes/no flag while the comment promised a version hash: revise the KID and the flag still says yes, so the sale looks clean and breaches Art 13 — the exact failure the covenant store was designed to stop.

**Topic 8 is now retired in the catalogue rather than deleted outright**, and the number is **never reassigned**. A stale claim that resolves to nothing fails closed; one that resolves to some later topic fails open, and only the first is survivable. Topics **22–26** (DLT Pilot Art 4(2)(c)–(g)) were retired on the same rule at rev 36 — see §10. Next free topic is **28**.

---

## 3. What is already fine — do not rebuild

- Fund rules: AIFMD II, UCITS, ELTIF portfolio limits — **5 contracts**, all reading `ValuationOracle` rather than a private NAV (§8). ⚠️ *Hardened 2026-09-08 — see §11: classification is persisted at trade time rather than supplied by the caller, the active path syncs inline before it computes, the UCITS 40% band keeps an enumerable issuer set, and suspension relief is per-bucket with a 365-day lifetime budget. `LmtGate` was rewritten as a dealing-day model with pro-rata allocation.*
- Venue: DLT Pilot caps, member eligibility, settlement — **built, and PARKED**. The issuer lane does not deploy them. Reviewed at moderate depth only: `SettlementEngine` runs an internal book that never touches `SecurityToken` and gates neither leg on identity; `DltPilotCapGate`'s €6bn test is "already at" where `dlt-pilot-checklist.md` says "would reach"; `SiQuoteEngine` needs `viaIR`. **Do not treat this row as audited.**
- Trading: MiFIR quotes, reporting and transparency events — **built, and PARKED**, same caveat. `MarketEventSchema` is an interface plus an abstract clock with no issuer-lane implementer: an issuer that runs a buy-back owes Art 16(2) surveillance on its own flow and there is **no order-lifecycle emitter for it** (§11).
- Identity: KYC claims, trusted issuers, eIDAS — **done**. Note the attestation *signature* is verified off-chain by the claims service; on-chain is the trusted-issuer write gate plus the revocation read (design §3/§4 corrected at rev 52).
- Operations: DORA governance wrapper — **done, and stripped 2026-09-08.** `DoraGovernor` is pause + incidents + key rotation + `tripFromOracle`. The upgrade queue, timelock, `queueUpgrade` disclosure gate and commit-reveal are **gone**: the upgrade path is stock Safe → OZ `TimelockController` → `ProxyAdmin` with the disclosure hash in the timelock salt (`UPGRADE-ARCHITECTURE.md`).
- CSDR and SFD: correctly handled as exemption conditions inside `SettlementEngine`, not separate contracts
- **GDPR: a design constraint, and it is not "nothing personal on-chain".** ⚠️ *Corrected 2026-09-08 — the old line is the formulation design rev 43 withdrew, and a DPA would not accept it.* A wallet bound to a verified investor **is** personal data and so is every transfer it makes; the register is the product and cannot reach zero. What the suite does instead: direct identifiers never touch the chain; every remaining field is justified individually (**D21**, still open); events carry the wallet and an opaque digest, never the person key, an attribute, a claim topic or a reason (design §10's field table, swept across all 30 contracts at rev 51); erasure is **approximated** — `deregisterPerson` sweeps every wallet and its claims, the off-chain record is deleted and its key destroyed, and the anchor becomes an orphan. The **calldata surface is unaddressed by any contract** — a registrar write carries the attribute in transaction data forever — which is a deployment or legal-position question (D23 candidate, DPO).

---

## 4. Two deleted files

| File | Verdict |
|---|---|
| `PdmrThresholdMonitor.sol` | **Right to delete.** The €20k limit only makes a trade *reportable*, never illegal. It blocks nothing, so it does not belong on-chain. |
| `InsiderListAnchor.sol` | **Leaves a hole.** The list itself stays off-chain — correct. But the insider's **written acknowledgment** now has nowhere to live, and neither does the key-holder record. Needs `CovenantRegistry`. |

---

## 5. The 7 — all built

| # | Contract | Deploy when |
|---|---|---|
| 1 | `SecurityToken` ✅ | Always. C1 hook + C5 freeze / forced transfer / recovery. Standard-neutral pending §16 D0. |
| 2 | `DocumentRegistry` ✅ | Always. Serves 4 regulations. Closes the dangling `IDocumentRegistry` call in `DoraGovernor`. |
| 3 | `CovenantRegistry` ✅ | Always. Serves 5 regulations. Ships with `CovenantGate` for `ModularCompliance`. |
| 4 | `DistributionAgent` ✅ | If the token pays holders at all. |
| 5 | `BuybackAgent` ✅ | If the issuer buys back its own units. |
| 6 | `CouponSchedule` ✅ | Debt / note tokens only. |
| 7 | `DistributionWaterfall` ✅ | Tranched or revenue-share tokens only. |

Items 4–7 are **product-driven, not regulation-driven**. A plain equity token with no buy-back and no distributions deploys 1–3 and stops.

### The two contracts that discharge no Article

`CouponSchedule` and `DistributionWaterfall` execute **commercial terms**, not obligations. Nothing in PRIIPs, Prospectus, MAR, ELTIF, UCITS, AIFMD II, DLT Pilot or MiFIR requires a debt token to pay coupons on any schedule. An audit map that lists either against an Article has invented one.

They earn their place for two inherited reasons:

1. **Neither pays anyone.** Both compute an amount and hand it to `DistributionAgent`, so income goes out through the same C1 eligibility gate as a transfer. A coupon contract that paid holders directly would let a restricted wallet collect interest on units it cannot move.
2. **Their terms are prospectus disclosure items,** so they are immutable — constructor only, no setters. A mutable coupon rate or a reorderable waterfall lets an operations key do, in one transaction, what the regulation treats as a re-offer.

### Four fixes to existing contracts (edits, not new files)

*(Heading said "Three" against a four-row table — corrected. The `ValuationOracle` swappability fix of §9 is separate and is already applied.)*

| Where | Fix |
|---|---|
| `ClaimTopicsRegistry.sol:28` | delete `TOPIC_PRIIPS_KID_DELIVERED` — Art 13 now lives in `CovenantRegistry`, and leaving a boolean topic named "KID delivered" invites someone to wire it up |
| `DoraGovernor.sol:37` | point at the real `DocumentRegistry`; drop the local `IDocumentRegistry` declaration |
| `IdentityRegistry.sol` | `jurisdiction` is one value; covenants can key on residence *and* tax residence *and* nationality. Until it is set-valued, those predicates fail closed rather than match on residence alone |
| `SiQuoteEngine.sol` | **does not compile** without `viaIR` — stack too deep at line 363. Pre-existing, committed in `6b0b45a`. Every other file in the folder builds on plain solc 0.8.22 |

### A fifth, opened 2026-09-07 — the revert path has no tipping-off carve-out

`ModularCompliance.checkTransfer` states its propagate-the-module's-own-error rule **globally**, on the reasoning that collapsing an Article breach into a generic failure destroys information an NCA reviewer and a support desk both need. That is right for `HoldingPeriodLock` — an unlock date is not a suspicion, and telling a holder when they may exit is a service.

It is **not** right for any module that can block on a suspicion- or sanctions-linked ground. The §4 AML table requires **one generic block code for that whole class, and no reason codes**, and tipping-off is an individual criminal offence in most Member States. `SecurityToken` already applies this correctly at the **event** layer — freeze and forced-transfer carry a `reasonHash`, never a reason. The **revert** layer has no equivalent rule, so a suspicion-linked module reverting with its own named error tells the blocked party exactly what Art 76 prohibits telling them.

**The fix is a classification, not a rewrite.** Every module is either **informative-block** or **generic-block**, decided by the Article it discharges and not by the developer:

| Module | Class | Why |
|---|---|---|
| `HoldingPeriodGate`, `PdmrClosedPeriodGate` | Informative | A date restriction. Disclosing it is a service |
| `CovenantGate` | Informative | A missing acknowledgment the investor can cure |
| Any eligibility / freeze / sanctions-linked path | **Generic** | AMLR Art 76 — one code to the caller, detail to the operator off-chain |

Two consequences worth recording:

- **`ModularCompliance`'s NatSpec must carry the carve-out**, not the unqualified rule. As written it instructs the next module author to do the wrong thing by default.
- **An ERC-3643-conformant `IModule` would not have this problem** — `moduleCheck` returns `bool`, so a T-REX block is generic by construction. The local `IComplianceModule` traded that property away for the named-error channel, and this is the cost. Worth stating against §16 D0, since the design doc's claim that generic codes *"cut directly against how both token standards are designed"* holds for ERC-1400's status-plus-reason return and **not** for ERC-3643.

### A sixth, opened 2026-09-08 — two residual leaks the restricted-party consolidation could not close

`IdentityRegistry.freeze` / `unfreeze` / `Investor.frozen` were **deleted** and every wallet-level stop moved into one store, `RestrictedPartyRegistry` (formerly `SanctionsRegistry`). The argument is storage-observability, not error strings: contract storage is public, so while two stores could each stop a wallet, an observer read *which* one held a person and inferred the class — and at that point the generic revert code is itself the tell. One store, one flag, one argument-free error.

Two things survive that argument and are **not** fixed in code:

| # | Leak | Why it was not closed | The operating rule |
|---|---|---|---|
| 1 | `SecurityToken.freezeUnits` writes a **public** `frozenUnits` mapping. An agent who freezes 100% of a wallet's balance has built a second, readable, wallet-level stop | A partial freeze over a disputed or collateralised parcel is a genuinely different mechanic, and forcing it through the restriction store would over-freeze — itself an exposure to the holder | **`freezeUnits` is for partial parcels only. A whole-wallet stop goes in `RestrictedPartyRegistry`.** Stated in the NatSpec on both contracts; no on-chain enforcement exists |
| 2 | `SecurityToken.recoverWallet` runs no transfer gate, so a **wallet**-keyed restriction on the lost wallet is left behind while the units land in a second wallet of the same investor | The token holds no write access to the store, and giving it one would put a sanctions key on the token | **Any restriction intended to survive a key loss must be written against the RECORD (`blockRecord`), not the wallet.** Record-keyed restrictions *do* follow, because both wallets resolve to the same pointer |

Both are stated in NatSpec at the site and in `DEPLOYMENT-DEFAULTS.md`. Neither is a code fix that exists; both are operator commitments that need an owner.

**What the consolidation *did* close in code:** the stop is no longer removable. `SecurityToken` and `DistributionAgent` each take `IRestrictedParty` as a non-zero constructor argument and read it in the **mandatory** layer — above `ModularCompliance`, and in `DistributionAgent`'s case not behind the per-distribution `runComplianceModules` flag. Routing sanctions exclusively through `RestrictedPartyGate` would have demoted a control that binds irrespective of client type into one a single `removeModule` call switches off.

---

## 6. The one decision nobody has made

**§16 D0 — ERC-1400 vs ERC-3643.**

It is not a build item and it is not on any list above, which is precisely why it keeps getting deferred. Two things make it urgent rather than architectural:

- **It is prospectus-blocking.** The token standard is a disclosure item under Prospectus Arts 6/16(1). Settle it *before* filing, or changing it later is a material change carrying an Art 23 supplement and an investor withdrawal window.
- **It decides C6.** Partitions are free under ERC-1400 and custom under ERC-3643. `SecurityToken` and `DistributionWaterfall` are both written to survive either answer, but only one of them is cheap to revisit.

Owner: operator. Everything else in this folder is portable across the answer by design (§13's standard-independence check).

---

## 7. One correction

CSDR, EU Listing Act, T+1 and TFR were earlier noted as missing from the design document. **They are not missing** — all four are covered there. Remove them from any pending list.

---

## 8. The 24th contract — `ValuationOracle`

§17a row *"Valuation / NAV oracle"* is **`●` (required) in the Fund lane**, `○⁴` in Venue. §17's *contract* inventory never listed it, which is how it stayed invisible for so long — but §5 calls it **"the #1 engineering risk"** and §17's critical path calls it **"the tightest dependency in the build"**.

The Venue lane was already satisfied: `DltPilotCapGate` has a real feed — oracle address, `postedAt`, `aggregateIsFresh()`, and `revert StaleValuationFeed(...)` blocking admission. The Fund lane was not. Every quantitative limit divided by a figure nothing guarded:

| Contract | NAV source before | Staleness check |
|---|---|---|
| `NavBorrowingCap` | `recordNavValuation(int256 delta)`, `onlyValuator` | none |
| `UcitsFiveTenForty` | `recordNavValuation(int256 delta)`, `onlyValuator` | none |
| `EltifConcentration` | `recordValuation(...)`, `onlyValuator` | none |
| `LmtGate` | set once in the constructor, only ever decremented by payouts | none — **no revaluation path at all** |

Two defects, and the second was worse than the first:

1. **No timestamp was stored, so nothing could fail closed.** §5 is explicit: *"oracle failure must HALT issuance/redemption, not pass a stale limit."* A valuator that stopped posting left every ratio silently passing.
2. **The feed was delta-applied, not absolute-set.** A stale absolute value self-heals on the next post. A missed *delta* never does — the running figure is permanently wrong from that point on and no later post can detect it. This one is a correctness bug independent of staleness.

### What `ValuationOracle` does

Absolute values only. Registered sources post, and a value is accepted when a configurable **quorum** of posts still inside `maxAgeSeconds` agree, taking the **median** — not the mean, because the failure being guarded against is one source going wrong, and a mean lets a single absurd figure drag the accepted value with it.

The **deviation guard** is the part worth reading. On a move larger than the configured band the feed *halts*: it does not publish the suspicious figure, and it does not advance `acceptedAt`. The last verified value stays readable, but freshness decays on schedule and every fail-closed consumer stops. Both alternatives are worse — publishing propagates a bad valuation into a breach check, and freezing the old figure as current is exactly the silent-stale-limit case. Clearing a halt is a governance act requiring the last accepted value be re-confirmed plus a justification reference; adopting the *new* figure instead means widening the band with `configureFeed` and letting the sources repost, which leaves an event showing the band was widened to admit the move.

Two read APIs, because §9's per-consumer rule is real:

- `value(assetId)` — **reverts** on stale, halted or unconfigured. For anything that mints, redeems or admits.
- `peek(assetId)` — **never reverts**, returns `(value, acceptedAt, fresh, halted)`. For passive rechecks and monitoring, where blocking an unrelated transfer would be over-enforcement.

### What changed in the four fund modules

⚠️ **Breaking.** Four constructors changed signature, and `recordNavValuation` / `recordValuation` are gone. Anything already deployed against those ABIs must be redeployed, not upgraded around.

- **NAV is now two fields, not one.** `navAtValuation` (oracle-published, timestamped, can go stale) plus `cashSinceValuation` (subscription cash, known exactly, needs no feed). They fail differently, so they are stored separately; `nav()` is the sum. That is what lets a subscription between valuation points be reflected without anyone inventing a price.
- **`syncNav()` and `syncAssetValuation()` are permissionless.** The figure is already guarded by the oracle's sources, quorum and band, so a role check would protect nothing — and it would hand whoever held that role the power to suppress a breach by simply not calling. Anyone who can see the fund is over a limit can now make the contract see it too.
- **Fail-closed on acquisition, fail-open on disposal.** Drawing leverage or buying into a bucket on an unverifiable denominator is the harm. *Repaying* or *selling* on the same denominator can only move every ratio downward whatever the true NAV is — so blocking disposals on a stale feed would trap a fund in breach at exactly the moment the feed is down. `_requireFreshNavIfIncreasing` is the whole of that asymmetry.
- **Passive rechecks still run on a stale figure.** They only flag, and a breach flag computed on last week's NAV beats no flag.
- **`EltifConcentration` deliberately does not halt subscriptions.** Art 2(8) defines capital by contribution, so its denominator is exact and reads no price. Applying §5's halt rule here mechanically would block subscriptions for a feed the subscription path never touches. Its numerators *are* oracle-fed, and `recordAssetTrade` now refuses an increasing position in an asset with no fresh feed — **you may not acquire an asset this fund cannot value**.
- **`LmtGate` is where the halt actually bites.** The gate cap is a percentage of NAV, so a stale NAV sizes the redemption window wrong — and an over-sized window pays early redeemers out of value belonging to the ones behind them, which is the dilution the LMT catalogue exists to prevent. `lockSelection`, `rollWindow`, `requestRedemption` and `processRedemption` all revert on a stale feed.

### Still open — `LmtGate` is not yet the ELTIF cap

§17a maps **ELTIF RTS Arts 5(5)–(6)** to `LmtGate`, where the redemption cap base is *liquid-asset bucket + prudently forecast 12-month cash flow*, the forecast **excluding** new-subscription and long-term-disposal proceeds, with `pct` from either the Annex I notice-period grid or the Annex II minimum-liquid-assets grid. `LmtGate` caps on `redeemableNav = nav() − sidePocketed` and has **no liquid-asset bucket, no forecast input, and neither grid**. It is a correct AIFMD II Art 16(2a) / Annex V toolkit; it is not the Art 5(5)–(6) cap. Two further fed inputs under the same staleness discipline would close it. Recorded in the file header — **do not mark this row closed**.

### Rows checked and confirmed *not* gaps

| §17a row | Verdict |
|---|---|
| Surveillance event schema (§6) | **Closed.** `MarketEventSchema` carries `OrderCreated`/`OrderModified`/`OrderCancelled` + flagged `TradePublished` and says so in its own header — the RTS 1/RTS 2 set *is* the MAR Art 8(1) set. Built once, feeds both, exactly as §7 specifies. |
| MiFIR Art 26 / APA-DPE / CTP bridges | **Closed.** Footnote ⁸: *"The `Trade` event schema is ● in every case — what is conditional is the delivery bridge, not the data capture."* Both schemas exist; bridges are off-chain. |
| Matching engine | **Not a contract.** Footnote ⁶: off-chain logic settling through `SubscriptionEscrow`/`LmtGate`. |
| `LoanRetention` | **Not in scope.** Footnote ¹¹: only under a separate loan-participation mandate. |

### What the oracle does not do

AIFMD Art 19. The valuation **methodology** is a documented, independently-reviewed procedure off-chain; this contract records what that procedure output, when, and from how many sources. §17a's own note is blunt about the consequence — *"if the methodology is undocumented, every quantitative fund limit in §5 rests on an unauditable input."* No amount of on-chain plumbing fixes that.

*(A duplicate copy of the "Rows checked and confirmed not gaps" table sat here and has been deleted — the table above is the only one.)*

---

## 9. Rev-35 hardening — seven defects in the module as first written

`ValuationOracle` closed the §17a gap. A full review of it against §9 and §17b then found seven things, one of which was a live breach of a requirement the design document states in terms.

### The breach

**All four fund modules held the oracle as `ValuationOracle public immutable oracle`.** §9 and §17b's DORA **Art 28** row both require the oracle stay *"swappable at the contract layer, not hard-wired"* — and a constructor-set immutable reference is hard-wired on any reading. A provider swap would have meant **redeploying every fund module**, which on a live instrument is a **re-issuance, not an upgrade**. The swap is already an Art 28(3) NCA pre-notification event; the contract layer must not add a redeploy on top of it.

`DltPilotCapGate` had it right all along (`setValuationOracle`, governance-gated) — so the correct pattern existed in this folder and the fund lane did not use it. All four now carry a `setOracle` gated to the AIFM/ManCo, per §5's delegation note that parameter-setting authority stays with the fund manager's governance. **None of them re-reads a valuation on swap**: adopting a new oracle's figures inside an administrative call would move every ratio with no valuation event, and could clear or create a breach unobservably. Call the `sync*` functions after — they fail closed.

### The other six

| # | Defect | Fix |
|---|---|---|
| 1 | `clearHalt` set `acceptedAt = now` on an **unchanged** value, so `value()` presented a governance re-attestation and a quorum of agreeing sources identically — the "old figure as though it were current" failure the file's own header condemns | New `reattested` flag on the feed, cleared on the next real acceptance, exposed via `valueWithProvenance()`. Not enforced: a halt must not permanently downgrade a fund's whole limit set. Consumers that size a payout from NAV can refuse it; consumers merely testing a ceiling need not care |
| 2 | `removeSource` could leave a feed with a quorum it could never reach again — no revert, no error, just `QuorumNotMet` forever, staleness on schedule, and **every fail-closed consumer frozen by one governance transaction** | `WouldOrphanFeedQuorum`. Bookkept in `_feedsRequiringQuorum` so the check is O(MAX_SOURCES), not a scan of every feed |
| 3 | `quorum == 1` with `maxDeviationBps == 0` was reachable — the accepted value is then whatever one address last said, with nothing checking it | `UndefendedFeedConfiguration`. Either setting alone stays legitimate; the combination is refused |
| 4 | `governance` was `immutable` — an unrotatable key with effective authority over every fund limit, against §9's key-rotation requirement | Two-step `transferGovernance` / `acceptGovernance`. Two-step because a one-step transfer to a mistyped address strands `configureFeed` **and** `clearHalt`, leaving every consuming fund one halt away from frozen with no path back |
| 5 | §9's **"auto-trip on oracle-anomaly"** was satisfied only by an event. An event is not a trip: DORA Art 19's clock runs from **detection**, so a control waiting for an operator to notice has spent the budget it exists to protect | Optional `ICircuitBreaker` hook called on a deviation trip, inside `try/catch` — a mis-set or reverting breaker must never brick the feed it protects. Failure emits `CircuitBreakerCallFailed`, which is its own page |
| 6 | **"Multi-source"** was carried as a requirement. It is in **no checklist in the library** | Documented as a parameter with a floor. The real duties are **AIFMD Art 19(5)** (the AIFM stays liable however valuation is sourced) and **DORA Art 28(2)** (are two feeds from one provider two sources?), neither of which gives a number. **Do not cite "dual-source" to an NCA** |

### One review finding rejected

The deviation band halts on the first post back after any outage that spanned a real move, which looks like it wants scaling by elapsed time. **It does not, and that change was not made.** Auto-widening the band with staleness inverts the control: the longer the feed has been blind, the *less* a large jump should be adopted without a human. Halt-on-recovery is the intended behaviour. Size the band per acceptance interval instead. Recorded in the struct comment so it does not get "fixed" later.

### Not fixed, and deliberately (rev-35 scope)

`Feed.value` carries **no unit or decimals metadata**. Consumers key by `bytes32 assetId` and divide one feed by another; a unit mismatch would be silent. This is left to the technical spec in `Dev/` rather than guessed at here, because the answer depends on §16 **D4** (who posts, on what method) and **D0** (token decimals) — both unmade. ⚠️ **Do not deploy multi-feed ratios until it is settled.**

---

## 10. Rev-36 — the interconnection layer

Reviewing the design document *against this folder* on the wiring axis, rather than contract by contract. Every finding was one-directional: **the code under-connected relative to the spec.**

### The one that mattered

**`ModularCompliance` could register exactly two contracts.** `ModuleAdapter`'s NatSpec claimed it bridged *"`HoldingPeriodLock.checkTransfer(address)`, and the fund modules in this folder"* — only `CovenantGate` ever inherited it. So `HoldingPeriodLock` (1-arg gate) and `PdmrClosedPeriodFreeze` (2-arg gate) were **unreachable from the C1 hook**, enforced only if a transfer agent remembered to call them. For a MAR Art 19(11) closed-period freeze that is the breach it exists to prevent, reported as a clean transfer.

Fixed with two adapters, `HoldingPeriodGate` and `PdmrClosedPeriodGate`. Both hold **no logic of their own** — logic in an adapter is a second place to look for the Article. `HoldingPeriodGate` gates the **sender only and skips mint**, since a holding period restricts *exiting*: a burn is in scope, a mint is not, and `SecurityToken._check` already states the same expectation from the other side.

### The one that was NOT fixed, on purpose

**No adapter for `EltifConcentration`, `UcitsFiveTenForty`, `NavBorrowingCap` or `LmtGate`** — and `ModuleAdapter`'s NatSpec was corrected to stop promising one. Four reasons, any one sufficient:

- A P2P transfer moves **neither the capital nor the NAV denominator**.
- A **mint raises the denominator and lowers every concentration ratio** — vetoing subscriptions during a breach blocks the remedy.
- `suspended` is the ELTIF **Art 17(1)(c) / Art 16(3)–(4) relief window during a capital raise**, not a trading halt. Gating mint on it is inverted.
- `onMint`/`onBurn` take a **cash amount from the subscription agent, not the token's unit amount**.

They are gated by their own reverting functions, which satisfies §11 on its own terms. The design document's §5 gate (c) called them *"transfer-side, C1-hook controls"* and that has been withdrawn.

### The rest

| # | Finding | Fix |
|---|---|---|
| 1 | **DLT Pilot Art 4(2)(c)–(g) enforced in two places with different semantics.** `MemberEligibility` carried them as boolean claim topics — **live, not dead**. (g) is the unsafe one: informed consent binds a *specific* risk disclosure, so as a boolean, updating that disclosure left every stale consent valid — the exact defect the covenant store exists to stop | Topics 22–26 removed. **(a)+(b) stay claims** (attestations *about* the member); **(c)–(g) are covenants**. Numbers **retired, never reassigned** — a stale claim resolving to nothing fails closed, one resolving to something else fails open. Topic 8 (`TOPIC_PRIIPS_KID_DELIVERED`) retired on the same rule |
| 2 | **`SubscriptionEscrow` had no link to `DocumentRegistry` at all** — zero imports. Window A opened on a bare governance call, so escrow and registry could diverge **both ways**: anchor a supplement and skip the escrow call → **no window opens**, a straight Art 23(2) breach; or open one with nothing filed → a withdrawal period against a document nobody was given | `publishSupplement` now takes the supplement's version hash and refuses unless **anchored *and* NCA-approved** — the same gate `DoraGovernor.queueUpgrade` applies. Subscribe path also checks the prospectus **anchor**, not just the Art 12 clock. ⚠️ **One direction stays open**: nothing can force the escrow call, so anchoring is a two-step procedure with a named owner and a reconciliation alarm off `SupplementAnchorVerified` |
| 3 | **`ValuationOracle`'s circuit-breaker hook pointed at nothing** — `DoraGovernor` had `pause()` and no `tripFromOracle`. My regression from the rev-35 pass | `DoraGovernor.tripFromOracle` added. Held by the **oracle, not governance** (an automatic trip nobody can invoke automatically is not automatic), and scoped so it can **only pause** — never unpause, upgrade, rotate or cancel. A compromised oracle costs a DoS governance can lift, not control. Idempotent, so a second halted feed does not look like a failed escalation |
| 4 | **Three price feeds, one documented.** `ValuationOracle` (NAV), `DltPilotCapGate`'s Art 3(4) monthly-average register, `BuybackAgent`'s Del. Reg 2016/1052 market inputs | **Not consolidated — the data genuinely differs.** Documented instead, because each is a separate ICT third party and DORA's Register of Information, Art 28(2) concentration test and Art 28(8) exit strategy are all per-provider |
| 5 | **§3's topology diagram drew a chain; the code is a star.** `ModularCompliance` holds **no identity reference** — each module wires its own | Diagram rewritten. The fan-out is the same one §2a coupling 3 raises about revocation reaching N references — **named, not resolved; it is D18** |

### Verified correct, no change needed

- `CovenantRegistry → DocumentRegistry.isCurrent()` — read at check time, no sweep. Exactly §4a.
- `DistributionAgent → ModularCompliance.canTransfer()` — payouts run the C1 gate; `CouponSchedule` and `DistributionWaterfall` route through it rather than paying directly.
- `DoraGovernor`'s locally-declared `IDocumentRegistry` **matches** `DocumentRegistry.documentStatus`. A legitimate decoupling — the only real risk is silent signature drift with no compile-time check.
- `SettlementEngine → DltPilotCapGate.withinArt5_8CommercialBankMoneyHeadroom()` — signatures align.
- `BuybackAgent → PdmrClosedPeriodFreeze` — one closed-period calendar for directors and treasury.

---

## 11. Rev-52 — the code review, and the nine things that were not what this file said they were

`CODE-REVIEW-2026-09-08.md` read all 30 contracts against design rev 49 and the ten drafted articles. Every finding below was re-read at the cited lines before it was fixed, and the suite compiles clean after. **The pattern worth naming: seven of the nine were controls this file or the design already described as working.** A control described in prose and not read by a `require` is the same defect §11 of the design exists to catch, one level up — the design's own gating test applied to the design's own claims.

### The nine

| # | What was wrong | Fix |
|---|---|---|
| **1** | **`SecurityToken.forcedTransfer` never read the restriction store.** Its NatSpec said the sender's hold was enforced "because `compliance.checkTransfer` still runs `RestrictedPartyGate`" — i.e. through the **removable module list**, which is the exact demotion rev 48 was written to prevent. `removeModule` or `emergencyBypass` on the gate and an agent key could place units on a listed person | `restrictions.assertTransferPermitted(from, to)` now runs first, in the mandatory layer, on the forced path too. The store's permitted-destination register still relieves the **sender** limb, so a seizure to a registered destination executes and a forced transfer out of a restricted wallet to anywhere else reverts |
| **2** | **`CovenantRegistry.effectiveTier` recursed infinitely** once an opt-up covenant was configured: `effectiveTier` → `_satisfied` → `appliesTo` → `effectiveTier`. Every transfer by an elective-professional holder would have reverted, and M3 §5 rule 4 *recommends* that configuration for retail distribution | The opt-up covenant is evaluated against the **raw** tier via `_satisfiedAtTier`. `setOptUpCovenant` now rejects a misconfigured predicate rather than accepting one that can never evaluate |
| **3** | **Any RECEIVE-scoped covenant blocked every burn.** `CovenantGate` asked `assertSatisfied(address(0), RECEIVE)`, `tierOf(0)` is `Unset`, the predicate is unevaluable, and unevaluable fails closed — correctly. PRIIPs Art 13, ELTIF Art 26 and DLT Pilot 4(2)(g) all carry RECEIVE, so redemptions, buy-back burns and maturity burns were dead | Burn gates the **sender** only. The zero leg is skipped, as the other three adapters already did |
| **4** | **`SubscriptionEscrow.settle()` was permissionless and waited only for windows already pushed**, so a subscription could be settled one block after acceptance and `withdrawAcceptance` then reverted `AlreadySettled`. On an offer with the final price omitted at filing that destroyed the Art 17(2) right for the whole offer. **The design said this too** (§8: "release is immediate… a no-op"), so the code was right about the spec and the spec was wrong about the Regulation | `offerClosesAt` is fed by governance and extend-only; `settle` waits for it, for the final price where one was omitted, and for every pending window. `subscribe` refuses after the close, so a late subscription cannot be settled in the same block |
| **5** | **`subscribe()` accepted against an anchored-but-unapproved prospectus** — it read `currentVersionHash` and never `approvedAt`, while Art 12's twelve months run **from approval**. Open and recorded since rev 49 | Approval is required, and validity is anchored to the **base** prospectus's approval, so a supplement's later approval cannot restart the clock. `checkEligible` and `assertNotBlocked` now also run on the subscriber |
| **6** | **The fund modules' permissionless sync took caller-supplied classification.** Anyone could call `syncAssetValuation(assetId, isEligibleLongTerm, …)` with false flags and hide a 55% floor breach. The permissionless argument covers the oracle *figure*; it never covered the *classification* | Classification is persisted at the manager-gated trade call; sync takes an id and reads it. `UnknownAsset` / `UnknownLeg` on anything never recorded |
| **7** | **`syncNav` zeroed the cash and payout counters on every call**, whether or not the oracle had accepted anything new. A redemption followed by a sync overstated NAV permanently, and the next `rollWindow` was oversized by the erased payouts — the dilution `LmtGate`'s own header says it prevents | `lastAbsorbedAcceptedAt`: counters clear only when the oracle's acceptance is strictly newer |
| **8** | **The active path checked oracle *freshness* and divided by the *last synced* NAV**, and sync was voluntary — so an AIFM could simply not call it and draw against a stale higher figure | Acquisition paths sync inline first, then check freshness, then compute |
| **9** | **The UCITS 40% band aggregate drifted.** Membership was decided at touch time, so a NAV move carrying an issuer across 5% never added it | An enumerable issuer set bounded at 256, re-summed on every recheck and trade. A buy that leaves the issuer under 5% and does not grow the band now passes during a band breach |

### And the two this file was wrong about

- **`DoraGovernor` was never swept after design rev 46.** It still carried `queueUpgrade` with the withdrawn disclosure gate, `executeUpgrade` doing an arbitrary `target.call`, a 12-hour timelock floor against the design's ≥48h, and a header asserting the "NCA approves the deployment" inversion **rev 49 corrected**. Now stripped to pause, incidents, key rotation and `tripFromOracle`, with two-step governance.
- **The oracle trip halted nothing** (see the sweep note at the top). Fixed by giving the pause readers.

### Reference discipline — the rev-38 standing rule

The rule (interface-typed, governance-settable, never `immutable`, never null) was violated in nine contracts while revs 39–40 recorded it as complete with two exceptions. Swept: `IdentityRegistry`'s claim-topic and trusted-issuer references, `SubscriptionEscrow`'s identity and document references, `PdmrClosedPeriodFreeze`'s register, the fund modules' oracle (now `IValuationFeed`, which the oracle declares), and zero-checks on the three economics constructors. `IdentityRegistry` imports the shared `Tier` and declares `is IIdentityGate`. **The sanctioned exception is an adapter binding its own module** — `CovenantGate`, `HoldingPeriodGate`, `PdmrClosedPeriodGate` — which is a module swap, not a re-point.

⚠️ **`CovenantRegistry → IdentityRegistry` was the *other* declared exception and is now closed** — it types `IIdentityGate`. If **D19** (ONCHAINID) reopens what the identity interface should contain, that is the seam to revisit.

### Roles, keys and the pause

Every manager role in the fund modules is rotatable (two-step for the AIFM/ManCo, setters for agent and regulator); `DoraGovernor`, `PdmrRegister` and `PdmrClosedPeriodFreeze` gained two-step governance. `grantPermission` (MAR Art 19(12) override) moved from the issuer to governance, matching the design and S3.

### Still open after this pass — do not read the above as "done"

1. **D20 blocks any proxy deployment.** 95 `immutable` declarations across 28 files. The rev-42 *mechanism* was imprecise (an immutable reads the **implementation's** constructor value through a proxy, not zero) and its *conclusion* stands: `SubscriptionEscrow.mode`, `finalPriceOmittedAtFiling`, `NavBorrowingCap.fundType`, `ClaimTopicsRegistry.governance` and `ModularCompliance.governance` are all silently load-bearing. `SubscriptionEscrow` now carries a **"never behind a proxy"** header, mirrored in `UPGRADE-ARCHITECTURE.md`. **Which contracts are proxied is still undecided.**
2. **`LmtGate` is still not the ELTIF RTS Art 5(5)–(6) cap** — no liquid-asset bucket, no 12-month forecast, neither Annex grid. It is now a correct AIFMD II Art 16(2a) / Annex V toolkit with pro-rata allocation and a minimum window. **S2 §… claims the forecast is a fed input; it is not — the article needs the correction.**
3. **No issuer-lane surveillance emitter.** `MarketEventSchema` has no implementer outside the parked dealer lane, so the Art 16(2) own-trading order-lifecycle surface M5/S3 describe does not exist. Either implement it on the buy-back path or correct both articles.
4. **The escrow mints nothing.** It holds cash and refunds it; there is no pending-state token, so §17's "burn + refund on withdrawal", S1 and Pure Issuer describe a mechanism with no code. **Decide whether the escrow mints, then sweep whichever side is wrong.**
5. **Native asset only.** `DistributionAgent` and `SubscriptionEscrow` are `payable`; there is no ERC-20/EMT leg. **D6 has no code**, and review finding 1.12 (Travel Rule on an EMT payout) is unreachable rather than unresolved.
6. **Not modelled, and now stated in the headers:** ELTIF Art 15(2), Art 13(7) professional-only relief, the MMF single-tool derogation.
7. ~~**`mar-checklist.md` §6.4 disagrees with the Series Plan** on where the €20k PDMR threshold sits and on the issuer's publication limb.~~ **✅ CLOSED 2026-09-08 — and it closed in favour of the code.** Settled against `EU Compliance/Checklist/mar.mhtml`, the consolidated text (CELEX:02014R0596-20260605) the checklist itself cites, read verbatim: the threshold is **Art 19(8)** *("calculated by adding without netting")*; **Art 19(9)** is a **competent-authority** decision to raise it to **€50,000 or lower it to €10,000**; **Art 19(1a)** is the collective-investment-undertaking **exemption**, not a threshold; the issuer publishes under **Art 19(3)** within **two** business days of **receipt**. `PdmrRegister`'s citations were already right — **do not change them.** `mar-checklist.md` corrected to its rev 1.2; the design doc's threshold statements swept at rev 52. ⚠️ **One substantive consequence, not a citation fix: the €10,000 downward option was missing from every document**, so any notification engine built to a €20k floor under-reports wherever an authority took the lower option. The threshold is a **three-valued** per-jurisdiction parameter. ⚠️ **Method worth keeping:** the `Checklist/` files are the source for compliance claims, but a checklist is itself derived — where it conflicts with the consolidated text it cites, **the `.mhtml` snapshot beside it is the tiebreaker.** That is what settled this, and the design's own rev 13 had previously "corrected" the citation *to* the wrong answer, where it stood for 39 revisions.
8. **Two leaks from §5's sixth item survive by operating rule, not code:** `freezeUnits` as a whole-wallet stop, and `recoverWallet` leaving a wallet-keyed restriction behind. Both are in `DEPLOYMENT-DEFAULTS.md`; neither is enforced on-chain.
9. **No test harness.** Every statement in this file is from reading and compiling, never from running.
