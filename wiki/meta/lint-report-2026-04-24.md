---
type: meta
title: "Lint Report 2026-04-24"
created: 2026-04-24
updated: 2026-04-24
tags: [meta, lint]
status: developing
---

# Lint Report: 2026-04-24

## Summary
- Pages scanned: 169
- Issues found: 18
- Auto-fixed: 9
- Needs review: 4

---

## Dead Links

### Fixed automatically
- `[[Content Strategy - InnBlockchain FinTech]]` in `sources/Content-Strategy-InnBlockchain-Crypto-Native.md` → corrected to `[[Content-Strategy-InnBlockchain-FinTech]]`

### Missing source pages (citation links with no file)
These were referenced in Marketing/Sales research session but source pages were never created. Wikilinks exist in concept pages:
- `[[Chargebee-AI-Agent-Pricing-Playbook]]` — referenced in `concepts/Outcome-Based Pricing.md`. Suggest: create minimal stub source page or remove wikilink.
- `[[IBD-How-to-Sell-Software-Development-2025]]` — referenced in `questions/Research: Marketing and Sales for AI-Era Dev Company.md`. Same suggestion.
- `[[Improvado-Sales-Marketing-Alignment]]` — referenced in `concepts/Marketing-Sales Alignment.md` + synthesis. Same suggestion.
- `[[Martal-5-Alignment-Strategies]]` — referenced in `concepts/Marketing-Sales Alignment.md` + synthesis. Same suggestion.

### Planned content (intentionally no file yet)
- `[[claude-obsidian-presentation]]` — referenced in `wiki/overview.md` as future planned presentation. Keep as-is.

### Non-issues (Obsidian handles these)
- `[[Product Blog Article Templates]]` → Obsidian resolves to `Product-Blog-Article-Templates.md` by title. OK.
- `[[concepts/_index]]`, `[[entities/_index]]`, `[[sources/_index]]` → path-qualified, Obsidian resolves. OK.
- `[[dashboard.base]]` → Obsidian Bases file, not markdown. OK.
- `[[AI Marketing Hub Cover Images.canvas]]` → canvas file. OK.
- `[[LangGraph]]` → **see Missing Pages below** — high priority.

---

## Missing Pages

- **`LangGraph`** — referenced across 5+ concept pages (AI Agents, AI Application Stack, LLMOps, LangChain entity, Xenoss comparison) but has no dedicated entity page. LangGraph is now LangChain's primary agent framework (replaced native agents). **Fixed: entity stub created.**

---

## Orphan Pages

- `sources/Crypto-Products-Blog-Article-Templates.md` — exists but zero inbound links. Not in index. **Fixed: added to index.**
- `meta/lint-report-2026-04-15.md` — previous lint report, intentionally isolated. OK.

---

## Frontmatter Gaps

Missing `status` field on all pages created today (2026-04-24):

**Entities:** TCS, Infosys, HCL Tech, Cognizant, Accenture → **Fixed: `status: current` added**

**Concepts:** Indian IT AI Transformation Strategy, AI Services Business Model → **Fixed: `status: current` added**

**Sources:** TCS-AI-Services-Growth-2026, Infosys-Topaz-AI-First-Framework-2026, HCLTech-AI-Advantages-2026, Cognizant-Enterprise-AI-2026, Accenture-AI-Bold-Bets-2026, Indian-IT-AI-Disruption-Structural-Shift-2026 → **Fixed: `status: current` added**

---

## Stale Claims

None identified. All pages are current (2026-04-23 or 2026-04-24).

---

## Needs Review (Human Judgment Required)

1. **Missing Marketing research source pages** — `Chargebee`, `IBD`, `Improvado`, `Martal` were cited in the autoresearch but never fetched/filed as source pages. Options: (a) remove the wikilinks and keep plain text citations, or (b) run a targeted fetch to create minimal stubs. Low urgency — the concept pages are complete without them.

2. **`[[wikilinks]]`** — stray dead link appearing in old vault content. Likely a documentation artifact from vault setup. Suggest: find and remove.

3. **`[[ICP - Channel Partner-I]]`** in `log.md` line — this is a log entry referencing the old source filename (before it was renamed). Log is append-only so should not be edited. Acceptable as historical record.

4. **`Crypto-Products-Blog-Article-Templates`** — added to index under Sources. Verify the content is still accurate and hasn't been superseded by `Product-Blog-Article-Templates`.
