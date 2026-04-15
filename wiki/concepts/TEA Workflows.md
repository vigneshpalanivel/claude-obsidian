---
type: concept
title: "TEA Workflows"
created: 2026-04-15
updated: 2026-04-15
tags:
  - concept
  - bmad
  - tea
  - testing
  - workflow-reference
status: current
related:
  - "[[Test Architect (TEA)]]"
  - "[[Risk-Based Testing]]"
  - "[[TEA Engagement Models]]"
  - "[[TEA Knowledge Base System]]"
  - "[[TEA-Documentation]]"
sources:
  - "[[TEA-Documentation]]"
---

# TEA Workflows

TEA ships nine executable workflows. All are invoked as slash commands in Claude Code / Cursor / Windsurf (e.g. `/bmad:tea:automate`) or as `$` skills in Codex (e.g. `$bmad-tea-testarch-automate`).

## Summary Table

| Command            | Phase          | Frequency                 | Primary Output                     |
| ------------------ | -------------- | ------------------------- | ---------------------------------- |
| `teach-me-testing` | Learning       | Once per learner          | Progress + notes + certificate     |
| `framework`        | 3              | Once per project          | Test infrastructure scaffold       |
| `ci`               | 3              | Once per project          | CI/CD pipeline                     |
| `test-design`      | 3 (system), 4 (epic) | Once + per epic     | Test design documents              |
| `atdd`             | 4              | Per story (optional)      | Red-phase test scaffolds           |
| `automate`         | 4              | Per story                 | Passing test suite                 |
| `test-review`      | 4, Gate        | Per epic / pre-release    | Quality report (0-100)             |
| `nfr-assess`       | 2 (enterprise), Gate | Per release         | NFR assessment                     |
| `trace`            | 2, 4, Gate     | Baseline, refresh, gate   | Coverage matrix + gate decision    |

---

## teach-me-testing (TEA Academy)

Interactive learning companion. 7 sessions, 1-2 weeks self-paced, 30-90 min per session. State persisted in `teaching-progress/{user}-tea-progress.yaml`, resumable, role-adapted (QA / Dev / Lead / VP), quiz-validated (≥70% to pass). Completion certificate after all 7.

**Sessions**: Quick Start · Core Concepts · Architecture · Test Design · ATDD & Automate · Quality & Trace · Advanced Patterns.

Also invocable as `TMT`.

---

## framework

Scaffold production-ready Playwright or Cypress infrastructure. Runs once in Phase 3 after architecture is drafted.

**Outputs**: `tests/` directory with `support/fixtures/` + `support/helpers/`, `playwright.config.ts` or `cypress.config.ts`, `.env.example`, `.nvmrc`, sample specs.

---

## ci

Configure the CI/CD pipeline. Platform-aware (GitHub Actions is default, also supports GitLab CI, etc.). Runs once in Phase 3.

**Outputs**: platform workflow file (e.g. `.github/workflows/test.yml`), parallel execution + sharding config, burn-in loops for flakiness detection, secrets checklist.

---

## test-design

Risk-based test planning. **Dual-mode.**

**System-level (Phase 3)** — runs after architecture/ADR drafting, before the implementation-readiness gate. Produces **two** documents:

- `test-design-architecture.md` (for Architecture/Dev teams) — Quick Guide with BLOCKERS / HIGH PRIORITY / INFO ONLY, risk scoring, testability gaps, mitigation plans. Architecture teams scan blockers in <5 minutes.
- `test-design-qa.md` (for QA team) — test execution recipe, P0-P3 coverage plan with checkboxes, Sprint 0 setup, NFR readiness summary.

**Epic-level (Phase 4)** — runs per epic after sprint-planning. Produces **one** document:

- `test-design-epic-N.md` — risk assessment (probability × impact), P0-P3 priorities, coverage strategy, mitigation plans.

Optional exploratory mode uses browser automation (CLI/MCP) to discover actual UI before planning.

---

## atdd

Generate **failing** acceptance tests before implementation (TDD red phase). Per-story, optional.

**Outputs**: red-phase scaffolds in `tests/api/` and `tests/e2e/` marked with `test.skip()`, implementation checklist keyed to `story_key`, story metadata for downstream `dev-story` handoff.

Optional recording mode verifies skeleton UI selectors against live DOM.

---

## automate

Expand test coverage **after** implementation. Runs per story. The most-used TEA workflow.

**Outputs**: prioritized test suite (`tests/e2e/`, `tests/api/`), updated fixtures and README, Definition of Done summary.

Optional modes:
- **Healing** — fix broken tests using browser traces and visual debugging
- **Recording** — verify selectors against live UI and inspect network calls

`automate` is the entire TEA Lite engagement: use it alone to test an existing app.

---

## test-review

Audit existing tests. Produces `test-review.md` with a 0-100 score.

**Category weights**:

| Category        | Weight |
| --------------- | ------ |
| Determinism     | 30%    |
| Isolation       | 30%    |
| Maintainability | 25%    |
| Performance     | 15%    |

Coverage guidance is **informational only**; coverage scoring and gates are handled by `trace`.

Worker split in non-sequential modes: one worker per quality dimension.

---

## nfr-assess

Validate non-functional requirements with evidence. Enterprise track only, runs in Phase 2 (early) and/or at the Release Gate.

**Categories assessed**: Security, Performance, Reliability, Maintainability, Scalability. Each gets PASS / CONCERNS / FAIL with mitigation plans feeding the gate decision.

Worker split: one per category.

---

## trace

Requirements traceability + quality gate decision. Two-phase workflow.

**Phase 1: Traceability** — maps requirements to tests with FULL / PARTIAL / NONE classification, prioritizes gaps. Output: `traceability-matrix.md`.

**Phase 2: Gate Decision** — evidence-based PASS / CONCERNS / FAIL / WAIVED with coverage %, quality scores, NFR status. Output: `gate-decision-{gate_type}-{story_id}.md`.

**Gate rules**:

- P0 coverage: **100% required**
- P1 coverage: ≥90% PASS, 80-89% CONCERNS, <80% FAIL
- Overall coverage: ≥80% required
- Risk score 9 present without mitigation: mandatory FAIL

Brownfield projects baseline with `trace` in Phase 2 before planning.

---

## See Also

- [[Test Architect (TEA)]] — module overview and phase coverage
- [[Risk-Based Testing]] — scoring that feeds `test-design` and `trace`
- [[TEA Engagement Models]] — which workflows to run per engagement
- [[TEA-Documentation]] — source
