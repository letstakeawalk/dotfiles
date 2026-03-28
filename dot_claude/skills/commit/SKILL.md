---
name: commit
description: "Generate a conventional commit message and copy to clipboard. Spawns the commit-msg agent for isolated context."
argument-hint: [hint] [--pr]
---

## Task

Spawn the `commit-msg` agent with `$ARGUMENTS` in the current working directory (`$CWD`). After the agent finishes, run `pbpaste` to retrieve the commit message and present it in a code block.
