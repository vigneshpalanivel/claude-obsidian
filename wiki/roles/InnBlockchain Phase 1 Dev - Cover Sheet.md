---
company:
 - innblockchain
department:
 - marketing
role: Dev
priority: high
rev: 3
last_revised: 2026-06-03
playbook_rev_synced: 34
parent: "[[Execution Playbook]]"
tags:
 - role
 - dev
 - cover-sheet
 - phase-1
---

# 🛠️ Dev — Phase 1 Cover Sheet

> **What this is:** Your slice of [[Execution Playbook]] for daily/weekly use. Task detail + cross-role context live in the parent playbook — open the `[[#anchor]]` links to drill in. ~30 task touchpoints across 4 workstreams.

---

## 🎯 What you own (top-level)

LP Gates 1 + 2 build (**CRITICAL PATH** — single point of failure for Speed Mode) · email-capture form integration · GA4 + UTM wiring · 301 redirect implementation · sitemap + Search Console submission · **academy blog technical SEO setup** (WordPress schema · sitemap · plugin · author pages) · LP hero image integration coordinated with MPs + Designer.

## 🗺️ Workstreams you touch

| WS | Role | Anchor |
|---|---|---|
| **WS1 — LP Delivery** | **PRIMARY · CRITICAL PATH** — build LP Gates 1 + 2 by **EOD W3** (5-day sprint). Slip = structured DMs slip W5 → W6 | [[Execution Playbook#WS1 — Landing Page Delivery (CRITICAL PATH)]] |
| **WS2 — SEO / AEO / GEO** | **Academy blog technical SEO setup** (W1–W2, one-time): `/academy` in sitemap + Search Console · WordPress SEO plugin · Article/BlogPosting schema · canonicals · author E-E-A-T pages · Core Web Vitals baseline | [[Execution Playbook#Academy blog technical SEO — one-time setup (Dev · by W1–W2, before articles publish)]] |
| **WS5 — Platform Setup** | Wire **two GA4 properties** (A: Site+LP · B: Academy) + **academy→LP UTM bridge** (WordPress filter auto-appending `utm_source=academy` on internal links) · email-capture integration with CRM (auto-create lead + trigger delivery within 24 hr) | [[Execution Playbook#Analytics + lead-capture infrastructure (funnel math depends on these)]] |
| **WS3 — Profile + LP assets** | Integrate Designer's LP hero images into LP code as they're produced (per WS15 Track A asset map) | [[Execution Playbook#X (Twitter) — initial setup (one-time, W1)]] *(adjacent — Dev integrates X-bio link)* |
| **WS10 — eIDAS Outbound Test** | Build the gated PDF landing page (`innblockchain.com/eidas-brief`) for eIDAS test — one-time, W11–W12 | [[Execution Playbook#WS10 — eIDAS Outbound Test (W13 mid-point, limited scope)]] |

## 📅 Timeline that affects you

| Week | What you ship |
|---|---|
| **W1 Day 1** | Kick off LP Gates 1 + 2 sprint |
| **W1–W2** | Academy blog technical SEO setup (before article publish volume ramps) |
| **EOD W3** | LP Gates 1 + 2 live — both verified not 404 |
| **EOD W3** | Email-capture form integration with CRM operational |
| **EOD W3** | GA4 + UTM events firing for both LPs |
| **W3 onwards** | LP citation health checks coordinated with MPs (monthly) |
| **W11–W12** | eIDAS gated PDF landing page built |
| **Ongoing** | LP hero images integrated when MPs/Designer hand off |

## 📚 Read first (in this order)

1. [[Execution Playbook#WS1 — Landing Page Delivery (CRITICAL PATH)]] — your primary section (~30 tasks)
2. [[Execution Playbook#Analytics + lead-capture infrastructure (funnel math depends on these)]] — your WS5 GA4 + email-capture contribution
3. [[Execution Playbook#WS10 — eIDAS Outbound Test (W13 mid-point, limited scope)]] § Pre-test assets — single eIDAS gated PDF page task
4. [[InnBlockchain - Landing Pages Plan]] — canonical LP IA + content spec
5. [[InnBlockchain - Landing Pages AEO GEO Prompts]] — per-LP SEO drafting principles (MPs lead, you implement)

## 🚫 Hard rules (memorise — these never relax)

- **LP Gates 1 + 2 shipping date is the single point of failure for Speed Mode.** If you can't commit to EOD W3, escalate to Vignesh as P0 same day so the team can plan structured DMs at the slipped date.
- **301 redirects are not optional.** Every retired URL in [[InnBlockchain - Landing Pages Plan]] § Existing Pages Migration Map must redirect, or SEO equity dies.
- **Hero copy regulatory framing comes from Vignesh, not you.** Do not let dev-time copy decisions leak MiCA framing into RWA-focused LPs (MiCA Art. 2(4) exclusion is the #1 Carol disqualifier).
- **FAQPage JSON-LD is mandatory on every LP.** AEO citation depends on it.
- **No new analytics events without GA4 schema review** — drift breaks the per-format CTR tracking in WS12.
- **The academy→LP UTM bridge is not optional** — with two separate GA4 properties, it's the only thing that attributes LP visits/conversions back to academy articles. If it's missing, academy content ROI is invisible.

## ☎️ Backup / escalation

- LP slip risk → **Vignesh** same day; he co-decides scope-compress vs slip-date
- GA4 / email-capture integration blockers → **MPs** (your day-to-day liaison — they own the configuration choices)
- Hero image hand-off blocked → **Designer** (via MPs for coordination)
- Anything regulatory → **Vignesh** (never make a regulatory judgment call yourself)

## 📂 Necessary documents to execute Phase 1 (your full doc bundle)

These are everything you need to do your job — share/bookmark all 6:

| # | Document | What it's for |
|---|---|---|
| 1 | [[Execution Playbook]] | Master ops doc — WS1 (your section) + WS5 + WS10 |
| 2 | [[Dev - Cover Sheet]] | This doc — your daily/weekly reference |
| 3 | **[[InnBlockchain - LP Sign-Off Checklist]]** (cross-phase framework) | The 8 gates Vignesh signs off on per LP before you launch — you provide the verified-live check (item 6) |
| 4 | [[InnBlockchain - Landing Pages Plan]] | Canonical LP IA + content spec + migration map (301 redirects) |
| 5 | [[InnBlockchain - Landing Pages AEO GEO Prompts]] | 13 AEO Drafting Principles for LP body copy (MPs lead drafting; you implement) |
| 6 | [[EU-Compliance-Landscape]] | Regulatory framing reference — when Vignesh flags MiCA-on-RWA leak in hero copy, this is the canonical map |

## ❌ What you DON'T own (redirect if asked)

- LP copy drafting → **MPs** (with Vignesh review for regulatory framing)
- LP on-page SEO + monthly citation probes → **MPs**
- LP hero image design → **Designer** (you integrate; don't design)
- CRM / Sales Nav / outreach tooling → **SP**
- Newsletter platform decision → **MPs + Vignesh** (W10 revisit)

---

> Cover sheet derived from [[Execution Playbook]]. When playbook revs, check this sheet for anchor changes; content updates propagate via links — no copy required.
