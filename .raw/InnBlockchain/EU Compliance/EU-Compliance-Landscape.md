# EU Compliance Landscape

The EU is the world's most active jurisdiction for fintech regulation. By 2026, over 60 new or revised directives and regulations are in force. For any fintech operating in the EU or serving EU customers, compliance is not optional — it is the cost of market access.

## The Ten Key Regulations (2025-2026)

| Regulation | Focus | Key Deadline | Penalty |
|-----------|-------|-------------|---------|
| **MiFID II/III** | Investment services + markets | MiFID II in force since Jan 2018; MiFID III phased rollout: Sep 2025 active monitoring · Apr 2026 expanded reporting · Jun 2026 PFOF ban + consolidated tape | €44.5M EU fines in 2024 (single-year) |
| **DORA** | ICT resilience | Jan 2025 (in force) | 2% annual turnover |
| **MiCA** | Crypto-asset services | **1 Jul 2026** (transition end); white papers iXBRL-format from 23 Dec 2025 | €540M+ cumulative fines + license revocation |
| **EU AI Act** | High-risk AI systems | Aug 2, 2026 (high-risk obligations); prohibited practices already in force from Feb 2, 2025 | €35M / 7% turnover |
| **IPR** | Instant euro payments | Oct 2025 (send + VoP) | Regulatory action |
| **PSD3 / PSR** | Payment services | Nov 2025 trilogue agreement; OJ publication early 2026; 21-month transposition → application late 2027 / early 2028 | TBD |
| **CCD2** | Consumer credit / BNPL | Nov 20, 2026 | TBD |
| **EU AML / AMLA package** | Anti-money laundering — three coupled instruments doing three jobs: **AMLR** (Reg 2024/1624, rulebook, direct effect) · **AMLD6** (Dir 2024/1640, enforcement architecture, Member State transposition) · **AMLA Regulation** (Reg 2024/1620, creates the EU supervisor in Frankfurt) | AMLR application + AMLD6 transposition: **Jul 2027** · AMLA operational since **Jul 2025**; direct supervision of "selected obliged entities" begins post-2027 selection | Significant fines; AMLD6 sets the penalty regime in national law (typically up to 10% of annual turnover for credit/financial institutions) |
| **FiDA** | Open finance / data access | ~2027 (trilogue paused) | TBD |
| **eIDAS 2.0** | Digital identity wallet | Dec 31, 2026 (EU Digital Identity Wallet available across all Member States) | Sanctions or loss of authorization scope for regulated FIs that refuse to accept the EUDI Wallet when required |

Two further regimes also apply but sit outside the "ten" because they trigger differently — **GDPR** (Regulation (EU) 2016/679) is universal across any entity processing EU residents' personal data, fintech or not; **DLT Pilot Regime** (Regulation (EU) 2022/858) is a conditional infrastructure sandbox for tokenized-securities trading + settlement (DLT MTF / SS / TSS; permanence package proposed April 2026). Both are mapped in the Dependency Map below.

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
MiFID II / III ─────► Investment services + financial instruments
                       (includes ownership-conferring tokenized securities)
MiCA ───────────────► Non-MiFID crypto-asset services + stablecoin issuance
                       (does NOT cover ownership-conferring RWA tokens)
