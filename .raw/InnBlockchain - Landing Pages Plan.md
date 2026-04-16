---
company:
  - innblockchain
department:
  - marketing
priority: highest
tags:
  - content
  - seo
---

# 🌐 Landing Pages Plan — InnBlockchain.com

> [!TIP] Related files
> [[ICP - FinTech]] · [[Content Strategy - FinTech]] · [[ICP - Crypto Native]] · [[Content Strategy - Crypto Native]]

---

## 🗺️ Site URL Map

```
innblockchain.com/
│
├── /about
├── /work
│
├── /services/
│   ├── smart-contracts
│   ├── public-blockchain
│   ├── private-blockchain
│   └── blockchain-consulting
│
├── /technologies/
│   ├── hyperledger
│   ├── corda
│   ├── enterprise-ethereum
│   ├── solidity
│   ├── solana
│   ├── polygon-l2
│   └── zk-mpc          -> Web3 & DeFi
│
├── /industries/
│   ├── fintech/
│   └── web3-defi/
│
└── /solutions/
    │
    ├── — FinTech —
    ├── tokenization             🟢
    ├── regulated-exchange       🟢
    ├── defi-lending             🟢
    ├── fintech-wallets          🟢
    ├── remittance               ⚪
    ├── regtech-kyc              ⚪
    ├── treasury-fx              ⚪
    └── insurtech                ⚪
    │
    ├── — Web3 & DeFi —
    ├── rwa-tokenization  🟢
    ├── dex-protocol      🟢
    ├── defi-protocol     🟢
    ├── mpc-wallets       🟢
    ├── nft-platform      🟢
    ├── token-launch      🟢
    ├── dao-governance    ⚪
    ├── l2-bridge         ⚪
    ├── web3-gaming       ⚪
    └── ai-crypto         ⚪
```

*Legend: 🟢 Active this quarter · ⚪ Watch*

---

## 🏛️ Two-Audience Architecture

InnBlockchain serves two fundamentally different ICPs. They share the same technology capabilities but need completely separate messaging, solutions pages, and content funnels.

| Dimension | FinTech ICP | Web3 & DeFi (Crypto Native) ICP |
|---|---|---|
| **Who** | CTOs/CEOs at mid-sized FinTech companies | Technical Founders/CTOs at protocol teams |
| **Pain** | Intermediary fees + Web3 talent gap | Exploit risk + Web3 talent gap |
| **Budget signal** | $25k+ budget earmarked | $25k+ (DEX/DeFi/Wallets — Segments 1–3) or $20k+ (NFT/Token Launch — Segments 4–5); funded token treasury |
| **Trigger** | New funding, competitor pressure, regulatory deadline | Upcoming audit, competitor exploit, mainnet date |
| **Tone** | ROI-driven, compliance-aware, business outcomes | Security-first, deeply technical, protocol credibility |
| **Examples** | WealthTech, ExchangeTech (CEX/DEX/DeFi), LendTech, WalletTech | DEX protocols, crypto-native CEX, DeFi lending, MPC wallets, L2 bridges |
| **Hard exclusion** | Crypto-native startups (DEX, DeFi, wallets) building from scratch | Traditional FinTech with no smart contracts |

> [!IMPORTANT] Separation Rule
> **Services pages** (`/services/`) are shared — they describe the technology and serve both audiences.
> **Industry/Solutions pages** are strictly separated — FinTech under `/industries/fintech/`, Web3 & DeFi under `/industries/web3-defi/`. Do not blend messaging across these paths.

---

## 🗺️ Information Architecture Strategy

To avoid SEO keyword cannibalization and duplicated content, the site structure is strictly split into **Services (The Technology)** and **Solutions (The Industry Use Cases)**.
- **Services pages** rank for "how" keywords (`smart contract audit company`, `private blockchain development`).
- **Solutions pages** rank for "who/what" keywords (`crypto exchange development company`, `defi protocol security`).

Within Solutions, the two ICPs are separated by their industry hub:
- `/industries/fintech/` → FinTech solutions
- `/industries/web3-defi/` → Web3 & DeFi solutions

