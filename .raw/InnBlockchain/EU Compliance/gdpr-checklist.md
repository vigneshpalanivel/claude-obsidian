# GDPR Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for Entities Processing EU Personal Data

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU General Data Protection Regulation (GDPR) — Regulation (EU) 2016/679
**Status:** Fully in force and applicable since **25 May 2018** *(Article 99)*
**Document type:** Pre-supervision readiness assessment — to be completed before the first DPA inspection, before launching a new processing activity, or as part of a vendor risk pack

**Official source:** https://eur-lex.europa.eu/eli/reg/2016/679/oj

---

> **Who this document is for:** General counsel, DPOs, CISOs, CTOs, product leads, and compliance officers at any entity that processes personal data of individuals in the EU/EEA — whether or not the entity is itself established in the EU. This checklist mirrors the intake assessment a specialist EU data-protection lawyer would walk you through in a first advisory session.

---

> **How to use this checklist:** GDPR is the **only genuinely universal horizontal regime** in the EU compliance landscape — it applies to *any* processing of EU residents' personal data, fintech or not, on-chain or off-chain, controller or processor. There is no "GDPR license" to apply for; supervision is by the national Data Protection Authority (DPA) of your main establishment, coordinated through the European Data Protection Board (EDPB). Work through each section in order. Items you cannot tick represent gaps that must be closed before your next DPA dialogue, customer audit, or new product launch.

---

## SECTION 1 — DOES GDPR APPLY TO YOU?

*GDPR scope is broader than any other EU regime — material scope (what is being processed) and territorial scope (where the controller/processor sits OR where the data subjects are) trigger independently. Either alone is enough to pull you in.*

---

### 1.1 — Material Scope (Article 2)

Tick every category that describes your activity. GDPR applies if any one is true.

- [ ] You process personal data wholly or partly by automated means (any digital system handling identifiable people)
- [ ] You process personal data forming part of a filing system or intended to form part of one (structured manual records)
- [ ] You hold customer / employee / prospect records that can identify a natural person directly or indirectly (name, email, IP address, device ID, pseudonymised wallet metadata linked to KYC, biometric template, etc.)
- [ ] You handle KYC / AML records collected under AMLR / AMLD6 (GDPR still applies to that processing — see Section 12)
- [ ] You process on-chain data that can be linked to an identifiable natural person (wallet address tied to KYC, transaction graph analytics, oracle inputs containing personal data)

**Scope exclusions (Article 2(2)) — check only if these clearly describe your situation:**

- [ ] Processing in the course of a purely personal or household activity (not commercial)
- [ ] Processing by competent authorities for criminal-law enforcement (covered by the Law Enforcement Directive 2016/680, not GDPR)
- [ ] Processing falling outside the scope of EU law (national security, defence)

> **Legal advisor note:** Two common misframes — (i) **"pseudonymous = anonymous"** is wrong. Pseudonymised data (wallet addresses, hashed identifiers, tokenised IDs) is still personal data under Recital 26 if re-identification is reasonably possible. Only *truly anonymised* data — where re-identification is no longer reasonably possible by any means — falls outside GDPR. (ii) **"On-chain ≠ personal data"** is also wrong. **EDPB Guidelines 02/2025 on processing of personal data through blockchain technologies** (adopted 14 April 2025) confirms that wallet addresses and transaction data linked to identified or identifiable persons are personal data and subject to GDPR.

**Reference:** GDPR Article 2; Recital 26; EDPB Guidelines 02/2025 on processing of personal data through blockchain technologies; CNIL "Blockchain and the GDPR" (29 October 2018)

---

### 1.2 — Territorial Scope (Article 3)

GDPR applies extraterritorially. Tick every trigger that applies.

- [ ] **Establishment trigger (Art. 3(1)):** Your entity (controller or processor) has an establishment in the EU/EEA — processing happens "in the context of" that establishment, regardless of whether processing itself occurs in the EU
- [ ] **Targeting trigger (Art. 3(2)(a)):** You are not established in the EU but you offer goods or services to data subjects in the EU/EEA (paid or free) — language, currency, EU customer references, .eu TLD, EU-targeted ads all count as evidence
- [ ] **Monitoring trigger (Art. 3(2)(b)):** You are not established in the EU but you monitor the behaviour of data subjects in the EU/EEA (web tracking, behavioural advertising, fraud monitoring of EU users)
- [ ] **Public international law trigger (Art. 3(3)):** Processing takes place where Member State law applies by virtue of public international law (embassies, consulates)

> **Legal advisor note:** The targeting trigger is the **most under-estimated** by non-EU fintechs and crypto firms. Accepting EU customer KYC, allowing EUR deposits, providing a German-language interface, or running ads targeted at EU residents are each independently enough. If any targeting indicator is present, you also need an **Article 27 representative** in the EU (Section 7.4) unless an exception applies.

**Reference:** GDPR Article 3; EDPB Guidelines 3/2018 on the territorial scope of the GDPR

---

### 1.3 — Article 27 EU Representative (For Non-EU Entities Only)

If GDPR applies via Art. 3(2) and you have no EU establishment:

- [ ] **Article 27 representative** appointed in writing in a Member State where the data subjects you target are located
- [ ] Representative's contact details published in your privacy notice (Art. 13(1)(a), 14(1)(a))
- [ ] Representative mandated to act on behalf of the controller / processor with DPAs and data subjects
- [ ] Exception assessment documented if you rely on the **Art. 27(2)** carve-out (occasional processing, not large-scale, no special-category or criminal-conviction data, low risk)

> **Legal advisor note:** The Art. 27(2) exception is narrow and fact-specific. "Occasional" means truly one-off — a running fintech onboarding pipeline does not qualify. DPAs (notably the French CNIL and the Dutch AP) have issued enforcement decisions against non-EU controllers operating without a representative.

**Reference:** GDPR Article 27; EDPB Guidelines 3/2018

---

