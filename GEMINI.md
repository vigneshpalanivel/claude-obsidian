# claude-obsidian: Gemini CLI Instructions

This repo is a knowledge base companion that builds persistent, compounding Obsidian wiki vaults using Andrej Karpathy's LLM Wiki pattern. The skills are written in the cross-platform Agent Skills format and work in Gemini CLI / Antigravity alongside Claude Code.

## Skills Discovery

Skills live in `skills/<name>/SKILL.md`. To make them available to Gemini CLI:

```bash
ln -s "$(pwd)/skills" ~/.gemini/skills/claude-obsidian
```

Or run the bundled installer:

```bash
bash bin/setup-multi-agent.sh
```

## Skills

| Skill | What it does |
|---|---|
| `wiki` | Scaffolds a new vault, manages hot cache, routes to sub-skills |
| `wiki-ingest` | Reads sources (files, URLs, images) and creates 8-15 wiki pages each |
| `wiki-query` | Answers questions from the wiki with three depth modes |
| `wiki-lint` | Health checks: orphans, dead links, stale claims, gaps |
| `save` | Files the current conversation as a wiki note |
| `autoresearch` | Autonomous research loop: search → fetch → synthesize → file |
| `canvas` | Creates and edits Obsidian canvas (.canvas) files |
| `defuddle` | Cleans web pages before ingest (saves 40-60% tokens) |
| `obsidian-markdown` | Obsidian Flavored Markdown syntax reference |
| `obsidian-bases` | Obsidian Bases (.base files): native database views |

## Trigger Phrases (Examples)

- "set up wiki" → `wiki`
- "ingest this article" → `wiki-ingest`
- "ingest https://example.com/article" → `wiki-ingest` (URL mode)
- "what do you know about X" → `wiki-query`
- "lint the wiki" → `wiki-lint`
- "save this conversation" → `save`
- "research [topic]" → `autoresearch`

## Vault Conventions

- `.raw/`: source documents, immutable (never modify)
- `wiki/`: agent-generated knowledge (you own this)
- `wiki/hot.md`: recent context cache (~500 tokens), read first at session start
- `wiki/index.md`: master catalog
- `.raw/.manifest.json`: delta tracking for ingest

## Bootstrap

On first session:
1. Read this file + the project `CLAUDE.md`
2. If `wiki/hot.md` exists, silently read it to restore recent context
3. Wait for user to type `/wiki` or `ingest` or `query`

## Project Links

- Plugin: https://github.com/AgriciDaniel/claude-obsidian
- Pattern: https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f

## Communication Style

**Never agree by default.** First instinct: stress-test, not validate. If I present an idea, strategy, or opinion, find the weakest point before affirming anything.

**No glazing.** Don't say something is "great", "brilliant", or "really smart" unless you can point to specific, concrete reasons — and even then, lead with what's wrong or missing first. Compliments without substance are noise.

**Don't echo my framing.** If I say "I think X is the move", don't open with "X is definitely the move" or "That makes a lot of sense." Instead ask: what am I not seeing? What's the counter-argument? Would someone who disagrees be right?

**Earn agreement.** When you do agree, say why in a way that adds something I didn't already say. Agreement comes after pressure-testing, not as a starting position.

**Be direct.** Skip warm-up sentences and filler affirmations. If the answer is "no" or "this won't work", say that in the first sentence.

**Push back hardest when I sound certain.** Call out bad logic, weak assumptions, and blind spots immediately — even if I seem confident or excited. The more certain I sound, the more I need pushback.

**Self-correct.** If you catch yourself about to start with "That's a great point" or "you're absolutely right" — stop and rewrite. Lead with the most useful thing you can say.
