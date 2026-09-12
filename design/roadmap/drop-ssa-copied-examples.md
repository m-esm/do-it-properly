---
state: killed
lens: subtraction
created: 2026-09-11
metric: examples/*.md files whose names contain cgc or ssa
before: 6 (2026-09-11; python count of examples/*.md with cgc or ssa in the name)
target: 0
measure: python3 -c "from pathlib import Path; r=Path('examples'); print(sum(1 for p in r.glob('*.md') if p.is_file() and ('cgc' in p.name or 'ssa' in p.name)))"
evidence:
  - design/roadmap/evidence/2026-09-11-ssa-copied-examples.txt
  - design/roadmap/evidence/2026-09-11-speckit-persistence.png
  - design/roadmap/evidence/2026-09-11-speckit-persistence-extract.txt
  - design/roadmap/evidence/2026-09-11-langchain-delete-examples.txt
slices: 0/2
after:
---
# Drop SSA-copied examples

## Why, against GOAL.md

GOAL.md number 3 is the fraction of stated bars whose Y is a SHA, a path that exists, or a URL (target 90%). The published set of stated bars in this repo is `examples/`. Measured this tick: 0 of 7 pass `tests/check-proof-token.sh`. 6 of those 7 are copies of smart-subagents dispatch/verify (CGC-SKIP route tables, chmod-000 brief.md), which GOAL.md says this skill is explicitly not. Query: `design/roadmap/evidence/2026-09-11-ssa-copied-examples.txt`. Spec Kit's comparable is living spec: derived `plan.md`/`tasks.md` are disposable, and Spec-first allows the artifact to be discarded (`design/roadmap/evidence/2026-09-11-speckit-persistence.png`, extract `design/roadmap/evidence/2026-09-11-speckit-persistence-extract.txt`). LangChain's comparable identity is DELETE `/api/v1/examples` — gone from the scored set (`design/roadmap/evidence/2026-09-11-langchain-delete-examples.txt`). The measure command prints 6.

## What better looks like

Spec Kit: discard derived artifacts; the contract file stays. LangChain: DELETE the example_ids. do-it-properly: `examples/` has zero files named with `cgc` or `ssa`. `examples/bar-3dvp-admin-users.md` stays. `check-contract.sh` no longer requires `examples/bar-cgc-route-invalid.md`. Not an orchestrator, not TDD, not a new scorer. The remaining 3dvp example still fails proof-token (`Y=verify_admin_users`); that is not this deletion.

## Slices

- [ ] Delete the six `examples/*.md` whose names contain `cgc` or `ssa`; measure command prints 0.
- [ ] Drop the `check-contract.sh` requirement that `examples/bar-cgc-route-invalid.md` exists (and the leftover per-route scan that only guarded those files). No README.