## SECTION 2 — ROLE CLASSIFICATION (Articles 4, 26, 28)

*Whether you are a controller, joint controller, or processor determines every downstream obligation. Misclassifying your role is the second most common scoping error after misjudging territorial scope.*

---

### 2.1 — Controller vs Processor Self-Assessment

For each distinct processing activity, document:

- [ ] **Purpose** — *why* the data is processed (controller decides purpose; processor follows instructions)
- [ ] **Means** — essential means (controller decides) vs non-essential / technical means (processor may decide)
- [ ] **Data categories** decided by controller
- [ ] **Data subjects** identified by controller
- [ ] **Retention period** set by controller
- [ ] **Recipients / transfer decisions** made by controller

> **Legal advisor note:** A SaaS vendor "merely hosting" data is usually a processor. The moment that vendor starts analysing data for its own product improvement, training AI models on customer data, or determining what data to collect, it becomes an independent controller (or joint controller) for that activity. **RegTech vendors** — the AMLR scoping says you are not an obliged entity, but under GDPR you may well be a joint controller for fraud-scoring models that learn across customers.

**Reference:** GDPR Article 4(7), 4(8); EDPB Guidelines 07/2020 on the concepts of controller and processor

---

### 2.2 — Joint Controllership (Article 26)

If you and another entity jointly determine the purposes and means of processing:

- [ ] **Joint controllership arrangement** in writing, in transparent form
- [ ] Allocation of responsibilities documented (who answers data subject requests, who notifies breaches, who handles DPIA)
- [ ] Essence of the arrangement made available to data subjects
- [ ] Single point of contact identified (optional but recommended)

> **Legal advisor note:** Joint controllership traps to watch for: (i) co-branded onboarding flows where two firms each see the same data; (ii) referral / affiliate arrangements where data is shared for joint marketing decisions; (iii) on-chain protocols where multiple participants (frontend operator, validator, indexer) each shape the processing of the same wallet data — the CJEU's *Wirtschaftsakademie*, *Fashion ID*, and *Jehovan todistajat* cases set a low bar.

**Reference:** GDPR Article 26; CJEU C-210/16 (*Wirtschaftsakademie*); C-40/17 (*Fashion ID*); C-25/17 (*Jehovan todistajat*)

---

### 2.3 — Processor Status (Article 28)

If you are processing personal data on behalf of another controller:

- [ ] Written contract or other legal act in place with the controller (Art. 28(3))
- [ ] Contract covers the **mandatory minimum content** of Art. 28(3)(a)–(h): subject-matter, duration, nature, purpose, types of personal data, categories of data subjects, controller's obligations and rights
- [ ] Documented instructions from controller (general or specific)
- [ ] Confidentiality commitments from processor personnel
- [ ] Article 32 security measures implemented
- [ ] Sub-processor regime: prior authorisation (specific or general) and onward Art. 28(4) flow-down contracts
- [ ] Assistance to controller for Art. 32–36 obligations (security, breach notification, DPIA, prior consultation)
- [ ] Assistance to controller for data subject rights (Chapter III)
- [ ] Deletion / return of data at end of services, certifying destruction
- [ ] Audit rights granted to controller

> **Legal advisor note:** Many "DPA addenda" use the Commission's **2021/915 Standard Contractual Clauses for controller-to-processor (intra-EU)** — these are pre-approved and remove negotiation friction. Use them as the default; only deviate where a customer has specific contractual reasons.

**Reference:** GDPR Article 28; Commission Implementing Decision (EU) 2021/915 (controller-to-processor SCCs intra-EU)

---

## SECTION 3 — LAWFUL BASIS FOR PROCESSING (Articles 6, 9, 10)

*Every processing activity must rest on at least one of six Article 6 lawful bases. Special-category data and criminal-conviction data require an additional Article 9 or 10 condition. "GDPR by consent" is the most common over-reliance — for fintech onboarding, consent is usually the **wrong** basis.*

---

### 3.1 — Article 6 Lawful Bases Mapping

For each processing activity, identify and document the lawful basis:

- [ ] **Consent (Art. 6(1)(a))** — freely given, specific, informed, unambiguous; withdrawable; documented; not bundled with contract
- [ ] **Contract necessity (Art. 6(1)(b))** — processing necessary to perform a contract with the data subject, or pre-contractual steps
- [ ] **Legal obligation (Art. 6(1)(c))** — required by EU or Member State law (AML CDD, tax records, financial reporting)
- [ ] **Vital interests (Art. 6(1)(d))** — protecting life of data subject or another person
- [ ] **Public interest / official authority (Art. 6(1)(e))** — usually only relevant for public bodies
- [ ] **Legitimate interests (Art. 6(1)(f))** — balancing test (Legitimate Interest Assessment, LIA) documented; not available to public authorities in their tasks

> **Legal advisor note:** For fintech onboarding: **KYC = legal obligation (Art. 6(1)(c) read with AMLR Art. 3 + AMLD6 transposition)**, *not* consent. For marketing emails to existing customers: usually **legitimate interests (Art. 6(1)(f))** with PECR / ePrivacy soft-opt-in. For cookies and similar tracking: **consent** under ePrivacy Directive (national implementations), then GDPR Art. 6(1)(a) for the processing of the resulting personal data. Stacking the wrong basis is a structural finding — DPAs flag it on first review.

**Reference:** GDPR Article 6; EDPB Guidelines 05/2020 on consent; EDPB Guidelines 2/2019 on processing in the context of the provision of online services to data subjects

---

### 3.2 — Article 9 Special Categories of Personal Data

If you process any of the following, you need a Article 9(2) condition in addition to Art. 6:

- [ ] Racial or ethnic origin
- [ ] Political opinions
- [ ] Religious or philosophical beliefs
- [ ] Trade union membership
- [ ] Genetic data
- [ ] Biometric data **for the purpose of uniquely identifying a natural person** (face match in KYC, fingerprint login, voice biometrics)
- [ ] Health data
- [ ] Sex life or sexual orientation

