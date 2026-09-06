---
state: promoted
lens: journey
created: 2026-09-06
metric: in-repo scripts named score-run-bar-rate.sh that print hits/total for a directory of run files
before: 0 (2026-09-06; python count of score-run-bar-rate.sh in tree)
target: 1
measure: python3 -c "from pathlib import Path; r=Path('.'); print(sum(1 for p in r.rglob('*') if p.is_file() and '.git' not in p.parts and p.name=='score-run-bar-rate.sh'))"
evidence:
  - design/roadmap/evidence/2026-09-06-gh-actions-run-history.png
  - design/roadmap/evidence/2026-09-06-skill-run-bar-rate.txt
slices: 0/3
after:
---
# Fleet score for the named-bar rate

## Why, against GOAL.md

GOAL.md number 2 is the fraction of skill-loading cron `## Response` blocks that contain `done =` and `proven by` (target 90%). Measured this tick: 82 of 206 runs (39.8%). A person cannot complete that path in-repo: `tests/check-run-bar.sh` scores one FILE and exits 0/1; there is no command that prints hits/total over a directory. GitHub Actions' comparable journey is the All workflows list: 2,500+ runs with a pass/fail mark on each row, no log open (`design/roadmap/evidence/2026-09-06-gh-actions-run-history.png`). Query dump: `design/roadmap/evidence/2026-09-06-skill-run-bar-rate.txt`. The measure command prints 0.

## What better looks like

GitHub: open Actions, see run outcomes in a list. do-it-properly: `bash tests/score-run-bar-rate.sh DIR` prints `hits/total pct`. Not an orchestrator, not TDD, not a Spec Kit port. `check-run-bar.sh` stays the per-run gate. `check-contract.sh` stays the SKILL.md gate.

## Slices

- [ ] `tests/score-run-bar-rate.sh` plus a small mixed fixture dir; measure command prints 1.
- [ ] README Contract check names scoring a directory of runs, not only one FILE.
- [ ] SKILL.md Verification points at the rate script without crossing the 80-line cap.
