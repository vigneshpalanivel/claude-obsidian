---
type: concept
title: "MiCA — NCA Authorization Mechanics (Practitioner Detail)"
created: 2026-05-20
updated: 2026-05-20
tags:
  - MiCA
  - EU
  - crypto
  - compliance
  - regulation
  - practitioner
  - NCA
  - authorization
status: current
related:
  - "[[MiCA-Regulation]]"
  - "[[DORA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[MiFID-II]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# MiCA — NCA Authorization Mechanics (Practitioner Detail)

The article-level requirements an EU crypto-regulatory specialist walks a founder through at first intake. Companion to [[MiCA-Regulation]] (which holds the strategic/positioning framing). Sourced from `.raw/InnBlockchain/EU Compliance/mica-checklist.md` and MiCA Regulation (EU) 2023/1114.

> [!info] When to read this page
> Read this when you're scoping or executing an NCA filing — capital math, white paper structure, dossier contents, application timeline, mandatory policies. For the *whether MiCA applies / which regime / ICP routing* question, start at [[MiCA-Regulation]].

## CASP Minimum Capital Requirements (Title V)

Own funds must be at least the **higher** of the Class minimum OR 25% of prior-year fixed overheads (or projected first-year overheads for new entrants). Must be maintained continuously, not just at authorization.

| Service Class | Services Covered | Minimum Own Funds |
|---|---|---|
| **Class 1** | Advisory, reception/transmission of orders, placing | **€50,000** |
| **Class 2** | Crypto-fiat exchange, crypto-crypto exchange, order execution, operation of a trading platform | **€125,000** |
| **Class 3** | Custody and administration of crypto-assets | **€150,000** |

Capital must be available and demonstrable via audited accounts or bank statements; source of funds documented and legitimate (NCA scrutinizes this); ongoing capital adequacy plan required.

## ART Issuer Capital (Title III)

Own funds = highest of:
- **€350,000** (fixed minimum)
- **2% of average reserve assets** (3% for "significant" ARTs)
- **25% of prior-year fixed overheads**

Plus:
- Reserve fully funded **pre-issuance**, segregated, insolvency-remote
- Reserve invested only in eligible instruments (sovereign debt, money-market funds, bank deposits)
- **No crypto-assets in the reserve**
- Custodian(s) appointed for reserve management
- Stress testing (Article 35(5)) — NCA may require **20–40% additional own funds** based on results. Plan the capital buffer before filing.
- **No yield/interest/staking rewards** to holders (Article 40) — rebuilding this post-authorization is a full product redesign.

## EMT Issuer Capital (Title IV)

- **Prerequisite**: authorization as a credit institution OR electronic money institution. Standard MiCA CASP authorization alone is NOT sufficient.
- 1:1 fiat reserve at all times
- ≥ **30%** of reserve as bank deposits (60% for "significant" EMTs)
- Remaining reserve in secure, low-risk, liquid financial instruments
- **No interest or yield** to holders
- Reserve assets legally segregated from issuer balance sheet

References: Articles 35–37 (ART reserves), 48–49 (EMT reserves), 67–68 (CASP own funds).

## "Significance" Thresholds (Articles 43–44)

An ART or EMT is classified "significant" by EBA on meeting ≥3 criteria. Consequences: direct EBA supervision (not NCA), 3% reserve own funds, 60% bank deposit reserve (EMTs), enhanced stress testing, mandatory recovery & wind-down plan, EBA can require up to 20% additional buffer.

| Criterion | Threshold |
|---|---|
| Token holders | > 10 million |
| Market cap / value issued | > €5 billion |
| Daily transactions | > 2.5M / > €500M daily |
| Reserve size | > €1 billion |
| Cross-border activities | > 7 Member States |
| Financial system interconnectedness | EBA case-by-case |

## White Paper Mechanics

**Exemptions to assess first** (Articles 4–5) — no white paper required if:
- Offer to < **150 persons per Member State**
- Total consideration < **€1,000,000** / 12-month period
- Offer solely to qualified investors (and only they can hold)
- Free distribution (airdrops, mining/validation rewards)

If no exemption applies — mandatory disclosure under Article 6 (Title II), Article 19 (ART), or Article 51 (EMT). Must be fair, clear, not misleading; published on issuer site; notified to NCA pre-offer; in a language accepted by the home NCA + each host Member State.

**iXBRL format mandatory from 23 December 2025** — machine-readable disclosure. Document-preparation toolchain must support this before filing.

ART white papers require **prior NCA approval**. Title II white papers must be notified but do not require prior approval.

### White Paper Content (Article 6)

Mandatory sections:
- Issuer information (legal name, registered address, LEI, directors, key persons)
- Project description (purpose, use of funds, roadmap, milestones)
- Token description (rights/obligations, supply, issuance, lock-ups/vesting)
- Technology description (DLT, consensus, interoperability, security standards)
- Risk disclosure (market, technology, regulatory, liquidity, counterparty, custody, operational, cybersecurity)
- Governance (decision-making, voting, upgrade/change procedures)
- Offer details (price/mechanism, total raise, subscription period, allocation)
- Trading and liquidity (venue admission, liquidity arrangements)
- Environmental impact (consensus mechanism principal adverse impacts)
- Mandatory disclaimer (token may lose entire value, not covered by investor compensation or deposit guarantee schemes)

