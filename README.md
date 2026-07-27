# DW Skills

开发治理：采用 `dw-skills` 轻量分级治理，按任务风险启用测试、安全、审批和交付门禁。

DW 不是产品运行技术栈，也不实现第二套通用开发方法。它只保留项目级治理：任务分级、四类条件门禁、权限和外部状态边界、必要的恢复记录，以及 skill 来源治理。

## 结构

- 一个运行入口：`AGENTS.md`。
- 三个级别：`quick`、`standard`、`high-risk`。
- 四类条件门禁：安全、数据、部署、外部操作。
- 显式扩展：Superpowers、多 Agent、GitHub 交付和 skill 更新均在真实触发后加载。

`SKILL.md` 只负责发现和指向入口。`docs/` 是参考资料，不应因任务级别而整批读取。

## 核心原则

- 当前模型默认负责通用开发；只有明确检测到 Superpowers 时才启用组合模式。
- 风险按敏感度、权限、影响、可逆性和失败后果判断；使用数据库、文件系统、外部 API 或普通架构调整本身不自动升级为高风险。
- 已有计划、测试、审查和验证证据直接复用，不重复创建。
- 任务级别不自动产生开发日志；只记录有恢复价值或会影响后续工作的事实。
- 外部 mutation、运行时安装和跨环境记忆启用都需要明确权限。
- 完成结论必须来自真实工具和项目检查。
- DW 不提供或强制 UI、视觉、品牌、颜色、排版、动效和组件风格标准，也不默认调用设计类 Skill。

## 参考文档

- 分级清单：`docs/05-execution-checklist.md`
- 质量与条件工具：`docs/09-quality-gates-and-review-loop.md`、`docs/12-conditional-quality-and-tooling-policy.md`
- 恢复：`docs/06-development-log-standard.md`、`docs/10-session-checkpoints-and-recovery.md`
- GitHub：`docs/08-github-update-standard.md`
- Skill 更新：`docs/14-skill-update-policy.md`
- Superpowers：`docs/15-superpowers-integration.md`
