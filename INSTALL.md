# Install i-have-dyslexia

**One file. Any harness.** The rules live in `i-have-dyslexia.md`. Every method below gets that file in front of your agent.

## TL;DR

1. **Clone** the repo: `git clone https://github.com/mdeloughry/i-have-dyslexia ./i-have-dyslexia`
2. **Pick** your harness from the list below.
3. **Verify** with the test prompt at the bottom.

## Claude Code (plugin)

Same install as the original i-have-adhd.

1. **Add** the marketplace: `claude plugin marketplace add ./i-have-dyslexia`
2. **Install** the plugin: `claude plugin install i-have-dyslexia@i-have-dyslexia`
3. **Invoke** it in a session: `/i-have-dyslexia`

**Disable:** `claude plugin disable i-have-dyslexia`

**Always-on option:** add to `~/.claude/CLAUDE.md`:

```markdown
## Output style

Always follow the rules in the `i-have-dyslexia` skill: headline first, short sentences, bold key terms, numbered steps, full content kept.
```

**Update:** `cd ./i-have-dyslexia && git pull`

## AGENTS.md (Codex, Cursor, Jules, Aider, many more)

`AGENTS.md` is the cross-harness standard. Most agents read it automatically.

**Per project:**

1. **Copy** `i-have-dyslexia.md` into your project root.
2. **Add** this line to `AGENTS.md` (create the file if missing):

```markdown
Follow all rules in [i-have-dyslexia.md](i-have-dyslexia.md) for every response.
```

**Global (every project):** paste the full contents of `i-have-dyslexia.md` into `~/.codex/AGENTS.md` or your harness's global memory file.

## Cursor (rules file)

1. **Create** `.cursor/rules/` in your project if it does not exist.
2. **Copy** `i-have-dyslexia.md` to `.cursor/rules/i-have-dyslexia.md`.
3. **Set** the rule to "Always" in Cursor's rules settings so it applies to every chat.

## Gemini CLI

1. **Open** `GEMINI.md` in your project root (or `~/.gemini/GEMINI.md` for global).
2. **Paste** the full contents of `i-have-dyslexia.md`.

## Windsurf

1. **Create** `.windsurf/rules/` in your project if it does not exist.
2. **Copy** `i-have-dyslexia.md` to `.windsurf/rules/i-have-dyslexia.md`.
3. **Set** activation to "Always On".

## Command Code

1. **Open** `~/.commandcode/AGENTS.md` for global use, or `.commandcode/AGENTS.md` in a project.
2. **Paste** the full contents of `i-have-dyslexia.md`.

## Any other harness

Every agent has a memory or instructions file. Find it. Paste `i-have-dyslexia.md` into it.

## Verify

Send this prompt in a fresh session:

> Explain how auth works in this repo.

**Pass:** the reply opens with a one-line headline, uses bold anchors, and numbers any steps.

**Fail:** the reply is dense paragraphs. Fix: check the rules file is actually loaded (path, rule activation setting, or plugin status).

## Troubleshooting

**Rules load but the agent still writes walls of text.** Start a new session. Old context carries. If it still drifts, move the rules higher in the memory file.

**Plugin not in autocomplete (Claude Code).** Restart Claude Code. The plugin index is read at startup.

**`marketplace add` fails.** Point at the repo root, not `.claude-plugin/`. The path must contain `.claude-plugin/marketplace.json`.

**Agent drops detail to stay short.** That is rule 4 failing. Add to your profile block: "Full technical depth always. Structure short, content complete."

## Tune it

Edit `i-have-dyslexia.md`. Keep your personal additions in a `## My profile` block at the top so upstream updates stay easy to merge.
