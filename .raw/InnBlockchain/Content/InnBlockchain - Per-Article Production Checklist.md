---
company:
 - innblockchain
department:
 - marketing
priority: high
rev: 2
last_revised: 2026-06-13
parent_extraction_source: "[[InnBlockchain - Phase 1 Execution Playbook]] § WS7 § Per-Article Production Checklist + § WS15 § Per-published-article repurposing checklist (folded into step 19 expansion)"
scope: cross-phase
applies_to:
 - phase-1
 - phase-2
 - phase-3
tags:
 - framework
 - per-article
 - production-checklist
 - cw
 - cross-phase
---

# Per-Article Production Checklist (CW master sequence)

> [!INFO] Single linear walk-through · ~25–35 min to step through · ~13 hr to execute per article · cross-phase framework
> Open this Monday morning for the Tue slot · Wednesday morning for the Thu slot (or whatever cadence the current phase uses). The single source of truth for *what* to write is **[[InnBlockchain - Editorial Calendar]]**; everything else is consulted at the step where it applies. Run sequentially — Phase 2 won't make sense without Phase 1; Phase 4 can't fire correctly if Phase 1 missed the tier.
>
> Extracted from [[InnBlockchain - Phase 1 Execution Playbook]] → cross-phase framework. Workflow structure (4 phases · 25 steps · 48-hr SLA · Mon AM batch approval · CORE-EEAT ordering rule) is universal. Phase-specific overlays (LP gate names · cross-pillar article slugs · regime hard stops · Pain Point validation deadlines) are flagged inline.

## Phase 1 — Pre-write (Mon AM for Tue slot · Wed AM for Thu slot · ~30 min)

| # | Step | Doc to consult |
|---|---|---|
| 1 | **(CW)** Confirm this week's slot — article ID, tier (1/2/3/0), score, track tag (`[CN]` / `[FT]` / `[Both]`), gate dependencies | [[InnBlockchain - Editorial Calendar]] § (phase-specific) Close Schedule |
| 2 | **(CW · escalate to Dev if 404)** Verify destination LP is live — if 404, escalate as P0 before drafting (Tier 0 rule: no repurposing on LP-gated articles) | [[InnBlockchain - Landing Pages Plan]] § matching solution sub-page |
| 3 | **(CW)** Confirm article positioning — pillar / cluster · primary persona · sales motion · `[Audit]` / `[Dev]` / `[White-Label]` motion lock | [[InnBlockchain - Content Strategy]] § Pillar Map + § Sales Motion Tagging |
| 4 | **(CW)** Confirm persona language for this track | [[InnBlockchain - ICP - Crypto Native]] OR [[InnBlockchain - ICP - FinTech]] (whichever the track tag points to) |
| 5 | **(CW · Vignesh confirms on regime questions)** Confirm regime framing — which regulations apply, which to AVOID for this phase | [[EU-Compliance-Landscape]] + the per-regime checklist (e.g., [[mifid2-checklist]], [[dlt-pilot-checklist]], [[mar-checklist]]) |
| 6 | **(CW)** Pull per-article AEO prompt block + apply 13 AEO Drafting Principles | [[InnBlockchain - Content AEO GEO Prompts]] § Week-by-Week Article Prompts + § AEO Drafting Principles |
| 7 | **(CW)** Confirm derivative chain scope by tier — Tier 1 full chain · Tier 2 scaled-back · Tier 3 amplify-only · Tier 0 none. Plan derivative copy structure while outlining. | [[InnBlockchain - Content Repurposing Plan]] § Repurposing Tiers |

## Phase 2 — Write (Mon PM for Tue slot · Wed for Thu slot · ~3 hr)

| # | Step | Doc to consult |
|---|---|---|
| 8 | **(CW)** Outline per AEO prompt block (H2/H3 = prompts verbatim per Principle 2) | [[InnBlockchain - Content AEO GEO Prompts]] § AEO Drafting Principles |
| 9 | **(CW)** Run the **9-item Per-article AEO/GEO checklist** as drafting gate | Playbook WS7 § Per-article AEO/GEO checklist |
| 10 | **(CW · Vignesh confirms)** Run the **4-item sales-motion tag checklist** — tag mandatory before submitting for review | Playbook WS7 § Per-article sales-motion tag |
| 11 | **(CW)** Apply voice / tone / formatting / citation rules per Style Guide | [[InnBlockchain - Content Style Guide]] |
| 12 | **(CW)** If `[Both]` article: confirm split CTA footer routes correctly to per-persona LP destinations · If regulatory-boundary article: add external-link routing footer per phase rules | [[InnBlockchain - Landing Pages Plan]] + Playbook WS1 routing rules |

