---
type: concept
title: "CCD2 — Consumer Credit Directive 2"
created: 2026-05-25
updated: 2026-05-25
tags:
  - CCD2
  - EU
  - compliance
  - consumer-credit
  - BNPL
  - LendTech
  - fintech
status: current
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[GDPR-Regulation]]"
  - "[[DORA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[MiCA-Regulation]]"
  - "[[IPR-Regulation]]"
  - "[[eIDAS-2.0]]"
  - "[[InnBlockchain FinTech ICP]]"
internal_sources:
  - path: ".raw/InnBlockchain/EU Compliance/ccd2-checklist.md"
    hash: "8c050fad1c8c66346a731974be541864"
    version: "1.0"
    ingested_at: "2026-05-25"
  - path: ".raw/InnBlockchain/EU Compliance/ccd2.html"
    hash: "059aa63f335e738058da5705636d5a0d"
    role: "verbatim verification artefact (EUR-Lex local copy of Directive (EU) 2023/2225)"
    ingested_at: "2026-05-25"
---

# CCD2 — Consumer Credit Directive 2

CCD2 (Directive (EU) 2023/2225) is the EU's modernised framework for consumer credit. It was adopted **18 October 2023**, published in OJ on **30 October 2023**, entered into force **19 November 2023** *(Article 49)*, and repeals the original Consumer Credit Directive 2008/48/EC (CCD1) with effect from **20 November 2026** *(Article 47)*. Member-State transposition deadline: **20 November 2025** *(Article 48(1))*. National measures apply from: **20 November 2026** *(Article 48(1))*. Source: https://eur-lex.europa.eu/eli/dir/2023/2225/oj

> [!warning] CCD2 ≠ CCD1 + cosmetic upgrades
> The single most consequential CCD2 shift is **scope expansion**. CCD1 carved out most BNPL, all sub-€200 credit, and free-of-interest credit. CCD2 brings most of these into scope (with lighter-touch obligations for some). A non-bank lender or BNPL operator that classified itself "out of CCD1" must re-run the scope test against CCD2 Art. 2 — being out before does not mean being out now.

> [!info] Practitioner detail
> Article-by-article checklist (scope mapping, role classification, SECCI compliance, creditworthiness assessment, withdrawal/early-repayment ops, admission/registration, intermediary obligations, cross-regime interactions) is in `.raw/InnBlockchain/EU Compliance/ccd2-checklist.md`. This concept page is the strategic / "what-is-CCD2" layer; the checklist is the NCA-ready operational dossier.

## Maximum Harmonisation Directive, Not a Regulation

CCD2 is a **directive** with **maximum harmonisation** (Art. 42(1)) — Member States transpose it into national law and cannot diverge from harmonised provisions. But CCD2 contains **~17 explicit Member-State regulatory choices** (Art. 2(5)–(8), 8(8), 14(2)–(3), 16(4)/(6), 18(11), 24(5), 25(6), 26(4)/(8), 29(4), 31(2), 32(4)–(5), 35(3)–(4), 37(3), 41(9)). Per Art. 42(2), Member States must notify the Commission of each choice, which publishes them centrally. Operating across multiple Member States means tracking up to 27 national overlays — not a single harmonised EU baseline.

> [!warning] The national transposing law is operative, not CCD2 itself
> By the 20 November 2025 transposition deadline (now passed), each Member State should have enacted a national law transposing CCD2. The **national law** is the operative legal text — CCD2 is the floor. For pan-EU operations, map each Member State's transposing act + competent authority Q&A separately.

## Who Must Comply (Article 2)

CCD2 applies to **credit agreements** (Art. 3(3)) — loans, deferred payment, or other similar financial accommodation — granted to a **consumer** (Art. 3(1)) by a **creditor** (Art. 3(2)) or facilitated by a **credit intermediary** (Art. 3(12)).

