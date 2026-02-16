#!/bin/bash
# Auto-format files after Claude writes/edits them
input=$(cat)
FILE_PATH=$(echo "$input" | jq -r '.tool_input.file_path // empty')

if [ "$FILE_PATH" = "" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

PROJECT_DIR=$(echo "$input" | jq -r '.cwd // empty')

case "$FILE_PATH" in
  *.rs)
    if command -v rustfmt &>/dev/null; then
      rustfmt --edition 2021 "$FILE_PATH" 2>/dev/null
    fi
    ;;
  *.ts|*.tsx|*.js|*.jsx|*.svelte)
    # Try oxfmt first (local then global), then biome
    if [ "$PROJECT_DIR" != "" ] && [ -f "$PROJECT_DIR/node_modules/.bin/oxfmt" ]; then
      "$PROJECT_DIR/node_modules/.bin/oxfmt" "$FILE_PATH" 2>/dev/null
    elif [ "$PROJECT_DIR" != "" ] && [ -f "$PROJECT_DIR/node_modules/.bin/biome" ]; then
      "$PROJECT_DIR/node_modules/.bin/biome" format --write "$FILE_PATH" 2>/dev/null
    elif command -v oxfmt &>/dev/null; then
      oxfmt "$FILE_PATH" 2>/dev/null
    elif command -v biome &>/dev/null; then
      biome format --write "$FILE_PATH" 2>/dev/null
    fi
    ;;
  *.py)
    if command -v ruff &>/dev/null; then
      ruff format "$FILE_PATH" 2>/dev/null
    fi
    ;;
esac

exit 0
