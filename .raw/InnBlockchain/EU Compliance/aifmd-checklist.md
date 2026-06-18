# AIFMD Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for Alternative Investment Fund Managers

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU Alternative Investment Fund Managers Directive (AIFMD) — Directive 2011/61/EU
**Status:** In force since 22 July 2013; amended by AIFMD II (Directive (EU) 2024/927), transposition deadline 16 April 2026
**Document type:** Pre-authorization readiness assessment — to be completed before formal NCA application or as part of an AIF launch programme

---

> **Who this document is for:** Fund managers, legal counsel, CFOs, compliance officers, and fund administrators structuring or managing alternative investment funds (AIFs) in or from the EU — including tokenized real-estate funds, private-credit funds, infrastructure funds, hedge funds, and private-equity vehicles. This checklist mirrors the intake assessment a specialist EU fund-regulatory lawyer would walk you through in a first advisory session. It covers the AIFMD as applicable prior to full AIFMD II national transposition; see the companion AIFMD II checklist for the amendments.

---

> **How to use this checklist:** Work through each section in order. Every checkbox represents a concrete requirement or decision. Items you cannot tick represent gaps that must be closed before committing to a fund structure, marketing assets, or managing investor capital. AIFMD is an authorization regime — operating as an AIFM without authorization is a criminal offence in most EU Member States.

---

## SECTION 1 — DOES AIFMD APPLY TO YOU?

*AIFMD applies to legal or natural persons whose regular business is managing one or more AIFs. The trigger is the combination of fund + manager, not investment strategy alone.*

---

### 1.1 — Is the Vehicle an AIF?

An **Alternative Investment Fund (AIF)** is a collective investment undertaking that:
- Raises capital from a number of investors
- Invests it in accordance with a defined investment policy
- For the benefit of those investors
- Does NOT require authorization as a UCITS under Directive 2009/65/EC

Answer all three questions. If all three are yes, the vehicle is an AIF.

- [ ] **Capital is raised from multiple investors** — two or more investors committing capital (a single-investor fund structured as CIU may still qualify; seek legal opinion)
- [ ] **Defined investment policy exists** — whether written or de facto (investment mandate, fund documentation, offering memorandum stating an investment focus or strategy)
- [ ] **Investment is for the benefit of investors** — investors are passive; they do not exercise day-to-day control over investment decisions

> **Legal advisor note — the operating-business carve-out:** A vehicle is NOT an AIF if it is a genuine operating business — i.e. investors receive a return from the trading profit of a business they own as shareholders, not from the yield of a managed asset pool. This carve-out is narrow. Real-estate vehicles, car-fleet vehicles, equipment-leasing vehicles, and private-credit vehicles where a manager selects and manages assets on behalf of passive investors are AIFs — they do not become operating businesses merely because they employ operational staff, have payroll, or maintain physical assets. ESMA's March 2025 guidelines on qualification of crypto-assets as financial instruments (specifically the CIU qualification test) confirm that a token giving a proportional share of pooled returns and redemption for a share of portfolio value constitutes a unit in a collective investment undertaking. Treat AIFMD as the default for pooled, manager-run, passive-investor vehicles and treat the operating-business carve-out as a position that requires a formal legal opinion — not a self-assessment.

**Reference:** AIFMD Article 4(1)(a) (definition of AIF); ESMA Guidelines on key concepts of the AIFMD (ESMA/2013/611, updated)

---

### 1.2 — Is the AIFM in Scope?

AIFMD applies to the legal or natural person who performs portfolio management or risk management for the AIF. The AIFM can be:

- [ ] **External AIFM** — a separate legal entity appointed to manage the AIF *(the standard structure for institutionally organized funds)*
- [ ] **Internal AIFM** — the AIF itself manages its own portfolio (only available to legal persons — investment companies); the investment company is its own AIFM

> **Legal advisor note:** An internally managed investment company must meet AIFM authorization requirements itself — the fact that there is no separate manager does not exempt the vehicle from AIFMD.

**Reference:** AIFMD Article 4(1)(b) (definition of AIFM); Article 5 (determination of AIFM)

---

### 1.3 — Is the AIFM EU-Based or Non-EU?

- [ ] **EU AIFM** — legal person with registered office in an EU Member State → Sections 2–10 of this checklist apply in full
- [ ] **Non-EU AIFM managing EU AIFs** → Article 37 authorization pathway; full AIFMD obligations apply
- [ ] **Non-EU AIFM marketing non-EU AIFs in the EU** → Article 42 national private placement regime (NPPR), no EU passport; limited obligations
- [ ] **EU AIFM managing non-EU AIFs** → Articles 34–36; AIFMD authorization applies to the EU AIFM regardless of fund domicile

**Reference:** AIFMD Articles 2, 34–42

---

### 1.4 — Scope Exclusions (Article 2(3))

AIFMD does **not** apply to the following. Check any that describe your structure:

- [ ] **Holding companies** — legal persons holding shares in subsidiaries for the purpose of implementing a business strategy through those subsidiaries and providing value to them, provided they do not trade in those shares for profit *(Article 2(3)(a) + recital 10 — note: ESMA guidelines narrow this carve-out considerably)*
- [ ] **Sovereign wealth funds, central banks, national governments, international organizations** managing assets for their own account *(Article 2(3)(b), (d))*
- [ ] **Employee participation schemes or savings schemes** *(Article 2(3)(e))*
- [ ] **Securitization special purpose entities** *(Article 2(3)(g))*
- [ ] **UCITS** — regulated under Directive 2009/65/EC, not AIFMD
- [ ] **Pension funds** subject to national prudential supervision and managed by pension fund managers subject to national supervision *(Article 2(3)(f))*
- [ ] **Insurance-linked vehicles** managed by insurance undertakings *(Article 2(3)(h))*
- [ ] **Family office vehicles** — managing assets of persons related by family without raising capital broadly *(Article 2(3)(b)(i))*
- [ ] **Joint ventures** that are not AIFs *(Article 2(3)(b)(ii))*

