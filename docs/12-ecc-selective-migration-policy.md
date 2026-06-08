# ECC Selective Migration Policy

This document defines how ECC modules are used in this local development workflow.

Default rule: adopt workflow principles, not ECC files, unless a concrete project stack requires them.

## Migration Boundaries

- Do not bulk copy ECC `commands/`, `agents/`, `hooks/`, platform configs, MCP configs, or scripts into a project.
- Do not install stack-specific skills before the target stack is known.
- Do not overwrite local Codex, GitHub, package manager, MCP, or editor configuration from ECC templates.
- Prefer docs/checklists first; install scripts or hooks only after the project has a repository, toolchain, rollback plan, and explicit approval.
- Treat domain modules as reference-only until a project requirement names that domain.

## Adopted By Default

These modules are already represented in `AGENT.nd` and `docs/` as project rules:

- `workflow-quality`: TDD, verification loop, eval harness, continuous learning.
- `rules-core`: common engineering rules, security triggers, review severity, conditional frontend rules.
- `agents-core`: role triggers for planning, TDD, review, security, build-fix, E2E, and stack-specific review.
- `commands-core`: command recipes for planning, feature development, checkpoint, quality gate, security scan, build fix, session save/resume, and PR creation.
- `agentic-patterns`: agentic engineering principles only: completion criteria, small work units, eval-first execution, model/cost discipline, and human-controlled merge gates.
- `security`: security review and scan triggers, secret hygiene, input validation, dependency and configuration review.

## Conditional Modules

Enable these only when the project requirement or stack makes them relevant:

| Module | Enable when | Adopt as |
| --- | --- | --- |
| `hooks-runtime` | The project has stable local commands and wants automated guardrails | Hook policy, not raw ECC hook files |
| `platform-configs` | A specific platform config gap is identified | Reference template only; no overwrite |
| `framework-language` | Project stack is known | Stack-specific coding/testing rules |
| `database` | Project uses persistence | Migration, schema, query, and data integrity rules |
| `optimization-workflows` | Performance, latency, throughput, or cost is a named requirement | Benchmark and measurement loop |
| `research-apis` | Research/API discovery is required | Search-first and source-quality rules |
| `operator-workflows` | External apps such as GitHub, Jira, billing, or Google Workspace are configured | Operation runbooks with auth checks |
| `orchestration` | Multiple agents, branches, worktrees, or parallel tasks are needed | Work item ownership, handoff, merge gates |
| `devops-infra` | Deployment, Docker, or infrastructure is in scope | Deployment and rollback standards |
| `media-generation` | Product requires image, audio, video, or demo assets | Existing local media skills first, ECC reference second |
| `document-processing` | Document conversion or translation exceeds installed document plugin coverage | Reference workflow |
| `machine-learning` | ML/MLOps is in scope | Data contracts, evals, monitoring, rollback |
| `swift-apple` | Building Apple platform software | Swift/SwiftUI rules |
| `social-distribution` | Publishing or distribution is part of the product | Channel-specific checklist |
| `business-content` | Product needs market, SEO, investor, or content workflows | Content/business checklist |

## Reference Or Skip

- `prediction-market-skills`: reference only if the product is explicitly about prediction markets.
- `supply-chain-domain`: reference only for supply-chain/logistics/procurement projects.
- Locale docs: skip by default; use `docs-zh-cn` only as a reading aid if ECC source text needs Chinese reference.

## Command Recipes

Use these command patterns as workflow recipes, not slash commands:

- Plan: restate requirements, inspect local patterns, define phases, risks, and validation, then wait for approval before coding when scope is large.
- Feature development: discovery, codebase exploration, clarification, architecture design, implementation, quality review, summary.
- Build fix: detect build system, run the failing command, group errors, fix one root error at a time, rerun the failed command.
- Checkpoint: verify current state, create a focused Git checkpoint, log the checkpoint, compare current state to checkpoint during recovery.
- Quality gate: run formatter/linter/type/test/build checks available in the project; do not invent missing scripts.
- Security scan: scan secrets, permissions, hooks/config, dependencies, raw HTML, API surfaces, and MCP/tool config when present.
- Session save/resume: preserve completed work, failed attempts, changed files, decisions, blockers, exact next step, and verification status.
- PR: validate branch state, analyze commits and diff, use PR template if present, push, create PR, verify CI.

## Hook Runtime Policy

Hooks are optional automation, not default behavior.

Before enabling a hook:

- The project must have local deterministic commands for the hook to run.
- The hook command must be pinned to local project dependencies or reviewed absolute scripts.
- Blocking hooks must have clear failure messages and a manual recovery path.
- Hooks must not silently send code, secrets, prompts, or file contents to remote services.
- Hooks that modify files must be scoped to edited files and must not rewrite broad config.
- Hook behavior must be documented in `docs/project-tooling.md` or the project equivalent.

Good hook candidates:

- format edited files
- lint edited files
- warn on production `console.log` or debug statements
- run incremental type checks
- block commits with obvious secrets or skipped verification
- save session/checkpoint metadata before compaction or handoff

Avoid hooks that:

- run long builds on every edit
- install packages automatically
- overwrite local configs
- require tmux/worktrees when the project is not using them
- hide failures or swallow non-zero exits

## Orchestration Policy

Use orchestration only when single-agent execution is insufficient.

Required before parallel work:

- work items with owner, scope, branch/worktree, acceptance criteria, and merge gate
- no overlapping writes without a named integrator
- handoff artifact for each worker
- deterministic checks before merge
- security/risk review for shared code, auth, data, deploy, or config changes

Do not use orchestration to make small tasks look larger. For narrow edits, use a single-agent flow.

## Domain Activation

When a project names a stack or domain, add the relevant ECC-derived rules to project-local docs:

- stack rules go into `docs/project-technical-decisions.md` or a stack-specific doc
- database rules go into migration/schema/runbook docs
- deployment rules go into deployment/rollback docs
- business/content/media/domain rules go into product-specific docs

Record the activation decision and source module in `dev-logs/YYYY-MM-DD.md`.
