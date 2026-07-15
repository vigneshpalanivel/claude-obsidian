---
company:
  - innblockchain
department:
  - marketing
priority: high
rev: 1
last_revised: 2026-06-13
parent_extraction_source: "[[Phase 1 Execution Playbook]] rev 31 § WS14 § Case Study Capture (at-contract-sign + at-delivery + publishing trigger)"
scope: cross-phase
applies_to:
  - phase-1
  - phase-2
  - phase-3
tags:
  - framework
  - case-study
  - vignesh
  - cross-phase
---

# Case Study Capture Framework

> [!INFO] Per-client-engagement case study capture workflow · cross-phase
> Fires for every new client engagement, every phase. Phase-specific overlays (MVP fallback trigger week · case study tagging — Case Study A vs B) live in the playbook's WS14; this framework covers the universal capture flow.

## At every new client engagement (contract sign · pre-emptive)

- [ ] **(Vignesh)** Negotiate **screenshot rights** in the contract — much harder to get post-launch
- [ ] **(Vignesh)** Negotiate **option to use anonymised case study** — even if client wants name kept private, anonymised version still ships
- [ ] **(Vignesh)** Identify which asset class / vertical the engagement serves (for case study tagging per current phase's ICP segmentation)

## At engagement delivery / launch

- [ ] **(Vignesh + delivery team)** Document deliverables (smart contracts shipped · audit findings · compliance work)
- [ ] **(Vignesh + delivery team)** Capture screenshots (issuer dashboard · investor portal · KYC flow · regulator reporting view · any UI surface that proves working product)
- [ ] **(Vignesh + SP)** Get client lead's quote (1–2 sentences on outcome · ROI · pain solved)
- [ ] **(Vignesh)** Confirm screenshot rights are signed-off (do not assume contract clause = sign-off · get explicit confirmation per asset)
- [ ] **(Vignesh + CW)** Tag for one of the phase-specific case study categories (Phase 1: Case Study A = CN RWA · Case Study B = FT WealthTech B1)

## Publishing trigger (out-of-sequence override per [[Editorial Calendar]])

- [ ] **(CW drafts · Vignesh review · MPs publish)** Case study slots into next BOFU position when delivered + screenshots cleared
- [ ] **(CW)** Per-vertical Post-Launch articles slot in after first client goes live in that vertical (Phase 1 examples: *Hardening a Live RWA Tokenization Platform* after first RWA client · *Expanding Your RWA Platform to New Markets* B1 Post-Launch after first B1 client)

## MVP fallback (per-phase trigger · only if no client deployment cleared screenshot rights by review deadline)

This is a phase-specific fallback. Phase 1 fires at W14 review per playbook WS14. Pattern is reusable:

- [ ] **(Vignesh decision)** **Mid-phase review:** if no client deployment has cleared screenshot rights by the phase-specific review week, commit to internal MVP build
- [ ] **(Designer)** **Scope = mockup deliverable, NOT working dApp.** Build in Figma + branded UI screenshots sufficient for white-label LP visual proof. 1–2 weeks feasible for design + screenshot capture. Working-dApp scope (4–6 weeks dev) is out of marketing budget.
- [ ] **(Designer + Vignesh review)** Branded as generic demo product (not InnBlockchain-named, not client-named) — gives BOFU LP a working visual
- [ ] **(Vignesh decision)** If review shows a client deployment likely to clear soon, defer MVP and stay on the client-deployment path

### Phase 1 overlay

- W14 (Aug 17–23) review window
- 4–6 wk runway needed before W20 BOFU publish
- If review shows client deployment likely to clear by W17, defer MVP

## Why this is a separate doc

Per-client case study capture is the same Phase 1 → Phase 2+. Specific case study category names + MVP trigger weeks update per phase but the at-sign / at-delivery / publishing-trigger / MVP-fallback flow doesn't.
