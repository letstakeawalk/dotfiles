if vim.api.nvim_win_get_width(0) < 88 then
    vim.cmd.wincmd("J")
end
