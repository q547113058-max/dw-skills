# 会话检查点和恢复

本标准用于让工作能在无状态 LLM 会话之间恢复。

## 会话启动

假设模型没有可靠记忆。

每次会话开始：

1. 读取 `AGENT.nd`。
2. 读取相关 `docs/` 文件。
3. 打开当天 `dev-logs/YYYY-MM-DD.md`。
4. 检查 Git 状态：

```powershell
git status
git branch --show-current
git log -1 --oneline
```

5. 找到进度文件：
   - 功能清单
   - TODO
   - 项目需求
   - 项目设计规范
   - 技术决策

6. 确认：
   - 上一个完成的检查点
   - 当前未完成任务
   - 已变更文件
   - 已运行检查
   - 待运行检查

## 进度追踪

以功能清单和 TODO 跟踪工作。

推荐文件：

- `docs/project-feature-checklist.md`
- `docs/project-todo.md`

每个功能清单项包含：

- 功能名
- 状态：pending / in progress / blocked / verified / done
- 验收标准
- 验证方式
- 可用时记录 checkpoint commit

每个 TODO 应足够小，可以独立完成和验证。

## Git 检查点

使用 Git commit 作为恢复快照。

每个连贯且已验证的步骤后创建检查点：

```powershell
git status
git diff
git add <relevant-files>
git commit -m "checkpoint: concise description"
```

规则：

- 只提交相关文件。
- 不混合无关功能。
- 不提交坏代码，除非提交信息明确标记为 WIP 且项目策略允许。
- 优先使用已验证的小检查点，而不是大批未验证变更。
- 按 GitHub 更新标准推送检查点。
- 如果项目不能创建 Git commit，记录阻塞项，并临时使用每日日志作为恢复记录。

## 检查点恢复

失败、中断、上下文丢失或工具超时后：

1. 读取 `AGENT.nd`。
2. 读取当天开发日志。
3. 运行：

```powershell
git status
git log --oneline -5
git diff
```

4. 比较当前文件和最新检查点。
5. 读取功能清单和 TODO。
6. 从第一个未完成事项继续。

存在可用检查点时，不要从头开始。

## 失败记录

任务失败时记录：

- 失败命令或步骤
- 观察到的错误
- 上一个检查点之后变更的文件
- 下一步恢复动作

结束会话前写入 `dev-logs/YYYY-MM-DD.md`。

## 会话保存和恢复记录

会话很长、中断、接近上下文限制或需要交接时，保留足够信息用于无状态重启。

记录：

- 正在构建什么以及原因
- 已确认工作的行为和证据
- 失败尝试和不要重试的精确原因
- 变更文件及当前状态
- 已做决策和取舍
- 阻塞项和开放问题
- 精确下一步
- 已运行和待运行检查

恢复时先读取记录，再编辑；总结当前状态，并在仍然有效时从精确下一步继续。

不要在会话记录中存储 secrets、私人对话细节或原始敏感代码。只保存安全继续工作所需的操作事实。