If yes, tick the Art. 9(2) condition relied on:

- [ ] (a) Explicit consent (separate from Art. 6 consent)
- [ ] (b) Employment / social security / social protection law
- [ ] (c) Vital interests where data subject incapable of consent
- [ ] (e) Manifestly made public by data subject
- [ ] (f) Legal claims / judicial acts
- [ ] (g) Substantial public interest in EU / Member State law
- [ ] (h) Preventive / occupational medicine
- [ ] (i) Public health
- [ ] (j) Archiving, scientific / historical research, statistics

> **Legal advisor note:** **Biometric KYC** (selfie + liveness, document-photo face-match) is the most common Art. 9 trigger in fintech and crypto. The default condition for facial-recognition KYC is **(a) explicit consent** — separate from the Art. 6 KYC obligation basis — and consent must be genuinely refusable (you must offer a non-biometric KYC fallback, or your "consent" is invalid for being unfreely given). Several DPAs (CNIL, Garante) have already enforced on this.

**Reference:** GDPR Article 9; EDPB Guidelines 05/2022 on the use of facial recognition technology in the area of law enforcement (analogous principles)

---

### 3.3 — Article 10 Criminal Convictions and Offences Data

- [ ] Document if you process personal data relating to criminal convictions and offences or related security measures
- [ ] Confirm processing is carried out under the control of official authority OR authorised by EU / Member State law providing appropriate safeguards
- [ ] If running sanctions / PEP / adverse-media screening for AML: identify Member-State-specific authorisation (these vary materially; some Member States permit only by reference to AMLR obligations, others require DPA notification)

> **Legal advisor note:** Sanctions screening, PEP screening, and adverse-media screening typically pull data that falls under Art. 10. The interaction with AMLR is settled — the obligation exists — but the *national* authorisation for the processing is not uniform. For pan-EU operations, get a per-Member-State legal opinion.

**Reference:** GDPR Article 10

---

## SECTION 4 — PRINCIPLES (Article 5)

*Article 5 is the constitutional layer of GDPR. Every processing activity must satisfy all seven principles. Article 5(2) is the accountability principle — the controller must be able to **demonstrate** compliance, not merely be compliant.*

---

### 4.1 — Article 5(1) Substantive Principles

- [ ] **Lawfulness, fairness, transparency** — documented lawful basis + plain-language notices + no covert processing
- [ ] **Purpose limitation** — purposes specified, explicit, legitimate; no incompatible secondary use without fresh basis
- [ ] **Data minimisation** — adequate, relevant, limited to what is necessary; defaults reviewed; over-collection in onboarding flagged
- [ ] **Accuracy** — data accurate, kept up to date; inaccurate data erased or rectified without delay
- [ ] **Storage limitation** — retention schedule documented; deletion / anonymisation triggers in place; retention aligned to legal-obligation periods (AML: 5 years per AMLR Art. 77; tax: 6–10 years; employment: varies)
- [ ] **Integrity and confidentiality** — Article 32 measures (Section 8)

### 4.2 — Article 5(2) Accountability Principle

- [ ] Records of processing activities (Section 5.3)
- [ ] Documented lawful basis register
- [ ] DPIA register (Section 7.2)
- [ ] Policies + training + audit trail
- [ ] Ability to demonstrate compliance on demand to the DPA

> **Legal advisor note:** Accountability is the principle that makes GDPR a paper-trail regime. **Compliance without documentation = non-compliance** in the eyes of any DPA. The first request in an inspection is almost always: "Show me your Article 30 records and your DPIA register."

**Reference:** GDPR Article 5

---

## SECTION 5 — CONTROLLER OBLIGATIONS (Articles 24, 25, 30, 35, 37–39)

*The controller's structural obligations sit independently of any one processing activity. These are the artefacts a DPA expects to see on the first day of an inspection.*

---

### 5.1 — Data Protection by Design and by Default (Article 25)

- [ ] **By design**: data-protection considerations integrated into product / system design from inception (pseudonymisation, data minimisation, access controls, encryption by default)
- [ ] **By default**: only data necessary for each specific purpose is processed by default; defaults do not require user action to limit collection
- [ ] Documented design reviews for new products / features
- [ ] Privacy-friendly defaults in customer-facing interfaces (no pre-ticked boxes, no opt-out marketing as default)

> **Legal advisor note:** Smart-contract systems are especially exposed under Art. 25 — **immutability** conflicts with data minimisation and storage limitation. EDPB Guidelines 02/2025 expect controllers to design *off-chain* the personal-data layer (store personal data off-chain, anchor only hashes on-chain) so that erasure and rectification remain possible.

**Reference:** GDPR Article 25; EDPB Guidelines 4/2019 on Article 25; EDPB Guidelines 02/2025 on blockchain

---

### 5.2 — Article 30 Records of Processing Activities (RoPA)

Required if you are not a small org under the Art. 30(5) carve-out (the carve-out is narrow — almost no fintech qualifies).

**Controller RoPA (Art. 30(1))** — for each processing activity:

- [ ] Name and contact details of controller, joint controller, DPO, representative
- [ ] Purposes of the processing
- [ ] Categories of data subjects
- [ ] Categories of personal data
- [ ] Categories of recipients (including third countries)
- [ ] International transfers + safeguards (Section 9)
- [ ] Retention periods
- [ ] General description of Article 32 security measures

**Processor RoPA (Art. 30(2))** — for each controller you serve:

- [ ] Name + contact of processor, processor's DPO / representative
- [ ] Name + contact of each controller
- [ ] Categories of processing carried out
- [ ] International transfers + safeguards
- [ ] General description of Article 32 security measures

> **Legal advisor note:** The Art. 30(5) carve-out (under 250 employees, not regular processing, no risk to rights, no special-category) almost never applies to fintech — AML data and onboarding records each break the exception independently. Treat RoPA as mandatory.

