---
type: concept
title: "Working Backwards PRFAQ"
created: 2026-04-15
updated: 2026-04-15
tags:
  - bmad
  - product
  - discovery
status: current
related:
  - "[[BMAD Method]]"
  - "[[Advanced Elicitation]]"
sources:
  - "[[BMAD-Method-Documentation]]"
---

# Working Backwards PRFAQ

Amazon's Working Backwards methodology, adapted by BMad as an interactive challenge for stress-testing a product concept *before* a PRD exists. You write the press release announcing your finished product — before a single line of code — then answer the hardest questions customers and stakeholders would ask.

Invoked via `bmad-prfaq`. Part of BMad's Analysis phase (Phase 1, optional).

## The Gauntlet

PRFAQ is positioned explicitly as the rigorous path into planning, in contrast to `bmad-product-brief` (the gentler path). The product brief captures a concept you already have conviction about. The PRFAQ tests whether that conviction survives being challenged.

The AI acts as a relentless but constructive product coach. You defend every claim. If you can't write a compelling press release, the product isn't ready. If the FAQ answers reveal gaps, those are gaps you'd otherwise discover much later — during implementation, where fixing them is expensive.

## Why It Works

Two reasons:

1. **Customer-first framing.** A press release is written from the customer's perspective, not the builder's. It forces you to articulate *why a customer would care* before you've sunk any cost into building. Most product failures start with builder-first framing.

2. **FAQ as adversarial discovery.** Writing "What might customers complain about?" and then *answering it honestly* surfaces the weak points that optimism would skip past. It's [[Adversarial Review]] applied at the concept stage.

## When to Use Which

| Situation | Tool |
|-----------|------|
| "I have a vague idea, not sure where to start" | `bmad-brainstorming` |
| "I need to understand the market before deciding" | `bmad-market-research` |
| "I know what I want to build, just need to document it" | `bmad-product-brief` |
| "I want to make sure this is actually worth building" | `bmad-prfaq` |
| "I want to explore, then validate, then document" | Brainstorming → Research → PRFAQ or Brief |

Product Brief and PRFAQ both produce input for the PRD. The brief is collaborative discovery; the PRFAQ is a gauntlet. Both get to the same destination — but PRFAQ tests whether the concept deserves to get there.

## What It Produces

`prfaq-{project}.md` — a document containing:
- Press release (as if the product shipped)
- Internal FAQ (harder questions you'd normally skip)
- External FAQ (customer-facing questions)

This feeds directly into `bmad-create-prd` as input. The PRD workflow synthesizes whatever upstream analysis exists into structured requirements.

## Lesson for the Wiki

The PRFAQ pattern — write the outcome first, then work backward to test whether you can actually produce it — is a generalizable discovery method. It maps onto wiki ingestion indirectly: for a source that makes a claim, the equivalent is "write the summary paragraph a reader would need, then check whether the source actually supports every clause." That's how contradiction detection can be made rigorous instead of accidental.