## Phase 3 — Pre-publish (Tue AM for Tue slot · Thu AM for Thu slot · 48-hr SLA from draft submit)

| # | Step | Doc to consult |
|---|---|---|
| 13 | **(CW submits · Vignesh reviews)** First draft to Vignesh by EOD day-before-publish — 1 hr Tue AM / Thu AM technical accuracy + regime-leak check (separate from Phase 3 compliance review which only fires Thursday Track B + Cross-Pillar) | Playbook WS7 § Weekly batch workflow |
| 14 | **(CW submits to Vignesh)** If Thursday Track B OR Cross-Pillar: submit to Vignesh for compliance review — 48-hr SLA | Playbook WS13 § Pre-publish review |
| 15 | **(Vignesh executes)** Run the **WS13 compliance review checklist** — 5 regime-leak gates (no regime-mismatch · date-stamped refs · per-segment scope · `[Both]` split CTA · reviewer sign-off logged) | Playbook WS13 § Pre-publish review |
| 16 | **(Vignesh signs · CW receives sign-off)** Compliance sign-off logged before publish — escalate after 2 missed cycles | Playbook WS13 § Pre-publish review |
| 17 | **(CW runs AI skill · Vignesh reviews score)** **CORE-EEAT score check** — run AI scoring skill on the corrected draft (post-Vignesh accuracy + post-compliance, all source-doc corrections applied). Threshold + iteration rule lives in the skill; if score below threshold, loop back to relevant Phase 2 step and re-submit before Phase 3 sign-off is final. **Run AFTER step 16, never before — scoring an uncorrected draft wastes the check.** | CORE-EEAT AI scoring skill *(to be configured · sister tool to [[InnBlockchain - Content AEO GEO Prompts]])* |
| 18 | **(Vignesh approves content for repurposing)** Article content approved post-CORE-EEAT — CW can now run derivative chain. **NOT yet final publish approval** (that's step 20); this is a "content is good enough to repurpose against" gate so derivative work can begin without risking source-article rework | Playbook WS13 § Delegated-work spot-check protocol |
| 19 | **(CW runs derivative chain pre-publish · MPs produce visuals · Designer for high-stakes)** Run **6-step derivative gate sequence below** + structure Tier 1/2 derivative copy (carousel slide outlines · X thread copy · persona variants · LinkedIn long-form · lead magnet body · email nurture excerpt). **If derivative work surfaces source-article corrections** (carousel summary reveals unclear framing · persona variant exposes misalignment · X thread distillation surfaces missing claim) — apply corrections to source article BEFORE step 20 publish. If corrections touch regulatory framing → loop back to Phase 3 step 14/15 (Vignesh re-reviews) before proceeding | [[InnBlockchain - Content Repurposing Plan]] + § Step 19 expanded below |
| 20 | **(MPs schedule · Vignesh approves Mon AM final batch)** Final scheduled batch approved Mon AM — **both source article + derivative assets locked** before publish window opens. Source corrections from step 19 must be applied + re-approved before this step fires | Playbook WS13 § Delegated-work spot-check protocol |

## Step 19 expanded — 6-step derivative gate sequence (every published article)

> [!INFO] Run these 6 gates in order to decide WHICH derivatives to produce
> Each gate is a checkbox. Skip a gate = wasted production (wrong tier · wrong format · wrong audience · wrong CTA). Was previously WS15 § Per-published-article repurposing checklist in the playbook; moved here as the step 19 expansion.

- [ ] **(CW)** **Step 1: Article Tier gate** — Tier 1 / 2 / 3 / 0 per article score (see [[InnBlockchain - Editorial Calendar]])
- [ ] **(CW)** **Step 2: Format Priority gate** — produce all applicable S formats; A formats if Tier 1; B formats if Tier 1 + bandwidth; never C or D
- [ ] **(CW)** **Step 3: Track gate** — `[CN]` → Track A asset family · `[FT]` → Track B asset family · `[Both]` → parallel chains per [[InnBlockchain - Content Repurposing Plan]] § `[Both]` Articles
- [ ] **(CW · Vignesh confirms)** **Step 4: Motion gate** — preserve `[Audit]` / `[Dev]` / `[White-Label]` CTA across every derivative — never mix
- [ ] **(CW + Vignesh)** **Step 5: Persona gate (cross-pillar only)** — per-phase cross-pillar persona coding. *Phase 1 overlay:* C1 Carol-coded · T4-N Sam/Tom-coded · P5-DORA-X compliance-officer + EU NCA · P5-eIDAS-X split with Dec 31 2026 urgency.
- [ ] **(MPs check · Dev confirms LP live)** **Step 6: LP gate** — Tier 0 if destination LP returns 404 → no repurposing. When LP ships, run derivative backfill chain.

## Phase 4 — Publish + Post-publish (publish window + Friday + monthly · ongoing)

| # | Step | Doc to consult |
|---|---|---|
| 21 | **(CW publishes WordPress · MPs publish LinkedIn/X · Vignesh approves at publish window)** Article publish on **innblockchain.com/academy** (CW · WordPress) + LinkedIn/X social amplification (MPs · no link in post body — drop in comment 1) | Playbook WS8 § Posting cadence + § Engagement tactics |
| 22 | **(MPs produce visuals + post · Designer for high-stakes)** Derivative ASSETS ship per LinkedIn output cap cadence — copy was structured in step 19, visuals produced now per Tier 1 full chain / Tier 2 lite / Tier 3 amplify-only | [[InnBlockchain - Cross-Channel Cannibalisation Matrix]] + Playbook WS15 |
| 23 | **(MPs enforce in scheduling)** Verify LinkedIn output cap — ≥48 hr spacing between any two posts about same article · ≤7 posts/wk steady state · cross-pillar Tier 1 distributes across 3 weeks (not launch week) | [[InnBlockchain - Cross-Channel Cannibalisation Matrix]] vectors 3, 4, 6 |
| 24 | **(CW logs Friday · MPs report GA4)** Friday: log per-article metrics — X thread CTR · LinkedIn carousel CTR · time-to-LP-click (<60s median target) · LP form-fill rate (≥2% cold / ≥5% warm) · booked discovery calls attributed per article · **CORE-EEAT post-publish delta** (if score correlates with ranking / citation outcomes, feed back into next-article drafting) | Playbook WS7 § Weekly batch workflow Fri + WS12 § Per-article tracking |
| 25 | **(Vignesh + CW · last Fri of month)** Monthly review — top 3 / bottom 3 articles by booked discovery calls · pattern-match for next month's slot · check Watch-candidate articles (kill at 90 days if zero inbound) · trigger Tier 0 backfill derivatives if LP shipped · **CORE-EEAT score-vs-performance pattern check** (which dimensions correlate with bookings?) | Playbook WS12 § Monthly review + WS15 § Monthly Repurposing Review |

## Hard stops — do not proceed past Phase 2 if any of these are true

- **Destination LP returns 404** (step 2) — Tier 0 rule: blocked until LP ships, no Phase 3/4
- **Regime framing uncertain at a phase boundary** (step 5) — escalate to Vignesh, do not draft under wrong regime
- **Phase-specific validation outstanding** — see per-phase overlay below

### Phase-specific hard stop overlays

#### Phase 1

- **MiCA-boundary regime uncertainty** (step 5) — Phase 1 is RWA-only; if article approaches MiCA boundary (W4 #4, W8 #11), confirm external-link footer routing per Playbook WS1 rather than internal MiCA LP (which is Phase 2)
- **Pain Point 5 cluster article + W2 validation not passed** (per Playbook WS6) — article never activates if validation fails or path not chosen by end of W1

#### Phase 2+

- Phase 2 introduces MiCA-scope LPs; revisit hard-stop list when activated
- Add new phase-specific validation deadlines here as they're set

## CORE-EEAT ordering rule (step 17)

> [!WARNING] Sequence is non-negotiable
> CORE-EEAT scoring MUST run after step 16 (compliance sign-off), not before. Running it on an uncorrected draft wastes the AI-skill call AND can produce a false high score on regime-leaked content. Sequence: Vignesh accuracy review → Vignesh compliance review → corrections applied → **CORE-EEAT score** → content approval (step 18) → CW runs derivative chain pre-publish (step 19 · catches source corrections) → final batch approval (step 20) → publish (step 21).

## Publish-step ownership split

- **CW publishes the WordPress article** on `innblockchain.com/academy`
- **MPs publish the LinkedIn / X social amplification posts**
- **Vignesh approves the Mon AM scheduled batch** before either fires

This 3-way split is structural; preserved across phases unless WordPress/CMS or social-channel stack changes.

## Per-phase publish window

- **Phase 1:** Tue + Thu 13:30 IST (= EU local 10:00 CEST · Phase 1 entirely within CEST window per Playbook). Phase 2 must re-anchor times post-Oct 26 DST switch.
- **Phase 2+:** Update window per current phase's editorial calendar.

## Why this is a separate doc

4-phase / 25-step workflow structure is universal. Per-phase overlays (LP gate names · regulatory boundary articles · validation deadlines · cross-pillar article slugs · publish-window times) are clearly marked so the framework stays reusable while phase-specific anchors live with the current phase's playbook.
