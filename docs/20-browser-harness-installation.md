# Browser Harness 安装记录

来源：`https://github.com/browser-use/browser-harness`（MIT）。

- 安装版本：`v0.1.8`。
- 安装提交：`dbe6f8f22ba65170e2d4b8f17754c704d008fe49`。
- 完整仓库路径：`C:\Users\54711\.codex\skills\dw-skills\work\browser-harness`。
- Codex Skill 入口：`D:\Codex\home\skills\browser-harness\SKILL.md`。
- Skill 入口是指向完整仓库根目录的目录联接；完整仓库由 `work/` 忽略，不加入 DW Git。
- `uv` 运行时命令：`C:\Users\54711\.local\bin\browser-harness.exe`。

## 默认边界

- 遥测已关闭，录屏已关闭，`BH_DOMAIN_SKILLS` 未启用。
- 使用本地 Chrome CDP；云端浏览器、API key、Cookie 同步和域名 Skill 不自动启用。
- 浏览器 mutation、登录、上传、下载、社交发布、购物和其他外部操作仍按 DW 授权边界执行。
- 上层 Browser 规则和项目规则优先于上游 Skill 中的“始终使用”提示。

## 版本特性

该版本的 `browser-harness skill` 命令只输出 `../../SKILL.md` 指针文本；本地入口因此直接暴露仓库根目录中的完整 `SKILL.md`，没有改写上游文件。
