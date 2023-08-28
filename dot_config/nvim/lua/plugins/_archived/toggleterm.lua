return {
    "akinsho/toggleterm.nvim",
    tag = "*",
    event = "VeryLazy",
    enabled = false,
    keys = {
        { "<leader>zv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal" },
        { "<leader>zx", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal" },
        { "<leader>zn", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal Float" },
        { "<leader>ze", "<cmd>2ToggleTerm direction=float<cr>", desc = "Terminal Float" },
        { "<leader>za", "<cmd>ToggleTermToggleAll<cr>", desc = "Terminal Toggle All" },
        { "<leader>zs", "<cmd>TermSelect<cr>", desc = "Select Terminal" },
    },
    opts = {
        open_mapping = "<leader>zz",
        insert_mapping = false,
        hide_numbers = true,
        start_in_insert = true,
        auto_scroll = true,
        close_on_exit = true,
        direction = "float", -- "vertical" | "horizontal" | "tab" | "float"
        shade_terminals = true,
        shade_filetypes = {},
        shading_factor = -30, -- default: -30 (percentage) (gets multiplied by -3 if background is light)
        size = function(term) return term.direction == "horizontal" and 30 or math.floor(vim.o.columns * 0.4) end,
        float_opts = {
            border = "single",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.85),
            winblend = 0,
            zindex = 50,
        },
        highlights = {
            Normal = { guibg = require("utils.nord").bg },
            NormalFloat = { guifg = require("utils.nord").fg, guibg = require("utils.nord").bg },
            FloatBorder = { link = "FloatBorder" },
        },
        winbar = { enabled = false },
    },
    init = function()
        vim.api.nvim_set_hl(0, "ToggleTerm1FloatBorder", { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "ToggleTerm1NormalBorder", { link = "FloatBorder" })
    end,
}
