---
type: concept
title: "Agentic Engineering"
created: 2026-04-15
updated: 2026-04-15
tags:
  - concept
  - ai-development
  - software-engineering
  - agentic-ai
status: developing
related:
  - "[[Vibe Coding]]"
  - "[[Andrej Karpathy]]"
  - "[[AI-Native Engineering Team]]"
  - "[[concepts/_index]]"
sources:
  - "[[Karpathy-2025-Year-in-Review]]"
---

# Agentic Engineering

The practice of software development where the engineer orchestrates autonomous AI agents rather than writing code directly. Coined by [[Andrej Karpathy]] as a successor to [[Vibe Coding]] when LLMs became capable enough to operate in longer multi-step loops.

"You are not writing the code directly 99% of the time, you are orchestrating agents who do." — Karpathy

---

## How It Differs from Vibe Coding

| | Vibe Coding | Agentic Engineering |
|---|---|---|
| Human role | Prompt → accept output | Orchestrate multi-step agent workflows |
| Code review | Optional / minimal | Judgment-driven; selective |
| Agent autonomy | Single-turn completion | Multi-step, self-correcting loops |
| Output | One file / function | Full feature, test suite, PR |
| Appropriate for | Throwaway prototypes | Production features |

---

## Local vs. Cloud Agents

Karpathy's key insight: running agents **locally** on the developer's machine outperforms cloud-deployed alternatives because local execution has immediate access to:
- Existing installation, configuration, and secrets
- Local data and context
- Low-latency interactive feedback loops

Claude Code's local model is the primary expression of this pattern as of 2025-2026.

---

## The Emerging Workflow

In 2026, the leading pattern is the **agent-driven test loop**:
1. Coding agent writes code
2. Agent generates tests
3. Agent runs tests, identifies failures
4. Agent fixes and iterates
5. Human reviews final diff before PR merge

Multi-agent systems extend this: one agent writes, another critiques, another validates security/compliance.

---

## Engineering Impact

- By mid-2026, agentic AI handles more than 50% of routine coding tasks
- Developer time shifts toward: architecture, orchestration, outcome definition, judgment calls
- Raw coding ability is no longer the primary differentiator — see [[AI-Native Engineering Team]]

---

## Connections

- [[Vibe Coding]] — predecessor concept, same person
- [[AI-Native Engineering Team]] — the org structure this enables
- [[Andrej Karpathy]] — originator
