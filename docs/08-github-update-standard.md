# GitHub Update Standard

All code modifications must be updated through GitHub after verification.

## Installed Tooling

- GitHub skill: `C:\Users\54711\.codex\skills\github\SKILL.md`
- GitHub CLI: `gh`
- Verified CLI version: `gh 2.93.0`

## Required Workflow After Code Changes

1. Check repository state:

```powershell
git status
git remote -v
```

2. Verify changes:

```powershell
git diff
```

3. Run the relevant tests, build, lint, or manual verification.

4. Stage only relevant files:

```powershell
git add <changed-files>
```

5. Commit with a clear message:

```powershell
git commit -m "short clear message"
```

6. Push to GitHub:

```powershell
git push
```

If the project uses pull requests, create or update a PR instead of pushing directly to the main branch:

```powershell
gh pr create --title "Title" --body "Summary"
```

## Blockers

If any of these are missing, record the issue in the daily development log:

- not inside a Git repository
- no GitHub remote configured
- not authenticated with GitHub
- branch protection requires a PR
- tests fail
- user approval is needed for a sensitive repository action

## Safety Rules

- Do not commit unrelated user changes.
- Do not force-push unless the user explicitly requests it.
- Do not rewrite history unless the user explicitly requests it.
- Do not merge, close PRs, delete branches, publish releases, or change repository settings unless directly requested.
- Always report whether the GitHub update was completed, skipped, or blocked.
