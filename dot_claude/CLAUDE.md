# Global Claude Code Rules

## Identity
- Primary stack: Rust (backend), TypeScript/SvelteKit (frontend), Python, Bash
- Package manager: bun (TS/JS), uv (Python); defer to project's lockfile if present
- Linting/formatting: oxlint/oxfmt or biome (not eslint/prettier)
- Editor: NeoVim with custom Lua config
- OS: macOS
- Language-specific conventions are in `~/.claude/rules/` — always follow them

## Git & Commits
- Only commit when I explicitly say "commit" or "make commit"
- `/commit-msg` — clipboard-only (no git commands), use the /commit-msg skill
- "make commit" — actually stage and commit changes, following the rules below
- NEVER push to remote without explicit instruction
- NEVER amend commits unless specifically asked
- NEVER create branches without explicit instruction

### "make commit" Rules
1. Review all staged and unstaged changes (`git diff --cached` and `git diff`)
2. If changes span unrelated concerns, split into multiple logical commits
3. For each commit: stage the relevant files, then `git commit`
4. Message format — same as /commit-msg skill:
   - Conventional Commits: `type(scope): description`
   - Types: feat, fix, refactor, chore, docs, style, test, perf, ci, build
   - No emojis, no Co-Authored-By, no AI attribution
   - Title max 72 characters; body (if needed) as bulleted list
   - Match the style of recent commits on the branch
5. After each commit, display the commit message and list of files included
6. If multiple commits were made in a session, end with a summary: count, short hashes, and full commit messages
7. Never commit files that contain secrets (`.env`, credentials, etc.)

## Before Modifying Code
- Never assume intent — if requirements or goals are ambiguous, ask before proceeding
- If unsure where something belongs, ask — don't guess
- When suggesting an Edit, briefly state why this approach (unless the change is trivial)

## Testing
- Suggest tests for new features, but don't auto-generate them unless asked

## Safety
- Never modify CI/CD configs, Cargo.toml dependencies, or package.json dependencies without asking
- Never touch `.env` files or files containing secrets
