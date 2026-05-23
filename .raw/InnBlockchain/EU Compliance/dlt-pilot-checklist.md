# DLT Pilot Regime Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for Operators of Tokenized-Securities Market Infrastructure in the EU

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU Pilot Regime for Market Infrastructures Based on Distributed Ledger Technology — Regulation (EU) 2022/858
**Source:** https://eur-lex.europa.eu/eli/reg/2022/858/oj
**Status:** Applicable since 23 March 2023 *(Article 19)*; sunset originally 23 March 2026, extendable up to a further 3 years (currently extended through 2029); EU Commission Market Integration Package (April 2026) proposes permanent status with €100bn cap — **not yet adopted**
**Document type:** Pre-engagement readiness assessment — to be completed before formal specific-permission application to the home NCA

---

> **Who this document is for:** Founders, exchange operators, CSD executives, and investment-firm executive teams approaching legal counsel for the first time to determine whether their planned tokenized-securities **trading**, **settlement**, or **combined trading-and-settlement** infrastructure can operate in the European Union under the DLT Pilot Regime. This checklist mirrors the intake assessment a specialist EU financial-markets-infrastructure lawyer would walk you through in a first advisory session.

---

> **How to use this checklist:** The DLT Pilot Regime is **not** a standalone authorisation regime — it is a *targeted exemption layer* on top of an existing MiFID II investment-firm / market-operator licence or a CSDR central-securities-depository licence. Item one is therefore: do you already hold (or are you eligible for) the underlying licence? Work through each section in order. Every checkbox represents a concrete requirement or decision you must resolve. Items you cannot tick represent gaps that must be closed before you file a specific-permission application.

---

> **DLT Pilot vs. MiCA vs. MiFID II — the boundary question:** A *tokenized financial instrument* (tokenized share, bond, fund unit, money-market instrument) is a **MiFID II financial instrument** that happens to be issued on DLT — it is **not** a MiCA crypto-asset (MiCA Article 2(4)(a) carve-out). The DLT Pilot Regime is the dedicated infrastructure path for *trading and settling* those instruments. If your token is a stablecoin, utility token, or other non-financial-instrument crypto-asset, you are in the MiCA / CASP regime, not the DLT Pilot. Get this classification wrong and your licence, prospectus regime, and infrastructure path are all wrong.

---

## SECTION 1 — DO YOU NEED A DLT PILOT REGIME PERMISSION?

*The DLT Pilot Regime is opt-in. You only need it if you want the targeted MiFID II / MiFIR / CSDR exemptions it provides. If you can operate within standard MiFID II / CSDR rules — which is increasingly difficult for natively-tokenized securities — you do not need to enter the pilot.*

---

### 1.1 — Is the DLT Pilot Regime the Right Framework for You?

Answer each question. If most are **Yes**, the pilot is the right framework.

- [ ] Are you planning to **operate an EU market infrastructure** (trading venue, settlement system, or both) for financial instruments?
- [ ] Will the financial instruments be **issued, recorded, transferred, and stored on DLT** (public, private permissioned, or hybrid)?
- [ ] Are the instruments **MiFID II financial instruments** (shares, bonds, money-market instruments, UCITS units) — not crypto-assets, stablecoins, or unregulated tokens?
- [ ] Do you need **at least one exemption** from MiFID II / MiFIR (for a DLT MTF) or CSDR (for a DLT SS) to make your business model work — e.g. direct retail access without intermediation, settlement on-chain rather than via a licensed CSD, atomic settlement rather than T+2?
- [ ] Are you prepared to operate under **enhanced ongoing supervision** by your home NCA and ESMA in exchange for those exemptions?

> **Legal advisor note:** Most operators discover they need the pilot for one of three reasons: (i) **DLT MTF** — they want to give retail investors direct access to a trading venue, which standard MiFID II prohibits; (ii) **DLT SS** — they want to settle in central-bank money / e-money / stablecoins on-chain without routing through a traditional CSD; or (iii) **DLT TSS** — they want **atomic settlement** (matching and settlement in a single on-chain transaction) which is structurally impossible under MiFID II / CSDR because trading venues and CSDs must be legally separated. If none of these three barriers blocks your model, you may not need the pilot at all.

**Reference:** Regulation (EU) 2022/858 Articles 1 (subject matter), 4 (DLT MTF exemptions), 5 (DLT SS exemptions), 6 (DLT TSS exemptions)

---

### 1.2 — Scope Exclusions and Confusions

The DLT Pilot Regime does **not** apply to the following. Check any that describe your situation:

- [ ] You are issuing or trading **MiCA crypto-assets** (ART, EMT, other crypto-assets) → MiCA regime, not DLT Pilot
- [ ] You are issuing or trading **NFTs that are not financial instruments** → out of scope of both regimes (subject to general consumer law)
- [ ] You are providing **custody-only** services for tokenized securities and operate no trading or settlement function → standard MiFID II / CSDR custodian rules; not a pilot use case
- [ ] You are a **DeFi protocol with no identifiable operator** → the pilot requires a licensed legal entity to hold the permission; "fully decentralised" is not a pilot pathway
- [ ] You are operating **outside the EU** with no EU-resident participants → no EU territorial nexus; pilot does not apply
- [ ] Your instruments are **sovereign bonds with issuance size ≥ €1 billion** → fail the Article 3(1)(b) cap; in practice almost all sovereign issuance is over the cap, so sovereign bonds are *de facto* excluded — but the regulation does not name them as a category-level exclusion

> **Legal advisor note:** "Fully decentralised" is **not** a get-out under the DLT Pilot Regime in the way it (narrowly) is under MiCA Recital 22. The pilot is built around an authorised, identifiable, supervised legal entity that holds the specific permission. If your architecture genuinely has no operator, the pilot is the wrong framework — and so is MiFID II.

**Reference:** Regulation (EU) 2022/858 Article 2 (definitions), Article 3 (eligibility restrictions); MiCA Article 2(4)(a) (financial-instrument carve-out)

---

### 1.3 — Underlying Licence Pathway

The pilot is a *layer* on an existing authorisation. Identify your base regime:

- [ ] **MiFID II investment firm** authorised for operation of an MTF → eligible to operate a **DLT MTF** *(Article 8)*
- [ ] **Market operator** authorised under MiFID II → eligible to operate a **DLT MTF** *(Article 8)*
- [ ] **CSD** authorised under Regulation (EU) 909/2014 (CSDR) → eligible to operate a **DLT SS** *(Article 9)*
- [ ] **Investment firm / market operator** intending to also perform settlement → eligible to apply for a **DLT TSS** permission *(Article 10)* without holding a separate CSD licence — the pilot specifically allows a non-CSD to operate settlement when combined with trading
- [ ] **CSD intending to also perform trading** → eligible to apply for a DLT TSS permission *(Article 10)* without holding a separate MTF licence
- [ ] **New entrant with no underlying licence** → apply for the base MiFID II / CSDR authorisation **and** the DLT-specific permission in a single coordinated process. The NCA may grant authorisation and permission simultaneously *(Article 8(2) / 9(2) / 10(2))*

> **Critical structural point — DLT TSS is the unique combined permission:** Under standard MiFID II + CSDR, the trading venue and the CSD must be legally separate entities. The DLT TSS permission *expressly waives* this separation, allowing a single firm to match orders and settle them atomically on the same DLT. This is the most powerful structure in the regime — and the reason LISE and 21X AG built as DLT TSS rather than MTF + SS.

> **Legal advisor note — 18-month coordination reality:** The 21X AG DLT TSS permission required coordinated review by BaFin, the Bundesbank, ESMA, and the ECB across approximately 18 months. Budget a similar timeline for a TSS file. DLT MTF (e.g., 360X AG, ~6–9 months) and DLT SS (Clearstream D7) are simpler because only one of the two supervisory tracks is in play.

**Reference:** Regulation (EU) 2022/858 Articles 8, 9, 10 (specific permissions)

---

## SECTION 2 — WHAT INFRASTRUCTURE TYPE ARE YOU?

*The Pilot Regime defines three — and only three — types of DLT market infrastructure. Pick your type at intake; it determines your exemption set, your base regulator track, and the compensatory measures you must propose.*

---

### 2.1 — Infrastructure Classification Decision Tree

Identify which category applies. **You can only hold one of these three permissions per legal entity.**

#### ☐ TYPE A — DLT Multilateral Trading Facility (DLT MTF)
*A trading venue that admits only DLT financial instruments. Settlement happens off-platform, through a CSD or a separate DLT SS.*

- You match buy and sell orders in DLT financial instruments
- You do not perform settlement yourself — final settlement is delivered to a CSD, a DLT SS, or directly between counterparties' wallets
- Your typical exemption ask: direct admission of natural and legal persons as members/participants (extension of MiFID II Article 53(3) under Article 4(2) of the pilot), and/or modified transaction-reporting under MiFIR Article 26 (Article 4(3) of the pilot)

**Underlying licence required:** MiFID II investment firm OR market operator with MTF authorisation
**Reference operator:** 360X AG (BaFin authorised April 2025)
**Key article:** Regulation (EU) 2022/858 Article 4

---

#### ☐ TYPE B — DLT Settlement System (DLT SS)
*A settlement system that settles transactions in DLT FIs against payment or against delivery, irrespective of whether designated under Directive 98/26/EC, AND that allows the initial recording of DLT FIs OR the provision of safekeeping services in relation to DLT FIs *(Article 2(7))*.*

- You settle DLT FI trades (typically initiated elsewhere — on a regulated market, MTF, OTF, or DLT MTF)
- **OR / AND** you act as the initial registrar of newly-issued DLT FIs
- **OR / AND** you safekeep DLT FIs for clients
- Your typical exemption ask: alternative to traditional securities-account model (book-entry obligation under CSDR Article 3), recognition of DLT addresses / wallets as the official register, alternative settlement currency (commercial bank money in tokenised form, e-money tokens) where central-bank money is impractical

**Underlying licence required:** CSDR-authorised CSD
**Reference operator:** Clearstream D7 DLT (Oct 2024)
**Key article:** Regulation (EU) 2022/858 Article 5

---

