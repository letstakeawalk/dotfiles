return {
    "gbprod/yanky.nvim",
    event = "BufReadPost",
    config = function()
        require("yanky").setup({
            ring = {
                history_length = 3,
                sync_with_numbered_register = true,
            },
            highlight = {
                on_put = false,
                on_yank = false,
            },
        })
        vim.keymap.set({ "n", "x" }, "y", "<Plug>(YankyYank)", { desc = "Yank" })

        vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)", { desc = "Put After" })
        vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)", { desc = "Put Before" })
        vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)", { desc = "gPut After" })
        vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)", { desc = "gPut Before" })

        vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "Put Indent After Linewise" })
        vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "Put Indent Before Linewise" })
        vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)", { desc = "Put Indent After Linewise" })
        vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)", { desc = "Put Indent Before Linewise" })

        vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)", { desc = "Put Indent After Shift Right" })
        vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", { desc = "Put Indent After Shift Left" })
        vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", { desc = "Put Indent Before Shift Right" })
        vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", { desc = "Put Indent Before Shift Left" })

        vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)", { desc = "Put After Filter" })
        vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)", { desc = "Put Before Filter" })

        vim.keymap.set("n", "<S-right>", "<Plug>(YankyCycleForward)", { desc = "Yanky Cycle Forward" })
        vim.keymap.set("n", "<S-left>", "<Plug>(YankyCycleBackward)", { desc = "Yanky Cycle Backward" })
    end,
}
