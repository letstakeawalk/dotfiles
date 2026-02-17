---
name: document
description: Audit documentation for drift — stale docstrings, missing docs on public APIs, outdated README sections. Spawns the document agent.
allowed-tools: Bash(git:*)
argument-hint: [optional: file/dir path, "staged", "all"]
---

## Context
- Branch: !`git branch --show-current`
- Changed files: !`git diff --name-only HEAD`

## Task

Audit documentation for the specified target by spawning the `document` agent.

### Target Detection

1. If `$ARGUMENTS` specifies a path, "staged", or "all", pass it through directly
2. If no arguments, default to changed files from the context above
3. If no changed files, say so and stop

### Execution

Spawn the `document` agent with the resolved target:
- Pass `$ARGUMENTS` (or the default) as the agent's input
- Present the agent's report as-is — do NOT auto-fix anything
