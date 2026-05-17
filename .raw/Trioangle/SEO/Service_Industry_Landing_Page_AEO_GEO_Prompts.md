# AEO + GEO Prompts — Service Industry Landing Pages (Per-Vertical)

**Source ICP:** `Trioangle - ICP - Service.md` (AI-First) | **Generated:** May 2026

| Field | Value |
|-------|-------|
| **URL Pattern** | `trioangle.com/industries/[vertical-slug]` |
| **Pages Covered** | 9 verticals — one prompt set, substitute per-vertical variables |
| **Total Prompts** | 49 per page · LP only (36 AI-track + 11 Custom Dev + 2 White-Label routing) |
| **Priority Split** | 🔴 S0 ship-first (10 AI + 4 CD) · 🟡 S1 week 1 (10 AI + 3 CD) · 🟢 S2 week 2 (16 AI + 4 CD + 2 WL) |
| **Word Budget** | ~3,500–5,500 words per industry page (expanded for three-CTA coverage with full CD funnel) |
| **Relationship** | These pages sit under `trioangle.com/industries` (parent) and are internally linked from Pillar 7 blog articles for their vertical |
| **Track** | Track 2 — AI-First Service Engine ([[Trioangle Growth Plan]]) |

> [!NOTE] How to Use
> Substitute the per-vertical variables from the table below into every prompt. The result is a complete AEO/GEO prompt set for that industry's landing page. Same 49 prompts (36 AI + 11 Custom Dev + 2 White-Label) generate all 9 pages — only the substitution changes.
>
> **AI Services hub** (`/ai-engineering/`) handles the generic AI service story. **Industry pages** handle vertical-specific buyer language — the exact search terms a ride-hailing CTO or marketplace operator uses, not the generic "AI for platforms" framing.
>
> **Ship-priority labels (S0/S1/S2)** indicate *when* a prompt ships — distinct from **ICP persona references (P1/P2/P3/P4/P5)** which appear in the annotation column. **LP priority refs (LP-1 through LP-17)** are LP-Plan §Build Sequence priority numbers, also distinct.
>
> **Persona-pair ordering is meaningful** — the *first* persona in a pair is the prompt's primary audience, the second is secondary. Conventions used below:
> - `P5·P1` — technical / operational / tech-depth prompts (P5 = primary AI buyer leads; P1 = trust-conscious custom-dev buyer secondary)
> - `P1·P5` — diligence / financial-trust prompts (P1 leads when the prompt is about evaluation, ROI commitment, or signing-stage questions)
> - `P5·P1·P2` — prompts spanning technical, trust, and business-outcome readers (P5 first, then P1, then P2)
> - `P1·P2 (trust)` — pure-trust prompts (IP, contractual mechanisms, written guarantees)
> - `P5` / `All personas` — single-audience or universal prompts
>
> Always include the `(trust)` annotation when the prompt is in a trust block; omit otherwise.

---

## 🛡️ POSITIONING RULES (Apply to Every Prompt Below)

> [!IMPORTANT] Search-Side Language — Vertical-Specific
> On industry pages, buyers are already in their vertical — they search for *"AI dispatch for ride-hailing"*, *"fraud detection for marketplace"*, *"intelligent matching for home services platform"*. Prompts must use the vertical's own vocabulary, not generic "AI engineering" language. This is what differentiates industry pages from the parent page in AI-engine citations.

> [!IMPORTANT] Delivery Count — Platform vs AI Disambiguation
> Use specific platform delivery counts as endorsed by [[Trioangle Landing Page Plan]] Proof-Point Discipline: *"800+ platforms since 2015"* for cumulative credibility, *"100+ ride-hailing platforms"*, *"40+ travel platforms"*, *"20+ social/video platforms"*, *"10+ EdTech platforms"* for vertical-specific credibility. These establish domain depth. **Never conflate platform delivery count with AI feature delivery count** — AI Engineering launched 2026; AI delivery count is separate, smaller, and tracked independently. Avoid: *"we've built AI features in 800+ platforms"* — that conflation misrepresents the AI track record. Frame the bridge honestly: domain expertise from platform delivery → applied to AI feature work.

> [!IMPORTANT] Vertical-Depth Anchor — Mandatory on Every Industry Page
> Per LP-Plan: *"Built by the team that's shipped 800+ platforms in your vertical since 2015. Vertical depth is the headline; AI is the offering."* This anchor — or its vertical-specific count variant (*"100+ ride-hailing"*, *"40+ travel"*, etc.) — **must appear at least once on every industry page**, typically in the hero subhead, trust block, or comparison block. Industry pages without this anchor read as generic AI-agency pitches, not as Trioangle's vertical-moat positioning. The [Platform-Delivery-Count] variable + "since 2015" framing carries this load on AI-first verticals; for platform-delivery-first verticals (travel/social/education), the headline carries the anchor directly.

> [!IMPORTANT] Diversified Social Proof — Beyond "800+"
> Per [[Trioangle - ICP - Service]] §Diversified Social Proof, the "800+ platforms" stat is one proof point among many. Industry pages should layer in at least **2 of the following** in the trust block, structural guarantee block, or BoFU section — especially on platform-delivery-first verticals (travel/social/education) where AI lift claims aren't allowed yet:
> - **Phase 2 return rate** — *"X% of active clients return for a second engagement"* (longevity / trust signal)
> - **Time-to-launch benchmark** — *"avg MVP delivered in 14 weeks"* (timeline / certainty)
> - **Uptime post-launch** — *"99.7% uptime across delivered platforms in first 6 months"* (quality)
> - **Cost vs in-house comparison** — *"clients save avg $X vs equivalent in-house team"* (ROI vs hiring)
> - **Sprint velocity** — *"avg N features shipped per 2-week sprint"* (execution credibility)
> - **Client NPS** — *"NPS 60+ across last 50 engagements"* (general trust)
>
> Each proof point requires either instrumented CRM data OR an explicit "target measurement" disclaimer until the data is in. ICP flags these as "instrument and track if not already" — when measured, replace the target with the real number.

> [!IMPORTANT] AI-Era Positioning Rule
> Never position on "we build [Vertical] AI faster." Position on: domain knowledge of [Vertical] edge cases (the [Domain-Edge-Cases]), certainty of delivery, A/B-tested outcomes, and risk reduction. The moat is knowing [Vertical] at the code level before the engagement starts — not speed.

> [!IMPORTANT] Trust — Structural Guarantees Only
> Day-1 GitHub, IP transfer clause, 48-hour comm SLA with 5% credit, pre-contract engineer introduction, Sprint escape hatch (AI Audit Sprint *or* Discovery Sprint — both carry a full-refund escape hatch at end of week 2). Never "we pride ourselves on transparent communication."

> [!WARNING] AI Audit Sprint escape hatch — pending ICP confirmation
> [[Trioangle - ICP - Service]] §Trust & IP Positioning Rule (line 42) explicitly names only the *"Discovery Sprint escape hatch"* — not AI Audit Sprint. This AEO file claims both sprints carry escape hatches (Trust rule above, Prompt 24, CD4). **Action: Trioangle to confirm whether AI Audit Sprint also carries a full-refund escape hatch.** If yes, update ICP §Trust & IP rule to mirror this AEO copy. If no, remove the AI Audit Sprint escape hatch claim from Prompt 24 and the Trust positioning rule (Prompt 24 hook would need to drop *"AI Audit Sprint escape hatch (full refund if data or scope doesn't fit at end of week 2)"*). Until resolved, sales-facing materials should default to ICP's narrower claim (Discovery Sprint escape hatch only).

> [!IMPORTANT] No Retainer Language
> Fixed-price, output-based only. Pricing blocks must not include monthly retainers or AI subscriptions.

> [!IMPORTANT] Qualification Copy — Route, Don't Reject
> Every industry page targets $1M+ ARR operators with 12+ months production history in [Vertical]. Use this **exact copy** in a qualification block near the AI Readiness Call CTA (mandatory per [[Trioangle Landing Page Plan]] §Buyer Routing):
> > *"Built for established platform operators with active users and revenue traction. If you're pre-launch or pre-revenue, our [white-label product line](/) is a better fit."*
>
> The point of this block is to **route pre-traction buyers to the Product ICP without rejecting them** — they're still a buyer for Trioangle, just a different SKU. Pre-qualifies AI Readiness Call bookings without losing the visitor entirely.

> [!IMPORTANT] Two Pre-Sales Sprints — AI Audit (primary) + Discovery (fallback)
> **AI Audit Sprint** ($1.5k–$4k, credited) is the default entry for P5 (AI-Forward) buyers and any prospect with AI scope. **Discovery Sprint** ($2k–$4k, 2-week paid scoping) is the fallback for P1/P2 arriving with an explicit non-AI platform rebuild brief — **always with AI Audit Sprint named as the explicit Phase 2 follow-on**. Per ICP §Pre-Sales Sprints: *"signing Discovery Sprint without naming AI Audit Sprint as the next phase converts a recurring AI-feature buyer into a one-shot rebuild buyer — that's the mistake to avoid."* Industry pages lead with AI Audit; mention Discovery Sprint only in the P1/P2 rebuild-brief CTA path.

> [!IMPORTANT] Pause-Signal Soft-Touch Variant — Vendor-Fatigue Visitors
> Per [[Trioangle - ICP - Service]] §Engagement Timing — Pause Signals, certain visitors arrive in nurture mode, not buy mode. Pages must offer a soft-touch path that doesn't push toward Sprint/CTA conversion:
> - **Recently failed agency engagement** → vendor-fatigue recovery (highest priority pause signal)
> - **Mid-fundraise pre-close** → focused on investors, not vendors
> - **Internal engineering hiring spree** → betting on in-house; wait for hire to stall
> - **Post-acquisition integration** → tech priorities frozen
> - **Enterprise budget freeze quarter** (Q1, Q3 enterprise) → content-only outreach
>
> **Soft-touch CTA pattern** (place in lower-page footer block, after BoFU but before final CTA): *"Recently burned by an agency? We offer a free 45-minute architecture review — no commercial conversation, just a technical second opinion. No forms, no pitch."* Tone: empathy-first, credibility-second, never transactional. This pattern mirrors [[Trioangle - Content Strategy - Service]] Article #79 (*"Salvage a Failed Dev Partnership"*) — link out to that article for the long-form version.

