---
type: source
title: "EU MiCA, DORA, and AML Regulations: 2025 Deep Dive"
created: 2026-04-16
updated: 2026-05-20
source_type: web-research + internal-checklist
url: https://www.innreg.com/blog/dora-regulation-explained
confidence: high
tags:
  - MiCA
  - DORA
  - AML
  - AMLA
  - EU
  - compliance
  - source
key_claims:
  - DORA in force January 2025; penalties up to 2% of total annual turnover
  - MiCA fully applicable 30 December 2024; CASP transitional period ends 1 July 2026 (Art 143(3))
  - 65% of EU-based crypto businesses MiCA-compliant by Q1 2025
  - Over EUR 540M in MiCA fines since implementation; 50+ licenses revoked
  - AMLA Regulation (EU) 2024/1620 — AMLA operational July 2025; direct supervision of selected obliged entities from 1 January 2028
  - EU AML rulebook (AMLR — Regulation (EU) 2024/1624) directly applicable from 10 July 2027
  - CASP capital tiers Class 1 €50k / Class 2 €125k / Class 3 €150k (Annex IV) — cumulative; custody is Class 2, trading platform is Class 3
  - ART issuer floor €350k or 2% reserves or 25% overheads (higher of); NCA can require up to 20% additional under Article 35(3)
  - White papers must be in machine-readable format set by ESMA RTS (specific format/date not in MiCA Level 1)
  - MiCA Articles 34(10) (ART issuers) and 68(7)–(8) (CASPs) cross-reference DORA — one regulatory process, not two
  - Article 60 lets banks/MiFID firms/EMIs/CSDs/UCITS/AIFMs/market operators provide CASP services via 40-working-day notification, exempt from Articles 62-64, 67, 83-84 (Art 60(10))
  - Article 39 — ART redemption shall not be subject to a fee on normal redemption (fees only under recovery plan, Article 46)
