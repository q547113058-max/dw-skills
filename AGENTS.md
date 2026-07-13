# DW Skills 工作说明

DW 是项目治理层，不是第二套通用开发生命周期。开始任务时先确定运行模式：

- **组合模式**：Superpowers 可用，由它负责需求、计划、TDD、调试、执行编排、代码审查、验证和分支完成。
- **独立模式**：Superpowers 不可用，使用 `docs/02-development-workflow.md` 的精简降级流程。

完整分工见 `docs/15-superpowers-integration.md`。

## 启动

1. 检查 Git 状态、当前分支、最近提交和用户已有改动。
2. 读取当天或最近的 `dev-logs/`、项目 TODO 和任务相关文档。
3. 检测 Superpowers 是否在当前 Agent 环境可用，记录运行模式。
4. 组合模式下继续 Superpowers 当前阶段；不要重新生成它已有的产物。
5. 只加载当前任务需要的 DW 规则。

## DW 增量规则

### UI 与产品上下文

- UI 任务读取 `docs/04-design-standards.md` 并使用可用的 `frontend-design`。
- 审美方向由 `taste-skill` / `design-taste-frontend` 负责；`frontend-design` 将方向落实为 token 和视觉 QA。
- 使用 `awesome-design-md` 时只读取最匹配的 DESIGN.md，并记录采用与禁用项。
- 持续 UI 项目维护 `docs/project-product-context.md` 和 `docs/project-design-spec.md`。

### 工具成本分级

- 默认先用 `rg`、直接读文件和现有测试。
- 需要轻量依赖图时使用 codegraph。
- 只有跨模块理解或长期知识沉淀确有价值时才使用 Graphify。
- agentmemory 只用于长期多会话、多 Agent 或跨环境共享需求。
- 调用登记 Skill 前遵守 `docs/14-skill-update-policy.md`。

### 精简实现

写代码前依次检查：是否需要、仓库已有实现、标准库、平台能力、已安装依赖、最小实现。禁止未请求的抽象、脚手架和投机扩展。Bugfix 修根因和共享入口。

### 条件门禁

- 项目已有 formatter、lint、type check、tests、build 时运行相关检查。
- 敏感边界启用安全审查；技术栈已确定时才启用专项规则。
- UI 交付补充响应式、可访问性和视觉检查。
- AI 工作流或 prompt 变更按需使用 eval，而不是把 eval 强加给普通文档改动。

Superpowers 已完成的 TDD、review 或 verification 可直接作为 DW 的证据，不重复执行同目的流程。DW 只补充项目特有的检查。

## 记录与交付

- 实质性任务更新当天 `dev-logs/YYYY-MM-DD.md`；窄小、无后续价值的任务可不创建日志。
- 记录运行模式、DW 增量规则、变更文件、验证结果、阻塞项和下一步。
- 重要决策同步到项目文档，不只留在聊天中。
- 重复 Agent 错误有明确证据时，才提升为项目规则。
- GitHub 操作遵守 `docs/08-github-update-standard.md` 和用户授权；不要把“修改文件”自动解释为获准 push、建 PR 或合并。

## 禁止重复

- 不在 brainstorming 之后再次要求用户填写完整需求模板。
- 不在 writing-plans 之后再生成 DW 阶段计划。
- 不在 Superpowers TDD 之外再运行一套 DW TDD 仪式。
- 不在 review/verification 已通过后仅为形式重复同类审查。
- 不同时维护两套任务状态；优先使用当前执行计划，DW 日志只保存恢复摘要。
