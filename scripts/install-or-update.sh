#!/usr/bin/env bash
set -euo pipefail
TARGET_DIR="${1:-$HOME/.codex/skills}"
MODE="${2:-install}"
SOURCE_DIR="${MM_VISUAL_SOURCE_DIR:-$HOME/.mm-visual-skills-source}"
REPO_URL="https://github.com/menghaoran214-lang/mm-visual-skills.git"
MARKER=".mm-visual-skills-managed"
VERSION_MARKER=".mm-visual-skills-version"

[[ "$MODE" == install || "$MODE" == --dry-run ]] || { echo "Usage: bash install-or-update.sh [target-dir] [--dry-run]" >&2; exit 2; }
command -v git >/dev/null 2>&1 || { echo "git is required" >&2; exit 1; }
echo "MM Visual Skills | source: $SOURCE_DIR | target: $TARGET_DIR"
if [[ "$MODE" == --dry-run ]]; then
  [[ -d "$SOURCE_DIR/.git" ]] || { echo "Dry-run requires an existing source clone at $SOURCE_DIR; it never downloads files." >&2; exit 2; }
elif [[ -d "$SOURCE_DIR/.git" ]]; then
  git -C "$SOURCE_DIR" pull --ff-only
elif [[ -e "$SOURCE_DIR" ]]; then
  echo "Source exists but is not a Git repository: $SOURCE_DIR" >&2; exit 1
else
  git clone "$REPO_URL" "$SOURCE_DIR"
fi

names=()
sources=()
seen_names=" "
for skill_dir in "$SOURCE_DIR"/*; do
  [[ -d "$skill_dir" && -f "$skill_dir/SKILL.md" ]] || continue
  skill_name="$(sed -n 's/^name:[[:space:]]*//p' "$skill_dir/SKILL.md" | head -n 1 | tr -d "\"'[:space:]")"
  [[ "$skill_name" =~ ^[a-z0-9][a-z0-9-]*$ ]] || { echo "Invalid Skill name in $skill_dir" >&2; exit 1; }
  [[ "$seen_names" != *" $skill_name "* ]] || { echo "Duplicate Skill name: $skill_name" >&2; exit 1; }
  seen_names+="$skill_name "
  dest="$TARGET_DIR/$skill_name"
  [[ ! -L "$dest" ]] || { echo "CONFLICT: symlink $dest; refusing overwrite." >&2; exit 1; }
  if [[ -e "$dest" ]]; then
    if [[ -f "$dest/$MARKER" ]] && grep -Fxq mm-visual-skills "$dest/$MARKER"; then
      :
    elif [[ -f "$dest/SKILL.md" ]] && grep -Fq 'source: "https://github.com/menghaoran214-lang/mm-visual-skills"' "$dest/SKILL.md"; then
      echo "Recognized legacy MM Visual installation: $skill_name"
    else
      echo "CONFLICT: $dest is not managed by MM Visual Skills; unchanged." >&2; exit 1
    fi
  fi
  names+=("$skill_name")
  sources+=("$skill_dir")
  echo "PLAN: $skill_name -> $dest"
done
[[ "${#names[@]}" -gt 0 ]] || { echo "No Skills found." >&2; exit 1; }
if [[ "$MODE" == --dry-run ]]; then
  echo "DRY RUN: no source or target files changed."
  exit 0
fi

mkdir -p "$TARGET_DIR/.mm-visual-skills-backups"
backup="$(mktemp -d "$TARGET_DIR/.mm-visual-skills-backups/backup.XXXXXXXX")"
stage="$(mktemp -d "$TARGET_DIR/.mm-visual-stage.XXXXXXXX")"
installed=()
backed_up=()
success=0
finish() {
  if [[ "$success" != 1 ]]; then
    echo "Install failed; restoring previous managed Skills..." >&2
    for name in "${installed[@]}"; do rm -rf -- "$TARGET_DIR/$name"; done
    for name in "${backed_up[@]}"; do mv -- "$backup/$name" "$TARGET_DIR/$name" || true; done
    if [[ -f "$backup/$VERSION_MARKER" ]]; then
      cp -- "$backup/$VERSION_MARKER" "$TARGET_DIR/$VERSION_MARKER" || true
    else
      rm -f -- "$TARGET_DIR/$VERSION_MARKER"
    fi
  fi
  rm -rf -- "$stage"
}
trap finish EXIT
if [[ -f "$TARGET_DIR/$VERSION_MARKER" ]]; then
  cp -- "$TARGET_DIR/$VERSION_MARKER" "$backup/$VERSION_MARKER"
fi
for i in "${!names[@]}"; do
  cp -R -- "${sources[$i]}" "$stage/${names[$i]}"
  printf 'mm-visual-skills\n' > "$stage/${names[$i]}/$MARKER"
done
for name in "${names[@]}"; do
  if [[ -e "$TARGET_DIR/$name" ]]; then
    mv -- "$TARGET_DIR/$name" "$backup/$name"
    backed_up+=("$name")
  fi
  mv -- "$stage/$name" "$TARGET_DIR/$name"
  installed+=("$name")
done
version="unknown"
[[ ! -f "$SOURCE_DIR/VERSION" ]] || version="$(tr -d '\r\n' < "$SOURCE_DIR/VERSION")"
printf '%s' "$version" > "$stage/$VERSION_MARKER"
mv -- "$stage/$VERSION_MARKER" "$TARGET_DIR/$VERSION_MARKER"
success=1
echo "Installed/updated ${#names[@]} Skills (v$version)."
echo "Previous version backup: $backup"
echo "To roll back, restore only the backed-up Skill folders and version marker to this target."
echo "Reload your AI client."
