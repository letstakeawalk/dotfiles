return {
	"kazhala/close-buffers.nvim",
  keys = "<C-q>",
	config = function()
		local cb = require("close_buffers")
		cb.setup({
			filetype_ignore = {}, -- Filetype to ignore when running deletions
			file_glob_ignore = {}, -- File name glob pattern to ignore when running deletions (e.g. '*.md')
			file_regex_ignore = {}, -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
			preserve_window_layout = { "this", "nameless" }, -- Types of deletion that should preserve the window layout
			next_buffer_cmd = nil, -- Custom function to retrieve the next buffer when preserving window layout
		})

		vim.keymap.set("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit buffer" })
		vim.keymap.set("n", "<C-q><C-a>", "<cmd>BDelete other<cr>", { desc = "Close other buffers" })
		vim.keymap.set("n", "<C-q><C-q>", "<cmd>BDelete this<cr>", { desc = "Close this buffer" })
	end,
} -- preserve window layout with bdelete/bwipeout
