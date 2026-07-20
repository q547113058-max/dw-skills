# Skill 更新策略

只在实际准备使用、安装、更新或迁移某个 skill 时检查它。普通任务不会因 skill 出现在登记表中而触发检查，也不再执行全量每周周检。

## 检查频率

- 普通开发 skill：距上次成功检查满 30 天后，在使用前检查。
- 安全、部署和外部连接/操作 skill：每次使用前检查。
- 候选 skill：不参与活动检查；只有用户明确评估、安装或启用时才检查。
- `-MaxAgeDays` 只用于临时覆盖普通 skill 的 30 天周期，不改变“每次使用前”类别。

## 活动注册表

| Skill | 来源 | 类别 | 用途 |
| --- | --- | --- | --- |
| `graphify` | `https://github.com/safishamsi/graphify` | 普通 / 30 天 | 架构和长期知识图谱 |
| `vpn-mihomo` | 本地私有 | 外部连接 / 使用前 | 网络失败后的命令级代理 |
| `github` | `https://cli.github.com/` | 外部操作 / 使用前 | GitHub 状态和 mutation |

## 候选参考

以下能力未安装或未配置，不参与 `-Skill all`：

| Skill | 来源 | 评估条件 |
| --- | --- | --- |
| `superpowers` | `https://github.com/obra/superpowers` | 环境明确提供或用户要求安装 |
| `codegraph` | `https://github.com/colbymchenry/codegraph` | 需要轻量代码关系工具 |
| `agentmemory` | `https://github.com/rohitg00/agentmemory` | 明确评估持久记忆层 |
| `ponytail` | `https://github.com/DietrichGebert/ponytail` | 明确评估外部运行时；精简原则本身无需安装 |

## 命令

检查本次准备使用的活动 skill：

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\check-dw-skill-updates.ps1" check -Skill graphify
```

检查全部活动项的到期状态，不包含候选：

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\check-dw-skill-updates.ps1" check
```

显式评估候选：

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\check-dw-skill-updates.ps1" check -Skill superpowers -IncludeCandidates
```

`mark` 和 `update` 都会执行真实探测，并只在探测成功时更新 `lastChecked`；它们不会覆盖本地 skill 文件。远端 SHA、工具可用性或本地私有路径检查失败时，只写入 `lastAttempt` 和失败状态，不得把失败尝试当作更新证明。

状态文件为 `work/skill-update-state.json`。不得记录 token、订阅 URL、节点服务器、账号、密码或完整私有配置。

## 更新边界

- Git checkout 只有在审查 diff、权限、secrets 风险和回滚方式后才更新。
- 非 Git checkout 不强行覆盖；按来源人工比较必要文件。
- 本地私有 skill 只更新公开说明或脱敏模板。
- 候选 runtime、hooks、plugins、marketplace 和平台配置未经明确授权不得安装。
- 策略或脚本变化只有在存在恢复价值时才写开发日志；GitHub mutation 仍需明确授权。
