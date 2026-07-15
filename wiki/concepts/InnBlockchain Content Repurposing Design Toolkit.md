---
company:
  - innblockchain
department:
  - marketing
priority: high
rev: 8
last_revised: 2026-07-06
revision_notes: |
  rev 1 (2026-05-29): initial design toolkit, design-child of Content Repurposing Plan + Playbook WS15. Tool stack, asset-category map, AI vs designer split, brand standards, hallucination spot-check, pre-publish checks. MPs owns. Comp structures out of scope.
  rev 2 (2026-05-29): removed all tool cost / pricing / budget references; tool stack table now tool + function + owner only.
  rev 3 (2026-05-29): collapsed 4 regime-specific compliance brief rows to 3 asset-category rows. References block pruned 10 → 5 (kept only inline-referenced docs).
  rev 4 (2026-05-29): repositioned as design-only child of Plan. Pre-Publish Checks 9 → 3 (design-only). Failure Modes 7 → 5 (dropped output-cap-breach + Vignesh SLA — owned by Playbook/Plan). Scope callout routes each non-design concern to its parent doc.
  rev 5 (2026-05-29): full duplication audit vs Plan. Asset Category Map: stripped all Plan-owned parentheticals (tier scope, format spec, spacing rules, event names, LP routing) — asset name + tool + owners only. Production Workflows: replaced embedded Plan content with pointer links (LinkedIn output cap, Cross-Track Assets disclosure, regime scope, canonical URL, Telegram timing). Failure mode #5 reframed as visual-layer regime leak (distinct from Plan's source-article review).
  rev 6 (2026-06-02): **alignment sweep to match Playbook rev 18 naming + ownership scheme.** Three changes: (1) Role abbreviation sweep — Marketing Person #1 + #2 → **MPs** (collective; internal split deferred to operational decision per Playbook rev 11) · Senior Content Writer (SCW) → **CW** · Part-time Designer (PTD) → **Designer** · "Sales Person" → **SP** in body content (full name in legend). (2) Team roles section restructured to match Playbook Per-Role Quick Reference + Team configuration callout — abbreviations defined once at the top. (3) Brand standards section adds a forward-reference to Playbook WS3 § Brand system foundation (Playbook rev 16) which independently enumerates the same artifacts as a checklist — toolkit defines the standards, Playbook tracks the W2–W3 sprint completion. Toolkit "primary owner" framing dropped (was the old MP2-specific framing) — now owned collectively by MPs with Designer for high-stakes pieces, mirroring Playbook WS15 ownership model.
  rev 7 (2026-06-03): **Telegram dev-group share dropped — doesn't map to Phase 1 ICP.** Synced to Playbook rev 20 sweep. RWA Felix (Phase 1 CN buyer) is asset-first non-technical; Sam/Tom/Carol (Phase 1 FT) evaluates via vendor risk pack + audit report. Telegram dev-group audience (Solidity devs · DeFi builders) is not a Phase 1 buyer. Sweep: (1) Asset Category Map Track A — "Telegram dev-group share" row removed. (2) Per-Asset Production Workflows — "Telegram dev-group share" workflow block removed. (3) References block — "Wed Telegram drop timing" pointer removed from Editorial Calendar reference description. Re-evaluate for Phase 2/3 DeFi-protocol scope (Telegram is correctly a high-converting channel for DeFi/protocol Felix per [[ICP - Crypto Native]] Segments 2–6).
  rev 8 (2026-07-06): **Claude design for carousel · quote-graphic · single-image post templates.** Synced to Playbook rev 35. Tool Stack: Claude row added (carousel + quote-graphic + single-image templates); carousel + quote-graphic removed from Canva's What-it-does. Asset Category Map: carousel + quote-graphic + single-image post rows updated across Track A + Track B (Canva Pro → Claude). Decision Shorthand: Claude-spec row added at top for the 3 formats. Brand Consistency Standards checklist: carousel + quote-graphic updated to Claude brand-locked prompt spec; single-image post template added. Per-asset workflow (LinkedIn carousel): Canva step updated to Claude design spec. Replan Triggers: Claude added to AI tool list.
