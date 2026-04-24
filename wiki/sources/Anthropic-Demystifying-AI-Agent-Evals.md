---
type: source
title: "Anthropic: Demystifying Evals for AI Agents"
source_type: article
author: "Anthropic Engineering"
date_published: 2026
url: "https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents"
confidence: high
key_claims:
  - "Three grader types: code-based, model-based, human — each with tradeoffs"
  - "pass@k vs pass^k metrics capture agent non-determinism"
  - "Start with 20-50 tasks from real failures, not comprehensive coverage"
  - "Never let agents touch production databases during eval — use mocks"
  - "Grade outcomes not prescribed paths"
created: 2026-04-23
updated: 2026-04-23
tags:
  - source
  - ai-engineering
  - evals
  - agents
  - anthropic
status: current
related:
  - "[[AI Evals]]"
  - "[[AI Engineering]]"
  - "[[Research: AI Engineering]]"
  - "[[sources/_index]]"
---

# Anthropic: Demystifying Evals for AI Agents

**Source**: [anthropic.com/engineering](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents) | Anthropic Engineering | 2026

---

## Summary

Primary-source engineering guide from Anthropic on how to evaluate AI agents in production. High-confidence authoritative material.

---

## Core Framework — Three Grader Types

1. **Code-based graders** — fast, objective, reproducible, but brittle to valid variations
2. **Model-based graders** — flexible and nuanced, but non-deterministic and expensive
3. **Human graders** — gold standard, but slow and costly

Production evals combine all three using the "Swiss Cheese Model": each catches issues the others miss.

---

## Essential Non-Determinism Metrics

- **pass@k** — probability of success in at least one of k attempts
- **pass^k** — probability that all k trials succeed (consistency measure)

Production agent reliability requires **pass^k thinking**, not just pass@k.

---

## Practical Implementation Roadmap

**Setup (steps 0–3)**
- Start with 20–50 tasks drawn from real failures in your bug tracker
- Write unambiguous specs where two domain experts independently agree on pass/fail
- Create reference solutions proving tasks are solvable

**Infrastructure (steps 4–5)**
- Build isolated trial environments; each run starts fresh
- Grade outcomes, not prescribed paths (agents find valid approaches evaluators didn't anticipate)
- Implement partial credit for multi-component tasks

**Maintenance (steps 6–8)**
- Read transcripts regularly; verify graders assess what matters
- Watch for saturation (100% pass = no signal)
- Treat eval suites as living artifacts with dedicated ownership

---

## Agent-Specific Patterns

- **Coding agents** — deterministic test suites + LLM rubric for quality
- **Conversational agents** — multi-turn user-persona simulation + interaction quality
- **Research agents** — groundedness + coverage + source quality checks
- **Computer use agents** — real/sandboxed env with state inspection

---

## Critical Rule

> Never let an agent interact with a production database during evaluation. Always use mocked tools and isolated sandboxes.

Analyze the agent's **trajectory** (sequence of thoughts + actions), not just the final output — to catch correct answers reached via flawed logic.

---

## What This Contributes

Authoritative playbook for the [[AI Evals]] concept. Directly informs production quality workflows for [[AI Engineering]] teams.
