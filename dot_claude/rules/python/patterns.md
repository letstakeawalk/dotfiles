---
paths:
  - "**/*.py"
  - "**/pyproject.toml"
  - "**/requirements*.txt"
---

# Python Patterns

## Conventions
- Follow existing project conventions (some projects use strict typing, others don't)
- Use `pathlib.Path` over `os.path`
- Prefer f-strings over `.format()` or `%`

## Testing
- Follow project's existing test framework (pytest preferred)
