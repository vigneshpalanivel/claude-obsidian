---
type: concept
title: "Trioangle Service Sales Playbook"
created: 2026-05-09
updated: 2026-05-09
tags:
  - concept
  - trioangle
  - sales
  - playbook
  - service-icp
  - operating-layer
status: current
related:
  - "[[Trioangle]]"
  - "[[Trioangle Service ICP]]"
  - "[[ICP-Service-Trioangle]]"
  - "[[Trioangle Growth Plan]]"
  - "[[Trioangle 2.0 AI Pivot Plan]]"
  - "[[Trioangle-Sales-Operations]]"
  - "[[Sales-Playbook-Service-Trioangle]]"
sources:
  - "[[Sales-Playbook-Service-Trioangle]]"
---

# Trioangle Service Sales Playbook

The **operating layer** for selling Trioangle's Service offering (AI Engineering — primary; Web/Mobile Custom Dev — secondary). Companion to [[Trioangle Service ICP]], which is the strategy layer.

> [!IMPORTANT] Strategy vs Operating Layer — Why They're Separate
> [[Trioangle Service ICP]] tells reps *who* we sell to and *why*: personas, pains, channels, objections, loss reasons, competitive positioning. It does **not** tell them what to do Tuesday morning.
>
> The Sales Playbook fills that operating gap with scripts, scoring, stage exit criteria, pricing guardrails, and handoff checklists. It is **deliberately separated** from the ICP so the two never drift into duplicate sources of truth. Where the playbook references strategic framing, it wikilinks back to the ICP rather than restating it. **If the playbook ever conflicts with the ICP, the ICP wins and the playbook gets corrected.**

> [!WARNING] Why a Service-Specific Playbook Was Needed
> Trioangle's pre-existing **Sales Initiatives List** and **Sales KPIs List** are scoped to the **Product ICP** (clone-script motion — $999 entry price, volume-driven, fast cycles). Importing them into Service-ICP context produces wrong floors ($999 vs $10k–$15k), wrong cycle expectations (days vs months), and wrong KPI bands (call-volume vs deal-economics). Both legacy files were formally marked `scope: product-icp-only` on 2026-05-09 in the same session this playbook was created. See [[Trioangle-Sales-Operations]] (built on those legacy files) for the scope-warning callout. Service-ICP-specific Initiatives and KPI docs are pending — the Playbook §15 currently holds the only Service-calibrated KPI ranges.

Source: [[Sales-Playbook-Service-Trioangle]]

---

## Two Non-Negotiable Framing Rules

Both inherited from [[Trioangle Service ICP]] — repeated at the top of the playbook because reps break them most often:

1. **AI-first, dev-second.** Default to AI Audit Sprint as the entry product unless the inbound brief is explicitly a non-AI rebuild. Lead every conversation, email, and demo with the AI angle if there is one.
2. **Defend trust with structural guarantees, not adjectives.** Day-1 GitHub access · IP transfer in writing · 48-hour communication SLA with contract credit · pre-contract engineer introduction · paid Sprint with escape hatch.
   - **Banned vocabulary**: "transparent," "passionate," "high-quality," "world-class." Every losing vendor used those words too.

---

## 7-Stage Pipeline Shape

Each stage has explicit exit AND kill criteria. Not stage-stalling-friendly: **a stage that doesn't move in 30 days is not a real opportunity** — force movement or close-lost.

| # | Stage | Advance when | Kill when |
|---|---|---|---|
| 0 | Lead | Qualified per scoring rubric (≥40 pts) AND named persona match | <40 pts after 14 days OR fails Existing-Operator Filter |
| 1 | Qualified Opportunity | Discovery call booked within 7 days | No call booked within 14 days |
| 2 | Discovery Complete | AI Audit / Discovery Sprint pitched and considered | Refuses paid sprint AND won't commit to demo |
| 3 | Demo Delivered | Sprint commitment OR signed proposal in flight | 14 days silence post-demo |
| 4 | Sprint Active | Sprint deliverable accepted; main proposal scoped | Deliverable rejected OR "thanks, going internal" |
| 5 | Proposal Submitted | Verbal commit + redlines on SoW | 21 days no redlines OR verbal "no" |
| 6 | Negotiation | Signed SoW + first invoice paid | Buyer disengages after 2 redline rounds |
| 7 | Closed-Won | First invoice paid, kickoff scheduled | n/a — handoff to delivery |

