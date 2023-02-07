-- key bindings popup
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			plugins = {
				marks = false, -- shows a list of your marks on ' and `
				registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			},
		})

		wk.register({
			a = { name = "Git" },
			c = { name = "Tmux Runner" },
			d = { name = "Diagnostic" },
			g = { name = "Telescope" },
			n = { name = "Neorg" },
			q = { name = "Close Buffer" },
			r = {
				name = "Refactor",
				k = "Swap Param >>", -- treesitter
				h = "Swap Param <<", -- treesitter
				w = "Trailing Whitespace",
			},
			s = { name = "Source/Reload" },
			t = { name = "Telescope" },
			x = { name = "Trouble" },
		}, { prefix = "<leader>" })
	end,
}