> **Legal advisor note:** Holding-company carve-outs are frequently over-relied upon. ESMA guidelines require that the holding company's purpose be carrying on a business through subsidiaries, not merely holding interests in asset vehicles for the benefit of passive investors. A real-estate holding company where investors are passive and returns come from asset yield, not from trading the subsidiaries as a business, will not satisfy the carve-out.

**Reference:** AIFMD Article 2(3) (exclusions); ESMA Guidelines on key concepts of the AIFMD

---

## SECTION 2 — REGISTRATION VS. FULL AUTHORIZATION: THE BELOW-THRESHOLD TEST

*AIFMD creates a two-tier system. Below-threshold AIFMs register with their NCA but are not subject to the full authorization and operating requirements. Above-threshold AIFMs require full authorization.*

---

### 2.1 — Below-Threshold Registration (Article 3)

An AIFM qualifies for registration-only treatment if it manages portfolios of AIFs whose assets under management (AUM) **in total** fall below both thresholds:

| Threshold | AUM limit | Conditions |
|---|---|---|
| **Leveraged AIFs (or with redemption rights within 5 years)** | **< €100,000,000** | Including assets acquired through leverage |
| **Unleveraged, closed-ended AIFs** | **< €500,000,000** | Must be closed-ended AND not exercise redemption rights for at least 5 years from initial investment |

Both thresholds are calculated at the AIFM level (aggregate across all AIFs managed), not per-fund.

- [ ] **AUM calculated correctly** — include all AIFs managed, including sub-threshold vehicles, calculated as total assets (not net assets / NAV — total assets including leverage)
- [ ] **Leverage assessed for each AIF** — determine leverage status for each fund in the portfolio; mixed portfolios where some are leveraged and others are not require careful aggregation
- [ ] **Redemption right assessed** — closed-ended treatment requires no statutory or contractual redemption rights within 5 years; early redemption gates in closed-ended docs may not satisfy this
- [ ] **Registration notification filed with home MS NCA** — below-threshold AIFMs must register; they cannot operate silently
- [ ] **Opt-in to full authorization considered** — sub-threshold AIFMs may opt in to full AIFMD authorization to access the EU marketing passport *(Article 3(4))*

> **Legal advisor note:** Below-threshold registration exempts the AIFM from the operating conditions, depositary, leverage, annual-report, and investor-disclosure requirements of AIFMD. However, below-threshold AIFMs cannot use the EU passport to market AIFs cross-border — they are restricted to national private placement rules in each target Member State. For any AIFM with plans to raise from EU investors across multiple Member States, the passport is almost always worth the full authorization burden.

**Reference:** AIFMD Article 3 (exemptions — registration-only threshold)

---

## SECTION 3 — AUTHORIZATION REQUIREMENTS

*Full AIFMD authorization is granted by the home Member State NCA. It is mandatory before any AIFM activities begin.*

---

### 3.1 — Home Member State

- [ ] **Home Member State identified** — for EU AIFMs, the home MS is the Member State where the AIFM has its registered office *(Article 4(1)(q))*
- [ ] **Application filed with home NCA** — only the home NCA can grant AIFMD authorization; there is no EU-level authorization body
- [ ] **Portfolio of EU AIFs** — if managing AIFs domiciled in multiple EU Member States, the home MS of the AIFM determines the primary regulator; each AIF may additionally be subject to its own domicile's fund rules
- [ ] **NCA selected in jurisdictions assessed** — Luxembourg (CSSF), Ireland (CBI), Germany (BaFin), France (AMF), Netherlands (AFM), Malta (MFSA), and the Baltic NCAs are the active AIFM authorization jurisdictions; assess processing timeline, secondary requirements, and ongoing supervisory culture

---

### 3.2 — Application Content (Article 7)

The authorization application must include:

- [ ] **Information about the persons effectively conducting the business** — minimum two; CVs, identity documents, criminal-record certificates, regulatory-history declarations, conflict-of-interest statements
- [ ] **Information about qualifying shareholders** — any person holding ≥10% of the AIFM's capital or voting rights; evidence of suitability and financial soundness
- [ ] **Programme of operations** — fund strategies to be pursued, organizational structure, staffing plan, technology infrastructure
- [ ] **Information about remuneration policies** — compliance with Article 13 and Annex II requirements
- [ ] **Information about delegation arrangements** — if delegation is planned, full delegation structure mapped against Article 20
- [ ] **Information about each AIF** to be managed — fund rules, instruments of incorporation, depositary identity, AIF domicile
- [ ] **Information about depositaries** — identity of proposed depositary for each AIF, evidence of eligibility
- [ ] **Valuation procedures** — description of the valuation methodology and procedures for each AIF
- [ ] **Liquidity management systems** — description of risk monitoring systems and liquidity management procedures

> **Legal advisor note:** Authorization decisions are typically made within 3 months of receipt of a complete application (or within 3 months of receipt of any supplementary information requested by the NCA). NCAs commonly reject applications as incomplete — engaging an NCA dialogue before formal submission is standard practice in Luxembourg and Ireland. Budget 6–12 months from start of preparation to authorization grant.

**Reference:** AIFMD Article 7 (application for authorization), Article 8 (conditions for granting authorization)

---

### 3.3 — Authorization Conditions (Article 8)

Authorization will be refused if any of the following is not satisfied:

