---
type: concept
title: "ML Engineering Learning Roadmap"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ml-engineering
  - learning-roadmap
  - self-study
status: current
related:
  - "[[Machine Learning Engineering]]"
  - "[[AI Engineering Learning Roadmap]]"
  - "[[AI Engineering Portfolio Projects]]"
  - "[[MLOps]]"
  - "[[Model Training Pipeline]]"
  - "[[LoRA and QLoRA Fine-Tuning]]"
  - "[[PyTorch]]"
  - "[[MLflow]]"
  - "[[Research: AI ML Engineering Roadmap]]"
  - "[[concepts/_index]]"
sources:
  - "[[Scaler-ML-Roadmap-2026]]"
  - "[[AI-Engineer-Reading-List-2026]]"
---

# ML Engineering Learning Roadmap

Beginner-to-advanced self-study path for [[Machine Learning Engineering]] — the discipline of training, deploying, and maintaining ML models as production systems. Deeper math than the AI engineering path, longer timeline. **Total: 12 months intensive to job-ready.**

---

## Orientation

ML engineering differs from AI engineering in two ways:
1. **You train models.** Not just call APIs.
2. **Math matters.** Not research-level, but enough to understand why algorithms work.

If your goal is "ship features with Claude/GPT/Gemini APIs," take the [[AI Engineering Learning Roadmap]] instead. This path is for: training models, fine-tuning, deep learning architectures, custom models, and research-adjacent engineering.

---

## The 7 Phases (Scaler 2026 framework)

(Source: [[Scaler-ML-Roadmap-2026]])

```
Phase 1 — Programming + Math           (Months 1-2)
Phase 2 — Core ML Concepts             (Months 3-5)
Phase 3 — ML Libraries + Tools         (Months 6-7)
Phase 4 — Advanced ML (Deep Learning)  (Months 8-9)
Phase 5 — Deployment + MLOps           (Month 10)
Phase 6 — Applied Projects             (Months 11-12)
Phase 7 — Continuous Learning          (ongoing)
```

---

## Phase 1 — Programming + Math (Beginner)

**Time:** 2 months

**Programming**
- Python with Jupyter Notebooks
- NumPy (vector/matrix ops)
- Pandas (data manipulation)
- Matplotlib + Seaborn (visualization)

**Math (intuition, not rigor)**
- Linear algebra — vectors, matrices, matrix mult, eigenvalues
- Calculus — derivatives, gradients, chain rule
- Probability — random variables, distributions, Bayes
- Statistics — mean/variance/stddev, correlation, hypothesis testing

