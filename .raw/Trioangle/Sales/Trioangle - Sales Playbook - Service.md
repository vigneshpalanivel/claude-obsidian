---
company:
  - trioangle
department:
  - sales
priority: highest
tags:
  - sales
  - playbook
  - service
  - icp
related:
  - "[[Trioangle - ICP - Service]]"
  - "[[Trioangle Growth Plan]]"
  - "[[Trioangle 2.0 AI Pivot Plan]]"
---

# 📘 Sales Playbook — Trioangle Service ICP

> [!NOTE] Scope of this document
> This playbook is the **operating layer** for selling Trioangle's Service offering (AI Engineering — primary; Web/Mobile Custom Dev — secondary). It tells a rep **what to do** in a given week — scripts, scoring, stage exit criteria, pricing guardrails, handoff checklists.
>
> It is **not** the strategy layer. For *who* we sell to, *why* they buy, *how channels are prioritized*, *what objections mean*, and *how the competitive set is structured* — read [[Trioangle - ICP - Service]] first. This playbook references that document; it does not duplicate it. If a section here ever conflicts with the ICP, the ICP wins and this playbook gets corrected.

> [!IMPORTANT] Two non-negotiable framing rules
> Both inherited from [[Trioangle - ICP - Service]] — repeated here because reps break them most often:
> 1. **AI-first, dev-second.** Default to AI Audit Sprint as the entry product unless the inbound brief is explicitly a non-AI rebuild. Lead every conversation, every email, every demo with the AI angle if there is one.
> 2. **Defend trust with structural guarantees, not adjectives.** Day-1 GitHub access · IP transfer in writing · 48-hour communication SLA with contract credit · pre-contract engineer introduction · paid Sprint with escape hatch. Never use the words "transparent", "passionate", "high-quality", or "world-class" — every losing vendor used them too.

---

## 1. 📌 How to Use This Playbook

| If you are… | Read these sections first |
|---|---|
| New SDR (week 1) | §2 Operating Model · §3 Pipeline Stages · §5 First-Touch Templates · §15 KPIs |
| AE running an active deal | §6 Discovery · §7 Demo · §8 Sprint Mechanics · §9 Pricing · §10 Negotiation |
| Account manager on a closed-won account | §12 Expansion · §13 Loss Recovery (for dormant accounts) |
| Sales manager reviewing pipeline | §3 Pipeline Stages · §14 CRM Hygiene · §15 KPIs |
| BA / Pre-sales engineer | §6 Discovery · §7 Demo · §8 Sprint Mechanics · §11 Handoff |

**Update cadence:** quarterly review · ad-hoc updates after any 10 closed-lost deals · ICP changes propagate within a week.

---

## 2. ⏰ Operating Model — The Rep's Week

### Daily rhythm (90-min blocks)

| Block | Activity | Output |
|---|---|---|
| **08:30 – 09:00** | Pipeline triage in Salesforce. Re-prioritize: any deal with no activity in 5+ days → next-step or close-lost. | All open deals have a *dated* next step |
| **09:00 – 10:30** | Outbound sequence work. LinkedIn touches, trigger-based outbound (per [[Trioangle - ICP - Service]] Channel Execution Sequences). | Day's connection requests + Step-1 messages out |
| **10:30 – 11:30** | Live calls block 1 — discovery / demo / scoping. | Call summary in CRM + follow-up email out within 2 hours |
| **11:30 – 12:30** | Inbound triage. Clutch / G2 / website forms / AI Search inbound. **2-hour response SLA** on inbound. | Every inbound replied to with a *vertical-specific* reference, not a deck |
| **13:30 – 15:00** | Live calls block 2 — proposal walkthroughs / negotiation / sprint kickoffs. | Call summary out before next call starts |
| **15:00 – 16:00** | Followups + content engagement (LinkedIn comments on prospect posts, etc.). | Day's nurture touches done |
| **16:00 – 17:00** | Proposal/SoW work. Day's CRM hygiene cleanup. EoD update. | EoD posted in agreed format; CRM clean |

> [!TIP] Calls are the leading indicator
> Call count and demo count are the cleanest leading indicators of pipeline. If both are flat for two weeks, expect closed-won to flatten ~6 weeks later.

### Weekly rhythm

- **Mon 09:30** — Pipeline review with sales manager (per-rep). Order: *Results → Pipeline → Activity*.
- **Tue 16:00** — Competitor analysis update (15 min — what changed in competitor demos / pricing / positioning).
- **Wed 09:30** — Daily lead discussion → flag stuck deals to peers for second opinion.
- **Thu 16:00** — LMS training (45 min — domain or product deep-dive).
- **Fri 15:00** — CRM closeout: every open opp has clean stage, next step, $ amount, close date.

### Monthly rhythm

- At least one closed-won deliverable-based engagement per rep (Service ICP floor is $10k; AI feature build floor is $15k — see §9). Monthly volume targets to be calibrated against [[Trioangle Growth Plan]] Year 1–3 ramp.
- Portfolio refresh check (any new vertical demo, case study, or load-test report from delivery team that the rep should know about).
- Closed-lost review: pick 2 deals lost in last 30 days, schedule 15-min post-mortem call with the buyer.

---

## 3. 🚦 Pipeline Stages & Exit Criteria

