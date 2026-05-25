# MiFIR Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide to Market-Conduct, Transparency & Reporting Obligations Under MiFIR

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU Markets in Financial Instruments Regulation (MiFIR) — Regulation (EU) No 600/2014, as amended by Regulation (EU) 2024/791 ("MiFID/MiFIR Review" — in force 28 March 2024)
**Source:** https://eur-lex.europa.eu/eli/reg/2014/600/oj
**Status:** Directly applicable since 3 January 2018 — substantively rewritten by Regulation (EU) 2024/791 with phased application through 2026
**Document type:** Operational readiness assessment — focuses on the ongoing market-conduct obligations a MiFID-authorised firm or trading venue must run continuously

---

> **Who this document is for:** Founders, COOs, Heads of Compliance, and Heads of Market Operations preparing to operate as an EU investment firm, trading venue (RM, MTF, OTF, DLT MTF), systematic internaliser (SI), APA, ARM, or CTP — or already authorised under MiFID II and trying to confirm the day-2 MiFIR machinery is in place. This checklist mirrors the operational-readiness intake a specialist EU market-structure lawyer would walk you through.

---

> **How this checklist relates to the MiFID II checklist:** MiFID II (Directive 2014/65/EU) governs **who can be authorised** and the **conduct-of-business** envelope around clients. MiFIR (Regulation (EU) 600/2014) governs **what happens on the market** — trade transparency, transaction reporting, the derivatives trading obligation, non-discriminatory access, and the third-country regime. They are a **single rulebook in two instruments**. Complete the MiFID II checklist first to confirm authorisation pathway; use this MiFIR checklist to confirm you can actually operate post-authorisation without breaching market-microstructure rules. Many of the most expensive MiFID enforcement actions of the last five years (transaction-reporting failures, SI mis-classifications, derivatives-trading-obligation breaches) sit on the MiFIR side, not the MiFID II side.

---

> **MiFID/MiFIR Review (2024) is the operative baseline:** Regulation (EU) 2024/791 entered into force on 28 March 2024 and changes a substantial portion of MiFIR — most importantly the **payment-for-order-flow (PFOF) ban (Article 39a)**, the **EU consolidated tape**, the **SI regime overhaul (opt-in instead of quantitative threshold)**, the **equity volume-cap simplification**, the **non-equity transparency recalibration**, and the **removal of share trading obligation extraterritoriality** (former Article 23 scope narrowed). If your business plan assumes the pre-2024 MiFIR text, it is already out of date. This checklist is calibrated to the post-2024 regulation as it applies through 2025–2026.

---

## SECTION 1 — DOES MIFIR APPLY TO YOU?

*Unlike MiFID II, MiFIR is a Regulation — it applies directly, without national transposition, the moment you operate in scope. There is no national-law "soft landing." Most firms are caught the day they become authorised; some (third-country firms operating cross-border into the EU) can be caught even without an EU authorisation.*

---

### 1.1 — Entity Scope — Does MiFIR Catch You?

Tick every category that describes you. Each adds a distinct MiFIR obligation stack.

- [ ] **Authorised investment firm** (MiFID II Article 5) providing any Annex I Section A service in the EU
- [ ] **Regulated Market (RM)** — operated by a market operator authorised under MiFID II Title III
- [ ] **Multilateral Trading Facility (MTF)** — authorised under MiFID II Article 18
- [ ] **Organised Trading Facility (OTF)** — non-equities only; authorised under MiFID II Article 20
- [ ] **Systematic Internaliser (SI)** — investment firm that opts in (post-2024 review) or that previously crossed the quantitative thresholds (legacy regime)
- [ ] **DLT MTF / DLT SS / DLT TSS** under Regulation (EU) 2022/858 (DLT Pilot Regime) — MiFIR transparency and reporting apply except where the DLT Pilot grants a specific exemption with compensatory measures
- [ ] **Data Reporting Service Provider (DRSP):** APA (Approved Publication Arrangement), ARM (Approved Reporting Mechanism), or CTP (Consolidated Tape Provider) — authorised under MiFID II Title V (APA/ARM by NCA, CTP by ESMA post-2024)
- [ ] **Third-country firm** providing investment services to per-se professional clients / eligible counterparties in the EU under MiFIR Article 46 (equivalence regime)

---

### 1.2 — Instrument Scope — Which Title(s) Apply?

MiFIR splits its transparency and reporting regime by instrument class. Tick every class you trade, execute, or admit to trading.

- [ ] **Shares, depositary receipts, ETFs, certificates and similar** → Title II Chapter 1 (Articles 3–7) + Title III SI quoting for equity (Articles 14–17, 20) + share **trading obligation** scope (post-2024 narrowed)
- [ ] **Bonds (sovereign, corporate, covered, securitised)** → Title II Chapter 2 (Articles 8–11) + Title III SI quoting for non-equity (Article 18, 21)
- [ ] **Structured finance products** → Title II Chapter 2 (Articles 8–11) + Title III non-equity SI quoting
- [ ] **Emission allowances (EU ETS units)** → Title II Chapter 2 + product intervention (Title VII)
- [ ] **Derivatives** (rates, credit, FX, equity, commodity) → Title II Chapter 2 + Title V **derivatives trading obligation (DTO, Article 28)** + EMIR clearing-obligation interface
- [ ] **Tokenised transferable securities (RWA / STO / tokenised bonds / tokenised equity)** → treated as their underlying instrument class (equity vs. non-equity) for MiFIR purposes; the **DLT form does not change MiFIR classification** — only the DLT Pilot Regime can vary transparency/reporting timing with compensatory measures

