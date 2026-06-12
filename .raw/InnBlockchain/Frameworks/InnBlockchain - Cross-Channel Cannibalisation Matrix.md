---
company:
  - innblockchain
department:
  - marketing
priority: high
rev: 1
last_revised: 2026-06-03
parent_extraction_source: "[[InnBlockchain - Phase 1 Execution Playbook]] rev 26 § WS8 § Cross-channel cannibalisation matrix"
scope: cross-phase
applies_to:
  - phase-1
  - phase-2
  - phase-3
tags:
  - framework
  - cannibalisation
  - linkedin
  - x
  - mps
  - cross-phase
---

# Cross-Channel Cannibalisation Matrix

> [!IMPORTANT] Single canonical reference for all cross-channel spacing rules · cross-phase framework
> Cannibalisation rules previously scattered across 4 subsections in the playbook (WS3 LinkedIn Company Page · WS3 X personal · WS8 LinkedIn output cap · WS15 LinkedIn output cap enforcement). MPs must consult multiple sections to enforce in real-time scheduling. **This matrix is the canonical source.**
>
> Extracted from [[InnBlockchain - Phase 1 Execution Playbook]] rev 26 → cross-phase framework (rev 27). Vectors apply whenever LinkedIn/X are active publishing channels regardless of phase.

## 8 vectors

| # | Vector | Rule | Spacing | Reason |
|---|---|---|---|---|
| 1 | **LinkedIn personal ↔ LinkedIn Company Page** (same topic) | Never same day | ≥24 hr stagger | Cannibalises personal feed reach |
| 2 | **LinkedIn personal ↔ X personal** (same article) | Never same day | ≥24 hr stagger | Cross-platform cannibalisation; same audience on both |
| 3 | **Two LinkedIn posts about same article from same profile** (personal OR Company Page) | Per-profile ≥48 hr spacing | ≥48 hr | Algorithm penalty + audience fatigue |
| 4 | **Cross-pillar Tier 1 article LinkedIn cadence** (Phase 1: C1 · T4-N · P5-DORA-X · P5-eIDAS-X) | Distribute carousel + long-form + persona variants across 3 weeks, NOT launch week | 3-week distribution | Cross-pillar Tier 1 = highest-leverage; concentrated launch = wasted derivative chain |
| 5 | **Two cross-pillar Tier 1 articles in same week** | Editorial Calendar enforces 1/wk cross-pillar cap | n/a (slot rule) | Prevents back-to-back cross-pillar spacing breaches |
| 6 | **Aggregate LinkedIn posts/wk from one profile** | Steady-state ≤7/wk; firehose threshold above that | weekly aggregate cap | Content firehose reads as low-signal · damages thoughtful-publisher framing |
| 7 | **Tier 2 Track B aggregate conflict** | If 2 Tier 2 Track B articles publish same week AND cross-pillar Tier 1 launch week active = >7/wk → defer one Tier 2 article's quote graphic to following week | conditional defer | Aggregate cap breach mitigation |
| 8 | **`[Both]` parallel chains** (Track A X thread + Track B LinkedIn carousel from same source) | Run concurrently within 3-week cadence — NOT sequentially. Platforms don't overlap so no cross-cannibalisation; output cap applies to each side independently | concurrent | Parallel ≠ doubled · platform-split not platform-doubled |

## MPs scheduling enforcement workflow (apply every Mon AM batch-approval)

- [ ] **(MPs)** For each scheduled post: identify which channel (LinkedIn personal · LinkedIn Company · X personal) + which article / topic
- [ ] **(MPs)** Run matrix lookup against the prior 48 hr scheduled queue: any same-channel · same-account · same-topic violations?
- [ ] **(MPs)** Aggregate weekly count check: are we within ≤7/wk LinkedIn from each profile? Are we within ≤4/wk X from each handle?
- [ ] **(MPs)** Cross-pillar Tier 1 week check: is this week already a cross-pillar Tier 1 launch week? If yes, apply Tier 2 Track B aggregate rule (vector 7).
- [ ] **(MPs · Vignesh approves batch Mon AM)** Submit batch with matrix-check log noted; Vignesh approves at WS13 spot-check pace.

> [!WARNING] When in doubt, stagger — not skip
> If two posts conflict on the matrix, defer one by 24–48 hr. Don't drop a post entirely unless the article is Tier 0 or the conflict is unresolvable within the week.

## Phase-specific note

Phase 1 (current) operates without X Company account — vector list above does not include LinkedIn Company ↔ X Company or X personal ↔ X Company spacing rules (per rev 23 playbook rollback). If Phase 2 activates corporate X handle, add those vectors back.

## Why this is a separate doc

Channel spacing rules are stable across phases. New channels (TikTok · YouTube) or new account types (X Company, if reactivated) append rows without changing the framework structure.
