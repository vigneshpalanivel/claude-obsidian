# DORA Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for Financial Entities Preparing for ICT Supervision

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU Digital Operational Resilience Act (DORA) — Regulation (EU) 2022/2554
**Status:** Fully in force and applicable since 17 January 2025 *(Article 64)*
**Document type:** Pre-supervision readiness assessment — to be completed before the first DORA-themed NCA inspection or as part of an authorisation dossier

---

> **Who this document is for:** General counsel, CIOs, CISOs, operations executives, and compliance officers at EU-licensed financial entities — or applicants for authorisation under any EU financial-services regime — preparing to demonstrate DORA compliance to their competent authority. This checklist mirrors the intake assessment a specialist EU financial-regulatory lawyer would walk you through in a first advisory session.

---

> **How to use this checklist:** DORA is not an authorisation regime. There is no "DORA license" to apply for. DORA is a continuous-compliance framework layered on top of your existing sectoral authorisation (MiCA, MiFID II, CRD/CRR, PSD2/PSD3, Solvency II, etc.) and supervised by the **same competent authority** that authorises your underlying business. Work through each section in order. Items you cannot tick represent gaps that must be closed before your next supervisory dialogue, audit, or authorisation milestone.

---

## SECTION 1 — DOES DORA APPLY TO YOU?

*DORA has wider scope than any other piece of EU financial-services legislation. Almost every regulated EU financial entity is in scope. Plus a separate regime applies to critical ICT vendors serving them.*

---

### 1.1 — Financial Entity Scope (Article 2(1)(a)–(t))

Tick every category that describes your entity. DORA applies if any one is true.

- [ ] Credit institution (bank) authorised under CRD
- [ ] Payment institution (PI) authorised under PSD2 / PSD3, including exempt PIs
- [ ] Account information service provider (AISP)
- [ ] Electronic money institution (EMI), including exempt EMIs
- [ ] Investment firm authorised under MiFID II
- [ ] **Crypto-asset service provider (CASP)** authorised under MiCA *(Article 2(1)(f))*
- [ ] **Issuer of asset-referenced tokens (ART)** authorised under MiCA Title III
- [ ] Central securities depository (CSD)
- [ ] Central counterparty (CCP)
- [ ] Trading venue (regulated market, MTF, OTF, **DLT MTF / SS / TSS under the DLT Pilot Regime**)
- [ ] Trade repository
- [ ] Manager of alternative investment funds (AIFM)
- [ ] Management company (UCITS ManCo)
- [ ] Data reporting service provider (ARM, APA, CTP)
- [ ] Insurance or reinsurance undertaking (Solvency II)
- [ ] Insurance / reinsurance intermediary, ancillary intermediary (where micro / SME exemption does not apply)
- [ ] Institution for occupational retirement provision (IORP), subject to size carve-outs
- [ ] Credit rating agency (CRA)
- [ ] Administrator of critical benchmarks
- [ ] Crowdfunding service provider (ECSP)
- [ ] Securitisation repository

> **Legal advisor note:** DORA applies *automatically* by virtue of the entity type, not by separate enrolment. The day your sectoral authorisation is granted, you are in DORA scope. The day you cease to hold authorisation, you exit.

**Reference:** DORA Article 2(1) (scope — financial entities)

---

### 1.2 — Scope Exclusions and Carve-Outs (Article 2(3)–(4))

DORA does **not** apply to the following. Check any that describe your situation:

- [ ] AIFMs below the AIFMD registration-only threshold (sub-threshold AIFMs)
- [ ] Insurance / reinsurance undertakings benefiting from the Solvency II Article 4 small-undertaking exemption
- [ ] Insurance intermediaries that are microenterprises / SMEs and do not act on a professional basis for life insurance or investment-based insurance
- [ ] Post Office Giro institutions covered by Article 2(5)(3) of CRD
- [ ] IORPs operating pension schemes which together have **not more than 15 members in total** *(Article 2(3)(c) — i.e. 15 members or fewer)*
- [ ] Natural or legal persons exempted under MiFID II Articles 2 and 3
- [ ] Non-EU entities not providing services into the EU (out of scope absent territorial nexus)

> **Legal advisor note:** Two common misframes — (i) **pre-authorisation start-ups** are *not* in DORA scope until they hold a licence, but NCAs will assess DORA readiness as part of the authorisation review (especially for MiCA — see Section 10). (ii) Pure SaaS vendors without a financial-services licence are *not* in scope as financial entities, but may be caught indirectly via the Critical ICT Third-Party Provider (CTPP) regime (Section 8) if their services support multiple EU financial entities.

**Reference:** DORA Article 2(3)–(4) (exclusions)

---

### 1.3 — Are You a Critical ICT Third-Party Provider (CTPP)?

A separate regime applies to ICT service providers that are *designated* as critical by the European Supervisory Authorities. CTPPs are supervised directly by a Lead Overseer (EBA, ESMA, or EIOPA) — outside the normal home-NCA framework.

- [ ] Do you provide ICT services to multiple EU financial entities?
- [ ] Are your services supporting "critical or important functions" of those entities (core banking, trading, settlement, custody, KYC/AML, risk modelling)?
- [ ] Would the failure of your service likely impair financial stability or the orderly functioning of EU financial markets?
- [ ] Are you systemic across multiple Member States and sectors?

These are indicative directional questions only. The actual designation is made by the ESAs against the **quantitative thresholds and qualitative criteria** in Commission Delegated Regulation (EU) 2024/1502 — covering systemic impact, criticality of services, substitutability, and interconnectedness. If any of the above are "yes," obtain a formal designation-risk assessment from counsel before assuming you are out of scope.

> **Legal advisor note:** CTPP designation is a *finding* by the ESAs, not a voluntary opt-in. The first wave of designations has begun under the Joint Committee oversight framework — the live list of designated CTPPs is published on the ESAs' Joint Committee page. If you are large enough for the directional questions to feel close, you need a legal opinion, not a self-assessment.

