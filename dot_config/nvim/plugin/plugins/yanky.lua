vim.pack.add({
    "gh:gbprod/yanky.nvim",
    "gh:nvim-telescope/telescope.nvim",
})

require("yanky").setup({
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
})
require("telescope").load_extension("yank_history")

local set = require("utils.keymap").set
set("nx", "y", "<Plug>(YankyYank)", { desc = "Yank" })
set("n", "p", "<Plug>(YankyPutAfter)", { desc = "Paste After" })
set("nx", "P", "<Plug>(YankyPutBefore)", { desc = "Paste Before" })
set("nx", "gp", "<Plug>(YankyGPutAfter)", { desc = "Paste After" })
set("nx", "gP", "<Plug>(YankyGPutBefore)", { desc = "Paste Before" })
set("nx", "]p", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "Paste Below" })
set("nx", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "Paste Above" })
