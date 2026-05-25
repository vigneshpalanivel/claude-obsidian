---
type: concept
title: "MiFIR — Operational Mechanics (Practitioner Detail)"
created: 2026-05-25
updated: 2026-05-25
tags:
  - MiFIR
  - MiFID-II
  - MiFID-III
  - EU
  - investment-firm
  - trading-venue
  - transparency
  - transaction-reporting
  - DTO
  - SI
  - practitioner
  - regulation
status: current
related:
  - "[[MiFID-II]]"
  - "[[MiFID-II-NCA-Authorization-Mechanics]]"
  - "[[MiFID-III]]"
  - "[[EU-Listing-Act]]"
  - "[[Prospectus-Regulation]]"
  - "[[MAR-Regulation]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[DORA-Regulation]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[ERC-3643]]"
  - "[[ERC-1400]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# MiFIR — Operational Mechanics (Practitioner Detail)

The article-level market-conduct, transparency, and transaction-reporting requirements that an EU market-structure specialist walks an operating firm through. Sourced from `.raw/InnBlockchain/EU Compliance/mifir-checklist.md` and Regulation (EU) No 600/2014 as amended by Regulation (EU) 2024/791 ("MiFIR Review", in force 28 March 2024).

> [!info] When to read this page
> Read this when you're scoping or operating an EU trading venue (RM / MTF / OTF / DLT MTF), a systematic internaliser, or any MiFID-authorised investment firm that needs to wire up transparency, transaction reporting, the derivatives trading obligation, or the third-country equivalence regime. For the *who can be authorised* question, start at [[MiFID-II]] / [[MiFID-II-NCA-Authorization-Mechanics]]. For the DLT-specific infrastructure path, see [[DLT-Pilot-Regime]].

## How MiFIR Pairs With MiFID II

| Instrument | Form | Governs |
|---|---|---|
| MiFID II (Dir 2014/65/EU) | Directive — national transposition | Authorisation, conduct-of-business toward **clients**, fit-and-proper, organisational requirements |
| MiFIR (Reg (EU) 600/2014) | Regulation — directly applicable | What happens on the **market** — pre/post-trade transparency, transaction reporting, DTO, non-discriminatory access, third-country equivalence |

Single rulebook, two instruments. Enforcement data 2018-present: the largest monetary penalties cluster on the MiFIR side (Article 26 reporting, SI mis-classification, DTO breaches), not the MiFID II side. Authorisation gets the firm in the door; MiFIR machinery is what fails operationally and triggers fines.

References: MiFIR Article 1 (subject matter); MiFID II Article 1; [[MiFID-III]] for the 2024 review package.

## 2024 MiFIR Review — End-State Calibration

Reg (EU) 2024/791 in force **28 March 2024**. Plan to end-state, not legacy text:

| Date | Change |
|---|---|
| 28 March 2024 | Regulation in force; most amendments effective subject to RTS/ITS revisions |
| By 29 Sept 2025 | ESMA active monitoring; CTP tender process; **SI opt-in regime live** |
| March 2026 | Revised pre/post-trade transparency thresholds + deferral regime in force |
| April 2026 | Expanded Article 26 transaction-reporting + reference-data fields go live |
| **June 2026** | **PFOF ban (Article 39a) applicable + EU Consolidated Tape operational** (equities + bonds first) |

**Material 2024 changes:**
- **PFOF prohibition** (Article 39a) — investment firms cannot accept fee/commission/non-monetary benefit from third parties for forwarding retail / elective-professional client orders. Revenue-model deal-breaker if PFOF-dependent.
- **SI regime opt-in** — legacy quantitative threshold designation **removed**. Firms now opt in or out per asset class and notify NCA. Counterparties read ESMA's SI register, not internal threshold calculations.
- **Equity volume cap simplified** — Double Volume Cap (4% per venue / 8% EU-wide) replaced by **single 7% EU-wide cap** under reference-price + negotiated-trade waivers (Article 5).
- **Share trading obligation narrowed** — former Article 23 extraterritoriality removed; share TO now applies only where instrument has a liquid market in the EU.
- **Non-equity transparency simplified** — SSTI architecture collapsed; new five-bucket deferral regime (very-large / large / small-size / illiquid / sovereign).
- **CTP centralisation at ESMA** — single Consolidated Tape Provider per asset class selected by ESMA tender (not NCA-level).

