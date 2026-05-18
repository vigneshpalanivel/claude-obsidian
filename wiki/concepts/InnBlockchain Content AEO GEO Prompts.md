---
title: "InnBlockchain Content AEO GEO Prompts"
type: concept
status: current
created: 2026-05-18
updated: 2026-05-18
tags:
  - AEO
  - GEO
  - SEO
  - content-strategy
  - innblockchain
  - prompts
  - phase-1
related:
  - "[[InnBlockchain]]"
  - "[[InnBlockchain Content Strategy]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain-Content-AEO-GEO-Prompts]]"
  - "[[SEO-AEO-GEO-Prompt-Library]]"
  - "[[SEO-Recovery-Strategy-2025-26]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[ERC-3643]]"
  - "[[ERC-1400]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[EU-AML-AMLA]]"
---

# InnBlockchain Content AEO GEO Prompts

A 270-prompt article-by-article inventory of the conversational queries InnBlockchain's Phase 1 ICPs (Crypto-Native + Regulated FinTech) are asking AI answer engines — ChatGPT, Claude, Perplexity, Google AI Overviews, Gemini, Copilot. Each prompt is mapped 1:1 to a specific article in the Phase 1 editorial calendar so writers can construct articles that literally answer the questions buyers are asking LLMs.

It is the execution-layer companion to [[InnBlockchain Content Strategy]]: the strategy says *what* to publish, the editorial calendar says *when*, and this artifact says *what conversational questions each article must answer in its first 150 words.*

---

## Why It Exists

[[SEO-Recovery-Strategy-2025-26]] established the directional shift: informational keywords are now AI territory, BoFU is where clicks still happen, AI engines need to cite InnBlockchain as the authoritative source. That strategy is directional; this prompt inventory is the execution map for the InnBlockchain content motion.

