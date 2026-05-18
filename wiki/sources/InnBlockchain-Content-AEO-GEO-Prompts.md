---
type: source
title: "InnBlockchain — Content AEO GEO Prompts (Phase 1)"
source_type: internal-document
author: "InnBlockchain Marketing"
date_published: 2026-05-18
url: ""
confidence: high
key_claims:
  - "270 conversational AEO/GEO prompts mapped 1:1 to the 44 date-locked articles in `InnBlockchain - Editorial Calendar` (rev 2) plus 9 overflow / out-of-sequence override articles — total 53+ Phase 1 articles."
  - "Scope is strictly Phase 1: Phase 0 (WL-0), Track A Phase 1 #1–#22 (incl. WL-1), Track B B1 WealthTech (17 dated + 2 overflow + 1 post-launch), Cross-Pillar early-ships (C1, T4-N, P1-N), Phase 2 starter (#23). Out of scope: Phase 2 verticals A2–A6, Track B B2–B8, WL-2 through WL-6 — build when Phase 2 calendar is cut post-Oct 2026."
  - "Each article block carries 3–6 prompts plus 5 metadata fields: Track (`[CN]` / `[FT]` / `[Both]`), Stage (TOFU/MOFU/BOFU/Post-launch), Persona (Founding Felix · RWA Felix · Security Sasha · Product Paulo · Strategic Sam · Technical Tom · Compliance Carol), Sales motion (`[Audit]` / `[Dev]` / `[White-Label]` / `[Carol]`), Distribution (SEO+X / 📎 LinkedIn+SEO / LinkedIn ABM)."
  - "Operational rule: every prompt must be answerable in the article's first 150 words — literally. Burying the answer below H3 #3 is the #1 reason AI engines don't cite articles that rank organically."
  - "Article construction protocol: (1) find article block, (2) draft lede so it literally answers 3+ prompts, (3) mirror prompts as H2/H3 headings, (4) add prompts verbatim as FAQPage JSON-LD at bottom, (5) probe 2–3 prompts against ChatGPT/Claude/Perplexity 30 days post-publish and rework lede if not cited."
  - "Dedup pass (rev 3, 2026-05-18) removed 11 cross-article prompt overlaps that would have created internal AEO competition between InnBlockchain articles. Notable: #4 vs B1-#16 MiFID II classification (strategy doc line 292 explicit 'Do NOT overlap') — B1-#16 rescoped to MiFID II mechanics only. Each affected block now carries `*(Scope: ...)*` line stating which prompts it owns vs. which sister article owns the alternative."
  - "10 AEO drafting principles enumerated: 150-word answer rule, H2/H3=prompts verbatim, FAQPage JSON-LD, cite specifics (versions/dates/named vendors), name competitors (Tokeny, Securitize, Polymath, RealT, Fireblocks, SettleMint), date-stamp regulation, markdown tables not images, persona-aligned vocabulary by track, avoid marketing voice, update bi-annually."
  - "12 highest-priority AEO prompts for Q2 2026 GTM ranked at top of doc — covers ERC-3643 vs ERC-1400, MiCA-for-RWA-platforms, RWA audit checks, DLT Pilot Regime, build-vs-license TCO, white-label vendor query, flash loan attack prevention, AML for institutional RWA, AI-written contract audit, CCD2 BNPL deadline, eIDAS 2.0 wallet deadline."
  - "Monthly AI search citation probe schedule across 6 engines: ChatGPT (Search) weekly · Claude (Web Search) bi-weekly · Perplexity weekly · Google AI Overviews weekly · Gemini bi-weekly · Microsoft Copilot monthly. Citation tracker file (`InnBlockchain - AI Citation Tracker.md`) recommended but not yet created."
  - "Persona-vocabulary rule: `[CN]` articles use 'protocol TVL,' 'mainnet,' 'exploit vector,' 'audit-ready'; `[FT]` articles use 'regulator-defensible,' 'compliance sign-off,' 'vendor risk,' 'DLT settlement'; `[Both]` articles avoid both lexicons and write neutrally with split CTAs. AI engines match on lexical proximity to the user's prompt phrasing."
  - "Replan triggers: (1) Phase 1 close Week 21 / Oct 6, 2026 → build Phase 2 AEO file; (2) Editorial calendar replan; (3) AI engine major model release (GPT-5 Search, Claude 5, Perplexity Pro 3) → re-test top 12 prompts; (4) Competitor breakthrough — if Tokeny / Securitize / Antier starts ranking for our target prompts on ChatGPT/Claude/Perplexity, rework affected article lede + cite specificity."
ingest_rev: 1
created: 2026-05-18
updated: 2026-05-18
tags:
  - source
  - AEO
  - GEO
  - SEO
  - content-strategy
  - innblockchain
  - prompts
  - phase-1
