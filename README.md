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

Canonical clone (or submodule) the repo into the skill directory your agent already reads.

```bash
git clone https://github.com/m-esm/do-it-properly.git \
  "$HOME/.claude/skills/do-it-properly"
```

Then point other agents at that same checkout. Prefer a symlink. If a loader ignores symlinks, a 3-line pointer file that says "read the canonical SKILL.md" is allowed. Do not copy the procedure.

| Agent | Typical path |
|---|---|
| Claude Code | `$HOME/.claude/skills/do-it-properly` |
| Hermes | `$HOME/.hermes/skills/software-development/do-it-properly` → symlink |
| Codex | `$HOME/.codex/skills/do-it-properly` → symlink |
| Grok | `$HOME/.grok/skills/do-it-properly` → symlink |
| Kimi | No global skill loader found. Unsupported until one exists. |

Optional backstop in a global `AGENTS.md` the CLI actually loads:

```
On "do it properly", read $HOME/.claude/skills/do-it-properly/SKILL.md.
Proof = the named bar, not a new test unless that bar or an explicit repo rule requires it.
```

Do not claim a CLI is supported until a fresh session loads the skill on a positive phrase and ignores a negative one.

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

Guards frontmatter length, trigger window, no machine-local paths, no vendored SSA tree. It does not prove an agent will follow the skill.

## License

MIT. Copyright 2026 Mohsen Esmaeili.
