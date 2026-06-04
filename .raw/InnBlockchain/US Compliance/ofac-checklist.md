# OFAC Sanctions Compliance Checklist
## The Legal Advisor's First-Meeting Guide for U.S. Persons and U.S.-Connected Businesses

**Regulation:** U.S. OFAC sanctions regulations — 31 CFR Chapter V (multiple Parts, one per sanctions program), the OFAC SDN List, and program-authorizing Executive Orders
**Issuing Authority:** Office of Foreign Assets Control (OFAC), U.S. Department of the Treasury
**Status:** In force (SDN List updated daily; programs updated by Executive Order, statute, or OFAC rulemaking)
**Document type:** Pre-engagement readiness assessment for any U.S. person or U.S.-connected business that handles financial transactions, securities, real estate, or virtual currency involving non-U.S. counterparties

---

> **Who this document is for:** Any U.S. person (citizen, permanent resident, U.S.-organized entity, U.S.-based foreign branch, or person physically present in the U.S.) operating in financial services, securities, real estate, or virtual currency. OFAC applies broadly and on a **strict liability basis** — there is no good-faith or knowledge defense for civil violations. This checklist mirrors the intake assessment an OFAC-specialist attorney would walk you through before structuring or launching a sanctions-touching business.

---

> **How to use this checklist:** Work through each section in order. Every item marked with a checkbox (☐) represents a concrete requirement or determination you must resolve. Items you cannot check off represent compliance gaps that create OFAC violation exposure — each violation a separate civil penalty event under strict liability, even if you did not know the counterparty was sanctioned.

---

## SECTION 1 — SCOPE: WHO IS A U.S. PERSON?

*OFAC obligations are triggered by being a U.S. person. Confirm your status before anything else.*

---

### 1.1 — The "U.S. Person" Test (31 CFR 560.314 and parallel definitions)

Any one of the following makes you a "U.S. person" subject to OFAC sanctions:

- [ ] **U.S. citizen** (born or naturalized), regardless of where they reside
- [ ] **Permanent resident alien** (green card holder), regardless of where they reside
- [ ] **Any entity organized under U.S. law** — including U.S. corporations, LLCs, partnerships, statutory trusts, and other legal entities
- [ ] **Any person physically located in the U.S.** at the time of the transaction — including foreign nationals temporarily in the U.S.
- [ ] **U.S. branches and subsidiaries of foreign entities** — the U.S. branch is itself a U.S. person
- [ ] For certain programs (Cuba, Iran), **foreign branches and subsidiaries owned or controlled by U.S. persons** are also subject to U.S. sanctions

> **Legal advisor note:** "U.S. person" status is broader than tax residency or immigration status. A foreign-incorporated SPV with its principal place of business in Florida is a U.S. person under OFAC even if it qualifies as a foreign private issuer for SEC purposes. Confirm each entity in the transaction chain (issuer, placement agent, KYC provider, broker, transfer agent, smart contract operator, custody provider) — every U.S. person in the chain has independent OFAC obligations.

**Reference:** 31 CFR § 560.314 (Iran); parallel definitions across other Chapter V Parts; OFAC FAQ guidance

---

### 1.2 — Strict Liability — No Knowledge Defense for Civil Violations

- [ ] **Civil violations** of OFAC sanctions are strict liability — knowledge, intent, and good faith are NOT defenses. Each transaction with a sanctioned party is a separate violation
- [ ] **Criminal violations** require willfulness — knowing violation. Civil violations are typically charged in enforcement actions; criminal violations require DOJ prosecution
- [ ] OFAC may consider mitigating factors (compliance program quality, voluntary disclosure, remedial action) at the penalty determination stage, but liability itself attaches regardless of knowledge
- [ ] You can violate OFAC simply by failing to screen — even if you would have screened correctly had you done so

**Reference:** 50 U.S.C. § 1705 (IEEPA penalties); 31 CFR § 501.701; OFAC Economic Sanctions Enforcement Guidelines (31 CFR Part 501 Appendix A)

---

## SECTION 2 — THE OFAC SANCTIONS LANDSCAPE

*OFAC administers ~30 active sanctions programs of varying scope. Understand the four structural categories.*

---

### 2.1 — Four Structural Categories of OFAC Programs

#### Category 1: Comprehensive Country Embargoes
*Total prohibition on transactions with, in, or for the benefit of the sanctioned jurisdiction or its residents/government.*

