# Market Abuse Regulation Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide to Inside Information, Insider Lists, Managers' Transactions & Market-Abuse Prohibitions Under MAR

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU Market Abuse Regulation (MAR) — Regulation (EU) No 596/2014, as amended by Regulation (EU) 2024/2809 (EU Listing Act)
**Source:** https://eur-lex.europa.eu/eli/reg/2014/596/oj
**Status:** Directly applicable since **3 July 2016** — substantively amended by the EU Listing Act, in force **4 December 2024**, with further MS-transposition measures and Art 2 point (6)(a)(b)(c)(e) amendments applying from **5 June 2026**
**Document type:** Operational readiness assessment — focuses on the ongoing-disclosure machinery a financial-instrument issuer or market participant must run continuously once admitted (or pending admission) to trading

---

> **Who this document is for:** Founders, CFOs, GCs, Heads of IR, Heads of Compliance, Heads of Market Operations, and PDMRs at companies that (i) are about to be admitted to trading on an EU RM / MTF / OTF / SME growth market, (ii) are already admitted and need to absorb the **Listing Act MAR amendments** (in force since 4 December 2024), (iii) operate as an investment firm placing or executing in MAR-scope instruments, (iv) operate as a market operator running surveillance, or (v) produce investment recommendations. This checklist mirrors the operational-readiness intake a specialist EU market-conduct lawyer would walk you through.

---

> **How MAR pairs with the other instruments in the EU stack:** MAR is the **ongoing-disclosure** counterpart to the Prospectus Regulation's **offer-time** disclosure. Once a transferable security is admitted to trading, the issuer's substantive obligation moves from "publish a prospectus" (one-shot, Prospectus Reg) to "disclose inside information continuously, keep an insider list, report PDMR transactions, never tip or manipulate" (continuous, MAR). MiFID II controls **who can be authorised** to operate venues / be investment firms; MiFIR controls **what happens on the market** (transparency, transaction reporting); MAR controls **how that market is allowed to be used** (no insider dealing, no manipulation, mandatory disclosure of inside info). For prospectus content / exemptions / scrutiny see [[prospectus-checklist.md]]. For the package of 2024 changes (which cuts across all three) see [[eu-listing-checklist.md]]. For MiFID/MiFIR transparency and reporting see [[mifir-checklist.md]] and [[mifid2-checklist.md]].

---

> **The 2024 Listing Act amendments to MAR are the operative baseline.** Regulation (EU) 2024/2809 entered into force on 4 December 2024 and changes a material portion of MAR — most importantly the **Article 17 protracted-process disclosure rule (narrowed to final event only)**, the **Article 19 PDMR threshold raise (€5k → €20k, MS opt-up to €50k)**, the **Article 5 buy-back single-NCA reporting routing**, the **Article 30 administrative-sanctions recalibration with SME-proportionate floors**, and the **new Articles 25a and 25b** (cross-border order-data and collaboration platforms). If your MAR procedure manual was last reviewed before December 2024, it is out of date. This checklist is calibrated to the post-Listing-Act regulation.

---

## SECTION 1 — DOES MAR APPLY TO YOU?

*MAR is a Regulation, directly applicable. It binds the moment a financial instrument enters MAR-scope, regardless of whether the issuer is itself an authorised entity. The scope test is **instrument-based**, not **entity-based** — this is the most common scoping mistake.*

---

### 1.1 — Instrument Scope — Is Your Instrument Caught by Article 2?

Tick every row that describes an instrument you issue, hold, trade, or admit. **Each row independently triggers MAR.**

- [ ] **Financial instruments admitted to trading on a regulated market (RM)** in an EU/EEA Member State (or for which a request for admission has been made) — Art 2(1)(a)
- [ ] **Financial instruments traded on an MTF**, or admitted to trading on an MTF / for which a request for admission has been made — Art 2(1)(b). **Includes SME growth markets and DLT MTFs.**
- [ ] **Financial instruments traded on an OTF** — Art 2(1)(c)
- [ ] **Financial instruments not covered by (a), (b), or (c), whose price or value depends on or has an effect on the price or value of a financial instrument in (a)–(c)** — Art 2(1) final paragraph (e.g. OTC derivatives referencing an admitted equity)
- [ ] **Behaviour in relation to auctioned products under EU ETS** (emission allowances, auction products) — Art 2(2)
- [ ] **Spot commodity contracts (other than wholesale energy products)** where the transaction has an effect on the price/value of a financial instrument in (a)–(c) — Art 2(2)(a)
- [ ] **Behaviour in relation to benchmarks** (incl. submission of false / misleading input data) — Art 2(2)(c)
- [ ] **Tokenised transferable securities** — caught **as their underlying instrument class** (the DLT form does not change MAR scope); see Section 10
- [ ] **Behaviour outside the EU in relation to instruments in (a)–(c)** — Art 2(4): MAR has **extraterritorial reach** to actions abroad relating to in-scope EU instruments

> **The instrument trigger is the binding one.** A non-EU issuer whose tokenised security has been admitted to an EU DLT MTF is in MAR scope. A pre-listing issuer that has filed a request for admission is in MAR scope. The fact you do not yourself hold an EU authorisation is irrelevant.

---

### 1.2 — Out-of-Scope Test — Carve-Outs and Boundaries

Confirm none of these put you fully out of scope:

- [ ] **No instrument admitted, traded, or under request for admission** on any EU venue at all → MAR has nothing to attach to (until any of those conditions changes)
- [ ] **Operations by Member States, ESCB members, ministries** in the conduct of monetary, exchange-rate, public-debt or climate-policy operations *(Art 6)*
- [ ] **Wholesale energy products** outside MAR — covered by REMIT (Reg (EU) No 1227/2011) instead
- [ ] **MiCA-classified crypto-assets** (asset-referenced tokens, e-money tokens, other MiCA crypto-assets) that are **not** also financial instruments → outside MAR; MiCA Title VI has a parallel market-abuse regime for those

> **Boundary with MiCA market abuse.** MiCA Title VI (Arts 86–92) extends a *similar* prohibition on insider dealing, unlawful disclosure of inside information, and market manipulation to crypto-assets in scope of MiCA. MAR applies to **financial instruments**; MiCA Title VI applies to **MiCA crypto-assets**. The classification decision determines the regime. A tokenised transferable security goes through MAR. An asset-referenced token goes through MiCA Title VI. The two regimes are similar but not identical — penalties, scope of "inside information", and competent-authority allocation differ.

