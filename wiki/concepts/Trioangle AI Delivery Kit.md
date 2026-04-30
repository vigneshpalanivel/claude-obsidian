---
type: concept
title: "Trioangle AI Delivery Kit"
created: 2026-04-28
updated: 2026-04-28
tags:
  - concept
  - trioangle
  - ai-delivery
  - internal-platform
  - ip-moat
status: planned
related:
  - "[[Trioangle 2.0 AI Pivot Plan]]"
  - "[[Retrieval-Augmented Generation (RAG)]]"
  - "[[AI Agents]]"
  - "[[LLMOps and AI Observability]]"
  - "[[AI Application Stack]]"
  - "[[LangGraph]]"
---

# Trioangle AI Delivery Kit

Internal toolkit that turns each AI engagement from "build from scratch" into "configure from templates." Not a public product — an internal asset that compounds Trioangle's delivery throughput and gross margin per package.

This is the IP version of what TCS calls "AI WisdomNext" and Infosys calls "Topaz Fabric" — the same open-source stack, wrapped in Trioangle's delivery process and domain knowledge for SMB-scale AI projects.

---

## Why It Exists

Without the kit: every AI project starts from a blank repo. Engineers redo the same RAG plumbing, observability wiring, integration glue. Two-week delivery times stay at two weeks forever. Margin compresses as competitors productize.

With the kit:
- Repeat-package delivery drops from **2 weeks → 3–5 days**
- Throughput per engineer rises without adding headcount
- Trioangle bills **IP, not hours** — the same package costs the same to deliver but takes a fraction of the engineer time
- Quality is consistent across customers because the production-tested defaults are baked in
- New engineers ramp faster — they configure, they don't architect

This is how the AI track scales without a linear team-size increase. Phase 4's >60% template-reuse target depends on the kit being real and maintained.

---

## What's In It

### 1. RAG Pipeline (Pre-Configured)
- LangChain + pgvector default stack
- Document ingestion templates (PDF, web scrape, API pull, CSV)
- Chunking + embedding defaults tuned for English SMB content
- Retriever + reranker configurations
- Per-customer eval harness (RAGAS faithfulness + answer relevance)
- See [[Retrieval-Augmented Generation (RAG)]] for the underlying pattern

### 2. Agent Templates (Horizontal)
Reference implementations for the productized packages — work in any vertical:
- **Customer Support Bot** template (LangGraph state machine, tool-calling pattern, escalation handler)
- **WhatsApp AI Automation** template (Twilio/WhatsApp Business API + LangGraph + structured-output parser)
- **Lead Qualifier** template (form/chat capture → enrichment → scoring → CRM webhook)
- **Content Moderation** template (multi-stage classifier + human review queue)
- **Search Upgrade** template (semantic + keyword hybrid + reranker)
- See [[AI Agents]] and [[LangGraph]]

### 2b. Vertical-Tuned Templates (Domain Depth from 800+ Deployments)
Variants of the horizontal templates with vertical-specific edge cases pre-baked from Trioangle's existing delivery experience across 8 verticals (see [[Trioangle Product ICP]]). These are the moat — net-new SMB AI agencies don't have these.

| Vertical | Vertical-Tuned AI Templates |
|---|---|
| **Ride-Hailing & Transport** | Dispatch optimization (driver supply curves, surge logic), AI fraud detection (fake-trip patterns), driver-side support bot (multi-language) |
| **Delivery & Logistics** | Demand forecasting (peak windows, weather-adjusted), route optimization, stock-out prediction for grocery, customer support for delivery edge cases |
| **Travel & Hospitality** | Booking assistant (Makent/Airbnb-style availability + rules), price-recommendation per listing, host/property-side moderation |
| **Social & Entertainment** | Content moderation at scale (PopTok, Igniter), feed personalization, comment-toxicity handling, dating-app safety patterns |
| **Multi-Service / Super App** | Service routing AI (which Gojek service the user actually wants), cross-service recommendation, unified support across taxi/delivery/handyman |
| **On-Demand Home Services** | Booking assistant with provider matching, review-analysis for quality flags, dynamic pricing for trade services |
| **Commerce & Marketplaces** | Marketplace fraud detection (PassUp/OLX patterns), listing-quality scoring, semantic search for product catalogs |
| **Education** | Learning-path recommendation, AI-graded short answers, course-discovery search |

These vertical templates are documented from existing delivery muscle, not invented. Each new project in a vertical refines the corresponding template; the kit compounds as Trioangle ships more in that vertical.

