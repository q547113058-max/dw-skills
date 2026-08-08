---
name: dw-skills
description: Lightweight, risk-based development governance.
---

# DW Skills

Use this file as the sole DW execution entry. Load only the reference required by the task.

## Task Levels

- `quick` is the default for narrow, local, reversible work; do not announce it unless the risk changes execution.
- `standard` covers ordinary behavior changes, multi-file work, reversible data or integration changes, and required deterministic verification.
- `high-risk` covers authentication or authorization, secrets, payments, sensitive data, destructive migrations, production release, privileged or irreversible operations, public contract breaks, or significant recovery cost. State the level and reason when it changes execution.

## Conditional Gates

- Security: input boundaries, authentication, authorization, secrets, payments, privacy.
- Data: persistence, schema, migration, integrity, customer data.
- Deployment: CI, runtime configuration, infrastructure, release, rollback.
- External operations: GitHub, third-party services, and mutations.

Use `references/governance-gates.md` only when a gate or non-quick verification is actually triggered. Do not add heavyweight plans, reviews, E2E, rollback drills, logs, checkpoints, or orchestration without a real trigger.

## Facts, Decisions, Recovery

- Project files, Git, and verified primary sources are the facts of record; plans, logs, historical summaries, tool state, and automatic memory do not override them.
- Write stable decisions to the project's existing rules or decision files. Logs are only recovery summaries and stable-decision references.
- Read history only to trace an old decision, investigate a regression, or handle a blocker.
- Resolve conflicts in this order: user's latest instruction, current repository rules, Git, then verifiable facts; old records and recalled memory cannot override current state.
- Maintain one plan and one task state. Reuse existing workflow artifacts; do not create parallel plans, decisions, or status systems.
- Automatic memory starts as `candidate` and becomes `reviewed` only after current facts are verified; memory is never the project facts source.

## Boundaries

Load `references/recovery-and-logs.md` only for cross-session recovery, interruption, handoff, or an explicit checkpoint request. Load `references/github-mutation.md` before authorized GitHub mutations. Other tools and skills own their own installation and usage rules.
