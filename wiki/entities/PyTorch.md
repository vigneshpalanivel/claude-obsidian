---
type: entity
title: "PyTorch"
entity_type: framework
created: 2026-04-23
updated: 2026-04-23
tags:
  - entity
  - ml-framework
  - deep-learning
status: current
related:
  - "[[Machine Learning Engineering]]"
  - "[[Model Training Pipeline]]"
  - "[[MLflow]]"
  - "[[Research: ML Engineering]]"
  - "[[entities/_index]]"
---

# PyTorch

Open-source deep learning framework, originally Meta (Facebook AI Research), now governed by the **PyTorch Foundation** under the Linux Foundation. The dominant ML training framework in 2026.

---

## Market Position

- **55%+ production share in 2025-2026** — now the clear default for deep learning training
- Dominant in research (appearing in most ML papers)
- Expanded production share after TorchServe, TorchCompile, and FSDP matured

---

## What It Is

A Python-first tensor library with dynamic computation graphs, autograd for automatic differentiation, and a large ecosystem of higher-level tools.

---

## Core APIs

- **torch.nn** — neural network modules
- **torch.optim** — optimizers (Adam, AdamW, SGD, etc.)
- **torch.utils.data** — Dataset, DataLoader abstractions
- **torch.distributed** — multi-GPU/multi-node training
- **torch.cuda** — GPU-accelerated tensor ops
- **torch.compile** — JIT compilation for speedups (2.x era)

---

## Distributed Training

- **DDP** (DistributedDataParallel) — default for multi-GPU scale-out
- **FSDP** (Fully Sharded Data Parallel) — for models beyond single-GPU memory
- Works natively with DeepSpeed, Ray, and cloud orchestrators

---

## Ecosystem

| Layer | Libraries |
|-------|-----------|
| Training utilities | PyTorch Lightning, HuggingFace Accelerate |
| LLM specialization | HuggingFace Transformers, Unsloth, Axolotl |
| Vision | torchvision, timm |
| NLP | torchtext (deprecated), HF ecosystem |
| Audio | torchaudio |
| RL | TorchRL, stable-baselines3 |
| Serving | TorchServe, Triton Inference Server |
| Edge | ExecuTorch, LiteRT (via conversion) |

---

## 2026 Developments

- **Google LiteRT** now supports first-class PyTorch edge deployment (March 2026)
- **IBM** expanded open-source training/inference investment (2026)
- **TorchCompile** maturity makes it competitive with compiled graphs (TF/JAX)
- **ExecuTorch** for on-device deployment stabilized

---

## When to Choose PyTorch vs Alternatives

| Need | Choice |
|------|--------|
| Research + rapid iteration | PyTorch |
| Production training (default) | PyTorch |
| TPU-heavy workload, functional purity | JAX |
| Edge deployment (Android, iOS) | PyTorch → LiteRT, or native TF |
| Legacy production pipelines | TensorFlow (often already deployed) |

---

## Licensing

BSD-style (permissive). Freely usable commercially.

---

## Connections

- [[Machine Learning Engineering]] — PyTorch is the dominant training tool
- [[Model Training Pipeline]] — the framework around which pipelines are built
- [[LoRA and QLoRA Fine-Tuning]] — LoRA tooling typically wraps PyTorch + Transformers