#### ☐ TYPE C — DLT Trading and Settlement System (DLT TSS)
*A combined system that performs both trading-venue functions AND settlement functions, in a single legal entity, using the same DLT.*

- You match orders AND settle them atomically on-chain in one operation
- You bypass the traditional MiFID II / CSDR separation between venue and CSD
- Your typical exemption set is the *union* of Article 4 and Article 5 exemptions

**Underlying licence required:** MiFID II investment firm / market operator **OR** CSDR-authorised CSD — the pilot permits a TSS operator to hold *only one* of the two and apply for the combined permission
**Reference operators:** 21X AG (BaFin Dec 2024), LISE / Lightning Stock Exchange (AMF Oct 2025)
**Key article:** Regulation (EU) 2022/858 Article 6

---

> **Intended permission structure:** The regulation contemplates one permission per legal entity — DLT MTF (Article 8), DLT SS (Article 9), or DLT TSS (Article 10). Articles 8(1) and 9(1) gate DLT MTF and DLT SS on different underlying licences (investment firm / market operator vs. CSD), so the same legal entity will only fit one path unless it holds both underlying licences (rare). If you want both trading and settlement under the pilot, the cleanest answer is a DLT TSS (Type C); separate DLT MTF + DLT SS entities in the same group is an alternative if you have legitimate reasons to keep the activities legally separate.

> **Legal advisor note — choice of type drives the regulator:** A DLT MTF is supervised by the NCA's securities-markets team; a DLT SS by the central-bank / CSD-supervision team; a DLT TSS by **both, jointly**, with ESMA cooperation. Budget executive time accordingly.

**Reference:** Regulation (EU) 2022/858 Article 2 (definitions), Articles 4–6 (type-specific requirements)

---

## SECTION 3 — ELIGIBLE DLT FINANCIAL INSTRUMENTS & SIZE LIMITS

*This is the section that has historically killed business cases. The €6bn aggregate cap was identified by ESMA in its June 2025 Article 14 review as the primary reason for low pilot uptake. The EC's April 2026 package proposes a €100bn cap, but that proposal has not been adopted — plan against the live limits, model against the proposed limits.*

---

### 3.1 — Eligible-Instrument Restrictions (Article 3(1))

A DLT financial instrument may only be admitted to trading on a DLT MTF / DLT TSS or recorded on a DLT SS / DLT TSS if it falls within one of the following classes **and** is within the per-instrument cap.

| Instrument class | Per-issuance / market-cap cap (at admission or recording) | Reference |
|---|---|---|
| Shares — issuer market capitalisation (or tentative market capitalisation) must be **less than** the cap | **EUR 500 million** | Article 3(1)(a) |
| Bonds, other forms of securitised debt (including depositary receipts in respect of such securities), money-market instruments — issuance size must be **less than** the cap; **excludes** instruments that embed a derivative or incorporate a structure making the risk hard to understand | **EUR 1 billion** | Article 3(1)(b) |
| Units in collective investment undertakings covered by MiFID II Article 25(4)(a)(iv) — AUM must be **less than** the cap | **EUR 500 million** | Article 3(1)(c) |

> **Bond-threshold carve-out (Article 3(1)(b), 2nd subparagraph):** Corporate bonds issued by an issuer whose market capitalisation did not exceed **EUR 200 million** at the time of issuance are **excluded from the calculation** of the €1 billion bond threshold. Use this to design issuer pipelines that maximise headroom under the cap.

> **Sovereign bonds — caveat:** The regulation does *not* expressly exclude sovereign bonds from eligibility. In practice, almost no sovereign bond issuance is below €1 billion, so the cap operates as a de facto exclusion. If a sub-€1bn sovereign bond is in scope, treat the eligibility analysis as a live question for counsel — the regulation does not provide a clean answer.

- [ ] **Instrument-class eligibility confirmed** — your planned instrument is one of the three eligible classes (shares, bonds / other securitised debt / money-market instruments, UCITS units)
- [ ] **Per-instrument cap modelling completed** — for each instrument you intend to admit, the relevant cap has been calculated and documented
- [ ] **Embedded-derivative / complex-structure exclusion checked** — for bonds, the instrument does not embed a derivative or incorporate a structure making the risk hard to understand *(Article 3(1)(b))*
- [ ] **€200m corporate-bond carve-out applied** where relevant to maximise capacity under the €1bn bond threshold *(Article 3(1)(b), 2nd subparagraph)*
- [ ] **Issuer due diligence process** — you have a written process to verify the market cap / issuance size / AUM of each issuer or instrument **before** admission, and to keep this verification current

> **Legal advisor note — the equity restriction is the most operationally constraining.** An issuer whose market cap is at the threshold today may exceed it tomorrow on a price movement. The pilot does not require expulsion of an instrument that crosses the threshold post-admission, but you should document the policy in the rulebook (Article 7) so the NCA sees you've thought about it. The EC April 2026 proposal removes the €500m equity cap entirely — if your business case depends on large-cap equities, plan for the post-amendment regime but do not assume it is in force.

> **NCA may set *lower* thresholds (Article 3(6)):** Your home NCA has discretion to set thresholds below the €500m / €1bn / €6bn / €9bn statutory caps for your specific infrastructure, taking into account market size, average capitalisation, and risk profile. The specific permission will state any lower thresholds set. If a lower threshold is applied to your €6bn cap, the €9bn trigger is reduced proportionately.

---

### 3.2 — Aggregate Threshold per DLT Market Infrastructure (Article 3(2)–(5))

The pilot imposes a hard cap on the total market value of DLT financial instruments admitted or recorded by a single DLT market infrastructure.

| Threshold | Value | Consequence | Reference |
|---|---|---|---|
| **Hard cap — admission ceiling** | **EUR 6 billion** (aggregate market value at the moment of admission/initial recording of a new DLT FI) | If the admission/initial recording of a new DLT FI would *reach* €6bn, the DLT MI **shall not admit / shall not record** that DLT FI | Article 3(2) |
| **Transition trigger** | **EUR 9 billion** | DLT MI operator **shall activate** its transition strategy under Article 7(7), notify the NCA of activation and timescale in the monthly report under Article 3(5) | Article 3(3) |

- [ ] **Aggregate-value monitoring system planned** — calculation of the **monthly average aggregate market value** required by Article 3(4): for each DLT FI with the same ISIN, average daily closing price × number of instruments traded or recorded
- [ ] **Monthly average used for**: (a) assessing whether next month's admission/recording would breach €6bn, and (b) deciding whether to activate the transition strategy *(Article 3(4))*
- [ ] **Monthly reporting workflow to NCA** *(Article 3(5))* — operator submits monthly reports demonstrating the thresholds in Article 3(2) and 3(3) are not exceeded
- [ ] **€6bn early-warning threshold set internally** (e.g. €5bn) — to give time to react before hitting the admission ceiling
- [ ] **€9bn transition trigger workflow documented** — who is notified, what stops, what migrates, on what timeline; trigger and timescale appear in the next monthly report
- [ ] **Business plan stress-tested at the caps** — your planned revenue at €6bn / €9bn must support the cost base; if it does not, the pilot is not viable for your business

> **Why this matters now:** ESMA's June 2025 Article 14 review explicitly stated that "market participants were unwilling to develop DLT platforms for a regime that capped the volume at €6bn." The EC's April 2026 Market Integration Package proposes raising the cap to **EUR 100 billion** (with a simplified €10bn tier for smaller operators) and removing the €9bn transition trigger — but that proposal requires European Parliament + Council adoption, expected late 2026. Until then, the €6bn / €9bn structure is binding.

**Reference:** Regulation (EU) 2022/858 Article 3 (restrictions on DLT financial instruments)

---

## SECTION 4 — ENTITY STRUCTURE, EU PRESENCE & UNDERLYING LICENCE

*The DLT Pilot Regime presupposes a substantively-licensed, EU-resident, fit-and-proper operator. There is no light-touch entry route.*

---

### 4.1 — Legal Entity Requirements

- [ ] **EU legal entity established** in an EU/EEA Member State — same requirement as for the underlying MiFID II / CSDR licence
- [ ] **Registered office and effective place of management** in the same EU Member State (your "home Member State")
- [ ] **Underlying authorisation held or applied for in parallel** — MiFID II investment firm, market operator, or CSDR-authorised CSD (per Section 1.3)
- [ ] **Home NCA identified** — the same NCA that authorises (or will authorise) your underlying licence will also grant the DLT-specific permission

> **Legal advisor note — jurisdiction choice matters more than for MiCA.** Because the DLT Pilot Regime layers on top of either MiFID II or CSDR, your jurisdiction choice locks in your regulator pair. BaFin + Bundesbank (Germany) has now processed three pilot permissions (Clearstream, 21X, 360X) and is the most experienced. AMF + ACPR (France) processed LISE. Bank of Lithuania is processing Axiology. Other NCAs have processed zero. Speed-of-review and process-maturity diverge meaningfully between these clusters.

---

### 4.2 — Governance & Fit-and-Proper

The fit-and-proper bar is set by the underlying MiFID II / CSDR regime — the pilot adds *DLT-specific competence* on top.

- [ ] **All management body fit-and-proper requirements** of the underlying regime satisfied (MiFID II Articles 9 / CSDR Article 27)
- [ ] **DLT-specific competence demonstrated** — at least one member of senior management or the board must have demonstrable knowledge of distributed-ledger technology, smart contracts, on-chain settlement, and the cyber-risk landscape associated with DLT
- [ ] **Dedicated DLT operations function** — identified responsible person for the DLT infrastructure, smart-contract change management, key-management procedures, and incident response
- [ ] **Conflict-of-interest policy** updated to address DLT-specific conflicts (e.g. dual-listing of native tokens vs. DLT securities; operator-as-counterparty risks; node-operator independence)

**Reference:** MiFID II Article 9 (management body); CSDR Article 27 (CSD board); Regulation (EU) 2022/858 Article 7 (additional requirements)

---

## SECTION 5 — COMMON OPERATIONAL & ORGANISATIONAL REQUIREMENTS (ARTICLE 7)

*Article 7 is the heart of the pilot's substantive requirements. It applies to **all** DLT market infrastructures regardless of type, and must be evidenced in the application dossier.*

