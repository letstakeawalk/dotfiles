#!/bin/bash
# Warn before modifying dependency manifests or CI config
input=$(cat)
FILE_PATH=$(echo "$input" | jq -r '.tool_input.file_path // empty')

# Files that warrant a warning before modification
if echo "$FILE_PATH" | grep -qE '(Cargo\.toml|package\.json|package-lock\.json|pnpm-lock\.yaml|\.github/|\.gitlab-ci|Dockerfile|docker-compose|\.env)'; then
  echo "Modifying config/dependency file: $FILE_PATH — verify user requested this change." >&2
  exit 2
fi

exit 0
