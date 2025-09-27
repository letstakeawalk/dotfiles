#!/usr/bin/env bash

set -e # exit on error

# Check if branch name argument is provided
if [ "$1" = "" ]; then
    echo "Usage: git_worktree_add.sh <branch-name> [worktree-path]"
    echo ""
    echo "Examples:"
    echo "  git worktree-add feature/foo"
    echo "  -> Creates worktree at ./feature/foo"
    echo ""
    echo "  git worktree-add feature/foo <worktree-path>"
    echo "  -> Creates worktree at <worktree-path>"
    echo ""
    echo "This script will:"
    echo "  - Create a new branch if it doesn't exist locally"
    echo "  - Track remote branch if it exists"
    echo "  - Create a worktree for the branch"
    exit 1
fi

branch_name=$1
worktree_path=${2:-$branch_name}

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Check if worktree path already exists
if [ -d "$worktree_path" ]; then
    echo "Error: Directory '$worktree_path' already exists"
    exit 1
fi

# Check if branch already exists locally
if git show-ref --verify --quiet refs/heads/"$branch_name"; then
    echo "Local branch '$branch_name' already exists, creating worktree..."
    git worktree add "$worktree_path" "$branch_name"
    echo "Worktree created at '$worktree_path' for existing local branch '$branch_name'"
    exit 0
fi

# Check if remote branch exists
if git show-ref --verify --quiet refs/remotes/origin/"$branch_name"; then
    echo "Remote branch 'origin/$branch_name' found, creating local tracking branch..."
    git worktree add -b "$branch_name" "$worktree_path" "origin/$branch_name"
    echo "Worktree created at '$worktree_path' for new local branch '$branch_name' tracking 'origin/$branch_name'"
else
    echo "Creating new branch '$branch_name'..."
    git worktree add -b "$branch_name" "$worktree_path"
    echo "Worktree created at '$worktree_path' for new branch '$branch_name'"
fi
