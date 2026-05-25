---
type: concept
title: "MiFID II — NCA Authorization Mechanics (Practitioner Detail)"
created: 2026-05-24
updated: 2026-05-24
tags:
  - MiFID-II
  - MiFID-III
  - EU
  - investment-firm
  - compliance
  - regulation
  - practitioner
  - NCA
  - authorization
  - IFR-IFD
status: current
related:
  - "[[MiFID-II]]"
  - "[[MiFID-III]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[DORA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[MiCA-NCA-Authorization-Mechanics]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[ERC-3643]]"
  - "[[ERC-1400]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# MiFID II — NCA Authorization Mechanics (Practitioner Detail)

The article-level requirements an EU financial-services specialist walks a founder through at first intake. Companion to [[MiFID-II]] (which holds the strategic/positioning framing). Sourced from `.raw/InnBlockchain/EU Compliance/mifid2-checklist.md` and Directive 2014/65/EU + IFR/IFD (2019/2033, 2019/2034) + MiFIR amendments via Regulation (EU) 2024/791.

> [!info] When to read this page
> Read this when you're scoping or executing an investment-firm authorization (or a DLT MTF / DLT SS / DLT TSS application) — capital math, dossier contents, application timeline, mandatory policies. For the *whether MiFID II applies / token classification cascade / ICP routing* question, start at [[MiFID-II]]. For the MiCA-side equivalent, see [[MiCA-NCA-Authorization-Mechanics]].

## Authorization Scope: Services × Instruments × Venue

MiFID II authorization is service-scoped. The combination of **Annex I Section A services**, **Annex I Section C instruments**, and **venue classification** determines capital class, dossier scope, and ongoing obligations. Get scope wrong at filing and a full variation procedure is required later.

**Investment services (Annex I Section A):**
A1 reception/transmission of orders · A2 execution of orders · A3 dealing on own account · A4 portfolio management · A5 investment advice · A6 underwriting / placing on firm commitment · A7 placing without firm commitment · A8 operation of an MTF · A9 operation of an OTF.

**Ancillary services (Section B)** — only available alongside a Section A authorization: B1 safekeeping/custody · B2 margin lending · B3 corporate-finance advice · B4 FX connected to investment services · B5 investment research · B6 underwriting-related services.

**Financial instruments (Section C, 1–11)** — transferable securities (C1), money-market instruments (C2), UCITS / AIF units (C3), derivatives on securities/currencies/rates (C4), commodity derivatives (C5–C7), credit derivatives (C8), CFDs (C9), exotic/inflation/freight derivatives (C10), EU ETS emission allowances (C11).

**Venue type — material distinction for tokenized-securities firms:**

| Venue | Discretion | Equity? | Matched principal? | Dealing on own account? |
|---|---|---|---|---|
| MTF | Non-discretionary | Equity + non-equity | **Prohibited** | Prohibited |
| OTF | Discretionary | **Non-equity only** | Permitted with client consent (not for cleared derivatives) | Sovereign debt with no liquid market only |
| SI (Systematic Internaliser) | n/a — bilateral | Equity + non-equity | n/a | Yes, that's the whole point |
| DLT MTF / DLT SS / DLT TSS | Per DLT Pilot Regime grant | Per Pilot Regime permission | Per Pilot Regime | Per Pilot Regime |

OTFs cannot share a legal entity with an SI (Art 20(4)). MTFs and OTFs require ≥3 materially active members (Art 18(7)). [[DLT-Pilot-Regime]] is the dedicated infrastructure path for tokenized securities — not MiCA's CASP regime.

References: MiFID II Articles 4 (definitions), 18–20 (MTF/OTF), Annex I A–C; MiFIR Articles 14–23 (SI quoting); DLT Pilot Regime Regulation (EU) 2022/858.

## Initial Capital (IFD Article 9 — supersedes original MiFID II Art 15)

