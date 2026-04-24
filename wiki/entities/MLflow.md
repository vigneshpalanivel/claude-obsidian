---
type: entity
title: "MLflow"
entity_type: framework
created: 2026-04-23
updated: 2026-04-23
tags:
  - entity
  - mlops
  - experiment-tracking
status: current
related:
  - "[[MLOps]]"
  - "[[Machine Learning Engineering]]"
  - "[[Model Training Pipeline]]"
  - "[[Research: ML Engineering]]"
  - "[[entities/_index]]"
---

# MLflow

Open-source MLOps platform for managing the ML lifecycle — experiment tracking, model registry, packaging, and deployment. Originally open-sourced by Databricks. **The most widely adopted open-source MLOps platform in 2025-2026.**

---

## What It Does

Four core components:

| Component | Function |
|-----------|----------|
| **MLflow Tracking** | Log params, metrics, artifacts for every run |
| **MLflow Projects** | Packaging format for reproducible runs |
| **MLflow Models** | Standard model format across frameworks |
| **MLflow Model Registry** | Versioned catalog of production models |

---

## Why It Won

- **Framework-agnostic** — works with PyTorch, TF, scikit-learn, XGBoost, Hugging Face, etc.
- **Self-hostable** — no cloud lock-in, runs from a Python `pip install`
- **Databricks-backed** — commercial entity behind OSS investment
- **Standard model format** — MLflow Models work across serving targets
- Free, open-source (Apache 2.0)

---

## Core Use Patterns

**Experiment tracking**
```python
with mlflow.start_run():
    mlflow.log_param("lr", 0.001)
    mlflow.log_metric("val_loss", 0.23)
    mlflow.log_model(model, "model")
```

**Model Registry**
- Register model → Staging → Production transitions
- Version lineage tied to Git commit + training data hash
- Webhook triggers for deployment

---

## Alternatives

| Tool | When it wins |
|------|--------------|
| **Weights & Biases** | Richer UI, collaborative experiment tracking, premium visualizations |
| **Neptune** | Enterprise-focused, strong lineage |
| **Comet** | Similar to W&B |
| **ClearML** | Open-source full-lifecycle platform |
| **Kubeflow Metadata** | Kubernetes-native metadata store |

MLflow wins on open-source + simple setup + framework coverage.

---

## 2026 LLMOps Extensions

MLflow has added LLM-specific features:
- **MLflow LLM Evaluate** — LLM evals built in
- **Prompt engineering UI** — version prompts alongside models
- **Tracing** — agent and LLM call traces
- **Deployments Server** — gateway for multi-LLM provider routing

This positions MLflow as one of the platforms trying to span traditional MLOps and [[LLMOps and AI Observability]] in one tool.

---

## Connections

- [[MLOps]] — MLflow is the dominant OSS MLOps platform
- [[Model Training Pipeline]] — MLflow tracks every pipeline run
- [[Machine Learning Engineering]] — core tool in the MLE toolkit
