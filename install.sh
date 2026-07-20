#!/bin/sh
# i-have-dyslexia installer
# Usage: curl -sSL https://raw.githubusercontent.com/mdeloughry/i-have-dyslexia/main/install.sh | sh
set -e

REPO_RAW="https://raw.githubusercontent.com/mdeloughry/i-have-dyslexia/main"
RULES_URL="$REPO_RAW/i-have-dyslexia.md"
MARKER="i-have-dyslexia"

bold() { printf '\033[1m%s\033[0m\n' "$1"; }

fetch_rules() {
  if command -v curl >/dev/null 2>&1; then
    curl -sSL "$RULES_URL"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO- "$RULES_URL"
  else
    echo "Error: need curl or wget to download the rules file." >&2
    exit 1
  fi
}

append_once() {
  file="$1"
  text="$2"
  if [ -f "$file" ] && grep -q "$MARKER" "$file"; then
    echo "  SKIP  $file (already installed)"
  else
    printf '%s\n' "$text" >> "$file"
    echo "  DONE  $file"
  fi
}

copy_rules() {
  dest="$1"
  dir=$(dirname "$dest")
  mkdir -p "$dir"
  if [ -f "$dest" ] && grep -q "$MARKER" "$dest"; then
    echo "  SKIP  $dest (already installed)"
  else
    fetch_rules > "$dest"
    echo "  DONE  $dest"
  fi
}

RULES_SNIPPET='
## Output style (i-have-dyslexia)

Dyslexia-friendly output rules: headline first, short sentences, one idea per sentence, bold the key term per line, numbered steps for any process, blank line between ideas, bullets over paragraphs, visual formats over prose. Never simplify content — only change structure. Say "dyslexia fit" to personalise.
Full rules: https://github.com/mdeloughry/i-have-dyslexia
'

bold "i-have-dyslexia installer"
echo ""
echo "Detecting agent harnesses..."
echo ""

found=0

# Claude Code (global memory)
if [ -d "$HOME/.claude" ]; then
  found=1
  bold "Claude Code"
  echo "  Recommended: use the plugin instead (see INSTALL.md)."
  echo "  Installing fallback: rules into ~/.claude/CLAUDE.md"
  append_once "$HOME/.claude/CLAUDE.md" "$RULES_SNIPPET"
fi

# Command Code (global memory)
if [ -d "$HOME/.commandcode" ]; then
  found=1
  bold "Command Code"
  append_once "$HOME/.commandcode/AGENTS.md" "$RULES_SNIPPET"
fi

# Cursor (project rules)
if [ -d ".cursor" ] || [ -d "$HOME/.cursor" ]; then
  found=1
  bold "Cursor"
  copy_rules ".cursor/rules/i-have-dyslexia.md"
fi

# Windsurf (project rules)
if [ -d ".windsurf" ] || [ -d "$HOME/.codeium" ]; then
  found=1
  bold "Windsurf"
  copy_rules ".windsurf/rules/i-have-dyslexia.md"
fi

# Gemini CLI (global memory)
if [ -d "$HOME/.gemini" ]; then
  found=1
  bold "Gemini CLI"
  append_once "$HOME/.gemini/GEMINI.md" "$RULES_SNIPPET"
fi

# Codex / AGENTS.md (project memory)
if [ -f "AGENTS.md" ]; then
  found=1
  bold "AGENTS.md (Codex and compatible)"
  append_once "AGENTS.md" "$RULES_SNIPPET"
fi

echo ""

if [ "$found" -eq 0 ]; then
  echo "No supported harness detected."
  echo ""
  echo "Manual install: paste this file into your agent's memory:"
  echo "  $RULES_URL"
  echo ""
  echo "See https://github.com/mdeloughry/i-have-dyslexia for per-harness steps."
  exit 0
fi

bold "Installed."
echo ""
echo "Verify: open a fresh session and ask: \"Explain how auth works.\""
echo "Pass: the reply opens with a one-line headline and bold anchors."
echo ""
echo "Personalise: say \"dyslexia fit\" to your agent."