References: Regulation (EU) 2024/791; [[MiFID-III]].

## Title II — Pre/Post-Trade Transparency (Articles 3–13)

Splits by instrument class:

| Chapter | Articles | Scope |
|---|---|---|
| Ch 1 — Equity | 3–7 | Shares, depositary receipts, ETFs, certificates, similar |
| Ch 2 — Non-equity | 8–11 | Bonds, structured finance, emission allowances, derivatives |
| Ch 3 — Reasonable commercial basis | 12–13 | Data licensing — pre/post separately, free-of-charge 15 min after publication |

**Pre-trade waivers (equity — Art 4):** reference price · negotiated trade · large-in-scale (LIS) · order management facility (OMF / iceberg). NCA approval per waiver; ESMA opinion within 2 months under Art 4(4).

**Pre-trade waivers (non-equity — Art 9):** LIS · above-SSTI on RFQ/voice · illiquid instrument · package transactions.

**Volume cap (Art 5, post-2024):** single 7% EU-wide cap on instruments traded under reference-price + negotiated-trade waivers over 12 months. Legacy 4%/8% double cap and per-venue sub-cap **gone** — update dark-pool routing logic accordingly.

**Post-trade publication (Art 6 equity, Art 10 non-equity):** "as close to real-time as is technically possible." Trade flags per RTS 1 / RTS 2 (benchmark / negotiated / portfolio / LIS / deferred / cancelled).

**Deferrals (Art 7 equity, Art 11 non-equity):** NCA-authorised; post-2024 non-equity deferral regime collapsed to five buckets — wire into trade-flagging + APA submission logic.

**RCB data licensing (Art 12-13):** pre-trade and post-trade data **separately** (no bundle-only); cost-plus-reasonable-margin per Reg (EU) 2017/567; 15-minute free-of-charge delayed feed; per-user/per-display licensing (not enterprise-only); non-discriminatory across client categories.

References: MiFIR Arts 3–13; RTS 1 (Reg (EU) 2017/587 — equity); RTS 2 (Reg (EU) 2017/583 — non-equity); RCB Reg (EU) 2017/567.

## Title III — SI Regime + OTC Trading (Articles 14–23)

**SI status decision (post-2024):** deliberate opt-in/opt-out per asset class. Notification to home NCA. Public ESMA SI register is the counterparty source-of-truth.

**Equity SI quoting (Arts 14-17):** firm quotes in liquid instruments published continuously during normal trading hours; quote size up to standard market size (SMS); non-discriminatory access to quotes; commercial policy on client access documented with objective criteria; price improvement permitted for professional clients in justified cases (Art 15(2)).

**Non-equity SI quoting (Art 18):** firm quotes on request for liquid instruments above RTS 2 thresholds, with size-specific calibration.

**OTC post-trade publication via APA:**
- Equity OTC trades — Art 20
- Non-equity OTC trades — Art 21
- Designated reporting party rules per RTS 1 / RTS 2 (post-2024: tightened "seller reports" default for non-equity)
- Failover APA contracted; trade-to-APA latency benchmarked monthly

References: MiFIR Arts 14–23 (as amended by Reg 2024/791).

## Title IV — Transaction Reporting (Articles 24–27)

The largest operational obligation in the MiFIR stack. T+1, 65+ fields, every reportable transaction.

**Scope (Art 26):** all transactions in financial instruments admitted to trading or traded on a trading venue, including OTC where the underlying is on-venue. Both counterparties report independently.

**Reporting timing:** T+1 close of business the working day after execution.

**Reporting channels:** ARM (Approved Reporting Mechanism) is the standard; direct-to-NCA where accepted; trading-venue-on-behalf is an option but **legal responsibility stays with the firm**.

**Field population (RTS 22 — Reg (EU) 2017/590):**
- **LEI for every legal-person counterparty** — "no LEI, no trade" since 3 Jan 2018
- **NCI (National Client Identifier) for every natural-person counterparty** — CONCAT-format per home jurisdiction
- Trader ID + decision-maker ID (algorithm ID where applicable)
- ISIN, price, quantity, currency, MIC, trading capacity (principal / agency / matched principal)
- Waiver / deferral / OTC flags
- Short selling flag (SSR Reg (EU) 236/2012)
- Commodity-derivative indicator

