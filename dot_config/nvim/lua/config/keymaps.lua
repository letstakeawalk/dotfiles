local set = vim.keymap.set

--[[
TODO: refactor all keymaps. Consider moving this function to utils
---@param lhs string
---@param rhs string | function
---@param modes ("i"|"n"|"c"|"v"|"x"|"s"|"o"|"t")[]
---@param opts { desc: string, silent: boolean, expr: boolean }
local function set(lhs, rhs, modes, opts) end
]]

--- General ------------------------------------
-- stylua: ignore start
-- go to normal mode (refer to better-escape)
set("i", "<C-c>", "<Esc>")
set("i", "<Esc>", "<Nop>")
set("n", "<Esc>", "<cmd>noh<cr>", { desc = "Clear highlights" })
set("n", "<C-c>", "<cmd>noh<cr>", { desc = "Clear highlights" })
-- cursor navigation
set("n", "k",  "v:count == 0 ? 'gj' : 'j'",      { desc = "Down",  silent = true, expr = true })
set("n", "h",  "v:count == 0 ? 'gk' : 'k'",      { desc = "Up",    silent = true, expr = true })
set("n", "gk", "gj",                             { desc = "Down" })
set("n", "gh", "gk",                             { desc = "Up" })
set("n", "j",  "h",                              { desc = "Left",  silent = true })
set("n", "l",  "l",                              { desc = "Right", silent = true })
set("x", "k",  "j",                              { desc = "Down",  silent = true })
set("x", "h",  "k",                              { desc = "Up",    silent = true })
set("x", "j",  "h",                              { desc = "Left",  silent = true })
set("x", "l",  "l",                              { desc = "Right", silent = true })
set({ "i", "n", "c" }, "<A-Right>", "<C-Right>", { desc = "Next word" }) -- ^[f
set({ "i", "n", "c" }, "<A-Left>",  "<C-Left>",  { desc = "Prev word" }) -- ^[b
set({ "i", "n", "c" }, "<A-f>",     "<C-Right>", { desc = "Next word" }) -- ^[f
set({ "i", "n", "c" }, "<A-b>",     "<C-Left>",  { desc = "Prev word" }) -- ^[b
set("c", "<C-a>", "<Home>",                      { desc = "BOL" })
set("c", "<C-e>", "<End>",                       { desc = "EOL" })
set("n", "ge", "gi",                             { desc = "Last edited position" }) -- go to last INSERT pos and insert
set("n", "gg", "gg",                             { desc = "Goto first line" }) -- jump to bof, center cursor
set("n", "G",  "Gzz",                            { desc = "Goto last line" })  -- jump to eof, center cursor
set("n", "zz", "zz",                             { desc = "Center Current Line" })
set("n", "gj", "zH",                             { desc = "Scroll Left",  silent = true })
set("n", "zj", "zH",                             { desc = "Scroll Left",  silent = true })
set("n", "zJ", "zH",                             { desc = "Scroll Left",  silent = true })
set("n", "zs", "zH",                             { desc = "Scroll Left",  silent = true })
set("n", "gl", "zL",                             { desc = "Scroll Right", silent = true })
set("n", "zl", "zL",                             { desc = "Scroll Right", silent = true })
set("n", "zL", "zL",                             { desc = "Scroll Right", silent = true })
set("n", "ze", "zL",                             { desc = "Scroll Right", silent = true })
set("n", "}",  "}zz",                            { desc = "Next Paragraph", silent = true })
set("n", "{",  "{zz",                            { desc = "Prev Paragraph", silent = true })
set("n", "<C-d>",      "<C-d>zz",                { desc = "Scroll down" })
set("n", "<C-u>",      "<C-u>zz",                { desc = "Scroll up" })
set("n", "<PageDown>", "<C-d>zz",                { desc = "Scroll down" })
set("n", "<PageUp>",   "<C-u>zz",                { desc = "Scroll up" })
set("n", "<C-e>",      "10<C-e>",                { desc = "Scroll down" })
set("n", "<C-y>",      "10<C-y>",                { desc = "Scroll up" })
-- buffer/tab/window navigation/management
set("n", "<C-t>", function() -- better buffer switching
    local success, _ = pcall(vim.cmd.e, "#") -- ":e #" == <C-^> (# := alternate buffer register)
    if not success then
        ---@diagnostic disable-next-line: param-type-mismatch
        local bufs = vim.tbl_filter(function(b) return b.listed == 1 end, vim.fn.getbufinfo())
        table.sort(bufs, function(a, b) return a.lastused > b.lastused end)
        if #bufs == 1 then
            vim.notify("No alternate file exists", vim.log.levels.WARN)
        else
            vim.api.nvim_win_set_buf(0, bufs[2].bufnr)
        end
    end
    --- `<C-^>`, `<C-6>`, `:e #` work great, but two issues: (* means active buffer)
    ---    - open A, B, C* -> `:bwipe` (B*) -> trigger -> error
    ---    - open A, B, C* -> `:bdelete` (B*) -> trigger -> re-opens C
    ---  Improved <C-^>:  (* means active buffer)
    ---    - open A, B, C* -> `:bwipe` (B*) -> trigger (A*) -> trigger (B*)
    ---    - open A, B, C* -> `:bdelete B` (B*) -> trigger (C*) -> trigger (B*)
end, { desc = "Open recently edited buffer" })
set("n", "<C-s>",      "<cmd>silent w<cr>",           { desc = "Write buffer"  })
set("n", "<C-q>",      "<cmd>q<cr>",                  { desc = "Quit buffer" })
set("n", "<leader>qn", "<cmd>enew<cr>",               { desc = "New File" })
set("n", "<C-Up>",     "<cmd>resize +2<cr>",          { desc = "Increase window height" })
set("n", "<C-Down>",   "<cmd>resize -2<cr>",          { desc = "Decrease window height" })
set("n", "<C-Left>",   "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
set("n", "<C-Right>",  "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
set("n", "<c-w>k",     "<c-w>j",                      { desc = "Goto bottom pane" })
set("n", "<c-w>h",     "<c-w>k",                      { desc = "Goto top pane" })
set("n", "<c-w>j",     "<c-w>h",                      { desc = "Goto left pane" })
set("n", "<c-w>l",     "<c-w>l",                      { desc = "Goto right pane" })
set("n", "<c-w>K",     "<c-w>J",                      { desc = "Move pane to down" })
set("n", "<c-w>H",     "<c-w>K",                      { desc = "Move pane to up" })
set("n", "<c-w>J",     "<c-w>H",                      { desc = "Move pane to left" })
set("n", "<c-w>L",     "<c-w>L",                      { desc = "Move pane to right" })
-- Editing
set("i", "<C-d>", "<C-d>", { desc = "Indent -1 level" })
set("i", "<C-v>", "<C-t>", { desc = "Indent +1 level" })
set("n", "<<", "<h",       { desc = "Indent -1 level" })
set("n", ">>", ">l",       { desc = "Indent +1 level" })
set("v", "<", "<gv",       { desc = "Indent -1 level" })
set("v", ">", ">gv",       { desc = "Indent +1 level" })
set("i", ",", ",<c-g>u")  -- add undo break-points
set("i", ".", ".<c-g>u")  -- add undo break-points
set("i", ";", ";<c-g>u")  -- add undo break-points
set("s", "<BS>", "<BS>i")            -- delete selection and stay in INSERT
set({ "i", "c" }, "<A-BS>", "<C-w>") -- delete word
set("n", "J", "mzJ`z", { desc = "Join lines" }) -- join lines while preservig cursor pos
set("x", "p", '"_dP') -- keep copied text in register w/o overriding when pasting/replacing -- "greatest remap ever" by theprimeage
set("n", "<A-down>", ":m .+1<CR>==",        { desc = "Move line below" })
set("n", "<A-up>",   ":m .-2<CR>==",        { desc = "Move line up" })
set("i", "<A-down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line below" })
set("i", "<A-up>",   "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
set("v", "<A-down>", ":m '>+1<CR>gv=gv",    { desc = "Move line below" })
set("v", "<A-up>",   ":m '<-2<CR>gv=gv",    { desc = "Move line up" })
set("n", "<A-k>",    ":m .+1<CR>==",        { desc = "Move line below" })
set("n", "<A-h>",    ":m .-2<CR>==",        { desc = "Move line up" })
set("i", "<A-k>",    "<Esc>:m .+1<CR>==gi", { desc = "Move line below" })
set("i", "<A-h>",    "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
set("v", "<A-k>",    ":m '>+1<CR>gv=gv",    { desc = "Move line below" })
set("v", "<A-h>",    ":m '<-2<CR>gv=gv",    { desc = "Move line up" })
-- Command mode
set("c", "<S-Down>", "<Down>", {desc = "Recent command-line"})
set("c", "<S-Up>",   "<Up>",   {desc = "Older command-line"})
-- Display/Toggle: <leader>d
set("n", "<leader>dm", "<cmd>message<cr>",         { desc = "Messages" })
set("n", "<leader>dM", "<cmd>Redir message<cr>",   { desc = "Redir Messages" })
set("n", "<leader>dC", "<cmd>set cmdheight=3<cr>", { desc = "Cmdline" })
set("n", "<leader>ds", function() vim.wo.spell = not vim.wo.spell; vim.notify("Spelling ".. (vim.wo.spell and "Enabled" or "Disabled")) end, { desc = "Spelling Toggle" })
set("n", "<leader>dw", function() vim.wo.wrap = not vim.wo.wrap; vim.notify("Wrap " .. (vim.wo.wrap and "Enabled" or "Disabled")) end,   { desc = "Wrap Line Toggle" })
set("n", "<leader>dW", function() if string.find(vim.bo.formatoptions, "t") then vim.bo.formatoptions = string.gsub(vim.bo.formatoptions, "t", ""); print("Text AutoWrap Disabled") else vim.bo.formatoptions = vim.bo.formatoptions .. "t"; print("Text AutoWrap Enabled") end end, {desc = "Text AutoWrap Toggle"})
-- etc
set("n", "'", "`") -- better mark navigation
set("n", "<leader>Cx", "<cmd>!chmod +x %<cr>", { silent = true, desc = "chmod +x" })
set("n", "<leader>Sb", "<cmd>so %<cr>",        { desc = "Source buffer" })
set("n", "<leader>Sk", function() require(vim.fn.stdpath("config") .. "/lua/config/keymaps.lua") end, { desc = "Source keymap" })
-- Refactor/Replace: <leader>r
set("n", "<leader>rz", [[<cmd>s!\v(https://)?(www\.)?github.com/([^/]+/[^/]+).*!\3<cr><cmd>noh<cr>]], { desc = "Clean GitHub url for Lazy" })
set("n", "<leader>rg", [[<cmd>s!\v(https://)?(www\.)?(github\.com/[^/]+/[^/]+).*!\1\2\3!<cr><cmd>noh<cr>]], { desc = "Clean GitHub url" })
set("n", "<leader>rl", [[<cmd>s!\v(https://)?(www\.)?(leetcode\.com/problems/)([^/]+).*!\1\2\3\4!<cr><cmd>noh<cr>]], { desc = "Clean Leetcode url" })
-- stylua: ignore end

--- Functions ------------------------------------
-- TODO: make this work -- if in comment, turn on 'c' flag for formatoptions
local function comment_continuation()
    vim.print("shift enter triggered")
    local line = vim.api.nvim_get_current_line()
    local ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
    print("ft:", ft)
    local commentstring = require("Comment.ft").get(ft, require("Comment.utils").ctype.linewise)
    print("cstring:", commentstring)
    if string.match(line, ".-" .. commentstring .. ".-$") then
        print("in comment")
        require("Comment.api").insert.linewise.below()
        vim.api.nvim_input("<BS> ") -- for some resaon, above cmd inserts `a` after the comment string
    else -- not in comment
        print("not in comment")
        vim.api.nvim_input("<CR>")
    end
end
set("i", "<S-cr>", comment_continuation, { desc = "Continue with comments" })

-- remove whitespace
set("n", "<leader>rw", function()
    local curpos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[keeppatterns %s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, curpos)
end, { desc = "Remove trailing whitespace" })

-- yank/delete contents of current buffer
set("n", "yA", "<cmd>%yank<cr>", { desc = "Yank file content" })
set("n", "dA", "<cmd>%del<cr>", { desc = "Delete file content" })

-- unimpaired
local function add_blank_line(line)
    vim.api.nvim_buf_set_lines(0, line, line, false, { "" })
end
local function add_blank_line_above()
    add_blank_line(vim.fn.line(".") - 1)
end
local function add_blank_line_below()
    add_blank_line(vim.fn.line("."))
end
set("n", "]<Space>", add_blank_line_below, { desc = "Add line below" })
set("n", "[<Space>", add_blank_line_above, { desc = "Add line above" })
set("n", "]q", "<cmd>cnext<cr>", { desc = "Goto next quickfix" })
set("n", "[q", "<cmd>cprev<cr>", { desc = "Goto previous quickfix" })
