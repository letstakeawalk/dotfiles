-- vim.ui.[input,select] interface
return {
    "stevearc/dressing.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "BufRead",
    opts = {
        input = {
            override = function(conf)
                conf.anchor = "NW"
                conf.row = 1
                return conf
            end,
            buf_options = {},
            win_options = { winblend = 0 },
            get_config = function()
                local excluded_filetypes = { "NvimTree" }
                if vim.tbl_contains(excluded_filetypes, vim.api.nvim_get_option_value("filetype", { buf = 0 })) then
                    return { enabled = false }
                end
            end,
        },
        select = {
            enabled = true,
            trim_prompt = true,
            get_config = function(opts)
                local themes = require("telescope.themes")
                local conf = {
                    backend = "telescope",
                    telescope = themes.get_dropdown({ layout_config = { width = 80, height = 15 } }),
                    trim_prompt = true,
                }
                if opts.kind == "codeaction" then
                    conf.telescope = themes.get_cursor({ layout_config = { width = 80, height = 15 } })
                end
                return conf
            end,
        },
    },
}
