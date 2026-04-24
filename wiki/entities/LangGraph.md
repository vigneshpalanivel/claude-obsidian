---
type: entity
title: "LangGraph"
entity_type: framework
created: 2026-04-24
updated: 2026-04-24
tags:
  - entity
  - ai-framework
  - agents
  - orchestration
status: current
related:
  - "[[LangChain]]"
  - "[[AI Agents]]"
  - "[[AI Application Stack]]"
  - "[[LLMOps and AI Observability]]"
sources:
  - "[[Xenoss-LangChain-LangGraph-LlamaIndex-Comparison]]"
  - "[[LangChain-State-of-Agent-Engineering-2026]]"
---

# LangGraph

**Type**: Open-source multi-agent orchestration framework  
**Made by**: LangChain Inc (same company as LangChain)  
**License**: MIT  
**Role in 2026 stack**: Primary framework for building production AI agents

## What It Is

LangGraph is a graph-based agent orchestration framework. Agents are modeled as nodes in a directed graph; edges define the flow of state between them. This gives explicit control over agent loops, branching, parallelism, and human-in-the-loop checkpoints — things that LangChain's original agent abstractions could not handle cleanly.

LangChain deprecated its native agents (AgentExecutor) in favor of LangGraph. LangGraph is now the main way to build agents within the LangChain ecosystem.

## Why It Replaced LangChain Native Agents

LangChain's original agents used an implicit loop (ReAct/plan-and-execute). Problems in production:
- No control over the loop structure
- Hard to add human approval steps
- Hard to run agents in parallel
- Debugging was opaque

LangGraph makes the loop structure **explicit as a graph**. Every state transition is visible, testable, and interceptable.

## Key Concepts

- **State graph**: agents as nodes, state passed along edges
- **Checkpointing**: pause/resume agent execution; enables human-in-the-loop
- **Persistence**: built-in memory across runs (short and long-term)
- **Subgraphs**: compose agent systems hierarchically
- **Streaming**: stream intermediate steps to UI in real-time

## 2026 Position

- Industry default for multi-agent systems (replaced AutoGen for most teams)
- 57.3% of production agent teams using LangGraph or LangGraph-compatible patterns
- Pairs with LangSmith for observability
- Beginner-to-advanced progression: CrewAI → **LangGraph** → AutoGen/OpenAI Agents SDK

## Relationship to LangChain

LangGraph is a separate library (`langgraph`) but part of the LangChain ecosystem. You can use LangGraph with or without LangChain's other components. The two are often used together: LangGraph for orchestration, LangChain for prompt templates and model connectors.
