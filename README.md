# do-it-properly

A load-signal skill. When you tell an agent **do it properly**, it names the bar for *this* task and meets that bar. It does not switch into ceremonial engineering.

Not a new orchestrator. Not a rewrite of [smart-subagents](https://github.com/m-esm/smart-subagents). Not "write unit tests and e2e."

## What it means

The agent states one sentence:

`done = X, proven by Y; not required: Z.`

Y is the cheapest *observable* evidence for the failure that would actually matter. Existing repo gates win. A new test is allowed only when nothing extant can catch a silent, high-blast-radius failure.

**Illegal unless that rule demands it:** unsolicited unit tests, e2e, TDD, review theater, always-fan-out, process ledgers.

## Examples (not a lookup table)

| Ask | Bar |
|---|---|
| CAD part | View loop. Not pytest. |
| Telegram send | Right topic, confirm if it leaves the machine. |
| One-line bug with coverage | Run the existing test. |
| Data loss / money / novel concurrency | Repro first, then the fix. |
| Mechanical rename | One worker, no panel, no new tests. |

## Trigger

Counts: `do it properly`, `do this properly`, `do it right`, `properly this time`, `the proper way`, `can you do this properly?`

Does not count: `properly escaped`, `was this done properly?`, quotes, hypotheticals, `make it clean`.

Stand-down: `quick and dirty is fine`.

## Install

Clone (or submodule) the repository into a skill directory your agent already reads. For example:

```bash
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

Optional backstop in a global `AGENTS.md` the CLI actually loads:

```
On "do it properly", read $HOME/.claude/skills/do-it-properly/SKILL.md.
Proof = the named bar, not a new test unless that bar or an explicit repo rule requires it.
```

Installation at a conventional path is not proof that a loader used the skill. This repository claims no cross-CLI behavioral coverage. Verify a loader in a fresh session with a positive phrase and a negative phrase before describing it as supported.

### Rollback

Remove the symlink or pointer. The clone can stay. `git submodule deinit` if you added it that way.

## Ownership

| Concern | Owner |
|---|---|
| Trigger, bar, routing, done | this skill |
| Quota, worktree, dispatch, verify, plan panel | live smart-subagents |
| How to survey options, CGC, commit/PR | the active repo/user instructions |
| TDD / review / e2e walkthroughs | those skills, loaded only when the bar needs them |

## Contract check

```bash
bash tests/check-contract.sh
```

Checks that the description is at most 60 characters and contains the trigger in its first 57 characters. It also checks the SKILL.md line limit, the Procedure step count, the ceremony sentence, machine-local home-directory leaks across the public tree, and copied SSA agent paths. It does not prove that an agent or CLI will follow the skill.

## License

MIT. Copyright 2026 Mohsen Esmaeili.
