---
type: concept
title: "MiCA — NCA Authorization Mechanics (Practitioner Detail)"
created: 2026-05-20
updated: 2026-05-25
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

The article-level requirements an EU crypto-regulatory specialist walks a founder through at first intake. Companion to [[MiCA-Regulation]] (which holds the strategic/positioning framing). Sourced from `.raw/InnBlockchain/EU Compliance/mica-checklist.md` (v2.3, re-ingested 2026-05-25 after triple-check verification against locally-downloaded full text of Regulation (EU) 2023/1114 — 85+ specific claims all verified verbatim).

> [!info] When to read this page
> Read this when you're scoping or executing an NCA filing — capital math, white paper structure, dossier contents, application timeline, mandatory policies. For the *whether MiCA applies / which regime / ICP routing* question, start at [[MiCA-Regulation]].

## Authorisation Pathway — Full vs. Simplified (Article 60)

Before scoping capital and dossier, confirm which pathway applies. **Article 60** lets entities already authorised under another EU financial-services regime provide CASP services via a 40-working-day **notification** rather than full authorisation:

| Entity type | Permitted scope | Article |
|---|---|---|
| Credit institution (bank) | All CASP services | 60(1) |
| Central securities depository | Custody and administration | 60(2) |
| MiFID investment firm | CASP services equivalent to its existing MiFID authorisations | 60(3) |
| Electronic money institution | Custody + transfer services for the EMTs it issues | 60(4) |
| UCITS management company / AIFM | CASP services equivalent to existing authorisations | 60(5) |
| Market operator (MiFID) | Operation of a trading platform for crypto-assets | 60(6) |
| Anything else | Full Article 59 authorisation required | — |

> [!warning] Article 60(10) carve-out
> Entities providing services under Article 60(1)–(6) are **not subject** to Articles 62, 63, 64, 67, 83 and 84. In practice: **no Annex IV capital class** (existing prudential regime applies), no separate authorisation/withdrawal under MiCA, and no qualifying-holdings assessment under MiCA. They remain subject to Articles 65–82 (cross-border, conduct, safeguarding, wind-down, service-specific obligations).

## CASP Minimum Capital Requirements (Title V — Article 67 + Annex IV)

Applies to **full-authorisation CASPs** (not Article 60 entities). Own funds (or equivalent insurance under Article 67(4)) must be at least the **higher** of the Annex IV Class minimum OR **one quarter of prior-year fixed overheads** (or projected first-year overheads for new entrants). Continuous maintenance, not point-in-time.

Classes are **cumulative** — Class 2 includes all Class 1 services; Class 3 includes all Class 2 services.

| Class | Services Authorised (cumulative) | Minimum Capital |
|---|---|---|
| **Class 1** | Execution of orders, placing, transfer services, reception/transmission, advice, portfolio management | **€50,000** |
| **Class 2** | Class 1 services **+ custody and administration**, exchange for funds, exchange for other crypto-assets | **€125,000** |
| **Class 3** | Class 2 services **+ operation of a trading platform** | **€150,000** |

> [!warning] Common misreading
> Custody is **Class 2** (€125,000), not Class 3. Operation of a trading platform is the single service that triggers **Class 3** (€150,000). The earlier v1 of the source checklist had this reversed — that mistake is now corrected.

Capital must be available and demonstrable via audited accounts or bank statements; source of funds documented and legitimate; ongoing capital adequacy plan required.

## ART Issuer Capital (Title III)

Own funds = highest of *(Article 35(1))*:
- **€350,000** (fixed minimum)
- **2% of average reserve assets** (3% for "significant" ARTs — Article 45(5))
- **One quarter of prior-year fixed overheads**

Plus:
- Reserve fully funded **pre-issuance**, segregated, insolvency-remote *(Article 36)*
- Reserve invested only in **highly liquid financial instruments with minimal market, credit, and concentration risk** *(Article 38)*
- **No crypto-assets in the reserve**
- Custodian(s) appointed for reserve management *(Article 37)*
- **Bank-deposit floor:** at least **30%** of the amount referenced in each official currency held as deposits in credit institutions, rising to **60%** for significant ARTs *(Article 36(5)(d) / Article 45(7)(b))*
- Stress testing — under Article 35(3), the home NCA may require own funds **up to 20% higher** than the 2%-of-reserve baseline (NOT 20–40%, as the v1 checklist had said)
- **No yield/interest/staking rewards** to holders *(Article 40)* — rebuilding this post-authorisation is a full product redesign
- **Permanent right of redemption** *(Article 39)* — holders can redeem at any time in funds equivalent to market value, or by delivery of the referenced assets. **No fee** on normal-time redemption (Article 39(3)). Fees, daily caps, or temporary suspension are allowed *only* under the recovery plan (Article 46)
- **Mandatory recovery plan** *(Article 46)* — measures to restore reserve compliance. Notify NCA within 6 months of authorisation / white paper approval
- **Mandatory redemption plan** *(Article 47)* — orderly redemption operational plan. Notify NCA within 6 months of authorisation / white paper approval
- **Quarterly reporting** *(Article 22)* — if issue value > €100M, report holders, value, reserve size, daily transactions to home NCA quarterly
- **Means-of-exchange cap** *(Article 23)* — if estimated quarterly average exceeds 1M transactions/day **AND** €200M/day in a single currency area for use as means of exchange, the issuer **must stop issuing** and submit a remediation plan within 40 working days

