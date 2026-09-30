#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-$HOME/.codex/skills}"
SOURCE_DIR="${MM_VISUAL_SOURCE_DIR:-$HOME/.mm-visual-skills-source}"
REPO_URL="https://github.com/menghaoran214-lang/mm-visual-skills.git"

command -v git >/dev/null 2>&1 || {
  echo "Required command not found: git" >&2
  exit 1
}

echo "MM Visual Skills"
echo "Source: $SOURCE_DIR"
echo "Target: $TARGET_DIR"

if [ -d "$SOURCE_DIR/.git" ]; then
  echo "Updating source repository..."
  git -C "$SOURCE_DIR" pull --ff-only
elif [ -e "$SOURCE_DIR" ]; then
  echo "Source directory exists but is not a Git repository: $SOURCE_DIR" >&2
  exit 1
else
  echo "Cloning source repository..."
  git clone "$REPO_URL" "$SOURCE_DIR"
fi

mkdir -p "$TARGET_DIR"

sync_skill() {
  local source_name="$1"
  local destination_name="$2"
  local source_path="$SOURCE_DIR/$source_name"
  local destination_path="$TARGET_DIR/$destination_name"

  if [ ! -d "$source_path" ]; then
    echo "Skill source not found: $source_path" >&2
    exit 1
  fi

  if [ -e "$destination_path" ]; then
    echo "Replacing managed Skill: $destination_name"
    rm -rf "$destination_path"
  fi

  cp -R "$source_path" "$destination_path"
}

sync_skill "mm-visual" "mm-visual"
sync_skill "article-illustration" "mm-article-illustration"

VERSION="unknown"
if [ -f "$SOURCE_DIR/VERSION" ]; then
  VERSION="$(tr -d '\r\n' < "$SOURCE_DIR/VERSION")"
fi

printf "%s" "$VERSION" > "$TARGET_DIR/.mm-visual-skills-version"

echo
echo "Installed/updated MM Visual Skills v$VERSION"
echo "Installed Skills:"
echo "  - $TARGET_DIR/mm-visual"
echo "  - $TARGET_DIR/mm-article-illustration"
echo "Version marker:"
echo "  - $TARGET_DIR/.mm-visual-skills-version"
echo
echo "Restart or reload your AI/Agent Skills if it does not detect changes automatically."
