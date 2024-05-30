return {
    "RRethy/vim-illuminate",
    event = "LspAttach",
    config = function()
        require("illuminate").configure({
            providers = { "lsp", "treesitter" },
            delay = 500,
            min_count_to_highlight = 2,
        })
    end,
}