Since **26 June 2021**, prudential capital for investment firms is set by **IFD/IFR** (Directive (EU) 2019/2034 + Regulation (EU) 2019/2033), not MiFID II Article 15 directly. Article 15's cross-reference to CRR is now read into the IFR/IFD regime for all firms below Class 1 reclassification.

| Tier | Services | Client money/securities held? | Initial Capital |
|---|---|---|---|
| **€75,000** | A1, A2, A4, A5, A7 (any combination) | **No** | **€75,000** *(IFD Art 9(2))* |
| **€150,000** | A1, A2, A4, A5, A7 (any combination) | **Yes** — including any firm offering B1 custody | **€150,000** *(IFD Art 9(3))* |
| **€750,000** | A3, A6, A8, or A9 | n/a | **€750,000** *(IFD Art 9(1))* |

> [!warning] Common error
> A7 (placing **without** firm commitment) is **not** in the €750k bracket. Only **A6 firm-commitment** placing triggers €750k for placing-type activities. A5 advice alone never triggers €150k or €750k. The €150k step-up is triggered by *holding client money/securities*; the €750k step-up is triggered by *dealing on own account, firm-commitment underwriting, or operating a multilateral venue*.

**Class 1 reclassification:** Investment firms dealing on own account or underwriting on a firm-commitment basis with total consolidated assets > **€30 billion** are reclassified as credit institutions and must seek CRD/CRR authorization (Regulation (EU) 575/2013) — directly supervised by the ECB under the SSM. Plan for this if the business plan crosses the threshold within the authorization horizon.

**Ongoing own funds (IFR Art 11) = highest of:**
- The IFD Art 9 initial capital tier above (permanent minimum)
- **Fixed overhead requirement (FOR)** — one quarter of preceding year's fixed overheads
- **K-factor requirement** — sum of RtC + RtM + RtF K-factors specific to the firm's activities (IFR Arts 15–34)

**Liquidity (IFR Art 43):** liquid assets ≥ one third of the fixed overhead requirement at all times.

**Class 3 (small and non-interconnected) — IFR Art 12(1):** AUM < €1.2bn, client orders < €100m/day (cash) or < €1bn/day (derivatives), no permission to hold client money/securities, and the other Art 12 thresholds met. Simplified regime: own funds = higher of permanent minimum and FOR (no K-factor calculation); simplified liquidity and reporting.

References: MiFID II Article 15; IFR (Reg (EU) 2019/2033) Articles 11, 12, 15–34, 43; IFD (Dir (EU) 2019/2034) Articles 9, 24 (ICAAP/ILAAP), 36 (SREP).

## Entity & Governance Requirements

- EU legal entity (GmbH / SAS / BV / OÜ / equivalent) — natural-person carve-outs are narrow and national-law-specific
- **Registered office AND head office in the same Member State** *(Article 5(4))* — brass-plate / split-jurisdiction structures fail authorization
- Home Member State identified (becomes home NCA + source of EU passport)
- **At least two natural persons effectively directing the business** — the "four-eyes" rule, mandatory regardless of firm size
- Management body members (Art 9) pass fit-and-proper:
  - Sufficient knowledge, skills, experience (individually + collectively)
  - Good repute — no convictions for financial crime, fraud, ML/TF
  - Sufficient time commitment (directorship-limit rules in Art 9(2) for significant firms)
  - No conflicts impairing independent judgment
  - Diversity policy for significant firms (Art 9(1))
- **Qualifying shareholders (≥10% capital or voting rights)** — Article 10 suitability review: criminal history, financial soundness, source of funds
- Nomination / risk / remuneration committees required where firm is significant (Art 9(2))
- CVs + professional references + background documentation prepared for NCA independent verification (criminal-record consultation expected)

References: MiFID II Articles 5 (authorization), 5(4) (head-office co-location), 9 (management body), 10 (qualifying holdings), 11 (notification of acquisitions), 13 (risk-management committees).

## Pre-Contractual Disclosures — No Single "White Paper"