> **Boundary with MiCA:** MiFIR applies only to financial instruments. Crypto-assets in scope of MiCA (asset-referenced tokens, e-money tokens, other crypto-assets) sit outside MiFIR transparency and reporting — they have a parallel CASP-side disclosure regime under MiCA Title V. The classification decision (MiFID financial instrument vs. MiCA crypto-asset) is the same one that determines whether MiFID II or MiCA applies; once made, the MiFIR stack follows automatically.

**Reference:** MiFIR Articles 1 (Subject matter and scope), 2 (Definitions), 4(1)(15) MiFID II (financial instrument definition); DLT Pilot Regime — Regulation (EU) 2022/858

---

## SECTION 2 — PRE-TRADE TRANSPARENCY (TITLE II)

*Pre-trade transparency means publishing actionable order-book or quote information **before** a trade. Failures here are the most operationally visible MiFIR breaches — they show up in ESMA's MMT (Market Model Typology) feeds and competing-venue surveillance immediately.*

---

### 2.1 — Equity Pre-Trade Transparency (Article 3)

If you operate an RM, MTF, or OTF (equity-eligible) trading shares, depositary receipts, ETFs, certificates, or similar:

- [ ] **Current bid / offer prices and depth of trading interest** made public on a **continuous basis during normal trading hours** (Article 3(1))
- [ ] Information made available to the public on **reasonable commercial terms** AND on a **non-discriminatory basis** (Article 3(2))
- [ ] Information made available **free of charge 15 minutes after publication** (Article 13(1))
- [ ] **Trading system type** identified (continuous auction order book / quote-driven / periodic auction / request-for-quote / hybrid) — different MiFIR transparency calibrations apply per RTS 1 (Commission Delegated Regulation (EU) 2017/587)
- [ ] **Indicative pre-auction prices** published where price-discovery auction is used

---

### 2.2 — Equity Pre-Trade Transparency Waivers (Article 4)

If you intend to use any pre-trade transparency waiver, document NCA approval before go-live:

- [ ] **Reference price waiver** (Article 4(1)(a)) — trades matched at the midpoint of a reference market; NCA approval required
- [ ] **Negotiated trade waiver** (Article 4(1)(b)) — pre-arranged trades subject to conditions in RTS 1
- [ ] **Large-in-scale (LIS) waiver** (Article 4(1)(c)) — orders large compared to normal market size (thresholds per RTS 1)
- [ ] **Order management facility (OMF) waiver** (Article 4(1)(d)) — orders held in a system pending disclosure (e.g., iceberg orders)
- [ ] **NCA notification of waiver use** filed and acknowledged before activation
- [ ] **ESMA opinion** consulted where required (ESMA has 2 months to issue a non-binding opinion under Article 4(4))

---

### 2.3 — Equity Volume Cap Mechanism (Article 5 — **simplified by 2024 review**)

The Double Volume Cap was replaced by a **single 7% cap** by Regulation (EU) 2024/791. Confirm calibration with the latest ESMA implementing act.

- [ ] **Single Volume Cap (SVC) monitoring** — share of EU trading under the reference price waiver and negotiated trade waiver capped at **7% of total EU trading volume per instrument over 12 months** (post-2024)
- [ ] Process in place to suspend waiver use for an instrument when ESMA publishes a cap breach
- [ ] Internal MIS to track and forecast cap consumption per instrument

> **Common error:** Trading desks designing dark-pool routing logic for the legacy 4%/8% double cap. Update routing logic to the 7% single cap and disable the per-venue 4% sub-cap controls.

---

### 2.4 — Non-Equity Pre-Trade Transparency (Article 8)

If you trade bonds, structured finance products, emission allowances, or derivatives on an RM, MTF, or OTF:

- [ ] **Current bid/offer prices and depth** published in respect of orders / actionable indications of interest **during normal trading hours**
- [ ] Calibration per **liquidity classification** of the instrument (liquid / illiquid per ESMA quarterly transparency calculations under RTS 2)
- [ ] **Size-specific-to-instrument (SSTI) regime** — pre-trade transparency requirements scale by instrument size; post-2024 review simplified the SSTI architecture — confirm current thresholds
- [ ] **Voice trading systems**: indicative bid/offer prices published for instruments traded by voice
- [ ] **Request-for-quote (RFQ) systems**: actionable indications of interest published at the point a quote is firm

---

### 2.5 — Non-Equity Pre-Trade Transparency Waivers (Article 9)

