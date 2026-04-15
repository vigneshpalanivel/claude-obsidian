---
type: concept
title: "Test Architect (TEA)"
created: 2026-04-15
updated: 2026-04-15
tags:
  - concept
  - bmad
  - tea
  - testing
  - agentic-engineering
status: current
related:
  - "[[BMAD Method]]"
  - "[[TEA Workflows]]"
  - "[[TEA Engagement Models]]"
  - "[[Risk-Based Testing]]"
  - "[[Fixture Architecture]]"
  - "[[Network-First Testing]]"
  - "[[TEA Knowledge Base System]]"
  - "[[TEA-Documentation]]"
  - "[[Agentic Engineering]]"
sources:
  - "[[TEA-Documentation]]"
---

# Test Architect (TEA)

The Test Architect is BMad Method's dedicated testing module. Persona: **Murat**, Master Test Architect and Quality Advisor. Its charter is risk-based test planning, fixture architecture, ATDD, CI/CD governance, and release gates.

TEA is the only BMM agent that **spans multiple phases** (Phase 3 Solutioning, Phase 4 Implementation, and the Release Gate) and the only one that ships its own knowledge base. Every other BMad agent operates within a single phase.

## When to Use TEA

Use TEA when:

- Running BMad Method or Enterprise track projects
- Integration risk is non-trivial
- Brownfield regression risk exists
- Compliance / NFR evidence is required (SOC 2, HIPAA, GDPR, etc.)

**Do not** add TEA to Quick Flow projects. The overhead outweighs the value for small, clear-scope work.

## Why TEA Exists

TEA was built to solve **AI-generated tests that rot in review**. The core problem: prompt-driven test generation is nondeterministic, which is the exact opposite of what testing protects. Without structure, AI produces a "slop factory":

| Issue                | Description                                          |
| -------------------- | ---------------------------------------------------- |
| Redundant coverage   | Multiple tests covering the same functionality       |
| Incorrect assertions | Tests that pass but don't actually verify behavior   |
| Flaky tests          | Non-deterministic, randomly pass or fail             |
| Unreviewable diffs   | Generated code too verbose or inconsistent to review |

TEA's answer is a three-part stack:

1. **Utilities**: `@seontechnologies/playwright-utils` (UI/API/network primitives) and `@seontechnologies/pactjs-utils` (contract testing primitives).
2. **Process**: 9 executable workflows covering planning, generation, review, and gates. See [[TEA Workflows]].
3. **Verification interfaces**: Playwright CLI (token-efficient, stateless) + Playwright MCP (rich, stateful) + Pact MCP (broker-aware contract automation).

This approach is called **context engineering**: load domain-specific standards into AI context automatically rather than relying on prompts alone.

## Phase Coverage

| Phase       | TEA Workflows                                                | Frequency        | Purpose                                   |
| ----------- | ------------------------------------------------------------ | ---------------- | ----------------------------------------- |
| **Phase 2** | `nfr-assess` (enterprise only)                               | Once             | Capture NFR requirements early            |
| **Phase 3** | `test-design` (system-level), `framework`, `ci`              | Once per project | Testability review + infrastructure setup |
| **Phase 4** | `test-design`, `atdd`, `automate`, `test-review`, `trace`    | Per epic/story   | Risk plans, generation, audit, coverage   |
| **Release** | `nfr-assess`, `test-review`, `trace` (Phase 2 gate decision) | Per release      | Go/no-go with evidence                    |

`test-design` is **dual-mode**: system-level (Phase 3) produces `test-design-architecture.md` + `test-design-qa.md`; epic-level (Phase 4) produces `test-design-epic-N.md`.

`trace` is **two-phase**: Phase 1 traceability matrix (FULL/PARTIAL/NONE coverage), then Phase 2 gate decision (PASS/CONCERNS/FAIL/WAIVED).

## Quality Principles (Definition of Done)

All TEA-generated tests must be:

- **Deterministic** — same result every run
- **Isolated** — no dependencies on other tests
- **Explicit** — assertions visible in the test body
- **Focused** — single responsibility, appropriate size
- **Fast** — execute in reasonable time

`test-review` scores tests 0-100 against these principles. Category weights: Determinism 30%, Isolation 30%, Maintainability 25%, Performance 15%. Coverage scoring lives in `trace`, not `test-review`.

## Execution Modes

Set via `tea_execution_mode` in `_bmad/tea/config.yaml`:

| Mode         | Behavior                                                         |
| ------------ | ---------------------------------------------------------------- |
| `auto`       | Pick best supported mode at runtime (agent-team → subagent → sequential) |
| `agent-team` | Delegation-based orchestration                                   |
| `subagent`   | Isolated worker orchestration                                    |
| `sequential` | Run steps one-by-one                                             |

With `tea_capability_probe: true`, TEA falls back gracefully. Output contracts are **identical across modes**; only orchestration style changes. Per-run verbal overrides are allowed (e.g. "use sequential").

Applies to 8 of 9 workflows. `teach-me-testing` does not support orchestration modes.

## Browser Automation

Set via `tea_browser_automation`:

| Mode   | Effect                                                                   |
| ------ | ------------------------------------------------------------------------ |
| `auto` | Pick per action — CLI for quick lookups, MCP for complex flows. **Recommended.** |
| `cli`  | Playwright CLI only (~93% fewer tokens than MCP, stateless)              |
| `mcp`  | Playwright MCP only (stateful, rich accessibility trees)                 |
| `none` | No browser interaction; generate from docs + code analysis               |

CLI is best for stateless tasks (page discovery, selector verification, screenshot capture). MCP is best for multi-step wizards, self-healing, deep DOM introspection.

## Optional Integrations

- **[Playwright Utils](https://www.npmjs.com/package/@seontechnologies/playwright-utils)** — `api-request`, `auth-session`, `network-recorder`, `intercept-network-call`, `recurse`, `log`, `file-utils`, `burn-in`, `network-error-monitor`, `fixtures-composition`. Enabled via installer or `tea_use_playwright_utils`.
- **[Pact.js Utils](https://www.npmjs.com/package/@seontechnologies/pactjs-utils)** — opt-in via `tea_use_pactjs_utils: true`. Standardizes provider state, request filtering, verifier configuration. Supports local monorepo (`pactUrls`) and remote broker (`PACT_BROKER_BASE_URL`) flows.
- **Pact MCP** (SmartBear) — optional MCP integration for broker interaction (provider state discovery, `can-i-deploy`, verification matrix). Set `tea_pact_mcp: mcp`. Complements pactjs-utils: MCP at planning/review time, pactjs-utils in runtime code.

## Relationship to Other Concepts

- **[[BMAD Method]]** — TEA is one of six BMad modules (Core, BMM, BMB, CIS, GDS, TEA). TEA inherits BMad's 4-phase methodology.
- **[[Agentic Engineering]]** — TEA is a concrete implementation of systematic agent orchestration with deterministic output contracts.
- **[[AI-Native Engineering Team]]** — TEA's existence is a direct response to the 2026 quality crisis (AI code has 1.7x more bugs).
- **[[Vibe Coding]]** — the anti-pattern TEA rejects: testing as improvisation instead of engineering.

## See Also

- [[TEA Workflows]] — 9-workflow command reference
- [[TEA Engagement Models]] — how to adopt TEA (5 models)
- [[Risk-Based Testing]] — probability × impact scoring
- [[Fixture Architecture]] — pure function → fixture → composition
- [[Network-First Testing]] — intercept-before-navigate flakiness elimination
- [[TEA Knowledge Base System]] — tea-index.csv, 42 fragments, context engineering
- [[TEA-Documentation]] — source summary
