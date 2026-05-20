---
company:
  - innblockchain
department:
  - marketing
priority: high
rev: 14
last_revised: 2026-05-20
revision_notes: |
  rev 1: initial inventory.
  rev 2: no-competitor-names policy.
  rev 3: TVL-claim strip + competitor-category extension.
  rev 4: positive-framing rule (Principle #6).
  rev 5: cross-LP deduplication.
  rev 6: SERP-validated prompt rewrite (8 LPs) + Principle #13 (listicle dominance).
  rev 7: consistency pass — Principle #13 applied to remaining 11 LPs + persona-doc sync.
  rev 8: review-driven fixes — `/about`, Carol prompts on tokenization + regulated-exchange, `/work` TVL strip, defi-protocol stablecoin-yield anchor, blockchain-consulting narrowed to [FT]. Open Items 4–5 added.
  rev 9: `/home` repositioned as industry-agnostic; multi-industry routing replaces FT/CN binary; Industry Hub build-out pattern documented. Open Items 6–7 added.
  rev 10: all Trioangle references stripped — InnBlockchain positioned as standalone firm. Principle #11 proof guidance reworked to InnBlockchain-native elements. Open Item 8 added (proof numbers are the LP gating item).
  rev 11: post-Trioangle cleanup — `/home` Prompts 4 + 5 rewrites, `/about` Carol/Sasha persona note stripped, Principle #10 track-tag vocabulary added, 🚧 Blocking dependencies callout surfaced at top.
  rev 12 (2026-05-20): MiCA-as-RWA-cover misframe correction. `/solutions/rwa-tokenization` (CN) + `/solutions/tokenization` (FT) prompts rewritten to MiFID II + Prospectus + DLT Pilot framing (RWA ownership tokens are MiFID II financial instruments under Art. 2(4)). Principle #4 + Principle #13 examples updated. Other LPs where MiCA is correct left as-is.
  rev 13 (2026-05-20): added Canonical regulatory reference callout pointing to [[EU-Compliance-Landscape]] — surfaces the two misframes (MiCA-not-universal; RWA ≠ MiCA) globally; "landscape doc wins on divergence" rule.
  rev 14 (2026-05-20): two errors fixed. (1) `/solutions/regtech-kyc` regime corrected from "MiCA + AMLD6" to AML/AMLA + EU AI Act (RegTech's own regime; MiCA is downstream demand driver); AMLD6 updated to current EU AML Package. (2) `/services/blockchain-consulting` MiCA-first ordering replaced with per-segment regime list. Prompts later tightened to conversational length.
tags:
  - seo
  - aeo
  - geo
  - landing-pages
  - phase-1
---

# 🌐 AEO / GEO Prompts — InnBlockchain Landing Pages

> [!NOTE] What this document is
> A page-by-page inventory of the conversational prompts InnBlockchain's buyers query AI answer engines (ChatGPT, Claude, Perplexity, Google AI Overviews, Gemini, Copilot) with **when they're evaluating vendors** — not when they're learning a topic. Every landing page in [[InnBlockchain - Landing Pages Plan]] gets a block of 4–6 prompts that the LP must answer in its first 150–200 words.
>
> **Boundary rule:** Blog articles (see [[InnBlockchain - Content AEO GEO Prompts]]) own *educational* prompts: *"What is X? How does X work?"* Landing pages own *commercial-intent* prompts: *"Who builds X? Best X development company? How much does X cost?"* Do not duplicate — if a prompt sounds educational, it belongs in a blog article; if it sounds like vendor selection, it belongs on an LP.

> [!IMPORTANT] How to use this with a draft
> 1. Open the LP you're drafting (or rewriting).
> 2. Find its block below.
> 3. Each prompt must be answerable in the LP's first 150 words — literally. The hero copy and first paragraph below the fold are the answer surface.
> 4. Add the prompts verbatim as `FAQPage` JSON-LD schema near the bottom of the page (before the closing CTA).
> 5. Use one of the prompts as the page's H1 question variant where it doesn't break the existing SEO H1.
> 6. 30 days post-publish: probe 2–3 prompts against ChatGPT / Claude / Perplexity. If InnBlockchain isn't cited, rework the hero answer block.

> [!INFO] Canonical regulatory reference
> **[[EU-Compliance-Landscape]]** is the single source of truth for the per-segment regulatory map (MiFID II / III, MiCA, DLT Pilot Regime, DORA, AML/AMLA, EU AI Act, PSD3, IPR, CCD2, eIDAS 2.0, GDPR) — including the dependency map, regulation-interaction risks, and the **two misframes** (MiCA-is-not-universal-for-FinTechs; WealthTech RWA ≠ MiCA — ownership tokens are MiFID II financial instruments under Art. 2(4)). Every regulatory framing in this doc — LP scope notes, individual prompts, the "Cite specifics" principle examples, listicle anchors — is a scoped excerpt; **if any prompt diverges from the landscape doc, the landscape doc wins**. Before drafting or revising prompts for FT solution LPs (`/solutions/tokenization`, `/solutions/regulated-exchange`, `/solutions/defi-lending`, `/solutions/fintech-wallets`) and the CN RWA LP (`/solutions/rwa-tokenization`), pull the canonical regime stack for that segment from the landscape doc — don't paraphrase from memory. Re-read on every LP revision.

> [!WARNING] 🚧 Blocking dependencies before LP build-out
> Three open items below currently gate effective LP execution. Most prompts can be drafted around them, but **the proof block on every active LP and the entire `/about` LP cannot be built well until these close.** Principle #11 explicitly warns that LLMs cite competitors when proof is missing — so even perfect prompt-mirroring won't deliver citation lift until the underlying facts land.
>
> | # | Blocker | Owner | Gates |
> |---|---|---|---|
> | **#8** | InnBlockchain-native proof numbers (founding year, projects shipped, team size, financial-stability signal) | Marketing lead | Every LP's proof block + 4 of 6 `/about` prompts |
> | **#1** | Verified TVL secured (cumulative + highest single-protocol) | Delivery / Engineering | Sasha-track BOFU proof + `/work` outcome metric |
> | **#2** | Listicle-outreach budget, owner, target | Marketing lead | Principle #13 motion — listicle inclusions deliver more citation lift than LP tuning |
>
> See [⏳ Open Items](#-open-items) at the bottom of this doc for full context on each. **Action: close #8 first — it unblocks the most LPs and is the lowest-effort to resolve (one stakeholder conversation, not a multi-week dependency).**

---

## 📊 Landing Page Scope Snapshot

| Bucket | Pages | Status | Owner |
|---|---|---|---|
| Core (Home, About, Work) | 3 | Active | Marketing |
| Services | 4 | Active | Marketing + Engineering review |
| Technologies | 7 | Active | Marketing + Engineering review |
| Industry Hubs (FinTech, Web3 & DeFi) | 2 | Active | Marketing |
| FinTech Solutions — Active | 4 | Active | Marketing + Compliance review |
| FinTech Solutions — Watch | 4 | Stub | Marketing (build when activated) |
| Web3 & DeFi Solutions — Active | 6 | Active | Marketing + Engineering review |
| Web3 & DeFi Solutions — Watch | 4 | Stub | Marketing (build when activated) |
| **Total LP AEO scope** | **34 pages** | — | — |

---

## 🧭 How to read each LP block

```
**[URL]** — Page name
- Track: [FT] / [CN] / [Both]
- Stage: TOFU / MOFU / BOFU
- Persona: who's evaluating
- Sales motion: [Audit] / [Dev] / [White-Label] / [Carol]
- Distribution: organic SEO + AI search (LPs are primarily inbound capture)
- Prompts: 4–6 commercial-intent queries the page must answer in the first 150 words
```

Prompt phrasing reflects how buyers query LLMs when they have intent to hire — verbose, context-loaded, vendor-comparison-style. Not "What is tokenization?" but "Which company builds tokenization platforms for licensed asset managers in the EU?"

---

# 🏗️ Core Pages

## `/` — Home

**Track:** [Both/All] · **Stage:** TOFU + Routing · **Persona:** All — Sam, Tom, Carol, Felix, Paulo, Sasha *(plus future-industry personas as Supply Chain / Healthcare activate)*
**Motion:** Industry routing — currently FinTech + Web3 & DeFi paths; extensible to Supply Chain / Healthcare / other industries as they activate · **Distribution:** SEO + AI search (brand + multi-industry routing queries)
**Prompts:** *(Scope: **brand recognition + multi-industry routing framing.** Home is positioned as an industry-agnostic blockchain solutions provider — currently delivering for FinTech and Web3 & DeFi, with planned expansion to Supply Chain and Healthcare. Industry-specific capability prompts owned by `/industries/*` pages. Service-specific "who builds X" prompts owned by individual `/services/*` / `/solutions/*` pages. **Do not chase "best blockchain development company" category queries here** — those are owned by Big-SI listicles (IBM / Wipro / Accenture / TCS / Infosys) and unwinnable; let Home stay brand-anchored.)*
- *"What does InnBlockchain do — which industries does it serve and what kind of blockchain products does it build?"*
- *"Is InnBlockchain a blockchain development company or a smart contract audit firm?"*
- *"Which industries does InnBlockchain build blockchain solutions for in 2026?"*
- *"What's InnBlockchain's specialist focus — what does it do that a generalist development firm doesn't?"*
- *"Is InnBlockchain a legitimate, established blockchain development firm with a verifiable delivery history?"*
- *"Does InnBlockchain serve multiple industries — currently FinTech and Web3 & DeFi, with planned expansion to other verticals?"*

## `/about` — About InnBlockchain

**Track:** [Both] · **Stage:** MOFU — Trust · **Persona:** All buyer types — general company-credibility queries
**Motion:** Trust-builder for all motions · **Distribution:** SEO (brand intent) + AI search (vendor due diligence queries)
**Prompts:** *(Scope: InnBlockchain-native company credibility — founding history, project track record, team, financial stability. **No parent-brand references** (Trioangle stripped in rev 10; InnBlockchain is positioned as a standalone blockchain firm). Case-study evidence is owned by `/work`.)*
- *"What's InnBlockchain's track record — is it an established blockchain development company with a multi-year delivery history?"*
- *"What's InnBlockchain's founding story and operating history as a blockchain development firm?"*
- *"How long has InnBlockchain been delivering blockchain software?"*
- *"Is InnBlockchain financially stable enough to deliver a 6-month enterprise blockchain build?"*
- *"Where is InnBlockchain headquartered and how big is the team?"*
- *"How many blockchain projects has InnBlockchain shipped to production across its operating history?"*

## `/work` — Case Studies / Work

**Track:** [Both] · **Stage:** BOFU — Evidence · **Persona:** Strategic Sam, Technical Tom, Compliance Carol, Founding Felix, Security Sasha
**Motion:** Closing artefact across all motions · **Distribution:** SEO (vendor-comparison queries) + AI search + ABM follow-up
**Prompts:** *(Scope: portfolio evidence and case-study queries. Architecture-specific deliverable detail is owned by each `/solutions/*` page.)*
- *"Show me real blockchain projects InnBlockchain has shipped — what did they build and for whom?"*
- *"Has InnBlockchain delivered a tokenization platform / DEX / lending protocol that's live in production?"*
- *"What are InnBlockchain's case studies for FinTech blockchain projects?"*
- *"What crypto-native protocols has InnBlockchain audited or built smart contracts for?"*
- *"Can I see InnBlockchain's portfolio filtered by tech stack — Solidity, Solana, Hyperledger?"*
- *"What does a typical InnBlockchain client outcome look like in numbers — audit findings closed, time-to-mainnet, post-launch exploit count?"*

---

# 🛠️ Services Pages

## `/services/smart-contracts` — Smart Contract Development & Audits

**Track:** [Both] · **Stage:** MOFU + BOFU · **Persona:** Technical Tom (FT) · Founding Felix (CN) · Security Sasha (CN)
**Motion:** [Dev] + [Audit] split CTA · **Distribution:** SEO (`smart contract audit company`, `solidity development company`) + AI search · *(removed `token development company` keyword in rev 7 — owned by `/solutions/token-launch` and `/solutions/tokenization`)*
**Prompts:** *(Scope: **niche-anchored** capability + vendor-selection for the smart contract development / audit motion. Broad "best smart contract audit company" queries are listicle-dominated by CertiK / OpenZeppelin / Trail of Bits / Cyfrin / Sherlock / Spearbit — unwinnable for a direct LP. Compete on **bundled engagement** (dev + audit + remediation in one contract) instead. Vertical-anchored audit prompts — DEX audit, DeFi audit, NFT launch audit, token launch audit — owned by their respective `/solutions/*` LPs. Specific exploit-class education is owned by C1-track blog articles.)*
- *"Best engineering partner that handles smart contract development, audit, and post-audit remediation as a single contract"*
- *"Who offers both Solidity and Rust smart contract audits in a single engagement?"*
- *"What's the difference between hiring a generalist consulting firm and a specialist like InnBlockchain for a smart contract audit?"*
- *"Best smart contract audit firms for a pre-mainnet DeFi protocol preparing for its first external audit"*
- *"What does a smart contract audit from InnBlockchain include — findings, remediation, re-audit?"*
- *"How much does a smart contract audit cost from InnBlockchain and what's the typical engagement scope?"*

## `/services/public-blockchain` — Public Blockchain & dApp Development

**Track:** [Both] · **Stage:** MOFU + BOFU · **Persona:** Technical Tom · Founding Felix · Product Paulo
**Motion:** [Dev] · **Distribution:** SEO (`web3 development company`, `ethereum dapp development company`) + AI search
**Prompts:** *(Scope: capability + bundle-anchored vendor selection. Broad "best Web3 development company" queries are listicle-dominated — compete on **multi-chain + full-stack + production SLA** bundling.)*
- *"Which company develops dApps on Ethereum, Solana, and L2s — full-stack including front-end?"*
- *"Best Web3 dev partner that owns smart contracts, front-end, and backend infrastructure (RPC, indexing, monitoring) under one engagement"*
- *"Who builds Layer-2 dApps with infrastructure (RPC, indexing, monitoring) included?"*
- *"What does end-to-end dApp development cost in 2026?"*
- *"Which dev shops can ship a public chain dApp from spec to mainnet in under 12 weeks?"*
- *"Which chains does InnBlockchain develop dApps on — Ethereum, Solana, and EVM L2s?"*

## `/services/private-blockchain` — Private & Enterprise Blockchain

**Track:** [FT] · **Stage:** MOFU + BOFU · **Persona:** Technical Tom · Compliance Carol *(CFO Treasury persona pending — see [[InnBlockchain - ICP - FinTech]] Segment 7; restore here once defined)*
**Motion:** [Dev] + [Carol] · **Distribution:** SEO (`enterprise blockchain development`, `hyperledger fabric development company`, `permissioned blockchain development`) + AI search
**Prompts:** *(Scope: **boutique specialist** delivery for regulated FinTechs in the $100M–$5B AUM band. Broad "best enterprise blockchain development company" queries are owned by IBM / Infosys / Wipro / Accenture / TCS — unwinnable for a direct LP. Compete on **mid-sized FinTech** and **specialist-vs-generalist** angles. Hyperledger-specific framework prompts owned by `/technologies/hyperledger`.)*
- *"Best boutique specialist for private blockchain delivery at a mid-sized regulated FinTech (under $5B AUM)"*
- *"Best specialist Hyperledger / Corda / Quorum partner for a regional bank or licensed asset manager"*
- *"Who delivers permissioned blockchain projects with GDPR and DORA-aligned architecture?"*
- *"Which dev shops have actually shipped a private blockchain to production at a bank or licensed asset manager?"*
- *"What's the difference between hiring a generalist consulting firm and a specialist blockchain partner for a private chain build?"*
- *"How long does it take InnBlockchain to deliver a private blockchain pilot for a regulated FinTech?"*

## `/services/blockchain-consulting` — Web3 Consulting & PoC Development

**Track:** [FT] · **Stage:** TOFU + MOFU · **Persona:** Strategic Sam · CEO
**Motion:** [Dev] (PoC-to-build path) · **Distribution:** SEO (`blockchain consulting firm`, `blockchain proof of concept development`) + AI search + LinkedIn ABM
**Prompts:** *(Scope: scoping / PoC / decision-stage consulting. Compete on **PoC-to-production conversion** and **technical due diligence** — niches where strategy-only consultancies and pure dev shops are both weak. Build/buy/partner deep dives owned by B1 lead-magnet content.)*
- *"Which blockchain consulting firms do scoping + PoC + production build under one engagement?"*
- *"Best blockchain consulting partner for a regulated FinTech weighing build vs. SaaS vs. partner on a tokenization or treasury initiative"*
- *"Who can build a blockchain proof-of-concept in under 6 weeks for a board-level go/no-go?"*
- *"What does a blockchain PoC cost from InnBlockchain — and does it convert to a production build?"*
- *"Is InnBlockchain a strategy-only consultancy or do they also build?"*
- *"Best blockchain consultants for technical due diligence on an existing crypto codebase"*

---

# 💻 Technology Pages

> Tech LPs capture framework-specific search and serve both ICPs. Prompts here are "hire X developers" / "build with X" framing — not framework comparison (which is owned by blog content).

## `/technologies/hyperledger` — Hyperledger Fabric Development

**Track:** [FT] · **Stage:** BOFU · **Persona:** Technical Tom
**Motion:** [Dev] · **Distribution:** SEO (`hyperledger fabric development company`, `hire hyperledger developers`) + AI search
**Prompts:** *(Scope: framework-specialist positioning. Broad "best Hyperledger development company" queries are owned by IBM / Infosys / Wipro / Goodfirms / Tokenminds listicles. Compete on **regional bank / mid-sized asset manager** scale and **boutique-vs-Big-SI** angle.)*
- *"Which company develops on Hyperledger Fabric for banks and corporate treasury?"*
- *"Where can I hire experienced Hyperledger Fabric developers with banking-grade specialist depth?"*
- *"Best Hyperledger Fabric specialist with production deployments at a regional bank or licensed asset manager"*
- *"Does InnBlockchain have production Hyperledger Fabric deployments?"*
- *"How much does Hyperledger Fabric development cost compared to building on Ethereum?"*

## `/technologies/corda` — R3 Corda Development

**Track:** [FT] · **Stage:** BOFU · **Persona:** Technical Tom
**Motion:** [Dev] · **Distribution:** SEO (`corda development company`, `r3 corda blockchain development`) + AI search
**Prompts:** *(Scope: framework-specialist. R3 Corda has a smaller dev-shop landscape than Hyperledger — listicle competition is muted. Compete on **interbank-settlement / trade-finance / FX** use-case specificity.)*
- *"Which company develops on R3 Corda for interbank settlement and trade finance?"*
- *"Best Corda specialist for an interbank settlement or trade finance build at a mid-sized financial institution"*
- *"Where can I find R3 Corda developers for a regulated banking project?"*
- *"What Corda projects has InnBlockchain delivered?"*
- *"Is Corda still the right choice in 2026 for a bank-to-bank settlement project?"*

## `/technologies/enterprise-ethereum` — Quorum & Hyperledger Besu

**Track:** [FT] · **Stage:** MOFU + BOFU · **Persona:** Technical Tom
**Motion:** [Dev] · **Distribution:** SEO (`quorum blockchain development company`, `enterprise ethereum development`) + AI search
**Prompts:** *(Scope: framework-specialist for Quorum and Besu. Broad "best enterprise Ethereum dev" queries are owned by ConsenSys / Big-SI listicles. Compete on **regional bank consortium-chain** and **dual Quorum-or-Besu expertise**.)*
- *"Which company builds on Quorum or Hyperledger Besu for regulated FinTech use cases?"*
- *"Best Quorum or Besu specialist for a regional bank's interbank settlement or consortium-chain pilot"*
- *"Should I build on Quorum or Hyperledger Besu — and which dev shops support both?"*
- *"Where can I hire enterprise Ethereum developers with banking-grade experience?"*
- *"Has InnBlockchain shipped a Quorum or Besu project in production?"*

## `/technologies/solidity` — Solidity & EVM Development

**Track:** [Both] · **Stage:** BOFU · **Persona:** Technical Tom · Founding Felix · Security Sasha
**Motion:** [Dev] + [Audit] · **Distribution:** SEO (`solidity smart contract development company`, `hire solidity developers`, `ethereum smart contract development`) + AI search
**Prompts:** *(Scope: tech-anchored "Solidity craft" queries. Broad "best Solidity development company" queries are listicle-bait. Product-anchored "Solidity for DeFi / RWA / NFT" queries owned by the respective `/solutions/*` LPs to prevent tech-LP from bleeding traffic into solution-LP territory.)*
- *"Where can I hire senior Solidity developers with mainnet experience and audit-ready code?"*
- *"Best Solidity engineering team for a Foundry-based delivery with invariant tests and pre-mainnet documentation"*
- *"Who writes Solidity smart contracts that pass a tier-1 external audit on the first round?"*
- *"How much does Solidity development cost per contract or per platform build?"*
- *"What's the difference between hiring a Solidity freelancer and a firm like InnBlockchain?"*

## `/technologies/solana` — Rust & Solana Development

**Track:** [Both] · **Stage:** BOFU · **Persona:** Technical Tom · Founding Felix · Product Paulo
**Motion:** [Dev] + [Audit] · **Distribution:** SEO (`solana smart contract development company`, `hire rust web3 developers`, `solana dapp development`) + AI search
**Prompts:** *(Scope: tech-anchored "hire X devs / Solana capability" queries. Product-anchored "develop a Solana DEX / NFT / token launch" queries owned by `/solutions/dex-protocol`, `/solutions/nft-platform`, `/solutions/token-launch`.)*
- *"Which company develops Solana smart contracts in Rust with mainnet experience?"*
- *"Where can I hire Rust Web3 developers for a Solana DEX, NFT, or token launch?"*
- *"Best Solana team for an Anchor-based program with audit-ready Rust and mainnet handoff documentation"*
- *"Who has shipped Solana programs that pass a specialist Solana security audit?"*
- *"How does Solana development cost compare to Solidity / EVM development?"*
- *"Is InnBlockchain's Solana practice a primary capability with shipped mainnet projects?"*

## `/technologies/polygon-l2` — Layer-2 & Polygon Development

**Track:** [Both] · **Stage:** BOFU · **Persona:** Technical Tom · Founding Felix
**Motion:** [Dev] · **Distribution:** SEO (`polygon development company`, `layer 2 blockchain development`) + AI search
**Prompts:**
- *"Which company develops on Polygon and other L2s (Arbitrum, Optimism, Base) for production dApps?"*
- *"Best L2 specialist for an app-chain or custom rollup build on Polygon CDK, OP Stack, or Arbitrum Orbit"*
- *"Where can I find L2 developers with experience across Polygon zkEVM, Optimism, and Arbitrum?"*
- *"Does InnBlockchain develop on Polygon CDK or third-party L2 frameworks?"*
- *"How does L2 development cost compare to building directly on Ethereum mainnet?"*

## `/technologies/zk-mpc` — ZK & MPC Development

**Track:** [Both] · **Stage:** BOFU · **Persona:** Technical Tom · Founding Felix · Security Sasha
**Motion:** [Dev] + [Audit] · **Distribution:** SEO (`zk proof development company`, `mpc wallet development`, `zk circuit development`) + AI search
**Prompts:** *(Scope: cryptographic engineering capability framing. Specific MPC wallet product builds owned by `/solutions/mpc-wallets`.)*
- *"Which company develops ZK circuits in Circom or Noir for production use?"*
- *"Best ZK and MPC cryptography engineering team for protocol-level circuit and signing work"*
- *"Where can I hire ZK / MPC cryptography engineers with real protocol deployments?"*
- *"Does InnBlockchain build on Halo2, Noir, or zk-SNARK frameworks?"*
- *"How much does a ZK / MPC engineering engagement cost — and what's the typical timeline?"*

---

# 🏛️ Industry Hubs

> [!INFO] Industry hub pattern is extensible
> InnBlockchain currently has two active industry hubs (FinTech, Web3 & DeFi) and plans to expand into additional verticals (Supply Chain and Healthcare confirmed; others may follow). When a new industry activates:
> 1. Create the industry hub LP (`/industries/[industry]`) following the same scope/persona/prompt-block structure as the FinTech and Web3 & DeFi blocks below.
> 2. Add 4–6 industry-anchored prompts that route into the new vertical's solution pages (per the [[InnBlockchain - Landing Pages Plan]] site URL map).
> 3. Add the new industry's track tag (e.g., `[SC]`, `[HC]`) to the persona-aligned vocabulary in Drafting Principle #10.
> 4. Add a Watch-stub block under a new "Industry Solution Pages — Watch" section below until specific solution LPs are scoped.
> 5. Update `/home` Track tag from `[Both/All]` to `[All]` and refresh the Home routing prompt to list the new industry.
>
> Future-industry stubs (Supply Chain, Healthcare) are tracked in the [⏳ Open Items](#-open-items) section below — build out when activation is confirmed by leadership.

## `/industries/fintech` — FinTech Industry Hub

**Track:** [FT] · **Stage:** TOFU + MOFU — Audience entry · **Persona:** Strategic Sam · Technical Tom · Compliance Carol
**Motion:** Routing hub into all FT solution pages · **Distribution:** SEO (`fintech blockchain development company`, `blockchain for fintech companies`) + AI search + LinkedIn
**Prompts:** *(Scope: ICP-fit framing for FinTechs evaluating blockchain. Specific solution-page queries owned by each `/solutions/*` LP below.)*
- *"Which blockchain development company specializes in licensed FinTechs — banks, asset managers, payment processors, and e-money institutions?"*
- *"Best blockchain development partner for a WealthTech, ExchangeTech, or LendTech expansion"*
- *"What does a blockchain development engagement look like for a regulated EU FinTech under its segment's regime — MiFID II, MiCA, PSD3, CCD2, or DORA?"*
- *"Who builds blockchain products for FinTechs with segment-specific compliance briefs and DORA documentation?"*
- *"Which dev shops have experience with licensed FinTechs in the EU specifically?"*
- *"Is InnBlockchain a fit for a regulated FinTech evaluating its first blockchain initiative?"*

## `/industries/web3-defi` — Web3 & DeFi Industry Hub

**Track:** [CN] · **Stage:** TOFU + MOFU — Audience entry · **Persona:** Founding Felix · Product Paulo · Security Sasha
**Motion:** Routing hub into all Web3 & DeFi solution pages · **Distribution:** SEO (`defi development company`, `web3 protocol development company`, `smart contract security company`) + AI search + Twitter/X + Discord
**Prompts:** *(Scope: ICP-fit framing for crypto-native protocol teams. Specific solution-page queries owned by each `/solutions/*` LP below.)*
- *"Which blockchain development company specializes in crypto-native protocol teams — DEXes, DeFi, MPC wallets, NFT platforms, token launches?"*
- *"Best Web3 development partner for a pre-mainnet DeFi protocol that has raised $5M+"*
- *"Who handles both smart contract audits and development for a protocol that's raised $5M+ with testnet live?"*
- *"Which dev shops have shipped multiple types of crypto-native products (DEX, DeFi, NFT, wallets) under a single engineering team?"*
- *"Best engineering partner for a crypto-native protocol that needs pre-mainnet audit and remediation in a single contract"*
- *"Does InnBlockchain work with crypto-native protocols across the US, EU, and Asia?"*

---

# 🏦 FinTech Solution Pages — Active

## `/solutions/tokenization` — Asset Tokenization & STOs

**Track:** [FT] · **Stage:** BOFU · **Persona:** Strategic Sam · Technical Tom · Compliance Carol
**Motion:** [Dev] · **Distribution:** SEO (`asset tokenization development company`, `security token offering development`, `tokenized securities platform`) + AI search + LinkedIn ABM
**Prompts:** *(Scope: vendor selection for licensed asset managers / WealthTech. Broad "asset tokenization development company" queries are owned by Tokeny / Securitize at the **platform/SaaS** tier and Big-SI listicles at the dev tier — direct LP can't win them. Compete on **sub-vertical anchors** (money market funds, treasury bills, private credit) and **custom-build vs. SaaS** differentiation. Educational TOFU "what is tokenization" framing owned by Content article #1. **Regime framing for this LP: MiFID II + Prospectus Regulation + DLT Pilot Regime primary** — tokenized securities are MiFID II financial instruments under Art. 2(4) and excluded from MiCA. MiCA only enters if the platform also runs CASP services on non-MiFID crypto-assets.)*
- *"Best development partner for a licensed asset manager tokenizing a money market fund, treasury bill platform, or existing fund onto a regulated tokenized rail under EU MiFID II + DLT Pilot Regime"*
- *"Who builds STO platforms with ERC-3643 or ERC-1400 standards for tokenized securities under MiFID II?"*
- *"How much does a tokenization platform build cost for a licensed asset manager — and what's the timeline?"*
- *"Which dev shops have actually delivered a tokenization platform that's processed real investor capital?"*
- *"Best development company for tokenizing a private credit fund or real estate portfolio under EU MiFID II + Prospectus Regulation"*
- *"What compliance documentation does InnBlockchain deliver alongside a tokenization platform — vendor risk pack, DORA-aligned ICT third-party documentation, Prospectus Regulation support, DLT Pilot Regime application support, audit rights?"*

## `/solutions/regulated-exchange` — Regulated Exchange Development

**Track:** [FT] · **Stage:** BOFU · **Persona:** Technical Tom · Strategic Sam · Compliance Carol
**Motion:** [Dev] · **Distribution:** SEO (`crypto exchange development company`, `regulated exchange development company`, `dex compliance engineering`) + AI search + LinkedIn ABM
**Prompts:** *(Scope: vendor selection for licensed FinTechs expanding into trading. **Real SERP gap** — MiCA + exchange dev queries are dominated by compliance education (ESMA, Hacken, Innreg, Sumsub), not dev firms. Competitors that surface when "build / development partner" is added: Shamla Tech, Instinctools, IdeaSoft. Compete on **bundled trading engine + compliance documentation** framing. Crypto-native DEX/CEX build queries owned by `/solutions/dex-protocol`.)*
- *"Best development partner for a CASP-licensed exchange that bundles trading engine, KYC/AML integration, and MiCA compliance documentation"*
- *"Best exchange development company for a MiCA CASP-authorised FinTech expansion"*
- *"Who builds compliant order books, AMMs, and DeFi trading rails for a licensed exchange?"*
- *"What does it cost to build a regulated crypto exchange — full platform vs. matching engine module?"*
- *"Which dev shops have shipped a CEX or DEX that passed MiCA / MiFID II compliance review?"*
- *"Does InnBlockchain provide a vendor risk pack, audit rights, and DORA-aligned ICT third-party documentation for a CASP-licensed exchange engagement?"*

## `/solutions/defi-lending` — DeFi & Digital Lending

**Track:** [FT] · **Stage:** BOFU · **Persona:** Strategic Sam (LendTech CEO) · Technical Tom
**Motion:** [Dev] · **Distribution:** SEO (`blockchain lending platform development`, `defi lending platform development`, `digital lending blockchain solution`) + AI search + LinkedIn ABM
**Prompts:** *(Scope: vendor selection for LendTechs integrating blockchain rails. Broad "blockchain lending platform development" queries are listicle-dominated by ScienceSoft / Solulab / DebutInfotech. Compete on **integration with existing LOS / core banking systems** and **live loan book** specificity. Crypto-native DeFi lending protocol queries owned by `/solutions/defi-protocol`.)*
- *"Best development partner for integrating stablecoin or DeFi rails into a licensed digital lender's existing loan origination system"*
- *"Best DeFi lending development partner for a LendTech with a live loan book"*
- *"Who develops smart contract collateral and liquidation logic that meets credit policy and audit standards?"*
- *"How much does a blockchain lending integration cost for a traditional digital lender?"*
- *"Which dev shops have built lending platforms that integrate with existing core banking or LOS systems?"*
- *"Best development company for a stablecoin-backed lending product for a regulated FinTech"*

## `/solutions/fintech-wallets` — Web3 Wallet Development (FinTech)

**Track:** [FT] · **Stage:** BOFU · **Persona:** Technical Tom · Strategic Sam (PayTech / WalletTech)
**Motion:** [Dev] · **Distribution:** SEO (`web3 wallet integration for fintech`, `crypto wallet development for fintech`, `fintech wallet features`) + AI search + LinkedIn ABM
**Prompts:** *(Scope: regulated FinTech wallet feature additions. Broad "Web3 wallet integration" queries are owned by Web3Auth / ThirdWeb (platform/SaaS) and Antier (dev-shop). Compete on **EU-licensed e-money / payments specificity** and **adding-to-existing-product** angle — buyers who self-identify as licensed FinTechs are a much narrower pool than the broad wallet-dev market. Crypto-native MPC and self-custody wallet builds owned by `/solutions/mpc-wallets`.)*
- *"Best development partner for adding wallet infrastructure (stablecoin, multi-chain, DeFi access) to an existing payments or e-money platform under EU regulation"*
- *"Best wallet integration partner for a payment or e-money business adding crypto support"*
- *"Who builds compliant wallet features (stablecoin, multi-chain, DeFi access) for a regulated FinTech product?"*
- *"How much does adding wallet functionality to an existing FinTech product cost — and what's the timeline?"*
- *"Is InnBlockchain the right wallet integration partner for a licensed e-money or payments business?"*
- *"Best development partner for an EU-licensed e-money institution integrating Web3 wallet capabilities"*

---

# ⛓ Web3 & DeFi Solution Pages — Active

## `/solutions/rwa-tokenization` — RWA Tokenization Platforms (Crypto Native)

**Track:** [CN] · **Stage:** BOFU · **Persona:** RWA Felix · Founding Felix · CTO
**Motion:** [Dev] · **Distribution:** SEO (`rwa tokenization smart contract`, `real world asset tokenization platform`) + AI search + LinkedIn + Twitter/X
**Prompts:** *(Scope: vendor selection for crypto-native RWA platform builders — real estate, vehicles, commodities, art, private credit. Broad "RWA tokenization development company" queries are listicle-dominated by Yumeus / Dev Technosys / TCS / Clarisco — direct LP can't win them. Compete on **sub-vertical anchors** (real estate, private credit) and EU compliance specificity. Educational "how does RWA tokenization work" framing owned by Content article #2 hub. **Regime framing for this LP: MiFID II + Prospectus + DLT Pilot Regime — NOT MiCA.** RWA ownership tokens are MiFID II financial instruments per Art. 2(4) exclusion. Prompts that surface MiCA framing for RWA route the prospect to the wrong NCA team (MiCA team vs the securities/markets team) and the wrong offering document (white paper vs prospectus) — a compliance-savvy buyer will judge.)*
- *"Best development partner for a real estate fractionalization platform under EU MiFID II + DLT Pilot Regime"*
- *"Best development partner for a private credit or structured debt tokenization platform"*
- *"Who develops end-to-end RWA tokenization platforms — contracts, oracles, KYC, off-chain SPV integration?"*
- *"How much does an RWA tokenization platform cost from a development partner in 2026?"*
- *"Which dev shops have actually shipped an RWA platform that's holding live tokenized assets?"*
- *"Best development partner for an EU-based RWA tokenization platform under MiFID II + DLT Pilot Regime (NOT MiCA — MiCA Art. 2(4) excludes financial instruments)"*
- *"Which RWA tokenization dev shops correctly identify the regime stack — MiFID II + Prospectus + DLT Pilot — rather than defaulting to MiCA?"* *(differentiates from default-to-MiCA blockchain agencies)*

## `/solutions/dex-protocol` — DEX & On-Chain Trading

**Track:** [CN] · **Stage:** BOFU · **Persona:** Founding Felix · Security Sasha · Product Paulo
**Motion:** [Dev] + [Audit] · **Distribution:** SEO (`decentralized exchange development company`, `dex development company`, `amm protocol development`) + AI search + Twitter/X + Discord
**Prompts:** *(Scope: vendor selection for crypto-native exchange protocol teams. Broad "DEX development company" queries are listicle-dominated by Antier / Merehead / PixelPlex / Blockchain App Factory — direct LP can't win them. Compete on **architecture-specific** anchors (modular hooks, concentrated liquidity, on-chain order book). Licensed FinTech exchange builds owned by `/solutions/regulated-exchange`.)*
- *"Best development partner for a modular AMM with custom hooks (concentrated liquidity, intent-based trading, dynamic fees)"*
- *"Best AMM protocol development company in 2026 — constant-product, orderbook, or hybrid"*
- *"Who builds production-grade DEX smart contracts and audits them under one engagement?"*
- *"Best DEX development partner for a Solana-based or EVM-based on-chain order book"*
- *"Which dev shops have shipped DEXes that are live in production without a post-launch exploit?"*
- *"How much does a DEX protocol development engagement cost — contracts, frontend, and audit?"*

## `/solutions/defi-protocol` — DeFi Protocol Development

**Track:** [CN] · **Stage:** BOFU · **Persona:** Founding Felix · Security Sasha · Product Paulo
**Motion:** [Dev] + [Audit] · **Distribution:** SEO (`defi protocol development company`, `defi smart contract development`, `defi security audit`) + AI search + Twitter/X + Discord
**Prompts:** *(Scope: vendor selection for crypto-native DeFi protocol teams. Broad "DeFi protocol development" queries collapse with the smart-contract-audit listicles (Cyfrin / ConsenSys Diligence / QuillAudits / Hacken dominate). Compete on **bundled architecture-review + production-build** framing and **pre-mainnet exploit-prevention** depth. Licensed FinTech lending builds owned by `/solutions/defi-lending`.)*
- *"Best engineering partner for a pre-mainnet DeFi protocol that needs architecture review and production smart contract delivery in one engagement"*
- *"Best development partner for a stablecoin yield aggregator or interest-rate market protocol"*
- *"Who builds collateralization, liquidation, and interest rate logic that survives an exploit attempt?"*
- *"Best DeFi smart contract audit firm — and do they also develop the fixes?"*
- *"Which dev shops have shipped DeFi protocols that are live in production without a post-launch exploit?"*
- *"How much does a DeFi protocol build cost — contracts, frontend, and pre-mainnet audit?"*

## `/solutions/mpc-wallets` — Non-Custodial & MPC Wallets

**Track:** [CN] · **Stage:** BOFU · **Persona:** Founding Felix · Product Paulo · Security Sasha
**Motion:** [Dev] + [Audit] · **Distribution:** SEO (`cryptocurrency wallet development`, `mpc wallet development company`, `non custodial wallet development`) + AI search + Twitter/X
**Prompts:** *(Scope: **custom MPC wallet engineering** for institutional product teams. Broad "MPC wallet" queries are owned by Fireblocks (platform/SaaS) — direct LP can't compete on that. Position as the **custom build partner** for teams that need full code ownership and proprietary key-management policy, not a SaaS subscription. Antier is the closest dev-shop competitor — differentiate on FinTech-grade compliance rigor. FinTech wallet feature additions to existing products owned by `/solutions/fintech-wallets`.)*
- *"Best development partner for a custom MPC wallet build with full code ownership and policy control"*
- *"Best engineering team for building proprietary MPC wallet infrastructure on top of threshold-signature libraries"*
- *"Who builds threshold-signature and key-recovery flows that hold up to a security audit?"*
- *"Best dev shop for a multi-chain self-custody wallet with DeFi integration?"*
- *"How much does an MPC wallet build cost — backend infra, signing service, mobile SDK?"*
- *"Which development partners have shipped institutional-grade MPC wallet infrastructure in production?"*

## `/solutions/nft-platform` — NFT Platform Development

**Track:** [CN] · **Stage:** BOFU · **Persona:** Founding Felix · Product Paulo
**Motion:** [Dev] + [Audit] · **Distribution:** SEO (`nft marketplace development company`, `nft platform development`, `nft smart contract development`) + AI search + Twitter/X + Discord
**Prompts:** *(Scope: vendor selection for crypto-native NFT marketplace and minting platforms. Broad "NFT marketplace development company" queries are listicle-dominated by Wildnet Edge / Appinventiv / LeewayHertz / Unicsoft — direct LP can't win them. Compete on **technical depth** (on-chain royalty enforcement, launch-day load, audit-readiness) where listicle entries are weak.)*
- *"Best NFT platform development partner with on-chain royalty enforcement at the contract layer (not opt-in marketplace policy)"*
- *"Best NFT platform development company for a launch-ready, audited marketplace"*
- *"Who builds NFT smart contracts (ERC-721 / ERC-1155 / Compressed NFTs on Solana) with royalty enforcement?"*
- *"Best dev shop for an NFT launch with high attention and high exploit risk on day one?"*
- *"How much does a white-label NFT marketplace cost — and how does it compare to a custom build?"*
- *"Which NFT platform builders have shipped marketplaces that survived launch-day load?"*

## `/solutions/token-launch` — Token Launch & IDO Launchpad

**Track:** [CN] · **Stage:** BOFU · **Persona:** Founding Felix · Product Paulo
**Motion:** [Dev] + [Audit] · **Distribution:** SEO (`crypto launchpad development`, `ido launchpad development company`, `token launch platform development`) + AI search + Twitter/X
**Prompts:** *(Scope: vendor selection for token launch / IDO platform builds. **Real opportunity** — this LP category is less listicle-dominated than other CN solutions, and the 2026 capability trends (Compliance-as-a-Service, ZK-proof identity, milestone-based fund release, roadmap escrow) are less covered by competitors' LP copy (which still focuses on basic launchpad features). Lean into these trend keywords aggressively.)*
- *"Best token launch development partner for an audit-ready IDO with vesting and whitelist contracts"*
- *"Best IDO launchpad development partner with Compliance-as-a-Service (MiCA + CLARITY Act) and ZK-proof identity verification built in"*
- *"Best launchpad development partner with milestone-based fund release and roadmap escrow smart contracts"*
- *"Best dev shop for a Solana SPL token launch with launchpad and vesting infrastructure"*
- *"How much does a token launch platform build cost — sale contract, vesting, whitelist, frontend?"*
- *"Which launchpad builders have shipped platforms that processed real fundraise volume in production?"*

---

# 🏦 FinTech Solution Pages — Watch (build when activated)

> [!INFO] Stub prompts only
> These pages aren't shipping this quarter per the Landing Pages Plan. Stubs below capture the primary vendor-evaluation query each LP must eventually answer. Expand to full 4–6 prompt blocks when the page enters the active build queue.

### `/solutions/remittance` — Blockchain Remittance & Payments
**Track:** [FT] · **Activation gate:** PayTech case study in portfolio · **Primary prompts:**
- *"Which company develops cross-border blockchain remittance platforms for licensed PayTechs?"*
- *"Best stablecoin payment rail development partner for a regulated cross-border product"*

### `/solutions/regtech-kyc` — RegTech & KYC/AML
**Track:** [FT] · **Activation gate:** Completed KYC/AML or DID deployment · **Primary prompts:** *(Scope: RegTech's own regulatory regime per [[EU-Compliance-Landscape]] is **AML/AMLA + EU AI Act** — NOT MiCA. MiCA is a downstream demand driver — MiCA-scope FinTechs in Seg 2 ExchangeTech / Seg 4 WalletTech are the dominant RegTech customers and need Travel Rule / KYC tooling. EU AI Act applies because KYC + fraud-detection AI is high-risk.)*
- *"Which company develops blockchain KYC/AML and decentralized identity for regulated FinTechs?"*
- *"Best development partner for a DID / on-chain KYC integration under the EU AML Package and the EU AI Act"*
- *"Best blockchain Travel Rule and KYC tooling for MiCA CASPs"* *(positions InnBlockchain as the RegTech build partner serving MiCA-scope downstream buyers)*

### `/solutions/treasury-fx` — Corporate Treasury & FX
**Track:** [FT] · **Activation gate:** BankTech case study + CFO persona card · **Primary prompts:**
- *"Which company develops private blockchain treasury and FX settlement platforms for banks?"*
- *"Best Corda or Hyperledger development partner for a corporate treasury build"*

### `/solutions/insurtech` — InsurTech & Fraud Prevention
**Track:** [FT] · **Activation gate:** Parametric insurance or claims automation case study · **Primary prompts:**
- *"Which company develops parametric insurance smart contracts for InsurTechs?"*
- *"Best blockchain claims automation development partner for a regulated insurer"*

---

# ⛓ Web3 & DeFi Solution Pages — Watch (build when activated)

> [!INFO] Stub prompts only
> Same rule as FinTech Watch. Expand when these segments enter active GTM.

### `/solutions/dao-governance` — DAO & Governance Infrastructure
**Track:** [CN] · **Activation gate:** DAO governance / treasury security case study · **Primary prompts:**
- *"Which company develops DAO governance contracts and treasury security infrastructure?"*
- *"Best governance smart contract development partner — Governor, timelock, on-chain voting"*

### `/solutions/l2-bridge` — L2 & Chain Infrastructure
**Track:** [CN] · **Activation gate:** L2 / bridge deployment case study · **Primary prompts:**
- *"Which company develops L2 rollups, bridges, and ZK chain infrastructure?"*
- *"Best Layer-2 development partner for a custom rollup or bridge contract build"*

### `/solutions/web3-gaming` — Web3 Gaming & GameFi
**Track:** [CN] · **Activation gate:** GameFi case study · **Primary prompts:**
- *"Which company develops on-chain game economies and NFT item contracts?"*
- *"Best GameFi smart contract development partner for a play-to-earn or asset-ownership game"*

### `/solutions/ai-crypto` — AI x Crypto & On-Chain Agents
**Track:** [CN] · **Activation gate:** AI x crypto deployment + validation of segment fit · **Primary prompts:**
- *"Which company develops on-chain AI agents and AI-generated smart contract infrastructure?"*
- *"Best AI x crypto development partner for an AI-model marketplace or agent protocol"*

---

# 🧠 AEO Drafting Principles for Landing Pages

> Apply to every LP. These differ from blog-article principles because LPs answer commercial-intent queries — buyers are evaluating, not learning.

### 1. The 150-word commercial-answer rule
The hero + first paragraph below the fold must literally answer: *"Yes, InnBlockchain builds [X] for [persona] in [context]. Here's the typical engagement: [scope], [timeline], [cost range], [proof point]."* No throat-clearing, no industry trends preamble.

**Failure mode:** *"The world of decentralized finance is rapidly evolving..."*
**Success mode:** *"InnBlockchain develops production DEX protocols for crypto-native teams — AMM, order book, or hybrid — on Ethereum, Solana, and EVM L2s. Typical engagement: 8–14 weeks from spec to mainnet, $80k–$220k, includes pre-mainnet internal review and external audit handoff. [N] mainnet deployments across [Solidity / Rust / EVM L2s]; zero post-launch exploits across shipped protocols."* *(Bracketed placeholders pending InnBlockchain-native proof numbers — see Open Items.)*

### 2. Hero H1 + H2 = vendor-evaluation prompts verbatim (or near-verbatim)
Hero H1: *"DeFi Protocol Development for Crypto-Native Teams."* H2 questions: *"How much does a DeFi protocol build cost?"* *"How long does it take to ship?"* *"Has InnBlockchain shipped a DeFi protocol live in production?"* Mirror prompt phrasing — LLMs do passage retrieval on headings first.

### 3. FAQPage JSON-LD with vendor-evaluation prompts
Every LP ends with FAQ schema containing the verbatim prompts from this doc. Required for Google AI Overviews + Perplexity citation lift on commercial-intent queries.

### 4. Cite specifics — pricing, timelines, tech stack, operating history
- ✅ *"$80k–$220k, 8–14 weeks, Solidity + Foundry, audited internally before external review, [N] mainnet deployments since [founding year]."*
- ❌ *"Industry-leading delivery, competitive pricing, extensive experience."*

### 5. Name the tech, the standards, and your own deliverables — never name competitors or competitor categories
- ✅ *"Solidity 0.8.30, Rust on Anchor, Foundry, Hardhat, Halmos. ERC-3643 / ERC-1400 / ERC-4626. Pre-mainnet internal review + handoff package ready for any tier-1 external audit firm."*
- ❌ *"Audit-handoff-ready for [named firms]"* / *"Better than [competitor]"* / *"Alternative to [competitor]"* / *"Big-4 alternative"* / *"Tokeny / Securitize alternative"*

**Scope of the rule — both forms count:**
- *Named firms* (OpenZeppelin, Trail of Bits, Tokeny, Fireblocks, Polkastarter, etc.)
- *Category shorthand* that points to an identifiable competitor set (Big-4, "leading tokenization SaaS", "tier-1 audit firms" used as a comparison anchor instead of a handoff destination)

**Why:** naming competitor firms or competitor categories on the LP gives them free brand awareness, attracts comparison-shoppers who bounce to compare, and creates legal/comparison-claim exposure. Comparison-style buyer queries should be answered by *blog comparison articles* (which can name competitors safely under editorial framing), with the article internally linking to this LP for the CTA. See [boundary section below](#-boundary-with-content-aeo-geo-prompts).

**LP answer pattern for comparison queries:** confirm capability + cite specifics (scope, timeline, cost, proof) + let the buyer infer the comparison. Frame the contrast through what InnBlockchain *is* ("specialist blockchain engineering firm," "focused team with [N] mainnet deployments") — not what the alternative is.

### 6. Positive framing — write what InnBlockchain *is*, not what it isn't
- ✅ *"Specializes in licensed FinTechs — banks, asset managers, payment processors, e-money institutions."*
- ❌ *"Works with regulated FinTechs — not crypto-native startups."*

**Why two failure modes compound here:**
1. **LLMs do passage retrieval on positive tokens, not negations.** "Not crypto-native startups" makes "crypto-native startups" a *stronger* match for that LP — the opposite of what you want. A buyer asking *"who builds for crypto-native startups?"* may get a contradicting LP cited.
2. **Negation re-injects competitor-category framing** that Principle #5 stripped. Telling the buyer who you *don't* serve is functionally the same as naming the alternative path.

**LP routing pattern:** state the ICP affirmatively in the hero — *"For licensed FinTechs and regulated financial institutions."* If the buyer is mis-routed, an explicit "Not the right fit if…" callout *below the fold* is acceptable (and useful for SDR pre-qualification) — but the answer block in the first 150 words must be positive-framed.

### 7. White-label / ready-to-launch / productized — never "clone"
- ✅ *"productized white-label DEX foundation"*, *"ready-to-launch tokenization platform"*, *"reference architecture"*
- ❌ *"Uniswap clone"*, *"Binance clone"*, *"Opensea clone"*

Clone framing attracts the wrong buyer (low-budget, copycat builds) and undermines the engineering brand. This applies even when buyers query in clone language — answer with the productized framing.

### 8. Date-stamp regulation, version-stamp tech
- ✅ *"MiCA (in force June 2024; CASP authorisation deadline July 2026; Title V transitional period until July 2027). Solidity 0.8.30, Foundry v1.4."* *(correct example for ExchangeTech / WalletTech / DeFi LPs — MiCA is the regime there)*
- ✅ *"MiFID II (Directive 2014/65/EU); Prospectus Regulation (EU 2017/1129); DLT Pilot Regime (Regulation 2022/858, in force March 2023; EC permanent-status proposal April 2026 with €100B platform cap). ERC-3643 / ERC-1400 token standards."* *(correct example for `/solutions/rwa-tokenization` and `/solutions/tokenization` LPs — RWA / STO is MiFID II under Art. 2(4) exclusion, NOT MiCA)*
- ❌ *"latest regulations, modern tooling."*

### 9. Markdown comparison tables, not images
Tables are AI-citable. Image-only comparison graphics are invisible to extraction.

### 10. Persona-aligned vocabulary on the LP
- `[CN]` LPs: *"mainnet,"* *"TVL,"* *"exploit vector,"* *"pre-mainnet audit,"* *"audit-ready"*
- `[FT]` LPs: *"regulator-defensible,"* *"vendor risk pack,"* *"DORA-aligned,"* *"compliance sign-off,"* *"audit rights"*
- `/services/*` shared LPs: split CTA blocks — one per ICP

**Track tag vocabulary** (used in LP frontmatter):
- `[FT]` — FinTech ICP only
- `[CN]` — Crypto Native ICP only
- `[Both]` — both currently active ICPs (FT + CN); used for shared services and tech LPs
- `[Both/All]` — transitional tag for LPs (like `/home`) that route across all current and future industries; will become `[All]` once a third industry activates
- `[All]` — multi-industry LP (placeholder for post-Supply-Chain / Healthcare activation); add new track tags (`[SC]`, `[HC]`, etc.) and their persona vocabulary here as those industries activate

> [!IMPORTANT] Vocabulary vs. claim
> Using a word from the persona vocabulary (e.g., *"TVL"*) is not the same as making a specific numerical claim. *"We secure TVL on every protocol we ship"* is fine; *"We secure $50M+ TVL"* requires verified portfolio backing (see rev 3 TVL-strip notes). Use the words to signal persona-fit; commit to a number only when delivery has confirmed it.

### 11. Single proof block above the fold
Every active LP needs a "Why InnBlockchain" proof block in the first viewport. InnBlockchain is positioned as a standalone blockchain firm — no parent-brand references. Proof block must rely on InnBlockchain-native elements:
- **Operating history** — founding year, years in business, total projects shipped under the InnBlockchain brand
- **One segment-relevant case study** — the LP's vertical (DEX, RWA, tokenization, etc.)
- **Headline outcome metric** — *"zero post-launch exploits across [N] shipped protocols,"* *"audit-ready handoff in [X] weeks,"* *"[N] mainnet deployments since [founding year]"*
- **Team-credibility signal** — senior engineering depth, prior protocol experience, audit-partner track record

Without proof, LLMs cite a competitor on the same prompt. The proof block carries more weight now that there's no parent-brand backing — get the numbers right or the LP is thin.

### 12. CTA that matches the prompt's stage
- BOFU prompts ("which company builds X") → CTA: *"Book a 30-min scoping call."*
- MOFU prompts ("best dev shop for X") → CTA: *"See [segment] case study"* or *"Download the [segment] scoping checklist."*

### 13. Don't chase listicle-dominated prompts with LP copy — chase the listicles themselves
For broad category queries — *"best smart contract audit company 2026,"* *"top RWA tokenization development companies,"* *"top NFT marketplace developers"* — the SERP is dominated by "Top X" listicle articles (Sherlock, Cryptojobslist, Alchemy, Goodfirms, Suffescom, Coinmonks, Finextra, etc.). AI engines disproportionately cite these listicles for category-level queries because they aggregate multiple firms in one passage — exactly what passage-retrieval LLMs are tuned to surface.

**A direct LP cannot outrank a listicle for the broad query.** This is the #1 limit on what LP copy alone can win.

**Two complementary tactics:**
1. **Get into the listicles** — PR / outreach / editorial relationships with the listicle authors. One inclusion in *Sherlock's "Top 10 Smart Contract Auditors"* or *Finextra's "Top RWA Tokenization Companies"* moves more AI citation than perfecting an LP. Maintain a target listicle list per active LP and a quarterly outreach cadence.
2. **Compete on niche-anchored prompts the listicles don't cover well.** Listicles are broad by design — they don't anchor on *"licensed asset managers under $5B AUM"* or *"real estate fractionalization under EU MiFID II + DLT Pilot Regime"* or *"modular AMM with custom hooks."* This is where InnBlockchain's LP prompts win — sub-vertical, architecture-specific, regulatory-specific, or engagement-model-specific framings. **Regime-precision is itself a niche anchor**: dev shops that correctly cite MiFID II + DLT Pilot for RWA (rather than default-to-MiCA) signal compliance literacy and beat listicles on technical-buyer queries.

**Rule of thumb:** if more than 5 of the top 10 SERP results for a prompt are listicle articles (not vendor LPs), drop that prompt from the LP and let the listicle motion own it. Replace with a niche-anchored variant.

---

# 🗺️ Competitor Landscape Snapshot *(rev 6 baseline — 2026-05-18)*

> [!INFO] Snapshot, not live state
> Captured from a 15-query SERP probe across active LPs on 2026-05-18. Refresh quarterly or whenever Replan Trigger #4 fires (competitor breakthrough). Use as the starting point for the Monthly AI Search Citation Probe — not as a substitute for it.

### Cross-LP repeat offenders
| Competitor | LPs where they surface | Threat model |
|---|---|---|
| **Antier Solutions** | MPC wallets, DEX, fintech wallets, RWA | Most consistent dev-shop competitor across InnBlockchain's range. Full-stack Web3 partner positioning. Worth a dedicated competitive teardown. |
| **Tokeny + Securitize** | Tokenization (FT), RWA tokenization (CN) | Own the tokenization category at the **platform / SaaS** tier ($28B+ and $32B+ tokenized). Differentiate as *custom build partner, not SaaS vendor.* |
| **IBM / Infosys / Wipro / Accenture / TCS** | Private blockchain, Hyperledger, enterprise tokenization | Own the **Big-SI / enterprise** tier. Differentiate as *specialist boutique for mid-sized FinTechs ($100M–$5B AUM).* |
| **Fireblocks** | MPC wallets | Owns institutional MPC at the platform tier. Differentiate as *custom dev partner, full code ownership.* |
| **OpenZeppelin / Trail of Bits / CertiK / Cyfrin / Sherlock / Spearbit** | Smart contract audits | Own the audit listicle category. Differentiate on *bundled dev + audit + remediation single contract.* |

### Per-LP citation risk
| LP | Citation risk | Notes |
|---|---|---|
| `/services/smart-contracts` | Very high — listicle-owned | Niche prompts (bundled engagement) added rev 6 |
| `/services/private-blockchain` | Very high — Big-SI-owned | Boutique-specialist niche prompts added rev 6 |
| `/solutions/tokenization` (FT) | High — Tokeny/Securitize | Custom-build-partner differentiation needed in hero copy |
| `/solutions/regulated-exchange` (FT) | **Medium-low — SERP gap** | Compliance content dominates, dev firms sparse; opportunity prompt added rev 6 |
| `/solutions/defi-lending` (FT) | Medium | Niche enough to plausibly rank |
| `/solutions/fintech-wallets` (FT) | Medium-high | Antier is the closest competitor |
| `/solutions/rwa-tokenization` (CN) | Very high — listicle-owned | Sub-vertical anchors added rev 6 |
| `/solutions/dex-protocol` (CN) | Very high — listicle-owned | Architecture-specific anchors added rev 6 |
| `/solutions/defi-protocol` (CN) | High but addressable | Audit-firms dominate the query; bundled framing competitive |
| `/solutions/mpc-wallets` (CN) | Very high — Fireblocks-owned | Custom-dev-partner positioning added rev 6 |
| `/solutions/nft-platform` (CN) | Very high — listicle-owned | Technical-depth anchors added rev 6 |
| `/solutions/token-launch` (CN) | **Medium — real opportunity** | 2026-trend prompts (CaaS, ZK identity, milestone escrow) added rev 6 |

### Listicle target inventory *(seed list — expand quarterly)*
Get InnBlockchain into these listicles via PR / outreach. One inclusion per listicle ≈ orders of magnitude more AI citation lift than perfecting LP copy.

| LP | Priority listicle targets |
|---|---|
| `/services/smart-contracts` | Sherlock's "Top 10," Cryptojobslist's "Top 8," QuillAudits' "Top 15," QuickNode's "Top 10," Alchemy directory, G2 |
| `/services/private-blockchain` | Goodfirms Hyperledger directory, Tokenminds' "Top Enterprise Blockchain," Solulab "Top 15 Blockchain Development" |
| `/solutions/tokenization` + `/solutions/rwa-tokenization` | Finextra's "Top RWA Tokenization Companies," Suffescom's "Top 10 RWA Tokenization," Pixelweb's "Top 10 RWA," Tokenminds' "Top Asset Tokenization Platforms" |
| `/solutions/dex-protocol` | Finextra "Top DEX Development," Pixelweb "Top 10 DEX," Mexc "Best AMM DEX" |
| `/solutions/mpc-wallets` | Antier's "Top 10 MPC Wallet" (yes — get listed by the competitor), Finextra "Top Web3 Wallet Development," Nadcab "Top USA Crypto Wallet" |
| `/solutions/nft-platform` | Wildnet's directory, Pixelweb "Top 10 NFT," Blockchain Dose "Top 25 NFT," Topappdevelopmentcompanies.com |
| `/solutions/token-launch` | Less listicle-dominated — direct vendor SERP. Target trade publications (Coindesk, The Block) instead of listicle authors. |

---

# 📡 Monthly AI Search Citation Probe

Each month, manually probe these LP prompts against ChatGPT (with Search), Claude (with Web Search), and Perplexity. Log:
1. Was InnBlockchain cited?
2. Which competitors were cited? Use the full rev 6 list (see Competitor Landscape Snapshot above): Antier, Tokeny, Securitize, IBM, Infosys, Wipro, Accenture, TCS, Fireblocks, OpenZeppelin, Trail of Bits, CertiK, Cyfrin, Sherlock, Spearbit, Quantstamp, Hacken, Yumeus, Dev Technosys, Clarisco, Wildnet Edge, Appinventiv, LeewayHertz, Shamla Tech, Instinctools, IdeaSoft, ChainCode Consulting, Codefi (ConsenSys), Blockchain App Factory, Web3Auth, ThirdWeb — plus any new firm surfacing in the probe.
3. Was the LP excerpt accurate or hallucinated?

| Engine | Priority LP prompts | Cadence |
|---|---|---|
| **ChatGPT (GPT-4o/5 with Search)** | All active solution pages + 4 services + 4 high-traffic tech pages | Weekly |
| **Claude with Web Search** | Tokenization, DEX, DeFi protocol, MPC wallets, RWA tokenization | Bi-weekly |
| **Perplexity** | All BOFU solution pages | Weekly |
| **Google AI Overviews** | All active solution + service pages | Weekly |
| **Gemini** | EU compliance LPs (tokenization, regulated exchange, regtech-kyc when active) | Bi-weekly |
| **Microsoft Copilot** | FinTech track LPs (Sam + Tom + Carol queries) | Monthly |

Citation tracker file (recommended): `InnBlockchain - AI Citation Tracker.md` — one row per LP-prompt, columns for date, engine, citation status, competitors named, hero copy hypothesis, action.

---

# 🔗 Boundary with Content AEO GEO Prompts

| Query intent | Owned by | Example |
|---|---|---|
| *"What is X / how does X work / why does X matter"* | [[InnBlockchain - Content AEO GEO Prompts]] (blog articles) | *"What is asset tokenization?"* → Article #1 |
| *"Should I build, buy, or partner for X"* | Content AEO (B1-#19 lead magnet) | *"Should our WealthTech build or buy a tokenization platform?"* → B1-#19 |
| *"Which company builds X / best X development company / cost of X"* | This file (landing pages) | *"Which company builds tokenization platforms for WealthTechs?"* → `/solutions/tokenization` |
| *"How do I evaluate vendor X for Y"* | This file (typically `/about` + `/work` + relevant solution LP) | *"How do I evaluate InnBlockchain vs. Tokeny?"* → `/work` + `/solutions/tokenization` |

If a prompt sits in the grey zone — say, *"How long does it take to build an RWA tokenization platform?"* — the rule is:
- Educational version with full process explanation → blog article
- Commercial version with InnBlockchain timeline + price → LP

Both can exist; they should not have the same H2 heading.

---

# 📚 References

- Landing Pages Plan (source for site map + SEO targets + ICP routing): [[InnBlockchain - Landing Pages Plan]]
- Content AEO/GEO companion: [[InnBlockchain - Content AEO GEO Prompts]]
- ICP — FinTech: [[InnBlockchain - ICP - FinTech]]
- ICP — Crypto Native: [[InnBlockchain - ICP - Crypto Native]]
- Content Strategy (for cross-link rationale): [[InnBlockchain - Content Strategy]]
- EU compliance reference: [[EU-Fintech-Compliance-Landscape]]

---

# 📌 Replan Triggers

This document gets re-cut, not patched, when:

1. **A Watch LP enters active GTM** → expand its stub block to a full 4–6 prompt set; add to monthly citation probe.
2. **Site URL map change** (new vertical added, two LPs merged, an LP split into two) → re-cut affected blocks.
3. **AI search engine model release** (GPT-5 Search, Claude 5, Perplexity Pro 3) → re-test top 12 LP prompts; revise Drafting Principles if commercial-intent citation patterns shift.
4. **Competitor breakthrough** — if Tokeny, Securitize, Antier, OpenZeppelin, or a regional dev shop starts ranking for active LP prompts on ChatGPT / Claude / Perplexity, rework the affected LP's hero answer + proof block.
5. **Pricing or engagement-model change** → re-cut every LP that cites cost ranges or timelines.
6. **InnBlockchain operating-history milestone or proof-number update** → re-cut every LP's proof block to reflect new mainnet-deployment count, years-in-business, or team-size figure.

---

# ⏳ Open Items *(carry-over from earlier revs)*

1. **TVL secured — verified portfolio numbers** *(rev 3 → unresolved through rev 8)*. Rev 3 stripped all specific TVL claims from prompts because portfolio numbers weren't confirmed. Rev 8 also stripped "TVL secured" from the `/work` metric-types prompt. Delivery needs to provide: (a) total cumulative TVL secured across shipped CN protocols, (b) highest single-protocol TVL InnBlockchain has shipped that remained exploit-free. Once confirmed, fold into a single Sasha-track BOFU prompt on `/industries/web3-defi` and `/work` proof block. **Owner: Delivery / Engineering. Due: before next LP redesign.**
2. **Listicle outreach operationalization** *(rev 6 → unresolved through rev 8)*. Principle #13 + Competitor Landscape Snapshot Listicle Target Inventory describe a real PR motion but no owner, target, cadence, or budget. **Action needed: Marketing lead assigns owner + Q3 inclusion target + outreach template + tracker file path. Budget anchor: PR / editorial outreach typically runs $5k–$20k per quarter per category (more with an agency). If no budget allocated, downgrade Principle #13 from "do this" to "considered, not committed."**
3. **CFO (Treasury) persona** *(rev 7 → pending)*. Stripped from `/services/private-blockchain` LP frontmatter pending ICP-FinTech Segment 7 activation. Restore here once defined.
4. **Document owner unassigned** *(rev 8 → new)*. This doc has no overall owner. Open Items #1–3 assign owners for specific tasks but no one owns LP-copy reviews, rev-bump decisions, Replan Trigger evaluation, or Monthly Citation Probe execution. **Action needed: Marketing lead claims overall doc ownership OR delegates to a named person.**
5. **CN consulting motion validation** *(rev 8 → new)*. `/services/blockchain-consulting` Track changed from [Both] → [FT] in rev 8 because the CN consulting motion isn't validated — crypto-native founders typically engage dev shops or audit firms directly, not consultants. If CN consulting motion is real (e.g., for protocol teams doing technical due diligence on a build-buy decision), restore [Both] and add Founding Felix back to persona. Otherwise, leave as FT-only.
6. **Future industry hubs — Supply Chain + Healthcare** *(rev 9 → new)*. Home page (`/`) repositioned in rev 9 as an industry-agnostic blockchain solutions provider, anticipating expansion beyond FinTech + Web3 & DeFi. **Confirmed future industries:** Supply Chain, Healthcare. **Activation gate per industry:** (a) leadership commits to GTM investment, (b) ≥1 case study or signed deal in the vertical, (c) ICP doc created for the new industry following the FinTech / Crypto Native pattern. **On activation, follow the build-out checklist** in the [🏛️ Industry Hubs intro note](#-industry-hubs). **Owner: leadership for activation decision; Marketing for LP build-out.**
7. **`/home` AEO scope discipline** *(rev 9 → new)*. Home is now positioned for industry-agnostic brand framing but must NOT chase "best blockchain development company" / "top blockchain solutions provider" listicle-bait queries — those are owned by IBM / Wipro / Accenture / TCS / Infosys. If Home traffic data shows the LP starting to attract those queries, tighten the prompts back toward brand-intent ("InnBlockchain", "who is InnBlockchain") rather than category framing. **Owner: Marketing — monitor Home LP traffic mix in citation probe.**
8. **InnBlockchain-native proof numbers — required to fill the Trioangle gap** *(rev 10 → new)*. Rev 10 stripped every Trioangle reference from the doc (per InnBlockchain standing as a standalone brand). Principles #1, #4, #5, #11 and the `/about` LP block now contain `[N]` / `[founding year]` placeholders where Trioangle-anchored proof numbers used to be. **Leadership / Marketing needs to provide:** (a) InnBlockchain founding year and years in operation as a blockchain firm, (b) total mainnet deployments shipped under the InnBlockchain brand, (c) team size and senior-engineer count, (d) any independent financial-stability signal (revenue band, runway, parent funding source if any non-Trioangle source exists). **Until these are filled in, the proof block on every active LP is thin** — Principle #11 says LLMs cite competitors when proof is missing, so the citation lift from rev 6's prompt rewrites won't fully realize until proof numbers land. **Owner: Marketing lead. Priority: highest — gates every LP build.**
