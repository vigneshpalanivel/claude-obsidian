# TFR (Travel Rule) Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for PSPs and CASPs under the EU Transfer of Funds Regulation

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU Transfer of Funds Regulation (TFR) — Regulation (EU) 2023/1113 (recast of Regulation (EU) 2015/847)
**Status:** Entered into force 9 June 2023. **Applies from 30 December 2024** (same application date as MiCA — by design, since TFR Title III obligations attach to "crypto-asset service provider" as defined in MiCA Art 3(1)(15)).
**Document type:** Pre-go-live readiness assessment — to be completed before any in-scope transfer of funds or crypto-assets is executed by a Union-established PSP or CASP, and refreshed annually thereafter.

---

> **Who this document is for:** Founders, MLROs, compliance officers, heads of operations, and general counsel at any payment service provider (PSP) authorised under PSD2 / EMD2, or any crypto-asset service provider (CASP) authorised under MiCA Title V, that originates, receives, or intermediates transfers of funds or crypto-assets touching the Union. TFR is the EU implementation of FATF Recommendation 16 (the "Travel Rule") and is the operational counterpart to AMLR/AMLD6 — AML/CFT tells you *who you must know*, TFR tells you *what information must travel with each transfer*. For CASPs the regime is materially stricter than for PSPs: there is **no de minimis threshold**, all transfers are treated as cross-border, and self-hosted address transactions create a new ownership-verification obligation.

---

> **How to use this checklist:** Work through Sections 1–3 first to establish scope and role. Then drill into the obligations that match your role (PSP of payer, PSP of payee, intermediary PSP, CASP of originator, CASP of beneficiary, intermediary CASP). Every checkbox (☐) represents a concrete operational requirement that must be in production before 30 December 2024 (or before authorisation, whichever is later). Items you cannot tick represent gaps that will trigger Article 29 sanctions (repeated/systematic failure to accompany transfers with required information is an explicit specific-breach trigger). The TFR is **directly applicable** — there is no national transposition layer; your NCA enforces the Regulation as written.

---

## SECTION 1 — DOES TFR APPLY TO YOU?

*TFR is a connecting-factor regulation. Unlike AMLR (which applies to obliged entities) or MiCA (which applies to authorised CASPs), TFR attaches to the **transfer** — if any PSP or CASP in the chain is established in the Union, the entire transfer falls under TFR for that leg. Article 2 is the gating provision.*

---

### 1.1 — Territorial Scope: Is the Transfer In-Scope?

Answer each question. If any answer is **Yes**, TFR applies to your leg of the transfer.

- [ ] Is the PSP or intermediary PSP of either the payer or the payee established in the Union?
- [ ] Is the CASP or intermediary CASP of either the originator or the beneficiary registered (registered office) in the Union?
- [ ] Are you executing transfers via a **crypto-ATM** physically located in, or operated from, the Union? *(crypto-ATM transfers are expressly in-scope per Article 2(1), regardless of customer location)*
- [ ] Are you a Union-established PSP or CASP acting on your own behalf as **intermediary** in a transfer where neither end-customer is your client?

> **Legal advisor note:** TFR is connecting-factor based, not customer-based. A Union CASP receiving a transfer from a third-country CASP is fully in-scope for the receiving leg — including the obligation to detect missing information, verify the beneficiary, and apply risk-based decisions on rejection or suspension. There is no "passive recipient" defence.

**Reference:** TFR Article 1 (Subject matter), Article 2(1) (Scope)

---

### 1.2 — Exclusion Check: Is Your Activity Outside TFR's Scope?

TFR does **not** apply to the following carve-outs. Check any that describe your activity:

**Funds-side carve-outs:**

- [ ] Services listed in Article 3(a)–(m) and point (o) of PSD2 *(Directive (EU) 2015/2366)* — e.g. cash-only operations, paper-based instruments, technical service providers
- [ ] Payment-card / e-money instrument / mobile-device transfers where (i) the instrument is used **exclusively** to pay for goods or services and (ii) the card/instrument/device number accompanies all transfers *(Art 2(3))* — **does NOT apply where the same instrument is used for consumer-to-consumer transfers**
- [ ] Cash-conversion service providers and pure messaging/clearing/settlement support providers *(Art 2(4))*
- [ ] Payer withdrawing cash from their own payment account
- [ ] Transfers to a public authority as payment for taxes, fines or other levies within a Member State
- [ ] Transfers where both payer and payee are PSPs acting on their own behalf
- [ ] Cheque-image exchanges, including truncated cheques
- [ ] **Domestic low-value transfer exemption (Member State option, Art 2(5))** — Member State may exempt transfers within its territory to a payee account permitting payment exclusively for goods/services, where the payee's PSP is subject to AMLD5/AMLR, the transfer is fully traceable through a unique transaction identifier, and the amount **does not exceed €1,000**

**Crypto-side carve-outs:**

- [ ] Both originator and beneficiary are CASPs acting on their own behalf *(Art 2(4))*
- [ ] **Person-to-person transfer of crypto-assets carried out without the involvement of any CASP** *(Art 2(4)(b); Art 3(13) definition)*
- [ ] Pure ancillary infrastructure providers (internet/cloud/software developers) that do not themselves execute transfers *(Recital 21)*
- [ ] **Crypto-assets that are unique and non-fungible** — out of scope **unless** they are classified as crypto-assets or funds under MiCA *(Art 2 final indent; Recital 24)*

