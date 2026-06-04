---
type: concept
title: "Rule 144 — Resale Safe Harbor for Restricted and Affiliate-Held Securities"
created: 2026-06-04
updated: 2026-06-04
tags:
  - Rule-144
  - SEC
  - securities-law
  - resale
  - restricted-securities
  - affiliate
  - US-law
status: current
related:
  - "[[Regulation-S]]"
  - "[[Rule-144A]]"
  - "[[OFAC-Sanctions]]"
  - "[[Real-Estate-RWA-Reg-S-Implementation]]"
  - "[[Real-Estate-RWA-Reg-S-Affiliate-Addendum]]"
  - "[[US-Fintech-Compliance-Landscape]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/US Compliance/rule-144-checklist.md"
    hash: "1fe424f6387937900d75c245f1e14303"
    version: "1.0"
    registered: 2026-06-04
    derived_from: this wiki concept + verbatim cross-check against eCFR § 230.144
    purpose: "Source-derived InnBlockchain client-facing Rule 144 compliance checklist. 12 sections + scorecard, scoped strictly to § 230.144. Designed to be the single source of truth for Rule 144 affiliate-seller and non-affiliate-seller resale conditions, including the holding period, current-public-information, volume cap, manner-of-sale, brokers' transactions, Form 144, and shell-company carve-out. Cross-referenced by reg-s-checklist.md §5 and §8.3 via the Rule 905 bridge."
---

# Rule 144 — Resale Safe Harbor for Restricted and Affiliate-Held Securities

Rule 144 is a **non-exclusive safe harbor** under the U.S. Securities Act that removes a seller from the Section 2(a)(11) "underwriter" definition, making the Section 4(a)(1) registration exemption available for resales of restricted securities and for any sale on behalf of an affiliate. It is the mechanism by which restricted securities — acquired in Reg D private placements, Reg S Category 3 offerings, Rule 144A transactions, or other non-public offerings — can ultimately be resold to U.S. persons without registration.

Rule 144 is the **other half of the U.S. private capital markets**: Regulation S, Reg D, Rule 144A, and Reg A all deal with how restricted securities get *issued*; Rule 144 deals with how they get *resold*.

## Two Distinct Paths

| Path | Who | Conditions |
|---|---|---|
| **Non-affiliate path** (Rule 144(b)(1)) | A seller who is not an affiliate at the time of sale **and has not been an affiliate in the prior 90 days** | Reporting issuer: holding period (6 months) + current public information for first year; after 12 months unconditional. **Non-reporting issuer: holding period (12 months) only.** |
| **Affiliate path** (Rule 144(b)(2)) | Any affiliate, or any person who was an affiliate within the prior 90 days, or any person selling for an affiliate's account | ALL conditions: current public information + holding period (if restricted) + volume limitations + manner of sale + brokers' transactions + Form 144 if above threshold |

The two paths produce different outcomes. A successful non-affiliate Rule 144 sale **strips the "restricted" label from the securities in the buyer's hands**. An affiliate Rule 144 sale does not — the securities remain restricted in the buyer's hands and the buyer must use Rule 144 to resell.

## Who Is an Affiliate (Rule 144(a)(1))

> A person that directly or indirectly through one or more intermediaries, **controls, is controlled by, or is under common control with**, the issuer.

The test is **control**, not ownership percentage. Control means the power to direct management and policies. Affiliate status looks through trusts, holding companies, and other intermediaries.

In practice:
- Officers, directors, and managing members are presumed affiliates by virtue of position
- 10%+ holders are commonly presumed potentially affiliates (rebuttable based on actual control influence)
- Sponsors / founders / GPs with discretionary authority are almost always affiliates
- Household members (spouse, dependents) of affiliates are presumed affiliates by attribution (Rule 144(a)(2)(i))
- Multiple holders acting in concert form a group whose aggregate holdings determine affiliate status of the group (and apply to each member)

## Holding Period (Rule 144(d))

| Issuer status | Minimum holding period |
|---|---|
| **Reporting issuer** (Exchange Act § 13 or § 15(d), ≥ 90 days before sale) | **6 months** |
| **Non-reporting issuer** | **12 months** |

The clock starts from the **later of**: (a) the date the securities were acquired from the issuer or an affiliate, or (b) the date full payment was made. Promissory notes / installment contracts do not satisfy the payment requirement unless full-recourse, separately-secured, and discharged before sale.

