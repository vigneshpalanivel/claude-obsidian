---
type: concept
title: "MiCA — Markets in Crypto-Assets Regulation"
created: 2026-04-16
updated: 2026-05-20
tags:
  - MiCA
  - EU
  - crypto
  - compliance
  - regulation
status: current
last_reingested: 2026-05-24
related:
  - "[[MiCA-NCA-Authorization-Mechanics]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[EU-AML-AMLA]]"
  - "[[DORA-Regulation]]"
  - "[[MiFID-II]]"
  - "[[CBDC-Central-Bank-Digital-Currency]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# MiCA — Markets in Crypto-Assets Regulation

MiCA (Regulation (EU) 2023/1114) is the EU's unified regulatory framework for crypto-asset service providers (CASPs) and crypto-asset issuers. It replaces 27 different national crypto regimes with a single passportable EU license. Fully in force since 30 December 2024.

## What MiCA Covers

**Crypto-asset categories under MiCA:**
- **ARTs** (Asset-Referenced Tokens, Title III): stablecoins pegged to a basket of assets, multiple currencies, or commodities
- **EMTs** (E-Money Tokens, Title IV): stablecoins pegged 1:1 to a single official fiat currency
- **Other crypto-assets** (Title II): utility, governance, access tokens — everything else not covered by existing financial law

**CASPs covered** (Title V — need MiCA authorization):
- Crypto exchanges (CEX and DEX where operators are identified)
- Custodian wallet providers
- Trading platforms for crypto-assets
- Portfolio managers for crypto-assets
- Crypto transfer services
- Advisory firms on crypto-assets

**Not covered by MiCA (Article 2 exclusions):**
- **Tokenized securities / RWA ownership tokens** (tokenized bonds, equities, fractional real estate, revenue-claim tokens) — these are MiFID II financial instruments under Article 2(4)(a). Classification is structural (transferability + claim on issuer/asset), **not** economic — distributing yield is not the trigger; conferring a security-like claim is. Trading/settlement infra path: **DLT Pilot Regime**, not MiCA.
- Deposits, structured deposits — CRD/CRR (Art 2(4)(b))
- Insurance / pension products — Solvency II / IORP II / PEPP (Art 2(4)(e)–(j))
- CBDCs and services provided exclusively by central banks (Art 2(2)(c))
- Securitization positions (Art 2(4)(d))
- NFTs and other unique non-fungible crypto-assets (Art 2(3)) — except where fractionalised or issued in a large series indicating fungibility in substance
- Intra-group services to parent / subsidiaries (Art 2(2)(a))
- **Fully decentralised** crypto-asset services without any intermediary — outside MiCA per Recital 22. **However**, the same Recital makes clear that crypto-assets with no identifiable issuer fall outside Titles II/III/IV only (issuance/white-paper obligations) — **CASPs providing services *in respect of* such no-issuer crypto-assets remain fully within Title V**. A Bitcoin-style token doesn't need a white paper, but the exchange listing it still needs CASP authorisation.

> [!warning] RWA ≠ MiCA
> MiCA's "Asset-Referenced Token" (ART) sounds like it covers RWA tokenization. It does not. ARTs *reference* the value of underlying assets (basket-pegged stablecoins). A token that confers **ownership** of an asset — even without yield distribution — is a transferable security under MiFID II and is excluded from MiCA by Article 2(4). The two regimes are mutually exclusive at the token level.

## Implementation Timeline

| Date | Event | Source |
|------|-------|---|
| 9 June 2023 | MiCA published in Official Journal (OJ L 150) | — |
| 29 June 2023 | MiCA entered into force (20 days after publication) | Art 149(1) |
| 30 June 2024 | Title III (ARTs) and Title IV (EMTs) apply | Art 149(3) |
| 30 December 2024 | Full MiCA application — Titles I, II, V, VI, VII | Art 149(2) |
| End 2025 | Spain's 12-month transition deadline | National option per Art 143(3) |
| **1 July 2026** | Latest end of CASP transitional period — "grandfathered" providers must be authorised or cease, unless their home MS has shortened the period | Art 143(3) |

