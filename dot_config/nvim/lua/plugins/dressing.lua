return {
    "stevearc/dressing.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "BufRead",
    opts = {
        input = {
            buf_options = {},
            win_options = { winblend = 0 },
            override = function(conf) -- conf: api.nvim_open_win() parameter
                if vim.startswith(conf.title, " Are you sure") then
                    return require("utils").ui.editor_center(conf)
                end
                conf.anchor = "NW"
                conf.row = 1
                return conf
            end,
            get_config = function(_) -- opts: ui.input() parameter
                local ignored = { "NvimTree" }
                local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
                if vim.tbl_contains(ignored, ft) then
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
