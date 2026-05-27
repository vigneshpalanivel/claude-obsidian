---
company:
  - innblockchain
department:
  - marketing
priority: high
rev: 7
last_revised: 2026-05-27
revision_notes: |
  rev 7 (2026-05-27): documentation-clarity pass addressing 11 issues from the third review round against rev 6. Fixes fall into three categories: **(1) Documentation gaps surfaced by user comprehension question** — "parallel chains" was used 5+ times across the doc (Operating Principle 5, `[Both]` section heading, decision table, Anti-Patterns, Tier × Track × Motion Matrix step 3) but never defined explicitly; user asked "what does parallel chains mean?" confirming the term wasn't parseable from context. Added explicit definition in Operating Principle 5 with concrete example (Reentrancy article → Track A chain = X thread + Telegram + GitHub + Mirror.xyz; Track B chain = Tom-coded LinkedIn carousel + LinkedIn long-form; both run concurrently within the article's 3-week LinkedIn cadence, not one after the other). Reinforcement callout added at `[Both]` section heading. **(2) Cross-table cell errors carried over from rev 6 Master Index changes** — when rev 6 expanded Master Index to support mixed-tier formats (X thread Tier 1+2+3, RWA Felix variant Tier 1+2, Mirror.xyz Tier 1+2 technical), the per-format tables updated correctly but the cross-table cells weren't fully reconciled. Three cells fixed: (a) A Tier 2 cell now includes RWA Felix LinkedIn variant (was "newsletter brief mention only" — omitted the one A format that extends to Tier 2); (b) B Tier 2 cell now includes Mirror.xyz alongside Telegram (was Telegram-only despite both being Tier 1+2 Track A technical per Master Index); (c) B Tier 1 cell reworded from soft "as bandwidth allows" to "all applicable per track + hub restrictions — Telegram/Mirror.xyz/Hacker News are standard Tier 1 technical expectations, not optional." Also fixed the Format Classification IMPORTANT callout which still said "S applies to all Tier 1+2; A may apply only to Tier 1" — accurate in rev 5 but stale after rev 6 mixed-tier expansion. Rewritten to acknowledge mixed-tier reality and route readers to per-format Article Tiers column as authoritative. **(3) Production realism + cap coverage gaps** — Q1 stacking: rev 6 anchored sample audit annual refresh in Q1 AND said research-report sprint typically Q1 or Q3. Both consuming the same dedicated resource in Q1 = compound non-derivative load not flagged. Fixed: sample audit anchor decision now tied to first-delivered-engagement timing (when redacted real audit becomes available) rather than calendar — separated from sprint window explicitly. LinkedIn output cap section now addresses Tier 2 Track B aggregate: when 2 Tier 2 Track B articles publish same week (Tue + Thu), carousel + quote graphic per article = 4 LinkedIn posts that week from one profile before cross-pillar Tier 1 cadence layers on top; new rule defers one Tier 2 article's quote graphic if breaches 7-posts/week aggregate. **Other fixes**: "single thread" at Tier 3 reworded to "one X thread (8-14 posts)" to remove ambiguity with "single tweet"; Watch-candidate anti-pattern reconciled with Tier 3 → Tier 2 promotion trigger (c) — anti-pattern reframed as "continuing Tier 3 repurposing past the 90-day review without making explicit kill OR promote decision" (drift, not investment); "Phase 1 has no portfolio" constraint marked as starting-state-only with replan trigger when first delivered engagement allows redacted real audit (likely mid-to-late Phase 1 if WL-1 or B1 client signs); "Tier 2 supplemental" phrasing for LinkedIn quote graphic clarified (Tier 2 = alongside carousel as second LinkedIn post subject to ≥48 hr spacing; Tier 3 = instead of carousel since carousel forbidden at Tier 3).
  rev 6 (2026-05-27): structural-integrity pass addressing 29 issues surfaced in two review rounds against rev 5. Fixes fall into six categories: **(1) Operating Principles re-grounded against rev 4/5 reality** — P1 now exempts Cross-Track Assets from the 'source article first' rule (sample audit report / research report / newsletter are standalone, not per-article derivatives); P3 explicitly acknowledges three documented cross-ICP variants that violate the 'track determines surface' rule by design (Tom-coded LinkedIn from Track A technical, RWA Felix LinkedIn from Track A 📎-tagged, dual LinkedIn carousels for RWA-themed `[Both]`); P6 removes long-form video (Deferred C) and FAQ pages (Excluded D — belongs in AEO/GEO doc) from the WL active-surfaces list; WL active surfaces narrowed to comparison tables + standalone infographics for hubs + Mirror.xyz + WL-1 LinkedIn (RWA Felix). **(2) Master Index ↔ per-track reconciliation** — added RWA Felix LinkedIn variant row to [A] table (was present in Track A section only); split GitHub repo and Solodit profile into separate Master Index rows to match Track A section; aligned LinkedIn quote graphic to Tier 2+3 only (removed Tier 1 supplement use from Track B section, which was both inconsistent with Master Index and contributed to LinkedIn feed cannibalization); added Tier 3 newsletter roundup mention to Own email newsletter row (was missing). **(3) Cross-table reconciliation with Repurposing Tiers** — S Tier 3 row corrected: no carousel ever per Tier 3 definition; updated to 'X thread for Track A; LinkedIn quote graphic for Track B' (was incorrectly listing carousel as option); A Tier 2 row corrected: own email newsletter brief mention only (LinkedIn long-form and Tom variant are Tier 1 only per Master Index); A Tier 3 row updated: newsletter roundup mention (was incorrectly 'Skip'); added cross-table header note that track restrictions from Master Index apply on top of tier gates. **(4) LinkedIn output cap and spacing rules** — new Track B sub-section addressing rev 5 LinkedIn feed cannibalization: cross-pillar Tier 1 articles generate up to 6 LinkedIn posts from one profile (carousel + long-form + 3 persona variants + native video); 6 posts in one week dilute algorithm signal exactly as the multi-audience posting rule warned. New rule: ≥48 hr between any two LinkedIn posts about the same article from the company profile; cross-pillar Tier 1 LinkedIn cadence spread across 3 weeks (launch week = carousel + long-form + persona variant 1; week 2 = persona variant 2 + optional video; week 3 = persona variant 3); cross-pillar Tier 1 publishes capped at 1/week to avoid breaching spacing across two articles. **(5) Tier upgrade + Tier 0 activation triggers expanded** — previously only Tier 2 → Tier 1 was defined. Added Tier 3 → Tier 2 promotion path (3× organic traffic baseline within 60 days OR page-1 rank on long-tail query); added Tier 0 → active activation protocol (when LP publishes, WL Reference Build Gate clears, or AI+Blockchain validation completes — the latter due 2026-05-31, 4 days from this rev): article promotes to its appropriate tier per original score; derivative backfill chain runs from gate-clear date forward at standard tier depth; added rare-case demotion path for Tier 1 underperformers at 90-day review. **(6) Adjacent Motions table restructured** — Cadence column previously contradicted Tier gate column (e.g., 'Bi-monthly Phase 1' AND 'Tier C deferred until trigger'). Restructured to three columns: Phase 1 status + activation trigger / Cadence once active / Notes — making conditional explicit. **Other fixes**: removed Twitter Spaces hosting from Production Cadence Monthly band (contradicted Format Classification Deferred C status); fixed 'annual review (only quarterly check)' ambiguity for sample audit report → 'annual refresh with quarterly status check for emergent updates'; added research-report sprint protocol (4-8 weeks: derivative production drops to Tier 3 amplify-only; document downgrades in Editorial Calendar); split metric windows for Carol-pattern + sample audit (30-day intent signal vs 90-day conversion) to match Carol's procurement cycle (rev 5's blanket 30-day window under-measured Carol assets); added metric for Tom-coded LinkedIn variant from Track A; sharpened sample audit report synthetic-disclosure language (if no portfolio, asset must self-disclose as reference report drawn from public exploit research); added `[Both]` decision table X thread answer split by article type (technical `[Both]` X thread is correct for Felix; RWA `[Both]` no X thread because RWA Felix is on LinkedIn); added Embedded Wallets / Passkey Auth classification override note (default technical → Tom; override to Carol-coded if source article frames primarily as eIDAS compliance, Sam-coded if business-UX); added Tier × Track × Motion Matrix Step 3 WL routing (was a gap); softened Memes (D) classification with cultural-participation nuance (light reactions/replies are community engagement, not the excluded format — original meme production from company account is); added Comparison-vs-competitor (D) disambiguation against technical comparison tables (different items, prevent conflation); webinar / panel talking points (B) vs webinar / panel hosting (C) disambiguation added in both rows; Anti-Patterns expanded with three new entries (LinkedIn feed cannibalization, Tier 1 chain for Watch-candidate, source article CTA misalignment); revised order of revision notes to descending (rev 6 first). Email capture path now explicitly documented: primary = per-article lead magnet (Tier 1); secondary = cluster Tier 1 hub lead magnet for Tier 2 articles via in-article cross-link CTA; tertiary = newsletter sign-up CTA on every article + Cross-Track Assets driving independent capture. Scope callout updated 'Friday batch session' → 'daily batch session' to reflect dedicated-resource cadence. Single-resource staffing caveat reframed: edge cases (cross-pillar Tier 1 + monthly infographic stacking, 2 Tier 1 in one week, reactive concurrent with planned work) occur ~1 week/month minimum — designer/producer support not optional for production months.
  rev 5 (2026-05-26): comprehensive format coverage + priority classification, surfaced by user question "is there any other content type or category I'm missing here?". Resource constraint relaxed (dedicated repurposing resource being assigned). Four structural additions: (1) **Master Format Classification (S/A/B/C/D)** — new section after Operating Principles. Every derivative format gets a priority tier: Critical (S) gates revenue; High-Leverage (A) compounds; Standard (B) capacity-allowing; Deferred (C) Phase 2 queue with triggers; Excluded (D) explicit skip list with reasons. Distinct from Article Tiers (1/2/3/0 — score-driven investment levels). (2) **6 new derivative rows added across Tracks** — Track A: Mirror.xyz cross-post, Hacker News (Show HN / Ask HN). Track B: Sample audit report / sample deliverable PDF, Standalone infographic, Whitepaper / ebook, LinkedIn native video (60-90 sec). Cross-track: Original research / data report (annual flagship), Own email newsletter. (3) **Adjacent Motions section** — new section for longer-lead motions (guest blogs, podcast appearances, conference speaking, sponsored newsletters, customer testimonial video) owned by dedicated resource but running on monthly/quarterly cadence, not weekly batch. (4) **Excluded Formats section** with **per-format reasons** — so future "should we do X?" questions get answered from the doc, not relitigated. Covers Medium, Pinterest, TikTok, Stack Overflow, Facebook, r/CryptoCurrency, memes, dev.to/HashNode (Mirror.xyz overlap), Bluesky/Farcaster/Lens, documentary case studies, vlogs, Clubhouse, direct mail, LinkedIn Live audio events, FAQ pages (belongs in SEO/AEO doc), comparison-vs-competitor pages (legal risk). (5) Production Cadence rewritten for dedicated-resource staffing — daily/weekly/monthly/quarterly/reactive bands instead of Friday 2-hr block (Friday block retained for measurement + planning + Tier 1 lead-magnet finalisation). Total format count after this rev: **20 active formats in Phase 1 (5 Critical S + 6 High-Leverage A + 9 Standard B), 12 deferred to Phase 2 (C), 20 explicit skip (D) — 52 formats total classified**. Format-first thinking flagged as failure mode in Anti-Patterns — the article remains the source-of-truth, format follows.
  rev 4 (2026-05-26): fixed over-binary "no technical content on LinkedIn" rule, surfaced by user question "CTOs and technical heads are on LinkedIn, why are we avoiding technical posts there?". The rev 1–3 framing assumed LinkedIn's technical audience is Felix (crypto-native protocol CTO) — wrong audience for InnBlockchain's LinkedIn profile, which is positioned for Sam + Tom + Carol + RWA Felix. Real LinkedIn technical audience is **Track B Tom** (FinTech CTO researching blockchain vendors + peer-learning security) per Content Strategy line 1066. Three fixes: (1) Track A "Where buyers read" preamble rewritten — LinkedIn now serves two secondary Track A audiences (RWA Felix for plain-language; Tom for reframed technical), with explicit note that Felix-coded Solidity threads still belong on X. (2) Track A asset family adds new derivative row: **LinkedIn post (Track B Tom variant)** for Tier 1 Track A technical articles — cost-gated (~30 min reframe; skip for Tier 2/3); not a copy-paste of the X thread but a vendor-evaluation / risk-assessment angle ("If your FinTech is evaluating a blockchain vendor..."). Cross-ICP re-engage pattern. (3) `[Both]` parallel chains section restructured by topic type: **technical `[Both]` articles** (security primers) → Track B audience is **Tom-coded** carousel, NOT Sam-coded (Sam doesn't care about reentrancy mechanics); **RWA / business-buyer `[Both]` articles** (Asset Tokenization 101, MiCA Explained) → Sam-coded carousel; **compliance-led `[Both]` articles** (P5-eIDAS-X) → Carol-coded primary + Tom-coded secondary. Rule of thumb added: look at which Track B persona the topic naturally serves before defaulting to Sam-coded — Sam-coded across all Track B carousels is a framing mistake. (4) Anti-pattern revised: "Never post technical Track A on LinkedIn" → "Never post in **Felix-coded framing**; DO produce a Tom variant" with concrete example of three frames from one source (X thread Felix / Tom variant FinTech-CTO / RWA Felix asset-owner). Track A anti-derivatives list also corrected — removed "LinkedIn document carousels for technical articles (Felix/Sasha don't read carousels)" because Tom DOES read carousels.
  rev 3 (2026-05-26): fixed internal inconsistency in `[Both]` parallel-chains logic, surfaced by user question "can I post two carousels and two X threads from one profile?". Rev 1/2 said `[Both]` articles get "two X threads (technical for Felix, asset-class for RWA Felix)" but the decision table elsewhere correctly said RWA Felix doesn't live on Crypto Twitter. Fixes: (1) Operating Principle #5 rewritten — parallel chains = platform-split, not platform-doubled. Most `[Both]` articles get **one X thread + one LinkedIn carousel** because audiences live on different platforms. Two LinkedIn carousels from one profile only applies to RWA-themed `[Both]` articles (Asset Tokenization 101 / MiCA Explained / P5-eIDAS-X) where both Track A (RWA Felix) and Track B (Sam) audiences are on LinkedIn. (2) `[Both]` Parallel Chains section now distinguishes **technical `[Both]` articles** (Felix on X; one carousel total — Sam-coded) from **RWA-themed `[Both]` articles** (RWA Felix on LinkedIn; two carousels with spacing rule). Explicit article-by-article list added so writers know which pattern applies. (3) LinkedIn carousel row in Track B asset family got a new **multi-audience posting rule** for RWA-themed `[Both]` articles: ≥24–48 hr spacing between Sam-coded + RWA Felix–coded carousels, differentiated hashtag stacks (`#WealthTech #MiFIDII #AssetManagement` vs `#PropTech #RealEstateInvestment #Tokenization`), sponsored targeting on at least one (Sales Navigator filtered named-accounts vs PropTech/commodity/private-credit). Reason: same-profile dual carousels dilute the LinkedIn algorithm's audience-targeting signal; spacing + sponsored mitigates it. No change to non-RWA `[Both]` pattern (still one X thread + one LinkedIn carousel).
  rev 2 (2026-05-26): consolidated derivative-content rules from Content Strategy rev 17 + Editorial Calendar rev 10 (both stripped their inline repurposing content and now link here). Updates: (1) LinkedIn carousel slide count corrected from "8–12" → "**7–10**" (matches Content Strategy working spec). (2) Added carousel **deployment mode** — organic + sponsored (LinkedIn ads). (3) Added **WealthTech-first capacity rule** — when carousel production capacity is constrained, B1 WealthTech/RWA articles take priority (matches Q2 2026 primary focus per Content Strategy). (4) Added rationale for **WL-1 LinkedIn amplification exception** — "RWA Felix lives on LinkedIn" (per Content Strategy line 818). (5) Added **LinkedIn quote graphic** as a distinct Tier 2/3 derivative format (was implicit in Editorial Calendar Wed amplification row — single-image, ~10-min production; distinct from carousel). (6) Added **Telegram dev-group syndication timing** — Wed afternoon per Editorial Calendar posting times.
  rev 1 (2026-05-26): initial blueprint. Sister doc to `InnBlockchain - Content Strategy.md` (article inventory + scoring) and `InnBlockchain - Editorial Calendar.md` (publish dates + Fri 2hr repurpose block). This doc answers what the calendar's "Repurpose + measure | Fri | 2 hr" line leaves open: which articles deserve full repurposing vs. publish-and-amplify, how derivative formats differ between Track A (X/Telegram/GitHub) and Track B (LinkedIn ABM/Money20-20/Finextra), and how `[Both]` articles split derivatives without mixing CTAs.
