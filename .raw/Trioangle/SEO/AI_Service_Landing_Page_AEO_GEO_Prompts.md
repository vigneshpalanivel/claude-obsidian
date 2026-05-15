# AEO + GEO Prompts — AI Service Feature Pages (`/ai/` cluster)

**Source:** `Trioangle Landing Page Plan.md` · `Trioangle - ICP - Service.md` · `Trioangle - Marketing Plan - Service.md` | **Generated:** May 2026

| Field | Value |
|-------|-------|
| **URL Pattern** | `trioangle.com/ai/[service-slug]` |
| **Hub Page** | `trioangle.com/ai/` — AI Services Hub (Priority 9 in Landing Page Plan) |
| **Service Pages** | 7 pages — one 13-prompt template, substitute per-service variables |
| **Total Prompt Entries** | 23 (13 service template + 10 hub-specific) |
| **Build Order** | P5 RAG → P6 Support Bot → P7 AI Agents → P9 Hub → P10 WhatsApp → P11 Moderation → P12 Search → P13 Voice |
| **Service Page CTA** | Fixed-price quote (all service pages) |
| **Hub Page CTA** | Free AI Readiness Call → AI Audit Sprint |
| **Track** | Track 2 — AI-First Service Engine ([[Trioangle Growth Plan]]) |

> [!NOTE] How to Use
> Substitute the per-service variables from the table below into the 13 template prompts. The result is a complete AEO/GEO prompt set for that service page. Hub-specific prompts (H1–H10) apply to `trioangle.com/ai/` only.
>
> **Service pages** (`/ai/[slug]`) target buyers who already know which AI service they need. **Hub page** (`/ai/`) targets buyers who know they need AI but haven't selected a specific service. Copy, keywords, and CTAs differ accordingly.

---

## 🛡️ POSITIONING RULES (Apply to Every Prompt Below)

> [!IMPORTANT] Search-Side Language — Service-Specific
> On service pages, buyers are already searching for the specific service: *"RAG implementation service"*, *"AI agent development"*, *"voice AI for booking platforms"*. Prompts must use the service's own technical vocabulary, not generic "AI engineering" language. Secondary keywords from the Landing Page Plan keyword map are the search surface; prompts must hit them.

> [!IMPORTANT] Custom vs SaaS Honesty Rule
> Every comparison prompt must include an honest "use [Alt-Service] when" path. Recommending a competitor SaaS when it fits better (e.g., "if Intercom Fin handles your support ticket volume, use it") is a structural differentiator — not a loss. The scoping call is where this recommendation is made explicitly, before any build commitment.

> [!IMPORTANT] Delivery Count — Pre-Publish Gate Active
> Do not use "800+" as an exact count in any external-facing content until the internal audit is confirmed. Use: *"built by the team that's shipped 800+ platforms in your vertical since 2015"* for platform credibility. Do not conflate platform deliveries with AI feature deliveries — AI service delivery counts are tracked separately.

> [!IMPORTANT] Trust — Structural Guarantees Only
> Day-1 GitHub, IP transfer clause, 48-hour comm SLA with 5% credit, pre-contract engineer introduction. Never "we pride ourselves on transparent communication." Every service page must name at least one contractual mechanism.

> [!IMPORTANT] No Retainer Language
> Every service page is fixed-price, output-based. No monthly retainer, no AI subscription. The pricing block must reflect this on every page.

> [!IMPORTANT] Established Operators Only
> Service pages target $1M+ ARR platform operators with 12+ months production history. Disqualification banner on every page routes pre-traction operators to the Product ICP (clone scripts).

---

## 🏷️ PRIORITY MARKERS

- 🔴 **P0** — Ship-first. Definition + voice anchors + cost/timeline (5 prompts per service page)
- 🟡 **P1** — Week 1. Comparison + tech-depth + evaluation (5 prompts per service page)
- 🟢 **P2** — Week 2. Due-diligence + ROI + compatibility (3 prompts per service page)