status: current
related:
  - "[[InnBlockchain]]"
  - "[[InnBlockchain Content Strategy]]"
  - "[[InnBlockchain Content AEO GEO Prompts]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[SEO-AEO-GEO-Prompt-Library]]"
  - "[[SEO-Recovery-Strategy-2025-26]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[ERC-3643]]"
  - "[[ERC-1400]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[EU-AML-AMLA]]"
  - "[[sources/_index]]"
---

# InnBlockchain — Content AEO GEO Prompts (Phase 1)

**Source**: `.raw/InnBlockchain/Content/InnBlockchain - Content AEO GEO Prompts.md` (rev 3, 2026-05-18) | InnBlockchain Marketing | hash `c3dffd0b1d3944f110df30b81b6f4402`

---

## What This Document Is

The execution-layer companion to [[InnBlockchain Content Strategy]] and the editorial calendar. Where the strategy doc specifies *what* articles to publish and the calendar specifies *when*, this document specifies the *exact conversational queries each article must literally answer in its first 150 words* to be citable by ChatGPT, Claude, Perplexity, Google AI Overviews, Gemini, and Copilot.

It is the InnBlockchain-side parallel to the Trioangle [[SEO-AEO-GEO-Prompt-Library]] — but structured differently: Trioangle's is a 180-prompt template substituted across 10 clone-script verticals. InnBlockchain's is a 270-prompt article-by-article inventory tied 1:1 to a 22-week Phase 1 editorial schedule.

---

## Scope

Strictly Phase 1 of [[InnBlockchain Content Strategy]] (May 18 – Oct 15, 2026):

