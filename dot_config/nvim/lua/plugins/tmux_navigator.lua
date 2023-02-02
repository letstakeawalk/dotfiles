return {
	"christoomey/vim-tmux-navigator",
	lazy = false,
	config = function()
		vim.g.tmux_navigator_no_mappings = 1
		vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateLeft<cr>")
		vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
		vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateDown<cr>")
		vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateUp<cr>")
		vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<cr>")
	end,
}
