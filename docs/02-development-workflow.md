# 开发流程

本流程适用于本文件夹内的每个软件项目。

## 阶段 0：会话启动

每次会话都按无状态处理。

1. 读取 `AGENTS.md`。
2. 读取当前任务需要的项目文档。
3. 打开当天 `dev-logs/YYYY-MM-DD.md`；不存在就创建。
4. 检查 Git 状态：

```powershell
git status
git branch --show-current
git log -1 --oneline
```

5. 找到当前功能清单和 TODO。
6. 确认：
   - 上一个完成的检查点
   - 当前未完成任务
   - 检查点之后变更过的文件
   - 已运行的检查
   - 待运行的检查

下一个安全步骤不清楚前，不要开始编辑。

## 阶段 0.5：Skills 准备

工作流会用到的 skills 必须记录来源，便于后续迁移到 Hermes 或其他 Agent 运行环境。

| Skill | 触发场景 | 下载地址 | 本地路径 |
| --- | --- | --- | --- |
| `frontend-design` | 页面、前端、Web App、网站、仪表盘、游戏或交互 UI 开发 | `https://github.com/anthropics/skills/tree/main/skills/frontend-design` | `C:\Users\54711\.codex\skills\frontend-design\SKILL.md` |
| `awesome-design-md` | UI 任务中按品牌、网站、行业、竞品、视觉风格，或在风格不明确时按产品类型假设匹配现成 DESIGN.md 风格系统 | `https://github.com/VoltAgent/awesome-design-md` | 按需远端读取 |
| `taste-skill` / `design-taste-frontend` | 高质量落地页、作品集、重设计、视觉方向判断 | `https://github.com/Leonxlnx/taste-skill` | `C:\Users\54711\.codex\skills\taste-skill\SKILL.md` |
| `codegraph` | 轻量代码结构图、import/call/dependency graph、循环依赖检查 | `https://github.com/colbymchenry/codegraph` | 待配置 |
| `graphify` | 项目级知识图谱、长期架构记忆、跨代码/文档/资料分析 | `https://github.com/safishamsi/graphify` | `C:\Users\54711\.codex\skills\graphify\SKILL.md` |
| `agentmemory` | 可选持久化记忆层，用于长期多会话、多 Agent 或 Hermes 迁移场景 | `https://github.com/rohitg00/agentmemory` | 待配置 |
| `ponytail` | 精简实现、YAGNI、复用优先和反过度工程审查参考 | `https://github.com/DietrichGebert/ponytail` | 待配置 |
| `vpn-mihomo` | GitHub、包下载、外部 API、浏览器登录或其他网络任务延迟/失败时启动可用代理节点 | 本地技能 | `C:\Users\54711\.codex\skills\vpn-mihomo\SKILL.md` |
| `github` | GitHub 仓库、提交、PR、Actions、GitHub API 工作 | GitHub CLI：`https://cli.github.com/` | `C:\Users\54711\.codex\skills\github\SKILL.md` |

规则：

- 本地路径只用于当前 Codex 环境。
- 下载地址和触发场景用于跨环境迁移。
- Hermes 适配时，优先迁移 skill 源、触发条件、输入输出约束和质量规则。
- 不把 Windows 绝对路径写成跨平台依赖。
- 轻量项目默认不创建 Graphify 图谱；先用 `rg`、直接读文件和现有测试。
- 轻量项目默认不启用 agentmemory；只有长期记忆需求明确时才评估。
- Ponytail 默认只移植为文档化工程规则和审查清单；未明确批准前不安装其 hooks、commands、platform configs 或运行时文件。
- `vpn-mihomo` 只用于需要网络连通性的任务；订阅链接和节点凭据视为 secrets，不打印、不写入日志。
- 所有登记技能每周至少检查一次更新状态；准备调用某个技能前，先运行 `scripts/check-dw-skill-updates.ps1 check -Skill <skill-name>`。
- 如果检测显示 `Due=True`，先按 `docs/14-skill-update-policy.md` 检查来源、权限、secrets 风险和回滚方式，再决定是否更新。
- 非 Git checkout 的本地技能不得自动覆盖；只允许人工审查后更新或记录为待处理。
- `awesome-design-md` 是远端 DESIGN.md 风格库，不默认克隆全库；按需求只读取最匹配的 `design-md/<slug>/DESIGN.md`。

## 网络故障与 VPN 配方

当 GitHub、包下载、外部 API、浏览器登录或其他联网任务出现超时、DNS 错误、连接失败、明显高延迟时：