tags:
  - content
  - repurposing
  - design
  - tools
---

# 🎨 Content Repurposing Design Toolkit — InnBlockchain

> [!NOTE] Scope
> **The Design Toolkit Plan for Content** — the design layer of content production. Covers tool stack, asset → tool/owner map, AI vs designer split, brand standards, hallucination spot-check, design-specific quality gates.
>
> Child of [[Content Repurposing Plan]]. Out of scope (routed elsewhere): format priority + tier scope + output cap + anti-patterns → Plan · publish schedule → [[Editorial Calendar]] · workstream ownership + spot-check ramp → [[Execution Playbook]] WS13/WS15 · regime-specific scope → [[Content Strategy]] · regulatory map → [[EU-Compliance-Landscape]].

> [!INFO] Team roles referenced (aligned with Playbook rev 18 Team configuration)
> - **MPs** = Marketing Persons (both, collectively) — AI visual generation · posting + scheduling · brand template maintenance · LP on-page SEO · LP hero / banner image production · day-to-day owners of this toolkit (no internal MP1/MP2 split prescribed here; operational allocation deferred)
> - **CW** = Content Writer — article writing · persona-variant copy · repurposing copy structuring · slide-copy outlines for MPs
> - **Designer** = high-stakes pieces — Sample Audit Report · Vendor Risk Pack · brand template system setup (W2–W3 one-time) · complex regulatory infographics · W14 Internal MVP mockup
> - **SP** = Sales Person — DM templates · vendor risk pack delivery (on request)
> - **Vignesh** = founder · final review + compliance self-review + on-camera for video
> - **Dev** = Frontend Dev — LP integration of hero images + email-capture wiring

---

## 🧰 Tool Stack

### Phase 1 active stack

| Tool | What it does | Primary owner |
|---|---|---|
| **Claude** *(Anthropic)* | Carousel templates · Quote-graphic templates · Single-image post templates (brand-locked prompt spec + patterns; Designer sets system W2–W3, MPs execute per template) | MPs |
| **Canva Pro Team** | Simple PDFs · Hero images · Brand template library | MPs |
| **Descript** | Video editing · AI captions · Voice cleanup · Audio waveform editing for 60–90s native video | MPs |
| **Beautiful.ai** *(or Tome as alternative)* | Lead magnet PDFs · Decks · Slide-based asset layouts (non-Carol-facing) | MPs |
| **Midjourney** *(or Adobe Firefly as alternative)* | Hero visuals · Abstract illustrations · Concept art for blog headers | MPs |
| **ChatGPT Pro** *(or Claude Pro)* | Slide caption generation · X thread structuring · LinkedIn long-form drafting assist · Persona variant rewrites *(requires human regime-leak review)* | MPs + CW |
| **Buffer** *(optional)* | Multi-platform scheduling (LinkedIn + X + others from one dashboard) | MPs |
| **LinkedIn native scheduler** | Schedule personal feed + company page posts | MPs |
| **X native scheduler** | Schedule X threads | MPs |
| **Part-time Designer (human)** | Sample Audit Report PDF · Vendor risk pack PDF · Brand template system setup (one-time) · Complex regulatory/architecture infographics · W14 Internal MVP mockup | Designer |

### Explicitly skipped (decided against)

| Tool | Reason |
|---|---|
| **Synthesia / HeyGen** (AI avatar video) | Too obvious a synthetic tell for CEO-positioned profile. Vignesh records on-camera; Descript edits. |
| **Hootsuite Enterprise** | Overkill for Phase 1 volume. LinkedIn + X native schedulers + Buffer cover the cadence. |
| **Adobe Creative Suite full subscription** | Heavyweight tooling for one user; Canva Pro + Descript + Midjourney cover the same use cases for a non-designer-hire profile. Designer may use their own Adobe license. |
| **Loomly / Publer / Sprout Social** (alternative schedulers) | LinkedIn native + X native + Buffer combination is sufficient; no need for third schedule dashboard. |

