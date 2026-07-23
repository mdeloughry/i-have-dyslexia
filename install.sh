#!/bin/sh
# i-have-dyslexia installer
# Usage: curl -sSL https://raw.githubusercontent.com/mdeloughry/i-have-dyslexia/main/install.sh | sh
set -eu

REPO_RAW="https://raw.githubusercontent.com/mdeloughry/i-have-dyslexia/main"
RULES_URL="${I_HAVE_DYSLEXIA_RULES_URL:-$REPO_RAW/i-have-dyslexia.md}"
START_MARKER="<!-- i-have-dyslexia:managed:start -->"
END_MARKER="<!-- i-have-dyslexia:managed:end -->"

mode="install"
dry_run=0

usage() {
  cat <<'EOF'
Usage: install.sh [--dry-run] [--update] [--uninstall]

  --dry-run    Show changes without writing files.
  --update     Update rules only when the previous install is unchanged.
  --uninstall  Remove managed instruction blocks and unchanged rule files.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run) dry_run=1 ;;
    --update) mode="update" ;;
    --uninstall) mode="uninstall" ;;
    --help|-h) usage; exit 0 ;;
    *) echo "Error: unknown option: $1" >&2; usage >&2; exit 1 ;;
  esac
  shift
done

bold() { printf '\033[1m%s\033[0m\n' "$1"; }
note() { printf '  %s  %s\n' "$1" "$2"; }
result() {
  if [ "$dry_run" -eq 1 ]; then
    note "PLAN" "$1"
  else
    note "DONE" "$1"
  fi
}

checksum() {
  cksum < "$1" | awk '{print $1 ":" $2}'
}

rules_version() {
  file="$1"
  sed -n 's/^<!-- i-have-dyslexia:version=\([^>]*\) -->$/\1/p' "$file" | head -n 1
}

state_version() {
  file="$1"
  [ -f "$file" ] || return 1
  sed -n 's/^version=//p' "$file" | head -n 1
}

validate_managed_block() {
  file="$1"
  [ -f "$file" ] || return 0
  awk -v start="$START_MARKER" -v end="$END_MARKER" '
    $0 == start { if (seen_start || seen_end) { bad=1 }; seen_start=1; next }
    $0 == end { if (!seen_start || seen_end) { bad=1 }; seen_end=1; next }
    END { if (bad || seen_start != seen_end) { exit 1 } }
  ' "$file"
}

fetch_rules() {
  target="$1"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$RULES_URL" > "$target"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$target" "$RULES_URL"
  else
    echo "Error: need curl or wget to download the rules file." >&2
    exit 1
  fi
}

write_file() {
  file="$1"
  source="$2"
  if [ "$dry_run" -eq 1 ]; then
    return
  fi
  mkdir -p "$(dirname "$file")"
  cp "$source" "$file"
}

state_checksum() {
  file="$1"
  [ -f "$file" ] || return 1
  sed -n 's/^checksum=//p' "$file" | head -n 1
}

write_state() {
  file="$1"
  rules="$2"
  if [ "$dry_run" -eq 1 ]; then
    return
  fi
  {
    printf 'checksum=%s\n' "$(checksum "$rules")"
    printf 'version=%s\n' "$(rules_version "$rules")"
    printf 'rules=%s\n' "$rules"
  } > "$file"
}

replace_managed_block() {
  config="$1"
  rules="$2"
  version="$3"
  if [ -f "$config" ] && ! validate_managed_block "$config"; then
    echo "Error: refusing to rewrite malformed managed block in $config." >&2
    return 1
  fi
  temp=$(mktemp "${config}.XXXXXX")
  if [ -f "$config" ]; then
    awk -v start="$START_MARKER" -v end="$END_MARKER" '
      $0 == start { inside=1; next }
      $0 == end { inside=0; next }
      !inside { print }
    ' "$config" > "$temp"
  fi
  {
    printf '\n%s\n' "$START_MARKER"
    printf '<!-- i-have-dyslexia:managed:version=%s -->\n' "$version"
    printf '%s%s%s\n' 'Follow every rule in `' "$rules" '` for every response.'
    printf '%s%s%s\n' 'If `' "${rules%.md}.profile.md" '` exists, apply it as the reader profile.'
    printf '%s\n' "$END_MARKER"
  } >> "$temp"

  if [ "$dry_run" -eq 1 ]; then
    rm "$temp"
    return
  fi
  mkdir -p "$(dirname "$config")"
  mv "$temp" "$config"
}

