#!/bin/bash
# Warn before modifying dependency manifests or CI config
# Also enforces the freeze list from /freeze skill
input=$(cat)
FILE_PATH=$(echo "$input" | jq -r '.tool_input.file_path // empty')

# Allow .env.example and .env.sample through
if echo "$FILE_PATH" | grep -qE '\.env\.(example|sample|template)$'; then
  exit 0
fi

# Check freeze list
FREEZE_FILE="$HOME/.claude/.frozen-paths"
if [ -f "$FREEZE_FILE" ]; then
  while IFS= read -r frozen; do
    [ -z "$frozen" ] && continue
    if [[ "$FILE_PATH" = "$frozen" || "$FILE_PATH" = "$frozen"/* ]]; then
      echo "{\"hookSpecificOutput\":{\"hookEventName\":\"PreToolUse\",\"permissionDecision\":\"deny\",\"permissionDecisionReason\":\"File is frozen: $frozen. Use /freeze --clear or /freeze --remove to unfreeze.\"}}" >&2
      exit 2
    fi
  done < "$FREEZE_FILE"
fi

exit 0