| Product | CCD1 status | CCD2 status |
|---|---|---|
| Bank-issued consumer loans €200–€100k | In scope | In scope |
| Mortgage-secured credit | Out (MCD covers) | Out (Art. 2(2)(a)) |
| Credit > €100k | Out | Out — *except* residential renovation, where the >€100k cap is removed (Art. 2(3)) |
| **BNPL (third-party financed)** | Out (most) | **In** (most — Art. 2(2)(h) carve-out is narrow) |
| **BNPL (merchant-financed, large platform)** | Out | **In** unless ≤14-day repayment, interest-free, limited late charges (Art. 2(2)(h)) |
| **BNPL (SME-merchant-financed)** | Out | **In** unless ≤50-day repayment, interest-free, limited late charges |
| **Sub-€200 credit** | Out (Member State option) | **In** (light regime — Art. 2(8)) |
| **Free-of-interest credit** | Out (some) | **In** (light regime — Art. 2(8)(b)) |
| **Leasing with option to purchase** | Out (mostly) | **In** — only leasing *without* option excluded (Art. 2(2)(g)) |
| **Crowdfunded consumer credit** | Out (ambiguous) | **In** under general credit-agreement scope |
| Overdrafts and overrunning | In (modified) | **In** (Art. 2(4) limits which provisions apply to overrunning) |

> [!warning] BNPL is the structural scope shift
> CCD1 Art. 2(2)(f) excluded most deferred-payment products. CCD2 Art. 2(2)(h) closes the gap: third-party-financed BNPL is captured outright; merchant-financed BNPL only escapes if the merchant is an SME *or* the payment window is ≤14 days when offered by a large online platform. Klarna-style and embedded-platform BNPL operating in the EU/EEA must assume in-scope status from 20 November 2026 unless a tightly drafted exception applies.

## The CCD2 Obligation Spine

CCD2 stacks obligations across the customer lifecycle:

| Lifecycle stage | Article | Core obligation |
|---|---|---|
| Marketing | Art. 7, 8 | Fair/clear/not misleading; mandatory **"Caution! Borrowing money costs money"** warning; Standard Information (APR, total cost, etc.); absolute prohibitions on "credit improves your situation" framing |
| Pre-contractual disclosure | Art. 9–12 | General information always available; **Standard European Consumer Credit Information (SECCI)** form (Annex I) with prescriptive one-page (max two-page) layout; adequate explanations free of charge |
| Personalised offers | Art. 13 | Clear disclosure when offer is based on automated processing of personal data |
| Product design | Art. 14–17 | Tying **prohibited** (bundling allowed); inferred consent / pre-ticked boxes prohibited; advisory-services regime; **ban on unsolicited credit** (Art. 17) |
| Underwriting | Art. 18, 19 | Thorough creditworthiness assessment; **no special-category data, no social-network data**; right to **human intervention** for automated assessments; cross-border database access |
| Contract | Art. 20–25 | Durable medium; mandatory content (Art. 21(1)(a)–(v)); modification disclosure; overdraft/overrunning regimes |
| Withdrawal & repayment | Art. 26–29 | **14-day no-reason withdrawal** (extendable to 12 months + 14 days if T&Cs missing); early-repayment right with capped compensation (1% / 0.5%) |
| Pricing | Art. 30, 31 | APR per Annex III; **Member States must introduce caps** on excessive rates / APR / total cost |
| Conduct & staff | Art. 32, 33 | Honest/fair/transparent/professional; staff knowledge & competence requirements |
| Arrears & support | Art. 34–36 | Financial education; **reasonable forbearance** before enforcement; **independent debt advisory services** + early detection of difficulty |
| Authorisation | Art. 37, 38 | Admission, registration, supervision of non-bank creditors and intermediaries; intermediary-specific obligations |
| Enforcement | Art. 39–44 | Assignment regime; ADR; competent authorities; **penalties set by Member State** (no EU ceiling) |

## Article 18(8) — The Strongest Right to Human Intervention in EU Law

Where the creditworthiness assessment uses automated processing, the consumer has an **unconditional right** to:
- a clear, comprehensible explanation of the assessment, including the **logic, risks, significance, and effects** of the automated processing;
- express their own point of view to the creditor;
- request a review of the assessment and the granting decision.

