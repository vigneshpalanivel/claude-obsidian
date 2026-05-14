---
title: "DLT Pilot Regime: EU Sandbox for Tokenized Securities Markets"
type: concept
status: current
created: 2026-05-14
updated: 2026-05-14
tags:
  - DLT
  - tokenization
  - EU
  - MiFID-II
  - compliance
  - blockchain
  - security-tokens
  - sandbox
  - CSDR
  - wholesale-CBDC
related:
  - "[[MiFID-II]]"
  - "[[MiFID-III]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[ERC-3643]]"
  - "[[ERC-1400]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[ESMA]]"
  - "[[21X-AG]]"
  - "[[LISE]]"
  - "[[JPMorgan-Kinexys]]"
---

# DLT Pilot Regime: EU Sandbox for Tokenized Securities Markets

The **DLT Pilot Regime** (Regulation EU 2022/858) is a time-limited experimental framework allowing DLT-based trading and settlement platforms to operate with targeted exemptions from [[MiFID-II]] and CSDR (Central Securities Depositories Regulation). Applicable from **March 23, 2023**, originally running to **2029**, with the EU Commission now proposing permanent status.

> Pilot Regime = EU's structured path for tokenized securities infrastructure to operate legally at scale while regulators gather data. It is not a crypto framework — it governs financial instruments that happen to be issued and traded on DLT.

---

## Why This Exists

Standard MiFID II and CSDR were written for traditional market infrastructure: central order books, CSD settlement, intermediary chains, T+2 settlement. They create three structural barriers for DLT-native approaches:

1. **Intermediation obligation**: MiFID II requires members of an MTF to be investment firms or credit institutions, preventing direct issuer/investor access
2. **CSD settlement mandate**: CSDR requires settlement through a licensed CSD, which DLT platforms by design replace or bypass
3. **Transparency and reporting**: Pre/post-trade publication standards assume centralized data points that don't exist the same way on-chain

The Pilot Regime grants exemptions from the specific provisions that create these barriers — for a limited period, under enhanced supervision — to generate real-world data on whether DLT-based market infrastructure can deliver equivalent investor protection.

---

## Three Platform Types

| Type | Function | MiFID II/CSDR Analog | Key Exemption |
|------|----------|----------------------|---------------|
| **DLT MTF** | Trade tokenized securities | MTF under MiFID II | Direct retail investor access; transparency reporting |
| **DLT SS** | Settle tokenized securities | CSD under CSDR | Securities account requirements; segregation rules |
| **DLT TSS** | Combined trade + settle | MTF + CSD combined | Both sets of exemptions; CSD bypassed entirely |

**DLT TSS is the most powerful structure**: a single firm handles both matching and settlement in one atomic transaction — structurally impossible in traditional market infrastructure where trading venues and CSDs must be separate entities. LISE and 21X are both DLT TSS operators.

---

## Permission Process

**Authorization requirements:**
- Apply to national competent authority (NCA) using ESMA's standardized templates (published March 2023)
- Submit: business plan, rules of the DLT MI, description of DLT + IT/cyber arrangements, safekeeping arrangements, investor protection plan
- Permission is valid throughout the EU for up to **6 years** from issuance
- NCAs may grant exemptions under Article 4 (DLT MTF) and Article 5 (DLT SS) conditional on compensatory measures

**Compensatory measures framework** — rather than prescriptive alternatives, operators propose their own safeguards. Examples:
- Settlement finality: must settle "in near real time or no later than T+2"
- Issue integrity: equivalent controls to CSD's asset integrity requirements
- Asset segregation: cryptographic segregation of client assets (multi-sig, separate wallets)

**The 18-month process at 21X** involved: BaFin + Bundesbank + ESMA + ECB coordination — giving a realistic sense of what DLT TSS authorization requires.

---

## Size Limits and Transition Trigger

| Parameter | Original | EC Proposal (April 2026) |
|-----------|----------|--------------------------|
| Issuance cap per platform | €6 billion | **€100 billion** (simplified tier: €10B) |
| Trigger for transition strategy | €9 billion | Removed |
| Eligible instruments | Shares (≤€500M market cap), bonds, UCITs | **All MiFID II securities** |
| Equity restriction | Companies ≤€500M market cap only | **Removed** |
| Time limit on authorizations | Yes (up to 6 years) | **Removed (permanent)** |

**The original €6B cap was the primary adoption barrier.** ESMA's June 2025 report found that setup costs made it economically impossible to generate a return at capped volumes. The €9B transition trigger (requiring operators to migrate instruments back to traditional infrastructure) compounded this by threatening stranded investment.

---

## Authorized Platforms (as of May 2026)

