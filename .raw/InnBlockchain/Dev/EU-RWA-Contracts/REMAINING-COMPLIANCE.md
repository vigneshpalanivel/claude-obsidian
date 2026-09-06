---
title: Remaining Compliance — EU-RWA-Contracts
date: 2026-09-06
status: derived from the 26 .sol files in this folder + §17/§17a of eu_tokenized_securities_smart_contract_design.md
---

# Remaining Compliance List

**24 contracts built. §17's contract inventory and §17a's matrix are now both complete.**

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

### The one dead line to know about

```solidity
ClaimTopicsRegistry.sol:28
uint256 public constant TOPIC_PRIIPS_KID_DELIVERED = 8;  // PRIIPs Art 13 — KID version hash bound
```

Declared once, **read nowhere**. And a claim topic is a yes/no flag, while the comment promises a version hash. If the KID is revised, the flag still says yes — the sale looks clean and breaches Art 13. This is the exact failure the covenant store was designed to stop.

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

### Three fixes to existing contracts (edits, not new files)

| Where | Fix |
|---|---|
| `ClaimTopicsRegistry.sol:28` | delete `TOPIC_PRIIPS_KID_DELIVERED` — Art 13 now lives in `CovenantRegistry`, and leaving a boolean topic named "KID delivered" invites someone to wire it up |
| `DoraGovernor.sol:37` | point at the real `DocumentRegistry`; drop the local `IDocumentRegistry` declaration |
| `IdentityRegistry.sol` | `jurisdiction` is one value; covenants can key on residence *and* tax residence *and* nationality. Until it is set-valued, those predicates fail closed rather than match on residence alone |
| `SiQuoteEngine.sol` | **does not compile** without `viaIR` — stack too deep at line 363. Pre-existing, committed in `6b0b45a`. Every other file in the folder builds on plain solc 0.8.22 |

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

### Rows checked and confirmed *not* gaps

| §17a row | Verdict |
|---|---|
| Surveillance event schema (§6) | **Closed.** `MifirEventSchema` carries `OrderCreated`/`OrderModified`/`OrderCancelled` + flagged `TradePublished` and says so in its own header — the RTS 1/RTS 2 set *is* the MAR Art 8(1) set. Built once, feeds both, exactly as §7 specifies. |
| MiFIR Art 26 / APA-DPE / CTP bridges | **Closed.** Footnote ⁸: *"The `Trade` event schema is ● in every case — what is conditional is the delivery bridge, not the data capture."* Both schemas exist; bridges are off-chain. |
| Matching engine | **Not a contract.** Footnote ⁶: off-chain logic settling through `SubscriptionEscrow`/`LmtGate`. |
| `LoanRetention` | **Not in scope.** Footnote ¹¹: only under a separate loan-participation mandate. |