**Reference:** MAR Articles 1, 2 (Scope), 6 (Exemption for monetary/public debt/climate policy); MiCA Title VI (Articles 86–92).

---

### 1.3 — Entity Role Map — Which MAR Obligations Bite Whom?

Tick every role that describes you. Each adds a distinct MAR obligation stack.

- [ ] **Issuer** (financial instrument is or will be admitted to trading) — primary obligation set: Art 17 disclosure, Art 18 insider lists, Art 19 PDMR notifications, Art 5 buy-back safe harbour, Art 16(2) suspicious-order/transaction reporting on its own trading, Art 11 market-sounding disclosing-side rules
- [ ] **Participant in the financial market** other than issuer — e.g. investment firm, market maker, SI — primary: Arts 14/15 prohibitions, Art 8 insider-dealing rules, Art 11 market-sounding receiving-side rules, Art 16(2) suspicious-order/transaction reporting (STOR) on client business
- [ ] **Person Discharging Managerial Responsibilities (PDMR)** at an issuer — Art 3(1)(25): member of administrative / management / supervisory body, or senior executive with regular access to inside information and authority to take managerial decisions affecting the issuer's future developments — must notify Art 19 transactions
- [ ] **Person closely associated with a PDMR** — Art 3(1)(26): spouse / equivalent, dependent children, other relative sharing household ≥1 year, controlled legal person / trust / partnership — must also notify under Art 19
- [ ] **Market operator / venue operator (RM, MTF, OTF, SMEGM, DLT MTF)** — primary: Art 4 instrument notifications, Art 16(1) systems and procedures to detect and report market abuse
- [ ] **Investment firm placing or executing client orders** in MAR-scope instruments — Art 16(2) STOR duty
- [ ] **Person professionally arranging or executing transactions** (PPAET) — Art 16(2) STOR duty
- [ ] **Producer of investment recommendations or information recommending an investment strategy** — Art 20 disclosure of interests + objective-presentation rules
- [ ] **Disseminator of investment recommendations** (rebroadcast / republish) — Art 20 reduced obligations
- [ ] **Media (journalist / press)** publishing inside information or recommendations — Art 21 special regime accommodating press freedom
- [ ] **Competent authority** of a Member State — primary: Arts 22–23 supervisory powers; Arts 24–25 cooperation; Arts 30–34 sanctioning
- [ ] **Third-country counterparty acting in scope of Art 2(4)** — MAR applies extraterritorially to your behaviour in EU-instrument markets

**Reference:** MAR Articles 3 (Definitions), 16 (Prevention and detection), 22 (Competent authorities); recital 8 (instrument-based scope), recital 25 (PDMR definition).

---

## SECTION 2 — EXEMPTIONS — BUY-BACKS AND STABILISATION

*The Article 5 safe harbour is the most operationally important of the MAR exemptions for listed issuers. Mis-running a buy-back outside the safe harbour can convert routine treasury activity into market manipulation. The Listing Act simplified the reporting routing but did not change the substantive conditions.*

---

### 2.1 — Article 5 Buy-Back Programme Safe Harbour

If you intend to repurchase your own shares as a listed issuer, confirm:

- [ ] **Sole purpose** of the buy-back is (i) reducing capital, (ii) meeting obligations from debt instruments convertible into equity, or (iii) meeting obligations from employee share / option schemes *(Art 5(2))*
- [ ] **Full details of the programme are disclosed before the start** — start date, end date, maximum consideration, maximum number of shares, max price per share *(Art 5(1)(a))*
- [ ] **Trades are reported as belonging to the buy-back programme** to the **competent authority of the most relevant market in terms of liquidity** as referred to in **MiFIR Article 26(1)** *(Art 5(3) as amended by Listing Act)*. The receiving NCA forwards on request to other NCAs.
- [ ] **Programme respects price and volume conditions** set out in Commission Delegated Regulation (EU) 2016/1052
- [ ] **Programme is publicly disclosed within 7 daily market sessions** of each transaction's execution
- [ ] **No trading during a closed period** for the issuer (Art 19(11) interaction)
- [ ] **No selling of own shares** during the programme
- [ ] **No transactions in a period of self-imposed restriction** following a tender offer

> **Listing Act change (in force since 4 December 2024):** buy-back reporting is now routed to a **single NCA** (the one for the most relevant market in liquidity terms), **not** to every NCA where the shares trade. Internal trade-reporting routing must be updated to feed that single NCA only. The receiving NCA forwards on request — you no longer need to file in parallel to every venue's NCA.

---

### 2.2 — Article 5 Stabilisation Safe Harbour

For underwriters / managers stabilising the secondary market after a public offer or admission to trading:

- [ ] Stabilisation period and conditions set in advance per Commission Delegated Reg (EU) 2016/1052
- [ ] Adequate public disclosure of stabilisation arrangements before the offer's first trading day
- [ ] Reports to NCA of every stabilisation transaction within 7 daily market sessions
- [ ] Stabilisation must not be conducted above the offer price
- [ ] Coordinator / stabilising manager designated and disclosed

---

### 2.3 — Article 6 Public-Policy Exemption (most issuers skip)

- [ ] Operation is by a Member State, ESCB member, ministry, or designated body in pursuit of monetary, exchange-rate, public-debt management, or **climate** policy — Listing Act-era recognition of climate-policy operations is preserved
- [ ] If yes, MAR's prohibitions and obligations do not apply to those operations (transactions, orders, behaviour)
- [ ] Not relevant for private-sector issuers

**Reference:** MAR Articles 5 (Buy-back / stabilisation), 6 (Public-policy exemption); Commission Delegated Regulation (EU) 2016/1052 (Buy-back and stabilisation RTS).

---

## SECTION 3 — INSIDE INFORMATION AND THE INSIDER-DEALING PROHIBITION

*"Inside information" is the foundational concept of MAR. Article 7's four-limb definition is the single most-litigated provision and the source of most enforcement actions. Get the definition wrong and every downstream obligation (Article 17 disclosure, Article 18 insider lists, Article 19 PDMR notifications, Articles 8–10 dealing/disclosure prohibitions) is misaligned.*

---

### 3.1 — Article 7 Definition — Four Limbs