- [ ] **AIFM complies with AIFMD in full** — all required policies, procedures, and organizational requirements in place at authorization
- [ ] **Sufficient initial capital demonstrated** — see Section 4
- [ ] **Management body members pass fit-and-proper assessment** — minimum two persons, good repute, sufficient knowledge and skills *(Article 8(1)(b))*
- [ ] **Qualifying shareholders are suitable** — no person with significant influence who would act contrary to sound and prudent management *(Article 8(1)(c))*
- [ ] **Head office and registered office both in the same Member State** — AIFM cannot be effectively managed from outside its home MS *(Article 8(1)(d))*
- [ ] **Changes to initial authorization notified** — material changes to authorization information must be notified to the home NCA in advance *(Article 10)*

**Reference:** AIFMD Article 8 (conditions for granting authorization)

---

## SECTION 4 — CAPITAL REQUIREMENTS

*AIFMD imposes minimum capital requirements that must be maintained on a continuous basis — not just at authorization.*

---

### 4.1 — Minimum Initial Capital (Article 9)

| AIFM type | Minimum initial capital |
|---|---|
| **External AIFM** (separate legal entity managing AIFs) | **€125,000** |
| **Internal AIFM** (investment company managing itself) | **€300,000** |

- [ ] Capital demonstrated at authorization via audited accounts or equivalent

---

### 4.2 — Additional Own Funds for AUM Above Threshold (Article 9(3))

Where the portfolio of AIFs managed exceeds **€250,000,000**, the AIFM must hold additional own funds equal to:

**0.02% of the amount by which the total AUM exceeds €250,000,000**

- [ ] AUM calculated correctly for additional-own-funds purposes — same methodology as Article 3 threshold *(total assets including leverage across all managed AIFs)*
- [ ] Additional own funds calculated and maintained: 0.02% × (AUM − €250M)
- [ ] **Cap applied:** Total required own funds (initial + additional) **need not exceed €10,000,000** *(Article 9(3) second subparagraph)*
- [ ] **Alternative — professional indemnity insurance (PII):** AIFM may cover all or part of the additional own-funds requirement via PII covering professional liability risks, provided the NCA accepts this *(Article 9(7))*
- [ ] **25% of prior-year fixed overheads** monitored — if at any time the AIFM's initial capital falls below 25% of prior-year fixed overheads, it must immediately notify the NCA and take corrective measures *(Article 9(5))*

---

### 4.3 — Own Funds Form and Investment (Article 9(6))

- [ ] **Own funds not invested in risky assets** — own funds must be invested in liquid assets or assets readily convertible to cash in the short term and not include speculative positions

**Reference:** AIFMD Article 9 (initial capital and own funds)

---

## SECTION 5 — OPERATING CONDITIONS

*The substantive operating conditions are the heart of AIFMD compliance. They apply continuously and are supervised by the home NCA.*

---

### 5.1 — General Principles (Article 12)

- [ ] **Act in the best interests of the AIFs and their investors** — fundamental conduct standard
- [ ] **Act with honesty, due skill, care, and diligence** in conducting activities
- [ ] **Resources and procedures** adequate for proper performance of activities
- [ ] **Take all reasonable steps to avoid conflicts of interest** and, where unavoidable, manage and disclose them
- [ ] **Comply with all regulatory requirements applicable to the conduct of business** to promote best interests of the AIFs and investors
- [ ] **Treat investors fairly** — no investor group receives preferential treatment that materially prejudices other investors *(Article 12(1)(f) + recital 28)*

**Reference:** AIFMD Article 12 (general principles)

---

### 5.2 — Remuneration Policy (Article 13 + Annex II)

- [ ] **Remuneration policy established** — covers fixed and variable remuneration for identified staff (senior management, risk-takers, control functions, and any employee with total remuneration placing them in the same bracket as senior management)
- [ ] **Policy consistent with sound risk management** — does not encourage risk-taking inconsistent with the AIF's risk profile, rules, or instruments of incorporation
- [ ] **Variable component limitations** — variable remuneration is not paid through instruments or methods that facilitate circumvention of AIFMD requirements
- [ ] **Pay-out process arrangements** — at least 25% of variable remuneration deferred for at least 3–5 years (specific percentages depend on AIF type and size); deferral aligned with AIF lifecycle
- [ ] **Annual disclosure in annual report** — total remuneration paid to AIFM staff in the financial year, split into fixed and variable; number of beneficiaries; any carried interest paid by the AIF *(Article 22(2)(e))*
- [ ] **Proportionality principle considered** — small AIFMs may be exempt from certain deferral and pay-out requirements *(Annex II para 1 — proportionality)*

**Reference:** AIFMD Article 13; Annex II (remuneration); EBA/ESMA Joint Guidelines on sound remuneration policies under AIFMD

---

### 5.3 — Conflicts of Interest (Article 14)

- [ ] **Conflicts of interest policy documented** — identifies conflicts between: AIFM and AIF; AIFM and investors; AIF and investors; investors inter se; AIFM staff / shareholders and AIFs or investors
- [ ] **Organizational and administrative measures** established to prevent or manage conflicts
- [ ] **Conflicts disclosed to investors** where structural or procedural measures are insufficient to prevent material prejudice
- [ ] **Senior-management oversight** of conflicts framework

**Reference:** AIFMD Article 14 (conflicts of interest); Commission Delegated Regulation (EU) No 231/2013, Articles 30–37

---

### 5.4 — Risk Management (Article 15)

