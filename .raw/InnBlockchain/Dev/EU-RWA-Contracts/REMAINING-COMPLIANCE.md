---
title: Remaining Compliance — EU-RWA-Contracts
date: 2026-09-06
status: derived from the 23 .sol files in this folder + §17 of eu_tokenized_securities_smart_contract_design.md
---

# Remaining Compliance List

**23 contracts built. The §17 inventory is complete.**

What is left is not "more contracts". It is three edits to existing files, and one decision nobody has made.

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

- Fund rules: AIFMD II, UCITS, ELTIF portfolio limits — **5 contracts, done**
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
