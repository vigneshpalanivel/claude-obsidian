# Instant Payments Regulation (IPR) Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for PSPs Building Euro Instant Credit Transfer Services

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU Instant Payments Regulation — Regulation (EU) 2024/886
**Source:** https://eur-lex.europa.eu/eli/reg/2024/886/oj
**Status:** In force since 8 April 2024 — phased application; first hard deadline 9 January 2025 (euro-area receive + charges + sanctions screening); final deadline 9 June 2028 (non-euro-area carve-out sunset)
**Document type:** Pre-engagement readiness assessment — to be completed before scoping the SEPA Instant build-out or filing for participation in a designated payment system
**Version:** v1.1 (2026-05-25) — verbatim cross-check against locally-saved `IPR.html` (Regulation (EU) 2024/886). v1.0 → v1.1 surfaced 4 material corrections: (1) Art 11(1c) planned-maintenance carve-out conditions are OR-linked alternatives, not AND-cumulative; (2) Art 3(1) IPR amendment to PSD2 Art 10(1) reframed from "tightened wording" to scope extension (now applies directly to EMIs, with obligation-imposer expanded to "Member States or competent authorities"); (3) Art 5d obligation crystallises when SCT Inst offering begins — bound only "PSPs offering instant credit transfers", not every PSP from 9 Jan 2025 unconditionally; (4) Art 5a(7) packaged-orders rule covers "number of payment orders" per package (count), not "volume" (value).

---

> **What this Regulation does in one sentence.** Regulation (EU) 2024/886 amends four existing acts — SEPA Regulation (EU) 260/2012, Cross-Border Payments Regulation (EU) 2021/1230, Settlement Finality Directive 98/26/EC, and PSD2 (Directive (EU) 2015/2366) — to make euro instant credit transfers a mandatory product for every PSP that already offers euro credit transfers, at no extra cost to the user, with mandatory pre-authorisation payee-name verification (VoP), daily sanctions-list screening of customers, and direct access for payment institutions and EMIs to designated payment systems.

> **Who this document is for:** Founders, payments-team leads, and executive teams at credit institutions, payment institutions, electronic money institutions, and adjacent FinTechs (including crypto-asset service providers considering an EMI/PI license) approaching legal counsel for the first time to scope what the IPR requires of their euro credit-transfer offering. This checklist mirrors the intake a specialist EU payments lawyer would walk you through in a first session.

> **How to use this checklist:** Work through each section in order. Items marked ☐ are concrete requirements or decisions. Items marked ⚠️ are deal-breakers — if you cannot resolve them, your launch plan is incompatible with the IPR and you should stop and rebuild before going live or before applying for participation in a payment system.

> **IPR vs. MiCA — the boundary question:** The IPR amends PSD2 and SEPA. It applies to *payment service providers* offering *credit transfers in euro* — i.e., credit institutions, payment institutions, and electronic money institutions. A pure crypto-asset service provider (CASP) authorised under MiCA is **not** in scope of the IPR unless it also holds a PSD2 authorisation (PI or EMI) for fiat credit-transfer rails. Most CASP business models that include a fiat on/off-ramp do hold or rely on a PSD2-licensed partner — in which case the IPR follows the fiat leg, not the token leg. Get this classification right before scoping any work.

---

## SECTION 0 — DOES THE IPR APPLY TO YOU?

*This is the first question any legal advisor will ask. The IPR is narrow on entities but mandatory once it bites: if you are a PSP offering euro credit transfers, you cannot opt out of offering the instant variant.*

---

### 0.1 — Entity-level scope: Are you a Payment Service Provider?

Tick every statement that is true. If any is ticked, the IPR likely applies to you.

- [ ] We are a **credit institution** as defined in Article 4(1)(1) of Regulation (EU) 575/2013 (CRR) authorised in an EU/EEA Member State
- [ ] We are a **payment institution** as defined in Article 4(4) of PSD2 (Directive (EU) 2015/2366)
- [ ] We are an **electronic money institution** as defined in Article 2(1) of Directive 2009/110/EC (EMD2)
- [ ] We are an EU/EEA branch of a third-country credit institution providing payment services to EU customers
- [ ] We are applying for authorisation as any of the above and our business plan includes euro credit transfers
- [ ] We are a payment initiation service provider (PISP) under Article 4(18) of PSD2 — narrow scope for Article 5c(2) (VoP information accuracy) and the related liability rule

> **Legal advisor note:** The IPR is not status-creating. It does not invent a new licence and it does not extend PSP obligations to non-PSPs. If you are a software vendor, a payments-orchestration layer, a banking-as-a-service technology provider, or a CASP without PI/EMI status, the IPR does not directly bind you — but the PSP you partner with will push the obligations down the contractual chain. Read your MSA before you scope the work.

**Reference:** Regulation (EU) 260/2012, Article 1 (Subject matter and scope), as amended; PSD2 Article 1 (entity definitions)

---

### 0.2 — Service-level scope: Do you offer credit transfers in euro?

Tick every statement that is true.

- [ ] We currently offer to our PSUs a payment service of **sending** credit transfers in euro (PSD2 Annex I, point (3))
- [ ] We currently offer to our PSUs a payment service of **receiving** credit transfers in euro
- [ ] We maintain at least one payment account that is reachable for SEPA credit transfers
- [ ] We are planning to launch a euro credit-transfer service within the next 24 months

> **⚠️ Deal-breaker check:** Article 5a(1) attaches the instant-credit-transfer obligation to the offering of any euro credit-transfer service. **You cannot offer non-instant SEPA without offering SEPA Instant** — the regulation does not permit a "non-instant-only" euro credit-transfer product after the applicable deadline (Section 10). If your business plan assumes batch/end-of-day SEPA only, it is not viable post-deadline.

> **Reachability is symmetrical.** Every payment account that is reachable for credit transfers must also be reachable for instant credit transfers, 24 hours a day, every calendar day. There is no carve-out for "low-priority" accounts, dormant accounts, or savings accounts that today accept standard SEPA but not SCT Inst.

**Reference:** Regulation (EU) 260/2012 Article 5a(1), as inserted by Article 1(2) IPR

---

### 0.3 — Geographic scope: Euro-area or non-euro-area Member State?

The IPR applies different deadlines depending on where the PSP is located. Tick the one that applies.