- [ ] **Cuba** — Cuban Assets Control Regulations (CACR), 31 CFR Part 515. One of the broadest and oldest programs. Includes extraterritorial reach (controls foreign subsidiaries of U.S. persons)
- [ ] **Iran** — Iranian Transactions and Sanctions Regulations (ITSR), 31 CFR Part 560. Comprehensive embargo with limited general licenses (humanitarian, certain telecom, certain agricultural)
- [ ] **North Korea (DPRK)** — North Korea Sanctions Regulations, 31 CFR Part 510. Comprehensive embargo
- [ ] **Syria** — Syrian Sanctions Regulations, 31 CFR Part 542. Comprehensive embargo

> **Legal advisor note:** "Comprehensive" embargoes prohibit virtually all transactions, not just those with named individuals. Investing in Iranian sovereign debt, processing a payment for an Iranian-resident person, or providing services to a Cuban-resident entity are all violations regardless of SDN-list status. The country itself is the embargoed party.

#### Category 2: Region-Specific Sanctions
*Same as comprehensive but limited to a geographic region within a country.*

- [ ] **Crimea, Donetsk, Luhansk, Kherson, and Zaporizhzhia regions of Ukraine** — Ukraine-/Russia-Related Sanctions Regulations, 31 CFR Part 589, plus E.O. 14065. Transactions in or with these regions are prohibited regardless of the counterparty's identity

#### Category 3: List-Based (SDN) Sanctions
*Prohibitions targeted at specific named individuals and entities, regardless of country.*

- [ ] **Specially Designated Nationals and Blocked Persons (SDN) List** — the primary OFAC list, daily updated. Includes terrorists, narcotics traffickers, WMD proliferators, transnational criminal organizations, malicious cyber actors, human rights abusers, foreign government officials, and entities owned/controlled by them
- [ ] **Subset programs** that contribute to the SDN List: Global Terrorism, Counter Narcotics, WMD Proliferation, Transnational Criminal Organizations, Cyber, Magnitsky (human rights / corruption), Venezuela, Iran, North Korea, Hizballah, Burma, and many others

#### Category 4: Sectoral Sanctions
*Targeted prohibitions on specific industries or transaction types with otherwise-non-SDN parties.*

- [ ] **Sectoral Sanctions Identifications (SSI) List** — Russia/Ukraine-Related Sectoral Sanctions (Directives 1-4 issued under E.O. 13662): debt/equity restrictions for major Russian financial, energy, defense entities
- [ ] **Iranian Financial Sanctions Regulations** (Part 561) — sanctions on financial institutions that knowingly facilitate certain Iranian transactions
- [ ] **Hong Kong-Related Sanctions** — E.O. 13936 designations
- [ ] Various other program-specific sectoral measures

**Reference:** 31 CFR Chapter V (Parts 500-599); OFAC Sanctions Programs and Country Information page; Executive Orders authorizing each program

---

### 2.2 — The 50 Percent Rule (OFAC Guidance, August 13, 2014)

- [ ] Any entity **owned 50% or more, directly or indirectly, individually or in the aggregate, by one or more SDN-listed persons** is itself treated as SDN — even if not explicitly listed
- [ ] **Aggregation across multiple SDN owners** matters — three SDN persons each owning 20% (60% combined) makes the entity SDN
- [ ] The rule applies through **multiple layers** of ownership — a non-SDN parent owning a non-SDN subsidiary that is 50%+ owned by SDN persons is itself blocked at the subsidiary level
- [ ] The 50 Percent Rule does NOT apply to sectoral sanctions (Directives 1-4) — there a 50%+ ownership by SSI-listed parties does not automatically extend SSI status, though Treasury may designate the subsidiary separately
- [ ] **Practical implication for the diligence pipeline:** entity investors require beneficial-ownership analysis going at least three layers deep, with aggregation logic

**Reference:** OFAC Revised Guidance on Entities Owned by Persons Whose Property and Interests in Property are Blocked (Aug. 13, 2014); OFAC FAQ 401

---

## SECTION 3 — THE OFAC LISTS YOU MUST SCREEN AGAINST

*OFAC maintains multiple lists. The SDN List is the primary one, but others apply depending on the sanctions program touched.*

---

### 3.1 — The Lists

