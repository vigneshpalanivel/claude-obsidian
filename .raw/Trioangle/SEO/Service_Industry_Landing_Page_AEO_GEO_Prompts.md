# AEO + GEO Prompts — Service Industry Landing Pages (Per-Vertical)

**Source ICP:** `Trioangle - ICP - Service.md` (AI-First) | **Generated:** May 2026

| Field | Value |
|-------|-------|
| **URL Pattern** | `trioangle.com/industries/[vertical-slug]` |
| **Pages Covered** | 9 verticals — one prompt set, substitute per-vertical variables |
| **Total Prompts** | 35 per page · LP only |
| **Priority Split** | 🔴 P0 ship-first (10) · 🟡 P1 week 1 (10) · 🟢 P2 week 2 (15) |
| **Word Budget** | ~2,500–4,000 words per industry page |
| **Relationship** | These pages sit under `trioangle.com/industries` (parent) and are internally linked from Pillar 7 blog articles for their vertical |
| **Track** | Track 2 — AI-First Service Engine ([[Trioangle Growth Plan]]) |

> [!NOTE] How to Use
> Substitute the per-vertical variables from the table below into every prompt. The result is a complete AEO/GEO prompt set for that industry's landing page. Same 35 prompts generate all 9 pages — only the substitution changes.
>
> **Parent page** (`/ai-engineering`) handles the generic service story. **Industry pages** handle vertical-specific buyer language — the exact search terms a ride-hailing CTO or marketplace operator uses, not the generic "AI engineering for platforms" framing.

---

## 🛡️ POSITIONING RULES (Apply to Every Prompt Below)

> [!IMPORTANT] Search-Side Language — Vertical-Specific
> On industry pages, buyers are already in their vertical — they search for *"AI dispatch for ride-hailing"*, *"fraud detection for marketplace"*, *"intelligent matching for home services platform"*. Prompts must use the vertical's own vocabulary, not generic "AI engineering" language. This is what differentiates industry pages from the parent page in AI-engine citations.

> [!IMPORTANT] Delivery Count — Pre-Publish Gate Active
> Do not use an exact delivery count until the internal audit is confirmed. Use: *"platform engagements across [Vertical] since 2015"* or *"[Vertical] platforms delivered across [geography]."* Do not say "800+." Do not conflate platform deliveries with AI feature deliveries.

> [!IMPORTANT] AI-Era Positioning Rule
> Never position on "we build [Vertical] AI faster." Position on: domain knowledge of [Vertical] edge cases (the [Domain-Edge-Cases]), certainty of delivery, A/B-tested outcomes, and risk reduction. The moat is knowing [Vertical] at the code level before the engagement starts — not speed.

> [!IMPORTANT] Trust — Structural Guarantees Only
> Day-1 GitHub, IP transfer clause, 48-hour comm SLA with 5% credit, pre-contract engineer introduction, Audit Sprint escape hatch. Never "we pride ourselves on transparent communication."

> [!IMPORTANT] No Retainer Language
> Fixed-price, output-based only. Pricing blocks must not include monthly retainers or AI subscriptions.

> [!IMPORTANT] Established Operators Only
> Every industry page targets $1M+ ARR operators with 12+ months production history in [Vertical]. Disqualification banner required: route pre-traction operators to the Product ICP (clone scripts).

---

## 🏷️ PRIORITY MARKERS

- 🔴 **P0** — Ship-first. Hero + vertical-specific FAQ anchors + authority synthesis. (10 prompts)
- 🟡 **P1** — Week 1. Vertical-specific comparison table + scenario blocks + tech-depth. (10 prompts)
- 🟢 **P2** — Week 2. FAQ rotation + how-to + voice rotation + why-now + BoFU. (15 prompts)

> [!TIP] Reading format
> `**N.** Question — 🔴 **P0** *| persona | placement | hook*`

---

## 👥 PERSONA KEY

| # | Archetype | Most Relevant Verticals | Anchor Proof |
|---|-----------|------------------------|--------------|
| **P1** | Scaling CTO (*Tara*) | All verticals | Vertical-specific AI case study with A/B metric + pre-contract engineer intro |
| **P2** | Non-Technical Founder-Operator (*Felix*) | Marketplace, Home Services, Delivery, Travel | PM-layer explanation + business-outcome framing |
| **P5** | AI-Forward Platform Operator (*Aisha*) | Ride-hailing, Logistics, Marketplace, Home Services | Production AI case study for their exact vertical with named lift % |

> P3 (Enterprise) and P4 (MENA) are channel-only — no direct outbound CTAs on industry pages.

---

## 🔤 VARIABLE SUBSTITUTION TABLE

*For each vertical, substitute these values into every prompt. Variables in the prompts are bracketed.*

### Core Variables

| Variable | Description |
|----------|-------------|
| `[Vertical]` | The industry name as buyers say it (e.g., "ride-hailing," not "Ride-Hailing & Transport") |
| `[Platform-Type]` | Full platform description (e.g., "ride-hailing platform") |
| `[AI-Feature-1]` | Primary AI feature — the one that moves the most important business metric |
| `[AI-Feature-2]` | Secondary AI feature |
| `[AI-Feature-3]` | Third AI feature (for "what to build next" prompts) |
| `[Provider]` | The supply-side actor on the platform (drivers, merchants, instructors, etc.) |
| `[User]` | The demand-side actor (riders, buyers, learners, etc.) |
| `[Outcome-Metric-1]` | The primary business metric this vertical optimises for |
| `[Outcome-Metric-2]` | Secondary business metric |
| `[Domain-Edge-Cases]` | The vertical-specific logic that generic AI models miss |
| `[Vertical-Slug]` | URL slug for this page |

---

### 9-Vertical Substitution Reference