> **Critical note — EMTs are crypto-assets for TFR purposes:** Article 2 final indent expressly states that **electronic money tokens** (EMTs as defined in MiCA Art 3(1)(7)) "shall be treated as crypto-assets under this Regulation". This means EMT transfers fall under **Chapter III** (CASP obligations: full Travel Rule data, no de minimis, self-hosted address rules), not Chapter II (PSP obligations). EMT issuers that are EMIs under EMD2 face dual classification — they are PSPs for the e-money side of their business and CASPs for the EMT-on-DLT side.

> **Critical note — "Fully decentralised" is not a TFR exit:** Person-to-person transfers without CASP involvement are out of scope, but the moment a CASP touches any leg of the transfer (as originator's CASP, beneficiary's CASP, or intermediary), the full Chapter III regime applies. There is no "DeFi protocol" carve-out. If your front-end, smart contract, or routing logic functions as a CASP under MiCA Art 3(1)(15), TFR attaches.

**Reference:** TFR Article 2(2)–(5), Article 3(13) (person-to-person definition), Recitals 20–25

---

### 1.3 — Your Role in the Transfer Chain

TFR creates **six distinct compliance roles**, each with a different obligation set. Tick every role you play. You may play more than one role on the same transfer (e.g. a CASP acting for both originator and beneficiary on an internal-book transfer).

**Funds side (Chapter II):**

- [ ] **PSP of the payer** *(Section 1, Arts 4–6)* — you initiate the transfer on behalf of the payer
- [ ] **PSP of the payee** *(Section 2, Arts 7–9)* — you receive and credit the transfer to the payee
- [ ] **Intermediary PSP** *(Section 3, Arts 10–13)* — you sit between the payer's PSP and the payee's PSP

**Crypto side (Chapter III):**

- [ ] **CASP of the originator** *(Section 1, Arts 14–15)* — you initiate the transfer of crypto-assets on behalf of the originator
- [ ] **CASP of the beneficiary** *(Section 2, Arts 16–18)* — you receive the transferred crypto-assets on behalf of the beneficiary
- [ ] **Intermediary CASP** *(Section 3, Arts 19–22)* — you receive and transmit a transfer on behalf of another CASP without being the originator's or beneficiary's CASP

> **Legal advisor note:** Role assignment is per-transfer, not per-entity. The same CASP can be the originator's CASP on transfer A and the beneficiary's CASP on transfer B. Your operational architecture must enforce the role boundary at execution time — the Article 14 data-collection obligation cannot be deferred until after the transfer is broadcast. Submission must be "in advance of, or simultaneously or concurrently with" the transfer (Art 14(4)).

**Reference:** TFR Article 3 (Definitions, points (5)–(6) PSPs, points (15)–(16) CASPs)

---

## SECTION 2 — TRAVEL RULE DATA REQUIREMENTS (THE CORE OBLIGATION)

*Articles 4 (funds) and 14 (crypto) define what information must accompany every in-scope transfer. The crypto requirements are materially stricter than the funds requirements — there is no equivalent of the intra-Union simplified set in Article 5, and there is no de minimis threshold.*

---

### 2.1 — PSP of the Payer: Data on the Payer (Article 4(1))

For transfers of funds that **leave the Union** (or where any leg sits outside the Union), the PSP of the payer must ensure each transfer carries the following information on the **payer**:

- [ ] **(a)** Name of the payer
- [ ] **(b)** Payer's payment account number *(or unique transaction identifier where there is no payment account — Art 4(3))*
- [ ] **(c)** Payer's address, including country, **and** official personal document number **and** customer identification number — **OR**, alternatively, payer's date and place of birth
- [ ] **(d)** Where the relevant message format has the field and the payer has provided it: current **LEI** (or any available equivalent official identifier)

### 2.2 — PSP of the Payer: Data on the Payee (Article 4(2))

- [ ] **(a)** Name of the payee
- [ ] **(b)** Payee's payment account number *(or unique transaction identifier per Art 4(3))*
- [ ] **(c)** Where the relevant message format has the field and the payer has provided it: current **LEI** of the payee (or equivalent)

### 2.3 — Intra-Union Funds Simplified Set (Article 5)

Where **all** PSPs in the chain are established in the Union, transfers may be accompanied by only:

- [ ] Payment account number of both payer and payee *(or unique transaction identifier)*

> **Recall on request:** The PSP of the payer must, within **3 working days** of a request from the payee's PSP or an intermediary PSP, make available:
> - For transfers exceeding €1,000 (single or linked): the full Article 4 information set
> - For transfers ≤€1,000 not linked to others exceeding the threshold: at minimum the names of payer and payee plus their account numbers (or UTI)

### 2.4 — Verification of Payer Information (Article 4(4)–(6))

