return {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufReadPost",
	config = function()
		require("indent_blankline").setup({
			-- for example, context is off by default, use this to turn it on
			show_current_context = true, -- current context highlight
			show_current_context_start = false,
			use_treesitter = true,
			filetype_exclude = { "help", "dashboard", "NvimTree" },
		})
	end,
}
