---
type: source
title: "MLOps Principles (ml-ops.org)"
source_type: reference
author: "INNOQ / ml-ops.org community"
date_published: 2026
url: "https://ml-ops.org/content/mlops-principles"
confidence: high
key_claims:
  - "MLOps treats ML artifacts as first-class citizens requiring version control"
  - "Continuous X: CI, CD, CT (training), CM (monitoring)"
  - "Three automation maturity levels: manual, ML pipeline, CI/CD"
  - "Testing spans three scopes: data/features, model, infrastructure"
  - "MLOps Stack: source control, test/build, deployment, model registry, feature store, metadata store, orchestrator"
created: 2026-04-23
updated: 2026-04-23
tags:
  - source
  - ml-engineering
  - mlops
status: current
related:
  - "[[MLOps]]"
  - "[[Machine Learning Engineering]]"
  - "[[Research: ML Engineering]]"
  - "[[sources/_index]]"
---

# MLOps Principles (ml-ops.org)

**Source**: [ml-ops.org](https://ml-ops.org/content/mlops-principles) | INNOQ / ml-ops.org community | evergreen

---

## Summary

Authoritative reference for MLOps principles. Treated as the canonical definition of what MLOps is and what a mature MLOps stack looks like. High-confidence source.

---

## Core Principles

**1. Iterative-Incremental Development** — three phases (design, experiment/develop, operate) with continuous feedback loops

**2. Automation Maturity**
- Manual: Jupyter-style experimentation
- ML pipeline automation: training triggered by new data
- CI/CD: fully automated build/test/deploy

**3. Continuous X**
- **CI** — testing data and models alongside code
- **CD** — automated model deployment
- **CT (Continuous Training)** — automatic retraining cycles
- **CM (Continuous Monitoring)** — production tracking vs. business metrics

**4. Versioning** — training scripts, models, and datasets all as first-class versioned artifacts

**5. Testing Across Three Scopes**
- Data/features — validation and quality
- Model — performance, fairness, staleness
- Infrastructure — reproducibility, integration, canary deployments

**6. Monitoring and Decay** — staleness, data drift, prediction quality, compute performance → triggers retraining

**7. Reproducibility** — same inputs produce identical outputs at every phase

---

## MLOps Stack Components

| Component | Function |
|-----------|----------|
| Source Control | Versions code, data, model artifacts |
| Test/Build Services | Quality assurance, build executables |
| Deployment Services | Pipeline orchestration to environments |
| Model Registry | Trained model storage and retrieval |
| Feature Store | Preprocessing and feature serving |
| ML Metadata Store | Training metadata tracking |
| ML Pipeline Orchestrator | Experiment automation |

---

## ML Test Score

A readiness framework measuring four categories. Score >3 indicates strong automated testing — a production-readiness threshold.

---

## What This Contributes

Canonical definitional source for [[MLOps]]. Informs evaluation of any ML platform claims — if a stack is missing these components, it's not production-MLOps.
