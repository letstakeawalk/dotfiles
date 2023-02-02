return {
	"christoomey/vim-tmux-runner",
	event = "VeryLazy",
	config = function()
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
		vim.keymap.set(
			{ "n", "x" },
			"<leader>cl",
			"<cmd>VtrSendLinesToRunner<cr>",
			{ desc = "Send lines to tmux runner" }
		)
		vim.keymap.set("n", "<leader>cf", "<cmd>VtrFlushCommand<cr>", { desc = "Flush commands tmux runner" })
		vim.keymap.set("n", "<leader>co", "<cmd>VtrOpenRunner<cr>", { desc = "Open tmux runner" })
		vim.keymap.set("n", "<leader>ck", "<cmd>VtrKillRunner<cr>", { desc = "Kill tmux runner" })
		vim.keymap.set("n", "<leader>cc", "<cmd>VtrClearRunner<cr>", { desc = "Clear tmux runner" })
	end,
}