**Reference:** GDPR Article 30

---

### 5.3 — Data Protection Officer (Articles 37–39)

Designate a DPO if any of these is true:

- [ ] You are a public authority or body (other than courts acting in their judicial capacity)
- [ ] Your core activities require regular and systematic monitoring of data subjects on a large scale
- [ ] Your core activities consist of large-scale processing of special-category or criminal-conviction data

If yes, the DPO must be:

- [ ] Designated based on professional qualities (expert knowledge of data-protection law and practice)
- [ ] Published in privacy notice + notified to the DPA
- [ ] Resourced sufficiently and granted access to processing operations
- [ ] Independent — no instructions on tasks, no dismissal / penalty for performing tasks
- [ ] Reporting to highest management level
- [ ] Free from conflicts of interest (cannot also be Head of IT, CISO, Head of Legal, CEO in most cases — EDPB & CJEU C-453/21)

> **Legal advisor note:** Most fintechs trigger DPO mandation via "large-scale processing" of KYC data (financial data is treated as inherently sensitive even if not Art. 9 special-category). Voluntary DPO appointment also triggers the full Art. 37–39 regime — there is no "DPO-lite." For non-EU controllers, the DPO and Art. 27 representative are *distinct roles* — you may need both.

**Reference:** GDPR Articles 37–39; EDPB Guidelines on DPOs (WP243 rev.01); CJEU C-453/21 (X-FAB Dresden)

---

## SECTION 6 — DATA SUBJECT RIGHTS (Articles 12–22)

*Eight enforceable rights, each with strict timelines (one month, extendable by two months for complex requests). Failure to honour rights is the most common consumer-driven complaint to DPAs.*

---

### 6.1 — Operational Rights-Handling Capability

For each right below, you must have a documented procedure, an audited workflow, and a one-month response capacity:

- [ ] **Right to information (Art. 13, 14)** — privacy notice provided at collection
- [ ] **Right of access (Art. 15)** — DSAR pipeline; identity verification; data export format; "manifestly unfounded or excessive" assessment criteria documented
- [ ] **Right to rectification (Art. 16)** — correction workflow; downstream notification (Art. 19)
- [ ] **Right to erasure / "right to be forgotten" (Art. 17)** — including the six grounds and the five exceptions; smart-contract erasure strategy documented
- [ ] **Right to restriction of processing (Art. 18)** — flag / suspend processing without deleting
- [ ] **Notification obligation (Art. 19)** — communicate rectification / erasure / restriction to all recipients
- [ ] **Right to data portability (Art. 20)** — structured, commonly used, machine-readable format; covers only Art. 6(1)(a) or 6(1)(b) processing carried out by automated means
- [ ] **Right to object (Art. 21)** — including absolute right to object to direct-marketing processing
- [ ] **Right not to be subject to automated decision-making, including profiling (Art. 22)** — covers solely automated decisions producing legal effects or similarly significant effects; safeguards (human review, contest right) where exceptions apply

### 6.2 — Right-Specific Edge Cases

- [ ] DSAR cap on third-party data (you do not have to disclose data that would identify another person without their consent)
- [ ] Art. 22 trigger map for credit-scoring (LendTech), fraud detection (PayTech, RegTech), pricing decisions (InsurTech), and on-chain AI agents making autonomous financial decisions (Seg 10 AI×Crypto) — see Section 12
- [ ] **Smart-contract erasure plan**: where personal data is on-chain and cannot be deleted, document the technical and organisational measures (off-chain storage with on-chain hash, key destruction / "cryptographic erasure," pseudonymisation) used to approximate erasure — EDPB Guidelines 02/2025 require this to be designed in from inception

> **Legal advisor note:** "We can't delete it because it's on-chain" is not a defence. Either you designed the personal data off-chain (acceptable), or you put personal data on-chain knowing erasure was impossible (structural Art. 17 + Art. 25 violation). Get this right at architecture stage, not at the DSAR stage.

**Reference:** GDPR Articles 12–22; EDPB Guidelines 01/2022 on data subject rights – right of access; EDPB Guidelines 05/2020 on consent; EDPB Guidelines 02/2025 on blockchain

---

## SECTION 7 — TRANSPARENCY, DPIA & PRIOR CONSULTATION (Articles 13, 14, 35, 36)

---

### 7.1 — Privacy Notices (Articles 13, 14)

- [ ] **Art. 13 notice** provided at the time data is collected from the data subject
- [ ] **Art. 14 notice** provided where data is collected from a third party (within one month, latest)
- [ ] Notice includes: identity + contact of controller and DPO / representative; purposes + lawful basis; legitimate interests (if Art. 6(1)(f)); recipients; international transfers + safeguards; retention periods; data-subject rights; right to withdraw consent (if applicable); right to lodge a complaint with DPA; whether provision is statutory / contractual + consequences of refusal; automated decision-making logic, significance, and consequences (where Art. 22 applies)
- [ ] Notice in plain language, concise, intelligible, easily accessible
- [ ] Layered notice design used for complex products (just-in-time + full text)

### 7.2 — Data Protection Impact Assessment (Article 35)

DPIA is mandatory where processing is likely to result in high risk. Tick all that apply:

- [ ] Systematic and extensive evaluation of personal aspects based on automated processing, including profiling, producing legal effects (Art. 35(3)(a)) — *credit scoring, automated fraud blocking, on-chain agent decisions*
- [ ] Large-scale processing of special-category or criminal-conviction data (Art. 35(3)(b)) — *biometric KYC, sanctions / PEP screening*
- [ ] Systematic monitoring of publicly accessible area on a large scale (Art. 35(3)(c)) — *less common in fintech; relevant for physical-branch CCTV*
- [ ] Any processing on the DPA's published "must-DPIA" list (Art. 35(4)) — *check your lead DPA's national list*

DPIA must include:

- [ ] Systematic description of processing operations and purposes
- [ ] Necessity and proportionality assessment
- [ ] Risks to rights and freedoms of data subjects
- [ ] Measures to address the risks, including safeguards, security measures, and mechanisms

### 7.3 — Prior Consultation (Article 36)

- [ ] If residual high risk remains after DPIA mitigation, consult the lead DPA before commencing processing
- [ ] Document the DPA's written advice (which the DPA must provide within 8 weeks, extendable by 6 weeks for complex cases)

> **Legal advisor note:** DPIA is the artefact that most directly maps to **EU AI Act Article 27 FRIA** (Fundamental Rights Impact Assessment) for high-risk AI. Where AI Act applies (credit scoring in LendTech, fraud in RegTech, on-chain agents in Seg 10), DPIA and FRIA can be combined as a single Art. 35 + AI Act assessment — saves duplication and demonstrates joined-up governance.

**Reference:** GDPR Articles 35, 36; EDPB Guidelines 4/2017 on DPIA (WP248 rev.01); EU AI Act Article 27

---

### 7.4 — Documentation Bundle for First DPA Meeting

If summoned to a first meeting with your DPA, expect them to ask for:

- [ ] Article 30 RoPA
- [ ] DPIA register + sample DPIAs
- [ ] Privacy notice and customer-facing data-rights pages
- [ ] DPO designation document + DPO independence assurance
- [ ] Article 27 representative designation (if non-EU)
- [ ] Article 32 security measures summary
- [ ] Latest breach register (Art. 33 internal log)
- [ ] Processor / sub-processor inventory with Art. 28 contracts
- [ ] International transfer inventory with TIA + transfer mechanism (Section 9)
- [ ] Records of consent (where consent is the basis)
- [ ] LIA documentation (where legitimate interests is the basis)

---

## SECTION 8 — SECURITY & BREACH NOTIFICATION (Articles 32–34)

---

### 8.1 — Article 32 Security of Processing

Implement appropriate technical and organisational measures, including as appropriate:

- [ ] Pseudonymisation and encryption of personal data
- [ ] Ongoing confidentiality, integrity, availability, resilience of processing systems
- [ ] Ability to restore availability and access to data in a timely manner in the event of a physical or technical incident
- [ ] Process for regularly testing, assessing, and evaluating the effectiveness of measures
- [ ] Risk-based selection of measures aligned to the nature, scope, context, and purposes of processing

> **Legal advisor note:** Art. 32 is **deliberately principles-based**. There is no checklist of "the right" measures. For DORA-bound financial entities, the **DORA Pillar 1 ICT risk management framework satisfies Art. 32 for the in-scope ICT estate** — but DORA is wider than personal data and Art. 32 covers more than ICT (physical security, vetting, training). Use DORA artefacts as evidence; do not assume DORA covers all GDPR security.

**Reference:** GDPR Article 32; DORA Regulation (EU) 2022/2554 Articles 5–16 (for in-scope financial entities)

---

### 8.2 — Article 33 Notification to the DPA

In the event of a personal data breach:

- [ ] Internal incident register maintained continuously (Art. 33(5))
- [ ] **Breach assessment framework**: is there a "risk to the rights and freedoms of natural persons"? If yes, notification required
- [ ] **72-hour notification clock** from awareness — notify lead DPA without undue delay and, where feasible, within 72 hours
- [ ] If beyond 72 hours: reasoned justification accompanies the notification
- [ ] Notification content: nature of breach, categories + approximate number of data subjects and records, contact point, likely consequences, measures taken / proposed
- [ ] Phased notification permitted where full info not available at 72 hours

### 8.3 — Article 34 Communication to Data Subjects

If the breach is likely to result in a **high risk** to rights and freedoms:

- [ ] Communicate to affected data subjects without undue delay, in clear and plain language
- [ ] Exceptions: encryption rendering data unintelligible; subsequent measures eliminating high risk; disproportionate effort (use public communication instead)
- [ ] DPA can compel communication under Art. 34(4) even if the controller has not assessed high risk

> **Legal advisor note:** The interplay with **DORA major-ICT-incident reporting** (Article 19) and **NIS2 incident reporting** is not a substitute for GDPR Art. 33 — they coexist. A single incident can trigger up to four notifications: DPA (GDPR), competent authority (DORA), CSIRT (NIS2), and AMLA/national FIU (if AML data implicated). Build a unified incident-classification engine; do not silo by regulation.

**Reference:** GDPR Articles 33, 34; EDPB Guidelines 9/2022 on personal data breach notification

---

## SECTION 9 — INTERNATIONAL TRANSFERS (Articles 44–50)

*Any transfer of personal data from the EU/EEA to a third country needs a Chapter V transfer mechanism. Schrems II (CJEU C-311/18) means even valid mechanisms now require a transfer impact assessment (TIA).*

---

### 9.1 — Transfer Inventory

- [ ] Map every flow of personal data from EU/EEA to a third country (group entities, SaaS vendors, cloud regions, sub-processors, customer-data exports)
- [ ] Identify each importer, jurisdiction, purpose, data categories, volume, sensitivity
- [ ] Identify the Art. 44–49 mechanism relied on for each transfer

### 9.2 — Transfer Mechanism Selection

- [ ] **Adequacy decision (Art. 45)** — transfer to an adequate country (current list: UK, Switzerland, Andorra, Argentina, Canada (commercial), Faroe Islands, Guernsey, Israel, Isle of Man, Japan, Jersey, New Zealand, Republic of Korea, United States (DPF participants only), Uruguay)
- [ ] **Appropriate safeguards (Art. 46)** — Standard Contractual Clauses (Commission Implementing Decision (EU) 2021/914); Binding Corporate Rules approved under Art. 47; approved code of conduct / certification mechanism with binding commitments
- [ ] **Derogations for specific situations (Art. 49)** — narrow: explicit consent for the specific transfer; contract necessity; important reasons of public interest; legal claims; vital interests; data from a public register; "compelling legitimate interests" (one-off, limited, not repetitive — EDPB has stressed this is exceptional)