> [!info] White-paper machine-readable format
> Articles 6, 19, and 51 require white papers in a machine-readable format. The specific technical format (commonly expected to be iXBRL) and effective date are set by ESMA RTS / Commission Delegated Regulation — **not by MiCA Level 1**. Verify the current effective date with counsel; do not anchor on the "23 December 2025 iXBRL" claim that circulated pre-2026 (it was a v1 source error, not in Level 1).

## Territorial Scope

MiCA applies to conduct within the EU, regardless of where the entity is incorporated. Triggers (any one suffices):
- Offering crypto-assets to the public in the EU, or seeking admission to an EU trading platform
- Providing crypto-asset services (custody, exchange, brokerage, advisory, portfolio management) to EU-resident clients
- Issuing a stablecoin that will circulate within the EU
- Marketing or actively soliciting EU-resident users — even from a non-EU entity

Reverse solicitation is a narrow, fact-specific defense — not a planning tool. Article references: Article 2 (Scope), Article 4 (Definitions).

---

> [!info] Going to file an NCA application?
> The article-by-article detail — Article 60 simplified-notification pathway, Annex IV CASP capital classes, ART/EMT formulas, white paper mechanics, Article 74 wind-down plan, Articles 46/47 recovery/redemption plans, Article 70(3) client fiat placement, Articles 34(10) / 68(7)–(8) ↔ DORA, dossier contents, application timeline, "fit and proper" requirements, Article 111 penalty schedule — lives in [[MiCA-NCA-Authorization-Mechanics]]. This page stays at the *what MiCA is and where it applies* layer.

## Enforcement (Q1 2025 Data)

| Metric | Value |
|--------|-------|
| EU crypto firms MiCA-compliant | 65% |
| Fines issued since implementation | €540M+ |
| Licenses revoked by Feb 2025 | 50+ |
| Top fine reason | AML/KYC failures or missing reserve requirements |
| Highest single fine | €62M (France, one exchange) |

**Compliance leaders**: Germany, France, Netherlands (90%+)
**Compliance laggards**: Greece, Portugal, Ireland (50-60%)

## MiCA vs. Existing Fintech Regulation

| Dimension | MiCA | PSD2/PSD3 | MiFID II |
|-----------|------|-----------|----------|
| Scope | Crypto-assets | Fiat payments | Financial instruments (incl. tokenized securities) |
| Passport | EU-wide single license | EU-wide | EU-wide |
| AML | Required | Required | Required |
| Reserve requirements | Yes (stablecoins) | No | N/A |
| White paper | Yes | No | Prospectus regime |
| Wind-down plan | Yes (Article 74) | No | No |

## Impact on InnBlockchain Clients

- **Crypto Native ICP (Seg 1 — RWA)**: MiCA is **not** the primary regime — tokenized securities sit under MiFID II + Prospectus Regulation + DLT Pilot Regime. MiCA only enters if (a) the firm also runs CASP-licensed services (custody/exchange) on non-MiFID crypto-assets on the side, or (b) the token is structured as an Asset-Referenced Token rather than an ownership token. Selling "MiCA covers your RWA" to a Seg 1 prospect is wrong-regulator framing.
- **Crypto Native ICP (Seg 2–10)**: MiCA is the dominant framing — CASP authorization, white paper, Travel Rule, reserve requirements.
- **FinTech ICP (Seg 1 — ExchangeTech)**: Licensed CEX/DEX operators must obtain MiCA CASP authorization by 1 July 2026 — creates urgent need for compliant smart contract architecture. If the venue also trades MiFID-classified tokens, MiFID II authorization is independently required.
- **Service positioning for MiCA-bound startups**: pre-build classification briefs (MiCA vs MiFID II token boundary), white paper technical review (iXBRL-ready), ERC-3643 / ERC-1400 contract architecture with article-level annotations, independent audit reports formatted for NCA dossiers, Proof-of-Reserve oracle integration for ART/EMT issuers, multi-sig + ERC-1967 proxy upgradability, structured event schema aligned to Travel Rule.

> [!gap] ESMA technical standards for several MiCA provisions were still being finalized as of late 2025. Some Level 2 and Level 3 operational details may shift before the 1 July 2026 transitional deadline.
