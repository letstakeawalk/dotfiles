---
name: commit
description: "Generate a conventional commit message and copy to clipboard. Spawns the commit-msg agent for isolated context."
argument-hint: [hint] [--pr]
---

## Task

Spawn the `commit-msg` agent with `$ARGUMENTS`. Do NOT mention the working directory in the prompt — the agent inherits it automatically. After the agent finishes, run `pbpaste` to retrieve the commit message and present it in a code block.
