# Zinit Installation and Setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Vim Mode Configuration
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_VI_INSERT_ESCAPE_BINDKEY=kh
# ZVM_VI_HIGHLIGHT_FOREGROUND=
# ZVM_VI_HIGHLIGHT_BACKGROUND=#434C5E
function zvm_after_init() {
    bindkey -M   vicmd    k    vi-down-line-or-history
    bindkey -M   vicmd    h    vi-up-line-or-history
    bindkey -M   vicmd    j    vi-backward-char
    bindkey -M   vicmd    l    vi-forward-char
    bindkey -M   visual   k    vi-down-line-or-history
    bindkey -M   visual   h    vi-up-line-or-history
    bindkey -M   visual   j    vi-backward-char
    bindkey -M   visual   l    vi-forward-char
    bindkey '^[f' vi-forward-word  # alt + right_arrow
    bindkey '^[b' vi-backward-word # alt + left_arrow
    # bindkey -M   viins   '^w'  vi-backward-kill-word
}

# zinit ice depth"1"
# zinit light mroth/evalcache
# _evalcache zoxide init zsh
# _evalcache starship init zsh

# Load plugins with proper wait for performance
zinit wait lucid for \
 depth"1" \
    jeffreytse/zsh-vi-mode \
 depth"1" atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay;" \
    zdharma-continuum/fast-syntax-highlighting \
 depth"1" blockf \
    zsh-users/zsh-completions \
 depth"1" atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# Completion styling
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} \
    'ma=48;2;67;76;94'

source <(starship init zsh)
source <(fzf --zsh)
source <(zoxide init zsh)
