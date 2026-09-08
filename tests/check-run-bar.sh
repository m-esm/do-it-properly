#!/usr/bin/env bash
# Score the ## Response body when present, otherwise the whole FILE.
set -euo pipefail

fail() { echo "FAIL: $*" >&2; exit 1; }

[[ $# -eq 1 ]] || fail "usage: $0 FILE"
[[ -f "$1" && -r "$1" ]] || fail "unreadable file: $1"

if grep -q '^## Response[[:space:]]*$' "$1"; then
  body=$(sed '1,/^## Response[[:space:]]*$/d' "$1")
else
  body=$(cat "$1")
fi

grep -q 'done =' <<< "$body" || fail "missing 'done ='"
grep -q 'proven by' <<< "$body" || fail "missing 'proven by'"
echo "ok: run bar present in $1"
