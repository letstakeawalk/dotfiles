-- tmux navigator
vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>")

vim.api.nvim_create_user_command("TmuxNavigateLeft", "call s:TmuxAwareNavigate('j')", {})
vim.api.nvim_create_user_command("TmuxNavigateRight", "call s:TmuxAwareNavigate('l')", {})
vim.api.nvim_create_user_command("TmuxNavigateDown", "call s:TmuxAwareNavigate('k')", {})
vim.api.nvim_create_user_command("TmuxNavigateUp", "call s:TmuxAwareNavigate('h')", {})
vim.api.nvim_create_user_command("TmuxNavigatePrevious", "call s:TmuxAwareNavigate('p')", {})

-- tmux runner
vim.g.VtrUseVtrMaps = 0
vim.g.VtrStripLeadingWhitespace = 0
vim.g.VtrClearEmptyLines = 0
vim.g.VtrAppendNewline = 1
local run_py = function()
	local path = vim.api.nvim_buf_get_name(0)
	vim.cmd("VtrSendCommandToRunner! python3 " .. path)
end

vim.keymap.set("n", "<leader>cpy", run_py, { desc = "Run this Python file" })
vim.keymap.set("n", "<leader>cr", "<cmd>VtrSendCommandToRunner<cr>", { desc = "Send command to tmux runner" })
vim.keymap.set({ "n", "x" }, "<leader>cl", "<cmd>VtrSendLinesToRunner<cr>", { desc = "Send lines to tmux runner" })
vim.keymap.set("n", "<leader>cf", "<cmd>VtrFlushCommand<cr>", { desc = "Flush commands tmux runner" })
vim.keymap.set("n", "<leader>co", "<cmd>VtrOpenRunner<cr>", { desc = "Open tmux runner" })
vim.keymap.set("n", "<leader>ck", "<cmd>VtrKillRunner<cr>", { desc = "Kill tmux runner" })
vim.keymap.set("n", "<leader>cc", "<cmd>VtrClearRunner<cr>", { desc = "Clear tmux runner" })
-- vim.keymap.set("n", "<leader>cf", "<cmd>VtrFocusRunner<cr>", { desc = "Focus tmux runner" })
