---
name: dw-skills
description: Project governance layer for Agent-assisted development. Use for DW Skills, project context, UI design standards, session recovery, tool governance, conditional quality gates, GitHub delivery records, and integration with Superpowers.
---

# DW Skills

Use DW as a project governance layer. When Superpowers is available, let it own the generic development lifecycle and apply DW only where it adds project-specific policy.

## Start

1. Read `AGENTS.md`.
2. Read `docs/15-superpowers-integration.md` and select combined or standalone mode.
3. Read only the DW references needed for the task.
4. Open the latest relevant `dev-logs/` entry for substantive or resumed work.

## Ownership

In combined mode, do not duplicate Superpowers outputs:

- brainstorming owns requirements and design approval;
- writing-plans owns implementation plans;
- test-driven-development owns RED/GREEN/REFACTOR;
- systematic-debugging owns root-cause debugging;
- review and verification skills own code review and completion proof;
- worktree and branch-finishing skills own workspace lifecycle.

DW owns UI design policy, project context, session recovery, tool selection, conditional security/domain gates, skill governance, delivery records, and reusable project rules.

## Fallback

If Superpowers is unavailable, state that once and use the compact standalone workflow in `docs/02-development-workflow.md`. Do not emulate unavailable hooks or subagents merely to reproduce the shape of Superpowers.

## References

- UI: `docs/04-design-standards.md`
- execution: `docs/05-execution-checklist.md`
- GitHub: `docs/08-github-update-standard.md`
- incremental quality: `docs/09-quality-gates-and-review-loop.md`
- recovery: `docs/10-session-checkpoints-and-recovery.md`
- conditional policy: `docs/12-conditional-quality-and-tooling-policy.md`
- integration: `docs/15-superpowers-integration.md`
