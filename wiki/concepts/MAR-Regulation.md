---
type: concept
title: "MAR (Market Abuse Regulation) — EU Ongoing-Disclosure & Market-Conduct Regime"
created: 2026-05-25
updated: 2026-05-25
tags:
  - MAR
  - market-abuse
  - inside-information
  - insider-list
  - PDMR
  - EU
  - securities
  - compliance
  - regulation
  - tokenization
status: current
last_reingested: 2026-05-25
related:
  - "[[Prospectus-Regulation]]"
  - "[[EU-Listing-Act]]"
  - "[[MiFID-II]]"
  - "[[MiFID-II-NCA-Authorization-Mechanics]]"
  - "[[MiFIR-Operational-Mechanics]]"
  - "[[MiFID-III]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[MiCA-Regulation]]"
  - "[[GDPR-Regulation]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[ERC-3643]]"
  - "[[ERC-1400]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# MAR (Market Abuse Regulation) — EU Ongoing-Disclosure & Market-Conduct Regime

The EU Market Abuse Regulation (Regulation (EU) No 596/2014) is the **ongoing-disclosure and market-conduct** counterpart to the Prospectus Regulation's offer-time disclosure. Once a financial instrument is admitted (or pending admission) to trading on an EU regulated market, MTF, OTF, or SME growth market, MAR binds — regardless of whether the issuer is itself an authorised entity. It prohibits insider dealing, unlawful disclosure of inside information, and market manipulation; it mandates inside-information disclosure, insider lists, and managers'-transaction notifications. Substantially amended by the **EU Listing Act (Regulation (EU) 2024/2809)** with changes in force **4 December 2024** and further Art 2 point (6)(a)(b)(c)(e) amendments applying from **5 June 2026**.

## What MAR Does

**Three substantive prohibitions (Articles 14, 15):**

1. **Insider dealing** — using inside information to trade, recommending / inducing another to trade, cancelling or amending an order once you possess inside information (Articles 8, 14(a))
2. **Unlawful disclosure of inside information** — disclosing inside information outside the normal exercise of employment / profession / duties (Articles 10, 14(c))
3. **Market manipulation** — false or misleading signals, fictitious devices, dissemination of false information, false benchmark inputs (Articles 12, 15)

**Three substantive ongoing-disclosure obligations on issuers (Articles 17, 18, 19):**

1. **Article 17 public disclosure of inside information** — "as soon as possible" of inside information that directly concerns the issuer. **Listing Act-narrowed to the final event only** of a protracted process from 4 December 2024; intermediate steps must be kept confidential under new Article 17(1a).
2. **Article 18 insider lists** — per-event sections; identity, reason, timestamp of access; written acknowledgment of MAR obligations by each insider; 5-year retention
3. **Article 19 managers' transactions (PDMRs)** — notification of own-account transactions in the issuer's instruments within 3 business days, once annual aggregate crosses **€20 000** (Listing Act raise from €5 000; Member States may opt up to **€50 000**); 30-calendar-day closed period before interim / year-end reports

**Two safe-harbour exemptions (Articles 5, 6):**

- **Buy-back programmes and stabilisation** (Art 5) — Listing Act simplified reporting routing to **single "most relevant market" NCA** under MiFIR Art 26, from 4 December 2024
- **Monetary / public-debt / climate-policy** operations by Member States, ESCB, ministries (Art 6)

**Two operational duties on market participants (Articles 11, 16):**

- **Market soundings** (Art 11) — disclosing-side and receiving-side procedure for sharing what would otherwise be inside information before a transaction
- **Prevention and detection of market abuse** (Art 16) — STORs (Suspicious Transaction and Order Reports) by venues and PPAETs immediately on reasonable suspicion

## Scope — Instrument-Based, Not Entity-Based

MAR scope attaches to **instruments**, not entities. The most common scoping mistake is reading MAR as catching only "authorised firms" — wrong. The scope test is Article 2.

