---
type: concept
title: "Trioangle Service Landing Page AI Tech Stack"
status: current
created: 2026-06-23
updated: 2026-06-23
source: ".raw/Trioangle/Trioangle Service Landing Page - AI Tech Stack.md"
tags:
  - concept
  - trioangle
  - marketing
  - landing-pages
  - ai-engineering
  - tech-stack
  - ai-pivot
related:
  - "[[Trioangle Landing Page Plan]]"
  - "[[Trioangle Service ICP]]"
  - "[[Trioangle Growth Plan]]"
  - "[[Trioangle 2.0 AI Pivot Plan]]"
  - "[[AI Application Stack]]"
  - "[[AI Engineering]]"
---

# Trioangle Service Landing Page AI Tech Stack

The AI technology list for Trioangle's service landing pages — both the master "Tech Stack" section and per-LP groupings. Companion to [[Trioangle Landing Page Plan]] (which owns page architecture, keyword maps, and buyer routing); this page owns *which AI tools appear, where, and why*.

**Positioning goal:** reinforce the AI-engineering position — model-agnostic across the full AI stack, no single-vendor dependency. Self-hosted / open-weight options are listed first to signal engineering capability over API-reselling.

> [!key-insight] A tool list cannot carry the positioning
> A clean logo grid is necessary but **not sufficient** to position as AI engineering — on its own it reads as *integrator* (anyone can list LangChain + Qdrant + OpenAI). The stack section is supporting evidence; the positioning is won by the architecture explainer, the "hard parts we own" (evals, guardrails, latency/cost, retraining), demonstrated model-selection judgment, and a real production proof point. Keep this section demoted (section 4-5 on the page), captioned as "the tools behind the systems above." See [[AI Engineering]] and [[AI Evals]].

> [!NOTE] Scope source
> Built from [[Trioangle Landing Page Plan]] (the actual offering — 8 industry LPs + 7 AI service LPs), not just the ArmourPath AI Addon doc. The addon doc under-scoped the stack; see "Gaps filled" below.

## Section header (above the grid)

> **Model-agnostic across the full AI stack — frontier APIs or open-source, managed cloud or self-hosted. Your choice.**

> [!IMPORTANT] The header line is mandatory
> Without it, a list of mostly third-party logos reads as *integrator*, not *AI engineer*. The line reframes every logo as Trioangle's *range*, not its dependency.

## Master AI Stack

Tools only — named technologies that can sit in a logo grid. The *features* they power (recommendation, fraud detection, dynamic pricing, dispatch, route optimization, etc.) are described in "AI Stack by Landing Page", not here. Lead with self-hosted/open options inside each row.

| Category | Tools |
|---|---|
| **LLMs & Reasoning** | Llama · Mistral · Ollama · Groq · OpenAI GPT · Google Gemini |
| **Embeddings** | nomic-embed · sentence-transformers · Cohere · OpenAI Embeddings |
| **Retrieval & RAG Frameworks** | LlamaIndex · LangChain · Haystack · Cohere Rerank |
| **Search Engines** | Meilisearch · Typesense · Elasticsearch / OpenSearch · Algolia |
| **Vector Databases** | pgvector · Qdrant · Weaviate · ChromaDB · FAISS · Pinecone |
| **Agent Frameworks** | LangGraph · CrewAI · AutoGen · MCP |
| **Voice AI** | Whisper · Coqui / Piper TTS · Vapi · Retell · Deepgram |
| **ML, Forecasting & Optimization** | scikit-learn · XGBoost · LightGBM · Prophet · PyTorch · TensorFlow · Google OR-Tools |
| **Computer Vision & Multimodal** | CLIP · YOLO · Google Vision |
| **Content Moderation** | NSFW.js · ONNX Runtime · GPT Vision · AWS Rekognition |

See [[AI Application Stack]] for the general (non-Trioangle-specific) layering of these categories.

## AI Stack by Landing Page

Each LP draws from a subset of the Master AI Stack above. Labels are the **exact master category names** — nothing else. Order by buyer relevance on the page.

### Industry LPs

| Landing Page | AI categories |
|---|---|
| **Ride-Hailing & Transport** (`/industries/ride-hailing`) | ML, Forecasting & Optimization · LLMs & Reasoning |
| **On-Demand Umbrella** (`/industries/on-demand`) | ML, Forecasting & Optimization · LLMs & Reasoning |
| **Delivery & Logistics** (`/industries/delivery`) | ML, Forecasting & Optimization · LLMs & Reasoning |
| **Marketplace & Commerce** (`/industries/marketplace`) | ML, Forecasting & Optimization · Search Engines · Embeddings · Vector Databases · Content Moderation |
| **Home Services & Local** (`/industries/home-services`) | ML, Forecasting & Optimization · LLMs & Reasoning · Agent Frameworks |
| **Rental Marketplaces** (`/industries/rentals`) | ML, Forecasting & Optimization · Search Engines · Embeddings · Vector Databases · Computer Vision & Multimodal |
| **Super App / Multi-Service** (`/industries/super-app`) | Agent Frameworks · ML, Forecasting & Optimization |
| **E-Commerce** (`/industries/ecommerce`) | ML, Forecasting & Optimization · Search Engines · Embeddings · Vector Databases |