internal_sources:
  - path: ".raw/InnBlockchain/EU Compliance/mica-checklist.md"
    hash: "492b5075eb46fb2a8a156fbad9b758b0"
    version: "2.3"
    ingested: 2026-05-20
    reingested: 2026-05-24
    triple_checked: 2026-05-25
    type: practitioner-checklist
    purpose: "Pre-NCA-application readiness assessment authored by InnBlockchain for MiCA-bound founders. Re-ingested after second-pass verification against Regulation (EU) 2023/1114 verbatim text via Wayback-archived EUR-Lex."
    superseded_claims:
      - "CASP capital class mapping (v1 had Class 2 and Class 3 services swapped — now corrected per Annex IV)"
      - "Article 66 cited for ICT — wrong; correct is Articles 34(10) and 68(7)–(8); Article 66 is conduct of business"
      - "30%/60% bank-deposit rule attributed to EMTs — wrong; applies to ARTs (Art 36(5)(d) / 45(7)(b))"
      - "Significance criteria (v1 table had reserve €1bn, '7 Member States', missing DMA gatekeeper and cumulation criteria — corrected against Article 43(1) verbatim)"
      - "Stress-testing buffer cited as '20-40%' — wrong; Article 35(3) is up to 20%"
      - "iXBRL by 23 December 2025 — not in MiCA Level 1; depends on ESMA RTS"
      - "Insider lists and personal dealing rules cited as MiCA requirements — wrong; these are MAR concepts not imported by MiCA"
      - "Article 39 redemption fee — v1 said cost-reflective fee allowed; corrected: no fee on normal redemption, fees only under recovery plan (Art 46)"
      - "Article 75 custody — v1 added 'with prior express consent' carve-out for own-account use; not in Article 75; Article 70(1) is absolute"
      - "Article 111 penalty percentages — v1 collapsed into 3% / 12.5%; corrected to the actual six tiers (3% / 12.5% / 12.5% / 5% / 2% / 15%)"
  - path: ".raw/InnBlockchain/EU Compliance/dora-checklist.md"
    hash: "7846555f77db1b3eac861b5ab510385a"
    version: "1.2"
    ingested: 2026-05-24
    reverified: 2026-05-25
    type: practitioner-checklist
    purpose: "DORA continuous-compliance readiness assessment authored by InnBlockchain for in-scope financial entities (or applicants for sectoral authorisation). Built around the five DORA pillars (ICT risk management, incident reporting, resilience testing including TLPT, third-party risk + CTPP regime, information sharing) plus sectoral integration (MiCA, MiFID II, PSD3, NIS2). Filed under this source page (not a separate source page) per the same convention used for mica-checklist. Re-verified 2026-05-25 against Regulation (EU) 2022/2554 verbatim text via locally-saved EUR-Lex HTML (`.raw/InnBlockchain/EU Compliance/dora.html`)."
    verification_artefact: ".raw/InnBlockchain/EU Compliance/dora.html"
    superseded_claims:
      - "v1.0 had TLPT external-tester rule wrong (said 'every three cycles'); v1.1 'corrected' to default external every cycle with internal-only-for-non-significant-CIs-not-consecutive — but THIS WAS ALSO WRONG (inverted polarity). v1.2 corrected to actual Article 26(8): financial entities MAY use internal testers, but must contract external testers every three tests; only credit institutions SIGNIFICANT under SSM Regulation Art 6(4) are restricted to external testers only"
      - "v1.0 omitted the 6-month duration cap on CTPP periodic penalty payments. v1.1 added it but cited the cap as 'Article 35(6)' — actually the trigger is 35(6), the 6-month cap is 35(7), and the 1% rate is 35(8). v1.2 has the paragraph attribution correct"
      - "v1.1 stated 'administrative penalties for infringements by CTPPs are imposed by NCAs under Article 50' — WRONG. Article 50 administrative penalties apply only to financial entities. CTPP enforcement runs exclusively through Articles 31–44 (Lead Overseer) + Article 35(6)–(8) periodic penalty payments. v1.2 has this corrected"
      - "v1.0/v1.1 listed 7 Article 18 classification criteria (treating reputation as separate). Actual Article 18(1) is 6 criteria (a)–(f); reputation is bundled into (a) with clients/transactions. v1.2 rewritten with verbatim 6-item list"
      - "v1.0/v1.1 Article 30(2) minimum-provisions list had 8 items and missed (d) data return on insolvency, (f) provider incident assistance, (i) security awareness participation; AND wrongly included (e) audit rights + (b) reporting obligations that are actually in Article 30(3). v1.2 rewritten with verbatim 9-item Art 30(2) list (a)–(i)"
      - "v1.0/v1.1 Article 30(3) CIF additional-provisions list missed (c) business contingency plans + ICT security measures. v1.2 rewritten with verbatim 6-item Art 30(3) list (a)–(f)"
      - "v1.0/v1.1 listed 'small insurance / reinsurance intermediaries' under Article 16 simplified framework. Actually they are FULLY OUT of DORA scope under Article 2(3) + recital 39. v1.2 corrected — Article 16 list now reads verbatim against Article 16(1) first subparagraph"
      - "v1.0/v1.1 IORP full-exclusion threshold cited as 'fewer than 15 members'. Actual Article 2(3)(c): 'not more than 15 members' (≤ 15). v1.2 corrected"
      - "v1.0/v1.1 microenterprise definition omitted the Article 3(60) carve-out-within-the-carve-out — trading venues, CCPs, trade repositories, and CSDs cannot qualify as microenterprises regardless of size. v1.2 added"
      - "v1.0/v1.1 cited 'CRD Article 67' for credit institution penalty hook; v1.1 corrected to Articles 65–67"
      - "v1.0/v1.1 implied a quantitative '3-of-4 yes = CTPP candidate' heuristic; v1.1 softened — actual designation is by the ESAs against Commission Delegated Regulation (EU) 2024/1502 criteria"
      - "v1.0/v1.1 NIS2 displacement framing oversimplified; v1.1 corrected — NIS2 Article 4(1) is obligation-level displacement, not blanket exemption; registration and CSIRT-cooperation duties may still bite via Member State transposition"
      - "v1.0/v1.1 Register of Information described as straight 'annual submission'. Actual Article 28(3): annual summary report (number of new arrangements, categories, types, services) + on-demand full Register + timely planned-CIF notification. v1.2 layered correctly; ITS template is the operational consolidation"
---

# EU MiCA, DORA, and AML Regulations: 2025 Deep Dive

## Source Summary

Research across InnReg, ESMA, EIOPA, DLA Piper, Mayer Brown, Lucinity, Anankai, and Norton Rose Fulbright covering the three most technically demanding EU fintech compliance frameworks.

---

## DORA — Digital Operational Resilience Act

