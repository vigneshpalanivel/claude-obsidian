---
type: concept
title: "DORA — NCA Supervision Mechanics (Practitioner Detail)"
created: 2026-05-24
updated: 2026-05-24
tags:
  - DORA
  - EU
  - ICT
  - cybersecurity
  - compliance
  - regulation
  - practitioner
  - NCA
  - supervision
status: current
related:
  - "[[DORA-Regulation]]"
  - "[[MiCA-NCA-Authorization-Mechanics]]"
  - "[[MiFID-II-NCA-Authorization-Mechanics]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# DORA — NCA Supervision Mechanics (Practitioner Detail)

The article-level requirements an EU ICT / financial-regulatory specialist walks an entity through at first intake. Companion to [[DORA-Regulation]] (which holds the strategic / "what-is-DORA" framing). Sourced from `.raw/InnBlockchain/EU Compliance/dora-checklist.md` (v1.1, hash `7846555f77db1b3eac861b5ab510385a`).

> [!info] When to read this page
> Read this when you're scoping or executing a DORA compliance buildout — pillar-by-pillar artefact list, Register of Information mechanics, TLPT scoping, contractual provisions, sectoral integration. For the *what-is-DORA / who's-in-scope* question, start at [[DORA-Regulation]].

> [!warning] DORA is not an authorisation regime
> There is **no DORA licence**. DORA applies automatically to in-scope financial entities by virtue of their sectoral authorisation (MiCA, MiFID II, CRD/CRR, PSD2/PSD3, Solvency II, etc.) and is supervised by the same NCA that authorises the underlying business. Pre-authorisation start-ups are not *yet* in DORA scope, but NCAs assess DORA readiness as part of the sectoral authorisation review.

## Scope — Article 2 Financial Entities

DORA Article 2(1) lists ~20 categories of "financial entity." If your sectoral authorisation slots into any of these, you are in scope:

- Credit institutions (CRD-authorised banks)
- Payment institutions (PSD2/PSD3 PIs), including exempt PIs
- Account information service providers (AISPs)
- Electronic money institutions (EMIs), including exempt EMIs
- Investment firms (MiFID II)
- **Crypto-asset service providers (CASPs) authorised under MiCA** *(Article 2(1)(f))*
- **Issuers of asset-referenced tokens (ARTs)** authorised under MiCA Title III
- Central securities depositories (CSDs)
- Central counterparties (CCPs)
- Trading venues — regulated markets, MTFs, OTFs, **DLT MTF / SS / TSS under the DLT Pilot Regime**
- Trade repositories, AIFMs, UCITS ManCos
- Data reporting service providers (ARMs, APAs, CTPs)
- Insurance / reinsurance undertakings, insurance intermediaries
- IORPs (subject to size carve-outs — see below)
- Credit rating agencies, administrators of critical benchmarks
- Crowdfunding service providers (ECSPs)
- Securitisation repositories

## Scope Exclusions (Article 2(3)–(4))

- **Sub-threshold AIFMs** below AIFMD registration-only threshold
- **Small Solvency II insurance / reinsurance undertakings** under Article 4 exemption
- **Microenterprise insurance intermediaries** not on a professional basis for life / investment-based insurance
- **IORPs operating pension schemes with fewer than 15 members in total** — *fully out of DORA scope*
- **Natural / legal persons exempted under MiFID II Articles 2 and 3**
- Post Office Giro institutions covered by CRD Article 2(5)(3)

## Proportionality — Simplified Framework (Article 16)

Smaller / lower-risk entities qualify for a **simplified ICT risk management framework** under Article 16:

- Small and non-interconnected investment firms (per IFR / IFD definition)
- PIs exempted under PSD2 Article 32
- EMIs exempted under Directive 2009/110/EC Article 9
- **IORPs with fewer than 100 members in total** (15–99 — fewer than 15 is fully out of scope)
- Small insurance / reinsurance intermediaries, ancillary intermediaries

Detailed in Commission Delegated Regulation (EU) 2024/1774 Title II. Simplified ≠ exempt — you still need a written framework, incident process, basic testing, third-party register, and reporting workflow.

**Microenterprise carve-outs** further lighten specific obligations (training cadence, contractual provisions, audit frequency). Microenterprise = fewer than 10 staff AND (annual turnover ≤ €2M OR balance sheet ≤ €2M) per Commission Recommendation 2003/361/EC, imported via DORA Article 3(60).

## Pillar 1 — ICT Risk Management Framework (Articles 5–16)

