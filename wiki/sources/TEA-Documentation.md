---
type: source
title: "Test Architect (TEA) Documentation (Full)"
source_type: docs
source_url: "https://bmad-code-org.github.io/bmad-method-test-architecture-enterprise/llms-full.txt"
fetched: 2026-04-13
ingested: 2026-04-15
confidence: high
key_claims:
  - "TEA is a BMad Method module (Murat persona) providing 9 executable workflows for test strategy, automation, and release gates"
  - "TEA spans Phase 3 (Solutioning), Phase 4 (Implementation), and the Release Gate. Most BMad agents operate in one phase."
  - "Five engagement models: No TEA, TEA Solo, TEA Lite, Integrated Greenfield (BMad or Enterprise), Integrated Brownfield. TEA is never mandatory."
  - "Risk-Based Testing core formula: Probability (1-3) × Impact (1-3) = Risk Score 1-9. Score 9 mandatory FAIL. Score 6-8 requires mitigation. Risk categories: TECH, SEC, PERF, DATA, BUS, OPS."
  - "Test priorities P0-P3 derived from risk score plus business context. P0 = 100% coverage, P1 = 90%, P2 = 50%, P3 = 20% smoke."
  - "Three-part stack solves AI-generated test slop: (1) Playwright-Utils + Pact.js Utils primitives, (2) TEA workflows as quality operating model, (3) Playwright CLI + MCP + Pact MCP verification."
  - "Nine workflows: teach-me-testing, framework, ci, test-design, atdd, automate, test-review, nfr-assess, trace."
  - "test-design is dual-mode: system-level (Phase 3, produces test-design-architecture.md + test-design-qa.md) and epic-level (Phase 4, produces test-design-epic-N.md)."
  - "trace is two-phase: Phase 1 traceability (FULL/PARTIAL/NONE coverage matrix) then Phase 2 gate decision (PASS/CONCERNS/FAIL/WAIVED)."
  - "Gate rules: P0 coverage 100% required, P1 ≥90% for PASS / 80-89% CONCERNS / <80% FAIL, overall ≥80%."
  - "Fixture Architecture pattern: pure function first, then framework fixture wrapper, then mergeTests composition. Pure functions are unit-testable and framework-agnostic."
  - "Network-First Pattern: intercept-before-navigate. Set up waitForResponse promise BEFORE goto/click, then await. Eliminates hard-wait flakiness and race conditions."
  - "Quality standards (Definition of Done): deterministic, isolated, explicit, focused, fast. test-review scores on Determinism 30%, Isolation 30%, Maintainability 25%, Performance 15%."
  - "Knowledge base: 42 markdown fragments indexed in tea-index.csv. Each workflow loads only the fragments it needs (context engineering, not prompt engineering)."
  - "Browser automation via tea_browser_automation: auto | cli | mcp | none. CLI is ~93% cheaper in tokens than MCP and stateless; MCP is stateful and richer."
  - "Execution modes via tea_execution_mode: auto | agent-team | subagent | sequential. Verbal override allowed per-run. Output contracts identical across modes."
  - "Optional integrations: @seontechnologies/playwright-utils (9 utilities), @seontechnologies/pactjs-utils (contract testing), Pact MCP (SmartBear broker integration)."
  - "Quick Flow track typically does NOT require TEA. TEA value appears in BMad Method and Enterprise tracks."
  - "Enterprise track adds nfr-assess in Phase 2 and archive artifacts at the release gate for audit trails (SOC 2, HIPAA, GDPR)."
  - "Brownfield delta: baseline trace in Phase 2 before planning; test-design focuses on regression hotspots and integration risk."
  - "TEA Academy (teach-me-testing command): 7 self-paced sessions, 1-2 weeks, role-adapted (QA/Dev/Lead/VP), state-persisted, quiz-gated."
created: 2026-04-15
updated: 2026-04-15
tags:
  - source
  - bmad
  - tea
  - testing
  - qa
  - risk-based-testing
  - agentic-engineering
