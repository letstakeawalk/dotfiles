return {
    "kevinhwang91/nvim-ufo", -- pretty fold block
    dependencies = "kevinhwang91/promise-async",
    event = "VeryLazy",
    config = function()
        local ufo = require("ufo")
        ufo.setup({
            open_fold_hl_timeout = 0,
        })
        -- Using ufo provider need remap `zR` and `zM`
        vim.keymap.set("n", "zR", ufo.openAllFolds)
        vim.keymap.set("n", "zM", ufo.closeAllFolds)
        vim.keymap.set("n", "zr", function()
            ufo.closeFoldsWith(1)
        end)
        vim.keymap.set("n", "zm", function()
            ufo.closeFoldsWith(0)
        end)

        -- vim.keymap.set('n', 'zm', ufo.closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

        -- vim.keymap.set('n', 'zr', function()
        --   local buf_foldlevel = vim.b.buf_foldlevel or 0
        --   ufo.closeFoldsWith(buf_foldlevel - 1)
        -- end)

        -- TODO
        -- vim.fn.foldlevel() -- use this to mimic zR zM etc
        -- https://github.com/kevinhwang91/nvim-ufo/issues/42
    end,
}