- [ ] **Risk management function separated from portfolio management** — functional and hierarchical separation; may be combined only where proportionate, with adequate safeguards against conflicts *(Article 15(1))*
- [ ] **Risk management systems implemented** — qualitatively and quantitatively appropriate to the nature, scale, and complexity of each AIF managed
- [ ] **Risks identified, measured, managed, and monitored on an ongoing basis** for each AIF
- [ ] **Aggregate risk and contribution to overall risk profile assessed at least quarterly** (or more frequently if AIF strategy requires)
- [ ] **Specific risk management requirements per strategy:**
  - [ ] **Leverage AIFs** — leverage exposure calculated and monitored under both commitment and gross methods *(Articles 15(4), 25)*
  - [ ] **Liquidity-sensitive AIFs** — liquidity risk assessed in relation to redemption policy *(Article 16)*
  - [ ] **Interest-rate, credit, counterparty, operational, and currency risks** assessed for all AIFs using derivatives or holding leveraged positions

**Reference:** AIFMD Article 15 (risk management); Commission Delegated Regulation (EU) No 231/2013, Articles 38–45

---

### 5.5 — Liquidity Management (Article 16)

- [ ] **Liquidity management system implemented** for each open-ended AIF — ensures liquidity profile of investments aligns with redemption policy and obligations
- [ ] **Liquidity stress tests** — regular stress tests conducted under normal and exceptional liquidity conditions; results used to manage liquidity risk
- [ ] **Alignment between investment strategy, liquidity profile, and redemption policy** — investors cannot be locked into an investment that the AIF cannot realize in time to meet redemptions
- [ ] **Side pockets** — if used, documented in fund rules; investor consent or separate share class required; disclosure to all investors
- [ ] **Redemption gates, notice periods, and suspension mechanisms** — disclosed in offering documents; implemented in line with IOSCO recommendations on open-ended fund liquidity management *(See AIFMD II amendments — Annex V LMT requirements from 16 April 2026 implementation)*

**Reference:** AIFMD Article 16 (liquidity management); Commission Delegated Regulation (EU) No 231/2013, Articles 46–49

---

### 5.6 — Valuation (Article 19)

- [ ] **Robust and transparent valuation procedures** established for each AIF — assets must be valued at least annually for closed-ended AIFs; more frequently for open-ended (at every subscription/redemption at minimum)
- [ ] **Valuer independent of portfolio management function** — either an external valuer or internal function with adequate safeguards
- [ ] **External valuer** — if used, appointed, registered or incorporated in the EU; subject to mandatory professional registration; not liable to conflict with AIFM *(Article 19(4))*
- [ ] **AIFM liability for valuation** — AIFM remains liable to the AIF and its investors for correct valuation even where an external valuer is used *(Article 19(5))*
- [ ] **Fair value methodology** consistent with IFRS or US GAAP depending on AIF domicile; specific valuation methods for each asset class documented
- [ ] **NAV per unit / share calculation** — documented process; verified and signed off for each publication

**Reference:** AIFMD Article 19 (valuation); Commission Delegated Regulation (EU) No 231/2013, Articles 67–74

---

### 5.7 — Organizational Requirements (Article 18)

- [ ] **Appropriate human and technical resources** available to manage the AIFs properly
- [ ] **Senior management in place** — minimum two persons effectively conducting the business; must be EU-resident or sufficiently present *(Article 8(1)(b))*
- [ ] **Compliance function** — adequate, staffed, independent
- [ ] **Risk management function** — separate from portfolio management *(Article 15(1))*
- [ ] **Internal audit function** — independent; periodic review of internal control system
- [ ] **Record-keeping** — all services, activities, transactions; records kept for at least 5 years *(Article 18 + Commission Delegated Regulation 231/2013 Article 66)*
- [ ] **Business continuity plan** — documented; ensures continuity of critical functions

**Reference:** AIFMD Article 18 (organizational requirements); Commission Delegated Regulation (EU) No 231/2013, Articles 57–66

---

## SECTION 6 — DELEGATION

*AIFMD permits AIFMs to delegate functions to third parties but prohibits delegation to the point where the AIFM becomes a letterbox entity.*

---

### 6.1 — Delegation Conditions (Article 20)

- [ ] **Objective reason for delegation documented** — delegation must be justified (operational efficiency, specialist expertise, risk mitigation); home NCA is entitled to request the justification
- [ ] **Delegatee sufficiently resourced** — human and technical resources adequate to perform the function
- [ ] **Delegatee authorized or registered** for asset management or otherwise competent for the delegated function
- [ ] **Supervision of delegatee** — AIFM retains full oversight; ability to monitor performance, recall delegation, and give instructions
- [ ] **Effective and continuous oversight** — AIFM must be able to monitor the delegatee on an ongoing basis
- [ ] **Home NCA notified before delegation takes effect** *(Article 20(1)(c))*

---

### 6.2 — Prohibition of Letterbox Entity (Article 20(3))

An AIFM cannot delegate to the extent that it becomes a letterbox entity. Letterbox assessment must confirm:

- [ ] **AIFM retains sufficient expertise and resources** to supervise the delegated functions effectively
- [ ] **AIFM retains authority to take decisions in areas of senior management** and perform senior management functions *(including setting investment strategy and approving key investment decisions at portfolio level)*
- [ ] **Delegation to third-country entities** — additional requirement: cooperation agreement between home MS NCA and the supervisory authority of the delegatee *(Article 20(2)(b))*
- [ ] **Sub-delegation** — only permitted with prior written consent of the AIFM; sub-delegatee must meet all delegatee conditions; AIFM remains responsible

