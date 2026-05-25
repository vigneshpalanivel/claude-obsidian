# CCD2 Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide for Consumer Credit Providers, BNPL Operators, and Credit Intermediaries Targeting EU Consumers

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** Consumer Credit Directive 2 (CCD2) — Directive (EU) 2023/2225 of the European Parliament and of the Council of 18 October 2023 on credit agreements for consumers and repealing Directive 2008/48/EC
**Status:** Entered into force **19 November 2023** *(Article 49 — 20 days after OJ publication on 30 October 2023)*. Member State transposition deadline: **20 November 2025** *(Article 48(1))*. National measures apply from: **20 November 2026** *(Article 48(1))*. Directive 2008/48/EC (CCD1) is repealed with effect from **20 November 2026** *(Article 47)*.
**Document type:** Pre-supervision readiness assessment — to be completed before the first national competent authority (NCA) dialogue, before a credit-product launch in the EU, or as part of an investor / M&A due-diligence pack

**Official source:** https://eur-lex.europa.eu/eli/dir/2023/2225/oj

---

> **Who this document is for:** General counsel, heads of compliance, product leads, CTOs, and credit-risk officers at any entity that offers, intermediates, or services credit agreements to consumers (natural persons) in the EU/EEA — whether a bank, a non-bank consumer lender, a BNPL platform, a crowdfunding-credit operator, a fintech embedding credit, a credit intermediary, or a retailer financing its own goods. CCD2 captures lenders that were entirely outside CCD1 (BNPL, sub-€200 credit, free-of-interest credit, leasing with option-to-buy), so being "out of scope under CCD1" does not mean "out of scope under CCD2."

---

> **How to use this checklist:** CCD2 is a **maximum-harmonisation directive** (Art. 42(1)) but with ~17 explicit Member-State regulatory choices, so the operating model is "EU baseline + 27 national overlays." Work through Sections 1–3 first (scope, definitions, role) — they determine which of the remaining sections apply to you. CCD2 application date is **20 November 2026**. As of mid-2026, Member-State transpositions are at varying maturity; the **national transposing law** is the authoritative text for each jurisdiction, with CCD2 as the floor.

---

## SECTION 1 — DOES CCD2 APPLY TO YOU?

*CCD2 scope is materially **wider** than CCD1. The biggest scoping shifts: BNPL/deferred-payment products that were excluded under CCD1 are largely captured; sub-€200 credit and interest-free credit are in scope (with lighter-touch obligations); leasing with an option/obligation to purchase is in scope. The €100 000 upper cap is preserved (with a carve-out for residential renovation).*

---

### 1.1 — Material Scope (Article 2(1)–(3))

Tick every category that describes your activity. CCD2 applies if any one is true.

- [ ] You grant or promise to grant credit to a natural person who acts outside trade/business/profession (Art. 3(1)–(3)) — loans, deferred-payment products, "other similar financial accommodation"
- [ ] You intermediate consumer credit agreements (Art. 3(12)) — present, offer, prepare, or conclude credit on behalf of a creditor
- [ ] You offer **Buy-Now-Pay-Later (BNPL)** that does not fit the Art. 2(2)(h) exclusion (see 1.2 below) — most third-party-financed BNPL is now in scope
- [ ] You offer **leasing with an obligation or an option to purchase** the leased object (Art. 2(2)(g) excludes leases *without* such option — so option-to-buy leasing is in scope)
- [ ] You offer credit agreements for amounts **between €0 and €100 000** — including **sub-€200 micro-credit** (lighter regime under Art. 2(8) but in scope)
- [ ] You offer **free-of-interest credit** (lighter regime under Art. 2(8)(b) but in scope unless within deferred-payment carve-out)
- [ ] You offer **overdraft facilities** (Art. 3(18)) or **overrunning** (Art. 3(19)) — in scope, but Art. 2(4) limits which CCD2 provisions apply
- [ ] You offer credit for **residential immovable-property renovation** above €100 000, not secured by mortgage (Art. 2(3) explicitly pulls these in)
- [ ] You assign / purchase / service consumer credit receivables (Art. 39)

**Scope exclusions (Art. 2(2)) — confirm each carve-out if you rely on it:**

- [ ] (a) Mortgage-secured credit (covered by Mortgage Credit Directive 2014/17/EU instead)
- [ ] (b) Credit to acquire/retain property rights in land or buildings
- [ ] (c) Credit > **€100 000** (except residential renovation per Art. 2(3))
- [ ] (d) Employer credit to employees at below-market or zero rates, not offered to public
- [ ] (e) Investment-firm / credit-institution credit to consumers for MiFID-instrument transactions where the institution is involved in the transaction
- [ ] (f) Credit arising from court / statutory-authority settlements
- [ ] (g) Hiring/leasing **without** option or obligation to purchase
- [ ] (h) **Deferred-payment carve-out** — applies ONLY where: (i) no third party offering credit, (ii) interest-free with only limited late-payment charges, (iii) payment within **50 days** of delivery — and for **information-society service providers that are not SMEs** (i.e. large online platforms), the deferred-payment window collapses to **14 days**
- [ ] (i) Free-of-charge deferred payment of existing debt
- [ ] (j) Pawnbroking-style credit with consumer-deposited security
- [ ] (k) Restricted-public statutory below-market credit
- [ ] (l) **Credit agreements existing on 20 November 2026** — grandfathered, but Arts. 23, 24, 25(1)2nd sentence, 25(2), 28 and 39 still apply to open-end agreements

> **Legal advisor note:** The single most under-estimated CCD2 expansion is **BNPL**. CCD1's deferred-payment carve-out (Art. 2(2)(f) of CCD1) was wide enough that most BNPL operators classified themselves out of scope. CCD2's Art. 2(2)(h) closes that gap: third-party-financed BNPL is captured outright, and even merchant-financed BNPL only escapes if the platform is an SME *or* if the payment window is ≤14 days when offered by a large online platform. Klarna-, Klarna-like-, and platform-embedded BNPL operating in the EU/EEA must assume in-scope status from 20 November 2026 unless the legal opinion is rock-solid the deferred-payment exception applies.

**Reference:** CCD2 Articles 1, 2; Article 3 definitions; Recitals 2–18; Mortgage Credit Directive 2014/17/EU (for the boundary with mortgage credit)

---

### 1.2 — Lighter-Regime Sub-Scopes (Articles 2(4)–(8))

Even where CCD2 applies, only a subset of articles may apply depending on the product type. Map your product to one of these regimes:

- [ ] **Full CCD2** — default
- [ ] **Overrunning (Art. 2(4))** — only Arts. 1, 2, 3, 17, 19, 25, 31, 35, 36, 39–50 + Art. 18 (unless Member State opts out) apply
- [ ] **Deferred-debit cards (Art. 2(5), Member State option)** — may be exempted if provided by credit/payment institution, ≤40-day repayment, interest-free with limited charges
- [ ] **Mutual-benefit / common-bond credit organisations (Art. 2(6), Member State option)** — limited article set applies
- [ ] **Forbearance restructuring of existing default (Art. 2(7), Member State option)** — limited article set applies
- [ ] **Sub-€200 / free-of-interest / ≤3-month-insignificant-charge credit (Art. 2(8), Member State option)** — Arts. 8(3)(d)–(f), 10(5), 11(4), 21(3) may be disapplied at Member State discretion