---

## 🏗️ 1. Core Pages

- **Home** (`/`): Two clear audience paths in the hero — *"Building a FinTech product?"* → FinTech path / *"Building a Web3 protocol?"* → Web3 & DeFi path. Primary SEO: `blockchain development company`.
- **About Us** (`/about`): Positioned as a dedicated Web3 division **"Backed by Trioangle."** Highlight 800+ traditional software deployments for financial stability and enterprise-grade execution credibility over fly-by-night crypto teams.
- **Case Studies / Work** (`/work`): Filterable by **Industry** (FinTech / Web3 & DeFi) and **Tech Stack**. Essential trust-builder for both CTO buyer types.

---

## 🛠️ 2. Services Pages (The Capabilities & Tech Stack)

*Shared across both ICPs. These capture bottom-of-funnel technical search intent regardless of industry.*

### A. Core Services (The Capabilities)

1. **Smart Contract Development & Audits** (`/services/smart-contracts`)
   - *Target SEO:* `smart contract development company`, `smart contract audit services`, `token development company`
   - *Focus:* Security checklists, Rust/Solidity/Move expertise, audit processes, pre-audit reviews.
   - *▶ Tech Links:* `/technologies/solidity`, `/technologies/solana`, `/technologies/zk-mpc`
   - *▶ Solution Links:* `/solutions/tokenization`, `/solutions/regulated-exchange`, `/solutions/dex-protocol`, `/solutions/defi-protocol`
   - *▶ Content Links:* FinTech T3 Hub (Smart Contracts & Web3 Security) · Crypto Native C1 Hub (Smart Contract Security & Auditing)

2. **Public Blockchain & dApp Development** (`/services/public-blockchain`)
   - *Target SEO:* `web3 development company`, `blockchain dapp development company`, `ethereum dapp development company`
   - *Focus:* Node infra, Layer-2 scaling, open network security.
   - *▶ Tech Links:* `/technologies/solidity`, `/technologies/solana`, `/technologies/polygon-l2`
   - *▶ Solution Links:* `/solutions/dex-protocol`, `/solutions/defi-protocol`, `/solutions/nft-platform`, `/solutions/token-launch`
   - *▶ Content Links:* FinTech T2 Hub (Public Blockchain & Layer 2s) · Crypto Native C2 Hub (Protocol Architecture & Design Patterns) · Verticals: V2 (DEX), V3 (DeFi), V5 (NFT), V6 (Token Launch)

3. **Private & Enterprise Blockchain** (`/services/private-blockchain`)
   - *Target SEO:* `private blockchain development company`, `enterprise blockchain development`, `permissioned blockchain development company`
   - *Focus:* Hyperledger, Corda, permissioned consensus, data privacy (GDPR).
   - *▶ Tech Links:* `/technologies/hyperledger`, `/technologies/corda`, `/technologies/enterprise-ethereum`
   - *▶ Solution Links:* `/solutions/treasury-fx`, `/solutions/regtech-kyc`, `/solutions/tokenization`
   - *▶ Content Links:* FinTech T1 Hub (Private & Hybrid Blockchain) — primarily FinTech ICP, less relevant to Crypto Native

4. **Web3 Consulting & PoC Development** (`/services/blockchain-consulting`)
   - *Target SEO:* `blockchain consulting firm`, `blockchain consulting services`, `blockchain proof of concept development`
   - *Focus:* ROI analysis, scoping, protocol design, technical roadmap creation.
   - *▶ Tech Links:* Routes to all capabilities master hub `/technologies/`
   - *▶ Solution Links:* Routes to master industry hubs `/industries/fintech` and `/industries/web3-defi`
   - *▶ Content Links:* FinTech T4 Hub (Blockchain ROI & Business Case) · Crypto Native C2 Hub (Protocol Architecture & Design Patterns) · Crypto Native C4 Hub (Web3 Engineering Velocity)

### B. Technology Pages (The Stack)

*Mapped to high-intent framework searches. Prove deep technical competence for CTOs searching for specific languages and protocols. Shared across both ICPs.*

