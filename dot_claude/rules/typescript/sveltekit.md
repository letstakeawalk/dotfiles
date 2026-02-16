---
paths:
  - "**/*.svelte"
  - "**/*.ts"
  - "**/*.js"
  - "**/+page*.ts"
  - "**/+layout*.ts"
  - "**/+server.ts"
---

# SvelteKit / Svelte 5 Patterns

## Svelte 5 Runes (mandatory)
- Use `$state()` for reactive state — NEVER use `writable()` or legacy stores
- Use `$derived()` for computed values — NEVER use `$:` reactive declarations
- Use `$effect()` for side effects — NEVER use `$:` statements for side effects
- Use `$props()` for component props — NEVER use `export let`
- Use `$bindable()` for two-way binding props
- Use snippet blocks `{#snippet name()}...{/snippet}` over slots

## SvelteKit Routing
- `+page.server.ts`: server-only load functions (DB queries, secrets)
- `+page.ts`: universal load functions (runs on server + client)
- `+server.ts`: API endpoints (GET, POST, PUT, DELETE)
- Form actions in `+page.server.ts` for mutations — prefer over client-side fetch
- Use `$app/navigation` for programmatic navigation

## Package Manager
- Use `bun` — not npm, pnpm, or yarn
- Commands: `bun run`, `bun add`, `bun remove`, `bunx`

## File Organization
- Components in `src/lib/components/`
- Utilities in `src/lib/utils/` or `src/lib/server/` for server-only code
- Types in `src/lib/types/` or co-located with usage
- Follow existing project structure — check `src/lib/` layout before creating files

## TypeScript
- Use strict mode; avoid `any` — prefer `unknown` and narrow with type guards
- Prefer `const` over `let`, never `var`
- Use `satisfies` operator for type checking without widening

## Testing
- Follow project's existing test setup
