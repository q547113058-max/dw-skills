# ECC Module Migration Review

Source repository: `work/ecc` from `https://github.com/affaan-m/ECC`.

Use this file to track how ECC modules are migrated into this local development workflow. The user approved selective migration for all modules; this table records the resulting boundary for each module.

## Migration Modes

- `Adopt rules`: summarize the useful behavior into `AGENT.nd` or `docs/`.
- `Install skill`: copy or install selected `SKILL.md` folders into the local Codex skills directory.
- `Reference only`: keep the ECC source in `work/ecc` and consult it when needed.
- `Skip`: do not migrate.

## Decision Table

| # | Module | Kind | Cost | Stability | What It Adds | Final Fit |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | `rules-core` | rules | light | stable | Shared and language rules. | Selected for `Adopt rules`: common rules migrated; TypeScript/React/Web rules kept conditional; other language rules reference-only. |
| 2 | `agents-core` | agents | light | stable | Agent roles and project-level agent guidance. | Selected for `Adopt rules`: role triggers migrated; full agent file installation skipped; stack-specific roles remain conditional. |
| 3 | `commands-core` | commands | medium | stable | Slash-command library and command docs. | Selected for `Adopt rules`: command recipes migrated; full command library skipped. |
| 4 | `hooks-runtime` | hooks | medium | stable | Runtime hooks and hook helper scripts. | Conditional: hook runtime policy migrated; raw hooks/scripts not installed. |
| 5 | `platform-configs` | platform | light | stable | Platform configs, package manager setup, MCP catalog. | Reference only: never overwrite local platform config without explicit setup work. |
| 6 | `framework-language` | skills | medium | stable | Framework/language engineering skills. | Conditional: activate only after project stack is known. |
| 7 | `database` | skills | medium | stable | Database and persistence skills. | Conditional: activate only when persistence/database work exists. |
| 8 | `workflow-quality` | skills | medium | stable | Eval, TDD, verification, compaction, continuous learning. | Selected for `Adopt rules`: quality loop migrated. |
| 9 | `optimization-workflows` | skills | medium | beta | Benchmarking, parallel execution, latency, recursive decisions. | Conditional: adopt measurement/benchmark loops only for performance, latency, throughput, or cost tasks. |
| 10 | `security` | skills | medium | stable | Security review and framework security guidance. | Selected for `Adopt rules`: security review and scan triggers migrated. |
| 11 | `research-apis` | skills | medium | stable | Deep research and API integration skills. | Conditional: adopt search/source-quality workflow for research-heavy tasks. |
| 12 | `business-content` | skills | heavy | stable | Writing, market, investor, SEO, product communication. | Conditional/reference: activate only when product/content/business work is in scope. |
| 13 | `operator-workflows` | skills | medium | beta | Connected app operations: billing, GitHub, Jira, Google Workspace, notifications. | Conditional/reference: activate only after external app auth and workflow surfaces are configured. |
| 14 | `prediction-market-skills` | skills | medium | beta | Prediction-market research workflows. | Reference/skip unless the product explicitly targets prediction markets. |
| 15 | `social-distribution` | skills | medium | stable | Social publishing and distribution. | Conditional: activate only for publishing/distribution requirements. |
| 16 | `media-generation` | skills | heavy | beta | Video, image, media generation and editing. | Reference only by default; use installed local media skills first. |
| 17 | `orchestration` | orchestration | medium | beta | Worktree/tmux orchestration runtime and docs. | Conditional: orchestration policy migrated; scripts/worktrees/tmux not installed. |
| 18 | `swift-apple` | skills | medium | stable | Swift, SwiftUI, and Apple platform skills. | Conditional: activate only for Apple platform projects. |
| 19 | `agentic-patterns` | skills | medium | stable | Agentic engineering, autonomous loops, harness construction, prompt optimization. | Selected for `Adopt rules`: small work units, eval-first, cost discipline, merge gates. |
| 20 | `devops-infra` | skills | medium | stable | Deployment, Docker, infra, network skills. | Conditional: activate only when deployment/infrastructure is in scope. |
| 21 | `machine-learning` | skills | medium | beta | ML engineering workflows. | Conditional: activate only for ML/MLOps projects. |
| 22 | `supply-chain-domain` | skills | heavy | stable | Supply chain, logistics, procurement domain skills. | Reference/skip unless project domain requires it. |
| 23 | `document-processing` | skills | medium | stable | Document conversion/translation skills. | Reference only; installed document plugins cover default needs. |
| 24 | `docs-ja-jp` | docs | heavy | stable | Japanese translated docs. | Skip by default. |
| 25 | `docs-zh-cn` | docs | heavy | stable | Simplified Chinese translated ECC docs. | Reference only as reading aid. |
| 26 | `docs-ko-kr` | docs | heavy | stable | Korean translated docs. | Skip by default. |
| 27 | `docs-pt-br` | docs | heavy | stable | Brazilian Portuguese translated docs. | Skip by default. |
| 28 | `docs-ru` | docs | heavy | stable | Russian translated docs. | Skip by default. |
| 29 | `docs-tr` | docs | heavy | stable | Turkish translated docs. | Skip by default. |
| 30 | `docs-vi-vn` | docs | heavy | stable | Vietnamese translated docs. | Skip by default. |
| 31 | `docs-zh-tw` | docs | heavy | stable | Traditional Chinese translated docs. | Skip by default. |
| 32 | `docs-de-de` | docs | heavy | stable | German translated docs. | Skip by default. |

## Profile Summary

- `minimal`: `rules-core`, `agents-core`, `commands-core`, `platform-configs`, `workflow-quality`.
- `core`: minimal plus `hooks-runtime`.
- `developer`: core plus `framework-language`, `database`, `orchestration`.
- `security`: core plus `security`.
- `research`: core plus `research-apis`, `business-content`, `social-distribution`.
- `full`: all major classified modules except locale docs.

## Final Migration Policy

- Default adopted rules live in `AGENT.nd`, `docs/02-development-workflow.md`, `docs/05-execution-checklist.md`, `docs/09-quality-gates-and-review-loop.md`, `docs/10-session-checkpoints-and-recovery.md`, and `docs/12-ecc-selective-migration-policy.md`.
- Conditional modules are activated only when a project requirement, stack, or domain makes them relevant.
- Runtime files, hooks, scripts, commands, agents, platform configs, and MCP configs are not copied by default.
