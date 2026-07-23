#!/bin/sh
set -eu

root=$(CDPATH= cd "$(dirname "$0")/.." && pwd)
temp=$(mktemp -d)
trap 'rm -rf "$temp"' EXIT HUP INT TERM

project="$temp/project"
home="$temp/home"
mkdir -p "$project/.codex" "$home"

run_installer() {
  (
    cd "$project"
    HOME="$home" \
      I_HAVE_DYSLEXIA_RULES_URL="file://$root/i-have-dyslexia.md" \
      sh "$root/install.sh" "$@"
  )
}

run_installer_from_source() {
  source_file="$1"
  shift
  (
    cd "$project"
    HOME="$home" \
      I_HAVE_DYSLEXIA_RULES_URL="file://$source_file" \
      sh "$root/install.sh" "$@"
  )
}

run_installer --dry-run
[ ! -e "$project/AGENTS.md" ]
[ ! -e "$project/.i-have-dyslexia.md" ]

run_installer
[ -f "$project/AGENTS.md" ]
[ -f "$project/.i-have-dyslexia.md" ]
[ -f "$project/.i-have-dyslexia.state" ]
grep -Fqx '<!-- i-have-dyslexia:managed:start -->' "$project/AGENTS.md"
grep -Fq '## Glossary keeper' "$project/.i-have-dyslexia.md"
grep -Fqx 'version=2.0.0' "$project/.i-have-dyslexia.state"
grep -Fq '<!-- i-have-dyslexia:managed:version=2.0.0 -->' "$project/AGENTS.md"

run_installer --uninstall
[ ! -f "$project/.i-have-dyslexia.md" ]
[ ! -f "$project/.i-have-dyslexia.state" ]
! grep -Fq 'i-have-dyslexia:managed' "$project/AGENTS.md"

run_installer
updated_rules="$temp/updated-rules.md"
cp "$root/i-have-dyslexia.md" "$updated_rules"
printf '\n<!-- test-update -->\n' >> "$updated_rules"
run_installer_from_source "$updated_rules" --update
grep -Fq '<!-- test-update -->' "$project/.i-have-dyslexia.md"

printf '\n<!-- local change -->\n' >> "$project/.i-have-dyslexia.md"
run_installer --update
grep -Fq '<!-- local change -->' "$project/.i-have-dyslexia.md"
run_installer --uninstall
[ -f "$project/.i-have-dyslexia.md" ]
[ ! -f "$project/.i-have-dyslexia.state" ]
! grep -Fq 'i-have-dyslexia:managed' "$project/AGENTS.md"

printf '\n<!-- i-have-dyslexia:managed:start -->\nuser tail\n' >> "$project/AGENTS.md"
if run_installer --update; then
  echo "malformed managed block was not rejected" >&2
  exit 1
fi
grep -Fq 'user tail' "$project/AGENTS.md"
