return {
    "utilyre/sentiment.nvim",
    event = "BufRead",
    init = function() vim.g.loaded_matchparen = 1 end,
    opts = {
        ---@type { [1]:string, [2]:string }[]
        pairs = {
            { "(", ")" },
            { "[", "]" },
            { "{", "}" },
        },
    },
}
