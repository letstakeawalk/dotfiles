-- smart commenting
return {
    "numToStr/Comment.nvim",
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
    opts = {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        extra = {
            eol = "gca",
        },
    },
    config = function(_, opts)
        require("Comment").setup(opts)
        vim.keymap.set("n", "gcc", "yy<Plug>(comment_toggle_linewise_current)", { desc = "Yank & Comment toggle current line" })
        vim.keymap.set("x", "gc", "<Plug>(YankyYank)|gv<Plug>(comment_toggle_linewise_visual)", { desc = "Yank & Comment toggle linewise" })
    end,
}
