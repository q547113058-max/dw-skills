# Project Environment

For a maintained project, record the minimum reproducible runtime information in its existing README, runbook, operations document, or equivalent project file. Do not create a parallel environment document when one already exists.

Record only what future work needs:

- target environment and purpose, required runtime or tool, and compatibility-critical version;
- canonical start, stop, deploy, restart, health-check, and verification script paths;
- the command or executable path that actually worked, including a fallback when the expected command was unavailable, such as `npm.cmd`, a bundled executable, package-manager shim, or project wrapper script;
- required environment-variable names and configuration source, never secret values;
- applicable host or shell constraint, verification command, last verified date, and the condition that requires revalidation.

Prefer project-relative scripts and discoverable commands over absolute machine paths. If an absolute path is unavoidable, mark it host-specific and verify it before reuse. Do not record transient process IDs, temporary ports, one-off command output, credentials, or other easily rediscovered state.

When a command path or workaround changes, update the existing project document after successful verification and replace stale guidance rather than appending competing instructions.
