# Path Configuration
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin
export PATH=$HOME/.local/script:$PATH # custom scripts
export PATH=$HOME/.local/bin:$PATH # custom bins
export PATH=$MISE_DATA_DIR/shims:$PATH # mise shims
export PATH=$CARGO_HOME/bin:$PATH # rust
export PATH=$RUSTUP_HOME/toolchains/stable-aarch64-apple-darwin/bin:$PATH # rust
export PATH=$XDG_DATA_HOME/bob/nvim-bin:$PATH # neovim
export PATH=$XDG_DATA_HOME/nvim/mason/bin:$PATH # lsp, linters, formatters
# export PATH=/opt/homebrew/opt/llvm/bin:$PATH # llvm
export PATH=/opt/homebrew/opt/libpq/bin:$PATH
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH # should be last line