1. **Hyperledger Fabric Development** (`/technologies/hyperledger`)
   - *Target SEO:* `hyperledger fabric development company`, `hire hyperledger developers`
   - *Primary ICP:* FinTech (BankTech / Corporate Treasury)
   - *▶ Content Links:* FinTech T1 Hub (Private & Hybrid Blockchain) · Solutions: `/solutions/treasury-fx`, `/solutions/regtech-kyc`

2. **Corda Development** (`/technologies/corda`)
   - *Target SEO:* `r3 corda development company`, `corda blockchain development`
   - *Primary ICP:* FinTech (BankTech)
   - *▶ Content Links:* FinTech T1 Hub (Private & Hybrid Blockchain) · Solutions: `/solutions/treasury-fx`

3. **Enterprise Ethereum: Quorum & Hyperledger Besu** (`/technologies/enterprise-ethereum`)
   - *Target SEO:* `quorum blockchain development company`, `hyperledger besu development company`, `enterprise ethereum development`
   - *Focus:* Quorum (ConsenSys-backed, regulated banking) vs Hyperledger Besu (Linux Foundation, vendor-neutral consortiums) — comparison + capabilities. Targets decision-stage buyers evaluating both options.
   - *Primary ICP:* FinTech (BankTech, Corporate Treasury, interbank settlements)
   - *▶ Content Links:* FinTech T1 Hub (Private & Hybrid Blockchain) · FinTech T2 Hub (Public Blockchain & Layer 2s) · Solutions: `/solutions/treasury-fx`, `/solutions/regtech-kyc`, `/solutions/tokenization`

4. **Solidity & EVM Development** (`/technologies/solidity`)
   - *Target SEO:* `solidity smart contract development company`, `hire solidity developers`, `ethereum smart contract development`
   - *Primary ICP:* Both (FinTech smart contracts + Crypto Native DEX/DeFi/Wallets/NFT/Token Launch)
   - *▶ Content Links:* FinTech T3 Hub (Smart Contracts & Web3 Security) · Solutions: `/solutions/tokenization`, `/solutions/regulated-exchange`, `/solutions/defi-lending`, `/solutions/fintech-wallets` · Crypto Native C1 Hub (Smart Contract Security) · C2 Hub (Protocol Architecture) · Verticals: V1 (RWA), V2 (DEX), V3 (DeFi), V4 (Wallets), V5 (NFT), V6 (Token Launch)

5. **Rust & Solana Development** (`/technologies/solana`)
   - *Target SEO:* `solana smart contract development company`, `solana dapp development`, `hire rust web3 developers`
   - *Primary ICP:* Both (ExchangeTech CEX/DEX + Crypto Native DEX/DeFi/NFT/Token Launch)
   - *▶ Content Links:* FinTech T2 Hub (Public Blockchain & Layer 2s) · FinTech T3 Hub (Smart Contracts & Web3 Security) · Solutions: `/solutions/regulated-exchange`, `/solutions/defi-lending`, `/solutions/tokenization` · Crypto Native C1 Hub (Smart Contract Security) · C2 Hub (Protocol Architecture) · Verticals: V2 (DEX), V3 (DeFi), V5 (NFT — compressed NFTs), V6 (Token Launch — SPL Token)

6. **Layer-2 & Polygon Development** (`/technologies/polygon-l2`)
   - *Target SEO:* `polygon development company`, `layer 2 blockchain development`, `polygon dapp development`
   - *Primary ICP:* Both
   - *▶ Content Links:* FinTech T2 Hub (Public Blockchain & Layer 2s) · Solutions: `/solutions/remittance`, `/solutions/tokenization` · Crypto Native C2 Hub (Protocol Architecture) · Verticals: V2 (DEX), V8 (L2 & Chain Infrastructure)

