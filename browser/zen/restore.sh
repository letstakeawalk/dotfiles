#!/usr/bin/env bash
set -euo pipefail

ZEN_DIR="$HOME/Library/Application Support/zen"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Find the default profile from profiles.ini
find_profile() {
  local install_default
  install_default=$(awk -F= '/^\[Install/ { section=1 } section && /^Default=/ { print $2; exit }' "$ZEN_DIR/profiles.ini")
  if [[ -n "$install_default" ]]; then
    echo "$ZEN_DIR/$install_default"
    return
  fi
  echo "Error: could not find default profile in profiles.ini" >&2
  exit 1
}

PROFILE="$(find_profile)"

if pgrep -x "zen" > /dev/null 2>&1; then
  echo "Error: Zen is running. Quit Zen first." >&2
  exit 1
fi

echo "Profile: $PROFILE"

# user.js — Zen reads this on startup, overrides prefs.js
cp "$SCRIPT_DIR/user.js" "$PROFILE/user.js"
echo "Copied user.js"

# Keyboard shortcuts
if [[ -f "$SCRIPT_DIR/zen-keyboard-shortcuts.json" ]]; then
  cp "$PROFILE/zen-keyboard-shortcuts.json" "$PROFILE/zen-keyboard-shortcuts.json.bak" 2>/dev/null || true
  cp "$SCRIPT_DIR/zen-keyboard-shortcuts.json" "$PROFILE/"
  echo "Copied zen-keyboard-shortcuts.json (backup: .bak)"
fi

# Containers
if [[ -f "$SCRIPT_DIR/containers.json" ]]; then
  cp "$PROFILE/containers.json" "$PROFILE/containers.json.bak" 2>/dev/null || true
  cp "$SCRIPT_DIR/containers.json" "$PROFILE/"
  echo "Copied containers.json (backup: .bak)"
fi

# userContent.css
if [[ -f "$SCRIPT_DIR/userContent.css" ]]; then
  mkdir -p "$PROFILE/chrome"
  cp "$SCRIPT_DIR/userContent.css" "$PROFILE/chrome/userContent.css"
  echo "Copied userContent.css"
fi

echo ""
echo "Done. Restart Zen to apply."
