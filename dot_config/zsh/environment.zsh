# Application Configuration
export BOB_CONFIG=$XDG_DATA_HOME/bob/config.json
export CARGO_HOME=$XDG_DATA_HOME/cargo
export CC=gcc
export CHEZMOI_SOURCE=$XDG_DATA_HOME/chezmoi
export DOCKER_CONFIG=$XDG_CONFIG_HOME/docker
export GITLINT_CONFIG=$XDG_CONFIG_HOME/git/gitlintrc
export EZA_CONFIG_DIR=$XDG_CONFIG_HOME/eza
export GOKU_EDN_CONFIG_FILE=$XDG_CONFIG_HOME/goku/karabiner.edn
export GOPATH=$XDG_DATA_HOME/go
export HOMEBREW_BUNDLE_FILE=$XDG_CONFIG_HOME/brewfile/Brewfile
export LESS="-R --lesskey-src=$XDG_CONFIG_HOME/less/lesskey"
export MISE_CACHE_DIR=$XDG_CACHE_HOME/mise
export MISE_CONFIG_DIR=$XDG_CONFIG_HOME/mise
export MISE_DATA_DIR=$XDG_DATA_HOME/mise
export MISE_STATE_DIR=$XDG_STATE_HOME/mise
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export OBSIDIAN="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notes"
export PAGER=less
export PSQLRC=$XDG_CONFIG_HOME/psql/psqlrc
export PSQL_HISTORY=$XDG_DATA_HOME/psql_history
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/pythonrc
export REDISCLI_HISTFILE=$XDG_DATA_HOME/rediscli_history
export REDISCLI_RCFILE=$XDG_CONFIG_HOME/redis/redisclirc
export RIPGREP_CONFIG_PATH=$XDG_CONFIG_HOME/rg/ripgreprc
export SHELL=/opt/homebrew/bin/zsh
export RUSTUP_HOME=$XDG_DATA_HOME/rustup
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
export TEALDEER_CONFIG_DIR=$XDG_CONFIG_HOME/tealdeer
export _ZO_DATA_DIR=$XDG_DATA_HOME/zoxide

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

# Editor Configuration
if [[ -n $SSH_CONNECTION ]]; then
  export VISUAL='nvim'
  export EDITOR='nvim'
else
  export VISUAL='nvim'
  export EDITOR='nvim'
fi