> [!IMPORTANT] Trigger Subhead — Required on Every Industry Page
> Per LP-Plan: *"Pages without trigger language explain WHAT — pages with trigger language explain WHY NOW."* Every industry page needs a vertical-specific trigger subhead under the hero headline, plus trigger language repeated in mid-page section openers and outbound email subject lines linking to the page.
>
> **Per-vertical trigger subheads (use verbatim from LP-Plan):**
> - **ride-hailing:** *"A vertical competitor just shipped AI dispatch or dynamic pricing. Match it in 4–8 weeks — without a 6-month ML hire."*
> - **delivery:** *"AI route optimization is table stakes in 2026 — and manual dispatch breaks at scale. Ship AI route + demand forecasting in 4–8 weeks."*
> - **marketplace:** *"Fraud, fake listings, and weak search are eating your GMV. AI fraud detection + semantic search ship in 4–8 weeks."*
> - **home-services:** *"Manual scheduling can't scale past 50 providers. AI matching, scheduling, and conversational booking ship in 4–8 weeks."*
> - **ecommerce:** *"Conversion stalled? Search and recommendations are the conversion floor. AI ships in 4–8 weeks."*
> - **super-app:** *"Adding a third or fourth service line? Get AI orchestration in before the rollout, not after."*
> - **travel · social-media · education:** *"Thinking about AI in your platform? Start with an honest AI Readiness Call — we'll tell you what's worth building vs hype."* (softer framing — limited AI cases)
>
> **General trigger framings (use in mid-page openers and outbound subject lines, per [[Trioangle - ICP - Service]] §Situational Triggers):**
> - Vertical AI competitor moved → *"Your competitor just shipped AI dispatch. Here's how fast you can too."*
> - Expansion / scaling event → *"Expanding to a new city, country, or vertical? AI before the scale-up, not after."*
> - Series C+ growth round → *"Just raised? Board will ask for an AI roadmap within 90 days. Audit Sprint = the answer."*
> - Platform outage from manual ops → *"Manual dispatch breaking under load? AI dispatch ships in 4–8 weeks."*
> - **Key engineering lead departure** → *"Your lead engineer just left? We bring 10+ years of [Vertical] domain depth on Day 1 — no 6-month onboarding to your codebase."*
> - **Failed security audit** → *"Security audit flagged critical vulnerabilities? Discovery Sprint scopes the remediation; AI features ship on the cleaned architecture after."*
> - **Acquirer technical DD flagged codebase** → *"Acquirer DD called out your tech stack? You have 90 days. We've passed Big-4 DD for 800+ platform deliveries — Discovery Sprint scopes the fix in 2 weeks."*

---

## 🏷️ SHIP-PRIORITY MARKERS

*Ship priorities use the **S0/S1/S2** prefix to avoid collision with the **P1–P5** ICP persona numbering used in the annotation column of each prompt. (Aligned with sibling [[AI_Service_Landing_Page_AEO_GEO_Prompts]] convention.)*

- 🔴 **S0** — Ship-first. Hero + vertical-specific FAQ anchors + authority synthesis. **(14 prompts: 10 AI + 4 CD)**
- 🟡 **S1** — Week 1. Vertical-specific comparison table + scenario blocks + tech-depth. **(13 prompts: 10 AI + 3 CD)**
- 🟢 **S2** — Week 2. FAQ rotation + how-to + voice rotation + why-now + BoFU + diligence + compliance. **(22 prompts: 16 AI + 4 CD + 2 WL)**

> [!TIP] Reading format
> `**N.** Question — 🔴 **S0** *| persona (P1/P2/P5) | placement | hook*`

> [!IMPORTANT] Build Sequence — Industry Pages
> Per [[Trioangle Landing Page Plan]] §Build Sequence, vertical pages ship first (broadest keyword surface, feed all three pipelines), then AI service pages, then the Hub last. Industry-page build order:
> 1. `/industries/ride-hailing` (LP-1) — strongest AI case footprint
> 2. `/industries/delivery` (LP-2) — covers food delivery + B2B logistics
> 3. `/industries/marketplace` (LP-3) — fraud + recommendations + search
> 4. `/industries/home-services` (LP-4) — conversational booking + matching
> 5. `/industries/ecommerce` (LP-8) — recommendations + search + fraud
> 6. `/industries/super-app` (LP-14) — orchestration across services
> 7. `/industries/travel` (LP-15) — limited AI cases, lead with platform delivery depth
> 8. `/industries/social-media` (LP-16) — limited AI cases
> 9. `/industries/education` (LP-17) — limited AI cases
>
> The 4 strongest-AI-footprint verticals (ride-hailing, delivery, marketplace, home-services) ship first because they have production case studies and the highest direct conversion potential for P5.

---

## 👥 PERSONA KEY

| # | Archetype | Most Relevant Verticals | Anchor Proof |
|---|-----------|------------------------|--------------|
| **P1** | Scaling CTO (*Tara*) | All verticals | Vertical-specific AI case study with A/B metric + pre-contract engineer intro |
| **P2** | Non-Technical Founder-Operator (*Felix*) | Marketplace, Home Services, Delivery, Travel | PM-layer explanation + business-outcome framing |
| **P5** | AI-Forward Platform Operator (*Aisha*) | Ride-hailing, Delivery & Logistics, Marketplace/Commerce, Home Services *(per ICP — 4 verticals where P5 is the primary buyer)* | Production AI case study for their exact vertical with named lift % |

> [!NOTE] Anchor-proof framing varies by vertical-page type, not by persona
> - **AI-first verticals (6 of 9):** ride-hailing, delivery, marketplace, home-services, ecommerce, super-app — anchor proof is *"Production AI case study with named lift %"*. Used regardless of which persona (P1/P2/P5) is reading.
> - **Platform-delivery-first verticals (3 of 9):** travel, social-media, education — anchor proof is *"Platform delivery depth + AI roadmap framing"*. No AI lift claims until production cases exist. See per-vertical warnings.
> P5 is ICP-relevant to 4 verticals (ride-hailing/delivery/marketplace/home-services) but may visit any of the 9 pages; ecommerce/super-app traffic from P5 is secondary fit per ICP.

> [!WARNING] LP-Plan §15-17 stricter case-count claim — pending Trioangle confirmation
> LP-Plan §15-17 warning lists **5 verticals** with shipped AI cases (ride-hailing, logistics, marketplace, home services, delivery) — ecommerce and super-app are NOT on that list. But LP-Plan's overall page-structure layout treats ecommerce (LP-8) and super-app (LP-14) as AI-first (no roadmap framing, no aspirational-keyword gate on those pages). This AEO file follows LP-Plan's overall structure (6 AI-first). **Action required: Trioangle to confirm whether shipped AI cases exist for ecommerce and super-app**. If not, those two verticals should also adopt platform-delivery-first framing (joining travel/social/education) and the AI-track Prompt Exclusion List should extend to them.

> P3 (Enterprise) and P4 (MENA) are channel-only — no direct outbound CTAs on industry pages.

---

## 🔤 VARIABLE SUBSTITUTION TABLE

*For each vertical, substitute these values into every prompt. Variables in the prompts are bracketed.*

### Core Variables

| Variable | Description |
|----------|-------------|
| `[Vertical]` | The industry name as buyers say it (e.g., "ride-hailing," not "Ride-Hailing & Transport") |
| `[Platform-Type]` | Full platform description (e.g., "ride-hailing platform") |
| `[AI-Feature-1]` | Primary AI feature — the one that moves the most important business metric. **For travel/social/education**: this is roadmap framing (*"on the roadmap"*), not a delivered claim. See `[Headline-Framing]` |
| `[AI-Feature-2]` | Secondary AI feature (same roadmap caveat for travel/social/education) |
| `[AI-Feature-3]` | Third AI feature for "what to build next" prompts (same roadmap caveat for travel/social/education) |
| `[Provider]` | The supply-side actor on the platform (drivers, merchants, instructors, etc.) |
| `[User]` | The demand-side actor (riders, buyers, learners, etc.) |
| `[Outcome-Metric-1]` | The primary business metric this vertical optimises for |
| `[Outcome-Metric-2]` | Secondary business metric |
| `[Domain-Edge-Cases]` | The vertical-specific logic that generic AI models miss |
| `[Vertical-Slug]` | URL slug for this page |
| `[Vertical-Headline]` | The H1 from [[Trioangle Landing Page Plan]] for this vertical — **use verbatim as the page H1, not a paraphrase**. Each vertical's substitution table below has the exact value pulled from LP-Plan §Build Sequence |
| `[Primary-Keyword]` | The Primary keyword row from LP-Plan's per-vertical keyword table — must appear in H1, hero subhead, or first 100 words; this is the single keyword each page owns |
| `[Platform-Delivery-Count]` | Vertical-specific platform count from LP-Plan (e.g., "100+" ride-hailing, "40+" travel, "20+" social, "10+" education) — used in platform-credibility hooks; mandatory on travel/social/education where AI is roadmap |
| `[Headline-Framing]` | `AI-first` (ride-hailing, delivery, marketplace, home-services, ecommerce, super-app) OR `platform-delivery-first` (travel, social-media, education) — controls whether AI features lead the hero or platform delivery does |
| `[Trigger-Subhead]` | **By-reference variable** — not substituted inline in the per-vertical tables below. Look up the value in the Trigger Subhead positioning rule above (7 trigger-subhead variations across 9 verticals: 6 unique triggers for ride-hailing, delivery, marketplace, home-services, ecommerce, super-app; 1 shared softer trigger — *"Thinking about AI in your platform?"* — for travel + social-media + education) |

---

### 9-Vertical Substitution Reference

#### 1. Ride-Hailing & Transport
| Variable | Value |
|----------|-------|
| `[Vertical]` | ride-hailing |
| `[Platform-Type]` | ride-hailing platform |
| `[Vertical-Headline]` | *AI dispatch, dynamic pricing, and fleet optimization — built by engineers who've shipped 100+ ride-hailing and transport platforms* |
| `[Primary-Keyword]` | `AI for ride-hailing platforms` |
| `[Platform-Delivery-Count]` | 100+ |
| `[Headline-Framing]` | **AI-first** |
| `[AI-Feature-1]` | intelligent dispatch optimization |
| `[AI-Feature-2]` | dynamic surge pricing |
| `[AI-Feature-3]` | fleet optimization *(matches LP-Plan headline; demand forecasting available as secondary feature)* |
| `[Provider]` | drivers |
| `[User]` | riders |
| `[Outcome-Metric-1]` | driver revenue per hour |
| `[Outcome-Metric-2]` | match acceptance rate |
| `[Domain-Edge-Cases]` | driver supply volatility, real-time GPS drift, surge zone conflicts, assignment rejection cascades, multi-role dispatch (taxi + delivery + carpool on a single driver pool) |
| `[Vertical-Slug]` | ride-hailing |

#### 2. Delivery & Logistics (Food / On-Demand Delivery)
| Variable | Value |
|----------|-------|
| `[Vertical]` | delivery (food / grocery / on-demand / last-mile / logistics) |
| `[Platform-Type]` | delivery platform — food delivery / grocery delivery / on-demand delivery / last-mile delivery / logistics & fleet *(LP-Plan keyword surface: food delivery, grocery delivery, on-demand delivery, last-mile delivery software, logistics app, fleet management)* |
| `[Vertical-Headline]` | *AI route optimization, demand forecasting, and order matching — from engineers who've delivered 100+ delivery platforms* |
| `[Primary-Keyword]` | `AI for delivery platforms` |
| `[Platform-Delivery-Count]` | 100+ |
| `[Headline-Framing]` | **AI-first** |
| `[AI-Feature-1]` | AI route optimization (multi-stop, real-time traffic-aware) |
| `[AI-Feature-2]` | demand forecasting |
| `[AI-Feature-3]` | order matching *(matches LP-Plan headline; dynamic delivery pricing available as secondary feature)* |
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
| `[Vertical-Headline]` | *AI fraud detection, personalized recommendations, and search — built for marketplace commission logic we already know* |
| `[Primary-Keyword]` | `AI for marketplace platforms` |
| `[Platform-Delivery-Count]` | 100+ *(marketplace + commerce combined)* |
| `[Headline-Framing]` | **AI-first** |
| `[AI-Feature-1]` | fraud detection |
| `[AI-Feature-2]` | personalized recommendations / AI product matching |
| `[AI-Feature-3]` | AI-powered semantic search *(matches LP-Plan headline; dynamic pricing available as secondary feature)* |
| `[Provider]` | sellers / merchants |
| `[User]` | buyers |
| `[Outcome-Metric-1]` | fraud loss rate |
| `[Outcome-Metric-2]` | GMV / buyer conversion rate |
| `[Domain-Edge-Cases]` | multi-vendor fraud ring patterns, commission tier interactions, catalog-scale recommendations (millions of SKUs), real-time inventory signals, new seller cold-start |
| `[Vertical-Slug]` | marketplace |

