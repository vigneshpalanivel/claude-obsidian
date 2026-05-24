# eIDAS 2.0 Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for Digital Identity, Trust Services & Wallet Integration in the EU

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU European Digital Identity Framework — Regulation (EU) 2024/1183 amending Regulation (EU) No 910/2014 (eIDAS)
**Status:** Entered into force 20 May 2024. EUDI Wallet rollout: Member States must provide at least one Wallet within 24 months of the entry into force of the Commission's implementing acts under Article 5a(23) / 5c(6). Private relying-party acceptance obligation under Article 5f(2) applies 36 months from that same trigger
**Document type:** Pre-engagement readiness assessment — to be completed before formal supervisory engagement, conformity assessment, or relying-party registration

---

> **Who this document is for:** Founders, executive teams, and product leads at (a) **regulated financial institutions and online service providers** that will be obliged to accept the EU Digital Identity Wallet (EUDI Wallet) as a relying party, (b) **trust service providers** intending to offer qualified or non-qualified services across the Union, including the new **qualified electronic ledger** trust service, and (c) **EUDI Wallet providers** building under a Member State mandate or independently with Member State recognition. Use this checklist before your first formal meeting with eIDAS counsel, your national supervisory body, or a conformity assessment body.

---

> **How to use this checklist:** Identify your role(s) in Section 2 first — the substantive obligations differ sharply between a relying party, a trust service provider, and a wallet provider. Work through every section that applies to a role you have selected. Items marked with a checkbox (☐) represent concrete obligations or design decisions. Gaps you cannot close are gaps your supervisory body will find.

---

## SECTION 1 — DOES eIDAS 2.0 APPLY TO YOU?

*eIDAS 2.0 is not a sector regulation — it is a horizontal framework that catches anyone in three roles: relying party, trust service provider, or wallet provider. The first triage question is which role(s) apply.*

---

### 1.1 — Are You a Relying Party Required to Accept the EUDI Wallet?

A relying party is any natural or legal person that relies on electronic identification or trust services to provide a service. Answer each question — if any is **Yes**, you fall within Article 5f and will be obliged to accept the EUDI Wallet.

