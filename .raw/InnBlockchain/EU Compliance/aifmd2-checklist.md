# AIFMD II Amendment Readiness Checklist
## What Existing AIFMs and Fund Structures Must Change — and When

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** AIFMD II — Directive (EU) 2024/927 amending Directive 2011/61/EU (AIFMD) and Directive 2009/65/EC (UCITS)
**Status:** Published OJ L 927, 15 April 2024. **Transposition deadline: 16 April 2026.** Member States may apply national measures from 16 October 2026 (6-month extension).
**Document type:** Amendment impact assessment — identifies changes from AIFMD II that require existing AIFMs to update structures, policies, and disclosures; companion to the base AIFMD checklist

---

> **Who this document is for:** Legal counsel, compliance officers, fund managers, and fund administrators at authorized AIFMs assessing the impact of AIFMD II on their existing authorization, fund documentation, operating model, and marketing arrangements. This checklist also covers the new loan origination fund (LOF) framework for AIFMs launching or converting to loan-originating strategies.

---

> **How to use this checklist:** AIFMD II is a directive amending AIFMD — it does not take direct effect. You are affected through your home Member State's national transposition law. The transposition deadline was 16 April 2026. As of June 2026, most EU Member States are either in final transposition or have enacted implementing laws. Confirm the effective date of the national law in your home MS before treating any item as binding. Work through each section to identify gaps versus your current authorization and fund documentation.

---

## SECTION 1 — STATUS: HAS YOUR HOME MEMBER STATE TRANSPOSED AIFMD II?

*AIFMD II imposes obligations through national law, not directly. The effective date varies by Member State.*

---

### 1.1 — Transposition Status Check

- [ ] **Home MS national implementation law identified and reviewed** — Article 3 of AIFMD II required transposition by 16 April 2026. Confirm the implementing statute for your jurisdiction:
  - **Luxembourg:** Law amending the 2013 Law on AIFMs — review CSSF communiqués for entry-into-force date
  - **Ireland:** AIFMD (Amendment) Regulations — confirm SI number and effective date with CBI
  - **Germany:** KAGB amendment — confirm BaFin publication and effective date
  - **France:** AMF regulation update — confirm AMF instruction date
  - **Netherlands:** Wft amendment — confirm AFM implementation date
  - Other jurisdictions: confirm with local counsel
- [ ] **Gap analysis completed** against home MS national law — the checklist items below describe what AIFMD II requires; your national law may impose additional requirements
- [ ] **NCA supervisory communications reviewed** — CSSF / CBI / BaFin / AMF / AFM may have issued guidance, FAQs, or transition timelines specific to their jurisdiction

---

## SECTION 2 — LOAN ORIGINATING AIFs (LOFs) — NEW FRAMEWORK

*AIFMD II introduces the first EU-harmonized framework for AIFs that originate loans. If your AIF lends money to borrowers (including via tokenized debt, private credit, real-estate construction finance, or SME lending), you must assess whether you now fall within the new LOF framework.*

---

### 2.1 — Do You Manage a Loan Originating AIF?

A **loan originating AIF (LOF)** is an AIF whose investment strategy is primarily focused on originating loans — i.e. the AIF or its AIFM directly extends credit to borrowers (as distinct from secondary acquisition of loans originated by third-party lenders).

- [ ] **Primary strategy assessment** — does the AIF's investment strategy primarily consist of originating loans? "Primarily" means loan origination is the core return-driver, not just one of multiple strategies
- [ ] **Distinguish origination from secondary acquisition** — buying loans in the secondary market is not loan origination for LOF purposes; it is an investment strategy under standard AIFMD rules
- [ ] **Tokenized private credit structures assessed** — a token representing a claim on a loan pool where the AIFM originates the underlying loans is a LOF structure if origination is the primary strategy

> **Practical note:** Many real-estate AIFs and private-credit AIFs provide construction loans, bridge loans, or mezzanine debt as part of their strategy. Whether that activity constitutes "primary" loan origination for LOF purposes — versus incidental lending alongside equity investment — is a fact-specific judgment. Obtain a formal legal opinion before committing to a LOF structure.

---