| Trigger | What it catches |
|---|---|
| **Art 2(1)(a)** | Financial instruments admitted to trading on an EU RM (or for which request for admission has been made) |
| **Art 2(1)(b)** | Financial instruments traded on an MTF, or admitted / pending admission to an MTF — **includes SME growth markets and DLT MTFs** |
| **Art 2(1)(c)** | Financial instruments traded on an OTF |
| **Art 2(1) final** | OTC instruments whose price or value depends on or affects in-scope instruments (e.g. OTC derivatives referencing admitted equity) |
| **Art 2(2)** | Behaviour in EU ETS auction products; spot commodity contracts where price effect on in-scope derivatives; benchmark submission |
| **Art 2(4)** | Behaviour **outside the EU** in relation to in-scope EU instruments — MAR has **extraterritorial reach** |

> [!warning] Common scope mistakes
> - **"We're not an authorised firm so MAR doesn't apply."** Wrong. MAR scope is instrument-based. A non-EU issuer whose tokenised security is admitted to an EU DLT MTF is in MAR scope.
> - **"We've filed for admission but not been admitted yet, so MAR doesn't bite."** Wrong. Art 2(1)(a) catches instruments "for which a request for admission has been made."
> - **"This is a crypto-asset, not a financial instrument."** Possibly. If MiCA-classified (asset-referenced token, e-money token, other MiCA crypto-asset), the parallel **MiCA Title VI** market-abuse regime applies — not MAR. Classification is the gating decision; once classified, the regime follows automatically.

## How MAR Pairs With the Rest of the EU Stack

| Instrument | Form | What it governs | Where to read it |
|---|---|---|---|
| **Prospectus Regulation** | Reg (EU) 2017/1129 | **Offer-time** disclosure (one-shot — publish a prospectus when offering or seeking admission) | [[Prospectus-Regulation]] |
| **MAR** | Reg (EU) No 596/2014 | **Ongoing-disclosure + market-conduct** (continuous — once admitted) | This page |
| **MiFID II** | Dir 2014/65/EU | **Who** can be authorised (investment firms, venues) and conduct-of-business toward clients | [[MiFID-II]] |
| **MiFIR** | Reg (EU) No 600/2014 | **What happens on the market** — transparency, transaction reporting (feeds MAR Art 26 "most relevant market" determination for MAR Art 5 buy-back routing) | [[MiFIR-Operational-Mechanics]] |
| **Listing Act** | Reg (EU) 2024/2809 + Dir 2024/2810 + Dir 2024/2811 | Horizontal package amending Prospectus / MAR / MiFIR / MiFID II + multi-vote shares | [[EU-Listing-Act]] |
| **MiCA Title VI** | Reg (EU) 2023/1114 Arts 86–92 | Parallel market-abuse regime for **MiCA crypto-assets** — not for MAR-financial-instruments | [[MiCA-Regulation]] |
| **DLT Pilot Regime** | Reg (EU) 2022/858 | Sandbox infrastructure for tokenised securities trading + settlement; MAR applies to the underlying instruments | [[DLT-Pilot-Regime]] |

> [!info] MAR ≠ MiCA Title VI
> Both contain prohibitions on insider dealing, unlawful disclosure, and market manipulation. The legal regimes are **separate**: MAR applies to financial instruments admitted to traditional / DLT MiFID venues; MiCA Title VI applies to MiCA crypto-assets. Penalties, scope of "inside information", competent-authority allocation, and surveillance mechanics differ. A single platform handling both classes runs both regimes in parallel.

## The Listing Act Amendments (4 December 2024 onward)

The single most operationally significant MAR change since 2014. Five things changed:

