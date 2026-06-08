# Development Log Standard

Daily logs live in `dev-logs/` and use the filename format `YYYY-MM-DD.md`.

## Automatic Logging Rule

At the start of every work session:

1. Determine today's date.
2. If `dev-logs/YYYY-MM-DD.md` does not exist, create it from the template below.
3. Add the active task under "Session".

At the end of every work session:

1. Append completed items.
2. Append changed files.
3. Append validation results.
4. Append open issues.
5. Append next todos.

If the agent cannot update the log, it must say why in the final response.

## Template

```markdown
# Development Log - YYYY-MM-DD

## Session

- Task:
- Requirement source:
- Current phase:

## Completed

- 

## Changed Files

- 

## Decisions

- 

## Validation

- 

## Open Issues

- 

## Next Todos

- 
```