---

## 🔤 VARIABLE SUBSTITUTION TABLE

*Substitute these values into every template prompt for each service page.*

### Core Variables

| Variable | Description |
|----------|-------------|
| `[Service]` | Service name as buyers search it (e.g., "RAG knowledge assistant") |
| `[Service-Slug]` | URL slug (e.g., `rag-knowledge-assistant`) |
| `[Alt-Service]` | Off-the-shelf alternative buyers compare against |
| `[Key-Tech]` | Core technology stack for this service (disclosed at scoping) |
| `[Platform-Pain]` | The specific failure mode this service solves |
| `[Outcome-Signal]` | The measurable metric this service moves |

---

### 7-Service Substitution Reference

#### 1. RAG Knowledge Assistant · `/ai/rag-knowledge-assistant` · Priority 5

| Variable | Value |
|----------|-------|
| `[Service]` | RAG knowledge assistant |
| `[Service-Slug]` | `rag-knowledge-assistant` |
| `[Alt-Service]` | Intercom Fin · Zendesk AI · off-the-shelf chatbot with generic LLM |
| `[Key-Tech]` | LlamaIndex · pgvector · BM25 hybrid search · reranking · embedding pipeline |
| `[Platform-Pain]` | generic chatbot hallucinating answers outside platform-specific knowledge; confidently wrong answers eroding user trust |
| `[Outcome-Signal]` | ticket deflection rate · answer accuracy on platform-specific queries · hallucination rate |

#### 2. AI Customer Support Bot · `/ai/ai-customer-support-bot` · Priority 6

| Variable | Value |
|----------|-------|
| `[Service]` | AI customer support bot |
| `[Service-Slug]` | `ai-customer-support-bot` |
| `[Alt-Service]` | Intercom Fin · Zendesk AI · Freshdesk Freddy |
| `[Key-Tech]` | RAG pipeline · live handoff logic · multilingual NLP · ticket routing and escalation |
| `[Platform-Pain]` | support ticket volume outpacing human team at scale; inconsistent answers across agents; slow first-response time |
| `[Outcome-Signal]` | ticket deflection rate · first-response time · CSAT score |

#### 3. AI Agents & Workflow Automation · `/ai/ai-agents-automation` · Priority 7

| Variable | Value |
|----------|-------|
| `[Service]` | AI agents and workflow automation |
| `[Service-Slug]` | `ai-agents-automation` |
| `[Alt-Service]` | Zapier · Make · no-code automation tools |
| `[Key-Tech]` | LangGraph · ReAct agents · MCP · tool use · human-in-the-loop checkpoints |
| `[Platform-Pain]` | multi-step operational workflows (dispatch, booking, reconciliation) that require judgment beyond simple rule-based routing |
| `[Outcome-Signal]` | operational steps automated without human · decision accuracy · human intervention rate |

#### 4. WhatsApp AI Automation · `/ai/whatsapp-ai-automation` · Priority 10

| Variable | Value |
|----------|-------|
| `[Service]` | WhatsApp AI automation |
| `[Service-Slug]` | `whatsapp-ai-automation` |
| `[Alt-Service]` | Twilio basic bot · manual WhatsApp ops team · generic WhatsApp Business API integration |
| `[Key-Tech]` | WhatsApp Business API · WhatsApp Flows · multi-language NLP · session management |
| `[Platform-Pain]` | manual ops team handling bookings, order updates, and support over WhatsApp — not scalable past a certain volume |
| `[Outcome-Signal]` | messages handled without human agent · booking confirmation rate · average response time |

#### 5. AI Content Moderation · `/ai/ai-content-moderation` · Priority 11

