---
type: meta
title: "Lint Report 2026-04-15"
created: 2026-04-15
updated: 2026-04-15
tags: [meta, lint]
status: developing
---

# Lint Report: 2026-04-15

## Summary
- Pages scanned: 61
- Orphan pages: 0
- Dead links: 15
- Frontmatter gaps: 8
- Uningested sources in `.raw/`: 3
- Auto-fixed: 0
- Needs review: 26

## Orphan Pages
None. Every content page has at least one inbound wikilink.

## Dead Links

Critical (block cross-referencing between the three new Content Strategy pages):

- [[Content Strategy - InnBlockchain FinTech]] — referenced by [[Content-Strategy-InnBlockchain-Crypto-Native]]. **Target page does not exist yet** (source sits in `.raw/` un-ingested).
- [[Content-Strategy-InnBlockchain-FinTech]] — referenced by [[Content-Strategy-InnBlockchain-Crypto-Native]], [[Content-Strategy-InnBlockchain-Crypto-Products]]. Same root cause.
- [[InnBlockchain Content Strategy]] — referenced by [[Content-Strategy-InnBlockchain-Crypto-Native]], [[Content-Strategy-InnBlockchain-Crypto-Products]]. No parent/hub page exists. Suggest: create `wiki/concepts/InnBlockchain Content Strategy.md` as the umbrella, or drop the link.
- [[InnBlockchain Crypto Native Content Strategy]] — referenced by [[Content-Strategy-InnBlockchain-Crypto-Native]] (self-ref with a different slug). Suggest: fix to `[[Content-Strategy-InnBlockchain-Crypto-Native]]`.
- [[InnBlockchain Crypto Products Content Strategy]] — same issue in [[Content-Strategy-InnBlockchain-Crypto-Products]]. Suggest: fix to `[[Content-Strategy-InnBlockchain-Crypto-Products]]`.

Navigation / index rot:

- [[ICP - Channel Partner-I]] — referenced by [[hot]] and [[log]]. Correct target is [[InnBlockchain Channel Partner ICP]] (or similar). Suggest: fix the slug in `hot.md` and `log.md`.
- [[claude-obsidian-presentation]] — referenced by [[overview]]. Page never existed. Suggest: remove line or create stub.
- [[AI Marketing Hub Cover Images Canvas]] — referenced by [[overview]]. Canvas file, not a note. Suggest: change to `[[AI Marketing Hub Cover Images.canvas]]` or delete the line.
- [[dashboard.base]] — referenced by [[dashboard]]. This is a `.base` file, not a markdown note; Obsidian does not resolve it as a wikilink. Suggest: use an explicit file path or embed syntax instead of `[[ ]]`.

Research / sources with pending ingest:

- [[Chargebee-AI-Agent-Pricing-Playbook]] — referenced by [[Outcome-Based Pricing]]. Not yet in `.raw/` or `wiki/sources/`. Suggest: ingest or convert to plain text.
- [[IBD-How-to-Sell-Software-Development-2025]] — referenced by [[Research: Marketing and Sales for AI-Era Dev Company]]. Same.
- [[Improvado-Sales-Marketing-Alignment]] — referenced by [[Marketing-Sales Alignment]] and [[Research: Marketing and Sales for AI-Era Dev Company]]. Same.
- [[Martal-5-Alignment-Strategies]] — same two sources reference. Same.
- [[Product Blog Article Templates]] — referenced by [[Content-Strategy-Product]] and [[Trioangle Content Strategy]]. Actual file is [[Product-Blog-Article-Templates]] (hyphenated). Suggest: fix the slug.

Glossary:

- [[wikilinks]] — referenced by [[cherry-picks]]. No concept page. Suggest: drop the link or create a short glossary note.

## Uningested Sources (`.raw/`)

These three files are in `.raw/` but have no corresponding `wiki/sources/` page:

- `Content Strategy - Crypto Native.md`
- `Content Strategy - Crypto Products.md`
- `Content Strategy - FinTech.md`

> [!gap] The existing `Content-Strategy-InnBlockchain-Crypto-Native.md` and `Content-Strategy-InnBlockchain-Crypto-Products.md` source pages were written *before* the raw files were dropped. They likely need a re-ingest pass to re-cite the now-available source text and to create the missing `Content-Strategy-InnBlockchain-FinTech.md`.

## Frontmatter Gaps

Pages missing the `created` field:

- [[hot]]
- [[getting-started]]
- [[log]]
- [[index]]
- [[dashboard]]
- `wiki/concepts/_index.md`
- `wiki/entities/_index.md`
- `wiki/sources/_index.md`

All other required fields (`type`, `status`, `updated`, `tags`) are present. Safe to auto-fix by stamping `created: 2026-04-15` — but for the infra pages (`hot`, `log`, `index`) you may prefer the vault's original creation date. Flagging for review.

## Missing Pages

Candidate concept/hub pages mentioned ≥2× without their own note:

- **InnBlockchain Content Strategy** — mentioned as an umbrella in both Crypto Native and Crypto Products strategy pages. Suggest: create a hub page that links the three vertical strategies once Content-Strategy-InnBlockchain-FinTech exists.

## Stale Claims
No contradictions detected by automated scan. Manual review of recent ingests vs. older concept pages not performed this run.

## Cross-Reference Gaps
Not scanned this run (would require entity-mention NLP over 61 pages). Deferring.

## Notes

- Empty-section heuristic flagged 33 results but most are false positives (headings followed by sub-headings or tables). Not worth surfacing without a smarter check.
- No Dataview/Canvas dashboard updates needed — `wiki/meta/dashboard.md` and `wiki/Wiki Map.canvas` both exist.

---

## Recommended Fix Order

1. Fix the five self-referential slug typos in the two `Content-Strategy-InnBlockchain-*` pages (safe, mechanical).
2. Fix `[[ICP - Channel Partner-I]]` in `hot.md` and `log.md`.
3. Fix `[[Product Blog Article Templates]]` → `[[Product-Blog-Article-Templates]]` in two pages.
4. Remove or stub `[[claude-obsidian-presentation]]` and `[[AI Marketing Hub Cover Images Canvas]]` in `overview.md`.
5. Ingest the three new `.raw/` content-strategy files — this resolves the FinTech dead link and gives the other two pages proper sources.
6. Decide on `InnBlockchain Content Strategy` hub page.
7. Stamp missing `created:` dates on infra pages.

Ask before any auto-fix.
