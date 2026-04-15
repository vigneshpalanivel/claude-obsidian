---
type: concept
title: "Adversarial Review"
created: 2026-04-15
updated: 2026-04-15
tags:
  - review
  - bmad
  - quality
  - cognitive-bias
status: current
related:
  - "[[BMAD Method]]"
  - "[[Advanced Elicitation]]"
  - "[[BMad Quick Dev]]"
sources:
  - "[[BMAD-Method-Documentation]]"
---

# Adversarial Review

A review technique where the reviewer **must** find issues. No "looks good" allowed. The reviewer adopts a cynical stance — assume problems exist, then find them. Zero findings triggers a halt: re-analyze or explain why nothing was found.

## The Core Rule

**Zero findings is a failure mode, not a success.** Standard reviews suffer from confirmation bias — skim the diff, nothing jumps out, approve it. Mandating a finding floor forces genuine analysis:

- Can't approve until you've looked hard enough to find something
- "What's not here?" becomes a natural question
- Findings are specific and actionable, not vague concerns
- Information asymmetry (reviewer gets fresh context, no access to author reasoning) prevents rubber-stamping

In BMad, the `bmad-review-adversarial-general` tool hardcodes a minimum of 10 findings; below that, it re-analyzes deeper.

## Orthogonal to Edge-Case Hunting

BMad pairs adversarial review with `bmad-review-edge-case-hunter`, which is **method-driven, not attitude-driven**. Edge case hunter mechanically enumerates branching paths and boundary conditions — missing else/default, unguarded inputs, off-by-one, arithmetic overflow, implicit type coercion, race conditions, timeout gaps — then reports only unhandled cases.

The two reviews catch different failure classes:

| Review | Catches | Fails At |
|--------|---------|----------|
| Adversarial | Missing requirements, sloppy reasoning, quality gaps, completeness issues | Mechanical edge cases an attitude won't surface |
| Edge case hunter | Unhandled branches, off-by-ones, coercion bugs | Missing features, unclear intent, bad design |

Running both gives non-overlapping coverage. Neither subsumes the other.

## Human Filtering Is Required

An AI instructed to find problems *will* find problems — even when they don't exist. Expect false positives: nitpicks dressed as high findings, misunderstood intent, outright hallucinated concerns. **The human filters.** Review each finding, dismiss the noise, fix what matters.

This is a deliberate tradeoff: false positives are cheaper than false negatives. A noisy review you have to filter is better than a clean review that approved a bug.

## Iteration and Diminishing Returns

Running adversarial review twice usually catches more. A third pass sometimes helps. Eventually you hit diminishing returns — just nitpicks and false positives. The skill is recognizing when you're past the useful point.

## Example Delta

Standard review:
> "The authentication implementation looks reasonable. Approved."

Adversarial review:
> 1. **HIGH** — `login.ts:47` — No rate limiting on failed attempts
> 2. **HIGH** — Session token stored in localStorage (XSS vulnerable)
> 3. **MEDIUM** — Password validation happens client-side only
> 4. **MEDIUM** — No audit logging for failed logins
> 5. **LOW** — Magic number `3600` should be `SESSION_TIMEOUT_SECONDS`

The standard review would have shipped the XSS vulnerability.

## Where It Shows Up in BMad

- `bmad-review-adversarial-general` — core tool, cross-module
- `bmad-review-edge-case-hunter` — orthogonal partner
- `bmad-code-review` — code-specific adversarial review
- `bmad-check-implementation-readiness` — adversarial gate check on planning artifacts before implementation
- Inside [[BMad Quick Dev]] — review findings feed failure-layer diagnosis (intent / spec / local)

## Why It Belongs in the Wiki

The mandatory-finding pattern generalizes beyond BMad. It's directly applicable to `wiki-lint` (the claude-obsidian health check): instead of "scan for problems," mandate "find at least N orphans/gaps/contradictions or explain why none exist." The pattern also underlies [[Advanced Elicitation]]'s pre-mortem method, which assumes failure and works backward to find causes.
