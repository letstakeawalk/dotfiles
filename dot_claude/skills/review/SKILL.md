---
name: review
description: Code review — detects language and spawns the appropriate reviewer agent. Works with diffs, staged changes, files, or directories.
allowed-tools: Bash(git:*)
argument-hint: [optional: rs|ts|py, file/dir path, "staged", or focus hint]
---

## Context
- Branch: !`git branch --show-current`
- Changed files: !`git diff --name-only HEAD`
- Diff stats: !`git diff --stat HEAD`

## Task

Review code by spawning the appropriate language-specific reviewer agent.

### Target Detection

1. If `$ARGUMENTS` specifies file paths or directories, use those to determine language and pass them to the agent
2. If `$ARGUMENTS` is a language hint (`rs`, `ts`, `py`), use that reviewer
3. If `$ARGUMENTS` is `staged`, run `git diff --cached` and detect language from changed files
4. If no arguments, default to `git diff HEAD` and detect language from changed files
5. If multiple languages are present, spawn **each** matching reviewer in parallel
6. If no changed files or no matching reviewer, say so and stop

Language detection:
- `.rs` files → `rs-reviewer`
- `.ts`, `.svelte`, `.js` files → `ts-reviewer`
- `.py` files → `py-reviewer`

### Execution

Spawn the matching reviewer agent(s):
- Pass the full `$ARGUMENTS` through — the agent handles diffs, paths, and focus instructions
- If no arguments, pass the output of `git diff HEAD`
- Present the agent's report as-is — do NOT auto-fix anything
- If multiple reviewers ran, present each report under a language header
