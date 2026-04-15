---
type: entity
title: "Andrej Karpathy"
entity_type: person
role: "AI researcher, educator, founder"
first_mentioned: "[[LLM Wiki Pattern]]"
created: 2026-04-07
updated: 2026-04-15
tags:
  - entity
  - person
  - ai-researcher
status: mature
related:
  - "[[LLM Wiki Pattern]]"
  - "[[Compounding Knowledge]]"
  - "[[Vibe Coding]]"
  - "[[Agentic Engineering]]"
  - "[[entities/_index]]"
sources:
  - "[[Karpathy-2025-Year-in-Review]]"
---

# Andrej Karpathy

AI researcher and educator. Former Director of AI at Tesla, founding member of OpenAI. Known for deep learning education (Neural Networks: Zero to Hero series, micrograd, nanoGPT) and for publishing practical AI patterns.

---

## Key Contributions to This Wiki

Karpathy originated the [[LLM Wiki Pattern]] — the idea of using LLMs to build and maintain a persistent, compounding knowledge base rather than re-deriving knowledge from raw documents on every query.

He published the idea as an "idea file" — intentionally abstract, designed to be copy-pasted into a Claude Code or similar session and built out collaboratively. The claude-obsidian plugin is a production implementation of this pattern.

His framing: "The wiki is a persistent, compounding artifact. The cross-references are already there. The contradictions have already been flagged. The synthesis already reflects everything you've read."

---

## Notable Quote

"I thought that I had to reach for fancy RAG, but the LLM has been pretty good at auto-maintaining index files and brief summaries of all documents and reads all the important related data fairly easily at this small scale."

---

## Additional Contributions

Karpathy coined **[[Vibe Coding]]** (February 2025) — software development where developers describe programs in natural language and accept AI-generated code without deep review. Named Collins English Dictionary Word of the Year 2025.

By late 2025 he had evolved the concept to **[[Agentic Engineering]]** — "you are not writing the code directly 99% of the time, you are orchestrating agents who do." The key architectural insight: running agents locally on the developer's machine outperforms cloud-deployed agents because of immediate access to machine state, context, and secrets. This is the foundation of Claude Code's local model.

His prediction on the developer role bifurcation: LLM labs produce generally capable models; specialized applications will "organize, finetune and actually animate teams of them into deployed professionals in specific verticals." Source: [[Karpathy-2025-Year-in-Review]]

---

## Connections

- [[LLM Wiki Pattern]] — his core contribution to knowledge management
- [[Compounding Knowledge]] — the central insight he articulated
- [[Vibe Coding]] — coined February 2025; paradigm shift in developer practice
- [[Agentic Engineering]] — the mature successor he introduced in late 2025
- claude-obsidian plugin — production implementation of his wiki pattern
