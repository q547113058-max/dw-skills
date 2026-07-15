# DW Skills

DW Skills 是一套面向 Agent 辅助开发的项目治理层。它不再重复实现完整的软件开发方法论；在支持的 Agent 环境中，通用开发主流程由 [obra/superpowers](https://github.com/obra/superpowers) 执行，DW 负责补充项目上下文、UI 设计、会话恢复、工具治理、交付记录和规则沉淀。

## 第二大脑部署范围

- 当前只在 `CODEX_HOME=D:\Codex\home` 启用第二大脑，`D:\Codex\vault` 是云盘迁移前的唯一权威 Vault。
- 其他电脑和环境保持关闭，不安装全局路由，不初始化或更新平行项目记忆。
- `dw-skills` 只保留一个物理 Git checkout；活动 skill 路径可通过目录联接复用。

## 任务级别

- `quick`：默认；低风险窄改动，只加载最小上下文并做针对性验证。
- `standard`：一般功能、行为变化、多文件 Bugfix，增加短计划、日志和相关确定性检查。
- `high-risk`：架构、认证、数据、支付、migration、部署或 secrets，增加完整相关门禁和恢复检查点。

任务级别决定流程深度，运行模式决定通用生命周期负责人，两者独立。

## 分工

| 能力 | 默认负责人 |
| --- | --- |
| 需求澄清、方案设计 | Superpowers `brainstorming` |
| 实施计划 | Superpowers `writing-plans` |
| 隔离工作区 | Superpowers `using-git-worktrees` |
| TDD | Superpowers `test-driven-development` |
| 执行与子 Agent 编排 | Superpowers `executing-plans` / `subagent-driven-development` |
| 调试 | Superpowers `systematic-debugging` |
| 代码审查与完成验证 | Superpowers review / verification skills |
| UI 方向、设计 token、视觉 QA | DW 设计规则和登记的设计 Skills |
| 项目日志、会话恢复、工具选型 | DW |
| 安全、技术栈和领域附加门禁 | DW 条件规则 |
| GitHub 交付记录、反馈归因 | DW |

原则是“一项能力只有一个主流程”。DW 不要求重复生成 Superpowers 已经产出的需求、计划、TDD 记录或审查报告，只补充缺失的项目级信息。

## 运行模式

- **组合模式**：环境已安装 Superpowers。使用 Superpowers 执行通用开发生命周期，DW 只运行增量门禁。
- **独立模式**：环境没有 Superpowers。DW 使用 `docs/02-development-workflow.md` 中的精简降级流程，保证工作仍可完成。

模式在任务开始时确定。`standard`、`high-risk`、恢复任务或已有日志时记录到 `dev-logs/YYYY-MM-DD.md`；没有后续价值的 `quick` 不为形式创建日志。不要在任务中途无故切换。

## DW 保留的差异化能力

- UI 任务的产品上下文、设计方向、token 和视觉 QA。
- 轻量代码理解、codegraph、Graphify 和 agentmemory 的成本分级。
- Ponytail 精简实现审查。
- 无状态会话恢复、项目 TODO 和开发日志。
- 安全敏感、技术栈专项、AI eval 和领域规则等条件门禁。
- Skill 来源、更新和迁移治理。
- GitHub 更新、交付状态和反馈归因。

## 使用方式

1. 读取 `AGENTS.md`。
2. 选择 `quick`、`standard` 或 `high-risk`，并检测 combined / standalone 模式。
3. `standard`、`high-risk` 或 combined 模式读取 `docs/15-superpowers-integration.md`。
4. 只读取当前任务需要的 DW 文档。
5. 组合模式下按 Superpowers 当前阶段执行，再运行 DW 增量清单。
6. 独立模式下使用 DW 精简降级流程。

详细分工和冲突处理见 `docs/15-superpowers-integration.md`。
