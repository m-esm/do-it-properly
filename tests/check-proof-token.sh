#!/usr/bin/env bash
# Exit 0 iff Y after `proven by` is a SHA, existing path, or URL.
set -euo pipefail

fail() { echo "FAIL: $*" >&2; exit 1; }

[[ $# -eq 1 ]] || fail "usage: $0 FILE"
[[ -f "$1" && -r "$1" ]] || fail "unreadable file: $1"

grep -q 'proven by' "$1" || fail "missing 'proven by'"

y=$(awk 'match($0, /proven by[[:space:]]+/) { print substr($0, RSTART + RLENGTH); exit }' "$1")
y=${y%%;*}
y=${y//\`/}
y="${y#"${y%%[![:space:]]*}"}"
y="${y%"${y##*[![:space:]]}"}"
[[ -n "$y" ]] || fail "empty Y after proven by"

if [[ "$y" =~ ^[0-9a-fA-F]{7,40}$ ]]; then
  echo "ok: proof token is SHA in $1"
  exit 0
fi
if [[ "$y" =~ ^https?:// ]]; then
  echo "ok: proof token is URL in $1"
  exit 0
fi
if [[ -e "$y" ]]; then
  echo "ok: proof token is path in $1"
  exit 0
fi
fail "Y is not a SHA, existing path, or URL: $y"