1. 先确认任务确实需要外网访问，并记录失败命令或现象。
2. 运行 `vpn-mihomo status` 检查当前代理状态，不直接改系统代理。
3. 如果需要继续联网任务，运行 `vpn-mihomo start` 并用 `vpn-mihomo test` 找到可用节点。
4. 命令行任务优先只在当前 shell 设置：

```powershell
$env:HTTP_PROXY="http://127.0.0.1:17890"
$env:HTTPS_PROXY="http://127.0.0.1:17890"
```

5. 只有用户明确要求浏览器、系统应用或全局流量走代理时，才允许启用系统代理。
6. 任务结束后，如果本次启用了代理，运行 `vpn-mihomo stop` 或恢复原代理状态。

禁止：

- 仅检查订阅、解析配置或查看节点数量时启动代理或改系统代理。
- 在回复、日志、diff 或命令输出中暴露订阅 URL、token、节点服务器、UUID、密码或完整配置。
- 在网络错误未确认前反复重试长命令；先切换到可用节点或记录阻塞。

## 阶段 1：需求收集

1. 要求用户填写 `docs/01-requirements-template.md`。
2. 找出缺失的关键信息：
   - 软件目的
   - 目标设备或平台
   - 核心功能
   - 要解决的问题
   - 设计风格
   - 主色
   - 展示内容
3. 用简短问题或明确假设补齐缺口。
4. 将确认后的需求保存到 `docs/project-requirements.md`。

## 阶段 2：小步规划

计划必须稳定推进。

每一步都要包含：

- 目标
- 可能变更的文件或模块
- 预期用户可见结果
- 验证方式
- 风险或依赖

规则：

- MVP 能验证方向时，不做一次性大计划。
- 先做一个可工作的页面或流程，再增加功能。
- 每一步都要能独立测试。
- 当决策改变产品、数据模型或 UI 结构时，停下来修改计划。
- 维护可见的功能清单和 TODO。
- 只有实现并验证后，才能把事项标记为完成。
- 较大任务使用 plan 配方：复述需求、检查本地模式、定义文件/风险/验证，等待确认后再编码。
- 功能开发使用 feature-dev 配方：发现、代码库探索、澄清、架构设计、实现、质量审查、总结。

### Ponytail 精简实现阶梯

规划和编码前先走精简阶梯，停在第一个能满足需求且可验证的层级：

1. 这个需求是否真的需要实现；投机性需求先跳过并说明。
2. 仓库里是否已有 helper、组件、类型、配置或相邻模式可以复用。
3. 标准库是否已经覆盖。
4. 平台原生能力是否已经覆盖，例如 HTML、CSS、数据库约束、框架内建能力。
5. 已安装依赖是否已经覆盖；不要为几行代码新增依赖。
6. 是否能用更直接的一行或小函数表达。
7. 只有以上都不成立时，写最小可工作的实现。

规则：

- 精简不是跳过理解。先读任务触达的代码和调用链，再选择最少改动点。
- Bugfix 优先修根因和共享入口；不要只在单一路径加症状补丁。
- 禁止未请求的抽象、脚手架、未来扩展、单实现接口、单产品工厂和不会变化的配置层。
- 删除优于新增；短 diff 优先，但错误位置的短 diff 不是好改动。
- 复杂请求可先交付覆盖真实需求的精简版本，并在交付说明中写清何时需要扩展。

### 前端设计 Skill 优先级

页面、前端、Web App、网站、仪表盘、游戏或交互 UI 工作，按以下优先级：

1. 用户需求、现有产品设计和品牌约束最高。
2. 先按 `docs/04-design-standards.md` 判断界面类型：
   - 品牌型界面：落地页、营销页、作品集、官网、活动页、长文内容页，设计本身影响第一印象。
   - 产品型界面：App UI、后台、仪表盘、工具、表单、数据表，设计服务任务完成。
3. UI 任务默认主动用 `awesome-design-md` 匹配对应或相近的 DESIGN.md；用户需求包含品牌、网站、行业、竞品、参考产品或视觉关键词时按这些信号匹配，需求不明确时按产品类型、目标用户、界面密度和任务气质做保守假设：
   - 精确命中时使用对应 `design-md/<slug>/DESIGN.md`。
   - 没有精确命中时，按行业、产品类型、密度、色彩和交互气质选 1 个最接近参考。
   - 用户没有说明视觉风格时，也要选 1 个最接近参考并在任务说明或 `docs/project-design-spec.md` 写明假设；只有产品目的、目标用户或核心流程不清楚到无法判断时才暂停澄清。
   - 只读取选中的 DESIGN.md，不批量拉取整个库。
   - 将采用的颜色、字体、组件、布局、Do/Don't 写入 `docs/project-design-spec.md` 或任务说明。
