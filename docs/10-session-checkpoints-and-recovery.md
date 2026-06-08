# Session Checkpoints And Recovery

Use this standard to make work recoverable across stateless LLM sessions.

## Session Startup

Assume the model has no reliable memory.

At the start of every session:

1. Read `AGENT.nd`.
2. Read relevant `docs/` files.
3. Open today's `dev-logs/YYYY-MM-DD.md`.
4. Check Git state:

```powershell
git status
git branch --show-current
git log -1 --oneline
```

5. Locate active progress files:
   - feature checklist
   - TODO list
   - project requirements
   - project design spec
   - technical decisions

6. Identify:
   - last completed checkpoint
   - current unfinished task
   - changed files
   - checks already run
   - checks still pending

## Progress Tracking

Track work as a feature checklist and TODO list.

Recommended files:

- `docs/project-feature-checklist.md`
- `docs/project-todo.md`

Each feature checklist item should include:

- feature name
- status: pending / in progress / blocked / verified / done
- acceptance criteria
- verification method
- checkpoint commit, when available

Each TODO should be small enough to finish and verify independently.

## Git Checkpoints

Use Git commits as recovery snapshots.

Create a checkpoint after each coherent verified step:

```powershell
git status
git diff
git add <relevant-files>
git commit -m "checkpoint: concise description"
```

Rules:

- Commit only relevant files.
- Do not mix unrelated features.
- Do not commit broken code unless the commit message clearly marks it as a work-in-progress checkpoint and the project policy allows that.
- Prefer verified checkpoints over large unverified batches.
- Push checkpoints according to the GitHub update standard.

If the project cannot create Git commits, record the blocker and use the daily log as the temporary recovery record.

## Checkpoint Recovery

After failure, interruption, context loss, or tool timeout:

1. Read `AGENT.nd`.
2. Read today's development log.
3. Run:

```powershell
git status
git log --oneline -5
git diff
```

4. Compare current files to the latest checkpoint.
5. Read the feature checklist and TODO list.
6. Continue from the first unfinished item.

Do not restart from scratch when a usable checkpoint exists.

## Failure Notes

If a task fails:

- record the failed command or step
- record the observed error
- record files changed since last checkpoint
- record the next recovery action

Put this in `dev-logs/YYYY-MM-DD.md` before ending the session.

## Session Save And Resume Record

When a session is long, interrupted, near context limits, or handed off, preserve enough state for a stateless restart.

Record:

- what is being built and why
- confirmed working behavior with evidence
- failed approaches and exact reasons not to retry
- changed files and their current status
- decisions made and tradeoffs accepted
- blockers and open questions
- exact next step
- checks run and checks still pending

On resume, read the record before editing, summarize current state, and continue from the exact next step when it is still valid.

Do not store secrets, private conversation details, or raw sensitive code in session records. Store only the operational facts needed to continue safely.
