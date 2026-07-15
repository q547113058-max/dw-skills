# 开发流程

DW 默认与 Superpowers 组合使用。通用开发阶段由 Superpowers 推进，DW 在阶段边界加载项目特有规则。详细映射见 `docs/15-superpowers-integration.md`。

## 任务分级

| 级别 | 触发条件 | DW 流程深度 |
| --- | --- | --- |
| `quick` | 默认；需求明确、低风险、容易回滚、影响少量文件 | 最小上下文、针对性验证、diff 审查、简短交付 |
| `standard` | 一般功能、行为变化、多文件 Bugfix、需要计划或自动化测试 | 相关文档、短计划、日志和确定性检查 |
| `high-risk` | 架构、认证、敏感数据、支付、migration、部署、secrets | 完整相关门禁、安全/独立审查和恢复检查点 |

任务级别与 combined / standalone 模式独立：级别决定 DW 增量深度，模式决定通用生命周期负责人。

## 阶段 0：恢复上下文并选择模式

1. 读取 `AGENTS.md` 并选择任务级别；`quick` 只读触达文件，其他级别或恢复任务再读相关文档和最近日志。
2. 检查 Git 状态、当前分支、最近提交和未提交用户改动。
3. 检查 Superpowers 是否在当前环境可用。
4. 需要日志时记录 `Mode: combined` 或 `Mode: standalone`；完成即结束的 `quick` 不为形式创建日志。
5. 跨步骤、跨会话或已有计划时，找到唯一的当前任务清单和第一个未完成事项。

存在 Superpowers 计划时，它是唯一任务清单。DW 不再维护平行的阶段计划。

## 组合模式

### 需求与设计

使用 Superpowers `brainstorming` 澄清需求和确认方案。DW 只在以下情况补充：

- 项目有必须填写但尚未覆盖的合规、平台或数据限制。
- UI 工作需要产品上下文、设计方向、token 或反参考。
- 重要项目决策需要写入仓库文档。

不要在设计已批准后再次要求填写完整的 DW 需求模板。

### 计划

使用 `writing-plans` 生成实施计划。DW 只把以下增量加入计划：

- UI 视觉与可访问性验证。
- 安全、技术栈或领域门禁。
- 日志、恢复信息和 GitHub 交付记录。
- 确有必要的 Graphify、agentmemory 或 Skill 更新步骤。

### 工作区和实现

使用 `using-git-worktrees` 管理隔离工作区，并使用 `executing-plans` 或 `subagent-driven-development` 实施。

DW 在实现中强制：

- 保留用户已有改动。
- 默认先搜索和复用，遵循 Ponytail 精简阶梯。
- UI 任务应用 `docs/04-design-standards.md`。
- 工具按成本分级，轻量任务不启用重型图谱或记忆层。
- 条件规则只在触发时加载。

### 测试、调试和审查

- TDD 由 `test-driven-development` 负责。
- 非显而易见的失败由 `systematic-debugging` 负责。
- 代码审查由 requesting/receiving review skills 负责。
- 完成证明由 `verification-before-completion` 负责。

DW 接受上述过程的证据，不重复相同目的的仪式。只补充未覆盖的 UI、安全、技术栈、领域和交付检查。

### 完成与交付

使用 `finishing-a-development-branch` 完成分支决策。DW 随后：

1. `standard`、`high-risk`、恢复任务或存在重要决策/阻塞时，更新必要的项目文档和当天日志。
2. 汇总 Superpowers 验证证据与 DW 增量检查。
3. 记录未运行检查、剩余风险和下一步。
4. 按 `docs/08-github-update-standard.md` 和用户授权执行 GitHub 操作。

## 独立模式

Superpowers 不可用时使用以下精简流程，不模拟不存在的插件能力：

1. **确认**：明确目标、验收标准、关键限制和风险。
2. **探索**：读取相关代码、调用链、测试和项目约定。
3. **计划**：`standard`、`high-risk` 拆成可独立验证的小步骤；`quick` 直接执行。
4. **测试**：有可靠测试面时先确认有效 RED，再做最小 GREEN 和必要重构。
5. **实现**：只修改当前步骤，优先复用和根因修复。
6. **验证**：运行项目真实命令，审查 diff，并补充触发的条件门禁。
7. **交付**：需要恢复价值时更新摘要，并按授权提交、推送或创建 PR。

## 网络故障

网络任务出现超时、DNS 或连接失败时，先记录失败并确认确实需要外网。代理只作用于当前命令，除非用户明确要求，不修改系统代理。不得打印订阅 URL、token、节点或完整配置。

## 工具选择

1. `rg`、直接读文件和现有测试。
2. 需要轻量 import/call/dependency graph 时使用 codegraph。
3. 需要跨模块长期知识图谱时才使用 Graphify。
4. 需要长期多会话或跨 Agent 共享时才评估 agentmemory。

## 精简实现阶梯

依次检查并停在第一个可满足需求的层级：

1. 是否真的需要实现。
2. 仓库是否已有可复用实现。
3. 标准库或平台能力是否覆盖。
4. 已安装依赖是否覆盖。
5. 是否能用一个直接的小函数表达。
6. 写最小可工作实现。

短 diff 不是唯一目标；必须修在正确边界并覆盖必要错误处理。
