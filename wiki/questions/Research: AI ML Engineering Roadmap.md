---
type: synthesis
title: "Research: AI ML Engineering Roadmap"
created: 2026-04-23
updated: 2026-04-23
tags:
  - research
  - ai-engineering
  - ml-engineering
  - learning-roadmap
  - synthesis
status: developing
related:
  - "[[AI Engineering Learning Roadmap]]"
  - "[[ML Engineering Learning Roadmap]]"
  - "[[AI Engineering Portfolio Projects]]"
  - "[[AI Engineering]]"
  - "[[Machine Learning Engineering]]"
  - "[[Trioangle 2.0 AI Pivot Plan]]"
  - "[[Research: AI Engineering]]"
  - "[[Research: ML Engineering]]"
sources:
  - "[[KDnuggets-AI-Engineer-Self-Study-Roadmap-2026]]"
  - "[[Scaler-ML-Roadmap-2026]]"
  - "[[TowardsAgenticAI-Agentic-Engineering-Roadmap-2026]]"
  - "[[AI-Engineer-Reading-List-2026]]"
---

# Research: AI ML Engineering Roadmap

## Overview

Two distinct learning paths have stabilized in 2026: the **AI engineering path** (integrate foundation models, 7-12 months intensive) and the **ML engineering path** (train models, 12 months intensive). Both converge at the top in fine-tuning and production ops. Path choice depends on goal: ship AI features faster → AI engineering; build/train custom models → ML engineering. For a dev company pivoting (like [[Trioangle]]), AI engineering delivers revenue faster and the ML engineering path is reserved for Phase 2+ specialists.

---

## Key Findings

- **Two distinct paths**, not one. AI engineering focuses on LLM integration and agentic systems; ML engineering focuses on model training and deployment. (Sources: [[KDnuggets-AI-Engineer-Self-Study-Roadmap-2026]], [[Scaler-ML-Roadmap-2026]])
- **Timelines**: AI engineering 7-12 months intensive; ML engineering 12 months intensive.
- **Accelerated paths exist.** Experienced software engineers can reach AI engineering job-ready in 4-6 months by skipping programming/SWE phases.
- **Three-project portfolio is the hiring bar.** Three well-deployed, documented projects outperform fifteen notebooks. (Source: ML Engineer Portfolio Playbook)
- **LLM fine-tune project single-handedly commands +40-60% pay premium** across both tracks.
- **Portfolio rule**: always deploy, always measure, always README. Colab-only is not a portfolio piece.
- **CrewAI, LangGraph, AutoGen** are the three 2026 default agent frameworks, ordered beginner → intermediate. (Source: [[TowardsAgenticAI-Agentic-Engineering-Roadmap-2026]])
- **First book recommendation (2026)**: Chip Huyen's *AI Engineering* — defines the discipline. (Source: [[AI-Engineer-Reading-List-2026]])
- **Sebastian Raschka's *Build an LLM from Scratch*** is the advanced deep-dive reference.
- **Prompt engineering has evolved into context engineering** — designing the full information environment, not just prompts.
- **Agentic AI adoption**: 64% of CIOs plan deployment within 24 months; 57% of teams already in production (consistent with [[LangChain-State-of-Agent-Engineering-2026]]).
- **Cost of self-study**: $100-$1200 for 12 months depending on hardware needs. Most of Phase 1-4 is doable on free-tier APIs and Colab.
- **Agentic AI specialization** is the fastest-growing subfield; new emerging roles: AI Agent Architect, AgentOps Engineer, Context Engineer, AI Safety Engineer.

---

## The Two Paths, Compared

| Dimension | AI Engineering | ML Engineering |
|-----------|---------------|----------------|
| Primary skill | LLM API integration, RAG, agents | Model training, deep learning, deployment |
| Math depth | Intuition only (what is attention?) | Deeper (gradients, distributions, regularization) |
| Python stack | FastAPI, LangChain, LlamaIndex | NumPy, Pandas, PyTorch, scikit-learn |
| Bottleneck skill | Eval + production (Phase 6) | Deep learning architectures (Phase 4) |
| Timeline intensive | 7-12 months | 12 months |
| Accelerated (SWE) | 4-6 months | 9-10 months |
| Advanced specialization | Agents, voice, LLMOps | Fine-tuning, MLOps, research eng |
| Portfolio | RAG + agent + production LLMOps | Classical ML + DL + fine-tune |
| Job-market urgency | Higher (57.3% production adoption) | Severe shortage (3.2:1 demand/supply) |
| Pay at senior | Higher avg ($206K+) | Slightly lower median but equal top end |

---

## The Universal Skill Stack

Regardless of path, both converge on:

1. **Python + SWE fundamentals** (both paths)
2. **Math intuition** (AI: light; ML: real)
3. **Core library competence** (AI: LangChain/LlamaIndex; ML: PyTorch/scikit)
4. **RAG or equivalent grounding technique** (both)
5. **Evaluation discipline** (both)
6. **Production deployment + observability** (both)
7. **One specialization** (agents, fine-tuning, voice, CV, MLOps, domain)

---

## Learning Order Matters

**Wrong order causes wasted time:**

❌ Start with a framework (LangChain) before understanding LLM APIs → debugging nightmares  
❌ Start with deep learning before classical ML → no intuition for when simpler works  
❌ Skip deployment + observability → never reach production-ready  
❌ Skip math intuition in ML path → surface-level understanding, can't debug

**Right order (AI path):**
Python → SWE → LLM APIs → prompt eng → RAG → agents → LLMOps → specialization

**Right order (ML path):**
Python → math → classical ML → PyTorch basics → deep learning → deployment → fine-tune specialty

---

## Common Patterns Across 2026 Roadmaps

All 2026 roadmaps examined agree on:

1. **Python first, always** — non-negotiable
2. **Build as you learn** — theory without projects kills motivation and doesn't stick
3. **Framework intuition ≠ framework proficiency** — start with direct API calls, add frameworks after pain points appear
4. **Evaluation is production** — ship without evals = ship broken
5. **Three projects beats thirty** — depth compounds, breadth dilutes
6. **Current stack stabilized** — PyTorch, LangGraph, LlamaIndex, pgvector, MLflow, LangSmith — these are safe bets for the 12-month horizon
7. **Fine-tuning is the single highest-leverage skill** to add at the top of either path

---

## Contradictions

- **Frameworks: required or skip?** Some sources push LangChain/CrewAI as essential beginner tools. Others (including the TowardsAgenticAI guide) warn that framework-first learning leads to brittle production code. Reconciliation: learn frameworks *after* hitting pain points with raw APIs — you need to know what the framework is abstracting to debug when it fails.
- **Math: deep or shallow for AI engineers?** Scaler's ML roadmap demands real math; KDnuggets' AI roadmap treats it as optional intuition. Reconciliation: AI engineers don't need calculus to ship features, but they can't debug LLM behavior without understanding attention/tokenization/embeddings intuitively. "Intuition depth" is the right bar.
- **Timeline claims vary widely** (6 months vs 12 months to job-ready). Reconciliation: depends heavily on starting point and hours/week. The 6-month claims assume 40+ hrs/week and strong programming background. 12 months is realistic for part-time learners.

---

## Open Questions

> [!gap] How does certification (NVIDIA Agentic AI, Google ML, AWS ML) actually impact hiring? Evidence is marketing-heavy.

> [!gap] Is there a formal "Agentic AI Engineer" role separate from AI Engineer, or is it a specialization? Job titles still vary widely.

> [!gap] What's the actual income impact of self-study vs degree/bootcamp in 2026 for hiring? Credential gap data mostly predates GenAI hiring boom.

> [!gap] How fast will agent frameworks churn? CrewAI and LangGraph are current defaults — 12-24 month outlook unclear.

---

## Implications for Trioangle

For the [[Trioangle 2.0 AI Pivot Plan]]:

1. **Start AI champions at roadmap Phase 3 (AI + LLM Fundamentals)**, not Phase 1. Existing Trioangle devs already have SWE foundation.
2. **Target 2-3 month timeline to production-AI-capable** for existing senior devs — feasible because they compress Phases 1-2.
3. **Don't try to teach ML engineering from scratch internally.** Timeline too long for the pivot. Hire 1 experienced ML engineer in Phase 2+ for fine-tuning services.
4. **Invest in the right tooling stack**: Cursor/Claude Code for champions, LangSmith/Langfuse for observability, Anthropic/OpenAI APIs for Phase 3, pgvector for Phase 4.
5. **Require the three-project portfolio internally.** Each champion builds 1 RAG, 1 agent, 1 production app with evals — these become client-facing reference architectures.
6. **Fine-tuning is the Phase 2+ differentiator.** When hiring the ML engineer, weight their LoRA/QLoRA experience heavily.
7. **Use [[AI Engineering Portfolio Projects]] as training curriculum.** Adapt the 15-project list into a training plan for champions.

---

## Sources

- [[KDnuggets-AI-Engineer-Self-Study-Roadmap-2026]] — 7-phase AI engineer self-study
- [[Scaler-ML-Roadmap-2026]] — 7-phase ML engineer roadmap
- [[TowardsAgenticAI-Agentic-Engineering-Roadmap-2026]] — specialized agentic AI path
- [[AI-Engineer-Reading-List-2026]] — 10-book reference list for 2026
