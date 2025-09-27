`OR`

`git worktree remove {{path/to/directory}}`

- Move a worktree:

`git worktree move {{old/path}} {{new/path}}`

- Lock a worktree:

`git worktree lock {{worktree}} --reason "protected branch"`
`git worktree unlock {{worktree}}`

- Create a new worktree with a new branch from base branch:

`git worktree add {{path/to/directory}} -b {{new_branch}} {{base_branch}}`

- Create a new throwaway worktree with detached HEAD

`git worktree add -d {{path/to/directory}}`

- Clone remote repo as bare

`mkdir foo && cd foo`
`git clone --bare {{url}} .bare`
`echo "gitdir: ./.bare >.git`

`OR`

`git clone-worktree {{url}} {{path/to/directory}}`