> **Legal advisor note — AIFMD II tightening from April 2026:** AIFMD II tightens the delegation framework. AIFMs delegating portfolio management to non-EU entities must notify their home NCA with specific information. NCAs must report to ESMA annually on delegation arrangements. ESMA uses this data to monitor letterbox-entity risks across the EU. The effective result is heightened supervisory scrutiny of delegation-heavy fund management structures, particularly where the AIFM is a thin EU wrapper for non-EU investment management. If your structure relies on delegation to a non-EU investment manager for core portfolio management, the letterbox analysis has become more important — and more scrutinized.

**Reference:** AIFMD Article 20 (delegation); Commission Delegated Regulation (EU) No 231/2013, Articles 75–82

---

## SECTION 7 — DEPOSITARY

*Every AIF must have a single depositary. This is a mandatory structural requirement — there are no exemptions for size, strategy, or investor type.*

---

### 7.1 — Depositary Eligibility (Article 21)

For each AIF managed, the AIFM must ensure a depositary is appointed that meets the following:

- [ ] **Established in the home Member State of the AIF** *(standard rule; AIFMD II introduces limited cross-border depositary flexibility — see AIFMD II checklist)*
- [ ] **Eligible depositary type:**
  - [ ] For **EU AIFs**: Credit institution with registered office in the EU; investment firm with MiFID II authorization including asset safekeeping; other institution subject to prudential regulation and with minimum own funds of €730,000 (for closed-ended non-leveraged AIFs only) *(Article 21(3))*
  - [ ] For **non-EU AIFs marketed in the EU**: depositary subject to equivalent regulation in the third country where the AIF is established *(Article 21(5))*
- [ ] **Written depositary agreement** in place covering all Article 21 obligations

---

### 7.2 — Depositary Functions (Article 21(7)–(9))

The depositary must perform three distinct functions:

#### Safe-keeping function:
- [ ] **Financial instruments** held in custody (in a segregated account); loss triggers strict liability regardless of fault *(Article 21(12))*
- [ ] **Other assets** (real estate, physical assets, infrastructure, commodities): title verification, record-keeping, and confirming AIFM's ownership *(Article 21(8)(b))*

#### Cash monitoring:
- [ ] **All cash flows monitored** — depositary must receive notice of all subscriptions and ensure subscription payments go into cash accounts in AIFM's or AIF's name, or depositary's name on AIF's behalf
- [ ] **Segregated accounts** — each AIF's cash segregated; no co-mingling with AIFM assets

#### Oversight function:
- [ ] **Subscription/redemption procedures monitored** — confirm consistent with fund rules
- [ ] **NAV calculation oversight** — depositary verifies process
- [ ] **Instructions from AIFM executed in accordance with applicable law and fund rules**
- [ ] **Distribution calculations reviewed**

---

### 7.3 — Depositary Liability (Article 21(12))

- [ ] **Strict liability for loss of financial instruments held in custody** — depositary liable to the AIF and its investors even if loss occurs via a sub-custodian; discharged only by proving the loss resulted from an external event beyond its reasonable control whose consequences were unavoidable despite all reasonable efforts
- [ ] **Negligence standard for other losses** — obligation breaches other than loss of held financial instruments (e.g. oversight failures): liability for negligent or intentional failure
- [ ] **Liability transfer to investor** — depositary may contractually transfer its strict liability to a sub-custodian if informed investors consent to this; limited to professional investors *(Article 21(13))*
- [ ] **Depositary conflict of interest policy** — depositaries must avoid acting in ways that conflict with their depositary obligations *(Article 21(15))*

**Reference:** AIFMD Article 21 (depositary); Commission Delegated Regulation (EU) No 231/2013, Articles 83–102

---

## SECTION 8 — TRANSPARENCY — ANNUAL REPORT

*Every AIF must produce an annual report — even where it is not marketed to the public.*

---

### 8.1 — Annual Report Content (Article 22)

The annual report must contain at minimum:

- [ ] **Balance sheet or statement of assets and liabilities**
- [ ] **Income and expenditure account** for the financial year
- [ ] **Report on activities** for the financial year — narrative summary of investment activities, key developments, market commentary
- [ ] **Any material changes in the information disclosed to investors** under Article 23 during the financial year
- [ ] **Total remuneration paid by the AIFM** to its staff in the financial year — fixed plus variable; number of beneficiaries; any carried interest paid by the AIF *(Article 22(2)(e))*
- [ ] **Senior management remuneration in aggregate and individually** for the highest earners
- [ ] **Statement of changes in assets** for open-ended AIFs
- [ ] **NAV per unit/share history** (where applicable)

---

### 8.2 — Annual Report Timing and Filing (Article 22(1))

- [ ] **Annual report made available within 6 months of financial year-end** to investors on request; submitted to the home NCA *(Article 22(1))*
- [ ] **Annual report published or communicated** in accordance with AIF rules and national law requirements of the home MS
- [ ] **Audited accounts** — annual financial statements must be audited by a person authorized to audit accounts under applicable national law *(Article 22(3))*

**Reference:** AIFMD Article 22 (annual report)

---

## SECTION 9 — INVESTOR DISCLOSURE

*Investors must receive comprehensive pre-investment disclosure and regular updates. This is a mandatory, continuous obligation.*

---

### 9.1 — Pre-Investment Disclosure (Article 23(1))

Before investing, each investor must receive:

- [ ] **Description of investment strategy** and objectives of the AIF; types of assets; investment techniques; any applicable leverage; risk profile; AIF domicile and legal structure
- [ ] **Description of procedures for changing investment strategy or policy** — under what circumstances and with what investor notification
- [ ] **Regulatory status** — whether any national regulatory control on investment applies
- [ ] **Identity of the AIFM, depositary, external valuer, and auditor** and any delegation arrangements
- [ ] **Liquidity risk management description** including redemption rights, redemption gates, side pockets, notice periods, suspension rights; how redemption rights may be suspended or restricted
- [ ] **Description of fees, charges, and expenses** borne by investors and by the AIF directly
- [ ] **Description of how fair treatment of investors is ensured** and whether any investor receives preferential treatment and in what form *(side letters)*
- [ ] **Leverage description** — leverage used; types; sources; associated risks and restrictions; maximum leverage
- [ ] **Depositary identity and liability description** — investor's rights against the depositary; arrangements for discharging depositary liability *(Article 23(1)(j))*

