# MiFID II Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for New Investment Firms Entering the EU Market

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU Markets in Financial Instruments Directive II (MiFID II) — Directive 2014/65/EU + MiFIR Regulation (EU) 600/2014
**Source:** https://eur-lex.europa.eu/eli/dir/2014/65/oj
**Status:** In force since 3 January 2018 — amended by MiFID III review (Directive (EU) 2024/790 + Regulation (EU) 2024/791), phased rollout through 2026
**Document type:** Pre-engagement readiness assessment — to be completed before formal NCA authorization application

---

> **Who this document is for:** Founders, entrepreneurs, and executive teams approaching legal counsel for the first time to determine whether their planned investment-services business — including RWA / tokenized-securities platforms, DLT MTFs, brokerages, advisory firms, and trading venues — can legally operate in the European Union under MiFID II. This checklist mirrors the intake assessment a specialist EU financial-services lawyer would walk you through in a first advisory session.

---

> **How to use this checklist:** Work through each section in order. Every item marked with a checkbox (☐) represents a concrete requirement or decision you must resolve. Items you cannot check off represent gaps that must be closed before you file an NCA application. Your legal advisor will use your responses to this checklist to scope the engagement, estimate timeline, and identify deal-breakers early.

> **MiFID II vs. MiCA — the boundary question:** MiFID II and MiCA are mutually exclusive at the token level (MiCA Article 2(4)). If your token is a *financial instrument* (transferable security, derivative, fund unit), MiFID II applies — not MiCA. If your token references value without conferring ownership or claim, MiCA applies. This classification decision is the foundation of your entire compliance architecture. Get it wrong and your offering document, infrastructure path, and licensing regime are all wrong.

---

## SECTION 1 — DO YOU NEED MIFID II AUTHORIZATION?

*This is the first question any legal advisor will ask. MiFID II catches a much broader set of activities than people expect — not just stockbrokers and exchanges. Any firm dealing in, advising on, or arranging transactions in financial instruments needs to consider it.*

---

### 1.1 — Territorial Scope: Does MiFID II Apply to You?

Answer each question. If any answer is **Yes**, MiFID II likely applies.

- [ ] Are you providing investment services or performing investment activities (Annex I Section A) on a professional basis within the EU?
- [ ] Are you dealing in, advising on, or arranging transactions in *financial instruments* (Annex I Section C) for EU-resident clients?
- [ ] Are you operating — or planning to operate — a trading venue (Regulated Market, MTF, or OTF) within the EU?
- [ ] Are you tokenizing securities (RWA, STO, tokenized bonds/equity/funds) on DLT and offering them to EU investors?
- [ ] Is your business entity registered or incorporated in an EU/EEA Member State?
- [ ] Are you marketing or actively soliciting EU-resident investors, even if your entity is based outside the EU?

