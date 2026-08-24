#!/usr/bin/env bash
# Objective loader-contract checks. Does not prove agent behavior.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILL="$ROOT/SKILL.md"

fail() { echo "FAIL: $*" >&2; exit 1; }

[[ -f "$SKILL" ]] || fail "missing SKILL.md"
[[ -f "$ROOT/README.md" ]] || fail "missing README.md"
[[ -f "$ROOT/LICENSE" ]] || fail "missing LICENSE"
head -1 "$ROOT/LICENSE" | grep -qx -- 'MIT License' || fail "LICENSE must start with MIT License"

head -1 "$SKILL" | grep -qx -- '---' || fail "SKILL.md must start with ---"

metrics="$(python3 - "$ROOT" <<'PY'
import json
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
    if not path.is_file() or ".git" in path.parts or path.resolve() == contract_script:
        continue
    if b"/Users/" in path.read_bytes():
        fail(f"machine-local /Users/ path in {path.relative_to(root)}")

print(description_length, line_count, step_count)
PY
)" || fail "contract validation failed"
read -r n lines steps <<< "$metrics"
if grep -R --exclude-dir=.git --exclude='check-contract.sh' -n 'vendor/smart-subagents/agents' "$ROOT"; then
  fail "SSA agent file path copied into the tree"
fi

grep -q 'done = X, proven by Y' "$SKILL" || fail "missing bar sentence"

echo "ok: description=$n chars, SKILL.md=$lines lines, steps=$steps"
