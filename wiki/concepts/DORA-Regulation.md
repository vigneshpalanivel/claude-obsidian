---
type: concept
title: "DORA — Digital Operational Resilience Act"
created: 2026-04-16
updated: 2026-05-24
tags:
  - DORA
  - EU
  - compliance
  - cybersecurity
  - ICT
  - fintech
status: current
related:
  - "[[DORA-NCA-Supervision-Mechanics]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[EU-AI-Act-Fintech]]"
  - "[[MiCA-Regulation]]"
  - "[[MiCA-NCA-Authorization-Mechanics]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# DORA — Digital Operational Resilience Act

DORA (Regulation (EU) 2022/2554) is the EU's unified framework requiring financial entities to manage ICT (Information and Communications Technology) risks and maintain digital operational resilience. It **entered into force 16 January 2023** and **became fully applicable on 17 January 2025** *(Article 64)*.

> [!info] Practitioner detail
> Article-level requirements (Pillar artefacts, Register of Information mechanics, TLPT scoping, contractual provisions, sectoral integration, Level 2 RTS cross-references) live in the companion practitioner page [[DORA-NCA-Supervision-Mechanics]]. This page is the strategic / "what-is-DORA" layer.

> [!warning] DORA is not an authorisation regime
> There is no "DORA licence." DORA applies automatically to in-scope financial entities by virtue of their sectoral authorisation (MiCA, MiFID II, CRD/CRR, PSD2/PSD3, Solvency II) and is supervised by the same NCA that authorises the underlying business.

## Who Must Comply

DORA applies to **over 22,000 financial entities** across the EU. The full Article 2(1) list runs to ~20 categories, including:
- Banks and credit institutions
- Payment institutions and e-money institutions, AISPs
- Investment firms (MiFID II) — including DLT MTF / SS / TSS under the DLT Pilot Regime
- Insurance and reinsurance undertakings, IORPs (subject to size carve-outs)
- **Crypto-asset service providers (CASPs) authorised under MiCA**; **issuers of asset-referenced tokens (ARTs)**
- CSDs, CCPs, trade repositories, AIFMs, UCITS ManCos, data reporting service providers
- Credit rating agencies, administrators of critical benchmarks, ECSPs, securitisation repositories

**Critical ICT Third-Party Providers (CTPPs)** are governed by a **separate regime** under Articles 31–44 — they are not "financial entities" under DORA but are designated by the ESAs and supervised directly by a Lead Overseer (EBA, ESMA, or EIOPA depending on sectoral mix). Most cloud, data, and SaaS vendors are *not* CTPPs unless formally designated. See [[DORA-NCA-Supervision-Mechanics]] for the CTPP track and Commission Delegated Regulation (EU) 2024/1502 for designation criteria.

## The Five Pillars

### 1. ICT Risk Management
- Documented risk management framework covering identification, protection, detection, response, and recovery
- Board-level accountability for ICT risk
- Business continuity plans and disaster recovery procedures

### 2. ICT-Related Incident Reporting
- **Major incident classification** criteria are standardized across EU
- Timeline: Initial notification → Intermediate report → Final report
- Reports go to home-state National Competent Authority (NCA)
- Significant cyber threats must also be reported voluntarily

### 3. Digital Operational Resilience Testing
- **Basic testing**: All in-scope entities (vulnerability assessments, network security tests)
- **Advanced TLPT (Threat-Led Penetration Testing)**: Required for significant entities every 3 years; modeled on TIBER-EU framework; involves red team testing of live systems

### 4. Third-Party ICT Risk Management
- Map all ICT vendor relationships (**Register of Information** — submitted annually to NCA via Commission Implementing Regulation (EU) 2024/2956 template)
- Renegotiate vendor contracts to include DORA-mandatory clauses per Article 30 (exit rights, audit rights, SLAs, sub-contracting disclosure)
- Critical Third-Party Providers (CTPPs) face direct supervision by a **Lead Overseer — EBA, ESMA, or EIOPA** (assigned by sectoral mix). ECB is *not* a DORA Lead Overseer; ECB's role is via the SSM for credit institutions
- **Most impactful for fintechs**: Heavy third-party dependency (cloud infrastructure, payments APIs, compliance SaaS) means extensive contract renegotiation. The Register of Information is the operationally heaviest artefact — most entities under-budget it by 3–5×

### 5. Information and Intelligence Sharing
- Voluntary: financial entities can share cyber threat information with industry peers
- Supervised by NCAs; protects sharing parties from liability in most cases

## Penalties

DORA does **not** create a unified penalty regime for financial entities — NCAs enforce via **sectoral powers** (MiCA Article 111 for CASPs; CRD Articles 65–67 for banks; MiFID II Article 70 for investment firms; etc.). The frequently-cited "2% turnover under DORA" figure is a **sectoral approximation**, not a DORA Level 1 cap. Practical maxima vary by entity type — CRD/MiFID II reach 10% of annual turnover, MiCA 3%-15% by infringement tier.

The only DORA-Level-1 direct penalty applies to **CTPPs** under Article 35(6):

| Violation | Maximum Penalty | Source |
|-----------|----------------|---|
| Financial entity DORA breach | **Via sectoral law** (MiCA 3%, CRD 10%, MiFID II 10%, etc.) | National transposition |
| CTPP — periodic penalty payment | **Up to 1% of average daily worldwide turnover, per day, for up to 6 months** until compliance | DORA Article 35(6) |
| CTPP — administrative penalties | Imposed by NCAs | DORA Article 50 |

See [[DORA-NCA-Supervision-Mechanics]] for the full sectoral-penalty mapping.

## Enforcement Status (2025-2026)

- **2025**: Supervisors reviewing frameworks, identifying gaps, setting expectations
- **2026**: Active enforcement begins; formal audits expected; "significant lapses" will trigger penalties
- Fintechs with complex third-party stacks face the highest compliance lift

## Common Compliance Gaps (Fintechs)

1. **Undocumented vendor dependencies**: Most fintechs use 20-100 SaaS tools; few have a complete ICT register
2. **Vendor contract gaps**: Existing cloud/SaaS contracts rarely include DORA-mandated clauses
3. **Incident classification**: Teams don't have pre-defined criteria for "major incident" triggering mandatory reporting
4. **TLPT readiness**: Significant entities haven't budgeted for red team exercises

## DORA + AI Act Intersection

AI systems used for fraud detection, credit scoring, or AML (classified as high-risk under the EU AI Act) must satisfy BOTH:
- AI Act: conformity assessments, human oversight, documentation
- DORA: resilience testing, incident reporting, third-party oversight of AI vendors

Two separate compliance programs for the same systems.

> [!info] TLPT scope is now specified by Level 2 RTS
> Earlier guidance noted that the "significant entity" definition for TLPT was delegated to NCAs without published thresholds. The criteria are now specified in **Commission Delegated Regulation (EU) 2025/295**. Practitioner detail in [[DORA-NCA-Supervision-Mechanics]].