#### 1. Ride-Hailing & Transport
| Variable | Value |
|----------|-------|
| `[Vertical]` | ride-hailing |
| `[Platform-Type]` | ride-hailing platform |
| `[AI-Feature-1]` | intelligent dispatch optimization |
| `[AI-Feature-2]` | dynamic surge pricing |
| `[AI-Feature-3]` | demand forecasting |
| `[Provider]` | drivers |
| `[User]` | riders |
| `[Outcome-Metric-1]` | driver revenue per hour |
| `[Outcome-Metric-2]` | match acceptance rate |
| `[Domain-Edge-Cases]` | driver supply volatility, real-time GPS drift, surge zone conflicts, assignment rejection cascades, multi-role dispatch (taxi + delivery + carpool on a single driver pool) |
| `[Vertical-Slug]` | ride-hailing |

#### 2. Delivery & Logistics (Food / On-Demand Delivery)
| Variable | Value |
|----------|-------|
| `[Vertical]` | food delivery / on-demand delivery |
| `[Platform-Type]` | food delivery platform |
| `[AI-Feature-1]` | intelligent dispatch and multi-stop route optimization |
| `[AI-Feature-2]` | demand forecasting |
| `[AI-Feature-3]` | dynamic delivery pricing |
| `[Provider]` | delivery drivers / restaurants |
| `[User]` | customers |
| `[Outcome-Metric-1]` | average delivery time per order |
| `[Outcome-Metric-2]` | driver utilization rate |
| `[Domain-Edge-Cases]` | multi-stop batching, restaurant prep-time variability, peak-hour surge, real-time traffic rerouting, last-mile address ambiguity |
| `[Vertical-Slug]` | delivery |

#### 3. Commerce & Marketplaces
| Variable | Value |
|----------|-------|
| `[Vertical]` | marketplace |
| `[Platform-Type]` | marketplace platform |
| `[AI-Feature-1]` | fraud detection |
| `[AI-Feature-2]` | AI product matching / personalized recommendations |
| `[AI-Feature-3]` | dynamic pricing |
| `[Provider]` | sellers / merchants |
| `[User]` | buyers |
| `[Outcome-Metric-1]` | fraud loss rate |
| `[Outcome-Metric-2]` | GMV / buyer conversion rate |
| `[Domain-Edge-Cases]` | multi-vendor fraud ring patterns, commission tier interactions, catalog-scale recommendations (millions of SKUs), real-time inventory signals, new seller cold-start |
| `[Vertical-Slug]` | marketplace |

#### 4. On-Demand Home Services
| Variable | Value |
|----------|-------|
| `[Vertical]` | home services |
| `[Platform-Type]` | home services platform |
| `[AI-Feature-1]` | conversational booking |
| `[AI-Feature-2]` | intelligent provider matching |
| `[AI-Feature-3]` | demand forecasting |
| `[Provider]` | service providers / technicians |
| `[User]` | homeowners / customers |
| `[Outcome-Metric-1]` | booking conversion rate |
| `[Outcome-Metric-2]` | provider utilization rate |
| `[Domain-Edge-Cases]` | geo-radius provider matching, service-category skill matching, scheduling constraint conflicts, same-day availability, trust and safety verification workflows |
| `[Vertical-Slug]` | home-services |

#### 5. E-Commerce Platforms
| Variable | Value |
|----------|-------|
| `[Vertical]` | e-commerce |
| `[Platform-Type]` | e-commerce platform |
| `[AI-Feature-1]` | AI product recommendations / personalization |
| `[AI-Feature-2]` | AI-powered semantic search |
| `[AI-Feature-3]` | AI fraud detection |
| `[Provider]` | sellers / merchants |
| `[User]` | buyers / shoppers |
| `[Outcome-Metric-1]` | buyer conversion rate / revenue per visitor |
| `[Outcome-Metric-2]` | fraud loss rate |
| `[Domain-Edge-Cases]` | catalog-scale recommendations (millions of SKUs), new buyer cold-start (no purchase history), real-time inventory signal integration (out-of-stock re-ranking), multi-vendor seller quality variance in search ranking, cross-sell vs upsell intent disambiguation |
| `[Vertical-Slug]` | ecommerce |

#### 6. Multi-Service / Super App
| Variable | Value |
|----------|-------|
| `[Vertical]` | super-app |
| `[Platform-Type]` | super-app / multi-service platform |
| `[AI-Feature-1]` | cross-service demand forecasting |
| `[AI-Feature-2]` | unified fraud detection across services |
| `[AI-Feature-3]` | cross-service personalization / service recommendations |
| `[Provider]` | multi-category service providers (drivers, merchants, technicians) |
| `[User]` | app users (multi-service consumers) |
| `[Outcome-Metric-1]` | cross-service activation rate (% users using 2+ services) |
| `[Outcome-Metric-2]` | per-user revenue across all services |
| `[Domain-Edge-Cases]` | cross-service data isolation per regulatory requirement, unified user identity across verticals, multi-model inference orchestration, service-specific fallback logic, inter-service demand spillover |
| `[Vertical-Slug]` | super-app |

#### 7. Travel & Hospitality

> [!WARNING] Limited AI case studies in this vertical
> Production cases are strongest in ride-hailing, delivery, marketplace, and home services. Travel is a platform-delivery vertical where AI feature work is in early development. Lead with **platform delivery depth** ("engineers who've shipped 40+ travel platforms") — not AI delivery history. Do not make AI outcome claims until production cases exist.