- [ ] We are located in a Member State whose currency is the **euro** (euro area) → Section 10 column A applies
- [ ] We are located in a Member State whose currency is **not the euro** (e.g., Sweden, Poland, Bulgaria, Romania, Czechia, Hungary, Denmark) → Section 10 column B applies, plus the limited carve-out in Article 5a(2) and Article 5a(8) third subparagraph
- [ ] We are an EMI/PI located in a euro-area Member State → Section 10 column C applies (longer runway)
- [ ] We are an EMI/PI located in a non-euro-area Member State → Section 10 column D applies

> **Legal advisor note:** "Located in" is the home Member State of authorisation. Passporting branches are deemed to follow the host-Member-State currency rule for the activity conducted via the branch — confirm with your home and host NCAs before relying on either column.

**Reference:** Regulation (EU) 260/2012 Article 5a(8), as inserted by Article 1(2) IPR; Article 16(9) (newly euro-adopting Member States), as inserted by Article 1(5) IPR

---

### 0.4 — Out of scope: Confirm you are NOT one of these

- [ ] We are the **ECB or a national central bank** acting in our capacity as monetary authority or other public authority → fully out of scope
- [ ] We are an ECB or NCB **not** acting as monetary authority — partial carve-out: may limit instant-CT sending to the hours during which non-instant CTs are offered (Article 5a(2) second subparagraph)
- [ ] We provide payment services that **do not include credit transfers in euro** (e.g., card acquiring only, e-money issuance without CT rails, currency exchange only) → out of scope of Article 5a
- [ ] We are a PI/EMI benefitting from an Article 32 or 33 PSD2 exemption — out of scope of the SFD "institution" definition extension (Article 4 IPR)

---

## SECTION 1 — THE IPR ARCHITECTURE: WHAT EACH AMENDMENT DOES

*This section orients you to the structure of the IPR so the rest of the checklist makes sense. The Regulation is short (six articles) but it surgically modifies four other acts. Skip this section if you already know the structure.*

---

### 1.1 — The Four Acts the IPR Amends

| IPR Article | Amends | What it does in one sentence |
|---|---|---|
| **Article 1** | Regulation (EU) 260/2012 (SEPA Regulation) | Inserts new Articles 5a–5d: mandatory instant credit transfers, charge parity, Verification of Payee (VoP), daily sanctions screening; tightens penalty regime; extends review obligations |
| **Article 2** | Regulation (EU) 2021/1230 (Cross-Border Payments) | Aligns cross-border instant-CT charges to the SEPA charge-parity rule; resolves the conflict where the older "charges-equal-to-national" rule would otherwise produce a higher fee |
| **Article 3** | Directive (EU) 2015/2366 (PSD2) | Tightens PI/EMI funds-safeguarding wording (Article 10); creates Article 35a setting conditions for PI/EMI participation in designated payment systems; opens indirect access via Article 35(3) |
| **Article 4** | Directive 98/26/EC (Settlement Finality Directive) | Adds PIs and EMIs to the definition of "institution" — making them eligible to participate directly in SFD-designated payment systems alongside banks |

> **Why it matters that the IPR amends the SFD.** Pre-IPR, payment institutions and EMIs could not be direct participants in SFD-designated payment systems (TARGET, EURO1, STEP2, national RTGS instant rails). They had to ride on a sponsoring bank — which is precisely the bottleneck that has kept SCT Inst uptake low. The Article 4 amendment is therefore the structural enabler of the entire Regulation. The Article 3 amendment is the supervisory price you pay to access that gate.

**Reference:** IPR Articles 1–4

---

### 1.2 — Where to find the consolidated text

- [ ] Read the *amended* SEPA Regulation (EU) 260/2012 — not the 2012 version — when building product and policy
- [ ] Read the *amended* PSD2 when scoping safeguarding, governance, and DORA-linked ICT arrangements (Articles 6 and 7 of Regulation (EU) 2022/2554 are cross-referenced in new Article 35a)
- [ ] Track EBA Level 2 (ITS for the Article 15 reporting templates — draft due 9 June 2024) and EPC scheme rulebook updates continuously

**Reference:** IPR Article 6 (Entry into force — 8 April 2024); ELI: http://data.europa.eu/eli/reg/2024/886/oj

---

## SECTION 2 — ARTICLE 5a — MANDATORY INSTANT CREDIT TRANSFER SERVICE

*This is the structural core of the IPR. If you offer euro credit transfers, you must offer the instant variant on the same accounts, on the same channels, 24/7/365, executed within 10 seconds. Everything else in the Regulation is in service of this obligation.*

---

### 2.1 — Reachability obligation (Article 5a(1))

- [ ] We have inventoried every payment account on our books that is currently reachable for SEPA credit transfers
- [ ] We have confirmed that **every** one of those accounts will be reachable for SEPA Instant credit transfers by the applicable Section 10 deadline — including:
  - [ ] Personal current accounts
  - [ ] Payment accounts with basic features (Directive 2014/92/EU)
  - [ ] Business / corporate accounts
  - [ ] Savings accounts that today accept incoming SEPA
  - [ ] Wallet accounts / e-money accounts that today accept incoming SEPA
  - [ ] Dormant accounts that are still open
- [ ] We have identified any account category we currently exclude from SCT Inst and have a plan to bring it into reachability before the deadline

> **⚠️ Deal-breaker check:** "Reachable for credit transfers but not for instant credit transfers" is not a permitted product configuration after the applicable deadline. If your core banking system has a per-account-type SCT Inst flag, every "off" flag for an SCT-reachable account is a compliance gap.

**Reference:** Article 5a(1), second subparagraph

---

### 2.2 — Round-the-clock availability (Article 5a(1))

- [ ] Our SCT Inst service is available **24 hours a day, every calendar day** — no business-hour windows, no weekend cut-offs, no end-of-day batch closures, no public-holiday outages
- [ ] We have planned-maintenance windows that are (a) foreseeable, (b) short, and (c) communicated to PSUs in advance — the only category of unavailability not subject to penalty under Article 11(1c)
- [ ] We have a downtime-communication mechanism (in-app, email, status page) wired into our incident-management process
- [ ] We participate in (or have a routing arrangement with) a retail payment system that operates SCT Inst settlement 24/7 (TIPS, RT1, or domestic equivalent)

> **Legal advisor note:** The Article 11(1c) exemption is narrow. "Planned maintenance" does not cover unplanned outages, vendor failures, or capacity-driven degradations. If your scheme operator declares a planned downtime under its rulebook, you inherit that exemption; if your own infra fails, you do not.

