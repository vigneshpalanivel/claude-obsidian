---
type: concept
title: "InnBlockchain Content Repurposing Design Toolkit"
status: current
created: 2026-05-29
updated: 2026-05-29
tags:
  - concept
  - content-repurposing
  - design
  - tooling
  - innblockchain
  - marketing
related:
  - "[[InnBlockchain Content Repurposing Plan]]"
  - "[[InnBlockchain Phase 1 Execution Playbook]]"
  - "[[InnBlockchain Content Strategy]]"
  - "[[InnBlockchain Editorial Calendar]]"
  - "[[Content Repurposing Workflow]]"
---

# InnBlockchain Content Repurposing Design Toolkit

The **Design Toolkit Plan for Content** — the design layer of content production for the InnBlockchain Phase 1 program. Owned operationally by **MP2 (Marketing Person #2 — Design / AI Visual)**. Child of [[InnBlockchain Content Repurposing Plan]]; covers what the Plan deliberately doesn't.

> **Canonical source:** `.raw/InnBlockchain/Content/InnBlockchain - Content Repurposing Design Toolkit.md` (rev 5, 2026-05-29).

## What this owns vs what it routes elsewhere

**In scope:** tool stack (AI + part-time designer), per-asset-category tool + owner map, AI vs designer decision shorthand, brand consistency standards, AI hallucination risk + spot-check protocol, design-specific quality gates.

**Routed elsewhere (out of scope):**

| Concern | Owner |
|---|---|
| Format priority (S/A/B/C/D), tier scope, output cap, anti-patterns | [[InnBlockchain Content Repurposing Plan]] |
| Publish schedule + distribution rhythm | [[InnBlockchain Editorial Calendar]] |
| Workstream ownership + spot-check ramp (WS13/WS15) | [[InnBlockchain Phase 1 Execution Playbook]] |
| Regime-specific scope (which briefs, which weeks, which LPs) | [[InnBlockchain Content Strategy]] |
| Regulatory map (canonical) | EU-Compliance-Landscape |

## Team roles referenced

- **MP1** — Marketing Person #1 (Ops / Distribution / SEO) · posting + scheduling + LP on-page SEO
- **MP2** — Marketing Person #2 (Design / AI Visual) · AI visual generation + brand consistency · **primary owner of the toolkit**
- **SCW** — Senior Content Writer · article writing + persona-variant copy + repurposing copy structuring
- **PTD** — Part-time Designer · high-stakes pieces (Sample Audit Report, vendor risk pack, brand template setup, complex regulatory infographics)
- **SM** — Senior Sales Manager · DM templates + vendor risk pack delivery
- **Vignesh** — founder · final review + compliance self-review + on-camera for video

## Tool stack (Phase 1)

| Tool | Function | Owner |
|---|---|---|
| **Canva Pro Team** | LinkedIn carousels · quote graphics · simple PDFs · hero images · brand template library | MP2 |
| **Descript** | Video editing · AI captions · voice cleanup · audio waveform | MP2 |
| **Beautiful.ai** *(or Tome)* | Lead magnet PDFs · decks · slide-based layouts | MP2 |
| **Midjourney** *(or Adobe Firefly)* | Hero visuals · abstract illustrations · concept art | MP2 |
| **ChatGPT Pro** *(or Claude Pro)* | Slide caption generation · X thread structuring · LinkedIn long-form drafting · persona-variant rewrites (human regime-leak review required) | MP2 + SCW |
| **Buffer** (optional), **LinkedIn native scheduler**, **X native scheduler** | Multi-platform + native scheduling | MP1 |
| **Part-time Designer (human)** | Sample Audit Report PDF · vendor risk pack · brand system setup · complex regulatory/architecture infographics · product mockups | PTD |

**Explicitly skipped:** Synthesia / HeyGen (AI avatar — too obvious a synthetic tell for CEO-positioned profile), Hootsuite Enterprise (overkill), Adobe Creative Suite full subscription (heavyweight for one MP2 seat; PTD may use own license), Loomly / Publer / Sprout Social (redundant with native schedulers).

## Asset → tool + owner map

Asset spec (slide count, video length, etc.), tier coverage, publish cadence, and compliance-review requirements all live in the [[InnBlockchain Content Repurposing Plan]] — not here. The asset name is the join key.

### Track A — Crypto Native derivatives

| Asset | Production tool | Production owner | Posting owner |
|---|---|---|---|
| X thread | ChatGPT + thread tool | SCW (copy) + MP2 (header image) | MP1 |
| Lead magnet PDF / checklist | Beautiful.ai OR Canva | MP2 | MP1 |
| GitHub repo / templates | GitHub UI | Vignesh + SCW + senior engineer | MP1 |
| Solodit profile contribution | Solodit submission UI | Vignesh + senior engineer | MP1 |
| LinkedIn post — RWA Felix variant | Canva Pro + ChatGPT | SCW + MP2 | MP1 |
| LinkedIn post — Tom variant | Canva Pro + ChatGPT | SCW + MP2 | MP1 |
| Mirror.xyz cross-post | Mirror.xyz native editor | SCW + MP2 | MP1 |
| Hacker News (Show / Ask HN) | HN submission UI | SCW | MP1 |
| Telegram dev-group share | Plain text + link | MP1 | MP1 |
| LinkedIn quote graphic | Canva Pro templates | MP2 | MP1 |

### Track B — FinTech derivatives

| Asset | Production tool | Production owner | Posting owner |
|---|---|---|---|
| LinkedIn document carousel | Canva Pro + ChatGPT | MP2 | MP1 |
| **Vendor risk pack PDF** ⭐ | Designer | PTD | SM (delivers on request) |
| Persona-specific LinkedIn variants (Sam / Tom / Carol) | ChatGPT + SCW + Canva | SCW + MP2 | MP1 |
| LinkedIn long-form article | ChatGPT + SCW | SCW + MP2 | MP1 |
| Whitepaper / ebook | Designer | PTD | MP1 |
| Standalone infographic | PTD for complex regulatory maps; Canva for simple comparison tables | PTD (complex) OR MP2 (simple) | MP1 |
| LinkedIn native video | Descript edit + phone record | MP2 + Vignesh (on-camera) | MP1 |
| LinkedIn quote graphic | Canva Pro templates | MP2 | MP1 |
| Conference deck-slide | Canva (template-driven slide bank) | MP2 | Vignesh |
| Webinar / panel talking points | Notion / Google Docs | SCW | Vignesh |
| Email nurture excerpt | Plain text in CRM | SCW | SM |

### Cross-Track Assets

| Asset | Production tool | Production owner | Posting owner |
|---|---|---|---|
| **Sample Audit Report PDF** ⭐ | Designer + Compliance sign-off | PTD — **NOT AI** | MP1 (gated download) |
| Original Research / Data Report | Designer + SCW + Vignesh (sprint protocol) | PTD + SCW | MP1 |
| Own Email Newsletter | Beautiful.ai OR Substack / Beehiiv native | SCW + MP2 | MP1 |

### Compliance briefs + checklists

Regime scope lives in [[InnBlockchain Content Strategy]]; this table is asset-category only.

| Asset category | Production tool | Production owner | Posting owner |
|---|---|---|---|
| Compliance brief PDF — standard | Beautiful.ai | MP2 | MP1 + SM |
| Compliance brief PDF — Carol-grade | Designer | PTD | SM |
| Regulatory checklist PDF | Canva OR Beautiful.ai | MP2 | MP1 (gated download) |

### Profile / LP design support

| Asset | Production tool | Production owner | Posting owner |
|---|---|---|---|
| LP hero images | Midjourney / Adobe Firefly | MP2 | FD (integrates into LP code) |
| LinkedIn profile banner | Canva Pro template | MP2 | Vignesh |
| Article hero images | Midjourney / Canva | MP2 | MP1 |
| Product mockup / wireframe | Figma + Canva | PTD | MP2 |

## Decision shorthand: AI vs Designer

When MP2 picks up a new asset, run this in order:

| If the asset is... | Use |
|---|---|
| LinkedIn feed only (not gated, not Carol-facing) | **AI** (Canva + ChatGPT) |
| Lead magnet for non-Carol audience | **AI** (Beautiful.ai or Canva) |
| Lead magnet Carol or Sam might include in vendor review file | **Designer (PTD)** |
| **Sample Audit Report or Vendor Risk Pack** | **Designer** — non-negotiable |
| Complex regulatory map or architecture diagram | **Designer** if accuracy matters; AI for simple comparison tables |
| Brand template / system foundation | **Designer (one-time), then AI maintains via templates** |
| Video with Vignesh's face | **Vignesh records + AI edits (Descript)** — never AI avatar |
| Tier 3 quote graphic, simple text-post visual | **AI** + template |
| Hero image or abstract illustration | **AI** (Midjourney / Firefly) |
| Trade event deck slide | **AI** template-driven; single high-value event = Designer |

**Default lean:** AI first; escalate to PTD only when the asset hits a Designer row. Designer capacity is finite and reserved for items where credibility hinges on human polish.

## Brand consistency standards

PTD owns initial brand system setup in W2–W3 (~5 days): typography system, color palette, logo usage rules, Canva carousel + quote graphic template sets, Beautiful.ai lead magnet template, Descript lower-thirds + caption styles, LinkedIn profile banner template, Midjourney hero image style guide. MP2 maintains via templates ongoing; new template requests routed to PTD (no ad-lib templates in Canva).

**Hard "never" rules for visual output:**

- Never publish a slide with a regulator-misframed claim (MiCA-on-RWA leak is the #1 risk — see hallucination section)
- Never use stock photos of "fake businesspeople shaking hands"
- Never use crypto-cliché visuals (Bitcoin logo, gold coins, floating blockchain rectangles, matrix-code overlays)
- Never publish a carousel slide that doesn't fit the template
- Never publish a Sample Audit Report or Vendor Risk Pack that wasn't designed by PTD
- Never use AI avatar video (Synthesia / HeyGen) for CEO-positioned content
- Never publish AI-generated copy on a slide without human regime-leak review

## AI hallucination risk + spot-check protocol

**Single biggest risk:** ChatGPT auto-generates slide copy that hallucinates regulatory framing. Concrete failure mode: prompted for an RWA tokenization compliance carousel, ChatGPT plausibly outputs *"Slide 4: Ensure MiCA compliance for your tokenized real-world assets"*. **This is wrong** — RWA ownership tokens are MiFID II financial instruments excluded from MiCA per Art. 2(4). Publishing this = MiCA-on-RWA leak = Carol kills the deal.

**Spot-check protocol** (per [[InnBlockchain Phase 1 Execution Playbook]] WS13): Vignesh review intensity ramps down from 100% in W1–W4 of MP2's ramp to sample-rate review at W5+ steady state, except for high-stakes pieces (Sample Audit, vendor risk pack, complex infographics) which stay at 100% + Compliance sign-off indefinitely.

**MP2 regime-leak checklist** (apply before publish on every AI-generated copy):

- No "MiCA" + "RWA" in same slide / sentence / caption
- No "MiCA-compliant tokenization" or similar formulations
- All regulatory references date-stamped
- Per-segment scope guards (RWA pieces stay in MiFID II / DLT Pilot lane; cross-pillar pieces use `[Both]` split CTA properly)
- If unsure, escalate to Vignesh BEFORE publish — never "publish then fix"

## Per-asset production workflows (key examples)

Workflows cover design execution steps only. Asset spec, tier scope, publish cadence, and distribution rules live in the [[InnBlockchain Content Repurposing Plan]] + [[InnBlockchain Editorial Calendar]].

| Asset | Total design time | High-level steps |
|---|---|---|
| LinkedIn carousel | ~3–4 hr | SCW copy outline → MP2 Canva layout → MP2 regime-leak check → Compliance review → MP1 schedules per LinkedIn output cap |
| LinkedIn native video | ~4–6 hr | SCW script → Vignesh records on phone → MP2 Descript edit → MP2 caption regime-leak check → Vignesh final review → MP1 schedules |
| Sample Audit Report PDF | ~15–25 hr | Vignesh writes content → PTD designs PDF layout → front-matter disclosure → Compliance sign-off → MP1 hosts on gated LP |
| Lead magnet PDF (non-Carol) | ~3–4 hr | SCW drafts → MP2 Beautiful.ai/Canva layout → MP2 regime-leak check → Vignesh compliance review → MP1 hosts on gated LP |
| Mirror.xyz cross-post | ~30 min | SCW reformats → MP2 light visuals → MP1 publishes |
| Telegram dev-group share | ~15 min | MP1 writes paragraph + link → MP1 posts to curated groups |

## Pre-publish quality checks — design only

General publish discipline (track tag, sales motion tag, CTA destination, tier scope, output cap, compliance sign-off) is owned by Plan + Strategy + Playbook. Apply those **in addition to** the three design-specific checks:

- Brand template adherence — typography, color, logo placement match brand system; no ad-lib visual elements
- AI-generated copy reviewed by human — never publish ChatGPT output directly; human pass + Vignesh sign-off at the rate set by spot-check protocol
- MP2 regime-leak checklist passed on every AI-generated slide / caption / body copy

## Failure modes to actively monitor — design only

Distribution-side and workflow-SLA failure modes (LinkedIn output cap breach, Vignesh review SLA slip, etc.) are owned by [[InnBlockchain Phase 1 Execution Playbook]] Risk Register + Plan Anti-Patterns. Design-specific ones:

1. **AI-hallucinated regulatory framing on slides** — Critical · same Carol-killing cost as regime-leak DM · spot-check protocol mandatory
2. **Brand consistency drift** — Medium · MP2 creates new templates ad hoc; monthly review with PTD catches drift
3. **Sample Audit Report shipped without designer polish or compliance sign-off** — Critical · undercuts the highest-leverage Phase 1 asset
4. **Synthetic Sample Audit shipped without explicit disclosure** — Critical · reputational + regulatory risk
5. **Visual-layer regime leak on Carol-pattern asset** — Critical · slide captions / infographic labels / diagram annotations added during design (often AI-generated) can introduce regulatory misframes the source-article review missed. Compliance review must cover the *visual-layer copy*, not just the source article. (Distinct from Plan's source-article anti-pattern; this is the design-output-layer extension.)

## Replan triggers

Re-cut this toolkit when:

1. **AI tool capability shift** — Canva / Descript / Beautiful.ai / Midjourney / ChatGPT introduce features that change AI vs designer split (e.g., AI infographic tools accurate enough for regulatory maps) — quarterly review
2. **Hallucination incident** — a published AI-generated asset contains a regulatory misframe — immediate spot-check tightening + post-mortem
3. **PTD capacity change** — designer engagement scales up (retainer) or down (contract ends) — re-allocate high-stakes pieces
4. **Phase 2 dedicated repurposing resource hired** — toolkit becomes owned by that resource, MP2 supports
5. **Brand system v2** — quarterly brand consistency review surfaces enough drift / new use cases
6. **LinkedIn algorithm shift** — carousel reach collapses or video performance changes materially → tool prioritization adjusts

## Why this is a separate doc from the Plan

The Plan owns *what* gets produced (formats, tiers, output cap, anti-patterns). The Toolkit owns *how it gets produced* (tools, AI vs designer split, brand standards, hallucination control). Bundling them into one doc bloats the Plan with execution detail that changes on a different cadence than format strategy, and obscures that MP2 (not the dedicated repurposing resource) owns the design layer. Splitting also makes the "compliance review covers visual-layer copy, not just source article" extension visible as a distinct failure mode rather than buried in a generic anti-pattern.
