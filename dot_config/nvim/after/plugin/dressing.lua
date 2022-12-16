local dressing = require("dressing")
local themes = require("telescope.themes")
dressing.setup({
	input = {
		override = function(conf)
			conf.anchor = "NW"
			conf.row = 1
			return conf
		end,
		buf_options = {},
		win_options = {
			winblend = 0, -- window transparency
		},
		get_config = function()
			if vim.api.nvim_buf_get_option(0, "filetype") == "NvimTree" then
				return { enabled = false }
			end
		end,
	},
	select = {
		enabled = true,
		backend = { "telescope" },
		-- telescope = themes.get_dropdown({
		--   layout_config = {
		--     anchor = "N",
		--   }
		-- })
		telescope = themes.get_cursor({
			layout_config = {
				width = 80,
			},
		}),
		trim_prompt = true,
		-- get_config = function(opts)
		--   vim.pretty_print(opts)
		-- end
	},
})
