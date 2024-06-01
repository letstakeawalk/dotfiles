---@diagnostic disable: missing-fields
return {
    "numToStr/Comment.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = "BufRead",
    config = function()
        require("Comment").setup({
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            extra = {
                eol = "gca",
            },
        })
        -- stylua: ignore start
        vim.keymap.set("x", "gc",  "<Plug>(comment_toggle_linewise_visual)",    { desc = "Comment toggle linewise" })
        vim.keymap.set("n", "gcc", "<Plug>(comment_toggle_linewise_current)",   { desc = "Yank & Comment toggle current line" })
        vim.keymap.set("x", "gy",  "gv<Plug>(comment_toggle_linewise_visual)",  { desc = "Yank & Comment toggle linewise" })
        vim.keymap.set("n", "gcy", "yy<Plug>(comment_toggle_linewise_current)", { desc = "Comment toggle current line" })
        -- stylua: ignore end
        -- vim.keymap.set("x", "gc",  "<Plug>(YankyYank)|gv<Plug>(comment_toggle_linewise_visual)", { desc = "Comment toggle linewise" })
        -- vim.keymap.set("n", "gcc", "yy<Plug>(comment_toggle_linewise_current)", { desc = "Yank & Comment toggle current line" })
        -- vim.keymap.set("x", "gc", "<Plug>(YankyYank)|gv<Plug>(comment_toggle_linewise_visual)", { desc = "Yank & Comment toggle linewise" })
    end,
}
