# Global Claude Code Rules

## Identity
- Primary stack: Rust (backend), TypeScript/SvelteKit (frontend), Python, Bash
- Package manager: bun (TS/JS), uv (Python); defer to project's lockfile if present
- Linting/formatting: oxlint/oxfmt or biome (not eslint/prettier)
- Editor: NeoVim with custom Lua config
- OS: macOS
- Language-specific conventions are in `~/.claude/rules/` — always follow them

## Git & Commits
- NEVER commit, push, or create branches without explicit instruction
- NEVER amend commits unless specifically asked
- When I say "commit", I mean generate the message only (use /commit skill)

## Before Modifying Code
- Never assume intent — if requirements or goals are ambiguous, ask before proceeding
- If unsure where something belongs, ask — don't guess
- When suggesting an Edit, briefly state why this approach (unless the change is trivial)

## Testing
- Suggest tests for new features, but don't auto-generate them unless asked

## Safety
- Never modify CI/CD configs, Cargo.toml dependencies, or package.json dependencies without asking
- Never touch `.env` files or files containing secrets
