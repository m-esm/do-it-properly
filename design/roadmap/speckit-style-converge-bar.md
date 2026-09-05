---
state: building
lens: outside-in
created: 2026-09-03
metric: in-repo scripts named check-run-bar.sh that exit 0/1 on whether a run named a checkable bar
before: 0 (2026-09-04; python count of check-run-bar.sh in tree)
target: 1
measure: python3 -c "from pathlib import Path; r=Path('.'); print(sum(1 for p in r.rglob('*') if p.is_file() and '.git' not in p.parts and p.name=='check-run-bar.sh'))"
evidence:
  - design/roadmap/evidence/2026-09-04-speckit-converge.png
  - design/roadmap/evidence/2026-09-04-speckit-converge-extract.txt
slices: 1/3
after:
---
# Spec Kit-style converge for the named bar

## Why, against GOAL.md

GOAL.md number 2 is the fraction of skill-loading cron `## Response` blocks that contain `done =` and `proven by` (target 90%). Measured this tick against jobs with `skill: do-it-properly`: 5 of 59 runs (8.5%), mostly because `pawl-work-retro` is 1/50. GitHub Spec Kit's comparable agent-contract product ends the chain with `/speckit.converge`, which reports **Converged** or appends remaining work — Done is a command result. uiwalk 2026-09-04 is `design/roadmap/evidence/2026-09-04-speckit-converge.png`. This repo's `tests/check-contract.sh` only lints SKILL.md. The measure command prints 0. Without a converge-style check on the run, the bar is optional self-report, so number 2 cannot move.

## What better looks like

Spec Kit: run `/speckit.converge`; either ✅ Converged or more tasks. do-it-properly: `bash tests/check-run-bar.sh RUN.md` exits 0 iff the text has `done =` and `proven by`. Not a Spec Kit port, not TDD, not an orchestrator. `check-contract.sh` stays the SKILL.md gate.

## Slices

- [x] `tests/check-run-bar.sh` plus pass/fail fixtures; measure command prints 1.
- [ ] README Contract check names scoring a run, not only SKILL.md.
- [ ] SKILL.md Verification points at the script without crossing the 80-line cap.
