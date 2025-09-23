return {
    "gbprod/yanky.nvim",
    -- stylua: ignore
    keys = {
        { "y", "<Plug>(YankyYank)",                     desc = "Yank",         mode = { "n", "x" } },
        { "p", "<Plug>(YankyPutAfter)",                 desc = "Paste After",  mode = { "n" } },
        { "P", "<Plug>(YankyPutBefore)",                desc = "Paste Before", mode = { "n", "x" } },
        { "gp", "<Plug>(YankyGPutAfter)",               desc = "Paste After",  mode = { "n", "x" } },
        { "gP", "<Plug>(YankyGPutBefore)",              desc = "Paste Before", mode = { "n", "x" } },
        { "]p", "<Plug>(YankyPutIndentAfterLinewise)",  desc = "Paste Below",  mode = { "n", "x" } },
        { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Paste Above",  mode = { "n", "x" } },
    },
    opts = {
        ring = {
            history_length = 10,
        },
        highlight = {
            on_put = false,
            on_yank = false,
        },
        preserve_cursor_position = {
            enabled = false,
        },
    },
}