Each stage has a **definition** (what's true here), **exit criteria** (what must happen to move forward), and a **kill criteria** (when to mark closed-lost and stop).

| # | Stage | Definition | Exit criteria (advance) | Kill criteria (close-lost) |
|---|---|---|---|---|
| 0 | **Lead** | Inbound or sourced contact, not yet qualified | Qualified per §4 scoring rubric (≥40 points) AND named persona match (P1–P5 in [[Trioangle - ICP - Service]]) | <40 points after 14 days OR fails Existing-Operator Filter |
| 1 | **Qualified Opportunity** | Persona match + budget signal + named pain | Discovery call booked within 7 days | No call booked within 14 days of qualification |
| 2 | **Discovery Complete** | Discovery call done; pain, budget, timeline, decision process captured | AI Audit Sprint or Discovery Sprint pitched and considered | Prospect refuses paid sprint AND won't commit to demo follow-up |
| 3 | **Demo Delivered** | Live product demo or architecture walk-through done; tailored to persona | Sprint commitment OR signed proposal in flight | 14 days of silence post-demo without reply to follow-up |
| 4 | **Sprint Active** | AI Audit Sprint or Discovery Sprint engagement signed and underway | Sprint deliverable accepted; main proposal scoped | Sprint deliverable rejected (rare) OR prospect says "thanks, we'll go internal" |
| 5 | **Proposal Submitted** | Fixed-price SoW with milestones submitted post-sprint | Verbal commit + redlines on SoW | 21 days post-proposal with no redlines OR verbal "no" |
| 6 | **Negotiation** | Price, scope, payment terms in active discussion | Signed SoW + first invoice paid | Buyer disengages after 2 redline rounds with no movement |
| 7 | **Closed-Won** | First invoice paid, kickoff scheduled | Hand off to delivery (§11) | n/a |
| L | **Closed-Lost** | Deal dead | Tag with structured loss reason (per [[Trioangle - ICP - Service]] Loss Reasons table). Schedule 15-min post-mortem if amount >$25k. | n/a |

> [!IMPORTANT] No proposal without a sprint
> Per [[Trioangle - ICP - Service]] Loss Reasons — "Ghosted after proposal" is a high-frequency loss driver because cold proposals get ignored. **Default rule: do not send a proposal without a paid AI Audit Sprint or Discovery Sprint preceding it.** Exceptions: P4 MENA (relationship gates trust, not sprints); P3 Enterprise on a formal RFP track. Document exceptions in CRM.

> [!WARNING] Stage hygiene
> A stage that doesn't move in **30 days** is not a real opportunity. Force movement (set a dated next step with the prospect) or close-lost. Keeping stale deals open inflates pipeline and corrupts forecasting.

### 3.1 Direct P3/P4 inbound — handle, don't reject

[[Trioangle - ICP - Service]] flags P3 (Enterprise) and P4 (MENA) as channel-partner-only by default. But direct inbound from these personas does happen — Clutch.co, conferences, referrals. Don't reject; route correctly.

**Direct P3 inbound (Clutch / conference / referral):**
1. Qualify on the Existing-Operator Filter and budget (§4 lead scoring).
2. Route through any channel partner with even a peripheral relationship to the prospect — revenue-share preserves the channel program and warm trust accelerates the close.
3. If no partner relationship exists AND deal is >$80k → take direct with formal proposal + RFP-style response. Use the engagement to seed a partner relationship for future P3 deals.
4. If no partner AND <$80k → take the deal but don't invest in repeated outbound to similar profiles. Single deals here aren't worth building a direct-P3 motion around.

**Direct P4 inbound:** trust isn't built on the first call.
1. Spend the first 1–2 conversations purely in relationship-building mode — no pricing, no scope, no proposal.
2. If a shared connection emerges in their network during early conversations, retroactively introduce the partner to formalize the relationship.
3. Direct closure of P4 without any partner or shared-connection bridge is rare and high-risk. Be willing to walk if no relationship anchor surfaces by call 3.

CRM note these as `direct-channel-bypass` for tracking; >5 of these per quarter is a signal the channel partner program needs strengthening.

---

## 4. 🎯 Lead Scoring Rubric

Score each new lead within 24 hours. ≥40 points = qualified for outbound. <40 = nurture or disqualify.

| Signal | Points | Notes |
|---|---|---|
| Persona match (P1–P5) | +15 | If unclear, default to "no match" |
| Vertical match (one of the 9 in [[Trioangle - Product Verticals]]) | +10 | |
| Geography match (NA / W. Europe / AU / UAE / KSA) | +5 | Secondary geos (SG / UK) +3 |
| **Existing-Operator Filter passes** ($1M+ ARR, 12+ mo operational) | +15 | Hard requirement; failing this disqualifies even if score is high |
| Stated budget ≥$15k (AI) or ≥$10k (dev) | +10 | |
| Trigger event in last 90 days (per ICP §⚡ Situational Triggers) | +10 | Outage · expansion · funding (Series C+ only) · key engineer departure · competitor AI launch |
| Reply within 48 hours to first touch | +5 | Engagement signal |
| Internal tech / product owner identified | +5 | |
| AI feature explicitly mentioned in inbound | +10 | Routes to AI Audit Sprint |
| Pre-existing peer referral or warm intro | +20 | Override most negatives |
| **Pre-revenue / pre-launch** | -25 | Route to [[ICP - Product]] (clone scripts) |
| **Solo non-technical founder, no business** | -25 | Disqualify |
| **Equity-only or deferred-payment ask** | -50 | Disqualify, no exception |
| **"Build Uber in 3 weeks for $8k"-class brief** | -50 | Disqualify |
| **Strong in-house team handling changes internally** | -15 | Low recurring demand; pursue only on AI scope |

> [!TIP] Reuse this rubric for closed-lost re-scoring
> Every quarter, re-score the closed-lost pile. Triggers, budgets, and personas change. A lead scored 25 in Q1 may score 60 in Q3 after their funding round.

---

## 5. ✉️ First-Touch Templates

> [!NOTE] These supplement, do not replace, the ICP Channel Execution Sequences
> [[Trioangle - ICP - Service]] §📬 Channel Execution Sequences gives the *3-step structure* per channel. The templates below are the *exact words* to ship. Personalize the bracketed parts; never send raw.

### 5.1 LinkedIn — Trigger-based outbound (P5, AI angle)

**Step 1 — Day 0 connection (no pitch):**
> *"Saw [Competitor X] just shipped [AI feature] in [vertical]. We built [analogous feature] for a [vertical] platform last year — the rollout pattern was non-obvious. Connecting either way."*

**Step 2 — Day 4 vertical-specific proof (no ask):**
> *"Sharing how we built [dynamic surge pricing / intelligent dispatch / fraud detection] for a [vertical] client — [specific metric, e.g., 18% driver revenue lift], A/B tested over 6 weeks. Three things broke during rollout that we hadn't predicted; full notes here: [link]. Useful or not, no agenda."*

**Step 3 — Day 10 soft scoping ask:**
> *"If a free 1-hour AI Readiness Call would help — engineering-language, no slide deck — we'll walk through your platform and tell you which 2–3 AI features would move your metrics, which are hype, which to buy off-the-shelf. We do these to disqualify deals where we can't help. If something is worth building, the next step is a paid AI Audit Sprint."*

**Banned in this channel:** "AI transformation", "strategy session", "we can train a custom LLM", "demo of our AI platform", "let's discuss your AI roadmap." All trigger the AI-vendor skepticism P5 is hardened against (per [[Trioangle - ICP - Service]] Channel 4).

### 5.2 LinkedIn — Trigger-based outbound (P1, dev rebuild signal — opportunistic)

**Step 1 — Day 0 connection (no pitch):**
> *"Congrats on the [new role / launch / expansion]. Following your engineering blog — the post on [specific technical topic] was sharp. Connecting to stay in your network."*

**Step 2 — Day 5 value-first message:**
> *"We solved a [Redis caching / multi-tenant dispatch / payment split] problem for a [similar-stage company] hitting the exact wall you'll hit at 10k concurrent users. Happy to share the architecture writeup if useful — no agenda."*

**Step 3 — Day 12 soft ask:**
> *"We've delivered platforms across delivery, ride-hailing, fleet management, marketplaces, rentals, home services, and education since 2015. If you ever want a second opinion on an architecture decision or are scoping a rebuild, I'd enjoy a 20-minute technical call. No pitch — peer conversation."*

### 5.3 Inbound (Clutch / G2 / website form) — within 2 hours

> *"Hi [Name] — saw your enquiry about [stated need]. Before sending a deck, two questions: (1) is your platform live and in production today? (2) what's the business metric this work needs to move? Also attaching one piece — a [vertical-specific] case study with the architecture decisions and outcome metric called out: [link]. Reply if useful; happy to set up a 30-min call."*

**Why this works:** the Existing-Operator Filter qualification is built into question (1); the "what metric" question filters out shoppers; the vertical-specific reference proves domain depth before the call. **Never send a generic capabilities deck on first reply.**

### 5.4 AI Search inbound (ChatGPT / Perplexity / Gemini referral)

These leads have already done some discovery via LLM search and arrive with a specific question.

> *"Hi [Name] — your question about [AI dispatch / dynamic pricing / fraud detection] is exactly what we worked on for [vertical] platforms last year. The honest short answer: [3-bullet substantive answer to their question]. If you want the long answer plus a build-vs-buy view for your specific data, that's the AI Readiness Call — free, 1 hour, engineering-language. Calendar: [link]."*

### 5.5 Cold email (Apollo/ZoomInfo with verified trigger)

Subject: *[Their company] + [trigger] — one note*

> *"[Name] — saw [trigger event: e.g., your Series C, the Black Friday outage post, the new AI feature posting]. We've shipped [analogous work] for [named comparable] in your vertical and the [specific edge case, e.g., dispatch rebalancing under surge] was where most teams trip. Two-paragraph writeup: [link]. If a 30-min call to compare notes is useful, here's my calendar: [link]. If not, no follow-up — I'll just keep an eye on what you're shipping."*

> [!IMPORTANT] No-follow-up promise must be honored
> If the prospect doesn't reply, **do not** auto-sequence. The credibility of "no follow-up" is the entire reason this template converts. Move them to the 90-day passive nurture list (content engagement, no DMs).

---

## 6. 🔍 Discovery Call Playbook

### 6.1 Structure (45 min)

| Min | Section | Goal |
|---|---|---|
| 0 – 3 | Opening | Confirm time, agenda, who's on the call |
| 3 – 8 | **Their context** (open-ended) | Get them talking about the business, not the request |
| 8 – 25 | **Pain / outcome / data** | Identify the *primary* pain (per ICP §😣 Pain Points × Persona matrix); confirm metric they want moved; assess data readiness if AI |
| 25 – 33 | **Decision process** (what do they need to sign?) | Identify decision-maker, budget range, timeline, alternatives being considered |
| 33 – 40 | **Sprint pitch** (AI Audit Sprint or Discovery Sprint) | Position the paid sprint as the next step |
| 40 – 45 | Close | Dated next step before the call ends — calendar invite sent live |

### 6.2 Question bank — by persona

> [!TIP] Lead with the persona's *primary* pain, not the full list
> Pain → Persona matrix in [[Trioangle - ICP - Service]] tells you which 1–2 pains to anchor on. P1 — scalability + IP + domain. P2 — communication trust + speed/quality + domain. P3 — IP + domain + scalability. P4 — communication trust + IP. P5 — AI-where-to-start + domain.

**P1 Scaling CTO — questions:**
1. What's the failure mode you're trying to engineer out — is this a scale ceiling, a refactor backlog, or a compliance gate?
2. How many concurrent users does the current architecture handle before P99 latency degrades?
3. Walk me through your CI/CD and test coverage today.
4. Who owns the repo today? Who needs read access tomorrow?
5. What does "passing" look like on the security audit you're aiming for — SOC2 Type II, PCI-DSS, HIPAA?
6. If we sat in a code review of your worst service, what would I find?
7. Have you tried other agencies on this? What broke?

**P2 Founder-Operator — questions:**
1. What's the business doing today — revenue, customers, growth — and what's the platform blocking?
2. Who built the current platform? Are they still around?
3. What's your relationship with technology — comfortable making decisions, or do you need a translator?
4. What does the next 12 months look like for the business? What's the platform the business needs in 12 months?
5. Where did the last vendor relationship break down — and what would have made it work?
6. Who signs the cheque, and what do they need to see to say yes?

**P3 Enterprise — questions:**
1. Where does this engagement sit in your digital transformation roadmap — flagship, follow-on, or rescue?
2. Who's your incumbent vendor today? Why are you looking outside them?
3. What does your procurement timeline look like — are we in formal RFP territory?
4. Which compliance frameworks does this platform need to live inside — SOC2, HIPAA, PCI-DSS, FedRAMP?
5. Who are the 3 stakeholders we need to make happy, ranked by veto power?
6. What does success look like for *you personally* in 12 months — not just the project?

**P4 MENA Relationship Buyer — questions (relationship-first; technical comes later):**
1. Tell me about the business — who are the founders, the family, the history?
2. What does this project mean inside the group — flagship, sister-business, expansion?
3. Who in your network has worked with us or with comparable partners? Whose opinion do you trust on vendor selection?
4. What's the cultural / language fit you need — Arabic-language capability, on-the-ground meetings, WhatsApp comms?
5. (Only after rapport is built) — what does the platform need to do, and by when?

**P5 AI-Forward Operator — questions (engineering-language, no slide deck):**
1. What's the metric you want AI to move — and what's the rule-based baseline today?
2. What event data do you have? How clean is it? How much history?
3. Who internally would integrate the AI service — and what's their bandwidth this quarter?
4. What's the platform's blast radius if the AI feature regresses — full outage, degraded UX, or contained?
5. Have you tried any AI SaaS or off-the-shelf service? What didn't fit?
6. What's the board / investor expectation, and what's the engineering reality? (Listen for the gap.)
7. If you had to pick *one* AI feature to ship in 90 days, what would it be?

### 6.3 What to listen for — and what to do with it

| Signal | What to do |
|---|---|
| Talks about their domain in detail you don't recognize | Ask, take notes, don't bluff. Bring an engineer to call 2. |
| Asks "what's your hourly rate?" before scope | Loss-risk signal (price-shopper). Reframe to fixed-price, sprint-first. |
| "We're trying [Copilot / Cursor / Devin] internally first" | Use the AI coding tools objection handler from ICP. Offer free AI Readiness Call. |
| "We've been burned before" | This is the *good* signal — these buyers convert highest. Lead with structural guarantees. |
| Mentions a specific competitor that just shipped a feature | Use as the wedge — "we built that for [other client], here's the rollout writeup." |
| Decision-maker not on the call | Re-book; do not run discovery without the buyer in the room. Champion-only calls are stage-1 max. |
| Data readiness sounds thin (P5) | Pre-flag the data instrumentation conversation in the AI Audit Sprint scope. |

### 6.4 Banned moves on discovery

- Sending a capabilities deck during the call.
- Quoting a price on the call without a sprint.
- Promising timelines before scope.
- Saying "we can do that" without engineer verification.
- Letting the call end without a dated next step.

---

## 7. 🎬 Demo Playbook

### 7.1 Pre-demo prep (mandatory — 24 hours before)

- [ ] Demo seed data populated for *their vertical* — not the default seed.
- [ ] Demo run on a device matching the buyer's likely device — same OS version, browser, and screen class. A demo that breaks live on a P1/P5 buyer's device is a closed-lost in waiting.
- [ ] Latest performance / load test report ready to share if asked.
- [ ] Vertical-specific case study URL handy.
- [ ] Discovery call notes re-read; the demo is *answering their pain*, not showcasing features.

### 7.2 Demo flow — by persona

**P1 / P5 (technical buyer):** Architecture diagram → live API → admin panel → CI/CD → load test report → engineer Q&A. **No slide deck.**

**P2 (non-technical founder):** End-user app flow → admin panel → reporting/dashboards → "here's what your week running this would look like" walkthrough → references.

**P3 (enterprise):** SoW deliverables → compliance / SLA / security exhibits → reference org chart → enterprise reference call offered.

**P4 (MENA):** Skip product demo on first meeting. Build relationship, share case studies, propose in-person or high-touch video introduction with a senior engineer. Demo comes after trust.

### 7.3 Demo close

> *"Three options for next steps — pick the one that fits where you are. (1) If you want a [free AI Readiness Call / free architecture review] to go deeper, here's my calendar. (2) If you're ready to scope, the next step is a [paid AI Audit Sprint / Discovery Sprint] — 2 weeks, $1,500–$4,000, credited toward the project. (3) If neither feels right today, tell me what's missing and I'll come back with that."*

Track which option they pick — it's a strong signal for forecasting.

---

## 8. 🏃 Pre-Sales Sprint Mechanics

The ICP §🔍 Pre-Sales Sprints describes *what* the sprints are. This section describes *how to sell them*.

### 8.1 Default = AI Audit Sprint

Per [[Trioangle - ICP - Service]] §AI-First service line priority: **AI Audit Sprint is the default entry product.** Discovery Sprint is the secondary fallback for explicit non-AI rebuild briefs.

### 8.1a AI Funnel — two distinct products (don't confuse them)

| Product | Stage | Format | Price | Purpose |
|---|---|---|---|---|
| **AI Readiness Call** | TOFU · qualification | 1-hour live call | Free | Identify 2–3 highest-ROI AI use cases at conversation level. No deliverable; goal is to qualify, build trust, surface whether a paid AI Audit Sprint is the next step. Used in objection handling (§19) and Channel 4 Step 3 (§5.1). |
| **AI Audit Sprint** | Pre-engagement · formal entry | 2-week paid | $1,500–$4,000 (credited toward first project) | Full data audit, feature shortlist, reference architecture, build-vs-buy recommendations, fixed-price quote. Converts qualified P5 prospects into signed AI feature builds. |

**Standard funnel:** Free AI Readiness Call → AI Audit Sprint → signed AI feature build (sprint fee credited).

**Floor rule:** Pick the right step for the prospect's stage; never offer both in the same conversation. Cold prospects → free call; warm content-engaged prospects → Audit Sprint pitch directly.

### 8.2 The sprint sales line — memorize this

**AI Audit Sprint:**
> *"Before we scope an AI feature build, let's do a 2-week AI Audit Sprint. We audit your data, identify the 2–3 features that would actually move your core metrics, recommend build vs buy honestly per feature, and you meet the engineers who'd deliver. If we tell you not to build something, that's the answer. If you proceed, the fee is credited."*

**Discovery Sprint:**
> *"Before we quote the full project, let's do a 2-week paid Discovery Sprint. You'll meet the actual engineers, we'll scope everything rigorously, and you'll leave with a guaranteed delivery timeline. If you proceed, the sprint fee is credited. If you don't, you still own the architecture spec."*

### 8.3 Sprint pricing decision tree

| Platform / scope complexity | Sprint price |
|---|---|
| Single AI feature on a clean codebase, <3 events to instrument | $1,500 |
| Multi-feature shortlist, moderate data readiness | $2,500 |
| Complex data audit, multi-vertical platform, >5 candidate features | $3,500 – $4,000 |
| Discovery Sprint (custom dev) — typical scope | $2,000 |
| Discovery Sprint with multi-region / compliance scope | $3,000 – $4,000 |

### 8.4 Common sprint objections

| Objection | Counter |
|---|---|
| *"I don't pay vendors before they prove value."* | "The sprint *is* the proof. You leave with an architecture spec or feature shortlist you own — even if you don't proceed. The fee is credited if you do." |
| *"$3,000 is fine — let's just start."* | Slow down. Run the sprint anyway. Sprints stop scope blowouts in the main project; skipping them inflates the loss-rate on the main engagement. |
| *"Can you do the audit for free?"* | "No — and the reason matters: we're staffing real senior engineers on it for 2 weeks. A free audit means a junior runs it, and that's the wrong shape for what you're paying us to figure out." |
| *"My internal team can do this audit."* | "Probably — and if they do, great. The reason buyers run our audit is the build-vs-buy recommendation backed by 800+ platform engagements in your vertical. Internal teams can audit data; they can't benchmark against what we've shipped. Decide which one matters for this decision." |

### 8.5 Sprint exit → main proposal

Within 48 hours of sprint deliverable acceptance:
- [ ] Fixed-price SoW for the top-priority recommended feature
- [ ] Named milestones with dates
- [ ] A/B test framework + success metric definition (AI) or load-test SLA (dev)
- [ ] Engineering team named on the SoW
- [ ] Sprint fee credited line-item visible

If the prospect doesn't proceed within 14 days post-sprint, run the loss recovery flow (§13).

---

## 9. 💵 Pricing & Commercial Guardrails

> [!IMPORTANT] Output / deliverable-based pricing only
> Trioangle does not sell retainers, hourly billing, or per-engineer subscriptions for the Service motion. Every engagement is **fixed-price for a defined deliverable** with named milestones. This is a deliberate operating model choice — see [[Trioangle - ICP - Service]] §Commercial Model and [[Trioangle Growth Plan]]. Reps who quote retainers or hourly rates are out of bounds.

### 9.1 Floor prices (do not sell below these)

| Engagement type | Floor | Note |
|---|---|---|
| Single AI feature build | **$15,000** | Below this, we lose money on senior-engineer staffing |
| AI multi-feature program | $40,000 | Tied to AI roadmap from the Audit Sprint |
| Web/mobile rebuild — established operator (P1/P2) | **$10,000** | Hard floor; below this disqualify |
| Enterprise digital transformation (P3) | $50,000 | Lower than this, the procurement overhead eats margin |
| MENA flagship (P4) | $30,000 | Often stretches to $80k–$120k+ |
| AI Audit Sprint | $1,500 | Below this, sprint is loss-leader theater |
| Discovery Sprint | $1,500 | Same |

### 9.2 Discount approval matrix

| Discount % | Approver | Justification required |
|---|---|---|
| 0–5% | AE | None — closeout courtesy |
| 5–10% | Sales Manager | Written justification (timing, multi-project commit, named reference) |
| 10–20% | Founder / CRO | Strategic logo, repeat customer, named multi-project commitment |
| >20% | Founder | Exception only — must be paired with multi-project commit or strategic positioning value |

**Discount triggers that are *not* sufficient justification:**
- "They asked." (Every buyer asks.)
- "Competitor was cheaper." (Counter on positioning, not price — see ICP Competitive Positioning.)
- "It'll close the deal." (If price is the only barrier, the deal wasn't qualified — see §4 lead scoring.)

### 9.3 Payment terms

- **Default:** 50% on signing / 50% on milestone (multi-milestone projects: 30/40/30).
- **Sprint:** 100% on signing.
- **Net-30 / Net-60 deferred:** approval from CRO; only for P3 enterprise with verified procurement constraint.
- **Equity / deferred / royalty:** not offered. Disqualify.

### 9.4 What's *always* in scope (no exception)

These are bundled into every engagement and not unbundled for discount:

- Day-1 GitHub repo access (buyer's organization)
- Full IP transfer on final payment
- Senior engineer code review on every PR
- 48-hour communication SLA with 5% contract credit penalty
- One-time team introduction call before signing
- Sprint deliverable handoff (audit / spec / architecture)
- 30-day post-launch warranty (bug fixes only)

These are the structural guarantees from [[Trioangle - ICP - Service]] §Trust & IP Positioning Rule. They are how Trioangle wins; do not negotiate them away.

### 9.5 What's *never* in scope by default (priced separately)

- 24/7 SLA / on-call (priced separately as a support contract — but not as a recurring retainer)
- Compliance certifications themselves (we build to standard; auditor cost is buyer's)
- Third-party API costs, server / cloud costs, license fees
- Marketing assets, branding, design systems (refer out)
- Ongoing feature work post-launch (next deliverable, next quote)

---

## 10. ⚖️ Negotiation Playbook

### 10.1 Common asks and defensible counters

| Buyer ask | Default counter | Walk-away signal |
|---|---|---|
| "Can you do this for $X?" (below floor) | "At that price the engineering shape changes — we'd staff juniors and you'd be unhappy. Two options: keep the price and the team, or reduce scope to fit the budget. Which fits your business better?" | They insist on floor price + full scope + senior team. Walk. |
| "We need fixed-bid on a vague scope." | "The sprint is exactly the bridge. 2 weeks, $X, you get a fixed-bid quote for the main work at the end. Without the sprint, fixed-bid means we pad the price to absorb the unknowns — that's worse for you." | They reject sprint and demand fixed-bid on hand-waved scope. Walk. |
| "Can you start before the contract is signed?" | "No — it's a structural protection for both sides. The fastest path is signing today; we can have engineers in your repo by Monday." | They want pre-signature work + no commitment. Walk. |
| "Net-90 payment terms." | "Net-30 is standard; Net-60 with CRO approval and a deposit. Net-90 we can't carry on a fixed-price engagement." | Insists on Net-90+ with no deposit. Walk. |
| "Drop the 48-hour SLA credit clause." | "It's a structural guarantee — non-negotiable. The reason it's in writing is that every losing vendor before us said 'we communicate well' and didn't. The credit is how we make that promise enforceable." | Insists on removing structural guarantees. Walk — they're optimizing for the wrong things. |
| "Can you assign your best engineer full-time exclusively?" | "On a fixed-price deliverable engagement we staff for the deliverable. Full exclusive allocation moves us into a different commercial model that we don't sell." | Hard insistence on per-engineer billing. Walk — it's the wrong product fit. |
| "We want to own the engineers' Slack / direct hire option." | "After the engagement closes, of course — we'll introduce you to anyone you want to keep. During the engagement, the team is ours so we can guarantee the deliverable. After, you have first right of conversation; we don't block." | Demanding direct hire pre-engagement. Walk. |

### 10.2 Multi-project commitment leverage

If a buyer commits to multiple projects upfront (typical for P5 with an AI roadmap from the Audit Sprint), you can offer:

- 5–10% discount on projects 2 and 3 (within Sales Manager authority)
- A reserved engineering team (no premium, but written into the SoW)
- Sprint fee credited across all projects, not just the first

**Do not offer:** retainer pricing, blended hourly rates, or rev-share. These break the operating model.

### 10.3 Walk-away discipline

Walking away is a tool, not a failure. Per [[Trioangle - ICP - Service]] Loss Reasons — disqualifying yourself from a wrong-fit deal is the highest-leverage move you can make. Reasons to walk before closing:

- Buyer cannot pass the Existing-Operator Filter
- Buyer demands removal of structural guarantees
- Buyer's data readiness is below threshold and they refuse the bridge engagement
- Buyer's stated outcome is "AI for the board deck", not a metric lift

Document the walk in CRM with the structured loss reason.

---

## 11. 🤝 Sales → Delivery Handoff

When does this happen? **At Stage 7 (Closed-Won) — first invoice paid, kickoff scheduled.**

### 11.1 Handoff package (delivered to BA / PM within 48 hours of close)

- [ ] Signed SoW + invoice
- [ ] Discovery call notes + sprint deliverable
- [ ] Buyer org chart + decision-makers + champion + skeptics
- [ ] Communication preferences (Slack, WhatsApp, email, weekly demo cadence)
- [ ] Timezone + language + cultural considerations (especially P4)
- [ ] Compliance / security requirements with deadlines
- [ ] Existing platform tech stack + repo access status
- [ ] Risk register from sprint (data readiness, fallback patterns, integration risks)
- [ ] Promised milestones with dates — no wiggle room
- [ ] Account expansion thesis — what's the next 2–3 projects per [[Trioangle - ICP - Service]] §Persona repeat-buy cadence

### 11.2 Sales → Delivery handoff call (mandatory — 30 min)

- AE walks the BA / PM through the package
- BA / PM confirms understanding and flags any "we sold something we can't deliver" risks
- Sales remains on the account for first 30 days as warm-handoff support
- Decision: who owns the buyer relationship long-term — AE or AM (account manager)? Default for P5 = same person across AI projects. Default for P3 = formal AM. Default for P4 = AE owns, never transitions.

### 11.3 What sales doesn't promise without delivery sign-off

- New milestone dates after kickoff
- Scope additions mid-engagement
- "Yeah we can probably do that" answers in escalation calls

---

## 12. 🔁 Account Expansion (Closed-Won → Repeat)

> [!NOTE] Reality check — ~30 active accounts, not 800
> Per saved memory and [[Trioangle Growth Plan]] — Trioangle has delivered 800+ platforms cumulatively but only ~30 are active accounts. **Expansion motion targets the active 30, not the historical 800.** Do not run "we worked with you 5 years ago" expansion plays — they're cold leads, not active accounts.

### 12.1 Quarterly account review (per persona)

| Persona | Cadence | Format | What to bring |
|---|---|---|---|
| **P5** | Quarterly AI roadmap review | 60 min, no slides | What's working in production · what's next from the audit shortlist · what's blocking |
| **P4 MENA** | Monthly WhatsApp check-in + quarterly in-person where possible | Informal | Industry insight relevant to their business · light project updates · personal news |
| **P3 Enterprise** | Quarterly executive readout | Formal deck | Outcome metrics vs board KPIs · change-management progress · compliance status · next-phase scope |
| P1 / P2 (opportunistic) | Post-launch + 6-month + annual | Email / call | Performance metrics vs SLA · feature backlog if applicable · upgrade options |

### 12.2 Expansion triggers — when to push

- Production AI feature has crossed its A/B-test threshold (P5) → "what's next on the shortlist?"
- Buyer's quarterly board update mentions a new initiative our scope can deliver
- Vertical competitor ships a feature the buyer doesn't yet have (the reverse of our outbound trigger)
- New geography / vertical / business unit announced — often a non-AI platform-extension project
- A technical leader the buyer trusts joins or leaves
- 6 months post-launch with stable metrics (the trust window has opened)
- AI feature roadmap from the Audit Sprint is running down (year 2+) → pivot expansion conversations toward platform extensions and operational projects, not more AI

> [!NOTE] Expansion revenue mix — AI is the wedge, not the whole book
> Per [[Trioangle - ICP - Service]] Repeat-Buy Cadence rows: expect 1–3 AI feature projects + 1–2 non-AI projects per active client per year (= 2–4 total). Don't force-fit every expansion conversation into an AI lens. After the AI Audit Sprint backlog runs down (typically end of year 2), most expansion revenue comes from platform extensions: new geography, new vertical, scaling work, compliance, integrations. AEs should be comfortable scoping non-AI work into the recurring engagement — that's not "downselling," it's the realistic shape of the recurring book per [[Trioangle Growth Plan]].

### 12.3 What not to do

- Send a fresh capabilities deck. They've seen it.
- Run a discovery call from zero. You have the relationship — pick up where you left off.
- Bundle expansion with discount asks. The deliverable is the value; pricing stays consistent.

---

## 13. 💀 Loss Recovery & Closed-Lost Re-engagement

### 13.1 Closed-lost post-mortem (mandatory for deals >$25k)

Within 14 days of close-lost:

1. **15-minute call with the buyer** — "We're not asking you to reconsider. We're asking what we got wrong, so we don't get it wrong with the next prospect like you."
2. **Capture structured loss reason** — match against [[Trioangle - ICP - Service]] Loss Reasons table.
3. **Update the lead scoring rubric** if the loss reveals a missing signal.
4. **Add to the 90-day re-engagement queue** if the loss reason is "wrong timing" not "wrong fit".

### 13.2 Re-engagement triggers

Wake up dormant closed-lost when:

- They're in the news (new round, new vertical, outage, AI feature announcement)
- The vendor they chose has demonstrably failed (industry chatter, ex-employee posts, public outage)
- A team member from the original deal moves to a new company in our ICP
- 12 months pass with no contact AND a fresh trigger fires

### 13.3 Re-engagement message

> *"[Name] — we lost this deal a year ago, you went with [other vendor / internal team]. Saw [trigger event]. No sales pitch — curious how the original decision turned out. Reply or don't, no follow-up either way."*

Same no-follow-up rule as cold email §5.5. If they reply, restart at Discovery (§6).

### 13.4 Counter-plays per loss-reason pattern

[[Trioangle - ICP - Service]] §💔 Loss Reasons lists the 12 patterns + early-warning signals (strategic). Below is the operational counter-play — what a rep does *during* a deal showing the early-warning signal, before it converts to closed-lost.

| Loss Pattern (per ICP) | Counter-play (during deal) |
|---|---|
| Lost to AI coding tools / "we'll build with Copilot" | Reframe: Copilot accelerates typing, not architecture or domain knowledge — offer free AI Readiness Call (§19.4 AI Coding Tools objection). |
| Lost to hyperscaler's pre-built AI service (P5) | In AI Audit Sprint, honestly recommend SaaS where it fits — disqualify out of wrong-fit deals. Win right-fit ones (custom integration, vertical tuning, data ownership) by being the partner who already said "don't build this yourself" once. |
| Disqualified by data thinness (P5) | During data audit (Sprint week 1), if <3 months clean events or no labels: tell them they need 6 months of instrumentation; offer paid data-instrumentation engagement as a bridge. Most say no — the few who say yes are excellent long-term clients. |
| Stalled on AI fallback/safety concerns (P5) | Lead with service-isolation + automatic-fallback pattern in the *first* technical call, before the prospect raises it. Use §19.4 AI Stability objection handler. |
| Lost on AI compliance / regulatory exposure (P3 esp.) | Bring AI compliance documentation into the AI Audit Sprint by default — model cards, EU AI Act risk classification, data-residency stance, human-in-loop docs, audit-trail logging. Pre-empt rather than scramble. (See §19.4 AI Compliance.) |
| Undercut by nearshore/offshore on price (dev-only) | Reframe to AI scope where domain depth matters and price competition is weaker — pivot to AI Audit Sprint offer; disqualify pure price shoppers on dev-only scope (don't enter the dev margin-compression race). See §10.1 first row. |
| Pivot to in-house hiring | Position as interim team that trains future hires; offer hybrid model. Escalate to Sales Manager for any deal over $50k where this signal fires. |
| Deal stalls indefinitely (no decision) | Force a decision point with a dated AI Audit Sprint slot (primary) or Discovery Sprint (only if scope is explicitly non-AI). Walk away if no movement in 30 days (§3 stage hygiene). |
| Ghosted after proposal | Never send a proposal without a paid sprint preceding it (§3 IMPORTANT callout). If already ghosted, single follow-up with no-follow-up promise (§5.5 template), then move to 90-day passive nurture. |
| Failed code review / technical diligence | Pre-curate vertical-specific code sample library (§16); only send the strongest matching example. If silence after technical deep-dive call, request specific feedback rather than re-pitching. |
| Lost to large consultancy (Accenture/Infy) | Don't compete on brand — compete on senior-engineer access and 3× faster delivery; bring a named enterprise reference. See §19.5 Vendor Comparison. |
| Lost to boutique/premium agency (Thoughtbot, Fueled) | Qualify out early — we are not a design studio; offer to partner, not compete. |
| Cultural / timezone mismatch (non-MENA buyers) | Assign timezone-matched PM from day one; over-index on proactive updates. |

---

## 14. 🧹 CRM Hygiene & Forecast Discipline

### 14.1 Mandatory CRM fields (every open opportunity)

- [ ] Stage (per §3)
- [ ] $ amount (best estimate, not range)
- [ ] Close date (committed, not aspirational)
- [ ] Persona (P1–P5)
- [ ] Vertical (one of 9)
- [ ] Source channel (per ICP Channel Strategy)
- [ ] Trigger event (if outbound)
- [ ] Decision-maker name + title
- [ ] Champion name + title (if different)
- [ ] Sprint type sold or planned (AI Audit / Discovery / none)
- [ ] Next step + date
- [ ] Last activity date

If any field is empty after Stage 1, the opportunity is incomplete — block it from the forecast.

### 14.2 Forecast categories

| Category | Meaning | Probability assumption |
|---|---|---|
| **Commit** | Verbal yes, signed sprint, paper in flight | 90% |
| **Best Case** | Active, multi-touch, sprint discussed but not signed | 50% |
| **Pipeline** | Qualified opportunity with discovery complete | 25% |
| **Worst Case** | Stage 1–2 with no next step in 14 days | 10% (effectively excluded) |

The ratio of these — and how it changes week-to-week — is what the sales manager forecasts off, not the raw open-deal count.

### 14.3 Banned CRM behaviors

- Moving a stage backward without a written reason
- Creating a "stage 6 negotiation" deal without a stage-4 sprint having existed
- "Updating" a close date by sliding it forward every Friday — close date slips >2 times = move to Worst Case
- Closing-won before invoice paid

---

## 15. 📊 KPIs & Cadence

> [!WARNING] Service-ICP-specific KPIs — do not import Product-ICP metrics
> The metrics and ranges below are calibrated for the Service motion (high-touch, $10k–$120k+ engagements, 45–180 day cycles, sprint-gated proposals). They are **not** the same as Product-ICP sales KPIs (low-cost clone-script motion, fast cycles, volume-driven). Don't blend the two when reporting.

### 15.1 Leading indicators (weekly)

| Metric | Target | Review |
|---|---|---|
| Calls / day per rep | 8–12 (mix of cold + scheduled) | Daily standup |
| Demo calls / week per rep | 4–6 | Weekly pipeline review |
| Inbound response time | <2 hours | Daily |
| LinkedIn touches / day per rep | 15–25 | Weekly |
| Stage-2 discoveries completed / week per rep | 3–5 | Weekly |

### 15.2 Conversion KPIs (monthly)

| Metric | Healthy range | Re-examine if |
|---|---|---|
| Lead → Qualified Opportunity | 25–40% | <20% (lead source quality issue) |
| Discovery → Sprint commitment | 40–60% | <30% (discovery skill issue) |
| Sprint → Main proposal | 70–85% | <60% (sprint scoping issue) |
| Proposal → Closed-Won | 40–55% | <30% (pricing / negotiation issue) |
| Average deal size | $25k–$60k blended | Trending down (commodity drift — see ICP §AI-First Rule) |
| Sales cycle length | 45–90 days (P5) · 60–120 (P1/P2) · 90–180 (P3) · 30–60 (P4) | >2× the band — usually a stage-4 stall |

### 15.3 Lagging indicators (quarterly)

- Win rate by persona
- Win rate by source channel (CAC, ACV)
- Closed-won by service line (AI vs Dev) — **realistic target ≥50% AI by end of FY26** for *new logos* (AI is the wedge that lands the relationship). For the *recurring book* including expansion revenue from existing accounts, expect ~40–60% AI / 40–60% non-AI per [[Trioangle Growth Plan]] Repeat-Buy Cadence — that's the realistic mix once accounts are in steady state, not a failure mode. Track new-logo and expansion AI shares separately.
- Active accounts at end of quarter (target growth from ~30 baseline per [[Trioangle Growth Plan]])
- Repeat-buy rate within 12 months of first close (P5 target 70%; P3/P4 target 50%; P1/P2 not tracked — opportunistic only)

---

## 16. 🧰 Materials & Tooling Library

What every rep needs at hand. Track the status of each.

| Asset | Owner | Status legend |
|---|---|---|
| Vertical-specific portfolio (10+ engagements per vertical) | Marketing | `[✅]` available · `[🔧]` in build · `[❌]` missing |
| Vertical-specific case studies with outcome metrics | Marketing | |
| Load testing reports (P1 / P5) | Delivery | |
| Security testing reports | Delivery / Compliance | |
| Server architecture diagrams (anonymized) | Delivery | |
| ROI calculator (cost vs in-house) | Sales Ops | |
| Standard SoW template + IP transfer clause | Legal | |
| Sprint kickoff deck (lightweight — engineer-led) | Pre-sales | |
| Engineering team bios (LinkedIn linked) | Talent | |
| Reference list with named clients willing to take a call | AE + AM | |
| AI feature case studies per vertical (P5 critical) | Marketing | |
| AI Audit Sprint deliverable template | Pre-sales | |
| Demo seed data per vertical | Delivery | |
| Competitor SWOT / demo notes | Sales | |

> [!IMPORTANT] Tracking
> Every asset shared with a prospect should be DocSend-tracked (or equivalent). Engagement on the document — pages viewed, time spent, re-opens — is a leading signal for forecasting and tells you who else inside the buyer's organization saw it.

---

## 17. 🎓 New-Rep Onboarding Checklist

Week 1:
- [ ] Read [[Trioangle - ICP - Service]] end-to-end (this is the foundation; everything else assumes it)
- [ ] Read this playbook §1–§5
- [ ] Shadow 5 live discovery calls
- [ ] Demo the platform yourself across web + Android + iOS

Week 2:
- [ ] Run 2 discovery calls with manager observation
- [ ] Pass internal demo certification (web + Android + iOS, on a buyer-spec'd device)
- [ ] Memorize the AI Audit Sprint sales line (§8.2) verbatim
- [ ] Memorize the Trust & IP positioning rule (§Top-of-doc) verbatim

Week 3–4:
- [ ] First independent discovery → sprint → proposal cycle, with manager review at each stage
- [ ] Closed-lost call on someone else's deal, observation only

Month 2:
- [ ] First closed-won independently
- [ ] Quarterly review participation

---

## 19. 🛡️ Objection Response Library

> [!NOTE] Where this lives
> [[Trioangle - ICP - Service]] §🛡️ Objection Handling lists *which* objections exist for this ICP and *what they tell you about buyer psychology* (strategic). This section gives the *response copy* a rep delivers in the room (operational). The ICP's response paragraphs were moved here in the 2026 split — if a section here ever conflicts with the ICP, the ICP wins on objection identification, this playbook wins on response wording.

### 19.1 Trust / quality / team

**🔒 Code Quality / Trust**
*Objection:* *"How do I know your code is high quality and not just put together by juniors?"*
> Strict QA pipelines (unit, integration, E2E), mandatory peer code reviews, full GitHub repo access from Day 1. We operate as team augmentation — attending your daily standups, not disappearing into a black box.

**Evidence:** `[✅]` GitHub contribution history screenshots · `[✅]` Sample code coverage reports · `[🔧]` Anonymized code review samples · `[✅]` Sample architecture review documents

---

**👥 Team Seniority**
*Objection:* *"Are these senior engineers or are you going to put a junior on my project?"*
> Every project is staffed with at least one dedicated senior architect (8+ years experience) who does code review on every PR. We'll introduce you to the specific team before you sign — no bait-and-switch.

**Evidence:** `[✅]` Team bio library (LinkedIn profiles) · `[🔧]` Architect CV samples · `[✅]` "Meet the Team" pre-contract call offer

---

**📡 Communication / Abandonment Risk**
*Objection:* *"We had a terrible experience with an agency that went quiet 3 months in."*
> Dedicated PM for your timezone provides daily Slack updates, weekly sprint demos via Zoom, and a shared project dashboard. If we go silent for 48 hours without warning, you get a 5% contract credit. That's how confident we are.

**Evidence:** `[✅]` Sample Slack communication logs (anonymized) · `[✅]` Sprint review deck template · `[✅]` Named client reference for communication reliability

### 19.2 Legal / commercial

**📄 IP Ownership**
*Objection:* *"Do we own the code at the end of this?"*
> 100%. For all custom development engagements — whether new builds or platform rebuilds — IP is entirely transferred to your company upon final payment. Written explicitly into the contract. You own the repo, the server infrastructure, and all documentation.

**Evidence:** `[✅]` Standard Contract IP Transfer clause · `[✅]` Escrow agreement template · `[✅]` Repo organization transfer protocol document

---

**💸 Budget / ROI**
*Objection:* *"$40,000 is a lot of money. How do we justify this?"*
> Rebuilding on a broken architecture at scale costs more in server bills, emergency patches, and engineer turnover than the project itself. Our clients typically recover the investment in 6–9 months through reduced downtime costs, faster feature velocity, and lower server costs. We can build you an ROI model.

**Evidence:** `[🔧]` Infrastructure cost ROI calculator · `[✅]` Case study: pre-rebuild vs post-rebuild AWS spend · `[🔧]` Feature velocity improvement data (before/after)

---

**🪪 Authority / Approval**
*Objection:* *"This looks good but I need CEO / CFO / board sign-off — what do I bring them?"*
> We help you build the business case. Standard package: (a) one-page ROI vs in-house cost ($X agency fee vs $Y annual cost of equivalent FTEs over the same delivery window); (b) named client reference list willing to take a 20-minute call with your decision-maker; (c) the AI Audit Sprint deliverable as the artifact your board can review (data audit + feature shortlist + reference architecture); (d) structural-guarantee summary (Day-1 GitHub access, IP transfer, 48-hour SLA credit) — the de-risking your procurement and legal teams need to sign. We've sat in those board meetings before; we know what gets approved and what stalls.

**Evidence:** `[🔧]` ROI calculator template (agency vs in-house) · `[✅]` Reference call introductions · `[✅]` Sample structural-guarantee summary one-pager · `[🔧]` Board-deck template adapted from past approved engagements

---

**🛋️ Inertia / Status Quo**
*Objection:* *"Our current solution works. Why change?"*
> The honest framing: it works *today*. The hidden costs of staying are usually three things — feature velocity slowing as your engineers absorb more maintenance load (your roadmap drifts); AI competitive gap widening as vertical competitors ship dispatch / pricing / fraud / matching while you don't (unit economics divergence); platform scaling cliff that's invisible until it isn't (the dispatch latency or payment race-condition that cost a competitor 4 hours of revenue last quarter). We're not here to tell you to rip and replace; we're here to do an AI Audit Sprint that names which of those three is closest, with a fixed-price quote for the one feature that addresses it. If we tell you to wait six months, that's the answer. The status quo is rarely the cheapest option once you measure it.

**Evidence:** `[🔧]` "Hidden Costs of Status Quo" diagnostic checklist · `[✅]` Feature velocity decline pattern data (anonymized) · `[✅]` Vertical competitor AI feature shipping timeline · `[🔧]` Sample 6-month "wait" recommendation

### 19.3 Technical risk

**⚠️ Technical Risk**
*Objection:* *"What happens if the architecture you design doesn't work at our scale?"*
> Load testing benchmarks built into every project. Before launch, we simulate 3× your projected peak load and document the results. If performance doesn't meet the agreed SLA, we fix it at no additional cost.

**Evidence:** `[🔧]` Load testing report template · `[✅]` Performance SLA contract clause · `[✅]` Live performance dashboard sample (Grafana/Datadog)

---

**⏰ Timeline**
*Objection:* *"We need this in 8 weeks. Is that realistic?"*
> The honest answer: it depends on scope. Let's do a 2-week paid sprint first to scope rigorously, identify the critical path, and give you a guaranteed delivery timeline:
> - **AI Audit Sprint** ($1.5–4k, credited) — for AI feature scope. Deliverables: data audit, AI feature shortlist, reference architecture, build-vs-buy recommendations, fixed-price quote with A/B test framework.
> - **Discovery Sprint** ($1.5–4k, credited) — for platform rebuild / custom-dev scope without an AI angle. Deliverables: ERD, system architecture, wireframes, critical path, fixed-price quote with milestone dates.
>
> No surprises either way.

**Evidence:** `[✅]` AI Audit Sprint deliverable samples · `[✅]` Discovery Sprint deliverable samples (ERD, wireframes) · `[✅]` Sprint plan template · `[✅]` Fixed-price estimate example

### 19.4 AI-specific objections

**🤖 AI Coding Tools**
*Objection:* *"Can't our internal engineers just use GitHub Copilot / ChatGPT to build AI features themselves?"*
> AI coding tools help engineers write code faster — they don't give your engineers domain expertise in ML/AI system design, RAG pipelines, or production LLM integration. More importantly, they don't know your vertical. We've already built AI features inside ride-hailing dispatch systems, marketplace fraud detection, and logistics demand forecasting — your engineers would spend 6+ months learning what we already know. Use Copilot for productivity; use us for domain-specific AI delivery.

**Evidence:** `[🔧]` AI feature case study (ride-hailing or logistics) · `[🔧]` AI Engineering capability overview (RAG, LLM integration, ML pipelines, agents) · `[🔧]` Free AI Readiness Call → paid AI Audit Sprint funnel (see §8 + ICP AI Funnel)

---

**🧪 AI Stability**
*Objection:* *"We're worried AI features will make our platform unstable or unpredictable."*
> Legitimate concern. AI features run as isolated services with fallback logic to rule-based defaults. If the model underperforms below a defined threshold, the system reverts automatically. We build AI as an enhancement layer, not a dependency. Your platform stays reliable; the AI improves it incrementally.

**Evidence:** `[🔧]` Architecture diagram showing AI service isolation pattern · `[✅]` Fallback logic design doc · `[🔧]` Model performance monitoring dashboard sample

---

**🧪 AI Quality**
*Objection:* *"How do I know your AI features actually work? AI is non-deterministic — what's your equivalent of test coverage?"*
> Three layers. (1) Feature-specific evaluation harness — dispatch optimization → latency distributions + match-quality A/B; fraud → precision/recall on held-out validation; RAG → retrieval@k against curated query sets. (2) A/B testing in production against a rule-based baseline before full rollout — shadow → canary → percentage rollout with named success metrics. (3) Ongoing observability with drift detection and automatic revert if model performance degrades below a contracted threshold. Your engineers see all three in production from Day 1. AI quality is verifiable, not faith-based.

**Evidence:** `[🔧]` Sample evaluation harness (dispatch / pricing / fraud) · `[🔧]` A/B test framework template · `[🔧]` Drift detection + auto-revert architecture · `[✅]` Day-1 observability dashboard (Grafana + LangSmith / Arize)

---

**🛡️ AI Compliance & Regulatory**
*Objection (P3 esp.):* *"What about EU AI Act, HIPAA + AI, sector-specific AI regulations? Our legal team will block this."*
> Legitimate procurement gate. We bring AI compliance documentation into every AI Audit Sprint by default — not as an afterthought. Standard deliverables: model cards (training data, intended use, known limitations, bias evaluation); EU AI Act risk classification (most platform AI features land in *limited* or *minimal risk* — we document the assessment); data-residency stance (inference geo-locked where required, EU data staying in EU regions); human-in-loop documentation for any decision-impacting feature; audit-trail logging for AI decisions (who, when, which model version). For sector-specific rules (HIPAA + AI, financial AI, automotive ADAS), we document the requirement and the architecture that satisfies it. Not compliance theater — the documentation procurement legal needs to sign off.

**Evidence:** `[🔧]` Model card template · `[🔧]` EU AI Act risk classification framework · `[🔧]` Sector-specific compliance docs (HIPAA + AI; PCI-DSS + AI for financial fraud) · `[🔧]` AI decision audit-trail architecture

### 19.5 Competitive

**⚔️ Vendor Comparison**
*Objection:* *"We're also talking to [competitor agency]. Why should we choose you?"*
> Ask them how many platforms in your exact vertical they've shipped in the last 12 months. We've delivered 800+ platforms (cumulative since 2015 across 150+ countries) spanning 9 verticals — that domain knowledge is the moat, and what makes our AI integration credible in *your* vertical. The edge cases — dispatching logic, route optimization, multi-vendor commission flows, real-time tracking, availability engines, multi-tenant architecture — are already in our muscle memory. They'll be learning on your dime; we'll be applying the AI on top of patterns we already understand.

**Evidence:** `[✅]` Vertical-specific portfolio (10+ engagements per vertical) · `[✅]` Domain expertise checklist · `[✅]` 800+ platform delivery track record since 2015 (cumulative — distinct from AI delivery count, see ICP Positioning caveat)

> [!IMPORTANT] 800+ stat — sales-floor disambiguation rule
> "800+" counts cumulative *platform* deliveries since 2015, not AI features. The AI delivery count is much smaller and growing. Anchor positioning on **vertical depth**, not AI delivery volume. Avoid "we've built AI features in 800+ platforms" — conflates the two and misrepresents the AI track record.

---

## 20. 🔧 Maintenance

| Trigger | Update needed |
|---|---|
| 10 closed-lost deals reviewed | §3 stage exit criteria · §4 scoring · §10 negotiation counters · ICP Loss Reasons table |
| New competitor surfaces | §10 negotiation · ICP Competitive Positioning |
| New vertical added | §16 materials · ICP firmographics |
| Pricing change | §9 floors and matrix |
| New AI feature shipped to a client | §16 case study list · ICP P5 proof |
| Quarterly OKR review | §15 KPI ranges |

**Last updated:** 2026-05-09 — Sales/strategy split. ICP retains strategic content (personas, pains, qualifying criteria, channel mapping ratings, loss patterns + early-warnings, objection topics, competitive positioning, validation plan). This Playbook now owns all execution: full Channel Execution Sequences (§5), Direct P3/P4 inbound workflow (§3.1), AI Funnel disambiguation (§8.1a), Pre-Sales Sprint sales lines (§8.2), per-loss-reason counter-plays (§13.4), and the comprehensive Objection Response Library (§19) covering all 14 objections. Originally derived from [[Trioangle - ICP - Service]] (2026-04-05 review pass); now operates alongside it as the operational counterpart.