7. **ZK & MPC Development** (`/technologies/zk-mpc`)
   - *Target SEO:* `zk proof development company`, `zk circuit development`, `mpc infrastructure development`
   - *Focus:* ZK circuits (Circom/Noir), MPC wallet infrastructure, threshold signatures.
   - *Primary ICP:* Both (FinTech WalletTech + Web3 & DeFi Wallets/L2)
   - *▶ Content Links:* FinTech T3 Hub (Smart Contracts & Web3 Security) · Solutions: `/solutions/fintech-wallets` · Crypto Native C3 Hub (ZK, MPC & Advanced Cryptography) · Verticals: V4 (MPC Wallets), V8 (L2 & Chain Infrastructure)

---

## 🎯 3. Industry Hubs & Solutions Pages

---

### 🏦 A. FinTech Industry Hub

**Master Hub:** `Blockchain Development for FinTech Companies` (`/industries/fintech`)
- *Target SEO:* `fintech blockchain development company`, `blockchain for fintech companies`
- *Audience:* CTOs/CEOs at WealthTech, ExchangeTech (CEX/DEX/DeFi if licensed), LendTech, WalletTech (regulated e-money wallets), PayTech, RegTech, BankTech, InsurTech. $25k+ budget.
- *▶ Content Links:* [[Content Strategy - FinTech]] — all T1–T4 pillars and V1 Priority 1–8 verticals

#### FinTech Solution Sub-Pages (Anchored to ICP GTM Priority)

| GTM | Page | URL | Consolidates | Target SEO | Tech & Service Links | Content Strategy Link |
|---|---|---|---|---|---|---|
| 🟢 Active | **Asset Tokenization & STOs** | `/solutions/tokenization` | WealthTech, institutional tokenization, utility NFTs, STOs | `asset tokenization development company`, `security token offering development`, `tokenized securities platform` | `services/smart-contracts`, `services/private-blockchain`, `technologies/solidity`, `technologies/enterprise-ethereum` | FinTech V1 Priority 1 Hub (Tokenization, NFTs & RWA) · T2 · T1 |
| 🟢 Active | **Regulated Exchange Development** | `/solutions/regulated-exchange` | ExchangeTech expanding into CEX, DEX, or DeFi (requires financial services license or formal application) | `crypto exchange development company`, `regulated exchange development company`, `dex compliance engineering` | `services/public-blockchain`, `technologies/solidity`, `technologies/solana` | FinTech V1 Priority 2 Hub (Exchange & Trading Infrastructure) · T2 · T1 |
| 🟢 Active | **DeFi & Digital Lending** | `/solutions/defi-lending` | LendTech, credit scoring, stablecoin lending | `blockchain lending platform development`, `defi lending platform development`, `digital lending blockchain solution` | `services/smart-contracts`, `technologies/solidity`, `technologies/solana` | FinTech V1 Priority 3 Hub (DeFi & Digital Lending) · T2 · T3 |
| 🟢 Active | **Web3 Wallet Development (FinTech)** | `/solutions/fintech-wallets` | FinTechs adding wallet features to existing products only — not web3-defi wallet startups | `web3 wallet integration for fintech`, `crypto wallet development for fintech`, `fintech wallet features` | `services/public-blockchain`, `technologies/zk-mpc`, `technologies/solidity` | FinTech V1 Priority 4 Hub (Digital Wallets & E-Money — WalletTech) · T2 |
| ⚪ Watch | **Blockchain Remittance & Payments** | `/solutions/remittance` | PayTech, cross-border, stablecoin settlements | `blockchain remittance solution`, `cross-border payment blockchain development`, `blockchain payment gateway development` | `services/public-blockchain`, `technologies/polygon-l2` | FinTech V1 Priority 5 Hub (Cross-Border Remittance & Payments) · T2 |
| ⚪ Watch | **RegTech & KYC/AML** | `/solutions/regtech-kyc` | BankTech KYC/AML, decentralized identity, compliance automation | `blockchain KYC solution`, `blockchain AML compliance platform`, `decentralized identity verification` | `services/private-blockchain`, `technologies/hyperledger`, `technologies/enterprise-ethereum` | FinTech V1 Priority 6 Hub (Compliance, KYC/AML & RegTech) · T1 · T3 |
| ⚪ Watch | **Corporate Treasury & FX** | `/solutions/treasury-fx` | BankTech treasury, FX settlement, cash visibility | `blockchain treasury management solution`, `blockchain fx settlement`, `corporate treasury blockchain` | `services/private-blockchain`, `technologies/corda`, `technologies/hyperledger` | FinTech V1 Priority 7 Hub (Corporate Treasury & FX) · T1 |
| ⚪ Watch | **InsurTech & Fraud Prevention** | `/solutions/insurtech` | Parametric insurance, claims automation, fraud detection | `blockchain insurance platform development`, `parametric insurance smart contracts`, `blockchain claims automation` | `services/smart-contracts`, `technologies/hyperledger`, `technologies/solidity` | FinTech V1 Priority 8 Hub (Insurance & Fraud Detection) · T3 · T1 |

