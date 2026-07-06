---
name: dw-skills
description: Use when the user asks to apply dw-skills, DW Skills, project development workflow standards, requirement confirmation, staged implementation, design standards, execution checklists, quality gates, GitHub update rules, session recovery, or reusable agent development rules from the local dw-skills repository.
---

# DW Skills

Use this skill as the project-level development workflow standard.

## Quick Start

When this skill is triggered, read only the files needed for the current task:

1. Start with `AGENTS.md` for the overall workflow and required standards.
2. For requirements or planning, read `docs/01-requirements-template.md` and `docs/02-development-workflow.md`.
3. For implementation standards, read `docs/03-technical-standards.md`.
4. For frontend or UI work, read `docs/04-design-standards.md` and also use the existing `frontend-design` skill.
5. For execution and verification, read `docs/05-execution-checklist.md` and `docs/09-quality-gates-and-review-loop.md`.
6. For GitHub syncing, read `docs/08-github-update-standard.md`.
7. For session resume or multi-turn continuity, read `docs/10-session-checkpoints-and-recovery.md`.
8. For dev-log expectations, read `docs/06-development-log-standard.md` and the latest file in `dev-logs/`.
9. Before invoking a registered DW skill, read `docs/14-skill-update-policy.md` and run the weekly skill check when needed.

## Working Rules

- Keep changes small, staged, and verifiable.
- Update relevant project docs when code behavior changes.
- Run appropriate checks before delivery.
- Record important decisions and verification results in the project dev log when the task is substantive.
- Push or sync to GitHub after completed code/documentation changes when the target project requires it.

## Bundled References

- `AGENTS.md`: main operating guide.
- `docs/`: detailed workflow, design, quality, GitHub, and recovery standards.
- `dev-logs/`: historical development notes.
- `outputs/`: user-facing deliverables.
- `work/`: temporary working material.
