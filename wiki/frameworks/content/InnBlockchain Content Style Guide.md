---
company:
  - innblockchain
department:
  - marketing
priority: high
rev: 1
last_revised: 2026-06-03
parent_extraction_source: "[[InnBlockchain Phase 1 Execution Playbook]] rev 26 § WS7 § CW Content Style Guide"
scope: cross-phase
applies_to:
  - phase-1
  - phase-2
  - phase-3
tags:
  - framework
  - content
  - style-guide
  - cw
  - cross-phase
---

# Content Style Guide

> [!INFO] HOW to write — voice / tone / formatting rules · cross-phase framework
> The AEO/GEO checklist (in [[Content AEO GEO Prompts]]) enforces STRUCTURE — H2 prompts · 150-word answers · FAQPage JSON-LD · markdown tables. This style guide enforces VOICE so all articles ship in one consistent voice rather than 40 different ones per phase.
>
> Extracted from [[InnBlockchain Phase 1 Execution Playbook]] rev 26 → cross-phase framework (rev 27). Voice / formatting / citation rules are stable across phases; per-track voice modifiers update when new ICP personas activate.

## Voice + tone

- **(CW)** Voice: senior engineer + compliance reviewer + founder, in that order. Never marketing-coded. Never breathless or hype-y.
- **(CW)** Tone: direct, specific, pressure-tested. Lead with the hard part. Push back hardest when the reader sounds certain.
- **(CW)** Reader assumption: knows Web3 fundamentals · knows their own asset class · does NOT know the regulatory + audit edge cases (which is why they're reading)
- **(CW)** **AVOID:** "leverage" (use "use") · "solutions" (name the thing) · "seamless" (replace with specific failure mode handled) · "robust" (cite the spec)
- **(CW)** **FAVOUR:** specific regulation names + dates · specific tech versions · specific failure modes + how mitigated · specific costs / timelines (per AEO Principle 4)

## Formatting standards

- **(CW)** Em-dashes (—) for parenthetical asides; never double hyphens (--)
- **(CW)** US spelling throughout (per Vignesh profile English-only setting)
- **(CW)** Numbers: spell out one–nine; numerals 10+. Currencies: $20k+ in headlines; full notation in tables.
- **(CW)** Code: inline backticks for short identifiers (e.g., `ERC-3643`); fenced code blocks for multi-line snippets
- **(CW)** Lists: numbered for sequences; bullets for parallel items; tables for comparisons
- **(CW)** Bold = the load-bearing claim of a paragraph (one per paragraph max). Italics = first introduction of a regulatory term.

## Source citation standard

- **(CW · Vignesh confirms in compliance review)** Every regulatory claim date-stamped with regulation source (e.g., "MiFID II Art. 4(1)(15) — as of 2026"). Per AEO Principle 8.
- **(CW)** Every numeric claim sourced inline (ESMA · national NCA · industry report · vendor whitepaper). Avoid unsourced figures.
- **(CW)** Competitor mentions: name the standard / spec / interface (ERC-3643 · ERC-1400) NOT the vendor (Securitize · Tokeny). Per AEO Principle 5.
- **(CW)** Internal links: every article internally links to its destination LP + at least 1 sister article in the same cluster.

## Title + meta-description + OG card

- **(CW)** Title (H1) max 60 chars for SERP display; primary keyword in first 30 chars
- **(CW)** Meta description: 150–160 chars; answer the H1 question in one sentence; include CTA verb (Download · Read · Compare)
- **(MPs · Designer template)** OG / Twitter card image: pulled from Designer brand template; never article hero image directly

## Alt-text template (every image)

- **(CW drafts · MPs apply at publish)** Describe what the image shows (not "image of") · include any text shown in the image · ≤125 chars
- **(CW)** Diagrams: describe the relationship being shown (e.g., "Flow from issuer wallet → smart contract → investor whitelist")

## Internal linking strategy

- **(CW)** Hub-and-spoke: every Tier 1 hub article internally linked from every Tier 2/3 article in its cluster
- **(CW)** Cross-pillar (C1, T4-N, P5-DORA-X, P5-eIDAS-X for Phase 1): explicit cross-pillar back-links to the persona-coded LP
- **(CW · Vignesh monthly review)** No orphans: every article has ≥2 internal incoming links within 4 weeks of publish

## Per-track voice modifiers (update per phase as ICP shifts)

### Phase 1 (current)

| Track | Voice modifier |
|---|---|
| `[CN]` Crypto Native (RWA Felix only) | Felix asset-first opener · plain-language regulatory framing · founder-to-founder tone |
| `[FT]` FinTech WealthTech | Sam ROI-first · Tom technical-first · Carol compliance-first — match the segment in the article hook |
| `[Both]` | Lead with regulatory + asset framing · split-CTA footer routes by persona · never blend voices in a single paragraph |

### Phase 2+ (placeholder — activates when DeFi/protocol Felix expands)

When Phase 2 activates DeFi-protocol Felix scope, this section gets a new row for `[CN]` DeFi/protocol with Felix-technical-first voice (different from RWA Felix). Update on Phase 2 kickoff.

## Why this is a separate doc

Voice / tone / formatting / citation rules are stable across all phases. Per-track voice modifiers update when new ICP personas activate, but the rest of the doc stays untouched. Extracting prevents drift between phase-specific playbook copies.
