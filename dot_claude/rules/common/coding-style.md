# Common Coding Style

## Naming
- Use the language's idiomatic naming convention (snake_case for Rust/Python, camelCase for TS)
- Name things for what they represent, not what they are (e.g., `users` not `user_vec`)
- Boolean variables/functions: use `is_`, `has_`, `should_`, `can_` prefixes

## Structure
- Read existing files before creating new ones — match the project's patterns
- One concept per file; if a file grows beyond ~300 lines, consider splitting
- Imports: group by stdlib, external deps, internal modules (with blank line between groups)

## Simplicity
- Do not refactor surrounding code unless explicitly asked
- Do not add error handling for impossible scenarios
- Do not create abstractions for one-time operations
- Three similar lines of code is better than a premature abstraction
- Don't add feature flags or backwards-compatibility shims — just change the code
- Delete dead code completely; don't comment it out or rename with `_` prefix
- No emojis in code or comments
