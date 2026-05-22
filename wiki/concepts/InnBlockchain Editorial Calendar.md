---
type: concept
title: "InnBlockchain Editorial Calendar"
status: current
created: 2026-05-21
updated: 2026-05-21
tags:
  - concept
  - editorial-calendar
  - innblockchain
  - marketing
  - content
  - phase-1
related:
  - "[[InnBlockchain]]"
  - "[[InnBlockchain Content Strategy]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain Landing Pages Plan]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
---

# InnBlockchain Editorial Calendar

Source of truth for **what publishes when** in InnBlockchain content. The strategy doc holds the article inventory; this calendar holds the date schedule.

> **Canonical source:** `.raw/InnBlockchain/Content/InnBlockchain - Editorial Calendar.md` (currently at rev 8, 2026-05-21).
> **Strategy doc:** [[InnBlockchain Content Strategy]] (currently at rev 16; tracks article inventory + scoring + routing rules).
> **Layer separation:** strategy = inventory; calendar = schedule. Cross-references between the two docs go by wikilink, not by version pin.

## Schedule snapshot

| Phase | Window | Articles | Status |
|---|---|---|---|
| **Phase 0** | W1 (May 18, 2026) | 1 (WL-0 *Own vs License: 5-Year TCO*) | Foundation |
| **Phase 1** | W1–W22 (May 18 → Oct 15, 2026) | 42 articles | 🟢 date-locked |
| **Phase 2** | W22+ (Oct 2026 onwards) | ~50–60 articles | ⚪ inventory only — dates cut after Phase 1 closes |
| **Phase 3** | Activation-gated | ~10–15 articles | ⚪ Watch — trigger-gated |

## Phase 1 structure (date-locked)

```
22 weeks × 2 publish slots (Tue + Thu 10:00 CET) = 44 slots
  − 2 closures (W21 Tue + W22 Tue closed/Phase 2)
  = 42 Phase 1 publishing slots filled

  21 Track A Tuesday articles  (RWA platform builders — A1)
+ 17 Track B Thursday articles (WealthTech RWA — B1)
+ 4 cross-pillar early-ship   (C1 W4, T4-N W6, P5-DORA-X W7, P5-eIDAS-X W13)
= 42 articles
```

**Day mapping:**
- **Tuesday default** = Track A (Crypto Native; mixed SEO+X for technical pieces, LinkedIn+SEO for plain-language RWA pieces)
- **Thursday default** = Track B (Regulated FinTech; LinkedIn ABM for B1; LinkedIn + SEO for cross-pillar early-ship)
- `[Both]` articles ship either day per slot availability

## Cross-Pillar early-ship articles in Phase 1

Four articles publish inside Phase 1 (not deferred to Phase 2) because they serve immediate cross-segment demand:

| ID | Article | Score | Why early |
|---|---|---|---|
| **C1** | What FinTech CCOs Should Demand in a Blockchain Vendor Risk Pack | 8.4 | Carol surfaces in every licensed FT deal |
| **T4-N** | The Cost of Hiring a Blockchain Team In-House: FinTech CTO Guide | 8.4 | Tom hiring decision is the wedge for any FT engagement |
| **P5-DORA-X** | DORA for All EU Licensed Financial Entities | 8.5 | DORA applies to every Active Track B deal touching a licensed entity |
| **P5-eIDAS-X** | eIDAS 2.0 EUDI Wallet for Regulated FinTechs and RWA Tokenization Platforms `[Both]` | 8.7 | Hard Dec 31, 2026 deadline + serves both wallet auth + investor KYC patterns |

P5-DORA-X and P5-eIDAS-X were promoted from the strategy's Phase 2 P5 Rebalancing queue into Phase 1 because they serve immediate demand.

## Gate Sequence (Confirmed)

| Gate | Type | ETA / Status | Unblocks |
|---|---|---|---|
| `/solutions/rwa-tokenization` LP | Landing page | Week 1 | Track A A1 cluster articles |
| `/solutions/tokenization` LP | Landing page | Week 2 | Track B B1 cluster + `[Both]` Asset Tokenization piece |
| MiCA destination LP | Landing page | Week 3 | Destination link for #4 boundary clarifier + #11 Prospectus vs MiCA Whitepaper + cross-cutting articles |
| **Reference Build Hard Gate** | WL articles only | ✅ Cleared 2026-05-14 | WL-1 + WL-2 through WL-6 in Phase 2 |
| AI+Blockchain validation | ICP FT Pain Point 5 | Due 2026-05-31 | AI+Blockchain Track B cluster (5 articles) |

## Phase 1 Segment-Scope Guard

