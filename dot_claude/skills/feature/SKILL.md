---
name: feature
description: "Guided feature development — explores codebase, clarifies requirements, designs approach, implements with review gates. Use for substantial new features."
allowed-tools: Read, Glob, Grep, Edit, Write, Bash(git diff:*), Bash(git log:*), Bash(git status:*), Bash(git branch:*), Bash(git ls-tree:*)
argument-hint: [feature description]
---

## Context
- Branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -5`
- Project structure: !`git ls-tree --name-only HEAD 2>/dev/null | head -20`

## Task

Guide feature implementation through structured phases. Each phase needs user approval before next.

Feature request: $ARGUMENTS

If empty, ask what to build.

### Phase 1: Scope
1. Restate understanding in 2-3 sentences
2. Ask clarifying questions — ambiguities, edge cases, scope boundaries
3. **Wait for answers**

### Phase 2: Explore
1. Read relevant existing code (Explore subagent for broad search)
2. Present: key files, patterns, integration points, constraints
3. List 5-10 files that will be touched

### Phase 3: Design
- Complex features: spawn `Plan` agent with description + explore findings
- Simple features: propose approach inline with trade-offs
- If user wants formal doc/ADR: spawn `architect` agent
- **Wait for approval**

### Phase 4: Implement
1. Implement following approved approach and codebase conventions
2. List what was created/modified

### Phase 5: Verify
Spawn in parallel:
1. Matching `*-reviewer` agent(s) on changed files
2. `doc-auditor` agent on changed files
3. `test-analyzer` agent on changed files

Present consolidated findings. **Ask what to address.**

### Phase 6: Wrap Up
1. Summarize: what was built, key decisions, files modified
2. Suggest next steps (if any)

## Rules

- Never skip Phase 1 — confirm understanding even if request seems clear
- Never start Phase 4 without explicit approval
- Keep phases lightweight for small features
- Use existing agents/skills — don't duplicate their work inline
- `/design-critique` for UI/UX feedback, `/review` for code quality
