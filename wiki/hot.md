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
2026-04-16: autoresearch on "Hyperledger Fabric." 5 web searches. 2 pages created: source [[autoresearch-hyperledger-fabric]] and concept [[Hyperledger-Fabric]]. Key facts: open-source enterprise permissioned blockchain under Linux Foundation (LF Decentralized Trust); original IBM contribution 2015. Architecture: peers (endorser + committer roles), orderers (consensus only, no chaincode), channels (isolated sub-ledgers for privacy), chaincode (Go/JS/Java), MSP (certificate-based identity). Transaction model: execute-order-validate -- endorsers simulate in parallel, orderers sequence, committers validate and write. This model scales horizontally unlike Ethereum's order-execute. Consensus: Raft (current default, CFT); Kafka deprecated; Solo dev-only. Performance: 2000+ TPS; 5x throughput and 26x lower latency than private Ethereum. Mindshare: 31.9% (Aug 2025). Fabric-X (2025): purpose-built for 100k+ TPS digital assets, tokenized securities, stablecoins; V1.0 target May 15 2025. Top use cases: supply chain (pharma, food, logistics), trade finance, healthcare, financial services, government. Key failure: TradeLens (Maersk+IBM) shut down 2022 -- technology worked, network adoption failed. Key limitations: endorsement rigidity for multi-party workflows (Fabric-X fixes this), interoperability with other chains unsolved, high operational complexity. InnBlockchain relevance: pharma/supply-chain clients run Fabric chaincode (Go) not Solidity -- different audit methodology required; AI-generated Go chaincode carries same hidden-logic risk as AI-generated Solidity.

2026-04-16: autoresearch on "blockchain in pharmaceutical supply chain." 4 web searches. 2 pages created: source [[autoresearch-blockchain-pharma-supply-chain]] and concept [[Blockchain-Pharmaceutical-Supply-Chain]]. Key facts: drug trace time collapses from 16 weeks to 2 seconds; WHO estimates 10% of global medicines are counterfeit ($200B+/year); DSCSA full enforcement 2025 (US); blockchain pharma supply chain market $1.27B (2024) -> $5.84B by 2032 (21% CAGR); cold chain blockchain $0.8B -> $6.2B by 2033 (25.4% CAGR). Production implementations: MediLedger (Pfizer, Merck, zero-knowledge proofs), IBM Transparent Supply, SAP Info Collab Hub (Boehringer Ingelheim), VeChain (Jan 2025), EFDA Ethiopia (Nov 2024). Five core use cases: anti-counterfeit verification, end-to-end traceability, cold chain IoT + smart contracts, recall management, compliance automation. Key challenges: scalability at global volume, multi-party adoption required, high integration cost for mid-tier manufacturers. AI intersection: AI-generated supply chain smart contracts carry same audit risk as DeFi contracts -- custody transfer conditions, escrow rules, compliance triggers. Positioning opportunity for InnBlockchain audit services in regulated supply chain context.

2026-04-16: ingested `Test Architect (TEA) Documentation (Full).md` (16.5k-line v2026-04-13 BMad TEA module snapshot). 8 pages created: source [[TEA-Documentation]] plus 7 concepts ([[Test Architect (TEA)]], [[TEA Workflows]], [[TEA Engagement Models]], [[Risk-Based Testing]], [[Fixture Architecture]], [[Network-First Testing]], [[TEA Knowledge Base System]]). Updated [[BMAD Method]] entity to cross-link TEA module + source. Key facts: TEA = Murat persona, BMad's testing module; 9 workflows span Phase 3/4/Release Gate (only BMad agent multi-phase); three-part stack vs AI test slop = Playwright-Utils + TEA workflows + Playwright/Pact MCP; Risk Score = Probability × Impact (1-9), Score 9 mandatory FAIL, 6-8 requires mitigation; 6 risk categories TECH/SEC/PERF/DATA/BUS/OPS; P0-P3 coverage targets 100/90/50/20%; `test-design` dual-mode (system-level = 2 docs, epic-level = 1 doc); `trace` two-phase (FULL/PARTIAL/NONE matrix → PASS/CONCERNS/FAIL/WAIVED gate); `test-review` scores Determinism 30/Isolation 30/Maintainability 25/Performance 15; 42 fragments in tea-index.csv loaded selectively per workflow (context engineering, not prompt engineering); 5 engagement models (No/Solo/Lite/Integrated-Greenfield/Integrated-Brownfield); Quick Flow skips TEA. Fixture Architecture rule: pure function first, fixture wrapper second, mergeTests compose third. Network-First rule: intercept-before-navigate eliminates hard-wait flakiness.