### 2.2 — LOF Structural Requirements (New Article 15a AIFMD as amended by AIFMD II)

If your AIF is a LOF, the following apply:

- [ ] **LOF must be closed-ended** — an open-ended LOF is only permitted if the AIFM can demonstrate to the NCA that the liquidity management system is compatible with open-ended redemption. In practice, closed-ended is the default; open-ended LOF requires NCA approval and specific liquidity risk justification
- [ ] **Retention requirement for open-ended LOFs** — if the NCA permits open-ended structure: the AIFM must retain at least **5% of the notional value** of each originated loan on the AIF's balance sheet (no "originate to distribute" — see Section 2.3) unless the open-ended exception applies
- [ ] **Fund rules and investor disclosure** updated to reflect LOF status, closed-ended structure, and loan origination strategy
- [ ] **Offering documents** identify the AIF as a loan originating fund; describe the credit strategy, underwriting process, and risk management framework

---

### 2.3 — Prohibition on "Originate to Distribute" (New Article 15b(2))

- [ ] **Prohibition confirmed and policy documented** — an AIFM managing a LOF must NOT originate a loan with the intention of immediately selling or transferring that loan to a third party on the secondary market
- [ ] **Retention monitoring system** — the AIFM must be able to demonstrate at any time that it is not systematically originating to distribute; document retention rates per loan origination cohort
- [ ] **Loan-by-loan records** — records of each originated loan, origination date, retention period, any subsequent transfer, and the business reason for any transfer

---

### 2.4 — Concentration Limits (New Article 15b(1))

- [ ] **20% concentration limit per borrower** — the total value of loans originated to a single borrower must not exceed 20% of the LOF's capital (commitments, not NAV, unless the national transposition specifies otherwise)
- [ ] **Group aggregation** — loans to companies that are part of the same group must be aggregated for the 20% limit
- [ ] **Concentration monitoring** — ongoing monitoring of borrower exposure; breach triggers mandatory remediation plan

---

### 2.5 — Prohibited Borrowers (New Article 15b(1))

- [ ] **Prohibition on loans to financial-sector entities** — a LOF may NOT originate loans to the following entities (prohibition designed to prevent circular funding structures and shadow banking risks):
  - [ ] Credit institutions
  - [ ] Investment firms
  - [ ] Alternative investment fund managers (AIFMs)
  - [ ] Management companies (UCITS ManCos)
  - [ ] AIFs
  - [ ] UCITS
  - [ ] Insurance undertakings
  - [ ] Reinsurance undertakings
  - [ ] Pension funds (IORPs)
  - [ ] Financial holding companies and mixed financial holding companies
- [ ] **Exception documented where applicable** — loans to holding companies of industrial or commercial groups for group-level working capital financing may be permissible; obtain legal opinion on any borderline case

---

### 2.6 — Borrower Due Diligence and Credit Risk Assessment

- [ ] **Credit underwriting standards documented** — written credit assessment policy covering borrower solvency, creditworthiness, collateral evaluation, loan-to-value monitoring
- [ ] **Borrower solvency assessed before origination** — mandatory assessment of the borrower's ability to repay; documented for each originated loan
- [ ] **Ongoing loan monitoring** — periodic review of borrower creditworthiness during the life of the loan; covenant monitoring; remediation procedures for non-performing loans

---

### 2.7 — Investor Disclosure for LOFs

- [ ] **Investor disclosure updated** under Article 23 to include:
  - Description of loan origination strategy, target borrower profiles, and sectors
  - Credit risk management framework
  - Concentration limits and any applicable exceptions
  - Originate-to-distribute prohibition and retention policy
  - Non-performing loan management approach
  - Closed-ended structure justification (or open-ended exception basis)

**Reference:** AIFMD II Articles 1(7)–1(8) (inserting Articles 15a–15d into AIFMD); national transposition measures

---

## SECTION 3 — DELEGATION FRAMEWORK — NEW REQUIREMENTS

*AIFMD II tightens the delegation monitoring regime without fundamentally changing the Article 20 conditions. The primary change is transparency towards NCAs and ESMA.*

---

