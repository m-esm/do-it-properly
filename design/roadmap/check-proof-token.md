---
state: promoted
lens: spec-gap
created: 2026-09-09
metric: in-repo scripts named check-proof-token.sh that exit 0/1 on whether Y after proven by is a SHA, existing path, or URL
before: 0 (2026-09-09; python count of check-proof-token.sh in tree)
target: 1
measure: python3 -c "from pathlib import Path; r=Path('.'); print(sum(1 for p in r.rglob('*') if p.is_file() and '.git' not in p.parts and p.name=='check-proof-token.sh'))"
evidence:
  - design/roadmap/evidence/2026-09-09-github-get-ref.png
  - design/roadmap/evidence/2026-09-09-github-get-ref-extract.txt
  - design/roadmap/evidence/2026-09-09-proof-token-gap.txt
slices: 0/3
after:
---
# Score the proof-token kind, not only the bar words

## Why, against GOAL.md

GOAL.md number 3 is the fraction of stated bars whose Y is a SHA on a remote, a path that exists, or a URL rather than a pasted grep (target 90%). Today that number is unknown. `tests/check-run-bar.sh` exits 0 on any Response that contains the strings `done =` and `proven by`, including `proven by the grep of SKILL.md above`. Query: `design/roadmap/evidence/2026-09-09-proof-token-gap.txt`. GitHub's comparable identity is Get a reference: `object.sha`, or 404 if the ref is missing — not a substring grep of the docs page (`design/roadmap/evidence/2026-09-09-github-get-ref.png`, extract `design/roadmap/evidence/2026-09-09-github-get-ref-extract.txt`). The measure command prints 0.

## What better looks like

GitHub: Get a reference returns `object.sha` or 404. do-it-properly: `bash tests/check-proof-token.sh FILE` exits 0 iff Y after `proven by` is a SHA, an existing path, or a URL. Pasted grep fails. Not an orchestrator, not TDD, not a fleet scorer. `check-run-bar.sh` stays the named-bar gate. `score-run-bar-rate.sh` stays the directory printer. `check-contract.sh` stays the SKILL.md gate.

## Slices

- [ ] `tests/check-proof-token.sh` plus fixtures (SHA pass, pasted-grep fail); measure command prints 1.
- [ ] README Contract check names scoring the proof-token kind, not only that a bar was named.
- [ ] SKILL.md Verification points at the script without crossing the 80-line cap.
