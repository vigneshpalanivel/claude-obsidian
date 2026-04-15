---
type: source
title: "BMAD Method Documentation (Full)"
source_type: docs
source_url: "https://docs.bmad-method.org/llms-full.txt"
fetched: 2026-04-13
ingested: 2026-04-15
confidence: high
key_claims:
  - "BMad is a 4-phase AI-driven dev framework: Analysis, Planning, Solutioning, Implementation"
  - "Three planning tracks: Quick Flow, BMad Method, Enterprise — chosen by planning need, not story count"
  - "Skills (bmad-*) are installer-generated prompt files; agents are personas with menu triggers"
  - "Quick Dev rebalances HITL cost: compress intent, freeze spec, then run longer unsupervised"
  - "project-context.md acts as a constitution loaded by every implementation workflow"
  - "Adversarial review must find issues; zero findings triggers re-analyze"
tags:
  - source
  - bmad
  - agentic-engineering
  - workflow-framework
status: current
related:
  - "[[BMAD Method]]"
  - "[[BMad Four-Phase Workflow]]"
  - "[[BMad Quick Dev]]"
  - "[[BMad Project Context]]"
  - "[[Adversarial Review]]"
  - "[[Advanced Elicitation]]"
  - "[[Working Backwards PRFAQ]]"
  - "[[Agentic Engineering]]"
  - "[[sources/_index]]"
---

# BMAD Method Documentation (Full)

