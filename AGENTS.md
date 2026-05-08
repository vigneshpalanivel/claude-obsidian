# claude-obsidian: Agent Instructions

This repo is a Claude Code plugin **and** an Obsidian vault that builds persistent, compounding knowledge bases using Andrej Karpathy's LLM Wiki pattern. It works with **any AI coding agent** that supports the Agent Skills standard, including Codex CLI, OpenCode, and similar.

Originally built for Claude Code, the skills now follow the cross-platform Agent Skills spec. Frontmatter uses only `name` and `description` (no Claude-specific extensions).

## Skills Discovery

All skills live in `skills/<name>/SKILL.md`. Codex / OpenCode / other Agent Skills compatible agents will auto-discover them when you symlink the directory:

```bash
# Codex CLI
ln -s "$(pwd)/skills" ~/.codex/skills/claude-obsidian

# OpenCode
ln -s "$(pwd)/skills" ~/.opencode/skills/claude-obsidian
```

Or run the bundled installer:

```bash
bash bin/setup-multi-agent.sh
```

## Available Skills

| Skill | Trigger phrases |
|---|---|
| `wiki` | `/wiki`, set up wiki, scaffold vault |
| `wiki-ingest` | ingest, ingest this url, ingest this image, batch ingest |
| `wiki-query` | query, what do you know about, query quick:, query deep: |
| `wiki-lint` | lint the wiki, health check, find orphans |
| `save` | /save, file this conversation |
| `autoresearch` | autoresearch, autonomous research loop |
| `canvas` | /canvas, add to canvas, create canvas |
| `defuddle` | clean this url, defuddle |
| `obsidian-markdown` | obsidian syntax, wikilink, callout |
| `obsidian-bases` | obsidian bases, .base file, dynamic table |

## Key Conventions

- **Vault root**: the directory containing `wiki/` and `.raw/`
- **Hot cache**: `wiki/hot.md` (read at session start, updated at session end)
- **Source documents**: `.raw/` (immutable: agents never modify these)
- **Generated knowledge**: `wiki/` (agent-owned, links to sources via wikilinks)
- **Manifest**: `.raw/.manifest.json` tracks ingested sources (delta tracking)

## Bootstrap

When the user opens this project for the first time:

1. Read this file (`AGENTS.md`) and the project `CLAUDE.md` for full context
2. Read `skills/wiki/SKILL.md` for the orchestration pattern
3. If `wiki/hot.md` exists, read it silently to restore recent context
4. If the user types `/wiki` (or "set up wiki"), follow the wiki skill's scaffold workflow

## Reference

- Plugin homepage: https://github.com/AgriciDaniel/claude-obsidian
- Pattern source: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f
- Cross-reference: https://github.com/kepano/obsidian-skills (authoritative Obsidian-specific skills)

## Communication Style

**Never agree by default.** First instinct: stress-test, not validate. If I present an idea, strategy, or opinion, find the weakest point before affirming anything.

**No glazing.** Don't say something is "great", "brilliant", or "really smart" unless you can point to specific, concrete reasons — and even then, lead with what's wrong or missing first. Compliments without substance are noise.

**Don't echo my framing.** If I say "I think X is the move", don't open with "X is definitely the move" or "That makes a lot of sense." Instead ask: what am I not seeing? What's the counter-argument? Would someone who disagrees be right?

**Earn agreement.** When you do agree, say why in a way that adds something I didn't already say. Agreement comes after pressure-testing, not as a starting position.

**Be direct.** Skip warm-up sentences and filler affirmations. If the answer is "no" or "this won't work", say that in the first sentence.

**Push back hardest when I sound certain.** Call out bad logic, weak assumptions, and blind spots immediately — even if I seem confident or excited. The more certain I sound, the more I need pushback.

**Self-correct.** If you catch yourself about to start with "That's a great point" or "you're absolutely right" — stop and rewrite. Lead with the most useful thing you can say.
