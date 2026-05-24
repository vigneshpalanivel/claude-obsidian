# MiFID III Delta Readiness Checklist
## The Legal Advisor's Companion to the MiFID II Intake — What the 2024 Review Changes for Investment Firms

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** MiFID/MiFIR Review Package — Directive (EU) 2024/790 + Regulation (EU) 2024/791
**Sources:**
- https://eur-lex.europa.eu/eli/dir/2024/790/oj
- https://eur-lex.europa.eu/eli/reg/2024/791/oj
**Status:** In force since 28 March 2024 — phased application through 30 June 2026; Member State transposition deadline 29 September 2025
**Document type:** Delta assessment — companion to the [MiFID II Business Readiness Checklist](./mifid2-checklist.md)

---

> **Important — read this first.** There is no standalone "MiFID III" regime. Directive (EU) 2024/790 and Regulation (EU) 2024/791 are *amending acts* that modify MiFID II (Directive 2014/65/EU) and MiFIR (Regulation 600/2014). You do not apply for "MiFID III authorization" — you apply for MiFID II authorization that complies with the amendments. This checklist sits **next to**, not instead of, the MiFID II checklist. Work through the full MiFID II intake first. Then use this document to identify which of the 2024 amendments materially change your authorization plan, your business model, your technology stack, or your ongoing obligations.

> **How to use this checklist:** Each section opens with the legacy MiFID II position (the "from"), then states the MiFID III position (the "to"), then lists the concrete actions a new applicant filing in 2026 must take. Items marked ☐ are decisions or build tasks; items marked ⚠️ are deal-breakers — if you cannot resolve them, your business plan is incompatible with the post-2024 regime and you should stop and rebuild before filing.

---

## SECTION 0 — IS YOUR BUSINESS MATERIALLY AFFECTED BY THE 2024 REVIEW?

*Not every MiFID II firm is materially affected by the 2024 amendments. Skim this triage section before reading the rest. If none of the triggers apply to you, the only chapter you must still read is Section 9 (phased dates and RTS watch-list).*

Tick every statement that applies. If any are ticked, the corresponding sections below are mandatory reading.

- [ ] My revenue model involves any form of payment, commission, rebate, or non-monetary benefit from third parties (market makers, venues, liquidity providers) in connection with executing or routing **retail or professional-on-request** client orders → **Section 2 (PFOF ban)**
- [ ] I operate, or am applying to operate, a **multilateral system** of any kind (regulated market, MTF, OTF) — or a hybrid system that brings together multiple third-party buying/selling interests → **Sections 3 + 5 + 6**
- [ ] I currently operate, or expect to qualify as, a **Systematic Internaliser** under MiFID II — or I deal on own account against client orders outside a trading venue → **Section 4**
- [ ] I trade or quote in **non-equity instruments** (bonds, structured finance products, emission allowances, derivatives) and rely on SI pre-trade transparency exemptions or SSTI / LIS waivers → **Sections 4 + 5**
- [ ] I am an **APA, ARM, CTP, or expect to operate as a Designated Publishing Entity (DPE)** under the new data-reporting framework → **Sections 6 + 8 + 9**
- [ ] I execute client orders (Annex I Section A2) or transmit orders for execution (A1) and have a published Order Execution Policy / RTS 28 top-five report → **Section 7**
- [ ] I submit transaction reports under MiFIR Article 26 or reference data under Article 27 → **Section 8**
- [ ] My business plan relies on the legacy **double volume cap** mechanics (4% per venue / 8% EU-wide for the reference price + negotiated trade waivers) → **Section 5**
- [ ] I am building a **DLT MTF / DLT SS / DLT TSS** under the Pilot Regime → **all sections** (the 2024 transparency, CT, and clock-sync provisions apply on top of the Pilot Regime)

> **Legal advisor note:** The 2024 review is the most substantial recalibration of EU secondary-markets structure since MiFID II went live in 2018. It is small in volume (one short directive, one regulation) but high in impact: PFOF, consolidated tape, SI regime, transparency calibration, and best-execution reporting are all rewritten. A firm that authorizes under MiFID II without planning for the 2024 deltas will be re-engineering its systems, policies, and disclosures within 12 months of authorization. Plan for the end-state.

---

## SECTION 1 — MIFID II vs. MIFID III: WHAT EACH ACT DOES

*This section orients you to the structure of the 2024 review so the rest of the checklist makes sense. Skip it if you already know the architecture.*

---

### 1.1 — The Two Amending Acts

| Act | Amends | What it does in one sentence |
|---|---|---|
| **Directive (EU) 2024/790** | MiFID II (Directive 2014/65/EU) | Re-routes definitions and venue obligations to MiFIR, narrows the SI regime to equity-only with a qualitative test, deletes RTS 27 best-execution reporting, extends the three-active-members rule to regulated markets, and adds new sanction-base provisions |
| **Regulation (EU) 2024/791** | MiFIR (Regulation 600/2014) | Establishes the EU consolidated tape (three asset classes), prohibits payment for order flow, replaces the double volume cap with a single 7% EU-wide cap on the reference price waiver, recalibrates pre-trade transparency for equity and non-equity, redesigns the SI regime, expands business-clock synchronisation, and creates the Designated Publishing Entity role |

> **Why two acts?** EU primary law splits substantive market-structure rules into a directly-applicable Regulation (MiFIR — same text in every Member State) and a Member-State-transposed Directive (MiFID II — implemented through national law). The 2024 review preserves that split but materially rebalances which provisions live in which act: more substance is moving into MiFIR (directly applicable, no transposition lag) and less into the Directive.

---

### 1.2 — Where to find the consolidated text