### Governance (Article 5)
- Management body has **explicit, non-delegable** responsibility for the ICT risk management framework *(Article 5(2))*
- Board members can demonstrate sufficient knowledge to assess ICT risk *(Article 5(4))* — documented training programme
- Annual board review + approval of framework, risk appetite, and budget
- Clear separation between policy-setting, operational ICT, ICT risk control, and internal audit

### Framework (Article 6)
- Written framework covering strategies, policies, procedures, protocols, tools to protect all information + ICT assets
- Annual review + update; after major incident; after supervisory instruction
- Internal audit coverage with documented follow-up
- Explicit **digital operational resilience strategy** *(Article 6(8))* — objectives, risk tolerance, indicators

Detailed content of the framework is specified in **Commission Delegated Regulation (EU) 2024/1774** — treat the RTS as a paragraph-by-paragraph compliance map.

### Identification (Article 8)
- Inventory of information assets + ICT assets, kept up to date
- Inventory of business functions / roles / responsibilities mapped to supporting ICT assets
- **"Critical or important functions" formally identified** — this designation drives TLPT scope, contractual depth, and exit-strategy depth (heaviest single decision in the framework)
- Dependencies on third-party ICT providers mapped for each CIF

### Protection (Article 9)
- ICT security policies + tools for resilience, continuity, availability
- Network security architecture (segmentation, hardening, baselines)
- IAM (RBAC, least privilege, recertification) + PAM (admin/privileged session controls)
- **Cryptography policy** — algorithms, key lifecycle, custodianship; aligned with current ENISA / NIST guidance
- ICT change management with formal risk assessment
- Patch + vulnerability management with severity SLAs

### Detection (Article 10)
- Anomaly detection across endpoint / network / identity / application / data layers
- Alert thresholds mapped to Article 18 classification criteria
- 24/7 monitoring proportionate to risk profile

### Response, Recovery, BCP/DRP (Articles 11–12)
- ICT business continuity policy, board-approved
- Actionable response + recovery plans per major scenario
- **RTOs + RPOs defined per critical or important function** and supporting ICT asset
- Backup policies — frequency, encryption, segregation, **immutable / ransomware-resilient copies**
- Backup restoration tested at least annually, independently from production
- BCP + DRP exercises at least annual; results documented; remediation tracked

### Learning + Communication (Articles 13–14)
- Mandatory post-mortem on every major incident
- Lessons integrated into framework / BCP / training
- All-staff ICT security awareness training annually, phishing-tested
- Crisis communication plan with designated spokesperson

## Pillar 2 — Incident Management, Classification & Reporting (Articles 17–23)

### Classification (Article 18)
Major-incident classification is **objective**, not discretionary. Criteria specified in **Commission Delegated Regulation (EU) 2024/1772**:

- Clients / financial counterparties / transactions affected
- Reputational impact
- Duration + service downtime
- Geographical spread
- Data losses — confidentiality, integrity, availability
- Criticality of services affected
- Economic impact

Operationalised in the incident-management runbook; classification decision log maintained for every call.

### Reporting Timelines (Articles 19–20)
Three sequential reports per major incident, on harmonised templates:

| Report | Trigger | Practical timing |
|---|---|---|
| **Initial notification** | Classification as major | As soon as feasible — operationally treat as **within 4 hours of classification**, hard outer limit 24 hours from detection |
| **Intermediate report** | Updated facts during incident | Per current harmonised reporting RTS / ITS |
| **Final report** | Root cause + remediation | Per current harmonised reporting RTS / ITS |

> [!warning] Level 2 timing has moved across drafts
> The exact hour-counts in the harmonised reporting RTS / ITS adopted under Article 20 have shifted across drafts. Confirm the current timeline with counsel before going live, and design your runbook to the *tightest* observed timeline so you are never out of compliance during a Level 2 change.

### Payment-Related Incidents (Article 23)
Credit institutions, PIs, AISPs, EMIs — the legacy PSD2 Article 96 operational/security incident reporting regime is absorbed into the DORA channel. **No parallel PSD2 channel.**

## Pillar 3 — Digital Operational Resilience Testing (Articles 24–27)

### Basic Testing Battery (Article 25)
At least annually on ICT systems supporting critical or important functions:

- Vulnerability assessments + scans
- Open-source analyses
- Network security assessments
- Gap analyses
- Physical security reviews
- Questionnaires + scanning software
- Source code reviews (manual or automated, where feasible)
- Scenario-based + compatibility + performance + end-to-end testing
- Penetration testing (general — distinct from TLPT)

