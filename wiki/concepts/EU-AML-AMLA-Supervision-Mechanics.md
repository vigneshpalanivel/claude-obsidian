---
type: concept
title: "EU AML / AMLA — Supervision Mechanics (Practitioner Detail)"
created: 2026-05-25
updated: 2026-05-25
tags:
  - AML
  - AMLA
  - AMLR
  - AMLD6
  - EU
  - compliance
  - KYC
  - CDD
  - practitioner
  - supervision
status: current
related:
  - "[[EU-AML-AMLA]]"
  - "[[DORA-NCA-Supervision-Mechanics]]"
  - "[[MiCA-NCA-Authorization-Mechanics]]"
  - "[[MiFID-II-NCA-Authorization-Mechanics]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[eIDAS-2.0]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain Crypto Native ICP]]"
---

# EU AML / AMLA — Supervision Mechanics (Practitioner Detail)

The article-level requirements an EU AML/CFT specialist walks an obliged entity through at first intake. Companion to [[EU-AML-AMLA]] (which holds the strategic / "what-is-the-package" framing). Sourced from `.raw/InnBlockchain/EU Compliance/aml-checklist.md` (v1.1, hash `8c54e67252d695780a923ff99c2bd3df`). Every article reference below is verbatim-verified against the EUR-Lex CONVEX XHTML texts of AMLR (Reg 2024/1624), AMLD6 (Dir 2024/1640), and AMLA Regulation (Reg 2024/1620) downloaded into `.raw/InnBlockchain/EU Compliance/`.

> [!info] When to read this page
> Read this when you're scoping or executing an AML/CFT compliance buildout — Article 3 obliged-entity classification, CDD trigger granularity, beneficial-ownership tracks, STR mechanics, sanctions exposure, and the two-stage AMLA selection question. For the *what-is-the-AML-package / who's-affected* question, start at [[EU-AML-AMLA]].

> [!warning] Three coupled instruments doing three different jobs
> **AMLR (Reg 2024/1624)** tells you *what to do* — directly applicable, no national transposition. **AMLD6 (Dir 2024/1640)** tells you *how you'll be sanctioned and who supervises you* — lives in each Member State's transposed law. **AMLA Regulation (Reg 2024/1620)** creates the EU supervisor in Frankfurt — but AMLA *directly supervises* only a narrow set of large cross-border banks and CASPs ("selected obliged entities" under Art. 13). For most obliged entities, AMLA matters only indirectly via RTS/ITS flowing through the national supervisor.

> [!warning] AMLR application date is 10 July 2027 — but the obliged-entity perimeter is locked now
> The substantive obligations bite on 10 July 2027. Gap analyses, system buildouts, and group-policy re-papering need to start in 2026 — the operational lift on CDD/BO/STR systems is 12–18 months for most credit institutions and CASPs. Football agents and clubs (Art. 3(3)(n) and (o)) get a built-in 2-year delay to **10 July 2029** under Art. 90.

## Obliged-Entity Scope — AMLR Article 3

Article 3 is the gating article. The verbatim enumeration (17 categories):

**Credit and financial institutions** *(Art. 3(1)–(2))*:
- Credit institutions (CRR-defined)
- Financial institutions (CRR-defined residual category — captures PIs, EMIs, investment firms, AIFMs, UCITS ManCos, life insurers, **CASPs**)

**Non-financial professional categories** *(Art. 3(3)(a)–(o))*:
- (a) Auditors, external accountants, tax advisors, tax-advisory legal professionals
- (b) Notaries, lawyers, independent legal professionals — when participating in specified financial / real-estate / business-formation contexts (incl. crypto-asset transactions)
- (c) Trust or company service providers (TCSPs)
- (d) Real estate agents — including letting where monthly rent ≥**€10,000**
- (e) Dealers in precious metals and stones (regular professional activity)
- (f) Dealers in high-value goods (regular professional activity)
- (g) Providers of gambling services
- (h) Crowdfunding service providers (ECSP-licensed) + crowdfunding intermediaries
- (i) Traders/intermediaries in **cultural goods** for transactions ≥€10,000 (art galleries, auction houses)
- (j) Traders/intermediaries in cultural and high-value goods **within free zones or customs warehouses**, transactions ≥€10,000
- (k) **Credit intermediaries for mortgage and consumer credits** (with carve-out for intermediaries acting under creditor responsibility)
- (l) **Investment migration operators** *(new category — "golden visa" intermediaries)*
- (m) **Non-financial mixed activity holding companies** *(new category)*
- (n) **Football agents** *(new category — application delayed to 10 Jul 2029 per Art. 90)*
- (o) **Professional football clubs** *(new category — for transactions with investors, sponsors, agents, and player transfers; application delayed to 10 Jul 2029 per Art. 90)*