**Reference:** DORA Articles 28(9), 31; Commission Delegated Regulation (EU) 2024/1502 (RTS on CTPP designation criteria)

---

## SECTION 2 — PROPORTIONALITY & SIMPLIFIED FRAMEWORK

*DORA applies the same five pillars to a global bank and a 10-person CASP. The proportionality principle (Article 4) determines how heavily each obligation lands. Misjudging your proportionality tier is the single most common scoping error.*

---

### 2.1 — Proportionality Self-Classification

Assess where you sit. The classification drives every downstream obligation.

- [ ] **Full ICT risk management framework (Articles 5–15) applies** by default to all in-scope financial entities
- [ ] **Simplified ICT risk management framework (Article 16(1) first subparagraph) applies** if you are:
  - A "small and non-interconnected" investment firm under IFR/IFD definition
  - A payment institution exempted pursuant to Directive (EU) 2015/2366 (PSD2 Article 32)
  - An institution exempted pursuant to Directive 2013/36/EU (CRD) where the Member State has not applied the Article 2(4) carve-back option of this Regulation
  - An electronic money institution exempted pursuant to Directive 2009/110/EC (Article 9)
  - A "small" institution for occupational retirement provision (i.e. operating pension schemes with **less than 100 members in total** per Article 3(53)) — *only if also subject to the Article 5 derogation of Directive (EU) 2016/2341 by the Member State*

> **Important — insurance intermediary carve-out is fuller than simplified, not simplified-framework:** insurance, reinsurance, and ancillary insurance intermediaries that qualify as microenterprises or as small/medium-sized enterprises are **fully out of DORA scope** under Article 2(3) and recital 39 — not subject to the simplified framework. Do not file them under Section 2.1.
- [ ] **Microenterprise carve-outs apply** *(Article 3(60))* if you employ **fewer than 10 persons** AND annual turnover **and/or** annual balance sheet total **does not exceed €2,000,000**. **Exclusion within the carve-out:** trading venues, central counterparties, trade repositories, and central securities depositories **cannot** qualify as microenterprises regardless of size *(Article 3(60) verbatim)*. Microenterprise status further lightens several specific obligations (third-party-relationship role in Article 5(3), independent control function in Article 6(4), internal audit cadence in Article 6(6), framework documentation cadence in Article 6(5), audit-rights delegation under Article 30(3) derogation)

> **Legal advisor note:** "Simplified" means leaner documentation and fewer mandatory components, *not* exemption. You still need a written framework, incident process, basic testing, third-party register, and reporting workflow. The framework is set out in Article 16 and detailed in Commission Delegated Regulation (EU) 2024/1774 Title II.

**Reference:** DORA Articles 4 (proportionality), 16 (simplified framework); Commission Delegated Regulation (EU) 2024/1774

---

### 2.2 — Significance and TLPT Threshold

A separate "significance" assessment determines whether you must perform **Threat-Led Penetration Testing (TLPT)** every three years (Section 5.3). The criteria are set out in Commission Delegated Regulation (EU) 2025/295.

- [ ] **Sector-based criteria assessed:** size, market share, cross-border activity, criticality of services
- [ ] **Threshold-based criteria assessed:** balance sheet total, assets under custody, payment volumes, number of accounts (varies by sector)
- [ ] **NCA notification on classification** — your competent authority confirms whether you are in TLPT scope; do not self-exempt

> **Legal advisor note:** TLPT scope is narrow — typically only the largest sectoral players. But if you are in scope, the operational burden is significant (live attack simulation on production systems, typically a 6–12 month engagement). Confirm with your NCA in writing.

**Reference:** DORA Article 26(8)–(9); Commission Delegated Regulation (EU) 2025/295 (RTS on TLPT)

---

## SECTION 3 — PILLAR 1: ICT RISK MANAGEMENT FRAMEWORK (Articles 5–16)

*The substantive heart of DORA. Every in-scope entity must have a written, board-approved ICT risk management framework — not a paragraph in the IT policy, a discrete, named document.*

---

### 3.1 — Governance and Organisation (Article 5)

- [ ] **Management body ultimate responsibility documented** — the board has explicit, written, non-delegable responsibility for the ICT risk management framework *(Article 5(2))*
- [ ] **Management body knowledge requirement met** — board members can demonstrate sufficient knowledge and skills to understand and assess ICT risk; documented training programme in place *(Article 5(4))*
- [ ] **Risk appetite for ICT risk approved** — written statement of the entity's tolerance for ICT risk, approved by the board, reviewed at least annually
- [ ] **Roles and responsibilities defined** — clear separation between (i) the function setting policy, (ii) operational ICT, (iii) ICT risk control, (iv) internal audit
- [ ] **Budget allocation reviewed annually** — the board reviews and approves ICT investment and resilience budget
- [ ] **Reporting line to management body** — at least an annual report on ICT risk posture; immediate escalation for major incidents

**Reference:** DORA Article 5 (governance and organisation)

---

### 3.2 — ICT Risk Management Framework (Article 6)

- [ ] **Written framework adopted** — covers strategies, policies, procedures, protocols, and tools to protect all information assets and ICT assets
- [ ] **Annual review and update** — at least once per year; after any major ICT incident; after any supervisory instruction
- [ ] **Internal audit coverage** — periodic audit by independent internal auditors with sufficient knowledge; follow-up on findings tracked
- [ ] **Digital operational resilience strategy** — explicit strategy setting out how the framework will be implemented, including objectives, risk tolerance, and indicators *(Article 6(8))*

Commission Delegated Regulation (EU) 2024/1774 specifies the detailed content of the framework — Title I (full framework) and Title II (simplified framework). Treat the RTS articles as a paragraph-by-paragraph compliance map, not optional guidance.

