# Technical Standards

Use these standards unless the project requirements define stricter rules.

## Architecture

- Prefer the simplest architecture that supports the current requirements.
- Keep business logic separate from presentation when the project structure supports it.
- Avoid introducing new frameworks, build tools, or services unless they solve a real project need.
- Document major technical decisions in `docs/project-technical-decisions.md`.
- Use Graphify for large codebase, architecture, dependency, and impact analysis when it adds value. See `docs/07-graphify-auxiliary-development.md`.

## Research And Reuse

- Before net-new implementation, search the existing repository for matching patterns and reusable helpers.
- For external APIs, packages, or framework behavior, verify against primary documentation or the installed package version before coding.
- Prefer proven libraries or local project utilities over hand-rolled infrastructure when they meet the requirement.
- Record major reuse, dependency, or build-tool decisions in the technical decision log.

## Code Quality

- Follow existing code style and naming conventions.
- Keep functions focused and understandable.
- Avoid duplicated logic when a local helper or shared module is appropriate.
- Keep edits scoped to the active task.
- Do not make broad rewrites unless the user requested them or the current task requires them.
- Prefer simple, direct code over speculative abstraction.
- Add abstractions only after real repetition or complexity exists.
- Prefer immutable updates for shared state, request data, and UI state where the language and framework support it.
- Keep functions small enough to review easily; split functions that mix unrelated responsibilities.
- Keep files cohesive; consider extracting modules when a file grows beyond roughly 800 lines.
- Replace meaningful magic numbers, delays, thresholds, and limits with named constants or config.
- Do not leave production `console.log`, debug output, placeholder names, or mock-only behavior in shipped code.

## Data

- Define data shapes clearly before building UI around them.
- Validate user input at the boundary where data enters the system.
- Handle empty, loading, error, and success states.
- Do not store secrets in source files.
- Treat external data, file contents, API responses, and user input as untrusted until validated.
- Use schema-based validation when available in the project stack.
- Handle errors explicitly and provide user-safe messages for UI-facing failures.

## Security

- Never hardcode API keys, tokens, passwords, credentials, or private endpoints.
- Validate and authorize state-changing operations on the server or trusted boundary, not only in the UI.
- Use parameterized queries or framework-safe database APIs when database access exists.
- Sanitize or avoid raw HTML injection.
- Do not leak sensitive data through error messages, logs, public environment variables, source maps, or client bundles.
- Trigger a security review for changes involving authentication, authorization, payments, user data, database queries, filesystem access, external API calls, cryptography, or secrets.

## Conditional TypeScript, React, And Web Rules

Apply these rules only when the project uses TypeScript, React, or a web frontend stack.

- Exported functions, shared utilities, public APIs, and component props should have explicit types.
- Avoid `any`; use `unknown` plus narrowing for external or untrusted values.
- Prefer typed schema validation for API inputs, form inputs, and server actions.
- In React, obey Hooks rules through linting: top-level hooks only, complete dependency arrays, and cleanup for subscriptions, timers, listeners, and in-flight requests.
- Do not use `useEffect` for derived state that can be computed during render.
- Validate URLs before putting user-controlled values into `href`, `src`, or similar attributes.
- Use `rel="noopener noreferrer"` with `target="_blank"`.
- Treat `dangerouslySetInnerHTML` or raw `innerHTML` as a security review trigger; sanitize at the call site when raw HTML is unavoidable.
- Keep client-exposed environment variables public by assumption; never put secrets behind frontend public prefixes.
- Prefer semantic HTML, accessible labels, keyboard support, and stable layout dimensions.
- For visual web work, verify responsive breakpoints and avoid text overlap, clipping, and horizontal overflow.

## Testing

Use test depth based on risk:

- Narrow UI or copy change: manual check may be enough.
- Shared logic or data behavior: add or update automated tests.
- Authentication, payment, persistence, or external API behavior: test normal, failure, and edge cases.

Record test results in the daily log.

## Deterministic Constraints

- Prefer deterministic project checks before subjective review.
- Use existing formatters, linters, type checks, structural tests, and test suites.
- If pre-commit is configured, run it before commit or rely on it during commit and fix any failure.
- Add missing deterministic checks when the project risk justifies it and the stack supports it.
- Record skipped checks and reasons in the daily log.

## Review And Evaluation

- Separate generation from evaluation for meaningful changes.
- Review should look for bugs, regressions, missing tests, unclear contracts, accessibility issues, layout failures, and unmet requirements.
- For substantial changes, use a multi-pass review loop: implement, review, fix, rerun checks, repeat.
- Independent evaluator output should be treated as findings to resolve or explicitly reject with reasons.

## Delivery

Every completed development step should include:

- summary of changes
- files changed
- verification performed
- known limitations
- next recommended step

## GitHub Updates

- After code changes are verified, update the project through GitHub.
- Use `git status`, `git diff`, a focused commit, and `git push` or a pull request.
- If the project is not a Git repository or has no GitHub remote, record that blocker in the daily development log.
- See `docs/08-github-update-standard.md`.
