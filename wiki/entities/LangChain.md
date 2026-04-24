---
type: entity
title: "LangChain"
entity_type: organization
created: 2026-04-23
updated: 2026-04-23
tags:
  - entity
  - ai-framework
  - company
status: current
related:
  - "[[AI Application Stack]]"
  - "[[AI Agents]]"
  - "[[LLMOps and AI Observability]]"
  - "[[LlamaIndex]]"
  - "[[Research: AI Engineering]]"
  - "[[entities/_index]]"
sources:
  - "[[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]]"
  - "[[LangChain-State-of-Agent-Engineering-2026]]"
---

# LangChain

Company and open-source framework ecosystem for building LLM applications. LangChain is the most widely adopted orchestration framework for AI engineering in 2026, with the largest integration surface of any LLM library.

---

## Products

| Product | Role |
|---------|------|
| **langchain (Python/JS)** | Composable LLM application toolkit using LCEL expression language |
| **LangGraph** | Stateful graph-based multi-agent framework — LangChain's primary agent path in 2026 |
| **LangSmith** | Observability, tracing, eval platform (hosted + self-hosted) |
| **LangServe** | Deployment wrapper for LangChain chains |
| **LangGraph Studio** | Visual debugger with time-travel for multi-agent workflows |

---

## Core Strengths

- **Breadth of integrations** — hundreds of LLM providers, vector stores, tools, document loaders, output parsers. New AI services usually have a LangChain integration within weeks of launch. (Source: [[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]])
- **LangSmith** — 9/10 observability coverage; native tracing + eval
- **LangGraph** — now the primary path for production multi-agent systems; typed state, checkpointing, human-in-the-loop

---

## The 2026 Shift

LangChain **deprecated its native agent capabilities** in favor of LangGraph. The LangChain team now positions LangGraph as the default for agentic workflows. Official quickstarts use LangGraph constructs by default.

---

## Adoption

LangChain authored the [[LangChain-State-of-Agent-Engineering-2026]] report, polling production deployers. Key industry finding from that report:

- 57.3% of orgs run agents in production
- 89% have observability (LangSmith dominant)
- 76%+ use multi-model/multi-provider strategies

---

## Licensing

MIT-licensed open source. Hosted LangSmith is paid above a free tier.

---

## When to Choose LangChain/LangGraph

| Need | Recommendation |
|------|----------------|
| Rapid prototyping of linear LLM chains | LangChain (Python/JS) |
| Multi-agent production systems | LangGraph |
| Hybrid RAG + agents | LangGraph + [[LlamaIndex]] for retrieval |
| Simple single-prompt chatbot | Skip framework; use provider SDK directly |

---

## Connections

- [[AI Agents]] — LangGraph is the dominant agent framework
- [[LlamaIndex]] — common partner for retrieval layer
- [[AI Application Stack]] — orchestration layer default
