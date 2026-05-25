---
type: source
title: "InnBlockchain TFR (Travel Rule) Business Readiness Checklist"
source_type: internal-checklist
date_published: 2026-05-25
url: ".raw/InnBlockchain/EU Compliance/tfr-checklist.md"
confidence: high
hash: "30917ffd51e1e7d3a26485751373d33a"
version: "1.0"
verification_source:
  path: ".raw/InnBlockchain/EU Compliance/tfr.html"
  hash: "19d7e0b7b22632eddf89b9c1b37b796e"
  description: "Local copy of EUR-Lex page for Regulation (EU) 2023/1113 — full OJ L 150 text used as verbatim cross-check source. Same pattern as the mica.html / dora.html / gdpr.html / mifid2.html / dlt.html / amla.html / prospectus.html files used for the 2026-05-24–25 verification corpus."
key_claims:
  - "TFR (Reg (EU) 2023/1113) is a recast of Regulation (EU) 2015/847; entered into force 9 June 2023 (Art 40, 20 days after OJ L 150 publication); applies from 30 December 2024 (synced with MiCA Title V start of application)"
  - "Connecting-factor scope (Art 2(1)) — transfer is in-scope if any PSP/intermediary PSP of payer/payee is established in the Union, OR if any CASP/intermediary CASP of originator/beneficiary has its registered office in the Union, OR if crypto-ATM is in the Union; no 'passive recipient' defence"
  - "Six distinct compliance roles per transfer: PSP of payer (Arts 4-6), PSP of payee (Arts 7-9), intermediary PSP (Arts 10-13), CASP of originator (Arts 14-15), CASP of beneficiary (Arts 16-18), intermediary CASP (Arts 19-22); role is per-transfer not per-entity"
  - "Article 2 final indent treats EMTs (as defined in MiCA Art 3(1)(7)) **as crypto-assets** under TFR — EMT transfers fall under Chapter III not Chapter II; EMIs that tokenize on DLT face dual PSP/CASP classification"
  - "**No de minimis for crypto transfers** (Recital 30, Art 14) — full originator + beneficiary data set on every transfer regardless of value, regardless of domestic vs cross-border; there is no Chapter III equivalent of the Art 5 intra-Union simplified set or the Art 6(2) outside-Union €1,000 threshold"
  - "Art 14(1) originator data set: (a) name + (b) DLT address AND crypto-asset account number where DLT-registered + (c) crypto-asset account number where not DLT-registered + (d) address w/ country + official personal document number + customer identification number OR date and place of birth + (e) LEI where message format supports and provided"
  - "Art 14(2) beneficiary data set: (a) name + (b) DLT address AND account number where DLT-registered + (c) account number where not DLT-registered + (d) LEI where supported"
  - "Art 14(4) — information submitted 'in advance of, or simultaneously or concurrently with' the transfer; secure + GDPR-compliant; **not required to be attached to or included in the on-chain transaction** — explicit technology-neutrality enabling off-chain Travel Rule protocols (IVMS101, TRP, Notabene, Sumsub, Sygna)"
  - "Art 14(8) — CASP of originator **shall not allow initiation or execute** any transfer before ensuring full Article 14 compliance; hard block-then-broadcast rule"
  - "Self-hosted address (Art 3(20)): DLT address not linked to (a) a CASP or (b) a third-country entity providing CASP-equivalent services"
  - "Art 14(5) — for transfers TO a self-hosted address: CASP of originator obtains + holds the full Art 14(1)/(2) information, transfer can be individually identified; **for amounts exceeding €1,000** adequate measures to assess whether the address is owned or controlled by the originator"
  - "Art 16(2) — mirror obligation for transfers FROM a self-hosted address on the CASP of beneficiary, same €1,000 ownership-verification threshold"
  - "Art 17(1) — risk-based decision tree for missing/incomplete info on incoming crypto transfers: execute / reject / **return the transferred crypto-assets to the originator's crypto-asset account** / suspend; the 'return' option does not exist for funds (Art 8)"
  - "Arts 8(2) / 12(2) / 17(2) / 21(2) — repeated-failure escalation by counterparty: warnings/deadlines, then directly reject/restrict/terminate; competent authority must be notified of the failure and the steps taken"
  - "Art 23 — internal policies, procedures, controls for implementation of Union and national restrictive measures; intended to migrate/be repealed when the new AMLR enters application (Recital 18)"
  - "Art 26 — 5-year record retention; Member State may extend for an additional 5 years following a documented necessity/proportionality assessment (max 10 total)"
  - "Art 29 specific-breach triggers feeding AMLD5 Art 59 administrative sanctions: (a) repeated/systematic failure to accompany transfers per Arts 4/5/6/14/15, (b) repeated/systematic/serious failure to retain records per Art 26, (c) failure to implement effective risk-based procedures per Arts 8/12/17, (d) serious failure of intermediaries per Arts 11/12 or 19/20/21"
  - "Art 30 — competent authorities publish administrative sanctions imposed under Arts 28-29 without undue delay, including breach type + identity of responsible parties (subject to case-by-case necessity/proportionality), mirroring AMLD5 Art 60"
  - "Art 38 inserts substantive obligations into AMLD5 (Dir 2015/849): (1) all MiCA CASPs (except advice-only per Art 3(1)(16)(h)) become obliged entities; (3) Art 18(5)-(6) — CASP risk variables/factors incl. privacy wallets, mixers, tumblers; (4) Arts 19a + 19b — self-hosted address EDD + correspondent CASP relationships; (5) Art 24a — enhanced CDD for crypto services + how-and-when additional info on originator/beneficiary"
  - "AMLD5 Art 19b (inserted by TFR Art 38(4)) — cross-border correspondent relationships with third-country CASP-equivalent respondents require six mandatory steps: license/registration check, reputation + supervision assessment, AML/CFT controls assessment, senior management approval, documented responsibilities, payable-through account CDD verification"
  - "EBA guideline mandate dates per Art 36: Art 24a (1 Jan 2024), Arts 14-17 + 19-22 + Art 19b (30 Jun 2024), Art 23 + Art 18(5) + Art 19a + correspondent CASP (30 Dec 2024)"
  - "Art 37(2) — Commission must assess by 1 July 2026 whether further specific measures are needed to mitigate risks from self-hosted address transfers or third-country entity transfers, including possible introduction of restrictions"
  - "Art 37(3) — Commission must report by 30 June 2027 on TFR application + enforcement with possible legislative proposal, covering: effectiveness/compliance, technological solutions including KYT/DLT analytic tools, de minimis effectiveness/suitability, costs/benefits of crypto thresholds, self-hosted address trend analysis"
  - "Art 33(2) — Commission first report on Chapter VI sanctions application by 31 December 2026, every three years thereafter"
  - "Art 25(4) — GDPR collision resolution: EDPB (after consulting EBA) issues guidelines on practical implementation of data protection requirements for third-country crypto transfers; EBA issues guidelines on suitable procedures for determining whether to execute/reject/return/suspend where GDPR Chapter V requirements cannot be ensured"
  - "Art 2(5) — Member State option to exempt domestic low-value (≤€1,000) funds transfers to a payee account permitting payment exclusively for goods/services; **no equivalent for crypto** (Recital 27 explicitly rejects the option for crypto-asset transfers)"
