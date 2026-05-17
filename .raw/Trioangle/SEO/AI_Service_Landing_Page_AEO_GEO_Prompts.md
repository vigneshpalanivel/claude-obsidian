# AEO + GEO Prompts — AI Engineering Feature Pages (`/ai-engineering/` cluster)

**Source:** `Trioangle Landing Page Plan.md` · `Trioangle - ICP - Service.md` · `Trioangle - Marketing Plan - Service.md` | **Generated:** May 2026

| Field | Value |
|-------|-------|
| **URL Pattern** | `trioangle.com/ai-engineering/[service-slug]` |
| **Hub Page** | `trioangle.com/ai-engineering/` — AI Engineering Hub (Priority 9 in Landing Page Plan) |
| **Service Pages** | 7 pages — one 13-prompt template, substitute per-service variables |
| **Total Prompt Entries** | 23 (13 service template + 10 hub-specific) |
| **Build Order** | P5 RAG → P6 Support Bot → P7 AI Agents → P9 Hub → P10 WhatsApp → P11 Moderation → P12 Search → P13 Voice |
| **Service Page CTA** | 🥇 Primary: *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k) → fixed-price [Service] build · 🥈 Secondary: *Request a scoping call* (defined-scope buyers who can skip the audit) |
| **Hub Page CTA** | Free AI Readiness Call (1-hour, no pitch deck) → AI Audit Sprint |
| **Sibling LP** | [[Service_Industry_Landing_Page_AEO_GEO_Prompts]] — covers `/industries/[vertical]` cluster |
| **Track** | Track 2 — AI-First Service Engine ([[Trioangle Growth Plan]]) |

> [!NOTE] How to Use
> Substitute the per-service variables from the table below into the 13 template prompts. The result is a complete AEO/GEO prompt set for that service page. Hub-specific prompts (H1–H10) apply to `trioangle.com/ai-engineering/` only.
>
> **Service pages** (`/ai-engineering/[slug]`) target buyers who already know which AI service they need. **Hub page** (`/ai-engineering/`) targets buyers who know they need AI but haven't selected a specific service. Copy, keywords, and CTAs differ accordingly.
>
> **Ship-priority labels (S0/S1/S2)** in this doc indicate *when* a prompt ships (S0 = day 1, S1 = week 1, S2 = week 2). They are distinct from **ICP persona references (P1/P2/P3/P4/P5)**, which use the Service ICP's persona numbering and appear in the annotation column of each prompt.
>
> **Persona-pair ordering is meaningful** — the *first* persona in a pair is the prompt's primary audience, the second is secondary. Conventions used below:
> - `P5·P1` — technical / operational / tech-depth prompts (P5 = primary AI buyer leads; P1 = trust-conscious custom-dev buyer secondary)
> - `P1·P5` — diligence / financial-trust prompts (P1 leads when the prompt is about evaluation, ROI commitment, or signing-stage questions)
> - `P1·P2 (trust)` — pure-trust prompts (IP, contractual mechanisms, written guarantees)
> - `P5` / `All personas` — single-audience or universal prompts
>
> Always include the `(trust)` annotation when the prompt is in a trust block; omit otherwise.

---

## 🛡️ POSITIONING RULES (Apply to Every Prompt Below)

> [!IMPORTANT] Search-Side Language — Service-Specific
> On service pages, buyers are already searching for the specific service: *"RAG implementation service"*, *"AI agent development"*, *"voice AI for booking platforms"*. Prompts must use the service's own technical vocabulary, not generic "AI engineering" language. Secondary keywords from the Landing Page Plan keyword map are the search surface; prompts must hit them.

> [!IMPORTANT] Custom vs SaaS Honesty Rule
> Every comparison prompt must include an honest "use [Alt-Service] when" path. Recommending a competitor SaaS when it fits better (e.g., "if Intercom Fin handles your support ticket volume, use it") is a structural differentiator — not a loss. The AI Readiness Call is where this recommendation is made explicitly, before any build commitment.

> [!IMPORTANT] Delivery Count — Pre-Publish Gate Active
> Do not use "800+" as an exact count in any external-facing content until the internal audit is confirmed. Use: *"built by the team that's shipped 800+ platforms in your vertical since 2015"* for platform credibility. Do not conflate platform deliveries with AI feature deliveries — AI service delivery counts are tracked separately.

> [!IMPORTANT] Trust — Structural Guarantees Only
> Day-1 GitHub, IP transfer clause, 48-hour comm SLA with 5% credit, pre-contract engineer introduction. Never "we pride ourselves on transparent communication." Every service page must name at least one contractual mechanism.

> [!IMPORTANT] No Retainer Language
> Every service page is fixed-price, output-based. No monthly retainer, no AI subscription. The pricing block must reflect this on every page.

> [!IMPORTANT] Established Operators Only
> Service pages target $1M+ ARR platform operators with 12+ months production history. Disqualification banner on every page routes pre-traction operators to the Product ICP (white-label / ready-to-launch / productized solutions).

> [!IMPORTANT] Vertical-Depth Anchor — Every Service Page
> The brand-wide positioning anchor from the Landing Page Plan — *"Built by the team that's shipped 800+ platforms in your vertical since 2015"* — must appear at least once on every service page (typically the trust block or hero subhead). Vertical depth is the headline; AI is the offering. Service-page prompts without this anchor risk reading as a generic AI agency pitch.

> [!IMPORTANT] Channel-Partner Inbound Routing (P3 / P4)
> Per the Landing Page Plan, P3 (enterprise) and P4 (MENA) personas are **channel-partner-only** — no direct outbound until the partner program is live. They will still land on these pages from Clutch, conference search, and referrals. Page copy is unchanged for them; routing happens at the form-fill and first-call layer (enterprise email + RFP language → enterprise partner; UAE/KSA/Qatar signals → MENA partner). Do not add P3/P4-specific banners or filters on the page itself.

