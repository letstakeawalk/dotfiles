#!/usr/bin/env bash

action="$1"

show_leaves() {
    brew leaves | \
        xargs brew deps --formulae --for-each | \
        sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"
}

show_deps() {
    brew list -1 --formulae | \
    xargs brew deps --formulae --for-each | \
    sed "s/^.*:/$(tput setaf 4)&$(tput sgr0)/"
}

show_installed() {
    case "${1:-all}" in
        formulae)
            brew list --installed-on-request -1
            ;;
        casks)
            brew list --cask -1
            ;;
        all)
            brew list --installed-on-request -1
            brew list --cask -1
            ;;
        *)
            echo "Usage: $0 installed {formulae|casks|all}"
            exit 1
            ;;
    esac
}

show_extras() {
    if [[ ! -f "$HOMEBREW_BUNDLE_FILE" ]]; then
        echo "Error: HOMEBREW_BUNDLE_FILE not set or file doesn't exist" >&2
        exit 1
    fi
    show_installed | \
        while read -r pkg; do
            grep -q "\"$pkg\"" "$HOMEBREW_BUNDLE_FILE" || echo "$pkg"
        done
}

show_missing() {
    if [[ ! -f "$HOMEBREW_BUNDLE_FILE" ]]; then
        echo "Error: HOMEBREW_BUNDLE_FILE not set or file doesn't exist" >&2
        exit 1
    fi

    installed_pkgs=$(mktemp)
    trap 'rm -f "$installed_pkgs"' EXIT

    show_installed formulae > "$installed_pkgs"
    show_installed casks >> "$installed_pkgs"

    grep -E '^(brew|cask) "' "$HOMEBREW_BUNDLE_FILE" | \
        sed 's/.*"\([^"]*\)".*/\1/' | \
        while read -r pkg; do
            # Extract just the formula name from tapped formulae (author/tap/formula -> formula)
            formula_name="${pkg##*/}"
            grep -q "^$formula_name$" "$installed_pkgs" || echo "$pkg"
        done
}


case "$action" in
    leaves)
        show_leaves
        ;;
    deps)
        show_deps
        ;;
    installed)
        shift
        show_installed "$1"
        ;;
    extras)
        show_extras
        ;;
    missing)
        show_missing
        ;;
    *)
        echo "Usage: $0 {leaves|deps|installed|extras|missing}"
        echo "  leaves    - Show dependencies for leaf packages"
        echo "  deps      - Show dependencies for all installed packages"
        echo "  installed - Show packages installed on request (use 'installed formulae|casks|all')"
        echo "  extras    - Show installed packages not in brewfile"
        echo "  missing   - Show packages in brewfile but not installed"
        exit 1
        ;;
esac
