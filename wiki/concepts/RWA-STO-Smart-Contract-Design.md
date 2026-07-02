---
type: concept
title: "RWA / STO Smart-Contract Design (EU)"
created: 2026-07-02
updated: 2026-07-02
tags:
  - EU
  - RWA
  - STO
  - tokenization
  - smart-contracts
  - ERC-3643
  - dev
status: current
related:
  - "[[RWA-STO-EU-Compliance-Landscape]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[ELTIF-2.0]]"
  - "[[MiFID-II]]"
  - "[[DLT-Pilot-Regime]]"
  - "[[DORA-Regulation]]"
  - "[[Asset-Tokenization-RWA]]"
internal_artifacts:
  - path: ".raw/InnBlockchain/sales-marketing/Service/Content/Contract Design/eu_rwa_sto_smart_contract_design.md"
    hash: "a960fb010ffafa818e9ef332c99bbfd6"
    registered: 2026-07-02
    last_synced: 2026-07-02
    role: "smart-contract design — requirement-first (each compliance point + its engineering approach), single doc; §17 appendix = consolidated contract inventory"
    purpose: "Client/dev-shareable artifact. Translates the EU RWA/STO compliance obligations (from RWA-STO-EU-Compliance-Landscape + the 15 EU Compliance/Checklist files) into an ERC-3643/T-REX permissioned-security-token design. Structured requirement-first and interleaved: §1-§10 each state the compliance obligation (Article-mapped) then the engineering approach for that same point (roles/lane-phasing, chain/selection, token-identity/ERC-3643, identity/claims-service, fund/modules+valuation-oracle+matching-engine, MAR/freeze+indexer, venue/settlement+caps+reporting-bridges, disclosure/doc-registry, DORA/governor, GDPR/no-PII); §11 on/off-chain boundary; §12-§15 cross-cutting engineering (NFRs, test/audit, phasing, team); §16 open decisions. Code omitted. Built 2026-07-02 via parallel extraction across the checklist clusters; a former separate engineering doc was merged in. A deeper technical spec (interfaces, schemas, gas budgets, test plans) to be authored in Dev/ before development."
---

# RWA / STO Smart-Contract Design (EU)

The **dev/engineering companion** to [[RWA-STO-EU-Compliance-Landscape]]. A single source doc (`Content/Contract Design/eu_rwa_sto_smart_contract_design.md`) translates the EU RWA/STO regulatory lane (MiFID II-primary, not MiCA) into a buildable tokenized-securities platform, structured **requirement-first and interleaved**: each compliance point is stated (Article-mapped), then the engineering approach that satisfies it follows immediately.

- **§1–§10** — one section per compliance domain, each = *compliance obligation* → *engineering approach*: roles/lane-phasing · chain/selection · token-identity/ERC-3643 · identity/claims-service · fund-structure/modules+valuation-oracle+matching-engine · MAR/freeze+surveillance-indexer · venue/settlement+caps+reporting-bridges · disclosure/doc-registry · DORA/governor-wrapper · GDPR/no-PII-pattern.
- **§11** on-chain vs off-chain boundary summary; **§12–§15** cross-cutting engineering that can't attach to one point (NFRs, test/audit, build phasing, team); **§16** consolidated open decisions (legal + engineering).

A deeper technical engineering spec (Solidity interfaces, on-chain schemas, sequence diagrams, gas/throughput budgets, test plans) will be authored in `Dev/` **before development begins**.

## Key decisions & insights