Unlike MiCA, MiFID II does **not** require a single offering document. Disclosures are layered across MiFID II Articles 24–25, the Prospectus Regulation, the PRIIPs KID, and (post-admission) MAR. Build the disclosure stack, not one document.

### Client Categorization (Annex II)

Categorization drives the entire conduct-of-business regime applied:

- **Retail clients** — highest protection; suitability + appropriateness; PRIIPs KID applies
- **Professional per se** (Annex II Section I) — credit institutions, investment firms, insurers, funds, large undertakings meeting 2 of: balance sheet ≥ €20m / turnover ≥ €40m / own funds ≥ €2m; governments; central banks; supranationals
- **Professional on request** (Annex II Section II) — written opt-up, NCA-prescribed warning, 2 of 3 criteria: 10+ transactions / quarter for 4 quarters, portfolio > €500k, ≥ 1 year financial-sector professional experience
- **Eligible counterparties** (Article 30) — narrowest scope; mainly regulated-entity-to-regulated-entity dealings

Opt-up and opt-down procedures must be documented in writing; periodic re-categorization scheduled.

### Article 24 — Pre-Trade Disclosures

Provide in good time before each client is bound:
- Firm and service description (identity, regulatory status, languages, channels)
- Financial instrument description (nature, risks, target market, costs)
- **Costs and charges** ex-ante + ex-post — aggregated and itemised on request, in monetary AND percentage terms, including third-party payments + cumulative effect on return *(Art 24(4))*
- **Inducements** — third-party fees/commissions disclosed; must enhance service quality AND not impair best-interest duty *(Art 24(9))*
- **Investment advice — independence status** declared; independent advice **prohibits retention of inducements** *(Art 24(7))*
- **Portfolio management — inducement prohibition** *(Art 24(8))*

### Article 25 — Suitability & Appropriateness

- **Suitability (advice + portfolio management)**: knowledge/experience, financial situation including loss-bearing ability, objectives including risk tolerance — recommend only suitable instruments
- **Suitability report** to retail clients before transaction
- **Appropriateness (other services in complex instruments)**: knowledge/experience; warn if not appropriate or if insufficient info provided
- **Execution-only exception** — only non-complex instruments, client-initiated, with warning that no appropriateness assessment was performed *(Art 25(4))*
- **Knowledge and competence** of staff giving advice/information — demonstrable per ESMA Guidelines

### Article 16(3) — Product Governance

If you manufacture or distribute financial instruments:
- Target market identification (positive AND **negative** target market)
- Product approval process before launch + significant adaptations
- Regular product review against target market
- Manufacturer-to-distributor information flow

### Parallel Disclosure Regimes (do not skip)

- **Prospectus** (Reg (EU) 2017/1129) — required for public offers of transferable securities; exemptions: < €1m/12mo EU-wide, < 150 persons per Member State, qualified-investors-only, denominations ≥ €100k. Member States can elect to apply national rules between €1m and €8m.
- **PRIIPs KID** (Reg (EU) 1286/2014) — 3-page Key Information Document for packaged retail investment products
- **UCITS KIID / KID** — for UCITS distributed to retail
- **MAR ad-hoc disclosure** (Reg (EU) 596/2014) — inside-information disclosure once instruments admitted to trading

> [!info] Tokenized-bond disclosure stack (practical example)
> A tokenized bond to EU retail typically needs: a **Prospectus** (or exemption), a **PRIIPs KID** if classified as PRIIP, **MiFID II Art 24 costs/charges + Art 25 suitability** disclosures at point of sale, and ongoing **MAR** disclosure post-admission. The MiFID II "white paper equivalent" is the prospectus, not a marketing document. Plan 2–4 months of disclosure-pack work with specialist counsel.

References: MiFID II Articles 16(3), 23, 24, 25, 30, Annex II; Prospectus Regulation (EU) 2017/1129; PRIIPs Regulation (EU) 1286/2014; MAR Regulation (EU) 596/2014.

