---
type: concept
title: "InnBlockchain Landing Pages Plan"
status: current
created: 2026-04-16
updated: 2026-04-16
tags:
  - concept
  - innblockchain
  - marketing
  - seo
  - landing-pages
  - content
related:
  - "[[InnBlockchain]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech Content Strategy]]"
  - "[[InnBlockchain Crypto Native Content Strategy]]"
  - "[[InnBlockchain Content Strategy]]"
---

# InnBlockchain Landing Pages Plan

The full site architecture and page strategy for innblockchain.com. Strictly separates the two ICPs across every URL path — shared Services pages (the technology), split Industry and Solutions pages (the use cases).

## Site URL Map

```
innblockchain.com/
├── /about
├── /work
├── /services/        — shared: smart-contracts, public-blockchain, private-blockchain, blockchain-consulting
├── /technologies/    — shared: hyperledger, corda, enterprise-ethereum, solidity, solana, polygon-l2, zk-mpc
├── /industries/
│   ├── fintech/      — FinTech ICP hub
│   └── web3-defi/    — Crypto Native ICP hub
└── /solutions/       — split by ICP (see below)
```

## Two-Audience Architecture

| Dimension | FinTech ICP | Crypto Native ICP |
|---|---|---|
| **Who** | CTOs/CEOs at mid-sized FinTech companies | Technical Founders/CTOs at protocol teams |
| **Pain** | Intermediary fees + Web3 talent gap | Exploit risk + Web3 talent gap |
| **Budget** | $25k+ earmarked | $25k+ (Seg 1-3) or $20k+ (Seg 4-5); funded token treasury |
| **Trigger** | New funding, competitor pressure, regulatory deadline | Upcoming audit, competitor exploit, mainnet date |
| **Tone** | ROI-driven, compliance-aware, business outcomes | Security-first, deeply technical, protocol credibility |
| **Hard exclusion** | Crypto-native startups building from scratch | Traditional FinTech with no smart contracts |

> [!IMPORTANT] Separation Rule
> Services pages (`/services/`) are shared across both ICPs.
> Industry and Solutions pages are strictly separated — never blend FinTech and Web3 & DeFi messaging.

## IA Strategy (Anti-Cannibalization)

- **Services pages** rank for "how" keywords: `smart contract audit company`, `private blockchain development`
- **Solutions pages** rank for "who/what" keywords: `crypto exchange development company`, `defi protocol security`
- Strict URL namespace split prevents SEO cannibalization between the two ICP funnels

## Core Pages

- **Home** (`/`): Dual audience paths in hero — "Building a FinTech product?" vs. "Building a Web3 protocol?"
- **About** (`/about`): Positioned as dedicated Web3 division backed by Trioangle. Highlights 800+ traditional software deployments for enterprise credibility.
- **Work** (`/work`): Filterable by Industry (FinTech / Web3 & DeFi) and Tech Stack.

## Services Pages (Shared)

| Page | URL | Primary SEO | Primary ICP |
|---|---|---|---|
| Smart Contract Dev & Audits | `/services/smart-contracts` | `smart contract development company`, `smart contract audit services` | Both |
| Public Blockchain & dApp Dev | `/services/public-blockchain` | `web3 development company`, `blockchain dapp development` | Both |
| Private & Enterprise Blockchain | `/services/private-blockchain` | `private blockchain development company`, `enterprise blockchain development` | FinTech |
| Web3 Consulting & PoC | `/services/blockchain-consulting` | `blockchain consulting firm`, `blockchain proof of concept development` | Both |

## Technology Pages (Shared)

| Page | URL | Primary SEO | Primary ICP |
|---|---|---|---|
| Hyperledger Fabric | `/technologies/hyperledger` | `hyperledger fabric development company` | FinTech |
| Corda | `/technologies/corda` | `r3 corda development company` | FinTech |
| Enterprise Ethereum (Quorum/Besu) | `/technologies/enterprise-ethereum` | `quorum blockchain development company` | FinTech |
| Solidity & EVM | `/technologies/solidity` | `solidity smart contract development company` | Both |
| Rust & Solana | `/technologies/solana` | `solana smart contract development company`, `hire rust web3 developers` | Both |
| Layer-2 & Polygon | `/technologies/polygon-l2` | `polygon development company`, `layer 2 blockchain development` | Both |
| ZK & MPC | `/technologies/zk-mpc` | `zk proof development company`, `mpc infrastructure development` | Both |

