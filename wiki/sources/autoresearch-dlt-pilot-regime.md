---
type: source
title: "autoresearch: DLT Pilot Regime"
source_type: web_research
date_published: 2026-05-14
url: multiple
confidence: high
key_claims:
  - Regulation EU 2022/858 applicable March 23, 2023; permissions valid up to 6 years
  - 4 confirmed authorized platforms: Clearstream D7 DLT (Oct 2024), 21X AG (Dec 2024), 360X AG (Apr 2025), LISE (Oct 2025)
  - ESMA Art.14 review published June 25, 2025 recommends permanent regime, tiered thresholds, extended scope
  - EU Commission Market Integration Package April 21, 2026: €100B cap, removed equity restriction, CASPs eligible, permanent authorizations
  - ECB wholesale CBDC initiative expanded Feb 20, 2025; Bundesbank Trigger Solution operational for DLT settlement
  - 10 applications in pipeline including Axiology (Lithuania), Securitize (Spain)
  - LISE: first tokenized IPO in EU (ST GROUP, April 9, 2026)
  - 21X: €500M DLT debt issue; Stellar integration; USDC atomic settlement; opened Sept 8, 2025
tags:
  - DLT-Pilot-Regime
  - EU
  - tokenization
  - autoresearch
related:
  - "[[DLT-Pilot-Regime]]"
  - "[[21X-AG]]"
  - "[[LISE]]"
  - "[[MiFID-II]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[Research: DLT Pilot Regime]]"
---

# autoresearch: DLT Pilot Regime

**Session:** 2026-05-14 | **Rounds:** 2 | **Searches:** 9 | **Pages fetched:** 4

## Primary Sources Used

1. **ESMA** (direct) — Art.14 report June 25, 2025; ESMA press releases; DLT Pilot Regime page
2. **DLA Piper** — ESMA amendments analysis; May 2025 "regime under review" explainer
3. **Goodwin Law** — ESMA report legal barriers analysis
4. **Ledger Insights** — Clearstream D7 DLT launch; LISE tokenized IPO; EC upgrade; 21X first license; 360X profile
5. **21X AG** (direct) — ESMA report response; platform milestones; Stellar integration; USDC settlement
6. **AMF France** (direct) — DLT Pilot Regime application process; exemption mechanics; compensatory measures
7. **EU Commission** (direct) — April 21, 2026 DLT and tokenisation announcement
8. **Globe Newswire / Coindesk** — LISE license; ST GROUP IPO; 360X xStocks
9. **ECB** (direct) — wholesale CBDC exploratory work; Trigger Solution; expanded initiative Feb 2025

## Search Queries Run

Round 1:
- "DLT Pilot Regime Regulation EU 2022/858 mechanics exemptions application process MiFID II CSDR"
- "ESMA Article 14 review DLT Pilot Regime 2025 report recommendations permanent"
- "Clearstream DLT settlement system tokenized securities 2024 2025"
- "21X AG DLT TSS trading settlement system tokenized securities EU pilot 2024 2025"
- "EU Commission DLT Pilot Regime upgrade proposal April 2026 permanent tokenized securities"

Round 2:
- "360X AG DLT MTF tokenized securities EU pilot regime Frankfurt 2025"
- "ESMA DLT Pilot Regime barriers uptake legal hurdles why limited adoption 2025"
- "ECB wholesale CBDC trigger solution DLT settlement tokenized securities Bundesbank 2024 2025"
- "DLT Pilot Regime pending applicants pipeline platforms 2025 2026"

## Confidence Notes

- Authorized platform dates: **high** (ESMA official page + company press releases)
- ESMA Art.14 barriers: **high** (official ESMA report + multiple practitioner analyses)
- EC April 2026 package: **high** (EU Commission official announcement + Ledger Insights)
- 10 pipeline applications figure: **medium** (cited in search summaries, exact source is ESMA report)
- ECB wholesale CBDC: **high** (ECB official announcements)
- "CSD Prague" discrepancy: **low confidence on this specific claim** — one source cites "CSD Prague" for the Oct 11 2024 authorization that other sources attribute to Clearstream. Flagged in concept page.