**Reference:** DORA Article 6; Commission Delegated Regulation (EU) 2024/1774 (RTS on ICT risk management tools, methods, processes, policies, and simplified framework)

---

### 3.3 — Identification (Article 8)

- [ ] **Inventory of information assets and ICT assets** — complete, structured, kept up to date
- [ ] **Inventory of business functions, roles, and responsibilities** mapped to supporting ICT assets
- [ ] **Critical or important functions identified** — those whose disruption would materially impair the entity's ability to comply with its authorisation conditions or perform its core business *(this designation drives the TLPT scope, third-party contractual clauses, and exit-strategy depth)*
- [ ] **Dependencies on third-party ICT service providers mapped** for each critical or important function
- [ ] **Annual review of identification artefacts** — at minimum; after any material change in IT estate

**Reference:** DORA Article 8

---

### 3.4 — Protection and Prevention (Article 9)

- [ ] **ICT security policies, procedures, protocols, and tools** in place to ensure resilience, continuity, and availability of ICT systems
- [ ] **Network security architecture** — segmentation, hardening, secure configuration baselines
- [ ] **Identity and access management (IAM)** — role-based access, least privilege, periodic recertification
- [ ] **Privileged access management (PAM)** — separate controls for administrative and privileged accounts, session recording where appropriate
- [ ] **Cryptography policy** — algorithms, key lifecycle management, key custodianship; alignment with current ENISA / NIST guidance
- [ ] **Data and system integrity** — controls preventing unauthorised modification of data, code, or configurations
- [ ] **ICT change management** — formal change-approval workflow with risk assessment
- [ ] **Patch and vulnerability management** — defined SLAs by severity; documented exceptions

**Reference:** DORA Article 9; Commission Delegated Regulation (EU) 2024/1774 Title I Chapter II

---

### 3.5 — Detection (Article 10)

- [ ] **Mechanisms to detect anomalous activities** — including ICT network performance issues, security events, potential single points of failure
- [ ] **Multiple layers of control** — defence-in-depth across endpoint, network, identity, application, data layers
- [ ] **Alert thresholds and criteria defined** — incident classification and escalation criteria mapped to Article 18 thresholds
- [ ] **24/7 monitoring coverage** appropriate to the entity's risk profile; documented coverage model (in-house SOC, outsourced MSSP, hybrid)

**Reference:** DORA Article 10

---

### 3.6 — Response and Recovery (Article 11) + BCP / DRP (Article 12)

- [ ] **ICT business continuity policy** — comprehensive, documented, board-approved, integrated with overall BCP
- [ ] **ICT response and recovery plans** — actionable plans for each major scenario (cyber attack, infrastructure failure, third-party failure)
- [ ] **Recovery Time Objectives (RTOs)** and **Recovery Point Objectives (RPOs)** defined for each critical or important function and each supporting ICT asset
- [ ] **Backup policies and procedures** — frequency, encryption, segregation, immutable copies where appropriate; ransomware-resilient design
- [ ] **Backup restoration testing** — restoration procedures tested at least annually; independent from production systems
- [ ] **Crisis communication plan** — internal escalation, client communication, regulator notification, public messaging
- [ ] **BCP and DRP exercises** — at least annual full-scenario exercise; results documented and remediation tracked

**Reference:** DORA Articles 11 and 12; Commission Delegated Regulation (EU) 2024/1774 Title I Chapter IV

---

### 3.7 — Learning and Evolving (Article 13)

- [ ] **Post-incident review process** — every major incident triggers a documented post-mortem with root cause, lessons learned, remediation actions
- [ ] **Lessons learned integrated** into the ICT risk management framework, BCP/DRP, training
- [ ] **ICT-related operational and security awareness training** — for all staff and management; at least annually; tested via phishing simulations or equivalent
- [ ] **Higher-level training for ICT and security staff** — proportionate to role

**Reference:** DORA Article 13

---

### 3.8 — Communication (Article 14)

- [ ] **Crisis communication plans documented** — covering staff, clients, counterparties, the public, the media, and the competent authority
- [ ] **Designated spokesperson** for ICT-related public disclosures
- [ ] **Client communication procedures** for major ICT incidents — what is disclosed, when, by which channel

**Reference:** DORA Article 14

---

## SECTION 4 — PILLAR 2: ICT INCIDENT MANAGEMENT, CLASSIFICATION & REPORTING (Articles 17–23)

*Mandatory regulatory reporting of major ICT-related incidents on tight timelines. Get this wrong once and you are explaining it to your NCA in writing.*

---

### 4.1 — Incident Management Process (Article 17)

- [ ] **Documented incident management process** covering detection, logging, response, containment, eradication, recovery, post-incident review
- [ ] **Incident logging** — every ICT-related incident logged with timestamp, classification, actions taken, root cause
- [ ] **Internal escalation matrix** — defined thresholds and authority to declare a major incident
- [ ] **Designated incident response team** with on-call coverage proportionate to risk profile

**Reference:** DORA Article 17

---

### 4.2 — Incident Classification (Article 18)

A **major ICT-related incident** must be reported to the NCA. Classification follows objective criteria set out in Commission Delegated Regulation (EU) 2024/1772.

- [ ] **Classification criteria operationalised** in the incident workflow — Article 18(1) sets out **six criteria** (a)–(f):
  - **(a)** Number / relevance of clients or financial counterparts affected; amount or number of transactions affected; **and** any reputational impact (note: reputational impact is bundled into criterion (a), not a standalone criterion)
  - **(b)** Duration of the incident, including the service downtime
  - **(c)** Geographical spread, **particularly if it affects more than two Member States**
  - **(d)** Data losses — availability, authenticity, integrity, **or** confidentiality
  - **(e)** Criticality of the services affected (transactions and operations)
  - **(f)** Economic impact — direct and indirect costs and losses, in both absolute and relative terms
