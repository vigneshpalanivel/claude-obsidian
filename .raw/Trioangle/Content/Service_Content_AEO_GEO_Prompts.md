# AEO + GEO Prompts — Trioangle Service Content (Blog)

**Source:** `Trioangle - Content Strategy - Service.md` · `Trioangle - Service Blog Article Templates.md` · `Trioangle - ICP - Service.md` | **Generated:** May 2026

| Field | Value |
|-------|-------|
| **Content Subject** | 7-Pillar Service blog (97 articles) — AI Engineering primary + custom-dev secondary |
| **URL Pattern** | `trioangle.com/blog/[article-slug]` · `trioangle.com/guides/[hub-slug]` |
| **Hub Pages** | 7 pillar hubs — `/blog/ai-engineering-platform-businesses` (Pillar 7, 🥇 primary) + 6 secondary pillar hubs |
| **Total Article Count** | 97 articles across 7 pillars · 24 clusters |
| **Template Approach** | 8 content-shape templates · 5–7 prompts each · cluster-level variable substitution |
| **Total Prompt Templates** | 47 (~ 6 avg per shape) |
| **Estimated Prompt Outputs** | ~500 prompts after substitution across 97 articles |
| **Track** | Track 2 — AI-First Service Engine ([[Trioangle Growth Plan]]) — Pillar 7 leads |
| **Sibling LPs** | [[AI_Service_Landing_Page_AEO_GEO_Prompts]] · [[Service_Industry_Landing_Page_AEO_GEO_Prompts]] |

> [!NOTE] How to Use
> Each article maps to **one content shape** (CS-1 through CS-8). The shape provides 5–7 template prompts; substitute the article-level variables from the cluster mapping tables to produce the final FAQ-schema + GEO synthesis blocks for that article.
>
> **Output per article:** 3–5 AEO FAQ questions (40–60-word answers, FAQPage JSON-LD) + 1 GEO synthesis block (200–400w, compressed for AI-engine citation) + 1 CTA block (persona-routed).
>
> **Ship-priority labels (S0/S1/S2)** = when the prompt ships within an article's editorial sprint. **ICP persona labels (P1–P5)** = which Service ICP persona the prompt is anchored to. These are distinct dimensions.

---

## 🛡️ POSITIONING RULES (Apply to Every Prompt Below)

> [!IMPORTANT] Service Line Priority — AI First, Custom Dev Second
> Pillar 7 (AI Engineering) is the 🥇 primary content motion. When AI is in scope (any way — vertical AI competitor pressure, AI feature topic, AI-mention paragraph), the CTA defaults to the **AI Audit Sprint funnel** (Free 1-hour AI Readiness Call → Paid 2-week AI Audit Sprint, $1.5k–$4k, fee credited). Discovery Sprint is the secondary CTA, used only for explicit non-AI custom-dev briefs.

> [!IMPORTANT] Existing-Operator Filter — Mandatory
> Every prompt implicitly targets a reader running an **established platform with $1M+ ARR and 12+ months operational history** (or an established offline business with proven revenue). Pre-traction Seed/Series A startups are out of scope — route to Product ICP (white-label / ready-to-launch / productized solutions). If a prompt's framing implies "you just raised a Seed round" or "you're building an MVP" → reroute or reframe.

> [!IMPORTANT] AI-Era Positioning Rule
> Never position on "we build faster with AI." Position on domain expertise, certainty of delivery, and risk reduction. Service buyers in 2026 have seen too many AI demos that delivered nothing. They are buying a named team with deep vertical domain delivery history. "Faster with AI" invites "then why are you expensive?" and loses.

> [!IMPORTANT] AI Proof-Point Caveat — Pre-Publish Gate Active
> The "800+ platforms since 2015" stat counts **platform deliveries, not AI feature deliveries**. The AI Engineering service line launched in 2026; AI delivery count is far smaller and tracked separately. Do not use exact counts in any external content until the internal audit is confirmed.
>
> ❌ Never write: *"we've built AI features in 800+ platforms"*
> ✅ Use: *"domain knowledge from platform engagements across ride-hailing, logistics, marketplace, home services, and adjacent verticals since 2015 — applied to the AI integration layer"*

> [!IMPORTANT] Trust — Structural Guarantees Only
> Day-1 GitHub, IP transfer clause, 48-hour comm SLA with 5% credit, pre-contract engineer introduction. Never *"we pride ourselves on transparent communication."* Every Decision-stage CTA block must reference at least one contractual mechanism — never an adjective.

> [!IMPORTANT] No Retainer Language
> All engagements are fixed-price, output-based. No monthly retainer, no AI subscription, no per-hour billing. Pricing prompts must reflect this on every article.

> [!IMPORTANT] Channel-Partner Inbound Routing (P3 / P4)
> P3 (Enterprise) and P4 (MENA) are **channel-partner-only** — no direct outbound until the partner program is live. They will still land on these articles from search. Article copy stays unchanged for them; **CTA structure is what shifts** (Pillar 5 dual-CTA, Pillar 6 LinkedIn/WhatsApp soft CTA). Do not add P3/P4-specific banners or filters inside the article body.

> [!IMPORTANT] Industry-LP Cross-Link Discipline — No Clone Language
> When a blog article links across to an industry landing page (`/industries/[vertical]`), the anchor text must use white-label / ready-to-launch / productized framing. Never "clone," "Uber-clone," "Airbnb-clone," or "Gojek-clone." This applies to all internal links from Cluster 3.1 and Cluster 7.2 articles.

> [!IMPORTANT] AEO Intent-Split — Blog vs LP Query Ownership
> When a query could match both a blog article and an LP, ownership is split by intent. This prevents same-domain cannibalisation across [[AI_Service_Landing_Page_AEO_GEO_Prompts]] and [[Service_Industry_Landing_Page_AEO_GEO_Prompts]].
>
> - **Blog wins informational queries:** *"how does [X] work,"* *"[X] vs [Y] comparison guide,"* *"when does [X] make sense,"* *"what's the methodology for [X],"* *"what are the trade-offs of [X],"* *"how do I sequence [X]"*
> - **LP wins transactional queries:** *"build [X],"* *"[X] for [Platform-Type],"* *"[X] engineering company,"* *"hire a [Vertical] dev team,"* *"[Service] development,"* *"[Vertical] app development"*
> - **When unclear:** the blog is the internal-link tier; the LP is the conversion target. Blog body must hand off to LP for commercial conversation — never close the loop inside the blog post. Example handoff sentence: *"If you're ready to scope a build, see `/industries/[vertical]` for vertical-specific delivery details or book a free AI Readiness Call directly."*
>
> **Disambiguation rule when blog and LP prompts collide:** the blog prompt must be the **decision-framework / methodology** version of the question (educational, helps the reader think); the LP prompt is the **commercial-readiness** version (helps the reader buy). If a blog prompt reads identical to its LP twin, rephrase the blog prompt around methodology / sequencing / failure-mode trade-offs.

---

## 🏷️ SHIP-PRIORITY MARKERS

*Ship priorities use the S0/S1/S2 prefix to avoid collision with the P1–P5 ICP persona numbering used in the annotation column of each prompt.*

- 🔴 **S0** — Ship-first. Article H1 + primary FAQ + first GEO block (Day 1 of editorial sprint)
- 🟡 **S1** — Week 1. Secondary FAQ + comparison block + objection handler
- 🟢 **S2** — Week 2. BoFU diligence + ROI + compatibility FAQ near CTA

> [!NOTE] Per-Article Prompt Count
> Each article ships **3–5 AEO FAQ prompts** (rotation across S0/S1/S2 markers) + **1 GEO synthesis block**. Do not stuff 13 prompts into one blog article — that's the LP shape. Blog articles compress the full prompt set into FAQ-schema + body-prose synthesis.

---

## 🔤 VARIABLE SUBSTITUTION SYSTEM

The system has **three layers** of variables. Substitute from the most-specific layer first, then fill global defaults.

### Layer 1 — Global Variables (Apply to Every Article)

| Variable | Default Value |
|----------|---------------|
| `[Brand]` | Trioangle |
| `[Year]` | 2026 |
| `[Anchor-Vertical-Depth]` | *"built by the team that's shipped platforms across ride-hailing, delivery, marketplace, home services, and adjacent verticals since 2015"* |
| `[Anchor-Structural-Trust]` | Day-1 GitHub · IP transfer clause · 48-hour comm SLA with 5% credit · pre-contract engineer introduction |
| `[Disqual-Banner]` | *"This guide assumes a $1M+ ARR platform with 12+ months production history. Pre-traction operators: see our [white-label productized platforms](trioangle.com/products) instead."* |

### Layer 2 — Pillar-Level Variables

| Pillar | `[Pillar-Hub-URL]` | `[Pillar-Primary-Persona]` | `[Pillar-Default-CTA]` |
|--------|--------------------|-----------------------------|------------------------|
| 🥇 **P7 — AI Engineering** (PRIMARY) | `/blog/ai-engineering-platform-businesses` | 🎯 P5 AI-Forward Platform Operator | AI Readiness Call (Awareness) → AI Audit Sprint (Decision) |
| P1 — Scaling Architecture | `/blog/scaling-platform-architecture-guide` | 🪶 P1 Scaling CTO | Technical Architecture Review |
| P2 — Choosing Dev/AI Partner | `/blog/choosing-custom-development-partner` | All personas | Free 20-min Fit Call (P2 default) → Discovery Sprint (P1 upgrade) |
| P3 — Building Marketplaces | `/blog/building-on-demand-marketplace-platforms` | 🪶 P1 / 🪶 P2 (inbound) | Discovery Sprint (or AI Audit Sprint if AI in scope) |
| P4 — Tech Leadership | `/blog/technical-leadership-platform-operators` | 🪶 P1 / 🪶 P2 (inbound) | Track-routed: TAR (P1) or Free Fit Call (P2) |
| P5 — Enterprise (Channel-Partner) | `/blog/enterprise-digital-transformation-custom-platforms` | 🤝 P3 (partner-routed) | Partner CTA lead + Buyer CTA secondary (dual) |
| P6 — MENA (Channel-Partner) | `/blog/platform-development-mena-market` | 🤝 P4 (partner-routed) | LinkedIn / WhatsApp direct — no forms |

### Layer 3 — Persona → CTA Mapping (Stage-Aware)