| Amendment | Mechanism | Operational impact |
|---|---|---|
| **Article 17 protracted-process narrowing** | New Art 17(1) second sentence excludes intermediate steps; new Art 17(1a) preserves confidentiality | Disclosure committee playbook must be rewritten. Only the **final event** of a protracted process triggers disclosure under Art 17(1). Intermediate-step information remains inside information for Arts 8–10 / 14 purposes (insider list, dealing prohibition) — only the disclosure trigger is narrowed. |
| **Article 19 PDMR threshold raise** | €5 000 → **€20 000** annual aggregate (default); Member States may opt up to **€50 000** for some PDMR categories (Art 19(9)) | Every PDMR policy must update the threshold and the aggregation logic. Annual aggregate, not per-transaction. |
| **Article 5 buy-back single-NCA routing** | Reports to **NCA of the most relevant market** under MiFIR Art 26(1) — the receiving NCA forwards on request | Trade-reporting feed re-routed to one NCA, not every venue's NCA. |
| **Article 30 administrative sanctions recalibration** | 2% turnover floor (min €2.5M; SME alternative €1M) for Art 17; 0.8% (min €1M; SME alternative €400k) for Arts 18–19 | Compliance exposure re-modelled. SME-proportionate floors recognise smaller-cap listed issuers. |
| **New Articles 25a + 25b + 29** | Cross-border order-data mechanism (large venues only — ≥€100bn turnover + ≥50% cross-border ratio); collaboration platforms; personal data transfers to third countries (GDPR-aligned) | Venue operators on large EU equity markets in scope of Art 25a; minimal direct issuer impact for the rest. |

> [!warning] Pre-December-2024 MAR procedure manuals are out of date
> If your disclosure-committee playbook, PDMR policy, or insider-list procedure was last reviewed before December 2024, it does not reflect the post-Listing-Act regime. Specific items to audit: (a) Art 17 final-event analysis applied to in-flight protracted processes; (b) PDMR notification threshold and aggregation engine; (c) buy-back reporting NCA routing; (d) sanctions-exposure modelling under new Art 30 tiers.

## Article 7 Inside-Information Definition — The Foundational Concept

**Inside information** under Article 7(1) means (any one of):

1. **(a)** Precise, non-public information directly or indirectly relating to issuers or instruments, **likely to have a significant effect on price** if made public
2. **(b)** For commodity derivatives — precise non-public information likely to significantly affect price and reasonably expected to be disclosed under EU/national law
3. **(c)** For emission allowances / auction products — precise non-public information likely to significantly affect price
4. **(d)** For client-order executors — client pending-order information of a precise nature likely to significantly affect price

**Precise** under Art 7(2): set of circumstances / event which exists or may reasonably be expected; **specific enough** to enable a conclusion about price effect.

**Protracted process** under Art 7(2)–(3): intermediate steps can constitute inside information for Arts 8–10 / 14 purposes (insider-dealing prohibition applies) — but the post-Listing-Act Art 17(1) disclosure trigger applies **only to the final event**. Two distinct analyses.

## Penalty Exposure (Art 30(2) as recalibrated)

| Infringement | Legal-person maximum | Floor | SME floor | Natural person |
|---|---|---|---|---|
| **Art 14 (insider dealing) + Art 15 (manipulation)** | 15% turnover | **€15 000 000** | — | **€5 000 000** |
| **Art 17 (inside-info disclosure)** | 2% turnover | **€2 500 000** | €1 000 000 | — |
| **Art 18 (insider lists) + Art 19 (PDMR)** | 0.8% turnover | **€1 000 000** | €400 000 | — |
| **Art 16 (STOR) + general** | 2% turnover | **€2 500 000** | — | €1 000 000 |
| **Disgorgement (Art 30(2)(g))** | **≥3× profits gained / losses avoided** | — | — | — |

Plus non-monetary measures (Art 30(2)(a)–(f)): public statement, cease-and-desist, authorisation withdrawal, temporary management ban, temporary own-account dealing ban. Whistleblower protection under Art 32 + public decision publication under Art 34 (5-year minimum).

## Why It Matters for Tokenised Securities

Tokenised transferable securities (security tokens, tokenised bonds, tokenised equity) are financial instruments under MiFID II Art 4(1)(15). They sit **inside** the MAR perimeter, regardless of issuance and trading on a DLT MTF / DLT TSS under the [[DLT-Pilot-Regime]]. The DLT form does not change the substance — it changes the surveillance, insider-list, and confidentiality mechanics.