- [ ] **Significant cyber threats — Article 18(2)** — separate (voluntary) notification regime under Article 19(2); criticality, number/relevance of targets, and geographical spread are the classification axes
- [ ] **Significant cyber threats** — separate (voluntary) notification regime under Article 19(2); criteria operationalised
- [ ] **Decision log** maintained for every classification call

**Reference:** DORA Article 18; Commission Delegated Regulation (EU) 2024/1772 (RTS on classification of major ICT-related incidents and significant cyber threats)

---

### 4.3 — Reporting Timelines and Templates (Articles 19–20)

Three sequential reports per major incident, on prescribed templates:

- [ ] **Initial notification** to NCA — submitted within the timeline set by the harmonised reporting RTS / ITS (operationally treat as "as soon as feasible and no later than 4 hours after classification, with a hard outer limit of 24 hours from detection")
- [ ] **Intermediate report** — updated facts and ongoing assessment; submitted within the timeline set by the harmonised reporting RTS / ITS
- [ ] **Final report** — root cause analysis, full impact, remediation, lessons learned; submitted within the timeline set by the harmonised reporting RTS / ITS
- [ ] **Reporting template ready** — current ESAs / Commission template populated in advance with static fields; dynamic fields auto-populated from incident-management tooling where possible
- [ ] **Single point of contact at NCA** identified for incident submissions
- [ ] **Backup submission channel** in case primary channel is itself impaired by the incident

> **Legal advisor note:** The exact timeline expressed in hours has shifted across drafts of the harmonised reporting RTS / ITS adopted under Article 20. Confirm the current timeline with counsel before going live, and design your runbook to the *tightest* observed timeline so you are never out of compliance during a Level 2 change.

**Reference:** DORA Articles 19, 20, 21, 22; harmonised reporting RTS / ITS adopted under Article 20

---

### 4.4 — Payment-Related Incident Reporting (Article 23)

For credit institutions, payment institutions, AISPs, and EMIs only — DORA absorbs the legacy PSD2 Article 96 operational and security incident reporting regime into a unified DORA channel.

- [ ] **Single incident reporting channel** — payment-related operational and security incidents reported via the DORA channel, not via separate PSD2 channels
- [ ] **EBA / national-NCA dual-routing handled** — if applicable, configured at the technical-submission layer

**Reference:** DORA Article 23

---

## SECTION 5 — PILLAR 3: DIGITAL OPERATIONAL RESILIENCE TESTING (Articles 24–27)

*DORA mandates a multi-tier testing programme. Most entities perform basic and advanced testing annually. A defined subset performs Threat-Led Penetration Testing (TLPT) every three years.*

---

### 5.1 — Testing Programme (Article 24)

- [ ] **Risk-based, written testing programme** covering all ICT systems and applications supporting critical or important functions
- [ ] **Annual review and update** of the programme
- [ ] **Independent testers** — internal or external, with sufficient knowledge, skills, and resources; conflict-of-interest controls if internal
- [ ] **Findings remediation tracked** to closure with severity-based SLAs
- [ ] **Test results reported to the management body**

**Reference:** DORA Article 24

---

### 5.2 — Basic Testing Battery (Article 25)

The following tests must be performed at least once per year on ICT systems and applications supporting critical or important functions:

- [ ] Vulnerability assessments and scans
- [ ] Open-source analyses
- [ ] Network security assessments
- [ ] Gap analyses
- [ ] Physical security reviews
- [ ] Questionnaires and scanning software solutions
- [ ] Source code reviews where feasible (manual or automated)
- [ ] Scenario-based tests
- [ ] Compatibility testing
- [ ] Performance testing
- [ ] End-to-end testing
- [ ] Penetration testing (general — distinct from TLPT)

**Reference:** DORA Article 25

---

### 5.3 — Threat-Led Penetration Testing / TLPT (Articles 26–27)

If you are designated for TLPT (Section 2.2), you must perform TLPT **at least every three years** on live production systems.

- [ ] **TLPT scope** covers critical or important functions, performed on live production systems
- [ ] **TLPT methodology** aligned with the TIBER-EU framework as built into Commission Delegated Regulation (EU) 2025/295
- [ ] **Pooled-testing options assessed** — joint TLPT with other in-scope entities sharing the same third-party providers is permitted and may be required for efficiency
- [ ] **Third-party providers included** in the TLPT scope where they support critical or important functions; provider consent and contractual arrangements in place in advance
- [ ] **Testers meet Article 27 requirements** — independence, reputability, certified, ethical, professional liability insurance. **Default rule (Article 26(8) first subparagraph):** financial entities **may** use internal testers, but **must contract external testers every three tests** (i.e. at least one in every three TLPT cycles must be external; the threat-intelligence provider must also always be external per recital 61). **Stricter exception (Article 26(8) second subparagraph):** **credit institutions classified as significant under SSM Regulation Article 6(4) shall ONLY use external testers** — no internal-tester option is available to them
- [ ] **NCA / TLPT authority engagement** — confirm in advance which authority leads TLPT supervision for your entity (varies by sector and Member State)
- [ ] **Attestation issued** by NCA / TLPT authority on completion of each cycle

> **Legal advisor note:** TLPT is not a pen test in the colloquial sense. It is a multi-month engagement involving (i) threat intelligence development by a separately commissioned provider, (ii) red-team execution by ethical hackers against live systems with executive but not operational awareness, (iii) blue-team de-brief, (iv) closure with the supervisor. Budget €500k–€2M per cycle depending on entity size.

**Reference:** DORA Articles 26, 27; Commission Delegated Regulation (EU) 2025/295 (RTS on TLPT)

---

## SECTION 6 — PILLAR 4: ICT THIRD-PARTY RISK MANAGEMENT (Articles 28–30)

*Most ICT failures travel through vendors. DORA pushes accountability for third-party ICT risk back onto the financial entity — the contract, the register, and the exit plan are the three load-bearing artefacts.*

