# agentmemory 适配评估

本文件记录 `rohitg00/agentmemory` 与当前开发流程的适配程度。

来源仓库：`https://github.com/rohitg00/agentmemory`

## 结论

适配程度：中高，但不默认启用。

适合场景：

- 长期多会话项目。
- 多 Agent 协作，需要共享会话记忆。
- 用户需要在 Codex、Hermes 或其他 MCP 客户端之间共享历史上下文。
- 重复解释架构、偏好、决策和历史 Bug 的成本明显变高。
- 项目已经进入持续迭代，而不是一次性小工具。

不适合默认启用的场景：

- 轻量项目、单页小工具、短期需求。
- 只需要当前会话内的 TODO、开发日志和 Git 检查点。
- 机器端口、Node 版本、MCP 配置或隐私边界不清楚。
- 用户不希望后台服务记录会话和工具行为。

## 仓库信息

- Star：约 `21,790`。
- License：Apache-2.0。
- 包名：`@agentmemory/agentmemory`。
- Node 要求：`>=20`。
- 默认本地服务端口：`3111` REST/MCP，`3113` viewer，另有 iii engine 端口。
- Windows：官方建议 WSL2；原生 Windows 能运行部分能力，但 `connect` 和自动 engine 安装有限制。

## Hermes 适配

仓库包含 `integrations/hermes/`，官方文档明确支持 Hermes。

Hermes 接入方式：

1. MCP server：在 `~/.hermes/config.yaml` 添加 agentmemory MCP server。
2. Memory provider plugin：复制 `integrations/hermes` 到 Hermes plugins 目录，获得更深的生命周期集成。

Hermes 能获得：

- MCP 记忆工具。
- 会话前记忆预取。
- turn capture。
- session end 标记。
- compaction 前上下文注入。
- MEMORY.md 写入镜像。
- session start 的 project profile 注入。

## 与当前工作流的关系

agentmemory 不替代：

- `AGENTS.md`
- `docs/`
- `dev-logs/YYYY-MM-DD.md`
- Git 检查点
- GitHub 更新标准
- TDD 和质量门禁

agentmemory 只补充：

- 跨会话记忆。
- 跨 Agent 共享历史。
- 决策、偏好、历史问题和反复出现模式的可检索存储。

当前工作流的每日日志仍是权威交接记录。agentmemory 的召回结果必须与项目文件、Git 历史或日志交叉确认。

## 启用边界

默认不启用。

满足以下任意条件时可以评估：

- 项目预计持续迭代超过 2 周。
- 同一项目已经出现 3 次以上重复解释。
- 多个 Agent 或多个工具需要共享历史上下文。
- 准备迁移到 Hermes，并希望记忆层跟随迁移。
- 用户明确要求安装或接入 agentmemory。

启用前必须确认：

- Node.js >= 20。
- 端口 `3111`、`3113` 等未冲突，或已设置替代端口。
- 数据存储位置和隐私边界明确。
- 是否需要 `AGENTMEMORY_SECRET`。
- 是否只暴露核心工具。
- 是否允许 hooks 捕获工具行为。
- 是否允许自动注入上下文。
- 是否允许 LLM 自动压缩。
- 如何停止、备份、导出和删除记忆。

## 默认配置建议

轻量安全默认：

```env
AGENTMEMORY_TOOLS=core
AGENTMEMORY_INJECT_CONTEXT=false
AGENTMEMORY_AUTO_COMPRESS=false
GRAPH_EXTRACTION_ENABLED=false
CONSOLIDATION_ENABLED=false
```

原则：

- 先使用零 LLM 模式。
- 先使用核心工具，不默认暴露全部工具。
- 不默认启用自动注入。
- 不默认启用自动压缩。
- 不默认启用 hooks。
- 不默认把记忆层作为质量证明。

## 风险

- 后台服务增加运行复杂度。
- MCP 工具面较大，默认全量工具会增加 Agent 选择噪音。
- Hook 自动捕获可能记录敏感上下文。
- 自动注入可能增加 token 成本或污染当前任务上下文。
- 自动压缩需要 LLM provider，可能产生费用。
- Windows 原生安装路径更复杂。

## 采纳方式

当前只采纳评估规则，不安装 runtime。

后续安装必须作为独立任务执行：

1. 确认用户明确要求。
2. 选择 Codex、Hermes 或其他目标宿主。
3. 选择 MCP-only 或 plugin/hook 深度集成。
4. 设置安全默认配置。
5. 运行健康检查。
6. 验证 save/recall round-trip。
7. 记录到 `dev-logs/YYYY-MM-DD.md` 和项目工具文档。
