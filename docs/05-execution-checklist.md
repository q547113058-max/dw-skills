# DW 分级执行清单

只执行一个任务级别，并叠加已触发的专项模块。

## 模式

- [ ] Superpowers 可用为 `combined`，否则为 `standalone`。
- [ ] combined 复用其计划、TDD、调试、审查和验证；standalone 由当前模型按仓库规则执行。
- [ ] 不维护第二套同目的产物或任务状态。

## Quick

- [ ] 范围明确、低风险、易回滚；否则升级。
- [ ] 只加载触达文件和命中的专项规则。
- [ ] 使用真实的针对性验证并审查 diff。
- [ ] 没有长期价值时不创建日志、TODO、评级或检查点。

## Standard

- [ ] 定义影响范围和验收证据，加载相关增量规则。
- [ ] 运行项目已有且相关的确定性检查。
- [ ] combined 复用 Superpowers 证据；standalone 不制造形式化流程。
- [ ] 有恢复价值或稳定决策时更新日志。

## High-Risk

- [ ] 明确敏感边界、失败路径、兼容性和回滚方案。
- [ ] 增加安全或技术栈专项审查。
- [ ] 验证正常、失败和边界场景，必要时运行集成/E2E。
- [ ] 创建恢复检查点并输出正式验证摘要。

## 专项触发器

| 触发 | 增量动作 |
| --- | --- |
| UI | `docs/04-design-standards.md`、`frontend-design`、主动匹配 `awesome-design-md` |
| 复杂代码关系 | codegraph；架构/长期图谱才用 Graphify |
| 长期多会话记忆 | 评估 `docs/13-agentmemory-adaptation.md` |
| GitHub 交付 | 先确认授权，再读 `docs/08-github-update-standard.md` |
| 网络失败 | 检查 `vpn-mihomo`，优先命令级代理 |
| 外部 skill | 只检测和加载实际调用的 skill |
| Auth、数据、支付、migration、部署、secrets | 升级 `high-risk` 并加载相关安全/领域门禁 |

## 升级

- 范围扩大、行为不确定或需要自动化验证：`quick` -> `standard`。
- 触达敏感或不可逆边界：任意级别 -> `high-risk`。
- 用户要求更严格流程时升级；不得因最终 diff 短而降级。