| Persona | Awareness CTA | Consideration CTA | Decision CTA |
|---------|---------------|-------------------|--------------|
| 🥇 **P5 AI-Forward** | Free AI Readiness Call (1 hr) | AI Audit Sprint ($1.5k–$4k, fee credited) | AI Audit Sprint → fixed-price build |
| 🪶 **P1 Scaling CTO** | Technical Architecture Review | Technical Architecture Review | TAR → Discovery Sprint (or AI Audit if AI scope) |
| 🪶 **P2 Founder-Operator** | Free 20-min Fit Call (qualifies $1M+ ARR filter) | Free 20-min Fit Call → Discovery Sprint | Discovery Sprint (or AI Audit if AI scope) |
| 🤝 **P3 Enterprise** | Partner CTA + soft buyer CTA | Partner-routed RFP response | Partner-attribution RFP |
| 🤝 **P4 MENA** | LinkedIn / WhatsApp (no forms) | LinkedIn / WhatsApp | LinkedIn / WhatsApp with named regional references |

### Layer 4 — Article-Level Variables (Filled Per Article from Cluster Mapping Tables)

| Variable | Description |
|----------|-------------|
| `[Article-Topic]` | The subject as buyers search for it (e.g., *"technical debt identification"*, *"RAG knowledge assistant"*) |
| `[Primary-Keyword]` | Target SEO keyword from the Content Strategy table (e.g., *"how to scale a software platform"*) |
| `[Pain-Point]` | The ICP pain this article addresses (Pain 1 Scalability · 2 Ghosted Agency · 3 IP/Lock-In · 4 Speed vs Quality · 5 AI Gap · 6 Domain Expertise) |
| `[Outcome-Metric]` | The named measurable outcome (e.g., *"deployment time reduced from 6 hours to 22 minutes"* — A/B-test framed for AI articles) |
| `[Vertical]` | (Cluster 3.1 / 7.2 only) ride-hailing · food delivery · fleet · TMS · grocery · rental · marketplace · home services · dating · short video · EdTech · super app · classifieds |
| `[Platform-Type]` | The vertical reformatted as a platform descriptor (e.g., *"ride-hailing platform"*) |
| `[Alt-Service]` | The off-the-shelf alternative buyers compare against (e.g., AWS Personalize · Pinecone · Algolia · Intercom Fin) — Build-vs-Buy articles only |
| `[Objection-Anchor]` | From Content Strategy Part 10 Objection Handler Mapping (e.g., *"800+ stat is platform deliveries, not AI"*, *"agency ghosting"*, *"IP lock-in"*) |
| `[Structural-Guarantee]` | One named mechanism: Day-1 GitHub · IP transfer clause · 48-hr comm SLA · pre-contract engineer intro · AI Audit Sprint escape hatch · 3× peak load test |
| `[Trigger]` | Existing-operator triggers only: Series C+ growth round · acquisition / late-stage DD · vertical AI competitor announcement · senior engineering departure · public outage · ML/AI Engineer job posting |
| `[Stage]` | Awareness · Consideration · Decision · Implementation |
| `[Persona]` | P1 · P2 · P3 · P4 · P5 (see Layer 2/3) |
| `[Pillar]` | P1–P7 |
| `[CTA-Type]` | Resolved from persona × stage in Layer 3 |

---

## 📚 CONTENT-SHAPE → ARTICLE MAPPING

Each blog article maps to **one content shape (CS-1 through CS-8)**. The shape provides the prompt templates; article-level variables fill them.

| Shape | Coverage | Clusters | Article Count | Pillar Priority |
|-------|----------|----------|---------------|-----------------|
| **CS-1 — Tech-Debt & Architecture Diagnostic** | Identify/diagnose/fix architecture failure modes on a live platform | 1.1 · 1.2 · 1.3 | 13 | P1 (secondary) |
| **CS-2 — Vendor Selection, IP, Risk** | Choose/work with/recover from a dev or AI partner | 2.1 · 2.2 · 2.3 · 4.3 | 17 | All personas |
| **CS-3 — Vertical Platform Architecture** | "How to build a [Vertical] platform" — vertical-specific architecture deep-dives | 3.1 | 13 | P1+P2 (inbound) |
| **CS-4 — Tech Components & Build-vs-Buy** | Reusable architecture components + clone-script-vs-custom decisions | 3.2 · 3.3 | 8 | P1+P2 (inbound) |
| **CS-5 — Established-Operator Playbook** | Series C+ · DD · founder-operator survival · in-house vs agency | 4.1 · 4.2 | 12 | P1+P2 (inbound) |
| **CS-6 — AI Strategy & Vertical AI Features** 🥇 | AI feature selection + per-vertical AI deep-dives (PRIMARY MOTION) | 7.1 · 7.2 · 7.5 | 18 | 🥇 P5 (direct primary) |
| **CS-7 — AI Production & Build-vs-Buy** 🥇 | Live-platform AI integration + AI SaaS-vs-custom decisions | 7.3 · 7.4 | 7 | 🥇 P5 (direct primary) |
| **CS-8 — Enterprise + MENA Channel-Partner** | Enterprise digital transformation + MENA market entry — partner enablement | 5.x · 6.x | 12 | 🤝 P3 / P4 (partner-routed) |

---

# 📄 CONTENT-SHAPE TEMPLATE PROMPTS

*Each shape provides 5–7 prompts. Per article: select 3–5 from the relevant shape's set, substitute Layer 4 article variables, ship.*

---

## CS-1 — Tech-Debt & Architecture Diagnostic
**Coverage:** Cluster 1.1 (Diagnosing Tech Debt) · 1.2 (Architecture Best Practices) · 1.3 (Cloud & Infrastructure)
**Primary Persona:** 🪶 P1 Scaling CTO (inbound)
**Default CTA:** Technical Architecture Review (no upfront fee)
**Tone:** Peer-level technical · production-scale framing · existing-operator only

### Template Prompts

**1.1** What does [Article-Topic] actually look like on a live platform at scale — and what are the warning signs an established operator should act on? — 🔴 **S0** *| P1 | Hero FAQ | Hook: name 3–5 production-scale symptoms (e.g., p95 latency drift, deploy rollback rate, ticket-volume spike on identical UX); frame in terms of an operating platform, not an MVP; reference [Outcome-Metric] as the validated benchmark*

**1.2** How do I diagnose [Article-Topic] without disrupting active users in production? — 🔴 **S0** *| P1 | Diagnostic FAQ | Hook: read-only observability layer first (APM, query profiler, load-test against staging mirror), production rollout via feature flag, automatic rollback path; never "rip and replace" framing*

**1.3** [Approach A] vs [Approach B] for [Article-Topic] in [Year] — when is each the right call for an established platform? — 🟡 **S1** *| P1 | Comparison block | Hook: honest "use [Approach B] when" path is mandatory; recommend the simpler approach when domain fit is adequate; custom rebuild only wins when the platform's specific failure mode is reproducible against the cheaper option*

**1.4** What does fixing [Article-Topic] cost — and what's the realistic timeline before user-facing improvement? — 🟡 **S1** *| P1 | Cost + timeline block | Hook: fixed-price scoping at the deliverable level; typical range and timeline windowed by complexity; included vs not-included; no retainer, no hourly billing; the Technical Architecture Review is the free scoping path*

**1.5** Can [Article-Topic] be fixed incrementally on an existing tech stack (Laravel/PHP, Node.js, Python/Django, Ruby on Rails) without a full rewrite? — 🟢 **S2** *| P1 | Compatibility FAQ | Hook: service-isolation pattern — fix runs alongside the existing platform; gradual cutover via feature flag; rollback in < 1 minute; the core codebase is untouched in 80%+ of cases*

**1.6** What questions should I ask before signing any [Article-Topic] engagement with an external team? — 🟢 **S2** *| P1 | BoFU diligence | Hook: 6-question checklist — (1) production case study with named [Outcome-Metric]? (2) pre-contract engineer introduction? (3) Day-1 GitHub access? (4) fixed-price with defined acceptance condition? (5) rollback path? (6) NDA before code review? Anchor with [Brand]'s pre-filled answers*

### Article Substitution Reference — CS-1

| Article # | Topic | Primary Keyword | Cluster | Stage | Use Prompts |
|-----------|-------|------------------|---------|-------|-------------|
| 1 | Technical debt identification | technical debt identification platform operator | 1.1 | Awareness | 1.1, 1.2, 1.6 |
| 2 | Cheap MVP financial cost breakdown | cost of cheap MVP development | 1.1 | Awareness | 1.1, 1.4, 1.6 |
| 3 | Platform scalability warning signs (traffic spike) | platform scalability warning signs | 1.1 | Awareness | 1.1, 1.2, 1.5 |
| 4 | Monolith → microservices migration | monolith to microservices migration | 1.1 | Consideration | 1.3, 1.4, 1.5 |
| 5 | Crashing food-delivery rebuild case study | platform rebuild case study | 1.1 | Decision | 1.1, 1.4, 1.6 |
| 6 | Multi-tenant marketplace architecture | multi-tenant architecture marketplace | 1.2 | Awareness | 1.1, 1.3, 1.5 |
| 7 | Real-time tracking architecture (GPS) | real-time tracking architecture | 1.2 | Awareness | 1.1, 1.3, 1.5 |
| 8 | Database optimization (on-demand) | database optimization on-demand apps | 1.2 | Consideration | 1.2, 1.3, 1.5 |
| 9 | Redis caching strategies | redis caching marketplace | 1.2 | Consideration | 1.3, 1.5 |
| 10 | Load testing playbook (pre-launch) | load testing before launch | 1.2 | Implementation | 1.2, 1.5 |
| 11 | AWS vs GCP vs Azure for on-demand | AWS vs GCP vs Azure on-demand apps | 1.3 | Consideration | 1.3, 1.4 |
| 12 | AWS cost reduction (40% through architecture) | reduce AWS costs optimization | 1.3 | Consideration | 1.2, 1.4 |
| 13 | CI/CD pipeline setup (marketplace) | CI/CD pipeline marketplace app | 1.3 | Implementation | 1.2, 1.5 |
| 75 | 72-hour outage post-mortem | platform outage post-mortem | 1.1 | Awareness | 1.1, 1.2, 1.6 |

---

## CS-2 — Vendor Selection, IP, Risk
**Coverage:** Cluster 2.1 (Vendor Selection) · 2.2 (Risk & IP) · 2.3 (Working Together) · 4.3 (Compliance & Security)
**Primary Persona:** All personas (P1+P2 conversion; P3/P4 routed via partner)
**Default CTA:** Free 20-min Fit Call (P2 default) → Discovery Sprint upgrade
**Tone:** Empathetic-first for vendor-fatigue articles, peer-technical for compliance articles