---

## Addendum — Internal DLT Pilot Regime Readiness Checklist (Ingested 2026-05-24 at v1.2)

**Source:** `.raw/InnBlockchain/EU Compliance/dlt-pilot-checklist.md` (v1.2, hash `41e046e2dcc7d2cc55c8d3e76d2bcf5a`)
**Type:** Internal InnBlockchain practitioner artifact — pre-NCA-application readiness assessment for DLT MTF / DLT SS / DLT TSS operators, 13 sections, scorecard format, written from the perspective of "what a specialist EU markets-infrastructure lawyer walks a founder through in a first intake meeting."
**Why it lives here**: filed under this dedicated DLT Pilot autoresearch source page (not as a separate source) per the same convention used for the mica-checklist and dora-checklist additions to [[EU-MiCA-DORA-AML-2025]]. The operational detail it contributes is integrated into [[DLT-Pilot-Regime]] (article-by-article anchor points added).

### Ingest Summary (2026-05-24, v1.2)

Source written from training-data knowledge + this autoresearch source (the May 14 web research session), then put through **two verification passes** against the actual Regulation (EU) 2022/858 text retrieved via Wayback Machine (live EUR-Lex blocks automated fetches behind AWS WAF). The two passes corrected **20+ material errors** in v1.0:

**v1.1 corrections (first pass):**
- Article 4(2) exemption: source was MiFID II Article 53(3) (MTF membership), not Article 19(1) — added the 7 statutory conditions on each admitted natural/legal person.
- Article 5 paragraph numbering reconstructed throughout: 5(2)=book-entry/securities account (CSDR 2(1)(4)/(9)/(28), 3, 37, 38); 5(3)=settlement discipline (CSDR 6,7); 5(4)=outsourcing (CSDR 19); 5(5)=participants beyond Directive 98/26/EC Art 2(f) (not CSDR 33 as v1 said); 5(6)=CSDR 33/34/35; 5(7)=CSDR 39 with T+2 ceiling; 5(8)=CSDR 40 cash-settlement (central-bank money / commercial bank money / e-money tokens, credit-institution carve-out under €6bn); 5(9)=CSDR 50/51/53.
- Article 6 statutory carve-outs added: 6(1)(b) carves out CSDR Articles 9, 16, 17, 18, 20, 26, 27, 28, 31, 42, 43, 44, 46, 47 for investment-firm-operated TSS; 6(2)(b) carves out MiFID II Articles 5–13 for CSD-operated TSS. These are the structural carve-outs that make a single-entity DLT TSS legally possible.
- Article 3 corrections: removed unsupported "sovereign-bond exclusion" claim; added Article 3(1)(b) €200m corporate-bond carve-out; added Article 3(6) NCA lower-threshold power; corrected Article 3(2) to "shall not exceed €6bn at the moment of admission"; added Article 3(4) monthly-average calculation method and Article 3(5) monthly threshold-reporting cadence.
- Article 7(5): added "without prior express written consent" of the client — DLT Pilot permits consent-based reuse of client assets (explicit contrast with MiCA Article 75 which prohibits it absolutely).
- Article 7(6): corrected operator-liability wording — capped at market value of asset lost; sole defence is "external event beyond reasonable control, consequences unavoidable despite all reasonable efforts"; NCA may require additional own funds OR insurance under Art 7(6) 3rd subparagraph.
- Article 7(7): added retail-investor protection specificity and "updated on ongoing basis with prior NCA approval"; added Article 7(8)/(9)/(10) take-over-arrangement obligations with 3-month receiving-CSD response deadline (no refusal on market-share grounds) and 5-year deadline for arrangements to be in place.
- Articles 8/9/10 procedural corrections: NCA completeness check is **30 working days** (not 25); added ESMA non-binding-opinion 30-calendar-day step; added 90-working-day statutory decision deadline; added refusal grounds (8(10)/9(10)/10(10)) and withdrawal grounds (8(12)/9(12)/10(12)).
- Article 11(1): periodic reporting frequency corrected to **6 months** (not quarterly); added 4-month advance notification requirement for material business-plan changes; enumerated the 5 categories of without-delay notifications.
- Article 19: corrected entry-into-force / application dates (general application 23 March 2023; Articles 8(5)/9(5)/10(6) and 17 from 22 June 2022; Article 16 from 4 July 2021).
- New section 12.3 added: Articles 16/17/18 amendments to MiFIR / CSDR / MiFID II — including the structurally important **MiFID II Art 4(1)(15)** amendment that confirms DLT-issued instruments are MiFID financial instruments (the legal anchor for the entire tokenized-securities regime, independent of pilot continuation).

