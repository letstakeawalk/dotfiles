-- vim.ui.[input,select] interface
return {
    "stevearc/dressing.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
        local dressing = require("dressing")
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
                    local excluded_filetypes = { "NvimTree", "norg" }
                    if vim.tbl_contains(excluded_filetypes, vim.api.nvim_buf_get_option(0, "filetype")) then
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
                telescope = require("telescope.themes").get_cursor({
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
    end,
}