## EMT Issuer Capital (Title IV)

- **Prerequisite**: authorisation as a credit institution OR electronic money institution *(Article 48)*. Standard MiCA CASP authorisation alone is NOT sufficient
- 1:1 funds-equivalent backing at all times *(Article 48(2))*
- Funds received in exchange for EMTs invested in **secure, low-risk assets denominated in the same official currency** referenced by the token *(Article 54)*
- EMTs issued **at par value** on receipt of funds *(Article 49(3))*
- Holders have a **redemption right at any time and at par value**, paid in funds other than e-money *(Article 49(4))*
- **EMT redemption shall not be subject to a fee** *(Article 49(6))* — parallel to the ART rule in Article 39(3), without prejudice to Article 46 applied *mutatis mutandis* via Article 55
- Conditions for redemption **prominently stated in the white paper** *(Article 49(5), referring to Article 51(1)(d))*
- **No interest** paid to holders or by CASPs in respect of services related to EMTs *(Article 50)*
- Reserve assets legally segregated from issuer balance sheet
- **Recovery and redemption plans** *(Article 55)* — Article 46 and Article 47 apply *mutatis mutandis*; plans to be notified within **6 months** of the offer to the public or admission to trading

> [!warning] 30%/60% deposit rule is for ARTs, not EMTs
> The v1 checklist mis-attributed the Article 36(5)(d) / Article 45(7)(b) bank-deposit rule to EMTs. Corrected: this applies to **asset-referenced tokens** only. EMT reserve composition is governed by Article 54 and the Electronic Money Directive 2009/110/EC, not by Article 36.

References: Articles 22, 23, 35–40, 46–47 (ART), 48–55 (EMT), 67–68 (CASP own funds), Annex IV (CASP capital classes).

## "Significance" Thresholds (Article 43 for ARTs, Article 56 for EMTs)

EBA classifies an ART (or EMT) as "significant" where **at least three** of the seven Article 43(1) criteria are met. Specific thresholds within each criterion are further specified by Commission Delegated Regulation under Article 43(11).

| # | Criterion (Article 43(1)) | Level 1 threshold |
|---|---|---|
| (a) | Number of holders | > 10 million |
| (b) | Value of the token issued, its market cap, **or** the size of the reserve of assets | > **€5 billion** (any of the three) |
| (c) | Average number and value of daily transactions | > 2.5M tx/day **and** > €500M/day |
| (d) | Issuer designated as gatekeeper under the Digital Markets Act | Reg. (EU) 2022/1925 |
| (e) | Significance of activities on an international scale (incl. payments/remittances) | Further specified by delegated act |
| (f) | Interconnectedness with the financial system | EBA case-by-case |
| (g) | Same issuer issues additional ARTs/EMTs or provides a CASP service | Cumulation criterion |

**Consequences of "significant" classification:**
- Direct **EBA supervision** for significant ARTs *(Article 117(1))*. For significant EMTs, EBA supervision applies **unless** the EMT is denominated in a non-euro Member State currency **and** ≥80% of holders and transaction volume are concentrated in the home Member State — then supervision stays with the home NCA *(Article 117(4)–(5))*
- 2% factor in Article 35(1)(b) raised to **3%** of average reserve assets *(Article 45(5))*
- Minimum **60%** of reserves (per currency referenced) held as deposits in credit institutions *(Article 45(7)(b))*
- Remuneration policy, liquidity management policy, regular liquidity stress testing *(Article 45(1)–(4))*
- Token must be available for custody by multiple unaffiliated CASPs on FRAND basis *(Article 45(2))*