> [!IMPORTANT] No Proposal Without a Sprint
> Per ICP Loss Reasons, "Ghosted after proposal" is a top loss driver because cold proposals get ignored. **Default rule: no proposal without a paid AI Audit Sprint or Discovery Sprint preceding it.** Exceptions: P4 MENA (relationship gates trust, not sprints); P3 on formal RFP. Document exceptions in CRM.

---

## Lead Scoring Rubric — Structure

Score each new lead within 24 hours. ≥40 = qualified; <40 = nurture or disqualify.

**Positive signals (weighted):**
- Persona match (P1–P5): +15 · Vertical match: +10 · Geography match: +5 · Existing-Operator Filter passes: +15 (hard requirement) · Stated budget meets floor: +10 · Trigger event in last 90 days: +10 · Reply within 48 hrs: +5 · Internal tech/product owner identified: +5 · AI feature mentioned: +10 · Peer referral / warm intro: +20

**Hard disqualifiers (large negatives):**
- Pre-revenue / pre-launch: −25 (route to Product ICP)
- Solo non-technical founder, no business: −25
- Equity-only or deferred-payment ask: −50 (no exception)
- "Build Uber in 3 weeks for $8k"-class brief: −50
- Strong in-house team handling internally: −15

**Existing-Operator Filter is non-negotiable.** Even with a high score, failing the filter (no $1M+ ARR, no 12+ months operational, no revenue traction) disqualifies. This is the gate that keeps the recurring-revenue thesis valid per [[Trioangle Growth Plan]].

---

## Pricing Floors (Do Not Sell Below)

| Engagement | Floor | Note |
|---|---|---|
| Single AI feature build | **$15,000** | Below this, lose money on senior-engineer staffing |
| AI multi-feature program | $40,000 | Tied to AI roadmap from Audit Sprint |
| Web/mobile rebuild (P1/P2) | **$10,000** | Hard floor; below this disqualify |
| Enterprise digital transformation (P3) | $50,000 | Procurement overhead eats lower margins |
| MENA flagship (P4) | $30,000 | Often stretches to $80k–$120k+ |
| AI Audit Sprint / Discovery Sprint | $1,500 | Below this is loss-leader theater |

> [!IMPORTANT] Output/Deliverable-Based Pricing Only
> Trioangle does not sell retainers, hourly billing, or per-engineer subscriptions for the Service motion. Every engagement is **fixed-price for a defined deliverable** with named milestones. Reps quoting any of those models are out of bounds. This aligns with [[Trioangle Growth Plan]] commercial-model policy and the operating-model decision documented separately.

### Discount Approval Matrix

| Discount | Approver | Required justification |
|---|---|---|
| 0–5% | AE | None — closeout courtesy |
| 5–10% | Sales Manager | Written justification (timing, multi-project, named reference) |
| 10–20% | Founder / CRO | Strategic logo, repeat customer, multi-project commit |
| >20% | Founder-only | Exception — must be paired with multi-project commit or strategic value |

**Insufficient justifications** (explicitly named in the playbook): "they asked," "competitor was cheaper," "it'll close the deal." If price is the only barrier, the deal wasn't qualified — see scoring rubric.

---

## Always-In-Scope Structural Guarantees

Bundled into every engagement and **not unbundled for discount**. These are how Trioangle wins; they are *how* the trust-rule from the ICP is operationalized commercially.

