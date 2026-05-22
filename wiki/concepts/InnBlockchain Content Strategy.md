---
type: concept
title: "InnBlockchain Content Strategy"
status: current
created: 2026-04-16
updated: 2026-05-21
tags:
  - concept
  - content-strategy
  - innblockchain
  - marketing
  - seo
related:
  - "[[InnBlockchain]]"
  - "[[InnBlockchain Crypto Native ICP]]"
  - "[[InnBlockchain FinTech ICP]]"
  - "[[InnBlockchain Crypto Products ICP]]"
  - "[[InnBlockchain Channel Partner ICP]]"
  - "[[EU-Fintech-Compliance-Landscape]]"
  - "[[Trioangle Content Strategy]]"
---

# InnBlockchain Content Strategy

The InnBlockchain content program. As of rev 1 (2026-05-13), the Crypto Native + FinTech strategies are **merged into one source-of-truth doc** at `.raw/InnBlockchain/Content/InnBlockchain - Content Strategy.md` (currently at rev 13, 2026-05-21). One doc serves both ICPs via track tagging (`[CN]` / `[FT]` / `[Both]`); the Crypto Products strategy remains separate.

> [!warning] Wiki concept docs for the per-ICP strategies are deprecated
> [[InnBlockchain Crypto Native Content Strategy]] and [[InnBlockchain FinTech Content Strategy]] are **pre-merge artifacts** (last refreshed 2026-05-13 before the rev 1 consolidation). They no longer reflect the canonical strategy. Use the canonical `.raw` doc instead. This umbrella page is the only current wiki summary.

## Structure (post-merge)

| Strategy | Source | Status |
|---|---|---|
| **InnBlockchain (unified CN + FT)** | `.raw/InnBlockchain/Content/InnBlockchain - Content Strategy.md` (rev 13, 2026-05-21) | 🟢 current |
| Crypto Products | `.raw/InnBlockchain/Content/InnBlockchain - Content Strategy - Crypto Products.md` | 🟢 separate program (clone-script $5k–$25k buyers) |
| Editorial schedule | `.raw/InnBlockchain/Content/InnBlockchain - Editorial Calendar.md` (rev 7, 2026-05-21) | 🟢 publish dates live here; strategy doc has article inventory |

## Two ICPs, One Strategy

- **Track A — Crypto-Native Builders** → [[InnBlockchain Crypto Native ICP]]. Channels: X/Telegram/ETHGlobal/GitHub. Flat buying committee. 1–3 week cycle. Payment in stablecoin/multisig. 10 segments (A1 RWA primary, A2 DEX, A3 DeFi Lending, A4 MPC Wallets, A5 NFT, A6 Token Launch, A7–A10 Watch).
- **Track B — Regulated FinTech** → [[InnBlockchain FinTech ICP]]. Channels: LinkedIn ABM/Money20/20/Finextra. Sam+Tom+Carol committee. 60–90 day cycle (+ Carol 2–8 weeks). CFO procurement at $75k+. 8 segments (B1 WealthTech primary Q2 2026, B2 ExchangeTech, B3 LendTech, B4 WalletTech, B5–B8 Watch).
- **White-Label Productized Platform** runs concurrently across both tracks. $20k+ flat floor. 7 unified articles (WL-0 through WL-6).

Every article carries three pieces of metadata: **Track tag**, **Destination LP**, **Sales Motion CTA**. Mixing tracks or motions in one article is the most common failure mode.

## Q2 2026 Primary Focus

- **Track A**: A1 RWA Tokenization (primary). Phase 1 ships ~22 numbered articles + 7 cross-pillar pieces (W1–W21).
- **Track B**: B1 WealthTech / RWA Tokenization (primary). 17 of 19 B1 articles interleaved in parallel with Track A.

Both tracks lead with RWA in Q2 2026 — the segment is the cross-ICP battleground.

## Canonical Regulatory Reference

> [!info] [[EU-Fintech-Compliance-Landscape]] is the single source of truth
> Every regulatory framing in the canonical strategy doc — A1 RWA warning callout, B1 audience qualifier, Phase 1 Segment-Scope Guard, per-segment article titles, P5 scope guards — is a scoped excerpt of the landscape doc. **If any article framing diverges, the landscape doc wins.** Two misframes to avoid: MiCA-is-not-universal-for-FinTechs, and WealthTech RWA ≠ MiCA (ownership tokens are MiFID II financial instruments under Art. 2(4)).

## EU Regulatory Coverage (post rev 13)

The strategy carries article inventory for every regulation in the canonical landscape map:

| Regulation | Coverage status |
|---|---|
| MiFID II + Prospectus + DLT Pilot Regime | 🟢 deep — primary regime for A1 + B1 RWA Phase 1 |
| MiCA | 🟢 deep — but explicitly scope-guarded (boundary clarifiers; not RWA) |
| DORA | 🟢 promoted to Phase 1 (P5-DORA-X at W7 — cross-cutting for all licensed financial entities) |
| EU AI Act | 🟢 [Both] tokenized-asset article + B3 LendTech + Track B AI+Blockchain cluster (validation-gated) |
| AML/AMLA + TFR Travel Rule | 🟢 covered (TFR not FATF — naming-precision rev 9/10) |
| eIDAS 2.0 | 🟢 promoted to Phase 1 (P5-eIDAS-X at W13 — broadened [Both] article serving wallet auth + RWA investor KYC) |
| CCD2 | 🟡 1 article (B3 LendTech); cross-cutting article queued for Phase 2 |
| PSD3 / PSR | 🟡 1 paired article (B4 WalletTech); standalone queued for Phase 2 |
| IPR | 🟡 1 article (B5 PayTech); activation-gated |
| GDPR | 🟡 partial (B6 RegTech); cross-cutting article queued for Phase 2 |
| FiDA | ⚪ deferred (trilogue paused) |