- [ ] **Specially Designated Nationals (SDN) List** — primary sanctions list. Includes names, aliases, dates of birth, places of birth, ID numbers, addresses, and (since 2018) wallet addresses for digital currency
- [ ] **Sectoral Sanctions Identifications (SSI) List** — Russia/Ukraine sectoral targets (Directives 1-4 under E.O. 13662)
- [ ] **Foreign Sanctions Evaders (FSE) List** — non-U.S. persons who have violated, attempted to violate, or facilitated U.S. sanctions
- [ ] **Non-SDN Iranian Sanctions Act (NS-ISA) List** — entities subject to Iran-related secondary sanctions (typically non-U.S. persons facing sanctions on their ability to transact with U.S. financial system)
- [ ] **Non-SDN Palestinian Legislative Council (NS-PLC) List** — Palestinian Legislative Council members subject to limited transactional restrictions
- [ ] **13599 List** — Iranian-government-related entities under E.O. 13599
- [ ] **CAPTA List (Correspondent Account / Payable-Through Account Sanctions List)** — foreign financial institutions subject to correspondent-banking restrictions under the Iran Threat Reduction Act
- [ ] **Non-SDN Menu-Based Sanctions (NS-MBS) List** — entities subject to graduated menu-based sanctions (typically Russia program)
- [ ] **Consolidated Sanctions List** — OFAC also publishes a consolidated list combining the non-SDN lists for convenience

### 3.2 — Crypto/Wallet Addresses on the SDN List

- [ ] **OFAC publishes virtual currency wallet addresses directly on the SDN list** — starting 2018 with Iranian-linked Bitcoin addresses, expanded significantly since
- [ ] **Major designations of note** (illustrative, not exhaustive):
  - 2018 — first crypto-address designations (Iranian-linked Bitcoin addresses)
  - August 2022 — **Tornado Cash** smart contract addresses (mixer) — extraordinary because the designations were against contract code, not just user wallets
  - 2020-2024 — wallets linked to ransomware operators (DarkSide, Conti, etc.), North Korean cyber actors (Lazarus), Russian/Iranian/North Korean state actors
- [ ] **Screening must cover the wallet address itself, not just the identity behind it** — a fresh wallet belonging to an SDN-listed individual that has not yet been added to the list may not flag on address-screening, but the underlying person flags on identity-screening; both must be screened
- [ ] **Indirect exposure to a sanctioned address** through receiving funds that previously touched a sanctioned wallet is itself a risk — typical screening providers offer "address risk score" to flag indirect exposure even when the immediate counterparty is not directly sanctioned

**Reference:** OFAC SDN List (administrative publication); OFAC Recent Actions page; OFAC FAQs on virtual currency (especially FAQs 559, 560, 561, 646)

---

## SECTION 4 — SCREENING REQUIREMENTS

*OFAC does not prescribe a specific screening methodology, but maintaining an effective sanctions compliance program is the only practical defense against violations.*

---

### 4.1 — The Four Screening Dimensions

For each counterparty (investor, vendor, counterparty in any transaction), screen across **all four**:

- [ ] **(1) Identity Match Against the SDN List** — counterparty's legal name, aliases, date of birth, place of birth, government ID numbers, addresses. Use fuzzy matching with cultural-name normalization (transliteration variants, common spelling variants, alias handling), not just exact string match
- [ ] **(2) Wallet Address Match Against the SDN Crypto-Address List** — counterparty's wallet address itself, plus addresses they have transacted with (indirect exposure score)
- [ ] **(3) Comprehensive Country / Region Match** — counterparty's country of residence, country of nationality, country of operations. Cuba, Iran, North Korea, Syria, and the Russian-occupied regions of Ukraine (Crimea, Donetsk, Luhansk, Kherson, Zaporizhzhia) trigger blanket prohibitions
- [ ] **(4) 50 Percent Rule Beneficial-Ownership Analysis** — for entity counterparties, identify all owners ≥10% and screen each. If aggregate SDN ownership reaches 50%, the entity itself is SDN

### 4.2 — Screening Cadence

- [ ] **Initial screening** — at onboarding / before the first transaction. Block onboarding if any dimension flags
- [ ] **Continuous re-screening** — OFAC updates the SDN List daily (sometimes intra-day for emergency designations). Screening provider pulls deltas at least daily and re-screens the full counterparty population
- [ ] **Pre-transaction re-screening** — before each material transaction (subscription, distribution, settlement), confirm screening status is current within the freshness window
- [ ] **Periodic full re-screening** — at least quarterly, perform a full re-screen of the entire counterparty population against the current full SDN List (not just deltas), to catch cases where the delta processing may have failed