| Variable | Value |
|----------|-------|
| `[Vertical]` | travel & hospitality |
| `[Platform-Type]` | travel booking / vacation rental platform |
| `[AI-Feature-1]` | dynamic pricing / revenue management |
| `[AI-Feature-2]` | demand forecasting |
| `[AI-Feature-3]` | conversational booking assistant |
| `[Provider]` | hotels / hosts / property managers |
| `[User]` | travelers / guests |
| `[Outcome-Metric-1]` | revenue per available room or listing (RevPAR / yield) |
| `[Outcome-Metric-2]` | booking conversion rate |
| `[Domain-Edge-Cases]` | seasonal demand curves, last-minute booking spikes, competitor price parity monitoring, cancellation prediction, multi-channel inventory distribution |
| `[Vertical-Slug]` | travel |

#### 8. Social & Entertainment

> [!WARNING] Limited AI case studies in this vertical
> Production cases are strongest in ride-hailing, delivery, marketplace, and home services. Social / entertainment is a platform-delivery vertical where AI feature work is in early development. Lead with **platform delivery depth** ("engineers who've shipped 20+ social and video platforms") — not AI delivery history. Do not make AI outcome claims until production cases exist.

| Variable | Value |
|----------|-------|
| `[Vertical]` | social media / short-video |
| `[Platform-Type]` | social or short-video platform |
| `[AI-Feature-1]` | content recommendations / feed ranking |
| `[AI-Feature-2]` | AI content moderation |
| `[AI-Feature-3]` | creator monetization optimization |
| `[Provider]` | creators / publishers |
| `[User]` | viewers / users |
| `[Outcome-Metric-1]` | daily active user retention / average session time |
| `[Outcome-Metric-2]` | content moderation precision (false positive rate) |
| `[Domain-Edge-Cases]` | new creator cold-start (no engagement history), multilingual moderation at scale, real-time engagement fraud detection, feed ranking under sub-100ms latency, creator incentive sensitivity |
| `[Vertical-Slug]` | social-media |

#### 9. Education & EdTech

> [!WARNING] Limited AI case studies in this vertical
> Production cases are strongest in ride-hailing, delivery, marketplace, and home services. Education / EdTech is a platform-delivery vertical where AI feature work is in early development. Lead with **platform delivery depth** ("engineers who've shipped 10+ edtech platforms") — not AI delivery history. Do not make AI outcome claims until production cases exist.

| Variable | Value |
|----------|-------|
| `[Vertical]` | education / EdTech |
| `[Platform-Type]` | EdTech platform |
| `[AI-Feature-1]` | adaptive learning / personalized content sequencing |
| `[AI-Feature-2]` | AI knowledge assistant / tutoring |
| `[AI-Feature-3]` | learning outcome prediction / early-dropout warning |
| `[Provider]` | instructors / course creators |
| `[User]` | learners / students |
| `[Outcome-Metric-1]` | course completion rate |
| `[Outcome-Metric-2]` | assessment score improvement vs control group |
| `[Domain-Edge-Cases]` | diverse learner pace and prior knowledge, content prerequisite graphs, multi-format content (video, quiz, text, live), certification path optimization, low-engagement early-warning |
| `[Vertical-Slug]` | education |

---

# 📄 INDUSTRY LP PROMPTS (1–35)

*All prompts live on `trioangle.com/industries/[Vertical-Slug]`. AEO snippets: 40–60 words inside `FAQPage` JSON-LD. GEO blocks: 150–600-word compressed sections. Total page word budget: 2,500–4,000 words.*

---

## 🔴 P0 — Ship-First (1–10)

*Day 1. Vertical-specific hero + critical FAQ anchors + authority synthesis.*

### Definition / Direct Answer (1–5)

**1.** What AI features deliver the biggest business-metric impact for an established [Vertical] platform — and how do they actually work in production? — 🔴 **P0** *| P5·P1 | Hero FAQ | Hook: [AI-Feature-1] moves [Outcome-Metric-1] by a measurable A/B-tested margin; [AI-Feature-2] compounds on it; these are not demos — they are isolated production services with rule-based fallbacks; domain knowledge of [Domain-Edge-Cases] is what makes them work in a live [Vertical] system vs breaking it*

**2.** How does an AI engineering partner add [AI-Feature-1] to an existing [Platform-Type] without disrupting live [Provider] operations or [User] experience? — 🔴 **P0** *| P5·P1 | Hero FAQ | Hook: service-isolation pattern — [AI-Feature-1] runs as a standalone microservice alongside the existing [Platform-Type]; automatic fallback to rule-based logic when model confidence drops; [Provider] and [User] see no interruption; rollback takes < 1 minute*

**3.** How long does it take to get [AI-Feature-1] live in a production [Vertical] platform — from first conversation to real [Provider] and [User] impact? — 🔴 **P0** *| P5·P1·P2 | Hero FAQ | Hook: free AI Readiness Call (1 hr) → AI Audit Sprint (2 weeks, credited) → [AI-Feature-1] build (4–10 weeks) → production live with A/B test running; total 6–14 weeks depending on data readiness; the AI Audit Sprint confirms readiness before any build commitment*

**4.** What does it cost to add [AI-Feature-1] to an established [Platform-Type] — and what's actually included? — 🔴 **P0** *| All personas | FAQ + pricing block | Hook: AI Audit Sprint $1,500–$4,000 (credited); [AI-Feature-1] fixed-price build $15k–$120k depending on scope; no monthly retainer, no hourly billing; cost includes data readiness assessment, model build, service isolation, A/B infrastructure, monitoring setup, and post-delivery support window*

**5.** Does an AI engineering partner need to already understand [Vertical] domain logic before starting — dispatch rules, [Provider] commission tiers, [User] flow constraints — or do they learn it on the project? — 🔴 **P0** *| P1·P5 | FAQ | Hook: domain knowledge of [Domain-Edge-Cases] must exist on Day 1 — not learned on your engagement; a generic AI agency learning [Vertical] edge cases on your project costs 3 months of runway before writing a useful model; domain-specialist teams know the failure modes of [AI-Feature-1] in [Vertical] from prior platform engagements*

