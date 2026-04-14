---
name: commit-msg
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

**Subject line:**
- Conventional Commits: `type(scope): imperative summary`
- Types: feat, fix, refactor, chore, docs, style, test, perf, ci, build
- Imperative mood: "add", "fix", "remove" — not "added", "adds", "adding"
- Use `!` before `:` for breaking changes
- Scope: short identifier for the area affected
- No trailing period, no emojis, no "Co-Authored-By" or AI attribution
- Max 72 characters
- Match the style of the recent commits shown above

**Body (only if needed):**
- Skip when subject is self-explanatory — why over what
- Always include body for: breaking changes, security fixes, data migrations, reverts
- Body MUST be a bulleted list (`- ` per line) — never prose paragraphs
- Wrap code references in backticks (e.g., `verify_token`, `auth.rs`)
- Reference issues at end: `Closes #42`, `Refs #17`

**Never write:**
- "This commit does X", "now", "currently" — the diff says what
- Restating the file name when scope already says it

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

1. Copy the message to clipboard using exactly this pattern — no other method:
   ```
   pbcopy <<'EOF'
   message here
   EOF
   ```
   Do not stage, commit, or modify files.
2. After copying, present the full commit message (and PR title/body if `--pr`) in a code block.
