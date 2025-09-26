#!/usr/bin/env bash

set -e # exit on error

# Check if arguments are provided
if [ "$#" -eq 0 ]; then
    echo "Usage: git worktree-remove <worktree-path> [-d|--delete-branch]"
    echo "       git worktree-remove [-d|--delete-branch] <worktree-path>"
    echo ""
    echo "Examples:"
    echo "  git worktree-remove feature-branch"
    echo "  -> Removes worktree only, keeps branch"
    echo ""
    echo "  git worktree-remove <worktree-path> -d"
    echo "  git worktree-remove -d <worktree-path>"
    echo "  git worktree-remove <worktree-path> --delete-branch"
    echo "  -> Removes worktree and deletes the associated branch"
    echo ""
    echo "Options:"
    echo "  -d, --delete-branch    Also delete the branch after removing worktree"
    exit 1
fi

worktree_path=""
delete_branch=false

# Parse arguments to handle flags in any order
for arg in "$@"; do
    case $arg in
        -d|--delete-branch)
            delete_branch=true
            ;;
        *)
            if [ "$worktree_path" = "" ]; then
                worktree_path="$arg"
            fi
            ;;
    esac
done

# Check if worktree path was provided
if [ "$worktree_path" = "" ]; then
    echo "Error: No worktree path specified"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Check if worktree path exists
if [ ! -d "$worktree_path" ]; then
    echo "Error: Worktree directory '$worktree_path' does not exist"
    exit 1
fi

# Get the branch name associated with this worktree
branch_name=$(git -C "$worktree_path" branch --show-current 2>/dev/null || echo "")

if [ "$branch_name" = "" ]; then
    echo "Warning: Could not determine branch name for worktree '$worktree_path'"
    echo "Removing worktree only..."
    git worktree remove "$worktree_path"
    echo "Worktree '$worktree_path' removed"
    exit 0
fi

# Remove the worktree
echo "Removing worktree '$worktree_path' (branch: '$branch_name')..."
git worktree remove "$worktree_path"
echo "Worktree '$worktree_path' removed"

# Delete branch if requested
if [ "$delete_branch" = true ]; then
    # Check if branch exists locally
    if git show-ref --verify --quiet refs/heads/"$branch_name"; then
        # Check if branch has a remote tracking branch
        if git config --get branch."$branch_name".remote > /dev/null 2>&1; then
            remote=$(git config --get branch."$branch_name".remote)
            remote_branch=$(git config --get branch."$branch_name".merge | sed 's|refs/heads/||')

            echo "Branch '$branch_name' tracks '$remote/$remote_branch'"
            read -p "Do you want to delete the remote branch '$remote/$remote_branch' as well? (y/N): " delete_remote

            if [ "$delete_remote" = "y" ] || [ "$delete_remote" = "Y" ]; then
                echo "Deleting remote branch '$remote/$remote_branch'..."
                git push "$remote" --delete "$remote_branch"
                echo "Remote branch '$remote/$remote_branch' deleted"
            fi
        fi

        echo "Deleting local branch '$branch_name'..."
        git branch -D "$branch_name"
        echo "Local branch '$branch_name' deleted"
    else
        echo "Warning: Local branch '$branch_name' not found"
    fi
fi
