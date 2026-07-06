---
type: concept
title: "US Fintech Compliance Landscape"
created: 2026-05-23
updated: 2026-06-04
tags:
  - US
  - fintech
  - compliance
  - regulation
status: current
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[Regulation-S]]"
  - "[[Rule-144]]"
  - "[[Rule-144A]]"
  - "[[OFAC-Sanctions]]"
  - "[[Real-Estate-RWA-Reg-D-Reg-S-Implementation]]"
  - "[[Real-Estate-RWA-Reg-S-Affiliate-Addendum]]"
  - "[[Stablecoin-Cross-Border-Payments]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[Blockchain-Fintech-Solutions]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/US Compliance/US-Compliance-Landscape.md"
    hash: "2ad8832cb1e413c06537981097663dbd"
    previous_hash: "254a3ec743648bc33d3ee207f6a065fd"
    registered: 2026-05-23
    last_updated: 2026-06-04
    derived_from: this wiki concept
    purpose: "Standalone InnBlockchain-branded client-shareable artifact (frontmatter stripped, H1 shortened to 'US Compliance Landscape'); body content tracks this wiki concept as canonical — keep them in sync if either changes. 2026-06-04 re-ingest added inline wikilinks at Seg 1 RWA / WealthTech / RWA-callout / Quick Reference / InnBlockchain Relevance to the four new concept pages ([[Regulation-S]] anchor link added; [[Rule-144]] added; [[OFAC-Sanctions]] added; [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] + [[Real-Estate-RWA-Reg-S-Affiliate-Addendum]] added), and added a Primary Sources section at the bottom with eCFR URLs for §§ 230.901-905, § 230.144, § 230.144A, Reg D/A/CF, Rule 15c2-11, 31 CFR Chapter V Parts 501/510/515/542/560/589, OFAC SDN List, plus a Supervisors and Agency Pages list."
---

# US Fintech Compliance Landscape

The US has no equivalent to the EU's single-market, directly-applicable regulatory model. Federal authority is fragmented across at least eight regulators (SEC, CFTC, FinCEN, OCC, FDIC, Federal Reserve, CFPB, IRS), each state runs its own money-transmission and (increasingly) consumer-protection regime, and crypto classification has been litigation-driven since 2017 — only beginning to consolidate now under the GENIUS Act (signed July 2025) and the CLARITY Act (passed House July 2025, cleared Senate Banking Committee May 14, 2026; full Senate vote pending). For any fintech operating in the US or serving US customers, "compliance" is rarely a single rulebook — it is a matrix of federal agency jurisdiction × state licensing × ongoing litigation.

## The Key Regulations (2025-2026)

| Regulation | Focus | Key Deadline | Penalty |
|-----------|-------|-------------|---------|
| **Securities Act 1933 / Exchange Act 1934 + SEC** | Securities offerings + market intermediaries (Howey-classified tokens) | Continuous; **SAB 121 rescinded Jan 23, 2025** via SAB 122 (custody no longer balance-sheet liability) | Civil penalties up to 3× gain; disgorgement; injunctions; criminal referral |
| **Commodity Exchange Act + CFTC** | Commodity derivatives, swaps; BTC + ETH classified as commodities | Continuous | $1.4M+ per violation per day; disgorgement; bans |
| **Bank Secrecy Act + FinCEN** | AML/CTF, MSB registration, SAR/CTR, Travel Rule | Travel Rule threshold currently **$3,000** (FinCEN 2010); proposed reduction to **$250 cross-border** pending finalization `[verify]` | $25K–$100K per day per violation civil; up to $500K + 10 years criminal |
| **AML Act 2020 + CTA** | Beneficial ownership reporting | **CTA scope narrowed Mar 26, 2025**: FinCEN interim final rule exempts all US-formed entities + US persons; only foreign-formed entities registered to do business in a US state still report. 11th Circuit affirmed CTA constitutionality (2025) | $591/day civil; $10K + 2 years criminal (applies only to remaining foreign-entity scope) |
| **GENIUS Act** | Federal payment-stablecoin framework (issuer authorization, reserves, redemption) | **Enacted Jul 18, 2025**; effective the earlier of (a) **Jan 18, 2027** (18 months post-enactment) or (b) 120 days after primary regulators finalize rules. OCC NPRM Mar 2026; FDIC proposal Jan 2026 | TBD via final rules; expect tiered banking-style penalties + license revocation |
| **CLARITY Act / FIT21** | SEC vs CFTC market-structure split for digital commodities vs securities | **House passed Jul 17, 2025** (294-134); **Senate Banking cleared May 14, 2026**; full Senate floor vote pending. Until enacted, classification remains litigation-driven | TBD |
| **OFAC sanctions** | SDN list compliance; entity / address blocking | Continuous; **Tornado Cash delisted Mar 21, 2025** following 5th Circuit *Van Loon* (Nov 2024) holding that immutable smart contracts aren't "property" under IEEPA | $377K civil per violation (2026 inflation adj.); criminal up to $1M + 20 years; secondary sanctions on counterparties |
| **CFPB Section 1033 — Open Banking** | Consumer financial data portability | **Final rule Oct 2024 stayed**: CFPB moved to vacate own rule May 30, 2025; Judge Reeves (E.D. Ky.) enjoined enforcement Oct 2025; CFPB issued ANPR Aug 22, 2025 for revised rulemaking — **no compliance obligations active as of May 2026** | TBD pending re-rulemaking |
| **IRS Form 1099-DA** | Digital-asset broker reporting | **CeFi brokers: live since Jan 1, 2025** (first 1099-DA filings due early 2026 for tax year 2025). **DeFi broker rule REPEALED**: Trump signed H.J.Res.25 (CRA) on Apr 10, 2025 — DeFi front-end providers are not brokers; CRA bars substantially similar future rule without new legislation | Standard IRS information-return penalties: $310/return (2026), capped at $3.78M/yr per filer |
| **State Money Transmitter Licenses** | Custody + transfer of fiat / virtual currency, state-by-state | Continuous; **MTMA adoption: 42 states + DC** (Dec 2025) — Massachusetts, Mississippi, Nebraska, Colorado live in 2025; Virginia effective Jul 1, 2026. Eight non-MTMA states remain bespoke | State-by-state; cease-and-desist + criminal referral; bond forfeiture; license revocation |
| **NY DFS BitLicense** | Virtual-currency business activity touching NY residents (23 NYCRR Part 200) | Continuous; conditional BitLicense + limited-purpose trust charter paths available | $5K–$25K per violation per day + license revocation; NY has assessed $100M+ cumulative in DFS-only crypto fines |
| **CA DFPI Digital Financial Assets Law (DFAL)** | California-specific crypto licensing for covered persons | **Effective Jul 1, 2026** (delayed from original Jul 1, 2025 by AB 1934 signed Sep 2024) `[verify exact effective date]` | DFPI civil penalties + license denial; one of the most stringent state regimes |
| **Colorado AI Act (SB 24-205)** | High-risk AI in lending, insurance, employment, housing | Originally Feb 1, 2026; **delayed to Jun 30, 2026** (SB 25B-004, Aug 28, 2025); federal magistrate stayed enforcement Apr 27, 2026 amid DOJ/xAI constitutional challenge — **operative status uncertain** | $20K per violation under Colorado Consumer Protection Act |

