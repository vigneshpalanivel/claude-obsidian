---
type: concept
title: "DORA — Digital Operational Resilience Act"
created: 2026-04-16
updated: 2026-04-16
tags:
  - DORA
  - EU
  - compliance
  - cybersecurity
  - ICT
  - fintech
status: current
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[EU-AI-Act-Fintech]]"
  - "[[MiCA-Regulation]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# DORA — Digital Operational Resilience Act

DORA (Regulation (EU) 2022/2554) is the EU's unified framework requiring financial entities to manage ICT (Information and Communications Technology) risks and maintain digital operational resilience. It entered force on **January 17, 2025**.

## Who Must Comply

DORA applies to **over 22,000 financial entities** across the EU, including:
- Banks and credit institutions
- Payment institutions and e-money institutions
- Investment firms
- Insurance and reinsurance undertakings
- Crypto-asset service providers (CASPs under MiCA)
- Credit rating agencies
- Crowdfunding service providers
- **Critical third-party ICT providers** (cloud services, data analytics, SaaS vendors supplying financial entities)

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
- Map all ICT vendor relationships (register required)
- Renegotiate vendor contracts to include DORA-mandatory clauses (exit rights, audit rights, SLAs, sub-contracting disclosure)
- Critical Third-Party Providers (CTPPs) face direct supervision by EU financial supervisors (ECB, ESMA, EIOPA, EBA)
- **Most impactful for fintechs**: Heavy third-party dependency (cloud infrastructure, payments APIs, compliance SaaS) means extensive contract renegotiation

### 5. Information and Intelligence Sharing
- Voluntary: financial entities can share cyber threat information with industry peers
- Supervised by NCAs; protects sharing parties from liability in most cases

## Penalties

| Violation | Maximum Penalty |
|-----------|----------------|
| Financial entity breach | **2% of total global annual turnover** |
| Critical third-party (CTPP) daily violation | **1% of average daily global turnover** |
| CTPP persistent breach (max 6 months) | **Up to €5 billion** |

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

> [!gap] DORA's definition of "significant entity" eligible for TLPT is delegated to NCAs — thresholds vary by member state and have not been fully published as of Q1 2026.
