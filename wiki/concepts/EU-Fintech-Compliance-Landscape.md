---
type: concept
title: "EU Fintech Compliance Landscape"
created: 2026-04-16
updated: 2026-07-11
tags:
  - EU
  - fintech
  - compliance
  - regulation
status: current
related:
  - "[[RWA-STO-EU-Compliance-Landscape]]"
  - "[[MiFID-II]]"
  - "[[MiFID-III]]"
  - "[[MiCA-Regulation]]"
  - "[[MiCA-NCA-Authorization-Mechanics]]"
  - "[[DORA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[TFR-Regulation]]"
  - "[[EU-AI-Act-Fintech]]"
  - "[[PSD3-Open-Banking-EU]]"
  - "[[IPR-Regulation]]"
  - "[[CCD2-Regulation]]"
  - "[[ESMA]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[Blockchain-Fintech-Solutions]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/sales-marketing/Service/Content/EU Compliance/EU-Compliance-Landscape.md"
    hash: "1a08da6c14ef63df509bf20cd446bf42"
    registered: 2026-05-20
    last_synced: 2026-07-11
    derived_from: this wiki concept (original direction); 2026-05-24 onward — edits flow raw → wiki per user workflow memory
    change_2026-07-11: "Re-mirrored from raw. Added a Retail Investment Strategy (RIS) row (amends MiFID II/UCITS/AIFMD/IDD/PRIIPs; €500k→€250k elective-professional; ~end-2028) and a T+1 settlement row (Reg (EU) 2025/2075, applies 11 Oct 2027) to the Key Regulations table; T+1 in Primary Sources (in-force), RIS in Proposals (COM(2023) 279)."
    purpose: "Standalone InnBlockchain-branded client-shareable artifact (frontmatter stripped, H1 shortened to 'EU Compliance Landscape'); body content kept in sync with this wiki concept. 2026-07-02 RWA/STO split: all RWA/STO-specific content (Seg 1 RWA Tokenization row, WealthTech row, RWA≠MiCA callout, AIFMD plain-words callout, Fund Classification Decision Tree, Three Roles callout, MiFID II/III detailed + AIFMD/UCITS + ELTIF 2.0 + Prospectus + MAR + EU Listing Act + DLT Pilot regulations-table rows, and their Dependency Map / Quick Reference / Primary Sources entries) moved to a NEW sibling artifact .raw/…/RWA-STO-EU-Compliance-Landscape.md, mirrored to wiki concept [[RWA-STO-EU-Compliance-Landscape]]. This file now covers generic FinTech (ExchangeTech/LendTech/WalletTech/PayTech/RegTech/BankTech/InsurTech) + Crypto Native Seg 2-10 only; RWA lane cross-referenced, not embedded. Prior sync history (all now living in the RWA-STO artifact): 2026-07-02 UCITS/ELTIF 2.0 Quick Reference + Fund Classification Decision Tree; 2026-07-01 ELTIF 2.0; 2026-06-09 AIFMD/UCITS; 2026-06-04 US-landscape-pattern Primary Sources; 2026-05-25 dedup; 2026-05-24 AML scoping + EUR-Lex Primary Sources + DORA two-pathway framing."
  - path: ".raw/InnBlockchain/sales-marketing/Service/Content/EU Compliance/RWA-STO-EU-Compliance-Landscape.md"
    hash: "6c899d1bb3a5bd770121b00aa4f36618"
    registered: 2026-07-02
    last_synced: 2026-07-11
    derived_from: split out of EU-Compliance-Landscape.md on 2026-07-02
    purpose: "RWA/STO-specific sibling artifact; mirrored to wiki concept [[RWA-STO-EU-Compliance-Landscape]]. See that page for the canonical wiki copy."
---

# EU Compliance Landscape

The EU is the world's most active jurisdiction for fintech regulation. By 2026, over 60 new or revised directives and regulations are in force. For any fintech operating in the EU or serving EU customers, compliance is not optional — it is the cost of market access.

> **RWA / Security Token Offerings:** Tokenized-securities platforms, fund structures (AIFMD/UCITS/ELTIF 2.0), and DLT venues operate in a distinct regulatory lane (MiFID II-primary, not MiCA). For RWA/STO compliance see [[RWA-STO-EU-Compliance-Landscape]].

## Key EU Fintech Regulations (2025-2026)