### Template Prompts

**2.1** What should I look for when evaluating a [Partner-Type] for [Article-Topic] — and what are the red flags? — 🔴 **S0** *| All personas | Hero FAQ | Hook: 5–7 verifiable signals — production case study in your platform type, pre-contract engineer intro, Day-1 GitHub access in writing, IP transfer clause, 48-hour comm SLA, fixed-price acceptance condition; red flags = verbal promises with no contractual mechanism, refusal of engineer intro, retainer-shaped pricing*

**2.2** How do I protect [Asset-Type] (IP / codebase / data / model artifacts) when working with an external [Partner-Type]? — 🔴 **S0** *| P1·P2 (trust) | FAQ | Hook: NDA executed before any code review; read-only codebase access during integration; write access only on agreed feature branches; Day-1 GitHub access (client owns the repo from commit one); IP transfer clause at delivery — no exceptions, no licensing of "shared libraries"; data handling clause prevents third-party model training*

**2.3** [Partner-Type-A] vs [Partner-Type-B] vs [Partner-Type-C] — which fits an established operator at [ARR-Stage]? — 🟡 **S1** *| All personas | Comparison block | Hook: honest "use [Partner-Type-X] when" path mandatory; boutique-agency model wins when domain fit + senior delivery matters; enterprise consultancy wins when procurement/compliance theater is the gating constraint; freelancer wins when scope is a single component (< 4 weeks); avoid recommending the boutique in every case — credibility comes from honest disqualification*

**2.4** How long does a [Article-Topic] engagement actually take — from first conversation to live in production? — 🟡 **S1** *| All personas | Timeline block | Hook: Discovery Sprint or AI Audit Sprint (1–2 weeks, paid, fee credited) → scoped quote (1–3 days) → build (4–16 weeks depending on scope) → live and measured; named milestones; no "depends on requirements" non-answer*

**2.5** What does a [Article-Topic] engagement cost — what's included, what's not, and what's the risk of scope creep? — 🟢 **S2** *| All personas | Cost + scope FAQ | Hook: fixed-price scoped at deliverable level; included: scoping, build, deployment, monitoring, post-delivery support window; not included: ongoing retainer beyond support window, infrastructure hosting after handoff; scope creep is contractually bounded — change requests priced separately, no "we'll figure it out" billing*

**2.6** What's the rebound playbook after a failed [Partner-Type] engagement — how do I salvage value from paused or stalled work? — 🟢 **S2** *| P1·P2 (vendor-fatigue) | Empathy-first BoFU | Hook: code audit of what was actually delivered (read-only, no commercial pitch); IP recovery checklist if access was lost; gap analysis vs original spec; production-readiness review; the 45-minute architecture review (free, no sales pitch) is the empathy-first entry — never lead with discovery call*

**2.7** What compliance / security guarantees should a [Partner-Type] provide for [Compliance-Standard]? — 🟡 **S1** *| P1 (compliance only) | Compliance FAQ | Hook: data encryption in transit + at rest, access logging with retention SLA, named compliance officer, SOC 2 or PCI-DSS audit history, breach notification clause; the Technical Architecture Review surfaces gaps before commercial conversation*

### Article Substitution Reference — CS-2

| Article # | Topic | Cluster | Stage | Use Prompts | Special CTA |
|-----------|-------|---------|-------|-------------|-------------|
| 14 | 15 questions for a dev agency | 2.1 | Consideration | 2.1, 2.3, 2.5 | — |
| 15 | Custom vs white-label | 2.1 | Consideration | 2.3, 2.4, 2.5 | — |
| 16 | Boutique vs consultancy vs freelancer | 2.1 | Consideration | 2.3, 2.5 | — |
| 17 | Evaluate code quality (non-technical) | 2.1 | Consideration | 2.1, 2.6 | P2 Fit Call lead |
| 18 | Domain expertise > generic coding | 2.1 | Awareness | 2.1, 2.3 | — |
| 19 | IP ownership in outsourced dev | 2.2 | Awareness | 2.2, 2.5 | — |
| 20 | Vendor lock-in prevention | 2.2 | Awareness | 2.2, 2.5 | — |
| 21 | $60k agency-ghosting lesson | 2.2 | Awareness | 2.1, 2.2, 2.6 | Empathy-first (vendor fatigue) |
| 22 | Contracts, escrow, GitHub access | 2.2 | Decision | 2.1, 2.2, 2.5 | — |
| 23 | Discovery Sprint week-by-week | 2.3 | Decision | 2.4, 2.5 | — |
| 24 | Agile sprint planning (external) | 2.3 | Implementation | 2.4 | — |
| 25 | Being a great Product Owner | 2.3 | Implementation | 2.4 | — |
| 79 | Salvage failed dev partnership | 2.3 | Awareness | 2.1, 2.6 | ⚠️ Empathy-first only — 45-min architecture review |
| 81 | Reading Clutch/G2 reviews | 2.1 | Consideration | 2.1, 2.3 | — |
| 48 | SOC 2 compliance | 4.3 | Awareness | 2.5, 2.7 | P1 TAR only |
| 49 | PCI-DSS for marketplace payments | 4.3 | Awareness | 2.5, 2.7 | P1 TAR only |
| 50 | Security audit failure recovery | 4.3 | Awareness | 2.1, 2.6, 2.7 | P1 TAR only |

> [!IMPORTANT] Article #79 + #21 — CTA Override
> Both target prospects who concluded a failed agency engagement. **Do not use a discovery-call CTA.** End with: *"If you're rebuilding after a painful agency experience, we offer a free 45-minute architecture review — no commercial conversation, just a technical second opinion. No forms, no pitch."* Tone: empathetic first, credibility second, never transactional. Reference: Content Strategy Cluster 2.3 CTA note.

---

## CS-3 — Vertical Platform Architecture
**Coverage:** Cluster 3.1 — *"How to build a [Vertical] platform"* (13 articles, one per vertical)
**Primary Persona:** 🪶 P1 Scaling CTO + 🪶 P2 Founder-Operator (both inbound)
**Default CTA:** Discovery Sprint **with AI Audit Sprint explicitly named as Phase 2** (or AI Audit Sprint lead if AI competitor pressure is in scope). Reference: [[Service_Industry_Landing_Page_AEO_GEO_Prompts]] §Two Pre-Sales Sprints — *"signing Discovery Sprint without naming AI Audit Sprint as the next phase converts a recurring AI-feature buyer into a one-shot rebuild buyer"* — same discipline applies on blog CTAs.
**Tone:** Vertical-domain-deep — name 2–3 genuine edge cases per article that a generic agency would learn at the client's expense

### Template Prompts

**3.1** How does a [Platform-Type] actually work end-to-end — what are the core components an established operator must get right? — 🔴 **S0** *| P1·P2 | Hero FAQ | Hook: 4–6 named components specific to the vertical (e.g., ride-hailing: dispatch algorithm + surge engine + driver supply curve + payment split + KYC + map provider); cross-link to the relevant `/industries/[vertical]` LP using white-label / productized framing, never "clone"*

**3.2** What are the platform-specific edge cases in a [Platform-Type] that generic engineering teams miss? — 🔴 **S0** *| P1·P2 | Domain-depth FAQ | Hook: 2–3 vertical edge cases from the Service Blog Article Templates table (e.g., grocery: cold-chain SLA + age verification + substitution logic; classifieds: contact-gating + spam filter feedback loop + listing-quality scoring); these are the things a generic agency bills the client to discover in months 1–3*

**3.3** How much does building a [Platform-Type] cost — realistic budget ranges for an established operator extending or rebuilding a working business? — 🟡 **S1** *| P1·P2 | Cost block | Hook: range scoped by feature breadth (core platform vs core + 2 AI features vs full multi-tenant); fixed-price; included vs not-included; no retainer; the Discovery Sprint or AI Audit Sprint produces the exact quote — listed-on-page ranges are guideposts only*

**3.4** Build [Platform-Type] from scratch vs. starting from a productized white-label vs. extending existing software — which fits an established operator at [ARR-Stage]? — 🟡 **S1** *| P1·P2 | Comparison block | Hook: extending wins when the existing platform's domain logic is mostly right; productized white-label wins when speed-to-launch on a vertical clone matters more than custom feature breadth; greenfield custom wins when the platform's business logic produces specific failure modes against off-the-shelf — link to `/industries/[vertical]` for productized path, never "clone"*

**3.5** How does AI sit on top of [Platform-Type] architecture — what data dependencies must the base platform produce now for AI features to work later? — 🟢 **S2** *| P5 cross-link | AI-readiness sequencing FAQ | Hook: AI features are downstream of platform event data; the [Platform-Type] must emit clean, labeled events for [Provider]/[User] outcomes before AI feature work can A/B-test against rule-based baseline; name 2–3 event streams the base platform should instrument from Day 1 even pre-AI (e.g., assignment outcomes, conversion events, moderation decisions); cross-link to `/ai-engineering/[ai-feature-slug]` LP for delivery scoping and to relevant Pillar 7 article for AI feature deep-dive; ⚠️ this prompt is the educational/sequencing version of `Industry LP #1` (which targets the transactional "what AI to build" query) — they must not duplicate*

**3.6** What does a typical [Platform-Type] build timeline look like — from first conversation to production at scale? — 🟢 **S2** *| P1·P2 | Timeline FAQ | Hook: Discovery Sprint (1–2 weeks, $2k–$4k, with AI Audit Sprint explicitly named as Phase 2 for any AI roadmap) OR AI Audit Sprint lead (when AI is the primary scope) → scoped quote (1–3 days) → build phases (typically 8–16 weeks for core platform, +4–8 weeks per AI feature added) → production with 3× peak load test → measurement window; named milestones, named acceptance conditions; ⚠️ blog must never present Discovery Sprint as a standalone end-state — Phase 2 AI Audit naming is non-negotiable*

### Article Substitution Reference — CS-3

