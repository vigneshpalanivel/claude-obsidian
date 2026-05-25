# EU AML Reform Package — Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for Obliged Entities under the New EU AML/CFT Regime

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU AML Reform Package — three coupled instruments:
- **AMLR** — Regulation (EU) 2024/1624 (single rulebook, directly applicable)
- **AMLD6** — Directive (EU) 2024/1640 (enforcement architecture, transposed into national law)
- **AMLA Regulation** — Regulation (EU) 2024/1620 (establishes EU AML Authority in Frankfurt)

**Status:** All three published in OJ on 19 June 2024. AMLA operational since 1 July 2025. AMLR application date + AMLD6 general transposition deadline: **10 July 2027**. Earlier dates for specific AMLD6 BO register provisions (Art. 74 by 10 July 2025; Articles 11–13 + 15 by 10 July 2026). AMLA direct supervision of selected obliged entities begins **2028** (first selection list 2027).
**Document type:** Pre-enforcement readiness assessment — to be completed before AMLR application date (10 July 2027) and refreshed annually thereafter

---

> **Who this document is for:** General counsel, MLROs, compliance officers, CCOs, and operations executives at any EU obliged entity under AMLR Article 3 — banks, payment institutions, e-money institutions, CASPs, investment firms, life and investment-related insurers, consumer lenders, art and high-value goods dealers, and (newly) professional football clubs and agents, investment migration operators, and non-financial mixed holding companies. The reform replaces the patchwork of AML directives (AMLD3–5) with a single directly-applicable rulebook (AMLR), a coupled enforcement directive (AMLD6) transposed into national law, and a new EU-level supervisor (AMLA). This checklist mirrors the intake assessment a specialist EU financial-regulatory lawyer would walk you through before the 10 July 2027 application date.

---

> **How to use this checklist:** The three instruments do three different jobs. **AMLR** tells you *what to do* (CDD, beneficial ownership, suspicious transaction reporting, cash limits) and is directly applicable — no national transposition. **AMLD6** tells you *how you will be sanctioned and who supervises you* and lives in your Member State's transposed law (transposition deadline 10 July 2027). **AMLA Regulation** creates the EU supervisor in Frankfurt, but AMLA only *directly supervises* a narrow set of large cross-border banks and CASPs ("selected obliged entities" under Article 13). For most obliged entities, AMLA matters only indirectly — through RTS/ITS that flow into national supervisory practice. Work through Sections 1–3 in order. **Section 4 (AMLA direct supervision) is a scoping section that most readers will determine they are out of, then skip.**

---

## SECTION 1 — ARE YOU AN OBLIGED ENTITY?

*AMLR Article 3 is the gating article. If you are not an obliged entity under Article 3, AMLR does not apply to you — full stop. If you are, every section below applies. Article 3 materially expands the obliged-entity perimeter compared with AMLD5 — three categories are entirely new (professional football, investment migration, mixed holding companies), and the CASP category is now aligned with the MiCA-driven definition.*

---

### 1.1 — AMLR Obliged-Entity Categories (Article 3)

Tick every category that describes your entity. AMLR applies if any one is true.

**Credit and financial institutions:**

