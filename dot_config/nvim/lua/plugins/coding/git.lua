return {
    {
        "bharam/fugitive-ext.nvim",
        -- dir = "$WORKSPACE/Dev/Projects/fugitive-ext.nvim",
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
        commit = "d96ef3bbff0bdbc3916a220f5c74a04c4db033f2",
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
            {
                "<leader>gd",
                function()
                    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                        if vim.api.nvim_get_option_value("filetype", { buf = buf }) == "DiffViewFiles" then
                            return vim.cmd("DiffviewClose")
                        end
                    end
                    -- return require("diffview.config").actions.open_in_diffview()
                    return vim.cmd("DiffviewOpen")
                end,
                desc = "DiffView open",
            },
            -- { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "DiffView close" },
        },
        -- DiffviewFiles
        cmd = { "DiffviewOpen", "DiffviewClose" },
        config = function()
            local actions = require("diffview.actions")
            require("diffview").setup({
                diff_binaries = false, -- Show diffs for binaries
                enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
                git_cmd = { "git" }, -- The git executable followed by default args.
                hg_cmd = { "hg" }, -- The hg executable followed by default args.
                use_icons = true, -- Requires nvim-web-devicons
                show_help_hints = true, -- Show hints for how to open the help panel
                watch_index = true, -- Update views and index buffers when the git index changes.
                icons = { -- Only applies when use_icons is true.
                    folder_closed = "",
                    folder_open = "",
                },
                signs = {
                    fold_closed = "",
                    fold_open = "",
                    done = "✓",
                },
                view = {
                    default = { layout = "diff2_horizontal", winbar_info = true },
                    merge_tool = { layout = "diff3_mixed", winbar_info = true },
                    file_hitory_view = { layout = "diff2_horizontal", winbar_info = true },
                },
                hooks = {},
                keymaps = {
                    disable_defaults = true, -- Disable the default keymaps

                    -- stylua: ignore start
                    view = {
                        -- The `view` bindings are active in the diff buffers, only when the current
                        -- tabpage is a Diffview.
                        { "n", "<tab>",         actions.select_next_entry,             { desc = "Open the diff for the next file" } },
                        { "n", "<s-tab>",       actions.select_prev_entry,             { desc = "Open the diff for the previous file" } },
                        { "n", "gf",            actions.goto_file_edit,                { desc = "Open the file in the previous tabpage" } },
                        { "n", "<C-w><C-f>",    actions.goto_file_split,               { desc = "Open the file in a new split" } },
                        { "n", "<C-w>gf",       actions.goto_file_tab,                 { desc = "Open the file in a new tabpage" } },
                        { "n", "<leader>E",     actions.focus_files,                   { desc = "Bring focus to the file panel" } },
                        { "n", "<leader>e",     actions.toggle_files,                  { desc = "Toggle the file panel." } },
                        { "n", "g<C-x>",        actions.cycle_layout,                  { desc = "Cycle through available layouts." } },
                        { "n", "[x",            actions.prev_conflict,                 { desc = "In the merge-tool: jump to the previous conflict" } },
                        { "n", "]x",            actions.next_conflict,                 { desc = "In the merge-tool: jump to the next conflict" } },
                        { "n", "<leader>co",    actions.conflict_choose("ours"),       { desc = "Choose the OURS version of a conflict" } },
                        { "n", "<leader>ct",    actions.conflict_choose("theirs"),     { desc = "Choose the THEIRS version of a conflict" } },
                        { "n", "<leader>cb",    actions.conflict_choose("base"),       { desc = "Choose the BASE version of a conflict" } },
                        { "n", "<leader>ca",    actions.conflict_choose("all"),        { desc = "Choose all the versions of a conflict" } },
                        { "n", "dx",            actions.conflict_choose("none"),       { desc = "Delete the conflict region" } },
                        { "n", "<leader>cO",    actions.conflict_choose_all("ours"),   { desc = "Choose the OURS version of a conflict for the whole file" } },
                        { "n", "<leader>cT",    actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
                        { "n", "<leader>cB",    actions.conflict_choose_all("base"),   { desc = "Choose the BASE version of a conflict for the whole file" } },
                        { "n", "<leader>cA",    actions.conflict_choose_all("all"),    { desc = "Choose all the versions of a conflict for the whole file" } },
                        { "n", "dX",            actions.conflict_choose_all("none"),   { desc = "Delete the conflict region for the whole file" } },
                    },

                    diff1 = { { "n", "g?",      actions.help({ "view", "diff1" }),     { desc = "Open the help panel" } } },
                    diff2 = { { "n", "g?",      actions.help({ "view", "diff2" }),     { desc = "Open the help panel" } } },
                    diff3 = {
                        { { "n", "x" }, "2do",  actions.diffget("ours"),               { desc = "Obtain the diff hunk from the OURS version of the file" } },
                        { { "n", "x" }, "3do",  actions.diffget("theirs"),             { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
                        { "n", "g?",            actions.help({ "view", "diff3" }),     { desc = "Open the help panel" } },
                    },
                    diff4 = {
                        { { "n", "x" }, "1do",  actions.diffget("base"),               { desc = "Obtain the diff hunk from the BASE version of the file" } },
                        { { "n", "x" }, "2do",  actions.diffget("ours"),               { desc = "Obtain the diff hunk from the OURS version of the file" } },
                        { { "n", "x" }, "3do",  actions.diffget("theirs"),             { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
                        { "n", "g?",            actions.help({ "view", "diff4" }),     { desc = "Open the help panel" } },
                    },

                    file_panel = {
                        { "n", "<c-u>",         actions.scroll_view(-0.25),            { desc = "Scroll the view up" } },
                        { "n", "<c-d>",         actions.scroll_view(0.25),             { desc = "Scroll the view down" } },
                        { "n", "k",             actions.next_entry,                    { desc = "Bring the cursor to the next file entry" } },
                        { "n", "h",             actions.prev_entry,                    { desc = "Bring the cursor to the previous file entry" } },
                        { "n", "<down>",        actions.next_entry,                    { desc = "Bring the cursor to the next file entry" } },
                        { "n", "<up>",          actions.prev_entry,                    { desc = "Bring the cursor to the previous file entry" } },
                        { "n", "<cr>",          actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
                        { "n", "o",             actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
                        { "n", "l",             actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
                        { "n", "<2-LeftMouse>", actions.select_entry,                  { desc = "Open the diff for the selected entry" } },
                        { "n", "-",             actions.toggle_stage_entry,            { desc = "Stage / unstage the selected entry" } },
                        { "n", "s",             actions.toggle_stage_entry,            { desc = "Stage / unstage the selected entry" } },
                        { "n", "S",             actions.stage_all,                     { desc = "Stage all entries" } },
                        { "n", "U",             actions.unstage_all,                   { desc = "Unstage all entries" } },
                        { "n", "X",             actions.restore_entry,                 { desc = "Restore entry to the state on the left side" } },
                        { "n", "L",             actions.open_commit_log,               { desc = "Open the commit log panel" } },
                        { "n", "zo",            actions.open_fold,                     { desc = "Expand fold" } },
                        { "n", "j",             actions.close_fold,                    { desc = "Collapse fold" } },
                        { "n", "zc",            actions.close_fold,                    { desc = "Collapse fold" } },
                        { "n", "za",            actions.toggle_fold,                   { desc = "Toggle fold" } },
                        { "n", "zR",            actions.open_all_folds,                { desc = "Expand all folds" } },
                        { "n", "zM",            actions.close_all_folds,               { desc = "Collapse all folds" } },
                        { "n", "<c-b>",         actions.scroll_view(-0.25),            { desc = "Scroll the view up" } },
                        { "n", "<c-f>",         actions.scroll_view(0.25),             { desc = "Scroll the view down" } },
                        { "n", "<tab>",         actions.select_next_entry,             { desc = "Open the diff for the next file" } },
                        { "n", "<s-tab>",       actions.select_prev_entry,             { desc = "Open the diff for the previous file" } },
                        { "n", "gf",            actions.goto_file_edit,                { desc = "Open the file in the previous tabpage" } },
                        { "n", "<C-w><C-f>",    actions.goto_file_split,               { desc = "Open the file in a new split" } },
                        { "n", "<C-w>gf",       actions.goto_file_tab,                 { desc = "Open the file in a new tabpage" } },
                        { "n", "i",             actions.listing_style,                 { desc = "Toggle between 'list' and 'tree' views" } },
                        { "n", "f",             actions.toggle_flatten_dirs,           { desc = "Flatten empty subdirectories in tree listing style" } },
                        { "n", "R",             actions.refresh_files,                 { desc = "Update stats and entries in the file list" } },
                        { "n", "<leader>E",     actions.focus_files,                   { desc = "Bring focus to the file panel" } },
                        { "n", "<leader>e",     actions.toggle_files,                  { desc = "Toggle the file panel" } },
                        { "n", "g<C-x>",        actions.cycle_layout,                  { desc = "Cycle available layouts" } },
                        { "n", "[x",            actions.prev_conflict,                 { desc = "Go to the previous conflict" } },
                        { "n", "]x",            actions.next_conflict,                 { desc = "Go to the next conflict" } },
                        { "n", "g?",            actions.help("file_panel"),            { desc = "Open the help panel" } },
                        { "n", "<leader>cO",    actions.conflict_choose_all("ours"),   { desc = "Choose the OURS version of a conflict for the whole file" } },
                        { "n", "<leader>cT",    actions.conflict_choose_all("theirs"), { desc = "Choose the THEIRS version of a conflict for the whole file" } },
                        { "n", "<leader>cB",    actions.conflict_choose_all("base"),   { desc = "Choose the BASE version of a conflict for the whole file" } },
                        { "n", "<leader>cA",    actions.conflict_choose_all("all"),    { desc = "Choose all the versions of a conflict for the whole file" } },
                        { "n", "dX",            actions.conflict_choose_all("none"),   { desc = "Delete the conflict region for the whole file" } },
                    },

                    file_history_panel = {
                        { "n", "j",             nil },
                        { "n", "<c-u>",         actions.scroll_view(-0.25),            { desc = "Scroll the view up" } },
                        { "n", "<c-d>",         actions.scroll_view(0.25),             { desc = "Scroll the view down" } },
                        { "n", "g!",            actions.options,                       { desc = "Open the option panel" } },
                        { "n", "<C-A-d>",       actions.open_in_diffview,              { desc = "Open the entry under the cursor in a diffview" } },
                        { "n", "y",             actions.copy_hash,                     { desc = "Copy the commit hash of the entry under the cursor" } },
                        { "n", "L",             actions.open_commit_log,               { desc = "Show commit details" } },
                        { "n", "zR",            actions.open_all_folds,                { desc = "Expand all folds" } },
                        { "n", "zM",            actions.close_all_folds,               { desc = "Collapse all folds" } },
                        { "n", "k",             actions.next_entry,                    { desc = "Bring the cursor to the next file entry" } },
                        { "n", "h",             actions.prev_entry,                    { desc = "Bring the cursor to the previous file entry." } },
                        { "n", "<down>",        actions.next_entry,                    { desc = "Bring the cursor to the next file entry" } },
                        { "n", "<up>",          actions.prev_entry,                    { desc = "Bring the cursor to the previous file entry." } },
                        { "n", "<cr>",          actions.select_entry,                  { desc = "Open the diff for the selected entry." } },
                        { "n", "o",             actions.select_entry,                  { desc = "Open the diff for the selected entry." } },
                        { "n", "<2-LeftMouse>", actions.select_entry,                  { desc = "Open the diff for the selected entry." } },
                        { "n", "<c-b>",         actions.scroll_view(-0.25),            { desc = "Scroll the view up" } },
                        { "n", "<c-f>",         actions.scroll_view(0.25),             { desc = "Scroll the view down" } },
                        { "n", "<tab>",         actions.select_next_entry,             { desc = "Open the diff for the next file" } },
                        { "n", "<s-tab>",       actions.select_prev_entry,             { desc = "Open the diff for the previous file" } },
                        { "n", "gf",            actions.goto_file_edit,                { desc = "Open the file in the previous tabpage" } },
                        { "n", "<C-w><C-f>",    actions.goto_file_split,               { desc = "Open the file in a new split" } },
                        { "n", "<C-w>gf",       actions.goto_file_tab,                 { desc = "Open the file in a new tabpage" } },
                        { "n", "<leader>E",     actions.focus_files,                   { desc = "Bring focus to the file panel" } },
                        { "n", "<leader>e",     actions.toggle_files,                  { desc = "Toggle the file panel" } },
                        { "n", "g<C-x>",        actions.cycle_layout,                  { desc = "Cycle available layouts" } },
                        { "n", "g?",            actions.help("file_history_panel"),    { desc = "Open the help panel" } },
                    },
                    option_panel = {
                        { "n", "<tab>",         actions.select_entry,                  { desc = "Change the current option" } },
                        { "n", "q",             actions.close,                         { desc = "Close the panel" } },
                        { "n", "g?",            actions.help("option_panel"),          { desc = "Open the help panel" } },
                    },
                    help_panel = {
                        { "n", "q",             actions.close,                         { desc = "Close help menu" } },
                        { "n", "<esc>",         actions.close,                         { desc = "Close help menu" } },
                    },
                    -- stylua: ignore end
                },
            })
        end,
    },
}
