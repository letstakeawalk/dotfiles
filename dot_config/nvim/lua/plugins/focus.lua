return {
    "nvim-focus/focus.nvim",
    event = "VeryLazy",
    keys = { { "<leader>df", "<cmd>FocusToggle<cr>", desc = "Focus Toggle" } },
    opts = {
        ui = {
            signcolumn = false,
            cursorline = false,
        },
        autoresize = {
            height_quickfix = 10, -- Set the height of quickfix panel
        },
    },
}
