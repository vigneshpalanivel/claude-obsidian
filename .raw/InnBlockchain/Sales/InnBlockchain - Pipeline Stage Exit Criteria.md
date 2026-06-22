---
company:
 - innblockchain
department:
 - marketing
priority: high
rev: 1
last_revised: 2026-06-03
parent_extraction_source: "[[InnBlockchain - Phase 1 Execution Playbook]] § WS12 § Pipeline-stage exit criteria"
scope: cross-phase
applies_to:
 - phase-1
 - phase-2
 - phase-3
tags:
 - framework
 - crm
 - pipeline
 - sp
 - cross-phase
---

# Pipeline Stage Exit Criteria

> [!INFO] When does a prospect advance from stage X to stage X+1? · cross-phase framework
> Without explicit criteria, "Qualified" means different things to different reviewers. These are the gates SP checks before transitioning a CRM status.
>
> Extracted from [[InnBlockchain - Phase 1 Execution Playbook]] → cross-phase framework. Stage advancement rules are stable across phases; ICP-segment specifics in the "Replied → Qualified" row update per phase.

## Stage transitions

| From → To | Criteria (ALL must be true) |
|---|---|
| **Connected → Replied** | T2 sent · prospect replied with anything substantive (1 sentence is enough) · NOT auto-reply / out-of-office |
| **Replied → Qualified** | Prospect's role + company match current-phase ICP segment · prospect engaged on regulatory or technical specifics (not just "interesting, send more info") · clear use case or stage signal |
| **Qualified → Call Booked** | Discovery call scheduled on Calendly · pre-call brief sent · prospect confirmed attendance (not just accepted invite) |
| **Call Booked → Closed** | Discovery call completed (per [[InnBlockchain - Discovery Call Master Sequence]]) · proposal sent · contract signed within 90 days of discovery |
| **Any stage → Parked** | 21 days no response after T5 OR explicit "not now" with no near-term timeline OR DQ signal surfaced |
| **Parked → Connected (re-engagement)** | 60 days minimum elapsed · new buying trigger detected · re-engagement DM sent fresh (NOT as T6) |

## Stage hygiene rules (SP enforces · Vignesh spot-checks)

- **(SP)** Never mark "Qualified" without a regulatory or technical specifics signal — vague interest = Replied, not Qualified
- **(SP)** Never advance a prospect on assumption — only on documented signal in CRM
- **(SP)** Always log stage transition reason in CRM (which signal triggered advance) — required for monthly pattern review
- **(SP · weekly Fri)** Stale "Call Booked" review — booked but not completed in 7 days = follow-up sequence; in 14 days = transition to Parked

## Why this is a separate doc

CRM stage advancement logic is universal across phases. ICP segment matching in the Replied→Qualified row updates per phase as new personas activate — but the rule structure (ALL-must-be-true gates) doesn't change.