- [ ] **Before** transferring funds, the payer's PSP verifies the accuracy of the Article 4(1) information using documents, data or information obtained from a **reliable and independent source**
- [ ] Verification is deemed to have taken place where the payer's identity has been verified under AMLD5 Article 13 **and** retained under AMLD5 Article 40, **or** where AMLD5 Article 14(5) applies (delayed verification in line with ML risk)
- [ ] The payer's PSP **does not execute** any transfer before ensuring full Article 4 compliance *(Art 4(6); subject to the Art 5 intra-Union derogation and the Art 6 outside-Union derogation for small amounts)*

> **De minimis for ≤€1,000 funds transfers — narrow application:** For transfers to outside the Union not exceeding €1,000 and not appearing to be linked to other transfers exceeding that threshold, the simplified set in Art 6(2) applies and verification of payer info is not required — **unless** the funds were received in cash or anonymous e-money, or there are reasonable grounds for suspecting ML/TF. This carve-out **does not exist for crypto transfers**.

**Reference:** TFR Articles 4, 5, 6

---

### 2.5 — CASP of the Originator: Data on the Originator (Article 14(1))

**There is no de minimis. The full set below applies to every in-scope transfer of crypto-assets, regardless of value, regardless of whether the transfer is domestic or cross-border** *(Recital 30, Art 14)*.

For every transfer of crypto-assets, the CASP of the originator must ensure the following information on the **originator** accompanies the transfer:

- [ ] **(a)** Name of the originator
- [ ] **(b)** Originator's **distributed ledger (DLT) address** — where the transfer is registered on a DLT network — **and** the originator's crypto-asset account number, where such an account exists and is used to process the transaction
- [ ] **(c)** Originator's crypto-asset account number — where the transfer is **not** registered on a DLT network
- [ ] **(d)** Originator's address (including country) **and** official personal document number **and** customer identification number — **OR**, alternatively, originator's date and place of birth
- [ ] **(e)** Where the message format supports it and the originator has provided it: current **LEI** of the originator (or equivalent)

### 2.6 — CASP of the Originator: Data on the Beneficiary (Article 14(2))

- [ ] **(a)** Name of the beneficiary
- [ ] **(b)** Beneficiary's DLT address (where the transfer is registered on a DLT network) **and** beneficiary's crypto-asset account number, where one exists and is used to process the transaction
- [ ] **(c)** Beneficiary's crypto-asset account number — where the transfer is **not** registered on a DLT network
- [ ] **(d)** Where the message format supports it and the originator has provided it: current **LEI** of the beneficiary (or equivalent)

### 2.7 — Transmission Mode (Article 14(4))

- [ ] Required information is submitted **in advance of, or simultaneously or concurrently with**, the transfer of crypto-assets
- [ ] Transmission is **secure** and compliant with **GDPR (Regulation (EU) 2016/679)**
- [ ] **Information is NOT required to be attached directly to, or included in, the on-chain transaction** — Art 14(4) is expressly technology-neutral, enabling off-chain Travel Rule protocols (TRP, IVMS101, Sumsub, Notabene, Sygna, etc.)
- [ ] If transmission via an off-chain protocol cannot complete before, with, or concurrent with the on-chain leg, the transfer is **not** executed

### 2.8 — Verification of Originator Information (Article 14(6)–(8))

- [ ] **Before** the transfer is initiated, the CASP of the originator verifies the accuracy of the Article 14(1) information using documents, data, or information obtained from a **reliable and independent source**
- [ ] Verification is deemed to have taken place where the originator's identity has been verified under AMLD5 Article 13 **and** retained under AMLD5 Article 40, **or** where AMLD5 Article 14(5) applies
- [ ] The CASP of the originator does **not allow initiation and does not execute** any transfer before ensuring full Article 14 compliance *(Art 14(8))*

> **Legal advisor note — the "in advance of" wording is load-bearing:** Article 14(4) and (8) read together create a hard "no broadcast before data sent" rule. Post-fact reconciliation is non-compliant. This is the operational bite of TFR for CASPs — the design choice between (a) blocking the on-chain broadcast until the Travel Rule message is delivered and acknowledged, or (b) bonding the off-chain message to the on-chain transaction with cryptographic commitments, must be made and documented before go-live. EBA guidelines on technology-neutral implementation are issued under Art 36; check the latest version with counsel.

**Reference:** TFR Article 14, Article 36 (EBA guidelines), Recitals 30, 36–37, 50

---

### 2.9 — Batch File Transfers (Articles 6(1), 15)

If you use batch file transfers (e.g. a marketplace settling multiple beneficiary payouts in a single bundle):

**Funds (Art 6(1)):**

- [ ] Batch file contains full Article 4 information set on the single payer
- [ ] Payer information in the batch file has been verified under Article 4(4)–(5)
- [ ] Each individual transfer in the bundle carries the payer's payment account number (or UTI)

**Crypto (Art 15):**

- [ ] Batch file contains full Article 14(1) and (2) information set on the single originator
- [ ] Originator information has been verified under Article 14(6)–(7)
- [ ] Each individual transfer carries the originator's DLT address, crypto-asset account number, or UTI as applicable
- [ ] Batch information is submitted **immediately and securely** — submission after the transfer is **not permitted** *(Recital 41)*

**Reference:** TFR Articles 6, 15, Recital 40–41

---

## SECTION 3 — SELF-HOSTED ADDRESSES (THE CASP-SPECIFIC NOVELTY)

