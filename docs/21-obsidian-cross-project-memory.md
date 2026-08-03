# Obsidian 跨项目记忆

本机启用受控的 Codex 长期记忆层，权威 Vault 为 `D:\Codex\vault`。该能力不安装 `agentmemory` runtime，不启用会话 hooks、自动上下文注入或自动压缩。

## 入口与数据分层

- 全局路由：`D:\Codex\home\AGENTS.md`
- 策略：`D:\Codex\vault\00_System\Codex\memory-policy.md`
- 每日模板：`D:\Codex\vault\00_System\Codex\daily-review-template.md`
- 候选区：`D:\Codex\vault\00_Inbox`
- 正式项目记忆：`D:\Codex\vault\30_Projects\<project-key>\memory`

项目文件、Git 和原始资料是事实源。自动复盘只生成 `candidate`，相关任务中完成交叉核验后才能晋升为 `reviewed`。

## 每日复盘

Codex 桌面自动任务在 Asia/Shanghai 每日 01:00 运行，处理前一自然日的本地会话记录。它按项目归纳稳定偏好、决策、进度、阻塞、验收和下一步，写入 `00_Inbox/YYYY-MM-DD-codex-memory-review.md`。

自动任务不得保存完整对话、secrets、凭据、私人原文、VPN 信息、客户敏感数据或可由 Git 重建的大段内容；不得修改项目代码、提交或推送 Git，也不得自动晋升候选记忆。

## 验证

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\Test-ObsidianMemory.ps1
```

自动任务由 Codex 桌面应用托管；其启用状态以应用中的自动任务卡片为准。

## 停用

在 Codex 桌面中停用“Obsidian 每日记忆复盘”自动任务，并删除或改名 `D:\Codex\home\AGENTS.md`。停用不会删除 Vault 中已有记忆；需要清理时应单独审核目标文件。
