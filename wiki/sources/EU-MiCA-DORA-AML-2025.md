---
type: source
title: "EU MiCA, DORA, and AML Regulations: 2025 Deep Dive"
created: 2026-04-16
updated: 2026-05-20
source_type: web-research + internal-checklist
url: https://www.innreg.com/blog/dora-regulation-explained
confidence: high
tags:
  - MiCA
  - DORA
  - AML
  - AMLA
  - EU
  - compliance
  - source
key_claims:
  - DORA in force January 2025; penalties up to 2% of total annual turnover
  - MiCA fully applicable January 2025; transitional period ends 1 July 2026
  - 65% of EU-based crypto businesses MiCA-compliant by Q1 2025
  - Over EUR 540M in MiCA fines since implementation; 50+ licenses revoked
  - AMLA commenced operations July 2025; full supervision 2028
  - EU AML rulebook directly applicable across all member states from July 2027
  - CASP capital tiers Class 1 €50k / Class 2 €125k / Class 3 €150k
  - ART issuer floor €350k or 2% reserves or 25% overheads (higher of)
  - White papers must be iXBRL-format from 23 December 2025
  - MiCA Article 66 cross-references DORA — one regulatory process, not two
internal_sources:
  - path: ".raw/InnBlockchain/EU Compliance/mica-checklist.md"
    hash: "79a90bdf14e17887faa9dcb048c5b7f4"
    ingested: 2026-05-20
    type: practitioner-checklist
    purpose: "Pre-NCA-application readiness assessment authored by InnBlockchain for MiCA-bound founders"
---

# EU MiCA, DORA, and AML Regulations: 2025 Deep Dive

## Source Summary

Research across InnReg, ESMA, EIOPA, DLA Piper, Mayer Brown, Lucinity, Anankai, and Norton Rose Fulbright covering the three most technically demanding EU fintech compliance frameworks.

---

## DORA — Digital Operational Resilience Act

### What It Is
EU regulation requiring all financial entities to withstand, respond to, and recover from ICT-related disruptions and cyberattacks. Entered force **January 17, 2025**.

### Who It Applies To
Banks, payment institutions, e-money institutions, investment firms, insurance companies, crypto-asset service providers, credit rating agencies, and — critically — their **critical third-party ICT providers** (cloud providers, data analytics firms, SaaS vendors).

### Five Pillars of Compliance

| Pillar | Requirement |
|--------|------------|
| ICT Risk Management | Documented risk frameworks; policies for threat identification, protection, detection, response, and recovery |
| Incident Reporting | Major incidents reported to competent authority within hours; standard classification criteria |
| Digital Resilience Testing | Basic testing for all; advanced Threat-Led Penetration Testing (TLPT) for significant entities |
| Third-Party Risk | Map all ICT vendor dependencies; renegotiate contracts to include DORA clauses; register critical providers |
| Information Sharing | Voluntary intelligence sharing about cyber threats with industry peers |

### Penalties
Up to **2% of total global annual turnover** for firms; up to **1% of average daily global turnover** per violation day for critical third parties.

### 2026 Outlook
Supervisors treated 2025 as a transition/review year. Stricter enforcement and formal audits expected throughout 2026. Fintechs with heavy third-party dependency (common model) face the highest DORA compliance lift.

---

## MiCA — Markets in Crypto-Assets Regulation

### What It Is
Single EU regulatory framework for crypto-asset service providers (CASPs) and issuers of crypto-assets (including stablecoins). Replaces the patchwork of 27 national regimes.

### Implementation Timeline

| Date | Event |
|------|-------|
| June 2023 | MiCA entered into force |
| June 2024 | Stablecoin provisions (ARTs, EMTs) applicable |
| December 2024 | CASP provisions fully applicable |
| January 2025 | Fully applicable in all EU member states |
| End 2025 | Spain transition deadline (12-month) |
| June 2026 | General transitional period ends; all CASPs must be licensed |

### Key Requirements for CASPs

- Obtain authorization from home-state National Competent Authority (NCA)
- Comply with AML/KYC including the Travel Rule for crypto transfers
- Meet capital and insurance requirements
- Publish whitepapers for crypto-assets offered
- Implement reserve requirements for stablecoin issuers
- Report market abuse to ESMA

### Compliance Status (Q1 2025)
- **65%** of EU-based crypto businesses MiCA-compliant
- Germany, France, Netherlands: **90%+** compliant
- Greece, Portugal, Ireland: only **50-60%** compliant
- **€540M+** in fines issued since implementation
- **50+** licenses revoked (primarily for AML/KYC or reserve requirement failures)

---

## EU AML Package — AMLR + AMLA

### The New Framework (Three-Part Package)

| Instrument | Role |
|-----------|------|
| **AMLR** (Anti-Money Laundering Regulation) | Single AML rulebook directly applicable across all EU member states (no national transposition needed) |
| **AMLD6** (6th AML Directive) | Governs national supervisory structures; replaces AMLD4/5 |
| **AMLA Regulation** | Establishes Anti-Money Laundering Authority as EU's central AML supervisor |

### Key Dates

- **July 2025**: AMLA commences operations in Frankfurt
- **2026**: Technical standards on CDD, risk classification, and transaction monitoring finalized
- **July 2027**: AMLR becomes directly applicable across all member states
- **2028**: AMLA takes over direct supervision of highest-risk cross-border financial institutions

