# EU Listing Act Business Readiness Checklist
## The Legal Advisor's First-Meeting Guide to the EU Listing Act Reforms for Companies Going (or Already) Public in the EU

**Prepared by InnBlockchain** | Smart Contract Engineering & Security Audit for Regulated FinTechs
**Regulation:** EU Listing Act — Regulation (EU) 2024/2809 of 23 October 2024 amending Regulations (EU) 2017/1129 (Prospectus), (EU) No 596/2014 (MAR), and (EU) No 600/2014 (MiFIR)
**Companion instruments in the Listing Act package:** Directive (EU) 2024/2810 (amending MiFID II and repealing Directive 2001/34/EC — the old Listing Directive); Directive (EU) 2024/2811 (multi-vote share structures for SME growth markets)
**Source:** https://eur-lex.europa.eu/eli/reg/2024/2809/oj
**Status:** Entered into force **4 December 2024** (20th day after OJ publication); phased application — **4 December 2024 / 5 March 2026 / 5 June 2026** (see Section 8)
**Document type:** Package-level readiness assessment for companies preparing to list, already listed, or operating as a market participant affected by the reforms

---

> **Who this document is for:** Founders, CFOs, GCs, Heads of IR / Compliance, and finance directors at companies that (i) are preparing for an IPO or secondary listing on an EU regulated market or SME growth market, (ii) are already listed and now need to absorb the Listing Act's ongoing-disclosure reforms (especially the MAR Article 17 protracted-process change), or (iii) are intermediaries, market operators, or trading venues whose obligations shift under the Listing Act. This checklist mirrors the package-level intake a specialist EU capital-markets lawyer would walk you through in a first advisory session.

---

> **How this checklist fits with the rest of the InnBlockchain EU stack:** The Listing Act is a **horizontal package** that amends three existing regulations rather than creating a new one. For deep operational detail on each amended instrument:
> - **Prospectus content, exemptions, formats, scrutiny** → see [[prospectus-checklist.md]]. This document only covers the **delta** the Listing Act creates and the **package-level decisions** an issuer must make.
> - **MiFID II authorisation & conduct envelope (investment firms, venues)** → see [[mifid2-checklist.md]]; the Listing Act companion directive 2024/2810 also amends MiFID II — flagged in Section 6.
> - **MiFIR transparency, transaction reporting, Article 25 record-keeping** → see [[mifir-checklist.md]]. The Listing Act amends MiFIR Article 25 only — covered in Section 5.
> - **MiFID III future-state reforms (Directive 2024/790 + Regulation 2024/791)** → see [[mifid3-checklist.md]]. These are a separate, parallel package (the **MiFID/MiFIR Review**) — do not conflate with the Listing Act.
> - **MiCA crypto-asset regime** → see [[mica-checklist.md]]. MiCA applies to crypto-assets that are **not** financial instruments. Tokenised transferable securities (security tokens, tokenised bonds, tokenised equity) sit inside the Listing Act / Prospectus / MAR perimeter — the form does not change the substance.

---

> **What the Listing Act actually does — in one paragraph:** The Listing Act is the EU's targeted attempt to make Union public markets more attractive after a decade of net-negative IPO flow and SME delistings. It does **three things at the regulation level** (this file) and **two more at the directive level**:
> 1. **Streamlines the prospectus** — shorter standard prospectus, new EU Follow-on prospectus (for already-listed issuers) and EU Growth issuance prospectus (for SMEs), wider exemptions (fungibility threshold raised 20%→30%, single offer threshold of €12M or MS-elected €5M), longer URD validity, faster scrutiny.
> 2. **Reduces ongoing MAR burden** — Article 17 protracted-process disclosure narrowed to the **final event** only, buy-back reporting simplified, managers' transactions threshold raised (€5k → €20k, MS-extendable to €50k), administrative-sanctions framework recalibrated against SME-proportionate floors.
> 3. **Loosens MiFIR Article 25** record-keeping — narrower scope of order/transaction records investment firms must retain.
> 4. **Amends MiFID II (via Directive 2024/2810)** to remove the SME-growth-market liquidity-contract barrier and update bundling of investment research (companion-only — out of scope of this regulation but relevant for the same offering).
> 5. **Authorises multi-vote share structures on SME growth markets (Directive 2024/2811)** — a deliberate IPO-incentive carve-out from the one-share-one-vote default.
>
> If your project is a new EU listing in 2026 or later, you are operating under the **post-Listing-Act regime**. If you are advising a pre-2024 listed company, you are operating in a **transitional regime** with material rule changes through 5 June 2026.

---

## SECTION 1 — DOES THE LISTING ACT APPLY TO YOU?

*Unlike a single substantive regulation, the Listing Act is a bundle of amendments. The question is not "does the Listing Act apply" — it is "which amendment limb catches you, and on what date does it bite?"*

---

### 1.1 — Entity Scope — Which Listing Act Limb Catches You?

Tick every category that describes your entity. Each row points to the relevant Listing Act limb and the substantive checklist to read after this one.

