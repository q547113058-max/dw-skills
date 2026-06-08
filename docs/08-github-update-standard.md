# GitHub 更新标准

所有代码修改在验证后都必须通过 GitHub 更新。

## 工具

- GitHub skill：`C:\Users\54711\.codex\skills\github\SKILL.md`
- GitHub CLI：`gh`
- GitHub CLI 下载地址：`https://cli.github.com/`

## 代码变更后的必做流程

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

4. 创建聚焦提交：

```powershell
git commit -m "type: concise description"
```

5. 检查 remote：

```powershell
git remote -v
```

6. 推送到 GitHub：

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

## 阻塞情况

以下情况记录到开发日志：

- 不是 Git 仓库
- 没有 GitHub remote
- 未登录 GitHub
- 测试或 build 失败
- 工作区包含无关用户改动
- 需要用户决定分支、remote 或 PR 策略

## 交付报告

最终回复必须说明：

- 是否已提交
- commit hash
- 是否已推送
- GitHub repo 或 PR 链接
- 哪些检查已运行
- 哪些检查未运行及原因
