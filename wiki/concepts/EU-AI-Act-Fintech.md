---
type: concept
title: "EU AI Act — Fintech Compliance"
created: 2026-04-16
updated: 2026-04-16
tags:
  - AI-Act
  - EU
  - fintech
  - compliance
  - high-risk-AI
status: current
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[DORA-Regulation]]"
  - "[[Blockchain-Fintech-Solutions]]"
  - "[[Smart-Contracts-Finance]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# EU AI Act — Fintech Compliance

The EU Artificial Intelligence Act (Regulation 2024/1689) is the world's first comprehensive AI regulation. It entered into force in August 2024, with staggered enforcement timelines based on risk tier. For fintechs, the critical deadline is **August 2, 2026** — when high-risk AI system requirements become enforceable.

## Risk Tiers

| Tier | Definition | Fintech Examples | Status |
|------|-----------|-----------------|--------|
| **Unacceptable risk** | AI that poses clear threats to fundamental rights | Social scoring of citizens, subliminal manipulation | **Banned from Feb 2, 2025** |
| **High-risk** (Annex III) | AI used in regulated activities with significant impact on people | Credit scoring, fraud detection, AML profiling, insurance underwriting, biometric ID | **Enforceable Aug 2, 2026** |
| **Limited risk** | AI with transparency obligations | Chatbots, deepfakes | Ongoing |
| **Minimal risk** | Everything else | Spam filters | No obligations |

## High-Risk AI Use Cases in Fintech (Annex III)

All of these are explicitly High-Risk under the Act:

- **Credit scoring and loan decisioning**: AI systems that determine creditworthiness or set credit limits
- **Fraud detection**: Real-time transaction monitoring and anomaly detection systems
- **AML/CFT risk profiling**: AI that classifies customers by money laundering risk
- **Insurance underwriting**: AI that prices risk or approves/denies coverage
- **Biometric identification**: Facial recognition or behavioral biometrics used in financial onboarding (SCA)
- **Employment screening AI** (if used by fintechs internally for hiring)

## Compliance Requirements for High-Risk Systems (from Aug 2, 2026)

| Requirement | What It Means Operationally |
|------------|---------------------------|
| Risk management system | Documented, continuously updated risk identification and mitigation process |
| Data governance | Training data documentation; bias testing; data quality measures |
| Technical documentation | Comprehensive system documentation for regulatory inspection |
| Record-keeping | Automatic logging of operations for post-market surveillance |
| Transparency | Users must know they're interacting with AI; explainability for consequential decisions |
| Human oversight | Humans must be able to understand, monitor, intervene, and override AI decisions |
| Accuracy and robustness | Performance standards; resilience to adversarial inputs |
| CE marking | Formal conformity marking (like product safety certification) |
| EU database registration | Register high-risk systems before deployment |

## Enforcement Timeline

| Date | What Becomes Enforceable |
|------|--------------------------|
| February 2, 2025 | Prohibited AI practices banned |
| August 2, 2025 | Governance infrastructure, general-purpose AI model obligations |
| **August 2, 2026** | High-risk AI system requirements (most fintech AI) |
| August 2, 2027 | High-risk AI in Annex I (existing product safety legislation) |

## Penalties

| Violation | Maximum Fine |
|-----------|-------------|
| Deploying prohibited AI | **€35M or 7% of global annual turnover** (higher) |
| High-risk system non-compliance | **€15M or 3% of global annual turnover** (higher) |
| Incorrect information to authorities | **€7.5M or 1.5% of global annual turnover** |

## AI Act + Blockchain Intersection

The EU AI Act creates a direct use case for blockchain infrastructure:

**Requirement**: High-risk AI decisions (credit scoring, fraud, AML) must have immutable audit trails for regulatory inspection.

**Solution**: Blockchain-based on-chain logging provides tamper-proof audit trails that satisfy Act requirements better than traditional database logs.

This is the "EU AI Act + FinTech" content cluster flagged in InnBlockchain's FinTech Content Strategy — content hook: "Tamper-proof AI decision audit trails for regulated financial services."

## DORA Overlap

Fintech AI systems that are both DORA-covered (ICT risk) and AI Act high-risk must satisfy:
- DORA: operational resilience, incident reporting, vendor oversight
- AI Act: conformity assessment, human oversight, EU registration

These are separate compliance programs. Firms cannot satisfy both with a single framework — different documentation, different supervisors (EBA/national NCAs for DORA; market surveillance authorities for AI Act).

> [!gap] EBA published guidance on AI Act implications for EU banking sector (November 2025). Specific technical standards for financial services AI systems under the Act are not yet finalized.