- [ ] **LIS waiver (Article 9(1)(a))** — orders large in scale per RTS 2
- [ ] **Above SSTI waiver (Article 9(1)(b))** — orders / actionable IOIs above SSTI threshold posted on RFQ / voice systems
- [ ] **Illiquid instrument waiver (Article 9(1)(c))** — derivatives not subject to the clearing obligation and other instruments for which there is no liquid market
- [ ] **Package transactions waiver (Article 9(1)(d))** — for orders that are components of packages
- [ ] NCA approval and ESMA opinion process completed for each waiver type used

---

### 2.6 — Pre-Trade Transparency for Tokenised Instruments (DLT Pilot Considerations)

If you operate a DLT MTF / DLT TSS under Regulation (EU) 2022/858:

- [ ] **On-chain order book or RFQ publication** mechanism designed to satisfy Article 3 / Article 8 transparency at the same calibration as a non-DLT venue
- [ ] **Pre-trade publication latency** kept within MiFIR "continuous basis" expectations — block-time considerations documented
- [ ] **Compensatory measures** for any transparency exemption granted under DLT Pilot Regime Article 4(2) — published and approved by NCA
- [ ] **Smart-contract event schema** maps to RTS 1 / RTS 2 data fields one-to-one (so the same publication satisfies MiFIR and is consumable by APAs)

**Reference:** MiFIR Articles 3–11; Commission Delegated Regulation (EU) 2017/587 (RTS 1, equity transparency); Commission Delegated Regulation (EU) 2017/583 (RTS 2, non-equity transparency); DLT Pilot Regime Article 4

---

## SECTION 3 — POST-TRADE TRANSPARENCY (TITLE II + III)

*Post-trade transparency is the publication of executed trades — price, volume, time, venue. It applies to virtually every trade in any financial instrument admitted to trading on an EU venue, regardless of where the trade itself was executed (including OTC).*

---

### 3.1 — Venue Post-Trade Transparency (Articles 6 & 10)

If you operate an RM, MTF, or OTF:

- [ ] **Price, volume, time of trades** in equity instruments (Article 6) and non-equity instruments (Article 10) published as **close to real-time as is technically possible**
- [ ] Information made available on **reasonable commercial terms** AND on a **non-discriminatory basis**
- [ ] Information made available **free of charge 15 minutes after publication** (Article 13(1))
- [ ] **Trade flags** correctly populated per RTS 1 / RTS 2 (benchmark / negotiated / portfolio / large-in-scale / deferred / cancelled / etc.)
- [ ] **APA arrangement** in place if venue does not publish directly — venues may publish via an Approved Publication Arrangement

---

### 3.2 — Investment Firm OTC Post-Trade Transparency (Articles 20 & 21)

If you trade financial instruments OTC (off-venue, including as an SI):

- [ ] **OTC trades in equity instruments** (Article 20) — published via APA, including for trades concluded outside trading venues
- [ ] **OTC trades in non-equity instruments** (Article 21) — published via APA
- [ ] **Designated reporting party rules** applied (the rules in RTS 1 / RTS 2 on which counterparty reports for OTC trades — the post-2024 review tightened the "seller reports" default for non-equity)
- [ ] **APA contract** in place; failover APA identified for resilience
- [ ] **Real-time reporting capability** — internal trade-to-APA latency benchmarked monthly

---

### 3.3 — Deferred Publication (Articles 7 & 11)

Post-trade publication may be deferred only with NCA authorisation and within published thresholds:

- [ ] **Equity deferrals (Article 7)** — LIS trades; deferral length set per RTS 1 schedule
- [ ] **Non-equity deferrals (Article 11)** — for trades above SSTI, illiquid-instrument trades, sovereign-debt trades — deferrals up to multiple weeks possible depending on category
- [ ] **NCA authorisation** for the deferral regime obtained and renewed as required
- [ ] **Public schedule** of deferred-trade publication times made available
- [ ] Post-2024 review: **non-equity deferral simplification** — confirm new five-bucket regime (very-large / large / small-size / illiquid / sovereign) is implemented in your trade-flagging and APA-reporting logic

---

### 3.4 — Make Data Available on Reasonable Commercial Basis (Articles 12–13)

- [ ] **Pre-trade data and post-trade data** made available **separately** (Article 12) — cannot be bundled-only
- [ ] **Reasonable commercial basis (RCB)** pricing methodology documented per Commission Delegated Regulation (EU) 2017/567 — costs-plus-reasonable-margin model
- [ ] **Free-of-charge 15-minute delayed feed** published
- [ ] **Per-user / per-display licensing** offered (not enterprise-only)
- [ ] **Non-discriminatory access** — same terms offered to all categories of clients (commercial, non-commercial, vendors, retail aggregators)
- [ ] **ESMA RCB Guidelines** compliance (annual published Q&A) — fee uplifts above inflation justified in writing

**Reference:** MiFIR Articles 6–13, 20–21; RTS 1 (Reg. 2017/587); RTS 2 (Reg. 2017/583); RCB Regulation 2017/567

