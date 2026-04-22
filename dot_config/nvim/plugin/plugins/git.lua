---@diagnostic disable: missing-fields
vim.pack.add({
    "gh:tpope/vim-fugitive", -- git interface
    "gh:junegunn/gv.vim", -- git commit browser
    "gh:tpope/vim-rhubarb", -- fugitive extension for GitHub
    "gh:lewis6991/gitsigns.nvim",
    "gh:letstakeawalk/fugitive-ext.nvim",
    "gh:niekdomi/conflict.nvim", -- "gh:letstakeawalk/git-conflict.nvim", -- "gh:akinsho/git-conflict.nvim"
    "gh:afonsofrancof/worktrees.nvim",
    "gh:nvim-telescope/telescope.nvim",
    -- "gh:polarmutex/git-worktree.nvim", -- "gh:ThePrimeagen/git-worktree.nvim",
})

local api = vim.api
local utils = require("utils")
local set = utils.keymap.set
local gs = require("gitsigns")
local next_hunk, prev_hunk = utils.repeatable(function()
    if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
    else
        gs.nav_hunk("next", { wrap = false, preview = false }, utils.centerscreen)
    end
end, function()
    if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
    else
        gs.nav_hunk("prev", { wrap = false, preview = false }, utils.centerscreen)
    end
end)

local function toggle_blame_buf()
    local blame_bufs = vim.tbl_filter(
        function(buf)
            return api.nvim_get_option_value("filetype", { buf = buf }) == "gitsigns-blame"
        end,
        api.nvim_list_bufs()
    )
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

local function setqflist(target)
    return function() gs.setqflist(target, { open = true }, vim.cmd.cfirst) end
end

local function git_conflicts()
    vim.cmd([[silent grep "^<<<<<<< " .]])
    vim.cmd.cwindow()
end

-- TODO: change this to selection with options instead of input. ~1 for last commit
local function diff()
    vim.ui.input({ prompt = "Diff against: " }, function(input) gs.diffthis(input) end)
end

gs.setup({
    attach_to_untracked = true,
    on_attach = function(bufnr)
        set("n", "]c", next_hunk, { desc = "Goto next hunk", buf = bufnr })
        set("n", "[c", prev_hunk, { desc = "Goto previous hunk", buf = bufnr })

        -- stylua: ignore start
        set("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk",            buf = bufnr })
        set("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk",            buf = bufnr })
        set("n", "<leader>gs", gs.stage_hunk,                                                        { desc = "Stage hunk",            buf = bufnr })
        set("n", "<leader>gr", gs.reset_hunk,                                                        { desc = "Reset hunk",            buf = bufnr })
        set("n", "<leader>ga", gs.stage_buffer,                                                      { desc = "Stage buffer",          buf = bufnr })
        set("n", "<leader>gR", gs.reset_buffer,                                                      { desc = "Reset buffer",          buf = bufnr })
        set("n", "<leader>gp", gs.preview_hunk,                                                      { desc = "Preview hunk",          buf = bufnr })
        set("n", "<leader>gx", gs.preview_hunk_inline,                                               { desc = "Preview hunk inline",   buf = bufnr })
        set("n", "<leader>gb", gs.blame_line,                                                        { desc = "Blame line",            buf = bufnr })
        set("n", "<leader>gB", toggle_blame_buf,                                                     { desc = "Blame",                 buf = bufnr })
        set("n", "<leader>gd", diffthis,                                                             { desc = "Diff this",             buf = bufnr })
        set("n", "<leader>gD", diff,                                                                 { desc = "Diff",                  buf = bufnr })
        set("n", "<leader>dw", gs.toggle_word_diff,                                                  { desc = "Git word diff",         buf = bufnr })
        set("n", "<leader>dg", gs.toggle_current_line_blame,                                         { desc = "Git Blame (curr line)", buf = bufnr })
        -- stylua: ignore end

        -- Text object
        set("xo", "ih", gs.select_hunk, { desc = "Select hunk", buf = bufnr })
        set("xo", "ah", gs.select_hunk, { desc = "Select hunk", buf = bufnr })
    end,
})

set("n", "<leader>gg", "<cmd>Git<cr>", { desc = "Fugitive" })
set("n", "<leader>gq", "<cmd>Git<cr><cmd>bd<cr>", { desc = "Close Fugitive" })
set("n", "<leader>gc", "<cmd>GV<cr>", { desc = "Commit Browser (GV)" })
set("n", "<leader>gC", "<cmd>GV!<cr>", { desc = "BufCommit Browser (GV!)" })
set("n", "<leader>gq", setqflist(0), { desc = "Buffer Hunks" })
set("n", "<leader>gw", setqflist("all"), { desc = "Workspace Hunks" })
set("n", "<leader>gf", git_conflicts, { desc = "Conflicts" })

require("fugitive-ext").setup({
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
})

require("conflict").setup({
    default_mappings = {
        current = "co",
        incoming = "ct",
        none = "c0",
        both = "cb",
        next = "]g",
        prev = "[g",
    },
    show_actions = false,
    disable_diagnostics = true, -- Disable LSP/Diagnostics while conflicts exist
    highlights = { -- They must have background color, otherwise the default color will be used
        current = "DiffText",
        incoming = "DiffAdd",
    },
})

require("worktrees").setup({
    path_template = "wt-{branch}",
    commands = {
        create = "WtCreate",
        delete = "WtDelete",
        switch = "WtSwitch",
    },
    mappings = {
        create = "<leader>wc",
        switch = "<leader>ws",
        delete = "<leader>wd",
    },
})
-- TODO: hooks || worktrunk
