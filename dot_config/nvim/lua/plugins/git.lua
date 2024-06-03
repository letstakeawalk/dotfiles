return {
    {
        "bharam/fugitive-ext.nvim",
        dependencies = {
            "tpope/vim-fugitive", -- git interface
            "junegunn/gv.vim", -- git commit browser
            "tpope/vim-rhubarb", -- fugitive extension for GitHub
        },
        keys = {
            { "<leader>gg", "<cmd>vert Git<cr>", desc = "Fugitive" },
            { "<leader>gq", "<cmd>Git<cr><cmd>bd<cr>", desc = "Close Fugitive" },
            { "<leader>gc", "<cmd>GV<cr>", desc = "Commit Browser (GV)" },
            { "<leader>gC", "<cmd>GV!<cr>", desc = "BufCommit Browser (GV!)" },
        },
        opts = {
            _debug = false,
            fugitive = {
                line_number = false,
                relative_number = false,
            },
            hint = {
                title = true,
                visibility = false,
                -- stylua: ignore
                sections = {
                    {
                        title = "Navigation",
                        entries = {
                            { "gU",    "untracked" },
                            { "gu",    "unstaged" },
                            { "gs",    "staged" },
                            { "gp",    "unpushed" },
                            { "gP",    "unpulled" },
                            { "gr",    "rebasing" },
                            { "gi",    "exclude/ignore" },
                            { "gI",    "exclude/ignore++" },
                            { "i",     "expand next" },
                            { "(,)",   "goto prev/next" },
                            { "[[,]]", "prev/next section" },
                        },
                    },
                    {
                        title = "Stage/Stash",
                        entries = {
                            { "s",       "stage" },
                            { "u",       "unstage" },
                            { "-, a",    "stage/unstage" },
                            { "X",       "discard" },
                            { "=",       "inline diff" },
                            { "I",       "patch" },
                            { "coo",     "checkout" },
                            { "czz,czw", "push stash" },
                            { "czp",     "pop stash" },
                            { "cza",     "apply stash" },
                            { "cz<sp>",  ":Git stash" },
                        },
                    },
                    {
                        title = "Commit",
                        entries = {
                            { "cc",     "commit" },
                            { "ca",     "amend" },
                            { "ce",     "amend no-edit" },
                            { "cw",     "reword" },
                            { "cf, cF", "fixup!" },
                            { "cs, cS", "squash!" },
                            { "crc",    "revert commit" },
                            { "c<sp>",  ":Git commit" },
                            { "cr<sp>", ":Git revert" },
                            { "cm<cp>", ":Git merge" },
                            { "p",      ":Git push" },
                        },
                    },
                    {
                        title = "Rebase",
                        entries = {
                            { "ri",    "interactive" },
                            { "rr",    "continue" },
                            { "rs",    "skip commit" },
                            { "ra",    "abort" },
                            { "re",    "edit todo" },
                            { "rw",    "mark reword" },
                            { "rm",    "mark edit" },
                            { "rd",    "mark drop" },
                            { "r<sp>", ":Git rebase" },
                            { "P",     ":Git pull" },
                        },
                    },
                },
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "BufRead",
        opts = {
            on_attach = function(bufnr)
                -- local gs = package.loaded.gitsigns
                local gs = require("gitsigns")

                local function map(mode, lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                local next_hunk, prev_hunk =
                    require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
                        gs.next_hunk,
                        gs.prev_hunk
                    )
                map("n", "]c", function()
                    if vim.wo.diff then
                        return vim.cmd.normal({ "]c", bang = true })
                    end
                    vim.schedule(next_hunk)
                    return "<Ignore>"
                end, { desc = "Goto next hunk", expr = true, silent = true })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return vim.cmd.normal({ "[c", bang = true })
                    end
                    vim.schedule(prev_hunk)
                    return "<Ignore>"
                end, { desc = "Goto previous hunk", expr = true, silent = true })

                -- stylua: ignore start
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
                map("n", "<leader>gd", gs.diffthis, { desc = "Diff" })
                map("n", "<leader>gD", function() gs.diffthis("~") end, { desc = "Diff" })
                map("n", "<leader>gx", gs.toggle_deleted, { desc = "Toggle deleted" })

                -- Text object
                map({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
                map({ "o", "x" }, "ah", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
                -- stylua: ignore end
            end,
        },
    },
    {
        "ThePrimeagen/git-worktree.nvim",
        keys = {
            { "<leader>w", "<cmd>Telescope git_worktree git_worktrees<cr>", desc = "Git worktrees (Telescope)" },
            { "<leader>gW", "<cmd>Telescope git_worktree create_git_worktrees<cr>", desc = "Create worktree" },
        },
        opts = {
            change_directory_command = "cd", -- default: "cd",
            update_on_change = true, -- default: true,
            update_on_change_command = "e .", -- default: "e .",
            clearjumps_on_change = true, -- default: true,
            autopush = false, -- default: false,
        },
    },
}