> [!warning] No RegTech / SaaS vendor category
> There is **no "RegTech vendor" or "SaaS provider" obliged-entity category in Art. 3**. Pure technology vendors to obliged entities are NOT themselves obliged entities. Their AML exposure flows through their FI customers' Art. 3 obligations, not through their own status.

## Member State Exemptions — AMLR Articles 4–7

AMLR has three narrow Member State exemption articles, all subject to Commission notification + 2-month confirmation under Art. 7:

- **Art. 4 — Gambling services**: Member States may exempt providers (in full / in part) on proven low risk + risk assessment. **Cannot exempt**: casinos; online gambling or sports betting as principal activity (except state-operated / state-regulated online gambling).
- **Art. 5 — Professional football clubs**: Member States may exempt top-division clubs with **annual turnover <€5 million** in each of the previous 2 years, or lower-division clubs, on proven low risk + risk assessment.
- **Art. 6 — Occasional / very limited financial activity**: Member States may exempt persons engaged in a CRD Annex I activity (points (2)–(12), (14), (15)) where ALL six criteria of Art. 6(1) are met (limited in absolute + per-transaction terms, not main, ancillary, restricted customer base, main activity not in Art. 3(3)(a)–(d) or (g)). **Money remittance (PSD2 Art. 4(22)) cannot be exempted.**
- **Art. 7 — Notification regime**: All exemptions must be notified to Commission with risk-assessment justification; Commission has 2 months to confirm or block. Legacy AMLD5 exemptions in place on 10 July 2027 must be re-notified by **10 October 2027**.

## AMLR Substantive Obligations

### Internal organisation, compliance manager + officer (Articles 9–16)

- **Compliance manager *(Art. 11(1))*** — designated member of the management body in its management function; responsible for ensuring the obliged entity complies with AMLR + TFR + supervisor administrative acts; ensures policies are consistent with risk exposure and adequately resourced
- **Compliance officer *(Art. 11(2))*** — appointed by the management body, **sufficiently high hierarchical standing**; day-to-day implementation of AML/CFT requirements including targeted financial sanctions; contact point for competent authorities; **personally signs STRs to the FIU per Art. 69(6)**
- Compliance officer removal: requires prior notification to the management body + supervisor notification
- Group-wide policies *(Art. 16)* — enforced across all subsidiaries including third-country branches/subsidiaries; group-wide CDD + risk information sharing with documented GDPR-compatible legal basis
- Training programme *(Art. 12)* — periodic, role-specific, documented, knowledge-tested
- Outsourcing controls *(Art. 14)* — written agreements + supervisor notification; ultimate accountability stays with the obliged entity

> [!warning] Compliance manager ≠ compliance officer
> The split is new under AMLR — AMLD5 conflated the two roles in most Member States. Art. 11(1) is the *board-level* sponsor; Art. 11(2) is the *operational* head of AML/CFT. The compliance officer is the named natural person who signs STRs under Art. 69(6). Misalignment between job titles, role descriptions, and the AMLR functions is the single most common finding in 2026 gap analyses.

### CDD Triggers (Article 19) — paragraph-by-paragraph

CDD must be applied when:

- *Art. 19(1)(a)* — Establishing a business relationship
- *Art. 19(1)(b)* — Occasional transaction ≥**€10,000** (single or linked)
- *Art. 19(1)(c)* — Participating in the creation of a legal entity, setting up of a legal arrangement, or (for **accountants / lawyers / TCSPs** per Art. 3(3)(a)(b)(c)) transfer of ownership of a legal entity — **regardless of transaction value**
- *Art. 19(1)(d)* — Suspicion of ML/TF, regardless of any derogation, exemption, or threshold
- *Art. 19(1)(e)* — Doubts about veracity / adequacy of previously obtained customer identification data
- *Art. 19(1)(f)* — Doubts whether the person interacted with is the customer or authorised person
- *Art. 19(2)* — For credit institutions and financial institutions **EXCEPT CASPs**: initiating/executing an occasional transfer of funds (per TFR Art. 3(9)) ≥**€1,000**
- *Art. 19(3)(a)* — **For CASPs only**: occasional transaction ≥**€1,000** (full CDD)
- *Art. 19(3)(b)* — For CASPs on occasional transactions <€1,000: at least Art. 20(1)(a) identification
- *Art. 19(4)* — All obliged entities: occasional **cash** transaction ≥**€3,000** triggers at least Art. 20(1)(a) identification (suspended where the Member State has an Art. 80 cash limit ≤€3,000)
- *Art. 19(5)* — Gambling providers: at collection of winnings / wagering of stake / both, when transactions ≥**€2,000**
- *Art. 19(7)* — Supervisor exemption for low-risk electronic money (non-reloadable ≤€150 + further risk-mitigating conditions)

