# 分级执行清单

先选择一个级别。默认使用 `quick`；出现升级条件时立即切换，不需要把三个清单全部执行。

## 运行模式

- [ ] 检测 Superpowers：可用为 `Mode: combined`，不可用为 `Mode: standalone`，无法确认按 unavailable 处理。
- [ ] combined 模式复用 Superpowers 的需求、计划、TDD、调试、审查、验证和分支产物，不建立第二套同目的流程。
- [ ] standalone 模式使用 `docs/02-development-workflow.md` 的精简降级，不模拟不存在的 hooks、插件事件或子 Agent。
- [ ] 任务级别控制流程深度，运行模式控制通用生命周期负责人；两者独立。

## Quick

适用于需求明确、低风险、容易回滚的单文件或少量文件改动。

### 开始

- [ ] 读取 `AGENTS.md`，检查 `git status` 和触达文件。
- [ ] 确认目标、现有模式、用户改动和最小验证方式。
- [ ] 搜索可复用实现，应用 Ponytail 精简阶梯。

### 编辑和验证

- [ ] 只修改当前需求需要的文件，不做无关重构。
- [ ] 运行最接近改动的测试、lint、构建片段或人工检查。
- [ ] 审查 diff，确认没有 secrets、调试输出、意外文件或明显回归。

### 交付

- [ ] 简要说明变更、验证和剩余问题。
- [ ] 没有重要决策、阻塞或后续待办时，不创建开发日志、质量评级或 Git 检查点。
- [ ] 只有用户要求或仓库策略要求时才提交、推送或创建 PR。

## Standard

适用于一般功能、行为变化、多文件 Bugfix、需要短计划或有实际自动化测试面的工作。执行 Quick，并增加：

### 开始

- [ ] 读取 `docs/02-development-workflow.md`、`docs/03-technical-standards.md` 和任务相关专项文档。
- [ ] combined 模式读取 `docs/15-superpowers-integration.md`，并以现有 Superpowers 计划作为唯一任务清单。
- [ ] 定义范围、预期结果、影响文件、风险和验证方式。
- [ ] 创建或更新当天开发日志；跨步骤工作维护简短 TODO。
- [ ] 功能、Bugfix 或重构有实际测试面时，定义 RED/GREEN 目标。

### 编辑和验证

- [ ] 运行项目已有的相关 formatter、linter、type check、tests 或 build；不运行无关全量工具。
- [ ] combined 模式复用 Superpowers TDD/review/verification 证据；standalone 行为变化有测试面时使用 TDD。
- [ ] 只补充尚未覆盖的代码、精简、UI、安全、栈或领域审查，修复阻塞问题后重跑失败检查。

### 交付

- [ ] 在日志中记录变更、验证、阻塞项和下一步。
- [ ] 给出与证据一致的 A、B、C 或 Blocked 等级。
- [ ] 跨会话或仓库策略要求时创建聚焦 Git 检查点。

## High-Risk

适用于架构、认证、授权、用户数据、支付、数据库 migration、文件系统、部署、外部 API、加密、secrets、大范围重构或困难恢复。执行 Standard，并增加：

- [ ] 读取 `docs/09-quality-gates-and-review-loop.md`、`docs/10-session-checkpoints-and-recovery.md`、`docs/11-execution-tracking-quality-feedback.md` 和相关安全/领域规则。
- [ ] 明确回滚方案、敏感边界、失败路径、数据兼容性和发布门禁。
- [ ] 使用完整相关确定性检查、独立代码审查和安全审查。
- [ ] 关键用户旅程可行时做集成或 E2E 验证。
- [ ] 每个连贯且已验证的阶段创建恢复检查点。
- [ ] 交付报告说明 Build、Types、Lint、Tests、Security 和 Diff 状态，以及未运行项的原因。

## 条件模块

以下项目只在触发时执行：

- **UI**：读取 `docs/04-design-standards.md` 和 `frontend-design`；按现有规则主动匹配 `awesome-design-md`。持续 UI 项目才维护产品/设计上下文文件。
- **代码关系**：直接阅读无法判断关系时读 `docs/07-code-structure-analysis.md`；轻量关系用 codegraph，架构/长期图谱再用 Graphify。
- **长期记忆**：长期多会话、多 Agent 或跨 Hermes/Codex 共享时读 `docs/13-agentmemory-adaptation.md`。
- **Superpowers**：可用时负责通用开发生命周期；DW 只增加项目特有门禁，一项能力只保留一个负责人。
- **网络/VPN**：联网命令出现超时、DNS 或连接失败时才检查 `vpn-mihomo`；只检查订阅或配置时不启动代理。
- **Skills 周检**：实际调用某个已登记外部 skill 前，只检测该 skill；未调用的 skill 不检查。
- **GitHub**：用户明确要求提交、推送、PR，或仓库有明确自动交付策略时才读取并执行 `docs/08-github-update-standard.md`。
- **角色、Hook、编排和领域规则**：只有 `docs/12-conditional-quality-and-tooling-policy.md` 的触发条件成立时启用。

## 升级规则

- `quick` 影响范围扩大、出现行为不确定性、需要多步计划或自动化测试时，升级为 `standard`。
- 任何级别触达认证、授权、敏感数据、支付、migration、部署、secrets 或不可逆操作时，升级为 `high-risk`。
- 用户明确要求更严格的计划、测试、审查、记录或 GitHub 交付时，按要求升级。
- 不因任务最终 diff 很短而降低已经触发的风险等级。
