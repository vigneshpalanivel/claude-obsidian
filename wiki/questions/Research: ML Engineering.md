---
type: synthesis
title: "Research: ML Engineering"
created: 2026-04-23
updated: 2026-04-23
tags:
  - research
  - ml-engineering
  - synthesis
status: developing
related:
  - "[[Machine Learning Engineering]]"
  - "[[MLOps]]"
  - "[[Model Training Pipeline]]"
  - "[[LoRA and QLoRA Fine-Tuning]]"
  - "[[Model Monitoring and Drift Detection]]"
  - "[[PyTorch]]"
  - "[[MLflow]]"
  - "[[AI Engineering]]"
  - "[[Research: AI Engineering]]"
  - "[[Trioangle]]"
sources:
  - "[[TDS-Evolving-Role-ML-Engineer-2026]]"
  - "[[MLOps-Principles-ml-ops-org]]"
  - "[[Signify-ML-Engineer-Salary-Benchmarks-2026]]"
  - "[[N1N-LoRA-QLoRA-Fine-Tuning-Guide-2026]]"
  - "[[Azilen-MLOps-Best-Practices-2026]]"
---

# Research: ML Engineering

## Overview

ML Engineering in 2026 has bifurcated from its pre-LLM form. The "train models from scratch, deploy endpoints, monitor drift" discipline remains essential — but the share of work absorbed by foundation-model APIs has shifted routine production to AI engineers, while concentrating ML engineering on **custom model work, fine-tuning, and the infrastructure gap that still kills 85% of ML projects**. The role pays well ($206K+ average, up to $521K senior total comp) because demand outstrips supply 3.2:1, and the single highest-paying specialization is GenAI/LLM fine-tuning (+40-60% over baseline MLE pay).

---

## Key Findings

- **The role shifted, not disappeared.** Experienced MLEs remain essential for non-standard problems; LLMs automated boilerplate but not judgment. (Source: [[TDS-Evolving-Role-ML-Engineer-2026]])
- **ML Engineer ≠ AI Engineer** (see [[Research: AI Engineering]]). MLEs train/optimize models; AI engineers integrate existing models into products. The split is real and the skill stacks have diverged.
- **Production gap is the defining problem.** Gartner: 85%+ of ML projects fail to reach production; <40% of deployed models sustain value past 12 months. (Source: [[Azilen-MLOps-Best-Practices-2026]]) The market pays for production, not modeling.
- **MLOps demand up 35%+ YoY in 2026.** Companies have models; they can't operationalize them.
- **Compensation anchor (US)**: Senior $195K-$275K base; Lead/Principal $208K-$355K (Bay Area); senior total comp $322K-$521K including equity. (Source: [[Signify-ML-Engineer-Salary-Benchmarks-2026]])
- **Talent ratio**: demand-to-supply **3.2:1** — severe shortage. AI/ML job postings +89% H1 2025.
- **GenAI/LLM specialization commands a 40-60% salary premium.** MLOps +25-40%. Domain expertise (healthcare, finance) +30-50%. Generalists get paid least.
- **PyTorch is the dominant framework** at 55%+ production share. TorchCompile and FSDP closed the gap vs compiled-graph frameworks. (Source: web search results)
- **Fine-tuning is tractable on consumer hardware**: LoRA on 7B models fits in 16GB VRAM; QLoRA fits in 8GB. 70B models: QLoRA on single A100 80GB (46GB used). (Source: [[N1N-LoRA-QLoRA-Fine-Tuning-Guide-2026]])
- **Data quality > quantity**: 200 hand-curated fine-tuning examples routinely beat 2,000 machine-generated ones.
- **Unsloth, Axolotl, LlamaFactory** are the 2026 default fine-tuning toolchains.
- **MLOps principles have solidified** (Source: [[MLOps-Principles-ml-ops-org]]): Continuous X (CI/CD/CT/CM), three-scope testing (data/model/infra), versioning-as-first-class, reproducibility non-negotiable.
- **Production AI ≠ single model**: 2026 systems are orchestrations — foundation model + fine-tuned adapters + retrieval + guardrails + routing + feedback. MLOps → LLMOps extension is now mainstream.
- **[[MLflow]] is the dominant open-source MLOps platform**; Databricks-backed, framework-agnostic.

---

## Key Entities

- [[PyTorch]] — dominant training framework
- [[MLflow]] — dominant OSS MLOps platform

---

## Key Concepts

- [[Machine Learning Engineering]] — the discipline
- [[MLOps]] — operational practice
- [[Model Training Pipeline]] — core artifact MLEs build
- [[LoRA and QLoRA Fine-Tuning]] — highest-premium specialization
- [[Model Monitoring and Drift Detection]] — the ongoing production discipline

---

## Contradictions

- **Is the ML engineer role dying or thriving?** Some 2025-26 voices (Egor Howell's "Is ML Engineering Dead?") suggest the classical MLE is being absorbed into AI engineering. Practitioner voices (Kirmer, [[TDS-Evolving-Role-ML-Engineer-2026]]) argue it's shifting, not dying, and hedge-fund/FAANG salary data ($300K-$500K+ senior) strongly supports ongoing demand. Reconciliation: *routine* ML work is being absorbed; *specialized* ML work pays more than ever.
- **Fine-tuning vs RAG for domain knowledge**: some sources push fine-tuning for "brand voice + domain depth"; others argue RAG is always better for factual knowledge. Both are true: fine-tune behavior (style, format), RAG for facts (things that change).

---

## Open Questions

> [!gap] What is the India/SEA ML engineer salary reality? All salary data here is US-centric. [[Trioangle]] hiring needs local data.

> [!gap] Do managed platforms (SageMaker, Vertex, Azure ML) meaningfully reduce the 85% production-fail rate, or do they just move the failure elsewhere?

> [!gap] As foundation models continue to improve, what fraction of classical "train a model" use cases remain? When does fine-tuning lose to prompting + RAG?

> [!gap] How does MLOps evolve as agent systems become more prevalent? [[LLMOps and AI Observability]] has different testing demands than static-model MLOps.

---

## Implications for Trioangle

Given [[Trioangle]]'s pivot (see [[Research: Running a Software Dev Company Post-Vibe-Coding]]), the ML engineering dimension adds:

1. **Don't hire ML engineers first.** AI engineers (integrators) deliver revenue faster. MLEs make sense in Phase 2+ once fine-tuning / custom model services become a proven offering.
2. **LLM fine-tuning is the single highest-leverage ML service to offer.** Healthcare, finance, and legal clients want on-prem fine-tuned models for compliance — this is a 40-60% margin premium service.
3. **MLOps consulting is a separate revenue line.** 85% production-fail rate means enterprises have shelved models waiting for someone to productionize them. Pure MLOps engagements (retainers) are high-margin, skill-deep, and don't require bleeding-edge model work.
4. **Don't try to compete on model training from scratch.** That's research-lab territory. Compete on *applied* ML + fine-tuning + MLOps.
5. **Domain specialization remains the moat**: +30-50% rate premium in any vertical Trioangle already serves.

---

## Sources

- [[TDS-Evolving-Role-ML-Engineer-2026]] — practitioner view on role evolution
- [[MLOps-Principles-ml-ops-org]] — canonical MLOps reference
- [[Signify-ML-Engineer-Salary-Benchmarks-2026]] — US compensation data
- [[N1N-LoRA-QLoRA-Fine-Tuning-Guide-2026]] — fine-tuning practical guide
- [[Azilen-MLOps-Best-Practices-2026]] — production-reality statistics
