return {
    "kevinhwang91/nvim-ufo", -- pretty fold block
    dependencies = "kevinhwang91/promise-async",
    event = "BufRead", -- use verylazy if still buggy
    config = function()
        local ufo = require("ufo")

        ufo.setup({
            open_fold_hl_timeout = 0, -- default 400
            -- provider_selector = selector,
            ---@diagnostic disable-next-line: unused-local
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
            close_fold_kinds_for_ft = { "comment", "imports", "region" },
            -- fold_virt_text_handler = nil, -- default nil
            -- enable_get_fold_virt_text = false, -- default false
        })

        -- Using ufo provider need remap `zR` and `zM`
        local function max_foldlevel()
            local max_fold = 0
            for i = 1, vim.fn.line("$") do
                max_fold = math.max(max_fold, vim.fn.foldlevel(i))
            end
            return max_fold
        end

        ---@param level integer
        local function set_fold(level)
            level = math.max(level, 0)
            level = math.min(level, max_foldlevel())
            vim.w.ufo_level = level
            ufo.closeFoldsWith(level)
        end

        -- stylua: ignore start
        vim.keymap.set("n", "zR", function() set_fold(max_foldlevel()) end, { desc = "Open all Folds" })
        vim.keymap.set("n", "zM", function() set_fold(0) end, { desc = "Close all Folds" })
        vim.keymap.set("n", "zr", function() set_fold((vim.w.ufo_level or max_foldlevel()) + 1) end, { desc = "Open fold +1" })
        vim.keymap.set("n", "zm", function() set_fold((vim.w.ufo_level or max_foldlevel()) - 1) end, { desc = "Close fold -1" })
        vim.keymap.set("n", "zv", "zMzvzczO", { desc = "Open just enough folds" })
        vim.keymap.set("n", "z0", function() set_fold(0) end, { desc = "Fold level 0" })
        vim.keymap.set("n", "z1", function() set_fold(1) end, { desc = "Fold level 1" })
        vim.keymap.set("n", "z2", function() set_fold(2) end, { desc = "Fold level 2" })
        vim.keymap.set("n", "z3", function() set_fold(3) end, { desc = "Fold level 3" })
        vim.keymap.set("n", "z4", function() set_fold(4) end, { desc = "Fold level 4" })
        -- stylua: ignore end

        vim.api.nvim_create_autocmd("BufRead", {
            group = require("utils").create_augroup("UfoFold", {}),
            callback = function()
                set_fold(1)
            end,
        })
    end,
}
