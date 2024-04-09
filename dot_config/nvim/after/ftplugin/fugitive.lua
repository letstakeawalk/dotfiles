if vim.api.nvim_win_get_width(0) < 88 then
    vim.cmd.wincmd("J")
end

vim.keymap.set("n", "gU", "<Plug>fugitive:gu", { buffer = true })
vim.keymap.set("n", "gu", "<Plug>fugitive:gU", { buffer = true })
