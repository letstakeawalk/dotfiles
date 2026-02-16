---
paths:
  - "**/*.rs"
  - "**/Cargo.toml"
  - "**/Cargo.lock"
---

# Rust Patterns

## Error Handling
- Library crates: define error types with `thiserror::Error`
- Application crates: use `anyhow::Result` for propagation, `anyhow::Context` for adding context
- Never `.unwrap()` or `.expect()` outside of tests — use `?` operator
- Map errors at boundaries: `map_err` when crossing module/crate boundaries

## Idiomatic Patterns
- Prefer iterators + combinators (`.map()`, `.filter()`, `.collect()`) over manual loops
- Use `match` over `if let` when handling more than one variant
- Use `impl Into<T>` / `AsRef<T>` for flexible function parameters
- Prefer `&str` over `&String`, `&[T]` over `&Vec<T>` in function signatures
- Use `Default::default()` and `#[derive(Default)]` where appropriate
- Builder pattern for structs with >3 optional fields

## Module Organization
- Check existing `mod.rs` / `lib.rs` before adding new modules
- Public API should be re-exported from the crate root
- Keep `pub` surface area minimal — default to private
- Integration tests go in `tests/`, unit tests in `#[cfg(test)]` submodule

## Derive Order
- `Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, Default, Serialize, Deserialize`
- Only derive what's actually needed

## Async
- Prefer `tokio` conventions if the project uses tokio
- Use `async fn` in traits (Rust 1.75+) where supported
- Avoid mixing sync and async code at the same level

## Testing
- Use `#[cfg(test)]` module in same file for unit tests
- Integration tests go in `tests/` directory
- `.unwrap()` and `.expect()` are acceptable in tests
