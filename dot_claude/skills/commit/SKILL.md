---
name: commit
description: "Generate a conventional commit message from staged changes and copy to clipboard."
allowed-tools: Bash(pbcopy:*), Bash(git diff:*), Bash(git log:*), Bash(git branch:*), Bash(gh:*), Bash(glab:*)
argument-hint: [hint] [--pr]
---

## Context
- Branch: !`git branch --show-current`
- Staged diff: !`git diff --cached`
- Recent commits: !`git log --oneline -10`

## Rules

- If there are no staged changes (empty diff above), say so and stop
- **ONLY use the staged diff shown above** — never run `git status`, `git diff` (without `--cached`), or any command that shows unstaged/untracked files

## Commit Message Format

- Conventional Commits: `type(scope): description`
- Types: feat, fix, refactor, chore, docs, style, test, perf, ci, build
- Use `!` before `:` for breaking changes
- Scope: short identifier for the area affected
- No emojis, no "Co-Authored-By" or AI attribution
- Title max 72 characters
- Add a body after a blank line only if changes are complex enough to warrant it
- Body MUST be a bulleted list (`- ` per line) — never use prose paragraphs
- Wrap function names, file names, types, and other code references in backticks (e.g., `verify_token`, `auth.rs`)
- Match the style of the recent commits shown above

## PR Title Format

When `$ARGUMENTS` contains `--pr`:
- Generate a PR title (under 70 characters) in addition to the commit message
- If multiple commits exist on the branch, summarize the overall change
- Use `gh pr view` or `git log main..HEAD` for full branch context
- Copy both to clipboard, clearly separated

## Arguments

`$ARGUMENTS` may contain:
- A hint for the message (type, scope, or intent)
- `--pr` to also generate a PR title
- A PR/issue number for additional context — fetch with `gh issue view` or `glab issue view`

## Output

1. Copy the message to clipboard using a `pbcopy <<'EOF'` heredoc. Do not pipe from `cat`, `echo`, `printf`, or any other command. Do not stage, commit, or modify files.
2. After copying, present the full commit message (and PR title/body if `--pr`) in a code block.
