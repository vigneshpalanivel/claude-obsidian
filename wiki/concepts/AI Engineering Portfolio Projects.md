---
type: concept
title: "AI Engineering Portfolio Projects"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ai-engineering
  - ml-engineering
  - learning-roadmap
  - portfolio
status: current
related:
  - "[[AI Engineering Learning Roadmap]]"
  - "[[ML Engineering Learning Roadmap]]"
  - "[[AI Engineering]]"
  - "[[Machine Learning Engineering]]"
  - "[[Research: AI ML Engineering Roadmap]]"
  - "[[concepts/_index]]"
---

# AI Engineering Portfolio Projects

Reference list of portfolio projects mapped to skill level. Hiring managers and clients trust **three well-deployed projects with real metrics** more than fifteen notebooks. Every project here includes: problem framing, deployment requirement, measurable outcome, and the specific skill it demonstrates.

---

## Portfolio Rules

1. **Deploy everything.** A Colab link is not a portfolio piece. Ship to Vercel / Railway / HF Spaces / a real URL.
2. **README > code.** Each project needs problem, architecture decision, tradeoffs considered, metric achieved, cost, and what you'd do differently.
3. **Metrics are mandatory.** "I built X" is weak. "I built X; it retrieves 5 docs in 180ms p95; RAGAS faithfulness 0.87" is strong.
4. **Three is the magic number.** Three projects at different skill levels outperform one massive project or a scatter of small ones.
5. **Don't fake production readiness.** Include logging, evals, error handling. A demo that crashes on edge cases tells the hiring manager everything.

---

## Beginner Tier (Phases 1-3)

### 1. Chatbot with Memory
**Skills**: LLM APIs, prompt engineering, state management  
**Stack**: Next.js + Vercel AI SDK + Claude/OpenAI  
**Metrics**: Response time P95, cost per conversation  
**Deployment**: Vercel  
**Variant**: Personal assistant for your own use (actually use it)

### 2. Text Summarization Service
**Skills**: Structured output, system prompt design, API + frontend  
**Stack**: FastAPI + LLM API + simple UI  
**Metrics**: Summary quality (human eval), tokens used, latency  
**Deployment**: Railway / Render

### 3. Code Documentation Generator
**Skills**: Parsing, batched LLM calls, file I/O  
**Stack**: Python CLI + OpenAI/Claude  
**Metrics**: Correctness on real codebases, cost per 1000 LOC  
**Deployment**: CLI tool + pip install

---

## Intermediate Tier (Phase 4 — RAG)

### 4. Personal Document Q&A
**Skills**: Chunking, embeddings, vector search, citation  
**Stack**: [[LlamaIndex]] + pgvector + Next.js  
**Metrics**: Retrieval accuracy, RAGAS faithfulness, latency  
**Deployment**: Vercel + Supabase  
**What to show off**: Evidence the answers are grounded — clickable citations to source chunks

### 5. PDF Research Assistant
**Skills**: Complex PDF parsing, multi-document retrieval, reranking  
**Stack**: LlamaParse + LlamaIndex + cross-encoder reranker  
**Metrics**: Retrieval@5, time to answer, handles tables/figures  
**Deployment**: HF Spaces or Streamlit Cloud

### 6. Company Knowledge Base (multi-tenant)
**Skills**: Auth, tenant isolation, ingestion pipeline, usage analytics  
**Stack**: FastAPI + Postgres (pgvector + tenant_id) + React  
**Metrics**: Ingest throughput, query latency, per-tenant cost  
**Deployment**: Railway / Fly.io  
**What to show off**: Actual multi-tenant isolation, not a toy

---

## Intermediate → Advanced (Phase 5 — Agents)