| Regulation | Focus | Key Deadline | Penalty |
|-----------|-------|-------------|---------|
| **MiFID II/III** | Investment services + markets | MiFID II in force since Jan 2018; MiFID III phased rollout: Sep 2025 active monitoring · Apr 2026 expanded reporting · Jun 2026 PFOF ban + consolidated tape | €44.5M EU fines in 2024 (single-year) |
| **Retail Investment Strategy (RIS)** | Omnibus investor-protection reform amending **MiFID II, UCITS, AIFMD, IDD and PRIIPs** — partial inducements ban, "value-for-money" benchmark, modernised PRIIPs KID, eased elective-professional test (portfolio €500k → **€250k** averaged over 3 yrs + new education/training alternative). Hits any firm advising on / distributing investment or insurance-based products to **retail** (WealthTech, InsurTech via IDD, packaged-product distributors) | Member-State-approved 12 Jun 2026; OJ expected H1 2026; transposition 24 mo; general application **~end-2028** (some PRIIPs bits 20 days post-OJ) | Per amended host act (MiFID II / PRIIPs / IDD) |
| **T+1 settlement (Reg (EU) 2025/2075)** | Shortens the EU securities settlement cycle from T+2 to **T+1** (amends CSDR Art 5). Relevant to firms trading/settling transferable securities (ExchangeTech if trading financial instruments); on-chain securities settlement is covered in the RWA/STO landscape | Adopted Oct 2025; applies **11 Oct 2027** | CSDR settlement-discipline regime |
| **DORA** | ICT resilience | Jan 2025 (in force) | 2% annual turnover |
| **MiCA** | Crypto-asset services | **1 Jul 2026** (transition end); white papers iXBRL-format from 23 Dec 2025 | €540M+ cumulative fines + license revocation |
| **EU AI Act** | High-risk AI systems | Aug 2, 2026 (high-risk obligations); prohibited practices already in force from Feb 2, 2025 | €35M / 7% turnover |
| **IPR** | Instant euro payments (Reg (EU) 2024/886 — amending act over SEPA Reg 260/2012, Cross-Border Payments 2021/1230, PSD2, SFD) — mandatory SCT Inst 24/7/365 + 10-sec + charge parity + VoP + daily PSU sanctions screening | Jan 2025 (receive + Art 5d daily sanctions screening) · Oct 2025 (send + VoP, euro-area CIs) · Jan 2027 (receive, non-euro CIs) · Apr 2027 (PIs/EMIs euro-area) · Jul 2027 (send, non-euro CIs + non-euro PIs/EMIs) · Jun 2028 (non-euro out-of-business-hours carve-out sunset) | ≥10% of consolidated turnover (legal person) / ≥€5M (natural person) for Art 5d breaches; general Art 5a–5c breaches: effective/proportionate/dissuasive per Member State |
| **PSD3 / PSR** | Payment services | Nov 2025 trilogue agreement; OJ publication early 2026; 21-month transposition → application late 2027 / early 2028 | TBD |
| **CCD2** | Consumer credit / BNPL — captures most third-party-financed BNPL, sub-€200 credit, free-of-interest credit, leasing-with-option-to-buy (all of which CCD1 carved out); SECCI Annex I disclosure; Art 18(8) unconditional right to human intervention in automated creditworthiness (stronger than GDPR Art 22); Art 18(3)+19(5) ban on special-category + social-network data inputs; Art 17 ban on unsolicited credit | Transposition 20 Nov 2025 (passed); **national measures apply 20 Nov 2026**; CCD1 (2008/48/EC) repealed same day | Member-State-set, **no EU ceiling** (inverse of GDPR/MiCA/DORA): "effective, proportionate, dissuasive" with wide divergence — DE criminal pathway StGB §§264a–266; IT/FR/NL admin fines in low six figures to low millions; Art 44(3) public-disclosure power |
| **EU AML / AMLA package** | Anti-money laundering — three coupled instruments doing three jobs: **AMLR** (Reg 2024/1624, rulebook, direct effect) · **AMLD6** (Dir 2024/1640, enforcement architecture, Member State transposition) · **AMLA Regulation** (Reg 2024/1620, creates the EU supervisor in Frankfurt) | AMLR application + AMLD6 transposition: **Jul 2027** · AMLA operational since **Jul 2025**; direct supervision of "selected obliged entities" begins post-2027 selection | Significant fines; AMLD6 sets the penalty regime in national law (typically up to 10% of annual turnover for credit/financial institutions) |
| **FiDA** | Open finance / data access | ~2027 (trilogue paused) | TBD |
| **eIDAS 2.0** | Digital identity wallet | Dec 31, 2026 (EU Digital Identity Wallet available across all Member States) | Sanctions or loss of authorization scope for regulated FIs that refuse to accept the EUDI Wallet when required |

**GDPR** (Regulation (EU) 2016/679) is universal across any entity processing EU residents' personal data, fintech or not. Securities-specific regimes (MiFID II/III detailed, Prospectus Reg, MAR, EU Listing Act, AIFMD/UCITS, ELTIF 2.0, DLT Pilot Regime) are covered in [[RWA-STO-EU-Compliance-Landscape]].

## Enforcement Climate

