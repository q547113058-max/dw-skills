# Execution Checklist

Use this checklist during each development task.

## Before Work

- [ ] Treat the session as stateless and rebuild context from files, not memory.
- [ ] Read `AGENT.nd`.
- [ ] Read the relevant docs in `docs/`.
- [ ] For page or frontend work, read and apply `C:\Users\54711\.codex\skills\frontend-design\SKILL.md`.
- [ ] For architecture, dependency, impact, or large codebase analysis, use Graphify when appropriate.
- [ ] For code changes, confirm Git repository and GitHub remote status.
- [ ] Create or open today's `dev-logs/YYYY-MM-DD.md`.
- [ ] Confirm requirements are complete enough to proceed.
- [ ] Locate the active feature checklist and TODO list.
- [ ] Identify the latest Git checkpoint and current working tree status.
- [ ] Identify the current development phase.
- [ ] Define the smallest useful next step.
- [ ] Search the repository for existing patterns, utilities, and tests before writing net-new code.
- [ ] Verify unfamiliar APIs, package behavior, or framework behavior against primary docs or installed package versions.
- [ ] Decide whether the task needs role-based support: planning, TDD, code review, security review, build-error resolution, or stack-specific review.
- [ ] Check whether any ECC conditional module should be activated for this task using `docs/12-ecc-selective-migration-policy.md`.

## Before Editing

- [ ] Inspect existing files and project structure.
- [ ] Identify files likely to change.
- [ ] State the intended edit.
- [ ] Check for user changes that must be preserved.
- [ ] Identify validation, error handling, and security boundaries affected by the edit.
- [ ] For TypeScript, React, or web work, identify applicable conditional frontend rules from `docs/03-technical-standards.md`.
- [ ] For complex features, architecture changes, or broad refactors, write a brief plan with phases, risks, affected files, and verification before editing.
- [ ] For features, bug fixes, or refactors with a practical test surface, define the TDD target before editing production code.
- [ ] If a command recipe applies, name it explicitly: plan, feature-dev, checkpoint, quality-gate, security-scan, build-fix, session-save/resume, or PR.

## During Work

- [ ] Keep changes scoped to the active step.
- [ ] Update the feature checklist and TODO list as work progresses.
- [ ] Update docs when decisions change.
- [ ] Avoid unrelated refactors.
- [ ] Keep UI behavior responsive and accessible when applicable.
- [ ] Prefer immutable updates when changing shared or UI state.
- [ ] Keep functions focused and split code that mixes unrelated responsibilities.
- [ ] Avoid production debug output, hardcoded secrets, and unvalidated external input.

## Verification

- [ ] Run relevant tests, build, lint, or manual checks.
- [ ] Run deterministic constraints available in the project: formatter, linter, type check, structural tests, and pre-commit.
- [ ] For substantial changes, run an automated review loop and fix blocking findings.
- [ ] Separate generation and evaluation; use an independent evaluator or review pass when available.
- [ ] If code files changed and `graphify-out/graph.json` exists, run `graphify update .` when practical.
- [ ] For UI work, inspect desktop and mobile layouts when practical.
- [ ] Record any check that could not be run.
- [ ] Review security-sensitive changes first: auth, authorization, user data, payments, filesystem, database, external APIs, cryptography, or secrets.
- [ ] For frontend work, check accessible queries/labels, keyboard behavior, URL safety, raw HTML usage, public env vars, and responsive overflow.
- [ ] After code edits, review the diff through the code-review role: concrete failure modes only, line references where possible, no speculative filler.
- [ ] If build, type check, or tests fail, use the build-error resolver role: read the actual error, apply the smallest fix, rerun the failed command.
- [ ] If hooks are configured, verify they run local deterministic commands and record any hook failures or bypasses.
- [ ] If security-sensitive configuration changed, run or document a security scan path for config, hooks, MCP, env, permissions, and dependency surfaces.

## Handoff

- [ ] Update today's development log.
- [ ] Record execution trace: phase, changed files, commands/checks, results, blockers, and next action.
- [ ] Assign quality grade: A, B, C, or Blocked.
- [ ] Check for anomalies: repeated failures, skipped checks, unclear requirements, unexpected diffs, regressions, or tool timeouts.
- [ ] Attribute user or evaluator feedback to requirement, planning, implementation, design, verification, tooling, or Agent rule cause.
- [ ] Record which role-based checks were used or skipped, with the reason.
- [ ] Record which ECC conditional modules were activated or left reference-only.
- [ ] Create an incremental Git checkpoint after a coherent verified step, or record why not.
- [ ] Commit and push through GitHub, or record why GitHub update is blocked.
- [ ] Use a focused conventional commit style when committing: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`, or `ci`.
- [ ] Summarize completed work.
- [ ] List verification results.
- [ ] List open issues.
- [ ] List next todos.
