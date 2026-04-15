---
type: concept
title: "TEA Knowledge Base System"
created: 2026-04-16
updated: 2026-04-16
tags:
  - concept
  - tea
  - testing
  - context-engineering
status: current
related:
  - "[[Test Architect (TEA)]]"
  - "[[TEA Workflows]]"
  - "[[Fixture Architecture]]"
  - "[[Network-First Testing]]"
  - "[[TEA-Documentation]]"
sources:
  - "[[TEA-Documentation]]"
---

# TEA Knowledge Base System

TEA's mechanism for **context engineering**: load domain-specific standards into AI context automatically so test quality is consistent regardless of prompt variation.

## The Problem Being Solved

Prompt-driven testing produces inconsistent results. Write "tests for login" in three sessions, get three different quality levels. Patterns drift across teams. There is no single source of truth.

TEA replaces prompt engineering with context engineering: the workflow decides which standards to load, the AI gets those standards as context, the output is consistent by construction.

## How It Works

### tea-index.csv Manifest

Located at `src/agents/bmad-tea/resources/tea-index.csv`. Each row describes one knowledge fragment:

```csv
id,name,description,tags,tier,fragment_file
test-quality,Test Quality,Execution limits and isolation rules,"quality,standards",knowledge/test-quality.md
network-first,Network-First Safeguards,Intercept-before-navigate workflow,"network,stability",knowledge/network-first.md
fixture-architecture,Fixture Architecture,Composable fixture patterns,"fixtures,architecture",knowledge/fixture-architecture.md
```

### Selective Loading

When a workflow runs, TEA reads the manifest and loads only the fragments that workflow needs. For `atdd` this might be:

- `test-quality.md`
- `network-first.md`
- `component-tdd.md`
- `fixture-architecture.md`
- `data-factories.md`

Five fragments loaded, **not all 42**. Token budget stays tight; context stays relevant.

### Consistent Output

Every invocation of the same workflow loads the same fragments, so every output follows the same standards. Tests look like they were written by the same expert, every time.

## Fragment Structure

Each fragment is a markdown file with a fixed shape:

```markdown
# Fragment Name

## Principle
[One sentence — what is this pattern?]

## Rationale
[Why use this instead of alternatives?]

## Pattern Examples
### Example 1: Basic Usage
[Runnable code]
### Example 2: Advanced Pattern
[More complex example]

## Anti-Patterns
### Don't Do This
[Bad example + why it fails]

## Related Patterns
- [Link to related fragment]
```

Fragments are deliberately small and focused. One pattern per file. 42 fragments total in the TEA 2026-04-13 snapshot.

## Fragment Categories

Organized into groups (covered in [reference/knowledge-base.md](https://bmad-code-org.github.io/bmad-method-test-architecture-enterprise/reference/knowledge-base)):

- **Quality Standards** — DoD, determinism, isolation, explicit assertions
- **Test Design** — risk-based planning, priorities, coverage
- **Fixture Patterns** — pure function → fixture → composition
- **Network Patterns** — intercept-before-navigate, burn-in, network-error-monitor
- **Data Factories** — test data generation and cleanup
- **Contract Testing** — Pact consumer/provider patterns
- **Browser Automation** — CLI vs MCP tradeoffs

## Why It Matters

> [!key-insight] Context engineering replaces prompt engineering
> TEA does not ask users to write better prompts. It ensures the AI already has the right context loaded before it sees the prompt at all. This is the same principle that makes [[LLM Wiki Pattern]] and the [[Hot Cache]] work in this vault: relevant standards in context, irrelevant stuff out, consistent output by construction.

This is why TEA can claim reproducible test quality across sessions, teams, and prompts. The knowledge base is the quality floor.

## Extension

Custom fragments can be added to the knowledge base. TEA also supports custom workflows that reference custom fragments (see `how-to/customization/extend-tea-with-custom-workflows.md` in the source).

## See Also

- [[Test Architect (TEA)]]
- [[LLM Wiki Pattern]] — same context engineering principle, different domain
- [[Hot Cache]] — parallel mechanism for session continuity
- [[TEA-Documentation]] — source
