---
type: concept
title: "Trioangle Landing Page Plan"
status: current
created: 2026-05-06
updated: 2026-05-21
source: ".raw/Trioangle/sales-marketing/Service/Trioangle Service LP Plan.md"
tags:
  - concept
  - trioangle
  - marketing
  - seo
  - landing-pages
  - ai-pivot
related:
  - "[[Trioangle 2.0 AI Pivot Plan]]"
  - "[[Trioangle Service ICP]]"
  - "[[Trioangle Growth Plan]]"
  - "[[Trioangle AI Delivery Kit]]"
  - "[[Trioangle Content Strategy]]"
---

# Trioangle Landing Page Plan

Site architecture and SEO keyword strategy for Trioangle's AI services landing pages. Targets **Service ICP Persona 5** — established platform operators in Trioangle's core verticals who need AI features embedded into their existing platform.

Positioning anchor: *"Built by the team that's shipped 800+ platforms in your vertical since 2015."* Vertical depth is the headline; AI is the offering.

> [!IMPORTANT] Keyword strategy
> Target **vertical + service combos**, not generic terms. "AI development agency" is dominated by IBM, Accenture, and Clutch listings. "AI dispatch optimization for ride-hailing platforms" has low competition and maps directly to Trioangle's moat. Every page owns one primary keyword and clusters secondary + long-tail around it.

> [!NOTE] AI Search (AEO/GEO) matters as much as Google
> Service ICP P5 buyers increasingly research via ChatGPT, Perplexity, and Gemini. Pages should be structured for AI search summaries — specific outcomes, named verticals, metric-backed claims. See [[SEO-AEO-GEO-Prompt-Library]].

> [!IMPORTANT] Priority order is demand-based
> Priorities are ranked by estimated demand (commercial search intent volume × Trioangle delivery credibility). Validate against actual search volume data (Ahrefs / SEMrush / Google Keyword Planner) before locking the build sprint.


## Page Architecture

```
trioangle.com/
├── /ai-engineering/                — AI Engineering Hub (broad AI engineering terms, links to all service pages)
│   ├── rag-knowledge-assistant         — RAG Knowledge Assistant
│   ├── ai-agents-automation            — AI Agents & Workflow Automation
│   ├── ai-customer-support-bot         — AI Customer Support Bot
│   ├── whatsapp-ai-automation          — WhatsApp AI Automation
│   ├── ai-search-upgrade               — AI Search Upgrade
│   ├── voice-ai-development            — Voice AI Development
│   └── ai-content-moderation           — AI Content Moderation
└── /industries/                    — Industry pages (AI primary CTA + custom dev + white-label solutions)
    │   ── Tier 1 (high demand + high credibility) ──
    ├── ride-hailing                — Ride-Hailing & Transport
    ├── on-demand                   — On-Demand Umbrella (broad on-demand search; funnels to ride-hailing / delivery / home-services)
    ├── delivery                    — Delivery & Logistics
    ├── marketplace                 — Marketplace & Commerce
    ├── home-services               — Home Services & Local On-Demand
    ├── rentals                     — Rental Marketplaces (car / boat / equipment / gear / fashion / vacation)
    │   ── Tier 2 (high demand, mixed credibility) ──
    ├── super-app                   — Multi-Service / Super App
    └── ecommerce                   — E-Commerce Platforms
```

**Why this split:** `/ai-engineering/[service]` pages are organized by AI service type (RAG, agents, voice, etc.) and target buyers who already know what service they need. `/industries/` pages are organized by vertical and serve all buyer entry points — AI features for established operators (primary pitch), custom app development for platform builders, and white-label solutions for fast-launch buyers. AI is the primary CTA on every industry page; dev and product keywords broaden the top of funnel and feed into the appropriate downstream pipeline.

**Build sequence:** Industry pages by demand (Tier 1 → Tier 2) → AI service pages → Hub last.
Industries are front-loaded because they match the ICP (P5 vertical operators) more directly than horizontal AI service pages. AI service pages capture top-of-funnel "I know what I want" buyers and feed all industry pipelines via internal linking. Several additional verticals (education / dating / short-video / social-media / video-streaming / etc.) were considered and dropped — see "Out of SEO Scope" section for rationale.


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