> [!warning] CCD2 Art. 18(8) is stronger than GDPR Art. 22
> Under [[GDPR-Regulation|GDPR]] Art. 22, the right to human intervention is qualified — it triggers only where the decision produces legal or similarly significant effects, and several gateways (contract necessity, explicit consent, authorising EU/Member-State law) allow controllers to bypass it. Under CCD2 Art. 18(8), the right has **no gateway** — wherever creditworthiness uses automated processing, the right applies. ML-driven underwriting stacks built on the GDPR Art. 22 "necessary for contract" defence lose that defence under CCD2 from 20 November 2026.

> [!warning] No social-network data, no special-category data in creditworthiness
> Art. 18(3) explicitly excludes GDPR Art. 9 special-category data **and** social-network data as inputs. Art. 19(5) extends the same exclusion to data processed *from* creditworthiness databases. Alt-data underwriting models built on social-graph signals (a common 2018–2023 thin-file lending architecture) must be retrained or replaced before the application date.

## Penalties — Member-State-Set, No EU Ceiling

CCD2 is the inverse of [[MiCA-Regulation|MiCA]] / [[DORA-Regulation|DORA]] / [[GDPR-Regulation|GDPR]] on penalty architecture. Art. 44(1) requires Member States to set "**effective, proportionate, dissuasive**" penalties and notify the Commission by 20 November 2026 — but there is **no harmonised EU ceiling**. Expect wide divergence:

| Member State | Historical CCD1 enforcement pattern |
|---|---|
| France | DGCCRF fines in low six-figures; consumer-collective-redress via UFC-Que Choisir |
| Germany | Criminal pathway via StGB §§ 264a–266 for egregious cases; civil litigation common |
| Italy | AGCM + Bank of Italy stack penalties — pan-product enforcement in the millions |
| Netherlands | AFM administrative fines + 14% APR statutory cap as backstop |
| Spain | Banco de España + INC consumer-protection penalty layering |

Pan-EU operators should budget against the **worst-case Member State**, not the average. Art. 44(3) public-disclosure power is likely the more consequential lever for brand-led non-bank lenders.

## CCD2 ↔ Other EU Regimes

CCD2 does not stand alone — it stacks on every other regime that touches consumer lending:

| Regime | Interaction with CCD2 |
|---|---|
| [[GDPR-Regulation\|GDPR]] | Art. 13 personalised-pricing disclosure dovetails with GDPR transparency; Art. 18(3)/19(5) ban on special-category + social-network data is *stricter* than GDPR Art. 9; Art. 18(8) human-intervention right is *stronger* than GDPR Art. 22 |
| EU AI Act | Creditworthiness AI is **high-risk** under AI Act Annex III(5)(b) — AI Act Art. 26 deployer obligations + Art. 27 FRIA layer on top of CCD2 Art. 18 |
| [[EU-AML-AMLA\|AMLR / AMLA]] | KYC data collected for AMLR CDD may be reused for CCD2 creditworthiness (Art. 18(3) "necessary and proportionate" basis); sanctions/PEP screening data is special-category-adjacent — handle under GDPR Art. 10, do not feed into creditworthiness scoring |
| [[DORA-Regulation\|DORA]] | Creditworthiness pipelines = ICT-supported services in DORA Pillar 1 scope; DORA Art. 28 third-party-ICT risk covers alt-data providers; DORA Art. 19 major-incident reporting + CCD2 supervisory-notification may both fire on a single outage |
| NPL Directive (EU) 2021/2167 | CCD2 Art. 35 forbearance ≈ NPL Directive Art. 28; integrated forbearance policy works for both with CCD2-specific rationale captured |
| [[MiCA-Regulation\|MiCA]] | Crypto-collateralised consumer lending: CCD2 governs the credit agreement layer; MiCA governs the CASP / custody side; **stablecoin-denominated consumer credit** triggers both CCD2 and EMD2/MiCA |

> [!info] Crypto-lending exposure is real but narrow
> CCD2 is technology-neutral — it captures **fiat-denominated credit to a consumer regardless of underlying technology**. The greatest exposure for crypto-native firms is in the **embedded-finance + BNPL crypto-stack** intersection: NFT marketplaces offering stablecoin BNPL, crypto-exchange "instant credit lines," DeFi front-ends offering consumer fiat onramp loans. Pure protocol-level over-collateralised loans (where there is no counterparty creditor in the conventional sense) sit in a contested zone. Decision rests on whether a "credit agreement" with an identifiable "creditor" actually exists at the protocol layer.

