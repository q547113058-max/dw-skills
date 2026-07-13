# 质量门禁和审查循环

组合模式下，Superpowers 负责通用 TDD、代码审查和完成验证。DW 质量门禁只补充项目特有风险，不创建第二套同目的流程。

## 证据复用

以下 Superpowers 产物可直接作为 DW 证据：

- `test-driven-development` 的有效 RED、GREEN 和重构后测试结果。
- `systematic-debugging` 的根因证据。
- requesting/receiving review 的发现和处理结果。
- `verification-before-completion` 的最新命令输出。

DW 日志记录引用和结论即可，不复制整段输出。若证据过期、变更范围扩大或关键文件在验证后又被修改，重新运行相关检查。

## 确定性检查

运行项目已经提供且与改动相关的命令：

1. Formatter
2. Linter
3. Type check
4. Unit / integration / structural tests
5. Build
6. 已配置的 pre-commit hooks

不编造缺失脚本，不仅因为某个工具未安装就阻塞交付。记录 `PASS`、`FAIL` 或带原因的 `SKIPPED`。

## DW 增量门禁

### UI 与前端

触发条件：页面、组件、交互、样式或公开 Web 输出发生变化。

- 检查桌面和移动布局、溢出、重叠和文本可读性。
- 检查键盘、焦点、标签、role、reduced-motion 和颜色对比度。
- 检查加载、空、错误、禁用和成功状态。
- 检查危险 URL、原始 HTML、公开环境变量和客户端 auth 边界。
- 视觉行为使用浏览器或截图检查；结构测试不能替代视觉 QA。

### 安全

触发条件：auth、用户数据、支付、数据库、文件系统、外部 API、webhook、加密、secrets、环境变量、原始 HTML、重定向或公开 bundle。

审查输入验证、权限边界、数据暴露、失败模式、依赖和回滚风险。CRITICAL/HIGH 问题在交付前修复，除非用户明确接受且不违反安全边界。

### 技术栈与领域

只有项目栈和变更范围明确时加载 `docs/12-conditional-quality-and-tooling-policy.md` 的相关规则。不要运行无关语言或框架清单。

### AI 与 Prompt

只有普通测试无法稳定评估的 Agent 行为或 prompt 变化才使用 eval。定义能力、回归、评分方式和发布阈值；普通文档变更不需要 eval 仪式。

## 精简审查

代码编辑后检查：

- 是否重复实现已有 helper、标准库、平台能力或已安装依赖。
- 是否新增未请求的接口、工厂、包装层、配置层或脚手架。
- Bugfix 是否位于根因和共享入口。
- 是否能删除文件、依赖或样板代码而不降低正确性。

只记录有证据的发现；没有发现时一句说明即可。

## 何时需要独立专项审查

满足任一条件时，在 Superpowers 通用 review 之外追加专项审查：

- 安全敏感边界。
- 高风险 UI 用户旅程或可访问性要求。
- 数据迁移、兼容性或不可逆行为。
- 技术栈特有并且通用审查未覆盖的失败模式。

窄小文档、文案或低风险配置变更不要求多 Agent 审查。

## 验证摘要

```text
Mode: combined / standalone
Superpowers evidence: reused / unavailable / stale
Project checks: PASS / FAIL / SKIPPED
DW UI gate: PASS / FAIL / N/A
DW security gate: PASS / FAIL / N/A
DW stack/domain gate: PASS / FAIL / N/A
Diff: reviewed / not reviewed
Overall: READY / NOT READY / BLOCKED
Remaining risk: ...
```

只有最新证据支持时才能报告 `READY`。构建或关键测试失败、核心流程阻塞、安全高风险未处理时报告 `NOT READY` 或 `BLOCKED`。
