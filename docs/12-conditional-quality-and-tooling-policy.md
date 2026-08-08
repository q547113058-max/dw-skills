# Conditional Tooling Policy

Use only when installing or enabling an external runtime, Hook, MCP, plugin, or other tool integration.

- Confirm user or repository authorization, source, version, network behavior, file scope, permissions, privacy impact, and rollback before installation.
- Keep Hooks disabled by default; bind enabled Hooks to reviewed, deterministic commands.
- Do not silently send code, prompts, secrets, or files to remote services.
- Prefer read-only or dry-run operation first, then the smallest reversible mutation; verify the result and stop on unexpected scope.
- Do not install candidates, plugins, runtimes, or platform configuration merely because they are listed.
- The tool's own Skill owns implementation and usage details; DW owns only authorization, scope, evidence, and recovery boundaries.
