---
name: review
description: "Code review — detects language and spawns the appropriate reviewer agent. Works with diffs, staged changes, files, or directories."
allowed-tools: Read, Glob, Grep, Edit, Write, Bash(git diff:*), Bash(git log:*), Bash(git status:*), Bash(git branch:*)
argument-hint: [file/dir|staged|lang] [security|performance|idioms|bugs|tests] [--fix] [--deep]
---

## Context
- Branch: !`git branch --show-current`
- Changed files: !`git diff --name-only HEAD`
- Diff stats: !`git diff --stat HEAD`

## Task

Review code by spawning the appropriate language-specific reviewer agent.

### Target Detection

1. If `$ARGUMENTS` specifies file paths or directories, use those to determine language and pass them to the agent
2. If `$ARGUMENTS` is a language name or extension (e.g., `rs`, `rust`, `ts`, `python`), find the matching `*-reviewer` agent in `~/.claude/agents/`
3. If `$ARGUMENTS` is `staged`, run `git diff --cached` and detect language from changed files
4. If no arguments, default to `git diff HEAD` and detect language from changed files
5. If multiple languages are present, spawn **each** matching reviewer in parallel
6. If no changed files or no matching reviewer, say so and stop

### Language → Reviewer Mapping

Match files to reviewer agents by extension. Look for `*-reviewer` agents in `~/.claude/agents/` to discover available reviewers. Common mappings:
- `.rs` → `rs-reviewer`
- `.ts`, `.svelte`, `.js`, `.jsx`, `.tsx` → `ts-reviewer`
- `.py` → `py-reviewer`

If a new `*-reviewer` agent exists (e.g., `go-reviewer`), use it automatically for matching extensions.

### Focus

If `$ARGUMENTS` includes a focus keyword (`security`, `performance`, `idioms`, `bugs`, `tests`), pass it through to the agent. The agent will run all review sections but emphasize the focused area in its report.

### Execution

Spawn the matching reviewer agent(s):
- Pass the full `$ARGUMENTS` through — the agent handles target, focus, and any other instructions
- If no arguments, pass the output of `git diff HEAD`
- If multiple reviewers ran, present each report under a language header

### Fix Mode

**Default (no `--fix`)**: present the report as-is, do not auto-fix anything.

**With `--fix`**: after presenting the report, automatically fix trivial issues:
- Debug artifacts: `console.log`, `dbg!()`, `print()`, `debugger`
- Unused imports, dead variables
- Missing `await` on async calls
- Obvious typos in strings/comments
- Simple lint fixes (formatting, trailing whitespace, missing semicolons)

Leave anything requiring judgment (logic changes, security fixes, API changes, refactors) as remaining items for the user to address.

### Thorough Mode

**With `--deep`**: run a full quality gate. In addition to the code review, also spawn the `doc-auditor` and `test-analyzer` agents.

Run in two phases:

**Phase 1** — Spawn in parallel:
1. **Doc audit**: Spawn the `doc-auditor` agent on the target
2. **Test coverage**: Spawn the `test-analyzer` agent on the target

**Phase 2** — After Phase 1 completes:
3. **Code review**: Spawn the matching `*-reviewer` agent(s)

This ordering ensures the reviewer sees the final state if `--fix` was applied in Phase 1.

Present each report under a clear header, ending with a verdict:
`BLOCK` (any CRITICAL/HIGH), `WARN` (MEDIUM only), or `APPROVE` (no issues).

`--deep` can be combined with `--fix`.