---

### 9.2 — Periodic Disclosure (Article 23(5))

On an ongoing basis, the AIFM must inform investors of:

- [ ] **Current risk profile of the AIF** and risk management systems in place — at least annually
- [ ] **Percentage of AIF assets subject to special arrangements** arising from illiquidity — at least annually
- [ ] **New arrangements for liquidity management** — promptly on implementation
- [ ] **Current leverage level** — periodically; maximum leverage permitted *(Article 23(5)(c))*

---

### 9.3 — Side Letters (Article 23(1)(h))

Where any investor receives preferential treatment:

- [ ] **All investors informed** of the existence of preferential treatment and the type of treatment offered — disclosure does not require naming the preferential investor but must describe the category of arrangement and the nature of the benefit
- [ ] **Side letter terms consistent** with AIF rules and legal requirements — AIFM cannot agree side letter terms that prejudice other investors' rights

**Reference:** AIFMD Article 23 (disclosure to investors)

---

## SECTION 10 — REGULATORY REPORTING

*AIFMs must report periodically to their home NCA. Reporting scope and frequency depend on AUM and leverage.*

---

### 10.1 — Content of Reports (Article 24)

For each AIF managed, the AIFM must report to its home NCA:

- [ ] **Principal markets and instruments traded** — investment strategy breakdown
- [ ] **Main categories of assets** in which the AIF invests
- [ ] **Performance data** — risk, liquidity, return metrics
- [ ] **Leverage information** — leverage amounts under both commitment and gross methods *(for leveraged AIFs)*
- [ ] **Changes in principal exposures and concentration risks** from prior reporting period
- [ ] **Stress test results** and liquidity profile *(for certain fund types)*
- [ ] **Details of any special arrangements** for redemption restriction

---

### 10.2 — Reporting Frequency (Article 24(1))

| AIFM / AIF category | Reporting frequency |
|---|---|
| **AIFMs with AUM ≤ €100M (leveraged) or ≤ €500M (unleveraged)** | **Annually** |
| **AIFMs managing leveraged AIFs with AUM between €100M–€1B** | **Semi-annually** |
| **AIFMs managing AIFs with AUM > €1B**, or **managing leveraged AIFs with total AUM > €100M** | **Quarterly** |
| **Non-EU AIFs marketed in the EU by EU AIFM** | Same schedule as above, per-AIF |

- [ ] Reporting frequency matched to current AUM levels; updated when thresholds crossed
- [ ] ESMA-specified reporting template used (Implementing Regulation adopted under Article 24(6))
- [ ] Data quality controls in place before submission

**Reference:** AIFMD Article 24 (reporting obligations to competent authorities); Commission Implementing Regulation (EU) No 447/2013; ESMA reporting guidelines

---

## SECTION 11 — LEVERAGE

*AIFMD distinguishes between the leverage used by an AIF (a fund-level characteristic) and the AIFM's obligations to manage and report that leverage.*

---

### 11.1 — Leverage Calculation (Articles 4(1)(v), 25)

- [ ] **Leverage method 1 — Commitment method** — all positions converted to equivalent positions in the underlying assets; netting and hedging permitted under defined rules
- [ ] **Leverage method 2 — Gross method** — sum of absolute values of all positions; no netting

Both methods must be calculated and disclosed. The higher of the two determines disclosure and reporting thresholds.

- [ ] **Leverage limits set by AIFM** — must be documented in fund rules and disclosed to investors *(Article 23(1)(g))* and reported to home NCA *(Article 24(4))*
- [ ] **AIFM demonstrates leverage consistent with AIF risk profile** and investment strategy at all times *(Article 25(1))*

---

### 11.2 — Leverage Reporting and NCA Powers (Article 25(3))

- [ ] **Leverage reported to home NCA** in regular Article 24 reports — leverage amounts, types, sources, any collateral arrangements
- [ ] **NCA power to impose leverage limits** — home NCA may impose limits on leverage where it considers the AIF's leverage creates systemic risk *(Article 25(3))*
- [ ] **ESMA notification** — home NCA notifies ESMA and other concerned NCAs when it imposes leverage limits; ESMA may issue an opinion

**Reference:** AIFMD Article 25 (use of leverage); Commission Delegated Regulation (EU) No 231/2013, Articles 6–10 (leverage calculation methods)

---

## SECTION 12 — PRIVATE EQUITY AND CORPORATE ACQUISITION RULES

*Where an AIF acquires shares in non-listed companies or issuers, special notification and disclosure rules apply.*

---

### 12.1 — Notification of Major Holdings (Article 26)

When an AIF acquires, disposes, or holds voting rights in a non-listed company that cross the thresholds of **10%, 20%, 30%, 50%, or 75%** of voting rights:

- [ ] **Notification to the company, the issuer, and the home NCA** within 10 working days of threshold crossing
- [ ] **Content of notification:** identity of AIFM; identity of AIF; date of crossing; level of voting rights held; conditions relating to acquisition

---

### 12.2 — Disclosure on Acquisition of Control (Article 27)

When an AIF acquires **control** of a non-listed company (> 50% of voting rights):

