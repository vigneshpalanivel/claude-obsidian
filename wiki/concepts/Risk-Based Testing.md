---
type: concept
title: "Risk-Based Testing"
created: 2026-04-15
updated: 2026-04-15
tags:
  - concept
  - testing
  - tea
  - risk
status: current
related:
  - "[[Test Architect (TEA)]]"
  - "[[TEA Workflows]]"
  - "[[TEA-Documentation]]"
sources:
  - "[[TEA-Documentation]]"
---

# Risk-Based Testing

TEA's core principle: **testing depth scales with business impact**. Instead of treating all features equally, measure risk and match test effort to it.

## The Formula

```
Risk Score = Probability × Impact
```

**Probability** (likelihood of failure):

- **1 (Low)** — stable, well-tested, simple logic
- **2 (Medium)** — moderate complexity, some unknowns
- **3 (High)** — complex, untested, many edge cases

**Impact** (severity if it fails):

- **1 (Low)** — minor inconvenience, few users affected
- **2 (Medium)** — degraded experience, workarounds exist
- **3 (High)** — critical path broken, business impact

**Score range**: 1-9.

| Score | Band          | Treatment                               |
| ----- | ------------- | --------------------------------------- |
| 9     | CRITICAL      | Blocks release without mitigation       |
| 6-8   | HIGH          | Mitigation plan required (CONCERNS if missing) |
| 4-5   | MEDIUM        | Mitigation recommended, not required    |
| 1-3   | LOW           | No mitigation needed                    |

## Risk Categories

TEA assesses risk across **six** categories. Score each separately.

| Code   | Meaning               | Example                                              |
| ------ | --------------------- | ---------------------------------------------------- |
| TECH   | Technical debt, architecture fragility | REST → GraphQL migration (3×3 = 9)   |
| SEC    | Security vulnerabilities | Adding OAuth (2×3 = 6)                             |
| PERF   | Performance degradation | Real-time notifications via WebSocket (2×2 = 4)    |
| DATA   | Data integrity, corruption | Database migration (2×3 = 6)                    |
| BUS    | Business logic errors  | Discount calculation (2×3 = 6)                      |
| OPS    | Operational issues     | Logging system update (1×2 = 2)                     |

## Test Priorities (P0-P3)

Risk scores feed priority classification (but business context matters too: revenue, usage, compliance).

| Priority | Typical Risk Scores | Other Triggers                      | Coverage Target | Test Levels           |
| -------- | ------------------- | ----------------------------------- | --------------- | --------------------- |
| **P0**   | 6-9                 | Revenue, security, regulatory       | **100%**        | E2E + API             |
| **P1**   | 4-6                 | Core user journeys, integrations    | **90%**         | API + selective E2E   |
| **P2**   | 2-4                 | Secondary, admin, reporting         | **50%**         | API happy path only   |
| **P3**   | 1-2                 | Rarely used, cosmetic               | **20%**         | E2E smoke test only   |

**Example priority → feature mapping**:

- P0: login, checkout, payment processing
- P1: profile editing, search, filters
- P2: export features, advanced settings
- P3: theme customization, experimental features

## Mitigation Plans

Any score ≥6 requires a documented mitigation with owner, deadline, and status. Example:

```markdown
## Risk Mitigation

**Risk**: Payment integration failure (Score: 9)

**Mitigation Plan**:
- Comprehensive test suite (20+ tests)
- Payment sandbox environment
- Retry logic with idempotency
- Monitoring and alerts
- Documented rollback procedure

**Owner**: Backend team lead
**Deadline**: Before production deployment
**Status**: In progress
```

## Where Risk-Based Testing Shows Up

- **`test-design`** writes the risk register for system-level and per-epic test plans
- **`trace`** (Phase 2 gate decision) enforces coverage targets by priority and blocks releases on unresolved P0 risks
- **`nfr-assess`** applies similar probability × impact reasoning to NFR categories

## Key Insight

> [!key-insight] Priority is not just risk score
> P0-P3 classification considers risk scores **plus** business context: revenue impact, usage frequency, regulatory requirements, user impact. A 2×2 feature can still be P0 if it sits on the checkout path. A 3×3 feature can be P2 if it is admin-only and rarely used.

## See Also

- [[Test Architect (TEA)]]
- [[TEA Workflows]] — `test-design` and `trace` consume these scores
- [[TEA-Documentation]] — source