| Article # | [Vertical] | [Platform-Type] | Cross-Link AI Feature | Cluster | Use Prompts |
|-----------|------------|------------------|------------------------|---------|-------------|
| 26 | Ride-Hailing | ride-hailing platform | AI dispatch optimization (#86) | 3.1 | 3.1, 3.2, 3.4, 3.5 |
| 27 | Food Delivery | food delivery platform | AI demand forecasting (#88) | 3.1 | 3.1, 3.2, 3.4 |
| 28 | Rental Marketplace | rental platform | AI availability prediction (#102) | 3.1 | 3.1, 3.2, 3.5 |
| 29 | Super App | super app | AI cross-service intelligence (#108) | 3.1 | 3.1, 3.2, 3.4, 3.5 |
| 30 | Home Services | home services platform | AI conversational booking (#89, #103) | 3.1 | 3.1, 3.2, 3.5 |
| 61 | Fleet & Logistics | fleet management platform | AI demand forecasting (#88) | 3.1 | 3.1, 3.2, 3.6 |
| 62 | TMS / Supply Chain | TMS platform | (limited AI scope) | 3.1 | 3.1, 3.2, 3.6 |
| 63 | Grocery & Pharmacy | grocery delivery platform | AI dispatch (#86) | 3.1 | 3.1, 3.2, 3.5 |
| 64 | E-Commerce Marketplace | multi-seller marketplace | AI fraud detection (#87) + AI search (#107) | 3.1 | 3.1, 3.2, 3.4, 3.5 |
| 65 | Dating | dating platform | AI matching (#105) | 3.1 | 3.1, 3.2, 3.5 |
| 66 | Short Video / Social | short-video platform | AI feed ranking (#117) | 3.1 | 3.1, 3.2 (limited AI per #117 caveat) |
| 67 | EdTech | edtech platform | AI personalization (#106) | 3.1 | 3.1, 3.2, 3.5 |
| 74 | Classifieds | classifieds platform | AI moderation (#104) | 3.1 | 3.1, 3.2, 3.5 |

> [!NOTE] CS-3 + Industry LP Cross-Link Discipline
> Every CS-3 article must internally link to `trioangle.com/industries/[vertical]` (the matching productized LP). Anchor text uses **white-label / ready-to-launch / productized** framing. Never use "clone," "Uber-clone," "Airbnb-clone," "Gojek-clone" — that framing belongs to product-side LPs only. Reference: project memory *Trioangle Industry LPs — No Clone Language*.
>
> Article #62 (TMS) and #66 (Short Video) — primary persona override: TMS targets Scaling CTO + Enterprise Buyer (not Founder-Operator); Short Video stays at Awareness stage until at least one production AI case is confirmed in the vertical.

---

## CS-4 — Tech Components & Build-vs-Buy
**Coverage:** Cluster 3.2 (Core Technical Components) · 3.3 (Build vs Buy)
**Primary Persona:** 🪶 P1 Scaling CTO + 🪶 P2 Founder-Operator (inbound)
**Default CTA:** Discovery Sprint
**Tone:** Decision-framework — the article exists to help the reader make a call, not to sell

### Template Prompts

**4.1** What is [Article-Topic] — and why does it matter for an established [Platform-Type]? — 🔴 **S0** *| P1·P2 | Definition FAQ | Hook: 50-word definition framed for a live-platform operator, not an MVP-builder; name the production-scale problem this component solves; reference [Outcome-Metric] as the validation*

**4.2** [Approach A] vs [Approach B] for [Article-Topic] — when does each win at production scale? — 🔴 **S0** *| P1·P2 | Comparison block | Hook: honest "use [Approach B] when" path mandatory; decision criteria by load profile, latency requirement, and team size; production-scale framing, not theoretical*

**4.3** When does a clone-script / off-the-shelf solution stop working for [Article-Topic] — what are the signs an established operator needs custom? — 🟡 **S1** *| P1·P2 | Build-vs-Buy decision block | Hook: 4–5 named breakpoints (custom business logic, multi-region compliance, performance ceiling, feature roadmap divergence, vendor pricing crossover); recommend the clone-script path when fit is adequate — credibility comes from honest disqualification; cross-link to `/industries/[vertical]` for the productized path*

**4.4** What does building custom [Article-Topic] cost — and how do I estimate ROI against the off-the-shelf alternative? — 🟡 **S1** *| P1·P2 | Cost + ROI FAQ | Hook: fixed-price build range; off-the-shelf TCO over 24–36 months (license + customization + lock-in cost); break-even calculator framing; the Discovery Sprint produces the specific number*

**4.5** Can [Article-Topic] be added incrementally to an existing platform without a rewrite? — 🟢 **S2** *| P1·P2 | Compatibility FAQ | Hook: service-isolation pattern; new component runs alongside existing; gradual cutover; rollback in < 1 minute; backend-stack-agnostic as long as an API layer exists*

### Article Substitution Reference — CS-4

| Article # | Topic | [Alt-Service / Approach B] | Cluster | Stage | Use Prompts |
|-----------|-------|------------------------------|---------|-------|-------------|
| 31 | Driver dispatch algorithms | FIFO vs proximity vs competitive | 3.2 | Consideration | 4.1, 4.2 |
| 32 | Multi-vendor commission flow | Stripe Connect · custom payout engine | 3.2 | Consideration | 4.1, 4.2, 4.4 |
| 33 | Multi-currency / multi-language | i18n libraries · custom localization layer | 3.2 | Consideration | 4.1, 4.5 |
| 34 | Payment gateway integration | Stripe · Razorpay · regional PG · custom orchestration | 3.2 | Consideration | 4.1, 4.2, 4.5 |
| 35 | Push notification architecture | Firebase · OneSignal · custom delivery pipeline | 3.2 | Implementation | 4.1, 4.5 |
| 76 | Multi-region expansion architecture | single-region scale-out · multi-region active-active | 3.2 | Awareness | 4.1, 4.2, 4.4 |
| 36 | Build vs white-label decision framework | productized white-label platforms | 3.3 | Consideration | 4.3, 4.4 |
| 37 | When clone scripts stop working | productized clone-script extension | 3.3 | Consideration | 4.3, 4.4 |
| 38 | True cost of custom on-demand platform | productized clone-script TCO | 3.3 | Decision | 4.3, 4.4 |

> [!NOTE] CS-4 — Article #36 & #37 Editorial Routing
> Both target established operators weighing a greenfield rebuild vs. adapting an off-the-shelf solution. Frame **exclusively** for the established-operator context — reader has 12+ months revenue traction and a live platform, not someone building an MVP. Recommend the productized path honestly when adequate; recommend custom when the platform's specific failure mode is reproducible against off-the-shelf. Cross-link to `/industries/[vertical]` using white-label / ready-to-launch framing.

---

## CS-5 — Established-Operator Playbook
**Coverage:** Cluster 4.1 (Established-Operator Technical Execution) · 4.2 (Building Engineering Teams)
**Primary Persona:** 🪶 P1 Scaling CTO + 🪶 P2 Founder-Operator (inbound)
**Default CTA:** Track-routed — TAR for P1 articles, Free Fit Call for P2 articles
**Tone:** Trigger-aware — Series C+, acquisition DD, engineer departure, vertical AI competitor; never Seed/Series A framing

### Template Prompts

**5.1** What does an established operator need to do in [Article-Topic] context — what's the playbook? — 🔴 **S0** *| P1·P2 | Hero FAQ | Hook: 90-day or 6-month timeline for the [Trigger] event; named milestones; existing-operator framing only (≥ $1M ARR, ≥ 12-month operating history); never "you just raised a Seed round" framing*

**5.2** How do I evaluate [Article-Topic] when I'm a non-technical founder-operator of an established business? — 🔴 **S0** *| P2 | Founder-Operator FAQ | Hook: business-outcome framing first (revenue impact, customer retention, ops cost); 3 questions to ask without engineering background; meet-the-engineers before signing; defer to a Free 20-min Fit Call for personalized evaluation; ⚠️ never use Discovery Sprint CTA on P2 awareness articles*

**5.3** In-house engineering team vs. external dev/AI agency vs. hybrid — what's the right call for an established platform operator? — 🟡 **S1** *| P1·P2 | Comparison block | Hook: in-house wins when [Article-Topic]-shape work exceeds 3–4 projects/year — at that scale, full-time salary beats fixed-price; external wins for project shape work, vertical-domain depth, and avoiding ML hiring cycle (4–9 months); hybrid wins when the team is mid-size and a single senior external engineer accelerates a known gap; honest disqualification path on each*

**5.4** How does an established operator pass technical due diligence for [Trigger] (Series C+ growth round, acquisition, late-stage M&A signal)? — 🟡 **S1** *| P1 | DD-readiness FAQ | Hook: 6-point audit checklist — architecture diagrams updated, security review with compliance certs, dependency-and-IP cleanliness audit, on-call playbook + runbooks, observability metrics with named SLOs, named platform owner; the Technical Architecture Review surfaces these in 1 hour before the DD conversation*

**5.5** How do I respond when [Trigger] hits my platform — vertical AI competitor announcement, key engineer departure, public outage, late-stage round? — 🟡 **S1** *| P1·P2 | Trigger response FAQ | Hook: specific 30/60/90-day response playbook per trigger; never "panic-rebuild" framing; the AI Readiness Call (free, 1 hour) for AI-competitor triggers; the Technical Architecture Review for departure / outage / round triggers; existing-operator only*

**5.6** When should an established operator hire a first senior CTO / VP Engineering — and how do I evaluate candidates as a non-technical founder? — 🟢 **S2** *| P2 | Hiring decision FAQ | Hook: hire-trigger at 8–12 engineers and revenue > $3M ARR (not before — at < $3M ARR a fractional CTO or external partner often fits better); evaluation rubric a non-technical founder can use (production case study, code-review walkthrough with a peer reference, on-call experience, hiring track record); ⚠️ P2 default CTA = Free Fit Call, not Discovery Sprint*

### Article Substitution Reference — CS-5

| Article # | Topic | Primary Persona | [Trigger] | Cluster | Stage | Use Prompts | CTA Override |
|-----------|-------|------------------|-----------|---------|-------|-------------|---------------|
| 39 | Series C / Growth Round 90-day playbook | P1 | Series C+ growth round | 4.1 | Awareness | 5.1, 5.4, 5.5 | TAR or Discovery Sprint OK |
| 40 | Technical due diligence for acquisition | P1 | Acquisition / late-stage DD | 4.1 | Awareness | 5.1, 5.4 | TAR or Discovery Sprint OK |
| 41 | Lead engineer just quit survival guide | P1·P2 | Senior engineering departure | 4.1 | Awareness | 5.1, 5.5 | Empathy-first wording |
| 42 | Speed vs quality on live platform | P1 | Ongoing operating tension | 4.1 | Awareness | 5.1, 5.3 | TAR |
| 43 | What late-stage investors look for in tech stack | P1·P2 | Series C+ / acquisition DD | 4.1 | Awareness | 5.1, 5.4 | — |
| 80 | Vertical competitor shipped AI — engineering response | P1·P2 | Vertical AI competitor announcement | 4.1 | Awareness | 5.5 | 🥇 AI Readiness Call (AI in scope) |
| 44 | In-house vs agency vs hybrid | P1·P2 | — | 4.2 | Consideration | 5.3 | — |
| 45 | Non-technical founder evaluating engineering | P2 | — | 4.2 | Awareness | 5.2, 5.6 | ⚠️ Free Fit Call only |
| 46 | "No technical co-founder" on a working business | P2 | — | 4.2 | Awareness | 5.2, 5.6 | ⚠️ Free Fit Call only |
| 47 | Working with external dev/AI team as non-technical CEO | P2 | — | 4.2 | Consideration | 5.2, 5.3 | ⚠️ Free Fit Call only |
| 77 | Hiring first senior CTO / VP Engineering | P2 | — | 4.2 | Awareness | 5.6 | ⚠️ Free Fit Call only |
| 78 | Senior vs junior engineers staffing | P1·P2 | — | 4.2 | Consideration | 5.3 | — |

> [!IMPORTANT] CS-5 P2 CTA Discipline (Articles #45, #46, #47, #77)
> These articles attract pre-revenue / pre-traction founder readers who do NOT meet the Existing-Operator Filter. **Do not use a paid Discovery Sprint CTA.** Use the qualification-first Fit Call CTA: *"Not sure if your platform is at the stage we work with? Book a free 20-minute fit call — no commitment, no pitch. We work exclusively with platforms doing $1M+ ARR with 12+ months of operating history; we'll tell you honestly whether we're the right partner."* Reserve paid Sprint CTAs for explicit established-operator articles (#39, #40, #43). Reference: Content Strategy Cluster 4.2 CTA note.

---

## CS-6 — AI Strategy & Vertical AI Features 🥇 (PRIMARY MOTION)
**Coverage:** Cluster 7.1 (AI Strategy) · 7.2 (AI Feature Deep-Dives by Vertical) · 7.5 (AI Hub Content)
**Primary Persona:** 🥇 P5 AI-Forward Platform Operator (direct primary)
**Default CTA:** Stage-routed — AI Readiness Call (Awareness) · AI Audit Sprint (Consideration / Decision)
**Tone:** Engineer-to-engineer · skeptical-of-hype · domain-proof-first · A/B-test-framed metrics only

### Template Prompts

**6.1** Which AI features actually move [Platform-Type] business metrics in [Year] — and which are hype? — 🔴 **S0** *| P5 | Hero FAQ | Hook: 2–3 named AI features with the specific business metric each moves (e.g., AI dispatch → driver-idle-time ↓ + completed-trip rate ↑; AI fraud detection → chargeback rate ↓ + GMV protected; AI moderation → false-positive removal ↓ + GMV from valid listings restored); honest "buy off-the-shelf when [Alt-Service] fits" path; the AI Readiness Call maps the specific 2–3 for the platform in 1 hour*

**6.2** When does [AI-Feature] make sense for a [Platform-Type] — and what are the decision criteria for choosing custom vs sticking with [Alt-Service]? — 🔴 **S0** *| P5 | Decision-criteria FAQ | Hook: 4–5 named decision criteria — vertical edge-case density, data ownership requirements, latency / explainability constraints, A/B-measurable failure mode against [Alt-Service], integration depth into the platform's business logic; honest "stick with [Alt-Service] when" path; ⚠️ this is the **decision-framework** version of `AI Service LP #1` (which targets the transactional "what is [Service]" query) — blog rephrases around criteria + sequencing, never duplicates LP definitions*

**6.3** How does [AI-Feature] integrate end-to-end into a live [Platform-Type] without breaking stability? — 🟡 **S1** *| P5 | Tech-depth GEO synthesis block (~300w) | Hook: platform API / event stream → data ingestion layer → AI service core build using [Key-Tech] → service-isolation deployment → staging A/B test against rule-based baseline → feature-flag rollout → automatic rollback on confidence/latency degradation → [Outcome-Metric] tracked vs pre-AI baseline*

**6.4** How do I model the ROI of [AI-Feature] for my [Platform-Type] before committing to a build — what methodology should a [Persona] use to defend the number to a board or co-founder? — 🟡 **S1** *| P5 | ROI methodology FAQ | Hook: 5-step methodology — (1) baseline [Outcome-Metric] over a representative window (8–12 weeks), (2) realistic lift band from comparable [Vertical] A/B-tested deployments, (3) business-value conversion (e.g., trip volume × commission % for ride-hailing), (4) sensitivity analysis at the low end of the lift band, (5) payback timeline against fixed-price build cost; AI Audit Sprint deliverable produces this model with the platform's actual data; ⚠️ this is the **methodology** version — for raw cost numbers, cross-link to `AI Service LP #3` (cost) and `AI Service LP #12` (ROI) and to `Industry LP #30` (board-defensible ROI)*

**6.5** What's the AI Readiness Audit — and how do I evaluate if my platform is ready for [AI-Feature] before committing to a build? — 🟢 **S2** *| P5 | Readiness FAQ | Hook: 5-dimension audit — data quality + volume, integration surface (API readiness), historical baseline (do we have a pre-AI metric to A/B against?), team capacity for production AI, business case strength; the free 1-hour AI Readiness Call covers dimensions 1–3; the paid 2-week AI Audit Sprint covers all 5 + recommends 2–3 features to build first*

**6.6** Why do generic AI consultants fail platform businesses — and what should I look for in an AI feature engineering partner instead? — 🟢 **S2** *| P5 | Trust + diligence FAQ | Hook: generic AI consultant = strategy + slides + LLM demo with no production hand-off; AI feature engineering partner = production AI integrated into the platform's existing API layer with named [Outcome-Metric] before sign-off; 6 verifiable diligence signals — production case study in the vertical with named A/B metric, pre-contract engineer introduction, Day-1 GitHub access, IP transfer clause (model artifacts + data pipeline + inference code), fixed-price acceptance condition, rule-based fallback in the architecture*

**6.7** What's the AI engineering stack for an established [Platform-Type] — what tech choices matter and which are buyer concerns? — 🟢 **S2** *| P5 | Tech-depth FAQ | Hook: name the stack components — orchestration framework (LangGraph · LangChain), vector store (pgvector · Pinecone) with build-vs-buy honesty, embedding model (OpenAI · open-source), reranker, observability (Langfuse · custom); the stack is chosen at the AI Readiness Call based on data volume, latency requirements, and hosting constraints — not on team preference; full stack disclosed before signing, client-owned at delivery*

### Article Substitution Reference — CS-6

| Article # | Topic | [AI-Feature] | [Vertical] | [Alt-Service] | Cluster | Stage | Use Prompts | CTA |
|-----------|-------|---------------|------------|----------------|---------|-------|-------------|-----|
| 82 | Which AI features move marketplace metrics | — (strategy) | marketplace | various SaaS | 7.1 | Awareness | 6.1, 6.5, 6.6 | 🥇 AI Readiness Call |
| 83 | AI Readiness Audit | — (strategy) | all verticals | — | 7.1 | Awareness | 6.5, 6.6 | 🥇 AI Readiness Call |
| 84 | Why generic AI consultants fail | — (strategy) | all verticals | generic AI consulting | 7.1 | Awareness | 6.6, 6.5 | 🥇 AI Readiness Call |
| 85 | AI dynamic pricing for ride-hailing | AI dynamic pricing | ride-hailing | Uber Surge engine · in-house ML | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 86 | Intelligent dispatch (AI vs rule-based) | AI dispatch optimization | ride-hailing / delivery | rule-based matching | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 87 | Marketplace fraud detection with AI | AI fraud detection | marketplace / e-commerce | Sift · Stripe Radar | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 88 | Demand forecasting (logistics) | AI demand forecasting | logistics / delivery | rule-based forecasting · GCP Vertex | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 89 | Conversational booking interface | AI conversational booking | home services / hospitality | rule-based forms · Intercom | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 102 | AI for rental marketplaces | AI availability prediction + pricing | rental | Algolia · in-house heuristics | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 103 | AI for on-demand home services | AI provider matching | home services | rule-based matching | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 104 | AI for classifieds | AI moderation + listing-quality scoring | classifieds | Perspective API · manual mod | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 105 | AI for dating apps | embedding-based compatibility | dating | rule-based matching | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 106 | AI for EdTech | personalized learning paths | EdTech | rule-based pathing · Khan-style | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 107 | AI for e-commerce marketplaces | AI search + ranking + trust scoring | e-commerce | Algolia · AWS Personalize | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 108 | AI for super apps | cross-service intent models | super app | siloed per-service ML | 7.2 | Consideration | 6.2, 6.3, 6.4 | 🥇 AI Audit Sprint |
| 117 | AI for short video / social | feed ranking + moderation | short video / social | TikTok-style heuristics · Perspective API | 7.2 | Awareness | 6.1, 6.5 | 🥇 AI Readiness Call only (no Audit until cases) |
| 118 | AI for booking / OTA | demand forecasting + dynamic pricing | booking / OTA | rule-based pricing · GCP Vertex | 7.2 | Awareness | 6.1, 6.5 | 🥇 AI Readiness Call only (no Audit until cases) |
| 113 | AI engineering stack reference guide | — (cross-feature) | all verticals | — | 7.5 | Awareness | 6.6, 6.7 | 🥇 AI Readiness Call |

> [!IMPORTANT] CS-6 — Articles #117 & #118 (Awareness-Stage Caveat)
> Per Content Strategy note on these articles: lead with platform delivery depth (*"engineers who've shipped 20+ social platforms"*), not AI outcome metrics. Do not apply A/B-test framing until at least one production AI case exists per vertical. CTA: Free AI Readiness Call only — never AI Audit Sprint. Upgrade to Consideration stage + add specific metrics when cases are confirmed.
>
> ⚠️ **Pre-Publish Gate (mandatory across all CS-6 prompts):** No exact AI delivery count (800+ or otherwise) until internal audit confirmed. Use *"domain knowledge from platform engagements across [verticals] since 2015 — applied to the AI integration layer."*

---

## CS-7 — AI Production & Build-vs-Buy 🥇
**Coverage:** Cluster 7.3 (Production AI Integration & Risk) · 7.4 (AI Build-vs-Buy Loss-Reason Counter)
**Primary Persona:** 🥇 P5 AI-Forward Platform Operator (direct primary)
**Default CTA:** AI Audit Sprint (framed around honest build-vs-buy advice)
**Tone:** Build-vs-buy honesty — recommending the SaaS when it fits is a structural differentiator; this CTA defeats the "AI vendor who pitches every project" objection

### Template Prompts

**7.1** Can [AI-Feature] be added to a live [Platform-Type] without breaking stability — and what's the safe-deployment architecture? — 🔴 **S0** *| P5 | Production-integration FAQ | Hook: AI service runs as isolated microservice alongside platform; gradual feature-flag rollout; automatic fallback to rule-based logic on confidence-threshold breach or latency spike; rollback in < 1 minute; core platform user flow is never in the AI failure path; A/B-test against pre-AI baseline before full rollout*

**7.2** What are the specific production failure modes of [Alt-Service] (AWS Personalize · Pinecone · Algolia · GCP Vertex AI · OpenAI direct) on a [Platform-Type] — and what are the named trigger points where a custom build becomes the right call? — 🔴 **S0** *| P5 | Named-SaaS failure-mode block (~300w) | Hook: 3–5 specific failure modes named per [Alt-Service] (e.g., AWS Personalize cold-start problem on new-SKU marketplaces, Pinecone retrieval-quality drift at > 10M vectors, Vertex AI explainability gap for compliance-regulated verticals); each failure mode has a measurable trigger point (false-positive rate ceiling, latency SLA breach, recall drop on long-tail queries); honest "stay with [Alt-Service] when" path mandatory; ⚠️ this is the **named-SaaS-deep-dive** version of `AI Service LP #6` (which is generic custom-vs-Alt-Service comparison) — blog goes deep on one Alt-Service per article, LP stays generic*

**7.3** Why is my data probably not AI-ready yet — and what should I fix before building [AI-Feature]? — 🟡 **S1** *| P5 | Data-readiness FAQ | Hook: 5 readiness gaps — data volume (most platforms have enough but it's scattered), labeling / ground truth (often missing), schema consistency across services, historical baseline metric for A/B comparison, PII / data-handling compliance; the AI Readiness Call surfaces these in 1 hour; the AI Audit Sprint produces the gap-fix plan + cost estimate*

**7.4** GitHub Copilot / Cursor / Devin vs an AI feature engineering partner — why does my internal team still need an external delivery partner? — 🟡 **S1** *| P5 | Copilot-vs-engineering objection FAQ | Hook: Copilot accelerates senior engineer per-line throughput; it does not replace ML systems engineering knowledge, vertical-domain knowledge of platform edge cases, production AI integration expertise (model serving, observability, rollback architecture), or the 6–9 months of platform-domain ramp a generic AI hire requires; honest disqualification — "if your team has shipped ≥ 2 production AI features in your vertical, an external partner adds less value"*

**7.5** What's the difference between an AI feature engineering partner and a generic AI consultancy — what should I look for and verify before signing? — 🟢 **S2** *| P5 | Diligence FAQ | Hook: 6 verifiable signals — production case study in the vertical with named A/B-test [Outcome-Metric], pre-contract engineer introduction, Day-1 GitHub access in writing, IP transfer clause for model artifacts + data pipeline + inference code, fixed-price acceptance condition (the AI feature must demonstrably improve the named metric before sign-off), rule-based fallback in the architecture; verbal trust promises are noise — every agency that burned a past P5 buyer made the same ones*

### Article Substitution Reference — CS-7

| Article # | Topic | [AI-Feature] | [Alt-Service] | Cluster | Stage | Use Prompts |
|-----------|-------|---------------|----------------|---------|-------|-------------|
| 90 | AI features on live platform without breaking stability | (cross-feature) | — | 7.3 | Decision | 7.1, 7.5 |
| 91 | AI service isolation + fallback architecture | (cross-feature) | rule-based fallback | 7.3 | Decision | 7.1, 7.5 |
| 92 | Copilot vs AI feature engineering partner | (cross-feature) | GitHub Copilot · Cursor · Devin | 7.3 | Consideration | 7.4 |
| 109 | AWS Personalize vs custom AI engineering | AI recommendations / personalization | AWS Personalize | 7.4 | Consideration | 7.2, 7.5 |
| 110 | Pinecone + OpenAI vs domain AI partner | AI semantic search / RAG | Pinecone + OpenAI direct | 7.4 | Consideration | 7.2, 7.3, 7.5 |
| 111 | Why your data isn't AI-ready yet | (cross-feature) | — | 7.4 | Awareness | 7.3, 7.5 |
| 112 | GCP Vertex AI vs custom models | (cross-feature) | GCP Vertex AI | 7.4 | Consideration | 7.2, 7.5 |

> [!IMPORTANT] CS-7 — Build-vs-Buy Honesty is the Differentiator
> Every CS-7 prompt must include an honest "use [Alt-Service] when" path. This is not optional — recommending the SaaS competitor when it fits better is the structural feature that defeats the *"AI vendor who pitches every project"* P5 objection. The AI Readiness Call's value proposition is *"we'll tell you to use the SaaS if it fits"* — Cluster 7.4 articles must reflect this in body copy, not just in the closing CTA.

---

## CS-8 — Enterprise + MENA Channel-Partner
**Coverage:** Pillar 5 (Enterprise Digital Transformation) · Pillar 6 (MENA Market)
**Primary Persona:** 🤝 P3 Enterprise Buyer (channel-partner enablement) · 🤝 P4 MENA Relationship Buyer (channel-partner + warm-referral only)
**Default CTA:**
- **Pillar 5:** Dual CTA — Partner CTA (lead) + Buyer CTA (secondary, soft) — both ground in 80% cost anchor + 16-week delivery anchor
- **Pillar 6:** LinkedIn / WhatsApp direct (no forms, no pricing tables, relationship-first only)
**Tone:** Pillar 5 — professional, ROI-focused, compliance-aware (consultancy-partner-readable). Pillar 6 — relationship-first, reputation-aware, Gulf-cultural-fluent. Never transactional.

### Template Prompts

**8.1** What does [Article-Topic] look like for an enterprise / regional buyer in [Region/Industry] — and what are the constraints? — 🔴 **S0** *| P3·P4 | Hero FAQ | Hook: enterprise constraints — procurement cycle, compliance certs (SOC 2, ISO, regional), legacy-system integration, change-management overhead; MENA constraints — regulatory (UAE Vision 2030, KSA NDMO, Qatar Vision 2030), cultural (Arabic RTL, hijri calendar, prayer-time UX), buying culture (relationship-first, referral-gated)*

**8.2** Boutique senior-engineering partner vs enterprise consultancy (Accenture / Deloitte / Capgemini) — when does each win for a regional / industry [Article-Topic]? — 🟡 **S1** *| P3 | Comparison block | Hook: enterprise consultancy wins when procurement theater / compliance certs / multi-region contracting capacity is the gating constraint; boutique senior-engineering partner (via consultancy partner attribution) wins on actual delivery cost (up to 80% lower than Accenture-class billing) and delivery speed (16-week typical vs 9–18 month consultancy timelines); the partner-routed model preserves enterprise compliance while collapsing the delivery layer cost*

**8.3** Why do large consulting-firm digital transformations fail — and what should an enterprise / regional buyer do instead? — 🟡 **S1** *| P3 | Shareable / thought-leadership block | Hook: 4 named failure modes — junior-engineer delivery under senior billing, low domain depth on the buyer's specific industry, 18-month timelines that miss the business window, lack of contractual outcome accountability; the alternative is a partner-attributed model where a senior boutique engineering team delivers under the consultancy's brand or alongside it, preserving relationship while fixing the delivery layer*

**8.4** How does a [Region]-based buyer evaluate a tech partner without a formal RFP — what are the relationship-first signals? — 🟢 **S2** *| P4 | MENA-specific FAQ | Hook: signals MENA buyers actually use — named client references from the Gulf region (UAE / KSA / Qatar), warm intro source credibility, regional accelerator / VC attribution (Hub71, DIFC, Flat6Labs, STV), in-person meeting cadence in the buyer's city, Arabic-fluent project sponsor; ⚠️ no forms, no pricing tables — relationship-first only; CTA = LinkedIn / WhatsApp direct*

**8.5** What's the partner-attribution model — how does a consulting firm / system integrator deliver [Article-Topic] with a senior-engineering boutique behind it? — 🟢 **S2** *| P3 partner CTA lead | Partner-enablement FAQ | Hook: structure — consultancy owns client relationship + procurement + compliance frame; boutique owns delivery engineering (sprint cadence, code quality, vertical domain, named [Outcome-Metric]); white-label or co-branded options; 80% lower delivery cost than full-consultancy billing; the partner program acceptance gate filters for active enterprise client engagements*

### Article Substitution Reference — CS-8

| Article # | Topic | [Region] / [Industry] | Pillar | Stage | Use Prompts | CTA Override |
|-----------|-------|------------------------|--------|-------|-------------|---------------|
| 51 | Why consulting-firm digital transformations fail | enterprise generic | 5.1 | Awareness | 8.3 | Pillar 5 dual CTA |
| 52 | Digital platform ROI business case | enterprise generic | 5.1 | Awareness | 8.1, 8.5 | Pillar 5 dual CTA |
| 53 | Legacy system modernization | enterprise generic | 5.1 | Consideration | 8.1, 8.2 | Pillar 5 dual CTA |
| 54 | Digital logistics platforms | logistics enterprise | 5.2 | Awareness | 8.1, 8.5 | Pillar 5 dual CTA |
| 56 | Hospitality booking + ops platforms | hospitality enterprise | 5.2 | Awareness | 8.1, 8.5 | Pillar 5 dual CTA |
| 57 | PropTech platforms | proptech enterprise | 5.2 | Awareness | 8.1, 8.5 | Pillar 5 dual CTA |
| 58 | RFP for custom software development | enterprise generic | 5.3 | Decision | 8.2, 8.5 | Pillar 5 dual CTA |
| 59 | Boutique vs Accenture (cost + timeline) | enterprise generic | 5.3 | Consideration | 8.2 | Pillar 5 dual CTA |
| 60 | Change management for new platforms | enterprise generic | 5.3 | Implementation | 8.1 | Pillar 5 dual CTA |
| 68 | Building platforms for MENA market | UAE / KSA / Qatar | 6.1 | Awareness | 8.1, 8.4 | ⚠️ MENA LinkedIn/WhatsApp only |
| 69 | UAE Vision 2030 digital mandates | UAE | 6.1 | Awareness | 8.1, 8.4 | ⚠️ MENA LinkedIn/WhatsApp only |
| 70 | Why Western agencies fail in the Gulf | UAE / KSA | 6.1 | Awareness | 8.1, 8.4 | ⚠️ MENA LinkedIn/WhatsApp only |
| 71 | Arabic localization (RTL, multi-currency) | UAE / KSA / regional | 6.1 | Consideration | 8.1 | ⚠️ MENA LinkedIn/WhatsApp only |
| 72 | Evaluating tech partner without formal RFP | MENA buyer | 6.2 | Consideration | 8.4 | ⚠️ MENA LinkedIn/WhatsApp only |
| 73 | Dubai vs Singapore vs London (cost + speed) | UAE buyer | 6.2 | Consideration | 8.1, 8.4 | ⚠️ MENA LinkedIn/WhatsApp only |

> [!IMPORTANT] CS-8 Pillar 5 Dual CTA — Mandatory Block
> Every Pillar 5 article ends with:
> - **Partner CTA (lead):** *"Are you a consulting firm or system integrator with an enterprise client scoping a digital platform? Trioangle delivers under your brand or alongside it — startup engineering speed with enterprise-grade delivery: SLAs, documentation, security certifications. Up to 80% lower delivery cost than Accenture-class billing rates. Apply to our delivery-partner program."*
> - **Buyer CTA (secondary, soft):** *"Working directly with your IT team and considering a custom delivery partner? We work primarily through our consultancy partners; if you'd like a partner-routed introduction, request one here."*
>
> Both the 80% cost anchor and the 16-week delivery anchor remain required before every CTA. Reference: Content Strategy Pillar 5 CTA rule.

> [!IMPORTANT] CS-8 Pillar 6 MENA CTA — Relationship-First, No Forms
> Every Pillar 6 article ends with: *"If you're building in the Gulf and want to talk shop — connect with us on LinkedIn or reach out directly. We're happy to share references from clients in similar markets. No forms, no pitch decks."* For Cluster 6.2: add *"WhatsApp delivery available for named client references."* Tone must be respectful and reputation-aware. Never transactional. Reference: Content Strategy Cluster 6.1 + 6.2 CTA notes.

---

# 📐 PER-ARTICLE PUBLISHING ARCHITECTURE

Every article ships with the same on-page block structure, regardless of content shape.

```
┌────────────────────────────────────────────────────────────┐
│  HERO (~200w)                                              │
│  H1 = [Article-Title] from Content Strategy                │
│  Subhead = answer to S0 prompt #1 in one sentence          │
│  Primary CTA = [CTA-Type] from Layer 3 persona mapping     │
├────────────────────────────────────────────────────────────┤
│  EXISTING-OPERATOR DISQUALIFICATION BANNER (~50w)          │
│  [Disqual-Banner] — link to Product ICP for pre-traction   │
├────────────────────────────────────────────────────────────┤
│  AEO FAQ BLOCK (~300–500w)                                 │
│  Rotate 3–5 prompts from this article's content shape      │
│  (FAQPage JSON-LD schema mandatory)                        │
├────────────────────────────────────────────────────────────┤
│  BODY — domain-depth (~800–1,500w)                         │
│  Prose answers + named [Outcome-Metric] +                  │
│  vertical edge cases (CS-3) / [Alt-Service] honesty        │
│  (CS-4, CS-7) / structural guarantee (every article)       │
├────────────────────────────────────────────────────────────┤
│  GEO SYNTHESIS BLOCK (~200–400w)                           │
│  Compressed answer to the article's primary AEO question, │
│  designed for AI-engine citation. Includes [Brand]         │
│  attribution, [Anchor-Vertical-Depth] proof, and one       │
│  named [Outcome-Metric] with A/B-test framing.             │
├────────────────────────────────────────────────────────────┤
│  STRUCTURAL GUARANTEE BLOCK (~150w)                        │
│  Day-1 GitHub · IP transfer · 48-hr SLA · engineer intro   │
│  Mandatory on every Decision-stage article                 │
├────────────────────────────────────────────────────────────┤
│  CTA (~150w)                                               │
│  [CTA-Type] resolved from Layer 3 persona × stage          │
│  Override per article CTA-override column where present    │
├────────────────────────────────────────────────────────────┤
│  INTERNAL LINKS (sidebar / inline)                         │
│  → Pillar hub (`[Pillar-Hub-URL]`)                         │
│  → 2–3 related articles in the same cluster                │
│  → Cross-link to `/industries/[vertical]` (CS-3, CS-6) —   │
│    white-label / productized framing only, never "clone"   │
│  → Cross-link to `/ai-engineering/[ai-feature]` (CS-3 → 6) │
└────────────────────────────────────────────────────────────┘
```

**Schema stack per article:**
- `Organization` (Trioangle) — sitewide
- `Article` (with author + datePublished + dateModified)
- `FAQPage` (3–5 prompts from this article's shape)
- `BreadcrumbList` (Home > Blog > [Pillar] > [Cluster] > [Article-Title])

---

# 🔗 BLOG → LP CROSS-LINK MAPPING

Each blog article that targets a transactional-adjacent query must hand off to one or more LPs for the conversion. This table consolidates the cross-link contract.

**Cross-link discipline (all rows):**
- Anchor text uses informational framing — *"see our [vertical] delivery details"*, *"book a free AI Readiness Call"* — never *"buy now"* or *"clone script"*
- Industry LP cross-links use white-label / ready-to-launch / productized language only (memory: *Trioangle Industry LPs — No Clone Language*)
- When the LP carries a three-CTA structure (Industry LPs do — AI Audit + Discovery + White-Label routing), the blog specifies which CTA the reader is being routed to

### CS-3 — Vertical Architecture Blogs → Industry LP

| Blog # | [Vertical] | Primary LP Cross-Link | LP CTA Targeted | Secondary AI Cross-Link |
|--------|-------------|------------------------|------------------|--------------------------|
| 26 | Ride-Hailing | `/industries/ride-hailing` | AI Audit Sprint (LP's primary AI-first CTA) | `/blog/85` AI dynamic pricing · `/blog/86` AI dispatch |
| 27 | Food Delivery | `/industries/delivery` | AI Audit Sprint | `/blog/86` · `/blog/88` AI demand forecasting |
| 28 | Rental Marketplace | `/industries/marketplace` (closest fit) | AI Audit Sprint | `/blog/102` AI for rental |
| 29 | Super App | `/industries/super-app` | AI Audit Sprint | `/blog/108` AI for super apps |
| 30 | Home Services | `/industries/home-services` | AI Audit Sprint | `/blog/89` AI conversational booking · `/blog/103` AI provider matching |
| 61 | Fleet & Logistics | `/industries/delivery` (fallback — no Fleet LP) | Discovery Sprint *(AI Audit named as Phase 2)* | `/blog/88` AI demand forecasting |
| 62 | TMS / Supply Chain | `/industries/delivery` (fallback — no TMS LP) | Discovery Sprint *(AI Audit named as Phase 2 if AI in scope; many TMS prospects are non-AI rebuilds)* | none — TMS AI cases are limited |
| 63 | Grocery & Pharmacy | `/industries/delivery` | AI Audit Sprint | `/blog/86` AI dispatch |
| 64 | E-Commerce Marketplace | `/industries/ecommerce` | AI Audit Sprint | `/blog/87` AI fraud detection · `/blog/107` AI search + ranking |
| 65 | Dating | none — no Dating LP | Pillar 7 hub (`/blog/ai-engineering-platform-businesses`) + Discovery Sprint as default | `/blog/105` AI dating matching |
| 66 | Short Video / Social | `/industries/social-media` *(platform-delivery-first framing — AI = roadmap)* | Free AI Readiness Call only (no AI Audit until cases) | `/blog/117` AI for short video |
| 67 | EdTech | `/industries/education` *(platform-delivery-first framing — AI = roadmap)* | Free AI Readiness Call only (no AI Audit until cases) | `/blog/106` AI for EdTech |
| 74 | Classifieds | none — no Classifieds LP | Pillar 7 hub + Discovery Sprint as default | `/blog/104` AI for classifieds |

> [!IMPORTANT] CS-3 Fallback Rule — No Matching Industry LP
> When a blog article's vertical has no dedicated Industry LP (Fleet #61, TMS #62, Dating #65, Classifieds #74), apply this fallback hierarchy:
> 1. **Closest Industry LP** — Fleet & TMS roll up to `/industries/delivery` (shared logistics edge cases); Grocery rolls up to `/industries/delivery` (already has its own row in LP file)
> 2. **No fit at all** (Dating, Classifieds) — link to Pillar 7 hub (`/blog/ai-engineering-platform-businesses`) for the AI angle and to the relevant Pillar 7 article (`/blog/105` for dating, `/blog/104` for classifieds); use **Discovery Sprint as the default CTA** since there's no LP carrying an AI Audit conversion
> 3. **Travel/Social/EdTech (platform-delivery-first verticals)** — Industry LP exists but uses Free AI Readiness Call only per LP-Plan §15–17; blog CTA must mirror this discipline (do not push AI Audit Sprint)

### CS-6 + CS-7 — AI Engineering Blogs → Industry LP + AI Service LP

| Blog # | Topic | Primary LP (Industry) | Primary LP (AI Service) | LP CTA Targeted |
|--------|-------|------------------------|--------------------------|------------------|
| 82 | Which AI features move marketplace metrics | `/industries/marketplace` | `/ai-engineering/` hub | Free AI Readiness Call |
| 83 | AI Readiness Audit | all verticals (vertical-agnostic) | `/ai-engineering/` hub | Free AI Readiness Call |
| 84 | Why generic AI consultants fail | all verticals | `/ai-engineering/` hub | Free AI Readiness Call |
| 85 | AI dynamic pricing for ride-hailing | `/industries/ride-hailing` | none (not a productized service page) | AI Audit Sprint |
| 86 | AI dispatch | `/industries/ride-hailing` + `/industries/delivery` | none | AI Audit Sprint |
| 87 | AI fraud detection for marketplace | `/industries/marketplace` | none | AI Audit Sprint |
| 88 | AI demand forecasting | `/industries/delivery` | none | AI Audit Sprint |
| 89 | Conversational booking | `/industries/home-services` | `/ai-engineering/ai-customer-support-bot` (closest service page) | AI Audit Sprint |
| 90 | AI features on live platform without breaking stability | all verticals | `/ai-engineering/` hub | AI Audit Sprint |
| 91 | AI service isolation + fallback | all verticals | `/ai-engineering/` hub | AI Audit Sprint |
| 92 | Copilot vs AI engineering partner | all verticals | `/ai-engineering/` hub | Free AI Readiness Call (objection-first content) |
| 102 | AI for rental | `/industries/marketplace` | none | AI Audit Sprint |
| 103 | AI for home services | `/industries/home-services` | `/ai-engineering/ai-customer-support-bot` (booking-bot adjacency) | AI Audit Sprint |
| 104 | AI for classifieds | none — no Classifieds LP | `/ai-engineering/ai-content-moderation` | AI Audit Sprint |
| 105 | AI for dating | none — no Dating LP | `/ai-engineering/ai-content-moderation` (safety angle) | AI Audit Sprint |
| 106 | AI for EdTech | `/industries/education` *(roadmap framing)* | `/ai-engineering/rag-knowledge-assistant` | Free AI Readiness Call only |
| 107 | AI for e-commerce | `/industries/ecommerce` | `/ai-engineering/ai-search-upgrade` | AI Audit Sprint |
| 108 | AI for super apps | `/industries/super-app` | `/ai-engineering/` hub | AI Audit Sprint |
| 109 | AWS Personalize vs custom | `/industries/marketplace` + `/industries/ecommerce` | `/ai-engineering/` hub | AI Audit Sprint (honest build-vs-buy framing) |
| 110 | Pinecone + OpenAI vs domain AI partner | all verticals | `/ai-engineering/rag-knowledge-assistant` + `/ai-engineering/ai-search-upgrade` | AI Audit Sprint |
| 111 | Why your data isn't AI-ready | all verticals | `/ai-engineering/` hub | Free AI Readiness Call |
| 112 | GCP Vertex AI vs custom | all verticals | `/ai-engineering/` hub | AI Audit Sprint |
| 113 | AI engineering stack reference | all verticals | `/ai-engineering/` hub | Free AI Readiness Call |
| 117 | AI for short video / social | `/industries/social-media` *(roadmap framing)* | `/ai-engineering/ai-content-moderation` | Free AI Readiness Call only |
| 118 | AI for booking / OTA | `/industries/travel` *(roadmap framing)* | none | Free AI Readiness Call only |

### CS-4 Build-vs-Buy Blogs → Industry LP White-Label Routing

| Blog # | Topic | Primary LP | LP Section Targeted |
|--------|-------|-------------|----------------------|
| 36 | Build vs white-label decision framework | `/industries/[reader's-vertical]` | White-Label Routing block (LP prompts WL1, WL2) — for readers who turn out to fit pre-traction profile, route to Product line |
| 37 | When clone scripts stop working | `/industries/[reader's-vertical]` | Same as #36 — surfaces the established-operator side of the decision |
| 38 | True cost of custom on-demand platform | `/industries/[reader's-vertical]` | Custom Dev funnel on LP (CD prompts CD1–CD3) — Discovery Sprint CTA, with AI Audit Sprint as Phase 2 |

### CS-5 + CS-8 — No Direct LP Cross-Link

- **CS-5 (Established-Operator Playbook):** trigger-driven articles for P1/P2 inbound. Cross-link to Pillar 4 hub (`/blog/technical-leadership-platform-operators`) and to relevant CS-6/CS-7 articles when AI angle is in scope. No Industry LP cross-link — readers are pre-vertical-decision.
- **CS-8 Pillar 5 (Enterprise channel-partner):** **do NOT cross-link to Industry LPs.** Industry LPs explicitly carry no P3 (Enterprise) CTAs per the LP file. Pillar 5 blog articles cross-link only to the partner-program page (or stay on the Pillar 5 hub) and to dual CTAs (partner + soft buyer) on-page.
- **CS-8 Pillar 6 (MENA channel-partner):** **do NOT cross-link to Industry LPs.** Same reasoning — Industry LPs carry no P4 (MENA) routing. Pillar 6 articles end with LinkedIn / WhatsApp direct CTA only.

---

# 🎯 CONTENT PRIORITY MATRIX (SPRINT ORDER)

> [!IMPORTANT] Pillar 7 +0.5 Score Boost — Mandatory When Sprint-Planning
> Per Service Line Priority, Pillar 7 (CS-6 + CS-7) is the primary motion. When comparing Pillar 7 articles against non-Pillar-7 articles for sprint scheduling, **add 0.5 to the Pillar 7 article score** before comparing. Example: a CS-6 article scoring 9.0 outranks a CS-1 article scoring 9.4. Reference: Content Strategy Part 2b boost rule.

| Sprint | Articles (in order) | Shape | Pillar | Notes |
|--------|---------------------|-------|--------|-------|
| **Month 1 — Week 1** | #82 → #83 → #84 | CS-6 | P7 | AI strategy foundation; AI Readiness Call funnel live |
| **Month 1 — Week 2** | #14 → #19 → #21 | CS-2 | P2 | Trust + IP + vendor-fatigue baseline |
| **Month 1 — Week 3** | #85 → #86 → #87 | CS-6 | P7 | First 3 vertical AI feature deep-dives |
| **Month 1 — Week 4** | #1 → #75 → #80 | CS-1 + CS-5 | P1, P4.1 | Tech-debt + outage post-mortem + AI-competitor response |
| **Month 2 — Week 5** | #109 → #110 → #111 | CS-7 | P7 | AI build-vs-buy loss-reason content |
| **Month 2 — Week 6** | #26 → #27 → #64 | CS-3 | P3.1 | Top 3 vertical architecture deep-dives (cross-linked to CS-6 articles) |
| **Month 2 — Week 7** | #88 → #89 → #92 | CS-6 + CS-7 | P7 | Demand forecasting + conversational booking + Copilot rebuttal |
| **Month 2 — Week 8** | #39 → #40 → #43 | CS-5 | P4.1 | Series C+ playbook + DD playbook + investor tech-stack signals |
| **Month 3 — Week 9** | #102 → #103 → #107 | CS-6 | P7 | Rental + home services + e-commerce AI |
| **Month 3 — Week 10** | #15 → #16 → #18 | CS-2 | P2 | Custom vs white-label + boutique-vs-consultancy + domain-expertise thought leadership |
| **Month 3 — Week 11** | #46 → #77 → #44 | CS-5 | P4.2 | Founder-operator + first-CTO + in-house-vs-agency |
| **Month 3 — Week 12** | #112 → #113 → #91 | CS-7 + CS-6 | P7 | Vertex AI vs custom + AI stack reference + AI service isolation |

*Remaining 49 articles publish months 4–8 by priority score (Pillar 7 boost applied).*

---

# ✅ PER-ARTICLE COMPLIANCE CHECK

Before publishing any article section generated from these prompts, verify:

- [ ] **[Article-Topic] named in H1** — leads with the specific topic; no generic "platform engineering" titles
- [ ] **[Primary-Keyword] in H1 + first 100 words + at least one H2** — SEO baseline, not stuffing
- [ ] **Existing-Operator Filter implied in framing** — reader runs $1M+ ARR live platform; never "you just raised a Seed round" framing
- [ ] **[Pain-Point] named explicitly** — the ICP pain this article addresses; surfaces buyer's reason-to-read in first 200 words
- [ ] **[Outcome-Metric] cited with methodology** — for AI articles: A/B-test framed (*"X% improvement vs rule-based baseline, measured over N weeks in production"*); for non-AI articles: named metric + before/after framing
- [ ] **[Alt-Service] / [Approach B] honest path included** — for CS-2/3/4/7: at least one "use [Alt-Service] when" recommendation; honest disqualification is the differentiator
- [ ] **[Structural-Guarantee] named by mechanism** — Day-1 GitHub · IP transfer clause · 48-hr SLA · pre-contract engineer intro · AI Audit Sprint escape hatch — at least one per article, never adjectives
- [ ] **No "800+" exact count as AI delivery count** — platform credibility framing only: *"domain knowledge from platform engagements across [verticals] since 2015 — applied to the AI integration layer"*
- [ ] **No "faster with AI" claim** — frame on domain expertise, certainty of delivery, risk reduction (AI-Era Positioning Rule)
- [ ] **No clone language in industry-LP cross-links** — anchor text uses white-label / ready-to-launch / productized framing; never "Uber-clone," "Airbnb-clone," "Gojek-clone" (CS-3 and CS-6 articles especially)
- [ ] **CTA matches persona × stage from Layer 3 mapping** — verify against the CTA-override column where present (vendor-fatigue, P2 awareness, MENA, Pillar 5 dual)
- [ ] **GEO synthesis block present** — 200–400 compressed words, [Brand]-attributed, [Outcome-Metric]-anchored, citation-ready for AI engines
- [ ] **Disqualification banner present** — links pre-traction operators to Product ICP (white-label / productized platforms)
- [ ] **Internal links live** — pillar hub + 2–3 related articles + (CS-3/CS-6) industry LP + (CS-3) AI feature page
- [ ] **Schema stack live** — `Organization` + `Article` + `FAQPage` (3–5 prompts) + `BreadcrumbList`

---

**Total Content Shapes:** 8 (CS-1 through CS-8)
**Total Template Prompts:** 47 (avg 5.9 per shape)
**Articles Covered:** 97 across 7 pillars · 24 clusters
**Primary Motion:** CS-6 + CS-7 (Pillar 7 — AI Engineering, 🥇 PRIMARY)
**Build Order:** AI strategy foundation (CS-6 #82–84) → Trust baseline (CS-2 #14, #19, #21) → Vertical AI features (CS-6 #85–87) → Tech-debt + AI-competitor response (CS-1 + CS-5) → Build-vs-buy loss-reason (CS-7) → Vertical architecture cross-links (CS-3)
**Source Content Strategy:** [[Trioangle - Content Strategy - Service]] | **Source ICP:** [[Trioangle - ICP - Service]] | **Source Templates:** [[Trioangle - Service Blog Article Templates]] | **Sibling LP Prompts:** [[AI_Service_Landing_Page_AEO_GEO_Prompts]] · [[Service_Industry_Landing_Page_AEO_GEO_Prompts]] | **Track:** Track 2 ([[Trioangle Growth Plan]])