### 4.3 — Screening Provider Selection

- [ ] **Specialized commercial providers** for the financial services and crypto industries:
  - **Chainalysis** (KYT — Know Your Transaction) — blockchain analytics + sanctions screening
  - **TRM Labs** — blockchain forensics + sanctions screening
  - **ComplyAdvantage** — identity sanctions screening (also AML)
  - **Refinitiv World-Check** — broad sanctions/PEP/adverse-media screening
  - **LexisNexis Bridger Insight** — broad sanctions/PEP/adverse-media screening
- [ ] Selection criteria:
  - Coverage of all the lists you need (SDN, SSI, FSE, non-SDN programs, crypto addresses)
  - Update cadence — daily delta minimum
  - Fuzzy matching quality (false positive rate vs. recall)
  - API integration with your KYC/identity infrastructure
  - Audit trail and reporting
  - SOC 2 Type II or equivalent operational controls

**Reference:** OFAC Framework for Compliance Commitments (May 2019); Sanctions Compliance Guidance for the Virtual Currency Industry (Oct 2021)

---

## SECTION 5 — BLOCKING OBLIGATIONS

*If screening identifies a match, immediate blocking is required by OFAC regulations.*

---

### 5.1 — What "Blocking" Means

- [ ] **Block** = freeze in place. The property remains where it is, in whose possession it is, but cannot be moved, paid out, transferred, or otherwise dealt with without OFAC authorization
- [ ] Blocking is **NOT seizure** — the U.S. government does not take possession; the holding party retains custody under regulatory freeze
- [ ] Blocking applies to ALL property and interests in property of the blocked person — bank accounts, securities, real estate, contractual rights, virtual currency, etc.
- [ ] **No release without OFAC authorization** — the blocked property cannot be returned to the blocked person, transferred to a third party, or otherwise dealt with absent an OFAC license

### 5.2 — Immediate Freeze on Detection

- [ ] When screening identifies a match — whether at onboarding, during continuous monitoring, or pre-transaction — the affected property must be **immediately frozen**
- [ ] Pending transactions to or from the blocked party must be **rejected** if not yet settled, or **blocked** if already in progress
- [ ] Existing accounts/positions of the blocked party must be moved to a designated blocked-property segregated account or otherwise flagged as frozen
- [ ] All distributions, dividends, interest, principal, and other payments owing to the blocked party must be **paid into the blocked account** (not paid to the blocked party) until OFAC license authorizes release

### 5.3 — Rejected vs. Blocked Transactions

- [ ] **Rejected** transaction = one you decline to process because executing it would violate sanctions. The funds/property never enter your control. Returned to sender
- [ ] **Blocked** transaction = one where you take possession or control of the property (typically because the sanction landed mid-transaction or because your role made you the custodian)
- [ ] Both rejections and blockings trigger OFAC reporting obligations (Section 6 below)

**Reference:** 31 CFR § 501.603 (blocking and reporting); program-specific blocking provisions in each Chapter V Part

---

## SECTION 6 — REPORTING OBLIGATIONS

*Multiple reports are required. Timeliness matters — late reporting itself is a violation.*

---

### 6.1 — Report of Blocked Transactions (TD F 90-22.50) — Within 10 Business Days

- [ ] Required whenever property is blocked in accordance with OFAC regulations
- [ ] Filed via OFAC's electronic reporting system
- [ ] Required information includes:
  - Identifying information of the blocked party (name, address, country, ID numbers, etc.)
  - Date of blocking
  - Description of the property
  - Ownership, interest, or beneficiary information
  - Amount or value
  - Location of the property
  - Circumstances of blocking (which screening match triggered it)
- [ ] Filing must occur **within 10 business days** of the blocking event

**Reference:** 31 CFR § 501.603

---

### 6.2 — Report of Rejected Transactions — Within 10 Business Days

- [ ] Required whenever a transaction is rejected due to sanctions (declined to execute, returned to sender)
- [ ] Same 10-business-day filing window as blocked transactions
- [ ] Required information includes:
  - Identifying information of all transaction parties
  - Date and nature of the rejected transaction
  - Reason for rejection
  - Amount or value
  - Documentation of the rejection

**Reference:** 31 CFR § 501.604

---

### 6.3 — Annual Report of Blocked Property (ARG) — By September 30 Each Year