| Variable | Value |
|----------|-------|
| `[Service]` | AI content moderation |
| `[Service-Slug]` | `ai-content-moderation` |
| `[Alt-Service]` | Amazon Rekognition · Google Vision AI · Perspective API |
| `[Key-Tech]` | image moderation classifier · text toxicity detection · domain-specific false positive tuning · human review escalation |
| `[Platform-Pain]` | false positives removing valid listings / content and killing GMV; human moderation team not scaling with platform UGC growth |
| `[Outcome-Signal]` | false positive rate · recall (miss rate on actual violations) · moderation throughput |

#### 6. AI Search Upgrade · `/ai/ai-search-upgrade` · Priority 12

| Variable | Value |
|----------|-------|
| `[Service]` | AI semantic search |
| `[Service-Slug]` | `ai-search-upgrade` |
| `[Alt-Service]` | Algolia · Elasticsearch keyword search · Typesense |
| `[Key-Tech]` | pgvector · BM25 hybrid search · embedding pipeline · reranking · query intent understanding |
| `[Platform-Pain]` | keyword search failing on intent-based queries; high zero-results rate; low search-to-conversion rate |
| `[Outcome-Signal]` | search conversion rate · zero-results rate · click-through rate on top results |

#### 7. Voice AI Development · `/ai/voice-ai-development` · Priority 13

| Variable | Value |
|----------|-------|
| `[Service]` | voice AI |
| `[Service-Slug]` | `voice-ai-development` |
| `[Alt-Service]` | legacy IVR systems · Twilio basic voice flow · Dialogflow |
| `[Key-Tech]` | Vapi · Retell AI · real-time voice pipeline · tool use · human fallback routing |
| `[Platform-Pain]` | phone support overload, IVR dead-ends, missed calls, manual booking ops over the phone |
| `[Outcome-Signal]` | calls resolved without human agent · bookings completed via voice · average handle time |

---

# 📄 SERVICE PAGE PROMPTS — Template (1–13)

*Apply to all 7 service pages via variable substitution. URL: `trioangle.com/ai/[Service-Slug]`. AEO snippets: 40–60 words inside `FAQPage` JSON-LD. GEO blocks: 150–500-word compressed sections. Word budget per service page: ~1,500–2,500 words.*

---

## 🔴 P0 — Ship-First (1–5)

*Hero FAQ + voice anchors + cost/timeline. Every service page must have these live on day 1.*

**1.** What is [Service] for an existing platform — and how is it different from using [Alt-Service]? — 🔴 **P0** *| All personas | Hero FAQ | Hook: [Service] is a purpose-built integration into the platform's own data layer and business logic — not an off-the-shelf tool applied generically; [Alt-Service] works when domain fit is adequate; custom [Service] wins when the platform's business logic is specific enough that [Alt-Service] produces [Platform-Pain]; domain knowledge of how the platform works is built into [Service] on day one, not discovered in month three*

**2.** How long does it take to get [Service] live in an existing production platform — from first conversation to working in production? — 🔴 **P0** *| P5·P1 | Hero FAQ | Hook: scoping call (1 hr) → fixed-price quote agreed (1 day) → build starts → [Service] in staging (weeks 3–6, depending on data readiness and scope) → production live with monitoring active; typical 4–8 weeks from signed scope to live [Service]; the platform's existing API layer and data readiness are the primary schedule variables*

**3.** What does [Service] cost — what is included in a fixed-price build and what is not? — 🔴 **P0** *| All personas | FAQ + pricing block | Hook: [Service] build is fixed-price, scoped at the deliverable level; included: data pipeline integration, [Service] core build using [Key-Tech], service-isolated deployment, monitoring setup, and a post-delivery support window; not included: ongoing model retraining beyond the agreed window, infrastructure hosting after handoff; no monthly retainer, no per-hour billing, no SaaS subscription lock-in*

**4.** Does an external team need access to my codebase to build [Service] — and what IP protections exist? — 🔴 **P0** *| P1·P2 (trust) | FAQ | Hook: read-only codebase access during integration (write access only on agreed feature branches); NDA executed before any code review; Day-1 GitHub access (client owns the [Service] repo from commit one); IP transfer clause at delivery — model artifacts, data pipeline, inference code, documentation all transfer at handoff; no client data used for third-party model training*