Several further regimes apply but sit outside the "key list" because they trigger horizontally rather than by activity — **GLBA / Reg P** (15 USC §6801) governs nonpublic personal information at any "financial institution" (broadly defined to include MSBs, BNPL, neobanks, RIAs); **CCPA / CPRA + state privacy laws** apply to any business processing CA-resident personal information meeting thresholds, with **20 states** now having comprehensive privacy laws in force or signed `[verify count as of May 2026]`; **EFTA / Reg E** governs error resolution + unauthorized-transfer liability for any electronic fund transfer; **TILA / Reg Z** governs consumer credit cost disclosure, extended to BNPL via the CFPB May 2024 interpretive rule (current CFPB enforcement posture: paused). All are mapped in the Dependency Map below.

## Enforcement Climate

Enforcement posture has shifted sharply between administrations and is now bifurcated by agency:
- **SEC enforcement against crypto: collapsed** — under Chair Atkins (confirmed Apr 2025), 12+ active crypto cases dismissed or paused (Coinbase, Binance, Consensys, Ripple appeals dropped, Uniswap NFT case dropped). Crypto Task Force replaced enforcement-first posture with rulemaking-first.
- **CFTC: holding the line** on commodity-derivatives enforcement; record $4.3B in monetary relief in FY2024, with ~50% from digital-asset cases (Binance, FTX, Voyager residuals).
- **FinCEN: structurally constrained** by the March 2025 CTA scope reduction but continues large MSB/AML actions — Binance ($4.3B 2023 settlement, monitorship ongoing), TD Bank ($1.3B 2024); 2026 actions tracking smaller MSBs.
- **OFAC: post-*Van Loon* recalibration** — Tornado Cash delisted (Mar 2025); developer Roman Storm's criminal trial (Jul 2025) is the open question on liability for code authors `[verify trial outcome]`.
- **State AGs + DFPI / DFS: rising** — fills the federal pullback, especially in privacy (CA, TX, CT), AI (CO, NY), and crypto (NY, CA).
- **IRS: ramping** — 1099-DA enforcement begins with the 2025 tax-year filings due 2026; expect mismatch notices at scale.

Net: federal crypto enforcement is at a multi-year low while state and CFTC pressure remain elevated. This is the inverse of the EU trajectory.

## Compliance Dependency Map

```
─── HORIZONTAL (applies broadly across the entity, not activity-specific) ───────
GLBA / Reg P ──────► Any "financial institution" handling nonpublic personal info
                      (banks, MSBs, RIAs, lenders, BNPL, neobanks)
State privacy laws ─► CCPA/CPRA + ~19 other state regimes; threshold-based but
                      applies regardless of fintech vs non-fintech status
EFTA / Reg E ──────► Any provider of consumer EFT services (cards, ACH, wallets)
BSA / FinCEN MSB ──► Any "money services business" by activity (transmitter,
                      exchanger, dealer in foreign exchange, issuer of stored value)
OFAC sanctions ────► Universal — every US person + entity, including code authors
                      (subject to evolving Van Loon limits on immutable contracts)

─── FEDERAL CONDITIONAL (triggers when specific activity is present) ────────────
SEC / 33 Act / 34 Act ► Securities offerings (Howey, Reves), exchanges, brokers,
                         transfer agents, investment advisers, funds
CFTC / CEA ──────────► Commodity derivatives, swaps, retail commodity transactions;
                         BTC + ETH are commodities, most other tokens contested
GENIUS Act ──────────► Payment stablecoin issuance to US persons (effective by
                         Jan 18, 2027 — only "permitted issuers" allowed)
CLARITY Act ─────────► Digital commodities trading + intermediaries (pending Senate)
Form 1099-DA ────────► CeFi brokers + custodial digital-asset platforms only;
                         DeFi front-ends explicitly excluded (CRA repeal Apr 2025)
CFPB regs (E/Z/V/B) ─► Consumer credit, deposits, EFT, credit reporting, ECOA;
                         enforcement posture currently constrained
Section 1033 ────────► Stayed; no current obligations
CFPB BNPL (TILA) ────► BNPL providers re: Reg Z; current CFPB stance: enforcement
                         paused, rule may be rescinded
NCUA + Federal banking ► Insured depositories: OCC (national banks), FDIC (state
  agencies                 nonmember banks), Fed (BHCs + state member banks)

─── STATE CONDITIONAL (triggers by state nexus + activity) ──────────────────────
State MTLs ──────────► Custody / transfer of fiat OR virtual currency on behalf of
                         users; 49 states + DC + PR + USVI; MTMA in 42 + DC
NY DFS BitLicense ──► Virtual currency business activity touching NY residents
                         (custody, exchange, transfer, issuance, control)
CA DFPI DFAL ───────► Digital-financial-asset business activity in CA (Jul 2026)
WY SPDI / DAO LLC ──► Special-purpose depository institution + DAO incorporation
State AI laws ──────► Colorado AI Act (Jun 2026, currently stayed), NYC AEDT (in
                         force; auto-employment decision tools), TX Responsible AI
                         Governance Act (Jan 2026) `[verify Texas]`, others
HIPAA ──────────────► Only if InsurTech touches PHI (rare for fintech-only stack)
COPPA ──────────────► Only if product collects data from US users under 13
TCPA ───────────────► Marketing comms (SMS / call) to US numbers — strict-liability
                         private right of action, $500–$1,500 per violation
```