4. `taste-skill` 负责审美方向：
   - 反模板化视觉判断
   - 布局性格
   - 氛围和美术方向
   - 动效方向
   - 视觉层级
   - 避免通用 AI 感 UI
5. `frontend-design` 负责把已选风格变成具体实现 token：
   - 色彩 token
   - 字体 token
   - 间距和质感 token
   - CSS 变量或设计系统值
   - 响应式、可访问性和视觉 QA 约束
6. 持续 UI 项目要记录：
   - `docs/project-product-context.md`：产品、用户、任务、场景和约束。
   - `docs/project-design-spec.md`：设计方向、参考/反参考、token、组件、动效和审查规则。

不要让 `taste-skill` 和 `frontend-design` 同时决定主色、字体或布局方向。冲突时：

- 用 `taste-skill` 决定设计方向。
- 用 `awesome-design-md` 提供具体品牌/行业 DESIGN.md token 和禁用项。
- 用 `frontend-design` 把方向形式化为 CSS/design tokens。
- 以用户需求和现有产品约束为最终裁决。

设计审查时使用 `docs/04-design-standards.md` 的配方：design read、设计系统发现、布局、字体、颜色、交互、反模板化和证据审查。`pbakaus/impeccable` 只作为参考来源；未明确批准前不安装其 CLI、hooks 或运行时文件。

## 阶段 3：实现

只实现当前计划步骤。

编辑前：

- 阅读相关文件。
- 检查已有项目模式。
- 走 Ponytail 精简阶梯，确认是否能复用、删除或使用平台/标准库能力。
- 说明将要编辑什么。

编辑中：

- 保持改动聚焦。
- 避免无关重构。
- 保留用户已有改动。
- 只在非显而易见逻辑处添加注释。

## 阶段 4：验证

报告完成前，先验证变更后的行为。

使用最强且实际可行的检查：

- 自动化测试
- lint 或类型检查
- build
- 手动浏览器或应用检查
- UI 工作的截图检查

无法运行的检查，要在当天日志中说明原因。

### 质量门禁

按顺序应用：

1. 确定性约束：
   - formatter
   - linter
   - type check
   - structural tests
   - unit 或 integration tests
   - 已配置的 pre-commit hooks
2. 自动审查循环：
   - 根据需求和验收标准审查变更文件
   - 修复发现的问题
   - 重新运行确定性检查
   - 循环直到没有阻塞问题
3. 生成/评估分离：
   - 实现和评估应是不同轮次
   - 重要或高风险工作，尽量使用独立评估或审查角色
   - 评估重点是正确性、回归、缺失测试、UX 问题和交付阻塞

不要把自我总结当作验证。验证必须来自检查、测试、审查输出或明确的人工检查。

### 构建修复配方

当 build、lint、type 或 test 失败：

1. 确认失败命令和第一个根因错误。
2. 按文件和依赖顺序归类错误。
3. 一次只修复一个根因，使用最小安全改动。
4. 每次有意义修复后重新运行失败命令。
5. 同一错误三次仍未解决、修复引入更多错误或需要架构变更时，停止并重新评估。

### PR 配方

创建 Pull Request 前：

1. 验证分支状态、工作区状态和相对 base 的提交。
2. 找到并遵循仓库 PR 模板。
3. 分析提交历史和 diff，不只看最新提交。
4. 包含测试计划和已知限制。
5. 推送分支并验证 PR 元数据和 CI 状态。

## 阶段 5：日志和交接

每次会话结束时：

1. 更新当天 `dev-logs/` 文件。
2. 记录已完成工作。
3. 记录变更文件。
4. 记录验证结果。
5. 记录未解决问题和下一步待办。
6. 记录最新 Git 检查点，或说明为什么没有检查点。
7. 告诉用户改了什么、还剩什么。

## 阶段 6：检查点恢复

失败、中断、上下文丢失或工具超时后恢复时：

1. 重新运行阶段 0。
2. 比较 Git 检查点状态和当前工作区。
3. 阅读当前 TODO 和当天开发日志。
4. 从第一个未完成且可验证的步骤继续。
5. 只在之前状态不可用时才从头开始。