> **Legal advisor note:** MiFID II applies to investment services *provided in the Union*, regardless of where the firm is incorporated. **Article 39 is permissive at Member State level** — *"A Member State may require that a third-country firm … establish a branch in that Member State"* — so the branch requirement for third-country firms serving EU retail or elective-professional clients depends on the host Member State exercising that option. Several major Member States do; others rely on national equivalence regimes. Where a branch is required, the Article 39–43 conditions apply. Reverse solicitation is the narrow defense if no branch / equivalence regime is in place — fact-specific and increasingly scrutinized by NCAs (ESMA's 2021 public statement materially tightened the interpretation). Do not assume reverse solicitation covers your business without formal legal advice.

**Reference:** MiFID II Article 1 (Subject matter), Article 4 (Definitions), Articles 39–43 (Third-country firms)

---

### 1.2 — Exclusion Check: Is Your Business Outside MiFID II's Scope?

MiFID II does **not** apply to the following (Article 2). Check any that describe your business:

- [ ] You are an insurance or reinsurance undertaking (regulated under Solvency II)
- [ ] You provide investment services exclusively to your parent / subsidiaries / other group entities
- [ ] You provide investment services only incidentally in the course of professional activity regulated by separate legal/regulatory rules (e.g., lawyers, accountants — narrow)
- [ ] You deal on own account in financial instruments *other than* commodity derivatives, emission allowances, or derivatives thereof, AND do not provide other investment services or operate an organised trading facility, AND are not a high-frequency algorithmic trader
- [ ] You are a collective investment undertaking, AIF, pension fund, or their depositaries / managers (regulated under UCITS / AIFMD / IORP II)
- [ ] You are an ECB, central bank, or other public body managing public debt or foreign reserves
- [ ] Your activity is ancillary to your main business and consists solely of dealing on own account in commodity derivatives / emission allowances (subject to the ancillary activity test — quantitatively defined in Commission Delegated Regulation 2021/1833)

> **Legal advisor note:** The "ancillary activity" exemption is the single most-tested exclusion in commodity-derivative markets. The quantitative thresholds (trading-activity and capital-employed tests) must be re-run annually. If you exceed them, MiFID II authorization is required and there is no transitional grace period.

> **Crypto / RWA boundary:** If your token is a financial instrument under Article 4(1)(15) (i.e., it falls within Annex I Section C), MiFID II applies and MiCA does **not** (MiCA Article 2(4) carve-out). Ownership-conferring tokens — fractional real estate, tokenized bonds/equity, revenue-share claims — are transferable securities (Section C(1)) regardless of whether yield is distributed. The DLT Pilot Regime (Regulation (EU) 2022/858) is the dedicated infrastructure path for trading and settling these — not MiCA's CASP regime.

**Reference:** MiFID II Article 2 (Exemptions), Article 3 (Optional exemptions), Article 4(1)(15) (financial instrument definition), Annex I Section C (financial instruments)

---

## SECTION 2 — WHAT TYPE OF INVESTMENT FIRM ARE YOU?

*MiFID II authorization is service-scoped. The specific Annex I Section A services and Section C financial instruments you intend to cover determine your authorization scope, your capital class, and your ongoing obligations. Pick the wrong scope at application and you will need a full variation procedure later.*

---

### 2.1 — Investment Services Classification (Annex I, Section A)

Tick every service you intend to provide. Each adds to your authorization scope:

- [ ] **(A1) Reception and transmission of orders** in relation to one or more financial instruments
- [ ] **(A2) Execution of orders** on behalf of clients
- [ ] **(A3) Dealing on own account** (proprietary trading)
- [ ] **(A4) Portfolio management** (discretionary management on a client-by-client basis)
- [ ] **(A5) Investment advice** (personalised recommendations on financial instruments)
- [ ] **(A6) Underwriting / placing on a firm-commitment basis**
- [ ] **(A7) Placing without firm commitment** (best-efforts distribution)
- [ ] **(A8) Operation of an MTF** (Multilateral Trading Facility)
- [ ] **(A9) Operation of an OTF** (Organised Trading Facility — non-equities only: bonds, structured finance, emission allowances, derivatives)

**Ancillary services (Annex I, Section B) — only available if at least one Section A service is authorized:**

- [ ] (B1) Safekeeping and administration of financial instruments (custody)
- [ ] (B2) Granting credits or loans to investors for transactions in financial instruments (margin lending)
- [ ] (B3) Advice on capital structure, M&A, corporate finance
- [ ] (B4) FX services connected to investment services
- [ ] (B5) Investment research and financial analysis
- [ ] (B6) Services related to underwriting

---

### 2.2 — Financial Instruments Scope (Annex I, Section C)

Tick every instrument category you intend to deal in. This determines product-specific obligations (MAR, EMIR, SFTR, position-limits regime, etc.):

- [ ] (C1) Transferable securities (shares, bonds, depositary receipts, tokenized equity/debt)
- [ ] (C2) Money-market instruments
- [ ] (C3) Units in collective investment undertakings (UCITS, AIF units)
- [ ] (C4) Options, futures, swaps, FRAs on securities, currencies, rates, emission allowances
- [ ] (C5) Commodity derivatives — cash-settled
- [ ] (C6) Commodity derivatives — physically settled, traded on RM / MTF / OTF (except certain wholesale energy products)
- [ ] (C7) Commodity derivatives — physically settled, not for commercial purposes, with characteristics of derivatives
- [ ] (C8) Credit derivatives (credit risk transfer instruments)
- [ ] (C9) Financial contracts for differences (CFDs)
- [ ] (C10) Derivatives on climatic / freight / inflation / economic statistics
- [ ] (C11) Emission allowances (EU ETS units)

> **Tokenized securities specifically:** A token that confers ownership in, or a claim against, an issuer or underlying asset is a transferable security under C(1) — full stop. The form (paper vs. DLT) does not change the classification. The Prospectus Regulation (Regulation (EU) 2017/1129) applies to public offers; the DLT Pilot Regime applies to trading and settlement infrastructure. Plan for both, not just MiFID II.

---

### 2.3 — Trading Venue Type (if operating one)

If you tick A8 or A9 above, classify your venue precisely:

#### ☐ Multilateral Trading Facility (MTF)
- Multilateral system bringing together multiple third-party buying and selling interests
- **Non-discretionary** rules for order execution
- Cannot execute client orders against own proprietary capital
- Cannot engage in matched principal trading
- May cover equity *and* non-equity instruments
- Three or more materially active members required *(Article 18(7))*

#### ☐ Organised Trading Facility (OTF)
- Multilateral system for **non-equities only** (bonds, structured finance products, emission allowances, derivatives)
- **Discretionary** execution (operator decides whether/when/how to match)
- May engage in matched principal trading **with client consent** (except for derivatives subject to the EMIR clearing obligation)
- Dealing on own account permitted **only** for sovereign debt with no liquid market
- Cannot be combined with a Systematic Internaliser in the same legal entity
- Three or more materially active members required *(Article 18(7))*

#### ☐ Systematic Internaliser (SI) — separate regime, not an A8/A9 service
- Investment firm that, on an organised, frequent, systematic and substantial basis, deals on own account when executing client orders outside a trading venue
- Falls under SI quantitative thresholds (Commission Delegated Regulation 2017/565) — assessed quarterly
- Pre-trade quoting obligations under MiFIR Articles 14–23

#### ☐ DLT MTF / DLT SS / DLT TSS (DLT Pilot Regime — Regulation (EU) 2022/858)
- Dedicated regime for trading and settlement of DLT-based financial instruments
- Limited to specific instrument types and issuance caps
- Requires specific authorization under the Pilot Regime in addition to MiFID II authorization
- 10+ applications pending across the EU as of 2026 (Securitize/Spain, 21X/Germany, et al.)

**Reference:** MiFID II Annex I Sections A–C, Article 4(1)(22)–(23) (MTF / OTF definitions), Articles 18–20 (MTF/OTF trading), DLT Pilot Regime Regulation (EU) 2022/858

---

## SECTION 3 — ENTITY STRUCTURE & EU PRESENCE

*MiFID II requires a physical, legal presence in the EU. There are no exceptions for remote or offshore-only operations. The "head office in the same Member State as registered office" rule rules out brass-plate structures.*

---

### 3.1 — Legal Entity Requirements

- [ ] **EU legal entity established:** Your business must be a legal person incorporated in an EU/EEA Member State, OR a natural person providing services subject to specific national-law conditions (Article 4(1)(1))
- [ ] **Registered office and head office in the same Member State:** Article 5(4) requires both to be in the home Member State — a registered office in one state and effective management in another is not permitted for investment firms
- [ ] **Home Member State selected:** You have identified the specific EU Member State where you will apply for authorization (this becomes your "home NCA" and the source of your EU passport)
- [ ] **Effective place of management in the EU:** At least the core directing mind of the business must be genuinely located in the home Member State

> **Legal advisor note:** Choice of home Member State matters significantly. France (AMF), Germany (BaFin), Netherlands (AFM), Ireland (CBI), Luxembourg (CSSF), and Lithuania (Bank of Lithuania) all have active investment-firm authorization teams with different processing speeds, secondary requirements, and sector specialisations. For DLT MTF / tokenized-securities use cases, Luxembourg, Germany, and Spain currently lead on Pilot Regime engagement. Your legal advisor will help you evaluate the optimal jurisdiction based on your service mix, target investor base, and operational footprint.

**Reference:** MiFID II Article 5 (Authorization requirement), Article 5(4) (Head office co-location)

---

### 3.2 — Governance & Management ("Fit and Proper")

MiFID II Article 9 requires all members of the management body and persons effectively directing the business to pass a "fit and proper" assessment by the NCA.

- [ ] **At least two natural persons** effectively directing the business — the "four-eyes" principle is mandatory for investment firms
- [ ] **Management body members identified** — each must demonstrate:
  - [ ] Sufficient knowledge, skills, and experience individually and collectively
  - [ ] Good repute — no criminal convictions for financial crimes, fraud, money laundering, or terrorist financing
  - [ ] Sufficient time commitment (with directorship-limit rules in Article 9(2) for significant firms)
  - [ ] No conflicts of interest impairing independent judgment
  - [ ] Diversity policy for the management body where the firm is significant in size, internal organisation, and complexity (Article 9(1))
- [ ] **Qualifying shareholders identified** (≥10% of capital or voting rights):
  - [ ] Each must demonstrate suitability to the NCA (Article 10)
  - [ ] No criminal history in financial crime, fraud, or AML offenses
  - [ ] Financial soundness demonstrated
  - [ ] Source of funds verified
- [ ] **Nomination, risk, and remuneration committees** established where the firm is significant (Article 9(2))
- [ ] **CVs, professional references, and background documentation** prepared for all directors, officers, and qualifying shareholders — NCAs will verify these independently and may consult home-state criminal records

**Reference:** MiFID II Articles 9 (Management body), 10 (Qualifying holdings), 11 (Notification of acquisitions), 13 (Risk-management committees)

---

## SECTION 4 — FINANCIAL REQUIREMENTS & CAPITAL

*MiFID II Article 15 requires investment firms to hold sufficient initial capital. Since 26 June 2021, the prudential regime for investment firms (other than Class 1 firms treated as credit institutions) is set by the **Investment Firms Regulation / Directive (IFR/IFD)** — Regulation (EU) 2019/2033 and Directive (EU) 2019/2034. The capital thresholds below come from IFD Article 9.*

---

### 4.1 — Initial Capital Requirements (IFD Article 9)

Initial capital is determined by the **services authorized** AND **whether the firm holds client money or securities**.

| Tier | Services / Conditions | Initial Capital |
|---|---|---|
| **€75,000** | Investment firms authorized **only** for any combination of: RTO (A1), execution of orders (A2), portfolio management (A4), investment advice (A5), placing without firm commitment (A7) — AND **not permitted to hold client money or securities belonging to clients** *(IFD Article 9(2))* | **€75,000** |
| **€150,000** | Investment firms authorized for the same A1 / A2 / A4 / A5 / A7 services **but permitted to hold client money or securities belonging to clients** — practically this includes any firm offering custody (B1) *(IFD Article 9(3))* | **€150,000** |
| **€750,000** | Investment firms authorized for dealing on own account (A3), underwriting / placing on firm commitment (A6), operation of an MTF (A8), or operation of an OTF (A9) *(IFD Article 9(1))* | **€750,000** |

> **Common error #1:** placing **without** firm commitment (A7) is **not** in the €750k bracket. Only placing on a **firm-commitment** basis (A6) triggers €750k.

> **Common error #2:** simply providing investment advice (A5) does not trigger €150k or €750k. The €150k threshold is triggered by *holding client money or securities*. The €750k threshold is triggered by *dealing on own account, firm-commitment underwriting, or operating a multilateral venue*.

> **Class 1 (treated as credit institutions):** Investment firms dealing on own account or underwriting on a firm-commitment basis whose total consolidated assets exceed **€30 billion** are reclassified as credit institutions and must seek authorization under CRD/CRR (Regulation (EU) 575/2013) instead — directly supervised by the ECB under the SSM. Plan for this if your business plan crosses the threshold within the authorization horizon.

**Additional ongoing requirement (IFR Article 11):** Own funds must be the **highest** of:
- The initial capital threshold above (permanent minimum requirement)
- The **fixed overhead requirement (FOR)** — one quarter of fixed overheads of the preceding year
- The **K-factor requirement** — sum of risk-to-client (RtC), risk-to-market (RtM), and risk-to-firm (RtF) K-factors specific to the firm's activities (IFR Articles 15–34)

- [ ] Initial capital amount confirmed against the IFD Article 9 tier matching your authorized services
- [ ] Capital available and demonstrable via audited accounts or bank statements
- [ ] Source of funds documented and legitimate (NCA will scrutinize this — particularly for crypto-founder-funded firms)
- [ ] Ongoing K-factor and FOR calculations modelled in your 3-year financial plan (own funds must be maintained continuously, not just at authorization)
- [ ] Liquidity requirement (IFR Article 43): liquid assets equivalent to at least **one third of the fixed overhead requirement** held at all times
- [ ] Concentration risk monitoring framework in place (IFR Articles 35–42)

---

### 4.2 — Small and Non-Interconnected Firms ("Class 3" under IFR)

If your firm meets all the criteria in **IFR Article 12(1)** — including AUM < €1.2bn, client orders handled < €100m/day (cash) or €1bn/day (derivatives), no permission to hold client money/securities, etc. — you qualify for the simplified Class 3 regime:

- [ ] Assessed Article 12(1) criteria against business plan
- [ ] If Class 3: own funds = higher of permanent minimum requirement and FOR (no K-factor calculation required)
- [ ] If Class 3: simplified liquidity, reporting, and disclosure regime applies
- [ ] Monitoring plan in place to detect when firm crosses thresholds into Class 2 (recalibration triggered)

**Reference:** IFR — Regulation (EU) 2019/2033; IFD — Directive (EU) 2019/2034 (Article 9 initial capital, Article 12 Class 3 criteria, Articles 15–34 K-factors, Article 43 liquidity); MiFID II Article 15 (cross-reference)

---

## SECTION 5 — PRE-CONTRACTUAL DISCLOSURES & CLIENT DOCUMENTATION

*Unlike MiCA, MiFID II does not require a single "white paper" document. Instead, it imposes a layered set of pre-contractual disclosures — and on top of those, the Prospectus Regulation applies to any public offer of transferable securities, and the PRIIPs KID applies to packaged retail investment products.*

---

### 5.1 — Client Categorization (Annex II)

Before any service is provided, every client must be categorized — categorization drives the entire conduct-of-business regime applied to that client.

- [ ] **Categorization framework documented** distinguishing:
  - [ ] **Retail clients** — highest level of protection; full suitability/appropriateness, full disclosures, MAR/PRIIPs apply
  - [ ] **Professional clients per se** (Annex II Section I) — credit institutions, investment firms, insurers, funds, large undertakings (meeting 2 of: balance sheet €20m / turnover €40m / own funds €2m), governments, central banks, supranationals
  - [ ] **Professional clients on request** (Annex II Section II) — opt-up requires written request, NCA-prescribed warning, two of three knowledge/experience criteria met (10+ transactions/quarter for 4 quarters, portfolio > €500k, ≥1 year financial-sector professional experience)
  - [ ] **Eligible counterparties** (Article 30) — narrowest scope, mainly inter-firm dealings between regulated entities
- [ ] **Opt-up and opt-down procedures** documented in writing
- [ ] **Periodic re-categorization review** scheduled (clients can drift across tiers)

---

### 5.2 — Pre-Trade Disclosures to Clients (Article 24)

Provide in good time before each client is bound:

- [ ] **Firm and service description** — identity, regulatory status, authorized services, languages, contact channels
- [ ] **Financial instrument description** — nature, risks (general and instrument-specific), target market category, costs structure
- [ ] **Costs and charges disclosure** — ex-ante and ex-post, **aggregated and itemised on request**, expressed in monetary and percentage terms, including third-party payments and cumulative effect on return *(Article 24(4))*
- [ ] **Inducements disclosure** — any third-party fees / commissions / non-monetary benefits received in connection with a service must be disclosed; design must enhance quality of service to client AND not impair duty to act in client's best interests *(Article 24(9))*
- [ ] **Investment advice — independence status** declared (independent vs. non-independent) — independent advice **prohibits retention of inducements** *(Article 24(7))*
- [ ] **Portfolio management — inducement prohibition** — no retention of third-party inducements when providing discretionary management *(Article 24(8))*
- [ ] **Execution venue / best execution policy** — summary of execution policy provided; top-five execution venues per asset class published annually under RTS 28 (status under MiFID III review — confirm current requirement)

---

### 5.3 — Suitability & Appropriateness (Article 25)

- [ ] **Suitability assessment (advice + portfolio management)** — collect client knowledge / experience, financial situation including ability to bear losses, investment objectives including risk tolerance; recommend only suitable instruments
- [ ] **Suitability report** — provided to retail clients before transaction, explaining advice and how it meets client's preferences/objectives
- [ ] **Appropriateness assessment (other services in complex instruments)** — collect knowledge / experience; warn if not appropriate or if client provides insufficient information
- [ ] **Execution-only exception** — limited to non-complex instruments and only where the client initiates the service and is warned no appropriateness assessment is performed *(Article 25(4))*
- [ ] **Knowledge and competence** of staff giving advice / information — demonstrable, with NCA-published criteria (ESMA Guidelines on knowledge and competence)
- [ ] **Recording of telephone conversations and electronic communications** for orders and dealing on own account — minimum **5-year retention** (extendable to 7 years on NCA request) *(Article 16(7))*

---

### 5.4 — Product Governance (Article 16(3) + Article 24(2))

If you manufacture or distribute financial instruments:

- [ ] **Target market identification** — every product has a defined target market of end-clients; distribution strategy is consistent with it
- [ ] **Negative target market** identification — clients for whom the product is **not** suitable
- [ ] **Product approval process** — new products and significant adaptations go through documented approval before launch
- [ ] **Regular product review** — products are reviewed against target market on an ongoing basis
- [ ] **Manufacturer-to-distributor information flow** — manufacturers provide distributors with all relevant target-market and product information

---

### 5.5 — Parallel Disclosure Regimes (Cross-Reference)

MiFID II disclosures sit alongside several other EU disclosure regimes — verify which apply:

- [ ] **Prospectus** (Regulation (EU) 2017/1129) — required for public offers of transferable securities to EU investors, subject to exemptions (offer < €1m EU-wide, offer to <150 persons per Member State, qualified-investors-only, denominations ≥€100k)
- [ ] **PRIIPs KID** (Regulation (EU) 1286/2014) — 3-page Key Information Document for packaged retail investment products sold to retail clients (covers structured products, derivatives, certain funds, with-profits insurance investment)
- [ ] **UCITS KIID / KID** — for UCITS funds distributed to retail
- [ ] **MAR ad-hoc disclosure** (Regulation (EU) 596/2014) — issuers of instruments admitted to trading must disclose inside information without delay

> **Legal advisor note:** A tokenized-bond issuance launched to EU retail will typically need a **Prospectus** (or rely on an exemption), a **PRIIPs KID** (if classified as PRIIP), **MiFID II costs and charges + suitability disclosures** at the point of sale, and ongoing **MAR disclosure** post-admission. The MiFID II "white paper equivalent" is the prospectus, not a marketing document. Building this disclosure stack is typically 2–4 months of work with specialist counsel.

**Reference:** MiFID II Articles 24 (Information to clients), 25 (Suitability/appropriateness), 16(3)/16(7) (Product governance, recording), 30 (Eligible counterparties), Annex II (Client categorisation); Prospectus Regulation (EU) 2017/1129; PRIIPs Regulation (EU) 1286/2014

---

## SECTION 6 — AML/CFT & KYC FRAMEWORK

*MiFID II and the EU's Anti-Money Laundering framework operate in tandem. No NCA will authorize an investment firm without a robust AML/CFT compliance program. The horizontal AML obligations are identical to those for CASPs under MiCA — the same NCAs apply them across regimes.*

---

### 6.1 — Anti-Money Laundering Requirements

- [ ] **AML/CFT compliance program** drafted and documented, covering:
  - [ ] Customer Due Diligence (CDD) procedures — standard, simplified, and enhanced
  - [ ] Know Your Customer (KYC) onboarding workflows for natural persons and legal entities
  - [ ] Know Your Business (KYB) procedures for corporate / institutional clients
  - [ ] Ongoing transaction monitoring — automated and manual
  - [ ] Suspicious Activity Reporting (SAR) procedures and designated reporting officer
  - [ ] Record-keeping policies (minimum 5-year retention)
  - [ ] Sanctions screening against EU, UN, OFAC, and other relevant lists
  - [ ] PEP (Politically Exposed Persons) screening and enhanced due diligence
- [ ] **Money Laundering Reporting Officer (MLRO)** appointed — must be senior management, EU-based
- [ ] **AML risk assessment** completed for the business — documenting customer risk, product risk, geographic risk, delivery channel risk
- [ ] **Staff training program** on AML/CFT obligations documented and scheduled
- [ ] **Source-of-funds and source-of-wealth verification** procedures for high-value or high-risk clients

> **Legal advisor note:** The EU's new Anti-Money Laundering Authority (AMLA) was established by Regulation (EU) 2024/1620 and is headquartered in Frankfurt. AMLA begins exercising its powers from 1 July 2025 and is scheduled to commence **direct supervision of selected high-risk obliged entities from 1 January 2028** (selection process during 2027). NCAs remain the primary AML supervisor until then — but the AML rulebook (Regulation (EU) 2024/1624 + Directive (EU) 2024/1640) tightens substantially from 2027. Your AML framework must be NCA-audit-ready from day one. AML deficiencies remain the single most common reason for MiFID II authorization delays, refusals, and post-authorization enforcement.

> **Note on Travel Rule:** The Transfer of Funds Regulation (Regulation (EU) 2023/1113 — "TFR") imposes the Travel Rule on **crypto-asset service providers**, not on MiFID II investment firms in respect of financial-instrument transactions. If your tokenized-securities platform is MiFID-authorized but does **not** also operate a CASP business, TFR does not apply to your MiFID-classified token transfers — they are not crypto-asset transfers under MiCA Article 3(5). Confirm this with counsel before assuming TFR coverage.

**Reference:** EU AML Directive 6 (AMLD6) and the AML Package (Regulation (EU) 2024/1624, Directive (EU) 2024/1640, Regulation (EU) 2024/1620 establishing AMLA); MiFID II Article 9(3) (AML obligations within management body remit)

---

## SECTION 7 — OPERATIONAL & ORGANIZATIONAL REQUIREMENTS

*MiFID II Article 16 lays down the organisational backbone of every investment firm. These obligations are not optional and apply continuously — they are tested by NCAs at authorization and re-tested at every supervisory inspection.*

---

### 7.1 — Organisational Policies (Must Have Before Application)

- [ ] **Business plan** — detailed 3-year plan covering revenue model, target client base, planned services, staffing, technology architecture, and financial forecasts (with K-factor and FOR projections)
- [ ] **Organisational chart** — clear reporting lines, identification of all key functions (compliance, risk, internal audit, IT, operations)
- [ ] **Three lines of defence model** — business, risk/compliance, internal audit
- [ ] **Compliance function** — independent, with permanent access to all information, reporting to management body (Article 16(2))
- [ ] **Risk management function** — independent where proportionate, dedicated risk committee for significant firms (Article 16(5) / Article 13)
- [ ] **Internal audit function** — independent, with direct reporting line to management body
- [ ] **Conflict of interest policy** (Article 23) — identifying, preventing, managing, and disclosing conflicts across all business functions and personal interests of management; inducements disclosed
- [ ] **Outsourcing policy** — if any critical functions are outsourced, documented oversight, audit rights, and exit arrangements; cannot outsource senior management responsibility (Article 16(5))
- [ ] **Personal account dealing policy** — restrictions on personal trading by staff with access to inside information
- [ ] **Complaints handling procedure** — formal process aligned with ESMA / EBA Joint Committee guidelines
- [ ] **Marketing and communications policy** — all communications fair, clear, not misleading; marketing identifiable as such (Article 24(3))
- [ ] **Record-keeping policy** — minimum 5-year retention for all services, transactions, orders, and client interactions; 7 years extendable on NCA request

---

### 7.2 — Best Execution (Article 27)

If you execute orders on behalf of clients (A2) or transmit orders for execution (A1):

- [ ] **Order Execution Policy** — written policy covering relative importance of price, costs, speed, likelihood of execution and settlement, size, nature, or any other consideration (and for retail clients, total consideration is the determining factor)
- [ ] **Execution venue selection** — venues chosen on objective criteria; rationale documented
- [ ] **Client consent to execution policy** — obtained before service begins; **express consent** required for execution outside trading venues
- [ ] **Order Handling rules** (Article 28) — prompt, fair, and expeditious execution; aggregation only where unlikely to disadvantage clients
- [ ] **Top-5 venue reporting (RTS 28)** — annual publication of top-five execution venues per class of financial instrument and quality of execution — *check current status under MiFIR review*
- [ ] **Best execution monitoring** — regular monitoring of execution quality; policy updated where material changes affect ability to obtain best result

---

### 7.3 — Algorithmic Trading & DEA (Article 17)

If your firm engages in algorithmic trading or provides direct electronic access:

- [ ] **Algo trading framework** — effective systems and risk controls ensuring resilience, capacity, trading thresholds, prevention of erroneous orders
- [ ] **Notification to home NCA and venue** — algo trading firms must notify both
- [ ] **High-frequency algorithmic trading (HFT) records** — store accurate, time-sequenced records of all placed orders, cancellations, executed orders, and quotations in approved form
- [ ] **Market-making strategy obligations** — if algo trading pursues a market-making strategy, binding written agreement with venue required (Article 17(3))
- [ ] **Direct Electronic Access (DEA) controls** — client suitability assessment, pre-set trading and credit thresholds, monitoring, binding written agreement with client (Article 17(5))

---

### 7.4 — Client Asset Safeguarding (Article 16(8)–(10))

If you hold client financial instruments or funds:

- [ ] **Client asset segregation** — client assets segregated from firm's own assets at all times
- [ ] **Custody arrangements** — sub-custodian due diligence, written agreement, periodic review (Commission Delegated Directive 2017/593)
- [ ] **Insolvency protection** — client assets must be insolvency-remote
- [ ] **No use of client financial instruments for own account** without express client consent (Article 16(8))
- [ ] **No use of client funds for own account** except for credit institutions (Article 16(9))
- [ ] **Title transfer collateral arrangements prohibited with retail clients** (Article 16(10))
- [ ] **Client funds placement** — held at credit institution, central bank, qualifying money market fund, or similar; subject to diversification (CDD 2017/593)
- [ ] **Annual external audit report** on client asset arrangements provided to NCA (CASS-equivalent)

---

### 7.5 — Recording of Communications (Article 16(7))

- [ ] **Telephone recording** — all communications relating to (or intended to result in) dealing on own account and client order services (RTO, execution) must be recorded
- [ ] **Electronic communications recording** — emails, chats, messaging applications used for the same purpose must be recorded
- [ ] **Client notification** — new and existing clients notified once before services provided
- [ ] **No service by un-notified telephone channel** — services cannot be provided over telephone channels the client has not been notified about
- [ ] **5-year retention minimum**, extendable to **7 years** on NCA request
- [ ] **Privately-owned device controls** — reasonable steps to prevent staff from using untracked personal channels for relevant communications

**Reference:** MiFID II Articles 16 (Organisational requirements), 17 (Algo trading), 23 (Conflicts of interest), 27 (Best execution), 28 (Order handling); Commission Delegated Regulation (EU) 2017/565 (organisational and conduct conditions); Commission Delegated Directive (EU) 2017/593 (client assets)

---

## SECTION 8 — ICT & OPERATIONAL SECURITY (MiFID II Article 16(5) + DORA Reg. 2022/2554)

*MiFID II Article 16(5) requires sound security mechanisms, internal control, and effective procedures for risk assessment and information processing. **DORA (Regulation (EU) 2022/2554) became applicable on 17 January 2025** and now sets the ICT-resilience standard for all MiFID-authorized investment firms — this is one regulatory process supervised by the NCA, not two.*

---

### 8.1 — ICT & Cybersecurity Readiness

- [ ] **ICT risk management framework** documented — covering identification, assessment, mitigation, and monitoring of all ICT risks
- [ ] **Business continuity plan (BCP)** — documented procedures for maintaining critical operations during technology disruptions, cyberattacks, or infrastructure failures
- [ ] **Disaster recovery plan (DRP)** — specific recovery time objectives (RTOs) and recovery point objectives (RPOs) for all critical systems
- [ ] **ICT incident detection, classification, and reporting** — capability to report major ICT-related incidents and significant cyber threats to the NCA within DORA timelines (initial, intermediate, final reports)
- [ ] **Digital operational resilience testing program** — basic resilience testing annually; **threat-led penetration testing (TLPT)** every 3 years for firms identified by competent authorities under Article 26
- [ ] **ICT third-party risk management** — contractual provisions including audit rights, sub-contracting controls, exit strategies, and termination rights (DORA Articles 28–30); register of all ICT third-party arrangements maintained
- [ ] **Critical ICT third-party providers (CTPP)** — awareness of which of your vendors may be designated as Critical Third-Party Providers under DORA Article 31 (cloud, blockchain infra, oracle providers — direct oversight by ESAs)
- [ ] **Data protection (GDPR)** — Regulation (EU) 2016/679 compliance across all personal data processing; DPIAs where required *(GDPR is an independent horizontal EU obligation — applies regardless of MiFID II or DORA — but NCAs expect it as part of operational readiness)*
- [ ] **For DLT MTF / DLT SS operators:** smart contract security audits with independent third-party review and remediation of material findings before deployment; on-chain identity registry integration; key management and custody architecture documented

**Reference:** MiFID II Article 16(5) (Security mechanisms); DORA — Regulation (EU) 2022/2554, Articles 5–16 (ICT risk management), Articles 17–23 (incident reporting), Articles 24–27 (resilience testing), Articles 28–44 (third-party risk)

---

## SECTION 9 — MARKET INTEGRITY & CONSUMER PROTECTION

*MiFID II is the conduct-of-business backbone, but it operates in tandem with the Market Abuse Regulation (MAR — Regulation (EU) 596/2014) and MiFIR transparency rules. Together these define the market-integrity envelope every investment firm must operate within.*

---

### 9.1 — Market Abuse Prevention (MAR — Regulation (EU) 596/2014)

- [ ] **Insider dealing policy** — prohibition on dealing on inside information; insider lists maintained
- [ ] **Market manipulation policy** — prohibition on wash trading, spoofing, layering, marking the close, pump-and-dump, dissemination of false or misleading information
- [ ] **Inside information disclosure** — issuers must disclose inside information as soon as possible; delayed disclosure procedures documented
- [ ] **Insider lists** — permanent and event-based lists maintained in ESMA-prescribed format
- [ ] **Personal Account Dealing rules** — closed periods, pre-clearance, post-trade disclosure for persons discharging managerial responsibilities (PDMRs) and persons closely associated
- [ ] **Suspicious Transaction and Order Reporting (STOR)** — system in place to detect, investigate, and report to the NCA
- [ ] **Market surveillance systems** — if operating a trading venue: order book surveillance covering insider dealing, manipulation, and disorderly trading

---

### 9.2 — Pre- and Post-Trade Transparency (MiFIR — Regulation (EU) 600/2014)

- [ ] **Pre-trade transparency** obligations identified for each instrument class traded (equity, equity-like, non-equity)
- [ ] **Post-trade transparency** obligations identified (trade publication timelines vary by instrument and venue type)
- [ ] **Transaction reporting (MiFIR Article 26)** — T+1 transaction reports to NCA via ARM, including 65+ data fields per transaction
- [ ] **Reference data reporting (MiFIR Article 27)** — instrument reference data submitted to NCA
- [ ] **Systematic Internaliser quoting** — pre-trade quotes published where SI thresholds met

---

### 9.3 — Consumer Protection Obligations

- [ ] **Conduct of business rules** — honest, fair, professional dealing in clients' best interests (Article 24(1))
- [ ] **Information fair, clear, and not misleading** — including marketing communications
- [ ] **Cross-selling rules** — separability of bundled products disclosed to clients (Article 24(11))
- [ ] **Remuneration structures** — must not conflict with duty to act in clients' best interests; no sales incentives that disadvantage clients (Article 24(10))
- [ ] **Knowledge and competence** of client-facing staff — ESMA Guidelines compliance, documented training, and assessment
- [ ] **Complaints handling** — recorded, investigated, resolved within prescribed timelines; reporting to NCA

**Reference:** MAR — Regulation (EU) 596/2014; MiFIR — Regulation (EU) 600/2014 (Articles 3–13 transparency, Articles 26–27 transaction and reference data reporting); MiFID II Articles 24–25 (conduct), 27–28 (best execution and order handling)

---

## SECTION 10 — APPLICATION PROCESS & TIMELINE

*This section maps the practical steps from "decision to apply" to "authorization granted." Investment-firm authorization typically takes 6–12 months from a complete application; the heaviest lift is the policy and documentation pack.*

---

### 10.1 — NCA Application Workflow

| Step | Action | Typical Timeline |
|---|---|---|
| **1** | Engage specialist EU financial-services legal counsel | Week 0 |
| **2** | Complete this readiness checklist — identify all gaps | Weeks 1–2 |
| **3** | Select home Member State and NCA | Week 2 |
| **4** | Pre-application meeting with NCA (most NCAs offer / require this) | Weeks 3–6 |
| **5** | Prepare full application dossier (business plan, ICAAP/ILAAP, policies, financial evidence, fit-and-proper documentation) | Weeks 4–20 |
| **6** | Submit application to NCA | Week 20+ |
| **7** | NCA completeness check | Article 7(3): authorization decision within **6 months** of complete application |
| **8** | NCA substantive review (Q&A rounds, additional information requests — clock stops) | 4–9 months in practice |
| **9** | Authorization granted (or conditions / refusal communicated) | **6–12 months total** from submission |
| **10** | ESMA register listing — every authorisation notified to ESMA; firm appears on public list of all EU investment firms *(Article 5(3))* | Upon authorization |
| **11** | EU-wide passporting notification (services or branch) — Articles 34–35 | Post-authorization |

> **Note:** The Article 7(3) statutory clock is **6 months** from a *complete* application — but NCAs routinely use information-request mechanisms that pause the clock. Plan for 9–12 months in practice. NCAs also vary in pre-application engagement: some (CSSF, CBI, AMF) hold structured pre-application meetings, others (BaFin, AFM) prefer the dossier to arrive complete.

---

### 10.2 — Application Dossier Contents

Your NCA application must include (at minimum):

- [ ] Completed application form (NCA-specific format)
- [ ] Business plan (3-year, detailed — services, target market, financial projections)
- [ ] Organisational chart and governance structure
- [ ] Fit-and-proper documentation for all directors, senior managers, and qualifying shareholders (CVs, criminal records, financial soundness evidence)
- [ ] Proof of initial capital paid in (bank statement / audited accounts)
- [ ] **ICAAP** (Internal Capital Adequacy Assessment Process) for non-Class 3 firms — IFD Article 24
- [ ] **ILAAP** (Internal Liquidity Adequacy Assessment Process) — IFD Article 24
- [ ] AML/CFT compliance program
- [ ] ICT risk management framework and DORA compliance documentation
- [ ] Business continuity and disaster recovery plans
- [ ] Conflict of interest policy and inducements register
- [ ] Complaints handling procedures
- [ ] Client asset safeguarding policy and CASS-equivalent procedures (if applicable)
- [ ] Order execution policy and best execution monitoring framework (if applicable)
- [ ] Outsourcing arrangements documentation and exit plans
- [ ] Insurance policy or equivalent guarantee documentation (where required)
- [ ] Marketing and communications policy
- [ ] Algorithmic trading description and risk controls (if applicable)
- [ ] **Wind-down plan** — orderly cessation of business and return of client assets
- [ ] For DLT MTF / DLT SS / DLT TSS: separate DLT Pilot Regime application — specific permissions, compensatory measures, and transition arrangements

**Reference:** MiFID II Articles 5–14 (Authorization), Article 7 (Procedure and timeline); IFD Article 24 (ICAAP / ILAAP)

---

## SECTION 11 — POST-AUTHORIZATION & ONGOING OBLIGATIONS

*Authorization is the beginning, not the end. The ongoing supervisory regime is what determines whether your firm stays in good standing.*

---

### 11.1 — Continuing Obligations

- [ ] **Regular review of authorization conditions** (Article 21) — firm must comply with initial authorization conditions at all times; notify NCA of material changes
- [ ] **Annual / periodic regulatory reporting** — own funds, FOR, K-factors, large exposures, liquidity (IFR / IFD)
- [ ] **Transaction reporting under MiFIR Article 26** — T+1 reporting via ARM
- [ ] **ICAAP / ILAAP annual update** and submission
- [ ] **SREP** (Supervisory Review and Evaluation Process) — NCA-led review, typically annual for larger firms, biennial / triennial for smaller
- [ ] **DORA incident reporting** — major ICT incidents reported on initial / intermediate / final basis within DORA timelines
- [ ] **AML annual reporting / typology updates** to NCA / FIU as required
- [ ] **Audited financial statements** filed annually
- [ ] **Material change notifications** — new qualifying shareholders, new directors, new business lines, material outsourcing — all require prior notification or approval

---

### 11.2 — Passporting (Articles 34–35)

If you want to provide services into other Member States:

- [ ] **Freedom-to-provide-services notification (Article 34)** — home NCA notifies host NCA; services may begin once notification is filed
- [ ] **Branch establishment notification (Article 35)** — home NCA notifies host NCA; host NCA has 2 months to prepare for supervision; branch may begin operating thereafter
- [ ] **Tied agent passporting** — separate notification regime
- [ ] **Conduct-of-business rules** — host Member State conduct rules apply to services provided in host territory (Article 35(8))

**Reference:** MiFID II Articles 21–22 (Ongoing supervision), 34–35 (Passporting), 41 (Branches); IFR / IFD reporting regime

---

## SECTION 12 — MIFID III REVIEW: PHASED ROLLOUT 2025–2026

*The MiFID/MiFIR review package — Directive (EU) 2024/790 and Regulation (EU) 2024/791 — entered into force 28 March 2024. Provisions roll out on a phased schedule. New entrants must plan for the end-state, not the legacy regime.*

---

### 12.1 — Key MiFID III Dates and Changes

| Date | Milestone | What changes |
|---|---|---|
| **28 March 2024** | MiFID III package enters into force | Most amendments take effect immediately; some on application dates below |
| **September 2025** | Active monitoring stage | ESMA begins active monitoring of conduct, transparency, and consolidated tape preparation |
| **March 2026** | Transparency rules tightened | Revised pre- and post-trade transparency calibration applies |
| **April 2026** | Expanded transaction reporting | New MiFIR Article 26 reporting fields and reference data requirements |
| **June 2026** | **PFOF ban + consolidated tape live** | Payment for Order Flow prohibited EU-wide; EU consolidated tape operational for equities and bonds |

**Practical impact for new applicants (file in 2026):**

- [ ] **PFOF business model deal-breaker:** If your revenue model relies on payment for order flow, **stop and rebuild** — PFOF is prohibited from June 2026 (MiFIR Article 39a)
- [ ] **Consolidated tape integration:** Trading venues, APAs, and systematic internalisers must integrate with the EU consolidated tape provider (CTP)
- [ ] **Best execution reporting overhaul:** RTS 27 has been repealed; RTS 28 publication under review — confirm current requirement with counsel
- [ ] **Equity transparency** — volume cap mechanism simplified to a single 7% cap; reference price waiver and negotiated trade waiver recalibrated
- [ ] **Non-equity transparency** — pre-trade transparency for bonds and derivatives recalibrated; size-specific-to-instrument (SSTI) regime simplified
- [ ] **Systematic Internaliser regime** — quantitative threshold-based SI designation replaced by **opt-in** regime; SI quoting obligations recalibrated

---

### 12.2 — Transitional Provisions for Existing Firms

- [ ] If already authorized under national investment-services regime pre-MiFID II — confirm transitional status with home NCA (most transitional periods closed by 2018)
- [ ] If new entrant filing in 2026 — plan for full MiFID II + MiFID III compliance from day one (no grandfathering)
- [ ] Monitor ESMA Level 2 (RTS / ITS) and Level 3 (Guidelines, Q&A) publications continuously — implementing measures continue to be issued

**Reference:** Directive (EU) 2024/790 (MiFID III review — Directive); Regulation (EU) 2024/791 (MiFID III review — Regulation); MiFIR Article 39a (PFOF ban)

---

## READINESS SCORECARD — SUMMARY

*Use this scorecard to assess your overall readiness. Count completed checkboxes per section.*

| Section | Topic | Items | Ready? |
|---|---|---|---|
| 1 | MiFID II applicability & scope | 13 | ☐ |
| 2 | Investment services + instruments + venue type | 30 | ☐ |
| 3 | Entity structure & governance | 14 | ☐ |
| 4 | Financial requirements & capital | 10 | ☐ |
| 5 | Pre-trade disclosures & client documentation | 28 | ☐ |
| 6 | AML/CFT & KYC | 14 | ☐ |
| 7 | Operational & organisational | 38 | ☐ |
| 8 | ICT, cybersecurity & DORA | 9 | ☐ |
| 9 | Market integrity & consumer protection | 19 | ☐ |
| 10 | Application process & dossier | 18 | ☐ |
| 11 | Post-authorization & ongoing obligations | 11 | ☐ |
| 12 | MiFID III phased rollout | 8 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** Ready to engage NCA application process
- **Amber (50–80% complete):** Material gaps exist — close these before filing
- **Red (<50% complete):** Significant preparation required — engage specialist counsel and allocate 4–8 months of pre-application work

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for MiFID II / DLT Pilot Regime applicants:**

**Pre-Build:** MiFID-vs-MiCA token-classification brief → instrument-level legal opinion → financial-instrument architecture mapped to Annex I Section C → DLT Pilot Regime fit assessment (DLT MTF / SS / TSS)

**Build:** ERC-3643 / ERC-1400 permissioned-token contracts for transferable securities → on-chain transfer-restriction enforcement aligned with prospectus terms → KYC-bound holder registries → corporate-action automation (dividends, voting, redemptions) → settlement integration with EU CSDs and DLT SS infrastructure → MAR-compliant event schema for inside-information disclosure → MiFIR Article 26 transaction-reporting event capture

**Audit:** Independent smart contract security audit → NCA-ready audit report → token-architecture-to-prospectus mapping → delta audit process for ongoing on-chain upgrades

**Why investment firms choose us:** We don't just write code — we write code your NCA reviewer can read against the Directive. Every contract function is labelled against the MiFID II article (or DLT Pilot Regime provision) it enforces. Your legal team reads the architecture specification alongside the prospectus, not instead of it.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. MiFID II requirements are subject to national implementation measures, ESMA / EBA technical standards, ongoing regulatory guidance, and the MiFID III review package which is still being phased in. Always engage qualified EU financial-services legal counsel for your specific business and jurisdiction.*

*Document version: 1.0 | Last updated: May 2026*
*Regulation reference: Directive 2014/65/EU of the European Parliament and of the Council of 15 May 2014 on markets in financial instruments (MiFID II) — https://eur-lex.europa.eu/eli/dir/2014/65/oj — as amended by Directive (EU) 2024/790 and Regulation (EU) 2024/791 (MiFID III review)*
