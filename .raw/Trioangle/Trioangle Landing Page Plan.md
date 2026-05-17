
# Trioangle Landing Page Plan

Site architecture and SEO keyword strategy for Trioangle's AI services landing pages. Targets **Service ICP Persona 5** — established platform operators in Trioangle's 9 core verticals who need AI features embedded into their existing platform.

Positioning anchor: *"Built by the team that's shipped 800+ platforms in your vertical since 2015."* Vertical depth is the headline; AI is the offering.

> [!IMPORTANT] Keyword strategy
> Target **vertical + service combos**, not generic terms. "AI development agency" is dominated by IBM, Accenture, and Clutch listings. "AI dispatch optimization for ride-hailing platforms" has low competition and maps directly to Trioangle's moat. Every page owns one primary keyword and clusters secondary + long-tail around it.

> [!NOTE] AI Search (AEO/GEO) matters as much as Google
> Service ICP P5 buyers increasingly research via ChatGPT, Perplexity, and Gemini. Pages should be structured for AI search summaries — specific outcomes, named verticals, metric-backed claims. See [[SEO-AEO-GEO-Prompt-Library]].


## Page Architecture

```
trioangle.com/
├── /ai-engineering/                — AI Engineering Hub (broad AI engineering terms, links to all service pages)
│   ├── rag-knowledge-assistant         — RAG Knowledge Assistant
│   ├── ai-customer-support-bot         — AI Customer Support Bot
│   ├── whatsapp-ai-automation          — WhatsApp AI Automation
│   ├── ai-agents-automation            — AI Agents & Workflow Automation
│   ├── ai-content-moderation           — AI Content Moderation
│   ├── ai-search-upgrade               — AI Search Upgrade
│   └── voice-ai-development            — Voice AI Development
└── /industries/                    — Industry pages (AI-first multi-service: AI primary CTA + custom dev + white-label solutions)
    ├── ride-hailing      — Ride-Hailing & Transport (AI primary · app development · white-label solutions)
    ├── delivery          — Delivery & Logistics (AI primary · app development · white-label solutions)
    ├── marketplace                 — Marketplace & Commerce (AI primary · app development · white-label solutions)
    ├── home-services     — On-Demand Home Services (AI primary · app development · white-label solutions)
    ├── ecommerce                   — E-Commerce Platforms (AI primary · app development · white-label solutions)
    ├── super-app                   — Multi-Service / Super App (AI primary · app development · white-label solutions)
    ├── travel          — Travel & Hospitality (AI primary · app development · white-label solutions)
    ├── social-media        — Social & Entertainment (AI primary · app development · white-label solutions)
    └── education                   — EdTech Platforms (AI primary · app development · white-label solutions)
```

**Why this split:** `/ai-engineering/[service]` pages are organized by AI service type (RAG, agents, voice, etc.) and target buyers who already know what service they need. `/industries/` pages are organized by vertical and serve all buyer entry points — AI features for established operators (primary pitch), custom app development for platform builders, and white-label solutions for fast-launch buyers. AI is the primary CTA on every industry page; dev and product keywords broaden the top of funnel and feed into the appropriate downstream pipeline.

**Build priority: Vertical pages first → AI service pages → Hub last.**
Vertical pages rank across the widest keyword surface (AI + dev + product) and funnel into all three pipelines.


## Buyer Routing & Qualification

> [!IMPORTANT] Industry pages serve three buyer intents — route each to its own CTA
> A single AI-only CTA on a page that also targets dev and white-label keywords burns 2/3 of the SEO traffic. Each industry page must surface three distinct CTAs, ordered to match buyer intent.

**CTA structure per industry page:**

