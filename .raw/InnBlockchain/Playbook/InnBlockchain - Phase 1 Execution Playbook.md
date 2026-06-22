---
company:
 - innblockchain
department:
 - marketing
priority: highest
rev: 33
last_revised: 2026-06-22
tags:
 - marketing
 - plan
 - playbook
 - phase-1
 - rwa
---

# ✅ Phase 1 Execution Playbook — InnBlockchain

> [!NOTE] Single source of truth
> Strategic frame (scope, sequencing, KPI rollup, risk register, out-of-scope fences) + operational do-list (~315 checkable tasks across 15 workstreams) for Phase 1 RWA (May 18 → Oct 15, 2026). Persona detail, message templates, article inventory, regulatory framing live in source docs (cited inline). This doc is what gets opened Monday morning + reviewed at phase boundaries.

> [!DANGER] SPEED MODE active
> Compressed timeline to generate LinkedIn leads ASAP. **Honest reset: Vignesh has NO warm FinTech network. Direct warm DMs to FT WealthTech / RWA prospects = same low conversion as cold. Speed Mode leans on three tracks:**
>
> - **WS9.5a — Adjacent-Network Warm Intros** — Vignesh first warm DM to Trioangle clients (real estate, marketplace, commodity verticals = candidate RWA Felix prospects) + tech/crypto connections for 2nd-degree FT WealthTech intros. SP carries forward after positive response. Trioangle active client base ~30 → universe depletes by ~W12–W15.
> - **WS9.5b — Engagement-Led Inbound** — SP runs high-volume strategic commenting (5–10/day) on RWA prospects' posts + reactive DMs + LinkedIn polls.
> - **Structured ABM Track (WS9)** — activates ~W5. SP owns full-cycle with close authority.
>
> **What stays non-negotiable** (compressing these collapses conversion to zero):
> 1. LP Gate 1 (`/solutions/rwa-tokenization`) must be live before any structured DM
> 2. Profile Featured assets + vendor risk pack must exist before any structured DM
> 3. Vendor risk pack must be ready before any FT WealthTech DM (Carol surfaces by call 2)
> 4. **Sample Audit Report PDF must be live (synthetic with explicit disclosure acceptable) before any FT WealthTech DM** — gates $10M+ Sasha + Track B Tom + Carol pre-call trust per [[InnBlockchain - Content Repurposing Plan]]
>
> **What got compressed (realistically):**
> - Feed warmup: 4–6 wks → 3 wks (Profile Recategorisation Accelerator W1–W3)
> - Recommendations: 4-wk stagger → batched 5 requests in 1 week
> - Compliance brief + vendor risk pack + Sample Audit Report: weeks → 5-day focused sprint
> - Structured DM activation: W6 → W5 (1 week earlier, not 2)
>
> **Team capacity model:**
> - **WS15 Tier coverage**: Tier 1 articles get full derivative chain; Tier 2 articles get scaled-back chain (carousel + LinkedIn long-form + X thread, skip video/infographic/persona variants); Tier 3 amplify-only. Enabled by MPs + CW + Designer combined production capacity.
> - **Vignesh load ~15–25 hr/wk marketing** (SP takes calls + outreach; MPs cover posting + SEO + GA4 + visual production; CW takes article + repurposing structuring).

> [!INFO] Source map (every section cites one of these)
> | File | What it informs |
> |---|---|
> | [[InnBlockchain - Landing Pages Plan]] | LP IA, gate sequence, migration map |
> | [[InnBlockchain - ICP - FinTech]] | WealthTech RWA personas (Sam/Tom/Carol), GTM, channels |
> | [[InnBlockchain - ICP - Crypto Native]] | RWA Felix persona, asset-backed founder GTM, channels |
> | [[InnBlockchain - Content Strategy]] | Article inventory, pillars, sales-motion tagging, distribution |
> | [[InnBlockchain - Editorial Calendar]] | Weekly publish schedule, gate dependencies, batch workflow |
> | [[InnBlockchain - Content AEO GEO Prompts]] | Per-article AEO drafting prompts (W1–W22) |
> | [[InnBlockchain - Content Repurposing Plan]] | Repurposing tiers (1/2/3/0), Format Priority (S/A/B/C/D), per-track asset families, Cross-Track Assets (sample audit / research report / newsletter), LinkedIn output cap, dedicated-resource production cadence |
> | [[InnBlockchain - Landing Pages AEO GEO Prompts]] | Per-LP AEO drafting prompts + JSON-LD + listicle targeting + monthly citation probes |
> | [[InnBlockchain - LinkedIn Marketing Strategy]] | Platform setup, algorithm, content cadence, authority |
> | [[InnBlockchain - LinkedIn Outreach Strategy]] | DM sequences, sales nav filters, weekly action plan, eIDAS test |
> | [[LinkedIn Profile Vignesh Content]] | Profile copy + Pre-Publish Hard Gate |
> | [[Recommendation Request Templates]] | 5 recommender categories + ops schedule |
> | [[EU-Compliance-Landscape]] + 14 regulation checklists | Per-segment regime map (RWA = MiFID II/III + Prospectus + DLT Pilot + MAR + Listing Act) |
> | 4 RWA technical explainers (car_rwa_tokenization · rwa_tokenization_explained · erc1400_explained · erc3643_explained) | Background reference for content writers |

---

# 🎯 STRATEGIC FRAME

## Scope Decision

Phase 1 is RWA-only across both tracks. Single primary target. No parallel segment work.

| Track | ICP source | Primary persona |
|---|---|---|
| **A — Crypto Native** | [[InnBlockchain - ICP - Crypto Native]] Segment 1 | RWA Felix — asset-backed founder (real estate, vehicle fleet, commodity, art, private credit). NOT technical; does NOT vet on GitHub. |
| **B — FinTech (WealthTech)** | [[InnBlockchain - ICP - FinTech]] Segment 1 | Sam + Tom + Carol committee at licensed wealth platforms, asset managers, STO platforms |

Regulatory regime, budget floors, geography rule, qualifying criteria, persona detail — see ICP docs and [[EU-Compliance-Landscape]].

---

## Critical Path — Landing Pages Gate Everything

Two LPs gate Phase 1 outreach activation. No DMs run, no outreach CTAs route correctly, until both ship.

| Gate | LP | Unblocks |
|---|---|---|
| 1 | `/solutions/rwa-tokenization` | Track A A1 cluster · CN RWA Felix DM sequences |
| 2 | `/solutions/tokenization` | Track B B1 cluster · FT WealthTech DM sequences |

> [!IMPORTANT] Phase 1 outreach CTAs route only to Gates 1 and 2. Never MiCA.
> RWA ownership tokens are MiFID II financial instruments per Art. 2(4) — see [[EU-Compliance-Landscape]]. A MiCA LP CTA on any RWA-facing surface is a credibility incident.

