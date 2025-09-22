---@diagnostic disable: param-type-mismatch
return {
    {
        "letstakeawalk/fugitive-ext.nvim",
        dependencies = {
            "tpope/vim-fugitive", -- git interface
            "junegunn/gv.vim", -- git commit browser
            "tpope/vim-rhubarb", -- fugitive extension for GitHub
        },
        cmd = "Git",
        keys = {
            { "<leader>gg", "<cmd>vert Git<cr>", desc = "Fugitive" },
            { "<leader>gq", "<cmd>Git<cr><cmd>bd<cr>", desc = "Close Fugitive" },
            { "<leader>gc", "<cmd>GV<cr>", desc = "Commit Browser (GV)" },
            { "<leader>gC", "<cmd>GV!<cr>", desc = "BufCommit Browser (GV!)" },
        },
        opts = {
            _debug = false,
            fugitive = {
                -- TODO: restore default conf when closing (bufdelete/wipe events)
                line_number = false,
                relative_number = false,
            },
            hint = {
                title = false,
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
                local api = vim.api

                local function map(mode, lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                local make_repeatable_move_pair =
                    require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair

                local next_hunk = function()
                    gs.nav_hunk("next", { wrap = false, preview = false })
                    vim.cmd("normal! zz")
                    -- gs.preview_hunk_inline()
                end
                local prev_hunk = function()
                    gs.nav_hunk("prev", { wrap = false, preview = false })
                    vim.cmd("normal! zz")
                    -- gs.preview_hunk_inline()
                end
                next_hunk, prev_hunk = make_repeatable_move_pair(next_hunk, prev_hunk)

                map("n", "]c", next_hunk, { desc = "Goto next hunk" })
                map("n", "[c", prev_hunk, { desc = "Goto previous hunk" })

                local function toggle_blame_buf()
                    local blame_bufs = vim.tbl_filter(function(buf)
                        return api.nvim_get_option_value("filetype", { buf = buf }) == "gitsigns.blame"
                    end, api.nvim_list_bufs())
                    if #blame_bufs == 0 then
                        gs.blame()
                    else
                        api.nvim_buf_delete(blame_bufs[1], { force = true })
                    end
                end

                local function diffthis()
                    local current_window = api.nvim_get_current_win()
                    if not api.nvim_get_option_value("diff", { win = current_window }) then
                        return gs.diffthis()
                    end
                    local current_tabpage = api.nvim_get_current_tabpage()
                    for _, win in ipairs(api.nvim_tabpage_list_wins(current_tabpage)) do
                        if api.nvim_get_option_value("diff", { win = win }) then
                            api.nvim_set_option_value("diff", false, { win = win })
                            local buf = api.nvim_win_get_buf(win)
                            if api.nvim_buf_get_name(buf):match("^gitsigns") then
                                -- api.nvim_buf_delete(buf, {})
                                api.nvim_win_close(win, true)
                            end
                        end
                    end
                end

                -- TODO: change this to selection with options instead of input
                -- ~1 for last commit
                local function diff()
                    vim.ui.input({ prompt = "Diff against: " }, function(input)
                        gs.diffthis(input)
                    end)
                end

                -- stylua: ignore start
                map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
                map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
                map("n", "<leader>gs", gs.stage_hunk,                   { desc = "Stage hunk" })
                map("n", "<leader>gr", gs.reset_hunk,                   { desc = "Reset hunk" })
                map("n", "<leader>ga", gs.stage_buffer,                 { desc = "Stage buffer" })
                map("n", "<leader>gR", gs.reset_buffer,                 { desc = "Reset buffer" })
                map("n", "<leader>gp", gs.preview_hunk,                 { desc = "Preview hunk" })
                map("n", "<leader>gb", toggle_blame_buf,                { desc = "Blame" })
                map("n", "<leader>gd", diffthis,                        { desc = "Diff this" })
                map("n", "<leader>gD", diff,                            { desc = "Diff" })
                map("n", "<leader>gx", gs.preview_hunk_inline,          { desc = "Toggle deleted" })

                -- Text object
                map({ "o", "x" }, "ih", gs.select_hunk, { desc = "Select hunk" })
                map({ "o", "x" }, "ah", gs.select_hunk, { desc = "Select hunk" })
                -- map({ "o", "x" }, "ih", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
                -- map({ "o", "x" }, "ah", "<cmd><C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
                -- stylua: ignore end
            end,
        },
    },
    {
        "akinsho/git-conflict.nvim",
        dir = "~/Workspace/projects/contribute/git-conflict.nvim",
        version = "*",
        event = "BufRead",
        opts = {
            default_mappings = {
                ours = "co",
                theirs = "ct",
                none = "c0",
                both = "cb",
                next = "]g",
                prev = "[g",
            },
            default_commands = true, -- disable commands created by this plugin
            disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
            list_opener = "copen", -- command or function to open the conflicts list
            highlights = { -- They must have background color, otherwise the default color will be used
                incoming = "DiffAdd",
                current = "DiffText",
            },
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