### Threat-Led Penetration Testing / TLPT (Articles 26–27)
Required **at least every three years** on live production systems for entities designated as significant under Commission Delegated Regulation (EU) 2025/295. Most entities are *out* of TLPT scope — confirm with NCA in writing.

- TLPT scope = critical or important functions on live production
- Methodology aligned with TIBER-EU as built into the RTS
- **Pooled / joint TLPT** with other in-scope entities sharing the same provider is permitted (and may be required for efficiency)
- Third-party providers included where they support CIFs — provider consent + contractual arrangements in advance
- **Testers:** default rule is *external testers every cycle*. Non-significant credit institutions may use internal testers, but **not in two consecutive cycles** *(Article 26(8))*
- NCA / TLPT authority issues attestation on completion of each cycle

> [!info] TLPT operational reality
> Budget €500k–€2M per cycle. It is a 6–12 month multi-phase engagement (threat intelligence + red-team live execution + blue-team de-brief + supervisory closure), not a colloquial pen test.

## Pillar 4 — ICT Third-Party Risk Management (Articles 28–30)

Three load-bearing artefacts: **the contract**, **the Register**, **the exit plan**.

### Register of Information (Article 28(3))
- Maintained for *every* ICT third-party arrangement, separately flagged for those supporting critical or important functions
- **Annual submission to NCA** using the harmonised ITS template — **Commission Implementing Regulation (EU) 2024/2956**
- Pre-notification of any new ICT provider supporting a CIF — to NCA before contract execution
- Notification of any change (including sub-outsourcing) to CIF arrangements

> [!warning] The Register is the operationally heaviest artefact
> The ITS template has ~14 sub-templates and ~50 fields per contract. Most entities under-budget this by 3–5×. Treat as a standing data-engineering project, not a one-time exercise.

### Key Contractual Provisions (Article 30)

**Minimum for all ICT contracts (Article 30(2)):**
- Description of all functions + services
- Locations of performance + data processing/storage
- Data protection (incl. personal data) + availability / authenticity / integrity / confidentiality
- SLAs with quantifiable targets + remedies
- Notice + reporting obligations of the provider
- Audit, access, inspection rights — for the financial entity, its appointed third parties, **and the NCA**
- Termination rights + minimum notice periods
- Conditions for sub-contracting

**Additional for critical-or-important functions (Article 30(3)):**
- Full SLA descriptions with quantitative + qualitative targets
- Incident-impacting notice + reporting obligations
- Cooperation with NCAs + resolution authorities (access, on-site, information)
- Termination triggers (breach, regulatory breach, insolvency, performance deterioration)
- Provider participation in financial entity's ICT awareness programmes + TLPT exercises
- **Documented exit strategy per contract** (see below)
- Incident-response cooperation

**Sub-outsourcing controls (Article 30(2), (3), and Article 30(5) RTS):**
- Pre-notification of any planned sub-outsourcing of CIF services
- Financial entity's right to object to sub-outsourcing changes
- Sub-outsourcing chain visibility in the Register

Detailed contractual policies are in **Commission Delegated Regulation (EU) 2024/1773** (RTS on contractual policies for critical/important functions) + the current Level 2 RTS on sub-outsourcing adopted under Article 30(5).

### Exit Strategy (Article 28(8))
Standalone artefact for **every contract supporting a critical or important function**:

- Documented plan for provider failure, deteriorating service, termination, supervisory direction
- Identified alternative provider or in-house capability
- Data extraction + migration plan with realistic timeline
- Periodic testing (at least desktop walkthrough; full migration where feasible)

## Pillar 5 — Information Sharing (Article 45)

Voluntary participation in cyber-threat information-sharing arrangements. Notification to NCA on entry + withdrawal. GDPR-compatible processing arrangements for any personal data shared.

## Critical ICT Third-Party Providers / CTPPs (Articles 31–44)

A separate regime for *vendors*, not financial entities. CTPP designation is a **finding** by the ESAs against the criteria in **Commission Delegated Regulation (EU) 2024/1502** (systemic impact, criticality of services, substitutability, interconnectedness) — not a voluntary opt-in.

