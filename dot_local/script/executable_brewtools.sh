#!/bin/bash

action="$1"

case "$action" in
    leaves)
        brew leaves | xargs brew deps --formula --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"
        ;;
    deps)
        brew list -1 --formula | xargs brew deps --formula --for-each | sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"
        ;;
    installed)
        brew info --json=v2 --installed | jq -r ".formulae[]|select(any(.installed[]; .installed_on_request)).full_name"
        ;;
    *)
        echo "Usage: $0 {leaves|deps|installed}"
        echo "  leaves    - Show dependencies for leaf packages"
        echo "  deps      - Show dependencies for all installed packages"
        echo "  installed - Show packages installed on request"
        exit 1
        ;;
esac