---

## SECTION 4 — SYSTEMATIC INTERNALISER (SI) REGIME

*The 2024 review removed the quantitative-threshold-based SI designation. Becoming an SI is now an **opt-in** decision. Investment firms that previously fell into SI status automatically must re-assess; firms designing new businesses must decide whether to opt in deliberately.*

---

### 4.1 — SI Designation Decision (Post-2024 Opt-In Regime)

- [ ] **SI status decision documented** — firm has decided to opt **in** or **out** of SI status per asset class
- [ ] **Notification to home NCA** filed for SI status (in or out)
- [ ] **ESMA SI register entry** maintained — the public SI register is the source of truth for counterparties; entries must be kept current
- [ ] **Internal product / desk taxonomy** confirms which trades fall inside vs. outside SI status

> **Common error:** firms continuing to assume legacy quarterly SI thresholds still trigger designation. The threshold regime was removed — quarterly SI calculations are no longer required for designation purposes (separate non-SI quantitative reporting may still apply).

---

### 4.2 — Equity SI Quoting Obligations (Articles 14–17)

If you have opted in as SI for shares, depositary receipts, ETFs, certificates, or similar:

- [ ] **Public firm quotes** in respect of liquid equity instruments published on a regular and continuous basis during normal trading hours (Article 14)
- [ ] **Quote size up to standard market size (SMS)** for the asset class
- [ ] **Quotes accessible to other market participants** on a non-discriminatory basis (Article 17)
- [ ] **Commercial policy** for client access to SI quotes documented — objective criteria, transparent application
- [ ] **Best price improvement** mechanism — quotes may be improved in justified cases for professional clients (Article 15(2))
- [ ] **Pre-trade NCA monitoring** under Article 16 — supervisor entitled to monitor SI quoting activity

---

### 4.3 — Non-Equity SI Quoting Obligations (Article 18)

If you have opted in as SI for bonds, structured finance products, emission allowances, or derivatives:

- [ ] **Firm quotes** published to clients / on request, depending on instrument and post-2024 calibration
- [ ] **Quotes for liquid instruments** made public when client requests a quote and the firm agrees to provide
- [ ] **Size-specific obligations** mapped to RTS 2 thresholds
- [ ] **ESMA monitoring** under Article 19 — supervisor entitled to monitor SI calibration

**Reference:** MiFIR Articles 14–23 (as amended by Regulation (EU) 2024/791); RTS 1 / RTS 2

---

## SECTION 5 — TRANSACTION REPORTING (TITLE IV)

*MiFIR Article 26 transaction reporting is the single largest operational obligation in the MiFIR stack — T+1 reporting of every executed transaction in any reportable financial instrument, with **65+ data fields per report**, to the home NCA. Reporting failures are the most common MiFID enforcement action category in the EU.*

---

### 5.1 — Reporting Obligation Scope (Article 26)

- [ ] **Scope confirmed:** transactions in financial instruments admitted to trading or traded on a trading venue, including OTC where the underlying is on-venue
- [ ] **Reporting deadline:** **T+1 close of business** the working day following execution
- [ ] **Reportable transactions identified per instrument** — equity, bonds, derivatives, ETFs, certificates, emission allowances, depositary receipts
- [ ] **Buy / sell / both-sides reporting logic** correctly applied (both counterparties report independently; agency vs. principal flagging correct)

---

### 5.2 — Data Field Population (Commission Delegated Regulation (EU) 2017/590 — RTS 22)

- [ ] **65 reporting fields** populated to RTS 22 standard, including:
  - [ ] Trader ID and decision-maker ID (natural-person / algorithm ID — National Client Identifier / SHORT-CODE / LEI)
  - [ ] **LEI for every legal-person counterparty** — "no LEI, no trade" principle since 3 January 2018
  - [ ] **National Client Identifier (NCI) for every natural-person counterparty** — CONCAT-format with passport / national-ID number per home jurisdiction
  - [ ] Instrument identifier (ISIN), price, quantity, currency, venue (MIC), trading capacity (principal / agency / matched principal)
  - [ ] Waiver / deferral / OTC flags
  - [ ] Short selling flag (per SSR Regulation (EU) 236/2012)
  - [ ] Commodity-derivative indicator
- [ ] **2024 review additions:** new reference data fields (algorithm identification, OTC interest-rate derivative fields, post-trade transparency cross-references) — post-April 2026 effective date per the phased rollout; mapping completed and tested

---

### 5.3 — Reporting Channel & ARM

- [ ] **Approved Reporting Mechanism (ARM)** contracted, with failover ARM identified
- [ ] **Direct-to-NCA reporting** option (where NCA accepts) configured as fallback
- [ ] **Trading venue alternative** — if executed on RM/MTF/OTF, the venue may report on the firm's behalf, but the firm remains legally responsible
- [ ] **Reconciliation between firm books and reported transactions** run daily
- [ ] **Rejection / amendment workflow** in place — corrections re-submitted within T+1 of identification
- [ ] **ARM contract** includes audit rights, latency SLAs, and exit / data-portability terms