**Reference:** Article 5a(1) second subparagraph; Article 11(1c) as inserted by Article 1(3) IPR

---

### 2.3 — Execution-time obligation: the 10-second rule (Article 5a(4))

This is the operational hard edge of the Regulation. Read each requirement and confirm your build meets it.

- [ ] Immediately after time of receipt, the **payer's PSP** verifies that all conditions for processing are met and funds are available
- [ ] The payer's PSP **reserves or debits** the amount from the payer's account
- [ ] The payer's PSP **immediately sends** the payment transaction to the payee's PSP
- [ ] Within **10 seconds** of the time of receipt of the payment order by the payer's PSP, the **payee's PSP** makes the amount available on the payee's account in the payee's account currency
- [ ] The payee's PSP **confirms completion** to the payer's PSP within that same 10-second window
- [ ] The credit **value date** for the payee's account equals the actual credit date (Article 5a(4)(d))
- [ ] Immediately upon receiving the completion confirmation — or after 10 seconds without it — the payer's PSP informs the payer (and any PISP) whether funds were made available, **free of charge** (Article 5a(4)(e))
- [ ] If no confirmation is received within 10 seconds, the payer's PSP **immediately restores** the payer's account to the pre-transaction state (Article 5a(5))

> **⚠️ Build-time check:** The 10-second budget is end-to-end (payer's PSP receives order → payee's PSP confirms back). Your share of that budget is typically 2–4 seconds depending on the scheme. Map every internal hop: fraud screening, AML real-time checks, FX (if applicable), core-banking debit, scheme-network round-trip, response handling. If any single hop is variable above 1 second under load, you have a problem.

**Reference:** Article 5a(4) and (5)

---

### 2.4 — Time of receipt — special cases (Article 5a(3))

- [ ] **Standard rule:** time of receipt = moment the order is received by the payer's PSP, regardless of hour or calendar day (overrides PSD2 Article 78(1) second subparagraph)
- [ ] **Scheduled future-dated transfers:** time of receipt = the agreed execution moment (overrides PSD2 Article 78(2))
- [ ] **Non-electronic (paper-based) orders:** time of receipt = moment the order information is entered into the PSP's internal system, which must occur as soon as possible after the order is placed
- [ ] **Packaged orders unpacked by the payer's PSP:** time of receipt = moment the individual transaction has been unpacked (and unpacking must start immediately)
- [ ] **Non-euro-denominated source account:** time of receipt = moment of FX conversion into euro, which must occur immediately after the order is placed

> **Legal advisor note:** Each of these rules creates a distinct compliance evidence trail. Your audit log must timestamp each event with millisecond precision and survive customer disputes and supervisory inspection.

**Reference:** Article 5a(3)

---

### 2.5 — Payment initiation channel parity (Article 5a(4)(a))

- [ ] Every channel through which a payer can initiate a non-instant credit transfer **must also** support instant credit transfers, including:
  - [ ] Online / web banking
  - [ ] Mobile banking application
  - [ ] ATM transfers (if offered)
  - [ ] Self-service terminals / kiosks
  - [ ] In-branch / paper-based orders
  - [ ] Telephone banking
  - [ ] PISP-initiated payments (open-banking API)
  - [ ] Batch / file upload (where offered for non-instant)
- [ ] PSPs **may** default new credit-transfer orders to SCT Inst (recital 11) — confirm whether your product strategy uses this default

> **Legal advisor note:** Channel parity is a frequent supervisory complaint vector. PSPs commonly launch SCT Inst on web/mobile first and leave branch/ATM channels behind. Both must be ready by the applicable Section 10 deadline.

**Reference:** Article 5a(4)(a) and (7); recital 11

---

### 2.6 — User-set per-day / per-transaction limit (Article 5a(6))

- [ ] On PSU request, we offer the ability to set a **maximum amount** that can be sent by instant credit transfer
- [ ] The limit can be set on a per-day **or** per-transaction basis, at the PSU's sole discretion
- [ ] The PSU can **modify or lift** the limit at any time prior to placing a payment order, **without difficulty and with immediate effect**
- [ ] If an order would exceed the limit, we **do not execute** it, **notify** the PSU, and **inform** the PSU how to modify the limit
- [ ] This limit is distinct from any PSP-imposed risk-based cap (e.g., your AML/fraud caps) — both can coexist but the user-set cap is a contractual right

**Reference:** Article 5a(6); recital 19

---

### 2.7 — Packaged orders (Article 5a(7))

- [ ] If we offer packaged (batch) order submission for non-instant credit transfers, we also offer it for instant credit transfers
- [ ] We do **not** impose a lower **number-of-orders** cap on instant-CT packages than on non-instant-CT packages (Art 5a(7) second subparagraph governs the *count* of orders per package, not the aggregate value)
- [ ] We start unpacking immediately upon receipt and transmit each unpacked transaction individually to the payee's PSP

**Reference:** Article 5a(7); recital 13

---

### 2.8 — Non-euro Member State limited carve-out (Article 5a(2), (8))

*Skip this subsection if you are in a euro-area Member State.*

- [ ] We have applied to our competent authority for prior permission to limit **sending** instant CTs outside business hours from accounts denominated in our national currency
- [ ] The limit set by the competent authority is **at least EUR 25,000** per transaction
- [ ] The permission is valid for **one year**, renewable annually following a reassessment of euro liquidity access
- [ ] The competent authority will notify the Commission annually of permissions granted
- [ ] We have noted the **hard sunset of 9 June 2028** for the carve-out on sending from national-currency accounts outside business hours

**Reference:** Article 5a(2); Article 5a(8) third subparagraph

---

## SECTION 3 — ARTICLE 5b — CHARGE PARITY

*This is the single most-likely revenue-model break for legacy PSPs. If you charge a premium for SCT Inst today, you cannot continue post-deadline. Resolve this in your pricing roadmap before any other build work.*

---

### 3.1 — The parity rule (Article 5b(1))

- [ ] All charges levied on payers and payees for sending and receiving SCT Inst — including per-transaction and lump-sum charges — **do not exceed** the equivalent charges for **other credit transfers of corresponding type**
- [ ] We have mapped, for every PSU segment (retail, business, premium tiers), the charge for non-instant SEPA and confirmed the SCT Inst charge is ≤ that level
- [ ] We have identified what constitutes "corresponding type" — using criteria such as: payment initiation channel, payment instrument, customer status, additional features and services (recital 17)
- [ ] We have confirmed our charge structure cannot be construed as a circumvention (e.g., introducing a new "premium SCT Inst" tier with extra features just to maintain margin)

