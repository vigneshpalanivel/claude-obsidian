---
title: "MiFID III: 2024 Review of EU Financial Markets Framework"
type: concept
status: current
created: 2026-05-14
updated: 2026-05-14
tags:
  - MiFID-III
  - MiFID-II
  - EU
  - fintech
  - compliance
  - investment
  - regulation
related:
  - "[[MiFID-II]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[ESMA]]"
  - "[[InnBlockchain FinTech ICP]]"
---

# MiFID III: 2024 Review of EU Financial Markets Framework

**MiFID III** = Directive 2024/790 + Regulation 2024/791 (MiFIR Review). Adopted by the European Commission in **March 2024**. Amends the [[MiFID-II]] framework without replacing it — the core obligations remain; these are targeted revisions to adapt to digital markets and strengthen investor protection.

---

## Implementation Timeline

| Milestone | Date |
|-----------|------|
| Adopted | March 2024 |
| Entered into force | March 29, 2024 |
| Member state transposition deadline | **September 29, 2025** |
| Transparency rules go-live | **March 2, 2026** |
| Reporting and register go-live | **April 1, 2026** |
| PFOF ban + consolidated tape full | **June 2026** |

---

## Key Changes

### 1. Payment for Order Flow (PFOF) Ban
PFOF payments — where brokers receive incentives for routing client orders to specific venues — are **prohibited EU-wide** from June 2026. Phased implementation allowed for some jurisdictions through mid-2026.

Rationale: PFOF creates a conflict of interest where broker routing decisions favor the paying venue, not the client.

### 2. Consolidated Tape (CT)
A single EU-wide post-trade data feed providing near-real-time price/volume data across:
- Equities
- ETFs  
- Bonds
- Derivatives

Replaces fragmented national data systems. Intended to reduce information asymmetry between large institutions and smaller participants.

### 3. Transaction Reporting — Expanded
- Extended data fields beyond MiFID II's 65-field standard
- Near real-time reporting (stricter than T+1 in some cases)
- New identifiers added
- ESMA gains stronger centralized control over validation

### 4. Transparency Rules — Revised
Bonds, structured finance products, emission allowances, and equity instruments all subject to revised post-trade transparency obligations from March 2, 2026. Replaces the previous "waiver" and "deferral" regime with more standardized rules.

### 5. Active Monitoring (not just Recording)
Firms must move from storing communications records to:
- Active monitoring of communications
- Analysis of order flow
- Verification that execution decisions served client interests
- Documentation of best execution evidence trail

### 6. Retail Investment Package Integration
Stronger requirements for:
- Suitability disclosure format
- Marketing communications to retail clients
- Cost transparency (especially for packaged retail investment products)

### 7. Enforcement Centralization
Moves from "national supervisory authorities responsible" toward:
- EU-wide sanctions with defined floors
- Tougher enforcement for data and volume violations
- ESMA given clearer coordination mandate

---

## What Did Not Change

- The core client categorization framework (retail / professional / eligible counterparty)
- Suitability and appropriateness obligations
- The MiFID II / MiCA boundary (no change to Article 2(4) MiCA)
- Algorithmic trading requirements (Article 17) — though ESMA issued new guidance February 2026

---

## MiFID III vs MiFID II: Quick Comparison

| Area | MiFID II | MiFID III |
|------|----------|-----------|
| PFOF | Allowed with disclosure | **Banned** (June 2026) |
| Post-trade data | Fragmented national tapes | **Single consolidated tape** |
| Reporting fields | 65 fixed | **Extended + near real-time** |
| Communication monitoring | Store records | **Active monitoring + analysis** |
| Enforcement | National-led | **EU-wide with ESMA oversight** |
| Transparency waivers | Complex per-instrument | **Standardized from March 2026** |

---

## InnBlockchain and WealthTech Implications

**For Compliance Carol (WealthTech ICP):**
- PFOF ban affects any robo-advisor or execution platform receiving routing incentives — potential revenue model disruption
- Consolidated tape = cheaper market data but also more transparency for regulators to scrutinize execution quality
- Active monitoring requirement = compliance tech investment (surveillance tooling)
- Tighter transaction reporting = higher data quality bar = more expensive compliance ops

**For InnBlockchain client engagement:**
- MiFID III compliance gap = service opportunity: audit existing MiFID II infrastructure for MiFID III readiness
- Reporting expansion = potential integration project for blockchain-based audit trails
- AI-driven monitoring tools (Article 17 algo trading + active comms monitoring) = emerging fintech category aligned with InnBlockchain AI audit positioning
