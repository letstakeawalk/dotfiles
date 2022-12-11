vim.cmd [[autocmd BufWinEnter <buffer> wincmd L]]

-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   group = vim.api.nvim_create_augroup("HelpVertPane", {}),
--   -- command = [[ windcmd L ]],
--   callback = function() vim.cmd([[<buffer> windcmd L]]) end
-- })
