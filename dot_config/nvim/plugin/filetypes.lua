-- custom filetypes
vim.filetype.add({
    filename = {
        ["dot_zshrc"] = "zsh",
    },
    pattern = {
        [".*%.toml%.tmpl"] = "toml",
        [".*/git/config"] = "gitconfig",
        [".*/ghostty/config%.tmpl"] = "config",
        [".*/%.ssh/.*%.sshconfig"] = "sshconfig",
        [".*/git/ignore"] = "gitignore",
        -- ["%.env%..*"] = "sh",
    },
})
