---
type: concept
title: "IPR — EU Instant Payments Regulation"
created: 2026-05-25
updated: 2026-05-25
tags:
  - IPR
  - SEPA
  - PSD2
  - PSD3
  - EU
  - payments
  - fintech
  - compliance
status: current
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[DORA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[GDPR-Regulation]]"
  - "[[eIDAS-2.0]]"
  - "[[InnBlockchain FinTech ICP]]"
sources:
  - "Regulation (EU) 2024/886 — https://eur-lex.europa.eu/eli/reg/2024/886/oj"
  - ".raw/InnBlockchain/EU Compliance/ipr-checklist.md"
  - ".raw/InnBlockchain/EU Compliance/IPR.html"
---

# IPR — EU Instant Payments Regulation

The **Instant Payments Regulation** (**Regulation (EU) 2024/886**, of 13 March 2024) is an *amending* act — it does not create a new regime. It surgically modifies four existing instruments to make euro instant credit transfers mandatory for every PSP that already offers euro credit transfers, at no extra cost, with pre-authorisation **Verification of Payee (VoP)**, daily **PSU-level sanctions screening**, and direct **PI/EMI access to designated payment systems**. It entered into force on **8 April 2024** with the first hard deadline — **9 January 2025** — already past.

> [!info] Practitioner detail
> Article-level requirements (10-second execution budget, four VoP scenarios, opt-out mechanics, Article 35a artefacts for PI/EMI system access, penalty regime, reporting templates, phased deadlines by zone × entity type) live in the companion **applicant-level readiness checklist** [`.raw/InnBlockchain/EU Compliance/ipr-checklist.md`](../../.raw/InnBlockchain/EU%20Compliance/ipr-checklist.md). This page holds the strategic / "what-is-the-IPR" framing.

> [!warning] The IPR is not an authorisation regime
> There is no "IPR licence." Obligations attach to PSPs by virtue of their existing PSD2 status — credit institution, payment institution, or electronic money institution — and to designated payment systems by virtue of SFD designation. NCAs supervise via the same powers they use for the underlying authorisation. The IPR is a **product-and-conduct overlay**, not a new licence track.

---

## What the Regulation Does — In One Sentence

If you are a PSP that offers euro credit transfers, you must offer the *instant* variant on every credit-transfer-reachable account, on every payment-initiation channel, 24/7/365, executed within 10 seconds, at a charge no higher than the non-instant variant, with mandatory pre-authorisation payee-name verification and daily customer-base sanctions screening.

---

## The Four Acts the IPR Amends

| IPR Article | Amends | Substance |
|---|---|---|
| **Article 1** | Regulation (EU) 260/2012 (SEPA Regulation) | Inserts new **Articles 5a–5d**: mandatory instant CT offering, charge parity, Verification of Payee, daily sanctions screening; tightens Article 11 penalty regime; extends Article 15 review/reporting |
| **Article 2** | Regulation (EU) 2021/1230 (Cross-Border Payments) | Aligns cross-border instant-CT charges to the SEPA charge-parity rule; resolves the conflict where the older national-currency equivalence rule would otherwise produce a higher fee |
| **Article 3** | Directive (EU) 2015/2366 (PSD2) | Extends PSD2 Article 10 safeguarding directly to **EMIs** and adds **competent authorities** as obligation-imposer alongside Member States (substantive obligations on PIs unchanged); creates **new Article 35a** setting conditions for PI/EMI participation in designated payment systems; opens indirect access via Article 35(3) |
| **Article 4** | Directive 98/26/EC (Settlement Finality Directive) | Adds **payment institutions and EMIs to the definition of "institution"** — making them eligible to participate directly in SFD-designated payment systems |

> **Why the SFD amendment is the structural enabler.** Pre-IPR, PIs and EMIs could not be direct participants in SFD-designated payment systems (TARGET, EURO1, STEP2, national instant rails). They had to ride on a sponsoring bank — precisely the bottleneck that has kept SCT Inst uptake low. The Article 4 amendment is the gate-opener; the Article 3 amendment (new Article 35a) is the supervisory price of admission.

---

## Who Must Comply

The IPR applies to **payment service providers** as defined in PSD2 — i.e.:

- **Credit institutions** authorised under CRR Article 4(1)(1)
- **Payment institutions** authorised under PSD2 Article 4(4)
- **Electronic money institutions** authorised under EMD2 Article 2(1)
- **EU branches** of third-country credit institutions providing payment services to EU customers

PISPs are in scope of one provision only (Article 5c(2) — VoP information accuracy and the related liability rule).

