# DW Skills 工作说明

本文件是 DW 唯一运行入口。DW 只做开发治理，不重复模型或已启用工具的通用开发流程；`SKILL.md`、README 和 `docs/` 不是默认必读。

## 任务分级

- `quick`：默认；明确、低风险、易回滚的窄改动。
- `standard`：一般行为变化、多文件修改或需要自动化验证。
- `high-risk`：架构、认证、敏感数据、支付、migration、部署、secrets 或不可逆操作。

## 执行规则

- 默认 `standalone`，由当前模型按用户要求、仓库规范和真实工具结果工作。仅在环境明确暴露 Superpowers 时切换 `combined` 并读取 `docs/15-superpowers-integration.md`；无法确认视为不可用。
- 一项能力只有一个负责人；复用已有计划、测试、审查、验证和任务状态，不创建同目的产物。
- `quick` 做针对性验证和 diff 审查；`standard` 运行相关确定性检查；`high-risk` 增加专项审查、失败路径、回滚验证和正式摘要。
- 任务级别不触发日志。只有跨会话恢复、稳定决策、阻塞、交接或明确要求时，才读取 `docs/06-development-log-standard.md` 和 `docs/10-session-checkpoints-and-recovery.md`。
- 无真实命令或工具证据不得宣称通过，不得编造工具、脚本或外部状态。

## 四类条件门禁

| 门禁 | 触发 | 按需动作 |
| --- | --- | --- |
| 安全 | 认证、授权、secrets、不可信输入、支付、隐私 | 读 `docs/03-technical-standards.md`、`docs/09-quality-gates-and-review-loop.md` 和 `docs/12-conditional-quality-and-tooling-policy.md` |
| 数据 | schema、migration、持久化、客户数据、完整性 | 使用上述技术、质量和条件规则 |
| 部署 | CI/CD、基础设施、运行配置、发布、回滚 | 使用上述技术、质量和条件规则 |
| 外部操作 | GitHub、VPN、第三方服务或外部 mutation | 先确认权限再读对应 runbook；GitHub 读 `docs/08-github-update-standard.md` |

## 显式扩展

- 执行清单：需要时读 `docs/05-execution-checklist.md`，只执行当前级别和已触发门禁。
- 代码图谱：直接阅读不足时才读 `docs/07-code-structure-analysis.md`；长期架构图谱才用 Graphify。
- Skill：实际使用、安装、更新或迁移时才读 `docs/14-skill-update-policy.md`。
- 第二大脑：仅迁移、恢复或跨环境同步时读 `docs/16-second-brain-deployment.md`。
- 多 Agent：仅用户明确要求并行且环境支持时读 `docs/12-conditional-quality-and-tooling-policy.md` 的编排策略。
- agentmemory：仅明确评估或启用持久记忆层时读 `docs/13-agentmemory-adaptation.md`。

DW 不提供 UI、视觉、品牌、排版、颜色、动效或组件风格标准，也不默认调用设计类 Skill。界面要求只来自用户、产品规范、仓库现有设计系统和当前环境的上层规则。

## 硬边界

- 不记录或输出 secrets、凭据、私人原文、VPN 订阅/节点信息或可由 Git 重建的大段内容。
- GitHub mutation 仅在明确授权或仓库已有交付策略时执行；不得默认 push、建 PR、合并或改设置。
- 网络失败后才检查 `vpn-mihomo`；优先命令级代理。系统代理需明确要求，任务结束后恢复并验证。
- 外部 runtime、hooks、plugins、Agent 编排和第二大脑扩展均不默认安装或启用。