**5.** Can [Service] be deployed into a live platform without downtime or disruption to active users? — 🔴 **P0** *| P5·P1 | Hero subhead + FAQ | Hook: service-isolation — [Service] runs as a standalone microservice alongside the existing platform; gradual traffic rollout via feature flag; automatic fallback to existing logic when [Service] confidence drops or latency spikes; rollback takes < 1 minute; core platform user flow is never in the [Service] failure path*

---

## 🟡 P1 — Week 1 (6–10)

*Comparison table + tech-depth + evaluation path.*

**6.** Custom [Service] vs [Alt-Service] — when does building custom beat buying off-the-shelf in [Year]? — 🟡 **P1** *| P5 | Comparison block | Hook: [Alt-Service] wins when domain fit is adequate and customization needs are low; custom [Service] wins when the platform's business logic produces [Platform-Pain] with off-the-shelf tools — meaning the model fails on real platform data; the scoping call surfaces this distinction before any build commitment; "use [Alt-Service]" is a valid and common output of that call*

**7.** External [Service] team vs hiring in-house ML engineers: which gets [Service] live faster for an established platform? — 🟡 **P1** *| P1·P5 | Comparison block | Hook: in-house ML = 4–9 month hiring + onboarding + no platform-specific domain knowledge + full-salary ongoing cost; external = scoping (1 hr) → build (4–8 weeks) → live and measured; external wins until [Service]-type build volume exceeds 3–4 projects per year — at that point, in-house makes financial sense for this service category specifically*

**8.** How does [Service] actually integrate into an existing platform end-to-end — from data ingestion to user-facing impact? — 🟡 **P1** *| Tech-depth section (~300w synthesis) | P5·P1 | Hook: platform API / event stream → data ingestion layer → [Service] core build ([Key-Tech]) → service-isolated API layer → staging validation → feature-flag rollout → [Outcome-Signal] tracked against pre-[Service] baseline; the integration point is the platform's existing API boundary — [Service] does not require refactoring the core platform*

**9.** What [Key-Tech] does [Service] rely on — and why does the tech stack choice matter for a platform operator? — 🟡 **P1** *| Tech-depth section (~200w) | P5·P1 | Hook: [Key-Tech] determine [Service]'s performance characteristics on real platform data (latency, accuracy, false positive rate, scale ceiling); the stack is chosen at scoping based on the platform's data volume, latency requirements, and hosting constraints — not on team preference; the full tech stack is disclosed before signing and fully client-owned at delivery*

**10.** How do I evaluate whether an external [Service] team genuinely understands my platform type — before committing $20k+? — 🟡 **P1** *| Due-diligence block | P1·P5 | Hook: ask for a production case study in a platform similar to yours with a named [Outcome-Signal] improvement and methodology disclosed; request a pre-contract engineer introduction (the engineers who will build [Service], not the sales rep); ask how [Platform-Pain] is specifically handled in the [Service] architecture; the scoping call is the lowest-risk evaluation path: 1 hour, free, no commitment*

---

## 🟢 P2 — Week 2 (11–13)

*BoFU diligence + ROI + compatibility.*

**11.** What questions should I ask before signing any [Service] engagement with an external team? — 🟢 **P2** *| BoFU checklist near CTA | P1·P5 | Hook: 7-question checklist — (1) production case study in my platform type with named [Outcome-Signal]? (2) pre-contract engineer introduction? (3) IP transfer clause in writing? (4) Day-1 GitHub access? (5) data handling NDA? (6) fixed-price with defined acceptance condition? (7) rule-based fallback or rollback path if [Service] underperforms? Anchor with Trioangle's pre-filled answers as the benchmark*