### 3.1 — Enhanced Delegation Notification to NCA

- [ ] **Notification package updated** — when delegating portfolio management or risk management to an entity in a third country, the notification to the home NCA must now include:
  - [ ] Name and domicile of the delegatee
  - [ ] Description of functions delegated
  - [ ] Confirmation of cooperation arrangement between home MS NCA and the third-country supervisor
  - [ ] Resources retained by the AIFM for oversight
  - [ ] Letterbox-entity analysis documenting the AIFM's retained supervisory capacity
- [ ] **Existing delegation arrangements reviewed** against enhanced requirements — update notification file with home NCA if existing notifications pre-date AIFMD II transposition and do not include the new content

---

### 3.2 — NCA Annual Reporting to ESMA on Delegation

Your home NCA will report annually to ESMA on delegation arrangements across all authorized AIFMs. This does not create direct AIFM obligations but increases supervisory attention on:

- [ ] **Delegation-heavy structures** where an AIFM delegates most or all portfolio management to a non-EU entity — heightened letterbox scrutiny expected
- [ ] **Substance review** — NCAs are expected to assess whether AIFM staff levels and resources are consistent with genuine oversight of delegated functions; plan for potential NCA information requests on staffing, governance, and oversight procedures

---

### 3.3 — Letterbox Entity Test — Ongoing Assessment

The letterbox-entity test from Article 20(3) AIFMD is unchanged in substance but subject to more active NCA monitoring:

- [ ] **Annual internal letterbox assessment documented** — board or management-body sign-off confirming the AIFM retains substantive control and oversight of delegated functions
- [ ] **Escalation procedure** for situations where delegatee's capacity degrades or delegation arrangements change materially

**Reference:** AIFMD II Article 1(12) (amending Article 20 AIFMD); ESMA annual delegation oversight reports

---

## SECTION 4 — CROSS-BORDER DEPOSITARY — NEW FLEXIBILITY

*AIFMD II introduces a limited facility for AIFMs to appoint a depositary established in a different EU Member State from the AIF. This is an opt-in; the default rule (depositary in home MS of AIF) continues.*

---

### 4.1 — Cross-Border Depositary Conditions (New Article 21a)

A Member State may permit a UCITS or AIF to appoint a depositary established in another EU Member State where:

- [ ] **No appropriate depositary available in the AIF's home MS** — the home MS NCA has assessed that there is no qualified depositary available in the jurisdiction
- [ ] **Depositary is established in the EU** — must be an EU-authorized depositary
- [ ] **Home MS NCA approval obtained** — the cross-border depositary appointment requires advance approval from the home MS NCA
- [ ] **Agreement between NCAs** — the AIF home NCA must agree arrangements for supervisory cooperation with the depositary home NCA

> **Practical note:** This provision is most relevant for smaller EU jurisdictions (e.g. Baltic states, Slovenia, Malta) where the local depositary market is thin and specialized depositaries for certain AIF types do not exist. For Luxembourg and Ireland domiciled AIFs, the rule is unlikely to be used. Check whether your home MS has elected to permit cross-border depositary arrangements under its national transposition law.

**Reference:** AIFMD II Article 1(16) (inserting Article 21a into AIFMD)

---

## SECTION 5 — LIQUIDITY MANAGEMENT TOOLS (LMTs) — NEW MANDATORY FRAMEWORK

*AIFMD II introduces a mandatory, harmonized framework of Liquidity Management Tools (LMTs) for open-ended AIFs. This is one of the most significant operational changes for open-ended fund managers.*

---

### 5.1 — Which Funds Are Affected?

- [ ] **Open-ended AIF** managed by the AIFM — if any of your AIFs accepts periodic subscriptions and allows periodic redemptions, it is open-ended and must comply with the LMT framework
- [ ] **Closed-ended AIFs** — not subject to mandatory LMT activation (closed-ended structure is itself a form of liquidity management)
- [ ] **Money market funds (MMFs)** — subject to separate MMF Regulation (EU) 2017/1131; AIFMD LMT framework does not apply

---

### 5.2 — Mandatory LMT Activation (New Annex V AIFMD as amended by AIFMD II)

