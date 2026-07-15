---
type: concept
title: "InnBlockchain Content Strategy"
status: current
created: 2026-04-16
updated: 2026-05-31
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
  - "[[InnBlockchain Editorial Calendar]]"
  - "[[InnBlockchain Content Repurposing Plan]]"
  - "[[EU-Compliance-Landscape]]"
  - "[[Trioangle Content Strategy]]"
---

> [!info] Layer separation (rev 17, 2026-05-26)
> This strategy doc owns **article inventory + scoring + sales motion tagging + routing rules**. It does NOT own publish dates ([[InnBlockchain Editorial Calendar]]) or derivative-content production ([[InnBlockchain Content Repurposing Plan]]). The Distribution Channels section in the canonical doc covers primary channels for **source articles only** — derivative formats (X threads, LinkedIn carousels, quote graphics, lead magnets, video, vendor risk PDFs) and the tiered investment model live in the Repurposing Plan.

# InnBlockchain Content Strategy

The InnBlockchain content program. As of rev 1 (2026-05-13), the Crypto Native + FinTech strategies are **merged into one source-of-truth doc** at `.raw/InnBlockchain/sales-marketing/Service/Content/Content Strategy.md` (currently at rev 19, 2026-05-31). One doc serves both ICPs via track tagging (`[CN]` / `[FT]` / `[Both]`); the Crypto Products strategy remains separate.

> [!warning] Wiki concept docs for the per-ICP strategies are deprecated
> [[InnBlockchain Crypto Native Content Strategy]] and [[InnBlockchain FinTech Content Strategy]] are **pre-merge artifacts** (last refreshed 2026-05-13 before the rev 1 consolidation). They no longer reflect the canonical strategy. Use the canonical `.raw` doc instead. This umbrella page is the only current wiki summary.

## Structure (post-merge)

| Strategy | Source | Status |
|---|---|---|
| **InnBlockchain (unified CN + FT)** | `.raw/InnBlockchain/sales-marketing/Service/Content/Content Strategy.md` (rev 19, 2026-05-31) | 🟢 current |
| Crypto Products | `.raw/InnBlockchain/sales-marketing/Product/Content/Content Strategy - Crypto Products.md` | 🟢 separate program (clone-script $5k–$25k buyers) |
| Editorial schedule | `.raw/InnBlockchain/sales-marketing/Service/Content/Editorial Calendar.md` | 🟢 publish dates live here; strategy doc has article inventory |
| Repurposing / derivatives | `.raw/InnBlockchain/sales-marketing/Service/Content/Content Repurposing Plan.md` (rev 7, 2026-05-27) | 🟢 derivative content production owns this layer (rev 17 separation) |

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

> [!info] [[EU-Compliance-Landscape]] is the single source of truth
> Every regulatory framing in the canonical strategy doc — A1 RWA warning callout, B1 audience qualifier, Phase 1 Segment-Scope Guard, per-segment article titles, P5 scope guards — is a scoped excerpt of the landscape doc. **If any article framing diverges, the landscape doc wins.** Two misframes to avoid: MiCA-is-not-universal-for-FinTechs, and WealthTech RWA ≠ MiCA (ownership tokens are MiFID II financial instruments under Art. 2(4)). (Wikilink renamed from `[[EU-Fintech-Compliance-Landscape]]` in rev 8 — doc now spans both ICPs.)

## EU Regulatory Coverage (post rev 19)

The strategy carries article inventory for every regulation in the canonical landscape map:

| Regulation | Coverage status |
|---|---|
| MiFID II + Prospectus + DLT Pilot Regime | 🟢 deep — primary regime for A1 + B1 RWA Phase 1 |
| MiCA | 🟢 deep — but explicitly scope-guarded (boundary clarifiers; not RWA) |
| DORA | 🟢 Phase 1 (P5-DORA-X — cross-cutting for all licensed financial entities; rev 10 promotion) |
| EU AI Act | 🟢 [Both] tokenized-asset article + B3 LendTech + Track B AI+Blockchain cluster (validation-gated to 2026-05-31) |
| AML/AMLA + TFR Travel Rule | 🟢 covered (TFR not FATF — naming-precision rev 9/10) |
| eIDAS 2.0 | 🟢 Phase 1 (P5-eIDAS-X — broadened [Both] article serving wallet auth + RWA investor KYC; rev 12 promotion) |
| CCD2 | 🟡 1 article (B3 LendTech); cross-cutting article queued for Phase 2 |
| PSD3 / PSR | 🟡 1 paired article (B4 WalletTech); standalone queued for Phase 2 |
| IPR | 🟡 1 article (B5 PayTech); activation-gated |
| GDPR | 🟡 partial (B6 RegTech); cross-cutting article queued for Phase 2 |
| FiDA | ⚪ deferred (trilogue paused) |

