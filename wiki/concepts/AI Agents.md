---
type: concept
title: "AI Agents"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ai-engineering
  - agents
  - agentic-ai
status: current
related:
  - "[[AI Engineering]]"
  - "[[Agentic Engineering]]"
  - "[[AI Application Stack]]"
  - "[[AI Evals]]"
  - "[[LangChain]]"
  - "[[Research: AI Engineering]]"
  - "[[concepts/_index]]"
sources:
  - "[[LangChain-State-of-Agent-Engineering-2026]]"
  - "[[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]]"
---

# AI Agents

An AI agent is an LLM-driven system that runs in a loop: it observes state, plans actions, invokes tools, observes results, and decides next steps — until a goal is reached or a budget is exhausted. Agents are distinct from simple prompt-response apps because they make **multi-step decisions autonomously**.

---

## Core Components

| Component | Role |
|-----------|------|
| LLM (planner) | Decides the next action |
| Tools | External functions the agent can call |
| Memory | Short-term (conversation) + long-term (vector store) |
| Orchestrator | Manages the reasoning loop |
| State | Graph/variables tracked across steps |

---

## The Reasoning Loop

```
while not done:
    think    — model reasons about the current state
    act      — model calls a tool
    observe  — tool returns a result
    update   — state/memory refreshed
```

Goal completion or budget (tokens, time, steps) terminates the loop.

---

## 2026 Production Reality

- **57.3%** of orgs have agents in production; 67% of large enterprises (Source: [[LangChain-State-of-Agent-Engineering-2026]])
- **Quality** is the #1 barrier, cited by 33% of teams
- **Customer service** is the top use case (26.5%)
- **89%** of deploying orgs have implemented agent observability
- Cost is *no longer* the top concern — falling model prices
- Only 11–12% of agent initiatives reach production at scale across the broader market — scope + governance are the main killers

---

## Dominant Frameworks

- **LangGraph** — stateful multi-agent systems; LangChain's successor for agents (Source: [[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]])
- **CrewAI** — role-based multi-agent teams
- **AutoGen** (Microsoft) — conversation-driven agent groups
- **OpenAI Agents SDK** — managed agent runtime
- **MCP (Model Context Protocol)** — Anthropic's tool-interface standard
- **n8n with AI nodes** — low-code workflow agents

---

## Common Failure Modes

**Orchestration complexity** — coordination between agents becomes the bottleneck, not the LLM calls themselves. Race conditions and cascading failures are hard to reproduce in staging.

**Silent drift** — agents don't fail suddenly; they degrade quietly over months. Observability must be built in from day one.

**Non-auditability** — agents without complete trace logs create compliance risk (GDPR, HIPAA, SEC).

**Scope creep** — narrower scope strongly correlates with production success.

---

## Agent Design Patterns

- **Single-agent with tools** — simplest, best-understood pattern
- **Supervisor + workers** — one agent routes to specialists
- **Parallel fan-out** — split work, aggregate results
- **Debate/critic** — writer + reviewer agents
- **Plan-and-execute** — generate a plan first, then execute step-by-step

---

## When to Use Agents vs Just Prompts

| Use a simple prompt | Use an agent |
|---|---|
| Single-turn Q&A | Multi-step task |
| Known input/output shape | Unknown number of steps |
| No external tools needed | Needs to call APIs/search |
| Latency is critical | Correctness > latency |
| Determinism required | Exploration required |

Agents add cost, latency, and failure surface — don't use them when a prompt suffices.

---

## Connections

- [[Agentic Engineering]] — agents applied to software development
- [[AI Evals]] — agent evaluation is a distinct discipline
- [[LLMOps and AI Observability]] — required for production agents
