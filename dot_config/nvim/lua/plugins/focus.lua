return {
    "nvim-focus/focus.nvim",
    event = "VeryLazy",
    keys = { "<leader>df", "<cmd>FocusToggle<cr>", desc = "Focus Toggle" },
    opts = {
        ui = {
            signcolumn = false,
            cursorline = false,
        },
    },
}
