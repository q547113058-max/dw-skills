# GitHub Mutation

Before an authorized push, pull request, comment, merge, release, or settings change:

1. Confirm the target, scope, authorization, and repository delivery policy.
2. Inspect status and the exact diff; exclude unrelated changes and secrets.
3. Execute the smallest reversible operation available.
4. Verify the remote result and report the target, result, and remaining risk.

Read-only public queries need no mutation authorization. Force-push, history rewrite, deletion, production release, and settings changes require separate confirmation.