- [ ] **Notification to the non-listed company's management, shareholders, and home NCA** — within 10 working days
- [ ] **AIFM must make available to the company's employees (via their representatives)** the information about the acquisition and consequences *(Article 28)*
- [ ] **Content of post-acquisition disclosure:** identity of AIFM / AIF; policy on prevention of and management of conflicts of interest; planned significant changes to employment and working conditions

---

### 12.3 — Asset Stripping Prevention (Article 30)

For **24 months following acquisition of control** of a non-listed company, the AIFM must:

- [ ] **Not cause or vote for** any distribution, capital reduction, share redemption, or acquisition of own shares that has the effect of reducing the company's net assets below share capital + non-distributable reserves *(Article 30(1))*
- [ ] **Ensure the company does not** make any such distribution, capital reduction, or acquisition
- [ ] These restrictions apply equally to listed companies *(Article 30(2))* and are designed to prevent leveraged-buyout asset stripping

**Reference:** AIFMD Articles 26–30 (notification and transparency for non-listed companies and issuers)

---

## SECTION 13 — MARKETING — EU PASSPORT

*EU AIFMs managing EU AIFs benefit from a marketing passport allowing them to market to professional investors in all EU Member States on a simple notification basis.*

---

### 13.1 — Home Member State Marketing (Article 31)

- [ ] **AIFM notifies home NCA** before beginning marketing of each EU AIF in the home MS
- [ ] **Notification package:** fund rules, identification of AIF and AIFM, details of any depositary, description of information available to investors
- [ ] **NCA has 20 working days** to assess completeness and notify refusal (if notification is complete, AIFM may begin marketing immediately)

---

### 13.2 — Cross-Border EU Passport (Article 32)

For each EU AIF the AIFM intends to market to professional investors in another EU Member State:

- [ ] **Notification to home NCA** — complete notification file submitted per Article 32(2):
  - Letter of intent identifying the host MS(es)
  - AIF prospectus and any offering documents
  - Identification of AIF, its home MS, and home NCA
  - Identification of depositary
  - Description of the AIF and investment strategy
  - Any additional information required by the host MS for securities offered to professional investors
- [ ] **Home NCA transmits to host NCA** within 20 working days of receiving complete notification *(Article 32(3))*
- [ ] **Marketing may begin immediately upon transmission** by the home NCA — no host-NCA approval required *(Article 32(3) final sentence)*
- [ ] **Changes to notification information** — home NCA notified at least 1 month before any planned change *(Article 32(7))*

---

### 13.3 — Marketing to Retail Investors (Article 43)

AIFMD itself governs marketing only to **professional investors** (MiFID II Annex II). Marketing AIFs to retail investors is subject to:

- [ ] **National rules of each target Member State** — Article 43 allows MS to permit retail marketing subject to stricter conditions
- [ ] **ELTIF structure** (European Long-Term Investment Fund — Regulation (EU) 2015/760, as amended by ELTIF 2.0 Regulation (EU) 2023/606) — the primary EU-harmonized route for semi-retail AIF marketing across the EU. For tokenized real-estate and infrastructure AIFs targeting a wider investor base, assess ELTIF qualification
- [ ] **EuVECA / EuSEF** — for qualifying venture capital and social entrepreneurship funds, separate passporting regimes under Reg (EU) No 345/2013 and No 346/2013

**Reference:** AIFMD Articles 31–33 (EU marketing passport); Article 43 (retail marketing)

---

## SECTION 14 — THIRD-COUNTRY PROVISIONS

*Non-EU AIFMs and EU AIFMs managing non-EU AIFs face additional requirements. The full third-country passport for non-EU AIFMs remains suspended pending ESMA opinions on third-country equivalence.*

---

### 14.1 — EU AIFM Managing Non-EU AIFs (Article 34)

An EU AIFM may manage non-EU AIFs without marketing them in the EU, subject to:

- [ ] **Compliance with all AIFMD provisions** applicable to the AIFM itself
- [ ] **Cooperation arrangements** between home MS NCA and supervisory authority of the non-EU AIF domicile *(Article 34(1)(b))*
- [ ] **Non-EU AIF country not on FATF high-risk list** *(Article 34(1)(c))*

---

### 14.2 — National Private Placement Regime (NPPR) for Non-EU AIFs (Article 36)

EU AIFM marketing non-EU AIFs in the EU under national private placement (no EU passport):

- [ ] **Compliance with Articles 22, 23, and 24** — annual report, investor disclosure, NCA reporting obligations apply
- [ ] **Cooperation arrangements in place** — between home MS NCA and non-EU AIF domicile regulator
- [ ] **Non-EU AIF country not on FATF high-risk list**
- [ ] **Additional national conditions satisfied** — each Member State may impose additional requirements for NPPR; check specific rules of each target MS

---

### 14.3 — Non-EU AIFM in the EU (Article 42 NPPR)

Non-EU AIFMs marketing AIFs in the EU using national private placement (prior to any third-country passport activation):

- [ ] **Compliance with Articles 22, 23, and 24** for each AIF marketed in the EU *(Article 42(1)(a))*
- [ ] **Cooperation arrangements** between non-EU AIFM's country NCA and each EU host MS NCA *(Article 42(1)(b))*
- [ ] **Non-EU AIFM country not on FATF high-risk list** *(Article 42(1)(c))*
- [ ] **Host Member State rules satisfied** — each target MS has its own NPPR requirements
- [ ] **Annual notification to each host MS NCA** of NPPR activities

> **Legal advisor note:** The EU third-country passport for non-EU AIFMs has never been activated. ESMA has issued opinions on equivalence for several jurisdictions but the Commission has not yet triggered the passport. This means non-EU AIFMs must use NPPR in every EU Member State separately — no single-application EU-wide marketing right exists. The AIFMD II changes to NPPR (harmonized conditions, more uniform reporting) are intended to reduce the fragmentation. Check current NPPR status in each target Member State with local counsel.