**v1.2 corrections (second pass):**
- Section 2.1 Type B (DLT SS): added the Article 2(7) initial-recording and safekeeping arms of the definition that v1.1 omitted (DLT SS is not just a settlement system — it also covers initial recording and safekeeping of DLT FIs).
- Section 2.1 "single-permission rule" softened: regulation does not expressly prohibit holding both DLT MTF and DLT SS permissions in the same entity; it gates them on different underlying licences (investment firm vs. CSD).
- Section 10.2 step 8a corrected: CSDR Article 12 relevant authorities provide a non-binding opinion for **both DLT SS** (Article 9(7), 4th subparagraph) **and DLT TSS** (Article 10(8)) — v1.1 incorrectly limited this to TSS.
- Section 9.1 MAR application: now anchored directly in **Article 3(7)** of the DLT Pilot (rather than derived from MiFID II financial-instrument status); clarified that Article 3(7) covers admission to trading on DLT MTF/TSS but does not extend MAR to DLT FIs only recorded on a DLT SS.

### What the Checklist Adds (Beyond the May 14 Web Research)

Web research above is macro (platforms, ESMA recommendations, EC April 2026 package). The internal checklist is micro (article-level requirements, exemption-paragraph-by-paragraph compensatory measures, dossier contents, statutory timelines). The two are complementary, not duplicative.

**Material integrated into [[DLT-Pilot-Regime]] (v1.2 of the checklist informed the rev):**

