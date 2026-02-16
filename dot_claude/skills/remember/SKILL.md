---
name: remember
description: >
  This skill should be used when the user says "remember this",
  "save this for later", "note this down", "always do X",
  "never do Y", or wants to persist a decision or preference
  across sessions.
allowed-tools: Read, Write, Edit, Glob, Bash(git:*)
argument-hint: <what to remember>
---

## Task

Persist user decisions, preferences, and patterns to auto-memory
so they survive across sessions.

## Locate Memory Directory

The auto-memory directory is per-project at `~/.claude/projects/<project>/memory/`.
To find the correct `<project>` path:
1. Check if inside a git repo: `git rev-parse --show-toplevel`
2. The project key is the repo root path (or cwd if not in a repo)
   with `/` replaced by `-` and leading `-` stripped
3. Verify the memory directory exists at the computed path
4. **If the directory does not exist or MEMORY.md is not found**:
   - Show the user the path you computed and what you tried
   - Ask if they want you to create it, or if the path looks wrong
   - Do NOT write to a guessed or fallback location without confirmation

## Steps

1. Parse what the user wants remembered from `$ARGUMENTS` or the
   preceding conversation
2. Read the current MEMORY.md to check for duplicates or conflicts
3. **If the note conflicts with an existing memory, show both versions
   and ask the user to confirm before overwriting**
4. Categorize the note (preference, decision, pattern, gotcha, workflow)
5. Write to the appropriate location:
   - Quick one-liner: add directly to MEMORY.md
   - Detailed topic: create/append to a topic file, link from MEMORY.md
   - Existing topic file matches: append there
6. Confirm what was saved and where

## Rules

- Keep entries concise — one line per fact when possible
- Don't duplicate what's already in CLAUDE.md or rules files
- MEMORY.md must stay under 200 lines (only first 200 are loaded)
- Use topic files for anything that needs detail