> [!warning] Three common misframes to avoid
> **"Howey is the only test."** False. Tokens evidencing debt obligations get the *Reves* family-resemblance test; ownership-conferring tokens may also implicate Section 3(a)(10) "investment contract" via the *Howey* test, but partnership / LLC interests, notes, and certain tokenized funds invoke separate frameworks. *SEC v. W.J. Howey* (1946) is the headline; *Reves v. Ernst & Young* (1990) is the gotcha for any yield-bearing instrument structured as a note.
>
> **"FinCEN Travel Rule mirrors the EU TFR."** False. FinCEN's current threshold is **$3,000** (proposed reduction to **$250 cross-border**, not finalized as of May 2026). The EU Travel Rule (Regulation (EU) 2023/1113) has **no threshold** for CASP-to-CASP crypto transfers. A US firm meeting US obligations is NOT compliant for EU-facing flows.
>
> **"There is a US digital-identity wallet equivalent to eIDAS 2.0 / EUDI Wallet."** No. US identity is fragmented across state driver's licenses (with mDL pilots in CA, AZ, CO, MD, others), IRS authentication (ID.me), Login.gov for federal services, and REAL ID for federal facility access. There is no federal digital-identity wallet, no mandatory RP-acceptance regime, and no equivalent compliance trigger. KYC stack remains the responsibility of the regulated entity — typically delegated to Onfido, Jumio, Persona, Plaid, Alloy.

## Regulation Interaction Risks

US regulatory layering creates distinct tension points:

1. **SEC vs CFTC**: The unresolved jurisdictional question — is a given token a security or a commodity? *SEC v. Ripple* (S.D.N.Y. 2023) split institutional vs programmatic sales; *SEC v. Coinbase* (dropped Feb 2025) left the question doctrinally unsettled. **CLARITY Act is the legislative attempt to resolve this** — until enacted, the same token can face dual claims of jurisdiction, and the safe-harbor question (Reg D vs CFTC swap-dealer registration) remains live.

2. **Federal vs state preemption**: Federal banking law (NBA, HOLA) preempts certain state consumer-protection rules for national banks and federal savings associations; non-bank fintechs (PIs, EMIs, BaaS partners) get no preemption and must comply state-by-state. The 2024 *Cantero v. Bank of America* (SCOTUS) decision narrowed preemption further, putting pressure on the BaaS sponsor-bank model.

3. **GENIUS Act vs state MTLs**: The Act creates federal pathways for payment-stablecoin issuance (OCC-supervised nonbank issuers, IDI subsidiaries) — but state-qualified issuer pathway remains for issuers under $10B (consolidated) `[verify cap]`. State MTLs for transmission of those stablecoins remain in force regardless of issuer authorization basis. **Authorization at one level does not relieve obligations at the other.**

4. **OFAC vs Van Loon / DeFi**: The 5th Circuit's holding that immutable smart contracts aren't "property" under IEEPA does NOT extend to mutable contracts, governance tokens with admin keys, or front-end interfaces. OFAC retains broad authority over US-person interaction with sanctioned addresses. Tornado Cash delisting did not create a categorical DeFi safe harbor — the *Storm* criminal trial is the test of personal liability for protocol developers.

5. **CFPB 1033 stay vs state open-banking**: Federal Section 1033 obligations are paused; however, state open-banking initiatives (NJ, CA pilots `[verify]`) and contractual data-access regimes (Akoya, Plaid, MX) continue. Building a US data-access compliance program around "wait for the federal rule" is currently the wrong posture.

6. **IRS 1099-DA scope vs state tax**: Federal CeFi broker reporting is live; the CRA repeal eliminated only the federal DeFi piece. State income-tax authorities can still issue subpoenas for digital-asset transaction history under state escheat and tax-enforcement authority — NY DTF, CA FTB are most active.

## Compliance by ICP Segment

### Crypto Native ICP

> [!info] Reading rules for this table
> **State MTLs and BSA/FinCEN MSB registration apply to every Seg 2-10 segment that touches custody or transfer of value on behalf of users.** Not repeated in each row — see Quick Reference. Segment rows list the *primary* federal obligations and any conditional triggers worth flagging at the segment level.
>
> **Travel Rule** ($3,000 FinCEN threshold; proposed $250 cross-border): applies to **every** Seg 2-10 segment operating as an MSB. Does **NOT** apply to Seg 1 unless the firm also operates a virtual-asset transmission side — securities-classified tokens are settled through traditional securities infrastructure (transfer agents, DTCC) and don't invoke the MSB Travel Rule.
>
> **OFAC sanctions screening** applies universally to every US person/entity and every segment. Not repeated in each row.