---

### 6.1 — General Principles (Article 28)

- [ ] **Third-party ICT risk strategy** documented as part of the ICT risk management framework
- [ ] **Concentration risk assessed at entity level** — before contracting any new ICT service that would create over-reliance on a single provider, particularly where the service supports a critical or important function
- [ ] **Pre-contracting due diligence** — written assessment of the provider's suitability (financial soundness, security posture, sub-outsourcing chain, geographic risk, ESG where material)
- [ ] **Board approval** for contracts supporting critical or important functions
- [ ] **Ongoing monitoring** of third-party performance and risk over the lifetime of the contract

**Reference:** DORA Article 28(1)–(7)

---

### 6.2 — Register of Information (Article 28(3) + Implementing RTS)

- [ ] **Register of Information maintained** — covers all contractual arrangements with ICT third-party service providers; separate flag for those supporting critical or important functions
- [ ] **Annual submission to NCA** of the Register of Information using the harmonised ITS template (Commission Implementing Regulation (EU) 2024/2956)
- [ ] **Notification of any planned new ICT service provider** supporting a critical or important function — to NCA before contract execution
- [ ] **Notification of any change** to existing arrangements supporting critical or important functions, including sub-outsourcing changes

> **Legal advisor note:** The Register of Information is the single most operationally heavy DORA artefact. The ITS template has ~14 sub-templates and ~50 fields per contract. Most entities under-budget this by a factor of 3–5x. Treat it as a standing data-engineering project, not a one-time compliance task.

**Reference:** DORA Article 28(3); Commission Implementing Regulation (EU) 2024/2956 (ITS on Register of Information templates); Commission Delegated Regulation (EU) 2024/1773 (RTS on policies on ICT services supporting critical or important functions)

---

### 6.3 — Key Contractual Provisions (Article 30)

Every ICT services contract must include the following. Contracts supporting **critical or important functions** must include the longer list in Article 30(3).

#### Minimum contractual provisions — all ICT contracts (Article 30(2)) — **9 mandatory elements**

- [ ] **(a)** Clear and complete description of all functions and ICT services, **including whether sub-contracting of CIF services or material parts is permitted, and on what conditions**
- [ ] **(b)** Locations (regions / countries) where contracted/sub-contracted functions and services are provided, **including data storage location**, and the requirement for the provider to **notify the financial entity in advance** if it envisages changing locations
- [ ] **(c)** Provisions on **availability, authenticity, integrity, and confidentiality** of data — including personal data
- [ ] **(d)** **Access, recovery and return** of personal and non-personal data in an easily accessible format on **insolvency, resolution, discontinuation of business, or termination** of the contract
- [ ] **(e)** Service level descriptions, including updates and revisions thereof
- [ ] **(f)** Obligation of the ICT third-party service provider to **assist the financial entity at no additional cost (or at ex-ante-determined cost) when an ICT incident related to the service occurs**
- [ ] **(g)** Obligation of the provider to **fully cooperate with the competent authorities and resolution authorities** (including persons appointed by them)
- [ ] **(h)** Termination rights and related minimum notice periods, in line with NCA and resolution-authority expectations
- [ ] **(i)** Conditions for participation by the ICT third-party service provider in the financial entity's **ICT security awareness programmes and digital operational resilience training** (per Article 13(6))

#### Additional contractual provisions — critical-or-important functions only (Article 30(3)) — **6 additional elements**

- [ ] **(a)** **Full service level descriptions** with **precise quantitative and qualitative performance targets** within the agreed service levels, enabling effective monitoring and timely corrective actions where service levels are not met
- [ ] **(b)** Notice periods and reporting obligations of the provider to the financial entity, **including notification of any development that might materially impact the provider's ability to provide CIF services at agreed levels**
- [ ] **(c)** **Requirements for the provider to implement and test business contingency plans, and to have in place ICT security measures, tools, and policies that provide an appropriate level of security** for the financial entity's services
- [ ] **(d)** Provider's **obligation to participate and fully cooperate in the financial entity's TLPT** as referred to in Articles 26 and 27
- [ ] **(e)** Right to **monitor the provider's performance on an ongoing basis** — unrestricted access / inspection / audit rights for the financial entity, appointed third parties, and the NCA + Lead Overseer; alternative assurance levels; full cooperation during on-site inspections; scope, procedures, and frequency of inspections
- [ ] **(f)** **Exit strategies** — establishment of a **mandatory adequate transition period** during which the provider continues services to enable migration to another provider or to in-house solutions

> **Microenterprise derogation (Article 30(3) final subparagraph):** the audit/inspection right under (e) may be delegated by contract to an independent third party appointed by the provider, provided the financial entity can request information and assurance at any time.

#### Sub-outsourcing controls (Article 30(2) on chain-of-supply description, Article 30(3) on contractual rights, Article 30(5) on Level 2 RTS)

- [ ] Pre-notification of any planned sub-outsourcing of services supporting critical or important functions
- [ ] Financial entity's right to object to sub-outsourcing changes
- [ ] Sub-outsourcing chain visibility maintained in the Register of Information

**Reference:** DORA Article 30 (full); Commission Delegated Regulation (EU) 2024/1773 (RTS on contractual policies for critical/important functions); current Level 2 RTS on sub-outsourcing of ICT services supporting critical or important functions adopted under Article 30(5)

---

### 6.4 — Exit Strategy (Article 28(8))

Mandatory standalone artefact for every contract supporting a critical or important function.

- [ ] **Documented exit plan** per contract — addressing scenarios of provider failure, deteriorating service, contract termination, or supervisory direction
- [ ] **Identified alternative provider or in-house capability** for each critical-or-important contract
- [ ] **Data extraction and migration plan** with realistic timeline
- [ ] **Periodic testing of the exit plan** — at least desktop walkthrough; full migration test where feasible

**Reference:** DORA Article 28(8)

