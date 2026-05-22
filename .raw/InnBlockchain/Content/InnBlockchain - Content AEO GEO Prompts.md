---
company:
  - innblockchain
department:
  - marketing
priority: high
rev: 5
last_revised: 2026-05-21
revision_notes: |
  rev 1 (2026-05-18): initial AEO/GEO prompt inventory across the full content strategy. Too broad — not actionable for the team currently shipping Phase 1.
  rev 2 (2026-05-18): rescoped to Phase 1 only. Each article in `InnBlockchain - Editorial Calendar` (rev 2) is mapped to 3–6 conversational prompts that buyers would issue to AI answer engines (ChatGPT, Claude, Perplexity, Google AI Overviews, Gemini, Copilot). Calendar week numbers carried over verbatim — each prompt block matches a date-locked article. Includes overflow queue + out-of-sequence override articles. Out of scope: Phase 2, Track A Watch verticals, Track B B2/B3/B4/B5/B6/B7/B8, WL-2 through WL-6 (build these when the Phase 2 calendar is cut Q4 2026).
  rev 3 (2026-05-18): deduplication pass. Removed 11 prompt overlaps that would have created internal AEO competition (two InnBlockchain articles fighting for the same conversational query). Fixes: (1) #2 hub stopped duplicating #6 MiCA + #8 oracle prompts. (2) B1-#16 tightened to MiFID II *mechanics* only — strategy doc line 292 explicit "Do NOT overlap" with #4 classification. (3) #20 stopped duplicating WL-0 TCO scaling prompts. (4) B1-#1 hub moved from BOFU build/buy/partner prompts (owned by B1-#19 lead magnet) to TOFU scoping prompts. (5) #5 post-mortem oracle prevention rephrased to incident-detection angle; prevention-architecture owned by #8. (6) B1-#19 "third option" duplicate removed; CN-track #20 owns the framing. (7) P1-N intra-article timeline duplicate removed. (8) #12 institutional onboarding prompt replaced with CN-specific accredited-investor / art-market angle; B1-#15 owns institutional securities AML. (9) Sasha A severity-rating prompt rephrased; Sasha B owns end-to-end report reading. Each scoped block now carries a *(Scope: ...)* line stating which prompts it owns vs. which sister article owns the alternative.
  rev 4 (2026-05-20): MiCA-as-RWA-cover misframe correction across A1 + B1 articles, synced with Content Strategy rev 6 and Editorial Calendar rev 3. Renamed in-place: #2 hub ("MiCA Compliance" → "EU MiFID II + DLT Pilot Regime Compliance"); #6 ("MiCA Compliance for RWA Tokenization Platforms" → "MiFID II + DLT Pilot Regime Compliance..."); #11 ("MiCA Whitepaper Requirements" → "Prospectus Regulation vs. MiCA Whitepaper..."); B1-#10 ("STOs ... Under MiCA" → "STOs ... Under MiFID II, Prospectus Regulation, and DLT Pilot Regime"); B1-#13 ("MiCA and MiFID II for Tokenized Assets" → "MiFID II + DLT Pilot Regime for Tokenized Assets (and Where MiCA Actually Fits)"). Prompts rewritten across #2, #6, #11, B1-#10, B1-#13 to lead with MiFID II + Prospectus + DLT Pilot framing and explicitly answer the boundary question (MiCA Art. 2(4) excludes financial instruments). Added new prompts that hit the misframe head-on (e.g., "Why isn't MiCA the right regime for RWA tokenization?", "Do I file a Prospectus or a MiCA white paper for my STO?"). Articles where MiCA is the correct regime (P5 MiCA Explained #3, MiCA License Application P1-N, MiCA Compliance Checklist for Crypto-Native Startups #14 scoped to Seg 2-10) were left as-is.
  rev 5 (2026-05-21): structural sync with Content Strategy rev 16 + Editorial Calendar rev 8. Three articles REMOVED from Phase 1 scope per Calendar rev 5 segment-scope audit: (1) #3 *MiCA Explained* — Seg 2/4 audience, MiCA LPs not live in Phase 1; (2) #14 *MiCA Compliance Checklist for Crypto-Native Startups* — Seg 2-10 scope, doesn't belong in RWA Phase 1; (3) P1-N *Preparing for MiCA License Application* — targets existing FinTechs licensing into MiCA CASP, audience activated only when `/solutions/regulated-exchange` + `/solutions/fintech-wallets` ship. Two articles ADDED per Calendar rev 6 + 7 promotions from Phase 2 P5 Rebalancing: (4) **P5-DORA-X** *DORA for All EU Licensed Financial Entities* at W7 Thu — cross-cutting CCO overview spanning every Active Track B segment; (5) **P5-eIDAS-X** *eIDAS 2.0 EUDI Wallet for Regulated FinTechs and RWA Tokenization Platforms* `[Both]` at W13 Tue — broadened cross-cutting article serves B4/B5/B7 wallet auth + A1/B1 RWA investor KYC. Track A Tuesday column cascaded forward by 1 week (rev 5 calendar fix): #4 W5→W4, #8 W6→W5, #9 W7→W6, #10 W8→W7, #11 W9→W8, #13 W10→W9, #5 W11→W10, #12 W12→W11, #15 W13→W12, #16 W15→W14, #17 W16→W15, #18 W17→W16, #19 W18→W17, #20 W19→W18, #21 W20→W19, #22/WL-1 W21→W20. Track A Phase 1 close marker moves from W21 to W20. W21 Tue is empty (Track A closed); W21 Thu retains B1-#18 Carol. Scope snapshot updated: Track A Phase 1 now 20 articles W1-W20 (was 22 W1-W21); Cross-Pillar early-ship now 4 articles (C1, T4-N, P5-DORA-X, P5-eIDAS-X — P1-N removed). References footer rev pins removed per Calendar rev 8 "do not rev-pin" guidance.
tags:
  - content
  - aeo
  - geo
  - seo
  - phase-1
---

# 🤖 AEO / GEO Prompts — Phase 1 Content Plan

> [!NOTE] What this document is
> A persona-tagged, article-by-article inventory of the conversational prompts InnBlockchain's Phase 1 ICPs are asking AI answer engines (ChatGPT, Claude, Perplexity, Google AI Overviews, Gemini, Copilot). Each article scheduled in [[InnBlockchain - Editorial Calendar]] gets a block of 3–6 prompts that the article must literally answer in its first 150–200 words.
>
> **Scope:** Phase 1 only — Phase 0 (WL-0), Track A Phase 1 #1, #2, #4, #5, #6, #7, #8, #9, #10, #11, #12, #13, #15, #16, #17, #18, #19, #20, #21, #22 (incl. WL-1), Track B B1 (17 dated + 2 overflow + 1 post-launch), Cross-Pillar early-ships (C1, T4-N, P5-DORA-X, P5-eIDAS-X), Phase 2 starter (#23), and out-of-sequence override articles. **Out of scope:** Phase 2 verticals A2–A6, Track B B2–B8, WL-2 through WL-6, plus three articles deferred from Phase 1 to Phase 2 in Calendar rev 5 (#3 MiCA Explained, #14 MiCA Checklist CN, P1-N MiCA License Application).

> [!IMPORTANT] How to use this with a draft
> 1. Open the article you're drafting.
> 2. Find its block below (organised by editorial-calendar week).
> 3. Each prompt must be answerable in the article's first 150 words — literally. Burying the answer kills AI citations.
> 4. Add the prompts verbatim as `FAQPage` JSON-LD schema at the bottom of the article.
> 5. Use one of the prompts as the article's H1 question variant (lateral SEO + AEO match).
> 6. 30 days post-publish: probe 2–3 prompts against ChatGPT / Claude / Perplexity. Log citation status. Rework lede if not cited.

---

## 📊 Phase 1 Scope Snapshot