*This is the single most operationally complex obligation in TFR and the area most likely to be missed in pre-MiCA compliance gap analyses. Self-hosted address rules apply only to crypto transfers (there is no funds equivalent), and they impose obligations that have no analogue under prior AML regimes.*

---

### 3.1 — Self-Hosted Address Definition (Article 3(20))

A self-hosted address is a DLT address **not** linked to either:

- (a) a crypto-asset service provider, or
- (b) an entity not established in the Union and providing services similar to those of a CASP

In practice: any DLT address that is not linked to a known regulated counterparty entity.

- [ ] Your KYT / wallet-screening stack is able to **classify each counterparty address** at transfer time as (i) Union CASP, (ii) third-country CASP-equivalent entity, or (iii) self-hosted — and your records reflect that classification per transfer

---

### 3.2 — Transfers TO a Self-Hosted Address (Article 14(5))

- [ ] The CASP of the originator **obtains and holds** the full Article 14(1) and (2) information on both originator and beneficiary — usually from the originator-client
- [ ] The transfer can be **individually identified** in the CASP's records (no aggregation that destroys per-transfer traceability)
- [ ] **For transfers exceeding €1,000** (single or linked): the CASP of the originator takes **adequate measures to assess whether the self-hosted address is owned or controlled by the originator**

> **Practical ownership-verification techniques (subject to EBA Art 36 guidance):**
> - Signed message from the self-hosted address (e.g. EIP-191 / Satoshi-style address-signing challenge)
> - Micro-deposit + return-transfer from the address
> - Hardware-wallet attestation in supervised onboarding
> - Where the address is not the originator's: enhanced due diligence on the third-party owner per AMLD5 Article 19a

### 3.3 — Transfers FROM a Self-Hosted Address (Article 16(2))

- [ ] The CASP of the beneficiary **obtains and holds** the full Article 14(1) and (2) information — typically from the beneficiary-client (since the self-hosted sender is unknown to the CASP)
- [ ] The transfer can be **individually identified** in the CASP's records
- [ ] **For transfers exceeding €1,000** (single or linked): the CASP of the beneficiary takes **adequate measures to assess whether the self-hosted address is owned or controlled by the beneficiary**

### 3.4 — Enhanced Due Diligence on Self-Hosted Address Transfers (AMLD5 Article 19a, inserted by TFR Article 38(4))

- [ ] Your firm has documented **internal policies, procedures, and controls** to identify and assess the ML/TF risk of self-hosted address transfers
- [ ] You apply mitigating measures **commensurate with risk**, including one or more of:
  - [ ] **(a)** Risk-based identification and verification of the identity of the originator/beneficiary of the self-hosted leg, or their beneficial owner (including via reliance on third parties under AMLD5)
  - [ ] **(b)** Requiring additional information on the **origin and destination** of the transferred crypto-assets *(e.g. chain-analytics provenance, source-of-funds attestation)*
  - [ ] **(c)** Enhanced ongoing monitoring of those transactions
  - [ ] **(d)** Other measures to mitigate and manage ML/TF risks and the risk of non-implementation/evasion of targeted financial and proliferation-financing sanctions

> **Legal advisor note — Commission self-hosted review by 1 July 2026:** Article 37(2) and Recital 58 require the Commission to assess by **1 July 2026** whether additional restrictions on self-hosted address transfers are needed — possibly including limitation or prohibition. Firms relying on permissive self-hosted address economics in their business model should track this review actively. The €1,000 ownership-verification threshold and the Art 19a EDD baseline are **floors, not ceilings**; firms may apply (and supervisors may require) stricter measures.

**Reference:** TFR Articles 14(5), 16(2), 37(2); AMLD5 Articles 19a, 19b (as inserted by TFR Art 38(4)); Recitals 17, 39, 45, 58

---

## SECTION 4 — INCOMING TRANSFERS: DETECTION, RISK-BASED DECISIONS, REPEATED FAILURES

*Articles 7–9 (PSPs of payee), 11–13 (intermediary PSPs), 16–18 (CASPs of beneficiary), and 20–22 (intermediary CASPs) form a mirrored structure. The substantive obligations are: detect missing/incomplete info, apply a risk-based execute/reject/suspend decision, and escalate repeated failures by counterparty.*

---

### 4.1 — Detection of Missing or Incomplete Information

For **every** incoming transfer, your firm has effective procedures to detect:

**PSP of the payee / intermediary PSP (Arts 7, 11):**

- [ ] Whether the messaging/payment-and-settlement system fields have been filled in using **admissible characters/inputs** per system conventions
- [ ] Whether the required information set is **missing** — calibrated to whether the counterparty PSP is Union-established (Art 5 set) or outside the Union (full Art 4 set)
- [ ] Detection includes, where appropriate, **monitoring after or during the transfer** (real-time and/or post-event)

**CASP of the beneficiary / intermediary CASP (Arts 16, 20):**

- [ ] Effective procedures to detect whether the Article 14(1) and (2) information **is included in, or follows,** the transfer or batch file transfer
- [ ] Detection covers transfers **to or from self-hosted addresses** *(Art 20 expressly includes self-hosted address transfers in the detection scope for intermediary CASPs)*
- [ ] Detection includes, where appropriate, monitoring after or during the transfer