---

## 🗂️ Asset Category → Tool + Owner Map

Each derivative format from [[Content Repurposing Plan]] mapped to its production tool, production owner, and posting owner. **Asset spec, tier coverage, format definition (slide count, video length, etc.), publish cadence, and compliance-review requirements live in the Plan** — not here. The asset name is the join key.

### Track A — Crypto Native derivatives

| Asset | Production tool | Production owner | Posting owner |
|---|---|---|---|
| **X thread** | ChatGPT + thread tool | CW (copy) + MPs (header image if needed) | MPs (X native scheduler) |
| **Lead magnet PDF / checklist** | Beautiful.ai OR Canva | MPs | MPs (gated LP + email capture) |
| **GitHub repo / open-source templates** | GitHub UI | Vignesh + CW + senior engineer | MPs |
| **Solodit profile contribution** | Solodit submission UI | Vignesh + senior engineer | MPs |
| **LinkedIn post — RWA Felix variant** | Claude + ChatGPT | CW (copy) + MPs (visual) | MPs |
| **LinkedIn post — Tom variant** | Claude + ChatGPT | CW (copy) + MPs (visual) | MPs |
| **Mirror.xyz cross-post** | Mirror.xyz native editor | CW (text reformat) + MPs (light visuals) | MPs |
| **Hacker News (Show HN / Ask HN)** | HN submission UI | CW (positioning copy) | MPs |
| **LinkedIn quote graphic** | Claude templates | MPs | MPs |

### Track B — FinTech derivatives

| Asset | Production tool | Production owner | Posting owner |
|---|---|---|---|
| **LinkedIn document carousel** | Claude + ChatGPT | MPs | MPs (LinkedIn native scheduler) |
| **Vendor risk pack PDF** ⭐ | Designer | Designer | SP (delivers on request) |
| **Persona-specific LinkedIn post variants** | Claude + ChatGPT + CW | CW (copy) + MPs (visuals) | MPs |
| **LinkedIn long-form article** | ChatGPT + CW writing | CW (copy) + MPs (visual elements) | MPs |
| **Whitepaper / ebook** | Designer | Designer | MPs (gated download + email capture) |
| **Standalone infographic** | Designer for complex regulatory maps; Canva for simple comparison tables | Designer (complex) OR MPs (simple) | MPs |
| **LinkedIn native video** | Descript (edit) + phone (record) | MPs (edits) + Vignesh (on-camera) | MPs |
| **LinkedIn quote graphic** | Claude templates | MPs | MPs |
| **Conference deck-slide** | Canva (template-driven slide bank) | MPs | Vignesh (uses at event) |
| **Webinar / panel talking points** | Notion / Google Docs | CW | Vignesh |
| **Email nurture excerpt** | Plain text drafted in CRM | CW (copy) | SP (CRM sequence) |

### Cross-Track Assets

| Asset | Production tool | Production owner | Posting owner |
|---|---|---|---|
| **Sample Audit Report PDF** ⭐ | Designer + Compliance sign-off | Designer — NOT AI | MPs (gated download) |
| **Original Research / Data Report** | Designer + CW + Vignesh (sprint protocol → [[Content Repurposing Plan]] § Research-report sprint) | Designer + CW | MPs |
| **Own Email Newsletter** | Beautiful.ai for layout OR newsletter platform native (Substack / Beehiiv) | CW (copy) + MPs (visuals) | MPs |

### Compliance briefs + checklists

Regime-specific scope (which briefs, which weeks, which LPs) lives in [[Content Strategy]] and [[Content Repurposing Plan]]. This table is asset-category only.