> *"Built for established platform operators with active users and revenue traction. If you're pre-launch or pre-revenue, our white-label products are a better fit."*

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

### Tier 1 — Industry Pages (highest demand + credibility)

---

### Priority 1 — /industries/ride-hailing

**Headline:** *AI dispatch, dynamic pricing, and fleet optimization — built by engineers who've shipped ride-hailing and transport platforms since 2015*
**Trigger subhead:** *A vertical competitor just shipped AI dispatch or dynamic pricing. Match it in 4–8 weeks — without a 6-month ML hire.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for ride-hailing platforms` |
| Secondary | `AI dispatch optimization for ride-hailing` · `ride-hailing AI development` · `intelligent dispatch system` · `transport AI development` |
| Long-tail | `AI dynamic pricing for ride-hailing` · `AI driver matching optimization` · `AI surge pricing development` · `ride-hailing demand forecasting AI` · `AI for taxi app` · `AI for cab booking platforms` |
| Feature-level | `intelligent driver dispatch AI` · `dynamic surge pricing engine` · `ETA prediction AI` · `driver behavior scoring AI` · `AI towing dispatch` |
| Dev & Product | `ride-hailing app development` · `ride-hailing app development company` · `taxi app development` · `cab booking app development` · `white-label ride-hailing solution` · `white-label taxi app` · `ride-hailing software development` · `transport app development company` |

> [!NOTE] Dropped from SEO scope
> Fleet management and B2B logistics dispatch keywords (e.g. `AI fleet management`, `fleet management app development`, `predictive maintenance AI for fleets`) are out of SEO scope — Trioangle's delivery history is consumer-facing ride-hailing, not B2B fleet ops. Targeting these without credible domain depth would produce thin content that won't rank.

---

### Priority 2 — /industries/on-demand

**Positioning:** Umbrella page. Funnels into ride-hailing, delivery, and home-services sub-pages via internal links. Owns broad on-demand search volume that none of the sub-vertical pages can rank for alone. **Tier 1 placement** because `on-demand app development` is one of the highest-volume terms in Trioangle's historical keyword universe.
**Headline:** *AI for on-demand platforms — ride-hailing, delivery, home services, and beyond. Built by the team that's shipped on-demand apps since 2015.*
**Trigger subhead:** *Manual operations cap your scale. AI matching, dispatch, and scheduling are the difference between $1M and $10M ARR.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established on-demand operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for on-demand platforms` |
| Secondary | `AI for on-demand apps` · `on-demand app AI integration` · `on-demand AI development` |
| Long-tail | `on-demand app chatbot` · `AI for on-demand marketplace` · `AI for on-demand service app` · `intelligent matching for on-demand` · `AI for on-demand startups` |
| Feature-level | `AI dispatch for on-demand` · `automated booking AI` · `AI scheduling for on-demand` |
| Dev & Product | `on-demand app development` · `on-demand app development company` · `on-demand service marketplace development` · `white-label on-demand service app` · `on-demand mobile app development` · `on-demand software development company` |

---

### Priority 3 — /industries/delivery

**Headline:** *AI route optimization, demand forecasting, and order matching — from engineers who've delivered delivery and logistics platforms since 2015*
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

---

### Priority 4 — /industries/marketplace

