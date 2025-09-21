return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        open_mapping = "<leader>dT",
        insert_mappings = false,
        hide_numbers = true,
        start_in_insert = true,
        auto_scroll = true,
        close_on_exit = true,
        direction = "horizontal", -- "vertical" | "horizontal" | "tab" | "float"
        shade_terminals = false,
        shade_filetypes = {},
        shading_factor = -30, -- default: -30 (percentage) (gets multiplied by -3 if background is light)
        size = function(term)
            if term.direction == "horizontal" then
                return math.floor(vim.o.lines * 0.4)
            else
                return math.floor(vim.o.columns * 0.4)
            end
        end,
        float_opts = {
            border = "rounded",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.85),
            winblend = 0,
            zindex = 50,
        },
        highlights = {},
        winbar = { enabled = false },
    },
}