---

### 5.4 — Transaction Reporting Quality Controls

- [ ] **Internal data quality dashboards** — completeness, accuracy, timeliness measured daily
- [ ] **Quarterly internal sample audit** of reported transactions against trade-blotter source-of-truth
- [ ] **Annual external assurance review** of transaction reporting (NCA-expected best practice for medium / large firms)
- [ ] **Periodic reconciliation against NCA's "reasonableness reports"** (FCA / BaFin / CSSF send these to firms quarterly; treat as gold-standard)
- [ ] **MiFIR Article 26 governance** — designated senior accountable owner; reporting metrics in compliance committee pack

---

### 5.5 — Reference Data Reporting (Article 27)

If you operate a trading venue OR are an SI for at least one instrument:

- [ ] **Daily instrument reference data submission** to NCA covering every instrument admitted to trading or traded
- [ ] **FIRDS (Financial Instruments Reference Data System)** integration tested
- [ ] **New-instrument onboarding** workflow ensures reference data is submitted at admission, not after first trade
- [ ] **Corporate actions** propagated promptly into FIRDS feed

> **Legal advisor note:** Transaction-reporting failures (Article 26) and reference-data failures (Article 27) are the **single largest source of EU MiFID monetary penalties** since 2018. Examples include €27.6m (FCA, 2019), €26m (FCA, 2017), €6m (BaFin, 2022). The root cause is almost always the same: data taxonomy at the firm doesn't match RTS 22 field definitions, and the reconciliation regime is too weak to detect divergence. Treat MiFIR reporting as a Tier-1 engineering and compliance problem from day one, not a "we'll sort it before go-live" problem.

**Reference:** MiFIR Articles 24–27; Commission Delegated Regulation (EU) 2017/590 (RTS 22 — transaction reporting); Commission Delegated Regulation (EU) 2017/585 (RTS 23 — reference data); ESMA TRACE / FITRS / FIRDS reference systems

---

## SECTION 6 — DERIVATIVES (TITLE V)

*MiFIR Title V interfaces with EMIR (Regulation (EU) 648/2012). The two together establish: (a) which derivatives must be **cleared** (EMIR Article 5 clearing obligation), and (b) which derivatives must be **traded on-venue** (MiFIR Article 28 derivatives trading obligation, or "DTO"). The DTO is conditional on the clearing obligation — only CCP-cleared, sufficiently liquid derivative classes are caught.*

---

### 6.1 — Derivatives Trading Obligation (DTO — Article 28)

- [ ] **In-scope derivative classes identified** against the **ESMA DTO public register** (Article 34) — currently covers specified IRS classes (EUR / USD / GBP fixed-to-floating swaps in benchmark tenors) and certain index CDS
- [ ] **Trading venue routing** — in-scope derivatives executed only on RM, MTF, OTF, or third-country venue benefiting from a positive Article 28(4) equivalence decision
- [ ] **Counterparty classification check** — DTO applies to financial counterparties (FC) and non-financial counterparties above the clearing threshold (NFC+); intra-group and pension-scheme exemptions reviewed against EMIR
- [ ] **Pre-execution venue-eligibility check** automated in OMS / EMS
- [ ] **Exception logging** — any execution off-venue documented and reviewed (post-trade risk-reduction, package-transaction exemption per RTS, etc.)

---

### 6.2 — Clearing Obligation Interface (Article 29, EMIR Article 5)

- [ ] **CCP-clearing arrangements** in place for every in-scope class (direct clearing member or indirect-clearing chain)
- [ ] **Indirect clearing arrangements (Article 30)** documented per RTS — written terms, segregation, leapfrog provisions, default-management
- [ ] **CCP timing of acceptance for clearing** — venues / CCPs accept trades for clearing as **quickly as technologically practicable** (Article 29(2)) — measured in seconds, not minutes
- [ ] **Backloading / give-up workflows** tested with the CCP

---

### 6.3 — Portfolio Compression (Article 31)

If you offer or participate in portfolio compression services:

- [ ] **Compression service provider** documented; controls in place to ensure the compression cycle reduces non-market risk without altering market risk of portfolios
- [ ] **Record-keeping** of pre-compression and post-compression positions per Article 31(3)
- [ ] **Public disclosure** of compression-cycle terms

---

### 6.4 — DTO Procedural Framework (Articles 32–34)

- [ ] **ESMA RTS draft / ITS review** monitoring — DTO scope expansion (additional derivative classes) tracked
- [ ] **Trading obligation suspension watch** — Article 32(5) allows ESMA to suspend the DTO in exceptional circumstances (rare); operational plan to act on suspension
- [ ] **Third-country equivalence monitoring** — Article 28(4) equivalence decisions (US CFTC SEFs, UK MTFs, etc.) tracked for changes

**Reference:** MiFIR Articles 28–34; EMIR — Regulation (EU) 648/2012, Article 5 (clearing obligation); ESMA Public Register of Derivatives Subject to the Trading Obligation

---

