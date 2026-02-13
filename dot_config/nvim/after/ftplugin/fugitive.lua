local actions = require("fugitive-ext.actions")
-- stylua: ignore start
vim.keymap.set("n", "P",  actions.push_cmdline,              { desc = ":Git push",      buffer = true })
vim.keymap.set("n", "p",  actions.pull_cmdline,              { desc = ":Git pull",      buffer = true })
vim.keymap.set("n", "gu", actions.goto_unstaged,             { desc = "Goto unstaged",  buffer = true })
vim.keymap.set("n", "gU", actions.goto_untracked,            { desc = "Goto untracked", buffer = true })
vim.keymap.set("n", "h",  actions.goto_prev_hunk,            { desc = "Prev hunk",      buffer = true })
vim.keymap.set("n", "k",  actions.goto_next_hunk,            { desc = "Next hunk",      buffer = true })
vim.keymap.set("n", "(",  actions.collapse_curr_expand_prev, { desc = "Previous hunk",  buffer = true })
vim.keymap.set("n", ")",  actions.collapse_curr_expand_next, { desc = "Next hunk",      buffer = true })
-- stylua: ignore end

vim.wo.foldlevel = 99
