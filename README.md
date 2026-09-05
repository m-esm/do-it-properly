# do-it-properly

A default session contract. The agent names the bar for *this* task and meets it, without waiting for a phrase. It does not switch into ceremonial engineering.

Not a new orchestrator. Not a rewrite of [smart-subagents](https://github.com/m-esm/smart-subagents). Not "write unit tests and e2e."

## What it means

The agent states one sentence:

`done = X, proven by Y; not required: Z.`

Y is the cheapest *observable* evidence for the failure that would actually matter. Existing repo gates win. A new test is allowed only when nothing extant can catch a silent, high-blast-radius failure.

**Ceremony is illegal** unless this rule demands it: unsolicited unit tests, e2e, TDD, review theater, always-panel, always-fanout, artifact ledgers.

## Examples (not a lookup table)

| Ask | Bar |
|---|---|
| CAD part | View loop. Not pytest. |
| Telegram send | Right topic, confirm if it leaves the machine. |
| One-line bug with coverage | Run the existing test. |
| Data loss / money / novel concurrency | Repro first, then the fix. |
| Mechanical rename | One worker, no panel, no new tests. |

## Default

Always on. Load `SKILL.md` at the start of work. The phrase is a reminder, not a gate.

Stand-down: `quick and dirty is fine`.

## Install

Clone (or submodule) the repository into a skill directory your agent already reads. For example:

```bash
mkdir -p "$HOME/.claude/skills"
git clone https://github.com/m-esm/do-it-properly.git \
  "$HOME/.claude/skills/do-it-properly"
```

To share one checkout between agents, prefer symlinks. If a loader ignores symlinks, a short pointer file that says "read the canonical SKILL.md" is allowed. Do not copy the procedure.

These are conventional locations, not claims of loader support. Confirm the path against the agent's current documentation.

| Agent | Conventional path |
|---|---|
| Claude Code | `$HOME/.claude/skills/do-it-properly` |
| Hermes | `$HOME/.hermes/skills/software-development/do-it-properly` → symlink |
| Codex | `$HOME/.codex/skills/do-it-properly` → symlink |
| Grok | `$HOME/.grok/skills/do-it-properly` → symlink |

Always-on backstop in a global `AGENTS.md` the CLI actually loads:

```
Always follow $HOME/.claude/skills/do-it-properly/SKILL.md.
Proof = the named bar, not a new test unless that bar or an explicit repo rule requires it.
Stand-down only if the user says quick and dirty is fine.
```

Installation at a conventional path is not proof that a loader used the skill. This repository claims no cross-CLI behavioral coverage. Before describing a loader as supported, verify in a fresh session that the agent names a bar without being asked.

### Rollback

Match rollback to the installation method: remove a symlink or pointer; for a direct clone, delete the checkout or move it outside the agent's skill directories. For a submodule, deinitialize it and remove the tracked submodule from the parent repository; `git submodule deinit` alone is not a complete uninstall.

## Ownership

| Concern | Owner |
|---|---|
| When to load, bar, routing, done | this skill |
| Quota, worktree, dispatch, verify, plan panel | live smart-subagents |
| How to survey options, CGC, commit/PR | the active repo/user instructions |
| TDD / review / e2e walkthroughs | those skills, loaded only when the bar needs them |

## Contract check

```bash
bash tests/check-contract.sh
```

Requires `README.md` and an MIT-licensed `LICENSE`, and checks that the SKILL.md frontmatter is closed. It also checks that the description is at most 60 characters and contains the trigger in its first 57 characters, the SKILL.md line limit, the Procedure step count, the ceremony sentence, machine-local macOS user-directory absolute paths in public files and symlink targets, and copied SSA agent paths. It does not prove that an agent or CLI will follow the skill.

Score a run (whether the text named a checkable bar), not only SKILL.md:

```bash
bash tests/check-run-bar.sh RUN.md
```

Exits 0 iff the file contains `done =` and `proven by`. `check-contract.sh` stays the SKILL.md gate.

## License

MIT. Copyright 2026 Mohsen Esmaeili.
