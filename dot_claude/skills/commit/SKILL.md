---
name: commit
description: "Generate a conventional commit message and copy to clipboard"
allowed-tools: Bash(pbcopy:*)
argument-hint: [hint]
---

## Context
- Branch: !`git branch --show-current`
- Status: !`git status --short`
- Diff summary: !`git diff --cached --stat`
- Recent commits: !`git log --oneline -10`
- Full diff: !`git diff --cached`

## Task

Generate a single commit message from the changes above, then copy it to the clipboard with `pbcopy`.

If there are no staged changes (empty diff), say so and stop.

### Format

- Conventional Commits: `type(scope): description`
- Types: feat, fix, refactor, chore, docs, style, test, perf, ci, build
- Use `!` before `:` for breaking changes
- Scope: short identifier for the area affected
- No emojis, no "Co-Authored-By" or AI attribution
- Subject line max 72 characters
- Add a body after a blank line only if changes are complex enough to warrant it
- Body should use a bulleted list (`- `) summarizing individual changes, one per line
- Wrap function names, file names, types, and other code references in backticks (e.g., `verify_token`, `auth.rs`)
- Match the style of the recent commits shown above

### Arguments

If the user provided a hint (`$ARGUMENTS`), incorporate it into the message — it may suggest the type, scope, or intent.

### Output

Copy the message to clipboard via `pbcopy`. Do not stage, commit, or modify files. No other output besides the tool call.