---

### 4.2 — Verification of the Receiving Party (Arts 7(3)–(5), 16(3)–(4))

**PSP of the payee:**

- [ ] For transfers **exceeding €1,000** (single or linked): verify accuracy of the payee information before crediting the payee's account or making funds available
- [ ] For transfers ≤€1,000 not linked to others exceeding €1,000: verification not required **unless** pay-out is in cash or anonymous e-money, or there are reasonable grounds for suspecting ML/TF

**CASP of the beneficiary:**

- [ ] **Before** making the crypto-assets available to the beneficiary, verify the accuracy of the Article 14(2) beneficiary information using a reliable and independent source — **no de minimis**

---

### 4.3 — Risk-Based Execute / Reject / Suspend Decision (Arts 8, 12, 17, 21)

Your firm has documented **effective risk-based procedures**, aligned with AMLD5 Article 13, that determine for each transfer with missing/incomplete information whether to:

- [ ] **Execute** (and request the missing information after the fact)
- [ ] **Reject** the transfer
- [ ] **Suspend** the transfer pending information
- [ ] **(Crypto only)** **Return** the transferred crypto-assets to the originator's crypto-asset account *(Arts 17(1)(a), 21(1)(a) — funds equivalent does not exist)*

Procedures additionally satisfy:

- [ ] Decision made on a **risk-sensitive basis and without undue delay** *(Arts 17(1), 21(1) — express speed obligation for crypto)*
- [ ] Decision factors include: counterparty PSP/CASP jurisdiction and supervision, transfer amount, customer risk profile, source/destination of crypto-assets, behavioural patterns
- [ ] Where you decide to execute despite missing info, you can articulate the risk-acceptance reasoning on file

---

### 4.4 — Repeated-Failure Escalation by Counterparty (Arts 8(2), 12(2), 17(2), 21(2))

Where a counterparty PSP or CASP **repeatedly fails** to provide required information:

- [ ] **(a)** Initial steps include issuing warnings and setting deadlines, before escalating to (b)
- [ ] **(b)** If failure persists: **directly reject any future transfers** from/to that counterparty, **or restrict or terminate** the business relationship
- [ ] You **report the failure and the steps taken** to the competent authority responsible for AML/CFT compliance monitoring

> **Legal advisor note — counterparty derisking is a sanctionable trigger in both directions:** Article 29(c)/(d) make failure to implement effective risk-based procedures (Arts 8, 12, 17) an explicit specific-breach trigger for AMLD5 Art 59 sanctions. At the same time, failure to escalate repeat offenders is itself a procedural failure. Build the counterparty-failure register early — supervisors will ask for it on first inspection.

### 4.5 — STR/FIU Reporting Hook (Arts 9, 13, 18, 22)

- [ ] Missing or incomplete information on the payer/payee or originator/beneficiary is treated as a **factor** in assessing whether the transfer (or any related transaction) is suspicious
- [ ] Where suspicion is established, the transfer is **reported to the FIU** in accordance with AMLD5 Article 33 obligations
- [ ] For crypto: additional STR factor — "the origin or destination of the crypto-assets" considered suspicious *(Recital 17, 47)*

**Reference:** TFR Articles 7–9, 11–13, 16–18, 20–22, 29(c)–(d)

---

## SECTION 5 — INTERMEDIARY-SPECIFIC OBLIGATIONS

*If you act as an intermediary PSP (Section II.3) or intermediary CASP (Section III.3), you have a "pass-through integrity" obligation in addition to the detection/risk-based obligations above.*

---

### 5.1 — Information Retention With the Transfer (Arts 10, 19)

- [ ] Intermediary PSP: **all information received** on the payer and the payee that accompanies a transfer is **retained with the transfer** when you onward-transmit it
- [ ] Intermediary CASP: all received information on originator and beneficiary is **transmitted with the transfer**, and **records of such information are retained and made available on request to competent authorities** *(Art 19 imposes both transmission and record-retention duties)*

### 5.2 — Pass-Through Detection (Arts 11, 20)

- [ ] You implement detection procedures (per Section 4.1 above) on every transfer you route — you do **not** rely on the originator-side PSP/CASP to have caught the gap
- [ ] For intermediary CASPs, detection covers self-hosted address transfers in transit *(Art 20 final clause)*

### 5.3 — Pass-Through Risk Decision (Arts 12, 21)

- [ ] You apply your own risk-based execute/reject/suspend (and, for crypto, return) decision on every transfer lacking required information
- [ ] You operate a counterparty-failure escalation register and you can demonstrate consistent action *(Arts 12(2), 21(2))*

> **Operational implication:** Intermediary CASPs cannot operate as "dumb routers". The retention + transmission + detection + decision stack means an intermediary CASP must run substantively the same Travel Rule compliance system as a customer-facing CASP. This frequently surprises liquidity providers, network bridges, and aggregator-style architectures.

**Reference:** TFR Articles 10–13 (intermediary PSPs), 19–22 (intermediary CASPs)

---

## SECTION 6 — RESTRICTIVE MEASURES (CHAPTER IV, ARTICLE 23)

