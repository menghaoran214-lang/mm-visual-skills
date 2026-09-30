# Changelog

All notable changes to MM Visual Skills are documented here.

## [0.8.0] - 2026-09-30

### Architecture correction

- Changed the visual architecture to **one stable visual style = one independent Skill**.
- Converted `mm-article-illustration` into the article-illustration category router.
- Promoted the former S01 Orange Cat style preset into the independent `mm-article-orange-cat` Skill.
- Moved Orange Cat style rules into the new Skill's `references/` directory.
- Added independent `README.md`, `agents/openai.yaml`, and `assets/` structure for the Orange Cat Skill.
- Converted the old style registry into a registry of independent article style Skills.
- Removed the obsolete Style Preset template and old S01 preset files.
- Root README now reflects the collection → category router → style Skill architecture.

### Current structure

```text
mm-visual-skills
├── mm-visual
├── article-illustration
└── article-orange-cat
```

## [0.7.0] - 2026-09-30

- Whole-repository install semantics and auto-discovery installer.

## [0.6.0] - 2026-09-30

- CS-style routing and portable SKILL.md alignment.

## [0.5.0] - 2026-09-30

- Visual example requirements introduced.

## [0.4.0] - 2026-09-30

- One-command bootstrap installation.

## [0.3.0] - 2026-09-30

- Automatic GitHub Tag / Release workflow.

## [0.2.0] - 2026-09-30

- Version-aware update checking.

## [0.1.0] - 2026-09-30

- Initial MM Visual Skills release.
