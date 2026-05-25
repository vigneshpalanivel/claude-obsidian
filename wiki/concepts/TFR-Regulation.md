---
type: concept
title: "TFR — Transfer of Funds Regulation (EU Travel Rule)"
created: 2026-05-25
updated: 2026-05-25
tags:
  - TFR
  - Travel-Rule
  - EU
  - crypto
  - AML
  - compliance
  - regulation
status: current
last_reingested: 2026-05-25
derived_from: ".raw/InnBlockchain/EU Compliance/tfr-checklist.md"
related:
  - "[[MiCA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[EU-AML-AMLA-Supervision-Mechanics]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[GDPR-Regulation]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# TFR — Transfer of Funds Regulation (EU Travel Rule)

TFR (Regulation (EU) 2023/1113) is the EU's implementation of FATF Recommendation 16 — the "Travel Rule". It is a **recast** of Regulation (EU) 2015/847, extending the wire-transfer information regime to **transfers of crypto-assets** for the first time. TFR is the operational counterpart to [[EU-AML-AMLA]]: AML/CFT tells you *who* you must know; TFR tells you *what information must travel with each transfer*.

> [!info] What TFR is NOT
> TFR is not an authorisation regime. It does not create new licensable activities — it imposes data-accompaniment obligations on PSPs (already authorised under PSD2 / EMD2) and CASPs (already authorised under MiCA Title V). If a firm is not in-scope under PSD2 or MiCA, it is generally not in-scope under TFR either. The exception is intermediary providers in the transfer chain.

## What TFR Covers

**Two parallel regimes, one regulation:**
- **Chapter II — Transfers of funds** (Arts 4–13): PSP-side Travel Rule, building on the 2015/847 baseline. Intra-Union simplified set (Art 5) + outside-Union full set (Art 4). De minimis at **€1,000** for verification.
- **Chapter III — Transfers of crypto-assets** (Arts 14–22): CASP-side Travel Rule. **No de minimis** — full data set on every transfer regardless of amount or jurisdiction. Self-hosted address rules at €1,000.

**Common chapters apply to both:**
- Chapter IV (Art 23) — restrictive-measures internal controls
- Chapter V (Arts 24–27) — data protection + 5-year record retention
- Chapter VI (Arts 28–33) — sanctions (Art 29 specific-breach triggers)

> [!warning] EMTs are crypto-assets under TFR — not funds
> Article 2 final indent expressly treats **electronic money tokens** (as defined in MiCA Art 3(1)(7)) **as crypto-assets** under TFR. EMT transfers fall under Chapter III (full Travel Rule, no de minimis, self-hosted address rules) — NOT Chapter II. EMI-authorised issuers that also tokenize on DLT face dual classification: PSP for fiat e-money side, CASP for the EMT-on-DLT side.

## Implementation Timeline

| Date | Event | Source |
|------|-------|---|
| 9 June 2023 | TFR published in OJ L 150 + entered into force | Art 40 |
| 1 January 2024 | EBA Art 24a guidelines (EDD for crypto services) due | AMLD5 Art 24a |
| 30 June 2024 | EBA Arts 14–17, 19–22 (CASP Travel Rule ops) + Art 19b (correspondent CASP) guidelines due | Arts 36, 38(4) |
| **30 December 2024** | **TFR applies — synchronised with MiCA Title V start of application** | Art 40 |
| 30 December 2024 | EBA Art 23 (restrictive measures), Art 18(5) (CASP risk factors), Art 19a (self-hosted EDD) guidelines due + AMLD5 amendments transposed | Arts 23, 38(8) |
| **1 July 2026** | Commission review of self-hosted address risks — possible further restrictions | Art 37(2) |
| 31 December 2026 | First Commission report on Chapter VI sanctions application | Art 33(2) |
| **30 June 2027** | Commission report on TFR application + possible legislative proposal | Art 37(3) |
| 10 July 2027 | AMLR application — TFR Art 23 restrictive-measures provision intended to migrate / be repealed | Recital 18 |

## Territorial Scope (Article 2)

