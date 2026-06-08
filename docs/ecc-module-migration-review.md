# ECC 模块迁移审阅

来源仓库：`work/ecc`，来自 `https://github.com/affaan-m/ECC`。

本文件记录 ECC 模块如何选择性迁移到本地开发工作流。用户已批准所有模块按选择性迁移策略处理；下表记录每个模块的最终边界。

## 迁移模式

- `Adopt rules`：把有用行为总结到 `AGENT.nd` 或 `docs/`。
- `Install skill`：只在明确需要时复制或安装选定 `SKILL.md`。
- `Reference only`：保留 ECC 源码在 `work/ecc`，需要时参考。
- `Skip`：默认不迁移。

## 决策表

| # | 模块 | 类型 | 成本 | 稳定性 | 提供内容 | 最终处理 |
| --- | --- | --- | --- | --- | --- | --- |
| 1 | `rules-core` | rules | light | stable | 通用和语言规则 | 已 `Adopt rules`：迁移 common 规则；TypeScript/React/Web 条件启用；其他语言仅参考。 |
| 2 | `agents-core` | agents | light | stable | Agent 角色和项目级说明 | 已 `Adopt rules`：迁移角色触发器；不安装完整 agent 文件；技术栈专项角色条件启用。 |
| 3 | `commands-core` | commands | medium | stable | Slash command 文档和命令库 | 已 `Adopt rules`：迁移命令配方；不复制完整 command library。 |
| 4 | `hooks-runtime` | hooks | medium | stable | Runtime hooks 和辅助脚本 | 条件启用：迁移 hook runtime 策略；不安装原始 hooks/scripts。 |
| 5 | `platform-configs` | platform | light | stable | 平台配置、包管理器、MCP 目录 | 仅参考：不自动覆盖本地平台配置。 |
| 6 | `framework-language` | skills | medium | stable | 框架/语言工程 skills | 条件启用：技术栈确定后再启用。 |
| 7 | `database` | skills | medium | stable | 数据库和持久化 skills | 条件启用：项目有数据库或持久化工作时启用。 |
| 8 | `workflow-quality` | skills | medium | stable | Eval、TDD、验证、压缩、持续学习 | 已 `Adopt rules`：迁移质量循环。 |
| 9 | `optimization-workflows` | skills | medium | beta | benchmark、并行执行、延迟、递归决策 | 条件启用：性能、延迟、吞吐或成本任务时采用测量循环。 |
| 10 | `security` | skills | medium | stable | 安全审查和框架安全规则 | 已 `Adopt rules`：迁移安全审查和扫描触发器。 |
| 11 | `research-apis` | skills | medium | stable | 深度研究和 API 集成 | 条件启用：研究密集任务采用 search/source-quality 工作流。 |
| 12 | `business-content` | skills | heavy | stable | 写作、市场、投资人、SEO、产品沟通 | 条件/参考：只有产品、内容或商业任务进入范围时启用。 |
| 13 | `operator-workflows` | skills | medium | beta | GitHub、Jira、billing、Google Workspace 等外部应用操作 | 条件/参考：外部应用授权和流程配置后启用。 |
| 14 | `prediction-market-skills` | skills | medium | beta | 预测市场研究流程 | 参考/跳过，除非产品明确涉及预测市场。 |
| 15 | `social-distribution` | skills | medium | stable | 社交发布和分发 | 条件启用：发布或分发是需求时启用。 |
| 16 | `media-generation` | skills | heavy | beta | 视频、图片、媒体生成和编辑 | 默认仅参考；优先使用已安装本地媒体 skills。 |
| 17 | `orchestration` | orchestration | medium | beta | worktree/tmux 编排 runtime 和文档 | 条件启用：迁移编排策略；不安装 scripts/worktrees/tmux。 |
| 18 | `swift-apple` | skills | medium | stable | Swift、SwiftUI、Apple 平台 skills | 条件启用：Apple 平台项目时启用。 |
| 19 | `agentic-patterns` | skills | medium | stable | Agentic engineering、自主循环、harness、prompt 优化 | 已 `Adopt rules`：迁移小工作单元、eval-first、成本纪律、merge gates。 |
| 20 | `devops-infra` | skills | medium | stable | 部署、Docker、基础设施、网络 | 条件启用：部署或基础设施进入范围时启用。 |
| 21 | `machine-learning` | skills | medium | beta | ML 工程流程 | 条件启用：ML/MLOps 项目时启用。 |
| 22 | `supply-chain-domain` | skills | heavy | stable | 供应链、物流、采购领域 skills | 参考/跳过，除非项目领域需要。 |
| 23 | `document-processing` | skills | medium | stable | 文档转换和翻译 | 仅参考；默认由已安装 document plugins 覆盖。 |
| 24 | `docs-ja-jp` | docs | heavy | stable | 日文翻译文档 | 默认跳过。 |
| 25 | `docs-zh-cn` | docs | heavy | stable | 简体中文 ECC 文档 | 仅作为阅读辅助参考。 |
| 26 | `docs-ko-kr` | docs | heavy | stable | 韩文翻译文档 | 默认跳过。 |
| 27 | `docs-pt-br` | docs | heavy | stable | 巴西葡萄牙语翻译文档 | 默认跳过。 |
| 28 | `docs-ru` | docs | heavy | stable | 俄文翻译文档 | 默认跳过。 |
| 29 | `docs-tr` | docs | heavy | stable | 土耳其语翻译文档 | 默认跳过。 |
| 30 | `docs-vi-vn` | docs | heavy | stable | 越南语翻译文档 | 默认跳过。 |
| 31 | `docs-zh-tw` | docs | heavy | stable | 繁体中文翻译文档 | 默认跳过。 |
| 32 | `docs-de-de` | docs | heavy | stable | 德文翻译文档 | 默认跳过。 |

## 配置档摘要

- `minimal`：`rules-core`、`agents-core`、`commands-core`、`platform-configs`、`workflow-quality`。
- `core`：minimal 加 `hooks-runtime`。
- `developer`：core 加 `framework-language`、`database`、`orchestration`。
- `security`：core 加 `security`。
- `research`：core 加 `research-apis`、`business-content`、`social-distribution`。
- `full`：除多语言文档外的主要模块。

## 最终迁移策略

- 默认采纳规则写在 `AGENT.nd`、`docs/02-development-workflow.md`、`docs/05-execution-checklist.md`、`docs/09-quality-gates-and-review-loop.md`、`docs/10-session-checkpoints-and-recovery.md` 和 `docs/12-ecc-selective-migration-policy.md`。
- 条件模块只有在项目需求、技术栈或领域相关时启用。
- runtime 文件、hooks、scripts、commands、agents、platform configs 和 MCP configs 默认不复制。
