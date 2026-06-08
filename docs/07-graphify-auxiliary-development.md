# Graphify Auxiliary Development Standard

Use Graphify as a codebase understanding and architecture analysis aid.

## Installed Paths

- Codex skill: `C:\Users\54711\.codex\skills\graphify\SKILL.md`
- CLI: `C:\Users\54711\.local\bin\graphify.exe`
- User PATH entry: `C:\Users\54711\.local\bin`
- Reference repo clone: `work\graphify`
- Source repository: `https://github.com/safishamsi/graphify`
- Official PyPI package: `graphifyy`

## When To Use

Use Graphify for:

- architecture questions
- module and file relationship questions
- dependency path questions
- impact analysis before refactors
- understanding large or unfamiliar codebases
- summarizing project structure from code and docs

Do not run a full graph build for small edits where normal file inspection is faster.

## Default Commands

When a graph already exists:

```powershell
graphify query "question"
graphify path "A" "B"
graphify explain "node"
graphify affected "node"
```

When a graph needs to be created:

```powershell
graphify extract .
```

For Codex skill usage after restart:

```text
/graphify .
/graphify query "question"
```

After modifying code files in a project with an existing graph:

```powershell
graphify update .
```

## Scope Rules

- Run Graphify from the actual project root.
- Exclude unrelated tool clones, generated files, dependencies, build outputs, caches, and archives.
- Do not scan `work\graphify` unless the Graphify repository itself is the target.
- If the target project is large, narrow to the relevant subfolder first.
- Record Graphify outputs and notable findings in the daily development log.

## Output Expectations

Graphify may create:

- `graphify-out/graph.json`
- `graphify-out/GRAPH_REPORT.md`
- `graphify-out/graph.html`

Use `GRAPH_REPORT.md` for architecture summary and `graph.json` for follow-up queries.
