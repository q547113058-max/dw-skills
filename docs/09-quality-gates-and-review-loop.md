# Quality Gates And Review Loop

Use this standard for every code change.

## Deterministic Constraints

Run deterministic checks before subjective review whenever the project supports them.

Preferred order:

1. Formatter
2. Linter
3. Type check
4. Structural tests
5. Unit tests
6. Integration tests
7. Build
8. Pre-commit hooks

Examples:

```powershell
npm run format
npm run lint
npm run typecheck
npm test
npm run build
pre-commit run --all-files
```

Use the project's actual commands. Do not invent commands when the project has no matching scripts.

## TDD Gate

Use TDD for features, bug fixes, and refactors when the project has a practical test surface.

Steps:

1. Write the user journey:

```text
As a [role], I want to [action], so that [benefit].
```

2. Write the smallest meaningful test first.
3. Confirm a valid RED state before editing production code.
4. Implement the smallest fix.
5. Rerun the same test target and confirm GREEN.
6. Refactor only after GREEN.
7. Rerun relevant checks after refactor.

A RED state is valid only when:

- the relevant test target compiles or reaches the intended assertion
- the new or changed test actually runs
- the failure is caused by the intended missing behavior or bug
- the failure is not only from syntax errors, missing dependencies, broken test setup, or unrelated regressions

Coverage target:

- Aim for 80%+ coverage where the project has coverage tooling.
- Cover edge cases, error paths, and boundary conditions for changed behavior.
- Do not claim coverage when no coverage command was run.

When the repository is under Git, use checkpoints for the TDD cycle:

- `test: add reproducer for <feature-or-bug>` after RED is validated
- `fix: <feature-or-bug>` after GREEN is validated
- `refactor: clean up <feature-or-bug>` after refactor remains GREEN

## Structural Tests

Use structural tests for behavior that should not depend on screenshots or subjective review:

- required routes exist
- required components render
- required files or generated artifacts exist
- API response shapes match contracts
- config files contain required keys
- accessibility landmarks exist
- no forbidden strings, placeholders, mock names, or TODO markers ship

For frontend work, structural tests complement visual QA; they do not replace screenshots or browser checks.

## Pre-Commit

If the project has pre-commit configured:

```powershell
pre-commit run --all-files
```

If pre-commit is not installed or not configured, record that fact. Do not block delivery solely because no pre-commit framework exists.

## Automated Review Loop

Use this loop for substantial or risky changes:

1. Implement the smallest planned step.
2. Run deterministic checks.
3. Review changed files against requirements and acceptance criteria.
4. Fix blocking findings.
5. Rerun failed checks.
6. Repeat until blocking findings are resolved.

Blocking findings include:

- broken build or tests
- behavior that contradicts requirements
- missing error or empty states for user-facing flows
- accessibility regressions
- unsafe data handling
- layout overlap, clipping, or unreadable text
- uncommitted generated artifacts required for runtime

Use these review severities:

| Level | Meaning | Required action |
| --- | --- | --- |
| CRITICAL | Security vulnerability, data loss, broken build, or blocked core flow | Block delivery until fixed |
| HIGH | Likely bug, regression, missing required validation, or missing required test | Fix before handoff unless explicitly accepted |
| MEDIUM | Maintainability, clarity, performance, or coverage weakness | Fix when practical or record rationale |
| LOW | Style, naming, or minor polish | Optional |

Security-sensitive changes must receive a security-first review before general polish:

- authentication or authorization
- user data, payments, or financial behavior
- database queries or migrations
- filesystem operations
- external API calls and webhooks
- cryptography, secrets, tokens, or environment variables
- raw HTML, URL construction, redirects, or public client bundles

## Verification Report

After substantial changes, produce a compact verification report with this structure:

```text
VERIFICATION REPORT

Build:     PASS/FAIL/SKIPPED
Types:     PASS/FAIL/SKIPPED
Lint:      PASS/FAIL/SKIPPED
Tests:     PASS/FAIL/SKIPPED
Security:  PASS/FAIL/SKIPPED
Diff:      reviewed/not reviewed

Overall:   READY / NOT READY / BLOCKED

Issues:
- ...
```

Verification phases:

1. Build verification.
2. Type check.
3. Lint check.
4. Test suite and coverage when available.
5. Security scan for secrets, unsafe patterns, and debug logging.
6. Diff review for unintended changes, missing error handling, and edge cases.

If build fails, stop and fix before continuing deeper verification.

## Conditional Frontend Quality Gates

Apply these gates when the project uses TypeScript, React, or a web frontend stack.

- Types: exported/public APIs, shared models, component props, and callbacks are typed.
- Type safety: avoid `any`; use `unknown` and narrowing at untrusted boundaries.
- React Hooks: hooks are top-level, dependency arrays are complete, and effects that subscribe, fetch, listen, or start timers clean up.
- State: avoid storing derived state that can be computed during render.
- Tests: prefer behavior tests using accessible queries; use network-layer mocking for API behavior when the stack supports it.
- Snapshots: avoid broad component snapshots; use visual regression or browser checks for visual behavior.
- Accessibility: check labels, roles, keyboard operation, focus states, and reduced-motion behavior when relevant.
- Security: audit raw HTML injection, unsafe URL schemes, `target="_blank"` links, public environment variables, client-side auth gates, and CSRF for cookie-auth forms.
- Performance: verify image dimensions, lazy/eager loading choices, layout shift, third-party scripts, and bundle impact for meaningful frontend surfaces.

