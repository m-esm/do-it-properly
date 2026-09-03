# GOAL (draft by Pawl 2026-09-03, edit freely)

For a solo developer running Claude Code, Hermes and CLI agents, so that every agent session names a real bar for done (`done = X, proven by Y; not required: Z`) with a Y someone can check, instead of defaulting to sloppy output or to unsolicited test, e2e and review ceremony. Done means a run that loaded this skill ends with that bar and the evidence it names. It is explicitly NOT an orchestrator, not a TDD or e2e mandate, and not a copy of smart-subagents' dispatch and verify logic.

## Numbers that prove it
- contract: `bash tests/check-contract.sh` - today: pass; target: pass on every commit
- runs that state a checkable bar: fraction of `~/.hermes/cron/output/*/*.md` from jobs that load this skill whose `## Response` contains `done =` and `proven by` - today: unknown; target: 90%
- bars whose proof token is verifiable (a SHA on a remote, a path that exists, a URL) rather than a pasted grep - today: unknown; target: 90% of stated bars

source: SKILL.md, README.md, tests/check-contract.sh, examples/bar-3dvp-admin-users.md