---

### 5.1 — Business Plan + Public Written Documentation (Article 7(1))

Article 7(1) imposes **two** documentation duties: a business plan filed with the NCA, **and** publicly-available written rules with binding legal terms.

- [ ] **Written business plan** *(Article 7(1), 1st subparagraph)* covering:
  - [ ] Services and activities to be carried out (trading, settlement, or both) and their interaction
  - [ ] Description of **critical staff**
  - [ ] Technical aspects and use of the DLT
  - [ ] Information required under Article 7(3) (functions, services, activities, type of DLT used, and how performance deviates from a non-DLT MTF / SSS)
  - [ ] Three-year financial projections (or longer where the NCA requests)
  - [ ] How the DLT MI will operate within the €6bn / €9bn caps and what triggers transition
- [ ] **Publicly-available written documentation** *(Article 7(1), 2nd subparagraph)* defining the rules under which the DLT MI operates, including legal terms specifying:
  - [ ] Rights, obligations, responsibilities, and liabilities of the operator, members, participants, issuers, and clients
  - [ ] **Governing law**
  - [ ] Any **pre-litigation dispute settlement mechanisms**
  - [ ] Any **insolvency-protection measures under Directive 98/26/EC**
  - [ ] The **jurisdictions** in which legal action may be brought
  - [ ] (May be provided by electronic means)

---

### 5.2 — Rules on the Functioning of the DLT (Article 7(2)) + Public-Facing Information (Article 7(3))

- [ ] **Rules on functioning of the DLT** *(Article 7(2))* — rules on accessing the distributed ledger, on participation of validating nodes, on addressing potential conflicts of interest, and on risk management (including mitigation measures to ensure investor protection, market integrity and financial stability)
- [ ] **Public-facing website information** *(Article 7(3))* — clear and unambiguous information on how the operator carries out functions, services, and activities, **and how the performance deviates from a non-DLT MTF / SSS**, including the **type of DLT used**

---

### 5.3 — IT and Cyber Arrangements (Article 7(4))

- [ ] **IT and cyber arrangements proportionate** to the nature, scale, and complexity of the business
- [ ] Arrangements ensure continuity, transparency, availability, reliability, and security of services — **including reliability of smart contracts**
- [ ] Arrangements ensure integrity, security, confidentiality, availability, and accessibility of any data stored
- [ ] **Specific operational risk-management procedures** for the risks posed by DLT use and crypto-assets, including how to address them if they materialise
- [ ] **NCA-ordered audit capacity** — the NCA may require an audit and **shall appoint an independent auditor**; **operator bears the cost**. Budget for this and integrate audit-readiness into the architecture
- [ ] **Smart-contract independent audit** completed for each contract performing a regulatory function (issuance, transfer, settlement, custody, identity check) with material findings remediated before go-live
- [ ] **Operational-resilience plan** consistent with **Regulation (EU) 2022/2554 (DORA)** — DLT Pilot operators are in DORA scope (DORA Article 2(1)); see Section 8
- [ ] **Key-management procedures** — multi-signature / threshold-signature, HSM use, key-rotation policy, lost-key recovery, segregation of duties for key holders

---

### 5.4 — Safekeeping of Client Funds, Collateral, and DLT Financial Instruments (Article 7(5))

Article 7(5) applies where the operator holds members'/participants'/issuers'/clients' funds, collateral, or DLT financial instruments — including holding the means of access (i.e. cryptographic keys).

- [ ] **No use on own account without prior express written consent** *(Article 7(5), 1st subparagraph)* — operator must have adequate arrangements to prevent use of those assets on the operator's own account **without the prior express written consent of the member, participant, issuer, or client concerned** (which may be given electronically). **Note:** unlike MiCA Article 75 (which prohibits use of client crypto-assets for own account outright), the DLT Pilot expressly permits consent-based use — design your client agreements accordingly
- [ ] **Records of assets and means of access** *(Article 7(5), 2nd subparagraph)* — safe, accurate, reliable, and retrievable records of funds / collateral / DLT FIs and of the means of access to them
- [ ] **Segregation of client assets** *(Article 7(5), 3rd subparagraph)* — segregated from those of the operator AND from those of other members, participants, issuers, clients (including means of access)
- [ ] **Protection against operational risks** *(Article 7(5), 4th subparagraph)* — IT and cyber arrangements (per Article 7(4)) must protect against unauthorised access, hacking, degradation, loss, cyber-attack, theft, fraud, negligence, and other serious operational malfunctions
- [ ] **On-chain segregation evidence** — wallet structure, address derivation, on-chain proof-of-segregation accessible to NCAs
- [ ] **Insolvency-remoteness** of client assets — legal opinion that on insolvency of the operator, client DLT financial instruments are not part of the estate
- [ ] **Equivalent protection** to traditional book-entry custody must be demonstrable; if the NCA grants an exemption from the CSDR book-entry rule under Article 5, the **compensatory measure** must close this protection gap

---

### 5.5 — Liability for Loss + Compensation / Redress Arrangements (Article 7(6))

- [ ] **Operator strict liability for loss** *(Article 7(6), 1st subparagraph)* — liable for loss of funds, collateral, or DLT FIs **up to the market value of the asset lost**. Not liable **only** where it proves the loss arose from "an external event beyond its reasonable control, the consequences of which were unavoidable despite all reasonable efforts to the contrary" — a high evidentiary bar
- [ ] **Investor-protection arrangements** *(Article 7(6), 2nd subparagraph)* — transparent and adequate arrangements; mechanisms for handling client complaints; procedures for compensation/redress in case of investor loss (from the Article 7(6) liability events OR from cessation of business under Articles 8(13), 9(11) or 10(10))
- [ ] **Additional prudential safeguards on NCA decision** *(Article 7(6), 3rd subparagraph)* — NCA may require **own funds OR an insurance policy** above the baseline CSDR / IFR (Reg 2019/2033) / MiFID II / IFD (Dir 2019/2034) prudential rules, where it determines those baseline rules do not adequately cover potential client damages
- [ ] **Coverage of DLT-specific failure modes** addressed in the compensation policy: smart-contract bug, key compromise, validator failure, chain reorganisation, oracle failure, bridging failure
- [ ] **Liability allocation** — between operator, client, and (if any) third-party custodian — clearly drafted in the legal terms (per 5.1)

---

### 5.6 — Transition Strategy (Article 7(7))

The transition strategy is the pilot's defining feature. It is the credible plan for *unwinding* the DLT MI back into traditional infrastructure when triggered.

- [ ] **Transition strategy established AND made publicly available** *(Article 7(7), 1st subparagraph)* — clear, detailed strategy for reducing the activity of, or transitioning out of / ceasing to operate, the DLT MI, including transition or reversion of DLT operations to traditional market infrastructures, in each of these events:
  - [ ] **(a)** the **€9bn threshold under Article 3(3)** has been exceeded
  - [ ] **(b)** a specific permission or exemption is to be withdrawn or otherwise discontinued (including under Article 14(2) — pilot termination)
  - [ ] **(c)** any **voluntary or involuntary cessation** of the business of the DLT MI
- [ ] **Ready to deploy in a timely manner** *(Article 7(7), 2nd subparagraph)*
- [ ] **Treatment of members / participants / issuers / clients** specified *(Article 7(7), 3rd subparagraph)*, with **specific protection for retail investors** against any disproportionate impact
- [ ] **Updated on an ongoing basis** subject to **prior approval of the NCA** *(Article 7(7), 3rd subparagraph)*
- [ ] **What is to be done if the €9bn threshold is exceeded** specifically addressed *(Article 7(7), 4th subparagraph)*

#### Take-over arrangements (Article 7(8), 7(9), 7(10))

- [ ] **DLT MTF take-over arrangements** *(Article 7(8))* — investment firms / market operators only permitted to operate a DLT MTF under Article 8(2) (i.e. did not also obtain a standard MiFID MTF authorisation), AND CSDs operating a DLT TSS, **shall use best efforts to conclude arrangements with investment firms or market operators operating a standard MTF** to take over their operations, and shall specify those arrangements in the transition strategy
- [ ] **DLT SS take-over arrangements** *(Article 7(9))* — CSDs only permitted to operate a DLT SS under Article 9(2) (i.e. did not also obtain a standard CSDR authorisation), AND investment firms / market operators operating a DLT TSS, **shall use best efforts to conclude arrangements with a CSD operating a standard SSS** to take over their operations. The receiving CSD **must respond within 3 months**, on a non-discriminatory basis and at a reasonable cost-based commercial fee, and **may refuse only on smooth-and-orderly-functioning / systemic-risk grounds — never on loss-of-market-share grounds**
- [ ] **5-year deadline** *(Article 7(10))* — these arrangements must be in place **no later than 5 years from the date the specific permission was granted**, or earlier if the NCA requires it to address early-termination risk

> **Critical operational point:** NCAs treat the transition strategy as the single most important paragraph of the Article 7 file. A weak transition strategy will block authorisation regardless of how strong the rest of the dossier is, because the regulator must be able to wind the pilot down without harming investors. The 5-year deadline for take-over arrangements is a hard one — start identifying the receiving infrastructure during the application phase, not after.

**Reference:** Regulation (EU) 2022/858 Article 7 (additional requirements applicable to DLT market infrastructures)

---

## SECTION 6 — TYPE-SPECIFIC REQUIREMENTS & EXEMPTIONS

*Each infrastructure type has its own exemption catalogue. You request exemptions from your home NCA item-by-item; you do not get the whole list automatically. Each exemption granted carries a **compensatory measure** the operator must propose and the NCA must approve.*

---

### 6.1 — DLT MTF Exemptions (Article 4)

Article 4(1) anchors the DLT MTF to MiFIR + MiFID II in full, except for exemptions granted under paragraphs (2) and (3). Article 4 provides **only two** specific exemption pathways — there is no general exemption catalogue. Tick each you intend to seek.

#### ☐ Direct admission of natural and legal persons as members/participants — extension of MiFID II Article 53(3) *(Article 4(2))*

