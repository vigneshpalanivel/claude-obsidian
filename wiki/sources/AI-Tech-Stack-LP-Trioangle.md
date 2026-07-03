---
title: "Trioangle Service Landing Page — AI Tech Stack"
type: source
status: ingested
created: 2026-06-23
ingested: 2026-06-23
source_path: ".raw/Trioangle/sales-marketing/Service/LP/AI Tech Stack - Trioangle Service Landing Page.md"
tags:
  - source
  - trioangle
  - landing-pages
  - ai-engineering
  - tech-stack
  - service-icp
related:
  - "[[Trioangle Service Landing Page AI Tech Stack]]"
  - "[[Trioangle Landing Page Plan]]"
  - "[[Trioangle Service ICP]]"
---

# Trioangle Service Landing Page — AI Tech Stack

**Date ingested:** 2026-06-23
**Source type:** Internal marketing/positioning document (.raw/)
**Source file:** `.raw/Trioangle/sales-marketing/Service/LP/AI Tech Stack - Trioangle Service Landing Page.md`
**Author intent:** Define the AI technology list for the "Tech Stack" section of Trioangle's service landing pages, in a way that reinforces AI-engineering positioning rather than diluting it with over-mentioned third-party vendors. Built collaboratively, iterating from the ArmourPath AI Addon tech reference up to a per-LP grouping aligned with [[Trioangle Landing Page Plan]].

**Pages created:** 1 concept page
- [[Trioangle Service Landing Page AI Tech Stack]]

**Pages updated:**
- [[index]] — new concept + source added
- [[log]] — entry appended
- [[hot]] — last-updated block prepended

---

## Why This Source Matters (Beyond the Tool List)

The substance isn't the logos — it's the **editorial discipline** applied to them, which encodes how Trioangle wants to be perceived:

1. **Vendor names are reframed as range, not dependency.** Self-hosted/open-weight options (Llama, Meilisearch, pgvector) are listed first in each row so the grid signals model-agnostic engineering capability, not API-reselling. The mandatory header line ("Model-agnostic across the full AI stack…") does the reframing.

2. **Tech vs. features were separated.** The Master AI Stack is tools only; features (recommendation, fraud detection, dynamic pricing, dispatch) live in the per-LP grouping. Both sections use one identical vocabulary (the 10 master category names).

3. **Non-AI items were actively purged** to protect the position: Cloud/Infrastructure (hosting), Conversational & Messaging (Twilio/WhatsApp channels + redundant Rasa), FFmpeg/pHash (video processing/hashing), FAISS dup, and the entire unused Video AI category. Rule established: *channels & integrations are not AI tech.*

4. **Scope was corrected against the real offering.** The ArmourPath addon doc under-scoped the stack; mapping to [[Trioangle Landing Page Plan]] surfaced four missing capability areas (Agent Frameworks, Voice AI, ML/Forecasting/Optimization, RAG frameworks), each backing a real LP.

## Key Caveat Carried Forward

A clean tech-stack section is **necessary but not sufficient** to position as AI engineering — on its own a logo grid reads as integrator. The positioning is won by architecture explainers, the "hard parts we own" (evals, guardrails, latency/cost, retraining), demonstrated model-selection judgment, and a production proof point. The stack should be demoted on the page. Proof-point discipline from [[Trioangle Service ICP]] applies: naming a tool ≠ claiming a deployment; several tools are unverified category defaults to be confirmed before publishing.
