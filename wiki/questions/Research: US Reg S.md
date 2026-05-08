---
type: synthesis
title: "Research: US Reg S"
created: 2026-05-07
updated: 2026-05-07
tags:
  - research
  - Regulation-S
  - SEC
  - securities-law
  - capital-raise
  - offshore
status: developing
related:
  - "[[Regulation-S]]"
  - "[[Rule-144A]]"
sources:
  - "[[Fourscore-Regulation-S-Guide]]"
  - "[[Cleary-Reg-S-Selling-Transfer-Restrictions]]"
  - "[[Cornell-LII-Rule-902-Definitions]]"
  - "[[Pillsbury-Restricted-Securities-Reg-S]]"
  - "[[Morrison-Foerster-Reg-S-FAQs]]"
  - "[[SEC-Problematic-Practices-Reg-S-1995]]"
  - "[[Cleary-2026-Digital-Assets-Update]]"
---

# Research: US Reg S

## Overview

U.S. Regulation S is a safe harbor under the Securities Act of 1933 that lets companies offer and sell securities **outside the United States** without SEC registration. Adopted in 1990, amended 1998, structurally unchanged through 2026. It is the workhorse for foreign issuers, cross-border bond deals, and the offshore tranche of token offerings — but the safe harbor is binary: violate either of its two core conditions and the entire offering becomes an unregistered U.S. securities offering exposed to rescission, civil penalties, and securities-fraud liability.

## Key Findings

### 1. Two Conditions Decide Everything (Source: [[Cornell-LII-Rule-902-Definitions]])
Every Reg S offering must be (a) an **offshore transaction** — buyer outside the U.S. or trade on a foreign exchange, no U.S.-side offer — and (b) made with **no directed selling efforts** in the U.S. Both conditions must hold for every sale, every interaction. There is no de minimis exception.

### 2. Three Categories Map Risk to Restrictions (Source: [[Cleary-Reg-S-Selling-Transfer-Restrictions]])
Reg S sorts offerings by issuer reporting status, SUSMI (Substantial U.S. Market Interest), and equity-vs-debt:
- **Cat 1** (no SUSMI, foreign government, or overseas-directed): just the two core conditions, no distribution compliance period.
- **Cat 2** (reporting foreign issuer equity, reporting issuer debt, non-reporting foreign issuer debt): 40-day distribution compliance period + offering restrictions.
- **Cat 3** (everything else, including most U.S. private equity): 1 year (U.S. equity) / 6 months (foreign equity) / 40 days (debt), plus hedging restrictions and stricter buyer certifications.

### 3. Rule 905 Is the Most-Misunderstood Rule (Source: [[Pillsbury-Restricted-Securities-Reg-S]])
Equity of a U.S. domestic issuer placed offshore under Reg S **stays restricted under Rule 144** even after the Reg S distribution compliance period ends. The Rule 144 holding period (6 months for reporting issuers, 1 year for non-reporting) governs when those securities can flow back into U.S. public markets. Offshore resales do not "wash" the restriction off. Founders raising abroad routinely miss this.

### 4. The U.S. Person Definition Has Eight Categories With Carve-Outs (Source: [[Cornell-LII-Rule-902-Definitions]])
Beyond the obvious (U.S. residents, U.S.-organized entities), the definition catches U.S. agencies/branches of foreign entities, fiduciary accounts benefitting U.S. persons, and foreign entities formed by U.S. persons to invest in unregistered securities. Carve-outs exist for foreign professional fiduciaries, foreign branches of U.S. banks/insurers in genuine local business, IGOs, and foreign-law employee benefit plans.

### 5. Directed Selling Efforts Are Captured Broadly (Source: [[Cleary-Reg-S-Selling-Transfer-Restrictions]])
Includes U.S. publication ads, U.S. radio/TV, U.S. seminars, contact with persons known to be in the U.S. **Permitted**: tombstone ads required by law (with non-registration disclaimer), offering documents to Rule 144A QIBs, ordinary corporate communications not designed to condition the U.S. market. A single careless email blast destroys the safe harbor.

### 6. 144A + Reg S Combined Is the Standard Cross-Border Bond Structure (Source: [[Morrison-Foerster-Reg-S-FAQs]])
Large bond and convertible deals (MicroStrategy $3B, AECOM $1B cited as examples) sell simultaneously to U.S. QIBs under Rule 144A and to non-U.S. investors under Reg S. Each tranche has its own purchase agreement, transfer legend, and selling-restrictions box. The deal cost premium is significant — only worth it above ~$100M deal size. See [[Rule-144A]].

### 7. Reg D + Reg S Is the Standard Token / Private Placement Structure (Source: [[Cleary-2026-Digital-Assets-Update]])
For U.S. private placements with global reach: Reg D 506(c) (allows general solicitation but only to verified U.S. accredited investors) plus Reg S (for non-U.S. persons). KYC/AML at the onboarding layer enforces the U.S.-person split. Modern integration safe harbors protect concurrent offerings if marketing channels stay separate.