Regulatory enforcement is intensifying sharply:
- H1 2025 financial institution fines: **$1.23 billion** (+417% vs H1 2024)
- MiCA enforcement since Dec 2024: **€540M+** in fines; **50+** license revocations
- EU AI Act prohibited practices enforceable from **February 2025** (already active)
- DORA penalties up to **2% of total annual turnover** per breach

## Compliance Dependency Map

```
─── UNIVERSAL HORIZONTAL (genuinely every entity, no carve-outs) ────────────────
GDPR ───────────────► All processing of EU residents' personal data

─── BROAD-SCOPE (every regulated EU financial entity within the defined scope) ──
DORA ───────────────► All "financial entities" per Article 2: banks, PIs, EMIs,
                       investment firms, CASPs, insurers, fund managers, etc.
                       + critical ICT third-party providers (CTPPs).
                       NOT in scope: non-licensed SaaS vendors, pre-authorization
                       startups.
AML/AMLA ───────────► All "obliged entities" per AMLR Art. 3: banks, PIs, EMIs,
                       CASPs, consumer lenders, life-insurance + certain
                       financial insurance, high-value art/luxury dealers, etc.
                       AMLR + AMLD6 (national transposition) apply to every
                       obliged entity. AMLA *direct supervision* applies only
                       to "selected obliged entities" (large cross-border banks
                       and CASPs above thresholds); the rest are supervised
                       nationally under AMLD6.
                       NOT in scope: pure P&C insurance, non-fund-holding SaaS,
                       RegTech vendors (their FI customers are obliged, not
                       the vendor itself).

─── CONDITIONAL (applies only when a triggering activity is present) ────────────
MiFID II / III ─────► Investment services + financial instruments. Applies to
                       investment firms (ExchangeTech, BankTech with investment
                       services). For detailed securities-specific obligations
                       (RWA/STO platforms, fund structures, DLT venues) see
                       RWA-STO-EU-Compliance-Landscape.md.
MiCA ───────────────► Non-MiFID crypto-asset services + stablecoin issuance
                       (does NOT cover ownership-conferring RWA tokens)
AI Act ─────────────► Deploying high-risk AI (credit scoring, fraud, biometrics,
                       on-chain agents making autonomous financial decisions)
PSD3 / PSR ─────────► Payment service providers (PIs, EMIs) directly; banks
                       only for their payment-services activity (separate
                       authorization basis under CRD)
IPR ────────────────► PSPs offering euro credit transfers
FiDA ───────────────► Financial data holders (2027, trilogue paused)
eIDAS 2.0 ──────────► Any regulated FI doing customer KYC must accept the EUDI
                       Wallet as a relying party
CCD2 ───────────────► BNPL providers + consumer lenders
```

For securities/RWA-specific conditional triggers — MiFID II/III (detailed), AIFMD/UCITS, ELTIF 2.0, Prospectus Reg, MAR, EU Listing Act, DLT Pilot Regime — see [[RWA-STO-EU-Compliance-Landscape]].

> [!warning] Two common misframes to avoid
> **MiCA is not "every fintech must comply."** It only applies when the firm touches non-MiFID crypto-assets or issues a stablecoin. Pure-fiat FinTechs (PayTech, LendTech, BankTech without crypto, InsurTech) are out of MiCA scope entirely — don't lead with MiCA in those rooms.
>
> **AI Act is not "every fintech must comply" either.** It triggers on the *deployment* of high-risk AI (credit scoring, fraud detection, biometrics, autonomous financial decisions), not on the entity being a fintech. A pure-payments fintech with no AI in the stack is out.
>
> These two are the most common misclassifications in vendor risk packs and pitch decks. The Dependency Map above places both in CONDITIONAL for that reason.

## Regulation Interaction Risks

Regulations overlap and create compliance tension points:

1. **GDPR vs. AML/AMLA**: GDPR restricts personal data processing; AMLA requires extensive cross-border data sharing for AML supervision. Guidance on how to reconcile these is still being finalized.

2. **AI Act vs. DORA**: High-risk AI systems used in fintech (fraud detection, credit scoring) must satisfy both AI Act conformity requirements AND DORA operational resilience testing.

3. **MiCA vs. DORA**: MiCA Article 66 directly cross-references DORA (Regulation (EU) 2022/2554) — DORA compliance IS the mechanism for meeting MiCA's ICT obligations. **At authorization: one regulatory process, not two** — DORA readiness is assessed by the NCA as part of MiCA authorization review. **Post-authorization: DORA enforcement is independent** (up to 2% of total annual turnover, separate incident reporting timelines, separate threat-led pen testing requirements). Treat the practitioner pre-launch dossier as one workstream; treat ongoing supervision as two. See [[MiCA-NCA-Authorization-Mechanics]] for the dossier-level integration.

4. **PSD3 / FiDA overlap**: PSD3 covers payment data sharing; FiDA covers broader financial data. Both mandate standardized APIs. There is intentional design overlap; operational conflict possible.