- [ ] Required by **every U.S. person holding blocked property** as of June 30 each year
- [ ] Filed by **September 30 of that year**, covering all blocked property held as of June 30
- [ ] Required even if the property was previously reported via TD F 90-22.50 — the ARG is a comprehensive annual roll-up
- [ ] Required information:
  - Description of blocked property
  - Blocked party identity
  - Date of blocking
  - Current value
  - Location

**Reference:** 31 CFR § 501.603(b)(2); annual ARG instructions published by OFAC

---

### 6.4 — Recordkeeping — 5 Years

- [ ] **All records related to sanctions compliance** — screening results, blocking and rejection determinations, license applications, ARG filings, internal compliance reviews — must be retained for **5 years**
- [ ] Records must be available for OFAC inspection on demand
- [ ] Recordkeeping requirement is independent of and longer than typical AML retention (5 years vs. SAR retention requirements)

**Reference:** 31 CFR § 501.601

---

## SECTION 7 — LICENSING FRAMEWORK

*OFAC sanctions are not absolute. In specific circumstances, OFAC may authorize otherwise-prohibited transactions through licenses.*

---

### 7.1 — General Licenses

- [ ] **General Licenses** = standing authorizations OFAC publishes that authorize broad categories of transactions for anyone meeting the stated conditions
- [ ] **No application needed** — if your contemplated transaction fits the GL's terms exactly, you can rely on it
- [ ] Common GL categories:
  - Humanitarian transactions (medicine, food, certain medical devices)
  - Journalistic and academic activities
  - Certain agricultural exports
  - Personal communications and information sharing
  - Telecommunications services (limited)
  - Wind-down of pre-existing transactions following a designation
- [ ] **Document compliance with GL terms contemporaneously** — if challenged, you must show your transaction met every GL condition. Marginal cases are not protected
- [ ] GLs can be revised, expanded, or revoked by OFAC at any time. Re-confirm current GL terms before each reliance

**Reference:** OFAC General Licenses (program-specific, published on OFAC website)

---

### 7.2 — Specific Licenses

- [ ] **Specific Licenses** = case-by-case authorizations OFAC issues in response to a written application
- [ ] Typical timeline: 60-90 days for routine matters, longer for complex or novel applications
- [ ] Required information in application:
  - Detailed description of the proposed transaction
  - Identity of all parties
  - Reason the transaction would otherwise be prohibited
  - Why a license should be issued (humanitarian, legal obligation, public policy, etc.)
  - Conditions you would accept on the license
- [ ] Specific licenses commonly granted for:
  - Release of erroneously blocked property
  - Wind-down of pre-existing obligations following a designation
  - Court-ordered transactions
  - Certain legal services to blocked parties
  - Inheritance and divorce settlements involving blocked property
- [ ] License once granted is **specific to the transaction and parties applied for** — it does not authorize broader or similar transactions

**Reference:** 31 CFR § 501.801

---

## SECTION 8 — VOLUNTARY SELF-DISCLOSURE (VSD)

*If you discover a violation post-facto, voluntary self-disclosure substantially mitigates penalty exposure.*

---

### 8.1 — When to Self-Disclose

- [ ] Self-disclosure is **voluntary** — there is no obligation to disclose if OFAC has not asked
- [ ] But voluntary self-disclosure typically results in **substantial penalty mitigation** — often 50%+ reduction from the base civil penalty calculation
- [ ] **Failing to self-disclose when OFAC later independently discovers the violation** substantially increases penalty exposure — non-disclosure is treated as an aggravating factor
- [ ] Standard practice: disclose if (a) you have credible internal evidence of a violation, AND (b) OFAC has not yet contacted you about the matter, AND (c) the violation is non-trivial in scope

### 8.2 — VSD Submission Components

- [ ] **Written submission to OFAC's Enforcement Division** describing:
  - Nature and circumstances of the apparent violation
  - Detailed transaction information (dates, amounts, parties, ID information)
  - Root-cause analysis explaining how the violation occurred
  - Remediation steps already taken
  - Future controls being implemented to prevent recurrence
- [ ] **Cooperation commitment** — agreement to cooperate fully with any subsequent OFAC inquiry
- [ ] Submission must be **timely** — disclosure long after the violation typically receives less mitigation credit
- [ ] **Engage OFAC-specialist counsel** before any VSD — disclosure framing materially affects penalty outcome

**Reference:** OFAC Economic Sanctions Enforcement Guidelines (31 CFR Part 501 Appendix A), Section IV — General Factors Affecting Administrative Action; OFAC FAQ guidance on VSD

