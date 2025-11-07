local function todo_comments(tag)
    return function()
        vim.api.nvim_feedkeys("gca", "m", false)
        vim.api.nvim_feedkeys(tag .. ": ", "n", false)
    end
end

---@diagnostic disable: missing-fields
return {
    "numToStr/Comment.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "JoosepAlviste/nvim-ts-context-commentstring",
    },
    event = "VeryLazy",
    config = function()
        require("Comment").setup({
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            extra = {
                eol = "gca",
            },
            mappings = { basic = true, extra = true },
        })
        -- stylua: ignore start
        vim.keymap.set("n", "gcc", "<Plug>(comment_toggle_linewise_current)",   { desc = "Comment toggle current line" })
        vim.keymap.set("n", "gcy", "yy<Plug>(comment_toggle_linewise_current)", { desc = "Yank & Comment toggle current line" })
        vim.keymap.set("x", "gc",  "<Plug>(comment_toggle_linewise_visual)",    { desc = "Comment toggle linewise" })
        vim.keymap.set("x", "gy",  "ygv<Plug>(comment_toggle_linewise_visual)", { desc = "Comment toggle linewise" })

        vim.keymap.set("n", "gct", todo_comments("TODO"),     { desc = "TODO" })
        vim.keymap.set("n", "gcb", todo_comments("BUG"),      { desc = "BUG" })
        vim.keymap.set("n", "gcf", todo_comments("FIXME"),    { desc = "FIXME" })
        vim.keymap.set("n", "gch", todo_comments("HACK"),     { desc = "HACK" })
        vim.keymap.set("n", "gcn", todo_comments("NOTE"),     { desc = "NOTE" })
        vim.keymap.set("n", "gcz", todo_comments("OPTIMIZE"), { desc = "Optimize" })
        -- stylua: ignore end
    end,
}
