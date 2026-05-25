---
type: concept
title: "GDPR — General Data Protection Regulation"
created: 2026-05-25
updated: 2026-05-25
tags:
  - GDPR
  - EU
  - compliance
  - data-protection
  - privacy
  - fintech
status: current
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[DORA-Regulation]]"
  - "[[MiCA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[TFR-Regulation]]"
  - "[[EU-AI-Act-Fintech]]"
  - "[[eIDAS-2.0]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain Crypto Native ICP]]"
internal_sources:
  - path: ".raw/InnBlockchain/EU Compliance/gdpr-checklist.md"
    hash: "788d3da1aafbfcf1e273cc95b78475b8"
    version: "1.1"
    ingested_at: "2026-05-25"
  - path: ".raw/InnBlockchain/EU Compliance/gdpr.html"
    hash: "cf04d05903e5805ba9571dfb1d6fdb57"
    role: "verbatim verification artefact (EUR-Lex local copy of Regulation (EU) 2016/679)"
    ingested_at: "2026-05-25"
---

# GDPR — General Data Protection Regulation

GDPR (Regulation (EU) 2016/679) is the EU's universal horizontal regime for the protection of natural persons with regard to the processing of personal data. It **entered into force 24 May 2016** and **became applicable 25 May 2018** *(Article 99)*. Source: https://eur-lex.europa.eu/eli/reg/2016/679/oj

> [!warning] GDPR is the only genuinely universal horizontal EU regime
> Unlike MiCA, DORA, MiFID II, PSD3, or AMLR — which trigger only on regulated activity or entity type — GDPR applies to **any** processing of EU residents' personal data, regardless of whether the controller is in fintech, crypto, or even EU-established. The [[EU-Fintech-Compliance-Landscape]] Dependency Map places it in the "UNIVERSAL HORIZONTAL" tier deliberately — there are no entity-type carve-outs (only narrow material-scope exclusions for personal/household activity, criminal-law enforcement, and processing outside EU law).

> [!info] Practitioner detail
> Article-by-article checklist (material + territorial scope, role classification, lawful basis selection, Article 5 principles, controller obligations, DPIA / DPO triggers, breach notification, international transfers, penalty exposure, sectoral interactions) is in `.raw/InnBlockchain/EU Compliance/gdpr-checklist.md`. This concept page is the strategic / "what-is-GDPR" layer; the checklist is the NCA-/DPA-ready operational dossier.

## Who Must Comply (Article 3 — Territorial Scope)

GDPR has the broadest territorial reach of any EU regime. Three independent triggers:

| Trigger | Mechanic | Common fintech scenario |
|---|---|---|
| **Establishment (Art. 3(1))** | EU/EEA establishment of controller or processor; processing happens "in the context of" that establishment regardless of *where* processing physically occurs | EU-headquartered fintech with US data centre — still GDPR-bound |
| **Targeting (Art. 3(2)(a))** | Non-EU controller/processor offering goods or services (paid or free) to data subjects in the EU/EEA | US crypto exchange accepting EU customers; EUR deposits; EU-language UI |
| **Monitoring (Art. 3(2)(b))** | Non-EU controller/processor monitoring behaviour of data subjects in the EU/EEA | Web analytics, behavioural advertising, fraud monitoring targeting EU users |

Non-EU controllers triggered under Art. 3(2) must designate an **Article 27 representative** in a Member State where targeted data subjects sit, unless the narrow Art. 27(2) exception applies (occasional + not large-scale + no special-category/criminal data + unlikely risk).

> [!warning] "On-chain ≠ personal data" is wrong
> EDPB Guidelines 02/2025 on processing of personal data through blockchain technologies (adopted 14 April 2025) confirm that wallet addresses and transaction data linked to identified or identifiable persons are personal data and subject to GDPR. Pseudonymisation does **not** equal anonymisation — re-identifiability is the test (Recital 26). Smart-contract architectures that put personal data on-chain inherit Article 17 erasure-right exposure that immutability can't satisfy. Architectural mitigation: store personal data off-chain, anchor only hashes / commitments on-chain; design key destruction ("cryptographic erasure") as the Article 17 approximation.

## The Six Lawful Bases (Article 6(1))

Every processing activity must rest on at least one:

| Basis | Article | Fintech default usage |
|---|---|---|
| Consent | 6(1)(a) | Cookies, marketing, biometric KYC (paired with Art. 9(2)(a) explicit consent) |
| Contract necessity | 6(1)(b) | Onboarding to fulfil customer agreement |
| **Legal obligation** | 6(1)(c) | **KYC / CDD / STR / Travel Rule** under AMLR + AMLD6; tax reporting; sanctions screening |
| Vital interests | 6(1)(d) | Rare in fintech (life-or-death scenarios) |
| Public interest / official authority | 6(1)(e) | Public bodies only |
| Legitimate interests | 6(1)(f) | Fraud prevention, marketing to existing customers, network security |

> [!warning] KYC ≠ consent
> The most common structural error in fintech privacy notices is asking customers to "consent" to KYC processing. KYC is mandated by AMLR — it is a **legal obligation** under Art. 6(1)(c), not consent under Art. 6(1)(a). Stacking the wrong basis is a finding DPAs flag on first review and makes consent withdrawal create a false-positive operational fault (consent withdrawal does not stop mandatory CDD retention).

## Special Categories (Article 9) and Criminal-Conviction Data (Article 10)

Eight Art. 9(1) categories require an *additional* Art. 9(2) condition beyond Art. 6:
- Racial or ethnic origin; political opinions; religious or philosophical beliefs; trade union membership
- Genetic data; biometric data **for the purpose of uniquely identifying a natural person**; health data; sex life or sexual orientation

**Biometric KYC** (selfie + liveness, document-photo face-match) is the dominant Art. 9 trigger in fintech and crypto. The default Art. 9(2) condition for facial-recognition KYC is **(a) explicit consent**, separate from the Art. 6(1)(c) KYC obligation basis — and consent must be genuinely refusable (non-biometric KYC fallback required, or "consent" is invalid for being unfreely given).

**Sanctions / PEP / adverse-media screening** pulls Art. 10 criminal-conviction data; national authorisation regimes vary materially Member-State by Member-State.

## The Seven Principles (Article 5)

| Principle | Practical test |
|---|---|
| Lawfulness, fairness, transparency | Documented lawful basis + plain-language notices + no covert processing |
| Purpose limitation | Purposes specified, explicit, legitimate; no incompatible secondary use |
| Data minimisation | Adequate, relevant, limited to what is necessary; defaults reviewed |
| Accuracy | Inaccurate data erased or rectified without delay |
| Storage limitation | Retention schedule documented; AMLR 5-year retention for CDD records (Art. 77) interlocks here |
| Integrity and confidentiality | Article 32 security measures |
| **Accountability (Art. 5(2))** | Must be able to *demonstrate* compliance — not merely be compliant |

Article 5(2) accountability is what makes GDPR a paper-trail regime. **"Compliance without documentation = non-compliance"** in DPA practice.

## Structural Controller Obligations

| Obligation | Article | Trigger |
|---|---|---|
| Data protection by design + default | Art. 25 | Every controller |
| Records of processing activities (RoPA) | Art. 30 | Every controller / processor (the Art. 30(5) under-250 carve-out has three knock-outs — almost no fintech qualifies) |
| Data Protection Officer (DPO) | Arts. 37–39 | Public authority; core activities = regular and systematic monitoring on a large scale; core activities = large-scale special-category or criminal-conviction data |
| DPIA + prior consultation | Arts. 35–36 | High-risk processing; three mandatory cases at Art. 35(3) — automated profiling with legal effects, large-scale Art. 9 / Art. 10 data, systematic large-scale monitoring of publicly accessible area |
| Article 27 representative | Art. 27 | Non-EU controller under Art. 3(2) |

## Data Subject Rights (Articles 12–22)

Eight enforceable rights, **one-month** response window (extendable by two months for complex requests):

- Right to information (Arts. 13, 14)
- Right of access (Art. 15) — DSAR
- Right to rectification (Art. 16)
- **Right to erasure / "right to be forgotten" (Art. 17)** — six grounds, five exceptions; on-chain personal data needs an architectural plan
- Right to restriction of processing (Art. 18)
- Right to data portability (Art. 20)
- Right to object (Art. 21) — absolute right against direct-marketing processing
- **Right not to be subject to solely automated decisions (Art. 22)** — credit scoring, fraud blocking, on-chain agent decisions all trigger; safeguards required

## Security & Breach Notification (Articles 32–34)

| Article | Mechanic |
|---|---|
| Art. 32 | Appropriate technical and organisational measures (TOMs) — risk-based, principles-based, no checklist |
| **Art. 33(1)** | **72-hour breach notification to lead DPA** from awareness, unless "unlikely to result in a risk to the rights and freedoms of natural persons" |
| Art. 33(5) | Internal breach register — continuous |
| Art. 34 | Communication to affected data subjects without undue delay where **high risk** to rights and freedoms |

