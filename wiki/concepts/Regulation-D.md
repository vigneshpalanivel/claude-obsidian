---
type: concept
title: "Regulation D — Private Placement Exemptions"
created: 2026-06-18
updated: 2026-06-18
tags:
  - Regulation-D
  - SEC
  - securities-law
  - private-placement
  - accredited-investor
  - capital-raise
  - US-law
status: current
related:
  - "[[Regulation-S]]"
  - "[[Rule-144]]"
  - "[[Rule-144A]]"
  - "[[OFAC-Sanctions]]"
  - "[[Real-Estate-RWA-Reg-S-Implementation]]"
  - "[[US-Fintech-Compliance-Landscape]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/sales-marketing/Service/Content/US Compliance/reg-d-checklist.md"
    hash: "b20782c9df9e6738a8e4d056cf89008e"
    version: "1.0"
    registered: 2026-06-18
    derived_from: this wiki concept + verbatim cross-check against eCFR §§ 230.500–230.508 (incl. 2020 accredited-investor amendments and 2021 Rule 152 integration framework)
    purpose: "Source-derived InnBlockchain client-facing Regulation D private-placement checklist. 14 sections + scorecard, scoped to 17 CFR §§ 230.500–230.508. Cross-references reg-s-checklist.md (concurrent Reg D + Reg S dual-tranche via Rule 152(b)(2)), rule-144-checklist.md (resale of the restricted securities Reg D produces), and ofac-checklist.md (sanctions screening cumulative with any exemption). v1.0 covers Rule 504 / 506(b) / 506(c), the accredited-investor definition, general conditions (integration, information, general solicitation, resale), bad-actor disqualification, Form D, Rule 508, Section 18 preemption, and enforcement."
---

# Regulation D — Private Placement Exemptions

Regulation D is the dominant set of U.S. private-capital exemptions — **17 CFR §§ 230.500–230.508** — implementing the Securities Act's private-offering exemption (**Section 4(a)(2)**) and small-offering authority (**Section 3(b)**). It lets an issuer raise capital without full Section 5 registration by selling to accredited (and, in limited cases, sophisticated non-accredited) investors.

Reg D is a **safe harbor**, not the outer limit of what is exempt: failing Reg D does not automatically create a Section 5 violation, but the issuer then has to prove a statutory Section 4(a)(2) exemption on first principles, at much higher risk and without the rule's certainty.

> [!warning] Reg D is the whole range 230.500–230.508 — not just "506(c)"
> Rule 506(c) is one sub-exemption inside Reg D. Citing "Reg D" as "230.506(c)" mislabels a single path as the whole regulation. The correct framework citation is **§§ 230.500–230.508**; cite 506(c) only when you specifically mean the general-solicitation / verified-accredited path.

## The Eight Rules of Reg D

| Rule | Function |
|------|----------|
| **500** | Use of Regulation D (general guidance) |
| **501** | Definitions — including **"accredited investor"** and how purchasers are counted |
| **502** | General conditions — integration, information delivery, general-solicitation limits, resale restrictions |
| **503** | **Form D** notice filing |
| **504** | Limited-offering exemption, up to **$10M** / 12 months |
| **505** | **Repealed (2017)** — the old $5M exemption; number reserved |
| **506** | Unlimited-amount exemption — **506(b)**, **506(c)**, plus **506(d)/(e)** bad-actor rules |
| **507 / 508** | Form D disqualification; insignificant-deviation cure |

## The Three Live Paths — 504 vs 506(b) vs 506(c)

Rule 505 is gone. Three exemptions remain; **Rule 506 carries the vast majority of exempt capital**.

| Feature | **Rule 504** | **Rule 506(b)** | **Rule 506(c)** |
|---|---|---|---|
| Max / 12 mo | $10,000,000 | Unlimited | Unlimited |
| Non-accredited buyers | Permitted (state-driven) | Up to **35** sophisticated + unlimited accredited | **None — all accredited** |
| General solicitation | No (unless state-registration path) | **No** | **Yes** |
| Accredited standard | N/A | Reasonable **belief** | Reasonable steps to **verify** |
| Securities restricted? | Yes (unless state-reg exception) | Yes | Yes |
| State Blue Sky | **Registration may apply** | **Preempted** (covered security) | **Preempted** (covered security) |

> [!key] 506's superpower is preemption
> Rule 506(b) and 506(c) securities are "covered securities" under **Section 18 (NSMIA)** — state Blue Sky registration is preempted; states may require only a notice filing + fee. Rule 504 is **not** covered, so it needs state-by-state registration — the main reason 504 is disfavored for multi-state raises.

## "Accredited Investor" (Rule 501(a))

The gateway definition. A purchaser qualifies under **any one** category. Highlights (as amended by the **2020 amendments**):

- **Individual net worth > $1,000,000** — jointly or individually, **excluding the primary residence** (the most-litigated retail trap: home value excluded, related debt up to value excluded, underwater debt and recent home-equity draws count against you).
- **Income > $200,000** (individual) / **$300,000** (joint) in each of the two most recent years, with reasonable expectation of the same.
- **Entities with assets > $5,000,000** (corporations, LLCs, partnerships, trusts) not formed to buy the securities; **entities whose owners are all accredited** (look-through).
- **Directors, executive officers, or general partners** of the issuer.
- **2020 additions:** natural persons holding **Series 7, 65, or 82** licenses; **"knowledgeable employees"** of a private fund; **family offices ≥ $5M AUM**; **spousal equivalents** may pool finances; a catch-all for entities with **"investments" > $5M**.

**Counting non-accredited purchasers (Rule 501(e)):** only non-accredited, non-excluded persons count toward the 35-purchaser cap in 506(b) — accredited investors and certain relatives/controlled entities are excluded from the count.