tags:
  - content
  - repurposing
  - distribution
---

# ♻️ Content Repurposing Plan — InnBlockchain

> [!NOTE] Scope
> Overview / blueprint only. Defines **repurposing tiers, per-track asset families, split-CTA discipline, and production cadence**. Does NOT enumerate derivatives per article — that is decided in the **daily batch session** by the dedicated repurposing resource using the rules below. Calendar dates and per-article publish schedule live in [[InnBlockchain - Editorial Calendar]]; article inventory + scoring + sales motion tags live in [[InnBlockchain - Content Strategy]].

> [!INFO] Why this doc exists
> The editorial calendar originally allocated a 2-hr Friday block ("Repurpose + measure — X threads, LinkedIn quote graphics, Telegram syndication, log metrics") as a time budget without decision rules. Result: every article got the same treatment regardless of score, track, or motion. This doc imposes a **tiered investment model** so a 9.7-scored A1 hub gets the full derivative chain while an 8.0 trending piece gets minimum amplification. As of rev 5+ (dedicated-resource model), derivative production runs Mon–Thu; the Friday block is retained for measurement + planning + Tier 1 lead-magnet finalization only — see Production Cadence section.

---

## 📋 Operating Principles

1. **Per-article derivatives require a published source article.** No standalone repurposing without a published source article behind it (avoids "LinkedIn post that goes nowhere"). **Cross-Track Assets exception:** standalone flagship assets — sample audit report, original research / data report, own email newsletter — are NOT per-article derivatives and are exempt from this rule. They are produced independently and benefit the entire content program (see Cross-Track Assets section).
2. **Repurposing investment scales with article score, not with format availability.** Don't burn full production on an 8.0; don't shortcut a 9.5.
3. **Track determines primary surface; cross-ICP variants exist for specific article types.** Track A derivatives primarily live where Felix/Sasha read (X, Telegram, GitHub, Rekt News, Solodit). Track B derivatives primarily live on LinkedIn (carousels + persona variants), Finextra, Sibos panels. **Three documented cross-ICP variants violate the primary-surface rule by design:** (a) Tier 1 Track A technical → Tom-coded LinkedIn variant (FinTech CTO on a Track B surface); (b) Tier 1+2 Track A 📎-tagged plain-language RWA articles → RWA Felix LinkedIn variant (asset owner on a Track B surface); (c) RWA-themed `[Both]` articles → dual LinkedIn carousels (both audiences live on LinkedIn). **Outside these three documented exceptions, repurposing into the wrong track's surface = wasted production.**
4. **Sales motion CTA is preserved across every derivative.** An `[Audit]` article's X thread, LinkedIn post, and PDF excerpt all close with the audit CTA. Mixing CTAs across derivatives is the single most common failure mode — see Anti-Patterns at the bottom.
5. **`[Both]` articles get parallel derivative chains, not blended ones.** **Definition:** a "parallel chain" is one of two separate derivative sequences (one per track) produced from a single `[Both]` source article and run **concurrently** (not sequentially). Example for the Reentrancy primer (a technical `[Both]` article): **Track A chain** = X thread (Felix on Crypto Twitter) + Telegram dev-group share + GitHub gist + Mirror.xyz cross-post; **Track B chain** = Tom-coded LinkedIn carousel + LinkedIn long-form. Both chains run at the same time within the article's launch + 3-week LinkedIn cadence — not one after the other. Parallel = platform-split, not platform-doubled. Most `[Both]` articles get **one X thread (Track A Felix on Crypto Twitter)** + **one LinkedIn carousel** — Track B framing varies by topic (Tom-coded for technical primers, Sam-coded for business/RWA topics, Carol-coded for compliance — see `[Both]` Parallel Chains section for the topic→persona map). Two LinkedIn carousels from one profile apply only to **RWA / business-buyer `[Both]` articles** where both Track A (RWA Felix) and Track B (Sam) audiences live on LinkedIn — and even then they require ≥24–48 hr spacing + differentiated hashtag/targeting stacks (see Track B carousel row). Never one "universal" derivative; never an X thread aimed at RWA Felix (RWA Felix doesn't live on Crypto Twitter — non-technical asset-owner framing is hostile to that audience).
6. **WL articles repurpose only via SEO-amplifying surfaces active in Phase 1:** technical comparison tables (e.g., feature comparison matrices, not competitor-naming pages), standalone infographics for hub articles, Mirror.xyz cross-post for technical WL content. **Long-form video is Deferred (C)** — not available in Phase 1; **standalone FAQ pages are Excluded (D)** — belong in [[InnBlockchain - Content AEO GEO Prompts]], not this plan. **LinkedIn amplification exception: WL-1 only** — because RWA Felix (the WL-1 buyer: real estate developer, vehicle fleet owner, commodity producer) lives on LinkedIn, not on Crypto Twitter. WL-2 through WL-6 buyers don't read LinkedIn for productized-platform research, so no LinkedIn amplification. **No X/Telegram for any WL article** — wrong buyer for all six.

