---
type: concept
title: "eIDAS 2.0 — European Digital Identity Framework"
created: 2026-05-24
updated: 2026-05-24
tags:
  - eIDAS
  - EU
  - digital-identity
  - trust-services
  - compliance
  - regulation
status: current
last_reingested: 2026-05-24
related:
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[MiCA-Regulation]]"
  - "[[DORA-Regulation]]"
  - "[[MiFID-II]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[PSD3-Open-Banking-EU]]"
  - "[[EU-AML-AMLA]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# eIDAS 2.0 — European Digital Identity Framework

eIDAS 2.0 (Regulation (EU) 2024/1183) amends the original eIDAS Regulation (EU) No 910/2014 to introduce the **EU Digital Identity Wallet (EUDI Wallet)**, expand the trust-services catalogue (notably with **qualified electronic ledgers** and **qualified electronic attestation of attributes**), and impose a hard acceptance obligation on regulated private-sector relying parties. It **entered into force 20 May 2024** (20 days after publication on 30 April 2024).

> [!info] eIDAS 2.0 is an amending regulation
> The operative articles continue to sit in **Regulation (EU) No 910/2014**. When citing "Article 5a" or "Article 45h," you are citing the *consolidated* eIDAS as amended by 2024/1183, not 2024/1183 itself. Counsel and supervisors will expect the consolidated cite.

> [!warning] No fixed "31 December 2026" deadline in the regulation
> The Wallet rollout and private-sector acceptance dates float against Commission **implementing acts** under Articles 5a(23) and 5c(6) (Commission deadline: 21 November 2024). Member States have **24 months** from those implementing acts to provide at least one Wallet *(Article 5a(1))*; private relying parties in strategic sectors have **36 months** *(Article 5f(2))*. The widely-cited "end 2026" date is the practical projection, not a statutory anchor.

## Three Roles, Three Obligation Surfaces

eIDAS 2.0 is **role-based**, not entity-type-based. A single business can sit in two or three roles simultaneously.

| Role | Who it captures | Core obligations | Source |
|---|---|---|---|
| **Relying party** | Public bodies, regulated FIs in strategic sectors, VLOPs, any private service that accepts Wallet data | Article 5b registration; declared intended use; data minimisation; identify self to user; no refusal of pseudonyms; mandatory acceptance under Article 5f triggers | Arts 5b, 5f |
| **Trust service provider (TSP)** — qualified or non-qualified | Issuers of e-signatures, e-seals, time stamps, registered delivery, website auth, attestations of attributes, archiving, **electronic ledgers** | Article 19 baseline + new Article 19a (non-qualified TSP baseline with explicit 24-hour breach notification) + Article 24 (for qualified); per-service articles; NIS2 risk-management and incident-reporting | Arts 17–24a, 25–45l |
| **EUDI Wallet provider** | Member State agencies, MS-mandated vendors, private providers recognised by an MS | Article 5a functional + privacy requirements; open-source app components; Article 5c certification; Article 5e breach regime | Arts 5a–5e |

## What's New vs the 2014 eIDAS

1. **EU Digital Identity Wallet** — Member States must provide at least one Wallet; cross-border legally recognised at assurance level high *(Articles 5a–5f)*
2. **Mandatory acceptance** by regulated private-sector relying parties in strategic sectors (banking, transport, energy, health, telecoms, postal, water, social security, digital infrastructure, education) and by DSA-designated VLOPs *(Article 5f)*
3. **Qualified electronic attestation of attributes (QEAA)** — verifiable credentials with cross-border legal effect, the format the Wallet uses to share verified attributes *(Articles 45b–45h + Annexes V/VI/VII)*
4. **Qualified electronic archiving** — new trust service (Section 10) for long-term integrity preservation *(Articles 45i–45j)*
5. **Qualified electronic ledger** — new trust service (Section 11) for tamper-evident, chronologically ordered data records; **technology-neutral**, covers both centralised and distributed designs *(Articles 45k–45l; Recital 68)*
6. **Cross-MS recognition of qualified trust services** — Article 24a explicitly enumerates cross-border recognition for every qualified trust service, including QEAA, qualified archiving, and qualified electronic ledger
7. **Explicit non-qualified TSP baseline + 24-hour breach notification** *(Article 19a — new)*
8. **Penalty floor for TSPs raised** — EUR 5,000,000 or 1 % of worldwide annual turnover, whichever is higher *(Article 16(2))*
9. **NIS2 cross-reference** — cybersecurity risk management and incident reporting for TSPs aligned with Directive (EU) 2022/2555 *(Articles 19, 19a; Recitals 50–51)*
10. **Cross-border identity matching** for cross-border public services *(Article 11a)*
11. **Statistics and reporting** — Member States must collect and report Wallet/QTS statistics annually *(Article 48a — new)*

