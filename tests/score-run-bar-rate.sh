#!/usr/bin/env bash
# Print hits/total and the integer percentage for regular files in DIR.
set -euo pipefail

fail() { echo "FAIL: $*" >&2; exit 1; }

[[ $# -eq 1 ]] || fail "usage: $0 DIR"
[[ -d "$1" ]] || fail "missing directory: $1"

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
checker="$script_dir/check-run-bar.sh"
hits=0
total=0

while IFS= read -r -d '' file; do
  ((total += 1))
  if "$checker" "$file" >/dev/null 2>&1; then
    ((hits += 1))
  fi
done < <(find "$1" -mindepth 1 -maxdepth 1 -type f -print0)

pct=0
if ((total > 0)); then
  pct=$((hits * 100 / total))
fi

echo "$hits/$total $pct"
