# Graphify 辅助开发标准

使用 Graphify 辅助理解代码库和架构。

## 已安装位置

- Skill：`C:\Users\54711\.codex\skills\graphify\SKILL.md`
- CLI：`graphify`
- 备用 CLI：`C:\Users\54711\.local\bin\graphify.exe`
- 参考仓库：`work\graphify`

## 何时使用

用于：

- 大型代码库理解
- 架构关系分析
- 文件依赖关系
- 影响分析
- 模块路径追踪
- 长文档、论文、图片或视频的知识图谱化

不用于：

- 小文件的简单阅读
- 不需要结构分析的窄改动
- 生成目录、依赖目录或无关克隆仓库

## 默认命令

已有图谱时：

```powershell
graphify query "question"
graphify path "NodeA" "NodeB"
graphify explain "NodeName"
```

需要新建图谱时：

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
2. 没有图谱时，只有分析价值足够才创建。
3. 不把 `work/ecc`、`work/graphify` 或其他临时克隆纳入业务项目图谱，除非它们就是分析目标。
4. Graphify 结论要与源码或文档交叉确认。
5. 重要发现记录到每日开发日志。

## 输出文件

常见输出：

- `graphify-out/GRAPH_REPORT.md`
- `graphify-out/graph.json`
- `graphify-out/graph.html`

使用 `GRAPH_REPORT.md` 做架构摘要，使用 `graph.json` 做后续查询。