| Bucket | Articles | Weeks | Owner |
|---|---|---|---|
| Phase 0 — WL-0 | 1 | W1 | Marketing |
| Track A Phase 1 (#1, #2, #4–#13, #15–#22, incl. WL-1) | 20 | W1–W20 | Marketing + Engineering review |
| Track B B1 WealthTech (dated) | 17 | W3–W22 | Marketing + Compliance review |
| Cross-Pillar early-ship (C1, T4-N, P5-DORA-X, P5-eIDAS-X) | 4 | W4 / W6 / W7 / W13 | Marketing + Compliance |
| Phase 2 starter (#23) | 1 | W22 | Marketing |
| Overflow queue (B1-#4, B1-#11, B1 Post-Launch) | 3 | Trigger-based | Marketing |
| Out-of-sequence overrides (Sasha, Paulo, AI overlay, post-mortems, case studies) | 6+ | Reactive | Marketing |
| **Total Phase 1 AEO scope** | **52+ articles** | **22 weeks** | — |

> [!INFO] Phase 1 deferrals (moved to Phase 2 in Calendar rev 5)
> The following three articles are tracked in the Phase 2 AEO prompts file (not yet cut). Do NOT draft against them in Phase 1:
> - **#3** *MiCA Explained: What the EU's Crypto Framework Means for Your Business* — Seg 2 ExchangeTech + Seg 4 WalletTech audience; LPs not live in Phase 1
> - **#14** *MiCA Compliance Checklist for Crypto-Native Startups* — Seg 2–10 scope, not RWA
> - **P1-N** *Preparing for MiCA License Application: Roadmap for Existing FinTechs* — RegTech audience activated only when `/solutions/regulated-exchange` + `/solutions/fintech-wallets` ship in Phase 2

---

## 🧭 How to read each article block

```
**[CALENDAR ID]** — Article title
- Track: [CN] / [FT] / [Both]
- Stage: TOFU / MOFU / BOFU / Post-launch
- Persona: who's asking
- Sales motion: [Audit] / [Dev] / [White-Label] / [Carol]
- Distribution: SEO+X / 📎 LinkedIn+SEO / LinkedIn ABM
- Prompts: 3–6 conversational queries the article must answer in the first 150 words
```

Prompt phrasing reflects how real buyers query LLMs (verbose, context-embedded, multi-part) — not search keywords.

---

# 🗓️ Phase 1 — Week-by-Week Article Prompts

## Week 1 (May 18–24) — LP Gate: `/solutions/rwa-tokenization` lands Thu W1

### **WL-0** — Own vs. License: The 5-Year TCO of Productized Crypto Platforms vs. SaaS Vendors *(9.1)*
- **Track:** [Both] · **Stage:** TOFU + Consideration · **Persona:** Founding Felix · Strategic Sam · CFO
- **Motion:** [White-Label] · **Distribution:** SEO + AI search engines (organic)
- **Prompts:**
  - *"Is it cheaper to build my own tokenization platform or license one from Tokeny or Securitize?"*
  - *"What's the 5-year total cost of ownership for a SaaS tokenization platform vs. an owned codebase?"*
  - *"How much does a white-label productized crypto platform actually cost in 2026?"*
  - *"What's the difference between owning the smart contract code and licensing a SaaS tokenization platform?"*
  - *"At what scale does a SaaS tokenization vendor become more expensive than building?"*
  - *"What are the real ongoing costs of Tokeny / Securitize / Polymath for a tokenization platform?"*

### 📎 **#2** — How to Tokenize Real-World Assets: Smart Contract Architecture, Oracle Design, and EU MiFID II + DLT Pilot Regime Compliance *(9.7 · A1 Hub — renamed rev 4 from "MiCA Compliance"; RWA ownership tokens are MiFID II financial instruments under Art. 2(4), not MiCA crypto-assets)*
- **Track:** [CN] · **Stage:** TOFU + MOFU · **Persona:** RWA Felix · Founding Felix · CTO
- **Motion:** [Dev] · **Distribution:** 📎 LinkedIn + SEO (EU PropTech / RWA Summit / DLT Pilot Regime / Security Token Summit communities)
- **Prompts:**
  - *"How do I tokenize a real-world asset on blockchain — what's the full process under MiFID II + DLT Pilot Regime?"*
  - *"What smart contract architecture do I need for an RWA tokenization platform?"*
  - *"What are the components of an RWA tokenization platform — contracts, oracles, KYC, off-chain SPV?"*
  - *"What's the difference between tokenizing real estate, art, commodities, and private credit?"*
  - *"How long does it take to build an RWA tokenization platform end-to-end?"*
  - *"What's the difference between an RWA tokenization platform and a security token platform?"*
  - *"Does my RWA tokenization platform fall under MiCA or MiFID II?"* *(boundary clarifier — answer is MiFID II + DLT Pilot for ownership tokens; deep dive in article #4)*

---

## Week 2 (May 25–31) — LP Gate: `/solutions/tokenization` lands

### **#6** — MiFID II + DLT Pilot Regime Compliance for RWA Tokenization Platforms *(9.6 — renamed rev 4 from "MiCA Compliance for RWA Tokenization Platforms"; the original was factually wrong since RWA ownership tokens are MiFID II financial instruments excluded from MiCA per Art. 2(4))*
- **Track:** [CN] · **Stage:** MOFU — Compliance Depth · **Persona:** CTO · RWA Felix · Compliance
- **Motion:** [Dev] · **Distribution:** SEO + X
- **Prompts:**
  - *"What does MiFID II + DLT Pilot Regime require for an RWA tokenization platform in 2026?"*
  - *"How do MiFID II smart contract / instrument-classification requirements apply to a tokenized real estate platform?"*
  - *"Do I need MiCA or MiFID II for my crypto-native RWA platform if I'm EU-based?"* *(answer: MiFID II for ownership tokens; MiCA only if also running CASP services on non-MiFID crypto-assets)*
  - *"What MiFID II + Prospectus Regulation articles apply to a tokenization platform issuing tokenized securities?"*
  - *"How do I document MiFID II + DLT Pilot Regime compliance for our RWA smart contracts?"*
  - *"Why isn't MiCA the right regime for RWA tokenization, and what is?"* *(addresses the misframe head-on — Art. 2(4) exclusion, then introduces MiFID II + Prospectus + DLT Pilot stack)*

### **#7** — ERC-3643 vs. ERC-1400 vs. ERC-20: Choosing the Right Token Standard for Your RWA Platform *(9.3)*
- **Track:** [CN] · **Stage:** MOFU — Technical Architecture · **Persona:** CTO · Head of Eng
- **Motion:** [Dev] · **Distribution:** SEO + X
- **Prompts:**
  - *"Should I use ERC-3643, ERC-1400, or ERC-20 for my RWA tokenization platform?"*
  - *"What's the difference between ERC-3643 and ERC-1400 for tokenized securities?"*
  - *"Which permissioned token standard is right for MiFID II investor whitelisting?"*
  - *"Is ERC-3643 better than ERC-1400 for compliance — what are the trade-offs?"*
  - *"Can I use plain ERC-20 for a real-world asset token or do I need a permissioned standard?"*

---

## Week 3 (Jun 1–7) — LP Gate: MiCA destination LP lands

### 📎 **#1** — What Is Asset Tokenization? A Plain-English Guide *(9.4 · `[Both]`)*
- **Track:** [Both] · **Stage:** TOFU — Awareness · **Persona:** RWA Felix · Strategic Sam
- **Motion:** Split CTA — [Dev] (CN) / [White-Label] (FT) · **Distribution:** 📎 LinkedIn + SEO + AI search
- **Prompts:**
  - *"What is asset tokenization in plain English?"*
  - *"How does tokenizing a real-world asset actually work?"*
  - *"What's the difference between tokenization and securitization?"*
  - *"Can any asset be tokenized or only certain ones?"*
  - *"Why are FinTechs tokenizing real-world assets in 2026?"*
  - *"What does it mean to tokenize real estate / a fund / a treasury bill?"*

### **B1-#1** — RWA Tokenization for Licensed Asset Managers: A Build Decision Guide for WealthTech CTOs *(9.2 · B1 Hub)*
- **Track:** [FT] · **Stage:** TOFU + Consideration · **Persona:** Strategic Sam · Technical Tom · CCO
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM (EU WealthTech / asset manager named accounts)
- **Prompts:** *(Scope: hub-level TOFU framing for licensed asset managers. Build/buy/partner decision framework is owned by B1-#19 lead magnet.)*
  - *"What is RWA tokenization for a licensed asset manager and why is it different from a crypto-native protocol?"*
  - *"What does a WealthTech CTO need to evaluate before scoping an RWA tokenization build?"*
  - *"How does RWA tokenization work for a licensed asset manager under MiFID II?"*
  - *"What stages does an RWA tokenization project go through for a licensed asset manager?"*
  - *"How long does it take a regulated WealthTech to launch tokenized assets?"*
  - *"What internal capabilities should a licensed asset manager have before starting an RWA tokenization project?"*

---

## Week 4 (Jun 8–14) — MiCA LP unblocks #4 boundary clarifier; Carol early-ship

### ⭐ 📎 **#4** — MiCA or MiFID II? How to Know Which EU Regime Governs Your Tokenized Asset *(9.1 · `[Both]` 🇪🇺 — shifted from W5 in Calendar rev 5 after #3 MiCA Explained deferred to Phase 2)*
- **Track:** [Both] · **Stage:** TOFU · **Persona:** CTO · Compliance Carol · RWA Felix
- **Motion:** Split CTA — [Dev] (CN) / [Carol] (FT) · **Distribution:** 📎 LinkedIn + SEO
- **Prompts:**
  - *"Is my tokenized asset governed by MiCA or MiFID II?"*
  - *"What's the test for whether my token is a financial instrument under MiFID II?"*
  - *"Can a token fall under both MiCA and MiFID II at the same time?"*
  - *"How do I classify a tokenized real estate fund — MiCA or MiFID II?"*
  - *"What happens if I get the MiCA vs. MiFID II classification wrong?"*
  - *"Who decides whether my tokenized asset is a security?"*

### ⏫ **C1** — What FinTech CCOs Should Demand in a Blockchain Vendor Risk Pack *(8.4)*
- **Track:** [FT] · **Stage:** TOFU + MOFU · **Persona:** Compliance Carol
- **Motion:** [Carol] · **Distribution:** LinkedIn ABM for Carol pattern (compliance officer titles, EU geo filter)
- **Prompts:**
  - *"What documentation do I need from a blockchain vendor before I can sign off?"*
  - *"What goes into a vendor risk pack for a blockchain ICT third-party?"*
  - *"What does a CCO at a regulated FinTech need from a blockchain dev partner under DORA?"*
  - *"How do I evaluate a blockchain vendor's compliance documentation?"*
  - *"What audit rights should a regulated FinTech demand from a blockchain vendor?"*

---

## Week 5 (Jun 15–21)

### **#8** — Oracle Design for Real-World Assets: How to Bring Off-Chain Valuations On-Chain Without Manipulation Risk *(9.2 — shifted from W6 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** MOFU — Technical Architecture · **Persona:** CTO · Head of Eng
- **Motion:** [Dev] · **Distribution:** SEO + X
- **Prompts:**
  - *"How do I design an oracle for real-world asset valuations on-chain?"*
  - *"What's the most secure way to bring off-chain RWA prices on-chain?"*
  - *"How do I prevent oracle manipulation in my RWA tokenization platform?"*
  - *"Should I use Chainlink, Pyth, or a custom oracle for RWA valuations?"*
  - *"What's the difference between push and pull oracles for RWA pricing?"*

### **B1-#5** — The Tech Stack Behind an RWA Tokenization Platform *(9.0)*
- **Track:** [FT] · **Stage:** MOFU — Platform Architecture · **Persona:** Technical Tom
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"What's the tech stack behind an RWA tokenization platform?"*
  - *"What infrastructure do I need to build a tokenization platform for a WealthTech?"*
  - *"What components make up a tokenization platform — smart contracts, oracles, KYC, what else?"*
  - *"What does a tokenization platform's architecture look like end-to-end?"*
  - *"What APIs and integrations does a tokenization platform need with our existing FinTech stack?"*

---

## Week 6 (Jun 22–28)

### **#9** — Investor Whitelisting On-Chain: How to Build KYC-Compliant Token Access Without Centralisation *(9.1 — shifted from W7 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** MOFU — Technical Architecture · **Persona:** CTO · Compliance
- **Motion:** [Dev] · **Distribution:** SEO + X
- **Prompts:**
  - *"How do I build investor whitelisting in a smart contract without making it centralised?"*
  - *"How do I add KYC checks to an ERC-3643 token without breaking decentralisation?"*
  - *"What's the architecture for compliant token access in an RWA platform?"*
  - *"Can investor whitelisting be done on-chain without a single admin key?"*
  - *"How do I implement on-chain KYC that satisfies AML regulations?"*

### ⏫ **T4-N** — The Cost of Hiring a Blockchain Team In-House: FinTech CTO Guide *(8.4)*
- **Track:** [FT] · **Stage:** TOFU · **Persona:** Technical Tom · CFO
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM for Tom + cold email for Sam
- **Prompts:**
  - *"What does it cost to hire a blockchain engineering team in-house for our FinTech?"*
  - *"How long does it take to build an in-house blockchain team — fully loaded cost over 18 months?"*
  - *"Should we hire blockchain engineers in-house or outsource to a development partner?"*
  - *"What's the average salary for a senior Solidity engineer in the EU in 2026?"*
  - *"What's the all-in cost of an in-house blockchain team of 4–6 engineers?"*

---

## Week 7 (Jun 29–Jul 5)

### 📎 **#10** — The Legal-Technical Interface in RWA Tokenization: What Smart Contracts Can and Cannot Enforce *(9.0 — shifted from W8 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** MOFU · **Persona:** RWA Felix · Lawyer · CTO
- **Motion:** [Dev] · **Distribution:** 📎 LinkedIn + SEO
- **Prompts:**
  - *"What can a smart contract actually enforce in a tokenized real estate transaction?"*
  - *"What legal docs do I still need if my asset is tokenized on-chain?"*
  - *"What's the gap between on-chain enforcement and legal title for tokenized assets?"*
  - *"Can a smart contract transfer legal ownership of real estate?"*
  - *"What happens off-chain when an RWA token transfers on-chain?"*

### ⏫ **P5-DORA-X** — DORA for All EU Licensed Financial Entities: ICT Resilience for Banks, Insurers, Investment Firms, PIs, EMIs, and CASPs *(8.5 · 🇪🇺 — promoted from Phase 2 P5 Rebalancing in Calendar rev 6; cross-cutting CCO overview spanning every Active Track B segment that touches a licensed entity in DORA Article 2 scope; replaces the W7 Thu slot left by P1-N MiCA License deferral)*
- **Track:** [FT] · **Stage:** TOFU + MOFU — Compliance Depth · **Persona:** Compliance Carol · Strategic Sam · Technical Tom
- **Motion:** [Carol] · **Distribution:** LinkedIn ABM for Carol pattern (compliance officer titles, EU geo filter — every Active Track B segment)
- **Prompts:** *(Scope: cross-cutting CCO overview of DORA across all licensed FT segments. WealthTech / DLT-tokenized-securities-specific DORA mechanics are owned by B1-#14.)*
  - *"What does DORA require from my licensed FinTech in 2026 — and is the Jan 17, 2025 enforcement date already past?"*
  - *"Which EU financial entities does DORA apply to — am I in scope as a PI, EMI, investment firm, insurer, or CASP?"*
  - *"What are DORA's five pillars and what does each actually require my organisation to do?"*
  - *"What ICT third-party risk obligations does DORA place on my blockchain vendor contracts — what audit rights and exit terms do I need?"*
  - *"What DORA-required incident classification and reporting workflow do I need set up — and who do I report to under Article 19?"*
  - *"How are EU National Competent Authorities actually auditing DORA in 2026 — what do they prioritise on inspections?"*

---

## Week 8 (Jul 6–12)

### **#11** — Prospectus Regulation vs. MiCA Whitepaper for Token Issuance: Which Document Your RWA Platform Actually Needs, and What Smart Contracts Must Enforce *(9.0 — renamed rev 4 from "MiCA Whitepaper Requirements"; most RWA platforms need a Prospectus or Prospectus exemption under MiFID II, not a MiCA white paper · shifted from W9 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** MOFU — Compliance Depth · **Persona:** CTO · RWA Felix · Compliance
- **Motion:** [Dev] · **Distribution:** SEO + X
- **Prompts:**
  - *"What does a MiCA whitepaper for token issuance have to contain?"*
  - *"Who needs to file a MiCA whitepaper vs. who needs to file a Prospectus before issuing a token in the EU?"*
  - *"What technical disclosures does MiCA require in the whitepaper vs. what does Prospectus Regulation require?"*
  - *"Do I need a MiCA whitepaper or an EU Prospectus if I'm issuing a tokenized real estate token?"* *(answer: Prospectus under MiFID II + Prospectus Regulation, not a MiCA white paper — real estate ownership tokens are transferable securities)*
  - *"How do I get a MiCA whitepaper notified — what's the regulator process?"*
  - *"How do I get an EU Prospectus approved for a tokenized securities offering — and which national competent authority handles it?"*
  - *"What's the Prospectus exemption threshold (≤€8M private placement, qualified-investor-only, etc.) for tokenized RWA?"*

### **B1-#9** — Real Estate Tokenization for Licensed Asset Managers: MiFID II Classification and Compliant Issuance *(8.9 · 🇪🇺)*
- **Track:** [FT] · **Stage:** MOFU — Asset Classes · **Persona:** Strategic Sam · Compliance Carol
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"How do licensed asset managers tokenize real estate under MiFID II?"*
  - *"Is tokenized real estate a financial instrument under MiFID II?"*
  - *"How does a licensed asset manager issue a tokenized real estate product compliantly?"*
  - *"What MiFID II classification applies to fractional tokenized real estate?"*
  - *"What's the MiFID II checklist for issuing a tokenized real estate fund?"*

---

## Week 9 (Jul 13–19)

### **#13** — EU AI Act for Tokenized Asset Platforms: When Your Valuation Oracle or AI Pricing Model Is High-Risk AI *(8.8 · `[Both]` 🇪🇺 — shifted from W10 in Calendar rev 5)*
- **Track:** [Both] · **Stage:** MOFU — Compliance Depth · **Persona:** CTO · Compliance Carol
- **Motion:** Split CTA — [Dev] (CN) / [Carol] (FT) · **Distribution:** SEO + X + LinkedIn
- **Prompts:**
  - *"Is my AI-powered RWA valuation oracle a high-risk AI system under the EU AI Act?"*
  - *"When does the EU AI Act classify a pricing model as high-risk?"*
  - *"What does the EU AI Act require for AI used in tokenized asset platforms?"*
  - *"Do I need a tamper-proof audit trail if my RWA platform uses AI for valuations?"*
  - *"When does my commodity pricing AI become high-risk under the EU AI Act?"*

### **B1-#2** — Institutional RWA Tokenization: What BlackRock's BUIDL Fund Means for FinTechs *(8.3)*
- **Track:** [FT] · **Stage:** TOFU · **Persona:** Strategic Sam
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"What is BlackRock's BUIDL fund and why does it matter for FinTechs?"*
  - *"What does institutional RWA tokenization look like in 2026?"*
  - *"How is BlackRock's tokenized fund structured — is it a model for mid-market WealthTechs?"*
  - *"What does the BUIDL launch tell me about the future of tokenized funds?"*
  - *"Should our WealthTech build a tokenized fund similar to BUIDL?"*

---

## Week 10 (Jul 20–26)

### 📎 **#5** — [POST-MORTEM] How Oracle Manipulation Compromises RWA Platforms — Root Cause and Prevention *(8.8 — shifted from W11 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** TOFU — Risk-hook · **Persona:** CTO · RWA Felix
- **Motion:** [Audit] · **Distribution:** 📎 LinkedIn + SEO + X (Rekt News reactive amplification)
- **Prompts:** *(Scope: post-mortem framing — incident analysis and detection. Prevention-side architecture is owned by #8.)*
  - *"How can an RWA platform get exploited via oracle manipulation?"*
  - *"What was the [specific RWA exploit] and what was the root cause?"*
  - *"How do attackers manipulate oracles in RWA tokenization platforms?"*
  - *"What's the worst oracle attack ever on a tokenization platform?"*
  - *"How would I detect early signs of an in-progress oracle manipulation attack on my RWA platform?"*
  - *"What on-chain forensic signals indicate oracle manipulation has happened?"*

### **B1-#3** — T+0 Settlement on Blockchain: How Real-Time Clearing Is Replacing T+2 *(8.3)*
- **Track:** [FT] · **Stage:** TOFU · **Persona:** Strategic Sam · Technical Tom
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"What is T+0 settlement on blockchain and how does it work?"*
  - *"How is blockchain replacing T+2 securities settlement with real-time clearing?"*
  - *"What does T+0 settlement mean for liquidity in our WealthTech product?"*
  - *"Is T+0 settlement actually achievable for regulated securities trading?"*
  - *"What does the DTCC say about T+0 settlement timelines for tokenized securities?"*

---

## Week 11 (Jul 27–Aug 2)

### **#12** — AML Compliance for RWA Investor Onboarding: Art Market Participants, Accredited Investors, and Cross-Border Asset Due Diligence *(8.9 · 🇪🇺 — shifted from W12 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** MOFU — Compliance Depth · **Persona:** RWA Felix · Compliance
- **Motion:** [Dev] · **Distribution:** SEO + X
- **Prompts:** *(Scope: CN-specific AML — Art Market Participant status, accredited investor verification, cross-border due diligence. Institutional securities transfers and travel rule for tokenized securities are owned by B1-#15.)*
  - *"What AML checks do I need for an RWA investor onboarding process?"*
  - *"How does Art Market Participant AML status apply to tokenized art?"*
  - *"What accredited investor verification is required for a tokenized RWA?"*
  - *"What cross-border AML obligations apply to RWA investor onboarding?"*
  - *"How do I verify accredited investors on-chain for a tokenized real estate or art platform?"*
  - *"What AML red flags are specific to tokenized art and tokenized collectibles?"*

### **B1-#6** — Tokenization and Liquidity: How Fractional Ownership Unlocks Capital for WealthTechs *(8.4)*
- **Track:** [FT] · **Stage:** MOFU — Platform Architecture · **Persona:** Strategic Sam
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"How does tokenization unlock liquidity for previously illiquid assets?"*
  - *"What's the liquidity case for fractional tokenization in a WealthTech?"*
  - *"How does fractional ownership through tokenization improve capital efficiency?"*
  - *"What's the secondary-market liquidity profile of tokenized real estate?"*
  - *"How does tokenization compare to traditional fund structures for liquidity?"*

---

## Week 12 (Aug 3–9)

### 📎 **#15** — Fractional Real Estate Tokenization: Smart Contract Architecture for Property Fractionalization and Compliant Issuance *(9.0 — shifted from W13 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** MOFU — Asset-Class Deep Dive · **Persona:** RWA Felix
- **Motion:** [Dev] · **Distribution:** 📎 LinkedIn + SEO (EU PropTech communities)
- **Prompts:**
  - *"How do I tokenize fractional real estate ownership on blockchain?"*
  - *"What's the smart contract architecture for property fractionalisation?"*
  - *"How does compliant fractional real estate token issuance work?"*
  - *"Can I tokenize a single building or do I need a fund wrapper?"*
  - *"What ERC standard do I use for fractional real estate tokens?"*

### **B1-#10** — STOs in 2026: The Regulatory Landscape for Security Token Offerings Under MiFID II, Prospectus Regulation, and DLT Pilot Regime *(8.7 · 🇪🇺 — renamed rev 4 from "Under MiCA"; STOs are MiFID II financial instruments under Art. 2(4), not MiCA crypto-assets)*
- **Track:** [FT] · **Stage:** MOFU — Asset Classes · **Persona:** Strategic Sam · CCO
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"What's the regulatory status of Security Token Offerings in 2026?"*
  - *"How does MiFID II + Prospectus Regulation treat STOs?"*
  - *"Can I run an STO under MiCA or do I need MiFID II?"* *(answer: MiFID II — STOs are transferable securities, MiCA Art. 2(4) excludes them)*
  - *"What's the difference between an STO under MiFID II and a token offering under MiCA?"*
  - *"What does a compliant STO process look like under EU regulation — Prospectus filing, DLT Pilot Regime for secondary trading, MiFID II investor categorization?"*
  - *"Do I file a Prospectus or a MiCA white paper for my STO?"* *(Prospectus, with possible exemption thresholds)*

---

## Week 13 (Aug 10–16)

### ⏫ 📎 **P5-eIDAS-X** — eIDAS 2.0 EUDI Wallet for Regulated FinTechs and RWA Tokenization Platforms: Becoming a Relying Party Before the Dec 31, 2026 Deadline *(8.7 · `[Both]` 🇪🇺 — promoted from Phase 2 P5 Rebalancing in Calendar rev 7; broadened from B4-WalletTech-only to cross-cutting — serves B4 / B5 / B7 wallet auth AND A1 / B1 RWA investor KYC; replaces the W13 Tue slot left by #14 MiCA Checklist deferral)*
- **Track:** [Both] · **Stage:** TOFU + MOFU — Compliance Depth · **Persona:** Compliance Carol · Technical Tom (FT) · CTO · RWA Felix (CN)
- **Motion:** Split CTA — [Carol] (FT: wallet relying-party integration) / [Dev] (CN: RWA investor KYC integration)
- **Distribution:** 📎 LinkedIn + SEO + AI search engines (hard deadline drives broad distribution)
- **Prompts:**
  - *"What is the EU Digital Identity (EUDI) Wallet and how does eIDAS 2.0 apply to my regulated FinTech or RWA platform?"*
  - *"Do I need to become an EUDI Wallet 'relying party' before the Dec 31, 2026 deadline — and what does that actually mean technically?"*
  - *"How does an EUDI Wallet replace traditional KYC for investor onboarding on an RWA tokenization platform?"*
  - *"What does my e-money wallet, payment app, or treasury platform need to build to accept EUDI Wallet authentication?"*
  - *"Can our RWA tokenization platform use the EUDI Wallet to verify accredited and qualified institutional investors compliantly?"*
  - *"What's the technical integration spec (OID4VC / OID4VP / SD-JWT) for becoming an EUDI Wallet relying party?"*
  - *"Will national EU member-state EUDI Wallets actually interoperate by Dec 31, 2026 — what's the current state of pilots?"*

### **B1-#12** — ERC-3643 for Licensed Asset Managers: How Permissioned Token Standards Satisfy MiFID II Compliance and Investor Whitelisting Requirements *(8.8 · 🇪🇺)*
- **Track:** [FT] · **Stage:** MOFU — Compliance Depth · **Persona:** Technical Tom · Compliance Carol
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"How does ERC-3643 satisfy MiFID II compliance for tokenized securities?"*
  - *"Why is ERC-3643 the standard for permissioned tokenized assets at licensed asset managers?"*
  - *"How does ERC-3643 enforce investor whitelisting at the contract layer?"*
  - *"What's the difference between ERC-3643 and ERC-1400 for a regulated asset manager?"*
  - *"Does using ERC-3643 mean my token is automatically MiFID II compliant?"*

---

## Week 14 (Aug 17–23)

### 📎 **#16** — Vehicle Fleet Tokenization: Smart Contract Architecture for Asset Fractionalization and Fractional Ownership *(8.7 — shifted from W15 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** MOFU — Asset-Class Deep Dive · **Persona:** RWA Felix
- **Motion:** [Dev] · **Distribution:** 📎 LinkedIn + SEO
- **Prompts:**
  - *"How do I tokenize a vehicle fleet for fractional ownership?"*
  - *"What's the smart contract architecture for tokenizing a fleet of vehicles?"*
  - *"Can I fractionalise vehicle ownership through tokenization?"*
  - *"How does revenue distribution work for tokenized vehicle fleets?"*
  - *"What regulatory status does a tokenized vehicle have?"*

### **B1-#13** — MiFID II + DLT Pilot Regime for Tokenized Assets: What EU WealthTechs Must Get Right Before Launch (and Where MiCA Actually Fits) *(8.6 · 🇪🇺 — renamed rev 4 from "MiCA and MiFID II for Tokenized Assets"; original ordering misframed MiCA as primary)*
- **Track:** [FT] · **Stage:** MOFU — Compliance Depth · **Persona:** Strategic Sam · Compliance Carol
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"What do EU WealthTechs need to get right with MiFID II + DLT Pilot Regime before launching tokenized assets — and where does MiCA actually fit?"*
  - *"How do MiFID II, Prospectus Regulation, DLT Pilot Regime, and MiCA interact for a tokenized asset product?"* *(MiFID II + Prospectus + DLT Pilot primary; MiCA only as service-level CASP or for ART tokens)*
  - *"What's the compliance checklist for an EU WealthTech tokenizing client portfolios?"*
  - *"Does MiFID II still apply if I'm MiCA-registered for a tokenized product?"* *(yes — MiFID II classification is structural and primary; MiCA CASP is only a service-level overlay if the firm also runs services on non-MiFID crypto-assets)*
  - *"What's the order of operations — MiFID II classification first (it's primary for tokenized securities), then Prospectus filing, then DLT Pilot Regime authorization for the trading/settlement layer; MiCA CASP only if also handling non-MiFID crypto-assets"*

---

## Week 15 (Aug 24–30)

### 📎 **#17** — Commodity Tokenization: On-Chain Representation of Gold, Oil, and Agricultural Assets *(8.7 — shifted from W16 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** MOFU — Asset-Class Deep Dive · **Persona:** RWA Felix
- **Motion:** [Dev] · **Distribution:** 📎 LinkedIn + SEO (commodity trade finance communities)
- **Prompts:**
  - *"How do I tokenize gold, oil, or agricultural commodities on-chain?"*
  - *"What's the smart contract architecture for a commodity-backed token?"*
  - *"How is a tokenized commodity backed by physical inventory?"*
  - *"What regulations apply to a tokenized gold or oil product in the EU?"*
  - *"How does on-chain commodity tokenization work end-to-end?"*

### **B1-#14** — DORA for Tokenized Securities Infrastructure: ICT Resilience Obligations for WealthTechs Building on DLT *(8.6 · 🇪🇺)*
- **Track:** [FT] · **Stage:** MOFU — Compliance Depth · **Persona:** Compliance Carol · Technical Tom
- **Motion:** [Carol] · **Distribution:** LinkedIn ABM
- **Prompts:** *(Scope: DLT-tokenized-securities-specific DORA mechanics. Cross-cutting CCO DORA overview spanning all licensed FT segments is owned by P5-DORA-X.)*
  - *"What does DORA require for tokenized securities infrastructure on DLT?"*
  - *"Are blockchain oracle providers ICT third-parties under DORA?"*
  - *"What DORA resilience testing applies to a tokenized securities settlement system?"*
  - *"Does DORA apply to my WealthTech's blockchain vendor?"*
  - *"What incident reporting does DORA require for tokenized securities infrastructure?"*

---

## Week 16 (Aug 31–Sep 6)

### 📎 **#18** — Private Credit On-Chain: How RWA Lending Protocols Tokenize Off-Chain Debt and Enforce Repayment *(8.6 — shifted from W17 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** MOFU — Asset-Class Deep Dive · **Persona:** RWA Felix · CTO
- **Motion:** [Dev] · **Distribution:** 📎 LinkedIn + SEO
- **Prompts:**
  - *"How do RWA lending protocols tokenize off-chain private credit?"*
  - *"How does on-chain enforcement work for private credit tokenization?"*
  - *"What's the architecture of a private credit RWA protocol like Goldfinch or Centrifuge?"*
  - *"How do I tokenize a private credit loan book?"*
  - *"What happens on-chain when a tokenized private credit loan defaults?"*

### **B1-#15** — AML / AMLA for Institutional RWA Investor Onboarding: Travel Rule Obligations for Tokenized Securities Transfers Between Institutional Clients *(8.5 · 🇪🇺)*
- **Track:** [FT] · **Stage:** MOFU — Compliance Depth · **Persona:** Compliance Carol
- **Motion:** [Carol] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"What AML obligations apply to institutional investor onboarding for tokenized securities?"*
  - *"Does the EU Travel Rule (TFR — Regulation (EU) 2023/1113) apply to tokenized securities transfers between institutional clients?"*
  - *"How does TFR relate to the FATF travel rule recommendation for tokenized securities — and what's the difference in practice?"*
  - *"What does AMLA require for tokenized securities transfers in the EU?"*
  - *"How do I implement travel rule compliance for institutional tokenized securities transactions?"*
  - *"What AML data must I collect for tokenized securities investor onboarding?"*

---

## Week 17 (Sep 7–13)

### 📎 **#19** — Art and Collectibles Tokenization: How On-Chain Title Transfer Works and Where It Can Fail *(8.5 — shifted from W18 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** MOFU — Asset-Class Deep Dive · **Persona:** RWA Felix
- **Motion:** [Dev] · **Distribution:** 📎 LinkedIn + SEO
- **Prompts:**
  - *"How do I tokenize a piece of art or a collectible on-chain?"*
  - *"How does on-chain title transfer work for tokenized art?"*
  - *"Where can tokenized art fail — what are the legal gaps?"*
  - *"What ERC standard is used for tokenized art?"*
  - *"How is the physical asset tied to the on-chain token for art tokenization?"*

### **B1-#7** — Blockchain for Treasury Tokenization: Turning Corporate Assets Into Liquid Instruments *(8.3)*
- **Track:** [FT] · **Stage:** MOFU — Platform Architecture · **Persona:** Strategic Sam · CFO
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"How does blockchain tokenize corporate treasury assets into liquid instruments?"*
  - *"Can my corporate treasury issue tokenized assets to unlock liquidity?"*
  - *"How are companies using blockchain to tokenize treasury bills?"*
  - *"What's the architecture for tokenized corporate treasury management?"*
  - *"How does tokenized treasury management compare to traditional cash management?"*

---

## Week 18 (Sep 14–20)

### 📎 **#20** — Custom Build vs. Securitize / Tokeny / Polymath: When You Need Your Own RWA Smart Contract Infrastructure *(8.9 — shifted from W19 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** BOFU — Decision · **Persona:** RWA Felix · Founding Felix
- **Motion:** [Dev] with [White-Label] routing line for middle-ground buyers · **Distribution:** 📎 LinkedIn + SEO
- **Prompts:** *(Scope: when custom is technically justified. 5-year TCO math is owned by WL-0.)*
  - *"When do I actually need custom RWA smart contract infrastructure vs. licensing a platform?"*
  - *"What's the difference between Securitize, Tokeny, and Polymath?"*
  - *"What customisations do Tokeny / Securitize / Polymath NOT support that force a custom build?"*
  - *"What's the third option between full-custom build and SaaS tokenization?"*
  - *"Build vs. buy vs. white-label for RWA tokenization — which makes sense?"*
  - *"Which RWA founders have moved off Tokeny / Securitize onto custom infrastructure and why?"*

### **B1-#16** — MiFID II Instrument Classification for Tokenized Assets: Is Your Token a Financial Instrument? *(8.5 · 🇪🇺)*
- **Track:** [FT] · **Stage:** MOFU — Compliance Depth · **Persona:** Compliance Carol
- **Motion:** [Carol] · **Distribution:** LinkedIn ABM
- **Prompts:** *(Scope: MiFID II mechanics once classification confirmed. Initial regime classification — MiCA vs. MiFID II — is owned by #4.)*
  - *"What MiFID II instrument category does my tokenized fund fall into — transferable security, MMF unit, UCITS?"*
  - *"What MiFID II conduct-of-business and best-execution rules apply once my token is classified as a financial instrument?"*
  - *"What MiFID II licensing do we already hold and which extends to our tokenized product line?"*
  - *"What happens if our national competent authority reclassifies our token under MiFID II mid-issuance?"*
  - *"What MiFID II reporting obligations apply to tokenized securities transactions (transaction reporting, MTF rules)?"*

---

## Week 19 (Sep 21–27)

### 🎯 📎 **#21** — Smart Contract Audit Checklist for RWA Tokenization Platforms: What Auditors Flag Before Investor Onboarding *(9.2 · Lead Magnet — shifted from W20 in Calendar rev 5)*
- **Track:** [CN] · **Stage:** BOFU — Decision · **Persona:** CTO · RWA Felix
- **Motion:** [Audit] · **Distribution:** 📎 LinkedIn + SEO
- **Prompts:**
  - *"What do smart contract auditors flag on an RWA tokenization platform before investor onboarding?"*
  - *"What's the pre-audit checklist for an RWA tokenization platform?"*
  - *"What vulnerabilities are most common in RWA tokenization smart contracts?"*
  - *"How do I prepare my RWA platform's contracts for a security audit?"*
  - *"What's the typical scope of an audit for an RWA tokenization smart contract?"*

### **B1-#17** — DLT Pilot Regime for Tokenized Securities Settlement: What EU WealthTechs Need to Know *(8.2 · 🇪🇺)*
- **Track:** [FT] · **Stage:** MOFU — Compliance Depth · **Persona:** Strategic Sam · Compliance Carol
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"What is the EU DLT Pilot Regime and how does it apply to tokenized securities?"*
  - *"Do I need DLT Pilot Regime authorisation for our tokenized securities platform?"*
  - *"How does the DLT Pilot Regime differ from MiCA for tokenized securities settlement?"*
  - *"What's the timeline and process for getting DLT Pilot Regime authorisation?"*
  - *"Which firms have already been authorised under the DLT Pilot Regime?"*

---

## Week 20 (Sep 28–Oct 4) — ✅ Track A Phase 1 complete

### 📎 **#22 / WL-1** — White-Label RWA Tokenization Platform: Audited Smart Contracts, Issuer Dashboard, and Investor Portal *(9.0 — shifted from W21 in Calendar rev 5; Track A Phase 1 now closes one week earlier)*
- **Track:** [Both] · **Stage:** BOFU — Decision · **Persona:** RWA Felix · Strategic Sam · Technical Tom
- **Motion:** [White-Label] · **Distribution:** 📎 LinkedIn + SEO + AI search engines
- **Prompts:**
  - *"Who builds white-label RWA tokenization platforms in 2026?"*
  - *"What does a white-label RWA tokenization platform actually include?"*
  - *"Best white-label tokenization platform for licensed asset managers under $30k?"*
  - *"How much does a white-label STO platform cost end-to-end with audit?"*
  - *"What's the difference between a white-label tokenization platform and a custom build?"*
  - *"Can I get a productized RWA platform with audit-grade smart contracts under $30k?"*

### **B1-#8** — Tokenizing Invoices and Receivables: How It Works and Who It's For *(8.3)*
- **Track:** [FT] · **Stage:** MOFU — Platform Architecture · **Persona:** Strategic Sam
- **Motion:** [Dev] · **Distribution:** LinkedIn ABM
- **Prompts:**
  - *"How do I tokenize invoices and receivables on blockchain?"*
  - *"Who actually buys tokenized invoices and how is it structured?"*
  - *"What's the architecture for tokenized invoice financing?"*
  - *"Can a B2B company tokenize its receivables for faster working capital?"*
  - *"How does invoice tokenization compare to traditional factoring?"*

---

## Week 21 (Oct 5–11)

*(Track A Phase 1 closed at W20 — no Tuesday Track A article. Phase 2 #23 starter shifted to W22 below.)*

### **B1-#18** — What Compliance Officers Need Before Approving a Tokenized Securities Build: MiFID II Instrument Review, DLT Pilot Authorization, and DORA Third-Party Risk *(9.0 · 🇪🇺)*
- **Track:** [FT] · **Stage:** BOFU — Decision · **Persona:** Compliance Carol
- **Motion:** [Carol] · **Distribution:** LinkedIn ABM (compliance officer titles)
- **Prompts:**
  - *"What does our compliance officer need before approving a tokenized securities build?"*
  - *"What's the compliance sign-off checklist for a tokenized securities project?"*
  - *"What MiFID II, DLT Pilot, and DORA documentation does a CCO need to approve a blockchain vendor?"*
  - *"How long does compliance sign-off take for a tokenized securities build?"*
  - *"What does a regulator look at when reviewing a tokenized securities platform?"*

---

## Week 22 (Oct 12–15) — Phase 2 starter + Track B B1 complete

### **Phase 2 #23** — [POST-MORTEM Series] How [DeFi Exploit] Happened — Root Cause and Prevention *(9.5 — Phase 2 starter; Track A Phase 1 already closed at W20)*
- **Track:** [CN] · **Stage:** TOFU + Consideration · **Persona:** CTO · Head of Eng
- **Motion:** [Audit] · **Distribution:** SEO + X + Rekt News reactive
- **Prompts:**
  - *"How did the [recent DeFi exploit] happen technically?"*
  - *"What was the root cause of the [protocol] exploit and how would I prevent it?"*
  - *"What vulnerability did the [exploit] exploit and is my protocol exposed?"*
  - *"Post-mortem of the [DeFi exploit] — what should every protocol team learn?"*
  - *"How much was lost in the [exploit] and what was the attack vector?"*

### 🎯 **B1-#19** — RWA Tokenization: Build vs. Buy vs. Partner — Decision Framework for WealthTech Leaders *(8.5 · Lead Magnet)*
- **Track:** [FT] · **Stage:** BOFU — Decision · **Persona:** Strategic Sam
- **Motion:** [Dev] with [White-Label] routing for productized buyers · **Distribution:** LinkedIn ABM
- **Prompts:** *(Scope: build/buy/partner decision framework specifically for licensed WealthTechs. "Third option" framing is owned by #20 (CN track).)*
  - *"Should our WealthTech build, buy, or partner for RWA tokenization?"*
  - *"What's the decision framework for tokenization platform sourcing at a licensed asset manager?"*
  - *"When does buying tokenization SaaS make more sense than building for a licensed asset manager?"*
  - *"How do I scope a build vs. buy decision for tokenization in a WealthTech?"*
  - *"What does a licensed asset manager need from a tokenization partner — capabilities, regulatory standing, exit terms?"*
  - *"How should our board evaluate three tokenization paths — custom build, productized white-label, or SaaS partnership?"*

---

# 🗂️ Overflow Queue Prompts *(not date-locked — trigger when condition fires)*

### **B1-#4** ⚠️ — Utility NFTs in FinTech: How Non-Fungible Tokens Map to Real-World Assets *(8.4)*
- **Trigger:** Schedule when B2 phase begins or if a live B1 deal asks for the framing. Watch-candidate — kill at 90-day review.
- **Track:** [FT] · **Stage:** TOFU · **Persona:** Strategic Sam · CPO · **Motion:** [Dev]
- **Prompts:**
  - *"How do utility NFTs map to real-world assets for FinTechs?"*
  - *"What's the difference between an RWA token and a utility NFT for asset representation?"*
  - *"Should our FinTech use NFTs or fungible tokens for asset representation?"*
  - *"Where do utility NFTs fit in a tokenization strategy in 2026?"*

### **B1-#11** ⚠️ — Tokenized US Treasuries as DeFi Collateral: What FinTechs Need to Know *(8.1)*
- **Trigger:** News-cycle dependent (next BUIDL-tier institutional announcement). Otherwise kill at 90 days.
- **Track:** [FT] · **Stage:** MOFU · **Persona:** Strategic Sam · CFO · **Motion:** [Dev]
- **Prompts:**
  - *"How are tokenized US Treasuries being used as DeFi collateral in 2026?"*
  - *"Which FinTechs are using tokenized US Treasuries on-chain?"*
  - *"What's the regulatory status of tokenized US Treasuries for EU FinTechs?"*
  - *"Can our WealthTech offer tokenized Treasury products as DeFi collateral?"*

### **B1 Post-Launch** — Expanding Your RWA Platform to New Markets: Regulatory and Technical Readiness
- **Trigger:** First B1 client goes live. Converts one-time build clients to retainer.
- **Track:** [FT] · **Stage:** Post-launch · **Persona:** Strategic Sam · Compliance Carol · **Motion:** [Dev]
- **Prompts:**
  - *"How do I expand an existing RWA tokenization platform to a new EU market?"*
  - *"What's the regulatory readiness checklist for launching our tokenization platform in a second jurisdiction?"*
  - *"How does cross-border tokenized securities distribution work between EU member states?"*
  - *"What technical changes does a tokenization platform need for a new market?"*

---

# ⚡ Out-of-Sequence Override Prompts *(reactive — publish bumps a scheduled article)*

### 🤖 AI Audit Overlay — Why Your AI-Written Smart Contracts Need a Human Audit: What Cursor, Copilot, and ChatGPT Miss in Solidity *(8.7)*
- **Trigger:** Any AI-coded smart contract project enters pipeline (no Phase 1 gate)
- **Track:** [Both] · **Stage:** TOFU · **Persona:** Founding Felix · Strategic Sam · Technical Tom · **Motion:** [Audit]
- **Prompts:**
  - *"What's wrong with smart contracts written by Cursor, Copilot, or ChatGPT?"*
  - *"Can I trust AI-generated Solidity code for production?"*
  - *"What vulnerabilities do AI coding tools miss in smart contract code?"*
  - *"Should I get an audit if my smart contracts were written with AI tools?"*
  - *"Why does AI-generated Solidity fail audit checks?"*

### 💼 Paulo Champion Piece — How We Cut Smart Contract Audit Prep Time from 6 Weeks to 2: A Protocol Team's Playbook *(8.8)*
- **Trigger:** Any deal stuck on "external team slows us down" objection
- **Track:** [CN] · **Stage:** Decision · **Persona:** Product Paulo → Founding Felix · **Motion:** [Audit] [Dev]
- **Prompts:**
  - *"How do other protocol teams cut their smart contract audit prep time?"*
  - *"What's the playbook for shortening smart contract audit prep from 6 weeks to 2?"*
  - *"How do top protocols accelerate audit-readiness without sacrificing quality?"*
  - *"What does a fast audit prep process look like for a Series A protocol?"*

### 🔑 Sasha Trust Piece A — How InnBlockchain Categorizes Smart Contract Findings: Our Severity Framework Explained *(8.3)*
- **Trigger:** Any $10M+ protocol enters discovery
- **Track:** [CN] · **Stage:** Decision · **Persona:** Security Sasha · **Motion:** [Audit]
- **Prompts:** *(Scope: severity framework specifically. How to read an audit report end-to-end is owned by Sasha B.)*
  - *"How does InnBlockchain categorize Critical vs. High severity in smart contract audits?"*
  - *"What's the severity framework used by smart contract audit firms?"*
  - *"What's the difference between Critical, High, Medium, and Low severity in a smart contract audit?"*
  - *"What makes an audit finding 'Critical' vs. just 'High'?"*
  - *"Why do different audit firms classify the same vulnerability at different severity levels?"*

### 🔑 Sasha Trust Piece B — What to Look for in a Smart Contract Audit Report: A Technical Evaluation Guide *(8.0)*
- **Trigger:** Any $10M+ protocol enters discovery
- **Track:** [CN] · **Stage:** Decision · **Persona:** Security Sasha · **Motion:** [Audit]
- **Prompts:**
  - *"How do I read and evaluate a smart contract audit report?"*
  - *"What should a smart contract audit report contain to be defensible?"*
  - *"What's the difference between a thorough audit report and a checkbox one?"*
  - *"What do top auditors include in their reports that mid-tier firms skip?"*

### 🎬 Case Study A — How We Tokenized [Asset Class] for [Client]: From First Smart Contract to Investor-Ready Platform
- **Trigger:** Delivered RWA platform + screenshot rights cleared
- **Track:** [CN] · **Stage:** BOFU · **Persona:** RWA Felix · **Motion:** [Dev]
- **Prompts:**
  - *"Show me a real RWA tokenization case study with delivered platform and metrics"*
  - *"Has InnBlockchain shipped an RWA tokenization platform — what does the deliverable look like?"*
  - *"What did an RWA tokenization platform actually cost and how long did it take?"*
  - *"What's a real example of an EU-compliant RWA tokenization build?"*

### 🎬 Case Study B — WealthTech / RWA Platform Build
- **Trigger:** Delivered B1 client deployment + screenshot rights cleared
- **Track:** [FT] · **Stage:** BOFU · **Persona:** Strategic Sam · Technical Tom · **Motion:** [Dev]
- **Prompts:**
  - *"Show me a WealthTech RWA tokenization case study with a licensed asset manager"*
  - *"Has InnBlockchain built a tokenization platform for a licensed FinTech?"*
  - *"What does an RWA tokenization build for a WealthTech actually look like end-to-end?"*
  - *"How long does it take a regulated WealthTech to launch a tokenized fund with InnBlockchain?"*

---

# 🧠 AEO Drafting Principles for Phase 1 Articles

> Apply to every Phase 1 article. These are not optional — they're the difference between an article that ranks but isn't cited, and one that gets pulled into ChatGPT / Claude / Perplexity answers.

### 1. The 150-word answer rule
Every prompt listed above must be answerable in the article's first 150 words — literally. The lede is not a teaser; it's the answer. Backfill depth in H2 #2 onwards.

**Failure mode:** *"Tokenization is one of the most exciting trends in finance today. In this article, we'll explore..."* — buyer bounces, LLM skips.
**Success mode:** *"Asset tokenization issues a blockchain token representing ownership of a real-world asset. For real estate, this typically uses ERC-3643 (permissioned) with KYC enforcement at the contract layer, an oracle pricing feed for valuation, and an off-chain SPV holding legal title. Total build cost: $20k–$80k. Timeline: 6–10 weeks."*

### 2. H2/H3 headings = prompts verbatim
The H2 / H3 structure of every article should mirror 3–5 prompts from this doc. ChatGPT / Claude do passage retrieval — heading match is the strongest signal.

### 3. FAQPage JSON-LD
Every article ends with an FAQ schema block containing the verbatim prompts. Required for Google AI Overviews + Perplexity citation lift.

### 4. Cite specifics
- ✅ *"ERC-3643, ratified by ERC-3643 Association, used by Tokeny and Securitize since 2022"*
- ❌ *"a popular permissioned token standard"*

### 5. Name competitors
- ✅ *"Tokeny, Securitize, Polymath, RealT, Fireblocks, SettleMint"*
- ❌ *"leading platforms"*

LLMs surface articles that name competitors because comparison queries dominate AI search.

### 6. Date-stamp regulation
- ✅ *"MiCA (in force June 2024; CASP authorisation deadline July 2026; Title V transitional period until July 2027)"*
- ❌ *"recent EU crypto regulation"*

### 7. Markdown tables, not images
Comparison tables in markdown are AI-citable. Image tables are invisible.

### 8. Persona-aligned vocabulary
- `[CN]` articles: *"protocol TVL,"* *"mainnet,"* *"exploit vector,"* *"audit-ready"*
- `[FT]` articles: *"regulator-defensible,"* *"compliance sign-off,"* *"vendor risk,"* *"DLT settlement"*
- `[Both]` articles: avoid both lexicons — write neutrally and split CTAs

### 9. Avoid marketing voice
*"Industry-leading,"* *"cutting-edge,"* *"revolutionary"* get filtered in extraction. Sound like a senior protocol engineer or a compliance counsel — not a brochure.

### 10. Update bi-annually
Every Phase 1 article gets a "Last updated: [month] 2026" stamp. Refresh dates, regulator references, and competitor lists every 6 months. LLMs aggressively de-prioritise stale content.

---

# 📡 Monthly AI Search Citation Probe

Each month, manually probe these prompts against ChatGPT (with Search), Claude (with Web Search), and Perplexity. Log:
1. Was InnBlockchain cited?
2. Which competitors were cited?
3. Was the article excerpt accurate or hallucinated?

| Engine | Phase 1 priority prompts | Cadence |
|---|---|---|
| **ChatGPT (GPT-4o/5 with Search)** | All W1–W22 article prompts; top 5 per week | Weekly |
| **Claude with Web Search** | Track A Phase 1 + Track B B1 prompts | Bi-weekly |
| **Perplexity** | WL-0 + WL-1 + RWA architecture prompts | Weekly |
| **Google AI Overviews** | All Phase 1 prompts via Google search | Weekly |
| **Gemini** | EU compliance prompts (MiFID II, DLT Pilot, Prospectus Regulation, MiCA, DORA, EU AI Act, eIDAS 2.0) | Bi-weekly |
| **Microsoft Copilot** | Track B B1 prompts (WealthTech CTO/CCO queries) | Monthly |

Citation tracker file (recommended): `InnBlockchain - AI Citation Tracker.md` — one row per prompt, columns for date, engine, citation status, competitors named, action.

---

# 📚 References

- Editorial Calendar (source for week-by-week sequencing): [[InnBlockchain - Editorial Calendar]] *(do not rev-pin — calendar evolves continuously)*
- Content Strategy (article inventory, scoring, sales motion tags): [[InnBlockchain - Content Strategy]] *(do not rev-pin — strategy evolves continuously)*
- ICP Track A: [[ICP - Crypto Native]]
- ICP Track B: [[ICP - FinTech]]
- EU compliance reference: [[EU-Compliance-Landscape]]
- LinkedIn distribution: [[InnBlockchain - LinkedIn Marketing Strategy]] · [[InnBlockchain - LinkedIn Outreach Strategy]]

---

# 📌 Replan Triggers

This document gets re-cut, not patched, when:

1. **Phase 1 close (Week 20 / Sep 28, 2026 — Track A; Week 22 / Oct 15, 2026 — Track B B1)** → build the Phase 2 AEO prompts file (covers A2–A6, B2–B4, WL-2 through WL-6, AI+Blockchain cluster post-validation, plus the three Phase-1-deferred articles: #3 MiCA Explained, #14 MiCA Checklist CN, P1-N MiCA License Application).
2. **Editorial calendar replan** (any of the Replan Triggers in [[InnBlockchain - Editorial Calendar]]) → re-cut affected weeks.
3. **AI search engine model release** (e.g., GPT-5 Search, Claude 5, Perplexity Pro 3) → re-test top 12 prompts; update Drafting Principles if citation patterns shift.
4. **Competitor breakthrough** — if Tokeny, Securitize, or Antier starts ranking for our target prompts on ChatGPT / Claude / Perplexity, rework the affected article's lede + cite specificity.