---

## SECTION 7 — PILLAR 5: INFORMATION SHARING (Article 45)

*Voluntary participation in cyber-threat information-sharing arrangements is encouraged. Not mandatory, but increasingly expected.*

---

### 7.1 — Information Sharing Arrangements

- [ ] **Decision recorded** whether to participate in information-sharing arrangements (formally or informally)
- [ ] **Participation notified to the NCA** if entered into, and any subsequent withdrawal also notified
- [ ] **GDPR-compatible processing arrangements** in place for any personal data shared (including under EDPB / EDPS guidance on cyber-threat data)
- [ ] **Sectoral CERT / CSIRT engagement** — at least passive consumption of national-CSIRT and sector-CSIRT feeds

**Reference:** DORA Article 45

---

## SECTION 8 — CRITICAL ICT THIRD-PARTY PROVIDERS / CTPP REGIME (Articles 31–44)

*Skip this section unless you are designated as a CTPP. This is a separate regulatory regime that applies to vendors, not to financial entities directly.*

---

### 8.1 — Designation Mechanics (Article 31)

- [ ] CTPP candidacy assessed under Commission Delegated Regulation (EU) 2024/1502 criteria
- [ ] If designated, **Lead Overseer assigned** — EBA, ESMA, or EIOPA depending on the sectoral mix of the CTPP's financial-entity customer base
- [ ] **Notification received** of designation; right to be heard exercised within the deadline
- [ ] **Annual oversight fee** budgeted (Article 43)

---

### 8.2 — Oversight Obligations (Articles 32–40)

- [ ] **Full cooperation with Lead Overseer** — including information requests, general investigations, on-site inspections
- [ ] **Annual oversight plan** received and incorporated into operations
- [ ] **Sub-contracting transparency** — full chain disclosed
- [ ] **Recommendations from Lead Overseer** addressed within prescribed deadlines; rejection requires written reasons and may be escalated to the financial-entity customers' NCAs
- [ ] **Penalty exposure understood** — Article 35(6) authorises the Lead Overseer to **impose a periodic penalty payment** on a CTPP that fails to comply with measures under Article 35(1)(a)–(c) after 30 calendar days' notice. Article 35(7) sets the duration: **imposed on a daily basis until compliance is achieved and for no more than 6 months** from notification of the decision. Article 35(8) sets the rate: **up to 1% of average daily worldwide turnover** in the preceding business year, with gravity, duration, intent/negligence, and cooperation as calibration criteria. **Note:** Article 50 administrative penalties are imposed by NCAs on **financial entities**, not on CTPPs — CTPP enforcement runs exclusively through the Lead Overseer regime in Articles 31–44 plus the periodic penalty payment regime in Article 35(6)–(8)

**Reference:** DORA Articles 31–44; Commission Delegated Regulation (EU) 2024/1502

---

## SECTION 9 — SUPERVISION, PENALTIES & ENFORCEMENT (Articles 46–56)

*DORA is supervised by the same NCA that authorises the entity under sectoral law. Penalty exposure flows through sectoral powers — not through a standalone DORA penalty regime for financial entities.*

---

### 9.1 — Competent Authority (Article 46)

- [ ] **DORA-competent NCA identified** — typically the same authority as your sectoral home NCA (BaFin, AMF, AFM, CBI, Bank of Lithuania, etc.)
- [ ] **Supervisory dialogue established** — at minimum, your sectoral NCA contacts are aware of your DORA framework and key contacts

**Reference:** DORA Article 46

---

### 9.2 — Penalty Exposure (Financial Entities)

DORA does **not** create a unified penalty regime for financial entities. NCAs use their **sectoral powers** to enforce DORA compliance. Practical exposure varies by entity type:

| Entity type | Penalty hook | Indicative max |
|---|---|---|
| **CASP (MiCA)** | MiCA Article 111 — general infringements, including Articles 67–73 (ICT, organisational) | **€5,000,000** or **3%** of annual turnover (legal person) |
| **Credit institution (CRD)** | CRD Articles 65–67 (penalties for breaches, including ICT/governance) / national transposition | Up to **10%** of total annual net turnover |
| **Investment firm (MiFID II)** | MiFID II Article 70 / national transposition | Up to **10%** of total annual turnover |
| **PI / EMI (PSD2/PSD3)** | PSD2 Article 103 / national transposition | National maxima — varies |
| **Insurance (Solvency II)** | National transposition | Varies |

- [ ] **Penalty exposure quantified at entity level** — included in risk appetite and D&O scope
- [ ] **Awareness that penalty decisions are published** by NCAs

> **Legal advisor note:** The frequently cited "2% of turnover under DORA" figure is a *practical* approximation derived from sectoral penalty regimes, not a DORA Level 1 article. The directly DORA-imposed penalty regime applies only to CTPPs (Article 35(6) — 1% of daily worldwide turnover). Frame this correctly in board materials so the discussion lands at the right risk level.

**Reference:** DORA Articles 50–54; sectoral penalty regimes per entity type

---

### 9.3 — Notification and Publication

- [ ] **Whistleblower / reporting-of-infringements channel** in place
- [ ] **Awareness of publication** of administrative penalties on NCA websites
- [ ] **Notification duties to other authorities** understood — for cross-sector incidents, NCAs notify ESAs, ENISA, and (where relevant) NIS2 CSIRTs

**Reference:** DORA Articles 53, 54

---

## SECTION 10 — SECTORAL INTERACTION & AUTHORISATION INTEGRATION

*DORA does not replace sectoral law — it overlays it. Where you sit in the regulatory stack determines how DORA reaches you.*

---

### 10.1 — MiCA / CASP Integration

For CASPs and ART/EMT issuers — DORA is the substantive mechanism for satisfying MiCA Articles 34(10) and 68(7)–(8).