> [!NOTE] Regulated vs Crypto-Native Exchange Separation
> The old `/solutions/crypto-exchange` consolidated segments. This must be split by company origin:
> - **FinTech path:** `/solutions/regulated-exchange` — Targets existing FinTech companies expanding into trading (CEX, DEX, or DeFi). Architecture is irrelevant; the license and origin (existing FinTech) are what matter.
> - **Web3 & DeFi path:** `/solutions/dex-protocol` — Targets crypto-native startups building on-chain trading infrastructure (DEX/AMM) or crypto-native CEX, regardless of licensing status.
> Keeping them merged causes messaging conflict and attracts disqualified audiences to both pages.

---

### ⛓ B. Web3 & DeFi Industry Hub *(NEW)*

**Master Hub:** `Web3 & DeFi Development: Protocols, Wallets & On-Chain Products` (`/industries/web3-defi`)
- *Target SEO:* `defi development company`, `web3 protocol development company`, `smart contract security company`
- *Audience:* Technical founders and CTOs at protocol-stage companies. Minimum $20k+ budget across all segments or funded token treasury. Testnet must be live.
- *Internal ICP name:* Crypto Native (see [[ICP - Crypto Native]])
- *▶ Content Links:* [[Content Strategy - Crypto Native]] — all C1–C4 pillars and V1–V8 segment verticals

#### Web3 & DeFi Solution Sub-Pages (Anchored to ICP GTM Priority)

