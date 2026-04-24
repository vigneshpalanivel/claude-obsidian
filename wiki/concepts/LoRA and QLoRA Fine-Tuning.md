---
type: concept
title: "LoRA and QLoRA Fine-Tuning"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ml-engineering
  - fine-tuning
  - lora
  - llm
status: current
related:
  - "[[Machine Learning Engineering]]"
  - "[[Model Training Pipeline]]"
  - "[[AI Engineering]]"
  - "[[Research: ML Engineering]]"
  - "[[concepts/_index]]"
sources:
  - "[[N1N-LoRA-QLoRA-Fine-Tuning-Guide-2026]]"
---

# LoRA and QLoRA Fine-Tuning

Parameter-efficient fine-tuning methods that make customizing large language models tractable on consumer/mid-range hardware. The most commercially important ML engineering technique of 2024-2026 — it's the bridge between "use a generic API" and "train a model from scratch," and the highest-paid AI engineering specialization.

---

## The Core Idea

Instead of updating all N billion parameters of a base model during fine-tuning, freeze them and train only small **rank-decomposed adapter matrices** alongside. The adapters are tiny (a few megabytes) but can meaningfully specialize behavior.

- **LoRA** (Low-Rank Adaptation) — rank-decomposition of weight deltas
- **QLoRA** — LoRA + 4-bit quantization of the frozen base model; drastically reduces memory
- **DoRA** (Weight-Decomposed LoRA, 2026 favorite) — decomposes updates into magnitude + direction for better convergence

---

## Performance vs Full Fine-Tune

LoRA recovers **90-95% of full fine-tune performance** at a fraction of memory/compute. (Source: [[N1N-LoRA-QLoRA-Fine-Tuning-Guide-2026]])

For most production use cases (brand voice, format adherence, domain Q&A) the quality gap is negligible — the compute savings are enormous.

---

## Hardware Requirements (2026)

| Base model size | LoRA memory | QLoRA memory |
|-----------------|-------------|-------------|
| 7B-8B | ~16 GB (RTX 4070 Ti) | ~8 GB (consumer GPU) |
| 13B | ~30 GB | ~12 GB |
| 70B | ~140 GB (A100×2) | ~46 GB (A100 80GB) |

QLoRA trades **33% less memory** for **39% more training time** on 7B models. Use QLoRA when VRAM is the bottleneck, LoRA when wall-clock time is.

---

## When Fine-Tuning Is the Right Tool

✅ **Good fits**
- Brand voice or writing style consistency
- Strict format adherence (JSON, specific templates)
- Domain terminology (legal, medical, finance)
- Offline/on-prem compliance (data can't leave perimeter)
- Task specialization where prompting keeps failing

❌ **Bad fits**
- Factual knowledge injection (use RAG instead)
- Rapidly changing information (fine-tuning is static)
- When a well-engineered prompt + RAG solves it
- When you have <100 high-quality examples

---

## 2026 Default Tooling

- **Unsloth** — speed-optimized training, 2-5× faster than baseline HF
- **Axolotl** — YAML-driven configuration pipelines
- **LlamaFactory** — visual interface for UI-preferring teams
- **Hugging Face PEFT** — the library LoRA/QLoRA live under

(Source: [[N1N-LoRA-QLoRA-Fine-Tuning-Guide-2026]])

---

## Key Hyperparameters

- **Rank (r)**: 16-64 (higher = more capacity, more memory)
- **Alpha**: typically 2×r
- **Learning rate**: start at 2e-4, lower for larger models
- **Target modules**: query/key/value projections + MLP — pick based on model architecture

---

## Data Quality Rule

**200 hand-curated examples often outperform 2,000 machine-generated ones.**

Data quality beats quantity for fine-tuning. Budget effort for human curation, not data scaling.

---

## Evaluation

- **Perplexity** on held-out validation set — primary metric
- **MMLU Delta** — guard against catastrophic forgetting; drop >3 points is a red flag
- **Task-specific evals** — the actual downstream behavior you care about
- **Red-team prompts** — check that safety/alignment didn't degrade

---

## Business Relevance

Fine-tuning is the highest-premium ML specialization in 2026 (+40-60% pay premium). For [[Trioangle]], it's the service offering that moves the company from "generic AI agency" to "custom AI capability partner." Healthcare, finance, and legal verticals specifically demand on-prem fine-tuning for compliance.

---

## Connections

- [[Machine Learning Engineering]] — fine-tuning is a core MLE skill
- [[Model Training Pipeline]] — fine-tuning runs as a specialized pipeline
- [[AI Engineering]] — AI engineers call fine-tuned adapters from application code