## The Two Misframes Corrected (rev 6 → rev 19)

The canonical doc has been through 19 revisions correcting two structural misframes:

1. **RWA ≠ MiCA.** Tokens conferring ownership of real assets are MiFID II financial instruments excluded from MiCA by Art. 2(4). The primary regime stack for RWA is MiFID II + Prospectus Regulation + DLT Pilot Regime. Six article titles renamed (rev 6) to lead with MiFID II / DLT Pilot framing; scope-guards added to P5 MiCA articles (rev 7); SEO keyword tables rewritten (rev 9); Track B P5 hub re-titled (rev 10).

2. **MiCA is not universal for FinTechs.** MiCA only triggers when the firm touches non-MiFID crypto-assets or issues a stablecoin. Pure-fiat FinTechs (PayTech, LendTech, RegTech, InsurTech without crypto) are out of MiCA scope entirely. Per-segment regime framing replaced flat "MiCA + DORA" defaults across vendor risk packs, Carol persona references, and trigger lists (rev 9/10).

## Phase 2 P5 Inventory Rebalancing

Six articles queued for Phase 2 to balance the regulatory inventory (MiCA-heavy in absolute count): GDPR cross-cutting (highest remaining priority), AML/AMLA Package, CCD2 standalone, IPR standalone, PSD3 standalone, FiDA (deferred). DORA + eIDAS already promoted to Phase 1.

## Cross-Cutting Rules (post rev 19)

> [!key-insight] Company origin is the routing gate, not licensing
> A licensed crypto-native DEX stays in Crypto Native. A licensed incumbent adding crypto routes to FinTech. First discovery question: *"Is your company a crypto-native startup, or an existing regulated financial business adding a crypto product?"*

- **EU-only until 5 projects close.** Both tracks share this geography gate. Regulatory framing is **per-segment**, not default-to-MiCA.
- **RWA is the cross-ICP battleground.** Track A A1 = platform builders + smart contract architecture. Track B B1 = licensed institutions + MiFID II instrument classification. SEO differentiation explicit per article.
- **Two motions never mix in one outreach.** Security Audit vs Development/Engineering — different buyers, cycles, ACVs.
- **AI-code audit overlay** activates immediately on any active segment deal — no gate.
- **`[Both]` shared-article pattern.** When a regulation cuts across multiple segments (EU AI Act for tokenized assets, eIDAS for KYC, MiCA-or-MiFID-II boundary), one article serves both audiences via split CTA footer. Used 3× in current inventory.
- **Per-article inline tagging (rev 18).** Phase 1 + cross-pillar + WL Roster articles carry inline `[#ID] [Track] [Motion]` prefixes. `[Both]`-tagged articles add a `[Both: Sub-type]` qualifier — `Technical` (Tom-coded derivative), `RWA-themed` (Sam-coded + dual carousel pattern), `Compliance-led` (Carol-coded primary). Sub-type values map to [[InnBlockchain Content Repurposing Plan]] rev 8 topic→persona map; writers + repurposing producers look up tags inline rather than re-deriving classification from article content. 8 borderline motion-tag cases flagged `(motion-inferred)` for owner verification. **NOT yet applied to Phase 2 / Watch verticals / full pillar inventories** — those get tags as they enter production.

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

