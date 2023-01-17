-- https://github.com/nvim-neorg/neorg

require("neorg").setup({
	load = {
		-- https://github.com/nvim-neorg/neorg/wiki/#the-concept-of-modules
		["core.defaults"] = {},
		["core.norg.concealer"] = {},
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp",
			},
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					work = "~/Wordspace/notes/work",
					home = "~/Wordspace/notes/home",
				},
			},
		},
		--[[ ["core.gdt.base"] = {}, ]]
		--[[ ["core.integrations.nvim-cmp"] = {}, ]]
	},
})