> Track A Phase 1 is **RWA-only** (Seg 1). Every Track A article published W1–W21 must serve RWA Felix (asset-backed founder building a tokenization platform). Same rule for Track B B1 — WealthTech RWA buyers need MiFID II + DLT Pilot framing, not MiCA framing. **The only MiCA-mentioning articles in Phase 1** are boundary clarifiers (#4 *MiCA or MiFID II?*, #11 *Prospectus vs MiCA Whitepaper*) — generic MiCA articles like #3 *MiCA Explained*, #14 *MiCA Compliance Checklist for CN Startups*, P1-N *MiCA License Application* are deferred to Phase 2 because their audiences aren't activated in Phase 1.

Per [[EU-Fintech-Compliance-Landscape]] canonical reference. See [[InnBlockchain Content Strategy]] for the article inventory.

## Deferred to Phase 2 (removed from Phase 1 in rev 4 / rev 5)

Three articles initially planned for Phase 1 were removed because their audience isn't activated in Q2 2026:

- **#3 *MiCA Explained: What the EU's Crypto Framework Means for Your Business*** — general MiCA explainer; audience is MiCA-segment buyers (Seg 2 ExchangeTech, Seg 4 WalletTech) whose LPs aren't live yet
- **#14 *MiCA Compliance Checklist for Crypto-Native Startups*** — Seg 2–10 scope, conflicts with RWA Phase 1 focus
- **P1-N *Preparing for MiCA License Application: Roadmap for Existing FinTechs*** — Track B FT cross-pillar for existing FinTechs licensing under MiCA CASP; audience activated only when `/solutions/regulated-exchange` + `/solutions/fintech-wallets` ship

## Phase 1 watch-candidates (in overflow, conditional on signal)

- **B1-#4 *Utility NFTs in FinTech*** (score 8.4) — watch-candidate, kill at 90-day review if no inbound
- **B1-#11 *Tokenized US Treasuries as DeFi Collateral*** (score 8.1) — news-cycle dependent
- **B1 Post-Launch: *Expanding Your RWA Platform to New Markets*** — gate-dependent (first B1 client must go live)

## Gate-dependent (publish when gate clears, out of sequence)

- 🎬 [CASE STUDY] *How We Tokenized [Asset] for [Client]* (A1) — requires delivered client deployment with screenshot rights
- 🎬 [CASE STUDY] *WealthTech / RWA Platform Build* (B1) — same gate
- *Hardening a Live RWA Tokenization Platform* (A1 post-launch) — first RWA platform must go live
- *AI + Blockchain cluster* (5 Track B articles) — Pain Point 5 validation by 2026-05-31

## Phase 1 close

- **Track A Phase 1 complete:** W20 (WL-1 at #22 ships, then Track A pauses for Phase 2 cut)
- **Track B B1 complete:** W22 (B1-#19 lead magnet ships, closing the WealthTech RWA cluster)
- **Phase 2 #23 starter:** W22 (A3 [POST-MORTEM Series] kicks off Phase 2)
- **Phase 2 full schedule:** to be replanned mid-October 2026 once 3 months of Phase 1 performance data is in

## Revision history (calendar-side)

8 revisions on canonical doc since 2026-05-18:
- **rev 1**: initial calendar derived from Content Strategy. 2/wk cadence locked.
- **rev 2**: 7 cross-strategy gaps fixed; added C1/T4-N/P1-N as cross-pillar early-ship; B1-#4 + B1-#11 to overflow.
- **rev 3**: title sync with Content Strategy MiCA-misframe correction.
- **rev 4**: Phase 1 segment-scope audit pass 1 — removed #14 from W14 + corrected #3 Track A CTA.
- **rev 5**: Phase 1 segment-scope audit pass 2 — finalized. Removed #3, #14, P1-N entirely; cascaded Track A Tuesday forward by 1 week.
- **rev 6**: promoted P5-DORA-X into W7 Thu, filling P1-N's OPEN slot.
- **rev 7**: promoted P5-eIDAS-X into W13 Tue, filling #14's OPEN slot.
- **rev 8**: post-strategy-rev-16 sync — removed stale "Derived from rev 4" pin; rewrote MiCA destination LP gate's "unblocks" column to reflect Phase 1 reality after the rev 5 deferrals.

## See Also

- Canonical regulatory map: [[EU-Fintech-Compliance-Landscape]]
- Strategy doc (article inventory + scoring): [[InnBlockchain Content Strategy]]
- ICPs: [[InnBlockchain Crypto Native ICP]] · [[InnBlockchain FinTech ICP]]
- Landing pages: [[InnBlockchain Landing Pages Plan]]
- Sister program: [[Trioangle Service Editorial Calendar]]
