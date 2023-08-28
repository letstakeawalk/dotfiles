return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        local nord = require("utils.nord")

        local hl = {
            fill = nord.c00_blk_dk,
            tab_bg = nord.c00_dk1,
            tab_sel_bg = nord.c00_blk,
            indicator = nord.c09_glcr,
        }

        local highlight = {
            fill = { bg = hl.fill }, -- background
            offset_separator = { bg = hl.fill }, -- offset separator
            -- inactive tab
            background = { bg = hl.tab_bg },
            separator = { bg = hl.tab_bg, fg = hl.fill }, -- inactive tab separator
            close_button = { bg = hl.tab_bg },
            diagnostic = { bg = hl.tab_bg },
            hint = { bg = hl.tab_bg },
            info = { bg = hl.tab_bg },
            warning = { bg = hl.tab_bg },
            error = { bg = hl.tab_bg },
            modified = { bg = hl.tab_bg },
            duplicate = { bg = hl.tab_bg },
            -- active tab
            buffer_selected = { bg = hl.tab_sel_bg, italic = false }, -- active tab
            indicator_selected = { fg = hl.indicator }, -- does not work for some reason
            separator_selected = { bg = hl.tab_sel_bg, fg = hl.fill },
            diagnostic_selected = { bg = hl.tab_sel_bg },
            hint_selected = { bg = hl.tab_sel_bg, italic = false },
            info_selected = { bg = hl.tab_sel_bg, italic = false },
            warning_selected = { bg = hl.tab_sel_bg, italic = false },
            error_selected = { bg = hl.tab_sel_bg, italic = false },
            modified_selected = { bg = hl.tab_sel_bg },
            duplicate_selected = { bg = hl.tab_sel_bg },
            -- active tab visible
            buffer_visible = { bg = hl.tab_sel_bg }, -- active visible tab
            separator_visible = { bg = hl.tab_sel_bg, fg = hl.fill }, -- active visible tab separator
            close_button_visible = { bg = hl.tab_sel_bg },
            diagnostic_visible = { bg = hl.tab_sel_bg },
            hint_visible = { bg = hl.tab_sel_bg },
            info_visible = { bg = hl.tab_sel_bg },
            warning_visible = { bg = hl.tab_sel_bg },
            error_visible = { bg = hl.tab_sel_bg },
            modified_visible = { bg = hl.tab_sel_bg },
            duplicate_visible = { bg = hl.tab_sel_bg },

            -- diag
        }

        require("bufferline").setup({
            options = {
                -- :h bufferline-configuration
                diagnostics = "nvim_lsp",
                show_buffer_close_icons = true,
                show_close_icon = false,
                separator_style = "thick",
                -- indicator = { style = 'underline' },
                offsets = {
                    {
                        filetype = "NvimTree",
                        -- text = "File Explorer",
                        text_align = "left",
                        separator = true,
                    },
                },
            },
            highlights = highlight,
            -- regular separator config
            -- https://github.com/ratheesh/dot-nvim/blob/main/nvim/nvim/lua/plugins/bufferline.lua
            -- highlights = {
            --   fill = { bg = nord.c00_dk0 }, -- background
            --   -- background = { fg = nord.c11, bg = nord.c14 }, -- inactive tab background
            --   -- close_button = { bg = nord.c14 },
            --   -- tab = { fg = nord.c15, bg = nord.c07 }, -- inactive tab font area
            --   -- tab_selected = { fg = nord.c08, bg = nord.c15 }, -- active tab font area
            --   -- tab_close = { fg = nord.c04, bg = nord.c05 }, --
            --   -- duplicate = { fg = nord.c12, bg = nord.c14 },
            --   -- separator = { fg = nord.c00_dk0, bg = nord.c00_dk1 }, -- inactive tab separator
            --   separator_selected = { fg = nord.c00_dk0, bg = nord.c00 }, -- active tab separator
            --   separator_visible = { fg = nord.c00_dk0, bg = nord.c00_dk1 }, -- active visible tab separator
            --   offset_separator = { bg = nord.c00 }, -- offset separator
            --   indicator_selected = { fg = nord.c10, bg = nord.c00, sp = nord.c11, underline = true, underdouble = true }, -- active indicator
            --   buffer_selected = { bg = nord.c00, italic = false }, -- active tab
            --   buffer_visible = { bg = nord.c00_dk1 }, -- active visible tab
            --   hint_selected = { italic = false },
            --   info_selected = { italic = false },
            --   warning_selected = { italic = false },
            --   -- warning = { bg = nord.c14 },
            --   error_selected = { italic = false },
            -- }
            -- slant separator config
        })

        -- TODO: groups

        -- FIXME: indicator does not work
        -- bufferline.config.derive_colors
        -- https://github.com/akinsho/bufferline.nvim/issues/617
        -- https://github.com/ratheesh/dot-nvim/blob/main/nvim/nvim/lua/plugins/bufferline.lua
    end,
}
