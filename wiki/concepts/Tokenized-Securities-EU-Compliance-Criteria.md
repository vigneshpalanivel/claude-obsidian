---
type: concept
title: "RWA / STO EU Compliance — Applicability Criteria"
created: 2026-07-07
updated: 2026-07-11
tags:
  - EU
  - RWA
  - STO
  - compliance
  - decision-trees
  - mermaid
status: current
related:
  - "[[RWA-STO-EU-Compliance-Landscape]]"
  - "[[RWA-STO-Smart-Contract-Design]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[ELTIF-2.0]]"
  - "[[MiFID-II]]"
  - "[[MAR-Regulation]]"
  - "[[Prospectus-Regulation]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[DORA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[MiCA-Regulation]]"
  - "[[TFR-Regulation]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/sales-marketing/Service/Content/EU Compliance/RWA-STO-EU-Compliance-Criteria.md"
    hash: "abd94e43ab1ff64a8f4c713993bad291"
    registered: 2026-07-07
    last_synced: 2026-07-11
    role: "per-regulation APPLICABILITY gates — 20 Mermaid 'does this regime apply?' decision trees"
    purpose: "Diagrams-only artifact. 2026-07-08 REVAMP: pivoted from classification decision trees to APPLICABILITY gates — one Mermaid tree per compliance regime answering 'does this apply to my RWA/STO platform, yes/no, and under what condition?', each ending in APPLIES (scope/trigger) or does-NOT-apply (reason). Sourced from the per-regulation Checklist/ files (scope sections). 20 gates (2026-07-11 update, was 18): 1.x securities-core (MiFID II, MiFIR, MiFID III, Prospectus, MAR, EU Listing Act) · 2.x fund (AIFMD, AIFMD II, UCITS, ELTIF 2.0) · 3.x infra (DLT Pilot) · 4.x horizontal (DORA, AMLR, eIDAS, GDPR, EU AI Act, MiCA, TFR) · §5 recently-adopted-not-yet-applicable (5.1 T+1 Reg 2025/2075; 5.2 RIS pre-OJ) · §6 out-of-scope note (CCD2, IPR, PSD3). §2.4 also links the ELTIF RTS 2024/2759 checklist; §3.1 notes the ESMA DLT-permanence recommendation. Gates ASSUME the token is already classified as a MiFID security — the token/role/fund CLASSIFICATION trees are the landscape's content and are deliberately NOT included here (user may add later). Prior version (18 classification trees sourced from landscape + checklists) fully replaced."
---

# RWA / STO EU Compliance — Applicability Criteria

The **applicability companion** to [[RWA-STO-EU-Compliance-Landscape]]: for each EU compliance regime relevant to an RWA/STO platform, one Mermaid decision tree answering a single question — **does this regulation apply to me, yes or no, and under what condition?** Each gate ends in **APPLIES** (with the scope/trigger) or **does NOT apply** (with the reason). Sourced from the per-regulation Checklist/ scope sections. Diagrams only.

> The gates **assume the token is already classified as a MiFID-lane security**. The token / role / fund **classification** decision trees are the landscape's content and are deliberately **not** duplicated here (may be added later).

## The 20 applicability gates

**1. Securities-core** — 1.1 MiFID II (provide an investment service? issuer-only ⇒ N/A) · 1.2 MiFIR (execute ⇒ Art 26; venue/SI ⇒ transparency) · 1.3 MiFID III (venue or dealer/SI only) · 1.4 Prospectus (public offer/admission minus exemptions; <€12m from Jun 2026) · 1.5 MAR (admitted/pending-admission to an EU venue) · 1.6 EU Listing Act (via Prospectus/MAR/MiFIR nexus)

**2. Fund regimes** — 2.1 AIFMD (is it an AIF? then full >€100m lev / >€500m unlev, else sub-threshold) · 2.2 AIFMD II (all AIFMs by 16 Apr 2026; +LOF rules if loan-originating) · 2.3 UCITS (open-ended + liquid + retail — rare) · 2.4 ELTIF 2.0 (full AIFM + retail passport for illiquid ≥55%)

**3. Infrastructure** — 3.1 DLT Pilot (on-chain venue/settlement + sandbox opt-in + within €500m/€1bn/€6bn caps)

**4. Horizontal** — 4.1 DORA (financial entity; venues never micro; +CTPP path) · 4.2 AMLR (obliged entity; +AMLA direct if ≥6 MS + high risk) · 4.3 eIDAS (strategic sector + SCA + not micro ⇒ accept EUDI Wallet ~2026–2027) · 4.4 GDPR (any EU personal data ⇒ always) · 4.5 EU AI Act (high-risk AI deployment only) · 4.6 MiCA (does NOT apply to RWA tokens — only a CASP side-business) · 4.7 TFR (does NOT apply to MiFID tokens — crypto transfers only)

**5. Recently adopted — not yet applicable** — 5.1 T+1 settlement (Reg (EU) 2025/2075; venue/settlement lane from 11 Oct 2027; on-chain DvP meets it natively) · 5.2 RIS (retail distribution ~end-2028, pre-OJ; eases elective-professional to €250k)

**6. Out of scope** — CCD2 (consumer credit), IPR / PSD3-PSR (payments) noted as not triggered by securities activity.

*Annotations: §2.4 ELTIF links the Level-2 RTS 2024/2759 checklist; §3.1 DLT Pilot notes the ESMA Jun-2025 permanence/flexible-caps recommendation.*

## Use cases

- **Compliance-scoping a prospect**: run the platform through all 20 gates → the set that says APPLIES is the engagement scope
- **Proposal / SoW basis**: each APPLIES gate = one workstream with its article trigger
- **Pairs with**: [[RWA-STO-EU-Compliance-Landscape]] (why/how each applies) and [[RWA-STO-Smart-Contract-Design]] (what the applicable ones require on-chain)

See: [[RWA-STO-EU-Compliance-Landscape]] | [[RWA-STO-Smart-Contract-Design]] | [[EU-Fintech-Compliance-Landscape]]
