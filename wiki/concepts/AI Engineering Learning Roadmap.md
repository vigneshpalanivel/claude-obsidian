---
type: concept
title: "AI Engineering Learning Roadmap"
created: 2026-04-23
updated: 2026-04-23
tags:
  - concept
  - ai-engineering
  - learning-roadmap
  - self-study
status: current
related:
  - "[[AI Engineering]]"
  - "[[ML Engineering Learning Roadmap]]"
  - "[[AI Engineering Portfolio Projects]]"
  - "[[AI Application Stack]]"
  - "[[Retrieval-Augmented Generation (RAG)]]"
  - "[[AI Agents]]"
  - "[[AI Evals]]"
  - "[[LLMOps and AI Observability]]"
  - "[[Trioangle 2.0 AI Pivot Plan]]"
  - "[[Research: AI ML Engineering Roadmap]]"
  - "[[concepts/_index]]"
sources:
  - "[[KDnuggets-AI-Engineer-Self-Study-Roadmap-2026]]"
  - "[[TowardsAgenticAI-Agentic-Engineering-Roadmap-2026]]"
  - "[[AI-Engineer-Reading-List-2026]]"
---

# AI Engineering Learning Roadmap

Beginner-to-advanced self-study path for [[AI Engineering]] — the discipline of integrating foundation models into production systems. Designed for software engineers moving into AI, not ML researchers. Total intensive timeline: **7-12 months to job-ready**.

---

## Orientation

Before starting, understand **what AI engineering is not**: it is not ML research, it is not training models from scratch, it is not data science. It is **software engineering for LLM-powered systems** — API integration, retrieval, agent orchestration, evaluation, and production operations. See [[AI Engineering]].

This roadmap is for people who want to **ship AI features**, not publish papers.

---

## The 7 Phases (KDnuggets 2026 framework)

(Source: [[KDnuggets-AI-Engineer-Self-Study-Roadmap-2026]])

```
Phase 1 — Programming Fundamentals          (2-3 months)
Phase 2 — Software Engineering Essentials   (1-2 months)
Phase 3 — AI + LLM Fundamentals             (1 month)
Phase 4 — Retrieval-Augmented Generation    (1-2 months)
Phase 5 — Agentic AI + Tool Use             (1-2 months)
Phase 6 — Production Systems + LLMOps       (1-2 months)
Phase 7 — Advanced + Safety                 (ongoing)
```

---

## Phase 1 — Programming Fundamentals (Beginner)

**Time:** 2-3 months

**Skills**
- Python — variables, functions, loops, data structures, OOP, file I/O
- Git + GitHub — basic workflow, branches, PRs
- Command line basics