**Out of scope:**
- Pure CASPs (MiCA-only authorisation, no PSD2 licence) — IPR follows the fiat leg, not the token leg
- PIs/EMIs benefitting from PSD2 Article 32 / 33 exemptions (small PI, AISP-only) — excluded from the new SFD "institution" definition
- ECBs and NCBs acting in monetary-authority capacity — fully out of scope; partial carve-out (Article 5a(2)) when not acting as monetary authority
- PSPs that do not offer credit transfers in euro at all

> **IPR vs. MiCA — the boundary question.** The IPR amends PSD2 and SEPA. It binds *payment service providers* offering *euro credit transfers*. A pure crypto-asset service provider authorised under MiCA is **not** in IPR scope unless it also holds PSD2 authorisation (PI or EMI) for fiat rails. Most CASP business models that include a fiat on/off-ramp either hold or rely on a PSD2-licensed partner — in which case the IPR follows the fiat leg.

---

## The Four Core Obligations (New SEPA Regulation Articles 5a–5d)

### 1. Mandatory Instant Credit Transfer Service (Article 5a)

- **Reachability symmetry** — every account reachable for SEPA CT must be reachable for SCT Inst, including payment accounts with basic features
- **24/7/365** availability — no business-hour windows, no batch closures, no holiday outages
- **10-second end-to-end execution** — payer's PSP debits, sends, payee's PSP credits and confirms, all within 10 seconds of time of receipt; if no confirmation in 10 seconds, payer's account is restored
- **Channel parity** — every initiation channel that supports non-instant CT must also support instant CT
- **User limit right** — PSU can set a daily or per-transaction maximum and modify it at any time
- **Packaged orders** — if packaged submission is offered for non-instant, it must be offered for instant

### 2. Charge Parity (Article 5b)

- Charges for SCT Inst **must not exceed** charges for non-instant CT of corresponding type, on a per-PSU-segment basis
- VoP service (Article 5c) must be **free**
- "Corresponding type" assessed by channel, payment instrument, customer status, additional features and services
- Cross-border charge alignment (Article 2 IPR) prevents the older Regulation 2021/1230 national-currency equivalence rule from producing a higher cross-border instant-CT fee

### 3. Verification of Payee — VoP (Article 5c)

The single largest new operational build. Applies on every credit transfer (not just instant) **across every channel**, **pre-authorisation**, **free of charge**. Four matching scenarios:

| Scenario | Match | Action on mismatch |
|---|---|---|
| **(a)** IBAN + payee name | Payee's PSP verifies match | Notify payer + warn that authorising might transfer funds to a wrong payee; on "almost match," show name actually associated with the IBAN |
| **(b)** IBAN + alternative unambiguous identifier (fiscal number, European unique identifier, LEI) for legal persons | Payee's PSP verifies match if identifier held in internal system | Notify payer |
| **(c)** Multi-payee account | Payee's PSP confirms the indicated payee is among the multiple payees | Notify payer if not |
| **(d)** Channels not requiring IBAN + name | PSP must otherwise ensure correct payee identification and inform the payer to validate before authorising | — |

Non-consumer PSUs submitting packaged orders may **opt out** and opt back in at any time. PSP loses its Article 88 PSD2 liability shield if it fails to correctly perform VoP — refund the payer **without delay**.

### 4. Daily PSU-Level Sanctions Screening (Article 5d)

The most counter-intuitive provision. The IPR **prohibits transaction-by-transaction sanctions screening on SCT Inst** and replaces it with a **daily PSU-level screen**:

- Verify all PSUs against persons/entities subject to **targeted financial restrictive measures** (asset freezes / prohibitions on making funds or economic resources available under Article 215 TFEU)
- Run **immediately** after entry into force of any new or amended measure
- Run **at least once every calendar day**
- During SCT Inst execution, **no additional transaction-level verification** beyond the daily screen — for *targeted financial restrictive measures only*
- AML/CFT transaction monitoring under AMLD/AMLR is **retained**; non-Article-215 restrictive measures are **retained**

**Scope-trigger note:** Article 5d(1) binds "PSPs offering instant credit transfers" — the obligation crystallises when SCT Inst offering begins, not unconditionally on 9 January 2025. Euro-area credit institutions began receiving from 9 January 2025, so for them Article 5d binds from that date. PIs/EMIs whose own Article 5a deadline is 9 April 2027 are bound from that date unless they voluntarily offer earlier.

> The screening burden is **reallocated, not removed**. PSPs who read Article 5d as "you can stop sanctions screening" misread the Regulation. Get this wrong and the Article 11(1b) penalty regime — 10% of consolidated turnover for a legal person, €5M for a natural person — bites.

