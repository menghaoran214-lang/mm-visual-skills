# Release Policy

MM Visual Skills uses semantic-style versions:

- **PATCH** `0.2.0 → 0.2.1`: small fixes that should not materially change existing behavior.
- **MINOR** `0.2.0 → 0.3.0`: new Style Presets, new Skills, new update capabilities, or meaningful workflow improvements.
- **MAJOR** `0.x → 1.0.0`: stable public contract or a deliberately incompatible restructuring.

## Automatic release flow

A release is triggered when `VERSION` changes on `main`.

The GitHub Actions workflow:

1. validates the version;
2. creates an annotated tag such as `v0.3.0`;
3. pushes the tag;
4. creates the matching GitHub Release;
5. uses GitHub-generated release notes and points readers to `CHANGELOG.md`.

If the tag already exists, the workflow exits without creating a duplicate release.

## Maintainer checklist

Before changing `VERSION`:

1. finish the actual Skill/style changes first;
2. update `CHANGELOG.md`;
3. update README when behavior or usage changed;
4. change `VERSION` **last**.

Changing `VERSION` last ensures the release tag points to a commit that already contains the complete release content.

## Rollback

Older releases remain addressable by tag, for example:

```text
v0.2.0
v0.3.0
```

Users that need a known-stable version can check out or download that tag instead of following `main`.