Inside information means (any one of):

- [ ] **(7(1)(a))** Information of a **precise nature**, not made public, relating directly or indirectly to one or more issuers / financial instruments, which if made public would be **likely to have a significant effect on price** of the instrument or related derivatives
- [ ] **(7(1)(b))** For commodity derivatives: information of a precise nature, not made public, relating directly or indirectly to one or more such derivatives or to the related spot commodity contract, where the information would be likely to have a significant effect on price of the derivative or spot contract, and where the information is reasonably expected to be disclosed or required to be disclosed under EU/national law
- [ ] **(7(1)(c))** For emission allowances or auctioned products: information of a precise nature, not made public, relating directly or indirectly to one or more such instruments, which if made public would be likely to have a significant effect on price; or for emission-allowance market participants (EAMPs) of an emission-allowance market participant: precise non-public information likely to significantly affect price of the allowance, auction product, or related derivative
- [ ] **(7(1)(d))** For persons charged with execution of client orders: information conveyed by a client relating to the client's pending orders, of a precise nature, relating to one or more financial instruments, which if made public would be likely to have a significant effect on price

---

### 3.2 — "Precise" — Article 7(2) Two-Limb Test

Information is precise if (cumulatively):

- [ ] Indicates a **set of circumstances** which exists, or which **may reasonably be expected to come into existence**, **or** an event which has occurred or may reasonably be expected to occur
- [ ] Is **specific enough** to enable a conclusion to be drawn as to the possible effect of those circumstances or that event on the price of the financial instrument

---

### 3.3 — Protracted Processes (Article 7(2) + 7(3)) — THE post-Listing-Act analysis

Under the post-Listing-Act regime, **intermediate steps** in a protracted process can still constitute inside information for purposes of Articles 8, 9, 10, 14, but the **Article 17 disclosure trigger** has been narrowed to the **final event only**. Keep these two analyses distinct.

- [ ] You have mapped each of your in-flight protracted processes (M&A targets / preliminary terms, regulatory approvals, drug-trial outcomes, contract award decisions, restructurings, capital-markets actions)
- [ ] For each, you have identified the **set of intermediate steps** that constitute precise information likely to significantly affect price
- [ ] You have classified intermediate steps as either:
  - **Inside information for Articles 8–10 / 14 purposes** (insider lists must include them; insider-dealing / unlawful-disclosure prohibitions apply) — YES, always
  - **Triggering Article 17 disclosure obligation** — NO under the post-Listing-Act regime; only the **final event** triggers disclosure
- [ ] You have updated your protocol so that intermediate-step information is **kept confidential under new Article 17(1a)** until disclosure of the final event
- [ ] Documented list of "final events" for each protracted process — Commission empowered to update a non-exhaustive list via delegated act

**Reference:** MAR Articles 7(1)–(4) (Inside information); Article 7(2)–(3) (Protracted processes); CJEU Geltl v. Daimler (C-19/11) on "may reasonably be expected"; Article 17(1) + (1a) as amended by Listing Act.

---

### 3.4 — Articles 8–10, 14 Prohibitions — The Core Bans

For every person who possesses inside information, the following are prohibited:

- [ ] **Insider dealing (Art 8(1))** — using inside information by acquiring or disposing of, for own or third-party account, the financial instruments to which the information relates (directly or indirectly)
- [ ] **Recommendation or inducement (Art 8(2))** — recommending that another person engage in insider dealing, or inducing another to do so
- [ ] **Cancellation or amendment of an order (Art 8(1) final subparagraph)** — once a person has inside information, cancelling or amending an existing order in the relevant instrument counts as insider dealing
- [ ] **Unlawful disclosure (Art 10)** — disclosing inside information to any other person except in the normal exercise of an employment / profession / duties
- [ ] **Onward disclosure (Art 10(2))** — disclosing a recommendation or inducement under Art 8(2), where the disclosing person knew or should have known it was based on inside information
- [ ] **Insider-dealing prohibition (Art 14(a))** — applies to any person referenced in Art 8
- [ ] **Recommendation/inducement prohibition (Art 14(b))**
- [ ] **Unlawful-disclosure prohibition (Art 14(c))**

---

### 3.5 — Article 9 Legitimate Behaviour Safe Harbours

You may need to invoke one of these:

- [ ] **(9(1))** Conduct as a market maker / authorised counterparty discharging their function legitimately
- [ ] **(9(2))** Trade pursuant to a pre-existing legal obligation that became due *(NB: the obligation must have arisen before the inside information was acquired)*
- [ ] **(9(3))** Use of inside information solely to comply with an obligation under acquisition of a holding / takeover
- [ ] **(9(4))** Decisions taken on the basis of publicly available information / one's own analysis (information that does **not** constitute inside information)
- [ ] **(9(5))** Mergers / public takeover bids — conducting due diligence and concluding the transaction based on inside information learned during DD does not constitute insider dealing if the information is **only used to conclude the merger / takeover**

> **All Article 9 carve-outs are narrow.** Use of inside information for an **unrelated** transaction is not protected. Internal "Chinese wall" / information-barrier evidence is the practical demonstration that the carve-out applies.

**Reference:** MAR Articles 7–10, 14; Article 9 safe harbours.

---

## SECTION 4 — MARKET SOUNDINGS (Article 11)

*Market soundings cover communication of information before announcement of a transaction (e.g. block trade, rights issue, M&A) to gauge investor interest. Article 11 sets out the only safe-harbour route for disclosing what would otherwise be inside information.*

---

### 4.1 — Disclosing-Side Procedure (Art 11(3)–(5))

If you (issuer / second-line seller / placement agent) intend to make a market sounding, confirm:

- [ ] **Pre-sounding assessment**: before disclosing, you have considered whether the sounding will involve disclosure of inside information; the conclusion is recorded with reasons (Art 11(3))
- [ ] **Consent of the receiver** obtained before disclosure (Art 11(5)(a))
- [ ] **Receiver informed** that they are prohibited from using or attempting to use the information for own / third-party account in instruments to which it relates (Art 11(5)(b))
- [ ] **Receiver informed** that they are prohibited from cancelling / amending orders in the instrument once they have the information (Art 11(5)(c))
- [ ] **Receiver informed** of confidentiality and onward-disclosure rules under Article 10 (Art 11(5)(d))
- [ ] **Written record** of all information given, identity of receivers, date/time of each disclosure (Art 11(5) final subparagraph)
- [ ] On request, written record is provided to the competent authority (Art 11(6))
- [ ] If the information later **ceases to constitute inside information**, the disclosing party notifies the receiver as soon as possible (Art 11(6))
- [ ] All procedures comply with **ESMA Guidelines on persons receiving market soundings** (MAR Art 11(11) deliverable; current ESMA guidelines)

