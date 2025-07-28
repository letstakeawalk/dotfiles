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
set({ "i", "n", "c" }, "<A-f>", "<C-Right>", { desc = "Next word" }) -- ^[f
set({ "i", "n", "c" }, "<A-b>", "<C-Left>",  { desc = "Prev word" }) -- ^[b
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
set("n", "z0", "zM",       { desc = "Fold level: 0" })
set("n", "z1", "zMzr",     { desc = "Fold level: 1" })
set("n", "z2", "zM2zr",    { desc = "Fold level: 2" })
set("n", "z3", "zM3zr",    { desc = "Fold level: 3" })
set("n", "z4", "zM4zr",    { desc = "Fold level: 4" })
set("n", "z5", "zM5zr",    { desc = "Fold level: 5" })
set("n", "zv", "zMzvzczO", { desc = "Open enough fold" })

-- Editing
set("i", "<C-d>", "<C-d>", { desc = "Indent -1 level" })
set("i", "<C-t>", "<C-t>", { desc = "Indent +1 level" })
set("i", "<C-v>", "<C-t>", { desc = "Indent +1 level" })
set("n", "<<", "<h",       { desc = "Indent -1 level" })
set("n", ">>", ">l",       { desc = "Indent +1 level" })
set("v", "<", "<gv",       { desc = "Indent -1 level" })
set("v", ">", ">gv",       { desc = "Indent +1 level" })
set("i", ",", ",<c-g>u")  -- add undo break-points
set("i", ".", ".<c-g>u")  -- add undo break-points
set("i", ";", ";<c-g>u")  -- add undo break-points
set("s",          "<BS>",   "<BS>i") -- delete selection and stay in INSERT
set({ "i", "c" }, "<A-BS>", "<C-w>") -- delete word
set("n", "J", "mzJ`z", { desc = "Join lines" }) -- join lines while preservig cursor pos
set("x", "p", '"_dP') -- keep copied text in register w/o overriding when pasting/replacing -- "greatest remap ever" by theprimeage
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

-- Display/Toggle: <leader>d
set("n", "<leader>dm", "<cmd>message<cr>",         { desc = "Messages" })
set("n", "<leader>dM", "<cmd>Redir message<cr>",   { desc = "Redir Messages" })
set("n", "<leader>dn", function() vim.wo.relativenumber = not vim.wo.relativenumber; vim.wo.number = not vim.wo.number; end,   { desc = "Display numbers" })
set("n", "<leader>dc", function() vim.wo.conceallevel = vim.wo.conceallevel == 0 and 2 or 0; vim.notify("Conceal ".. (vim.wo.conceallevel == 2 and "Enabled" or "Disabled")) end, { desc = "Conceal Toggle" })
set("n", "<leader>ds", function() vim.wo.spell = not vim.wo.spell; vim.notify("Spelling ".. (vim.wo.spell and "Enabled" or "Disabled")) end,                                                                                                                                         { desc = "Spelling Toggle" })
set("n", "<leader>dw", function() vim.wo.wrap = not vim.wo.wrap; vim.notify("Wrap " .. (vim.wo.wrap and "Enabled" or "Disabled")) end,                                                                                                                                               { desc = "Wrap Line Toggle" })

-- etc
set("n",        "<leader><leader>s", "<cmd>source<cr>", { desc = "Source" })
set({"n", "v"}, "<leader><leader>x", "<cmd>.lua<cr>",   { desc = "Execute current line" })
set("n", "<leader>rz", [[<cmd>s!\v(https://)?(www\.)?github.com/([^/]+/[^/]+).*!\3<cr><cmd>noh<cr>]], { desc = "Clean GitHub url for Lazy" })
set("n", "<leader>rg", [[<cmd>s!\v(https://)?(www\.)?(github\.com/[^/]+/[^/]+).*!\1\2\3!<cr><cmd>noh<cr>]], { desc = "Clean GitHub url" })
set("n", "<leader>rl", [[<cmd>s!\v(https://)?(www\.)?(leetcode\.com/problems/)([^/]+).*!\1\2\3\4!<cr><cmd>noh<cr>]], { desc = "Clean Leetcode url" })
-- stylua: ignore end

--- `<C-^>`, `<C-6>`, `:e #` work great, but two issues: (* means active buffer)
---    - open A, B, C* -> `:bwipe` (B*) -> trigger -> error
---    - open A, B, C* -> `:bdele` (B*) -> trigger -> re-opens C
---  Improved <C-^>:  (* means active buffer)
---    - open A, B, C* -> `:bwip` (B*) -> trigger (A*) -> trigger (B*)
---    - open A, B, C* -> `:bdel` (B*) -> trigger (C*) -> trigger (B*)
local function better_alt_buf()
    local success, _ = pcall(vim.cmd.e, "#")
    if success then
        return
    end
    local bufs = vim.fn.getbufinfo({ buflisted = 1 })
    table.sort(bufs, function(a, b)
        return a.lastused > b.lastused
    end)
    if #bufs == 1 then
        vim.notify("No alternate buffer", 3)
    else
        vim.api.nvim_win_set_buf(0, bufs[2].bufnr)
    end
end
set("n", "<C-t>", better_alt_buf, { desc = "Open alternate buffer" })

local function remove_trailing_whitespace()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, cursor)
end
local function remove_trailing_blanklines()
    local n_lines = vim.api.nvim_buf_line_count(0)
    local last_nonblank = vim.fn.prevnonblank(n_lines)
    if last_nonblank < n_lines then
        vim.api.nvim_buf_set_lines(0, last_nonblank, n_lines, true, {})
    end
end
local function trailspace()
    remove_trailing_whitespace()
    remove_trailing_blanklines()
end
set("n", "<leader>rw", trailspace, { desc = "Remove trailing whitespace" })

-- stylua: ignore
set("n", "yA", "<cmd>%yank<cr>",   { desc = "Yank all" })
set("n", "dA", "<cmd>%delete<cr>", { desc = "Delete all" })

---@param above boolean
local function add_blank_line(above)
    local lnum = unpack(vim.api.nvim_win_get_cursor(0))
    if above then
        vim.api.nvim_buf_set_lines(0, lnum - 1, lnum - 1, false, { "" })
    else
        vim.api.nvim_buf_set_lines(0, lnum, lnum, false, { "" })
    end
end
---@diagnostic disable-next-line: unused-local, unused-function
local function move_cursor_and_insert(above)
    local lnum = unpack(vim.api.nvim_win_get_cursor(0))
    if above then
        vim.api.nvim_win_set_cursor(0, { lnum - 1, 0 })
    else
        vim.api.nvim_win_set_cursor(0, { lnum + 1, 0 })
    end
    vim.cmd.startinsert()
end
-- stylua: ignore start
set("n", "[<Space>", function() add_blank_line(true)  end, { desc = "Add blank line above" })
set("n", "]<Space>", function() add_blank_line(false) end, { desc = "Add blank line below" })
-- set("n", "[i", function() add_blank_line(true);  move_cursor_and_insert(true);  end, { desc = "Add blank line above and insert" })
-- set("n", "]i", function() add_blank_line(false); move_cursor_and_insert(false); end, { desc = "Add blank line above and insert" })

-- stylua: ignore end

local function yank_location()
    local path = string.sub(vim.fn.expand("%:p"), #vim.fn.getcwd() + 2)
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local cursor = string.format("%d:%d", row, col)
    local line = vim.trim(vim.api.nvim_get_current_line())
    vim.fn.setreg("+", path .. ":" .. cursor .. "\n" .. line)
end
set("n", "<leader>y", yank_location, { desc = "Yank current location" })

-- disable defaults
del("n", "grn")
del("n", "gra")
del("n", "grr")
del("n", "gri")
del("n", "gO")

-- TODO
-- local function better_yank()
--     local cursor = vim.api.nvim_win_get_cursor(0)
-- end
