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

get_skill_name() {
  local skill_file="$1/SKILL.md"
  local name
  name="$(awk '
    /^name:[[:space:]]*/ {
      sub(/^name:[[:space:]]*/, "", $0)
      gsub(/^["'"'"']|["'"'"']$/, "", $0)
      print $0
      exit
    }
  ' "$skill_file")"
  if [ -z "$name" ]; then
    echo "Could not read skill name from: $skill_file" >&2
    exit 1
  fi
  printf "%s" "$name"
}

installed_count=0
installed_names=""

for skill_dir in "$SOURCE_DIR"/*; do
  [ -d "$skill_dir" ] || continue
  [ -f "$skill_dir/SKILL.md" ] || continue

  skill_name="$(get_skill_name "$skill_dir")"
  destination_path="$TARGET_DIR/$skill_name"

  if [ -e "$destination_path" ]; then
    echo "Replacing managed Skill: $skill_name"
    rm -rf "$destination_path"
  else
    echo "Installing Skill: $skill_name"
  fi

  cp -R "$skill_dir" "$destination_path"
  installed_count=$((installed_count + 1))
  installed_names="$installed_names
$skill_name"
done

if [ "$installed_count" -eq 0 ]; then
  echo "No installable Skills found in repository root." >&2
  exit 1
fi

VERSION="unknown"
if [ -f "$SOURCE_DIR/VERSION" ]; then
  VERSION="$(tr -d '\r\n' < "$SOURCE_DIR/VERSION")"
fi

printf "%s" "$VERSION" > "$TARGET_DIR/.mm-visual-skills-version"

echo
echo "Installed/updated MM Visual Skills v$VERSION"
echo "Installed Skills:"
printf "%s\n" "$installed_names" | sed '/^$/d; s#^#  - '"$TARGET_DIR"'/#'
echo "Version marker:"
echo "  - $TARGET_DIR/.mm-visual-skills-version"
echo
echo "Future root-level directories containing SKILL.md will be installed automatically."
echo "Restart or reload your AI/Agent Skills if it does not detect changes automatically."