| Segment | US Compliance Obligations |
|---|---|
| **Seg 1 — RWA Tokenization** | **Securities Act 1933 + Exchange Act 1934** (primary — almost any token conferring ownership / claim is a security under *Howey* or *Reves*; CLARITY Act may carve out "digital commodities" but does not touch RWA) · **Reg D 506(c)** (accredited only, most common); **Reg A+ Tier 2** (retail up to $75M); **Reg CF** (≤$5M crowdfunding); **[[Regulation-S]]** (17 CFR §§ 230.901-905 — offshore safe harbor for non-US-person purchasers; commonly paired with Reg D 506(c) for concurrent US-accredited + offshore tranches; Category 3 distribution compliance period = 1 year for equity tokens, 40 days for debt; **flowback risk** if tokens reach US persons in the compliance period breaks the safe harbor; **Rule 905 makes Cat 3 domestic-issuer equity permanently "restricted securities" under [[Rule-144]]** even after offshore Rule 904 secondary resales — see [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] for the InnBlockchain reference architecture) · **Transfer agent registration** (Section 17A) if the firm maintains the ownership ledger · **No DLT Pilot Regime equivalent** — SEC's "innovation" path is the no-action letter / exemptive order process (Securitize, INX, tZERO precedents), all narrow · **FINRA ATS registration** if secondary trading offered · **State Blue Sky laws** (Reg D 506 + Reg S federally covered; Reg CF + Reg A Tier 1 require state-by-state notice or qualification) · **[[OFAC-Sanctions]]** (strict liability on every U.S.-person transaction — four screening dimensions including SDN identity, SDN wallet address, comprehensive country embargoes, 50 Percent Rule) · **GLBA** · **State privacy laws** |
| **Seg 2 — DEX & On-Chain Trading** | **Exchange Act registration** (if facilitating securities trading — the *Coinbase* case was dropped but doctrine unresolved) · **CFTC swap dealer / FCM registration** (if derivatives or leveraged retail commodity transactions on a non-cash-settled basis) · **BSA / FinCEN MSB** (transmission of value on behalf of users) · **State MTLs** (49+ jurisdictions if user nexus) · **OFAC** (post-*Van Loon* care for smart-contract design + front-end blocking) |
| **Seg 3 — DeFi Lending & Yield** | **Securities Act** (if pool tokens or yield instruments are securities — *SEC v. Kraken* (staking-as-a-service settled 2023; dismissed 2025) precedent ambiguous) · **CFTC** (if leverage / margin / synthetics) · **BSA / FinCEN** (custodial only; non-custodial DeFi explicitly NOT a broker per Apr 2025 CRA repeal) · **State lending licenses** (if extending credit to consumers — varies state-by-state, several treat overcollateralized crypto loans as licensable lending) · **Colorado AI Act** (Jun 2026, currently stayed; if AI used for credit scoring) · **ECOA / Reg B** (if consumer credit — adverse-action notice + disparate-impact constraints) |
| **Seg 4 — Non-Custodial & MPC Wallets** | **BSA / FinCEN** (FinCEN 2019 guidance: non-custodial software-only wallets are NOT money transmitters; **custody on behalf of users triggers MSB registration**) · **State MTLs** (state-by-state interpretation varies — NY DFS, TX, FL most aggressive on MPC = control = transmission) · **OFAC** (front-end + node-operator screening obligations) · **GLBA** (if collecting KYC) |
| **Seg 5 — NFT Platforms** | **Securities Act** (fractionalized NFTs, NFT collections marketed with promoter promises, dynamic-yield NFTs may be securities — *SEC v. Stoner Cats* (2023) and *SEC v. Impact Theory* (2023) settled; framework unresolved; *Sky Mavis* / *Yuga Labs* investigations closed without action in 2024) · **BSA / FinCEN** (if NFT trading enables value transfer) · **State sales tax** (multiple states now collecting NFT sales tax — WA, PA, MN) · **IP / DMCA** (creator rights) · **Colorado AI Act** (if generative-AI mechanics) |
| **Seg 6 — Token Launch / IDO** | **Securities Act 1933** (default classification — almost every public token sale is a securities offering; *SEC v. Telegram* (2020), *SEC v. Kik* (2020), *SEC v. LBRY* (2022) precedents; CLARITY Act may create a digital-commodity issuance path) · **Reg D 506(c)** (accredited only — most common 2024-2026 path), **Reg A+ Tier 2** (retail, qualified offering up to $75M), **Reg CF** (≤$5M, intermediary required), **[[Regulation-S]]** (Rules 901-905 — offshore safe harbor; non-US-person purchasers only; "no directed selling efforts" in the US is a strict condition — Discord/Twitter/Telegram general marketing can break the safe harbor; Category 3 = 1-year distribution compliance period for most token issuers; tokens commonly used **Reg D + Reg S concurrent structure** to address both markets in a single raise) · **State Blue Sky** for Reg A/CF (Reg D 506 + Reg S federally covered) · **BSA / FinCEN** (if proceeds touch transmission) · **OFAC** (purchaser screening on both Reg D and Reg S tranches) |
| **Seg 7 — DAO Infrastructure** | **Securities Act** (governance tokens with profit expectation = investment contract; *CFTC v. Ooki DAO* (N.D. Cal. 2022) established DAOs can be sued as unincorporated associations) · **State entity law** (Wyoming DAO LLC, Vermont BBLLC, Marshall Islands DAO — only WY and VT confer US-state legal personality) · **Joint-and-several member liability** the default in states without DAO statutes · **BSA / FinCEN** (if DAO operates a treasury / transfer function) |
| **Seg 8 — L2 & Chain Infrastructure** | **No direct federal license** (consensus + execution layer infra not currently regulated as such) · **BSA / FinCEN** (sequencer + bridge operators may be MSBs if they exercise control over funds in transit — facts-specific; bridge operators particularly exposed) · **CFTC** (if native token is a commodity derivative) · **State MTLs** (if bridge custody) · **OFAC** (sequencer-level transaction screening — open question; some L2s have implemented OFAC filtering, others have not) |
| **Seg 9 — Web3 Gaming / GameFi** | **Securities Act** (if in-game tokens with tradeable value + profit expectation — *SEC v. Dapper Labs* (NBA Top Shot, settled 2023 on Moments) precedent) · **State gambling laws** (loot boxes, P2E with cash-out are regulated as gambling in WA, NV, and others — facts-specific) · **COPPA** (if any US user under 13 — applies to any data collection) · **BSA / FinCEN** (if cash-out / fiat off-ramp) · **TCPA** (in-game marketing comms) |
| **Seg 10 — AI × Crypto** | **No federal AI Act** — patchwork applies: **Colorado AI Act** (high-risk AI in financial decisions; Jun 2026, stayed), **NYC Local Law 144** (AEDT for employment — in force), **TX Responsible AI Governance Act** (effective Jan 2026 `[verify]`), **CA SB 1047 vetoed Sep 2024**, **CA AB 2013** (training-data transparency, Jan 2026) · **Securities + CFTC** (if AI agent executes covered transactions — agent legal status unsettled) · **BSA / FinCEN** (if AI agent transmits value — registration attaches to the operator, not the agent) · **OFAC** (agent transaction screening required) · **FTC Section 5** (UDAP for misrepresented AI capabilities — active enforcement focus) |

