---
type: source
title: "InnBlockchain GDPR Business Readiness Checklist"
source_type: internal-checklist
date_published: 2026-05-25
url: ".raw/InnBlockchain/EU Compliance/gdpr-checklist.md"
confidence: high
hash: "788d3da1aafbfcf1e273cc95b78475b8"
version: "1.1"
verification_source:
  path: ".raw/InnBlockchain/EU Compliance/gdpr.html"
  hash: "cf04d05903e5805ba9571dfb1d6fdb57"
  description: "Local copy of EUR-Lex page for Regulation (EU) 2016/679 — used as verbatim cross-check source because live EUR-Lex blocks programmatic access with HTTP 202 anti-bot wall"
key_claims:
  - "GDPR (Reg (EU) 2016/679) entered into force 24 May 2016; applies from 25 May 2018 (Art. 99)"
  - "Three independent territorial triggers (Art. 3): establishment, targeting, monitoring — extraterritorial reach is the broadest of any EU regime"
  - "Non-EU controllers under Art. 3(2) must designate an Art. 27 representative unless the narrow Art. 27(2) exception applies; Art. 27(2) is fact-specific and rarely available to running fintech onboarding pipelines"
  - "Six Art. 6(1) lawful bases; for fintech KYC the correct basis is 6(1)(c) legal obligation under AMLR, NOT 6(1)(a) consent — wrong-basis stacking is a structural DPA finding"
  - "Eight Art. 9(1) special categories; biometric KYC requires Art. 9(2)(a) explicit consent SEPARATE from Art. 6 basis, plus a non-biometric KYC fallback (otherwise consent is invalid for being unfreely given)"
  - "Three mandatory DPIA triggers at Art. 35(3): automated profiling with legal effects; large-scale Art. 9 / Art. 10 data; systematic large-scale monitoring of publicly accessible area"
  - "DPO mandation triggers (Art. 37(1)): public authority; core activities = regular and systematic monitoring of data subjects on a large scale; core activities = large-scale Art. 9 / Art. 10 data — most fintechs trigger via 'large-scale processing of KYC data'"
  - "Art. 30(5) under-250 RoPA carve-out has three knock-outs (risk to rights, processing not occasional, Art. 9 / Art. 10 data) — almost no fintech qualifies"
  - "Art. 33(1) 72-hour breach notification to lead DPA; threshold is 'unlikely to result in a risk to the rights and freedoms of natural persons'; phased reporting allowed (Art. 33(4))"
  - "Schrems II + transfer impact assessment (TIA) requirement layered on top of any Art. 46 mechanism (SCCs, BCRs)"
  - "Art. 83 two-tier admin fine regime: Tier 1 €10M or 2% turnover (controller/processor obligations, Arts 8/11/25-39/42/43); Tier 2 €20M or 4% turnover (principles, rights, transfers, MS law obligations, DPA order non-compliance)"
  - "EDPB Guidelines 02/2025 on processing of personal data through blockchain technologies (adopted 14 April 2025) is the authoritative EDPB blockchain document — NOT EDPB Opinion 28/2024 (which is on AI models, adopted 18 Dec 2024)"
  - "EDPB Guidelines 02/2025 expects controllers to design off-chain personal data + on-chain hash anchoring + cryptographic erasure as the Art. 17 erasure approximation for smart-contract architectures"
  - "GDPR ↔ AMLR: KYC retention conflict resolved via Art. 6(1)(c) legal-obligation basis with 5-year retention per AMLR Art. 77"
  - "GDPR ↔ AI Act: DPIA (Art. 35) and FRIA (AI Act Art. 27) can be combined; relevant for LendTech credit scoring, RegTech fraud AI, InsurTech underwriting, Seg 10 AI×Crypto"
  - "GDPR ↔ DORA: DORA Pillar 1 ICT-risk framework = Art. 32 security evidence for in-scope ICT estate, but neither subsumes the other"
verification_method: "All 22 article citations in the checklist cross-checked verbatim against locally-saved EUR-Lex HTML (gdpr.html, 810KB → 374KB text). Verification covered Arts 2, 3, 6, 9, 22, 27, 30, 32, 33, 35, 36, 37, 83, 99. One material error caught and corrected pre-ingest: EDPB Opinion 28/2024 was originally cited as the blockchain authority — Opinion 28/2024 is actually on AI models; corrected to EDPB Guidelines 02/2025 (the authoritative blockchain document). v1.0 → v1.1 in same session."
tags:
  - GDPR
  - EU
  - compliance
  - data-protection
  - privacy
  - internal-checklist
