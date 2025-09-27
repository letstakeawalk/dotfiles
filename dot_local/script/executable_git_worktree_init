#!/usr/bin/env bash

set -e # exit on error

# Check if name argument is provided
if [ "$1" = "" ]; then
    echo "Usage: git worktree-init <directory-name>"
    echo ""
    echo "Examples:"
    echo "  git worktree-init foo"
    echo "  -> Creates a new bare repository in ./foo directory"
    exit 1
fi

name=$1

mkdir "$name"
cd "$name"

git init --bare .bare
echo "gitdir: .bare" > .git