## Command Recipe Gates

Use ECC command recipes as checklists, not installed slash commands.

- Plan gate: large work must have requirements restatement, local pattern evidence, phases, risks, validation, and user approval before implementation.
- Feature-dev gate: feature work must pass discovery, codebase exploration, clarification, design, implementation, review, and summary.
- Quality-gate recipe: run the project's formatter, linter, type check, tests, build, and pre-commit when available; do not invent missing scripts.
- Security-scan recipe: scan secrets, permissions, hook/config surfaces, MCP/tool config, dependencies, auth, raw HTML, public bundle exposure, and external API boundaries when relevant.
- Build-fix recipe: fix the first root error with a minimal change, rerun the failed command, and stop after repeated failures or architectural drift.
- PR recipe: validate branch state, compare against base, follow templates, include test plan, push, create PR, and verify CI.

## Hook Runtime Gate

Hooks are optional. Enable them only when they improve deterministic quality without hiding risk.

Before enabling or modifying a hook:

- the project has a stable local command for the hook to run
- the hook is scoped to edited files or a clearly bounded event
- blocking behavior and bypass/recovery are documented
- the hook does not install packages, overwrite configs, leak data, or run long builds unexpectedly
- the hook result is recorded when it blocks delivery

Good candidates are format-on-edit, lint-on-edit, incremental type checks, debug-log warnings, secret scans, pre-commit quality checks, and session/checkpoint metadata capture.

## Multi-Agent Review

When available and worthwhile, use separate agents for review:

- implementation agent writes the change
- review agent evaluates the diff
- evaluator agent checks final behavior against acceptance criteria

Keep review prompts neutral. Do not tell the evaluator what answer to prefer. Provide the changed files, requirements, and acceptance criteria.

## Role-Based Agent Triggers

Use role-based support by trigger, not by habit. Do not install or invoke stack-specific roles until the project stack is known.

| Role | Trigger | Output |
| --- | --- | --- |
| Planning role | Complex feature, architecture change, broad refactor, unclear sequencing | Phased plan with affected files, risks, dependencies, verification |
| TDD role | Feature, bug fix, or refactor with a practical test surface | RED/GREEN/REFACTOR target, test scope, coverage notes |
| Code review role | After code edits or before shared-branch commit/PR | Findings by severity, concrete failure modes, line references when possible |
| Security review role | Auth, authorization, user data, payments, database, filesystem, external APIs, cryptography, secrets, raw HTML, redirects, or public bundle changes | Security findings, remediation, residual risk |
| Build-error resolver role | Build, type check, lint, or test failure | Root error, smallest fix, rerun result |
| E2E role | Critical user journey, high-risk UI flow, or browser-only behavior | Browser test target, screenshots or trace when practical |
| Stack-specific review role | Project stack is known and changed files touch that stack | Focused review using the stack's local rules |

Review quality rules:

- Report only issues with a concrete trigger, failure mode, and affected file or behavior.
- Do not manufacture findings to justify a review pass.
- Do not escalate severity without proof.
- Do not let a role override project requirements, user instructions, security rules, or deterministic check results.
- For small documentation, copy, or narrow UI changes, a local review pass may replace multi-agent review.

## Generation And Evaluation Separation

Do not let the same pass both generate the solution and be the only proof of quality.

For small changes, a separate review pass in the same session may be enough.

For larger changes, use an independent evaluator or review agent. The evaluator should focus on:

- correctness
- regressions
- missing tests
- UX and accessibility failures
- security or data risks
- deployment blockers

Record evaluator findings and resolutions in the daily development log.

## Eval Harness

Use eval-driven development for agent behavior, prompt changes, workflow rules, or product behavior that cannot be fully validated by ordinary tests.

Define evals before implementation:

```markdown
## EVAL: feature-name

Capability Evals:
- [ ] New behavior succeeds
- [ ] Edge case succeeds

Regression Evals:
- [ ] Existing flow still works
- [ ] Existing output shape remains compatible

Success Metrics:
- capability evals: target pass@3 >= 90% when retries are allowed
- release-critical regression evals: target pass^3 = 100%
```

Use the most deterministic grader practical:

- code grader: scripts, tests, grep, schema checks
- rule grader: regex or structured constraints
- model grader: rubric for open-ended outputs
- human grader: security, product judgment, or ambiguous UX

Eval reports should include:

- capability pass/fail
- regression pass/fail
- pass@1, pass@3, or pass^k when relevant
- readiness status
- regressions and next actions

Avoid eval anti-patterns:

- only testing happy paths
- overfitting prompts to known examples
- ignoring cost or latency drift
- using flaky graders as release gates

## Continuous Learning

Use continuous learning as a lightweight rule-improvement loop, not automatic rule spam.

Learning unit:

- one trigger
- one action
- evidence
- confidence
- scope: project or global

Scope rules:

- Project scope for stack conventions, file structure, code style, and local testing habits.
- Global scope for security practices, general verification behavior, Git hygiene, and recurring Agent mistakes across projects.

Confidence levels:

- `0.3`: tentative
- `0.5`: moderate
- `0.7`: strong
- `0.9`: near-certain

Promote a pattern to `AGENT.nd` only when:

- it repeats
- it has clear evidence
- it prevents a real failure or repeated correction
- it can be written as an actionable rule with trigger, required behavior, and forbidden behavior

Do not store raw private conversation or sensitive code in learned rules. Store only the reusable pattern.