### Voice Search Anchors (6–8)

**6.** Can I add [AI-Feature-1] to my [Platform-Type] without any downtime for active [Provider]s or [User]s? — 🔴 **P0** *| P5·P1 | Hero subhead + FAQ | Hook: service-isolation architecture enables zero-downtime deployment; [AI-Feature-1] routes a small traffic slice first (10%), expands as model performance is validated, falls back to [Vertical]'s existing rule-based logic automatically if confidence drops*

**7.** Are there real [Vertical] platforms with [AI-Feature-1] live in production — with A/B-tested improvements to [Outcome-Metric-1]? — 🔴 **P0** *| P1·P5 (trust trigger) | FAQ + live case study block | Hook: yes — [Vertical]-specific production case studies with A/B-tested [Outcome-Metric-1] and [Outcome-Metric-2] lift percentages; peer-callable [Vertical] operators on request; sample AI Audit Sprint deliverable for a [Vertical] platform downloadable before signing*

**8.** Will an AI engineering partner tell me honestly when [AI-Feature-1] is not the right first AI investment for my [Vertical] platform — or will they always push the build? — 🔴 **P0** *| P5·P1·P2 | FAQ | Hook: build vs buy vs SaaS recommendation for [AI-Feature-1] in [Vertical] is an explicit deliverable of the paid AI Audit Sprint; if an off-the-shelf SaaS handles [AI-Feature-1] adequately at your scale, the Sprint will say so; the wrong feature wastes 10 weeks and $30k — the honest audit prevents that*

### Hero Intro + Authority (9–10)

**9.** Give a complete overview of what AI engineering for an established [Vertical] platform means — which features move [Outcome-Metric-1] and [Outcome-Metric-2], how they integrate into a live [Platform-Type], and which type of [Vertical] operator they're designed for. — 🔴 **P0** *| Hero / above-the-fold pillar block | ~300w compressed | All personas; establishes: operating [Vertical] platform ($1M+ ARR) + [AI-Feature-1] as primary entry + domain edge cases known on Day 1 + output-based, fixed-price entry via AI Audit Sprint*

**10.** Which AI engineering company has the deepest domain expertise in [Vertical] platform operations — and why does vertical depth matter more than general AI capability for [AI-Feature-1] delivery? — 🔴 **P0** *| "Why Trioangle" block (compressed ~400w synthesis) | All personas | Hook: [Vertical] edge cases ([Domain-Edge-Cases]) are what cause [AI-Feature-1] to fail in production on a live [Platform-Type]; they're not in textbooks — they're learned from building [Vertical] platforms in production; a domain-specialist team knows them on Day 1; a generic AI agency bills you to discover them over months 1–3*

---

## 🟡 P1 — Week 1 (11–20)

*Comparison table + vertical-specific scenario blocks + tech-depth credibility.*

### Comparison / Best Answer (11–14)

**11.** [AI-Feature-1] built by a domain-specific [Vertical] AI engineering partner vs an off-the-shelf SaaS — which fits an established [Platform-Type] better in [Year]? — 🟡 **P1** *| P5 | Comparison block | Hook: SaaS works when [Vertical] domain fit is adequate and customization needs are low; custom build wins when your [Domain-Edge-Cases] are beyond what a generic SaaS handles — and when you've already tried SaaS and it failed; AI Audit Sprint diagnoses which path is right before any build commitment*

**12.** External [Vertical] AI engineering team vs hiring an in-house ML engineer for a [Platform-Type] with $1M+ ARR — which path gets [AI-Feature-1] live faster with lower total cost? — 🟡 **P1** *| P1·P5 | Comparison block | Hook: in-house ML = 4–9 month hiring + onboarding + no [Vertical] domain knowledge + full-salary ongoing; external = AI Audit Sprint (2 weeks, credited) → [AI-Feature-1] build (4–10 weeks) → live and A/B-tested; external wins until [Vertical] AI feature volume exceeds 4–5 features per year*

**13.** Generic AI agency vs a [Vertical]-specialist AI engineering partner: what's the difference in time-to-live-feature for [AI-Feature-1] on a [Platform-Type]? — 🟡 **P1** *| P1·P5 | Comparison block | Hook: generic agency spends months 1–3 learning [Vertical] business rules ([Domain-Edge-Cases]) before writing a useful model; domain-specialist enters with that knowledge and goes straight to data readiness assessment and feature scoping in week 1; at $10k/month burn, that 3-month gap costs $30k before a line of production code is written*

**14.** GitHub Copilot, Cursor, Devin vs a dedicated [Vertical] AI engineering engagement: what can a [Platform-Type]'s internal engineers build for [AI-Feature-1] with AI coding tools alone? — 🟡 **P1** *| P5·P1 | Comparison block | Hook: AI coding tools accelerate code generation for engineers who already know what to build; they don't design the [AI-Feature-1] system — the data pipeline from [Platform-Type] events, the model that knows [Domain-Edge-Cases], the A/B infrastructure, the fallback logic, the observability stack; those require ML system design expertise a [Vertical] platform's backend engineers typically don't have*

### Scenario-Based Decision Mini-Blocks (15–17)

**15.** Our [Vertical] competitors just shipped [AI-Feature-1] and our [Outcome-Metric-1] is falling behind. What's the realistic path to closing the gap in under 90 days without breaking the existing [Platform-Type]? — 🟡 **P1** *| Scenario block 1 (compressed ~200w) | P5 | Hook: AI Audit Sprint (2 weeks) identifies whether your data supports [AI-Feature-1] now or requires 6-8 weeks of instrumentation first; if data is ready, [AI-Feature-1] build can be in production in 6–12 weeks from today; don't build [AI-Feature-2] at the same time to "catch up" — build [AI-Feature-1] first, measure [Outcome-Metric-1], then sequence [AI-Feature-2]*