## Who Must Comply (Acceptance Side)

Relying parties caught by the Article 5f(2) acceptance obligation include any regulated private service operating in:
- **Financial services** — MiFID II investment firms, CRR credit institutions, PSD3 PIs/EMIs, MiCA CASPs (Section 5f(2) reads "banking, financial services")
- **Insurance and social security**
- **Health** and **drinking water**
- **Transport, energy, postal, telecommunications**
- **Digital infrastructure** and **education**

**Carve-outs:** Microenterprises and small enterprises (<50 staff and ≤EUR 10M turnover/balance sheet) are exempt from the Article 5f(2) acceptance obligation under Commission Recommendation 2003/361/EC. They are still subject to Article 5b registration if they accept the Wallet voluntarily.

**VLOPs** designated under Article 33 DSA must accept and facilitate the Wallet on a user's voluntary request, limited to minimum data necessary *(Article 5f(3))*.

## Trust Services Catalogue (Post-Amendment)

| Trust service | Qualified-tier presumption | Source |
|---|---|---|
| Electronic signature | Equivalent legal effect to handwritten signature | Arts 25–34 |
| Electronic seal | Presumption of integrity and origin | Arts 35–40 |
| Electronic time stamp | Presumption of accuracy of date/time + integrity | Arts 41–42 |
| Electronic registered delivery | Integrity, identification, accuracy of dates | Arts 43–44 |
| Website authentication certificate (QWAC) | Identifies owner of website | Art 45 |
| **Electronic attestation of attributes (EAA / QEAA)** | Equivalent legal effect to paper attestations | Arts 45b–45h + Annexes V/VI/VII |
| **Electronic archiving** | Presumption of integrity for the duration of the preservation period | Arts 45i–45j |
| **Electronic ledger** | Presumption of unique + accurate sequential chronological ordering + integrity of data records | Arts 45k–45l |
| Remote QSCD management | Where the QSCD is held remotely on behalf of the signatory | Arts 29a, 39a |

## Why the Qualified Electronic Ledger Matters (Blockchain Angle)

Articles 45k–45l introduce a **technology-neutral** trust service for tamper-evident, chronologically ordered records (new Section 11 of Chapter III). The Regulation's Recital 68 explicitly contemplates centralised **and** distributed ledger implementations — and use cases including **decentralised land registries**, **e-voting**, **cross-border customs**, and prevention of double-spending of digital assets.

For tokenisation builders, the Article 45k–l pathway is the cleanest route to **EU-wide statutory legal presumption** for on-chain records — Article 45k(2) confers on data records in a qualified ledger the presumption of **unique and accurate sequential chronological ordering** and **integrity** — far stronger than relying on contract law or notary-attested off-chain reconciliations. Article 24a(11) makes the cross-MS recognition explicit.

> [!warning] Permissionless chains and the operator-accountability problem
> Article 45l(1)(a) is **explicit**: qualified electronic ledgers must be "**created and managed by one or more qualified trust service providers**." A pure permissionless network with no identifiable operator cannot qualify on its own. Wrapper services or consortium operators can take the qualified-TSP role; the underlying chain technology is a substrate choice. This is the same accountability question MiCA poses under Recital 22 for "fully decentralised" services — the answers are converging.

## Penalties (Article 16)

Member States must give competent authorities power to impose, on **trust service providers** (qualified and non-qualified):