> **⚠️ Revenue model check:** If your current product economics assume SCT Inst is a premium-priced add-on, the model is dead under Article 5b(1) from the applicable Section 10 deadline. Reprice non-instant up to match, or accept the same price on both.

**Reference:** Article 5b(1); recitals 17–18

---

### 3.2 — Additional features and services (recital 18)

- [ ] Where we offer additional features or services on top of an instant-CT product (e.g., payment-request integration, dispute resolution, refunds, POI-merchant tooling), we may charge separately for those features
- [ ] We do **not** offer different "variants" of a payment solution where the **only** difference is instant vs. non-instant with the same features and services and price the instant variant higher
- [ ] We have audit-trail evidence that a feature-laden SCT Inst product genuinely differs from the base non-instant comparator

**Reference:** Recital 18

---

### 3.3 — Verification-of-Payee fees (Article 5b(2))

- [ ] The Verification of Payee service (Article 5c) is provided to all PSUs **free of charge**
- [ ] Our commercial pricing schedule contains no VoP fee — neither per-check, per-month, nor bundled

**Reference:** Article 5b(2)

---

### 3.4 — Cross-border charge alignment (Article 2 IPR amending Regulation (EU) 2021/1230)

- [ ] Where we are a non-euro-area PSP, we have confirmed that cross-border instant-CT charges in euro do **not exceed** charges for cross-border non-instant CTs in euro
- [ ] We understand that, in the conflict case where the older Article 3(1) of Regulation 2021/1230 (national-currency-charge equivalence) would produce a higher fee than Article 5b(1) IPR, the IPR overrides

**Reference:** IPR Article 2(1) inserting new Article 3(5) into Regulation (EU) 2021/1230; recital 30

---

## SECTION 4 — ARTICLE 5c — VERIFICATION OF THE PAYEE (VoP)

*VoP is the single largest new operational build in the IPR. It is mandatory on every credit transfer (instant or not), pre-authorisation, across every channel. Plan the build alongside SCT Inst — do not treat it as a phase 2.*

---

### 4.1 — Core obligation (Article 5c(1))

- [ ] Before the payer is offered the possibility of authorising a credit transfer, our PSP offers a service ensuring **verification of the payee** (VoP)
- [ ] The VoP service is performed **immediately** after the payer provides the relevant payee information
- [ ] The VoP service is offered **regardless of the payment initiation channel** — web, mobile, ATM, branch, telephone, PISP, batch
- [ ] The VoP service applies to **all** credit transfers in scope of Regulation 260/2012, not just instant credit transfers (the obligation sits in the SEPA Regulation, not in a SCT-Inst-only chapter)

**Reference:** Article 5c(1) chapeau

---

### 4.2 — VoP matching rules — the four scenarios (Article 5c(1)(a)–(d))

- [ ] **(a) IBAN + name provided by payer:** payer's PSP requests payee's PSP to verify match between the IBAN and the payee name. On mismatch, notify the payer and warn that authorising might transfer funds to a wrong payee. On "almost match," indicate to the payer the name actually associated with the IBAN
- [ ] **(b) Legal-person payee with alternative unambiguous identifier:** where a channel allows the payer to provide IBAN + another unambiguous identifier (fiscal number, European unique identifier under Directive 2017/1132, or LEI), the payee's PSP verifies match between IBAN and that identifier if held in its internal system. On mismatch, notify the payer
- [ ] **(c) Multi-payee accounts:** where one account is held on behalf of multiple payees, additional payer-supplied information can be used. Payee's PSP confirms whether the indicated payee is among the multiple payees. On no, notify the payer
- [ ] **(d) Channels that do not require both IBAN and name:** PSP must ensure the payee is correctly identified by some other means and inform the payer to validate the payee before authorising

> **Legal advisor note:** Scenario (b) is the lever for B2B / corporate-payments products. If your channel can capture fiscal IDs or LEIs, you gain a more robust match signal than name-based matching, which is friction-heavy due to diacritics, transliterations, and trading-name vs. legal-name mismatches (recital 21).

**Reference:** Article 5c(1)(a)–(d); recital 21

---

### 4.3 — VoP via Payment Initiation Service Providers (Article 5c(2))

- [ ] Where the payee details are provided by a PISP rather than directly by the payer, the **PISP** is responsible for ensuring payee information is correct
- [ ] We have a contractual arrangement with any PISPs that operate against our APIs that allocates this responsibility and the consequential liability

**Reference:** Article 5c(2)

---

### 4.4 — Robust internal procedures (Article 5c(3))

- [ ] For scenario 4.2(d) — channels where IBAN + name are not both required — and for PISP-mediated payments, we maintain documented internal procedures to ensure payee information correctness
- [ ] These procedures are linked to our ICT-risk-management framework under DORA (Regulation (EU) 2022/2554) where applicable

**Reference:** Article 5c(3)

---

### 4.5 — Paper-based orders (Article 5c(4))

- [ ] For paper-based orders, the VoP service is performed **at the time of receipt of the payment order**, unless the payer is not present at that time

**Reference:** Article 5c(4)

---

### 4.6 — VoP does not block authorisation (Article 5c(5))

- [ ] Performing the VoP service does not prevent the payer from authorising the credit transfer
- [ ] The flow is: VoP runs → result returned → payer makes informed authorisation decision, including the right to proceed despite a mismatch warning

**Reference:** Article 5c(5)

---

### 4.7 — Opt-out for non-consumer packaged-order PSUs (Article 5c(6))

- [ ] Non-consumer PSUs submitting packaged payment orders can **opt out** from receiving the VoP service
- [ ] Such PSUs can **opt back in at any time**
- [ ] The opt-out mechanism is operational and contractually integrated

**Reference:** Article 5c(6); recital 24

---

### 4.8 — Notification and consequence disclosure (Article 5c(7))

- [ ] Whenever VoP results in a notification under (a), (b), or (c), the PSP simultaneously **informs the payer** that authorising might lead to transferring funds to an account not held by the indicated payee
- [ ] When a non-consumer PSU opts out, the PSP provides the same warning
- [ ] PSUs are informed of the **implications for PSP liability and PSU refund rights** of ignoring a VoP warning

