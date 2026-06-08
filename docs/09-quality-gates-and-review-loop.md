# 质量门禁和审查循环

每次代码变更都使用本标准。

## 确定性约束

主观审查前，优先运行项目支持的确定性检查。

推荐顺序：

1. Formatter
2. Linter
3. Type check
4. Structural tests
5. Unit tests
6. Integration tests
7. Build
8. Pre-commit hooks

示例：

```powershell
npm run format
npm run lint
npm run typecheck
npm test
npm run build
pre-commit run --all-files
```

使用项目真实命令。项目没有相应脚本时，不要编造命令。

## TDD 门禁

功能、Bugfix 和重构在有实际测试面时使用 TDD。

步骤：

1. 写用户旅程：

```text
As a [role], I want to [action], so that [benefit].
```

2. 先写最小有意义测试。
3. 修改生产代码前确认有效 RED。
4. 实现最小修复。
5. 重新运行同一测试目标，确认 GREEN。
6. GREEN 后再重构。
7. 重构后重新运行相关检查。

有效 RED 必须满足：

- 测试目标能编译或到达预期断言。
- 新增或修改的测试确实运行。
- 失败来自预期缺失行为或 Bug。
- 失败不是语法错误、缺依赖、测试环境坏掉或无关回归。

覆盖率目标：

- 项目有覆盖率工具时，目标 80%+。
- 变更行为要覆盖边界、错误路径和异常情况。
- 没有运行覆盖率命令时，不声称达到覆盖率。

仓库使用 Git 时，TDD 周期使用检查点：

- RED 验证后：`test: add reproducer for <feature-or-bug>`
- GREEN 验证后：`fix: <feature-or-bug>`
- 重构仍 GREEN 后：`refactor: clean up <feature-or-bug>`

## 结构测试

适合不依赖截图或主观判断的行为：

- 必要路由存在
- 必要组件可渲染
- 必要文件或生成产物存在
- API 响应形状符合契约
- 配置文件包含必要 key
- 可访问性 landmark 存在
- 禁止字符串、占位符、mock 名或 TODO 未进入交付

前端工作中，结构测试补充视觉 QA，但不能替代截图或浏览器检查。

## Pre-Commit

如果项目配置了 pre-commit：

```powershell
pre-commit run --all-files
```

如果未安装或未配置，记录事实。不要仅因为没有 pre-commit 框架而阻塞交付。

## 自动审查循环

重要或高风险变更使用：

1. 实现最小计划步骤。
2. 运行确定性检查。
3. 按需求和验收标准审查变更文件。
4. 修复阻塞问题。
5. 重新运行失败检查。
6. 重复直到阻塞问题解决。

阻塞问题包括：

- build 或 tests 失败
- 行为与需求冲突
- 用户流程缺少错误或空状态
- 可访问性回归
- 不安全数据处理
- 布局重叠、裁切或文字不可读
- 运行时需要的生成产物未提交

审查严重级别：

| 等级 | 含义 | 必须动作 |
| --- | --- | --- |
| CRITICAL | 安全漏洞、数据丢失、build 失败或核心流程阻塞 | 修复前不得交付 |
| HIGH | 可能 Bug、回归、缺少必要验证或测试 | 交付前修复，除非明确接受 |
| MEDIUM | 可维护性、清晰度、性能或覆盖率弱点 | 可行时修复，或记录理由 |
| LOW | 风格、命名或轻微打磨 | 可选 |

以下敏感变更必须先做安全审查：

- authentication 或 authorization
- 用户数据、支付或金融行为
- 数据库查询或 migration
- 文件系统操作
- 外部 API 调用和 webhooks
- 加密、secrets、tokens 或环境变量
- 原始 HTML、URL 构造、重定向或公开客户端 bundle

## 验证报告

重要变更后输出紧凑验证报告：

```text
验证报告

Build:     PASS/FAIL/SKIPPED
Types:     PASS/FAIL/SKIPPED
Lint:      PASS/FAIL/SKIPPED
Tests:     PASS/FAIL/SKIPPED
Security:  PASS/FAIL/SKIPPED
Diff:      reviewed/not reviewed

Overall:   READY / NOT READY / BLOCKED

Issues:
- ...
```

验证阶段：

1. Build 验证。
2. Type check。
3. Lint。
4. 测试套件和覆盖率。
5. 安全扫描：secrets、不安全模式、debug logging。
6. Diff 审查：意外变更、缺少错误处理和边界情况。

build 失败时，先修复，不继续更深验证。

## 条件前端质量门禁

项目使用 TypeScript、React 或 Web 前端栈时启用：

- Types：导出/公共 API、共享模型、组件 props 和回调有类型。
- Type safety：避免 `any`；不可信边界使用 `unknown` 并收窄。
- React Hooks：顶层调用、依赖数组完整、订阅/请求/监听/定时器有清理。
- State：避免存储可在 render 中计算的派生状态。
- Tests：行为测试优先使用可访问查询；API 行为尽量使用网络层 mock。
- Snapshots：避免大范围组件快照；视觉行为用视觉回归或浏览器检查。
- Accessibility：检查标签、role、键盘操作、focus 状态和 reduced-motion。
- Security：审查原始 HTML、危险 URL、`target="_blank"`、公开环境变量、客户端 auth gate 和 cookie-auth 表单 CSRF。
- Performance：检查图片尺寸、lazy/eager 策略、布局偏移、第三方脚本和 bundle 影响。