TFR is **connecting-factor** based, not customer-based. The transfer is in-scope if any one of the following is true:
- A PSP (or intermediary PSP) of the payer or payee is **established** in the Union
- A CASP (or intermediary CASP) of the originator or beneficiary has its **registered office** in the Union
- The transfer involves a **crypto-ATM** in the Union (Art 2(1) — expressly in-scope regardless of customer location)

There is no "passive recipient" defence. A Union CASP receiving a transfer from a third-country CASP is fully in-scope for the receiving leg.

## Key Exclusions

| Carve-out | Source | Note |
|-----------|--------|------|
| Person-to-person crypto transfers without any CASP | Art 2(4)(b), 3(13) | Touched by a CASP at any leg → full Chapter III applies |
| Both originator + beneficiary are CASPs acting on own behalf | Art 2(4) | Same for PSPs Art 2(4) |
| Pure ancillary infrastructure (internet, cloud, software dev) not executing transfers | Recital 21 | If you route/relay transfers operationally, you're an intermediary CASP |
| Unique + non-fungible crypto-assets | Art 2 final indent, Recital 24 | Unless classified as crypto-assets or funds under MiCA |
| Card / e-money / mobile payments used **exclusively** for goods/services | Art 2(3) | Does NOT apply to consumer-to-consumer transfers |
| Domestic low-value funds transfers ≤€1,000 (Member State option) | Art 2(5) | Funds-only option; no crypto equivalent |

> [!warning] No "fully decentralised" exit for TFR
> Person-to-person transfers without any CASP are out of scope. But the moment a CASP touches any leg — as originator's CASP, beneficiary's CASP, or intermediary — the full Chapter III regime applies. There is no DeFi protocol carve-out. If a front-end, smart contract, or routing layer functions as a CASP under MiCA Art 3(1)(15), TFR attaches.

## The Core Asymmetry: PSP vs CASP

| Dimension | PSPs (Funds, Ch II) | CASPs (Crypto, Ch III) |
|-----------|--------------------|-------------------------|
| De minimis threshold | €1,000 (verification scoped, Art 4(4)/Art 5/Art 6) | **None — full set on every transfer** (Recital 30) |
| Domestic vs cross-border | Intra-Union simplified set (Art 5) | **All transfers treated as cross-border** (Recital 27) |
| Transmission mode | Attached to payment message | "In advance of, simultaneously, or concurrently with" — technology-neutral, off-chain protocols supported (Art 14(4)) |
| Self-hosted address rules | N/A | €1,000 ownership-verification trigger (Art 14(5), 16(2)) |
| Block-then-broadcast hard rule | Art 4(6) | **Art 14(8) — must not allow initiation or execute before full compliance** |
| Risk-based outcomes for missing info | execute / reject / suspend (Art 8) | execute / reject / suspend / **return** (Art 17(1)(a)) |

> [!info] The "in advance of, simultaneously, or concurrently with" wording is load-bearing
> Articles 14(4) and 14(8) together create a hard "no broadcast before data sent" rule for CASPs. Post-fact reconciliation is non-compliant. Architectural choice — block on-chain broadcast until off-chain Travel Rule message is delivered + acknowledged, OR bond the off-chain message to the on-chain tx with cryptographic commitments — must be made before go-live.

## Self-Hosted Addresses (The CASP-Specific Novelty)

A self-hosted address (Art 3(20)) is a DLT address NOT linked to a CASP or to a third-country CASP-equivalent entity.

**For transfers TO a self-hosted address** (Art 14(5)):
- CASP of originator obtains + holds the full Art 14(1)/(2) information (usually from the originator-client)
- Transfer must be individually identifiable in records
- **For transfers exceeding €1,000:** CASP must take adequate measures to assess whether the address is owned or controlled by the originator

**For transfers FROM a self-hosted address** (Art 16(2)):
- Mirror obligation on CASP of beneficiary — full information held + €1,000 ownership verification

**Enhanced due diligence layer** (AMLD5 Art 19a, inserted by TFR Art 38(4)) — mitigating measures *commensurate with risk*:
- (a) Risk-based ID/V of originator/beneficiary or their beneficial owner
- (b) Additional information on **origin and destination** of the transferred crypto-assets
- (c) **Enhanced ongoing monitoring** of self-hosted transactions
- (d) Other measures to mitigate ML/TF + sanctions evasion risk

