---@diagnostic disable: missing-fields
local function git_worktrees()
    require("telescope").extensions.git_worktree.git_worktree({
        layout_config = {
            height = 20,
            width = 80,
        },
    })
end
local function git_worktree_create()
    require("telescope").extensions.git_worktree.create_git_worktree()
end
local function git_conflicts()
    vim.cmd([[silent grep "^<<<<<<< " .]])
    vim.cmd.copen()
end
local function setqflist(target)
    return function()
        require("gitsigns").setqflist(target, { open = true }, vim.cmd.cfirst)
    end
end

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
            { "<leader>gg", "<cmd>Git<cr>", desc = "Fugitive" },
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
        dir = "~/Workspace/projects/contribute/gitsigns.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = "VeryLazy",
        keys = {
            { "<leader>gq", setqflist(0), desc = "Buffer Hunks" },
            { "<leader>gw", setqflist("all"), desc = "Workspace Hunks" },
            { "<leader>gf", git_conflicts, desc = "Conflicts" },
        },
        opts = {
            attach_to_untracked = true,
            on_attach = function(bufnr)
                local gs = require("gitsigns")
                local api = vim.api

                local function map(mode, lhs, rhs, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                local make_repeatable_move_pair =
                    require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair

                -- stylua: ignore start
                local next_hunk = function()
                    gs.nav_hunk("next", { wrap = false, preview = false }, require("utils").centerscreen)
                end
                local prev_hunk = function()
                    gs.nav_hunk("prev", { wrap = false, preview = false }, require("utils").centerscreen)
                end
                next_hunk, prev_hunk = make_repeatable_move_pair(next_hunk, prev_hunk)
                map("n", "]c", next_hunk, { desc = "Goto next hunk" })
                map("n", "[c", prev_hunk, { desc = "Goto previous hunk" })
                -- stylua: ignore end

                local function toggle_blame_buf()
                    local blame_bufs = vim.tbl_filter(function(buf)
                        return api.nvim_get_option_value("filetype", { buf = buf }) == "gitsigns-blame"
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
                            local bufname = api.nvim_buf_get_name(buf)
                            if
                                bufname:match("^gitsigns")
                                or (bufname:match("^fugitive") and not bufname:match("//$"))
                            then
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
                map("n", "<leader>gs", gs.stage_hunk,          { desc = "Stage hunk" })
                map("n", "<leader>gr", gs.reset_hunk,          { desc = "Reset hunk" })
                map("n", "<leader>ga", gs.stage_buffer,        { desc = "Stage buffer" })
                map("n", "<leader>gR", gs.reset_buffer,        { desc = "Reset buffer" })
                map("n", "<leader>gp", gs.preview_hunk,        { desc = "Preview hunk" })
                map("n", "<leader>gx", gs.preview_hunk_inline, { desc = "Preview hunk inline" })
                map("n", "<leader>gb", gs.blame_line,          { desc = "Blame line" })
                map("n", "<leader>gB", toggle_blame_buf,       { desc = "Blame" })
                map("n", "<leader>gd", diffthis,               { desc = "Diff this" })
                map("n", "<leader>gD", diff,                   { desc = "Diff" })
                map("n", "<leader>dg", gs.toggle_current_line_blame, { desc = "Git Blame (curr line)" })
                -- stylua: ignore end

                -- Text object
                map({ "o", "x" }, "ih", gs.select_hunk, { desc = "Select hunk" })
                map({ "o", "x" }, "ah", gs.select_hunk, { desc = "Select hunk" })
            end,
        },
    },
    {
        "letstakeawalk/git-conflict.nvim", -- "akinsho/git-conflict.nvim"
        -- dir = "~/Workspace/projects/contribute/git-conflict.nvim",
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
        "polarmutex/git-worktree.nvim", -- "ThePrimeagen/git-worktree.nvim",
        version = "^2",
        keys = {
            { "<leader>w", git_worktrees, desc = "Git worktrees (Telescope)" },
            { "<leader>W", git_worktree_create, desc = "Create worktree" },
        },
        init = function()
            vim.g.git_worktree = {
                change_directory_command = "cd", -- default: "cd",
                update_on_change = true, -- default: true,
                update_on_change_command = "e .", -- default: "e .",
                clearjumps_on_change = true, -- default: true,
                confirm_telescope_deletions = true,
                autopush = false, -- default: false,
            }
        end,
        config = function()
            local Hooks = require("git-worktree.hooks")
            local config = require("git-worktree.config")
            local update_on_switch = Hooks.builtins.update_current_buffer_on_switch

            Hooks.register(Hooks.type.SWITCH, function(path, prev_path)
                vim.notify("Moved from " .. prev_path .. " to " .. path, vim.log.levels.INFO)
                update_on_switch(path, prev_path)
            end)

            Hooks.register(Hooks.type.DELETE, function()
                vim.cmd(config.update_on_change_command)
            end)
        end,
    },
}
