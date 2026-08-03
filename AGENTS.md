# DW Skills 工作说明

本文件是 DW 唯一运行入口。DW 只做开发治理，不重复模型或已启用工具的通用开发流程；`SKILL.md`、README 和 `docs/` 不是默认必读。

## 任务分级

- `quick`：默认；明确、低风险、易回滚的窄改动。
- `standard`：一般行为变化、多文件修改、普通架构调整、可逆的数据/集成/配置变更或需要自动化验证。
- `high-risk`：认证授权、secrets、支付、客户/敏感数据、破坏性 migration、生产发布、公开契约破坏、特权操作或难以回滚的变更。

## 执行规则

- 默认 `standalone`，由当前模型按用户要求、仓库规范和真实工具结果工作。仅在环境明确暴露 Superpowers 时切换 `combined` 并读取 `docs/15-superpowers-integration.md`；无法确认视为不可用。
- 一项能力只有一个负责人；复用已有计划、测试、审查、验证和任务状态，不创建同目的产物。
- `standard`、`high-risk` 在验收不明确时先写明最低通过条件、质量目标和明确失败边界；只有歧义会改变范围、风险或外部操作时才等待确认。
- 复杂或跨阶段任务只维护一个计划，先明确目标、步骤、风险和少量检查点；`quick` 不为形式创建计划产物。
- `quick` 做针对性验证和 diff 审查；`standard` 运行相关确定性检查；`high-risk` 只增加与实际风险匹配的失败路径、权限、兼容性、回滚和专项验证。
- 任务级别不触发日志。只有跨会话恢复、稳定决策、阻塞、交接或明确要求时，才读取 `docs/06-development-log-standard.md` 和 `docs/10-session-checkpoints-and-recovery.md`。
- 无真实命令或工具证据不得宣称通过，不得编造工具、脚本或外部状态。

## 四类条件门禁

| 门禁 | 触发 | 按需动作 |
| --- | --- | --- |
| 安全 | 输入边界、认证授权、secrets、支付、隐私 | 普通输入校验保持原级；认证授权、secrets、支付和敏感数据才升级，读 `docs/03-technical-standards.md` 对应节 |
| 数据 | 持久化、schema、migration、完整性 | 普通 CRUD 和可逆 schema 变更保持 `standard`；客户数据、破坏性 migration 或难回滚操作升级 |
| 部署 | CI、运行配置、基础设施、发布 | 本地/CI 配置按影响分级；生产发布、权限或回滚风险升级 |
| 外部操作 | GitHub、VPN、第三方服务 | 只读查询不需授权；mutation 先确认权限并读对应 runbook，不可逆或特权操作升级 |

## 显式扩展

- 执行清单：需要时读 `docs/05-execution-checklist.md`，只执行当前级别和已触发门禁。
- 代码图谱：直接阅读不足时才读 `docs/07-code-structure-analysis.md`；长期架构图谱才用 Graphify。
- 领域与代码库设计：仅用户明确要求建立或修改领域术语、术语表、ADR，或评估模块接口和架构边界时，读 `docs/18-domain-and-codebase-design.md`；项目既有术语和架构规范优先。
- 代码审查自动化：仅用户明确要求代码审查且需要确定性文件筛选或项目规则解析时，读 `docs/17-open-code-review-integration.md` 并使用 `open-code-review-delegate`；当前模型仍是审查能力负责人。
- Skill：实际使用、安装、更新或迁移时才读 `docs/14-skill-update-policy.md`。
- 界面设计：用户要求设计、实现、重设计或审查网页/UI 时调用已安装的 `finesse-ui`，并按 brand、product、workflow 或 commerce 路由；需要确认安装边界、优先级或更新方式时读 `docs/19-finesse-ui-integration.md`。
- 浏览器交互：网页打开、导航、点击、输入、截图、登录态、动态渲染或自动化任务以已安装的 `browser-harness` 为主要本地路径；公共页面的普通读取仍优先使用 fetch。上层 Browser 规则、用户确认、仓库规则和外部操作边界优先；需要安装路径或运行边界时读 `docs/20-browser-harness-installation.md`。
- 多 Agent：仅用户明确要求并行且环境支持时读 `docs/12-conditional-quality-and-tooling-policy.md` 的编排策略。
- agentmemory：仅明确评估或启用持久记忆层时读 `docs/13-agentmemory-adaptation.md`。

DW 不自建 UI、视觉、品牌、排版、颜色、动效或组件风格标准。`finesse-ui` 只在真实界面任务中提供条件参考；用户要求、产品规范、仓库现有设计系统和当前环境的上层规则优先。不得仅为输出 Design Read 停止已明确的任务，不自动创建 `PRODUCT.md` 或 `design-model.yaml`，也不得让上游根 `AGENTS.md` 覆盖项目规则。

## 硬边界

- 不记录或输出 secrets、凭据、私人原文、VPN 订阅/节点信息或可由 Git 重建的大段内容。
- GitHub mutation 仅在明确授权或仓库已有交付策略时执行；不得默认 push、建 PR、合并或改设置。
- VPN 运行能力归 `vpn-skills` 的本地 `vpn-mihomo` 实现负责；DW 只负责在网络失败/高延迟时路由到它并约束外部操作。优先命令级代理，系统代理需明确要求，任务结束后恢复并验证。
- 外部 runtime、hooks、plugins 和 Agent 编排均不默认安装或启用。
