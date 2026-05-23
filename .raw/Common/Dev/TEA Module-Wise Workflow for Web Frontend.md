---
title: "TEA Module-Wise Workflow for Large Web Frontend Apps"
author: Vignesh
created: 2026-05-22
updated: 2026-05-23
description: End-to-end task list for running BMad TEA on a brownfield web frontend app with 30+ modules, no epics, no stories.
tags:
  - bmad
  - tea
  - testing
  - workflow
  - web-frontend
  - brownfield
---

# TEA Module-Wise Workflow for Large Web Frontend Apps

End-to-end task list for running BMad TEA (`document-project` → `test-design` → `automate`) on a brownfield web frontend app with 30+ modules, no epics, no stories — just code.

> *Scope: web frontends only (React, Vue, Svelte, Angular, vanilla JS, etc.). For React Native, Flutter, or native mobile, the tier strategy applies but tooling (Playwright, Vitest, browser exploration) and the knowledge skill must be swapped — author a separate workflow for those stacks.*

## Critical Pre-Decision: Tier the Modules

> *"Module" here means a feature area / business domain (auth, checkout, orders) — a way to split the codebase by user-facing functionality. It is **not** a framework-specific construct (Angular NgModule, ES module, Python module, etc.).*

Do not run test-design + automate on all 30 modules equally. That's 60-120 hours of work, most of it wasted on low-traffic modules, and the result is a 1500-test suite with high flake rate that gets ignored within a month.

Tier first:

| Tier | Module count | Test layers | Examples |
|---|---|---|---|
| **Tier 1 (P0)** | 4-6 | E2E + API + Component + Visual (critical pages) | Auth, payments, core data flows, anything touching money/PII |
| **Tier 2 (P1)** | 8-12 | Component (primary) + API + light E2E + selective Visual | High-traffic user-facing flows |
| **Tier 3 (P2)** | 10-15 | Component (primary) + one smoke E2E. Skip Visual | Internal/admin/settings |
| **Tier 4 (P3)** | Remainder | Single smoke E2E. Skip everything else | Rarely-used or trivial routes |

Two things to internalize before starting:

- **Component tests carry most of the weight on a frontend app.** They're 10-100x faster than E2E, deterministic, and catch most logic bugs. E2E should cover only true cross-component user journeys. If your plan is mostly E2E, the pyramid is upside-down.
- **Visual regression has the highest false-positive rate of any test type** — font tweaks, antialiasing, dynamic content, and OS-level rendering differences trigger noise. Apply only where the visual *is* the product (marketing pages, design system, brand-critical flows). Skip for internal/admin UI.

---

## Pre-flight (do once)

1. Verify `_bmad/` and `_bmad/tea/config.yaml` exist. Run BMad installer with TEA module if not.
2. Confirm `npm run dev` works and note the dev server URL.
3. Edit `_bmad/tea/config.yaml`:
   ```yaml
   tea_browser_automation: auto       # critical for UI app
   tea_execution_mode: auto
   tea_capability_probe: true
   tea_use_playwright_utils: true     # if Playwright
   output_folder: docs/qa             # or your preference — pick one and stick
   ```
4. **E2E + API runner: Playwright.** This workflow is framework-agnostic — it works for React, Vue, Svelte, Angular, or any web frontend. Coding patterns for the generated test code come from a framework-specific knowledge skill (one per stack). Available today: `bmad-react-test-kb`. For other stacks, author a comparable skill or write patterns inline.
5. Decide **component test runner**: **Vitest** (framework-agnostic) + `@testing-library/<your-framework>` (e.g. `@testing-library/react`, `@testing-library/vue`, `@testing-library/svelte`) is the modern default. Jest + Testing Library if you're already on it. Don't add a second runner if one is already set up — pick what's there and move on.
6. Decide **visual regression tool**:
   - **Playwright built-in `toHaveScreenshot()`** — zero extra tooling, snapshots committed to repo. Best default unless you need cloud diff review.
   - **Percy** or **Chromatic** — cloud-hosted diffs with reviewer UI. Worth it only if non-engineers review visual changes or you need cross-browser/device baselines.
   - **Skip entirely** — valid choice for internal-only apps where visuals aren't the product. Don't add visual regression for the sake of having it.

## One-time codebase scan & infra setup

