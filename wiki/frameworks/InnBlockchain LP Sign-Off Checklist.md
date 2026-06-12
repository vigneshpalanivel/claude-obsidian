---
company:
  - innblockchain
department:
  - marketing
priority: high
rev: 1
last_revised: 2026-06-03
parent_extraction_source: "[[InnBlockchain - Phase 1 Execution Playbook]] rev 26 § WS1 § Vignesh Pre-Launch LP Sign-Off Checklist"
scope: cross-phase
applies_to:
  - phase-1
  - phase-2
  - phase-3
tags:
  - framework
  - landing-pages
  - vignesh
  - sign-off
  - cross-phase
---

# Vignesh Pre-Launch LP Sign-Off Checklist

> [!IMPORTANT] Single regulatory authority on the LP surface · cross-phase framework
> Every LP (Phase 1 Gate 1 + Gate 2 · Phase 2 destinations · any future LP) gets a Vignesh regulatory sign-off before launch. LPs are the **#1 Carol disqualifier surface** alongside DM templates. Build-phase hero + About reviews catch ~10% of the LP surface — this checklist covers the other 90%. **48-hr SLA same as article pre-publish review.**
>
> Extracted from [[InnBlockchain - Phase 1 Execution Playbook]] rev 26 → cross-phase framework (rev 27). Phase 1 fires this checklist for Gate 1 + Gate 2 + eIDAS gated PDF; Phase 2 will fire for new destination LPs.

## When this fires (per LP — before launch)

- [ ] **(Vignesh)** Phase 1 — Gate 1 (`/solutions/rwa-tokenization`) before EOD W3 launch
- [ ] **(Vignesh)** Phase 1 — Gate 2 (`/solutions/tokenization`) before EOD W3 launch
- [ ] **(Vignesh)** Phase 1 — eIDAS gated PDF page (`/eidas-brief` per Playbook WS10) before W13 eIDAS Outbound Test
- [ ] **(Vignesh)** Phase 2 / future — Any new destination LP before publish

## Pre-launch regulatory gates (Vignesh executes per LP · 48-hr SLA)

- [ ] **(Vignesh)** **Full LP body regulatory framing** — read every paragraph, not just hero. No regime leaks · regime correctly named per [[EU-Compliance-Landscape]] canonical map · no compliance-officer-confusing language (e.g., RWA token framed as MiCA crypto-asset for Phase 1 LPs)
- [ ] **(Vignesh)** **FAQPage JSON-LD copy review** — AEO citation surface; Perplexity / ChatGPT / Gemini will quote these answers verbatim to vendor-research queries. Same regime-leak risk as article body. Verify all Q&A pairs match the canonical regime map. Date-stamp regulatory references (AEO Principle 8).
- [ ] **(Vignesh + Dev verification)** **CTA copy + destination targeting** — primary CTA + secondary CTA both point to the correct destination per [[InnBlockchain - Landing Pages Plan]]. **No CTA points to a non-existent LP** (broken-CTA-to-future-phase-LP = Carol-killing trust drop).
- [ ] **(Vignesh)** **Email-capture trigger + delivery workflow text** — auto-reply email body + SLA promise ("We'll send your [asset] within 24 hr") regulatory framing reviewed + deliverability tested end-to-end (form submit → CRM lead record created → trigger fires → email lands in inbox, not spam)
- [ ] **(Vignesh)** **Asset-download workflow text** — Asset itself signed off separately; this is the *delivery message* layer that's often overlooked
- [ ] **(Dev reports · Vignesh confirms before sign-off)** **Verified-live check** — LP not 404 · all 301 redirects working · sitemap.xml entry present · FAQPage JSON-LD validates per Schema.org validator · GA4 events firing for page-view + CTA-click + form-submit (test from incognito session)
- [ ] **(Vignesh)** **Cross-doc consistency check** — no claims contradict [[LinkedIn Profile Vignesh Content]] Pre-Publish Hard Gate. No claims contradict [[InnBlockchain - Content Strategy]] § sales motion tagging for the destination LP.
- [ ] **(Vignesh)** **Sign-off logged** before launch — note in CRM or LP version-control log: `Vignesh pre-launch sign-off [date], LP [name], regulatory framing verified against [EU-Compliance-Landscape] rev [N], FAQPage JSON-LD reviewed, CTA destinations verified, email-capture workflow tested end-to-end.` Logging is non-optional — if it's not logged, it didn't happen and the launch is blocked.

## Escalation rules

- [ ] **(Dev → Vignesh same day)** If Dev can't ship on the date Vignesh sign-off is needed (sign-off cycle = 48 hr) → flag P0 same day for slip-vs-scope-compress decision
- [ ] **(Vignesh blocks launch)** If Vignesh finds regulatory leak during pre-launch review → block launch · Dev fixes · re-sign-off · only then publish. **Never publish "fix it after launch"** — LP is the AEO citation surface; once Perplexity / ChatGPT cite the leaked version it propagates faster than the fix.
- [ ] **(Vignesh)** If Vignesh travel collides with launch window → block out launch day in calendar 1 wk ahead OR delay launch (Vignesh is the only sign-off authority in Phase 1 self-review model; revisit for Phase 2 if compliance reviewer hired)

## Post-launch verification (Vignesh + MPs · within 48 hr of launch · doesn't block launch but catches drift)

- [ ] **(MPs run probe · Vignesh reviews results)** AEO citation probe per [[InnBlockchain - Landing Pages AEO GEO Prompts]] § Monthly AI Search Citation Probe — does Perplexity / ChatGPT now cite the LP for vendor-evaluation queries within 48 hr? (Indexing lag is normal; 48-hr check confirms LP is reachable)
- [ ] **(MPs)** GA4 event firing confirmation across first 50 page-views · first 10 form-submits (catches schema drift between Dev event spec + actual fire)
- [ ] **(MPs · external email test)** Email-capture workflow operational confirmation — submit test form from a Gmail / Outlook account NOT in InnBlockchain domain · confirm email lands within SLA · not in spam folder

## Why this is a separate doc

LP regulatory framing review is cross-phase. Phase 1 fires this checklist for 3 LPs; Phase 2 will fire it for new destination LPs (currently MiCA CASP `/solutions/regulated-exchange` deferred per Playbook). Extracting the framework prevents drift between phase-specific playbook copies.
