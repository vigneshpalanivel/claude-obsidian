---
type: concept
title: "EU AML Package and AMLA"
created: 2026-04-16
updated: 2026-04-16
tags:
  - AML
  - AMLA
  - EU
  - compliance
  - KYC
  - fintech
status: current
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[MiCA-Regulation]]"
  - "[[Blockchain-Fintech-Solutions]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain Crypto Native ICP]]"
---

# EU AML Package and AMLA

The EU's 2024 Anti-Money Laundering (AML) package is the most significant overhaul of EU AML/CFT (Counter-Financing of Terrorism) law since AMLD4. It creates a single AML rulebook and a central EU supervisor for the first time.

## The Three-Part Package

| Instrument | Legal Form | Effect |
|-----------|-----------|--------|
| **AMLR** (Anti-Money Laundering Regulation) | EU Regulation | Directly applicable single rulebook; no national transposition |
| **AMLD6** (6th AML Directive) | EU Directive | Governs national supervisory structures; replaces AMLD4/5 |
| **AMLA Regulation** (Reg. EU 2024/620) | EU Regulation | Establishes Anti-Money Laundering Authority |

## Timeline

| Date | Event |
|------|-------|
| June 2024 | AMLA Regulation (EU 2024/620) adopted |
| **July 2025** | AMLA commences operations (Frankfurt) |
| 2026 | Technical standards on CDD, risk classification, transaction monitoring finalized |
| **July 10, 2027** | AMLR becomes directly applicable across all member states |
| **2028** | AMLA takes over direct supervision of highest-risk cross-border financial institutions |

## AMLA — The New Central Supervisor

AMLA (Anti-Money Laundering Authority) is headquartered in Frankfurt. Key powers:
- **Direct supervision** of obliged entities deemed highest-risk and cross-border (selected group of ~40 entities initially)
- **Indirect supervision**: setting binding standards, resolving disputes between NCAs, coordinating joint investigations
- Does NOT replace national supervisors — redefines their role within a unified model

## Who Is Newly In Scope (AMLR Expansion)

The AMLR extends AML obligations beyond traditional banking to:
- Crypto-asset service providers (aligned with MiCA definition)
- Crowdfunding service providers
- Mortgage credit intermediaries
- Consumer credit providers
- Real estate agents and luxury goods dealers above thresholds
- Football clubs with foreign player transfers above thresholds
- Certain professional services (accountants, lawyers, notaries)

## Key AML Compliance Obligations (2025+)

### Customer Due Diligence (CDD)
- Simplified, standard, or enhanced CDD based on risk classification
- Continuous monitoring — not just onboarding
- Ultimate Beneficial Ownership (UBO) verification mandatory

### Transaction Monitoring
- Fully automated systems required (AI-supported)
- Transaction scoring against typology rules
- Sanctions list screening (daily at minimum under IPR requirements)
- PEP (Politically Exposed Person) monitoring
- Immediate STR (Suspicious Transaction Report) filing

### Travel Rule (Crypto)
From 2025, all crypto transfers (even below €1,000) require originator and beneficiary information to accompany the transaction — implementing FATF Travel Rule in EU law via Transfer of Funds Regulation (TFR).

### Cash Transaction Limits
EU-wide cash payment limit of **€10,000** (Article 80, AMLR) — member states may set lower limits.

## GDPR vs. AML Tension

A fundamental conflict: GDPR mandates data minimization and restricts cross-border personal data transfers; effective AML supervision requires extensive data collection, cross-institution sharing, and cross-border exchange.

Resolution still being negotiated in AMLA governance design. Data-protection-by-design requirements in AMLR are still being interpreted alongside GDPR Article 6 legitimate basis for AML processing.

> [!gap] AMLA technical standards on CDD risk classification, transaction monitoring thresholds, and cross-border data sharing rules are being finalized through 2026. Exact requirements may shift before July 2027 applicability.

## Impact on InnBlockchain

- **Crypto Native ICP**: Every EU-facing crypto platform needs Travel Rule implementation — direct smart contract compliance work
- **FinTech ICP**: Compliance Carol (CCO veto-holder) is specifically focused on AML obligations; vendor risk pack must include AMLR technical readiness
- **Content**: "AMLR for Crypto Platforms" and "Travel Rule Smart Contract Implementation" are high-value content opportunities (flagged in InnBlockchain Crypto Native Content Strategy)
