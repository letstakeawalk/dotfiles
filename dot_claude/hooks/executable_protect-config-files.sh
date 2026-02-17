#!/bin/bash
# Warn before modifying dependency manifests or CI config
# NOTE: exit 2 = require user approval. With auto-edit enabled, this silently denies
# the edit (no approval prompt). Add early exit 0 for safe files (e.g., .env.example).
input=$(cat)
FILE_PATH=$(echo "$input" | jq -r '.tool_input.file_path // empty')

# Files that warrant a warning before modification
# Allow .env.example and .env.sample through
if echo "$FILE_PATH" | grep -qE '\.env\.(example|sample|template)$'; then
  exit 0
fi

if echo "$FILE_PATH" | grep -qE '(Cargo\.toml|package\.json|package-lock\.json|pnpm-lock\.yaml|\.github/|\.gitlab-ci|Dockerfile|docker-compose|\.env)'; then
  echo "Modifying config/dependency file: $FILE_PATH — verify user requested this change." >&2
  exit 2
fi

exit 0
