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

MiCA does **not** apply to the following carve-outs in Article 2. Check any that describe your product:

- [ ] **NFTs and other unique/non-fungible crypto-assets** → out of scope per Article 2(3), except where fractionalised or issued in a large series indicating fungibility in substance
- [ ] **Financial instruments under MiFID II** (equity tokens, security tokens, derivatives) → regulated under MiFID II, not MiCA *(Article 2(4)(a))*
- [ ] **Deposits, including structured deposits** → regulated under CRD/CRR *(Article 2(4)(b))*
- [ ] **Funds** (other than e-money tokens) → other EU regimes *(Article 2(4)(c))*
- [ ] **Securitisation positions** under Regulation (EU) 2017/2402 *(Article 2(4)(d))*
- [ ] **Insurance and reinsurance products** (life, non-life, retrocession) *(Article 2(4)(e))*
- [ ] **Pension products** (occupational schemes, individual products with employer contribution, PEPP, social security schemes) *(Article 2(4)(f)–(j))*
- [ ] **CBDCs issued by central banks** acting as monetary authorities *(Article 2(2)(c))*
- [ ] **Services provided exclusively to parent / subsidiaries within a corporate group** *(Article 2(2)(a))*
- [ ] **Services provided by ECB, national central banks, public authorities, EIB, EFSF/ESM, public international organisations** *(Article 2(2)(c)–(f))*

> **Decentralisation — read carefully:** MiCA Recital 22 states that crypto-asset services provided "in a fully decentralised manner without any intermediary" fall outside the Regulation, and that crypto-assets with **no identifiable issuer** fall outside Titles II, III, and IV (issuance/white-paper obligations). **However**, the same Recital makes clear that CASPs providing services *in respect of* such no-issuer crypto-assets remain fully within Title V. In practice this means: a Bitcoin-style token without an issuer does not need a white paper, but the exchange listing it still needs CASP authorisation. "Fully decentralised" is a high evidentiary bar, not a self-certification.

> **Legal advisor note:** The MiFID II vs. MiCA boundary is the single most common classification issue. If your token represents equity, debt, or derivative exposure, MiFID II applies. If it references the value of an asset or basket but does not confer ownership of the underlying, MiCA likely applies. ESMA was mandated under Article 2(5) to issue guidelines on the financial-instrument boundary by 30 December 2024 — confirm the current version of those guidelines with counsel. This classification decision must be documented formally — it is the foundation of your entire compliance architecture.

**Reference:** MiCA Article 2 (scope and exclusions), Article 2(5) (ESMA guidelines on financial-instrument classification), Recital 22 (decentralisation and no-issuer tokens)

---

### 1.3 — Authorisation Pathway: Full Authorisation vs. Simplified Notification

If your business is **already authorised under another EU financial-services regime**, MiCA Article 60 may let you provide CASP services via a 40-working-day **notification** to your NCA — not a full authorisation. Check whether any of the following apply:

- [ ] **Credit institution** (CRD-authorised bank) → may provide all CASP services on notification *(Article 60(1))*
- [ ] **Central securities depository (CSDR)** → may provide custody and administration on notification *(Article 60(2))*
- [ ] **MiFID investment firm** → may provide CASP services equivalent to its existing MiFID authorisations on notification *(Article 60(3))*
- [ ] **Electronic money institution** → may provide custody and transfer services for the EMTs it issues, on notification *(Article 60(4))*
- [ ] **UCITS management company / AIFM** → may provide CASP services equivalent to its existing authorisations on notification *(Article 60(5))*
- [ ] **Market operator (MiFID)** → may operate a trading platform for crypto-assets on notification *(Article 60(6))*
- [ ] **None of the above** → full CASP authorisation under Article 59 is required

> **Legal advisor note:** The notification still requires submission of an extensive information package (Article 60(7), points (a)–(k) — programme of operations, AML controls, BCP, ICT systems, segregation, custody policy, trading-platform rules, commercial policy, execution policy, advisor competence, transfer-service modalities). The benefit is the 40-working-day timeline and the absence of a re-authorisation step, not reduced substantive obligations.

