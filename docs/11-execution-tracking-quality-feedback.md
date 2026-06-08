# Execution Tracking Quality Feedback

Use this standard at the end of each task and whenever feedback arrives.

## Execution Tracking

Every task should leave a trace in `dev-logs/YYYY-MM-DD.md`.

Record:

- task name
- current phase
- changed files
- commands or checks run
- command results
- skipped checks and reasons
- blockers
- next action
- latest Git checkpoint, when available

## Quality Grading

Assign one grade before handoff:

- `A`: Requirements met, relevant checks passed, no known blocking issues.
- `B`: Requirements mostly met, minor known issues or skipped low-risk checks recorded.
- `C`: Partial completion, important checks missing, or notable risk remains.
- `Blocked`: Cannot safely proceed without user input, missing environment, failing dependency, or unresolved critical issue.

Do not grade `A` when tests, build, or required manual verification were skipped without a strong reason.

## Anomaly Detection

Flag anomalies when any of these occur:

- same failure repeats
- command times out
- generated output is unexpectedly missing
- Git diff contains unrelated changes
- tests pass but visible behavior is broken
- UI has overlap, clipping, unreadable text, or broken responsive layout
- requirements are ambiguous after implementation starts
- a tool, dependency, or API behaves differently than expected
- verification was skipped

For each anomaly, record:

- what happened
- likely cause
- affected files or commands
- recovery action

## Feedback Attribution

When the user, evaluator, tests, or review identifies a problem, attribute it to one primary source:

- requirement gap
- planning gap
- implementation bug
- design issue
- verification gap
- tooling or environment issue
- Agent rule gap

Then record:

- feedback summary
- attributed cause
- fix applied or next action
- whether `AGENT.nd` needs a new prevention rule

If the same Agent rule gap repeats, update `AGENT.nd` with an actionable prevention rule.