- [ ] Are you a **Member State public-sector body** providing an online service that already requires electronic identification and authentication? *(Article 5f(1) — mandatory acceptance, no carve-out for size or sector)*
- [ ] Are you a private service provider in **transport, energy, banking, financial services, social security, health, drinking water, postal services, digital infrastructure, education or telecommunications**, where Union or national law (or contract) requires **strong user authentication** for online identification? *(Article 5f(2))*
- [ ] Are you a **very large online platform (VLOP)** designated under Article 33 of Regulation (EU) 2022/2065 (Digital Services Act)? *(Article 5f(3) — must accept on user's voluntary request, limited to minimum data necessary)*
- [ ] Do you carry out **customer KYC, onboarding, or strong customer authentication** under any EU regulated regime (MiCA CASP, MiFID II investment firm, PSD3 PSP/EMI, AMLR-obliged entity, DORA-licensed financial entity)? You are caught indirectly — your existing identification flows must accept the EUDI Wallet from the Article 5f trigger date.
- [ ] Do you provide services by digital interaction within the EU and intend to rely on EUDI Wallets at all (even voluntarily)? You become a relying party the moment you accept Wallet data, with all Article 5b obligations attached.

> **Legal advisor note:** "Strong user authentication" in Article 5f(2) is not defined in eIDAS — it is the EBA / PSD2-style concept (two-factor, dynamic linking) plus equivalent concepts across sectoral law. If your business already does SCA under PSD2/PSD3, you are squarely in scope. The 36-month Article 5f(2) clock runs from the entry into force of the implementing acts under Articles 5a(23) and 5c(6), not from the regulation itself.

> **Micro/small enterprise carve-out:** Article 5f(2) **excludes microenterprises and small enterprises** as defined in Commission Recommendation 2003/361/EC (i.e. under 50 staff and turnover/balance sheet ≤ EUR 10 million). The carve-out applies to the *acceptance obligation*, not to the right to *use* the Wallet voluntarily and not to Article 5b registration obligations if you do.

**Reference:** Regulation (EU) 2024/1183, Article 5f (cross-border reliance), Article 5b (relying party registration), Article 33 of Regulation (EU) 2022/2065 (VLOP designation)

---

### 1.2 — Are You a Trust Service Provider?

A trust service provider (TSP) creates, verifies, validates, preserves, or otherwise handles one or more of the **eIDAS trust services**. Two tiers exist: **non-qualified** (general obligations) and **qualified** (heavy obligations, the right to use the EU trust mark, presumption of legal effect).

Tick each trust service you provide or intend to provide:

- [ ] **Electronic signatures** — qualified, advanced, or simple — for natural persons
- [ ] **Electronic seals** — qualified, advanced, or simple — for legal persons
- [ ] **Electronic time stamps** — qualified or non-qualified
- [ ] **Electronic registered delivery services** — qualified or non-qualified
- [ ] **Website authentication certificates** (QWACs and non-qualified)
- [ ] **Electronic attestation of attributes (EAA / QEAA)** — issuing verifiable credentials such as diplomas, licences, mandates, age/residency proofs, financial-status attestations *(Articles 45b–45h + Annexes V, VI, VII)*
- [ ] **Electronic archiving** — qualified or non-qualified preservation of electronic documents over time *(Articles 45i–45j)*
- [ ] **Electronic ledgers** — qualified or non-qualified service for the sequential, chronological, integrity-protected recording of data records (**new trust service introduced by eIDAS 2.0**; the natural home for tokenisation, on-chain registries, settlement audit trails) *(Articles 45k–45l)*
- [ ] **Management of remote qualified electronic signature/seal creation devices** *(Article 29a, 39a)*

> **Legal advisor note — why "qualified" matters:** Qualified trust services carry a **presumption of legal effect** equivalent to their paper counterparts, cross-border recognition by force of law across all 27 Member States, and the right to display the EU trust mark. The obligation surface is materially larger: prior conformity assessment by an accredited CAB, supervisory body confirmation of qualified status, mandatory liability insurance, cybersecurity audit cycle aligned to NIS2, and inclusion on the EU trusted lists. The non-qualified route is faster to market but the legal value of your output rests on your contractual terms and national private law, not on the Regulation.

**Reference:** Regulation (EU) No 910/2014 as amended, Article 3 (definitions), Articles 17–24a (supervisory, qualified-status framework, and cross-MS recognition), Article 19a (non-qualified TSP baseline + 24-hour incident notification — **new**), Articles 25–34 (e-signatures), Articles 29a, 39a (remote QSCD management — **new**), Articles 32a, 40a (validation of advanced sigs/seals on qualified certs — **new**), Articles 35–40 (e-seals), Articles 41–42 (timestamps), Articles 43–44 (registered delivery), Article 45 (website auth) + Article 45a (web-browser precautionary measures — **new**), Articles 45b–45h (electronic attestation of attributes — **new section, with Annexes V/VI/VII**), Articles 45i–45j (electronic archiving — **new**), Articles 45k–45l (electronic ledgers — **new**)

---

### 1.3 — Are You an EUDI Wallet Provider?

The EUDI Wallet is provided by Member States, in one of three forms (Article 5a(2)):

- [ ] **Directly by a Member State** — you are an agency / public body
- [ ] **Under a mandate from a Member State** — you are a vendor or consortium contracted by a Member State
- [ ] **Independently of a Member State but recognised by that Member State** — you are a private wallet provider seeking endorsement

Tick whichever path applies. If none applies, **you are not a wallet provider** under eIDAS 2.0 — building a wallet-shaped product without Member State provision or recognition does not make you an Article 5a provider, and you cannot benefit from the cross-border reliance regime in Article 5f.

> **Legal advisor note:** The "independently but recognised" route is the door for private-sector wallet builders, but recognition is a Member-State-level decision, not self-declared. Conformity assessment by an accredited CAB (Article 5c) is mandatory before any Wallet can be placed on the EU trusted list maintained by the Commission under Article 5d.

**Reference:** Articles 5a (provision), 5b (relying-party interface), 5c (certification), 5d (Union list of certified Wallets)

---

### 1.4 — Out-of-Scope / Carve-Outs

- [ ] **Aspects relating to the conclusion and validity of contracts** where Union or national law lays down form requirements — eIDAS does not override national contract form rules *(Recital 46)*
- [ ] **National form requirements for public registers** (commercial registers, land registers) — out of scope
- [ ] **Closed systems** that exchange electronic identification means only within a defined group of participants and do not interact with third parties — outside the EUDI Wallet acceptance regime
- [ ] **Microenterprises and small enterprises** (≤50 staff and ≤EUR 10M turnover/BS) are exempt from the **Article 5f(2)** acceptance obligation — but **not** from the Article 5b registration obligations if they choose to accept the Wallet voluntarily

**Reference:** Regulation (EU) 2024/1183 Recital 46; Commission Recommendation 2003/361/EC (SME definition)

---

## SECTION 2 — WHICH ROLE(S) APPLY TO YOUR BUSINESS?

*eIDAS 2.0 obligations are role-based. A single business may be in two or three roles simultaneously (e.g. a regulated FI that is both a relying party and a QTSP for its own seals). Identify all that apply.*

---

### 2.1 — Role Classification Decision Tree

#### ☐ ROLE A — Relying Party (Article 5b, Article 5f)
*You provide a service that will accept identification, authentication, or attribute data from a Wallet or other notified eID.*

- You provide a service by digital interaction (online / offline mode via close-proximity tech)
- You rely on identification data, attributes, or signatures from the user
- You will request, validate, and/or store information presented from a Wallet

**Requirements summary:**
- **Registration in the Member State of establishment** — cost-effective, proportionate-to-risk, no pre-authorisation *(Article 5b(1)–(2))*
- **Pre-declared intended use** — you must declare which data you will request and why; you may not request anything beyond that declaration *(Article 5b(3))*
- **Identification to the user** in each interaction *(Article 5b(8))*
- **Authentication / validation** of presented attributes is your responsibility, not the wallet provider's *(Article 5b(9))*
- **No refusal of pseudonyms** where identification is not required by law *(Article 5b(9))*
- **Update obligation** when any registration data changes *(Article 5b(6))*

---

#### ☐ ROLE B — Non-Qualified Trust Service Provider (Articles 19–24)
*You provide one or more trust services without seeking qualified status.*

- You provide a trust service listed in Section 1.2
- You do not seek the EU trust mark or the presumption of legal effect
- Your value proposition rests on contract terms, not on cross-border statutory recognition

**Requirements summary:**
- **General obligations apply** — technical and organisational risk management, security incident reporting, cooperation with the supervisory body *(Article 19, Article 21 (security and notification of breaches))*
- **Cybersecurity risk management and incident reporting** aligned with **Directive (EU) 2022/2555 (NIS2)** *(Article 19(1), Recitals 50–51)*
- **No use of the EU trust mark** *(Article 23 limits the trust mark to qualified services)*
- **Liability for damages caused by failure to comply** *(Article 13 — burden of proof regime)*
- **Penalties exposure** — same EUR 5,000,000 / 1 % worldwide turnover floor as QTSPs *(Article 16(2))*

---

#### ☐ ROLE C — Qualified Trust Service Provider (Articles 20–24a, plus per-service Articles)
*You provide one or more trust services and seek qualified status.*

- You will undergo **conformity assessment** by an accredited Conformity Assessment Body (CAB)
- You will be reviewed by your national **supervisory body** before being granted qualified status
- You will be included on your Member State's **trusted list** (Article 22) and entitled to display the **EU trust mark** (Article 23)

**Requirements summary:**
- **Conformity assessment report** issued by an accredited CAB no older than required by your supervisory body, submitted with your notification to the supervisory body *(Article 21)*
- **Supervisory body confirmation** of qualified status before holding out the service as qualified *(Article 21(2)–(3))*
- **Mandatory liability insurance** or equivalent financial guarantees *(Article 24(2)(c))*
- **Staff vetting** — staff and contractors must have the necessary expertise, reliability, experience, and qualifications, and have received appropriate training on security and personal-data protection *(Article 24(2)(b))*
- **Trustworthy systems and products** — must use systems and products that protect against modification and ensure technical security and reliability *(Article 24(2)(e))*
- **Identity verification of the person to whom the qualified certificate / attestation is issued** — by physical presence, by means notified at assurance level high, by qualified e-signature/seal, or by other means recognised at national level that provide equivalent assurance to physical presence *(Article 24(1))*
- **Termination plan** — documented plan for the orderly termination of services, including how subscribers and relying parties will be informed, how records will be preserved, and how certificate revocation will continue to be ensured *(Article 24(2)(h))*
- **Record retention** — relevant information for the appropriate period, including after activities have ceased *(Article 24(2)(h)–(i))*
- **Reporting obligations** — significant changes to the provision, intent to cease activities, security breaches and integrity losses to the supervisory body and, where applicable, the data protection authority within 24 hours of becoming aware

---

#### ☐ ROLE D — EUDI Wallet Provider (Articles 5a–5e)
*You build, issue, and maintain an EUDI Wallet for one or more Member States.*

- You are a Member State agency, a vendor under Member State mandate, or a private provider seeking Member State recognition
- You will undergo Wallet-specific conformity assessment under Article 5c
- You will be placed on the Commission's Union list of certified Wallets under Article 5d

**Requirements summary:**
- **Open-source application software** — source code of application software components must be open-source licensed; non-device components may be withheld for duly justified reasons (e.g. public security) *(Article 5a(3))*
- **Assurance level high** — Wallets must be provided under an eID scheme with assurance level **high** *(Article 5a(11))*
- **Security-by-design** *(Article 5a(12))*
- **Free of charge to natural persons** for issuance, use, and revocation *(Article 5a(13))*
- **No tracking, no data combination** — unobservability of transactions; logical separation of Wallet data from any other data held by the provider; no combination with other personal data *(Article 5a(14))*
- **Unlinkability** where the attestation does not require user identification *(Article 5a(16))*
- **Common dashboard** — user-facing log of all transactions; ability to request erasure from relying parties and report suspicious requests to DPAs *(Article 5a(4)(d))*
- **Validation mechanisms free of charge** for verifying Wallet authenticity and relying-party identity *(Article 5a(8))*
- **Revocation on user request, security compromise, or death/cease of activity** *(Article 5a(9))*
- **Pseudonyms supported** *(Article 5a(4)(b))*
- **Free qualified e-signatures by default for natural persons** for non-professional purposes *(Article 5a(5)(g))*
- **Security-breach notification regime** — suspension within "without undue delay"; withdrawal after 3 months if not remedied *(Article 5e)*

---

> **Critical note — Multiple roles may apply:** A regulated FinTech that integrates the Wallet for onboarding (Role A), issues its own qualified electronic seals for client documents (Role C), and uses a qualified electronic ledger to record token-issuance events (Role C again, ledger service) is in **three** roles simultaneously. Each carries independent obligations.

**Reference:** Regulation (EU) No 910/2014 as amended, Article 3 (definitions), Articles 5a–5f (Wallets and relying parties), Articles 17–24a (TSPs and qualified status), Articles 25–45l (per-trust-service obligations)

---

## SECTION 3 — TRUST SERVICE TAXONOMY (DETAILED)

*If you are in Role B or C, you must classify your service correctly. Misclassification at this stage carries through to conformity assessment scope and liability allocation.*

---

### 3.1 — Trust Services in Scope

| # | Trust service | Qualified-tier presumption | Source articles |
|---|---|---|---|
| 1 | Electronic signature | Qualified e-sig has equivalent legal effect to handwritten signature across the EU | Arts 25–34 |
| 2 | Electronic seal | Qualified e-seal enjoys presumption of integrity and correctness of origin | Arts 35–40 |
| 3 | Electronic time stamp | Qualified time stamp enjoys presumption of accuracy of date/time and integrity of data | Arts 41–42 |
| 4 | Electronic registered delivery service | Qualified service enjoys presumption of integrity of data, identification of sender/addressee, accuracy of date/time of sending/receipt | Arts 43–44 |
| 5 | Website authentication certificate (QWAC) | Qualified certificate identifies the natural/legal person owning the website | Art 45 |
| 6 | **Electronic attestation of attributes (EAA)** | Qualified EAA (QEAA) has legal effect equivalent to lawfully issued paper attestations; cross-border recognition | Arts 45b–45h + Annexes V/VI/VII |
| 7 | **Electronic archiving** | Qualified archiving service provides presumption of integrity and origin of preserved electronic data for the duration of the preservation period | Arts 45i–45j |
| 8 | **Electronic ledger — new trust service** | Qualified ledger enjoys presumption of **unique and accurate sequential chronological ordering** and **integrity** of the data records | Arts 45k–45l |
| 9 | Management of remote qualified e-sig/seal creation devices | Where the QSCD is held remotely on behalf of the signatory | Arts 29a, 39a |

---

### 3.2 — Special Focus: Qualified Electronic Attestation of Attributes (QEAA)

*The QEAA is the credential format the EUDI Wallet relies on for sharing verified attributes (age, residency, professional qualifications, financial status, mandates, etc.). If your business issues structured claims about people or organisations, this is your service.*

- [ ] **Issuer is a qualified TSP** — only QTSPs can issue QEAAs; requirements set in Annex V *(Article 45d)*. EAAs issued by or on behalf of a public-sector body responsible for an authentic source have **equivalent legal effect** to a QEAA without being issued by a QTSP, but the public-sector body must meet a level of reliability and trustworthiness equivalent to a QTSP per Article 24 and is itself subject to conformity assessment *(Article 45b(2), Article 45f(2)–(3))*
- [ ] **Cross-border recognition** — a QEAA issued in one Member State is recognised as a QEAA in all other Member States *(Article 24a(9))*
- [ ] **Attribute verification against authentic sources** — Member States must ensure, within 24 months of the date of entry into force of the implementing acts under Articles 5a(23) and 5c(6), that for at least the attributes listed in **Annex VI** (wherever they rely on authentic sources within the public sector) QTSPs can verify those attributes by electronic means at the request of the user *(Article 45e)*
- [ ] **No data combination, logical separation, functional separation** — providers of qualified and non-qualified EAA services shall not combine personal data from EAA services with personal data from any other services offered by them or their commercial partners; EAA data must be kept logically separate; qualified EAA services must be functionally separate from other services provided *(Article 45h)*
- [ ] **Interface with EUDI Wallets** — providers of QEAAs must provide an interface with EUDI Wallets in accordance with Article 5a *(Article 45g(2))*
- [ ] **Revocation is final** — once a QEAA is revoked, it loses validity from the moment of revocation and its status **shall not in any circumstances be reverted** *(Article 45d(4))*
- [ ] **Selective disclosure supported by design** *(Recital 14, 56 — privacy-preserving techniques, zero-knowledge proofs)*
- [ ] **No tracking of QEAA use** — the QEAA issuer must not be able to obtain data that allows transactions or user behaviour to be tracked, linked or correlated, unless the user expressly authorises it *(Article 5a(16) — applies via the Wallet integration)*
- [ ] **Liability regime for incorrect attributes** — QTSP liability for damages caused by inaccurate attestation, subject to limitation of liability if disclosed in advance *(Article 13)*

---

### 3.3 — Special Focus: Qualified Electronic Ledger (Articles 45k–45l) — Direct Blockchain Relevance

*This is a new trust service introduced by eIDAS 2.0 (Section 11 of Chapter III). A "qualified electronic ledger" provides cross-border legal certainty for the recording of data in a tamper-evident, chronologically ordered sequence. Distributed ledgers and blockchain-based registries can qualify if they meet the substantive requirements. This is the article-of-record for tokenisation, on-chain settlement audit trails, decentralised land registries, and any product that relies on the legal value of "this was recorded here, in this order, and has not changed since."*

**Article 45k — Legal effects:**
- An electronic ledger **shall not be denied legal effect or admissibility as evidence** in legal proceedings solely on the ground that it is electronic or non-qualified *(Article 45k(1))*
- Data records contained in a **qualified** electronic ledger **enjoy the presumption** of (i) their **unique and accurate sequential chronological ordering** and (ii) their **integrity** *(Article 45k(2))*

**Article 45l — Requirements for a qualified electronic ledger:**

- [ ] **Created and managed by one or more qualified trust service providers** *(Article 45l(1)(a))* — the operator-accountability constraint is explicit in Level 1
- [ ] **Establishes the origin of data records in the ledger** *(Article 45l(1)(b))*
- [ ] **Ensures the unique sequential chronological ordering of data records in the ledger** *(Article 45l(1)(c))*
- [ ] **Records data in such a way that any subsequent change to the data is immediately detectable, ensuring integrity over time** *(Article 45l(1)(d))*
- [ ] **Cross-border recognition** — a qualified electronic ledger provided in one Member State is recognised as such in all other Member States *(Article 24a(11))*
- [ ] **Compliance presumed** where the ledger complies with standards/specifications/procedures set by Commission implementing act under Article 45l(3) — Commission deadline **21 May 2025**

**Other contextual obligations from Recital 68:**
- [ ] **Distinguished from time stamps and registered delivery services** — Recital 68 makes the boundary explicit; misclassification will fail conformity assessment
- [ ] **Technological neutrality** — neither favours nor discriminates between centralised and distributed implementations *(Recital 68)*
- [ ] **Sustainability indicators** — the Commission must take into account adverse climate/environmental impacts when adopting the Article 45l(3) implementing acts *(Recital 68)*

> **Founder takeaway — when to design for qualified-ledger status:** Build for it when the *legal value of the record itself* (e.g. token ownership, tokenised real-estate title, settlement finality) is part of your customer value proposition. Do **not** retrofit it onto an existing chain you do not operate. Article 45l(1)(a) explicitly requires that the ledger be **created and managed by one or more qualified TSPs** — a pure permissionless deployment cannot meet this without a wrapper service or consortium that takes the qualified-TSP role.

**Reference:** Regulation (EU) No 910/2014 as amended, Articles 45k–45l (new Section 11 — Electronic Ledgers); Article 24a(11) (cross-MS recognition); Recital 68 (framework, technological neutrality, sustainability)

---

## SECTION 4 — IF YOU ARE A RELYING PARTY: ACCEPTANCE & REGISTRATION

*This section is mandatory reading for every regulated FI, VLOP, and public-sector body. Article 5b registration is the operational gate that opens before you can technically interact with any EUDI Wallet.*

---

### 4.1 — Article 5b Registration

- [ ] **Member State of establishment identified** — you register in the Member State where you are established. Multi-MS groups need to map which entities register where *(Article 5b(1))*
- [ ] **Pre-declared information ready** — at minimum: (i) Member State of establishment; (ii) legal name plus registration number from an official record; (iii) contact details; (iv) intended use of the Wallet including an indication of the data to be requested *(Article 5b(2))*
- [ ] **No over-collection** — the relying party shall not request users to provide any data **other than** that indicated in its registered intended use *(Article 5b(3))*. Internal product, marketing, and dev teams must be aware: scope drift at the UI level is a registration breach
- [ ] **Update workflow** — any change to registered information must be notified to the Member State without delay *(Article 5b(6))*
- [ ] **Authentication infrastructure** — implement the common authentication mechanism the Member State provides for identifying relying parties to Wallets *(Article 5b(7))*
- [ ] **Self-identification to the user** in every interaction — your UI must surface your identity to the Wallet user *(Article 5b(8))*
- [ ] **Validation responsibility owned** — the relying party is responsible for authenticating and validating presented person identification data and attestations. The Wallet provides the data, but you confirm it *(Article 5b(9))*
- [ ] **Pseudonyms accepted where identification not required by law** *(Article 5b(9))* — this is a hard duty, not a UX choice. Pre-built KYC flows that demand a legal name regardless of need are non-compliant
- [ ] **Intermediary status mapped** — if you operate through an intermediary that acts on your behalf, the intermediary is **deemed a relying party** and is itself bound by the registration regime, with the added restriction that it must not store data about the content of the transaction *(Article 5b(10))*

---

### 4.2 — Acceptance Obligations Under Article 5f

| Type of relying party | Acceptance trigger | Source |
|---|---|---|
| Public-sector body requiring eID/authentication | **Must accept** EUDI Wallets | Article 5f(1) |
| Private relying party in a listed strategic sector (transport, energy, banking, financial services, social security, health, drinking water, postal, digital infra, education, telecommunications) where Union/national law or contract requires **strong user authentication** | **Must accept** EUDI Wallets within **36 months** of entry into force of implementing acts under Arts 5a(23) / 5c(6); micro/small enterprises exempt | Article 5f(2) |
| Very large online platform (Art 33 DSA) | **Must accept and facilitate** EUDI Wallets, upon user's voluntary request, limited to minimum data necessary | Article 5f(3) |
| Any other private relying party | Voluntary acceptance — but if you accept, you are a relying party for all purposes of Article 5b | — |

- [ ] **Acceptance window mapped** — confirm your projected go-live against the 36-month Article 5f(2) trigger date. Confirm the precise date with counsel once the Commission's implementing acts under Articles 5a(23) and 5c(6) are published
- [ ] **UX work scoped** — the user-facing flow must offer the Wallet as an option wherever your service requires strong authentication, alongside any existing eID, account/password, or KYC option. The user's right to use other identification means is protected *(Article 5a(15))*
- [ ] **Data minimisation enforced in flow design** — never request the legal name where an age-over-18 attestation, residency attestation, or pseudonym would do
- [ ] **Acceptance for VLOPs** — if you are a designated VLOP, the obligation is to **accept and facilitate** on voluntary user request, with strict minimum-data discipline. This is on top of, not instead of, your DSA risk-assessment obligations
- [ ] **Documentation for supervisor** — keep audit-ready records of the registered intended use, the corresponding live data requests, and any deviations. The Wallet user can report you to the DPA from inside the Wallet dashboard

---

### 4.3 — Data Protection Specifics for Relying Parties

- [ ] **DPIA performed** before processing Wallet data — particularly where you process special categories of data (e.g. health attributes) *(Article 35–36 GDPR; eIDAS Recital 17)*
- [ ] **DPA consultation** carried out where the DPIA indicates high risk *(Article 36 GDPR)*
- [ ] **Article 5(1) GDPR principles operationalised** — purpose limitation, data minimisation, storage limitation specifically mapped against the registered intended use
- [ ] **Right of erasure pipeline ready** — Wallet users can request erasure of their personal data directly through the Wallet dashboard. You must respond *(Article 17 GDPR; Article 5a(4)(d)(ii))*
- [ ] **Audit log of relying-party requests retained** — the Wallet's dashboard logs your requests on the user side. Your side must align: if a user complaint is escalated to the supervisory body, the body will compare its records to yours

**Reference:** Articles 5b, 5f; Regulation (EU) 2016/679 (GDPR), Articles 5, 17, 25, 32, 35–36; Recitals 17, 56–57 of Regulation (EU) 2024/1183

---

## SECTION 5 — IF YOU ARE A TRUST SERVICE PROVIDER (QUALIFIED OR NON-QUALIFIED)

*This section applies to Roles B and C. All TSPs share a baseline; QTSPs sit on top of it.*

---

### 5.1 — Baseline Obligations for All TSPs (Articles 19, 19a)

- [ ] **Technical and organisational measures** to manage risks to the security of the trust services provided *(Article 19(1))*. As amended by eIDAS 2.0, the cybersecurity risk-management measures and incident-reporting obligations of **Directive (EU) 2022/2555 (NIS2)** apply to trust service providers *(Recital 50)*
- [ ] **Non-qualified TSP explicit baseline (Article 19a — new)** — non-qualified TSPs must have appropriate policies and measures (notwithstanding NIS2 Article 21) covering: (i) registration and onboarding procedures, (ii) procedural/administrative checks, and (iii) management and implementation of trust services. Compliance presumed when implementing-act standards (Commission deadline 21 May 2025) are met *(Article 19a(1)(a), 19a(2))*
- [ ] **Breach notification — explicit 24-hour deadline for non-qualified TSPs (Article 19a(1)(b))** — security breaches or disruptions with significant impact on the trust service or on personal data must be notified to the supervisory body, identifiable affected individuals, the public if of public interest, and other relevant competent authorities, **without undue delay and in any case no later than 24 hours of having become aware**
- [ ] **Cybersecurity audit trail** — incidents, root cause, remediation, and post-incident review documented
- [ ] **Cooperation with the supervisory body** — providing information, granting access to premises, supporting inspections *(Articles 17, 19, 20, 46b)*
- [ ] **GDPR alignment** — personal data processing within trust services must comply with GDPR; data protection by design and by default *(Article 5 of GDPR)*

---

### 5.2 — Additional Obligations for Qualified TSPs (Article 24)

- [ ] **Identity verification before issuing a qualified certificate or QEAA** by one of: physical presence, notified eID means at assurance level high, qualified e-signature/seal supported by a qualified certificate, or other identification methods recognised at national level that provide equivalent assurance to physical presence — assessed by an accredited conformity assessment body *(Article 24(1))*
- [ ] **Staff fit-and-proper** — employed personnel and subcontractors with the necessary expertise, reliability, experience, and qualifications; appropriate training on security and personal-data protection rules *(Article 24(2)(b))*
- [ ] **Financial resources and/or liability insurance** sufficient to maintain operations and meet liability under Article 13 *(Article 24(2)(c))*
- [ ] **Trustworthy systems and products** — protection against modification, technical security and reliability; cryptographic agility plan to address algorithm/parameter obsolescence *(Article 24(2)(e)–(f))*
- [ ] **Record-keeping** — all relevant information concerning data issued and received, for an appropriate period (including after cessation), so that evidence can be provided in legal proceedings and to ensure continuity of the service. Records to be maintained electronically *(Article 24(2)(h))*
- [ ] **Up-to-date termination plan** — to ensure continuity of service in accordance with the supervisory body's requirements *(Article 24(2)(h))*
- [ ] **Lawful and timely revocation** of qualified certificates / attestations *(Article 24(2)(k); per-service articles)*
- [ ] **Certificate-status database operational 24/7** *(Article 24(2)(l) per the original Regulation)*

---

### 5.3 — Conformity Assessment & Qualified-Status Workflow

- [ ] **CAB selected from those accredited under Regulation (EC) No 765/2008** — accreditation specifically for the assessment of qualified trust service providers
- [ ] **Conformity assessment report prepared** — covering all relevant per-service articles for the trust service(s) you offer
- [ ] **Notification submitted to the national supervisory body** — including the conformity assessment report, the intended trust services, and supporting documentation *(Article 21)*
- [ ] **Supervisory body confirmation received** — before the trust service may be held out as "qualified" *(Article 21(2))*
- [ ] **Listing on the Member State trusted list** by the supervisory body — and from there into the EU list of trusted lists maintained by the Commission *(Article 22)*
- [ ] **EU trust mark used correctly** — only against confirmed qualified services, with a link to the trusted list *(Article 23)*
- [ ] **Re-assessment** — submitted to the supervisory body **at least every 24 months** *(Article 20(1) — supervisory regime)*

---

### 5.4 — Liability Regime (Article 13)

- [ ] **Damage liability mapped** — TSPs are liable for damages caused intentionally or negligently to natural or legal persons by failure to comply with the Regulation; for QTSPs the burden of proof reverses (presumed at fault unless the QTSP proves the contrary) *(Article 13(1))*
- [ ] **Limitation of liability disclosed in advance** — TSPs may limit their liability for the use of services beyond declared limits, provided the limitations are made known to the user in advance and clearly recognisable *(Article 13(2))*
- [ ] **Insurance and capital adequacy** documented to match the liability exposure

**Reference:** Articles 13, 17–24a (general and qualified TSP regime), Articles 19, 19a + NIS2 (cybersecurity), per-service Articles 25–45l

---

## SECTION 6 — IF YOU ARE AN EUDI WALLET PROVIDER

*This section is for Member State agencies, vendors under Member State mandate, and private providers seeking Member State recognition.*

---

### 6.1 — Core Wallet Functional Requirements (Article 5a)

- [ ] **Core user functions implemented** — request, obtain, select, combine, store, delete, share and present person identification data and EAAs; generate pseudonyms; authenticate another Wallet; access transaction log; sign with qualified electronic signatures; download data; exercise data portability *(Article 5a(4)(a)–(g))*
- [ ] **Common protocols and interfaces** for issuance, sharing, authentication, validation, erasure-request, reporting-to-DPA, qualified-signature creation — supporting the eleven interface obligations in Article 5a(5)(a)(i)–(xi)
- [ ] **No information to attestation providers about use** of attestations *(Article 5a(5)(b))*
- [ ] **Relying-party authentication mechanism** implemented in line with Article 5b *(Article 5a(5)(c))*
- [ ] **Assurance level high requirements met** for identity proofing, eID management, and authentication *(Article 5a(5)(d))*
- [ ] **Person identification data uniquely represents** the natural/legal person and is associated with the Wallet *(Article 5a(5)(f))*
- [ ] **Free qualified e-signatures by default for natural persons** for non-professional purposes — Member State may proportionately restrict to non-professional purposes *(Article 5a(5)(g))*

---

### 6.2 — Privacy & Data Protection by Design

- [ ] **Logical separation** of Wallet data from any other data the provider holds *(Article 5a(14))*
- [ ] **No tracking, no combination, no insight into transactions** — unobservability of user transactions by the provider; no combination with personal data from other services unless the user expressly requests it *(Article 5a(14), Recital 32)*
- [ ] **Privacy-preserving techniques (e.g. zero-knowledge proof) integrated** into the Wallet to allow validation without revealing underlying data *(Recital 14)*
- [ ] **Unlinkability** where the attestation does not require identification *(Article 5a(16)(b))*
- [ ] **Common dashboard** that lists all relying parties, all data exchanged, supports erasure requests under Article 17 GDPR, and supports reporting to the DPA *(Article 5a(4)(d))*
- [ ] **Source code published under open-source licence** for application software components; non-device components may be withheld for duly justified reasons *(Article 5a(3))*

---

### 6.3 — Certification (Article 5c) and Listing (Article 5d)

- [ ] **Conformity assessment body designated by a Member State** selected *(Article 5c(1))*
- [ ] **Cybersecurity certification under a scheme adopted pursuant to the Cybersecurity Act (Regulation (EU) 2019/881)** where available *(Article 5c(2))*
- [ ] **National certification scheme** prepared for non-cybersecurity requirements (and for cybersecurity gaps not yet covered by EU schemes) — draft transmitted to the European Digital Identity Cooperation Group for opinion *(Article 5c(3))*
- [ ] **Certification validity tracked** — up to **5 years**, conditional on a **vulnerability assessment every 2 years**; certification cancelled if a vulnerability is identified and not remedied in a timely manner *(Article 5c(4))*
- [ ] **Listing pack ready** for Member State notification to Commission and Cooperation Group: certificate + assessment report; description of the eID scheme; applicable supervisory and liability regime; responsible authorities; suspension/revocation arrangements *(Article 5d(2))*

---

### 6.4 — Security Breach Regime (Article 5e)

- [ ] **Incident-response runbook covers eIDAS 2.0 specific obligations** — on detection of breach affecting reliability, suspend provision and use **without undue delay**; withdraw without undue delay if severity justifies *(Article 5e(1))*
- [ ] **3-month withdrawal trigger** — if the breach is not remedied within 3 months of suspension, withdraw and revoke validity *(Article 5e(2))*
- [ ] **Communications matrix** — affected users, single points of contact (Article 46c), relying parties, Commission *(Article 5e(1)–(3))*
- [ ] **Re-establishment workflow** — when remedied, re-provision and notify all parties *(Article 5e(3))*

---

### 6.5 — Wallet User Lifecycle

- [ ] **Onboarding via eID at assurance level high** — or, transitionally, assurance level substantial combined with supplementary identity verification meeting AL-high requirements per implementing acts *(Article 5a(24); Recital 28)*
- [ ] **Voluntary revocation flow** — explicit user request, security compromise, death/cease of activity *(Article 5a(9))*
- [ ] **Portability between Wallets** — where a Member State endorses more than one Wallet, effective portability of data on user request; no contractual, economic, or technical lock-in *(Recital 48)*
- [ ] **Accessibility for persons with disabilities** in line with Directive (EU) 2019/882 *(Article 5a(21))*

**Reference:** Articles 5a–5f; Recitals 14, 28, 32, 48; Regulation (EU) 2019/881 (Cybersecurity Act); Directive (EU) 2019/882 (European Accessibility Act)

---

## SECTION 7 — CYBERSECURITY, INCIDENT REPORTING & DATA PROTECTION

*eIDAS 2.0 sits on top of three other horizontal regimes: NIS2 (cybersecurity), GDPR (personal data), Cybersecurity Act (certification). Wherever the Regulation says "shall maintain secure systems," that obligation is operationalised through these regimes.*

---

### 7.1 — NIS2 Alignment for Trust Service Providers

- [ ] **NIS2 risk-management framework** in place — TSPs are designated **essential entities** under NIS2 Annex I, point 8, by virtue of being eIDAS TSPs *(Directive (EU) 2022/2555, Annex I)*
- [ ] **Incident reporting cadence aligned** — NIS2 imposes early warning within 24 hours, incident notification within 72 hours, intermediate and final reports per Article 23 of NIS2. The eIDAS 2.0 supervisory body and the NIS2 competent authority must both be served where they differ *(Recital 51 of Reg (EU) 2024/1183)*
- [ ] **Supply-chain risk management** — ICT third-party providers screened and contracted in line with NIS2 Article 21(2)(d); particular attention to cloud, HSM/QSCD vendors, identity-proofing providers
- [ ] **Vulnerability handling** — CVD process documented, aligned with NIS2 Article 12; for QTSPs, also the Article 5c-equivalent vulnerability-assessment cycle where applicable
- [ ] **Cooperation arrangements** between the eIDAS supervisory body and the NIS2 competent authority documented in your incident-response runbook

---

### 7.2 — GDPR Operationalisation

- [ ] **Roles mapped** — controller / processor / joint controller positions for each touchpoint: wallet ↔ relying party ↔ attestation issuer ↔ supervisory body
- [ ] **Lawful basis recorded** for each processing operation, distinguishing the user's exercise of rights via the Wallet (consent / vital interest / public task as applicable) from the relying party's processing for service provision (often legitimate interest or legal obligation)
- [ ] **DPIA performed** for high-risk processing — particularly QEAA issuance involving health, biometric, criminal-record data, or large-scale processing
- [ ] **Cross-border processing** — if you process personal data across Member States in scope of the GDPR one-stop-shop, identify your lead supervisory authority
- [ ] **Data minimisation enforced contractually with intermediaries** — Article 5b(10) intermediaries must not store transaction content; ensure your contracts mirror this restriction

---

### 7.3 — Cybersecurity Act Certification

- [ ] **EUCC / EUCS / sector-specific cybersecurity schemes** identified where applicable to your product/service stack
- [ ] **Wallet providers** — Wallet cybersecurity certification under Regulation (EU) 2019/881 to the extent schemes cover the requirements; otherwise via national certification schemes *(Article 5c(2)–(3))*

**Reference:** Directive (EU) 2022/2555 (NIS2); Regulation (EU) 2016/679 (GDPR); Regulation (EU) 2019/881 (Cybersecurity Act); Recitals 50–51 of Regulation (EU) 2024/1183

---

## SECTION 8 — CROSS-BORDER & RECOGNITION

*The whole point of eIDAS 2.0 is that an identification credential issued in Member State A is legally valid in Member State B. The cross-border machinery is concrete.*

---

### 8.1 — Cross-Border Identity Matching (Article 11a)

- [ ] **Unequivocal matching** ensured when acting as a relying party for cross-border services — Member States and their public bodies must implement technical and organisational measures to match natural persons identified by another Member State's notified eID or EUDI Wallet to local records, without profiling
- [ ] **Implementing acts referenced** — Commission to establish standards/specifications by 21 November 2024; confirm current published versions with counsel before designing the matching service

---

### 8.2 — Mutual Recognition of Notified eID Schemes (Article 6)

- [ ] **Cross-border login flow supports notified eID schemes** at the assurance level the service requires (low / substantial / high)
- [ ] **Streamlined notification / peer-review** for new schemes — Member States benefit from a faster review process under the amended Articles 9 and 12a *(Recitals 38–40)*

---

### 8.2a — Cross-Border Recognition of Qualified Trust Services (Article 24a — new)

Article 24a is the explicit, service-by-service statement of cross-Member-State recognition for the entire qualified-trust-service catalogue. A qualified service issued / provided in one Member State is recognised as a qualified service in **all other** Member States across:

- Qualified electronic signatures (and certificates supporting them) *(Art 24a(1))*
- Qualified electronic seals (and certificates supporting them) *(Art 24a(1))*
- Qualified e-sig and e-seal creation devices *(Art 24a(2))*
- Qualified certificates for e-sig / e-seal; qualified services for management of remote QSCDs *(Art 24a(3))*
- Qualified validation services for qualified e-sigs and e-seals *(Art 24a(4))*
- Qualified preservation services for qualified e-sigs and e-seals *(Art 24a(5))*
- Qualified electronic time stamp *(Art 24a(6))*
- Qualified certificate for website authentication (QWAC) *(Art 24a(7))*
- Qualified electronic registered delivery service *(Art 24a(8))*
- **Qualified electronic attestation of attributes (QEAA)** *(Art 24a(9))*
- **Qualified electronic archiving service** *(Art 24a(10))*
- **Qualified electronic ledger** *(Art 24a(11))*

- [ ] **Passporting expectation set internally** — once you have qualified status in your home Member State, you can offer the service across the EU without re-authorisation; sales and contracting workflows should reflect this

---

### 8.3 — Recognition of Third-Country Trust Services (Article 14)

- [ ] **Third-country recognition status checked** — qualified trust services from a non-EU jurisdiction are recognised as legally equivalent only where the Commission adopts an implementing act, or an Article 218 TFEU agreement is concluded, requiring inter alia that the third-country regime maintain and publish a trusted list and satisfy equivalence with EU requirements
- [ ] **No assumption of UK/Swiss/US equivalence by default** — the regime is not symmetric to the GDPR adequacy decision regime; verify the implementing-act position with counsel for each third country relevant to your business

**Reference:** Articles 6, 11a, 14 of Regulation (EU) No 910/2014 as amended; Article 218 TFEU; Regulation (EU) 2022/2555 alignment

---

## SECTION 9 — SUPERVISION & GOVERNANCE

*Know who supervises you, who arbitrates between Member States, and which single point of contact you call when something breaks.*

---

### 9.1 — National Supervisory Body (Article 46a–46b)

- [ ] **Supervisory body of your Member State identified** — Member States designate a supervisory body for trust services and (in many cases) for wallet providers; the body's name and address must be communicated to the Commission. The body has powers of audit, request for information, inspection, withdrawal of qualified status, and supervisory measures
- [ ] **Single point of contact (SPOC) identified** for cooperation with other Member States' supervisors and with the Cooperation Group *(Article 46c)*

---

### 9.2 — European Digital Identity Cooperation Group (Article 46e)

- [ ] **Cooperation Group remit understood** — Commission-chaired, brings together Member State representatives, ENISA and (as observers) other EU bodies. Coordinates implementation of the Wallet framework, certification schemes, identity matching, technical specifications. Opinions and recommendations from the Group shape national certification schemes *(Article 5c(3); Recital 24)*

---

### 9.3 — Mutual Assistance and Joint Supervisory Actions

- [ ] **Mechanisms for mutual assistance** between supervisory bodies in place — important where your trust services or Wallet integration touch multiple Member States
- [ ] **Joint supervisory actions** possible — be prepared for coordinated inspections in cross-border cases

**Reference:** Articles 46a–46e of Regulation (EU) No 910/2014 as amended

---

## SECTION 10 — APPLICATION PROCESS & TIMELINE

*This section maps the practical steps from "decision to act" to "service live on the trusted list."*

---

### 10.1 — Workflow by Role

| Role | Step | Action | Typical Timeline |
|---|---|---|---|
| **Relying party** | 1 | Map intended use and data fields | Weeks 1–2 |
| | 2 | Register in Member State (Article 5b) | 4–12 weeks (varies by MS) |
| | 3 | Integrate Wallet protocols and authentication mechanism | 8–16 weeks |
| | 4 | Live acceptance | Aligned to Article 5f trigger |
| **Non-qualified TSP** | 1 | Risk assessment + NIS2 alignment | Weeks 1–4 |
| | 2 | Notify supervisory body of intent to provide | Weeks 4–8 |
| | 3 | Go live | Post-notification |
| **Qualified TSP** | 1 | Gap analysis vs Articles 19, 24 + per-service article(s) | Weeks 1–4 |
| | 2 | Engage accredited CAB | Weeks 4–8 |
| | 3 | Conformity assessment | 12–24 weeks |
| | 4 | Submit notification + CAR to supervisory body | Week 24+ |
| | 5 | Supervisory body grant of qualified status | Within 3 months of submission (Article 21) |
| | 6 | Trusted list inclusion + EU trust mark live | Immediately on grant |
| **Wallet provider** | 1 | Member State mandate or recognition negotiation | 6–12 months |
| | 2 | Design and build to Article 5a requirements | 12–24 months |
| | 3 | Conformity assessment (Article 5c) | 16+ weeks |
| | 4 | Member State notification to Commission | Post-certification |
| | 5 | Inclusion on Union list (Article 5d) + go live | Within Member State's 24-month Article 5a(1) window |

---

### 10.2 — Documentation Pack (by Role)

**Relying party:**
- [ ] Registration form with: Member State, legal name + registration number, contact details, intended use including the precise list of data fields requested
- [ ] DPIA for Wallet-based processing
- [ ] Records of processing activities (Article 30 GDPR) updated
- [ ] Service-design documentation evidencing pseudonym support and data minimisation
- [ ] Intermediary contracts (if any) mirroring Article 5b(10) restrictions

**Trust service provider (qualified):**
- [ ] Conformity assessment report from accredited CAB
- [ ] Notification to supervisory body
- [ ] Termination plan (Article 24(2)(h))
- [ ] Liability insurance certificate / capital adequacy evidence (Article 24(2)(c))
- [ ] Personnel qualification matrix and training records (Article 24(2)(b))
- [ ] Cryptographic agility plan
- [ ] Per-service technical documentation (e.g. for a qualified electronic ledger: ledger architecture, integrity model, chronological-ordering proof, operator accountability, vulnerability assessment cycle)

**Wallet provider:**
- [ ] Conformity assessment report under Article 5c
- [ ] Open-source repository for application software components, with publication policy for any withheld non-device components and the justification
- [ ] Cybersecurity certification artefacts (EUCC/EUCS as applicable)
- [ ] National certification scheme participation evidence for non-cybersecurity requirements
- [ ] Privacy-preserving cryptography design notes (ZKP, selective disclosure, unlinkability)
- [ ] Common-dashboard UX specification
- [ ] Security-breach runbook covering Article 5e suspension/withdrawal/re-establishment

---

## SECTION 11 — ENFORCEMENT & PENALTIES (ARTICLE 16)

*Penalty exposure under eIDAS 2.0 is materially higher than under the original eIDAS. The floor for the maximum fine is set at the regulation level; Member States may go higher.*

---

### 11.1 — Administrative Fines (Article 16(2))

Member States must give competent authorities the power to impose administrative fines on trust service providers (qualified and non-qualified) of a **maximum of at least**:

| Infringer | Maximum fine floor |
|---|---|
| Trust service provider — natural person | **EUR 5,000,000** |
| Trust service provider — legal person | **EUR 5,000,000** or **1 % of total worldwide annual turnover** in the preceding financial year, whichever is **higher** |

- [ ] **D&O insurance and risk-appetite statement updated** to reflect the EUR 5,000,000 / 1 % floor — the worldwide-turnover base means group exposure for large undertakings
- [ ] **Member State procedure mapped** — Article 16(3) allows national law to set fines through court rather than administrative process; confirm the procedural pathway in your home Member State
- [ ] **Coordination with NIS2 enforcement** — NIS2 has its own penalty regime (EUR 10,000,000 / 2 % worldwide turnover for essential entities). The same incident can attract enforcement under both regimes from different competent authorities. Avoid double-jeopardy arguments by maintaining a unified incident response

---

### 11.2 — Non-Monetary Sanctions and Reputational Exposure

- [ ] **Withdrawal or suspension of qualified status** — the supervisory body can downgrade a qualified service to non-qualified, with corresponding loss of legal presumption and EU trust mark rights *(Articles 20–21)*
- [ ] **Public notification of supervisory decisions** — Member States typically publish enforcement decisions; reputational risk is concrete
- [ ] **Removal from trusted list** — equivalent to commercial death for a QTSP whose value proposition rests on cross-border recognition
- [ ] **Trust mark misuse penalty regime** — Member States must penalise misleading practices that confuse non-qualified and qualified services or that abuse the EU trust mark *(Article 23; Recital 45)*

**Reference:** Article 16 of Regulation (EU) No 910/2014 as amended; Recitals 44–45 of Regulation (EU) 2024/1183; Directive (EU) 2022/2555 Article 34 (NIS2 penalties)

---

## SECTION 12 — KEY DATES & TRANSITIONAL TIMELINE

*Plan against the actual triggers, not against "December 2026" as a single date. The triggers attach to Commission implementing acts.*

---

### 12.1 — Key Dates

| Date | Milestone | Source |
|---|---|---|
| **30 April 2024** | Regulation (EU) 2024/1183 published in OJ L (2024/1183) | — |
| **20 May 2024** | Regulation enters into force (20 days after publication) | Article 3 of Reg 2024/1183 |
| **21 November 2024** | Deadline for the Commission to adopt key implementing acts under Articles 5a(23), 5b(11), 5c(6), 5d(7), 5e(5), 11a(3) — these acts trigger the Member State and relying-party clocks | Each cited article |
| **24 months from entry into force of Article 5a(23) / 5c(6) implementing acts** | Each Member State must provide **at least one EUDI Wallet** | Article 5a(1) |
| **36 months from entry into force of Article 5a(23) / 5c(6) implementing acts** | Article 5f(2) acceptance obligation for private relying parties in listed strategic sectors begins | Article 5f(2) |
| **24 months after deployment of Wallets** | Commission to assess demand, availability, and usability of Wallets | Article 5f(5) |

- [ ] **Wallet rollout date tracked** for each Member State you operate in — Member State provision is independent across the 27 MS
- [ ] **Confirm precise implementing-act publication date** with counsel — the practical "2026 / 2027" deadlines float against this date
- [ ] **Monitor publication of EU implementing acts and Cooperation Group opinions** — these set technical and operational details that supervisors will assess against

> **Founder takeaway — practical planning horizon:** Industry consensus is that the Wallet acceptance obligation under Article 5f(2) will land **late 2026 to mid-2027** for most strategic-sector relying parties. Build a 12–18 month integration window; pre-register under Article 5b in your home Member State once the Article 5b(11) implementing acts are in force.

**Reference:** Article 3 of Regulation (EU) 2024/1183; Articles 5a(1), 5a(23), 5b(11), 5c(6), 5d(7), 5e(5), 5f(2), 5f(5), 11a(3) of Regulation (EU) No 910/2014 as amended

---

## SECTION 13 — INTERPLAY WITH ADJACENT EU REGIMES

*eIDAS 2.0 does not exist in isolation. Map your obligations across the regimes you are already subject to.*

---

### 13.1 — Regulatory Interplay (Decision Map)

| Adjacent regime | Interplay with eIDAS 2.0 |
|---|---|
| **GDPR (Reg (EU) 2016/679)** | Horizontal — every Wallet interaction processes personal data. eIDAS 2.0 specifies additional safeguards (no combination, logical separation, unobservability) |
| **NIS2 (Dir (EU) 2022/2555)** | TSPs are essential entities under NIS2 by virtue of providing trust services. Cybersecurity risk management and incident reporting are governed by NIS2; eIDAS 2.0 Article 19 cross-references it |
| **DSA (Reg (EU) 2022/2065)** | VLOPs designated under Article 33 DSA must accept the EUDI Wallet under Article 5f(3) of eIDAS 2.0 |
| **DORA (Reg (EU) 2022/2554)** | DORA-regulated FIs that accept the Wallet must align their ICT third-party risk management to cover the Wallet integration path |
| **AMLR / AMLD6 (Reg (EU) 2024/1624 / Dir (EU) 2024/1640)** | The EUDI Wallet provides a high-assurance identification means that satisfies CDD identity-verification requirements under EU AML law — but does not replace risk-based EDD, source-of-funds, or PEP screening |
| **PSD3 / PSR** | Strong customer authentication under PSD3 is squarely within the "strong user authentication" trigger of Article 5f(2) — PSPs are caught |
| **MiCA (Reg (EU) 2023/1114)** | CASPs are private relying parties in the financial-services strategic sector — Article 5f(2) acceptance obligation applies |
| **Cybersecurity Act (Reg (EU) 2019/881)** | EUCC/EUCS schemes are the certification vehicle for Wallet and TSP cybersecurity requirements |
| **European Accessibility Act (Dir (EU) 2019/882)** | Wallets, trust services, and end-user products in their provision must be accessible *(Articles 5a(21), 15)* |

- [ ] **Cross-regime gap analysis performed** — particularly for FinTechs caught by MiCA + DORA + AMLR + eIDAS 2.0 simultaneously. Build one control framework that satisfies all four; do not build four parallel ones

**Reference:** Recitals 9, 12, 49–51, 57 of Regulation (EU) 2024/1183; each cited adjacent regulation

---

## READINESS SCORECARD — SUMMARY

*Use this scorecard to assess your overall readiness. Score per the role(s) that apply to you.*

| Section | Topic | Items (approx) | Ready? |
|---|---|---|---|
| 1 | Applicability triage (relying party / TSP / Wallet provider / out-of-scope) | 19 | ☐ |
| 2 | Role classification | 14 | ☐ |
| 3 | Trust service taxonomy (incl. QEAA and qualified electronic ledger) | 18 | ☐ |
| 4 | Relying-party registration and acceptance | 17 | ☐ |
| 5 | TSP obligations (baseline + qualified + liability) | 18 | ☐ |
| 6 | Wallet provider obligations | 21 | ☐ |
| 7 | Cybersecurity, incident reporting & data protection | 11 | ☐ |
| 8 | Cross-border, mutual recognition, third countries | 6 | ☐ |
| 9 | Supervision & governance | 5 | ☐ |
| 10 | Application process & documentation pack | role-dependent | ☐ |
| 11 | Enforcement & penalties | 5 | ☐ |
| 12 | Key dates & transitional planning | 3 | ☐ |
| 13 | Interplay with adjacent EU regimes | 1 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** Ready to engage supervisor / conformity assessor
- **Amber (50–80% complete):** Material gaps exist — close these before filing
- **Red (<50% complete):** Significant preparation required — engage specialist counsel and allocate 3–6 months of pre-engagement work

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for eIDAS 2.0-bound businesses:**

**For Relying Parties (FIs, VLOPs, public bodies):** Article 5b registration package → intended-use and data-minimisation specification → Wallet integration architecture (protocol selection, pseudonym support, validation library) → DPIA + RoPA update → relying-party UX audit against Article 5f acceptance triggers

**For Trust Service Providers (esp. Qualified Electronic Ledger candidates):** Trust-service classification opinion → conformity-assessment-ready architecture for qualified electronic ledgers (sequential ordering, integrity, operator accountability, auditability) → smart-contract ledger components engineered for Articles 45k–45l → on-chain identity registry → cryptographic agility plan → CAB-ready documentation pack

**For QEAA Issuers:** Verifiable credential architecture aligned to Articles 45b–45h + Annexes V/VI/VII → authentic-source integration patterns (Article 45e + Annex VI) → selective-disclosure and ZKP design → wallet-compatible issuance protocols (ARF-aligned) → privacy-by-design review

**For Wallet Providers (under MS mandate or recognition):** Open-source application stack → secure-element integration → Article 5c certification dossier → ZKP / unlinkability libraries → common-dashboard UX → security-breach runbook aligned to Article 5e

**Why builders choose us:** We don't ship a generic blockchain stack and ask your legal team to map it backwards. We engineer to the article, label every component against the specific eIDAS 2.0 obligation it satisfies, and hand the architecture spec to your conformity assessor and your supervisor in the form they expect.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. eIDAS 2.0 requirements depend on Commission implementing acts, ENISA technical guidance, the European Digital Identity Architecture and Reference Framework (ARF), national certification schemes, and Member State implementing measures that are still being published. Always engage qualified eIDAS / digital identity legal counsel for your specific business and jurisdictions.*

*Document version: 1.0 | Last updated: May 2026*
*Regulation references: Regulation (EU) 2024/1183 of the European Parliament and of the Council of 11 April 2024 amending Regulation (EU) No 910/2014 as regards establishing the European Digital Identity Framework, OJ L 2024/1183, 30 April 2024; Regulation (EU) No 910/2014 (eIDAS), as amended.*
