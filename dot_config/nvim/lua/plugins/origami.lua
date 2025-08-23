return {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
        -- { "<Left>",  function() require("origami").h() end },
        -- { "<Right>", function() require("origami").l() end },
        { "j",       function() require("origami").h() end },
        { "l",       function() require("origami").l() end },
        { "$",       function() require("origami").dollar() end },
    },
    opts = {
        useLspFoldsWithTreesitterFallback = true,
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
        },
        autoFold = {
            enabled = true,
            kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
        },
        foldKeymaps = {
            setup = false, -- modifies `h`, `l`, and `$`
            hOnlyOpensOnFirstColumn = false,
        },
    },
}
