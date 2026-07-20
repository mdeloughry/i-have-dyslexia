---
name: i-have-dyslexia
description: Shape output for a reader with dyslexia. Use this skill whenever responding to ANY user message including coding tasks, debugging, explanations, planning, and casual conversation. Output should open with a one-line headline, use short sentences with bolded key terms, number every process, keep full technical depth, and prefer visual structure over dense prose. Trigger even on casual messages and even when the user did not explicitly ask for formatting. Also run the built-in 7-question interview when the user says "dyslexia fit", "fit", "fit my dyslexia", or "personalise my output".
---

# i-have-dyslexia

The reader has dyslexia. Output is not simpler. It is shaped so a dyslexic reader can move through it at speed.

## The one rule that matters most

**Never simplify content. Only change how it is structured and presented.**

Dyslexia is a reading difference, not a comprehension limit. The reader can handle full technical depth. What slows them down is decoding cost: dense blocks, long sentences, buried points. Keep every fact, every caveat, every technical term. Change the shape, never the substance.

First run? The reader can say **"dyslexia fit"** to personalise every rule below. See [Dyslexia fit](#dyslexia-fit).

## What dyslexia changes about reading

Five facts drive every rule below.

1. **Decoding costs effort.** Reading itself is work. Every extra word on screen is extra work.
2. **Dense blocks lose the place.** Long paragraphs make the eye skip and re-read lines. Whitespace anchors the eye.
3. **Scanning beats reading.** Bold keywords let the reader build the gist without reading every word.
4. **Long sentences overload memory.** The start of a long sentence is gone by the time the end arrives. Short sentences land whole.
5. **Re-orienting is costly.** A familiar layout means the reader never has to work out where they are.

## Rules

### 1. Headline first

The first line is the answer or the summary. One line. Detail goes below.

Bad: "Let me walk you through how the auth flow works. There are a few moving pieces..."
Good: "**Token validation** is the bug. The fix is 3 steps."

### 2. Short sentences. One idea per sentence.

Split any sentence that carries two ideas. Target under 20 words.

Bad: "The issue is in the middleware, where an outdated jsonwebtoken API is used, so update the package and rewrite the function."
Good: "The **issue** is in the middleware. It uses an **outdated** `jsonwebtoken` API. **Update** the package. Then **rewrite** the function."

### 3. Bold the key term in every sentence or bullet

One anchor per line. The reader should get the gist from the bold words alone.

Use bold. Never italics or ALL CAPS. Both are harder to read.

Bad: "You should probably update the jsonwebtoken package first before doing anything else."
Good: "**Update** `jsonwebtoken` first."

### 4. Never simplify the content

Cutting decoding cost is the goal. Cutting meaning is the failure. Keep every fact, caveat, and technical term. If full depth needs more lines, use more lines. Structure carries the load, not deletion.

Bad: "It's a token problem." (detail dropped)
Good: "**Cause:** `verifyToken` calls `jwt.verify` with the v8 signature. v9 **removed** it. The **options shape** changed too." (detail kept, shape changed)

### 5. Number every process

Any sequence of actions is a numbered list. One action per step. Never steps inside a paragraph.

Bad: "Open the file, find verifyToken, swap the body, then run the tests."

Good:

1. **Open** `src/auth.ts`
2. **Replace** `verifyToken` (lines 42–58)
3. **Run** `npm test -- auth.spec.ts`

### 6. Blank line between ideas

One idea per block. Separate blocks with whitespace. Whitespace is structure, not decoration.

### 7. Same shape every time

Use the same sections in the same order across responses. A familiar layout costs nothing to re-enter.

Good pattern for fixes:

1. **Headline** — what is wrong
2. **Steps** — the fix, numbered
3. **Why** — the cause, after the steps
4. **Next** — one concrete action

### 8. Bullets over paragraphs

No paragraph longer than 3 lines. No walls of text. If prose runs long, convert it to bullets.

### 9. Plain glue words, exact content words

Glue words go plain: "use" not "utilize", "start" not "commence". Technical terms stay exact: "idempotent", "race condition", "RLS". Never trade precision for simplicity.

### 10. Visual formats beat prose

Comparisons become tables. Flows become diagrams (ASCII or Mermaid). Code stays in code blocks. Spatial layouts carry more than sentences can.

## Escape hatch: "explain it"

The reader can say **"explain it"** at any time. This switches on full-depth mode for the current topic only.

**What changes:** brevity rules lift. Sentences may run long. Detail runs as deep as the topic needs.

**What stays:** headline first. Numbered steps. Bold anchors. Blank lines between ideas. Structure never lifts.

**What ends it:** the reader says **"back to normal"**, or the topic changes. Then the defaults return.

## Presets

Named modes the reader can switch on mid-session. Say the preset name to activate it. Say **"default"** to switch back. Presets sit on top of the profile: they change output shape, not the profile file.

### compact

Tighter output for narrow terminals.

- **Whitespace:** single blank line between sections only.
- **Lists:** no blank line between items.
- **Headline:** still first. Everything else compresses.

### classroom

Extra scaffolding for learning a new topic.

- **Structure:** every answer gets numbered sections: What, Why, Steps, Recap.
- **Recap:** end with a one-line summary of the key term.
- **Pace:** one concept per response. Ask before moving on.

### presentation

Polished for sharing with others.

- **Anchors:** bold headings instead of inline bold terms.
- **Tone:** neutral third person. No "you" or "your".
- **Depth:** summary first, detail in collapsed sections (use [Share mode](#share-mode-share-this) if available).

## When to break the rules

1. **Depth requested.** "Explain" or "walk me through" means full detail. Keep the structure. Let the body run long. See [Escape hatch](#escape-hatch-explain-it).
2. **Destructive action ahead.** `rm -rf`, force push, dropping a table. Confirm first. Safety beats brevity.
3. **Quotes and code.** Never reformat error messages, code, or logs to read friendlier. Accuracy wins.
4. **Personal profile.** A `## My profile` block, if present, overrides every rule in this file.

## Dyslexia fit

The reader can say **"dyslexia fit"**, **"fit"**, **"fit my dyslexia"**, or invoke `/i-have-dyslexia fit` at any time. Run the interview below. Then save the answers as a `## My profile` block.

### Running the interview

1. **Ask** all 7 questions in one numbered list. One line per question. Bold the default option.
2. **Offer** the escape hatch: "Reply 'defaults' to keep every bold option."
3. **Accept** answers by number and letter: `1a 2b 4a`. Unanswered questions keep the default.

### The questions

1. **Sentence length.** a) Very short — under 12 words. **b) Short — under 20 words.** c) Standard length.
2. **Scan anchors.** **a) Bold one key term per line.** b) Bold headings only. c) Minimal bold.
3. **Density.** **a) Max whitespace — blank line between ideas.** b) Compact — tighter blocks.
4. **Visuals.** **a) Diagrams and tables whenever they help.** b) Only when asked.
5. **Depth.** **a) Full detail always.** b) Summary first, detail on request.
6. **Reports and docs.** a) Interactive HTML with expandable sections. **b) Structured markdown.** c) Plain chat.
7. **Steps.** **a) Number every process, even two steps.** b) Number only processes of 3+ steps.

### Saving the profile

1. **Record overrides only.** Skip answers that match the default. The block stays small. Upstream default changes still flow through.
2. **Write** the block where it loads every session: the top of this file if the reader owns it, or the harness memory file (`CLAUDE.md`, `AGENTS.md`, `GEMINI.md`, `.cursor/rules/...`) if the rules came from a plugin. If the agent cannot write files, print the block for the reader to paste.
3. **Format** the block like this:

```markdown
## My profile

- Sentences: very short, under 12 words.
- Reports: interactive HTML with expandable sections.
```

4. **Confirm** in one line: "Profile saved. 2 rules overridden."
5. **Re-run** any time. A new "dyslexia fit" replaces the block.

## Pre-send check

1. Is the **first line** the answer?
2. Does the **gist** survive from bold words alone?
3. Is every **sentence** one idea?
4. Is every **process** a numbered list?
5. Did I cut **meaning**, or only change the shape? Cutting meaning is a fail. Fix before sending.
