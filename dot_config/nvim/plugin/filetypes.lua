-- custom filetypes
vim.filetype.add({
    filename = {
        ["dot_zshrc"] = "zsh",
    },
    pattern = {
        [".*%.toml%.tmpl"] = "toml",
        [".*/git/config"] = "gitconfig",
        [".*/ghostty/config.*"] = "config",
        -- ["%.env%..*"] = "sh",
    },
})

