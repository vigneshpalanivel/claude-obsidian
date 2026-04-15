---
type: meta
title: "Hot Cache"
updated: 2026-04-15T00:00:00
tags:
  - meta
  - hot-cache
status: evergreen
related:
  - "[[index]]"
  - "[[log]]"
  - "[[Wiki Map]]"
  - "[[getting-started]]"
  - "[[claude-obsidian-v1.4-release-session]]"
---

# Recent Context

Navigation: [[index]] | [[log]] | [[overview]]

## Last Updated
2026-04-15: autoresearch on running a software dev company in the vibe coding / AI era. 9 pages created.

## Key Recent Facts (Ingest: ICP - Channel Partner-T.md + ICP - Service.md — Trioangle)
- Service ICP: 5 buyer personas for custom dev + AI engineering ($10k-$120k+). Personas 1+2+5 reachable directly; Persona 3 (Enterprise) and Persona 4 (MENA) require channel partner intermediaries.
- AI-Forward Platform Operator (Service Persona 5, 2026): existing platform, needs AI features (dispatch, pricing, forecasting) - not a rebuild. Budget $15k-$60k. 4-8 week close.
- Channel Partner ICP: 3 partner personas (Overflow Agency Lead, Consulting Upseller, Vertical Specialist). All share the same primary trust barrier: non-circumvention (NCNDA must be signed Day 1).
- NCNDA framing note: "800+ projects delivered" can backfire with partners - they fear Trioangle will bypass them. Counter: Trioangle has no direct sales motion for these markets; partner model is permanent.
- Discovery Sprint ($1,500-$4,000) available as paid pre-sales scoping tool for all partner types.
- India-based agencies excluded from Channel Partner ICP: peer/competitor perception prevents sub-contractor trust.
- Qualification shortcut (Service ICP): <$10k disqualify; $10k-$40k = Persona 2 motion; $40k+ = assess technical vs. relationship-led buyer.

## Key Recent Facts (Ingest: ICP - Product.md — Trioangle)
- Trioangle: marketplace clone scripts, operating since 2015, 800+ platforms, 150+ countries. Product ($500–$25k) + Service ($10k+ custom) lines.
- 6 buyer archetypes: Visionary Velocity, Burned Builder, Diaspora Entrepreneur, Small Business Digitalizer, Super-App Builder, AI Builder Who Hit the Wall
- Persona 6 (AI Builder Who Hit the Wall) is a direct named consequence of the vibe coding wave — buyers who spent 4–8 weeks in Cursor/Lovable arrive needing production deployment, not more code
- Persona 1 (Visionary Velocity) is most at risk of AI displacement — compete on certainty of outcome (live date, App Store approval record), not speed to demo
- Product routing decision tree lives in [[Trioangle]] entity page
- Disqualify: sub-$5k super-app ambition, "cheapest option" buyers, resellers without a live client project

## Key Recent Facts (Autoresearch: Marketing + Sales for AI-Era Dev Company)
- Core positioning rule: do NOT market "we write code faster with AI" — that commoditizes you. Market certainty of outcome and risk reduction.
- ICP in 2026: companies that tried DIY/AI and hit the wall — regulated industries, post-PMF scaling, non-technical founders with budget
- Handle the "why not just vibe-code it?" objection: code is only 25-35% of project scope; architecture, security, compliance, integration are the rest
- Three objections to script: "we can build it ourselves," "AI should make this cheaper," "we have AI tools in-house"
- Alignment mechanics: one shared ICP doc, objection-to-content pipeline (sales logs objections, marketing builds content), lead SLA (24h follow-up)
- RevOps model: 57% of B2B companies building it; for small teams, one person can own it

## Key Recent Facts (Autoresearch: AI-Era Dev Company)
- Vibe coding (Karpathy, Feb 2025) is now passé. The current term is "agentic engineering" — orchestrating multi-step autonomous agent workflows
- 90% of engineering teams use AI coding tools; Claude Code became #1 tool in 8 months
- Smaller teams with better judgment out-deliver larger traditional coding teams
- Hire for: product taste, architectural judgment, agent leverage, communication, ownership, learning velocity (NOT coding speed)
- Price for: outcomes and value, not hours. Hybrid model (base retainer + variable) is the practical entry point
- Quality crisis: AI code has 1.7x more bugs; 1 in 5 security breaches traces to AI-generated code. 2026 = year of quality, not speed
- Only 20% of teams measure AI's impact — the measurement gap is a leadership failure, not a tool problem

