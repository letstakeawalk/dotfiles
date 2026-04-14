---
name: freeze
description: "Temporarily protect files/directories from edits during a session. Use to prevent accidental changes to files outside current scope. /freeze <paths> to lock, /freeze --list to show, /freeze --clear to unlock all."
allowed-tools: Read, Write, Bash(cat:*), Bash(rm:*)
argument-hint: <file or dir paths> | --list | --clear
---

## Task

Manage a temporary freeze list that prevents Claude from editing specified files during this session.

## Commands

- `/freeze src/db/ schema.sql` — add paths to freeze list
- `/freeze --list` — show currently frozen paths
- `/freeze --clear` — remove all frozen paths
- `/freeze --remove src/db/` — remove specific path from freeze list

## How It Works

1. Freeze list stored at `~/.claude/.frozen-paths`
2. One path per line (files or directories)
3. The `protect-config-files.sh` PreToolUse hook reads this file and blocks Edit/Write to matching paths
4. List persists until cleared or session ends

## When Invoked

Parse `$ARGUMENTS`:

### Adding paths
- Write each path to `~/.claude/.frozen-paths` (append, don't overwrite)
- Normalize paths: expand `~`, resolve relative to cwd, strip trailing `/`
- Confirm what was frozen

### `--list`
- Read and display `~/.claude/.frozen-paths`
- If empty or missing, say "No frozen paths"

### `--clear`
- Remove `~/.claude/.frozen-paths`
- Confirm all paths unfrozen

### `--remove <path>`
- Remove matching line from `~/.claude/.frozen-paths`
- Confirm what was unfrozen

## Output

```
Frozen: src/db/, schema.sql
```

or

```
Unfrozen all paths.
```

Keep output minimal.

## Rules

- Never freeze the freeze list file itself
- Warn if user tries to freeze cwd or entire project root
- Paths are prefix-matched: freezing `src/db/` blocks `src/db/schema.sql`
