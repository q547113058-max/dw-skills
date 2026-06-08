# 代码结构分析标准

本标准用于轻量项目中的代码理解工具取舍。

## 默认取舍

轻量项目默认不创建 Graphify 图谱。

优先级：

1. `rg`、直接读文件、现有测试和项目文档。
2. codegraph：轻量代码结构图、import/call/dependency graph、循环依赖检查。
3. Graphify：项目级知识图谱、长期架构记忆、跨代码/文档/资料分析。

## codegraph

当前定位：

- 快速查看文件、模块、函数或依赖关系。
- 快速发现循环依赖、异常耦合或模块边界问题。
- 适合轻量项目和窄范围结构问题。

当前状态：

- 本地路径：待配置。
- 下载地址：待确认具体实现仓库后补充。

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