> [!note] NFT Grey Zone (US version)
> The SEC closed investigations into Yuga Labs (Sep 2024) and Sky Mavis (2024) without action. Combined with the dismissal of Coinbase, Consensys, and Uniswap NFT cases in 2025, the practical enforcement posture is that pure-collectible NFTs are de-prioritized. State AGs (NY, CA) remain active, and the *securities* question is not legally resolved — only enforcement priorities have shifted. Don't sell Seg 5 prospects on permanent regulatory clarity.

> [!warning] RWA in the US ≠ "Just Tokenize It"
> Unlike MiCA in the EU, the US has no mutual-exclusivity carve-out for tokenized securities. Almost any ownership-conferring or yield-bearing token is a security under the 1933 Act by default. There are five real production paths:
> - **Reg D 506(c)** — accredited-investor only, general solicitation permitted, 12-month resale lock-up under [[Rule-144]]; the dominant 2024-2026 RWA path
> - **Reg A+ Tier 2** — retail-eligible up to $75M/yr, qualified offering circular, ongoing reporting; few issuers complete it
> - **Reg CF** — crowdfunding up to $5M/yr, retail-eligible, registered intermediary required; rarely used for tokens due to transfer restrictions
> - **[[Regulation-S]]** — offshore safe harbor for non-US-person purchasers, no SEC registration; **commonly paired with Reg D 506(c) as a concurrent dual-tranche structure** to address US-accredited and offshore markets in one raise. Three category-tiers under Rule 903 set the distribution compliance period (Category 1 = no compliance period, only for non-US issuers without substantial US market interest; Category 2 = 40 days; Category 3 = 1 year for equity, 40 days for debt — most token issuers fall here). **"No directed selling efforts" in the US** is a strict condition: open Discord channels, Twitter/X promotion, US-targeted Telegram all break the safe harbor. **Flowback** (tokens reaching US persons during the compliance period) also breaks it. See [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] for the InnBlockchain reference architecture (affiliate-free Cat 3 domestic-issuer equity, ERC-1400 + ERC-3643 stack, two-clock canTransfer enforcement) and [[Real-Estate-RWA-Reg-S-Affiliate-Addendum]] for the optional [[Rule-144]] affiliate machinery extension (institutional investor with board representation scenarios)
> - **Public registration (S-1)** — full reporting; cost-prohibitive for most tokenization projects
>
> The "DLT Pilot Regime" in the EU has **no US analog**. The closest is SEC exemptive relief (Securitize / INX / tZERO precedent), each granted ad hoc and narrowly. Telling a US RWA prospect "you can just tokenize without securities registration" is a credibility risk — the prospect's outside counsel will catch it.
>
> **Reg S misuse warning**: SEC has historically challenged Reg S structures where tokens were marketed broadly online or designed to flow back into US trading. *SEC v. Telegram* (2020) made clear that a Reg S sale to non-US persons followed by listing on US-accessible exchanges does NOT cleanse the offering — the secondary distribution to US persons can pull the entire raise into Section 5 violation. Treat Reg S as a real safe harbor with real conditions, not a US-securities-laws-don't-apply hatch.

### FinTech ICP

