#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-$HOME/.codex/skills}"
MODE="${2:-prompt}"
REMOTE_VERSION_URL="https://raw.githubusercontent.com/menghaoran214-lang/mm-visual-skills/main/VERSION"
LOCAL_VERSION_FILE="$TARGET_DIR/.mm-visual-skills-version"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALLER="$SCRIPT_DIR/install-or-update.sh"

if command -v curl >/dev/null 2>&1; then
  REMOTE_VERSION="$(curl -fsSL "$REMOTE_VERSION_URL" | tr -d '\r\n')"
elif command -v wget >/dev/null 2>&1; then
  REMOTE_VERSION="$(wget -qO- "$REMOTE_VERSION_URL" | tr -d '\r\n')"
else
  echo "Need curl or wget to check GitHub version." >&2
  exit 1
fi

if [ -f "$LOCAL_VERSION_FILE" ]; then
  LOCAL_VERSION="$(tr -d '\r\n' < "$LOCAL_VERSION_FILE")"
else
  LOCAL_VERSION="not-installed"
fi

echo "Installed version: $LOCAL_VERSION"
echo "Latest version:    $REMOTE_VERSION"

if [ "$LOCAL_VERSION" = "$REMOTE_VERSION" ]; then
  echo "MM Visual Skills is up to date."
  exit 0
fi

if [ "$LOCAL_VERSION" = "not-installed" ]; then
  echo "MM Visual Skills is not installed in: $TARGET_DIR"
else
  echo "A newer/different version is available."
fi

if [ "$MODE" = "check-only" ]; then
  exit 2
fi

if [ "$MODE" = "yes" ]; then
  ANSWER="y"
else
  printf "Install/update now? [Y/n] "
  read -r ANSWER
fi

case "${ANSWER:-y}" in
  y|Y|yes|YES|"")
    bash "$INSTALLER" "$TARGET_DIR"
    ;;
  *)
    echo "Skipped."
    ;;
esac
