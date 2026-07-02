---
type: concept
title: "ELTIF 2.0 — European Long-Term Investment Fund"
created: 2026-07-01
updated: 2026-07-01
tags:
  - ELTIF
  - EU
  - fund
  - AIFMD
  - private-equity
  - infrastructure
  - real-assets
  - private-debt
  - retail-access
  - marketing-passport
  - compliance
  - regulation
  - tokenization
status: current
last_reingested: 2026-07-01
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[DORA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[GDPR-Regulation]]"
  - "[[MiCA-Regulation]]"
  - "[[MiFID-II]]"
  - "[[Prospectus-Regulation]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[ERC-3643]]"
  - "[[ERC-1400]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain Crypto Native ICP]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/sales-marketing/Service/Content/EU Compliance/eltif-checklist.md"
    hash: "8d56afdc8f3cef6735f68724a593bc03"
    registered: 2026-07-01
    last_synced: 2026-07-01
    purpose: "InnBlockchain-branded ELTIF 2.0 pre-authorisation readiness checklist (19 sections, 700+ lines); source of truth for ELTIF-specific numbers and article citations used in this concept page"
---

# ELTIF 2.0 — European Long-Term Investment Fund

The **European Long-Term Investment Fund (ELTIF)** is a voluntary EU product label for Alternative Investment Funds (AIFs) that channel capital into long-term illiquid assets — infrastructure, private equity, real estate, private debt, and intellectual property. The label grants an EU-wide marketing passport, including (under **ELTIF 2.0**) full retail access without a national private placement process. ELTIF 2.0 = **Regulation (EU) 2023/606** (OJ L 80/1, 20 March 2023), amending the original **Regulation (EU) 2015/760**. Applicable from **10 January 2024**.

## What ELTIF 2.0 Changed

ELTIF 1.0 failed commercially — by 2023 fewer than 90 funds had been authorised EU-wide. ELTIF 2.0 rewrote the economics:

| Change | ELTIF 1.0 | ELTIF 2.0 |
|---|---|---|
| Min allocation to long-term assets | 70 % of capital | **55 % of capital** (Art 13(1)) |
| Borrowing cap — retail-eligible | 30 % of NAV | **50 % of NAV** (Art 16(1)(a)) |
| Borrowing cap — professional-only | 30 % of NAV | **100 % of NAV** (Art 16(1)(a)) |
| Diversification limits | Apply to all ELTIFs | **Waived entirely for professional-only ELTIFs** (Art 13(7)) |
| Fund-of-funds eligible CIUs | ELTIFs, EuVECAs, EuSEFs only | + **UCITS and EU AIFs** (Art 10(1)(d)) |
| Master-feeder ELTIF structures | Not permitted | **Formally introduced** (Art 29) |
| Secondary market exit | No mechanism | **Matching mechanism** for investor-to-investor transfers (Art 19(2a)) |
| Local facilities for retail | Required in each MS | **Removed entirely** (recital 38) |
| Minimum retail ticket | €10,000 | **Removed** (recital 36) |
| Qualifying portfolio undertakings | Financial firms excluded | **Newly authorised financials (<5 yrs) now eligible** (Art 11(1)(a)) |
| European Green Bonds | Not mentioned | **Explicitly eligible** (Art 10(1)(g)) |
| Third-country investments | Ambiguous | **Explicitly permitted** where they benefit the EU economy (recital 4) |

## Structure: Two Required Authorisations

An ELTIF requires **two independent authorisations** — this is the most common structuring error:

1. **AIFMD licence** held by the EU AIFM (from the AIFM's home-Member-State NCA). Sub-threshold AIFMs and non-EU AIFMs cannot manage ELTIFs.
2. **ELTIF authorisation** granted by the NCA of the Member State where the fund is established. Application must include: fund rules, AIFM identity, depositary name, and (for retail ELTIFs) investor-complaints arrangements. NCA has **2 months** to decide on a complete application (Art 5(3)).

## Key Numbers

| Metric | Limit | Source |
|---|---|---|
| Min eligible long-term assets | ≥ 55 % of capital | Art 13(1) |
| Per-QPU concentration (retail) | ≤ 20 % of capital | Art 13(2)(a) |
| Per-real-asset concentration (retail) | ≤ 20 % of capital | Art 13(2)(b) |
| Per-single CIU concentration (retail) | ≤ 20 % of capital | Art 13(2)(c) |
| Per-single liquid issuer | ≤ 10 % of capital | Art 13(2)(d) |
| STS securitisations — aggregate cap | ≤ 20 % of capital | Art 13(3) |
| OTC/repo counterparty — aggregate cap | ≤ 10 % of capital | Art 13(4) |
| Cross-holding in any single CIU | ≤ 30 % of CIU units | Art 15(1) |
| Borrowing — retail-eligible ELTIF | ≤ 50 % of NAV | Art 16(1)(a) |
| Borrowing — professional-only ELTIF | ≤ 100 % of NAV | Art 16(1)(a) |
| Fund-of-funds look-through cap | Investee CIU ≤ 10 % in any single CIU | Art 10(1)(d) |
| QPU market cap ceiling | ≤ €1,500,000,000 | Art 11(1)(b) |
| QPU — newly authorised financial firm | < 5 years since authorisation | Art 11(1)(a) |
| NCA authorisation decision | 2 months from complete application | Art 5(3) |
| Retail written warning (life > 10 yrs) | Required for retail ELTIFs | Art 18(3) |

**Professional-only waiver**: All concentration limits in Art 13(2)–(4) and the 30 % cross-holding cap in Art 15 **do not apply** to professional-investor-only ELTIFs. This is the structural lever for concentrated infrastructure and real-estate strategies.

## Eligible Investment Assets (Article 10)

Seven categories, positive list only:

- **(a)** Equity / quasi-equity in qualifying portfolio undertakings (QPUs) — primary or secondary market
- **(b)** Debt instruments issued by QPUs
- **(c)** Loans to QPUs — maturity must not exceed the ELTIF's life
- **(d)** Units/shares of other ELTIFs, EuVECAs, EuSEFs, UCITS, and EU AIFs — but each investee CIU must not have invested >10 % in any other single CIU (look-through cap)
- **(e)** Real assets — infrastructure (transport/energy/environment/digital/social), real estate, IP, vessels, equipment, machinery, aircraft, rolling stock, natural resources. **Excluded**: art, manuscripts, wine, jewellery
- **(f)** STS securitisations (Commission Delegated Regulation (EU) 2019/1851 qualifying exposures)
- **(g)** European Green Bonds issued by QPUs

## Qualifying Portfolio Undertakings (Article 11)

Three cumulative tests **at time of initial investment**:

1. **Not a financial undertaking** — unless it is a non-holding-company financial firm authorised or registered <5 years before investment date
2. **Size** — not listed on a regulated market/MTF, OR listed but market cap ≤ **€1,500,000,000**
3. **Jurisdiction** — established in a Member State or a third country that is neither (i) on the FATF high-risk-country delegated-act list (AMLD Art 9(2)) nor (ii) on the EU Council's Annex I tax non-cooperative-jurisdictions list

## Redemption and Liquidity

**Default**: Closed-ended — redemptions only after end of ELTIF's life. Fund rules must state a specific end-of-life date.

**Optional open-ended variant** (Art 18(2)): Early redemptions permitted if all five conditions met — minimum holding period observed, NCA-demonstrated compatible redemption policy and LMTs, clear redemption conditions in fund rules, redemptions capped to liquid-asset percentage, excess requests handled pro-rata.

**Matching mechanism** (Art 19(2a)): Full or partial matching of exiting investors with incoming investors during the ELTIF's life. Requires a written matching policy covering process, pricing, pro-ration, disclosure, and fees. This is **not** a liquidity guarantee — unmatched requests carry no redemption obligation.

## Retail Access

- No minimum ticket (€10k removed under ELTIF 2.0)
- Suitability assessment by the distributor remains mandatory (MiFID II suitability)
- **PRIIPs KID mandatory** — max 3 pages; covers risk indicator, performance scenarios, all costs
- For ELTIF life > 10 years: written alert to retail investors required
- Marketing passport across EU — notification to home NCA covers all Member States; no local facility required

## InnBlockchain Use Cases

ELTIF 2.0 is the EU institutional-fund wrapper most directly relevant to InnBlockchain's tokenization and smart-contract work:

- **Tokenised ELTIF units** — ERC-3643 / T-REX on-chain representation with embedded transfer restrictions, investor eligibility logic (professional vs retail), and redemption-window mechanics
- **Art 19(2a) matching mechanism** — smart contract-based or DLT-MTF matching for secondary ELTIF unit transfers; automated settlement
- **NAV and portfolio compliance monitoring** — real-time tracking of the 55 % minimum, per-asset concentration limits, borrowing NAV ratios; automated alerts on breaches
- **PRIIPs KID data automation** — cost calculation pipelines + performance scenario generation per PRIIPs RTS
- **Real-asset tokenisation onboarding** — infrastructure equity, real estate, IP, and equipment contributed to ELTIF structures via smart contracts
- **AIFMD Annex IV reporting automation** — NCA reporting workflows for the AIFM managing the ELTIF

## Key Regulatory Cross-References

| Regulation | Interaction |
|---|---|
| AIFMD (Dir 2011/61/EU) + AIFMD II (Dir 2024/927) | ELTIF requires full AIFMD authorisation; AIFMD II LMT obligations apply to open-ended ELTIFs |
| MiFID II | Suitability assessment for retail ELTIF distribution; ELTIF units are MiFID Annex I C(3) instruments |
| PRIIPs Regulation (EU) 1286/2014 | KID mandatory for all retail-eligible ELTIFs |
| DORA (Reg 2022/2554) | AIFMs managing ELTIFs are DORA-scoped financial entities |
| AMLR (Reg 2024/1624) | AIFM as investment firm = obliged entity; QPU third-country jurisdiction check against FATF list |
| GDPR (Reg 2016/679) | KYC of retail investors; suitability data; AML CDD data |

> [!gap] AIFMD and AIFMD II Concept Pages Missing
> No dedicated [[AIFMD-Regulation]] or [[AIFMD-II-Regulation]] concept pages exist yet in this wiki. The ELTIF framework presupposes AIFMD authorisation — those pages should be created to complete the EU fund-manager authorisation chain. The source checklists exist at `.raw/InnBlockchain/EU Compliance/aifmd-checklist.md` and `.raw/InnBlockchain/EU Compliance/aifmd2-checklist.md`.

**Source:** Regulation (EU) 2023/606 (OJ L 80, 20.3.2023, p. 1) — https://eur-lex.europa.eu/eli/reg/2023/606/oj/eng
Original: Regulation (EU) 2015/760 (OJ L 123, 19.5.2015, p. 98) — https://eur-lex.europa.eu/eli/reg/2015/760/oj
