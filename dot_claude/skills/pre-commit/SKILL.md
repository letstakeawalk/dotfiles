---
name: pre-commit
description: "Run review + document audit + test coverage analysis on staged changes in one shot. Pre-commit quality gate."
allowed-tools: Read, Glob, Grep, Edit, Write, Bash(git diff:*), Bash(git branch:*)
argument-hint: [focus hint] [--fix]
---

## Context
- Branch: !`git branch --show-current`
- Staged files: !`git diff --cached --name-only`
- Staged stats: !`git diff --cached --stat`

## Task

Run all quality checks on staged changes before committing.

If there are no staged changes, say so and stop.

### Execution

Run in two phases:

**Phase 1** — Spawn in parallel:
1. **Document audit**: Spawn the `document` agent with `staged`
2. **Test coverage**: Spawn the `test-analyzer` agent with `staged`

**Phase 2** — After Phase 1 completes:
3. **Code review**: Spawn the matching `*-reviewer` agent(s) — detect language from staged files, pass `staged` + any `$ARGUMENTS` as focus hints

This ordering ensures the reviewer sees the final state if `--fix` was applied in Phase 1.

### Output

Present each report under a clear header:

```
## Pre-commit Quality Gate

### Documentation
[document agent report]

### Test Coverage
[test-analyzer agent report]

### Code Review
[reviewer agent report]

### Verdict
[BLOCK / WARN / APPROVE based on worst severity across all reports]
```

### Fix Mode

**Default (no `--fix`)**: present all findings, do not auto-fix anything.

**With `--fix`**: after each phase, automatically fix trivial issues (same rules as `/review --fix` and `/document --fix`). Phase 2 review then runs against the updated code. Leave non-trivial issues as remaining items for the user to address.
