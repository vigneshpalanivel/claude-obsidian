# Trioangle Service Landing Page — AI Tech Stack

**Purpose:** AI technology list for the Trioangle service landing pages — both the master "Tech Stack" section and per-LP groupings.
**Positioning goal:** Reinforce AI-engineering position — model-agnostic across the full AI stack, no single-vendor dependency. Self-hosted / open-weight options listed first to signal engineering capability over API-reselling.
**Scope source:** Built from [[Trioangle Service LP Plan]] (the actual service offering — 8 industry LPs + 7 AI service LPs), not just the ArmourPath AI Addon doc. The addon doc under-scoped the stack; see "Gaps filled" note below.

---

## Section header (above the grid)

> **Model-agnostic across the full AI stack — frontier APIs or open-source, managed cloud or self-hosted. Your choice.**

---

## Master AI Stack

> Tools only — named technologies that can sit in a logo grid. The *features* they power (recommendation, fraud detection, dynamic pricing, dispatch, route optimization, etc.) are described in the "AI Stack by Landing Page" section, not here.

**LLMs & Reasoning**
Llama · Mistral · Ollama · Groq · OpenAI GPT · Google Gemini

**Embeddings**
nomic-embed · sentence-transformers · Cohere · OpenAI Embeddings

**Retrieval & RAG Frameworks**
LlamaIndex · LangChain · Haystack · Cohere Rerank

**Search Engines**
Meilisearch · Typesense · Elasticsearch / OpenSearch · Algolia

**Vector Databases**
pgvector · Qdrant · Weaviate · ChromaDB · FAISS · Pinecone

**Agent Frameworks**
LangGraph · CrewAI · AutoGen · MCP

**Voice AI**
Whisper · Coqui / Piper TTS · Vapi · Retell · Deepgram

**ML, Forecasting & Optimization**
scikit-learn · XGBoost · LightGBM · Prophet · PyTorch · TensorFlow · Google OR-Tools

**Computer Vision & Multimodal**
CLIP · YOLO · Google Vision

**Content Moderation**
NSFW.js · ONNX Runtime · GPT Vision · AWS Rekognition

---

## AI Stack by Landing Page

> Each LP draws from a subset of the Master AI Stack above. Labels below are the **exact master category names** — nothing else. Order by buyer relevance on the page; lead with self-hosted/open tools inside each category.

### Industry LPs

**Ride-Hailing & Transport** (`/industries/ride-hailing`)
ML, Forecasting & Optimization · LLMs & Reasoning

**On-Demand Umbrella** (`/industries/on-demand`)
ML, Forecasting & Optimization · LLMs & Reasoning

**Delivery & Logistics** (`/industries/delivery`)
ML, Forecasting & Optimization · LLMs & Reasoning

**Marketplace & Commerce** (`/industries/marketplace`)
ML, Forecasting & Optimization · Search Engines · Embeddings · Vector Databases · Content Moderation

**Home Services & Local** (`/industries/home-services`)
ML, Forecasting & Optimization · LLMs & Reasoning · Agent Frameworks

**Rental Marketplaces** (`/industries/rentals`)
ML, Forecasting & Optimization · Search Engines · Embeddings · Vector Databases · Computer Vision & Multimodal

**Super App / Multi-Service** (`/industries/super-app`)
Agent Frameworks · ML, Forecasting & Optimization

**E-Commerce** (`/industries/ecommerce`)
ML, Forecasting & Optimization · Search Engines · Embeddings · Vector Databases

### AI Service LPs

**RAG Knowledge Assistant** (`/ai-engineering/rag-knowledge-assistant`)
LLMs & Reasoning · Embeddings · Retrieval & RAG Frameworks · Vector Databases

**AI Agents & Automation** (`/ai-engineering/ai-agents-automation`)
Agent Frameworks · LLMs & Reasoning

**AI Customer Support Bot** (`/ai-engineering/ai-customer-support-bot`)
LLMs & Reasoning · Retrieval & RAG Frameworks · Vector Databases