- [ ] Read the *amended* MiFID II — not the 2014 version — when building your policies. The Office of Publications consolidated version reflects all amendments including 2024/790
- [ ] Read the *amended* MiFIR — not the 2014 version — for transparency, transaction reporting, CT, and PFOF rules
- [ ] Track ESMA Level 2 (RTS / ITS) and Level 3 (Guidelines, Q&A) publications continuously — most of the 2024 review's operational detail sits in delegated and implementing acts still in draft as of mid-2026

**Reference:** Directive (EU) 2024/790, Articles 1–3; Regulation (EU) 2024/791, Articles 1–2

---

## SECTION 2 — PAYMENT FOR ORDER FLOW (PFOF) PROHIBITION

*This is the single most-likely business-model deal-breaker in the 2024 review. If your revenue depends on PFOF, your authorization application is dead on arrival in the post-transition end state. Resolve this before any other section.*

---

### 2.1 — What the Prohibition Says (MiFIR Article 39a — new)

**Scope:** Investment firms acting on behalf of **retail clients** or clients categorised as **professional on request** (Annex II Section II of MiFID II) are **prohibited from receiving** any fee, commission, or non-monetary benefit from any third party for executing or forwarding client orders on a particular execution venue.

**Geographic scope:** The prohibition applies to all transactions, regardless of whether they are executed on EU or third-country venues.

**Permitted carve-out:** Client-exclusive rebates, discounts, or non-monetary benefits passed through to the client under venue tariffs that are publicly disclosed and apply uniformly to all venue members do **not** count as PFOF — provided the firm derives no direct or indirect benefit beyond the pass-through.

**Per-se-professional clients and eligible counterparties are out of scope:** The prohibition does **not** apply to relationships with credit institutions, investment firms, insurers, funds, large undertakings, or other Annex II Section I "professional per se" clients.

---

### 2.2 — Triage: Is Your Business Model PFOF-Dependent?

Tick every statement that is true. If any is ticked, you face the prohibition.

- [ ] We receive any payment, commission, or rebate from market makers, liquidity providers, or trading venues in connection with retail client order flow
- [ ] We receive non-monetary benefits (technology, data, research) from third parties in connection with where we route or execute retail client orders
- [ ] We hold or have signed term sheets for any "execution payment" or "order flow agreement" with venues or wholesale market makers
- [ ] Our internal revenue model attributes any portion of retail trading revenue to "venue rebates," "maker-taker fees received," or "PFOF income"
- [ ] We operate a zero-commission retail brokerage funded primarily by execution rebates
- [ ] We pass retail order flow to a single connected market maker on an exclusive or near-exclusive basis with any reciprocal economic arrangement

> **⚠️ Deal-breaker check:** If your zero-commission model is structurally cross-subsidised by PFOF, the model is **not viable** under MiFIR Article 39a from 30 June 2026 (legacy MS exemption sunset) or immediately for new applicants in non-legacy Member States. You need to either (a) reprice the service, (b) shift to per-se-professional or eligible-counterparty client segments only, or (c) operate the order-routing function in a non-EU jurisdiction with no EU-resident retail clients (and rely on a genuine reverse-solicitation defense — narrow).

---

### 2.3 — Legacy Member State Transitional Exemption (Article 39a(2))

A small number of Member States permitted PFOF on a regulated basis before 28 March 2024. Those Member States may temporarily exempt firms authorized in their territory from the prohibition, but **only** for orders of clients **domiciled or established in that Member State**, and only until **30 June 2026**.

- [ ] Identify whether your chosen home Member State has notified ESMA of a legacy PFOF exemption (notification deadline was 29 September 2024)
- [ ] If yes — confirm the scope of the exemption (instruments, client residency, sunset date)
- [ ] If your business plan depends on this exemption — **plan for the 30 June 2026 cliff edge**: by that date, all PFOF must cease for retail and professional-on-request clients across the Union

> **Legal advisor note:** ESMA publishes the list of Member States that have notified the exemption. Do not assume your home Member State is on the list. Confirm in writing with your home NCA before relying on the transitional regime in a business plan.

---

### 2.4 — Build / Policy Actions

- [ ] **Revenue model audit:** Independent finance audit of all third-party revenue streams attributable to client-order execution — broken down by client category (retail / pro-on-request / pro-per-se / ECP) and by venue
- [ ] **Inducements register update:** Existing MiFID II Article 24(9) inducements register must reflect the post-Article 39a scope — anything categorisable as PFOF must be flagged and either restructured or terminated
- [ ] **Order routing logic review:** Smart order router decisions must not be influenced by any third-party benefit to the firm — document and audit the routing-decision criteria
- [ ] **Client disclosure update:** Pre-contractual disclosures and execution policy must explicitly state how the firm is (not) remunerated by third parties for executing client orders
- [ ] **Contractual review:** All venue-tariff agreements, market-maker arrangements, and white-label execution agreements reviewed against Article 39a permitted-carve-out criteria
- [ ] **Transition plan documented** if relying on legacy MS exemption — explicit board-approved plan for ceasing PFOF revenue by 30 June 2026, with replacement revenue sources identified

**Reference:** MiFIR Article 39a (PFOF prohibition — inserted by Regulation (EU) 2024/791); MiFID II Article 24(9) (inducements — unchanged); MiFID II Annex II (client categorisation — unchanged)

---

## SECTION 3 — MULTILATERAL SYSTEMS RE-ROUTED TO MIFIR

*The 2024 review moves the "all multilateral systems must operate as RM / MTF / OTF" rule out of MiFID II and into MiFIR. This is a structural change with practical consequences for hybrid systems, broker-crossing networks, and DLT venues.*

---

### 3.1 — What Changed

**Legacy MiFID II position (Article 1(7), Article 4(1)(19) — now deleted/replaced):** The MiFID II Directive contained both the substantive rule (any system bringing together third-party buying/selling interests must be authorized as a regulated market, MTF, or OTF) and the definition of "multilateral system."