| Segment | US Compliance Obligations |
|---|---|
| **WealthTech (RWA / STO / Tokenized Securities)** | **Securities Act 1933 + Exchange Act 1934** (primary — financial-instrument classification) · **Investment Advisers Act 1940** (if portfolio management or wrap services) · **Investment Company Act 1940** (if pooled vehicle) · **FINRA membership** (if broker-dealer activity) · **Reg D 506(c) / Reg A+ / Reg CF / [[Regulation-S]]** for token offerings (Reg D + Reg S concurrent structure is the dominant 2024-2026 RWA path for issuers serving both US-accredited and international investors; for Reg S Cat 3 domestic-issuer equity, [[Rule-144]] applies via the Rule 905 bridge — see [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] for the reference architecture) · **SAB 122** (crypto custody recognition — favorable post-Jan 2025) · **[[OFAC-Sanctions]]** (strict liability — applies cumulatively to every U.S.-person transaction independent of any securities-law exemption) · **GLBA / Reg S-P** (customer NPI) · **State Blue Sky** for Reg A/CF (Reg D 506 + Reg S federally covered) · **Colorado AI Act** (if AI in portfolio/risk; Jun 2026, stayed) |
| **ExchangeTech (CEX / DEX / DeFi FinTech)** | **BSA / FinCEN MSB** (mandatory) · **State MTLs** (49+ states; **NY DFS BitLicense** for any NY-resident exposure) · **CA DFPI DFAL** (Jul 2026) · **CFTC FCM / swap-dealer / DCM / SEF** (if derivatives) · **SEC broker-dealer + ATS** (if securities — currently low enforcement) · **OFAC sanctions program** (live transaction screening + SDN blocking) · **Form 1099-DA** (CeFi only) · **GLBA** |
| **LendTech (Digital Lending / BNPL / Credit)** | **TILA / Reg Z** (consumer-credit cost disclosure; BNPL covered via 2024 CFPB interpretive rule, **enforcement currently paused**) · **ECOA / Reg B** (anti-discrimination; adverse-action notices) · **FCRA / Reg V** (if consumer-reporting agency activity, or furnishing data) · **State usury caps + lender licensing** (per-state — most active enforcement at the state level; "true lender" doctrine since *Madden v. Midland* remains a litigation risk for bank-partnership models) · **MLA** (Military Lending Act 36% APR cap) · **SCRA** (servicemember protections) · **Colorado AI Act** (Jun 2026, stayed) for AI underwriting · **GLBA** |
| **WalletTech (e-money / payment wallets)** | **BSA / FinCEN MSB** · **State MTLs** (universal) · **EFTA / Reg E** (unauthorized-transfer liability; error-resolution; **prepaid Reg E since 2019**) · **GENIUS Act** (if storing or issuing payment stablecoins; effective by Jan 2027) · **OCC fintech charter** (theoretical path — no operating charters issued as of May 2026) · **CA DFPI DFAL** (Jul 2026) for CA-resident crypto wallets · **GLBA** · **OFAC** |
| **PayTech (Payments / Remittance)** | **BSA / FinCEN MSB** (CIP + SAR + CTR) · **State MTLs** (universal — **the single largest US-specific compliance cost**) · **EFTA / Reg E** (consumer protections) · **Reg E §1005.30 (Remittance Rule)** (cross-border consumer remittances >$15) · **NACHA Operating Rules** (ACH) · **FedNow / RTP scheme rules** (if instant payments — FedNow GA Jul 2023, mandatory bank-to-bank operating procedures) · **Card-network rules** (Visa / Mastercard / Discover / Amex — not law, but contractually binding) · **OFAC** (real-time screening) · **GLBA** |
| **RegTech (KYC/AML tooling)** | **BSA / FinCEN** (indirect — tool must enable customer to meet CIP / SAR / SDN obligations) · **CCPA / CPRA + state privacy laws** (identity data is sensitive personal info under several state regimes) · **GLBA service-provider obligations** (under client FI's privacy program) · **Colorado AI Act** (if KYC/fraud uses AI scoring — high-risk category, Jun 2026 stayed) · **No SOC 2 by law** but de facto mandatory for FI procurement |
| **BankTech (Neo-banks / Core Banking)** | **Federal banking law** (OCC for national charter; FDIC for state nonmember; Fed for state member + BHCs) · **Bank Holding Company Act** · **CRA** (Community Reinvestment Act) · **BSA / FinCEN** · **EFTA / Reg E**, **TILA / Reg Z**, **TISA / Reg DD** (deposit-account disclosure), **ECOA / Reg B**, **FCRA / Reg V** · **GLBA / Reg P** · For **BaaS sponsor-bank model**: post-*Cantero* preemption narrowing, partner-bank scrutiny is high (Synapse failure Apr 2024, Evolve consent order Jun 2024) — third-party risk management is the dominant 2025-2026 supervisory focus · **GENIUS Act** if issuing payment stablecoins |
| **InsurTech** | **State insurance commissioners** (50 + DC + PR; **no federal insurance regulator** for non-systemic insurers) · **NAIC model laws** (state-adopted, varying) · **NY DFS Reg 187** (best-interest for life/annuity) · **GLBA** · **HIPAA** (if health-insurance product) · **Colorado AI Act** + NAIC AI Model Bulletin (adopted by 20+ states `[verify]`) — most active state-AI vector for insurance pricing/underwriting · **State privacy laws** |

### Quick Reference: Primary Regulatory Trigger by Segment

*Cells show where each regulation is the **dominant framing** for that segment, plus secondary triggers in parentheses. State MTLs, BSA / FinCEN MSB, GLBA, and OFAC are broad-scope; the matrix below shows where they are *primary* triggers, not where they merely apply. See Dependency Map for full scope.*

| Regulation | Crypto Native ICP | FinTech ICP |
|---|---|---|
| **SEC / Securities Act / Exchange Act** | Seg 1 RWA (primary — almost all RWA tokens are securities); Seg 6 Token Launch (primary); Seg 3, 5, 7 conditional | WealthTech (primary), ExchangeTech (if securities trading) |
| **Reg D 506(c) / Reg A+ / Reg CF / [[Regulation-S]]** | Seg 1 RWA (primary — Reg D + Reg S concurrent dominant; Rule 905 bridges to [[Rule-144]] for Cat 3 domestic-issuer equity; [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] = real-estate reference architecture, [[Real-Estate-RWA-Reg-S-Affiliate-Addendum]] = optional affiliate machinery extension), Seg 6 Token Launch (primary — same dual-tranche pattern); Seg 7 DAO if governance token sold | WealthTech (primary); BankTech, InsurTech if raising primary capital via tokenized vehicle |
| **CFTC / CEA** | Seg 2 (if derivatives), Seg 3 (if leverage / synthetics), Seg 8 (native commodity tokens), Seg 10 (if agent trades commodities) | ExchangeTech (if derivatives) |
| **BSA / FinCEN MSB** | All Seg 2-10 that custody or transmit on behalf of users (Seg 4 conditional on custody; Seg 7 conditional on treasury function; Seg 8 conditional on bridge/sequencer control) | ExchangeTech (mandatory), WalletTech (mandatory), PayTech (mandatory); BankTech via banking charter; LendTech, InsurTech, RegTech conditional |
| **State MTLs** | All Seg 2-10 with state user nexus + custody/transmission; **NY DFS BitLicense** specifically for any NY-resident exposure | ExchangeTech, WalletTech, PayTech (all mandatory across most states) |
| **GENIUS Act** | Only if firm issues a payment stablecoin (rare on this side post-2025) | WalletTech (if stablecoin-backed), PayTech (if stablecoin rails), BankTech (if IDI-subsidiary issuer) |
| **Form 1099-DA** | Seg 2 (if CeFi-classified custodial exchange); explicitly NOT Seg 3, 4 non-custodial, 7 DAO, 8 L2 (per CRA repeal Apr 2025) | ExchangeTech (CeFi side), WalletTech (custodial only) |
| **OFAC sanctions** | All segments (US-person screening obligation universal; *Van Loon* narrows scope for immutable contracts but not front-ends or US-person interaction) | All segments |
| **TILA / Reg Z + ECOA / Reg B + FCRA** | Seg 3 DeFi Lending (if consumer credit) | LendTech (primary), BankTech (consumer-credit products) |
| **EFTA / Reg E** | Seg 4, Seg 9 (if fiat off-ramp) | WalletTech, PayTech, BankTech (mandatory) |
| **State AI laws (CO, NYC, TX)** | Seg 3 (lending), Seg 10 AI×Crypto, Seg 5 + Seg 9 conditional | LendTech, InsurTech, RegTech (primary); BankTech, WealthTech secondary |
| **GLBA / Reg P + state privacy** | All segments collecting KYC | All segments |
| **CFPB Section 1033** | — (stayed) | WealthTech, BankTech, PayTech would be in scope if/when revised rule lands |
| **Federal banking law (OCC/FDIC/Fed)** | Seg 1 indirect (if working with chartered partner); Seg 8 indirect (if bridge serves an IDI) | BankTech (primary); WalletTech + PayTech (sponsor-bank model exposure) |
| **State insurance / NAIC** | — | InsurTech (mandatory across 50 states) |
| **HIPAA / COPPA / TCPA** | Seg 9 (COPPA if under-13 users); all segments (TCPA for marketing) | InsurTech (HIPAA if health); all (TCPA for marketing) |

> [!tip] State MTL as a Sales Hook
> The single largest US-specific compliance friction is the **49-state MTL patchwork**. Even with MTMA in 42 + DC, ongoing renewal, surety bonds, net-worth requirements, and Nationwide Multistate Licensing System (NMLS) reporting consume 1-2 FTE per fintech indefinitely. Prospects scaling from regional to national service (Seg 2 DEX going retail, ExchangeTech going US-wide, BaaS partner-banks) face 12-24 month MTL acquisition timelines. Compliance tooling that maps obligations across states, automates NMLS filings, and tracks bond/net-worth thresholds is a defensible sales hook for InnBlockchain compliance-infra plays.

## InnBlockchain Relevance

US compliance is a different revenue motion from the EU and must be sold differently:

- **FinTech ICP**: Compliance lead is typically a Chief Compliance Officer / BSA Officer (not the EU's "CCO veto" model — US compliance functions are often more operationally embedded). Vendor risk packs are segment-scoped — **all FinTech segments**: SOC 2 Type II (universal), GLBA service-provider agreements, state privacy DPAs, and (post-Synapse / Evolve) **third-party risk management documentation** is now table-stakes for any BaaS or sponsor-bank-adjacent fintech. **Only if the FinTech touches crypto** (ExchangeTech, WalletTech with crypto, BankTech crypto-custody product, WealthTech with tokenized side): add BSA/FinCEN MSB context + state MTL coverage analysis + (if stablecoin issuance) GENIUS Act issuer-pathway analysis. Pure-fiat PayTech, LendTech, RegTech, InsurTech are out of MiCA / GENIUS scope — do not lead with crypto regs in those rooms.

- **Crypto Native ICP**: Federal classification is bifurcated (SEC vs CFTC, CLARITY Act pending) — sell **process** (audit, monitoring, OFAC integration), not regulatory certainty. **Seg 1 RWA is securities-primary** — Reg D 506(c) + [[Regulation-S]] concurrent is the dominant production path; the lack of a DLT Pilot Regime equivalent means tokenization platforms need real broker-dealer / ATS / transfer-agent infrastructure, not a sandbox shortcut. [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] is the InnBlockchain reference architecture for U.S.-domiciled real-estate sponsors doing offshore-only Reg S Cat 3 STOs (affiliate-free, ERC-1400 + ERC-3643 stack, 12-month per-tranche compliance clocks, 9.99% concentration cap, [[OFAC-Sanctions]] strict-liability enforcement on every transfer). **Seg 2-10 lives or dies on state MTL coverage** more than on any federal regime.

- **State AI laws as the EU AI Act analog**: The patchwork of Colorado AI Act (stayed but watch closely), NYC AEDT (in force, employment), and state-by-state NAIC AI bulletin adoption (20+ states for insurance) replaces the EU's single high-risk AI regime. The on-chain audit-trail use case still works — sell it as **state insurance commissioner + state lending regulator examiner-readiness**, not federal AI Act compliance.

- **GENIUS Act as a 2026-2027 build-out market**: Federal stablecoin issuance becomes legal under tight conditions. Issuer-readiness work (reserve attestation infrastructure, redemption mechanics, monthly disclosure templates) is a 6-18 month dev-and-audit pipeline for any prospect targeting the OCC nonbank-issuer pathway or IDI-subsidiary path. CLARITY Act, if it passes the Senate floor in 2026, opens a second wave for digital-commodity intermediaries.

- **Defensive enforcement-shift posture**: SEC enforcement against crypto is at a multi-year low — but the *threat* of FY2027+ reversal (depending on administration) keeps audit/compliance investment warranted. State AG + DFPI + DFS enforcement is the active vector. Sell to state-exam preparedness, not federal investigation defense.

## Primary Sources

Citations use eCFR URLs (the canonical, version-stable form for U.S. federal regulations). Agency pages are listed separately because that's where guidance, no-action letters, and enforcement statistics publish.

### Federal Securities Regulations

| Regulation | Instrument | Official source |
|---|---|---|
| Regulation S — Reg 230.901 | 17 CFR § 230.901 (General Statement) | https://www.ecfr.gov/current/title-17/chapter-II/part-230/section-230.901 |
| Regulation S — Reg 230.902 | 17 CFR § 230.902 (Definitions) | https://www.ecfr.gov/current/title-17/chapter-II/part-230/section-230.902 |
| Regulation S — Reg 230.903 | 17 CFR § 230.903 (Issuer Safe Harbor) | https://www.ecfr.gov/current/title-17/chapter-II/part-230/section-230.903 |
| Regulation S — Reg 230.904 | 17 CFR § 230.904 (Offshore Resales) | https://www.ecfr.gov/current/title-17/chapter-II/part-230/section-230.904 |
| Regulation S — Reg 230.905 | 17 CFR § 230.905 (Resale Limitations) | https://www.ecfr.gov/current/title-17/chapter-II/part-230/section-230.905 |
| Rule 144 — Resale safe harbor | 17 CFR § 230.144 | https://www.ecfr.gov/current/title-17/chapter-II/part-230/section-230.144 |
| Rule 144A — QIB resale safe harbor | 17 CFR § 230.144A | https://www.ecfr.gov/current/title-17/chapter-II/part-230/section-230.144A |
| Regulation D — Rules 504/506(b)/506(c) | 17 CFR §§ 230.500-230.508 | https://www.ecfr.gov/current/title-17/chapter-II/part-230 |
| Regulation A — Tier 1/Tier 2 | 17 CFR §§ 230.251-230.263 | https://www.ecfr.gov/current/title-17/chapter-II/part-230 |
| Regulation Crowdfunding — Reg CF | 17 CFR §§ 227.100-227.503 | https://www.ecfr.gov/current/title-17/chapter-II/part-227 |
| Rule 15c2-11 — Current public information | 17 CFR § 240.15c2-11 | https://www.ecfr.gov/current/title-17/chapter-II/part-240/section-240.15c2-11 |

### Federal Sanctions Regulations

| Regulation | Instrument | Official source |
|---|---|---|
| OFAC — General provisions | 31 CFR Part 501 | https://www.ecfr.gov/current/title-31/subtitle-B/chapter-V/part-501 |
| OFAC — Cuban Assets Control (CACR) | 31 CFR Part 515 | https://www.ecfr.gov/current/title-31/subtitle-B/chapter-V/part-515 |
| OFAC — North Korea Sanctions (NKSR) | 31 CFR Part 510 | https://www.ecfr.gov/current/title-31/subtitle-B/chapter-V/part-510 |
| OFAC — Syrian Sanctions (SySR) | 31 CFR Part 542 | https://www.ecfr.gov/current/title-31/subtitle-B/chapter-V/part-542 |
| OFAC — Iranian Transactions and Sanctions (ITSR) | 31 CFR Part 560 | https://www.ecfr.gov/current/title-31/subtitle-B/chapter-V/part-560 |
| OFAC — Ukraine-/Russia-Related (URSR) | 31 CFR Part 589 | https://www.ecfr.gov/current/title-31/subtitle-B/chapter-V/part-589 |
| OFAC — All sanctions programs index | 31 CFR Chapter V | https://www.ecfr.gov/current/title-31/subtitle-B/chapter-V |
| OFAC SDN List | Administrative publication (daily updated) | https://sanctionssearch.ofac.treas.gov/ |

### Other Federal Regulations

| Regulation | Instrument | Official source |
|---|---|---|
| GENIUS Act (payment stablecoins) | Pub. L. 119-XX (signed Jul 18, 2025) | https://www.congress.gov/bill/119th-congress/senate-bill/919 `[verify final P.L. number]` |
| CLARITY Act / FIT21 (digital commodities) | H.R. 4763 — Senate Banking Committee cleared May 14, 2026 | https://www.congress.gov/bill/119th-congress/house-bill/4763 |
| Bank Secrecy Act — Travel Rule | 31 CFR § 1010.410 | https://www.ecfr.gov/current/title-31/subtitle-B/chapter-X/part-1010/section-1010.410 |
| FinCEN MSB regulations | 31 CFR Part 1022 | https://www.ecfr.gov/current/title-31/subtitle-B/chapter-X/part-1022 |
| Form 1099-DA — Digital asset broker reporting | IRC § 6045 + Treas. Reg. § 1.6045 | https://www.irs.gov/forms-pubs/about-form-1099-da |
| CTA — Corporate Transparency Act (FinCEN) | 31 CFR § 1010.380 (BOI) | https://www.fincen.gov/boi |
| Section 1033 — Open Banking | 12 U.S.C. § 5533 (Dodd-Frank) | https://www.consumerfinance.gov/rules-policy/regulations/1033 |

### Supervisors and Agency Pages

Where guidance, no-action letters, exemptive orders, FAQs, and enforcement statistics publish:

- **SEC** (Securities Act, Exchange Act, Reg S, Rule 144, Reg D, Reg A, Reg CF): https://www.sec.gov
  - SEC Crypto Task Force (post-Apr 2025): https://www.sec.gov/about/crypto-task-force
- **CFTC** (Commodity Exchange Act, swap regulation, BTC + ETH as commodities): https://www.cftc.gov
- **FinCEN** (BSA, MSB registration, Travel Rule, SAR/CTR, CTA): https://www.fincen.gov
- **OFAC** (sanctions enforcement, SDN List, General + Specific Licenses, October 2021 virtual currency guidance): https://ofac.treasury.gov
  - Recent Actions: https://ofac.treasury.gov/recent-actions
  - Virtual Currency Guidance: https://ofac.treasury.gov/media/913571/download
- **IRS** (Form 1099-DA, digital asset broker reporting): https://www.irs.gov/businesses/digital-assets
- **OCC** (national bank chartering, fintech charter, BaaS supervisory expectations): https://www.occ.treas.gov
- **FDIC** (state nonmember bank supervision, BaaS partner-bank scrutiny post-Synapse): https://www.fdic.gov
- **Federal Reserve** (state member banks, BHCs, FedNow): https://www.federalreserve.gov
- **CFPB** (TILA, ECOA, EFTA, FCRA; Section 1033 currently stayed): https://www.consumerfinance.gov
- **NY DFS** (BitLicense, 23 NYCRR Part 200, state-level crypto + AI + privacy enforcement): https://www.dfs.ny.gov
- **CA DFPI** (Digital Financial Assets Law effective Jul 1, 2026): https://dfpi.ca.gov

See: [[SEC]] | [[CFTC]] | [[FinCEN]] | [[OCC]] | [[FDIC]] | [[Federal-Reserve]] | [[CFPB]] | [[IRS]] | [[OFAC-Sanctions]] | [[GENIUS-Act]] | [[CLARITY-Act]] | [[Howey-Test]] | [[Reves-Test]] | [[Regulation-S]] | [[Rule-144]] | [[Rule-144A]] | [[Real-Estate-RWA-Reg-D-Reg-S-Implementation]] | [[Real-Estate-RWA-Reg-S-Affiliate-Addendum]] | [[Reg-D-Reg-A-Reg-CF]] | [[Form-1099-DA]] | [[SAB-122]] | [[Tornado-Cash-Van-Loon]] | [[NY-DFS-BitLicense]] | [[CA-DFPI-DFAL]] | [[Money-Transmitter-License]] | [[MTMA]] | [[FedNow]] | [[Section-1033-Open-Banking]] | [[Colorado-AI-Act]] | [[NYC-AEDT]] | [[GLBA]] | [[CCPA-CPRA]] | [[TILA-Reg-Z]] | [[ECOA-Reg-B]] | [[EFTA-Reg-E]] | [[Cantero-Preemption]] | [[Synapse-Evolve-BaaS]] | [[EU-Fintech-Compliance-Landscape]] | [[Stablecoin-Cross-Border-Payments]]