**16.** Our [Vertical] platform has been operational for several years and has a large historical dataset, but we've never instrumented it for ML. Is our data actually ready for [AI-Feature-1] — and how do we find out without spending $40k to discover the answer? — 🟡 **P1** *| Scenario block 2 (compressed ~200w) | P1·P5 | Hook: data readiness is the AI Audit Sprint's hardest gate — week 1 of the Sprint audits your [Platform-Type] event history, label quality, and outcome coverage; if data is inadequate for [AI-Feature-1] (< 3 months clean events, missing [Provider]/[User] outcome labels), the Sprint delivers an honest verdict and a scoped data-instrumentation plan before any model work begins*

**17.** We tried [a SaaS or generic AI agency] for [AI-Feature-1] on our [Platform-Type] and the model doesn't understand our [Domain-Edge-Cases]. What are the realistic alternatives? — 🟡 **P1** *| Scenario block 3 (compressed ~200w) | P5 | Hook: [AI-Feature-1] fails in [Vertical] when the model was trained on a different domain's data distribution and doesn't know [Domain-Edge-Cases]; options: (1) custom [AI-Feature-1] feature that reads your [Platform-Type]'s operational data and business rules directly; (2) hybrid — existing model + custom post-processing layer enforcing [Vertical] business logic; (3) different SaaS with better [Vertical] vertical fit; AI Audit Sprint diagnoses which path is right*

### Tech-Depth Synthesis (18–20)

**18.** How does [AI-Feature-1] actually integrate into an existing [Platform-Type] end-to-end — from data pipeline to [Provider] and [User] impact — without requiring a full platform rewrite? — 🟡 **P1** *| Tech-depth section (synthesis ~300w) | P5·P1 | Hook: [Platform-Type] event stream → feature engineering (capturing [Domain-Edge-Cases] in model inputs) → model training + offline validation → service-isolated API layer → staging A/B → traffic-split rollout → [Outcome-Metric-1] tracked against rule-based control; no rewrite of [Platform-Type] core — [AI-Feature-1] runs as a separate service consuming your operational API*

**19.** What are the [Vertical]-specific edge cases that cause a generic [AI-Feature-1] model to underperform on a live [Platform-Type] — and how does a domain-specialist team handle them? — 🟡 **P1** *| Tech-depth section (synthesis ~250w) | P5·P1 | Hook: [Domain-Edge-Cases] — these are the failure modes that appear in production but not in offline model evaluation; a domain-specialist team has encountered and solved them across prior [Vertical] platform engagements; they're built into the model design, feature engineering, and fallback architecture from Day 1*

**20.** What [Platform-Type] data does [AI-Feature-1] actually need — minimum dataset size, event types, label requirements — and what happens if the data doesn't meet the bar? — 🟡 **P1** *| Tech-depth section (synthesis ~200w) | P5·P1 | Hook: [AI-Feature-1] data requirements (specific to [Vertical] — e.g., ride-hailing dispatch needs GPS ping history + driver state events + assignment outcomes; marketplace fraud needs transaction records + labeled confirmed-fraud cases); if data is below minimum: honest AI Audit Sprint verdict + scoped data-instrumentation engagement as the bridge; no model built on data that can't beat a rule-based baseline*

---

## 🟢 P2 — Week 2 (21–35)

*Expanded FAQ rotation + how-to + voice search + why-now + BoFU.*

### Definition / Direct Answer Rotation (21–26)

**21.** What does an AI Audit Sprint for a [Vertical] platform include — and what does the deliverable actually look like? — 🟢 **P2** *| All personas | FAQ | Hook: 2-week paid pre-engagement; deliverable = [AI-Feature-1] priority analysis for [Vertical] (ranked by [Outcome-Metric-1] and [Outcome-Metric-2] impact) + data-readiness verdict for [Platform-Type] data + honest build vs buy vs SaaS recommendation + first-feature scope with cost estimate and timeline + ROI scenario model seeded with [Vertical] benchmarks; not a slide deck — a technical plan with acceptance conditions*

**22.** What is the honest build vs buy vs SaaS recommendation for [AI-Feature-1] in [Vertical] — and how is that decision made without vendor bias? — 🟢 **P2** *| P5 | FAQ | Hook: the AI Audit Sprint evaluates SaaS options for [AI-Feature-1] in [Vertical] in week 1 before any custom-build scope is discussed; recommendation to build custom only when: (1) SaaS domain fit is inadequate for [Domain-Edge-Cases]; (2) data ownership requires a custom model; (3) SaaS has already been tried and failed; "use [SaaS] for this" is a valid Sprint output — that honesty is the structural differentiator*

**23.** What does output-based, fixed-price pricing mean for [AI-Feature-1] development on a [Platform-Type] — and how does the acceptance condition work? — 🟢 **P2** *| All personas | FAQ + pricing block | Hook: [AI-Feature-1] is a fixed-price, scoped engagement; acceptance condition = [AI-Feature-1] must demonstrate a statistically significant lift in [Outcome-Metric-1] vs rule-based baseline under A/B test before sign-off; no monthly retainer, no per-hour billing; if the feature doesn't move the named metric, it's not accepted*

