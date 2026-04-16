---
type: meta
title: "Operation Log"
updated: 2026-04-16
tags:
  - meta
  - log
status: evergreen
related:
  - "[[index]]"
  - "[[hot]]"
  - "[[overview]]"
  - "[[sources/_index]]"
---

# Operation Log

Navigation: [[index]] | [[hot]] | [[overview]]

Append-only. New entries go at the TOP. Never edit past entries.

Entry format: `## [YYYY-MM-DD] operation | Title`

Parse recent entries: `grep "^## \[" wiki/log.md | head -10`

---

## [2026-04-16] ingest | Test Architect (TEA) Documentation (Full)
- Source: `.raw/Test Architect (TEA) Documentation (Full).md` (hash → 79eba2ed29dd26f68725581706c4b11a, 16512 lines)
- Summary: [[TEA-Documentation]]
- Pages created: [[TEA-Documentation]], [[Test Architect (TEA)]], [[TEA Workflows]], [[TEA Engagement Models]], [[Risk-Based Testing]], [[Fixture Architecture]], [[Network-First Testing]], [[TEA Knowledge Base System]]
- Pages updated: [[BMAD Method]] (TEA module cross-reference + source link), [[index]], [[hot]]
- Key insight: TEA codifies context engineering for testing. Load only the 42 knowledge-base fragments a workflow needs (not all of them), and the AI produces consistent test quality regardless of prompt. It is the same mechanism as the [[Hot Cache]] in this vault and [[LLM Wiki Pattern]] generally: relevant standards in context, irrelevant stuff out, output quality by construction.
- Secondary: TEA is the only BMad agent that spans multiple phases (3, 4, Release Gate) and the only one with its own knowledge base. Quick Flow track intentionally excludes TEA.

## [2026-04-15] ingest | BMAD Method Documentation (Full)
- Source: `.raw/BMAD Method Documentation (Full).md` (hash → 4091f2571c34f93b1d9dccd3b29849dc)
- Summary: [[BMAD-Method-Documentation]]
- Pages created: [[BMAD Method]], [[BMad Four-Phase Workflow]], [[BMad Quick Dev]], [[BMad Project Context]], [[Adversarial Review]], [[Advanced Elicitation]], [[Working Backwards PRFAQ]]
- Pages updated: [[index]], [[hot]], [[log]]
- Key insight: BMad's phased-document-as-context pattern, adversarial-review-with-finding-floor, and intent-compression-before-autonomous-run are directly transferable to claude-obsidian's wiki-lint, autoresearch, and CLAUDE.md design.

## [2026-04-16] ingest | InnBlockchain Content Strategies (Crypto Native + Crypto Products + FinTech)
- Sources:
  - `.raw/InnBlockchain - Content Strategy - Crypto Native.md` (hash → 00cc87e6b15f6d1a3559a4b3c1f8376f)
  - `.raw/InnBlockchain - Content Strategy - Crypto Products.md` (hash → 86fa8a149b2ea17921683a528d771c2b)
  - `.raw/InnBlockchain - Content Strategy - FinTech.md` (hash → 71884caa609e8f7acd2d698bf8890186)
