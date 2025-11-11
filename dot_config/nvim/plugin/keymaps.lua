local set = vim.keymap.set
local del = vim.keymap.del

-- stylua: ignore start
--- General
set("n", "<C-c>", vim.cmd.noh, { desc = "Clear highlights" })
set("n", "<Esc>", vim.cmd.noh, { desc = "Clear highlights" })
-- set("i", "<C-c>", function() return vim.api.nvim_win_get_cursor(0)[2] > 1 and "<esc>l" or "<esc>" end, { expr = true })
set("i", "<C-c>", "<Esc>")
-- set("i", "<Esc>", "<Nop>")

--- Cursor Navigation
set("n", "k",  "v:count == 0 ? 'gj' : 'j'",  { desc = "Down",  silent = true, expr = true })
set("n", "h",  "v:count == 0 ? 'gk' : 'k'",  { desc = "Up",    silent = true, expr = true })
set("n", "j",  "h",                          { desc = "Left",  silent = true })
set("n", "l",  "l",                          { desc = "Right", silent = true })
set("x", "k",  "j",                          { desc = "Down",  silent = true })
set("x", "h",  "k",                          { desc = "Up",    silent = true })
set("x", "j",  "h",                          { desc = "Left",  silent = true })
set("x", "l",  "l",                          { desc = "Right", silent = true })
set("n", "gk", "j",                          { desc = "Down" })
set("n", "gh", "k",                          { desc = "Up" })
set({ "i", "n" }, "<A-f>", "<C-Right>",      { desc = "Next word" }) -- ^[f (A-right)
set({ "i", "n" }, "<A-b>", "<C-Left>",       { desc = "Prev word" }) -- ^[b (A-left)
vim.keymap.set("c", "<A-f>", function()
    local cmd, pos = vim.fn.getcmdline(), vim.fn.getcmdpos()
    if pos > #cmd then return "" end
    local after = cmd:sub(pos)
    local offset = 1
    if after:match("^[%w_]") then -- word
        offset = after:match("^[%w_]+()")
    elseif after:match("^[^%w_%s]") then -- special chars
        offset = after:match("^[^%w_%s]+()")
    end
    local ws_offset = after:sub(offset):match("^%s+()") or 1 -- skip whitespace
    return string.rep("<Right>", offset + ws_offset - 2)
end, { desc = "Next word", expr = true })
vim.keymap.set("c", "<A-b>", function()
    local cmd, pos = vim.fn.getcmdline(), vim.fn.getcmdpos()
    if pos == 1 then return "" end
    local before = cmd:sub(1, pos - 1)
    local trimmed = before:gsub("%s+$", "") -- Skip trailing whitespace
    if trimmed:match("[%w_]$") then -- word
        trimmed = trimmed:gsub("[%w_]+$", "")
    elseif #trimmed > 0 then -- special chars
        trimmed = trimmed:gsub("[^%w_%s]+$", "")
    end
    return string.rep("<Left>", #before - #trimmed)
end, { desc = "Prev word", expr = true })
set("c", "<C-a>", "<Home>",                  { desc = "BoL" })
set("c", "<C-e>", "<End>",                   { desc = "EoL" })
set("n", "ge", "gi",                         { desc = "Goto last edited" }) -- go to last INSERT pos and insert
set("n", "gg", "gg",                         { desc = "Goto BoF" }) -- jump to bof, center cursor
set("n", "G",  "Gzz",                        { desc = "Goto EoF" })  -- jump to eof, center cursor
set("n", "zj", "10zh",                       { desc = "Scroll left" })
set("n", "zl", "10zl",                       { desc = "Scroll left" })
set("n", "zJ", "10zh",                       { desc = "Scroll left" })
set("n", "zL", "10zl",                       { desc = "Scroll left" })
set("n", "zh", "<Nop>",                      { desc = "NOP"})
set("n", "zH", "<Nop>",                      { desc = "NOP"})
set("n", "}",  "}zz",                        { desc = "Next Paragraph" })
set("n", "{",  "{zz",                        { desc = "Prev Paragraph" })
set("n", "'",  "g`",                         { desc = "Jump to mark" })
set("n", "<C-d>",      "<C-d>zz",            { desc = "Scroll down" })
set("n", "<C-u>",      "<C-u>zz",            { desc = "Scroll up" })
set("n", "<PageDown>", "<C-d>zz",            { desc = "Scroll down" })
set("n", "<PageUp>",   "<C-u>zz",            { desc = "Scroll up" })
set("n", "<C-e>",      "10<C-e>",            { desc = "Scroll down" })
set("n", "<C-y>",      "10<C-y>",            { desc = "Scroll up" })

-- Buffer/Tab/Pane Navigation & Management
set("n", "<C-q>",     "<cmd>q<cr>",                  { desc = "Close buffer"  })
set("n", "<C-s>",     "<cmd>silent w<cr>",           { desc = "Write buffer" })
set("n", "<Home>",    "<cmd>tabprev<cr>",            { desc = "Previous tab" })
set("n", "<End>",     "<cmd>tabnext<cr>",            { desc = "Next tab" })
-- set("n", "<c-w>k",    "<c-w>j",                      { desc = "Goto bottom pane" })
-- set("n", "<c-w>h",    "<c-w>k",                      { desc = "Goto top pane" })
-- set("n", "<c-w>j",    "<c-w>h",                      { desc = "Goto left pane" })
-- set("n", "<c-w>l",    "<c-w>l",                      { desc = "Goto right pane" })
set("n", "<c-w>K",    "<c-w>J",                      { desc = "Move pane to down" })
set("n", "<c-w>H",    "<c-w>K",                      { desc = "Move pane to up" })
set("n", "<c-w>J",    "<c-w>H",                      { desc = "Move pane to left" })
set("n", "<c-w>L",    "<c-w>L",                      { desc = "Move pane to right" })
set("n", "<C-Up>",    "<cmd>resize +2<cr>",          { desc = "Increase window height" })
set("n", "<C-Down>",  "<cmd>resize -2<cr>",          { desc = "Decrease window height" })
set("n", "<C-Left>",  "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Fold
local function fold_ic()
    vim.lsp.foldclose("comment")
    vim.lsp.foldclose("imports")
end
local function fold(level)
    return function()
        vim.wo.foldlevel = level
        if level > 0 then fold_ic() end
    end
end
set("n", "z0", fold(0), { desc = "Fold level: 0" })
set("n", "z1", fold(1), { desc = "Fold level: 1" })
set("n", "z2", fold(2), { desc = "Fold level: 2" })
set("n", "z3", fold(3), { desc = "Fold level: 3" })
set("n", "z4", fold(4), { desc = "Fold level: 4" })
set("n", "z5", fold(5), { desc = "Fold level: 5" })
set("n", "zv", "zMzx",  { desc = "Open enough fold" }) -- zMzvzczO
set("n", "zx", "zMzx",  { desc = "Open enough fold" })
set("n", "z/", fold_ic, { desc = "Fold imports & comments" })

-- Editing
set("i", "<C-d>", "<C-d>", { desc = "Indent -1 level" })
set("i", "<C-t>", "<C-t>", { desc = "Indent +1 level" })
set("i", "<C-v>", "<C-t>", { desc = "Indent +1 level" })
set("n", "<<", "<h",       { desc = "Indent -1 level" })
set("n", ">>", ">l",       { desc = "Indent +1 level" })
set("v", "<", "<gv",       { desc = "Indent -1 level" })
set("v", ">", ">gv",       { desc = "Indent +1 level" })
set({ "i", "c" }, "<A-BS>",  "<C-w>",   { desc = "Delete word" }) -- delete word
set({ "i", "c" }, "<A-Del>", "<C-o>dw", { desc = "Delete word forward" })
set("i",          "<C-l>",   "<Del>",   { desc = "Delete forward" })
-- set("c",          "<C-k>",   "<Del>",   { desc = "Delete line from cursor" })
set("s",          "<BS>",    "<BS>i",   { desc = "Delete selection and stay in I-mode" })
set("n", "J", "mzJ`z", { desc = "Join lines" }) -- join lines while preserving cursor pos
set("x", "p", '"_dP') -- keep copied text in register without overriding when pasting/replacing -- "greatest remap ever" by thePrimeagen
set("n", "<A-down>", ":m .+1<CR>==",        { desc = "Move line below" })
set("i", "<A-down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line below" })
set("v", "<A-down>", ":m '>+1<CR>gv=gv",    { desc = "Move line below" })
set("n", "<A-k>",    ":m .+1<CR>==",        { desc = "Move line below" })
set("i", "<A-k>",    "<Esc>:m .+1<CR>==gi", { desc = "Move line below" })
set("v", "<A-k>",    ":m '>+1<CR>gv=gv",    { desc = "Move line below" })
set("n", "<A-up>",   ":m .-2<CR>==",        { desc = "Move line up" })
set("i", "<A-up>",   "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
set("v", "<A-up>",   ":m '<-2<CR>gv=gv",    { desc = "Move line up" })
set("n", "<A-h>",    ":m .-2<CR>==",        { desc = "Move line up" })
set("i", "<A-h>",    "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
set("v", "<A-h>",    ":m '<-2<CR>gv=gv",    { desc = "Move line up" })
-- stylua: ignore end

-- Display/Toggle: <leader>d
set("n", "<leader>dm", "<cmd>message<cr>", { desc = "Messages" })
set("n", "<leader>dM", "<cmd>Redir message<cr>", { desc = "Redir Messages" })
set("n", "<leader>dn", function()
    local enabled = vim.wo.number
    vim.wo.number = not enabled
    vim.wo.relativenumber = not enabled
    vim.wo.signcolumn = enabled and "no" or "yes"
    vim.wo.scrolloff = enabled and 0 or 10
    vim.wo.sidescrolloff = enabled and 0 or 10
end, { desc = "Display Numbers" })
set("n", "<leader>dc", function()
    vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0
    vim.notify("Conceal " .. (vim.wo.conceallevel == 2 and "Enabled" or "Disabled"), vim.log.levels.INFO)
end, { desc = "Conceal Toggle" })
-- set("n", "<leader>ds", function()
--     vim.wo.spell = not vim.wo.spell
--     vim.notify("Spelling " .. (vim.wo.spell and "Enabled" or "Disabled"))
-- end, { desc = "Spelling Toggle" })
set("n", "<leader>dw", function()
    vim.wo.wrap = not vim.wo.wrap
    vim.notify("Wrap " .. (vim.wo.wrap and "Enabled" or "Disabled"), vim.log.levels.INFO)
end, { desc = "Wrap Line Toggle" })

-- etc
-- stylua: ignore start
set("n",        "<leader><leader>s", "<cmd>source<cr>", { desc = "Source" })
set({"n", "v"}, "<leader><leader>x", "<cmd>.lua<cr>",   { desc = "Execute current line" })
set("n", "<leader>rz", [[<cmd>s!\v(https://)?(www\.)?github.com/([^/]+/[^/]+).*!\3<cr><cmd>noh<cr>]], { desc = "Clean GitHub url for Lazy" })
set("n", "<leader>rg", [[<cmd>s!\v(https://)?(www\.)?(github\.com/[^/]+/[^/]+).*!\1\2\3!<cr><cmd>noh<cr>]], { desc = "Clean GitHub url" })
set("n", "<leader>rl", [[<cmd>s!\v(https://)?(www\.)?(leetcode\.com/problems/)([^/]+).*!\1\2\3\4!<cr><cmd>noh<cr>]], { desc = "Clean LeetCode url" })
-- stylua: ignore end

--- `<C-^>`, `<C-6>`, `:e #` work great, but two issues: (* means active buffer)
---    - open A, B, C* -> `:bwipe` (B*) -> trigger -> error
---    - open A, B, C* -> `:bdele` (B*) -> trigger -> re-opens C
---  Improved <C-^>:  (* means active buffer)
---    - open A, B, C* -> `:bwip` (B*) -> trigger (A*) -> trigger (B*)
---    - open A, B, C* -> `:bdel` (B*) -> trigger (C*) -> trigger (B*)
local function better_alt_buf()
    if vim.bo[0].buftype ~= "" then
        return
    end
    local success, _ = pcall(vim.cmd.e, "#")
    if success then
        return
    end
    local bufs = vim.tbl_filter(function(info)
        return vim.bo[info.bufnr].buftype == "" -- normal buffers only. :h buftype
    end, vim.fn.getbufinfo({ buflisted = 1 }))

    table.sort(bufs, function(a, b)
        return a.lastused > b.lastused
    end)
    if #bufs == 1 then
        vim.notify("No alternate buffer", vim.log.levels.WARN)
    else
        vim.api.nvim_win_set_buf(0, bufs[2].bufnr)
    end
end
set("n", "<C-t>", better_alt_buf, { desc = "Open alternate buffer" })

-- TODO: delete unnecessary buffers (noname, git, fugitive, etc)

local function remove_trailing_whitespace()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, cursor)
end
local function remove_eof_blanklines()
    local n_lines = vim.api.nvim_buf_line_count(0)
    local last_nonblank = vim.fn.prevnonblank(n_lines)
    if last_nonblank < n_lines then
        vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, {})
    end
end
local function remove_unnecessary_whitespace()
    remove_trailing_whitespace()
    remove_eof_blanklines()
end
set("n", "<leader>rw", remove_unnecessary_whitespace, { desc = "Remove unnecessary whitespace" })

-- stylua: ignore
set("n", "yA", "<cmd>%yank<cr>",   { desc = "Yank all" })
set("n", "dA", "<cmd>%delete<cr>", { desc = "Delete all" })

local function yank_location()
    local path = string.sub(vim.fn.expand("%:p"), #vim.fn.getcwd() + 2)
    local linenr = vim.api.nvim_win_get_cursor(0)[1]
    local location = string.format("%s:%d", path, linenr)
    vim.fn.setreg("+", location)
end
---@diagnostic disable-next-line: unused-local, unused-function
local function yank_location_and_line()
    local path = string.sub(vim.fn.expand("%:p"), #vim.fn.getcwd() + 2)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local cursor = string.format("%d:%d", row, col)
    local line = vim.trim(vim.api.nvim_get_current_line())
    vim.fn.setreg("+", path .. ":" .. cursor .. "\n" .. line)
end
set("n", "<leader>y", yank_location, { desc = "Yank current location" })
set("n", "<leader>Y", yank_location_and_line, { desc = "Yank current location and content" })

-- quickfix & loclist
local function close_qfloclist()
    local quicker = require("quicker")
    quicker.close()
    quicker.close({ loclist = true })
end
local function toggle_buffer_diagnostic()
    close_qfloclist()
    vim.diagnostic.setloclist({
        severity = { min = vim.diagnostic.severity.WARN },
        title = "Buffer Diagnostics",
        open = false,
    })
    require("quicker").open({ loclist = true })
    vim.cmd("cc")
end
local function toggle_workspace_diagnostic()
    close_qfloclist()
    vim.diagnostic.setqflist({
        severity = { min = vim.diagnostic.severity.WARN },
        title = "Workspace Diagnostics",
        open = false,
    })
    require("quicker").open()
    vim.cmd("cc")
end
local function toggle_hint_info_diagnostic()
    close_qfloclist()
    vim.diagnostic.setqflist({
        severity = { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT },
        title = "Hint & Info Diagnostics",
        open = false,
    })
    require("quicker").open()
    vim.cmd("cc")
end
set("n", "<leader>xx", toggle_workspace_diagnostic, { desc = "Workspace diagnostics" })
set("n", "<leader>xd", toggle_buffer_diagnostic, { desc = "Buffer diagnostics" })
set("n", "<leader>xh", toggle_hint_info_diagnostic, { desc = "Hint & Info diagnostics" })
set("n", "<leader>xc", close_qfloclist, { desc = "Close qfloclist" })
set("n", "<leader>xq", vim.cmd.copen, { desc = "Open qflist" })
set("n", "<leader>xl", vim.cmd.lopen, { desc = "Open loclist" })

local make_repeatable_move_pair = require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair
local function with_warning(cmd)
    return function()
        local ok, _ = pcall(cmd)
        if ok then
            vim.cmd("normal! zz")
        else
            vim.notify("No more items", vim.log.levels.INFO)
        end
    end
end
local cnext, cprev = make_repeatable_move_pair(with_warning(vim.cmd.cnext), with_warning(vim.cmd.cprevious))
local lnext, lprev = make_repeatable_move_pair(with_warning(vim.cmd.lnext), with_warning(vim.cmd.lprevious))
local function xnext()
    local quicker = require("quicker")
    if quicker.is_open() then -- qflist
        cnext()
    elseif quicker.is_open(0) then -- loclist
        lnext()
    end
end
local function xprev()
    local quicker = require("quicker")
    if quicker.is_open() then -- qflist
        cprev()
    elseif quicker.is_open(0) then -- loclist
        lprev()
    end
end
set("n", "]x", xnext, { desc = "Goto next qfloclist item" })
set("n", "[x", xprev, { desc = "Goto previous qfloclist item" })
set("n", "]q", cnext, { desc = "Goto next qflist" })
set("n", "[q", cprev, { desc = "Goto previous qflist" })
set("n", "]l", lnext, { desc = "Goto next loclist" })
set("n", "[l", lprev, { desc = "Goto previous loclist" })

-- Control + Enter
set("n", "<C-CR>", function()
    vim.notify("control enter pressed", vim.log.levels.ERROR)
end, { desc = "Control Enter" })
-- Shift + Enter  (refer to ghostty config)
set("n", "<ESC><CR>", function()
    vim.notify("shift enter pressed", vim.log.levels.ERROR)
end, { desc = "Shift Enter" })
set("n", "<Esc>'", function()
    vim.notify("control ' (esc') pressed", vim.log.levels.ERROR)
end)
set("n", "<Esc>;", function()
    vim.notify("control ; (esc;) pressed", vim.log.levels.ERROR)
end)
set("n", "<C-_>", function()
    vim.notify("control _ (ctrl /)pressed", vim.log.levels.ERROR)
end)

-- disable defaults
del("n", "grn")
del("n", "gra")
del("n", "grr")
del("n", "gri")
del("n", "grt")
del("n", "gO")
del("n", "[t")
del("n", "]t")
del("n", "[T")
del("n", "]T")
del("n", "[b")
del("n", "]b")
del("n", "[B")
del("n", "]B")
del("n", "[A")
del("n", "]A")
del("n", "[<C-q>")
del("n", "]<C-q>")
del("n", "[<C-l>")
del("n", "]<C-l>")
del("n", "[<C-t>")
del("n", "]<C-t>")