**Source**: [docs.bmad-method.org/llms-full.txt](https://docs.bmad-method.org/llms-full.txt) | Generated 2026-04-13 | Repository: [bmad-code-org/BMAD-METHOD](https://github.com/bmad-code-org/BMAD-METHOD)

Full single-file snapshot of the BMad Method v6 documentation, intended for LLM consumption. Covers tutorials, how-to guides, explanations (concept deep-dives), and reference material for the framework.

---

## What BMad Is

BMad (Build More Architect Dreams) is an AI-driven development framework that structures software work across specialized agents and guided workflows. Installed via `npx bmad-method install`. Integrates with Claude Code, Cursor, Codex, and others by generating per-tool skill files.

Core structure:
- `_bmad/` — agents, workflows, tasks, config (per installed module)
- `_bmad-output/` — generated artifacts (PRD, architecture, stories, sprint status)
- `.claude/skills/` (or per-IDE equivalent) — installer-generated skill entry points

## The Four Phases

| Phase | Name | Output |
|-------|------|--------|
| 1 | Analysis (optional) | Brainstorm, research, product brief, PRFAQ |
| 2 | Planning (required) | PRD |
| 3 | Solutioning (Method/Enterprise) | Architecture, epics, stories |
| 4 | Implementation | Working code, tests, retrospectives |

See [[BMad Four-Phase Workflow]].

## Three Planning Tracks

| Track | Best For | Documents |
|-------|----------|-----------|
| **Quick Flow** | Bug fixes, clear-scope features (1–15 stories) | Tech-spec only |
| **BMad Method** | Products/platforms (10–50+ stories) | PRD + Architecture + UX |
| **Enterprise** | Compliance, multi-tenant (30+ stories) | PRD + Architecture + Security + DevOps |

Story counts are guidance — track choice is based on planning needs, not story math. V6 reordered the flow: **epics/stories are now created after architecture** because technical decisions inform how work breaks down.

## Default Agents (BMM module)

| Agent | Skill ID | Persona | Primary workflows |
|-------|----------|---------|-------------------|
| Analyst | `bmad-analyst` | Mary | Brainstorm, Market/Domain/Technical Research, Product Brief, PRFAQ, Document Project |
| Product Manager | `bmad-pm` | John | Create/Validate PRD, Epics & Stories, Implementation Readiness, Correct Course |
| Architect | `bmad-architect` | Winston | Create Architecture, Implementation Readiness |
| Developer | `bmad-agent-dev` | Amelia | Dev Story, Quick Dev, QA E2E Tests, Code Review, Sprint Planning |
| UX Designer | `bmad-ux-designer` | Sally | Create UX Design |
| Technical Writer | `bmad-tech-writer` | Paige | Document Project, Write Document, Mermaid, Explain Concept |

Agents are invoked as skills; within an agent session, **menu trigger codes** (e.g. `CP`, `DS`, `QD`) switch workflows without leaving the persona. Test Architect (TEA, "Murat") lives in its own installable module with 9 workflows for enterprise test strategy.

## Core Tools (always installed)

`bmad-help` (intelligent guide), `bmad-brainstorming`, `bmad-party-mode` (multi-agent group chat), `bmad-distillator` (lossless compression), `bmad-advanced-elicitation`, `bmad-review-adversarial-general`, `bmad-review-edge-case-hunter`, `bmad-editorial-review-prose`, `bmad-editorial-review-structure`, `bmad-shard-doc`, `bmad-index-docs`.

Review pattern is deliberately orthogonal: [[Adversarial Review]] catches quality/completeness ("must find issues"); the edge-case hunter mechanically walks branching paths and reports only unhandled cases. Run both for non-overlapping coverage.

## Key Concepts Worth Stealing

- **[[BMad Quick Dev]]** — compress intent, freeze spec, run longer unsupervised; diagnose review findings at the layer where they entered (intent vs. spec vs. local).
- **[[BMad Project Context]]** — `project-context.md` as a constitution loaded by every implementation workflow.
- **[[Adversarial Review]]** — "must find issues" review pattern that breaks confirmation bias.
- **[[Advanced Elicitation]]** — named reasoning methods (pre-mortem, inversion, first principles) applied to LLM output for a structured second pass.
- **[[Working Backwards PRFAQ]]** — Amazon PRFAQ as a gauntlet to stress-test a product concept before committing to a PRD.
- **Checkpoint Preview** — LLM walks a human through a diff by *concern*, not file order; the handoff point when Quick Dev hands back to human review.
- **Adversarial + edge-case hunter as orthogonal reviewers** — mandated finding floors break approval bias.
- **Party Mode** — multi-agent group discussion with BMad Master orchestrating turn-taking between personas.

## Installation & Customization

```bash
npx bmad-method install                # interactive
npx bmad-method@next install            # prerelease channel
npx bmad-method install --directory . --modules bmm --tools claude-code --yes  # non-interactive
```

Customization lives in per-agent `_bmad/_config/agents/<agent>.customize.yaml` files. Sections: `agent.metadata` (replaces display name), `persona` (replaces role/identity/style/principles), `memories` (appends), `menu` (appends), `critical_actions` (appends on startup), `prompts` (reusable with `action: "#id"`). The installer preserves these across updates.

Custom modules install from Git URLs or local paths via `--custom-source`. Modules with `.claude-plugin/marketplace.json` use discovery mode; otherwise the installer scans for `SKILL.md` directories.

## Deprecated / Cautions

- **`bmad-shard-doc`** is marked deprecated — modern LLMs and subprocess-capable tooling make manual sharding unnecessary.
- **v4 → v6 migration** requires manual cleanup of `.bmad-method` folder and legacy `.claude/commands/` entries; planning artifacts move to `_bmad-output/planning-artifacts/`.

---

## What This Contributes

Primary source for [[BMAD Method]] entity and the concept pages it spawns. BMad's patterns — phased context engineering, adversarial review, project-context constitutions, intent-compression before autonomous runs — are directly applicable to the claude-obsidian wiki pattern and to [[Agentic Engineering]] in general.

Connects to [[Agentic Engineering]] as a concrete implementation of the orchestration-over-code-writing philosophy, and to [[LLM Wiki Pattern]] via the shared idea that upstream artifacts (PRD, architecture, project-context) act as durable context for downstream agent work.
