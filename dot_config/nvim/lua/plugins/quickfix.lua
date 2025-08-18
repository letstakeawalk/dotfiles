return {
    {
        "kevinhwang91/nvim-bqf",
        ft = "qf",
        opts = {
            auto_resize_height = true,
            preview = {
                show_title = false,
                winblend = 0,
            },
        },
    },
    {
        "stevearc/quicker.nvim",
        ft = "qf",
        opts = {
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
        },
    },
}