### Expanded Scope for Fintechs
The AMLR extends AML obligations to previously unregulated entities:
- Crypto-asset service providers (aligned with MiCA CASP definition)
- Crowdfunding platforms
- Mortgage credit intermediaries
- Consumer credit lenders
- Certain luxury goods dealers and real estate agents

### Key AML Compliance Requirements (2025+)
- Automated transaction monitoring systems with AI support
- Transaction scoring and AML filters for sanctions lists
- PEP (Politically Exposed Person) monitoring
- Continuous operation analysis and unusual pattern detection
- Immediate reporting of suspicious activities (STRs)
- Travel Rule compliance for crypto transfers

### GDPR Tension
AMLA must balance effective data sharing with EU GDPR requirements. Effective AML supervision requires extensive cross-border data collection and analysis; GDPR imposes strict limits on personal data processing. Resolving this tension is a live governance challenge.

## Sources

- [DORA Regulation Explained](https://www.innreg.com/blog/dora-regulation-explained) — InnReg, 2025
- [MiCA: EU Crypto Compliance Guide](https://www.cyfrin.io/blog/mica-regulation-explained-a-guide-to-eu-crypto-compliance) — Cyfrin, 2025
- [EU AMLA Regulation Explained 2026](https://www.anankai.com/eu-anti-money-laundering-authority-amla-in-2026/) — Anankai, 2026
- [EU's New AML Package 2025](https://lucinity.com/blog/the-eus-new-aml-package-what-financial-institutions-need-to-know-for-2025) — Lucinity, 2025
- [MiCA Regulations Statistics 2025](https://coinlaw.io/eu-mica-regulations-statistics/) — CoinLaw, 2025

---

## Addendum — Internal MiCA Readiness Checklist (Ingested 2026-05-20)

**Source:** `.raw/InnBlockchain/EU Compliance/mica-checklist.md` (hash `79a90bdf14e17887faa9dcb048c5b7f4`)
**Type:** Internal InnBlockchain practitioner artifact — pre-NCA-application readiness assessment, 12 sections, scorecard format, written from the perspective of "what a specialist EU crypto-reg lawyer walks a founder through in a first intake meeting."
**Why it lives here**: per ingest instruction, no separate source page; the operational detail it contributes was integrated into [[MiCA-Regulation]] under the "Practitioner Detail" section.

### What the Checklist Adds (Beyond the 2025 Web Research)

Web research above is macro (timeline, penalties, compliance rate). The internal checklist is micro (article-level requirements, capital math, dossier contents). The two are complementary, not duplicative.

**New material integrated into [[MiCA-Regulation]]:**

1. **CASP capital class structure** — Class 1 / 2 / 3 with explicit service-to-amount mapping (€50k / €125k / €150k); 25% prior-year overheads override always live.
2. **ART capital formula** — €350k or 2% of average reserve assets or 25% overheads, whichever is highest. Stress-testing buffer (Article 35(5)) can add 20–40%. No-yield rule (Article 40).
3. **EMT prerequisite** — must be authorized as a credit institution or EMI; standard CASP authorization alone is insufficient. 30% bank-deposit floor (60% for significant EMTs).
4. **White paper exemptions** (Articles 4–5): <150 persons per Member State, <€1M / 12 months, qualified investors only, free distribution. ART white papers need prior NCA approval — Title II white papers do not.
5. **iXBRL format mandate** — from 23 December 2025. Document-prep toolchain must support this before filing.
6. **Article 74 wind-down plan** — distinct from BCP; mandatory dossier item; documents client-asset return and per-service-line cessation.
7. **Article 70(3) client fiat placement** — end-of-day-following-receipt at credit institution or central bank, segregated account. Banking relationship must exist pre-launch.
8. **Article 66 ↔ DORA cross-reference** — clarified that DORA readiness is assessed by the NCA as part of MiCA authorization, not by a separate regulator. One process, not two.
9. **Significance thresholds detail** (Articles 43–44) — six criteria, ≥3 triggers reclassification, EBA supervision replaces NCA.
10. **Application timeline** — 25 working days completeness check + 40+ working days substantive review; 6–12 months realistic total.
11. **Active NCA list** — AMF (FR), BaFin (DE), AFM (NL), CBI (IE), Bank of Lithuania.
12. **14-day right of withdrawal** — Title II crypto-assets bought retail directly from issuer.

### Tensions / Open Items Flagged During Ingest

- **"InnBlockchain reads as the wrong author"** for some claims (e.g., decisions an NCA reviewer would make) — but the checklist explicitly positions itself as the *intake checklist a lawyer uses*, not as legal opinion. Acceptable framing.
- The checklist asserts Article 66 satisfies DORA via cross-reference. This is correct for MiCA-side authorization, but DORA also has independent supervisory enforcement once the firm is live — the checklist is silent on post-authorization DORA inspections. Not a contradiction, but worth noting if used as the only DORA reference.
- The transitional deadline is given as 1 July 2026 in the checklist and "June 2026" in earlier web research. The checklist's specific date is authoritative — sourced from MiCA Articles 143–149.
- iXBRL date (23 Dec 2025) is new vs. earlier 2025 research — confirm via ESMA RTS publication if used in client-facing material.
