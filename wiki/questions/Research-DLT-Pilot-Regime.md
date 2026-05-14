---
type: synthesis
title: "Research: DLT Pilot Regime"
created: 2026-05-14
updated: 2026-05-14
tags:
  - research
  - DLT-Pilot-Regime
  - EU
  - tokenization
  - MiFID-II
  - security-tokens
  - wholesale-CBDC
status: developing
related:
  - "[[DLT-Pilot-Regime]]"
  - "[[21X-AG]]"
  - "[[LISE]]"
  - "[[MiFID-II]]"
  - "[[MiFID-III]]"
  - "[[Asset-Tokenization-RWA]]"
  - "[[ERC-3643]]"
  - "[[ESMA]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
sources:
  - "[[autoresearch-dlt-pilot-regime]]"
  - "[[autoresearch-mifid-ii]]"
---

# Research: DLT Pilot Regime

## Overview

The EU DLT Pilot Regime (Regulation EU 2022/858, applicable March 2023) is a time-limited sandbox allowing DLT-based trading and settlement platforms to operate with targeted exemptions from MiFID II and CSDR. Four platforms are now authorized, 10+ are in the pipeline, and the EU Commission's April 2026 Market Integration Package proposes making the regime permanent with a raised €100B cap and expanded eligible instruments. The Pilot Regime is the primary EU mechanism for building regulated tokenized securities infrastructure — it covers financial instruments (not crypto-assets), is completely separate from MiCA, and is now approaching inflection.

---

## Key Findings

1. **Four platforms are now authorized under the Pilot Regime**, spanning three EU jurisdictions: Clearstream D7 DLT (DLT SS, BaFin/CSSF, Oct 2024), 21X AG (DLT TSS, BaFin, Dec 2024), 360X AG (DLT MTF, BaFin, Apr 2025), and LISE (DLT TSS, AMF/ACPR, Oct 2025). LISE executed the **first tokenized IPO in EU history** (ST GROUP, April 9, 2026). (Source: [[autoresearch-dlt-pilot-regime]])

2. **The original €6B cap was the primary adoption barrier.** ESMA's June 2025 Art.14 report found the economics didn't work: setup costs for a DLT MI are comparable to traditional infrastructure, but capped volume made ROI impossible. The EU Commission's April 2026 package raises the cap to **€100B** and removes the transition trigger. (Source: [[DLT-Pilot-Regime]])

3. **Central bank money settlement was the second critical barrier.** Institutional clients require settlement finality in central bank money. The ECB expanded its wholesale DLT settlement initiative February 20, 2025; the Bundesbank Trigger Solution is now operational for DLT platforms connecting to TARGET2. Clearstream used it for live issuances in 2024. (Source: [[autoresearch-dlt-pilot-regime]])

4. **21X AG is the structural benchmark**: first DLT TSS in the EU; atomic settlement in a single blockchain transaction; USDC settlement; Stellar integration; €500M debt issued. The 18-month BaFin authorization process involved BaFin + Bundesbank + ESMA + ECB — this is what the next applicant faces. (Source: [[21X-AG]])

5. **LISE proves the SME capital formation case**: a DLT TSS can run a tokenized stock exchange for companies that couldn't afford traditional listing. This is a new market, not a displacement of existing ones. (Source: [[LISE]])

6. **The April 2026 EU Commission Market Integration Package** resolves the two remaining barriers: raises cap to €100B, removes the equity market cap restriction (large-caps now eligible), allows CASPs to issue tokenized securities under the Pilot, centralizes CASP supervision at ESMA, removes time limits on authorizations. Legislative approval expected by end 2026. (Source: [[DLT-Pilot-Regime]])

7. **10 applications are in the pipeline**, including Axiology (Lithuania, DLT TSS) and Securitize (Spain, DLT TSS). The pipeline accelerated after ESMA's June 2025 recommendations. (Source: [[autoresearch-dlt-pilot-regime]])

---

## Key Entities

- [[ESMA]]: Published Art.14 review June 25, 2025; recommended permanent regime; now being granted centralized CASP supervision under EC proposal
- **EU Commission**: Issued Market Integration Package April 21, 2026; DLT Pilot upgrade accepted ESMA recommendations
- [[21X-AG]]: First DLT TSS license (BaFin Dec 2024); opened Sept 2025; benchmark for new DLT TSS applicants
- [[LISE]]: First tokenized IPO in EU (Apr 2026); DLT TSS for SME equity; AMF/ACPR France
- **Clearstream (Deutsche Börse Group)**: First DLT SS (Oct 2024); D7 DLT platform; Google Cloud; ECB trials; Ondo/360X alliance
- **360X AG (Deutsche Börse Group + Commerzbank)**: DLT MTF (Apr 2025); Siemens digital bond; Ondo tokenized US equities (xStocks)
- **Bundesbank**: Trigger Solution — operational bridge from DLT platforms to TARGET2 central bank money settlement
- **Securitize**: Pending DLT TSS in Spain — the most established RWA tokenization platform applying for EU DLT Pilot status

---

## Key Concepts

- [[DLT-Pilot-Regime]]: The sandbox framework; platform types; exemptions; thresholds; barriers; EC upgrade
- [[MiFID-II]]: Primary framework the Pilot Regime carves exemptions from
- [[Asset-Tokenization-RWA]]: The broader RWA market context ($33.84B, McKinsey $2T by 2030)
- [[ERC-3643]]: T-REX standard directly addresses non-waivable Pilot Regime investor protection requirements
- **ECB Wholesale CBDC / Trigger Solution**: The settlement infrastructure making institutional DLT securities viable

---

## Contradictions

- **"CSD Prague" vs. "Clearstream"** for the Oct 11, 2024 authorization: one ESMA-cited source lists CSD Prague, primary ESMA press releases and Clearstream's own announcements reference Clearstream D7 DLT. Likely explanation: there may be a 4th authorized platform (Czech CSD Prague) with the same authorization date as Clearstream, meaning there are actually 5+ platforms. Needs verification from the official ESMA DLT Pilot Regime registry.

- **"Limited live trading" vs. "€500M debt issue"**: ESMA's June 2025 report described activity as minimal at time of writing. 21X's €500M DLT debt issue appears to have been one landmark transaction rather than sustained volume. The pipeline remains thin relative to traditional market volumes.

---

## Open Questions

1. Will the EC Market Integration Package clear the European Parliament and Council before end 2026, or will the legislative process extend into 2027 — and does the 2029 sunset remain a risk if legislation is delayed?
2. How does Securitize's pending DLT TSS application in Spain change the competitive landscape if approved? Securitize is the leading US RWA tokenization platform — EU authorization would be a significant market signal.
3. What is the actual integration path for the ECB Wholesale CBDC / DL3S as a long-term settlement solution? The Trigger Solution is a stopgap — when does the integrated wholesale CBDC account on an ECB DLT platform arrive?
4. Can InnBlockchain position itself as a technology partner to Pilot Regime applicants (Axiology, new entrants) rather than only to clients seeking to build and apply themselves?

---

## Sources

- [[autoresearch-dlt-pilot-regime]]: 2026-05-14 | 9 searches, 4 fetches | web research
- [[autoresearch-mifid-ii]]: 2026-05-14 | prior session; MiFID II context
- [[Asset-Tokenization-RWA-2026]]: 2026-04-16 | broader RWA market context
