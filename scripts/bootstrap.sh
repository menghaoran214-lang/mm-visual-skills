#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-$HOME/.codex/skills}"
SOURCE_DIR="${MM_VISUAL_SOURCE_DIR:-$HOME/.mm-visual-skills-source}"
INSTALLER_URL="https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/scripts/install-or-update.sh"

TMP_FILE="$(mktemp)"
cleanup() {
  rm -f "$TMP_FILE"
}
trap cleanup EXIT

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$INSTALLER_URL" -o "$TMP_FILE"
elif command -v wget >/dev/null 2>&1; then
  wget -qO "$TMP_FILE" "$INSTALLER_URL"
else
  echo "Install failed: curl or wget is required." >&2
  exit 1
fi

if [ ! -s "$TMP_FILE" ]; then
  echo "Install failed: installer download was empty." >&2
  exit 1
fi

MM_VISUAL_SOURCE_DIR="$SOURCE_DIR" bash "$TMP_FILE" "$TARGET_DIR"
