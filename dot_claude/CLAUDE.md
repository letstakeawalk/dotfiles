# Global Claude Code Rules

## Identity
- Stack: Rust (backend), TypeScript/SvelteKit (frontend), Python, Bash
- Pkg manager: bun (TS/JS), uv (Python); defer to project lockfile
- Lint/fmt: oxlint/oxfmt or biome (not eslint/prettier)
- Editor: NeoVim (custom Lua config)
- OS: macOS
- Follow language conventions in `~/.claude/rules/`

## Git & Commits
- Only commit when explicitly told "commit" or "make commit"
- `/commit-msg` — clipboard-only (no git commands), use the /commit-msg skill
- "make commit" — stage and commit, rules below
- NEVER push to remote without explicit instruction
- NEVER amend commits unless specifically asked
- NEVER create branches without explicit instruction

### "make commit" Rules
1. Review staged + unstaged changes (`git diff --cached` and `git diff`)
2. Split unrelated concerns into separate commits
3. Stage relevant files, then `git commit`
4. Message format (same as /commit-msg skill):
   - Conventional Commits: `type(scope): description`
   - Types: feat, fix, refactor, chore, docs, style, test, perf, ci, build
   - No emojis, no Co-Authored-By, no AI attribution
   - Title max 72 chars; body (if needed) as bulleted list
   - Match style of recent commits
5. After each commit, display message + files included
6. Multiple commits in session → end with summary: count, short hashes, full messages
7. Never commit secrets (`.env`, credentials, etc.)

## Before Modifying Code
- If ambiguous, ask before proceeding
- If unsure where something belongs, ask
- Explain non-obvious choices in summary after changes

## Testing
- Suggest tests for new features, don't auto-generate unless asked

## Safety
- Never modify CI/CD, `Cargo.toml` deps, or `package.json` deps without asking
- Never touch `.env` or files with secrets