remove_managed_block() {
  config="$1"
  [ -f "$config" ] || return
  if ! validate_managed_block "$config"; then
    echo "Error: refusing to remove malformed managed block in $config." >&2
    return 1
  fi
  temp=$(mktemp "${config}.XXXXXX")
  awk -v start="$START_MARKER" -v end="$END_MARKER" '
    $0 == start { inside=1; next }
    $0 == end { inside=0; next }
    !inside { print }
  ' "$config" > "$temp"
  if [ "$dry_run" -eq 1 ]; then
    rm "$temp"
    return
  fi
  mv "$temp" "$config"
}

install_target() {
  name="$1"
  config="$2"
  rules="$3"
  state="$(dirname "$rules")/.i-have-dyslexia.state"

  bold "$name"

  if [ "$mode" = "uninstall" ]; then
    if [ "$config" != "$rules" ] && [ -f "$config" ]; then
      if ! validate_managed_block "$config"; then
        echo "Error: refusing to uninstall from malformed managed block in $config." >&2
        return 1
      fi
      if grep -Fqx "$START_MARKER" "$config"; then
        remove_managed_block "$config"
        result "$config (managed block removed)"
      fi
    fi
    if [ -f "$rules" ] && [ "$(state_checksum "$state" 2>/dev/null || true)" = "$(checksum "$rules")" ]; then
      if [ "$dry_run" -eq 1 ]; then
        result "$rules and $state"
      else
        rm "$rules" "$state"
        result "$rules (unchanged file removed)"
      fi
    elif [ -f "$rules" ]; then
      note "KEEP" "$rules (changed locally)"
      if [ -f "$state" ]; then
        if [ "$dry_run" -eq 1 ]; then
          result "$state"
        else
          rm "$state"
          result "$state (installer state removed)"
        fi
      fi
    fi
    return
  fi

  if [ -f "$rules" ]; then
    installed_checksum=$(state_checksum "$state" 2>/dev/null || true)
    current_checksum=$(checksum "$rules")
    if [ "$mode" = "install" ]; then
      note "SKIP" "$rules (already exists; use --update)"
    elif [ -n "$installed_checksum" ] && [ "$installed_checksum" = "$current_checksum" ]; then
      write_file "$rules" "$downloaded_rules"
      write_state "$state" "$rules"
      result "$rules (updated $(state_version "$state" 2>/dev/null || true))"
    else
      note "KEEP" "$rules (changed locally or not installer-managed)"
    fi
  else
    write_file "$rules" "$downloaded_rules"
    write_state "$state" "$rules"
    result "$rules"
  fi

  if [ "$config" != "$rules" ]; then
    version=""
    if [ "$dry_run" -eq 0 ]; then
      version=$(rules_version "$downloaded_rules")
    fi
    replace_managed_block "$config" "$rules" "$version"
    result "$config (managed instruction)"
  fi
}

downloaded_rules=""
if [ "$mode" != "uninstall" ] && [ "$dry_run" -eq 0 ]; then
  downloaded_rules=$(mktemp)
  trap 'rm -f "$downloaded_rules"' 0 1 2 3 15
  fetch_rules "$downloaded_rules"
fi

bold "i-have-dyslexia installer"
if [ "$dry_run" -eq 1 ]; then
  echo "Dry run. No files will change."
fi
echo ""

found=0

if [ -d "$HOME/.claude" ]; then
  found=1
  install_target "Claude Code" "$HOME/.claude/CLAUDE.md" "$HOME/.claude/i-have-dyslexia.md"
fi

if [ -d "$HOME/.commandcode" ]; then
  found=1
  install_target "Command Code" "$HOME/.commandcode/AGENTS.md" "$HOME/.commandcode/i-have-dyslexia.md"
fi

if [ -d ".cursor" ]; then
  found=1
  install_target "Cursor" ".cursor/rules/i-have-dyslexia.md" ".cursor/rules/i-have-dyslexia.md"
fi

if [ -d ".windsurf" ]; then
  found=1
  install_target "Windsurf" ".windsurf/rules/i-have-dyslexia.md" ".windsurf/rules/i-have-dyslexia.md"
fi

if [ -d "$HOME/.gemini" ]; then
  found=1
  install_target "Gemini CLI" "$HOME/.gemini/GEMINI.md" "$HOME/.gemini/i-have-dyslexia.md"
fi

if [ -f "AGENTS.md" ] || [ -d ".codex" ] || [ -d ".agents" ]; then
  found=1
  install_target "AGENTS.md tools" "AGENTS.md" ".i-have-dyslexia.md"
fi

echo ""
if [ "$found" -eq 0 ]; then
  echo "No supported harness detected in this directory."
  echo "Run from a project with AGENTS.md, .codex, .agents, .cursor, or .windsurf."
  exit 0
fi

if [ "$mode" = "uninstall" ]; then
  bold "Uninstall complete."
else
  bold "Install complete."
  echo "Verify in a fresh session: Explain how auth works in this repo."
  echo "Personalise: say dyslexia fit."
fi