status: current
related:
  - "[[Test Architect (TEA)]]"
  - "[[TEA Workflows]]"
  - "[[Risk-Based Testing]]"
  - "[[Fixture Architecture]]"
  - "[[Network-First Testing]]"
  - "[[TEA Engagement Models]]"
  - "[[TEA Knowledge Base System]]"
  - "[[BMAD Method]]"
  - "[[BMAD-Method-Documentation]]"
  - "[[sources/_index]]"
---

# Test Architect (TEA) Documentation (Full)

**Source**: [bmad-method-test-architecture-enterprise/llms-full.txt](https://bmad-code-org.github.io/bmad-method-test-architecture-enterprise/llms-full.txt) | Generated 2026-04-13 | Repository: [bmad-code-org/bmad-method-test-architecture-enterprise](https://github.com/bmad-code-org/bmad-method-test-architecture-enterprise)

Full single-file snapshot (16.5k lines) of the Test Architect documentation. TEA is BMad's dedicated testing module. It is the only BMM agent that spans multiple phases and carries its own knowledge base.

---

## Structure

The dump follows a Diátaxis layout:

- **Tutorials** — `tea-lite-quickstart`, `learn-testing-tea-academy`
- **How-to** — one guide per workflow (`run-atdd`, `run-automate`, `run-test-design`, `run-test-review`, `run-nfr-assess`, `run-trace`, `setup-test-framework`, `setup-ci`, `teach-me-testing`) plus brownfield + enterprise guides and customization guides (`configure-browser-automation`, `integrate-playwright-utils`, `extend-tea-with-custom-workflows`)
- **Explanation** — `tea-overview`, `engagement-models`, `testing-as-engineering`, `risk-based-testing`, `test-quality-standards`, `fixture-architecture`, `network-first-patterns`, `knowledge-base-system`, `subagent-architecture`, `step-file-architecture`
- **Reference** — `commands`, `configuration`, `knowledge-base`, `troubleshooting`, `glossary`

---

## Why TEA Exists

TEA was built to solve **AI-generated tests that rot in review**. Without structure, prompt-driven testing amplifies the chaos it is meant to prevent: redundant coverage, incorrect assertions, flaky tests, unreviewable diffs. TEA responds with a three-part stack:

1. **Utilities** (`@seontechnologies/playwright-utils`, `@seontechnologies/pactjs-utils`) that standardize testing primitives so agents stop reinventing them.
2. **Process** (TEA workflows) as a quality operating model with risk planning, generation, review, and release gates.
3. **Verification interfaces** (Playwright CLI, Playwright MCP, Pact MCP) so agents confirm tests against real systems instead of inferring from docs.

See [[Test Architect (TEA)]] for the module map and [[Risk-Based Testing]], [[Fixture Architecture]], [[Network-First Testing]], [[TEA Knowledge Base System]] for the pattern deep-dives.

---

## Pages Generated From This Source

- [[Test Architect (TEA)]] (module overview, Murat persona, phase coverage, optional integrations)
- [[TEA Workflows]] (9-workflow command reference)
- [[TEA Engagement Models]] (No TEA / Solo / Lite / Integrated Greenfield / Integrated Brownfield)
- [[Risk-Based Testing]] (probability × impact, categories, P0-P3, mitigation gates)
- [[Fixture Architecture]] (pure function → fixture → composition)
- [[Network-First Testing]] (intercept-before-navigate, flakiness elimination)
- [[TEA Knowledge Base System]] (tea-index.csv, 42 fragments, context engineering)
- [[BMAD Method]] (entity updated with TEA module reference)

---

## Cross-References

- **Parent framework**: [[BMAD Method]] v6 module ecosystem. TEA is one of six modules (Core, BMM, BMB, CIS, GDS, TEA).
- **BMad source snapshot**: [[BMAD-Method-Documentation]] ingested 2026-04-15, which mentions TEA but does not detail its workflows. This source fills that gap.
- **Related concepts already in wiki**: [[Agentic Engineering]] (TEA is an exemplar of systematic agent orchestration), [[AI-Native Engineering Team]] (TEA's philosophy that AI code has 1.7x more bugs maps to the 2026 quality crisis already tracked).
