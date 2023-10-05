return {
    "kevinhwang91/nvim-ufo", -- pretty fold block
    dependencies = "kevinhwang91/promise-async",
    event = "BufRead", -- use verylazy if still buggy
    config = function()
        local ufo = require("ufo")
        local ft_provider = { norg = { "treesitter", "indent" } }
        ufo.setup({
            open_fold_hl_timeout = 0, -- default 400
            provider_selector = function(_, ft)
                -- return ft_provider[ft] or { "lsp", "indent" }
                return ft_provider[ft] or { "treesitter", "indent" }
            end,
            close_fold_kinds = { "comment", "imports", "region" },
            -- fold_virt_text_handler = nil, -- default nil
            -- enable_get_fold_virt_text = false, -- default false
        })

        -- Using ufo provider need remap `zR` and `zM`
        local max_foldlevel = function()
            local max_fold = 0
            for i = 1, vim.fn.line("$") do
                max_fold = math.max(max_fold, vim.fn.foldlevel(i))
            end
            return max_fold
        end
        vim.keymap.set("n", "zR", function()
            vim.w.ufo_level = max_foldlevel()
            ufo.openAllFolds()
        end, { desc = "Open All Folds" })
        vim.keymap.set("n", "zM", function()
            vim.w.ufo_level = 0
            ufo.closeAllFolds()
        end, { desc = "Close All Folds" })
        vim.keymap.set("n", "zr", function()
            local max_level = max_foldlevel()
            local curr_level = vim.w.ufo_level and vim.w.ufo_level or max_level
            vim.w.ufo_level = math.min(curr_level + 1, max_level)
            ufo.closeFoldsWith(vim.w.ufo_level)
        end, { desc = "Open Fold One Level" })
        vim.keymap.set("n", "zm", function()
            local curr_level = vim.w.ufo_level and vim.w.ufo_level or max_foldlevel()
            vim.w.ufo_level = math.max(curr_level - 1, 0)
            ufo.closeFoldsWith(vim.w.ufo_level)
        end, { desc = "Close Fold One Level" })
        vim.keymap.set("n", "zv", "zvzczO", { desc = "Open just enough folds" })
        vim.keymap.set("n", "z0", function()
            vim.w.ufo_level = 0
            ufo.closeAllFolds()
        end, { desc = "Fold level 0" })
        vim.keymap.set("n", "z1", function()
            vim.w.ufo_level = 1
            ufo.closeFoldsWith(1)
        end, { desc = "Fold level 1" })
        vim.keymap.set("n", "z2", function()
            vim.w.ufo_level = 2
            ufo.closeFoldsWith(2)
        end, { desc = "Fold level 2" })
        vim.keymap.set("n", "z3", function()
            vim.w.ufo_level = 3
            ufo.closeFoldsWith(3)
        end, { desc = "Fold level 3" })
        vim.keymap.set("n", "z4", function()
            vim.w.ufo_level = 4
            ufo.closeFoldsWith(4)
        end, { desc = "Fold level 4" })

        -- hi default link UfoPreviewSbar PmenuSbar
        -- hi default link UfoPreviewThumb PmenuThumb
        -- hi default link UfoPreviewWinBar UfoFoldedBg
        -- hi default link UfoPreviewCursorLine Visual
        -- hi default link UfoFoldedEllipsis Comment
        -- hi default link UfoCursorFoldedLine CursorLine

        -- TODO: autocmd bufread close all folds on selected fts
    end,
}
