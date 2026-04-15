---
type: concept
title: "BMad Quick Dev"
created: 2026-04-15
updated: 2026-04-15
tags:
  - bmad
  - workflow
  - autonomous-execution
status: current
related:
  - "[[BMAD Method]]"
  - "[[BMad Four-Phase Workflow]]"
  - "[[Adversarial Review]]"
  - "[[Agentic Engineering]]"
sources:
  - "[[BMAD-Method-Documentation]]"
---

# BMad Quick Dev

`bmad-quick-dev` is BMad's parallel track for small, well-understood changes. Its deeper purpose is a design experiment: *how much autonomous model execution is safe if you invest heavily in upfront intent compression?*

## The Core Bet

Human-in-the-loop checkpoints are necessary but expensive. Current LLMs fail in predictable ways: they misread intent, fill gaps with confident guesses, drift into unrelated work, and produce noisy reviews. Constant supervision keeps them on track but caps velocity.

Quick Dev rebalances the tradeoff: **run longer with less supervision, but only after building a strong boundary first.**

## The Design

1. **Compress intent first.** Before anything autonomous happens, the human and the model collapse the request into one coherent, contradiction-free goal. Intent can start as anything — a phrase, a bug tracker URL, text copied from chat, plan mode output, even a BMAD story number. But before execution, it has to be small enough and sharp enough that the model can run against it without needing to guess.

2. **Route to the smallest safe path.** Zero-blast-radius changes go straight to implementation. Everything else goes through spec generation so the model has a stronger frozen boundary.

3. **Run longer with less supervision.** On the fuller path, the approved spec *is* the boundary. The model executes against it with minimal check-ins.

4. **Diagnose failure at the right layer.** This is the subtle part. If a review finds something wrong, Quick Dev asks: did the problem come from the intent, the spec, or local implementation?
   - Intent wrong → go back to intent interview, regenerate spec, regenerate code
   - Spec wrong → regenerate spec, regenerate code
   - Local implementation wrong → patch the code
   
   Patching code when the intent was wrong is the worst failure mode — it masks the upstream error and produces confident-looking-but-wrong output.

5. **Bring the human back only when needed.** Human attention returns at intent clarification, spec approval, final review, and intent-gap resolution. Everything else is candidate for autonomous execution.

## Review as Triage, Not Recall

Agentic reviews derail runs in two ways:
- Too many findings → human sifts through noise
- Surfacing unrelated issues → every run becomes an ad hoc cleanup

Quick Dev treats review as triage. Some findings belong to the current change; some don't. Incidental findings get **deferred** to `deferred-work.md` rather than forcing immediate resolution. Imperfect triage is acceptable — the system optimizes for signal quality, not exhaustive recall.

## Why This Matters Outside BMad

The intent-compression-then-autonomous-run pattern is generally useful for any agentic workflow. It's the same philosophy that:

- [[Agentic Engineering]] applies to multi-step agent orchestration
- The claude-obsidian `/autoresearch` loop should apply when scheduling its own continuations
- [[Advanced Elicitation]] applies at a smaller scale, within a single workflow turn

The key insight: **human checkpoints should be rare and high-leverage, not frequent and low-leverage**. Every checkpoint is expensive; spend them where human judgment has the highest return.

## Checkpoint Preview Integration

Quick Dev ends by appending a review trail to the spec file and opening it in the editor. The user can say "checkpoint" to trigger `bmad-checkpoint-preview`, which walks them through the change organized by concern (not by file). That walkthrough is the primary handoff from autonomous implementation back to human judgment.