### What It Is
EU regulation requiring all financial entities to withstand, respond to, and recover from ICT-related disruptions and cyberattacks. Entered force **January 17, 2025**.

### Who It Applies To
Banks, payment institutions, e-money institutions, investment firms, insurance companies, crypto-asset service providers, credit rating agencies, and — critically — their **critical third-party ICT providers** (cloud providers, data analytics firms, SaaS vendors).

### Five Pillars of Compliance

| Pillar | Requirement |
|--------|------------|
| ICT Risk Management | Documented risk frameworks; policies for threat identification, protection, detection, response, and recovery |
| Incident Reporting | Major incidents reported to competent authority within hours; standard classification criteria |
| Digital Resilience Testing | Basic testing for all; advanced Threat-Led Penetration Testing (TLPT) for significant entities |
| Third-Party Risk | Map all ICT vendor dependencies; renegotiate contracts to include DORA clauses; register critical providers |
| Information Sharing | Voluntary intelligence sharing about cyber threats with industry peers |

### Penalties
Up to **2% of total global annual turnover** for firms; up to **1% of average daily global turnover** per violation day for critical third parties.

### 2026 Outlook
Supervisors treated 2025 as a transition/review year. Stricter enforcement and formal audits expected throughout 2026. Fintechs with heavy third-party dependency (common model) face the highest DORA compliance lift.

---

## MiCA — Markets in Crypto-Assets Regulation

### What It Is
Single EU regulatory framework for crypto-asset service providers (CASPs) and issuers of crypto-assets (including stablecoins). Replaces the patchwork of 27 national regimes.

### Implementation Timeline

| Date | Event |
|------|-------|
| June 2023 | MiCA entered into force |
| June 2024 | Stablecoin provisions (ARTs, EMTs) applicable |
| December 2024 | CASP provisions fully applicable |
| January 2025 | Fully applicable in all EU member states |
| End 2025 | Spain transition deadline (12-month) |
| June 2026 | General transitional period ends; all CASPs must be licensed |

### Key Requirements for CASPs

- Obtain authorization from home-state National Competent Authority (NCA)
- Comply with AML/KYC including the Travel Rule for crypto transfers
- Meet capital and insurance requirements
- Publish whitepapers for crypto-assets offered
- Implement reserve requirements for stablecoin issuers
- Report market abuse to ESMA

### Compliance Status (Q1 2025)
- **65%** of EU-based crypto businesses MiCA-compliant
- Germany, France, Netherlands: **90%+** compliant
- Greece, Portugal, Ireland: only **50-60%** compliant
- **€540M+** in fines issued since implementation
- **50+** licenses revoked (primarily for AML/KYC or reserve requirement failures)

---

## EU AML Package — AMLR + AMLA

### The New Framework (Three-Part Package)

| Instrument | Role |
|-----------|------|
| **AMLR** (Anti-Money Laundering Regulation) | Single AML rulebook directly applicable across all EU member states (no national transposition needed) |
| **AMLD6** (6th AML Directive) | Governs national supervisory structures; replaces AMLD4/5 |
| **AMLA Regulation** | Establishes Anti-Money Laundering Authority as EU's central AML supervisor |

### Key Dates

- **July 2025**: AMLA commences operations in Frankfurt
- **2026**: Technical standards on CDD, risk classification, and transaction monitoring finalized
- **July 2027**: AMLR becomes directly applicable across all member states
- **2028**: AMLA takes over direct supervision of highest-risk cross-border financial institutions

### Expanded Scope for Fintechs
The AMLR extends AML obligations to previously unregulated entities:
- Crypto-asset service providers (aligned with MiCA CASP definition)
- Crowdfunding platforms
- Mortgage credit intermediaries
- Consumer credit lenders
- Certain luxury goods dealers and real estate agents

### Key AML Compliance Requirements (2025+)
- Automated transaction monitoring systems with AI support
- Transaction scoring and AML filters for sanctions lists
- PEP (Politically Exposed Person) monitoring
- Continuous operation analysis and unusual pattern detection
- Immediate reporting of suspicious activities (STRs)
- Travel Rule compliance for crypto transfers

### GDPR Tension
AMLA must balance effective data sharing with EU GDPR requirements. Effective AML supervision requires extensive cross-border data collection and analysis; GDPR imposes strict limits on personal data processing. Resolving this tension is a live governance challenge.

## Sources