## Entity & Governance Requirements

- EU legal entity (GmbH / SAS / BV / OÜ / equivalent)
- Registered office in a Member State
- **Effective place of management in the EU** — brass-plate setups fail NCA scrutiny
- Home Member State identified (becomes home NCA)
- **Two natural persons** effectively directing the business (dual management for CASPs)
- All directors, key managers, and qualifying shareholders (≥10%) pass "fit and proper" review:
  - Sufficient knowledge, skills, experience
  - Good repute — no financial crime, fraud, AML, or terrorist financing convictions
  - Sufficient time commitment
  - No impairing conflicts of interest
  - Demonstrable financial soundness (qualifying shareholders)
- Board composition allowing independent oversight
- CVs + background documentation prepared for NCA independent verification

References: Articles 34, 59, 62, 68.

## Article 74 — Orderly Wind-Down Plan (CASPs)

Standalone mandatory dossier item, separate from business continuity. Documents the ability to wind down all activities without undue economic harm to clients:
- Continuity or recovery of any critical client-facing activities during wind-down
- Return of client assets and funds in an orderly sequence
- Communications procedures to clients during wind-down
- Timeline and steps for cessation of each service line

Distinct from a BCP (which assumes the business continues operating). NCAs review this at authorization to assess exit risk for clients.

## Article 70(3) — End-of-Day Client Fiat Placement

Client fiat funds (non-e-money) received must be placed with a credit institution or central bank by the **end of the business day following receipt**, in separately identifiable accounts distinct from the CASP's own. Requires a dedicated banking relationship and segregated account infrastructure stood up **before** going live.

## Client Asset Safeguarding (CASPs)

- Client crypto-assets and funds segregated from firm's own at all times
- Documented custody policy including private key management
- Client assets insolvency-remote (not available to CASP creditors)
- CASP liable for loss of client crypto-assets unless caused by event beyond reasonable control

References: Articles 67–73 (CASP organizational), 70, 75–82 (client asset safeguarding, specific service requirements).

## ICT & DORA Integration (Article 66)

MiCA Article 66 directly cross-references **DORA (Regulation (EU) 2022/2554)**. DORA compliance IS the mechanism for meeting MiCA's ICT obligations — one regulatory process at authorization, not two. DORA readiness is assessed by the NCA as part of MiCA authorization review.

Required:
- ICT risk management framework (identification, assessment, mitigation, monitoring)
- Business continuity plan (BCP) — operations under disruption/attack/failure
- Disaster recovery plan with explicit RTO/RPO per critical system
- Incident detection, classification, NCA reporting within prescribed timelines
- Penetration testing — independent vulnerability + threat-led pen tests
- Third-party ICT risk management (cloud, blockchain nodes, oracles, APIs) with audit rights, data access, exit strategies
- Smart contract audit — independent third-party with material findings remediated before deployment

GDPR (Regulation (EU) 2016/679) remains an independent horizontal obligation — not a MiCA/DORA requirement, but NCAs expect it in place.

> [!warning] Post-authorization DORA enforcement is independent
> The "one process" framing applies at MiCA authorization. Once live, DORA has independent supervisory enforcement with penalties up to 2% of total annual turnover. The checklist this page derives from is silent on post-authorization DORA inspections — don't use it as your only DORA reference once you're operating.

References: DORA Articles 5–16 (ICT risk), 17–23 (incident reporting), 24–27 (resilience testing), 28–44 (third-party risk).

## AML/CFT Integration

MiCA does not stand alone — AML rests on **AMLD6 + Regulation (EU) 2023/1113 (TFR / Travel Rule)**. NCA will not authorize without:
- Documented AML/CFT program (CDD, KYC, KYB, transaction monitoring, SAR procedures, sanctions screening, PEP screening)
- MLRO appointed (senior management, EU-based)
- AML risk assessment (customer/product/geographic/channel)
- Travel Rule capability — transmit originator and beneficiary info with crypto transfers
- 5-year record retention
- Staff training program documented + scheduled

**AMLA** (operational Frankfurt, July 2025) takes direct supervision of certain high-risk CASPs from 2026 onward. AML framework must be NCA-audit-ready Day 1 — single most common cause of authorization delays or refusals.

## Operational Policies (Pre-Application)

Required in the dossier:
- **Business plan** — 3-year, revenue model, target markets, services, staffing, technology, financial forecasts
- **Organizational chart** — reporting lines, key functions (compliance, risk, IT, ops, internal audit)
- **Conflict of interest policy** — identification, prevention, management, disclosure across functions and personal interests
- **Outsourcing policy** — documented oversight + control of any critical outsourced functions
- **Complaint handling procedure** — formal, transparent, prescribed timelines
- **Marketing and communications policy** — fair, clear, not misleading, consistent with white paper
- **Record-keeping policy** — minimum 5-year retention