---

## SECTION 9 — VIRTUAL CURRENCY-SPECIFIC GUIDANCE

*OFAC issued targeted virtual currency industry guidance in October 2021. Crypto-touching businesses have specific obligations.*

---

### 9.1 — Sanctions Compliance Program (SCP) for Virtual Currency Businesses

OFAC's October 2021 guidance identifies five essential components every effective sanctions compliance program should include:

- [ ] **(1) Management commitment** — explicit senior management endorsement of the SCP, sufficient resources, board-level visibility for material decisions
- [ ] **(2) Risk assessment** — periodic assessment of the firm's sanctions exposure considering customer base, products, services, geographies, and counterparties. Document the assessment methodology and conclusions
- [ ] **(3) Internal controls** — written policies and procedures, including:
  - Customer onboarding and KYC including OFAC screening
  - Transaction monitoring and screening
  - Blocking and reporting procedures
  - Escalation protocols
  - Recordkeeping
- [ ] **(4) Testing and audit** — periodic independent testing of the SCP's effectiveness. Audit findings and remediation tracked at the management/board level
- [ ] **(5) Training** — initial and periodic training for all employees with sanctions-touching responsibilities. Maintain training records

### 9.2 — Specific Risks for Virtual Currency Businesses

- [ ] **Anonymous wallets** — pseudonymous nature of crypto wallets means address screening is necessary but not sufficient; identity layer (KYC) must tie wallets to verified persons
- [ ] **Geographic obfuscation** — VPN use, IP spoofing, and other geographic-masking techniques make country-residence determinations harder. Multi-factor jurisdiction analysis (IP + payment instrument + declared residence + KYC documentation) is the standard
- [ ] **DeFi and DAO exposure** — even decentralized protocols are subject to OFAC if a U.S. person is operating them or providing services. Tornado Cash designation (Aug 2022) confirmed protocol-level liability
- [ ] **Wrapped tokens and cross-chain bridges** — moving value across chains can transit a sanctioned address or service. Track exposure across bridge contracts
- [ ] **Mixers and privacy tools** — addresses that have used mixing services within a recent window (typically 60-90 days) are treated as high-risk even if not directly sanctioned
- [ ] **Stablecoins** — issuers may have their own freeze/blacklist capability; coordinate with issuer when blocking obligations attach to stablecoin holdings

### 9.3 — Recent Crypto Enforcement Actions (Illustrative)

| Year | Target | Outcome |
|---|---|---|
| 2018 | First OFAC crypto-address designations | Iranian-linked Bitcoin addresses added to SDN List |
| 2020 | BitGo | Settled for ~$98K for processing transactions for users in Cuba, Iran, North Korea, Sudan, Syria, Crimea |
| 2022 | Bittrex | Settled for $24M (largest crypto OFAC settlement at time) for similar geographic and SDN violations |
| 2022 | Tornado Cash | Smart contract addresses sanctioned — protocol-level designation |
| 2023 | Binance | Combined OFAC/FinCEN settlement $968M+ for sanctions and AML failures |
| 2023 | Kraken | Settled for $362K for processing transactions for users in Iran |

**Reference:** OFAC Sanctions Compliance Guidance for the Virtual Currency Industry (Oct 15, 2021); OFAC Recent Actions page

---

## SECTION 10 — ENFORCEMENT & PENALTIES

*Penalty magnitudes are not theoretical. Recent enforcement actions in the crypto sector run into hundreds of millions.*

---

### 10.1 — Civil Penalties

- [ ] **Per-violation maximum:** the GREATER of:
  - **$311,562 per violation** (2024 inflation-adjusted maximum, recalculated annually by Treasury)
  - **Twice the value of the underlying transaction**
- [ ] Each separate transaction is a separate violation. Multi-transaction enforcement actions easily reach millions or billions in aggregate exposure
- [ ] **Strict liability** — no knowledge or intent requirement for civil penalties

### 10.2 — Criminal Penalties (Willful Violations)

- [ ] **Individuals:** up to **$1,000,000 per violation** AND/OR up to **20 years imprisonment** per violation
- [ ] **Corporations:** up to the GREATER of **$1,000,000** OR **twice the gain/loss**
- [ ] Willfulness requires DOJ prosecution and proof beyond a reasonable doubt
- [ ] Civil and criminal penalties can be pursued concurrently