- [ ] Credit institution (bank) as defined in CRR
- [ ] Financial institution as defined in CRR (the residual category — captures factoring, leasing, payment processors, etc. that don't sit in any other named bucket)
- [ ] Payment institution (PI) authorised under PSD2 / PSD3
- [ ] Electronic money institution (EMI), including exempt EMIs
- [ ] Investment firm authorised under MiFID II
- [ ] UCITS management company / AIFM
- [ ] Insurance undertaking — **life insurance and other investment-related insurance only**; pure P&C insurance is out of AMLR scope
- [ ] Insurance intermediary for life / investment-related insurance products

**Crypto and emerging finance:**

- [ ] **Crypto-asset service provider (CASP)** authorised under MiCA Title V (the obligation now tracks the MiCA-driven definition, replacing the AMLD5 "virtual asset service provider" framing)
- [ ] Crowdfunding service provider (ECSP) authorised under Regulation (EU) 2020/1503
- [ ] Crowdfunding intermediaries not licensed under ECSP but conducting similar activity

**Non-financial sectors:**

- [ ] Lawyer, notary, or other independent legal professional (when acting in defined real-estate, business-formation, or financial-transaction contexts)
- [ ] Auditor, external accountant, tax advisor, or person providing tax-related services
- [ ] Trust or company service provider (TCSP)
- [ ] Real estate agent or intermediary in real estate transactions — including letting agents where monthly rent ≥**€10,000**
- [ ] **Credit intermediaries for mortgage and consumer credits** *(excluding certain types — confirm specific carve-outs)*
- [ ] Dealer in **precious metals and stones** as regular professional activity
- [ ] **Dealer in high-value goods** (watches, jewellery, luxury yachts, aircraft, motor vehicles, other luxury goods) as regular professional activity, when accepting or making cash payments of **≥€10,000** (single or linked)
- [ ] **Trader or intermediary in cultural goods** (including fine art) for transactions ≥€10,000
- [ ] Trader in cultural and high-value goods operating **within free zones or customs warehouses** for transactions ≥€10,000
- [ ] **Professional football clubs** *(new category — for transactions with investors, sponsors, football agents/intermediaries, and player transfers, per Art. 3(3)(o); **delayed application date: 10 July 2029** per Art. 90 — distinct from the general 10 July 2027 date for all other Art. 3 categories; Member State exemption available under Art. 5 for top-division clubs with annual turnover <€5M in each of the previous 2 years, or for lower-division clubs, on proven low risk + risk assessment)*

- [ ] **Football agents** *(new category — Art. 3(3)(n); **delayed application date: 10 July 2029** per Art. 90)*
- [ ] **Investment migration operators** *(new category — "golden visa" / "golden passport" residence-for-investment intermediaries)*
- [ ] **Non-financial mixed activity holding companies** *(new category)*
- [ ] Provider of gambling services (not just casinos — extends across the gambling sector)

> **Legal advisor note:** Three obliged-entity categories are entirely new under AMLR and are routinely missed in vendor risk packs and pitch decks — **professional football clubs and agents** (with a *built-in 2-year delayed application* to **10 July 2029** under Art. 90, not a Member State option), **investment migration operators**, and **non-financial mixed holding companies**. CASPs were already in scope under AMLD5 as VASPs, but the AMLR framework now ties them to the MiCA Title V definition and treats them as a distinct subset of financial institutions (explicitly enumerated in AMLA Art. 12(4)(j) for direct-supervision assessment). **There is no "RegTech vendor" or "general SaaS provider" category in Article 3.** Pure technology providers to obliged entities are NOT themselves obliged entities; their AML exposure flows through their FI customers' Article 3 obligations.

**Reference:** AMLR Article 3 (obliged entities); MiCA Title V (CASP definition); Reg 2020/1503 (ECSP)

---

### 1.2 — Carve-Outs and Member State Exemptions (Articles 4–7)

AMLR has three discretionary Member State exemption articles plus a notification regime. Check whether your activity might fall within a national exemption:

- [ ] **Gambling services exemption** *(Art. 4)* — Member States may exempt providers of gambling services (in full or in part) on basis of proven low risk. **Cannot exempt**: (a) casinos, (b) online gambling or sports betting providers as principal activity, except state-operated or state-regulated online gambling. Member State must carry out a risk assessment per Art. 4(2).
- [ ] **Professional football club exemption** *(Art. 5)* — Member States may exempt top-division clubs with annual turnover <€5M (each of previous 2 years) or lower-division clubs, on basis of proven low risk + Member State risk assessment.
- [ ] **Financial activity occasional/very limited exemption** *(Art. 6)* — Member States may exempt persons engaged in a CRD Annex I activity (points (2)–(12), (14), (15)) on occasional/very limited basis, provided ALL of *(Art. 6(1))*:
  - Activity is limited in absolute terms (national turnover threshold per Art. 6(2))
  - Activity is limited on a per-transaction basis (national threshold per Art. 6(3))
  - Activity is NOT the main activity
  - Activity is ancillary and directly related to the main activity
  - Main activity is NOT a tax/legal/TCSP/real estate or gambling activity per Art. 3(3)(a)–(d) or (g)
  - Activity is provided only to customers of the main activity, not to the public
  - **EXCLUSION**: money remittance (per PSD2 Art. 4(22)) cannot be exempted under Art. 6
- [ ] **Prior notification of exemptions** *(Art. 7)* — Member States must notify Commission of any Art. 4/5/6 exemption with risk-assessment justification; Commission has **2 months** to confirm or block; legacy AMLD5 Art. 2(2)/(3) exemptions in place on 10 July 2027 must be notified by **10 October 2027**

> **Legal advisor note:** Carve-outs are **Member-State elective AND Commission-controlled**. The Commission has explicit veto power under Art. 7(2) — a Member State cannot just adopt an exemption and notify; it must wait 2 months for confirmation. Even legacy AMLD5 carve-outs need re-notification by 10 Oct 2027. Confirm with national counsel before assuming exemption — and check whether the Commission has confirmed it.

**Reference:** AMLR Articles 4 (gambling exemption), 5 (football club exemption), 6 (financial activity exemption), 7 (prior notification + Commission confirmation regime)

---

## SECTION 2 — AMLR SUBSTANTIVE OBLIGATIONS (What You Must Do)

*Once obliged-entity status is confirmed, AMLR sets the substantive rulebook. These provisions apply directly from 10 July 2027 — no national transposition is needed for AMLR articles (only AMLD6 articles require transposition). The single rulebook eliminates Member State divergence on what CDD, BO, and STR look like — a material change from the AMLD3–5 era when each Member State had its own gloss.*

---

### 2.1 — Internal Policies, Procedures and Controls (Articles 9–16)

- [ ] **Written AML/CFT policies, procedures and controls** approved by the management body and reviewed at least annually *(Article 9)*
- [ ] **Compliance manager** appointed at executive / management-body level *(Article 11(1))* — designated member of the management body with formal responsibility for AML/CFT compliance
- [ ] **Compliance officer** appointed *(Article 11(2))* — responsible for day-to-day implementation; the compliance officer is the designated person who submits STRs to the FIU per *Article 69(6)*
- [ ] **Independence + adequate resourcing** of the compliance function documented; conflicts-of-interest controls in place
- [ ] **Training programme** for all relevant staff — periodic, role-specific, documented; tested via knowledge checks *(Article 12)*
- [ ] **Employee screening** — fit-and-proper checks for staff in AML-relevant roles (compliance officer, MLRO, front-office, KYC operations, dealing-room)
- [ ] **Independent audit function** — periodic internal or external audit of AML controls; findings tracked to closure
- [ ] **Outsourcing controls** — written agreements + supervisor notification for outsourced AML functions; ultimate accountability stays with the obliged entity *(Article 14)*
- [ ] **Group-wide AML policies** documented and enforced across all subsidiaries, including third-country branches and subsidiaries *(Article 16)*
- [ ] **Group-wide information sharing** policy permitting CDD and risk-relevant data exchange across group entities, with GDPR-compatible legal basis documented

> **Legal advisor note:** The split between the **compliance manager** (Art. 11(1), board-level) and the **compliance officer** (Art. 11(2), operational) is new under AMLR — AMLD5 conflated the roles in many Member States. The compliance officer is the named individual who personally signs STRs under Art. 69(6). Misalignment between job titles, role descriptions, and the AMLR functions is a frequent finding in early gap analyses — re-paper the function before the application date.

**Reference:** AMLR Articles 9–16 (internal organisation, governance, group-wide policies)

---

### 2.2 — Customer Due Diligence — Triggers (Article 19)

CDD must be applied when *(article paragraph references in brackets)*:

- [ ] **Establishing a business relationship** *(Art. 19(1)(a))*
- [ ] **Carrying out an occasional transaction of value ≥€10,000** *(Art. 19(1)(b))* — single or linked transactions
- [ ] **Participating in the creation of a legal entity, setting up of a legal arrangement, or (for accountants, lawyers, TCSPs — Art. 3(3)(a)(b)(c)) transfer of ownership of a legal entity** — regardless of transaction value *(Art. 19(1)(c))*
- [ ] **Suspicion of ML/TF** regardless of any derogation, exemption, or threshold *(Art. 19(1)(d))*
- [ ] **Doubts about the veracity or adequacy of previously obtained customer identification data** *(Art. 19(1)(e))*
- [ ] **Doubts as to whether the person interacted with is the customer or authorised person** *(Art. 19(1)(f))*
- [ ] **For credit institutions and financial institutions (EXCEPT CASPs)**: when initiating or executing an occasional transfer of funds (per TFR) **≥€1,000** *(Art. 19(2))*
- [ ] **For CASPs**: when carrying out an occasional transaction **≥€1,000** *(Art. 19(3)(a))*; for transactions <€1,000, apply at least Art. 20(1)(a) identification only *(Art. 19(3)(b))*
- [ ] **For all obliged entities**: when carrying out an occasional **cash** transaction **≥€3,000** *(Art. 19(4))* — apply at least Art. 20(1)(a) identification (suspended where the Member State has an Art. 80 cash limit ≤€3,000)
- [ ] **For gambling service providers**: at collection of winnings, wagering of stake, or both, when transactions amount to **≥€2,000** *(Art. 19(5))*

> **Legal advisor note:** Art. 19 distinguishes triggers for *full CDD* (paragraph 1, all measures under Art. 20) from triggers for *minimum CDD* (Art. 20(1)(a) identification only — paragraphs 3(b), 4, and the supervisor-exempt e-money case in paragraph 7). The €3,000 cash trigger and the CASP €1,000 trigger are minimum-CDD triggers — design the onboarding flow to distinguish full-CDD entry points from identification-only entry points.

**Reference:** AMLR Article 19 (application of CDD measures); Article 3(9) Reg 2023/1113 (TFR transfer-of-funds definition cross-reference)

---

### 2.3 — Customer Due Diligence — Measures (Article 20)

For every CDD trigger, the obliged entity must apply ALL of the following measures, proportionate to the risk:

- [ ] **Customer identification + verification** using independent, reliable source data — including the **EUDI Wallet from 31 December 2026** as a mandatory acceptable identification means under eIDAS 2.0
- [ ] **Beneficial owner identification + reasonable verification** under Chapter IV (see 2.5 below)
- [ ] **Purpose and intended nature of the business relationship** assessed and documented
- [ ] **Targeted Financial Sanctions screening** of customer AND beneficial owners — at onboarding AND on every sanctions-list update
- [ ] **Ongoing monitoring** of the business relationship and the transactions carried out throughout it — scrutiny of transactions for consistency with the customer's risk profile, source of funds, and stated activity
- [ ] **Source of funds + source of wealth** assessed where appropriate to risk (mandatory for EDD; risk-based for standard CDD)
- [ ] **Periodic CDD refresh** based on documented risk-tiered cadence (e.g. annual for high-risk, every three to five years for low-risk)

> **Legal advisor note:** "Sanctions screening" in Article 20 is mandatory at the customer record AND at every beneficial owner record — broader than the legacy AMLD5 framing. Build the screening pipeline to fire on both records at onboarding, and to re-fire across the full customer base on every sanctions-list update. Sanctions-screening defects (under-screening of BO records, no re-screening on list updates, false-negative tuning) are emerging as the AMLA-coordinated thematic review topic — get this right before the first AMLA peer review cycle.

**Reference:** AMLR Article 20 (CDD measures); Article 28 (RTS on CDD information — being developed by AMLA)

---

### 2.4 — Simplified and Enhanced CDD (Articles 33–46)

- [ ] **Simplified CDD (SDD)** applied only to lower-risk cases identified per (i) AMLR risk assessment + (ii) AMLA RTS on lower-risk situations — SDD does NOT exempt customer identification; it permits reduced verification depth and frequency
- [ ] **Enhanced CDD (EDD)** applied when *(Article 34 and adjacent)*:
  - **High-risk third countries** (per Commission delegated list)
  - **Politically Exposed Persons (PEPs)** — domestic PEPs, foreign PEPs, family members, known close associates; PEP status and EDD obligations continue **≥12 months** after the individual leaves the prominent public function
  - **Correspondent banking** with third-country institutions
  - **Cross-border correspondent relationships with third-country CASPs** *(new EDD trigger under AMLR — relevant where an EU CASP onboards a non-EU CASP as an institutional counterparty)*
  - **High-risk customer / product / geography combinations** identified by the entity's own risk assessment
  - **Unusually complex or large transactions** without apparent economic or lawful purpose
- [ ] **EDD measures** include:
  - Additional information on customer, BO, source of funds, source of wealth
  - **Senior management approval** to establish or continue the business relationship
  - **Enhanced ongoing monitoring** — increased frequency, expanded scope, deeper transaction scrutiny
  - Additional identification and verification of beneficial owners
  - Independent and reliable corroboration of customer-provided information

> **Legal advisor note:** The new EDD trigger for **correspondent relationships with third-country CASPs** did not exist under AMLD5 and is the most-missed item in CASP onboarding flows. If you are an EU CASP that provides liquidity to, settles for, or routes customer transactions through a non-EU CASP at the institutional level, that's a correspondent relationship — EDD is mandatory. Design the counterparty CASP EDD workflow into onboarding now; retrofitting at the application date is significantly more expensive.

**Reference:** AMLR Article 21 (inability to comply with CDD); Section 3 (simplified CDD); Section 4 (enhanced CDD); Articles 33–46

---

### 2.5 — Beneficial Ownership Identification (Chapter IV, Articles 51–63)

- [ ] **Two parallel identification tracks** assessed for every legal-entity customer *(Article 51)*:
  - **Ownership track** *(Article 52)*: natural person holding **≥25%** of shares, voting rights, profit participation rights, OR liquidation rights — note the threshold change from ">25%" (AMLD5) to "**≥25%**" (AMLR)
  - **Control track** *(Article 53)*: natural person exercising **decisive influence** through formal or informal agreements, voting arrangements, shareholder agreements, or other means — control as the *possibility* to exercise influence, not requiring actual exercise
- [ ] **Where no UBO is identifiable** under either ownership or control track: senior managing official(s) recorded as the fallback BO *(near Article 63)*
- [ ] **Collective investment undertakings (CIUs)** — special BO identification rules under *Article 61*
- [ ] **Trusts and similar legal arrangements** — BO identification covers settlor, trustees, protector, beneficiaries, and any other natural person exercising ultimate control
- [ ] **Reasonable verification** of BO identity via reliable sources — including the national BO register AND independent corroboration (the register alone is not sufficient)
- [ ] **BO information kept current** — refresh on any change-of-control event, ownership restructuring, or material corporate action
- [ ] **Discrepancy reporting** — discrepancies between entity-collected BO data and national BO register data must be reported to the register (Member State implementation flows via AMLD6 register articles)

> **Legal advisor note:** The threshold change from ">25%" to "≥25%" looks minor but creates real onboarding friction at the boundary — customers whose UBOs sit at exactly 25% need to be reclassified. Audit your historic onboarded customer base before the application date; bulk re-papering at the 10 July 2027 deadline is operationally painful. Forward-looking: the Commission has an Article 52 delegated-act power to lower the threshold to **15%** for higher-risk entity categories. Build your data model so the threshold is a parameter, not a hard-coded value.

**Reference:** AMLR Chapter IV, Articles 51–63 (beneficial ownership)

---

### 2.6 — Suspicious Transaction Reporting (Chapter V, Articles 69–76)

- [ ] **STR submitted to the national FIU** for every suspicion of ML/TF — including:
  - Attempted transactions (not just executed)
  - Suspicions arising from inability to complete CDD *(Article 21)*
  - Suspicions arising from negative news, sanctions hits, or third-party tips
- [ ] **STR submitted by the named compliance officer** *(Article 69(6))* — single point of accountability; the compliance officer signs personally
- [ ] **FIU information requests answered within 5 working days** *(Article 69)* — FIU may shorten this deadline to **less than 24 hours** in justified and urgent cases
- [ ] **Tipping-off prohibition** observed *(Article 76)* — no disclosure to the customer or to any third party that an STR has been filed, is being prepared, or that the customer is under analysis
- [ ] **Refrain from executing suspicious transactions** where possible, unless executing the transaction is necessary for law enforcement purposes *(Article 75)*
- [ ] **Internal escalation log** maintained for every suspicion considered — including suspicions that did not result in STR filing (the rationale-for-no-filing decision must be documentable on FIU request)

> **Legal advisor note:** Tipping-off is an individual criminal offence in most Member States — train front-office staff explicitly. The most common operational failure: relationship managers asking the customer "is there an explanation for this transaction" *after* STR filing as part of "managing the relationship." That's tipping-off, full stop. Build the tipping-off prohibition into the customer-contact policy at the technical level: lock customer-facing comms on accounts with active STR analysis.

**Reference:** AMLR Chapter V, Articles 69–76 (reporting suspicions and tipping-off prohibition)

---

### 2.7 — Record Retention (Article 77)

- [ ] **CDD records retained for 5 years** after the end of the business relationship or after the date of the occasional transaction (covers documents and information obtained under Chapter III)
- [ ] **Transaction records retained for 5 years** — supporting evidence and records of transactions, originals or copies admissible in judicial proceedings; longer where national law requires for tax or judicial purposes
- [ ] **Suspicion assessments (Art. 69(2)) and copies of STRs retained for 5 years** after the date of assessment / filing
- [ ] **Information-sharing partnership records** retained where the entity participates in such partnerships
- [ ] **5-year extension on competent authority direction** — the supervisor may require an additional 5-year retention period on a case-by-case basis where necessary for AML/CFT investigations
- [ ] **Records not redacted** — entities may retain references instead of copies only where they can provide the original information immediately to authorities on request
- [ ] **Records accessible to the FIU and competent authority within 2 working days** of request
- [ ] **GDPR-compliant deletion** at the end of the retention period — no indefinite retention without a fresh legal basis; deletion process auditable

> **Legal advisor note:** The 5-year retention period is shorter than several existing AMLD5-transposed national rules (Italy, Spain historically went longer). National law may continue to require longer retention for tax or judicial purposes — confirm with national counsel. The AMLR floor is 5 years; national overlay may be longer; AMLR does not override longer national retention.

**Reference:** AMLR Article 77 (record retention)

---

### 2.8 — Cash Payment Limit (Article 80)

- [ ] **EU-wide cash payment cap: €10,000** (single or linked payments, accepted or made by an obliged entity in the course of professional activity) — applies from **10 July 2027**
- [ ] **Lower national limits preserved** where notified to the Commission by **10 October 2024** (e.g. France €1,000; Italy €5,000; Spain €1,000 resident / €10,000 non-resident — confirm current national thresholds)
- [ ] **Identification + CDD triggered at €3,000** for occasional cash transactions *(Article 19)* — separate from the €10,000 prohibition; the €3,000 trigger is identification, not prohibition
- [ ] **B2B and B2C cash payments** above €10,000 prohibited where at least one party is acting in professional capacity (persons trading in goods or providing services) *(Art. 80(1))*
- [ ] **Member States may adopt LOWER cash limits** following ECB consultation; lower limits **notified to Commission within 3 months** *(Art. 80(2))*
- [ ] **Pre-existing lower national limits preserved** if notified to Commission by **10 October 2024** *(Art. 80(3))*
- [ ] **Exclusions from the cap** *(Art. 80(4))*:
  - **(a)** Payments between natural persons NOT acting in a professional capacity
  - **(b)** Payments or deposits made at the premises of **credit institutions, EMIs (per Dir 2009/110/EC Art. 2(3)), or PSPs (per Dir (EU) 2015/2366 Art. 4(11))** — these are excepted from the Art. 80 cap **BUT above-threshold payments/deposits MUST be reported to the FIU within FIU-imposed deadlines**
- [ ] **Member States enforce via penalties** *(Art. 80(5)–(6))* — proportionate to seriousness of infringement
- [ ] **Force majeure suspension** *(Art. 80(7))* — Member States may temporarily suspend Art. 80(1) or 80(2) if non-cash payment means become unavailable nationally due to force majeure; Commission notified; Commission may order immediate lifting if it considers suspension unjustified

> **Legal advisor note:** Two common misframes — (i) the **€10,000** figure is the *prohibition* threshold under Article 80; the *CDD identification* threshold under Article 19 is **€3,000** for occasional cash transactions, lowered from €7,500 under AMLD5. Don't confuse the two when training cashiers and tellers. (ii) The cap is on cash *as a payment instrument*. Cash deposits to one's own bank account are not "payments" between parties — different rules. Crypto-asset transactions are NOT cash for Article 80 purposes — they sit under AMLR Article 80 only if the on/off-ramp is a cash payment.

**Reference:** AMLR Article 80 (limits to large cash payments)

---

### 2.9 — Sanctions and PEP Screening (Cross-Cutting)

- [ ] **Targeted Financial Sanctions screening** at onboarding + ongoing for both customer and BO records
- [ ] **PEP identification** at onboarding — domestic PEPs, foreign PEPs, family members, known close associates
- [ ] **PEP measures continue ≥12 months** after the prominent public function ends
- [ ] **EDD for PEPs is automatic** — senior management approval, source of wealth, enhanced ongoing monitoring
- [ ] **Screening triggered on sanctions list updates** — pipeline must re-fire across full customer + BO base, not only on new onboardings
- [ ] **False-positive tuning + manual disposition queue** documented; AMLA-relevant supervisor will inspect the tuning logic

**Reference:** AMLR Article 20(1)(f) (sanctions screening); Articles 42–46 (PEPs); Council Regulations on targeted financial sanctions for substantive lists

---

## SECTION 3 — AMLD6: SANCTIONS REGIME AND NATIONAL SUPERVISORS

*AMLD6 does not apply to you directly. Your Member State's transposed national law applies. AMLD6 sets the **floor** — Member States may go further. The phased transposition schedule per **Art. 78** is:*

- *General deadline: **10 July 2027***
- *Art. 74 (Amendments to Dir 2015/849, including new BO register access rules with "legitimate interest" framework): **10 July 2025***
- *Arts 11, 12, 13, 15 (BO register infrastructure): **10 July 2026***
- *Art. 18 (Single access point to real estate information): **10 July 2029***

*Entry into force per Art. 79: 9 July 2024 (20 days after OJ publication on 19 June 2024). What follows is the AMLD6 floor; check your national transposition for actual penalties and supervisor structure.*

---

### 3.1 — Maximum Administrative Pecuniary Sanctions

**Article 55 (Pecuniary sanctions)** — Member States must impose pecuniary sanctions on obliged entities for serious, repeated, or systematic breaches (intentional or negligent) of:
- AMLR **Chapter II** (Internal policies, procedures and controls)
- AMLR **Chapter III** (Customer due diligence)
- AMLR **Chapter V** (Reporting obligations)
- AMLR **Article 77** (Record retention)

Plus where the obliged entity fails to comply with administrative measures under Art. 56, or for non-serious / non-systematic breaches *(Art. 55(1))*.

Maximum sanction levels:
- [ ] **General floor** *(Art. 55(2))*: maximum at least **twice the benefit derived from the breach** (where determinable) OR **at least €1 million** — whichever is higher
- [ ] **Credit institutions and financial institutions — legal persons** *(Art. 55(3)(a))*: maximum **at least €10 million OR 10% of total annual turnover** (whichever is higher); for parent/subsidiary in a consolidated group, the relevant turnover is the **ultimate parent's consolidated turnover**
- [ ] **Credit institutions and financial institutions — natural persons** *(Art. 55(3)(b))*: maximum **at least €5 million** (€5,000,000 or national-currency equivalent at 9 July 2024 conversion reference date)
- [ ] **Currency conversion reference date**: **9 July 2024** for non-euro Member States

> **Legal advisor note:** Art. 55 is a **minimum harmonisation floor** ("at least") — Member States may transpose at higher caps. Germany, Netherlands have historically gone above. Always verify the specific national transposition before quoting numbers to a client. Note the breach scope is **explicitly limited** to AMLR Chapters II, III, V and Art. 77 — sanctions for other AMLR breaches (e.g., Art. 80 cash limit) flow via Art. 56 administrative measures and Art. 55(1) catch-all, not the headline Art. 55(3) caps.

**Article 56 (Administrative measures)** — supervisors may apply administrative measures (alongside or in lieu of Art. 55 sanctions) for breaches, weaknesses likely to lead to breaches, or disproportionate internal controls:

- [ ] *(Art. 56(2)(a))* recommendations
- [ ] *(Art. 56(2)(b))* compliance orders, including specific corrective measures
- [ ] *(Art. 56(2)(c))* public statements identifying the natural / legal person and the nature of the breach
- [ ] *(Art. 56(2)(d))* cease-and-desist orders
- [ ] *(Art. 56(2)(e))* restrict/limit business, operations or network of institutions; or require divestment of activities
- [ ] *(Art. 56(2)(f))* withdraw or suspend authorisation (where the obliged entity holds one)
- [ ] *(Art. 56(2)(g))* require changes in governance structure
- [ ] *(Art. 56(3))* data submission requirements, reinforcement of policies, customer- or product-specific requirements, temporary management bans

**Reference:** AMLD6 Article 55 (pecuniary sanctions), Article 56 (administrative measures); cross-reference to AMLA Regulation Article 22 for the AMLA-imposed parallel sanctioning power on selected obliged entities

---

### 3.2 — National Supervisor Architecture

- [ ] **Identify your competent supervisor** — typically the same NCA that authorises your sectoral business (ECB / national central bank / BaFin / AMF / CSSF / CNMV / CBI / etc. for credit institutions; sectoral regulator for PIs, EMIs, CASPs, investment firms)
- [ ] **Confirm supervisor's AML mandate scope** — for credit institutions, the prudential supervisor and the AML supervisor are often co-located but legally distinct
- [ ] **Confirm reporting + notification channels** for STRs (national FIU) and for supervisory matters (NCA)
- [ ] **Document the supervisor's on-site inspection rights** under national law (notice, scope, in-camera procedures, escalation)
- [ ] **AMLA coordination expectation** — your national supervisor will increasingly coordinate with AMLA (RTS, peer reviews, common methodologies) — material in your supervisory dialogue from 2026 onward, well before the AMLA direct-supervision start date

**Reference:** AMLD6 Article 40 (risk-based supervision), Article 41 (central contact points), Article 50 (AML/CFT supervisory colleges in the non-financial sector), Article 52 (oversight of self-regulatory bodies), Article 67 (professional secrecy); national competent authority designation per Member State transposition; AMLA Regulation Articles 25–30 (indirect supervision and cooperation pathway)

---

### 3.3 — Financial Intelligence Unit (FIU)

- [ ] **National FIU designated** under AMLD6 (typically a specialised unit within a national authority — e.g., FIU-NL Netherlands, FIU-IT Italy, Tracfin France, FIU Malta)
- [ ] **STR submission channel + format** documented — increasingly mandated digital structured format (e.g., goAML)
- [ ] **FIU information requests** answered within **5 working days** *(AMLR Article 69)* — possible reduction to **<24 hours** in urgent cases
- [ ] **FIU access** to beneficial ownership register, real estate register, tax data, vehicle register, customs data — these are AMLD6 transposition items
- [ ] **Cross-border FIU cooperation** via **FIU.net** infrastructure — AMLA assumes operational coordination from 2026 onwards
- [ ] **Joint analyses by FIUs** facilitated by AMLA — your STR data may flow into multi-FIU analysis without further notice to the obliged entity

**Reference:** AMLD6 Article 42 (disclosure to FIUs); FIU establishment, powers and cooperation articles per Member State transposition; AMLA Regulation Articles 5(2) + 38–40 (FIU coordination role)

---

### 3.4 — Beneficial Ownership Registers

- [ ] **Real estate single access point** *(Art. 18)* — Member States must establish a single electronic access point (digital, machine-readable where possible) giving competent authorities + AMLA immediate free access to: cadastral parcel + reference, geographic location, area/size, property type, owner identity (incl. legal entity ownership) and transaction history; **transposition deadline 10 July 2029** — material for real estate agents, lawyers/notaries in property transactions, and any obliged entity doing real-estate-related CDD
- [ ] **National BO register submission** kept current for all corporate entities + express trusts (separate registers for legal persons and legal arrangements)
- [ ] **Discrepancy reporting** from obliged entities — any divergence between BO entity-data and registered BO data must be reported to the register
- [ ] **Register access rules under AMLD6** *(post-CJEU Sovim/WM ruling, Joined Cases C-37/20 and C-601/20)*:
  - **Competent authorities + FIUs**: unrestricted access
  - **Obliged entities for CDD purposes**: access on the AMLR Article 20 basis
  - **General public**: NO general/automatic public access (struck down by the CJEU in 2022 as disproportionate)
  - **Persons with legitimate interest**: access granted — explicitly including journalists, civil society organisations, academic researchers, and counterparties to transactions
- [ ] **Earlier transposition for register access**: Article 74 by **10 July 2025**; Articles 11–13 + 15 by **10 July 2026** (these dates are *earlier* than the general 10 July 2027 transposition deadline — most Member States are now operationally live on the register access regime)

> **Legal advisor note:** The "legitimate interest" framework is the most-litigated piece of AMLD6 transposition. Several Member States have interpreted "legitimate interest" narrowly (requiring journalist credentialling, formal application + national-authority approval); others broadly (presumption of legitimate interest for credentialled journalists and academics). If you are an obliged entity that relies on national BO registers for CDD, your access path is the **AMLR Article 20 basis (CDD purpose)** — different procedural rules from the legitimate-interest path. The legitimate-interest path matters mainly for journalists, NGOs, and academic counterparties asking the obliged entity to verify BO data they have obtained independently.

**Reference:** AMLD6 Articles 11–13, 15 (BO register infrastructure, transposed by 10 July 2026); Article 74 (register accessibility, transposed by 10 July 2025); CJEU Joined Cases C-37/20 and C-601/20 (2022 Sovim/WM ruling)

---

## SECTION 4 — AMLA DIRECT SUPERVISION (Most Readers Skip This)

*AMLA in Frankfurt has been operational since 1 July 2025. AMLA *directly supervises* only a narrow set of large cross-border banks and CASPs — "selected obliged entities" under AMLA Regulation Article 13. For everyone else, AMLA supervises *indirectly* via RTS/ITS standards, peer reviews of national supervisors, and convergence work. Your operational counterpart remains your national supervisor under AMLD6 transposition. Read 4.1; if you fall outside, skip 4.2 and read 4.3 only.*

---

### 4.1 — Are You a "Selected Obliged Entity"?

Selection is a **two-stage mechanism** — Art. 12 sets who gets *assessed*; Art. 13 sets who from that pool becomes *selected*.

**Stage 1 — Periodic assessment eligibility (Art. 12(1))**:

- [ ] **Entity type**: credit institution OR financial institution OR group of credit/financial institutions
- [ ] **Operate in at least 6 Member States** *(Art. 12(1) verbatim)* — "where they operate, whether through establishments or under the freedom to provide services, **in at least six Member States, including the home Member State**, regardless of whether the activities are carried out through infrastructure on the territory concerned or remotely"
- [ ] **Risk profile classified as low / medium / substantial / high** by AMLA per benchmarks in the Art. 12(7) RTS, applied separately to each of the **11 enumerated obliged-entity categories** *(Art. 12(4))*: (a) credit institutions, (b) bureaux de change, (c) collective investment undertakings, (d) credit providers other than credit institutions, (e) e-money institutions, (f) investment firms, (g) payment institutions, (h) life insurance undertakings, (i) life insurance intermediaries, **(j) crypto-asset service providers**, (k) other financial institutions

If you operate in **fewer than 6 Member States**, you are not periodically assessed under Art. 12 — and therefore cannot be selected under Art. 13(1) **except via the per-MS fallback rule below (Art. 13(3))**.

**Stage 2 — Selection from the assessed pool (Art. 13)**:

- [ ] **Art. 13(1)** — credit / financial institutions (and groups) whose **residual risk profile has been classified as high** under Art. 12 qualify as selected obliged entities
- [ ] **Art. 13(2) — 40-entity cap with discretion to expand**: if more than 40 entities qualify under (1), AMLA may, in consultation with supervisors, agree on a different number greater than 40 (capacity-constrained); priority then goes to entities **operating in the highest number of Member States**; tie-breaker = highest ratio of **third-country transactions to total transactions** (last financial year)
- [ ] **Art. 13(3) — per-Member-State fallback**: where no entity in a Member State qualifies under (1)–(2), AMLA carries out an **additional selection process** so that each Member State has at least one selected obliged entity with a high risk profile; tie-breakers = highest MS count, then highest third-country transaction ratio

> **Legal advisor note:** The ≥6 Member States criterion is in **Art. 12(1)**, not Art. 13 — it is the assessment-eligibility floor, not the selection criterion. Selection itself (Art. 13) turns on **high residual risk classification**, not size or geographic spread per se. The 40-entity cap in Art. 13(2) is a capacity ceiling, not a target — first selection cycle in 2027 is widely expected to land at ~40. Prototypical selected obliged entities: tier-1 EU banks with broad cross-border footprint (BankTech ICP — Revolut, N26, ING-class); large cross-border CASPs above the assessment threshold (ExchangeTech ICP — Binance EU, Coinbase Europe, Kraken EU-class) — note CASPs are an explicitly enumerated assessment category under Art. 12(4)(j). National-focused PIs / EMIs / single-Member-State CASPs / RegTech vendors are out of Stage 1 assessment, so out of Stage 2 selection, **unless** the per-MS fallback rule applies. **First selection list 2027; direct supervision begins 2028.**

**Reference:** AMLA Regulation Article 13 (definition of selected obliged entity); Article 12(7) (RTS on selection methodology); AMLA RTS final report under Article 12(7) (published 2025–2026)

---

### 4.2 — If You Are a Selected Obliged Entity

The remainder of Section 4.2 applies. If you are uncertain, obtain a formal scoping opinion **now** — selection decisions for the 2027 first cycle are being prepared based on national-supervisor reporting packages already in circulation.

#### 4.2.1 — Joint Supervisory Teams (JSTs)

- [ ] **JST composition documented** — AMLA staff + national supervisor staff under AMLA leadership
- [ ] **JST as single supervisory interface** for all AMLA-supervised AML matters
- [ ] **JST on-site inspection rights** confirmed; entry, scope, in-camera procedures documented
- [ ] **JST reporting cadence** documented (typically quarterly review + ad-hoc on material incidents)

#### 4.2.2 — AMLA's Direct Supervisory Powers (Articles 17–23)

- [ ] **Article 17** — information request powers, exercisable without national-supervisor intermediation
- [ ] **Articles 18–19** — investigations and on-site inspections, including unannounced inspections where authorised
- [ ] **Article 22** — pecuniary sanctions imposed by the AMLA Executive Board for serious, repeated, or systematic breaches of:
  - **TFR (Reg 2023/1113)** OR **AMLR (Reg 2024/1624)** OR a binding AMLA decision under Article 6(1)
  - Maximum cap: **10% of total annual turnover** for CDD breaches *(Art. 22(6))*
  - Maximum cap: **€10 million** for other serious breaches *(Art. 22(7))*
  - Basic amount band for multi-jurisdiction CDD violations: **€500,000 to €2 million or 1% turnover (whichever higher)** *(Art. 22(3)(a))*
  - Sanctions must be **effective, proportionate, and dissuasive**
- [ ] **Article 23** — periodic penalty payments alongside or in lieu of one-off fines
- [ ] **Publication of sanctions decisions** with name, violation nature, and amount
- [ ] **Withdrawal recommendation** to home-NCA where AML failings warrant sectoral authorisation withdrawal (AMLA itself does not withdraw the sectoral licence — that remains the home-NCA's act)

#### 4.2.3 — Reporting and Documentation to AMLA

- [ ] **Annual AML/CFT report to AMLA** in standardised format (template under AMLA RTS/ITS)
- [ ] **Material change notifications** — governance changes, key personnel changes, group structure changes
- [ ] **Significant AML-relevant incident reporting** in parallel to DORA major-incident reporting where the incident also has AML relevance (e.g., compromise of CDD systems, customer data exfiltration relevant to sanctions screening)

**Reference:** AMLA Regulation Articles 13 (direct supervision scope), 17–23 (supervisory and investigative powers), 25–30 (cooperation with national authorities)

---

### 4.3 — For Non-Selected Obliged Entities: How AMLA Still Reaches You

AMLA does not directly supervise you, but its work product flows through your national supervisor:

- [ ] **RTS / ITS adopted by Commission on AMLA's draft** — directly applicable; binds your operations (e.g., AMLR Art. 28 CDD-information RTS; BO discrepancy reporting RTS; AMLR Art. 12(7) selection methodology RTS)
- [ ] **Guidelines and recommendations** — national supervisor expected to comply or explain
- [ ] **Peer reviews of your national supervisor** — may trigger thematic reviews flowing down to you
- [ ] **Convergence + thematic reviews** coordinated by AMLA (sectoral or topical — e.g., CASP onboarding controls, sanctions-screening defects, BO discrepancy reporting)
- [ ] **Common training and supervisory methodology** — your supervisor's inspection style will increasingly converge with AMLA's, even though AMLA does not directly inspect you

> **Legal advisor note:** Treat AMLA-published RTS/ITS as binding-on-you even though AMLA does not directly supervise you. The implementing legal instrument is a Commission delegated/implementing act, with AMLA as the technical drafter. The **Article 28 CDD RTS** is the highest-stakes one for v1 — it will codify exactly what data points and verification standards constitute compliant CDD across all Member States. Once adopted, it removes Member-State divergence on CDD operational standards.

**Reference:** AMLA Regulation Articles 25–30 (cooperation with national supervisors); Article 5 (AMLA tasks); various AMLR articles (notably Article 28) cross-referencing AMLA RTS development

---

## SECTION 5 — REGULATION INTERACTION POINTS

*The AML package does not sit alone. For most obliged entities, AMLR/AMLD6/AMLA stack with one or more other EU regimes. The interaction points below are the most common sources of compliance tension.*

---

### 5.1 — AMLR ↔ GDPR (the data-tension axis)

- [ ] **Legal basis for processing customer + BO personal data** documented under both AMLR (legal obligation, Article 6(1)(c) GDPR) and the entity's sectoral authorisation
- [ ] **Cross-border data sharing for AMLA supervision** — assess against GDPR Articles 44–49 (international transfers) where AMLA involves third-country supervisors
- [ ] **Group-wide information sharing** *(AMLR Article 16)* — GDPR-compliant intra-group legal basis required; binding corporate rules or equivalent for third-country subsidiaries
- [ ] **Tipping-off prohibition vs. GDPR data subject access requests** — managed via the AMLR Article 76 prohibition + national-FIU coordination on response framing
- [ ] **Retention period** *(AMLR Article 77 — 5 years)* documented as the GDPR storage-limitation justification; deletion process auditable

> **Legal advisor note:** EDPB and AMLA are still finalising joint guidance on the AMLR-GDPR interface — particularly on cross-border AMLA data flows. The landscape document flags this as a live tension point. Build the data architecture to permit *both* GDPR-compliant deletion AND AMLR-compliant retention extension on FIU request — these are not in conflict if the architecture supports event-driven retention.

**Reference:** AMLR Articles 16, 76, 77; GDPR (Regulation (EU) 2016/679); EDPB-AMLA forthcoming joint guidance

---

### 5.2 — AMLR ↔ MiCA (for CASPs)

- [ ] CASP-classified entity in scope of AMLR Article 3 by virtue of MiCA Title V authorisation
- [ ] TFR (Regulation (EU) 2023/1113) Travel Rule applies to all CASP-to-CASP and CASP-to-unhosted-wallet crypto transfers — separate compliance workstream from AMLR but operationally co-located
- [ ] **MiCA white paper liability** for token offerings — separate from AMLR but typically managed by the same compliance team
- [ ] **CASP onboarding flow** must satisfy AMLR Article 20 CDD + MiCA + TFR Travel Rule in one customer journey

**Reference:** AMLR Article 3 (CASP as obliged entity); MiCA (Regulation (EU) 2023/1114); TFR (Regulation (EU) 2023/1113)

---

### 5.3 — AMLR ↔ DORA (for all FE-classified obliged entities)

- [ ] **CDD and sanctions screening systems** classified as ICT services supporting a critical or important function under DORA — apply DORA Pillar 1 risk management + Pillar 2 incident reporting accordingly
- [ ] **Compromise of CDD or sanctions screening systems** → triggers both DORA Article 18 major-incident reporting AND (where AML-relevant) AMLA notification under Article 4.2.3
- [ ] **Third-party providers of KYC/CDD tooling** → DORA Article 30 contractual clauses + AMLR Article 14 outsourcing controls — design once, satisfy both regimes

**Reference:** AMLR Articles 14, 20; DORA (Regulation (EU) 2022/2554) Articles 8, 18, 28, 30

---

### 5.4 — AMLR ↔ eIDAS 2.0 (mandatory from 31 December 2026)

- [ ] **EUDI Wallet** must be accepted as a means of customer identification for CDD onboarding from 31 December 2026 — applies to every obliged entity performing customer KYC
- [ ] **Relying-party registration** with the national eIDAS authority completed
- [ ] **CDD workflow updated** to support EUDI Wallet identity attribute consumption alongside legacy identification methods

**Reference:** AMLR Article 20; eIDAS 2.0 (Regulation (EU) 2024/1183)

---

## SECTION 6 — KEY DATES, SCOPE TABLE, SOURCES

---

### 6.1 — Consolidated Timeline

| Date | Event | Instrument |
|---|---|---|
| 19 Jun 2024 | All three instruments published in OJ (L series) | All |
| 9 Jul 2024 | AMLR and AMLD6 enter into force (20 days after OJ publication) | AMLR + AMLD6 |
| 10 Oct 2024 | Deadline for Member States to notify Commission of pre-existing lower national cash limits *(AMLR Art. 80(3))* | AMLR |
| 1 Jul 2025 | AMLA operational in Frankfurt | AMLA Reg |
| 10 Jul 2025 | AMLD6 **Article 74** (Amendments to Dir 2015/849 including BO register access + legitimate interest framework) — national transposition deadline | AMLD6 |
| 10 Jul 2026 | AMLD6 **Articles 11, 12, 13, 15** (BO register infrastructure) — national transposition deadline | AMLD6 |
| 10 Jul 2026 | AMLA ITS on STR format (per AMLR Art. 69(3)) — draft submission to Commission | AMLR |
| 31 Dec 2026 | EUDI Wallet acceptance becomes mandatory for CDD | eIDAS 2.0 (cross-regime) |
| 2027 | AMLA first selection cycle — list of "selected obliged entities" published | AMLA Reg |
| **10 Jul 2027** | **AMLR application date + AMLD6 general transposition deadline (Art. 78(1))** | AMLR + AMLD6 |
| 2028 | AMLA direct supervision of selected obliged entities begins | AMLA Reg |
| 10 Jul 2029 | AMLD6 **Article 18** (Single access point to real estate information) — national transposition deadline | AMLD6 |
| 10 Jul 2029 | AMLR application to **football agents (Art. 3(3)(n)) and professional football clubs (Art. 3(3)(o))** — per Art. 90 second subparagraph | AMLR |
| 10 Jul 2029 | Commission may adopt delegated act under AMLR Art. 52(2) lowering BO threshold to 15% (max) for higher-risk categories | AMLR |
| 10 Jul 2030 | Commission reports to EP + Council under AMLR Art. 88 on necessity/proportionality of: (a) lowering 25% BO threshold; (b) extending high-value goods to garments/accessories; (c) extending Art. 74 threshold disclosures; (d) adjusting Art. 80 cash limit | AMLR |

---

### 6.2 — Three-Instrument Citation Map

| If you need to cite... | Cite this | Why |
|---|---|---|
| **What an obliged entity must do** | **AMLR (Reg 2024/1624)** — verbatim article | Directly-applicable rulebook; no national gloss |
| **How an obliged entity is sanctioned** | **AMLD6 (Dir 2024/1640) — as transposed in [your Member State]** | Enforcement architecture; sanctions live in national law |
| **Direct supervision by EU-level supervisor** | **AMLA Regulation (Reg 2024/1620)** — but only if you are a "selected obliged entity" under Article 13 | Most readers will be outside this scope |
| **RTS / ITS technical standards** | **AMLA draft + Commission delegated/implementing act** | Technical level-2/3 detail under AMLR/AMLD6/AMLA empowering articles |
| **Crypto-asset transfer travel rule** | **TFR (Reg 2023/1113)** — separate instrument; applies only to CASPs | Not part of the 2024 AML package; sits next door |

---

### 6.3 — Primary Sources

| Instrument | EUR-Lex ELI URL | Status |
|---|---|---|
| AMLR (Reg 2024/1624) | https://eur-lex.europa.eu/eli/reg/2024/1624/oj | In force; applicable 10 Jul 2027 |
| AMLD6 (Dir 2024/1640) | https://eur-lex.europa.eu/eli/dir/2024/1640/oj | In force; transposition 10 Jul 2027 (earlier for some BO provisions) |
| AMLA Regulation (Reg 2024/1620) | https://eur-lex.europa.eu/eli/reg/2024/1620/oj | Operational since 1 Jul 2025; direct supervision from 2028 |

---

### 6.4 — Supervisors and Authority Pages

Where RTS/ITS, Q&As, transitional guidance, and enforcement statistics publish:

- **AMLA** (Frankfurt): https://www.amla.europa.eu — RTS/ITS publications, selection methodology, peer review programmes
- **EBA**: https://www.eba.europa.eu — AML transitional guidance (handing over to AMLA), Q&As on AMLR/AMLD6
- **EDPB**: https://www.edpb.europa.eu — GDPR ↔ AML reconciliation guidance (joint with AMLA, in development)
- **Commission AML page**: https://finance.ec.europa.eu/financial-crime/anti-money-laundering-and-countering-financing-terrorism_en — package status + delegated acts pipeline
- **National FIUs**: list maintained on FIU.net and Egmont Group (https://egmontgroup.org)
- **CJEU**: https://curia.europa.eu — for BO register access rulings (Sovim/WM Joined Cases C-37/20 + C-601/20)

---

### 6.5 — Source Verification Status

**All article references in this checklist have been verbatim-verified against the official EUR-Lex OJ XHTML texts of AMLR (Reg 2024/1624), AMLD6 (Dir 2024/1640), and AMLA Regulation (Reg 2024/1620), as downloaded into `.raw/InnBlockchain/EU Compliance/` (amlr.html, amld6.html, amla.html — CONVEX format generated 17–18 June 2024 from EUR-Lex).**

| Article | Status | Note |
|---|---|---|
| AMLR Art. 3 (obliged entities — 17 categories) | ✅ Verbatim | Full enumeration matches |
| AMLR Arts 4, 5, 6, 7 (exemptions + Commission notification) | ✅ Verbatim | Art. 4 = gambling only; Art. 5 = football clubs <€5M; Art. 6 = occasional financial activity; Art. 7 = notification regime |
| AMLR Art. 11 (compliance manager Art. 11(1) / compliance officer Art. 11(2)) | ✅ Verbatim | Split confirmed |
| AMLR Art. 19 (CDD triggers — paragraphs 1–7 mapped) | ✅ Verbatim | Includes Art. 19(1)(c) legal-entity creation; Art. 19(2)/(3) CASP-specific funds transfer; Art. 19(4) cash €3k; Art. 19(5) gambling €2k |
| AMLR Art. 20 (CDD measures incl. 50% / majority interest sanctions detail) | ✅ Verbatim | All 9 measures (a)–(i) confirmed |
| AMLR Art. 52 (25% BO threshold; future 15% via Art. 52(2) delegated act) | ✅ Verbatim | Indirect ownership multiplication rule confirmed |
| AMLR Art. 69 (STR — 5 days, <24h urgent reduction, FIU extension option) | ✅ Verbatim | Compliance officer per Art. 11(2) → Art. 69 STR link confirmed |
| AMLR Art. 77 (5-year retention + 4 record categories + no-redaction rule + reference-instead-of-copy derogation) | ✅ Verbatim | All four record categories confirmed |
| AMLR Art. 80 (€10k cash cap + 10 Oct 2024 notification + deposits exception with FIU-reporting overlay + force majeure) | ✅ Verbatim | All 7 paragraphs confirmed |
| AMLD6 Art. 18 (Single access point to real estate information, 10 Jul 2029 transposition) | ✅ Verbatim | Includes AMLA access for joint analyses |
| AMLD6 Arts 40–42, 50, 52, 56, 67 (supervisor architecture + administrative measures) | ✅ Verbatim | Art. 56 administrative measures (a)–(g) confirmed |
| AMLD6 Art. 55 (Pecuniary sanctions — general €1M floor + credit/FI €10M or 10% turnover + natural person €5M) | ✅ Verbatim | Breach scope explicitly limited to AMLR Chapters II, III, V and Art. 77 |
| AMLD6 Art. 74 (Amendments to Dir 2015/849 BO register access — 10 Jul 2025 transposition) | ✅ Verbatim | Legitimate-interest framework codified in amended AMLD4 Art. 30(5) and Art. 31(4) |
| AMLD6 Art. 78 (Transposition deadlines: 10 Jul 2027 general; 10 Jul 2025 for Art. 74; 10 Jul 2026 for Arts 11–13, 15; 10 Jul 2029 for Art. 18) | ✅ Verbatim | All four deadlines confirmed |
| AMLD6 Art. 79 (Entry into force 20 days after OJ = 9 Jul 2024) | ✅ Verbatim | |
| AMLA Art. 5 (AMLA tasks enumeration) | ✅ Verbatim | |
| AMLA Art. 6 (AMLA powers + binding decisions reference for Art. 22) | ✅ Verbatim | |
| AMLA Art. 12 (≥6 Member States assessment eligibility; 11 obliged-entity categories incl. CASPs at Art. 12(4)(j); 4-tier risk classification) | ✅ Verbatim | **Corrected from prior version** which had ≥6 MS under Art. 13 |
| AMLA Art. 13 (selection from high-risk pool; 40-entity cap with Member State count tie-breaker and third-country transaction ratio second tie-breaker; per-MS fallback) | ✅ Verbatim | **Corrected from prior version** |
| AMLA Art. 22 (sanctions structure: 10% turnover for CDD breaches; €10M for other serious breaches; €500k–€2M basic amount band) | ✅ Verbatim | Executive Board imposes |

> **Source files in this vault:**
> - `.raw/InnBlockchain/EU Compliance/amlr.html` — Regulation (EU) 2024/1624 (90 articles)
> - `.raw/InnBlockchain/EU Compliance/amld6.html` — Directive (EU) 2024/1640 (80 articles)
> - `.raw/InnBlockchain/EU Compliance/amla.html` — Regulation (EU) 2024/1620 (108 articles)
>
> All three were downloaded by the user from EUR-Lex (CONVEX XHTML format) and verified against the OJ ELI URLs cited in [[EU-Compliance-Landscape]] Section "Primary Sources." Re-pull these files before any future v2 of this checklist — Level 2 RTS/ITS pipeline under AMLR, AMLD6, and AMLA is active and may introduce consolidated amended versions.

---

## SECTION 7 — INNBLOCKCHAIN-RELEVANT SCOPING

*Cross-walk of the AMLR/AMLD6/AMLA package to InnBlockchain's two ICPs (FinTech and Crypto Native). Use this to map a prospect's AMLR exposure to the engagement hooks in Section 8.*

---

### 7.1 — Obliged-Entity Status + AMLA Direct Supervision by ICP Segment

| ICP Segment | AMLR Obliged Entity? | AMLA Direct Supervision Likely? | Notes |
|---|---|---|---|
| **FinTech — BankTech** | Yes (credit institution) | **Highly likely** at cross-border scale | Prototypical selected obliged entity; AMLA + national supervisor JST |
| **FinTech — PayTech** | Yes (PI) | Possible at large cross-border scale | PSD3 + AMLR concurrent compliance |
| **FinTech — WalletTech** | Yes (EMI / PI; CASP if crypto wallet) | Possible at large cross-border scale | EMI / PI + CASP overlay |
| **FinTech — WealthTech** | Yes (investment firm) | Possible at large AUM + cross-border | MiFID II + AMLR concurrent |
| **FinTech — ExchangeTech** | Yes (CASP and/or investment firm) | **Highly likely** for cross-border CASPs | Prototypical selected obliged entity in crypto |
| **FinTech — LendTech** | Yes (credit / financial institution) | Unlikely (single-Member-State typical) | National supervisor only |
| **FinTech — InsurTech** | Yes for life + investment-related insurance only; pure P&C OUT | Unlikely | Product-by-product assessment |
| **FinTech — RegTech** | **NO** — SaaS vendor, not Art. 3 obliged entity | N/A | Indirect — tooling supports FI customers' compliance |
| **Crypto — Seg 1 RWA** | Yes (investment firm / securities issuer) | Unlikely unless very large + cross-border | TFR does NOT apply (MiFID-classified) |
| **Crypto — Seg 2 DEX / On-Chain Trading** | Yes (CASP) | **Highly likely** at cross-border scale | Prototypical selected obliged entity in crypto |
| **Crypto — Seg 3 DeFi Lending** | Conditional (only if CASP-classified) | Unlikely | Truly decentralised DeFi: contested out-of-scope claim |
| **Crypto — Seg 4 Non-Custodial / MPC Wallets** | Conditional (only if custody offered) | Unlikely | Pure non-custodial software vendor: out |
| **Crypto — Seg 5 NFT Platforms** | Conditional (fractionalised/fungible NFTs as CASP, or AMP ≥€10k) | Unlikely | Grey zone; monitor AMLA convergence |
| **Crypto — Seg 6 IDO / Token Launch** | Yes (CASP via placing of crypto-assets) | Unlikely | Token issuer obliged via CASP role |
| **Crypto — Seg 7 DAO Infrastructure** | Conditional (only if CASP under MiCA) | Unlikely | Pure software-vendor DAO: out |
| **Crypto — Seg 8 L2 / Chain Infrastructure** | Conditional (only if bridge/settlement is CASP) | Unlikely | Pure protocol-only L2: out |
| **Crypto — Seg 9 Web3 Gaming / GameFi** | Conditional (only if fiat off-ramp / P2P at material value) | Unlikely | Pure in-game economy without fiat ramp: out |
| **Crypto — Seg 10 AI × Crypto** | Conditional (only if agent-as-CASP) | Unlikely | Pure AI tooling without CASP service: out |

> **Legal advisor note:** The "Conditional" rows are the highest-stakes scoping decisions in InnBlockchain's pipeline. They turn on whether the firm meets the MiCA CASP definition — pure software, pure protocol, and pure tooling vendors are typically OUT, but any custody, exchange, or transfer service triggers CASP status, which triggers AMLR obliged-entity status. Get the MiCA scoping right and the AMLR scoping follows automatically. See [[mica-checklist]] Sections 1–2 for the CASP classification gating.

---

### 7.2 — InnBlockchain Engagement Hooks by Section

- **Section 1 scoping**: AMLR Article 3 scoping memo for prospects unsure whether they are obliged entities (particularly Conditional Crypto segments). Single deliverable — fixed-fee. Highest top-of-funnel volume.
- **Section 2.1 governance**: Compliance manager / compliance officer role design, board paper templates, group-wide policy drafting (Article 16) for groups with third-country subsidiaries.
- **Section 2.3 CDD pipeline**: On-chain audit trails for customer identification + verification events; structured event schema designed to satisfy Article 28 CDD RTS once adopted.
- **Section 2.4 EDD for third-country CASP correspondents**: Smart-contract-level counterparty CASP scoring and EDD trigger logic for institutional crypto trading desks.
- **Section 2.5 beneficial ownership**: BO discrepancy reporting integration between obliged-entity systems and national BO registers; ≥25% threshold parameterisation; CIU BO identification helpers under Article 61.
- **Section 2.6 STR**: Tipping-off-safe customer-comms gating; structured STR rationale logs; FIU 5-working-day response automation; the compliance officer's Article 69(6) personal accountability evidence chain.
- **Section 2.9 sanctions**: Sanctions screening pipeline at customer record + every BO record + on every list update; false-positive tuning audit trail for AMLA-coordinated thematic review.
- **Section 4 AMLA prep**: Selected-obliged-entity readiness for tier-1 BankTech and ExchangeTech clients — governance documentation, JST workflow, AMLA reporting templates, Article 22–23 sanctions exposure.
- **Section 5 cross-instrument**: Consolidated GRC tooling spanning AMLR + MiCA + DORA + eIDAS 2.0 for CASPs — single onboarding journey satisfying all four regimes.

---

## SECTION 8 — RELATED CHECKLISTS

- [[mica-checklist]] — CASP authorisation + Title V services (the gating obligation for crypto-side AMLR scoping)
- [[dora-checklist]] — ICT resilience (concurrent obligation for all FE-classified obliged entities; CDD + sanctions systems sit in DORA scope)
- [[mifid2-checklist]] / [[mifid3-checklist]] — Investment firm authorisation (concurrent obligation for WealthTech, RWA tokenization, ExchangeTech)
- [[eidas2-checklist]] — EUDI Wallet acceptance for CDD (mandatory from 31 Dec 2026; AMLR Article 20 identification means)
- [[dlt-pilot-checklist]] — DLT MTF/SS/TSS infrastructure (Seg 1 RWA)

---

## READINESS SCORECARD — SUMMARY

*Count completed checkboxes per section.*

| Section | Topic | Items (approx) | Ready? |
|---|---|---|---|
| 1 | Obliged-entity scope (Art. 3) + carve-outs | 25 | ☐ |
| 2.1 | Internal policies, compliance officer, group-wide | 10 | ☐ |
| 2.2–2.3 | CDD triggers + measures | 14 | ☐ |
| 2.4 | Simplified + enhanced CDD (PEPs, third-country CASPs) | 12 | ☐ |
| 2.5 | Beneficial ownership (≥25%, two tracks) | 7 | ☐ |
| 2.6 | Suspicious transaction reporting + tipping-off | 6 | ☐ |
| 2.7 | Record retention | 5 | ☐ |
| 2.8 | Cash payment limit | 5 | ☐ |
| 2.9 | Sanctions + PEP screening | 6 | ☐ |
| 3 | AMLD6 national sanctions + supervisor + FIU + BO register | 18 | ☐ |
| 4 | AMLA direct supervision (most readers skip 4.2) | 14 | ☐ |
| 5 | Regulation interactions (GDPR / MiCA / DORA / eIDAS) | 14 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** AMLR-application-ready; align with annual compliance review cadence
- **Amber (50–80% complete):** Material gaps exist — close before 10 Jul 2027 application date or before next sectoral supervisory dialogue
- **Red (<50% complete):** Significant preparation required — engage specialist counsel; allocate 6–12 months of compliance programme uplift work; tier-1 candidates for selected-obliged-entity status should engage AMLA-experienced counsel immediately

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for AMLR-bound obliged entities:**

**Pre-Build:** AMLR scoping brief (Article 3 obliged-entity classification + AMLD6 national-supervisor mapping + AMLA selected-obliged-entity exposure assessment) → compliance programme drafting aligned to AMLR Articles 9–16 → CDD framework drafting against forthcoming Article 28 RTS → group-wide policy templates for Article 16 → tipping-off-safe customer-comms playbook for Article 76 compliance

**Build:** On-chain audit trails for CDD events, BO identification events, and STR-relevant transactions → structured event schema designed for Article 28 CDD RTS conformance → smart-contract architecture for sanctions screening at customer + BO record level firing on every list update → BO discrepancy reporting integration between obliged-entity systems and national BO registers → tipping-off prohibition enforcement built into customer-contact technical controls → FIU response automation hitting the 5-working-day / <24-hour Article 69 timelines

**Audit:** Independent smart-contract security audit suitable for inclusion in DORA Article 25 basic testing and AML supervisory dialogue → AMLR Article 9 framework gap analysis against national supervisor expectations → sanctions screening pipeline penetration testing (false-negative tuning, list-update propagation latency, BO record coverage) → selected-obliged-entity AMLA readiness assessment for tier-1 candidates

**Why obliged entities choose us for the AML layer:** AMLR's single rulebook ends Member State divergence on what compliant CDD looks like, but it also raises the floor — every obliged entity needs the same article-precise compliance programme, regardless of which Member State they passport from. We design CDD + BO + STR systems against the AMLR article text and the AMLA RTS pipeline, not against legacy AMLD5-transposed national rules that are about to be displaced. For CASPs, we design the AMLR + MiCA + DORA + eIDAS 2.0 stack as one architecture — because supervisors increasingly read them that way.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. AMLR / AMLD6 / AMLA Regulation implementation is shaped by Level 2 Regulatory Technical Standards and Implementing Technical Standards adopted by AMLA / the Commission, national-supervisor transposition choices (AMLD6 floor only — Member States may go further), ongoing AMLA convergence guidance, and joint EDPB-AMLA work on the GDPR interface. Always engage qualified EU financial-regulatory legal counsel for your specific entity, sector, and Member State.*

*Document version: 1.1 | Last updated: May 2026*
*Changes in v1.1 (verbatim primary-source verification pass): added AMLR Art. 19(1)(c) legal-entity-creation CDD trigger and paragraph-level granularity (Art. 19(2)/(3)/(4)/(5)); refined Art. 20 CDD measures with verbatim sanctions-control detail (50% proprietary rights / majority interest); refined Art. 80 cash limit with verbatim deposit-exception + FIU-reporting overlay and force majeure detail; corrected AMLR exemption articles (Art. 4 = gambling only; Art. 5 = football clubs; Art. 6 = occasional financial activity; Art. 7 = Commission notification regime); corrected AMLA selection mechanism (Art. 12 sets ≥6 Member States assessment eligibility — NOT Art. 13; Art. 13 selects high-risk pool from assessed entities with 40-entity cap + tie-breakers); added AMLD6 Art. 18 (Single access point to real estate information, 10 Jul 2029); added explicit AMLD6 Art. 78 transposition phasing; refined Art. 55 sanctions structure (general €1M floor in Art. 55(2) + credit/FI €10M / 10% in Art. 55(3)(a) + natural person €5M in Art. 55(3)(b); breach scope explicitly limited to AMLR Chapters II, III, V and Art. 77); added Art. 56 administrative measures enumeration; corrected football clubs application date to 10 Jul 2029 (Art. 90, built-in delay — not Member State option); added 10 Jul 2030 Commission review timeline under Art. 88.*
*Regulation references: Regulation (EU) 2024/1624 (AMLR); Directive (EU) 2024/1640 (AMLD6); Regulation (EU) 2024/1620 (AMLA Regulation) — all published in OJ on 19 June 2024.*