| Platform | Type | Authorization Date | Regulator | Notable Activity |
|----------|------|--------------------|-----------|-----------------|
| **Clearstream D7 DLT** | DLT SS | Oct 11, 2024 | BaFin/CSSF | Commercial paper, MTNs; Ondo/360X alliance Apr 2026 |
| **[[21X-AG]]** | DLT TSS | Dec 3, 2024 | BaFin | €500M debt issue; opened Sept 8 2025; Stellar + USDC; multi-chain |
| **360X AG** | DLT MTF | Apr 29, 2025 | BaFin | Siemens bond (2025); xStocks (10 Ondo tokenized US equities, Feb 2026) |
| **[[LISE]]** (Lightning Stock Exchange) | DLT TSS | Oct 13, 2025 | AMF/ACPR | First tokenized IPO (ST GROUP, April 9, 2026); SME-focused |

> [!gap] One pipeline source cites "CSD Prague" with the same Oct 11, 2024 authorization date as Clearstream. If accurate, there are 5+ authorized platforms. Clearstream D7 DLT press releases are the higher-confidence reference.

**Pipeline (10 applications pending):** includes Axiology (Lithuania, DLT TSS), Securitize (Spain, DLT TSS), and others unnamed.

---

## Platform Profiles

### Clearstream D7 DLT (Deutsche Börse Group)
- **Technology**: Google Cloud, private permissioned DLT
- **Role**: settlement system (CSD function on DLT)
- **Path**: participated in ECB wholesale CBDC trials 2024; issued 2x EUR 5M tokenized bonds with DekaBank + DZ Bank; settled via Bundesbank Trigger Solution → TARGET2
- **April 2026**: partnered with Ondo Finance + 360X to connect tokenized US stocks (Apple, Tesla, Nvidia, SPY, QQQ) to European regulated market infrastructure

### [[21X-AG]] (Germany)
- First DLT TSS license in EU, BaFin December 3, 2024
- Opened for live trading September 8, 2025
- Atomic settlement: matching + settlement in single blockchain transaction (no T+2)
- Settlement currency: **USDC** (atomic, on-chain)
- Multi-chain: technically integrated with Stellar network
- May 2025: primary market launched; €500M DLT debt issue executed
- Technology-agnostic positioning: aims to support multiple chains and instrument types

### 360X AG (Deutsche Börse Group + Commerzbank)
- Operates three-segment venue: traditional MTF + DLT-MTF (Pilot Regime) + OTC desk
- BaFin and ESMA regulated investment firm, Frankfurt
- DLT-MTF: natively tokenized securities and digital bearer bonds
- **Feb 2026**: xStocks — 10 Ondo tokenized US equity tokens (AAPL, TSLA, NVDA, SPY, QQQ, etc.) listed for institutional investors
- April 2026: Ondo + Clearstream + 360X alliance (connecting public blockchain tokenization to European regulated infrastructure)

### [[LISE]] (Lightning Stock Exchange, France)
- Subsidiary of Kriptown, a French "neo-exchange for startups and SMEs"
- DLT TSS license from AMF + ACPR, October 13, 2025
- **First tokenized stock exchange focused on SMEs** in Europe
- First tokenized IPO: ST GROUP, April 9, 2026 (first ever natively tokenized public company listing in EU)
- Key proposition: DLT TSS allows LISE to skip the traditional CSD entirely — lower cost, faster settlement for smaller issuers

---

## Why Adoption Was Limited (ESMA June 2025 Report)

ESMA's Article 14 review published June 25, 2025 identified five structural barriers:

1. **€6B cap made ROI impossible**: Setup costs for a DLT MI are comparable to a traditional infrastructure build. At €6B max throughput, the business case doesn't close. ESMA: "market participants were unwilling to develop DLT platforms for a regime that capped the volume at €6bn."

2. **No central bank money access**: DLT settlement in commercial bank money or e-money carries counterparty risk. Without central bank money settlement, institutional clients (pension funds, banks) cannot use DLT platforms for regulated securities — their mandates require settlement finality in central bank money.

3. **E-money token restriction**: Only credit institutions (banks) can issue the e-money tokens used for DLT settlement. E-money institutions (fintech EMIs) are excluded. This limits which FinTechs can build settlement infrastructure.

4. **National law uncertainty**: Legal structuring of tokenized instruments varies across EU member states — some countries' securities law doesn't clearly accommodate natively digital instruments (bearer bonds on DLT vs. registered securities in a CSD). This creates cross-border legal risk.

5. **Regulatory permanence uncertainty**: The biggest psychological barrier — firms didn't invest heavily in a framework that might disappear in 2029. ESMA's permanence recommendation directly addresses this.

---

## ECB Wholesale Settlement: The Missing Piece

Central bank money settlement is the non-negotiable requirement for institutional tokenized securities. The ECB is solving this:

**Three settlement approaches explored (2024 trials, 70+ institutions):**

