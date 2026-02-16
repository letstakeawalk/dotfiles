#!/bin/bash
# Block dangerous bash commands unless explicitly approved
input=$(cat)
COMMAND=$(echo "$input" | jq -r '.tool_input.command // empty')

# Patterns that should always be blocked
if echo "$COMMAND" | grep -qE '(rm\s+-rf\s+[/~]|git\s+push\s+--force|git\s+reset\s+--hard|git\s+clean\s+-f|DROP\s+TABLE|DROP\s+DATABASE)'; then
  echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"Destructive command blocked. Ask the user for explicit approval first."}}' >&2
  exit 2
fi

# Warn on git commit/push (should only happen when user explicitly asks)
if echo "$COMMAND" | grep -qE '^git\s+(commit|push|tag)\b'; then
  echo '{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"Git mutation detected. Verify user explicitly requested this."}}' >&2
  exit 2
fi

exit 0