> [!NOTE] Trigger Language (Hero Subheads, Optional)
> The Landing Page Plan defines four trigger subheads for industry pages — competitor moved, expansion event, post–Series C, manual-ops breakdown. Service pages can borrow these in hero subheads when a clear trigger maps to the service:
> - **RAG** → platform knowledge base or policy docs outpacing what support agents can answer from memory
> - **AI Support Bot** → ticket backlog after volume spike
> - **AI Agents** → manual ops breakdown at scale
> - **Voice AI** → phone overload during expansion
> - **WhatsApp AI** → manual WhatsApp ops team capped at message volume
> - **AI Content Moderation** → post-moderation-incident (false-positive GMV drop, regulator letter, viral takedown, UGC volume outpacing the human moderation team)
> - **AI Search** → search-to-conversion rate dropping or zero-results rate climbing as catalog / inventory grows
>
> Use sparingly; service pages explain *what*, trigger language explains *why now*.

---

## 🏷️ SHIP-PRIORITY MARKERS

*Ship priorities use the S0/S1/S2 prefix to avoid collision with the P1–P5 ICP persona numbering used in the annotation column of each prompt.*

- 🔴 **S0** — Ship-first. Definition + voice anchors + cost/timeline (5 prompts per service page)
- 🟡 **S1** — Week 1. Comparison + tech-depth + evaluation (5 prompts per service page)
- 🟢 **S2** — Week 2. Due-diligence + ROI + compatibility (3 prompts per service page)

---

## 🔤 VARIABLE SUBSTITUTION TABLE

*Substitute these values into every template prompt for each service page.*

### Core Variables

| Variable | Description |
|----------|-------------|
| `[Service]` | Service name as buyers search it (e.g., "RAG knowledge assistant") |
| `[Service-Slug]` | URL slug (e.g., `rag-knowledge-assistant`) |
| `[Service-Headline]` | The H1 from the Landing Page Plan for this service — use verbatim as the page H1, not a paraphrase |
| `[Alt-Service]` | Off-the-shelf alternative buyers compare against |
| `[Key-Tech]` | Core technology stack for this service — recommended at the AI Readiness Call, finalized in the Audit Sprint, fully disclosed before signing the fixed-price build, and client-owned at delivery |
| `[Platform-Pain]` | The specific failure mode this service solves |
| `[Outcome-Signal]` | The measurable metric this service moves |

---

### 7-Service Substitution Reference

#### 1. RAG Knowledge Assistant · `/ai-engineering/rag-knowledge-assistant` · Priority 5

| Variable | Value |
|----------|-------|
| `[Service]` | RAG knowledge assistant |
| `[Service-Slug]` | `rag-knowledge-assistant` |
| `[Service-Headline]` | *RAG knowledge assistants that actually know your platform's data — not generic chatbots* |
| `[Alt-Service]` | Pinecone Assistant · AWS Bedrock Knowledge Bases · generic LlamaIndex/LangChain RAG without domain tuning · vector-DB-only setups (Pinecone / Weaviate / Qdrant + manual integration) |
| `[Key-Tech]` | LlamaIndex · pgvector · BM25 hybrid search · reranking · embedding pipeline |
| `[Platform-Pain]` | generic RAG hallucinating answers outside platform-specific knowledge; retrieval failing on platform vocabulary (commission terms, dispatch states, listing taxonomies); confidently wrong answers eroding user trust |
| `[Outcome-Signal]` | answer accuracy on platform-specific queries · retrieval precision/recall on platform vocabulary · hallucination rate · downstream business-translation (support tickets deflected from agents · session length / retention lift from accurate self-serve answers · time-to-resolution on platform-specific user questions — pick the metric the operator already tracks) |

#### 2. AI Customer Support Bot · `/ai-engineering/ai-customer-support-bot` · Priority 6

| Variable | Value |
|----------|-------|
| `[Service]` | AI customer support bot |
| `[Service-Slug]` | `ai-customer-support-bot` |
| `[Service-Headline]` | *AI customer support bots that resolve tickets without human handoff — trained on your platform's actual data* |
| `[Alt-Service]` | Intercom Fin · Zendesk AI · Freshdesk Freddy |
| `[Key-Tech]` | RAG pipeline · live handoff logic · multilingual NLP · ticket routing and escalation |
| `[Platform-Pain]` | support ticket volume outpacing human team at scale; inconsistent answers across agents; slow first-response time |
| `[Outcome-Signal]` | ticket deflection rate · first-response time · CSAT score |

#### 3. AI Agents & Workflow Automation · `/ai-engineering/ai-agents-automation` · Priority 7

| Variable | Value |
|----------|-------|
| `[Service]` | AI agents and workflow automation |
| `[Service-Slug]` | `ai-agents-automation` |
| `[Service-Headline]` | *AI agents that do the work — not just answer questions. Booking, dispatch, support, and ops workflows automated end-to-end.* |
| `[Alt-Service]` | Zapier · Make · no-code automation tools |
| `[Key-Tech]` | LangGraph · ReAct agents · MCP · tool use · human-in-the-loop checkpoints |
| `[Platform-Pain]` | multi-step operational workflows (dispatch, booking, reconciliation) that require judgment beyond simple rule-based routing |
| `[Outcome-Signal]` | operational steps automated without human · decision accuracy · human intervention rate |

#### 4. WhatsApp AI Automation · `/ai-engineering/whatsapp-ai-automation` · Priority 10

| Variable | Value |
|----------|-------|
| `[Service]` | WhatsApp AI automation |
| `[Service-Slug]` | `whatsapp-ai-automation` |
| `[Service-Headline]` | *WhatsApp AI that handles bookings, support, and order updates — without a human in the loop* |
| `[Alt-Service]` | Twilio basic bot · manual WhatsApp ops team · generic WhatsApp Business API integration |
| `[Key-Tech]` | WhatsApp Business API · WhatsApp Flows · multi-language NLP · session management |
| `[Platform-Pain]` | manual ops team handling bookings, order updates, and support over WhatsApp — not scalable past a certain volume |
| `[Outcome-Signal]` | messages handled without human agent · booking confirmation rate · average response time |

