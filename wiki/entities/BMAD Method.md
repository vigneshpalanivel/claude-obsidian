---
type: entity
title: "BMAD Method"
created: 2026-04-15
updated: 2026-04-15
tags:
  - framework
  - agentic-engineering
  - ai-dev-tooling
status: current
related:
  - "[[BMad Four-Phase Workflow]]"
  - "[[BMad Quick Dev]]"
  - "[[BMad Project Context]]"
  - "[[Adversarial Review]]"
  - "[[Advanced Elicitation]]"
  - "[[Working Backwards PRFAQ]]"
  - "[[Agentic Engineering]]"
sources:
  - "[[BMAD-Method-Documentation]]"
  - "[[TEA-Documentation]]"
---

# BMAD Method

**Type**: AI-driven software development framework (installable)
**Repository**: https://github.com/bmad-code-org/BMAD-METHOD
**Docs**: https://docs.bmad-method.org
**Install**: `npx bmad-method install`
**Version (source snapshot)**: v6

## What It Is

BMad (Build More Architect Dreams) structures end-to-end software development as a sequence of guided workflows run by specialized AI agents. It treats context engineering as the primary problem: each phase produces a document that becomes load-bearing context for the next phase, so agents never make decisions from vague prompts.

The framework is tool-agnostic. It integrates with Claude Code, Cursor, Codex CLI, Windsurf, and other agent-capable tools by generating per-tool skill files at install time.

## Modules

- **Core** — universal framework, always installed
- **BMM** (`bmm`) — BMad Method (Agile suite), the default development module
- **BMB** (`bmb`) — BMad Builder, meta-module for creating custom agents/workflows/modules
- **CIS** — Creative Intelligence Suite (ideation agents)
- **GDS** — Game Dev Studio (Unity, Unreal, Godot)
- **TEA** — [[Test Architect (TEA)]] (Murat agent, 9 workflows spanning Phase 3, Phase 4, and the Release Gate). Dedicated knowledge base of 42 fragments loaded via [[TEA Knowledge Base System]]. See [[TEA-Documentation]] for the full v2026-04-13 source dump.

Community modules install via `--custom-source` from Git URLs or local paths.

## Directory Layout (after install)

```
_bmad/               agents, workflows, tasks, module configs
_bmad-output/        generated artifacts (PRD, architecture, stories, sprint-status.yaml)
_bmad/_config/agents/*.customize.yaml   # persistent per-agent customizations
.claude/skills/bmad-*/SKILL.md          # one dir per skill (Claude Code)
```

Each agent is a skill; each workflow is a skill; each task/tool is a skill. The installer regenerates all of them on every run.

## The Four Phases

1. **Analysis** (optional) — brainstorming, market/domain/technical research, product brief, PRFAQ
2. **Planning** (required) — PRD (and optionally UX spec)
3. **Solutioning** (BMad Method/Enterprise) — architecture with ADRs, then epics and stories
4. **Implementation** — sprint planning, per-story build cycle, code review, retrospective

Quick Flow is a parallel track that collapses everything into `bmad-quick-dev` for small, clear-scope changes. See [[BMad Four-Phase Workflow]].

## Signature Patterns

- **Fresh chat per workflow** — context isolation between phases is treated as a hard rule.
- **Agent personas with menu triggers** — agents stay in character; short codes (`DS`, `CP`, `QD`) switch workflows without reloading.
- **[[BMad Project Context]]** — `project-context.md` is loaded by every implementation workflow as a project "constitution."
- **[[BMad Quick Dev]]** — intent compression + frozen spec + longer autonomous runs; failure-layer diagnosis when review finds issues.
- **[[Adversarial Review]]** + edge-case hunter as orthogonal reviewers with mandatory finding floors.
- **[[Advanced Elicitation]]** — named reasoning methods applied to LLM output on demand.
- **Party Mode** — multi-agent group discussion orchestrated by BMad Master.
- **Checkpoint Preview** — LLM walks a human through a diff by concern, not file order.

## Why It Matters Here

BMad is one of the most developed public examples of a phased, context-engineered agent framework. Several of its patterns translate directly to the claude-obsidian wiki:

- Phased artifacts as durable context mirrors the wiki's source → concept → index flow.
- `project-context.md` is conceptually the same as a vault's CLAUDE.md instructions.
- Adversarial review and edge-case hunter are review patterns worth adopting for `wiki-lint`.
- Quick Dev's intent-compression-before-autonomous-run pattern maps onto `/autoresearch` loop design.

See [[BMAD-Method-Documentation]] for the full source.
