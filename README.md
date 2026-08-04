# DW Skills

开发治理：采用 `dw-skills` 轻量分级治理，按任务风险启用测试、安全、审批和交付门禁。

DW 不是产品运行技术栈，也不实现第二套通用开发方法。它只保留项目级治理：任务分级、四类条件门禁、权限和外部状态边界、必要的恢复记录，以及 skill 来源治理。

## 结构

- 一个运行入口：`AGENTS.md`。
- 三个级别：`quick`、`standard`、`high-risk`。
- 四类条件门禁：安全、数据、部署、外部操作。
- 显式扩展：Superpowers、多 Agent、GitHub 交付、界面设计、浏览器交互和 skill 更新均在真实触发后加载。

`SKILL.md` 只负责发现和指向入口。`docs/` 是参考资料，不应因任务级别而整批读取。

## 核心原则

- 当前模型默认负责通用开发；只有明确检测到 Superpowers 时才启用组合模式。
- 重复使用的项目规则写入项目 `AGENTS.md`；全局规则只保留真正跨项目的稳定约束，不复制项目细节。
- 风险按敏感度、权限、影响、可逆性和失败后果判断；使用数据库、文件系统、外部 API 或普通架构调整本身不自动升级为高风险。
- 已有计划、测试、审查和验证证据直接复用，不重复创建。
- 任务级别不自动产生开发日志；只记录有恢复价值或会影响后续工作的事实。
- 外部 mutation、运行时安装和跨环境记忆启用都需要明确权限。
- 完成结论必须来自真实工具和项目检查。
- DW 不自建设计标准；真实网页/UI 任务可条件调用完整安装的 `finesse-ui`，但用户、产品、仓库设计系统和上层规则始终优先。

## 参考文档

- 分级清单：`docs/05-execution-checklist.md`
- 质量与条件工具：`docs/09-quality-gates-and-review-loop.md`、`docs/12-conditional-quality-and-tooling-policy.md`
- 恢复：`docs/06-development-log-standard.md`、`docs/10-session-checkpoints-and-recovery.md`
- GitHub：`docs/08-github-update-standard.md`
- Skill 更新：`docs/14-skill-update-policy.md`
- Obsidian 与反馈治理：`docs/21-obsidian-cross-project-memory.md`
- Finesse UI：`docs/19-finesse-ui-integration.md`
- Browser Harness：`docs/20-browser-harness-installation.md`
- Superpowers：`docs/15-superpowers-integration.md`