- [ ] You want **natural and legal persons** to be admitted directly as members or participants of the DLT MTF to deal on own account, *in addition to* the persons already specified in MiFID II Article 53(3)
- [ ] **All seven conditions** of Article 4(2) met by each admitted natural or legal person:
  - [ ] **(a)** of sufficient good repute
  - [ ] **(b)** sufficient level of trading ability, competence and experience, **including knowledge of the functioning of distributed ledger technology**
  - [ ] **(c)** **not** market makers on the DLT MTF
  - [ ] **(d)** **not** using a high-frequency algorithmic trading technique on the DLT MTF
  - [ ] **(e)** **not** providing other persons with direct electronic access to the DLT MTF
  - [ ] **(f)** **not** dealing on own account when executing client orders on the DLT MI
  - [ ] **(g)** **informed consent** given to trading as a member/participant **after being informed by the DLT MTF of the potential risks** of using its systems to trade DLT FIs
- [ ] **Additional protection measures** *(Article 4(2), 2nd subparagraph)* — the NCA may require additional measures proportionate to the risk profile of admitted natural persons; design member-onboarding flows so these can be layered in

#### ☐ Exemption from MiFIR Article 26 transaction-reporting *(Article 4(3))*

- [ ] You want the operator (or its members/participants) exempted from MiFIR Article 26 transaction reporting
- [ ] **Required compensatory arrangement:** the DLT MTF must keep records of all transactions through its systems, containing all the details of MiFIR Article 26(3) relevant to the DLT system and the executing member/participant
- [ ] **NCA admitted as "regulatory observer participant"** — the NCAs entitled to receive transaction-reporting data directly from the MTF under MiFIR Article 26 must have **direct and immediate access** to those records; they shall be admitted to the DLT MTF as a regulatory-observer participant
- [ ] **NCA shares the information with ESMA without undue delay**

#### Cross-cutting tests for both exemptions *(Article 4(4))*

- [ ] **Proportionality test** — the operator must demonstrate that the exemption requested is **proportionate to, and justified by, the use of DLT** *(Article 4(4)(a))*
- [ ] **Ring-fencing test** — the exemption is **limited to the DLT MTF and does not extend to any other MTF operated by the same operator** *(Article 4(4)(b))*. Important if you already run a traditional MTF — your DLT MTF can be exempted, your standard MTF cannot piggyback

> **CSD operating a DLT TSS:** Article 4(2), (3) and (4) apply *mutatis mutandis* to a CSD operating a DLT TSS *(Article 4(5))*.

> **ESMA compensatory-measures guidelines** *(Article 4(6))* — ESMA prepares (and updates) guidelines on the compensatory measures relevant to Article 4(1)(c). Check current ESMA guidelines before drafting your compensatory-measure proposal.

> **Compensatory-measures principle:** Article 4 does not prescribe alternatives. The operator proposes a compensatory measure; the NCA approves, modifies, or rejects. This is highly negotiated — engage counsel with prior pilot experience or expect a substantially longer review cycle.

**Reference:** Regulation (EU) 2022/858 Article 4 (requirements and exemptions for DLT MTFs)

---

### 6.2 — DLT SS Exemptions (Article 5)

Article 5(1) anchors the DLT SS (operated by a CSD) to CSDR in full, except for exemptions granted under paragraphs (2) to (9). Each exemption pathway has its own paragraph and its own conditions/compensatory measures. Tick each you intend to seek.

#### ☐ Book-entry form, securities-account and integrity-of-issue requirements — CSDR Articles 2(1)(4)/(9)/(28), 3, 37, 38 *(Article 5(2))*

- [ ] You want DLT FIs to exist natively on the DLT rather than as book entries in a CSD account / securities accounts
- [ ] **Demonstration requirement:** use of a "securities account" (CSDR Art 2(1)(28)) or book-entry form (CSDR Art 3) is **incompatible with the particular DLT** used
- [ ] **Compensatory measures must at minimum ensure:**
  - [ ] **(i)** DLT FIs are recorded on the distributed ledger
  - [ ] **(ii)** the number of DLT FIs recorded by the CSD on its DLT SS is equal to the total number of DLT FIs in the issue (or part of the issue) recorded on the distributed ledger **at any given time** (integrity of issue)
  - [ ] **(iii)** records enable the CSD to **segregate** DLT FIs of each member/participant/issuer/client from those of any other, **without delay**
  - [ ] **(iv)** **no securities overdrafts, debit balances, or improper creation/deletion** of securities

#### ☐ Settlement-discipline exemption — CSDR Articles 6 or 7 *(Article 5(3))*

- [ ] You want exemption from CSDR's settlement-discipline regime (measures to prevent settlement fails, cash penalties, mandatory buy-ins)
- [ ] **Required compensatory arrangements** — robust procedures and arrangements ensuring:
  - [ ] **(a)** clear, accurate and timely confirmation of transaction details (including payments and collateral)
  - [ ] **(b)** either **prevention of settlement fails OR addressing them if not preventable**

#### ☐ Outsourcing exemption — CSDR Article 19 *(Article 5(4))*

- [ ] You want exemption from CSDR Article 19 **in relation only to the outsourcing of a core service to a third party**
- [ ] **Demonstration requirement:** the application of CSDR Article 19 is **incompatible with the use of DLT** as envisaged by the DLT SS

#### ☐ Admit additional participants beyond the Directive 98/26/EC Art 2(f) list *(Article 5(5))*

- [ ] You want to admit **natural and legal persons** as participants of the DLT SS, beyond those listed in Article 2(f) of Directive 98/26/EC (the Settlement Finality Directive)
- [ ] **All three conditions** met by each such participant:
  - [ ] **(a)** of sufficient good repute
  - [ ] **(b)** sufficient level of ability, competence, experience, and knowledge in **settlement, DLT functioning, and risk assessment**
  - [ ] **(c)** informed consent to inclusion in the pilot regime, adequately informed of its experimental nature and potential risks

#### ☐ Participation, transparency and communication-procedure exemptions — CSDR Articles 33, 34, 35 *(Article 5(6))*

- [ ] You want exemption from CSDR Article 33 (participation criteria), 34 (transparency obligations), or 35 (communication procedures)
- [ ] **Compensatory measures must at minimum ensure:**
  - [ ] **(a)** publicly disclosed criteria for participation that allow **fair and open access** — transparent, objective, non-discriminatory
  - [ ] **(b)** publicly disclosed prices and fees for settlement services

#### ☐ Settlement-finality-protection / SFD exemption — CSDR Article 39 *(Article 5(7))*

- [ ] You want exemption from CSDR Article 39 (settlement finality of CSD-operated SSSs)
- [ ] **Required compensatory arrangements:**
  - [ ] **(a)** the DLT SS settles transactions in DLT FIs at close to real time or intraday, **and in any case no later than the second business day after the conclusion of the trade** — i.e. **T+2 maximum** ceiling on settlement
  - [ ] **(b)** rules governing the settlement system publicly disclosed
  - [ ] **(c)** risks from non-designation of the DLT SS under Directive 98/26/EC mitigated, in particular regarding insolvency proceedings
- [ ] **SFD designation is optional, not required** — Member States are not obliged to designate the DLT SS under Directive 98/26/EC; if not designated, the CSD **must propose compensatory measures for insolvency risk**

#### ☐ Cash-settlement exemption — CSDR Article 40 *(Article 5(8))*

- [ ] You want exemption from CSDR Article 40 (cash settlement)
- [ ] **Condition:** the CSD settles on the basis of **delivery versus payment** (DvP)
- [ ] **Permitted cash-settlement means** — payment settled through:
  - [ ] **Central-bank money, including in tokenised form**, where practical and available; OR
  - [ ] **Central-bank money via the CSD's account** under CSDR Title IV (where central-bank money in tokenised form not practical/available); OR
  - [ ] **Commercial bank money, including in tokenised form**, under CSDR Title IV; OR
  - [ ] **'E-money tokens'**
- [ ] **CSDR Title IV derogation** for credit institutions — Title IV does **not** apply to a credit institution providing commercial-bank-money settlement to a DLT MI whose aggregate market value at initial recording does not exceed **EUR 6 billion** (per Article 3(4))
- [ ] **Risk-management duty** — where settlement uses commercial bank money under the derogation above, or e-money tokens, the CSD must **identify, measure, monitor, manage, and minimise** the risks arising
- [ ] **E-money-token services equivalent to CSDR Section C(b)/(c)** must be provided by the CSD operating the DLT SS in accordance with CSDR Title IV **or by a credit institution** — practical effect: the e-money-token issuer is a credit institution, not a fintech EMI (ESMA flagged this as a barrier in June 2025; the EC April 2026 package proposes opening it to MiCA EMT issuers; not yet adopted)

#### ☐ Interoperability / CSD-link exemption — CSDR Articles 50, 51 or 53 *(Article 5(9))*

- [ ] You want exemption from CSDR Articles 50, 51 or 53 (standard CSD links / access between CSDs / access to other market infrastructures)
- [ ] **Demonstration requirement:** the use of DLT is **incompatible with legacy systems** of other CSDs / market infrastructures, OR granting access via legacy systems would trigger **disproportionate costs** given the scale of activities
- [ ] **Reciprocal access obligation:** an exempted CSD must give other DLT SS / DLT TSS operators access to its DLT SS; must inform the NCA of intention to grant access; NCA may prohibit access if detrimental to financial stability

#### Cross-cutting tests for all Article 5 exemptions *(Article 5(10))*

- [ ] **Proportionality test** — exemption proportionate to, and justified by, the use of DLT
- [ ] **Ring-fencing test** — exemption **limited to the DLT SS, does not extend to a securities settlement system operated by the same CSD** under standard CSDR. If you already run a standard CSD, your DLT SS exemptions do not flow to your standard SSS

> **Investment firm / market operator operating a DLT TSS** *(Article 5(11))* — Article 5(2)–(10) apply *mutatis mutandis*. Combined with Article 4 read across, this is what lets an investment firm / market operator (not normally a CSD) operate settlement under a TSS permission.

> **ESMA guidelines** *(Article 5(12))* — ESMA prepares guidelines on the compensatory measures referenced in Article 5(1)(c). Check current versions before drafting.