## 506(c) Verification — the Audit Target

506(c) permits **general solicitation** (public marketing, website, social, demo days), but every purchaser must be accredited **and verified**. A **reasonable belief is not enough** — self-certification check-boxes fail 506(c). Non-exclusive safe-harbor methods:

1. **Income** — review IRS forms (W-2, 1099, 1040, K-1) for two years + written representation.
2. **Net worth** — review assets + a consumer credit report (dated within 3 months) + written representation that all liabilities are disclosed.
3. **Third-party letter** — written confirmation from a registered broker-dealer, SEC-registered adviser, licensed attorney, or CPA.
4. **Prior-investor carryover** — certification from an accredited investor already in the issuer's prior 506(b) round.

## General Conditions (Rule 502)

- **Integration (Rule 502(a) → Rule 152, 2021):** separate offerings don't integrate if each independently complies or is exempt. Four safe harbors — the **30-day separation** and the **Rule 701 / employee-plan / Regulation S** safe harbor (Rule 152(b)(2)) are the ones that matter for token raises.
- **Information (502(b)):** if any **non-accredited** purchaser participates (504 or 506(b)), scaled financial + non-financial disclosure must be furnished before sale. Accredited-only offerings have no mandated disclosure (anti-fraud still applies).
- **General solicitation (502(c)):** prohibited for 504 and 506(b); permitted for 506(c).
- **Resale (502(d)):** Reg D securities are **restricted securities** — resale needs Rule 144, registration, or another exemption. Reasonable care = inquiry, written restriction disclosure, and a restrictive legend.

## Bad-Actor Disqualification (Rule 506(d)/(e))

Rule 506 is **unavailable** if any "covered person" (issuer, directors, executive/participating officers, 20% voting owners, promoters, placement agents, fund managers) has a disqualifying event (criminal convictions, injunctions, regulator bars/fraud orders, SEC cease-and-desist for scienter fraud or Section 5, SRO expulsion) within the look-back windows. A **reasonable-care exception (506(d)(2)(iv))** applies if the issuer conducted a factual inquiry — so **bad-actor questionnaires for every covered person, refreshed each offering**, are mandatory. Pre-23-Sept-2013 events don't disqualify but must be **disclosed** (506(e)).

## Form D & Housekeeping

- **File Form D on EDGAR within 15 calendar days after the first sale** (Rule 503); amend on material change and annually for continuous offerings.
- **Rule 507:** Reg D is lost to an issuer enjoined for violating the Form D filing requirement.
- **Rule 508:** *insignificant* deviations are forgiven — but the general-solicitation prohibition, the dollar caps, and the non-accredited-purchaser limit are **never** insignificant.

## Reg D + Reg S — the Concurrent Dual-Tranche

The standard token / RWA structure in 2024–2026: **Rule 506(c) for U.S. verified-accredited investors + [[Regulation-S]] for offshore non-U.S. persons**, run concurrently and kept from integrating via the **Rule 152(b)(2)** safe harbor. Keep separate subscription pools, documents, and records; ensure no directed selling efforts into the U.S. from the Reg S leg, and no non-accredited/unverified sales in the 506(c) leg. For a domestic-issuer equity token, the Reg S leg also triggers the **Rule 905** restricted-securities bridge into [[Rule-144]] — see [[Real-Estate-RWA-Reg-S-Implementation]] for the InnBlockchain reference architecture.

## Reg D vs Reg S — Choose the Buyer Pool

| | Reg D (Rule 506) | [[Regulation-S]] |
|---|---|---|
| Buyer | U.S. accredited investors | Non-U.S. persons |
| Geography | U.S. focus; general solicitation under 506(c) | Offshore only, no U.S. solicitation |
| Resale | Restricted securities → [[Rule-144]] | Distribution compliance period + Rule 905 if U.S. issuer |
| Filing | Form D with the SEC | No SEC filing |
| Combined? | Frequently together — Reg D (U.S. accredited) + Reg S (offshore), separate offerings under a Rule 152 safe harbor |

## Common Failure Modes

1. **Inadvertent general solicitation in a 506(b) deal** — a public "we're raising" post kills it.
2. **Self-certification instead of verification in 506(c)** — check-the-box accreditation is not verification.
3. **One non-accredited (or unverified) purchaser in a 506(c) deal** — 506(c) is accredited-only.
4. **Primary-residence miscount** in the $1M net-worth test.
5. **Undiscovered bad actor** — no questionnaires, no reasonable-care defense.
6. **Late/missing Form D** — federal 15-day filing and state notice filings.
7. **Treating Reg D as an anti-fraud shield** — 10b-5 / 17(a) apply regardless.

## Enforcement

A failed exemption is an unregistered offering: **Section 12(a)(1) rescission** (buyers recover price + interest — the practical worst case), plus SEC injunctions/disgorgement/penalties, anti-fraud liability, and — for willful violations — criminal exposure. State Blue Sky actions run in parallel, especially for Rule 504 or missed state notice filings.

> [!tip] Companion source-derived checklist
> A full source-derived Regulation D compliance checklist scoped to 17 CFR §§ 230.500–230.508 is maintained as an internal artifact at `.raw/InnBlockchain/sales-marketing/Service/Content/US Compliance/reg-d-checklist.md` (v1.0, 2026-06-18). It cross-references the parallel [[Regulation-S]], [[Rule-144]], and [[OFAC-Sanctions]] checklists for the regimes Reg D runs alongside — the concurrent Reg S offshore tranche (integration via Rule 152(b)(2)), Rule 144 resale of the restricted securities Reg D produces, and OFAC sanctions screening that applies cumulatively to every U.S.-person transaction regardless of the exemption.