19 revisions on canonical doc since 2026-04-16:
- **rev 1–5 (May 13–18)**: structural consolidation — merge CN + FT, cannibalization fix, WL unification, priority plan restructure, editorial schedule extraction.
- **rev 6–7 (May 19–20)**: MiCA misframe correction (6 article renames + P5 scope guards).
- **rev 8 (May 20)**: canonical regulatory reference callout pointing to [[EU-Compliance-Landscape]] (renamed from `[[EU-Fintech-Compliance-Landscape]]` — doc now spans both ICPs).
- **rev 9 (May 20)**: post-canonical audit — 4 errors + 2 gaps fixed; Phase 2 Rebalancing callout added.
- **rev 10 (May 21)**: 4th-pass audit — DORA gap fixed across 5 segments + 2 segments missing hooks (B7, B8) + Track B P5 Hub re-ordered. **DORA promoted to Phase 1** (P5-DORA-X cross-cutting article).
- **rev 11 (May 21)**: 5th-pass audit — fixed P1-N stale reference + added P5-DORA-X to inventory.
- **rev 12 (May 21)**: closed RWA Phase 1 eIDAS gap via broadened [Both] article promoted to Phase 1.
- **rev 13 (May 21)**: 6th-pass cleanup — eIDAS cross-references added to B7 + B8 + B3 hooks; stale claim removed from B4 hook.
- **rev 14 (May 21)**: 7th-pass cross-doc audit — added P5-eIDAS-X to P5 inventory; Cross-Pillar early-ship callout updated from 3 articles to 4 (P5-DORA-X + P5-eIDAS-X + C1 + T4-N).
- **rev 15 (May 21)**: removed false "Active phase" date commitments from 3 B6 articles + cluster callout — strategy doc stays at article-inventory layer; Editorial Calendar owns scheduling.
- **rev 16 (May 21)**: layer-clean pass — stripped 9 calendar-scheduling references that bled into the strategy doc as breadcrumbs from rev 10–12 promotions (week numbers, rev numbers, reassignment history). Only external date retained is the Dec 31 2026 EUDI Wallet deadline.
- **rev 17 (May 26)**: repurposing-content extraction — spun out derivative-content rules into sister doc [[InnBlockchain Content Repurposing Plan]] (tiered investment model: Tier 1/2/3/0; per-track asset families; split-CTA discipline). Distribution Channels section now strictly covers primary channels for source articles.
- **rev 18 (May 31)**: per-article inline tag application — added `[#ID] [Track] [Motion]` prefixes (with `[Both: Sub-type]` qualifier where applicable) to every Phase 1 + cross-pillar + WL Roster article entry. Closes the lookup-protocol gap surfaced during the RWA Blog 1 repurposing audit. Sub-type values (`Technical` / `RWA-themed` / `Compliance-led`) map to Repurposing Plan rev 8 topic→persona map. 8 borderline motion-tag cases flagged `(motion-inferred)` for owner verification. No article content changed.
- **rev 19 (May 31)**: hygiene pass — 3 fixes on full-doc review. (1) Repaired ~20 concatenated table rows in Priority Content Plan (Phase 2 + Phase 3 Track A, Track B B2/B3/B4, Track B Watch) where `||` separators replaced newlines — rev 1 merge artifact breaking Obsidian table rendering. (2) Reordered rev 16 / rev 17 entries in revision_notes block (chronological inversion). (3) Added A1 article-ID-numbering callout above A1 Articles subsection explaining `[#3]` and `[#14]` (P5 cross-pillar articles cross-listed; #14 deferred Phase 1 → Phase 2 per rev 7). Formatting and clarity only — no article content changed.

## See Also

- Entity: [[InnBlockchain]]
- Canonical regulatory map: [[EU-Compliance-Landscape]]
- Editorial Calendar (publish dates): [[InnBlockchain Editorial Calendar]]
- Derivative content production: [[InnBlockchain Content Repurposing Plan]]
- Design toolkit (derivative production tooling): [[InnBlockchain Content Repurposing Design Toolkit]]
- Sister program (Trioangle): [[Trioangle Content Strategy]]
- Crypto Products (separate): [[InnBlockchain Crypto Products Content Strategy]]
- Deprecated pre-merge per-ICP docs: [[InnBlockchain Crypto Native Content Strategy]] · [[InnBlockchain FinTech Content Strategy]]