*Article 23 is short but operationally significant. It is the bridge between TFR and the EU sanctions architecture (Council Regulations under Art 215 TFEU and national restrictive measures lists).*

---

- [ ] Internal policies, procedures, and controls are in place to ensure implementation of **Union and national restrictive measures** when performing transfers of funds and transfers of crypto-assets
- [ ] Sanctions screening runs against EU consolidated list, UN list, OFAC (where applicable), and Member State national lists at all of: customer onboarding, transfer initiation (originator-side), transfer receipt (beneficiary-side), and ongoing monitoring
- [ ] Screening covers names, DLT addresses, wallet identifiers, and beneficial owners
- [ ] You are tracking and applying the EBA Article 23 guidelines (issued by 30 December 2024 per Art 23 final indent) — confirm the latest version with counsel
- [ ] Sanctions hits trigger freeze, non-execution, and competent-authority reporting per the applicable Council Regulation procedures

> **Legal advisor note:** Recital 18 flags that Article 23's internal-policies obligation is **intended to be repealed in the near future** by a forthcoming Regulation on the prevention of the use of the financial system for ML/TF (the new AMLR/AMLD6 package). Treat Article 23 as the current operational requirement while monitoring the migration to the AMLR equivalent.

**Reference:** TFR Article 23, Recital 18; Council Regulations under Article 215 TFEU (e.g. (EC) No 2580/2001, (EC) No 881/2002, (EU) No 267/2012)

---

## SECTION 7 — DATA PROTECTION & RECORD RETENTION (CHAPTER V)

---

### 7.1 — GDPR Compliance (Article 25)

- [ ] Personal data processed under TFR is processed **only** for ML/TF prevention purposes — **further processing for commercial purposes is prohibited** *(Art 25(2))*
- [ ] New clients receive the GDPR Article 13 information **before** establishing the business relationship or carrying out the occasional transaction, in a concise, transparent, intelligible form per GDPR Art 12
- [ ] The notice includes a general statement of your TFR legal obligations when processing personal data for ML/TF prevention
- [ ] Transmission of personal data on the parties to a transfer complies with GDPR — including Chapter V for third-country transfers
- [ ] You are tracking and applying:
  - [ ] **European Data Protection Board guidelines** (after EBA consultation) on practical implementation of data-protection requirements for transfers of personal data to third countries in the context of crypto-asset transfers
  - [ ] **EBA guidelines** on procedures for determining whether to execute, reject, return, or suspend a crypto-asset transfer where GDPR requirements for third-country data transfer cannot be ensured

> **Legal advisor note — the GDPR collision is real:** When a Union CASP must transmit personal data to a third-country CASP that cannot meet GDPR Chapter V requirements (no adequacy decision, no SCCs, no derogation), Article 14(4)'s "submit in advance of or concurrent with the transfer" obligation and GDPR's third-country transfer rules can be mutually exclusive. The TFR resolution path is to refuse to execute the transfer — see EDPB/EBA guidelines for the documented procedure. This is the single most common cross-border compliance failure mode for CASPs.

### 7.2 — Record Retention (Article 26)

- [ ] PSPs of payer and payee retain Articles 4–7 records for **five (5) years**
- [ ] CASPs of originator and beneficiary retain Articles 14–16 records for **five (5) years**
- [ ] Records are **deleted** on expiry of the retention period — unless national law permits or requires further retention (max another 5 years) following a documented necessity-and-proportionality assessment
- [ ] Retention period is not extended unless the relevant Member State has carried out the assessment per Art 26(2)

### 7.3 — Response to Authorities (Article 24)

- [ ] You respond **fully and without delay** to enquiries from the authorities responsible for AML/CFT in the Member State where you are established or have your registered office
- [ ] Responses are channelled via a **central contact point** under AMLD5 Article 45(9) where one has been appointed
- [ ] Responses comply with the procedural requirements of the relevant national law

**Reference:** TFR Articles 24–27, Chapter V

---

## SECTION 8 — AMLD5 AMENDMENTS (ARTICLE 38) — CASPs, CORRESPONDENT RELATIONSHIPS, EDD

*TFR Article 38 inserts substantive obligations into AMLD5 (Directive (EU) 2015/849) that apply alongside TFR Chapter III for CASPs. These are AML-side obligations carried by TFR — easy to miss if you read TFR in isolation.*

---

### 8.1 — CASPs as Obliged Entities (AMLD5 Art 2(1)(3), Art 3(2)(g))

- [ ] You are aware that all CASPs as defined in MiCA Art 3(1)(15) — except those providing only **advice** on crypto-assets per MiCA Art 3(1)(16)(h) — are **obliged entities** under AMLD5 (and forthcoming AMLR)
- [ ] The narrow AMLD5 categories (custodial wallet providers, fiat-crypto exchanges) referenced in former AMLD5 Art 2(1)(3)(g)/(h) are **superseded** — those provisions are deleted by TFR Art 38(1)

### 8.2 — CASP Correspondent Relationships (AMLD5 Art 19b, inserted by TFR Art 38(4))

If you have a cross-border correspondent relationship with a **non-Union entity** providing similar crypto-asset services (including transfers of crypto-assets):