> [!warning] v1 errors corrected
> v1 of the source checklist had four wrong rows in this table: (i) split "value/market cap" and "reserve size" into separate criteria — Article 43(1)(b) is one combined criterion at €5bn; (ii) "reserve > €1bn" was wrong — the threshold is €5bn; (iii) "> 7 Member States" is not in Level 1 — Article 43(1)(e) doesn't specify a Member State count; (iv) missing criteria (d) DMA gatekeeper and (g) cumulation. The "20% NCA discretion" buffer (Article 35(3)) applies to **all** ARTs, not just significant ones.

## Significant CASP Threshold (Article 85 — separate regime)

A CASP is "significant" if it has, in the Union, **≥15 million active users on average** over a calendar year (average of daily active users in the previous year). CASPs must notify the NCA within 2 months of reaching the threshold; the NCA, in agreement with EBA, notifies the College of supervisors. Consequences: enhanced ongoing reporting and supervisory cooperation.

## White Paper Mechanics

**Exemptions to assess first** *(Article 4(2)–(3))* — no white paper required if:
- Offer to **fewer than 150 natural or legal persons per Member State** acting on their own account
- Total consideration in the Union **does not exceed €1,000,000** over any 12-month period
- Offer addressed **solely to qualified investors** and only they can hold the crypto-asset
- The crypto-asset is offered **for free**, or automatically created as a reward for DLT maintenance/transaction validation, or is a utility token providing access to an existing good/service, or is usable only within a limited network of merchants

If no exemption applies — mandatory disclosure under **Article 6** (Title II), **Article 19** (ART), or **Article 51** (EMT). Must be fair, clear, not misleading; published on issuer site; notified to NCA pre-offer; in a language accepted by the home NCA + each host Member State.

**Machine-readable format** — Articles 6, 19, and 51 require white papers to be available in a machine-readable format. The specific technical format and effective date are set by ESMA-developed Regulatory Technical Standards adopted as Commission Delegated Regulations — **not by MiCA Level 1**. Verify the current effective format/timetable against the relevant Commission Delegated Regulation, not against the regulation text. (v1 of the source checklist asserted "iXBRL by 23 December 2025" — that specific date is not in Level 1 and has been removed.)

ART white papers (Article 17) and EMT white papers (Article 17/48) require **prior NCA approval/notification with substantive review**. Title II white papers must be notified to NCA in advance (Article 8) but **do not require prior approval**.

**Ongoing duty to update** *(Articles 12, 25, 53)* — the white paper is not a one-time disclosure. Any "significant new factor, material mistake, or material inaccuracy" capable of affecting the assessment of the crypto-asset triggers an obligation to modify and re-notify. For ARTs and EMTs, modifications require prior NCA approval before publication.

**Historical-version retention** *(Article 9(3))* — previously published versions must remain accessible on the issuer's website for **at least 10 years** after publication, marked as no longer valid, with a hyperlink to the current version.

**Failed-offer refund mechanics** *(Article 10 — Title II only)* — if a Title II offer has a stated subscription period/target and the condition is not met, funds collected must be returned via either (a) deposit at a credit institution, or (b) an arrangement that guarantees their return. Disclosure of the refund mechanism in the white paper is mandatory.

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

## ICT & DORA Integration (Articles 34(10) and 68(7)–(8))

MiCA cross-references **DORA (Regulation (EU) 2022/2554)** at two anchor points: **Article 34(10)** for ART issuers and **Article 68(7)–(8)** for CASPs. Both require "resilient and secure ICT systems as required by Regulation (EU) 2022/2554". DORA compliance IS the mechanism for meeting MiCA's ICT obligations — one regulatory process at authorisation, not two. DORA readiness is assessed by the NCA as part of MiCA authorisation review.

> [!warning] v1 cited the wrong article
> The v1 source checklist (and v1 of this page) cited "Article 66" as the ICT requirement. Article 66 is actually **"Obligation to act honestly, fairly and professionally in the best interests of clients"** — conduct of business, not ICT. The correct citations are **34(10)** (ARTs) and **68(7)–(8)** (CASPs). Fixed.

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

MiCA does not stand alone. Until **10 July 2027**, AML compliance for CASPs rests on national law transposing **Directive (EU) 2015/849 (AMLD4)** as amended by **Directive (EU) 2018/843 (AMLD5)**, plus **Regulation (EU) 2023/1113 (TFR / Travel Rule)**. From 10 July 2027, the **2024 EU AML Package** applies:
- **Regulation (EU) 2024/1624 ("AMLR")** — single, directly applicable EU AML rulebook for obliged entities including CASPs
- **Directive (EU) 2024/1640 ("AMLD6")** — institutional/supervisory framework; MS transposition by 10 July 2027
- **Regulation (EU) 2024/1620** — establishes **AMLA** in Frankfurt; operational since 1 July 2025; direct supervision of selected obliged entities from **1 January 2028**

