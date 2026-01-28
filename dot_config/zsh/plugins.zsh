# Zinit Installation and Setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

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
export FZF_TMUX_OPTS="-p 50%,50%" # "--reverse"
zinit light Aloxaf/fzf-tab

# Load plugins with proper wait for performance
zinit wait lucid for \
 depth"1" atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay;" \
    zdharma-continuum/fast-syntax-highlighting \
 depth"1" blockf \
    zsh-users/zsh-completions \
 depth"1" atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# Completion styling
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# To make fzf-tab follow FZF_DEFAULT_OPTS.
# NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' default-color ""
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --bind='tab:accept'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# # tmux popup
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# Vim Mode Configuration
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
ZVM_VI_INSERT_ESCAPE_BINDKEY=kh
ZVM_VI_HIGHLIGHT_FOREGROUND=#D8DEE9
ZVM_VI_HIGHLIGHT_BACKGROUND=#434C5E
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

    # source `fzf` after zvm -- keybinding issues
    # https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#execute-extra-commands
    source <(fzf --zsh)
}

# History Configuration
HISTFILE="$XDG_DATA_HOME/zsh_history"
HISTSIZE=1000000
HISTORY_IGNORE="(ls|cd|z|eza|exit)*"
HIST_STAMPS="yyyy-mm-dd"

source <(starship init zsh)
source <(zoxide init zsh) # this must come after compinit


# edit-command-line
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^g' edit-command-line

# magic space
bindkey ' ' magic-space