> [!info] Full CDD vs minimum CDD
> Art. 19 distinguishes full-CDD triggers (paragraph 1, all measures under Art. 20) from minimum-CDD triggers (Art. 20(1)(a) identification only — paragraphs 3(b), 4, and the e-money case in 7). Design the onboarding flow to distinguish full-CDD entry points from identification-only entry points.

### CDD Measures (Article 20)

All nine measures must be applied, proportionate to risk:

- *(a)* Identify + verify the customer's identity using independent, reliable source data
- *(b)* Identify beneficial owners + take reasonable verification measures (per Chapter IV — see below)
- *(c)* Assess and document the purpose and intended nature of the business relationship or occasional transaction
- *(d)* **Sanctions screening** of customer AND beneficial owners; for legal-entity customers, also check whether sanctioned persons **control** the entity, hold **>50% proprietary rights**, or **majority interest** (individually or collectively)
- *(e)* Assess and obtain information on the nature of customer's business (incl. employment / occupation for natural persons)
- *(f)* Ongoing monitoring + transaction scrutiny against customer's known profile; source of funds where necessary
- *(g)* **PEP determination** for customer, beneficial owner, and any person on whose behalf a transaction is being carried out
- *(h)* Where a transaction is carried out on behalf of natural persons other than the customer — identify + verify those persons
- *(i)* Verify that any person purporting to act on behalf of the customer is authorised

The **EUDI Wallet** must be accepted as an identification means under eIDAS 2.0 from **31 December 2026** (cross-regime obligation — see [[eIDAS-2.0]]).

### Simplified and Enhanced CDD (Articles 33–46)

**Simplified CDD (SDD)** — allowed only in lower-risk situations per AMLR risk assessment + AMLA RTS. Does NOT exempt customer identification (reduces verification depth + frequency only).

**Enhanced CDD (EDD)** triggers *(Art. 34 and adjacent)*:
- High-risk third countries (Commission delegated list)
- PEPs (domestic + foreign + family + close associates); PEP status + EDD continues **≥12 months** after the person leaves the prominent public function
- Correspondent banking with third-country institutions
- **Correspondent relationships with third-country CASPs** *(new EDD trigger under AMLR — no equivalent in AMLD5)*
- High-risk customer / product / geography combinations from entity's own risk assessment
- Unusually complex or large transactions without apparent economic / lawful purpose

EDD measures: additional info on customer/BO/source of funds/wealth; **senior management approval** to establish or continue the relationship; enhanced ongoing monitoring; additional BO identification and verification; independent corroboration.

### Beneficial Ownership (Chapter IV, Articles 51–63)

Two parallel identification tracks must be assessed for every legal-entity customer *(Art. 51)*:

- **Ownership track *(Art. 52)*** — natural person holding **≥25%** of shares, voting rights, profit participation rights, OR liquidation rights. Threshold change from ">25%" (AMLD5) to "**≥25%**" (AMLR). Indirect ownership calculated by multiplying through the entity chain and adding across chains.
- **Control track *(Art. 53)*** — natural person exercising **decisive influence** through formal or informal agreements, voting arrangements, shareholder agreements, or other means. Control = *possibility* to exercise influence, not actual exercise.

Where no UBO is identifiable under either track: **senior managing official(s)** recorded as fallback *(Art. 63 area)*.

Special rule for **collective investment undertakings (CIUs)** *(Art. 61)*.

**Future-state**: Commission may adopt delegated act under Art. 52(2) by **10 July 2029** lowering the threshold to **15%** (maximum) for higher-risk entity categories.

