#!/bin/bash

# Read JSON input
input=$(cat)

# Extract values from JSON
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
model=$(echo "$input" | jq -r '.model.display_name | split(" ")[0]')
ctx_used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

# Get current time in HH:MM format
current_time=$(date +%H:%M)

# Convert absolute path to relative with ~/...
relative_path="${cwd/#$HOME/~}"

# Git branch detection
git_branch=""
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    git_branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)

    if [ "$git_branch" = "" ]; then
        git_branch=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
    fi

    # Dirty indicator: * for unstaged, + for staged
    git_dirty=""
    git_status=$(git -C "$cwd" --no-optional-locks status --porcelain 2>/dev/null)
    if [ "$git_status" != "" ]; then
        git_dirty="*"
    fi
fi

cost_fmt=$(printf '%.2f' "$cost")

# Colors: Path=#88C0D0 Branch=#B48EAD Ctx=#EBCB8B Cost=#A3BE8C Model=#686B70 Time=#82858C

# Print left side
printf "\033[38;2;136;192;208m%s\033[0m" "$relative_path"           # Path: #88C0D0
if [ "$git_branch" != "" ]; then
    printf " \033[38;2;180;142;173m%s%s\033[0m" "$git_branch" "$git_dirty"  # Branch: #B48EAD
fi

# Print padding
# printf "%s" "$padding"
printf " "

# Print right side: model, ctx, cost, time
printf "\033[38;2;104;107;112m%s\033[0m" "$model"               # Model: #686B70
if [ "$ctx_used" != "" ]; then
    printf " \033[38;2;235;203;139mctx:%s%%\033[0m" "$ctx_used" # Ctx: #EBCB8B
fi
if [ "$(echo "$cost > 0" | bc)" = "1" ]; then
    printf " \033[38;2;163;190;140m\$%s\033[0m" "$cost_fmt"     # Cost: #A3BE8C
fi
printf " \033[38;2;130;133;140m%s\033[0m" "$current_time"       # Time: #82858C

echo ""