**WhatsApp AI Automation** (`/ai-engineering/whatsapp-ai-automation`)
LLMs & Reasoning · Agent Frameworks
*(WhatsApp Business API is the channel — an integration, not AI tech.)*

**AI Search Upgrade** (`/ai-engineering/ai-search-upgrade`)
Search Engines · Embeddings · Vector Databases · Retrieval & RAG Frameworks

**Voice AI Development** (`/ai-engineering/voice-ai-development`)
Voice AI · LLMs & Reasoning · Agent Frameworks

**AI Content Moderation** (`/ai-engineering/ai-content-moderation`)
Content Moderation · Computer Vision & Multimodal · LLMs & Reasoning

**AI Engineering Hub** (`/ai-engineering/`)
Full master stack

---

## Gaps filled (vs. ArmourPath AI Addon source doc)

The original tech list was scoped to the ArmourPath AI Addon doc's 14 features and missed several capabilities that the Service LP Plan actually sells. Added here:

- **Agent Frameworks** — LangGraph, CrewAI, AutoGen, MCP. Backs an entire LP (Priority 10) that previously had no tech.
- **Voice AI** — Whisper, Vapi, Retell, TTS. Backs an entire LP (Priority 14) that previously had no tech.
- **ML, Forecasting & Optimization** — forecasting, route/dispatch optimization, dynamic pricing, ETA, plus recommendation and fraud/anomaly detection. The core of ride-hailing / delivery / rentals (forecasting + optimization) and marketplace / ecommerce (fraud + recommendation); was the single biggest hole.
- **Retrieval & RAG Frameworks** — LlamaIndex, LangChain, Haystack, Cohere Rerank (had bare "RAG" only).

---

## Notes / Rationale

- **Self-hosted & open-weight options are listed first** in each row (e.g. Llama/Mistral before OpenAI). Self-hostable tech first signals engineering capability — an API reseller can't run a fully self-hosted stack. Strongest AI-engineering credibility signal available.
- **The header line is mandatory.** Without "Model-agnostic across the full AI stack…" above the grid, a list of mostly third-party logos reads as *integrator*, not *AI engineer*.
- **Per-LP grouping > one master grid on every page.** Each LP should show only its relevant rows so the stack reads as "the engineering behind this specific feature," not a generic logo wall. Reserve the full master grid for the AI Engineering Hub.
- **Non-AI items removed.** Cleaned out tools that aren't AI and dilute the position: Cloud & Infrastructure (Docker, AWS, Laravel, MinIO — hosting/compute); Conversational & Messaging category (Twilio, WhatsApp Business API — messaging channels; Rasa — redundant with LLMs/Agent Frameworks); FFmpeg + pHash (video processing / classical hashing); FAISS in the CV row (duplicate of Vector Databases); and the entire Video AI category (no LP used it + it was half non-AI).
- **Channels & integrations are not AI tech.** WhatsApp Business API, Twilio, SMS/email gateways, payment APIs etc. are delivery/integration infrastructure. Keep them off the AI stack grid. If a page needs them, list them under "integrates with," not the AI tech stack.
- **Proof-point discipline applies** — naming a tool ≠ claiming a deployment. Before publishing a per-LP stack, confirm which of those capabilities are deployed vs. "available to build." See [[Trioangle Service LP Plan]] → Proof-Point Discipline.
- **Confirm the tool list against Trioangle's actual stack.** Several Master AI Stack tools were added as standard category defaults, not verified usage — specifically Haystack, CrewAI, AutoGen, PyTorch/TensorFlow, YOLO, Coqui/Piper. Keep only what the team actually uses or would credibly deploy; drop the rest before publishing.
- Underlying feature→tech mapping source: `~/Downloads/AI_Addon_TechStack_and_Alternatives_v2.md` (ArmourPath, June 2026), extended with LP Plan scope.

---

## Related

- [[Trioangle Service LP Plan]] — landing page structure, buyer routing, CTA tiers, per-page keyword maps
- AI-engineering positioning rules: never "we build faster with AI"; position on domain expertise, certainty, risk reduction; "intelligence layer on top of your existing codebase"
