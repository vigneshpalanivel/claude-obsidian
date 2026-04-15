---
type: concept
title: "BMad Four-Phase Workflow"
created: 2026-04-15
updated: 2026-04-15
tags:
  - bmad
  - workflow
  - context-engineering
status: current
related:
  - "[[BMAD Method]]"
  - "[[BMad Quick Dev]]"
  - "[[BMad Project Context]]"
  - "[[Agentic Engineering]]"
sources:
  - "[[BMAD-Method-Documentation]]"
---

# BMad Four-Phase Workflow

BMad's central construct: a linear sequence of four phases where each phase produces documents that become context for the next. The rationale is that AI agents work best from clear, structured upstream artifacts — not from ad hoc prompts.

## Phases

| Phase | Name | Required? | Key workflows | Output |
|-------|------|-----------|---------------|--------|
| 1 | Analysis | Optional | `bmad-brainstorming`, `bmad-market-research`, `bmad-domain-research`, `bmad-technical-research`, `bmad-product-brief`, `bmad-prfaq` | Research, brief, or PRFAQ |
| 2 | Planning | Required | `bmad-create-prd`, `bmad-create-ux-design` | `PRD.md`, `ux-spec.md` |
| 3 | Solutioning | Method/Enterprise | `bmad-create-architecture`, `bmad-create-epics-and-stories`, `bmad-check-implementation-readiness` | `architecture.md` + epic files |
| 4 | Implementation | Always | `bmad-sprint-planning`, `bmad-create-story`, `bmad-dev-story`, `bmad-code-review`, `bmad-retrospective`, `bmad-correct-course` | Code, tests, retros |

## Three Tracks Pick the Rigor Level

| Track | Use When | Phases Used |
|-------|----------|-------------|
| Quick Flow | Bug fixes, small features, clear scope (1–15 stories) | Tech-spec → implementation via [[BMad Quick Dev]] |
| BMad Method | Products/platforms (10–50+ stories) | Full 1→2→3→4 |
| Enterprise | Compliance/multi-tenant (30+ stories) | Full with Security + DevOps extensions |

Story counts are guidance, not definitions. The choice is based on planning needs — how much upstream clarity the project demands before implementation is safe.

## V6 Sequencing Change

Epics and stories are now created **after** architecture. The rationale: architecture decisions (database, API patterns, stack) directly shape how work should break down, so stories written before architecture ship with embedded wrong assumptions. This reorder is the single biggest v4→v6 flow change.

## Why Fresh Chats Per Workflow

Every phase-transition document is treated as the authoritative interface. The workflow map mandates starting a fresh chat for each workflow so that:

- Context from previous phases enters only through documents, not through chat scrollback
- Agents can't accidentally rely on informal memory that won't exist in future sessions
- Context limits don't accumulate across phases

This is a structural commitment to "documents are the context." In LLM wiki terms: the phase documents are to BMad what wiki pages are to claude-obsidian.

## Context Management

> [!key-insight]
> Each document becomes context for the next phase. Vague thinking upstream compounds into wrong technical bets downstream. Architecture built on a weak PRD makes wrong bets. Stories derived from weak architecture miss edge cases. Cost compounds. Analysis phase exists to prevent this compounding.

[[BMad Project Context]] (`project-context.md`) is the one document that is loaded across **all** implementation workflows, not just the next one. It's the project-wide constitution that survives phase transitions.

## Where It Differs From Ad Hoc AI Coding

Most AI-assisted coding is single-phase: a developer prompts an agent to write code. BMad's claim is that this works for small changes but collapses above a threshold of complexity — the agent loses the plot, and the developer can't catch it because they're reviewing code instead of decisions. The four-phase structure forces decisions to be made and documented before code is written.

This is the same philosophy that underlies [[Agentic Engineering]]: agents orchestrate upstream decisions, not just downstream typing.