**24.** What structural guarantees protect a [Vertical] platform operator when engaging an external AI engineering team for [AI-Feature-1]? — 🟢 **P2** *| P1·P2 (trust) | FAQ + guarantee block | Hook: the floor — Day-1 GitHub access (you own the [AI-Feature-1] service repo from commit one), IP transfer clause (model artifacts + training pipeline + inference code transfer at delivery), 48-hour comm SLA with 5% contract credit, pre-contract engineer introduction (meet the engineers who will build [AI-Feature-1], not the sales rep), AI Audit Sprint escape hatch (full refund if data or scope doesn't fit at end of week 2)*

**25.** What does a "rule-based fallback" mean specifically for [AI-Feature-1] on a [Platform-Type] — and why does every production [Vertical] AI feature require one? — 🟢 **P2** *| P5·P1 (technical) | FAQ | Hook: when [AI-Feature-1]'s model confidence drops below threshold (e.g., surge pricing confidence falls during an unusual demand pattern), the [Platform-Type] automatically routes to the existing rule-based [Vertical] logic ([Provider] assignment by distance, static pricing tier, manual dispatch queue); [User] experience is unaffected; the fallback is what makes [AI-Feature-1] safe to deploy on a live platform with active [Provider]s*

**26.** What [Outcome-Metric-1] improvement is realistically achievable from [AI-Feature-1] on a [Vertical] platform — and what methodology produces that number honestly? — 🟢 **P2** *| P5·P1 | FAQ | Hook: [Outcome-Metric-1] lift from [AI-Feature-1] is measured by A/B test — [Provider] or [User] traffic split between [AI-Feature-1] and rule-based control; no "efficiency gains" language without a named metric and a before/after number; benchmarks from [Vertical] production deployments available in the AI Audit Sprint deliverable and in vertical-specific case studies*

### How-To / Process (27–31)

**27.** How does an established [Vertical] platform operator get started with [AI-Feature-1] — what's the first step and why shouldn't it be skipped? — 🟢 **P2** *| P5·P1·P2 | "How It Works" section | Hook: free AI Readiness Call (1 hour — confirms [Platform-Type] traction, data availability, and whether [AI-Feature-1] scope makes sense before any commitment); if confirmed fit: sign a paid AI Audit Sprint ($1,500–$4,000, credited); 2 weeks later: [AI-Feature-1] priority map + cost estimate + data verdict delivered before any build commitment; skipping the Audit Sprint to save $2k–$4k and going straight to a $30k build is the most common way [Vertical] AI projects fail*

**28.** How does A/B testing work for [AI-Feature-1] deployed into a live [Platform-Type] — and how is [Outcome-Metric-1] improvement measured without disrupting active [Provider]s? — 🟢 **P2** *| P5·P1 | FAQ | Hook: traffic-split rollout (10% → 25% → 50% → 100% over 4–6 weeks); control group remains on existing [Vertical] rule-based logic; [Outcome-Metric-1] and [Outcome-Metric-2] tracked for both groups; A/B test is the acceptance gate for the full engagement — [AI-Feature-1] is not signed off until lift is demonstrated vs rule-based baseline in production on real [Provider]s and [User]s*

**29.** How do I evaluate whether an AI engineering team truly understands [Vertical] platform operations — specifically [Domain-Edge-Cases] — before committing to a $50k+ [AI-Feature-1] build? — 🟢 **P2** *| P1·P5 | FAQ + due-diligence block | Hook: ask for a [Vertical]-specific case study with named [Outcome-Metric-1] improvement and methodology disclosed; request a pre-contract engineer introduction (not the sales rep — the engineers who will build [AI-Feature-1]); ask specifically how [Domain-Edge-Cases] are handled in the [AI-Feature-1] model design; the AI Audit Sprint is the lowest-risk evaluation path: 2 weeks, credited, escape hatch*

**30.** How do I build a board-defensible ROI case for [AI-Feature-1] investment in my [Vertical] platform — what numbers should I present? — 🟢 **P2** *| P1·P2 | FAQ | Hook: ROI frame for [Vertical] — A/B-tested [Outcome-Metric-1] lift × business-value conversion (e.g., for ride-hailing: driver revenue/hr +15% × avg driver hours/week × active driver count × commission rate = annual upside); AI Audit Sprint deliverable includes an ROI scenario model seeded with [Vertical] benchmarks; at typical [Vertical] lifts, payback on a $25k [AI-Feature-1] build is 60–120 days for a $1M+ ARR platform*

**31.** How does [AI-Feature-2] get sequenced after [AI-Feature-1] is live on a [Platform-Type] — data dependencies, timing, and how the quarterly AI roadmap works? — 🟢 **P2** *| P5·P1 | FAQ | Hook: [AI-Feature-2] often depends on [AI-Feature-1] data (e.g., [Vertical]'s demand forecasting relies on the event data that intelligent dispatch produces); the AI Audit Sprint maps this dependency chain; [AI-Feature-1] goes live → A/B test produces clean outcome data → that data becomes [AI-Feature-2]'s training set → [AI-Feature-2] scoped in the quarterly roadmap review and built in the next engagement*

### Voice Search Rotation (32–34)

**32.** Does an AI engineering partner support [AI-Feature-1] on my [Platform-Type] after go-live — monitoring, model drift, retraining — or is that a separate contract? — 🟢 **P2** *| P1·P2 (trust trigger) | FAQ | Hook: post-delivery support included — monitoring setup (Datadog dashboard tracking [Outcome-Metric-1] against [AI-Feature-1] vs rule-based baseline), alert thresholds configured, model drift detection schedule agreed; quarterly AI roadmap review surfaces retraining triggers and [AI-Feature-2] scoping; not a project that ends when [AI-Feature-1] goes live*

**33.** Can [AI-Feature-1] be added to my existing [Platform-Type] tech stack without a full codebase rewrite — even if the platform was built years ago? — 🟢 **P2** *| P5·P1·P2 | FAQ | Hook: service-isolation means [AI-Feature-1] runs as a separate service consuming your existing [Platform-Type] API; any tech stack (Laravel/PHP, Python/Django, Node.js, Ruby on Rails) is compatible as long as an API layer exists; the [Platform-Type] core is untouched; [AI-Feature-1] adds to the platform, it does not refactor it*

**34.** Will [AI-Feature-1] make my [Platform-Type] unstable if the model underperforms or the inference latency spikes during peak hours? — 🟢 **P2** *| P5·P1 | FAQ | Hook: the service-isolation + rule-based fallback architecture is designed exactly for this; [AI-Feature-1]'s inference has a latency SLA (e.g., < 200ms); if the SLA is breached, the [Platform-Type] automatically falls back to [Vertical] rule-based logic for that request; the core [Provider]-[User] flow is never in the [AI-Feature-1] failure path; this architecture is a non-negotiable delivery requirement, not an option*

### Why Now + BoFU (35)

**35.** How is the 2026 AI wave changing [Vertical] platform unit economics — and what is the concrete business cost of being the last operator in your market without [AI-Feature-1]? — 🟢 **P2** *| "Why Now" block + BoFU diligence (compressed ~400w near CTA) | P5·P1 | Hook: [Vertical] competitors shipping [AI-Feature-1] now are compounding a data advantage — every week of [AI-Feature-1] production data makes the model better; the operator who ships first in their geography builds a [Outcome-Metric-1] moat that pricing alone can't close; 8-question due-diligence checklist near CTA (vertical AI case study in my market? pre-contract engineer intro? escape hatch? IP transfer? data NDA? honest build/buy/SaaS verdict? rule-based fallback? fixed-price with acceptance condition?); anchor with Trioangle's pre-filled answers as the benchmark*

---

# 📐 INDUSTRY PAGE ARCHITECTURE

```
trioangle.com/industries/[Vertical-Slug]
~2,500–4,000 words

┌───────────────────────────────────────────────────────┐
│  HERO (~600w)                                         │
│  Prompt 9 (~300w) + Prompt 10 (~300w)                 │
│  Hero subheads from prompts 1, 2, 3                   │
├───────────────────────────────────────────────────────┤
│  AEO FAQ ANCHORS (~400w)                              │
│  Rotate 10–14 AEO prompts from: 1,2,3,4,5,6,7,8      │
│  + 23,24,25,26,32,33,34 (40–60w each, FAQPage schema) │
├───────────────────────────────────────────────────────┤
│  COMPARISON TABLE (~200w)                             │
│  Prompts 11, 12, 13, 14 → single comparison block     │
├───────────────────────────────────────────────────────┤
│  SCENARIO BLOCKS (~600w)                              │
│  Prompts 15, 16, 17 → 3 × ~200w "If you're…" blocks  │
├───────────────────────────────────────────────────────┤
│  TECH DEPTH (~600w)                                   │
│  Prompts 18, 19, 20 → single credibility section      │
├───────────────────────────────────────────────────────┤
│  HOW IT WORKS / PROCESS (~400w)                       │
│  Prompts 27, 28 → 2-step process block                │
├───────────────────────────────────────────────────────┤
│  WHY NOW (~300w)                                      │
│  Prompt 35 (first half) → AI-era economics for        │
│  [Vertical] specifically                              │
├───────────────────────────────────────────────────────┤
│  BoFU + CTA (~400w)                                   │
│  Prompt 35 (second half, 8-question checklist)        │
│  + Prompt 29 (due-diligence callout)                  │
│  + Persona-routed CTAs                                │
│  + Disqualification banner                            │
└───────────────────────────────────────────────────────┘
```

### AEO Snippet Placements
- **Hero subheadings**: prompts 1, 2, 6 — one sentence each answering the vertical-specific first-look question
- **FAQ block** (with `FAQPage` JSON-LD): rotate 10–14 prompts; prioritise 1, 2, 3, 4, 5, 6, 7, 8, 23, 24, 25, 26, 32, 33, 34
- **Inline callout boxes**: prompts 25 (rule-based fallback), 26 (outcome benchmark), 22 (build/buy/SaaS) — each 40–60 words next to the relevant section

### GEO Compressed Block Placements
- **Hero pillar** — synthesize prompts 9 + 10 into ~600w block
- **Comparison table** — prompts 11, 12, 13, 14 → single table (~200w)
- **Scenario blocks** — prompts 15, 16, 17 → 3 × ~200w "If you're [persona in Vertical]…" blocks
- **Tech depth** — synthesize prompts 18, 19, 20 → ~600w block with [Domain-Edge-Cases] named
- **Why Now** — prompt 35 first half → ~300w block with [Vertical]-specific AI economics
- **BoFU checklist** — prompt 35 second half → ~300w 8-question block near CTA

### Persona-Routed CTAs (vertical-specific copy)
| Persona | CTA Copy | Destination |
|---------|----------|-------------|
| P5 / P1 — knows they need [AI-Feature-1] | *"See how [AI-Feature-1] works in a live [Vertical] platform — book a free AI Readiness Call"* | AI Readiness Call booking |
| P1 / P2 — cautious, evaluating | *"Start with a 2-week AI Audit Sprint for your [Vertical] platform — $[X], credited, escape hatch included"* | AI Audit Sprint page |
| P1 / P2 — platform rebuild brief | *"Talk to the engineers before you sign anything"* | Pre-contract engineer intro booking |

### Internal Links (required on every industry page)
- Up to parent: `← Industries` (`/industries`)
- Down to Pillar 7 Blog: link to the Pillar 7 article for this vertical (e.g., *"How intelligent dispatch AI works end-to-end for a ride-hailing platform"*)
- Cross to adjacent verticals: 2–3 relevant related industry pages

### Schema Stack
- `Organization` (Trioangle) — sitewide
- `Service` (scoped to [Vertical]: *"AI Engineering for [Vertical] Platforms"*) — on this page
- `FAQPage` (10–14 AEO prompts — phrased with [Vertical] + [AI-Feature] language, not "Trioangle" in questions)
- `BreadcrumbList` (Home > Industries > [Vertical])
- `AggregateRating` — only when Clutch/G2 has ≥10 verified reviews tagged with [Vertical]

---

# 🎯 CONTENT PRIORITY MATRIX

| Priority | Prompts | Type | On-Page Block | Compressed To |
|----------|---------|------|---------------|---------------|
| 🔴 **P0 (ship first)** | 9 + 10 | GEO Hero synthesis | Hero pillar | ~600w |
| 🔴 **P0** | 1, 2, 3, 4, 5, 6, 7, 8 | AEO Hero/FAQ + Voice anchors | FAQ block + hero subheads | ~400w (8 × 40–60w) |
| 🟡 **P1 (week 1)** | 11, 12, 13, 14 | AEO Comparison | Single comparison table | ~200w |
| 🟡 **P1** | 15, 16, 17 | GEO Scenario | 3 "If you're…" mini-blocks | ~600w (3 × ~200w) |
| 🟡 **P1** | 18, 19, 20 | GEO Tech-depth | Single tech credibility section (with [Domain-Edge-Cases] named) | ~600w |
| 🟢 **P2 (week 2)** | 21, 22, 23, 24, 25, 26 | AEO Definition rotation | Expanded FAQ + pricing block + guarantee block | ~400w (rotate 4–6) |
| 🟢 **P2** | 27, 28, 29, 30, 31 | AEO How-To | FAQ + sidebar callouts + "How It Works" section | ~400w (rotate) |
| 🟢 **P2** | 32, 33, 34 | AEO Voice rotation | FAQ inline | ~200w |
| 🟢 **P2** | 35 | GEO Why Now + BoFU | "Why Now" block + 8-question checklist near CTA | ~600w |

**Total industry page word budget: ~3,000–3,800 words.**

---

# 👥 PERSONA → SECTION MAP

| Persona | Must-Have Sections |
|---------|--------------------|
| **P5 — AI-Forward Platform Operator** | Hero (9,10) → AEO FAQ (1,2,6,7,8) → Comparison (11,13,14) → Tech depth (18,19,20) → Why Now (35) → AI Readiness Call CTA |
| **P1 — Scaling CTO** | Hero (9,10) → AEO FAQ (3,5,7,8) → Comparison (11,12) → Tech depth (18,19) → Due diligence (29,35) → Structural guarantee callout (24) → Pre-contract engineer intro CTA |
| **P2 — Non-Technical Founder-Operator** | Hero (9,10) → AEO FAQ (1,2,4) → Scenario (16) → How It Works (27,28) → ROI (30) → Guarantee (24) → Discovery Sprint CTA with AI Audit Sprint named as follow-on |

---

# ✅ INDUSTRY PAGE COMPLIANCE CHECK

Before publishing any industry page section generated from these prompts, verify:

- [ ] **[Vertical] language used throughout** — search-side prompts use the vertical's own vocabulary, not generic "AI engineering" framing; a ride-hailing operator and a marketplace operator see completely different hero copy
- [ ] **[Domain-Edge-Cases] named explicitly** in tech-depth section — this is the primary differentiator from generic AI agency pages and is what AI engines cite as evidence of domain expertise
- [ ] **[AI-Feature-1] named as primary** — the page is not a generic "AI engineering" page; it leads with the single most impactful AI feature for this vertical and names it in the H1 or hero subhead
- [ ] **[Outcome-Metric-1] improvement framed as A/B-tested** — no vague "efficiency gains"; named metric + A/B methodology
- [ ] **No exact "800+" delivery count** — unquantified framing only until internal audit confirmed
- [ ] **AI feature delivery count not conflated with platform delivery count** — AI Engineering launched 2026; vertical-specific AI case studies are the only valid AI-delivery proof
- [ ] **Service-isolation + rule-based fallback** described at least once — critical for P5/P1 who will specifically ask about platform stability
- [ ] **Structural guarantees named by mechanism** (Day-1 GitHub, IP transfer, 48-hr SLA, pre-contract engineer intro, Audit Sprint escape hatch) — not verbal promises
- [ ] **No "faster with AI" or "AI-powered development" claim** — frame on vertical domain expertise and certainty of delivery
- [ ] **No retainer language** in pricing block or CTAs — fixed-price, output-based only
- [ ] **Disqualification banner present** — routes pre-traction operators to Product ICP (clone scripts)
- [ ] **Internal links in place** — parent page (`/industries`) + Pillar 7 blog article for this vertical + 2–3 adjacent industry pages
- [ ] **Schema stack live** — `Organization` + `Service` (vertical-scoped) + `FAQPage` + `BreadcrumbList`
- [ ] **Persona-tagged CTAs** — P5/P1 → AI Readiness Call; P1/P2 (cautious) → AI Audit Sprint page; P1/P2 (rebuild brief) → pre-contract engineer intro

---

**Total Prompts:** 35 per industry page | **9 pages via variable substitution**
**Priority Split:** 🔴 P0 (1–10) · 🟡 P1 (11–20) · 🟢 P2 (21–35)
**Vertical Slugs:** `ride-hailing` · `delivery` · `marketplace` · `home-services` · `ecommerce` · `super-app` · `travel` · `social-media` · `education`
**Source ICP:** [[Trioangle - ICP - Service]] | **Parent LP:** [[Service_Landing_Page_AEO_GEO_Prompts]] | **Track:** Track 2 ([[Trioangle Growth Plan]])