### 4.2 — Receiving-Side Procedure

- [ ] Internal procedure to assess whether information received in a sounding is inside information
- [ ] Insider list maintained covering persons in receipt
- [ ] No trading / cancellation / amendment in the relevant instrument until information is public or ceases to be inside information
- [ ] Documented audit trail of every sounding received

**Reference:** MAR Article 11 (Market soundings); Commission Delegated Regulation (EU) 2016/960 + ESMA Guidelines.

---

## SECTION 5 — MARKET MANIPULATION (Articles 12, 13, 15)

*Market manipulation under Article 12 is broader than insider dealing — it covers behaviour, not just possession of information. The list of indicators in Annex I (referred to via RTS) is the operative reference for any compliance / surveillance build.*

---

### 5.1 — Article 12(1) Definition — Four Limbs

Market manipulation shall comprise the following activities:

- [ ] **(12(1)(a))** Entering into a transaction, placing an order to trade, or any other behaviour that **gives, or is likely to give, false or misleading signals** as to supply, demand, or price; **or** secures the price at an abnormal or artificial level (unless legitimate reasons + accepted market practice)
- [ ] **(12(1)(b))** Entering a transaction / order / behaviour affecting price through the use of **fictitious devices, deception, or contrivance**
- [ ] **(12(1)(c))** Dissemination of information through any media (incl. internet, social media, AI bots) that **gives, or is likely to give, false or misleading signals**, or **secures the price at an abnormal or artificial level**, where the person knew or should have known the information was false or misleading
- [ ] **(12(1)(d))** Transmitting false or misleading information or providing false or misleading inputs in relation to a **benchmark** where the person knew or should have known it was false or misleading

### 5.2 — Article 12(2) Non-Exhaustive List of Behaviours Treated as Manipulation

- [ ] Securing a dominant position over supply/demand resulting in fixing of prices (12(2)(a))
- [ ] Buying or selling at the open or close of the market to mislead investors using closing prices (12(2)(b)) — including ETFs and NAV-based products
- [ ] Order placement (incl. cancellation/modification) by any available trading means including electronic means (HFT) — disrupting / delaying the functioning of the trading system, making it harder for others to identify genuine orders, creating false or misleading signals (12(2)(c)) — **layering, spoofing, quote stuffing, momentum ignition all explicitly within scope**
- [ ] Taking advantage of media access to voice opinion about an instrument while having previously taken positions and profiting from the resulting price movement, without proper disclosure of conflict (12(2)(d)) — **pump-and-dump including social-media / influencer pumps**
- [ ] Buying / selling of emission allowances or related derivatives in the auction context with the effect of fixing the auction-clearing price at an abnormal or artificial level (12(2)(e))

### 5.3 — Article 13 Accepted Market Practices

- [ ] If a practice could be argued to manipulate under Article 12 but is in fact an **accepted market practice** authorised by an NCA, confirm:
  - [ ] Practice is published on the NCA's website
  - [ ] Practice meets ESMA criteria (transparency, safeguards against abuse, etc.)
  - [ ] Practice was notified to ESMA
- [ ] AMPs are jurisdiction-specific — list them per Member State of operation

### 5.4 — Article 15 Prohibition

- [ ] All persons subject to MAR scope are prohibited from engaging in or **attempting to engage in** market manipulation

**Reference:** MAR Articles 12 (definition), 13 (accepted market practices), 15 (prohibition); Annex I (indicators); Commission Delegated Regulation (EU) 2016/522 (RTS for indicators).

---

## SECTION 6 — ISSUER ONGOING-DISCLOSURE OBLIGATIONS

*This is the section every already-listed issuer must read. Articles 16–19 are where Listing Act amendments most heavily impact day-to-day compliance.*

---

### 6.1 — Article 16 Prevention and Detection of Market Abuse

For market operators and investment firms:

- [ ] **(16(1) — venues)** RM / MTF / OTF operators have effective arrangements, systems, and procedures to **prevent and detect** insider dealing, market manipulation, and attempts thereof; report suspicious orders / transactions / attempts immediately to NCA without delay (STOR — Suspicious Transaction and Order Report)
- [ ] **(16(2) — firms)** Investment firm / PPAET (person professionally arranging or executing transactions) maintains effective arrangements and systems and procedures; if reasonable suspicion of insider dealing / market manipulation / attempt → immediate STOR to NCA without delay
- [ ] **Internal escalation protocol** for STOR triggering: surveillance hit → compliance review → STOR file
- [ ] **STOR template** per Commission Delegated Regulation (EU) 2016/957
- [ ] **Record-keeping** of all suspicions analysed, including those that did not result in a STOR — 5 years
- [ ] **Surveillance system in place** for layering / spoofing / quote stuffing / momentum ignition / cross-market manipulation
- [ ] **For DLT MTFs**: surveillance covers on-chain manipulation vectors — wash trading via smart-contract self-trades, front-running by validators / sequencers, oracle manipulation, sandwich attacks where the instrument is in MAR scope

---

### 6.2 — Article 17 Public Disclosure of Inside Information — THE Listing Act Change

This is the single most operationally significant change in MAR since 2014. The Listing Act narrows the disclosure trigger to the **final event** of a protracted process; intermediate steps must still be kept confidential.

- [ ] **(17(1) as amended)** Issuer informs the public **as soon as possible** of inside information which directly concerns it
- [ ] **(17(1) second sentence — NEW)** The requirement does **not** apply to inside information related to **intermediate steps** in a protracted process under Art 7(2)–(3) **where those steps are connected with bringing about or resulting in particular circumstances or a particular event**. In a protracted process, **only the final circumstances or final event** shall be disclosed, as soon as possible after they have occurred.
- [ ] **(17(1a) — NEW)** Issuer ensures **confidentiality** of intermediate-step inside information until disclosure of the final event under paragraph 1
- [ ] **(17(2))** Issuer must post and maintain on its website all inside information it is required to disclose publicly for **at least 5 years**
- [ ] **(17(4))** Delayed disclosure is available if (cumulatively):
  - [ ] Immediate disclosure is **likely to prejudice the legitimate interests** of the issuer
  - [ ] Delay is **not likely to mislead the public**
  - [ ] Issuer is **able to ensure confidentiality** of the information
