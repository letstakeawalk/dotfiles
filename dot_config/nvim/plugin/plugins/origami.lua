vim.pack.add({ "gh:chrisgrieser/nvim-origami" })

local origami = require("origami")
origami.setup({
    useLspFoldsWithTreesitterFallback = { enabled = true },
    pauseFoldsOnSearch = true,
    foldtext = {
        enabled = true,
        padding = { width = 3 },
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
        kinds = { "comment" }, ---@type lsp.FoldingRangeKind[]
        -- kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
    },
    foldKeymaps = {
        setup = false, -- modifies `h`, `l`, and `$`
        hOnlyOpensOnFirstColumn = false,
        scrollLeftOnCaret = false,
    },
})

local set = require("utils.keymap").set
set("n", "j", origami.h)
set("n", "l", origami.l)
set("n", "$", origami.dollar)
