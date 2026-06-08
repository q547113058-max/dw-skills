# DW Skills

这是一个面向 Agent 辅助开发的项目级开发工作流仓库。

目标是把需求确认、分阶段开发、设计规范、质量门禁、GitHub 更新、会话恢复、执行追踪和可复用质量规则整理成稳定标准。后续如果迁移到 Hermes，应优先迁移这些文档化规则，而不是依赖某个本地运行时目录。

## 目录

- `AGENT.nd`：开发会话入口说明，规定 Agent 开始工作前必须读取的标准文件、可用 skills 和核心流程。
- `docs/`：项目开发标准，包括需求模板、开发流程、技术规范、设计规范、执行清单、质量门禁、GitHub 更新、恢复机制和条件质量策略。
- `dev-logs/`：每日开发日志，用于记录已完成事项、决策、验证结果、阻塞项和待办事项。

## 核心原则

- 先确认需求，再规划开发。
- 每次只推进一个稳定、可验证的小步骤。
- 页面开发默认使用 `frontend-design`，审美方向由 `taste-skill` 负责。
- 轻量项目默认先用 `rg`、直接读文件和现有测试；需要代码结构图时再用 codegraph，项目变复杂或已有图谱时才用 Graphify。
- 长期多会话项目可选用 agentmemory 作为记忆层；轻量项目不默认启用。
- 所有代码修改后通过 GitHub 提交和更新。
- 重复出现的 Agent 错误要沉淀成 `AGENT.nd` 中的明确规则。

## 已用 Skills 和下载地址

| Skill | 用途 | 下载地址 |
| --- | --- | --- |
| `frontend-design` | 页面、前端、Web App、仪表盘、游戏和交互 UI 的基础设计与视觉 QA 规则 | `https://github.com/Ilm-Alan/frontend-design` |
| `taste-skill` / `design-taste-frontend` | 审美方向、反模板化视觉判断、风格选择 | `https://github.com/Leonxlnx/taste-skill` |
| `codegraph` | 轻量代码结构图、import/call/dependency graph、循环依赖检查 | `https://github.com/colbymchenry/codegraph` |
| `graphify` | 项目级知识图谱、长期架构记忆、跨代码/文档/资料分析 | `https://github.com/safishamsi/graphify` |
| `agentmemory` | 可选持久化记忆层，用于长期多会话、多 Agent 或 Hermes 迁移场景 | `https://github.com/rohitg00/agentmemory` |
| `github` | GitHub CLI、仓库、提交、PR 和 GitHub API 工作流 | Codex 本地 skill；GitHub CLI 下载地址：`https://cli.github.com/` |

## 使用方式

开始一个开发任务前，先读取：

1. `AGENT.nd`
2. `docs/01-requirements-template.md`
3. `docs/02-development-workflow.md`
4. `docs/05-execution-checklist.md`
5. 当天的 `dev-logs/YYYY-MM-DD.md`

如果项目已经确定技术栈，再根据 `docs/12-conditional-quality-and-tooling-policy.md` 启用对应的条件规则。
