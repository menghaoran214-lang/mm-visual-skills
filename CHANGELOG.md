# Changelog

All notable changes to MM Visual Skills are documented here.

## [0.7.0] - 2026-09-30

### Changed

- Clarified the collection model: `mm-visual-skills` is the whole Skill collection, `mm-visual` is the router, and each functional Skill can still be installed independently.
- Root repository URL is now documented as the preferred whole-collection install target for clients that support Skill Collections.
- Windows and macOS/Linux installers now auto-discover every root-level directory containing `SKILL.md`.
- Install destination names are read from each Skill's frontmatter `name:`, so future Skills do not require hardcoded installer changes.
- Whole-collection updates automatically pick up newly added active Skills.
- Individual child-directory installation remains supported.

### Install semantics

```text
repository root -> install all active root-level Skills
child Skill URL  -> install only that Skill
```

## [0.6.0] - 2026-09-30

### Changed

- Aligned the repository more closely with the proven CS Skills structure.
- `mm-visual` now behaves as a portable single front door, with explicit active routes and unsupported-route handling.
- `mm-article-illustration` now has explicit trigger language, two working modes, lazy reference loading, and clearer output contracts.
- OpenAI agent metadata now uses the `interface.display_name / short_description / default_prompt` structure.
- Root README now documents direct in-chat GitHub Skill installation first.
- Added `article-illustration/README.md` with usage, install prompts, Style Registry explanation, and quick-call examples.

### Compatibility

- Standard `SKILL.md` remains the portable core.
- `agents/openai.yaml` provides OpenAI/Codex-facing display metadata.
- Existing Git/bootstrap install scripts remain available for users who prefer local installation or whole-repository updates.

## [0.5.0] - 2026-09-30

### Added

- Mandatory visual preview standard for every Style Preset.
- `preview.png` as the canonical style thumbnail / visual anchor.
- Recommended `examples/` folder with 1–2 representative application examples.
- Style registration checklist now verifies preview/example assets.
- Registry now distinguishes “rules complete” from “fully usable with visual examples”.

### Why

- Helps users distinguish styles at a glance.
- Gives generation systems a stable visual anchor.
- Reduces style drift.
- Makes the public style library easier to browse and understand.

## [0.4.0] - 2026-09-30

### Added

- True one-command bootstrap install/update for Windows PowerShell.
- True one-command bootstrap install/update for macOS/Linux.
- Bootstrap scripts download the latest installer directly from GitHub, so users do not need to clone the repository first.
- README “1 分钟安装” section with copy-paste commands.

### User experience

- First run = install.
- Running the same command again = update.
- Default target remains `~/.codex/skills`.
- Only `mm-visual` and `mm-article-illustration` are managed; other Skills are left untouched.

## [0.3.0] - 2026-09-30

### Added

- Automatic GitHub Release workflow.
- Automatic annotated tags such as `v0.3.0` whenever `VERSION` changes on `main`.
- GitHub-generated release notes.
- `RELEASING.md` with versioning, release, and rollback rules.

### Release behavior

- Release content is prepared first.
- `VERSION` is changed last.
- The VERSION change triggers GitHub Actions.
- The workflow creates the matching tag and GitHub Release.
- Existing tags are never recreated.

## [0.2.0] - 2026-09-30

### Added

- Version-aware install/update flow.
- Installed-version marker: `.mm-visual-skills-version`.
- Windows update checker: `scripts/check-update.ps1`.
- macOS/Linux update checker: `scripts/check-update.sh`.
- Interactive update prompt.
- Non-interactive one-click update modes.
- Check-only mode for automation and health checks.

### Changed

- Install/update scripts now record the installed version after every successful sync.
- README now documents update checking and one-click upgrades.

## [0.1.0] - 2026-09-30

### Added

- `mm-visual` unified visual routing Skill.
- `mm-article-illustration` article illustration Skill.
- Style Registry architecture for reusable visual styles.
- S01 · Orange Cat Explainer / 橘猫机制说明书.
- Article illustration QA checklist.
- Reusable Style Preset template.
- Windows PowerShell install/update script.
- macOS/Linux install/update script.
- VERSION file and version-check instructions.

### S01 locked rules

- Fixed orange-cat IP: black knit beanie, round black sunglasses, black turtleneck.
- White/warm-white background with generous negative space.
- Thin black editorial line art.
- One image = one cognitive anchor.
- Abstract ideas translated into visible physical actions.
- Orange = process/flow.
- Blue = operational or explanatory annotation.
- Red = real risk/warning only.
- Light dry humor only after clarity.
- No poster-style layout, dense infographic, whole-article summary, 3D, or photorealism.
- Aspect ratio selected according to content rather than forced uniformity.
