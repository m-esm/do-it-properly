#!/usr/bin/env bash
# Objective loader-contract checks. Does not prove agent behavior.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL="$ROOT/SKILL.md"

fail() { echo "FAIL: $*" >&2; exit 1; }

[[ -f "$SKILL" ]] || fail "missing SKILL.md"
[[ -f "$ROOT/README.md" ]] || fail "missing README.md"
[[ -f "$ROOT/LICENSE" ]] || fail "missing LICENSE"

head -1 "$SKILL" | grep -qx -- '---' || fail "SKILL.md must start with ---"

desc="$(python3 - "$SKILL" <<'PY'
import re, sys
text = open(sys.argv[1], encoding="utf-8").read()
m = re.search(r"^description:\s*(.*)$", text, re.M)
if not m:
    raise SystemExit("no description")
raw = m.group(1).strip()
if raw.startswith('"') and raw.endswith('"'):
    desc = bytes(raw[1:-1], "utf-8").decode("unicode_escape")
else:
    desc = raw
print(desc)
PY
)" || fail "could not parse description"

n="${#desc}"
(( n <= 60 )) || fail "description is $n chars (max 60)"
printf '%s' "$desc" | grep -qi 'do it properly' || fail "trigger phrase missing from description"
window="${desc:0:57}"
printf '%s' "$window" | grep -qi 'do it properly' || fail "trigger phrase not inside first 57 chars"

lines="$(wc -l < "$SKILL" | tr -d ' ')"
(( lines <= 80 )) || fail "SKILL.md is $lines lines (max 80)"

if grep -q '/Users/' "$SKILL" "$ROOT/README.md"; then
  fail "machine-local /Users/ path"
fi
if grep -R --exclude-dir=.git --exclude='check-contract.sh' -n 'vendor/smart-subagents/agents' "$ROOT"; then
  fail "SSA agent file path copied into the tree"
fi

grep -q 'Ceremony is illegal' "$SKILL" || fail "missing ceremony prohibition"
grep -q 'done = X, proven by Y' "$SKILL" || fail "missing bar sentence"

steps="$(grep -cE '^[0-9]+\. \*\*' "$SKILL" || true)"
(( steps <= 5 )) || fail "procedure has $steps numbered steps (max 5)"
(( steps >= 3 )) || fail "procedure has $steps numbered steps (need at least 3)"

echo "ok: description=$n chars, SKILL.md=$lines lines, steps=$steps"
