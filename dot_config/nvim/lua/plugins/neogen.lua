return {
	"danymat/neogen",
	dependencies = "nvim-treesitter/nvim-treesitter",
	cmd = "Neogen",
	keys = { {
		"<leader>rd",
		function()
			require("neogen").generate()
		end,
		desc = "Generate annotation",
	} },
	config = function()
		local ng = require("neogen")
		ng.setup({
			snippet_engine = "luasnip",
		})
	end,
	-- Uncomment next line if you want to follow only stable versions
	-- version = "*"
}
