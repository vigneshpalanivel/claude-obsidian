# MiCA Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for New Crypto Businesses Entering the EU Market

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU Markets in Crypto-Assets Regulation (MiCA) — Regulation (EU) 2023/1114
**Status:** Fully in force as of 30 December 2024
**Document type:** Pre-engagement readiness assessment — to be completed before formal NCA application

---

> **Who this document is for:** Founders, entrepreneurs, and executive teams approaching legal counsel for the first time to determine whether their planned crypto-asset business can legally operate in the European Union under MiCA. This checklist mirrors the intake assessment a specialist EU crypto-regulatory lawyer would walk you through in a first advisory session.

---

> **How to use this checklist:** Work through each section in order. Every item marked with a checkbox (☐) represents a concrete requirement or decision you must resolve. Items you cannot check off represent gaps that must be closed before you file an NCA application. Your legal advisor will use your responses to this checklist to scope the engagement, estimate timeline, and identify deal-breakers early.

---

## SECTION 1 — DO YOU NEED MICA AUTHORIZATION?

*This is the first question any legal advisor will ask. Not every crypto business needs MiCA authorization — but almost every crypto business touching the EU does.*

---

### 1.1 — Territorial Scope: Does MiCA Apply to You?

Answer each question. If any answer is **Yes**, MiCA likely applies.

- [ ] Are you offering crypto-assets to the public within the EU, or seeking admission to trading on an EU platform?
- [ ] Are you providing crypto-asset services (custody, exchange, brokerage, advisory, portfolio management) to EU-resident clients?
- [ ] Are you issuing a stablecoin (fiat-referenced or asset-referenced) that will circulate within the EU?
- [ ] Is your business entity registered or incorporated in an EU/EEA Member State?
- [ ] Are you marketing or actively soliciting EU-resident users, even if your entity is based outside the EU?

> **Legal advisor note:** MiCA applies to conduct within the EU, regardless of where the entity is incorporated. If you are targeting EU users from a non-EU jurisdiction, you are likely caught. Reverse solicitation is a narrow, fact-specific defense — do not assume it applies to you without formal legal advice.

**Reference:** MiCA Article 2 (Scope), Article 4 (Definitions)

---

### 1.2 — Exclusion Check: Is Your Product Outside MiCA's Scope?

MiCA does **not** apply to the following. Check any that describe your product:

- [ ] Your token qualifies as a financial instrument under MiFID II (equity token, security token, derivative) → Regulated under MiFID II, not MiCA
- [ ] Your product is a deposit or structured deposit under the banking directive → Regulated under CRD/CRR
- [ ] Your product is an insurance contract or pension product → Regulated under Solvency II / IORP II
- [ ] Your token is a CBDC (Central Bank Digital Currency) issued by a central bank
- [ ] Your service is provided exclusively by the ECB or national central banks
- [ ] Your crypto-asset is a securitization position under the EU Securitisation Regulation
- [ ] Your token is fully decentralized with no identifiable issuer or service provider (extremely narrow — consult counsel)

> **Legal advisor note:** The MiFID II vs. MiCA boundary is the single most common classification issue. If your token represents equity, debt, or derivative exposure, MiFID II applies. If it references the value of an asset or basket but does not confer ownership of the underlying, MiCA likely applies. This classification decision must be documented formally — it is the foundation of your entire compliance architecture.

**Reference:** MiCA Article 2(2)–(4) (Exclusions), Article 43 (Classification of crypto-assets)

---

## SECTION 2 — WHAT TYPE OF BUSINESS ARE YOU?

*MiCA creates four distinct regulatory pathways. Your legal advisor will classify your business into one (or more) of these categories. Each carries different authorization requirements, capital thresholds, and ongoing obligations.*

---

### 2.1 — Business Classification Decision Tree

Identify which category (or categories) apply to your planned business:

#### ☐ CATEGORY A — Issuer of Other Crypto-Assets (MiCA Title II)
*Utility tokens, governance tokens, access tokens, or any crypto-asset that is NOT an ART or EMT*