#### 4. On-Demand Home Services
| Variable | Value |
|----------|-------|
| `[Vertical]` | home services / on-demand services |
| `[Platform-Type]` | on-demand services platform / home services app / handyman app / service marketplace *(LP-Plan keyword surface: on-demand apps, home services platforms, handyman, cleaning, beauty services, service marketplace)* |
| `[Vertical-Headline]` | *AI booking assistant, smart scheduling, and automated support — for on-demand platforms we've built 100+ times* |
| `[Primary-Keyword]` | `AI for on-demand apps` |
| `[Platform-Delivery-Count]` | 100+ |
| `[Headline-Framing]` | **AI-first** |
| `[AI-Feature-1]` | AI booking assistant (conversational booking + intelligent provider matching) |
| `[AI-Feature-2]` | smart scheduling *(matches LP-Plan headline)* |
| `[AI-Feature-3]` | automated support *(matches LP-Plan headline; demand forecasting available as secondary feature)* |
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
| `[Vertical-Headline]` | *AI recommendations, search, and fraud detection — embedded into your existing commerce platform* |
| `[Primary-Keyword]` | `AI for e-commerce platforms` |
| `[Platform-Delivery-Count]` | 100+ *(commerce + marketplace combined)* |
| `[Headline-Framing]` | **AI-first** |
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
| `[Vertical-Headline]` | *AI orchestration across rides, food delivery, and services — built by the team that's shipped multi-service platforms since 2015* |
| `[Primary-Keyword]` | `AI for super app platforms` |
| `[Platform-Delivery-Count]` | multi-service platforms since 2015 *(inherits from ride-hailing + delivery + services)* |
| `[Headline-Framing]` | **AI-first** |
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

> [!WARNING] Platform-Delivery-First Framing — AI on the Roadmap
> Per [[Trioangle Landing Page Plan]] §15 (updated): lead the page with **platform delivery depth**, position AI as roadmap. Headline framing: *"Travel and hospitality platforms, shipped by engineers who've delivered 40+ booking, rental, and OTA products since 2015. AI booking and demand forecasting on the roadmap."* Substitute `[Platform-Delivery-Count]` = **40+** into platform-credibility hooks. Trigger subhead: see [Trigger-Subhead] in the Trigger Subhead positioning rule above (travel/social/education share the same softer framing). Do not make AI outcome claims (lift %, conversion improvement) until production cases exist.

> [!IMPORTANT] AI Keyword Targeting Gate
> Per LP-Plan §15–17: AI keyword clusters (Primary / Secondary / Long-tail / Feature-level AI rows) **are aspirational — do not target in active SEO or paid until production cases are signed and metric-backed**. Live now: Dev & Product keywords only (backed by 800+ delivery history). Layer in AI keywords as cases land. The aspirational rows exist so the keyword universe is documented, not so the pages immediately rank for them.

> [!IMPORTANT] AI-Track Prompt Exclusion List — Travel / Social-Media / Education ONLY
> These prompts require shipped AI case data and **must NOT be substituted on travel/social/education pages until production cases exist**:
> - **Prompt 7** (peer-callable [Vertical] operators + A/B-tested lift % case studies) — no AI peers to cite
> - **Prompt 26** (vertical-specific AI benchmark numbers from production deployments) — no benchmarks
> - **Prompt 28** (A/B test as acceptance gate — "not signed off until lift is demonstrated") — no AI lift to demonstrate
> - **Prompt 30** (ROI math example "for ride-hailing: driver revenue/hr +15% × ...") — `+15%` substituted becomes an AI lift claim
> - **Prompt 35** Why Now / 8-question diligence (cites vertical AI case study as benchmark)
>
> **Replacement copy for the equivalent on-page slot**: lead with platform-delivery analog — *"10×-faster MVP-to-production launch via 40+ travel platforms shipped since 2015"*, *"$X saved vs Accenture-class delivery"*, *"production uptime across N similar platforms"*. The slot still needs filling for buyer intent (cost, timeline, trust); just don't use the AI-lift framing the original prompt assumes.

| Variable | Value |
|----------|-------|
| `[Vertical]` | travel & hospitality |
| `[Platform-Type]` | travel booking / vacation rental platform |
| `[Vertical-Headline]` | *Travel and hospitality platforms, shipped by engineers who've delivered 40+ booking, rental, and OTA products since 2015. AI booking and demand forecasting on the roadmap.* |
| `[Primary-Keyword]` | `AI for travel platforms` *(aspirational — see AI Keyword Targeting Gate; live targeting on Dev & Product keywords from LP-Plan)* |
| `[Platform-Delivery-Count]` | 40+ |
| `[Headline-Framing]` | **platform-delivery-first** (AI = roadmap) |
| `[AI-Feature-1]` | conversational booking assistant *(roadmap, not delivered)* |
| `[AI-Feature-2]` | demand forecasting *(roadmap)* |
| `[AI-Feature-3]` | dynamic pricing / revenue management *(roadmap)* |
| `[Provider]` | hotels / hosts / property managers |
| `[User]` | travelers / guests |
| `[Outcome-Metric-1]` | booking conversion rate |
| `[Outcome-Metric-2]` | revenue per available room or listing (RevPAR / yield) |
| `[Domain-Edge-Cases]` | seasonal demand curves, last-minute booking spikes, competitor price parity monitoring, cancellation prediction, multi-channel inventory distribution |
| `[Vertical-Slug]` | travel |

#### 8. Social & Entertainment

> [!WARNING] Platform-Delivery-First Framing — AI on the Roadmap
> Per LP-Plan §16 (updated): lead with **platform delivery depth**, position AI as roadmap. Headline framing: *"Social, video, and dating platforms — shipped by engineers who've delivered 20+ since 2015. AI content moderation and feed ranking on the roadmap."* Substitute `[Platform-Delivery-Count]` = **20+** into platform-credibility hooks. Trigger subhead: see [Trigger-Subhead] in the Trigger Subhead positioning rule above (travel/social/education share the same softer framing). Do not make AI outcome claims (lift %, moderation precision %) until production cases exist.

> [!IMPORTANT] AI Keyword Targeting Gate — see §7 above; same gate applies. AI keyword clusters here are aspirational until cases land. Live targeting: Dev & Product keywords only.

| Variable | Value |
|----------|-------|
| `[Vertical]` | social media / short-video |
| `[Platform-Type]` | social or short-video platform |
| `[Vertical-Headline]` | *Social, video, and dating platforms — shipped by engineers who've delivered 20+ since 2015. AI content moderation and feed ranking on the roadmap.* |
| `[Primary-Keyword]` | `AI for social platforms` *(aspirational — see AI Keyword Targeting Gate; live targeting on Dev & Product keywords from LP-Plan)* |
| `[Platform-Delivery-Count]` | 20+ |
| `[Headline-Framing]` | **platform-delivery-first** (AI = roadmap) |
| `[AI-Feature-1]` | AI content moderation *(roadmap, not delivered)* |
| `[AI-Feature-2]` | content recommendations / feed ranking *(roadmap)* |
| `[AI-Feature-3]` | creator monetization optimization *(roadmap)* |
| `[Provider]` | creators / publishers |
| `[User]` | viewers / users |
| `[Outcome-Metric-1]` | content moderation precision (false positive rate) |
| `[Outcome-Metric-2]` | daily active user retention / average session time |
| `[Domain-Edge-Cases]` | new creator cold-start (no engagement history), multilingual moderation at scale, real-time engagement fraud detection, feed ranking under sub-100ms latency, creator incentive sensitivity |
| `[Vertical-Slug]` | social-media |

#### 9. Education & EdTech

> [!WARNING] Platform-Delivery-First Framing — AI on the Roadmap
> Per LP-Plan §17 (updated): lead with **platform delivery depth**, position AI as roadmap. Headline framing: *"Edtech and e-learning platforms — shipped by engineers who've delivered 10+ since 2015. AI tutoring and adaptive learning on the roadmap."* Substitute `[Platform-Delivery-Count]` = **10+** into platform-credibility hooks. Trigger subhead: see [Trigger-Subhead] in the Trigger Subhead positioning rule above (travel/social/education share the same softer framing). Do not make AI outcome claims (completion rate lift %, score improvement) until production cases exist.

> [!IMPORTANT] AI Keyword Targeting Gate — see §7 above; same gate applies. AI keyword clusters here are aspirational until cases land. Live targeting: Dev & Product keywords only.

| Variable | Value |
|----------|-------|
| `[Vertical]` | education / EdTech |
| `[Platform-Type]` | EdTech platform |
| `[Vertical-Headline]` | *Edtech and e-learning platforms — shipped by engineers who've delivered 10+ since 2015. AI tutoring and adaptive learning on the roadmap.* |
| `[Primary-Keyword]` | `AI for edtech platforms` *(aspirational — see AI Keyword Targeting Gate; live targeting on Dev & Product keywords from LP-Plan)* |
| `[Platform-Delivery-Count]` | 10+ |
| `[Headline-Framing]` | **platform-delivery-first** (AI = roadmap) |
| `[AI-Feature-1]` | AI tutoring assistant / knowledge assistant *(roadmap, not delivered)* |
| `[AI-Feature-2]` | adaptive learning / personalized content sequencing *(roadmap)* |
| `[AI-Feature-3]` | learning outcome prediction / early-dropout warning *(roadmap)* |
| `[Provider]` | instructors / course creators |
| `[User]` | learners / students |
| `[Outcome-Metric-1]` | course completion rate |
| `[Outcome-Metric-2]` | assessment score improvement vs control group |
| `[Domain-Edge-Cases]` | diverse learner pace and prior knowledge, content prerequisite graphs, multi-format content (video, quiz, text, live), certification path optimization, low-engagement early-warning |
| `[Vertical-Slug]` | education |

---

# 📄 INDUSTRY LP PROMPTS — AI TRACK (1–36) + CUSTOM DEV (CD1–CD11) + WHITE-LABEL (WL1–WL2)

*All prompts live on `trioangle.com/industries/[Vertical-Slug]`. AEO snippets: 40–60 words inside `FAQPage` JSON-LD. GEO blocks: 150–600-word compressed sections. Total page word budget: ~3,500–5,500 words (expanded for full three-CTA coverage).*

