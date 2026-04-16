---
type: concept
title: "MiCA — Markets in Crypto-Assets Regulation"
created: 2026-04-16
updated: 2026-04-16
tags:
  - MiCA
  - EU
  - crypto
  - compliance
  - regulation
status: current
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[EU-AML-AMLA]]"
  - "[[CBDC-Central-Bank-Digital-Currency]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# MiCA — Markets in Crypto-Assets Regulation

MiCA is the EU's unified regulatory framework for crypto-asset service providers (CASPs) and crypto-asset issuers. It replaces 27 different national crypto regimes with a single passportable EU license.

## What MiCA Covers

**Crypto-asset categories under MiCA:**
- **ARTs** (Asset-Referenced Tokens): stablecoins pegged to a basket of assets
- **EMTs** (E-Money Tokens): stablecoins pegged to a single fiat currency (e.g., USDC-equivalent)
- **Other crypto-assets**: everything else not covered by existing financial law

**CASPs covered** (need MiCA authorization):
- Crypto exchanges (CEX and DEX where operators are identified)
- Custodian wallet providers
- Trading platforms for crypto-assets
- Portfolio managers for crypto-assets
- Crypto transfer services
- Advisory firms on crypto-assets

**Not covered by MiCA:**
- Fully decentralized DeFi protocols (no identifiable issuer or service provider)
- NFTs (generally, unless they qualify as financial instruments)
- Security tokens / tokenized securities (covered by MiFID II + DLT Pilot Regime)

## Implementation Timeline

| Date | Event |
|------|-------|
| June 2023 | MiCA entered into force |
| June 2024 | Title III (ARTs) and Title IV (EMTs) applicable |
| December 2024 | Title V (CASPs) applicable |
| January 2025 | Fully applicable in all 27 EU member states |
| End 2025 | Spain's 12-month transition deadline |
| **June 2026** | General 18-month transitional period ends — all CASPs must hold MiCA authorization |

## Key CASP Authorization Requirements

1. **Home-state authorization**: Apply to the National Competent Authority (NCA) in one EU member state; passport to all others
2. **Capital requirements**: Minimum own funds based on service type and scale
3. **Insurance / guarantee**: Professional indemnity insurance or equivalent
4. **Whitepaper publication**: Mandatory for crypto-asset issuers before offering to the public
5. **AML/KYC**: Full compliance including Travel Rule for crypto transfers
6. **Reserve requirements**: 1:1 backing for EMT issuers; stringent for ART issuers
7. **Market abuse**: Report suspicious transactions and market manipulation to ESMA
8. **Segregation**: Client assets must be held separately from firm assets

## Enforcement (2025 Data)

| Metric | Value |
|--------|-------|
| EU crypto firms MiCA-compliant (Q1 2025) | 65% |
| Fines issued since implementation | €540M+ |
| Licenses revoked by Feb 2025 | 50+ |
| Top fine reason | AML/KYC failures or missing reserve requirements |
| Highest single fine | €62M (France, to one exchange) |

**Compliance leaders**: Germany, France, Netherlands (90%+)
**Compliance laggards**: Greece, Portugal, Ireland (50-60%)

## MiCA vs. Existing Fintech Regulation

| Dimension | MiCA | PSD2/PSD3 |
|-----------|------|----------|
| Scope | Crypto-assets | Fiat payments |
| Passport | EU-wide single license | EU-wide single license |
| AML | Required | Required |
| Reserve requirements | Yes (for stablecoins) | No |
| Whitepaper | Yes | No |

## Impact on InnBlockchain Clients

- **Crypto Native ICP (Seg 1 — RWA)**: MiCA doesn't directly cover tokenized securities (that's MiFID II + DLT Pilot), but MiCA compliance is a prerequisite for any crypto platform touching fiat off-ramps or stablecoin products
- **FinTech ICP (Seg 1 — ExchangeTech)**: Licensed CEX/DEX operators must obtain MiCA CASP authorization by June 2026 — creates urgent need for compliant smart contract architecture
- Content positioning: "MiCA for Technical Founders" is the highest-scored InnBlockchain Crypto Native content article (9.6)

> [!gap] ESMA technical standards for several MiCA provisions were still being finalized as of late 2025. Some operational details may shift before the June 2026 deadline.