### AI Service LPs

| Landing Page | AI categories |
|---|---|
| **RAG Knowledge Assistant** (`/ai-engineering/rag-knowledge-assistant`) | LLMs & Reasoning · Embeddings · Retrieval & RAG Frameworks · Vector Databases |
| **AI Agents & Automation** (`/ai-engineering/ai-agents-automation`) | Agent Frameworks · LLMs & Reasoning |
| **AI Customer Support Bot** (`/ai-engineering/ai-customer-support-bot`) | LLMs & Reasoning · Retrieval & RAG Frameworks · Vector Databases |
| **WhatsApp AI Automation** (`/ai-engineering/whatsapp-ai-automation`) | LLMs & Reasoning · Agent Frameworks *(WhatsApp Business API is the channel — an integration, not AI tech.)* |
| **AI Search Upgrade** (`/ai-engineering/ai-search-upgrade`) | Search Engines · Embeddings · Vector Databases · Retrieval & RAG Frameworks |
| **Voice AI Development** (`/ai-engineering/voice-ai-development`) | Voice AI · LLMs & Reasoning · Agent Frameworks |
| **AI Content Moderation** (`/ai-engineering/ai-content-moderation`) | Content Moderation · Computer Vision & Multimodal · LLMs & Reasoning |
| **AI Engineering Hub** (`/ai-engineering/`) | Full master stack |

## Gaps filled (vs. ArmourPath AI Addon source doc)

The original tech list was scoped to the ArmourPath AI Addon doc's 14 features and missed several capabilities the [[Trioangle Landing Page Plan]] actually sells:

- **Agent Frameworks** — LangGraph, CrewAI, AutoGen, MCP. Backs an entire LP (Priority 10) that previously had no tech.
- **Voice AI** — Whisper, Vapi, Retell, TTS. Backs an entire LP (Priority 14) that previously had no tech.
- **ML, Forecasting & Optimization** — forecasting, route/dispatch optimization, dynamic pricing, ETA, plus recommendation and fraud/anomaly detection. The core of ride-hailing / delivery / rentals and marketplace / ecommerce; was the single biggest hole.
- **Retrieval & RAG Frameworks** — LlamaIndex, LangChain, Haystack, Cohere Rerank (had bare "RAG" only).

## Non-AI items deliberately excluded

> [!IMPORTANT] Channels & integrations are not AI tech
> WhatsApp Business API, Twilio, SMS/email gateways, payment APIs etc. are delivery/integration infrastructure. Keep them off the AI stack grid. If a page needs them, list under "integrates with."

Removed during review because they aren't AI and dilute the position:
- **Cloud & Infrastructure** (Docker, AWS, Laravel, MinIO) — hosting/compute. Deployment-flexibility lives in the header instead.
- **Conversational & Messaging category** (Twilio, WhatsApp Business API = channels; Rasa = redundant with LLMs/Agent Frameworks).
- **FFmpeg + pHash** — video processing / classical hashing, not ML.
- **FAISS in the CV row** — duplicate of Vector Databases.
- **Entire Video AI category** — no LP referenced it + it was half non-AI.

**Borderline-but-kept:** Search Engines (lexical-search infra, but substrate for hybrid AI search); Vector DBs, ONNX Runtime, OR-Tools, Ollama, Groq (AI infrastructure/runtimes, not models, but AI-specific and signal real engineering).

## Open items before publishing

- **Confirm the tool list against Trioangle's actual stack.** Several tools were added as standard category defaults, not verified usage — Haystack, CrewAI, AutoGen, PyTorch/TensorFlow, YOLO, Coqui/Piper. Keep only what the team uses or would credibly deploy.
- **Proof-point discipline** — naming a tool ≠ claiming a deployment. Confirm which capabilities are deployed vs. "available to build." See [[Trioangle Landing Page Plan]] → Proof-Point Discipline and [[Trioangle Service ICP]] → Proof-Point Caveat.
- **The stack section is the weakest positioning lever.** The page still needs an architecture explainer, a "hard parts we own" section, and one production proof point to actually read as AI engineering.

## See also

- [[Trioangle Landing Page Plan]] — page architecture, keyword maps, buyer routing, CTA tiers
- [[Trioangle Service ICP]] — Persona 5 (AI-forward operators), AI-era positioning rules, proof-point caveat
- [[AI Engineering]] · [[AI Application Stack]] · [[AI Evals]] — the discipline this page positions Trioangle within
