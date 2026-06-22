---
company:
 - innblockchain
department:
 - marketing
priority: medium
rev: 1
last_revised: 2026-06-03
parent_extraction_source: "[[InnBlockchain - Phase 1 Execution Playbook]] § WS8 § Newsletter Vendor-Selection Decision Criteria"
scope: cross-phase
applies_to:
 - phase-1
 - phase-2
 - phase-3
tags:
 - framework
 - newsletter
 - vendor-selection
 - cross-phase
---

# Newsletter Vendor Selection Decision Criteria

> [!INFO] Pre-decided framework so revisit is a 30-min call, not a 2-week research sprint
> Newsletter is currently DEFERRED for Phase 1 (revisit ~W10). This framework documents the vendor decision criteria so when activation fires (any phase), the platform decision isn't the bottleneck.
>
> Extracted from [[InnBlockchain - Phase 1 Execution Playbook]] → cross-phase framework. Vendor landscape evaluation is stable across phases; revisit triggers update per phase.

## Vendor comparison

| Vendor | Best for | Trade-off |
|---|---|---|
| **Beehiiv** | Analytics + segmentation + zero revenue cut + no platform lock-in | Smaller discovery network than Substack; slightly more setup work |
| **Substack** | Audience growth + discovery (built-in recommendation network) | 10% revenue cut if paid · weaker analytics · founder voice ties to platform |
| **LinkedIn Newsletter** | Native to existing audience · zero migration · auto-distribution | Lock-in to LinkedIn algorithm · no email list ownership · weak analytics |
| **ConvertKit (now Kit)** | Email automation + CRM integration | No publish-network · pay per subscriber tier |
| **Self-hosted (Ghost / WordPress)** | Full control + own subscriber list + own analytics | Higher engineering cost · no built-in discovery |

## Decision triggers (commit when ALL true at revisit)

- [ ] **(MPs report · Vignesh decides)** 50+ subscribers on LP email-capture list
- [ ] **(MPs report)** 4+ consecutive weeks of follower growth above baseline (>50/mo Phase 1 target; adjust per phase)
- [ ] **(Vignesh decision)** Vignesh has 1–2 hr/wk bi-weekly writing capacity (NOT during a production crunch — confirm against current Vignesh load)
- [ ] **(Vignesh)** Current phase close cleared OR newsletter activated as next-phase launchpad rather than mid-phase distraction

## Default recommendation (if revisit fires + decision triggers pass)

- **Default: Beehiiv** — analytics + segmentation + revenue retention + no lock-in. Best long-term play.
- **Alternative: LinkedIn Newsletter** — if subscriber list <200 at revisit, prefer LinkedIn Newsletter for fastest first-issue ship (lower friction); migrate to Beehiiv at >500 subscribers
- **Defer Substack** until subscriber base >1,000 (discovery network compounds at scale)
- **Avoid ConvertKit** unless next phase commits to email-CRM-integrated drip sequences
- **Avoid self-hosted** unless engineering capacity confirmed available

## Phase-specific revisit triggers

- **Phase 1:** Revisit at W10 (mid-point). Defer if Phase 1 production load consumes Vignesh writing capacity.
- **Phase 2:** Re-evaluate at Phase 2 kickoff with updated subscriber count baseline.

## Why this is a separate doc

Vendor landscape + decision criteria are stable across phases. Revisit timing + subscriber thresholds update per phase but framework structure doesn't change.