## Recent Changes
- Created: [[Vibe Coding]], [[Agentic Engineering]], [[AI-Native Engineering Team]], [[Outcome-Based Pricing]]
- Created sources: [[Karpathy-2025-Year-in-Review]], [[Jellyfish-2025-Engineering-Management]], [[LeadDev-5-Predictions-2026]], [[Augment-Code-AI-Native-Hiring]]
- Created synthesis: [[Research: Running a Software Dev Company Post-Vibe-Coding]]
- Updated: [[Andrej Karpathy]] (added vibe coding + agentic engineering contributions)

## Active Threads
- Research filed: AI-era software company operations
- v1.5.0 backlog still open: /adopt command, vault graph analysis, semantic search, Marp output

## Plugin State
- **Version**: 1.4.1 (installed, enabled, user scope)
- **Install ID**: `claude-obsidian@claude-obsidian-marketplace`
- **Releases**: v1.1, v1.4.0, v1.4.1 on GitHub
- **Skills**: 10 (wiki, wiki-ingest, wiki-query, wiki-lint, save, autoresearch, canvas, defuddle, obsidian-bases, obsidian-markdown)
- **Hooks**: 4 (SessionStart, PostCompact, PostToolUse, Stop)
- **Multi-agent**: bootstrap files for Codex, OpenCode, Gemini, Cursor, Windsurf, GitHub Copilot

## Install Command (Correct Two-Step Flow)
```bash
claude plugin marketplace add AgriciDaniel/claude-obsidian
claude plugin install claude-obsidian@claude-obsidian-marketplace
```

There is no `claude plugin install github:owner/repo` shortcut. Both steps are required. Full session note: [[claude-obsidian-v1.4-release-session]].

## Recent Release Cycle (v1.1 → v1.4.1)
- **v1.1**: URL ingestion, vision ingestion, delta tracking manifest, 3 new skills (defuddle, obsidian-bases, obsidian-markdown), multi-depth query modes, PostToolUse auto-commit, removed invalid `allowed-tools` frontmatter field
- **v1.4.0**: Dataview to Bases migration (new `wiki/meta/dashboard.base`), Canvas JSON 1.0 spec completeness, PostCompact hook, Obsidian CLI MCP option, 6 multi-agent bootstrap files, 249 em dashes scrubbed, security git history rewrite to remove placeholder email
- **v1.4.1**: hotfix for wrong plugin install command syntax in README and install-guide.md

## Key Lessons (Recent)
1. Plugin install is always two-step: `marketplace add` then `install plugin@marketplace`
2. `allowed-tools` is NOT valid in skill frontmatter. Use only `name` and `description` (kepano convention).
3. Obsidian Bases uses `filters/views/formulas`, not Dataview `from/where`
4. Canvas edges have asymmetric defaults: `fromEnd="none"`, `toEnd="arrow"`
5. Hook-injected context does not survive compaction. PostCompact hook is required to restore hot cache.
6. `git filter-repo` needs two passes: `--replace-text` for blobs, `--replace-message` for commit messages

## Style Preferences (Saved to Memory)
- **No em dashes** (U+2014) or `--` as punctuation anywhere. Use periods, commas, colons, or parentheses. Hyphens in compound words are fine (auto-commit, multi-agent).
- Keep responses short and direct. No trailing "here's what I did" summaries.
- Parallel tool calls when independent.

## Ecosystem Research (Done 2026-04-08)
16+ Claude + Obsidian projects mapped. Full feature matrix at [[claude-obsidian-ecosystem]]. Prioritized backlog at [[cherry-picks]]. Top competitors: [[Ar9av-obsidian-wiki]] (multi-agent + delta tracking), [[rvk7895-llm-knowledge-bases]] (multi-depth query), [[ballred-obsidian-claude-pkm]] (goal cascade + auto-commit), [[kepano-obsidian-skills]] (authoritative Obsidian skills from Obsidian's own creator).

## Active Threads
- v1.5.0 backlog: `/adopt` command, vault graph analysis in wiki-lint, semantic search via qmd, Marp output
- `community` remote (`avalonreset-pro/claude-obsidian`) still has pre-rewrite history. Force-push needed next time that remote is configured.

## Repo Locations
- Working: `~/Desktop/claude-obsidian/`
- Public: https://github.com/AgriciDaniel/claude-obsidian
- Community (private): https://github.com/avalonreset-pro/claude-obsidian
