# 开发 Skills 工作说明

本文件是 DW 的唯一默认入口。每次开发任务先读取本文件、选择任务级别，再按触发条件读取相关文档；禁止为了形式把全部 `docs/`、skills、角色和检查注入普通任务。

## 第二大脑部署范围

- 当前只允许 `CODEX_HOME=D:\Codex\home` 启用第二大脑，`D:\Codex\vault` 是迁移云盘前的唯一权威 Vault。
- 其他电脑、其他 Codex Home 和其他 Agent 环境不得安装全局第二大脑路由，也不得初始化、读取或更新项目记忆。
- 云盘迁移完成并验证同步、冲突处理和项目键一致性后，才允许启用其他环境。
- `dw-skills` 源码 checkout 可以被活动环境通过目录联接复用；不要维护两份会漂移的物理副本。

## 任务分级

| 级别 | 适用范围 | 默认动作 |
| --- | --- | --- |
| `quick` | 默认级别；需求明确、低风险、容易回滚、影响少量文件 | 读触达文件、最小修改、针对性验证、diff 审查、简短交付 |
| `standard` | 一般功能、行为变化、多文件 Bugfix、需要短计划或自动化测试 | 读流程和技术标准、短计划、相关测试、日志和聚焦审查 |
| `high-risk` | 架构、认证、授权、敏感数据、支付、migration、部署、secrets、大范围重构 | 完整相关门禁、安全/独立审查、恢复检查点和质量报告 |

默认从 `quick` 开始。影响范围扩大、行为不确定或需要多步计划时升级为 `standard`；触达敏感或不可逆边界时升级为 `high-risk`。不因最终 diff 很短而降低已触发的风险等级。

## 文档路由

- 运行模式和职责边界：`standard`、`high-risk` 或当前环境可用 Superpowers 时读取 `docs/15-superpowers-integration.md`；`quick` 无通用生命周期产物时可直接使用本文件中的模式规则。
- 执行清单：需要时读取 `docs/05-execution-checklist.md` 对应级别，不能把三级清单全部执行。
- 新项目、范围或验收标准不清：`docs/01-requirements-template.md`。
- `standard` 规划和实现：`docs/02-development-workflow.md`、`docs/03-technical-standards.md`。
- UI、页面或交互：`docs/04-design-standards.md`。
- `standard`、`high-risk`、中断恢复或重要决策：`docs/06-development-log-standard.md`。
- 直接阅读无法判断代码关系：`docs/07-code-structure-analysis.md`。
- 用户要求提交、推送、PR，或仓库有明确自动交付策略：`docs/08-github-update-standard.md`。
- `standard`、`high-risk` 质量门禁：`docs/09-quality-gates-and-review-loop.md`。
- 跨会话、中断或困难恢复：`docs/10-session-checkpoints-and-recovery.md`。
- `standard`、`high-risk` 执行追踪或反馈归因：`docs/11-execution-tracking-quality-feedback.md`。
- 条件工具、Hook、角色、编排或领域能力：`docs/12-conditional-quality-and-tooling-policy.md`。
- 长期多会话、多 Agent 或跨 Hermes/Codex 记忆：`docs/13-agentmemory-adaptation.md`。
- 实际调用已登记外部 skill：`docs/14-skill-update-policy.md`，只检测该 skill。

## Skills 和来源

| Skill | 本地路径 | 来源 | 触发用途 |
| --- | --- | --- | --- |
| `frontend-design` | `C:\Users\54711\.codex\skills\frontend-design\SKILL.md` | `https://github.com/anthropics/skills/tree/main/skills/frontend-design` | UI 实现和视觉 QA |
| `awesome-design-md` | 按需远端读取 | `https://github.com/VoltAgent/awesome-design-md` | UI 需求明确或不明确时，按品牌、行业或产品类型匹配 DESIGN.md |
| `taste-skill` / `design-taste-frontend` | `C:\Users\54711\.codex\skills\taste-skill\SKILL.md` | `https://github.com/Leonxlnx/taste-skill` | 审美方向和反模板化判断 |
| `codegraph` | 待配置 | `https://github.com/colbymchenry/codegraph` | 轻量 import/call/dependency graph |
| `graphify` | `C:\Users\54711\.codex\skills\graphify\SKILL.md` | `https://github.com/safishamsi/graphify` | 项目级知识图谱和跨文档分析 |
| `agentmemory` | 待配置 | `https://github.com/rohitg00/agentmemory` | 条件持久化记忆层 |
| `ponytail` | 待配置 | `https://github.com/DietrichGebert/ponytail` | YAGNI、复用优先和反过度工程参考 |
| `superpowers` | 待配置 | `https://github.com/obra/superpowers` | 可用时负责通用开发生命周期；不可用时使用 DW 独立降级 |
| `vpn-mihomo` | `C:\Users\54711\.codex\skills\vpn-mihomo\SKILL.md` | 本地技能 | 网络失败后的代理状态和节点检查 |
| `github` | `C:\Users\54711\.codex\skills\github\SKILL.md` | `https://cli.github.com/` | GitHub 提交、PR、Actions 和 API |

Hermes 迁移优先使用来源、触发条件和规则说明；Windows 绝对路径不是跨平台唯一依赖。待配置 skill 默认只记录来源，不安装其 runtime、hooks、commands、plugins、marketplace 或 platform configs。

## 核心规则