---

## 🗂️ Format Classification (Master Index)

> [!IMPORTANT] Two orthogonal tier systems
> This doc uses **two** tier systems that operate independently:
> - **Format Priority (S/A/B/C/D below)** — answers "*should we produce this format at all?*" Decided once per format. Reviewed quarterly.
> - **Article Tier (1/2/3/0 in next section)** — answers "*how much investment per article?*" Decided per published article by score + LP state.
>
> **Per-format Article Tier coverage is mixed.** Most S formats apply to Tier 1+2 (LinkedIn carousel), some only Tier 1 (vendor risk pack, lead magnet), one extends to Tier 3 (X thread for Track A), and one is a Cross-Track Asset not tier-gated per-article (sample audit report). Most A formats are Tier 1 only, some extend to Tier 2 (RWA Felix LinkedIn variant for Track A 📎-tagged articles), one covers all tiers in degraded form (newsletter — featured / brief / roundup). Deferred (C) and Excluded (D) formats never produce in Phase 1 regardless of Article Tier. **The per-format Article Tiers column is authoritative**; the cross-table at the bottom of this section summarizes investment depth by Tier but defer to the per-format column for edge cases.

### S — Critical (revenue-gating; must-do for every applicable article)

These don't grow revenue alone — but without them, the source articles don't convert. Skipping any of these is structural.

| Format | Track | Article Tiers | Why revenue-gating |
|---|---|---|---|
| **X thread** (8–14 posts) | Track A | Tier 1 + 2 + 3 (Tier 3 = single thread, amplify-only) | Felix's primary discovery surface; without it, Track A articles get no protocol-developer reach |
| **LinkedIn document carousel** (7–10 slides, topic-coded Sam/Tom/Carol) | Track B | Tier 1 + 2 only (**no carousel at Tier 3** per Tier 3 amplify-only definition) | Sam/Tom/Carol's primary engagement format on LinkedIn ABM; without it, LinkedIn posts underperform 5–10× |
| **Vendor risk pack / regulator-defensible PDF** | Track B (Carol-pattern articles) | Tier 1 only | Gates every Track B procurement decision — no call → no deal without this artefact |
| **Sample audit report / sample deliverable PDF** | Cross-track (Sasha + Tom + Carol) | Cross-Track Asset — one-time bank, refreshed annually | Pre-call evaluation artefact for $10M+ protocol Sashas + Track B Toms. No portfolio yet = sample deliverable IS the trust signal |
| **Lead magnet PDF / checklist / decision tree** | Cross-track | Tier 1 only (Tier 2 inherits via cluster — see note below) | Drives the only direct per-article email capture. **Tier 2 articles route to the cluster's Tier 1 hub lead magnet via in-article cross-link CTA** — no per-Tier-2 production. **Tier 3 has no email capture path by design** (amplify-only). Newsletter sign-up CTA on every article tier is a separate broad-capture channel |

### A — High-Leverage (disproportionate impact; do early)

These compound over time and create asymmetric returns. Highest ROI per hour invested.

| Format | Track | Article Tiers | Why high-leverage |
|---|---|---|---|
| **Original research / data report** (annual flagship — 1 per year) | Cross-track | Cross-Track Asset — standalone, not per-article | **AI search engines (ChatGPT/Perplexity/Claude) cite original data verbatim.** Earns 12+ months of citation leverage. Highest single-asset leverage you can produce. Anchors the AEO/GEO work in [[InnBlockchain - Content AEO GEO Prompts]] |
| **Persona-specific LinkedIn variants** (Sam / Tom / Carol from one cross-pillar article) | Track B (cross-pillar only: C1, T4-N, P5-DORA-X, P5-eIDAS-X) | Tier 1 only | Three posts from one article reaches all three Track B personas from a single source. **Subject to LinkedIn output cap + spacing rule** — see Track B section |
| **LinkedIn long-form article** (native, not link-out) | Track B | Tier 1 only | Native LinkedIn long-form outperforms link-out posts ~3× for B2B reach. Free format |
| **LinkedIn RWA Felix variant** from Track A 📎-tagged plain-language articles | Track A → secondary LinkedIn audience (RWA Felix) | Tier 1 + 2 Track A 📎-tagged only | Asset-class community framing for RWA Felix on LinkedIn (PropTech, RWA Summit, real estate investment communities). Cross-ICP — Track A source article finds its asset-owner buyers on a Track B surface |
| **LinkedIn Tom variant** from Track A technical articles | Track A → secondary LinkedIn audience (Tom) | Tier 1 Track A technical only | Cross-ICP re-engage. Single source article gets two surfaces (X for Felix + LinkedIn for Tom). ~30 min reframe (vendor-evaluation / risk-assessment angle, NOT copy-paste of X thread) |
| **GitHub repo / open-source templates** | Track A | Tier 1 technical only | Sasha trust artefact + Tom due-diligence artefact (cross-ICP). One-time investment, compounds via search + GitHub discovery |
| **Solodit profile contribution** | Track A | Tier 1 audit / security articles only | Attribution proxy for Sasha — strategy doc already tracks Solodit referral as a Sasha-trust metric |
| **Own email newsletter** (Substack or Beehiiv) | Cross-track | Featured slot for Tier 1; brief mention for Tier 2; roundup mention for Tier 3 | Platform-independent owned audience. Compounds over 18–24 months. Insurance against LinkedIn/X algorithm risk |

### B — Standard (capacity-allowing; valuable but not urgent)

Real ROI; ship after S + A are operational and stable.

| Format | Track | Article Tiers | Notes |
|---|---|---|---|
| **Standalone infographic** (single image, evergreen, cross-platform) | Cross-track | Tier 1 hub articles only (architecture diagrams, regulatory maps, comparison tables) | ~3 hr production. Distinct from carousel — infographic is one image, evergreen, cross-shareable |
| **Whitepaper / ebook** (3–5 hub articles bundled, designed, gated) | Track B primary | Semi-annual hub bundling | Better Carol/Sam conversion than checklists. Procurement-grade gated asset |
| **Mirror.xyz cross-post** (crypto-native long-form syndication) | Track A | Tier 1 + 2 technical | ~15 min cross-post. Felix/Sasha read Mirror.xyz |
| **Hacker News (Show HN / Ask HN)** | Track A | Tier 1 technical only | Free, low effort. Front-page hit = months of leverage. Also a Tom discovery channel |
| **LinkedIn native video** (60–90 sec) | Track B | Tier 1 hub articles only (cost-gated; subject to LinkedIn output cap — see Track B section) | LinkedIn algorithm favors native video. Higher production cost than carousel but justified for hubs |
| **LinkedIn quote graphic** (single-image) | Cross-track | Tier 2 + 3 only (**not used as Tier 1 supplement** — see Track B section LinkedIn output cap) | ~10 min. **Tier 3 Track B**: produced INSTEAD of the carousel (carousel forbidden at Tier 3). **Tier 2 Track B**: produced ALONGSIDE the carousel as a second LinkedIn post (subject to ≥48 hr spacing per LinkedIn output cap) |
| **Telegram dev-group share** | Track A | Tier 1 + 2 technical | Wed afternoon per Editorial Calendar. Already in production rhythm |
| **Money20-20 / Sibos / Finextra deck-slide** (banked per topic) | Track B | Tier 1 hub + cross-pillar | One slide per article, banked. Don't build full decks per article — assemble at event time |
| **Webinar / panel talking points** (banked content for guest-speaking) | Track B | Tier 1 hub + AI+Blockchain cluster (post-validation) | 30-min talk format banked for **guest-speaking at others' events** (conference panels, podcast appearances). **Distinct from 'Webinar / panel hosting' [C]** — hosting your own webinar requires audience + funnel infrastructure (Deferred to Phase 2) |
| **Email nurture excerpt** (LinkedIn ABM follow-up) | Track B | Tier 1 + 2 named-account-tied | 1 message per article, feeds [[InnBlockchain - LinkedIn Outreach Strategy]] cadence |

### C — Deferred (Phase 2 queue; ship only when trigger fires)

Don't produce in Phase 1. Each has a specific trigger condition to revisit.

| Format | Trigger to ship |
|---|---|
| **Customer testimonial video** | First delivered Track B client agrees to filming + screenshot rights |
| **Conference speaking pipeline** (ETHGlobal, DevCon, Money20/20, Sibos) | Portfolio reaches 3+ Track B case studies; quarterly target Phase 2 |
| **Guest blog program** (Cointelegraph, The Block, Finextra, FinTech Futures, PaymentsCM) | Top 3 Tier 1 articles show organic traction worth amplifying; bi-monthly cadence Phase 2 |
| **Sponsored newsletter placements** (Bankless, Fintech Brainfood, This Week in FinTech) | Flagship research report ships and warrants paid amplification |
| **Podcast appearance bookings** (Fintech Insider, This Week in FinTech, CFO Thought Leader, Bankless, Empire) | Vignesh LinkedIn profile published + 2–3 strong Tier 1 articles in market |
| **AMA / Office Hours** (recurring scheduled X Spaces + LinkedIn Live) | Founder personal brand reaches ~5k LinkedIn followers actively engaging |
| **Long-form YouTube walkthroughs** (10–20 min) | Track A reaches 2nd active vertical beyond A1 RWA; production cost not justified by single-vertical reach |
| **Interactive tool / scope analyzer** (MiCA-vs-MiFID-II analyzer, gas calculator, DORA applicability quiz) | Product roadmap commits engineering capacity (this is product work, not marketing repurposing) |
| **Own podcast launch** | Phase 2 decision Oct 2026; requires 6+ month sustained commitment to compound |
| **Reddit r/defi / r/ethdev syndication** | When Felix reach via X + Telegram + Mirror.xyz plateaus and Reddit becomes incremental |
| **Audiograms / Twitter Spaces clips** | When you start hosting Spaces regularly (not just clipping); 6+ month commitment |
| **Webinar / panel hosting** (own-hosted) | First reference client live + AI+Blockchain validation completes (due 2026-05-31). **Distinct from 'Webinar / panel talking points' [B]** — talking points = banked 30-min content for guest-speaking at others' events (low effort, no funnel); hosting = own webinar with full audience + funnel infrastructure (requires sustained commitment) |

### D — Excluded (explicit skip list; reasons documented for future re-ask)

These are deliberate exclusions, not omissions. If anyone asks "should we do X?" in the future, the answer is below.