**12.** How do I calculate ROI from [Service] — what's a realistic payback timeline for a platform at $1M+ ARR? — 🟢 **P2** *| BoFU near CTA | P1·P2 | Hook: ROI frame = [Outcome-Signal] improvement × business-value conversion × total volume = annual upside; at typical [Service] performance lifts, payback on a $15k–$40k fixed-price [Service] build is 60–120 days for most $1M+ ARR platforms; scoping call produces an ROI estimate specific to the platform's volume before any commitment*

**13.** Can [Service] be added to an existing tech stack (Laravel/PHP, Node.js, Python/Django, Ruby on Rails) without a full platform rewrite? — 🟢 **P2** *| FAQ | All personas | Hook: service-isolation means [Service] runs as a separate service consuming the platform's existing API; any backend stack is compatible as long as an API layer exists; the core codebase is untouched; [Service] adds capability without refactoring what already works in production*

---

# 📄 HUB PAGE PROMPTS — `trioangle.com/ai/` (H1–H10)

*Hub page targets buyers who know they need AI features but haven't selected a specific service. AEO snippets + GEO blocks. Word budget: ~2,000–3,000 words.*

---

## 🔴 Hub P0 — Ship-First (H1–H5)

**H1.** What AI services can be embedded into an existing platform — and how does an established platform operator decide which to build first? — 🔴 **Hub P0** *| Hero FAQ | All personas | Hook: 7 productized AI services for platform operators — RAG knowledge assistant, AI customer support bot, AI agents and workflow automation, WhatsApp AI automation, AI content moderation, AI semantic search, voice AI; selection is based on which has the highest business-metric impact for the platform's specific vertical and data readiness; the AI Readiness Call maps this in 1 hour before any commitment*

**H2.** How long does it take to get the first AI feature live in an existing platform — from first conversation to working in production? — 🔴 **Hub P0** *| Hero FAQ | P5·P1 | Hook: AI Readiness Call (1 hr, free) → fixed-price quote agreed (1–3 days) → build starts → first AI feature in production: 4–10 weeks depending on service type and data readiness; domain knowledge of the platform's vertical is built in on day one — no 3-month learning curve billed to the client*

**H3.** Which AI service delivers the highest business-metric impact for an established platform operator in [Year]? — 🔴 **Hub P0** *| "Where to start" block (~300w) | P5 | Hook: depends on vertical — ride-hailing/delivery: AI dispatch optimization; marketplace/commerce: fraud detection + AI search; home services: conversational booking assistant; social/UGC platforms: AI content moderation; platforms with high support ticket volume across any vertical: AI customer support bot; platforms with heavy WhatsApp ops (MENA, SEA): WhatsApp AI automation; the AI Readiness Call maps this per platform in 1 hour*

**H4.** Is this another AI agency that shows demos and disappears — or does the team have domain knowledge of how my platform type actually works in production? — 🔴 **Hub P0** *| "Why Trioangle" / trust block | P1·P2 (trust) | Hook: structural guarantees in writing, verifiable before signing: Day-1 GitHub access, IP transfer clause, 48-hour comm SLA with 5% contract credit per breach, pre-contract engineer introduction (meet the engineers, not the sales rep); platform domain depth from building 800+ platforms across ride-hailing, logistics, marketplace, home services, and adjacent verticals since 2015 — the AI integration layer runs on knowledge of how these platforms actually work, not general ML theory*

**H5.** What does a fixed-price AI feature build cost — and what is and isn't included? — 🔴 **Hub P0** *| FAQ + pricing block | All personas | Hook: productized AI services are fixed-price, scoped at the deliverable level; typical range $15k–$80k depending on service type and integration complexity; included: scoping, build, service-isolated deployment, monitoring setup, post-delivery support window; not included: ongoing retraining beyond the post-delivery window, infrastructure hosting after handoff; no monthly retainer, no hourly billing, no AI subscription lock-in*

---

## 🟡 Hub P1 — Week 1 (H6–H8)

