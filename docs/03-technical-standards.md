# DW 技术增量标准

仓库本地规则、用户要求和当前模型的通用工程能力优先。本文只定义 DW 需要额外强制的项目治理，不重复命名、函数长度、常规重构、一般测试写法等模型原生建议。

## 何时读取

- 仓库缺少明确技术规则。
- 变更触达共享数据、外部输入、认证、支付、持久化、文件系统、外部 API、部署或 secrets。
- 需要记录项目级技术决策或选择确定性门禁。

普通 `quick` 文档、文案或低风险样式改动不读取本文件。

## 项目决策

- 重大架构、依赖、数据模型、构建或部署决策写入项目技术决策文档。
- 先复用仓库、标准库、平台能力和已安装依赖；Ponytail 只作为反过度工程增量检查。
- codegraph、Graphify 和 agentmemory 按 `docs/07-code-structure-analysis.md` 与 `docs/13-agentmemory-adaptation.md` 的触发条件使用。

## 不可信边界

- 用户输入、外部数据、文件、API 响应和环境变量在验证前均不可信。
- 状态变更必须在可信边界完成验证和授权。
- secrets 不得进入源码、日志、公开环境变量、客户端 bundle 或交付文档。
- 认证、授权、用户数据、支付、数据库、文件系统、外部 API、加密和 secrets 自动升级为 `high-risk`。

## 确定性门禁

- `quick`：运行最接近改动的现有检查或人工验证。
- `standard`：运行项目已有且相关的 formatter、lint、type check、tests 或 build。
- `high-risk`：补充失败路径、边界、权限、回滚和必要集成/E2E 验证。
- 不编造缺失脚本；跳过关键检查时说明原因。

Superpowers 或仓库 CI 已提供的最新证据直接复用；证据过期或验证后继续改动时重新运行。

## 条件专项

- 技术栈和领域规则只在栈与影响范围明确时从 `docs/12-conditional-quality-and-tooling-policy.md` 加载。
- GitHub 交付只按 `docs/08-github-update-standard.md` 和用户授权执行。
