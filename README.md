# DW Skills

`dw-skills` 是轻量分级开发治理：按任务风险启用测试、安全、审批与交付门禁。

DW 不是产品运行技术栈，也不实现第二套通用开发方法。它只保留项目级治理：任务分级、条件门禁、权限与外部状态边界、必要的恢复记录。

## 结构

- 唯一执行入口：`SKILL.md`。
- DW 自身的改动规则：`AGENTS.md`。
- 执行期条件参考放在 `references/`，标准与流程文档放在 `docs/`，只在真实触发时读取。
- 反向工程任务（已发布二进制、打包或 Electron/JavaScript 应用、网页及其网络流量、托管程序集、固件、运行时行为）路由到 `references/reverse-engineering.md`。

## 核心原则

- `quick` 是默认级别；`standard` 与 `high-risk` 按风险触发，级别不改变执行时不额外声明。
- 条件门禁与验证强度内联在 `SKILL.md`：门禁分安全、数据、部署、外部操作四类。
- 项目文件、Git 和可验证的一手来源是事实依据；计划、日志、历史摘要和自动记忆都不能覆盖它们。
- 稳定决策写入项目既有的规则或决策文件；日志只是恢复摘要与决策索引。
- 冲突按「用户最新指令 → 当前仓库规则 → Git → 可验证事实」的顺序解决。
- 只维护一份计划；不为同一任务另建并行的计划、决策或状态产物。
- 自动记忆从 `candidate` 起步，只有在当前事实核实后才升级为 `reviewed`。
- 没有真实触发时不加重量级的计划、评审、E2E、回滚演练、日志或编排。

## 参考

- 条件门禁与验证强度已内联在 `SKILL.md`，没有独立的 governance-gates 参考文件。
- 恢复与交接：`references/recovery-and-logs.md`
- GitHub 变更：`references/github-mutation.md`
- GitHub 更新标准：`docs/08-github-update-standard.md`