**H6.** Domain-specific AI feature development vs a generic AI agency: what's the real difference for an established platform operator? — 🟡 **Hub P1** *| Comparison block | P5·P1 | Hook: domain-specific means the engineering team knows the dispatch logic, commission flows, content policy edge cases, and supply-demand dynamics of the platform type before the engagement begins — not learned at the client's expense over months 1–3; a generic AI agency applies general ML patterns to a vertical it discovers on your project; the first 6–8 weeks of a generic agency engagement is billable domain learning*

**H7.** Build vs buy vs SaaS for AI features: how does an established platform operator decide? — 🟡 **Hub P1** *| Comparison block | P5 | Hook: SaaS wins when domain fit is adequate and customization is low; custom AI feature wins when the platform's business logic is specific enough that generic SaaS produces the failure mode the operator is trying to solve; the AI Readiness Call surfaces this decision in 1 hour before any build commitment — "use [SaaS]" is a valid and common output of that call*

**H8.** What structural guarantees should an AI feature engineering partner provide in writing — before any engagement begins? — 🟡 **Hub P1** *| Guarantee block | P1·P2 | Hook: the floor — Day-1 GitHub access (client owns the AI service repo from commit one), IP transfer clause (model artifacts + data pipeline + inference code at delivery), 48-hour comm SLA with 5% contract credit per breach, pre-contract engineer introduction (meet the engineers before signing), fixed-price acceptance condition (the AI feature must demonstrably improve the named metric before sign-off); verbal trust promises are noise — every agency that burned a past buyer made the same ones*

---

## 🟢 Hub P2 — Week 2 (H9–H10)

**H9.** How is the 2026 AI wave changing platform economics — and what is the cost of being the last operator in your market without AI features? — 🟢 **Hub P2** *| "Why Now" block (~400w) | P5·P1 | Hook: platform operators shipping AI features now are compounding a data advantage — every week of AI production data makes the model more accurate; competitors shipping AI dispatch, AI moderation, or AI search today have a training data head start that pricing alone cannot close in 12–18 months; the risk isn't "AI will fail" — it's "competitors will have 18 months of production AI data before you start"*

**H10.** What questions should I ask any AI feature engineering partner before signing — and what should Trioangle's answers be? — 🟢 **Hub P2** *| BoFU checklist near CTA | P1·P5 | Hook: 8-question checklist — (1) production AI case study in my platform vertical with named metric outcome? (2) pre-contract engineer introduction? (3) IP transfer clause confirmed? (4) Day-1 GitHub access? (5) data handling NDA? (6) fixed-price with defined acceptance condition? (7) honest build vs buy vs SaaS verdict as part of scoping? (8) rule-based fallback in the AI service design? Anchor with Trioangle's pre-filled answers as the benchmark*

---

# 📐 PAGE ARCHITECTURE

## Service Pages (`trioangle.com/ai/[Service-Slug]`) — ~1,500–2,500 words each

```
┌────────────────────────────────────────────────────────────┐
│  HERO (~300w)                                              │
│  H1: [Service-Headline from Landing Page Plan]             │
│  Subhead from prompts 1, 2, 5 (one sentence each)         │
│  Primary CTA: "Get a fixed-price [Service] quote"          │
├────────────────────────────────────────────────────────────┤
│  DISQUALIFICATION BANNER (~80w)                            │
│  "$1M+ ARR / 12+ months production — not for pre-launch"   │
├────────────────────────────────────────────────────────────┤
│  AEO FAQ BLOCK (~400w)                                     │
│  Rotate 6–8 prompts: 1,2,3,4,5,6,11,13                    │
│  (FAQPage JSON-LD schema)                                  │
├────────────────────────────────────────────────────────────┤
│  COMPARISON TABLE (~200w)                                  │
│  Prompts 6, 7 → custom vs SaaS vs in-house                │
├────────────────────────────────────────────────────────────┤
│  TECH DEPTH (~400w)                                        │
│  Prompts 8, 9 → integration end-to-end + [Key-Tech] named  │
├────────────────────────────────────────────────────────────┤
│  HOW IT WORKS (~200w)                                      │
│  Prompt 2 → timeline + milestones                          │
├────────────────────────────────────────────────────────────┤
│  STRUCTURAL GUARANTEE BLOCK (~150w)                        │
│  Day-1 GitHub · IP transfer · 48-hr SLA · engineer intro   │
├────────────────────────────────────────────────────────────┤
│  BOFU + CTA (~300w)                                        │
│  Prompts 10, 11, 12 → diligence checklist + ROI block      │
│  CTA: "Get a fixed-price [Service] quote"                  │
└────────────────────────────────────────────────────────────┘
```