### Suspicious Transaction Reporting (Chapter V, Articles 69–76)

- *Art. 69(1)* — STR submitted to FIU for every suspicion of ML/TF, including **attempted transactions** and suspicions arising from inability to complete CDD (Art. 21)
- *Art. 69(6)* — Compliance officer per Art. 11(2) is the named natural person who transmits the STR
- *Art. 69* (third subparagraph) — FIU information requests answered within **5 working days**; **<24 hours** in justified urgent cases; FIU may also **extend beyond 5 days** if justified and not undermining FIU analysis
- *Art. 69(3)* — AMLA to develop ITS specifying STR format by **10 July 2026** (draft submission to Commission)
- *Art. 75* — Refrain from executing suspicious transactions where possible (unless executing serves law enforcement)
- *Art. 76* — **Tipping-off prohibition** — no disclosure to customer or third parties that an STR has been filed or is being prepared

> [!warning] Tipping-off is a personal criminal offence in most Member States
> Common operational failure: relationship managers asking the customer "is there an explanation for this transaction" *after* STR filing as part of "relationship management." That's tipping-off. Build the prohibition into customer-contact policy at the technical level — lock customer-facing comms on accounts with active STR analysis.

### Record Retention (Article 77)

Four record categories retained for **5 years**:

- *(a)* CDD documents + information obtained under Chapter III (including via electronic identification means)
- *(b)* Records of suspicion assessments under Art. 69(2) (whether or not resulting in STR) + copies of any STRs filed
- *(c)* Supporting evidence + transaction records (originals or judicially admissible copies)
- *(d)* Information-sharing partnership records where the entity participates in such partnerships

Records **shall not be redacted**. Obliged entities may retain *references* instead of *copies* under Art. 77(2) derogation, provided the information can be provided immediately to competent authorities on request and cannot be altered. Competent authorities may require an additional **5-year extension** on a case-by-case basis for AML/CFT investigations.

### Cash Payment Limit (Article 80)

- *Art. 80(1)* — EU-wide cap: **€10,000** (single or linked) for persons trading in goods or providing services
- *Art. 80(2)* — Member States may adopt lower limits following ECB consultation; notified to Commission within 3 months
- *Art. 80(3)* — Pre-existing lower limits preserved if notified to Commission by **10 October 2024**
- *Art. 80(4)* — Exclusions: (a) payments between natural persons not acting professionally; (b) payments/deposits at credit institutions, EMIs (per Dir 2009/110/EC), or PSPs (per PSD2). **Above-threshold deposits at (b) entities MUST be reported to the FIU** within FIU-imposed deadlines.
- *Art. 80(5)–(6)* — Member States enforce via penalties proportionate to seriousness
- *Art. 80(7)* — Force majeure suspension where non-cash payment means become unavailable nationally; Commission notified; Commission may order immediate lifting if unjustified

> [!warning] €10,000 prohibition ≠ €3,000 CDD trigger
> The €10,000 in Art. 80 is the *prohibition* threshold. The €3,000 in Art. 19(4) is the *CDD identification* trigger for cash transactions. Don't confuse the two when training cashiers and tellers. The €3,000 trigger is suspended where the Member State has a cash prohibition limit ≤€3,000.

## AMLD6 — Enforcement Architecture

### Transposition Phasing (Article 78)

- **General deadline: 10 July 2027** (Art. 78(1) first subparagraph)
- **Art. 74** (Amendments to Dir 2015/849, including new BO register access regime with "legitimate interest" framework): **10 July 2025**
- **Arts 11, 12, 13, 15** (BO register infrastructure): **10 July 2026**
- **Art. 18** (Single access point to real estate information): **10 July 2029**

Entry into force per *Art. 79*: 9 July 2024 (20 days after OJ publication on 19 June 2024).

### Pecuniary Sanctions (Article 55)

Member States must impose pecuniary sanctions on obliged entities for serious, repeated, or systematic breaches (intentional or negligent) of:
- AMLR **Chapter II** (Internal policies, procedures and controls)
- AMLR **Chapter III** (Customer due diligence)
- AMLR **Chapter V** (Reporting obligations)
- AMLR **Article 77** (Record retention)

Plus where the obliged entity fails to comply with Art. 56 administrative measures, or for non-serious / non-systematic breaches *(Art. 55(1))*.

