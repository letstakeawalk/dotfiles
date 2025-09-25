#!/usr/bin/env bash

selected=$(sesh list --tmux --hide-attached --icons | fzf-tmux -p 80,40% \
    --no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
    --header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
    --bind 'tab:down,btab:up' \
    --bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list --icons)' \
    --bind 'ctrl-t:change-prompt(⚡  )+reload(sesh list --tmux --icons)' \
    --bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list --config --icons)' \
    --bind 'ctrl-x:change-prompt(📁  )+reload(sesh list --zoxide --icons)' \
    --bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
    --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡  )+reload(sesh list --icons)')
    # --preview-window 'right:55%' \
    # --preview 'sesh preview {}'

# If a session was selected, connect to it
if [[ -n "$selected" ]]; then
  sesh connect "$selected"
fi