> **Settlement-currency reality (May 2026):** Only **credit institutions** can issue the e-money tokens used by a DLT SS / DLT TSS under Article 5(8). ESMA flagged this in June 2025 as a structural barrier excluding fintech EMIs. The EC April 2026 package proposes opening this to **MiCA-authorised EMT issuers** — not yet adopted.

**Reference:** Regulation (EU) 2022/858 Article 5 (requirements and exemptions for DLT SSs)

---

### 6.3 — DLT TSS Exemptions (Article 6)

Article 6 sets up two parallel tracks depending on whether the operator is an investment firm / market operator (Article 6(1)) or a CSD (Article 6(2)). Both can request the full Article 4 + Article 5 exemption set, plus *built-in* statutory carve-outs from the side of CSDR / MiFID II that the operator is not natively licensed under.

#### Track 1 — Investment firm or market operator operating a DLT TSS (Article 6(1))

The operator is subject to MiFIR + MiFID II in full, **plus** the CSDR requirements that apply to a CSD — but with a **statutory carve-out** from a defined list of CSDR articles, on top of any Article 4 / 5 exemptions requested.

- [ ] **Statutory CSDR exemptions** *(Article 6(1)(b))* — the following CSDR articles do **not** apply, by operation of law (no separate exemption request needed): **Articles 9, 16, 17, 18, 20, 26, 27, 28, 31, 42, 43, 44, 46 and 47** of Regulation (EU) 909/2014. This is the regime that lets an investment firm / market operator perform settlement without holding a full CSD licence
- [ ] **Article 4(2), (3) and (4) exemptions requested** as needed, per Section 6.1
- [ ] **Article 5(2) to (10) exemptions requested** as needed, per Section 6.2 (apply *mutatis mutandis* per Article 5(11))
- [ ] **Compensatory measures** for each exemption requested under Article 4 / 5 *(Article 6(1)(c))*

#### Track 2 — CSD operating a DLT TSS (Article 6(2))

The CSD is subject to CSDR in full, **plus** the MiFIR + MiFID II requirements that apply to an MTF — but with a **statutory carve-out** from MiFID II Articles 5 to 13, on top of any Article 4 / 5 exemptions requested.

- [ ] **Statutory MiFID II exemptions** *(Article 6(2)(b))* — **Articles 5 to 13** of Directive 2014/65/EU do **not** apply, by operation of law. This is the regime that lets a CSD perform trading without holding a full MiFID investment-firm / market-operator licence
- [ ] **Article 4(2), (3) and (4) exemptions requested** as needed (Article 4(5) applies *mutatis mutandis* to a CSD operating a DLT TSS)
- [ ] **Article 5(2) to (10) exemptions requested** as needed
- [ ] **Compensatory measures** for each exemption requested under Article 4 / 5 *(Article 6(2)(c))*

#### Common items

- [ ] **Atomic-settlement architecture documented** — matching engine and settlement engine operate on the same DLT, in the same transaction, with no T+ delay
- [ ] **Conflict-of-interest controls** strengthened to address the combined-function risk — e.g. separation of duties between trading and settlement operations within the firm, independent risk function, internal audit coverage
- [ ] **DLT-specific operational rules** demonstrating the trading and settlement functions are interoperable, deterministic, and resilient

> **Why DLT TSS is the preferred structure for new entrants:** A DLT TSS is a single legal entity, a single permission, and (in the 21X / LISE pattern) a single supervisory dialogue. A DLT MTF + DLT SS pair requires two entities, two licences, two permissions, two boards, two AMLA-readiness assessments, and two transition strategies. The Article 6(1)(b) / 6(2)(b) statutory carve-outs are the *legal mechanism* that makes this collapse possible — they exempt a firm from the parts of the *other* regime it would otherwise need to hold a second licence for.

**Reference:** Regulation (EU) 2022/858 Article 6 (requirements and exemptions for DLT TSSs)

---

## SECTION 7 — SETTLEMENT, CUSTODY & PAYMENT-LEG ARCHITECTURE

*Settlement architecture is where pilot applications most often stall. Get the payment-leg story right or the file does not move.*

---

### 7.1 — Payment-Leg Options

Identify your settlement currency and mechanism:

- [ ] **Central-bank money via TARGET / TARGET2** — traditional gold standard; requires a credit-institution intermediary to access ECB balance-sheet money
- [ ] **Central-bank money via Bundesbank Trigger Solution** — DLT bridge to TARGET2; operational; used by Clearstream D7
- [ ] **Central-bank money via ECB DL3S** (Distributed Ledger for Securities Settlement) — exploratory; ECB long-term integrated solution targeted post-2026
- [ ] **Central-bank money via TIPS Hash-Link** — exploratory
- [ ] **Commercial bank money** — settlement through a credit institution; counterparty risk to the bank
- [ ] **E-money tokens issued by a credit institution** — permitted under Article 5(5); 21X AG uses USDC, though USDC's issuer status under EU rules is a complex point — confirm with counsel
- [ ] **MiCA EMTs / stablecoins** — **only if** the EC April 2026 package is adopted (proposed, not yet in force)

> **Institutional client gating:** Pension funds, insurance undertakings, and many bank treasuries have mandates that require settlement in **central-bank money** — they cannot accept commercial-bank-money or e-money settlement for regulated securities. If your target user base includes these institutions, the central-bank-money route (Bundesbank Trigger or eventual DL3S) is not optional. Plan integration accordingly.

---

### 7.2 — Securities-Leg & On-Chain Custody

- [ ] **Wallet architecture documented** — issuer wallets, participant wallets, omnibus client wallets, individually-segregated client wallets (where required), operator hot/cold wallets
- [ ] **Permissioned-transfer enforcement** — smart-contract-level controls that block non-whitelisted addresses (e.g. ERC-3643 / ONCHAINID identity layer for tokenized securities)
- [ ] **Issuance-control smart contracts** — only authorised issuer can mint; supply cap enforced; freeze/unfreeze for compliance actions documented
- [ ] **Corporate-actions support** — dividend payments, interest coupons, capital changes, voting — handled via documented on-chain or off-chain mechanisms
- [ ] **Recovery procedures** — lost-key recovery, sanctions freeze, court-order forced-transfer pathways documented and consistent with national civil-procedure law
- [ ] **Cross-chain / bridge risk** — if your architecture spans multiple chains (e.g. 21X AG on Stellar + others), bridge-failure scenarios assessed and compensated for

---

### 7.3 — Settlement Finality

- [ ] **Settlement-finality moment defined** — exactly when does settlement become irrevocable on your DLT? (block confirmation depth, validator quorum, etc.)
- [ ] **Settlement Finality Directive (98/26/EC) recognition** — has your DLT SS / TSS been notified by your home Member State as a "designated system" under SFD? Required for legal protection of finality against insolvency law of participants
- [ ] **Cross-jurisdictional finality** — for cross-border participants, finality recognition under their home insolvency law assessed
- [ ] **No-revocation rule** — once on-chain settlement is final, no reversal is possible without breaking immutability; ensure operational procedures (e.g. error-trade handling) reflect this

**Reference:** Regulation (EU) 2022/858 Articles 4(3), 5(5), 6; Directive 98/26/EC (Settlement Finality Directive)

---

## SECTION 8 — ICT, CYBER & SMART-CONTRACT SECURITY (Article 7(2) + DORA)

*The pilot's IT/cyber obligations are operationalised through DORA (Regulation (EU) 2022/2554), which applies in full to trading venues and CSDs (DORA Article 2(1)). DLT MTFs, DLT SSs, and DLT TSSs are all therefore in DORA scope from authorisation day one.*

---

### 8.1 — DORA Five-Pillar Readiness

- [ ] **ICT risk management framework** documented (DORA Articles 5–16) — including identification, protection, detection, response, recovery
- [ ] **ICT-related incident reporting** workflow established (DORA Articles 17–23) — classification of significant incidents, notification timelines to NCA
- [ ] **Digital operational resilience testing** programme (DORA Articles 24–27) — including **TLPT (threat-led penetration testing)** if you cross DORA's significance thresholds
- [ ] **Third-party ICT risk** management (DORA Articles 28–44) — register of all ICT third-party providers, written contractual provisions, exit strategies; relevant for cloud, blockchain-node providers, oracles, wallet vendors, smart-contract audit firms
- [ ] **Information-sharing arrangements** with peer DLT MIs and the wider financial sector (DORA Articles 45–49)

> **See the standalone DORA Business Readiness Checklist for full coverage.** DORA compliance is a precondition for pilot authorisation — your NCA will assess DORA readiness as part of the Article 8/9/10 review.

---

### 8.2 — Smart-Contract & DLT-Specific Cyber Requirements

- [ ] **Independent smart-contract audit** for each regulatorily-relevant contract — issuance, transfer, settlement, identity gating, freeze/unfreeze — with material findings remediated before deployment
- [ ] **Upgrade governance** — if contracts are upgradeable (e.g. ERC-1967 proxy), the upgrade-authorisation key custody and approval workflow is documented; if non-upgradeable, the patching strategy (deploy-new-and-migrate) is documented
- [ ] **Formal verification or equivalent** for the highest-criticality components (e.g. issuance and supply control)
- [ ] **Oracle architecture** — for any contract dependent on external price feeds, the oracle redundancy, manipulation-resistance, and fallback behaviour documented
- [ ] **Validator / node-operator set** — for permissioned networks, the identity, jurisdiction, and operational independence of validators documented; collusion-risk assessment
- [ ] **Chain-reorganisation / fork policy** — for public-chain components, the operator's policy on which fork is authoritative, and the handling of pre-fork transactions

---

### 8.3 — Key Management

- [ ] **HSM-backed key custody** for all issuance, freeze, and settlement-authorisation keys
- [ ] **Multi-signature / threshold-signature** schemes for high-value operations; M-of-N policy documented
- [ ] **Key rotation policy** scheduled and tested
- [ ] **Key recovery / break-glass procedures** documented with separation of duties
- [ ] **Operator-key compromise scenario** — recovery procedure ends with a clean state and no client loss

**Reference:** Regulation (EU) 2022/858 Article 7(2); Regulation (EU) 2022/2554 (DORA), Articles 5–44

---

## SECTION 9 — MARKET INTEGRITY, INVESTOR PROTECTION & AML