> **Legal advisor note:** Confirm the **specific Member-State transposition** for each lighter regime before relying on it. Member State A may apply the Art. 2(8) lighter regime to sub-€200 credit; Member State B may not. Operating cross-border under "the lightest of any Member State" is not legally defensible — the consumer's residence state governs.

**Reference:** CCD2 Article 2(4)–(8); Article 42(2) Member State notification regime

---

### 1.3 — Territorial Scope and Cross-Border Operation

- [ ] Identify each Member State where you offer credit to consumers (offer, conclude, service, or intermediate)
- [ ] For each Member State, identify the **transposed national law** (CCD2 is a directive — the national act, not CCD2 itself, is operative)
- [ ] Map cross-border database access rights (Art. 19(1) — non-discriminatory access to creditworthiness databases of any Member State where you lend cross-border)
- [ ] Confirm whether national law of **consumer's residence** or **creditor's establishment** governs (consumer-protection law conflict-of-laws rules under Rome I Art. 6 generally favour consumer's habitual residence)

> **Legal advisor note:** CCD2 has no harmonised passport for non-credit-institution creditors equivalent to MiFID II / CRD VI. Each Member State runs its own Art. 37 admission/registration regime. Operating in 27 Member States means 27 supervisory relationships (subject to Member-State carve-outs for credit / payment / e-money institutions in Art. 37(2) which leverage their existing CRD / PSD2 / EMD2 passports).

**Reference:** CCD2 Articles 19, 37, 41; Rome I Regulation (EC) 593/2008 Article 6

---

## SECTION 2 — ROLE CLASSIFICATION (Article 3)

*CCD2 imposes distinct obligations on **creditors** (the principal regulated entity), **credit intermediaries** (a separate regulated category with its own conduct rules in Art. 38), and indirectly on **debt advisory service providers** (Art. 3(22), Art. 36). Get the classification wrong and you'll be reading the wrong article set.*

---

### 2.1 — Self-Classification

For each product / activity, identify the role:

- [ ] **Creditor (Art. 3(2))** — natural / legal person granting or promising to grant credit in the course of trade, business, profession
- [ ] **Credit intermediary (Art. 3(12))** — not creditor, not notary, not a mere introducer; for remuneration: presents/offers credit, assists with preparation, or concludes on behalf of creditor
- [ ] **Credit intermediary in an ancillary capacity (Art. 37(3))** — supplier/provider acting incidentally as intermediary; Member States may exempt SMEs from admission/registration
- [ ] **Crowdfunding-credit operator** — covered under general "creditor" definition where you grant credit to consumers (cross-check with ECSPR Regulation (EU) 2020/1503 for the crowdfunding-services authorisation layer)
- [ ] **Debt advisory services provider (Art. 3(22))** — independent professional, NOT a creditor / credit intermediary / credit purchaser / credit servicer, providing technical / legal / psychological assistance to consumers in financial difficulty
- [ ] **Credit purchaser / credit servicer (Directive (EU) 2021/2167)** — out of CCD2's "creditor" definition but engaged via Art. 39 assignment-of-rights regime

> **Legal advisor note:** A retailer offering its own zero-interest 30-day "pay-later" with no third-party financing is potentially neither creditor nor intermediary under Art. 2(2)(h) — but this exception is narrow. The moment a third party (acquirer, embedded-finance partner, BNPL platform) sits behind the scenes, the retailer becomes a credit intermediary *and* the financing party becomes a creditor. Embedded-finance stacks frequently have 3–4 entities in the chain — each must self-classify independently.

**Reference:** CCD2 Article 3(2), 3(12), 3(22), 37(3); ECSPR Regulation (EU) 2020/1503; NPL Directive (EU) 2021/2167

---

## SECTION 3 — ADVERTISING AND MARKETING (Articles 7, 8)

*CCD2 imposes prescriptive advertising rules far stricter than the general Unfair Commercial Practices Directive baseline. The Art. 8(1) "Caution! Borrowing money costs money" warning is mandatory; the Art. 8(7) absolute prohibitions and Art. 8(8) Member-State optional prohibitions reshape marketing playbooks. Standard advertising templates from non-EU markets will not pass review.*

---

### 3.1 — Fair, Clear, Not Misleading (Article 7)

- [ ] All advertising and marketing communications are fair, clear, not misleading (Art. 7)
- [ ] Wording that may create false expectations regarding availability, cost, or total amount payable is removed
- [ ] Alignment with Directive 2005/29/EC (Unfair Commercial Practices) maintained as a floor

### 3.2 — Mandatory Warning + Standard Information (Article 8(1)–(6))

- [ ] **"Caution! Borrowing money costs money"** (or equivalent national wording) included in **all** advertising concerning credit agreements (Art. 8(1)) — clear and prominent
- [ ] Where advertising indicates an interest rate or any figure relating to the cost of credit, **Standard Information** included in clear, concise, prominent form (Art. 8(3)):
  - [ ] Borrowing rate (fixed/variable/both) + particulars of any charges included in total cost
  - [ ] Total amount of credit
  - [ ] Annual Percentage Rate of Charge (APR)
  - [ ] Duration of credit agreement (where applicable)
  - [ ] Cash price and any advance payment (for deferred-payment credit for specific goods/services)
  - [ ] Total amount payable + amount of instalments (where applicable)
- [ ] Standard information specified by a **representative example** (Art. 8(4))
- [ ] Compulsory ancillary-service cost disclosed where unquantifiable (Art. 8(5))
- [ ] On electronic media that cannot display all info prominently, total-amount-payable and instalments accessible via click/scroll/swipe (Art. 8(6))

### 3.3 — Absolute Advertising Prohibitions (Article 8(7))

Member States shall prohibit advertising that:

- [ ] Encourages consumers to seek credit by suggesting it would improve their financial situation
- [ ] Specifies that outstanding credit agreements or registered credit in databases have little or no influence on creditworthiness assessment
- [ ] Falsely suggests credit increases financial resources, substitutes for savings, or raises living standards

### 3.4 — Optional Advertising Prohibitions (Article 8(8), Member State option)

Member States *may* prohibit:

- [ ] Advertising that highlights ease or speed of obtaining credit
- [ ] Advertising that conditions a discount on taking up credit
- [ ] Advertising that offers grace periods of more than three months

> **Legal advisor note:** The "ease/speed" prohibition (Art. 8(8)(a)) directly targets digital-onboarding marketing — "Get credit in 60 seconds," "Instant approval," "Apply in one click." Several Member States are expected to opt in. Audit your paid-acquisition copy, landing pages, app-store listings, and influencer briefs against this list per-Member-State; do not assume a single creative pack works across the EU.

**Reference:** CCD2 Articles 7, 8; UCPD Directive 2005/29/EC

---

## SECTION 4 — PRE-CONTRACTUAL DISCLOSURE (Articles 9–13)

*CCD2 mandates the **Standard European Consumer Credit Information** (SECCI) form set out in Annex I, with a prescriptive one-page (max two-page) layout. The Art. 10 obligations are detailed and audit-friendly — regulators will compare your SECCI against the template element by element.*

---

### 4.1 — General Information Always Available (Article 9)

- [ ] Clear, comprehensible general information about credit agreements available to consumers at all times on paper or other durable medium chosen by the consumer
- [ ] Where information is made available at creditor / intermediary premises, paper available
- [ ] Content includes: issuer identity + contact, credit purposes, possible durations, types of borrowing rate with fixed/variable characteristics, representative example, possible further costs, repayment options, early-repayment conditions, withdrawal right description, mandatory ancillary services, general warning on consequences of non-compliance (Art. 9(2)(a)–(k))

### 4.2 — Standard European Consumer Credit Information (Article 10)

- [ ] Pre-contractual information provided **in good time before** the consumer is bound (Art. 10(1))
- [ ] **Late-disclosure reminder regime** — if SECCI given less than one day before the consumer is bound, creditor must send a reminder of the withdrawal right between 1 and 7 days after conclusion (Art. 10(1) second subparagraph)
- [ ] SECCI provided on paper or other durable medium chosen by the consumer (Art. 10(2)) — Annex I form used
- [ ] **One-page first part** with mandatory elements (Art. 10(3)(a)–(l)): creditor identity, total amount of credit, duration, borrowing rate, APR + total amount payable, cash price for deferred-payment, late-payment costs, instalment schedule, missed-payment warning, withdrawal right + period, early-repayment right + compensation, geographical address + contact details
- [ ] Two-page fallback if all elements cannot fit on one page; (a)–(g) must remain on the first page (Art. 10(4))
- [ ] **Second part** (Art. 10(5)(a)–(q)) — type of credit, drawdown conditions, variable-rate conditions, drawdown-mechanism APR caveats, account-maintenance charges, representative example, notary costs, mandatory ancillary services, sureties, early-repayment compensation method, database-consultation right, right to draft-agreement copy, **automated-pricing personalisation indication**, validity period of pre-contractual info, ADR mechanism, missing-payment legal/financial consequences, full repayment schedule
- [ ] Display adequate, suitable across channels with interoperability considered (Art. 10(6))
- [ ] Voice-telephony fallback: minimum Art. 10(3) elements; SECCI on durable medium immediately after conclusion (Art. 10(7))
- [ ] On request, free copy of draft credit agreement provided (Art. 10(8))
- [ ] Specific warning where capital-constituting structure (no immediate amortisation) — no guarantee of repayment unless given expressly (Art. 10(9))

### 4.3 — Pre-Contractual Information for Overdraft / Specific Products (Article 11)

- [ ] Pre-contractual information regime for credit agreements under Art. 2(6) or 2(7) followed where applicable

### 4.4 — Adequate Explanations (Article 12)

- [ ] Free, pre-conclusion adequate explanations provided on the proposed credit agreement and ancillary services
- [ ] Explanations cover: SECCI / Art. 11 / Art. 38 info; essential characteristics; specific effects on the consumer including default consequences; separability of bundled ancillary services
- [ ] Explanation scope adapted to product type / consumer / context where Member State has used the Art. 12(2) derogation

### 4.5 — Personalised Pricing Disclosure (Article 13)

- [ ] Consumers informed clearly and comprehensibly when a personalised offer is based on **automated processing of personal data**
- [ ] Disclosure dovetails with GDPR Art. 13 / 14 transparency, Art. 22 automated-decision rules, and AI Act deployer-transparency obligations

> **Legal advisor note:** Article 13 is one of two **direct CCD2 ↔ GDPR ↔ AI Act intersection points** (the other is Art. 18(8)). For any creditor using ML-driven pricing, underwriting, or offer personalisation, Art. 13 disclosure is mandatory **at offer presentation**, not merely in the privacy notice. Best-in-class implementations surface a contextual "This offer was personalised using your data" message at the point of decision, not buried in T&Cs.

**Reference:** CCD2 Articles 9, 10, 11, 12, 13; Annex I (SECCI form); GDPR Articles 13, 14, 22; AI Act Article 26

---

## SECTION 5 — TYING, BUNDLING, ADVISORY, UNSOLICITED CREDIT (Articles 14–17)

---

### 5.1 — Tying and Bundling (Article 14)

- [ ] **Tying prohibited** — selling credit only in a package with other distinct financial products/services (Art. 14(1))
- [ ] Bundling allowed — but consumer must be able to obtain the credit separately (different terms acceptable)
- [ ] Permitted account-tying narrow exceptions (Art. 14(2)) — accumulate capital / service credit / pool resources / additional security (Member State option)
- [ ] Insurance-policy bundling: must accept equivalent-guarantee policy from supplier other than creditor's preferred (Art. 14(3))
- [ ] **Oncological-disease "right to be forgotten"** — consumers' cancer-diagnosis data not used for credit-related insurance after Member-State-determined period (max 15 years post-treatment) (Art. 14(4))
- [ ] **3-day insurance-offer comparison window** — consumers given ≥3 days to compare credit-related insurance offers without offer changes (Art. 14(5))

### 5.2 — Inferred Consent / Default Options Prohibited (Article 15)

- [ ] No agreement inferred via default options or pre-ticked boxes (Art. 15(1))
- [ ] Affirmative, freely given, specific, informed, unambiguous consent required (Art. 15(2))

### 5.3 — Advisory Services Regime (Article 16)

- [ ] Consumer explicitly informed whether advisory services are or can be provided
- [ ] Pre-advice disclosure: scope (own range vs market-wide), fee or fee-calculation method (Art. 16(2))
- [ ] Where advice provided: gather consumer info on financial situation, preferences, objectives; assess based on up-to-date info with reasonable risk assumptions; consider sufficiently large product range; act in consumer's best interest; record recommendation on durable medium (Art. 16(3))
- [ ] **"Advice" / "advisor" terminology controls** (Art. 16(4), Member State option) — Member States may prohibit, or impose "independent advice" conditions (sufficiently large market sample + no creditor remuneration where less than majority of market considered)
- [ ] Warning consumers where the credit agreement may induce a specific risk given their financial situation (Art. 16(5))
- [ ] Advisory services restricted to creditors / intermediaries unless Member State opts in for incidental/insolvency/public-debt-advice providers (Art. 16(6))

### 5.4 — Ban on Unsolicited Credit (Article 17)

- [ ] **No granting of credit without prior consumer request and explicit agreement** (Art. 17)
- [ ] Pre-approved credit-limit increases, automatic overdraft conversions, and "your card has been upgraded with a credit line" offers reviewed against this prohibition

> **Legal advisor note:** Art. 17 is the most overlooked structural ban. Many fintech and neobank growth playbooks rely on "pre-approved credit offers" and "auto-upgrade your account with a credit facility" flows that pre-date CCD2. From 20 November 2026, these are prohibited unless the consumer has explicitly requested and explicitly agreed. The line between a *marketing offer* (allowed) and *granting credit* (prohibited without prior request) is fact-specific — get it wrong and the entire growth funnel breaks.

**Reference:** CCD2 Articles 14, 15, 16, 17

---

## SECTION 6 — CREDITWORTHINESS ASSESSMENT AND DATABASES (Articles 18, 19)

*Article 18 is the single most operationally demanding CCD2 article. It mandates a thorough assessment, restricts data sources (no special-category data, no social-network data), grants consumers a right to human intervention in automated assessments, and prevents creditors from cancelling agreements later on the grounds of incorrect assessment. Article 19 governs cross-border database access.*

---

### 6.1 — Mandatory Creditworthiness Assessment (Article 18(1)–(7))

- [ ] **Thorough assessment** carried out before concluding the credit agreement, in the consumer's interest, to prevent irresponsible lending and over-indebtedness (Art. 18(1))
- [ ] Credit intermediaries accurately submit consumer-provided info to creditor in compliance with GDPR (Art. 18(2))
- [ ] Assessment based on **relevant and accurate** info on consumer's income, expenses, financial/economic circumstances — necessary and proportionate (Art. 18(3))
- [ ] **No special-category data** (GDPR Art. 9) used (Art. 18(3))
- [ ] **No social-network data** as an external source (Art. 18(3))
- [ ] Info appropriately verified, where necessary through independently verifiable documentation (Art. 18(3))
- [ ] Assessment procedure documented and maintained (Art. 18(4))
- [ ] Joint applications: assessment based on joint repayment capacity (Art. 18(5))
- [ ] **Credit granted only where assessment indicates obligations are likely to be met** (Art. 18(6))
- [ ] Creditor cannot subsequently cancel/modify agreement to consumer's detriment on grounds of incorrect assessment (Art. 18(7)) — unless consumer knowingly withheld or falsified info

### 6.2 — Right to Human Intervention in Automated Creditworthiness (Article 18(8)–(9))

Where the assessment uses **automated processing of personal data**:

- [ ] Consumer has the right to request and obtain **human intervention** from the creditor (Art. 18(8))
- [ ] Right includes:
  - [ ] Clear and comprehensible explanation of the assessment, including logic, risks, significance, and effects of automated processing
  - [ ] Right to express the consumer's own point of view to the creditor
  - [ ] Right to request a review of the assessment and the granting decision
- [ ] Consumer informed of this right
- [ ] Where credit application rejected: creditor informs consumer without delay of rejection and refers to debt advisory services where relevant (Art. 18(9))
- [ ] Where rejection based on automated processing: consumer informed of automated basis, right to human assessment, and contest procedure

### 6.3 — Re-Assessment on Significant Credit-Limit Increase (Article 18(10))

- [ ] Creditworthiness reassessed on updated information before any significant increase in total amount of credit (Art. 18(10))

### 6.4 — Database Consultation (Article 18(11) + Article 19)

- [ ] Member-State requirement (optional under Art. 18(11)) to consult relevant database followed where applicable — but assessment **not** based exclusively on credit history
- [ ] Cross-border non-discriminatory database access ensured where lending cross-border (Art. 19(1)–(3))
- [ ] Database minimum content: arrears in repayment, type of credit, identity of creditor (Art. 19(4))
- [ ] **No special-category data and no social-network data processed** from databases (Art. 19(5))
- [ ] Where rejection based on database consultation: consumer informed without undue delay and free of charge of result, database details, and categories of data used (Art. 19(6))
- [ ] Database providers ensure info up-to-date and accurate; consumers informed within 30 days of arrears registration and of GDPR rights (Art. 19(7))
- [ ] Complaint procedures in place for consumers to challenge database content (Art. 19(8))

> **Legal advisor note:** Art. 18(8) is a **direct strengthening of GDPR Art. 22**. Under GDPR Art. 22, the right to human intervention is qualified (only where the decision produces legal or similarly significant effects and only outside narrow contract / consent / law exceptions). Under CCD2 Art. 18(8), the right is **unconditional** wherever the creditworthiness assessment uses automated processing — there is no necessity or consent gateway. ML-driven underwriting stacks built on the GDPR Art. 22 exception (contract necessity for credit decisions) lose that defence under CCD2. Plan for a per-application human-review pipeline with documented logic explanations.

> **Legal advisor note:** The social-network-data ban (Art. 18(3), Art. 19(5)) explicitly targets the "alt-data" underwriting models popular with thin-file/no-file lenders pre-2023. Models trained on or inferring from social-graph signals must be retrained / replaced before 20 November 2026.

**Reference:** CCD2 Articles 18, 19; GDPR Articles 9, 22; AI Act Article 27 (FRIA)

---

## SECTION 7 — CREDIT AGREEMENT FORM AND CONTENT (Articles 20–25)

---

### 7.1 — Form (Article 20)

- [ ] Credit agreement and modifications drawn up on paper or other durable medium
- [ ] Copy provided to all contracting parties

### 7.2 — Mandatory Agreement Contents (Article 21)

The credit agreement must specify clearly and concisely:

- [ ] Type of credit (Art. 21(1)(a))
- [ ] Identities + geographical addresses + telephone + email of contracting parties and credit intermediary (Art. 21(1)(b))
- [ ] Total amount of credit + drawdown conditions (Art. 21(1)(c))
- [ ] Duration of agreement (Art. 21(1)(d))
- [ ] For deferred-payment / linked credit: specific goods/services and cash price (Art. 21(1)(e))
- [ ] Borrowing rate(s) and conditions for each (Art. 21(1)(f))
- [ ] APR + total amount payable (Art. 21(1)(g)–(h))
- [ ] Amount, number, frequency of payments and allocation order (Art. 21(1)(i))
- [ ] Where amortising: amortisation table showing capital amortised, interest, additional costs, balances after each payment (Art. 21(1)(j))
- [ ] Charges for account maintenance, payment-means use, and other agreement-derived charges with change conditions (Art. 21(1)(k))
- [ ] Late-payment interest rate, adjustment mechanism, default charges (Art. 21(1)(l))
- [ ] **Missed-payment warning** regarding consequences (Art. 21(1)(m))
- [ ] Sureties and insurance required (Art. 21(1)(n)–(o))
- [ ] **Existence or absence of withdrawal right, period, conditions, notification address, interest payable per Art. 26(5)(b)** (Art. 21(1)(p))
- [ ] Linked-credit rights under Art. 27 where applicable (Art. 21(1)(q))
- [ ] Early-repayment right and compensation calculation method (Art. 21(1)(r))
- [ ] Termination procedure for open-end agreements (Art. 21(1)(s))
- [ ] ADR availability and access methods (Art. 21(1)(t))
- [ ] Other contractual T&Cs (Art. 21(1)(u))
- [ ] Competent supervisory authority contact (Art. 21(1)(v))

### 7.3 — Information Regarding Modifications (Article 22)

- [ ] Modifications of credit agreement communicated on paper or durable medium with applicable information per Art. 22

### 7.4 — Changes in the Borrowing Rate (Article 23)

- [ ] Consumer informed of borrowing-rate changes on paper or other durable medium before they take effect — with new instalment information

### 7.5 — Overdrafts and Overrunning (Articles 24, 25)

- [ ] Overdraft-facility specific information regime followed (Art. 24)
- [ ] Overrunning-specific information regime (Art. 25) — consumer warned where overrunning is sustained beyond 1 month (Art. 25(2))

**Reference:** CCD2 Articles 20–25

---

## SECTION 8 — WITHDRAWAL, LINKED CREDIT, OPEN-END, EARLY REPAYMENT (Articles 26–29)

---

### 8.1 — Right of Withdrawal (Article 26)

- [ ] **14 calendar days** withdrawal right without giving any reason (Art. 26(1))
- [ ] Period starts from: (a) conclusion of agreement; or (b) day consumer receives T&Cs + Art. 20/21 info — whichever later
- [ ] If consumer never received T&Cs and Art. 20/21 info: withdrawal period extends to **12 months and 14 days** after conclusion (Art. 26(2))
- [ ] Linked-credit + extended-return-policy: withdrawal right extended to match return-policy duration (Art. 26(3))
- [ ] On withdrawal: consumer notifies creditor on paper / durable medium; pays capital + interest within **30 days** (Art. 26(5))
- [ ] Creditor entitled only to interest at agreed rate + compensation for non-refundable charges paid to public administrative body — no other compensation (Art. 26(5))
- [ ] Ancillary-service contract terminates automatically on withdrawal (Art. 26(6))

### 8.2 — Linked Credit Agreements (Article 27)

- [ ] Where consumer exercises EU-law-based withdrawal from goods/services contract: linked credit agreement no longer binds
- [ ] Where goods/services not supplied or not in conformity: consumer's remedies against creditor (Member-State-determined scope)

### 8.3 — Open-End Credit Agreement Termination (Article 28)

- [ ] Consumer may terminate open-end credit free of charge at any time, with notice not exceeding 1 month
- [ ] Creditor termination right (where agreed): ≥2 months' notice on durable medium
- [ ] Creditor may, on objectively justified reasons, terminate drawdown right with reasons disclosed on durable medium

### 8.4 — Early Repayment (Article 29)

- [ ] Consumer entitled at any time to early repayment, with proportionate reduction in total cost (Art. 29(1))
- [ ] Creditor entitled to **fair, objectively justified compensation** for costs directly linked to early repayment — only where fixed-rate period
- [ ] **Compensation cap:** 1% of early-repaid amount if >1 year to agreed termination; 0.5% if ≤1 year (Art. 29(2))
- [ ] No compensation where: insurance-contract-driven repayment; overdraft facility; variable-rate period (Art. 29(3))
- [ ] Member State option: compensation only if early repayment exceeds threshold ≤€10 000 within 12-month period; or creditor may claim higher compensation on proof of actual loss (Art. 29(4))
- [ ] Compensation in any case capped at interest consumer would have paid over remaining period (Art. 29(5))

**Reference:** CCD2 Articles 26, 27, 28, 29

---

## SECTION 9 — APR AND RATE CAPS (Articles 30, 31)

---

### 9.1 — APR Calculation (Article 30 + Annex III)

- [ ] APR calculated per the mathematical formula in Annex III, Part I
- [ ] Total cost of credit determined excluding non-compliance charges and cash-equivalent purchase charges
- [ ] Compulsory-account charges included unless account is optional and charges separately identified
- [ ] Variable-rate assumption: rates and charges deemed to remain fixed at initial level until end of agreement
- [ ] Additional Annex III Part II assumptions used where necessary

### 9.2 — Caps on Rates / APR / Total Cost (Article 31)

- [ ] Member-State-introduced measures (caps or other) to prevent abusively high borrowing rates, APRs, or total costs identified for each Member State of operation
- [ ] Member State possible prohibitions on specific charges/fees mapped (Art. 31(2))
- [ ] **20 November 2026** — Member States reported their measures to Commission; cross-check published Commission list (Art. 31(3))
- [ ] **20 November 2029** — EBA report on implementation expected (Art. 31(4))

> **Legal advisor note:** CCD2 mandates that Member States introduce *some* anti-abuse rate-cap measure but leaves the methodology entirely to national law. The result is 27 different cap regimes — Germany retains a "doppelter Marktzins" (twice-the-market-rate) judicial standard, France uses statutory *taux d'usure* by product class, Italy uses a quarterly published cap, Netherlands has a hard 14% APR cap on consumer credit. There is no EU ceiling. Map per Member State before pricing a pan-EU product.

**Reference:** CCD2 Articles 30, 31; Annex III

---

## SECTION 10 — CONDUCT OF BUSINESS AND STAFF COMPETENCE (Articles 32, 33)

---

### 10.1 — Conduct of Business (Article 32)

- [ ] Creditor and credit intermediary act **honestly, fairly, transparently, professionally** taking account of consumer rights and interests
- [ ] Applied across: design/manufacture, marketing, granting, intermediation, advisory, sale of credit products
- [ ] Remuneration policies of staff and intermediaries do not create incentives that conflict with the duty to act in consumers' interest (Art. 32(2)–(3))
- [ ] Where relevant, manufacturing of credit products complies with Member-State-imposed product-governance rules (Art. 32(4)–(5), Member State option)

### 10.2 — Staff Knowledge and Competence (Article 33)

- [ ] Creditor and credit intermediary staff possess and keep up-to-date appropriate knowledge and competence in: manufacturing, offering, granting credit; intermediation; advisory; consumer rights; ancillary services
- [ ] Minimum knowledge/competence requirements per Member State law identified and met
- [ ] Compliance supervised by competent authority; evidence-on-demand available

> **Legal advisor note:** Art. 33 is operationally similar to MiFID II ESMA Guidelines on knowledge & competence for investment-firm staff. Expect Member-State implementing measures to require formal certification (CRC-equivalent qualifications, ongoing CPD hours, annual attestations). Build training, testing, and recordkeeping into HR / RegTech systems before 20 November 2026.

**Reference:** CCD2 Articles 32, 33; MiFID II ESMA Guidelines on knowledge and competence (analogous)

---

## SECTION 11 — FINANCIAL EDUCATION, ARREARS, FORBEARANCE, DEBT ADVISORY (Articles 34, 35, 36)

---

### 11.1 — Financial Education Support (Article 34)

- [ ] Member-State financial-education measures supported / not undermined by creditor's marketing
- [ ] First-time-borrower guidance available (especially via digital tools)

### 11.2 — Arrears and Forbearance (Article 35)

- [ ] **Reasonable forbearance** exercised before enforcement proceedings initiated, taking into account consumer's individual circumstances (Art. 35(1))
- [ ] Forbearance not required reiteratively unless justified
- [ ] No new creditworthiness assessment needed for forbearance-driven modifications where total payable not significantly increased
- [ ] Forbearance toolkit available (any of): total/partial refinancing, term extension, credit-type change, payment deferral, rate reduction, payment holiday, partial repayments, currency conversion, partial forgiveness, debt consolidation
- [ ] Default-charges proportionality: charges no greater than necessary to compensate for cost of default (Member State option, Art. 35(3))
- [ ] Cap on additional default charges (Member State option, Art. 35(4))
- [ ] Documented forbearance policy, decision logs, consumer-impact-analysis records maintained

### 11.3 — Debt Advisory Services (Article 36)

- [ ] **Independent debt advisory services** available to consumers in financial difficulty, with only limited charges (Member State to ensure)
- [ ] Creditor has **processes for early detection** of consumers experiencing financial difficulties (Art. 36(2))
- [ ] Creditor refers consumers in difficulty to easily accessible debt advisory services (Art. 36(3))
- [ ] **20 November 2026** — first annual Member-State report to Commission on available debt advisory services

> **Legal advisor note:** Article 35 forbearance language is materially identical to NPL-Directive 2021/2167 forbearance expectations. If you already operate under NPL-Directive forbearance policies, CCD2 Art. 35 likely adds nothing operational — but the documentation must be CCD2-specific (a single forbearance policy may serve both regimes, but the audit trail must show CCD2 reasoning). Article 36(2) "early detection" is the new structural requirement — typically implemented as a behavioural-signal monitoring layer over payment data (missed payments, partial payments, minimum-only payments, multi-creditor cross-defaults via database signals).

**Reference:** CCD2 Articles 34, 35, 36; NPL Directive (EU) 2021/2167 Article 28

---

## SECTION 12 — ADMISSION, REGISTRATION, SUPERVISION, INTERMEDIARIES (Articles 37, 38)

---

### 12.1 — Admission and Registration (Article 37)

- [ ] Creditors and credit intermediaries subject to **adequate admission process + registration + supervision** by independent competent authority (Art. 37(1))
- [ ] Exemption check: are you a credit institution (CRR Art. 4(1)(1)), payment institution (PSD2 Art. 4(4)) for the credit-granting service under Annex I point 4, or e-money institution granting credit under EMD2 Art. 6(1)(b)? If yes, Art. 37(2) exempts from CCD2-specific admission/registration (but supervision continues under existing licence)
- [ ] SME-supplier-acting-as-intermediary or as ancillary-capacity zero-interest-deferred-payment creditor: Member-State exemption (Art. 37(3)) checked
- [ ] National registration application files: ownership and management fitness; financial soundness; conduct-of-business policy; AML/KYC controls; consumer-protection governance; data-protection compliance evidence (per Member-State requirements transposing Art. 37)

### 12.2 — Specific Obligations for Credit Intermediaries (Article 38)

Credit intermediaries shall:

- [ ] **Disclose extent of powers** and whether working exclusively for ≥1 creditor or as independent intermediary (in advertising and consumer documentation)
- [ ] **Disclose fees** payable by consumer for services to be provided
- [ ] **Reach written fee agreement** with consumer on paper / durable medium before credit-agreement conclusion
- [ ] **Communicate fees to the creditor** for APR-calculation purposes (Art. 38(d))

> **Legal advisor note:** Article 37 is **not** a harmonised EU passport. Each Member State licenses independently. A non-bank lender operating in 5 Member States needs 5 admissions (subject to mutual-recognition and Art. 37(2) exemptions for already-passported institutions). This is a deliberate political compromise — CRD VI passports were not extended to consumer-credit-only non-banks. For a pan-EU non-bank consumer-credit play, factor this into go-to-market sequencing and budget.

**Reference:** CCD2 Articles 37, 38; CRR Regulation (EU) 575/2013 Art. 4(1)(1); PSD2 Directive (EU) 2015/2366; EMD2 Directive 2009/110/EC

---

## SECTION 13 — ASSIGNMENT, ADR, COMPETENT AUTHORITIES (Articles 39, 40, 41)

---

### 13.1 — Assignment of Rights (Article 39)

- [ ] On assignment of creditor's rights to a third party, consumer retains all defences (including set-off where Member State permits) available against original creditor
- [ ] Consumer informed of the assignment by the original creditor, except where original creditor continues to service the credit

### 13.2 — Out-of-Court Dispute Resolution (Article 40)

- [ ] Consumers have access to ADR procedures complying with Directive 2013/11/EU
- [ ] Cross-border ADR cooperation supported

### 13.3 — Competent Authorities (Article 41)

- [ ] Lead competent authority identified for each Member State of operation
- [ ] Authority's investigating and enforcement powers understood; cooperation with EBA-authorised competent authorities under Reg (EU) 1093/2010 in place
- [ ] **20 November 2025 deadline (passed)** — Member States notified competent authorities to Commission; check Commission's published list
- [ ] Recognition of potential **product-intervention powers** (Art. 41(9), Member State option) — competent authorities may withdraw credit products in justified cases

**Reference:** CCD2 Articles 39, 40, 41; ADR Directive 2013/11/EU; EBA Regulation (EU) 1093/2010

---

## SECTION 14 — HARMONISATION, IMPERATIVE NATURE, PENALTIES (Articles 42, 43, 44)

---

### 14.1 — Maximum Harmonisation + Member-State Options (Articles 42)

- [ ] CCD2 is a **maximum-harmonisation** directive — Member States cannot diverge except where CCD2 expressly allows (Art. 42(1))
- [ ] Map all **17 Member-State regulatory choices** that may diverge: Arts. 2(5), 2(6), 2(7), 2(8), 8(8), 14(2), 14(3), 16(4), 16(6), 18(11), 24(5), 25(6), 26(4), 26(8), 29(4), 31(2), 32(4), 32(5), 35(3), 35(4), 37(3), 41(9) — published on Commission website (Art. 42(2))

### 14.2 — Imperative Nature (Article 43)

- [ ] Consumers cannot waive CCD2 rights as transposed by national law (Art. 43(1))
- [ ] Drafting must not circumvent transposing provisions (Art. 43(2)) — review T&Cs against CCD2 minimums

### 14.3 — Penalties (Article 44)

- [ ] Penalty regime understood for each Member State of operation — penalties are **set by Member State** (no EU ceiling, unlike GDPR / MiCA / DORA)
- [ ] Penalties must be **effective, proportionate, dissuasive** (Art. 44(1))
- [ ] **20 November 2026 deadline** — Member States notify Commission of penalty rules
- [ ] Administrative fines and/or legal proceedings available per Reg (EU) 2017/2394 cross-border consumer-protection cooperation regime (Art. 44(2))
- [ ] Public disclosure of administrative penalties possible (Art. 44(3))

> **Legal advisor note:** CCD2's penalty regime is the **inverse of MiCA / DORA / GDPR** — no harmonised ceiling, all Member-State-set. Expect wide divergence: France's DGCCRF has historically applied fines up to a few hundred thousand euros for CCD1 breaches; Italy's AGCM and Bank of Italy can stack penalties into the millions; Germany applies criminal sanctions via the Strafgesetzbuch §§ 264a–266 framework in egregious cases. Pan-EU operators should budget for the *worst-case* Member State, not the average. Reputational sanctions (Art. 44(3) public disclosure) are likely the more consequential lever for non-bank brand-led lenders.

**Reference:** CCD2 Articles 42, 43, 44; Regulation (EU) 2017/2394 on consumer-protection cooperation

---

## SECTION 15 — CROSS-REGIME INTERACTION

*CCD2 sits on top of, and intersects with, multiple EU regimes. The most common operational error is treating CCD2 in isolation; the most common architectural error is failing to design data and consent flows that satisfy all overlapping regimes simultaneously.*

---

### 15.1 — CCD2 ↔ GDPR

- [ ] **Art. 13 personalised-offer disclosure** integrated with GDPR Art. 13/14 privacy notices and AI Act transparency obligations
- [ ] **Art. 18(3) special-category data ban** consistent with GDPR Art. 9 — but stricter (CCD2 forbids in creditworthiness even where GDPR Art. 9(2) condition exists)
- [ ] **Art. 18(3) social-network-data ban** — model training and inference pipelines audited; remove social-graph features
- [ ] **Art. 18(8) right to human intervention** stronger than GDPR Art. 22 — design assumption: every automated creditworthiness decision is reviewable on request
- [ ] **Art. 19 database access** — controllers must satisfy GDPR Art. 6 lawful basis + Art. 5 minimisation + Art. 30 RoPA for each database integration

### 15.2 — CCD2 ↔ AI Act

- [ ] Creditworthiness-assessment AI systems classified as **high-risk** under AI Act Annex III(5)(b) — "AI systems intended to be used to evaluate the creditworthiness of natural persons or establish their credit score"
- [ ] AI Act Art. 26 deployer obligations (oversight, monitoring, FRIA) layered on top of CCD2 Art. 18(8) human-intervention right
- [ ] AI Act Art. 27 Fundamental Rights Impact Assessment combined with GDPR Art. 35 DPIA + CCD2 documented procedure (Art. 18(4))
- [ ] AI Act post-market monitoring extends to creditworthiness model drift, fairness metrics, decision-rejection rates

### 15.3 — CCD2 ↔ AMLR / KYC

- [ ] CCD2 creditworthiness assessment ≠ AMLR CDD — both required separately
- [ ] Identification data collected for AMLR Art. 22 CDD may be reused for CCD2 creditworthiness (Art. 18(3) "necessary and proportionate" basis), with GDPR purpose-limitation safeguards
- [ ] **Sanctions / PEP screening data is special-category-adjacent** — handle under GDPR Art. 10 framework; do **not** feed into CCD2 creditworthiness scoring beyond minimum legally required

### 15.4 — CCD2 ↔ DORA

- [ ] DORA-bound credit institutions: CCD2 Art. 18 automated creditworthiness systems are ICT-supported services under DORA's Pillar 1 ICT risk-management scope
- [ ] DORA Art. 28 third-party ICT risk (e.g. external credit-scoring SaaS, alt-data providers) applies to CCD2 creditworthiness pipeline
- [ ] DORA Art. 19 major-incident reporting + CCD2 supervisory-notification reporting may both apply to a single incident (e.g. credit-decision-engine outage)

### 15.5 — CCD2 ↔ NPL Directive (2021/2167)

- [ ] Forbearance regimes (CCD2 Art. 35 ↔ NPL Directive Art. 28) are coordinated — single forbearance policy with CCD2-specific decision rationale captured
- [ ] On NPL sale: CCD2 Art. 39 assignment regime + NPL Directive credit-purchaser / credit-servicer authorisation regime both apply
- [ ] Debt-advisory referral (CCD2 Art. 36) integrated with NPL Directive early-arrears handling

### 15.6 — CCD2 ↔ MiCA / Crypto-Lending

- [ ] **Crypto-collateralised consumer lending**: where consumer obtains fiat credit against crypto collateral, CCD2 applies as a consumer credit agreement; MiCA applies separately to the CASP / collateral-custody side
- [ ] **Stablecoin-denominated consumer credit** (e.g. EMT-denominated): CCD2 applies (credit agreement); EMD2 / MiCA Title III–IV applies to the stablecoin issuance / use
- [ ] **DeFi lending protocols offering consumer access**: under EU CASP / MiCA assessment, the credit agreement layer (where a consumer is the borrower) falls under CCD2; the "non-custodial" framing does not exempt the protocol where it presents/offers credit
- [ ] **Smart-contract credit agreement architecture**: durable-medium (Art. 3(11)) requirement met by ensuring off-chain delivery of SECCI + agreement to consumer; on-chain hashing alone does not satisfy Arts. 9, 10, 20

> **Legal advisor note:** CCD2 was drafted without explicit reference to crypto-asset markets — but its **technology-neutral material scope** captures fiat-denominated credit to a consumer regardless of underlying technology. The greatest exposure for crypto-native firms is in the **embedded-finance + BNPL crypto-stack** intersection: NFT marketplaces offering "pay later" in stablecoin, crypto-exchange "instant credit lines," and DeFi front-ends providing consumer fiat-onramp loans. None of these have a clean CCD1 exemption; under CCD2 from 20 November 2026, all are likely captured.

**Reference:** CCD2; GDPR Reg (EU) 2016/679; AI Act Reg (EU) 2024/1689 Annex III(5)(b); AMLR Reg (EU) 2024/1624; DORA Reg (EU) 2022/2554; NPL Directive (EU) 2021/2167; MiCA Reg (EU) 2023/1114; EMD2 Directive 2009/110/EC

---

## SECTION 16 — TIMELINE & KEY DATES

| Date | Milestone | Source |
|---|---|---|
| **18 October 2023** | CCD2 adopted | Strasbourg signing |
| **30 October 2023** | OJ publication | OJ L series 2023/2225 |
| **19 November 2023** | **CCD2 entered into force** | Article 49 (20 days post-publication) |
| **20 November 2025** | **Member State transposition deadline** (PASSED) | Article 48(1) |
| **20 November 2025** | Member States notify competent authorities to Commission | Article 41(5) |
| **20 November 2026** | **National measures apply / CCD1 (2008/48/EC) repealed** | Articles 47, 48(1) |
| **20 November 2026** | Member States report rate-cap measures + penalties + debt-advisory availability to Commission | Articles 31(3), 44(1), 36(4) |
| **20 November 2027** | Commission publishes Member-State rate-cap measures | Article 31(3) |
| **20 November 2028** | Commission report on debt-advisory services across EU | Article 36(4) |
| **20 November 2029** | EBA report on rate-cap implementation | Article 31(4) |

- [ ] **Application-date readiness** — all sections of this checklist completed by 20 November 2026
- [ ] **Existing-contract grandfathering** — credit agreements existing on 20 November 2026 remain under CCD1 until termination (Art. 47), with limited CCD2 carve-ins for open-end agreements (Arts. 23, 24, 25(1)2nd, 25(2), 28, 39)
- [ ] **Member-State transposition tracking** — for each Member State of operation, monitor the national transposing law and competent-authority Q&A / guidance

**Reference:** CCD2 Articles 47, 48, 49

---

## SECTION 17 — DOCUMENTATION BUNDLE FOR FIRST NCA MEETING

If summoned to a first meeting with your national competent authority (NCA), expect them to ask for:

- [ ] Article 37 admission/registration file (or proof of Art. 37(2) exemption)
- [ ] Conduct-of-business policy + remuneration framework (Art. 32)
- [ ] Staff knowledge/competence training records + certifications (Art. 33)
- [ ] Standard European Consumer Credit Information template + Annex I cross-mapping (Art. 10)
- [ ] General-information document (Art. 9)
- [ ] Sample credit agreements showing Art. 21 mandatory elements
- [ ] Marketing/advertising creative library + Art. 8 compliance review
- [ ] Creditworthiness-assessment procedure document (Art. 18(4))
- [ ] Automated-decision human-intervention workflow + Art. 18(8) operational logs
- [ ] Database integration register + Art. 19(5) special-category-data exclusion attestation
- [ ] Tying/bundling product-design review (Art. 14)
- [ ] Forbearance policy + early-detection process for financial difficulty (Arts. 35, 36)
- [ ] Withdrawal-and-early-repayment operations runbook (Arts. 26, 29)
- [ ] Credit-intermediary onboarding + Art. 38 disclosure templates (if you use intermediaries)
- [ ] ADR mechanism integration (Art. 40)
- [ ] Cross-regime impact assessments (GDPR DPIA + AI Act FRIA + CCD2 Art. 18(4) procedure documentation, consolidated)

---

## READINESS SCORECARD — SUMMARY

*Count completed checkboxes per section.*

| Section | Topic | Items (approx) | Ready? |
|---|---|---|---|
| 1 | Material + territorial scope + lighter regimes | 25 | ☐ |
| 2 | Role classification | 6 | ☐ |
| 3 | Advertising + marketing (Arts. 7, 8) | 17 | ☐ |
| 4 | Pre-contractual disclosure + SECCI + adequate explanations + personalised pricing | 22 | ☐ |
| 5 | Tying / bundling / advisory / unsolicited credit | 15 | ☐ |
| 6 | Creditworthiness assessment + databases | 21 | ☐ |
| 7 | Credit-agreement form and content | 25 | ☐ |
| 8 | Withdrawal / linked credit / open-end / early repayment | 16 | ☐ |
| 9 | APR + rate caps | 8 | ☐ |
| 10 | Conduct of business + staff competence | 7 | ☐ |
| 11 | Financial education + arrears / forbearance / debt advisory | 14 | ☐ |
| 12 | Admission, registration, supervision, intermediaries | 9 | ☐ |
| 13 | Assignment, ADR, competent authorities | 7 | ☐ |
| 14 | Harmonisation, imperative nature, penalties | 8 | ☐ |
| 15 | Cross-regime interaction (GDPR / AI Act / AMLR / DORA / NPL / MiCA) | 22 | ☐ |
| 16 | Timeline awareness | 3 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** CCD2-supervision-ready for 20 November 2026 go-live; align with annual EBA / national NCA guidance updates
- **Amber (50–80% complete):** Material gaps exist — close before the 20 November 2026 application date; prioritise SECCI (Section 4), creditworthiness procedure (Section 6), admission/registration (Section 12), and advertising audit (Section 3)
- **Red (<50% complete):** Significant preparation required — engage specialist EU consumer-credit counsel and a RegTech implementation partner; allocate 6–9 months of remediation work, treat the 20 November 2026 application date as a hard launch gate

---

## WORKING WITH INNBLOCKCHAIN

**What we deliver for CCD2-bound consumer-credit, BNPL, and embedded-finance firms:**

**Pre-Build:** CCD2 scoping brief (material scope + lighter-regime mapping by product) → Member-State transposition map for each jurisdiction of operation → SECCI templates configured to your product set with Annex I element-level audit trail → creditworthiness procedure document drafted to Art. 18(4) standard → AI-Act-Annex-III-5(b) high-risk classification dossier prepared in parallel with CCD2 Art. 18(8) human-intervention workflow

**Build:** Smart-contract / on-chain credit-agreement architecture with off-chain SECCI + Art. 20 durable-medium delivery and on-chain hash anchoring → automated creditworthiness pipeline with mandatory human-review checkpoints satisfying Art. 18(8) + GDPR Art. 22 simultaneously → social-network-data and special-category-data feature exclusion enforced at data-ingestion layer (Art. 18(3), Art. 19(5)) → withdrawal-period state machine with auto-reminder triggers (Art. 10(1) late-disclosure fallback) → early-repayment compensation calculator implementing the Art. 29(2)–(5) caps natively

**Audit:** Independent CCD2-readiness audit of the credit-decision pipeline → SECCI element-by-element review against Annex I → advertising-creative library audit against Arts. 7, 8 → creditworthiness-data-source attestation against Art. 18(3) restrictions → cross-regime audit of CCD2 ↔ GDPR ↔ AI Act ↔ DORA touch-points with single source of truth (the creditworthiness-procedure document)

**Why consumer-credit, BNPL, and embedded-finance firms choose us for the CCD2 layer:** CCD2 is not a paperwork regime — it is an operational regime that re-shapes how credit decisions, product designs, and marketing flows must work. We design and audit those flows to NCA-reviewable standards from day one, and we map each technical decision to the CCD2 article it satisfies, so your head of compliance reads the system architecture alongside the directive, not instead of it.

→ **Contact us:** [Insert contact details]

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. CCD2 implementation is shaped by Member-State transposition laws, national competent authority practice, EBA guidelines, CJEU case law, and ongoing legislative work (AI Act, AMLR, DORA, NPL Directive, MiCA). The national transposing law of each Member State, not CCD2 itself, is operative — always engage qualified consumer-credit counsel for each Member State, sector, and product.*

*Document version: 1.0 | Last updated: May 2026*
*Regulation reference: Directive (EU) 2023/2225 of the European Parliament and of the Council of 18 October 2023 on credit agreements for consumers and repealing Directive 2008/48/EC, as published in OJ L series 2023/2225, 30 October 2023.*
*Official source: https://eur-lex.europa.eu/eli/dir/2023/2225/oj*