For each open-ended AIF:

- [ ] **At least two LMTs from Annex V activated and always available** — the AIFM must select and document at least two of the following tools from the new Annex V, which must be available for use at all times (not just in crisis situations):

| LMT | Type | Description |
|---|---|---|
| **Redemption gates** | Quantity limit | Restricts redemptions in any period to a percentage of AIF NAV |
| **Notice periods for redemptions** | Time delay | Requires investors to give advance notice before redeeming |
| **Redemption fees** | Cost-based | Fee charged on redemptions to protect remaining investors from transaction costs |
| **Anti-dilution levies (ADL)** | Cost-based | Adjusts redemption price to reflect transaction costs of portfolio liquidation |
| **Swing pricing** | Price adjustment | Adjusts NAV per unit to reflect subscription/redemption transaction costs |
| **Redemption in kind** | Asset delivery | Satisfies redemptions by delivering portfolio assets rather than cash |
| **Side pockets** | Segregation | Segregates illiquid assets from the main portfolio; illiquid portion not eligible for redemption |
| **Suspension of subscriptions and redemptions** | Full halt | Temporary suspension of all subscriptions and/or redemptions |

- [ ] **Selection documented and justified** — board-level decision on which two (or more) LMTs to activate; documented rationale aligned with AIF's investment strategy and investor base
- [ ] **Suspension always available as backstop** — regardless of which two primary LMTs are selected, the power to suspend subscriptions and redemptions must always be retained as an emergency backstop
- [ ] **NCA notified of LMT selection** — home NCA informed of the LMTs selected for each open-ended AIF
- [ ] **Fund rules updated** — LMT activation rights and conditions must be described in fund rules/instruments of incorporation and the offering memorandum

---

### 5.3 — Investor Disclosure on LMTs

- [ ] **Offering document (Article 23 disclosure) updated** to describe:
  - The LMTs selected and available for each AIF
  - The conditions and thresholds under which each LMT would be activated
  - The process for investor notification when an LMT is activated
  - Investor rights and limitations during LMT activation (e.g. minimum redemption amounts, notice periods, fees)
- [ ] **Investor notification procedure** documented — investors must be notified when an LMT is activated (except in emergency suspension scenarios where market integrity requires immediate action without prior notice)

---

### 5.4 — Activation and Deactivation Procedure

- [ ] **Governance procedure for LMT activation** — who has authority to activate each LMT; documentation requirements; escalation from portfolio management to senior management / board
- [ ] **NCA notification on activation** — where an LMT other than redemption fees or anti-dilution levies is activated, the home NCA must be notified without undue delay
- [ ] **ESMA coordination for cross-border funds** — ESMA may issue guidelines on supervisory convergence regarding LMT activation conditions

**Reference:** AIFMD II Article 1(11) (amending Article 16 AIFMD and adding Annex V); ESMA Guidelines on LMTs for UCITs and open-ended AIFs (expected 2025–2026)

---

## SECTION 6 — REPORTING ENHANCEMENTS

*AIFMD II introduces harmonization of AIFM regulatory reporting with the goal of creating a more consistent data framework across the EU.*

---

### 6.1 — Enhanced Article 24 Reporting Requirements

- [ ] **ESMA-driven data standards** — ESMA is mandated to develop harmonized data templates for Article 24 reports; the current ad-hoc national formats will be replaced. Monitor ESMA AIFMD consultation papers for the new reporting format timeline
- [ ] **LOF-specific reporting** — AIFMs managing loan originating AIFs must report to their NCA:
  - Total portfolio of originated loans
  - Breakdown by borrower sector, geography, maturity
  - Non-performing loans (NPL) ratio
  - Retention rates confirming compliance with originate-to-distribute prohibition
- [ ] **Cross-border delegation reporting** — home NCA reports to ESMA; no direct AIFM obligation beyond current notification requirements, but data quality in delegation notifications is now a supervisory focus

---

### 6.2 — Data Management Readiness

- [ ] **Reporting infrastructure assessed** for compatibility with harmonized templates when published — avoid bespoke reporting solutions that cannot be reconfigured
- [ ] **Fund administrator briefed** on AIFMD II reporting timeline — most reporting is handled by fund administrators; confirm they are tracking the new template format

