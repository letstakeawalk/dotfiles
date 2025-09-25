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
