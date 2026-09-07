---
title: Remaining Compliance — EU-RWA-Contracts
date: 2026-09-07
status: derived from the 26 .sol files in this folder + §17/§17a of eu_tokenized_securities_smart_contract_design.md (rev 36)
---

# Remaining Compliance List

**26 contracts built. §17's contract inventory and §17a's matrix are now both complete.**

> ⚠️ *Count corrected 2026-09-07 — this line read "24" against 26 `.sol` files, which the frontmatter above had right. See §9 for the rev-35 review of `ValuationOracle` and the four fund modules, including one live breach of DORA Art 28.*

The last gap — §17a's **valuation / NAV oracle**, `●` required in the Fund lane with no file — is closed. See §8, which also records what changed in the four fund modules and the one thing that stayed open.

What is left is three edits to existing files, and one decision nobody has made.

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
| **Payout eligibility** | a frozen wallet must not get paid | `DistributionAgent` ✅ — same C1 gate as a transfer |

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

- Fund rules: AIFMD II, UCITS, ELTIF portfolio limits — **5 contracts, done**, now all reading `ValuationOracle` rather than a private NAV (§8)
- Venue: DLT Pilot caps, member eligibility, settlement — **done**
- Trading: MiFIR quotes, reporting and transparency events — **done**
- Identity: KYC claims, trusted issuers, eIDAS — **done**
- Operations: DORA governance wrapper — **done**
- CSDR and SFD: correctly handled as exemption conditions inside `SettlementEngine`, not separate contracts
- GDPR: a design rule, not a contract. Nothing personal on-chain.

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

1. **Neither pays anyone.** Both compute an amount and hand it to `DistributionAgent`, so income goes out through the same C1 eligibility gate as a transfer. A coupon contract that paid holders directly would let a frozen wallet collect interest on units it cannot move.
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
| Surveillance event schema (§6) | **Closed.** `MifirEventSchema` carries `OrderCreated`/`OrderModified`/`OrderCancelled` + flagged `TradePublished` and says so in its own header — the RTS 1/RTS 2 set *is* the MAR Art 8(1) set. Built once, feeds both, exactly as §7 specifies. |
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
