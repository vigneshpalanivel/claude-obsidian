---
type: concept
title: "MLOps"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ml-engineering
  - mlops
  - production
status: current
related:
  - "[[Machine Learning Engineering]]"
  - "[[Model Training Pipeline]]"
  - "[[Model Monitoring and Drift Detection]]"
  - "[[LLMOps and AI Observability]]"
  - "[[MLflow]]"
  - "[[Research: ML Engineering]]"
  - "[[concepts/_index]]"
sources:
  - "[[MLOps-Principles-ml-ops-org]]"
  - "[[Azilen-MLOps-Best-Practices-2026]]"
---

# MLOps

The operational discipline that treats ML systems with the same rigor as traditional software. MLOps covers versioning, testing, deployment, monitoring, and continuous retraining of models in production. It exists because ML systems decay, drift, and fail in ways software monitoring alone doesn't catch.

---

## Why MLOps Exists

- **85%+ of ML projects fail to reach production** (Gartner 2025)
- **<40%** of deployed models sustain value past 12 months
- Models decay silently as input distributions shift
- Standard CI/CD doesn't test data, features, or model quality

(Source: [[Azilen-MLOps-Best-Practices-2026]])

---

## Core Principles

(Source: [[MLOps-Principles-ml-ops-org]])

**Iterative-Incremental Development** — three phases (design, experiment, operate) with feedback loops

**Automation Maturity Levels**
1. Manual (Jupyter-style experimentation)
2. ML pipeline automation (training triggered by new data)
3. Full CI/CD (automated build/test/deploy)

**Continuous X**
- **CI** — test data, features, model code
- **CD** — automated model deployment
- **CT (Continuous Training)** — automatic retraining on new data
- **CM (Continuous Monitoring)** — track production against business metrics

**Versioning** — code, data, models, configs, eval results all first-class artifacts

**Testing Across Three Scopes**
1. Data/features — quality, validation, schema checks
2. Model — performance, fairness, staleness
3. Infrastructure — reproducibility, canary, integration

**Reproducibility** — identical inputs yield identical outputs at every phase

---

## The MLOps Stack

| Component | Function |
|-----------|----------|
| Source control | Versions code, data, model artifacts |
| Test/build services | Quality gates, executables |
| Deployment services | Pipeline orchestration to environments |
| Model registry | Trained model storage + metadata |
| Feature store | Preprocessing + serving features |
| Metadata store | Training run tracking |
| Pipeline orchestrator | End-to-end automation |

---

## 2026 Evolution: MLOps → AIOps/LLMOps

Production AI systems in 2026 are **not single models** but orchestrations:

- Foundation models (APIs or self-hosted)
- Fine-tuned adapters (LoRA checkpoints)
- Retrieval systems (vector DBs, embeddings)
- Guardrails (safety, policy)
- Routing logic (model selection, fallbacks)
- Feedback mechanisms (user signals → retraining)

Classical MLOps extends into **LLMOps** — see [[LLMOps and AI Observability]]. The two share foundations but differ in:

| Area | MLOps | LLMOps |
|------|-------|--------|
| Versioning | Code + models + data | Code + models + **prompts** |
| Training | Training pipelines primary | Fine-tuning is optional |
| Evaluation | Held-out test sets | Eval suites, LLM-judge, trajectories |
| Cost | GPU training cost | Per-token inference cost |
| Monitoring | Drift, accuracy | Drift, hallucination, safety |

---

## Seven Most Commonly Missing Practices

(Source: [[Azilen-MLOps-Best-Practices-2026]])

1. Automated ML pipelines (CI/CD/CT)
2. Model versioning + registry
3. Data drift detection
4. Automated retraining triggers
5. Model explainability / governance
6. Cost optimization for LLM inference
7. LLMOps extensions for GenAI

If you're missing 3+ of these, you don't have production MLOps.

---

## Common Tools

- **Pipeline orchestrators**: Kubeflow, Metaflow, Airflow, Dagster, Prefect
- **Model/experiment tracking**: [[MLflow]], W&B, Neptune, Comet
- **Model serving**: BentoML, KServe, Ray Serve, TorchServe, Triton
- **Monitoring**: WhyLabs, Arize, Fiddler, Evidently
- **Cloud platforms**: AWS SageMaker, GCP Vertex AI, Azure ML
- **Feature stores**: Feast, Tecton

---

## The ML Test Score

A readiness framework measuring four categories. **Score >3 = production-ready automated testing**. Below that, you're flying blind.

---

## Connections

- [[Machine Learning Engineering]] — the discipline that owns MLOps
- [[LLMOps and AI Observability]] — MLOps applied to LLM/agent systems
- [[Model Monitoring and Drift Detection]] — the continuous-monitoring practice
- [[Model Training Pipeline]] — the pipeline MLOps automates