## Operational & Organizational Requirements (Article 16)

Required in the dossier and continuously thereafter:

- **Business plan** — 3-year, services, target market, financial forecasts including K-factor + FOR projections
- **Three lines of defence** — business / risk + compliance / internal audit
- **Compliance function** (Art 16(2)) — independent, permanent access to all info, reports to management body
- **Risk-management function** — independent where proportionate; risk committee for significant firms
- **Internal audit function** — independent, direct reporting line to management body
- **Conflict of interest policy** (Art 23) — identify, prevent, manage, disclose; inducements register
- **Outsourcing policy** — critical-function oversight, audit rights, exit arrangements; cannot outsource senior-management responsibility (Art 16(5))
- **Personal account dealing policy** — restrictions for staff with inside-info access
- **Complaints handling** — formal process per ESMA / EBA Joint Committee guidelines
- **Marketing / communications policy** — fair, clear, not misleading (Art 24(3))
- **Record-keeping policy** — minimum **5-year retention**, extendable to **7 years** on NCA request

### Best Execution (Article 27)

- Written **Order Execution Policy** weighing price, costs, speed, likelihood of execution and settlement, size, nature — for retail clients, **total consideration** is the determining factor
- Execution-venue selection on objective criteria, documented rationale
- **Client consent to execution policy** before service begins; **express consent** required for execution outside trading venues
- **Order handling rules** (Art 28) — prompt, fair, expeditious; aggregation only where unlikely to disadvantage clients
- **Top-5 venue reporting (RTS 28)** — annual publication of top-five execution venues per asset class; *status under MiFID III review — confirm current requirement*
- Regular execution-quality monitoring; policy updated where material changes affect ability to obtain best result

### Algorithmic Trading & DEA (Article 17)

- Systems + risk controls ensuring resilience, capacity, trading thresholds, prevention of erroneous orders
- Notification to home NCA AND the venue
- HFT firms: store accurate, time-sequenced records of all placed orders, cancellations, executed orders, quotations
- Market-making strategy: binding written agreement with venue (Art 17(3))
- **Direct Electronic Access (DEA)**: client suitability assessment, pre-set trading + credit thresholds, monitoring, binding written agreement (Art 17(5))

### Client Asset Safeguarding (Article 16(8)–(10))

- Client assets segregated from firm's own at all times
- Custody arrangements + sub-custodian due diligence (Commission Delegated Directive (EU) 2017/593)
- Insolvency-remote
- No use of client financial instruments for own account without express consent (Art 16(8))
- No use of client funds for own account except credit institutions (Art 16(9))
- **Title-transfer collateral arrangements prohibited with retail clients** (Art 16(10))
- Client-fund placement at credit institution / central bank / qualifying MMF, with diversification
- Annual external audit report on client-asset arrangements to NCA (CASS-equivalent)

### Recording of Communications (Article 16(7))

- Telephone + electronic communications for orders / dealing on own account / RTO must be recorded
- Client notification once before services provided
- No service over un-notified telephone channels
- **5-year retention**, extendable to **7 years** on NCA request
- Reasonable steps to prevent staff from using untracked personal channels

References: MiFID II Articles 16, 17, 23, 27, 28; Commission Delegated Regulation (EU) 2017/565 (organisational + conduct); Commission Delegated Directive (EU) 2017/593 (client assets).

## ICT & DORA Integration (Article 16(5))

MiFID II Article 16(5) requires sound security mechanisms + internal controls + effective ICT risk procedures. **DORA (Regulation (EU) 2022/2554) became fully applicable on 17 January 2025** and is now the ICT-resilience standard for all MiFID-authorized investment firms — assessed by the NCA as part of MiFID II authorization. One regulatory process, not two.