### 9.3 — Transfer Impact Assessment (Schrems II)

For Art. 46 transfers (especially SCCs), document:

- [ ] Mapping of the transfer (parties, jurisdictions, purposes)
- [ ] Assessment of the third-country legal regime (surveillance laws, government access, redress rights)
- [ ] Identification of supplementary measures (technical: end-to-end encryption with EU-held keys, pseudonymisation; contractual: enhanced clauses; organisational: split processing)
- [ ] Re-evaluation cadence (annual or upon change in legal regime)

> **Legal advisor note:** **EU–US Data Privacy Framework (DPF)** restored adequacy for self-certified US importers from July 2023. But DPF is under active legal challenge (Schrems III is pending), and political risk in 2025–2026 is non-trivial. Do not architect EU–US flows assuming DPF is permanent — keep SCC fallbacks pre-signed.

**Reference:** GDPR Articles 44–50; Commission Implementing Decision (EU) 2021/914 (controller-to-processor + controller-to-controller SCCs for international transfers); EDPB Recommendations 01/2020 on supplementary measures; CJEU C-311/18 (Schrems II)

---

## SECTION 10 — SUPERVISION, COOPERATION & ONE-STOP-SHOP (Articles 51–76)

---

### 10.1 — Lead DPA Identification

- [ ] Identify your **main establishment** (place of central administration in EU; if processing decisions are made elsewhere in EU, that place)
- [ ] The DPA of the main establishment is your **lead supervisory authority** for cross-border processing (Art. 56)
- [ ] Other concerned DPAs (Member States where data subjects are substantially affected) are coordinated through the **consistency mechanism** (Art. 63–67)

### 10.2 — One-Stop-Shop Mechanics

- [ ] Document your lead DPA designation analysis (cross-border processing definition: substantially affects data subjects in more than one Member State, or affects only one but processing happens in establishments in more than one)
- [ ] Operating model for handling DPA inquiries from a non-lead DPA (route through lead; cooperate; do not respond unilaterally)

### 10.3 — EDPB Coordination

- [ ] Monitor EDPB binding decisions under Art. 65 (consistency mechanism dispute resolution)
- [ ] Track EDPB guidelines, recommendations, and opinions — they bind via the consistency mechanism even though formally non-binding

> **Legal advisor note:** For fintech / crypto firms, the lead DPA is usually where the EU HQ sits (Dublin DPC for many global SaaS players, CNIL for France-headquartered, BfDI / state DPAs for Germany — Germany has multiple, with a federal coordination layer). **Non-EU controllers under Art. 3(2) do not have a lead DPA under one-stop-shop** — every DPA where targeted data subjects sit can act independently against them. This is a frequent surprise for US fintechs entering the EU.

**Reference:** GDPR Articles 51–76; EDPB Guidelines 8/2022 on identifying a controller or processor's lead supervisory authority

---

## SECTION 11 — REMEDIES, LIABILITY & PENALTIES (Articles 77–84)

---

### 11.1 — Penalty Exposure

GDPR imposes a two-tier administrative-fine regime (Art. 83):

- [ ] **Tier 1 (Art. 83(4)):** Up to **€10 million or 2% of total worldwide annual turnover** of the preceding financial year, whichever is higher — for breaches of controller/processor obligations (Art. 8, 11, 25–39, 42, 43)
- [ ] **Tier 2 (Art. 83(5)):** Up to **€20 million or 4% of total worldwide annual turnover**, whichever is higher — for breaches of basic principles (Art. 5, 6, 7, 9), data subjects' rights (Art. 12–22), international transfers (Art. 44–49), Member State law obligations under Chapter IX, non-compliance with DPA orders (Art. 58(2))
- [ ] Document the Art. 83(2) aggravating / mitigating factors framework (nature, gravity, duration, intentional / negligent, mitigation measures, technical and organisational measures, cooperation, etc.)

### 11.2 — Civil Liability

- [ ] **Art. 82 right to compensation** — material and non-material damage; controllers and processors jointly liable for the damage caused; CJEU C-300/21 confirms threshold-of-damage element exists (not all minor anxieties qualify) but threshold is low
- [ ] Data-subject collective-action exposure under Art. 80 + national consumer-collective-redress laws

### 11.3 — Right to Lodge a Complaint + Judicial Remedies

- [ ] Data subjects have an unconditional right to complain to a DPA (Art. 77) and seek judicial remedy (Art. 79)
- [ ] Maintain a complaint-handling workflow that minimises escalation to DPA (in-house ombuds, ADR, plain-language response)

> **Legal advisor note:** Headline GDPR fines that have shaped enforcement: **Meta €1.2bn (DPC, 2023)** for international transfers; **Amazon €746m (CNPD Luxembourg, 2021)**; **WhatsApp €225m (DPC, 2021)** for transparency; **Google €50m (CNIL, 2019)** for consent. Crypto-specific: enforcement against CASPs has so far been at DPA level rather than headline, but **on-chain personal data on immutable ledgers is the next likely enforcement frontier** (EDPB Guidelines 02/2025 signals it). Treat GDPR exposure as comparable to AML / MiCA — sometimes higher in absolute fine terms.

**Reference:** GDPR Articles 77–84; CJEU C-300/21 (Österreichische Post); EDPB Guidelines 04/2022 on the calculation of administrative fines

---

## SECTION 12 — GDPR INTERACTION WITH OTHER EU REGIMES

*GDPR sits underneath every other EU fintech regime. The interactions create tension that needs to be designed for, not solved at the breach stage.*

---

### 12.1 — GDPR ↔ AML / AMLA

