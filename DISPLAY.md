# Display setup for dyslexic readers

**The rules fix what the agent writes. This guide fixes how your screen shows it.**

Both matter. Good rules in a bad font still cost effort.

## Fonts

Ranked by letterform distinction — how hard it is to confuse `b/d`, `p/q`, `I/l/1`.

| Font | Cost | Notes |
|---|---|---|
| **Atkinson Hyperlegible** | Free | Designed for low vision. Strong `I/l/1` split. Clean look. |
| **OpenDyslexic** | Free (OFL) | Weighted bottoms resist letter-flipping. Polarising look — try before committing. |
| **Dyslexie** | Paid | Similar weighted-bottom idea. Some research support. |
| **Comic Sans** | Installed | Irregular letterforms genuinely help some readers. No shame. |
| **Verdana / Tahoma** | Installed | Wide spacing, clear forms. Good zero-effort default. |

**Code fonts:** JetBrains Mono and Fira Code both have clear `0/O` and `1/l` splits. Avoid ultra-condensed code fonts.

## Spacing

Three settings do most of the work.

1. **Line-height 1.5–1.8.** Stops lines blurring together.
2. **Letter-spacing +2–5%.** Stops letters crowding.
3. **Paragraph spacing > line spacing.** Makes gaps between ideas bigger than gaps inside them.

## Colour and contrast

1. **Avoid pure black on pure white.** The contrast is harsh. Dark grey (`#1a1a1a`) on off-white (`#fafafa`) reads easier.
2. **Dark mode:** off-white text (`#e8e8e8`) on dark grey (`#1e1e1e`). Not pure black backgrounds.
3. **Colour filters** (warm tints) help some readers. macOS: System Settings → Accessibility → Display → Colour Filters.

## Terminal settings

1. **Font size 14–16pt minimum.** Squinting adds load.
2. **Line-height 1.4+** if your terminal supports it (iTerm2: yes, built-in Terminal: limited).
3. **Wide window, short lines.** Aim for 80–100 character line length in output.
4. **Disable blinking cursor** if it pulls your eye.

## Editor settings

For VS Code and forks (Cursor, Windsurf):

```json
{
  "editor.lineHeight": 1.6,
  "editor.letterSpacing": 0.5,
  "editor.fontSize": 15,
  "editor.fontFamily": "JetBrains Mono, Fira Code, monospace",
  "editor.renderWhitespace": "none",
  "workbench.colorTheme": "your dark-grey theme here"
}
```

## What not to do

1. **No italics.** Letters slant and merge.
2. **No ALL CAPS blocks.** Word shape disappears. Every word becomes a rectangle.
3. **No justified text.** Uneven word gaps create "rivers" of whitespace.
4. **No serif body text at small sizes.** Serifs add decoding noise below ~14pt.

## Further reading

- British Dyslexia Association: [Dyslexia friendly style guide](https://www.bdadyslexia.org.uk/advice/employers/creating-a-dyslexia-friendly-workplace/dyslexia-friendly-style-guide)
- WebAIM: [Evaluating Cognitive Web Accessibility](https://webaim.org/articles/evaluatingcognitive/)