| Format | Why excluded |
|---|---|
| **Medium / Substack general blogs** (vs. own newsletter on Substack) | Dead distribution surface for B2B blockchain in 2026; ROI doesn't beat LinkedIn long-form. Own newsletter on Substack is different — owned audience, not Medium-style discovery |
| **Pinterest / Instagram** | Wrong audience for both tracks; Sam/Tom/Carol don't make B2B procurement decisions on Instagram; Felix/Sasha don't research protocols on Pinterest |
| **TikTok / Reels / YouTube Shorts** (vertical-video short-form) | Wrong audience; B2B blockchain ACVs ($20k–$250k) don't earn on vertical-video platforms. Production cost vs. conversion = negative |
| **Stack Overflow** | Q&A format, not a repurposing surface. Useful for SEO-via-answers but that's a different motion (engineering team, not marketing) |
| **Facebook / Meta ads / pages** | Not where any of our personas make B2B decisions |
| **r/CryptoCurrency** (the main sub, not r/defi or r/ethdev) | Too retail-heavy, hostile to vendor posts. r/defi + r/ethdev are deferred (C) — main sub is excluded |
| **Original meme / reaction content production** (Crypto Twitter, company account) | Tone mismatch with audit-grade / regulatory positioning. The trust signal you're building (audit-firm credibility, Carol-grade compliance work) gets undercut by meme-tier content produced from the same account. **Distinct from light cultural participation** — reactions to others' posts, supportive replies in ecosystem threads, and ecosystem-native voice on Twitter are community engagement (not a production format) and are fine. The excluded item is original meme content production from the company account as a planned derivative format |
| **dev.to / HashNode** | Overlap with Mirror.xyz; one crypto-native / engineering long-form syndication surface is enough for Phase 1. Revisit if Mirror.xyz underperforms |
| **Bluesky / Farcaster / Lens** | Bluesky = wrong audience (mostly tech/journalism, not blockchain B2B); Farcaster + Lens = unproven audience size for B2B vendor selection. Re-evaluate annually |
| **Documentary-style case studies** | Over-investment for B2B blockchain ACVs; typical 6–8 figure production cost requires 7+ figure ACVs to justify |
| **Vlogs / behind-the-scenes** | Wrong tone for the buyer profile (regulated FinTech CCOs + protocol founders don't buy from vlogs) |
| **Clubhouse** | Dead platform (2026) |
| **Direct mail / physical letters** | Niche; signal-to-noise too low for the budget required |
| **LinkedIn Live audio events** | Production cost too high for the niche audience size (Carol-specific). LinkedIn carousel + persona variants cover this audience more efficiently |
| **FAQ pages (AEO-optimized standalone)** | Core SEO/AEO work, not a Repurposing Plan derivative. Belongs in [[InnBlockchain - Content AEO GEO Prompts]] (already there — 270 prompts mapped to articles). Leave it where it belongs |
| **Comparison-vs-competitor pages** (vs. Tokeny / Securitize / Fireblocks / Antier) | Legally sensitive — trademark + disparagement risk requires careful framing. Belongs in [[InnBlockchain - Landing Pages Plan]] if at all (as source pages, not derivatives), not Repurposing Plan. **Distinct from technical comparison tables** (e.g., "Solidity vs Rust vs Vyper", feature comparison matrices) which name technologies/standards rather than competitors — those are fine source content and may be amplified via standalone infographics. The excluded item is competitor-naming pages specifically |
| **WhatsApp Status / Telegram channel broadcasts** (vs. Telegram dev-group shares which we DO use) | Wrong tone + frequency for our audiences; dev-group shares are different (community participation, not broadcast) |
| **Hackathon sponsorship + judging** | Community/sales motion, not repurposing. Different budget line; doesn't fit Repurposing Plan scope |
| **Roundtable dinners** | Sales motion, not repurposing. Belongs in [[InnBlockchain - LinkedIn Outreach Strategy]] |
| **Wikipedia contributions** | Credibility play with very long lead time + low ROI for the specific work; revisit in Phase 3 |

### Cross-table: Format × Article Tier triggers

> [!IMPORTANT] Apply Track gate first
> Apply the Track gate (Step 3 of decision shorthand) **before** consulting this cross-table. The cross-table answers INVESTMENT DEPTH per Article Tier; **Master Index track restrictions still apply on top**. Example: LinkedIn long-form is Track B Tier 1 only per Master Index — the cross-table A-row "full production" at Tier 1 means "full production for those A-formats whose track + topic match the article being repurposed."

| Format Priority | Article Tier 1 (full chain) | Article Tier 2 (standard chain) | Article Tier 3 (amplify-only) | Article Tier 0 (gated) |
|---|---|---|---|---|
| **S — Critical** | ✅ All applicable per track | ✅ All applicable per track (no carousel for Tier 2 Track B without spacing — see LinkedIn output cap) | ⚠️ **Track A: X thread only.** **Track B: LinkedIn quote graphic (B-format).** No carousel ever at Tier 3 per Tier 3 amplify-only definition | ❌ No repurposing |
| **A — High-Leverage** | ✅ All applicable per track | ⚠️ **RWA Felix LinkedIn variant** (if Track A 📎-tagged) + newsletter brief mention. LinkedIn long-form, persona variants, Tom variant, GitHub, Solodit are all Tier 1 only per Master Index | ⚠️ Newsletter roundup mention only | ❌ No repurposing |
| **B — Standard** | ✅ All applicable per track + hub restrictions. Telegram, Mirror.xyz, Hacker News are standard Tier 1 technical expectations — not optional. Drop only when capacity genuinely constrained (rare; if recurring, see Replan trigger #3) | ⚠️ LinkedIn quote graphic + email nurture excerpt (named-account-tied) + Telegram + Mirror.xyz (both Track A technical) — other B formats are Tier 1-only or hub-only | ⚠️ LinkedIn quote graphic only | ❌ No repurposing |
| **C — Deferred** | ❌ Phase 1 = no | ❌ Phase 1 = no | ❌ Phase 1 = no | ❌ No repurposing |
| **D — Excluded** | ❌ Never | ❌ Never | ❌ Never | ❌ Never |

**Phase 1 active format count:** 5 Critical + 8 High-Leverage + 9 Standard = **22 formats in active production** (up from 20 in rev 5 after splitting GitHub/Solodit + adding RWA Felix LinkedIn variant), with Article Tier gating the application per article. **12 deferred** (Phase 2 queue), **20 excluded** (explicit skip). **54 formats total classified**.

---

## 🎚️ Repurposing Tiers

| Tier | Trigger | Derivatives | Production Time |
|---|---|---|---|
| **Tier 1 — Full chain** | Score ≥ 9.3 OR hub article OR case study OR cross-pillar early-ship (C1, T4-N, P5-DORA-X, P5-eIDAS-X) | Full per-track asset family (below) + 1 lead magnet (gated PDF / checklist / decision tree) + 1 video or audio asset | ~5 hr (extends Fri block, plus async video/audio); cross-pillar Tier 1 LinkedIn cadence spreads 3 weeks per LinkedIn output cap |
| **Tier 2 — Standard chain** | Score 8.5–9.2 | Per-track asset family without the lead magnet; no video/audio. Lead magnet inherited from cluster's Tier 1 hub via in-article cross-link CTA | ~2 hr |
| **Tier 3 — Amplify only** | Score < 8.5 OR Watch-candidate OR trending/news-cycle piece | Track A: 1 X thread. Track B: 1 LinkedIn quote graphic (no carousel). Plus newsletter roundup mention. No PDF, no video, no carousel | ~30 min |
| **Tier 0 — Gated** | Article references a published LP that returns 404, OR WL article without cleared Reference Build Gate, OR AI+Blockchain cluster pre-validation | **No repurposing.** Don't amplify a piece whose destination doesn't convert. Activates when gate clears — see triggers below | 0 hr |

> [!IMPORTANT] Tier upgrade + Tier 0 activation triggers
>
> **Tier 2 → Tier 1 promotion** (mid-life): (a) ≥2 booked discovery calls attributed within 30 days, OR (b) ranks page-1 for primary keyword, OR (c) a Sam/Carol-pattern reader shares it externally. Signal: "this one earned the lead magnet."
>
> **Tier 3 → Tier 2 promotion** (mid-life): (a) inbound traffic ≥3× organic baseline within 60 days, OR (b) page-1 rank on long-tail query, OR (c) Watch-candidate suddenly attracts inbound at the 90-day review. Signal: "this one earned the per-track asset family chain."
>
> **Tier 0 → active activation** (when gate clears): destination LP publishes, WL Reference Build Gate clears, or AI+Blockchain validation completes (due 2026-05-31 — 4 days from this rev). Article promotes to its appropriate tier per original score; derivative backfill chain runs from gate-clear date forward at standard tier depth.
>
> **Demotion** (rare): a Tier 1 article underperforming after 90 days (zero booked calls, organic traffic flat, no promotion trigger fired) is reviewed in the Monthly Repurposing Review — decision: continue Tier 1, downgrade to Tier 2 (stop producing new Tier-1-only formats; existing assets remain), or kill (per Watch-candidate 90-day kill rule from strategy doc). Demotion is rare because Tier 1 is reserved for hub / case study / cross-pillar / score≥9.3 articles that have structural reasons to be Tier 1.

---

## 📡 Per-Track Asset Families

### Track A — Crypto Native (Founding Felix, RWA Felix, Sasha, Paulo)

**Where Track A buyers actually read:** X/Crypto Twitter, Telegram dev groups, GitHub, Rekt News, Solodit, ETHGlobal Discord, Reddit r/defi / r/ethdev. **LinkedIn serves two secondary audiences for Track A content:** (a) **RWA Felix** for plain-language asset-class articles (asset owners live on LinkedIn, not Crypto Twitter); (b) **Track B Tom** for reframed technical articles (FinTech CTOs research blockchain vendors + peer-learn security on LinkedIn, not on X). Felix himself is on LinkedIn but uses it for fundraising/hiring/press — not for technical learning — so Felix-coded Solidity threads belong on X, not LinkedIn.

| Asset | When to produce | Notes |
|---|---|---|
| **X thread (8–14 posts)** [S] | Every Tier 1 + Tier 2 + Tier 3 Track A article (Tier 3 = one X thread of 8–14 posts, no other derivatives) | Lead with the strongest finding; cap with motion-matched CTA. **Mandatory for post-mortem articles** (Rekt-News-adjacent audience). Post 09:00 / 14:00 / 19:00 CET per Editorial Calendar X timing |
| **Lead magnet (gated PDF / checklist)** [S] | Tier 1 only | "Pre-audit 30-day checklist", "RWA tokenization legal-technical interface map", "DEX AMM security review template". Distributes via X bio link + LinkedIn for RWA Felix variants. Tier 2 inherits the cluster's Tier 1 hub lead magnet via in-article cross-link CTA |
| **GitHub repo / open-source templates** [A] | Tier 1 technical-deep-dive only (audit checklists, architecture comparisons, security primers) | Felix/Sasha trust artefacts that live in their tooling, not in their feed. Single highest-leverage Sasha asset. Cross-ICP — Tom uses GitHub for vendor due-diligence too |
| **Solodit profile contribution** [A] | Tier 1 audit / security articles only | Attribution proxy for Sasha — strategy doc already tracks Solodit referral as a Sasha-trust metric |
| **LinkedIn post (RWA Felix variant)** [A] | Every Tier 1 + Tier 2 📎-tagged Track A article (plain-language RWA pieces) | Asset-class community framing (PropTech, RWA Summit, real estate investment communities). Subject to LinkedIn output cap if other LinkedIn output for same article is also active |
| **LinkedIn post (Track B Tom variant)** [A] | **Tier 1 Track A technical articles only** (cost-gated) | Reframe the technical content for FinTech CTO / VP Eng evaluating blockchain vendors — **NOT a copy-paste of the X thread**. Frame as risk/vendor-evaluation angle: *"If your FinTech is evaluating a blockchain vendor, here's the smart contract vulnerability that's killed $2B+ in protocols. What to ask your vendor's audit firm."* ~30 min reframe production. Cross-ICP re-engage pattern: aligns with Content Strategy line 1066 (technical explainers → Tom discovery on LinkedIn). Skip for Tier 2/3 — cost > benefit |
| **Mirror.xyz cross-post** [B] | Tier 1 + Tier 2 Track A technical articles | Felix/Sasha read Mirror.xyz; ~15 min cross-post effort. Preserve canonical URL pointing to innblockchain.com to avoid duplicate-content SEO hit. Crypto-native long-form syndication — distinct from LinkedIn long-form (different audience). **Also applies to Tier 1 WL technical content** per Principle 6 |
| **Hacker News (Show HN / Ask HN)** [B] | Tier 1 technical articles only | Free, low effort to post; front-page hit = months of leverage. Also a Tom discovery channel (FinTech CTOs read HN). Timing matters — post Tue/Wed 09:00 ET (peak HN traffic). No paid promotion possible (HN bans it) — content quality is the only lever |
| **Telegram dev-group share** [B] | Every Tier 1 + Tier 2 technical Track A article | Short paragraph + link, **posted Wed afternoon** (post-Tuesday-article amplification slot per Editorial Calendar). Curate the group list quarterly |
| **LinkedIn quote graphic** (single-image) [B] | Every Tier 2 + Tier 3 📎-tagged Track A article (RWA Felix variants only) | Single-slide pull-quote or stat visual; ~10 min production. Distinct from carousel — quote graphic = one image, carousel = 7–10 slides. Used at Tier 3 where carousel investment isn't justified |

**Track A anti-derivatives (don't produce):** Felix-coded technical posts on LinkedIn (the X thread copy-pasted directly — Felix isn't actively learning on LinkedIn; Tom IS, but he needs a different frame — see Tom variant row above); webinar replays (cycle is 1–3 weeks — no time for webinar funnel); Finextra/Money20-20 republication (wrong audience entirely).

---

### Track B — Regulated FinTech (Sam, Tom, Carol)

**Where Track B buyers actually read:** LinkedIn (primary), Finextra, Sibos / Money20-20 panel decks, FinTech-specific newsletters (Fintech Brainfood, This Week in FinTech), compliance-officer LinkedIn lists for Carol, EU NCA regulator networks for DORA/MiCA-licensed-entity audiences.

| Asset | When to produce | Notes |
|---|---|---|
| **LinkedIn document carousel (7–10 slides, topic-coded Sam/Tom/Carol)** [S] | Every Tier 1 + Tier 2 Track B article (**not Tier 3** — Tier 3 Track B = LinkedIn quote graphic only per Repurposing Tiers definition) | Highest-engagement LinkedIn format for Sam/Tom/Carol. Visual but text-dense. CCO-readable in <90 seconds. **Deployment: organic + sponsored** (paid LinkedIn ads against named-account lists or EU geo filter — promote Tier 1 carousels; organic-only for Tier 2). **Capacity rule: WealthTech (B1) first.** When carousel production capacity is constrained that week, B1 articles take priority over other Track B clusters (matches Q2 2026 primary focus). **Multi-audience posting rule (RWA-themed `[Both]` articles):** if the same `[Both]` article triggers both a Sam-coded carousel (Track B Sam/Tom/Carol) AND an RWA Felix carousel (Track A asset-owner) from one profile, space them **≥24–48 hr apart** + use differentiated hashtag stacks (`#WealthTech #MiFIDII #AssetManagement` vs `#PropTech #RealEstateInvestment #Tokenization`) + use sponsored targeting (Sales Navigator filtered named-accounts vs PropTech/commodity/private-credit audiences) for at least one of the two — sponsored bypasses the algorithm's "what is this account about" segmentation and reduces same-profile dilution risk. Same-day dual posts dilute audience-targeting signals and look scattered in followers' feeds |
| **Vendor risk pack / regulator-defensible PDF** [S] | Tier 1 Carol-pattern articles (C1, B1-#18, P5-DORA-X, P5-eIDAS-X) | Procurement-grade artefact — Carol attaches it to vendor onboarding files. Highest-leverage Carol asset and the only one that survives her review process. **Mandatory compliance reviewer sign-off** (same gate as source article) |
| **Persona-specific LinkedIn post variants** [A] | Tier 1 cross-pillar articles (C1, T4-N, P5-DORA-X, P5-eIDAS-X) | Three posts from one article — one Sam-coded (cost/competitiveness), one Tom-coded (talent/security), one Carol-coded (regulator-defensible). Different angles, same article, same blog destination. **Subject to LinkedIn output cap + spacing rule below** — these 3 variants distribute across 3 weeks, not posted in launch week |
| **LinkedIn long-form article (native)** [A] | Every Tier 1 Track B article | Published as native LinkedIn article (not just a post linking to blog). Re-frames the blog post for LinkedIn's algorithm. ~3× organic reach of link-out posts. Drives LP traffic via in-text CTA |
| **Whitepaper / ebook (3–5 hub articles bundled, designed, gated)** [B] | Semi-annual hub bundling (Tier 1 hubs only) | Better Carol/Sam conversion than checklists — procurement-grade gated asset. Example: bundle B1-#1 hub + B1-#10 STOs + B1-#13 MiFID II/DLT Pilot + #14 MiCA Checklist into "RWA Tokenization Compliance Whitepaper for EU WealthTech." Designed + branded; 20–40 pages |
| **Standalone infographic** [B] | Tier 1 hub articles only (architecture diagrams, regulatory maps, comparison tables) | ~3 hr production. Single image, evergreen, cross-platform shareable (LinkedIn + X + embedded in blog). Distinct from carousel — infographic is one image, carousel is 7–10 slides. **Also applies to Tier 1 WL hub articles** per Principle 6 |
| **LinkedIn native video (60–90 sec)** [B] | Tier 1 hub articles only (cost-gated) | LinkedIn algorithm favors native video. Vignesh on-camera or animated explainer. Higher production cost than carousel (~2 hr per) but justified for hubs. **Subject to LinkedIn output cap** — for cross-pillar Tier 1, video ships in week 2-3 of the 3-week LinkedIn cadence, not launch week |
| **LinkedIn quote graphic (single-image)** [B] | Every Tier 2 + Tier 3 Track B article | Single-slide pull-quote or stat visual; ~10 min production. Distinct from carousel — quote graphic = one image, carousel = 7–10 slides. Tier 3 Track B = quote graphic only (carousel forbidden at Tier 3). **Not used as Tier 1 supplement** — Tier 1 LinkedIn output is consumed by carousel + long-form + persona variants + video; adding quote graphics breaches the LinkedIn output cap |
| **Money20-20 / Sibos / Finextra deck-slide** [B] | Tier 1 B1 hub articles + cross-pillar articles | One slide per article, banked for event use. Don't build full decks per article — bank slides, assemble decks per event |
| **Webinar / panel talking points** [B] | Tier 1 hub articles + AI+Blockchain cluster (post-validation) | 30-min talk format banked for **guest-speaking at others' events** (conference panels, podcast appearances, association invitations). Recording (when available) becomes additional asset (LinkedIn native video, gated replay). **Distinct from 'Webinar / panel hosting' [C]** — hosting your own webinar requires audience + funnel infrastructure (Deferred to Phase 2) |
| **Email nurture sequence excerpt (LinkedIn ABM follow-up)** [B] | Tier 1 + Tier 2 Track B articles tied to named-account outreach | 1 message per article, dropped into the existing ABM cadence — referenced by [[InnBlockchain - LinkedIn Outreach Strategy]] |

**Track B anti-derivatives (don't produce):** X threads (Sam/Tom/Carol don't live on X for B2B procurement decisions), Telegram syndication (wrong channel), Reddit posts, GitHub Gists (Tom may read code on GitHub for due diligence but doesn't make procurement decisions from a Gist).

### LinkedIn output cap and spacing rules (single profile)

Track B Tier 1 cross-pillar articles can generate up to **6 LinkedIn posts from one company profile** (1 carousel + 1 long-form + 3 persona variants + 1 native video). Posting all 6 within a launch week causes feed cannibalization, dilutes the LinkedIn algorithm's audience-targeting signal, and looks scattered in followers' feeds — exactly the failure mode the multi-audience posting rule warns against, applied to all LinkedIn output not just dual carousels.

**Rules:**

- **≥48 hr spacing** between any two LinkedIn posts about the same article from the company profile (extends the existing dual-carousel ≥24–48 hr rule to ALL Tier 1 LinkedIn cluster combinations, not only RWA-themed `[Both]` carousels).
- **Cross-pillar Tier 1 LinkedIn cadence (3 weeks):**
  - **Launch week (Mon–Fri):** carousel (S) + LinkedIn long-form (A) + persona variant #1 (A). 3 posts.
  - **Week 2:** persona variant #2 (A) + optional LinkedIn native video (B) if Tier 1 hub. 1–2 posts.
  - **Week 3:** persona variant #3 (A). 1 post.
- **Non-cross-pillar Tier 1 Track B articles** (no persona variants): launch week = carousel (S) + LinkedIn long-form (A); week 2 = native video (B) if Tier 1 hub. Max 3 posts over 2 weeks per article.
- **Sponsored deployment counts toward the cap** (a sponsored carousel + organic long-form on the same day = 2 posts; subject to ≥48 hr spacing unless sponsored is in a different geo/audience segment from organic).
- **Multi-audience posting rule for RWA-themed `[Both]` dual carousels** (from carousel row above) still applies on top of these rules — that rule governs spacing of two RWA-themed carousels from one profile; this LinkedIn output cap governs all LinkedIn output for an article.
- **Cross-pillar Tier 1 publishes capped at 1/week** in the Editorial Calendar to avoid breaching spacing across two articles. If two cross-pillar Tier 1 articles publish in the same week, one's LinkedIn cadence shifts to week 2 (only the carousel + long-form ship in launch week; persona variants begin week 2).
- **Tier 2 Track B aggregate (multiple articles, same week):** Tier 2 Track B articles produce **2 LinkedIn posts each** (carousel S + quote graphic B). When 2 Tier 2 Track B articles publish in the same week (Tue + Thu), aggregate = 4 LinkedIn posts that week from one profile, **before** any cross-pillar Tier 1 cadence layers on top. Rule: if 2 Tier 2 Track B articles publish same week + a cross-pillar Tier 1 launch week is also active = >7 posts/week. **Defer one Tier 2 article's quote graphic to the following week** to stay under 7 posts/week aggregate. Carousel ships in launch week; quote graphic shifts.
- **Steady-state aggregate target:** 4–7 LinkedIn posts/week from one profile. Above 7 = feed reads as content firehose; cap enforces thoughtful-publisher feel.

**Editorial Calendar interaction:** Tue + Thu publish slots + per-article LinkedIn cadence = 4–7 distinct LinkedIn post events per week from one profile when production is at steady state. Cap enforces that profile reads as a thoughtful publisher rather than a content firehose.

---

### `[Both]` Articles — Parallel Chains

> [!NOTE] What "parallel chains" means
> Two separate derivative sequences (one per track) produced from a single `[Both]` source article and run **concurrently** (not sequentially). Each chain has its own platforms, formats, and audience framing. See Operating Principle 5 above for full definition + concrete example.

`[Both]` articles in the inventory:
*Asset Tokenization 101 · MiCA Explained · Reentrancy / Flash Loan / Oracle / Access Control / Integer Overflow security primers · Embedded Wallets Compared · Passkey Auth · Smart Contract 101 · Solidity vs Rust vs Vyper · When Smart Contracts Go Wrong · P5-eIDAS-X*

**Production rule:** Two derivative chains per article, not one — but parallel = **platform-split**, not platform-doubled. Each chain runs through its own track's asset family above. Source article carries the split CTA footer; derivatives never combine CTAs.

**Track B carousel framing depends on topic** — Track B has three personas (Sam business / Tom technical / Carol compliance), and the right LinkedIn carousel framing differs per `[Both]` article type:

- **Technical `[Both]` articles** (security primers — Reentrancy / Flash Loan / Oracle / Access Control / Integer Overflow / Smart Contract 101 / Solidity vs Rust vs Vyper / When Smart Contracts Go Wrong / Embedded Wallets / Passkey Auth):
    - Track A audience = **Felix (Crypto Twitter)**, not RWA Felix → X thread
    - Track B audience = **Tom (LinkedIn)**, NOT Sam — Sam doesn't care about reentrancy mechanics; Tom does (vendor evaluation / security risk assessment) → **Tom-coded LinkedIn carousel** ("Vendor risk angle: 5 smart contract vulnerabilities your blockchain vendor's audit firm must have caught")
    - Platforms don't overlap → no same-profile LinkedIn carousel doubling
- **RWA / business-buyer `[Both]` articles** (Asset Tokenization 101, MiCA Explained):
    - Track A audience = **RWA Felix (LinkedIn)** → RWA Felix–coded LinkedIn carousel (asset-class framing)
    - Track B audience = **Sam (LinkedIn)** — business decision-maker for tokenized-securities strategy → Sam-coded LinkedIn carousel (margin/ROI/competitive framing)
    - Both audiences on LinkedIn → **two LinkedIn carousels from one profile**. Apply multi-audience posting rule from carousel row: ≥24–48 hr spacing + differentiated hashtag/targeting stacks + sponsored on at least one
- **Compliance-led `[Both]` articles** (P5-eIDAS-X):
    - Track A audience = **RWA Felix (LinkedIn)** for investor-KYC framing
    - Track B audience = **Carol + Tom (LinkedIn)** — Carol owns vendor-risk-pack outcome; Tom owns implementation → Carol-coded carousel OR split into separate Carol + Tom carousels for Tier 1 articles. Sam is NOT the primary Track B persona here (he's not the relying-party decision-maker)
    - Multi-audience posting rule applies same way

**Rule of thumb:** Look at which Track B persona the topic *naturally* serves before defaulting to Sam-coded framing. Technical → Tom. Business strategy → Sam. Compliance / vendor risk → Carol. Sam-coded LinkedIn carousels make sense for business-buyer topics only — defaulting Sam-coded across all Track B carousels is a framing mistake.

> [!NOTE] Classification override (Embedded Wallets / Passkey Auth)
> Both currently default to the **technical `[Both]`** classification → Tom-coded carousel. But these topics sit on the boundary: Passkey Auth specifically intersects eIDAS 2.0 EUDI Wallet compliance (Carol territory); Embedded Wallets Compared can be framed as business UX decision (Sam) or technical comparison (Tom).
>
> **Rule:** if the source article frames primarily as compliance (eIDAS, regulatory), override to Carol-coded; if it frames primarily as business UX / vendor decision, override to Sam-coded. Default is technical → Tom-coded; override on framing of the source article. Classification override gets documented in the article's repurposing checklist.

| Decision | Rule |
|---|---|
| Which track gets which derivative? | Both. Run Track A chain AND Track B chain in parallel — but the platforms differ depending on whether Track A audience is Felix (X) or RWA Felix (LinkedIn) |
| Can we use one LinkedIn carousel for both? | No (when both audiences are on LinkedIn) — Sam reads "regulatory cost recovery", RWA Felix reads "first asset issuance timeline". Visuals overlap; framings don't. Two carousels, spaced per multi-audience posting rule |
| Can the same X thread serve both? | **Depends on `[Both]` article type.** For **technical `[Both]`** (security primers, Smart Contract 101, Solidity vs Rust, etc.): X thread IS produced for Track A (Felix on Crypto Twitter) — it serves Track A only; Track B (Tom) gets the LinkedIn carousel instead, no X thread needed. For **RWA / business-buyer `[Both]`** (Asset Tokenization 101, MiCA Explained): **no X thread at all** because Track A audience is RWA Felix who lives on LinkedIn, not Crypto Twitter — both Track A and Track B chains run as LinkedIn carousels (with multi-audience posting rule applied) |
| Lead magnet for `[Both]` Tier 1? | Two distinct lead magnets, one per audience. P5-eIDAS-X = (a) wallet-auth integration checklist for B4/B5/B7 + (b) investor-KYC relying-party map for A1/B1 |

---

### Cross-Track Assets (Not Per-Article — Standalone Production)

These don't get produced per article. They're standalone flagship assets that benefit the entire content program by serving multiple tracks + AI search + owned audience. Exempt from Operating Principle 1 (no source article required).

| Asset | Cadence | Notes |
|---|---|---|
| **Sample audit report / sample deliverable PDF** [S] | One-time bank, refreshed annually | Pre-call evaluation artefact. $10M+ protocol Sashas + Track B Toms + Track B Carols all want to see one before booking. **Phase 1 starts with no portfolio** (synthetic reference report = the trust signal); **replan trigger fires when first delivered engagement allows redacted real audit** — likely mid-to-late Phase 1 if WL-1 or B1 client signs. Once available, redacted real audit supersedes synthetic reference report; synthetic version stays archived but active deliverable shifts to real-engagement-based. **Production:** (preferred) redacted real audit report from a delivered engagement; (acceptable while no portfolio exists) synthetic reference report drawn from publicly available exploit research and InnBlockchain methodology. **If synthetic, disclose explicitly in the asset itself** — front-matter callout: "Sample reference report — methodology and findings drawn from publicly available exploit research; no client engagement." Synthetic-without-disclosure undercuts Carol-defensibility and creates reputational risk. **Compliance reviewer sign-off required** regardless of source. **Refresh annually** to reflect current methodology + latest exploit patterns; quarterly status check for emergent updates (new high-profile exploit categories warrant interim refresh) |
| **Original research / data report** [A] | Annual flagship (1 per year) | E.g., "State of Smart Contract Security 2026", "EU RWA Tokenization Vendor Benchmark", "FinTech Blockchain Audit Cost Survey." **Highest single-asset leverage** — AI search engines (ChatGPT/Perplexity/Claude) cite original data verbatim. Earns 12+ months of citation. Production: 4–8 weeks (data collection + analysis + design). Distributes via gated PDF + LinkedIn campaign + sponsored newsletter + press release. Anchors the AEO/GEO work already in [[InnBlockchain - Content AEO GEO Prompts]]. **Sprint protocol applies** — see Production Cadence |
| **Own email newsletter** (Substack or Beehiiv) [A] | Bi-weekly cadence | Platform-independent owned audience. Compounds over 18–24 months. Insurance against LinkedIn/X algorithm risk. Featured slot for every Tier 1 article; brief mention for Tier 2; Tier 3 in roundup. Format: 1 deep-dive (Tier 1 article repurpose) + 3-5 short links + 1 community pick. Cross-track audience — segment by interest tags if list size justifies (>2k subscribers) |

### Email capture paths (across the plan)

| Capture path | Trigger | Tier coverage |
|---|---|---|
| **Per-article lead magnet** (primary) | Tier 1 only | Tier 1 articles |
| **Cluster Tier 1 hub lead magnet** (secondary) | Tier 2 article inherits via in-article cross-link CTA to its cluster's Tier 1 hub | Tier 2 articles |
| **Sitewide newsletter sign-up CTA** (tertiary, broad) | Footer + in-article CTA on every article tier | All Tier 1 + 2 + 3 articles |
| **Cross-Track Asset gated downloads** (independent) | Sample audit report download form, research report download form | Sashas + Toms + Carols + general visitors regardless of article tier |

---

## 🔄 Adjacent Motions (Longer-Lead, Owned by Dedicated Resource)

These run **parallel to the weekly batch**, not inside it. Each has 4–12+ week lead times and benefits from sustained relationship-building. Dedicated repurposing resource owns the calendar; the cadence is monthly or quarterly post-activation, not weekly.

| Motion | Phase 1 status & activation trigger | Cadence once active | Notes |
|---|---|---|---|
| **Guest blog program** (Track A: Cointelegraph, The Block, Decrypt · Track B: Finextra, FinTech Futures, PaymentsCM, The Banker) | **Deferred (C) in Phase 1.** Activation trigger: top-3 Tier 1 articles show organic traction worth amplifying | Bi-monthly (1 per track every 2 months) Phase 1 post-trigger; monthly Phase 2 | 4–8 week pitch-to-publish lead time. Editorial relationships compound over years — start pitching even if first 3–5 placements take 6 months to land. Use as third-party validation for sales conversations, not just SEO backlinks |
| **Podcast appearance bookings** (Track A: Bankless, Empire, The Crypto Watch · Track B: Fintech Insider, This Week in FinTech, CFO Thought Leader, Finovate) | **Deferred (C) in Phase 1.** Activation trigger: Vignesh LinkedIn profile published + 2–3 strong Tier 1 articles in market | Monthly (1 appearance per month, alternating tracks) post-trigger | 6–12 week booking lead time. Highest-trust surface (host endorsement = strong signal). Repurpose appearance → audiogram clips + transcript blog post + LinkedIn carousel + email newsletter feature |
| **Conference speaking pipeline** (Track A: ETHGlobal, DevCon, EthCC · Track B: Money20/20 Europe, Sibos Europe, Finovate Europe) | **Deferred (C) in Phase 1.** Activation trigger: portfolio reaches 3+ Track B case studies (Phase 2) | Quarterly (1 speaking slot per quarter) post-trigger | 3–6 month CFP-to-stage lead time. Speaking slot = days of high-density networking + recorded video asset + Track B credibility signal. Pitch CFPs 6 months ahead |
| **Sponsored newsletter placements** (Bankless · Fintech Brainfood · This Week in FinTech · TLDR Newsletter · Web3 Wednesday) | **Deferred (C) in Phase 1.** Activation trigger: flagship research report ships and warrants paid amplification | As-needed (paid placement) post-trigger | Paid placement; budget separately. Use for major launches (research report drop, whitepaper, lead magnet promotion) — not for routine articles |
| **AMA / Office Hours** (recurring scheduled X Spaces + LinkedIn Live) | **Deferred (C) in Phase 1.** Activation trigger: founder personal brand reaches ~5k LinkedIn followers actively engaging | Monthly recurring slot post-trigger | Compounding personal brand asset. Recurring slot = repeat audience. Run for 6+ months before judging ROI |
| **Press releases** (funding rounds, major case study launches, research report drops) | **Active in Phase 1** when triggered by major news. Not tier-gated by article | Trigger-based (only for major news) | PR motion, not content repurposing per se. Coordinate with PR firm or DIY via Notified / Cision / PRNewswire. Use sparingly — press release frequency dilutes signal |
| **Analyst briefings** (Gartner, Forrester, IDC for Track B enterprise) | **Deferred (C — Phase 3 consideration).** Activation trigger: Track B enterprise ACVs ($150k+) become repeatable | Quarterly post-trigger | Long-lead institutional credibility play. Not relevant to Phase 1 ACVs ($20k–$75k) |
| **Awards submissions** (FinTech Awards Europe, Crypto Awards, Web3 Awards) | **Active in Phase 1** once portfolio reaches 5+ case studies. Standalone — not tier-gated | Annual submission windows (typically Q1 + Q3) | Earned-media; submission fee + nomination effort |

---

## 🚦 Tier × Track × Motion Matrix (decision shorthand)

When the dedicated resource opens an article in the daily batch, run this in order:

1. **Article Tier gate** — look up score in [[InnBlockchain - Content Strategy]]. Apply Tier 1 / 2 / 3 / 0 investment depth.
2. **Format Priority gate** — apply Critical (S) formats first; High-Leverage (A) next if Tier 1; Standard (B) if Tier 1 + bandwidth; never Deferred (C) or Excluded (D). Cross-reference Master Format Classification table.
3. **Track gate** —
   - `[CN]` → Track A asset family.
   - `[FT]` → Track B asset family.
   - `[Both]` → parallel chains; topic-based persona map for Track B carousel: **technical** → Track A Felix on X + Track B Tom-coded carousel; **RWA/business** → Track A RWA Felix on LinkedIn + Track B Sam-coded carousel (dual carousels, multi-audience spacing rule applies); **compliance** → Track A RWA Felix on LinkedIn + Track B Carol-coded primary + Tom-coded secondary.
   - `[WL]` → SEO-amplifying surfaces only per Principle 6 (technical comparison tables, standalone infographics for hubs, Mirror.xyz for technical content); WL-1 only gets LinkedIn (RWA Felix variant); no X/Telegram for any WL article.
4. **Motion gate** — preserve `[Audit]` / `[Dev]` / `[White-Label]` / `[Audit + Dev]` CTA across every derivative. WL articles skip LinkedIn (except WL-1 which gets RWA Felix amplification only).
5. **Persona gate (cross-pillar only)** — C1 → Carol-coded. T4-N → Sam/Tom-coded. P5-DORA-X → compliance-officer + EU NCA distribution. P5-eIDAS-X → split, with Dec 31 2026 deadline urgency in every variant.
6. **LP gate** — Tier 0 if destination LP returns 404 or WL Reference Build Gate not cleared. **No repurposing for a piece that can't convert.** When gate clears, see Tier 0 → active activation trigger above.

---

## 🛠️ Production Cadence (Dedicated Resource Model)

A **dedicated repurposing resource** owns this calendar. The cadence runs on five overlapping bands: daily / weekly / monthly / quarterly / reactive. The Editorial Calendar's Friday batch slot is retained for **measurement + planning + Tier 1 lead-magnet finalisation only** — derivative production happens throughout the week.

| Band | Focus | Time allocation |
|---|---|---|
| **Daily (Mon–Thu)** | Current week's published articles. Carousel + X thread + Telegram + LinkedIn variants for Tue + Thu publishes (subject to LinkedIn output cap + 3-week cross-pillar Tier 1 cadence). Mirror.xyz + Hacker News + email newsletter slot for Tier 1 | ~3–5 hr/day depending on Tier 1 count + article complexity |
| **Friday** | Measure prior week's metrics; plan next week's derivative load; finalize Tier 1 lead magnets started earlier in week | ~3–4 hr |
| **Weekly batch (within Mon–Thu)** | Per-article derivative chain (S + A formats). Tier 1 = full chain spread across 3 weeks for cross-pillar; Tier 2 = subset; Tier 3 = amplify-only | Folded into daily allocation |
| **Monthly** | Standalone infographic (1–2/month for Tier 1 hubs); email newsletter assembly (bi-weekly = 2 issues/month); webinar / panel talking points production for upcoming guest-speaking slots | ~2–3 days/month carved out |
| **Quarterly** | Slide deck refresh for upcoming events; **sample audit report annual refresh** (anchor tied to first-delivered-engagement timing, NOT calendar — explicitly separated from research-report sprint window to avoid resource stacking; if no engagement yet, anchor late Q4 so as not to collide with typical Q1 sprint); interim quarterly status checks for emergent updates — new high-profile exploit categories warrant interim refresh; deferred-format reassessment; format-priority reclassification (S/A/B/C/D drift); guest blog pitch campaign (post-activation) | ~5–7 days/quarter |
| **Reactive** | Exploit post-mortem amplification (48-hour rapid response — pause normal queue when triggered); regulatory news cycle (e.g., MiCA Article 17 ruling, AMLA appointment) | Variable; cap at 2 events/month |

**Adjacent motion sub-cadence** (also owned by dedicated resource, post-activation):

| Adjacent motion | Cadence within resource calendar |
|---|---|
| Guest blog pitches (post-activation) | Bi-weekly outreach session (~3 hr); 1 pitch per track per month |
| Podcast booking outreach (post-activation) | Bi-weekly (~2 hr); 1 booking per month target |
| Conference CFP submissions (post-activation) | Quarterly (~1 day/quarter) |
| Sponsored newsletter placement coordination | As-needed (~half day per placement) |

### Research-report sprint protocol (annual flagship — 4–8 weeks)

- **Pre-block in Editorial Calendar 6 weeks ahead.** Sprint typically Q1 or Q3 (when industry conference + tax-cycle attention is highest for research releases).
- **During sprint:** dedicated resource pulls off weekly batch. Derivative production drops to **Tier 3 amplify-only** for all articles published in the window (1 LinkedIn post OR 1 X thread per article; no carousel, no per-track chain, no Tier 1 lead magnets started).
- **Tier 1 articles publishing in the sprint window** either pause publishing or downgrade to Tier 3 depth for the duration. **Document downgrades in Editorial Calendar** with note "Repurpose deferred — research sprint window."
- **Sprint exit week:** resource returns to normal cadence; deferred Tier 1 articles get their full chain produced in catchup mode (~7–10 days of catchup at 50 hr/week).
- This trade-off (4–16 Tier 1 articles bleed during sprint) is acceptable because the research report itself is the highest-leverage single asset for AI search citation + earned media.

### Staffing realism

**Total resource load: ~32–40 hr/week** during normal cadence; ~50 hr/week during research-report sprint, sprint exit catchup, or reactive event response.

Single dedicated resource is feasible for cross-pillar Tier 1 ≤1/week + standard Tier 2 + 3 chains. **Add designer/producer support when:**
- (a) Cross-pillar Tier 1 lands in the same week as monthly infographic production, OR
- (b) Two Tier 1 articles publish in one week (LinkedIn output cap forces shifted cadence + extra production complexity), OR
- (c) Reactive event triggers concurrent with planned monthly/quarterly work.

Edge cases (a)/(b)/(c) occur roughly **1 week/month minimum** at steady state. Designer/producer support is **not optional for production months** — budget it in from rev 6 onward.

---

## ⚠️ Anti-Patterns (do not do these)

- **Posting technical Track A articles to LinkedIn in Felix-coded framing** (Solidity threads, raw code snippets, Crypto-Twitter voice). Felix is on LinkedIn but uses it for fundraising/hiring/press, not technical learning. **DO produce a Tom-coded LinkedIn variant** for Tier 1 Track A technical articles — reframe as vendor-evaluation / risk-assessment angle for FinTech CTOs. RWA Felix gets a separate plain-language asset-class framing. Three different LinkedIn frames can come from one Track A technical source: X thread (Felix on Crypto Twitter) + Tom variant (FinTech CTO on LinkedIn) + RWA Felix variant (if topic intersects RWA).
- **Posting Track B regulatory articles to X/Crypto Twitter.** Sam/Carol aren't there. The crypto-Twitter discourse around MiCA/DORA is hostile to "regulated FinTech" framing — wrong audience and wrong tone.
- **One universal carousel/thread for `[Both]` articles.** Always two parallel chains. Blended derivatives mute both audiences.
- **Mixing CTAs across derivatives.** If the source article CTA is `[Audit]`, every derivative closes with the audit CTA. Don't drift to `[White-Label]` in the LinkedIn carousel because it "sells better."
- **Repurposing a Tier 0 article.** If the LP is 404 or the WL Reference Build Gate isn't cleared, the article was published as a Tier 3 amplify-only or shouldn't have published at all. Don't compound the gate breach with downstream derivatives.
- **Building a webinar funnel for Track A.** Cycle is 1–3 weeks; webinar funnels need 6–8 weeks to pay back. Track B webinar/panel format only.
- **Repurposing a Watch-candidate article past the 90-day review without an explicit kill OR promote decision.** B1-#4, B1-#11, A2 Solana Raydium — at the 90-day review: (a) zero inbound = kill per strategy doc, repurposing stops immediately; (b) inbound emerges = promote per Tier 3 → Tier 2 trigger (c), repurposing escalates to Tier 2 per-track asset family chain. The anti-pattern is **continuing Tier 3 repurposing past the 90-day review without making either decision** — that's drift, not investment.
- **Producing a Carol-pattern asset without compliance review.** Vendor risk packs / regulator-defensible PDFs get the same compliance reviewer sign-off as the source article. A regulator-grade artefact derived without review is the highest-risk failure mode.
- **Format-first thinking.** "We have this new format, let's find articles to fit it." Wrong direction. The article remains the source-of-truth; format follows. If a format doesn't have a clear S/A/B classification triggered by article tier + persona fit, don't produce it. Adding formats outside the classification = Excluded (D) tier by definition.
- **Adding new formats without a quarterly classification review.** If someone proposes a new derivative format (e.g., "what about TikTok / Threads / Lens?"), check the Excluded (D) list first — most have already been decided. If genuinely new, add it to the quarterly format-priority review queue (not to production this month). Decisions go in the master Format Classification table.
- **Skipping the sample audit report production.** Phase 1 has no portfolio. Sample audit report IS the trust artefact every $10M+ Sasha + Track B Tom + Carol asks for pre-call. Deprioritizing it means qualified buyers don't book the call. Single highest-leverage Phase 1 production item after the source articles themselves.
- **Producing memes / vlogs / behind-scenes content as a planned format from the company account.** The audit-grade + regulatory + Carol-defensibility positioning you're building is the differentiation. Original meme-tier or vlog-style content produced from the same account undercuts that trust signal. Light cultural participation (reactions to others' posts, ecosystem replies, supportive comments) is different and fine — see Excluded (D) memes row for the distinction.
- **Breaching the LinkedIn output cap.** More than 3 LinkedIn posts about the same article from the company profile in a 7-day window, or <48 hr spacing between same-article posts. Cross-pillar Tier 1 articles distribute over 3 weeks per the LinkedIn cadence rules in Track B section. Burning the full 6-post set in launch week dilutes algorithm signal and trains followers to scroll past — exactly what the multi-audience posting rule warns against, applied to all LinkedIn output not just dual carousels.
- **Producing a Tier 1 chain for a Watch-candidate article.** Watch-candidates (e.g., B1-#4 *Utility NFTs in FinTech*, B1-#11 *Tokenized US Treasuries as DeFi Collateral*) ship as Tier 3 amplify-only by design — the 90-day kill rule applies. Producing Tier 1 derivatives upfront wastes investment on articles that may be killed; if traction emerges, promote Tier 3 → Tier 2 → Tier 1 via the upgrade triggers rather than pre-committing.
- **Producing derivatives without verifying the source article CTA is correct.** A misframed source article (e.g., `[Audit]`-tagged article that should have been `[Dev]`) propagates the wrong CTA across every derivative. Verify the source article's sales motion tag against the article's actual content before producing any derivative — CTA misalignment is structural and can't be fixed downstream without recalling derivatives.

---

## 📊 Repurposing-Specific Metrics

Extends (does not replace) [[InnBlockchain - Editorial Calendar]] Metrics Dashboard. Track per derivative, not just per source article:

| Metric | Target | Source |
|---|---|---|
| **Derivative → LP click-through** (per format) | LinkedIn carousel ≥ 2× LinkedIn text post; X thread ≥ 5× single tweet; LinkedIn long-form ≥ 3× link-out post; Mirror.xyz post ≥ 0.5× X thread (lower volume, higher-intent) | UTM by derivative format |
| **LinkedIn Tom variant from Track A technical → discovery calls within 60 days** | Baseline TBD (new format in rev 4); target ≥ 1× LinkedIn long-form article click-through rate. Tracks whether the cross-ICP re-engage pattern (Track A source → Track B Tom audience) actually converts | UTM + LinkedIn analytics + CRM source field tagging "Tom variant" |
| **Lead magnet downloads → discovery calls booked within 30 days** | ≥ 5% conversion | Marketing automation |
| **Sample audit report downloads → call request within 30 days (intent signal)** | ≥ 15% (download → call request, not booked) — fast intent signal | CRM source field |
| **Sample audit report downloads → call booked within 90 days (Carol-cycle conversion)** | ≥ 8% conversion — matches Carol procurement cycle (months, not weeks) | CRM source field |
| **Carol-pattern derivative (vendor risk pack) → call request within 30 days (intent)** | ≥ 20% (procurement-grade intent) | CRM source field, qualitative confirmation by title match |
| **Carol-pattern derivative (vendor risk pack) → call booked within 90 days (Carol-cycle conversion)** | ≥ 10% conversion — matches Carol procurement cycle | CRM source field |
| **Persona-variant LinkedIn posts (Sam / Tom / Carol)** | Which persona angle wins per article — surfaces sales motion fit | LinkedIn analytics + CRM source |
| **`[Both]` split-chain attribution** | Which track's chain produced the booked call — confirms the parallel-chain decision pays off | UTM by track + chain |
| **Tier 2 → Tier 1 promotion latency** | <30 days from publish to first promotion-trigger signal (≥2 calls, page-1 rank, or Sam/Carol share) | Monthly review |
| **Tier 3 → Tier 2 promotion rate** | New metric in rev 6 — track % of Tier 3 articles that hit promotion triggers (3× organic traffic OR page-1 long-tail) within 60 days. Baseline TBD; target ≥10% suggests Tier 3 calibration is correct (some upside surprises); >30% suggests Tier 3 threshold is too strict | Monthly review |
| **AI search citation rate** (ChatGPT / Perplexity / Claude citing InnBlockchain content) | ≥ 1 citation per Tier 1 article within 90 days; ≥ 5 citations per research report within 90 days | Manual probing (monthly per [[InnBlockchain - Content AEO GEO Prompts]] schedule) |
| **Hacker News front-page hits** | Track per technical Tier 1 article. Front-page hit = months of secondary referral traffic | HN Algolia API + direct referrer logs |
| **Newsletter open / click rates** | Open ≥ 35%; click ≥ 7% on featured Tier 1 link | Newsletter platform analytics |
| **Mirror.xyz read-time** | ≥ 3 min average (vs. ~30 sec for social posts) | Mirror.xyz analytics |
| **Annual research report citations** (across AI search + earned media + LinkedIn share velocity) | ≥ 50 LinkedIn shares + ≥ 10 AI search citations + ≥ 3 earned-media references in 90 days post-launch | Multi-channel attribution |
| **LinkedIn output cap compliance** | New metric in rev 6 — zero breaches of ≥48 hr spacing rule or 3-posts-per-7-days cap per article from the company profile. Breach = root-cause in Monthly Repurposing Review | Manual log + LinkedIn post timeline review |

### Monthly Repurposing Review (in addition to calendar's monthly review)

1. **Article Tier mix** — how many Tier 1 / 2 / 3 / 0 this month? Skew toward Tier 1 means resource strain — see Production Cadence note.
2. **Format Priority mix** — how many S / A / B formats produced? Any Standard (B) formats slipping because S + A consumed all bandwidth? If so, escalate (decide: drop B for the month, or add capacity).
3. **Derivative-format winners** — which format produced disproportionate LP clicks? Double down next month.
4. **Anti-pattern audit** — any cross-track derivatives published by mistake (technical article on LinkedIn in Felix-coded framing, regulatory article on X, LinkedIn output cap breach)? Root-cause and fix the workflow.
5. **Lead magnet + sample audit conversion** — any Tier 1 PDFs underperforming on the 30-day intent OR 90-day conversion metrics? Re-evaluate gate strategy (gate too aggressive vs. PDF doesn't match search intent).
6. **Deferred (C) format triggers** — any triggers fired this month? Promote to active classification with updated S/A/B placement.
7. **Tier 0 → active gate clears** — any LPs published, WL gates cleared, or AI+Blockchain validation completed this month? Activate Tier 0 articles per protocol; queue backfill derivatives.
8. **Tier 1 demotion review** — any Tier 1 articles past 90 days with zero promotion-trigger signals? Decision: continue / downgrade / kill.

### Quarterly Format-Priority Audit

Owned by dedicated resource + content lead. Done as a half-day session per quarter:

1. **Review master Format Classification table** — every format S/A/B reviewed against actual metric performance from prior quarter.
2. **Promote / demote** — Deferred (C) formats whose triggers fired → promoted; underperforming Standard (B) formats → demoted to Deferred or Excluded with documented reason.
3. **Process the "should we do X?" queue** — any new format proposals from prior quarter get classified into S/A/B/C/D with reasoning.
4. **Re-validate Excluded (D) reasons** — market changes (e.g., a previously dead platform regains traction) may merit re-classification. Default: keep excluded unless new evidence.
5. **Document outcome in revision notes** — every quarterly audit gets a rev bump.

---

## 🔗 References

- Article inventory + scoring + sales motion tagging: [[InnBlockchain - Content Strategy]]
- Publish dates + distribution rhythm + Fri batch block: [[InnBlockchain - Editorial Calendar]]
- ICP — Crypto Native (Felix/Sasha/Paulo channels): [[ICP - Crypto Native]]
- ICP — FinTech (Sam/Tom/Carol channels): [[ICP - FinTech]]
- LinkedIn outreach (Track B ABM cadence — repurposed assets feed this): [[InnBlockchain - LinkedIn Outreach Strategy]]
- Compliance reference (for Carol-pattern derivative review): [[EU-Compliance-Landscape]]
- AEO/GEO + FAQ pages (excluded from this plan; lives in its own doc): [[InnBlockchain - Content AEO GEO Prompts]]

---

## 📌 Replan Triggers

Re-cut this blueprint when any of these fire:

1. **Channel collapse / algorithm shift** — Track A or Track B primary channel shifts (e.g., X engagement collapse, LinkedIn algorithm change that kills carousel reach). Re-classify formats in master index.
2. **Tier 1 promotion failure** — a Tier 1 article fails to clear any promotion trigger within 60 days — the tier criteria are wrong, not the article.
3. **Production staffing change** — dedicated resource replaced / augmented / removed. Re-evaluate format-priority capacity. Designer/producer support assumption (1 week/month minimum) needs re-validation.
4. **EU 5-project gate clears** — outbound expands to UK / MENA / US / SEA. Derivative surfaces change per geography (FCA brief in UK, ADGM/VARA framing in MENA, etc.).
5. **AI+Blockchain cluster validation completes** (due 2026-05-31) — new Track B persona angle activates, may warrant its own derivative pattern. Also triggers Tier 0 → active activation for the AI+Blockchain article cluster.
6. **Phase 2 trigger** — first delivered Track B client + 3+ Track B case studies. Several Deferred (C) formats become active (customer testimonial video, conference speaking, own podcast consideration, guest blog program if not already started).
7. **AI search citation rate drops below baseline** — original research report or FAQ pages (in [[InnBlockchain - Content AEO GEO Prompts]]) underperforming citation targets. Format-priority for cross-track flagship assets needs upgrade.
8. **LinkedIn output cap breach pattern** — if Monthly Repurposing Review surfaces ≥2 consecutive months of cap breaches, the cadence rules need revisiting (likely: cross-pillar Tier 1 needs to drop a format, or the 48-hr spacing needs lengthening, or weekly cross-pillar Tier 1 publish cap needs to tighten further).
9. **Quarterly format-priority audit** (scheduled, not event-driven) — every quarter, review S/A/B/C/D classifications. New formats that emerged in the market (e.g., a new social platform reaching critical mass) get classified. Existing classifications reviewed against actual metric performance. Deferred (C) formats with their triggers fired get promoted; underperforming Standard (B) formats get demoted to Deferred or Excluded.

> [!INFO] How to handle a new format question (e.g., "should we do X?")
> If a new content format / platform gets proposed (TikTok, Threads, new emerging social), check in this order:
> 1. Is it in the **Excluded (D)** table? → Answer is in the "Why excluded" column. Done.
> 2. Is it in the **Deferred (C)** table? → Answer is "not in Phase 1" + trigger condition listed.
> 3. Is it genuinely new (not classified)? → Add to the quarterly format-priority review queue. Do NOT add to production this month. Decisions go in the master Format Classification table.
