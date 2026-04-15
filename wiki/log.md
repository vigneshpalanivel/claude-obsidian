---
type: meta
title: "Operation Log"
updated: 2026-04-08
tags:
  - meta
  - log
status: evergreen
related:
  - "[[index]]"
  - "[[hot]]"
  - "[[overview]]"
  - "[[sources/_index]]"
---

# Operation Log

Navigation: [[index]] | [[hot]] | [[overview]]

Append-only. New entries go at the TOP. Never edit past entries.

Entry format: `## [YYYY-MM-DD] operation | Title`

Parse recent entries: `grep "^## \[" wiki/log.md | head -10`

---

## [2026-04-15] ingest | ICP - Channel Partner-T.md + ICP - Service.md
- Sources: .raw/ICP - Channel Partner-T.md and .raw/ICP - Service.md (Trioangle internal, 2026)
- Pages created: [[ICP-Channel-Partner-Trioangle]], [[ICP-Service-Trioangle]], [[Trioangle Channel Partner Personas]], [[Trioangle Service ICP]]
- Updated: [[sources/_index]], [[concepts/_index]], [[index]]
- Key finding 1 (Channel Partner): Enterprise Buyer and MENA Relationship Buyer in the Service ICP are not reachable via direct outbound - channel partners are the only access path. This makes the partner program structurally necessary, not just a growth lever.
- Key finding 2 (Service ICP): AI-Forward Platform Operator (Persona 5) is a 2026-emergent buyer archetype - existing platforms under competitive AI pressure, needs domain-specific AI features, not a rebuild. Distinct from all prior personas.

## [2026-04-15] ingest | ICP - Product.md
- Source: .raw/ICP - Product.md (Trioangle internal, 2026)
- Pages created: [[Trioangle]], [[Trioangle Buyer Personas]], [[ICP-Product]]
- Updated: [[entities/_index]], [[sources/_index]], [[index]]
- Key finding: Persona 6 (AI Builder Who Hit the Wall) is a named, revenue-generating buyer archetype — direct validation that vibe coding creates a real market for production-deployment services

## [2026-04-15] autoresearch | Marketing and Sales for AI-Era Dev Company
- Rounds: 2
- Sources found: 4 (IBD Consulting, Improvado alignment guide, Martal 5 strategies, Sopro alignment stats)
- Pages created: [[Marketing-Sales Alignment]], [[Research: Marketing and Sales for AI-Era Dev Company]]
- Updated: [[index]], [[concepts/_index]]
- Key finding: Do NOT position on "faster with AI" — position on certainty of outcome. Buyers in 2026 can vibe-code themselves; they're buying risk reduction and end-to-end accountability.

## [2026-04-15] autoresearch | Running a Software Dev Company Post-Vibe-Coding
- Rounds: 2
- Sources found: 6 (Karpathy 2025, Jellyfish Eng Mgmt, LeadDev 5 Predictions, Augment Code Hiring, Harvard Gazette, Chargebee Pricing)
- Pages created: [[Vibe Coding]], [[Agentic Engineering]], [[AI-Native Engineering Team]], [[Outcome-Based Pricing]], [[Karpathy-2025-Year-in-Review]], [[Jellyfish-2025-Engineering-Management]], [[LeadDev-5-Predictions-2026]], [[Augment-Code-AI-Native-Hiring]], [[Research: Running a Software Dev Company Post-Vibe-Coding]]
- Updated: [[Andrej Karpathy]] (added vibe coding + agentic engineering), [[index]], [[concepts/_index]], [[sources/_index]]
- Key finding: The competitive advantage in software dev has moved from headcount to leverage — smaller teams with AI orchestration skills out-deliver larger traditional teams; pricing must shift from hourly to outcome-based

## [2026-04-08] save | claude-obsidian v1.4 Release Session
- Type: session
- Location: wiki/meta/claude-obsidian-v1.4-release-session.md
- From: full release cycle covering v1.1 (URL/vision/delta tracking, 3 new skills), v1.4.0 (audit response, multi-agent compat, Bases dashboard, em dash scrub, security history rewrite), and v1.4.1 (plugin install command hotfix)
- Key lessons: plugin install is 2-step (marketplace add then install), allowed-tools is not valid frontmatter, Bases uses filters/views/formulas not Dataview syntax, hook context does not survive compaction, git filter-repo needs 2 passes for full scrub

## [2026-04-08] ingest | Claude + Obsidian Ecosystem Research
- Type: research ingest
- Source: `.raw/claude-obsidian-ecosystem-research.md`
- Queries: 6 parallel web searches + 12 repo deep-reads
- Pages created: [[claude-obsidian-ecosystem]], [[cherry-picks]], [[claude-obsidian-ecosystem-research]], [[Ar9av-obsidian-wiki]], [[Nexus-claudesidian-mcp]], [[ballred-obsidian-claude-pkm]], [[rvk7895-llm-knowledge-bases]], [[kepano-obsidian-skills]], [[Claudian-YishenTu]]
- Key finding: 16+ active Claude+Obsidian projects; 13 cherry-pick features identified for v1.3.0+
- Top gap confirmed: no delta tracking, no URL ingestion, no auto-commit

## [2026-04-07] session | Full Audit, System Setup & Plugin Installation
- Type: session
- Location: wiki/meta/full-audit-and-system-setup-session.md
- From: 12-area repo audit, 3 fixes, plugin installed to local system, folder renamed

## [2026-04-07] session | claude-obsidian v1.2.0 Release Session
- Type: session
- Location: wiki/meta/claude-obsidian-v1.2.0-release-session.md
- From: full build session — v1.2.0 plan execution, cosmic-brain→claude-obsidian rename, legal/security audit, branded GIFs, PDF install guide, dual GitHub repos


- Source: `.raw/` (first ingest)
- Pages updated: [[index]], [[log]], [[hot]], [[overview]]
- Key insight: The wiki pattern turns ephemeral AI chat into compounding knowledge — one user dropped token usage by 95%.

## [2026-04-07] setup | Vault initialized

- Plugin: claude-obsidian v1.1.0
- Structure: seed files + first ingest complete
- Skills: wiki, wiki-ingest, wiki-query, wiki-lint, save, autoresearch
