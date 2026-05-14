---
type: concept
title: "BMAD Track Selection Guide"
created: 2026-05-14
updated: 2026-05-14
tags:
  - bmad
  - workflow
  - quick-dev
  - decision-framework
  - team-process
status: current
related:
  - "[[BMad Quick Dev]]"
  - "[[BMad Four-Phase Workflow]]"
  - "[[BMAD Method]]"
---

# BMAD Track Selection — Team Decision Guide

## The Two Tracks

| Track | Best For | Documents Produced | Workflow |
|--|--|--|--|
| **Quick Flow** | Small, clear-scope changes | Tech-spec only | `bmad-quick-dev` (unified) |
| **BMad Method** | Products, platforms, new features | PRD + Architecture + UX | Full 4-phase |

---

## The 5-Question Decision Test

Ask in order. Stop at the first **Yes**.

| # | Question | If Yes → |
|---|--|--|
| 1 | Can the goal **NOT** be stated in one contradiction-free sentence? | Full Method |
| 2 | Does solving it require choosing between **architectural alternatives**? | Full Method |
| 3 | Does the change span **more than one service/module**? | Full Method |
| 4 | Does the team need a **written decision record** (compliance, onboarding, stakeholders)? | Full Method |
| 5 | Is this the team's **first 3–5 BMAD runs**? | Full Method (build calibration first) |

If all five answers are **No** → Quick-Dev. Otherwise → Full Method.

---

## The Core Principle

> [!important]
> Quick-Dev is not about "small" — it's about "fully understood." If the intent can be compressed into one sharp, unambiguous goal, Quick-Dev is safe. If not, no amount of automation will save you from unclear thinking.

---

## Examples

### Good Fits for Quick-Dev

- Fix: login allows empty passwords — `auth/validator.ts` returns true on null
- Add: `created_at` column to `orders` table with default `now()`
- Refactor: convert `UserService` from callbacks to async/await
- Patch: CVE in dependency — bump version, adjust one call site
- UI: change primary button color and hover state

### NOT Quick-Dev (Even If They Seem Small)

- "Add an API endpoint for X" — if it needs new auth, rate limiting, or schema change
- "Fix the checkout bug" — if root cause is unknown
- "Make login faster" — vague goal, not compressed intent
- "Add SSO" — touches auth, config, user model, UI, session management
- "Migrate from Redis to Memcached" — cross-cutting, needs architecture decision

---

## The Escape Hatch

> [!warning]
> If you start Quick-Dev and the spec phase reveals cross-module impact, architectural alternatives, or unclear scope — STOP. Abort Quick-Dev. Route to PM agent for a PRD. Sunk-cost continuation is the #1 Quick-Dev failure mode.

---

## Risk Summary

| Mistake | Cost |
|--|--|
| Quick-Dev on unclear scope | Model fills gaps with confident-wrong output → rework |
| Quick-Dev on cross-system work | Integration bugs missed until QA or prod |
| Full Method on a typo fix | Wasted planning overhead, slower timeline |
| Skipping Quick-Dev's spec approval step | Autonomous run has no frozen boundary → drift |

---

## One-Line Rule

> "If you can write the goal in one sentence and it touches one module — Quick-Dev. Otherwise — Full Method. When the spec phase says otherwise, believe the spec phase."