---

## Phased Compliance Timeline

| Obligation | Euro-area CIs | Non-euro-area CIs | Euro-area PIs / EMIs | Non-euro-area PIs / EMIs |
|---|---|---|---|---|
| **Receive SCT Inst** | 9 January 2025 | 9 January 2027 | 9 April 2027 | 9 April 2027 |
| **Send SCT Inst** | 9 October 2025 | 9 July 2027 | 9 April 2027 | 9 July 2027 |
| **Charge parity** | 9 January 2025 | 9 January 2027 | (with send) | (with send) |
| **Verification of Payee** | 9 October 2025 | 9 July 2027 | (with send) | (with send) |
| **Daily PSU sanctions screening** | **9 January 2025** | **9 January 2025** | **9 January 2025** | **9 January 2025** |
| **PSD2 + SFD national transposition** | 9 April 2025 | 9 April 2025 | 9 April 2025 | 9 April 2025 |
| **Member-State penalty rules** | 9 April 2025 | 9 April 2025 | 9 April 2025 | 9 April 2025 |
| **First annual PSP report** (charges + sanctions-rejection share) | 9 April 2025 | 9 April 2025 | 9 April 2025 | 9 April 2025 |
| **Non-euro out-of-business-hours send carve-out sunset** | n/a | 9 June 2028 | n/a | 9 June 2028 |

**Critical-path observation:** For credit institutions in the euro area, daily sanctions screening (Article 5d) binds from **9 January 2025** — the same date as the receive-SCT-Inst obligation. For PIs/EMIs with a 9 April 2027 offering deadline, Article 5d binds when offering begins. As of today (2026-05-25), any euro-area credit institution receiving SCT Inst without daily-screening capability is non-compliant; any PI/EMI offering SCT Inst voluntarily ahead of its 9 April 2027 deadline is bound from go-live.

**Newly euro-adopting Member States** (SEPA Regulation Article 16(9), inserted by IPR Article 1(5)): comply within one year of euro adoption, not later than the dates above for non-euro PSPs and not earlier than the dates for euro PSPs.

---

## Penalty Regime (SEPA Regulation Article 11 as amended)

| Breach | Maximum penalty | Source |
|---|---|---|
| General Articles 5a–5d infringements | Effective, proportionate, dissuasive — set by Member State | Art 11(1a) |
| **Article 5d (sanctions screening) — legal person** | **≥ 10% of total annual net turnover** (consolidated for subsidiaries) | Art 11(1b)(a) |
| **Article 5d — natural person** | **≥ €5,000,000** | Art 11(1b)(b) |
| Reachability breach during planned, foreseeable, short, PSU-pre-announced maintenance | **No penalty** | Art 11(1c) |

Senior management and management-body members can be personally penalised.

> **Risk-management implication.** Article 11(1b) puts sanctions-screening failures at AMLR/AMLD6-grade ceilings. The Article 5d build (Section 5 of the practitioner checklist) deserves Board-level governance attention, not Operations-level treatment.

---

## What Did *Not* Change

- PSD2 status thresholds and the initial-capital tiers (€20k AISP / €50k PIS-only / €125k for full PI / €350k EMI / CRR for credit institutions) — IPR does not change who needs which licence
- The Article 88 PSD2 "unique-identifier-prevails" liability rule — preserved subject to VoP performance
- AML/CFT obligations under AMLR / AMLD — IPR Article 5d(2) preserves them explicitly
- Other (non-Article-215) restrictive-measure compliance — retained
- The SCT Inst scheme rulebook itself (EPC) — operates alongside, recalibrated by EPC for VoP via SPAA
- The single-euro-payments-area (SEPA) substantive architecture — only specific definitions and the Articles 5a–5d block are added

---

## IPR vs. PSD3 / PSR — How They Relate

The PSD3 + PSR package (provisional political agreement reached Q4 2025, expected OJ publication Q1–Q2 2026, 21-month transition → applicability late 2027 / early 2028) is **downstream** of the IPR. The IPR was drafted as a self-contained amending act *because* the PSD3 timeline was already long; recital 16 explicitly anticipates the PSD3 review of the Article 3 IPR amendments to PSD2. Practical implication:

- IPR obligations are live now (or coming live by 2027) — do **not** defer compliance pending PSD3
- PSD3 will re-shape parts of the same architecture (especially safeguarding under PSD2 Article 10, indirect access under Article 35) — anticipate a second round of redrafting of the safeguarding policy and system-access agreements 2027–2028
- The PSD3 fraud-liability shift (PSPs fully liable for fraud losses if prevention was inadequate) interacts with the IPR Article 5c VoP liability rule — expect the combined liability surface to be the operational driver for fraud-prevention investment 2025–2028

---

## Common Compliance Gaps (FinTech / Payments)

1. **Account-reachability gaps** — at least one credit-transfer-reachable account category still not SCT-Inst-reachable on deadline
2. **10-second budget overruns** — internal hops (fraud, AML real-time checks, FX, core-banking) cumulatively exceed the available share of the 10-second end-to-end ceiling under load
3. **Channel parity gap** — branch / ATM / batch channels lag mobile / web on SCT Inst readiness
4. **SCT Inst priced above SCT** — current commercial model breaks Article 5b(1)
5. **VoP treated as phase 2** — VoP deadline equals send-SCT-Inst deadline, not later
6. **Per-transaction sanctions screening retained on SCT Inst rail** — direct breach of Article 5d(2)
7. **No daily full-base PSU re-screen capability** — direct breach of Article 5d(1), maximum penalty 10% of consolidated turnover
8. **PI / EMI participation plan assumes pre-IPR access regime** — Article 35a artefacts (safeguarding description, governance description, winding-up plan) missing
9. **No PSU advance-notice mechanism for planned downtime** — loses the Article 11(1c) penalty carve-out
10. **VoP logging insufficient to evidence per-transaction performance** — loses the Article 5c(8) liability shield

---

## InnBlockchain Relevance

**For FinTech ICP — PayTech segment (primary):**
- IPR is the *defining* regulatory build of 2025–2027 for any PI/EMI offering euro rails. The Section 7 Article 35a artefacts (safeguarding description, governance + ICT controls description, winding-up plan) are deliverable-shaped — natural fit for an InnBlockchain "PSP authorisation companion" service line, especially the **DORA-cross-referenced ICT arrangements description** (PSD2 Article 35a(1)(b) explicitly cross-references DORA Articles 6 and 7).
- VoP build is the highest-engineering-intensity workstream — opportunity for InnBlockchain to package a VoP-architecture + EPC SPAA integration + logging-for-Article-5c(8)-liability-shield audit deliverable.
- Article 5d daily-screening rebuild is a discrete project — list-ingestion pipeline + full-base re-screen + immediate-freeze trigger; opportunity to bundle with [[EU-AML-AMLA]] sanctions architecture work.

**For FinTech ICP — BankTech / WealthTech / LendTech (secondary):**
- These segments are likely already covered by their underlying credit-institution authorisation but inherit the IPR build inside the bank. Less direct InnBlockchain wedge unless the bank carves out a PI/EMI subsidiary for instant rails.

**For Crypto Native ICP — segments that hold or rely on PSD2 status:**
- Segments operating fiat on/off-ramps via a partner PSP — partner is in IPR scope; CASP is not. Worth reviewing partner-PSP contracts for downstream cost / liability pass-through.
- Segments holding their own EMI / PI licence (rare) — full IPR scope applies on the fiat leg; **not** on the token leg.

**For Channel Partner ICP:**
- IPR + DORA + AMLR is the EU-payments-compliance triangle for any prospect introduction in 2026–2027. The same partner intake conversation can route to all three.

---

## Key Regulators

- **National Competent Authorities** — home-Member-State supervision; transposition of IPR Article 3 (PSD2 amendments) and Article 4 (SFD amendments) by 9 April 2025; enforce Article 11 penalties
- **European Central Bank** — designated payment system oversight; SSM-significant credit institutions DORA + prudential supervision continues to run through the ECB
- **European Banking Authority (EBA)** — implementing technical standards on Article 15 reporting templates (draft due 9 June 2024); ongoing operational guidance
- **European Payments Council (EPC)** — SCT Inst scheme rulebook + SEPA Payment Account Verification (SPAA) for VoP industry-wide standards (recital 23)
- **European Commission** — Article 15(2) review report due 9 October 2028; Article 15(6) obstacles report due 9 April 2027

---

## Sources

- Regulation (EU) 2024/886 — full text: https://eur-lex.europa.eu/eli/reg/2024/886/oj — verification artefact `IPR.html` (187KB local copy) in `.raw/InnBlockchain/EU Compliance/`
- Companion practitioner checklist: `.raw/InnBlockchain/EU Compliance/ipr-checklist.md`
- Cross-regulatory context: [[EU-PSD3-IPR-FiDA-AIAct-2026]] (April 2026 external research source)
