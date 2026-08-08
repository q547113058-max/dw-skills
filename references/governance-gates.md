# Governance Gates

Use only for a triggered `standard` or `high-risk` task, or when the user requests a governance checklist.

## Verification Strength

- `quick`: nearest relevant test, lint, build fragment, or manual check plus diff review.
- `standard`: quick evidence plus relevant deterministic tests and boundary checks.
- `high-risk`: standard evidence plus only the risk-specific permission, exposure, failure, compatibility, recovery, rollback, or integration checks required by the change.

## Conditional Gates

- Security: validate input and error boundaries; for auth, secrets, payments, or sensitive data check least privilege, exposure, logging, and bypass paths.
- Data: validate scope, transactions or idempotency, compatibility, integrity, backup, and recovery when writes are destructive or sensitive.
- Deployment: validate target environment, configuration, permissions, release evidence, and rollback when production or difficult recovery is involved.
- External operations: confirm source and target; read-only queries need no mutation authorization, while mutations require explicit authorization or established repository policy.

## Evidence

Define the minimum pass condition, quality target, failure boundary, and evidence before non-quick work. Do not claim success without real command or tool evidence. Do not add unrelated specialist review, E2E, rollback drills, or checklists.