related:
  - "[[GDPR-Regulation]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[DORA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[EU-AI-Act-Fintech]]"
  - "[[eIDAS-2.0]]"
---

# InnBlockchain GDPR Business Readiness Checklist

Internal practitioner checklist for InnBlockchain prospects (FinTech ICP — DPO / CISO / CCO audience; Crypto Native ICP — CTO / founder audience). Maps to the article-by-article structure a specialist EU data-protection lawyer would walk a founder through at a first-intake call.

## Scope

GDPR is the **only genuinely universal horizontal regime** in the EU compliance stack — every InnBlockchain prospect that processes EU residents' personal data is in scope, regardless of segment, product surface, or licensing posture. The checklist treats GDPR as the foundational layer under MiCA, DORA, MiFID II, AMLR, AI Act, and eIDAS 2.0, not as a parallel siloed compliance.

## Structure (14 Sections)

1. Does GDPR apply? — material + territorial scope, Art. 27 representative
2. Role classification — controller / joint controller / processor (Arts. 4, 26, 28)
3. Lawful basis — Art. 6 + Art. 9 special categories + Art. 10 criminal data
4. Article 5 principles + accountability
5. Controller structural obligations — Art. 25 by-design, Art. 30 RoPA, Art. 37–39 DPO
6. Data subject rights (Arts. 12–22) — including on-chain erasure design
7. Transparency, DPIA, prior consultation, DPA-meeting documentation bundle
8. Security + breach notification (Arts. 32–34)
9. International transfers + Schrems II TIA (Arts. 44–50)
10. Supervision, one-stop-shop, EDPB coordination (Arts. 51–76)
11. Penalties + civil liability + complaints (Arts. 77–84)
12. GDPR ↔ AML/AMLA / AI Act / DORA / MiCA / eIDAS 2.0
13. Timeline & key dates
14. EDPB / Commission instruments cross-reference map

Plus: Readiness scorecard (count completed checkboxes per section, green/amber/red banding), Working with InnBlockchain (Pre-Build / Build / Audit deliverables), Disclaimer.

## What This Adds vs. the Concept Page