**Resources**
- Free: [Khan Academy Linear Algebra](https://www.khanacademy.org/math/linear-algebra), [3Blue1Brown: Essence of Linear Algebra](https://www.3blue1brown.com/topics/linear-algebra), [Pandas docs + tutorials](https://pandas.pydata.org/docs/getting_started/)
- Course: Andrew Ng's *Machine Learning Specialization* (Coursera, free to audit)

**Projects**
- EDA on a public dataset (Titanic, housing prices)
- Simple linear regression from scratch with NumPy
- Data visualization dashboard

**Exit criterion:** You can load a CSV in Pandas, compute basic statistics, visualize distributions, and explain what a gradient is.

---

## Phase 2 — Core ML (Beginner → Intermediate)

**Time:** 3 months

**Algorithms**
- Linear + logistic regression
- Decision trees + random forests
- KNN, SVM, Naive Bayes
- K-means, DBSCAN (clustering)
- PCA (dimensionality reduction)

**Concepts**
- Train/val/test splits
- Cross-validation
- Bias-variance tradeoff
- Overfitting / regularization
- Feature engineering
- Hyperparameter tuning

**Tools**
- Scikit-learn (primary)
- Imbalanced-learn
- Optuna (hyperparameter search)

**Resources**
- Andrew Ng's Machine Learning Specialization (full)
- Book: *Hands-On Machine Learning with Scikit-Learn, Keras, and TensorFlow* by Aurélien Géron
- Platform: Kaggle Learn (free microcourses)

**Projects**
- Titanic survival prediction (classic)
- House price regression
- Customer churn classifier
- Clustering on customer segments

**Exit criterion:** You can build a Scikit-learn pipeline end-to-end: load data → feature engineer → train → evaluate → tune → interpret results.

---

## Phase 3 — ML Libraries + Tools (Intermediate)

**Time:** 2 months

**Frameworks**
- [[PyTorch]] (primary for 2026)
- TensorFlow/Keras (for edge + legacy)
- Hugging Face Transformers (NLP)

**Concepts**
- Tensors + autograd
- Neural networks from scratch
- Dataloaders + datasets
- Training loops
- GPU acceleration

**Resources**
- Free: [Learn PyTorch for Deep Learning (Zero to Mastery)](https://www.learnpytorch.io/) — Daniel Bourke
- Free: [PyTorch official tutorials](https://pytorch.org/tutorials/)
- Course: [DeepLearning.AI PyTorch Specialization](https://www.deeplearning.ai/)

**Projects**
- MNIST digit classification in PyTorch
- Simple neural network from scratch (no frameworks)
- Transfer learning on CIFAR-10

**Exit criterion:** You can write a PyTorch training loop from scratch, debug gradient issues, and use GPU acceleration.

---

## Phase 4 — Advanced ML / Deep Learning (Intermediate → Advanced)

**Time:** 2 months

**Architectures**
- CNNs (image classification, object detection)
- RNNs, LSTMs, GRUs (sequence data)
- Transformers (attention mechanism)
- Encoder-decoder, autoencoders
- GANs, diffusion (generative)

**Specializations (pick 1)**
- **Computer Vision** — torchvision, timm, YOLO, SAM
- **NLP** — Hugging Face, tokenizers, transformers
- **Time Series** — TFT, DeepAR, N-BEATS

**Techniques**
- Transfer learning + fine-tuning pretrained models
- Data augmentation
- Regularization (dropout, weight decay, early stopping)
- Mixed precision (fp16/bf16)
- Distributed training basics (DDP)

**Resources**
- Andrew Ng's *Deep Learning Specialization* (Coursera)
- Book: *Deep Learning* by Goodfellow, Bengio, Courville (reference)
- [fast.ai Practical Deep Learning](https://course.fast.ai/) (free)

**Projects**
- End-to-end computer vision project (classification or detection)
- End-to-end NLP project (sentiment, summarization, or QA)
- Transfer learning case study

**Exit criterion:** You understand transformer architecture code-level. You can fine-tune a pretrained model to a new domain.

See: [[Model Training Pipeline]]

---

## Phase 5 — Deployment + MLOps (Advanced)

**Time:** 1-2 months

**Skills**
- Model serving (FastAPI, BentoML, Triton, KServe)
- Containerization (Docker)
- Experiment tracking ([[MLflow]], W&B)
- Cloud platforms (AWS SageMaker, GCP Vertex AI, Azure ML)
- CI/CD for ML (GitHub Actions, Kubeflow)
- Model monitoring + drift detection

**Resources**
- Book: *Designing Machine Learning Systems* by Chip Huyen
- Book: *Machine Learning Design Patterns* by Lakshmanan et al.
- [Made with ML](https://madewithml.com/) — free MLOps course
- [[MLOps]] concept page

**Projects**
- Deploy a model as a REST API in Docker
- Build CI/CD pipeline with automated retraining
- Add drift monitoring to a deployed model (Evidently, WhyLabs)

**Exit criterion:** You can take a trained model from Jupyter to a monitored, versioned, auto-retrainable production service.

See: [[MLOps]], [[Model Monitoring and Drift Detection]]

---

## Phase 6 — Applied Projects (Advanced → Job-Ready)

**Time:** 2 months

**Three end-to-end capstones** — the portfolio that lands jobs. See [[AI Engineering Portfolio Projects]].

**Recommended capstones**
1. **End-to-end classical ML pipeline** — e.g., fraud detection with full MLOps stack
2. **Deep learning specialty project** — e.g., fine-tuned NLP model deployed with evals
3. **LLM fine-tuning project** — e.g., LoRA fine-tune an open-source model on domain data (bridges to AI engineering)

**Activities**
- GitHub portfolio with 3 well-documented projects
- Kaggle competitions (bronze+ medal ideal)
- Technical blog posts documenting learnings
- LeetCode medium + ML system design practice

**Exit criterion:** You have 3 deployed, documented projects with metrics. You can whiteboard an ML system for a novel problem.

---

## Phase 7 — Continuous Learning (Specialist)

**Pick 1-2 specialization tracks:**

**LLM / GenAI specialization** (highest-paying, +40-60%)
- [[LoRA and QLoRA Fine-Tuning]]
- Custom model training
- DPO / RLHF
- Book: *Build a Large Language Model from Scratch* by Sebastian Raschka

**MLOps platform specialization** (+25-40%)
- Kubernetes + Kubeflow
- Feature stores (Feast, Tecton)
- Cost optimization for inference
- On-call / incident response for ML

**Research engineering** (research labs, niche)
- Read papers (arXiv, NeurIPS, ICML)
- Reproduce paper implementations
- Push on specific problem depths

**Domain specialization** (+30-50%)
- Healthcare (medical imaging, clinical NLP)
- Finance (quant, risk, fraud)
- Robotics + autonomy
- Science (protein folding, materials)

---

## Timeline Summary

| Phase | Time | Cumulative |
|-------|------|-----------|
| 1 — Programming + Math | 2 mo | 2 mo |
| 2 — Core ML | 3 mo | 5 mo |
| 3 — Libraries + PyTorch | 2 mo | 7 mo |
| 4 — Deep Learning | 2 mo | 9 mo |
| 5 — Deployment + MLOps | 1-2 mo | 10-11 mo |
| 6 — Applied Projects | 2 mo | 12-13 mo |
| 7 — Continuous | ongoing | — |

**Job-ready: ~12 months intensive** (20+ hrs/week).

---

## Accelerated Paths by Background

**Software engineer** → fast through Phase 1 programming. Full math. **9-10 months**.

**Data analyst / scientist** → skip Phase 1. Start Phase 2. **7-9 months**.

**Software engineer wanting GenAI only** → take [[AI Engineering Learning Roadmap]] instead — faster, more production-relevant.

**Academic ML background** → skip Phases 1-4. Focus on Phase 5-6 (deployment, production). **3-4 months**.

---

## Reading Sequence

(Source: [[AI-Engineer-Reading-List-2026]])

1. *Hands-On ML* — Aurélien Géron (Phase 2-3 reference)
2. *Deep Learning with PyTorch* — Stevens et al. (Phase 3-4)
3. *Designing ML Systems* — Chip Huyen (Phase 5)
4. *Machine Learning Design Patterns* — Lakshmanan et al. (Phase 5-6)
5. *Build a Large Language Model from Scratch* — Sebastian Raschka (Phase 7 advanced)

---

## Cost of Learning

- Free tier covers most of Phases 1-4 (no GPU needed for smaller models)
- Phase 4-5: Colab Pro ($10/mo) or Kaggle GPU (free) for deep learning
- Phase 7 LoRA fine-tuning: RTX 4070 Ti (~$800) or cloud GPU ($1-2/hr)
- Books: ~$150 total
- Courses (optional): Coursera Plus ($49/mo), fast.ai free

**Typical 12-month total: $300-$1200** depending on hardware.

---

## Trioangle Application

For [[Trioangle 2.0 AI Pivot Plan]]:
- **Don't train ML engineers from scratch internally** — too slow for the pivot timeline
- For Phase 2+ of Trioangle pivot (fine-tuning services), **hire 1 experienced ML engineer** or retrain 1 senior developer who already has Phase 1-4 skills
- Use this roadmap to identify: which current devs have enough ML intuition to be candidates for upskilling?

For any Trioangle dev moving from Phase 3-4 (already has PyTorch intuition) to fine-tuning services: **3-4 months** to deliverable capability.

---

## Connections

- [[Machine Learning Engineering]] — the target discipline
- [[AI Engineering Learning Roadmap]] — the sibling path for LLM-integration engineers
- [[AI Engineering Portfolio Projects]] — what to build at each phase
- [[MLOps]] — Phase 5 focus area
- [[LoRA and QLoRA Fine-Tuning]] — Phase 7 LLM specialization