- [ ] **(17(4) final subparagraph)** When inside information is no longer confidential / when delay would mislead the public → issuer must disclose without delay
- [ ] **(17(4) record-keeping)** Issuer records the decision to delay, the time inside information arose, the time disclosure took place
- [ ] **(17(5))** Credit institutions and financial institutions may delay further to preserve financial stability, with NCA consent
- [ ] **(17(7))** **Leak management** — if confidentiality is no longer ensured (rumours, leaks, accidental disclosure), issuer discloses without delay; if delay was in force under (4), the delayed disclosure obligation is triggered as soon as the issuer becomes aware of the leak
- [ ] **(17(8))** Selective disclosure — if an issuer or person acting on their behalf discloses inside information in the normal exercise of employment / profession / duties to a third party, full disclosure must be made simultaneously to the public (intentional) or as soon as possible (unintentional)
- [ ] **(17(9))** Public disclosure made in a manner enabling fast access and complete, correct, timely assessment

**Internal artefacts your disclosure committee must own:**

- [ ] **Disclosure committee charter** updated for post-Listing-Act regime
- [ ] **Inside-information register** with timestamps for: information arose / Article 17(4) delay decided / Article 17(1) final-event trigger / disclosure released
- [ ] **Protracted-process register** mapping in-flight protracted processes to their identified "final events"
- [ ] **Insider list** (Article 18) maintained in parallel — intermediate-step information that does **not** trigger Article 17(1) still places people on the insider list
- [ ] **PR/IR Q&A playbook** updated: how to respond to analyst questions about intermediate steps without selectively disclosing inside information not yet at the Article 17(1) trigger
- [ ] **Leak-response protocol** under Article 17(7)
- [ ] **Board minutes** for every delayed-disclosure decision

**Reference:** MAR Article 17 as amended by Listing Act Article 2(5); ESMA Guidelines on delayed disclosure under Article 17(4); Commission Implementing Regulation (EU) 2016/1055 (technical means of public disclosure).

---

### 6.3 — Article 18 Insider Lists

Insider lists remain mandatory regardless of the Article 17 protracted-process narrowing. Anyone with access to inside information — including intermediate-step information — is on the list.

- [ ] Issuer (and any person acting on its behalf / on its account) draws up and maintains an insider list of all persons who have access to inside information
- [ ] Insider list includes:
  - [ ] Identity of each insider (full name, surname at birth where different)
  - [ ] Reason for inclusion
  - [ ] Date / time on which insider obtained access
  - [ ] Date the list was drawn up
- [ ] **Per-event sections**: the list is divided into separate sections per item of inside information (so a deal-specific insider list is the unit, not a single rolling list)
- [ ] **Permanent insider section**: persons with constant access to inside information (board, executive committee, GC, CFO, head of IR, etc.) — Listing Act has not abolished this concept though ESMA Q&A has tightened the boundary
- [ ] **Updated promptly** whenever there is a change of reason, additional insiders, end of access
- [ ] **Retained for at least 5 years** after creation or update
- [ ] **Provided to NCA on request as soon as possible**
- [ ] **Insider acknowledgment**: each insider is informed in writing of MAR obligations, sanctions, and their inclusion on the list
- [ ] **SME growth markets**: Art 18(6) lighter regime — only persons with regular access to inside information need to be on the list; full list provided on NCA request only

**Reference:** MAR Article 18; Commission Implementing Regulation (EU) 2016/347 (insider-list format).

---

### 6.4 — Article 19 Managers' Transactions (PDMR Notifications) — THE Listing Act €5k → €20k Change

Pre-Listing-Act, PDMRs and persons closely associated had to notify on aggregate transactions ≥ €5,000 per calendar year. **The Listing Act raised this to €20,000 (default) / €50,000 (MS opt-up)**, in force since 4 December 2024.

- [ ] **(19(1))** PDMR / closely-associated person notifies the issuer **and** the NCA of every transaction conducted on own account in shares / debt instruments of the issuer or derivatives / other linked instruments — promptly, **no later than 3 business days** after the transaction
- [ ] **(19(1a) — as amended by Listing Act)** The notification obligation applies once the **total amount of transactions** has reached a threshold of **€20,000** within a calendar year. Member States may opt to set a **higher threshold of €50,000** (Art 19(9))
- [ ] **(19(2))** Issuer makes the information public within **3 business days** of the transaction
- [ ] **(19(3))** Issuer ensures the information is publicly disclosed in a manner enabling fast access on a non-discriminatory basis
- [ ] **(19(5))** Issuer draws up a list of PDMRs and closely-associated persons
- [ ] **(19(7))** PDMR notifies the issuer of closely-associated persons; closely-associated persons listed
- [ ] **(19(11) — closed periods)** PDMR shall not conduct any transactions on its own account or for a third party (directly or indirectly), relating to the shares / debt of the issuer / derivatives or other linked instruments, during a **closed period of 30 calendar days before** the announcement of an interim financial report or year-end report that the issuer is obliged to make public
- [ ] **(19(12))** Issuer may allow a PDMR to trade in the closed period on a case-by-case basis under (a) exceptional circumstances (e.g. severe financial difficulty requiring immediate share sale) or (b) due to the characteristics of trading involved (e.g. transactions made under, or related to, an employee share or saving scheme, qualification or entitlement of shares, or transactions where the beneficial interest in the relevant security does not change)
- [ ] **PDMR education**: every PDMR has signed acknowledgement of MAR obligations, the €20k/€50k aggregation rule, the closed-period rule, and notification timing
- [ ] **Notification template**: Commission Implementing Regulation (EU) 2016/523
- [ ] **Internal aggregation engine**: the €20k threshold is **annual aggregate**, not per-transaction — internal systems aggregate correctly

**Reference:** MAR Article 19 as amended by Listing Act Article 2(7); Commission Implementing Regulation (EU) 2016/523 (PDMR notification template); Commission Delegated Regulation (EU) 2016/522 (criteria for permitted trades during closed periods).