- [ ] **Issuer preparing an IPO on an EU regulated market** (first admission of a class of shares) — caught by **Article 1** (Prospectus) and **Article 2** (MAR) amendments → continue here, then go to [[prospectus-checklist.md]]
- [ ] **Issuer preparing an IPO on an EU SME growth market** (MTF registered as SMEGM under MiFID II Article 33) — caught by Articles 1 and 2 plus **Directive 2024/2811** (multi-vote shares opt-in) → continue here, then [[prospectus-checklist.md]] §3 (EU Growth issuance prospectus track)
- [ ] **Issuer already admitted to trading on an EU regulated market or SMEGM** — caught by **Article 2 (MAR)** changes (new Article 17 disclosure timing; new buy-back reporting; raised managers'-transaction threshold) **regardless of when listed** → Section 4 below is mandatory reading
- [ ] **Issuer planning a secondary equity or non-equity issuance** (already listed ≥18 months continuously) — caught by **Article 1 point (7)(g)** (new EU Follow-on prospectus from 5 March 2026) → [[prospectus-checklist.md]] §4
- [ ] **SME (market cap < €500M or other Annex II eligibility) considering a new public bond programme** — caught by raised €150M continuous-issuance threshold (Art 1(4)(j), (5)(j) of Prospectus Reg) made **permanent** by Listing Act → [[prospectus-checklist.md]] §1.3
- [ ] **Investment firm** providing investment services / executing client orders — caught by **Article 3** (MiFIR Article 25 record-keeping narrowing) → [[mifir-checklist.md]] §6
- [ ] **Trading venue (RM, MTF, OTF, SMEGM) operator** — caught by Article 1 (Prospectus venue interactions), Article 2 (MAR cooperation platforms, designated cross-border venues, order-data sharing under new MAR Articles 25a / 25b), and Directive 2024/2810 (MiFID II) → Section 6
- [ ] **Director / PDMR (Person Discharging Managerial Responsibilities) or closely associated person** at a listed issuer — caught by Article 2 amendments to MAR Article 19 (raised €5k → €20k threshold; MS opt-up to €50k) → Section 4.4
- [ ] **Third-country issuer** with EU offer or admission — caught by reformed Article 29 (equivalence) and Article 30 (third-country cooperation arrangements) of Prospectus Regulation → [[prospectus-checklist.md]] §10
- [ ] **DLT MTF / DLT SS / DLT TSS** operator under Regulation (EU) 2022/858 — caught indirectly: the underlying instruments (tokenised transferable securities) are inside the Prospectus / MAR / MiFIR perimeter, so Listing Act amendments apply substantively → Section 7

---

### 1.2 — Reform-Limb Map — What Changes for You Specifically?

The Listing Act has three limbs. Tick the limbs that touch your business model. If you tick more than one, plan a phased internal rollout aligned with Section 8.

- [ ] **Prospectus limb (Article 1 of Listing Act → amending Regulation 2017/1129)** — relevant if you draw up, scrutinise, or rely on a prospectus
- [ ] **MAR limb (Article 2 → amending Regulation 596/2014)** — relevant if you are a listed issuer, a PDMR, a market operator with surveillance duties, or a competent authority
- [ ] **MiFIR limb (Article 3 → amending Regulation 600/2014 Article 25)** — relevant if you are an investment firm that keeps order/transaction records under MiFIR Article 25
- [ ] **Companion: MiFID II amendments (Directive 2024/2810)** — relevant for investment firms (research bundling, payment for order flow interaction, SME research provision)
- [ ] **Companion: Multi-vote shares (Directive 2024/2811)** — relevant if you are an SMEGM operator, an SME considering dual-class structure for IPO, or an institutional investor with governance constraints

**Reference:** Listing Act Articles 1, 2, 3, 4; recitals 1–4 (problem statement: declining EU IPO volumes; cost of compliance for SMEs).

---

## SECTION 2 — LISTING PATHWAY DECISION — REGULATED MARKET, SMEGM, OR MTF?

*The Listing Act does not change the venue typology. But it changes the relative cost-benefit between regulated market and SME growth market in ways that should reopen the venue decision for any issuer that last benchmarked before 2024.*

---

### 2.1 — Pathway Filter — Which Venue Is Open to You?

Answer each row. If the answer is "no" for a venue, that pathway is closed; if "yes", it remains a candidate.

- [ ] **Regulated Market (RM)** — open to any issuer of transferable securities meeting the venue's admission requirements; prospectus mandatory under Art 3(3) Prospectus Reg unless exemption applies. **Yes / No**
- [ ] **SME Growth Market (SMEGM)** — MTF subject to MiFID II Article 33; open only to issuers where ≥ 50 % of issuers admitted are SMEs (market cap < €200M historical; threshold revised by accompanying Commission acts — check current calibration). **Yes / No**
- [ ] **MTF (non-SMEGM)** — any MTF authorised under MiFID II Article 18; lighter admission regime, no prospectus obligation unless also offering to the public. **Yes / No**
- [ ] **DLT MTF / DLT TSS** — only for tokenised transferable securities under Reg 2022/858; capped by per-instrument and per-venue limits; sunset clauses; see Section 7. **Yes / No**

---

### 2.2 — Cost-Benefit Re-Calibration After the Listing Act

For each pair, confirm you have updated your internal model since 4 December 2024:

- [ ] **Prospectus drafting cost (RM vs. SMEGM):** SMEGM issuers can now use the **EU Growth issuance prospectus** (from 5 March 2026), which is materially shorter than the standard prospectus. Have you updated your prospectus-cost estimate to reflect the 2026 format?
- [ ] **Multi-vote shares (SMEGM only):** Directive 2024/2811 requires Member States to **permit multi-vote share structures for SMEGM IPOs** (subject to MS-defined safeguards) by 5 December 2026. Have you assessed whether multi-vote shares change the founder/family-control calculus that previously argued against going public?
- [ ] **Ongoing MAR compliance (RM vs. SMEGM):** MAR applies to **both** RM and SMEGM with limited proportionality. Listing Act Article 2 narrows protracted-process disclosure for **all** issuers. Recalculate the post-IPO compliance burden under the new Article 17 standard before final venue choice.
- [ ] **Liquidity / index inclusion (RM advantage):** SMEGM remains MTF-category and does not feed major institutional benchmarks. Has the buy-side feedback you used pre-2024 been re-tested?
- [ ] **Cross-listing / passporting:** prospectus passporting works identically across RM and SMEGM. Listing Act does not change this. Confirm.

---

### 2.3 — Voluntary Prospectus Option (NEW Article 4 PR — Listing Act recital and Art 1 amendment)

The Listing Act explicitly confirms that an issuer otherwise **exempt** under Art 1(4)–(5) or Art 3(2)/(2a) PR may **voluntarily** draw up a prospectus and obtain its full passporting / liability framework benefit. Tick if relevant:

- [ ] You are exempt but want to **passport** the offer across the EU → voluntary prospectus track is open
- [ ] You are exempt but want **institutional buyers to rely on the Prospectus Regulation liability regime** rather than ad-hoc disclosure → voluntary prospectus track may be commercially required
- [ ] You have considered the **trade-off**: voluntary prospectus = full prospectus liability + scrutiny cost, in exchange for legal-certainty benefits

**Reference:** Listing Act Article 1, amending Article 4 PR; recital on voluntary prospectus.

---

## SECTION 3 — PROSPECTUS TRACK UNDER THE LISTING ACT

*This section is a navigation layer only. The substantive prospectus checklist (content requirements, exemptions, scrutiny, supplements, third-country regime) lives in [[prospectus-checklist.md]]. The items below identify which Listing Act delta you must apply on top of that checklist.*

---

### 3.1 — Which Prospectus Format Will You Use?

Pick exactly one. Each maps to a distinct Annex and disclosure standard.

- [ ] **Standard prospectus** (registration document + securities note + summary, or single document) — Articles 6 to 13 PR. **Length, summary, format reformed by Listing Act effective 5 March 2026.**
- [ ] **EU Follow-on prospectus** (NEW — replaces both the simplified prospectus for secondary issuances and the EU Recovery prospectus) — new **Article 14a PR** inserted by Listing Act, **applies from 5 March 2026**. Eligibility: issuer has been admitted to RM or SMEGM continuously for ≥18 months and complied with periodic / ongoing disclosure under Directive 2004/109/EC, MAR, or Delegated Reg 2017/565.
- [ ] **EU Growth issuance prospectus** (NEW — replaces the EU Growth prospectus) — new **Article 15a PR** inserted by Listing Act, **applies from 5 March 2026**. Eligibility broadly tracks the old EU Growth prospectus (SMEs; market cap < €500M on SMEGM).
- [ ] **Base prospectus** (for non-equity issued in a continuous or repeated manner) — unchanged in substance; raised €150M credit-institution threshold made permanent.
- [ ] **Universal Registration Document (URD)** — frequent-issuer status now achievable after **1 financial year** of URD approval (down from 2) — Article 9 PR as amended.

---

### 3.2 — Listing Act Prospectus Reforms — Confirm You Have Re-Read Each

For each reform, confirm internal review:

- [ ] **Single threshold of €12M** (or MS-elected €5M) for non-passported public offers — replaces the old €1M / €1M-to-€8M dual structure from 5 June 2026 (Art 3(2) PR as amended)
- [ ] **Removal of the €1M lower threshold** (Art 1(3) PR deleted) from 5 June 2026 — below the MS-chosen threshold, MS may still impose a **national disclosure document**
- [ ] **Fungibility exemption raised 20 % → 30 %** of admitted shares over 12 months (Art 1(5)(a), (b), (c) PR) — already in force since **4 December 2024**, plus extended to public-offer side
- [ ] **Mandatory short-form fungibility-disclosure document** for exempt offers under the 30 % carve-out — issuer files with NCA, no approval required (Article 1(7) PR)
- [ ] **Permanent €150M credit-institution continuous-issuance threshold** (Art 1(4)(j), 1(5)(j))
- [ ] **Language regime narrowed**: prospectus may be drawn up in a language "customary in the sphere of international finance" (effectively English); translation required only for the summary; MS opt-out for purely domestic offers (Art 27 PR)
- [ ] **Standardised order of sections** for prospectus, registration document, securities note, and summary — new Annexes I–V to PR replace old structure (Annex of Listing Act)
- [ ] **Prospectus summary** — extended length permitted with multiple guarantors (Art 7 PR)
- [ ] **Scrutiny period for EU Follow-on prospectus on shares** — aligned with the (now-retired) EU Recovery prospectus's reduced scrutiny period; **does not apply** to a transfer from SMEGM to RM
- [ ] **Six-working-day publication-to-end-of-offer minimum for IPOs** **reduced** by Listing Act (calibration in delegated act) — to permit faster book-building
- [ ] **Supplements regime (Art 23 PR)** — Regulation 2021/337 reforms on financial-intermediary investor contact made **permanent**; electronic-contact requirement clarified
- [ ] **Equivalence regime (Art 29 PR) and third-country cooperation (Art 30 PR)** — third-country prospectus filing (not re-approval); MS / ESMA cooperation arrangements expanded; exclusion of non-cooperative tax jurisdictions and high-AML-risk jurisdictions

> **Cross-reference:** every reform above is also covered in [[prospectus-checklist.md]] §§1–10 with the substantive checklist items. This section confirms scope, not detail.

---

### 3.3 — Transitional Considerations (drafting now, filing across the cutover)

- [ ] Will you file the prospectus **before 5 March 2026**? → old format applies; the new EU Follow-on / EU Growth issuance formats are **not yet available**; pre-Listing-Act standard / simplified-secondary / EU Growth / EU Recovery formats remain valid
- [ ] Will you file between **5 March 2026 and 4 June 2026**? → new prospectus formats apply; **old €1M/€1M-to-€8M threshold regime still in force** for the offer-side exemption
- [ ] Will you file on or after **5 June 2026**? → new prospectus formats **and** new €12M / €5M threshold regime apply
- [ ] Have you confirmed which **delegated acts** (Annexes to Delegated Reg 2019/980) are in force at filing date? — ESMA / Commission delegated acts implementing the Listing Act Annexes are expected on a rolling basis through 2026

---

## SECTION 4 — MAR REFORMS UNDER THE LISTING ACT (THE NOVEL CONTENT)

*This is the section every already-listed issuer must read. The MAR amendments in Listing Act Article 2 are in force **4 December 2024** unless otherwise stated and change how issuers manage inside information, buy-backs, managers' transactions, and competent-authority cooperation.*

---

### 4.1 — New Definition of "Systematic Internaliser" in MAR (Art 3 amendment)

- [ ] You have noted that **"systematic internaliser"** is now a defined term in MAR (Art 3 PR aligned with Art 4(1)(20) MiFID II). This was previously implicit and now matters for trade-flow surveillance and order-data-sharing duties under new MAR Articles 25a / 25b.

---

### 4.2 — Buy-Back Programme Reporting (MAR Art 5)

The safe-harbour for share buy-back programmes under Art 5(1) MAR is preserved but the **reporting mechanics are simplified**.

- [ ] Buy-back transactions reported to the **competent authority of the most relevant market in terms of liquidity** (per Art 26(1) MiFIR), **not** to every NCA of every venue where the shares trade — receiving authority forwards on request
- [ ] Internal procedure updated so trade-reporting feeds the **single receiving NCA** correctly
- [ ] Document chain confirms the issuer can demonstrate which NCA is the "most relevant market" determination at the time of each buy-back
- [ ] Liquidity contracts (often used alongside buy-backs) interaction with new MiFID II amendments (Dir 2024/2810) understood

**Reference:** MAR Article 5(3) as amended by Listing Act Article 2(2).

---

### 4.3 — Inside-Information Disclosure: The Protracted-Process Change (MAR Art 17 — THE biggest issuer-side change)

This is the single most operationally significant change in the Listing Act for already-listed issuers. The previous regime under Article 17(1) MAR required disclosure of inside information **as soon as possible**, including intermediate steps in a protracted process. The Listing Act **narrows the disclosure trigger** to the **final event** only, while preserving the obligation to keep intermediate-step information confidential and to deal with leaks.

- [ ] **Trigger narrowed**: only **final circumstances or final event** of a protracted process must be disclosed as soon as possible (Art 17(1) MAR as replaced)
- [ ] **Intermediate steps**: the issuer must still **ensure confidentiality** of intermediate-step inside information until disclosure of the final event (new Art 17(1a) MAR)
- [ ] Internal disclosure committee / insider-list procedure updated to reflect:
  - [ ] removal of the "intermediate step" disclosure trigger
  - [ ] preservation of the "no delay" rule for the final event
  - [ ] preservation of leak-management duties (Art 17(7) MAR — still in force)
- [ ] Documented case-by-case **list of "final events"** in long-running processes (M&A, drug-trial outcomes, regulatory approvals, contract awards) — Commission empowered to update a non-exhaustive list via delegated act
- [ ] **Delayed disclosure regime (Art 17(4) MAR)** reviewed — still available; conditions tightened in practice by alignment with new Art 17(1)
- [ ] **PR/IR script and Q&A** updated: investors / analysts asking about intermediate steps must be handled without selectively disclosing what the issuer is not (yet) obliged to disclose
- [ ] **Insider lists** still required for inside information regardless of when the disclosure obligation will crystallise
- [ ] Board minutes for any **delayed-disclosure decision** retained per Art 17(4) MAR
- [ ] Issuer confidentiality protocol covers leaks, accidental disclosures, market rumour responses

**Reference:** MAR Articles 17(1), 17(1a) (new) as introduced by Listing Act Article 2(5).

---

### 4.4 — Managers' Transactions Threshold Raised (MAR Art 19)

Pre-Listing-Act, PDMRs and persons closely associated had to notify the issuer and the NCA of any transaction once the **annual aggregate** crossed €5 000. Listing Act raises this to **€20 000**, with Member State discretion to opt up to **€50 000** for some PDMR categories.

- [ ] Annual aggregate threshold updated in internal PDMR notification policy: **€20 000 (default) / €50 000 (MS opt-up where applicable)**
- [ ] Notification template and intranet guidance updated for PDMRs and closely associated persons (spouses, dependent children, controlled legal persons, trusts)
- [ ] Issuer notification window of **3 business days** unchanged
- [ ] Closed-period regime (no transactions in the 30 calendar days before a financial report) unchanged
- [ ] **Reminder cadence to PDMRs** updated to reflect new threshold and that aggregation is annual
- [ ] **Sanctions exposure recalculated** under new MAR Article 30(2) administrative-sanction calibration (see 4.6)

**Reference:** MAR Article 19 as amended by Listing Act Article 2(7).

---

### 4.5 — Market Sounding, Investment Recommendations, and Cooperation (MAR Arts 13, 23 — light-touch amendments)

- [ ] **Market sounding regime (Art 11 MAR)** — substantive obligations unchanged but cooperation framework updated; review MS-level NCA guidance
- [ ] **Investment recommendations (Art 20 MAR)** — disclosure obligations refined for analysts producing recommendations on issuers (see Listing Act Article 2 point 6)
- [ ] **Cooperation between competent authorities (Art 25 MAR)** updated — new paragraph permits a competent authority to obtain order data from a venue with a significant cross-border dimension when that authority is the NCA of the most relevant market under Art 26 MiFIR (new MAR Art 25(4))

---

### 4.6 — Administrative Sanctions — Recalibrated for SMEs (MAR Art 30 + Art 31)

- [ ] **Article 17 infringements (inside-information disclosure)** — administrative pecuniary sanction capped at **2 % of total annual turnover**; minimum **€2 500 000** (SME alternative: **€1 000 000**)
- [ ] **Article 18 / 19 infringements (insider lists / managers' transactions)** — capped at **0.8 % of total annual turnover**; minimum **€1 000 000** (SME alternative: **€400 000**)
- [ ] Internal sanctions-exposure assessment refreshed against the **SME alternative floors** if you qualify as a micro / small / medium-sized enterprise
- [ ] **Aggravating / mitigating circumstances (Art 31(1))** — read against the new sanctions tier; compliance programme documentation should be assessable against Art 31(1)(a), (b), (d)–(h)
- [ ] Whistleblower / breach-reporting channels (Art 32 MAR) confirmed in place

---

### 4.7 — Cross-Border Order-Data Mechanism (NEW MAR Arts 25a, 25b)

This is invisible to most issuers but material to **trading venues and competent authorities**. Tick only if you operate a venue or are an NCA.

- [ ] **Mechanism to exchange order data (new Art 25a MAR)** — NCA of the most relevant market may obtain order data from a venue with significant cross-border dimension (≥ €100 billion annual share turnover **and** ≥ 50 % cross-border share-of-trading ratio)
- [ ] **Collaboration platforms (new Art 25b MAR)** — voluntary ESMA-coordinated platforms for cross-border surveillance
- [ ] Issuer impact: **none direct**, but expect more efficient cross-border market-abuse detection
- [ ] Delegated acts under Art 25a(7), (9) MAR — Commission empowered for 5 years from 4 December 2024

---

### 4.8 — Personal Data Transfers to Third Countries (NEW MAR Art 29)

- [ ] **New MAR Article 29** governs disclosure of personal data to third countries for market-abuse investigations — GDPR-aligned framework
- [ ] Issuer impact: limited; relevant if you receive a third-country authority request relayed via an EU NCA

---

## SECTION 5 — MIFIR LIMB OF THE LISTING ACT (NARROW)

*The Listing Act's MiFIR limb is a single-point amendment — Article 25 paragraphs 2 and 3 are replaced. It narrows the scope of records investment firms must keep at the disposal of the competent authority. The substantive MiFIR record-keeping checklist remains in [[mifir-checklist.md]].*

---

### 5.1 — MiFIR Article 25 Record-Keeping (post-Listing-Act)

- [ ] Investment firm has updated its **MiFIR Article 25(2)–(3)** record-keeping policy to reflect the Listing Act amendment (specifically the alignment of the perimeter with the narrowed transaction-reporting scope)
- [ ] Internal record-retention period (**5 years**) unchanged
- [ ] **Format and content of orders and transactions retained** in a form ESMA / NCA can readily reconstruct — unchanged duty, narrower instrument scope
- [ ] Cross-check against the broader MiFID/MiFIR Review (Regulation 2024/791) — be careful not to confuse the two; the Listing Act Article 3 is **narrow** and surgical, whereas Regulation 2024/791 substantively rewrites larger parts of MiFIR

**Reference:** Listing Act Article 3, amending MiFIR Article 25(2), (3). See [[mifir-checklist.md]] §6 for full operational detail.

---

## SECTION 6 — COMPANION DIRECTIVES (NOT IN THIS REGULATION BUT THE SAME PACKAGE)

*Directive 2024/2810 (MiFID II amendments + repeal of the Listing Directive 2001/34/EC) and Directive 2024/2811 (multi-vote shares) travel with Regulation 2024/2809. Different instruments, same package logic, different transposition timelines.*

---

### 6.1 — Directive (EU) 2024/2810 — MiFID II Reforms (companion)

- [ ] **Repeal of Directive 2001/34/EC** (Listing Directive — listing particulars / admission to official listing) — its surviving requirements absorbed into MiFID II / Prospectus / national law
- [ ] **Investment research bundling** — narrow reversal of part of the MiFID II unbundling rule, permitting bundling for issuers with **market cap < €1 billion** subject to conditions; designed to revive sell-side coverage of SMEs
- [ ] **SME research provision code of conduct** — voluntary regime endorsed
- [ ] **MiFID II Article 33 SMEGM regime** refined to permit liquidity-provider contracts and accommodate multi-vote shares
- [ ] **MS transposition deadline:** 5 June 2026 (see Listing Act Art 4(4) — mirror date for measures Member States must take under MAR Art 2(14)(a), (15))
- [ ] If you are an investment firm: refresh inducement / research-payment policy ahead of MS transposition

---

### 6.2 — Directive (EU) 2024/2811 — Multi-Vote Share Structures on SMEGMs (companion)

- [ ] **Default rule overridden**: MS must permit a company to have multi-vote share structures **when seeking first admission to trading on an SMEGM**
- [ ] **MS-defined safeguards required** — sunset clauses, escalating-vote ratios, super-majority approval, related-party protections — Member States may choose from the menu
- [ ] **MS transposition deadline:** by 5 December 2026
- [ ] Founder / family-control implications: if multi-vote shares affect your IPO governance design, model the prospectus disclosure burden (governance section) **and** post-IPO investor relations risk
- [ ] Note: directive applies **only at IPO**; existing listed companies are not granted retro-fit multi-vote rights
- [ ] Cross-check **proxy-advisor and index-provider policy** — many institutional investors exclude or downweight multi-vote-share issuers; this may eat into the IPO demand pool

---

## SECTION 7 — TOKENISED SECURITIES UNDER THE LISTING ACT

*Tokenised transferable securities (security tokens, tokenised bonds, tokenised equity) are financial instruments under MiFID II Art 4(1)(15). They sit inside the Prospectus / MAR / MiFIR perimeter — and therefore inside the Listing Act perimeter — even when issued and traded on DLT infrastructure under the DLT Pilot Regime.*

---

### 7.1 — Listing Act Treatment of Tokenised Issuances

- [ ] **Classification first**: tokenised instrument is a financial instrument (Prospectus / MAR / MiFIR apply) **or** a crypto-asset (MiCA applies). The Listing Act does not change this taxonomy.
- [ ] If financial instrument → Listing Act prospectus reforms apply on the same calendar (Section 8)
- [ ] DLT MTF / DLT TSS operators read this checklist as a **trading venue** would
- [ ] **DLT Pilot exemptions** under Reg 2022/858 can vary transparency / record-keeping mechanics but **do not** disapply MAR or the Prospectus Regulation
- [ ] **Wallet-address insider information**: protracted-process amendment (Section 4.3) applies identically to tokenised issuers — the on-chain visibility of internal steps does **not** create a disclosure trigger; on-chain leaks must be handled under MAR Art 17(7)
- [ ] **PDMR transactions on-chain**: thresholds (€20k / €50k) apply on aggregate fiat-equivalent value; wallet-monitoring tooling required
- [ ] Cross-reference: [[mica-checklist.md]] for any crypto-asset adjacency; [[dlt-pilot-checklist.md]] for the DLT regime envelope

---

## SECTION 8 — APPLICATION TIMELINE — WHEN EACH PIECE BITES

*The Listing Act has a three-step calendar. Map every obligation to the correct cliff before drafting any internal compliance roadmap.*

---

### 8.1 — In force since 4 December 2024 (default rule per Listing Act Art 4(1))

- [ ] Fungibility exemption raised 20 % → 30 % (Art 1(5)(a), (b), (c) PR)
- [ ] All MAR Article 2 amendments **except** point (6)(a), (b), (c), (e) — including:
  - [ ] New Article 17 protracted-process rule
  - [ ] Buy-back single-NCA reporting (Art 5(3) MAR)
  - [ ] Managers'-transaction threshold raised to €20k (default)
  - [ ] New SI definition in Art 3 MAR
  - [ ] New cross-border order-data and collaboration mechanisms (Arts 25a, 25b MAR)
  - [ ] New Article 29 MAR (personal data)
  - [ ] Recalibrated administrative sanctions (Arts 30, 31 MAR)
- [ ] MiFIR Article 25 record-keeping narrowing (Listing Act Art 3)
- [ ] Voluntary prospectus right (amended Art 4 PR)
- [ ] Permanent €150M credit-institution non-equity threshold
- [ ] Equivalence (Art 29 PR) and third-country cooperation (Art 30 PR) reforms

### 8.2 — From 5 March 2026 (Listing Act Art 4(2))

- [ ] Art 1 point (7)(g) — new **Article 14a PR (EU Follow-on prospectus)** and **Article 15a PR (EU Growth issuance prospectus)**
- [ ] Art 1 points (11) to (14) — Annex restructuring (standardised sequence of sections) and related delegated-act empowerments

### 8.3 — From 5 June 2026 (Listing Act Art 4(3))

- [ ] Art 1 point (3) — repeal of Art 1(3) PR (€1M lower threshold removed)
- [ ] Art 1 point (6)(b) and (c) — new single threshold (€12M / MS-elected €5M) regime in Art 3(2) PR
- [ ] Art 1 point (7)(a) to (f) — other Art 4-onwards prospectus reforms
- [ ] Art 1 point 10(a)(i), (ii), (iii) and 10(b), (c) — content-of-prospectus reforms
- [ ] Art 1 point 21(a) re Art 27(1) PR — language regime change
- [ ] Art 2 point (6)(a), (b), (c), (e) — MAR amendments deferred to MS implementation
- [ ] **MS deadline (Listing Act Art 4(4))** — Member States take measures to comply with MAR Art 2 point (14)(a), (15) by **5 June 2026**

### 8.4 — Additional companion-directive deadlines

- [ ] **Directive 2024/2810 (MiFID II) transposition:** 5 June 2026
- [ ] **Directive 2024/2811 (multi-vote shares) transposition:** 5 December 2026
- [ ] Internal compliance calendar reflects all four cliff dates

---

## SECTION 9 — DOCUMENTATION CHECKLIST FOR THE FIRST ADVISORY MEETING

*Bring the following to your first specialist consultation so the lawyer can scope the engagement on first meeting.*

---

### 9.1 — Corporate / Issuer Documents

- [ ] Latest **annual report** and last two sets of audited financials (or **three** if your auditor requires 3-year track record for IPO purposes — note: Listing Act reduces standard prospectus financial-history requirement to **2 years** for equity, **1 year** for non-equity)
- [ ] Current **shareholder register** and cap table
- [ ] **Articles of association** and any shareholder agreements
- [ ] **Board composition** and committee charters
- [ ] **Insider list policy** (MAR Art 18) and existing insider list
- [ ] **PDMR list** and existing managers'-transaction notification log
- [ ] **Insider disclosure committee** charter (if already listed)

### 9.2 — Offer / Listing Documents

- [ ] **Indicative offer structure** (primary / secondary, equity / non-equity, IPO / follow-on, public / qualified-only)
- [ ] **Target venue** (RM / SMEGM / MTF / DLT MTF) and **target home Member State**
- [ ] **Expected total offer size** and time-to-market
- [ ] **Underwriter / placing agent identified** (or unidentified — flag if pre-mandate)
- [ ] **Past offers in the EU in the last 12 months** (cumulative-consideration calculation feeds threshold-exemption analysis)
- [ ] **Past offers in third countries** in the last 12 months (relevant for cross-border equivalence)

### 9.3 — Listing Act-Specific Inputs

- [ ] **Planned filing date** — maps to which application-date regime (Section 8) governs your prospectus
- [ ] **Eligibility for EU Follow-on prospectus** — has the issuer been continuously admitted ≥18 months and complied with Directive 2004/109/EC / MAR / Delegated Reg 2017/565?
- [ ] **Eligibility for EU Growth issuance prospectus** — SME? Market cap < €500M? Other Annex II eligibility?
- [ ] **Multi-vote share interest** — has the founder/control group expressed appetite, and is the venue an SMEGM?
- [ ] **Tokenised issuance** — yes / no (and if yes, DLT MTF candidate?)
- [ ] **Material protracted processes already in motion** (M&A, regulatory approval, litigation outcome) — for which the new Art 17(1)(1a) MAR rule changes the disclosure timing analysis

### 9.4 — Cross-Reference Reading List (in priority order)

1. [[prospectus-checklist.md]] — substantive prospectus content / exemptions / scrutiny
2. This document (eu-listing-checklist) — Listing Act delta and package navigation
3. [[mifid2-checklist.md]] — investment-firm and venue conduct envelope (also impacted by Directive 2024/2810)
4. [[mifir-checklist.md]] — transparency, transaction reporting, Article 25 narrowing (also impacted by Listing Act Article 3)
5. [[mifid3-checklist.md]] — only if MiFID/MiFIR Review (Reg 2024/791, Dir 2024/790) reforms are also live for your business plan — these are a **separate** package
6. [[mica-checklist.md]] — only for crypto-asset perimeter (not for tokenised financial instruments)
7. [[dlt-pilot-checklist.md]] — only for DLT MTF / DLT SS / DLT TSS candidacy

---

## SECTION 10 — RED FLAGS THAT WILL DERAIL A LISTING ACT-ERA OFFERING

*Items below frequently cause first-meeting deal-breakers or material restatements. Tick any that apply — each is a separate work-stream.*

- [ ] Issuer has **disclosed intermediate steps of a protracted process** prior to 4 December 2024 and now has **inconsistent practice** — risk of analyst confusion and "drift" disclosure litigation
- [ ] Issuer has been **operating insider lists informally** — Art 18 MAR still requires structured lists; recalibrated sanctions (up to 0.8 % of turnover) heighten exposure
- [ ] PDMR notifications **not aggregated** properly — €20k threshold is annual aggregate, not per-trade
- [ ] Buy-back programme **reported to wrong NCA** under pre-Listing-Act practice — confirm receiving NCA is now the **most relevant market** NCA only
- [ ] **Multi-vote share structure** designed for an SMEGM IPO but the **MS has not yet transposed Directive 2024/2811** at planned listing date — confirm transposition status with home-MS counsel
- [ ] **EU Follow-on prospectus** drafted for a filing scheduled **before 5 March 2026** — format not yet available; revert to pre-Listing-Act format
- [ ] **Threshold-based exemption** assumed at **€8M** for a filing scheduled **after 5 June 2026** — threshold changes to €12M (or MS-elected €5M); restate exemption memo
- [ ] **Voluntary prospectus** assumed unavailable for an exempt offer — Listing Act explicitly opens the voluntary track
- [ ] **Tokenised issuance** structured under MiCA when the instrument is in fact a transferable security — Prospectus / MAR / Listing Act perimeter applies, MiCA does not
- [ ] **Third-country issuer** assumes pre-Listing-Act equivalence framework — the equivalence and third-country-cooperation regimes have been reformed; re-validate
- [ ] **Translation strategy** based on full prospectus translation in every offer Member State — Listing Act narrows the obligation to the summary only, except where a MS opts out
- [ ] **Internal sanctions exposure** modelled against pre-2024 administrative-sanction caps — re-model under new Art 30 MAR

---

## APPENDIX A — KEY LEGAL REFERENCES

- **Listing Act Regulation:** Regulation (EU) 2024/2809 of the European Parliament and of the Council of 23 October 2024 — https://eur-lex.europa.eu/eli/reg/2024/2809/oj
- **Companion directive (MiFID II + repeal of Listing Directive):** Directive (EU) 2024/2810
- **Companion directive (multi-vote shares):** Directive (EU) 2024/2811
- **Prospectus Regulation (as amended):** Regulation (EU) 2017/1129
- **MAR (as amended):** Regulation (EU) No 596/2014
- **MiFIR (as amended):** Regulation (EU) No 600/2014
- **MiFID II (as amended):** Directive 2014/65/EU
- **Repealed Listing Directive:** Directive 2001/34/EC (repealed by Directive 2024/2810)
- **DLT Pilot Regime:** Regulation (EU) 2022/858
- **Delegated Regulation on prospectus content:** Commission Delegated Regulation (EU) 2019/980 (Annexes updated by delegated acts under Listing Act)
- **ESAP:** Regulation (EU) 2023/2859 (European Single Access Point) — relevant for incorporation-by-reference flow

---

## APPENDIX B — DELTA-ONLY SUMMARY FOR ALREADY-LISTED ISSUERS

If you are **already listed** and reading this checklist for ongoing-compliance impact only, the operational priorities are:

1. **MAR Article 17 protracted-process** — rewrite insider / disclosure-committee playbook **(highest impact)**
2. **MAR Article 19 PDMR threshold** — update PDMR policy and notification templates
3. **MAR Article 5 buy-back reporting** — re-route to single-NCA model
4. **MAR Article 30 sanctions** — re-model exposure and refresh compliance documentation against new tiers
5. **Prospectus follow-on filings** — wait for 5 March 2026 EU Follow-on prospectus format if filing timing permits; otherwise use pre-Listing-Act format
6. **Fungibility issuance** — leverage 30 % threshold (in force since 4 Dec 2024) before deciding to file a full follow-on prospectus
7. **Multi-vote shares** — only relevant at next IPO of a related entity on SMEGM; not retro-applicable

Everything else in this checklist is for **IPO-side** issuers or **market participants** other than already-listed companies.

---

*End of checklist. Last updated 2026-05-25. Source: eu-listing.html → Regulation (EU) 2024/2809.*
