---
type: concept
title: "AI Evals"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ai-engineering
  - evals
  - quality
status: current
related:
  - "[[AI Engineering]]"
  - "[[AI Agents]]"
  - "[[LLMOps and AI Observability]]"
  - "[[Research: AI Engineering]]"
  - "[[concepts/_index]]"
sources:
  - "[[Anthropic-Demystifying-AI-Agent-Evals]]"
  - "[[LangChain-State-of-Agent-Engineering-2026]]"
---

# AI Evals

Systematic measurement of AI system quality. Evals are to AI engineering what unit tests are to traditional software — except the target is non-deterministic, and "correct" often isn't binary. Evals are the main lever for shipping AI features reliably in production.

---

## Why Evals Matter

- **Quality is the #1 barrier** to agent production in 2026, cited by 33% of teams (Source: [[LangChain-State-of-Agent-Engineering-2026]])
- LLM output is non-deterministic — a one-time passing test guarantees nothing
- Evals are how you detect regressions when switching models, adjusting prompts, or shipping new features
- Teams running online evals in production reach 44.8% of production deployers

---

## Three Grader Types

(Source: [[Anthropic-Demystifying-AI-Agent-Evals]])

| Grader | Pros | Cons |
|--------|------|------|
| **Code-based** | Fast, objective, reproducible | Brittle to valid variations |
| **Model-based (LLM-as-judge)** | Flexible, nuanced | Non-deterministic, expensive |
| **Human** | Gold standard | Slow, costly |

Production systems combine all three ("Swiss Cheese Model") — each catches what the others miss.

---

## Non-Determinism Metrics

- **pass@k** — probability of success in at least one of k attempts
- **pass^k** — probability all k trials succeed (consistency)

Production reliability requires **pass^k thinking**, not just pass@k.

---

## Practical Workflow

1. Start with **20–50 tasks from real failures** (bug tracker, user complaints) — not comprehensive coverage.
2. Write **unambiguous specs** two domain experts would agree on.
3. Build **isolated trial environments** — each run fresh, no cross-contamination.
4. **Grade outcomes, not paths** — agents find valid approaches you didn't anticipate.
5. **Read transcripts regularly** — verify graders assess what matters.
6. Watch for **saturation** — 100% pass rate = no signal; raise difficulty.

---

## Agent-Specific Eval Patterns

- **Coding agents** — deterministic test suites + LLM rubric for quality
- **Conversational agents** — multi-turn user-persona simulation
- **Research agents** — groundedness + coverage + source-quality checks
- **Computer use agents** — real/sandboxed env with state inspection

---

## Critical Rules

> Never let an agent interact with a production database during evaluation. Always use mocked tools and sandboxes.

Analyze the **trajectory** (sequence of thoughts + actions), not just the final answer — catch correct outputs reached via flawed logic.

---

## Eval in the SDLC

- **Pre-launch / CI**: automated evals as quality gate with score thresholds
- **Pre-prod canary**: A/B test vs. current production prompt/model
- **Production monitoring**: sample real traffic, re-grade offline periodically
- **Drift detection**: watch eval scores over time as input distribution changes

---

## Tools

- **LangSmith** — LangChain-native evals + tracing
- **Langfuse** — open-source LLM observability + evals
- **Helicone** — logging + eval layer
- **Promptfoo** — CLI-driven eval framework
- **RAGAS** — RAG-specific evaluation metrics
- **DeepEval** — pytest-style LLM evals
- **Braintrust** — eval + observability platform

---

## Common Anti-Patterns

- **Test-set contamination** — LLM has seen your eval set during training
- **Vibes-based eval** — manually skim outputs; doesn't scale; misses regressions
- **Single-metric optimization** — accuracy up, latency catastrophic
- **Grader without calibration** — LLM-judge hasn't been validated against human judgments

---

## Connections

- [[AI Engineering]] — evals are a core AI engineer skill
- [[LLMOps and AI Observability]] — eval data flows through the observability stack
- [[AI Agents]] — agent evaluation requires trajectory-level analysis
