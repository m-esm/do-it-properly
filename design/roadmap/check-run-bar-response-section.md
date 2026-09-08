---
state: promoted
lens: telemetry
created: 2026-09-07
metric: check-run-bar.sh files that mention ## Response so they score the run body not the Prompt-embedded skill
before: 0 (2026-09-07; python int(Path('tests/check-run-bar.sh').read_text() contains '## Response'))
target: 1
measure: python3 -c "from pathlib import Path; p=Path('tests/check-run-bar.sh'); print(int(p.is_file() and '## Response' in p.read_text()))"
evidence:
  - design/roadmap/evidence/2026-09-07-check-run-bar-prompt-false-positives.txt
  - design/roadmap/evidence/2026-09-07-github-commits-sha-field.txt
slices: 2
---
# Score the ## Response, not the Prompt-embedded skill

## Why, against GOAL.md

GOAL.md number 2 is the fraction of skill-loading cron `## Response` blocks that contain `done =` and `proven by` (target 90%). The in-repo gate `tests/check-run-bar.sh` greps the whole FILE. Measured this tick: 175 of 230 skill-loading dumps pass that grep, but only 110 have both strings in `## Response` (65 false positives). All 9 `[SILENT]` Responses still print `ok: run bar present` because the Prompt embeds SKILL.md. Query: `design/roadmap/evidence/2026-09-07-check-run-bar-prompt-false-positives.txt`. GitHub's comparable identity is the commits JSON `sha` field, not a substring grep of the docs page (`design/roadmap/evidence/2026-09-07-github-commits-sha-field.txt`). The measure command prints 0.

## What better looks like

GitHub: the commit is the `sha` field. do-it-properly: `bash tests/check-run-bar.sh FILE` exits 0 iff `## Response` (or the whole file when that header is absent, so tiny fixtures still work) contains `done =` and `proven by`. Prompt-only matches fail. Not an orchestrator, not TDD, not a fleet scorer. `score-run-bar-rate.sh` stays the directory printer. `check-contract.sh` stays the SKILL.md gate.

## Slices

- [ ] `check-run-bar.sh` scores `## Response` when present; fixture is Prompt-with-skill + `[SILENT]` Response (must fail); measure command prints 1.
- [ ] SKILL.md Verification notes the gate is the Response body, without crossing the 80-line cap. No README.