**Schema stack per service page:**
- `Organization` (Trioangle) — sitewide
- `Service` (scoped: *"[Service] Development for Platform Operators"*)
- `FAQPage` (6–8 prompts, phrased with [Service] + [Platform-Pain] language)
- `BreadcrumbList` (Home > AI Services > [Service])

---

## Hub Page (`trioangle.com/ai/`) — ~2,000–3,000 words

```
┌────────────────────────────────────────────────────────────┐
│  HERO (~400w)                                              │
│  H1: Productized AI for platform operators                 │
│  Prompts H1, H2 → what services + how fast                │
│  CTA: "Book a free AI Readiness Call"                      │
├────────────────────────────────────────────────────────────┤
│  7-SERVICE GRID (~400w)                                    │
│  One card per service page with: service name, primary     │
│  pain solved, outcome signal, CTA → /ai/[slug]            │
├────────────────────────────────────────────────────────────┤
│  AEO FAQ BLOCK (~500w)                                     │
│  Prompts H1,H2,H3,H4,H5,H8,H10 (FAQPage JSON-LD)         │
├────────────────────────────────────────────────────────────┤
│  WHERE TO START (~300w)                                    │
│  Prompt H3 → vertical-to-service mapping                  │
├────────────────────────────────────────────────────────────┤
│  WHY TRIOANGLE (~300w)                                     │
│  Prompt H4 → trust + structural guarantees + H8           │
├────────────────────────────────────────────────────────────┤
│  COMPARISON (~200w)                                        │
│  Prompts H6, H7 → domain-specific vs generic + build/buy  │
├────────────────────────────────────────────────────────────┤
│  WHY NOW (~400w)                                           │
│  Prompt H9 → AI-era platform economics                    │
├────────────────────────────────────────────────────────────┤
│  BOFU + CTA (~200w)                                        │
│  Prompt H10 → 8-question checklist near CTA               │
│  CTA: "Book a free AI Readiness Call"                      │
└────────────────────────────────────────────────────────────┘
```

**Schema stack — Hub:**
- `Organization` (Trioangle) — sitewide
- `Service` (broad: *"AI Feature Development for Platform Operators"*)
- `FAQPage` (7 prompts from H1–H10)
- `BreadcrumbList` (Home > AI Services)

### Internal Links (required on hub page)
- Down to each service page: `/ai/rag-knowledge-assistant`, `/ai/ai-customer-support-bot`, `/ai/ai-agents-automation`, `/ai/whatsapp-ai-automation`, `/ai/ai-content-moderation`, `/ai/ai-search-upgrade`, `/ai/voice-ai-development`
- Cross to industry pages: `/industries/[vertical]` for buyers researching by vertical

### Internal Links (required on each service page)
- Up to hub: `← AI Services` (`/ai/`)
- Cross to 2–3 related service pages (e.g., RAG → AI Support Bot → AI Search)
- Cross to relevant industry pages (e.g., AI Content Moderation → `/industries/marketplace`, `/industries/social-media`)

---

# 🎯 CONTENT PRIORITY MATRIX

