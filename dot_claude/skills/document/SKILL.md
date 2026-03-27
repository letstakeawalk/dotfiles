---
name: document
description: "Audit documentation for drift — stale docstrings, missing docs on public APIs, outdated README sections. Spawns the document agent."
allowed-tools: Read, Glob, Grep, Edit, Write, Bash(git diff:*), Bash(git branch:*)
argument-hint: [file/dir|staged|all] [--fix]
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

### Fix Mode

**Default (no `--fix`)**: present the report as-is, do not auto-fix anything.

**With `--fix`**: after presenting the report, automatically fix trivial issues:
- Missing docstrings on public APIs (match the project's existing convention)
- Parameter name mismatches in existing docstrings
- Obvious typos in comments/docstrings
- Stale `@param` / `@returns` tags that don't match the current signature

Leave anything requiring judgment (rewriting explanations, updating README sections, clarifying ambiguous docs) as remaining items for the user to address.