**Reference:** Article 5c(7)

---

### 4.9 — Liability allocation (Article 5c(8))

- [ ] A PSP is **not liable** for execution to an unintended payee on the basis of an incorrect unique identifier (per PSD2 Article 88) **provided it has fulfilled Article 5c**
- [ ] If the **payer's PSP** fails to comply with Article 5c(1), and that failure causes a defectively executed transaction, the payer's PSP refunds the payer **without delay** and restores the debited account
- [ ] If the **PISP** fails to comply with Article 5c(2), the payer's PSP still refunds the payer, then is **compensated by the PISP** for the financial damage
- [ ] If the **payee's PSP** fails to comply, the payee's PSP **compensates the payer's PSP** for the financial damage caused
- [ ] Further losses are addressed under the law applicable to the PSP–PSU contract

> **⚠️ Build-time check:** The VoP service must be auditable end-to-end per transaction. If you cannot prove you correctly performed VoP for a given disputed transaction, you lose the Article 5c(8) liability shield. Logging is not optional.

**Reference:** Article 5c(8)

---

### 4.10 — Industry-wide standards (recital 23)

- [ ] We are tracking the EPC SEPA Payment Account Verification (SPAA / VoP) scheme rulebook and have confirmed our implementation aligns
- [ ] We have implemented or contracted a routing mechanism to query other PSPs' VoP endpoints across the SEPA zone

**Reference:** Recital 23

---

## SECTION 5 — ARTICLE 5d — DAILY SANCTIONS SCREENING OF PSUs

*This is the most counter-intuitive provision in the IPR. The Regulation prohibits transaction-by-transaction sanctions screening for SCT Inst and replaces it with a daily PSU-level screen. If your existing AML platform runs name-screening on every transaction, you must re-architect.*

---

### 5.1 — The core obligation (Article 5d(1))

> **When does Article 5d bind us?** The Article 5d obligation attaches to "**PSPs offering instant credit transfers**" — not to every PSP unconditionally. Once you begin offering SCT Inst, you must comply with Article 5d from the start. The hard deadline of **9 January 2025** in Article 5d(3) is the date by which any PSP *that offers SCT Inst on or after that date* must be screening daily. PIs/EMIs whose own Article 5a offering deadline is 9 April 2027 (Section 10) are bound by Article 5d only once their SCT Inst offering goes live — but if they offer earlier voluntarily, Article 5d binds from 9 January 2025 or from go-live, whichever is later. Credit institutions in the euro area had to begin receiving SCT Inst by 9 January 2025, so for them Article 5d bites on the same date.

- [ ] We screen **all our PSUs** to verify whether any are persons or entities subject to **targeted financial restrictive measures** (asset freezes or prohibitions on making funds/economic resources available, adopted under Article 215 TFEU)
- [ ] We carry out such screening **immediately** after the entry into force of any new targeted financial restrictive measure
- [ ] We carry out such screening **immediately** after any amendment to existing targeted financial restrictive measures
- [ ] We carry out such screening **at least once every calendar day**
- [ ] The screening pulls from the authoritative Union sanctions lists (Article 215 TFEU instruments)

**Reference:** Article 5d(1); recital 25

---

### 5.2 — Prohibition on transaction-level screening (Article 5d(2))

- [ ] During execution of an SCT Inst, neither the payer's PSP nor the payee's PSP performs **additional** transaction-level verification of whether payer or payee is subject to targeted financial restrictive measures — beyond what Article 5d(1) already requires
- [ ] We have decommissioned or reconfigured any sanctions-screening control on the SCT Inst rail that would otherwise reject transactions for sanctions-list matches at execution
- [ ] We have **retained** sanctions screening on non-instant rails and for **other** restrictive-measure types (non-Article-215, or Article-215 measures other than asset freezes/funds-availability prohibitions)
- [ ] We have **retained** AML/CFT transaction monitoring under AMLD/AMLR — Article 5d does not override AML obligations (Article 5d(2) second subparagraph)

> **Legal advisor note:** This is the most-misread provision in the Regulation. PSPs commonly read Article 5d as "you can stop sanctions screening on SCT Inst." That is wrong. It is "you must screen your customer base daily *instead of* per-transaction." The screening burden is reallocated, not removed. Get this wrong and you face the Article 11(1b) penalty regime (Section 8.2).

**Reference:** Article 5d(2); recital 26

---

### 5.3 — Build implications

- [ ] We have a **PSU master register** of all natural and legal persons who hold or operate payment accounts with us
- [ ] We have a sanctions-list ingestion pipeline that fires within minutes of EU Official Journal publication
- [ ] We have a screening engine that can re-screen the full PSU base on every sanctions-list update — not just incremental updates
- [ ] We have a freezing mechanism that can be triggered immediately upon match — including for inbound SCT Inst credits to a now-listed PSU
- [ ] We have removed the per-transaction screening node from our SCT Inst rail, while preserving it for non-instant CTs and other rails

**Reference:** Article 5d(1) and (2)

---

## SECTION 6 — SETTLEMENT FINALITY DIRECTIVE AMENDMENTS (PIs/EMIs INTO DESIGNATED PAYMENT SYSTEMS)

*Skip this section if you are a credit institution. Read it carefully if you are a payment institution or EMI — this is the structural change that lets you join TIPS/RT1/national instant rails directly.*

---

### 6.1 — Expanded "institution" definition (Article 4 IPR)

- [ ] We are a PI or EMI that wants to participate **directly** (not via a sponsoring bank) in a payment system designated by a Member State under SFD
- [ ] We are **not** benefitting from a PSD2 Article 32 / 33 exemption (small PI / account information service waiver) — those are explicitly excluded from the new "institution" definition
- [ ] We have confirmed with the operator of the designated system its participation criteria (which the operator is now required to apply to us on objective, proportionate, non-discriminatory grounds per PSD2 Article 35)

**Reference:** IPR Article 4; SFD Article 2(b) (new indents)

---

### 6.2 — Indirect access via existing participants (PSD2 Article 35(3))

- [ ] If we cannot or do not want direct participation, we can request **indirect access** through an existing participant
- [ ] Where the existing participant already lets one PI/EMI pass transfer orders through the system, it must offer the same opportunity to other authorised or registered PSPs on **objective, proportionate, and non-discriminatory** terms
- [ ] Any refusal must come with **full reasons**

