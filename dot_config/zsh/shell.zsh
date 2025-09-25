# Shell options and history settings
setopt EXTENDED_HISTORY      # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY    # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY         # Share history between all sessions.
setopt HIST_IGNORE_DUPS      # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS  # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE     # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS     # Do not write a duplicate event to the history file.
setopt HIST_VERIFY           # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY        # append to history file (Default)
setopt HIST_NO_STORE         # Don't store history commands
setopt HIST_REDUCE_BLANKS    # Remove superfluous blanks from each command line being added to the history.

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
zle_highlight=(paste:none region:none)

# General Aliases
alias so="source $XDG_CONFIG_HOME/zsh/.zshrc"
alias c=clear           # clear screen
alias f=open            # open in MacOS finder
alias ff=openf
alias openf='fd --type directory --max-depth 3 | fzf | xargs open'
alias mkdir='mkdir -pv' # mkdir: create parent directories
alias py=python3
alias doco='docker-compose'
alias doma='docker-machine'
alias chez=chezmoi
alias seshf=sesh_fzf.sh
alias jqf='fd --type file "json$" | fzf --preview "bat --color=always -n {1}" --preview-window=right,60% | xargs cat | jq "."'
alias tldrf='tldr --list | fzf --preview "tldr --color always {1}" --preview-window=right,70% | xargs tldr'

# Vim Aliases
alias v=nvim
alias vi=nvim
alias vim=nvim
alias vimdiff='nvim -d'
alias view='nvim -R'
alias vdiff=vimdiff
alias vf=nvimf
alias vif=nvimf
alias vimf=nvimf
alias nvimf='fd --type file --hidden | fzf --preview "bat --color=always -n {1}" --preview-window=right,60% | xargs nvim'

# Modern CLI Alternatives
alias find=fd
alias grep=rg
alias cat=bat
alias cd=z
alias dust='dust --reverse'
alias ls='eza --group-directories-first'
alias lt='eza -a --tree --level 2'
alias lt3='eza -a --tree --level 3'
alias lt4='eza -a --tree --level 4'
alias lt5='eza -a --tree --level 5'
alias ltd='eza -a --tree --only-dirs'
alias la='eza -lhga --git --time-style long-iso --group-directories-first'
alias ll='eza -lhg --git --time-style long-iso --group-directories-first'
alias l=ll

# Quick Navigation
alias config="z $XDG_CONFIG_HOME"
alias data="z $XDG_DATA_HOME"
alias state="z $XDG_STATE_HOME"
alias cache="z $XDG_CACHE_HOME"

# Git Aliases
alias gst='git status'
alias ga='git add'
alias grs='git restore'
alias grm='git rm'
alias gcm='git commit'
alias gcma='git commit --amend'
alias gcman='git commit --amend --no-edit'
alias goops='git commit --amend --no-edit'
alias gcl='git clone'
alias gclwt="git clone-worktree"
alias gwt='git worktree'
alias gco='git checkout'
alias gdi='git diff'
alias gdiff='git diff'
alias glast='git log -5'
alias glog='git log --graph --oneline --decorate'
alias gbr='git branch'
alias gsw='git switch'
alias gswf='git branch --sort=-committerdate | fzf --header "Checkout recent branch" --preview "git diff --color=always {1}" | xargs git switch'
alias gsta='git stash'
alias gps='git push'
alias gpl='git pull'
alias gfe='git fetch'
alias gre='git rebase'
alias gme='git merge'
alias gcp='git cherry-pick'
alias gbi='git bisect'
alias gbl='git blame'

# Functions
# Always show ls when changing directories
function chpwd() {
    pwd
    eza --group-directories-first
}

# Benchmark zsh startup time
timezsh() {
    echo "\n--- w/ zshrc vs w/o zshrc ---"
    shell=${1-$SHELL}
    hyperfine -N --warmup 5 --max-runs 30 "$shell -i -c exit" "$shell -i -f -c exit"
}