2026-04-15: ingested `BMAD Method Documentation (Full).md` (v6 docs snapshot from docs.bmad-method.org/llms-full.txt). 8 pages created: source summary [[BMAD-Method-Documentation]], entity [[BMAD Method]], and 6 concept pages ([[BMad Four-Phase Workflow]], [[BMad Quick Dev]], [[BMad Project Context]], [[Adversarial Review]], [[Advanced Elicitation]], [[Working Backwards PRFAQ]]). Key patterns worth stealing for claude-obsidian: (a) project-context.md as a lean constitution loaded on every implementation workflow — maps onto vault CLAUDE.md, (b) adversarial review with mandatory finding floor + orthogonal edge-case hunter — directly applicable to `wiki-lint`, (c) intent-compression-then-autonomous-run pattern from Quick Dev — maps onto `/autoresearch` loop design, (d) named reasoning methods (pre-mortem, inversion) from Advanced Elicitation as alternatives to vague "try again" retries, (e) fresh-chat-per-workflow rule enforces "documents are the context, not chat scrollback." V6 sequencing change: epics/stories now created AFTER architecture (not before) because technical decisions shape work breakdown.

2026-04-16: ingested all 3 InnBlockchain Content Strategy files (Crypto Native, Crypto Products, FinTech). 7 pages created: 3 source summaries ([[Content-Strategy-InnBlockchain-Crypto-Native]], [[Content-Strategy-InnBlockchain-Crypto-Products]], [[Content-Strategy-InnBlockchain-FinTech]]), 3 concept pages ([[InnBlockchain Crypto Native Content Strategy]], [[InnBlockchain FinTech Content Strategy]], [[InnBlockchain Crypto Products Content Strategy]]), and 1 umbrella concept ([[InnBlockchain Content Strategy]]). [[InnBlockchain]] entity + index + log updated. Channel Partner ICP has no dedicated content program (flagged as open question in umbrella).

2026-04-15: re-ingested `InnBlockchain - ICP - FinTech.md` after review. 8 fixes to source: segment reorder (WealthTech now Seg 1, ExchangeTech Seg 2 — doc order matches priority), API-first contradiction resolved (Tier 0 tag formalized), unused maturity tiers deleted, age ranges removed from all 3 personas, Segment 7 marked Blocked on CFO persona definition, anti-ICP block dedup'd, interview Q17 reframed as indirect budget question, AI content tagged `[unvalidated — pending 2026-05-31]` at Pain Point 5 / WealthTech AI convergence / SEO AI+Blockchain cluster. Updated [[ICP-InnBlockchain-FinTech]] source and [[InnBlockchain FinTech ICP]] concept.

