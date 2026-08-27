---
name: do-it-properly
description: "Default: do it properly. Meet this task's real bar."
version: 0.1.0
author: Mohsen Esmaeili (m-esm), Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [engineering, judgment, context-bar]
---

# do-it-properly

Default contract. Name the bar that makes *this* task done in *this* context, then meet it. Nothing more. It is not full-engineering mode, TDD, e2e, or a process ledger. The phrase is a reminder, not a prerequisite.

When routing, use live root `$HOME/.claude/vendor/smart-subagents`; invoke `scripts/smart-subagents.sh` there; never copy it.

## When to Use

Load at the start of every task. Do not wait for `do it properly`. That phrase, and polite forms, are reminders. Stand-down (`quick and dirty is fine`) → one-line ack, then drop this skill for that request only.

## Bar

- Name the requested outcome and the most plausible consequential failure.
- Use any explicit user, repo, or domain gate that already detects that failure.
- Otherwise pick the cheapest observable evidence for that risk. A **new** test exists only when it *is* that evidence, and only if failure would be silent with real blast radius.

State once: `done = X, proven by Y; not required: Z.` A bar of nothing is illegal. Y must be observable.

Real example, 3dvp [PR #14](https://github.com/m-esm/3d-vibing-platform/pull/14): `done = /admin/users does list/search/create/set-role/ban/unban plus memberships with last-admin and self guards, proven by verify_admin_users + verify_acl + verify_acl_routes; not required: S1, impersonation, SMTP.`

Real example, 3dvp [PR #12](https://github.com/m-esm/3d-vibing-platform/pull/12): `done = 3DVP mark in nav/login/signup/create-progress and a left-aligned Queued→Ready stage track, proven by verify_create_progress + verify_acl + verify_acl_routes; not required: new tokens, CAD.`

**Ceremony is illegal** unless this rule demands it: unsolicited unit tests, e2e, TDD, review theater, always-panel, always-fanout, artifact ledgers.

Prove-then-fix means bar-relevant evidence, not write a test. An explicit repo gate (CI, lint, mandated regression) stays part of the bar. This skill does not override AGENTS.md; it defines what proof is.

## Procedure

1. **Bar.** One sentence: done / proven by / not required.
2. **Route only if needed.**
   - Survey only on a real fork. Plan panel only on consequential multi-shape design.
   - Quota check only if a panel or dispatch is actually on the table (run `python3 scripts/ai-cli-usage.py` from the live root; honor `remaining_pct`; never redeem Codex banked resets).
   - One worker default. In-session for small, non-isolable, live-steering, or dirty mid-task work. Never Hermes `delegate_task` as a substitute; invoke `scripts/smart-subagents.sh` for isolable labor.
3. **Do the smallest reversible change.** Pre-change repro only when the bar needs it. Mid-task: stop at the next safe boundary; do not discard dirty work; do not silently move it into a new worktree.
4. **Verify Y, then stop.** Working result or one named blocker. Unused gates stay silent. No skip-justification paragraphs.

## Pitfalls

- Loading this skill and then writing tests you were not asked for.
- Copying SSA procedure text into this file or a session essay.
- Advertising coverage for a CLI that never loaded this file.

## Verification

The bar sentence named X/Y/Z. The done message shows Y, or one blocker. You did not add gates after the fact to look thorough.