### 10.3 — Non-Monetary Consequences

- [ ] **Public enforcement action** — OFAC publishes enforcement actions on its website with the name of the violator and the conduct
- [ ] **Banking impact** — U.S. correspondent banks routinely terminate relationships with parties subject to OFAC enforcement actions; difficulty obtaining new banking relationships
- [ ] **Reputational damage** — capital markets, sophisticated investors, and counterparties may refuse to do business with sanctioned-action subjects
- [ ] **Cease-and-desist orders** — OFAC can require immediate remediation and compliance program upgrades
- [ ] **Industry notice** — banking and securities regulators (SEC, FINRA, FinCEN, OCC, Fed) typically take action in parallel based on the same conduct

### 10.4 — Enforcement Considerations

OFAC's Enforcement Guidelines (31 CFR Part 501 Appendix A) identify factors that mitigate or aggravate penalties:

**Mitigating:**
- Voluntary self-disclosure
- Effective sanctions compliance program at the time of the violation
- Remedial actions taken
- Cooperation with OFAC investigation
- First-time violation
- Substantial cooperation in identifying other violators

**Aggravating:**
- Willfulness or reckless disregard
- Awareness of conduct (knowledge that conduct was prohibited)
- Pattern of conduct
- Harm to sanctions program objectives
- Large transaction value
- Concealment from regulators
- Lack of remediation post-discovery

**Reference:** OFAC Economic Sanctions Enforcement Guidelines (31 CFR Part 501 Appendix A)

---

## SECTION 11 — INTERACTION WITH OTHER U.S. REGULATORY REGIMES

*OFAC operates independently of and cumulatively with other compliance regimes. Confirm cross-overlay.*

---

### 11.1 — AML / BSA (FinCEN)

- [ ] OFAC sanctions compliance is **independent** of FinCEN's AML/BSA obligations under the Bank Secrecy Act. Some screening may overlap (PEPs, adverse media), but sanctions screening is its own discipline
- [ ] AML SAR filings are separate from OFAC blocked-transaction reports
- [ ] FinCEN designations (e.g., 311 designations, special measures) are coordinated with OFAC but separate in application

### 11.2 — SEC Securities Regulation

- [ ] Reg S, Reg D, Reg A, and other SEC offering frameworks do NOT exempt from OFAC. Selling securities to a sanctioned investor is an OFAC violation even if the offering itself complies with Reg S or Reg D
- [ ] SEC anti-fraud rules (10b-5, 17(a)) also apply independently — material misrepresentation about sanctions compliance can trigger securities-fraud liability in addition to OFAC penalties

### 11.3 — Export Controls (BIS, State Department)

- [ ] OFAC sanctions and export controls (EAR — Export Administration Regulations, ITAR — International Traffic in Arms Regulations) are administered by separate agencies but often overlap
- [ ] Comprehensive country embargoes (Cuba, Iran, North Korea, Syria) interact with EAR country charts
- [ ] Dual-use goods and software may require both OFAC and BIS authorization

### 11.4 — State Securities and Money Transmission Laws

- [ ] State money transmitter licensing (49 U.S. states + DC + territories) imposes its own sanctions compliance expectations
- [ ] New York Department of Financial Services (NYDFS) BitLicense includes sanctions compliance program requirements
- [ ] State enforcement actions in parallel with OFAC are common

---

## SECTION 12 — COMMON FAILURE MODES

*Frequent ways OFAC compliance fails. Review before launch.*

---

- [ ] **Treating SDN screening as one-time** — failing to re-screen against daily SDN updates means newly-designated counterparties continue to transact
- [ ] **Missing the crypto-address dimension** — screening identities but not wallet addresses, missing Tornado Cash designations and other contract-level sanctions
- [ ] **Comprehensive country oversight** — focusing on SDN matches while ignoring country-of-residence prohibitions for Cuba, Iran, North Korea, Syria, and the Russian-occupied Ukrainian regions
- [ ] **50 Percent Rule not enforced** — accepting entity investors without beneficial-ownership look-through; aggregating SDN ownership across multiple owners
- [ ] **Geographic obfuscation acceptance** — accepting VPN users, IP-masked subscribers, or counterparties whose declared residence does not match payment-instrument origin
- [ ] **Stale screening cache** — using cached screening results beyond the freshness window
- [ ] **Failure to block on detection** — recording a hit but allowing the transaction to complete pending compliance review
- [ ] **Late or missed reports** — TD F 90-22.50 not filed within 10 business days; ARG not filed by September 30
- [ ] **Foreign subsidiary blind spot** — Cuba/Iran programs reach foreign subsidiaries owned by U.S. persons; treating subsidiaries as outside U.S. person scope creates exposure
- [ ] **License conditions not documented** — relying on a General License but failing to document contemporaneous compliance with its terms
- [ ] **Material misrepresentation in self-disclosure** — VSDs that omit, minimize, or misframe the violation forfeit mitigation credit and may create additional fraud exposure

