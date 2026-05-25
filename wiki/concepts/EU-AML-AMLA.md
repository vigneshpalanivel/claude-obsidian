---
type: concept
title: "EU AML Package and AMLA"
created: 2026-04-16
updated: 2026-05-25
tags:
  - AML
  - AMLA
  - EU
  - compliance
  - KYC
  - fintech
status: current
related:
  - "[[EU-AML-AMLA-Supervision-Mechanics]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[MiCA-Regulation]]"
  - "[[TFR-Regulation]]"
  - "[[DORA-Regulation]]"
  - "[[eIDAS-2.0]]"
  - "[[Blockchain-Fintech-Solutions]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain Crypto Native ICP]]"
---

# EU AML Package and AMLA

The EU's 2024 Anti-Money Laundering (AML) package is the most significant overhaul of EU AML/CFT (Counter-Financing of Terrorism) law since AMLD4. It creates a single AML rulebook and a central EU supervisor for the first time.

> [!info] Practitioner detail
> Article-level mechanics — Art. 3 obliged-entity classification, CDD trigger granularity, beneficial-ownership tracks, STR mechanics, two-stage AMLA selection, sanctions exposure, cross-regime interactions — live in the companion practitioner page [[EU-AML-AMLA-Supervision-Mechanics]]. This page is the strategic / "what-is-the-package" layer.

## The Three-Part Package

| Instrument | Legal Form | Effect |
|-----------|-----------|--------|
| **AMLR** — Regulation (EU) **2024/1624** | EU Regulation | Directly applicable single rulebook; no national transposition |
| **AMLD6** — Directive (EU) **2024/1640** | EU Directive | Replaces AMLD4/5; governs national supervisor + FIU + BO register architecture; transposed by Member States |
| **AMLA Regulation** — Regulation (EU) **2024/1620** | EU Regulation | Establishes the EU Anti-Money Laundering Authority in Frankfurt |

All three were published in OJ on **19 June 2024** and entered into force on **9 July 2024** (20 days later).

> [!warning] Three coupled instruments doing three different jobs
> **AMLR** tells you *what to do* (CDD, beneficial ownership, STR, cash limits). **AMLD6** tells you *how you'll be sanctioned and who supervises you* — lives in your Member State's transposed law. **AMLA Regulation** creates the EU supervisor, but AMLA *directly supervises* only a narrow set of large cross-border banks and CASPs ("selected obliged entities" — see [[EU-AML-AMLA-Supervision-Mechanics]]).

## Timeline

| Date | Event |
|------|-------|
| 19 Jun 2024 | All three instruments published in OJ |
| 9 Jul 2024 | AMLR + AMLD6 enter into force |
| 1 Jul 2025 | AMLA commences operations (Frankfurt) |
| 10 Jul 2025 | AMLD6 Art. 74 (BO register access + legitimate-interest framework) — transposition deadline |
| 10 Jul 2026 | AMLD6 Arts 11–13, 15 (BO register infrastructure) — transposition deadline |
| 2027 | AMLA first selection cycle — list of "selected obliged entities" published |
| **10 Jul 2027** | **AMLR becomes directly applicable + AMLD6 general transposition deadline** |
| 2028 | AMLA takes over direct supervision of selected obliged entities |
| 10 Jul 2029 | AMLD6 Art. 18 (Single access point to real estate information) — transposition deadline; AMLR application to football agents + clubs (Art. 90) |

## AMLA — The New Central Supervisor

AMLA (Anti-Money Laundering Authority) is headquartered in Frankfurt, operational since 1 July 2025. Key powers:

- **Direct supervision** of selected obliged entities — credit institutions and financial institutions assessed under Art. 12 (operating in ≥6 Member States) whose residual risk profile is classified as high under Art. 13. **40-entity capacity cap** with discretion to expand; selection priority by cross-border footprint and third-country transaction ratio.
- **Indirect supervision** of all other obliged entities via RTS/ITS development (Commission delegated/implementing acts on AMLA drafts), peer reviews of national supervisors, convergence work, and FIU coordination
- AMLA does NOT replace national supervisors — for non-selected entities (most InnBlockchain segments), the operational counterpart remains the national supervisor under AMLD6 transposition

See [[EU-AML-AMLA-Supervision-Mechanics]] for the full two-stage selection mechanism and direct-supervisory powers under Arts 17–23.

## Who Is Newly In Scope (AMLR Article 3 Expansion)

The AMLR extends AML obligations beyond traditional banking to **17 obliged-entity categories** under Article 3, including these new or expanded categories:

- **Crypto-asset service providers (CASPs)** — aligned with MiCA Title V definition; explicitly enumerated as an assessment category at AMLA Art. 12(4)(j)
- **Crowdfunding service providers** + crowdfunding intermediaries
- **Credit intermediaries for mortgage and consumer credits**
- **Real estate agents** including letting (monthly rent ≥€10,000)
- **Dealers in precious metals/stones, high-value goods, cultural goods** (≥€10,000 trigger for some categories)
- **Investment migration operators** *(new — "golden visa" intermediaries)*
- **Non-financial mixed activity holding companies** *(new)*
- **Professional football clubs + football agents** *(new — application delayed to 10 July 2029 under Art. 90)*
- Auditors, accountants, tax advisors, notaries, lawyers, TCSPs

**Not in scope**: pure technology / RegTech / SaaS vendors are NOT obliged entities — their AML exposure flows through their FI customers' Art. 3 obligations. Pure P&C insurance is also out (only life + investment-related insurance is in scope).

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
