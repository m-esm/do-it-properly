#!/usr/bin/env bash
# Objective loader-contract checks. Does not prove agent behavior.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL="$ROOT/SKILL.md"

fail() { echo "FAIL: $*" >&2; exit 1; }

# Done=paste is not a legal proof kind. Only the negative fixture may contain it.
no_legal_paste() {
  ! grep -E -q 'Done=[[:space:]]*paste' "$1"
}

# Done=look (rendered artifact + sentence after looking) is required for product channels.
look_token_ok() {
  local skill="$1"
  grep -E -q 'Done=[[:space:]]*look' "$skill" \
    && grep -qi 'rendered artifact' "$skill" \
    && grep -qi 'sentence after looking' "$skill" \
    && grep -q '#3dvp' "$skill" \
    && grep -q '#bet' "$skill" \
    && grep -q '#mechlib' "$skill" \
    && grep -q '#onlydash' "$skill"
}

if [[ "${1:-}" == "--skill" ]]; then
  [[ -n "${2:-}" && -f "$2" ]] || fail "usage: $0 --skill PATH"
  no_legal_paste "$2" || fail "SKILL.md still presents Done=paste as a legal proof kind"
  look_token_ok "$2" || fail "SKILL.md Proof token has no Done=look (rendered artifact + sentence after looking) for #3dvp/#bet/#mechlib/#onlydash"
  echo "ok: no legal Done=paste and look token present in $2"
  exit 0
fi

[[ -f "$SKILL" ]] || fail "missing SKILL.md"
[[ -f "$ROOT/README.md" ]] || fail "missing README.md"
[[ -f "$ROOT/LICENSE" ]] || fail "missing LICENSE"
head -1 "$ROOT/LICENSE" | grep -qx -- 'MIT License' || fail "LICENSE must start with MIT License"

head -1 "$SKILL" | grep -qx -- '---' || fail "SKILL.md must start with ---"

metrics="$(python3 - "$ROOT" <<'PY'
import json
import os
from pathlib import Path
import re
import sys

root = Path(sys.argv[1])
skill = root / "SKILL.md"
text = skill.read_text(encoding="utf-8")


def fail(message):
    print(f"FAIL: {message}", file=sys.stderr)
    raise SystemExit(1)


skill_lines = text.splitlines()
try:
    frontmatter_end = skill_lines.index("---", 1)
except ValueError:
    fail("SKILL.md frontmatter is not closed")

description_lines = [
    line for line in skill_lines[1:frontmatter_end]
    if re.match(r"^description\s*:", line)
]
if len(description_lines) != 1:
    fail(f"frontmatter has {len(description_lines)} description fields (need exactly 1)")

raw_description = description_lines[0].split(":", 1)[1].strip()
try:
    description = json.loads(raw_description) if raw_description.startswith('"') else raw_description
except (json.JSONDecodeError, TypeError):
    fail("could not parse description")
if not isinstance(description, str) or not description:
    fail("description must be non-empty text")

description_length = len(description)
if description_length > 60:
    fail(f"description is {description_length} chars (max 60)")
trigger = "do it properly"
if trigger not in description.casefold():
    fail("trigger phrase missing from description")
if trigger not in description[:57].casefold():
    fail("trigger phrase not inside first 57 chars")

line_count = len(skill_lines)
if line_count > 80:
    fail(f"SKILL.md is {line_count} lines (max 80)")

try:
    procedure_start = skill_lines.index("## Procedure") + 1
except ValueError:
    fail("missing Procedure section")
procedure_end = next(
    (index for index in range(procedure_start, len(skill_lines))
     if skill_lines[index].startswith("## ")),
    len(skill_lines),
)
step_numbers = [
    int(match.group(1))
    for line in skill_lines[procedure_start:procedure_end]
    if (match := re.match(r"^(\d+)\.\s+", line))
]
step_count = len(step_numbers)
if not 3 <= step_count <= 5:
    fail(f"procedure has {step_count} numbered steps (need 3 to 5)")
if step_numbers != list(range(1, step_count + 1)):
    fail("procedure steps must be numbered consecutively from 1")

ceremony_sentence = "Ceremony is illegal unless this rule demands it:"
if ceremony_sentence not in text.replace("**", ""):
    fail("missing ceremony sentence")

contract_script = (root / "tests/check-contract.sh").resolve()
for path in root.rglob("*"):
    if ".git" in path.parts or path.resolve() == contract_script:
        continue
    if path.is_symlink():
        if b"/Users/" in os.fsencode(os.readlink(path)):
            fail(f"machine-local /Users/ path in {path.relative_to(root)}")
        continue
    if not path.is_file():
        continue
    if b"/Users/" in path.read_bytes():
        fail(f"machine-local /Users/ path in {path.relative_to(root)}")

print(description_length, line_count, step_count)
PY
)" || fail "contract validation failed"
read -r n lines steps <<< "$metrics"
if grep -R --exclude-dir=.git --exclude='check-contract.sh' -n 'vendor/smart-subagents/agents' "$ROOT"; then
  fail "SSA agent file path copied into the tree"
else
  grep_status=$?
  [[ $grep_status -eq 1 ]] || fail "SSA agent file path scan failed (grep exit $grep_status)"
fi

grep -q 'done = X, proven by Y' "$SKILL" || fail "missing bar sentence"

no_legal_paste "$SKILL" || fail "SKILL.md still presents Done=paste as a legal proof kind"
fixture="$ROOT/tests/fixtures/done-paste-for-3dvp.md"
[[ -f "$fixture" ]] || fail "missing fixture tests/fixtures/done-paste-for-3dvp.md"
grep -E -q 'Done=[[:space:]]*paste' "$fixture" || fail "negative fixture must contain Done=paste"
if no_legal_paste "$fixture"; then
  fail "fixture that names Done=paste as legal must fail the no-paste check"
fi
if grep -R --exclude-dir=.git --exclude='check-contract.sh' --exclude='done-paste-for-3dvp.md' -E -n 'Done=[[:space:]]*paste' "$ROOT"; then
  fail "Done=paste appears outside the negative fixture"
fi

look_token_ok "$SKILL" || fail "SKILL.md Proof token has no Done=look (rendered artifact + sentence after looking) for #3dvp/#bet/#mechlib/#onlydash"
no_look="$ROOT/tests/fixtures/no-look-token.md"
[[ -f "$no_look" ]] || fail "missing fixture tests/fixtures/no-look-token.md"
if look_token_ok "$no_look"; then
  fail "fixture with no Done=look token must fail the look-token check"
fi

generic_illegal="$ROOT/examples/bar-cgc-route-invalid.md"
[[ -f "$generic_illegal" ]] || fail "missing generic illegal CGC-SKIP example (examples/bar-cgc-route-invalid.md)"
per_route=()
shopt -s nullglob
for f in "$ROOT"/examples/bar-cgc-route-*.md; do
  base="$(basename "$f")"
  case "$base" in
    bar-cgc-route-invalid.md|bar-cgc-route-none.md) ;;
    *) per_route+=("$base") ;;
  esac
done
shopt -u nullglob
if ((${#per_route[@]})); then
  fail "examples/ still enumerates per-route illegal CGC-SKIP files: ${per_route[*]} (one generic file covers every remaining illegal route)"
fi

echo "ok: description=$n chars, SKILL.md=$lines lines, steps=$steps"