| GTM | Page | URL | Consolidates | Target SEO | Tech & Service Links | Content Strategy Link |
|---|---|---|---|---|---|---|
| 🟢 Active | **RWA Tokenization Platforms** | `/solutions/rwa-tokenization` | Real estate, vehicles, commodities platform builds (not STOs) | `rwa tokenization smart contract`, `real world asset tokenization platform` | `services/smart-contracts`, `technologies/solidity` | Crypto Native V1 Hub (RWA Tokenization) · C1 (Smart Contract Security) · C5 (EU Compliance) |
| 🟢 Active | **DEX & On-Chain Trading** | `/solutions/dex-protocol` | AMM protocols, on-chain order books, trading aggregators | `decentralized exchange development company`, `dex development company`, `amm protocol development` | `services/smart-contracts`, `technologies/solana`, `technologies/solidity` | Crypto Native V2 Hub (DEX & On-Chain Trading) · C1 (Smart Contract Security) · C2 (Protocol Architecture) |
| 🟢 Active | **DeFi Protocol Development** | `/solutions/defi-protocol` | Lending protocols, yield vaults, liquidity management | `defi protocol development company`, `defi smart contract development`, `defi security audit` | `services/smart-contracts`, `technologies/solidity`, `technologies/solana` | Crypto Native V3 Hub (DeFi Lending & Yield) · C1 (Smart Contract Security) · C2 (Protocol Architecture) |
| 🟢 Active | **Non-Custodial & MPC Wallets** | `/solutions/mpc-wallets` | MPC wallets, self-custody infrastructure, institutional key management | `cryptocurrency wallet development`, `mpc wallet development company`, `non custodial wallet development` | `services/public-blockchain`, `technologies/zk-mpc` | Crypto Native V4 Hub (Non-Custodial & MPC Wallets) · C3 (Cryptography) · C1 (Security) |
| 🟢 Active | **NFT Platform Development** | `/solutions/nft-platform` | NFT marketplaces, minting contracts, royalty enforcement | `nft marketplace development company`, `nft platform development`, `nft smart contract development` | `services/smart-contracts`, `technologies/solidity`, `technologies/solana` | Crypto Native V5 Hub (NFT Platforms & Marketplaces) · C1 (Smart Contract Security) · C2 (Protocol Architecture) |
| 🟢 Active | **Token Launch & IDO Launchpad** | `/solutions/token-launch` | IDO launchpads, token sale platforms, vesting contracts, whitelist infrastructure | `crypto launchpad development`, `ido launchpad development company`, `token launch platform development` | `services/smart-contracts`, `technologies/solana` | Crypto Native V6 Hub (Token Launch & IDO Launchpad) · C1 (Smart Contract Security) · C2 (Protocol Architecture) |
| ⚪ Watch | **DAO & Governance Infrastructure** | `/solutions/dao-governance` | Governor contracts, timelock, on-chain voting, treasury security | `dao development company`, `dao governance infrastructure`, `governance smart contract development` | `services/smart-contracts`, `technologies/solidity` | Crypto Native V7 Hub (DAO Infrastructure) · C1 (Smart Contract Security) · C2 (Protocol Architecture) |
| ⚪ Watch | **L2 & Chain Infrastructure** | `/solutions/l2-bridge` | L2 rollup builds, bridge contracts, ZK infrastructure, sequencer design | `layer 2 development company`, `blockchain bridge development`, `zk rollup development company` | `services/public-blockchain`, `technologies/polygon-l2`, `technologies/zk-mpc` | Crypto Native V8 Hub (L2 & Chain Infrastructure) · C2 (Protocol Architecture) · C3 (Cryptography) |
| ⚪ Watch | **Web3 Gaming & GameFi** | `/solutions/web3-gaming` | On-chain game economies, NFT item contracts, play-to-earn mechanics | `web3 game development company`, `blockchain game development`, `gamefi smart contract development` | `services/smart-contracts`, `technologies/solana`, `technologies/polygon-l2` | Crypto Native V9 Hub (Web3 Gaming & GameFi) · C1 (Smart Contract Security) · C2 (Protocol Architecture) |
| ⚪ Watch | **AI x Crypto & On-Chain Agents** | `/solutions/ai-crypto` | AI-generated smart contracts, AI model marketplaces, on-chain AI agents | `ai smart contract audit`, `on chain ai agents development`, `ai crypto protocol development` | `services/smart-contracts`, `technologies/zk-mpc`, `technologies/solidity` | Crypto Native V10 Hub (AI x Crypto) · C1 (Smart Contract Security) |

---

## 📝 4. Traffic Flow & Content Hub Integration

Two separate content funnels — one per ICP. Both follow the same 3-step flow.

### Funnel A — FinTech ICP

```
[ToFU Blog] e.g. "What Is Asset Tokenization? Guide for FinTech Founders"
        ↓  (internal links + sidebar CTAs)
[Content Hub] e.g. "Real-World Asset Tokenization & Utility NFTs for FinTech"
        ↓  (strong "Work With Us" CTA)
[Solution Page] /solutions/tokenization
        ↓
[Discovery Call]
```

**Active funnel priorities this quarter (aligned to FinTech ICP active segments):**
1. RWA Tokenization → `/solutions/tokenization`
2. Regulated Exchange → `/solutions/regulated-exchange`
3. DeFi & Digital Lending → `/solutions/defi-lending`
4. Wallets → `/solutions/fintech-wallets`

### Funnel B — Crypto Native ICP

```
[ToFU Blog] e.g. "[DeFi Exploit] Post-Mortem: Root Cause & Prevention"
        ↓  (internal links + sidebar CTAs)
[Content Hub] e.g. "Building a Secure DeFi Lending Protocol"
        ↓  (strong "Audit Your Protocol" CTA)
[Solution Page] /solutions/defi-protocol
        ↓
[Discovery Call]
```

