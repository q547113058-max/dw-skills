# Skill 周更新策略

DW 登记的外部或本地技能需要每周做一次更新检查；准备调用某个技能时，也要先确认该技能最近 7 天内已经检查过。

## 覆盖范围

覆盖 `AGENTS.md` 和 `docs/02-development-workflow.md` 中登记的技能：

- `frontend-design`
- `taste-skill` / `design-taste-frontend`
- `codegraph`
- `graphify`
- `agentmemory`
- `ponytail`
- `vpn-mihomo`
- `github`

## 检测命令

检查全部技能：

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\check-dw-skill-updates.ps1" check
```

检查单个技能：

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\check-dw-skill-updates.ps1" check -Skill frontend-design
```

完成一次人工检查或更新后，记录本周状态：

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\check-dw-skill-updates.ps1" mark -Skill frontend-design
```

记录全部技能本周已检查：

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\check-dw-skill-updates.ps1" mark
```

状态文件写入 `work/skill-update-state.json`。该文件只记录检查时间、来源、状态和远端 commit 摘要；不得记录 token、订阅 URL、节点服务器、账号或密码。

## 调用时检测规则

准备调用任一 DW 登记技能前：

1. 运行单技能检查命令。
2. 如果 `Due=True`，先检查来源仓库或工具版本是否需要更新。
3. 如果技能目录是 Git checkout，可在审查 diff 后更新；不是 Git checkout 时，不要强行覆盖本地文件。
4. 对 `vpn-mihomo` 这类本地私有技能，只更新公开说明或脱敏模板；不得上传真实订阅 URL、token、节点服务器、UUID、密码或完整配置。
5. 对 `codegraph`、`agentmemory`、`ponytail` 等待配置技能，只记录来源和状态；未明确需要前不安装运行时、hooks 或 platform configs。

## 每周更新规则

每周至少执行一次全部技能检查：

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\check-dw-skill-updates.ps1" update
```

`update` 在当前策略中等价于“检查并记录状态”，不会自动覆盖本地技能文件。需要更新本地内容时必须先审查来源、权限、secrets 风险和回滚方式。

## GitHub 同步

如果本策略、脚本或技能说明发生变化：

- 更新当天 `dev-logs/YYYY-MM-DD.md`。
- 提交 `dw-skills` 相关文档和脚本。
- 推送到 GitHub；如果普通 `git push` 因网络问题失败，可按 `docs/08-github-update-standard.md` 使用 GitHub API 同步并记录原因。