### 7. Research Agent
**Skills**: Tool use, multi-step planning, memory  
**Stack**: LangGraph + WebSearch + Fetch + Write  
**Metrics**: Task completion rate, time to answer, cost per query  
**Deployment**: Streamlit Cloud  
**What to show off**: Full trajectory visualization (show the agent's thinking)

### 8. Data Analysis Agent (Text-to-SQL)
**Skills**: Safe SQL execution, schema introspection, visualization  
**Stack**: LangGraph + DuckDB + Plotly  
**Metrics**: Query correctness, time saved vs manual  
**Deployment**: HF Spaces  
**Safety**: Read-only queries only, schema-aware prompting

### 9. Multi-Agent Writing Team
**Skills**: Agent coordination, role design, reviewer patterns  
**Stack**: CrewAI or LangGraph with 3 agents (writer, critic, fact-checker)  
**Metrics**: Output quality vs single-agent, cost tradeoff  
**Deployment**: CLI + deployed web UI

---

## Advanced Tier (Phase 6 — Production)

### 10. Production RAG with Full LLMOps
Take project #4, #5, or #6 and add:
- [[LLMOps and AI Observability]] — LangSmith or Langfuse tracing on every call
- [[AI Evals]] — 50+ test eval suite with RAGAS + LLM-judge
- Prompt versioning with Git
- Cost dashboard
- Drift detection on retrieval quality
- Fallback model routing

**What to show off**: Screenshot of the eval suite running in CI, blocking bad prompts from shipping.

### 11. Voice AI Agent
**Skills**: Real-time audio pipeline, low-latency, interruption handling  
**Stack**: Vapi or Retell + custom logic  
**Metrics**: Time to first audio, interruption handling, task success  
**Deployment**: Phone number clients can actually call  
**Use case**: Appointment booking, customer service triage

### 12. Agentic Coding Assistant
**Skills**: File-system tool use, test-driven loops, error recovery  
**Stack**: Custom agent on top of Anthropic/OpenAI + sandboxed exec  
**Metrics**: Task success rate on benchmark (e.g., SWE-bench Lite)  
**Deployment**: CLI or VS Code extension  
**Note**: Hard — compete seriously only if targeting a coding-tools role

---

## ML Engineering Tier (Phase 4-5 of [[ML Engineering Learning Roadmap]])

### 13. End-to-End Classical ML Pipeline
**Skills**: Data pipeline, feature engineering, training, deployment  
**Stack**: Scikit-learn + MLflow + FastAPI + Docker  
**Use cases**: Fraud detection, churn prediction, price forecasting  
**Metrics**: AUC, latency, MLflow-tracked experiment count  
**Deployment**: Docker image on cloud VM or Kubernetes  
**What to show off**: CI pipeline that retrains and deploys automatically

### 14. Computer Vision Deployment
**Skills**: Deep learning training, transfer learning, efficient serving  
**Stack**: PyTorch + timm + TorchServe or Triton  
**Use cases**: Image classification on custom domain  
**Metrics**: Top-5 accuracy, inference latency, throughput  
**Deployment**: GPU-backed endpoint or edge deployment (ONNX)

### 15. LLM Fine-Tune with LoRA
**Skills**: [[LoRA and QLoRA Fine-Tuning]], evaluation, deployment  
**Stack**: Unsloth or Axolotl + HF Hub + vLLM  
**Use cases**: Domain-specific style (legal, medical, brand voice)  
**Metrics**: Perplexity, MMLU delta, task-specific metric  
**Deployment**: Model card on HF Hub + demo on HF Spaces  
**What to show off**: Before/after examples demonstrating the specialization

---

## The Three-Project Portfolio

For each career target, **pick three** at the recommended levels:

### For AI Engineer role
1. Advanced RAG with LLMOps (#10)
2. Research or Data Analysis Agent (#7 or #8)
3. Production-deployed LLM app with evals (any of #4-9 at production quality)

### For ML Engineer role
1. End-to-end classical ML pipeline (#13)
2. Deep learning specialty project (#14)
3. LLM fine-tune (#15) — **this single project commands +40-60% pay**

### For Agentic AI Engineer (advanced specialist)
1. Multi-agent writing team (#9)
2. Voice AI agent (#11)
3. Agentic coding assistant or similar tool-heavy agent (#12)

---

## What Makes a Project Stand Out

- **Real usage** — someone other than you actually uses it (friends, a community, a live demo)
- **Honest metrics** — include failures and what broke, not just successes
- **Deploy + monitor** — dashboards showing it runs in the wild
- **Blog post** — writeup of the build, design decisions, what you learned
- **Open source** — clean repo with issues, PRs, roadmap

---

## Anti-Patterns

- 💀 Jupyter-only, not deployed
- 💀 "I trained MNIST" (that's a tutorial, not a project)
- 💀 Flashy name + no metrics
- 💀 Fifteen half-finished projects
- 💀 "AI-powered" X without any AI engineering (just OpenAI API call)
- 💀 No README
- 💀 Demos that crash on any input out of distribution

---

## Connections

- [[AI Engineering Learning Roadmap]] — phases these projects map to
- [[ML Engineering Learning Roadmap]] — ML track projects
- [[AI Engineering]] — target discipline
- [[Machine Learning Engineering]] — sibling discipline
