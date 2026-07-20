# 条件质量与工具策略

本文件定义哪些增量质量规则、Hook、工具和领域规则应进入项目工作流。组合模式的通用流程和编排由 Superpowers 负责。

默认规则：先吸收可执行原则，不复制外部运行时文件；只有具体项目技术栈、工具链和回滚方案明确后，才启用对应自动化。

先按 `quick`、`standard`、`high-risk` 分级。本文件中的规则组不会因为被登记而自动启用；只有任务触发条件成立时才加载和执行。

## 适用边界

- 不批量复制 `commands/`、`agents/`、`hooks/`、platform configs、MCP configs 或 scripts。
- 目标技术栈未知前，不安装技术栈专项 skills。
- 不用外部模板覆盖本地 Codex、Hermes、GitHub、包管理器、MCP 或编辑器配置。
- 优先写入 docs/checklists；只有项目已有仓库、工具链、回滚方案并得到明确批准后，才安装脚本或 hooks。
- 领域模块在项目需求明确命名该领域前，只作为参考。

## 默认已采纳规则

以下规则已经以项目增量规则形式体现在 `AGENTS.md` 和 `docs/` 中：

- `workflow-quality`：项目确定性检查、条件 eval 和持续学习；通用 TDD/验证由 Superpowers 负责。
- `rules-core`：通用工程规则、安全触发器和审查严重级别。
- `role-triggers`：安全、E2E 和技术栈专项增量审查触发器。
- `fallback-recipes`：Superpowers 不可用时的构建修复、检查点、质量门禁、安全扫描、会话恢复和 PR 配方。
- `agentic-patterns`：完成标准、小工作单元、eval-first、模型/成本纪律和人工控制合并门禁。
- `security`：安全审查和扫描触发器、secret hygiene、输入验证、依赖和配置审查。
- `ponytail-pragmatism`：YAGNI、复用优先、标准库/平台优先、最小可工作实现和反过度工程审查。

## 条件规则

仅在项目需求或技术栈相关时启用：

| 规则组 | 启用条件 | 采纳方式 |
| --- | --- | --- |
| `hooks-runtime` | 项目有稳定本地命令，并需要自动化 guardrails | Hook 策略，不复制未经审查的 hook 文件 |
| `ponytail-runtime` | 用户明确要求安装 Ponytail 插件、hooks、commands 或 platform configs | 先审查运行时文件、权限、网络行为和回滚方案，再安装 |
| `platform-configs` | 发现具体平台配置缺口 | 只参考模板，不覆盖 |
| `framework-language` | 项目技术栈已确定 | 技术栈专项编码/测试规则 |
| `database` | 项目使用持久化 | migration、schema、query、data integrity 规则 |
| `optimization-workflows` | 性能、延迟、吞吐或成本是明确需求 | benchmark 和 measurement loop |
| `research-apis` | 需要研究或 API discovery | search-first 和 source-quality 规则 |
| `operator-workflows` | GitHub、Jira、billing、Google Workspace 等外部应用已配置 | 带认证检查的操作 runbook |
| `agentmemory` | 长期多会话、多 Agent、跨 Hermes/Codex 记忆共享或重复解释成本高 | 可选记忆层；默认核心工具、零 LLM、无自动注入 |
| `orchestration` | 用户明确要求多 Agent 并行，且当前环境确实支持 | 使用已有编排能力；只补最小 ownership、handoff 和 merge gates |
| `devops-infra` | 部署、Docker 或基础设施进入范围 | 部署和回滚标准 |
| `media-generation` | 产品需要图片、音频、视频或 demo assets | 先用本地已有 media skills，再补充专项规则 |
| `document-processing` | 文档转换或翻译超出已安装 document 插件能力 | 参考 workflow |
| `machine-learning` | ML/MLOps 进入范围 | 数据契约、eval、监控、回滚 |
| `swift-apple` | 构建 Apple 平台软件 | Swift/SwiftUI 规则 |
| `social-distribution` | 发布或分发是产品需求 | 渠道专项清单 |
| `business-content` | 产品需要市场、SEO、投资人或内容工作流 | 内容/商业清单 |

## 参考或跳过