**April 2026 expansion:** new fields for algorithm identification, OTC interest-rate derivatives, post-trade transparency cross-references. Mapping + testing required.

**Reference data reporting (Art 27):** daily instrument reference data to NCA via FIRDS for every instrument admitted to trading or traded. New-instrument onboarding must populate FIRDS **at admission**, not after first trade. Corporate actions propagated promptly.

> [!warning] Highest enforcement exposure in MiFIR
> Article 26 / 27 failures are the single largest source of EU MiFID monetary penalties since 2018 (FCA £27.6m 2019, FCA £26m 2017, BaFin €6m 2022). Root cause is consistently the same: internal data taxonomy doesn't match RTS 22 field definitions, and reconciliation is too weak to detect divergence. Treat as a Tier-1 engineering + compliance problem from day one.

**Quality control baseline:** daily completeness/accuracy/timeliness dashboards · quarterly internal sample audit vs trade-blotter source-of-truth · annual external assurance review · reconciliation against NCA "reasonableness reports" (FCA / BaFin / CSSF issue quarterly).

References: MiFIR Arts 24–27; RTS 22 (Reg (EU) 2017/590); RTS 23 (Reg (EU) 2017/585); ESMA FIRDS / FITRS.

## Title V — Derivatives (Articles 28–34)

Interfaces with [[EMIR]] (Reg (EU) 648/2012) Article 5 clearing obligation. DTO catches only CCP-cleared, sufficiently liquid derivative classes.

**Derivatives Trading Obligation (DTO — Art 28):**
- In-scope classes published in **ESMA DTO public register** (Art 34) — currently specified IRS classes (EUR / USD / GBP fixed-to-floating swaps in benchmark tenors) + certain index CDS
- Execute on RM / MTF / OTF / third-country venue with positive Art 28(4) equivalence decision
- Applies to financial counterparties (FC) + non-financial counterparties above EMIR clearing threshold (NFC+); intra-group + pension-scheme exemptions per EMIR
- Pre-execution venue-eligibility check automated in OMS/EMS
- Off-venue exceptions (post-trade risk-reduction, package transactions per RTS) logged and reviewed

**Acceptance for clearing (Art 29(2)):** venues / CCPs accept trades "as quickly as technologically practicable" — measured in seconds, not minutes.

**Indirect clearing (Art 30):** written terms, segregation, leapfrog provisions, default-management per RTS.

**Portfolio compression (Art 31):** controls ensure cycles reduce non-market risk without altering market risk; pre/post-compression records kept per Art 31(3).

References: MiFIR Arts 28–34; EMIR Art 5; ESMA DTO Public Register.

## Title VI — Non-Discriminatory Clearing & Access (Articles 35–38)

Prevents vertically integrated trading-clearing silos from blocking competition.

| Article | Direction | Obligation |
|---|---|---|
| 35 | Trading venue → CCP | CCP offers non-discriminatory access to venues that request it; 3-month response window per RTS 15 (Reg 2017/581) |
| 36 | CCP → Trading venue | Venue offers non-discriminatory access to feeds, trade reports, reference data to CCPs |
| 37 | Benchmark administrator | Non-discriminatory FRAND-style licence to CCPs + venues; BMR (Reg (EU) 2016/1011) compliance baseline |
| 38 | Third-country CCPs/venues | Equivalence + ESMA recognition status tracked |

## Title VII — Product Intervention + Position Limits (Articles 39–45)

**Product intervention (Arts 39-43):** monitor ESMA / EBA / NCA intervention registers — historical examples include retail CFD leverage caps, binary options ban (made permanent), crypto-CFD restrictions. Cascade restrictions through product governance (MiFID II Art 16(3)) to tied agents + distributors. Marketing review ensures no promotion of intervention-restricted products.

**Position management (Arts 44-45):** position limits per MiFID II Art 57 mapped per commodity / emission-allowance class; position reporting per Art 58 to venue + home NCA; ancillary-activity exemption (MiFID II Art 2(1)(j)) reassessed annually; ESMA position-management directions monitored (Art 45 lets ESMA require position reduction or elimination).

## Title VIII — Third-Country Firms (Articles 46–49)

Equivalence-based cross-border provision **to per-se professionals + eligible counterparties only**. Retail + elective-professional EU clients still require MiFID II Art 39 branch authorisation.

