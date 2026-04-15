---
type: concept
title: "Network-First Testing"
created: 2026-04-16
updated: 2026-04-16
tags:
  - concept
  - testing
  - tea
  - patterns
  - flakiness
status: current
related:
  - "[[Test Architect (TEA)]]"
  - "[[Fixture Architecture]]"
  - "[[TEA-Documentation]]"
sources:
  - "[[TEA-Documentation]]"
---

# Network-First Testing

TEA's solution to flaky end-to-end tests. **Core principle**: UI changes because APIs respond. Wait for the API response, not an arbitrary timeout.

## The Pattern: Intercept-Before-Navigate

Set up the network wait **before** the action that triggers it, then await the response before asserting.

```typescript
// ✅ Good
test('should load dashboard data', async ({ page }) => {
  const dashboardPromise = page.waitForResponse(
    (resp) => resp.url().includes('/api/dashboard') && resp.ok()
  );

  await page.goto('/dashboard');

  const response = await dashboardPromise;
  const data = await response.json();

  await expect(page.locator('.data-table')).toBeVisible();
  await expect(page.locator('.data-table tr')).toHaveCount(data.items.length);
});
```

Why it works:

1. Wait is armed **before** navigation (no race)
2. Waits for the **actual** API response (deterministic, no guesswork)
3. No fixed timeout (fast when the API is fast)
4. Validates the API response as a side benefit (catches backend errors)

## Anti-Patterns

### Hard Waits

```typescript
// ❌ Hope 2 seconds is enough
await page.waitForTimeout(2000);
```

Fails on slow networks. Wastes time on fast networks. CI environment is always different from local. Under load, wait escalates: 2s → 5s → 10s, suite runtime explodes, and it is still flaky.

### Navigate-Then-Wait Race

```typescript
// ❌ Race condition
await page.goto('/dashboard');
await expect(page.locator('.data-table')).toBeVisible();
```

The assertion fires before the API has responded. Sometimes it works, sometimes it doesn't.

## With Playwright Utils

`interceptNetworkCall` from `@seontechnologies/playwright-utils` is the canonical implementation:

```typescript
import { test } from '@seontechnologies/playwright-utils/fixtures';
import { expect } from '@playwright/test';

test('should load dashboard data', async ({ page, interceptNetworkCall }) => {
  const dashboardCall = interceptNetworkCall({
    method: 'GET',
    url: '**/api/dashboard',
  });

  await page.goto('/dashboard');

  const { status, responseJson: data } = await dashboardCall;

  expect(status).toBe(200);
  expect(data.items).toBeDefined();

  await expect(page.locator('.data-table')).toBeVisible();
  await expect(page.locator('.data-table tr')).toHaveCount(data.items.length);
});
```

Same pattern, cleaner surface. Automatic JSON parsing, built-in status assertions.

## Why TEA Encodes This as a Fragment

Network-first is one of the 42 knowledge fragments loaded by `automate`, `atdd`, and `test-review` via `tea-index.csv`. Every TEA-generated test inherits this pattern without the user having to request it in the prompt. See [[TEA Knowledge Base System]].

## See Also

- [[Test Architect (TEA)]]
- [[Fixture Architecture]] — how `interceptNetworkCall` is built
- [[TEA Knowledge Base System]] — how the pattern is loaded automatically
- [[TEA-Documentation]] — source
