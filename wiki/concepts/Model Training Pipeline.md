---
type: concept
title: "Model Training Pipeline"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ml-engineering
  - training
  - pipelines
status: current
related:
  - "[[Machine Learning Engineering]]"
  - "[[MLOps]]"
  - "[[LoRA and QLoRA Fine-Tuning]]"
  - "[[PyTorch]]"
  - "[[Research: ML Engineering]]"
  - "[[concepts/_index]]"
---

# Model Training Pipeline

The end-to-end automated workflow for taking raw data to a trained, registered, deployable model. Training pipelines are the central artifact of ML engineering — production MLOps is essentially "the training pipeline runs correctly, on new data, without human intervention."

---

## Pipeline Stages

```
Raw data
   ↓
Ingestion (batch or streaming)
   ↓
Validation (schema, quality, drift)
   ↓
Feature engineering (transform, encode)
   ↓
Feature store (materialized + versioned)
   ↓
Training (distributed if large)
   ↓
Evaluation (held-out + eval suite)
   ↓
Model registry (versioned artifact)
   ↓
Deployment (canary → rollout)
```

Each stage is a versioned, observable unit. Each can fail and trigger alerts without taking down the whole pipeline.

---

## Distributed Training Patterns

For models beyond single-GPU memory:

| Pattern | What it shards | When to use |
|---------|---------------|-------------|
| **DDP** (DistributedDataParallel) | Gradients only | Fits in single GPU memory; scale by batch |
| **FSDP** (Fully Sharded Data Parallel) | Parameters + gradients + optimizer state | Won't fit in single GPU |
| **DeepSpeed ZeRO** | Optimizer state + gradients + params | Large model, memory-constrained |
| **Pipeline parallel** | Layers across GPUs | Very large sequential models |
| **Tensor parallel** | Tensor operations across GPUs | Each layer won't fit on one GPU |

[[PyTorch]] provides native DDP and FSDP. DeepSpeed from Microsoft is the most-adopted layer on top for large-model work.

---

## Pipeline Orchestrators

- **Kubeflow** — Kubernetes-native, heavy but powerful
- **Metaflow** (Netflix) — Python-native, developer-friendly
- **Airflow** — general-purpose workflow engine
- **Dagster** — data-asset-oriented
- **Prefect** — modern Airflow alternative
- **Managed**: AWS SageMaker Pipelines, GCP Vertex AI Pipelines, Azure ML

---

## Key Decisions

**Batch vs streaming** — streaming if data arrives continuously and freshness matters; batch otherwise

**On-prem vs cloud** — cloud is default unless data sovereignty requires on-prem (healthcare, finance, government)

**Framework**: [[PyTorch]] has **55%+ production share in 2025-2026**; JAX for research; TensorFlow for edge/legacy

**Hyperparameter search**: Optuna, Ray Tune, W&B Sweeps

**Training cost optimization**
- Spot instances where interrupts are tolerable
- Mixed precision (fp16/bf16)
- Gradient checkpointing
- Efficient checkpointing to reduce restart cost

---

## Common Failure Modes

- **Training-serving skew** — features computed differently at train time vs serve time
- **Data leakage** — test set contaminates train set
- **Silent drift** — input distribution shifts, training set goes stale
- **Reproducibility gaps** — unversioned data, non-deterministic ops
- **Catastrophic forgetting** (for fine-tuning) — model loses general capability

---

## Reproducibility Checklist

- Data snapshot hash / version pin
- Library version pins (framework, CUDA)
- Random seed fixed
- Hardware-agnostic determinism (or noted non-determinism)
- Config serialized alongside model
- Training logs captured (experiment tracker)

---

## Connections

- [[MLOps]] — the discipline around the pipeline
- [[LoRA and QLoRA Fine-Tuning]] — the LLM-era specialization of training
- [[Model Monitoring and Drift Detection]] — what triggers the next training run
- [[PyTorch]] — the dominant training framework
