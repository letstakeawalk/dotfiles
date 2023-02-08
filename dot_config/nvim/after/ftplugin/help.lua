vim.cmd [[autocmd BufWinEnter <buffer> wincmd L]]

-- vim.api.nvim_create_autocmd("BufWinEnter", {
--   pattern = "help",
--   group = vim.api.nvim_create_augroup("Help", {}),
--   callback = function() vim.cmd([[<buffer> windcmd L]]) end
-- })

-- local function is_wide_win()
--   return vim.fn.winwidth(0) > 160
-- end
--
-- if is_wide_win() then
--   print("wide window")
--   vim.cmd [[ wincmd L ]]
-- else
--   print("narrow window")
-- end