| Buyer | Keyword intent | CTA | Funnel destination |
|---|---|---|---|
| 🥇 **AI Buyer (P5 — primary)** | `AI for [vertical]`, `AI [feature] for [vertical]` | **Book a Free AI Readiness Call** → AI Audit Sprint ($1.5k–$4k, 2-week paid pre-engagement) | Service ICP — AI track |
| 🥈 **Custom Dev Buyer (P1/P2 — opportunistic)** | `[vertical] app development company`, `custom [vertical] software` | **Book a Discovery Sprint** ($2k–$4k, 2-week paid scoping for platform rebuild/extension) | Service ICP — Dev track |
| 🥉 **White-Label Buyer (Product ICP)** | `white-label [vertical] solution` | **View white-label products & pricing** → product catalog | Product ICP (out of Service ICP scope — route, don't sell) |

**Placement order on page:**
1. Hero CTA = AI Buyer (primary pitch, AI-first positioning)
2. Mid-page section = "Already have a working platform? Explore AI features" — repeats AI CTA
3. Lower section = "Building from scratch?" — routes Custom Dev or White-Label depending on copy variant
4. Footer = all three CTAs visible

**Qualification filter (mandatory copy block on every industry page):**

> *"Built for established platform operators with active users and revenue traction. If you're pre-launch or pre-revenue, our [white-label product line](/) is a better fit."*

This filter sits near the AI CTA. It pre-qualifies AI Readiness Call bookings to $1M+ ARR / 12mo+ operational buyers per the ICP Existing-Operator Filter, and routes pre-traction buyers to the Product ICP without rejecting them.

**Trigger language (use in headlines and CTA copy where relevant):**

| Trigger | Use in copy |
|---|---|
| Vertical AI competitor moved | *"Your competitor just shipped AI dispatch. Here's how fast you can too."* |
| Expansion / scaling event | *"Expanding to a new city, country, or vertical? AI before the scale-up, not after."* |
| Series C+ growth round | *"Just raised? Board will ask for an AI roadmap within 90 days. Audit Sprint = the answer."* |
| Platform outage from manual ops | *"Manual dispatch breaking under load? AI dispatch ships in 4–8 weeks."* |

Triggers go in hero subheads, mid-page section openers, and outbound email subject lines that link to these pages. Pages without trigger language explain *what* — pages with trigger language explain *why now*.

**P3 (Enterprise) and P4 (MENA) inbound routing:**

These two personas are **channel-partner only** per Service ICP — no direct outbound until the partner program is live. But they will land on these pages from Clutch, conference search, and referrals. Do not filter them out at the page level — handle the inbound on the AI Readiness Call:

| Inbound signal | Action |
|---|---|
| Enterprise email domain + RFP language in form fill | Route to enterprise channel partner; offer AI Audit Sprint inside the RFP |
| UAE / KSA / Qatar email or phone + Arabic name | Route to MENA channel partner or family-network introducer; offer AI Audit Sprint as relationship-demonstration deliverable |
| Standard inbound (P1/P2/P5) | Run AI Readiness Call directly |

The page copy stays unchanged. The qualification happens in the booking form and the first call, not on the page.


## Build Sequence & Keyword Map

### Priority 1 — /industries/ride-hailing

**Headline:** *AI dispatch, dynamic pricing, and fleet optimization — built by engineers who've shipped 100+ ride-hailing and transport platforms*
**Trigger subhead:** *A vertical competitor just shipped AI dispatch or dynamic pricing. Match it in 4–8 weeks — without a 6-month ML hire.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for ride-hailing platforms` |
| Secondary | `AI dispatch optimization` · `ride-hailing AI development` · `intelligent dispatch system` · `AI fleet management` · `transport AI development` |
| Long-tail | `AI dynamic pricing for ride-hailing` · `AI driver matching optimization` · `AI surge pricing development` · `ride-hailing demand forecasting AI` · `AI for taxi app` · `AI fleet optimization` · `AI for logistics dispatch` · `fleet utilization AI` · `predictive maintenance AI for fleets` |
| Feature-level | `intelligent driver dispatch AI` · `dynamic surge pricing engine` · `ETA prediction AI` · `driver behavior scoring AI` · `AI towing dispatch` · `on-demand logistics dispatch AI` |
| Dev & Product | `ride-hailing app development` · `ride-hailing app development company` · `taxi app development` · `cab booking app development` · `white-label ride-hailing solution` · `white-label taxi app` · `ride-hailing software development` · `fleet management app development` · `transport app development company` · `white-label fleet management software` |


### Priority 2 — /industries/delivery

**Headline:** *AI route optimization, demand forecasting, and order matching — from engineers who've delivered 100+ delivery platforms*
**Trigger subhead:** *AI route optimization is table stakes in 2026 — and manual dispatch breaks at scale. Ship AI route + demand forecasting in 4–8 weeks.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for delivery platforms` |
| Secondary | `AI for logistics platforms` · `AI for food delivery apps` · `AI demand forecasting logistics` |
| Long-tail | `AI route optimization for delivery` · `delivery demand forecasting AI` · `AI driver allocation system` · `AI for last-mile delivery` · `logistics AI development` |
| Feature-level | `AI order batching` · `multi-stop route optimization AI` · `delivery ETA prediction` |
| Dev & Product | `food delivery app development` · `food delivery app development company` · `delivery app development` · `grocery delivery app development` · `white-label food delivery solution` · `white-label delivery app` · `logistics app development` · `last-mile delivery software development` · `on-demand delivery app development company` · `white-label logistics platform` |


### Priority 3 — /industries/marketplace

**Headline:** *AI fraud detection, personalized recommendations, and search — built for marketplace commission logic we already know*
**Trigger subhead:** *Fraud, fake listings, and weak search are eating your GMV. AI fraud detection + semantic search ship in 4–8 weeks.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for marketplace platforms` |
| Secondary | `AI fraud detection marketplace` · `marketplace AI development` · `AI recommendation engine marketplace` · `AI for real estate platforms` · `AI for classified platforms` |
| Long-tail | `AI-powered marketplace search` · `seller ranking AI` · `marketplace fraud prevention AI` · `AI for multi-vendor platform` · `marketplace personalization AI` · `AI listing fraud detection` · `property search AI` · `real estate recommendation AI` · `AI for peer-to-peer marketplaces` · `AI for classified ads platform` |
| Feature-level | `AI commission fraud detection` · `buyer intent prediction` · `AI search ranking marketplace` · `AI property valuation` · `duplicate listing detection AI` |
| Dev & Product | `marketplace app development` · `marketplace app development company` · `multi-vendor marketplace development` · `online marketplace development` · `classified ads app development` · `real estate app development` · `white-label marketplace solution` · `white-label classified ads platform` · `marketplace software development` · `peer-to-peer marketplace development` |


### Priority 4 — /industries/home-services

**Headline:** *AI booking assistant, smart scheduling, and automated support — for on-demand platforms we've built 100+ times*
**Trigger subhead:** *Manual scheduling can't scale past 50 providers. AI matching, scheduling, and conversational booking ship in 4–8 weeks.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for on-demand apps` |
| Secondary | `AI for home services platforms` · `on-demand app AI integration` · `AI for service marketplace` |
| Long-tail | `AI booking assistant development` · `smart provider matching AI` · `AI scheduling for home services` · `on-demand app chatbot` · `AI for cleaning app` |
| Feature-level | `intelligent provider matching` · `AI job assignment` · `automated booking confirmation AI` |
| Dev & Product | `on-demand app development` · `on-demand app development company` · `home services app development` · `handyman app development` · `service marketplace app development` · `white-label on-demand service app` · `white-label home services platform` · `on-demand service marketplace development` · `cleaning app development` · `beauty services app development` |


### Priority 5 — /ai-engineering/rag-knowledge-assistant

**Headline:** *RAG knowledge assistants that actually know your platform's data — not generic chatbots*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint → fixed-price RAG build
- 🥈 Defined scope → *Request a RAG scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `RAG implementation service` |
| Secondary | `retrieval augmented generation development` · `RAG development company` · `knowledge assistant AI` |
| Long-tail | `RAG for platform operators` · `custom RAG pipeline development` · `LLM integration service` · `RAG chatbot development` · `enterprise RAG implementation` · `document Q&A chatbot development` |
| Feature-level | `vector database integration` · `pgvector implementation` · `RAG pipeline for SaaS` · `hybrid search implementation` · `embedding pipeline development` · `LlamaIndex integration` · `BM25 retrieval` · `reranking AI` |


### Priority 6 — /ai-engineering/ai-customer-support-bot

**Headline:** *AI customer support bots that resolve tickets without human handoff — trained on your platform's actual data*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `AI customer support bot development` |
| Secondary | `AI chatbot development` · `customer support automation AI` · `AI helpdesk bot` |
| Long-tail | `AI support bot for marketplace` · `AI customer support for platforms` · `automated ticket resolution AI` · `AI for customer service platform` · `chatbot integration service` |
| Feature-level | `AI ticket deflection` · `live handoff AI bot` · `multilingual support bot` |


### Priority 7 — /ai-engineering/ai-agents-automation

**Headline:** *AI agents that do the work — not just answer questions. Booking, dispatch, support, and ops workflows automated end-to-end.*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `AI agent development` |
| Secondary | `agentic AI development` · `AI workflow automation` · `multi-agent system development` |
| Long-tail | `LangGraph development` · `AI task automation service` · `custom AI agent for platforms` · `AI process automation` · `AI agent integration service` · `ReAct agent development` |
| Feature-level | `LangGraph workflow` · `multi-agent orchestration` · `tool use AI` · `AI agent with memory` · `human-in-the-loop AI` · `MCP integration` |


### Priority 8 — /industries/ecommerce

**Headline:** *AI recommendations, search, and fraud detection — embedded into your existing commerce platform*
**Trigger subhead:** *Conversion stalled? Search and recommendations are the conversion floor. AI ships in 4–8 weeks.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for e-commerce platforms` |
| Secondary | `AI product recommendations` · `e-commerce AI development` · `AI for online marketplace` |
| Long-tail | `AI-powered product search` · `e-commerce personalization AI` · `AI fraud detection e-commerce` · `AI for multi-vendor ecommerce` · `recommendation engine development` |
| Feature-level | `collaborative filtering AI` · `semantic product search` · `purchase intent prediction` |
| Dev & Product | `ecommerce app development` · `ecommerce app development company` · `multi-vendor ecommerce development` · `online shopping app development` · `ecommerce website development company` · `white-label ecommerce platform` · `white-label multi-vendor store` · `B2B ecommerce development` · `ecommerce software development` · `custom ecommerce development` |


### Priority 9 — /ai-engineering/ (Hub)

**Headline:** *Productized AI engineering for marketplace, on-demand, and platform operators — built by the team that's shipped 800+ platforms since 2015 across 9 verticals*
**CTA:** Free AI Readiness Call (1-hour, no pitch deck)

| Type | Keywords |
|---|---|
| Primary | `AI engineering services` |
| Secondary | `AI feature development` · `AI integration services` · `custom AI development` · `AI development agency` |
| Long-tail | `hire AI development team` · `outsource AI development` · `AI feature development agency` · `productized AI services` · `domain-specific AI development` · `AI integration for SaaS platforms` · `AI engineering for platform operators` · `LLM-powered application development` · `agentic AI development` · `production AI deployment` |
| Buyer-intent | `AI development company for platform businesses` · `embed AI into existing platform` · `add AI features to existing app` |


### Priority 10 — /ai-engineering/whatsapp-ai-automation

**Headline:** *WhatsApp AI that handles bookings, support, and order updates — without a human in the loop*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `WhatsApp AI automation` |
| Secondary | `WhatsApp chatbot development` · `WhatsApp bot for business` · `WhatsApp Business API integration` |
| Long-tail | `WhatsApp AI for platforms` · `WhatsApp order update automation` · `WhatsApp booking bot` · `WhatsApp support bot development` · `conversational AI for WhatsApp` |
| Feature-level | `WhatsApp Business API bot` · `WhatsApp flow automation` · `multi-language WhatsApp bot` |


### Priority 11 — /ai-engineering/ai-content-moderation

**Headline:** *AI content moderation that scales with your platform — without false positives tanking your GMV*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `AI content moderation service` |
| Secondary | `automated content moderation AI` · `automated moderation system` · `AI moderation platform` |
| Long-tail | `AI moderation for marketplace` · `AI moderation for social platforms` · `real-time content moderation AI` · `AI listing moderation` · `UGC moderation AI` |
| Feature-level | `image moderation AI` · `text toxicity detection` · `AI false positive reduction` |


### Priority 12 — /ai-engineering/ai-search-upgrade

**Headline:** *Semantic search that understands what your users actually mean — not just what they typed*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `AI search integration` |
| Secondary | `semantic search implementation` · `AI-powered search platform` · `vector search development` |
| Long-tail | `semantic search for marketplace` · `AI search for platforms` · `vector search implementation` · `embedding-based search development` · `AI search upgrade for SaaS` |
| Feature-level | `pgvector search implementation` · `hybrid search AI` · `BM25 hybrid search` · `query intent understanding` · `reranking search results AI` |


### Priority 13 — /ai-engineering/voice-ai-development

**Headline:** *Voice AI that handles calls, bookings, and support — integrated into your existing platform, not bolted on*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `voice AI development` |
| Secondary | `conversational AI development` · `voice AI integration service` · `AI voice bot for business` |
| Long-tail | `voice assistant development for platforms` · `voice AI for on-demand apps` · `AI phone support bot` · `Vapi integration service` · `Retell AI development` · `voice AI pipeline development` |
| Feature-level | `voice AI for booking` · `IVR replacement AI` · `real-time voice AI` · `voice agent with tool use` |


### Priority 14 — /industries/super-app

**Headline:** *AI orchestration across rides, food delivery, and services — built by the team that's shipped multi-service platforms since 2015*
**Trigger subhead:** *Adding a third or fourth service line? Get AI orchestration in before the rollout, not after.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for super app platforms` |
| Secondary | `multi-service app AI development` · `unified platform AI development` · `AI for on-demand super apps` |
| Long-tail | `AI for multi-service platforms` · `AI service orchestration` · `super app AI integration` · `AI for ride-food-services platform` · `multi-vertical demand forecasting AI` |
| Feature-level | `cross-service AI recommendations` · `unified dispatch AI` · `multi-service demand prediction` · `AI for super app` |
| Dev & Product | `super app development` · `super app development company` · `multi-service platform development` · `multi-service app development` · `on-demand super app development` · `white-label super app solution` · `white-label multi-service platform` · `ride-food-services app development` · `all-in-one on-demand app development` · `super app software development` |


### Priority 15–17 — Remaining Vertical Pages

> [!WARNING] Limited AI case studies in these verticals
> AI engineering production cases exist for ride-hailing, logistics, marketplace, home services, and delivery. Travel, social/entertainment, and education are platform-delivery verticals where AI feature work is in early development. Copy for these pages must lead with **platform delivery depth** ("engineers who've shipped 40+ travel platforms") — not AI delivery history. Do not make AI outcome claims (lift %, fraud reduction) for these verticals until production cases exist.

> [!IMPORTANT] Keyword status for these three pages
> AI keyword clusters in the tables below are split into two states. **Live now:** Dev & Product rows (app development, white-label — backed by 800+ delivery history). **Aspirational (gated on case studies):** Primary / Secondary / Long-tail / Feature-level AI rows — **do not target in active SEO or paid until production cases are signed and metric-backed**. Build the pages with platform-delivery framing first; layer in AI keywords as cases land. The aspirational rows live in the plan so the keyword universe is documented, not so the pages immediately rank for them.

#### /industries/travel

**Headline:** *Travel and hospitality platforms, shipped by engineers who've delivered 40+ booking, rental, and OTA products since 2015. AI booking and demand forecasting on the roadmap.*
**Trigger subhead:** *Thinking about AI in your platform? Start with an honest AI Readiness Call — we'll tell you what's worth building vs hype.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for travel platforms` |
| Secondary | `AI booking assistant development` · `travel AI development` · `AI for hospitality platforms` · `AI for rental platforms` |
| Long-tail | `AI for hotel booking platform` · `travel demand forecasting AI` · `AI for OTA platform` · `conversational booking AI` · `AI for short-term rental platforms` · `AI availability engine` · `AI pricing for vacation rentals` |
| Feature-level | `AI booking confirmation bot` · `dynamic pricing AI for rentals` · `demand forecasting for hotels` |
| Dev & Product | `travel app development` · `travel app development company` · `hotel booking app development` · `vacation rental app development` · `OTA platform development` · `white-label travel booking platform` · `white-label rental platform` · `peer-to-peer rental platform development` · `travel portal development` · `hospitality software development` |

#### /industries/social-media

**Headline:** *Social, video, and dating platforms — shipped by engineers who've delivered 20+ since 2015. AI content moderation and feed ranking on the roadmap.*
**Trigger subhead:** *Thinking about AI in your platform? Start with an honest AI Readiness Call — we'll tell you what's worth building vs hype.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for social platforms` |
| Secondary | `AI content moderation service` · `social platform AI development` · `AI for video platforms` · `AI for dating apps` |
| Long-tail | `AI feed ranking for social apps` · `content recommendation AI` · `AI for creator platforms` · `AI moderation for UGC platforms` · `AI for short-video platforms` · `AI matchmaking algorithm` |
| Feature-level | `AI toxicity detection` · `short video feed ranking AI` · `AI profile matching` · `real-time content moderation AI` |
| Dev & Product | `social media app development` · `social media app development company` · `video streaming app development` · `short video app development` · `dating app development` · `dating app development company` · `white-label social media platform` · `white-label dating app` · `live streaming app development` · `UGC platform development` |

#### /industries/education

**Headline:** *Edtech and e-learning platforms — shipped by engineers who've delivered 10+ since 2015. AI tutoring and adaptive learning on the roadmap.*
**Trigger subhead:** *Thinking about AI in your platform? Start with an honest AI Readiness Call — we'll tell you what's worth building vs hype.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for edtech platforms` |
| Secondary | `AI for education apps` · `e-learning AI development` · `AI for LMS platforms` |
| Long-tail | `AI tutoring system development` · `adaptive learning AI` · `conversational AI for education` · `AI for online course platforms` · `AI quiz generation` · `AI course recommendation` |
| Feature-level | `AI learning path personalization` · `AI knowledge gap detection` · `conversational AI tutor` |
| Dev & Product | `edtech app development` · `edtech app development company` · `e-learning app development` · `LMS development` · `online learning platform development` · `white-label e-learning platform` · `white-label LMS solution` · `online course platform development` · `e-learning software development` · `education app development company` |


## Proof-Point Discipline

> [!WARNING]
> Use "800+ platform deliveries since 2015" to establish **domain credibility** — not as an AI delivery claim. The AI feature delivery count is a separate, smaller number that should be tracked and grown as a standalone metric. Avoid "we've built AI features in 800+ platforms" — that conflates platform delivery with AI delivery and misrepresents the AI track record. Use: *"Built by the team that shipped 800+ platforms in your vertical."* See [[Trioangle Service ICP]] — Proof-Point Caveat.