## Consumer Protection & Market Abuse (Title VI, Articles 75–82, 86–92)

- **14-day right of withdrawal** for retail consumers buying Title II crypto-assets directly from the issuer (specific exceptions apply)
- Pre-contractual disclosures (services, fees, risks, complaint procedures)
- Suitability/appropriateness assessment (advisory + portfolio management)
- Pricing transparency: full fee, cost, charge, execution disclosure
- Market abuse rules apply from day one:
  - Insider dealing prohibition (MNPI)
  - Market manipulation prohibition (wash trading, spoofing, layering, pump-and-dump)
  - Insider lists
  - MNPI disclosure procedures (with delayed disclosure provisions)
  - Personal dealing rules (directors, employees, connected persons)
  - Surveillance systems (trading platforms)

## Application Workflow & Timeline

| Step | Action | Typical Timeline |
|---|---|---|
| 1 | Engage specialist EU crypto-reg counsel | Week 0 |
| 2 | Complete readiness assessment, identify gaps | Weeks 1–2 |
| 3 | Select home Member State and NCA | Week 2 |
| 4 | Prepare application dossier | Weeks 3–16 |
| 5 | Submit to NCA | Week 16+ |
| 6 | NCA completeness check | 25 working days |
| 7 | Substantive review + Q&A rounds | 40+ working days (often 3–6 months in practice) |
| 8 | Authorization granted / conditions / refusal | **6–12 months total** from initial submission |
| 9 | ESMA register listing | Upon authorization |
| 10 | EU-wide passporting notification | Post-authorization |

Active crypto-regulatory NCAs: **AMF** (France), **BaFin** (Germany), **AFM** (Netherlands), **CBI** (Ireland), **Bank of Lithuania**. Home Member State choice is a strategic decision — speed, secondary requirements, supervisory experience vary materially.

## Application Dossier Contents (Minimum)

- Completed application form (NCA-specific)
- Business plan (3-year, detailed)
- Organizational chart + governance structure
- Fit-and-proper documentation (all directors, senior managers, qualifying shareholders)
- Proof of minimum capital / own funds
- AML/CFT compliance program
- ICT risk management framework + DORA compliance documentation
- Business continuity + disaster recovery plans
- Conflict of interest policy
- Complaint handling procedures
- Client asset safeguarding policy (if applicable)
- White paper (if issuing tokens)
- Outsourcing arrangements (if applicable)
- Insurance / equivalent guarantee documentation (if required)
- Marketing + communications policy
- Legal opinions on token classification (if applicable)
- **Article 74 orderly wind-down plan** (CASPs)

## InnBlockchain Service Mapping

Every Article reference here is potentially a contract function, audit item, or compliance artifact InnBlockchain can deliver:

| MiCA Requirement | InnBlockchain Deliverable |
|---|---|
| Article 35–37 ART reserve segregation | Proof-of-Reserve oracle integration, multi-sig custody architecture |
| Article 40 no-yield rule | Smart contract design review — flag yield/staking surfaces before deployment |
| Article 43–44 significance thresholds | Architecture stress-test framework for projected scale |
| Article 6 / 19 / 51 white paper | iXBRL-ready white paper technical review, code-to-disclosure mapping |
| Article 66 ICT / DORA | Independent smart contract security audit with material findings remediation; NCA-format audit report |
| Article 70(3) client fiat segregation | Event schema + accounting integration for end-of-day reconciliation |
| Article 74 wind-down plan | Contract-level orderly cessation procedures (paused state, asset return functions, time-locked emergency exits) |
| ERC-3643 / ERC-1400 | Article-annotated contract architecture aligned to NCA reviewer expectations |
| Travel Rule (Reg (EU) 2023/1113) | Structured event schema for originator/beneficiary transmission |

Primary fit: Crypto Native ICP Segments 2–10 (CASP authorization path) and FinTech ICP Segment 1 ExchangeTech (CASP–MiFID II split). **Not** relevant to Crypto Native Seg 1 (RWA / tokenized securities — MiFID II + DLT Pilot Regime path).

## Open Items / Tensions

- **iXBRL date (23 Dec 2025)** asserted in source checklist but not yet confirmed against ESMA RTS publication — verify before client-facing use.
- **"One process, not two" Article 66/DORA framing** applies at authorization only. Post-authorization DORA enforcement is independent (up to 2% turnover penalty) — do not rely on this page or the source checklist as your DORA reference once operational.
- **ESMA Level 2 / Level 3 technical standards** for several MiCA provisions still being finalized as of late 2025. Some operational details may shift before 1 July 2026.

> [!gap] This page is derived from a single source (`.raw/InnBlockchain/EU Compliance/mica-checklist.md`, hash `79a90bdf14e17887faa9dcb048c5b7f4`, ingested 2026-05-20). Cross-validation against ESMA / EBA Level 2 publications + NCA-specific guidance is recommended before relying on any specific Article-level claim for a real filing.