- You are creating and offering a token to the public
- The token does not reference the value of any fiat currency or asset basket
- The token provides access to a service, governance rights, or utility within your ecosystem

**Requirements summary:**
- White paper must be drafted, notified to NCA, and published — but prior NCA approval is NOT required
- White paper must meet all Article 6 content requirements
- Marketing must be consistent with white paper disclosures
- Issuer liability for white paper accuracy applies

---

#### ☐ CATEGORY B — Issuer of Asset-Referenced Tokens / ART (MiCA Title III)
*Stablecoins backed by a basket of assets, commodities, or multiple currencies*

- Your token references the value of multiple official currencies, commodities, or other assets
- Examples: basket stablecoins, gold-backed tokens, commodity index tokens

**Requirements summary:**
- **Full NCA authorization required** before issuance
- White paper must be approved by NCA
- Reserve of assets must be established, segregated, and managed
- Minimum own funds: the higher of €350,000 / 2% of average reserve assets / 25% of prior-year fixed overheads
- Redemption rights must be offered to token holders at all times
- Ongoing reporting to NCA required

---

#### ☐ CATEGORY C — Issuer of E-Money Tokens / EMT (MiCA Title IV)
*Stablecoins pegged 1:1 to a single official fiat currency*

- Your token references the value of exactly one official currency (EUR, USD, GBP, etc.)
- The token is designed to maintain a stable value relative to that currency
- Examples: EUR-pegged stablecoins, USD-pegged payment tokens

**Requirements summary:**
- Must be authorized as a **credit institution** (bank) or **electronic money institution (EMI)** — standard MiCA CASP authorization alone is NOT sufficient
- 1:1 fiat reserve backing required at all times
- Token holders must have a redemption right at par value at any time
- **No interest or yield may accrue on the token itself**
- At least 30% of reserves must be held as bank deposits (60% for "significant" EMTs)

---

#### ☐ CATEGORY D — Crypto-Asset Service Provider / CASP (MiCA Title V)
*Operating a crypto business that provides services relating to crypto-assets*

Check each service you intend to provide:

- [ ] **Custody and administration** of crypto-assets on behalf of clients
- [ ] **Operation of a trading platform** for crypto-assets
- [ ] **Exchange of crypto-assets for funds** (fiat on/off ramp)
- [ ] **Exchange of crypto-assets for other crypto-assets**
- [ ] **Execution of orders** for crypto-assets on behalf of clients
- [ ] **Placing of crypto-assets** (distribution/underwriting)
- [ ] **Reception and transmission of orders** for crypto-assets
- [ ] **Providing advice** on crypto-assets
- [ ] **Providing portfolio management** of crypto-assets
- [ ] **Providing transfer services** for crypto-assets on behalf of clients

**Requirements summary:**
- **Full NCA authorization required** before providing any services
- Authorization grants EU-wide passporting rights across all 27 Member States
- Minimum capital requirements based on service class (see Section 4)
- Ongoing organizational, prudential, and conduct-of-business requirements

---

> **Critical note — Multiple categories may apply:** If you are both issuing a token (Category A, B, or C) AND operating services around it (Category D), you may need to satisfy requirements for multiple categories simultaneously. Your legal advisor will map this.

**Reference:** MiCA Titles II–V

---

## SECTION 3 — ENTITY STRUCTURE & EU PRESENCE

*MiCA requires a physical, legal presence in the EU. There are no exceptions for remote or offshore-only operations.*

---

### 3.1 — Legal Entity Requirements

- [ ] **EU legal entity established:** Your business must be a legal person incorporated in an EU/EEA Member State (e.g., GmbH in Germany, SAS in France, BV in Netherlands, OÜ in Estonia)
- [ ] **Registered office in the EU:** The entity's registered office must be in a Member State
- [ ] **Effective place of management in the EU:** At least part of the business must be genuinely directed from within the EU — brass-plate entities will not pass NCA scrutiny
- [ ] **Home Member State selected:** You have identified the specific EU Member State where you will apply for authorization (this becomes your "home NCA")