- [ ] **(a)** Determine if the respondent entity is licensed or registered
- [ ] **(b)** Gather sufficient information about the respondent to understand the nature of its business, its publicly available reputation, and the quality of its supervision
- [ ] **(c)** Assess the respondent's AML/CFT controls
- [ ] **(d)** Obtain **senior management approval** before establishing new correspondent relationships
- [ ] **(e)** Document the respective responsibilities of each party
- [ ] **(f)** For payable-through crypto-asset accounts: be satisfied that the respondent has verified the identity of, and performed ongoing due diligence on, customers having direct access to your correspondent accounts; respondent must be able to provide that CDD data on request
- [ ] Where you **terminate** a correspondent relationship for AML/CFT reasons: **document and record** the decision
- [ ] Update correspondent-relationship CDD information **regularly and when new risks emerge**
- [ ] Apply EBA guidelines under Art 19b(3) (issued by 30 June 2024) on assessment criteria and minimum action when interacting with unregistered/unlicensed respondent entities

> **Legal advisor note — correspondent for crypto is unfamiliar territory:** Recital 60 explicitly maps Article 19b onto the banking correspondent regime. Treat unregistered/unlicensed third-country CASPs as a higher-risk correspondent category by default, with the burden of evidence on the relationship-establishing CASP to justify continuation. EBA guidelines specify minimum action — confirm the latest version with counsel.

### 8.3 — Enhanced CDD When Performing Crypto Services (AMLD5 Art 24a, inserted by TFR Art 38(5))

- [ ] You apply the EBA guidelines under AMLD5 Art 24a (issued by 1 January 2024) on **how and when enhanced CDD applies** when obliged entities perform MiCA crypto-asset services (excluding advice) or transfers of crypto-assets under TFR
- [ ] In particular: you implement the EBA guidance on **how and when** to obtain **additional information on the originator and beneficiary** in EDD scenarios

### 8.4 — Risk Variables and Risk Factors for CASPs (AMLD5 Art 18(5)–(6), inserted by TFR Art 38(3))

- [ ] Your customer / product / delivery channel / geography risk assessment for crypto activities applies the EBA guidelines under AMLD5 Art 18(5) (issued by 30 December 2024) on **risk variables and risk factors for CASPs**
- [ ] Your assessment expressly addresses products, transactions, and technologies that **facilitate anonymity** — including privacy wallets, mixers, and tumblers — and applies the EBA guidance on EDD measures for higher-risk situations, including procedures to detect origin/destination of crypto-assets (e.g. DLT analytic tools)

**Reference:** TFR Article 38; AMLD5 (Directive (EU) 2015/849) as amended — Articles 2(1)(3), 3(2)(g), 3(18)–(20), 18(5)–(6), 19a, 19b, 24a, 45(9), 47(1), 67(3); Recitals 17, 59–61

---

## SECTION 9 — SANCTIONS, INTERNAL CONTROLS, GOVERNANCE (CHAPTER VI)

---

### 9.1 — Administrative Sanctions Exposure (Articles 28–31)

- [ ] You understand that **administrative sanctions and measures** apply for breaches of TFR, mirroring AMLD5 Chapter VI Section 4 — **effective, proportionate, and dissuasive**
- [ ] Sanctions can apply to the **legal person** AND to **members of the management body** and other natural persons responsible under national law *(Art 28(2))*
- [ ] You are aware that the following are **specific-breach triggers** under Article 29:
  - [ ] **(a)** Repeated/systematic failure to accompany transfers with required payer/payee or originator/beneficiary information *(breach of Arts 4, 5, 6, 14, or 15)*
  - [ ] **(b)** Repeated/systematic/serious failure to retain records *(Art 26)*
  - [ ] **(c)** Failure to implement effective risk-based procedures *(Arts 8, 12, 17)*
  - [ ] **(d)** Serious failure by an intermediary PSP or intermediary CASP to comply with Arts 11/12 or 19/20/21 respectively

### 9.2 — Publication of Sanctions (Article 30)

- [ ] You are aware that competent authorities **publish** administrative sanctions imposed under Articles 28 and 29 without undue delay, including the type and nature of the breach and the identity of those responsible (subject to case-by-case necessity-and-proportionality assessment), per AMLD5 Article 60

### 9.3 — Internal Whistleblowing Channel (Article 32)

- [ ] You have in place — in cooperation with the competent authority — an **internal procedure** allowing employees (or persons in a comparable position) to report TFR breaches **internally** through a **secure, independent, specific, and anonymous** channel, proportionate to your nature and size
- [ ] The mechanism includes the elements required by AMLD5 Article 61(2)

### 9.4 — Monitoring by Competent Authorities (Article 33)

- [ ] You can demonstrate effective internal compliance with TFR to your competent authority on inspection
- [ ] You are aware that the Commission must report on Chapter VI application by **31 December 2026** and every three years thereafter, with particular regard to cross-border cases

**Reference:** TFR Articles 28–33, Article 29 (specific breaches), Recital 55

---

## SECTION 10 — OPERATIONAL READINESS, TECHNOLOGY, AND KEY DATES

---

### 10.1 — Travel Rule Protocol & Interoperability