## SECTION 7 — NON-DISCRIMINATORY CLEARING & ACCESS (TITLE VI)

*Title VI prevents vertically integrated trading-and-clearing silos from blocking competition. If you operate an RM / MTF / OTF or a CCP, you must offer non-discriminatory access to others under the conditions set in MiFIR.*

---

### 7.1 — CCP Access (Article 35)

If you operate a CCP:

- [ ] **Non-discriminatory access** offered to trading venues that request it on transparent and non-discriminatory commercial terms
- [ ] **Capacity-based justifications** for refusal documented per ESMA RTS
- [ ] **3-month response window** to access requests under RTS 15 (Reg. 2017/581)

---

### 7.2 — Trading Venue Access (Article 36)

If you operate an RM / MTF / OTF:

- [ ] **Non-discriminatory access to feeds, trade reports, reference data** offered to CCPs that request it
- [ ] **License terms** transparent and non-discriminatory
- [ ] **Refusal grounds** documented per RTS

---

### 7.3 — Benchmarks (Article 37)

If your firm administers a benchmark used in financial instruments traded on EU venues:

- [ ] **Non-discriminatory access to licence the benchmark and to relevant price / data feeds** offered to CCPs and trading venues
- [ ] **Licence terms** non-discriminatory, FRAND-style
- [ ] **Benchmark Regulation (BMR — Regulation (EU) 2016/1011)** compliance baseline confirmed (parallel regime)

---

### 7.4 — Third-Country CCPs and Venues (Article 38)

- [ ] **Equivalence status** of any third-country CCP / venue your firm depends on tracked (Commission equivalence decisions, ESMA recognition status)

**Reference:** MiFIR Articles 35–38; Commission Delegated Regulation (EU) 2017/581 (RTS 15)

---

## SECTION 8 — SUPERVISORY MEASURES: PRODUCT INTERVENTION & POSITION LIMITS (TITLE VII)

*Title VII gives ESMA, EBA, and NCAs intervention powers. Firms must build product-governance and position-monitoring controls that anticipate intervention rather than react to it after enforcement.*

---

### 8.1 — Product Intervention Awareness (Articles 39–43)

- [ ] **ESMA intervention register** monitored — historical examples include retail CFD leverage caps, binary options ban (made permanent by Commission Regulation), crypto-related CFD restrictions
- [ ] **EBA intervention register** monitored — structured deposits scope
- [ ] **NCA intervention notifications** monitored per host Member State of operation
- [ ] **Internal product governance** (MiFID II Article 16(3)) updated immediately on any intervention publication; downstream distribution restrictions cascaded to tied agents and distributors
- [ ] **Marketing review** ensures the firm's content does not promote products subject to active intervention

---

### 8.2 — Position Management (Articles 44–45)

If you trade commodity derivatives, emission allowances, or any instruments for which ESMA has set position management measures:

- [ ] **Position limits per Article 57 MiFID II** mapped to your trading activity per commodity / emission-allowance class
- [ ] **Position reporting per Article 58 MiFID II** to the relevant trading venue and home NCA
- [ ] **Ancillary activity exemption (MiFID II Article 2(1)(j))** reassessed annually
- [ ] **ESMA position-management directions** monitored — Article 45 lets ESMA require firms to reduce or eliminate positions

**Reference:** MiFIR Articles 39–45; MiFID II Articles 57–58 (commodity position limits / reporting); Commission Delegated Regulation (EU) 2016/1226

---

## SECTION 9 — THIRD-COUNTRY FIRMS (TITLE VIII)

*Title VIII governs how a non-EU investment firm can provide services into the EU to per-se professional clients and eligible counterparties without an EU branch — via the equivalence regime.*

---

### 9.1 — Equivalence-Based Cross-Border Provision (Articles 46–49)

If you are a third-country firm intending to provide investment services into the EU under the MiFIR equivalence regime (rather than via branch authorisation under MiFID II Article 39):

- [ ] **Commission equivalence decision** (Article 47) confirmed to be in force for your home jurisdiction in respect of the services you intend to provide
- [ ] **ESMA registration (Article 46)** filed and granted before any cross-border service is offered
- [ ] **Cooperation arrangement** between ESMA and your home supervisor confirmed in place
- [ ] **Disclosure to EU clients** — clients informed that services are provided under the Article 46 regime and that complaints / dispute resolution take place in the third-country jurisdiction
- [ ] **EU-resident retail and elective-professional clients** — confirmed that Article 46 does **not** cover these (full branch authorisation under MiFID II Article 39 required)
- [ ] **Article 49 withdrawal-of-registration risk** mitigated — robust ongoing compliance with equivalent home regime; ESMA reporting kept current

> **Legal advisor note:** The Article 46–47 equivalence regime is narrow and slow. Most third-country firms serving EU retail or elective-professional clients build out an EU subsidiary or branch rather than relying on equivalence. Reverse solicitation remains the only alternative for retail-facing third-country activity, and ESMA's 2021 public statement materially narrowed it. Do not design a third-country crypto-to-RWA distribution model around reverse solicitation without specific legal opinion.

