# Saved 2026-09-04 from Spec Kit Agentic SDD (uiwalk + web_extract)

Source: https://github.github.com/spec-kit/reference/agentic-sdd.html
Shot: design/roadmap/evidence/2026-09-04-speckit-converge.png (uiwalk desktop part 2, `/speckit.converge`)

Comparable product: GitHub Spec Kit. The last command in the agentic chain is `/speckit.converge`. Done is a command result, not a sentence the model applies to itself.

Quoted from the page (2026-09-04):

> `/speckit.converge`
> Assesses the codebase against the feature's spec, plan, and tasks to confirm nothing was missed. It is **append-only**: it never edits or deletes code, and its only possible write is adding tasks to `tasks.md`. Run it only after `/speckit.implement` has run on the current `tasks.md`.

Outcomes:

- **Converged** — no gaps found. `tasks.md` is left byte-for-byte unchanged and you'll see a clean result like ✅ Converged — the implementation satisfies the spec, plan, and tasks. You're done; proceed to review or open a PR.
- **Tasks appended** — gaps found. Converge appends them as new tasks under a Convergence section in `tasks.md` and tells you how many.

Chain shown in the docs: constitution → specify → clarify → plan → checklist → tasks → analyze → implement → **converge**.

do-it-properly counterpart today: `tests/check-contract.sh` lints SKILL.md. There is no `check-run-bar.sh`. A run that loaded the skill can omit `done =` / `proven by` and still look finished.