#### 5. AI Content Moderation · `/ai-engineering/ai-content-moderation` · Priority 11

| Variable | Value |
|----------|-------|
| `[Service]` | AI content moderation |
| `[Service-Slug]` | `ai-content-moderation` |
| `[Service-Headline]` | *AI content moderation that scales with your platform — without false positives tanking your GMV* |
| `[Alt-Service]` | Amazon Rekognition · Google Vision AI · Perspective API |
| `[Key-Tech]` | image moderation classifier · text toxicity detection · domain-specific false positive tuning · human review escalation |
| `[Platform-Pain]` | false positives removing valid listings / content and killing GMV; human moderation team not scaling with platform UGC growth |
| `[Outcome-Signal]` | false positive rate · recall (miss rate on actual violations) · moderation throughput |

#### 6. AI Search Upgrade · `/ai-engineering/ai-search-upgrade` · Priority 12

| Variable | Value |
|----------|-------|
| `[Service]` | AI semantic search |
| `[Service-Slug]` | `ai-search-upgrade` |
| `[Service-Headline]` | *Semantic search that understands what your users actually mean — not just what they typed* |
| `[Alt-Service]` | Algolia · Elasticsearch keyword search · Typesense |
| `[Key-Tech]` | pgvector · BM25 hybrid search · embedding pipeline · reranking · query intent understanding |
| `[Platform-Pain]` | keyword search failing on intent-based queries; high zero-results rate; low search-to-conversion rate |
| `[Outcome-Signal]` | search conversion rate · zero-results rate · click-through rate on top results |

#### 7. Voice AI Development · `/ai-engineering/voice-ai-development` · Priority 13

| Variable | Value |
|----------|-------|
| `[Service]` | voice AI |
| `[Service-Slug]` | `voice-ai-development` |
| `[Service-Headline]` | *Voice AI that handles calls, bookings, and support — integrated into your existing platform, not bolted on* |
| `[Alt-Service]` | legacy IVR systems · Twilio basic voice flow · Dialogflow |
| `[Key-Tech]` | Vapi · Retell AI · real-time voice pipeline · tool use · human fallback routing |
| `[Platform-Pain]` | phone support overload, IVR dead-ends, missed calls, manual booking ops over the phone |
| `[Outcome-Signal]` | calls resolved without human agent · bookings completed via voice · average handle time |

---

# 📄 SERVICE PAGE PROMPTS — Template (1–13)

*Apply to all 7 service pages via variable substitution. URL: `trioangle.com/ai-engineering/[Service-Slug]`. AEO snippets: 40–60 words inside `FAQPage` JSON-LD. GEO blocks: 150–500-word compressed sections. Word budget per service page: ~1,500–2,500 words.*

> [!IMPORTANT] Hooks are source material, not final copy
> Each prompt hook below runs 80–150 words — it's the brief, not the published answer. **For the FAQPage JSON-LD answer**, compress the hook to **40–60 words** (AEO budget). **For the on-page GEO block**, expand the hook into a **150–500-word section** with the body copy detail. Pasting the raw hook into JSON-LD will blow the AEO budget; using the hook verbatim as the only body copy will under-fill the GEO target.

---

## 🔴 S0 — Ship-First (1–5)

*Hero FAQ + voice anchors + cost/timeline. Every service page must have these live on day 1.*

**1.** What is [Service] for an existing platform — and how is it different from using [Alt-Service]? — 🔴 **S0** *| All personas | Hero FAQ | Hook: [Service] is a purpose-built integration into the platform's own data layer and business logic — not an off-the-shelf tool applied generically; [Alt-Service] works when domain fit is adequate; custom [Service] wins when the platform's business logic is specific enough that [Alt-Service] produces [Platform-Pain]; domain knowledge of how the platform works is built into [Service] on day one, not discovered in month three*

**2.** How long does it take to get [Service] live in an existing production platform — from first conversation to working in production? — 🔴 **S0** *| P5·P1 | Hero FAQ | Hook: Free AI Readiness Call (1 hr) → optional AI Audit Sprint ($1.5k–$4k, 2-week paid pre-engagement that produces architecture + data-readiness assessment + fixed-price quote — skippable for buyers with a defined scope) → fixed-price quote agreed → build starts → [Service] in staging (weeks 3–6, depending on data readiness and scope) → production live with monitoring active; typical 4–8 weeks from signed scope to live [Service]; the platform's existing API layer and data readiness are the primary schedule variables*

**3.** What does [Service] cost — what is included in a fixed-price build and what is not? — 🔴 **S0** *| All personas | FAQ + pricing block | Hook: [Service] build is fixed-price, scoped at the deliverable level; included: data pipeline integration, [Service] core build using [Key-Tech], service-isolated deployment, monitoring setup, and a post-delivery support window; not included: ongoing model retraining beyond the agreed window, infrastructure hosting after handoff; no monthly retainer, no per-hour billing, no SaaS subscription lock-in*

**4.** Does an external team need access to my codebase to build [Service] — and what IP protections exist? — 🔴 **S0** *| P1·P2 (trust) | FAQ | Hook: read-only codebase access during integration (write access only on agreed feature branches); NDA executed before any code review; Day-1 GitHub access (client owns the [Service] repo from commit one); IP transfer clause at delivery — model artifacts, data pipeline, inference code, documentation all transfer at handoff; no client data used for third-party model training*