Required:
- ICT risk management framework
- BCP for critical operations under disruption / attack / failure
- DRP with explicit RTO/RPO per critical system
- ICT incident detection, classification, NCA reporting (initial / intermediate / final per DORA timelines)
- **Digital operational resilience testing** — basic annually; **threat-led penetration testing (TLPT) every 3 years** for firms identified under DORA Art 26
- ICT third-party risk management — audit rights, sub-contracting controls, exit strategies (DORA Arts 28–30); register of all ICT third-party arrangements
- **CTPP awareness (DORA Art 31)** — which vendors may be designated Critical ICT Third-Party Providers (cloud, blockchain infra, oracle providers) and what that triggers
- GDPR (Reg (EU) 2016/679) — independent horizontal obligation, NCAs expect it in place

For DLT MTF / DLT SS operators: independent smart contract security audits with material findings remediated before deployment; on-chain identity registry; documented key-management + custody architecture.

> [!warning] Post-authorization DORA enforcement is independent
> The "one process" framing applies at MiFID II authorization. Once live, DORA has independent supervisory enforcement with penalties up to **2% of total annual turnover**. The checklist this page derives from is silent on post-authorization DORA inspections — do not use it as your only DORA reference once operating.

References: MiFID II Art 16(5); DORA Arts 5–16 (ICT risk), 17–23 (incident reporting), 24–27 (resilience testing), 28–44 (third-party risk).

## AML/CFT Integration

NCAs do not authorize without:
- Documented AML/CFT program (CDD, KYC, KYB, transaction monitoring, SAR procedures, sanctions screening, PEP screening)
- MLRO appointed (senior management, EU-based)
- AML risk assessment (customer / product / geographic / channel)
- 5-year record retention
- Source-of-funds / source-of-wealth verification for high-value / high-risk clients
- Staff training program documented + scheduled

**AMLA** (Reg (EU) 2024/1620, Frankfurt) begins exercising its powers from **1 July 2025** and commences **direct supervision of selected high-risk obliged entities from 1 January 2028** (selection process 2027). The AML rulebook (Reg (EU) 2024/1624 + Dir (EU) 2024/1640) tightens substantially from 2027. AML deficiencies remain the single most common reason for MiFID II authorization delays, refusals, and post-authorization enforcement.

> [!info] TFR / Travel Rule does NOT apply to pure MiFID II token transfers
> The Transfer of Funds Regulation (Reg (EU) 2023/1113) imposes the Travel Rule on **crypto-asset service providers**, not on MiFID II investment firms in respect of financial-instrument transactions. A tokenized-securities platform that is MiFID-authorized but does **not** also operate a CASP business does not trigger TFR for its MiFID-classified token transfers — they are not "crypto-asset transfers" under MiCA Art 3(5). Confirm with counsel before assuming TFR coverage.

References: AML Package (Reg (EU) 2024/1624, Dir (EU) 2024/1640, Reg (EU) 2024/1620 establishing AMLA); MiFID II Art 9(3); TFR Reg (EU) 2023/1113.

## Market Integrity (MAR + MiFIR)

### Market Abuse Regulation (Reg (EU) 596/2014)

- Insider dealing prohibition; **insider lists** in ESMA-prescribed format (permanent + event-based)
- Market manipulation prohibition (wash trading, spoofing, layering, marking the close, pump-and-dump, false-info dissemination)
- Inside-information disclosure ASAP; delayed disclosure procedures documented
- PDMR + closely-associated personal-dealing rules (closed periods, pre-clearance, post-trade disclosure)
- **STOR** — suspicious transaction/order reporting to NCA
- Trading-venue order-book surveillance covering insider dealing + manipulation + disorderly trading

### MiFIR Transparency + Reporting (Reg (EU) 600/2014)

- Pre-trade + post-trade transparency calibrated per instrument class (equity, equity-like, non-equity)
- **Transaction reporting (Art 26)** — **T+1** to NCA via ARM, **65+ data fields** per transaction (RTS 22); valid LEIs mandatory; single incorrect field = reporting breach
- Reference-data reporting (Art 27)
- SI pre-trade quoting where SI thresholds met

## Application Workflow & Timeline