- **Commission equivalence decision (Art 47)** in force for the home jurisdiction
- **ESMA registration (Art 46)** filed + granted before any service offered
- **Cooperation arrangement** ESMA ↔ home supervisor in place
- **Disclosure to EU clients** — services provided under Art 46 regime; disputes resolved in third-country jurisdiction
- **Article 49 withdrawal risk** — robust ongoing compliance with equivalent home regime + current ESMA reporting

> [!warning] Reverse solicitation is narrow
> Art 46–47 equivalence is narrow + slow. ESMA's 13 January 2021 public statement materially tightened reverse solicitation; do not design a third-country crypto-to-RWA distribution model around it without specific legal opinion.

## Title V of MiFID II — DRSPs Under MiFIR (APA / ARM / CTP)

| Provider | Authorisation route | MiFIR role |
|---|---|---|
| **APA** (Approved Publication Arrangement) | NCA (MiFID II Arts 59–65) | Publishes post-trade reports under MiFIR Arts 20-21 |
| **ARM** (Approved Reporting Mechanism) | NCA (MiFID II Arts 59–65) | Submits Art 26 transaction reports on behalf of firms |
| **CTP** (Consolidated Tape Provider) | **ESMA (post-2024)** — competitive tender per asset class | Aggregates EU-wide tape; equities + bonds tape live June 2026 |

**June 2026 consolidated tape:** mandatory contribution by trading venues, APAs, and (non-equity) SIs once operational. Revenue-sharing per 2024-review model. Internal use of the tape for best-execution monitoring (MiFID II Art 27) and price-discovery.

## DLT MTF / DLT TSS — MiFIR Interaction

Tokenisation does **not** avoid MiFIR. A tokenised transferable security is a financial instrument; trades are reportable; venues are subject to Title II transparency. [[DLT-Pilot-Regime]] (Reg (EU) 2022/858) grants limited + conditional exemptions only — with compensatory measures.

**Smart-contract → MiFIR event mapping:**
- `OrderCreated` / `OrderModified` / `OrderCancelled` events consumable by APA at RTS 1 / RTS 2 field granularity
- `Trade` event carries all RTS 22 fields (instrument ID / price / quantity / counterparties / capacity / timestamp)
- LEI + NCI registry on-chain — counterparty wallets bound to identifiers **before** trade execution; "no identity, no trade" enforced at contract level
- Block-time vs "as close to real-time as technically possible" — L1 / L2 chain selection justified against transparency latency expectations
- Atomic settlement implications — Art 29(2) acceptance-for-clearing logic adapted where DLT TSS handles both trading + settlement

**DLT Pilot exemptions documented + NCA-approved with compensatory measures** for each disapplication (intermediation requirement, modified settlement timeline, retail-investor access caps). Issuance caps (Pilot Art 3) monitored in real time. Transition plan ready for Pilot sunset or growth beyond Pilot caps.

References: [[DLT-Pilot-Regime]]; MiFIR Arts 3-13, 20-21, 26-27; MiFID II Art 27 (best execution).

## InnBlockchain Engagement Mapping (MiFIR Side)

**Architecture:** event-schema design → on-chain `Order` / `Trade` / `Cancel` events mapped 1:1 to RTS 1 / RTS 2 / RTS 22 → APA / ARM bridge specification → LEI- and NCI-bound permissioned-token modules.

**Build:** [[ERC-3643]] / [[ERC-1400]] permissioned tokens enforcing identity at transfer → order-management modules calibrated to pre/post-trade transparency → settlement modules calibrated to Art 29(2) "as quickly as technologically practicable" → DLT MTF / TSS reference-data feed to FIRDS.

**Audit:** independent smart-contract security audit → MiFIR-field-coverage audit (every reportable field traceable to an on-chain event) → NCA-readable audit report mapping every contract function to the MiFIR / RTS provision it satisfies.

**Companion pages:**
- [[MiFID-II]] — strategic framing, token classification cascade
- [[MiFID-II-NCA-Authorization-Mechanics]] — capital math, dossier, authorisation timeline
- [[MiFID-III]] — 2024 review package
- [[DLT-Pilot-Regime]] — DLT MTF / DLT SS / DLT TSS infrastructure path
- [[EU-Fintech-Compliance-Landscape]] — full EU stack
- [[InnBlockchain FinTech ICP]] — buyer routing
