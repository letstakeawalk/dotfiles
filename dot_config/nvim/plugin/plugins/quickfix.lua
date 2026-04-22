vim.pack.add({
    "gh:kevinhwang91/nvim-bqf",
    "gh:stevearc/quicker.nvim",
})

---@diagnostic disable-next-line: missing-fields
require("bqf").setup({
    auto_resize_height = true,
    ---@diagnostic disable-next-line: missing-fields
    preview = {
        show_title = false,
        winblend = 0,
    },
})

require("quicker").setup({
    opts = {
        number = true,
    },
    borders = {
        vert = "  ",
        -- Strong headers separate results from different files
        strong_header = "─",
        strong_cross = "┼",
        strong_end = "┤",
        -- Soft headers separate results within the same file
        soft_header = "┈",
        soft_cross = "┼",
        soft_end = "┤",
        -- ╭╮╰╯│┌─┐├┼┬┴┤╱╲╳ ┄┆ ┈┊
    },
    type_icons = {
        E = "E",
        W = "W",
        I = "I ",
        N = "N",
        H = "H",
    },
})