**Headline:** *AI fraud detection, personalized recommendations, and search — built by engineers who've shipped marketplace platforms since 2015*
**Trigger subhead:** *Fraud, fake listings, and weak search are eating your GMV. AI fraud detection + semantic search ship in 4–8 weeks.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for marketplace platforms` |
| Secondary | `AI fraud detection marketplace` · `marketplace AI development` · `AI recommendation engine marketplace` · `AI for classified platforms` |
| Long-tail | `AI-powered marketplace search` · `seller ranking AI` · `marketplace fraud prevention AI` · `AI for multi-vendor platform` · `marketplace personalization AI` · `AI listing fraud detection` · `AI for peer-to-peer marketplaces` · `AI for classified ads platform` |
| Feature-level | `AI commission fraud detection` · `buyer intent prediction` · `AI search ranking marketplace` · `duplicate listing detection AI` |
| Dev & Product | `marketplace app development` · `marketplace app development company` · `multi-vendor marketplace development` · `multi-vendor app development` · `online marketplace development` · `classified ads app development` · `white-label marketplace solution` · `white-label multi-vendor store` · `white-label classified ads platform` · `marketplace software development` · `peer-to-peer marketplace development` |

> [!NOTE] Dropped from SEO scope
> Real estate / proptech keywords (e.g. `AI for real estate platforms`, `property search AI`, `real estate app development`) are out of SEO scope — proptech is a distinct vertical (MLS integration, mortgage matching, property valuation) where Trioangle has no credible delivery history. Targeting these would produce thin content that won't rank.

---

### Priority 5 — /industries/home-services

**Headline:** *AI booking assistant, smart scheduling, and automated support — for home services platforms we've built since 2015*
**Trigger subhead:** *Manual scheduling can't scale past 50 providers. AI matching, scheduling, and conversational booking ship in 4–8 weeks.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for home services platforms` |
| Secondary | `AI for service marketplace` · `home services AI development` · `AI for cleaning services platforms` |
| Long-tail | `AI booking assistant for home services` · `smart provider matching AI` · `AI scheduling for home services` · `AI for cleaning app` · `AI for handyman apps` |
| Feature-level | `intelligent provider matching` · `AI job assignment` · `automated booking confirmation AI` |
| Dev & Product | `home services app development` · `home services app development company` · `handyman app development` · `service marketplace app development` · `white-label home services platform` · `cleaning app development` · `beauty services app development` · `salon app development` · `appliance repair app development` |