DLT Pilot Regime ───► On-chain tokenized securities trading + settlement infra
                       (DLT MTF / SS / TSS — sandbox path)
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
> **TFR Travel Rule** (Regulation (EU) 2023/1113): no threshold for CASP-to-CASP crypto transfers; €1,000 threshold applies only to unhosted-wallet ownership verification. Applies to **every** Seg 2-10 CASP segment. Does **NOT** apply to Seg 1 unless the firm also operates a CASP side — MiFID-classified tokens aren't crypto-assets under MiCA, so the TFR mechanism doesn't reach them. Segment cells use "Travel Rule" as shorthand; Seg 1 retains the explicit disclaimer because the RWA misframe lives there.
>
> **DORA** applies via two pathways: (a) every Seg 2-10 segment that is classified as a CASP (CASPs are explicitly named in DORA Article 2(f) scope), and (b) Seg 1 RWA platforms via the MiFID II investment-firm / DLT Pilot Regime trading-venue or CSD pathway (DORA Article 2(e), (g), (i)) — the Seg 1 firm doesn't need to be a CASP to be in scope. For the grey-zone segments (Seg 5 NFT, Seg 7 DAO), DORA tracks the same fact-pattern as MiCA — if the venue is a CASP under MiCA, it's a financial entity under DORA.
>
> **AML/AMLA** in segment cells is shorthand for AMLR (Reg 2024/1624) + AMLD6 (Dir 2024/1640 as transposed) when the segment is an obliged entity under MiCA / MiFID II classification. The AMLA Regulation (Reg 2024/1620) does NOT trigger across all segments — AMLA *direct supervision* catches only "selected obliged entities" (large cross-border banks and CASPs above thresholds). For most Crypto Native segments, AMLA affects them indirectly via RTS/ITS standards but is supervised nationally under AMLD6. Direct AMLA supervision in Crypto Native is most plausible at Seg 2 (large cross-border CASP). Segments where obliged-entity status is itself conditional: Seg 3, 4, 7, 8, 9, 10 — see each cell's qualifier.

