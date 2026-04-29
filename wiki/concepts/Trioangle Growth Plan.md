---
type: concept
title: "Trioangle Growth Plan: Result-Based Recurring Revenue Architecture"
status: current
created: 2026-04-25
updated: 2026-04-26
tags:
  - trioangle
  - growth
  - recurring-revenue
  - result-based
  - outcome-based
  - strategy
related:
  - "[[Trioangle 2.0 AI Pivot Plan]]"
  - "[[Outcome-Based Pricing]]"
  - "[[AI Services Business Model]]"
---

# Trioangle Growth Plan: Result-Based Recurring Revenue Architecture

## The Core Problem: Services Trap

Project revenue resets every month. You close a ₹5L project, deliver it, and then revenue drops back to zero. Growth feels impossible because there's no base — every month starts from scratch.

The fix is recurring revenue — but **not retainers**. Once you have ₹5L of result-based recurring delivery (output-tied subscriptions + outcome-based deals + productized hosting), you start every month already at ₹5L and layer new projects on top. That's what growth feels like.

**Revenue = Projects × Ticket** → resets monthly, no compounding
**Revenue = Result-Based Recurring + New Projects** → compounds; growth becomes visible

---

## Why Retainers Don't Work Post-Vibe-Coding

The classic "Annual Maintenance Contract" / monthly retainer pitch fails harder than ever in 2026:

- **Fear-based framing** — "pay in case something breaks" — clients don't feel they're buying anything
- **No visible monthly deliverables** — what do they actually get each month?
- **Wrong positioning** — feels like insurance, not investment
- **AI tools made it worse** — clients can vibe-code small fixes themselves; "support availability" is a weaker pitch every quarter
- **Top MNCs are abandoning it** — TCS, Infosys, Accenture are pivoting from retainer to result-based pricing for the same reason

**The fix: every recurring rupee is gated on a shipped output or a measurable outcome.** No bundled-availability pricing. No "AMC." Clients buy deliverables or business results — never "we're here if you need us."

The two recurring shapes Trioangle uses:

1. **Workflow-based recurring delivery** — fixed monthly fee, but tied to a specific shipped deliverable each month. Cancel-anytime if a month's deliverable doesn't ship.
2. **Outcome-based deals** — variable pricing tied to a business metric (per-lead, per-resolved-ticket, % revenue lift). See [[Outcome-Based Pricing]].

Hosting is the one exception that looks subscription-shaped but isn't a retainer — it's a productized service (you pay for hosted infra, you get hosted infra).

---

## Customer Mortality: The Real Recurring-Revenue Bottleneck

Of 800+ projects delivered historically, only **~30 customer businesses are still operating** as of April 2026 — a ~96% mortality rate. The "lack of recurring revenue" isn't only a pricing-model problem; it's a customer-survival problem. Even with retainer pricing from day one, ~770 of those clients would have churned via business death, not service dissatisfaction.

**What this means for the recurring stack:**

- **The realistic recurring base is ~30, not 800.** The historical "delivered" number is a credibility asset for sales materials only — not an upsell pipeline. Treat the 800 as graveyard, not dormant inventory.
- **"Reactivating dormant operators" is mostly fishing the graveyard.** A small subset (likely under 10) are alive but moved off Trioangle's stack — those are the only real reactivation targets. Do not budget recurring growth on imagined dormant revival at scale.
- **Recurring revenue depends on customers who survive.** A clone-script buyer with no funding, no GTM, and no operational experience churns within 12–18 months regardless of pricing model. The recurring book compounds only when the underlying customer business compounds.
- **ICP qualification at sale is now a recurring-revenue lever, not just a delivery-margin lever.** Filtering out high-mortality buyers protects the recurring book *before* it's built. See ICP Qualification under [Non-AI Business Foundations](#non-ai-business-foundations).

