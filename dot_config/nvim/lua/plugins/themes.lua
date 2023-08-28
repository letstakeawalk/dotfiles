return {
    {
        "arcticicestudio/nord-vim",
        lazy = false,
        priority = 1000,
        enabled = false,
        config = function()
            vim.cmd.colorscheme("nord")
            vim.g.nord_cursor_line_number_background = 1
            vim.g.nord_uniform_diff_background = 1
            vim.g.nord_bold = 1
            vim.g.nord_italic = 1
            vim.g.nord_italic_comments = 1
            vim.g.nord_underline = 1
            require("config.highlights").apply_highlights()
        end,
    },
    {
        "shaunsingh/nord.nvim",
        lazy = false,
        priority = 1000,
        enabled = true,
        init = function()
            vim.g.nord_contrast = false -- def: false
            vim.g.nord_borders = true -- def: false
            vim.g.nord_disable_background = false -- def: false
            vim.g.norg_cursorline_transparent = false -- def: false
            vim.g.nord_enable_sidebar_background = false -- def: false
            vim.g.nord_uniform_diff_background = true -- def: false
            vim.g.nord_italic = true -- def: true
            vim.g.nord_bold = true -- def: true
            vim.cmd.colorscheme("nord")
            require("config.highlights").apply_highlights()
        end,
    },
}