---

## SECTION 7 — INVESTMENT RECOMMENDATIONS AND MEDIA (Articles 20, 21)

*Article 20 applies to anyone producing investment recommendations or information recommending an investment strategy. Article 21 carves out media / journalists subject to professional norms.*

---

### 7.1 — Article 20 Investment Recommendations

If you produce investment research or any recommendation / proposal for an investment strategy in relation to financial instruments:

- [ ] **Producer rules**: present recommendations objectively + disclose interests / conflicts of interest (Art 20(1))
- [ ] **Disseminator rules** (rebroadcast / republish): lighter — disclose source and any material changes, indicate the original producer
- [ ] **Templates / standards**: Commission Delegated Regulation (EU) 2016/958 (RTS for technical arrangements)
- [ ] **For social-media / influencer-driven recommendations**: yes, Article 20 applies; non-disclosure of holdings while recommending is the textbook pump-and-dump pattern under Art 12(2)(d)

### 7.2 — Article 21 Media Carve-Out

- [ ] Disclosure / dissemination of information for purposes of **journalism / other form of expression in the media** is assessed taking account of:
  - [ ] Freedom of the press / freedom of expression rules
  - [ ] Codes governing the journalist profession
- [ ] Exception does **not** apply if:
  - [ ] The person derives directly or indirectly an advantage / profit from the disclosure
  - [ ] The disclosure / dissemination was made with the intent to mislead the market

---

## SECTION 8 — COMPETENT AUTHORITY COOPERATION (Arts 22–29)

*This section is largely procedural for issuers, but PDMRs and compliance officers should understand the supervisory architecture because it determines who you talk to and what they can demand.*

---

### 8.1 — Competent Authority Designation (Art 22)

- [ ] Each Member State has designated **a single administrative competent authority** for MAR purposes
- [ ] You have confirmed which NCA is your **home** NCA for MAR (typically the same as MiFID II home NCA where applicable; for issuer-only, the NCA of the home Member State per Art 2(1)(i) of the Prospectus Regulation)
- [ ] You have confirmed the home NCA's MAR-specific contact / portal (typically separate from the MiFID II authorisation portal)

### 8.2 — Powers of Competent Authorities (Art 23)

NCAs may (without prejudice to judicial process):

- [ ] Access documents and data in any form; require record of telephone / electronic communications; require existing records from telecoms operators (with judicial approval where required)
- [ ] Carry out on-site inspections (other than at private residences without judicial approval)
- [ ] Refer matters for criminal prosecution
- [ ] Require existing recordings of telephone conversations held by investment firms / credit institutions / financial entities
- [ ] Require freezing / sequestration of assets
- [ ] Suspend trading of the financial instrument
- [ ] Require temporary cessation of any practice or conduct
- [ ] Take all necessary measures to ensure correct information of the public
- [ ] **You have a documented incident-response process for receiving and responding to NCA requests under Art 23 without delay**

### 8.3 — Cross-Border Cooperation (Arts 24–26)

- [ ] **ESMA coordination (Art 24)** — NCAs cooperate via ESMA
- [ ] **NCA-to-NCA cooperation (Art 25)** — including the new mechanism for cross-border order data and collaboration platforms under **new Articles 25a and 25b inserted by the Listing Act**
- [ ] **New MAR Article 25(4) — Listing Act inserted paragraph** — NCA of the most relevant market under MiFIR Art 26 may obtain order data from a trading venue with significant cross-border dimension
- [ ] **Third-country cooperation (Art 26)** — MAR-relevant for non-EU groups; cooperation arrangements with third-country supervisors
- [ ] **Personal data and third countries (new Art 29)** — Listing Act-inserted GDPR-aligned framework for transferring personal data to third countries for market-abuse investigations

**Reference:** MAR Articles 22–29 (Competent authority architecture); new Articles 25a, 25b, 29 inserted by Listing Act Article 2.

---

## SECTION 9 — ADMINISTRATIVE SANCTIONS AND ENFORCEMENT (Arts 30–34) — RECALIBRATED BY LISTING ACT

*Article 30(2) sets minimum-maximum administrative pecuniary sanctions. The Listing Act recalibrated the floors to be SME-proportionate and aligned with turnover percentages. This is the section every compliance committee must re-model.*

---

### 9.1 — Sanction Tiers (Art 30(2) as amended by Listing Act)

**Article 17 infringements (inside-information disclosure failures)**:

- [ ] Maximum pecuniary sanction: **at least 2 % of total annual turnover** according to the last available accounts approved by the management body
- [ ] Floor: **at least €2 500 000**
- [ ] SME alternative floor: Member States may set a minimum of **at least €1 000 000** for SMEs
- [ ] Recidivism: NCAs may apply higher amounts

