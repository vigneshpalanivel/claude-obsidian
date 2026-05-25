---
type: concept
title: "Prospectus Regulation — EU Securities Disclosure Regime"
created: 2026-05-25
updated: 2026-05-25
tags:
  - Prospectus
  - EU
  - securities
  - compliance
  - regulation
  - tokenization
status: current
last_reingested: 2026-05-25
related:
  - "[[EU-Listing-Act]]"
  - "[[MiFID-II]]"
  - "[[MiFID-III]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[MiCA-Regulation]]"
  - "[[DORA-Regulation]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[ERC-3643]]"
  - "[[ERC-1400]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# Prospectus Regulation — EU Securities Disclosure Regime

The Prospectus Regulation (Regulation (EU) 2017/1129) is the EU's harmonised disclosure regime for offering transferable securities to the public or admitting them to trading on a regulated market. It is the **issuer-level** obligation that sits alongside MiFID II (which classifies the instrument and authorises the intermediaries). Substantially amended by the **EU Listing Act (Regulation (EU) 2024/2809)**, with changes phased across **4 December 2024 / 5 March 2026 / 5 June 2026**.

## What the Prospectus Regulation Does

**Two purposes, one supporting the other:**

1. **Investor protection through mandatory disclosure** — before transferable securities can be offered to the public in the EU or admitted to trading on a regulated market, the issuer must publish an NCA-approved document containing all information material to an informed investment assessment *(Art. 6(1))*. Civil liability attaches to the persons responsible *(Art. 11)*.
2. **Capital Markets Union — single disclosure passport** — a prospectus approved by one Member State's NCA is valid across all 27 Member States via the notification mechanism *(Arts. 24–25)*.

**What it is NOT:**
- Not a licensing regime — does not authorise the issuer to do anything other than make the specific offer
- Not a merit review — NCA checks **completeness, consistency, and comprehensibility** *(Art. 20(4))*, not whether the deal is a good investment
- Not a suitability regime — that sits in MiFID II conduct rules on the intermediaries selling the security

## Trigger Test: Does It Apply?

Three layers, three different answers:

| Question | Answer |
|---|---|
| Is the *instrument* a "transferable security"? | Borrowed verbatim from **MiFID II Art. 4(1)(44)** — there is no Prospectus-scope instrument that isn't also a MiFID transferable security |
| Does the *issuer* need MiFID authorisation? | **Usually no** — Prospectus is an issuer obligation; MiFID authorisation hits the *intermediaries* (underwriters, placing agents, MTF operators, custodians) |
| Does the *offer document* fall under Prospectus? | **Yes, on the issuer** — public offer or admission to a regulated market triggers it, regardless of whether the issuer is also a regulated entity |

> [!warning] Common misframe — Prospectus ≠ MiFID authorisation
> A real-estate company tokenising equity in its buildings, a startup doing a security-token IDO, a fund tokenising its units — all need a prospectus, **none need to hold a MiFID firm licence**. The MiFID firms in the picture are the DLT MTF / custodian / placing agent, not the issuer.

## When You Do NOT Need a Prospectus

**Securities outside scope (Art. 1(2)):** UCITS units, public-body non-equity, central-bank shares, MS-guaranteed securities, non-profit issuer securities, non-fungible occupancy shares.

**Public-offer exemptions (Art. 1(4)):**
- Offer solely to qualified investors *(Art. 1(4)(a))*
- Offer to fewer than 150 persons per Member State *(Art. 1(4)(b))*
- Minimum denomination ≥ €100 000 *(Art. 1(4)(c))*
- Minimum consideration ≥ €100 000 per investor *(Art. 1(4)(d))*
- Employee share schemes, certain takeover / merger / division consideration

**Threshold exemption — regime depends on filing date:**
- **Until 4 June 2026:** offer < €1M (12-month aggregate) → outside Regulation entirely *(Art. 1(3))*; €1M–€8M MS opt-in exemption *(Art. 3(2))*
- **From 5 June 2026 (Listing Act):** Art. 1(3) deleted — single €12M threshold under amended Art. 3(2) below which non-passported offers are exempt; Member States may opt for €5M instead

**Admission exemptions (Art. 1(5)):** fungibility (< **30%** over 12 months — raised from 20% by Listing Act, effective 4 Dec 2024), conversion shares, M&A consideration, dividends-in-shares, securities admitted on another EU regulated market for ≥18 months.

## Prospectus Formats (Post-Listing Act, from 5 March 2026)

| Format | Use case | Key feature |
|---|---|---|
| **Standard prospectus** *(Art. 6)* | First-time public offer, IPO, no lighter format available | 300-page limit for shares; standardised format mandatory |
| **Base prospectus** *(Art. 8)* | Non-equity programmes, continuous / repeated issuance | Final terms filed per issuance (no NCA approval needed); base updates via incorporation by reference |
| **Universal Registration Document (URD)** *(Art. 9)* | Frequent issuers | After **2 consecutive years** of approval, subsequent URDs filed without prior approval; enables 5-WD fast-track approval of securities note + summary |
| **EU Follow-on Prospectus** *(NEW, replaces Art. 14)* | Secondary issuance by issuers admitted to a regulated market / SME growth market for ≥18 months continuously | Significantly reduced disclosure; simplified summary; standardised format |
| **EU Growth Issuance Prospectus** *(NEW, replaces Art. 15)* | SMEs, SME-growth-market issuers, small unlisted companies offering ≤ **€50M** over 12 months | Single-document format; alleviated summary; not available to regulated-market issuers |

