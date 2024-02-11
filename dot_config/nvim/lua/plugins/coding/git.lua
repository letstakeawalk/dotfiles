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
                map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
                map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
                map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
                map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
                map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
                map("n", "<leader>ga", gs.stage_buffer, { desc = "Stage buffer" })
                map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
                map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
                map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
                map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Blame toggle" })
                -- map("n", "<leader>gd", gs.diffthis, { desc = "Diff" })
                -- map("n", "<leader>gD", function() gs.diffthis("~") end, { desc = "Diff" })
                map("n", "<leader>gx", gs.toggle_deleted, { desc = "Toggle deleted" })

                -- Text object
                map({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
                map({ "o", "x" }, "ah", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
            end,
        },
    },
    {
        "ThePrimeagen/git-worktree.nvim",
        event = "BufRead",
        keys = {
            { "<leader>w", "<cmd>Telescope git_worktree git_worktrees<cr>", desc = "Git worktrees (Telescope)" },
            { "<leader>gW", "<cmd>Telescope git_worktree create_git_worktrees<cr>", desc = "Create worktree" },
        },
        config = function()
            -- stylua: ignore
            require("git-worktree").setup({
                change_directory_command = "cd",  -- default: "cd",
                update_on_change         = true,  -- default: true,
                update_on_change_command = "e .", -- default: "e .",
                clearjumps_on_change     = true,  -- default: true,
                autopush                 = false, -- default: false,
            })
        end,
    },
    {
        "tpope/vim-fugitive", -- git wrapper
        event = "BufRead",
        dependencies = {
            "junegunn/gv.vim", -- git commit browser
            "tpope/vim-rhubarb", -- fugitive extension for GitHub
        },
        keys = {
            { "<leader>gg", "<cmd>Git<cr>", desc = "Fugitive" },
            { "<leader>gq", "<cmd>Git<cr><cmd>bd<cr>", desc = "Close Fugitive" },
            { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Diff split" },
            { "<leader>gc", "<cmd>GV<cr>", desc = "Commit Browser (GV)" },
            { "<leader>gC", "<cmd>GV!<cr>", desc = "BufCommit Browser (GV!)" },
        },
    },
}
