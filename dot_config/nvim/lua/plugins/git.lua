return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "Goto next hunk" })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "Goto prev hunk" })

                -- Actions
                map({ "n", "v" }, "<leader>as", ":Gitsigns stage_hunk<CR>", { desc = "Git stage hunk" })
                map({ "n", "v" }, "<leader>ar", ":Gitsigns reset_hunk<CR>", { desc = "Git reset hunk" })
                map("n", "<leader>aS", gs.stage_buffer, { desc = "Git stage buffer" })
                map("n", "<leader>aR", gs.reset_buffer, { desc = "Git reset buffer" })
                map("n", "<leader>au", gs.undo_stage_hunk, { desc = "Git undo stage hunk" })
                map("n", "<leader>ap", gs.preview_hunk, { desc = "Git preview hunk" })
                map("n", "<leader>ab", function()
                    gs.blame_line({ full = true })
                end, { desc = "Git blame" })
                map("n", "<leader>aB", gs.toggle_current_line_blame, { desc = "Git blame toggle" })
                map("n", "<leader>ad", gs.diffthis, { desc = "Git diff" })
                map("n", "<leader>aD", function()
                    gs.diffthis("~")
                end, { desc = "Git diff" })
                map("n", "<leader>ax", gs.toggle_deleted, { desc = "Git toggle deleted" })
                -- Text object
                map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git select hunk" })
            end,
        },
    },
    {
        "tpope/vim-fugitive", -- git wrapper
        dependencies = {
            "junegunn/gv.vim", -- git commit browser
            "tpope/vim-rhubarb", -- fugitive extension for GitHub
        },
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>gv", ":GV<cr>", { desc = "Git Commit Browser" })
            vim.keymap.set("n", "<leader>gV", ":GV!<cr>", { desc = "Git BufCommit Browser" })
        end,
    },
}