### Lead Overseer Mechanics
- Lead Overseer assigned: **EBA, ESMA, or EIOPA** depending on sectoral mix of the CTPP's customer base (which financial-entity sectors dominate)
- **Notification** of designation; right to be heard within the deadline
- **Annual oversight fee** *(Article 43)*
- Full cooperation with information requests, general investigations, on-site inspections
- Annual oversight plan from Lead Overseer
- Sub-contracting transparency — full chain disclosed
- Lead Overseer recommendations addressed within prescribed deadlines

### CTPP Penalty Exposure *(Article 35(6))*
**Periodic penalty payments of up to 1% of average daily worldwide turnover** in the preceding business year, **per day, for up to 6 months**, until compliance is achieved. Separately, administrative penalties for CTPP infringements are imposed by NCAs under **Article 50**.

## Supervision & Penalties for Financial Entities

DORA does **not** create a unified penalty regime for financial entities. NCAs use their **sectoral powers** to enforce DORA compliance:

| Entity type | Penalty hook | Indicative max |
|---|---|---|
| **CASP (MiCA)** | MiCA Article 111 — general infringements (Arts 67–73 are ICT/organisational) | **€5M** or **3%** of annual turnover (legal person) |
| **Credit institution (CRD)** | CRD Articles 65–67 / national transposition | Up to **10%** of total annual net turnover |
| **Investment firm (MiFID II)** | MiFID II Article 70 / national transposition | Up to **10%** of total annual turnover |
| **PI / EMI (PSD2/PSD3)** | PSD2 Article 103 / national transposition | National maxima — varies |
| **Insurance (Solvency II)** | National transposition | Varies |

> [!warning] The "2% of turnover under DORA" myth
> The frequently-cited "2% of turnover under DORA" figure (including in [[EU-Fintech-Compliance-Landscape]] and most secondary sources) is a *practical* approximation derived from sectoral penalty regimes — **not a DORA Level 1 article**. The only directly DORA-imposed penalty regime is the Article 35(6) periodic-penalty-payment cap of 1% of daily worldwide turnover for CTPPs (vendors), not financial entities. Frame this correctly in board materials so the conversation lands at the right risk level.

## Sectoral Integration

### MiCA / CASP — [[MiCA-NCA-Authorization-Mechanics]]
- DORA is the substantive mechanism for satisfying **MiCA Articles 34(10)** (ART issuers) and **68(7)–(8)** (CASPs) — **NOT** Article 66 (which is conduct-of-business)
- At-authorisation: NCA expects the ICT framework, incident reporting workflow, basic testing programme, third-party Register, and exit strategies to be at least in design before MiCA authorisation is granted — **one process, not two**
- Post-authorisation: DORA enforcement is **independent**. Don't rely on the MiCA cross-reference as your DORA reference once operational

### MiFID II / DLT Pilot Regime — [[MiFID-II-NCA-Authorization-Mechanics]]
- For Segment 1 RWA tokenisation platforms, DORA reaches the entity via **MiFID II investment-firm classification or DLT Pilot Regime trading-venue / SS / TSS authorisation**, not via MiCA
- DLT Pilot Regime exemptions to settlement / transparency rules **do not extend to DORA** — DORA applies in full

### PSD3 / PSR
- DORA absorbs the PSD2 Article 96 operational and security incident reporting regime *(Article 23)*
- Single ICT and security framework covers both PSD3 and DORA — no parallel frameworks
- SCA controls under PSD3 sit within the DORA framework, not separate from it

### NIS2 Interaction
DORA is *lex specialis* for financial entities. **NIS2 Article 4(1)** carves DORA out where it imposes substantively equivalent obligations on cybersecurity risk management and incident notification — the substantive obligations and supervision/enforcement in NIS2 Chapter VII do not apply. **But NIS2 is not displaced in its entirety** — entity-identification, registration in national NIS2 registries, and cooperation with national CSIRTs may still bite depending on Member State transposition. Group-level interactions: non-financial group entities (holding companies, technology subsidiaries) may still fall directly under NIS2 even where the regulated affiliate falls under DORA.

## Application Timeline

| Date | Milestone | Source |
|---|---|---|
| 27 Dec 2022 | DORA published in OJ L 333 | — |
| 16 Jan 2023 | Entered into force (20 days after publication) | Art 64(1) |
| **17 Jan 2025** | **DORA fully applicable** to all in-scope financial entities | Art 64(2) |
| 17 Jan 2025 onwards | First Register of Information submission cycle | Art 28(3) + ITS |
| 2025 onwards | First CTPP designations by the ESAs | Art 31 |
| 2025–2026 | First TLPT cycles for designated entities | Arts 26–27 |