> [!IMPORTANT] Hooks are source material, not final copy
> Each prompt hook below runs 80–150 words — it's the brief, not the published answer. **For the FAQPage JSON-LD answer**, compress the hook to **40–60 words** (AEO budget). **For the on-page GEO block**, expand the hook into a **150–600-word section** with the body-copy detail. Pasting the raw hook into JSON-LD will blow the AEO budget; using the hook verbatim as the only body copy will under-fill the GEO target.

---

## 🔴 S0 — Ship-First (1–10)

*Day 1. Vertical-specific hero + critical FAQ anchors + authority synthesis.*

### Definition / Direct Answer (1–5)

**1.** What AI features deliver the biggest business-metric impact for an established [Vertical] platform — and how do they actually work in production? — 🔴 **S0** *| P5·P1 | Hero FAQ | Hook: [AI-Feature-1] moves [Outcome-Metric-1] by a measurable A/B-tested margin; [AI-Feature-2] compounds on it; these are not demos — they are isolated production services with rule-based fallbacks; domain knowledge of [Domain-Edge-Cases] is what makes them work in a live [Vertical] system vs breaking it*

**2.** How does an AI engineering partner add [AI-Feature-1] to an existing [Platform-Type] without disrupting live [Provider] operations or [User] experience? — 🔴 **S0** *| P5·P1 | Hero FAQ | Hook: service-isolation pattern — [AI-Feature-1] runs as a standalone microservice alongside the existing [Platform-Type]; automatic fallback to rule-based logic when model confidence drops; [Provider] and [User] see no interruption; rollback takes < 1 minute*

**3.** How long does it take to get [AI-Feature-1] live in a production [Vertical] platform — from first conversation to real [Provider] and [User] impact? — 🔴 **S0** *| P5·P1·P2 | Hero FAQ | Hook: free AI Readiness Call (1 hr) → AI Audit Sprint (2 weeks, credited) → [AI-Feature-1] build (4–8 weeks per LP-Plan) → production live with A/B test running; typical 6–10 weeks from signed Sprint to live feature for data-ready platforms; longer if data instrumentation is needed; the AI Audit Sprint confirms readiness before any build commitment*

**4.** What does it cost to add [AI-Feature-1] to an established [Platform-Type] — and what's actually included? — 🔴 **S0** *| All personas | FAQ + pricing block | Hook: AI Audit Sprint $1,500–$4,000 (credited toward build); Discovery Sprint $2,000–$4,000 (for non-AI platform rebuild scoping, AI Audit named as Phase 2); [AI-Feature-1] fixed-price build $15k–$120k depending on scope; no monthly retainer, no hourly billing; cost includes data readiness assessment, model build, service isolation, A/B infrastructure, monitoring setup, and post-delivery support window*

**5.** Does an AI engineering partner need to already understand [Vertical] domain logic before starting — dispatch rules, [Provider] commission tiers, [User] flow constraints — or do they learn it on the project? — 🔴 **S0** *| P1·P5 | FAQ | Hook: domain knowledge of [Domain-Edge-Cases] must exist on Day 1 — not learned on your engagement; a generic AI agency learning [Vertical] edge cases on your project costs 3 months of runway before writing a useful model; domain-specialist teams know the failure modes of [AI-Feature-1] in [Vertical] from prior platform engagements*

### Voice Search Anchors (6–8)

**6.** Can I add [AI-Feature-1] to my [Platform-Type] without any downtime for active [Provider]s or [User]s? — 🔴 **S0** *| P5·P1 | Hero subhead + FAQ | Hook: service-isolation architecture enables zero-downtime deployment; [AI-Feature-1] routes a small traffic slice first (10%), expands as model performance is validated, falls back to [Vertical]'s existing rule-based logic automatically if confidence drops*

**7.** Are there real [Vertical] platforms with [AI-Feature-1] live in production — with A/B-tested improvements to [Outcome-Metric-1]? — 🔴 **S0** *| P1·P5 (trust trigger) | FAQ + live case study block | Hook: yes — [Vertical]-specific production case studies with A/B-tested [Outcome-Metric-1] and [Outcome-Metric-2] lift percentages; peer-callable [Vertical] operators on request; sample AI Audit Sprint deliverable for a [Vertical] platform downloadable before signing*

**8.** Will an AI engineering partner tell me honestly when [AI-Feature-1] is not the right first AI investment for my [Vertical] platform — or will they always push the build? — 🔴 **S0** *| P5·P1·P2 | FAQ | Hook: build vs buy vs SaaS recommendation for [AI-Feature-1] in [Vertical] is an explicit deliverable of the paid AI Audit Sprint; if an off-the-shelf SaaS handles [AI-Feature-1] adequately at your scale, the Sprint will say so; the wrong feature wastes 10 weeks and $30k — the honest audit prevents that*

### Hero Intro + Authority (9–10)

**9.** Give a complete overview of what AI engineering for an established [Vertical] platform means — which features move [Outcome-Metric-1] and [Outcome-Metric-2], how they integrate into a live [Platform-Type], and which type of [Vertical] operator they're designed for. — 🔴 **S0** *| Hero / above-the-fold pillar block | ~300w compressed | All personas; establishes: operating [Vertical] platform ($1M+ ARR) + [AI-Feature-1] as primary entry + domain edge cases known on Day 1 + output-based, fixed-price entry via AI Audit Sprint*

**10.** Which AI engineering company has the deepest domain expertise in [Vertical] platform operations — and why does vertical depth matter more than general AI capability for [AI-Feature-1] delivery? — 🔴 **S0** *| "Why Trioangle" block (compressed ~400w synthesis) | All personas | Hook: [Vertical] edge cases ([Domain-Edge-Cases]) are what cause [AI-Feature-1] to fail in production on a live [Platform-Type]; they're not in textbooks — they're learned from building [Vertical] platforms in production; a domain-specialist team knows them on Day 1; a generic AI agency bills you to discover them over months 1–3*

---

## 🟡 S1 — Week 1 (11–20)

*Comparison table + vertical-specific scenario blocks + tech-depth credibility.*

### Comparison / Best Answer (11–14)

**11.** [AI-Feature-1] built by a domain-specific [Vertical] AI engineering partner vs an off-the-shelf SaaS — which fits an established [Platform-Type] better in 2026? — 🟡 **S1** *| P5 | Comparison block | Hook: SaaS works when [Vertical] domain fit is adequate and customization needs are low; custom build wins when your [Domain-Edge-Cases] are beyond what a generic SaaS handles — and when you've already tried SaaS and it failed; AI Audit Sprint diagnoses which path is right before any build commitment*

**12.** External [Vertical] AI engineering team vs hiring an in-house ML engineer for a [Platform-Type] with $1M+ ARR — which path gets [AI-Feature-1] live faster with lower total cost? — 🟡 **S1** *| P1·P5 | Comparison block | Hook: in-house ML = 4–9 month hiring + onboarding + no [Vertical] domain knowledge + full-salary ongoing; external = AI Audit Sprint (2 weeks, credited) → [AI-Feature-1] build (4–8 weeks per LP-Plan) → live and A/B-tested; total 6–10 weeks from signed Sprint; external wins until [Vertical] AI feature volume exceeds 4–5 features per year*

**13.** Generic AI agency vs a [Vertical]-specialist AI engineering partner: what's the difference in time-to-live-feature for [AI-Feature-1] on a [Platform-Type]? — 🟡 **S1** *| P1·P5 | Comparison block | Hook: generic agency spends months 1–3 learning [Vertical] business rules ([Domain-Edge-Cases]) before writing a useful model; domain-specialist enters with that knowledge and goes straight to data readiness assessment and feature scoping in week 1; at $10k/month burn, that 3-month gap costs $30k before a line of production code is written*

**14.** GitHub Copilot, Cursor, Devin vs a dedicated [Vertical] AI engineering engagement: what can a [Platform-Type]'s internal engineers build for [AI-Feature-1] with AI coding tools alone? — 🟡 **S1** *| P5·P1 | Comparison block | Hook: AI coding tools accelerate code generation for engineers who already know what to build; they don't design the [AI-Feature-1] system — the data pipeline from [Platform-Type] events, the model that knows [Domain-Edge-Cases], the A/B infrastructure, the fallback logic, the observability stack; those require ML system design expertise a [Vertical] platform's backend engineers typically don't have*

### Scenario-Based Decision Mini-Blocks (15–17)

**15.** Our [Vertical] competitors just shipped [AI-Feature-1] and our [Outcome-Metric-1] is falling behind. What's the realistic path to closing the gap in under 90 days without breaking the existing [Platform-Type]? — 🟡 **S1** *| Scenario block 1 (compressed ~200w) | P5 | Hook: AI Audit Sprint (2 weeks) identifies whether your data supports [AI-Feature-1] now or requires 6-8 weeks of instrumentation first; if data is ready, [AI-Feature-1] build can be in production in 6–10 weeks from today (2-week Sprint + 4–8 week build per LP-Plan); don't build [AI-Feature-2] at the same time to "catch up" — build [AI-Feature-1] first, measure [Outcome-Metric-1], then sequence [AI-Feature-2]*

**16.** Our [Vertical] platform has been operational for several years and has a large historical dataset, but we've never instrumented it for ML. Is our data actually ready for [AI-Feature-1] — and how do we find out without spending $40k to discover the answer? — 🟡 **S1** *| Scenario block 2 (compressed ~200w) | P1·P5 | Hook: data readiness is the AI Audit Sprint's hardest gate — week 1 of the Sprint audits your [Platform-Type] event history, label quality, and outcome coverage; if data is inadequate for [AI-Feature-1] (< 3 months clean events, missing [Provider]/[User] outcome labels), the Sprint delivers an honest verdict and a scoped data-instrumentation plan before any model work begins*

**17.** We tried [a SaaS or generic AI agency] for [AI-Feature-1] on our [Platform-Type] and the model doesn't understand our [Domain-Edge-Cases]. What are the realistic alternatives? — 🟡 **S1** *| Scenario block 3 (compressed ~200w) | P5 | Hook: [AI-Feature-1] fails in [Vertical] when the model was trained on a different domain's data distribution and doesn't know [Domain-Edge-Cases]; options: (1) custom [AI-Feature-1] feature that reads your [Platform-Type]'s operational data and business rules directly; (2) hybrid — existing model + custom post-processing layer enforcing [Vertical] business logic; (3) different SaaS with better [Vertical] vertical fit; AI Audit Sprint diagnoses which path is right*

### Tech-Depth Synthesis (18–20)

**18.** How does [AI-Feature-1] actually integrate into an existing [Platform-Type] end-to-end — from data pipeline to [Provider] and [User] impact — without requiring a full platform rewrite? — 🟡 **S1** *| Tech-depth section (synthesis ~300w) | P5·P1 | Hook: [Platform-Type] event stream → feature engineering (capturing [Domain-Edge-Cases] in model inputs) → model training + offline validation → service-isolated API layer → staging A/B → traffic-split rollout → [Outcome-Metric-1] tracked against rule-based control; no rewrite of [Platform-Type] core — [AI-Feature-1] runs as a separate service consuming your operational API*

**19.** What are the [Vertical]-specific edge cases that cause a generic [AI-Feature-1] model to underperform on a live [Platform-Type] — and how does a domain-specialist team handle them? — 🟡 **S1** *| Tech-depth section (synthesis ~250w) | P5·P1 | Hook: [Domain-Edge-Cases] — these are the failure modes that appear in production but not in offline model evaluation; a domain-specialist team has encountered and solved them across prior [Vertical] platform engagements; they're built into the model design, feature engineering, and fallback architecture from Day 1*