**Resources**
- Free: [Python for Everybody (Coursera)](https://www.coursera.org/specializations/python), [CS50's Python](https://cs50.harvard.edu/python/), [Automate the Boring Stuff](https://automatetheboringstuff.com/)
- Practice: LeetCode Easy tier, HackerRank Python track

**Projects (1-2)**
- Todo CLI app
- Web scraper
- File organizer / budget tracker

**Exit criterion:** You can write a Python script that reads data, transforms it, calls an API, and writes output — without looking up basic syntax.

---

## Phase 2 — Software Engineering Essentials (Beginner → Intermediate)

**Time:** 1-2 months

**Skills**
- HTTP / REST APIs / JSON
- FastAPI (primary) or Flask
- SQL + Postgres fundamentals
- Docker + virtual environments
- Pytest + TDD basics

**Resources**
- Free: [FastAPI Tutorial](https://fastapi.tiangolo.com/tutorial/), [Full Stack Open](https://fullstackopen.com/en/), [Docker Curriculum](https://docker-curriculum.com/)

**Projects (1-2)**
- REST API with CRUD + auth
- Containerized weather dashboard
- URL shortener with persistence

**Exit criterion:** You can design + ship a backend API that runs in Docker, uses Postgres, and has basic tests.

---

## Phase 3 — AI + LLM Fundamentals (Intermediate)

**Time:** 1 month

**Skills**
- How LLMs work conceptually (transformers, tokens, context windows — intuition, not math)
- Prompt engineering (zero-shot, few-shot, CoT, system prompts)
- LLM APIs (Anthropic Claude, OpenAI, Gemini)
- Sampling parameters (temperature, top-p)
- Structured outputs / function calling

**Resources**
- Free: [Anthropic Prompt Engineering Guide](https://docs.anthropic.com/claude/docs/prompt-engineering), [OpenAI Cookbook](https://cookbook.openai.com/), [DeepLearning.AI short courses](https://learn.deeplearning.ai/)
- Book: *Prompt Engineering for LLMs* by Berryman & Ziegler
- Book (start here): *AI Engineering* by Chip Huyen

**Projects (2-3)**
- Chatbot with conversation memory
- Text summarizer
- Code documentation generator
- Email classifier with function calling

**Exit criterion:** You can call an LLM API with a well-designed system prompt, parse structured outputs, and handle streaming.

---

## Phase 4 — Retrieval-Augmented Generation (Intermediate)

**Time:** 1-2 months

**Skills**
- Embeddings + semantic search (intuition)
- Vector databases (Chroma for learning, pgvector for production)
- Document chunking (fixed, sentence, semantic, hierarchical)
- Retrieval strategies (dense, sparse/BM25, hybrid)
- Reranking with cross-encoders
- RAG evaluation (RAGAS)

**Resources**
- Free: LangChain RAG tutorials, [DeepLearning.AI RAG courses](https://www.deeplearning.ai/courses/)
- Book: *Hands-On Large Language Models* by Alammar & Grootendorst
- Framework: [[LlamaIndex]] for depth; [[LangChain]] for breadth

**Projects (2-3)**
- Personal document Q&A chatbot
- PDF research assistant
- Company knowledge base assistant with citations

**Exit criterion:** You can build a RAG pipeline that ingests documents, stores embeddings, retrieves relevant chunks, and generates cited answers. You can measure its quality using RAGAS.

See: [[Retrieval-Augmented Generation (RAG)]]

---

## Phase 5 — Agentic AI + Tool Use (Intermediate → Advanced)

**Time:** 1-2 months

**Skills**
- Function calling / tool use
- Agent loop patterns: ReAct, Plan-and-Execute, Reflection
- Memory systems (short-term conversation, long-term vector)
- Error handling + retry logic
- Multi-agent coordination
- Model Context Protocol (MCP)

**Framework progression** (Source: [[TowardsAgenticAI-Agentic-Engineering-Roadmap-2026]])
- Week 1-2: **CrewAI** (beginner-friendly, role-based)
- Week 3-5: **LangGraph** (industry standard, stateful)
- Week 6+: **AutoGen** or **OpenAI Agents SDK** (enterprise/HIL)

**Resources**
- [Anthropic Agents Cookbook](https://github.com/anthropics/courses)
- [LangGraph tutorials](https://langchain-ai.github.io/langgraph/)
- Book: *Building Agentic AI Systems* by Biswas & Talukdar

**Projects (2-3)**
- Research agent (web search + summarize + file)
- Data analysis agent (query DB + generate report)
- Customer support agent with tool integrations
- Multi-agent team (writer + critic + fact-checker)

**Exit criterion:** You can design + ship an agent that uses 3+ tools, handles errors, and stays within a budget of tokens/time/steps.

See: [[AI Agents]]

---

## Phase 6 — Production Systems + LLMOps (Advanced)

**Time:** 1-2 months

**Skills**
- Prompt versioning (prompts-as-code)
- Observability + tracing (LangSmith, Langfuse, Helicone)
- Eval frameworks + A/B testing
- Rate limiting, caching, cost controls
- Multi-provider routing + fallbacks
- Cloud deployment (Vercel, Railway, Modal)

**Resources**
- Book: *Designing ML Systems* by Chip Huyen
- Book: *Building LLMs for Production* by Bouchard & Peters
- Platforms: LangSmith free tier, Langfuse (self-hostable)

**Projects (2-3)**
- Add full observability to an existing RAG/agent project
- Build an eval suite with 50+ test cases
- Implement prompt version management with A/B testing
- Deploy a monitored LLM app to cloud with cost tracking

**Exit criterion:** You can ship an AI feature that is **observable, evaluable, cost-controlled, and recoverable from drift**. See [[LLMOps and AI Observability]] and [[AI Evals]].

---

## Phase 7 — Advanced + Safety (Ongoing)

**Focus areas**
- AI safety + alignment basics
- Prompt injection defense (Lakera, Rebuff)
- Jailbreak mitigation
- PII detection + redaction
- Bias + harmful output detection

**Specialization tracks** (pick 1-2)
- Agentic coding (Claude Code, Cursor extensions)
- Voice AI (Vapi, Retell, custom pipelines)
- Fine-tuning specialist (bridges to ML engineering — see [[LoRA and QLoRA Fine-Tuning]])
- Enterprise architecture (on-prem, compliance, governance)
- AI safety + evaluation research

---

## Portfolio Requirements

**Three well-deployed, well-documented projects with real metrics** outperform fifteen notebooks. See [[AI Engineering Portfolio Projects]].

Minimum portfolio for job-ready:
1. A RAG application (Phase 4)
2. An agent system (Phase 5)
3. A production-grade LLM app with observability (Phase 6)

Each should be deployed + have a README with: problem, architecture decision, tradeoffs, metrics.

---

## Accelerated Paths by Background

**Experienced software engineer** → skip Phases 1-2. Start at Phase 3. Job-ready in **4-6 months**.

**Frontend developer** → skip Phase 1. Fast through Phase 2 (backend). Start AI at Phase 3. **5-7 months**.

**Data analyst** → fast through Phases 1-2 (Python likely done). Emphasis on Phase 2 backend. **6-8 months**.

**ML engineer transitioning** → skip Phases 1-3 (already have fundamentals). Focus on Phases 4-7. **3-4 months**.

**Total novice** → follow full roadmap. **9-12 months** intensive.

---

## Cost of Learning

- Free tier: OpenAI ($5 credit), Anthropic ($5 credit), LangSmith free, GitHub Copilot Students
- Cursor Pro ($20/mo) or Claude Code subscription — recommended
- Paid courses (optional): DeepLearning.AI Plus ($49/mo), Educative, Udemy occasional ($15-20)
- Books (optional): Chip Huyen's *AI Engineering* + 1-2 others (~$100 total)

Typical 12-month total: **$400-$800** if you want the premium tier; **under $100** if everything free.

---

## Trioangle Application

For the [[Trioangle 2.0 AI Pivot Plan]], this roadmap maps to the capability-building phases:

- Phase 0 champions → start at Phase 3 (they already have Phase 1-2 skills)
- Weeks 1-4 of Trioangle Phase 0 → matches roadmap Phase 3 + start of Phase 4
- Weeks 5-12 → Phase 4 RAG + Phase 5 agents
- Phase 1 of Trioangle plan → complete Phase 6 production skills
- Phase 2 of Trioangle → Phase 7 specialization (fine-tuning, voice, etc.)

**Expected timeline for existing Trioangle engineer to reach production-AI-capable: 2-3 months** starting from Phase 3.

---

## Connections

- [[AI Engineering]] — the target discipline
- [[ML Engineering Learning Roadmap]] — the sibling path for model-training-focused engineers
- [[AI Engineering Portfolio Projects]] — what to build for each phase
- [[Research: AI ML Engineering Roadmap]] — full synthesis