**MiFID III position (MiFIR Article 1 paragraph 5b — new; MiFIR Article 2(1)(11) — new):** Both the substantive rule and the definition are now in MiFIR. New MiFIR Article 1(5b) states: *"All multilateral systems shall operate either in accordance with the provisions of Title II of Directive 2014/65/EU concerning MTFs or OTFs or in accordance with the provisions of Title III of that Directive concerning regulated markets. Systematic internalisers shall operate in accordance with Title III of this Regulation."*

**Practical consequence:** The rule is now **directly applicable** in every Member State — no transposition lag, no national-implementation variance. ESMA and NCAs will enforce it uniformly. The 2021 ESMA report identified material non-compliance among multilateral systems operating outside the RM/MTF/OTF regime; the 2024 move tightens enforcement.

---

### 3.2 — Triage: Are You Operating a Multilateral System?

A "multilateral system" is broadly defined: any system or facility in which multiple third-party buying and selling trading interests in financial instruments are able to interact in the system. This catches more than the typical exchange.

Tick every statement that is true:

- [ ] We operate a platform / venue / facility that brings together two or more third-party orders or quotes in a financial instrument
- [ ] We operate a broker-crossing network, internal liquidity pool, or matching engine that interacts client orders with other client orders or with third-party liquidity
- [ ] We operate a request-for-quote (RFQ) system that allows clients to receive quotes from multiple liquidity providers simultaneously
- [ ] We operate a DLT trading venue under the Pilot Regime (Regulation (EU) 2022/858) — DLT MTFs are multilateral systems by definition
- [ ] We operate an OTC dealing desk that internalises matching client orders against each other (rather than executing each against own capital)

> **⚠️ Deal-breaker check:** If any of the above is true and you are **not** authorized as a regulated market, MTF, or OTF, you are operating an unauthorized multilateral system under MiFIR Article 1(5b). The fix is either (a) authorize as RM/MTF/OTF, (b) reconfigure the system to genuinely operate on a bilateral / own-capital basis as a Systematic Internaliser, or (c) close the multilateral functionality.

---

### 3.3 — Three-Active-Members Rule Extended to Regulated Markets (MiFID II Article 47(1) — amended)

The MiFID II requirement that MTFs and OTFs have at least three materially active members or users (Article 18(7)) is now **also** extended to regulated markets via amendments to Article 47(1).

- [ ] If applying for RM authorization: confirm three or more materially active members or users committed before authorization
- [ ] If applying for MTF/OTF: requirement is unchanged but enforcement is harmonised across venue types

---

### 3.4 — Build / Policy Actions

- [ ] Map every internal system that interacts third-party buying/selling interests; classify each as multilateral (→ RM/MTF/OTF) or bilateral (→ SI / OTC)
- [ ] If operating any RFQ or matching functionality outside an authorized venue: legal opinion on whether the system qualifies as a multilateral system under the new MiFIR Article 2(1)(11) definition
- [ ] For DLT venues: the multilateral-system rule applies on top of Pilot Regime obligations — confirm DLT MTF/DLT TSS authorization is sought

**Reference:** Regulation (EU) 2024/791 amendments to MiFIR Articles 1(5b), 2(1)(11); Directive (EU) 2024/790 deletions of MiFID II Article 1(7), amendments to Article 4(1)(19) and Article 47(1)

---

## SECTION 4 — SYSTEMATIC INTERNALISER REGIME RESET

*The SI regime is fundamentally reshaped: quantitative thresholds are replaced by a qualitative test, the regime is narrowed to equity instruments by default, non-equity SI status becomes opt-in only, and pre-trade transparency obligations are recalibrated.*

---

### 4.1 — What Changed: Equity vs. Non-Equity Bifurcation

**Legacy MiFID II position:** SI status was determined by quantitative thresholds set in Commission Delegated Regulation (EU) 2017/565 (organised, frequent, systematic, substantial — all four measured quarterly by ESMA-published data). The regime applied uniformly to equity and non-equity instruments. Opt-in was permitted.

**MiFID III position (MiFID II Article 4(1)(20) — replaced):** The SI definition now applies on the basis of a **qualitative assessment**, and only to **equity instruments** by default. For non-equity instruments, SI status is **opt-in only**. The full new definition:

> *"systematic internaliser" means an investment firm which, on an organised, frequent and systematic basis, deals on own account in equity instruments by executing client orders outside a regulated market, an MTF or an OTF, without operating a multilateral system, or which opts in to the status of systematic internaliser.*

**Why this matters operationally:**
- Firms no longer perform the quarterly quantitative SI-threshold test for equity (the qualitative test replaces it)
- Non-equity SI obligations no longer apply by default — only to firms that affirmatively opt in
- ESMA stops publishing the quantitative SI-determination data for non-equity instruments

---

### 4.2 — Pre-Trade Transparency Recalibration for SIs

**Equity SIs (MiFIR Articles 14–17 — amended):** Pre-trade quoting obligations continue, but with recalibrated quote-size thresholds:
- Standard market size (SMS) calibration to be revised by ESMA RTS (deadline 29 March 2025)
- Minimum quote size cannot fall below twice the SMS (RTS-specified)
- Pre-trade quoting obligation triggered at narrower size threshold

**Non-equity SIs (MiFIR Articles 18–19 — deleted):** Pre-trade transparency obligations for SI non-equity firm quotes are **deleted**. The rationale (Recital): SI non-equity quotes were customised, of low informational value, and imposed disproportionate operational burden. Non-equity SIs are now subject only to post-trade transparency and transaction-reporting obligations.

---

### 4.3 — Triage and Build Actions

If you currently are, or expect to be, a Systematic Internaliser:

- [ ] **Reclassification analysis:** Apply the new qualitative test to your equity dealing activity — do you deal on own account in equity instruments on an "organised, frequent and systematic" basis outside trading venues? If yes, you are an equity SI by definition (no quantitative safe harbour)
- [ ] **Non-equity opt-in decision:** Decide whether to opt in to SI status for any non-equity instruments — opt-in subjects you to MiFIR transaction reporting and reference data obligations but no longer to pre-trade transparency for firm quotes
- [ ] **SMS calibration monitoring:** Track the ESMA RTS on Standard Market Size — until adopted, current MiFID II RTS 1/2 thresholds remain provisional
- [ ] **Quote engine retooling:** Equity SI quote-engine architecture must adapt to new minimum quote sizes and triggering thresholds (RTS-driven, not currently fixed)
- [ ] **Systems decommissioning:** If currently operating SI quote infrastructure for non-equity instruments without opt-in intent, decommission and migrate to OTC/bilateral reporting
- [ ] **ESMA opt-in registration:** Document the firm's opt-in decision per instrument class and notify the home NCA on the prescribed schedule
- [ ] **Conflict with multilateral system rule:** Confirm the SI activity does not constitute operating a multilateral system (the new MiFIR Article 1(5b) explicitly distinguishes the two — operating both regimes in the same legal entity for the same instrument class is not permitted)

> **Legal advisor note:** Firms that were marginal SIs under the quantitative regime (i.e., crossed the threshold in some quarters but not others) face a meaningful classification change. The qualitative test is bright-line: if you deal in equity on an organised, frequent, and systematic basis, you are an SI. There is no quarterly off-ramp. Plan for permanent equity SI status if your business does any meaningful own-account equity dealing.

**Reference:** MiFID II Article 4(1)(20) (definition — replaced by Directive (EU) 2024/790); MiFIR Articles 14–17 (equity SI quoting — amended by Regulation (EU) 2024/791); MiFIR Articles 18–19 (non-equity SI quoting — deleted); Commission Delegated Regulation (EU) 2017/565 (current SI thresholds — pending RTS replacement)

---

## SECTION 5 — TRANSPARENCY RECALIBRATION (PRE-TRADE AND POST-TRADE)

*The 2024 review simplifies equity transparency mechanics and expands non-equity pre-trade transparency to exchange-traded derivatives and specified OTC derivative classes.*

---

### 5.1 — Equity: Single Volume Cap Replaces Double Volume Cap (MiFIR Article 5 — amended)

**Legacy double volume cap:**
- 4% per venue cap on use of the reference price waiver + negotiated trade waiver
- 8% EU-wide cap on use of the same two waivers combined
- Complex enforcement: venue-specific suspension first, then EU-wide

**New single volume cap:**
- **7% EU-wide cap** on use of the **reference price waiver only** (Article 4(1)(a))
- The **negotiated trade waiver** (Article 4(1)(b)(i)) is **no longer subject to the cap**
- No per-venue threshold — only the Union-wide threshold
- ESMA monitors and publishes monthly collation; Commission may adjust the threshold by delegated act based on ESMA's first review report (due 29 September 2027)

**Build actions:**
- [ ] Review reliance on the reference price waiver against the lower 7% EU-wide cap (was effectively 8% under the legacy regime)
- [ ] Reconfigure trade-flagging systems to distinguish reference-price-waiver flow from negotiated-trade-waiver flow (only the former now counts toward the cap)
- [ ] Update internal monitoring and venue-side capacity for waiver-suspension handling

---

### 5.2 — Equity: Reference Price Waiver Recalibration (MiFIR Article 4 — amended)

The reference price waiver definition is updated — "reference price" is now defined by reference to the volume-weighted spread on order book or market-maker quotes (RTS by 29 March 2025 to specify per asset class).

- [ ] Track ESMA RTS on reference price methodology — current waiver mechanics will change
- [ ] Update price-discovery feeds to align with the new reference price calculation once RTS adopted

---

### 5.3 — Non-Equity Pre-Trade Transparency Expanded (MiFIR Articles 8a, 8b — new)

The 2024 review **introduces** pre-trade transparency for:

- **Exchange-traded derivatives (ETDs)** — bid/offer and depth publication, calibrated by trading-system type
- **OTC derivatives** denominated in euro / JPY / USD / GBP, that are subject to the clearing obligation under EMIR, with specified tenors and (for CDS) reference indices
- **Package orders** (across bonds, structured finance products, emission allowances, derivatives)

Pre-trade transparency obligations are calibrated by trading-system type (order book, quote-driven, request-for-quote, voice, hybrid). Waivers for large-in-scale (LIS) and SSTI (size-specific-to-instrument) are retained but recalibrated by RTS.

- [ ] If you trade ETDs or in-scope OTC derivatives: review whether new pre-trade transparency obligations apply
- [ ] Track ESMA RTS on:
  - [ ] Pre-trade transparency thresholds for derivatives
  - [ ] LIS and SSTI recalibration for non-equity (deadline 29 March 2025)
  - [ ] Package order treatment

---

### 5.4 — Size-Specific-to-Instrument (SSTI) and Standard Market Size (SMS) Recalibration (MiFIR Articles 11, 11a — amended/inserted)

- **Article 11 amended** — SMS calibration revised by RTS per asset class (deadline 29 March 2025)
- **Article 11a inserted** — SSTI thresholds are RTS-driven and tailored per instrument; post-trade deferrals permitted under recalibrated regime

Until ESMA RTS adopted, transitional thresholds apply. For business planning, assume meaningful shifts in both SMS and SSTI thresholds — particularly for less-liquid bonds and derivatives.

- [ ] Watch ESMA Level 2 publications for SMS / SSTI calibration RTS
- [ ] Model business impact of likely threshold changes on non-equity dealing activity