**20.** What [Platform-Type] data does [AI-Feature-1] actually need — minimum dataset size, event types, label requirements — and what happens if the data doesn't meet the bar? — 🟡 **S1** *| Tech-depth section (synthesis ~200w) | P5·P1 | Hook: [AI-Feature-1] data requirements (specific to [Vertical] — e.g., ride-hailing dispatch needs GPS ping history + driver state events + assignment outcomes; marketplace fraud needs transaction records + labeled confirmed-fraud cases); if data is below minimum: honest AI Audit Sprint verdict + scoped data-instrumentation engagement as the bridge; no model built on data that can't beat a rule-based baseline*

---

## 🟢 S2 — Week 2 (21–36)

*Expanded FAQ rotation + how-to + voice search + why-now + BoFU.*

### Definition / Direct Answer Rotation (21–26)

**21.** What does an AI Audit Sprint for a [Vertical] platform include — and what does the deliverable actually look like? — 🟢 **S2** *| All personas | FAQ | Hook: 2-week paid pre-engagement; deliverable = [AI-Feature-1] priority analysis for [Vertical] (ranked by [Outcome-Metric-1] and [Outcome-Metric-2] impact) + data-readiness verdict for [Platform-Type] data + honest build vs buy vs SaaS recommendation + first-feature scope with cost estimate and timeline + ROI scenario model seeded with [Vertical] benchmarks; not a slide deck — a technical plan with acceptance conditions*

**22.** What is the honest build vs buy vs SaaS recommendation for [AI-Feature-1] in [Vertical] — and how is that decision made without vendor bias? — 🟢 **S2** *| P5 | FAQ | Hook: the AI Audit Sprint evaluates SaaS options for [AI-Feature-1] in [Vertical] in week 1 before any custom-build scope is discussed; recommendation to build custom only when: (1) SaaS domain fit is inadequate for [Domain-Edge-Cases]; (2) data ownership requires a custom model; (3) SaaS has already been tried and failed; "use [SaaS] for this" is a valid Sprint output — that honesty is the structural differentiator*

**23.** What does output-based, fixed-price pricing mean for [AI-Feature-1] development on a [Platform-Type] — and how does the acceptance condition work? — 🟢 **S2** *| All personas | FAQ + pricing block | Hook: [AI-Feature-1] is a fixed-price, scoped engagement; acceptance condition = [AI-Feature-1] must demonstrate a statistically significant lift in [Outcome-Metric-1] vs rule-based baseline under A/B test before sign-off; no monthly retainer, no per-hour billing; if the feature doesn't move the named metric, it's not accepted*