*Pilot exemptions are from MiFID II / MiFIR / CSDR rules — **not** from market-abuse, investor-protection, AML, or sanctions rules. These apply in full.*

---

### 9.1 — Market Abuse Regulation (MAR — Regulation (EU) 596/2014)

- [ ] **MAR applies in full** to DLT financial instruments admitted to trading on a DLT MTF or DLT TSS — anchored directly in **Article 3(7) of the DLT Pilot Regulation**, which states: "Regulation (EU) No 596/2014 applies to DLT financial instruments admitted to trading on a DLT MTF or on a DLT TSS." Note: Article 3(7) does **not** extend MAR to DLT FIs that are only *recorded* on a DLT SS without being admitted to trading on a DLT MTF / TSS
- [ ] **Insider-dealing, unlawful disclosure, market-manipulation prohibitions** in operation
- [ ] **Insider lists** maintained
- [ ] **STOR (Suspicious Transaction and Order Reports)** workflow for MAR; on-chain surveillance tooling calibrated to feed STORs
- [ ] **Managers' transactions** (PDMR notifications) regime applied to issuers admitted on the DLT MTF / TSS

---

### 9.2 — Retail Investor Protection (where Article 4 retail-access exemption is used)

- [ ] **Suitability assessment** of retail participants — knowledge, experience, financial situation, risk tolerance — equivalent to MiFID II Article 25
- [ ] **Risk warnings** specific to DLT — smart-contract risk, key-loss risk, settlement-finality risk, regulatory-permanence risk
- [ ] **Pre-contractual disclosure** of fees, services, complaint-handling, settlement timing
- [ ] **Right of complaint** procedure free of charge, with reasonable response timelines
- [ ] **No leverage / no derivatives** in scope of pilot exemptions — pilot is for spot transactions in eligible MiFID II instruments only

---

### 9.3 — AML / CFT / Sanctions

- [ ] **AML programme** applicable to the operator under EU AML rules — currently AMLD4/5 + national transposition, replaced from **10 July 2027** by Regulation (EU) 2024/1624 (AMLR), Directive (EU) 2024/1640 (AMLD6), Regulation (EU) 2024/1620 (AMLA Regulation)
- [ ] **KYC / KYB on all members and participants** — even where Article 4(2) exemption admits retail directly, AML obligations are not waived
- [ ] **Transaction monitoring** including on-chain heuristics for sanctions/PEP/sources-of-funds risk
- [ ] **Travel Rule** — for any in-scope crypto-asset transfers; Regulation (EU) 2023/1113 applies where relevant
- [ ] **Sanctions screening** against EU, UN, OFAC lists, including on-chain address sanctions
- [ ] **MLRO appointed** — EU-resident, senior management

---

### 9.4 — Prospectus & Disclosure Obligations

- [ ] **Prospectus Regulation (EU) 2017/1129** applies to public offers of DLT financial instruments where the offer threshold is exceeded — issuers must publish an approved prospectus
- [ ] **No "white paper" route** — unlike MiCA, the pilot does not replace the prospectus regime. Tokenized shares / bonds / fund units remain subject to MiFID II + Prospectus Regulation + (where applicable) UCITS rules
- [ ] **Ongoing transparency obligations** under MiFIR / MAR — issuer disclosures, periodic reports — apply

**Reference:** MAR (Reg 596/2014); MiFID II Article 25 (suitability); Prospectus Reg (EU) 2017/1129; Regulation (EU) 2023/1113 (TFR); Regulation (EU) 2024/1624 (AMLR)

---

## SECTION 10 — APPLICATION PROCESS & SUPERVISORY DIALOGUE

*Articles 8, 9, and 10 govern the specific-permission process for DLT MTF, DLT SS, and DLT TSS respectively. ESMA published standardised templates in March 2023 — your application should follow them.*

---

### 10.1 — Application Dossier Contents

Your application to the home NCA must include (at minimum):

- [ ] **Application form** in the ESMA-standardised template format (separate templates for MTF / SS / TSS)
- [ ] **Underlying-authorisation evidence** (MiFID II / CSDR licence number) — or parallel application
- [ ] **Business plan** *(Article 7(1))*
- [ ] **Rules of the DLT MI** *(Article 7(3))*
- [ ] **Description of the DLT and IT/cyber arrangements** *(Article 7(2))*
- [ ] **Compensation arrangements** for loss of funds, collateral, or DLT financial instruments *(Article 7(6))*
- [ ] **Transition strategy** *(Article 7(7))*
- [ ] **Detailed itemisation of exemptions sought** with the **compensatory measure** proposed for each *(Articles 4, 5, 6)*
- [ ] **Safekeeping and segregation arrangements** *(Article 7(5))*
- [ ] **Conflicts-of-interest policy** updated for DLT context
- [ ] **Smart-contract audit reports** for each regulatorily-relevant contract
- [ ] **Key-management documentation**
- [ ] **DORA compliance evidence** (ICT risk management, BCP, DRP, third-party register)
- [ ] **AML / sanctions programme**
- [ ] **Three-year financial projections** including cap-stressed scenarios
- [ ] **Description of types of instruments to be admitted / recorded** and demonstration that each is within Article 3 limits

---

### 10.2 — NCA Review Process & Statutory Timelines

| Step | Action | Statutory / typical timeline |
|---|---|---|
| **1** | Engage specialist EU markets-infrastructure counsel and (for TSS) prepare for dual regulator track | Week 0 |
| **2** | Pre-application meeting with home NCA (most NCAs strongly recommend this; some require it) | Weeks 1–4 |
| **3** | Complete this readiness checklist and close all gaps | Weeks 2–12 |
| **4** | Prepare full dossier in ESMA-template format (templates were due to be developed by **23 March 2023** under Articles 8(5)/9(5)/10(6)) | Weeks 8–20 |
| **5** | Submit specific-permission application | Week 20+ |
| **6** | NCA completeness check **— statutory: 30 working days** *(Articles 8(6), 9(6), 10(7))* | 30 wd |
| **7** | NCA sends complete application to **ESMA** (DLT MTF) or to **ESMA + the CSDR Article 12 relevant authorities** (DLT SS / TSS) *(Articles 8(6), 9(6), 10(7))* | On completeness |
| **8** | **ESMA non-binding opinion** on exemptions and adequacy of DLT — within **30 calendar days** of receiving the application; ESMA first consults other Member States' NCAs *(Articles 8(7), 9(7), 10(8))*. The NCA must give the opinion due consideration and provide ESMA with a statement on any significant deviations | 30 cd |
| **8a** | For **DLT SS and DLT TSS**: **CSDR Article 12 relevant authorities' non-binding opinion** on features of the DLT SS / TSS — within **30 calendar days** *(Articles 9(7), 4th subparagraph; 10(8), 4th subparagraph)* | 30 cd |
| **9** | **NCA substantive review and decision** — statutory: **90 working days** from a complete application *(Articles 8(9), 9(9), 10(9))*. Extendable if applying simultaneously for MiFID II / CSDR authorisation (up to the additional period in MiFID II Art 7(3) / CSDR Art 17(8)). **Practical reality: DLT MTF 6–9 months; DLT SS 9–12 months; DLT TSS 12–18+ months** | 90 wd statutory |
| **10** | Permission granted (with itemised list of exemptions, compensatory measures, supervisory conditions, and any lower thresholds set under Article 3(6)) — **valid throughout the Union for up to 6 years from issuance** | — |
| **11** | ESMA publishes on its website: list of DLT MIs, start/end dates of permissions, exemptions granted, any lower thresholds; anonymised total of exemption requests granted/refused | On grant |
| **12** | Cross-border passporting (for DLT MTF / TSS) under MiFID II passporting rules | Post-permission |

> **Refusal grounds** *(Articles 8(10), 9(10), 10(10))* — NCA **shall refuse** if there are grounds to believe: (a) significant risks to investor protection / market integrity / financial stability not properly addressed; (b) permission sought to **circumvent** legal / regulatory requirements; or (c) operator (or its users) will not be able to comply with applicable Union / national law.

> **Withdrawal grounds** *(Articles 8(12), 9(12), 10(12))* — NCA **shall withdraw** the specific permission (or related exemptions) where: (a) a flaw in the DLT / services poses a risk that outweighs the benefits of experimentation; (b) operator breaches the conditions attached to exemptions; (c) FIs admitted/recorded that don't meet Article 3(1); (d) Article 3(2) threshold exceeded; (e) Article 3(3) threshold exceeded without activating transition strategy; (f) permission obtained on misleading information / material omission.

> **Legal advisor note — pre-application meetings are critical.** The DLT Pilot Regime is genuinely novel; NCAs are still learning. A pre-application meeting lets you discover early what compensatory measures the regulator will and will not accept, before you commit to a dossier structure. BaFin, AMF, and Bank of Lithuania have all run pre-application processes for pilot applicants.

---

### 10.3 — Material Changes Post-Authorisation (Articles 8(13), 9(13), 10(13))

- [ ] **Material-change application required** — any material change to the functioning of the DLT, or to the services / activities of the operator, that requires a new specific permission, a new exemption, or modification of an existing exemption / its conditions, requires a **new application** following the same procedure as the original
- [ ] **Internal change-control gate** — operational change-management process must include a pre-screening step that flags any change to compliance/legal for materiality assessment before deployment
- [ ] **Note:** distinct from the 4-month advance notification of material business-plan changes under Article 11(1) — see Section 11

---

### 10.4 — Permission Duration & Renewal

- [ ] **Permission validity:** up to **6 years** from the date of issuance *(Articles 8(11), 9(11), 10(11))*, **and** must end no later than the pilot regime sunset date (currently 23 March 2029 — extended from the original 2026 sunset)
- [ ] **Withdrawal grounds** — per Articles 8(12), 9(12), 10(12) above; plus standard authorisation-withdrawal grounds of the underlying MiFID II / CSDR regime
- [ ] **Renewal pathway** — the regime in its current form does not provide for renewal beyond the sunset; the EC April 2026 proposal would convert permissions to permanent authorisations, but is not yet adopted. Plan transition strategy as the *default* end-state under live law