---

### 5.5 — Post-Trade Deferrals

The post-trade deferral regime is consolidated and simplified for non-equity instruments (bonds, derivatives, SFPs). The legacy supplementary deferral regime (4-week deferrals for specific transactions) is replaced by a recalibrated maximum deferral period set by RTS.

- [ ] Review reliance on legacy post-trade deferral regime for non-equity transactions
- [ ] Update post-trade publication workflows once ESMA RTS adopted

**Reference:** Regulation (EU) 2024/791 amendments to MiFIR Articles 4, 5, 8a, 8b, 9, 11, 11a, 14–17

---

## SECTION 6 — CONSOLIDATED TAPE (CT)

*The EU consolidated tape is the structural centrepiece of the 2024 review. Three asset-class tapes will operate under five-year exclusive concessions awarded by ESMA. Mandatory data contribution applies to all in-scope venues and APAs; small venues have opt-out relief.*

---

### 6.1 — Three Consolidated Tapes (MiFIR Articles 27da, 27db — new)

| Asset class | ESMA selection initiated | Provider mandate length |
|---|---|---|
| **Bonds** | First — by 29 December 2024 | 5 years |
| **Shares and ETFs** | Within 6 months of bonds CTP selection | 5 years |
| **OTC derivatives** | Within 3 months of Commission delegated act on derivative identifier, minimum 6 months after shares/ETFs CTP selection | 5 years |

ESMA selects CTPs via competitive procedure based on: technical resilience, governance, data dissemination speed, data-quality methodology, operating costs, fee transparency, business continuity and cyber resilience, energy-mitigation methods, and use of modern interface technologies.

---

### 6.2 — Mandatory Data Contributions (MiFIR Article 22a — new)

**In-scope contributors:** Regulated markets, MTFs, OTFs, APAs, designated publishing entities (DPEs), and systematic internalisers (within scope per asset class).

**Mandatory contribution:**
- Real-time transmission of trading data to the CTP
- Harmonised format and protocol (RTS-specified)
- No remuneration to contributors except via the revenue-redistribution arrangements applicable to bonds (Articles 27h(5)–(7))

**Exemptions:**
- **Small venues** with less than 1% of Union trading volume in the relevant asset class — exempt unless they opt in
- **SME growth markets** where 85%+ of trading is self-execution — exempt
- **Members of the European System of Central Banks** — exempt for monetary/forex/financial-stability transactions

**Build actions:**
- [ ] Confirm whether the firm operates a trading venue, APA, or qualifying SI subject to mandatory data contribution
- [ ] Assess whether small-venue or SME-growth-market exemption applies — and whether opt-in is strategically warranted (for revenue-redistribution participation on bonds)
- [ ] Build harmonised real-time data-transmission infrastructure (RTS-driven, deadline-dependent)
- [ ] Allocate licensing budget for CT consumption (free 15-min delay is available from venues/APAs; CTPs may charge for real-time)

---

### 6.3 — European Best Bid and Offer (EBBO) for Shares and ETFs (MiFIR Article 27g — amended)

The shares/ETFs CTP publishes the **European Best Bid and Offer** (EBBO) — the consolidated best buying and selling price across all contributing venues — but **without the market identifier code (MIC)** of the originating venue. The Commission will assess by 30 June 2026 whether this anonymised EBBO design is sufficient and may propose changes.

