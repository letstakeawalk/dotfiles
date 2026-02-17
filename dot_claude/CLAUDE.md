# Global Claude Code Rules

## Identity
- Primary stack: Rust (backend), TypeScript/SvelteKit (frontend), Python, Bash
- Package manager: bun (not npm/pnpm/yarn)
- Linting/formatting: oxlint/oxfmt or biome (not eslint/prettier)
- Editor: NeoVim with custom Lua config
- OS: macOS
- Language-specific conventions are in `~/.claude/rules/` — always follow them

## Git & Commits
- NEVER commit, push, or create branches without explicit instruction
- NEVER amend commits unless specifically asked
- Use Conventional Commits: `type(scope): description` (max 72 chars)
- Types: feat, fix, refactor, chore, docs, style, test, perf, ci, build
- Use `!` before `:` for breaking changes
- No emojis in commit messages
- Never include "Co-Authored-By" or AI attribution lines
- When I say "commit", I mean generate the message only (use /commit skill)

## Before Modifying Code
- ALWAYS read the existing file before editing it
- ALWAYS check existing project structure before creating new files
- Before editing, read surrounding code in the same file/module to match patterns, style, and design choices
- Follow existing naming conventions, module layout, and patterns in the project
- When suggesting an Edit, briefly state why this approach (unless the change is trivial)
- Never assume intent — if requirements or goals are ambiguous, ask before proceeding
- If unsure where something belongs, ask — don't guess

## Testing
- Suggest tests for new features, but don't auto-generate them unless asked

## Safety
- Never run `rm -rf`, `git push --force`, `git reset --hard`, or `git clean -f` without explicit approval
- Never modify CI/CD configs, Cargo.toml dependencies, or package.json dependencies without asking
- Never touch `.env` files or files containing secrets
