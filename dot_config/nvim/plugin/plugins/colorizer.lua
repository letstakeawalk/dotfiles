vim.pack.add({ "gh:catgoose/nvim-colorizer.lua" })

require("colorizer").setup({
    options = {
        parsers = {
            names = { enable = false },
        },
    },
})