- [ ] **DORA readiness assessed at MiCA authorisation stage** — NCA expects the ICT risk management framework, incident reporting workflow, basic testing programme, third-party register, and exit strategies to be at least in design before MiCA authorisation is granted
- [ ] **Cross-references in MiCA application dossier** — explicitly map MiCA ICT obligations to the DORA artefacts that satisfy them
- [ ] **Post-authorisation supervision is dual-track** — NCA supervises MiCA conduct and DORA operational resilience on separate cadences with separate triggers

**Reference:** MiCA Articles 34(10), 68(7)–(8); DORA Article 2(1)(f)

---

### 10.2 — MiFID II / DLT Pilot Regime Integration

For RWA tokenisation platforms (Segment 1 of the InnBlockchain Crypto Native ICP), DORA reaches the entity via MiFID II investment-firm classification or via DLT Pilot Regime trading-venue / SS / TSS authorisation — not via MiCA.

- [ ] **DORA scope confirmed via MiFID II / DLT Pilot Regime pathway**, not via CASP pathway (the firm may not be CASP-classified)
- [ ] **DLT Pilot Regime exemptions to settlement / transparency rules** do not extend to DORA — DORA applies in full

**Reference:** DORA Article 2(1)(e), (g), (i); DLT Pilot Regime Regulation (EU) 2022/858

---

### 10.3 — PSD3 / PSR Integration

For PIs, EMIs, and AISPs — DORA absorbs the PSD2 Article 96 operational and security incident reporting regime (Section 4.4 above) and the PSD2 RTS on ICT and security risk management.

- [ ] **Single ICT and security framework** covers both PSD3 and DORA obligations — no parallel frameworks
- [ ] **Strong customer authentication (SCA) controls** under PSD3 are protected within the DORA framework, not separate from it

**Reference:** DORA Articles 17, 23; PSD2 Article 96 (to be amended under PSD3)

---

### 10.4 — NIS2 Interaction

DORA is *lex specialis* for financial entities. NIS2 (Directive (EU) 2022/2555) Article 4(1) carves DORA out: where DORA imposes substantively equivalent obligations on cybersecurity risk management and incident notification, those NIS2 provisions (and the related supervision and enforcement in Chapter VII) do not apply to DORA-scope financial entities. **NIS2 is not displaced in its entirety** — entity-identification, registration in national NIS2 registries, and cooperation with national CSIRTs may still bite depending on Member State transposition.

- [ ] **NIS2 displacement confirmed at obligation level**, not as a blanket exemption — check Member State NIS2 transposition for residual registration / cooperation duties
- [ ] **Group-level interactions assessed** — non-financial group entities (holding companies, technology subsidiaries) may still fall directly under NIS2 even where the regulated affiliate falls under DORA
- [ ] **Cooperation with NIS2 CSIRTs** maintained via DORA Article 47

**Reference:** DORA Article 47; NIS2 Directive (EU) 2022/2555 Article 4(1)

---

## SECTION 11 — TIMELINE & KEY DATES

| Date | Milestone | Source |
|---|---|---|
| **27 December 2022** | DORA published in Official Journal (OJ L 333) | — |
| **16 January 2023** | DORA entered into force (20 days after publication) | Article 64(1) |
| **17 January 2025** | **DORA fully applicable** to all in-scope financial entities | Article 64(2) |
| **17 January 2025 onwards** | First Register of Information submission cycle to NCAs | Article 28(3) + ITS |
| **2025 onwards** | First CTPP designations by the ESAs | Article 31 |
| **2025–2026** | First TLPT cycles for designated entities | Articles 26–27 |
| **Ongoing** | Level 2 RTS / ITS continue to be issued and refined by ESAs / Commission | — |

- [ ] **Application date awareness** — DORA is fully in force; there is no transitional period for new entrants
- [ ] **Level 2 monitoring** — subscribe to EBA / ESMA / EIOPA Joint Committee publications; the Level 2 package is not static

**Reference:** DORA Article 64

---

## SECTION 12 — KEY LEVEL 2 INSTRUMENTS (Cross-Reference Map)

Treat these as **mandatory reading**, not optional guidance. They specify the substance of the obligations.

| Instrument | Subject | DORA hook |
|---|---|---|
| **Commission Delegated Regulation (EU) 2024/1772** | RTS on classification of major ICT-related incidents and significant cyber threats | Article 18 |
| **Commission Delegated Regulation (EU) 2024/1773** | RTS on policies for ICT services supporting critical or important functions | Articles 28, 30 |
| **Commission Delegated Regulation (EU) 2024/1774** | RTS on ICT risk management framework + simplified framework | Articles 15, 16 |
| **Commission Delegated Regulation (EU) 2024/1502** | RTS on criteria for CTPP designation | Article 31 |
| **Commission Implementing Regulation (EU) 2024/2956** | ITS on Register of Information templates | Article 28(9) |
| **Commission Delegated Regulation (EU) 2025/295** | RTS on TLPT | Article 26(11) |
| **Harmonised reporting RTS / ITS adopted under Article 20** | RTS on incident reporting content; ITS on templates and timelines | Articles 19, 20 |
| **RTS on sub-outsourcing adopted under Article 30(5)** | Sub-outsourcing controls for critical/important functions | Article 30 |

> **Legal advisor note:** The Level 2 package is still evolving — some delegated acts cited above have been amended once already, and others under Article 30(5) are at different stages of adoption. Always cite the current consolidated version from EUR-Lex, not the original OJ publication.

---

## READINESS SCORECARD — SUMMARY

*Count completed checkboxes per section.*