## The Two Misframes Corrected (rev 6 → rev 13)

The canonical doc has been through 13 revisions correcting two structural misframes:

1. **RWA ≠ MiCA.** Tokens conferring ownership of real assets are MiFID II financial instruments excluded from MiCA by Art. 2(4). The primary regime stack for RWA is MiFID II + Prospectus Regulation + DLT Pilot Regime. Six article titles renamed (rev 6) to lead with MiFID II / DLT Pilot framing; scope-guards added to P5 MiCA articles (rev 7); SEO keyword tables rewritten (rev 9); Track B P5 hub re-titled (rev 10).

2. **MiCA is not universal for FinTechs.** MiCA only triggers when the firm touches non-MiFID crypto-assets or issues a stablecoin. Pure-fiat FinTechs (PayTech, LendTech, RegTech, InsurTech without crypto) are out of MiCA scope entirely. Per-segment regime framing replaced flat "MiCA + DORA" defaults across vendor risk packs, Carol persona references, and trigger lists (rev 9/10).

## Phase 2 P5 Inventory Rebalancing

Six articles queued for Phase 2 to balance the regulatory inventory (MiCA-heavy in absolute count): GDPR cross-cutting (highest remaining priority), AML/AMLA Package, CCD2 standalone, IPR standalone, PSD3 standalone, FiDA (deferred). DORA + eIDAS already promoted to Phase 1.

## Cross-Cutting Rules (post rev 13)

> [!key-insight] Company origin is the routing gate, not licensing
> A licensed crypto-native DEX stays in Crypto Native. A licensed incumbent adding crypto routes to FinTech. First discovery question: *"Is your company a crypto-native startup, or an existing regulated financial business adding a crypto product?"*

- **EU-only until 5 projects close.** Both tracks share this geography gate. Regulatory framing is **per-segment**, not default-to-MiCA.
- **RWA is the cross-ICP battleground.** Track A A1 = platform builders + smart contract architecture. Track B B1 = licensed institutions + MiFID II instrument classification. SEO differentiation explicit per article.
- **Two motions never mix in one outreach.** Security Audit vs Development/Engineering — different buyers, cycles, ACVs.
- **AI-code audit overlay** activates immediately on any active segment deal — no gate.
- **`[Both]` shared-article pattern.** When a regulation cuts across multiple segments (EU AI Act for tokenized assets, eIDAS for KYC, MiCA-or-MiFID-II boundary), one article serves both audiences via split CTA footer. Used 3× in current inventory.

## Distribution Split

- **Track A**: Crypto Twitter/X, ETHGlobal, Telegram dev groups, LinkedIn EU (RWA Felix primary channel), Reddit r/defi/r/ethdev, Rekt News + DeFi Llama reactive (48h exploit trigger).
- **Track B**: LinkedIn ABM (dominant), partner/referral, Money20/20 Europe + Sibos Europe (events), segment-specific follow-up assets by persona (Sam + Tom + Carol).
- **Crypto Products** (separate program): AI Search (ChatGPT/Perplexity/Gemini) + Google SEO + Crypto Twitter + Telegram + diaspora communities.

## Open Questions (Cross-Strategy)

- No shared keyword ledger between Track A and Track B. Disambiguation is prose per-article, not a central registry. First publishing conflict is the risk surface.
- Compliance Carol attribution methodology undefined — she's a veto-holder addressed via content but not a buyer.
- Channel Partner ICP has no dedicated content program — partner recruitment messaging lives inside Track A + Track B without explicit anchoring.
- Phase 2 P5 Rebalancing queue has 6 articles waiting on segment activation; promotion criteria currently judgment-based (DORA + eIDAS promoted on hard external deadlines, not segment activation).

## Revision History

13 revisions on canonical doc since 2026-04-16:
- **rev 1–5 (May 13–18)**: structural consolidation — merge CN + FT, cannibalization fix, WL unification, priority plan restructure, editorial schedule extraction.
- **rev 6–7 (May 19–20)**: MiCA misframe correction (6 article renames + P5 scope guards).
- **rev 8 (May 20)**: canonical regulatory reference callout pointing to [[EU-Fintech-Compliance-Landscape]].
- **rev 9 (May 20)**: post-canonical audit — 4 errors + 2 gaps fixed; Phase 2 Rebalancing callout added.
- **rev 10 (May 21)**: 4th-pass audit — DORA gap fixed across 5 segments + 2 segments missing hooks (B7, B8) + Track B P5 Hub re-ordered.
- **rev 11 (May 21)**: 5th-pass audit — fixed P1-N stale reference + added P5-DORA-X to inventory.
- **rev 12 (May 21)**: closed RWA Phase 1 eIDAS gap via broadened [Both] article promoted to W13.
- **rev 13 (May 21)**: 6th-pass cleanup — eIDAS cross-references added to B7 + B8 + B3 hooks; stale claim removed from B4 hook.

## See Also

- Entity: [[InnBlockchain]]
- Canonical regulatory map: [[EU-Fintech-Compliance-Landscape]]
- Sister program (Trioangle): [[Trioangle Content Strategy]]
- Crypto Products (separate): [[InnBlockchain Crypto Products Content Strategy]]
- Deprecated pre-merge per-ICP docs: [[InnBlockchain Crypto Native Content Strategy]] · [[InnBlockchain FinTech Content Strategy]]
