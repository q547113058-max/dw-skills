# Finesse UI 集成

来源：`https://github.com/mouse-lin/finesse-skill`（MIT）。DW 完整保留上游仓库，但只把其中的 `skills/finesse-ui` 暴露为 Codex Skill。

## 安装记录

- 安装日期：2026-08-01。
- 上游版本：`finesse-ui 0.12.0`。
- 安装提交：`ba004b21e14e55385992dff6e345db7108deca78`。
- 完整仓库：`C:\Users\54711\.codex\skills\dw-skills\work\finesse-skill`。
- Skill 入口：`D:\Codex\home\skills\finesse-ui\SKILL.md`。
- 暴露方式：`D:\Codex\home\skills\finesse-ui` 是指向完整仓库内 `skills\finesse-ui` 的目录联接，不维护第二份静态副本。
- `work/` 由 DW Git 忽略；DW 仓库只提交治理、来源和更新记录，不提交可从上游重建的完整第三方仓库。

整仓中的 Claude、Cursor、Trae、CodeBuddy 配置、示例、图片和参考文档均保留，但不会自动复制到项目、注册插件、安装 hooks 或覆盖项目配置。

## 条件路由

只在用户要求设计、实现、重设计或审查网页/UI 时调用：

- `brand`：落地页、品牌站、作品集、Hero 和视觉动效。
- `product`：仪表盘、后台、数据表格、分析和应用壳层。
- `workflow`：向导、发布流程、设置、控制台和审核队列。
- `commerce`：商品详情、列表、购物车和结算。

一般后端、数据、基础设施和无界面的开发任务不调用。当前模型仍负责实现、测试和完成判断，不建立重复的设计计划、审查或验证流程。

## 优先级与适配

1. 用户明确要求和验收标准。
2. 当前环境的上层规则。
3. 产品规范与仓库现有设计系统、组件库和技术栈。
4. `finesse-ui` 中与当前任务匹配的参考。

采用以下适配边界：

- 不复制或启用上游根 `AGENTS.md`；项目自己的 `AGENTS.md` 始终有效。
- 任务已明确时不因 Design Read、风格参数或方向陈述强制等待确认。
- 只有用户明确要求初始化或沉淀设计模型时才创建 `PRODUCT.md`、`design-model.yaml`。
- Grain、vignette、固定圆角、负字距、配色禁令等是上下文建议，不是 DW 硬门禁。
- 外部图片、生成预算、下载、hotlink 和第三方服务仍按 DW 外部操作边界处理。
- `scripts/detect.mjs` 可作本地只读辅助；它的审美型规则不替代浏览器验证和当前模型判断。默认退出码为 0，必须读取报告中的 `p0`。

## 更新

`finesse-ui` 作为普通开发 Skill，在距上次成功检查满 30 天且准备使用时检查：

```powershell
powershell -ExecutionPolicy Bypass -File ".\scripts\check-dw-skill-updates.ps1" check -Skill finesse-ui
```

检查只比较本地存在性、Git 提交和远端提交，不自动修改完整仓库。真实更新前先审查上游 diff、Skill 入口、脚本、依赖、权限和规则冲突；获得更新授权后再在完整仓库中执行可回滚的 fast-forward，并复验目录联接和 Skill 发现。

## 验证

```powershell
git -C ".\work\finesse-skill" status --short
git -C ".\work\finesse-skill" rev-parse HEAD
Get-Item "D:\Codex\home\skills\finesse-ui" | Select-Object LinkType, Target
Get-Content "D:\Codex\home\skills\finesse-ui\SKILL.md" -TotalCount 12
```