**Tier-by-tier implication for the stack below:**
- **Tier 1 (Hosting + Ops)** is resilient to high mortality — you collect during operating months and lose customers gracefully when their business shuts down. Safe to scale across the surviving base.
- **Tier 2 (Monthly Feature Drop)** only works with customers whose business is actually growing. Qualify hard before pitching — most of the 30 may not qualify.
- **Tier 3 (Sprint-as-a-Service)** requires funded or revenue-generating customers. Realistically a 1–2 client tier at current ICP, not a scale tier.
- **AI Workflow / Outcome Deals** (per [[Trioangle 2.0 AI Pivot Plan]]) — the biggest unlock here is shifting ICP itself. Selling AI to higher-survival customer profiles (funded startups, established SMBs) is how you escape the mortality drag, not just the pricing drag.

**Cohort decay & replacement velocity:**

The surviving 30 are not a static base — they continue to die off at the underlying mortality rate. Even a conservative 5%/quarter business-death rate means recurring revenue erodes by ~₹25–30K/month every quarter without new acquisition.

- **Steady-state replacement target:** ~6 new ICP-qualified customers per year to hold ₹5–6L/month flat (5%/quarter decay across mixed tiers).
- **Growth target** (₹8–10L/month): ~10–12 new qualifying customers per year, attached to recurring at sale.
- **Source:** new-buyer acquisition via [[Trioangle Product ICP]] / [[Trioangle Service ICP]] channels — not dormant reactivation.
- **What this kills:** any plan that treats ₹5–6L recurring as a one-time push. The recurring book is a leaky bucket — acquisition velocity is the tap, ICP qualification is the bucket.

---

## 3-Tier Result-Based Recurring Delivery

Each tier is a fixed monthly fee tied to a specific shipped deliverable — not availability. Cancel-anytime if a month's deliverable doesn't ship. AI-specific recurring (AI Workflow Subscription, AI Outcome Deals) lives in [[Trioangle 2.0 AI Pivot Plan]] — this doc covers the non-AI tiers.

### Tier 1 — Hosting + Ops Pack ₹8,000–15,000/month
**Target:** Small clients, finished projects, low-touch
**Productized service (not a retainer)** — you pay for hosted infra and reports; if you don't get them, you cancel.

**Monthly deliverables:**
- Hosted production environment (servers, SSL, backups, monitoring)
- Monthly uptime + performance report
- Monthly dependency/security scan + applied minor patches
- Quarterly hosting health audit document

**Positioning:** "Your app stays hosted, monitored, patched. You get a monthly report. Cancel anytime."

**Why it isn't a retainer:** the deliverable is the running infra + the monthly report. You can verify the report exists. There's no "hours bank" or "support availability" promise.

---

### Tier 2 — Monthly Feature Drop ₹35,000–50,000/month
**Target:** Active businesses that want their product getting better, not just maintained

**Monthly deliverables:**
- 1 shipped feature or UI improvement per month (scoped at month start, shipped before month end)
- Monthly analytics review document with 3 prioritized recommendations
- Monthly delivery video walking through what shipped
- Quarterly strategy session (1 hour)

**Positioning:** "Every month, one new feature ships. Cancel any month a feature doesn't ship."

**Why it isn't a retainer:** the deliverable list is concrete (feature shipped, analytics doc, video). Missed month = automatic credit OR cancellation, customer's choice.

---

### Tier 3 — Sprint-as-a-Service ₹80,000–1,00,000/month
**Target:** Product companies, SaaS, high-growth startups

**Monthly deliverables:**
- 1 full sprint cycle delivered (2 features OR 1 major module shipped to production)
- Sprint planning + backlog grooming call (start of month)
- Sprint demo at end of month
- Code review + deployment + handover doc

**Positioning:** "Outsourced product engineering team. One monthly invoice, one shipped sprint, predictable delivery."

**Why it isn't a retainer:** the deliverable is "sprint shipped to production." If the sprint doesn't ship, customer doesn't pay that month (or cancels).

---

### Premium Tier — AI Workflow Subscription / AI Outcome Deals
For customers ready to add AI on top, see [[Trioangle 2.0 AI Pivot Plan]] for:
- **AI Workflow Subscription** ₹50K–₹75K/month (1 AI workflow shipped per month)
- **AI Outcome Deals** — per-lead, per-resolved-ticket, or % revenue lift pricing

Sold as adjacent products to Tier 1-3 customers, not as a tier upgrade.

