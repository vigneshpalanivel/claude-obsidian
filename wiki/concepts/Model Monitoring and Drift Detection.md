---
type: concept
title: "Model Monitoring and Drift Detection"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ml-engineering
  - monitoring
  - drift
  - production
status: current
related:
  - "[[MLOps]]"
  - "[[Machine Learning Engineering]]"
  - "[[LLMOps and AI Observability]]"
  - "[[Model Training Pipeline]]"
  - "[[Research: ML Engineering]]"
  - "[[concepts/_index]]"
---

# Model Monitoring and Drift Detection

The production practice of continuously measuring an ML model's input distribution, output distribution, and business-metric performance to detect silent degradation. Models don't crash — they drift, and without monitoring you'll only notice after the business impact is visible.

---

## Why Monitoring Is Different for ML

Traditional observability (logs, latency, errors) catches **availability** problems. ML systems fail differently: the endpoint returns 200 OK, the latency is fine, but the *predictions are slowly becoming wrong*.

**<40% of production ML models sustain business value past 12 months** (Source: [[Azilen-MLOps-Best-Practices-2026]]) — the main cause is unmonitored drift.

---

## Types of Drift

| Drift | Definition | Example |
|-------|------------|---------|
| **Data drift** (covariate shift) | Input feature distributions change | User demographics shift; new product categories |
| **Concept drift** | Relationship between inputs and outputs changes | Fraud patterns evolve; user tastes shift |
| **Label drift** (prior shift) | Output class proportions change | Class imbalance grows over time |
| **Upstream drift** | Feature pipeline changes silently | Dependency updated, feature means different |

---

## What to Monitor

**Input-side (data health)**
- Feature means, stds, distributions (PSI, KL divergence, Wasserstein)
- Missing value rates
- Schema violations, type errors
- Input volume anomalies

**Output-side (prediction health)**
- Prediction distribution vs training-time baseline
- Confidence/probability distributions
- Flip rates between serving versions

**Performance (requires ground truth)**
- Accuracy, F1, AUC — when labels arrive
- Business KPIs (revenue, conversion, retention) — the ultimate truth
- Delayed-label techniques when ground truth lags

**Infrastructure**
- Latency P50/P95/P99
- Inference cost per prediction
- GPU utilization
- Error rates

---

## Drift Metrics

| Metric | Use | Threshold |
|--------|-----|-----------|
| **PSI** (Population Stability Index) | Feature distribution shift | 0.1 = light, 0.25+ = heavy |
| **KL divergence** | Probability distribution distance | Context-dependent |
| **Wasserstein** | Earth-mover distance between distributions | More robust than PSI |
| **Kolmogorov-Smirnov** | Two-sample distribution test | p < 0.05 |
| **Chi-square** | Categorical feature drift | p < 0.05 |

---

## Monitoring Tools

| Tool | Focus |
|------|-------|
| **WhyLabs** | Data profiling + drift, OSS whylogs |
| **Arize** | Full ML observability |
| **Fiddler** | Explainability + monitoring |
| **Evidently** | Open-source drift reports |
| **Grafana + Prometheus** | Custom metrics dashboards |

---

## Response Patterns

When drift is detected, automated options:

1. **Alert + human review** — default
2. **Automated retraining** — trigger the [[Model Training Pipeline]]
3. **Shadow deployment** — new model runs alongside, compare predictions
4. **Rollback** — revert to previous model version
5. **Feature pipeline investigation** — drift may be upstream bug, not real data shift

---

## Silent Degradation Playbook

Agentic and LLM systems drift too — see [[LLMOps and AI Observability]]. For all AI systems:

1. Establish baselines **before** production
2. Monitor continuously; don't sample only on incidents
3. Set thresholds tied to business impact, not just statistics
4. Investigate drift *before* retraining — it may be a data pipeline bug
5. Log everything with enough context to reconstruct any production failure

---

## Connections

- [[MLOps]] — monitoring is one of the seven core practices
- [[Model Training Pipeline]] — drift detection feeds back into retraining
- [[LLMOps and AI Observability]] — the LLM-specific extension
- [[Machine Learning Engineering]] — MLEs own the monitoring surface
