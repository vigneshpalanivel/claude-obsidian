---
type: concept
title: "RWA / STO EU Compliance Criteria (Decision Diagrams)"
created: 2026-07-07
updated: 2026-07-07
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
    hash: "5a0f88a667d5d6c549271cadfbffe947"
    registered: 2026-07-07
    last_synced: 2026-07-07
    role: "visual criteria companion to the RWA/STO landscape — 19 Mermaid decision trees"
    purpose: "Diagrams-only artifact: every RWA/STO classification and trigger decision as a Mermaid flowchart, with article refs and numeric thresholds in the nodes. Sourced from BOTH the RWA-STO landscape (top-level classification) AND the 15 per-regulation Checklist/ files (granular thresholds, formats, proportionality tests) — extracted via parallel checklist sweep 2026-07-07. Consistent with the 2026-07-07 landscape corrections (best execution = MiFID II Art 27; eIDAS acceptance ~2026-2027; PDMR €20k + MS opt-up €50k; DLT Pilot ~10 applications + €6bn/€9bn caps)."
---

# RWA / STO EU Compliance Criteria (Decision Diagrams)

The **visual criteria companion** to [[RWA-STO-EU-Compliance-Landscape]]: 19 Mermaid decision trees covering every classification and trigger decision in the EU RWA/STO lane, with article references and numeric thresholds in the nodes. Diagrams only — the landscape and the per-regulation checklists carry the explanations.

Unlike the landscape (top-level classification only), the criteria file also encodes the **granular checklist-level decisions**: prospectus exemptions + format selection, MiFID client classification (2-of-3 tests), venue-type determination, AIFMD authorisation thresholds, ELTIF retail/professional parameter split, LOF triggers, DLT Pilot caps, DORA proportionality/TLPT, AMLR CDD tiers, MiCA sub-classification, TFR applicability, eIDAS relying-party obligation.

## The 19 diagrams

**A. Classification & scope**
- A1 Token classification — MiFID II financial instrument vs MiCA (Art 2(4)(a) carve-out; CASP overlay)
- A2 MiCA sub-classification — EMT (1:1 single fiat, bank/EMI issuer) vs ART (≥2 currencies/commodities/basket, own funds ≥ max(€350k, 2% reserve, 25% fixed OH)) vs other crypto-asset (Title II); CASP via Art 60 notification (40 WD) vs full Art 59
- A3 Role stack — issuer → venue (Art 4(1)(22)) → dealer/SI (Art 4(1)(20)) → advisor
- A4 Venue type — RM vs MTF vs OTF vs SI (equity automatic / non-equity opt-in post-2024) vs DLT overlay

**B. Investor & offering**
- B1 Client classification — per-se professional (2-of-3: ≥€20M BS / ≥€40M turnover / ≥€2M own funds) vs ECP vs elective professional (2-of-3: ≥€500k portfolio / 10+ trades/qtr / ≥1yr finance work) vs retail default
- B2 Suitability (advice/portfolio mgmt) vs appropriateness (non-advised complex) vs execution-only (non-complex + client-initiated + warned)
- B3 Prospectus — exclusions (Art 1(2)) → exemptions (QI-only, <150 persons/MS, ≥€100k denom/ticket, <30% fungibility) → €12M threshold (5 Jun 2026) → format (Standard 300pp / Base / URD / EU Follow-on ≥18mo admitted / EU Growth ≤€50M SME, both from 5 Mar 2026)
- B4 MAR — admitted/pending-admission trigger (incl. DLT MTF/TSS) → PDMR €20k (MS opt-up €50k) 3-BD notification → 30-day closed period + Art 19(12) exceptions

**C. Fund structuring**
- C1 UCITS → AIF → ELTIF sequenced test
- C2 AIFMD level — sub-threshold (≤€100M leveraged / ≤€500M unleveraged+5yr-locked, no passport) vs full (Art 6); Art 3(4) opt-in
- C3 UCITS eligibility gate — open-ended → eligible assets (Art 50) → 5/10/40 (Art 52) → retail
- C4 ELTIF retail vs professional-only — 50% vs 100% NAV borrowing; concentration (Art 13) + cross-holding (Art 15) waived for pro-only (Art 13(7))
- C5 AIFMD II LOF — primary-lending-strategy trigger; closed-ended default; open-ended needs NCA-proven LMTs + ≥5% retention; ≤20% per borrower; financial-sector borrowers prohibited (Arts 15a–15b)

**D. Infrastructure & horizontal**
- D1 DLT Pilot — MTF/SS/TSS permission choice; per-instrument caps (shares <€500M mcap, bonds <€1bn, funds <€500M AUM); aggregate €6bn admission ceiling / €9bn transition trigger; 7-condition retail direct access (Art 4(2))
- D2 DORA — Art 2(1) scope; venue/CCP/CSD/TR can never be microenterprises; simplified framework (Art 16) vs full (Arts 5–15); TLPT every 3 yrs if "significant" (external testers every 3rd cycle; significant credit institutions external-only)
- D3 AMLR — CDD triggers (≥€10k, ≥€1k CASP, relationship, suspicion) → EDD (PEP/high-risk-3rd-country) → AMLA selection (≥6 MS + high residual risk)
- D4 TFR — MiFID-classified tokens OUT; crypto (incl. EMT) in with no de-minimis; self-hosted ≥€1k ownership verification
- D5 eIDAS — public sector must accept; private strategic-sector + SCA must accept within 36 months of implementing acts (~late 2026–mid 2027); micro/small exempt
- D6 Cross-cutting summary — always DORA/AML/GDPR; conditional AI Act / MiCA / TFR

## Use cases

- **First-intake routing**: walk a prospect through A1 → A3 → C1 in one call
- **Compliance-scoping proposals**: each diagram = one scoping question with its article basis
- **Smart-contract design input**: the trees are the human-readable version of the gates the [[RWA-STO-Smart-Contract-Design]] compliance modules enforce

See: [[RWA-STO-EU-Compliance-Landscape]] | [[RWA-STO-Smart-Contract-Design]] | [[EU-Fintech-Compliance-Landscape]]