---

## Hosting Margin Play (Tier 1 Engine)

This is the fastest path to passive recurring revenue and the easiest sell. Hosting is treated as a productized service, not a retainer — clients pay for hosted infra they receive, not for "support availability."

**How it works:**
1. Identify clients where you built and deployed their app
2. Offer to take over hosting management — handle servers, SSL, backups, monitoring
3. Bill client ₹8,000–12,000/month for "Hosting + Ops Pack" (Tier 1)
4. Actual cost on AWS/GCP/Hetzner: ₹2,000–4,000/month
5. Net margin: ₹5,000–8,000 per client, near-zero ongoing effort

**Why clients say yes:**
- They don't want to manage servers
- They're already paying someone or doing it badly
- "Handled by Trioangle" is a clean, trusted answer
- Cancel-anytime + monthly uptime report makes it feel like a service, not insurance

**Revenue math at scale (real-world bound by ~30 currently active customers):**
| Clients | Margin/Client | Monthly Revenue |
|---------|--------------|-------------|
| 10 | ₹6,000 | ₹60,000 |
| 20 | ₹6,000 | ₹1,20,000 |
| 30 | ₹7,000 | ₹2,10,000 |

30 hosting clients = ₹2.1L/month with near-zero ongoing effort. **Reaching 40+ is bottlenecked by customer mortality, not sales effort** — most of the 770 dormant accounts are dead businesses, not pausable customers. Growth past 30 requires new-buyer hosting attach via [[Trioangle Product ICP]] — the dormant-operator pool is a graveyard, not a pipeline.

**Hosting also erodes without replacements.** At ~5%/quarter customer mortality, you lose ~1.5 hosting clients/quarter to business shutdown. Hold-steady velocity is **~6 new hosting attaches/year**; without that, the table above erodes by roughly ₹10K/month every quarter.

---

## Project-to-Recurring-Delivery Conversion

The highest-leverage moment to sell recurring delivery is **the day the project goes live** — satisfaction is at its peak, the client trusts you, they're already thinking about what's next.

**Go-live conversation script (Tier 1 — Hosting + Ops):**

> "The project is live — congratulations. Want us to handle hosting, backups, monthly health reports, and security patches? It's ₹[10K]/month, you get a monthly uptime + ops report, and you can cancel anytime. Want me to set it up?"

**Go-live conversation script (Tier 2 — Monthly Feature Drop):**

> "You'll want to keep adding features without re-quoting each one. We can ship one feature per month for ₹[40K] — analytics doc, demo video, the works. If a month goes by without a feature shipping, you don't pay that month. Want to start next month?"

**Go-live conversation script (Tier 3 — Sprint-as-a-Service):**

> "Most product teams need a full sprint cycle every month. We deliver one sprint of 2 features or 1 module shipped to production for ₹[90K]/month. Sprint demo, code review, handover doc — all included. Cancel anytime. Want our team running your monthly sprint?"

Key principles:
- Offer it as the obvious next step, not a separate sales pitch
- Name a specific tier based on what you know about their needs
- Anchor the conversation on the **shipped deliverable**, not "support" or "availability"
- "If a month doesn't ship, you don't pay" is the key phrase — it inverts the AMC pitch
- Don't over-explain — short and confident closes better

---

## Re-Pitch for AMC Rejectors

For clients who already said no to your old ₹500/month AMC offer — reframe as result-based delivery, not insurance:

**Step 0 — verify the business is still operating before sending anything.**

Most AMC rejectors said no 1–3+ years ago. Given the 96% historical mortality rate, the majority are now in the dead-business pool. Before any outreach:

1. Check that their app/site is still live and functioning
2. Quick LinkedIn check on the founder — still active, still listing the company?
3. WhatsApp business profile / last-seen check
4. If 2 of 3 fail → mark as dead, skip outreach

Without this filter, the campaign is a bounced-message exercise across a graveyard.

**WhatsApp template (operating businesses only):**