7. **Run `/bmad:document-project` with `deep` scan.** Once, whole codebase. Output lands in `output_folder`.
8. **Review the `document-project` output** for accuracy, then create `docs/frontend-notes.md` for the three things the scanner can't know on its own:
   - **Auth credentials & flow** — login URL, test username/password (or env var), session/cookie pattern, auth-gated route prefix. Without this, exploratory mode only sees public routes.
   - **Corrections to the scanner output** — missed routes (e.g. lazy-loaded), wrong component groupings, hallucinated relationships. Don't redocument what it got right; just note overrides.
   - **Module tiers** (added in step 10 — same file).

   Skip anything `document-project` already covered well: directory structure, component tree, declared routes, dependencies, state management library, API surface.
9. **Run `/bmad:tea:framework`** once. Scaffolds Playwright E2E + API infra at the repo root. Don't repeat per module — all modules share the same `tests/` tree. Configure component test runner (Vitest config) and visual regression baselines (snapshot dir or Percy/Chromatic project) in the same pass.

## Module inventory

10. **List all 30+ modules** in `docs/frontend-notes.md` with tier, owner, and one-line description:
    ```markdown
    ## Modules

    ### Tier 1 (P0 — full coverage)
    - **auth**       — login/signup/password reset. Routes: /login, /signup, /reset
    - **checkout**   — cart → payment → confirmation. Routes: /cart, /checkout
    - **payments**   — Stripe integration, refunds. Routes: /payments/*

    ### Tier 2 (P1 — component + API + light E2E)
    - **orders**     — order history, tracking. Routes: /orders, /orders/:id
    - **profile**    — user settings. Routes: /profile/*
    - ...

    ### Tier 3 (P2 — component + smoke E2E)
    - ...

    ### Tier 4 (P3 — smoke only)
    - ...
    ```
    This list is the spine of everything that follows and doubles as your tracking checklist.

11. **Define output naming convention** so 30 modules' worth of tests and plans don't collide:
    ```
    docs/qa/
      test-design-architecture.md
      modules/
        auth/test-design-auth.md
        auth/test-design-qa-auth.md
        checkout/test-design-checkout.md
        ...
    tests/
      e2e/auth/
      e2e/checkout/
      api/auth/
      api/checkout/
      component/auth/
      component/checkout/
      visual/auth/             # only for tiers that use visual regression
      visual/checkout/
      ...
    ```
    Mirror in `_bmad/tea/config.yaml` if it supports per-module output paths; otherwise rename outputs manually after each run.

## Per-module loop (repeat for Tier 1 → 2 → 3)

For each module, in tier order:

12. **Append a per-module risk/scope appendix to `docs/frontend-notes.md`.** Just the things `document-project` can't infer.

    **Always include** (the two things nothing else captures):
    - `Risk hotspots:` — failure modes that matter for this module
    - `Out of scope:` — what test-design should not plan for

    **Only include when deviating from the tier default** (see tier table). Skip these lines entirely if the module follows its tier's default layer mix:
    - `Component focus:` — only if specific components need explicit attention beyond what test-design would infer
    - `Visual coverage:` — only if you're skipping visual on a Tier 1 module or adding it to a Tier 2/3 module

    **Default case (80% of modules) — two lines only:**
    ```markdown
    ### orders (Tier 2)
    **Risk hotspots:** status sync lag with fulfillment service; refund race condition on partial refunds
    **Out of scope:** order export to CSV (separate module)
    ```

    **Exception case — call out the deviation explicitly:**
    ```markdown
    ### admin-settings (Tier 1 — exception)
    **Risk hotspots:** permission boundary bypass; settings cache invalidation
    **Out of scope:** SSO configuration UI
    **Visual coverage:** SKIP — internal admin tool, pixel-exact rendering doesn't matter
    ```

    Don't restate routes, components, or "what it does" — that's already in the `document-project` output.

13. **Start dev server** (if not already running) — exploratory mode needs it live.

14. **Run `/bmad:tea:test-design`** for this module. When prompted, point it at the module's `document-project` output (for structure) and the relevant section of `frontend-notes.md` (for risk + scope). Output: `test-design-<module>.md` in the module's folder, with cases split by layer (E2E / API / Component / Visual).

15. **Review and edit the plan** (15-30 min per module). Delete hallucinated cases, add missed ones, fix P-tier assignments, rebalance layer split (push cases down the pyramid — most logic should be component, not E2E). Don't skip — unedited plans produce slop test suites.