**Reference:** Regulation (EU) 2022/858 Articles 8 (DLT MTF permission), 9 (DLT SS permission), 10 (DLT TSS permission)

---

## SECTION 11 — COOPERATION, REPORTING & ONGOING SUPERVISION

*Pilot operators carry enhanced supervisory cooperation duties on top of the standard reporting obligations of their underlying licence.*

---

### 11.1 — Without-Delay Notifications to the NCA (Article 11(1))

The operator must notify the NCA **upon becoming aware** of any of the following:

- [ ] **(a)** Any proposed **material change** to the business plan — including changes to critical staff, rules of the DLT MI, and legal terms — **at least 4 months before** the change is planned (whether or not a new specific permission is required) *(Article 11(1), 3rd subparagraph)*
- [ ] **(b)** Any evidence of **unauthorised access, material malfunctioning, loss, cyber-attacks or other cyber-threats, fraud, theft, or other serious malpractice** suffered by the operator
- [ ] **(c)** Any **material change to information** previously provided to the NCA
- [ ] **(d)** Any **technical or operational difficulties** in performing activities or providing services subject to the specific permission — including difficulties relating to the DLT or DLT FIs
- [ ] **(e)** Any **risks affecting investor protection, market integrity, or financial stability** that arose and were not anticipated at the time of the application or grant
- [ ] **Workflow defined** — designated officer, escalation thresholds, drafting templates, and 4-month change-planning lead time embedded in the change-management process

> **NCA's response options** *(Article 11(1), 4th subparagraph + 11(3))* — on notification of any of (a)–(e), the NCA may require either a new application under Articles 8(13)/9(13)/10(13), **or** corrective measures with respect to the business plan, rules, or legal terms.

---

### 11.2 — Periodic Reporting (Article 11(4))

- [ ] **Six-monthly report to NCA** *(Article 11(4))* — **every 6 months from the date of the specific permission**, the operator submits a report containing:
  - [ ] **(a)** Summary of the information listed in Article 11(1), 2nd subparagraph (i.e. notifications of items (a)–(e))
  - [ ] **(b)** Number and value of DLT FIs admitted to trading on the DLT MTF / TSS, and number and value of DLT FIs recorded on the DLT SS / TSS
  - [ ] **(c)** Number and value of transactions traded on the DLT MTF / TSS and settled on the DLT SS / TSS
  - [ ] **(d)** Reasoned assessment of any difficulties in applying Union or national financial-services law
  - [ ] **(e)** Actions taken to implement conditions attached to exemptions or any compensatory / corrective measures required by the NCA
- [ ] **Monthly threshold report (separate)** *(Article 3(5))* — see Section 3.2 — distinct from the 6-monthly Article 11(4) report; do not consolidate the two

---

### 11.3 — ESMA Coordination and Information Flows (Article 11(5)–(6))