| Step | Action | Typical Timeline |
|---|---|---|
| 1 | Engage specialist EU financial-services counsel | Week 0 |
| 2 | Complete readiness assessment, identify gaps | Weeks 1–2 |
| 3 | Select home Member State and NCA | Week 2 |
| 4 | Pre-application meeting with NCA (where offered) | Weeks 3–6 |
| 5 | Prepare application dossier (business plan, ICAAP / ILAAP, policies, capital evidence, F&P documentation) | Weeks 4–20 |
| 6 | Submit application | Week 20+ |
| 7 | NCA completeness check + substantive review (Q&A rounds; clock stops on information requests) | Statutory Art 7(3): **6 months** from complete application; 9–12 months in practice |
| 8 | Authorization granted / conditions / refusal | **6–12 months total** from submission |
| 9 | ESMA register listing — every authorization notified to ESMA (Art 5(3)) | Upon authorization |
| 10 | EU-wide passporting notification (services Art 34 / branch Art 35) | Post-authorization |

Active investment-firm NCAs with experience handling crypto / DLT applications: **AMF** (France), **BaFin** (Germany), **AFM** (Netherlands), **CBI** (Ireland), **CSSF** (Luxembourg), **Bank of Lithuania**. For DLT MTF / tokenized-securities, Luxembourg, Germany, and Spain currently lead on Pilot Regime engagement.

NCA pre-application engagement style varies: CSSF / CBI / AMF hold structured pre-application meetings; BaFin / AFM prefer dossier-arrives-complete.

## Application Dossier Contents (Minimum)

- Completed application form (NCA-specific)
- Business plan (3-year, detailed — services, target market, financial projections)
- Organizational chart + governance structure
- Fit-and-proper documentation (all directors, senior managers, qualifying shareholders — CVs, criminal records, financial-soundness evidence)
- Proof of initial capital paid in (bank statement / audited accounts)
- **ICAAP** (Internal Capital Adequacy Assessment Process) — IFD Art 24, non-Class 3 firms
- **ILAAP** (Internal Liquidity Adequacy Assessment Process) — IFD Art 24
- AML/CFT compliance program
- ICT risk management framework + DORA compliance documentation
- BCP + DRP
- Conflict of interest policy + inducements register
- Complaints handling procedures
- Client asset safeguarding policy + CASS-equivalent procedures (if applicable)
- Order execution policy + best-execution monitoring framework (if applicable)
- Outsourcing arrangements + exit plans
- Insurance / equivalent guarantee documentation (where required)
- Marketing + communications policy
- Algorithmic-trading description + risk controls (if applicable)
- **Wind-down plan** — orderly cessation + return of client assets
- For DLT MTF / DLT SS / DLT TSS: separate **DLT Pilot Regime application** — specific permissions, compensatory measures, transition arrangements

## Post-Authorization Obligations

- **Art 21 ongoing review** — comply with initial authorization conditions at all times; notify NCA of material changes
- Annual/periodic regulatory reporting (own funds, FOR, K-factors, large exposures, liquidity) per IFR/IFD
- **MiFIR Art 26 transaction reporting** — T+1, via ARM
- ICAAP / ILAAP annual update + submission
- **SREP** (Supervisory Review and Evaluation Process) — typically annual for larger firms, biennial/triennial for smaller (IFD Art 36)
- DORA incident reporting on initial / intermediate / final basis
- AML annual reporting / typology updates to NCA / FIU
- Audited financial statements filed annually
- Material change notifications (new qualifying shareholders, new directors, new business lines, material outsourcing — prior notification or approval)

**Passporting (Arts 34–35):**
- Art 34 freedom-to-provide-services notification — home NCA notifies host; services may begin once filed
- Art 35 branch establishment — host NCA has 2 months to prepare; branch operates thereafter
- Tied-agent passporting — separate notification regime
- Host Member State conduct rules apply to services in host territory (Art 35(8))

## MiFID III Review — Phased Rollout 2025–2026