## Compliance by ICP Segment

### Crypto Native ICP

> [!info] Reading rules for this table
> **eIDAS 2.0** applies to every CASP-classified segment that performs customer KYC (Seg 2-10) from 31 Dec 2026. Not repeated in each row — see Quick Reference. Segment rows list the *primary* obligations and any conditional triggers worth flagging at the segment level.
>
> **TFR Travel Rule** (Regulation (EU) 2023/1113): no threshold for CASP-to-CASP crypto transfers; €1,000 threshold applies only to unhosted-wallet ownership verification. Applies to **every** Seg 2-10 CASP segment. Segment cells use "Travel Rule" as shorthand.
>
> **DORA** applies to every Seg 2-10 segment that is classified as a CASP (CASPs are explicitly named in DORA Article 2(f) scope). For the grey-zone segments (Seg 5 NFT, Seg 7 DAO), DORA tracks the same fact-pattern as MiCA — if the venue is a CASP under MiCA, it's a financial entity under DORA.
>
> **AML/AMLA** in segment cells is shorthand for AMLR (Reg 2024/1624) + AMLD6 (Dir 2024/1640 as transposed) when the segment is an obliged entity under MiCA classification. The AMLA Regulation (Reg 2024/1620) does NOT trigger across all segments — AMLA *direct supervision* catches only "selected obliged entities" (large cross-border banks and CASPs above thresholds). For most Crypto Native segments, AMLA affects them indirectly via RTS/ITS standards but is supervised nationally under AMLD6. Direct AMLA supervision in Crypto Native is most plausible at Seg 2 (large cross-border CASP). Segments where obliged-entity status is itself conditional: Seg 3, 4, 7, 8, 9, 10 — see each cell's qualifier.
>
> **MAR (Market Abuse Regulation)** is instrument-based, not entity-based — **MiCA Title VI (Arts 86-92)** is the parallel market-abuse regime for Seg 2-10 MiCA crypto-assets, not MAR. MAR applies only when a financial instrument is admitted to an EU trading venue — see [[RWA-STO-EU-Compliance-Landscape]] for that trigger.

| Segment | EU Compliance Obligations |
|---|---|
| **Seg 1 — RWA Tokenization** | **MiFID II + Prospectus Regulation** (primary — ownership-conferring tokens are transferable securities, MiFID-lane not MiCA) · **AIFMD / UCITS / ELTIF 2.0** (if pooled fund vehicle) · **MAR + DLT Pilot Regime** (if admitted to trading / on-chain venue) · **DORA** · **AML/AMLA** · **eIDAS 2.0** · **GDPR**. **Full detail → [[RWA-STO-EU-Compliance-Landscape]].** |
| **Seg 2 — DEX & On-Chain Trading** | **MiCA** (CASP registration mandatory for EU-facing trading/custody) · **AML/AMLA** (CASP → AMLR obliged entity; Travel Rule; AMLA direct supervision plausible at cross-border scale) · **DORA** · **GDPR** |
| **Seg 3 — DeFi Lending & Yield** | **MiCA** (CASP if lending/yield products constitute crypto-asset services) · **AML/AMLA** (only if structured as CASP; truly decentralized DeFi with no entity operator is not an obliged entity — contested, ESMA continues to probe) · **CCD2** (applies where a consumer is the borrower; the "non-custodial" framing does not exempt the protocol where it presents/offers credit — credit-agreement layer in scope from Nov 2026) · **DORA** (if CASP) · **EU AI Act** (if AI used for credit/risk scoring — high-risk AI category) · **GDPR** |
| **Seg 4 — Non-Custodial & MPC Wallets** | **MiCA** (CASP if custody services offered; non-custodial under active scrutiny) · **AML/AMLA** (Travel Rule, if custody offered; pure non-custodial software vendor is out of obliged-entity scope) · **DORA** (if CASP) · **GDPR** |
| **Seg 5 — NFT Platforms** | **MiCA** (unique NFTs exempt; fractionalized/fungible NFTs may qualify as crypto-assets — grey zone, monitor ESMA guidance) · **AML/AMLA** (two triggers: fractionalized/fungible NFTs treated as crypto-assets → CASP under MiCA → AMLR obliged entity, *or* Art Market Participant obligations for transactions ≥ €10,000. Unique NFTs without art-market trigger: out of scope) · **DORA** (if NFT venue is a CASP — grey-zone trigger tracks MiCA) · **EU AI Act** (if AI used in pricing, recommendation, or generative NFT mechanics — secondary trigger) · **GDPR** |
| **Seg 6 — Token Launch / IDO** | **MiCA** (White Paper obligation for public crypto-asset offerings; prospectus-equivalent liability) · **Prospectus Regulation** (conditional — if the token is MiFID-classified, i.e. a security token conferring ownership / claim rather than a utility token, the MiCA white paper does NOT substitute for a prospectus; the issuer needs both a MiFID II classification analysis and a prospectus per Reg 2017/1129) · **AML/AMLA** (CASP issuer via placing of crypto-assets → AMLR obliged entity) · **DORA** (placing of crypto-assets is a Title V CASP service) · **GDPR** |
| **Seg 7 — DAO Infrastructure** | **MiCA** (governance tokens may qualify as crypto-assets) · **AML/AMLA** (only if the DAO qualifies as a CASP — pure software-vendor DAO is out; grey area, fact-specific) · **DORA** (only if the DAO is service-providing enough to qualify as a CASP — grey area, fact-specific) · **GDPR** |
| **Seg 8 — L2 & Chain Infrastructure** | **DORA** (critical ICT infrastructure, only via service-layer CASP exposure) · **MiCA** (CASP if bridge/settlement services exposed to EU users) · **AML/AMLA** (only if bridge/settlement service is a CASP — pure protocol-only L2 is not an obliged entity) · **GDPR** |
| **Seg 9 — Web3 Gaming / GameFi** | **MiCA** (in-game tokens with tradeable value) · **AML/AMLA** (only if in-game token trading enables fiat off-ramp or P2P transfer at material value → CASP → AMLR obliged entity; pure in-game economy without fiat ramp: not an obliged entity) · **DORA** (only if the GameFi venue is a CASP — tracks the same fact-pattern as MiCA / AMLR; pure in-game economy without fiat ramp is out) · **GDPR** · **EU AI Act** (if AI mechanics influence in-game purchases) |
| **Seg 10 — AI × Crypto** | **EU AI Act** (on-chain AI agents making autonomous financial decisions = high-risk AI; immutable audit trail required) · **MiCA** (if agent executes crypto-asset services) · **AML/AMLA** (only if agent-as-CASP — pure AI tooling without a CASP service relationship is out) · **DORA** · **GDPR** |