| Sanction tier | Maximum | Article |
|---|---|---|
| **General floor** (all obliged entities) | At least **twice the benefit derived** from the breach OR **€1 million** (whichever higher) | Art. 55(2) |
| **Credit / financial institutions — legal persons** | At least **€10 million** OR **10% of total annual turnover** (whichever higher) | Art. 55(3)(a) |
| **Credit / financial institutions — natural persons** (e.g. compliance officer, board members) | At least **€5 million** | Art. 55(3)(b) |

Currency conversion reference date for non-euro Member States: **9 July 2024**.

> [!warning] Sanction breach scope is explicitly limited
> Art. 55 sanctions apply ONLY to breaches of AMLR Chapters II, III, V and Art. 77. Breaches of other AMLR articles (e.g. Art. 80 cash limit) flow via Art. 56 administrative measures + Art. 55(1) catch-all, not the headline Art. 55(3) caps. Verify your specific national transposition before quoting numbers — Member States may go above the floor.

### Administrative Measures (Article 56)

Available alongside or in lieu of Art. 55 pecuniary sanctions, for breaches, weaknesses likely to lead to breaches, or disproportionate internal controls:

- *Art. 56(2)(a)* — Recommendations
- *Art. 56(2)(b)* — Compliance orders, including specific corrective measures
- *Art. 56(2)(c)* — Public statements identifying the person + breach nature
- *Art. 56(2)(d)* — Cease-and-desist orders
- *Art. 56(2)(e)* — Restrict / limit business, operations, or network; or require divestment
- *Art. 56(2)(f)* — Withdraw / suspend authorisation (where the obliged entity holds one)
- *Art. 56(2)(g)* — Require changes in governance structure
- *Art. 56(3)* — Data submission requirements, policy reinforcement, customer- or product-specific requirements, temporary management bans

### National Supervisor Architecture

- *Art. 40* — Risk-based supervision (national supervisors apply a risk-based approach to AML/CFT supervision)
- *Art. 41* — Central contact points
- *Art. 42* — Disclosure to FIUs
- *Art. 50* — AML/CFT supervisory colleges in the non-financial sector
- *Art. 52* — Oversight of self-regulatory bodies
- *Art. 67* — Professional secrecy requirements

National supervisor = typically the same NCA that authorises the sectoral business (ECB / national central bank / BaFin / AMF / CSSF / CNMV / CBI / etc.). For credit institutions, prudential and AML supervisors are often co-located but legally distinct. AMLA coordination expectation increases from 2026 onward, well before the AMLA direct-supervision start date.

### Beneficial Ownership Registers

- **Arts 11–13, 15** (BO register infrastructure) — transposition by **10 July 2026**
- **Art. 74** (Amendments to Dir 2015/849 with the post-CJEU register-access regime) — transposition by **10 July 2025**

Access rules post-CJEU Joined Cases C-37/20 + C-601/20 (*Sovim / WM*, 2022):
- Competent authorities + FIUs: unrestricted access
- Obliged entities for CDD purposes: access on AMLR Art. 20 basis
- **General public**: NO general/automatic public access (CJEU disproportionality ruling)
- **Persons with legitimate interest**: explicit codified access — journalists, civil society, academic researchers, counterparties to transactions

> [!warning] Legitimate-interest access is the most-litigated piece of AMLD6 transposition
> Member States have diverged sharply — some require journalist credentialling + national-authority approval; others operate a broad presumption. If you are an obliged entity relying on national BO registers for CDD, your access path is the **AMLR Art. 20 basis (CDD purpose)** — different procedural rules from the legitimate-interest path. The legitimate-interest path matters for journalists, NGOs, and academic counterparties asking the obliged entity to verify BO data they have obtained independently.

### Single Access Point to Real Estate Information (Article 18)

New under AMLD6 — transposition by **10 July 2029**. Member States must establish a single electronic access point (digital, machine-readable where possible) giving competent authorities + AMLA immediate free access to:

- Property data (cadastral parcel + reference, geographic location, area/size, property type)
- Ownership data (owner identity including legal-entity ownership)
- Transaction history

Material for real estate agents, lawyers/notaries in property deals, and AMLA's joint-analysis access under Art. 32 AMLD6 / Art. 40 AMLA Regulation.

## AMLA Direct Supervision — Two-Stage Selection Mechanism

