return {
	"tpope/vim-fugitive", -- git wrapper
	dependencies = {
		"junegunn/gv.vim", -- git commit browser
		"tpope/vim-rhubarb", -- fugitive extension for GitHub
	},
	event = "VeryLazy",
	config = function()
		vim.keymap.set("n", "<leader>gv", ":GV<cr>", { desc = "Git Commit Browser" })
		vim.keymap.set("n", "<leader>gV", ":GV!<cr>", { desc = "Git BufCommit Browser" })
	end,
}
