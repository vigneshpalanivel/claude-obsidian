---
type: concept
title: "AI Application Stack"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ai-engineering
  - stack
  - architecture
status: current
related:
  - "[[AI Engineering]]"
  - "[[Retrieval-Augmented Generation (RAG)]]"
  - "[[AI Agents]]"
  - "[[AI Evals]]"
  - "[[LLMOps and AI Observability]]"
  - "[[LangChain]]"
  - "[[LlamaIndex]]"
  - "[[Research: AI Engineering]]"
  - "[[concepts/_index]]"
sources:
  - "[[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]]"
  - "[[LangChain-State-of-Agent-Engineering-2026]]"
---

# AI Application Stack

The layered architecture used to build production AI-powered applications in 2026. The stack has stabilized enough that a common "default" exists, with variations by domain.

---

## The Layers

```
┌─ Application / UX ─────────────────────┐
│  Next.js, Vercel AI SDK, streaming UI  │
├─ Orchestration ────────────────────────┤
│  LangGraph, LangChain, CrewAI, n8n     │
├─ Retrieval / Data ─────────────────────┤
│  LlamaIndex, pgvector, Pinecone        │
├─ Inference ────────────────────────────┤
│  Anthropic, OpenAI, Gemini (API)       │
│  Or: Ollama, vLLM, Modal (self-host)   │
├─ Observability / Ops ──────────────────┤
│  LangSmith, Langfuse, Helicone         │
└────────────────────────────────────────┘
```

---

## Layer-by-Layer

### 1. Application / UX
- **Next.js + Vercel AI SDK** — default choice for web AI apps
- **React + streaming** — for chat interfaces
- **Flutter / React Native** — for mobile AI apps
- Key pattern: **streaming tokens** to reduce perceived latency

### 2. Orchestration
- **LangGraph** — multi-agent, stateful, production-grade
- **LangChain** — rapid prototyping, widest integration surface
- **CrewAI / AutoGen** — role-based agent teams
- **n8n** — low-code workflow automation with AI nodes
- Choose based on complexity: one prompt → SDK; multi-step → LangGraph

### 3. Retrieval / Data
- **LlamaIndex** — data-centric RAG pipelines
- **pgvector (Postgres)** — default for most production apps (uses existing DB)
- **Pinecone / Weaviate / Qdrant** — managed vector DBs at scale
- **Embedding models** — OpenAI `text-embedding-3`, Voyage, Cohere, BGE (open)

### 4. Inference
- **Anthropic Claude** — strong reasoning, long context, tool use
- **OpenAI** — broad coverage, fastest ecosystem
- **Gemini** — cost/latency advantage for many tasks
- **Self-hosted** (Llama, Mistral, Qwen via Ollama/vLLM/Modal) — data-privacy or cost at scale

### 5. Observability / Ops
- **LangSmith** — LangChain-native
- **Langfuse** — open-source
- **Helicone** — proxy-based logging + cost
- **Promptfoo / RAGAS / DeepEval** — eval layer

---

## Common Patterns

**Simple chatbot**
- Next.js + Vercel AI SDK → Claude/OpenAI API. No orchestrator needed.

**Document Q&A (RAG)**
- Ingestion: LlamaIndex → pgvector
- Query: LlamaIndex retrieval → LLM with system prompt + chunks
- UX: streaming chat

**Customer service agent**
- LangGraph workflow
- Tools: RAG over knowledge base, CRM API, ticket creation API
- Observability: LangSmith + online evals
- Fallback: human handoff on low confidence

**Workflow automation**
- n8n with AI nodes
- WhatsApp/Slack trigger → LLM classifier → action nodes
- No orchestrator needed if steps are linear

---

## Infrastructure Choices

| Need | Default |
|------|---------|
| LLM inference | Managed API (Anthropic/OpenAI) |
| Vector store | pgvector in existing Postgres |
| Frontend | Next.js |
| Backend | Python FastAPI or Node |
| Hosting | Vercel + Supabase/Neon |
| Observability | LangSmith or Langfuse |

Upgrade only when you hit a real limit (cost, latency, data privacy, scale).

---

## 2026 Stabilization

The 2024–25 chaos of framework churn has settled:
- **LangGraph** is now LangChain's default for agents (Source: [[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]])
- **pgvector** became the boring default for retrieval
- **Observability** is now standard practice, not optional (89% adoption per Source: [[LangChain-State-of-Agent-Engineering-2026]])
- **Multi-provider** is the norm (76%+ of production teams)

---

## Connections

- [[AI Engineering]] — the role that owns this stack
- [[Retrieval-Augmented Generation (RAG)]] — the dominant data pattern
- [[AI Agents]] — the orchestration layer's primary use
- [[LLMOps and AI Observability]] — the ops layer