---

## READINESS SCORECARD — SUMMARY

| Section | Topic | Key Items | Ready? |
|---|---|---|---|
| 1 | Scope (U.S. person test, strict liability) | 8 | ☐ |
| 2 | Sanctions landscape (program categories, 50 Percent Rule) | 12 | ☐ |
| 3 | OFAC lists (SDN, sectoral, non-SDN programs, crypto addresses) | 12 | ☐ |
| 4 | Screening requirements (four dimensions, cadence, providers) | 15 | ☐ |
| 5 | Blocking obligations | 8 | ☐ |
| 6 | Reporting obligations (TD F 90-22.50, ARG, recordkeeping) | 18 | ☐ |
| 7 | Licensing framework (General + Specific) | 12 | ☐ |
| 8 | Voluntary self-disclosure | 8 | ☐ |
| 9 | Virtual currency-specific guidance (SCP, crypto risks, enforcement) | 18 | ☐ |
| 10 | Enforcement & penalties | 12 | ☐ |
| 11 | Cross-regulatory overlays | 8 | ☐ |
| 12 | Common failure modes | 11 | ☐ |

**Overall assessment:**
- **Green (>80% complete):** Sanctions compliance program in place; ongoing monitoring established
- **Amber (50–80% complete):** Material gaps exist — close these before processing any U.S.-connected transactions
- **Red (<50% complete):** Significant exposure — do not transact under U.S.-person status until program is built

---

*Disclaimer: This checklist is provided for informational and educational purposes only. It does not constitute legal, financial, or regulatory advice. OFAC sanctions programs are amended frequently by Executive Order, statute, and OFAC rulemaking. Always engage qualified OFAC-specialist legal counsel for your specific business and any transaction touching sanctioned jurisdictions, sanctioned parties, or U.S. persons. This document references 31 CFR Chapter V — verify current text and active sanctions programs at sanctions.ofac.treas.gov before reliance.*

**Sources:**
- [31 CFR Chapter V — Office of Foreign Assets Control regulations](https://www.ecfr.gov/current/title-31/subtitle-B/chapter-V) (multiple Parts per sanctions program)
- [OFAC SDN List](https://sanctionssearch.ofac.treas.gov/) (daily updated; administrative publication outside the CFR)
- [OFAC Recent Actions](https://ofac.treasury.gov/recent-actions) (designations, removals, guidance)
- [OFAC Sanctions Programs and Country Information](https://ofac.treasury.gov/sanctions-programs-and-country-information)
- [OFAC Economic Sanctions Enforcement Guidelines (31 CFR Part 501 Appendix A)](https://www.ecfr.gov/current/title-31/subtitle-B/chapter-V/part-501/appendix-Appendix%20A%20to%20Part%20501) (penalty determination)
- [OFAC Sanctions Compliance Guidance for the Virtual Currency Industry (Oct 15, 2021)](https://ofac.treasury.gov/media/913571/download)
- [OFAC A Framework for Compliance Commitments (May 2, 2019)](https://ofac.treasury.gov/media/16331/download)
- 50 U.S.C. §§ 1701-1707 (IEEPA — International Emergency Economic Powers Act, the primary statutory authority for most modern sanctions programs)
- 50 U.S.C. App. §§ 1-44 (TWEA — Trading with the Enemy Act, the older authority for Cuba sanctions)

**Cross-references within this vault:**
- [Reg S checklist](reg-s-checklist.md) — §8.4 notes that OFAC sanctions screening is required for all Reg S purchasers; Reg S does not create a sanctions exemption
- [Rule 144 checklist](rule-144-checklist.md) — Rule 144 resales do not exempt from OFAC; affiliate sellers and non-affiliate sellers alike must be OFAC-screened

*Document version: 1.0 | Created: June 2026*
*Based on eCFR as of 6 June 2026 and OFAC sanctions programs in effect as of June 2026.*
