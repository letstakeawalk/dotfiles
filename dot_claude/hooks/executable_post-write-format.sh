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
    # Use cargo fmt to respect Cargo.toml edition and rustfmt.toml config
    # This matches rust-analyzer's formatting behavior
    if command -v cargo &>/dev/null; then
      MANIFEST_DIR="$PROJECT_DIR"
      if [ "$MANIFEST_DIR" = "" ]; then
        MANIFEST_DIR=$(dirname "$FILE_PATH")
      fi
      # Walk up to find Cargo.toml
      while [ "$MANIFEST_DIR" != "/" ] && [ ! -f "$MANIFEST_DIR/Cargo.toml" ]; do
        MANIFEST_DIR=$(dirname "$MANIFEST_DIR")
      done
      if [ -f "$MANIFEST_DIR/Cargo.toml" ]; then
        (cd "$MANIFEST_DIR" && cargo fmt -- "$FILE_PATH" 2>/dev/null)
      elif command -v rustfmt &>/dev/null; then
        rustfmt "$FILE_PATH" 2>/dev/null
      fi
    elif command -v rustfmt &>/dev/null; then
      rustfmt "$FILE_PATH" 2>/dev/null
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