The **MiFID/MiFIR review package** (Directive (EU) 2024/790 + Regulation (EU) 2024/791) entered into force **28 March 2024**. New entrants should plan for the end-state, not the legacy regime. See [[MiFID-III]] for the full picture.

| Date | Milestone |
|---|---|
| 28 March 2024 | Package enters into force |
| September 2025 | ESMA active monitoring begins (conduct, transparency, CTP preparation) |
| March 2026 | Pre/post-trade transparency calibration revised |
| April 2026 | MiFIR Art 26 expanded transaction reporting fields |
| **30 June 2026** | **PFOF ban (MiFIR Art 39a) + EU consolidated tape live** |

**Practical impact for new applicants filing in 2026:**
- **PFOF business model = deal-breaker.** Prohibited from June 2026 (MiFIR Art 39a). If revenue model relies on PFOF, stop and rebuild.
- Trading venues / APAs / SIs must integrate with the EU consolidated tape provider (CTP)
- **RTS 27 has been repealed; RTS 28 publication status under review** — confirm current best-execution reporting requirement with counsel
- Equity transparency: volume-cap mechanism simplified to single 7% cap; reference-price + negotiated-trade waivers recalibrated
- Non-equity transparency: bond + derivative pre-trade transparency recalibrated; SSTI regime simplified
- **SI regime**: quantitative-threshold-based designation replaced by **opt-in** regime; quoting obligations recalibrated

## InnBlockchain Service Mapping

Every Article reference here is potentially a contract function, audit item, or compliance artifact InnBlockchain can deliver:

| MiFID II / Pilot Regime Requirement | InnBlockchain Deliverable |
|---|---|
| Token classification (Annex I Section C, Art 4(1)(15)) | MiFID-vs-MiCA boundary opinion; instrument-level legal-opinion support; token-architecture-to-Section-C mapping |
| Article 16(3) product governance | Target-market metadata baked into token contract; positive + negative target market enforcement at transfer level |
| Article 16(7) communications recording | Event-schema design for on-chain order capture + off-chain communications retention pipeline |
| Article 16(8)–(10) client asset safeguarding | Segregated-wallet architecture, ERC-3643 / ERC-1400 holder-registry isolation, insolvency-remote custody design |
| Article 24 costs and charges | On-chain fee-disclosure schema (gas, settlement, custody, transfer) at point-of-trade |
| Article 25 suitability | KYC-bound transfer restrictions enforced in contract `canTransfer()` per investor classification |
| Article 27 best execution | Smart-order-routing logic transparent + auditable; execution-quality event capture |
| Article 17 algorithmic trading + DEA | Kill-switch design, pre-trade risk-check modules, HFT order-record retention pipeline |
| MAR Arts 7–10 inside information | MAR-compliant event schema for inside-information disclosure; PDMR list + closed-period enforcement |
| MiFIR Art 26 transaction reporting | Event-capture pipeline for the 65+ RTS 22 fields including LEIs; ARM-ready feed |
| DLT Pilot Regime — DLT MTF / SS / TSS | On-chain identity registry; corporate-action automation (dividends, voting, redemptions); CSD integration; settlement finality design |
| ERC-3643 (T-REX) / ERC-1400 | Article-annotated contract architecture aligned to NCA reviewer expectations |
| DORA Art 31 CTPP exposure | Vendor-dependency audit (cloud / blockchain infra / oracle); exit-strategy contract clauses |
| Article 74 wind-down (analog for trading-venue closure) | Contract-level orderly cessation procedures, asset-return functions, time-locked emergency exits |

**Primary fit:** FinTech ICP Segment 1 (RWA / tokenized securities) and Segment 7 (ExchangeTech / DLT MTF). **Secondary fit:** WealthTech firms tokenizing fund units, robo-advisor firms automating Article 25 suitability. **Not a fit:** pure-crypto firms with no financial-instrument exposure (those route to MiCA — see [[MiCA-NCA-Authorization-Mechanics]]).