- [DORA Regulation Explained](https://www.innreg.com/blog/dora-regulation-explained) — InnReg, 2025
- [MiCA: EU Crypto Compliance Guide](https://www.cyfrin.io/blog/mica-regulation-explained-a-guide-to-eu-crypto-compliance) — Cyfrin, 2025
- [EU AMLA Regulation Explained 2026](https://www.anankai.com/eu-anti-money-laundering-authority-amla-in-2026/) — Anankai, 2026
- [EU's New AML Package 2025](https://lucinity.com/blog/the-eus-new-aml-package-what-financial-institutions-need-to-know-for-2025) — Lucinity, 2025
- [MiCA Regulations Statistics 2025](https://coinlaw.io/eu-mica-regulations-statistics/) — CoinLaw, 2025

---

## Addendum — Internal MiCA Readiness Checklist (Ingested 2026-05-20, Re-ingested 2026-05-24 at v2.2)

**Source:** `.raw/InnBlockchain/EU Compliance/mica-checklist.md` (v2.3, hash `492b5075eb46fb2a8a156fbad9b758b0`, triple-checked 2026-05-25)
**Type:** Internal InnBlockchain practitioner artifact — pre-NCA-application readiness assessment, 13 sections, scorecard format, written from the perspective of "what a specialist EU crypto-reg lawyer walks a founder through in a first intake meeting."
**Why it lives here**: per ingest instruction, no separate source page; the operational detail it contributes is integrated into [[MiCA-NCA-Authorization-Mechanics]] (article-by-article) and [[MiCA-Regulation]] (strategic/positioning).

### Re-ingest Summary (v2.2 on 2026-05-24, triple-checked to v2.3 on 2026-05-25)

After the v1.0 ingest, the source checklist was put through two verification passes against the regulation text (via Wayback-archived EUR-Lex, since live EUR-Lex blocks automated fetches behind AWS WAF). The passes surfaced and corrected **10+ material errors** in v1.0 — several of which had propagated into wiki notes. The re-ingest updates [[MiCA-NCA-Authorization-Mechanics]] and [[MiCA-Regulation]] to track the corrected source. See `superseded_claims` in frontmatter for the specific corrections.

**Triple-check (v2.3, 2026-05-25):** the user downloaded `mica.html` (full text of Regulation (EU) 2023/1114, OJ L 150, 1.68 MB) into the same `.raw/InnBlockchain/EU Compliance/` folder. Used as an authoritative second source to cross-verify v2.2. 85+ specific claims — article numbers, monetary amounts, percentages, time periods, subsection mappings, Annex IV class breakdown — all verified verbatim. **One missing detail surfaced**: Article 49(6) ("redemption of e-money tokens shall not be subject to a fee") was not in the v2.2 EMT section. Added, plus expanded EMT redemption bullets to cover Article 49(3) par-value issuance, Article 49(4) par-value redemption mechanics, Article 49(5) white-paper disclosure, Article 49(6) no-fee rule. Hash updated `3283a568...` → `492b5075...`; source grew 796 → 800 lines.

### What the Checklist Adds (Beyond the 2025 Web Research)

Web research above is macro (timeline, penalties, compliance rate). The internal checklist is micro (article-level requirements, capital math, dossier contents). The two are complementary, not duplicative.

**Material integrated into [[MiCA-NCA-Authorization-Mechanics]] (v2.2):**

1. **Authorisation pathway** — Article 60 simplified-notification regime for banks, MiFID firms, EMIs, CSDs, UCITS/AIFMs, and market operators (40-working-day notification, not full authorisation). Critical Article 60(10) carve-out: these entities are exempt from Articles 62, 63, 64, 67, 83, 84 (no Annex IV class, no qualifying-holdings under MiCA).
2. **CASP capital class structure (Annex IV — corrected)** — cumulative classes: Class 1 €50k (execution, placing, transfer, RTO, advice, portfolio mgmt) / Class 2 €125k (+ custody, exchange for funds, exchange for crypto-assets) / Class 3 €150k (+ trading platform). Plus one-quarter prior-year overheads override. Plus Article 67(4) insurance-policy alternative.
3. **ART capital formula** — €350k or 2% of average reserve assets or 25% overheads, whichever is highest. Article 35(3) NCA discretion to require **up to 20% higher** (not 20–40% as v1 said). 3% factor for significant ARTs (Art 45(5)). No-interest rule (Art 40). Permanent redemption right at no fee (Art 39). Mandatory recovery plan (Art 46) and redemption plan (Art 47), both notifiable within 6 months of authorisation/white paper approval. Quarterly reporting if issue value > €100M (Art 22). Means-of-exchange cap at 1M tx/day AND €200M/day (Art 23).
4. **EMT prerequisite** — must be authorised as a credit institution or EMI (Art 48); CASP authorisation alone is insufficient. **The 30%/60% bank-deposit rule is for ARTs, not EMTs (v1 had this wrong)**. EMT reserve rules sit in Article 54 + EMD. EMT recovery/redemption plans per Article 55 (Art 46/47 *mutatis mutandis*, notified within 6 months).
5. **White paper exemptions** (Article 4(2)–(3)): <150 persons per Member State, <€1M / 12 months, qualified investors only, free distribution / DLT-reward / utility-in-operation / limited-network. ART and EMT white papers need prior NCA approval/review; Title II ones don't.
6. **Machine-readable white paper format** — required by Articles 6/19/51, but specific format and date are set by ESMA RTS / Commission Delegated Regulation, not by MiCA Level 1 (the "iXBRL by 23 December 2025" claim in v1 of the source was not in Level 1 and has been removed).
7. **Article 74 wind-down plan** — distinct from BCP, recovery, and redemption plans; mandatory dossier item; documents client-asset return and per-service-line cessation.
8. **Article 70(3) client fiat placement** — end-of-day-following-receipt at credit institution or central bank, segregated account. Banking relationship must exist pre-launch.
9. **Articles 34(10) and 68(7)–(8) ↔ DORA cross-reference** (not Article 66, which is conduct of business — v1 had this wrong). DORA readiness is assessed by the NCA as part of MiCA authorisation. One process, not two — at authorisation.
10. **Significance thresholds (Article 43(1) — corrected)** — seven criteria (not six); ≥3 triggers reclassification. Reserve threshold combined with value/market-cap at €5bn (v1 had it wrongly separated at €1bn). Missing v1 criteria added: (d) DMA gatekeeper, (g) cumulation. "7 Member States" was unsupported and removed. For significant EMTs, EBA supervision has a derogation (Art 117(5)) if non-euro-denominated with ≥80% local concentration.
11. **Service-specific obligations (Articles 75–82)** — fully expanded: custody (Art 75 register of positions, quarterly statement, loss liability capped at market value), trading platform (Art 76 — no own-account dealing, matched principal with consent, 24h DLT settlement, fee structure rules), exchange (Art 77), execution (Art 78 best execution), placing (Art 79), RTO (Art 80), advice/portfolio mgmt (Art 81 suitability + 2-year reassessment + quarterly portfolio statements + inducement restrictions + standard risk warnings), transfer (Art 82).
12. **Ongoing notifications post-authorisation** — management body changes (Arts 33/69), qualifying holdings ≥20%/30%/50% (Arts 41–42/83–84, except for Art 60 entities), cross-border passporting (Art 65 — 10 working days forwarding, 15 calendar days minimum before start).
13. **Significant CASP threshold (Article 85)** — ≥15M active users/year average. Different from ART/EMT significance.
14. **Enforcement exposure (Article 111 — corrected)** — six tiers of turnover caps: 3% (Title II), 12.5% (Title III ART), 12.5% (Title IV EMT), 5% (Title V CASP), 2% (Art 88), 15% (Arts 89–92). Disgorgement: 2× general / 3× market abuse.
15. **Application timeline** — 25 working days completeness check + 40+ working days substantive review; 6–12 months realistic total.
16. **Active NCA list** — AMF (FR), BaFin (DE), AFM (NL), CBI (IE), Bank of Lithuania.
17. **14-day right of withdrawal (Article 13)** — Title II crypto-assets bought retail directly from issuer (or CASP placing on its behalf); not applicable where asset already admitted to trading.
18. **2024 EU AML Package** — AMLR (Reg 2024/1624, applies 10 July 2027), AMLD6 (Dir 2024/1640, MS transposition 10 July 2027), AMLA Regulation (Reg 2024/1620, AMLA operational 1 July 2025, direct supervision from 1 January 2028). Until July 2027, national AML law transposing AMLD4/5 still applies.
19. **Product intervention (Articles 102–105)** — NCA, ESMA, EBA all have powers to prohibit/restrict crypto-assets or CASP activities; tail risk founders should design around.

### Tensions / Open Items After v2.2 Re-ingest

- The source is now anchored to verbatim regulation text where possible. Article numbers and percentages reconciled against the actual Article text. Disclaimers in the source flag that ESMA/EBA Level 2 and Level 3 technical standards continue to evolve.
- DORA: at-authorisation framing in MiCA Articles 34(10) / 68(7)–(8) does not displace independent DORA supervisory enforcement once operational (penalties up to 2% of turnover).
- Member State variation: Article 143(3) allows MS to shorten or disapply the transitional regime. The "1 July 2026" date is the latest possible end of the transitional period; some MS (e.g. Spain) have shorter periods.

---

## Addendum — Internal DORA Readiness Checklist (Ingested 2026-05-24 at v1.1; Re-verified 2026-05-25 at v1.2 against local EUR-Lex HTML)

**Source:** `.raw/InnBlockchain/EU Compliance/dora-checklist.md` (v1.1, hash `7846555f77db1b3eac861b5ab510385a`)
**Type:** Internal InnBlockchain practitioner artifact — DORA continuous-compliance readiness assessment, 13 sections, scorecard format, written from the perspective of "what a specialist EU ICT / financial-regulatory lawyer walks an in-scope entity through in a first intake meeting."
**Why it lives here**: filed under this combined MiCA-DORA-AML source page (not as a separate source) per the same convention used for the mica-checklist. The operational detail it contributes is integrated into the new practitioner concept page [[DORA-NCA-Supervision-Mechanics]] (article-by-article) and the strategic concept page [[DORA-Regulation]] (substantively updated to reflect the corrected penalty framing and CTPP-scope distinction).

### Structural delta vs. the MiCA checklist

DORA is **not an authorisation regime**. So the MiCA checklist's structure (applicability → classification → capital → white paper → application dossier) doesn't map. The DORA checklist restructures around DORA's **five pillars** (ICT risk management → incident reporting → resilience testing → third-party risk → information sharing) plus sectoral integration (MiCA, MiFID II, PSD3, NIS2). There is no equivalent of Section 5 (white paper), Section 10 (application process), or capital classes.

### Material integrated into [[DORA-NCA-Supervision-Mechanics]] (v1.1)

1. **Scope** (Article 2) — full 20-category list of financial entities, including DLT MTF/SS/TSS under the DLT Pilot Regime (Seg 1 RWA pathway not via MiCA).
2. **Exclusions** (Article 2(3)–(4)) — sub-threshold AIFMs, small Solvency II insurers, IORPs < 15 members fully out, microenterprise insurance intermediaries.
3. **Proportionality — Simplified Framework (Article 16)** — small/non-interconnected MiFID firms, exempt PIs (PSD2 Art 32), exempt EMIs (Dir 2009/110/EC Art 9), IORPs with 15–99 members, small insurance intermediaries. Detailed in Commission Delegated Regulation (EU) 2024/1774 Title II.
4. **CTPP regime is separate** (Articles 31–44) — vendors not financial entities; Lead Overseer = EBA/ESMA/EIOPA by sectoral mix; not ECB (a common misconception now corrected on [[DORA-Regulation]]).
5. **Pillar 1 — ICT Risk Management** (Articles 5–16) — board responsibility non-delegable (Art 5(2)), board knowledge requirement (Art 5(4)), digital operational resilience strategy (Art 6(8)), critical-or-important function identification (Art 8 — drives TLPT scope, contractual depth, exit-strategy depth).
6. **Pillar 2 — Incident reporting** (Articles 17–23) — classification per Commission Delegated Regulation (EU) 2024/1772 (seven criteria — clients affected, reputation, duration, geography, data losses, criticality, economic impact); three-report cadence (initial / intermediate / final) on harmonised templates; payment-related incidents absorbed from PSD2 Art 96 via DORA Art 23.
7. **Pillar 3 — TLPT** (Articles 26–27 + Commission Delegated Regulation (EU) 2025/295) — every 3 years for significant entities; live production systems; pooled / joint TLPT permitted; **default external testers every cycle** (Art 26(8)) with narrow internal-tester exception only for non-significant credit institutions and not in consecutive cycles (v1.0 of checklist had this wrong — corrected).
8. **Pillar 4 — Register of Information** (Article 28(3) + Commission Implementing Regulation (EU) 2024/2956 ITS) — annual NCA submission via the ITS template; ~14 sub-templates × ~50 fields per contract; under-budgeted by 3–5× by most entities.
9. **Pillar 4 — Article 30 contractual provisions** — minimum (Art 30(2): 8 items for all ICT contracts) + additional (Art 30(3): 7 more for CIF contracts) + sub-outsourcing per Article 30(5) RTS.
10. **Pillar 4 — Exit strategy** (Article 28(8)) — standalone artefact per CIF contract; data extraction + migration plan; periodic testing.
11. **Pillar 5 — Information sharing** (Article 45) — voluntary; NCA notification on entry/withdrawal; GDPR-compatible processing.
12. **CTPP penalty cap (Article 35(6))** — periodic penalty payments up to 1% of average daily worldwide turnover, per day, **for up to 6 months** (the 6-month duration cap was missing in v1.0). Separate Article 50 administrative penalties.
13. **Sectoral penalty hooks for financial entities** — MiCA Art 111 (3-15%), CRD Arts 65–67 (10%), MiFID II Art 70 (10%), PSD2 Art 103 (national), Solvency II (national). The frequently-cited "2% under DORA" for financial entities is a sectoral derivative, not a DORA Level 1 cap (corrected on [[DORA-Regulation]]).
14. **MiCA cross-reference** is to Articles **34(10) and 68(7)–(8)**, not Article 66 — same correction as the MiCA-NCA-Authorization-Mechanics page (Art 66 is conduct-of-business). At-authorisation is "one process"; post-authorisation is independent dual-track.
15. **NIS2 displacement** (Art 4(1)) — obligation-level, not blanket. Registration in national NIS2 registries and CSIRT cooperation may still bite via Member State transposition. Group-level non-financial entities may still fall directly under NIS2.
16. **Key Level 2 cross-reference map** — 8 instruments: Commission Delegated Regulations 2024/1502 (CTPP designation), 2024/1772 (incident classification), 2024/1773 (CIF contractual policies), 2024/1774 (risk management + simplified framework), 2025/295 (TLPT); Commission Implementing Regulation 2024/2956 (Register ITS); harmonised reporting RTS/ITS under Art 20; sub-outsourcing RTS under Art 30(5).

### Verification status (2026-05-25 update)

The 2026-05-24 ingest at v1.1 was built **without** a verbatim Regulation (EU) 2022/2554 cross-check — EUR-Lex direct URL blocked by AWS WAF JS challenge, Wayback fallback was not used. The 2026-05-25 verification pass closed that gap: user manually saved EUR-Lex HTML to `.raw/InnBlockchain/EU Compliance/dora.html` (749KB); defuddle yielded 2,695 lines clean markdown; systematic Article-by-Article cross-check surfaced **5 material errors + 4 precision issues in v1.1**, all corrected at v1.2. Notable: v1.1's "correction" of the Article 26(8) TLPT tester rule went 180° in the wrong direction — v1.0 was actually closer to correct. See `superseded_claims` in frontmatter for the full list. Two residual hedges remain: (i) **harmonised reporting RTS / ITS hour-counts** under Article 20 are practitioner reads, since timing has moved across drafts; (ii) **Level 2 RTS citations** (Delegated Regulations 2024/1502, 2024/1772, 2024/1773, 2024/1774, 2025/295, Implementing Regulation 2024/2956) are flagged as the most likely to drift. For any real filing, cross-validate against current ESMA / EBA / EIOPA publications and home-NCA-specific guidance.

### Why this matters for InnBlockchain client work

DORA is the second-most-frequently-misframed EU regulation (after MiCA-for-RWA). Three corrections this ingest baked into the wiki: (1) **CTPPs ≠ all SaaS vendors** — only formally-designated providers; (2) **Lead Overseer ≠ ECB** — Lead Overseer is EBA/ESMA/EIOPA by sectoral mix; (3) **2% penalty cap is sectoral**, not direct DORA — frame correctly in board materials. All three were misframed on the prior [[DORA-Regulation]] page and are now corrected. This matters for both ICPs: every CASP-classified Crypto Native segment (Seg 2-10) and every licensed FinTech segment is in DORA scope, and DORA compliance is *part of* the MiCA / sectoral authorisation dossier — InnBlockchain's smart-contract architecture work plugs into Pillar 1 (Art 9 protection), Pillar 2 (Art 18 classification via structured events), Pillar 3 (Art 25 basic testing battery), Pillar 4 (Art 28(8) exit strategies for protocol-layer dependencies).
