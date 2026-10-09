# Recovery And Logs

Use only for cross-session work, interruption recovery, complex failure, handoff, or an explicit checkpoint request.

## Priority

Resume from current project rules, Git status, and the minimum recovery summary needed. Resolve conflicts by the user's latest instruction, current repository rules, Git, and verifiable facts. Prefer current files over history; read historical logs for old-decision tracing, regression investigation, or blockers.

## Recovery Summary

Record only what is needed to resume: current goal, changed files, verification state, blocker, and next step. Do not copy stable decision text, secrets, private transcripts, or rebuildable Git content.

Logs are recovery summaries and stable-decision references, not project facts or a parallel task state.