| Section | Topic | Items (approx) | Ready? |
|---|---|---|---|
| 1 | DORA applicability & CTPP candidacy | 30 | ☐ |
| 2 | Proportionality & TLPT classification | 7 | ☐ |
| 3 | Pillar 1 — ICT risk management framework | 38 | ☐ |
| 4 | Pillar 2 — Incident management & reporting | 14 | ☐ |
| 5 | Pillar 3 — Resilience testing (incl. TLPT) | 22 | ☐ |
| 6 | Pillar 4 — Third-party risk + Register + Exit | 21 | ☐ |
| 7 | Pillar 5 — Information sharing | 4 | ☐ |
| 8 | CTPP regime (vendors only) | 8 | ☐ |
| 9 | Supervision & penalty exposure | 5 | ☐ |
| 10 | Sectoral integration (MiCA, MiFID II, PSD3, NIS2) | 8 | ☐ |
| 11 | Timeline awareness | 2 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** DORA-supervision-ready; align with annual review cadence
- **Amber (50–80% complete):** Material gaps exist — close before next supervisory dialogue or before MiCA / sectoral authorisation
- **Red (<50% complete):** Significant preparation required — engage specialist counsel and an ICT security partner; allocate 6–12 months of remediation work

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for DORA-bound financial entities:**

**Pre-Build:** DORA scoping brief (which articles bind your entity) → ICT risk management framework drafting aligned to Commission Delegated Regulation (EU) 2024/1774 → third-party contractual provisions templates (Article 30(2)–(3)) → Register of Information template configuration → incident classification runbook against Commission Delegated Regulation (EU) 2024/1772 thresholds

**Build:** Smart-contract architecture with structured event schema for incident classification → on-chain audit trails for ICT changes affecting critical/important functions → multi-sig governance for protocol upgrades that meet Article 9 protection-and-prevention requirements → integration with SIEM / SOAR for automated Article 19 incident-report triage → backup and key custodianship design that meets Article 12 immutability requirements

**Audit:** Independent smart contract security audit suitable for inclusion in Article 25 basic testing battery → TLPT-readiness assessment for Article 26 designated entities → exit-strategy stress test (Article 28(8)) for protocol-layer dependencies

**Why financial entities choose us for the ICT layer:** DORA does not stop at the application boundary. Every smart contract that supports a critical or important function is part of your DORA estate. We design and audit that part of the estate to NCA-reviewable standards from day one — and we map each contract feature to the DORA article it satisfies, so your supervisor reads the architecture document alongside the regulation, not instead of it.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. DORA implementation is shaped by Level 2 Regulatory Technical Standards and Implementing Technical Standards adopted by the ESAs / Commission, national-NCA supervisory guidance, and ongoing ESAs Joint Committee Q&As. Always engage qualified EU financial-regulatory legal counsel for your specific entity, sector, and Member State.*

*Document version: 1.2 | Last updated: May 2026*
*Changes in v1.2 (verification pass against Regulation (EU) 2022/2554 verbatim text via locally-saved EUR-Lex HTML — 749KB `.raw/InnBlockchain/EU Compliance/dora.html`):*
*(1) **TLPT tester rule corrected** — v1.1 reversed the polarity: actual Article 26(8) rule is that financial entities CAN use internal testers but must contract external testers every three tests, and only significant credit institutions (SSM Reg Art 6(4)) are restricted to external testers exclusively.*
*(2) **CTPP penalty citation precised** — paragraph attribution: 35(6) is the trigger article; 35(7) sets the 6-month duration cap; 35(8) sets the 1% rate. v1.1 collapsed all three into "35(6)".*
*(3) **Article 50 scope corrected** — v1.1 implied Article 50 applies to CTPPs; corrected — Article 50 administrative penalties apply only to financial entities. CTPP enforcement is exclusively Lead Overseer regime (Arts 31–44) + periodic penalty payments (35(6)–(8)).*
*(4) **Article 18 classification criteria corrected** — actual count is 6 criteria (a)–(f), not 7. Reputational impact is bundled into criterion (a), not a standalone criterion.*
*(5) **Article 30(2) minimum provisions rewritten** — full 9-item verbatim list (a)–(i); v1.1 missed (d) data return on insolvency, (f) provider incident assistance, (i) security awareness participation; and wrongly placed (e) audit rights + (b) reporting obligations in 30(2) when they are actually in 30(3).*
*(6) **Article 30(3) CIF additional provisions rewritten** — full 6-item verbatim list (a)–(f); v1.1 missed (c) business contingency plans and ICT security measures requirement.*
*(7) **Article 16 simplified-framework list corrected** — v1.1 wrongly listed small insurance intermediaries in the simplified-framework category; corrected — they are FULLY OUT of DORA scope under Article 2(3) + recital 39. Per-instrument-list rewritten verbatim against Article 16(1) first subparagraph.*
*(8) **IORP full-exclusion threshold corrected** — Article 2(3)(c) says "not more than 15 members in total" (≤ 15), not "fewer than 15" (< 15) as v1.1 stated.*
*(9) **Microenterprise carve-out within the carve-out added** — Article 3(60) excludes trading venues, CCPs, trade repositories, and CSDs from microenterprise classification regardless of size.*
*Changes in v1.1: corrected TLPT tester rule against Article 26(8) (now superseded by v1.2); added Article 35(6) 6-month duration cap on CTPP periodic penalty payments and Article 50 administrative-penalty hook (Article 50 scope now corrected in v1.2); corrected CRD penalty citation to Articles 65–67; clarified microenterprise definition per Commission Recommendation 2003/361/EC (turnover OR balance sheet, not both); corrected Article 30 sub-outsourcing citation; refined NIS2 displacement framing per Article 4(1) (obligation-level, not blanket exemption).*
*Regulation reference: Regulation (EU) 2022/2554 of the European Parliament and of the Council of 14 December 2022 on digital operational resilience for the financial sector (DORA), as published in OJ L 333, 27 December 2022.*
*Verification artefact: `.raw/InnBlockchain/EU Compliance/dora.html` (local copy of EUR-Lex CELEX:32022R2554; live EUR-Lex blocks programmatic fetch via AWS WAF). All v1.2 corrections cross-checked against verbatim regulation text.*