**Tacking rules** (Rule 144(d)(3)) — the holding-period clock can carry over from a previous holder in defined cases: stock dividends, conversions / exchanges, contingent issuance, pledges (recourse only), gifts, trusts, estates, holding-company formations, cashless exercise. Rule 145(a) transactions and non-recourse pledges restart the clock.

## Current Public Information (Rule 144(c)) — The Practical Killswitch

> [!warning] The binding constraint for non-reporting issuers
> Rule 144(c)(2) requires that **publicly available information** equivalent to Rule 15c2-11 be on file — current financials, business description, officers / directors, capital structure. For a **non-reporting issuer**, this is a real ongoing operational commitment. **Without it, affiliates cannot use Rule 144 at all** — full stop. The Rule 144 path is closed entirely, regardless of holding period or volume.

For reporting issuers, the requirement is satisfied by being current in Exchange Act filings (10-K, 10-Q, etc.). The non-affiliate-path 1-year branch removes this requirement entirely after 12 months for non-affiliates.

## Volume Limitations (Rule 144(e)) — Affiliates Only

In any 3-month period, affiliate sales of a class are capped at the **greatest of**:
- **1%** of the shares or other units outstanding (binding constraint for illiquid securities)
- Average weekly reported volume on national securities exchanges during the 4 weeks preceding Form 144 filing (or sale order if no Form 144)
- Average weekly volume reported pursuant to an effective transaction reporting plan during the same 4-week period

For debt securities, an alternative **10% of the tranche** cap applies if greater.

**Aggregation rules** (Rule 144(e)(3)) — sales by pledgees / donees / trust settlors / estates / persons acting in concert / household members are aggregated under defined conditions. **Reg S offshore sales are explicitly excluded** from the aggregation — Reg S Rule 904 is the offshore escape valve for affiliates.

## Manner of Sale (Rule 144(f)) — Affiliates Only

Three permitted manners:
1. **Brokers' transactions** under Section 4(4) (defined further in Rule 144(g))
2. Direct transactions with a **market maker**
3. **Riskless principal transactions** subject to conditions

Affiliate sellers may NOT solicit orders to buy or make payments to anyone other than the executing broker. Estates of deceased non-affiliates and debt securities are exempt from the manner-of-sale requirement.

## Brokers' Transactions (Rule 144(g))

The broker must:
- Execute as agent only, no more than usual and customary commission
- Not solicit buy orders (with narrow exceptions: dealers who indicated interest within 60 days, customers who indicated unsolicited interest within 10 business days, certain ATS and inter-dealer quotation system arrangements)
- Perform a reasonable inquiry on the seller (length of holding, nature of acquisition, recent sales aggregation, etc.)
- Be unaware (after inquiry) of facts indicating the seller is an underwriter or the transaction is part of a distribution

## Form 144 Filing (Rule 144(h))

Required when an affiliate proposes to sell more than **5,000 shares OR more than $50,000** in any 3-month period. Filing is **concurrent with** the sale order placement (not before, not after). For reporting issuers, electronic filing via EDGAR; for non-reporting, three paper copies.

## Shell Company Carve-Out (Rule 144(i))

Rule 144 is **unavailable** for resales of securities initially issued by:
- An issuer with no or nominal operations AND either no/nominal assets or cash-equivalent-only assets (a "shell company")
- **Any issuer that previously was a shell company** — the taint follows the entity through corporate reorganizations

For former shells, Rule 144 becomes available again only after:
- Issuer is subject to Exchange Act reporting
- All required reports filed for the preceding 12 months (other than 8-Ks)
- Current "Form 10 information" filed with the SEC reflecting non-shell status
- **At least 1 year has elapsed** since the Form 10 information was filed

This is the operative rule for **resale paths after a de-SPAC merger** — the SPAC-origin taint requires the post-merger entity to clear the 1-year wait.

## Rule 144 + Regulation S — The Critical Bridge

[[Regulation-S]] Rule 905 deems Cat 3 domestic-issuer equity acquired offshore to be **"restricted securities" under Rule 144 indefinitely**, even after Reg S secondary trades. The label survives multiple offshore Rule 904 resales. Only a successful Rule 144 non-affiliate sale (post-holding period, satisfying §144(b)(1)) can strip the restricted label.