**Reference:** MiFIR Articles 46–49; ESMA Public Statement on Reverse Solicitation (13 January 2021)

---

## SECTION 10 — DATA REPORTING SERVICES PROVIDERS (DRSPs)

*APAs, ARMs, and CTPs are themselves regulated entities. If you intend to operate one as a service to other firms (rather than only consuming the service), the MiFID II Title V authorisation regime applies, with operational obligations set by MiFIR and ESMA-level RTS.*

---

### 10.1 — APA / ARM / CTP Authorisation Path

- [ ] **APA authorisation** (Approved Publication Arrangement) — NCA-authorised under MiFID II Articles 59–65; publishes post-trade reports under MiFIR Articles 20–21
- [ ] **ARM authorisation** (Approved Reporting Mechanism) — NCA-authorised under MiFID II Articles 59–65; submits Article 26 transaction reports on behalf of firms
- [ ] **CTP authorisation** (Consolidated Tape Provider) — **ESMA-authorised** post-2024 review (centralised at ESMA, not NCA-level); selection via competitive tender per asset class; tape must be in production from June 2026 (equities and bonds first)
- [ ] **Operational organisation, conflicts of interest, data quality, business continuity** requirements per ESMA RTS / ITS satisfied

---

### 10.2 — Consolidated Tape (June 2026 — New Regime)

- [ ] **Mandatory contribution** to the EU consolidated tape required for trading venues, APAs, and (for non-equity) SIs once the tape is operational
- [ ] **Revenue-sharing arrangements** with the CTP per the 2024-review distribution model
- [ ] **Latency, completeness, and accuracy** of contributed data tested before tape go-live
- [ ] **Internal use of consolidated tape** evaluated for best-execution (MiFID II Article 27) monitoring and price-discovery

**Reference:** MiFID II Articles 59–65 (DRSP authorisation); MiFIR (as amended by Reg. 2024/791) consolidated tape provisions; ESMA CTP-selection tender process

---

## SECTION 11 — 2024 MIFIR REVIEW — PHASED ROLLOUT MATRIX

*Regulation (EU) 2024/791 entered into force 28 March 2024. Provisions take effect on a staggered timetable through 2026. Plan to end-state, not legacy.*

---

### 11.1 — Effective-Date Cheatsheet

| Date | Provision | What changes |
|---|---|---|
| **28 March 2024** | Regulation in force | Most amendments take effect on entry into force, subject to RTS / ITS revisions |
| **By 29 September 2025** | ESMA monitoring & CTP tender prep | Active CTP-tender process; SI opt-in regime live |
| **March 2026** | Transparency calibration | Revised pre- and post-trade transparency thresholds and deferral regime in force |
| **April 2026** | Expanded Article 26 reporting | New transaction-report and reference-data fields go live |
| **June 2026** | **PFOF ban + CT live** | MiFIR Article 39a PFOF ban applicable; EU consolidated tape operational (equities + bonds first) |

---

### 11.2 — Specific 2024 Changes To Implement

- [ ] **PFOF prohibition (Article 39a)** — investment firms executing orders on behalf of retail / elective-professional clients prohibited from receiving fee / commission / non-monetary benefit from any third party for forwarding orders for execution; **rebuild revenue model if PFOF-dependent**
- [ ] **Share trading obligation (former Article 23) narrowed** — extraterritorial reach removed; share TO now applies only where instrument has a liquid market in the EU; recheck venue-eligibility rules in routing
- [ ] **Volume cap simplified** to single 7% cap (Article 5)
- [ ] **SI regime opt-in** — quantitative SI thresholds removed; deliberate opt-in or opt-out per instrument class
- [ ] **Non-equity transparency simplified** — SSTI regime collapsed; new deferral buckets
- [ ] **Reference data harmonisation** (Article 26 + 27) — new fields rolled out for April 2026
- [ ] **Consolidated tape live** for equities and bonds — June 2026 (derivatives tape follows on a later schedule)
- [ ] **CTP centralisation at ESMA** — single CTP per asset class selected by ESMA tender

**Reference:** Regulation (EU) 2024/791 (MiFIR review); Directive (EU) 2024/790 (MiFID III review companion directive)

---

## SECTION 12 — INNBLOCKCHAIN-SPECIFIC: MiFIR FOR TOKENISED-SECURITIES & DLT MTF OPERATORS

*Tokenisation does not avoid MiFIR. A tokenised transferable security is a financial instrument; trades in it are reportable; venues that match it are subject to Title II transparency. The DLT Pilot Regime grants limited and conditional exemptions only — with compensatory measures.*

---

### 12.1 — Smart Contract → MiFIR Event Mapping