NCA will not authorise without:
- Documented AML/CFT program (CDD, KYC, KYB, transaction monitoring, SAR procedures, sanctions screening, PEP screening)
- MLRO appointed (senior management, EU-based)
- AML risk assessment (customer/product/geographic/channel)
- Travel Rule capability — transmit originator and beneficiary info with crypto transfers
- 5-year record retention
- Staff training program documented + scheduled

AML framework must be NCA-audit-ready Day 1 — single most common cause of authorisation delays or refusals. Build the programme to satisfy the existing national regime while remaining layerable to AMLR/AMLD6 without re-architecture.

## Operational Policies (Pre-Application)

Required in the dossier:
- **Business plan** — 3-year, revenue model, target markets, services, staffing, technology, financial forecasts
- **Organizational chart** — reporting lines, key functions (compliance, risk, IT, ops, internal audit)
- **Conflict of interest policy** — identification, prevention, management, disclosure across functions and personal interests
- **Outsourcing policy** — documented oversight + control of any critical outsourced functions
- **Complaint handling procedure** — formal, transparent, prescribed timelines
- **Marketing and communications policy** — fair, clear, not misleading, consistent with white paper
- **Record-keeping policy** — minimum 5-year retention

## Consumer Protection & Market Abuse (Articles 13, 66, 75–82, 86–92)

**Consumer protection / conduct of business:**
- **Best-interests duty** *(Articles 27 (ART) / 66 (CASP))* — standalone duty to act honestly, fairly, professionally in clients' / holders' best interests
- **14-day right of withdrawal** *(Article 13)* — retail consumers buying Title II crypto-assets directly from offeror (or CASP placing on its behalf); not applicable where the asset has already been admitted to trading
- Pre-contractual disclosures of services, fees, risks, complaint procedures
- **Suitability assessment + report** *(Article 81)* for advisory and portfolio management; periodic reassessment every 2 years; staff must possess necessary knowledge and competence (NCAs publish criteria); inducement restrictions for independent advice / portfolio management
- **Periodic portfolio-management statements** *(Article 81(14))* — every 3 months (or via online system with quarterly access evidence)
- **Environmental disclosure** *(Article 66(5))* — CASPs publish principal adverse environmental impacts of consensus mechanisms used
- Pricing transparency

**Market abuse (Articles 86–92):**
- **Insider dealing prohibition** *(Article 89)*
- **Unlawful disclosure prohibition** *(Article 90)*
- **Market manipulation prohibition** *(Article 91)* — wash trading, spoofing, layering, fictitious devices, dissemination of false/misleading information
- **Public disclosure of inside information** *(Article 88)* — as soon as possible; on website for ≥5 years; combination with marketing prohibited; delayed disclosure permitted under three cumulative conditions; NCA informed immediately after eventual disclosure
- **Prevention-and-detection arrangements + STORs** *(Article 92)* — anyone professionally arranging or executing transactions must have effective systems to prevent and detect market abuse, **and report suspicious orders/transactions to NCA without delay**
- Surveillance systems (trading platforms)

> [!info] MiCA does NOT import MAR's insider lists / managers' transactions regime
> Insider lists, managers' transactions disclosure, and personal-account pre-clearance are **MAR concepts** (Articles 18–19 MAR), not MiCA Level 1 requirements. Firms often maintain them anyway as best practice to evidence the conflict-of-interest controls required by Article 72 and to support STOR detection — but they are not a standalone MiCA obligation. v1 of the source checklist presented these as MiCA requirements; corrected.

## Service-Specific CASP Obligations (Articles 75–82)

Each CASP service line carries its own conduct/operational obligations layered on top of the general organisational requirements:

