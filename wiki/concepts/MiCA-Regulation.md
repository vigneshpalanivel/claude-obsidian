---
type: concept
title: "MiCA — Markets in Crypto-Assets Regulation"
created: 2026-04-16
updated: 2026-05-19
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

**Not covered by MiCA (Article 2(4) exclusion):**
- **Tokenized securities / RWA ownership tokens** (tokenized bonds, equities, fractional real estate, revenue-claim tokens) — these are MiFID II financial instruments. Classification is structural (transferability + claim on issuer/asset), **not** economic — distributing yield is not the trigger; conferring a security-like claim is. Trading/settlement infra path: **DLT Pilot Regime**, not MiCA.
- Fully decentralized DeFi protocols (no identifiable issuer or service provider)
- NFTs (generally, unless they qualify as financial instruments or fractionalized into fungible economic interests)
- Pure payment instruments under PSD2/PSD3
- Deposits, insurance contracts, pension products (covered by their own regimes)

> [!warning] RWA ≠ MiCA
> MiCA's "Asset-Referenced Token" (ART) sounds like it covers RWA tokenization. It does not. ARTs *reference* the value of underlying assets (basket-pegged stablecoins). A token that confers **ownership** of an asset — even without yield distribution — is a transferable security under MiFID II and is excluded from MiCA by Article 2(4). The two regimes are mutually exclusive at the token level.

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

- **Crypto Native ICP (Seg 1 — RWA)**: MiCA is **not** the primary regime — tokenized securities sit under MiFID II + Prospectus Regulation + DLT Pilot Regime. MiCA only enters if (a) the firm also runs CASP-licensed services (custody/exchange) on non-MiFID crypto-assets on the side, or (b) the token is structured as an Asset-Referenced Token rather than an ownership token. Selling "MiCA covers your RWA" to a Seg 1 prospect is wrong-regulator framing.
- **Crypto Native ICP (Seg 2–10)**: MiCA is the dominant framing — CASP authorization, white paper, Travel Rule, reserve requirements
- **FinTech ICP (Seg 1 — ExchangeTech)**: Licensed CEX/DEX operators must obtain MiCA CASP authorization by June 2026 — creates urgent need for compliant smart contract architecture. Note that if the venue also trades MiFID-classified tokens, MiFID II authorization is independently required.
- Content positioning: "MiCA for Technical Founders" is the highest-scored InnBlockchain Crypto Native content article (9.6) — but it should explicitly disclaim the RWA scope so Seg 1 readers aren't misrouted

> [!gap] ESMA technical standards for several MiCA provisions were still being finalized as of late 2025. Some operational details may shift before the June 2026 deadline.
