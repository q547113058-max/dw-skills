# DW Skills 工作说明

DW 是项目治理层，不重复模型或 Superpowers 的通用开发能力。每次任务只读取本文件和被触发的专项文档。

## 第二大脑范围

- 云盘迁移前，仅 `CODEX_HOME=D:\Codex\home` 使用 `D:\Codex\vault`；其他环境保持关闭。
- `dw-skills` 只维护一个物理 checkout；活动路径可使用目录联接。
- 第二大脑禁止保存 secrets、凭据、私人原文或可由 Git 重建的大段内容。

## 启动路由

1. 选择任务级别：
   - `quick`：默认；明确、低风险、易回滚的窄改动。
   - `standard`：一般行为变化、多文件修改或需要自动化验证。
   - `high-risk`：架构、认证、敏感数据、支付、migration、部署、secrets 或不可逆操作。
2. 选择运行模式：Superpowers 可用为 `combined`，否则为 `standalone`；两者不得伪造或重复产物。
3. 只加载命中触发条件的文档：

| 触发条件 | 文档 |
| --- | --- |
| `standard` / `high-risk` 或 combined | `docs/15-superpowers-integration.md` |
| standalone 需要流程降级 | `docs/02-development-workflow.md` |
| 仓库缺少技术规则或触发安全边界 | `docs/03-technical-standards.md` |
| UI、页面、交互 | `docs/04-design-standards.md` |
| 需要执行清单 | `docs/05-execution-checklist.md` 对应级别 |
| 实质性记录或恢复 | `docs/06-development-log-standard.md`、`docs/10-session-checkpoints-and-recovery.md` |
| 代码关系超出直接阅读 | `docs/07-code-structure-analysis.md` |
| 已授权 GitHub 操作 | `docs/08-github-update-standard.md` |
| `standard` / `high-risk` 质量证据 | `docs/09-quality-gates-and-review-loop.md` |
| 条件工具、Hook、角色或领域规则 | `docs/12-conditional-quality-and-tooling-policy.md` |
| agentmemory 评估 | `docs/13-agentmemory-adaptation.md` |
| 实际调用或更新登记 skill | `docs/14-skill-update-policy.md` |

## 能力所有权

- `combined`：Superpowers 负责需求、计划、TDD、调试、通用审查、完成验证和分支生命周期。
- `standalone`：当前模型按用户要求、仓库规范和真实工具结果执行通用开发；DW 不复述模型原生方法。
- DW 只负责任务分级、UI/产品上下文、第二大脑、工具成本、条件安全/领域门禁、skill 治理和交付记录。
- 实际 GitHub、VPN、图谱和持久记忆状态由相应工具负责，模型推断不能替代工具结果。
- 一项能力只有一个负责人；已有计划、测试、审查或验证证据直接复用。

## 分级门禁

- `quick`：针对性验证和 diff 审查；没有长期价值时不创建日志、TODO、质量评级或检查点。
- `standard`：运行项目已有且相关的确定性检查；需要恢复或形成稳定决策时记录日志。
- `high-risk`：增加安全/专项审查、失败与回滚验证、恢复检查点和正式验证摘要。
- 无真实命令或证据不得宣称通过；不存在的工具和脚本不得编造。

## 外部状态边界

- GitHub mutation 只在用户明确授权或仓库已有交付策略时执行；不得默认 push、建 PR、合并或改设置。
- 网络失败时才检查 `vpn-mihomo`；命令级代理优先，系统代理必须由用户明确要求，任务结束后恢复。
- UI 任务默认使用 `frontend-design` 并主动匹配 `awesome-design-md`；其他设计 skill 只按职责增量调用。
- 代码理解默认直接读文件；关系问题才用 codegraph，架构或长期图谱问题才用 Graphify。
- agentmemory 和外部 skill runtime 默认不安装；启用、更新或迁移前先读取对应策略并确认权限。