- **Token standard: ERC-3643 (T-REX) + ONCHAINID**, not ERC-1400 as base. EU compliance is identity-gated and rule-dense; ERC-3643 makes on-chain identity, a modular (pluggable, Article-mapped) compliance engine, and freeze/forced-transfer/recovery **standard primitives**. ERC-1400 leaves all of that as bespoke code. Borrow the ERC-1400 *partition pattern* only for per-tranche lock-ups and ELTIF side pockets, inside an ERC-3643 base.
- **Chain: permissioned / known-validator EVM** (BFT instant-finality — Besu-class consortium, or controlled-sequencer appchain). This is a **compliance requirement, not a free engineering pick** — and is stated as such in *both* the requirements doc (as a constraint) and the engineering doc (as the selection). Forced by four requirements a public anonymous L1 cannot satisfy: MAR validator/sequencer front-running **surveillance** (Art 16/12(2)), DLT Pilot deterministic **settlement finality** (Art 5(7)-(8)/CSDR Art 39), DORA **validator control + failover** (Art 12), and an **NCA-accountable operator** (DLT Pilot authorisation). ERC-3643 is EVM-portable, so the token/identity core is unaffected. (GDPR no-PII-on-chain applies on any chain — not a selection driver.)
- **~80% of the build is off-chain.** The contracts are the enforcement/settlement layer; the load-bearing systems are backend services: identity & claims (EUDI/QTSP intake), **valuation/NAV oracle**, sanctions/PEP/BO screening, the **ELTIF matching engine** (Art 19.2a), the reporting bridges (ARM Art 26 T+1 / APA transparency / CTP consolidated tape), and the event indexer for MAR surveillance.
- **Role-lanes compound ~3× and are phased**: issuer core (token+identity+DORA wrapper) → fund-structure modules (ELTIF/UCITS/NAV/LMT) + document registry → venue (DLT MTF/SS/TSS + DvP + reporting) → dealer/SI (quoting + PFOF + consolidated tape). Ship the issuer lane first; don't carry venue/SI code a pure issuer doesn't need.
- **Valuation/NAV oracle is the #1 risk** — every quantitative limit (ELTIF 55/20, UCITS 5/10/40, NAV borrowing caps) trusts it; a wrong NAV silently passes a breach. Multi-source + deviation guard + last-valid fallback; oracle failure must **halt** issuance/redemption, not pass silently.
- **GDPR immutability pattern (mandatory from inception):** no PII on-chain — only claim hashes / ZK attestations; erasure = off-chain delete + cryptographic key destruction; on-chain anchor persists non-identifying. Legal basis GDPR Art 6(1)(c).
- **Travel Rule (TFR) does NOT apply** — these are MiFID-classified financial instruments, outside TFR crypto-asset scope. The control is AMLR Art 20 CDD re-verification on transfer, not TFR originator/beneficiary fields. Do not build Travel-Rule fields into the contract.
- **Not MiCA:** transfer restrictions derive from MiFID II / Prospectus / AIFMD-UCITS-ELTIF / DLT Pilot — not MiCA. MiCA appears only if the firm separately services non-MiFID crypto-assets.

## Open decisions for the CTO

Network topology (consortium vs single-operator PoA vs appchain-with-L1-anchor); settlement asset (central-bank money vs tokenized e-money vs off-chain leg); custody model (self vs qualified custodian); build-vs-buy for the load-bearing off-chain systems (T-REX stack, oracle, reporting bridges); eIDAS QEL status (requires a QTSP operator); DLT Pilot caps as a governance parameter (permanence package proposed Apr 2026).

## InnBlockchain relevance

This is the delivery blueprint for the RWA/STO tokenization-engineering motion the compliance landscape identifies as InnBlockchain's highest-fit EU opportunity — ERC-3643/T-REX builds, ELTIF matching-mechanism smart contracts, compliance-module engineering, and DLT-Pilot venue infrastructure. The requirements↔engineering split lets a compliance/counsel audience read the *what* without wading through the engineering *how*.

See: [[RWA-STO-EU-Compliance-Landscape]] | [[EU-Fintech-Compliance-Landscape]] | [[ELTIF-2.0]] | [[MiFID-II]] | [[DLT-Pilot-Regime]] | [[DORA-Regulation]] | [[Asset-Tokenization-RWA]]