> [!NOTE] NFT Grey Zone
> MiCA explicitly excludes unique NFTs but ESMA is actively probing fractionalized NFTs and collections with fungible economics. Compliance posture for Seg 5 clients must be treated as live and evolving, not settled.

### FinTech ICP

| Segment | EU Compliance Obligations |
|---|---|
| **WealthTech (RWA / STO / Tokenized Securities)** | **MiFID II / III + Prospectus Regulation** (primary) · **AIFMD / UCITS / ELTIF 2.0** (if pooled fund vehicle) · **MAR** (once admitted to trading) · **DLT Pilot Regime** (if DLT venue) · **DORA** · **AML/AMLA** · **eIDAS 2.0** · **GDPR**. **Full detail → [[RWA-STO-EU-Compliance-Landscape]].** |
| **ExchangeTech (licensed CEX/DEX/DeFi FinTech)** | **MiCA** (CASP registration + Travel Rule) · **MiFID II / III** (if trading financial instruments — MiFID III adds PFOF ban Jun 2026, consolidated tape Jun 2026, expanded reporting Apr 2026) · **MAR (Market Abuse Regulation)** (if admitting financial instruments to trading — Art 16 venue prevention/detection, STOR workflow, market-manipulation surveillance; **MiCA Title VI Arts 86-92** is the parallel market-abuse regime for MiCA crypto-assets on the same platform) · **DORA** · **AML/AMLA** (CASP and/or investment firm → AMLR obliged entity; Travel Rule mandatory; **highly likely AMLA direct supervision** at cross-border scale — prototypical selected obliged entity for CASPs) · **eIDAS 2.0** (KYC of traders must accept the EUDI Wallet) · **GDPR** |
| **LendTech (Digital Lending / BNPL / Credit)** | **CCD2** (Consumer Credit Directive 2; in force Nov 2026) · **AML/AMLA** (consumer lender / credit institution → AMLR obliged entity; BNPL coverage depends on credit-institution classification) · **EU AI Act** (credit scoring = high-risk AI — immutable audit trail required) · **DORA** (if credit institution or PI license held) · **eIDAS 2.0** (borrower KYC must accept the EUDI Wallet) · **GDPR** |
| **WalletTech (regulated e-money / payment wallets)** | **PSD3 / PSR** (payment services authorization) · **IPR** (conditional — if the wallet offers euro credit transfers via its EMI/PI rails, mandatory from Oct 2025; CASP-only wallets with no PSD2 authorisation are out of IPR scope) · **MiCA** (if crypto wallet feature added) · **DORA** (PSD3-authorized PIs and EMIs are explicitly in DORA scope per Article 2) · **eIDAS 2.0** (digital identity for wallet authentication + KYC acceptance) · **AML/AMLA** (EMI / PI → AMLR obliged entity; with crypto wallet feature → additionally CASP-obliged and Travel Rule applies) · **GDPR** |
| **PayTech (Payments / Remittance)** | **PSD3 / PSR** · **IPR** (Instant Payments Regulation — mandatory euro credit transfers from Oct 2025) · **DORA** (PSPs explicitly in DORA scope per Article 2) · **AML/AMLA** (PI → AMLR obliged entity; AMLA direct supervision possible for large cross-border PSPs, otherwise national supervision under AMLD6) · **eIDAS 2.0** (sender/receiver KYC must accept the EUDI Wallet) · **GDPR** |
| **RegTech (KYC/AML tooling)** | **AML/AMLA** (indirect — RegTech vendors are SaaS *to* financial institutions, not obliged entities themselves under AMLR Art. 3; the vendor doesn't carry its own AMLR/AMLD6 obligations, but tooling must support customer compliance with CDD/STR/Travel Rule. Direct obligation only if the RegTech also operates as a regulated FI itself) · **EU AI Act** (KYC/fraud detection AI = high-risk — this is the RegTech vendor's *primary direct* obligation) · **DORA** (conditional — applies via the critical-third-party ICT provider (CTPP) pathway if the RegTech vendor serves enough EU financial entities to be designated critical; doesn't apply to small/single-customer vendors) · **eIDAS 2.0** (indirect — RegTech tooling itself isn't a relying party, but must support the EUDI Wallet so its FI customers can comply) · **GDPR** |
| **BankTech (Neo-banks / Core Banking)** | **DORA** · **PSD3 / PSR** · **IPR** (mandatory for credit institutions offering euro credit transfers — Oct 2025) · **CCD2** (if the bank offers consumer credit — overdrafts under Art. 3(18), personal loans, embedded BNPL; in force Nov 2026) · **AML/AMLA** (credit institution → AMLR obliged entity; **highly likely AMLA direct supervision** for large cross-border banks — prototypical selected obliged entity) · **MiFID II / III** (if investment services offered) · **MiCA** (if crypto product added) · **eIDAS 2.0** (account-opening KYC must accept the EUDI Wallet) · **GDPR** |
| **InsurTech** | **DORA** · **AML/AMLA** (life + certain financial insurance products → AMLR obliged entity; pure P&C insurance generally out of scope — assess product-by-product) · **EU AI Act** (underwriting AI = high-risk) · **eIDAS 2.0** (policyholder KYC must accept the EUDI Wallet) · **GDPR** |