> "Hi [Name], quick update — we've replaced our old AMC with monthly deliverables. Each tier ships something specific each month, and if a month doesn't ship, you don't pay that month.
>
> The simplest is **Hosting + Ops Pack** at ₹10,000/month — hosted infra, monthly uptime report, security patches applied. If we miss a month's report or the infra goes down, you cancel — no questions.
>
> Want to try it for 3 months?"

What changed vs. the old AMC:
- Specific monthly deliverable (not vague "support")
- **Risk reversal is concrete** — missed deliverable = no charge that month
- Anchored on output, not availability
- Value-based, not fear-based

---

## 30-Day Sprint to ₹3L Recurring Revenue

Calibrated against the real active-customer count (~30 operators currently running), not the historical 800.

### Week 1 — Hosting + Ops takeovers
- List all clients where you manage their deployment (likely most of the active 30)
- Send hosting transfer proposal to top 15
- Target: 10 Tier 1 clients signed = ₹60,000–80,000/mo

### Week 2 — Tier 1 conversions for non-managed deployments
- Identify clients running on their own hosting / shared hosting / dormant infra
- Send personalized WhatsApp pitch: "we host + monitor + patch — ₹10K/mo, monthly report, cancel anytime"
- Target: 5 more Tier 1 at ₹10,000 = ₹50,000/mo

### Week 3 — Monthly Feature Drop pitch to active clients
- Identify 5 clients with growing businesses who already ask for changes regularly
- Call them — don't message; this tier needs a conversation
- Pitch: "instead of quoting each change, we ship one feature a month for ₹40K — if we don't ship, you don't pay"
- Target: 2-3 Tier 2 at ₹40,000 = ₹80,000–₹1,20,000/mo

### Week 4 — Sprint-as-a-Service close + AI Workflow Subscription seed
- Identify 1-2 clients with active dev demand (currently buying multiple features per quarter) → Tier 3, close and start month-1 billing
- Identify 2-3 clients who've expressed AI interest → AI Workflow Subscription seed conversations (per [[Trioangle 2.0 AI Pivot Plan]])
- **AI Workflow contracts are contingent on AI delivery readiness** — close in week 4, but billing/delivery starts month 2 once 1–2 AI workflow patterns are productized per the Pivot Plan. Don't bill for capability you haven't built.
- Target: 1 Sprint-as-a-Service at ₹90,000 (month 1) + 2 AI Workflow Subs at ₹60,000 (month 2 onwards) = ₹90,000 month 1, +₹1,20,000 from month 2

**End of Month 1 estimate:** ₹2,80,000–₹3,00,000 recurring (Tier 1 + Tier 2 + 1× Tier 3). **End of Month 2 estimate:** ₹4,00,000–₹4,20,000 once AI Workflow billing kicks in.

---

## Full Revenue Math (Realistic Against Active Base)

Revised against ~30 currently active customers (not the 800 historical figure):

| Stream | Volume | Rate | Monthly |
|--------|--------|------|---------|
| Hosting + Ops Pack (Tier 1) | 20 clients | ₹7,000 margin | ₹1,40,000 |
| Monthly Feature Drop (Tier 2) | 2 clients | ₹40,000 | ₹80,000 |
| Sprint-as-a-Service (Tier 3) | 1 client | ₹90,000 | ₹90,000 |
| AI Workflow Subscription (cross-ref Pivot Plan) | 3 clients | ₹60,000 | ₹1,80,000 |
| **Total recurring (non-retainer, all output-based)** | | | **₹4,90,000** |

**Tier stacking note:** Tier 2/3/AI customers also subscribe to Tier 1 hosting — so distinct customer count across this table is ~20, not 26 (~67% of the active 30 base on recurring). The 6 premium-tier slots come from within the 20 Tier 1 clients, not on top of them.

This is entirely from existing relationships — no new client acquisition needed. **Reaching ₹8–10L/month requires new-buyer attach via Product ICP / Service ICP channels** (see [[Trioangle Product ICP]] and [[Trioangle Service ICP]]) — the historical 770 dormant accounts are mostly dead businesses, not a reactivation pipeline (see Customer Mortality section above). A small reactivation campaign targeting the <10 still-operating-but-moved-off operators is worth doing once, but should not be modeled as a growth lever.

