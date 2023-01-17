-- TODO: config this
require("nvim-navic").setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "練",
		Interface = "練",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = "◩ ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		TypeParameter = " ",
	},
	highlight = true,
	separator = "  ",
	depth_limit = 0,
	depth_limit_indicator = "..",
	safe_output = true,
})

-- navic.setup {
--   icons = {
--     File = ' ',
--     Module = ' ',
--     Namespace = ' ',
--     Package = ' ',
--     Class = ' ',
--     Method = ' ',
--     Property = ' ',
--     Field = ' ',
--     Constructor = ' ',
--     Enum = ' ',
--     Interface = ' ',
--     Function = ' ',
--     Variable = ' ',
--     Constant = ' ',
--     String = ' ',
--     Number = ' ',
--     Boolean = ' ',
--     Array = ' ',
--     Object = ' ',
--     Key = ' ',
--     Null = ' ',
--     EnumMember = ' ',
--     Struct = ' ',
--     Event = ' ',
--     Operator = ' ',
--     TypeParameter = ' '
--   }
-- }

--
vim.o.winbar = "  %{%v:lua.require'nvim-navic'.get_location()%}"

local nord = require("HRB.nord")

-- vim.api.nvim_set_hl(0, "WinBar",                  { default = true, bg = nord.c01 })
vim.api.nvim_set_hl(0, "NavicIconsFile",          { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsModule",        { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsNamespace",     { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsPackage",       { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsClass",         { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsMethod",        { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsProperty",      { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsField",         { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsConstructor",   { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsEnum",          { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsInterface",     { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsFunction",      { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsVariable",      { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsConstant",      { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsString",        { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsNumber",        { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsBoolean",       { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsArray",         { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsObject",        { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsKey",           { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsNull",          { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsEnumMember",    { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsStruct",        { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsEvent",         { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsOperator",      { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, fg = nord.c04_dk01 })
vim.api.nvim_set_hl(0, "NavicText",               { default = true, fg = nord.c04 })
vim.api.nvim_set_hl(0, "NavicSeparator",          { default = true, fg = nord.c04 })
