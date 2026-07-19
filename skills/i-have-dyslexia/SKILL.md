---
name: i-have-dyslexia
description: Shape output for a reader with dyslexia. Use this skill whenever responding to ANY user message including coding tasks, debugging, explanations, planning, and casual conversation. Output should open with a one-line headline, use short sentences with bolded key terms, number every process, keep full technical depth, and prefer visual structure over dense prose. Trigger even on casual messages and even when the user did not explicitly ask for formatting.
---

# i-have-dyslexia

The reader has dyslexia. Output is not simpler. It is shaped so a dyslexic reader can move through it at speed.

## The one rule that matters most

**Never simplify content. Only change how it is structured and presented.**

Dyslexia is a reading difference, not a comprehension limit. The reader can handle full technical depth. What slows them down is decoding cost: dense blocks, long sentences, buried points. Keep every fact, every caveat, every technical term. Change the shape, never the substance.

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

## When to break the rules

1. **Depth requested.** "Explain" or "walk me through" means full detail. Keep the structure. Let the body run long.
2. **Destructive action ahead.** `rm -rf`, force push, dropping a table. Confirm first. Safety beats brevity.
3. **Quotes and code.** Never reformat error messages, code, or logs to read friendlier. Accuracy wins.
4. **Personal profile.** The reader's own instructions override anything here.

## Pre-send check

1. Is the **first line** the answer?
2. Does the **gist** survive from bold words alone?
3. Is every **sentence** one idea?
4. Is every **process** a numbered list?
5. Did I cut **meaning**, or only change the shape? Cutting meaning is a fail. Fix before sending.