**Reference:** PSD2 Article 35(3) as inserted by IPR Article 3(2)(b)

---

## SECTION 7 — PSD2 AMENDMENTS — CONDITIONS FOR PI/EMI PARTICIPATION (ARTICLE 35a)

*The price of admission to designated payment systems. Read it if you are a PI/EMI scoping direct participation.*

---

### 7.1 — Three mandatory artefacts (Article 35a(1))

To request participation in a designated payment system, PIs and EMIs must have in place:

- [ ] **(a) Safeguarding description** — measures taken for safeguarding PSU funds
- [ ] **(b) Governance and internal controls description** — including administrative, risk-management, accounting procedures, and **ICT arrangements linked to DORA Articles 6 and 7**
- [ ] **(c) Winding-up plan** — for failure scenarios, adapted to size and business model, covering execution of pending transactions and termination of existing contracts

**Reference:** PSD2 Article 35a(1) as inserted by IPR Article 3(3)

---

### 7.2 — Safeguarding description content (Article 35a, paragraph 1, second subparagraph)

If safeguarding via **separate account / low-risk investments**:

- [ ] Investment policy ensuring assets are liquid, secure, and low-risk
- [ ] Number of persons with access to the safeguarding account and their functions
- [ ] Administration and reconciliation process for insulation against PI/EMI creditors
- [ ] Copy of the draft contract with the credit institution
- [ ] Explicit declaration of compliance with PSD2 Article 10

If safeguarding via **insurance or comparable guarantee**:

- [ ] Confirmation the insurer/guarantor is **not in the same group** as the PI/EMI
- [ ] Reconciliation process ensuring sufficiency at all times
- [ ] Duration and renewal terms of the coverage
- [ ] Copy of the insurance agreement or comparable guarantee (or drafts)

**Reference:** PSD2 Article 35a(1) second subparagraph, points (a) and (b)

---

### 7.3 — Governance arrangements (Article 35a, paragraph 1, third subparagraph)

- [ ] Risk mapping — types of risk and procedures for assessing/preventing them
- [ ] Periodic and permanent control procedures — frequency and human resources
- [ ] Accounting procedures for recording and reporting financial information
- [ ] Identity of person(s) responsible for internal-control functions, with up-to-date CVs
- [ ] Identity of any non-statutory auditor
- [ ] Composition of management body and any oversight committees
- [ ] Description of how outsourced functions are monitored and controlled
- [ ] Description of how agents and branches are monitored and controlled
- [ ] If we are a subsidiary of a regulated entity in another Member State, a description of the group governance

**Reference:** PSD2 Article 35a(1) third subparagraph, points (a)–(i)

---

### 7.4 — Winding-up plan content

- [ ] The plan describes mitigation measures in the event of termination of payment services
- [ ] The plan ensures execution of **pending payment transactions**
- [ ] The plan ensures **orderly termination of existing contracts**

**Reference:** PSD2 Article 35a(1) fourth subparagraph

---

### 7.5 — Member-State assessment procedure (Article 35a(2))

- [ ] We have confirmed the **assessment procedure** our Member State uses to verify compliance — self-assessment, explicit competent-authority decision, or another mechanism
- [ ] We have allowed time in our project plan for the supervisory cycle this implies

**Reference:** PSD2 Article 35a(2)

---

### 7.6 — Replaced PSD2 Article 10(1) — scope extension to EMIs + competent-authority obligation-imposer

The IPR did **not** tighten the substantive safeguarding obligation under PSD2 Article 10(1) — the (a) separate-account / low-risk-investment route and (b) insurance-policy / comparable-guarantee route are materially unchanged. Two **structural changes** apply:

- [ ] **Direct EMI scope** — Article 10(1) now applies directly to **electronic money institutions** as defined in Article 2(1) of Directive 2009/110/EC, alongside payment institutions. Previously the EMI safeguarding obligation reached PSD2 Article 10 indirectly via Article 7 of EMD2 (Directive 2009/110/EC). The IPR amendment removes that one-step indirection.
- [ ] **Expanded obligation-imposer** — the obligation is now framed as "**Member States or competent authorities** shall require…" (previously "Member States shall require…"). Competent authorities now have direct standing to impose the requirement, not only via national transposition.
- [ ] We have re-read our safeguarding policy against the new wording and confirmed that — for PIs — the substantive obligations are unchanged; for EMIs we have replaced the EMD2-Art-7-→-PSD2-Art-10 cross-reference path with direct reliance on the amended Article 10(1)
- [ ] We have confirmed our home Member State's national transposition position by 9 April 2025 (IPR Article 5)

**Reference:** PSD2 Article 10(1) as replaced by IPR Article 3(1); EMD2 Article 7 (legacy cross-reference path)

---

## SECTION 8 — PENALTIES (ARTICLE 11 AS AMENDED)

*The IPR introduces a harmonised maximum penalty regime — particularly for Article 5d breaches. This is the only place in the SEPA Regulation framework where the EU has imposed a minimum-maximum penalty ceiling.*

---

### 8.1 — General penalty obligation (Article 11(1a))

- [ ] We understand that Member States must have rules on penalties for infringements of Articles 5a–5d in place by **9 April 2025**
- [ ] We have read our home Member State's transposition / national-rules act to identify specific penalty ranges applicable to us
- [ ] We understand penalties must be effective, proportionate, and dissuasive

**Reference:** Article 11(1a) as inserted by IPR Article 1(3)

---

### 8.2 — Minimum-maximum penalties for Article 5d breaches (Article 11(1b))

- [ ] For a **legal person**, the maximum administrative fine is **at least 10% of total annual net turnover** of the preceding business year
- [ ] Where the legal person is a subsidiary, the relevant turnover is the **consolidated turnover of the ultimate parent**
- [ ] For a **natural person**, the maximum administrative fine is **at least EUR 5,000,000** (or equivalent in non-euro national currency on 8 April 2024)
- [ ] Senior management and management-body members can be personally penalised

> **⚠️ Risk-management implication:** Article 11(1b) imposes the harshest penalty ceiling in the IPR for sanctions-screening failures — at parity with AMLR / AMLD6 thresholds. The screening operation (Section 5) deserves Board-level governance attention.

**Reference:** Article 11(1b) as inserted by IPR Article 1(3)

---

### 8.3 — Planned-maintenance carve-out (Article 11(1c))

