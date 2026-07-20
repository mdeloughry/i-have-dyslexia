# i-have-dyslexia

**Dyslexia-friendly output from any AI coding agent. One file. Any harness.**

A dyslexia port of [i-have-adhd](https://github.com/ayghri/i-have-adhd) by Ayoub G. ([@ayghri](https://github.com/ayghri)). Same idea, different reader. Dyslexia is a decoding difference, not an attention one. So these rules shape **structure**, never **substance**. Full credit in [Credits](#credits).

## The one rule

**Never simplify content. Only change how it is structured and presented.**

## What changes

**Before**

> The issue you're seeing is most likely related to the way tokens are validated in the middleware layer, specifically in the verifyToken function in src/auth.ts around lines 42 to 58, which appears to be using an outdated version of the jsonwebtoken API, so I'd recommend updating the package to the latest version and then rewriting the function to match the new API, after which you should run the auth tests to confirm nothing else breaks.

**After**

> **Token validation** is the bug. The fix is 3 steps.
>
> 1. **Update** the package: `npm install jsonwebtoken@latest`
> 2. **Rewrite** `verifyToken` in `src/auth.ts:42-58`
> 3. **Run** the tests: `npm test -- auth.spec.ts`
>
> **Cause:** `verifyToken` uses the old `jsonwebtoken` API. v9 changed the signature.
>
> **Next:** run step 1 now.

Same facts. Different shape.

## The rules

10 rules. Full text in [i-have-dyslexia.md](i-have-dyslexia.md).

1. Headline first.
2. Short sentences. One idea per sentence.
3. Bold the key term in every line.
4. Never simplify the content.
5. Number every process.
6. Blank line between ideas.
7. Same shape every time.
8. Bullets over paragraphs.
9. Plain glue words, exact content words.
10. Visual formats beat prose.

Plus **dyslexia fit**: say **"dyslexia fit"** to your agent and it interviews you — 7 questions, bold defaults — then writes a `## My profile` block that overrides any rule. The interview script lives inside the rules file, so every harness below gets it for free.

Plus **glossary keeper**: the agent decodes each technical term once, records it in `.dyslexia-glossary.json`, and never makes you decode it twice. Say **"glossary"** to review your terms.

## Install

The rules live in one file: [`i-have-dyslexia.md`](i-have-dyslexia.md). Point your agent at it.

| Harness | Where the rules go |
|---|---|
| Claude Code | Plugin: `claude plugin marketplace add ./i-have-dyslexia && claude plugin install i-have-dyslexia@i-have-dyslexia` |
| AGENTS.md tools (Codex, Cursor, Jules, Aider, ...) | Paste into `AGENTS.md` |
| Cursor rules | Copy to `.cursor/rules/i-have-dyslexia.md` |
| Gemini CLI | Paste into `GEMINI.md` |
| Windsurf | Copy to `.windsurf/rules/i-have-dyslexia.md` |
| Command Code | Paste into `~/.commandcode/AGENTS.md` |

Step-by-step per harness: [INSTALL.md](INSTALL.md)

## Tune it

**Easy way:** load the rules, then say **"dyslexia fit"**. The agent asks 7 questions and writes your profile for you.

**Manual way:** edit `i-have-dyslexia.md`. Add a profile block at the top. The agent reads it first.

```markdown
## My profile

- Mixed dyslexia profile.
- For reports: give me interactive HTML with expandable sections, not dense prose.
- Prefer diagrams over text explanations.
```

## Credits

- [i-have-adhd](https://github.com/ayghri/i-have-adhd) by [@ayghri](https://github.com/ayghri) — the idea and the format.
- British Dyslexia Association style guidance, adapted for LLM output.

## License

MIT.