> [!INFO] No MiCA LP in Phase 1
> Phase 1 is RWA-only; MiCA-scope buyers are Phase 2 ICP. The 4 articles that reference MiCA (#4 *MiCA or MiFID II?* W4, #11 *Prospectus vs MiCA Whitepaper* W8, P5-DORA-X W7, P5-eIDAS-X W13) handle MiCA-self-qualifying readers via **external link to ESMA / national NCA MiCA reference** (one-sentence footer: *"If your token is structured as a MiCA crypto-asset, see [ESMA MiCA page]. Otherwise, MiFID II + DLT Pilot Regime is where we work →"*). MiCA LP build moved to Phase 2 ExchangeTech activation. **Diverges from [[InnBlockchain - Editorial Calendar]] § Gate Sequence row 3 — calendar should be updated to match.**

---

## Phase 1 Cross-Channel Orchestration (SPEED MODE)

Editorial Calendar owns the publish schedule. LinkedIn Outreach Strategy owns sequence mechanics. This table is the **integrated state map** — what activates when, what depends on what.

| Weeks | Publish state | Outreach state |
|---|---|---|
| **W1 (May 18 – 24)** | *Calendar planned:* WL-0 *Own vs. License: 5-Year TCO* (Tue May 19) · #2 *How to Tokenize Real-World Assets* A1 hub (Thu May 21, blocked on LP Gate 1 ship target same day). *Actual status:* LP Gate 1 was still 404 at 2026-05-23 check → A1 hub publish likely slipped; WL-0 may have shipped (no LP dependency). **Audit this week's actual deliverables before proceeding.** | DMs not running. Profile foundations in progress (or should have been). |
| **W2 (May 26 – 31)** | LP build sprint kicks off · profile content publish-ready · feed warmup starts (Profile Recategorisation Accelerator: 2 posts/day for first 2 wks) · compliance brief + vendor risk pack + **Sample Audit Report (synthetic) 5-day sprint** · 5 recommendations requested in batch · WL-0 publish if not done in W1 | **Adjacent-Network + Engagement-Led Tracks activate Day 1.** Trioangle client audit + adjacent intro requests + 5–10 strategic comments/day on RWA prospects' posts. |
| **W3 (Jun 1–7)** | LP Gates 1 + 2 ship by EOD W3 · A1 hub + B1 hub publish · profile publishes when Gate 1 live + Asset 3 (anchor article) pinnable · 3+ recommendations published | Adjacent + Engagement tracks continue. Structured ABM prep: Sales Nav saved searches built, Expandi/Lemlist configured, first batch of 20–30 structured prospects identified for W5 activation. |
| **W4 (Jun 8–14)** | Phase 1 MOFU starts: C1 Carol (W4 Thu) + #4 *MiCA or MiFID II?* (W4 Tue) | Adjacent + Engagement continuing. Profile recategorisation visible (search-appearance signal shifting). Structured DM prep finalised. 5+ recommendations published. |
| **W5 (Jun 15–21)** | #8 *Oracle Design for RWA* + B1-#5 *Tech Stack* | **Structured ABM DMs activate at half cap (8–10/day RWA).** Adjacent + Engagement still running in parallel. |
| **W6–8 (Jun 22 – Jul 12)** | MOFU compliance depth: T4-N Tom · P5-DORA-X · architecture pieces | **Full structured ABM cap (15–20/day).** First discovery calls from Adjacent + Engagement tracks (sent W2–W4, replies clustering W5–W7). First structured-ABM calls expected by W7–W8. |
| **W9–13 (Jul 13 – Aug 16)** | Asset-class deep dives publish (real estate, vehicle, commodity, private credit, art) · P5-eIDAS-X W13 | DM volume steady at 15–20/day. Discovery call cadence at target (3–6/wk combined). |
| **W14–18 (Aug 17 – Sep 20)** | Asset-class deep dives complete · DORA, AML/AMLA, MiFID II classification | Case-study gates begin clearing. Out-of-sequence publish allowed. Internal MVP fallback trigger at W14 if no client deployment. |
| **W19–22 (Sep 21 – Oct 15)** | BOFU + close: lead magnets, Carol piece, WL-1 RWA white-label LP | Track A closes W20 (Oct 4). Track B B1 closes W22 (Oct 15). |

Article IDs and weekly slot detail — [[InnBlockchain - Editorial Calendar]] § Phase 1 Close Schedule.

---

## Funnel Math & KPIs

Per-channel KPIs live in source docs. This is the **pipeline rollup** — how the per-channel ranges combine to test whether the 5-project EU gate clears in Phase 1. Stages flow top → bottom; each row consumes the row above it.

| Stage | Source for range | Phase 1 cumulative (SPEED MODE: W5 → W22 structured ~17 wks + W2–W22 adjacent + engagement-led ~20 wks) |
|---|---|---|
| Adjacent-Network Trioangle direct DMs (1–3/wk × 20 wks) | New WS9.5a | **20–60** |
| Adjacent-Network intro requests (2–4/wk × 20 wks) | New WS9.5a | **40–80** |
| Engagement-Led: substantive comments (5–10/day × ~100 days) | New WS9.5b | **500–1,000** |
| Engagement-Led: reactive DMs (5–15/wk × 20 wks) | New WS9.5b | **100–300** |
| Structured connection requests (W5–W22, 15–20/day × ~85 working days) | [[InnBlockchain - LinkedIn Outreach Strategy]] § 6 | **1,275–1,700** |
| └─ FT WealthTech split (50%) | — | 640–850 |
| └─ CN RWA Felix split (50%) | — | 640–850 |
| Connection accepts — FT WealthTech (30–45%) | § 8 | 190–385 |
| Connection accepts — CN RWA Felix (25–40%) | § 8 | 160–340 |
| **Total structured accepts** | | **350–725** |
| Qualified leads from structured outbound (FT 8–15/mo + CN 8–15/mo × 4 mo) | § 8 Qualified Leads/Month | 64–120 |
| + Qualified leads from Adjacent-Network (2–4/mo × ~5 mo) | New WS9.5a | 10–20 |
| + Qualified leads from Engagement-Led (3–6/mo × ~4 mo at W6+ steady-state) | New WS9.5b | 12–24 |
| + Inbound qualified leads from content + AEO/GEO + LP (4–8/mo × 4 mo) | [[InnBlockchain - Editorial Calendar]] § Metrics Dashboard | 16–32 |
| + Partner-intro qualified leads (2 VC intros/mo × ~50% qualify × 4 mo) | — | 4 |
| **Total qualified RWA leads** | All channels | **106–200** |
| Discovery calls booked (structured 3–6/wk × 17 wks + adjacent + engagement-led) | § 8 + WS9.5 | **65–115** |
| Close rate per discovery call | Unvalidated — first 10 closes validate | 5–10% |
| **EU projects closed in Phase 1** | Target: 5+ to clear geography gate | **3–11** — gate clears at mid close rate. Realistic ASAP gain vs prior baseline (2–10) is +1 close at low end, +1 at high end — modest because no warm FinTech network = no warm-DM advantage to FT WealthTech, the higher-ACV segment. |

> [!WARNING] Numbers are directional, not committed
> Per-channel ranges come from source docs as cited. Win rate is the unvalidated assumption. If any DM sequence drops below 2% reply rate, stop and diagnose before scaling (source-doc rule).

**Per-segment KPI targets** (per [[InnBlockchain - LinkedIn Outreach Strategy]] § 8):

| Metric | FT WealthTech RWA | CN RWA Felix |
|---|---|---|
| Connection accept rate | 30–45% | 25–40% |
| T2 reply rate | ≥5% | 10–20% |
| Positive response rate | 3–8% | 5–10% |
| Discovery calls booked / wk | 2–4 | 1–2 |
| Qualified leads / mo | 8–15 | 8–15 |

**Phase 1 combined target:** 16–30 qualified leads/month + 3–6 discovery calls/week

**Phase 1 exit criteria:**
- ✅ 5 RWA projects closed (FT WealthTech + CN RWA Felix combined)
- ✅ Phase 1 KPI bands consistently hit for 8+ consecutive weeks
- ✅ Editorial Calendar Phase 1 (W1–W21) content published
- ✅ Phase 2 LPs scheduled for ship within 4 weeks

---

## Out of Scope (Phase 1 Fences)

To prevent drift — what this playbook does NOT cover:

- **Pricing** — sales rules, not marketing levers. Marketing routes to the correct floor; doesn't negotiate.
- **Sales execution** — discovery call → scoping → contracting → close runs through Vignesh (no separate sales function). This playbook covers everything up to "discovery call booked"; deal-stage progression, contract terms, and pricing negotiation happen outside it.
- **UK / MENA / US / SEA outbound** — Watch geographies until 5-project EU gate clears.
- **Crypto Products ICP** ($5k–$20k productized clone scripts) — separate ICP, [[InnBlockchain - ICP - Crypto Products]].
- **PR / press / earned media** — Finextra / Banking Technology / PYMNTS guest articles operationalised post-Phase 1.
- **Paid LinkedIn Ads / Google Ads** — organic + outbound only; paid evaluated after Phase 1 attribution baseline.

---

# 📋 OPERATIONAL DO-LIST

## 🕒 Phase 1 Timeline (week-relative — independent of calendar dates)

| Marker | Week |
|---|---|
| Phase 1 duration | 22 weeks (W1 → W22) |
| LP Gate 1 (`/solutions/rwa-tokenization`) target ship | **EOD W3** — 5-day dev sprint |
| LP Gate 2 (`/solutions/tokenization`) target ship | **EOD W3** — parallel sprint |
| Pain Point 5 validation deadline | **End of W2** (assignment deadline at end of W1) |
| **Sample Audit Report PDF (synthetic) sprint** | **EOD W3** — gates FT WealthTech DMs per non-negotiable |
| **Adjacent-Network + Engagement-Led Tracks activate** | **W1 Day 1** — no gate, immediate |
| **Structured ABM DM Track activates** | **W5** — after 3-wk profile recategorisation warmup |
| Full DM cadence (15–20/day cap) | **W6** |
| eIDAS Outbound Test fires | **W13** |
| Track A Phase 1 close | **W20** |
| Track B B1 close | **W22** |

> [!DANGER] LP Gate 1 ship by EOD W3 is THE single point of failure for Speed Mode
> If dev can't ship LP Gate 1 in the 5-day sprint window, structured DMs slip back to W6 (original schedule). Adjacent-Network + Engagement-Led Tracks still run regardless (no LP dependency). Escalate LP delivery to dev as P0 immediately.

---

## 👥 Per-Role Quick Reference

> [!TIP] Start here on Day 1
> If you're new to this playbook, find your role below first — it tells you which workstreams (WS#) you own or contribute to, your top responsibilities, and which sections to read first. Then use the Workstream Map underneath for the full structural view.

| Role | Workstreams you touch | Key responsibilities | Read first |
|---|---|---|---|
| **Dev** | WS1 · WS5 (analytics wiring) | LP Gates 1 + 2 shipped by **EOD W3** (single point of failure for Speed Mode) · email-capture forms · GA4 + UTM wiring · 301 redirects per migration map | WS1 → WS5 § Analytics |
| **CW** — Content Writer | WS7 (primary) · WS2 (per-article AEO drafting) · WS4 (brief structuring + Style Guide voice) · WS8 (post copy) · WS15 (repurposing copy structuring) | Article drafts + AEO sections per editorial calendar · LinkedIn post copy (Vignesh approves) · compliance brief structuring (Vignesh authors regulatory content) · structure Tier 1/2 articles into derivative copy briefs for MPs to design + distribute | WS7 · WS15 · WS2 § Per-article AEO · WS4 |
| **MPs** — Marketing Persons | WS1 (LP on-page SEO + GA4 + email-capture coordination) · WS2 (LP on-page SEO + monthly citation probes) · WS3 (Featured assets ops · Company Page ongoing ops) · WS8 (scheduling + posting + visuals + per-platform formatting) · WS12 (GA4 dashboard + per-format CTR + monthly review prep) · WS15 (posting + AI visual production for derivative chain) | LP on-page SEO + citation probes · GA4 + email-capture coordination with Dev on LP build · Featured asset operations · Company Page ongoing ops · post scheduling + design + distribution across LinkedIn/X/newsletter · AI visual generation for Tier 1 derivative chain + Tier 2 lite chain · GA4 dashboard + weekly metrics report | WS1 · WS2 · WS3 · WS8 · WS15 · WS12 § Analytics |
| **SP** — Sales Person | WS5 (CRM ownership) · WS8 (strategic commenting) · WS9 (Structured ABM, **primary**) · WS9.5a (drafts first warm DM in Vignesh voice · carries thread after positive response) · WS9.5b (Engagement-Led Inbound, **primary**) · WS10 (eIDAS Outbound Test) · WS12 (CRM + pipeline tracking) · WS13 (DM template approval before send) | LinkedIn outbound full-cycle (DM → discovery call → close authority) · CRM hygiene + pipeline weekly reviews · strategic commenting (5–10/day) on RWA prospects · backup discovery call owner · DM template self-approval against compliance checklist | WS9 · WS9.5a · WS9.5b · WS10 · WS12 · WS5 § CRM |
| **Designer** | WS3 (PDF asset design) · WS4 (Compliance brief + Vendor Risk Pack layout) · WS14 (MVP mockup fallback) · WS15 (high-stakes pieces + brand templates) | PDF layout for **Sample Audit Report** (highest-leverage Phase 1 asset), Risk Checklist, Vendor Risk Pack · brand-consistent templates MPs reuse for derivative chain · MVP mockup if W14 fallback fires | WS3 · WS4 · WS15 § High-stakes pieces |
| **Vignesh** — Founder | All workstreams (final-review authority) · Primary on WS3 (profile content + recommendations outreach) · WS4 (compliance self-review) · WS6 (validation) · WS9.5a (first warm DM) · WS11 (Events + Partner/VC intros) · WS13 (compliance review process) | Final compliance + content + DM-template review · Profile content authoring + recommendations outreach · weekly + monthly KPI reviews · events + 1:1 intros (Money20/20 W3, Sibos W22+) · backup-of-backup discovery calls | WS3 · WS4 · WS6 · WS11 · WS13 · Risk Register |

---

## 🗺️ Workstream Map

> [!INFO] Team configuration
> Phase 1 team: **2 Marketing Persons · Sales Person · Content Writer · Designer · Vignesh (founder) · Dev (existing)**. Used throughout this doc: **MPs** = Marketing Persons (both, collectively) · **CW** = Content Writer · **SP** = Sales Person. Designer + Vignesh + Dev written out by name.

| # | Workstream | Owner | Trigger to start | Source of truth |
|---|---|---|---|---|
| 1 | **LP Delivery** | Dev (build) + MPs (on-page SEO + GA4 + email-capture coordination) + Vignesh (oversight + About copy review) | Critical path — start immediately | [[InnBlockchain - Landing Pages Plan]] |
| 2 | **SEO / AEO / GEO** | MPs (LP on-page SEO + monthly citation probes) + CW (per-article AEO drafting) | Per LP — starts when LP shell exists | [[InnBlockchain - Landing Pages AEO GEO Prompts]] · [[InnBlockchain - Content AEO GEO Prompts]] |
| 3 | **LinkedIn Profile + Featured + Recommendations** | Vignesh (profile content + recommendations outreach) + MPs (Featured assets ops) + Designer (PDF asset design) | Pre-publish gate | [[LinkedIn Profile Vignesh Content]] · [[Recommendation Request Templates]] |
| 4 | **Compliance Briefs + Vendor Risk Pack** | Vignesh (regulatory content + self-review) + CW (brief structuring + Content Style Guide voice) + Designer (PDF layout) | Pre-publish gate | [[EU-Compliance-Landscape]] + regulation checklists |
| 5 | **Platform Setup (CRM + Tooling)** | Vignesh + MPs (analytics + email capture) + SP (CRM ownership once onboarded) | Must exist before any DMs | [[InnBlockchain - LinkedIn Marketing Strategy]] § 6 + [[InnBlockchain - LinkedIn Outreach Strategy]] § 6 |
| 6 | **Validation** | Vignesh (default) | TIME-CRITICAL — W2 result deadline | [[InnBlockchain - ICP - FinTech]] Pain Point 5 |
| 7 | **Content Production** | CW (drafts + AEO + structuring + **WordPress publish on innblockchain.com/academy**) + Vignesh (Tue AM technical accuracy review + Thu AM compliance self-review on Track B + Cross-Pillar) + MPs (LinkedIn/X social amplification publish) | Per editorial calendar W1+ | [[InnBlockchain - Content Strategy]] · [[InnBlockchain - Editorial Calendar]] |
| 8 | **LinkedIn Organic (feed + newsletter)** | Vignesh (authors all posts) + MPs (schedules + posts + visuals + company page) + SP (strategic commenting from W8) | Feed warm-up needed pre-outreach | [[InnBlockchain - LinkedIn Marketing Strategy]] |
| 9 | **LinkedIn Outbound — Structured ABM** | **SP** | Compressed: Outreach Readiness Gate clears ~W5 | [[InnBlockchain - LinkedIn Outreach Strategy]] |
| **9.5a** | **Adjacent-Network Warm Intros** | SP drafts in Vignesh voice + sends from own profile · Vignesh per-DM approves (24-hr SLA) · Vignesh sends personally when relationship calls for it · SP carries forward after positive response | W1 Day 1 | This playbook WS9.5a |
| **9.5b** | **Engagement-Led Inbound** | **SP** | W1 Day 1 | This playbook WS9.5b |
| 10 | **eIDAS Outbound Test** | SP | W13 (~Aug 2026) | [[InnBlockchain - LinkedIn Outreach Strategy]] § 7a |
| 11 | **Events + Partner / VC Intros** | Vignesh | Money20/20 Europe Jun 2–4 (attendance + meetings); pursue Sibos Oct + Money20/20 Jun 2027 for speaking | ICP docs § Channel Strategy |
| 12 | **Pipeline + CRM + Measurement** | SP (CRM ownership + pipeline tracking) + MPs (GA4 dashboard + per-format CTR + monthly review prep) + Vignesh (weekly + monthly reviews) | Must exist before any DMs | [[InnBlockchain - LinkedIn Outreach Strategy]] § 8 |
| 13 | **Compliance Review Process** | Vignesh (self-review with structured checklist) + spot-checks on MPs visual output + SP DM template approval before send | Every Thursday Phase 1 article + Cross-Pillar | [[InnBlockchain - Editorial Calendar]] § Weekly Batch Workflow |
| 14 | **Case Study Capture** | Vignesh + delivery team + Designer (MVP mockup if W14 fallback triggers) | Every new client engagement | [[InnBlockchain - Editorial Calendar]] § Gate-dependent + Override |
| **15** | **Content Repurposing** | CW (copy structuring) + MPs (AI visual generation + posting + distribution) + Designer (high-stakes pieces) + Vignesh (final review) | Per published article + Cross-Track Assets standalone | [[InnBlockchain - Content Repurposing Plan]] |

---

# 🟥 PHASE A — Pre-Flight Foundations (target: completed by ~W6)

**No LinkedIn DMs run until every box in this section is checked.** Per [[InnBlockchain - LinkedIn Outreach Strategy]] Outreach Readiness Gate.

---

## WS1 — Landing Page Delivery (CRITICAL PATH)

> Source: [[InnBlockchain - Landing Pages Plan]] · [[InnBlockchain - Editorial Calendar]] § Gate Sequence

### Pre-flight verification
- [ ] **(Dev)** **Verify current LP status** of both Phase 1 outreach-gating LPs: `/solutions/rwa-tokenization` (Gate 1) + `/solutions/tokenization` (Gate 2). If either 404, all dependent tasks are blocked. *(MiCA LP dropped from Phase 1 scope — see Critical Path callout.)*

### Gate 1 — `/solutions/rwa-tokenization` (Crypto Native RWA Felix)
- [ ] **(Dev)** Build LP shell per [[InnBlockchain - Landing Pages Plan]] § Web3 & DeFi Solution Sub-Pages
- [ ] **(Dev + Vignesh review)** Hero H1 + H2 match the persona language in [[LinkedIn Profile Vignesh Content]] About section (RWA + MiFID II/III + Prospectus + DLT Pilot Regime + MAR + asset-backed founders — **NOT** RWA + MiCA)
- [ ] **(Dev)** Body copy follows the 13 Drafting Principles in [[InnBlockchain - Landing Pages AEO GEO Prompts]] § AEO Drafting Principles
- [ ] **(Dev)** FAQPage JSON-LD with vendor-evaluation prompts (Principle 3)
- [ ] **(Dev)** Single proof block above the fold (Principle 11)
- [ ] **(Dev)** Hosts the gated RWA Tokenization Risk Checklist PDF download (Featured asset 1) — primary CTA "Download Risk Checklist" with email capture
- [ ] **(Dev)** Secondary CTA: discovery call (Calendly)
- [ ] **(Dev)** 301 redirects from retired pages per [[InnBlockchain - Landing Pages Plan]] § Existing Pages Migration Map (`/token-development` → here)

### Gate 2 — `/solutions/tokenization` (FinTech WealthTech Sam/Tom/Carol)
- [ ] **(Dev)** Build LP shell per [[InnBlockchain - Landing Pages Plan]] § FinTech Solution Sub-Pages
- [ ] **(Dev + Vignesh review)** Hero H1 + H2 in WealthTech CTO/CCO language (MiFID II + Prospectus + DLT Pilot + MAR + Listing Act)
- [ ] **(Dev)** Body copy follows the 13 Drafting Principles (same as Gate 1)
- [ ] **(Dev)** FAQPage JSON-LD
- [ ] **(Dev)** Vendor risk pack — request mechanism: email-capture form ("Request vendor risk pack") triggers manual delivery within 24 hrs (consistent with WS4 "delivered on request" SLA)
- [ ] **(Dev)** Sample audit report (anonymised) — same email-capture pattern
- [ ] **(Dev)** CTA: discovery call + "Request vendor risk pack"
- [ ] **(Dev)** 301 redirects: `/sto-development` + `/token-development` (STO portion) → here

### External-link routing for MiCA-boundary articles (replaces former Gate 3)
- [ ] **(Dev)** For W4 #4 *MiCA or MiFID II?* and W8 #11 *Prospectus vs MiCA Whitepaper* — add footer routing: *"If your token is structured as a MiCA crypto-asset, see [ESMA MiCA registry] or your national NCA. Otherwise, MiFID II + DLT Pilot Regime is where we work →"* with link to Gate 1 (CN) or Gate 2 (FT) based on track tag
- [ ] **(Dev)** For W7 P5-DORA-X and W13 P5-eIDAS-X — no MiCA-destination handling needed; CTAs route to Gates 1+2 (the regulated FI / RWA audience these articles serve)

### Cross-LP work
- [ ] **(Dev)** **Audit all retired URLs:** confirm 301 redirects per [[InnBlockchain - Landing Pages Plan]] § Existing Pages Migration Map
- [ ] **(Dev)** **Home page (`/`) routing:** add RWA tile pointing to Gate 1 + WealthTech tile pointing to Gate 2
- [ ] **(Vignesh)** **About page:** ensure no claims contradict [[LinkedIn Profile Vignesh Content]] Pre-Publish Hard Gate (7+ years, 15+ protocols audited zero critical, EU FinTech focus)
- [ ] **(Dev)** **Sitemap.xml updated** so all new LPs are indexable

### Vignesh Pre-Launch LP Sign-Off Checklist (extracted to [[InnBlockchain - LP Sign-Off Checklist]])

> Cross-phase framework extracted from this playbook → see [[InnBlockchain - LP Sign-Off Checklist]] for the full 8-gate checklist + escalation rules + post-launch verification. Phase 1 fires this checklist for Gate 1 + Gate 2 (before EOD W3) + eIDAS gated PDF page (before W13). 48-hr SLA · sign-off logged before launch · Vignesh blocks launch on any regulatory leak.

---

## WS2 — SEO / AEO / GEO (per LP)

> Source: [[InnBlockchain - Landing Pages AEO GEO Prompts]] · [[InnBlockchain - Content AEO GEO Prompts]]

### For each Phase 1 LP (Gates 1 + 2)
- [ ] **(MPs)** Pull the per-LP AEO/GEO prompts from [[InnBlockchain - Landing Pages AEO GEO Prompts]] § matching LP block
- [ ] **(MPs draft → Dev implements)** Hero H1 + H2 ≈ vendor-evaluation prompts verbatim (Principle 2)
- [ ] **(MPs draft → Dev implements)** 150-word commercial answer above the fold (Principle 1)
- [ ] **(MPs draft → Dev implements)** FAQPage JSON-LD with the prompt set (Principle 3)
- [ ] **(MPs)** Cite specifics: pricing floor ($20k+), timelines, tech stack, operating history (Principle 4)
- [ ] **(MPs)** Name the tech, standards, deliverables — never name competitors (Principle 5)
- [ ] **(MPs)** Positive framing — write what InnBlockchain *is*, not what it isn't (Principle 6)
- [ ] **(MPs)** Productized language — "white-label / ready-to-launch / productized" — never "clone" (Principle 7)
- [ ] **(MPs)** Date-stamp regulation (e.g., "MiFID II — as of 2026"), version-stamp tech (e.g., "Solidity 0.8.x") (Principle 8)
- [ ] **(MPs)** Markdown comparison tables — not images (Principle 9)
- [ ] **(MPs)** Persona-aligned vocabulary per Principle 10 track-tag rules
- [ ] **(MPs)** CTA matches the prompt's funnel stage (Principle 12)

### Per-LP citation health
- [ ] **(MPs)** Run monthly AI citation probe per [[InnBlockchain - Landing Pages AEO GEO Prompts]] § Monthly AI Search Citation Probe — Perplexity / ChatGPT / Gemini sample queries
- [ ] **(MPs identify · CW drafts competing piece)** Per [[InnBlockchain - Landing Pages AEO GEO Prompts]] § Listicle target inventory: identify the listicle pages outranking InnBlockchain on commercial-investigation queries; pursue inclusion or write a competing listicle on InnBlockchain.com

---

## WS3 — LinkedIn Profile + Featured Assets + Recommendations

> Source: [[LinkedIn Profile Vignesh Content]] · [[Recommendation Request Templates]] · [[InnBlockchain - LinkedIn Marketing Strategy]] § 2 Platform Setup

### Personal profile setup
- [ ] **(Vignesh)** Creator Mode enabled
- [ ] **(Vignesh)** Custom URL claimed: `linkedin.com/in/vigneshpalanivel`
- [ ] **(Vignesh)** Profile language: English only
- [ ] **(Vignesh)** "Open to" set for "Providing services"

### Profile content (publish-ready per [[LinkedIn Profile Vignesh Content]] Pre-Publish Hard Gate)
- [ ] **(Vignesh)** **Headline** — 207-char Phase 1 version pasted (RWA tokenization + MiFID II/III + Prospectus + DLT Pilot first)
- [ ] **(Vignesh + Designer)** **Banner** — uploaded, no "Turn Your Business Ideas Into Reality" / "200+ Mentored" legacy text
- [ ] **(Vignesh)** **About** — 2,508-char draft pasted with `[INSERT REFERENCE]` placeholders filled (at least 2 of 3) OR fallback "Currently engaged with EU WealthTech and RWA founders in [vertical]" line
- [ ] **(Vignesh)** **InnBlockchain Experience entry** — start year, EU city, populated placeholders, skills capped at top 9 to avoid display truncation
- [ ] **(Vignesh)** **Skills section** — top 3 pinned: RWA Tokenization · Smart Contract Security · MiFID II/III Compliance. Remainder ordered per [[LinkedIn Profile Vignesh Content]] § Skills

### Profile claim verification (Pre-Publish Hard Gate)
- [ ] **(Vignesh)** "7+ years building blockchain infrastructure" verified against existing LinkedIn Experience
- [ ] **(Vignesh)** "15+ protocols audited, zero critical findings on production" count verified
- [ ] **(Vignesh)** Segment spread verified — 15+ audits must span ≥2 of (asset tokenization · regulated exchanges · DeFi lending). If concentrated in 1 segment only, revise to name only that one
- [ ] **(Vignesh)** Operational capacity verified — "We can start next week" must reflect current team availability; revise to honest timeframe if booked 3+ weeks out
- [ ] **(Vignesh)** About CTA link (`innblockchain.com/solutions/rwa-tokenization`) does NOT 404 (blocked on WS1 Gate 1)

### Social profile setup — LinkedIn Company Page · X personal · GitHub · Solodit

> Cross-phase framework → see [[InnBlockchain - Social Profile Setup]] for full setup + completeness audit + ongoing-ops for each surface. **Phase 1 overlay:** all four surfaces activate W1 Day 1 · LinkedIn Company Page = `linkedin.com/company/innblockchain` · X handle `@vigneshpalanivel` (or equivalent) · GitHub `github.com/innblockchain` · Solodit profile claim with 2–3 historical findings · corporate X handle NOT created (X has no structural Company Page concept).

### Brand system foundation (Designer W2–W3 sprint — pre-Featured-asset gate)

> [!INFO] Templates must exist before MPs produce derivatives at consistent quality
> The toolkit ([[InnBlockchain - Content Repurposing Design Toolkit]]) defines WHICH tools to use; the brand system defines WHAT the templates look like. Required before MPs ramp on AI visual production in WS15.

#### Required artifacts (Designer owns build · MPs verify before WS15 ramp)
- [ ] **(Designer)** Typography system — display font · body font · scale (h1–h6 + body + caption) · line-height rules
- [ ] **(Designer)** Color palette — primary · secondary · accent · semantic (success / warning / error) · neutral scale · usage rules
- [ ] **(Designer)** Logo usage rules — clearspace · minimum size · color variants · forbidden treatments (no shadows · no rotation · no stretching)
- [ ] **(Designer)** Canva carousel templates — LinkedIn 10-slide + 7-slide variants · title slide + summary slide mandatory
- [ ] **(Designer)** Canva quote-graphic + single-image templates — LinkedIn 1:1 · LinkedIn 4:5 vertical · X 1:1
- [ ] **(Designer)** Beautiful.ai lead magnet template — title page · TOC · body content · CTA back-cover
- [ ] **(Designer)** Descript caption + lower-third style — font · color · positioning
- [ ] **(Designer)** LinkedIn profile banner template — text variants for Phase 1 · Phase 2 · post-Phase 1 milestones
- [ ] **(Designer)** Midjourney hero image style guide — prompt patterns + forbidden cliché list (no Bitcoin logos · no gold coins · no matrix code · no "fake businesspeople shaking hands")
- [ ] **(MPs verify)** Brand handoff: MPs can independently produce 1× carousel + 1× quote graphic + 1× lead magnet using only templates (no ad-hoc design)

> [!IMPORTANT] Storage + handoff rule
> Templates live in shared Canva Pro Team library + Figma file (Designer-owned). All new template requests routed to Designer — **no ad-lib Canva templates by MPs**. Brand drift is one of the failure modes in [[InnBlockchain - Content Repurposing Design Toolkit]] § Failure modes.

### Featured assets — chronological build order

> [!IMPORTANT] Profile publish is blocked on LP Gate 1
> Asset 3 (anchor article) requires a Phase 1 Track A article to be published first. Article publish requires LP Gate 1 (`/solutions/rwa-tokenization`) to be live. So the dependency chain is: **LP Gate 1 live → W1 Thu A1 hub publishes → Asset 3 pinnable → Profile publish-gate cleared**. Profile cannot publish ahead of LP Gate 1.

> [!NOTE] LinkedIn Featured slot capacity
> LinkedIn Featured shows ~3–4 items prominently. Phase 1 commitment: Assets 1, 2, 3 pinned at publish (= 3 slots). Asset 4 (eIDAS) pins at W13 — at that point either rotate out Asset 3 (anchor article, now older) or accept 4-item Featured (LinkedIn allows; second row is less visible).

**Phase 1 publish-required (W2–W3 sprint — both committed Featured pins)**
- [ ] **(Designer builds · Vignesh content review · MPs upload + pin)** **Asset 1 — RWA Tokenization Risk Checklist for Asset-Backed Founders** (PDF, 5–7 pages, non-technical). Regime framing: MiFID II/III + Prospectus + DLT Pilot Regime + MAR + EU Listing Act — **NOT MiCA**. Pinned to Featured. Hosted as gated download on Gate 1 LP.
- [ ] **(Designer builds · Vignesh content + compliance sign-off · MPs upload + pin)** **Asset 2 — Sample Audit Report / Sample Deliverable PDF** (Cross-Track Asset; exempt from per-article rules per [[InnBlockchain - Content Repurposing Plan]]). **Single highest-leverage Phase 1 production item** — gates $10M+ Sasha + Track B Tom + Carol pre-call trust. Built W2–W3 sprint. **Pinned to Featured (committed, not optional)**. Hosted on Gate 2 LP as gated download.
 - **Phase 1 production form: synthetic reference report** (no portfolio yet) — methodology + findings drawn from publicly available exploit research + InnBlockchain methodology.
 - **Mandatory front-matter disclosure: "Sample reference report — methodology and findings drawn from publicly available exploit research; no client engagement."** Synthetic-without-disclosure undercuts Carol-defensibility and creates reputational risk.
 - **Replan trigger:** when first delivered engagement allows redacted real audit (likely mid-to-late Phase 1 if WL-1 or B1 client signs) → redacted real audit supersedes synthetic; synthetic stays archived.
 - **Compliance reviewer sign-off mandatory** regardless of synthetic vs real source.
 - **Annual refresh** (anchor tied to first-delivered-engagement timing per Repurposing Plan, NOT calendar — explicitly separated from research-report sprint window).

**Phase 1 publish-required (W3 — LP Gate 1 dependent)**
- [ ] **(CW drafts article in WS7 · MPs pin to Featured)** **Asset 3 — 1 anchor article from Phase 1 W1–W3 Track A backlog** — pinned to Featured once published (blocked on LP Gate 1 → article publish chain)

**Phase 1 mid-point (W11–W12 build, W13 pin)**
- [ ] **(CW drafts copy · Designer lays out PDF · Vignesh compliance review · MPs pin)** **Asset 4 — eIDAS 2.0 / EUDI Wallet Relying-Party Brief** (PDF, 3–4 pages). Built W11–W12. Pinned at W13 when the cross-cutting eIDAS article publishes. Required before §7a eIDAS Outbound Test fires. At W13, decide: rotate out Asset 3 (older anchor article) OR keep 4-item Featured.

### Recommendations pipeline + Recommender filter (extracted to [[InnBlockchain - Recommendations Outreach Pipeline]])

> Cross-phase framework extracted from this playbook → see [[InnBlockchain - Recommendations Outreach Pipeline]] for the SPEED MODE batched cadence + standard 4-week stagger + 5-category outreach pattern + Recommender DQ filter + activation gates (pre-publish 2–3 · pre-structured-DM 5 · Sasha-grade 7–8). **Phase 1 overlay:** target 3+ published by W3 EOD · 5+ before structured DMs activate W5.

---

## WS4 — Compliance Briefs + Vendor Risk Pack

> Source: [[EU-Compliance-Landscape]] + 14 regulation checklists ([[mifid2-checklist]], [[mifid3-checklist]], [[mifir-checklist]], [[prospectus-checklist]], [[dlt-pilot-checklist]], [[mar-checklist]], [[eu-listing-checklist]], [[dora-checklist]], [[mica-checklist]], [[aml-checklist]], [[tfr-checklist]], [[ccd2-checklist]], [[eidas2-checklist]], [[ipr-checklist]], [[gdpr-checklist]])

### Phase 1 primary compliance brief — required before profile publish
- [ ] **(Vignesh drafts regulatory content + self-reviews · CW structures + applies Style Guide voice · Designer lays out PDF)** **MiFID II/III + Prospectus + DLT Pilot Regime + MAR + EU Listing Act brief** built (PDF, ~6–10 pages). Pull regime detail from:
 - [[mifid2-checklist]] · [[mifid3-checklist]] · [[prospectus-checklist]] · [[dlt-pilot-checklist]] · [[mar-checklist]] · [[eu-listing-checklist]]
- [ ] **(Vignesh)** Brief framing matches profile About copy (Carol on an RWA prospect judges by this asset)
- [ ] **(SP on request · MPs maintain link)** Brief is delivered on request (linked from About: "available on request")
- [ ] **(MPs)** Brief stored in version-controlled asset library

### Vendor risk pack — required before profile publish
- [ ] **(Vignesh)** Company overview + ownership structure
- [ ] **(Vignesh)** ISO 27001 status (achieved / in-progress / not pursued — be honest)
- [ ] **(Vignesh)** SOC 2 status
- [ ] **(Vignesh)** Data residency + processing statement
- [ ] **(Vignesh + Designer)** Sample audit report (anonymised, regulator-grade) — at least one available
- [ ] **(Designer assembles · Vignesh review)** Pack assembled as a single PDF or zipped folder
- [ ] **(SP + MPs)** Deliverable within 24 hours of any vendor risk request

### Phase 1 cross-cutting briefs (built mid-phase for cross-cutting articles)
- [ ] **(Vignesh drafts regulatory content + self-reviews · CW structures + applies Style Guide voice · Designer lays out PDF)** **DORA brief** — for W7 P5-DORA-X cross-cutting article. Pull from [[dora-checklist]]. Cross-references MiFID II + DLT Pilot regime stack.
- [ ] **(Vignesh drafts regulatory content + self-reviews · CW structures + applies Style Guide voice · Designer lays out PDF)** **eIDAS 2.0 brief** — for W13 P5-eIDAS-X cross-cutting article. Built W11–W12. Pull from [[eidas2-checklist]]. Doubles as Featured Asset 4 + eIDAS outbound test landing-page download.

### Briefs explicitly DEFERRED to Phase 2/3 (do NOT build in Phase 1)
- MiCA CASP brief — Phase 2 when `/solutions/regulated-exchange` ships
- PSD3 + eIDAS WalletTech brief — Phase 2 when `/solutions/fintech-wallets` ships
- CCD2 + EU AI Act LendTech brief — Phase 3+ when `/solutions/defi-lending` ships
- On-inquiry delivery acceptable until then. **Do NOT ship a generic "MiCA compliance brief"** — that's the misframe that loses RWA prospects.

---

## WS5 — Platform Setup (CRM + Tooling) — SPEED MODE 5-day sprint

> Source: [[InnBlockchain - LinkedIn Marketing Strategy]] § 6 Tools Stack · [[InnBlockchain - LinkedIn Outreach Strategy]] § 6 Outreach Automation

> [!IMPORTANT] Complete all WS5 + WS3 + WS4 by EOD W3 (2026-06-07)
> Structured DM activation W4 (Jun 8) requires the full platform stack operational. Warm-Network Track (WS9.5) only needs Sales Nav (to identify warm prospects) + manual CRM tracking — can run with reduced infrastructure.

### Required before structured DMs (W4 activation gate)
- [ ] **(Vignesh procures · SP uses)** **LinkedIn Sales Navigator** subscription active (Day 1 — also needed for WS9.5 warm-network target identification)
- [ ] **(SP)** **Saved searches per RWA track** created:
 - FinTech WealthTech filter (Title + Industry + Company size + EU geo + RWA/MiFID II keywords — NO MiCA keyword per [[InnBlockchain - LinkedIn Outreach Strategy]] § 2.1)
 - CN PropTech / asset-backed Felix filter (Real Estate / Commodities industry + EU geo + asset tokenization keywords)
- [ ] **(SP)** **Outreach tooling** configured (Expandi.io OR Lemlist) with personalisation variables
- [ ] **(SP)** **CRM/pipeline tracker** live (Zoho or equivalent) with T1–T5 sequence state per prospect
- [ ] **(SP)** Pipeline fields: Connected · Replied · Qualified · Call Booked · Closed · Parked
- [ ] **(Vignesh procures · MPs use)** **Shield Analytics** subscription for LinkedIn deep content analytics (optional but high-leverage)
- [ ] **(SP)** **Calendly** discovery call booking link live + tested

### Analytics + lead-capture infrastructure (funnel math depends on these)
- [ ] **(MPs configure · Dev wires events)** **GA4 configured** on innblockchain.com — track LP page-views, time-on-page, scroll depth, CTA clicks, form submissions. Required for time-to-LP-click <60s + LP form-fill rate ≥2% targets in WS12. Set up GA4 transition events specifically for `/solutions/rwa-tokenization` and `/solutions/tokenization`.
- [ ] **(MPs choose tool · Dev integrates with CRM)** **Email capture mechanism** live — for gated PDF downloads (RWA Risk Checklist, eIDAS brief, vendor risk pack). Options: native CMS form (WordPress / framework), ConvertKit, Mailchimp, or HubSpot Forms. Whatever's chosen must integrate with CRM (auto-create lead record on form submit) and trigger the manual delivery workflow within 24 hrs.
- [ ] **(SP)** **CRM data hygiene + import** — if any historical LinkedIn contacts / prior discovery calls / referral conversations exist outside Zoho, import + tag with source. Avoids re-outreaching prior contacts and protects relationship credibility.

### Discovery call infrastructure
- [ ] **(SP drafts · Vignesh review)** **Discovery call prep template** built — what Vignesh opens with for each track:
 - **CN RWA Felix:** plain-language opener about their asset class; do NOT lead with technical depth or GitHub; reference call with similar-asset founder ready to offer
 - **FT WealthTech Sam:** ROI + zero-incident framing; case studies / audit reports ready; ask "who handles vendor risk approval?" by minute 15
 - Vendor risk pack + sample audit report + segment-specific compliance brief queued for instant delivery if Carol surfaces
- [ ] **(SP)** **Pre-call checklist** — per prospect: review their LinkedIn for trigger / company news / regime alignment; pull any prior touchpoints from CRM

### Vignesh calendar time-blocked — founder-only work
- [ ] **(Vignesh)** **Daily 15–30 min** for final review of MPs / SP / CW output (per SLA: 24 hr article review, 24 hr visual review, 48 hr DM template review)
- [ ] **(Vignesh)** **Daily ≤30 min** strategic comments on highest-leverage ICP posts (SP does the volume; Vignesh contributes to keep founder voice in the feed)
- [ ] **(Vignesh)** **1–2 discovery call slots/wk** for FT WealthTech > $100k OR Carol vendor review escalations (SP takes the rest)
- [ ] **(Vignesh)** **Weekly Fri review** 60 min — pipeline tracker + per-channel KPIs + risk register + team blockers
- [ ] **(Vignesh)** **Monthly review** last Fri 2 hr — top/bottom 3 articles · 5-project EU gate progress · capacity check (MP utilization, content writer pace, SP close rate)
- [ ] **(Vignesh · ≤15 min/day)** **WS9.5a per-DM approval** — review SP drafted DMs (Trioangle + adjacent network) + sign off within 24 hr SLA. Vignesh sends personally only when relationship calls for it (~0–1 DMs/wk personal time1–3/wk).
- [ ] **(Vignesh)** **WS6 Pain Point 5 interviews** (if Path A chosen) — 3–5 calls during W2 only
- [ ] **(Vignesh)** **Event execution** — Money20/20 Europe (~W3) · Sibos (~W19–W22) · RWA Summit (block 1–2 days per event)
- [ ] **(Vignesh)** **Bi-weekly newsletter writing block** (if newsletter activated W10+)

---

## WS6 — Validation (W2 deadline)

### Pain Point 5 (AI + Blockchain) validation — result by end of W2

> [!IMPORTANT] Two paths
> **Path A — Validate:** Vignesh runs 3–5 phone or LinkedIn DM interviews with EU WealthTech / LendTech Sams during W2. Ask one question: *"Are you deploying AI for credit/fraud/KYC decisions, and do you have a tamper-proof audit trail requirement under EU AI Act?"*
>
> **Path B — Skip:** mark cluster permanently dropped, log in [[InnBlockchain - Editorial Calendar]] § Replan Triggers, free up the 5 article slots that were blocked-pending-validation. No retroactive recovery.
>
> **Decide Path A or B by end of W1. Silent miss = worst outcome.**

- [ ] **(Vignesh)** **Owner named end of W1** (Vignesh default)
- [ ] **(Vignesh)** **DECIDE Path A or Path B by end of W1**
- [ ] **(Vignesh)** If Path A: Vignesh runs 3–5 interviews during W2 — result by end of W2
- [ ] **(Vignesh)** If Path A passes (≥3/5 confirm pain): unlock AI + Blockchain Track B cluster (5 articles) + World Summit AI event positioning
- [ ] **(Vignesh)** If Path A fails OR Path B chosen: log "UNVALIDATED — AI+Blockchain cluster dropped from Phase 1" in [[InnBlockchain - Editorial Calendar]] § Replan Triggers; the 5 articles never activate (no redirect needed — they aren't in the locked W1–W22 calendar)

---

# 🟧 PHASE B — Active Execution (W4 onwards, once Phase A complete)

---

## WS7 — Content Production (Editorial Calendar Execution)

> Source: [[InnBlockchain - Content Strategy]] · [[InnBlockchain - Editorial Calendar]] · [[InnBlockchain - Content AEO GEO Prompts]]

### Weekly batch workflow (per [[InnBlockchain - Editorial Calendar]] § Weekly Batch Workflow)
| Day | Task | Owner | Time |
|---|---|---|---|
| Mon AM | Research + outline both articles for the week · pre-launch tease post | CW | 2 hr |
| Mon PM | Tuesday article first draft | CW | 3 hr |
| Tue AM | Technical accuracy + regime check review | Vignesh | 1 hr |
| **Tue 13:30 IST** | **PUBLISH article #1 on innblockchain.com/academy (WordPress)** + LinkedIn/X social amplification | CW publishes WordPress · MPs publish LinkedIn/X · Vignesh approves Mon AM batch | 30 min |
| Wed | Thursday article first draft | CW | 3 hr |
| Thu AM | **Compliance review** — Phase 1 Thursday slot is Track B by default, so compliance reviews **every Thursday article + W4/W7/W13 Cross-Pillar pieces**. 48-hr SLA. | Vignesh (self-review) | 1 hr |
| **Thu 13:30 IST** | **PUBLISH article #2 on innblockchain.com/academy (WordPress)** + LinkedIn ABM amplification | CW publishes WordPress · MPs publish LinkedIn/X · Vignesh approves Mon AM batch | 30 min |
| Fri | Repurpose + measure: X threads, LinkedIn quote graphics, log metrics | CW (structure) + MPs (produce + post) | 2 hr |

**Total: ~13 hrs/wk per writer.** Workable with CW + Vignesh (Tue AM accuracy review + Thu AM compliance self-review on Track B + Cross-Pillar).

### Per-Article Production Checklist (extracted to [[InnBlockchain - Per-Article Production Checklist]])

> Cross-phase framework extracted from this playbook → see [[InnBlockchain - Per-Article Production Checklist]] for the full 25-step / 4-phase walk-through (Pre-write · Write · Pre-publish · Publish + Post-publish) + hard stops + CORE-EEAT ordering rule + publish-step ownership split. CW master sequence — open once per article.
>
> **Phase 1 hard-stop overlays** (in the framework's "Phase-specific overlays" section): MiCA boundary check at step 5 (Phase 1 is RWA-only) · Pain Point 5 cluster validation per WS6 (W2 deadline) · regulatory-boundary articles route via external ESMA link footer (per WS1) not internal MiCA LP.

### Per-article AEO/GEO checklist + Per-article sales-motion tag (extracted to [[InnBlockchain - Per-Article Pre-Publish Checklists]])

> Cross-phase framework extracted from this playbook → see [[InnBlockchain - Per-Article Pre-Publish Checklists]] for the 9-item AEO/GEO drafting gate + 4-item sales-motion tag. Both fire at Phase 2 of the Per-Article Production Checklist (steps 9 + 10).

### CW Content Style Guide (extracted to [[InnBlockchain - Content Style Guide]])

> Cross-phase framework → see [[InnBlockchain - Content Style Guide]] for full voice / tone / formatting / source citation / title-meta / alt-text / internal linking / per-track voice modifiers. Phase 1 per-track modifiers (RWA Felix · Sam/Tom/Carol · `[Both]`) documented inline in the framework doc.

### Phase 1 W1–W22 article-by-article execution

> Article schedule (40 articles · W1–W22) is canonical in [[InnBlockchain - Editorial Calendar]] § Phase 1 Close Schedule. Per-article AEO prompts in [[InnBlockchain - Content AEO GEO Prompts]] § Week-by-Week. Owner pattern for every article: **CW** drafts (Mon/Wed) · **Vignesh** reviews (Tue AM accuracy + Thu AM compliance on Track B + Cross-Pillar) · **CW publishes WordPress on innblockchain.com/academy** · **MPs publish LinkedIn/X social amplification** (Tue/Thu 13:30 IST).

### Out-of-sequence overrides (publish reactively — bumps next slot)
- [ ] **(CW · Vignesh review)** Case Study A — *How We Tokenized [Asset Class] for [Client]* → when client deployment + screenshot rights clear
- [ ] **(CW · Vignesh review)** Case Study B — *WealthTech / RWA Platform Build* → same gate
- [ ] **(CW · Vignesh review)** B1-#18 Carol — already scheduled W21 Thu by default. **Override only if a live B1 deal hits procurement before W21** — in that case, publish early and bump the W21 Thu slot back to its scheduled date (slot stays B1-#18 Carol — pre-publishing doesn't free a new slot).
- [ ] **(CW · Vignesh review)** Sasha trust pieces (Severity Framework + Audit Report Evaluation Guide) → any $10M+ protocol enters discovery
- [ ] **(CW · Vignesh review)** AI audit overlay article → any AI-coded smart contract project enters pipeline
- [ ] **(CW · Vignesh review)** Paulo champion piece → any deal stuck on "external team slows us down" objection

### Overflow queue — kill at 90-day review if no inbound
- [ ] **(Vignesh decides at 90-day review)** B1-#4 *Utility NFTs in FinTech* ⚠️
- [ ] **(Vignesh decides at 90-day review)** B1-#11 *Tokenized US Treasuries as DeFi Collateral* ⚠️
- [ ] **(CW · Vignesh review)** B1 Post-Launch *Expanding Your RWA Platform to New Markets* (gated on first B1 client live)

---

## WS8 — LinkedIn Organic (Feed + Newsletter)

> Source: [[InnBlockchain - LinkedIn Marketing Strategy]]

> [!INFO] Ownership split
> - **Vignesh** authors all personal-feed posts (voice = founder)
> - **MPs** schedule + post (LinkedIn native scheduler) + manage company page (3×/wk) + coordinate Tue/Thu publish-day amplification + produce visual assets needed for feed posts (graphics, video clips)
> - **SP** (from W8) handles 5–10 strategic comments/day on RWA prospects' posts (WS9.5b primary track); Vignesh contributes ≤30 min/day to keep founder voice in the feed

### Posting cadence (Vignesh personal — 4–5×/wk per § 4 Content Cadence)
*(SPEED MODE: feed warmup is 3 weeks before structured DMs activate W5 — softened from earlier 2-week claim. Reason: Vignesh's 7+ year LinkedIn signal is **Trioangle CEO / general software dev**, not blockchain/FinTech. The algorithm needs to RE-CATEGORISE the profile to a new topic cluster, not just confirm existing signal. 2 weeks insufficient for re-categorisation; 3 weeks with aggressive Profile Recategorisation Accelerator gets close.)*
- [ ] **(Vignesh authors · MPs schedule + post · SP comments)** **Mon** — feed post; comment on 5–10 ICP posts (FT + CN); engage 3-5 morning posts
- [ ] **(Vignesh authors · MPs schedule + post)** **Tue** — feed post amplifying Tuesday article (no link in body — drop link in comment 1)
- [ ] **(Vignesh authors · MPs schedule + post + company page repost)** **Wed** — feed post; company page repost
- [ ] **(Vignesh authors · MPs design carousel + post)** **Thu** — carousel post (algorithm preference)
- [ ] **(Vignesh authors · MPs schedule · Vignesh runs weekly review)** **Fri** — feed post + weekly review
- [ ] **(MPs ensure cadence)** **Start W1 Day 1** — first 3 weeks (W1–W3) carry compressed Outreach Readiness Gate; do not slip cadence

### Profile Recategorisation Accelerator (W2–W3 only — Speed Mode-specific)
- [ ] **(Vignesh authors · MPs post)** **2 posts/day** in W2–W3 (vs 1/day normal cadence) to flood the algorithm with RWA / MiFID II / DLT Pilot / blockchain-security signal
- [ ] **(Vignesh authors · MPs gatekeep cluster discipline)** **EVERY post in W2–W3 must hit a topic cluster** (no off-topic posts — see § 5.1 clusters); off-topic posts in this window confirm the wrong categorisation
- [ ] **(SP · Vignesh contributes ≤30 min/day)** **Strategic comments amplified to 10–15/day in W2–W3** (vs 5–10 normal) on EU WealthTech / RWA accounts — comments are a strong topic-relevance signal to the algorithm
- [ ] **(MPs track · Vignesh reviews)** **Track Search Appearance metric weekly** — if search appearances for "RWA" / "MiFID II" / "tokenization" don't show signal by W4, accelerator is failing and warmup needs to extend

### Posting cadence (Company page — 3×/wk)
- [ ] **(MPs)** Mix: 2× repurposed Vignesh posts + 1× company-specific (case study / milestone / service post)
- [ ] **(MPs)** Alternate days with Vignesh personal — never both same day

### Posting times (EU primary — per § 3.2)
- Tue 11:30–13:00 IST · Wed 12:30–14:00 IST · Thu 11:30–13:30 IST · Mon 11:00–12:30 IST · Avoid Fri after 15:30 IST

> [!INFO] Time-zone convention
> All times converted to **IST** (UTC+5:30) — operational team executes from India. EU posting peaks are anchored to EU buyer behavior on LinkedIn — IST times above correspond to **EU local Tue/Wed/Thu 08:00–10:30 + Mon 07:30–09:00 + Fri after 12:00** (Phase 1 May–Oct 2026 falls entirely within CEST window = UTC+2 · IST = European local + 3:30). **Post-Oct 26, 2026 (CEST → CET DST switch)** these IST values shift +1 hr — Phase 1 closes Oct 15 so this doesn't affect Phase 1, but Phase 2 schedule must re-anchor times after the DST switch.

### Per-platform formatting spec (extracted to [[InnBlockchain - Per-Platform Posting Spec]])

> Cross-phase framework extracted from this playbook → see [[InnBlockchain - Per-Platform Posting Spec]] for the full LinkedIn / X formatting table + safe-area rules + cross-platform asset bundle. Phase 1 IST posting times included in the table. Telegram correctly absent (dropped Phase 1; re-evaluate Phase 2/3 DeFi-protocol Felix scope).

### Topic cluster discipline (per § 5.1)
- [ ] **(Vignesh authors · MPs gatekeep cluster discipline)** **3 of every 5 posts** must fall inside these clusters:
 - MiCA CASP compliance engineering (Seg 2/4 — not RWA)
 - MiFID II + DLT Pilot Regime tokenization engineering ⭐
 - RWA tokenization security ⭐
 - Smart contract audit readiness
 - AI-generated smart contract risk
 - Web3 talent gap solutions
- [ ] **(MPs check)** Every off-topic post dilutes the algorithm's categorisation

### Engagement tactics (per § 4 Engagement Tactics)
- [ ] **(SP + Vignesh)** Comment on ICP posts BEFORE publishing your own each morning (warms the algorithm)
- [ ] **(MPs publish · Vignesh authors)** Drop external links in comment #1, not the post body (algorithm penalises external links in body)
- [ ] **(Vignesh)** Reply to every comment within the first hour (re-triggers the algorithm)
- [ ] **(Vignesh)** Tag sparingly — only people likely to engage
- [ ] **(Vignesh)** Repost ICP-relevant news with 2–3 lines of your own analysis (positions you as the filter)

### Strategic commenting (per § 5.3)
- [ ] **(SP)** 5–10 high-quality comments per day on high-reach ICP posts
- [ ] **(SP · Vignesh shadows first 20)** Comment quality: specific point / counterargument / data point — never "great post"
- [ ] **(SP)** 3–5 sentences max
- [ ] **(SP)** End with a question when possible
- [ ] **(SP)** Comment within first 30 minutes of post going live

### Newsletter "Secure by Design" — DEFERRED
- [ ] **(Vignesh decision)** Decision recorded: deferred until 50+ subscribers / 4–6 weeks of baseline follower count established
- [ ] **(Vignesh)** Revisit at Phase 1 mid-point (~W10)
- [ ] **(Vignesh authors · MPs assemble + send)** If activated: bi-weekly, 400–700 words, one topic per issue, alternating FinTech / Crypto Native angle

#### Vendor-selection decision criteria (extracted to [[InnBlockchain - Newsletter Vendor Selection]])

> Cross-phase framework extracted from this playbook → see [[InnBlockchain - Newsletter Vendor Selection]] for the full 5-vendor trade-off table + decision triggers + default recommendation (Beehiiv default · LinkedIn Newsletter if <200 subscribers at revisit · defer Substack until >1,000). Phase 1 revisit fires at W10.

### Authority signals to track (per § 5.5 — first 30 days are invisible, signals appear W8–W12)
- Profile views: 100–300 / week
- Search appearances: trending up week-on-week
- Follower growth: +50–100 / month
- Inbound DMs from ICP (not outbound responses) — qualitative

### LinkedIn output cap (per [[InnBlockchain - Content Repurposing Plan]] § LinkedIn output cap)
Once content repurposing starts producing carousels + persona variants + long-form from same article, the cap prevents feed cannibalization.

- [ ] **(MPs enforce in scheduling)** **≥48 hr spacing** between any two LinkedIn posts about the same article from the company profile
- [ ] **(MPs + CW plan cadence)** **Cross-pillar Tier 1 articles** (C1, T4-N, P5-DORA-X, P5-eIDAS-X) distribute LinkedIn cadence across **3 weeks**, not launch week — full detail in Repurposing Plan § Track B
- [ ] **(CW enforces in calendar)** **Cross-pillar Tier 1 publishes capped at 1/week** in Editorial Calendar to avoid breaching spacing across two articles
- [ ] **(MPs monitor + cap)** **Steady-state aggregate target: 4–7 LinkedIn posts/week** from one profile. Above 7 = feed reads as content firehose; cap enforces thoughtful-publisher feel
- [ ] **(MPs decide defers · CW flags conflicts)** **Tier 2 Track B aggregate rule:** if 2 Tier 2 Track B articles publish same week AND a cross-pillar Tier 1 launch week is active = >7 posts/wk → defer one Tier 2 article's quote graphic to the following week

### Cross-channel cannibalisation matrix (extracted to [[InnBlockchain - Cross-Channel Cannibalisation Matrix]])

> Cross-phase framework extracted from this playbook → see [[InnBlockchain - Cross-Channel Cannibalisation Matrix]] for the full 8-vector matrix + MPs scheduling enforcement workflow + "when in doubt, stagger not skip" rule. Canonical source for all cross-channel spacing rules.

---

## WS9 — LinkedIn Outbound — Structured ABM (DM Sequences)

> Source: [[InnBlockchain - LinkedIn Outreach Strategy]]
> **SPEED MODE:** activation compressed W6 → W5. Adjacent-Network (WS9.5a) + Engagement-Led (WS9.5b) tracks run in parallel and start W1 Day 1 without these gates.

> [!INFO] Ownership
> - **Primary owner: SP** — full-cycle: DMs → sequences → discovery calls → sales-led closes (Vignesh joins for FT WealthTech > $100k OR Carol vendor reviews)
> - SP ramp at start: 1–2 wk (regime-leak training + voice/style guide + Vignesh shadows first 10 DMs before approval to send)
> - SP writes from **Vignesh's profile** (recommended) or own profile — decision in open items

### Pre-flight ready items (must clear before W5 activation)
- [ ] **(SP verifies · Vignesh confirms gate clear)** **Outreach Readiness Gate cleared** — every box in WS3 + WS4 + WS5 + **3 weeks of feed posts** (compressed from 4–6 wks; cannot drop below 3 because profile recategorisation needs the time)
- [ ] **(SP)** LP Gates 1 + 2 verified live (not 404) — hard gate, not compressible
- [ ] **(Vignesh tracks)** 5+ recommendations published across 3 of 5 categories
- [ ] **(SP + MPs ensure delivery infra ready)** Compliance brief (MiFID II/III + Prospectus + DLT Pilot + MAR + Listing Act) + vendor risk pack + Sample Audit Report PDF ready for instant delivery

### Mid-flight checkpoint (W4 — go / no-go for W5 activation)
- [ ] **(MPs report · Vignesh decides go/no-go)** Profile Search Appearances showing RWA / MiFID II / tokenization signal — if NOT trending, profile categorisation hasn't shifted, warmup extends 1 wk → structured DMs slip W5 → W6

### Daily mix (per § 7 Phase 1 Weekly Action Plan)
- 12–17 RWA structured ABM connection requests + 2–3 ambient organic signals (cap 20/day)
- Split: ~50% FT WealthTech RWA / ~50% CN RWA Felix
- **Zero non-RWA sequences in Phase 1** (per scope decision above)

### Weekly action plan
| Day | Action |
|---|---|
| **Mon** | Identify 12–17 EU RWA leads + 2–3 ambient signals. Apply DQ filter. Check tokenization announcements / MiFID II/III filings / Prospectus / DLT Pilot / MAR / Listing Act filings / asset issuance announcements. |
| **Tue** | Send 12–17 RWA T1 connection requests + 2–3 ambient. Asset-specific hook for CN RWA Felix; MiFID II + DLT Pilot framing for FT WealthTech. **Total hard cap 20/day.** |
| **Wed** | Send T2 welcomes to RWA connections from Mon–Tue (regime-aware open question per § 5 templates). Engage in EU PropTech / Security Token / MiFID II groups. |
| **Thu** | Publish RWA content per editorial calendar. Send T3 value asset to RWA connections from prior week. |
| **Fri** | Send T4 soft-ask to qualified RWA leads (10–14 days old, positive signal). Book discovery calls. T5 nudge or park stale leads. Update CRM pipeline tracker. |

### Sequence per prospect (T1 → T5)
- [ ] **(SP)** **T1 (Day 0)** — personalised connection request (300 char max). Hook = a specific RWA trigger.
- [ ] **(SP)** **T2 (Day 1–2 post-accept)** — welcome message, no pitch, open question about their work
- [ ] **(SP)** **T3 (Day 5–7)** — share relevant content (RWA security guide, MiFID II + DLT Pilot audit pattern, asset-class deep dive)
- [ ] **(SP)** **T4 (Day 12–14)** — soft ask referencing their context, propose 20-min call
- [ ] **(SP)** **T5 (Day 21)** — final nudge or park for 60 days

### Templates — pull verbatim from [[InnBlockchain - LinkedIn Outreach Strategy]] § 5
- **(SP uses · Vignesh approves all new template variants)** FinTech RWA / WealthTech templates: § 5 🥇 FinTech RWA / WealthTech block
- **(SP uses · Vignesh approves all new template variants)** CN RWA Felix templates: § 5 🥇 RWA Crypto Native block
- **(SP uses · Vignesh approves all new template variants)** Universal T5: § 5 Universal T5 — Final Nudge

### Sales Navigator filters
- [ ] **(SP)** FT WealthTech RWA saved search created per § 2.1 (Title + Industry Financial Services + Company size 50–500 + EU geo + RWA/MiFID II/DLT Pilot/STO keywords — **NO MiCA keyword**)
- [ ] **(SP)** CN RWA Felix saved search created per § 2.2 (Title + Industry Real Estate/Commodities/Financial Services + EU geo + asset tokenization keywords)

### Safe daily limits (per § 6 Outreach Automation)
- Profile views: 80–100/day
- Connection requests: 15–20/day (personalised — no bulk)
- Messages: 30–50/day
- InMails: 10–20/day

### Disqualification signals — do NOT connect / advance (per § 9)
- [ ] **(SP)** FT RWA: idea-stage with no product, no licensing intent, no timeline
- [ ] **(SP)** FT RWA: "just exploring" with no funding, no MiFID II / Prospectus / DLT Pilot pressure
- [ ] **(SP)** CN RWA: no underlying asset, no codebase, zero build budget
- [ ] **(SP)** CN RWA: jurisdiction with explicit crypto/tokenization ban
- [ ] **(SP)** All: hiring multiple blockchain dev firms simultaneously for competitive pitches
- [ ] **(SP)** CN exchange/DeFi/wallet startup with no asset-backing → park to Phase 3 watchlist
- [ ] **(SP)** FT non-RWA (pure ExchangeTech / etc.) → park to Phase 2 watchlist

> [!IMPORTANT] Hard rules — review monthly, not checkable
> *(These are standing rules, not one-time tasks. Per § 9 Phase 1 Common Mistakes.)*
> - Never pitch MiCA framing to an RWA prospect — #1 Carol disqualifier
> - Never pitch in T1 (300-char connection request is tone only)
> - Never use generic "I came across your profile" opening
> - Never treat FT RWA and CN RWA as the same audience (compliance-first vs asset-first)
> - Never mix FT and CN messaging in a single sequence
> - Never outreach outside EU Continental Europe until 5-project gate
> - Never exceed 20 connection requests/day
> - Never stop after T2
> - Never pitch Trioangle or generic software dev from this profile
> - Never DM from a group joined the same day (2-week presence minimum)

### Discovery Call Master Sequence (extracted to [[InnBlockchain - Discovery Call Master Sequence]])

> Cross-phase framework extracted from this playbook → see [[InnBlockchain - Discovery Call Master Sequence]] for the full 5-phase / 20-step walk-through + Vignesh escalation triggers + common mistakes. Phase 1 escalation triggers (Carol founder request · Sam $100k+ · Trioangle relationships · MiCA-confusion) covered in the framework with Phase 1 overlays.

---

## WS9.5a — Adjacent-Network Warm Intros (Speed Mode)

> **Activates W1 Day 1. No Outreach Readiness Gate.** Vignesh has NO direct warm network in FinTech. He DOES have adjacent network from Trioangle (real estate / marketplace / commodity / general-business clients) + tech/crypto connections. This track uses that adjacent network for **2nd-degree intros**, not direct DMs to FinTech prospects.

> [!INFO] Ownership split
> - **SP can send first warm DM** using a Vignesh-voice template, with **Vignesh per-DM approval** before send (not just template-level approval — the specific personalised version for each prospect). Sender = SP's profile; opener references Vignesh explicitly ("I work with Vignesh at InnBlockchain — he asked me to reach out about [your asset class]"). Avoids the security issue of shared account access while preserving the warm-relationship signal.
> - **Vignesh sends personally** only when the relationship calls for it — close personal contacts · founder-CEO peers · cases where SP framing would feel inauthentic. Vignesh's call.
> - **SP carries forward** thread after first response — discovery call coordination + technical scoping + close
> - Vignesh joins live call only if Trioangle client explicitly asks for founder (high-value cases)
> - Per-DM approval SLA: Vignesh reviews + signs off within 24 hr of SP submitting drafted DM

### Why 2nd-degree intros, not direct DMs
- **Vignesh's Trioangle clients in real estate / commodity / marketplace verticals are themselves candidate RWA Felix prospects** — many of them are asset owners considering tokenization. Direct conversation with them is legitimate (existing relationship).
- **Tech/crypto connections may have routes to FT WealthTech buyers** — ask for warm intros, don't bypass them.
- Volume is intrinsically low. Don't expect more than 1–3 intro requests/wk.

### Target identification (this week)
- [ ] **(Vignesh + SP)** **Audit Trioangle client base** — list every client who is in real estate, commodity, marketplace, or asset-backed verticals. These are direct RWA Felix candidates.
- [ ] **(Vignesh + SP)** **Audit existing LinkedIn connections** in tech, crypto, blockchain, fintech-adjacent spaces — list those who likely know FT WealthTech buyers
- [ ] **(Vignesh + SP)** Score by: relationship recency · likely RWA/tokenization relevance · willingness to make intro

### Trioangle client outreach (direct conversation — they ARE RWA Felix candidates)
- [ ] **(SP drafts in Vignesh voice · Vignesh per-DM approves · SP sends from own profile)** **Per-client message:** "Hi [name], I work with Vignesh at InnBlockchain — he asked me to reach out. You've worked together on [X]; we've been doing RWA tokenization work — building smart contract infrastructure for real estate / commodity / fleet asset owners under MiFID II + DLT Pilot. Are you exploring tokenization for [their asset class] or know anyone who is?"
- [ ] **(SP leads · Vignesh joins live call only on request)** If yes / interested → discovery call (same prep template per WS5)
- [ ] **(SP · escalate to Vignesh if Trioangle-relationship-specific)** If no but warm → ask "anyone in your network looking at this?"

### Adjacent-network warm intro requests (not direct DMs to FinTech)
- [ ] **(SP drafts in Vignesh voice · Vignesh per-DM approves · SP sends from own profile)** **Per-connection ask:** "Hi [name], I work with Vignesh at InnBlockchain. We're building out our RWA tokenization practice — focused on EU WealthTech + asset-backed founders. Do you know anyone in [their adjacent space] working on tokenization who'd be worth a 15-min conversation? Happy to return the favour any time."
- [ ] **(SP drafts · Vignesh approves opener pattern)** Reciprocity offer ("happy to return the favour") increases response rate 2–3×
- [ ] **(SP)** If intro happens → treat the intro'd prospect as warm-referred (much higher conversion than cold)

> [!IMPORTANT] When Vignesh sends personally instead (Vignesh's judgment call)
> Default = SP drafts + sends per above. Vignesh sends personally when: close personal contact (>5 years sustained relationship) · founder-CEO peer where SP framing reads inauthentic · prior dispute / sensitive context that needs founder presence. Vignesh's judgment, not a hard rule. When Vignesh sends, SP picks up the thread on positive response same as the default flow.

### Daily / weekly cadence
- [ ] **(SP drafts · Vignesh approves 24-hr SLA)** **1–3 Trioangle client direct DMs/wk** (limited universe; quality over volume)
- [ ] **(SP drafts · Vignesh approves 24-hr SLA)** **2–4 adjacent-network intro requests/wk**
- [ ] **(SP)** **Track in CRM** under Source = "Adjacent-Network Intro" or "Trioangle Client Direct" · tag whether Sales-Person-sent or Vignesh-sent for monthly review pattern check
- [ ] **(Vignesh · daily, ≤15 min)** Review SP drafted DMs + sign off (24-hr SLA) — calendar block for this

> [!IMPORTANT] Trioangle universe depletes by ~W12–W15
> ~30 active Trioangle clients × 1–3 DMs/wk × 20 wks = the universe is exhausted within 10–20 weeks. **Realistic depletion: W12–W15** (mid-to-late Phase 1). After depletion: Trioangle direct outreach stops; only adjacent-network intro requests continue (lower volume); WS9.5b engagement-led carries the immediate-lead load. Plan for this transition at the W10 monthly review.

### KPI targets (realistic given no FinTech warm network)
| Metric | Target |
|---|---|
| Trioangle client direct DMs / wk | 1–3 |
| Adjacent-network intro requests / wk | 2–4 |
| Intro success rate (request → actual intro) | 20–35% |
| Discovery calls / mo from this track | 1–2 |
| Qualified leads / mo from this track | 2–4 |

### What NOT to do
- [ ] **(Vignesh + SP)** Never send direct DMs to FinTech prospects framed as "warm" — Vignesh doesn't have that warmth in FinTech; prospects will see through it instantly
- [ ] **(Vignesh + SP)** Never burn Trioangle client relationships with pitch-y RWA framing — these are existing trust relationships, treat as such
- [ ] **(Vignesh + SP)** Never mention MiCA when discussing RWA

---

## WS9.5b — Engagement-Led Inbound (Speed Mode)

> **Activates W1 Day 1. Genuine ASAP play that doesn't require warm network OR readiness gate.** Surface RWA / WealthTech prospects by engaging meaningfully on their LinkedIn content; convert engagement → reactive DMs from people who engage back. This is the source-doc-prescribed engagement tactic (see [[InnBlockchain - LinkedIn Marketing Strategy]] § 5.3 Strategic Comment Strategy) elevated to a primary outbound channel for the no-warm-network reality.

> [!INFO] Ownership
> - **Primary from W8: SP** takes over commenting volume + reactive DMs; Vignesh contributes ≤30 min/day to maintain founder voice in the feed
> - SP ramp on commenting requires regulatory + technical fluency — Vignesh shadows first 20 comments before SP goes solo (regime-leak risk identical to DM track)

### Why this works without warm network
- **Substantive comments on a thought-leader's post are seen by their entire audience** — often 1k–10k+ ICP-relevant followers per comment
- **Reactive DMs (initiated by the prospect, not Vignesh) convert 3–5× cold DMs** — the prospect has self-qualified
- **No conversion gate required** — engagement is free; prospects who engage actively are signaling interest

### Daily mechanics
- [ ] **(SP · Vignesh ≤30 min/day)** **5–10 substantive comments/day** on EU WealthTech / RWA / tokenization posts by Sam-tier accounts (FinTech founders, WealthTech CTOs, RWA commentators, MiFID II / DLT Pilot voices)
- [ ] **(SP · Vignesh shadows first 20)** Comment quality: specific point / counterargument / data point — **never** "great post"
- [ ] **(SP)** 3–5 sentences max
- [ ] **(SP)** End with a question when possible (invites a reply, extends the thread)
- [ ] **(SP)** Comment within first 30 minutes of post going live (algorithm rewards early high-quality comments)
- [ ] **(SP)** Identify target accounts — 30–50 EU RWA / WealthTech / MiFID II commentators to follow + monitor daily

### Reactive DM rule
- [ ] **(SP)** When someone replies to your comment with substance, follow up with a DM within 24 hrs: "Appreciated your point on [X] — saw you're working on [Y] at [Z]. Curious how you're thinking about [specific RWA / MiFID II question relevant to their post]."
- [ ] **(SP)** When someone engages with Vignesh's own posts (likes + comments) and matches ICP, follow up with a non-pitch-y DM within 24 hrs
- [ ] **(SP)** These reactive DMs are NOT cold — they're warm follow-ups to demonstrated interest. Conversion 3–5× cold DM.

### LinkedIn polls (Speed Mode amplifier)
- [ ] **(Vignesh authors · MPs schedule)** **1 poll/week** — ask a sharp question your ICP cares about (e.g., "Asset managers tokenizing: which framework are you using? — MiFID II + DLT Pilot / MiCA / Still figuring out / Not tokenizing yet")
- [ ] **(MPs track engagement)** Polls drive 3–5× engagement vs text posts; voters self-identify as relevant audience
- [ ] **(SP)** Follow up with poll voters who match ICP via reactive DM

### KPI targets (engagement-led inbound)
| Metric | Target |
|---|---|
| Substantive comments / day | 5–10 |
| Reactive DMs sent / wk | 5–15 |
| LinkedIn polls / wk | 1 |
| Inbound DMs from ICP / mo (first 60 days) | 0–2 (low expectation — authority compounds slowly) |
| Inbound DMs from ICP / mo (W8+) | 2–5 (compounding) |
| Discovery calls / mo from this track | 1–3 (W6+ as engagement compounds) |
| Qualified leads / mo from this track | 3–6 (W6+) |

### What NOT to do
- [ ] **(SP)** Never comment "great post" or generic agreement — wastes the slot
- [ ] **(SP)** Never paste the same comment on multiple posts — flagged as spam
- [ ] **(SP)** Never DM someone who hasn't engaged with you — that's cold outreach, belongs in WS9 structured track
- [ ] **(SP)** Never mention MiCA when discussing RWA (same hard rule)

---

## WS10 — eIDAS Outbound Test (W13 mid-point, limited scope)

> Source: [[InnBlockchain - LinkedIn Outreach Strategy]] § 7a Limited eIDAS Outbound Test

### Pre-test assets (must exist before T1s fire)
- [ ] **(Vignesh + Designer — covered in WS3/WS4)** eIDAS 2.0 / EUDI Wallet Relying-Party Brief built (PDF, 3–4 pages) — same as WS3 Asset 4
- [ ] **(Dev)** Gated PDF landing page live (`innblockchain.com/eidas-brief` recommended) — captures email + redirects to PDF
- [ ] **(CW — covered in WS7)** W13 cross-cutting article *"eIDAS 2.0 EUDI Wallet for Regulated FinTechs and RWA Tokenization Platforms"* published
- [ ] **(MPs)** eIDAS brief pinned to Featured on Vignesh's profile

### Test parameters
- [ ] **(SP)** Timing: starts week of W13 article publish (~Aug 2026)
- [ ] **(SP)** Scope: 20–30 prospects total in first 2 weeks
- [ ] **(SP)** Daily allocation: 2–3 eIDAS T1s/day (RWA budget reduced 12–17 → 10–14 during test window only; cap 20/day)
- [ ] **(SP)** Landing destination: gated PDF download (no full Solutions LP build needed for test)
- [ ] **(SP — Vignesh approves new templates)** Templates per § 5 "🧪 eIDAS 2.0 Outbound Test" block

### Sales Navigator filters
- [ ] **(SP)** Title: CTO / CPO / VP Engineering / Head of Digital Identity / Head of KYC / Head of Platform Engineering (exclude Head of Compliance — Carol responds to formal RFPs not cold DMs)
- [ ] **(SP)** Industry: Financial Services
- [ ] **(SP)** Company size: 50–500
- [ ] **(SP)** Geography: EU Continental Europe
- [ ] **(SP)** Keywords: EUDI Wallet OR eIDAS OR eIDAS 2.0 OR Digital Identity Wallet OR e-money OR payment institution OR regulated wallet OR FinTech custody
- [ ] **(SP)** Exclude pure crypto-native wallet providers (Phase 3 territory)

### Scale-up vs park criteria (after first 2 weeks)
- **Scale to 40–60/month + commit `/solutions/fintech-wallets` LP build IF:** accept rate ≥35% AND reply rate ≥6% AND ≥1 qualified discovery call
- **Park and re-evaluate IF:** accept rate <25% OR reply rate <3% OR zero qualified calls

---

## WS11 — Events + Partner / VC Intros

> Source: ICP docs § Channel Strategy

### EU events — reality-checked Phase 1 windows

> [!IMPORTANT] Money20/20 Europe 2026 is Jun 2–4 (1 week away). Speaking slots locked months ago.
> Realistic Phase 1 event posture for Money20/20 Europe 2026: **attendance + targeted meetings only**, not speaking. Pursue speaking slots for events that still have lead-time.

- [ ] **(Vignesh)** **Money20/20 Europe** (Amsterdam, Jun 2–4 2026) — **attendance + meeting bookings only** (speaking slot window closed). Book 5–10 meetings with WealthTech CTOs / Heads of Product (1 week out is late but salvageable). Post-event LinkedIn coverage with RWA + MiFID II + DLT Pilot framing.
- [ ] **(Vignesh)** **Sibos** (Oct 2026) — **pursue speaking slot now** — lead time is realistic. Leverage for partner intros (Big4 / core banking).
- [ ] **(Vignesh)** **RWA Summit EU editions** — pursue speaking slot · use MiFID II + DLT Pilot framing exclusively (RWA Summit attendees who hear MiCA framing will judge)
- [ ] **(Vignesh)** **EU Security Token Summit** — pursue speaking slot · correct regulatory venue for ownership-token RWA
- [ ] **(Vignesh)** **DLT Pilot Regime / MiFID II tokenization regulatory forums** — attend / speak

> Money20/20 Europe Jun 2027 speaking-slot pursuit (typically Q4 2026 CFP) is beyond Phase 1 close (Oct 2026) — moved to Phase 2 playbook.

### Event execution per attended event (extracted to [[InnBlockchain - Event Execution Playbook]])

> Cross-phase framework extracted from this playbook → see [[InnBlockchain - Event Execution Playbook]] for full pre-event / at-event / post-event execution + speaking-slot lead time guidance per event class. Phase 1 event list (Money20/20 · Sibos · RWA Summit · EU Security Token Summit · DLT Pilot regulatory forums) stays in the WS11 § EU events block above.

### Partner / VC intros — target 2/month
- [ ] **(Vignesh)** **EU FinTech VCs:** Northzone · Atomico · Speedinvest · Balderton — intro requests to portfolio companies with WealthTech / RWA tokenization mandates
- [ ] **(Vignesh)** **Core banking platforms:** Mambu · Thought Machine · Temenos — intro requests to clients adding tokenized-asset modules
- [ ] **(Vignesh)** Build relationships with 3–5 EU-based FinTech-focused VCs (warm intros outperform any outbound channel)

---

## WS12 — Pipeline + CRM + Measurement

> Source: [[InnBlockchain - LinkedIn Outreach Strategy]] § 8 KPIs · [[InnBlockchain - LinkedIn Marketing Strategy]] § 6 Analytics · [[InnBlockchain - Editorial Calendar]] § Metrics Dashboard

### Per-prospect tracking (in CRM, after each touchpoint)
- [ ] **(SP)** Status field: Connected · Replied · Qualified · Call Booked · Closed · Parked
- [ ] **(SP)** Sequence state: T1 sent / T2 sent / T3 sent / T4 sent / T5 sent / Parked-60d
- [ ] **(SP)** Source field: Outbound DM / Inbound LP / Inbound content / Partner intro / Event
- [ ] **(SP)** Motion field: `[Audit]` / `[Dev]` / `[White-Label]`
- [ ] **(SP)** Trigger field: which buying trigger drove the connection

### Pipeline-stage exit criteria (extracted to [[InnBlockchain - Pipeline Stage Exit Criteria]])

> Cross-phase framework extracted from this playbook → see [[InnBlockchain - Pipeline Stage Exit Criteria]] for the full stage-transition table (Connected → Replied → Qualified → Call Booked → Closed + Parked + re-engagement) + 4 hygiene rules. SP enforces; Vignesh spot-checks at monthly review.

### Per-article tracking (from [[InnBlockchain - Editorial Calendar]] § Metrics Dashboard)
- [ ] **(MPs)** Time-to-LP-click <60s median (GA4 transition events)
- [ ] **(MPs)** LP form-fill rate ≥2% cold / ≥5% warm EU LinkedIn
- [ ] **(MPs · SP reconciles in CRM)** Booked discovery calls attributed per article, per motion
- [ ] **(MPs)** `[Both]` split-CTA performance
- [ ] **(MPs)** Carol pieces — CCO-pattern reader profile (LinkedIn referrer + title contains "compliance")
- [ ] **(MPs)** MiCA articles — EU geo split of LP-bound traffic (≥60% EU target)
- [ ] **(MPs · SP reconciles)** Cross-Pillar early-ship articles (C1, T4-N, P5-DORA-X, P5-eIDAS-X) — Track B discovery calls within 60 days of publish (target ≥1 each)

### Discovery call division of labour

> [!INFO] Backup discovery call owner question resolved
> SP is the backup AND primary closer for most discovery calls. Prior risk "Vignesh capacity ceiling on discovery calls (3–6/wk target)" reduces to ~1–2/wk for Vignesh (escalations only). Senior engineer / co-founder backup no longer required for routine overflow.

| Call type | Owner | Vignesh involvement |
|---|---|---|
| **CN RWA Felix** — all asset classes, all stages | **SP solo** | None unless SP escalates |
| **FT WealthTech Tom only** (CTO due diligence, technical scoping) | **SP solo** | None |
| **FT WealthTech Sam first call (deal value < $100k indicated)** | **SP solo** | Notified via Slack/CRM |
| **FT WealthTech Sam first call (deal value > $100k indicated)** | **Co-pitch** | SP opens, Vignesh joins last 15 min OR Vignesh leads + SP observes for handoff |
| **FT WealthTech Carol vendor review** | **SP submits vendor risk pack first** | Vignesh joins live call ONLY if Carol explicitly requests CEO |
| **Trioangle existing client (WS9.5a)** | **Vignesh sends first warm DM** → SP brought in after positive response → SP runs discovery call | Vignesh on Slack/back-channel for any escalations |
| **Adjacent-network warm intro recipients** | **SP solo** | Intro was Vignesh's; introducee gets SP call |
| **Inbound from content / AEO / LP form-fill** | **SP intake** | SP routes to Vignesh only on high-ACV signal (> $100k OR Sam-tier title at $5M+ ARR FinTech) |

### Calendly routing rules
- [ ] **(SP)** **Default routing:** all new bookings → SP Calendly
- [ ] **(SP + Vignesh)** **Vignesh Calendly slots reserved** for: FT WealthTech > $100k follow-ups · Carol-requested founder calls · Trioangle high-value client escalations · partner intro warm calls (VCs, core banking partners)
- [ ] **(SP flags · Vignesh opens slot)** **Escalation protocol:** SP tags a call "needs Vignesh" in CRM → Vignesh's calendar opens a slot within 48 hr

### Weekly review (Fri 60 min — Vignesh owns)
- [ ] **(Vignesh · SP prepares)** Pipeline tracker review — new connects, replies, qualified leads, calls booked
- [ ] **(Vignesh · MPs prepare GA4 + per-format CTR snapshot)** Per-channel KPI review (DM rates, LP conversion, article performance)
- [ ] **(Vignesh)** Risk register status (see Risk Register below)
- [ ] **(Vignesh + CW)** Identify 1 post to repurpose as carousel or video next week
- [ ] **(MPs report · Vignesh reviews)** Review profile-views spike sources (which post drove it)
- [ ] **(MPs)** Check newsletter subscriber count if launched
- [ ] **(Vignesh decision)** Capacity check: if Vignesh hit 6+ calls this week, escalate backup-owner activation

### Monthly review (last Fri 2 hr — Vignesh + CW)
- [ ] **(Vignesh + CW)** Top 3 / bottom 3 articles by booked discovery calls — pattern-match
- [ ] **(Dev reports · Vignesh decides)** LP gate status — any new 404s? Any LPs not yet shipped that block upcoming weeks?
- [ ] **(CW + Vignesh decision)** Watch-candidate articles (B1-#4, B1-#11) inbound check — kill at 90 days if zero
- [ ] **(SP + Vignesh)** Override events fired (Carol, Sasha, AI overlay, exploit post-mortem) — log and re-sequence
- [ ] **(SP reports · Vignesh tracks)** EU 5-project gate progress — count of EU deals closed
- [ ] **(MPs)** Monthly AI search citation probe per [[InnBlockchain - Landing Pages AEO GEO Prompts]] § Monthly AI Search Citation Probe (Perplexity / ChatGPT / Gemini sample queries)

> [!WARNING] Reply rate <2% on any sequence = stop and diagnose
> Stop, diagnose hook / persona match, iterate template before resuming. Source-doc rule from [[InnBlockchain - LinkedIn Outreach Strategy]] § 8 Note.

---

## WS13 — Compliance Review Process

> Source: [[InnBlockchain - Editorial Calendar]] § Weekly Batch Workflow · [[EU-Compliance-Landscape]]
> Vignesh self-reviews articles (per prior team-config decision) + spot-checks delegated work (MPs visual output + SP DM templates + SP strategic comments) for regime-leak risk

### Delegated-work spot-check protocol (extracted to [[InnBlockchain - Delegated-Work Spot-Check Protocol]])

> Cross-phase framework extracted → see [[InnBlockchain - Delegated-Work Spot-Check Protocol]] for the full per-role spot-check rate table (SP DM templates · SP strategic comments · MPs visual asset output · MPs LinkedIn posts · Sales-led close paperwork) + ramp principle (risk concentrates in first 4 weeks · 25% W1–W4 → 10% W5+ if zero incidents) + ramp-up rule on regime-leak incident.

### Pre-publish review — applies to every Thursday Phase 1 article + W4 / W7 / W13 Cross-Pillar pieces
*(Thursday slot is Track B B1 by default for all of Phase 1; effectively every Thursday article needs review. Cross-pillar pieces fire W4 Thu C1 / W6 Thu T4-N / W7 Thu P5-DORA-X / W13 Tue P5-eIDAS-X.)*
- [ ] **(CW submits · Vignesh reviews)** Article first draft to compliance reviewer by EOD day-before-publish
- [ ] **(Vignesh)** Compliance review 48-hr SLA
- [ ] **(Vignesh)** Reviewer checks: regime framing matches [[EU-Compliance-Landscape]] canonical map (no MiCA-on-RWA leaks)
- [ ] **(Vignesh)** Reviewer checks: date-stamped regulation references (Principle 8)
- [ ] **(Vignesh)** Reviewer checks: per-segment scope guards (RWA pieces stay in MiFID II / DLT Pilot lane; cross-pillar pieces use `[Both]` split CTA properly)
- [ ] **(Vignesh)** Reviewer sign-off logged before publish
- [ ] **(Vignesh + CW)** Escalate after 2 missed cycles

### Pre-publish review on every LinkedIn post hook
- [ ] **(Vignesh)** Weekly audit of LinkedIn post hooks before publishing — same regime-leak check
- [ ] **(Vignesh)** Per-segment keyword regime (per [[InnBlockchain - LinkedIn Marketing Strategy]] § 3.1 Relevance Signals + § 4 Hook Formula): RWA posts use MiFID II + DLT Pilot keywords only; never `#MiCA` paired with `#RWATokenization`

### Quarterly compliance brief refresh
- [ ] **(Vignesh)** Re-read [[EU-Compliance-Landscape]] for any regime changes
- [ ] **(Vignesh drafts · Designer relays out PDF)** Update MiFID II/III + Prospectus + DLT Pilot + MAR + Listing Act brief
- [ ] **(Vignesh)** Update vendor risk pack
- [ ] **(Vignesh)** Notify Vignesh of any change that affects About copy or LP hero

---

## WS14 — Case Study Capture

> Source: [[InnBlockchain - Editorial Calendar]] § Gate-dependent + Out-of-Sequence Overrides

### Case Study Capture workflow (extracted to [[InnBlockchain - Case Study Capture Framework]])

> Cross-phase framework extracted → see [[InnBlockchain - Case Study Capture Framework]] for the full at-contract-sign + at-delivery + publishing-trigger flow + MVP-fallback pattern. Phase 1 overlays: Case Study A (CN RWA) + Case Study B (FT WealthTech B1) tagging · W14 (Aug 17–23) MVP fallback review window · *Hardening a Live RWA Tokenization Platform* + *Expanding Your RWA Platform to New Markets* Post-Launch articles slot in after first RWA/B1 client goes live.

---

## WS15 — Content Repurposing

> Source: [[InnBlockchain - Content Repurposing Plan]]. The Repurposing Plan is the canonical source for tier definitions, format priority, per-track asset families, per-`[Both]` derivative rules, output cap detail, anti-patterns, KPIs, and quarterly format-priority audit protocol. This workstream is the **execution checklist** layered on top.

> [!IMPORTANT] Two orthogonal tier systems
> - **Article Tier (1/2/3/0)** — per-article investment depth (already used in WS7 Content Production)
> - **Format Priority (S/A/B/C/D)** — per-format "should we produce this at all"
> Both gate every derivative decision. See Repurposing Plan § Format Classification + § Repurposing Tiers.

### Phase 1 derivative scope

| Article Tier | Derivative chain | Owner |
|---|---|---|
| **Tier 1** (~12 articles: hubs + cross-pillar + score ≥9.3) | **Full chain** — all S formats (carousel + lead magnet + X thread + vendor risk pack where applicable) + A formats (persona variants + LinkedIn long-form + GitHub/Solodit where applicable) | MPs produce visuals via AI + post/schedule · CW structures copy + persona variants · Designer for high-stakes (Sample Audit, regulatory infographics) · Vignesh final review |
| **Tier 2** (~15–18 articles, score 8.5–9.2) | **Scaled-back chain** — carousel + LinkedIn long-form + X thread (Track A) OR carousel + LinkedIn long-form + quote graphic (Track B). Skip: video, infographic, persona variants × 3, GitHub. | MPs + CW (same as Tier 1 but lighter scope) |
| **Tier 3** (~10–14 articles, score <8.5 OR Watch-candidate) | **Amplify-only** — 1 X thread (Track A) OR 1 LinkedIn quote graphic (Track B). No carousel, no PDF, no video. | MPs (minimal — <30 min per article) |
| **Tier 0** (LP-gated, WL Reference Build pending, PP5 validation pending) | **No repurposing** | — |

**Cross-Track Assets (standalone, exempt from per-article rules):**
- [ ] **Sample Audit Report PDF** (S, MANDATORY) — covered in WS3 Asset 2; Designer owns build
- [ ] **Original Research Report** (A, annual flagship) — Phase 1 decision: defer to Phase 2 unless Q3 2026 window opens up; tracked as Replan Trigger
- [ ] **Own Email Newsletter "Secure by Design"** (A) — deferred per WS8 until 50+ subscribers / 4–6 weeks baseline; revisit ~W10. MPs own assembly when activated.

**Phase 2 dedicated repurposing resource re-trigger:** Track B closes 2+ deals OR W18 (whichever first) OR if MPs + CW capacity sustains >85% utilization for 4+ consecutive weeks.

### Per-published-article repurposing checklist

> Lives in [[InnBlockchain - Per-Article Production Checklist]] § Step 19 expanded — 6-step derivative gate sequence (Article Tier → Format Priority → Track → Motion → Persona → LP) fires in CW workflow at step 19. Cross-Pillar Phase 1 persona overlays (C1 · T4-N · P5-DORA-X · P5-eIDAS-X) inline in framework Step 5.

### Cross-Track Assets — standalone production
- [ ] **(Designer · Vignesh review — covered in WS3)** **Sample Audit Report PDF** (S — covered in WS3 Asset 2 above)
- [ ] **(Vignesh decision · CW + MPs produce if committed)** **Original Research / Data Report** (A) — annual flagship, 1/year. Phase 1 decision: defer or commit? Highest single-asset leverage for AI search citation; production 4–8 weeks. **Recommendation:** defer until Phase 2 unless Q3 2026 window opens up; tracked as Replan Trigger.
- [ ] **(Vignesh authors · MPs assemble + send)** **Own Email Newsletter "Secure by Design"** (A) — deferred per WS8 until 50+ subscribers / 4–6 weeks baseline; revisit ~W10

### LinkedIn output cap enforcement (cross-references WS8)
- [ ] **(MPs)** Weekly review: count posts/article/wk + verify ≥48 hr spacing — any breaches feed Monthly Repurposing Review
- [ ] **(MPs + CW)** Cross-pillar Tier 1 cadence 3-week distribution (Launch wk = carousel + long-form + persona variant 1 · W2 = persona variant 2 + optional video · W3 = persona variant 3)
- [ ] **(CW enforces in calendar)** Cross-pillar Tier 1 publishes capped at 1/wk in Editorial Calendar — verify before scheduling

### Anti-patterns + Monthly + Quarterly reviews + KPIs

> Canonical sources: [[InnBlockchain - Content Repurposing Plan]] § Anti-Patterns (8 anti-patterns) · § Quarterly Format-Priority Audit (half-day session per quarter — Vignesh + CW) · § Metrics. WS12 § Per-article tracking owns the lead-magnet + sample-audit conversion KPIs (intent signal ≥15% / Carol-cycle conversion ≥8% / lead-magnet → call ≥5%). Monthly Repurposing Review folds into [[InnBlockchain - Phase 1 Execution Playbook#Monthly review (last Fri 2 hr — Vignesh + CW)]] — Article Tier mix · Format Priority mix · per-format winners · anti-pattern audit · Tier 0 → active backfill.

---

# 🛡️ Risk Register

Consolidated cross-channel risks. Per-channel risks live in source docs. Organized by category (Critical Path / Channel / Production / Operational) not rev-introduction order.

### Critical Path risks
| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| LP Gates 1+2 slip beyond Week 3 (Speed Mode target ship) | Medium | Critical — structured DMs slip back to ~W6; Speed Mode plan defaults to baseline timeline | Weekly status until clear · escalate to dev as P0 · Adjacent-Network (WS9.5a) + Engagement-Led (WS9.5b) Tracks still run regardless (no LP dependency) · do NOT launch structured DMs until LP live |
| Sample Audit Report PDF not produced in W2–W3 | High if no W2–W3 sprint commitment | High — single highest-leverage Phase 1 asset per [[InnBlockchain - Content Repurposing Plan]]; without it, $10M+ Sasha + Track B Tom + Carol don't book the discovery call | 3-day sprint W2 with Compliance co-owner · synthetic reference report acceptable (with explicit disclosure) until first delivered engagement |
| Outreach Readiness Gate stalls (Featured assets, <5 recommendations, <4 wks feed posts) | Medium | High — premature DMs convert near zero | Treat as separate critical path · weekly checkbox vs [[InnBlockchain - LinkedIn Outreach Strategy]] § Outreach Readiness Gate |
| Pain Point 5 validation never happens (owner not named end of W1) | Medium | Medium — kills 5 Track B articles + World Summit AI angle | WS6 escalation: decide Path A (Vignesh runs interviews W2) or Path B (mark cluster dropped, log in Replan Triggers) by end of W1 |

### Channel risks (LinkedIn + content + regulatory framing)
| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| No warm FinTech network = primary ASAP play is engagement-led, not warm-DM | Confirmed | High — Speed Mode's warm-DM-to-prospects advantage doesn't exist; pipeline relies on slower mechanics | Lean into WS9.5b engagement-led + WS9.5a Trioangle client direct outreach; expectations on closes revised down (3–11's 4–13) |
| Profile categorisation wrong direction (Trioangle CEO / general dev, not blockchain/FinTech) | High | High — algorithm shows profile to wrong audience until re-categorised; reduces inbound + content reach for first 3–4 wks | Profile Recategorisation Accelerator W1–W3: 2 posts/day all in topic clusters + 10–15 strategic comments/day. Track Search Appearance signal weekly; extend warmup if signal hasn't shifted by W4 |
| MiCA-framing leak on any RWA surface | Medium | High — Carol kills deal on call 1 | Compliance review on every Track B / MiFID II / DLT Pilot article · re-read [[EU-Compliance-Landscape]] before any P5 article or any regime-titled article |
| Synthetic Sample Audit shipped without disclosure | Medium | Critical — undercuts Carol-defensibility + creates reputational risk | Mandatory front-matter callout · Compliance reviewer sign-off required on every version |
| LinkedIn output cap breach (>3 posts/article/wk OR <48 hr same-article spacing) | Medium once carousel + persona variants + long-form stack | Medium — algorithm signal dilutes, followers scroll past | WS15 + WS8 cap enforcement · Cross-pillar Tier 1 cadence spread across 3 weeks · cross-pillar Tier 1 publishes capped at 1/wk in calendar |
| Reply rate <2% on any sequence | Medium | High — sequence wasted | Stop · diagnose · iterate template before resuming |
| Trioangle client outreach mis-framed as RWA pitch | Medium | Medium — burns Trioangle client trust; relationships are limited and valuable | First DM offers conversation only; don't pitch services in the same message that introduces RWA; treat as continued relationship not new sales motion |
| Recommendations batched in 1 week look "organised" not "earned" | Low–Medium | Medium — Sasha-grade evaluators may notice 5+ recommendations landing in 7-day window | Spread requests over 5 working days (not 1); aim for natural 10–14 day publish window not 48-hour cluster |

### Production / pipeline risks
| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| RWA pipeline <5 qualified leads/mo by W10 | Medium | High — 5-project gate misses, geography stays EU-locked | Diagnose LP conversion / DM hook / persona match before scaling volume |
| Case-study gates don't clear by W18 | High | Medium — BOFU conversion weaker without proof | Pre-emptively negotiate screenshot rights at contract sign · build 1 internal MVP reference (mockup scope) by W18 |
| ~~WS15 capacity-forced cut — 24 of 44 Phase 1 articles ship with zero derivatives~~ **RESOLVED** — team config (MPs + CW + Designer) enables Tier 2 scaled-back chains; only Tier 3 amplify-only remains intentional cut | — | — | — |

### Operational risks
| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Vignesh review SLA slips (24 hr article, 24 hr visual, 48 hr DM template) under volume | Medium | Medium — entire pipeline waits on his sign-off; bottleneck shifts from production to approval | Weekly Fri review checks SLA performance; if slipping, switch to spot-check protocol (review 25% randomly, not 100%) |
| **NEW — SP pitches too early in discovery calls** (selling vs listening = lower close rate) | Medium | Medium — closes drop; deals stall at scoping | Scripted discovery framework (first 20 min listening + qualify against ICP gates) · Vignesh sits in on SP's first 3 calls to coach · monthly review tracks SP close rate vs Vignesh-led benchmark |
| **NEW — SP misjudges Carol-handoff threshold** (handles Carol when she wants CEO; or escalates Vignesh when SP could've handled) | Medium | Medium — either wastes Vignesh time OR damages Carol's vendor approval cycle | Explicit rule: Carol asks "can I speak to the founder?" = always escalate to Vignesh · monthly review tracks SP escalation rate |
| **NEW — Trioangle relationship damage if SP framing reads inauthentic** (client expected founder, gets SP pitch with no Vignesh reference) | Medium | Medium — burns Trioangle client trust permanently | Per SP can send first warm DM but **must use Vignesh-voice template referencing Vignesh explicitly** ("I work with Vignesh — he asked me to reach out about [your asset class]"). Vignesh per-DM approves before send. Vignesh sends personally when relationship calls for it (Vignesh's judgment). Process documented in WS9.5a Ownership split callout. |
| **NEW — MPs visual output ships with AI-hallucinated regulatory framing** (e.g., AI auto-generates slide copy saying "MiCA-compliant RWA tokenization") | Medium | High — same Carol-killing cost as a regime-leak DM | WS13 spot-check protocol on 25% of MPs visual output W1–W4 · regime-leak checklist for MPs to reference before publish · ChatGPT-generated copy reviewed against regime guide before slide commit |
| **NEW — Content writer single point of failure** (no backup writer if CW sick/leaves) | Medium | High — 44-article schedule slips immediately | Accept the risk OR budget freelance writer retainer for emergencies · cross-train one MP to author 1 article in absence (degraded quality acceptable for 1–2 articles) |
| Compliance reviewer not available on Thu publish (resolved by Vignesh self-review) | Low (own role) | Low — Vignesh prioritizes Thu review block in calendar | Vignesh blocks Thu AM for compliance review · escalation path if Vignesh travel collides with Thu publish |

---

# 📅 Critical Path + Time-Critical Items

## W1 — Pre-Flight Audit + Foundations Kickoff

Editorial Calendar planned W1 publishes + foundations work. Run a W1 retro at end of W1 to mark what landed before executing W2 sprint.

### W1 publish targets (per Editorial Calendar)
- [ ] **WL-0** *Own vs. License: 5-Year TCO of Productized Crypto Platforms vs. SaaS Vendors* (no LP dependency)
- [ ] **#2** *How to Tokenize Real-World Assets* (A1 hub) — blocked on LP Gate 1

### W1 LP delivery targets
- [ ] **LP Gate 1** (`/solutions/rwa-tokenization`) — Editorial Calendar target
- [ ] **LP Gate 2** (`/solutions/tokenization`) — Editorial Calendar target

### W1 foundations work (kicked off immediately)
- [ ] Profile content drafting (per [[LinkedIn Profile Vignesh Content]])
- [ ] Recommendations pipeline kickoff (Week 1 of batch — 2 FinTech client + 1 engineering hire requests)
- [ ] Compliance brief drafting (5-day sprint EOD W2)
- [ ] Vendor risk pack assembly (2-day sprint EOD W1)
- [ ] RWA Tokenization Risk Checklist PDF (3-day sprint EOD W2)
- [ ] **Sample Audit Report PDF (synthetic)** — 3-day sprint, complete by EOD W3
- [ ] LinkedIn feed posting cadence active (Profile Recategorisation Accelerator: 2 posts/day W1–W2)
- [ ] Platform setup (Sales Nav, Expandi/Lemlist, Zoho CRM, Calendly, GA4, email capture)
- [ ] **WS9.5a Adjacent-Network activates** — audit Trioangle client base · identify adjacent connections for 2nd-degree FT WealthTech intros
- [ ] **WS9.5b Engagement-Led activates** — identify 30–50 EU WealthTech / RWA / MiFID II thought-leader accounts · first 5–10 substantive comments
- [ ] **LP Gates 1 + 2 escalated to dev as P0** — target ship EOD W3
- [ ] **Pain Point 5 validation owner named end of W1** — deadline end of W2

### W1 first publish + design sprint
- [ ] **Dev** kicks off LP Gates 1+2 sprint — target EOD W3 ship
- [ ] **CW** publishes W1 articles per Editorial Calendar
- [ ] **Designer** engaged for brand template + Sample Audit Report PDF sprint — 5-day build by EOD W3

> [!IMPORTANT] Run a W1 retro at end of W1
> Mark each above as ✅ done / ❌ slipped / 🟡 partial. Anything slipped rolls forward into W2 sprint. If W1 shows everything ❌, the foundations sprint extends and structured DMs slip from W5 to W6.

---

## W2 — Foundations sprint completion

Foundations sprint + immediate engagement-led lead generation in parallel. No direct warm-FinTech DMs (don't exist).

- [ ] **PP5 validation deadline by end of W2** — Path A interview results logged OR Path B (drop cluster) decision recorded in [[InnBlockchain - Editorial Calendar]] § Replan Triggers
- [ ] **W2 articles publish** (gated on LP status): #6 *MiFID II + DLT Pilot Compliance for RWA* (Tue) · #7 *ERC-3643 vs ERC-1400 vs ERC-20* (Thu)
- [ ] **Recommendations: 5–8 requests sent by EOD W2** (compressed from 4-wk stagger)
- [ ] **Vendor risk pack assembly** complete by EOD W2
- [ ] WS9.5a Adjacent-Network: 1–3 Trioangle client conversations open (Vignesh personally)
- [ ] WS9.5b Engagement-Led (Vignesh interim): cadence at 5–10 comments/day + reactive DMs going out
- [ ] Profile Recategorisation Accelerator W1–W2: ~28 posts published (2/day × 14 days), all topic-cluster aligned

---

## W3 — Foundations complete + structured prep
- [ ] LP Gates 1 + 2 ship by EOD W3
- [ ] Profile publishes (LP Gate 1 live + Asset 3 anchor article pinnable)
- [ ] 3+ recommendations published; 5+ target by W4
- [ ] Compliance brief + vendor risk pack + Sample Audit Report PDF + RWA Risk Checklist PDF complete
- [ ] MPs + Designer onboarded; brand template + Sample Audit Report sprint complete by EOD W3
- [ ] Sales Nav saved searches refined; first 20–30 structured prospects identified for W5 activation
- [ ] Profile Recategorisation Accelerator W3 continues (2 posts/day final week)

---

## W4 — Recategorisation check + structured prep finalised
- [ ] **Profile Search Appearance signal check** — trending toward RWA / MiFID II / tokenization terms. If NOT trending, warmup extends 1 wk → structured DMs slip W5 → W6
- [ ] 5+ recommendations published
- [ ] Sales Nav saved searches refined
- [ ] Phase 1 articles publish: C1 Carol (Thu) + #4 *MiCA or MiFID II?* (Tue)
- [ ] First discovery calls from Adjacent + Engagement tracks arriving

---

## W5–W6 — Structured ABM activates + leads landing
- [ ] **W5: Structured DMs activate at half cap (8–10/day RWA)** — Vignesh interim if SP not yet onboarded
- [ ] **W6: Full structured DM cadence (15–20/day)**
- [ ] First structured-ABM calls expected by W7–W8
- [ ] Continued recommendations backfill (Sasha-grade 7–8 by W8)

---

## Phase 1 mid-point (W11–W13)
- [ ] eIDAS Featured asset built (W11–W12)
- [ ] eIDAS outbound test fires (W13)
- [ ] Newsletter activation decision (~W10)
- [ ] First case study gates may begin clearing

---

## Phase 1 close (W19–W22)
- [ ] BOFU lead magnets + Carol piece + WL-1 publish
- [ ] Track A close W20 · Track B B1 close W22
- [ ] Phase 1 retro for Phase 2 planning (separate doc)

---

## Events (week-relative — exact dates depend on Phase 1 start date)
- [ ] **Money20/20 Europe** (typically early-to-mid June, around W3) — Vignesh attends · book 5–10 WealthTech CTO / Head of Product meetings · speaking slot window typically closed by Phase 1 start. Post-event LinkedIn coverage with RWA + MiFID II + DLT Pilot framing.
- [ ] **Sibos Europe** (typically October, around W19–W22) — speaking slot pursuit · partner intros target
- [ ] **RWA Summit EU editions** — pursue speaking slot · MiFID II + DLT Pilot framing exclusively
- [ ] **EU Security Token Summit** — pursue speaking slot
- [ ] **DLT Pilot Regime / MiFID II tokenization regulatory forums** — attend / speak

---

# 🚨 Replan Triggers (per [[InnBlockchain - Editorial Calendar]] § Replan Triggers)

The playbook gets re-cut, not patched, when any of these fire:

1. **Cadence change** — moving to 1/wk or 3/wk shifts everything downstream
2. **LP gate slip** — any of the three Phase 1 LPs slipping beyond confirmed ETAs by ≥2 weeks
3. **EU 5-project gate clears** — UK / MENA / US / SEA content gets added
4. **AI+Blockchain validation result (end of W2)** — pass = slot 5 articles into Track B; fail = restructure
5. **Case study gate clears** — delivered RWA platform with screenshot rights triggers 2 case study slots out-of-sequence
6. **B1 first client goes live** — B1 Post-Launch piece slots in
7. **Phase 1 close (Week 21)** — full Phase 2 calendar gets built from Q3 performance data