No transitional period for new entrants. Level 2 RTS / ITS continue to be issued and refined by the ESAs / Commission.

## Key Level 2 Cross-References

| Instrument | Subject | DORA hook |
|---|---|---|
| **Commission Delegated Regulation (EU) 2024/1772** | Major-incident + cyber-threat classification | Art 18 |
| **Commission Delegated Regulation (EU) 2024/1773** | Contractual policies for critical/important ICT services | Arts 28, 30 |
| **Commission Delegated Regulation (EU) 2024/1774** | ICT risk management framework + simplified framework | Arts 15, 16 |
| **Commission Delegated Regulation (EU) 2024/1502** | CTPP designation criteria | Art 31 |
| **Commission Implementing Regulation (EU) 2024/2956** | Register of Information templates | Art 28(9) |
| **Commission Delegated Regulation (EU) 2025/295** | TLPT specification | Art 26(11) |
| Harmonised reporting RTS / ITS under Art 20 | Incident reporting content + templates + timing | Arts 19, 20 |
| RTS on sub-outsourcing under Art 30(5) | Sub-outsourcing controls | Art 30 |

## InnBlockchain Service Mapping

Every DORA Pillar maps to a deliverable InnBlockchain can ship at the smart-contract / ICT-architecture layer:

| DORA Requirement | InnBlockchain Deliverable |
|---|---|
| Article 6 ICT risk management framework | Framework drafting aligned to Commission Delegated Regulation (EU) 2024/1774 |
| Article 8 Critical or important function identification | Smart-contract dependency mapping — which contracts support CIFs, which don't |
| Article 9 Protection + prevention | Multi-sig governance for protocol upgrades; cryptography policy review |
| Article 12 Backup + immutability | Backup + key custodianship architecture meeting Article 12 standards |
| Article 18 Incident classification (Reg 2024/1772) | Structured event schema for incident classification; SIEM/SOAR integration |
| Articles 19–20 Reporting workflow | Automated triage from contract events to incident-report draft fields |
| Article 25 Basic testing battery | Independent smart contract security audit suitable for inclusion in the annual battery |
| Articles 26–27 TLPT (if applicable) | TLPT-readiness assessment for protocol-layer dependencies |
| Article 28(3) Register of Information | Register template configuration for protocol-layer dependencies |
| Articles 30(2)–(3) Contractual provisions | Article 30-aligned templates for protocol vendor + oracle + custody contracts |
| Article 28(8) Exit strategy | Exit-strategy stress test for protocol-layer dependencies (oracles, bridges, custodians) |

Primary fit: **all CASP-classified segments** (Crypto Native Seg 2–10 + FinTech ExchangeTech / WalletTech-with-crypto / BankTech-with-crypto), **Seg 1 RWA** via MiFID II / DLT Pilot Regime pathway, and **all FinTech segments** holding a sectoral licence that puts them in Article 2 scope (BankTech, InsurTech, WealthTech, PayTech, LendTech-if-licensed).

## Open Items / Tensions

- **Harmonised reporting RTS / ITS timing under Article 20** has moved across drafts. Cite the current consolidated version on EUR-Lex before relying on specific hour-counts.
- **The 2% turnover figure for financial entities** is a sectoral derivative, not a DORA Level 1 cap — see Supervision & Penalties section above.
- **CTPP designation list** is published on the ESAs' Joint Committee page and updates faster than this doc will. Re-check before relying on a specific designation.
- **NIS2 displacement** is obligation-level, not blanket — Member State transposition determines residual registration / CSIRT-cooperation duties.

> [!gap] This page is derived from `.raw/InnBlockchain/EU Compliance/dora-checklist.md` (v1.1, hash `7846555f77db1b3eac861b5ab510385a`). The article-level claims are training-data-grounded against my knowledge of Regulation (EU) 2022/2554, but **the EUR-Lex source was unreachable at ingest time** (AWS WAF JS challenge blocked WebFetch, curl, and defuddle). Same constraint as the May 24 MiCA verification — the difference is MiCA fell back to a Wayback-archived snapshot; DORA was built without a verbatim cross-check pass. Treat Level 2 RTS citations (Delegated Regulations 2024/1502, 2024/1772, 2024/1773, 2024/1774, 2025/295, Implementing Regulation 2024/2956) as the most likely to drift — ESAs Joint Committee has amended several since first OJ publication. Cross-validate against ESMA / EBA / EIOPA publications and home-NCA-specific guidance before any real filing.
