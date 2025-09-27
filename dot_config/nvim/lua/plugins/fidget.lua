return {
    "j-hui/fidget.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
        progress = {
            display = {
                done_icon = "✔ ",
                done_style = "Type",
                icon_style = "Comment",
            },
        },
        notification = {
            override_vim_notify = true,
            window = { winblend = 0, border = "single", x_padding = 0 },
        },
    },
}
