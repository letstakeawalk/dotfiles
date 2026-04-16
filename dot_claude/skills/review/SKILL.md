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

1. File paths/directories in `$ARGUMENTS` → determine language, pass to agent
2. Language name/extension (`rs`, `ts`, `python`) → find matching `*-reviewer` in `~/.claude/agents/`
3. `staged` → `git diff --cached`, detect language
4. No arguments → `git diff HEAD`, detect language
5. Multiple languages → spawn each reviewer in parallel
6. No changes or no matching reviewer → stop

### Language → Reviewer

Discover `*-reviewer` agents in `~/.claude/agents/`. Common mappings:
- `.rs` → `rs-reviewer`
- `.ts`, `.svelte`, `.js`, `.jsx`, `.tsx` → `ts-reviewer`
- `.py` → `py-reviewer`

New `*-reviewer` agents auto-match by extension.

### Focus

Focus keyword in `$ARGUMENTS` (`security`, `performance`, `idioms`, `bugs`, `tests`) → pass to agent. Agent emphasizes that area.

### Execution

- Pass full `$ARGUMENTS` to agent
- No arguments → pass `git diff HEAD` output
- Multiple reviewers → present each under language header

### `--fix`

After report, auto-fix trivial issues only:
- Debug artifacts (`console.log`, `dbg!()`, `print()`, `debugger`)
- Unused imports, dead variables
- Missing `await` on async calls
- Simple lint fixes

Leave anything requiring judgment for user.

### `--deep`

Full quality gate. Two phases:

**Phase 1** (parallel):
1. `doc-auditor` agent on target
2. `test-analyzer` agent on target

**Phase 2** (after Phase 1):
3. Matching `*-reviewer` agent(s)

Verdict: `BLOCK` (any bug), `WARN` (risk only), `APPROVE` (clean).

`--deep` combinable with `--fix`.
