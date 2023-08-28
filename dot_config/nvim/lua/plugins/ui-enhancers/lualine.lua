return {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    -- enabled=false,
    event = "VeryLazy",
    config = function()
        local lualine = require("lualine")
        local utils = require("lualine.utils.mode")
        local nord = require("utils.nord")
        local nord_theme = require("lualine.themes.nord")
        nord_theme.normal.a.bg = nord.c09_glcr
        nord_theme.normal.b.bg = nord.c03_gry
        nord_theme.normal.b.fg = nord.c04_wht
        nord_theme.normal.c.bg = nord.c01_gry
        nord_theme.normal.c.fg = nord.c04_wht
        nord_theme.insert.a.bg = nord.c04_wht
        local function location() return ":%l/%L :%-2v" end
        local function mode() return " " .. utils.get_mode() end

        lualine.setup({
            options = {
                icons_enabled = true,
                theme = nord_theme,
                -- section_separators = { left = "", right = "" },
                -- component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" }, -- { left = "", right = "" },
                disabled_filetypes = {
                    -- statusline = { "NvimTree" },
                    winbar = {},
                },
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    -- tabline = 1000,
                    -- winbar = 1000,
                },
            },
            sections = {
                lualine_a = { mode },
                lualine_b = {
                    { "branch", icon = " ", separator = "" },
                    {
                        "diff",
                        -- symbols = { added = " ", modified = " ", removed = " " },
                        symbols = { added = " ", modified = " ", removed = " " },
                        padding = { left = 1, right = 1 },
                    },
                },
                lualine_c = {
                    { "filetype", icon_only = true, separator = "", padding = { left = 2, right = 1 } },
                    { "filename", path = 1 }, -- 1: rel, 2: abs, 3:abs(~), 4: filename
                    {
                        "diagnostics",
                        symbols = { error = " ", warn = " ", hint = " ", info = " " },
                    },
                },
                lualine_x = {
                    "filetype",
                    --[[ "encoding", "fileformat", ]]
                },
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
    end,
}
