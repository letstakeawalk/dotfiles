local utils = require("utils")
local M = vim.defaulttable()

local function generate_help_txt()
    local align = require("plenary.strings").align_str
    -- stylua: ignore
    local text = {
        nav = {
            { "gU",     "untracked" },
            { "gu",     "unstaged" },
            { "gs",     "staged" },
            { "gp",     "unpushed" },
            { "gP",     "unpulled" },
            { "gr",     "rebasing" },
            { "gi",     "exclude/ignore" },
            { "gI",     "exclude/ignore++" },
            { "i",      "next hunk & exp" },
            { "[c, ]c", "expand prev/next" },
            { "(, )",   "goto prev/next" },
        },
        staging = {
            { "s",      "stage" },
            { "u",      "unstage" },
            { "a",      "stage/unstage" },
            { "-",      "stage/unstage" },
            { "X",      "discard" },
            { "=",      "inline diff" },
            { "I",      "patch" },
            { "coo",    "checkout" },
            { "czz",    "stash push" },
            { "czp",    "stash pop" },
            { "cz<sp>", ":Git stash" },
        },
        commit = {
            { "cc",     "commit" },
            { "ca",     "amend" },
            { "ce",     "amend no-edit" },
            { "cw",     "reword" },
            { "cf",     "fixup!" },
            { "cs",     "squash!" },
            { "crc",    "revert commit" },
            { "c<sp>",  ":Git commit" },
            { "cr<sp>", ":Git revert" },
            { "cm<cp>", ":Git merge" },
            { "P",      ":Git push" },
        },
        rebase_stash = {
            { "ri",     "interactive" },
            { "rr",     "continue" },
            { "rs",     "skip commit" },
            { "ra",     "abort" },
            { "re",     "edit todo" },
            { "rw",     "mark reword" },
            { "rm",     "mark edit" },
            { "rd",     "mark drop" },
            { "r<sp>",  ":Git rebase" },
        },
    }

    local padding = {
        header = 1,
        footer = 1,
        line_leader = 2,
        key = 2,
        desc = 5,
        nav = {},
        staging = {},
        commit = {},
        rebase_stash = {},
    }
    local num_rows = 0
    for section, tips in pairs(text) do
        num_rows = math.max(num_rows, #tips)
        local klen, vlen = 0, 0
        for _, tip in ipairs(tips) do
            klen = math.max(klen, #tip[1])
            vlen = math.max(vlen, #tip[2])
        end
        padding[section].key = klen
        padding[section].val = vlen
    end
    local lines = {}
    table.insert(
        lines,
        align("", padding.line_leader, false)
            .. align("Navigation", padding.nav.key + padding.nav.val + padding.key + padding.desc, false)
            .. align("Staging", padding.staging.key + padding.staging.val + padding.key + padding.desc, false)
            .. align("Commit", padding.commit.key + padding.commit.val + padding.key + padding.desc, false)
            .. align("Rebase/Stash", padding.rebase_stash.key + padding.rebase_stash.val + padding.key + padding.desc, false)
    )
    for _ = 1, padding.header do
        table.insert(lines, "")
    end
    for i = 1, num_rows do
        text.nav[i] = text.nav[i] or {}
        text.staging[i] = text.staging[i] or {}
        text.commit[i] = text.commit[i] or {}
        text.rebase_stash[i] = text.rebase_stash[i] or {}
        local line = align("", padding.line_leader, false)
            .. align(text.nav[i][1] or "", padding.nav.key + padding.key, false)
            .. align(text.nav[i][2] or "", padding.nav.val + padding.desc, false)
            .. align(text.staging[i][1] or "", padding.staging.key + padding.key, false)
            .. align(text.staging[i][2] or "", padding.staging.val + padding.desc, false)
            .. align(text.commit[i][1] or "", padding.commit.key + padding.key, false)
            .. align(text.commit[i][2] or "", padding.commit.val + padding.desc, false)
            .. align(text.rebase_stash[i][1] or "", padding.rebase_stash.key + padding.key, false)
            .. align(text.rebase_stash[i][2] or "", padding.rebase_stash.val + padding.desc, false)
        table.insert(lines, line)
    end
    for _ = 1, padding.footer do
        table.insert(lines, "")
    end
    return lines, padding, num_rows
end

---@return boolean: Whether the floating window is valid
local function float_is_valid()
    -- stylua: ignore
    return vim.g.fugitive_ext_float_winid
        and vim.api.nvim_win_is_valid(vim.g.fugitive_ext_float_winid)
        or false
end

---@return boolean: Whether the fugitive window is resized
local function fugitive_resized()
    -- stylua: ignore
    return vim.g.fugitive_ext_win_width
        and vim.g.fugitive_ext_win_height
        and vim.api.nvim_win_get_width(0) ~= vim.g.fugitive_ext_win_width
        or vim.api.nvim_win_get_height(0) ~= vim.g.fugitive_ext_win_height
end

--- Helper function to open the help floating window
local function help_float_open()
    if float_is_valid() then
        return
    end
    M.help.close()

    ---@type integer|nil: fugitive window width
    vim.g.fugitive_ext_win_width = vim.api.nvim_win_get_width(0)
    ---@type integer|nil: fugitive window height
    vim.g.fugitive_ext_win_height = vim.api.nvim_win_get_height(0)

    -- if vim.g.fugitive_ext_win_height and vim.g.fugitive_ext_win_height < 35 then
    --     return
    -- end

    local buf = vim.api.nvim_create_buf(false, true)
    local text, padding, num_rows = generate_help_txt()
    vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, text)

    ---@type integer|nil: floating window id
    vim.g.fugitive_ext_float_winid = vim.api.nvim_open_win(buf, false, {
        relative = "win",
        anchor = "NW",
        width = vim.api.nvim_win_get_width(0),
        height = #text,
        style = "minimal",
        border = { { "─", "WinSeparator" }, { "─", "WinSeparator" }, { "─", "WinSeparator" }, "", "", "", "", "" },
        row = vim.api.nvim_win_get_height(0) - (#text + 1), -- #text + #border_lines
        col = 0,
        -- focusable = false,
        noautocmd = true,
    })

    -- nvim_buf_add_highlight
    -- stylua: ignore start
    local nav_key          = padding.nav.key  + padding.key
    local nav_val          = nav_key          + padding.nav.val          + padding.desc
    local staging_key      = nav_val          + padding.staging.key      + padding.key
    local staging_val      = staging_key      + padding.staging.val      + padding.desc
    local commit_key       = staging_val      + padding.commit.key       + padding.key
    local commit_val       = commit_key       + padding.commit.val       + padding.desc
    local rebase_stash_key = commit_val       + padding.rebase_stash.key + padding.key
    local rebase_stash_val = rebase_stash_key + padding.rebase_stash.val + padding.desc

    vim.api.nvim_buf_add_highlight(buf, -1, "FugitiveExtSection", 0, 0, -1)
    for i = padding.header + 1, num_rows + 1 do
        vim.api.nvim_buf_add_highlight(buf, -1, "FugitiveExtKey",  i, 0,                nav_key)
        vim.api.nvim_buf_add_highlight(buf, -1, "FugitiveExtDesc", i, nav_key,          nav_val)
        vim.api.nvim_buf_add_highlight(buf, -1, "FugitiveExtKey",  i, nav_val,          staging_key)
        vim.api.nvim_buf_add_highlight(buf, -1, "FugitiveExtDesc", i, staging_key,      staging_val)
        vim.api.nvim_buf_add_highlight(buf, -1, "FugitiveExtKey",  i, staging_val,      commit_key)
        vim.api.nvim_buf_add_highlight(buf, -1, "FugitiveExtDesc", i, commit_key,       commit_val)
        vim.api.nvim_buf_add_highlight(buf, -1, "FugitiveExtKey",  i, commit_val,       rebase_stash_key)
        vim.api.nvim_buf_add_highlight(buf, -1, "FugitiveExtDesc", i, rebase_stash_key, rebase_stash_val)
    end
    -- stylua: ignore end
end

function M.help.open()
    if vim.g.fugitive_ext_disabled then
        return
    end
    if fugitive_resized() then
        M.help.close()
        help_float_open()
    else
        help_float_open()
    end
end

function M.help.close()
    if float_is_valid() then
        vim.api.nvim_win_close(vim.g.fugitive_ext_float_winid, true)
        vim.g.fugitive_ext_float_winid = nil
        vim.g.fugitive_ext_win_width = nil
        vim.g.fugitive_ext_win_height = nil
    end
end

function M.help.toggle()
    if float_is_valid() then
        M.help.close()
        ---@type boolean|nil: Whether the help window is closed
        vim.g.fugitive_ext_disabled = true
    else
        help_float_open()
        vim.g.fugitive_ext_disabled = false
    end
end

function M.help.update_help_header()
    for i, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, 4, false)) do
        if vim.startswith(line, "Help: g?") then
            vim.bo.modifiable = true
            vim.bo.readonly = false
            vim.api.nvim_buf_set_lines(0, i - 1, i, false, { "Help: ?, Doc: g?" })
            vim.bo.modifiable = false
            vim.bo.readonly = true
            vim.api.nvim_buf_add_highlight(0, -1, "fugitiveHelpHeader", i - 1, 9, 12)
            break
        end
    end
end

function M.cmd.discard_changes()
    utils.ui.input({ prompt = "Are you sure to discard changes? (y/n)" }, function(input)
        if input == "y" then
            utils.exec.plug("fugitive:X")
        end
    end)
end

function M.cmd.git_push()
    -- utils.ui.input({ prompt = "Git push <options>" }, function(input)
    --     vim.cmd("Git push " .. input)
    -- end)
    local keys = ":Git push "
    local escaped = vim.api.nvim_replace_termcodes(keys, true, true, true)
    vim.api.nvim_feedkeys(escaped, "n", true)
end

function M.cmd.commit_amend_no_edit()
    utils.ui.input({ prompt = "Are you sure to `commit --amend --no-edit`? (y/n)" }, function(input)
        if input == "y" then
            utils.exec.plug("fugitive:ce")
        end
    end)
end

M.cmd.stash_pop_i = "<Plug>fugitive:czp"
M.cmd.stash_pop = "<Plug>fugitive:czP"

-- stylua: ignore start
M.nav.untracked           = "<Plug>fugitive:gu"
M.nav.unstaged            = "<Plug>fugitive:gU"
M.nav.staged              = "<Plug>fugitive:gs"
M.nav.unpushed            = "<Plug>fugitive:gp"
M.nav.unpulled            = "<Plug>fugitive:gP"
M.nav.rebasing            = "<Plug>fugitive:gr"
M.nav.exclude_ignore      = "<Plug>fugitive:gi"
M.nav.exclude_ignore_plus = "<Plug>fugitive:gI"
M.nav.next_hunk           = "i"
M.nav.expand_prev_hunk    = "[c"
M.nav.expand_next_hunk    = "]c"
-- stylua: ignore start

return M
