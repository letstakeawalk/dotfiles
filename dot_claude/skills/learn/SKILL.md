---
name: learn
description: >
  Reflect on the current session and extract reusable patterns worth remembering.
  Use when a session involved mistakes, corrections, debugging breakthroughs,
  or workarounds that should inform future sessions.
allowed-tools: Read, Write, Edit, Glob, Bash(git:*)
argument-hint: [optional: focus area to reflect on]
---

## Task

Reflect on this session's conversation and extract patterns worth persisting to memory.

This is NOT the same as `/remember` (which saves explicit user-stated facts). This skill is about **self-reflection** — analyzing what happened during the session to find implicit lessons.

## What to Look For

Scan the conversation for:

1. **User corrections** — where I was wrong and the user corrected me. What was the mistake? What's the right approach?
2. **Error resolutions** — debugging that led to a fix. What was the root cause? How was it found?
3. **Workarounds** — solutions to framework/library/tool quirks that aren't obvious
4. **Over-engineering** — where I was told to simplify. What did I over-complicate?
5. **Project conventions** — patterns established or reinforced during the session
6. **Effective approaches** — techniques that worked well and should be repeated

If the user provided a focus area via `$ARGUMENTS`, prioritize that.

## Extraction Rules

- Only extract patterns that are **reusable across sessions** — skip one-time fixes
- Be honest about mistakes — the point is to learn, not save face
- Keep each pattern to 1-3 lines — concise and actionable
- Skip anything already covered in CLAUDE.md or rules files

## Where to Save

### Locate Memory Directory
1. Check if inside a git repo: `git rev-parse --show-toplevel`
2. The project key is the repo root path (or cwd if not in a repo) with `/` replaced by `-` and leading `-` stripped
3. Memory dir: `~/.claude/projects/<project>/memory/`
4. If the directory doesn't exist, show the computed path and ask before creating

### Save Patterns
1. Read existing MEMORY.md to avoid duplicates
2. Add new patterns under a clear category heading
3. If a pattern is detailed enough to warrant its own file, create a topic file and link from MEMORY.md
4. Keep MEMORY.md under 200 lines

## Output

After saving, summarize:
- How many patterns extracted
- What was saved and where
- Any patterns you considered but skipped (and why)
