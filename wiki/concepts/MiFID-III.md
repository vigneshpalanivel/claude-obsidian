---
title: "MiFID III: 2024 Review of EU Financial Markets Framework"
type: concept
status: current
created: 2026-05-14
updated: 2026-05-24
tags:
  - MiFID-III
  - MiFID-II
  - MiFIR
  - EU
  - fintech
  - compliance
  - investment
  - regulation
related:
  - "[[MiFID-II]]"
  - "[[MiFID-II-NCA-Authorization-Mechanics]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[ESMA]]"
  - "[[InnBlockchain FinTech ICP]]"
sources:
  - "Directive (EU) 2024/790 — https://eur-lex.europa.eu/eli/dir/2024/790/oj"
  - "Regulation (EU) 2024/791 — https://eur-lex.europa.eu/eli/reg/2024/791/oj"
  - ".raw/InnBlockchain/EU Compliance/mifid3-checklist.md"
---

# MiFID III: 2024 Review of EU Financial Markets Framework

**"MiFID III"** is a working label, not a standalone regime. It refers to the **MiFID/MiFIR Review package** — **Directive (EU) 2024/790** (amending MiFID II Directive 2014/65/EU) + **Regulation (EU) 2024/791** (amending MiFIR Regulation 600/2014). Both adopted 28 February 2024, published in the OJ on 8 March 2024, entered into force 28 March 2024.

> You do not apply for "MiFID III authorization." You apply for [[MiFID-II]] authorization that complies with the 2024 amendments. The full [[MiFID-II]] obligation stack remains intact — these are targeted recalibrations, not a replacement.

> [!info] Practitioner detail
> This page holds the **conceptual orientation** — what the 2024 review does and why. For the **applicant-level delta checklist** (section-by-section ☐ items, PFOF triage, SI reclassification analysis, application-pack addenda for 2026 filers), see [`.raw/InnBlockchain/EU Compliance/mifid3-checklist.md`](../../.raw/InnBlockchain/EU%20Compliance/mifid3-checklist.md).

---

## What the Two Acts Do

| Act | Amends | Substance |
|---|---|---|
| **Directive (EU) 2024/790** | MiFID II (Dir 2014/65/EU) | Re-routes definitions and venue obligations to MiFIR; narrows SI regime to equity-only with a qualitative test; deletes RTS 27 best-execution reporting; extends the three-active-members rule to regulated markets |
| **Regulation (EU) 2024/791** | MiFIR (Reg 600/2014) | Establishes the EU consolidated tape (three asset classes); prohibits PFOF; replaces double volume cap with a single 7% EU-wide cap on the reference price waiver; recalibrates pre-trade transparency; expands business-clock-sync; creates the Designated Publishing Entity (DPE) role |

The split matters: more substance is moving *into* MiFIR (directly applicable, no transposition lag) and *out of* the Directive. Member State variance shrinks.

---

## Implementation Timeline

| Date | Event | Source |
|------|-------|--------|
| **28 March 2024** | Both acts enter into force; PFOF prohibition immediately applicable in non-legacy MS | Dir Art. 3; Reg Art. 2 |
| **29 June 2024** | Commission deadline — delegated act on OTC derivatives identifier | Reg Art. 27(5) |
| **29 September 2024** | MS deadline to notify ESMA of legacy PFOF exemption | Reg Art. 39a(2) |
| **29 December 2024** | ESMA RTS deadlines: CTP selection (bonds), business clock sync, data quality, Art. 26/27 fields, DPE/ARM access | Reg Arts. 22b, 22c, 26, 27, 27da, 27i |
| **29 March 2025** | ESMA RTS deadlines: volume-cap collation, reference price waiver, SSTI/SMS calibration | Reg Arts. 4, 5(9), 11, 11a |
| **29 September 2025** | **Directive transposition deadline**; volume cap monitoring begins; derivatives pre-trade transparency live; CT data contributions begin | Dir Art. 2; Reg Art. 5(8), 22a |
| **30 June 2026** | **PFOF legacy MS exemption sunsets** — full Union-wide ban for retail + pro-on-request clients; Commission reviews EBBO design | Reg Art. 39a(2) |
| **29 September 2027** | ESMA first annual volume-cap adequacy report; Commission may adjust 7% threshold | Reg Art. 5(10) |

