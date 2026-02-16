---
name: review
description: Pre-commit code review — detects language and spawns the appropriate reviewer agent
allowed-tools: Bash(git:*)
argument-hint: [optional: rs|ts|py to force a specific reviewer]
---

## Context
- Branch: !`git branch --show-current`
- Changed files: !`git diff --name-only HEAD`
- Diff stats: !`git diff --stat HEAD`

## Task

Review staged/unstaged changes before commit by spawning the appropriate language-specific reviewer agent.

### Language Detection

1. If the user specified a reviewer via `$ARGUMENTS` (`rs`, `ts`, or `py`), use that
2. Otherwise, detect from the changed files above:
   - `.rs` files → `rs-reviewer`
   - `.ts`, `.svelte`, `.js` files → `ts-reviewer`
   - `.py` files → `py-reviewer`
3. If multiple languages are changed, spawn **each** matching reviewer in parallel
4. If no changed files or no matching reviewer, say so and stop

### Execution

Spawn the matching reviewer agent(s) with the full diff as input:
- Pass the output of `git diff HEAD` as the argument
- Let the agent run its diagnostics, review all sections, and produce the report
- Present the agent's report as-is — do NOT auto-fix anything
- If multiple reviewers ran, present each report under a language header
