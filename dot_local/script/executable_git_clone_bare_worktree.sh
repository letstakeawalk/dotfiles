#!/usr/bin/env bash

# Examples of call:
#
# git_clone_bare_worktree git@github.com:name/repo.git
# -> Clones to a /repo directory
#
# git_clone_bare_worktree git@github.com:name/repo.git my-repo
# -> Clones to a /my-repo directory
set -e # exit on error

# Check if URL argument is provided
if [ "$1" = "" ]; then
    echo "Usage: git clone-worktree <git-url> [directory-name]"
    echo ""
    echo "Examples:"
    echo "  git clone-worktree git@github.com:name/repo.git"
    echo "  -> Clones to a /repo directory"
    echo ""
    echo "  git clone-worktree git@github.com:name/repo.git my-repo"
    echo "  -> Clones to a /my-repo directory"
    exit 1
fi

url=$1
basename=${url##*/}
name=${2:-${basename%.*}}

mkdir "$name"
cd "$name"

# Moves all the administrative git files (a.k.a $GIT_DIR) under .bare directory.
#
# Plan is to create worktrees as siblings of this directory.
# Example targeted structure:
# - repo/.bare
# - repo/main
# - repo/feature-x
# - repo/hotfix
# - ...
git clone --bare "$url" .bare
echo "gitdir: ./.bare" >.git

# Explicitly sets the remote origin fetch so we can fetch remote branches
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

# Gets all branches from origin
git fetch origin

# Reference: https://morgan.cugerone.com/blog/workarounds-to-git-worktree-using-bare-repository-and-cannot-fetch-remote-branches/