1. **Two-document Article 7(1) duty** — separate business plan (filed with NCA) AND publicly-available written rules with binding legal terms (governing law, dispute settlement, insolvency protection under Directive 98/26/EC, jurisdictions for legal action). The autoresearch concept page treated this as one document.
2. **Article 4 has only two exemption pathways** — the autoresearch concept page implied a broader catalogue; correct picture is (i) Article 4(2) extension of MiFID II Article 53(3) for direct natural/legal-person admission (with 7 cumulative conditions), and (ii) Article 4(3) exemption from MiFIR Article 26 transaction reporting (with "regulatory observer participant" compensatory access).
3. **Article 5 nine-paragraph exemption catalogue** — fully enumerated against CSDR provisions (above). Each exemption has its own paragraph-specific compensatory-measure conditions baked into the regulation.
4. **Article 6 dual-track TSS structure** — Track 1 (investment firm / market operator-operated): subject to MiFIR+MiFID II in full, plus CSDR *mutatis mutandis* WITH statutory carve-outs from 14 CSDR articles (the 6(1)(b) list). Track 2 (CSD-operated): subject to CSDR in full, plus MiFID II *mutatis mutandis* WITH statutory carve-outs from MiFID II Articles 5–13 (the 6(2)(b) list). These statutory carve-outs are the legal mechanism that makes a single-entity DLT TSS possible.
5. **Article 7(5) consent-based asset reuse permitted** — explicit divergence from MiCA Article 75 (which prohibits use of client crypto-assets on own account outright). For a CASP also operating in MiCA scope, the asset-use rules are stricter than for a DLT MI — important for service-design conversations with prospects active in both regimes.
6. **Article 7(8)/(9)/(10) take-over arrangements** — operators who hold only the pilot permission (no parallel standard MiFID MTF / CSDR CSD authorisation) MUST conclude best-efforts arrangements with traditional MTF / CSD operators to take over their operations; receiving CSD must respond within 3 months; arrangements in place no later than 5 years from permission. Practical effect: the receiving infrastructure should be identified during the application phase, not after.
7. **Article 8(7) / 9(7) / 10(8) ESMA non-binding opinion procedural step** — 30 calendar days; ESMA first consults other NCAs; NCA must give due consideration and explain significant deviations to ESMA on request. Adds ~30 days to the realistic timeline.
8. **Article 9(7) 4th subparagraph + 10(8) 4th subparagraph CSDR-Art-12 relevant-authorities opinion** for DLT SS and DLT TSS — separate from ESMA; another 30 calendar days; the bank-supervisory voice in the file.
9. **Article 11(1) without-delay notifications** — five categories enumerated: (a) material business-plan changes (with 4-month advance lead time); (b) cyber-attacks, fraud, theft, serious malpractice; (c) material change to NCA-provided information; (d) technical/operational difficulties; (e) unanticipated risks to investor protection / market integrity / financial stability.
10. **Article 11(4) six-monthly cyclical reporting** — five content elements: summary of 11(1) notifications, number/value of DLT FIs admitted/recorded, number/value of transactions, reasoned assessment of difficulties applying Union/national law, actions taken on exemption conditions and compensatory/corrective measures. Distinct from the Article 3(5) monthly threshold-reporting cadence.
11. **Article 3(4) monthly-average calculation method** — for each DLT FI with the same ISIN, average daily closing price × number recorded; the average is used both for the next-month admission check (€6bn) and the transition-strategy activation check (€9bn).
12. **Article 3(6) NCA lower-threshold power** — NCAs can set caps below €500m / €1bn / €6bn / €9bn for a specific infrastructure based on market size, average capitalisation, and risk profile; lowering the €6bn cap commensurately lowers the €9bn trigger.
13. **Article 3(7) — MAR direct anchor** — MAR applies to DLT FIs admitted on DLT MTF / TSS, anchored directly in the DLT Pilot Regulation (not derived from MiFID II status). MAR does NOT extend to DLT FIs only recorded on a DLT SS without trading-venue admission — narrower than the autoresearch concept page implied.
14. **Articles 16 + 17 + 18 amendments** — permanent legislative changes that remain in force regardless of pilot sunset. The most operationally important is Article 18's amendment to MiFID II Article 4(1)(15), which expressly adds DLT-issued instruments to the financial-instrument definition. This is the structural anchor that confirms a tokenized share / bond / fund unit is a MiFID II financial instrument regardless of pilot continuation — the MiFID II–MiCA boundary does not depend on the pilot.
15. **Article 7(4) NCA-ordered audit** — NCA may require an audit, **NCA appoints the independent auditor, operator pays the cost**. Build audit-readiness and budget for this from day one.
16. **Article 7(6) prudential top-up** — NCA may require additional own funds **or** an insurance policy beyond baseline CSDR / IFR / MiFID II / IFD prudential rules, if the baseline doesn't adequately cover potential client damages.
17. **Operator-strict-liability for loss (Article 7(6) 1st subparagraph)** — operator liable up to market value of asset lost; sole defence is "external event beyond reasonable control, consequences unavoidable despite all reasonable efforts." Higher bar than typical MiFID best-efforts standards.
18. **Refusal grounds (8(10)/9(10)/10(10))** — three statutory refusal grounds: significant risks not addressed; permission sought to circumvent legal/regulatory requirements; operator (or users) unable to comply with Union or national law.
19. **Withdrawal grounds (8(12)/9(12)/10(12))** — six statutory withdrawal grounds: DLT-functioning flaw outweighing benefits; breach of exemption conditions; admission/recording of Article 3(1)-ineligible FIs; Article 3(2) threshold exceeded; Article 3(3) exceeded without activating transition strategy; permission obtained on misleading information / material omission.
20. **Pilot-permission validity is capped twice** — up to 6 years from issuance AND no later than the regime sunset (currently 23 March 2029, originally 23 March 2026 + Article 14(2)(a) 3-year extension power).

