---
name: learn
description: "Reflect on the current session and extract reusable patterns worth remembering. Use when a session involved mistakes, corrections, debugging breakthroughs, or workarounds that should inform future sessions."
allowed-tools: Read, Write, Edit, Glob, Bash(git rev-parse:*)
argument-hint: [focus area to reflect on]
---

## Task

Reflect on this session's conversation and extract patterns worth persisting to memory.

Not `/remember` (saves explicit user-stated facts). This is **self-reflection** — implicit lessons from what happened during the session.

### Structured Retro

Work through these three questions:

#### 1. What worked?
- Approaches that solved problems efficiently
- Techniques the user confirmed or accepted without pushback
- Patterns that should be repeated

#### 2. What broke?
- Mistakes I made and user corrections
- Debugging dead ends — what was tried and why it failed
- Wrong assumptions about the codebase or requirements
- Over-engineering or under-engineering

#### 3. What to change?
- Workarounds for framework/library/tool quirks
- Project conventions established or reinforced
- Process improvements (e.g., "check X before doing Y")

If the user provided a focus area via `$ARGUMENTS`, prioritize that.

### Locate Memory Directory

1. Check if inside a git repo: `git rev-parse --show-toplevel`
2. Project key: repo root path (or cwd if not in repo) with `/` replaced by `-`, leading `-` stripped
3. Memory dir: `~/.claude/projects/<project>/memory/`
4. If directory doesn't exist, show computed path and ask before creating

### Save Patterns

1. Read existing MEMORY.md to avoid duplicates
2. Add new patterns under a clear category heading
3. If a pattern is detailed enough, create a topic file and link from MEMORY.md
4. Keep MEMORY.md under 200 lines

### Output

After saving, present the retro:

```
### What worked
- [list]

### What broke
- [list]

### What to change
- [list]

### Saved
- [count] patterns extracted
- [where saved]
- [patterns considered but skipped, and why]
```

## Rules

- Only extract patterns **reusable across sessions** — skip one-time fixes
- Be honest about mistakes — the point is to learn, not save face
- Keep each pattern to 1-3 lines — concise and actionable
- Skip anything already covered in CLAUDE.md or rules files