| Substantive obligation | DLT-specific consideration |
|---|---|
| **Art 16(1) venue surveillance** | Must cover on-chain manipulation vectors — wash trading via smart-contract self-trades, validator / sequencer front-running, oracle manipulation, sandwich attacks |
| **Art 17 final-event disclosure** | On-chain visibility of intermediate steps (multisig confirmations, governance votes) does **not** create a disclosure trigger; leak-management under Art 17(7) still applies if confidentiality cannot be maintained |
| **Art 18 insider lists** | Smart-contract developers with upgrade authority typically go on the permanent insider section; pseudonymous wallet holders receiving inside information off-chain still listed under controller's real-world identity |
| **Art 19 PDMR notifications** | €20k / €50k threshold applies on aggregate fiat-equivalent value across all controlled wallets; closed-period restrictions apply on-chain identically to traditional trading |

## Impact on InnBlockchain Clients

- **Crypto Native ICP (Seg 1 — RWA Tokenization)**: MAR is **post-admission**, not pre-issuance. The issuer's MAR programme is the **client's securities counsel** problem, not InnBlockchain's. InnBlockchain's smart-contract delivery should be MAR-aware where the contract design materially affects insider-list mechanics (multi-sig upgrade authority, oracle dependencies, governance vote scheduling) — but MAR advisory is not the deliverable.
- **Crypto Native ICP (Seg 6 — Token Launch / IDO)**: if the token is MiFID-classified (security token), MAR applies from admission. If MiCA-classified, MiCA Title VI applies instead. Classification opinion is the gating decision.
- **FinTech ICP (WealthTech / RWA / STO)**: WealthTech clients with admitted-to-trading tokenised offerings are in MAR scope from day one. Vendor risk packs may include MAR Article 16(1) surveillance integration as a third-party dependency — InnBlockchain's surveillance / monitoring tooling deliverables should map to this row of the risk pack.
- **Service positioning**: MAR-aware smart-contract architecture documents (upgrade governance, oracle insulation, multisig key-holder identification for insider-list inclusion), not standalone MAR advisory.

---

> [!info] Going to operate under MAR?
> The article-by-article detail — Art 2 scope test, Art 5 buy-back safe harbour, Art 7 inside-information definition with protracted-process analysis, Arts 8–10 / 14 prohibitions, Art 11 market soundings, Art 12 manipulation indicators, Art 16 STOR, Art 17 post-Listing-Act disclosure (with the operational delta), Art 18 insider lists with per-event sections, Art 19 PDMR notifications at the €20k/€50k threshold, Arts 20–21 investment recommendations + media, Arts 22–29 competent-authority architecture (including new Arts 25a/25b/29), Art 30 administrative sanctions tiers, Section 10 tokenised-instrument specifics, plus first-meeting documentation checklist and post-Listing-Act red flags — lives in the full readiness checklist at `.raw/InnBlockchain/EU Compliance/mar-checklist.md`. This page stays at the *what the regime is and how it triggers* layer.

> [!gap] No dedicated MAR practitioner-mechanics page yet (parallel to [[MiFID-II-NCA-Authorization-Mechanics]] / [[MiFIR-Operational-Mechanics]]). The mar-checklist Section 4 (Market soundings), Section 5 (Manipulation indicators), and Section 6 (Issuer ongoing-disclosure mechanics) carry the operational granularity for now; a MAR-Operational-Mechanics page covering ESMA Q&A, Delegated Reg 2016/522 indicators, and Delegated Reg 2016/1052 buy-back conditions is a future extraction candidate.

> [!gap] **CRIM-MAD (Directive 2014/57/EU)** — the criminal-sanctions counterpart to MAR's administrative regime — is not covered in this concept page. Member-State transposition varies materially; relevant where a prospect group has a director / PDMR at risk of personal criminal liability for insider dealing or manipulation. Track per-MS local-counsel for criminal exposure rather than treating CRIM-MAD as a horizontal reference.