**Article 18 and 19 infringements (insider lists / managers' transactions failures)**:

- [ ] Maximum pecuniary sanction: **at least 0.8 % of total annual turnover**
- [ ] Floor: **at least €1 000 000**
- [ ] SME alternative floor: Member States may set a minimum of **at least €400 000** for SMEs

**Articles 14 and 15 infringements (insider-dealing / market-manipulation prohibitions)**:

- [ ] Legal persons: at least **€15 000 000** or 15 % of total annual turnover (whichever is higher)
- [ ] Natural persons: at least **€5 000 000**

**Articles 16 and 17 STOR failures + general infringements**:

- [ ] Legal persons: at least **€2 500 000** or 2 % of total annual turnover
- [ ] Natural persons: at least **€1 000 000**

**Disgorgement (Art 30(2)(g))**:

- [ ] **At least three times** the amount of profits gained or losses avoided because of the infringement

**Non-monetary measures (Art 30(2)(a)–(f))**:

- [ ] Public statement indicating the natural / legal person and nature of the infringement
- [ ] Order to cease and desist
- [ ] Disgorgement of profits
- [ ] Withdrawal / suspension of authorisation
- [ ] Temporary ban on management function for natural persons
- [ ] Temporary ban from dealing on own account in financial instruments

---

### 9.2 — Exercise of Supervisory Powers and Imposition of Sanctions (Art 31)

NCAs apply sanctions taking into account:

- [ ] Gravity and duration of the infringement
- [ ] Degree of responsibility of the person
- [ ] Financial strength of the person (e.g. total annual turnover; net worth for natural persons)
- [ ] Importance of the profits gained / losses avoided
- [ ] Cooperation with the competent authority
- [ ] Previous infringements by the person
- [ ] Measures taken to prevent its repetition

---

### 9.3 — Whistleblower Reporting (Art 32)

- [ ] Effective mechanisms to enable reporting of actual or potential MAR infringements
- [ ] **Procedures for receiving reports**: specific channels, secure, confidential
- [ ] **Protection from retaliation, discrimination, unfair treatment** for whistleblowers
- [ ] **Protection of personal data** of reporter and accused
- [ ] **Whistleblower protection extends to financial incentives in some MS** (Art 32(4) — MS option)

---

### 9.4 — Publication of Decisions (Art 34)

- [ ] NCA publishes every decision imposing administrative sanction or other measure
- [ ] Identity of the person and nature of the infringement disclosed
- [ ] Right to appeal indicated
- [ ] Anonymous publication permitted in limited circumstances (juvenile, disproportionate damage, ongoing investigation jeopardy)
- [ ] Published for **at least 5 years**

**Reference:** MAR Articles 30 (Sanctions), 31 (Exercise of powers), 32 (Whistleblower reporting), 33 (Exchange with ESMA), 34 (Publication of decisions); CRIM-MAD (Directive 2014/57/EU) for criminal sanctions in parallel.

---

## SECTION 10 — TOKENISED INSTRUMENTS UNDER MAR

*Tokenised transferable securities are financial instruments. The DLT form does not change MAR scope. The on-chain visibility of order flow and the smart-contract execution environment do, however, change the surveillance, insider-list, and confidentiality mechanics.*

---

### 10.1 — Scope Confirmation

- [ ] **Classification first**: tokenised instrument is a financial instrument (MAR applies) **or** a crypto-asset (MiCA Title VI applies). The substantive prohibitions are similar but the legal regime is distinct. Do not assume one covers the other.
- [ ] If financial instrument and admitted (or pending admission) on a DLT MTF / DLT TSS → MAR applies in full

### 10.2 — On-Chain Surveillance

For DLT MTFs and tokenised-issuer compliance teams:

- [ ] **Wash trading** detection — on-chain self-trades, cross-wallet self-trades by the same controller — addressable via clustering analysis
- [ ] **Layering / spoofing** — orders placed and cancelled before execution; detect via order-book replay against on-chain or off-chain order books
- [ ] **Front-running by validators / sequencers / MEV searchers** — Art 12 manipulation if conducted in MAR-scope instruments; surveillance must cover the consensus / sequencing layer
- [ ] **Oracle manipulation** — feeding false price data → Art 12(1)(c)/(d) manipulation (information / benchmark)
- [ ] **Sandwich attacks** — front + back-run a victim trade; Art 12(2)(c) practice
- [ ] **Smart-contract upgrade events** — upgrade / migration / parameter change involving in-scope instruments → assessed under Art 7 protracted-process analysis

### 10.3 — Insider-List Challenges On-Chain

- [ ] **Pseudonymous wallet holders** receiving inside information via off-chain channels still go on the Art 18 insider list with the controller's real-world identity
- [ ] **Multi-sig key holders** at the issuer go on the permanent insider section
- [ ] **Smart-contract developers with upgrade authority** — depends on whether the role gives access to inside information; usually yes for the development team during the period of an undisclosed material upgrade

### 10.4 — Confidentiality vs On-Chain Transparency

- [ ] **Article 17(1a) confidentiality of intermediate steps** must be reconciled with on-chain visibility of staking / governance / vote events that occur as intermediate steps of a protracted process
- [ ] Where intermediate steps occur on-chain (e.g. a governance vote that materially affects the instrument), the public-disclosure analysis must address whether the on-chain event itself constitutes the "final event" or remains an intermediate step
- [ ] Document the disclosure-committee position on this for every in-flight on-chain protracted process

### 10.5 — PDMR Wallet Monitoring

- [ ] PDMRs disclose all controlled wallets that may hold the issuer's tokens or derivatives referencing them
- [ ] €20k / €50k threshold applies on aggregate **fiat-equivalent value** across all controlled wallets, not per-wallet
- [ ] Closed-period restrictions apply equally to on-chain transactions

---

## SECTION 11 — DOCUMENTATION CHECKLIST FOR THE FIRST ADVISORY MEETING

*Bring the following to your first specialist consultation so the lawyer can scope the engagement on first meeting.*

---

### 11.1 — Corporate / Issuer Documents

- [ ] Current **shareholder register** and cap table
- [ ] **Articles of association** and any shareholder agreements
- [ ] **Board composition** + committee charters (audit, disclosure, risk)
- [ ] **PDMR list** + persons closely associated (and how relationships are tracked)
- [ ] **Closed-period calendar** — interim / year-end reporting dates plus 30-day windows
- [ ] **Existing insider list policy** + sample insider list
- [ ] **Existing disclosure committee charter** + standing meeting cadence

### 11.2 — Process / Procedure Documents

- [ ] **Inside-information register** template + sample entries from the last 12 months
- [ ] **Article 17(4) delayed-disclosure decisions log** for the last 24 months
- [ ] **Article 5 buy-back programme** documentation (if applicable) — start/end dates, ceiling, daily reporting evidence
- [ ] **Market-sounding log** — both disclosing and receiving side
- [ ] **STOR (Art 16) procedure** + log of STORs filed in last 12 months
- [ ] **Leak-response protocol** under Art 17(7)
- [ ] **Whistleblower channel** (Art 32) — provider, escalation path, statistics

### 11.3 — Listing Act Migration Inputs

- [ ] **Date of last MAR procedure review** — if pre-December 2024, full migration is required
- [ ] **Protracted processes currently live** — for each, has it been re-mapped to "final event" under post-Listing-Act Article 17(1)?
- [ ] **PDMR notification template** — has it been updated to the €20k / €50k threshold?
- [ ] **Buy-back reporting routing** — has it been re-routed to the single "most relevant market" NCA under MiFIR Art 26?
- [ ] **PR / IR Q&A playbook** — has it been updated for intermediate-step confidentiality?

### 11.4 — Cross-Reference Reading List (priority order)

1. This document (mar-checklist)
2. [[eu-listing-checklist.md]] — Listing Act delta navigation (MAR is Article 2 of Reg 2024/2809; Section 4 of that checklist mirrors much of this one)
3. [[prospectus-checklist.md]] — offer-time disclosure counterpart
4. [[mifid2-checklist.md]] — investment-firm authorisation envelope (for firms with STOR / surveillance duties)
5. [[mifir-checklist.md]] — transparency, transaction reporting, Article 26 "most relevant market" determination feeding buy-back reporting
6. [[mica-checklist.md]] — only for crypto-asset perimeter; MiCA Title VI is the MAR analogue for MiCA crypto-assets (parallel regime, distinct rules)
7. [[dlt-pilot-checklist.md]] — only for DLT MTF / DLT TSS candidacy
8. [[gdpr-checklist.md]] — interaction with personal data in insider lists, PDMR notifications, surveillance recordings

---

## SECTION 12 — RED FLAGS THAT WILL DERAIL A MAR-ERA OFFERING OR ONGOING-COMPLIANCE PROGRAMME

*Items below frequently cause first-meeting deal-breakers, restatements, or NCA enforcement attention.*

- [ ] Issuer **disclosed intermediate steps** of a protracted process after 4 December 2024 — over-disclosure under the new Article 17 standard; analyst confusion + drift-disclosure litigation risk
- [ ] Issuer **failed to disclose** the **final event** of a protracted process "as soon as possible" because of an old delayed-disclosure decision predicated on intermediate-step framing — Article 17(1) breach with 2 % turnover / €2.5M sanctions exposure
- [ ] **Insider list** is a single rolling list rather than per-event sections — non-compliant with Article 18; ESMA Q&A has been unambiguous on this point
- [ ] **PDMR threshold** still applied as €5k per the pre-Listing-Act regime — under-notification means under-disclosure; sanctions exposure under Art 30(2) at 0.8 % turnover / €1M floor
- [ ] **PDMR aggregation** applied per-transaction rather than annual aggregate — common technical breach
- [ ] **Buy-back reporting** routed to all NCAs in the pre-Listing-Act pattern, missing the single-NCA routing under amended Article 5(3)
- [ ] **Closed period** treated as 30 trading days rather than 30 calendar days
- [ ] **Insider acknowledgment** missing — Art 18 requires written acknowledgment of obligations and sanctions by each insider; common documentation gap
- [ ] **STOR** filed late or not filed because of internal review delays — Art 16(2) requires immediate STOR "without delay"; multi-week internal-investigation pipelines are non-compliant
- [ ] **Market sounding** records incomplete — no consent log, no list of receivers, no information given log
- [ ] **On-chain wallet** holdings of PDMRs not disclosed because "they aren't traded shares" — wallets holding the issuer's tokens or derivatives are in scope; failure to monitor and aggregate is an Art 19 breach
- [ ] **Tokenised issuance** assumed under MiCA when the instrument is a transferable security — MAR (not MiCA Title VI) is the live market-abuse regime
- [ ] **Delayed-disclosure decision** taken without recording the three Article 17(4) conditions — admissibility risk if NCA challenges the delay
- [ ] **Sanctions exposure** still modelled against pre-2024 administrative-sanction caps — re-model under new Art 30(2) tiers

---

## APPENDIX A — KEY LEGAL REFERENCES

- **MAR (consolidated):** Regulation (EU) No 596/2014 of the European Parliament and of the Council of 16 April 2014 on market abuse — https://eur-lex.europa.eu/eli/reg/2014/596/oj
- **Listing Act (MAR amendments via Article 2):** Regulation (EU) 2024/2809 of 23 October 2024 — https://eur-lex.europa.eu/eli/reg/2024/2809/oj
- **CRIM-MAD (parallel criminal regime):** Directive 2014/57/EU of 16 April 2014 on criminal sanctions for market abuse
- **Buy-back / stabilisation RTS:** Commission Delegated Regulation (EU) 2016/1052
- **STOR template:** Commission Delegated Regulation (EU) 2016/957
- **Market-sounding RTS:** Commission Delegated Regulation (EU) 2016/960
- **Indicators of manipulation:** MAR Annex I + Commission Delegated Regulation (EU) 2016/522
- **Investment recommendations RTS:** Commission Delegated Regulation (EU) 2016/958
- **Insider list format:** Commission Implementing Regulation (EU) 2016/347
- **PDMR notification template:** Commission Implementing Regulation (EU) 2016/523
- **Public disclosure means:** Commission Implementing Regulation (EU) 2016/1055
- **ESMA Q&A on MAR:** https://www.esma.europa.eu/policy-rules/market-abuse-mar
- **ESMA Guidelines on delayed disclosure (Art 17(4)):** ESMA/2016/1478
- **ESMA Guidelines on persons receiving market soundings (Art 11):** ESMA/2016/1477

---

## APPENDIX B — DELTA-ONLY SUMMARY FOR ALREADY-LISTED ISSUERS POST-LISTING-ACT

If you are **already listed** and reading this checklist for ongoing-compliance impact only, the operational priorities are:

1. **Article 17 protracted-process** — rewrite disclosure-committee playbook for "final event only"; preserve Article 17(1a) intermediate-step confidentiality; update analyst-Q&A scripts **(highest impact)**
2. **Article 19 PDMR €20k threshold** — update PDMR policy, intranet guidance, notification templates, internal aggregation engine
3. **Article 5 buy-back reporting** — re-route to single "most relevant market" NCA per MiFIR Art 26
4. **Article 30 sanctions** — re-model exposure under new tiers (2 % turnover / €2.5M for Art 17; 0.8 % / €1M for Arts 18-19; SME alternatives €1M / €400k)
5. **Cross-border surveillance** — engage with new MAR Arts 25a, 25b mechanisms if applicable; expect more efficient cross-border market-abuse detection
6. **Article 29 personal-data-to-third-countries** — confirm internal procedure aligns with the new GDPR-aligned framework
7. **Insider lists** — confirm per-event sections + Listing Act has not changed Article 18 substantively; do not over-rotate

Everything else in this checklist is for **new admissions / IPOs**, **investment firms with surveillance duties**, **market operators**, or **DLT MTF operators** with tokenised-instrument specifics.

---

*End of checklist. Last updated 2026-05-25. Source: MAR.html → Regulation (EU) No 596/2014 as amended by Reg (EU) 2024/2809.*