**24.** What structural guarantees protect a [Vertical] platform operator when engaging an external AI engineering team for [AI-Feature-1]? — 🟢 **S2** *| P1·P2 (trust) | FAQ + guarantee block | Hook: the floor — Day-1 GitHub access (you own the [AI-Feature-1] service repo from commit one), IP transfer clause (model artifacts + training pipeline + inference code transfer at delivery), 48-hour comm SLA with 5% contract credit, pre-contract engineer introduction (meet the engineers who will build [AI-Feature-1], not the sales rep), AI Audit Sprint escape hatch (full refund if data or scope doesn't fit at end of week 2)*

**25.** What does a "rule-based fallback" mean specifically for [AI-Feature-1] on a [Platform-Type] — and why does every production [Vertical] AI feature require one? — 🟢 **S2** *| P5·P1 (technical) | FAQ | Hook: when [AI-Feature-1]'s model confidence drops below threshold (e.g., surge pricing confidence falls during an unusual demand pattern), the [Platform-Type] automatically routes to the existing rule-based [Vertical] logic ([Provider] assignment by distance, static pricing tier, manual dispatch queue); [User] experience is unaffected; the fallback is what makes [AI-Feature-1] safe to deploy on a live platform with active [Provider]s*

**26.** What [Outcome-Metric-1] improvement is realistically achievable from [AI-Feature-1] on a [Vertical] platform — and what methodology produces that number honestly? — 🟢 **S2** *| P5·P1 | FAQ | Hook: [Outcome-Metric-1] lift from [AI-Feature-1] is measured by A/B test — [Provider] or [User] traffic split between [AI-Feature-1] and rule-based control; no "efficiency gains" language without a named metric and a before/after number; benchmarks from [Vertical] production deployments available in the AI Audit Sprint deliverable and in vertical-specific case studies*

### How-To / Process (27–31)

**27.** How does an established [Vertical] platform operator get started with [AI-Feature-1] — what's the first step and why shouldn't it be skipped? — 🟢 **S2** *| P5·P1·P2 | "How It Works" section | Hook: free AI Readiness Call (1 hour — confirms [Platform-Type] traction, data availability, and whether [AI-Feature-1] scope makes sense before any commitment); if confirmed fit: sign a paid AI Audit Sprint ($1,500–$4,000, credited); 2 weeks later: [AI-Feature-1] priority map + cost estimate + data verdict delivered before any build commitment; skipping the Audit Sprint to save $2k–$4k and going straight to a $30k build is the most common way [Vertical] AI projects fail*

**28.** How does A/B testing work for [AI-Feature-1] deployed into a live [Platform-Type] — and how is [Outcome-Metric-1] improvement measured without disrupting active [Provider]s? — 🟢 **S2** *| P5·P1 | FAQ | Hook: traffic-split rollout (10% → 25% → 50% → 100% over 4–6 weeks); control group remains on existing [Vertical] rule-based logic; [Outcome-Metric-1] and [Outcome-Metric-2] tracked for both groups; A/B test is the acceptance gate for the full engagement — [AI-Feature-1] is not signed off until lift is demonstrated vs rule-based baseline in production on real [Provider]s and [User]s*

**29.** How do I evaluate whether an AI engineering team truly understands [Vertical] platform operations — specifically [Domain-Edge-Cases] — before committing to a $50k+ [AI-Feature-1] build? — 🟢 **S2** *| P1·P5 | FAQ + due-diligence block | Hook: ask for a [Vertical]-specific case study with named [Outcome-Metric-1] improvement and methodology disclosed; request a pre-contract engineer introduction (not the sales rep — the engineers who will build [AI-Feature-1]); ask specifically how [Domain-Edge-Cases] are handled in the [AI-Feature-1] model design; the AI Audit Sprint is the lowest-risk evaluation path: 2 weeks, credited, escape hatch*

**30.** How do I build a board-defensible ROI case for [AI-Feature-1] investment in my [Vertical] platform — what numbers should I present? — 🟢 **S2** *| P1·P2 | FAQ | Hook: ROI frame for [Vertical] — A/B-tested [Outcome-Metric-1] lift × business-value conversion (illustrative AI-first example only — for ride-hailing: driver revenue/hr +15% × avg driver hours/week × active driver count × commission rate = annual upside); AI Audit Sprint deliverable includes an ROI scenario model seeded with [Vertical] benchmarks; at typical [Vertical] lifts, payback on a $25k [AI-Feature-1] build is 60–120 days for a $1M+ ARR platform.* **For travel/social/education (platform-delivery-first verticals):** do NOT use the AI lift % example — substitute a platform-delivery ROI analog: *"10×-faster MVP-to-production vs in-house team × engineering team cost × months saved"* or *"$X saved vs Accenture-class delivery × N projects/year"*. AI lift claims violate the no-AI-outcome-claims rule for these verticals per AI Keyword Targeting Gate.*

**31.** How does [AI-Feature-2] get sequenced after [AI-Feature-1] is live on a [Platform-Type] — data dependencies, timing, and how the quarterly AI roadmap works? — 🟢 **S2** *| P5·P1 | FAQ | Hook: [AI-Feature-2] often depends on [AI-Feature-1] data (e.g., [Vertical]'s demand forecasting relies on the event data that intelligent dispatch produces); the AI Audit Sprint maps this dependency chain; [AI-Feature-1] goes live → A/B test produces clean outcome data → that data becomes [AI-Feature-2]'s training set → [AI-Feature-2] scoped in the quarterly roadmap review and built in the next engagement*

### Voice Search Rotation (32–34)

**32.** Does an AI engineering partner support [AI-Feature-1] on my [Platform-Type] after go-live — monitoring, model drift, retraining — or is that a separate contract? — 🟢 **S2** *| P1·P2 (trust trigger) | FAQ | Hook: post-delivery support included — monitoring setup (Datadog dashboard tracking [Outcome-Metric-1] against [AI-Feature-1] vs rule-based baseline), alert thresholds configured, model drift detection schedule agreed; quarterly AI roadmap review surfaces retraining triggers and [AI-Feature-2] scoping; not a project that ends when [AI-Feature-1] goes live*

**33.** Can [AI-Feature-1] be added to my existing [Platform-Type] tech stack without a full codebase rewrite — even if the platform was built years ago? — 🟢 **S2** *| P5·P1·P2 | FAQ | Hook: service-isolation means [AI-Feature-1] runs as a separate service consuming your existing [Platform-Type] API; any tech stack (Laravel/PHP, Python/Django, Node.js, Ruby on Rails) is compatible as long as an API layer exists; the [Platform-Type] core is untouched; [AI-Feature-1] adds to the platform, it does not refactor it*

**34.** Will [AI-Feature-1] make my [Platform-Type] unstable if the model underperforms or the inference latency spikes during peak hours? — 🟢 **S2** *| P5·P1 | FAQ | Hook: the service-isolation + rule-based fallback architecture is designed exactly for this; [AI-Feature-1]'s inference has a latency SLA (e.g., < 200ms); if the SLA is breached, the [Platform-Type] automatically falls back to [Vertical] rule-based logic for that request; the core [Provider]-[User] flow is never in the [AI-Feature-1] failure path; this architecture is a non-negotiable delivery requirement, not an option*

### Why Now + BoFU (35)

**35.** How is the 2026 AI wave changing [Vertical] platform unit economics — and what is the concrete business cost of being the last operator in your market without [AI-Feature-1]? — 🟢 **S2** *| "Why Now" block + BoFU diligence (compressed ~400w near CTA) | P5·P1 | Hook: [Vertical] competitors shipping [AI-Feature-1] now are compounding a data advantage — every week of [AI-Feature-1] production data makes the model better; the operator who ships first in their geography builds a [Outcome-Metric-1] moat that pricing alone can't close; 8-question due-diligence checklist near CTA (vertical AI case study in my market? pre-contract engineer intro? escape hatch? IP transfer? data NDA? honest build/buy/SaaS verdict? rule-based fallback? fixed-price with acceptance condition?); anchor with Trioangle's pre-filled answers as the benchmark*

**36.** What AI compliance and regulatory exposure does my [Platform-Type] face — EU AI Act, sector AI rules (HIPAA + AI, financial AI), data residency for AI inference — and how does the engagement structure handle it? — 🟢 **S2** *| P1·P3 (compliance trigger) — Loss Reason: "Lost on AI compliance / regulatory exposure" per ICP §Loss Reasons | Compliance FAQ + sidebar callout | Hook: AI compliance is the 2026 procurement gate — EU AI Act risk tier classification (high-risk vs limited-risk vs minimal-risk for [AI-Feature-1] on a [Vertical] platform), sector rules (HIPAA + AI for healthcare adjacencies, financial AI for marketplace payment fraud detection, GDPR/CCPA for [User] data in inference), data residency requirements (where the inference runs, where the training data lives); engagement deliverables include: AI model documentation per regulatory requirement, inference data flow diagram, training data lineage, risk-tier classification, audit trail for model decisions; the AI Audit Sprint week-1 deliverable includes a compliance scoping verdict — what regulations apply to [AI-Feature-1] on a [Vertical] platform and what documentation is required pre-launch.*

---

## 🟣 CUSTOM DEV BUYER PROMPTS (CD1–CD11)

*Targets the **Custom Dev Buyer (P1/P2)** keyword cluster from LP-Plan Dev & Product rows: `[vertical] app development`, `[vertical] app development company`, `[vertical] software development`, `custom [vertical] software`, `[platform-type] development company`. Placed in the "Building or rebuilding from scratch?" mid-page section. Routes to Discovery Sprint, not AI Audit Sprint.*

> [!IMPORTANT] CD prompt sizing rationale
> Dev & Product is ~1/3 of total SEO traffic surface per LP-Plan. CD prompts must hit the same priority structure as AI prompts (S0 hero/cost/timeline → S1 comparison → S2 process/diligence) to compete for these keywords. CD is positioned as **secondary funnel** per LP-Plan three-CTA structure — but it gets real prompt weight so the page actually ranks on dev-buyer search intent.

### 🔴 CD S0 — Ship-first (CD1–CD4)

*Hero FAQ + cost/timeline + trust anchors for Custom Dev Buyer. Same priority as AI S0 prompts on the page.*

**CD1.** What is custom [Vertical] platform development for an established operator — and when does building beat using a white-label [Vertical] solution? — 🔴 **CD-S0** *| P1·P2 | Mid-page "Custom Dev" hero FAQ | Hook: custom dev fits established operators ($1M+ ARR, 12+ months production) who need proprietary architecture, integrations the white-label can't accommodate, or platform extensions on a working system; white-label fits pre-launch / pre-revenue (from $500) or operators whose feature set maps cleanly to a productized [Platform-Type]; the AI Readiness Call surfaces which path fits — no commitment, honest answer*

**CD2.** What does custom [Vertical] software development cost for an established operator — and what's actually included in a fixed-price build? — 🔴 **CD-S0** *| P1·P2 | FAQ + pricing block | Hook: fixed-price, output-based [Vertical] platform builds $10k–$120k+ depending on scope (matches ICP P1/P2 budget bands: $10k–$40k for P2 founder-operator, $30k–$80k for P1 scaling CTO); includes architecture, build, CI/CD, Day-1 GitHub access, IP transfer at delivery, dedicated PM, post-delivery support window; no monthly retainer, no hourly billing, no surprise change-order escalation*

**CD3.** How long does custom [Vertical] platform development take — from first conversation to a working production rebuild? — 🔴 **CD-S0** *| P1·P2 | Hero FAQ + timeline block | Hook: Discovery Sprint (2 weeks, $2k–$4k) → fixed-price quote agreed → build (8–16 weeks for typical [Vertical] rebuild scope, 4–8 weeks for focused extension); total 10–20 weeks from signed Sprint to live production for [Platform-Type] rebuilds; the Discovery Sprint is what makes the build timeline reliable — pre-engagement scoping eliminates the "we'll figure it out as we go" failure mode*

**CD4.** What structural guarantees protect a [Vertical] platform operator engaging an external [Vertical] development team — IP, code quality, communication? — 🔴 **CD-S0** *| P1·P2 (trust) | FAQ + guarantee block | Hook: the floor — Day-1 GitHub access (you own the [Platform-Type] repo from commit one), IP transfer clause (full codebase, docs, deployment scripts transfer at delivery), 48-hour communication SLA with 5% contract credit per breach, pre-contract engineer introduction (meet the engineers who will build the [Platform-Type], not the sales rep), Discovery Sprint escape hatch (full refund if scope or fit doesn't work at end of week 2); per ICP §Pain Point 2 (Ghosted Agency), these mechanisms exist precisely because verbal trust promises are noise after every prospect has been burned once*

### 🟡 CD S1 — Week 1 (CD5–CD7)

*Comparison + Discovery Sprint detail + alternative-paths analysis.*

**CD5.** [Vertical] app development company vs generic outsourcing or nearshore agency — what does domain-specialist depth actually give an established operator? — 🟡 **CD-S1** *| P1·P2 | Comparison block | Hook: domain-specialist = [Platform-Delivery-Count] [Vertical] platforms delivered since 2015; backend patterns ([Vertical] dispatch/commission/booking/inventory edge cases), tech-stack decisions, and integration gotchas known before week 1; generic outsourcing learns the [Vertical] domain on your dime over months 1–3; nearshore wins on raw hourly rate but loses on [Vertical]-specific architecture decisions made in week 1 that compound into 6-month rework if wrong — domain depth is what de-risks the build for $1M+ ARR operators where downtime costs more than dev rate savings*

**CD6.** What does a Discovery Sprint for a [Vertical] platform rebuild include — and how is it different from the AI Audit Sprint? — 🟡 **CD-S1** *| P1·P2 | Discovery Sprint detail block | Hook: Discovery Sprint = 2-week paid scoping ($2k–$4k) for non-AI [Vertical] platform rebuild or extension; deliverable = architecture review + scope-and-timeline + fixed-price quote + engineer introduction + risk register; **AI Audit Sprint named as Phase 2 follow-on by default** (per ICP §Pre-Sales Sprints — signing Discovery alone converts a recurring AI-feature buyer into a one-shot rebuild buyer; AI Audit must be on the roadmap); AI Audit Sprint = different deliverable (AI feature prioritization + data readiness verdict + first-feature scope)*

**CD7.** External [Vertical] development team vs hiring senior in-house engineers — which path fits a $1M+ ARR platform operator? — 🟡 **CD-S1** *| P1·P5 | Comparison block | Hook: in-house = 4–9 month hiring + onboarding + full-salary ongoing + no [Vertical] domain depth on day one + risk of key-engineer departure (ICP Loss Reason); external = Discovery Sprint (2 weeks) → fixed-price build (8–16 weeks) → live production; external wins when [Vertical] dev volume is <3–4 projects per year — at higher volume, hybrid (in-house product engineers + external [Vertical] specialist team for surge work) fits better; honest answer from the AI Readiness Call*

### 🟢 CD S2 — Week 2 (CD8–CD11)

*Diligence + post-delivery + rebuild-vs-extend + scale-then-AI sequence (Pain 1 + Pain 4 bridge).*

**CD8.** How do I evaluate a [Vertical] dev agency's engineering quality before signing a $50k+ contract — what should I ask for? — 🟢 **CD-S2** *| P1·P5 (technical diligence) | Due-diligence block | Hook: ask for (1) anonymized [Vertical] platform code samples for review, (2) architecture diagrams of past [Vertical] builds, (3) named client references in [Vertical] willing to take a 30-min call, (4) pre-contract engineer introduction — meet the engineers who will write the code, not the sales rep, (5) Day-1 GitHub commit access from the build start so you see code quality in real time, not at delivery; the Discovery Sprint is the lowest-risk evaluation path — 2 weeks, $2k–$4k, escape hatch, full architecture review delivered*

**CD9.** How does post-delivery support work for a custom-built [Platform-Type] — what happens after launch if something breaks? — 🟢 **CD-S2** *| P1·P2 (Pain Point 2 — ghosted agency) | Trust block | Hook: post-delivery support window included in the fixed-price build (typical 60–90 days of bug-fix and stability work); after the window, ongoing support is a separate engagement — quarterly retainer not offered, but priority response on incidents available via dedicated account contact; per ICP, our average client returns for at least one follow-on engagement, which is structural — we stay reachable because the relationship is the unit of repeat business, not the project*

**CD10.** When should a [Vertical] platform operator rebuild from scratch vs extend the existing codebase — and how does the Discovery Sprint help decide? — 🟢 **CD-S2** *| P1·P2 | FAQ + decision framework | Hook: rebuild when (1) the current [Platform-Type] is a legacy monolith hitting database/scaling walls, (2) the original code is undocumented and original engineers are unreachable, (3) the platform can't pass a security or compliance audit, (4) AI features require event data the current architecture can't emit; extend when (1) the platform is structurally sound but needs specific feature additions, (2) database and core services are solid, (3) the team that built it is still reachable; Discovery Sprint's first-week deliverable is the rebuild-vs-extend verdict with cost estimates for each path — honest answer, not a sales pitch for the bigger build*

**CD11.** Our [Platform-Type] is hitting scaling walls AND we want AI features — should we rebuild first, then add AI? Or run both in parallel? How do we ship fast without burying ourselves in tech debt? — 🟢 **CD-S2** *| P1·P2 (Pain 1 + Pain 4) | Bridge to AI track | Hook: per [[Trioangle - ICP - Service]] §Persona 1, the right sequence is **rebuild for scale first, then AI features on the cleaned architecture** — not parallel. Reasons: (1) AI features require clean event data; if your event pipeline is broken or absent, the AI model trains on garbage → poor production outcomes regardless of model quality. (2) Service isolation for AI requires a stable API boundary; a scaling rebuild fixes the API surface, then AI plugs in. (3) Speed-vs-quality (Pain 4): rushing AI onto an unstable platform compounds tech debt — you end up rebuilding AI features later when the platform changes. **Recommended path**: Discovery Sprint (scope rebuild, 2 wks) → fixed-price platform rebuild (8–16 wks) → AI Audit Sprint (Phase 2, 2 wks, credited) → first AI feature ([AI-Feature-1], 4–8 wks). Total 16–28 weeks for stable platform + first AI feature live. The Discovery Sprint surfaces whether you can run a focused AI feature on the existing platform earlier — if data quality is already acceptable, AI Audit Sprint can run in parallel with the rebuild.*

---

## 🟤 WHITE-LABEL ROUTING PROMPTS (WL1–WL2)

*Targets the **White-Label Buyer (Product ICP)** keyword cluster from LP-Plan Dev & Product rows: `white-label [vertical] solution`, `white-label [vertical] platform`, `ready-to-launch [vertical] app`. Placed in the qualification block and lower section of the page. **Route, don't sell** — these visitors go to the Product catalog, out of Service ICP scope.*

> [!IMPORTANT] No "clone" language on industry landing pages
> Industry pages must NEVER use "clone," "clone script," "Uber-clone," "Airbnb-clone," "Gojek-clone," or any "-clone" framing. Use **"white-label [Vertical] solution,"** **"ready-to-launch [Platform-Type],"** or **"productized [Vertical] platform"** instead. Internal Product-ICP shorthand stays internal; buyer-facing copy on industry LPs uses white-label / productized language.

**WL1.** Looking for a white-label [Vertical] solution to launch fast without custom development — what are the options? — 🟢 **WL-S2** *| Pre-traction / fast-launch buyer | Qualification block + lower-section routing | Hook: ready-to-launch white-label [Platform-Type] solutions available from Trioangle's Product line — proven [Vertical] feature set, launch in weeks not months, from $500; this Service page targets established operators with revenue traction needing custom AI engineering or platform rebuild work; pre-launch / pre-revenue → route to white-label products directly (linked above); not a rejection — a different SKU fit*

**WL2.** When does a white-label [Vertical] solution make sense vs custom [Vertical] development? — 🟢 **WL-S2** *| Buyer routing | Lower section copy | Hook: white-label fits when (1) the platform doesn't exist yet (pre-launch), (2) the standard [Vertical] feature set is enough, (3) speed-to-market matters more than proprietary architecture, (4) budget is <$10k; custom dev fits when the operator already has a working platform with $1M+ ARR and needs proprietary architecture, AI features, or platform extensions; the AI Readiness Call (free, 1 hr) confirms which path fits — no commitment, honest answer*

---

# 📐 INDUSTRY PAGE ARCHITECTURE

```
trioangle.com/industries/[Vertical-Slug]
~3,500–5,500 words (expanded for full three-CTA coverage)

┌───────────────────────────────────────────────────────┐
│  HERO (~600w)                                         │
│  H1: [Vertical]-specific headline (from LP-Plan)      │
│  Trigger subhead: [Trigger-Subhead] (LP-Plan verbatim)│
│  Hero subheads (one-sentence each): prompts 1, 2, 6   │
│  Pillar body (~600w synthesis): prompts 9 + 10        │
│  🥇 PRIMARY CTA: Book a Free AI Readiness Call        │
├───────────────────────────────────────────────────────┤
│  QUALIFICATION BLOCK (~80w) — mandatory copy          │
│  "Built for established operators... pre-launch       │
│   → see our white-label products instead."            │
├───────────────────────────────────────────────────────┤
│  AEO FAQ ANCHORS (~400w)                              │
│  Rotate 8–10 AEO prompts from: 1,2,3,4,5,6,7,8        │
│  + 23,24,25,26,32,33,34 (40–50w each, FAQPage schema) │
├───────────────────────────────────────────────────────┤
│  COMPARISON TABLE (~200w)                             │
│  Prompts 11, 12, 13, 14 → single comparison block     │
├───────────────────────────────────────────────────────┤
│  SCENARIO BLOCKS (~600w)                              │
│  Prompts 15, 16, 17 → 3 × ~200w "If you're…" blocks   │
├───────────────────────────────────────────────────────┤
│  TECH DEPTH (~600w)                                   │
│  Prompts 18, 19, 20 → single credibility section      │
├───────────────────────────────────────────────────────┤
│  HOW IT WORKS / PROCESS (~400w)                       │
│  Prompts 27, 28 → 2-step process block                │
│  🥇 REPEAT AI CTA: "Already have a working platform?  │
│   Explore AI features" → AI Readiness Call            │
├───────────────────────────────────────────────────────┤
│  CUSTOM DEV BLOCK (~1,200w) — 🥈 SECONDARY CTA        │
│  Section: "Building or rebuilding from scratch?"      │
│  CD Hero FAQ: CD1, CD2, CD3, CD4 (~500w)              │
│  CD Comparison: CD5, CD6, CD7 (~400w)                 │
│  CD Diligence/Process: CD8, CD9, CD10 (~300w)         │
│  🥈 CTA: Book a Discovery Sprint ($2k–$4k)            │
├───────────────────────────────────────────────────────┤
│  WHITE-LABEL ROUTING (~200w) — 🥉 TERTIARY CTA        │
│  Section: "Need a fast launch? Skip custom dev."      │
│  Prompts WL1, WL2 → White-Label Buyer routing         │
│  🥉 CTA: View white-label products & pricing          │
├───────────────────────────────────────────────────────┤
│  WHY NOW (~300w)                                      │
│  Prompt 35 (first half) → AI-era economics for        │
│  [Vertical] specifically                              │
├───────────────────────────────────────────────────────┤
│  BoFU + CTA (~400w)                                   │
│  Prompt 35 (second half, 8-question checklist)        │
│  + Prompt 29 (due-diligence callout)                  │
│  + FOOTER: All three CTAs visible (AI / Dev / WL)     │
└───────────────────────────────────────────────────────┘
  Block-sum: ~4,980w (600+80+400+200+600+600+400+1,200+200+300+400)
  Target: 3,500–5,500w  ·  Headroom: ~520w
```

### AEO Snippet Placements
- **Hero subheadings**: prompts 1, 2, 6 — one sentence each answering the vertical-specific first-look question
- **AI-track FAQ block** (with `FAQPage` JSON-LD): rotate **8–10 prompts at 40–50w each** to fit the ~400w budget; prioritise 1, 2, 3, 4, 5, 6, 7, 8 (S0 hero/voice anchors), then add from 23, 24, 25, 26, 32, 33, 34 (S2 rotation) if space allows
- **Custom Dev FAQ block** (separate `FAQPage` JSON-LD inside Custom Dev section): rotate 4–6 CD prompts; prioritise CD1, CD2, CD3, CD4, CD6, CD9 — these are CD-S0/CD-S1 hero FAQs that anchor the dev funnel
- **Inline callout boxes**: prompts 25 (rule-based fallback), 26 (outcome benchmark), 22 (build/buy/SaaS), CD4 (CD structural guarantees) — each 40–60 words next to the relevant section

### GEO Compressed Block Placements
- **Hero pillar** — synthesize prompts 9 + 10 into ~600w block
- **Comparison table** — prompts 11, 12, 13, 14 → single table (~200w)
- **Scenario blocks** — prompts 15, 16, 17 → 3 × ~200w "If you're [persona in Vertical]…" blocks
- **Tech depth** — synthesize prompts 18, 19, 20 → ~600w block with [Domain-Edge-Cases] named
- **Why Now** — prompt 35 first half → ~300w block with [Vertical]-specific AI economics
- **BoFU checklist** — prompt 35 second half → ~300w 8-question block near CTA

### Three-CTA Structure (mandatory on every industry page)

Per [[Trioangle Landing Page Plan]] §Buyer Routing & Qualification — every industry page surfaces **three CTAs**, ordered to match buyer intent. A single AI-only CTA burns 2/3 of the SEO traffic (custom dev keywords + white-label keywords). Each CTA targets a different keyword cluster and routes to a different funnel.

| Order | Buyer | Keyword intent | CTA | Funnel destination |
|---|---|---|---|---|
| 🥇 **Primary** | **AI Buyer (P5)** | `AI for [vertical]` · `AI [feature] for [vertical]` | **Book a Free AI Readiness Call** → AI Audit Sprint ($1.5k–$4k, credited) | Service ICP — AI track |
| 🥈 **Secondary** | **Custom Dev Buyer (P1/P2)** | `[vertical] app development company` · `custom [vertical] software` | **Book a Discovery Sprint** ($2k–$4k, 2-week paid scoping) — AI Audit named as Phase 2 follow-on | Service ICP — Dev track |
| 🥉 **Tertiary** | **White-Label Buyer (Product ICP)** | `white-label [vertical] solution` · `ready-to-launch [vertical] app` · `productized [vertical] platform` | **View white-label products & pricing** | Product ICP (route, don't sell) |

**Placement order on the page** (per LP-Plan):
1. Hero CTA = AI Buyer (primary pitch, AI-first positioning)
2. Mid-page section = *"Already have a working platform? Explore AI features"* — repeats AI CTA
3. Lower section = *"Building from scratch?"* — routes Custom Dev or White-Label depending on copy variant
4. Footer = all three CTAs visible

> [!NOTE] AEO interpretation of "Custom Dev OR White-Label depending on copy variant"
> The LP-Plan says the lower section routes to one or the other "depending on copy variant." This AEO spec instead places **both** sections sequentially on every page (CD block ~1,200w followed by WL routing ~200w) — for two reasons: (a) the CD section is the Service-ICP-aligned conversion path and gets the depth; (b) the WL section is just lightweight routing (2 prompts, ~200w) for pre-traction visitors who don't qualify for either Service-ICP funnel. This is heavier than the LP-Plan's "either/or" wording implied, but the LP-Plan's intent — *don't burn the dev or white-label keyword surface* — is satisfied. Per-vertical copy variants may still A/B test which section appears first based on buyer-mix data; the AEO spec doesn't lock the order, just guarantees both sections are present.

> [!IMPORTANT] P3/P4 routing happens at the booking form, NOT on the page
> Per LP-Plan §Buyer Routing: *"The page copy stays unchanged. The qualification happens in the booking form and the first call, not on the page."* Do not surface P3 (Enterprise) or P4 (MENA) CTAs on industry pages. Booking-form logic detects enterprise email domains + RFP language (route to enterprise channel partner) or UAE/KSA/Qatar email/phone + Arabic name (route to MENA channel partner). Standard inbound (P1/P2/P5) runs AI Readiness Call directly.

### Internal Links (required on every industry page)
- Up to parent: `← Industries` (`/industries`)
- Down to Pillar 7 Blog: link to the Pillar 7 article for this vertical (e.g., *"How intelligent dispatch AI works end-to-end for a ride-hailing platform"*)
- Cross to relevant `/ai-engineering/` service pages — when an [AI-Feature] on this page has a dedicated service page, link to it (e.g., social-media → `/ai-engineering/ai-content-moderation`; marketplace → `/ai-engineering/ai-search-upgrade` + `/ai-engineering/ai-content-moderation`; home-services → `/ai-engineering/ai-customer-support-bot` + `/ai-engineering/voice-ai-development`; education → `/ai-engineering/ai-customer-support-bot`; super-app → `/ai-engineering/ai-agents-automation`)
- Cross to adjacent verticals: 2–3 relevant related industry pages

### Schema Stack
- `Organization` (Trioangle) — sitewide
- `Service` (scoped to [Vertical]: *"AI Engineering for [Vertical] Platforms"*) — on this page
- `FAQPage` **(AI-track, 8–10 prompts)** — in the AEO FAQ Anchors block; phrased with [Vertical] + [AI-Feature] language, not "Trioangle" in questions
- `FAQPage` **(Custom Dev, 4–6 CD prompts)** — inside the Custom Dev section; phrased with [Vertical] + dev/Discovery Sprint language
- `BreadcrumbList` (Home > Industries > [Vertical])
- `AggregateRating` — only when Clutch/G2 has ≥10 verified reviews tagged with [Vertical]

---

# 🎯 CONTENT PRIORITY MATRIX

| Priority | Prompts | Type | On-Page Block | Compressed To |
|----------|---------|------|---------------|---------------|
| 🔴 **S0** | 9 + 10 | GEO Hero synthesis | Hero pillar | ~600w |
| 🔴 **S0** | 1, 2, 3, 4, 5, 6, 7, 8 | AEO Hero/FAQ + Voice anchors | FAQ block + hero subheads | ~400w (8 × 40–50w) |
| 🟡 **S1** | 11, 12, 13, 14 | AEO Comparison | Single comparison table | ~200w |
| 🟡 **S1** | 15, 16, 17 | GEO Scenario | 3 "If you're…" mini-blocks | ~600w (3 × ~200w) |
| 🟡 **S1** | 18, 19, 20 | GEO Tech-depth | Single tech credibility section (with [Domain-Edge-Cases] named) | ~600w |
| 🟢 **S2** | 21, 22, 23, 24, 25, 26 | AEO Definition rotation | Expanded FAQ + pricing block + guarantee block | ~400w (rotate 4–6) |
| 🟢 **S2** | 27, 28, 29, 30, 31 | AEO How-To | FAQ + sidebar callouts + "How It Works" section | ~400w (rotate) |
| 🟢 **S2** | 32, 33, 34 | AEO Voice rotation | FAQ inline | ~200w |
| 🟢 **S2** | 35 | GEO Why Now + BoFU | "Why Now" block + 8-question checklist near CTA | ~600w |
| 🟢 **S2** | 36 | AEO Compliance | AI compliance FAQ + sidebar callout (EU AI Act / sector regs) | ~150w |
| 🔴 **CD-S0** | CD1, CD2, CD3, CD4 | Custom Dev Hero FAQ + pricing + timeline + guarantees | "Building or rebuilding from scratch?" section block | ~500w |
| 🟡 **CD-S1** | CD5, CD6, CD7 | Custom Dev comparison + Discovery Sprint detail + alternative-paths | Custom Dev comparison block | ~400w |
| 🟢 **CD-S2** | CD8, CD9, CD10, CD11 | CD diligence + post-delivery + rebuild-vs-extend + scale-then-AI sequence | Custom Dev BoFU/FAQ rotation + Pain 1/4 bridge | ~400w |
| 🟢 **WL-S2** | WL1, WL2 | White-Label routing | Qualification block + lower-section routing | ~200w |

**Total industry page word budget: ~3,500–5,500 words** (expanded for full three-CTA coverage).

---

# 👥 PERSONA → SECTION MAP

| Persona | Buyer Track | Must-Have Sections |
|---------|-------------|--------------------|
| **P5 — AI-Forward Platform Operator** | 🥇 AI Buyer | Hero (9,10) + Trigger subhead → AEO FAQ (1,2,6,7,8) → Comparison (11,13,14) → Tech depth (18,19,20) → Why Now (35) → AI Readiness Call CTA |
| **P1 — Scaling CTO (AI-curious)** | 🥇 AI Buyer | Hero (9,10) → AEO FAQ (3,5,7,8) → Comparison (11,12) → Tech depth (18,19) → Due diligence (29,35) → Structural guarantee callout (24) → AI Readiness Call CTA |
| **P1 — Scaling CTO (rebuild brief, Pain 1 + Pain 4)** | 🥈 Custom Dev Buyer | Hero → Qualification block → CD Hero FAQ (CD1, CD2, CD3, CD4) → CD Comparison (CD5, CD7) → CD Diligence (CD8) → CD Bridge to AI (CD11 scale-then-AI) → Discovery Sprint CTA — AI Audit named as Phase 2 follow-on |
| **P2 — Non-Technical Founder-Operator (AI scope)** | 🥇 AI Buyer | Hero (9,10) → AEO FAQ (1,2,4) → Scenario (16) → How It Works (27,28) → ROI (30) → Guarantee (24) → AI Readiness Call CTA → AI Audit Sprint follow-on |
| **P2 — Founder-Operator (rebuild brief, Pain 4)** | 🥈 Custom Dev Buyer | Hero → Qualification block → CD Hero FAQ (CD1, CD2, CD3, CD4) → CD Decision (CD10 rebuild-vs-extend) → CD Trust (CD9) → CD Bridge to AI (CD11) → Discovery Sprint CTA — AI Audit named as Phase 2 |
| **P3 inbound — enterprise compliance gate** | 🤝 Channel-partner only | Hero → AEO FAQ (1, 5) → AI Compliance FAQ (Prompt 36) → Structural guarantee (24) — booking-form layer routes to enterprise channel partner; page copy unchanged |
| **Pre-traction / fast-launch buyer** | 🥉 White-Label Buyer | Qualification block (routes to white-label products) → White-Label section (WL1, WL2) → Product catalog CTA *(out of Service ICP scope — route, don't sell)* |

> [!NOTE] CD4 placement — same prompt, same position for both rebuild-brief personas
> CD4 (structural guarantees: Day-1 GitHub, IP transfer, 48-hr SLA, engineer intro, Discovery Sprint escape hatch) is placed in the **CD Hero FAQ block** for both P1 and P2 rebuild-brief personas. ICP Pain Point 2 (Ghosted Agency) hits both personas hard — putting CD4 high on the page (hero FAQ, not trust block) is what un-blocks the trust conversation early. CD9 (post-delivery support) stays in the dedicated trust block since it's a different concern (what-happens-after-launch).

> [!NOTE] P3/P4 — no on-page mapping
> Per LP-Plan §Buyer Routing, P3 (Enterprise) and P4 (MENA) qualification happens at the booking form, not on the page. They see the same content as P1/P2/P5. The form detects enterprise email domain + RFP language → enterprise channel partner; UAE/KSA/Qatar email + Arabic name → MENA channel partner.

---

# ✅ INDUSTRY PAGE COMPLIANCE CHECK

Before publishing any industry page section generated from these prompts, verify:

- [ ] **[Vertical] language used throughout** — search-side prompts use the vertical's own vocabulary, not generic "AI engineering" framing; a ride-hailing operator and a marketplace operator see completely different hero copy
- [ ] **[Domain-Edge-Cases] named explicitly** in tech-depth section — this is the primary differentiator from generic AI agency pages and is what AI engines cite as evidence of domain expertise
- [ ] **[AI-Feature-1] named as primary** — the page is not a generic "AI engineering" page; it leads with the single most impactful AI feature for this vertical and names it in the H1 or hero subhead
- [ ] **[Outcome-Metric-1] improvement framed as A/B-tested** — no vague "efficiency gains"; named metric + A/B methodology
- [ ] **Platform delivery count framed correctly** — "800+ platforms since 2015" or vertical-specific counts ("100+ ride-hailing," "40+ travel," etc.) per Landing Page Plan; never claim "800+ AI features"
- [ ] **AI feature delivery count not conflated with platform delivery count** — AI Engineering launched 2026; vertical-specific AI case studies are the only valid AI-delivery proof
- [ ] **Service-isolation + rule-based fallback** described at least once — critical for P5/P1 who will specifically ask about platform stability
- [ ] **Structural guarantees named by mechanism** (Day-1 GitHub, IP transfer, 48-hr SLA, pre-contract engineer intro, Sprint escape hatch — AI Audit *or* Discovery, both carry full-refund escape hatch) — not verbal promises
- [ ] **No "faster with AI" or "AI-powered development" claim** — frame on vertical domain expertise and certainty of delivery
- [ ] **No retainer language** in pricing block or CTAs — fixed-price, output-based only
- [ ] **No "clone" language anywhere on page** — never "clone," "clone script," "Uber-clone," "Airbnb-clone," "Gojek-clone." Use "white-label [Vertical] solution," "ready-to-launch [Platform-Type]," or "productized [Vertical] platform" instead
- [ ] **Qualification copy block uses LP-Plan verbatim** — routes pre-traction buyers to white-label, does not reject them
- [ ] **Trigger subhead present in hero** — vertical-specific copy from LP-Plan (e.g., ride-hailing: *"A vertical competitor just shipped AI dispatch..."*); pages without trigger language explain WHAT, pages with it explain WHY NOW
- [ ] **Three CTAs visible on page** — 🥇 AI Buyer (primary, hero + mid + footer) · 🥈 Custom Dev Buyer (mid-page section) · 🥉 White-Label Buyer (lower section + footer)
- [ ] **CTA placement order matches LP-Plan** — hero AI · mid-page repeat AI · lower-section Custom Dev or White-Label · footer all three
- [ ] **Dev & Product keyword cluster covered in CD section** — page must rank for `[vertical] app development company`, `custom [vertical] software`, `[platform-type] development company`, and at least 3 vertical-specific dev keywords from LP-Plan Dev & Product row
- [ ] **Discovery Sprint pricing visible in CD section** — `$2k–$4k` price anchor appears in CD2 + CD6 + the Custom Dev CTA copy; without this, the dev funnel CTA reads as ambiguous
- [ ] **Scale-then-AI sequence covered (CD11)** — for P1/P2 buyers with Pain 1 (scalability) + Pain 4 (speed vs quality), the page covers the recommended rebuild-first-then-AI path with timeline math (16–28 weeks total); ICP §Persona 1 entry-conversation pattern reflected
- [ ] **AI compliance covered (Prompt 36)** — EU AI Act risk tier, sector AI rules (HIPAA + AI, financial AI), data residency, model documentation requirements; this is the 2026 procurement gate per ICP Loss Reasons
- [ ] **Diversified social proof** — at least 2 proof points beyond "[Platform-Delivery-Count] platforms since 2015" (Phase 2 return rate, time-to-launch benchmark, uptime, cost vs in-house, sprint velocity, client NPS); each measured or labeled as target
- [ ] **Soft-touch CTA for vendor-fatigue visitors** — empathy-first 45-min architecture review CTA placed in lower-page footer block; no commercial conversation; per ICP §Pause Signals + Content Strategy Article #79
- [ ] **AI Audit Sprint escape hatch claim verified** — currently claimed in Prompt 24 + Trust positioning rule; pending Trioangle confirmation that AI Audit Sprint actually carries a full-refund escape hatch (ICP names only Discovery Sprint escape hatch)
- [ ] **P3/P4 routing happens at booking form, NOT on the page** — no enterprise/MENA CTAs surfaced; booking form detects enterprise email domain or UAE/KSA/Qatar contact and routes to channel partner
- [ ] **For travel/social/education only — platform-delivery-first framing** — H1 leads with `[Platform-Delivery-Count]` (40+/20+/10+) and "since 2015"; AI features framed as "on the roadmap"; AI keyword clusters NOT targeted in active SEO/paid until production cases land
- [ ] **Internal links in place** — parent page (`/industries`) + Pillar 7 blog article for this vertical + 2–3 adjacent industry pages + relevant `/ai-engineering/` service pages
- [ ] **Schema stack live** — `Organization` + `Service` (vertical-scoped) + **two `FAQPage` schemas** (AI-track FAQ block 8–10 prompts + Custom Dev FAQ block 4–6 CD prompts) + `BreadcrumbList`

---

**Total Prompts:** 49 per industry page (36 AI-track + 11 Custom Dev + 2 White-Label routing) | **9 pages via variable substitution**
**Priority Split:** 🔴 S0 (1–10 AI + CD1–CD4 Custom Dev) · 🟡 S1 (11–20 AI + CD5–CD7 Custom Dev) · 🟢 S2 (21–36 AI + CD8–CD11 Custom Dev + WL1–WL2 White-Label routing)
**Vertical Slugs:** `ride-hailing` · `delivery` · `marketplace` · `home-services` · `ecommerce` · `super-app` · `travel` * · `social-media` * · `education` *  *(* = platform-delivery-first framing, AI on roadmap)*
**Source Landing Page Plan:** [[Trioangle Landing Page Plan]] | **Source ICP:** [[Trioangle - ICP - Service]] | **Sibling LP:** [[AI_Service_Landing_Page_AEO_GEO_Prompts]] (covers `/ai-engineering/` cluster) | **Track:** Track 2 ([[Trioangle Growth Plan]])