1. **最小上下文**
   - `quick` 只读取本文件、Git 状态和触达文件。
   - `standard`、`high-risk` 或恢复任务再读取相关文档、日志和 TODO。
   - 任务级别表示风险和流程深度；运行模式表示 Superpowers 是否可用。两者独立选择，不互相替代。
   - Superpowers 可用时记录 `Mode: combined` 并复用其需求、计划、TDD、调试、审查和验证产物；不可用时记录 `Mode: standalone`，不模拟不存在的插件或子 Agent。
   - 不假设聊天历史完整；保留用户已有改动，不扫描生成/依赖/无关目录。

2. **需求和规划**
   - 目标明确的 `quick` 直接继续，不要求完整需求模板或书面计划。
   - 目标、平台、核心流程或验收标准不清到影响实现时，补齐必要信息。
   - `standard`、`high-risk` 拆成可独立验证的小阶段；复杂范围明确影响文件、风险和验证方式。

3. **精简实现**
   - 依次判断：是否需要、仓库已有实现、标准库、平台能力、已安装依赖、小函数、最小自定义实现。
   - Bugfix 修根因和共享入口；禁止未请求抽象、脚手架、单实现接口、投机扩展和无实际变化的配置层。
   - 删除和复用优先，但不能以少代码为由跳过输入验证、错误处理、安全或必要测试。

4. **条件能力**
   - UI 默认使用 `frontend-design`，并按现有规则主动匹配 `awesome-design-md`；`taste-skill` 负责审美方向，`frontend-design` 负责 token 和视觉 QA。
   - 代码理解默认用 `rg`、直接读文件和现有测试；关系问题再用 codegraph，架构/长期图谱问题再用 Graphify。
   - agentmemory 仅用于长期多会话、多 Agent 或跨环境共享；默认不安装、不自动注入、不自动压缩。
   - Superpowers 在 combined 模式负责通用需求、计划、TDD、调试、审查、验证和分支完成；DW 只补 UI、工具成本、安全/领域、恢复和交付增量。一个能力只能有一个负责人。

5. **网络和 secrets**
   - 外网任务出现超时、DNS、连接失败或明显高延迟时，才检查并按需使用 `vpn-mihomo`。
   - 命令行优先只给当前命令设置代理；只有用户明确要求才改系统代理，结束后恢复。
   - 仅检查订阅或配置时不启动代理。禁止记录或输出订阅 URL、token、节点服务器、UUID、密码或完整配置。

6. **验证和审查**
   - `quick`：运行与改动直接相关的最小验证并审查 diff，不生成完整质量报告或模拟额外角色。
   - `standard`：运行项目已有的相关 formatter、lint、types、tests 或 build；有实际测试面时优先 TDD，并做聚焦代码/精简审查。
   - `high-risk`：增加完整相关门禁、独立审查、安全审查、回滚验证，以及可行的集成/E2E 检查。
   - 不编造不存在的命令或检查；无法运行的关键验证要说明原因。

7. **记录和恢复**
   - `quick` 完成且没有重要决策、阻塞或后续待办时，不创建开发日志、质量评级、TODO 或检查点。
   - `standard`、`high-risk`、跨会话、中断恢复或稳定决策使用当天日志；记录变更、验证、阻塞和下一步。
   - 需要恢复能力时，每个连贯且已验证阶段创建聚焦 Git 检查点；不混入无关改动。
   - 同类 Agent 错误重复出现后，才写成包含触发条件、必须行为和禁止行为的可执行规则。

8. **Git 和 GitHub**
   - 编辑前后检查 `git status`，只处理任务相关文件，不覆盖或回退用户改动。
   - `quick` 不为流程形式强制提交。用户明确要求或仓库策略要求时，才提交、推送或创建 PR。
   - 未经明确要求，不 force-push、不改写历史、不合并、不删分支、不改仓库设置。
   - GitHub mutation 失败时，只有本次任务需要 GitHub 交付才记录阻塞和恢复方案。

## Skills 周更新

- DW 登记技能每周至少检查一次更新状态，状态写入 `work/skill-update-state.json`。
- 实际调用某个 skill 前运行 `scripts/check-dw-skill-updates.ps1 check -Skill <skill-name>`；清单中出现、读取 DW 文档或未调用的 skill 不触发检查。
- `Due=True` 时先审查来源、权限、secrets 风险和回滚方式；不是 Git checkout 的本地技能不得强行覆盖。
- `vpn-mihomo` 等私有技能只同步脱敏说明或模板。

## 项目路径

- 需求模板：`docs/01-requirements-template.md`
- 开发流程：`docs/02-development-workflow.md`
- 技术标准：`docs/03-technical-standards.md`
- 设计标准：`docs/04-design-standards.md`
- 分级清单：`docs/05-execution-checklist.md`
- 日志标准：`docs/06-development-log-standard.md`
- 代码结构：`docs/07-code-structure-analysis.md`
- GitHub 更新：`docs/08-github-update-standard.md`
- 质量门禁：`docs/09-quality-gates-and-review-loop.md`
- 会话恢复：`docs/10-session-checkpoints-and-recovery.md`
- 执行反馈：`docs/11-execution-tracking-quality-feedback.md`
- 条件策略：`docs/12-conditional-quality-and-tooling-policy.md`
- agentmemory：`docs/13-agentmemory-adaptation.md`
- skill 更新：`docs/14-skill-update-policy.md`
- Superpowers 集成：`docs/15-superpowers-integration.md`
- 每日日志：`dev-logs/`
- 用户交付：`outputs/`
- 临时工作：`work/`