- [ ] Document the **Art. 6(1)(c) legal-obligation basis** for KYC / CDD / STR processing
- [ ] Document **Art. 10 authorisation** for sanctions / PEP / criminal-data processing per Member State
- [ ] **Retention conflict**: AMLR Art. 77 requires 5-year retention of CDD records; GDPR storage limitation requires deletion after purpose ends. Resolve by documenting the 5-year period as the GDPR retention period under the legal-obligation basis; delete on day 1 of year 6 unless extension is justified
- [ ] **Cross-border data sharing under AMLA**: AMLA's supervisory data flows engage GDPR; rely on Art. 6(1)(c) + the EU-law-mandated transfer basis under Art. 49(1)(d)
- [ ] EDPB is finalising guidance on the GDPR–AMLA reconciliation — monitor

### 12.2 — GDPR ↔ EU AI Act

- [ ] **DPIA + FRIA convergence** — combine into a single assessment (Section 7.2)
- [ ] **Art. 22 GDPR + AI Act Art. 26 deployer obligations** — automated decisions producing legal / similarly significant effects require both transparency, human review, and AI Act post-market monitoring
- [ ] **Training data lineage** — where personal data is used in AI training, document lawful basis + data minimisation + retention; legitimate-interests balancing is fact-intensive for model training (EDPB Opinion 28/2024 on AI models)
- [ ] **High-risk AI in fintech**: credit scoring (LendTech), fraud detection (RegTech, PayTech), biometrics (KYC across all FinTech segments), insurance underwriting (InsurTech), on-chain agents (Seg 10) — DPIA mandatory under Art. 35(3)(a)–(b) **and** AI Act FRIA under Art. 27

### 12.3 — GDPR ↔ DORA

- [ ] **DORA Art. 5–16 ICT risk management = Art. 32 GDPR security evidence** for the in-scope ICT estate
- [ ] **DORA Art. 19 incident reporting ≠ GDPR Art. 33 breach notification** — a single incident may require both, with different scoping and timelines (DORA: classification under Commission Delegated Regulation (EU) 2024/1772; GDPR: rights-and-freedoms risk)
- [ ] DORA-bound entities (most FinTech segments) should integrate breach taxonomy across both regimes

### 12.4 — GDPR ↔ MiCA / Crypto

- [ ] **On-chain personal data**: design off-chain personal data + on-chain hash anchoring (Section 6.2)
- [ ] **TFR Travel Rule (Reg 2023/1113)**: information flows between CASPs about originator / beneficiary engage GDPR; rely on Art. 6(1)(c) for the TFR-mandated transfer; minimum-necessary fields only
- [ ] **MiCA Title V CASP authorisation**: NCA application requires GDPR compliance evidence — include RoPA, DPIA, and DPO designation in the authorisation dossier

### 12.5 — GDPR ↔ eIDAS 2.0

- [ ] **EUDI Wallet acceptance**: relying-party requirements interact with GDPR data-minimisation — accept only the attributes strictly necessary for the KYC use case
- [ ] **Selective disclosure**: EUDI Wallet supports selective-disclosure cryptography; design KYC pipelines to consume only the disclosed attributes (privacy-by-design alignment with Art. 25)

> **Legal advisor note:** Treat GDPR as the **foundational layer** under every fintech regime: AML, MiCA, DORA, AI Act, eIDAS 2.0 each impose information-handling rules that must dovetail with GDPR. The most efficient operating model is a single data-protection function that maps each obligation to a single source of truth (the RoPA), with regulation-specific overlays — not parallel siloed compliance shops.

**Reference:** GDPR Articles 6, 10, 32–35; AMLR (Reg 2024/1624); EU AI Act (Reg 2024/1689) Articles 26, 27; DORA (Reg 2022/2554) Articles 5–19; MiCA (Reg 2023/1114); TFR (Reg 2023/1113); eIDAS 2.0 (Reg 2024/1183); EDPB Guidelines 02/2025 (blockchain); EDPB Opinion 28/2024 (AI models)

---

## SECTION 13 — TIMELINE & KEY DATES

| Date | Milestone | Source |
|---|---|---|
| **27 April 2016** | GDPR adopted | OJ L 119, 4 May 2016 |
| **24 May 2016** | GDPR entered into force | Article 99(1) |
| **25 May 2018** | **GDPR became applicable** | Article 99(2) |
| **16 July 2020** | CJEU Schrems II invalidates EU–US Privacy Shield | C-311/18 |
| **4 June 2021** | Commission adopts new SCCs (Implementing Decision 2021/914) | OJ L 199, 7 Jun 2021 |
| **10 July 2023** | EU–US Data Privacy Framework adequacy decision | OJ L 231, 20 Sep 2023 |
| **Ongoing** | EDPB guidelines, opinions, and binding Art. 65 decisions continue to refine application | — |

- [ ] **Application date awareness** — GDPR is fully in force; no transitional period exists for new entrants or new processing activities
- [ ] **EDPB monitoring** — subscribe to EDPB news; binding decisions and guidelines shape compliance expectations year-on-year
- [ ] **Pending litigation tracking** — Schrems III (DPF challenge), CJEU Art. 82 damages line of cases, AI-model-training references all bear on GDPR practice

**Reference:** GDPR Article 99

---

## SECTION 14 — KEY EDPB & COMMISSION INSTRUMENTS (Cross-Reference Map)

Treat the EDPB guideline corpus as **mandatory reading**, not optional. The EDPB's interpretations bind via the consistency mechanism and DPA practice converges on them.