## Listing Act — Three-Tranche Application

| Effective | What changes |
|---|---|
| **4 December 2024** (in force) | Fungibility 20% → **30%**; supplement withdrawal right 2 → **3 working days** (permanent, was a 2021 temporary measure); intermediary contact by electronic means |
| **5 March 2026** | New EU Follow-on Prospectus + EU Growth Issuance Prospectus; **300-page limit** for shares; mandatory standardised format and sequence; summary may include charts/graphs/tables + 1 page per additional guarantor; base prospectus updates via IBR; supplement cannot introduce new security types |
| **5 June 2026** | **Art. 1(3) deleted**; single €12M threshold under amended Art. 3(2) (or €5M if MS opts); raised SME offer cap to €50M for EU Growth Issuance Prospectus eligibility |

## Approval Process (Art. 20)

| Step | Timeline |
|---|---|
| Initial NCA filing | T |
| NCA first review (standard issuer) | **10 working days** *(Art. 20(2))* |
| NCA first review (first-time issuer) | **20 working days** *(Art. 20(3))* |
| Subsequent review rounds | 10 working days per round *(Art. 20(4))* |
| Frequent-issuer URD fast track | **5 working days** *(Art. 20(6))* |
| Supplement approval | **5 working days** *(Art. 23(1))* |
| Passport notification home → host NCA (via ESMA portal) | **1 working day** *(Art. 25(1))* |
| Publication availability | At least **10 years** *(Art. 21(7))* |

> [!info] No passporting fee
> Art. 25(5) explicitly prohibits any fee for the notification or receipt of notification of a prospectus, supplement, or related supervisory activity, in either home or host Member State. Approval fees in the home Member State *(Art. 20(10))* are separate and permitted.

## Penalty Exposure (Art. 38(2))

Member State minimum-maxima — national law may go higher:

| Sanction type | Quantum |
|---|---|
| Public statement *(Art. 38(2)(a))* — published per Art. 42 | — |
| Cease-and-desist order *(Art. 38(2)(b))* | — |
| Profit disgorgement *(Art. 38(2)(c))* | At least **2× profits gained / losses avoided** |
| Legal person *(Art. 38(2)(d))* | At least **€5M** *or* **3% of total annual turnover** (whichever higher; consolidated where applicable) |
| Natural person *(Art. 38(2)(e))* | At least **€700k** |

Plus: whistleblower protection *(Art. 41)*, publication of decisions on NCA website *(Art. 42)*.

## Why It Matters for Tokenised Securities

For security tokens (ownership / debt / derivative-exposure tokens), the prospectus is the offer document — the MiCA white paper is the wrong instrument. The MiFID II / MiCA boundary determines which regime applies:

| Token type | Regime | Offer document |
|---|---|---|
| Ownership / debt / derivative exposure | **MiFID II + Prospectus** | Prospectus |
| Asset-referenced token (basket-pegged, no ownership) | MiCA Title III (ART) | MiCA white paper |
| E-money token (single-currency stablecoin) | MiCA Title IV (EMT) | MiCA white paper |
| Utility / access / governance (no ownership, no asset reference) | MiCA Title II | MiCA white paper |

**DLT Pilot Regime interaction:** the [[DLT-Pilot-Regime]] governs the trading and settlement *infrastructure* (DLT MTF / SS / TSS). It does **not** waive the issuer's prospectus obligation. If the token is admitted on a DLT Pilot venue, a compliant prospectus is still required.

## Impact on InnBlockchain Clients

- **Crypto Native ICP (Seg 1 — RWA Tokenization)**: Prospectus is **primary** (not MiCA). Every public offer or regulated-market admission of an ownership-conferring token triggers it. Smart contract architecture (ERC-3643 / ERC-1400) must include the disclosures referenced in the prospectus — transfer restrictions, whitelist mechanics, corporate-actions handling, upgrade governance.
- **Crypto Native ICP (Seg 6 — Token Launch / IDO)**: if the token is MiFID-classified (security token), the MiCA white paper route is wrong — Prospectus applies. Classification opinion is the gating decision.
- **FinTech ICP (WealthTech / RWA / STO)**: Prospectus is the primary disclosure document; MiFID II governs the trading venue and intermediaries.
- **Service positioning**: pre-build classification briefs (MiFID II / MiCA / Prospectus boundary), smart-contract audit reports formatted for NCA prospectus review, prospectus-to-code mapping documents (every disclosed risk linked to the contract function that creates or mitigates it).

---

> [!info] Going to file a prospectus?
> The article-by-article detail — Art. 1 scope and exemptions, Art. 6 content schedules, Art. 7 summary, Art. 11 civil liability, Art. 16 risk-factor presentation, Art. 17 final-price omission and withdrawal right, Art. 19 incorporation by reference, Art. 20 approval mechanics, Art. 21 publication, Art. 22 advertisements, Art. 23 supplements, Arts. 24–25 passporting, Art. 27 languages, Arts. 28–29 third-country issuers, Art. 38 penalties, plus the full Listing Act transition by tranche — lives in the full readiness checklist at `.raw/InnBlockchain/EU Compliance/prospectus-checklist.md`. This page stays at the *what the regime is and when it triggers* layer.

> [!gap] Listing Act Level 2 RTS — page-limit detail, standardised format templates, EU Follow-on and EU Growth Issuance Prospectus layout — sit in Commission Delegated Regulations adopted under Reg 2024/2809. Track adoption status before drafting begins; some templates may publish close to or after the 5 March 2026 application date.