| Approach | Mechanism | Status |
|----------|-----------|--------|
| **Bundesbank Trigger Solution** | DLT bridge → TARGET2 (T2) payment system | Operational; used by Clearstream |
| **DL3S** (Distributed Ledger for Security Settlement) | Full wholesale CBDC account on ECB DLT platform | Exploratory |
| **TIPS Hash-Link** | ECB instant payment system hash-linked to DLT | Exploratory |

**February 20, 2025**: ECB expanded initiative to settle DLT securities transactions in central bank money. Target: interoperability link with TARGET Services as the long-term integrated solution. This is the infrastructure that makes institutional DLT securities settlement viable.

**Key ECB trial transactions:**
- Siemens AG: €300M digital bond
- Slovenia: first EU sovereign digital bond
- Italy: first digital bond under Italian "fintech" decree-law
- Clearstream + DekaBank + DZ Bank: 2x EUR 5M tokenized bonds (settled via Bundesbank Trigger → TARGET2)

---

## ESMA Recommendations (June 25, 2025)

1. **Make the regime permanent** — remove the 2029 sunset; allow firms to build long-term business models
2. **Tiered, adjustable thresholds** — €6B was one-size-fits-all; calibrate per asset type and risk profile
3. **Extend eligible assets** — include complex and illiquid instruments (private credit, real estate tokens, structured products)
4. **Remove activity-based thresholds for market infrastructures** — the €9B transition trigger is a deterrent
5. **Embed DLT provisions into MiFID II/CSDR directly** — rather than maintaining a parallel sandbox, absorb DLT-specific rules into the primary legislation

The EC was required to respond by March 24, 2026. The April 2026 Market Integration Package is that response.

---

## EU Commission Market Integration Package (April 21, 2026)

The EC's April 2026 package accepted ESMA's core recommendations with modifications:

- **€100B platform cap** (with simplified €10B tier for smaller operators)
- **Removed €500M equity market cap restriction** — large-cap stocks now eligible
- **All MiFID II securities** eligible (not just shares, bonds, UCITs)
- **CASPs eligible** to issue tokenized securities under the Pilot Regime (convergence of MiCA + DLT Pilot)
- **ESMA to supervise all CASPs** centrally, replacing fragmented NCA oversight
- **Permanent authorizations** — no time limits
- **Legislative process**: European Parliament + Council approval required; expected by end 2026

---

## Relationship to MiCA and MiFID II

| Framework | Covers | Key Point |
|-----------|--------|-----------|
| DLT Pilot Regime | Financial instruments on DLT | Subset of MiFID II — tokenized bonds/shares stay under MiFID II |
| MiFID II | All financial instruments | Primary framework; DLT Pilot carves out specific exemptions |
| MiCA | Crypto-assets (NOT financial instruments) | Mutually exclusive with MiFID II/DLT Pilot |

- A tokenized bond on a DLT MTF is still a MiFID II financial instrument — it's NOT a crypto-asset under MiCA
- No decentralization exemption: the Pilot requires an identifiable operator with a license
- CASPs entering the Pilot Regime (EC April 2026 proposal) must still treat instruments as MiFID II securities, not crypto-assets

---

## InnBlockchain Implications

1. **Direct service opportunity**: The application process (business plan, DLT description, IT/cyber arrangements, investor protection) is an infrastructure build that InnBlockchain can deliver. A client seeking DLT SS or DLT TSS permission needs the technical stack: smart contracts, ONCHAINID-compatible identity (ERC-3643), compliance engine, settlement mechanism.

2. **21X and LISE are the reference architectures for new entrants**: both are DLT TSS operators that allow atomic settlement without a CSD. This is the model smaller clients (boutique asset managers, SME exchanges) will want to replicate. LISE specifically shows the path for an SME-focused tokenized exchange.

3. **ECB Bundesbank Trigger Solution = the settlement layer**: any serious DLT Pilot platform built for EU institutional clients needs to integrate with the Bundesbank Trigger or DL3S. This is a technical integration project.

4. **The pipeline**: 10 applications are pending. These are the warm prospects — firms that have already decided to pursue DLT Pilot status but haven't yet built the infrastructure. Securitize (Spain, DLT TSS) is the most recognizable name in that pipeline for InnBlockchain's crypto-native ICP.

5. **EU Capital Markets Competitiveness pressure**: The April 2026 package explicitly frames the DLT Pilot expansion as a competitiveness response to US digital asset momentum. This is the same pressure InnBlockchain's EU FinTech clients feel — and it de-risks selling DLT Pilot build services because the regulatory tailwind is accelerating, not reversing.

6. **Sunset risk is resolving**: The 2029 sunset was the primary reason enterprises wouldn't commit to building on the Pilot Regime. With ESMA recommending permanence and the EC accepting it in April 2026, this objection is functionally resolved — clients can invest in compliant DLT infrastructure with confidence.
