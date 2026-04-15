---
type: concept
title: "Fixture Architecture"
created: 2026-04-15
updated: 2026-04-15
tags:
  - concept
  - testing
  - tea
  - patterns
status: current
related:
  - "[[Test Architect (TEA)]]"
  - "[[Network-First Testing]]"
  - "[[TEA-Documentation]]"
sources:
  - "[[TEA-Documentation]]"
---

# Fixture Architecture

TEA's pattern for building reusable, testable, composable test utilities. The core rule: **build pure functions first, wrap in framework fixtures second.**

## The Three-Step Pattern

```
Step 1: Pure Function    helpers/api-request.ts      (framework-agnostic)
            ↓
Step 2: Fixture Wrapper  fixtures/api-request.ts     (Playwright/Cypress)
            ↓
Step 3: Composition      fixtures/index.ts           (mergeTests)
            ↓
Step 4: Use              tests/**.spec.ts
```

### Why This Order

- Pure functions are easier to unit test (inject dependencies, mock them)
- Fixtures are framework-bound (less portable)
- Composition happens at the fixture level with `mergeTests`
- Reusability is maximized: swap Playwright for Cypress by changing only the wrapper

## Step 1: Pure Function

Write the utility with dependency injection. No framework imports.

```typescript
// helpers/api-request.ts
export async function apiRequest({
  request,    // injected dependency
  method,
  url,
  data,
  headers = {},
}: ApiRequestParams): Promise<ApiResponse> {
  const response = await request.fetch(url, { method, data, headers });

  if (!response.ok()) {
    throw new Error(`API request failed: ${response.status()}`);
  }

  return { status: response.status(), body: await response.json() };
}
```

Unit-testable without a browser:

```typescript
describe('apiRequest', () => {
  it('throws on non-OK response', async () => {
    const mockRequest = {
      fetch: vi.fn().mockResolvedValue({ ok: () => false, status: () => 500 }),
    };
    await expect(
      apiRequest({ request: mockRequest, method: 'GET', url: '/api/test' })
    ).rejects.toThrow('API request failed: 500');
  });
});
```

## Step 2: Fixture Wrapper

Wire the pure function into the framework by injecting the framework-provided dependency.

```typescript
// fixtures/api-request.ts
import { test as base } from '@playwright/test';
import { apiRequest as apiRequestFn } from '../helpers/api-request';

export const test = base.extend<{ apiRequest: typeof apiRequestFn }>({
  apiRequest: async ({ request }, use) => {
    await use((params) => apiRequestFn({ request, ...params }));
  },
});

export { expect } from '@playwright/test';
```

The wrapper is the **only** framework-coupled code. Logic stays in the pure function.

## Step 3: Composition

Combine fixtures with `mergeTests`. Tests can consume multiple capabilities without one monster fixture.

```typescript
// fixtures/index.ts
import { mergeTests } from '@playwright/test';
import { test as apiRequest } from './api-request';
import { test as authSession } from './auth-session';
import { test as networkRecorder } from './network-recorder';

export const test = mergeTests(apiRequest, authSession, networkRecorder);
```

## Anti-Patterns

### Framework-First

```typescript
// ❌ Built as fixture from the start — cannot unit test
export const test = base.extend({
  apiRequest: async ({ request }, use) => {
    await use(async (options) => {
      const response = await request.fetch(options.url, { ... });
      if (!response.ok()) throw new Error(`... ${response.status()}`);
      return response.json();
    });
  },
});
```

Logic is trapped inside the fixture closure. No way to mock `request`, no way to reuse in Node scripts or Cypress.

### Copy-Paste Utilities

Repeating the same 5 lines across 50 tests. Violates DRY, creates inconsistent error handling, and turns every pattern change into a 50-file edit.

## Playwright Utils

`@seontechnologies/playwright-utils` ships production-ready fixtures built this way: `api-request`, `auth-session`, `intercept-network-call`, `network-recorder`, `burn-in`, `network-error-monitor`, `log`, `file-utils`, `recurse`, `fixtures-composition`. Install via installer or set `tea_use_playwright_utils: true`.

## See Also

- [[Test Architect (TEA)]]
- [[Network-First Testing]] — the canonical pattern `interceptNetworkCall` implements
- [[TEA-Documentation]] — source