> [!warning] The ≥6 Member States criterion is in Art. 12, NOT Art. 13
> Common misframe in 2025–2026 summaries. Art. 12(1) sets *assessment* eligibility (≥6 Member States); Art. 13 sets *selection* from the assessed pool. The two are sequential, not unitary.

### Stage 1 — Assessment Eligibility (Article 12)

AMLA conducts a periodic assessment of credit institutions and financial institutions (and groups) that:

- Operate, through establishments or under the freedom to provide services, **in at least six Member States, including the home Member State** *(Art. 12(1) verbatim)*, regardless of whether activities are carried out through physical infrastructure or remotely

Risk profile is classified as **low / medium / substantial / high** based on benchmarks in the Art. 12(7) RTS. Methodology applied **separately to each of 11 obliged-entity categories** *(Art. 12(4))*:

(a) credit institutions · (b) bureaux de change · (c) collective investment undertakings · (d) credit providers other than credit institutions · (e) e-money institutions · (f) investment firms · (g) payment institutions · (h) life insurance undertakings · (i) life insurance intermediaries · **(j) crypto-asset service providers** · (k) other financial institutions

CASPs are an **explicitly enumerated assessment category** at Art. 12(4)(j).

### Stage 2 — Selection (Article 13)

- *Art. 13(1)* — Entities whose **residual risk profile is classified as high** under Art. 12 qualify as selected obliged entities
- *Art. 13(2)* — **40-entity capacity cap with discretion to expand**: if >40 entities qualify, AMLA may agree (in consultation with supervisors) on a different number greater than 40. Selection priority: entities operating in the **highest number of Member States**. Tie-breaker: **highest ratio of third-country transactions to total transactions** (last financial year).
- *Art. 13(3)* — **Per-Member-State fallback**: where no entity in a Member State qualifies under (1)–(2), AMLA conducts additional selection to ensure each Member State has at least one selected high-risk entity. Tie-breaker: highest MS count → highest third-country transaction ratio.

> [!info] Practical sizing
> First selection list 2027; direct supervision begins **2028**. AMLA has issued reporting packages to national supervisors to identify provisionally eligible entities. Prototypical selected obliged entities: tier-1 EU banks with broad cross-border footprint (Revolut, N26, ING-class); large cross-border CASPs above assessment threshold (Binance EU, Coinbase Europe, Kraken EU-class). National-focused PIs / EMIs / single-MS CASPs / RegTech vendors are out of Stage 1 assessment unless picked up by the per-MS fallback.

### AMLA's Direct Supervisory Powers (over selected obliged entities)

- *Art. 6* — General powers framework + binding decisions framework
- *Art. 17* — Information request powers (without national-supervisor intermediation)
- *Arts 18–19* — Investigations and on-site inspections (including unannounced where authorised)
- *Arts 20–21* — Further investigative powers
- *Art. 22* — **Pecuniary sanctions** imposed by AMLA Executive Board for serious, repeated, or systematic breaches of TFR (Reg 2023/1113) OR AMLR (Reg 2024/1624) OR binding AMLA decisions under Art. 6(1):

| Sanction structure | Cap | Article |
|---|---|---|
| CDD breaches | Maximum **10% of total annual turnover** | Art. 22(6) |
| Other serious breaches | Maximum **€10 million** | Art. 22(7) |
| Basic amount (multi-jurisdiction CDD violations) | **€500,000 to €2 million** OR **1% turnover** (whichever higher) | Art. 22(3)(a) |

Sanctions must be **effective, proportionate, and dissuasive**.

