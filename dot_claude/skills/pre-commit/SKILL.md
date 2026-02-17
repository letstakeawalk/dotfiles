---
name: pre-commit
description: "Run review + document audit + test coverage analysis on staged changes in one shot. Pre-commit quality gate."
allowed-tools: Bash(git:*)
argument-hint: [focus hint]
---

## Context
- Branch: !`git branch --show-current`
- Staged files: !`git diff --cached --name-only`
- Staged stats: !`git diff --cached --stat`

## Task

Run all quality checks on staged changes before committing. This is a one-shot orchestrator that spawns review, document, and test-coverage agents in parallel.

If there are no staged changes, say so and stop.

### Execution

Spawn all three in parallel on staged changes:

1. **Review**: Spawn the matching `*-reviewer` agent(s) — detect language from staged files, pass `staged` + any `$ARGUMENTS` as focus hints
2. **Document audit**: Spawn the `document` agent with `staged`
3. **Test coverage**: Spawn the `test-analyzer` agent with `staged`

### Output

Present each report under a clear header:

```
## Pre-commit Quality Gate

### Code Review
[reviewer agent report]

### Documentation
[document agent report]

### Test Coverage
[test-analyzer agent report]

### Verdict
[BLOCK / WARN / APPROVE based on worst severity across all reports]
```

Do NOT auto-fix anything. Present findings and let the user decide what to address before committing.