CTP selection runs in three phases: bonds (initiated by 29 December 2024), shares/ETFs (6 months after bonds), OTC derivatives (3 months after the derivative-identifier delegated act, minimum 6 months after shares/ETFs). Each provider awarded a 5-year mandate.

---

## Key Changes

### 1. Payment for Order Flow — Prohibited (MiFIR Art. 39a — new)

PFOF — receiving any fee, commission, or non-monetary benefit from a third party for executing or forwarding **retail or professional-on-request** client orders on a particular venue — is **prohibited Union-wide**. Per-se-professional clients and eligible counterparties are out of scope. Geographic scope covers all transactions, including those on third-country venues.

**Legacy exemption:** Member States where PFOF was permitted pre-28 March 2024 may temporarily exempt their firms — but only for clients **domiciled or established in that MS**, and only **until 30 June 2026**. MS had to notify ESMA by 29 September 2024 to use the exemption.

**Permitted carve-out:** Venue tariff rebates passed through to the client (with no firm benefit) do not count as PFOF.

### 2. Consolidated Tape — Three Asset Classes (MiFIR Arts. 22a, 27da, 27db — new)

Three EU consolidated tape providers, awarded via competitive ESMA selection on 5-year exclusive mandates:

- **Bonds CTP** — selection initiated 29 December 2024; revenue-redistribution arrangement (small venues + new issuances + pre-trade-transparent trading weighted)
- **Shares/ETFs CTP** — selection within 6 months of bonds; publishes the **European Best Bid and Offer (EBBO)** *without* the venue MIC
- **OTC derivatives CTP** — selection after derivative-identifier delegated act; minimum 6 months after shares/ETFs

**Mandatory data contribution** applies to RMs, MTFs, OTFs, APAs, DPEs, and in-scope SIs. Small venues (<1% Union trading volume) and SME growth markets (85%+ self-execution) are exempt unless they opt in. Real-time transmission in harmonised RTS-specified format.

The Commission will assess by 30 June 2026 whether the anonymised EBBO design for shares/ETFs is sufficient and may propose legislative amendments.

### 3. Systematic Internaliser Regime — Reset (MiFID II Art. 4(1)(20); MiFIR Arts. 14–19)

**Quantitative thresholds replaced by qualitative test.** The MiFID II SI definition is rewritten: SI status applies on the basis of "organised, frequent and systematic" dealing on own account in **equity instruments** outside trading venues. Non-equity SI status is now **opt-in only**.

**Operational impact:**
- Equity SIs: quote-size and quoting-trigger thresholds recalibrated via ESMA RTS (Standard Market Size, SSTI — RTS due 29 March 2025)
- Non-equity SIs: pre-trade transparency obligations on firm quotes (legacy Arts. 18–19) **deleted** — non-equity SIs now subject only to post-trade transparency and transaction reporting
- ESMA stops publishing the quantitative SI-determination data for non-equity instruments

### 4. Single Volume Cap (MiFIR Art. 5 — amended)

The legacy **double volume cap** (4% per venue + 8% EU-wide, both applying to reference price waiver + negotiated trade waiver combined) is replaced by a **single 7% EU-wide cap** on the **reference price waiver only**. The negotiated trade waiver is no longer subject to the cap. Per-venue thresholds eliminated. ESMA monitors and publishes monthly collation.

### 5. Pre-Trade Transparency Expanded to Derivatives (MiFIR Arts. 8a, 8b — new)

