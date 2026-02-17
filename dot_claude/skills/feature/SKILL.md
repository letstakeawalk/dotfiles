---
name: feature
description: Guided feature development — explores codebase, clarifies requirements, designs approach, implements with review gates. Use for substantial new features.
allowed-tools: Bash(git:*)
argument-hint: <feature description>
---

## Context
- Branch: !`git branch --show-current`
- Recent commits: !`git log --oneline -5`
- Project structure: !`ls -d */ 2>/dev/null | head -20`

## Task

Guide a feature implementation through structured phases. Each phase requires user approval before moving to the next.

Feature request: $ARGUMENTS

If `$ARGUMENTS` is empty, ask what the user wants to build.

---

### Phase 1: Scope

1. Restate your understanding of the feature in 2-3 sentences
2. Ask clarifying questions — identify ambiguities, edge cases, integration points, scope boundaries
3. **Wait for answers before proceeding**

### Phase 2: Explore

1. Use the Explore subagent (or read files directly) to understand relevant existing code
2. Present findings: key files, patterns, integration points, constraints
3. List 5-10 key files that will be touched or referenced

### Phase 3: Design

1. Propose an implementation approach — components, data flow, file changes
2. For complex features, spawn the `architect` agent for a structured design doc
3. For simple features, present the approach inline with trade-offs
4. **Wait for user approval of the approach**

### Phase 4: Implement

1. Implement following the approved approach
2. Follow existing codebase conventions
3. After implementation, briefly list what was created/modified

### Phase 5: Verify

Run these in parallel where possible:
1. Spawn the matching `*-reviewer` agent(s) on the changed files
2. Spawn the `document` agent on the changed files
3. Spawn the `test-analyzer` agent on the changed files
4. Present consolidated findings and **ask what to address**

### Phase 6: Wrap Up

1. Summarize: what was built, key decisions, files modified
2. Suggest next steps (if any)

---

## Rules

- Never skip Phase 1 (Scope) — even if the request seems clear, confirm understanding
- Never start Phase 4 (Implement) without explicit user approval
- Keep phases lightweight — if the feature is small, phases 2-3 can be brief
- Use existing agents and skills — don't duplicate their work inline