- Summaries: [[Content-Strategy-InnBlockchain-Crypto-Native]], [[Content-Strategy-InnBlockchain-Crypto-Products]], [[Content-Strategy-InnBlockchain-FinTech]]
- Pages created: [[InnBlockchain Content Strategy]] (umbrella), [[InnBlockchain Crypto Native Content Strategy]], [[InnBlockchain FinTech Content Strategy]], [[InnBlockchain Crypto Products Content Strategy]]
- Pages updated: [[index]], [[hot]], [[InnBlockchain]]
- Key insights:
  - Three parallel content programs mapped 1:1 to InnBlockchain ICPs (Crypto Native, FinTech, Crypto Products). Channel Partner ICP has no dedicated content program.
  - **Crypto Native**: 5 pillars (C1-C5) × 10 verticals (6 Active, 4 Watch) × 51 scored articles. Strict Phase 1 lock — 18 RWA + MiCA articles must publish fully before Phase 2 unlocks any of DEX/DeFi/Wallet/NFT/Token Launch content (~4-5 months concentrated on one vertical).
  - **FinTech**: 4 pillars (T1-T4) × 8 use-case clusters × 40+ scored articles. Primary Q2 2026 = WealthTech ⭐ (RWA/STO). LinkedIn ABM is dominant channel. EU compliance content (MiCA/MiFID II/DORA/EU AI Act/DLT Pilot) publishes in Active phase regardless of cluster — never deferred to Watch RegTech.
  - **Crypto Products**: 4 verticals (CEX/P2P/DEX/NFT) × 5 pillars × 40 scored articles × 5 personas. Security Hub (#1) publishes first as universal trust foundation; every subsequent article links back. First 12-post sequence locked.
  - **Cross-ICP SEO differentiation protocol**: every overlapping topic (RWA, upgrade patterns, audit checklists, travel rule, account abstraction/passkeys, hiring) carries inline disambiguation on both sides. Crypto Native angle = smart contract implementation / exploit; FinTech angle = compliance auditability / regulatory liability.
  - **Routing gate confirmed**: company origin, not licensing status. Embedded as explicit routing clause in every overlapping vertical (DEX, Lending, Wallets, RWA).
  - **AI-code audit overlay** (V10 Crypto Native) activates immediately on any active segment deal — no gate, no segment dependency. This is the one exception to Phase 1 lock.
  - **Persona 2 Diaspora Builder (Crypto Products)** is peer-driven: Facebook diaspora groups + WhatsApp communities are primary discovery channels, not search/Twitter.
  - **AI Search (ChatGPT/Perplexity/Gemini) is the new TOFU** for priority market crypto buyers (US/UK/EU/ME) — they query AI before Google. Content must be citation-structured; tracking is manual monthly harness until third-party tools mature.
  - **Compliance Carol** (FinTech CCO) addressed as veto-holder via content but not revenue-attributable — attribution methodology undefined.
  - **Risk flagged**: no shared keyword/topic ledger between Crypto Native and FinTech strategies. Disambiguation is prose per-article, not a central registry. First publishing conflict is the risk surface.

---

## [2026-04-15] reingest | InnBlockchain - ICP - FinTech.md (post-review fixes)
- Source: `.raw/InnBlockchain - ICP - FinTech.md` (hash → 86340bd89c7b926c207ff9e9828b7255)
- Pages updated: [[ICP-InnBlockchain-FinTech]], [[InnBlockchain FinTech ICP]], [[hot]]
- Source edits applied (8 issues from review):
  1. Segment reorder — WealthTech is now Segment 1 (Priority 1), ExchangeTech is Segment 2 (Priority 2). Physical document order now matches stated priority. All 8 cross-references updated (GTM header, Validation Plan, Activation Steps 2/4/5, strategic note).
  2. API-first Tier 0 contradiction resolved — removed "[ASSUMPTION — formalize as Tier 0]" tag since lead scoring already treats it as Tier 0. Kept pointer to 2026-05-15 validation and downgrade path if data doesn't support ≥2× win-rate threshold.
  3. Unused maturity tiers deleted — Early-adopter / Mainstream / Laggard row removed from firmographics table. Nothing downstream (scoring, playbook, activation) referenced it.
  4. Age ranges removed from all 3 persona headers (Sam, Tom, Carol). Low-value, hiring-adjacent risk.
  5. Segment 7 (Corporate Treasury & FX) marked Blocked on CFO persona definition in subtitle, not just buried note.
  6. Anti-ICP block dedup'd — collapsed to edge-cases callout that references the Disqualifying row instead of restating it. Kept ExchangeTech and WalletTech edge-case clarifications.
  7. Interview Q17 reframed — indirect budget question ("typical range you've seen work at companies your size") with explicit note that quantitative capture belongs in the survey. Most buyers won't share their own number on first call.
  8. AI content tagged `[unvalidated — pending 2026-05-31]` at 3 load-bearing insertions: Pain Point 5 header, WealthTech AI convergence note, SEO AI+Blockchain cluster. Rollback path is mechanical if the 2026-05-31 inbound test fails.
- Not fixed (needs human input): pricing/packaging section (no data), LTV/churn → repeat-engagement metric swap (judgment call on project-based model), Money20/20 date verification, optional routing-decision-tree canvas.
- Key insight: The AI + blockchain thesis has heavy document surface area but no closed-deal validation. Explicit `[unvalidated]` tags make the rollback mechanical if the 2026-05-31 test fails, rather than requiring a hunt for affected sections.

---

## [2026-04-15] reingest | InnBlockchain - ICP - Crypto Native.md (post-review fixes)
- Source: `.raw/InnBlockchain - ICP - Crypto Native.md` (hash → 7d1542eadee640b2b7d13221a6602e5f)
- Pages updated: [[ICP-InnBlockchain-Crypto-Native]], [[InnBlockchain Crypto Native ICP]], [[hot]]
- Source edits applied (7 issues from review):
  1. Budget floor contradiction fixed — $2M+ reframed as DeFi-side readiness signal only; $20k+ confirmed as universal hard gate; Must-Have criteria now explicitly splits to $30k+ for Segment 1 (RWA) vs $20k+ for Segments 2–6 and 8–10.
  2. Validation Plan date inconsistency — discovery calls pushed from 2026-04-30 to 2026-05-31 with explicit dependency on Activation Phase 1 (landing page + playbook due 2026-04-30). 48hr reactive outreach assumption split into its own Ongoing bullet.
  3. Segment 10 (AI x Crypto) Watch vs overlay conflict — now labeled "split status": AI-coded contract audit overlay is Active immediately (no segment gate, layer onto any Segment 1–9 deal), standalone AI x crypto protocol outbound remains Watch/Future Quarter.
  4. Segment 1 ACV floor mismatch — $20k+ Must-Have floor raised to $30k+ for RWA to align with $30k–$150k segment ACV target.
  5. Segment priority clarity — callout added that Segment 1 (RWA) is the highest-priority outbound target this quarter; numeric order = GTM priority, not alphabetical.
  6. Sasha counter-objection added to Objection Handling — *"How do I know your findings aren't AI-generated too?"* with response: AI used for triage/coverage only, every finding human-signed, offer live methodology walkthrough with lead auditor.
  7. $10M Sasha threshold assumption — new Validation Plan item owned by Sales Lead, due 2026-07-31, validate across first 5 deals.
- Key insight: The ICP was already strong; the biggest real risks were timing (discovery calls scheduled before the credibility materials existed) and a $20k/$30k floor mismatch that could qualify RWA deals below ACV target. Sasha AI-code counter-objection is the highest-leverage fix — without it, the AI-code audit pitch loses its most technically demanding evaluator in one exchange.

---

## [2026-04-16] reingest | InnBlockchain - ICP - Channel Partner-I.md (post-review fixes)
- Source: `.raw/InnBlockchain - ICP - Channel Partner-I.md` (hash → 9668f949d06ad1e37033e6acf25bdd5d)
- Pages updated: [[InnBlockchain Channel Partner ICP]] (Discovery Sprint price $1.5k-$4k → $2k-$5k with 1-2 week duration; audit firm objection clarified — CertiK/Hacken/Zellic as standard coordination partners vs. Trail of Bits/OpenZeppelin/Zellic as brand-name positioning), [[ICP-InnBlockchain-Channel-Partner]] (Discovery Sprint price + duration)
- Source edits applied during review: (1) Qualifying Criteria table — stripped trailing empty column from header, separator, and 8 data rows; (2) audit firm objection (line 250) — clarified CertiK/Hacken/Zellic are standard coordination partners and cross-referenced the brand-name audit objection for Trail of Bits / OpenZeppelin cases; (3) P1 Budget Authority row — added parenthetical note that Crypto Products sub-threshold routing is P1/P3-only (P2 FinTech uses different path).
- Key insight: Discovery Sprint pricing drifted upward vs. the previously ingested version — worth watching whether this was intentional repricing or a typo. Trioangle channel partner Discovery Sprint is still $1.5k-$4k (source: log entry 2026-04-15).

---

## [2026-04-15] reingest | Trioangle - ICP - Channel Partner.md (consistency review vs. Product + Service ICPs)
- Source: `.raw/Trioangle - ICP - Channel Partner.md` (hash → d54d34903ba88c8118c1bc096cc9792c)
- Pages updated: [[ICP-Channel-Partner-Trioangle]] (key_claims, Delivery modes row, Qualifying budget row, Segment Access section, Validation Status), [[Trioangle Channel Partner Personas]] (intro Segment Access framing, P1 delivery-mode exception callout, P2 MENA range, P3 end-clients adds AI-Forward Platform Operator)
- Source edits applied (Pass 2, cross-reference with [[Trioangle Product ICP]] and [[Trioangle Service ICP]]): (1) MENA Relationship Buyer corrected from $30k-$80k to $30k-$120k+ in P2 Budget Authority and End clients — matches Service ICP Persona 4; (2) Segment Access callout softened from "Cannot Reach Directly" to "Faster to Reach via Partners" — Service ICP lists LinkedIn/Clutch/Gartner as active direct channels for both Enterprise and MENA buyers, so "unreachable" was inaccurate; (3) AI-Forward Platform Operator (Service Persona 5, $15k-$60k) added to P3 Vertical Specialist end-clients — the Cursor/Lovable-wall narrative already in the doc makes this the natural routing match; (4) P1 delivery-mode exception added — ICP-level framing has Custom Dev primary / Clone Script alternative, but P1's end-client pool skews Product ICP so Clone Script is the primary route for P1 partners specifically.
- Source edits applied (Pass 1, standalone fixes): (5) InnBlockchain wikilink `[[ICP - Channel Partner-I]]` corrected to `[[InnBlockchain Channel Partner ICP]]`; (6) budget floor split by delivery mode in Must-Have criteria ($10k+ Custom Dev / $500+ Clone Script with live client brief) — resolved conflict with clone-script alternative; (7) P3 Budget Authority clarified to accept sub-$30k briefs when vertical fit is strong; (8) Discovery Sprint pricing ($1.5k-$4k) hoisted into Executive Summary — was buried in objection footnote.
- Unresolved (judgment calls): Burned Builder (Product Persona 2) and Super-App Ecosystem Builder (Product Persona 5) still omitted from Channel Partner routing — may be deliberate but not confirmed. Validation-status-vs-specificity tension, empty Research Log, and missing Trioangle-side channel economics flagged but not edited.
- Key insight: the prior Channel Partner doc oversold the partner motion by claiming Enterprise and MENA buyers were "unreachable" via direct channels when the Service ICP itself lists those channels as active. The accurate and still-compelling framing is time-compression, not access-exclusivity.

---

## [2026-04-15] reingest | InnBlockchain - ICP - Crypto Products.md (review-driven fixes)
- Source: `.raw/InnBlockchain - ICP - Crypto Products.md` (hash → b1894c35b2dea81fd297f9f9270cc3f9)
- Pages updated: [[InnBlockchain Crypto Products ICP]] (new sections: Price Band Anchors, Regulatory Framing by Priority Market, Graduation Path, Competitive Math, 800+ Backfire Risk)
- Source edits applied: (1) group-company brand/routing header, (2) partial-validation status callout, (3) scope-dial pricing anchors for $5–8k/$9–13k/$14–20k tiers, (4) tightened disqualifiers (prohibited jurisdictions, mixers, anonymous operators, ICO scaffolding, laundering patterns), (5) expanded regulatory section with MiCA/FCA/MAS/VARA/DIFC/ADGM/US by-jurisdiction framing, (6) Persona 3 (Web3 Protocol Architect) budget reconciled with explanation for $5–15k narrower band, (7) competitive table replaced "95%/95%" with defensible midpoint math (~96% cost / ~97% time, ~20× / ~40×), (8) new Graduation Path section with 5 re-engagement triggers + handoff protocol + 25% graduation target, (9) Persona 4 objection handling phishing/fake listings/royalty bypass with ERC-2981 + router allowlist + drainer blocklist response, (10) "800+ platforms" backfire warning on channel-partner deals.
- Key insight: Crypto Products is not a terminal product line — it's a production-validation step in a 12-month conversion funnel toward InnBlockchain custom dev. Target 25% graduation rate; track the cohort.

---

## [2026-04-15] ingest | InnBlockchain ICPs (4 files — Crypto Native, FinTech, Channel Partner, Crypto Products)
- Sources: `.raw/InnBlockchain - ICP - Crypto Native.md`, `.raw/InnBlockchain - ICP - FinTech.md`, `.raw/InnBlockchain - ICP - Channel Partner-I.md`, `.raw/InnBlockchain - ICP - Crypto Products.md`
- Summaries: [[ICP-InnBlockchain-Crypto-Native]], [[ICP-InnBlockchain-FinTech]], [[ICP-InnBlockchain-Channel-Partner]], [[ICP-InnBlockchain-Crypto-Products]]
- Pages created: [[InnBlockchain]] (entity), [[InnBlockchain Crypto Native ICP]], [[InnBlockchain FinTech ICP]], [[InnBlockchain Channel Partner ICP]], [[InnBlockchain Crypto Products ICP]] (concepts), plus 4 source summaries
- Pages updated: [[index]], [[hot]]
- Key insight: InnBlockchain is Trioangle's **sister/group company** for blockchain dev + smart contract security; routing between Crypto Native and FinTech is decided by **company origin, not license status**; Crypto Products clone scripts (operated under Trioangle brand) are the sub-$20k routing destination for crypto-native clients **but not for FinTech clients**; all 4 ICPs share a single EU Continental / 5-project geography gate.

---

## [2026-04-15] reingest | Content Strategy - Product.md + Product Blog Article Templates.md (rev 2)
- Sources: .raw/Content Strategy - Product.md, .raw/Product Blog Article Templates.md (propagation from ICP v3 gap-fix pass)
- Pages updated: [[Content-Strategy-Product]], [[Product-Blog-Article-Templates]], [[Trioangle Content Strategy]]
- Content Strategy additions: Persona 6 in Target Audience (<14 day cycle); AI-Era Positioning Rule callout under Mission; Pillar 3 rationale rewritten to reference PP5 7/10 + 4.0 App Store rating filter; Trioangle Founder Referral named in channel #7 + Priority Distribution Channels (dual reward, 90-day attribution, Small Business added as beneficiary); new Secondary Markets distribution playbook (6-row comparison); T14 gains 2 P6 AI-trigger variants; Quick Win #7 promotes T18 as canonical P6 unlock
- Blog Templates additions: AI-Era Positioning Rule + Persona Abbreviations (P1–P6 with P6 technical-honesty warning) at intro; T14 gains 2 P6 AI-trigger variants + P6 CTA; T18 "Clone Script vs AI Builders" elevated to canonical P6 decision anchor with extended writer brief (acknowledge-then-document-gap); T11 P6 case study note; new Global Writer Briefs section (Secondary-Market Variants table, AI-Era Compliance Check, Referral Program References)
- Concept update: [[Trioangle Content Strategy]] gains Global Writer Briefs section and Persona 6 Coverage Map table; T18 standout entry rewritten as canonical P6 anchor with technical-honesty rule
- Decision: no new top-level template (T21+) added — P6 short cycle + narrow pain is served by T14 awareness + T18 decision variants; revisit only if P6 inbound justifies second decision-stage asset

## [2026-04-15] reingest | ICP - Product.md (v3 — gap fixes)
- Source: .raw/ICP - Product.md (third pass — 6 gap fixes + 6 structural/consistency fixes from review)
- Pages updated: [[Trioangle Product ICP]], [[ICP-Product-Trioangle]]
- Gap fixes: (1) Persona 1 AI-displacement re-evaluation triggers with CRM-tagging dependency, (2) PP5 severity 5→7/10 + rewritten workaround/cost/emotion, (3) Trioangle Founder Referral — full structured program definition (eligibility, 90-day attribution, support-or-cash reward, tracking, activation), (4) Persona 6 origin paragraph (why they chose AI over agency — priced out + peer burns + creator-wave belief), (5) Other Clone Vendors row quantified (205 scripts vs competitor 20–60), (6) Secondary Markets distinct playbook (channel mix, payment, language, trust signals, sales motion)
- Consistency fixes: blockquote prefix repair on Product→Service routing row; Post-Purchase Arc + Top 3 Channels updated to reference the new referral program structure
- Key finding: referral program was referenced in 3 places but never defined — now a named, tracked program with a 90-day window tuned to the slowest documented persona decision cycle

## [2026-04-15] ingest | Trioangle - Product Verticals.md
- Source: .raw/Trioangle - Product Verticals.md (Trioangle internal, sitemap analysis, 2026)
- Pages created: [[Trioangle-Product-Verticals]]
- Updated: [[sources/_index]], [[index]]
- Key finding 1: 205 distinct product scripts across 8 verticals — distinct from 800+ deployments; full brand name map documented (Gofer, Makent, PassUp, PopTok, Igniter, GoferHandy, GoferJek, GoferTow, Udify)
- Key finding 2: Watchit (YouTube/Vimeo clone) appears in this source but is NOT an active product — flagged in source page; never reference in any content

## [2026-04-15] reingest | ICP - Service.md (updated)
- Source: .raw/ICP - Service.md (updated by user — three additions)
- Pages updated: [[Trioangle Service ICP]], [[ICP-Service-Trioangle]]
- Addition 1: PP numbering fixed — PP6 (AI Knowledge Gap, 9/10) renumbered to PP5; PP5 (Domain Expertise, 7/10) renumbered to PP6; order now matches severity descending
- Addition 2: AI-era positioning rule added — "Never position on faster with AI. Position on domain expertise, certainty of delivery, and risk reduction." Added to both raw file and concept page
- Addition 3: Discovery Sprint defined as a named pre-sales offer — $1,500-$4,000, 2 weeks, credited toward full engagement; added to raw file and concept page with deliverables and sales line

## [2026-04-15] reingest | ICP - Product.md (updated)
- Source: .raw/ICP - Product.md (updated by user — two additions)
- Pages updated: [[Trioangle Product ICP]], [[ICP-Product-Trioangle]]
- Addition 1: Vertical inbound priority column added to 8 Product Verticals table; rows reordered by inbound signal; PopTok (TikTok clone) flagged as active inbound — build BOFU immediately
- Addition 2: AI-era positioning rule added — "Never position on faster with AI. Position on certainty of outcome and risk reduction." Added to Executive Summary in source and as standalone section in concept page

## [2026-04-15] ingest | Content Strategy - Product.md + Content Strategy - Service.md + Product Blog Article Templates.md
- Sources: .raw/Content Strategy - Product.md, .raw/Content Strategy - Service.md, .raw/Product Blog Article Templates.md (Trioangle internal, 2026)
- Pages created: [[Content-Strategy-Product]], [[Content-Strategy-Service]], [[Product-Blog-Article-Templates]], [[Trioangle Content Strategy]]
- Updated: [[sources/_index]], [[concepts/_index]], [[index]]
- Key finding 1 (Product): TikTok clone (PopTok) has active inbound NOW — BOFU content must be built alongside TOFU to capture existing demand immediately. Don't wait for full awareness funnel.
- Key finding 2 (Service): CTA is strictly persona-gated. MENA articles NEVER use form-based CTAs — always LinkedIn/WhatsApp, no exceptions. Budget overlap zone ($30k-$40k) defaults to Founder-CTO motion unless post-Series A context confirmed.
- Key finding 3 (Templates): Article #36 (Build vs Buy 2026, score 9.3) is the one piece that bridges both ICPs — must coordinate across both content calendars. WatchIt (long-video clone) is NOT an active product; never reference it.

## [2026-04-15] ingest | ICP - Channel Partner-T.md + ICP - Service.md
- Sources: .raw/ICP - Channel Partner-T.md and .raw/ICP - Service.md (Trioangle internal, 2026)
- Pages created: [[ICP-Channel-Partner-Trioangle]], [[ICP-Service-Trioangle]], [[Trioangle Channel Partner Personas]], [[Trioangle Service ICP]]
- Updated: [[sources/_index]], [[concepts/_index]], [[index]]
- Key finding 1 (Channel Partner): Enterprise Buyer and MENA Relationship Buyer in the Service ICP are not reachable via direct outbound - channel partners are the only access path. This makes the partner program structurally necessary, not just a growth lever.
- Key finding 2 (Service ICP): AI-Forward Platform Operator (Persona 5) is a 2026-emergent buyer archetype - existing platforms under competitive AI pressure, needs domain-specific AI features, not a rebuild. Distinct from all prior personas.

## [2026-04-15] ingest | ICP - Product.md
- Source: .raw/ICP - Product.md (Trioangle internal, 2026)
- Pages created: [[Trioangle]], [[Trioangle Buyer Personas]], [[ICP-Product-Trioangle]]
- Updated: [[entities/_index]], [[sources/_index]], [[index]]
- Key finding: Persona 6 (AI Builder Who Hit the Wall) is a named, revenue-generating buyer archetype — direct validation that vibe coding creates a real market for production-deployment services

## [2026-04-15] autoresearch | Marketing and Sales for AI-Era Dev Company
- Rounds: 2
- Sources found: 4 (IBD Consulting, Improvado alignment guide, Martal 5 strategies, Sopro alignment stats)
- Pages created: [[Marketing-Sales Alignment]], [[Research: Marketing and Sales for AI-Era Dev Company]]
- Updated: [[index]], [[concepts/_index]]
- Key finding: Do NOT position on "faster with AI" — position on certainty of outcome. Buyers in 2026 can vibe-code themselves; they're buying risk reduction and end-to-end accountability.

## [2026-04-15] autoresearch | Running a Software Dev Company Post-Vibe-Coding
- Rounds: 2
- Sources found: 6 (Karpathy 2025, Jellyfish Eng Mgmt, LeadDev 5 Predictions, Augment Code Hiring, Harvard Gazette, Chargebee Pricing)
- Pages created: [[Vibe Coding]], [[Agentic Engineering]], [[AI-Native Engineering Team]], [[Outcome-Based Pricing]], [[Karpathy-2025-Year-in-Review]], [[Jellyfish-2025-Engineering-Management]], [[LeadDev-5-Predictions-2026]], [[Augment-Code-AI-Native-Hiring]], [[Research: Running a Software Dev Company Post-Vibe-Coding]]
- Updated: [[Andrej Karpathy]] (added vibe coding + agentic engineering), [[index]], [[concepts/_index]], [[sources/_index]]
- Key finding: The competitive advantage in software dev has moved from headcount to leverage — smaller teams with AI orchestration skills out-deliver larger traditional teams; pricing must shift from hourly to outcome-based

## [2026-04-08] save | claude-obsidian v1.4 Release Session
- Type: session
- Location: wiki/meta/claude-obsidian-v1.4-release-session.md
- From: full release cycle covering v1.1 (URL/vision/delta tracking, 3 new skills), v1.4.0 (audit response, multi-agent compat, Bases dashboard, em dash scrub, security history rewrite), and v1.4.1 (plugin install command hotfix)
- Key lessons: plugin install is 2-step (marketplace add then install), allowed-tools is not valid frontmatter, Bases uses filters/views/formulas not Dataview syntax, hook context does not survive compaction, git filter-repo needs 2 passes for full scrub

## [2026-04-08] ingest | Claude + Obsidian Ecosystem Research
- Type: research ingest
- Source: `.raw/claude-obsidian-ecosystem-research.md`
- Queries: 6 parallel web searches + 12 repo deep-reads
- Pages created: [[claude-obsidian-ecosystem]], [[cherry-picks]], [[claude-obsidian-ecosystem-research]], [[Ar9av-obsidian-wiki]], [[Nexus-claudesidian-mcp]], [[ballred-obsidian-claude-pkm]], [[rvk7895-llm-knowledge-bases]], [[kepano-obsidian-skills]], [[Claudian-YishenTu]]
- Key finding: 16+ active Claude+Obsidian projects; 13 cherry-pick features identified for v1.3.0+
- Top gap confirmed: no delta tracking, no URL ingestion, no auto-commit

## [2026-04-07] session | Full Audit, System Setup & Plugin Installation
- Type: session
- Location: wiki/meta/full-audit-and-system-setup-session.md
- From: 12-area repo audit, 3 fixes, plugin installed to local system, folder renamed

## [2026-04-07] session | claude-obsidian v1.2.0 Release Session
- Type: session
- Location: wiki/meta/claude-obsidian-v1.2.0-release-session.md
- From: full build session — v1.2.0 plan execution, cosmic-brain→claude-obsidian rename, legal/security audit, branded GIFs, PDF install guide, dual GitHub repos


- Source: `.raw/` (first ingest)
- Pages updated: [[index]], [[log]], [[hot]], [[overview]]
- Key insight: The wiki pattern turns ephemeral AI chat into compounding knowledge — one user dropped token usage by 95%.

## [2026-04-07] setup | Vault initialized

- Plugin: claude-obsidian v1.1.0
- Structure: seed files + first ingest complete
- Skills: wiki, wiki-ingest, wiki-query, wiki-lint, save, autoresearch
