---
type: concept
title: "PSD3, PSR, IPR, and Open Banking in the EU"
created: 2026-04-16
updated: 2026-04-16
tags:
  - PSD3
  - PSR
  - IPR
  - open-banking
  - EU
  - fintech
  - payments
status: current
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[Stablecoin-Cross-Border-Payments]]"
  - "[[EU-AML-AMLA]]"
  - "[[Blockchain-Fintech-Solutions]]"
---

# PSD3, PSR, IPR, and Open Banking in the EU

The EU is simultaneously upgrading its payment services legal framework (PSD3/PSR), mandating instant payments (IPR), and laying groundwork for open finance (FiDA). Together these reshape the regulatory environment for every fintech operating in the EU.

## Instant Payments Regulation (IPR) — Already In Force

### What It Does
Mandates all PSPs offering euro credit transfers to support instant payments (settlement within 10 seconds, 24/7) at fees no higher than standard transfers.

### Compliance Milestones

| Obligation | Deadline |
|-----------|----------|
| Receive instant payments | January 9, 2025 |
| **Send instant payments** | **October 9, 2025** |
| **Verification of Payee (VoP) live** | **October 9, 2025** |
| Non-euro EU PSPs receive | January 9, 2027 |
| Non-euro EU PSPs send | January 9, 2028 |

### Verification of Payee (VoP)
The VoP service requires PSPs to verify payee name against IBAN before authorizing a transfer. Automated API-based system returns: **match / close match / no match / other**. Free service — cannot be charged to payers.

VoP is the primary fraud prevention mechanism in IPR. PSPs are liable for fraud losses if VoP was not offered or failed technically.

---

## PSD3 / PSR — Payment Services Directive 3

### Status (April 2026)
- November 27, 2025: Provisional political agreement
- Expected Q1-Q2 2026: Entry into force
- **21-month transition period** after entry into force
- Full compliance expected late 2027 / early 2028

### What Changes

**Fraud liability shift**: PSPs become fully liable for fraud losses where they failed to implement adequate prevention. Significant shift from PSD2's shared liability model.

**Stronger Open Banking**: PSD3 reinforces APIs for third-party payment providers and aligns with FiDA for broader financial data access. Dedicated interface for TPPs mandatory.

**BNPL and crypto scope**: PSD3 explicitly covers Buy Now Pay Later products and certain crypto payment services previously in a regulatory grey zone.

**E-money integration**: E-money institutions absorbed as a sub-category of payment institutions under PSD3, simplifying the authorization landscape.

**Cash access rights**: Consumers may withdraw cash in shops without making a purchase — addressing physical branch decline.

**eIDAS 2.0 alignment**: EUDI Wallet accepted as SCA method under PSD3.

### PSR (Payment Services Regulation)
The PSR is a directly applicable EU regulation (no national transposition) that replaces PSD2's conduct and market rules. This eliminates the regulatory arbitrage created by 27 different national implementations of PSD2.

---

## FiDA — Financial Data Access

### What It Is
EU "Open Finance" regulation extending PSD2's Open Banking (payments only) to all financial data including savings, investments, loans, insurance, pensions, and crypto assets.

### Status
- Trilogue negotiations halted early 2026
- Expected adoption: H1 2026 (if resumed) or later
- **Implementation: 2027** (30-32 months post-adoption)

### Key Requirements (Once Adopted)
1. Financial data holders must provide standardized API access (real-time, continuous)
2. Customer consent required; revocable at any time via dashboard
3. Institutions must join **Financial Data Sharing Schemes (FDSS)**
4. New licensed entity class: **FISPs** (Financial Information Service Providers)

**Data in scope**: Mortgages, loans, savings, investment accounts, pension accounts, non-life insurance, crypto assets.

---

## CCD2 — Consumer Credit Directive 2

### What It Does
Extends EU consumer credit rules to previously unregulated digital credit products.

### Key Changes
- **BNPL (Buy Now Pay Later) now regulated**: Affordability checks mandatory for all deferred payment products including those below €200
- **Balloon payment restrictions**: Minimum 3 installments required
- **Fee and interest rate caps**: Member states can set caps on BNPL costs
- **Deadline**: November 20, 2026

---

## Open Banking: PSD2 vs. PSD3 vs. FiDA

| Dimension | PSD2 | PSD3 + PSR | FiDA |
|-----------|------|-----------|------|
| Data scope | Payment accounts | Payment + crypto | All financial data |
| API mandated | Yes | Yes (improved) | Yes (standardized) |
| Monetization | Free | Free | Paid (FDSS schemes) |
| Liability | Shared | PSP-primary | TBD |
| Timeline | In force | Late 2027 | ~2027 |

> [!gap] PSR's specific technical standards for API interfaces and authentication are not yet published. PSD2 APIs were notoriously fragmented — it's unclear whether PSR will solve this. FDSS governance structures under FiDA are still being designed.
