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
| `frontend-design` | 页面、前端、Web App、网站、仪表盘、游戏或交互 UI 开发 | `https://github.com/Ilm-Alan/frontend-design` | `C:\Users\54711\.codex\skills\frontend-design\SKILL.md` |
| `taste-skill` / `design-taste-frontend` | 高质量落地页、作品集、重设计、视觉方向判断 | `https://github.com/Leonxlnx/taste-skill` | `C:\Users\54711\.codex\skills\taste-skill\SKILL.md` |
| `codegraph` | 轻量代码结构图、import/call/dependency graph、循环依赖检查 | `https://github.com/colbymchenry/codegraph` | 待配置 |
| `graphify` | 项目级知识图谱、长期架构记忆、跨代码/文档/资料分析 | `https://github.com/safishamsi/graphify` | `C:\Users\54711\.codex\skills\graphify\SKILL.md` |
| `agentmemory` | 可选持久化记忆层，用于长期多会话、多 Agent 或 Hermes 迁移场景 | `https://github.com/rohitg00/agentmemory` | 待配置 |
| `github` | GitHub 仓库、提交、PR、Actions、GitHub API 工作 | GitHub CLI：`https://cli.github.com/` | `C:\Users\54711\.codex\skills\github\SKILL.md` |

规则：

- 本地路径只用于当前 Codex 环境。
- 下载地址和触发场景用于跨环境迁移。
- Hermes 适配时，优先迁移 skill 源、触发条件、输入输出约束和质量规则。
- 不把 Windows 绝对路径写成跨平台依赖。
- 轻量项目默认不创建 Graphify 图谱；先用 `rg`、直接读文件和现有测试。
- 轻量项目默认不启用 agentmemory；只有长期记忆需求明确时才评估。

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

### 前端设计 Skill 优先级

页面、前端、Web App、网站、仪表盘、游戏或交互 UI 工作，按以下优先级：

1. 用户需求、现有产品设计和品牌约束最高。
2. `taste-skill` 负责审美方向：
   - 反模板化视觉判断
   - 布局性格
   - 氛围和美术方向
   - 动效方向
   - 视觉层级
   - 避免通用 AI 感 UI
3. `frontend-design` 负责把已选风格变成具体实现 token：
   - 色彩 token
   - 字体 token
   - 间距和质感 token
   - CSS 变量或设计系统值
   - 响应式、可访问性和视觉 QA 约束
4. 最终选择记录在 `docs/project-design-spec.md`。

不要让 `taste-skill` 和 `frontend-design` 同时决定主色、字体或布局方向。冲突时：

- 用 `taste-skill` 决定设计方向。
- 用 `frontend-design` 把方向形式化为 CSS/design tokens。
- 以用户需求和现有产品约束为最终裁决。

## 阶段 3：实现

只实现当前计划步骤。

编辑前：

- 阅读相关文件。
- 检查已有项目模式。
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
