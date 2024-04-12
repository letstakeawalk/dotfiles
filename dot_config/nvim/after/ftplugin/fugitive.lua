local fugitive_ext = require("utils.fugitive_ext")

fugitive_ext.help.generate()
fugitive_ext.ui.update_help_header()

-- Set fugitive specific keymaps
-- stylua: ignore start
vim.keymap.set("n", "gU", fugitive_ext.nav.untracked,       { desc = "Goto Untracked", buffer = true })
vim.keymap.set("n", "gu", fugitive_ext.nav.unstaged,        { desc = "Goto Unstaged",  buffer = true })
vim.keymap.set("n", "P",  fugitive_ext.cmd.git_push,        { buffer = true })
vim.keymap.set("n", "X",  fugitive_ext.cmd.discard_changes, { buffer = true })
vim.keymap.set("n", "?",  fugitive_ext.help.toggle,         { buffer = true })
-- stylua: ignore end

vim.wo.number = false
vim.wo.relativenumber = false
vim.wo.scrolloff = #vim.g.fugitive_ext_help.text + 1 -- +1 for border

vim.api.nvim_create_autocmd({ "BufEnter", "WinLeave", "WinResized", "VimResized", "FocusGained", "FocusLost" }, {
    group = vim.api.nvim_create_augroup("FugitiveExtOpen", { clear = true }),
    buffer = 0,
    callback = fugitive_ext.help.open,
})

vim.api.nvim_create_autocmd({ "WinClosed", "BufUnload" }, {
    group = vim.api.nvim_create_augroup("FugitiveExtClose", { clear = true }),
    buffer = 0,
    callback = fugitive_ext.help.close,
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("FugitiveExtEtc", { clear = true }),
    pattern = { "gitcommit", "gitrebase", "gitignore" },
    callback = fugitive_ext.help.close,
})