- Day-1 GitHub repo access (in buyer's organization)
- Full IP transfer on final payment
- Senior engineer code review on every PR
- 48-hour communication SLA with **5% contract credit penalty** if breached
- One-time team introduction call before signing
- Sprint deliverable handoff (audit / spec / architecture)
- 30-day post-launch warranty (bug fixes only)

---

## Negotiation Discipline

For every common buyer ask, the playbook names a defensible counter AND an explicit walk-away signal. Walking is a tool, not a failure.

**Walk-away triggers (do not close):**
- Buyer cannot pass the Existing-Operator Filter
- Buyer demands removal of structural guarantees (the trust-rule mechanisms)
- Buyer's data readiness is below threshold and they refuse the bridge engagement
- Buyer's stated outcome is "AI for the board deck," not a metric lift
- Buyer insists on hourly / retainer / per-engineer billing (wrong product fit)

Document every walk in CRM with a structured loss reason matching the ICP Loss Reasons table.

---

## Service-Specific KPI Ranges

> [!WARNING] Do Not Blend with Product-ICP KPIs
> The ranges below are calibrated for Service-ICP economics ($10k–$120k+ engagements, 45–180 day cycles, sprint-gated proposals). They are **not** comparable to Product-ICP volume metrics from the legacy [[Trioangle-Sales-Operations]].

**Conversion KPIs (monthly review):**
- Lead → Qualified Opportunity: 25–40%
- Discovery → Sprint commitment: 40–60%
- Sprint → Main proposal: 70–85%
- Proposal → Closed-Won: 40–55%
- Average deal size: **$25k–$60k blended** (trending down = commodity drift, see ICP §AI-First Rule)

**Sales cycle by persona:**
- P5 (AI-Forward): 45–90 days
- P1/P2 (Scaling CTO / Founder-Operator): 60–120 days
- P3 (Enterprise): 90–180 days
- P4 (MENA): 30–60 days post-relationship-build

**Strategic targets (quarterly):**
- ≥60% of closed-won by service line = AI by end of FY26 (per [[Trioangle 2.0 AI Pivot Plan]])
- Active accounts growing from ~30 baseline (per [[Trioangle Growth Plan]])
- P5 repeat-buy rate within 12 months: target 70%

---

## Account Expansion — Targets the Active ~30, Not the Historical 800

Per [[Trioangle Growth Plan]], Trioangle has delivered 800+ platforms cumulatively but only ~30 are active accounts as of April 2026. Expansion plays target the active 30. **"We worked together 5 years ago" outreach is forbidden** — those are cold leads, not active accounts.

Persona-specific account cadence:

| Persona | Cadence | What to bring |
|---|---|---|
| P5 | Quarterly AI roadmap review (no slides) | What's working in production · what's next from Audit shortlist · what's blocking |
| P4 (MENA) | Monthly WhatsApp + quarterly in-person | Industry insight · light updates · personal news |
| P3 | Quarterly executive readout (formal deck) | Outcome metrics vs board KPIs · change-management progress · compliance status · next-phase scope |
| P1 / P2 | Post-launch + 6-month + annual | Performance metrics vs SLA · feature backlog if applicable |

---

## Sales → Delivery Handoff

At Stage 7 (Closed-Won, first invoice paid). Mandatory **30-min handoff call** with BA/PM. Sales remains as warm-handoff support for first 30 days.

**Long-term account ownership defaults:**
- P5 — same person across AI projects (relationship continuity is the cadence engine)
- P3 — formal Account Manager
- P4 — AE owns, never transitions (relationship is the unit of cadence, not the project)

---

## Closed-Lost Post-Mortem (>$25k deals)

Mandatory within 14 days of close-lost. **15-min call with the buyer**:
> *"We're not asking you to reconsider. We're asking what we got wrong, so we don't get it wrong with the next prospect like you."*

Capture structured loss reason against ICP Loss Reasons table. Update lead scoring rubric if the loss reveals a missing signal. Add to 90-day re-engagement queue if loss reason is "wrong timing," not "wrong fit."

---

## Open Calibration Items

The playbook ships with explicit acknowledgment of what's *not* yet data-backed:

- **Lead scoring rubric weights** — judgment-based, not derived from conversion data. Re-score the closed-lost pile quarterly.
- **KPI target ranges** — industry-typical, not Trioangle-specific. Calibrate after one quarter of clean attribution data.
- **Pricing floors** — aligned with ICP budget bands; AI-feature $15k floor is conservative and may need to rise if senior-engineer fully-loaded cost is higher than assumed.
- **Discovery question banks** — opinionated, not battle-tested. Swap in better questions as the team accumulates real-world experience.
- **Per-rep monthly deal target** — placeholder pending Service-ICP-specific Initiatives doc.

---

## Connections

- [[Trioangle Service ICP]] — strategy layer this playbook operationalizes
- [[ICP-Service-Trioangle]] — original Service ICP source document
- [[Trioangle Growth Plan]] — Track 2 thesis, ~30 active customers reality, volume targets
- [[Trioangle 2.0 AI Pivot Plan]] — AI-first service line priority, AI Audit Sprint as entry product
- [[Trioangle-Sales-Operations]] — legacy concept built from Product-ICP-only docs (scope warning added)
- [[Sales-Playbook-Service-Trioangle]] — source page for this playbook
- [[Trioangle]] — the company entity