**5.** Can [Service] be deployed into a live platform without downtime or disruption to active users? — 🔴 **S0** *| P5·P1 | Hero subhead + FAQ | Hook: service-isolation — [Service] runs as a standalone microservice alongside the existing platform; gradual traffic rollout via feature flag; automatic fallback to a defined path when [Service] confidence drops or latency spikes (existing rule-based logic for RAG/Support Bot/Moderation/Search/Agents; sub-N-second human handoff for Voice AI and WhatsApp AI where the user is in the [Service] flow by design); rollback takes < 1 minute; core platform's non-[Service] user flows are never blocked by a [Service] failure*

---

## 🟡 S1 — Week 1 (6–10)

*Comparison table + tech-depth + evaluation path.*

**6.** Custom [Service] vs [Alt-Service] — when does building custom beat buying off-the-shelf in 2026? — 🟡 **S1** *| P5 | Comparison block | Hook: [Alt-Service] wins when domain fit is adequate and customization needs are low; custom [Service] wins when the platform's business logic produces [Platform-Pain] with off-the-shelf tools — meaning the model fails on real platform data; the AI Readiness Call surfaces this distinction before any build commitment; "use [Alt-Service]" is a valid and common output of that call*

**7.** External [Service] team vs hiring in-house ML engineers: which gets [Service] live faster for an established platform? — 🟡 **S1** *| P1·P5 | Comparison block | Hook: in-house ML = 4–9 month hiring + onboarding + no platform-specific domain knowledge + full-salary ongoing cost; external = Free AI Readiness Call (1 hr) → AI Audit Sprint ($1.5k–$4k, 2 weeks, skippable for defined-scope buyers) → fixed-price build (4–8 weeks) → live and measured; external wins until [Service]-type build volume exceeds 3–4 projects per year — at that point, in-house makes financial sense for this service category specifically*

**8.** How does [Service] actually integrate into an existing platform end-to-end — from data ingestion to user-facing impact? — 🟡 **S1** *| Tech-depth section (~300w synthesis) | P5·P1 | Hook: platform API / event stream → data ingestion layer → [Service] core build ([Key-Tech]) → service-isolated API layer → staging validation → feature-flag rollout → [Outcome-Signal] tracked against pre-[Service] baseline; the integration point is the platform's existing API boundary — [Service] does not require refactoring the core platform*

**9.** What [Key-Tech] does [Service] rely on — and why does the tech stack choice matter for a platform operator? — 🟡 **S1** *| Tech-depth section (~200w) | P5·P1 | Hook: the [Key-Tech] stack determines [Service]'s performance characteristics on real platform data (latency, accuracy, false positive rate, scale ceiling); the stack is recommended at the AI Readiness Call and finalized in the Audit Sprint based on the platform's data volume, latency requirements, and hosting constraints — not on team preference; the full tech stack is disclosed before signing the fixed-price build and fully client-owned at delivery*

**10.** How do I evaluate whether an external [Service] team genuinely understands my platform type — before committing to a $15k–$80k fixed-price build? — 🟡 **S1** *| Due-diligence block | P1·P5 | Hook: ask for a production case study in a platform similar to yours with a named [Outcome-Signal] improvement and methodology disclosed; request a pre-contract engineer introduction (the engineers who will build [Service], not the sales rep); ask how [Platform-Pain] is specifically handled in the [Service] architecture; the AI Readiness Call is the lowest-risk evaluation path: 1 hour, free, no commitment*

---

## 🟢 S2 — Week 2 (11–13)

*BoFU diligence + ROI + compatibility.*

**11.** What questions should I ask before signing any [Service] engagement with an external team? — 🟢 **S2** *| BoFU checklist near CTA | P1·P5 | Hook: 7-question checklist — (1) production case study in my platform type with named [Outcome-Signal]? (2) pre-contract engineer introduction? (3) IP transfer clause in writing? (4) Day-1 GitHub access? (5) data handling NDA? (6) fixed-price with defined acceptance condition? (7) rule-based fallback or rollback path if [Service] underperforms? Anchor with Trioangle's pre-filled answers as the benchmark*

**12.** How do I calculate ROI from [Service] — what's a realistic payback timeline for a platform at $1M+ ARR? — 🟢 **S2** *| BoFU near CTA | P1·P2 | Hook: ROI frame = [Outcome-Signal] improvement × business-value conversion × total volume = annual upside; at typical [Service] performance lifts, payback on a fixed-price [Service] build (typical range $15k–$80k depending on service type and integration complexity) is 60–120 days for most $1M+ ARR platforms; the AI Readiness Call produces an ROI estimate specific to the platform's volume before any commitment*

**13.** Can [Service] be added to an existing tech stack (Laravel/PHP, Node.js, Python/Django, Ruby on Rails) without a full platform rewrite? — 🟢 **S2** *| FAQ | All personas | Hook: service-isolation means [Service] runs as a separate service consuming the platform's existing API; any backend stack is compatible as long as an API layer exists; the core codebase is untouched; [Service] adds capability without refactoring what already works in production*

---

# 📄 HUB PAGE PROMPTS — `trioangle.com/ai-engineering/` (H1–H10)

*Hub page targets buyers who know they need AI features but haven't selected a specific service. AEO snippets + GEO blocks. Word budget: ~2,000–3,000 words.*

---

## 🔴 Hub S0 — Ship-First (H1–H5)

**H1.** What AI services can be embedded into an existing platform — and how does an established platform operator decide which to build first? — 🔴 **Hub S0** *| Hero FAQ | All personas | Hook: 7 productized AI services for platform operators — RAG knowledge assistant, AI customer support bot, AI agents and workflow automation, WhatsApp AI automation, AI content moderation, AI semantic search, voice AI; selection is based on which has the highest business-metric impact for the platform's specific vertical and data readiness; the AI Readiness Call maps this in 1 hour before any commitment*

**H2.** How long does it take to get the first AI feature live in an existing platform — from first conversation to working in production? — 🔴 **Hub S0** *| Hero FAQ | P5·P1 | Hook: Free AI Readiness Call (1 hr, no pitch deck) → optional AI Audit Sprint ($1.5k–$4k, 2-week paid pre-engagement that produces architecture + data-readiness assessment + fixed-price quote; skippable for buyers with a defined scope) → fixed-price quote agreed → build starts → first AI feature in production: 4–10 weeks depending on service type and data readiness; domain knowledge of the platform's vertical is built in on day one — no 3-month learning curve billed to the client*

