# Design Standards

Use these standards for frontend, app, website, dashboard, and interactive tool work.

## Default Skill

For any page, frontend, web app, website, dashboard, game, or interactive UI development, use the installed `frontend-design` skill by default:

- `C:\Users\54711\.codex\skills\frontend-design\SKILL.md`

Apply it before choosing layout, visual hierarchy, controls, responsive behavior, typography, colors, icons, imagery, interaction states, or visual QA criteria.

For landing pages, portfolios, and redesigns that need stronger aesthetic direction, use installed `taste-skill`:

- `C:\Users\54711\.codex\skills\taste-skill\SKILL.md`
- Install name: `design-taste-frontend`

## Taste And Token Roles

When using `taste-skill` together with `Ilm-Alan/frontend-design`, assign clear responsibilities:

- `taste-skill` decides the aesthetic direction and anti-generic visual quality.
- `Ilm-Alan/frontend-design` converts that selected direction into concrete CSS tokens and design-system values.
- Local `frontend-design` provides baseline frontend UI guardrails and visual QA.

If these sources conflict, do not blend competing directions. Keep the chosen aesthetic from `taste-skill`, then use `Ilm-Alan/frontend-design` only for palette, typography, spacing, texture, and CSS token formalization.

## Product Fit

- Design for the target user and actual workflow.
- Put the primary task on the first screen when building an app or tool.
- Avoid marketing-style landing pages unless the user specifically asks for one.
- Make common actions easy to find and repeat.

## Visual Direction

Before designing, confirm:

- desired style
- main color
- secondary colors
- typography direction
- visible first-screen content
- examples to resemble or avoid

If the user has not specified these, make conservative choices and document them in `docs/project-design-spec.md`.

## Layout

- Use stable dimensions for fixed-format UI elements.
- Ensure text does not overlap or overflow containers.
- Keep controls near the content they affect.
- Use tabs, menus, segmented controls, checkboxes, sliders, and icon buttons where they match expected UI behavior.
- Avoid cards inside cards.

## Color

- Use a deliberate palette with one main color, supporting neutrals, and clear status colors.
- Avoid a one-note palette dominated by only one hue family.
- Ensure sufficient contrast for text and controls.
- Document final colors in `docs/project-design-spec.md`.

## Content

- Use concise labels.
- Avoid in-app text that explains obvious features or implementation details.
- Include useful empty and error states.
- Match text size to the density of the surface.

## Visual QA

For UI work, verify:

- desktop layout
- mobile layout when applicable
- text fit
- hover, active, disabled, loading, empty, and error states
- image or media rendering when assets are used
