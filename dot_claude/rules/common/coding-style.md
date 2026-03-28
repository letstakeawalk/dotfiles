# Common Coding Style

## Naming
- Use the language's idiomatic naming convention (snake_case for Rust/Python, camelCase for TS)
- Name things for what they represent, not what they are (e.g., `users` not `user_vec`)
- Boolean variables/functions: use `is_`, `has_`, `should_`, `can_` prefixes

## Structure
- One concept per file; if a file grows beyond ~300 lines, consider splitting
- Imports: group by stdlib, external deps, internal modules (with blank line between groups)