**H3.** Which AI service delivers the highest business-metric impact for an established platform operator in 2026? — 🔴 **Hub S0** *| "Where to start" block (~300w) | P5 | Hook: depends on vertical, mapped to one of the 7 productized services — high support-ticket volume (any vertical): AI customer support bot · platforms with deep platform-specific knowledge to surface (docs, policies, listing taxonomies): RAG knowledge assistant · multi-step ops workflows (booking, dispatch, reconciliation) that need judgment beyond if/then routing: AI agents and workflow automation · heavy WhatsApp ops (MENA, SEA, LatAm): WhatsApp AI automation · UGC platforms with moderation cost or false-positive GMV impact: AI content moderation · weak keyword search hurting conversion: AI semantic search · phone-heavy ops or IVR dead-ends: voice AI. For vertical-specific features that live outside these 7 services (AI dispatch optimization for ride-hailing/delivery, AI fraud detection for marketplaces, AI feed ranking for social), link out to the relevant /industries/[vertical] page. The AI Readiness Call maps this per platform in 1 hour*

**H4.** Is this another AI agency that shows demos and disappears — or does the team have domain knowledge of how my platform type actually works in production? — 🔴 **Hub S0** *| "Why Trioangle" / trust block | P1·P2 (trust) | Hook: structural guarantees in writing, verifiable before signing: Day-1 GitHub access, IP transfer clause, 48-hour comm SLA with 5% contract credit per breach, pre-contract engineer introduction (meet the engineers, not the sales rep); platform domain depth from building 800+ platforms across ride-hailing, delivery, marketplace, home services, and adjacent verticals since 2015 — the AI integration layer runs on knowledge of how these platforms actually work, not general ML theory*

**H5.** What does a fixed-price AI feature build cost — and what is and isn't included? — 🔴 **Hub S0** *| FAQ + pricing block | All personas | Hook: productized AI services are fixed-price, scoped at the deliverable level; typical range $15k–$80k depending on service type and integration complexity; included: detailed architecture & data-pipeline planning, build, service-isolated deployment, monitoring setup, post-delivery support window; not included: ongoing retraining beyond the post-delivery window, infrastructure hosting after handoff; no monthly retainer, no hourly billing, no AI subscription lock-in*

---

## 🟡 Hub S1 — Week 1 (H6–H8)

**H6.** Domain-specific AI feature development vs a generic AI agency: what's the real difference for an established platform operator? — 🟡 **Hub S1** *| Comparison block | P5·P1 | Hook: domain-specific means the engineering team knows the dispatch logic, commission flows, content policy edge cases, and supply-demand dynamics of the platform type before the engagement begins — not learned at the client's expense over months 1–3; a generic AI agency applies general ML patterns to a vertical it discovers on your project; the first 6–8 weeks of a generic agency engagement is billable domain learning*

**H7.** Build vs buy vs SaaS for AI features: how does an established platform operator decide? — 🟡 **Hub S1** *| Comparison block | P5 | Hook: SaaS wins when domain fit is adequate and customization is low; custom AI feature wins when the platform's business logic is specific enough that generic SaaS produces the failure mode the operator is trying to solve; the AI Readiness Call surfaces this decision in 1 hour before any build commitment — "use [SaaS]" is a valid and common output of that call*

**H8.** What structural guarantees should an AI feature engineering partner provide in writing — before any engagement begins? — 🟡 **Hub S1** *| Guarantee block | P1·P2 (trust) | Hook: the floor — Day-1 GitHub access (client owns the AI service repo from commit one), IP transfer clause (model artifacts + data pipeline + inference code at delivery), 48-hour comm SLA with 5% contract credit per breach, pre-contract engineer introduction (meet the engineers before signing), fixed-price acceptance condition (the AI feature must demonstrably improve the named metric before sign-off); verbal trust promises are noise — every agency that burned a past buyer made the same ones*

---

## 🟢 Hub S2 — Week 2 (H9–H10)

**H9.** How is the 2026 AI wave changing platform economics — and what is the cost of being the last operator in your market without AI features? — 🟢 **Hub S2** *| "Why Now" block (~400w) | P5·P1 | Hook: platform operators shipping AI features now are compounding a data advantage — every week of AI production data makes the model more accurate; competitors shipping AI dispatch, AI moderation, or AI search today have a training data head start that pricing alone cannot close in 12–18 months; the risk isn't "AI will fail" — it's "competitors will have 18 months of production AI data before you start"*

**H10.** What questions should I ask any AI feature engineering partner before signing — and what should Trioangle's answers be? — 🟢 **Hub S2** *| BoFU checklist near CTA | P1·P5 | Hook: 8-question checklist — (1) production AI case study in my platform vertical with named metric outcome? (2) pre-contract engineer introduction? (3) IP transfer clause confirmed? (4) Day-1 GitHub access? (5) data handling NDA? (6) fixed-price with defined acceptance condition? (7) honest build vs buy vs SaaS verdict from the AI Readiness Call? (8) rule-based fallback in the AI service design? Anchor with Trioangle's pre-filled answers as the benchmark*

---

# 📐 PAGE ARCHITECTURE

## Service Pages (`trioangle.com/ai-engineering/[Service-Slug]`) — ~1,500–2,500 words each

