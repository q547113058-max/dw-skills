---
name: dw-skills
description: Lightweight, risk-based development governance.
---

# DW Skills

Use this file as the sole DW execution entry. Load only the reference required by the task.

## Task Levels

- `quick` is the default for narrow, local, reversible work.
- `standard` covers ordinary behavior changes, multi-file work, reversible data or integration changes, and required deterministic verification.
- `high-risk` covers authentication or authorization, secrets, payments, sensitive data, destructive migrations, production release, privileged or irreversible operations, public contract breaks, or significant recovery cost.

Do not announce the level unless it changes how the work is done.

## Conditional Gates

- Security: input boundaries, authentication, authorization, secrets, payments, privacy.
- Data: persistence, schema, migration, integrity, customer data.
- Deployment: CI, runtime configuration, infrastructure, release, rollback.
- External operations: GitHub, third-party services, and mutations.

Verification strength: `quick` = nearest relevant test, lint, build fragment, or manual check plus diff review; `standard` = quick evidence plus relevant deterministic tests and boundary checks; `high-risk` = standard evidence plus only the risk-specific permission, exposure, failure, compatibility, recovery, rollback, or integration checks the change needs. Define the minimum pass condition and evidence before non-quick work.

Do not add heavyweight plans, reviews, E2E, rollback drills, logs, checkpoints, orchestration, or unrelated specialist review without a real trigger.

## Facts, Decisions, Recovery

- Project files, Git, and verified primary sources are the facts of record; plans, logs, historical summaries, tool state, and automatic memory do not override them.
- Write stable decisions to the project's existing rules or decision files. Logs are only recovery summaries and stable-decision references.
- Prefer current files over history; read history when tracing an old decision, investigating a regression, or handling a blocker.
- Resolve conflicts in this order: user's latest instruction, current repository rules, Git, then verifiable facts; old records and recalled memory cannot override current state.
- Keep one plan in context. Do not create parallel plans, decisions, or status artifacts unless the user or an existing workflow requires them.
- Automatic memory starts as `candidate` and becomes `reviewed` only after current facts are verified; memory is never the project facts source.

## Routes

- Recovering behavior or a data source that exists only in a shipped, packaged, or running target - native binaries, packaged or Electron/JavaScript apps, web pages and their network traffic, managed assemblies, firmware: read `references/reverse-engineering.md`.
- Reviewing a diff, commit, or branch range where deterministic file selection or project rule resolution helps: read `docs/17-open-code-review-integration.md` and use the OCR delegate CLI. The current model stays the review owner.

## Boundaries

Load `references/recovery-and-logs.md` only for cross-session recovery, interruption, handoff, or an explicit checkpoint request. Load `references/github-mutation.md` before authorized GitHub mutations. Other tools and skills own their own installation and usage rules.
