return {
    {
        dir = "$WORKSPACE/Dev/Projects/fugitive-ext.nvim",
        dependencies = {
            "tpope/vim-fugitive", -- git interface
            "junegunn/gv.vim", -- git commit browser
            "tpope/vim-rhubarb", -- fugitive extension for GitHub
        },
        -- stylua: ignore
        keys = {
            { "<leader>gg", "<cmd>vert Git<cr>",       desc = "Fugitive" },
            { "<leader>gq", "<cmd>Git<cr><cmd>bd<cr>", desc = "Close Fugitive" },
            { "<leader>gc", "<cmd>GV<cr>",             desc = "Commit Browser (GV)" },
            { "<leader>gC", "<cmd>GV!<cr>",            desc = "BufCommit Browser (GV!)" },
        },
        config = function()
            local fugitive_ext = require("fugitive-ext")
            fugitive_ext:setup({
                _debug = false,
                fugitive = {
                    line_number = false,
                    relative_number = false,
                },
                hint = {
                    title = true,
                    visibility = false,
                    sections = {
                        {
                            title = "Navigation",
                            entries = {
                                { "gu", "untracked" },
                                { "gU", "unstaged" },
                                { "gs", "staged" },
                                { "gp", "unpushed" },
                                { "gP", "unpulled" },
                                { "gr", "rebasing" },
                                { "gi", "exclude/ignore" },
                                { "gI", "exclude/ignore++" },
                                { "i", "expand next" },
                                { "(, )", "goto prev/next" },
                                { "[[, ]]", "prev/next section" },
                            },
                        },
                        {
                            title = "Stage/Stash",
                            entries = {
                                { "s", "stage" },
                                { "u", "unstage" },
                                { "-, a", "stage/unstage" },
                                { "X", "discard" },
                                { "=", "inline diff" },
                                { "I", "patch" },
                                { "coo", "checkout" },
                                { "czz, czw", "push stash" },
                                { "czp", "pop stash" },
                                { "cza", "apply stash" },
                                { "cz<sp>", ":Git stash" },
                            },
                        },
                        {
                            title = "Commit",
                            entries = {
                                { "cc", "commit" },
                                { "ca", "amend" },
                                { "ce", "amend no-edit" },
                                { "cw", "reword" },
                                { "cf, cF", "fixup!" },
                                { "cs, cS", "squash!" },
                                { "crc", "revert commit" },
                                { "c<sp>", ":Git commit" },
                                { "cr<sp>", ":Git revert" },
                                { "cm<cp>", ":Git merge" },
                                { "p", ":Git push" },
                            },
                        },
                        {
                            title = "Rebase",
                            entries = {
                                { "ri", "interactive" },
                                { "rr", "continue" },
                                { "rs", "skip commit" },
                                { "ra", "abort" },
                                { "re", "edit todo" },
                                { "rw", "mark reword" },
                                { "rm", "mark edit" },
                                { "rd", "mark drop" },
                                { "r<sp>", ":Git rebase" },
                                { "P", ":Git pull" },
                            },
                        },
                    },
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("FugitiveExtKeymap", { clear = true }),
                pattern = "fugitive",
                callback = function()
                    -- stylua: ignore start
                    local actions = require("fugitive-ext.actions")
                    vim.keymap.set("n", "p",  actions.push_cmdline,              { desc = ":Git push",       buffer = true })
                    vim.keymap.set("n", "P",  actions.pull_cmdline,              { desc = ":Git pull",       buffer = true })
                    vim.keymap.set("n", "X",  actions.discard_confirm,           { desc = "Discard changes", buffer = true })
                    vim.keymap.set("n", "gu", actions.goto_unstaged,             { desc = "Goto unstaged",   buffer = true })
                    vim.keymap.set("n", "gU", actions.goto_untracked,            { desc = "Goto untracked",  buffer = true })
                    vim.keymap.set("n", "h",  actions.goto_prev_hunk,            { desc = "Prev hunk",       buffer = true })
                    vim.keymap.set("n", "k",  actions.goto_next_hunk,            { desc = "Next hunk",       buffer = true })
                    vim.keymap.set("n", "(",  actions.collapse_curr_expand_prev, { desc = "Previous hunk",   buffer = true })
                    vim.keymap.set("n", ")",  actions.collapse_curr_expand_next, { desc = "Next hunk",       buffer = true })
                    -- stylua: ignore end
                end,
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
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
                end, { desc = "Goto next hunk", expr = true, silent = true })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(prev_hunk)
                    return "<Ignore>"
                end, { desc = "Goto prev hunk", expr = true, silent = true })

                -- Actions
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
                -- map("n", "<leader>gd", gs.diffthis, { desc = "Diff" })
                -- map("n", "<leader>gD", function() gs.diffthis("~") end, { desc = "Diff" })
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
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "DiffView" },
        },
        config = function()
            local actions = require("diffview.actions")
            require("diffview").setup({
                hooks = {},
                keymaps = {
                    disable_defaults = false, -- Disable the default keymaps
                    file_panel = {
                        { "n", "k", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
                        { "n", "h", actions.prev_entry, { desc = "Bring the cursor to the previous file entry" } },
                        { "n", "l", actions.select_entry, { desc = "Open the diff for the selected entry" } },
                        { "n", "j", actions.close_fold, { desc = "Collapse fold" } },
                        { "n", "<c-u>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
                        { "n", "<c-d>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
                    },
                    file_history_panel = {
                        { "n", "j", nil },
                        { "n", "k", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
                        { "n", "h", actions.prev_entry, { desc = "Bring the cursor to the previous file entry." } },
                        { "n", "<c-u>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
                        { "n", "<c-d>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
                    },
                },
            })
        end,
    },
}