**Holding ₹4.9L flat also requires acquisition.** Per Cohort Decay & Replacement Velocity above, ~6 new ICP-qualified customers/year are needed just to offset business-mortality churn — without them, this table is a peak number, not a steady state.

---

## Non-AI Business Foundations

These are the structural changes that make revenue predictable regardless of AI pivot progress:

### ICP Qualification at Sale
- **The 96% historical mortality rate is a hidden tax on every recurring tier.** Selling builds to buyers who fail in 12–18 months means rebuilding the recurring book every 2 years from zero.
- Qualifying questions before quoting any project:
	- Who's funding this? (personal savings ≠ funded — flag)
	- What's the GTM plan? (no plan = no survival)
	- Has the founder run a business before, or is this their first? (first-timers fail more)
	- Is there a paying-customer hypothesis or just an idea?
- **Filter rule:** if 3+ signals are weak, decline the build OR scope it as a ₹50K MVP test instead of a ₹5L full clone. Both protect Trioangle's recurring book and the customer's wallet.
- Healthy ICP signals to prioritize: prior funding round, 6+ months of revenue traction, founder with operational background, paying-customer waitlist or LOIs.
- This discipline applies *before* any tier pitch — recurring revenue compounds only on customers who survive long enough to compound.

### Billing Discipline
- Switch to milestone billing for all projects (30% upfront, 40% mid, 30% on delivery)
- Stop billing on delivery alone — you lose negotiating leverage at the end
- Add a late payment clause to all contracts (1.5% per month after 15 days)

### Contracts
- Use a signed agreement for every engagement — even small ones
- Include: scope boundaries, change request process, IP ownership, **monthly deliverable definition + missed-month policy** (for Tier 1-3 customers), **success metric + measurement method** (for Outcome Deal customers)
- Prevents scope creep, payment disputes, and outcome-attribution disputes

### CRM / Pipeline Visibility
- Track every client and lead in one place (even a spreadsheet works)
- Know: last contact date, current tier, monthly deliverable status (shipped / in flight / at risk), next upsell opportunity
- Without visibility you can't act on timing — and missed deliverables compound into churn fast

### Equity / Profit Share Option
- **Only for ICP-qualifying startups** (per ICP Qualification above) — funded round, real traction, or operationally experienced founder. Never for unfunded first-timers; that just reopens the mortality drain through equity instead of cash.
- For *qualifying* early-stage clients who can't afford full rates: offer reduced fee + 1–2% equity
- Even 2–3 equity positions in surviving companies maturing in 3–5 years changes your personal outcome significantly
- Equity in a company that fails at the 96% historical rate is worth zero — the ICP filter is what makes this option a wealth lever instead of a goodwill discount

### Reputation Infrastructure
- Get 5 Clutch reviews from best clients — this is the #1 B2B credibility signal internationally
- One video testimonial > ten text reviews
- LinkedIn case study posts (problem → solution → result) build inbound pipeline over 6 months

### Referral Program
- Give existing clients 10% of first invoice for any referred client who signs
- Simple, transparent, no expiry
- Most referrals come from clients who trust you but never thought to mention you — the program gives them a reason to act

---

## Summary: The Result-Based Recurring Stack

```
Tier 1 — Hosting + Ops Pack          → ₹1–2L/month from 15–20 clients
Tier 2 — Monthly Feature Drop        → ₹80K–1.2L/month from 2–3 clients
Tier 3 — Sprint-as-a-Service         → ₹80K–1.8L/month from 1–2 clients
AI Workflow Subscription (Pivot Plan) → ₹1.5–3L/month from 3–5 clients (month 2+)
AI Outcome Deals (Pivot Plan)        → variable, scales with customer business
─────────────────────────────────────────────────────────────────────
Target by Month 3:                    ₹5–7L/month recurring
Composition:                          100% result-based (zero retainer)
Sustaining target:                    ~6 new ICP-qualified customers/year
                                      to offset cohort decay and hold flat
```

Once this base exists, every new project is additive — not survival. **Every rupee of recurring revenue is gated on a shipped output or a measurable outcome.** No retainers, no AMC, no pay-for-availability.