## Key Dates

| Date | Event | Source |
|---|---|---|
| 18 October 2023 | CCD2 adopted | OJ L 2023/2225 |
| 30 October 2023 | OJ publication | OJ L 2023/2225 |
| **19 November 2023** | CCD2 enters into force | Art. 49 (OJ + 20 days) |
| **20 November 2025** | **Member State transposition deadline (passed)** | Art. 48(1) |
| 20 November 2025 | Member States notify competent authorities to Commission | Art. 41(5) |
| **20 November 2026** | **National measures apply / CCD1 (2008/48/EC) repealed** | Arts. 47, 48(1) |
| 20 November 2026 | Member States report rate-cap measures, penalties, and debt-advisory availability | Arts. 31(3), 44(1), 36(4) |
| 20 November 2027 | Commission publishes Member-State rate-cap measures | Art. 31(3) |
| 20 November 2028 | Commission report on debt-advisory services | Art. 36(4) |
| 20 November 2029 | EBA report on rate-cap implementation | Art. 31(4) |

Existing credit agreements on 20 November 2026 are **grandfathered** under CCD1 until termination (Art. 47), with narrow CCD2 carve-ins for open-end agreements (Arts. 23, 24, 25(1) second sentence, 25(2), 28, 39).

## InnBlockchain Relevance

CCD2 is the dominant compliance regime for the LendTech segment of [[InnBlockchain FinTech ICP]] and a non-trivial overlay for BNPL features embedded in Crypto Native segments (Seg 3 DeFi Lending fiat-onramp loans, Seg 5 NFT marketplace stablecoin BNPL, Seg 10 AI×Crypto on-chain credit agents). Service hooks:

- **Pre-build:** CCD2 scope mapping per product line; Member-State transposition tracking; SECCI templates configured to Annex I element-by-element
- **Build:** Smart-contract credit-agreement architecture with off-chain SECCI + durable-medium delivery (Art. 20) and on-chain hash anchoring; automated creditworthiness pipeline with mandatory human-review checkpoints (Art. 18(8) + GDPR Art. 22 simultaneous compliance); withdrawal-period state machine with auto-reminder triggers (Art. 10(1) late-disclosure fallback); early-repayment calculator with native Art. 29 caps
- **Audit:** Independent CCD2-readiness audit of the credit-decision pipeline; SECCI element-by-element review against Annex I; advertising-creative audit against Arts. 7, 8; data-source attestation against Art. 18(3) restrictions; cross-regime audit of CCD2 ↔ GDPR ↔ AI Act ↔ DORA touch-points

Sales positioning: CCD2 + [[GDPR-Regulation|GDPR]] + EU AI Act high-risk-AI obligations stack tightly around the **creditworthiness pipeline**. A non-bank lender or BNPL platform launching in the EU from 20 November 2026 needs a single architectural narrative that satisfies all three — that is the cross-sell hook into the AI-Act audit + DORA pillar work.

## Sources

- **Primary:** Directive (EU) 2023/2225 — https://eur-lex.europa.eu/eli/dir/2023/2225/oj
- **Practitioner detail:** [.raw/InnBlockchain/EU Compliance/ccd2-checklist.md](../../.raw/InnBlockchain/EU%20Compliance/ccd2-checklist.md) (v1.0, 17 sections, scorecard format)
- **Verbatim verification artefact:** `.raw/InnBlockchain/EU Compliance/ccd2.html` (local EUR-Lex copy)
- **Cross-references:** [[EU-Fintech-Compliance-Landscape]] (landscape position, ICP mapping), [[InnBlockchain FinTech ICP]] (LendTech segment), [[GDPR-Regulation]] (Art. 22 ↔ CCD2 Art. 18(8) interaction)

## See also

- [[EU-Fintech-Compliance-Landscape]]
- [[GDPR-Regulation]]
- [[DORA-Regulation]]
- [[EU-AML-AMLA]]
- [[MiCA-Regulation]]
- [[IPR-Regulation]]
- [[InnBlockchain FinTech ICP]]
