local function location()
	return ":%l/%L :%-2v"
end

local lualine = require("lualine")
local nord = require("HRB.nord")
local nord_theme = require("lualine.themes.nord")
nord_theme.normal.a.bg = nord.c09
nord_theme.normal.b.bg = nord.c03
nord_theme.normal.c.bg = nord.c01
nord_theme.normal.b.fg = nord.c04
nord_theme.normal.c.fg = nord.c04

lualine.setup({
	options = {
		icons_enabled = true,
		theme = nord_theme,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			-- statusline = { "NvimTree" },
			winbar = {},
		},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	-- sections = {
	-- 	lualine_a = { "mode" },
	-- 	lualine_b = { "branch", "diff", "diagnostics" },
	-- 	lualine_c = { { "filetype", icon_only = true, separator = "" }, {"filename", padding=0} },
	-- 	lualine_x = { "encoding", "fileformat", "filetype" },
	-- 	lualine_y = { "progress" },
	-- 	lualine_z = { location },
	-- },
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{ "branch", separator = "" },
			{
				"diff",
				-- symbols = { added = " ", modified = " ", removed = " " },
				padding = { left = 0, right = 1 },
			},
		},
		lualine_c = {
			{
				"diagnostics",
				symbols = { error = " ", warn = " ", hint = " ", info = " " },
			},
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			{ "filename", path = 1 },
      -- stylua: ignore
      -- {
      --   function() return require("nvim-navic").get_location() end,
      --   cond = function() return require("nvim-navic").is_available() end,
      -- },
		},
		lualine_x = { --[[ "encoding", "fileformat", ]] "filetype" },
		lualine_y = { "progress" },
		lualine_z = { location },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { location },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	-- winbar = {
	-- 	lualine_a = {},
	-- 	lualine_b = {},
	-- 	lualine_c = { "filename" },
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {},
	-- },
	--
	-- inactive_winbar = {
	-- 	lualine_a = {},
	-- 	lualine_b = {},
	-- 	lualine_c = { "filename" },
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {},
	-- },
	extensions = {},
})