> **Legal advisor note:** Choice of home Member State matters. Different NCAs have different levels of experience, processing speed, and secondary requirements. France (AMF), Germany (BaFin), Netherlands (AFM), Ireland (CBI), and Lithuania (Bank of Lithuania) all have active crypto-regulatory teams. Your legal advisor will help you evaluate the optimal jurisdiction based on your business model, target market, and operational needs.

---

### 3.2 — Governance & Management ("Fit and Proper")

MiCA requires that all persons who effectively direct the business pass a "fit and proper" assessment by the NCA.

- [ ] **At least two natural persons** effectively directing the business (dual management requirement for CASPs)
- [ ] **Management body members identified** — each must demonstrate:
  - [ ] Sufficient knowledge, skills, and experience to manage the business
  - [ ] Good repute — no criminal convictions for financial crimes, fraud, money laundering, or terrorist financing
  - [ ] Sufficient time commitment to effectively perform their duties
  - [ ] No conflicts of interest that would impair independent judgment
- [ ] **Major shareholders / qualifying holders identified** (≥10% of capital or voting rights):
  - [ ] Each must demonstrate suitability to the NCA
  - [ ] No criminal history in financial crime, fraud, or AML offenses
  - [ ] Financial soundness demonstrated
- [ ] **Board composition** allows for independent oversight and challenge
- [ ] **CVs and background documentation** prepared for all directors, officers, and qualifying shareholders — NCA will verify these independently

**Reference:** MiCA Articles 34, 59, 62, 68

---

## SECTION 4 — FINANCIAL REQUIREMENTS & CAPITAL

*MiCA imposes minimum capital ("own funds") requirements. These are non-negotiable — you must demonstrate you have the capital before authorization is granted.*

---

### 4.1 — CASP Minimum Capital Requirements (Title V)

| Service Class | Services Covered | Minimum Own Funds |
|---|---|---|
| **Class 1** | Advisory services, reception/transmission of orders, placing of crypto-assets | **€50,000** |
| **Class 2** | Crypto-to-fiat exchange, crypto-to-crypto exchange, order execution, operation of a trading platform | **€125,000** |
| **Class 3** | Custody and administration of crypto-assets on behalf of clients | **€150,000** |

**Additional requirement:** Own funds must be at least the **higher** of:
- The Class minimum above, OR
- **25% of the previous year's fixed overheads** (or projected first-year overheads for new businesses)

- [ ] Capital requirement calculated based on planned services
- [ ] Capital available and demonstrable via audited accounts or bank statements
- [ ] Source of funds documented and legitimate (NCA will scrutinize this)
- [ ] Plan for maintaining ongoing capital adequacy (own funds must be maintained continuously, not just at authorization)

---

### 4.2 — ART Issuer Capital Requirements (Title III)

For businesses issuing asset-referenced tokens:

- [ ] Own funds calculated as the highest of:
  - **€350,000** (fixed minimum)
  - **2% of average reserve assets** (increases to 3% for "significant" ARTs)
  - **25% of prior-year fixed overheads**
- [ ] Reserve of assets established and fully funded before issuance
- [ ] Reserve assets segregated from issuer's own assets (insolvency-remote)
- [ ] Reserve invested only in eligible instruments (sovereign debt, money-market funds, bank deposits)
- [ ] No crypto-assets held in the reserve
- [ ] Custodian(s) appointed for reserve management
- [ ] **Stress testing program planned** — MiCA requires ART issuers to conduct regular stress tests covering severe financial scenarios (e.g. interest rate shocks) and non-financial scenarios (e.g. operational risk). The NCA may require you to hold 20–40% additional own funds based on stress test results — plan your capital buffer accordingly before filing *(MiCA Article 35(5))*
- [ ] **No-interest / no-yield feature confirmed** — ARTs must not offer interest, yield, staking rewards, or any return to token holders based on the length of time they hold the token. If your product design includes any yield or rewards mechanism, it must be removed before issuance — rebuilding this post-authorization is a full product redesign *(MiCA Article 40)*