This is the most-misunderstood aspect of Reg S Cat 3 in practice: the 12-month Reg S distribution compliance period and the 12-month Rule 144 holding period for non-reporting issuers run **concurrently** and are **structurally independent**:

- The Reg S clock blocks **all** sales to U.S. persons until expiry (regardless of who is selling)
- The Rule 144 clock gates **non-affiliate U.S. resales** to a "permitted manner" path after expiry

For a domestic non-reporting issuer with affiliate-free architecture (e.g., the InnBlockchain real-estate RWA pattern at [[Real-Estate-RWA-Reg-S-Implementation]]), the two clocks expire at the same time and the post-expiry resale path is the clean non-affiliate Rule 144(b)(1)(ii) path — no volume cap, no manner-of-sale restriction, no current-information requirement, no Form 144.

## Rule 144 vs Rule 144A

The two are commonly confused but operate in different worlds:

| | Rule 144 | [[Rule-144A]] |
|---|---|---|
| Purpose | Resale safe harbor for restricted securities (general) | Resale to QIBs (qualified institutional buyers) specifically |
| Holding period? | Yes (6 mo reporting / 12 mo non-reporting) | None — immediate QIB resale permitted |
| Volume cap? | Yes for affiliates | No |
| Resale "washing" of restricted status? | Yes for non-affiliate resales | No — securities remain restricted |
| Common deal structures | Reg D / Reg S → public market via Rule 144 after holding period | Combined 144A / Reg S global offerings (US institutional + offshore tranches) |

## Common Failure Modes

1. **Treating Rule 144 as automatic.** Conditions must be affirmatively satisfied at every sale. Holding period clearing alone is not enough if current-public-information has lapsed (for reporting-issuer first-year resales) or volume / manner / Form 144 conditions fail (for affiliates).
2. **Forgetting the 90-day affiliate tail.** Recently-ex-affiliates are still on the affiliate path. Rule 144(b)(1)'s "not an affiliate during the preceding 90 days" requirement is the gating language.
3. **Aggregation oversight.** Failing to aggregate sales across household members, controlled entities, concerted-action groups, donees, and trust settlors → inadvertent volume cap breach.
4. **Tacking errors on conversions / amendments.** Assuming the clock tacks back when amendment consideration was paid (it does not — tacking begins from the amendment date).
5. **Shell-company taint missed** — common in de-SPAC and reverse-merger structures. Rule 144 is unavailable until 1 year after Form 10 information is filed.
6. **Non-reporting issuer Rule 15c2-11 lapse.** Affiliate sales completely blocked if the issuer's public information is not current.

## Practical Note for InnBlockchain Real-Estate RWA Implementations

For a domestic non-reporting real-estate sponsor doing an offshore Reg S Cat 3 STO:

- **Non-affiliate offshore investors** clear the 12-month Rule 144 holding period concurrently with the 12-month Reg S distribution compliance period. After both clear, U.S. resale via Rule 144(b)(1)(ii) is unconditional (subject only to the offshore-to-onshore mechanics).
- **The sponsor** — by definition an affiliate — would face the full Rule 144(b)(2) affiliate-path machinery (volume cap, manner of sale, current information, Form 144) on any U.S. resale. The Rule 144(c) current-information requirement is typically the binding killswitch for a non-reporting issuer.
- **InnBlockchain's recommended structure** keeps the sponsor's economics at the LLC level (Class B Promote Units) rather than in tokens, removing the affiliate-trading scenario entirely. See [[Real-Estate-RWA-Reg-S-Implementation]] for the architecture; [[Real-Estate-RWA-Reg-S-Affiliate-Addendum]] preserves the full affiliate-machinery option for deals where it cannot be avoided.

## Key Sources

- 17 CFR § 230.144 (the rule itself, including Preliminary Notes)
- 17 CFR § 240.15c2-11 (the current-public-information standard incorporated by Rule 144(c)(2))
- Securities Act §§ 4(a)(1), 5, 2(a)(11) (statutory framework: Rule 144 removes the seller from the underwriter definition, making the Section 4(a)(1) exemption available)
- Form 144 (17 CFR § 239.144) — the notice form
- OFAC Economic Sanctions Enforcement Guidelines (31 CFR Part 501 Appendix A) — Rule 144 sales remain subject to OFAC, see [[OFAC-Sanctions]]