| Bucket | Articles | Weeks |
|---|---|---|
| Phase 0 — WL-0 (Own vs. License TCO) | 1 | W1 |
| Track A Phase 1 #1–#22 (incl. WL-1) | 22 | W1–W21 |
| Track B B1 WealthTech (dated) | 17 | W3–W22 |
| Cross-Pillar early-ship (C1, T4-N, P1-N) | 3 | W4 / W6 / W7 |
| Phase 2 starter (#23 post-mortem) | 1 | W22 |
| Overflow queue (B1-#4, B1-#11, B1 Post-Launch) | 3 | Trigger-based |
| Out-of-sequence overrides (Sasha A/B, Paulo, AI overlay, Case A/B) | 6+ | Reactive |
| **Total** | **53+** | **22 weeks** |

Out of scope: Phase 2 verticals A2–A6 (DEX/DeFi/Wallet/NFT/Token Launch), Track B B2–B8, WL-2 through WL-6. Build those when Phase 2 calendar is cut Q4 2026.

---

## Per-Article Block Schema

Each article gets a structured block:

```
[CALENDAR ID] — Article title
- Track: [CN] / [FT] / [Both]
- Stage: TOFU / MOFU / BOFU / Post-launch
- Persona: who's asking
- Sales motion: [Audit] / [Dev] / [White-Label] / [Carol]
- Distribution: SEO+X / 📎 LinkedIn+SEO / LinkedIn ABM
- Prompts: 3–6 conversational queries
```

Prompt phrasing reflects real LLM query patterns — verbose, context-embedded ("I run a licensed asset management firm — should I build my own RWA platform?"), multi-part — not 3-word search keywords.

---

## The 10 AEO Drafting Principles

> Apply to every Phase 1 article. Not optional.

1. **150-word answer rule** — every listed prompt must be answerable in the article's first 150 words. Lede is the answer, not a teaser.
2. **H2/H3 = prompts verbatim** — heading match is the strongest passage-retrieval signal for ChatGPT/Claude.
3. **FAQPage JSON-LD** — embed prompts as schema at article bottom. Required for Google AI Overviews + Perplexity citation lift.
4. **Cite specifics** — *"ERC-3643, ratified 2022, used by Tokeny and Securitize"* > *"a popular permissioned token standard."*
5. **Name competitors** — *"Tokeny, Securitize, Polymath, RealT, Fireblocks, SettleMint"* > *"leading platforms."* Comparison queries dominate AI search.
6. **Date-stamp regulation** — *"MiCA (in force June 2024; CASP authorisation deadline July 2026; Title V transitional period until July 2027)."*
7. **Markdown tables, not images** — tables in markdown are AI-citable; image tables are invisible.
8. **Persona-aligned vocabulary** — `[CN]`: *protocol TVL, mainnet, exploit vector, audit-ready*. `[FT]`: *regulator-defensible, compliance sign-off, vendor risk, DLT settlement*. `[Both]`: neutral, split CTAs.
9. **Avoid marketing voice** — *"industry-leading, cutting-edge, revolutionary"* get filtered in extraction.
10. **Update bi-annually** — date-stamp each article; refresh dates, regulator references, and competitor lists every 6 months.

---

## Top-12 Phase 1 AEO Priorities (Q2 2026 GTM)

The 12 prompts most likely to be issued by an in-funnel buyer in the next 90 days. If InnBlockchain isn't cited for these on ChatGPT/Claude/Perplexity within 60 days of publish, article needs a lede rework.

1. *"What's the difference between ERC-3643 and ERC-1400 for tokenizing real-world assets?"* — [[ERC-3643]] vs [[ERC-1400]]
2. *"Does MiCA apply to my tokenized real estate platform if I'm based in Germany?"*
3. *"What does an RWA tokenization smart contract audit actually check for?"*
4. *"How is the EU DLT Pilot Regime different from MiCA for tokenized securities?"* — [[DLT-Pilot-Regime]]
5. *"Is it cheaper to build my own RWA tokenization platform or license one from Tokeny / Securitize?"*
6. *"Who builds white-label RWA tokenization platforms in 2026?"*
7. *"What is a flash loan attack and how do DEXes prevent them?"*
8. *"What does a regulated FinTech CTO actually need to give a smart contract auditor?"*
9. *"Is my AI-powered credit scoring model a high-risk AI system under the EU AI Act?"*
10. *"How long before the CCD2 deadline do I need to be compliant if I run a BNPL on blockchain?"*
11. *"What's wrong with smart contracts written by Cursor or ChatGPT?"*
12. *"What is the eIDAS 2.0 wallet requirement and does my e-money wallet have to comply by Dec 2026?"*

---

## Dedup Discipline

Rev 3 (2026-05-18) removed 11 cross-article prompt overlaps that would have created internal AEO competition between InnBlockchain articles fighting for the same conversational query. Each affected block now carries an explicit `*(Scope: ...)*` line stating which prompts it owns vs. which sister article owns the alternative.

Notable enforcement: [[InnBlockchain Content Strategy]] line 292 says "Do NOT overlap" between `#4 MiCA or MiFID II?` (TOFU regime classification) and `B1-#16 MiFID II Instrument Classification` (MOFU mechanics). The prompts file enforces this — `B1-#16` was rescoped to MiFID II *mechanics once classification confirmed* (instrument category, reporting, conduct rules); `#4` owns the *which regime applies* question.

Acceptable remaining parallels (not fixed — by design):
- `#7` (CN) vs `B1-#12` (FT) on ERC-3643 vs ERC-1400 — deliberate two-track split
- `#20` (CN) vs `B1-#19` (FT) on build/buy decision — deliberate two-track split
- Case Study A (CN) vs B (FT) — deliberate two-track parallel

---

## Monthly Probe Schedule

| Engine | Phase 1 priority prompts | Cadence |
|---|---|---|
| ChatGPT (GPT-4o/5 with Search) | All W1–W22 article prompts; top 5 per week | Weekly |
| Claude with Web Search | Track A Phase 1 + Track B B1 prompts | Bi-weekly |
| Perplexity | WL-0 + WL-1 + RWA architecture prompts | Weekly |
| Google AI Overviews | All Phase 1 prompts via Google search | Weekly |
| Gemini | EU compliance prompts (MiCA, MiFID II, DORA, DLT Pilot, EU AI Act) | Bi-weekly |
| Microsoft Copilot | Track B B1 prompts (WealthTech CTO/CCO queries) | Monthly |

Citation tracker file (recommended, not yet created): `InnBlockchain - AI Citation Tracker.md` — one row per prompt, columns for date, engine, citation status, competitors named, action.

---

## Replan Triggers

This document is re-cut (not patched) when:

1. **Phase 1 close (Week 21 / Oct 6, 2026)** → build Phase 2 AEO prompts file (covers A2–A6, B2–B4, WL-2 through WL-6, AI+Blockchain cluster post-validation).
2. **Editorial calendar replan** (any of the 7 triggers in `InnBlockchain - Editorial Calendar` § Replan Triggers) → re-cut affected weeks.
3. **AI search engine major model release** (e.g., GPT-5 Search, Claude 5, Perplexity Pro 3) → re-test top 12 prompts; update Drafting Principles if citation patterns shift.
4. **Competitor breakthrough** — if Tokeny, Securitize, or Antier starts ranking for InnBlockchain's target prompts on ChatGPT/Claude/Perplexity, rework affected article lede + cite specificity.

---

## Cross-References

- Strategic parent: [[InnBlockchain Content Strategy]]
- Editorial cadence: `.raw/InnBlockchain/Content/InnBlockchain - Editorial Calendar.md` (rev 2, 2026-05-18)
- Concept synthesis: [[InnBlockchain Content AEO GEO Prompts]]
- ICPs: [[InnBlockchain Crypto Native ICP]] · [[InnBlockchain FinTech ICP]]
- Trioangle parallel approach: [[SEO-AEO-GEO-Prompt-Library]]
- Strategic origin of AI-search pivot: [[SEO-Recovery-Strategy-2025-26]]
- Domain concepts: [[Asset-Tokenization-RWA]] · [[ERC-3643]] · [[ERC-1400]] · [[DLT-Pilot-Regime]] · [[EU-AML-AMLA]]