- 预测市场规则：只有产品明确涉及预测市场时参考。
- 供应链、物流或采购领域规则：只有项目领域需要时参考。
- 多语言文档：默认跳过；只有目标用户或交付语言需要时启用。
- Ponytail 外部运行时：默认跳过；只移植规则。安装 hooks、commands、statusline 或平台配置前必须得到明确批准并完成安全审查。

## 命令配方

以下命令模式仅供独立模式降级或补充 Superpowers 未覆盖的项目操作，不作为 slash commands 安装：

- Plan 和 feature development：组合模式由 Superpowers `brainstorming` 与 `writing-plans` 负责；独立模式使用 `docs/02-development-workflow.md` 的精简流程。
- Build fix：检测构建系统、运行失败命令、归类错误、一次修一个根因、重新运行失败命令。
- Checkpoint：验证当前状态、创建聚焦 Git 检查点、记录检查点、恢复时比较当前状态。
- 质量门禁：运行项目可用 formatter/linter/type/test/build 检查，不编造缺失脚本。
- Security scan：扫描 secrets、permissions、hooks/config、dependencies、raw HTML、API surfaces、MCP/tool config。
- 会话保存/恢复：保留已完成、失败尝试、变更文件、决策、阻塞项、精确下一步和验证状态。
- PR：验证分支状态、分析 commits 和 diff、使用 PR 模板、push、创建 PR、验证 CI。

## Hook 运行时策略

Hooks 是可选自动化，不是默认行为。

启用 hook 前：

- 项目必须有本地确定性命令供 hook 运行。
- hook 命令必须绑定本地项目依赖，或经过审查的绝对脚本。
- 阻塞 hook 必须有清晰失败消息和手动恢复路径。
- hook 不得静默发送代码、secrets、prompts 或文件内容到远程服务。
- 会修改文件的 hook 必须限定到编辑文件，不得大范围重写配置。
- hook 行为记录在 `docs/project-tooling.md` 或项目等效文档中。

适合的 hook：

- 格式化编辑文件
- lint 编辑文件
- 警告生产 `console.log` 或 debug 语句
- 增量 type check
- 阻止明显 secrets 或跳过验证的提交
- compaction 或交接前保存会话/检查点 metadata

避免的 hook：

- 每次编辑都跑长 build
- 自动安装包
- 覆盖本地配置
- 在项目未使用 tmux/worktrees 时强制要求
- 隐藏失败或吞掉非零退出码

## 编排策略

多 Agent、worktree、任务派发和分支完成默认关闭。只有用户明确要求并行执行且当前环境确实提供相应能力时才启用；已启用 Superpowers 时由其相关 Skills 负责，DW 不建立第二套调度协议。

独立模式不会因为任务较大而自行启用编排；缺少用户明确要求或环境能力时继续使用单 Agent。

并行工作前必须有：

- 带 owner、scope、branch/worktree、acceptance criteria、merge gate 的 work items
- 没有命名 integrator 时禁止重叠写入
- 每个 worker 有 handoff artifact
- 合并前运行确定性检查
- 共享代码、auth、data、deploy 或 config 变更要做安全/风险审查

不要为了让小任务显得复杂而使用编排。窄改动使用单 Agent 流程。

## 领域启用

项目明确技术栈或领域后，将对应条件规则加入项目本地文档：

- 技术栈规则写入 `docs/project-technical-decisions.md` 或栈专项文档。
- 数据库规则写入 migration/schema/runbook 文档。
- 部署规则写入部署/回滚文档。
- business/content/media/domain 规则写入产品专项文档。

启用决策只有在形成稳定约束或需要跨会话恢复时才记录到 `dev-logs/YYYY-MM-DD.md`。

## Hermes 适配

未来迁移到 Hermes 时：

- 以 `docs/02-development-workflow.md` 的 skills 表作为依赖清单。
- 优先迁移下载地址、触发条件、输入输出、质量门禁和日志格式。
- 本地绝对路径仅作为当前 Codex 环境说明，不作为 Hermes 运行依赖。
- Hook、命令和多 Agent 编排必须先转成 Hermes 可审查配置，再启用。
- 迁移完成后运行同样的质量门禁和执行追踪，不降低验证标准。
- 如果需要跨 Hermes 和 Codex 共享长期记忆，可按 `docs/13-agentmemory-adaptation.md` 评估 agentmemory；未明确需要时不要默认启用。
