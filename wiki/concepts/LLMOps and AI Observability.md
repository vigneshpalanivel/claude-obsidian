---
type: concept
title: "LLMOps and AI Observability"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ai-engineering
  - llmops
  - observability
  - production
status: current
related:
  - "[[AI Engineering]]"
  - "[[AI Evals]]"
  - "[[AI Agents]]"
  - "[[Research: AI Engineering]]"
  - "[[concepts/_index]]"
sources:
  - "[[LangChain-State-of-Agent-Engineering-2026]]"
---

# LLMOps and AI Observability

The operational discipline for running AI systems — especially LLM- and agent-based — in production. LLMOps covers deployment, monitoring, cost control, evaluation integration, prompt/model versioning, and drift detection. It extends classical MLOps to the specifics of generative AI.

---

## Why It's a Distinct Practice

Traditional observability (logs, metrics, traces) doesn't cover the AI-specific failure surface:

- Prompts are code — need versioning and rollback
- Model upgrades change behavior silently
- Per-request cost varies 10–50× based on tokens
- Quality regressions aren't caught by status-code monitoring
- Agent trajectories span many calls — need step-level tracing

---

## Production Adoption (2026)

(Source: [[LangChain-State-of-Agent-Engineering-2026]])

- **89%** of organizations running agents have implemented some form of observability
- **62%** maintain detailed tracing
- **52.4%** run offline evals
- **37.3%** run online evals in production
- **44.8%** of production teams use online methods

---

## What to Monitor

**Quality signals**
- Eval scores on a fixed test set (regression detection)
- User feedback (thumbs up/down, edit rate)
- Hallucination rates (groundedness checks)
- Instruction-following accuracy

**Behavioral signals**
- Prompt + completion traces (full payloads)
- Agent trajectories (tool call sequences)
- Latency P50/P95/P99 per prompt version
- Token usage per request

**Cost signals**
- Cost per request, per user, per feature
- Model routing efficiency (right model for right task)
- Cache hit rate

**Reliability signals**
- Rate-limit errors from providers
- Fallback model invocation rate
- Retry rate

---

## The LLMOps Stack (2026)

| Layer | Tools |
|-------|-------|
| Tracing | LangSmith, Langfuse, Helicone, Arize Phoenix |
| Eval | Promptfoo, RAGAS, DeepEval, LangSmith Evals |
| Cost monitoring | Helicone, OpenMeter |
| Prompt versioning | LangSmith, Humanloop, PromptLayer |
| Gateway / routing | Portkey, OpenRouter, LiteLLM |
| Guardrails | Guardrails AI, NeMo Guardrails, Rebuff |
| Feature flagging | LaunchDarkly (LLM-specific flags) |

---

## Key Operational Practices

**Prompts as code**
- Version prompts in git
- Tie prompt version to deployment
- A/B test prompt changes with real traffic

**Model routing**
- Cheapest model that meets quality threshold
- Cascading fallbacks (fast cheap → slower strong)
- Multi-provider for outage resilience (76%+ of production teams use multiple providers)

**Cost controls**
- Per-user/feature rate limits
- Prompt caching (Anthropic, OpenAI both support)
- Compression of long contexts
- Streaming to cut perceived latency

**Safety and security**
- Prompt injection detection (Rebuff, Lakera)
- PII redaction at ingress
- Output filtering for policy compliance
- Rate limiting for abuse prevention

---

## Silent-Degradation Problem

Agentic AI systems don't fail suddenly — they drift over weeks. Without telemetry you notice only after the accumulated risk becomes visible. Observability must be built in from day one, not bolted on after incidents.

---

## Common Anti-Patterns

- **Logging prompts in plaintext** — contains PII and credentials
- **Single-provider lock-in** — outage = full outage
- **No eval regression gate in CI** — ship a bad prompt to prod
- **Manual transcript review only** — doesn't scale past ~100 requests/day
- **Missing cost alarms** — a prompt loop can run up $10K overnight

---

## Connections

- [[AI Engineering]] — LLMOps is part of the production skill layer
- [[AI Evals]] — evaluation is the quality signal for LLMOps
- [[AI Agents]] — observability is mandatory for agent production