| Instrument | Subject | GDPR hook |
|---|---|---|
| **EDPB Guidelines 3/2018** | Territorial scope | Article 3 |
| **EDPB Guidelines 4/2017 (WP248 rev.01)** | DPIA | Article 35 |
| **EDPB Guidelines 05/2020** | Consent | Articles 4(11), 6(1)(a), 7 |
| **EDPB Guidelines 07/2020** | Concepts of controller and processor | Articles 4(7), 4(8), 26, 28 |
| **EDPB Guidelines 2/2019** | Online services to data subjects | Article 6(1)(b) |
| **EDPB Guidelines 01/2022** | Right of access | Article 15 |
| **EDPB Guidelines 9/2022** | Personal data breach notification | Articles 33, 34 |
| **EDPB Guidelines 8/2022** | Identifying the lead supervisory authority | Article 56 |
| **EDPB Guidelines 04/2022** | Calculation of administrative fines | Article 83 |
| **EDPB Recommendations 01/2020** | Supplementary measures for international transfers | Articles 44–49 |
| **EDPB Guidelines 02/2025** | Processing of personal data through blockchain technologies (adopted 14 April 2025) | Articles 5, 17, 25, 32 |
| **EDPB Opinion 28/2024** | Certain data protection aspects related to the processing of personal data in the context of AI models (adopted 18 December 2024) | Articles 5, 6, 22 (AI Act interplay) |
| **CNIL Blockchain & GDPR Guidance** | Solutions for a responsible use of the blockchain in the context of personal data (29 October 2018) | Articles 5, 17, 25 |
| **Commission Implementing Decision (EU) 2021/914** | SCCs for international transfers | Article 46 |
| **Commission Implementing Decision (EU) 2021/915** | SCCs for controller-to-processor (intra-EU) | Article 28 |
| **EDPB DPO Guidelines (WP243 rev.01)** | DPO | Articles 37–39 |

> **Legal advisor note:** The EDPB guideline corpus is the *de facto* operational manual for GDPR. National DPAs may add Member-State-specific guidance on top (notably CNIL, Garante, AEPD, BfDI). Always cross-check the lead-DPA-specific guidance before relying solely on EDPB-level instruments.

---

## READINESS SCORECARD — SUMMARY

*Count completed checkboxes per section.*

| Section | Topic | Items (approx) | Ready? |
|---|---|---|---|
| 1 | Material + territorial scope + Art. 27 representative | 14 | ☐ |
| 2 | Role classification (controller / processor / joint) | 25 | ☐ |
| 3 | Lawful basis (Art. 6, 9, 10) | 23 | ☐ |
| 4 | Article 5 principles + accountability | 13 | ☐ |
| 5 | Controller structural obligations (DP by design, RoPA, DPO) | 24 | ☐ |
| 6 | Data subject rights | 13 | ☐ |
| 7 | Transparency, DPIA, prior consultation, documentation bundle | 24 | ☐ |
| 8 | Security + breach notification | 14 | ☐ |
| 9 | International transfers + TIA | 14 | ☐ |
| 10 | Supervision, one-stop-shop, EDPB | 6 | ☐ |
| 11 | Penalty exposure, civil liability, complaints | 7 | ☐ |
| 12 | GDPR ↔ AML, AI Act, DORA, MiCA, eIDAS 2.0 | 16 | ☐ |
| 13 | Timeline awareness | 3 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** GDPR-supervision-ready; align with annual review cadence and EDPB guideline updates
- **Amber (50–80% complete):** Material gaps exist — close before next DPA dialogue, MiCA / sectoral authorisation submission, or enterprise customer audit
- **Red (<50% complete):** Significant preparation required — engage specialist EU data-protection counsel and a privacy-engineering partner; allocate 6–12 months of remediation work

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for GDPR-bound FinTechs and Crypto-Native firms:**

**Pre-Build:** GDPR scoping brief (material + territorial scope mapping) → RoPA template configured to your product surface → DPIA register seeded with the high-risk activities the EDPB has flagged for your segment → off-chain / on-chain data architecture decision aligned to EDPB Guidelines 02/2025 → Article 28 processor-contract templates and sub-processor flow-down clauses

**Build:** Smart-contract architecture with personal data held off-chain and only hashes / commitments anchored on-chain → key-destruction ("cryptographic erasure") design that approximates Article 17 erasure rights where on-chain anchoring exists → multi-sig + role-based access controls satisfying Article 32 confidentiality requirements → automated DSAR pipeline integrating off-chain stores with on-chain identity → AML / TFR data-flow design that satisfies both AMLR + GDPR minimisation simultaneously

**Audit:** Independent privacy-engineering audit of the on-chain / off-chain boundary → DSAR-readiness stress test → DPIA review against EDPB Guidelines 02/2025 expectations → transfer impact assessment (TIA) for any non-EU sub-processors or non-EU node operators → breach-classification engine review unifying GDPR Art. 33 + DORA Art. 19 + NIS2 reporting taxonomies

**Why fintechs and crypto-native firms choose us for the GDPR layer:** GDPR does not stop at the application boundary. Every wallet address linked to KYC, every on-chain analytics event, every cross-CASP TFR transfer is part of your GDPR estate. We design and audit that part of the estate to DPA-reviewable standards from day one — and we map each technical decision to the GDPR article it satisfies, so your DPO reads the architecture document alongside the regulation, not instead of it.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. GDPR implementation is shaped by EDPB guidelines, national DPA supervisory practice, CJEU case law, and ongoing legislative work (AI Act, AMLR, DORA, eIDAS 2.0). Always engage qualified EU data-protection legal counsel for your specific entity, sector, and Member State.*

*Document version: 1.1 | Last updated: May 2026*
*Changes in v1.1: corrected EDPB blockchain reference — the authoritative document is **EDPB Guidelines 02/2025 on processing of personal data through blockchain technologies** (adopted 14 April 2025), not Opinion 28/2024 (which is on AI models). Opinion 28/2024 retained as the correct cite for the GDPR ↔ AI Act section. CNIL "Blockchain and the GDPR" (29 October 2018) added as supporting reference.*
*Regulation reference: Regulation (EU) 2016/679 of the European Parliament and of the Council of 27 April 2016 on the protection of natural persons with regard to the processing of personal data and on the free movement of such data, and repealing Directive 95/46/EC (General Data Protection Regulation), as published in OJ L 119, 4 May 2016.*
*Official source: https://eur-lex.europa.eu/eli/reg/2016/679/oj*