**Active funnel priorities this quarter (aligned to Web3 & DeFi (Crypto Native) ICP active segments):**
1. RWA Tokenization (Crypto Native) → `/solutions/rwa-tokenization`
2. DEX protocols → `/solutions/dex-protocol`
3. DeFi Lending/Yield → `/solutions/defi-protocol`
4. MPC Wallets → `/solutions/mpc-wallets`
5. NFT Platforms → `/solutions/nft-platform`
6. Token Launch → `/solutions/token-launch`

> [!TIP] Cross-ICP overlap
> The `/services/smart-contracts` page sits at the intersection of both funnels. It should have two CTA paths: "Securing a FinTech product?" → FinTech hub, "Securing a Web3 protocol?" → Web3 & DeFi hub.

---

## 🚀 5. Future Expansion Architecture

### New Industry Verticals (Supply Chain, Healthcare)
Because Services (the technology) are decoupled from Solutions (the industry), adding new industries requires zero restructuring of core pages:
1. **Services pages** remain untouched.
2. **New industry hub** added: e.g., `/industries/supply-chain`
3. **New solution sub-pages** added: e.g., `/solutions/supply-chain-traceability`
4. **New content hubs** built to feed those solutions pages.

### Activating FinTech Watch Segments
As FinTech Priorities 5–8 enter active GTM focus (Remittance, RegTech, Treasury, InsurTech):
1. Build the corresponding Priority section in [[Content Strategy - FinTech]] (V1 Tier 2 vertical) first.
2. Publish 3–5 supporting blog posts mapped to the relevant T-pillar.
3. Build the solution page and connect it to the `/industries/fintech` hub.
4. Add to the publishing calendar and priority content plan.

### Activating Web3 & DeFi Watch Segments
As ICP Segments V7–V10 enter active GTM focus (DAO, L2, Gaming, AI x Crypto):
1. Build the corresponding Tier 2 vertical in [[Content Strategy - Crypto Native]] first.
2. Publish 3–5 supporting blog posts to establish content authority.
3. Build the solution page and connect it to the `/industries/web3-defi` hub.
4. Add to the publishing calendar and priority content plan.

---

## 🔄 6. Existing Pages Migration Map

How the 10 current innblockchain.com landing pages map into the new architecture. All retired pages should be 301 redirected to their new destination.

| Existing URL | Action | FinTech Mapping | Crypto Native Mapping |
|---|---|---|---|
| `/smart-contract-development` | Restructure → Service page | `/services/smart-contracts` | `/services/smart-contracts` |
| `/web3-development` | Restructure → Service page | `/services/public-blockchain` | `/services/public-blockchain` |
| `/cryptocurrency-exchange-development` | Split into two pages | `/solutions/regulated-exchange` 🟢 | `/solutions/dex-protocol` 🟢 |
| `/p2p-cryptocurrency-exchange-development` | Fold + 301 redirect | `/solutions/regulated-exchange` (H2 sub-topic — P2P is a centralized variant) | Not relevant |
| `/defi-development` | Split into two pages | `/solutions/defi-lending` 🟢 | `/solutions/defi-protocol` 🟢 |
| `/cryptocurrency-wallet-development` | Split into two pages | `/solutions/fintech-wallets` 🟢 | `/solutions/mpc-wallets` 🟢 |
| `/nft-marketplace-development` | Rename + 301 redirect | Not relevant | `/solutions/nft-platform` 🟢 |
| `/sto-development` | Fold + 301 redirect | `/solutions/tokenization` (H2 section) | Not relevant |
| `/token-development` | Split into three | `/solutions/tokenization` 🟢 (STOs, institutional utility tokens) | `/solutions/token-launch` 🟢 (IDO), `/solutions/rwa-tokenization` 🟢 (Crypto Native RWA platforms) |
| `/launchpad-development` | Rename + 301 redirect | Not relevant | `/solutions/token-launch` 🟢 |

> [!NOTE] Pages needing a split
> `/cryptocurrency-exchange-development`, `/defi-development`, and `/cryptocurrency-wallet-development` each blend both ICPs into one page — causing messaging conflict. Each must be rebuilt as two separate pages before the old URL is retired.

---
