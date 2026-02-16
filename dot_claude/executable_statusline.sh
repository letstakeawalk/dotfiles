#!/bin/bash

# Read JSON input
input=$(cat)

# Extract values from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name')
ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Get current time in HH:MM format
current_time=$(date +%H:%M)

# Convert absolute path to relative with ~/...
relative_path="${cwd/#$HOME/~}"

# Git branch detection
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    git_branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)

    if [ -z "$git_branch" ]; then
        git_branch=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
    fi
fi

# Build output: <CWD> <branch> ctx:<ctx%> <Model> <time>
# Colors: Path=#88C0D0 Branch=#B48EAD Ctx=#D08770 Model=#686B70 Time=#82858C

printf "\033[38;2;136;192;208m%s\033[0m" "$relative_path"

if [ -n "$git_branch" ]; then
    printf " \033[38;2;180;142;173m%s\033[0m" "$git_branch"
fi

if [ -n "$ctx_used" ]; then
    printf " \033[38;2;235;203;139mctx:%s%%\033[0m" "$ctx_used"
fi

printf " \033[38;2;104;107;112m%s\033[0m" "$model"

printf " \033[38;2;130;133;140m%s\033[0m" "$current_time"

echo ""