| Build Order | Page | Priority | Prompts | Compressed To |
|-------------|------|----------|---------|---------------|
| 1st | `/ai/rag-knowledge-assistant` | LP P5 | 1–13 via substitution | ~1,500–2,000w |
| 2nd | `/ai/ai-customer-support-bot` | LP P6 | 1–13 via substitution | ~1,500–2,000w |
| 3rd | `/ai/ai-agents-automation` | LP P7 | 1–13 via substitution | ~1,500–2,000w |
| 4th | `/ai/` Hub | LP P9 | H1–H10 | ~2,000–3,000w |
| 5th | `/ai/whatsapp-ai-automation` | LP P10 | 1–13 via substitution | ~1,500–2,000w |
| 6th | `/ai/ai-content-moderation` | LP P11 | 1–13 via substitution | ~1,500–2,000w |
| 7th | `/ai/ai-search-upgrade` | LP P12 | 1–13 via substitution | ~1,500–2,000w |
| 8th | `/ai/voice-ai-development` | LP P13 | 1–13 via substitution | ~1,500–2,000w |

**Within each service page:**

| Priority | Prompts | Type | On-Page Block |
|----------|---------|------|---------------|
| 🔴 **P0 (ship first)** | 1, 2, 3, 4, 5 | AEO Hero/FAQ | Hero subheads + FAQ block + pricing block |
| 🟡 **P1 (week 1)** | 6, 7, 8, 9, 10 | AEO Comparison + GEO Tech-depth | Comparison table + tech-depth section + evaluation block |
| 🟢 **P2 (week 2)** | 11, 12, 13 | AEO BoFU | Diligence checklist + ROI block + compatibility FAQ near CTA |

---

# ✅ SERVICE PAGE COMPLIANCE CHECK

Before publishing any service page section generated from these prompts, verify:

- [ ] **[Service] named in H1 or hero subhead** — not a generic "AI engineering" page; leads with the specific service
- [ ] **[Platform-Pain] named explicitly** — the exact failure mode this service solves; this is what the buyer is searching for
- [ ] **[Alt-Service] comparison is honest** — includes a "use [Alt-Service] when" path; recommending a competitor SaaS when it fits is a feature, not a loss
- [ ] **[Key-Tech] named in tech-depth section** — tech stack disclosed, not hidden; builds trust with P5/P1 who evaluate this
- [ ] **[Outcome-Signal] framed as measurable** — no "efficiency gains"; named metric with before/after framing; A/B methodology where applicable
- [ ] **Service-isolation + fallback described** — at least once on every page; critical for P5/P1 who ask about platform stability
- [ ] **Structural guarantees named by mechanism** — Day-1 GitHub, IP transfer, 48-hr SLA, pre-contract engineer intro — not verbal promises
- [ ] **Fixed-price CTA only** — "Get a fixed-price [Service] quote"; no "request a proposal" or retainer-shaped language
- [ ] **No "faster with AI" claim** — frame on domain expertise, certainty of delivery, and risk reduction
- [ ] **No "800+" exact count** — platform credibility only: "built by the team that's shipped 800+ platforms in your vertical since 2015"; do not conflate with AI feature delivery count
- [ ] **Disqualification banner present** — $1M+ ARR / 12+ months production; routes pre-traction operators to Product ICP
- [ ] **Internal links live** — hub (`/ai/`) + 2–3 related service pages + relevant industry pages
- [ ] **Schema stack live** — `Organization` + `Service` (service-scoped) + `FAQPage` + `BreadcrumbList`

---

**Total Prompt Entries:** 23 (13 service template + 10 hub-specific)
**Pages Generated:** 8 (1 hub + 7 service pages) via variable substitution
**Build Order:** RAG (P5) → Support Bot (P6) → AI Agents (P7) → Hub (P9) → WhatsApp (P10) → Moderation (P11) → Search (P12) → Voice (P13)
**Source Landing Page Plan:** [[Trioangle Landing Page Plan]] | **Source ICP:** [[Trioangle - ICP - Service]] | **Marketing Plan:** [[Trioangle - Marketing Plan - Service]] | **Track:** Track 2 ([[Trioangle Growth Plan]])