## FinTech Solutions — Active Q2 2026

| Priority | Page | URL | Key SEO |
|---|---|---|---|
| 1 | Asset Tokenization & STOs | `/solutions/tokenization` | `asset tokenization development company`, `security token offering development` |
| 2 | Regulated Exchange Development | `/solutions/regulated-exchange` | `crypto exchange development company`, `regulated exchange development company` |
| 3 | DeFi & Digital Lending | `/solutions/defi-lending` | `blockchain lending platform development`, `defi lending platform development` |
| 4 | Web3 Wallet Development (FinTech) | `/solutions/fintech-wallets` | `web3 wallet integration for fintech`, `fintech wallet features` |

FinTech Watch (not active yet): remittance, regtech-kyc, treasury-fx, insurtech.

## Crypto Native Solutions — Active Q2 2026

| Priority | Page | URL | Key SEO |
|---|---|---|---|
| 1 | RWA Tokenization Platforms | `/solutions/rwa-tokenization` | `rwa tokenization smart contract`, `real world asset tokenization platform` |
| 2 | DEX & On-Chain Trading | `/solutions/dex-protocol` | `decentralized exchange development company`, `amm protocol development` |
| 3 | DeFi Protocol Development | `/solutions/defi-protocol` | `defi protocol development company`, `defi security audit` |
| 4 | Non-Custodial & MPC Wallets | `/solutions/mpc-wallets` | `mpc wallet development company`, `non custodial wallet development` |
| 5 | NFT Platform Development | `/solutions/nft-platform` | `nft marketplace development company` |
| 6 | Token Launch & IDO Launchpad | `/solutions/token-launch` | `crypto launchpad development`, `ido launchpad development company` |

Crypto Native Watch: dao-governance, l2-bridge, web3-gaming, ai-crypto.

## Exchange + Wallet + DeFi Split Rule

Old pages (`/cryptocurrency-exchange-development`, `/defi-development`, `/cryptocurrency-wallet-development`) blend both ICPs — messaging conflict. Each must be rebuilt as two separate pages before the old URL is retired:

| Old URL | FinTech Destination | Crypto Native Destination |
|---|---|---|
| `/cryptocurrency-exchange-development` | `/solutions/regulated-exchange` | `/solutions/dex-protocol` |
| `/defi-development` | `/solutions/defi-lending` | `/solutions/defi-protocol` |
| `/cryptocurrency-wallet-development` | `/solutions/fintech-wallets` | `/solutions/mpc-wallets` |

All retired pages: 301 redirect to new destinations.

## Content Funnel Integration

**FinTech funnel:** ToFU Blog → Content Hub → Solution Page → Discovery Call. Active Q2: tokenization, regulated-exchange, defi-lending, fintech-wallets.

**Crypto Native funnel:** ToFU Blog (exploit post-mortems) → Content Hub → Solution Page → Discovery Call. Active Q2: rwa-tokenization, dex-protocol, defi-protocol, mpc-wallets, nft-platform, token-launch.

**Cross-funnel intersection:** `/services/smart-contracts` sits at both funnels. Needs two CTA paths: FinTech hub + Web3 & DeFi hub.

## Future Expansion Pattern

Services pages remain untouched. Add new industry hubs + solution sub-pages as new verticals activate. Sequence: build content hubs first → publish 3-5 blog posts → build solution page → connect to industry hub → add to publishing calendar.

## See Also

- Audience context: [[InnBlockchain FinTech ICP]], [[InnBlockchain Crypto Native ICP]]
- Content strategy: [[InnBlockchain FinTech Content Strategy]], [[InnBlockchain Crypto Native Content Strategy]]
- Umbrella: [[InnBlockchain Content Strategy]]
- Entity: [[InnBlockchain]]
