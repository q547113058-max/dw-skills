# GitHub 更新标准

代码修改在验证后按用户授权和仓库策略通过 GitHub 交付。读取公开仓库、查询状态、Issue 或 PR 不需要 mutation 授权；push、创建 PR、评论、合并、发布或修改设置需要明确授权或仓库既有交付策略。修改本地文件不自动等于获准执行这些动作。

组合模式下，分支完成和选项呈现由 Superpowers `finishing-a-development-branch` 负责；DW 只执行用户选定的 GitHub 动作并记录结果。

## 工具

- GitHub skill：`C:\Users\54711\.codex\skills\github\SKILL.md`
- GitHub CLI：`gh`
- GitHub CLI 下载地址：`https://cli.github.com/`

## 代码变更后的交付流程

1. 检查状态：

```powershell
git status
git diff
```

2. 验证变更：

```powershell
# 使用项目实际命令
npm test
npm run lint
npm run build
```

3. 只暂存相关文件：

```powershell
git add <relevant-files>
```

4. 在用户已授权提交或仓库规则明确要求时，创建聚焦提交：

```powershell
git commit -m "type: concise description"
```

5. 检查 remote：

```powershell
git remote -v
```

6. 在用户选择推送或创建 PR 后执行相应动作：

```powershell
git push
```

或创建 Pull Request：

```powershell
gh pr create
```

## 禁止行为

未经明确要求，不要：

- force-push
- 改写历史
- 合并 PR
- 删除分支
- 改仓库设置
- 提交无关文件
- 提交 secrets
- 把本地修改请求解释为默认获准 push 或创建 PR

## 阻塞情况

以下情况只有在需要跨会话恢复、交接或形成稳定决策时才记录到开发日志：

- 不是 Git 仓库
- 没有 GitHub remote
- 未登录 GitHub
- 测试或 build 失败
- 工作区包含无关用户改动
- 需要用户决定分支、remote 或 PR 策略

## 交付报告

最终回复必须说明：

- 是否已提交；已提交时提供 commit hash
- 是否已推送
- 已创建时提供 GitHub repo 或 PR 链接
- 哪些检查已运行
- 哪些检查未运行及原因