DORA-bound entities should integrate breach taxonomy across GDPR Art. 33 + DORA Art. 19 + NIS2 — a single incident can trigger up to four separate notifications.

## International Transfers (Articles 44–50)

Every transfer of personal data from EU/EEA to a third country needs a Chapter V mechanism. Schrems II (CJEU C-311/18) means even valid mechanisms now require a **Transfer Impact Assessment (TIA)**:

- **Adequacy decisions (Art. 45)**: UK, Switzerland, Andorra, Argentina, Canada (commercial), Faroe Is., Guernsey, Israel, Isle of Man, Japan, Jersey, NZ, Korea, US (DPF participants only), Uruguay
- **Standard Contractual Clauses (Art. 46)**: Commission Implementing Decision (EU) 2021/914 (international transfers) and (EU) 2021/915 (intra-EU controller→processor)
- **Binding Corporate Rules (Art. 47)**, codes of conduct, certification mechanisms with binding commitments
- **Derogations (Art. 49)** — narrow, exceptional, not for routine flows

**EU–US Data Privacy Framework (DPF)** restored adequacy for self-certified US importers from July 2023 but is under active legal challenge (Schrems III pending). Keep SCC fallbacks pre-signed.

## Penalties (Article 83)

Two-tier administrative-fine regime, **whichever is higher**:

| Tier | Ceiling | Covered |
|---|---|---|
| **Tier 1 (Art. 83(4))** | €10 million or **2% of total worldwide annual turnover** | Articles 8, 11, 25–39, 42, 43 (controller / processor / certification-body / monitoring-body obligations) |
| **Tier 2 (Art. 83(5))** | €20 million or **4% of total worldwide annual turnover** | Articles 5, 6, 7, 9 (principles); 12–22 (rights); 44–49 (transfers); Member-State law under Chapter IX; non-compliance with Art. 58(2) DPA orders |

Headline enforcement: Meta €1.2bn (DPC, 2023, international transfers), Amazon €746m (CNPD, 2021), WhatsApp €225m (DPC, 2021, transparency), Google €50m (CNIL, 2019, consent). Crypto-specific enforcement so far has been DPA-level rather than headline, but **on-chain personal data on immutable ledgers is the next likely enforcement frontier** (EDPB Guidelines 02/2025 signals it).

## Interaction with Other EU Regimes

| Pair | Tension point | Resolution |
|---|---|---|
| **GDPR ↔ AML/AMLA** | AMLR mandates extensive cross-border data sharing; GDPR data minimisation pushes the other way | Rely on Art. 6(1)(c) for KYC processing; Art. 49(1)(d) for EU-law-mandated transfers; retain 5 years per AMLR Art. 77 then delete |
| **GDPR ↔ EU AI Act** | DPIA (Art. 35) and FRIA (AI Act Art. 27) overlap; Art. 22 GDPR and AI Act Art. 26 both bear on automated decisions | Combine DPIA + FRIA into single assessment; EDPB Opinion 28/2024 (on AI models, adopted 18 Dec 2024) is the reference document |
| **GDPR ↔ DORA** | DORA Pillar 1 ICT-risk-management framework = evidence of Art. 32 security for in-scope ICT estate (but DORA covers more than personal data, and Art. 32 covers more than ICT) | Use DORA artefacts as evidence; do not assume DORA covers all GDPR security |
| **GDPR ↔ MiCA / TFR** | Wallet addresses tied to KYC are personal data; on-chain immutability conflicts with Art. 17 erasure | EDPB Guidelines 02/2025; off-chain personal data + on-chain hash anchoring; cryptographic erasure as erasure approximation |
| **GDPR ↔ eIDAS 2.0** | EUDI Wallet as relying party — what attributes can be requested? | Selective disclosure (cryptographic); accept only attributes strictly necessary for the KYC use case |

## Compliance Gaps Common to Fintech / Crypto