### 3. Observability Stack (Pre-Wired)
- Langfuse (free tier) trace + cost tracking
- Eval scheduling (daily faithfulness + relevance checks against held-out test set)
- Cost alert rules (per-customer monthly cap, per-request anomaly threshold)
- Drift monitoring on input distribution (input length, token mix, language)
- Per-customer dashboard template (auto-provisioned per project)
- See [[LLMOps and AI Observability]]

### 4. Integration Connectors
Pre-built adapters that show up in 80% of SMB AI projects:
- **Razorpay** (payment gateway integration for transactional AI flows)
- **WhatsApp Business API** (messaging in/out)
- **Shopify** (product catalog, order webhook)
- **Stripe** (international payment flows)
- **CRM webhooks** (HubSpot, Pipedrive, Zoho generic adapters)
- **Email** (SendGrid + Resend default templates)

### 5. Delivery Operations
- **Deployment scripts** — one-command deploy to AWS/GCP/Hetzner (Trioangle's three default stacks)
- **Client handover checklist** — code repo, observability access, eval baseline, runbook, rollback procedure
- **Documentation template** — auto-generates per-project docs from the configured kit (architecture, integration map, eval baselines, ops runbook)
- **Per-project IP separation** — kit components stay Trioangle-owned; client deliverable is the configured + extended instance + full handover

---

## Maturity Curve

| Phase | Target | What it looks like |
|---|---|---|
| **Phase 1 (M4–6)** | 0% | Engineers building each project from scratch; collecting reusable patterns into a private repo |
| **Phase 2 (M7–10)** | v1 documented; >30% template-reuse on repeat-package types | After 10–15 projects, the kit gets named, documented, and version-controlled. New AI Customer Support Bot deals start from the template. |
| **Phase 3 (M11–14)** | >50% template-reuse | Most repeat-package types start from kit. New package types added to kit as they emerge. |
| **Phase 4 (M15–18)** | >60% template-reuse; 1–2 components open-sourced | Kit is the default starting point for all AI work. Selected non-differentiating components open-sourced for credibility + inbound SEO. |

---

## What This Buys vs. Selling Hours

| Without Kit | With Kit |
|---|---|
| Each AI Customer Support Bot deal: ~2 weeks engineering | ~3–5 days engineering |
| Same price ($900–$2,500) | Same price ($900–$2,500) |
| Margin: ~baseline | Margin: 2–3x baseline |
| Capacity: ~1 deal per engineer per 2 weeks | Capacity: ~3 deals per engineer per 2 weeks |

**This is how Trioangle escapes "billing hours" without raising prices.** Same package, same client experience, fundamentally different cost structure.

---

## What This Is NOT

- **Not a SaaS product** — Trioangle does not sell the kit. Clients receive the *output* of the kit (their configured AI), not access to the kit itself.
- **Not a public framework** — selected components might get open-sourced in Phase 4 for credibility, but the integrated kit is internal.
- **Not a replacement for foundation models** — the kit wraps OpenAI / Anthropic / Vertex; it does not compete with them.
- **Not a one-time build** — the kit is maintained continuously. Each new project either reuses the kit (90% of the time) or extends it (10%).

---

## Risks

| Risk | Mitigation |
|---|---|
| Kit becomes stale faster than projects are delivered | Each project's lessons go back into the kit at handover; quarterly kit review by AI R&D Pod |
| Engineers bypass the kit ("I'll just rebuild this faster") | Head of Delivery enforces kit-first; bypass requires written justification |
| Kit becomes too rigid (every new project needs extension) | Track extension rate; if >30% of projects need core changes, kit needs refactor not just patching |
| Open-sourced components leak Trioangle's competitive advantage | Open-source only non-differentiating glue (e.g., a single connector); never the integrated stack |

---

## Connections

- [[Trioangle 2.0 AI Pivot Plan]] — the kit is a Phase 2 deliverable inside the pivot
- [[AI Application Stack]] — architectural reference the kit implements
- [[Retrieval-Augmented Generation (RAG)]] — RAG pipeline component
- [[AI Agents]] — agent templates pattern
- [[LangGraph]] — primary orchestration framework in agent templates
- [[LLMOps and AI Observability]] — observability stack the kit wires in by default
- [[Indian IT AI Transformation Strategy]] — competitive context (TCS WisdomNext, Infosys Topaz Fabric are the equivalent at enterprise scale)