> [!warning] €1,000 is a floor, not a ceiling
> Firms can (and supervisors may require) lower thresholds. The Commission's 1 July 2026 review (Art 37(2)) is mandated to assess whether further restrictions on self-hosted address transfers are needed — possibly including limitation or prohibition. Business models relying on permissive self-hosted economics should track this review actively.

## AMLD5 Amendments Carried By TFR (Article 38)

TFR Article 38 inserts substantive obligations directly into AMLD5 (Directive (EU) 2015/849) — easy to miss if TFR is read in isolation:

- **CASP scope alignment** (Art 38(1)–(2)) — all MiCA-defined CASPs (except advice-only per MiCA Art 3(1)(16)(h)) become AMLD5 obliged entities; legacy "custodial wallet provider" and "fiat-crypto exchange" categories deleted
- **CASP correspondent relationships** (new AMLD5 Art 19b) — third-country CASP-respondent EDD with six mandatory steps (licensing check, reputation + supervision assessment, AML/CFT controls review, senior management approval, documented responsibilities, payable-through account CDD verification)
- **Enhanced CDD for crypto** (new AMLD5 Art 24a) — EBA guidelines on *how and when* to obtain additional originator/beneficiary information in EDD scenarios
- **CASP risk factors** (new AMLD5 Art 18(5)–(6)) — EBA guidance on privacy wallets, mixers, tumblers + DLT analytic tools for origin/destination detection

## Sanctions Exposure (Chapter VI)

Administrative sanctions mirror AMLD5 Chapter VI Section 4 — effective, proportionate, dissuasive. Article 29 lists the **specific-breach triggers**:

- **(a)** Repeated/systematic failure to accompany transfers with required info (Arts 4, 5, 6, 14, 15)
- **(b)** Repeated/systematic/serious record-retention failure (Art 26)
- **(c)** Failure to implement effective risk-based procedures (Arts 8, 12, 17)
- **(d)** Serious intermediary-side failures (Arts 11/12 PSPs or 19/20/21 CASPs)

Sanctions can apply to the legal person AND to management body members + other responsible natural persons (Art 28(2)). Sanctions are **published** by the competent authority with the breach type + identity (Art 30, subject to case-by-case necessity/proportionality assessment per AMLD5 Art 60).

## GDPR–TFR Collision

Article 14(4) requires CASPs to transmit personal data "in advance of, simultaneously, or concurrently with" the transfer. GDPR Chapter V requires Union → third-country personal data transfers to satisfy adequacy / SCCs / derogations. The two can be mutually exclusive for transfers to third-country CASPs in non-adequate jurisdictions.

**Resolution path** (Art 25(4)):
- EDPB (after consulting EBA) issues guidelines on practical implementation of data-protection requirements for third-country crypto transfers
- EBA issues guidelines on suitable procedures for determining whether to execute / reject / return / suspend a transfer where GDPR third-country transfer rules cannot be met

In practice: the resolution is generally **refuse to execute the transfer**. This is the single most common cross-border CASP failure mode. See [[GDPR-Regulation]] for the broader cross-regime tension.

## TFR vs Adjacent Regimes

| Dimension | TFR | MiCA Title V | AMLR | PSD2 |
|-----------|-----|--------------|------|------|
| What it does | Per-transfer info accompaniment | CASP authorisation + conduct | Substantive AML rulebook | Payment-services authorisation + conduct |
| Connecting factor | Any in-chain PSP/CASP in EU | EU services to EU clients | Obliged-entity status | EU services to EU clients |
| Applies from | 30 Dec 2024 | 30 Dec 2024 | 10 Jul 2027 (replaces AMLD5 substantive law) | In force |
| Crypto de minimis | None for CASPs | N/A | €1,000 transfer trigger (Art 19(2)–(3) CASP exception) | N/A |
| Authorisation required | No (attaches to existing PSP/CASP) | Yes | No | Yes |

## Impact on InnBlockchain Clients

