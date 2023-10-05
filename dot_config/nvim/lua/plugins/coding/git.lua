return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufRead",
        init = function()
            local nord = require("utils.nord")
            vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = nord.c14_grn }) -- diff mode: Added line |diff.txt|
            vim.api.nvim_set_hl(0, "GitSignsAddNr", { fg = nord.c14_grn }) -- diff mode: Added line |diff.txt|
            vim.api.nvim_set_hl(0, "GitSignsAddLn", { fg = nord.c14_grn }) -- diff mode: Added line |diff.txt|
            vim.api.nvim_set_hl(0, "GitSignsChange", { fg = nord.c13_ylw }) -- diff mode: Changed line |diff.txt|
            vim.api.nvim_set_hl(0, "GitSignsChangeNr", { fg = nord.c13_ylw }) -- diff mode: Changed line |diff.txt|
            vim.api.nvim_set_hl(0, "GitSignsChangeLn", { fg = nord.c13_ylw }) -- diff mode: Changed line |diff.txt|
            vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = nord.c11_red }) -- diff mode: Deleted line |diff.txt|
            vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { fg = nord.c11_red }) -- diff mode: Deleted line |diff.txt|
            vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { fg = nord.c11_red }) -- diff mode: Deleted line |diff.txt|
            vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = nord.c03_gry_br })
        end,
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                local next_hunk, prev_hunk =
                    require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(gs.next_hunk, gs.prev_hunk)
                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(next_hunk)
                    return "<Ignore>"
                end, { expr = true, desc = "Goto next hunk" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(prev_hunk)
                    return "<Ignore>"
                end, { expr = true, desc = "Goto prev hunk" })

                -- Actions
                map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git stage hunk" })
                map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Git reset hunk" })
                map("n", "<leader>gs", gs.stage_hunk, { desc = "Git stage hunk" })
                map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Git undo stage hunk" })
                map("n", "<leader>gr", gs.reset_hunk, { desc = "Git reset hunk" })
                map("n", "<leader>ga", gs.stage_buffer, { desc = "Git stage buffer" })
                map("n", "<leader>gR", gs.reset_buffer, { desc = "Git reset buffer" })
                map("n", "<leader>gp", gs.preview_hunk, { desc = "Git preview hunk" })
                map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Git blame" })
                map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Git blame toggle" })
                -- map("n", "<leader>gd", gs.diffthis, { desc = "Git diff" })
                -- map("n", "<leader>gD", function() gs.diffthis("~") end, { desc = "Git diff" })
                map("n", "<leader>gx", gs.toggle_deleted, { desc = "Git toggle deleted" })

                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git select hunk" })
                map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git select hunk" })
            end,
        },
    },
    {
        "tpope/vim-fugitive", -- git wrapper
        dependencies = {
            "junegunn/gv.vim", -- git commit browser
            "tpope/vim-rhubarb", -- fugitive extension for GitHub
        },
        keys = {
            { "<leader>gg", "<cmd>Git<cr>", desc = "Git status (fugitive)" },
            { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git diff" },
            { "<leader>gc", "<cmd>GV<cr>", desc = "Git Commit Browser (GV)" },
            { "<leader>gC", "<cmd>GV!<cr>", desc = "Git BufCommit Browser (GV!)" },
        },
    },
}
