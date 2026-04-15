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

## [2026-04-15] reingest | Content Strategy - Product.md + Product Blog Article Templates.md (rev 2)
- Sources: .raw/Content Strategy - Product.md, .raw/Product Blog Article Templates.md (propagation from ICP v3 gap-fix pass)
- Pages updated: [[Content-Strategy-Product]], [[Product-Blog-Article-Templates]], [[Trioangle Content Strategy]]
- Content Strategy additions: Persona 6 in Target Audience (<14 day cycle); AI-Era Positioning Rule callout under Mission; Pillar 3 rationale rewritten to reference PP5 7/10 + 4.0 App Store rating filter; Trioangle Founder Referral named in channel #7 + Priority Distribution Channels (dual reward, 90-day attribution, Small Business added as beneficiary); new Secondary Markets distribution playbook (6-row comparison); T14 gains 2 P6 AI-trigger variants; Quick Win #7 promotes T18 as canonical P6 unlock
- Blog Templates additions: AI-Era Positioning Rule + Persona Abbreviations (P1–P6 with P6 technical-honesty warning) at intro; T14 gains 2 P6 AI-trigger variants + P6 CTA; T18 "Clone Script vs AI Builders" elevated to canonical P6 decision anchor with extended writer brief (acknowledge-then-document-gap); T11 P6 case study note; new Global Writer Briefs section (Secondary-Market Variants table, AI-Era Compliance Check, Referral Program References)
- Concept update: [[Trioangle Content Strategy]] gains Global Writer Briefs section and Persona 6 Coverage Map table; T18 standout entry rewritten as canonical P6 anchor with technical-honesty rule
- Decision: no new top-level template (T21+) added — P6 short cycle + narrow pain is served by T14 awareness + T18 decision variants; revisit only if P6 inbound justifies second decision-stage asset

## [2026-04-15] reingest | ICP - Product.md (v3 — gap fixes)
- Source: .raw/ICP - Product.md (third pass — 6 gap fixes + 6 structural/consistency fixes from review)
- Pages updated: [[Trioangle Product ICP]], [[ICP-Product-Trioangle]]
- Gap fixes: (1) Persona 1 AI-displacement re-evaluation triggers with CRM-tagging dependency, (2) PP5 severity 5→7/10 + rewritten workaround/cost/emotion, (3) Trioangle Founder Referral — full structured program definition (eligibility, 90-day attribution, support-or-cash reward, tracking, activation), (4) Persona 6 origin paragraph (why they chose AI over agency — priced out + peer burns + creator-wave belief), (5) Other Clone Vendors row quantified (205 scripts vs competitor 20–60), (6) Secondary Markets distinct playbook (channel mix, payment, language, trust signals, sales motion)
- Consistency fixes: blockquote prefix repair on Product→Service routing row; Post-Purchase Arc + Top 3 Channels updated to reference the new referral program structure
- Key finding: referral program was referenced in 3 places but never defined — now a named, tracked program with a 90-day window tuned to the slowest documented persona decision cycle

## [2026-04-15] ingest | Trioangle - Product Verticals.md
- Source: .raw/Trioangle - Product Verticals.md (Trioangle internal, sitemap analysis, 2026)
- Pages created: [[Trioangle-Product-Verticals]]
- Updated: [[sources/_index]], [[index]]
- Key finding 1: 205 distinct product scripts across 8 verticals — distinct from 800+ deployments; full brand name map documented (Gofer, Makent, PassUp, PopTok, Igniter, GoferHandy, GoferJek, GoferTow, Udify)
- Key finding 2: Watchit (YouTube/Vimeo clone) appears in this source but is NOT an active product — flagged in source page; never reference in any content

## [2026-04-15] reingest | ICP - Service.md (updated)
- Source: .raw/ICP - Service.md (updated by user — three additions)
- Pages updated: [[Trioangle Service ICP]], [[ICP-Service-Trioangle]]
- Addition 1: PP numbering fixed — PP6 (AI Knowledge Gap, 9/10) renumbered to PP5; PP5 (Domain Expertise, 7/10) renumbered to PP6; order now matches severity descending
- Addition 2: AI-era positioning rule added — "Never position on faster with AI. Position on domain expertise, certainty of delivery, and risk reduction." Added to both raw file and concept page
- Addition 3: Discovery Sprint defined as a named pre-sales offer — $1,500-$4,000, 2 weeks, credited toward full engagement; added to raw file and concept page with deliverables and sales line

## [2026-04-15] reingest | ICP - Product.md (updated)
- Source: .raw/ICP - Product.md (updated by user — two additions)
- Pages updated: [[Trioangle Product ICP]], [[ICP-Product-Trioangle]]
- Addition 1: Vertical inbound priority column added to 8 Product Verticals table; rows reordered by inbound signal; PopTok (TikTok clone) flagged as active inbound — build BOFU immediately
- Addition 2: AI-era positioning rule added — "Never position on faster with AI. Position on certainty of outcome and risk reduction." Added to Executive Summary in source and as standalone section in concept page

## [2026-04-15] ingest | Content Strategy - Product.md + Content Strategy - Service.md + Product Blog Article Templates.md
- Sources: .raw/Content Strategy - Product.md, .raw/Content Strategy - Service.md, .raw/Product Blog Article Templates.md (Trioangle internal, 2026)
- Pages created: [[Content-Strategy-Product]], [[Content-Strategy-Service]], [[Product-Blog-Article-Templates]], [[Trioangle Content Strategy]]
- Updated: [[sources/_index]], [[concepts/_index]], [[index]]
- Key finding 1 (Product): TikTok clone (PopTok) has active inbound NOW — BOFU content must be built alongside TOFU to capture existing demand immediately. Don't wait for full awareness funnel.
- Key finding 2 (Service): CTA is strictly persona-gated. MENA articles NEVER use form-based CTAs — always LinkedIn/WhatsApp, no exceptions. Budget overlap zone ($30k-$40k) defaults to Founder-CTO motion unless post-Series A context confirmed.
- Key finding 3 (Templates): Article #36 (Build vs Buy 2026, score 9.3) is the one piece that bridges both ICPs — must coordinate across both content calendars. WatchIt (long-video clone) is NOT an active product; never reference it.

## [2026-04-15] ingest | ICP - Channel Partner-T.md + ICP - Service.md
- Sources: .raw/ICP - Channel Partner-T.md and .raw/ICP - Service.md (Trioangle internal, 2026)
- Pages created: [[ICP-Channel-Partner-Trioangle]], [[ICP-Service-Trioangle]], [[Trioangle Channel Partner Personas]], [[Trioangle Service ICP]]
- Updated: [[sources/_index]], [[concepts/_index]], [[index]]
- Key finding 1 (Channel Partner): Enterprise Buyer and MENA Relationship Buyer in the Service ICP are not reachable via direct outbound - channel partners are the only access path. This makes the partner program structurally necessary, not just a growth lever.
- Key finding 2 (Service ICP): AI-Forward Platform Operator (Persona 5) is a 2026-emergent buyer archetype - existing platforms under competitive AI pressure, needs domain-specific AI features, not a rebuild. Distinct from all prior personas.

## [2026-04-15] ingest | ICP - Product.md
- Source: .raw/ICP - Product.md (Trioangle internal, 2026)
- Pages created: [[Trioangle]], [[Trioangle Buyer Personas]], [[ICP-Product-Trioangle]]
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
