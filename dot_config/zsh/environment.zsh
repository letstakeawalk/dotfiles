# XDG Base Directory Specification
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_RUNTIME_DIR=$HOME/.cache
export WORKSPACE=$HOME/Workspace

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

# Editor Configuration
if [[ -n $SSH_CONNECTION ]]; then
  export VISUAL='nvim'
  export EDITOR='nvim'
else
  export VISUAL='nvim'
  export EDITOR='nvim'
fi

# FZF Configuration
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(up|down|hidden|)'"
export FZF_CTRL_R_OPTS="--layout=reverse"
export FZF_DEFAULT_COMMAND="fd --type file --hidden --follow"
export FZF_DEFAULT_OPTS="
  --color='fg:#98A2B5,fg+:#98A2B5,fg+:regular,bg+:#434C5E'
  --color='hl:#D8DEE9,hl:bold,hl+:#D8DEE9,info:#434C5E,border:#616E88'
  --color='gutter:-1,pointer:bright-blue'
  --prompt=' ' --pointer=' '"
export FZF_TMUX_OPTS="-p 50%,50% --reverse"

# History Configuration
HISTFILE="$XDG_DATA_HOME/zsh_history"
HISTSIZE=1000000
HISTORY_IGNORE="(ls|cd|z|eza|exit)*"
HIST_STAMPS="yyyy-mm-dd"

# Evalcache Configuration
export ZSH_EVALCACHE_DIR="$XDG_CACHE_HOME/zsh-evalcache"

# LS Colors with Nord theme
NORD_TEAL="38;2;143;188;187"
NORD_CYAN="38;2;136;192;208"
NORD_GLACIER="38;2;129;161;193"
NORD_BLUE="38;2;94;129;172"
NORD_RED="38;2;191;97;106"
NORD_ORANGE="38;2;208;135;112"
NORD_YELLOW="38;2;235;203;139"
NORD_GREEN="38;2;163;190;140"
NORD_PURPLE="38;2;180;142;173"
export LS_COLORS="$(vivid generate nord):Cargo.toml=1;${NORD_ORANGE}"