return {
	{
		"arcticicestudio/nord-vim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("nord")
			vim.g.nord_cursor_line_number_background = 1
			vim.g.nord_uniform_diff_background = 1
			vim.g.nord_bold = 1
			vim.g.nord_italic = 1
			vim.g.nord_italic_comments = 1
			vim.g.nord_underline = 1

			-- custom highlights
			local nord = require("utils").nord
			vim.api.nvim_set_hl(0, "Italic", { italic = true })
			vim.api.nvim_set_hl(0, "Comment", { italic = true, default = true })
			vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
			vim.api.nvim_set_hl(0, "FloatTitle", { fg = nord.c09 })
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = nord.c03_br })
			vim.api.nvim_set_hl(0, "TabLine", { fg = nord.c04, bg = nord.c01, sp = nord.c11 })
			vim.api.nvim_set_hl(0, "TabLineSel", { fg = nord.c04, bg = nord.c11, sp = nord.c11 })
			vim.api.nvim_set_hl(0, "TabLineFill", { fg = nord.c04, bg = nord.c01, sp = nord.c11 })
			vim.api.nvim_set_hl(0, "Folded", { fg = nord.c03, bg = nord.c01, bold = false })
			vim.api.nvim_set_hl(0, "Search", { bg = nord.c10 })
		end,
	},
}