### Quick Reference: Primary Regulatory Trigger by Segment

*Cells show where each regulation is the **dominant framing** for that segment, plus secondary triggers in parentheses. GDPR is the only genuinely universal regime; DORA and AML/AMLA are broad-scope but bounded by DORA Article 2 / AMLR Article 3 obliged-entity definitions — see Dependency Map for the scope of each.*

| Regulation | Crypto Native ICP | FinTech ICP |
|---|---|---|
| **MiCA** | Seg 2-10 primary; Seg 6 IDO also conditional if token is security-classified (MiCA white paper does NOT substitute for a prospectus) | ExchangeTech, WalletTech (with crypto), BankTech (with crypto); WealthTech only if non-MiFID crypto-asset side — see RWA-STO file |
| **MiFID II / III** | Seg 1 RWA (primary) → see RWA-STO file; Seg 6 IDO only if the token is a MiFID-classified security. Most Seg 2-10 are MiCA crypto-assets, not MiFID financial instruments. MiFID III: PFOF ban Jun 2026, consolidated tape Jun 2026, expanded reporting Apr 2026 | ExchangeTech (if trading financial instruments), BankTech (if investment services offered); WealthTech (primary) → see RWA-STO file |
| **Prospectus Regulation** | Seg 6 IDO (conditional — if token is MiFID-classified security, MiCA white paper does NOT substitute); Seg 7 DAO if governance tokens confer economic rights — fact-specific | WealthTech (primary) → see RWA-STO file; ExchangeTech indirectly (must verify compliant prospectus exists before admitting a security token to trading) |
| **MAR (Market Abuse Regulation)** | Seg 6 IDO conditional (only if token is MiFID-classified AND subsequently admitted to trading); Seg 7 DAO fact-specific. **Seg 2-10 out of MAR scope** — MiCA Title VI (Arts 86-92) is the parallel market-abuse regime | WealthTech (primary once admitted) → see RWA-STO file; ExchangeTech (venue Art 16 surveillance + STORs if admitting financial instruments). All other FinTech segments out of scope unless they admit financial instruments to trading |
| **AML / AMLA** | **Obliged-entity coverage (AMLR + AMLD6):** Seg 2, 6 full CASP coverage; Seg 3, 4, 7, 8, 9, 10 conditional on CASP classification under MiCA (truly decentralized DeFi / pure non-custodial / pure-software DAO / pure L2 protocol / pure in-game economy without fiat ramp / pure AI tooling are out); Seg 5 conditional on fractionalized/fungible status or Art Market Participant ≥€10k trigger. **AMLA direct supervision (Reg 2024/1620):** narrow — most plausible at Seg 2 large cross-border CASPs; rest supervised nationally under AMLD6 transposition | **Obliged entities (AMLR + AMLD6):** ExchangeTech (CASP/investment firm), LendTech (consumer lender / credit institution), WalletTech (EMI/PI/CASP), PayTech (PI), BankTech (credit institution); InsurTech limited to life + certain financial insurance products (pure P&C out); **RegTech NOT an obliged entity itself** — SaaS to FIs, indirect only. **AMLA direct supervision:** prototypical for ExchangeTech and BankTech at cross-border scale; the rest are supervised nationally |
| **DORA** | **All CASP segments (Seg 2-10)** via Art. 2(f) — CASPs explicitly named in DORA scope; Seg 9 GameFi tracks the same conditional fact-pattern as MiCA (CASP-classified only); most material at Seg 8 (critical ICT infra) and Seg 10 (AI agents executing services) | All in DORA Article 2 scope via their own entity type: BankTech (credit institutions), InsurTech (insurers), ExchangeTech (CASPs), WalletTech + PayTech (PIs/EMIs). LendTech conditional — only if credit institution or PI license held. RegTech conditional — only via the CTPP designation pathway, which is a narrow process applied to ICT vendors serving multiple financial entities; most RegTech vendors are out. WealthTech (investment firms) — see RWA-STO file |
| **EU AI Act** | Seg 3 DeFi Lending + Seg 10 AI×Crypto (primary); secondary at Seg 5 (AI in NFT mechanics), Seg 9 (AI in gaming purchases) | LendTech, RegTech, InsurTech, BankTech (all primary — high-risk AI in core function) |
| **PSD3 / PSR** | — | PayTech, WalletTech, BankTech |
| **IPR** | — | PayTech (mandatory); BankTech (mandatory — credit institutions); WalletTech (conditional — if wallet offers euro credit transfers via EMI/PI rails) |
| **CCD2** | Seg 3 DeFi Lending (conditional — if consumer is the borrower; non-custodial framing does not exempt). Indirect at Seg 5 / Seg 10 — fiat-onramp consumer lending wrapping DeFi where a consumer-as-borrower exists and an identifiable creditor is on the other side; pure protocol-level over-collateralised loans without a counterparty creditor are in a contested zone | LendTech (primary); BankTech (if offering consumer credit — overdrafts, personal loans, embedded BNPL); secondary at WalletTech if a credit-line feature wraps the wallet |
| **eIDAS 2.0** | All CASP-classified segments (Seg 2-10) that perform customer KYC — must accept EUDI Wallet as relying party from 31 Dec 2026 | All FinTech segments with consumer KYC: ExchangeTech, LendTech, WalletTech, PayTech, BankTech, InsurTech (RegTech indirect — supports its FI customers' compliance, not a relying party itself). WealthTech (investor KYC) — see RWA-STO file |
| **GDPR** | All segments | All segments |

## InnBlockchain Relevance

EU compliance is a direct revenue driver for InnBlockchain:
- **FinTech ICP**: Compliance Carol (CCO) is the regulatory veto-holder. Vendor risk pack contents are segment-scoped — **all FinTech segments**: ISO/SOC 2, data residency, GDPR processing. **DORA third-party clauses** for all *licensed* financial entities (which is most FinTech segments: BankTech, InsurTech, ExchangeTech, WalletTech, PayTech). RegTech only carries DORA via the CTPP pathway if designated critical; LendTech only if it holds a credit-institution / PI license alongside CCD2. **Only if the FinTech touches non-MiFID crypto-assets** (ExchangeTech, WalletTech with crypto, BankTech with crypto product): add MiCA compliance context. Pure-fiat PayTech, LendTech, RegTech, InsurTech are out of MiCA scope — do not lead with MiCA in those rooms.
- **Crypto Native ICP (Seg 2-10)**: MiCA is the dominant framing. For RWA/STO tokenization (MiFID-primary, DLT Pilot Regime, AIFMD/UCITS/ELTIF 2.0) see [[RWA-STO-EU-Compliance-Landscape]].
- **AI+Blockchain opportunity**: EU AI Act mandates on-chain audit trails for high-risk AI decisions (credit scoring, fraud) — direct use case for blockchain-based compliance infrastructure across LendTech, RegTech, and Seg 10 AI×Crypto

## Primary Sources

Citations use EUR-Lex ELI URLs (the canonical, version-stable form). Supervisor pages are listed separately because that's where RTS/ITS, Q&As, and deadline updates publish post-adoption.

### Legislation in force

| Regulation | Instrument | Official source |
|---|---|---|
| MiFID II | Directive 2014/65/EU | https://eur-lex.europa.eu/eli/dir/2014/65/oj |
| MiFIR | Regulation (EU) 600/2014 | https://eur-lex.europa.eu/eli/reg/2014/600/oj |
| MAR (Market Abuse Regulation) | Regulation (EU) No 596/2014 | https://eur-lex.europa.eu/eli/reg/2014/596/oj |
| MiFID III review — Directive | Directive (EU) 2024/790 | https://eur-lex.europa.eu/eli/dir/2024/790/oj |
| MiFID III review — Regulation | Regulation (EU) 2024/791 | https://eur-lex.europa.eu/eli/reg/2024/791/oj |
| DORA | Regulation (EU) 2022/2554 | https://eur-lex.europa.eu/eli/reg/2022/2554/oj |
| MiCA | Regulation (EU) 2023/1114 | https://eur-lex.europa.eu/eli/reg/2023/1114/oj |
| TFR (Travel Rule) | Regulation (EU) 2023/1113 | https://eur-lex.europa.eu/eli/reg/2023/1113/oj |
| EU AI Act | Regulation (EU) 2024/1689 | https://eur-lex.europa.eu/eli/reg/2024/1689/oj |
| IPR (Instant Payments) | Regulation (EU) 2024/886 | https://eur-lex.europa.eu/eli/reg/2024/886/oj |
| CCD2 | Directive (EU) 2023/2225 | https://eur-lex.europa.eu/eli/dir/2023/2225/oj |
| AMLR (single rulebook) | Regulation (EU) 2024/1624 | https://eur-lex.europa.eu/eli/reg/2024/1624/oj |
| AMLD6 | Directive (EU) 2024/1640 | https://eur-lex.europa.eu/eli/dir/2024/1640/oj |
| AMLA Regulation | Regulation (EU) 2024/1620 | https://eur-lex.europa.eu/eli/reg/2024/1620/oj |
| eIDAS 2.0 | Regulation (EU) 2024/1183 | https://eur-lex.europa.eu/eli/reg/2024/1183/oj |
| GDPR | Regulation (EU) 2016/679 | https://eur-lex.europa.eu/eli/reg/2016/679/oj |
| T+1 settlement cycle (amends CSDR) | Regulation (EU) 2025/2075 | https://eur-lex.europa.eu/eli/reg/2025/2075/oj |

For RWA-specific primary sources (AIFMD/UCITS, ELTIF 2.0, Prospectus Reg, MAR, EU Listing Act, DLT Pilot Regime, MiFID II/III securities-specific instruments) see [[RWA-STO-EU-Compliance-Landscape]].

### Proposals not yet in the OJ (re-check before citing)

| File | Commission proposal | Official source |
|---|---|---|
| Retail Investment Strategy (RIS) — **approved 12 Jun 2026, OJ pending** | COM(2023) 279 final (amending Directive + Regulation) | https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:52023PC0279 |
| PSD3 (Directive) | COM(2023) 367 final | https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:52023PC0367 |
| PSR (Regulation) | COM(2023) 366 final | https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:52023PC0366 |
| FiDA | COM(2023) 360 final | https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:52023PC0360 |

### Supervisors and authority pages

Where RTS/ITS, Q&As, transitional guidance, and enforcement statistics publish:

- **ESMA** (MiCA, MiFID II/III): https://www.esma.europa.eu
  - MiCA hub: https://www.esma.europa.eu/esmas-activities/digital-finance-and-innovation/markets-crypto-assets-regulation-mica
- **EBA** (DORA joint ESAs, PSD3/PSR, AML transition): https://www.eba.europa.eu
  - DORA: https://www.eba.europa.eu/regulation-and-policy/digital-operational-resilience-act-dora
- **EIOPA** (InsurTech, DORA insurance pathway): https://www.eiopa.europa.eu
- **AMLA** (Frankfurt, operational since Jul 2025): https://anti-money-laundering-authority.europa.eu
- **ENISA** (DORA technical incident reporting): https://www.enisa.europa.eu
- **EDPB** (GDPR ↔ AML reconciliation, GDPR ↔ AI Act): https://www.edpb.europa.eu
- **EU AI Office** (AI Act enforcement, codes of practice): https://digital-strategy.ec.europa.eu/en/policies/ai-office
- **ECB** (IPR, eurozone payments oversight): https://www.ecb.europa.eu
- **Commission — payments package tracker** (PSD3/PSR/FiDA status): https://finance.ec.europa.eu/publications/financial-data-access-and-payments-package_en

See: [[MiFID-II]] | [[MiFID-III]] | [[MiCA-Regulation]] | [[MiCA-NCA-Authorization-Mechanics]] | [[DORA-Regulation]] | [[EU-AML-AMLA]] | [[EU-AI-Act-Fintech]] | [[PSD3-Open-Banking-EU]] | [[ESMA]] | [[RWA-STO-EU-Compliance-Landscape]]