- **Crypto Native ICP (Seg 2–10)** — TFR is unavoidable. Every EU-facing CASP must implement a Travel Rule protocol (IVMS101-compliant — Notabene, Sumsub, TRP, Sygna, OpenVASP) integrated with KYC + KYT stack. Block-then-broadcast architecture is non-negotiable.
- **Crypto Native ICP (Seg 1 — RWA Tokenization)** — TFR generally **does NOT apply** to MiFID-classified ownership tokens (they aren't crypto-assets under MiCA Art 2(4)(a), so Chapter III doesn't reach them). TFR only enters if the firm separately operates a CASP side for non-MiFID assets. Selling "Travel Rule compliance" to a pure RWA platform is wrong-regulator framing.
- **FinTech ICP (ExchangeTech, WalletTech with crypto, regulated CEX/DEX)** — TFR + AMLR + MiCA stack together. Travel Rule data flow is the operational hot spot; AMLD5 Art 19b correspondent-CASP EDD is the second-largest compliance lift for cross-border firms.
- **FinTech ICP (BankTech, EMI, PI without crypto)** — Chapter II only. Existing 2015/847 implementation generally sufficient; intra-Union simplified set + outside-Union €1,000 verification threshold unchanged in substance.
- **Service positioning for TFR-bound startups** — Travel Rule protocol integration + off-chain message bonding to on-chain tx, self-hosted address ownership verification (signed-message challenge / micro-deposit / hardware attestation), chain-analytics integration (Chainalysis / Elliptic / TRM / Crystal) for source/destination KYT, counterparty CASP register + AMLD5 Art 19b correspondent assessment workflow, sanctions screening at four touchpoints (onboarding, originator-side initiation, beneficiary-side receipt, ongoing monitoring), STR factor-handling for missing-info transfers, GDPR-Chapter-V refusal workflow for non-adequate third-country counterparties.

## Key References

| Provision | What it does |
|-----------|--------------|
| Arts 1–3 | Subject matter, scope, definitions (incl. self-hosted address Art 3(20), person-to-person Art 3(13)) |
| Arts 4–6 | PSP of payer obligations (info accompaniment + verification + intra-Union/outside-Union derogations) |
| Arts 7–9 | PSP of payee obligations (detection + risk-based decision + STR factor) |
| Arts 10–13 | Intermediary PSP obligations |
| Art 14 | **CASP of originator — full Travel Rule data set + Art 14(5) self-hosted to / Art 14(8) block-then-broadcast** |
| Art 15 | Batch file transfers of crypto-assets |
| Arts 16–18 | CASP of beneficiary obligations (incl. Art 16(2) self-hosted from) |
| Arts 19–22 | Intermediary CASP obligations |
| Art 23 | Restrictive measures internal controls (intended to migrate to AMLR) |
| Arts 24–27 | Provision of information + GDPR + 5-year record retention |
| Arts 28–33 | Administrative sanctions, publication, internal whistleblowing, monitoring |
| Art 36 | EBA guidelines mandates |
| Art 37 | Review clauses (1 Jul 2026 self-hosted; 30 Jun 2027 general) |
| Art 38 | AMLD5 amendments (CASP scope, Arts 19a/19b/24a inserted) |

> [!info] Operational checklist
> The article-by-article checklist for first-meeting legal-counsel scoping lives in [`.raw/InnBlockchain/EU Compliance/tfr-checklist.md`](../../.raw/InnBlockchain/EU Compliance/tfr-checklist.md). This page is the *what TFR is and where it applies* layer. Practitioner-level mechanics (EBA guideline cross-references, Travel Rule protocol comparison, counterparty CASP register design) would go in a future companion page if extracted from operational experience.

> [!gap] Practitioner companion page not yet created
> Other regulations in this vault (MiCA, DORA, EU-AML-AMLA, MiFID II) each have a `*-Mechanics` companion page for article-level practitioner detail. A `TFR-Operational-Mechanics` companion is **not yet** created — EBA guideline cross-references, protocol-by-protocol Travel Rule comparison, and detailed counterparty-failure escalation playbook would belong there.

**Top-level reference:** Regulation (EU) 2023/1113 of the European Parliament and of the Council of 31 May 2023 on information accompanying transfers of funds and certain crypto-assets and amending Directive (EU) 2015/849 (recast) (OJ L 150, 9.6.2023, p. 1) — https://eur-lex.europa.eu/eli/reg/2023/1113/oj