- **Article 75 (Custody)** — written client agreement; register of positions; custody policy; statement of position **at least every 3 months**; **liability for loss attributable to the CASP, capped at market value at time of loss**; legal and operational DLT segregation; sub-custody only via Article 59 CASPs
- **Article 76 (Trading platform)** — operating rules covering CDD-based admission, exclusion categories, fair participation, suspension; **no admission of crypto-assets without a compliant white paper** where one is required; pre-/post-trade transparency in real time; **no dealing on own account** on the operated platform; matched-principal trading **only with client consent and NCA notification**; **final settlement initiated within 24 hours** on DLT (or by close of business day off-DLT); resilient systems with circuit breakers
- **Article 77 (Exchange)** — non-discriminatory commercial policy; firm or indicative prices published; post-trade transparency; execution policy
- **Article 78 (Execution)** — best execution; client information on the policy and consent; off-platform execution requires prior express consent
- **Article 79 (Placing)** — pre-engagement disclosure (type, fees, timing, targeted purchasers); conflicts management
- **Article 80 (RTO)** — prompt transmission; no misuse of order information; **no inducements** for routing orders
- **Article 81 (Advice / portfolio management)** — suitability assessment + report; **periodic reassessment ≥ every 2 years**; quarterly portfolio statements; staff competence; independence disclosure; inducement restrictions
- **Article 82 (Transfer services)** — written client agreement; Travel Rule compliance per Reg. (EU) 2023/1113

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
| Articles 34(10) / 68(7)–(8) ICT / DORA | Independent smart contract security audit with material findings remediation; NCA-format audit report |
| Article 70(3) client fiat segregation | Event schema + accounting integration for end-of-day reconciliation |
| Article 74 wind-down plan | Contract-level orderly cessation procedures (paused state, asset return functions, time-locked emergency exits) |
| ERC-3643 / ERC-1400 | Article-annotated contract architecture aligned to NCA reviewer expectations |
| Travel Rule (Reg (EU) 2023/1113) | Structured event schema for originator/beneficiary transmission |

Primary fit: Crypto Native ICP Segments 2–10 (CASP authorization path) and FinTech ICP Segment 1 ExchangeTech (CASP–MiFID II split). **Not** relevant to Crypto Native Seg 1 (RWA / tokenized securities — MiFID II + DLT Pilot Regime path).

## Ongoing Notification Obligations (Post-Authorisation)

- **Changes to management body** *(Articles 33 (ART) / 69 (CASP))* — notify NCA **before** new members exercise activities, with fit-and-proper documentation
- **Qualifying holdings — ART issuer** *(Articles 41–42)* — proposed direct/indirect acquisition reaching/exceeding **20%, 30%, or 50%** of voting rights/capital, or making the issuer a subsidiary, requires prior written notification; NCA has 60 working days to assess
- **Qualifying holdings — CASP** *(Articles 83–84)* — same regime; affects every funding round, secondary, founder transfer, exit. **Carve-out:** Article 60 entities are exempt from Articles 83–84 by virtue of Article 60(10)
- **Cross-border passporting** *(Article 65)* — notify home NCA before providing services in another Member State; home NCA forwards to host NCA within 10 working days; CASP may begin services from receipt of communication or at the latest from 15 calendar days after submission

## Enforcement Exposure (Article 111)

Member States must provide for **at least** the following maximum fines (national law may go higher), per Article 111(3):

| Infringement (Art 111(1)) | Articles in scope | Legal person — flat | Legal person — turnover cap |
|---|---|---|---|
| (a) Title II — other crypto-assets | Arts 4–14 | €5,000,000 | **3%** |
| (b) Title III — ART issuers | Arts 16, 17, 19, 22, 23, 25, 27–41, 46, 47 | €5,000,000 | **12.5%** |
| (c) Title IV — EMT issuers | Arts 48–51, 53–55 | €5,000,000 | **12.5%** |
| (d) Title V — CASPs | Arts 59, 60, 64, 65–83 | €5,000,000 | **5%** |
| (e) Art 88 disclosure failure | Art 88 | €2,500,000 | **2%** |
| (e) Market abuse | Arts 89–92 | €15,000,000 | **15%** |

Plus disgorgement: at least **2× profits gained / losses avoided** for (a)–(d); at least **3×** for market abuse (e). Non-monetary penalties include withdrawal of authorisation, ≥10-year ban from management functions for repeat market abuse offences, and ban from dealing on own account.

## Open Items / Tensions

- **Machine-readable white-paper format** is set by ESMA RTS / Commission Delegated Regulation — not by MiCA Level 1. Confirm current effective date and format with counsel before drafting.
- **"One process, not two" DORA framing** applies at MiCA authorisation only (via Articles 34(10) and 68(7)–(8)). Post-authorisation DORA enforcement is independent (up to 2% turnover penalty). Don't rely on this page as your DORA reference once operational.
- **ESMA / EBA Level 2 / Level 3 technical standards** continue to be issued. Operational details may evolve.

> [!gap] This page is derived from a single source (`.raw/InnBlockchain/EU Compliance/mica-checklist.md`, v2.3, hash `492b5075eb46fb2a8a156fbad9b758b0`, re-ingested 2026-05-24, triple-checked 2026-05-25 against locally-downloaded mica.html (full text of Regulation (EU) 2023/1114, OJ L 150)). 85+ specific claims (article numbers, monetary amounts, percentages, time periods, subsection mappings, Annex IV) all verified verbatim. Cross-validation against ESMA / EBA Level 2 publications + NCA-specific guidance is still recommended before relying on any specific Article-level claim for a real filing.