### Tensions / Open Items After v1.2 Ingest

- The source is now anchored to verbatim regulation text. Article numbers and percentages reconciled against the actual Article text via **two independent confirmations**: (i) Wayback Machine archive of EUR-Lex CELEX:32022R0858 used during v1.1 / v1.2 correction passes; (ii) **double-confirm pass against local `.raw/InnBlockchain/EU Compliance/dlt.html`** (the original EUR-Lex HTML, cleaner UTF-8, no archival drift) — substantive content identical, every v1.2 claim confirmed verbatim.
- **Methodology lesson for future EUR-Lex-blocked ingests:** check `.raw/` for a local copy of the regulation HTML before falling back to Wayback. The local file is higher-confidence (no mojibake, no archival drift risk) and faster to parse.
- **One verbatim citation in the source preserved as-written even though it appears to be a citation slip:** Article 7(6) 2nd subparagraph cross-references "Articles 8(13), 9(11) and 10(10)" for cessation circumstances. Those paragraph numbers do not correspond to cessation provisions (8(13)=material change; 9(11)=permission duration; 10(10)=refusal grounds) — the intended references look like 8(12)/9(12)/10(12) (withdrawal). The checklist reproduces what the regulation literally states; flagged to counsel if it becomes load-bearing.
- **EC April 2026 Market Integration Package** (€100bn cap, removal of equity restriction, CASP eligibility, permanent regime, MiCA EMT settlement eligibility) is **proposed, not adopted** — the checklist plans against the live regulation and flags the proposal as forward-looking. Pipeline: European Parliament + Council co-decision, expected late 2026.
- **EUR-Lex direct fetch was unsuccessful** — CloudFront WAF JavaScript challenge blocked WebFetch, defuddle, and curl. The Wayback Machine archive (web.archive.org snapshot of CELEX:32022R0858) was used as the verbatim text fallback. Document recommends cross-validating Article-level claims against live EUR-Lex on adoption-day filings.

### Why this matters for InnBlockchain client work

DLT Pilot Regime is the natural Seg-1 RWA (tokenized securities) regulatory frame for the Crypto Native ICP, and is **the wrong frame to ignore** for the FinTech ICP — institutional issuers and traditional CSDs are filing applications. Three corrections this ingest baked into the wiki:

1. **DLT TSS structural carve-out from CSDR (Article 6(1)(b)) is the legal mechanism**, not just an industry pattern. The 14-article CSDR carve-out is *what makes* single-entity venue+settlement legally possible — without it, 21X and LISE could not exist as built. Selling DLT TSS architecture build requires understanding this carve-out at article level.
2. **Settlement-currency reality is that only credit institutions can issue the e-money tokens** used for cash settlement under Article 5(8). Fintech EMIs are excluded; this was identified as a barrier in ESMA's June 2025 Article 14 report. The EC April 2026 package proposes opening this to MiCA EMT issuers — track the legislative timeline because it changes the addressable market.
3. **DLT FIs are not MiCA crypto-assets**, confirmed structurally by Article 18's amendment to MiFID II Art 4(1)(15). This is the article-level evidence for the "MiCA framing routes prospects to the wrong regulator" warning on the concept page — having the article reference makes the warning credible to a compliance counterpart.

The InnBlockchain service map plugs into the pilot at four layers: (i) smart-contract architecture for the Article 7(2) DLT-functioning + Article 7(5) asset-segregation requirements; (ii) ERC-3643 / ONCHAINID identity layer for the Article 4(2) member-onboarding good-repute/competence/consent conditions; (iii) on-chain settlement architecture for the Article 5(7) T+2 ceiling and Article 5(8) DvP requirement; (iv) compensatory-measures evidence pack (the document NCAs grade hardest after the transition strategy).