Without this layer, the failure mode is predictable: articles rank organically (Google sees a match) but never get cited by ChatGPT/Claude/Perplexity (the lede buries the answer below H3 #3). The 150-word answer rule and FAQPage JSON-LD discipline exist to close that gap.

---

## Difference from the Trioangle Parallel

[[SEO-AEO-GEO-Prompt-Library]] is the Trioangle equivalent: a 180-prompt master template substituted across 10 clone-script verticals. InnBlockchain's is structurally different:

| Dimension | Trioangle [[SEO-AEO-GEO-Prompt-Library]] | InnBlockchain Content AEO/GEO Prompts |
|---|---|---|
| Form | Reusable template with variable placeholders | Article-by-article inventory mapped 1:1 to calendar |
| Vertical multiplication | 1 template × 10 verticals = 1,800 prompt instances | 270 prompts × no multiplication (each is a unique article) |
| Scope | All Trioangle clone-script products | Phase 1 only (53+ articles, 22 weeks, May–Oct 2026) |
| Engine class split | Explicit SEO (75) / AEO (40) / GEO (60) / Hybrid (5) bucketing | Single conversational-query framing; SEO is folded in via H2/H3 prompt phrasing |
| Track tagging | None | Mandatory `[CN]` / `[FT]` / `[Both]` per prompt |
| Sales motion tagging | None | Mandatory `[Audit]` / `[Dev]` / `[White-Label]` / `[Carol]` per article |
| Persona tagging | Variable-driven | Explicit (Founding Felix / RWA Felix / Security Sasha / Product Paulo / Strategic Sam / Technical Tom / Compliance Carol) |
| Reuse cycle | Substitute placeholders per new product | Re-cut at Phase 1 close → Phase 2 file |

Both are operationalising the same underlying GEO/AIO pivot — but Trioangle's product line scales horizontally (same template, more verticals), while InnBlockchain's content motion scales depth-first within fixed Phase 1 scope.

---

## The 10 Drafting Principles

Apply to every Phase 1 article. Not optional — these are the difference between an article that ranks but isn't cited, and one that gets pulled into ChatGPT / Claude / Perplexity answers.

1. **150-word answer rule** — every listed prompt must be answerable in the article's first 150 words. Lede is the answer, not a teaser.
2. **H2/H3 = prompts verbatim** — heading match is the strongest passage-retrieval signal.
3. **FAQPage JSON-LD** — verbatim prompts as schema at article bottom. Required for Google AI Overviews + Perplexity citation lift.
4. **Cite specifics** — versions, dates, named vendors. *"ERC-3643, ratified 2022, used by Tokeny and Securitize"* > *"a popular permissioned token standard."*
5. **Name competitors** — Tokeny, Securitize, Polymath, RealT, Fireblocks, SettleMint. LLMs surface articles that name competitors because comparison queries dominate AI search.
6. **Date-stamp regulation** — *"MiCA (in force June 2024; CASP authorisation deadline July 2026; Title V transitional period until July 2027)."*
7. **Markdown tables, not images** — tables in markdown are AI-citable; image tables are invisible.
8. **Persona-aligned vocabulary** — `[CN]` uses *protocol TVL, mainnet, exploit vector*; `[FT]` uses *regulator-defensible, compliance sign-off, vendor risk*; `[Both]` writes neutrally with split CTAs.
9. **Avoid marketing voice** — *"industry-leading, cutting-edge, revolutionary"* get filtered in LLM extraction.
10. **Update bi-annually** — date-stamp each article; refresh dates, regulator references, competitor lists every 6 months.

---

## Per-Article Block Schema

Each of the 53+ Phase 1 articles carries:

```
[CALENDAR ID] — Article title (score)
- Track: [CN] / [FT] / [Both]
- Stage: TOFU / MOFU / BOFU / Post-launch
- Persona: who's asking
- Sales motion: [Audit] / [Dev] / [White-Label] / [Carol]
- Distribution: SEO+X / 📎 LinkedIn+SEO / LinkedIn ABM
- Prompts: 3–6 conversational queries
- (Scope: ...) — optional line stating ownership boundary vs. sister article
```

The `(Scope: ...)` line was added in rev 3 after a deduplication pass removed 11 cross-article prompt overlaps that would have created internal AEO competition.

---

## Top-12 Phase 1 AEO Priorities (Q2 2026)

The 12 prompts most likely to be issued by an in-funnel buyer in the next 90 days:

1. ERC-3643 vs ERC-1400 for RWA tokenization → [[ERC-3643]] · [[ERC-1400]]
2. MiCA applicability for tokenized real estate (Germany-based)
3. RWA smart contract audit scope
4. EU DLT Pilot Regime vs MiCA → [[DLT-Pilot-Regime]]
5. Build vs license tokenization platform — TCO
6. White-label RWA tokenization vendor query
7. Flash loan attack prevention for DEXes
8. Regulated FinTech CTO audit deliverables
9. AI credit scoring under EU AI Act
10. CCD2 BNPL deadline (Nov 2026)
11. AI-written smart contract audit gaps
12. eIDAS 2.0 wallet deadline (Dec 2026)

If InnBlockchain isn't cited for these on ChatGPT/Claude/Perplexity within 60 days of article publish, the article needs an AEO lede rework.

---

## Dedup Discipline (Rev 3)

11 cross-article overlaps removed. Each affected article block now carries an explicit `*(Scope: ...)*` line. Notable enforcement:

- **#4 vs B1-#16 MiFID II** — strategy doc line 292 says "Do NOT overlap." `#4` owns the regime classification question; `B1-#16` rescoped to MiFID II mechanics once classification confirmed.
- **WL-0 vs #20** — `WL-0` owns 5-year TCO math; `#20` owns when-custom-is-technically-justified.
- **B1-#1 hub vs B1-#19 lead magnet** — hub stays TOFU scoping; lead magnet owns BOFU build/buy/partner framework.
- **#5 post-mortem vs #8 architecture** — post-mortem rephrased to detection/forensic angle; prevention-architecture owned by #8.
- **Sasha A vs B** — A is severity framework only; B is end-to-end audit report reading.

Acceptable cross-track parallels remain (deliberate by strategy doc design): `#7` (CN) vs `B1-#12` (FT) on ERC-3643 vs ERC-1400; `#20` (CN) vs `B1-#19` (FT) on build/buy; Case Study A (CN) vs B (FT).

---

## How to Use With a Draft

Article construction protocol:

1. Open the article you're drafting from the editorial calendar.
2. Find its block in `.raw/InnBlockchain/Content/InnBlockchain - Content AEO GEO Prompts.md`.
3. Draft the lede so it literally answers 3+ of the prompts in the first 150 words.
4. Mirror prompts as H2/H3 headings.
5. Add prompts verbatim as FAQPage JSON-LD schema at the article bottom.
6. Use one prompt as the article H1 question variant for lateral SEO + AEO match.
7. 30 days post-publish: probe 2–3 prompts against ChatGPT/Claude/Perplexity. Log citation status. Rework lede if not cited.

---

## Monthly AI Search Citation Probe

| Engine | Phase 1 priority prompts | Cadence |
|---|---|---|
| ChatGPT (GPT-4o/5 with Search) | All W1–W22 article prompts; top 5/week | Weekly |
| Claude with Web Search | Track A Phase 1 + Track B B1 | Bi-weekly |
| Perplexity | WL-0 + WL-1 + RWA architecture | Weekly |
| Google AI Overviews | All Phase 1 prompts via Google | Weekly |
| Gemini | EU compliance prompts (MiCA, MiFID II, DORA, DLT Pilot, EU AI Act) | Bi-weekly |
| Microsoft Copilot | Track B B1 (WealthTech CTO/CCO queries) | Monthly |

Citation tracker file recommended but not yet created — would be `InnBlockchain - AI Citation Tracker.md`.

---

## Open Questions / Gaps

1. **Citation tracker not yet created.** The monthly probe schedule requires a persistent tracker — without it, citation patterns can't be measured month-over-month.
2. **Phase 2 prompts deferred.** Phase 2 (A2–A6, B2–B4, WL-2 through WL-6) is intentionally out of scope until the Phase 2 editorial calendar is cut. Premature work risks rework when calendar reshuffles.
3. **Marketing-voice vs AEO collision.** The drafting principles will collide with the existing blog voice if it still leans on *"revolutionary"* / *"cutting-edge"* ledes. Editorial standards need to change alongside this artifact — a prompt doc in isolation doesn't enforce voice.
4. **No competitor citation baseline.** Without a pre-publish probe of "who currently gets cited for these prompts on ChatGPT/Claude," there's no benchmark for measuring InnBlockchain's eventual displacement of Tokeny / Securitize / Antier in AI answers.

---

## Replan Triggers

Re-cut (not patched) when:

1. **Phase 1 close — Week 21 / Oct 6, 2026** → build Phase 2 AEO prompts file.
2. **Editorial calendar replan** → re-cut affected weeks.
3. **AI engine major model release** (GPT-5 Search, Claude 5, Perplexity Pro 3) → re-test top 12 prompts.
4. **Competitor breakthrough** — Tokeny / Securitize / Antier ranking on AI engines for InnBlockchain target prompts → lede rework.

---

## Source

`.raw/InnBlockchain/Content/InnBlockchain - Content AEO GEO Prompts.md` (rev 3, 2026-05-18) — see [[InnBlockchain-Content-AEO-GEO-Prompts]] source note.
