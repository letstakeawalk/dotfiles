return {
    "gbprod/yanky.nvim",
    event = "BufRead",
    -- stylua: ignore
    keys = {
        { "y", "<Plug>(YankyYank)",               { "n", "x" }, desc = "Yank" },
        { "p", "<Plug>(YankyPutAfter)",           { "n", "x" }, desc = "Paste After" },
        { "P", "<Plug>(YankyPutBefore)",          { "n", "x" }, desc = "Paste Before" },
        { "gp", "<Plug>(YankyGPutAfter)",         { "n", "x" }, desc = "Paste After" },
        { "gP", "<Plug>(YankyGPutBefore)",        { "n", "x" }, desc = "Paste Before" },
        { "]p", "<Plug>(YankyPutAfterLinewise)",  { "n", "x" }, desc = "Paste Below" },
        { "[p", "<Plug>(YankyPutBeforeLinewise)", { "n", "x" }, desc = "Paste Above" },
    },
    opts = {
        ring = {
            history_length = 10,
        },
        highlight = {
            on_put = false,
            on_yank = false,
        },
    },
    preserve_cursor_position = {
        enabled = false,
    },
}
