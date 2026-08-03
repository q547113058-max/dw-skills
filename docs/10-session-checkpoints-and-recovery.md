# 会话检查点和恢复

本标准只用于跨会话工作、中断恢复、复杂失败、Agent 交接，或用户/仓库明确要求的检查点。任务被分为 `standard` 或 `high-risk` 并不自动触发完整恢复记录。

组合模式下复用 Superpowers 已有计划、worktree 和任务状态；独立模式复用当前唯一计划。DW 只保存恢复摘要和项目特有决策，不维护平行任务状态。

## 建立恢复记录

需要跨会话继续或中断风险明显时，记录：

- 当前目标、范围和验收条件。
- 唯一计划或任务清单的路径及精确下一步。
- 已变更文件和用户原有改动。
- 已运行、通过、失败和待运行的检查。
- 关键决策、阻塞、失败根因和不得重复的尝试。
- 可用的 checkpoint commit 或分支引用。

恢复摘要写入 `dev-logs/YYYY-MM-DD.md`；格式见 `docs/06-development-log-standard.md`。不得保存 secrets、私人对话细节或原始敏感配置。

## Git 检查点

仅在检查点确有恢复价值、用户/仓库要求，或已启用流程明确要求时创建 commit：

```powershell
git status
git diff
git add <relevant-files>
git commit -m "checkpoint: concise description"
```

- 只提交相关且已验证的文件，不混入用户的无关改动。
- 不把普通 `standard` 任务自动转成 checkpoint 流程。
- push、PR 或其他 GitHub mutation 仍需明确授权，并遵循 `docs/08-github-update-standard.md`。

## 恢复步骤

1. 读取 `AGENTS.md` 和已有恢复摘要。
2. 运行 `git status`、`git log --oneline -5` 和 `git diff`。
3. 比较当前工作树、最近检查点和记录的变更文件。
4. 找到唯一计划或任务清单，从第一个仍有效的未完成事项继续。
5. 先复现失败或确认当前状态，再编辑；不要从头重建已有产物。
6. 完成后更新验证、剩余风险和下一步；没有继续价值时结束记录。

## 分阶段线程

- 只有用户明确选择分阶段处理，或当前线程上下文已明显妨碍下一阶段时，才切换到新线程。
- 切换前把稳定结论、未完成项、风险和验证状态写入仓库现有文档或必要的开发日志，不创建平行状态系统。
- `quick` 和连续实现阶段不为形式拆线程；新线程不自动继承权限或外部 mutation 授权。