**Reference:** AIFMD II Article 1(13) (amending Article 24 AIFMD)

---

## SECTION 7 — NATIONAL PRIVATE PLACEMENT REGIME (NPPR) — HARMONIZATION

*AIFMD II introduces more standardized conditions for the national private placement regime used by non-EU AIFMs and EU AIFMs marketing non-EU AIFs in the EU.*

---

### 7.1 — Harmonized NPPR Conditions

- [ ] **NPPR conditions reviewed in each target Member State** — AIFMD II mandates certain minimum standards for national private placement regimes, but Member States retain flexibility on additional conditions. Confirm the current NPPR rules in each target MS following national transposition of AIFMD II
- [ ] **Annual reporting in NPPR jurisdictions** — non-EU AIFMs and EU AIFMs using NPPR must file annual reports with each host MS NCA on the NPPR activities in that MS
- [ ] **Cooperation arrangements current** — the cooperation agreement between home/relevant NCA and third-country supervisor must be in place and current; ESMA maintains a list of acceptable cooperation arrangements *(see ESMA website)*

**Reference:** AIFMD II Article 1(20) (amending Article 42 AIFMD on NPPR conditions)

---

## SECTION 8 — UCITS MANAGEMENT COMPANY CHANGES

*AIFMD II also amends UCITS Directive 2009/65/EC. Key changes affecting UCITS management companies operating under both AIFMD and UCITS authorizations.*

---

### 8.1 — Super ManCo Changes

ManCos authorized to manage both UCITS (under 2009/65/EC) and AIFs (under AIFMD) — so-called "super ManCos" — are subject to both directive amendments.

- [ ] **Super ManCo authorization reviewed** — confirm that existing combined authorization remains valid under national transposition of both AIFMD II and the UCITS amendments in AIFMD II
- [ ] **Delegation rules apply symmetrically** — AIFMD II's enhanced delegation rules apply to the AIF management activities; UCITS delegation rules (as amended by AIFMD II) apply to the UCITS management activities
- [ ] **LMT framework** applies to open-ended AIFs managed by the super ManCo; UCITS LMT amendments apply to UCITS managed by the super ManCo *(see UCITS checklist for UCITS-specific LMT requirements)*

---

## SECTION 9 — EXISTING FUND DOCUMENTATION — WHAT MUST BE UPDATED

*This section summarizes documentation changes required for existing authorized AIFMs and their funds.*

---

### 9.1 — AIFM-Level Document Updates

- [ ] **Remuneration policy** — confirm current policy complies with any national implementation changes to Annex II requirements
- [ ] **Delegation notifications** — update home NCA delegation notifications with enhanced content if previously insufficient
- [ ] **Risk management policy** — update to incorporate LMT activation framework for open-ended AIFs
- [ ] **Conflicts of interest policy** — update to reflect any LOF-specific conflicts (origination vs. investor interests)

---

### 9.2 — AIF-Level Document Updates

For each AIF managed:

- [ ] **Fund rules / constitutive documents** — update to include:
  - [ ] LMT regime for open-ended AIFs (which LMTs are available, activation conditions)
  - [ ] LOF framework (if applicable): loan origination strategy, prohibited borrowers, concentration limits, closed-ended structure
  - [ ] Cross-border depositary arrangements (if applicable)
- [ ] **Prospectus / offering memorandum** — update with:
  - [ ] LMT description and investor rights during LMT activation
  - [ ] LOF strategy, risk factors, retention policy (if applicable)
- [ ] **Article 23 disclosure document** — update investor disclosure with:
  - [ ] LMT description *(Article 23(1)(i) updated)*
  - [ ] LOF-specific risk disclosures (if applicable)
  - [ ] Any changes to delegation arrangements

---

## SECTION 10 — TRANSITION TIMELINE AND COMPLIANCE DEADLINES