> [!NOTE] Cross-link to umbrella
> Broad on-demand keywords (`AI for on-demand apps`, `on-demand app development`) live on [`/industries/on-demand`](#priority-2--industrieson-demand) (Priority 2). The umbrella page internally funnels to this page for home-services-specific intent.

---

### Priority 6 — /industries/rentals

**Positioning:** Rental marketplace umbrella covering **vacation rental, car, boat, equipment, gear, fashion, and furniture** rentals. **Tier 1 placement reflects strong delivery history** — most of Trioangle's "40+ travel deliveries" are actually vacation rental + car rental P2P platforms shipped since 2015.

**Headline:** *AI for rental marketplaces — vacation rental, car, boat, equipment, and beyond. Built by the team that's shipped peer-to-peer rental platforms since 2015.*
**Trigger subhead:** *Availability conflicts, manual pricing, and weak search are eating your booking conversion. AI dynamic pricing and semantic search ship in 4–8 weeks.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established rental marketplace operators with active inventory and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for rental platforms` |
| Secondary | `AI for rental marketplaces` · `rental marketplace AI development` · `peer-to-peer rental AI` · `AI for vacation rental platforms` |
| Long-tail | `AI for car rental platforms` · `AI for boat rental platforms` · `AI for equipment rental platforms` · `AI for fashion rental platforms` · `AI for gear rental platforms` · `AI for furniture rental platforms` · `AI for short-term rental platforms` · `AI dynamic pricing for rentals` · `AI pricing for vacation rentals` · `AI availability optimization for rentals` |
| Feature-level | `AI rental booking optimization` · `AI rental fraud detection` · `AI rental damage assessment` · `AI rental recommendation engine` · `dynamic pricing AI for vacation rentals` |
| Dev & Product | `vacation rental app development` · `car rental app development` · `boat rental app development` · `equipment rental app development` · `gear rental app development` · `fashion rental app development` · `furniture rental app development` · `peer-to-peer rental platform development` · `rental marketplace development` · `white-label rental platform` · `white-label vacation rental platform` · `white-label car rental software` · `white-label boat rental platform` · `white-label equipment rental platform` |

> [!NOTE] Travel / hotel / OTA dropped from SEO scope
> Hotel booking, OTA platforms, and hospitality software keywords (e.g. `hotel booking app development`, `OTA platform development`, `travel portal development`, `hospitality software development`) are **out of SEO scope** — Trioangle's actual travel delivery history is mostly vacation rental + car rental P2P platforms (covered here), with only minimal hotel booking history. Targeting hotel / OTA keywords would produce thin content that won't rank against dedicated travel-tech competitors. Vacation rental and short-term rental search intent is captured here.


### Tier 2 — Industry Pages (high demand, mixed credibility)

---

### Priority 7 — /industries/super-app

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
| Feature-level | `cross-service AI recommendations` · `unified dispatch AI` · `multi-service demand prediction` |
| Dev & Product | `super app development` · `super app development company` · `multi-service platform development` · `multi-service app development` · `on-demand super app development` · `white-label super app solution` · `white-label multi-service platform` · `ride-food-services app development` · `all-in-one on-demand app development` · `super app software development` |

---

### Priority 8 — /industries/ecommerce

**Headline:** *AI recommendations, search, and fraud detection — built by engineers who've shipped ecommerce platforms since 2015*
**Trigger subhead:** *Conversion stalled? Search and recommendations are the conversion floor. AI ships in 4–8 weeks.*
**CTAs:**
- 🥇 AI Buyer (primary) → *Book a Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k)
- 🥈 Custom Dev Buyer → *Book a Discovery Sprint* ($2k–$4k scoping)
- 🥉 White-Label Buyer → *View white-label products & pricing* (routes to Product catalog)

**Qualification:** *Built for established platform operators with active users and revenue traction. Pre-launch / pre-revenue → see our white-label products instead.*

| Type | Keywords |
|---|---|
| Primary | `AI for ecommerce platforms` |
| Secondary | `AI product recommendations` · `ecommerce AI development` · `AI for retail platforms` |
| Long-tail | `AI-powered product search` · `ecommerce personalization AI` · `ecommerce fraud detection AI` · `AI for multi-vendor ecommerce` · `product recommendation engine development` |
| Feature-level | `collaborative filtering AI` · `semantic product search` · `purchase intent prediction` |
| Dev & Product | `ecommerce app development` · `ecommerce app development company` · `multi-vendor ecommerce development` · `online shopping app development` · `ecommerce website development company` · `white-label ecommerce platform` · `B2B ecommerce development` · `ecommerce software development` · `custom ecommerce development` |

> [!NOTE] Scope boundary with marketplace
> Generic multi-vendor terms (`multi-vendor app development`, `white-label multi-vendor store`) live on [`/industries/marketplace`](#priority-4--industriesmarketplace) (Priority 4) — multi-vendor IS the marketplace business model. Ecommerce keeps `multi-vendor ecommerce development` (retail store with multiple vendors, single-brand-ish), marketplace owns Etsy/eBay/Amazon Marketplace-style multi-vendor.


### AI Service Pages (cross-vertical productized services)

---

### Priority 9 — /ai-engineering/rag-knowledge-assistant

**Headline:** *RAG knowledge assistants that actually know your platform's data — not generic chatbots*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k) → fixed-price RAG build
- 🥈 Defined scope → *Request a RAG scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `RAG implementation service` |
| Secondary | `retrieval augmented generation development` · `RAG development company` · `knowledge assistant AI` |
| Long-tail | `RAG for platform operators` · `custom RAG pipeline development` · `LLM integration service` · `RAG chatbot development` · `enterprise RAG implementation` · `document Q&A chatbot development` |
| Feature-level | `vector database integration` · `pgvector implementation` · `RAG pipeline for SaaS` · `hybrid search implementation` · `embedding pipeline development` · `LlamaIndex integration` · `BM25 retrieval` · `reranking AI` |

---

### Priority 10 — /ai-engineering/ai-agents-automation

**Headline:** *AI agents that do the work — not just answer questions. Booking, dispatch, support, and ops workflows automated end-to-end.*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k) → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `AI agent development` |
| Secondary | `agentic AI development` · `AI workflow automation` · `multi-agent system development` |
| Long-tail | `LangGraph development` · `AI task automation service` · `custom AI agent for platforms` · `AI process automation` · `AI agent integration service` · `ReAct agent development` |
| Feature-level | `LangGraph workflow` · `multi-agent orchestration` · `tool use AI` · `AI agent with memory` · `human-in-the-loop AI` · `MCP integration` |

---

### Priority 11 — /ai-engineering/ai-customer-support-bot

**Headline:** *AI customer support bots that resolve tickets without human handoff — trained on your platform's actual data*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k) → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `AI customer support bot development` |
| Secondary | `AI chatbot development` · `customer support automation AI` · `AI helpdesk bot` |
| Long-tail | `AI support bot for marketplace` · `AI customer support for platforms` · `automated ticket resolution AI` · `AI for customer service platform` · `chatbot integration service` |
| Feature-level | `AI ticket deflection` · `live handoff AI bot` · `multilingual support bot` |

---

### Priority 12 — /ai-engineering/whatsapp-ai-automation

**Headline:** *WhatsApp AI that handles bookings, support, and order updates — without a human in the loop*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k) → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `WhatsApp AI automation` |
| Secondary | `WhatsApp chatbot development` · `WhatsApp bot for business` · `WhatsApp Business API integration` |
| Long-tail | `WhatsApp AI for platforms` · `WhatsApp order update automation` · `WhatsApp booking bot` · `WhatsApp support bot development` · `conversational AI for WhatsApp` |
| Feature-level | `WhatsApp Business API bot` · `WhatsApp flow automation` · `multi-language WhatsApp bot` |

---

### Priority 13 — /ai-engineering/ai-search-upgrade

**Headline:** *Semantic search that understands what your users actually mean — not just what they typed*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k) → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `AI search integration` |
| Secondary | `semantic search implementation` · `AI-powered search platform` · `vector search development` |
| Long-tail | `semantic search for marketplace` · `AI search for platforms` · `vector search implementation` · `embedding-based search development` · `AI search upgrade for SaaS` |
| Feature-level | `pgvector search implementation` · `hybrid search AI` · `BM25 hybrid search` · `query intent understanding` · `reranking search results AI` |

---

### Priority 14 — /ai-engineering/voice-ai-development

**Headline:** *Voice AI that handles calls, bookings, and support — integrated into your existing platform, not bolted on*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k) → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `voice AI development` |
| Secondary | `voice agent development` · `voice AI integration service` · `AI voice bot for business` |
| Long-tail | `voice assistant development for platforms` · `voice AI for on-demand apps` · `AI phone support bot` · `Vapi integration service` · `Retell AI development` · `voice AI pipeline development` |
| Feature-level | `voice AI for booking` · `IVR replacement AI` · `real-time voice AI` · `voice agent with tool use` |

---

### Priority 15 — /ai-engineering/ai-content-moderation

**Headline:** *AI content moderation that scales with your platform — without false positives tanking your GMV*
**CTAs:**
- 🥇 Default → *Free AI Readiness Call* → AI Audit Sprint ($1.5k–$4k) → fixed-price build
- 🥈 Defined scope → *Request a scoping call* (skip the audit if you already know what to build)

| Type | Keywords |
|---|---|
| Primary | `AI content moderation service` |
| Secondary | `automated content moderation AI` · `automated moderation system` · `AI moderation platform` |
| Long-tail | `AI moderation for marketplace` · `AI moderation for rental marketplaces` · `AI moderation for e-commerce reviews` · `real-time content moderation AI` · `AI listing moderation` |
| Feature-level | `image moderation AI` · `text toxicity detection` · `AI false positive reduction` |

---

### Priority 16 — /ai-engineering/ (Hub) — build last

**Headline:** *Productized AI engineering for marketplace, on-demand, and platform operators — built by the team that's shipped platforms across core verticals since 2015*
**CTA:** Free AI Readiness Call (1-hour, no pitch deck)

| Type | Keywords |
|---|---|
| Primary | `AI engineering services` |
| Secondary | `AI feature development` · `AI integration services` · `custom AI development` · `AI development agency` |
| Long-tail | `hire AI development team` · `outsource AI development` · `AI feature development agency` · `productized AI services` · `domain-specific AI development` · `AI integration for SaaS platforms` · `AI engineering for platform operators` · `LLM-powered application development` · `conversational AI development` · `production AI deployment` |
| Buyer-intent | `AI development company for platform businesses` · `embed AI into existing platform` · `add AI features to existing app` |

> [!IMPORTANT] Build the hub after the sub-pages
> The hub aggregates and links to all 7 AI service pages. Building it before the sub-pages means launching with broken internal links and no topical authority feeding in.


## Out of SEO Scope

Categories considered during planning and dropped, with rationale. Documented so future SEO / sales / content work has context for "why don't we have an X page?" — and so SEO experiments can revisit these decisions if the market shifts.

### Sub-cluster drops (called out inline on industry pages)

- **Fleet management / B2B logistics dispatch** — would have been split from ride-hailing. Out of scope: Trioangle's ride-hailing history is consumer-facing, not B2B fleet ops. See callout on Priority 1.
- **Real estate / proptech** — would have been split from marketplace. Out of scope: distinct vertical (MLS integration, mortgage matching, property valuation) where Trioangle has no credible delivery history. See callout on Priority 4.
- **Travel / hotel booking / OTA / hospitality** — was a separate page, removed. Trioangle's "40+ travel deliveries" are mostly vacation + car rental P2P platforms (absorbed into Priority 6 rentals page). Hotel booking delivery is minimal; targeting hotel / OTA / hospitality would produce thin content against specialized travel-tech competitors. See callout on Priority 6.

### Full vertical drops (considered as separate pages, rejected)

- **General social-media platforms** — keywords like `AI for social platforms`, `social media app development`, `UGC platform development`, `creator platform development`, `community app development`, `social network development`. Out of scope: saturated category, big-tech dominated; most "20+ social deliveries" are pre-traction clone work (Product ICP / P1-P2 buyers), not Service ICP P5 targets.
- **Video-streaming / OTT** (Netflix / Twitch / long-form video) — keywords like `AI for video streaming platforms`, `AI for OTT platforms`, `video streaming app development`, `live streaming app development`, `OTT app development`, `video on demand app development`, `white-label video streaming platform`. Out of scope: OTT/streaming dominated by specialized platforms (Vimeo OTT, Brightcove, Mux); Trioangle's streaming deliveries are mostly Product ICP / pre-traction clone work.
- **EdTech** (both consumer and B2B-narrowed) — keywords like `edtech app development`, `e-learning app development`, `online course platform development`, `AI for online course platforms`, `AI quiz generation`, `AI course recommendation`, plus the B2B sub-cluster (`AI for LMS platforms`, `LMS development`, `corporate training platform development`, `AI tutoring platform development`). Out of scope: consumer Q&A and Udemy-clone segments are being commoditized by free LLMs (Chegg-style erosion). Post-2022 bubble bust contracted the operator landscape. A B2B-narrowed version (LMS / corporate L&D / AI tutoring) was drafted but dropped to maintain Tier 1 + AI service page focus — incremental conversion didn't justify the build effort.
- **Dating** — keywords like `dating app development`, `dating app development company`, `white-label dating app`, `matchmaking app development`, `AI for dating apps`, `AI matchmaking algorithm`, `AI profile verification`. Out of scope: Match Group monopoly + Bumble dominate mass market; specialty/niche dating (religious, LGBTQ, regional) is a real segment but too small to justify a dedicated page. Most "15+ dating deliveries" are likely pre-traction clone work.
- **Short-video / TikTok-category** — keywords like `AI for short-video platforms`, `short video app development`, `short-form video app development`, `vertical video app development`, `UGC video platform development`. Out of scope: real demand and emerging-market geographic alignment, but small P5 pool (~20-30 operators globally); Trioangle's specific short-video delivery count unconfirmed; doesn't justify the build effort versus Tier 1 + AI service page concentration.

If any of these become high-conviction priorities later (signed case study, dedicated practice lead, market shift creating new P5 buyer pool), revisit and add as a new industry page. The keyword universes are documented here so the next planning cycle doesn't redo the research.


## Proof-Point Discipline

> [!WARNING]
> Use "800+ platform deliveries since 2015" to establish **domain credibility** — not as an AI delivery claim. The AI feature delivery count is a separate, smaller number that should be tracked and grown as a standalone metric. Avoid "we've built AI features in 800+ platforms" — that conflates platform delivery with AI delivery and misrepresents the AI track record. Use: *"Built by the team that shipped 800+ platforms in your vertical."* See [[Trioangle Service ICP]] — Proof-Point Caveat.
