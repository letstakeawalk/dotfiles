local fugitive_ext = require("utils.fugitive_ext")

-- if vim.api.nvim_win_get_width(0) < 88 then
--     vim.cmd.wincmd("J")
-- end

vim.wo.number = false
vim.wo.relativenumber = false

-- stylua: ignore start
vim.keymap.set("n", "gU", fugitive_ext.nav.untracked,       { desc = "Goto Untracked", buffer = true })
vim.keymap.set("n", "gu", fugitive_ext.nav.unstaged,        { desc = "Goto Unstaged",  buffer = true })
vim.keymap.set("n", "P",  fugitive_ext.cmd.git_push,        { buffer = true })
vim.keymap.set("n", "X",  fugitive_ext.cmd.discard_changes, { buffer = true })
vim.keymap.set("n", "?",  fugitive_ext.help.toggle,         { buffer = true })
-- stylua: ignore end

fugitive_ext.help.update_help_header()

vim.api.nvim_create_autocmd({ "BufEnter", "WinLeave", "VimResized", "FocusGained", "FocusLost" }, {
    group = vim.api.nvim_create_augroup("FugitiveExtOpen", { clear = true }),
    buffer = 0,
    callback = fugitive_ext.help.open,
})

vim.api.nvim_create_autocmd("WinClosed", {
    group = vim.api.nvim_create_augroup("FugitiveExtClose", { clear = true }),
    buffer = 0,
    callback = fugitive_ext.help.close,
})
