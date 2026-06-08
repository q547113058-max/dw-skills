# Development Workflow

Use this workflow for every software project in this folder.

## Phase 0: Session Startup

Treat every session as stateless.

1. Read `AGENT.nd`.
2. Read the current project docs needed for the task.
3. Open today's `dev-logs/YYYY-MM-DD.md`; create it if missing.
4. Check Git state:
   - `git status`
   - `git branch --show-current`
   - `git log -1 --oneline`
5. Find the active feature checklist and TODO list.
6. Identify:
   - last completed checkpoint
   - current unfinished task
   - files changed since the last checkpoint
   - checks already run
   - checks still pending

Do not start editing until the next safe step is clear.

## Phase 1: Requirement Intake

1. Ask the user to fill `docs/01-requirements-template.md`.
2. Identify missing critical information:
   - software purpose
   - target device or platform
   - core features
   - problem being solved
   - design style
   - main colors
   - displayed content
3. Resolve missing details with short questions or explicit assumptions.
4. Save clarified requirements in `docs/project-requirements.md`.

## Phase 2: Small-Step Planning

Create a plan that moves in stable increments.

Each step must include:

- Goal
- Files or modules likely to change
- Expected user-visible result
- Validation method
- Risk or dependency

Rules:

- Do not plan a large all-at-once build when an MVP can validate the direction.
- Prefer one working screen or workflow before adding extra features.
- Keep each step independently testable.
- Stop and revise the plan when a decision changes the product, data model, or UI structure.
- Maintain a visible feature checklist and TODO list.
- Mark items complete only after implementation and verification.
- For larger tasks, use the ECC-derived plan recipe: restate requirements, inspect local patterns, define files/risks/validation, and wait for confirmation before coding.
- For feature work, follow the ECC-derived feature recipe: discovery, codebase exploration, clarification, architecture design, implementation, quality review, and summary.

### Frontend Design Skill Priority

For page, frontend, web app, website, dashboard, game, or interactive UI work, use this priority order:

1. User requirements, existing product design, and brand constraints are the highest authority.
2. `taste-skill` is responsible for aesthetic direction:
   - anti-slop visual judgment
   - layout character
   - mood and art direction
   - motion direction
   - visual hierarchy
   - avoiding generic AI-looking UI
3. `Ilm-Alan/frontend-design` is responsible for turning the selected style into concrete implementation tokens:
   - color palette tokens
   - typography tokens
   - spacing and texture tokens
   - CSS variables or design-system values
4. The installed local `frontend-design` skill remains the baseline UI quality and visual QA standard.

Do not let `taste-skill` and `Ilm-Alan/frontend-design` independently decide the same main color, typography, or layout direction. If they conflict:

- Use `taste-skill` for the design direction.
- Use `Ilm-Alan/frontend-design` only to formalize that direction into CSS/design tokens.
- Record the final choice in `docs/project-design-spec.md`.

## Phase 3: Implementation

Implement only the current planned step.

Before editing:

- Read relevant files.
- Check existing project patterns.
- State the intended edit.

During editing:

- Keep changes scoped.
- Avoid unrelated refactors.
- Preserve user changes.
- Add comments only when they clarify non-obvious logic.

## Phase 4: Verification

Verify the changed behavior before reporting completion.

Use the strongest practical checks:

- automated tests
- lint or type checks
- build
- manual browser or app check
- screenshot inspection for UI work

If a check cannot be run, record why in the daily log.

### Quality Gates

Apply quality gates in this order:

1. Deterministic constraints:
   - formatter
   - linter
   - type check
   - structural tests
   - unit or integration tests
   - pre-commit hooks when configured
2. Automated review loop:
   - review changed files against requirements and acceptance criteria
   - fix findings
   - rerun deterministic checks
   - repeat until no blocking findings remain
3. Generation/evaluation separation:
   - implementation and evaluation should be separate passes
   - for substantial or risky work, use an independent evaluator or review agent when available
   - evaluator output must focus on correctness, regressions, missing tests, UX failures, and delivery blockers

Do not treat a self-summary as verification. Verification requires evidence from checks, tests, review output, or explicit manual inspection.

### Build-Fix Recipe

When build, lint, type, or test checks fail:

1. Identify the exact failing command and first root error.
2. Group errors by file and dependency order.
3. Fix one root error at a time with the smallest safe change.
4. Rerun the failed command after each meaningful fix.
5. Stop and reassess if the same error persists after three attempts, the fix creates more errors, or the fix requires architecture changes.

### PR Recipe

Before creating a pull request:

1. Verify branch state, working tree state, and commits ahead of base.
2. Discover and follow the repository PR template when present.
3. Analyze commit history and diff, not only the latest commit.
4. Include a test plan and known limitations.
5. Push the branch and verify PR metadata and CI status.

## Phase 5: Logging And Handoff

At the end of each session:

1. Update today's file in `dev-logs/`.
2. Record completed work.
3. Record changed files.
4. Record validation results.
5. Record open issues and next todos.
6. Record the latest Git checkpoint or why no checkpoint was created.
7. Tell the user what changed and what remains.

## Phase 6: Checkpoint Recovery

When a session resumes after failure, interruption, context loss, or tool timeout:

1. Re-run Phase 0.
2. Compare Git checkpoint state with current working tree.
3. Read the active TODO list and today's development log.
4. Continue from the first unfinished verified step.
5. Do not restart from scratch unless the previous state is unusable.
