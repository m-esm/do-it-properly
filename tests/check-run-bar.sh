#!/usr/bin/env bash
# Exit 0 iff FILE text contains both `done =` and `proven by`.
set -euo pipefail

fail() { echo "FAIL: $*" >&2; exit 1; }

[[ $# -eq 1 ]] || fail "usage: $0 FILE"
[[ -f "$1" && -r "$1" ]] || fail "unreadable file: $1"

grep -q 'done =' "$1" || fail "missing 'done ='"
grep -q 'proven by' "$1" || fail "missing 'proven by'"
echo "ok: run bar present in $1"