## 命令配方门禁

命令配方作为清单使用，不依赖 slash commands。

- Plan gate：大任务必须复述需求、提供本地模式证据、阶段、风险、验证和用户确认。
- Feature-dev gate：功能工作通过 discovery、codebase exploration、clarification、design、implementation、review、summary。
- 质量门禁配方：运行项目已有 formatter、linter、type check、tests、build、pre-commit；不编造缺失脚本。
- Security-scan recipe：相关时扫描 secrets、permissions、hooks/config、MCP/tool config、dependencies、auth、raw HTML、public bundle、external API。
- Build-fix recipe：用最小改动修复第一个根因错误，重新运行失败命令；重复失败或架构漂移时停止。
- PR recipe：验证分支状态、对比 base、遵循模板、包含测试计划、push、创建 PR、验证 CI。

## Hook 运行时门禁

Hooks 是可选自动化。只有能增强确定性质量且不隐藏风险时才启用。

启用或修改 hook 前确认：

- 项目有稳定本地命令可供 hook 运行。
- hook 作用域限定在编辑文件或明确事件。
- 阻塞行为和绕过/恢复方式已记录。
- hook 不安装包、不覆盖配置、不泄露数据、不意外运行长 build。
- hook 阻塞交付时记录结果。

适合的 hook：

- format-on-edit
- lint-on-edit
- incremental type checks
- debug-log warnings
- secret scans
- pre-commit quality checks
- session/checkpoint metadata capture

## 基于角色的 Agent 触发器

按触发条件使用角色支持，不按习惯滥用。项目栈未知前，不启用技术栈专项角色。

| 角色 | 触发条件 | 输出 |
| --- | --- | --- |
| 规划角色 | 复杂功能、架构变更、大范围重构、顺序不清 | 阶段计划、影响文件、风险、依赖、验证 |
| TDD 角色 | 有实际测试面的功能、Bugfix 或重构 | RED/GREEN/REFACTOR 目标、测试范围、覆盖率说明 |
| 代码审查角色 | 代码编辑后或共享分支提交/PR 前 | 按严重级别输出发现、具体失败模式、尽量给行引用 |
| 安全审查角色 | Auth、用户数据、支付、数据库、文件系统、外部 API、加密、secrets、原始 HTML、重定向或公开 bundle | 安全发现、修复建议、剩余风险 |
| 构建错误修复角色 | build、type check、lint 或 test 失败 | 根因错误、最小修复、复跑结果 |
| E2E 角色 | 关键用户旅程、高风险 UI 流程或浏览器专有行为 | 浏览器测试目标、可行时给截图或 trace |
| 技术栈专项审查角色 | 项目栈已知且变更文件触达该栈 | 使用本地栈规则做聚焦审查 |

审查质量规则：

- 只报告有具体触发条件、失败模式和影响文件/行为的问题。
- 不为证明审查存在而制造发现。
- 没有证据不要升级严重级别。
- 角色不得覆盖项目需求、用户指令、安全规则或确定性检查结果。
- 小型文档、文案或窄 UI 变更，可用本地审查替代多 Agent 审查。

## 生成和评估分离

不要让同一轮既生成方案又成为唯一质量证明。

小改动可以在同一会话中做独立审查轮。

大改动使用独立评估或审查角色，评估重点：

- 正确性
- 回归
- 缺失测试
- UX 和可访问性失败
- 安全或数据风险
- 部署阻塞

评估发现和处理结果记录到当天日志。

## Eval Harness

Agent 行为、prompt 变更、工作流规则或普通测试无法完全验证的产品行为，使用 eval-driven development。

实现前定义 eval：

```markdown
## EVAL: feature-name

Capability Evals:
- [ ] 新行为成功
- [ ] 边界场景成功

Regression Evals:
- [ ] 现有流程仍可用
- [ ] 现有输出形状兼容

Success Metrics:
- capability evals: 允许重试时 pass@3 >= 90%
- release-critical regression evals: pass^3 = 100%
```

优先使用最确定的评分器：

- code grader：scripts、tests、grep、schema checks
- rule grader：regex 或结构约束
- model grader：开放输出 rubric
- human grader：安全、产品判断或模糊 UX

Eval 报告包含：

- capability pass/fail
- regression pass/fail
- pass@1、pass@3 或 pass^k
- readiness status
- regressions 和下一步

避免：

- 只测 happy path
- prompt 过拟合已知样例
- 忽略成本或延迟漂移
- 用不稳定 grader 做发布门禁

## 持续学习

持续学习是轻量规则改进循环，不是自动规则堆积。

学习单元：

- 一个触发条件
- 一个动作
- 证据
- 置信度
- 范围：项目或全局

范围规则：

- 项目范围：技术栈约定、文件结构、代码风格、本地测试习惯。
- 全局范围：安全实践、通用验证行为、Git hygiene、跨项目重复 Agent 错误。

置信度：

- `0.3`：暂定
- `0.5`：中等
- `0.7`：强
- `0.9`：接近确定

提升到 `AGENT.nd` 的条件：

- 模式重复出现
- 有清晰证据
- 能防止真实失败或重复纠正
- 能写成包含触发条件、必须行为、禁止行为的可执行规则

不要在规则中保存原始私人对话或敏感代码，只保存可复用模式。
