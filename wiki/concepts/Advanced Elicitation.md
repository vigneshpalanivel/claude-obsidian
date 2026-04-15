---
type: concept
title: "Advanced Elicitation"
created: 2026-04-15
updated: 2026-04-15
tags:
  - bmad
  - review
  - reasoning-methods
status: current
related:
  - "[[BMAD Method]]"
  - "[[Adversarial Review]]"
  - "[[Working Backwards PRFAQ]]"
sources:
  - "[[BMAD-Method-Documentation]]"
---

# Advanced Elicitation

Make the LLM reconsider what it just generated — not by asking it to "try again," but by applying a **specific reasoning method** to its own output. The named method forces a particular angle of attack that generic retries miss.

## The Distinction

"Try again" or "make it better" produces vague revisions. A named method produces targeted ones. Vague requests → vague improvements. Named methods → surfaced insights.

## How It Works in BMad

1. LLM suggests 5 relevant methods for your content
2. You pick one (or reshuffle for other options)
3. Method is applied, improvements shown
4. Accept or discard, repeat or continue

Workflows offer advanced elicitation at decision points — after something has been generated, the user is asked whether to run it.

## Built-in Methods (Sample)

| Method | What It Does |
|--------|-------------|
| **Pre-mortem Analysis** | Assume the project already failed; work backward to find why |
| **First Principles Thinking** | Strip assumptions, rebuild from ground truth |
| **Inversion** | Ask how to guarantee failure, then avoid those things |
| **Red Team vs Blue Team** | Attack your own work, then defend it |
| **Socratic Questioning** | Challenge every claim with "why?" and "how do you know?" |
| **Constraint Removal** | Drop all constraints, see what changes, add them back selectively |
| **Stakeholder Mapping** | Re-evaluate from each stakeholder's perspective |
| **Analogical Reasoning** | Find parallels in other domains and apply their lessons |

Dozens more exist. The AI picks the most relevant options for the content type; the user chooses which to run.

## Recommended Starting Method

Pre-mortem analysis is a good first pick for any spec or plan. It consistently finds gaps that a standard review misses, because assuming failure flips the cognitive default from "does this seem to work?" to "how does this break?"

## Relationship to Adversarial Review

[[Adversarial Review]] mandates finding issues; advanced elicitation applies named reasoning methods. They complement:

- Adversarial review is attitude-driven (mandatory skepticism)
- Advanced elicitation is method-driven (structured reasoning)
- Both produce gap-finding output, but via different mechanisms

You can run them in sequence: adversarial review finds obvious problems; advanced elicitation (pre-mortem) finds second-order ones.

## Why It Generalizes

The core insight — **vague requests produce vague revisions; named methods produce targeted ones** — applies broadly to any LLM workflow. Instead of "refine this," the instruction becomes "apply pre-mortem analysis to this." Instead of "think harder," it's "invert the problem and find failure modes." The structure of the method is doing the cognitive work.

This maps onto how the claude-obsidian `/save` skill could work: rather than asking Claude to "summarize the session," the skill could apply a named method ("extract surprising facts," "invert to find gaps," etc.) to produce structured output.
