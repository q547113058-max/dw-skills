# 代码结构分析标准

本标准用于轻量项目中的代码理解工具取舍。

## 默认取舍

轻量项目默认不创建 Graphify 图谱。

优先级：

1. `rg`、直接读文件、现有测试和项目文档。
2. codegraph：轻量代码结构图、import/call/dependency graph、循环依赖检查。
3. Graphify：项目级知识图谱、长期架构记忆、跨代码/文档/资料分析。

## 大小分级

轻量项目：

- 文件数少于 `80`。
- 主要业务目录少于 `5`。
- 核心流程 `1-3` 条。
- 一次功能修改通常影响 `1-5` 个文件。
- 入口文件、路由、组件和测试能在 `10` 分钟内看清影响面。

中型项目：

- 文件数 `80-300`。
- 目录或模块开始分层。
- 有多个页面、服务、状态管理、API 或构建配置。
- 一次功能修改可能影响 `5-15` 个文件。
- 需要依赖图或调用图辅助判断边界。

大型项目：

- 文件数 `300+`，或代码行 `30k+`。
- 多模块、多应用、monorepo、插件系统或复杂状态流。
- 有跨目录共享层，例如 `lib/`、`core/`、`services/`、`packages/`。
- 一次修改可能影响 `15+` 个文件或多个运行入口。
- 仅靠读文件容易漏调用链、数据流、权限流或副作用。
- 需要长期保存架构关系、模块边界和历史决策。

## 调用边界

默认调用边界：

| 条件 | 工具 |
| --- | --- |
| 单文件问题、小功能、小 UI、小 bug | `rg` + 直接读文件 |
| 影响面预计少于 `5` 个文件 | `rg` + 直接读文件 |
| 影响面预计 `5-15` 个文件 | codegraph |
| 需要 import/call/dependency graph | codegraph |
| 怀疑循环依赖、异常耦合或模块边界问题 | codegraph |
| 影响超过 `15` 个文件 | Graphify |
| 跨 `3` 个以上模块或应用 | Graphify |
| `10` 分钟内无法判断调用链或影响面 | Graphify |
| 需要代码和文档一起分析 | Graphify |
| 项目已有 `graphify-out/graph.json` | Graphify query |

一句规则：

轻量项目用 `rg` 优先；关系问题用 codegraph；架构问题、长期记忆和跨文档分析用 Graphify。

## codegraph

当前定位：

- 快速查看文件、模块、函数或依赖关系。
- 快速发现循环依赖、异常耦合或模块边界问题。
- 适合轻量项目和窄范围结构问题。

当前状态：

- 本地路径：待配置。
- 下载地址：`https://github.com/colbymchenry/codegraph`

使用规则：

- 不为了普通文件阅读运行 codegraph。
- 不用 codegraph 替代真实源码阅读和测试验证。
- codegraph 结论必须与源码交叉确认。

## Graphify

已安装位置：

- Skill：`C:\Users\54711\.codex\skills\graphify\SKILL.md`
- 下载地址：`https://github.com/safishamsi/graphify`
- CLI：`graphify`
- 备用 CLI：`C:\Users\54711\.local\bin\graphify.exe`
- 参考仓库：`work\graphify`

## 何时使用 Graphify

用于：

- 多模块架构不清
- 长期项目知识沉淀
- 架构关系和影响分析超出轻量阅读能力
- 需要跨代码、文档、论文、图片或视频建立知识图谱
- 项目根目录已经存在 `graphify-out/graph.json`

不用于：

- 小文件的简单阅读
- 单页、小工具或少量文件项目的常规理解
- 不需要结构分析的窄改动
- 只想看 import/call/dependency graph 的轻量问题
- 生成目录、依赖目录或无关克隆仓库

## 默认命令

已有图谱时：

```powershell
graphify query "question"
graphify path "NodeA" "NodeB"
graphify explain "NodeName"
```

需要新建项目级图谱时：

```powershell
graphify .
```

需要深度分析时：

```powershell
graphify . --mode deep
```

代码修改后更新已有图谱：

```powershell
graphify . --update
```

## 工作规则

1. 如果项目根目录存在 `graphify-out/graph.json`，优先查询现有图谱。
2. 没有图谱时，先判断是否真的需要项目级知识图谱。
3. 轻量项目默认不用 Graphify 新建图谱。
4. 只需要代码依赖结构时，优先使用 codegraph。
5. 不把 `work/graphify` 或其他临时克隆纳入业务项目图谱，除非它们就是分析目标。
6. Graphify 和 codegraph 结论都要与源码或文档交叉确认。
7. 重要发现记录到每日开发日志。

## 输出文件

Graphify 常见输出：

- `graphify-out/GRAPH_REPORT.md`
- `graphify-out/graph.json`
- `graphify-out/graph.html`

使用 `GRAPH_REPORT.md` 做架构摘要，使用 `graph.json` 做后续查询。