[[GDPR-Regulation]] is the strategic / "what-is-GDPR" layer (who is in scope, the regime's interactions with other EU laws, common gaps, supervisory architecture). The checklist is the **operational dossier** — every InnBlockchain claim is tied to a specific Article reference and a checkbox the prospect can tick or fail on.

Most distinctive additions:

- **Art. 9 biometric-KYC consent fallback requirement** — facial-recognition KYC needs Art. 9(2)(a) explicit consent **plus** a non-biometric KYC alternative, otherwise the consent is invalid for being unfreely given. CNIL and Garante have enforced on this.
- **Art. 10 criminal-conviction data Member-State authorisation patchwork** — sanctions / PEP / adverse-media screening data is Art. 10; the *national* authorisation regime varies materially; pan-EU operations need per-Member-State legal opinions.
- **On-chain erasure architectural plan** — EDPB Guidelines 02/2025 explicitly expects this designed in at inception, not retrofitted at DSAR stage. Off-chain personal data + on-chain hash anchoring + cryptographic erasure is the InnBlockchain-buildable solution.
- **Documentation bundle for first DPA meeting** — explicit list of what DPAs ask for on day one (Art. 30 RoPA, DPIA register, privacy notice, DPO designation, Art. 27 representative, Art. 32 measures summary, breach register, processor inventory with Art. 28 contracts, transfer inventory with TIA).
- **Breach taxonomy integration across GDPR Art. 33 + DORA Art. 19 + NIS2 + AMLR/FIU** — a single incident can trigger up to four separate notifications with different scoping rules and timelines.
- **GDPR ↔ AMLR retention conflict resolution** — AMLR Art. 77 mandates 5-year CDD retention; GDPR storage limitation pushes the other way. Resolution: document the 5-year period as the GDPR retention period under the legal-obligation basis; delete on day 1 of year 6 unless extension justified.
- **DPIA + FRIA convergence** — single combined assessment satisfying Art. 35 GDPR + Art. 27 AI Act for high-risk AI in LendTech / RegTech / InsurTech / Seg 10 AI×Crypto.

## Verification

All 22 article citations in the checklist cross-checked verbatim against the locally-saved EUR-Lex HTML of Regulation (EU) 2016/679 (`gdpr.html`, 810KB raw, ~374KB plain text after HTML stripping). Verification covered:

- Art. 2 (material scope), Art. 3 (territorial scope)
- Art. 6 (lawful bases), Art. 9 (special categories), Art. 22 (automated decisions)
- Art. 27 (representative + Art. 27(2) exception verbatim), Art. 30(5) (RoPA carve-out verbatim)
- Art. 32 (security TOMs (a)–(d) verbatim), Art. 33(1)–(5) (72-hour rule verbatim)
- Art. 35(3)(a)–(c) (mandatory DPIA triggers verbatim), Art. 36 (prior consultation 8 wk + 6 wk extension)
- Art. 37(1)(a)–(c) (DPO mandation triggers verbatim)
- Art. 83(4) and 83(5) (penalty tiers verbatim with article-coverage list verbatim)
- Art. 99(1)–(2) (entry into force + 25 May 2018 application date verbatim)

EUR-Lex was used as the canonical source rather than gdpr-info.eu (a verbatim mirror) because the user requested cross-check against the official source URL from [[EU-Fintech-Compliance-Landscape]] line 203.

## Material Error Caught and Corrected (v1.0 → v1.1)

The v1.0 draft cited **EDPB Opinion 28/2024 on blockchain** as the authoritative EDPB blockchain document across 11 references. This was a hallucination — Opinion 28/2024 is actually on **AI models** (adopted 18 December 2024). The correct authority is **EDPB Guidelines 02/2025 on processing of personal data through blockchain technologies** (adopted 14 April 2025). v1.1 corrected all 11 references — 9 blockchain-context references re-pointed to Guidelines 02/2025; Opinion 28/2024 retained in the 2 places where it correctly belongs (GDPR ↔ AI Act section). CNIL "Blockchain and the GDPR" (29 October 2018) added as supplementary national-DPA reference.

## Tensions / Open Items

1. **EU–US Data Privacy Framework (DPF)** is treated as live but politically fragile (Schrems III pending). The checklist holds the position "do not architect EU–US flows assuming DPF is permanent — keep SCC fallbacks pre-signed." Re-verify before client-facing use if Schrems III decision lands.
2. **Smart-contract erasure plan** — the EDPB Guidelines 02/2025 framing of cryptographic erasure as an approximate Art. 17 satisfaction is the strongest available reading but is not statutory; some Member-State DPAs may demand stricter (e.g. complete off-chain re-architecting). Cross-validate with lead-DPA-specific guidance.
3. **Art. 27 exception edge cases** — the "occasional" prong of Art. 27(2)(a) is fact-specific and DPAs have been inconsistent on what counts as occasional. CNIL and Dutch AP have both enforced against non-EU controllers operating without a representative; pattern still developing.
4. **Schrems II TIA depth** — EDPB Recommendations 01/2020 set the baseline; some lead DPAs (notably the EDPS for EU-bodies) require deeper documentation than others. Treat the TIA template as a starting point, not a one-size finished artefact.

## InnBlockchain Service Mapping

The Working with InnBlockchain section in the checklist breaks down delivery into three layers — Pre-Build (scoping briefs, RoPA templates, DPIA register seeded, off-chain/on-chain decision, Art. 28 contract templates), Build (off-chain personal data + on-chain hash architecture, cryptographic erasure, multi-sig + RBAC for Art. 32, automated DSAR pipeline, AML+TFR data-flow design satisfying both regimes), Audit (privacy-engineering audit of on-chain/off-chain boundary, DSAR stress test, DPIA review against EDPB Guidelines 02/2025, TIA review, breach-classification engine unifying GDPR/DORA/NIS2 taxonomies).

Primary fit by segment:

- **FinTech ICP**: all 8 segments — GDPR applies universally. Highest InnBlockchain wedge in WealthTech (RWA on-chain personal data), LendTech (credit-scoring DPIA + FRIA), RegTech (KYC/AML AI), BankTech (DORA/GDPR breach taxonomy integration).
- **Crypto Native ICP**: all 10 segments — Seg 1 RWA Tokenization is the highest-value GDPR conversation (on-chain personal data architecture decisions made at SPV/token design stage). Seg 10 AI×Crypto is the second-highest (AI Act × GDPR convergence around on-chain agent decisions).

## See Also

[[GDPR-Regulation]] | [[EU-Fintech-Compliance-Landscape]] | [[DORA-Regulation]] | [[DORA-NCA-Supervision-Mechanics]] | [[MiCA-Regulation]] | [[EU-AML-AMLA]] | [[EU-AI-Act-Fintech]] | [[eIDAS-2.0]] | [[InnBlockchain FinTech ICP]] | [[InnBlockchain Crypto Native ICP]]