> **Critical carve-out — Article 60(10):** Entities providing services under Article 60(1)–(6) are **not subject** to Articles **62, 63, 64, 67, 83 and 84**. In practice this means: no Annex IV capital class (the firm's existing prudential regime applies instead), no separate authorisation/withdrawal procedure, and no qualifying-holdings assessment under MiCA. They remain subject to Articles 65–82 (cross-border, conduct of business, safeguarding, wind-down, service-specific obligations).

**Reference:** MiCA Article 59 (full authorisation), Article 60 (provision of crypto-asset services by certain financial entities, including the (10) carve-out), Article 61 (exclusive initiative of the client / reverse solicitation)

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
- **No interest or yield may accrue on the token itself** *(Article 50)*
- Funds received in exchange for EMTs must be invested in secure, low-risk assets denominated in the same official currency referenced by the token *(Article 54)*

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

### 4.1 — CASP Minimum Capital Requirements (Title V, Article 67 + Annex IV)

Capital class is determined by the services you are authorised to provide. Classes are cumulative — Class 2 includes all Class 1 services, Class 3 includes all Class 2 services.

| Class | Services Authorised (cumulative) | Minimum Capital |
|---|---|---|
| **Class 1** | Execution of orders, placing, transfer services, reception/transmission of orders, advice, portfolio management | **€50,000** |
| **Class 2** | All Class 1 services **plus** custody and administration of crypto-assets, exchange for funds, exchange for other crypto-assets | **€125,000** |
| **Class 3** | All Class 2 services **plus** operation of a trading platform for crypto-assets | **€150,000** |

> **Common error:** custody is in Class 2 (€125,000), not Class 3. Operation of a trading platform is the single service that triggers Class 3 (€150,000).

**Additional requirement (Article 67(1)(b)):** Prudential safeguards must be at least the **higher** of:
- The Class minimum above, OR
- **One quarter of the fixed overheads of the preceding year** (or projected first-year overheads for new businesses)

Prudential safeguards may take the form of own funds (CET1 instruments) **or** an equivalent insurance policy covering the EU territories of operation — or a combination of both *(Article 67(4))*.

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
- [ ] Reserve assets segregated from issuer's own assets (insolvency-remote) *(Article 36)*
- [ ] Reserve invested only in highly liquid financial instruments with minimal market, credit, and concentration risk *(Article 38)*
- [ ] No crypto-assets held in the reserve
- [ ] Custodian(s) appointed for reserve management *(Article 37)*
- [ ] **Bank-deposit minimum:** at least **30% of the amount referenced in each official currency** held as deposits in credit institutions (rising to **60% for significant ARTs**) *(Article 36(5)(d) / Article 45(7)(b))*
- [ ] **Stress testing program planned** — MiCA requires ART issuers to conduct regular stress tests covering severe financial scenarios (e.g. interest rate shocks) and non-financial scenarios (e.g. operational risk). Based on the risk assessment, the home NCA may require you to hold own funds **up to 20% higher** than the 2%-of-reserve baseline. Plan your capital buffer accordingly before filing *(MiCA Article 35(3))*
- [ ] **No-interest / no-yield feature confirmed** — ARTs must not offer interest, yield, staking rewards, or any return to token holders based on the length of time they hold the token. If your product design includes any yield or rewards mechanism, it must be removed before issuance — rebuilding this post-authorization is a full product redesign *(MiCA Article 40)*
- [ ] **Permanent redemption right for holders confirmed** — holders must be able to redeem at any time, either (i) in funds (other than e-money) equivalent to the market value of the referenced assets, or (ii) by delivery of the referenced assets. **Redemption shall not be subject to a fee** (Article 39(3)) — except where the issuer is operating under its recovery plan (Article 46), which expressly permits liquidity fees on redemptions, daily redemption caps, or temporary suspension as recovery measures. Redemption policy and procedures must be published *(MiCA Article 39 + Article 46(1))*
- [ ] **Quarterly reporting workflow planned** — if the issue value is or will exceed **€100,000,000**, the issuer must report to the home NCA every quarter on: (i) number of holders, (ii) value issued and reserve size, (iii) average number and value of daily transactions, (iv) transactions associated with use of the ART as a means of exchange. Reporting infrastructure (data extraction, attestation, submission format) must be operational from launch *(MiCA Article 22)*
- [ ] **Means-of-exchange cap understood and modelled** — if the estimated quarterly average exceeds **1 million transactions per day AND €200 million per day** in a single currency area for use as a means of exchange, the issuer **must stop issuing** the ART and submit a remediation plan to NCA within 40 working days. If your product targets payment use, model your projected volumes against this cap before product launch *(MiCA Article 23)*

---

### 4.2a — ART Recovery & Redemption Plans (Mandatory Crisis Documents)

These are **two separate documents**, both mandatory, both filed with the NCA. Neither is the same as a wind-down plan (Section 7.3) or a business continuity plan (Section 8.1).

- [ ] **Recovery plan drafted** — measures the issuer will take to **restore compliance with reserve requirements** if it fails to comply, plus measures to preserve services, recover operations, and meet obligations in stress events. Must include conditions and indicators triggering activation, and shall be notified to the NCA within 6 months of authorisation / approval of the white paper *(MiCA Article 46)*
- [ ] **Redemption plan drafted** — operational plan to support the **orderly redemption** of each ART, to be implemented on a decision by the NCA that the issuer is unable (or likely to be unable) to fulfil its obligations — including insolvency, resolution, or withdrawal of authorisation. Must include arrangements for protection of holders and continuity of any critical activities, and shall be notified to the NCA within 6 months of authorisation / approval of the white paper *(MiCA Article 47)*

> **Legal advisor note:** Recovery (Art 46) is for *restoring* the business to compliance. Redemption (Art 47) is for *winding the token down* without harming holders. Wind-down (Art 74) is for ceasing CASP services. A founder issuing an ART **and** providing services around it needs all three — they answer different questions for different failure modes.

**Reference:** MiCA Articles 46–47 (recovery and redemption plans)

---

### 4.3 — EMT Issuer Capital Requirements (Title IV)

For businesses issuing e-money tokens:

- [ ] Authorized as a credit institution or electronic money institution (prerequisite) *(Article 48)*
- [ ] 1:1 funds-equivalent backing maintained at all times *(Article 48(2))*
- [ ] Funds received in exchange for EMTs invested in secure, low-risk assets denominated in the same official currency referenced by the token *(Article 54)*
- [ ] EMTs issued **at par value** on receipt of funds *(Article 49(3))*
- [ ] Holders have a redemption right **at any time and at par value**, paid in funds (other than e-money) *(Article 49(4))*
- [ ] **Redemption shall not be subject to a fee** — parallel to the ART rule, without prejudice to Article 46 (recovery plan) applied *mutatis mutandis* via Article 55 *(Article 49(6))*
- [ ] Conditions for redemption **prominently stated in the white paper** *(Article 49(5), referring to Article 51(1)(d))*
- [ ] **No interest paid** to token holders or by CASPs in respect of services related to EMTs *(Article 50)*
- [ ] Reserve assets legally segregated from issuer's balance sheet

> **Note on bank-deposit thresholds:** The 30% / 60%-as-bank-deposits rule (Article 36(5)(d) / Article 45(7)(b)) applies to **asset-referenced tokens**, not EMTs. EMT investment rules sit in Article 54 and the Electronic Money Directive 2009/110/EC. Do not conflate the two regimes.

- [ ] **EMT recovery plan drafted and notified** — Article 46 applies *mutatis mutandis* to EMT issuers, with the recovery plan to be notified to the NCA within **6 months** of the offer to the public or admission to trading *(MiCA Article 55, by reference to Article 46)*
- [ ] **EMT redemption plan drafted and notified** — Article 47 applies *mutatis mutandis* to EMT issuers, with the redemption plan to be notified to the NCA within **6 months** of the offer to the public or admission to trading *(MiCA Article 55, by reference to Article 47)*

**Reference:** MiCA Articles 35–38 (ART reserves and own funds), Articles 48–54 (EMT authorisation, reserves, and investment), Article 55 (EMT recovery and redemption plans), Articles 67–68 (CASP prudential and organisational requirements), Annex IV (CASP capital classes)

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

> **Legal advisor note:** Articles 6, 19, and 51 require white papers to be available in a machine-readable format. The specific technical format and timetable are set by ESMA-developed Regulatory Technical Standards adopted as Commission Delegated Regulations — not by MiCA Level 1. Confirm the current format requirement, effective date, and any transitional periods with counsel before drafting, and ensure your document preparation team or compliance technology vendor can support the format.

**Reference:** MiCA Articles 6–12 (Title II white paper), Articles 19–22 (Title III white paper), Articles 51–53 (Title IV white paper)

---

### 5.3 — Ongoing Duty to Update the White Paper

The white paper is **not a one-time disclosure**. The obligation to keep it accurate runs for the entire life of the offer or admission to trading.

- [ ] **Trigger awareness:** any **significant new factor, material mistake, or material inaccuracy** capable of affecting the assessment of the crypto-asset triggers an obligation to modify the white paper (and any related marketing communications) *(Articles 12 (Title II), 25 (ART), 53 (EMT))*
- [ ] **Modification workflow defined:** modified white paper notified to NCA in advance of publication, with the reasons for modification. For ARTs and EMTs, prior **NCA approval** of the modification is required before publication *(Article 25(1) and Article 53)*
- [ ] **Historical-version retention:** previously published versions of the white paper must remain accessible on the issuer's website for at least **10 years** after the date of publication, with a prominent warning that they are no longer valid and a hyperlink to the current version *(Article 9(3))*

---

### 5.4 — Failed Offer: Refunds and Safeguarding (Title II Offers Only)

If a Title II offer to the public has a stated **subscription period, target, or condition** and that condition is not met, the offeror must return the funds collected.

- [ ] **Safeguarding arrangements documented before launch** — funds collected during the subscription period must be either: (a) deposited at a credit institution, or (b) held under an arrangement that guarantees their return to retail holders if the offer fails *(Article 10(2))*
- [ ] **Refund mechanics defined** — if the offer does not meet its target or is cancelled, funds must be returned to subscribers in accordance with the conditions disclosed in the white paper, without undue delay *(Article 10(2)–(3))*
- [ ] **Disclosure in white paper** — subscription period, conditions, target amount, refund mechanism, and safeguarding arrangements all disclosed in the white paper *(Article 6 + Annex I)*

**Reference:** MiCA Article 10 (result of the offer to the public and safeguarding arrangements)

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
- [ ] **Travel Rule compliance** — ability to transmit originator and beneficiary information with crypto-asset transfers under **Regulation (EU) 2023/1113** (Transfer of Funds Regulation / TFR), applicable to CASPs since 30 December 2024
- [ ] **2024 AML Package awareness** — three new acts progressively replace the older AMLD framework. Build your AML programme so the additional requirements can be layered in without re-architecture:
  - **Regulation (EU) 2024/1624** ("AMLR") — single, directly applicable EU AML rulebook for obliged entities (including CASPs); applies from **10 July 2027**
  - **Directive (EU) 2024/1640** ("AMLD6") — institutional and supervisory framework; Member State transposition by **10 July 2027**
  - **Regulation (EU) 2024/1620** — establishes the **Anti-Money Laundering Authority (AMLA)** in Frankfurt; AMLA begins operations 1 July 2025; direct supervision of selected obliged entities from **1 January 2028** (selection during 2027)
- [ ] **Current-state AML compliance** — until AMLR applies in July 2027, CASPs remain subject to **national law transposing Directive (EU) 2015/849 (AMLD4) as amended by Directive (EU) 2018/843 (AMLD5)**, plus Regulation (EU) 2023/1113. The NCA examines AML readiness against the national regime in force at the time of application

> **Legal advisor note:** AMLA's first selection of directly supervised obliged entities is expected in 2027 with direct supervision from 1 January 2028. A CASP operating in multiple Member States at sufficient scale should expect to be a candidate, which means concurrent scrutiny by the NCA (for MiCA conduct/prudential) and AMLA (for AML). Your AML framework must be NCA-audit-ready from day one — AML readiness is the single most common reason for MiCA authorisation delays or refusals.

**Reference:** Regulation (EU) 2024/1624 (AMLR), Directive (EU) 2024/1640 (AMLD6 institutional framework), Regulation (EU) 2024/1620 (AMLA Regulation), Regulation (EU) 2023/1113 (TFR / Travel Rule), Directive (EU) 2015/849 + Directive (EU) 2018/843 (AMLD4/5 — current regime until July 2027), MiCA Articles 68(8) (AML cross-reference for CASPs), 18, 34, 62 (AML documentation in authorisation dossier)

---

## SECTION 7 — OPERATIONAL & ORGANIZATIONAL REQUIREMENTS

*MiCA requires CASPs and token issuers to maintain specific operational policies, procedures, and infrastructure. These must be documented and ready for NCA review.*

---

### 7.1 — Organizational Policies (Must Have Before Application)

- [ ] **Business plan** — detailed 3-year plan covering revenue model, target markets, planned services, staffing projections, technology architecture, and financial forecasts
- [ ] **Organizational chart** — clear reporting lines, identification of all key functions (compliance, risk, IT, operations, internal audit)
- [ ] **Conflict of interest policy** *(Articles 32 (ART) / 72 (CASP))* — written policy that (i) identifies sources of conflict between the firm, its management, employees, shareholders, clients, and holders; (ii) sets organisational and administrative arrangements to prevent or manage them; (iii) provides for disclosure to clients/holders **only where prevention is not sufficient**; (iv) is reviewed at least annually; (v) covers personal-account dealing rules
- [ ] **Outsourcing policy** *(Article 73)* — if any function is outsourced: (i) no outsourcing of senior-management responsibility — the firm remains fully responsible; (ii) due diligence on the service provider; (iii) written agreement specifying rights and obligations; (iv) **NCA's right of access** to data, premises, and information held by the provider; (v) **documented exit strategy** for each outsourced function; (vi) ongoing oversight and performance monitoring
- [ ] **Complaint handling procedure** *(Article 71 (CASP) / Article 31 (ART))* — free, fair, prompt and consistent procedure published on the website, with clear escalation, timelines, and record-keeping
- [ ] **Marketing and communications policy** — all marketing must be fair, clear, not misleading, and consistent with white paper disclosures *(Articles 7, 29, 53)*
- [ ] **Record-keeping policy** — documentation of all services, transactions, orders, and client interactions; minimum **5-year retention**, extendable to **7 years** on NCA request *(Article 68(9))*

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

### 7.4 — Service-Specific CASP Obligations (Articles 75–82)

Each CASP service has its own conduct, transparency, and operational obligations on top of the general organisational requirements in Section 7.1. Tick the rows that apply to your planned service mix — every row creates concrete documentation and process work.

#### ☐ Custody and administration of crypto-assets *(Article 75)*

- [ ] **Custody agreement** with each client specifying: parties, nature of the service, custody policy, communication and authentication, security systems, fees, applicable law
- [ ] **Register of positions** opened in the name of each client, recording all movements promptly
- [ ] **Custody policy** with internal rules and procedures minimising the risk of loss
- [ ] **Statement of position** provided to clients at least every 3 months and on demand
- [ ] **Liability for loss confirmed in design** — the CASP is liable for loss of crypto-assets or means of access **as a result of an incident attributable to it**, capped at the market value of the lost asset at the time of loss. Excluded: incidents the CASP demonstrates occurred independently of its operations, e.g. an inherent problem in the DLT itself *(Article 75(8))*
- [ ] **No use of client crypto-assets for own account** — Article 70(1) requires arrangements to safeguard ownership rights and **prevent use of clients' crypto-assets for the CASP's own account**. Article 75 does not provide a consent-based carve-out
- [ ] **Operational and legal segregation on the DLT** — clients' crypto-assets held in custody are legally segregated from the CASP's estate (insolvency-remote) and operationally held separately on the distributed ledger *(Article 75(7))*
- [ ] **Use of third-party sub-custodians** — if outsourcing custody to another CASP, only use CASPs authorised under Article 59 and inform clients *(Article 75(9))*

#### ☐ Operation of a trading platform *(Article 76)*

- [ ] **Operating rules** *(Article 76(1))* covering: CDD-based approval of applicants, exclusion categories, admission fees, non-discriminatory participation rules, fair and orderly trading rules, suspension conditions, and efficient settlement procedures
- [ ] **No admission of crypto-assets without a compliant white paper** in the cases where a white paper is required by the Regulation *(Article 76(1), second subparagraph)*
- [ ] **Pre-trade and post-trade transparency** — bid/offer prices, depth, and executed price/volume/time published in real time on a continuous basis during trading hours *(Article 76(9)–(10))*
- [ ] **No dealing on own account** on the trading platform the CASP itself operates *(Article 76(5))*
- [ ] **Matched principal trading allowed only with client consent**, with information provided to the NCA which monitors usage and conflict-of-interest implications *(Article 76(6))*
- [ ] **Final settlement initiated on the DLT within 24 hours** of execution on the platform; for transactions settled outside the DLT, settlement by the **close of the same business day** at the latest *(Article 76(12))*
- [ ] **Resilient trading systems** — capacity, throughput, ability to ensure orderly trading under stress, including circuit breakers *(Article 76(7))*
- [ ] **Transparent, fair, non-discriminatory fee structure** that does not incentivise placing, modifying, or cancelling orders in ways that disrupt orderly trading *(Article 76(13))*

#### ☐ Exchange of crypto-assets for funds or other crypto-assets *(Article 77)*

- [ ] **Non-discriminatory commercial policy** published, including types of clients accepted and conditions
- [ ] **Firm or indicative prices** published, plus method of price determination
- [ ] **Post-trade transparency** — execution price, volume, and time published
- [ ] **Order execution policy** — designed to obtain the best result for clients

#### ☐ Execution of orders on behalf of clients *(Article 78)*

- [ ] **Best execution policy** — sufficient steps to obtain the best possible result for clients in terms of price, costs, speed, likelihood of execution and settlement, size, nature, and any other relevant consideration
- [ ] **Client information** on the order execution policy provided and consent obtained
- [ ] **Monitoring of execution quality** and annual review of the policy

#### ☐ Placing of crypto-assets *(Article 79)*

- [ ] **Pre-engagement disclosure** to the offeror/issuer of: the type of placing (firm-commitment / best-efforts), fees, timing, targeted purchasers
- [ ] **Conflict-of-interest management** in placing — particularly where the CASP is also providing other services to the same issuer

#### ☐ Reception and transmission of orders *(Article 80)*

- [ ] **Prompt and proper transmission** of client orders to a third party for execution
- [ ] **No misuse of client order information** for own account or for benefit of others
- [ ] **No monetary or non-monetary inducements** for routing client orders to a specific platform

#### ☐ Advice on crypto-assets and portfolio management *(Article 81)*

- [ ] **Suitability assessment** — obtain information on the client's knowledge and experience, investment objectives, financial situation including ability to bear losses, and risk tolerance, **before** providing advice or portfolio management *(Article 81(1), (8))*
- [ ] **Suitability report** issued to the client in electronic format, specifying the advice given and how it meets the client's preferences, objectives, and other characteristics *(Article 81(13))*
- [ ] **Periodic suitability reassessment** — at least every 2 years after the initial assessment *(Article 81(12))*
- [ ] **Periodic portfolio-management statements** — for portfolio management clients, **every 3 months** (or via an online system with evidence of client access at least once per quarter), covering activities, performance, and updated suitability *(Article 81(14))*
- [ ] **Staff competence** — natural persons giving advice or information must possess the necessary knowledge and competence; Member States publish the assessment criteria *(Article 81(7))*
- [ ] **Independence disclosure** — before providing advice, inform the client whether it is provided on an independent basis and whether based on a broad market analysis *(Article 81(2))*
- [ ] **Inducement restrictions** — if independent advice or portfolio management: **no fees, commissions, or non-monetary benefits** from third parties may be accepted and retained (minor non-monetary benefits permitted with disclosure); if non-independent advice: inducements allowed only if they enhance service quality, do not impair best-interests duty, and are clearly disclosed *(Article 81(3), (5), (6))*
- [ ] **Standard risk warnings** to clients — value may fluctuate, partial/full losses possible, illiquidity, no investor compensation scheme, no deposit guarantee scheme *(Article 81(9))*

#### ☐ Transfer services for crypto-assets *(Article 82)*

- [ ] **Written agreement** with each client specifying: identity of parties, description of the service, security systems, fees, applicable law
- [ ] **Compliance with Travel Rule** (Regulation (EU) 2023/1113) — already in Section 6.1

**Reference:** MiCA Articles 75–82 (specific service obligations)

---

### 7.5 — Ongoing Notification Obligations (Post-Authorisation)

Authorisation is not the end of the relationship with the NCA — material changes must be notified, often **before** they take effect. Build the workflow before going live.

- [ ] **Changes to the management body** — any new or replaced member of the management body must be notified to the NCA **prior to exercising activities**, with full fit-and-proper documentation (CVs, criminal-record certificates, conflict declarations) *(Article 33 (ART) / Article 69 (CASP))*
- [ ] **Qualifying holdings — acquisitions (ART issuer)** — any proposed direct or indirect acquisition reaching or exceeding **20%, 30%, or 50%** of voting rights or capital, or making the issuer a subsidiary, requires **prior written notification** to the NCA for assessment. The NCA has up to 60 working days to oppose. Apply the same for proposed disposals *(Articles 41–42)*
- [ ] **Qualifying holdings — acquisitions (CASP)** — same regime: any proposed acquisition reaching 20%, 30%, or 50% requires prior written notification to the home NCA; the NCA acknowledges receipt within 2 working days and has 60 working days to assess (suspendable for additional information). Disposals reducing holdings below 10%, 20%, 30%, or 50% also require notification. Affects every funding round, secondary, founder transfer, and exit. **Carve-out:** entities providing CASP services under Article 60 (banks, MiFID firms, EMIs, etc.) are exempt from Articles 83–84 by virtue of Article 60(10) *(Articles 83–84)*
- [ ] **Programme of operations / business model changes** — material changes (new services, new Member States, new technical infrastructure) require notification and may require a new authorisation step
- [ ] **Cross-border passporting** — before providing services in another Member State, notify the home NCA, which forwards to the host NCA within 10 working days *(Article 65)*

**Reference:** MiCA Articles 33, 41–42, 65, 69, 83–84

---

## SECTION 8 — ICT & OPERATIONAL SECURITY (MiCA Articles 34 & 68 + DORA Reg. 2022/2554)

*MiCA requires CASPs (Article 68(7)–(8)) and ART issuers (Article 34(10)) to maintain "resilient and secure ICT systems as required by Regulation (EU) 2022/2554" — i.e. DORA. MiCA satisfies the ICT requirement by directly cross-referencing DORA, meaning DORA compliance is the mechanism for meeting MiCA's ICT obligations. This is one regulatory process, not two. You do not file separately with DORA regulators — DORA readiness is assessed by the NCA as part of your MiCA authorisation review.*

---

### 8.1 — ICT & Cybersecurity Readiness

- [ ] **ICT risk management framework** documented — covering identification, assessment, mitigation, and monitoring of all ICT risks
- [ ] **Business continuity plan (BCP)** — documented procedures for maintaining critical operations during technology disruptions, cyberattacks, or infrastructure failures
- [ ] **Disaster recovery plan (DRP)** — specific recovery time objectives (RTOs) and recovery point objectives (RPOs) for all critical systems
- [ ] **Incident detection and reporting** — systems in place to detect, classify, and report significant ICT incidents to the NCA within prescribed timelines
- [ ] **Penetration testing** — regular independent testing of ICT systems, including vulnerability assessments and threat-led penetration testing
- [ ] **Third-party ICT risk management** — due diligence on all third-party technology providers (cloud, blockchain nodes, oracle providers, API services); contractual provisions for audit rights, data access, and exit strategies
- [ ] **Data protection** — GDPR (Regulation (EU) 2016/679) compliance across all personal data processing activities, including Data Protection Impact Assessments (DPIAs) where required. *Note: GDPR is an independent horizontal EU obligation — it applies to all businesses regardless of MiCA. It is not a MiCA or DORA requirement, but NCAs will expect it to be in place as part of overall operational readiness.*
- [ ] **Smart contract audit** — if deploying smart contracts, independent third-party security audit completed with all material findings remediated before deployment *(MiCA Articles 34(10) / 68(7)–(8) — ICT systems must be resilient and secure as required by DORA)*

**Reference:** DORA — Regulation (EU) 2022/2554, Articles 5–16 (ICT risk management), Articles 17–23 (incident reporting), Articles 24–27 (resilience testing), Articles 28–44 (third-party risk)

---

## SECTION 9 — MARKET INTEGRITY & CONSUMER PROTECTION

*MiCA introduces market abuse rules for crypto-assets — similar to those in traditional securities markets. These apply from day one.*

---

### 9.1 — Market Abuse Prevention

- [ ] **Insider dealing prohibition** — prohibition on using inside information to acquire, dispose of, cancel, or amend orders for the affected crypto-assets, for own account or for the account of another *(Article 89)*
- [ ] **Unlawful disclosure prohibition** — prohibition on disclosing inside information to any other person except in the normal course of work, profession, or duties *(Article 90)*
- [ ] **Market manipulation prohibition** — prohibition on (i) transactions/orders giving false or misleading signals as to supply, demand or price, or securing the price at an abnormal level; (ii) transactions employing fictitious devices or any form of deception; (iii) dissemination of information giving false or misleading signals *(Article 91)*
- [ ] **Public disclosure of inside information** *(Article 88)* — issuers, offerors, and persons seeking admission to trading must publicly disclose inside information directly concerning them **as soon as possible**, in a manner enabling fast access and complete, correct, timely assessment. Posted on the issuer's website and kept there for **at least 5 years**. Issuers must not combine the disclosure of inside information with the marketing of their activities. Disclosure may be **delayed** under the issuer's own responsibility where all three conditions are met: (i) immediate disclosure likely to prejudice the issuer's legitimate interests, (ii) delay not likely to mislead the public, (iii) confidentiality ensured. The NCA must be informed (with a written explanation) **immediately after** the information is eventually disclosed to the public
- [ ] **Internal controls supporting Article 88** — although MiCA does not import the MAR insider-list or managers'-transactions regime, firms in practice maintain (i) a record of persons with access to inside information, and (ii) personal-account dealing rules for directors, employees, and connected persons, to evidence the conflict-of-interest controls required by **Article 72** and to support STOR detection. Treat these as best-practice / MAR-equivalent controls, not as standalone MiCA obligations
- [ ] **Prevention-and-detection arrangements** *(Article 92)* — any person professionally arranging or executing transactions in crypto-assets must have **effective arrangements, systems, and procedures** to prevent and detect market abuse
- [ ] **Suspicious Transaction and Order Reports (STORs)** *(Article 92(1))* — the same persons must **report to the NCA without delay** any reasonable suspicion regarding an order or transaction (including cancellation or modification) that could constitute insider dealing, unlawful disclosure, or market manipulation. Build the workflow (criteria, escalation, reporting form, designated officer) before going live
- [ ] **Surveillance systems** — if operating a trading platform, market surveillance tools to detect suspicious trading activity, calibrated to feed the STOR workflow

**Reference:** MiCA Title VI — Articles 86 (scope), 87 (inside information), 88 (public disclosure), 89 (insider dealing), 90 (unlawful disclosure), 91 (market manipulation), 92 (prevention, detection, and STORs)

---

### 9.2 — Consumer Protection & Best-Interests Duty

- [ ] **Best interests of clients / holders** *(Articles 27 (ART) / 66 (CASP))* — duty to act **honestly, fairly, and professionally** in the best interests of clients and holders. This is a standalone conduct duty that overlays everything else (marketing, advice, custody, execution)
- [ ] **Pre-contractual disclosures** *(Article 66)* — clients must receive clear information about services, fees, risks, and complaint procedures before entering into a relationship; CASPs must publish pricing, costs, and fee policies on their website
- [ ] **Suitability / appropriateness assessment** *(Article 81)* — if providing advisory or portfolio management services, assess whether the crypto-asset is appropriate for the client (knowledge, experience, objectives, financial situation, risk tolerance)
- [ ] **Right of withdrawal** *(Article 13)* — retail consumers who purchase Title II crypto-assets directly from an offeror (or a CASP placing on its behalf) have a **14 calendar day** right of withdrawal without fees or reasons; not applicable where the crypto-asset has been admitted to trading prior to purchase
- [ ] **Environmental impact disclosure** *(Article 66(5))* — CASPs must publish information on the principal adverse environmental and climate impacts of the consensus mechanism used by each crypto-asset they provide services for, in a prominent place on their website
- [ ] **Pricing transparency** — clear, non-misleading disclosure of all fees, costs, charges, and execution practices

**Reference:** MiCA Article 13 (right of withdrawal), Articles 27 / 66 (best-interests duty), Article 81 (suitability), Article 66(5) (environmental disclosure)

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

### 11.1 — Significance Criteria (Article 43 for ARTs, Article 56 for EMTs)

EBA shall classify an ART (or EMT) as "significant" where **at least three** of the criteria below are met. Specific thresholds within each criterion are further specified by Commission Delegated Regulation adopted under Article 43(11).

| # | Criterion (Article 43(1)) | Level 1 threshold |
|---|---|---|
| (a) | Number of holders of the token | > **10 million** |
| (b) | Value of the token issued, its market capitalisation, **or** the size of the reserve of assets | > **EUR 5 000 000 000** (any of the three measures) |
| (c) | Average number and average aggregate value of daily transactions | > **2.5 million** transactions **and** > **EUR 500 million** per day |
| (d) | Issuer is a gatekeeper designated under the Digital Markets Act | Designated under Reg. (EU) 2022/1925 |
| (e) | Significance of activities on an international scale | Including use of the token for payments and remittances (further specified by delegated act) |
| (f) | Interconnectedness with the financial system | Assessed by EBA |
| (g) | Same issuer issues additional ARTs/EMTs or provides at least one crypto-asset service | Cumulation criterion |

**Consequences of "significant" classification:**
- [ ] **Direct EBA supervision** of significant ART issuers *(Article 117(1))*. For significant EMTs, EBA supervision applies **unless** the EMT is denominated in a non-euro Member State currency **and** at least **80% of holders and transaction volume** are concentrated in the home Member State — in which case supervision remains with the home NCA *(Article 117(4)–(5))*
- [ ] Own funds increase: the 2% factor in Article 35(1)(b) is raised to **3%** of average reserve assets *(Article 45(5))*
- [ ] Minimum **60%** of reserves (per official currency referenced) must be held as deposits in credit institutions *(Article 45(7)(b))*
- [ ] Remuneration policy, liquidity management policy, and regular liquidity stress testing required *(Article 45(1)–(4))*
- [ ] Token must be available for custody by multiple unaffiliated CASPs on a fair, reasonable and non-discriminatory basis *(Article 45(2))*

> **Separately, for all ARTs (significant or not):** Article 35(3) allows the home NCA to require own funds **up to 20% higher** than the 2%-of-reserve baseline where the risk profile justifies it. This is not significance-specific.

**Reference:** MiCA Article 43 (significance criteria for ARTs), Article 44 (voluntary classification), Article 45 (additional obligations for significant ARTs), Article 56 (significance criteria for EMTs), Article 58 (additional obligations for significant EMTs)

---

### 11.2 — Significant CASP Threshold (Article 85)

Separate from the ART/EMT regime. A CASP is deemed **significant** where it has, in the Union, **at least 15 million active users on average** in one calendar year (average calculated as the daily number of active users over the previous calendar year).

- [ ] **Threshold modelled in business plan** — if user-growth projections cross 15M active users, plan for the additional cooperation and reporting that follows
- [ ] **Notification workflow** — a CASP that reaches the threshold must notify its NCA **within two months**; the NCA, in agreement with EBA, then notifies the College of supervisors

**Consequences:**
- College of supervisors involvement
- Enhanced ongoing reporting and information requests
- Higher NCA / EBA scrutiny

**Reference:** MiCA Article 85 (identification of significant CASPs)

---

## SECTION 12 — TRANSITIONAL PROVISIONS & TIMELINE AWARENESS

*If you are already operating, understand the transitional rules. If you are a new entrant, understand when full enforcement applies.*

---

### 12.1 — Key Dates

| Date | Milestone | Source |
|---|---|---|
| **9 June 2023** | MiCA published in Official Journal (OJ L 150) | — |
| **29 June 2023** | MiCA entered into force (20 days after publication) | Article 149(1) |
| **30 June 2024** | Title III (ARTs) and Title IV (EMTs) apply | Article 149(3) |
| **30 December 2024** | Full MiCA application — Titles I, II, V, VI, VII apply | Article 149(2) |
| **1 July 2026** | Latest end of CASP transitional period — existing providers must be authorised or cease, unless their home Member State has shortened the period | Article 143(3) |

- [ ] If already operating under a national regime — confirm transitional period status with home NCA (Member States may shorten or disapply the transitional regime under Article 143(3))
- [ ] If new entrant — plan for full MiCA compliance from day one (no grandfathering available)
- [ ] Monitor ESMA, EBA, and Commission technical standards publications — Level 2 RTS/ITS and Level 3 guidelines continue to be issued (including the white-paper machine-readable format)

**Reference:** MiCA Article 143 (transitional measures), Article 149 (entry into force and application)

---

## SECTION 13 — ENFORCEMENT, PENALTIES & PRODUCT INTERVENTION

*The maximum exposures are not theoretical — they are mandatory floors that Member States must provide for. Founders should know the magnitudes at intake so they can weight compliance investment appropriately.*

---

### 13.1 — Administrative Penalty Exposure (Article 111)

Member States must give competent authorities the power to impose **at least** the following maximum fines (national law may go higher). The percentage cap is calculated on the legal person's **total annual turnover** per the last approved accounts (or consolidated accounts of the ultimate parent, where applicable).

| Infringement category (Article 111(1)) | Articles in scope | Natural person — max fine | Legal person — flat max | Legal person — turnover cap |
|---|---|---|---|---|
| **(a) Title II — other crypto-assets** | Arts 4–14 | EUR 700,000 | EUR 5,000,000 | **3%** |
| **(b) Title III — ART issuers** | Arts 16, 17, 19, 22, 23, 25, 27–41, 46, 47 | EUR 700,000 | EUR 5,000,000 | **12.5%** |
| **(c) Title IV — EMT issuers** | Arts 48–51, 53–55 | EUR 700,000 | EUR 5,000,000 | **12.5%** |
| **(d) Title V — CASPs** | Arts 59, 60, 64, 65–83 | EUR 700,000 | EUR 5,000,000 | **5%** |
| **(e) Title VI — market abuse: Article 88** (inside information disclosure) | Art 88 | EUR 1,000,000 | EUR 2,500,000 | **2%** |
| **(e) Title VI — market abuse: Articles 89–92** (insider dealing, unlawful disclosure, manipulation, prevention/STORs) | Arts 89–92 | EUR 5,000,000 | EUR 15,000,000 | **15%** |
| **Profit disgorgement — general (a)–(d)** | as above | at least **2×** profits gained / losses avoided, even if higher than the caps above | same | — |
| **Profit disgorgement — market abuse (e)** | Arts 88–92 | at least **3×** profits gained / losses avoided, even if higher than the caps above | same | — |

Plus non-monetary penalties: public statement of infringement (Art 114), cease-and-desist orders, withdrawal of authorisation, **temporary ban** from management functions for the individuals concerned (or **at least a 10-year ban** in case of repeat market abuse offences — Art 111(5)(f)), and a temporary ban from dealing on own account (Art 111(5)(g)).

- [ ] Maximum-exposure quantum understood at executive level — included in the firm's risk appetite statement and D&O insurance scope
- [ ] Whistleblower / reporting-of-infringements mechanism in place *(Article 116)*
- [ ] Awareness that **decisions imposing penalties are published** on the NCA website with the identity of the person sanctioned *(Article 114)*

**Reference:** MiCA Article 111 (administrative penalties), Article 112 (exercise of powers), Article 114 (publication of decisions), Article 116 (whistleblower protection)

---

### 13.2 — Product Intervention Powers (Articles 102–105)

Competent authorities, **ESMA**, and **EBA** all have powers to **prohibit or restrict** the marketing, distribution, or sale of crypto-assets or a related activity. These are tail risks but real — equivalent powers under MiFIR have been used to ban binary options and restrict CFDs.

- [ ] **Host Member State precautionary measures** *(Article 102)* — a host NCA may, after notifying home NCA + ESMA/EBA, take measures to protect investors / market integrity in its territory
- [ ] **ESMA temporary intervention** *(Article 103)* — ESMA may temporarily prohibit or restrict the marketing, distribution, or sale of specified crypto-assets or specified CASP activities Union-wide, where a significant investor-protection concern or threat to orderly functioning / financial stability exists
- [ ] **EBA temporary intervention** *(Article 104)* — equivalent EBA power for ARTs and EMTs
- [ ] **Product intervention by NCA** *(Article 105)* — analogous power at national level for crypto-assets in or from the Member State concerned

> **Founder takeaway:** plan your product so that no single feature is essential if it had to be removed under an intervention order. Cross-border revenue should not depend on continued availability in any one Member State whose NCA might act.

**Reference:** MiCA Articles 102 (host MS precautionary measures), 103 (ESMA), 104 (EBA), 105 (NCA product intervention)

---

## READINESS SCORECARD — SUMMARY

*Use this scorecard to assess your overall readiness. Count completed checkboxes per section.*

| Section | Topic | Items (approx) | Ready? |
|---|---|---|---|
| 1 | MiCA applicability, exclusions & authorisation pathway | 19 | ☐ |
| 2 | Business classification | 14 | ☐ |
| 3 | Entity structure & governance | 14 | ☐ |
| 4 | Financial requirements, capital & crisis plans (ART/EMT) | 25 | ☐ |
| 5 | White paper (incl. ongoing update duty & failed-offer mechanics) | 22 | ☐ |
| 6 | AML/CFT & KYC | 15 | ☐ |
| 7 | Operational, organisational, service-specific & ongoing notifications | 45 | ☐ |
| 8 | ICT, cybersecurity & DORA | 8 | ☐ |
| 9 | Market integrity (incl. STORs) & consumer protection | 14 | ☐ |
| 10 | Application process & dossier | 16 | ☐ |
| 11 | Significance thresholds (ART/EMT + significant CASP) | 9 | ☐ |
| 12 | Transitional provisions | 3 | ☐ |
| 13 | Enforcement, penalties & product intervention | 6 | ☐ |

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

*Document version: 2.3 | Last updated: May 2026*
*Changes in v2.3 (final verification pass against local-copy mica.html, full text of Regulation (EU) 2023/1114, OJ L 150, 9 June 2023): cross-checked 85+ specific claims (article numbers, monetary amounts, percentages, time periods, subsection mappings) against verbatim regulation text. All passed except one missing detail: added Article 49(6) "redemption of e-money tokens shall not be subject to a fee" (parallel to Article 39(3) for ARTs) — Section 4.3 EMT bullets expanded.*
*Changes in v2.2: rebuilt Section 1.2 against Article 2 with full exclusion list and a clarified decentralisation note distinguishing Title II–IV (issuance) carve-outs from continuing Title V (CASP) coverage; updated Section 6.1 to the 2024 EU AML Package (Reg 2024/1624 AMLR, Dir 2024/1640 AMLD6, Reg 2024/1620 AMLA Regulation) with transitional planning to the current AMLD4/5 regime until July 2027.*
*Changes in v2.0: corrected CASP capital class table against Annex IV; corrected ICT citations to Articles 34(10) and 68(7)–(8); corrected 30%/60% bank-deposit rule scope (ARTs, not EMTs); corrected significance criteria table against Article 43(1); added missing requirements (Articles 10, 12, 22, 23, 39, 41–42, 46, 47, 55, 60, 65, 69, 73, 75–85, 88, 92, 102–105, 111).*
*Changes in v2.1 (second-pass corrections): (i) corrected Article 39 redemption rule — no fee on normal redemption, only under recovery plan (Art 46); (ii) corrected Article 75 custody — removed incorrect "with consent" carve-out, anchored to Article 70(1); (iii) corrected Article 76 trading platform bullets to track the regulation verbatim; (iv) reframed insider lists / personal dealing as best practice / Art 72 controls — not MiCA Level 1 obligations; (v) rebuilt Article 111 penalty table to match the actual percentage tiers (3% / 5% / 12.5% / 2% / 15%) and disgorgement multipliers (2× general, 3× market abuse); (vi) added Article 117 EMT supervision derogation; (vii) added Article 81(14) portfolio-management quarterly statements and inducement restrictions; (viii) added Article 60(10) carve-out (no Annex IV / Arts 62–64, 67, 83–84 for financial-entity CASPs).*
*Regulation reference: Regulation (EU) 2023/1114 of the European Parliament and of the Council of 31 May 2023 on markets in crypto-assets (MiCA), as published in OJ L 150, 9 June 2023.*
