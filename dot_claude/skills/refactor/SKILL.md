---
name: refactor
description: Identify and apply refactoring opportunities — supports full analysis, cleanup, simplify, structure, naming, and DRY focus modes.
allowed-tools: Bash(git:*)
argument-hint: [target] [mode: full|cleanup|simplify|structure|naming|dry]
---

## Context
- Branch: !`git branch --show-current`
- Changed files: !`git diff --name-only HEAD`
- Diff stats: !`git diff --stat HEAD`

## Task

Analyze code for refactoring opportunities, present findings, and apply selected refactors with user approval.

### Parse Arguments

`$ARGUMENTS` may contain a **target** and/or a **focus mode**.

- **Target**: file path, directory, `staged`, or empty (defaults to changed files from context above)
- **Focus mode**: `full`, `cleanup`, `simplify`, `structure`, `naming`, `dry`

If `$ARGUMENTS` is empty or contains only a target with no mode, use `AskUserQuestion` to ask which mode:

| Mode | Description |
|------|-------------|
| `full` | All categories — thorough refactoring pass |
| `cleanup` | Pre-commit tidying — dead code, unused imports, simplify recent changes |
| `simplify` | Reduce over-engineering — unnecessary indirection, premature abstractions |
| `structure` | Reorganize — extract/move functions/modules, split large files |
| `naming` | Naming consistency — variables, functions, types aligned with conventions |
| `dry` | Reduce duplication — within-file and cross-file shared patterns |

If no target is given either, also ask what to refactor (suggest changed files if any exist).

---

### Step 1: Read

1. Read all target files fully
2. Read surrounding code in the same module/directory for context
3. Identify the project's existing patterns, naming conventions, and style

### Step 2: Analyze

Based on the focus mode, identify opportunities. **Present findings only — do not change anything yet.**

#### full (all of the below)

#### cleanup
- Unused imports and dead code
- Variables/functions defined but never used
- Overly verbose patterns that can be simplified
- Debug artifacts (`dbg!`, `console.log`, `print`)
- Commented-out code

#### simplify
- Unnecessary indirection (wrapper functions that just delegate)
- Premature abstractions (generic over one type, trait with one impl)
- Verbose patterns where idiomatic alternatives exist
- Over-nested logic that can be flattened (early returns, guard clauses)

#### structure
- Functions longer than ~50 lines — extract candidates
- Files longer than ~300 lines — split candidates
- Code that belongs in a different module based on responsibility
- Related functions scattered across files that should be co-located
- Public API surface that could be narrowed

#### naming
- Inconsistent naming within the module (mixed conventions)
- Names that don't match what the code does
- Abbreviations where full words would be clearer
- Boolean names missing `is_`/`has_`/`should_` prefixes

#### dry
- Duplicated logic within the target files
- Cross-file duplication (search the broader codebase)
- Patterns that could share a helper without premature abstraction
- Copy-pasted code with minor variations

### Step 3: Present

Present findings grouped by category, ranked by impact:

```
## Refactoring Opportunities

### Target
[What was analyzed, which mode]

### Findings
[HIGH] src/auth.rs:42 — `validate_and_process_token` is 80 lines, does validation + processing + logging
  Suggestion: Extract into `validate_token`, `process_token`, `log_auth_event`

[MEDIUM] src/auth.rs:15 — `fn helper` doesn't describe what it helps with
  Suggestion: Rename to `extract_bearer_token`

[LOW] src/utils.rs:30 — Unused import `std::collections::BTreeMap`
  Suggestion: Remove

### Summary
- High impact: [count]
- Medium impact: [count]
- Low impact: [count]
```

**Ask the user which findings to apply** — they may want all, some, or none.

### Step 4: Apply

For each approved refactor:
1. State briefly what you're changing and why
2. Make the edit
3. Verify surrounding code still makes sense (imports, callers, etc.)

After all refactors, summarize what changed.

---

## Rules

- Never refactor without presenting findings first
- Never change code the user didn't approve
- Match existing project patterns — don't impose new conventions
- If a refactor would change public API, flag it explicitly before applying
- Keep refactors atomic — one logical change at a time, don't bundle unrelated changes