**Reference:** AIFMD Articles 34–42 (third-country provisions)

---

## SECTION 15 — TIMELINE & KEY DATES

| Date | Milestone | Reference |
|---|---|---|
| **22 July 2011** | AIFMD published in Official Journal (OJ L 174) | — |
| **22 July 2013** | AIFMD fully applicable in all Member States (2-year transposition period) | Article 66 |
| **22 July 2014** | Passport extension to EU AIFs managed by non-EU AIFMs and non-EU AIFs managed by EU AIFMs *(operational from 22 July 2014)* | Articles 35, 36 |
| **2014 onwards** | Annual ESMA third-country opinions — no third-country passport yet activated | Article 67 |
| **1 March 2023** | ELTIF 2.0 Regulation (EU) 2023/606 entered into force — expanded retail marketing window for AIFs structured as ELTIFs | ELTIF 2.0 Art. 45 |
| **15 April 2024** | AIFMD II (Directive (EU) 2024/927) published in Official Journal (OJ L 927) | — |
| **15 April 2024** | AIFMD II entered into force (20th day post OJ) | — |
| **16 April 2026** | AIFMD II transposition deadline — Member States must incorporate into national law | AIFMD II Article 3 |
| **16 October 2026** | Latest date for Member States to begin applying AIFMD II national measures (6-month extension option for certain provisions) | AIFMD II Article 3 |
| **16 April 2028** | Existing AIFMs managing loan-originating AIFs have 18 months from transposition to bring existing AIFs into compliance with new LOF rules | AIFMD II transitional provisions |

- [ ] **Authorization currency** — confirm authorization remains valid and no NCA conditions outstanding
- [ ] **AIFMD II transition assessed** — identify which AIFMD II changes require procedural or structural amendments; see companion AIFMD II checklist
- [ ] **ESMA and EBA publications monitored** — AIFMD implementing measures, Q&As, and guidelines evolve continuously

---

## READINESS SCORECARD — SUMMARY

| Section | Topic | Items (approx) | Ready? |
|---|---|---|---|
| 1 | AIFMD scope — AIF and AIFM classification | 15 | ☐ |
| 2 | Below-threshold registration vs. full authorization | 5 | ☐ |
| 3 | Authorization requirements and dossier | 12 | ☐ |
| 4 | Capital — initial + additional own funds | 6 | ☐ |
| 5 | Operating conditions (remuneration, conflicts, risk, liquidity, valuation, organizational) | 30 | ☐ |
| 6 | Delegation — conditions and letterbox | 9 | ☐ |
| 7 | Depositary — eligibility, functions, liability | 14 | ☐ |
| 8 | Annual report — content and timing | 8 | ☐ |
| 9 | Investor disclosure — pre-investment and periodic | 12 | ☐ |
| 10 | Regulatory reporting to NCA | 6 | ☐ |
| 11 | Leverage — calculation, limits, NCA powers | 6 | ☐ |
| 12 | Private equity / corporate acquisition rules | 8 | ☐ |
| 13 | Marketing — EU passport and retail | 8 | ☐ |
| 14 | Third-country provisions — NPPR | 10 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** AIFMD-authorization-ready; engage NCA for pre-application dialogue
- **Amber (50–80% complete):** Material structural or documentation gaps — close before fund launch
- **Red (<50% complete):** Significant preparation required — engage specialist fund-regulatory counsel and fund administrator; allow 9–18 months to authorization for a new AIFM

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for AIFMD-regulated fund managers handling tokenized AIFs:**

**Pre-Build:** AIFM scoping brief (AIF vs. operating business; below-threshold vs. full authorization; ELTIF/RAIF wrapper analysis) → token architecture mapped against AIFMD Article 23 investor-disclosure requirements → on-chain AIF structure design (unit tokens as MiFID Annex I C(3) instruments) → depositary interface specification

**Build:** ERC-3643/ERC-1400 security token contracts with on-chain investor registry and transfer restrictions → NAV oracle design with Article 19 valuation audit trail → on-chain subscription/redemption workflow compatible with Article 21 depositary cash-monitoring requirements → multi-sig governance for investment committee approval of portfolio decisions → structured event schema for Article 24 AIFM reporting feeds → DORA-compliant ICT architecture for the AIFM's digital operations

**Audit:** Smart contract security audit mapped to AIFMD Article 19 (valuation integrity) and Article 21 (depositary safekeeping of financial instruments in custody) → regulatory audit readiness assessment → exit-strategy and orderly wind-down analysis for tokenized fund structures

**Why fund managers choose us:** A tokenized AIF has two regulatory layers — the fund-law layer (AIFMD) and the token-law layer (MiFID II, Prospectus Regulation, DLT Pilot Regime). We design the smart contract architecture so that both layers are satisfied simultaneously, not sequentially. The depositary can settle, the NCA can audit, and the investor can redeem — without rebuilding the token after authorization.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. AIFMD implementation and the AIFMD II amendments are shaped by national transposition measures, ESMA Level 3 guidelines, and ongoing NCA supervisory practice which varies materially by Member State. Always engage qualified EU fund-regulatory legal counsel for your specific fund structure, AIFM domicile, and target investor base.*

*Document version: 1.0 | Last updated: June 2026*
*Regulation reference: Directive 2011/61/EU of the European Parliament and of the Council of 8 June 2011 on Alternative Investment Fund Managers (AIFMD), as published in OJ L 174, 1 July 2011; as amended by Directive (EU) 2024/927 (AIFMD II), OJ L 927, 15 April 2024.*
