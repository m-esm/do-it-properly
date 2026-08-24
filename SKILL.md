---
name: do-it-properly
description: "\"Do it properly\": meet this task's real bar, no theater."
version: 0.1.0
author: Mohsen Esmaeili (m-esm), Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [engineering, judgment, context-bar]
---

# do-it-properly

Saying **do it properly** means: name the bar that makes *this* task done in *this* context, then meet it. Nothing more. It is not full-engineering mode, TDD, e2e, or a process ledger.

Invoke live `$HOME/.claude/vendor/smart-subagents/scripts/smart-subagents.sh`; never copy it.

## When to Use

Load when the user gives a prospective instruction about *how this request should be done*: `do it properly`, `do this properly`, `do it right`, `properly this time`, `the proper way`, or a polite form (`can you do this properly?`). Don't use for: artifact adverbs (`properly escaped`), retrospectives (`was this done properly?`), quotes, hypotheticals, generic quality (`make it clean`). Ambiguous → one yes/no. Stand-down (`quick and dirty is fine`) → one-line ack, then drop this skill.

## Bar

1. Name the requested outcome and the most plausible consequential failure.
2. Use any explicit user, repo, or domain gate that already detects that failure.
3. Otherwise pick the cheapest observable evidence for that risk. A **new** test exists only when it *is* that evidence, and only if failure would be silent with real blast radius.

State once: `done = X, proven by Y; not required: Z.` A bar of nothing is illegal. Y must be observable.

**Ceremony is illegal** unless this rule demands it: unsolicited unit tests, e2e, TDD, review theater, always-panel, always-fanout, artifact ledgers.

Prove-then-fix means bar-relevant evidence, not write a test. An explicit repo gate (CI, lint, mandated regression) stays part of the bar. This skill does not override AGENTS.md; it defines what proof is.

## Procedure

1. **Bar.** One sentence: done / proven by / not required.
2. **Route only if needed.**
   - Survey only on a real fork. Plan panel only on consequential multi-shape design.
   - Quota check only if a panel or dispatch is actually on the table (`python3 $HOME/.claude/vendor/smart-subagents/scripts/ai-cli-usage.py`; honor `remaining_pct`; never redeem Codex banked resets).
   - One worker default. In-session for small, non-isolable, live-steering, or dirty mid-task work. Never Hermes `delegate_task` as a substitute; invoke live for isolable labor.
3. **Do the smallest reversible change.** Pre-change repro only when the bar needs it. Mid-task: stop at the next safe boundary; do not discard dirty work; do not silently move it into a new worktree.
4. **Verify Y, then stop.** Working result or one named blocker. Unused gates stay silent. No skip-justification paragraphs.

## Pitfalls

- Loading this skill and then writing tests you were not asked for.
- Copying SSA procedure text into this file or a session essay.
- Advertising coverage for a CLI that never loaded this file.

## Verification

The kickoff sentence named X/Y/Z. The done message shows Y, or one blocker. You did not add gates after the fact to look thorough.
