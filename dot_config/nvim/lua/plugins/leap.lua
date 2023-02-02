return {
	"ggandor/leap.nvim",
	dependencies = { "ggandor/leap-spooky.nvim", "ggandor/flit.nvim" },
	keys = { "s", "S", "f", "F", "t", "T" },
	config = function()
		local leap = require("leap")
		leap.setup({})
		leap.set_default_keymaps()

		local flit = require("flit")
		flit.setup({})

		local spooky = require("leap-spooky")
		spooky.setup({})
	end,
}