---

### 4.3 — EMT Issuer Capital Requirements (Title IV)

For businesses issuing e-money tokens:

- [ ] Authorized as a credit institution or electronic money institution (prerequisite)
- [ ] 1:1 fiat reserve maintained at all times
- [ ] At least **30% of reserve** held as bank deposits (60% for "significant" EMTs)
- [ ] Remaining reserve invested in secure, low-risk, liquid financial instruments
- [ ] No interest paid to token holders
- [ ] Reserve assets legally segregated from issuer's balance sheet

**Reference:** MiCA Articles 35, 36, 37 (ART reserves), Articles 48, 49 (EMT reserves), Articles 67–68 (CASP own funds)

---

## SECTION 5 — WHITE PAPER REQUIREMENTS

*Every crypto-asset offered to the public in the EU requires a MiCA-compliant white paper. This is not your marketing white paper — it is a regulated disclosure document with legal liability attached.*

---

### 5.1 — White Paper Obligation

- [ ] **White paper exemption assessed first** — before drafting, confirm whether your offer qualifies for a full exemption from the white paper obligation:
  - Offer to fewer than **150 persons per Member State**
  - Total consideration below **€1,000,000** over any 12-month period
  - Offer addressed **solely to qualified investors** where tokens can only be held by them
  - Tokens distributed **for free** (airdrops, mining/validation rewards)

  If any exemption applies, a white paper is not required — but EU consumer protection law still applies to all communications. Confirm with legal counsel before assuming exemption *(MiCA Articles 4–5)*

- [ ] White paper drafted in compliance with MiCA Article 6 (general crypto-assets), Article 19 (ARTs), or Article 51 (EMTs)
- [ ] White paper is fair, clear, and not misleading
- [ ] White paper is written in a language accepted by the home NCA (plus any host Member State languages where the token will be offered)
- [ ] White paper published on the issuer's website and made freely available
- [ ] White paper notified to the NCA before the offer begins

---

### 5.2 — White Paper Content Checklist

Verify your white paper includes all mandatory sections:

- [ ] **Issuer information:** Legal name, registered address, LEI (Legal Entity Identifier), contact details, identity of directors and key persons
- [ ] **Project description:** Purpose of the project, planned use of funds raised, development roadmap and milestones
- [ ] **Token description:** Rights and obligations attached to the token, total supply, issuance mechanism, any minting/burning mechanics, lock-up or vesting schedules
- [ ] **Technology description:** Underlying DLT/blockchain technology, consensus mechanism, interoperability, technical security standards
- [ ] **Risk disclosure:** Comprehensive disclosure of all material risks — market, technology, regulatory, liquidity, counterparty, custody, operational, cybersecurity risks
- [ ] **Governance:** Governance arrangements, decision-making processes, voting mechanisms (if any), upgrade/change procedures
- [ ] **Offer details:** Offer price (or pricing mechanism), total amount to be raised, subscription period, allocation methodology
- [ ] **Trading and liquidity:** Whether admission to trading is sought, which platforms, liquidity arrangements
- [ ] **Environmental impact:** Principal adverse environmental and climate impacts of the consensus mechanism used
- [ ] **Disclaimer:** Mandatory warning that the crypto-asset may lose its entire value, is not covered by investor compensation or deposit guarantee schemes

> **Legal advisor note:** As of 23 December 2025, white papers must be prepared in **iXBRL format** (Inline eXtensible Business Reporting Language) for machine-readability. This is a technical requirement that your document preparation team or compliance technology vendor must support.

**Reference:** MiCA Articles 6–12 (Title II white paper), Articles 19–22 (Title III white paper), Articles 51–53 (Title IV white paper)