- [ ] If operating a venue: prepare for the EBBO publication regime (your venue's quotes feed in, but venue identity does not surface to retail consumers)
- [ ] If consuming CT data: design execution-quality monitoring around EBBO (venue selection cannot rely on MIC in CT feed)

---

### 6.4 — Revenue Redistribution for Bonds CTP (MiFIR Article 27h(5)–(7) — new)

For the **bonds** CTP only, a revenue-redistribution arrangement applies. Contributing venues receive a share of CTP subscription revenue, with the formula weighted (RTS-specified) by:
- Volume of trading on small venues
- New bond issuances
- Pre-trade-transparent trading

This is intended to compensate small venues for the loss of proprietary data revenue. There is **no** revenue redistribution for shares/ETFs or OTC derivatives CTPs.

- [ ] If operating a bond venue: track the revenue-redistribution RTS (deadline 29 December 2024) — affects business case
- [ ] If a small bond venue: opt-in decision must factor projected redistribution revenue

---

### 6.5 — Free Access for Academics, Regulators, Retail

For the **shares/ETFs** CTP, the EBBO and post-trade data must be available free of charge to academics for non-commercial research, to regulators, and (where commercially feasible) to retail investors. This is a Commission-driven public-good provision.

- [ ] If consuming CT data commercially: confirm your usage is paid commercial use (academic/retail free access does not apply to firm-level consumption)

**Reference:** Regulation (EU) 2024/791 amendments inserting MiFIR Articles 22a, 22b, 27da, 27db, 27g, 27h (consolidated tape regime)

---

## SECTION 7 — BEST EXECUTION OVERHAUL

*RTS 27 and RTS 28 reporting are removed; best-execution monitoring obligations are tightened and refocused on retail vs. professional client distinction; the consolidated tape replaces venue-quality reports as the primary data source.*

---

### 7.1 — RTS 27 Repealed; RTS 28 Replaced (MiFID II Article 27 — amended)

**Legacy:** Execution venues published RTS 27 reports (detailed execution-quality metrics by instrument class) annually. Investment firms published RTS 28 reports (top-five execution venues per asset class, plus a qualitative summary of execution quality obtained).

**MiFID III:**
- **RTS 27 is removed** — MiFID II Article 27(2), (3) (old), and (6) deleted. The consolidated tape replaces RTS 27 as the primary execution-quality data source
- **RTS 28 is restructured** — MiFID II Article 27(3) (new), (7), and (10) replaced. Firms must continue to monitor execution effectiveness and notify clients of material changes, but the prescriptive top-five-venue annual report format is replaced by an RTS-driven framework distinguishing retail from professional client treatment (ESMA RTS pending under Article 27(10))

---

### 7.2 — Build / Policy Actions

- [ ] **Order Execution Policy update:** Reflect post-2024 best-execution obligations — retail vs. professional client distinction explicit, with the criteria-weighting methodology documented
- [ ] **Execution-quality monitoring framework:** Transition monitoring data sources from RTS 27 venue reports (no longer published post-transposition) to consolidated tape data
- [ ] **Client notification process:** Document the process for notifying clients of material changes to execution arrangements (now a positive obligation under Article 27(7) new)
- [ ] **Top-five venue report:** Continue current RTS 28 publication discipline until ESMA RTS under new Article 27(10) is adopted — confirm with home NCA whether interim reporting is expected
- [ ] **Venue selection re-justification:** Document venue inclusion in execution policy against the new RTS criteria once published (factors determining venue choice, frequency of policy review, retail/professional weighting)

> **Legal advisor note:** The interim period — between Member State transposition (29 September 2025) and adoption of the Article 27(10) RTS — is the highest risk window for best-execution disputes. Firms should over-document execution decisions during this window rather than rely on legacy RTS 27 / RTS 28 disciplines that are being deprecated.

**Reference:** Directive (EU) 2024/790 amendments to MiFID II Article 27 (paragraphs 2, 3, 6, 7, 10)

---

## SECTION 8 — TRANSACTION REPORTING, REFERENCE DATA, AND DRSP REGIME

*The MiFIR transaction reporting framework is expanded, reference data scope is broadened, and the Data Reporting Service Provider (DRSP) regime gains a new Designated Publishing Entity (DPE) role with cost-based pricing and access obligations.*

---

### 8.1 — Transaction Reporting (MiFIR Article 26 — amended)

- New and amended reporting fields driven by ESMA RTS (deadline 29 December 2024)
- Reporting scope broadly unchanged (T+1 transaction reports via ARM to NCA), but field set expanded particularly for derivative identifiers and counterparty data
- The OTC derivatives identifier delegated act (Commission, deadline 29 June 2024) is a prerequisite for the OTC derivatives CTP timeline

**Build actions:**
- [ ] Map current transaction-reporting fields against the ESMA RTS draft — identify new fields requiring source-system changes
- [ ] Confirm ARM relationship and ARM readiness for new field set
- [ ] For derivatives dealers: implement OTC derivatives identifier once Commission delegated act adopted

---

### 8.2 — Reference Data Reporting (MiFIR Article 27 — amended)

- Reference data scope refined by ESMA RTS (deadline 29 December 2024)
- Single-source criteria for OTC derivatives identifier

**Build actions:**
- [ ] Audit current reference-data submissions against forthcoming RTS
- [ ] Confirm single-source provider for OTC derivatives identifier once Commission delegated act adopted

---

### 8.3 — Designated Publishing Entity (DPE) — New Role (MiFIR Articles 22c, 27f–27i — new/amended)

**What a DPE is:** An investment firm or market operator authorized by ESMA to publish post-trade transparency data on behalf of itself and / or other firms. The DPE role is new in the 2024 framework and supersedes some of the legacy publication responsibilities of APAs.

**Build actions:**
- [ ] **DPE designation decision:** Determine whether to seek DPE designation (relevant for venues, SIs, and large investment firms that internalise reporting at scale)
- [ ] **Operational readiness:** If pursuing DPE designation, build to the ESMA RTS standards (deadline 29 December 2024 for DPE/ARM access, fees, and authorisation criteria) — including cost-based fees, objective access rules, per-service fee disaggregation, and 5-year record retention
- [ ] **Business clock synchronisation:** DPEs join the list of entities subject to clock synchronisation (Article 22c) — alongside venues, members/participants/users, SIs, APAs, and CTPs

---

### 8.4 — Business Clock Synchronisation Expanded (MiFIR Article 22c — new)

**Legacy:** Clock-synchronisation obligation under MiFID II applied to trading venues and their members/participants/users.

**MiFID III:** Now applies additionally to Systematic Internalisers, Designated Publishing Entities, APAs, and CTPs. Accuracy level set by ESMA RTS (deadline 29 December 2024).

- [ ] If you fall in any of the newly-in-scope categories: confirm clock-synchronisation infrastructure aligns with the RTS once adopted (likely UTC-aligned, microsecond-level for venue/SI operations)

**Reference:** Regulation (EU) 2024/791 amendments to MiFIR Articles 22a, 22b, 22c, 26, 27, 27f, 27g, 27h, 27i (data reporting, DPE, clock sync, data quality)

---

## SECTION 9 — PHASED ROLLOUT DATES AND RTS WATCH-LIST

*The 2024 review entered into force 28 March 2024 but operative provisions phase in through 30 June 2026. Many obligations depend on ESMA RTS and Commission delegated acts that were not yet adopted as of the source-text reading. Track these continuously.*

---

### 9.1 — Phased Application Dates

| Date | Event | Source |
|---|---|---|
| **28 March 2024** | Both acts enter into force; PFOF prohibition immediately applicable in non-legacy Member States; multilateral system re-routing immediately effective | Dir. 2024/790 Art. 3; Reg. 2024/791 Art. 2 |
| **29 June 2024** | Commission deadline to adopt delegated act on OTC derivatives identifier | Reg. 2024/791 Art. 27(5) |
| **29 September 2024** | Deadline for Member States to notify ESMA of legacy PFOF exemption | Reg. 2024/791 Art. 39a(2) |
| **29 December 2024** | ESMA RTS submission deadlines: CTP selection (bonds initiated), business clock synchronisation, consolidated tape data quality, transaction reporting fields, reference data, DPE/ARM access and fees | Reg. 2024/791 Arts. 22b(3), 22c(2), 26, 27, 27da, 27i(4a–4b) |
| **29 March 2025** | ESMA RTS submission deadlines: volume cap collation, reference price waiver methodology, SSTI calibration, SMS calibration | Reg. 2024/791 Arts. 4, 5(9), 11, 11a |
| **~June 2025** | ESMA initiates shares/ETFs CTP selection procedure (6 months after bonds) | Reg. 2024/791 Art. 27da(1) |
| **29 September 2025** | **Directive 2024/790 transposition deadline** — Member States must have implemented amendments in national law; single volume cap monitoring begins; pre-trade transparency for derivatives takes effect; venues begin waiver-flagging; first wave of mandatory CT data contributions begins | Dir. 2024/790 Art. 2; Reg. 2024/791 Arts. 5(8), 22a |
| **~Late 2025 – mid 2026** | OTC derivatives CTP selection (3 months after delegated act on derivative identifier; min 6 months after shares/ETFs CTP) | Reg. 2024/791 Art. 27da(1) |
| **30 June 2026** | **PFOF legacy MS exemption expires** — full Union-wide PFOF prohibition in effect for retail and professional-on-request clients; Commission assesses EBBO design for shares/ETFs and may propose legislative amendments | Reg. 2024/791 Art. 39a(2), Recital 26 |
| **29 September 2027** | ESMA first annual volume cap adequacy report — Commission may adjust the 7% threshold by delegated act based on the report | Reg. 2024/791 Art. 5(10) |

---

### 9.2 — RTS / Delegated Acts Watch-List

These Level 2 measures shape day-to-day compliance. Track ESMA publications and Commission adoption status continuously. Items in **bold** are critical-path for authorization or operational readiness.

| Topic | Source Article | RTS Target Date | Compliance Impact |
|---|---|---|---|
| **Volume cap collation methodology** | MiFIR Art. 5(9) | 29 Mar 2025 | Critical — flagging and calculation logic for the 7% cap |
| **CTP selection criteria & bonds revenue redistribution** | MiFIR Arts. 27da, 27h(5) | 29 Dec 2024 | High — affects CTP business case |
| **Business clock synchronisation accuracy** | MiFIR Art. 22c(2) | 29 Dec 2024 | Medium — operational infrastructure |
| **Data quality standards for CT contributors** | MiFIR Art. 22b(3) | 29 Dec 2024 | Critical — CTP operational readiness |
| **Reference price waiver definition** | MiFIR Arts. 4, 7 | 29 Mar 2025 | Medium — current waiver mechanics will shift |
| **SMS and SSTI calibration** | MiFIR Arts. 11, 11a | 29 Mar 2025 | High — affects equity and non-equity dealing strategies |
| **Pre-trade transparency thresholds for derivatives** | MiFIR Arts. 8a, 8b | (RTS pending) | Medium — scope clarity for ETD/OTC derivatives in scope |
| **OTC derivatives identifier (delegated act)** | MiFIR Art. 27(5) | 29 Jun 2024 | Critical — gates OTC derivatives CTP timeline |
| **Transaction reporting fields** | MiFIR Art. 26 | 29 Dec 2024 | High — source-system mapping changes |
| **Reference data fields** | MiFIR Art. 27 | 29 Dec 2024 | High — submission scope changes |
| **DPE/ARM cost-based pricing & access** | MiFIR Art. 27i(4a–4b) | 29 Dec 2024 | Medium — DPE business model |
| **Order execution policy criteria (retail vs. pro)** | MiFID II Art. 27(10) | (RTS pending) | Critical — replaces RTS 28 |
| **Trading halt / circuit breaker principles** | MiFID II Art. 48 / new Art. 90(5) | (RTS pending) | Low — applies to RMs |
| **Post-trade risk reduction services exemption scope** | MiFIR Arts. 31, 32 | (Delegated act pending) | Medium — portfolio compression scope |

---

### 9.3 — Standing Watch Items for Authorization Applicants

- [ ] Subscribe to ESMA press releases and Q&A updates on MiFID/MiFIR review
- [ ] Subscribe to home NCA bulletins on national transposition of Directive (EU) 2024/790
- [ ] Schedule quarterly internal review of RTS adoption status until all listed items are final
- [ ] Build "transitional period contingency" into your authorization application narrative — NCAs will accept that certain operational details depend on RTS adoption, but they expect a clear adaptation plan once RTS are published

---

## SECTION 10 — APPLICATION-PACK ADDENDA FOR FIRMS FILING IN 2026

*If you are filing a new MiFID II authorization application in 2026 — i.e., after entry into force of the 2024 review and after the Directive's transposition deadline — your application dossier must reflect the post-amendment regime, not the legacy regime.*

---

### 10.1 — Application Dossier Additions

In addition to the standard MiFID II application contents (see [mifid2-checklist.md](./mifid2-checklist.md) Section 10.2), include:

- [ ] **PFOF policy statement** — explicit confirmation of how the firm complies with MiFIR Article 39a, including (if applicable) any reliance on the legacy MS exemption and the firm's plan for cessation by 30 June 2026
- [ ] **Multilateral system classification opinion** — legal opinion confirming that any system operated by the firm is correctly classified as RM, MTF, OTF, SI, or bilateral OTC under the post-2024 MiFIR Article 1(5b) regime
- [ ] **SI classification analysis** — if the firm expects to qualify as a Systematic Internaliser, an explicit equity / non-equity assessment under the qualitative test, including any opt-in election for non-equity SI status
- [ ] **Best execution policy** — explicitly reflecting the post-Article 27 (Directive amended) framework, with retail vs. professional client treatment documented and the firm's plan for transitioning execution-quality monitoring off RTS 27 venue data and onto consolidated tape data once available
- [ ] **CT integration roadmap** — if the firm operates a trading venue, APA, SI, or DPE: timeline and architecture for mandatory data contribution to the relevant CTP(s)
- [ ] **DPE designation election** (if applicable) — separate ESMA application and confirmation of operational readiness against the (forthcoming) Article 27i RTS
- [ ] **Business clock synchronisation attestation** — if newly in scope (SI, APA, DPE, CTP) — current clock infrastructure description and adaptation plan once Article 22c RTS adopted
- [ ] **Volume cap monitoring infrastructure** (if operating a trading venue) — system description for flagging reference-price-waiver vs. negotiated-trade-waiver trades and reporting to ESMA
- [ ] **Inducements register** — explicit alignment with both MiFID II Article 24(9) and MiFIR Article 39a — no PFOF-classifiable revenue items

---

### 10.2 — Business Plan Cross-Check Against MiFID III

Before submission, run your 3-year business plan against the following questions. A "Yes" to any of them requires explicit treatment in the business plan narrative.

- [ ] Does any revenue line depend on PFOF? → Section 2 deal-breaker check
- [ ] Does any cost saving depend on legacy double-volume-cap mechanics? → Recalculate against 7% single cap
- [ ] Does the model assume RTS 27 / RTS 28 venue data is available for execution-quality monitoring? → Replace with CT data assumption
- [ ] Does the model assume non-equity SI pre-trade transparency obligations apply (cost) or exemptions apply (advantage)? → Recalibrate against deleted Articles 18–19
- [ ] Does the model assume quarterly SI threshold quantitative test cadence? → Replace with qualitative test
- [ ] Does the model rely on access to bond CT revenue redistribution? → Sensitise against RTS uncertainty

**Reference:** Directive (EU) 2024/790 Article 2 (Transposition — 29 September 2025); Regulation (EU) 2024/791 Article 2 (Application dates — phased)

---

## READINESS SCORECARD — DELTA SUMMARY

*Use alongside the full MiFID II readiness scorecard. Count completed checkboxes per section.*

| Section | Topic | Items | Ready? |
|---|---|---|---|
| 0 | Triage — material impact identification | 9 | ☐ |
| 1 | Architectural orientation | 3 | ☐ |
| 2 | PFOF prohibition (Article 39a) | 16 | ☐ |
| 3 | Multilateral system re-routing | 9 | ☐ |
| 4 | SI regime reset | 8 | ☐ |
| 5 | Transparency recalibration | 11 | ☐ |
| 6 | Consolidated tape integration | 9 | ☐ |
| 7 | Best execution overhaul | 5 | ☐ |
| 8 | Transaction reporting, reference data, DPE | 9 | ☐ |
| 9 | Phased dates and RTS watch-list | 4 | ☐ |
| 10 | 2026-applicant addenda | 15 | ☐ |

**Overall delta assessment:**
- **Green (>80%):** Application pack is post-2024-review-ready
- **Amber (50–80%):** Material delta gaps — close before filing
- **Red (<50%):** Business plan may still be calibrated to the legacy MiFID II regime — re-engineer before engaging the NCA

---

## WORKING WITH INNBLOCKCHAIN — MIFID III SPECIFICS

**Where the 2024 review intersects with our smart-contract and infrastructure work:**

**For DLT MTFs / Pilot Regime applicants:** The DLT Pilot Regime sits alongside MiFID II + MiFID III — it is not a substitute. The 2024 transparency, CT data-contribution, business-clock-synchronisation, and PFOF rules all apply on top of Pilot Regime obligations. We build venue infrastructure that satisfies both: ERC-3643 / ERC-1400 permissioned tokens, on-chain transparency event schemas mapped to MiFIR Articles 3–13, harmonised data-format contribution to (future) CTPs, and clock-synchronisation infrastructure that satisfies the new Article 22c standard.

**For RWA / tokenized-securities issuers operating multilateral matching:** The MiFIR Article 1(5b) clarification means that on-chain matching engines that interact multiple third-party buying/selling interests are multilateral systems — even when the matching logic is encoded in smart contracts. We help issuers structure on-chain trading either (a) as a properly-authorized DLT MTF, or (b) as bilateral SI matching with each transaction documented as a single-counterparty trade against the firm's own capital.

**For SIs operating on-chain quote engines:** We build the qualitative-test evidentiary record (quote frequency, organisation, systematic-basis indicators) and the equity-specific quote-engine logic at the new SMS-driven thresholds.

**For investment firms with PFOF-adjacent on-chain revenue (e.g., MEV capture, validator rebates, on-chain auction proceeds):** We map the Article 39a analysis to on-chain revenue mechanics and help structure the order-routing logic to satisfy both the "no firm benefit beyond pass-through" carve-out and the inducements-register obligation.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. The MiFID/MiFIR review package is subject to national transposition measures, ESMA Regulatory Technical Standards and Implementing Technical Standards, Commission delegated and implementing acts, and ongoing ESMA Level 3 guidance — most of which were in draft or pending adoption as of the source-text reading date. Always engage qualified EU financial-services legal counsel for your specific business, instrument scope, and home Member State.*

*Document version: 1.0 | Last updated: May 2026*
*Sources: Directive (EU) 2024/790 of the European Parliament and of the Council of 28 February 2024 amending Directive 2014/65/EU on markets in financial instruments — https://eur-lex.europa.eu/eli/dir/2024/790/oj ; Regulation (EU) 2024/791 of the European Parliament and of the Council of 28 February 2024 amending Regulation (EU) No 600/2014 — https://eur-lex.europa.eu/eli/reg/2024/791/oj*