```
┌────────────────────────────────────────────────────────────┐
│  HERO (~300w)                                              │
│  H1: [Service-Headline] (verbatim from Landing Page Plan)  │
│  Subhead from prompts 1, 2, 5 (one sentence each)          │
│  Vertical-depth anchor: "Built by the team that's shipped  │
│    800+ platforms in your vertical since 2015"             │
│  🥇 Primary CTA: "Book a Free AI Readiness Call"           │
│  🥈 Secondary CTA: "Request a scoping call" (defined scope)│
├────────────────────────────────────────────────────────────┤
│  DISQUALIFICATION BANNER (~80w)                            │
│  "Built for established platform operators with active     │
│   users and revenue traction ($1M+ ARR / 12+ months in     │
│   production). Pre-launch or pre-revenue? Our white-label  │
│   product line is a better fit." → links to Product catalog│
├────────────────────────────────────────────────────────────┤
│  AEO FAQ BLOCK (~400w)                                     │
│  Rotate 6–8 prompts: 1,2,3,4,5,6,11,13                     │
│  (FAQPage JSON-LD schema)                                  │
├────────────────────────────────────────────────────────────┤
│  COMPARISON BLOCK (~400w, two sub-tables)                  │
│  Prompt 6 (~200w): custom [Service] vs [Alt-Service]       │
│  Prompt 7 (~200w): external team vs in-house ML hiring     │
├────────────────────────────────────────────────────────────┤
│  TECH DEPTH (~400w)                                        │
│  Prompts 8, 9 → integration end-to-end + [Key-Tech] named  │
├────────────────────────────────────────────────────────────┤
│  HOW IT WORKS (~200w)                                      │
│  Prompt 2 → timeline + milestones (Readiness Call → Audit  │
│    Sprint → fixed-price build)                             │
├────────────────────────────────────────────────────────────┤
│  STRUCTURAL GUARANTEE BLOCK (~150w)                        │
│  Day-1 GitHub · IP transfer · 48-hr SLA · engineer intro · │
│  vertical-depth anchor (800+ platforms since 2015)         │
├────────────────────────────────────────────────────────────┤
│  BOFU + CTA (~300w)                                        │
│  Prompts 10, 11, 12 → diligence checklist + ROI block      │
│  🥇 Primary: "Book a Free AI Readiness Call"               │
│  🥈 Secondary: "Request a scoping call"                    │
└────────────────────────────────────────────────────────────┘
  Block-sum: ~2,230w  ·  Target: 1,500–2,500w  ·  Headroom: ~270w
```

**Schema stack per service page:**
- `Organization` (Trioangle) — sitewide
- `Service` (scoped: *"[Service] for Platform Operators"*)
- `FAQPage` (6–8 prompts, phrased with [Service] + [Platform-Pain] language)
- `BreadcrumbList` (Home > AI Engineering > [Service])

> [!NOTE] Why "[Service] for Platform Operators" and not "[Service] Development for Platform Operators"
> The `[Service]` variable already implies the engineering work (e.g., "RAG knowledge assistant", "AI customer support bot", "voice AI"). Appending "Development" produces awkward concatenations like *"AI agents and workflow automation Development for Platform Operators"*. Drop the suffix; the service name carries the engineering connotation on its own.

---

## Hub Page (`trioangle.com/ai-engineering/`) — ~2,000–3,000 words

```
┌────────────────────────────────────────────────────────────┐
│  HERO (~400w)                                              │
│  H1 (verbatim from Landing Page Plan P9):                  │
│   "Productized AI engineering for marketplace, on-demand,  │
│    and platform operators — built by the team that's       │
│    shipped 800+ platforms since 2015 across 9 verticals"   │
│  Prompts H1, H2 → what services + how fast                 │
│  CTA: "Book a Free AI Readiness Call" (1-hr, no pitch deck)│
├────────────────────────────────────────────────────────────┤
│  7-SERVICE GRID (~400w)                                    │
│  One card per service page with: service name, primary     │
│  pain solved, outcome signal, CTA → /ai-engineering/[slug] │
├────────────────────────────────────────────────────────────┤
│  AEO FAQ BLOCK (~500w)                                     │
│  Prompts H1,H2,H3,H4,H5,H8,H10 (FAQPage JSON-LD)           │
├────────────────────────────────────────────────────────────┤
│  WHERE TO START (~200w)                                    │
│  Prompt H3 → vertical-to-service mapping (compact: 7 lines │
│  one per service); features outside the 7 services link    │
│  out to /industries/[slug]                                 │
├────────────────────────────────────────────────────────────┤
│  WHY TRIOANGLE (~300w)                                     │
│  Prompt H4 → trust + structural guarantees + H8            │
├────────────────────────────────────────────────────────────┤
│  HOW IT WORKS (~200w)                                      │
│  Prompt H2 → Readiness Call (1 hr, free, no pitch deck) →  │
│  optional Audit Sprint ($1.5k–$4k, 2 weeks) → fixed-price  │
│  build (4–10 weeks); visual timeline with named milestones │
├────────────────────────────────────────────────────────────┤
│  COMPARISON BLOCK (~400w, two sub-tables)                  │
│  Prompt H6 (~200w): domain-specific vs generic AI agency   │
│  Prompt H7 (~200w): build vs buy vs SaaS for AI features   │
├────────────────────────────────────────────────────────────┤
│  WHY NOW (~400w)                                           │
│  Prompt H9 → AI-era platform economics                     │
├────────────────────────────────────────────────────────────┤
│  BOFU + CTA (~200w)                                        │
│  Prompt H10 → 8-question checklist near CTA                │
│  CTA: "Book a Free AI Readiness Call"                      │
└────────────────────────────────────────────────────────────┘
  Block-sum: ~3,000w  ·  Target: 2,000–3,000w  ·  At ceiling — no headroom
```