| Asset category | Production tool | Production owner | Posting owner |
|---|---|---|---|
| **Compliance brief PDF — standard** | Beautiful.ai | MPs | MPs + SP |
| **Compliance brief PDF — Carol-grade** | Designer | Designer | SP delivers on request |
| **Regulatory checklist PDF** | Canva OR Beautiful.ai | MPs | MPs (gated download on LP) |

### Profile / LP design support

| Asset | Production tool | Production owner | Posting owner |
|---|---|---|---|
| **LP hero images** | Midjourney / Adobe Firefly | MPs | Dev (integrates into LP code) |
| **LinkedIn profile banner** | Canva Pro template | MPs | Vignesh |
| **Article hero images** | Midjourney / Canva | MPs | MPs |
| **Product mockup / wireframe** | Figma + Canva | Designer | MPs (integrates into LP) |

---

## 🧭 Decision Shorthand: AI vs Designer

When MPs picks up a new asset, run this in order:

| If the asset is... | Use |
|---|---|
| **Carousel · Quote graphic · Single-image post** (any track) | **Claude design spec** (brand-locked prompt templates — Designer sets system W2–W3, MPs execute) |
| Going on LinkedIn feed only (not gated, not Carol-facing) | **AI** (Canva + ChatGPT) |
| A lead magnet downloaded via email-capture form, non-Carol audience | **AI** (Beautiful.ai or Canva) |
| A lead magnet that Carol or Sam might include in vendor review file | **Designer** (Designer) |
| **Sample Audit Report or Vendor Risk Pack** | **Designer** — non-negotiable |
| A complex regulatory map or architecture diagram | **Designer** if accuracy matters; AI for simple comparison tables |
| Brand template / system foundation (typography, color, logo placement standards) | **Designer (one-time setup), then AI maintains via templates** |
| Video with Vignesh's face | **Vignesh records + AI edits (Descript)** — no AI avatar |
| Quick amplification asset (Tier 3 quote graphic, simple text post visual) | **AI** + template |
| Hero image or abstract illustration | **AI** (Midjourney / Firefly) |
| Trade event deck slide for Vignesh to present | **AI** template-driven (Canva); single high-value event = Designer |

**Default lean:** AI first; escalate to Designer when the asset hits one of the "Designer" rows above. Don't pre-emptively escalate everything to Designer — designer capacity is finite and reserved for the items where credibility hinges on human polish.

---

## 🎨 Brand Consistency Standards

Brand system is set up ONCE by Designer in W2–W3, then maintained by MPs across all assets.

> [!INFO] Cross-doc alignment
> The same artifact list also lives in [[Execution Playbook]] WS3 § Brand system foundation (Playbook rev 16) — there as a Designer W2–W3 sprint checklist tracked at the operational level. This toolkit defines the standards; the Playbook tracks sprint completion. Keep both in sync when artifact list changes.

### Brand system deliverables (Designer owns initial setup — ~5 days W2–W3)

- [ ] **Typography system** — primary headline font · body font · accent font · size hierarchy (H1/H2/H3/body/caption) · sizing for carousel slides vs PDF vs video subtitle
- [ ] **Color palette** — primary brand color · secondary · accent · neutrals · semantic colors (success/warning/error/info) · accessibility contrast ratios documented
- [ ] **Logo usage rules** — minimum size · clear-space requirements · color variants (full-color · white knockout · single-color · monochrome) · usage on light vs dark backgrounds
- [ ] **Carousel template set** (Claude — brand-locked prompt spec + patterns) — title slide · text-heavy slide · stat-callout slide · quote slide · CTA close slide · cover image template
- [ ] **Quote graphic template set** (Claude — brand-locked prompt spec + patterns) — short-quote variant · long-quote variant · stat variant · founder-attribution variant
- [ ] **Single-image post template set** (Claude — brand-locked prompt spec + patterns) — feed post visual · stat highlight variant
- [ ] **Lead magnet PDF template** (Beautiful.ai) — cover · TOC · content page · CTA close · branded footer
- [ ] **Video lower-thirds + caption styles** (Descript) — title card · speaker name overlay · subtitle styling
- [ ] **LinkedIn profile banner template** + variants for event seasons
- [ ] **Article hero image style guide** — Midjourney prompts that produce on-brand visuals (style keywords, color guidance, composition rules)

