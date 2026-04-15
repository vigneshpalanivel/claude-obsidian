---
type: concept
title: "BMad Project Context"
created: 2026-04-15
updated: 2026-04-15
tags:
  - bmad
  - context-engineering
  - conventions
status: current
related:
  - "[[BMAD Method]]"
  - "[[BMad Four-Phase Workflow]]"
sources:
  - "[[BMAD-Method-Documentation]]"
---

# BMad Project Context

`project-context.md` is BMad's "constitution" for a project — a concise, LLM-optimized file that documents the rules, patterns, and preferences every implementation workflow must follow. It solves the multi-agent consistency problem: without it, different agents implementing different stories make independent technical decisions that conflict.

## Location and Loading

- Default path: `_bmad-output/project-context.md`
- Fallback: any `**/project-context.md` in the project tree
- Loaded automatically by: `bmad-create-architecture`, `bmad-create-story`, `bmad-dev-story`, `bmad-code-review`, `bmad-quick-dev`, `bmad-sprint-planning`, `bmad-retrospective`, `bmad-correct-course`

It's the one document that crosses phase boundaries. Everything else in BMad is phase-local; this is project-wide.

## Two Required Sections

### 1. Technology Stack & Versions

Specific frameworks, languages, tools, and versions:

```markdown
- Node.js 20.x, TypeScript 5.3, React 18.2
- State: Zustand (not Redux)
- Testing: Vitest, Playwright, MSW
- Styling: Tailwind CSS with custom design tokens
```

### 2. Critical Implementation Rules

Patterns agents might otherwise miss. The guidance is emphatic: **focus on the unobvious**. Don't document universal best practices ("use meaningful names"). Document project-specific conventions agents wouldn't infer from reading code snippets:

```markdown
**Code Organization:**
- Components in `/src/components/` with co-located `.test.tsx`
- API calls use the `apiClient` singleton — never fetch directly

**Framework-Specific:**
- All async operations use the `handleError` wrapper
- Feature flags accessed via `featureFlag()` from `@/lib/flags`
```

## Three Creation Paths

1. **Manual, before architecture** — best when you have strong technical preferences that should constrain the architect
2. **Generate after architecture** — `bmad-generate-project-context` scans architecture + project files to capture decisions that were made
3. **Generate for existing projects** — `bmad-generate-project-context` scans the codebase to discover existing conventions

## Why "Keep It Lean" Is Enforced

Project context is loaded by every implementation workflow. Long files waste context window tokens on every single story implementation. The documentation is explicit: **exclude content that only applies to narrow scope or specific stories**. It's a global rule set, not a design document.

## Parallel to claude-obsidian

`project-context.md` is conceptually the same as a vault's `CLAUDE.md` instructions file: a lean, always-loaded context pointer that sets global conventions. The difference is scope — BMad loads it in every workflow explicitly; claude-obsidian relies on Claude Code's built-in CLAUDE.md auto-loading.

The lessons transfer:
- Keep it short (loaded on every turn)
- Focus on the unobvious (don't waste tokens on universal practices)
- Update it when patterns change (living document, not one-time setup)