- [ ] You have selected a Travel Rule protocol/provider (e.g. IVMS101-compliant Notabene, Sumsub, TRP, Sygna, OpenVASP, Shyft) that supports:
  - [ ] Counterparty CASP discovery and KYV (Know-Your-VASP)
  - [ ] Pre/concurrent transmission of Article 14(1)–(2) data
  - [ ] Encrypted, secure transmission compliant with GDPR
  - [ ] Failure handling (delayed, partial, rejected counterparties)
  - [ ] Audit trail and record retention per Article 26
- [ ] Your protocol enables the "in advance of, simultaneously, or concurrently with" transmission requirement *(Art 14(4))*
- [ ] Your block-then-broadcast logic enforces Article 14(8) ("not allow initiation, nor execute, before full compliance")
- [ ] You have an **interoperability plan** for the multi-protocol counterparty world — TFR is expressly technology-neutral (Recital 50), and there is no single dominant protocol; firms commonly support 2–3

### 10.2 — Self-Hosted Address Operational Stack

- [ ] You have selected and integrated **ownership-verification methods** for self-hosted address transfers >€1,000 (signed-message, micro-deposit, attestation, third-party reliance)
- [ ] You have selected a **chain-analytics / KYT provider** (Chainalysis, Elliptic, TRM Labs, Crystal, Merkle Science) covering at minimum: sanctions screening, mixer detection, darknet exposure, source-of-funds tracing
- [ ] You have documented the threshold at which you escalate from baseline to enhanced due diligence on self-hosted address transfers (your threshold may be lower than €1,000 — €1,000 is the floor, not the trigger)

### 10.3 — Key Application Dates and EBA Mandates

- [ ] **9 June 2023** — TFR entered into force (twentieth day after publication in OJ)
- [ ] **30 December 2024** — TFR **applies** (synchronised with MiCA Title V start of application)
- [ ] **1 January 2024** — EBA Art 24a guidelines on EDD for crypto services issued
- [ ] **30 June 2024** — EBA guidelines on Articles 14–17 and 19–22 (CASP travel rule operations) and on AMLD5 Art 19b (correspondent CASP relationships) issued
- [ ] **30 December 2024** — EBA Art 23 guidelines (restrictive measures internal controls), AMLD5 Art 18(5) guidelines (CASP risk factors), AMLD5 Art 19a guidelines (self-hosted address EDD) issued
- [ ] **30 December 2024** — AMLD5 amendments in TFR Art 38 transposed into national law (Art 38(8) inserting Art 67(3) into AMLD5)
- [ ] **1 July 2026** — Commission report on self-hosted address risks and need for additional restrictions *(Art 37(2))*
- [ ] **31 December 2026** — Commission report on Chapter VI application *(Art 33(2))*
- [ ] **30 June 2027** — Commission report on TFR application and enforcement, with possible legislative proposal *(Art 37(3))*

### 10.4 — Forthcoming AMLR/AMLD6 Migration

- [ ] You are tracking the **forthcoming Regulation on the prevention of the use of the financial system for ML/TF** (the AMLR/AMLD6/AMLA package, application date **10 July 2027**) — TFR provisions on restrictive-measures internal controls (Art 23) and certain EBA-mandate timelines are intended to migrate to or be repealed by that package
- [ ] You expect that TFR Articles 7, 8, 11, 12, 14–17, 19–22 will be **reviewed within 12 months** of entry into force of the forthcoming AMLR for consistency *(Art 37(1))*

**Reference:** TFR Article 36 (EBA guidelines mandates), Article 37 (Review clauses), Article 38(8) (AMLD5 Art 67(3) transposition), Article 40 (Entry into force and application)

---

## CLOSING — WHAT YOUR LEGAL ADVISOR WILL ASK NEXT

Once you have worked through this checklist, your legal advisor will typically scope the next phase around:

1. **The single biggest gap:** the operational architecture for transmitting Travel Rule information **before broadcast**, including how you will handle counterparties on a different protocol or no protocol at all (the "non-deliverable" Travel Rule problem).
2. **Self-hosted address policy:** the threshold (≥€1,000 is the floor) at which you will require ownership verification, the verification method, and the documented risk assessment under AMLD5 Art 19a.
3. **The GDPR–TFR collision:** your standing procedure for transfers where third-country GDPR adequacy cannot be ensured — EBA/EDPB guidance under Art 25 sets the floor.
4. **Counterparty correspondent register:** the inventory of every third-country CASP you exchange transfers with, classified by registration status and AMLD5 Art 19b assessment outcome.
5. **The forthcoming AMLR/AMLD6 migration path:** ensuring your TFR implementation is forward-compatible with the 10 July 2027 obligations, rather than a throwaway 2024 build.

> Items you could not check off in this checklist define the scope of your pre-application engagement with counsel. Items marked "subject to EBA guidance" or "subject to EDPB guidance" require active monitoring — confirm the latest version of each set of guidelines before relying on this checklist as a snapshot.

**Top-level reference:** Regulation (EU) 2023/1113 of the European Parliament and of the Council of 31 May 2023 on information accompanying transfers of funds and certain crypto-assets and amending Directive (EU) 2015/849 (recast) (OJ L 150, 9.6.2023, p. 1)
