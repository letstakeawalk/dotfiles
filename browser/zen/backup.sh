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

if [[ "${1:-}" == "--profile-path" ]]; then
  echo "$PROFILE"
  exit 0
fi

if pgrep -x "zen" > /dev/null 2>&1; then
  echo "Warning: Zen is running. Quit Zen first for clean backup." >&2
fi

echo "Profile: $PROFILE"

# Keyboard shortcuts
cp "$PROFILE/zen-keyboard-shortcuts.json" "$SCRIPT_DIR/"
echo "Copied zen-keyboard-shortcuts.json"

# Containers
cp "$PROFILE/containers.json" "$SCRIPT_DIR/"
echo "Copied containers.json"

# userContent.css
if [[ -f "$PROFILE/chrome/userContent.css" ]]; then
  cp "$PROFILE/chrome/userContent.css" "$SCRIPT_DIR/"
  echo "Copied userContent.css"
fi

echo ""
echo "Done. Review prefs.js for new intentional prefs to add to user.js:"
echo "  diff <(grep '^user_pref' \"$PROFILE/prefs.js\" | sort) <(grep '^user_pref' \"$SCRIPT_DIR/user.js\" | sort)"