- [ ] **NCA forwards reports and notifications to ESMA** in a timely manner *(Article 11(5))*
- [ ] **ESMA informs NCAs on a regular basis** of: 11(4) reports submitted; specific permissions and exemptions granted with conditions; any refusals, withdrawals, and cessations of business
- [ ] **ESMA submits an annual report to the Commission** on how specific permissions, exemptions, conditions and compensatory/corrective measures are applied in practice *(Article 11(6))*
- [ ] **Operator influence on regime evolution** — engagement during ESMA's coordination role and Article 14 reviews is one of the operator's best routes to shape the regime (e.g. ESMA's June 2025 Article 14 report became the basis of the EC April 2026 Market Integration Package)

---

### 11.4 — Cooperation with Other Authorities

- [ ] **ECB / Bundesbank cooperation** — if your settlement design uses central-bank money or the Trigger Solution, ongoing engagement with the relevant central bank is part of the supervisory relationship
- [ ] **CSDR Article 12 relevant authorities** — for DLT SS / TSS, these authorities are involved at the permission-application stage (Articles 9(6), 10(7)) and remain part of the supervisory perimeter
- [ ] **Host-Member-State cooperation** — for passported services, host-NCA cooperation duties apply under MiFID II

**Reference:** Regulation (EU) 2022/858 Articles 11 (cooperation), 12 (designation of competent authorities), 13 (notifications)

---

## SECTION 12 — TRANSITIONAL PROVISIONS, SUNSET & PROPOSED PERMANENCE

*Plan against the live regulation. Track the proposed amendments separately. Do not assume adoption.*

---

### 12.1 — Key Dates (Live Regulation)

| Date | Milestone | Source |
|---|---|---|
| **30 May 2022** | Regulation (EU) 2022/858 adopted; published 2 June 2022 (OJ L 151, p. 1) | — |
| **22 June 2022** | Entry into force (20 days after publication) | Article 19(1) |
| **22 June 2022** | Application date for Articles 8(5), 9(5), 10(6) (ESMA template-development mandates) and Article 17 (CSDR amendment) | Article 19(2)(a) |
| **4 July 2021** *(retroactive)* | Application date for Article 16 (MiFIR amendment — open-access regime postponement) | Article 19(2)(b) |
| **23 March 2023** | General date of application of the Regulation — DLT Pilot Regime operational; ESMA templates due (Articles 8(5)/9(5)/10(6)); MiFID II Article 4(1)(15) DLT FI definition applies via Article 18 | Article 19(2) |
| **24 March 2024** | First ESMA interim report due (Article 15) | Article 15 |
| **24 March 2025** | ESMA develops guidelines on exemption consistency / proportionality (Articles 8(8)/9(8)/10(8)) | Article 8(8) |
| **24 March 2026** | ESMA Article 14 review report due to Commission; Commission Article 14(2) report to EP/Council due **within 3 months** thereafter | Article 14 |
| **23 March 2026** *(originally)* | Original sunset of the pilot regime — note: in practice, ESMA's Article 14 report was published 25 June 2025; Commission has authority to extend by up to 3 years under Article 14(2)(a) | Article 14(2)(a) |
| **23 March 2029** *(if extension exercised)* | Extended sunset after 3-year extension | Article 14(2)(a) |

- [ ] **Permission validity does not exceed the sunset** — you cannot hold a pilot permission beyond the operative sunset date under the current regulation; permissions are capped at 6 years from issuance AND at the regime sunset
- [ ] **Transition strategy must execute before sunset** — your migration plan must complete *before* the operative sunset, not at it
- [ ] **EC April 2026 Market Integration Package monitored** — proposed conversion to permanent regime + €100bn cap + extended scope; **adoption expected late 2026**; legislative path: European Parliament + Council co-decision

---

### 12.2 — Proposed Amendments (Track but Do Not Rely On)

| Parameter | Live regulation | EC April 2026 proposal |
|---|---|---|
| Aggregate cap per DLT MI | €6bn / €9bn transition trigger | **€100bn** (simplified €10bn tier) — €9bn trigger removed |
| Equity instruments cap | Issuers with market cap < €500m | **Removed** — all-cap eligibility |
| Eligible instruments | Shares, bonds (incl. MMIs), UCITS units | **All MiFID II financial instruments** |
| Sunset | 23 March 2029 | **Permanent regime** |
| Settlement currency | Credit-institution e-money tokens | **MiCA-authorised EMTs eligible** |
| Operator eligibility | MiFID II investment firm / market operator / CSD | **MiCA-authorised CASPs eligible** to operate DLT MIs |
| ESMA role | Coordination + Article 14 reports | **Direct supervision of CASPs operating DLT MIs** |

- [ ] Adoption tracked through European Parliament and Council legislative pipeline
- [ ] Business case modelled at both live thresholds and proposed thresholds — *go-live decision should be viable at live thresholds, not contingent on adoption*

**Reference:** Regulation (EU) 2022/858 Articles 14, 15, 19; ESMA Article 14 Report on the DLT Pilot Regime (25 June 2025); EU Commission Market Integration Package (21 April 2026)

---

### 12.3 — Amendments to Other EU Legislation (Articles 16, 17, 18)

The DLT Pilot Regime made three permanent amendments to existing EU law that remain in force regardless of the pilot's sunset.

- [ ] **Article 16 — Amendment to MiFIR (Reg 600/2014):** modified MiFIR Article 54(2) — postponed the open-access regime for CCPs and trading venues in exchange-traded derivatives until **3 July 2023**. Largely time-expired, but is the historical context for current open-access rules
- [ ] **Article 17 — Amendment to CSDR (Reg 909/2014):** modified CSDR Article 76(5) on the application dates of settlement-discipline measures — making each settlement-discipline measure under CSDR Article 7(1) to (13) apply from the date specified in the delegated act adopted under CSDR Article 7(15)
- [ ] **Article 18 — Amendment to MiFID II (Dir 2014/65/EU):** **expressly added DLT-issued instruments to the financial-instrument definition** in MiFID II Article 4(1)(15). The amended definition: *"financial instrument means those instruments specified in Section C of Annex I, including such instruments issued by means of distributed ledger technology"*. **This is the legal anchor for the entire tokenized-securities regime** — it confirms that a tokenized share, bond, or fund unit is a MiFID II financial instrument regardless of its DLT issuance, and therefore not a MiCA crypto-asset. Member States had to transpose by 23 March 2023 (with a 6-month extension available on notification)

> **Why this matters even if the pilot sunsets:** the MiFID II Article 4(1)(15) amendment is permanent and structurally separate from the pilot. Even if the pilot regime terminated tomorrow, DLT-issued instruments would still be financial instruments under MiFID II — the regulatory boundary with MiCA does not depend on the pilot's continuation.

**Reference:** Regulation (EU) 2022/858 Articles 16, 17, 18, 19; MiFID II Article 4(1)(15) as amended

---

## SECTION 13 — ENFORCEMENT & PENALTY EXPOSURE

*The pilot does not create new sanctions. It exposes operators to the underlying MiFID II / CSDR / MAR / DORA / AML penalty regimes, plus the specific possibility of NCA withdrawal of the pilot permission.*

---

### 13.1 — Sources of Penalty Exposure

- [ ] **MiFID II / MiFIR penalties** — administrative fines up to **at least €5m** for legal persons, plus turnover-based caps (national law may go higher), withdrawal of authorisation, public statement, ban from management functions
- [ ] **CSDR penalties** — comparable scale for CSD-licensed DLT SS operators
- [ ] **MAR penalties** — up to **at least €15m** or 15% of turnover for legal persons for market abuse infringements
- [ ] **DORA penalties** — Member State-set, applicable to ICT risk management and incident reporting failures
- [ ] **AML penalties** — under national AML transpositions, transitioning to AMLR/AMLD6 from July 2027
- [ ] **Pilot-specific consequence — withdrawal of the specific permission** — the DLT-specific permission can be withdrawn for breach of Article 7 requirements or the conditions of the permission, separately from the underlying authorisation

### 13.2 — Operational Risk Implications

- [ ] **D&O insurance scope** includes pilot-specific liability (smart-contract failure, on-chain settlement failure)
- [ ] **Whistleblowing channels** in place — required under DORA, MAR, MiFID II
- [ ] **Penalty-decision publication awareness** — NCAs publish enforcement decisions; reputational impact may exceed financial impact for a novel-infrastructure operator

**Reference:** MiFID II Article 70; CSDR Article 63; MAR Article 30; DORA Article 50; pilot Article 7 (basis for withdrawal of specific permission)

---

## READINESS SCORECARD — SUMMARY

*Use this scorecard to assess your overall readiness. Count completed checkboxes per section.*

| Section | Topic | Items (approx) | Ready? |
|---|---|---|---|
| 1 | Applicability, exclusions, underlying licence pathway | 16 | ☐ |
| 2 | Infrastructure-type classification (MTF / SS / TSS) | 3 | ☐ |
| 3 | Eligible instruments & size limits (Article 3) | 11 | ☐ |
| 4 | Entity structure, EU presence & governance | 8 | ☐ |
| 5 | Common requirements (Article 7(1)–(10)) — business plan, DLT rules, IT/cyber, safekeeping, liability, transition, take-over arrangements | 35 | ☐ |
| 6 | Type-specific requirements & exemptions (Articles 4, 5, 6) | 50 | ☐ |
| 7 | Settlement, custody & payment-leg architecture | 16 | ☐ |
| 8 | ICT, cyber, smart-contract security & DORA | 15 | ☐ |
| 9 | Market integrity, investor protection & AML | 18 | ☐ |
| 10 | Application process, statutory timelines, material change, permission duration (Articles 8/9/10) | 25 | ☐ |
| 11 | Cooperation, 4-month notifications, 6-monthly reporting, ESMA coordination (Article 11) | 20 | ☐ |
| 12 | Transitional provisions, sunset, permanence proposal, amendments to other legislation | 8 | ☐ |
| 13 | Enforcement & penalty exposure | 8 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** Ready to engage NCA pre-application meeting
- **Amber (50–80% complete):** Material gaps exist — close these before requesting pre-application meeting
- **Red (<50% complete):** Significant preparation required — engage specialist counsel and budget 6–18 months of pre-application work (6 for MTF, 9–12 for SS, 12–18 for TSS)

---

## REFERENCE OPERATORS (as of May 2026)

| Operator | Type | NCA | Permission date | Notable |
|---|---|---|---|---|
| **Clearstream D7 DLT** | DLT SS | BaFin / CSSF | Oct 2024 | Bundesbank Trigger settlement; Ondo/360X alliance Apr 2026 |
| **21X AG** | DLT TSS | BaFin | Dec 2024 | First DLT TSS in EU; €500m debt issue; Stellar + USDC; live Sept 2025 |
| **360X AG** | DLT MTF | BaFin | Apr 2025 | xStocks (Ondo-tokenized US equities) Feb 2026 |
| **LISE (Lightning Stock Exchange)** | DLT TSS | AMF / ACPR | Oct 2025 | First tokenized IPO in EU (ST GROUP, Apr 2026); SME-focused |

**Pipeline (per ESMA / market intelligence):** ~10 applications pending, including Axiology (Lithuania, DLT TSS), Securitize (Spain, DLT TSS).

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for DLT Pilot Regime applicants:**

**Pre-Build:** Pilot-vs-MiCA classification brief → instrument-eligibility analysis (Article 3) → exemption strategy and compensatory-measure architecture → transition-strategy design (the Article 7(7) document NCAs grade hardest)

**Build:** ERC-3643 / ERC-1400 token contracts → ONCHAINID identity layer → settlement engine (atomic on-chain or bridged to Bundesbank Trigger) → multi-sig key custody → on-chain segregation and proof-of-reserve → structured DORA-aligned event schema → smart-contract upgrade governance

**Audit:** Independent smart-contract security audit → NCA-ready audit report → compensatory-measures-to-code mapping → recurring delta audits for upgrade releases

**Why pilot applicants choose us:** We have built against the operational reality of the 21X, LISE, Clearstream, and 360X architectures. Every contract function in our delivery is labelled against the Article 4 / 5 / 6 / 7 obligation it discharges. Your legal counsel reads the architecture document alongside the regulation, not instead of it.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. The DLT Pilot Regime is a novel, evolving framework subject to ESMA / Commission review, NCA discretion in exemption-grant decisions, and proposed amendments under the EU Commission's April 2026 Market Integration Package. Always engage qualified EU markets-infrastructure legal counsel for your specific business, jurisdiction, and instrument set.*

*Document version: 1.2 | Last updated: May 2026*
*Changes in v1.2 (second-pass reconciliation against OJ L 151, 2.6.2022 text):*
*— Section 2.1 Type B (DLT SS): added the Article 2(7) initial-recording and safekeeping arms of the definition that v1.1 omitted.*
*— Section 2.1 "single-permission rule" softened: regulation does not expressly prohibit holding both DLT MTF and DLT SS permissions in the same entity; it gates them on different underlying licences.*
*— Section 10.2 step 8a corrected: CSDR Article 12 relevant authorities provide a non-binding opinion for **both** DLT SS (Article 9(7), 4th subparagraph) and DLT TSS (Article 10(8)) — v1.1 incorrectly limited this to TSS.*
*— Section 9.1: MAR application now anchored directly in **Article 3(7)** of the DLT Pilot (rather than derived from MiFID II financial-instrument status); also clarified that Article 3(7) covers admission to trading on DLT MTF/TSS but does not extend MAR to DLT FIs only recorded on a DLT SS.*
*Changes in v1.1 (full reconciliation against OJ L 151, 2.6.2022 text):*
*— Article 4(2) corrected: exemption is from MiFID II Article 53(3) (MTF membership), not Article 19(1); added the 7 statutory conditions on each admitted natural/legal person.*
*— Article 4(3): added "regulatory observer participant" requirement when MiFIR Art 26 transaction-reporting exempted.*
*— Article 4(4) / 5(10): added the proportionality + ring-fencing tests (exemption limited to the DLT MI, not extending to other MTFs/SSSs operated by the same entity).*
*— Article 5 paragraph numbering corrected throughout: 5(2)=book-entry/securities-account (CSDR 2(1)(4)/(9)/(28), 3, 37, 38) with 4 mandatory compensatory ensure-conditions; 5(3)=settlement discipline (CSDR 6, 7); 5(4)=outsourcing (CSDR 19); 5(5)=admit participants beyond Directive 98/26/EC Art 2(f); 5(6)=CSDR 33/34/35; 5(7)=CSDR 39 with T+2 ceiling; 5(8)=CSDR 40 cash-settlement (central-bank money / commercial bank money / e-money tokens, with credit-institution carve-out under €6bn); 5(9)=CSDR 50/51/53 interoperability.*
*— Article 6: added statutory carve-outs from CSDR Articles 9, 16, 17, 18, 20, 26, 27, 28, 31, 42, 43, 44, 46, 47 (Art 6(1)(b)) for investment-firm-operated TSS, and from MiFID II Articles 5–13 (Art 6(2)(b)) for CSD-operated TSS — these are the structural carve-outs that make a single-entity DLT TSS legally possible.*
*— Article 3: removed unsupported "sovereign-bond exclusion" claim; added Article 3(1)(b) €200m corporate-bond carve-out; added Article 3(6) NCA-may-set-lower-thresholds power; corrected Article 3(2) to "shall not exceed €6bn at the moment of admission"; added Article 3(4) monthly-average calculation method and Article 3(5) monthly threshold reporting.*
*— Article 7(5): added "without prior express written consent" of the client — DLT Pilot permits consent-based reuse of client assets (unlike MiCA Article 75 which prohibits it absolutely).*
*— Article 7(6): corrected operator-liability wording — capped at market value of asset lost, sole defence is "external event beyond reasonable control, consequences unavoidable despite all reasonable efforts"; NCA may require additional own funds OR insurance under Art 7(6) 3rd subparagraph.*
*— Article 7(7): added retail-investor protection requirement and "updated on ongoing basis with prior NCA approval"; added Article 7(8)/(9)/(10) take-over-arrangement obligations with 3-month receiving-CSD response deadline and 5-year deadline for arrangements to be in place.*
*— Articles 8/9/10: corrected NCA completeness check to 30 working days (not 25); added ESMA non-binding-opinion 30-calendar-day step; added 90-working-day statutory decision deadline; added refusal grounds (8(10)/9(10)/10(10)) and withdrawal grounds (8(12)/9(12)/10(12)).*
*— Article 11: corrected periodic reporting frequency to 6 months (not quarterly); added 4-month advance notification for material business-plan changes; enumerated the 5 categories of without-delay notifications.*
*— Article 19: corrected entry-into-force / application dates (general application 23 March 2023; Articles 8(5)/9(5)/10(6) and 17 from 22 June 2022; Article 16 from 4 July 2021).*
*— New Section 12.3 added: Articles 16/17/18 amendments to MiFIR / CSDR / MiFID II, including the structurally important MiFID II Art 4(1)(15) amendment that confirms DLT-issued instruments are MiFID financial instruments.*

*Regulation reference: Regulation (EU) 2022/858 of the European Parliament and of the Council of 30 May 2022 on a pilot regime for market infrastructures based on distributed ledger technology, and amending Regulations (EU) No 600/2014 and (EU) No 909/2014 and Directive 2014/65/EU, OJ L 151, 2 June 2022, p. 1–33.*
*Source: https://eur-lex.europa.eu/eli/reg/2022/858/oj*