| Infringer | Maximum fine floor |
|---|---|
| TSP — natural person | **EUR 5,000,000** |
| TSP — legal person | **EUR 5,000,000** or **1 % of total worldwide annual turnover** (whichever is higher) |

Plus: withdrawal/suspension of qualified status; removal from the trusted list; sanctions for trust-mark misuse; potential parallel NIS2 enforcement (up to EUR 10M / 2 % worldwide turnover for essential entities). The Article 16 floor applies to **TSPs only** — relying-party non-compliance is enforced via the sectoral regimes (MiCA, MiFID II, PSD3, etc.).

## Key Dates

| Date | Milestone | Source |
|---|---|---|
| **30 April 2024** | Reg (EU) 2024/1183 published in OJ L (2024/1183) | — |
| **20 May 2024** | Regulation enters into force | Art 3 of Reg 2024/1183 |
| **21 November 2024** | Commission deadline to adopt key implementing acts (Arts 5a(23), 5b(11), 5c(6), 5d(7), 5e(5), 11a(3)) | Each cited article |
| **+24 months from Art 5a(23) / 5c(6) implementing acts** | Each MS must provide at least one EUDI Wallet | Art 5a(1) |
| **+36 months from Art 5a(23) / 5c(6) implementing acts** | Article 5f(2) acceptance obligation begins | Art 5f(2) |
| **+24 months after Wallet deployment** | Commission assessment of demand/availability/usability | Art 5f(5) |

Practical industry projection: Wallet acceptance lands **late 2026 to mid-2027** for most strategic-sector relying parties.

## Interplay with Adjacent Regimes

- **GDPR** — every Wallet interaction processes personal data; eIDAS 2.0 layers in additional safeguards (logical separation, unobservability, no combination)
- **NIS2** — TSPs are essential entities under NIS2 by virtue of providing trust services; cybersecurity and incident-reporting obligations governed by NIS2
- **DSA** — Article 33 VLOPs must accept the Wallet under Article 5f(3)
- **DORA** — DORA-regulated FIs accepting the Wallet must extend ICT third-party risk management to the integration
- **AMLR / AMLD6** — the Wallet provides a high-assurance identification means that satisfies CDD identity verification, but does not replace risk-based EDD, source-of-funds, or PEP screening
- **MiCA** — CASPs are private relying parties in financial services; Article 5f(2) catches them
- **PSD3** — strong customer authentication is squarely within the Article 5f(2) "strong user authentication" trigger
- **MiFID II / DLT Pilot Regime** — investment firms and DLT MTF/SS/TSS operators are financial-services relying parties

## Common Compliance Gaps

1. **Treating Wallet acceptance as a UX checkbox** — Article 5b registration locks the *intended use* and *list of data fields*; UI changes that drift beyond the registered scope are a compliance breach, not a sprint task
2. **Conflating "strong user authentication" with PSD2 SCA** — the Article 5f(2) trigger is broader; any sectoral regime requiring strong auth catches you
3. **Assuming third-country (UK / Swiss / US) trust services are equivalent** — Article 14 equivalence requires a Commission implementing act or Article 218 TFEU agreement; not symmetric to GDPR adequacy
4. **Building a wallet-shaped product without Member State recognition** — without Article 5a(2) provision/mandate/recognition, you cannot claim eIDAS 2.0 cross-border legal value
5. **Misclassifying the trust service** — particularly between electronic timestamp (asserts time on one piece of data), electronic registered delivery (asserts sending/receipt of one transmission), and electronic ledger (asserts sequence and integrity of a stream of records). Misclassification carries through to conformity assessment scope
6. **Under-budgeting the QTSP pathway** — accredited CAB engagement, conformity assessment, supervisory body confirmation, and trusted-list listing typically take 6–9 months end-to-end

## Practitioner Detail

The full pre-engagement readiness assessment — including per-role checklists, certification workflows, documentation packs, and Article-by-Article requirements — lives in [`.raw/InnBlockchain/EU Compliance/eidas2-checklist.md`](../../.raw/InnBlockchain/EU%20Compliance/eidas2-checklist.md). Use that document as the operational guide; this concept page is the strategic / "what-is-eIDAS-2.0" layer.