- *Art. 23* — Periodic penalty payments alongside or in lieu of one-off fines
- Publication of sanctions decisions (name + violation + amount); withdrawal recommendation to home-NCA where AML failings warrant sectoral authorisation withdrawal (AMLA itself does not withdraw the sectoral licence — that remains the home-NCA's act)

### Joint Supervisory Teams (JSTs)

For selected obliged entities, AMLA + national supervisor staff form a JST under AMLA leadership. JST is the single supervisory interface for all AMLA-supervised AML matters. Quarterly review cadence + ad-hoc on material incidents.

### Indirect Channels for Non-Selected Obliged Entities

AMLA does not directly supervise non-selected entities, but its work product flows through the national supervisor:

- **RTS / ITS adopted by Commission on AMLA's draft** — directly applicable; binds your operations (e.g. AMLR Art. 28 CDD-information RTS; BO discrepancy reporting RTS; Art. 12(7) selection methodology RTS)
- **Guidelines and recommendations** — national supervisor expected to comply or explain
- **Peer reviews of your national supervisor** — may trigger thematic reviews flowing down to obliged entities
- **Convergence + thematic reviews** coordinated by AMLA (sectoral or topical — e.g. CASP onboarding controls, sanctions-screening defects, BO discrepancy reporting)
- **Common training + supervisory methodology** — your supervisor's inspection style will increasingly converge with AMLA's

> [!info] Art. 28 CDD RTS is the highest-stakes Level 2 instrument
> Once adopted, it codifies exactly what data points and verification standards constitute compliant CDD across all Member States. It removes Member-State divergence on CDD operational standards. Track its final adoption closely.

## Cross-Regime Interactions

### AMLR ↔ GDPR (data-tension axis)
- Legal basis for processing customer + BO personal data: AMLR (legal obligation, GDPR Art. 6(1)(c))
- Cross-border data sharing for AMLA supervision: assess against GDPR Arts 44–49 international transfers where third-country supervisors involved
- Group-wide info sharing (AMLR Art. 16) requires intra-group legal basis; binding corporate rules or equivalent for third-country subsidiaries
- Tipping-off prohibition vs GDPR data subject access requests — managed via AMLR Art. 76 + national-FIU coordination on response framing
- EDPB-AMLA joint guidance in development (landscape doc flags this as a live tension)

### AMLR ↔ MiCA + TFR (for CASPs)
- CASP-classified entity is in AMLR Art. 3 scope (via the financial-institution definition)
- TFR (Reg 2023/1113) Travel Rule applies to all CASP-to-CASP and CASP-to-unhosted-wallet crypto transfers — separate workstream but operationally co-located
- CASP onboarding must satisfy AMLR Art. 20 CDD + MiCA + TFR Travel Rule in one customer journey

### AMLR ↔ DORA (for all FE-classified obliged entities)
- CDD + sanctions screening systems classified as ICT services supporting a critical or important function under DORA — apply DORA Pillar 1 + Pillar 2 accordingly
- Compromise of CDD or sanctions systems → triggers BOTH DORA Art. 18 major-incident reporting AND (where AML-relevant) AMLA notification for selected obliged entities
- Third-party providers of KYC/CDD tooling → DORA Art. 30 contractual clauses + AMLR Art. 14 outsourcing controls — design once, satisfy both regimes
- See [[DORA-NCA-Supervision-Mechanics]] for the DORA pillar detail

### AMLR ↔ eIDAS 2.0 (mandatory from 31 December 2026)
- EUDI Wallet must be accepted as customer identification for CDD onboarding — applies to every obliged entity performing customer KYC
- Relying-party registration with national eIDAS authority completed
- CDD workflow updated to support EUDI Wallet identity attribute consumption alongside legacy methods
- See [[eIDAS-2.0]]

## Consolidated Timeline

| Date | Event | Instrument |
|---|---|---|
| 19 Jun 2024 | All three instruments published in OJ (L series) | All |
| 9 Jul 2024 | AMLR + AMLD6 enter into force (20 days after OJ publication) | AMLR + AMLD6 |
| 10 Oct 2024 | Deadline for MS notification of pre-existing lower national cash limits | AMLR Art. 80(3) |
| 1 Jul 2025 | AMLA operational in Frankfurt | AMLA Reg |
| 10 Jul 2025 | AMLD6 Art. 74 (BO register access + legitimate interest framework) — transposition | AMLD6 Art. 78 |
| 10 Jul 2026 | AMLD6 Arts 11, 12, 13, 15 (BO register infrastructure) — transposition | AMLD6 Art. 78 |
| 10 Jul 2026 | AMLA ITS on STR format — draft submission to Commission | AMLR Art. 69(3) |
| 31 Dec 2026 | EUDI Wallet acceptance mandatory for CDD | eIDAS 2.0 (cross-regime) |
| 2027 | AMLA first selection cycle — list of "selected obliged entities" published | AMLA Reg |
| **10 Jul 2027** | **AMLR application date + AMLD6 general transposition deadline** | AMLR + AMLD6 |
| 10 Oct 2027 | Deadline for MS notification of legacy AMLD5 Art. 2(2)/(3) exemptions in place on 10 Jul 2027 | AMLR Art. 7(4) |
| 2028 | AMLA direct supervision of selected obliged entities begins | AMLA Reg |
| 10 Jul 2029 | AMLD6 Art. 18 (Single access point to real estate information) — transposition | AMLD6 Art. 78 |
| 10 Jul 2029 | AMLR application to football agents (Art. 3(3)(n)) + professional football clubs (Art. 3(3)(o)) | AMLR Art. 90 |
| 10 Jul 2029 | Commission may adopt delegated act under AMLR Art. 52(2) lowering BO threshold to 15% (max) for higher-risk categories | AMLR |
| 10 Jul 2030 | Commission reports under AMLR Art. 88 on: lowering 25% BO threshold; extending high-value goods to garments/accessories; extending Art. 74 threshold disclosures; adjusting Art. 80 cash limit | AMLR |

## InnBlockchain Application — Obliged-Entity + AMLA Direct-Supervision Status by ICP Segment

| ICP Segment | AMLR Obliged Entity? | AMLA Direct Supervision Likely? | Note |
|---|---|---|---|
| **FinTech — BankTech** | Yes (credit institution) | **Highly likely** at cross-border scale | Prototypical selected obliged entity |
| **FinTech — PayTech / WalletTech / WealthTech / ExchangeTech** | Yes (PI / EMI / CASP / investment firm) | Possible at large cross-border scale; ExchangeTech is prototypical for crypto-side | Concurrent compliance with PSD3 / MiCA / MiFID II |
| **FinTech — LendTech** | Yes (credit / financial institution) | Unlikely (single-MS typical) | National supervisor only |
| **FinTech — InsurTech** | Yes for life + investment-related insurance only; pure P&C OUT | Unlikely | Product-by-product assessment |
| **FinTech — RegTech** | **NO** (SaaS vendor — not Art. 3) | N/A | Indirect — tooling supports FI customers' compliance |
| **Crypto — Seg 1 RWA** | Yes (investment firm / securities issuer) | Unlikely unless very large + cross-border | TFR does NOT apply (MiFID-classified) |
| **Crypto — Seg 2 DEX / On-Chain Trading** | Yes (CASP) | **Highly likely** at cross-border scale | Prototypical selected obliged entity in crypto |
| **Crypto — Seg 3 DeFi Lending** | Conditional (only if CASP-classified) | Unlikely | Truly decentralised DeFi: contested out-of-scope claim |
| **Crypto — Seg 4 Non-Custodial / MPC Wallets** | Conditional (only if custody offered) | Unlikely | Pure non-custodial software: out |
| **Crypto — Seg 5 NFT Platforms** | Conditional (fractionalised/fungible NFTs as CASP, or AMP ≥€10k) | Unlikely | Grey zone; monitor AMLA convergence |
| **Crypto — Seg 6 IDO / Token Launch** | Yes (CASP via placing of crypto-assets) | Unlikely | Token issuer obliged via CASP role |
| **Crypto — Seg 7 DAO Infrastructure** | Conditional (only if CASP under MiCA) | Unlikely | Pure software-vendor DAO: out |
| **Crypto — Seg 8 L2 / Chain Infrastructure** | Conditional (only if bridge/settlement is CASP) | Unlikely | Pure protocol-only L2: out |
| **Crypto — Seg 9 Web3 Gaming / GameFi** | Conditional (only if fiat off-ramp / P2P at material value) | Unlikely | Pure in-game economy without fiat ramp: out |
| **Crypto — Seg 10 AI × Crypto** | Conditional (only if agent-as-CASP) | Unlikely | Pure AI tooling without CASP service: out |

## Related Pages

- [[EU-AML-AMLA]] — strategic / "what-is-the-package" framing (parent concept page)
- [[EU-Fintech-Compliance-Landscape]] — package context within the full EU regulatory landscape
- [[DORA-NCA-Supervision-Mechanics]] — companion practitioner page for ICT operational resilience (concurrent obligation for all FE-classified obliged entities)
- [[MiCA-NCA-Authorization-Mechanics]] — companion practitioner page for CASP authorisation (the gating obligation for crypto-side AMLR scoping)
- [[MiFID-II-NCA-Authorization-Mechanics]] — companion practitioner page for investment firm authorisation
- [[eIDAS-2.0]] — EUDI Wallet acceptance for CDD (mandatory from 31 Dec 2026)
- [[DLT-Pilot-Regime]] — DLT MTF/SS/TSS infrastructure (Seg 1 RWA)
