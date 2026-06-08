# DW Skills

这是一个面向 Codex 辅助开发的项目级开发工作流仓库。

它的目标是把需求确认、分阶段开发、设计规范、质量门禁、GitHub 更新、会话恢复、执行追踪，以及 ECC 模块的选择性迁移规则整理成可复用的本地标准。

## 目录

- `AGENT.nd`：开发会话入口说明，规定 Codex 开始工作前必须读取的标准文件和核心流程。
- `docs/`：项目开发相关标准，包括需求模板、开发流程、技术规范、设计规范、执行清单、质量门禁、GitHub 更新、恢复机制和 ECC 迁移策略。
- `dev-logs/`：每日开发日志，用于记录已完成事项、决策、验证结果、阻塞项和待办事项。

## 核心原则

- 先确认需求，再规划开发。
- 每次只推进一个稳定、可验证的小步骤。
- 页面开发默认使用已安装的 `frontend-design`，审美方向由 `taste-skill` 负责。
- 使用 Graphify 辅助理解架构、文件关系和大型代码库。
- 所有代码修改后通过 GitHub 提交和更新。
- 重复出现的 Agent 错误要沉淀成 `AGENT.nd` 中的明确规则。

## ECC 选择性迁移

ECC 模块不会被整包复制。当前仓库只吸收其中适合本工作流的规则、流程和启用条件。

默认不复制这些运行时内容：

- commands
- hooks
- agents
- scripts
- platform configs
- MCP configs

具体迁移边界见：

- `docs/12-ecc-selective-migration-policy.md`
- `docs/ecc-module-migration-review.md`

## 使用方式

开始一个开发任务前，先读取：

1. `AGENT.nd`
2. `docs/01-requirements-template.md`
3. `docs/02-development-workflow.md`
4. `docs/05-execution-checklist.md`
5. 当天的 `dev-logs/YYYY-MM-DD.md`

如果项目已经确定技术栈，再根据 `docs/12-ecc-selective-migration-policy.md` 启用对应的条件规则。
