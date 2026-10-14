#!/usr/bin/env bash
set -euo pipefail
repo_root="$(cd "$(dirname "$0")/../.." && pwd)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
remote="$tmp/upstream.git"
source_dir="$tmp/source"
target="$tmp/skills"

git init --bare -q "$remote"
git --git-dir="$remote" symbolic-ref HEAD refs/heads/main
git clone -q "$remote" "$source_dir" 2>/dev/null
git -C "$source_dir" config user.email test@example.invalid
git -C "$source_dir" config user.name "MM Tests"
mkdir -p "$source_dir/visual" "$source_dir/cover"
cat > "$source_dir/visual/SKILL.md" <<'SKILL'
---
name: mm-visual
metadata:
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
---
SKILL
cat > "$source_dir/cover/SKILL.md" <<'SKILL'
---
name: mm-cover
metadata:
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
---
SKILL
echo 0.10.3 > "$source_dir/VERSION"
git -C "$source_dir" add . && git -C "$source_dir" commit -qm init
git -C "$source_dir" push -q -u origin main

export MM_VISUAL_SOURCE_DIR="$source_dir"
bash "$repo_root/scripts/install-or-update.sh" "$target" --dry-run
test ! -e "$target"
bash "$repo_root/scripts/install-or-update.sh" "$target"
test -f "$target/mm-visual/.mm-visual-skills-managed"
test "$(cat "$target/.mm-visual-skills-version")" = "0.10.3"

echo LOCAL_CHANGE >> "$target/mm-cover/SKILL.md"
echo 0.10.4 > "$source_dir/VERSION"
git -C "$source_dir" add . && git -C "$source_dir" commit -qm update
git -C "$source_dir" push -q
bash "$repo_root/scripts/install-or-update.sh" "$target"
test "$(cat "$target/.mm-visual-skills-version")" = "0.10.4"
grep -R -q LOCAL_CHANGE "$target/.mm-visual-skills-backups"

# Unrelated folders must never be deleted or overwritten.
mkdir -p "$source_dir/other" "$target/mm-other"
cat > "$source_dir/other/SKILL.md" <<'SKILL'
---
name: mm-other
metadata:
  source: "https://github.com/menghaoran214-lang/mm-visual-skills"
---
SKILL
echo "MY OWN FILE" > "$target/mm-other/keep.txt"
git -C "$source_dir" add . && git -C "$source_dir" commit -qm add-other
git -C "$source_dir" push -q
if bash "$repo_root/scripts/install-or-update.sh" "$target"; then
  echo "Installer overwrote a foreign Skill" >&2; exit 1
fi
test "$(cat "$target/mm-other/keep.txt")" = "MY OWN FILE"
test "$(cat "$target/.mm-visual-skills-version")" = "0.10.4"

# Legacy installs with matching metadata.source should remain upgradable.
rm -rf "$target/mm-other"
rm "$target/mm-visual/.mm-visual-skills-managed"
bash "$repo_root/scripts/install-or-update.sh" "$target"
test -f "$target/mm-visual/.mm-visual-skills-managed"
test -f "$target/mm-other/.mm-visual-skills-managed"

# Regression: the self-contained checker must pass a defined SOURCE_DIR to the installer.
echo 0.10.9 > "$source_dir/VERSION"
git -C "$source_dir" add VERSION && git -C "$source_dir" commit -qm bump
git -C "$source_dir" push -q
mkdir -p "$tmp/mock-bin"
cat > "$tmp/mock-bin/curl" <<'CURL'
#!/usr/bin/env bash
if [[ "$1" == "-fsSL" && "$3" == "-o" ]]; then
  cp "$MM_TEST_INSTALLER" "$4"
else
  printf '0.10.9\n'
fi
CURL
chmod +x "$tmp/mock-bin/curl"
PATH="$tmp/mock-bin:$PATH" MM_TEST_INSTALLER="$repo_root/scripts/install-or-update.sh" bash "$repo_root/scripts/check-update.sh" "$target" yes
test "$(cat "$target/.mm-visual-skills-version")" = "0.10.9"
echo "PASS: dry-run, fresh install, update, backups, conflict, legacy migration, checker"
