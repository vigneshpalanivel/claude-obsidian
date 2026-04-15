---
type: concept
title: "TEA Engagement Models"
created: 2026-04-16
updated: 2026-04-16
tags:
  - concept
  - bmad
  - tea
  - adoption
status: current
related:
  - "[[Test Architect (TEA)]]"
  - "[[TEA Workflows]]"
  - "[[BMAD Method]]"
  - "[[TEA-Documentation]]"
sources:
  - "[[TEA-Documentation]]"
---

# TEA Engagement Models

TEA is **not mandatory**. BMad Method offers five valid ways to engage with TEA. Pick one intentionally based on project context, team maturity, and compliance needs.

## The Five Models

| #   | Model                               | Best For                                          |
| --- | ----------------------------------- | ------------------------------------------------- |
| 1   | **No TEA**                          | Mature QA teams with established practices       |
| 2   | **TEA Solo** (Standalone)           | Non-BMad projects that want TEA's quality model  |
| 3   | **TEA Lite**                        | Learning TEA, testing an existing app fast       |
| 4   | **Integrated (Greenfield)**         | New BMad Method or Enterprise projects           |
| 5   | **Integrated (Brownfield)**         | Existing codebases with regression risk          |

## Model 1: No TEA

Skip everything. Use your existing testing approach. Valid choice when the team already has high-quality tests and established practices. You keep full control; you miss risk-based planning, systematic review, gate decisions, and the knowledge base.

## Model 2: TEA Solo

Use TEA on a non-BMad project. Bring your own requirements and environments. Typical sequence:

```
1. test-design  (system or epic level)
2. atdd  OR  automate
3. test-review  (optional)
4. trace  (coverage + gate decision)
```

Run `framework` or `ci` only if you want TEA to scaffold the harness or pipeline.

Best for teams wanting TEA benefits without committing to the full BMad Method lifecycle.

## Model 3: TEA Lite

The simplest entry point. Use just `automate` to generate tests for existing features.

```
1. framework     (optional, scaffold infra)
2. test-design   (optional, risk assessment)
3. automate      (generate tests for existing features)
4. Run tests     (they pass immediately)
```

30-minute beginner path. Teaches TEA fundamentals via the TodoMVC demo in the [TEA Lite Quickstart Tutorial](https://bmad-code-org.github.io/bmad-method-test-architecture-enterprise/tutorials/tea-lite-quickstart).

## Model 4: Integrated (Greenfield)

Full BMad Method (Simple/Standard) or Enterprise (Compliance) integration for new projects.

**Greenfield BMad Method**:

| Phase | TEA Actions                                                                |
| ----- | -------------------------------------------------------------------------- |
| 3     | `test-design` (system), `framework`, `ci`                                  |
| 4     | Per-epic `test-design`, optional `atdd`, `automate`, optional `test-review` |
| Gate  | `trace` (Phase 2 decision)                                                 |

**Greenfield Enterprise** adds:

- Phase 2: `nfr-assess` early (capture NFR requirements at planning time)
- Phase 4: `test-design` emphasizes compliance, security, performance
- Release Gate: archive artifacts + compliance evidence for audits (SOC 2, HIPAA, GDPR)

## Model 5: Integrated (Brownfield)

Existing codebase, regression risk is the dominant concern. Deltas from greenfield:

- **Documentation prerequisite**: run `document-project` if the codebase is undocumented
- **Phase 2**: baseline `trace` before planning (know what you already cover)
- **Phase 4 `test-design`**: focus on regression hotspots and integration risk
- **Phase 4 Story Review**: may add `nfr-assess` if not done earlier

Brownfield Enterprise combines both sets of deltas.

## Decision Guide

```
New project + standard complexity     → Integrated Greenfield (BMad Method)
New project + compliance required      → Integrated Greenfield (Enterprise)
Existing codebase                       → Integrated Brownfield
Non-BMad project, want quality model    → TEA Solo
Learning TEA, 30 min available          → TEA Lite
Mature QA team, no gaps                 → No TEA
```

**When in doubt**: default to the integrated path for your track. Adjust later.

**Quick Flow projects typically do NOT require TEA**. Overhead outweighs value for small clear-scope work.

## See Also

- [[Test Architect (TEA)]]
- [[TEA Workflows]] — workflow-by-workflow reference
- [[BMAD Method]] — parent framework and phase model
- [[TEA-Documentation]] — source
