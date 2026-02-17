---
name: test-coverage
description: Analyze test coverage gaps — untested public APIs, missing edge cases, uncovered error paths. Spawns the test-analyzer agent.
allowed-tools: Bash(git:*)
argument-hint: [optional: file/dir path, "staged", "all"]
---

## Context
- Branch: !`git branch --show-current`
- Changed files: !`git diff --name-only HEAD`

## Task

Analyze test coverage for the specified target by spawning the `test-analyzer` agent.

### Target Detection

1. If `$ARGUMENTS` specifies a path, "staged", or "all", pass it through directly
2. If no arguments, default to changed files from the context above
3. If no changed files, say so and stop

### Execution

Spawn the `test-analyzer` agent with the resolved target:
- Pass `$ARGUMENTS` (or the default) as the agent's input
- Present the agent's report as-is — do NOT generate test code unless explicitly asked