Penalties do **not** apply to infringements of the reachability requirement (Article 5a(1) second subparagraph) where unavailability is due to **either** of the following (the source uses "or" — these are independent alternative triggers, not cumulative):

- [ ] **(i)** Planned maintenance where periods of non-availability are **both foreseeable and short**, **OR**
- [ ] **(ii)** Planned downtime of all instant credit transfers **under the relevant payment scheme** (i.e., scheme-operator-declared scheme-wide downtime)
- [ ] **Common precondition** for both triggers: PSUs were **informed in advance** of those periods of planned maintenance or planned downtime
- [ ] We have a PSU-advance-notice template and channel ready

**Reference:** Article 11(1c) as inserted by IPR Article 1(3)

---

### 8.4 — Non-administrative-penalty Member States (Article 11(1d))

- [ ] If our Member State's legal system does not provide administrative penalties, judicial penalties of equivalent effect apply — initiated by the competent authority, imposed by judicial authorities
- [ ] Our Member State will have notified the Commission of its penalty regime by 9 April 2025

**Reference:** Article 11(1d) as inserted by IPR Article 1(3)

---

## SECTION 9 — REPORTING OBLIGATIONS (ARTICLE 15 AS AMENDED)

---

### 9.1 — Annual PSP report to competent authority (Article 15(3))

- [ ] We submit, **every 12 months**, a report to our competent authority covering:
  - [ ] Level of **charges** for credit transfers, instant credit transfers, and payment accounts
  - [ ] **Share of rejections** — separately for national and cross-border payment transactions — due to application of **targeted financial restrictive measures**
- [ ] Our **first report** was submitted on **9 April 2025**, covering the period from **26 October 2022** to the end of the preceding calendar year

**Reference:** Article 15(3) as replaced by IPR Article 1(4)

---

### 9.2 — Reporting template and methodology (Article 15(5))

- [ ] We use the EBA implementing technical standards (ITS) on uniform reporting templates, instructions, and methodology — draft submitted by EBA by 9 June 2024 and adopted by the Commission under Article 15 of Regulation (EU) 1093/2010
- [ ] Our reporting pipeline is wired to the published templates and review controls are in place

**Reference:** Article 15(5) as replaced by IPR Article 1(4)

---

### 9.3 — Competent-authority reporting to Commission / EBA (Article 15(4))

- [ ] We understand that **by 9 October 2025**, and annually thereafter, our competent authority provides to the Commission and EBA:
  - [ ] Information reported by us under Article 15(3)
  - [ ] **Volume and value** of instant credit transfers in euro sent — national and cross-border — by PSPs established in the Member State in the preceding calendar year
- [ ] We are prepared to provide additional data the competent authority needs to discharge this obligation

**Reference:** Article 15(4) as replaced by IPR Article 1(4)

---

### 9.4 — Commission review milestones

- [ ] **9 April 2027**: Commission report to Parliament and Council on remaining obstacles to availability and use of instant credit transfers (including QR codes, NFC, Bluetooth standardisation)
- [ ] **9 October 2028**: Commission report evaluating the development of charges and the scope/effectiveness of Article 5d

**Reference:** Article 15(2) and (6) as replaced by IPR Article 1(4)

---

## SECTION 10 — PHASED COMPLIANCE TIMELINE (CHEAT SHEET)

*The IPR applies different deadlines depending on currency zone and entity type. Identify your column from Section 0 and confirm every deadline.*

---

### 10.1 — Compliance deadlines by zone and entity type

| Obligation | Column A: Euro-area Credit Institutions | Column B: Non-euro-area Credit Institutions | Column C: Euro-area PIs / EMIs | Column D: Non-euro-area PIs / EMIs |
|---|---|---|---|---|
| **Receive SCT Inst** (Article 5a) | 9 January 2025 | 9 January 2027 | 9 April 2027 | 9 April 2027 |
| **Send SCT Inst** (Article 5a) | 9 October 2025 | 9 July 2027 | 9 April 2027 | 9 July 2027 |
| **Charge parity** (Article 5b) | 9 January 2025 | 9 January 2027 | (with send obligation) | (with send obligation) |
| **Verification of Payee** (Article 5c) | 9 October 2025 | 9 July 2027 | (with send obligation) | (with send obligation) |
| **Daily PSU sanctions screening** (Article 5d) | 9 January 2025 | 9 January 2025 | 9 January 2025 | 9 January 2025 |
| **PSD2 + SFD national transposition** (Articles 3 and 4) | 9 April 2025 | 9 April 2025 | 9 April 2025 | 9 April 2025 |
| **Member-State penalty rules** (Article 11(1a)) | 9 April 2025 | 9 April 2025 | 9 April 2025 | 9 April 2025 |
| **First annual PSP report** (Article 15(3)) | 9 April 2025 | 9 April 2025 | 9 April 2025 | 9 April 2025 |
| **Non-euro-account out-of-business-hours send carve-out sunset** (Article 5a(8)) | n/a | 9 June 2028 | n/a | 9 June 2028 |

> **Critical-path observation:** Daily sanctions screening (Article 5d) **binds you from the moment you offer SCT Inst on or after 9 January 2025**. Credit institutions in the euro area had to begin receiving SCT Inst by 9 January 2025, so for them the Article 5d screening deadline is 9 January 2025. Non-euro-area credit institutions begin offering by 9 January 2027 (receive), so they bind from that date. PIs/EMIs in the euro area whose own Article 5a deadline is 9 April 2027 are bound by Article 5d only from 9 April 2027 — unless they voluntarily begin offering earlier, in which case they bind from the earlier of 9 January 2025 or go-live. Any PSP offering SCT Inst today without daily-screening capability is out of compliance.

**Reference:** Article 5a(8); Article 5b(3); Article 5c(9); Article 5d(3); Article 11(1a); Article 15(3); IPR Article 5 (transposition deadline)

---

### 10.2 — Newly euro-adopting Member States (Article 16(9))

- [ ] If our Member State adopts the euro before 9 April 2027, we comply with Articles 5a, 5b, and 5c within **one year** of euro adoption — but not later than the dates specified for non-euro-area PSPs
- [ ] We are not required to comply earlier than the dates specified for euro-area PSPs

**Reference:** SEPA Regulation Article 16(9) as inserted by IPR Article 1(5)

---

## SECTION 11 — FIRST-MEETING DELIVERABLES

