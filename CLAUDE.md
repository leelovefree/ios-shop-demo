# ios-shop-demo — AI QA Automation Pipeline

This repo hosts two things: (1) the ShopDemo iOS app itself (`Sources/`, `Tests/`), the pilot app for
this framework, and (2) an AI-assisted QA automation pipeline built around it (this file, `.claude/`,
`specs/`, `tests/`, `reports/`, `.github/workflows/ci-regression.yml`). Full design spec:
`ios-qa-automation-requirements.md` — read it before working on any pipeline stage.

## Two different "tests" concepts — do not confuse them

- `.maestro/` at repo root — 4 hand-written, informal smoke-test flows for the demo app
  (`login_success.yaml`, `login_failure.yaml`, `browse_add_to_cart.yaml`, `checkout_happy_path.yaml`).
  Pre-dates this pipeline. **Never migrate, delete, or write into this folder from any pipeline stage.**
- `qa-tests/<module>/<feature>/CASES.md` + co-located `<case-id>.yaml` — the pipeline's own permanent
  test artifacts, one pair per requirement ID, written by Stage 3/4 and reviewed via PR. Empty until
  the first ticket runs through the pipeline (Phase 2). Named `qa-tests/` rather than the spec doc's
  `tests/` because this repo already has a `Tests/` folder (Xcode's unit test target) and macOS's
  case-insensitive filesystem would otherwise collide the two — see `qa-tests/README.md`.

## Non-negotiable principles

1. AI never declares a fail as a pass — enforced in code, not in a prompt.
2. Ambiguity halts the pipeline and asks a human — never guess at a requirement.
3. Every autonomous step has a hard ceiling (attempts, actions, or time) — no unbounded loops.
4. No code reaches `main` without explicit human PR approval — the agent's authority ends at "propose."
5. Every artifact (spec, test, diff, commit, report) is traceable to its ticket, model version, and cost.

## Repo layout (current state — Phase 1)

```
specs/<TICKET-ID>/spec.md, open-questions.md   # Stage 2 output — created per ticket, not ahead of time
qa-tests/<module>/<feature>/CASES.md + *.yaml  # Stage 3/4 output — empty until first ticket
reports/<TICKET-ID>/run-<timestamp>.md         # Stage 8 output — empty until first ticket, agent not built yet
.claude/agents/                                # spec-extractor.md, automation-writer.md (Phase 1 only)
.github/workflows/ci-regression.yml            # Stage 6 — zero AI calls, always
```

See `ios-qa-automation-requirements.md` Section 2 for the full target tree (includes `case-designer.md`,
`repair-agent.md`, `reviewer.md`, `reporter.md`, and module-level `tests/*/CLAUDE.md` — all deferred to
Phase 3).

## Stage → agent mapping

| Stage | Actor | Phase 1 status |
|---|---|---|
| 1. Intake | Human (Jira ticket) | n/a |
| 2. Parse & Clarify | `spec-extractor` agent | implemented |
| 3. Design cases | `automation-writer` agent (covers Stage 3 + 4 in Phase 1; splits into `case-designer` in Phase 3) | implemented |
| 4. Observe & Generate | `automation-writer` agent | implemented |
| 5. Commit & Review | Human (PR) | process only, no agent |
| 6. CI Regression | `.github/workflows/ci-regression.yml` — no AI | implemented |
| 7. Diagnose on failure | `repair-agent` (not yet built) | deferred to Phase 3 |
| 8. Report & Audit | `reporter` (not yet built) | deferred to Phase 3 |

## Hard guardrails (code-level, not prompt-level — do not weaken these)

Stage 6 — the CI runner's own pass/fail decision, not an LLM's opinion:
```js
// the real test runner decides — nothing upstream of this can override it
result.passed = results.every(r => r.status === "passed");
```
`maestro test` already behaves this way natively (deterministic exit code from real device state) —
this is why Stage 6 must stay "plain Maestro CLI, zero LLM calls."

Stage 7 — a repair-agent's own self-report is never trusted on its own (not yet active in Phase 1,
kept here so any future session touching repair logic sees it from day one):
```js
// even if the agent reports "approved: true", the gate below is what actually decides
if (!replay.passed) review.approved = false;
```

## Session discipline

One Claude Code session per pipeline stage. Do not run Stage 2 through Stage 4 in one continuous chat.
