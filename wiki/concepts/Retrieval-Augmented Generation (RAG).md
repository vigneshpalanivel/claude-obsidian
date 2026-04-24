---
type: concept
title: "Retrieval-Augmented Generation (RAG)"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ai-engineering
  - rag
  - llm
status: current
related:
  - "[[AI Engineering]]"
  - "[[AI Application Stack]]"
  - "[[LlamaIndex]]"
  - "[[LangChain]]"
  - "[[Research: AI Engineering]]"
  - "[[concepts/_index]]"
sources:
  - "[[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]]"
---

# Retrieval-Augmented Generation (RAG)

The pattern of grounding LLM outputs in a retrieved subset of external knowledge rather than relying only on the model's pre-trained weights. RAG is the most widely adopted technique in production AI applications for factual, up-to-date, domain-specific outputs while minimizing hallucinations.

---

## Why It Exists

LLMs have two core weaknesses for enterprise use:

1. **Knowledge cutoff** — training data is frozen at a point in time
2. **Hallucinations** — confident fabrication when the answer isn't in weights

RAG fixes both by retrieving relevant content from a trusted corpus *at query time* and injecting it into the prompt context.

---

## Pipeline Architecture

```
Ingest:   documents → chunker → embedder → vector DB
Query:    user question → embedder → similarity search → top-k chunks
Generate: chunks + question → LLM → answer (with citations)
```

---

## Key Components

**Chunking**
- Fixed-size, sentence-based, semantic, or hierarchical
- Chunk size + overlap are primary tuning knobs

**Embeddings**
- OpenAI `text-embedding-3`, Cohere, Voyage, open-source (BGE, e5)
- Dimension vs. cost tradeoffs

**Vector databases**
- Managed: Pinecone, Weaviate Cloud
- Open-source: pgvector (Postgres), Chroma, Qdrant, Milvus
- pgvector is the default choice for most 2026 production apps (uses existing DB)

**Retrieval strategies**
- Dense (semantic) — vector similarity
- Sparse (BM25) — keyword
- Hybrid — ensemble of both
- Reranking — cross-encoder model re-orders top-k

**Orchestration**
- [[LangChain]] for broad tool integration
- [[LlamaIndex]] is purpose-built for RAG: more sophisticated ingestion + chunking (Source: [[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]])

---

## Common Failure Modes

- **Retrieval miss** — relevant chunk exists but isn't returned
- **Context stuffing** — too many chunks drown the answer
- **Lost in the middle** — LLMs underweight content in the middle of long contexts
- **Hallucinated citations** — LLM fabricates source attributions

Mitigations: reranking, query rewriting, smaller focused chunks, citation verification.

---

## Advanced Patterns

- **GraphRAG** — knowledge-graph-aware retrieval for multi-hop reasoning
- **HyDE** — generate hypothetical answer, embed it, use for retrieval
- **Agentic RAG** — agent chooses when and how to retrieve
- **Self-RAG** — model decides if retrieval is needed per-query

---

## Business Relevance

RAG is the fastest-to-monetize AI service for a dev shop:
- Document Q&A, knowledge assistants, internal search
- 2–3 week delivery cycle
- Clear client data → clear value
- Central to [[Trioangle]]'s Phase 1 AI service offerings

---

## Connections

- [[AI Engineering]] — RAG is a core AI engineer skill
- [[LlamaIndex]] — dominant RAG framework
- [[AI Application Stack]] — where RAG fits in the broader stack