---

## SECTION 6 — AML/CFT & KYC FRAMEWORK

*MiCA and the EU's Anti-Money Laundering framework operate in tandem. No NCA will authorize a crypto business without a robust AML/CFT compliance program.*

---

### 6.1 — Anti-Money Laundering Requirements

- [ ] **AML/CFT compliance program** drafted and documented, covering:
  - [ ] Customer Due Diligence (CDD) procedures — standard, simplified, and enhanced
  - [ ] Know Your Customer (KYC) onboarding workflows for natural persons and legal entities
  - [ ] Know Your Business (KYB) procedures for corporate/institutional clients
  - [ ] Ongoing transaction monitoring — automated and manual
  - [ ] Suspicious Activity Reporting (SAR) procedures and designated reporting officer
  - [ ] Record-keeping policies (minimum 5-year retention)
  - [ ] Sanctions screening against EU, UN, OFAC, and other relevant lists
  - [ ] PEP (Politically Exposed Persons) screening and enhanced due diligence
- [ ] **Money Laundering Reporting Officer (MLRO)** appointed — must be senior management, EU-based
- [ ] **AML risk assessment** completed for the business — documenting customer risk, product risk, geographic risk, delivery channel risk
- [ ] **Staff training program** on AML/CFT obligations documented and scheduled
- [ ] **Travel Rule compliance** — ability to transmit originator and beneficiary information with crypto-asset transfers (Regulation (EU) 2023/1113 — Transfer of Funds Regulation / TFR)

> **Legal advisor note:** The EU's new Anti-Money Laundering Authority (AMLA) will directly supervise certain high-risk CASPs from 2026. Your AML framework must be NCA-audit-ready from day one — this is the single most common reason for authorization delays or refusals.

**Reference:** EU AML Directive 6 (AMLD6), Regulation (EU) 2023/1113 (TFR/Travel Rule), MiCA Articles 68, 76–79

---

## SECTION 7 — OPERATIONAL & ORGANIZATIONAL REQUIREMENTS

*MiCA requires CASPs and token issuers to maintain specific operational policies, procedures, and infrastructure. These must be documented and ready for NCA review.*

---

### 7.1 — Organizational Policies (Must Have Before Application)

- [ ] **Business plan** — detailed 3-year plan covering revenue model, target markets, planned services, staffing projections, technology architecture, and financial forecasts
- [ ] **Organizational chart** — clear reporting lines, identification of all key functions (compliance, risk, IT, operations, internal audit)
- [ ] **Conflict of interest policy** — identifying, preventing, managing, and disclosing conflicts across all business functions and personal interests of management
- [ ] **Outsourcing policy** — if any critical functions are outsourced, documented oversight and control arrangements must exist
- [ ] **Complaint handling procedure** — formal, transparent process for receiving, investigating, and resolving client complaints within prescribed timelines
- [ ] **Marketing and communications policy** — all marketing must be fair, clear, not misleading, and consistent with white paper disclosures
- [ ] **Record-keeping policy** — documentation of all services, transactions, orders, and client interactions (minimum 5-year retention)

---

### 7.2 — Client Asset Safeguarding (CASPs)

If you provide custody, exchange, or transfer services:

- [ ] **Client asset segregation** — client crypto-assets and funds must be segregated from the firm's own assets at all times
- [ ] **Custody policy** — documented procedures for safekeeping of client crypto-assets, including private key management
- [ ] **Insolvency protection** — client assets must be insolvency-remote (not available to the CASP's creditors in the event of insolvency)
- [ ] **Custodian liability** — the CASP is liable for loss of client crypto-assets unless it can prove the loss was caused by an event beyond its reasonable control
- [ ] **End-of-day client fiat funds placement** — client fiat funds (non-e-money) received must be placed with a credit institution or central bank by the end of the business day following receipt, held in separately identifiable accounts distinct from the CASP's own accounts. This requires a dedicated banking relationship and segregated account infrastructure to be established before going live *(MiCA Article 70(3))*

**Reference:** MiCA Articles 67–73 (CASP organizational requirements), Articles 70, 75–82 (client asset safeguarding and specific service requirements)

---

### 7.3 — Orderly Wind-Down Plan (CASPs)

MiCA Article 74 is a standalone mandatory requirement for every CASP — separate from business continuity planning. It must be submitted as part of the NCA authorization dossier (see Section 10.2).

- [ ] **Orderly wind-down plan documented** — a written plan demonstrating the CASP's ability to wind down all activities without causing undue economic harm to clients, including:
  - Continuity or recovery of any critical client-facing activities during wind-down
  - Return of client assets and funds in an orderly sequence
  - Communication procedures to clients during wind-down
  - Timeline and steps for cessation of each service line

> **Legal advisor note:** This is not the same as a business continuity plan (BCP). BCP covers recovery from disruption while continuing to operate. The wind-down plan covers the scenario where the business ceases permanently. NCAs review this at authorization stage to assess whether the startup has thought through exit risk for clients.

**Reference:** MiCA Article 74

---

## SECTION 8 — ICT & OPERATIONAL SECURITY (MiCA Article 66 + DORA Reg. 2022/2554)

*MiCA Article 66 requires CASPs and token issuers to maintain systems and security protocols in conformity with Union standards. MiCA satisfies this requirement by directly cross-referencing Regulation (EU) 2022/2554 (DORA) — meaning DORA compliance is the mechanism for meeting MiCA's ICT obligations. This is one regulatory process, not two. You do not file separately with DORA regulators — DORA readiness is assessed by the NCA as part of your MiCA authorization review.*

---

### 8.1 — ICT & Cybersecurity Readiness

- [ ] **ICT risk management framework** documented — covering identification, assessment, mitigation, and monitoring of all ICT risks
- [ ] **Business continuity plan (BCP)** — documented procedures for maintaining critical operations during technology disruptions, cyberattacks, or infrastructure failures
- [ ] **Disaster recovery plan (DRP)** — specific recovery time objectives (RTOs) and recovery point objectives (RPOs) for all critical systems
- [ ] **Incident detection and reporting** — systems in place to detect, classify, and report significant ICT incidents to the NCA within prescribed timelines
- [ ] **Penetration testing** — regular independent testing of ICT systems, including vulnerability assessments and threat-led penetration testing
- [ ] **Third-party ICT risk management** — due diligence on all third-party technology providers (cloud, blockchain nodes, oracle providers, API services); contractual provisions for audit rights, data access, and exit strategies
- [ ] **Data protection** — GDPR (Regulation (EU) 2016/679) compliance across all personal data processing activities, including Data Protection Impact Assessments (DPIAs) where required. *Note: GDPR is an independent horizontal EU obligation — it applies to all businesses regardless of MiCA. It is not a MiCA or DORA requirement, but NCAs will expect it to be in place as part of overall operational readiness.*
- [ ] **Smart contract audit** — if deploying smart contracts, independent third-party security audit completed with all material findings remediated before deployment *(MiCA Article 66 — systems and security protocols must conform to Union standards)*

**Reference:** DORA — Regulation (EU) 2022/2554, Articles 5–16 (ICT risk management), Articles 17–23 (incident reporting), Articles 24–27 (resilience testing), Articles 28–44 (third-party risk)

---

## SECTION 9 — MARKET INTEGRITY & CONSUMER PROTECTION

*MiCA introduces market abuse rules for crypto-assets — similar to those in traditional securities markets. These apply from day one.*

---

### 9.1 — Market Abuse Prevention

- [ ] **Insider dealing policy** — prohibition on trading on material non-public information (MNPI) about the crypto-asset
- [ ] **Market manipulation policy** — prohibition on wash trading, spoofing, layering, pump-and-dump schemes, and spreading false or misleading information
- [ ] **Insider lists** — maintenance of lists of persons with access to inside information
- [ ] **MNPI disclosure procedures** — timely public disclosure of inside information, with provisions for delayed disclosure in limited circumstances
- [ ] **Personal dealing rules** — restrictions on personal trading by directors, employees, and connected persons
- [ ] **Surveillance systems** — if operating a trading platform, market surveillance tools to detect suspicious trading activity

**Reference:** MiCA Title VI — Articles 86–92 (Market Abuse)

---

### 9.2 — Consumer Protection Obligations

- [ ] **Pre-contractual disclosures** — clients must receive clear information about services, fees, risks, and complaint procedures before entering into a relationship
- [ ] **Suitability / appropriateness assessment** — if providing advisory or portfolio management services, assessment of whether the crypto-asset is appropriate for the client
- [ ] **Right of withdrawal** — retail consumers who purchase crypto-assets directly from the issuer have a 14-day right of withdrawal (Title II crypto-assets only, with specific exceptions)
- [ ] **Pricing transparency** — clear, non-misleading disclosure of all fees, costs, charges, and execution practices

**Reference:** MiCA Articles 75–82 (Consumer protection), Article 13 (Right of withdrawal)

---

## SECTION 10 — APPLICATION PROCESS & TIMELINE

*This section maps the practical steps from "decision to apply" to "authorization granted."*

---

### 10.1 — NCA Application Workflow

| Step | Action | Typical Timeline |
|---|---|---|
| **1** | Engage specialist EU crypto-regulatory legal counsel | Week 0 |
| **2** | Complete this readiness checklist — identify all gaps | Weeks 1–2 |
| **3** | Select home Member State and NCA | Week 2 |
| **4** | Prepare full application dossier (business plan, policies, white paper, financial evidence, fit-and-proper documentation) | Weeks 3–16 |
| **5** | Submit application to NCA | Week 16+ |
| **6** | NCA completeness check | 25 working days from submission |
| **7** | NCA substantive review (includes Q&A rounds) | 40+ working days (often 3–6 months in practice) |
| **8** | Authorization granted (or conditions/refusal communicated) | 6–12 months total from initial submission |
| **9** | ESMA register listing | Upon authorization |
| **10** | EU-wide passporting notification (if providing services in other Member States) | Post-authorization |

---

### 10.2 — Application Dossier Contents

Your NCA application must include (at minimum):

- [ ] Completed application form (NCA-specific format)
- [ ] Business plan (3-year, detailed)
- [ ] Organizational chart and governance structure
- [ ] Fit-and-proper documentation for all directors, senior managers, and qualifying shareholders
- [ ] Proof of minimum capital / own funds
- [ ] AML/CFT compliance program
- [ ] ICT risk management framework and DORA compliance documentation
- [ ] Business continuity and disaster recovery plans
- [ ] Conflict of interest policy
- [ ] Complaint handling procedures
- [ ] Client asset safeguarding policy (if applicable)
- [ ] White paper (if issuing tokens)
- [ ] Outsourcing arrangements documentation (if applicable)
- [ ] Insurance policy or equivalent guarantee documentation (if required)
- [ ] Marketing and communications policy
- [ ] Legal opinions on token classification (if applicable)

---

## SECTION 11 — "SIGNIFICANCE" THRESHOLDS

*MiCA applies enhanced requirements to ART and EMT issuers that exceed certain thresholds. Know these early — if you anticipate hitting them, your architecture and capital planning must account for it from day one.*

---

### 11.1 — Significance Criteria (Articles 43–44)

An ART or EMT may be classified as "significant" by the EBA if it meets at least three of the following:

| Criterion | Threshold |
|---|---|
| Number of token holders | > 10 million |
| Value of tokens issued / market capitalization | > €5 billion |
| Number and value of daily transactions | > 2.5 million transactions / > €500 million daily |
| Size of reserve of assets | > €1 billion |
| Significance of cross-border activities | Operations in > 7 Member States |
| Interconnectedness with the financial system | Determined by EBA on case-by-case basis |

**Consequences of "significant" classification:**
- [ ] Direct supervision transfers from NCA to EBA
- [ ] Own funds requirement increases (up to 3% of average reserves)
- [ ] Minimum 60% of reserves must be held as bank deposits (EMTs)
- [ ] Enhanced liquidity management and stress testing requirements
- [ ] Recovery and wind-down planning mandatory
- [ ] EBA can require additional capital buffers (up to 20% increase)

**Reference:** MiCA Articles 43–44 (Significance criteria), Articles 45 (Voluntary classification)

---

## SECTION 12 — TRANSITIONAL PROVISIONS & TIMELINE AWARENESS

*If you are already operating, understand the transitional rules. If you are a new entrant, understand when full enforcement applies.*

---

### 12.1 — Key Dates

| Date | Milestone |
|---|---|
| **29 June 2023** | MiCA published in Official Journal of the EU |
| **30 June 2024** | Title III (ART) and Title IV (EMT) provisions apply |
| **30 December 2024** | Full MiCA application — Titles I, II, V, VI, VII apply |
| **1 July 2026** | Transitional period ends — all "grandfathered" providers must be authorized or cease operations |
| **23 December 2025** | White papers must comply with iXBRL format requirements |

- [ ] If already operating under a national regime — confirm transitional period status with home NCA
- [ ] If new entrant — plan for full MiCA compliance from day one (no grandfathering available)
- [ ] Monitor ESMA and EBA technical standards publications — Level 2 and Level 3 measures continue to be issued

**Reference:** MiCA Articles 143–149 (Transitional provisions)

---

## READINESS SCORECARD — SUMMARY

*Use this scorecard to assess your overall readiness. Count completed checkboxes per section.*

| Section | Topic | Items | Ready? |
|---|---|---|---|
| 1 | MiCA applicability & scope | 12 | ☐ |
| 2 | Business classification | 14 | ☐ |
| 3 | Entity structure & governance | 14 | ☐ |
| 4 | Financial requirements & capital | 14 | ☐ |
| 5 | White paper | 16 | ☐ |
| 6 | AML/CFT & KYC | 15 | ☐ |
| 7 | Operational & organizational | 11 | ☐ |
| 8 | ICT, cybersecurity & DORA | 8 | ☐ |
| 9 | Market integrity & consumer protection | 10 | ☐ |
| 10 | Application process & dossier | 16 | ☐ |
| 11 | Significance thresholds | 7 | ☐ |
| 12 | Transitional provisions | 3 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** Ready to engage NCA application process
- **Amber (50–80% complete):** Material gaps exist — close these before filing
- **Red (<50% complete):** Significant preparation required — engage specialist counsel and allocate 3–6 months of pre-application work

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for MiCA-bound start-ups:**

**Pre-Build:** MiCA classification brief → token behavior specification → white paper technical review → architecture design (all compliance logic embedded before first line of code)

**Build:** ERC-3643/ERC-1400 token contracts → on-chain identity registry → Proof-of-Reserve oracle integration → multi-sig governance → ERC-1967 proxy upgradability → custody segregation → structured event schema → Travel Rule event design

**Audit:** Independent smart contract security audit → NCA-ready audit report → white paper-to-code mapping document → delta audit process for ongoing deployments

**Why start-ups choose us:** We don't just write code — we write code that satisfies your NCA reviewer. Every contract function is labelled against the MiCA article it enforces. Your legal team reads the architecture specification alongside the regulation, not instead of it.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. MiCA requirements are subject to national implementation measures, ESMA/EBA technical standards, and ongoing regulatory guidance. Always engage qualified EU crypto-regulatory legal counsel for your specific business and jurisdiction.*

*Document version: 1.0 | Last updated: May 2026*
*Regulation reference: Regulation (EU) 2023/1114 of the European Parliament and of the Council of 31 May 2023 on markets in crypto-assets (MiCA)*