verification_method: "All Article-level claims drafted directly against the Python HTMLParser-stripped text extract of locally-saved tfr.html (Reg (EU) 2023/1113 from OJ L 150) — same methodology used for gdpr.html / dora.html / dlt.html verifications. Verification covered: Arts 1-3 (subject matter, scope, definitions incl. Art 3(13) person-to-person + Art 3(20) self-hosted address); Arts 4(1)-(6), 5(1)-(3), 6 (PSP of payer + intra-Union + outside-Union derogations); Arts 7(1)-(5), 8, 9 (PSP of payee); Arts 10-13 (intermediary PSP); Arts 14(1)-(8) verbatim including 14(4) 'in advance of, simultaneously or concurrently with' + 14(5) self-hosted to + 14(8) block-then-broadcast; Art 15 batch; Arts 16(1)-(4), 17(1)-(2), 18 (CASP of beneficiary); Arts 19-22 (intermediary CASP); Art 23 (restrictive measures); Arts 24-27 (information provision, GDPR, 5-year record retention, cooperation); Arts 28(1)-(7), 29(a)-(d), 30, 31 (sanctions); Arts 32, 33 (whistleblowing, monitoring); Art 35 (third-country agreement derogations); Arts 36 (EBA guidelines), 37(1)-(3) (review clauses); Art 38 (AMLD5 amendments — Art 19a/19b/24a inserted verbatim); Art 40 (entry into force + 30 Dec 2024 application date). All confirmed verbatim against the OJ text."
tags:
  - TFR
  - Travel-Rule
  - EU
  - crypto
  - AML
  - compliance
  - internal-checklist
