# Superpowers 集成策略

本文件定义 DW 与 `obra/superpowers` 的组合边界。目标是获得 Superpowers 的可执行开发方法论，同时保留 DW 的项目治理能力，避免重复提问、重复计划和重复审查。

## 运行模式检测

任务开始时检查当前 Agent 环境是否暴露 Superpowers Skills 或插件能力。

- 可用：记录 `Mode: combined`。
- 不可用：记录 `Mode: standalone`，说明一次后使用 DW 降级流程。
- 无法确认：以不可用处理，不伪造 Skill 调用结果。

模式只描述能力是否存在，不要求安装插件。安装、更新或启用 Superpowers 必须由用户或当前环境的插件策略授权。

## 唯一负责人矩阵

| 阶段/能力 | 组合模式负责人 | DW 的增量职责 |
| --- | --- | --- |
| 需求与方案 | `brainstorming` | 补充项目模板中仍缺失的硬约束；UI 时补产品上下文 |
| 实施计划 | `writing-plans` | 补充 DW 条件门禁和需要更新的项目记录 |
| 隔离环境 | `using-git-worktrees` | 检查本地路径、用户改动和项目恢复记录 |
| 实现 | `executing-plans` 或 `subagent-driven-development` | 工具成本分级、UI 规则、Ponytail 精简原则 |
| TDD | `test-driven-development` | 接受其 RED/GREEN 证据，不建立第二套周期 |
| 调试 | `systematic-debugging` | 记录项目特有根因和恢复信息 |
| 代码审查 | `requesting-code-review` / `receiving-code-review` | 只补安全、UI、技术栈或领域专项审查 |
| 完成验证 | `verification-before-completion` | 汇总 DW 增量检查和无法运行项 |
| 分支完成 | `finishing-a-development-branch` | 更新日志和 GitHub 交付记录 |

## 冲突优先级

1. 用户当前明确指令和仓库本地规则。
2. 安全、隐私、权限和不可逆操作限制。
3. Superpowers 当前阶段的通用流程规则。
4. DW 项目级增量规则。
5. 外部参考 Skill 的建议。

冲突时保留更具体的项目约束，但不要静默破坏 Superpowers 的阶段不变量，例如跳过有效 RED 或在验证前宣称完成。记录冲突、选择和理由。

## 产物复用

- Superpowers 设计文档可作为 DW 的需求依据；只补缺失字段，不复制全文。
- Superpowers 实施计划是唯一任务清单；DW 日志只记录当前阶段、完成项和恢复入口。
- Superpowers 测试输出和 review 结果可直接进入 DW 验证摘要。
- Worktree 或分支信息只保存引用，不在 DW 创建平行状态。

## DW 增量门禁触发器

| 触发条件 | 加载的 DW 规则 |
| --- | --- |
| UI、页面、前端交互 | `docs/04-design-standards.md`，设计 Skills，浏览器/截图 QA |
| 长期或跨会话任务 | `docs/06-development-log-standard.md`、`docs/10-session-checkpoints-and-recovery.md` |
| 复杂代码理解 | `docs/07-code-structure-analysis.md` |
| GitHub 交付 | `docs/08-github-update-standard.md` |
| 安全或栈专项风险 | `docs/09-quality-gates-and-review-loop.md`、`docs/12-conditional-quality-and-tooling-policy.md` |
| Skill 安装、更新或迁移 | `docs/14-skill-update-policy.md` |

没有触发条件时不加载对应规则。

## 独立模式降级

Superpowers 不可用时，当前模型是通用开发负责人，按用户要求、仓库规范和真实工具结果工作。DW 不建立第二套模型方法，只保证以下治理闭环：

1. 确认目标、验收标准和关键限制。
2. 检查代码库和现有模式。
3. 对非 `quick` 任务保留可验证的范围和验收证据。
4. 运行项目已有且相关的确定性检查。
5. 审查触发的 UI、安全、技术栈、恢复和交付增量。
6. 需要时更新恢复记录，并按授权完成 GitHub 交付。

模型原生的实现、调试和普通审查不在 DW 文档中重复描述。独立模式不模拟不存在的 hooks、插件事件或子 Agent；能力缺失应透明报告。

## 反重复检查

任务每次进入新阶段时只问三个问题：

1. 这个产物是否已经存在？
2. 当前动作是否新增项目特有价值？
3. 删除这个 DW 步骤会不会丢失安全、UI、恢复或交付证据？

如果前两项分别为“是”和“否”，跳过该步骤。