**Schema stack — Hub:**
- `Organization` (Trioangle) — sitewide
- `Service` (broad: *"AI Engineering for Platform Operators"* — aligns with the Landing Page Plan's primary keyword `AI engineering services`)
- `FAQPage` (7 prompts from H1–H10)
- `BreadcrumbList` (Home > AI Engineering)

### Internal Links (required on hub page)
- Down to each service page: `/ai-engineering/rag-knowledge-assistant`, `/ai-engineering/ai-customer-support-bot`, `/ai-engineering/ai-agents-automation`, `/ai-engineering/whatsapp-ai-automation`, `/ai-engineering/ai-content-moderation`, `/ai-engineering/ai-search-upgrade`, `/ai-engineering/voice-ai-development`
- Cross to industry pages: `/industries/[vertical]` for buyers researching by vertical
- **Pillar 7 articles linked from CTA / BoFU zones** (per [[Trioangle - Content Strategy - Service]] §Cluster 7.1, 7.3, 7.4, 7.5):
  - AI Strategy framing → Articles #82, #83, #84 + Article #92 (*"Copilot vs AI Engineering"*)
  - Build-vs-Buy depth → Articles #109, #110, #111, #112 (Cluster 7.4)
  - Post-Launch AI Ops → Articles #114, #115, #116
  - **Do NOT link Article #113 from hub** — #113 is architecture deep-dive linked from RAG and AI Agents service LPs only, to avoid duplicating hub intent
  - Note: Articles #90 and #91 are reverse-linked *from each service LP's Tech-Depth section*, not from the hub directly

### Internal Links (required on each service page)
- Up to hub: `← AI Engineering` (`/ai-engineering/`)
- Cross to 2–3 related service pages (e.g., RAG → AI Support Bot → AI Search)
- Cross to relevant industry pages (e.g., AI Content Moderation → `/industries/marketplace`, `/industries/social-media`)
- **Tech Depth section links down to canonical Pillar 7 articles** ([[Trioangle - Content Strategy - Service]] §Cluster 7.3, 7.4, 7.5):
  - Prompt 5 + Prompt 8 (service-isolation, integration) → Article #91 *"AI Service Isolation"* (canonical for the architecture pattern) and Article #90 *"How to Add AI Features to a Live Platform"* (canonical for operator-anxiety framing)
  - Prompt 6 (SaaS-vs-custom) → relevant Cluster 7.4 article by service: `/ai-engineering/ai-search-upgrade` → Article #109 *"AWS Personalize vs. Custom AI"* + Article #112 *"Vertex AI vs. Custom Models"*; `/ai-engineering/rag-knowledge-assistant` → Article #110 *"Pinecone + OpenAI vs. Domain Partner"*; `/ai-engineering/ai-content-moderation` → Article #109
  - Prompt 9 (tech-depth, RAG and AI Agents pages only) → Article #113 *"Inside Our AI Engineering Stack: pgvector, LangGraph, Service Isolation"* (architecture deep-dive — linked from individual service LPs, NOT the hub, per Content Strategy §Cluster 7.5)
- **Cross-link discipline (prevent SEO cannibalization):** LP carries the 40–60w FAQ-format answer; blog article carries the long-form depth. LP must NOT re-argue what the article argues — link out instead. Article must NOT compete on LP's decision-stage CTA — its CTA routes to AI Readiness Call / AI Audit Sprint funnel, not back to LP

---

# 🎯 CONTENT PRIORITY MATRIX

| Build Order | Page | Priority | Prompts | Compressed To |
|-------------|------|----------|---------|---------------|
| 1st | `/ai-engineering/rag-knowledge-assistant` | LP P5 | 1–13 via substitution | ~1,500–2,500w |
| 2nd | `/ai-engineering/ai-customer-support-bot` | LP P6 | 1–13 via substitution | ~1,500–2,500w |
| 3rd | `/ai-engineering/ai-agents-automation` | LP P7 | 1–13 via substitution | ~1,500–2,500w |
| 4th | `/ai-engineering/` Hub | LP P9 | H1–H10 | ~2,000–3,000w |
| 5th | `/ai-engineering/whatsapp-ai-automation` | LP P10 | 1–13 via substitution | ~1,500–2,500w |
| 6th | `/ai-engineering/ai-content-moderation` | LP P11 | 1–13 via substitution | ~1,500–2,500w |
| 7th | `/ai-engineering/ai-search-upgrade` | LP P12 | 1–13 via substitution | ~1,500–2,500w |
| 8th | `/ai-engineering/voice-ai-development` | LP P13 | 1–13 via substitution | ~1,500–2,500w |

**Within each service page:**

| Priority | Prompts | Type | On-Page Block |
|----------|---------|------|---------------|
| 🔴 **S0 (ship first)** | 1, 2, 3, 4, 5 | AEO Hero/FAQ | Hero subheads + FAQ block + pricing block |
| 🟡 **S1 (week 1)** | 6, 7, 8, 9, 10 | AEO Comparison + GEO Tech-depth | Comparison table + tech-depth section + evaluation block |
| 🟢 **S2 (week 2)** | 11, 12, 13 | AEO BoFU | Diligence checklist + ROI block + compatibility FAQ near CTA |

---

# ✅ SERVICE PAGE COMPLIANCE CHECK

Before publishing any service page section generated from these prompts, verify each gate. Grouped by category — work top-to-bottom.

**Variables (substitution-table correctness):**
- [ ] **[Service-Headline] used verbatim as H1** — not paraphrased; matches the Landing Page Plan headline for this service exactly
- [ ] **[Service] named in H1 or hero subhead** — leads with the specific service (e.g., "RAG knowledge assistant", "voice AI"); does not fall back to the cluster-level "AI engineering" framing, which belongs on the hub page
- [ ] **[Platform-Pain] named explicitly** — the exact failure mode this service solves; this is what the buyer is searching for
- [ ] **[Alt-Service] comparison is honest** — includes a "use [Alt-Service] when" path; recommending a competitor SaaS when it fits is a feature, not a loss
- [ ] **[Alt-Service] is service-appropriate, not duplicated across pages** — RAG ≠ AI Support Bot alternatives; pages with overlapping alternatives will read as duplicates
- [ ] **[Key-Tech] named in tech-depth section** — tech stack disclosed, not hidden; builds trust with P5/P1 who evaluate this
- [ ] **[Outcome-Signal] framed as measurable** — no "efficiency gains"; named metric with before/after framing; A/B methodology where applicable

**Positioning & copy (brand-discipline gates):**
- [ ] **Vertical-depth anchor present** — *"Built by the team that's shipped 800+ platforms in your vertical since 2015"* appears at least once (hero subhead or trust block); vertical depth is the brand-wide positioning anchor
- [ ] **No "faster with AI" claim** — frame on domain expertise, certainty of delivery, and risk reduction
- [ ] **No "800+" exact count as AI delivery claim** — platform credibility only: *"built by the team that's shipped 800+ platforms in your vertical since 2015"*; do not conflate with AI feature delivery count
- [ ] **No clone language** — never "Uber-clone / Airbnb-clone / Gojek-clone"; use *"white-label / ready-to-launch / productized"* framing for any Product-ICP references in the disqualification banner
- [ ] **Disqualification banner present** — $1M+ ARR / 12+ months in production; routes pre-traction operators to Product ICP (white-label / productized line)

**CTAs & funnel:**
- [ ] **Dual-CTA flow live** — 🥇 *"Book a Free AI Readiness Call"* primary; 🥈 *"Request a scoping call"* secondary for defined-scope buyers. No standalone "Get a fixed-price quote" CTA — that skips the Audit Sprint qualifier the ICP filter depends on
- [ ] **Readiness Call → Audit Sprint → fixed-price build flow disclosed** — the optional 2-week paid Audit Sprint ($1.5k–$4k) is named in the "How It Works" or pricing block; not hidden
- [ ] **Pricing range consistent with hub** — typical service-page builds $15k–$80k depending on service and integration complexity; do not contradict hub-page range

**Trust & technical credibility:**
- [ ] **Service-isolation + fallback described** — at least once on every page; critical for P5/P1 who ask about platform stability
- [ ] **Structural guarantees named by mechanism** — Day-1 GitHub, IP transfer, 48-hr SLA, pre-contract engineer intro — not verbal promises

**SEO / schema:**
- [ ] **Internal links live** — hub (`/ai-engineering/`) + 2–3 related service pages + relevant industry pages
- [ ] **Schema stack live** — `Organization` + `Service` (service-scoped) + `FAQPage` + `BreadcrumbList`

---

# ✅ HUB PAGE COMPLIANCE CHECK

Before publishing the `/ai-engineering/` hub page, verify each gate below. Grouped by category. Several differ from the service-page check — the differences are intentional.

**Hero & framing (hub-specific):**
- [ ] **H1 used verbatim from Landing Page Plan P9** — *"Productized AI engineering for marketplace, on-demand, and platform operators — built by the team that's shipped 800+ platforms since 2015 across 9 verticals"*; not paraphrased
- [ ] **Vertical-depth anchor in hero** — *"built by the team that's shipped 800+ platforms since 2015 across 9 verticals"* is baked into the H1 already; verify it survives any copywriter compression
- [ ] **All 7 services listed by name with the keyword each ranks for** — RAG knowledge assistant, AI customer support bot, AI agents and workflow automation, WhatsApp AI automation, AI content moderation, AI semantic search, voice AI

**CTAs & pricing:**
- [ ] **Single primary CTA** — *"Book a Free AI Readiness Call"* (1-hr, no pitch deck). Hub does NOT use the service-page dual-CTA (no "Request a scoping call" — that lives one level down)
- [ ] **Pricing range disclosed** — $15k–$80k typical; matches every service page's prompt 12 ROI math

**Vertical-to-service mapping:**
- [ ] **Vertical-to-service mapping (H3) names only the 7 productized services** — features that live on industry pages (AI dispatch optimization, AI fraud detection, AI feed ranking) explicitly link out to `/industries/[vertical]` rather than promising a service page that doesn't exist

**Trust & copy discipline:**
- [ ] **No clone language** — pre-launch hand-off (if disclaimed) uses "white-label / ready-to-launch / productized"
- [ ] **No retainer language** — fixed-price + Audit Sprint framing throughout

**Internal links & cross-pollination:**
- [ ] **7-service grid links live** — every card → `/ai-engineering/[slug]`; if a service page isn't built yet, route the card to "coming [date]" with the AI Readiness Call CTA below (no dead links)
- [ ] **Cross-link to industry pages** — at least one prominent link to `/industries/[vertical]` for the buyer who's researching by vertical
- [ ] **Pillar 7 articles linked correctly** — Articles #82–#84, #92 (Strategy); #109–#112 (Build-vs-Buy); #114–#116 (Post-Launch Ops). **Article #113 NOT linked from hub** (it routes from RAG and AI Agents service LPs only)

**SEO / schema:**
- [ ] **Schema `Service.name` = "AI Engineering for Platform Operators"** — broad-scoped, aligned with the primary keyword `AI engineering services`; do NOT use the service-page "[Service] for Platform Operators" framing
- [ ] **BreadcrumbList terminates at "AI Engineering"** — `Home > AI Engineering`; no `> [Service]` third level
- [ ] **FAQPage JSON-LD carries 7 prompts** — H1, H2, H3, H4, H5, H8, H10 (H6, H7, H9 have dedicated body sections, not FAQ)

---

**Total Prompt Entries:** 23 (13 service template + 10 hub-specific)
**Pages Generated:** 8 (1 hub + 7 service pages) via variable substitution
**Build Order:** RAG (P5) → Support Bot (P6) → AI Agents (P7) → Hub (P9) → WhatsApp (P10) → Moderation (P11) → Search (P12) → Voice (P13)
**Source Landing Page Plan:** [[Trioangle Landing Page Plan]] | **Source ICP:** [[Trioangle - ICP - Service]] | **Marketing Plan:** [[Trioangle - Marketing Plan - Service]] | **Track:** Track 2 ([[Trioangle Growth Plan]])
