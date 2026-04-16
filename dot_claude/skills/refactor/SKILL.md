---
name: refactor
description: "Identify and apply refactoring opportunities — supports full analysis, cleanup, simplify, structure, naming, and DRY focus modes."
allowed-tools: Read, Glob, Grep, Edit, Write, Bash(git diff:*), Bash(git branch:*)
argument-hint: [file/dir|staged] [full|cleanup|simplify|structure|naming|dry]
---

## Context
- Branch: !`git branch --show-current`
- Changed files: !`git diff --name-only HEAD`
- Diff stats: !`git diff --stat HEAD`

## Task

Analyze code for refactoring opportunities, present findings, apply with user approval.

### Parse Arguments

`$ARGUMENTS` may contain a **target** and/or **focus mode**.

- **Target**: file path, directory, `staged`, or empty (defaults to changed files)
- **Mode**: `full`, `cleanup`, `simplify`, `structure`, `naming`, `dry`

If empty, ask which mode:

| Mode | What |
|------|------|
| `full` | All categories |
| `cleanup` | Dead code, unused imports, debug artifacts, commented-out code |
| `simplify` | Unnecessary indirection, premature abstractions, over-nested logic |
| `structure` | Extract/split large functions (>50 lines) and files (>300 lines), move misplaced code |
| `naming` | Inconsistent names, misleading names, missing `is_`/`has_` prefixes on booleans |
| `dry` | Within-file and cross-file duplication, copy-pasted code with minor variations |

### Step 1: Read

Read all target files + surrounding module context. Identify existing patterns and conventions.

### Step 2: Analyze

Identify opportunities based on mode. **Present findings only — no changes yet.**

### Step 3: Present

```
### Refactoring Opportunities

**Target:** [what was analyzed, which mode]

### Findings
1. src/auth.rs:L42: bug: `validate_and_process_token` is 80 lines. Extract `validate_token`, `process_token`, `log_auth_event`.
2. src/auth.rs:L15: nit: `fn helper` → `extract_bearer_token`.
3. src/utils.rs:L30: nit: unused import `std::collections::BTreeMap`. Remove.

### Verdict: [count] bug / [count] risk / [count] nit
```

Severity: `bug` (structural issues, large functions, significant duplication), `risk` (naming, minor duplication, verbose patterns), `nit` (unused imports, dead code, cosmetic).

**Ask user which findings to apply.**

### Step 4: Apply

For each approved refactor: make edit, verify surrounding code (imports, callers).

### Step 5: Verify

Spawn matching `*-reviewer` agent(s) on changed files. Fix trivial issues, flag the rest.

## Rules

- Never refactor without presenting findings first
- Never change code user didn't approve
- Match existing project patterns
- Flag public API changes explicitly before applying
- Atomic refactors — one logical change at a time
