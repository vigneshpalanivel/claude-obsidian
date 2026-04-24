---
type: entity
title: "LlamaIndex"
entity_type: organization
created: 2026-04-23
updated: 2026-04-23
tags:
  - entity
  - ai-framework
  - rag
status: current
related:
  - "[[Retrieval-Augmented Generation (RAG)]]"
  - "[[AI Application Stack]]"
  - "[[LangChain]]"
  - "[[Research: AI Engineering]]"
  - "[[entities/_index]]"
sources:
  - "[[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]]"
---

# LlamaIndex

Company and open-source data framework specialized for RAG and agentic applications that use an organization's internal data. While LangChain optimizes for breadth, LlamaIndex optimizes for depth in retrieval.

---

## Core Strengths

- **Data ingestion** — dozens of out-of-the-box connectors (Notion, Slack, Drive, Confluence, SQL, APIs)
- **Advanced chunking** — node parsing, hierarchical chunking, sentence-window
- **Retrieval abstractions** — auto-merging retrieval, sub-question decomposition, routing retrievers
- **PDF/document processing** — among the most sophisticated in OSS (Source: [[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]])

---

## Products

| Product | Role |
|---------|------|
| **llama-index (Python/TS)** | Data-centric LLM framework |
| **LlamaParse** | Managed PDF/document parser (hosted) |
| **LlamaCloud** | Managed ingestion + retrieval pipelines |
| **LlamaDeploy** | Multi-agent workflow deployment |

---

## When LlamaIndex Beats LangChain

| Scenario | LlamaIndex advantage |
|----------|---------------------|
| Document-heavy RAG | Purpose-built from day one |
| Complex PDFs | LlamaParse handles tables/images better |
| Multiple data sources | More connectors, easier merge |
| Advanced retrieval | Router/hybrid retrievers more mature |

---

## When LangChain Wins

- Need broad tool integration beyond retrieval
- Multi-agent orchestration (LangGraph)
- Mature observability (LangSmith)

---

## Hybrid Pattern

Many 2026 production systems combine:
- **LlamaIndex** for the retrieval layer
- **LangChain/LangGraph** for orchestration + tool use

The frameworks are complementary, not competing, for complex apps.

---

## Observability Gap

LlamaIndex has weaker native observability (7/10 vs LangChain's 9/10) — teams typically add Arize or WhyLabs for monitoring. (Source: [[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]])

---

## Licensing

MIT-licensed open source. LlamaCloud and LlamaParse are paid managed services above free tiers.

---

## Connections

- [[Retrieval-Augmented Generation (RAG)]] — LlamaIndex is the RAG specialist
- [[LangChain]] — common pairing for production systems
- [[AI Application Stack]] — data/retrieval layer default