Pre-trade transparency obligations now apply to:
- Exchange-traded derivatives (ETDs)
- OTC derivatives denominated in EUR / JPY / USD / GBP, subject to the EMIR clearing obligation, with specified tenors / CDS reference indices
- Package orders across bonds, structured finance products, emission allowances, derivatives

Calibrated by trading-system type (order book / quote-driven / RFQ / voice / hybrid). LIS and SSTI waivers retained but recalibrated.

### 6. Best Execution Overhaul (MiFID II Art. 27 — amended)

- **RTS 27 venue-quality reports — deleted** (Art. 27(2), (3) old, (6) — deleted). The consolidated tape replaces venue-quality reports as the primary execution-quality data source.
- **RTS 28 top-five venue report — restructured** under new Art. 27(10) RTS distinguishing retail vs. professional client criteria (ESMA RTS pending).
- Investment firms must monitor execution effectiveness on a regular basis and notify clients of material changes to execution arrangements (Art. 27(7) — replaced).

### 7. Multilateral Systems Re-Routed to MiFIR (MiFID II Art. 1(7) — deleted; MiFIR Art. 1(5b) — new)

The substantive rule that any multilateral system must operate as RM, MTF, or OTF — and the "multilateral system" definition itself — move from MiFID II into MiFIR. Now directly applicable across the Union, no national-implementation variance. The 2021 ESMA report identified meaningful non-compliance among broker-crossing networks and hybrid systems; the 2024 move tightens enforcement.

The three-materially-active-members rule (was MTF/OTF only under Art. 18(7)) is **extended to regulated markets** via amendments to Art. 47(1).

### 8. Business Clock Sync + Designated Publishing Entity (MiFIR Arts. 22c, 27f–27i)

Business clock synchronisation now applies to trading venues *plus* their members/participants/users, Systematic Internalisers, Designated Publishing Entities, APAs, and CTPs (accuracy via RTS).

The **Designated Publishing Entity (DPE)** is a new role — investment firms or market operators authorized by ESMA to publish post-trade transparency data on behalf of themselves and/or other firms. Cost-based pricing, objective access rules, 5-year record retention (RTS due 29 December 2024).

### 9. Transaction Reporting Field Expansion (MiFIR Art. 26 — amended)

Enhanced fields for post-trade transaction reporting (T+1 via ARM regime unchanged in scope), particularly around derivative identifiers and counterparty data. ESMA RTS due 29 December 2024 specifies field set. OTC derivatives identifier (Commission delegated act, due 29 June 2024) is a prerequisite for the OTC derivatives CTP timeline.

---

## What Did *Not* Change

- The MiFID II / MiCA boundary — [[MiCA-Regulation]] Art. 2(4) carve-out is untouched
- Client categorization framework (retail / professional / eligible counterparty)
- Core suitability and appropriateness obligations
- Algorithmic trading requirements (Art. 17)
- Capital requirements under IFD/IFR (separate framework)
- Recordkeeping retention period (5 years, extendable to 7 on NCA request)

---

## MiFID III vs MiFID II — Delta Comparison

| Area | MiFID II (legacy) | Post-2024 (MiFID III) |
|------|-------------------|-----------------------|
| **PFOF** | Allowed with disclosure | **Prohibited** for retail + pro-on-request (legacy MS exemption to 30 Jun 2026) |
| **Post-trade data** | Fragmented national/venue feeds | **Three EU consolidated tapes** (bonds / shares+ETFs / OTC derivs) |
| **Volume cap (equity)** | Double cap: 4% per venue + 8% EU-wide on ref-price + negotiated trade waivers | **Single 7% EU-wide cap** on reference price waiver only |
| **SI determination** | Quantitative thresholds (quarterly ESMA data) | **Qualitative test** for equity; non-equity = **opt-in only** |
| **Non-equity SI pre-trade transparency** | Required for firm quotes (Arts. 18–19) | **Deleted** |
| **Best-execution reporting** | RTS 27 (venues) + RTS 28 (firms) | **RTS 27 deleted**; RTS 28 restructured under new RTS (retail vs pro) |
| **Multilateral system rule** | In MiFID II Art. 1(7) — Member State transposed | In MiFIR Art. 1(5b) — **directly applicable** |
| **Three-active-members rule** | MTF/OTF only | Extended to **regulated markets** |
| **Business clock sync** | Venues + members | Extended to **SIs, DPEs, APAs, CTPs** |
| **DPE role** | Did not exist | **New** — publishes post-trade data; ESMA-authorized |
| **Derivative pre-trade transparency** | Limited (LIS/SSTI waivers heavily used) | **Expanded** to ETDs + euro/JPY/USD/GBP cleared OTC derivs |