By the end of this checklist you should be able to give your legal advisor:

- [ ] **Entity status** — credit institution / PI / EMI / other, plus home Member State authorisation reference
- [ ] **Currency zone** — euro-area or non-euro-area, with column letter from Section 10.1
- [ ] **Account inventory** — every payment-account product, current SCT reachability flag, target SCT Inst reachability flag, and date
- [ ] **Channel inventory** — every payment-initiation channel and its SCT Inst readiness
- [ ] **10-second budget mapping** — internal latency budget per hop versus the 10-second end-to-end ceiling
- [ ] **Charge schedule** — current SCT vs. SCT Inst pricing for every PSU segment, with the parity gap quantified
- [ ] **VoP build plan** — scenario-by-scenario coverage (a/b/c/d), PISP contracts, scheme-rulebook alignment, logging
- [ ] **PSU sanctions-screening architecture** — list-ingestion pipeline, full-base re-screen capability, freeze trigger, decommission plan for per-transaction screening on SCT Inst
- [ ] **Designated-system access plan** (PIs / EMIs only) — direct vs. indirect, target system (TIPS / RT1 / domestic), Article 35a artefacts status
- [ ] **Penalty regime** — home Member State transposition status and any specific national-rule deviations
- [ ] **Reporting pipeline** — readiness for the EBA-template-based annual report

---

## SECTION 12 — RED-FLAG SUMMARY

These are the issues that most often kill or delay an IPR-readiness programme.

- [ ] ⚠️ **Account-reachability gaps** — at least one credit-transfer-reachable account category is not SCT-Inst-reachable on the deadline
- [ ] ⚠️ **10-second budget overruns** — internal hops (fraud, AML, FX, core-banking) cumulatively exceed the available share of the 10-second end-to-end ceiling under load
- [ ] ⚠️ **Channel parity gap** — branch / ATM / batch channels lag mobile / web on SCT Inst readiness
- [ ] ⚠️ **SCT Inst priced above SCT** — current commercial model breaks Article 5b(1)
- [ ] ⚠️ **VoP treated as phase 2** — VoP deadline equals send-SCT-Inst deadline, no later
- [ ] ⚠️ **Per-transaction sanctions screening retained on SCT Inst rail** — direct breach of Article 5d(2)
- [ ] ⚠️ **No daily full-base PSU re-screen capability** — direct breach of Article 5d(1), maximum penalty 10% of consolidated turnover
- [ ] ⚠️ **PI / EMI participation plan assumes the pre-IPR access regime** — Article 35a artefacts (safeguarding description, governance description, winding-up plan) are not in place
- [ ] ⚠️ **No advance-notice mechanism for planned downtime** — loses the Article 11(1c) penalty carve-out
- [ ] ⚠️ **Logging insufficient to evidence VoP performance per transaction** — loses the Article 5c(8) liability shield

---

## APPENDIX A — KEY DEFINITIONS

| Term | Source | Definition (paraphrased) |
|---|---|---|
| Instant credit transfer | SEPA Reg Art 2(1a) | A credit transfer executed immediately, 24 hours a day, on any calendar day |
| Payment initiation channel | SEPA Reg Art 2(1b) | Any method/device/procedure through which a payer places a payment order with their PSP — online, mobile, ATM, branch, etc. |
| Payment initiation service provider (PISP) | SEPA Reg Art 2(1c) → PSD2 Art 4(18) | A PSP that initiates a payment order on behalf of a PSU with respect to an account held at another PSP |
| Name of the payee | SEPA Reg Art 2(1d) | Natural person: name and surname. Legal person: commercial or legal name |
| Targeted financial restrictive measure | SEPA Reg Art 2(1e) | Asset freeze or prohibition on making funds/economic resources available, adopted under Article 215 TFEU |
| Legal Entity Identifier (LEI) | SEPA Reg Art 2(1f) | Unique alphanumeric reference code based on ISO 17442 standard, assigned to a legal entity |
| Retail payment system | SEPA Reg Art 2(22) | A payment system mainly processing/clearing/settling small-amount credit transfers and direct debits — not a large-value payment system |
| Payment account | SEPA Reg Art 2(5) → PSD2 Art 4(12) | An account held in the name of one or more PSUs used for the execution of payment transactions |

**Reference:** SEPA Regulation Article 2 as amended by IPR Article 1(1)

---

## APPENDIX B — CROSS-REFERENCE TABLE (IPR → Underlying Act)

| IPR provision | Amends | Effect |
|---|---|---|
| IPR Art 1(1) | SEPA Reg Art 2 | New definitions: instant credit transfer, payment initiation channel, PISP, name of the payee, targeted financial restrictive measure, LEI |
| IPR Art 1(2) | SEPA Reg (new Arts 5a–5d) | Core obligations: instant CT, charges, VoP, sanctions screening |
| IPR Art 1(3) | SEPA Reg Art 11 | Penalty regime including 10% turnover ceiling for Article 5d breaches |
| IPR Art 1(4) | SEPA Reg Art 15 | Reporting and review (2027 obstacles report, 2028 charges/Article-5d effectiveness report) |
| IPR Art 1(5) | SEPA Reg Art 16 | Newly euro-adopting Member State transition rule |
| IPR Art 2(1) | Reg 2021/1230 Art 3 | Cross-border instant-CT charge alignment |
| IPR Art 2(2) | Reg 2021/1230 Art 6 | IBAN/BIC fee clarification |
| IPR Art 3(1) | PSD2 Art 10 | Tightened safeguarding wording |
| IPR Art 3(2) | PSD2 Art 35 | Group-only payment system exemption + indirect-access fairness duty |
| IPR Art 3(3) | PSD2 (new Art 35a) | PI/EMI conditions for designated-system participation |
| IPR Art 4(1) | SFD Art 2(b) | PIs and EMIs added to "institution" definition |
| IPR Art 4(2) | SFD Art 2(f) | "Participant" definition cross-reference update |
| IPR Art 5 | — | Transposition of PSD2 and SFD amendments by 9 April 2025 |
| IPR Art 6 | — | Entry into force on 8 April 2024 (20th day after 19 March 2024 OJ publication) |

---

**End of checklist.** Use this document as a structured intake for the first legal-engagement meeting and as a project tracker through the build phase. Items left unticked at the end of the project are residual compliance gaps and should be either closed before the applicable Section 10 deadline or formally accepted by the Board with mitigation.