### 8. The 1995 Problematic Practices Release Still Drives the Doctrine (Source: [[SEC-Problematic-Practices-Reg-S-1995]])
SEC Release 33-7190 publicly called out sham offshore closes, pre-arranged U.S. flowback, and offshore hedging-during-restricted-period schemes. The 1998 amendments (Rule 905, 1-year U.S. equity period, hedging restrictions) flowed directly from this release. Substance over form: the SEC will look through paper offshoreness if the economic reality is U.S.-bound.

### 9. 2025 Shifted the Enforcement Climate but Not the Rules (Source: [[Cleary-2026-Digital-Assets-Update]])
Under SEC Chairman Atkins, the 2025–2026 posture is friendlier to digital-asset issuers and re-centered on fraud + investor harm, not technical violations. The GENIUS Act gave stablecoins federal footing. **Reg S itself is unchanged.** The rules that worked in 2020 work in 2026; the difference is the surrounding regulatory tone.

## Key Entities

- **SEC** — promulgates and enforces Regulation S; current Chairman Paul Atkins (2025–)
- **QIBs** — Qualified Institutional Buyers, the eligible buyer pool under Rule 144A (≥$100M discretionary AUM)
- **Cleary Gottlieb, Pillsbury, Morrison & Foerster** — top capital markets firms; their practitioner guides are the de facto market interpretations

## Key Concepts

- [[Regulation-S]]: the safe harbor itself, with the three categories and core conditions
- [[Rule-144A]]: the QIB resale safe harbor that pairs with Reg S in global offerings
- **SUSMI** (Substantial U.S. Market Interest): the Rule 902(j) test that decides Cat 1 vs Cat 2/3 — equity SUSMI = U.S. is largest market or ≥20% trading; debt SUSMI = >300 U.S. holders + >20% U.S. + >$1B principal
- **Distribution compliance period**: post-closing window blocking U.S.-person resales
- **Directed selling efforts**: any activity conditioning the U.S. market for the offered securities
- **Restricted security** (under Rule 144): how Rule 905 keeps U.S. domestic equity sold offshore from being "washed" of its U.S. resale restrictions

## Contradictions

None of the sources contradict each other on doctrine — Reg S has been stable for 25+ years. The contemporary disagreement is on **enforcement tone**:
- Pre-2025 view (regulation-by-enforcement): SEC may second-guess any digital-asset offering after the fact
- 2025+ view ([[Cleary-2026-Digital-Assets-Update]]): SEC explicitly de-emphasizing technical violations, focusing on fraud
- Practical reading: structure compliantly anyway — administrations change, and securities-fraud private rights of action are unaffected.

## Open Questions

- **For a non-U.S. issuer (e.g., Indian company) raising from non-U.S. investors with no U.S. nexus**: is Reg S even needed, or is the offering simply outside Section 5 entirely? (Answer in practice: Reg S is used as a belt-and-suspenders safe harbor whenever there is *any* U.S. touchpoint — U.S. counsel, U.S. placement agent, U.S. data center hosting investor portal, etc.)
- **What is the practical SUSMI test for a private U.S. company with no public trading market?** Likely no SUSMI → Cat 1 → lightest restrictions. But the analysis interacts with whether the issuer is also relying on Reg D for U.S. accredited buyers in the same raise.
- **For a tokenized securities offering with global onboarding**: how strict must the geofencing be to satisfy the "no directed selling efforts" condition? Industry practice varies; conservative counsel requires IP geoblocking, KYC location verification, and U.S.-person attestations.
- **Does general solicitation under Reg D 506(c) (e.g., a public LinkedIn post) become directed selling efforts for the concurrent Reg S tranche?** Practitioners separate marketing channels — Reg D content stays gated to accredited-only landing pages, Reg S marketing happens through offshore-only channels. Untested edge cases remain.
- **Tokenized resale on offshore secondary markets within the distribution compliance period**: the doctrine is clear (still restricted) but the smart-contract enforcement layer is novel. No public SEC enforcement on this fact pattern as of 2026-05.
- **Trioangle / India-context use case**: Reg S is irrelevant unless raising capital from U.S. investors *or* using a U.S. issuance vehicle. For a pure India-based capital raise from Indian/foreign-non-U.S. investors, SEBI rules apply, not Reg S. Worth confirming the actual fundraising structure before deeper research.

## Sources

- [[Fourscore-Regulation-S-Guide]] — Fourscore Business Law, primer
- [[Cleary-Reg-S-Selling-Transfer-Restrictions]] — Cleary Gottlieb, practitioner framework
- [[Cornell-LII-Rule-902-Definitions]] — primary regulatory text (17 CFR § 230.902)
- [[Pillsbury-Restricted-Securities-Reg-S]] — Pillsbury, on Rule 905 and restricted-security treatment
- [[Morrison-Foerster-Reg-S-FAQs]] — Mofo, FAQ-format primer
- [[SEC-Problematic-Practices-Reg-S-1995]] — SEC Release 33-7190, foundational anti-abuse doctrine
- [[Cleary-2026-Digital-Assets-Update]] — Cleary, 2025–2026 SEC posture and crypto offerings