| Segment | EU Compliance Obligations |
|---|---|
| **Seg 1 — RWA Tokenization** | **MiFID II + Prospectus Regulation** (primary — any token conferring ownership / claim on issuer or underlying asset is a transferable security regardless of yield; MiCA Art. 2(4) carve-out applies) · **MiFID III** (if operating a DLT MTF / SS / TSS — expanded reporting from Apr 2026, transparency rules from Mar 2026, PFOF ban Jun 2026; pure token issuers with no trading venue are not directly in scope) · **DLT Pilot Regime** (DLT MTF / SS / TSS for tokenized securities trading + settlement — the real on-chain infra path, not MiCA) · **MiCA** (only if token is an **Asset-Referenced Token** — references value without conferring ownership — *or* if the firm also provides CASP services for non-MiFID crypto-assets; CASP licensing is service-level and independent of token classification) · **DORA** (ICT resilience for the platform) · **AML/AMLA** (CDD + KYC + STR via **AMLR** on the issuer/platform as a MiFID II investment firm; **TFR Travel Rule does NOT apply** because MiFID-classified tokens aren't crypto-assets under MiCA — only the CASP side, if present, triggers TFR. AMLA direct supervision: only if cross-border + large) · **eIDAS 2.0** (KYC of investors must accept the EUDI Wallet as relying party) · **GDPR** · **EU AI Act** (if AI used for asset valuation or oracle inputs) |
| **Seg 2 — DEX & On-Chain Trading** | **MiCA** (CASP registration mandatory for EU-facing trading/custody) · **AML/AMLA** (CASP → AMLR obliged entity; Travel Rule; AMLA direct supervision plausible at cross-border scale) · **DORA** · **GDPR** |
| **Seg 3 — DeFi Lending & Yield** | **MiCA** (CASP if lending/yield products constitute crypto-asset services) · **AML/AMLA** (only if structured as CASP; truly decentralized DeFi with no entity operator is not an obliged entity — contested, ESMA continues to probe) · **DORA** (if CASP) · **EU AI Act** (if AI used for credit/risk scoring — high-risk AI category) · **GDPR** |
| **Seg 4 — Non-Custodial & MPC Wallets** | **MiCA** (CASP if custody services offered; non-custodial under active scrutiny) · **AML/AMLA** (Travel Rule, if custody offered; pure non-custodial software vendor is out of obliged-entity scope) · **DORA** (if CASP) · **GDPR** |
| **Seg 5 — NFT Platforms** | **MiCA** (unique NFTs exempt; fractionalized/fungible NFTs may qualify as crypto-assets — grey zone, monitor ESMA guidance) · **AML/AMLA** (two triggers: fractionalized/fungible NFTs treated as crypto-assets → CASP under MiCA → AMLR obliged entity, *or* Art Market Participant obligations for transactions ≥ €10,000. Unique NFTs without art-market trigger: out of scope) · **DORA** (if NFT venue is a CASP — grey-zone trigger tracks MiCA) · **EU AI Act** (if AI used in pricing, recommendation, or generative NFT mechanics — secondary trigger) · **GDPR** |
| **Seg 6 — Token Launch / IDO** | **MiCA** (White Paper obligation for public crypto-asset offerings; prospectus-equivalent liability) · **AML/AMLA** (CASP issuer via placing of crypto-assets → AMLR obliged entity) · **DORA** (placing of crypto-assets is a Title V CASP service) · **GDPR** |
| **Seg 7 — DAO Infrastructure** | **MiCA** (governance tokens may qualify as crypto-assets) · **AML/AMLA** (only if the DAO qualifies as a CASP — pure software-vendor DAO is out; grey area, fact-specific) · **DORA** (only if the DAO is service-providing enough to qualify as a CASP — grey area, fact-specific) · **GDPR** |
| **Seg 8 — L2 & Chain Infrastructure** | **DORA** (critical ICT infrastructure, only via service-layer CASP exposure) · **MiCA** (CASP if bridge/settlement services exposed to EU users) · **AML/AMLA** (only if bridge/settlement service is a CASP — pure protocol-only L2 is not an obliged entity) · **GDPR** |
| **Seg 9 — Web3 Gaming / GameFi** | **MiCA** (in-game tokens with tradeable value) · **AML/AMLA** (only if in-game token trading enables fiat off-ramp or P2P transfer at material value → CASP → AMLR obliged entity; pure in-game economy without fiat ramp: not an obliged entity) · **GDPR** · **EU AI Act** (if AI mechanics influence in-game purchases) |
| **Seg 10 — AI × Crypto** | **EU AI Act** (on-chain AI agents making autonomous financial decisions = high-risk AI; immutable audit trail required) · **MiCA** (if agent executes crypto-asset services) · **AML/AMLA** (only if agent-as-CASP — pure AI tooling without a CASP service relationship is out) · **DORA** · **GDPR** |

> [!NOTE] NFT Grey Zone
> MiCA explicitly excludes unique NFTs but ESMA is actively probing fractionalized NFTs and collections with fungible economics. Compliance posture for Seg 5 clients must be treated as live and evolving, not settled.

> [!WARNING] RWA ≠ MiCA — Common Misframe
> MiCA does not "cover" RWA tokenization by default. Token classification is mutually exclusive between MiFID II and MiCA (Article 2(4)):
> - **Ownership-conferring token** (fractional real estate, tokenized bond/equity, revenue claim) → **MiFID II financial instrument**, regardless of whether yield is distributed. Path: Prospectus Regulation + DLT Pilot Regime + DORA.
> - **Value-referencing token without ownership** (basket-pegged, asset-backed stable value) → **MiCA Asset-Referenced Token (ART)**. Different category, narrow use case.
> - **CASP authorization under MiCA** is a *service-level* license (custody, trading, exchange) and can still apply to a firm whose primary token is MiFID-classified — but only if that firm also services non-MiFID crypto-assets.
>
> Selling MiCA-as-RWA-cover to a Seg 1 prospect is a credibility risk: wrong regulatory regime (MiFID II under prospectus + ESMA convergence vs MiCA white-paper regime — both supervised by the same national NCAs, but the substantive obligations diverge), wrong offering document (prospectus vs white paper), wrong infrastructure path (DLT Pilot Regime vs CASP authorization).

### FinTech ICP

| Segment | EU Compliance Obligations |
|---|---|
| **WealthTech (RWA / STO / Tokenized Securities)** | **MiFID II / III** (primary — financial instrument classification; investment services authorization) · **Prospectus Regulation** (for any token conferring ownership / claim on issuer or underlying asset) · **DLT Pilot Regime** (if building DLT MTF/SS/TSS) · **MiCA** (only if firm also services **non-MiFID** crypto-assets — stablecoins, utility tokens — on the side; does not cover the tokenized-securities side itself) · **DORA** · **AML/AMLA** (investment firm → AMLR obliged entity; AMLA direct supervision possible if cross-border + large AUM) · **eIDAS 2.0** (KYC of investors must accept the EUDI Wallet) · **GDPR** · **EU AI Act** (if AI used in portfolio or risk management) |
| **ExchangeTech (licensed CEX/DEX/DeFi FinTech)** | **MiCA** (CASP registration + Travel Rule) · **MiFID II / III** (if trading financial instruments — MiFID III adds PFOF ban Jun 2026, consolidated tape Jun 2026, expanded reporting Apr 2026) · **DORA** · **AML/AMLA** (CASP and/or investment firm → AMLR obliged entity; Travel Rule mandatory; **highly likely AMLA direct supervision** at cross-border scale — prototypical selected obliged entity for CASPs) · **eIDAS 2.0** (KYC of traders must accept the EUDI Wallet) · **GDPR** |
| **LendTech (Digital Lending / BNPL / Credit)** | **CCD2** (Consumer Credit Directive 2; in force Nov 2026) · **AML/AMLA** (consumer lender / credit institution → AMLR obliged entity; BNPL coverage depends on credit-institution classification) · **EU AI Act** (credit scoring = high-risk AI — immutable audit trail required) · **DORA** (if credit institution or PI license held) · **eIDAS 2.0** (borrower KYC must accept the EUDI Wallet) · **GDPR** |
| **WalletTech (regulated e-money / payment wallets)** | **PSD3 / PSR** (payment services authorization) · **MiCA** (if crypto wallet feature added) · **DORA** (PSD3-authorized PIs and EMIs are explicitly in DORA scope per Article 2) · **eIDAS 2.0** (digital identity for wallet authentication + KYC acceptance) · **AML/AMLA** (EMI / PI → AMLR obliged entity; with crypto wallet feature → additionally CASP-obliged and Travel Rule applies) · **GDPR** |
| **PayTech (Payments / Remittance)** | **PSD3 / PSR** · **IPR** (Instant Payments Regulation — mandatory euro credit transfers from Oct 2025) · **DORA** (PSPs explicitly in DORA scope per Article 2) · **AML/AMLA** (PI → AMLR obliged entity; AMLA direct supervision possible for large cross-border PSPs, otherwise national supervision under AMLD6) · **eIDAS 2.0** (sender/receiver KYC must accept the EUDI Wallet) · **GDPR** |
| **RegTech (KYC/AML tooling)** | **AML/AMLA** (indirect — RegTech vendors are SaaS *to* financial institutions, not obliged entities themselves under AMLR Art. 3; the vendor doesn't carry its own AMLR/AMLD6 obligations, but tooling must support customer compliance with CDD/STR/Travel Rule. Direct obligation only if the RegTech also operates as a regulated FI itself) · **EU AI Act** (KYC/fraud detection AI = high-risk — this is the RegTech vendor's *primary direct* obligation) · **DORA** (conditional — applies via the critical-third-party ICT provider (CTPP) pathway if the RegTech vendor serves enough EU financial entities to be designated critical; doesn't apply to small/single-customer vendors) · **eIDAS 2.0** (indirect — RegTech tooling itself isn't a relying party, but must support the EUDI Wallet so its FI customers can comply) · **GDPR** |
| **BankTech (Neo-banks / Core Banking)** | **DORA** · **PSD3 / PSR** · **AML/AMLA** (credit institution → AMLR obliged entity; **highly likely AMLA direct supervision** for large cross-border banks — prototypical selected obliged entity) · **MiFID II / III** (if investment services offered) · **MiCA** (if crypto product added) · **eIDAS 2.0** (account-opening KYC must accept the EUDI Wallet) · **GDPR** |
| **InsurTech** | **DORA** · **AML/AMLA** (life + certain financial insurance products → AMLR obliged entity; pure P&C insurance generally out of scope — assess product-by-product) · **EU AI Act** (underwriting AI = high-risk) · **eIDAS 2.0** (policyholder KYC must accept the EUDI Wallet) · **GDPR** |

### Quick Reference: Primary Regulatory Trigger by Segment

*Cells show where each regulation is the **dominant framing** for that segment, plus secondary triggers in parentheses. GDPR is the only genuinely universal regime; DORA and AML/AMLA are broad-scope but bounded by DORA Article 2 / AMLR Article 3 obliged-entity definitions — see Dependency Map for the scope of each.*

| Regulation | Crypto Native ICP | FinTech ICP |
|---|---|---|
| **MiCA** | Seg 2-10 primary; Seg 1 only if ART or CASP services on non-MiFID assets | ExchangeTech, WalletTech (with crypto), BankTech (with crypto); WealthTech only if non-MiFID crypto-asset side |
| **MiFID II / III** | Seg 1 RWA primary (ownership tokens are securities by default) | WealthTech (primary), ExchangeTech (if trading financial instruments) |
| **DLT Pilot Regime** | Seg 1 RWA (DLT MTF / SS / TSS — the real on-chain securities infra path) | WealthTech (primary — DLT MTF/SS/TSS) |
| **AML / AMLA** | **Obliged-entity coverage (AMLR + AMLD6):** Seg 1 (AMLR obliged entity — investment firm / securities issuer, not CASP-classified); Seg 2, 6 full CASP coverage; Seg 3, 4, 7, 8, 9, 10 conditional on CASP classification under MiCA (truly decentralized DeFi / pure non-custodial / pure-software DAO / pure L2 protocol / pure in-game economy without fiat ramp / pure AI tooling are out); Seg 5 conditional on fractionalized/fungible status or Art Market Participant ≥€10k trigger. **AMLA direct supervision (Reg 2024/1620):** narrow — most plausible at Seg 2 large cross-border CASPs; rest supervised nationally under AMLD6 transposition | **Obliged entities (AMLR + AMLD6):** WealthTech (investment firm), ExchangeTech (CASP/investment firm), LendTech (consumer lender / credit institution), WalletTech (EMI/PI/CASP), PayTech (PI), BankTech (credit institution); InsurTech limited to life + certain financial insurance products (pure P&C out); **RegTech NOT an obliged entity itself** — SaaS to FIs, indirect only. **AMLA direct supervision:** prototypical for ExchangeTech and BankTech at cross-border scale; the rest are supervised nationally |
| **DORA** | **Seg 1 RWA** via MiFID II investment-firm / DLT Pilot Regime trading-venue or CSD pathway (DORA Art. 2(e), (g), (i)); **all CASP segments (Seg 2-10)** via Art. 2(f) — CASPs explicitly named in DORA scope; most material at Seg 8 (critical ICT infra) and Seg 10 (AI agents executing services) | All in DORA Article 2 scope via their own entity type: BankTech (credit institutions), InsurTech (insurers), WealthTech (investment firms), ExchangeTech (CASPs), WalletTech + PayTech (PIs/EMIs). LendTech conditional — only if credit institution or PI license held. RegTech conditional — only via the CTPP designation pathway, which is a narrow process applied to ICT vendors serving multiple financial entities; most RegTech vendors are out |
| **EU AI Act** | Seg 3 DeFi Lending + Seg 10 AI×Crypto (primary); secondary at Seg 1 (AI for asset valuation / oracles), Seg 5 (AI in NFT mechanics), Seg 9 (AI in gaming purchases) | LendTech, RegTech, InsurTech, BankTech (all primary — high-risk AI in core function) |
| **PSD3 / PSR** | — | PayTech, WalletTech, BankTech |
| **IPR** | — | PayTech (mandatory) |
| **CCD2** | — | LendTech |
| **eIDAS 2.0** | All CASP-classified segments (Seg 2-10) that perform customer KYC — must accept EUDI Wallet as relying party from 31 Dec 2026; also Seg 1 RWA platforms doing investor KYC | All FinTech segments with consumer KYC: WealthTech, ExchangeTech, LendTech, WalletTech, PayTech, BankTech, InsurTech (RegTech indirect — supports its FI customers' compliance, not a relying party itself) |
| **GDPR** | All segments | All segments |

> [!TIP] DLT Pilot Regime Sales Hook
> The 10 pending DLT Pilot applications (including Securitize, Spain) are warm prospects — firms that have decided to pursue DLT Pilot status but haven't built the infrastructure. Highest-intent leads for InnBlockchain's dev/audit motion across both ICPs.

## InnBlockchain Relevance

EU compliance is a direct revenue driver for InnBlockchain:
- **FinTech ICP**: Compliance Carol (CCO) is the regulatory veto-holder. Vendor risk pack contents are segment-scoped — **all FinTech segments**: ISO/SOC 2, data residency, GDPR processing. **DORA third-party clauses** for all *licensed* financial entities (which is most FinTech segments: BankTech, InsurTech, WealthTech, ExchangeTech, WalletTech, PayTech). RegTech only carries DORA via the CTPP pathway if designated critical; LendTech only if it holds a credit-institution / PI license alongside CCD2. **Only if the FinTech touches non-MiFID crypto-assets** (ExchangeTech, WalletTech with crypto, BankTech with crypto product, WealthTech with stablecoin/utility-token side): add MiCA compliance context. Pure-fiat PayTech, LendTech, RegTech, InsurTech are out of MiCA scope — do not lead with MiCA in those rooms.
- **Crypto Native ICP**: MiCA is the dominant framing for Seg 2-10; **Seg 1 RWA is MiFID-primary, not MiCA** — DLT Pilot Regime is both the correct infra path and the highest-intent sales hook (10 pending applications including Securitize / Spain)
- **AI+Blockchain opportunity**: EU AI Act mandates on-chain audit trails for high-risk AI decisions (credit scoring, fraud) — direct use case for blockchain-based compliance infrastructure across LendTech, RegTech, and Seg 10 AI×Crypto

## Primary Sources

Citations use EUR-Lex ELI URLs (the canonical, version-stable form). Supervisor pages are listed separately because that's where RTS/ITS, Q&As, and deadline updates publish post-adoption.

### Legislation in force

| Regulation | Instrument | Official source |
|---|---|---|
| MiFID II | Directive 2014/65/EU | https://eur-lex.europa.eu/eli/dir/2014/65/oj |
| MiFIR | Regulation (EU) 600/2014 | https://eur-lex.europa.eu/eli/reg/2014/600/oj |
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
| DLT Pilot Regime | Regulation (EU) 2022/858 | https://eur-lex.europa.eu/eli/reg/2022/858/oj |
| Prospectus Regulation (Seg 1 RWA) | Regulation (EU) 2017/1129 | https://eur-lex.europa.eu/eli/reg/2017/1129/oj |

### Proposals not yet in the OJ (re-check before citing)

| File | Commission proposal | Official source |
|---|---|---|
| PSD3 (Directive) | COM(2023) 367 final | https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:52023PC0367 |
| PSR (Regulation) | COM(2023) 366 final | https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:52023PC0366 |
| FiDA | COM(2023) 360 final | https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:52023PC0360 |

> [!warning] AML is three coupled instruments — citation map
> The "EU AML / AMLA package" row in the top table is shorthand for three legal instruments doing three different jobs:
> - **AMLR** (Reg 2024/1624) — substantive rulebook, directly applicable from Jul 2027. Cite for *what the obliged entity must do* (CDD, STR, beneficial-ownership, Travel Rule, cash limits).
> - **AMLD6** (Dir 2024/1640) — enforcement architecture, transposed by each Member State by Jul 2027. Cite for *how the obliged entity is sanctioned* (penalty regime, FIU reporting, supervisor powers).
> - **AMLA Regulation** (Reg 2024/1620) — creates the EU supervisor in Frankfurt, operational since Jul 2025. Cite *only if directly supervised* by AMLA (selected obliged entities — large cross-border banks and CASPs above thresholds; everyone else is supervised nationally under AMLD6 transposition).
>
> **AMLR + AMLD6 are coupled** — if a segment is an obliged entity, both apply. **AMLA direct supervision is a narrower scoping question** — most InnBlockchain client-segments will be supervised nationally, with AMLA affecting them only indirectly via RTS/ITS standards. See the per-segment qualifiers in the Compliance by ICP Segment tables and the AML/AMLA row of the Quick Reference for scoping by segment.

### Supervisors and authority pages

Where RTS/ITS, Q&As, transitional guidance, and enforcement statistics publish:

- **ESMA** (MiCA, MiFID II/III, DLT Pilot, Prospectus): https://www.esma.europa.eu
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

See: [[MiFID-II]] | [[MiFID-III]] | [[MiCA-Regulation]] | [[MiCA-NCA-Authorization-Mechanics]] | [[DORA-Regulation]] | [[EU-AML-AMLA]] | [[EU-AI-Act-Fintech]] | [[PSD3-Open-Banking-EU]] | [[DLT-Pilot-Regime]] | [[ESMA]] | [[Asset-Tokenization-RWA]]
