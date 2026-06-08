---
company:
  - innblockchain
department:
  - marketing
role: Dev
priority: high
rev: 2
last_revised: 2026-06-03
playbook_rev_synced: 22
parent: "[[InnBlockchain - Phase 1 Execution Playbook]]"
revision_notes: |
  rev 2 (2026-06-03): sync to Playbook rev 20 — Dev scope unaffected by rev 20 changes (X Company addition + Cross-channel cannibalisation matrix touch MPs + WS3/WS8, not WS1 LP delivery). Rev bump for cover-sheet-cohort consistency only.
  rev 1 (2026-06-03): initial cover sheet — pilot draft for Option B (lightweight per-role cover sheets). One slice of [[InnBlockchain - Phase 1 Execution Playbook]] rev 19 for daily/weekly Dev-role use. Content is not duplicated from the playbook — anchor links route Dev into their workstream sections for task detail. Sync rule: when playbook revs, only re-touch this sheet if heading anchors change OR Dev ownership scope changes.
tags:
  - role
  - dev
  - cover-sheet
  - phase-1
---

# 🛠️ Dev — Phase 1 Cover Sheet

> **What this is:** Your slice of [[InnBlockchain - Phase 1 Execution Playbook]] (rev 19) for daily/weekly use. Task detail + cross-role context live in the parent playbook — open the `[[#anchor]]` links to drill in. ~30 task touchpoints across 4 workstreams.

---

## 🎯 What you own (top-level)

LP Gates 1 + 2 build (**CRITICAL PATH** — single point of failure for Speed Mode) · email-capture form integration · GA4 + UTM wiring · 301 redirect implementation · sitemap + Search Console submission · LP hero image integration coordinated with MPs + Designer.

## 🗺️ Workstreams you touch

| WS | Role | Anchor |
|---|---|---|
| **WS1 — LP Delivery** | **PRIMARY · CRITICAL PATH** — build LP Gates 1 + 2 by **EOD W3** (5-day sprint). Slip = structured DMs slip W5 → W6 | [[InnBlockchain - Phase 1 Execution Playbook#WS1 — Landing Page Delivery (CRITICAL PATH)]] |
| **WS5 — Platform Setup** | Coordinate with MPs on GA4 events + email-capture integration with CRM (auto-create lead record on form submit · trigger manual delivery workflow within 24 hr) | [[InnBlockchain - Phase 1 Execution Playbook#Analytics + lead-capture infrastructure (funnel math depends on these)]] |
| **WS3 — Profile + LP assets** | Integrate Designer's LP hero images into LP code as they're produced (per WS15 Track A asset map) | [[InnBlockchain - Phase 1 Execution Playbook#X (Twitter) — initial setup (one-time, W1)]] *(adjacent — Dev integrates X-bio link)* |
| **WS10 — eIDAS Outbound Test** | Build the gated PDF landing page (`innblockchain.com/eidas-brief`) for eIDAS test — one-time, W11–W12 | [[InnBlockchain - Phase 1 Execution Playbook#WS10 — eIDAS Outbound Test (W13 mid-point, limited scope)]] |

## 📅 Timeline that affects you

| Week | What you ship |
|---|---|
| **W1 Day 1** | Kick off LP Gates 1 + 2 sprint |
| **EOD W3** | LP Gates 1 + 2 live — both verified not 404 |
| **EOD W3** | Email-capture form integration with CRM operational |
| **EOD W3** | GA4 + UTM events firing for both LPs |
| **W3 onwards** | LP citation health checks coordinated with MPs (monthly) |
| **W11–W12** | eIDAS gated PDF landing page built |
| **Ongoing** | LP hero images integrated when MPs/Designer hand off |

## 📚 Read first (in this order)

1. [[InnBlockchain - Phase 1 Execution Playbook#WS1 — Landing Page Delivery (CRITICAL PATH)]] — your primary section (~30 tasks)
2. [[InnBlockchain - Phase 1 Execution Playbook#Analytics + lead-capture infrastructure (funnel math depends on these)]] — your WS5 GA4 + email-capture contribution
3. [[InnBlockchain - Phase 1 Execution Playbook#WS10 — eIDAS Outbound Test (W13 mid-point, limited scope)]] § Pre-test assets — single eIDAS gated PDF page task
4. [[InnBlockchain - Landing Pages Plan]] — canonical LP IA + content spec
5. [[InnBlockchain - Landing Pages AEO GEO Prompts]] — per-LP SEO drafting principles (MPs lead, you implement)

## 🚫 Hard rules (memorise — these never relax)

- **LP Gates 1 + 2 shipping date is the single point of failure for Speed Mode.** If you can't commit to EOD W3, escalate to Vignesh as P0 same day so the team can plan structured DMs at the slipped date.
- **301 redirects are not optional.** Every retired URL in [[InnBlockchain - Landing Pages Plan]] § Existing Pages Migration Map must redirect, or SEO equity dies.
- **Hero copy regulatory framing comes from Vignesh, not you.** Do not let dev-time copy decisions leak MiCA framing into RWA-focused LPs (MiCA Art. 2(4) exclusion is the #1 Carol disqualifier).
- **FAQPage JSON-LD is mandatory on every LP.** AEO citation depends on it.
- **No new analytics events without GA4 schema review** — drift breaks the per-format CTR tracking in WS12.

## ☎️ Backup / escalation

- LP slip risk → **Vignesh** same day; he co-decides scope-compress vs slip-date
- GA4 / email-capture integration blockers → **MPs** (your day-to-day liaison — they own the configuration choices)
- Hero image hand-off blocked → **Designer** (via MPs for coordination)
- Anything regulatory → **Vignesh** (never make a regulatory judgment call yourself)

## ❌ What you DON'T own (redirect if asked)

- LP copy drafting → **MPs** (with Vignesh review for regulatory framing)
- LP on-page SEO + monthly citation probes → **MPs**
- LP hero image design → **Designer** (you integrate; don't design)
- CRM / Sales Nav / outreach tooling → **SP**
- Newsletter platform decision → **MPs + Vignesh** (W10 revisit)

---

> Cover sheet derived from [[InnBlockchain - Phase 1 Execution Playbook]] rev 19. When playbook revs, check this sheet for anchor changes; content updates propagate via links — no copy required.