related:
  - "[[TFR-Regulation]]"
  - "[[MiCA-Regulation]]"
  - "[[EU-AML-AMLA]]"
  - "[[EU-AML-AMLA-Supervision-Mechanics]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[GDPR-Regulation]]"
---

# InnBlockchain TFR (Travel Rule) Business Readiness Checklist

Internal practitioner checklist for InnBlockchain prospects (Crypto Native ICP — CTO / founder / MLRO audience; FinTech ICP — ExchangeTech, WalletTech with crypto, EMI/PI with EMT tokenization). Maps to the article-by-article structure a specialist EU crypto-regulatory lawyer would walk a CASP founder through at a first-intake call on Travel Rule readiness.

## Scope

TFR is the EU's implementation of FATF Recommendation 16 — the **Travel Rule**. It is a **recast** of the prior wire-transfer regulation (2015/847), extending the wire-transfer information regime to **transfers of crypto-assets** for the first time. TFR attaches to existing PSP/CASP authorisations (PSD2/EMD2 + MiCA Title V); it is not itself an authorisation regime.

The checklist's centre of gravity is **Chapter III (CASPs, Arts 14–22)** because that is where the substantive novelty lives. PSP coverage (Chapter II, Arts 4–13) is preserved for EMT issuers and for the dual-classification PSP+CASP cases.

## Structure (10 Sections)

1. Does TFR apply? — Article 2 connecting-factor scope, exclusions (incl. EMT-as-crypto trap, person-to-person, NFTs, fully decentralised), role assignment across the six compliance roles
2. Travel Rule data requirements — Art 4 (PSPs) and Art 14 (CASPs), intra-Union simplified set (Art 5), batch file transfers (Arts 6, 15), verification mode + Art 14(4) technology-neutrality
3. Self-hosted addresses — the CASP-specific novelty: Art 14(5) to + Art 16(2) from + AMLD5 Art 19a EDD layer
4. Incoming transfers — detection, risk-based execute/reject/suspend/return, repeated-failure escalation, STR/FIU hook
5. Intermediary-specific obligations — retention with transfer, pass-through detection + decision
6. Restrictive measures (Art 23) — internal controls + EBA guidelines + AMLR migration flag
7. Data protection (Art 25) + 5-year record retention (Art 26) + response to authorities (Art 24); the GDPR-TFR collision
8. AMLD5 amendments via Art 38 — CASPs as obliged entities, correspondent CASP relationships (Art 19b), enhanced CDD (Art 24a), risk factors (Art 18(5)-(6))
9. Sanctions + governance — Art 29 specific-breach triggers, Art 30 publication, Art 32 internal whistleblowing
10. Operational readiness — Travel Rule protocol selection (IVMS101 + Notabene/Sumsub/TRP/Sygna), self-hosted ownership-verification methods, chain-analytics, EBA guideline mandate dates, AMLR/AMLD6 forward compatibility

Plus: Top-level reference at OJ L 150 / Reg (EU) 2023/1113.

## What This Adds vs. the Concept Page

[[TFR-Regulation]] is the strategic / "what-is-TFR-and-where-does-it-apply" layer — package structure, timeline, scope, PSP-vs-CASP asymmetry, self-hosted address overview, GDPR collision, AMLD5 Art 38 amendments, InnBlockchain ICP impact. The checklist is the **operational dossier** — every claim ties to a specific Article reference and a checkbox the prospect can tick or fail on.