| Date | Milestone | What AIFMs Must Do |
|---|---|---|
| **15 April 2024** | AIFMD II published in OJ | Begin gap analysis; map AIFMD II changes against current structure |
| **16 April 2026** | **Transposition deadline** | Home MS law implementing AIFMD II must exist; confirm your home MS status |
| **16 October 2026** | Member States' latest date to begin applying national measures | Treat this as the outer deadline — work back 6 months to identify documentation update milestones |
| **16 April 2028** | Latest deadline for LOF compliance on existing funds | Existing AIFMs with funds that constitute LOFs under the new definition have **24 months** from the national application date to bring those funds into compliance with the LOF framework |
| **Ongoing** | ESMA LMT guidelines | ESMA expected to issue guidelines on LMT calibration and supervisory convergence — monitor and incorporate |
| **Ongoing** | ESMA harmonized reporting templates | New Article 24 data templates to be developed by ESMA — monitor consultation and adoption timeline |

- [ ] **Home MS national transposition timeline confirmed** with home NCA or local counsel
- [ ] **Internal AIFMD II project plan created** with owners, milestones, and sign-off dates for each documentation update
- [ ] **Fund administrator briefed** and engaged on required fund-rule amendments and disclosure updates
- [ ] **Legal counsel appointed** for national-law analysis and NCA liaison

---

## READINESS SCORECARD — SUMMARY

| Section | Topic | Items (approx) | Ready? |
|---|---|---|---|
| 1 | Home MS transposition status confirmed | 3 | ☐ |
| 2 | LOF framework — structural and operational requirements | 18 | ☐ |
| 3 | Delegation — enhanced notification and letterbox monitoring | 8 | ☐ |
| 4 | Cross-border depositary — eligibility and NCA approval | 4 | ☐ |
| 5 | LMTs — mandatory activation, disclosure, governance | 14 | ☐ |
| 6 | Reporting enhancements — LOF and harmonized templates | 4 | ☐ |
| 7 | NPPR harmonization — conditions and annual reporting | 3 | ☐ |
| 8 | Super ManCo — combined authorization review | 3 | ☐ |
| 9 | Documentation updates — AIFM-level and AIF-level | 12 | ☐ |
| 10 | Transition timeline awareness and project plan | 5 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** AIFMD II transition is substantively addressed; monitor ESMA guidelines on LMTs
- **Amber (50–80% complete):** Material documentation or structural gaps — close before home MS application date
- **Red (<50% complete):** AIFMD II transition has not been properly scoped — engage fund-regulatory counsel and fund administrator immediately; the outer application deadline of October 2026 is approaching

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for AIFMD II transition projects involving tokenized funds:**

**AIFMD II Gap Analysis:** Mapping current fund structure against AIFMD II requirements → identification of LOF status for tokenized private-credit or real-estate loan vehicles → LMT framework design for open-ended tokenized AIFs

**LMT Implementation for On-Chain AIFs:** Smart contract architecture for on-chain LMT enforcement — programmable redemption gates (cap on daily/weekly redemption in token units), notice-period enforcement via time-locked redemption flows, swing-pricing oracle integration, side-pocket token class issuance → AIFMD II Annex V compliant design

**LOF Tokenization Architecture:** On-chain loan origination event logging with Art 15b retention audit trail → borrower registry with prohibited-borrower exclusion logic → concentration-limit monitoring by borrower address/entity → ESMA-ready reporting data schema for LOF regulatory submissions

**Delegation Monitoring Infrastructure:** Governance event trail for board-level oversight of delegated portfolio management decisions → immutable audit log satisfying enhanced NCA oversight requirements

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. AIFMD II implementation is shaped by national transposition measures which vary by Member State, ESMA guidelines on LMTs and reporting, and ongoing NCA supervisory practice. The transposition deadline of 16 April 2026 has passed — confirm current national-law status in your home Member State with local fund-regulatory counsel before taking any compliance action.*

*Document version: 1.0 | Last updated: June 2026*
*Regulation reference: Directive (EU) 2024/927 of the European Parliament and of the Council of 13 March 2024 amending Directives 2011/61/EU and 2009/65/EC as regards delegation arrangements, liquidity risk management, supervisory reporting, provision of depositary and custody services, and loan origination by alternative investment funds, as published in OJ L 927, 15 April 2024.*