16. **Run `/bmad:tea:automate`** for this module. Point it at the reviewed plan. Output:
    - E2E + API tests in `tests/e2e/<module>/` and `tests/api/<module>/` — generated automatically
    - Component tests in `tests/component/<module>/` — `automate` may scaffold these if your config has the component runner wired; otherwise generate via a second `automate` pass scoped to component layer, or write by hand using the plan as a checklist
    - Visual tests in `tests/visual/<module>/` — usually hand-written (5-15 lines each) since they're just `await expect(page).toHaveScreenshot()` calls at key states

17. **Run all new tests locally.** Confirm they pass — and for visual tests, confirm the baseline snapshots look right (first run creates them; subsequent runs compare). Investigate flakes immediately — don't let them pile up.

18. **Commit per module.** One git commit per completed module makes review and rollback sane. Naming: `test(<module>): add automated tests via TEA`.

19. **Update the module checklist** in `docs/frontend-notes.md` — mark done with date and case count per layer (e.g., `auth: 8 E2E, 12 API, 24 component, 4 visual`).

## Periodic checkpoints (every 5-10 modules)

20. **Run `/bmad:tea:trace`** to see overall coverage trend. Confirm Tier 1 hits P0 ≥ 100% and Tier 2 hits P1 ≥ 90%. If not, fix gaps before moving to the next tier.
21. **Run `/bmad:tea:test-review`** on a sample of completed modules (every 5 or so). Catches quality drift early — flake rate, weak assertions, redundant cases. Score should stay ≥ 80. Visual snapshot tests are exempt from "weak assertion" scoring; they have only one assertion by design.

## When you finish each tier

- **Tier 1 done:** Most critical surface covered. App is shippable with confidence. Pause and reassess Tier 2 — often Tier 1 already exercises much of Tier 2's code paths. Re-run `trace` before continuing.
- **Tier 2 done:** Likely the right stopping point for most teams. Tier 3 has diminishing returns vs. maintenance cost.
- **Tier 3 done:** You're in over-tested territory. Stop unless compliance forces it.
- **Tier 4:** Single smoke spec ("does the route load") manually written, not via `automate`. TEA overhead per module isn't worth it for P3.

## Realistic time estimate

- Pre-flight + infra (steps 1-9): half a day to a full day (extra time if setting up component runner + visual regression for the first time)
- Module inventory + tiering (steps 10-11): 2-4 hours
- Per Tier 1 module: **4-6 hours** end-to-end (was 3-4 — component + visual layers add ~1-2 hours)
- Per Tier 2 module: **3-4 hours**
- Per Tier 3 module: 1-2 hours

For 4 Tier 1 + 10 Tier 2 + 12 Tier 3 modules: **~80-110 hours total**. Plan 3-4 weeks of focused work, not a sprint task.

## Three things that will bite you

- **Shared components/hooks across modules.** If `<DataTable />` is used in 15 modules, don't write 15 sets of redundant tests for its behavior. Test it once at the component level and let module tests assume it works. Create a `tests/component/shared/` folder for these. `test-design` won't know which components are shared — call it out in the per-module appendix.
- **Module boundaries ≠ feature boundaries.** "Modules" usually means directories, but users experience features that cross modules. Checkout *feature* touches cart, payments, orders, and notifications *modules*. Plan E2E by user journey, not module — per-module split is for API + component tests. Add a `tests/e2e/journeys/` folder for cross-module flows.
- **Visual regression snapshot drift.** First run creates baselines; every subsequent UI change requires either a real-bug fix or an explicit baseline update. Without discipline this devolves into "just regenerate all snapshots" on every PR, which makes the layer worthless. Enforce: visual diffs require a screenshot in the PR description showing intentional change. If non-engineers should approve, use Percy/Chromatic instead of file-based snapshots.

## End state

- `docs/qa/` with per-module plans and a global checklist
- `tests/e2e/<module>/`, `tests/api/<module>/`, `tests/component/<module>/`, `tests/visual/<module>/` mirroring module structure
- `tests/component/shared/` for cross-module components
- `tests/e2e/journeys/` for cross-module user flows
- A `trace` report showing coverage by tier and layer
- A maintainable suite — not a 1500-test slop pile
