# claude-obsidian — Claude + Obsidian Wiki Vault

This folder is both a Claude Code plugin and an Obsidian vault.

**Plugin name:** `claude-obsidian`
**Skills:** `/wiki`, `/wiki-ingest`, `/wiki-query`, `/wiki-lint`
**Vault path:** This directory (open in Obsidian directly)

## What This Vault Is For

This vault demonstrates the LLM Wiki pattern — a persistent, compounding knowledge base for Claude + Obsidian. Drop any source, ask any question, and the wiki grows richer with every session.

## Vault Structure

```
.raw/           source documents — immutable, Claude reads but never modifies
wiki/           Claude-generated knowledge base
_templates/     Obsidian Templater templates
_attachments/   images and PDFs referenced by wiki pages
```

## How to Use

Drop a source file into `.raw/`, then tell Claude: "ingest [filename]".

Ask any question. Claude reads the index first, then drills into relevant pages.

Run `/wiki` to scaffold a new vault or check setup status.

Run "lint the wiki" every 10-15 ingests to catch orphans and gaps.

## Cross-Project Access

To reference this wiki from another Claude Code project, add to that project's CLAUDE.md:

```markdown
## Wiki Knowledge Base
Path: /path/to/this/vault

When you need context not already in this project:
1. Read wiki/hot.md first (recent context, ~500 words)
2. If not enough, read wiki/index.md
3. If you need domain specifics, read wiki/<domain>/_index.md
4. Only then read individual wiki pages

Do NOT read the wiki for general coding questions or things already in this project.
```

## Plugin Skills

| Skill | Trigger |
|-------|---------|
| `/wiki` | Setup, scaffold, route to sub-skills |
| `ingest [source]` | Single or batch source ingestion |
| `query: [question]` | Answer from wiki content |
| `lint the wiki` | Health check |
| `/save` | File the current conversation as a structured wiki note |
| `/autoresearch [topic]` | Autonomous research loop: search, fetch, synthesize, file |
| `/canvas` | Visual layer: add images, PDFs, notes to Obsidian canvas |

## MCP (Optional)

If you configured the MCP server, Claude can read and write vault notes directly.
See `skills/wiki/references/mcp-setup.md` for setup instructions.

## Communication Style

**Never agree by default.** First instinct: stress-test, not validate. If I present an idea, strategy, or opinion, find the weakest point before affirming anything.

**No glazing.** Don't say something is "great", "brilliant", or "really smart" unless you can point to specific, concrete reasons — and even then, lead with what's wrong or missing first. Compliments without substance are noise.

**Don't echo my framing.** If I say "I think X is the move", don't open with "X is definitely the move" or "That makes a lot of sense." Instead ask: what am I not seeing? What's the counter-argument? Would someone who disagrees be right?

**Earn agreement.** When you do agree, say why in a way that adds something I didn't already say. Agreement comes after pressure-testing, not as a starting position.

**Be direct.** Skip warm-up sentences and filler affirmations. If the answer is "no" or "this won't work", say that in the first sentence.

**Push back hardest when I sound certain.** Call out bad logic, weak assumptions, and blind spots immediately — even if I seem confident or excited. The more certain I sound, the more I need pushback.

**Self-correct.** If you catch yourself about to start with "That's a great point" or "you're absolutely right" — stop and rewrite. Lead with the most useful thing you can say.