### MPs maintenance (ongoing)

- [ ] Every new asset uses an existing template — no ad-lib new colors/fonts/layouts
- [ ] Quarterly brand consistency review with Designer (drift correction)
- [ ] New template requests routed to Designer (don't create new templates ad hoc in Canva)

### Hard "never" rules for visual output

- [ ] Never publish a slide with a regulator-misframed claim (MiCA-on-RWA leak is the #1 risk — see § AI Hallucination Risk below)
- [ ] Never use stock photos of "fake businesspeople shaking hands" — uniformly unprofessional in B2B FinTech
- [ ] Never use crypto cliché visuals (Bitcoin logo · gold coins · floating blockchain rectangles · matrix-code overlays) — wrong tone for regulated FinTech buyers
- [ ] Never publish a carousel slide that doesn't fit the template — visual inconsistency reads as scattered to Compliance Carol
- [ ] Never publish a Sample Audit Report or Vendor Risk Pack that wasn't designed by Designer
- [ ] Never use AI avatar video (Synthesia / HeyGen) for CEO-positioned content
- [ ] Never publish AI-generated copy on a slide without human regime-leak review

---

## ⚠️ AI Hallucination Risk + Spot-Check Protocol

The single biggest risk with AI-assisted visual production: **ChatGPT auto-generates slide copy that hallucinates regulatory framing.**

### Concrete failure mode

Prompt to ChatGPT: *"Write 7 slide captions for a LinkedIn carousel about RWA tokenization compliance for EU asset managers."*

Plausible AI output: *"Slide 4: Ensure MiCA compliance for your tokenized real-world assets."*

**This is wrong.** RWA ownership tokens are MiFID II financial instruments excluded from MiCA per Art. 2(4). Publishing this slide = MiCA-on-RWA leak = Carol kills the deal. **Same cost as a regime-leak DM.**

ChatGPT doesn't know the MiFID II / DLT Pilot vs MiCA regime boundary because it confuses surface-level keyword associations. Every AI-generated slide caption must be reviewed against [[EU-Compliance-Landscape]] before publish.

### Spot-check protocol (per [[Execution Playbook]] WS13)

| Asset type | Review intensity W1–W4 of MPs ramp | Steady-state W5+ |
|---|---|---|
| MPs carousels (Track B Tier 1, cross-pillar) | Vignesh reviews 100% before publish | Vignesh reviews 25% sample |
| MPs carousels (Track A Tier 2/3, lower stakes) | Vignesh reviews 25% sample | Vignesh reviews 10% sample |
| MPs quote graphics / single-image visuals | Vignesh reviews 25% sample | Vignesh reviews 10% sample |
| MPs LP hero images / article hero images | Vignesh reviews 100% (low volume) | Vignesh reviews 100% |
| MPs video edits (Vignesh on-camera) | Vignesh reviews 100% (he's the talent) | Vignesh reviews 100% |
| MPs lead magnet PDFs (non-Carol-facing) | Vignesh reviews 100% before publish | Vignesh reviews 50% sample |
| Designer high-stakes pieces (Sample Audit, vendor risk pack, complex infographics) | Vignesh reviews 100% + Compliance sign-off | Vignesh reviews 100% + Compliance sign-off |

### Hard rule for MPs

> Every AI-generated slide caption / video subtitle / PDF body copy gets a regime-leak check against the canonical map in [[EU-Compliance-Landscape]] before publish. ChatGPT-generated copy is **suggestive, not authoritative**.

**MPs regime-leak checklist** (apply before publish on every AI-generated copy):
- [ ] No "MiCA" + "RWA" in same slide / sentence / caption
- [ ] No "MiCA-compliant tokenization" or similar formulations
- [ ] All regulatory references date-stamped (e.g., "MiFID II — as of 2026")
- [ ] Per-segment scope guards (RWA pieces stay in MiFID II / DLT Pilot lane; cross-pillar pieces use [Both] split CTA properly)
- [ ] If unsure, escalate to Vignesh BEFORE publish — never "publish then fix"

---

## 🛠️ Per-Asset Production Workflow (Key Examples)

Workflows below cover design execution steps. Asset spec (slide count, video length, page count), tier scope, publish cadence, and distribution rules live in [[Content Repurposing Plan]] + [[Editorial Calendar]].

### LinkedIn carousel

**Total time: ~3–4 hr per article**

1. **CW writes slide-by-slide copy outline** (~1 hr) — persona coding per [[Content Repurposing Plan]] § `[Both]` Articles
2. **MPs generates visual layout using Claude design spec** (~1.5 hr) — uses brand-locked prompt template, fills slide copy, generates hero image via Midjourney if needed
3. **MPs regime-leak check** (~15 min) — runs MPs regime-leak checklist on slide copy
4. **Compliance review** (~30 min) — Vignesh reviews for regime accuracy at sample rate per § AI Hallucination Risk
5. **MPs schedules publish** (~15 min) — LinkedIn native scheduler, per [[Content Repurposing Plan]] § LinkedIn output cap

### LinkedIn native video

**Total time: ~4–6 hr per article**

1. **CW drafts script** (~1 hr) — one key insight from source article
2. **Vignesh records** (~30 min) — on phone, native camera, good lighting + audio
3. **MPs edits in Descript** (~2–3 hr) — auto-caption + manual cleanup · B-roll if any · branded lower-thirds + outro card · audio cleanup
4. **MPs regime-leak check on captions** (~15 min) — Descript auto-captions may hallucinate regulatory terms; verify against canonical regime map
5. **Vignesh final review** (~15 min) — he's the talent, sign-off required
6. **MPs schedules publish** (~10 min) — captions on by default, per [[Content Repurposing Plan]] § LinkedIn output cap

### Sample Audit Report PDF

**Total time: ~15–25 hr — designer (Designer) + Compliance (Vignesh)**

1. **Vignesh writes report content** (~5–8 hr) — methodology + findings drawn from publicly available exploit research + InnBlockchain methodology (synthetic acceptable per [[Content Repurposing Plan]] § Cross-Track Assets)
2. **Designer designs PDF layout** (~6–10 hr) — mimics regulator-grade audit firm report format (Trail of Bits / OpenZeppelin / Halborn structures as reference) · cover · executive summary · methodology · findings table · severity classification · appendix · branded footer
3. **Front-matter disclosure inserted** — exact wording + when-it-applies per [[Content Repurposing Plan]] § Cross-Track Assets disclosure rule
4. **Compliance reviewer sign-off** (~2–4 hr) — Vignesh self-review against canonical regime map; check all regulatory references are accurate
5. **MPs hosts on gated LP** (~30 min) — gated PDF download, email capture form, pinned to Featured on LinkedIn profile

### Lead magnet PDF (non-Carol-facing)

**Total time: ~3–4 hr per asset**

1. **CW drafts content** (~1.5 hr) — checklist body copy; regime scope per [[Content Strategy]]
2. **MPs generates layout in Beautiful.ai or Canva** (~1 hr) — applies brand template, formats checklist items
3. **MPs regime-leak check** (~15 min)
4. **Vignesh self-reviews compliance** (~30 min)
5. **MPs hosts on gated LP** (~30 min) — email capture form, "Download" CTA, pinned to Featured

### Mirror.xyz cross-post

**Total time: ~30 min per article**

1. **CW reformats source article for Mirror** (~15 min) — Mirror UI; canonical URL rule per [[Content Repurposing Plan]] Track A asset family
2. **MPs adds light visuals if needed** (~10 min) — hero image, inline diagrams
3. **MPs publishes** (~5 min)

---

## ✅ Pre-Publish Quality Checks — Design Only

General publish discipline (track tag, sales motion tag, CTA destination, tier scope, output cap, compliance sign-off) is owned by [[Content Repurposing Plan]], [[Content Strategy]], and [[Execution Playbook]] WS13. Apply those checks **in addition to** the design-specific ones below.

- [ ] **Brand template adherence** — typography, color, logo placement match brand system; no ad-lib visual elements
- [ ] **AI-generated copy reviewed by human** — never publish ChatGPT-generated slide / caption / PDF copy directly; human pass + Vignesh sign-off at the rate set in § AI Hallucination Risk
- [ ] **MPs regime-leak checklist passed** on every AI-generated slide / caption / body copy — see § AI Hallucination Risk for the checklist + anchor map

---

## 🚨 Failure modes to actively monitor — Design Only

Distribution-side and workflow-SLA failure modes (LinkedIn output cap breach, Vignesh review SLA slip, etc.) are owned by [[Execution Playbook]] Risk Register + [[Content Repurposing Plan]] § Anti-Patterns. The design-specific ones below:

1. **AI-hallucinated regulatory framing on slides** (MPs visual output ships with "MiCA-compliant RWA" or similar) — Critical · same Carol-killing cost as regime-leak DM · spot-check protocol mandatory
2. **Brand consistency drift** (MPs creates new templates ad hoc; carousel #1 looks different from carousel #5) — Medium · monthly review with Designer catches drift
3. **Sample Audit Report shipped without designer polish or compliance sign-off** — Critical · undercuts the highest-leverage Phase 1 asset
4. **Synthetic Sample Audit shipped without explicit disclosure** — Critical · reputational + regulatory risk
5. **Visual-layer regime leak on Carol-pattern asset** — Critical · slide captions / infographic labels / diagram annotations added during design (often AI-generated) can introduce regulatory misframes that the content review missed. Compliance review must cover the *visual-layer copy*, not just the source article. (Plan anti-pattern covers the source-article review; this is the design-output-layer extension.)

---

## 📚 References

Only docs actually pulled from inline in this toolkit. Regime-specific scope, AEO prompts, LinkedIn algorithm strategy, and profile copy live in their own docs and aren't reached from here.

- **[[Content Repurposing Plan]]** — parent doc: tiers (1/2/3/0), Format Priority (S/A/B/C/D), per-track asset families, LinkedIn output cap + 3-week cross-pillar cadence, research-report sprint protocol, Anti-Patterns
- **[[Execution Playbook]]** — WS13 spot-check ramp (W1–W4 → W5+), WS15 ownership + capacity model, Risk Register
- **[[EU-Compliance-Landscape]]** — canonical regulatory regime map; the anchor for every MPs regime-leak check
- **[[Editorial Calendar]]** — publish schedule + distribution rhythm (cross-pillar 3-week cadence)
- **[[Content Strategy]]** — article inventory + sales motion tagging; regime-specific compliance brief scope (which briefs, which weeks, which LPs)

---

## 📌 Replan Triggers

Re-cut this toolkit when:

1. **AI tool capability shift** — Canva / Descript / Beautiful.ai / Midjourney / Claude / ChatGPT introduce features that change AI vs designer split (e.g., AI infographic tools become accurate enough for regulatory maps) — quarterly review
2. **Hallucination incident** — a published AI-generated asset contains a regulatory misframe (MiCA-on-RWA leak in carousel copy, etc.) — immediate spot-check protocol tightening + post-mortem
3. **Designer capacity change** — designer engagement scales up (e.g., move to retainer) or down (e.g., contract ends without renewal) — re-allocate high-stakes pieces between Designer and MPs
4. **Phase 2 dedicated repurposing resource hired** — toolkit becomes owned by that resource, MPs supports
5. **Brand system v2** — quarterly brand consistency review surfaces enough drift / new use cases to warrant template refresh
6. **LinkedIn algorithm shift** — if carousel reach collapses or video performance changes materially, tool prioritization adjusts
