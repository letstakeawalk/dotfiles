return {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
        { "j", function() require("origami").h() end },
        { "l", function() require("origami").l() end },
        { "$", function() require("origami").dollar() end },
    },
    opts = {
        useLspFoldsWithTreesitterFallback = {
            enabled = true,
        },
        pauseFoldsOnSearch = true,
        foldtext = {
            enabled = true,
            padding = 3,
            lineCount = {
                template = "%d lines", -- `%d` is replaced with the number of folded lines
                hlgroup = "Comment",
            },
            diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
            gitsignsCount = true, -- requires `gitsigns.nvim`
            disableOnFt = {
                "fugitive",
                "TelescopeResults",
            },
        },
        autoFold = {
            enabled = true,
            kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
        },
        foldKeymaps = {
            setup = false, -- modifies `h`, `l`, and `$`
            hOnlyOpensOnFirstColumn = false,
            scrollLeftOnCaret = false,
        },
    },
}