- [ ] **On-chain `OrderCreated` / `OrderModified` / `OrderCancelled` events** designed to be consumable by APA infrastructure (off-chain bridge) at RTS 1 / RTS 2 field granularity
- [ ] **On-chain `Trade` event** carries all RTS 22 reportable fields (instrument ID / price / quantity / counterparties / capacity / time)
- [ ] **LEI registry on-chain** — counterparty wallets bound to LEIs (for legal-person counterparties) and to NCI (for natural persons) before trade execution; "no identity, no trade" enforced at smart-contract level
- [ ] **Block-time vs. "as close to real time as technically possible"** — chain selection (L1 / L2) justified against transparency latency expectations
- [ ] **Atomic settlement implications** — Article 29(2) acceptance-for-clearing logic adapted where DLT TSS handles both trading and settlement

---

### 12.2 — DLT Pilot Regime + MiFIR Interaction

- [ ] **DLT Pilot exemptions identified** — per the operator's specific permission (e.g., disapplication of intermediation requirement, modified settlement timeline, retail-investor access caps)
- [ ] **Compensatory measures** documented and NCA-approved for each exemption
- [ ] **Cap monitoring** — DLT Pilot issuance caps (per Article 3 of the DLT Pilot Regulation) monitored in real time
- [ ] **Transition plan** — if Pilot Regime is sunset or your operations grow beyond Pilot caps, plan to migrate to a non-Pilot MiFIR-fully-compliant architecture

---

### 12.3 — Tokenised-Securities Best-Execution & Order Routing

- [ ] **Best execution monitoring** under MiFID II Article 27 includes on-chain venues; price / cost / speed / likelihood / settlement-certainty captured per execution
- [ ] **Routing across DLT and non-DLT venues** documented; client consent obtained where execution outside trading venues
- [ ] **Failure-mode handling** — chain reorgs, gas spikes, oracle failures — addressed in execution policy

**Reference:** DLT Pilot Regime — Regulation (EU) 2022/858; MiFIR Articles 3–13, 20–21, 26–27; MiFID II Article 27

---

## READINESS SCORECARD — SUMMARY

*Use this scorecard to assess operational readiness. Count completed checkboxes per section.*

| Section | Topic | Items | Ready? |
|---|---|---|---|
| 1 | MiFIR entity & instrument scope | 14 | ☐ |
| 2 | Pre-trade transparency | 23 | ☐ |
| 3 | Post-trade transparency & deferrals | 21 | ☐ |
| 4 | Systematic Internaliser regime | 12 | ☐ |
| 5 | Transaction reporting (Art. 26 + 27) | 22 | ☐ |
| 6 | Derivatives — DTO + clearing interface | 11 | ☐ |
| 7 | Non-discriminatory clearing & access | 7 | ☐ |
| 8 | Product intervention & position limits | 9 | ☐ |
| 9 | Third-country equivalence regime | 6 | ☐ |
| 10 | DRSPs & consolidated tape | 8 | ☐ |
| 11 | 2024 MiFIR review phased rollout | 12 | ☐ |
| 12 | Tokenised-securities / DLT-specific | 11 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** Operationally ready for MiFIR — schedule pre-go-live NCA notification meetings
- **Amber (50–80% complete):** Material operational gaps — close before connecting to APA/ARM/CCP infrastructure or admitting any instrument to trading
- **Red (<50% complete):** Significant build remaining — particularly on transaction reporting (Section 5) and DTO routing (Section 6), which carry the largest enforcement exposure

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for MiFIR-impacted trading venues, investment firms, and DLT operators:**

**Architecture:** MiFIR event-schema design → on-chain `Order` / `Trade` / `Cancel` events mapped 1:1 to RTS 1 / RTS 2 / RTS 22 fields → APA / ARM bridge specification → LEI- and NCI-bound permissioned-token modules

**Build:** ERC-3643 / ERC-1400 permissioned-token contracts that enforce identity at transfer → on-chain order-management modules whose events satisfy pre- and post-trade transparency calibration → settlement modules calibrated to Article 29(2) "as quickly as technically practicable" → DLT MTF / DLT TSS reference-data feed to FIRDS

**Audit:** Independent smart contract security audit → MiFIR-field-coverage audit (every reportable field traceable to an on-chain event) → NCA-readable audit report mapping every contract function to the MiFIR / RTS provision it satisfies

**Why MiFIR-impacted firms choose us:** We don't ship code that "will pass an audit"; we ship code labelled against the regulation. Each `emit Trade(...)` carries the RTS 22 fields the supervisor expects. Your compliance team can reconcile the chain against the NCA reasonableness report by reading the contract, not the trade-blotter.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. MiFIR is supplemented by extensive ESMA Regulatory Technical Standards (RTS), Implementing Technical Standards (ITS), Guidelines, and Q&As that are updated continuously, and was substantially amended by Regulation (EU) 2024/791 with phased application through 2026. Always engage qualified EU financial-services legal counsel for your specific business, instrument class, and jurisdiction.*

*Document version: 1.0 | Last updated: May 2026*
*Regulation reference: Regulation (EU) No 600/2014 of the European Parliament and of the Council of 15 May 2014 on markets in financial instruments and amending Regulation (EU) No 648/2012 (MiFIR) — https://eur-lex.europa.eu/eli/reg/2014/600/oj — as amended by Regulation (EU) 2024/791 (MiFIR review)*