---

## InnBlockchain and FinTech Implications

**For Compliance-focused FinTech ICPs:**
- **PFOF ban is a revenue-model deal-breaker** for any robo-advisor, retail brokerage, or execution platform funded by venue rebates. Re-pricing or client-tier shift needed before 30 June 2026.
- **Consolidated tape consumption** = cheaper market data baseline but more transparency for regulators to scrutinise execution-quality decisions.
- **SI reclassification** affects any firm dealing on own account against retail equity orders — qualitative test gives no quarterly off-ramp.
- **Transaction-reporting field expansion** + DPE designation = compliance-tech investment window.

**For DLT MTF / DLT Pilot Regime applicants ([[DLT-Pilot-Regime]]):**
- The 2024 transparency, CT data-contribution, business-clock-sync, and PFOF rules apply **on top of** Pilot Regime obligations — not as substitutes.
- On-chain matching engines that interact multiple third-party buying/selling interests are **multilateral systems** under MiFIR Art. 1(5b) — must authorize as RM/MTF/OTF or restructure as bilateral SI.
- Block-time and oracle clock-drift become regulatory issues under the new Art. 22c clock-sync regime.

**For RWA / tokenized-securities issuers ([[Asset-Tokenization-RWA]]):**
- Tokenized bonds and shares trading on multilateral matching surfaces inherit the full MiFIR 2024 transparency stack — RM/MTF/OTF status plus mandatory CT contribution.
- "Bilateral OTC dealing only" architectures avoid the multilateral system trap but must satisfy the qualitative SI test if conducted at organised frequency.

**For InnBlockchain service positioning:**
- **MiFID III readiness audit** = a defined service line for existing [[MiFID-II]]-authorized clients (PFOF revenue audit, SI reclassification, CT integration architecture, best-execution-policy update).
- **DPE infrastructure build** = emerging niche — ESMA-authorized post-trade publication entity with cost-based pricing model.
- **Inducements + PFOF on-chain analogues** (MEV capture, validator rebates, on-chain auction proceeds) need Art. 39a treatment in the order-routing logic for any on-chain execution venue serving EU retail.

---

## Key Open Items (RTS / Delegated Acts Pending)

Most operational detail sits in Level 2 measures. Critical-path items:

- ESMA RTS on volume-cap collation methodology (deadline 29 Mar 2025)
- ESMA RTS on data quality standards for CT contributors (deadline 29 Dec 2024)
- ESMA RTS on business clock sync accuracy (deadline 29 Dec 2024)
- ESMA RTS on SMS and SSTI calibration (deadline 29 Mar 2025)
- ESMA RTS on order execution policy criteria — retail vs professional (no fixed deadline; replaces RTS 28)
- Commission delegated act on OTC derivatives identifier (deadline 29 Jun 2024) — gates OTC derivatives CTP timeline
- ESMA RTS on DPE/ARM cost-based pricing and access (deadline 29 Dec 2024)

Track ESMA Level 2 publications and home NCA transposition bulletins continuously.

---

## Key Regulators

- **[[ESMA]]** — Level 2 RTS/ITS development; CTP selection procedures; centralised data publication (volume cap, transaction reporting)
- **NCAs** — home-Member-State supervision; national transposition of Directive 2024/790; sanctions for breaches of new MiFIR provisions