2026-04-15: re-ingested `InnBlockchain - ICP - Crypto Native.md` after review. 7 targeted fixes to source: budget floor split ($30k+ RWA vs $20k+ other; $2M+ reframed as DeFi signal only), validation discovery calls pushed to 2026-05-31 with explicit Phase 1 dependency, Segment 10 split status (AI-code audit overlay Active immediately; standalone Watch), Segment 1 ACV floor raised to $30k+ to match target, Segment priority callout (RWA is #1 outbound — numeric order = priority), Sasha AI-code counter-objection row added, $10M Sasha threshold validation owned by Sales Lead due 2026-07-31. Updated [[ICP-InnBlockchain-Crypto-Native]] source + [[InnBlockchain Crypto Native ICP]] concept.

2026-04-15: re-ingested `Trioangle - ICP - Channel Partner.md` after consistency review against Product + Service ICPs. 5 targeted fixes to source (MENA range, Segment Access softening, AI-Forward Operator added to P3, P1 delivery-mode exception, budget floor split by mode) plus prior pass (InnBlockchain wikilink, Discovery Sprint hoisted). Updated [[ICP-Channel-Partner-Trioangle]] source summary and [[Trioangle Channel Partner Personas]] concept page.

2026-04-15: reingested `InnBlockchain - ICP - Crypto Products.md` after review. 10 targeted fixes applied to source + concept page (group-company header, validation status, pricing scope dial, prohibited-jurisdiction DQs, MiCA/FCA/MAS/VARA/US regulatory framing, Persona 3 budget reconciliation, defensible competitive math, graduation path section with 25% target, Persona 4 phishing/royalty-bypass objection, 800+ backfire warning for channel-partner deals).

2026-04-15: ingested 4 InnBlockchain ICPs (Crypto Native, FinTech, Channel Partner, Crypto Products). 9 pages created (1 entity + 4 concept + 4 source).

## Key Recent Facts (Re-ingest: Trioangle Channel Partner ICP — consistency fixes)
- **MENA Relationship Buyer range corrected** in P2 end-client mapping: was $30k-$80k, now $30k-$120k+ (matches [[Trioangle Service ICP]] Persona 4 authoritative range). Prior Channel Partner doc understated the ceiling by $40k.
- **Segment Access framing softened**: Enterprise + MENA buyers are NOT "unreachable" via direct outbound — Service ICP lists LinkedIn/Clutch/Gartner as active channels for both. Accurate framing is "technically reachable but slow and trust-gated; partners compress cycles from months to weeks."
- **AI-Forward Platform Operator added to P3 routing**: Service ICP Persona 5 ($15k-$60k) — client who stalled on Cursor/Lovable and needs a domain specialist to take over. Previously missing from Channel Partner end-client mapping despite being the natural fit for P3 Vertical Specialist's domain-depth pitch.
- **P1 delivery-mode exception recorded**: ICP-level framing is Custom Dev primary / Clone Script alternative, but P1 Overflow Agency is the exception — end clients skew Product ICP ($500-$25k), so Clone Script is the primary route for P1 partners. Custom Dev is the upsell when a client outgrows the template.
- **Budget floor clarified**: Must-Have criteria previously said "$10k+ net dev cost" but conflicted with the $500-$25k clone script alternative. Now split: $10k+ for Custom Dev; $500+ for Clone Script **with a named live client brief** (bulk licensing still disqualifying).
- **Discovery Sprint ($1.5k-$4k) hoisted into Executive Summary** — was buried in an objection footnote. Commercial offer, not a technical detail.
- **InnBlockchain wikilink fixed**: `[[ICP - Channel Partner-I]]` was a dead link; now points at [[InnBlockchain Channel Partner ICP]].
- **Unaddressed judgment calls** (not yet resolved): Burned Builder (Product Persona 2) and Super-App Ecosystem Builder (Product Persona 5) remain omitted from Channel Partner routing — may be deliberate (too small / too self-serve for partner motion) but not confirmed.

## Key Recent Facts (Ingest: InnBlockchain ICPs)
- InnBlockchain is Trioangle's **sister/group company** for blockchain-native dev + smart contract security. Four ICPs: Crypto Native, FinTech, Channel Partner, Crypto Products.
- **Company origin is the ONLY routing gate** between Crypto Native and FinTech — not licensing status. Any crypto-born startup = Crypto Native (licensed or not). Existing regulated FinTech adding crypto = FinTech. Discovery question: *"Is your company a crypto-native startup, or an existing regulated financial services business adding a crypto product?"*
- **EU Continental only until 5-project gate** applies to ALL four InnBlockchain ICPs. No outbound capacity on UK, US, MENA, SEA, Singapore until 5 EU deals close. MiCA is the dominant compliance framing.
- **API-first backend live in production** is the Tier 0 velocity signal (FinTech + Channel Partner P2). Skip preliminary discovery if confirmed.
- Crypto Native **Segment 1 is RWA Tokenization** (strategic prioritization) — real estate, vehicles, commodities, art, private credit. Stakes differ from DeFi: a minting bug misassigns real property title, not just drains a pool. $30k–$150k ACV.
- FinTech **primary focus Q2 2026 is WealthTech** (RWA/STO) — $20k–$250k, 60–90 day. AI+tokenization emerging search trend; inbound content at intersection outperforms 3 months of LinkedIn outbound.
- **Compliance Carol** (FinTech CCO) is a **regulatory veto-holder, not economic buyer**. Surface by call 1: *"Who handles vendor risk approval?"* Vendor risk pack Day 1 (ownership, ISO/SOC 2, data residency, MiCA brief, sample audit) unblocks most approvals within 1 week.
- **ExchangeTech qualification: architecture irrelevant** — CEX, DEX, DeFi all qualify in FinTech ICP Segment 1 if (a) licensed or license filed AND (b) expanding existing FinTech business. Don't DQ DEX/DeFi on architecture alone.
- **Two motions, never mix them in one outreach**: Security Audit (pre-mainnet review) vs. Development/Engineering (build/extend). Different buyers, ACVs, cycles.
- **AI-generated smart contract risk** (Pain Point 5, rising) — Cursor/Copilot miss reentrancy edge cases, access control, integer arithmetic. Positioning: human audit layer for AI-generated code. Content hook: "what AI coding tools get wrong in Solidity."
- **Channel Partner P3 (Crypto GTM Advisor)** motivator differs from P1/P2: **personal reputation protection on a single token launch**, not recurring implementation revenue. One vesting contract failure ends the career.
- **NCNDA Day 1** is the #1 trust barrier for all 3 advisory personas. The "800+ projects delivered" proof can **backfire** — counter: *"InnBlockchain has no direct sales motion for these markets; partner model is permanent."*
- **Budget Routing Rule**: sub-$20k crypto-native end-clients → [[InnBlockchain Crypto Products ICP]] (Trioangle clone scripts $5k–$20k, 5–15 days). **P2 FinTech exception**: clone scripts are crypto-native only, NOT for regulated FinTechs — scope smaller or park.
- **Re-engagement path**: clone script → validation → custom build. Partners check in at 60/90 days; re-introduce InnBlockchain when client hits feature limits, closes funding, or needs regulatory licensing. Partner owns the whole journey.
- **Burned Crypto Builder** (Crypto Products Persona 5) is **highest-urgency archetype** — second-attempt buyers with validated market + capital + forensic vendor evaluation. Close faster than first-timers. Framing: *"on-chain addresses to verify before you commit a dollar."*
- **Exploit-reactive outreach trigger (P1/P3 channel)**: outreach within 48h of major DeFi exploits. Monitor Rekt News + DeFi Llama.
- **EU AI Act + FinTech**: creates blockchain-alongside-AI opportunity (tamper-proof on-chain audit trail for high-risk AI: credit scoring, fraud detection, KYC). Not blockchain-instead-of-AI.
- **India-based agencies excluded** from Channel Partner ICP — peer/competitor perception prevents trust (carried over from Trioangle pattern).
- All 4 InnBlockchain ICPs are **assumption-based / validation-pending**. Ranges and severities are hypotheses.

## Key Recent Facts (Ingest: InnBlockchain Content Strategies)
- **Three parallel content programs** mapped 1:1 to [[InnBlockchain Crypto Native ICP]], [[InnBlockchain FinTech ICP]], [[InnBlockchain Crypto Products ICP]]. Channel Partner ICP has NO dedicated content strategy — partner recruitment messaging lives inside the other three programs.
- **Crypto Native CS**: 5 pillars (C1 Smart Contract Security, C2 Protocol Architecture, C3 ZK/MPC, C4 Engineering Velocity, **C5 MiCA — cross-cutting**) × 10 verticals × 51 scored articles. **Phase 1 is strictly sequential**: 18 RWA + MiCA articles publish fully before Phase 2 unlocks any of V2/V3/V4/V5/V6 content — ~4-5 months locked on one vertical. Top-scored: RWA Hub 9.7, MiCA for RWA 9.6, MiCA for Technical Founders 9.5, RWA 101 plain-language 9.4.
- **RWA Felix persona** is the one tone departure in Crypto Native CS: asset owner (real estate, commodities, vehicles, art), non-technical, cannot read Solidity. Content is plain-language, asset-first, compliance-aware — NOT exploit-thread. All other Crypto Native personas (Founding Felix, Product Paulo, Security Sasha) get deeply technical exploit depth.
- **FinTech CS**: 4 pillars (T1-T4) × 8 use-case clusters × 40+ scored articles. Primary Q2 2026 = **WealthTech ⭐ (RWA/STO/tokenized securities)**. Top Active: Asset Tokenization Guide 9.3, RWA Hub 9.2, Regulated Exchange 9.1, RWA Tech Stack 9.0.
- **FinTech channel priority is LinkedIn ABM → Partner/Referral → Events** (Money20/20 Europe, Sibos Europe). FinTech Connect London = Watch (UK gate not met). Every article repurposes as LinkedIn carousel (7-10 slides) with Sales Navigator EU geography targeting.
- **EU compliance content (MiCA, MiFID II, DORA, EU AI Act, DLT Pilot Regime) publishes in Active phase regardless of cluster** — never deferred to Watch RegTech. It is EU compliance infrastructure, not RegTech-vertical content.
- **ExchangeTech qualification (FinTech)**: architecture irrelevant. CEX, DEX, DeFi all qualify equally if (a) licensed or license filed AND (b) expanding existing FinTech business. Do NOT DQ DEX/DeFi on architecture alone.
- **WalletTech (FinTech) is regulated e-money wallet operators ONLY**. Crypto-native self-custody wallet startups are hard DQ (route to Crypto Native).
- **Crypto Products CS**: 4 verticals (CEX/P2P/DEX/NFT, mapped 1:1 to Trioangle clone script product lines) × 5 pillars × 40 articles. **Security Hub (#1 Are Crypto Clone Scripts Safe?) publishes first as universal trust foundation** — every subsequent article links back. First 12 posts locked. Top scored: Security Hub 9.2, Crypto Exchange in [Country] 9.0, Binance Clone Guide 8.9.
- **Crypto Products priority markets**: North America, UK, EU, Middle East (high-intent, regulatory clarity). Secondary: SEA, Eastern Europe, LatAm, West Africa. Diaspora founders in NYC/London/Dubai/Toronto building for home markets = priority buyers.
- **AI Search (ChatGPT/Perplexity/Gemini) is the new TOFU** for priority market crypto buyers — they query AI before Google. Content must be citation-structured (clear headings, direct answers, structured data). Citation tracking is manual monthly query harness until Semrush/BrightEdge AI visibility tools mature.
- **Persona 2 Diaspora Fintech Builder** is peer-driven: Facebook diaspora groups + WhatsApp communities are primary discovery channels, NOT search or Twitter. Must seed content there alongside SEO.
- **Persona 3 Web3 Protocol Architect** reads GitHub commits and verifies on-chain addresses. Technical precision required — vague marketing language destroys credibility instantly. Blog alone does NOT convert; sales must offer NDA code access + third-party audit report + on-chain TVL proof.
- **Tone rule (Crypto Products)**: never write "easy" or "simple" about smart contract security. Every claim needs verifiable proof.
- **Cross-ICP SEO differentiation protocol**: every topic that exists in both Crypto Native and FinTech strategies carries inline disambiguation on both sides. Overlapping topics + rules:
  - RWA: Crypto Native = smart contract architecture, oracle design, ERC-3643, MiCA for platform builders. FinTech = liquidity, T+0, MiFID II classification, institutional investors.
  - Upgrade patterns: Crypto Native = exploit vectors. FinTech = governance, auditability, regulatory liability.
  - Audit checklists: Crypto Native = exploit-pattern testing. FinTech = compliance auditability, regulator sign-off.
  - Travel rule: Crypto Native = DeFi protocol smart contract impl. FinTech = licensed CASP on-chain AML tooling.
  - Account abstraction / passkeys / embedded wallets: Crypto Native = self-custody wallet primitives. FinTech = friction reduction for licensed wallet operators.
  - Hiring: Crypto Native = reentrancy auditing, ZK circuits. FinTech = compliance-aware engineers, audit trails, KYC/AML.
- **Routing gate (unchanged, now embedded in content strategies)**: company origin, not licensing. Every overlapping vertical (DEX, Lending, Wallets, RWA) carries explicit routing clauses. Licensed crypto-native DEX = Crypto Native. Licensed incumbent adding crypto = FinTech.
- **AI-code audit overlay (V10 Crypto Native)** activates immediately on any active segment deal — no gate, no segment dependency. One exception to Phase 1 lock.
- **Compliance Carol (FinTech CCO)** addressed via content but is a veto-holder not a buyer — attribution methodology for compliance content is undefined.
- **Risk flagged**: no shared keyword/topic ledger between Crypto Native and FinTech strategies. Disambiguation is prose per-article, not a central registry. First cross-ICP publishing conflict is the risk surface.
- **Competitive framing (FinTech)**: never name competitors. Angles: vs Accenture/Deloitte = speed + FinTech specialisation; vs Kaleido/SettleMint/Fireblocks = custom logic beats 80% platform; vs Trail of Bits/Zellic = FinTech compliance context; vs in-house = time-to-start + IP transfer.
- **Crypto Products competitor benchmarks**: B2Broker, AlphaPoint, Shift Markets, Hayvn, Rain (MENA). Comparison content is a designated pillar, not an afterthought. Dedicated silo: `/blog/trioangle-vs-*/`.
- **Budget floors**: Crypto Native $20k+ (non-RWA) / $30k+ (RWA). FinTech $25k+. Crypto Products $5k-$25k (clone script line).

## Previous

## Key Recent Facts (Ingest: Content Strategy files — Trioangle)
- Product blog: 10 silos, 5 pillars, 20 article templates (T1-T20) + 8 lead magnets. TikTok clone (PopTok) has active inbound NOW — build BOFU (demo, comparison, case study) before completing awareness funnel.
- Service blog: 81 articles, 6 verticals, 3x/week cadence. CTA is strictly persona-gated. Highest-priority article: #14 CTO Checklist (score 9.5). Top quick win: #36 Build vs Buy 2026 (9.3) bridges BOTH ICPs.
- MENA CTA rule (service blog, Cluster 6): NEVER form-based CTAs. Always LinkedIn DM or WhatsApp. No exceptions in any MENA article. Tone must be relationship-first, never transactional.
- Article #79 (Salvage Failed Dev Partnership): Empathy-first CTA only — "free 45-min architecture review, no pitch." Never use discovery call CTA here.
- WatchIt (YouTube-style long-video clone) is NOT an active product — never reference it anywhere. Short-video = PopTok only.
- Budget overlap zone $30k-$40k: default to Founder-CTO motion (fit call) unless confirmed post-Series A context.
- T18 template: "Clone Script vs AI Builders (Cursor, Lovable): Why Prompting Isn't a Product" — directly answers the vibe coding objection and captures Persona 6 intent.
- Variable rule: [ORIGINAL] (Uber, TikTok) in article titles; [BRAND] (Gofer, PopTok) only in CTAs and post-purchase content.

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
