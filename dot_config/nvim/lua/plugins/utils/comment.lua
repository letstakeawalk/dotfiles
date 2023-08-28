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
}