1. **Wrong lawful basis stack** — consent used where legal obligation is the correct basis (KYC, AML)
2. **Pseudonymisation treated as anonymisation** — wallet metadata, hashed identifiers, tokenised IDs are still personal data
3. **Missing Art. 27 representative** — non-EU controllers serving EU customers without designating one
4. **DPIA gap** — credit scoring, biometric KYC, fraud detection deployed without documented DPIA + FRIA
5. **DPO independence failure** — DPO doubling as Head of IT, CISO, or CEO (CJEU C-453/21 *X-FAB Dresden* — conflict-of-interest enforcement live since 2023)
6. **On-chain personal data baked into protocol** — Article 17 erasure infeasible by architecture
7. **Transfer mechanism gap** — SaaS sub-processors in third countries without SCCs or TIA
8. **Breach notification under-classification** — taxonomy not aligned across GDPR / DORA / NIS2; risk of late or missed Art. 33 notification

## Supervisory Architecture

- **National Data Protection Authority (DPA)** of the main establishment is the **lead supervisory authority** for cross-border processing (Art. 56)
- **European Data Protection Board (EDPB)** coordinates DPAs via the consistency mechanism (Arts. 63–67) and issues binding Art. 65 decisions
- Non-EU controllers under Art. 3(2) **do not have a lead DPA** under one-stop-shop — every DPA where targeted data subjects sit can act independently against them
- Common lead DPAs for fintech: **Ireland (DPC)** for Dublin-headquartered global SaaS; **France (CNIL)**; **Germany (BfDI + 16 state DPAs with federal coordination layer)**; **Italy (Garante)**; **Spain (AEPD)**

## EDPB Document Stack (Reference)

| Instrument | Subject |
|---|---|
| EDPB Guidelines 3/2018 | Territorial scope (Art. 3) |
| EDPB Guidelines 4/2017 (WP248 rev.01) | DPIA (Art. 35) |
| EDPB Guidelines 05/2020 | Consent (Art. 6(1)(a), 7) |
| EDPB Guidelines 07/2020 | Controller / processor / joint controller (Arts. 4(7), 4(8), 26, 28) |
| EDPB Guidelines 2/2019 | Lawful basis for online services (Art. 6(1)(b)) |
| EDPB Guidelines 01/2022 | Right of access (Art. 15) |
| EDPB Guidelines 9/2022 | Personal data breach notification (Arts. 33, 34) |
| EDPB Guidelines 8/2022 | Lead supervisory authority (Art. 56) |
| EDPB Guidelines 04/2022 | Calculation of administrative fines (Art. 83) |
| EDPB Recommendations 01/2020 | Supplementary measures for international transfers |
| **EDPB Guidelines 02/2025** | **Processing of personal data through blockchain technologies (adopted 14 April 2025)** |
| **EDPB Opinion 28/2024** | **AI models (adopted 18 December 2024)** — relevant to GDPR ↔ AI Act interaction |
| Commission Impl. Decision (EU) 2021/914 | SCCs for international transfers |
| Commission Impl. Decision (EU) 2021/915 | SCCs for intra-EU controller-to-processor |
| CNIL "Blockchain and the GDPR" (29 Oct 2018) | Older but still-cited national guidance |

## InnBlockchain Relevance

GDPR is the foundational layer under every other InnBlockchain EU regulatory motion. Three sales-relevant angles:

1. **Architecture-grade GDPR**: On-chain personal-data design is the InnBlockchain wedge — off-chain personal data + on-chain hash anchoring + cryptographic erasure is a smart-contract architecture decision, not a privacy-policy edit. Bake it in at the SPV / token design stage, not at DSAR stage.
2. **DPIA + FRIA convergence**: For LendTech (credit scoring), RegTech (fraud detection AI), Crypto Native Seg 3 (DeFi lending), Seg 10 (AI×Crypto) — combined GDPR Art. 35 + AI Act Art. 27 assessment is a packaged deliverable.
3. **Breach taxonomy integration**: Unifying GDPR Art. 33 + DORA Art. 19 + NIS2 incident-reporting taxonomies is the operational fix for licensed FinTechs (BankTech, PayTech, WealthTech, ExchangeTech) — heavy compliance-Carol wedge.

See `.raw/InnBlockchain/EU Compliance/gdpr-checklist.md` for the article-by-article practitioner dossier and InnBlockchain service-mapping table.

## See Also

[[EU-Fintech-Compliance-Landscape]] | [[DORA-Regulation]] | [[DORA-NCA-Supervision-Mechanics]] | [[MiCA-Regulation]] | [[EU-AML-AMLA]] | [[EU-AI-Act-Fintech]] | [[eIDAS-2.0]] | [[DLT-Pilot-Regime]] | [[InnBlockchain FinTech ICP]] | [[InnBlockchain Crypto Native ICP]]
