# Changelog

All notable changes to MM Visual Skills are documented here.

## [0.10.0] - 2026-10-01

### Reliable installed-user update flow

- Made the Windows and macOS/Linux update-check scripts self-contained when launched directly from GitHub.
- Version checks now download the current installer only after an update is confirmed (or `-Yes` / `yes` is supplied), so already-installed users do not need a local checkout or a manual `git pull`.
- Added documented interactive, check-only, and non-interactive update commands for PowerShell and shell users.
- Kept the existing auto-discovery behavior: each successful sync scans root-level `SKILL.md` directories and installs new Skills automatically.

## [0.9.0] - 2026-10-01

### Cover architecture + Handdrawn Knowledge cover style

- Added `mm-cover` as the article-cover category router.
- Added `mm-cover-handdrawn-knowledge` as the first independent cover style Skill.
- Formalized the “手绘干货风” visual DNA: title-first editorial cover, hand-drawn IP, one real business object, compact infographic support, and strong hierarchy.
- Added dynamic color selection by topic instead of a fixed red/black/white or yellow/blue/black palette.
- Added orange-cat pose, role, expression, scale, and position rotation to prevent repeated right-side static compositions.
- Added layout rotation, anti-template rules, reference analysis, prompt template, negative rules, and QA checklist.
- Added `assets/preview.png` plus a contrasting red-theme example as visual anchors; examples are explicitly treated as style references, not fixed templates.
- Defaulted X / Twitter Article cover ratio to approximately 2.5:1.
- Updated `mm-visual` routing and root README for the new cover category.

## [0.8.1] - 2026-09-30

### Orange Cat style hardening

- Tightened `mm-article-orange-cat` around the intended white-background editorial line-art look.
- Added explicit visual-priority rules: visual samples first, text rules second.
- Added hard failures for colorful infographic/card/dashboard drift.
- Explicitly banned six-panel / nine-panel / multi-panel collage generation.
- Locked the fixed orange-cat identity: black knit beanie, round black sunglasses, black turtleneck/black outfit.
- Clarified color semantics and typography behavior.
- Updated article-level QA to reference concrete style Skills rather than the retired Style Preset model.
- Defined the intended visual asset set: `preview.png`, `example-old-vs-new.png`, `example-x402-bazaar.png`.

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