## Open Items / Tensions

- **RTS 28 publication status** is genuinely in flux post-MiFID III — ESMA has issued no-action letters in past cycles. Confirm current best-execution publication requirement before drafting policy. Same caution for RTS 27 (officially repealed).
- **CTP go-live date (30 June 2026)** is the directional target — ESMA's selection procedure can slip. Bond CTP is the first to be operational; equity CTP follows.
- **SI opt-in regime under MiFID III** — Level 2 standards still being adopted. Plan for opt-in registration if pursuing SI status; do not rely on legacy quantitative-threshold designation.
- **"One process, not two" Art 16(5) / DORA framing** applies at authorization only. Post-authorization DORA enforcement is independent (up to 2% turnover penalty). Do not rely on this page or the source checklist as your DORA reference once operational.
- **Reverse solicitation defense** is increasingly narrow post-ESMA 2021 public statement. Note that Article 39 is permissive (*"A Member State may require ... establish a branch"*), not mandatory at Union level — third-country firms targeting EU retail / elective-professional clients should map host-state-by-host-state whether a branch / equivalence is required, and not rely on blanket reverse-solicitation cover where it isn't.

## Verification Status

Re-ingested 2026-05-24 against five local EUR-Lex HTML files (`mifid2.html`, `mifid3-791.html`, `amla.html`, `dora.html`, `prospectus.html`). 32 of 32 load-bearing MiFID II Article-level claims confirmed verbatim against `mifid2.html` — including Articles 5(3), 5(4), 7(3), 8 vs 5(3) register cite, 9 two-persons rule, 10 qualifying holdings, 15 initial-capital cross-reference, 16(5)/(7)/(8)/(9)/(10), 17(5) DEA, 18(7) ≥3 members, 19(5) MTF matched-principal ban, 20 OTF + 20(4) no-SI-overlap, 23 conflicts, 24(4)/(7)(b)/(8), 25(4) execution-only, 27 best execution, 28 order handling, 30 eligible counterparties, 34 freedom-to-provide, 35 + 35(8) host conduct, 39 ("may require" not "shall require"), Annex I A/C, Annex II large-undertaking thresholds €20m/€40m/€2m + opt-up criteria. Cross-references confirmed verbatim: AMLA Reg 2024/1620 (1 Jul 2025 powers + 2028 direct supervision + 2027 first selection), DORA Reg 2022/2554 (17 Jan 2025 application), Prospectus Reg 2017/1129 (4 exemptions + €1m–€8m national option), MiFIR Art 39a PFOF (30 Jun 2026 transition for pre-existing PFOF firms in opt-out Member States).

> [!gap] Residual unverified claims
> IFR Reg 2019/2033 + IFD Dir 2019/2034 HTML files are not in the local folder, and EUR-Lex live fetch is currently blocked by AWS WAF challenge — so the **IFD Article 9 capital tiers (€75k / €150k / €750k)**, **IFR Article 11 ongoing own-funds formula**, **IFR Article 12 Class 3 criteria**, **IFR Article 43 one-third-FOR liquidity**, and the **Class 1 €30bn consolidated-assets reclassification threshold** remain training-data-recall, not source-verified. Wayback Machine fallback (used successfully on the DLT Pilot Regime ingest) is the recommended close-out path. Until then: cross-validate IFR/IFD numbers against ESMA / EBA Level 2 publications and NCA-specific guidance before relying on them for a real filing.

> [!info] Source provenance
> Practitioner content derived from `.raw/InnBlockchain/EU Compliance/mifid2-checklist.md` v1.1 (hash `092e0ef3e509342813def75de3ca37df`, ingested 2026-05-24, re-ingested same day after verification-pass corrections). v1.0 → v1.1 delta = Article 39 "must obtain branch authorization" → "Member State may require branch establishment" (caught during the local-HTML verification pass — Article 39 text reads *"A Member State may require..."*, permissive at host-state level, not EU-mandated).