Most distinctive additions in the checklist (not in the concept page):

- **Art 14(4) technology-neutrality + Art 14(8) block-then-broadcast as a single architectural rule** — the off-chain Travel Rule message must be delivered before/with/concurrent with the on-chain broadcast, AND the on-chain broadcast must be blocked until full Art 14 compliance is established. This creates a hard design decision at go-live: block-and-wait, or cryptographic commitment binding.
- **Self-hosted address ownership-verification techniques** — signed-message challenge (EIP-191), micro-deposit + return-transfer, hardware-wallet attestation, third-party EDD reliance. €1,000 is the floor; firms may apply lower triggers.
- **Counterparty-failure register** — Art 8/12/17/21 repeated-failure escalation paths require an inventory of counterparty PSPs/CASPs by failure pattern with warnings/deadlines/restrictions/terminations all documented. Sanctions trigger under Art 29(c) for failure to implement effective risk-based procedures.
- **GDPR–TFR collision resolution workflow** — when transferring to a third-country CASP in a non-adequate jurisdiction and GDPR Chapter V cannot be satisfied, the resolution is generally to refuse to execute. EDPB + EBA guidelines under Art 25(4) define the documented procedure.
- **AMLD5 Art 19b correspondent CASP six-step checklist** — license/registration, reputation + supervision, AML/CFT controls, senior management approval, documented responsibilities, payable-through CDD. Treats third-country CASP relationships as correspondent banking equivalents.
- **EBA guidelines mandate timeline** (Art 36 + Art 38 inserted AMLD5 articles) — six distinct EBA mandates with deadlines spanning 1 Jan 2024 to 30 Dec 2024; firms must track each.
- **Operational architecture stack** — Travel Rule protocol comparison (IVMS101, TRP, Notabene, Sumsub, Sygna, OpenVASP), chain-analytics provider selection (Chainalysis, Elliptic, TRM Labs, Crystal, Merkle Science), multi-protocol interoperability planning. TFR is technology-neutral (Recital 50) — no single dominant protocol.

## Verification

All material Article-level claims drafted directly against the Python HTMLParser-stripped text of the locally-saved EUR-Lex copy of Regulation (EU) 2023/1113 (`tfr.html`, 328KB raw → 1,674 lines plain text). Verification corpus methodology matches the 2026-05-24–25 GDPR / DORA / DLT Pilot / MiCA verification passes. Coverage:

- Arts 1–3 (subject matter, scope, definitions incl. Art 3(13) person-to-person + Art 3(20) self-hosted address)
- Arts 4(1)–(6) (PSP of payer Travel Rule data + verification + execution gate)
- Art 5(1)–(3) (intra-Union simplified set + 3-working-day request response window)
- Art 6 (transfers outside the Union including 6(1) batch file + 6(2) ≤€1,000 simplified set with cash/anonymous-e-money/suspicion exception)
- Arts 7(1)–(5), 8, 9 (PSP of payee detection + risk-based decision + STR factor)
- Arts 10–13 (intermediary PSP retention + detection + decision)
- **Art 14(1)(a)–(e) originator data set verbatim**, **Art 14(2)(a)–(d) beneficiary data set verbatim**, Art 14(3) UTI derogation, **Art 14(4) "in advance of, simultaneously or concurrently with" + technology neutrality**, **Art 14(5) self-hosted to + €1,000 ownership verification**, Art 14(6)–(7) verification deemed-to-have-occurred, **Art 14(8) block-then-broadcast hard rule**
- Art 15 batch file transfers of crypto-assets
- Arts 16(1)–(4) (CASP of beneficiary detection + Art 16(2) self-hosted from + €1,000 ownership + Art 16(3) verification before making available)
- **Art 17(1)–(2) execute/reject/return/suspend** (the "return" option being the crypto-specific addition) + repeated-failure escalation
- Art 18 STR factor + FIU reporting
- Arts 19–22 (intermediary CASP — retention with transfer + transmission + records + detection incl. self-hosted + risk-based decision + repeated-failure escalation + STR factor)
- Art 23 restrictive measures internal controls + EBA Art 36 guideline mandate
- Arts 24–27 (information provision via central contact point + GDPR + Art 25(4) EDPB/EBA mandate + 5-year record retention with Member State extension)
- Art 28(1)–(7) administrative sanctions structure incl. natural-person liability + delegation/judicial routes
- **Art 29(a)–(d) specific-breach triggers verbatim**
- Art 30 publication of sanctions
- Art 31 application of sanctions/measures by competent authorities
- Art 32 whistleblowing internal channels
- Art 33 monitoring + Commission report by 31 Dec 2026
- Art 35 third-country agreement derogation procedure
- **Art 36 EBA guideline mandates** (Arts 7/8/11/12 PSPs + Arts 14-17/19-22 CASPs by 30 Jun 2024)
- **Art 37(1)–(3) review clauses** (12 months after new AMLR / 1 Jul 2026 self-hosted / 30 Jun 2027 general)
- **Art 38(1)–(8) AMLD5 amendments** — Art 2(1)(3) deletion of (g)/(h), Art 3(2)(g) CASP inclusion, Art 3(8) correspondent relationship redefinition for crypto, Art 3(18)–(20) crypto-asset/CASP/self-hosted address definitions, **Art 18(5)–(6) risk variables/factors EBA mandate by 30 Dec 2024**, **Art 19a self-hosted address EDD (a)–(d) verbatim + EBA mandate by 30 Dec 2024**, **Art 19b correspondent CASP six-step (a)–(f) verbatim + EBA mandate by 30 Jun 2024**, **Art 24a EBA mandate by 1 Jan 2024**, Art 45(9) central contact point, Art 47(1) registration regime, Art 67(3) transposition by 30 Dec 2024
- Art 40 entry into force + 30 December 2024 application date

All confirmed verbatim against the OJ text.

## Tensions / Open Items

1. **EBA guideline drift** — Six EBA mandate deadlines across Art 36 and Art 38 inserted articles (1 Jan 2024 / 30 Jun 2024 / 30 Dec 2024). Confirm the latest published version of each set with counsel before relying on the checklist as a snapshot — guidelines evolve faster than the Level 1 text.
2. **Travel Rule protocol interoperability** — There is no single dominant protocol (IVMS101 is the data model; transport layers diverge between Notabene/Sumsub/TRP/Sygna). The "deliverability" problem for counterparties on different protocols remains the largest practical compliance gap. EBA Art 36 dialogue with stakeholders on technical interoperability is ongoing — confirm current EBA position before architecting.
3. **Self-hosted address restrictions risk** — Art 37(2) requires the Commission to assess by **1 July 2026** whether further restrictions on self-hosted address transfers are needed, possibly including limitation or prohibition. Business models that rely on permissive self-hosted address economics carry deferred political risk through that review. Track actively; consider scenario planning for stricter outcomes.
4. **AMLR/AMLD6 migration** — Recital 18 flags that Art 23 (restrictive measures internal controls) is intended to migrate to or be repealed by the new AMLR (application 10 July 2027). Art 37(1) requires Commission review within 12 months of new AMLR entry into force for consistency. Firms should design TFR implementations to be forward-compatible with the 2027 obligations, not throwaway 2024 builds.
5. **GDPR Chapter V third-country transfer collision** — Art 25(4) provides for EDPB + EBA guidelines on practical implementation. In the interim, the operationally safe interpretation is to refuse to execute transfers where GDPR third-country requirements cannot be satisfied. National DPAs have varying tolerance — confirm with lead DPA before client-facing use.
6. **Crypto-ATM scope edge cases** — Art 2(1) brings crypto-ATMs into scope but the operational mechanics for short-form/cash deposits don't map cleanly to the Art 14 data set. EBA Art 36 guidelines on Art 17 should clarify; track current EBA publication.

## InnBlockchain Service Mapping

The TFR checklist breaks down into three layers of InnBlockchain delivery:

**Pre-Build:**
- Travel Rule protocol selection brief (IVMS101 + 2–3 of: Notabene, Sumsub, TRP, Sygna, OpenVASP)
- Self-hosted address policy memo (threshold, verification method, AMLD5 Art 19a EDD baseline)
- Counterparty CASP register design + AMLD5 Art 19b correspondent assessment workflow
- GDPR Chapter V refusal procedure for non-adequate third-country counterparties
- Block-then-broadcast architectural decision (block-and-wait vs cryptographic commitment binding)

**Build:**
- Off-chain Travel Rule message + on-chain transaction bonding (cryptographic commitments, deterministic UTI)
- Self-hosted address ownership-verification module (signed-message challenge + micro-deposit + hardware attestation paths)
- Chain-analytics integration layer (Chainalysis / Elliptic / TRM Labs / Crystal / Merkle Science)
- Sanctions screening at four touchpoints (onboarding, originator-side initiation, beneficiary-side receipt, ongoing monitoring)
- Repeated-failure counterparty register + automated escalation workflow (warnings → restriction → termination → competent-authority notification)
- 5-year record retention layer with optional 5-year extension hooks per Member State
- STR factor-handling module for missing-info transfers feeding existing AMLR/AMLD5 STR pipeline

**Audit:**
- Travel Rule data-flow audit (Art 14(1)–(2) completeness + Art 14(4) timing + Art 14(8) block-then-broadcast enforcement)
- Self-hosted address EDD review (AMLD5 Art 19a measures (a)–(d) implementation evidence)
- AMLD5 Art 19b correspondent register review against EBA guidelines
- GDPR–TFR cross-regime audit (Art 25(4) procedure documented, refusal events logged)
- Sanctions screening efficacy testing across the four touchpoints
- Counterparty-failure escalation evidence review (Art 29(c) sanctions exposure)

## Primary Fit by Segment

- **Crypto Native ICP (Seg 2–10)**: All segments where MiCA CASP attaches are TFR-bound. Highest InnBlockchain wedge in Seg 2 (DEX & on-chain trading — block-then-broadcast architecture is non-negotiable), Seg 3 (DeFi lending — self-hosted address concentration), Seg 4 (non-custodial wallets — self-hosted address ownership verification at scale), and Seg 7 (DAO operating as CASP). Seg 5 (NFT marketplaces) only triggers via the fractionalized-NFT path (NFT = crypto-asset under MiCA Art 2(3) carve-out reversal).
- **Crypto Native ICP (Seg 1 — RWA Tokenization)**: TFR generally does NOT apply — tokenized securities under MiFID II/Prospectus/DLT Pilot are not crypto-assets under MiCA Art 2(4)(a), so Chapter III doesn't reach them. TFR only enters if the firm separately operates a CASP side for non-MiFID assets. Selling TFR compliance to a pure RWA platform is wrong-regulator framing.
- **FinTech ICP (ExchangeTech, BankTech with crypto, WalletTech with crypto)**: TFR + AMLR + MiCA stack together. Travel Rule data flow is the operational hot spot; AMLD5 Art 19b correspondent-CASP EDD is the second-largest compliance lift for cross-border firms.
- **FinTech ICP (BankTech, EMI, PI without crypto)**: Chapter II only. Existing 2015/847 implementation generally sufficient; intra-Union simplified set + outside-Union €1,000 verification threshold are unchanged in substance. The recast does not materially change the funds side.
- **EMI issuing EMTs on DLT**: Dual classification — PSP for fiat e-money side under Chapter II, CASP for EMT-on-DLT side under Chapter III. This is the most architecturally complex audience.

## See Also

[[TFR-Regulation]] | [[MiCA-Regulation]] | [[MiCA-NCA-Authorization-Mechanics]] | [[EU-AML-AMLA]] | [[EU-AML-AMLA-Supervision-Mechanics]] | [[GDPR-Regulation]] | [[EU-Fintech-Compliance-Landscape]] | [[InnBlockchain Crypto Native ICP]] | [[InnBlockchain FinTech ICP]]
