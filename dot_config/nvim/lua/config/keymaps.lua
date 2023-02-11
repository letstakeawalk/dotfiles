local map = vim.keymap.set

--- General ------------------------------------
-- go to normal mode
map("i", "<C-d>", "<Esc>")
map("c", "<C-d>", "<Esc>")
-- better indenting
map("n", "<", "<h", { desc = "Indent -1 level" })
map("n", ">", ">l", { desc = "Indent +1 level" })
map("v", "<", "<gv")
map("v", ">", ">gv")
-- cursor navigation
map({ "i", "n", "c" }, "<A-Right>", "<C-Right>", { desc = "Next word" }) -- ^[f
map({ "i", "n", "c" }, "<A-Left>", "<C-Left>", { desc = "Prev word" }) -- ^[b
map("c", "<C-a>", "<Home>") -- move cursor to BOL
map("c", "<C-e>", "<End>") -- move cursor to EOL
map({ "i", "c" }, "<A-BS>", "<C-w>") -- delete word
map("n", "ge", "gi", { desc = "Last edited position" }) -- go to last INSERT pos and insert
map("n", "G", "Gzz", { desc = "Goto last line" }) -- jump to eof center cursor
-- buffers and tabs navigation
map("n", "<Home>", ":tabnext<cr>", { desc = "Prev tab" })
map("n", "<End>", ":tabprev<cr>", { desc = "Next tab" })
map("n", "<PageUp>", ":bnext<cr>", { desc = "Next buffer" })
map("n", "<PageDown>", ":bprev<cr>", { desc = "Prev buffer" })
map("n", "<C-t>", "<C-^>", { desc = "Edit prev edited file" })
-- buffer management
map("n", "<C-s>", ":w<cr>", { desc = "Write buffer" }) -- save current buffer
map("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit buffer" })
map("n", "<leader>qn", "<cmd>enew<cr>", { desc = "New File" })
-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
-- etc
map("n", "'", "`") -- better mark navigation
map("n", "<leader>ss", "<cmd>so %<cr>", { desc = "Source buffer" })
map("n", "<leader>sk", function() require(vim.fn.stdpath("config") .. "/lua/config/keymaps.lua") end, { desc = "Source keymap" })
map("s", "<BS>", "<BS>i") -- delete selection and stay in INSERT
map("n", "J", "mzJ`z", { desc = "Join lines" }) -- join lines while preserving cursor pos
map("x", "p", '"_dP') -- "greatest remap ever" by theprimeage (keep copied text in register w/o overriding)
map("i", "<C-f>", "<Del>") -- delete char
-- map("n", "<leader>S", ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Substitude word under cursor" }) -- substitute word under cursor
map("n", "<leader>xX", "<cmd>!chmod +x %<cr>", { silent = true, desc = "chmod +x" })
map("n", "<leader>rz", "<cmd>s!\\(https://\\)\\?\\(www.\\)\\?github.com/\\(.*\\)!\\3<cr>", { desc = "Clean gh url" }) -- remove github prefix
map("n", "gcy", "yygcc")
-- TODO: refer to comment.nvim and treesitter / use <C-_> instead
-- map("i", "<C-x>", "<esc>gcci<tab>")
-- map("i", "<C-l>", "<esc>gcccc", { desc = "Toggle comment" })
-- map({ "n", "x" }, "<leader>rC", "<cmd>s!\\<.!\\u&!g<cr>", { desc = "Caplitalize words" })

--- Colemak-dhm --------------------------------
-- navigate cursor
map("n", "k", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map("n", "h", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("x", "k", "j") -- visual mode
map("x", "h", "k") -- visual mode
map("n", "j", "h")
map("x", "j", "h")
map("n", "gk", "gj", { desc = "down" })
map("n", "gh", "gk", { desc = "up" })
-- navigate split panes
map("n", "<c-w>k", "<c-w>j", { desc = "Goto left pane" })
map("n", "<c-w>h", "<c-w>k", { desc = "Goto bottom pane" })
map("n", "<c-w>j", "<c-w>h", { desc = "Goto top pane" })
-- move/swap pane position
map("n", "<c-w>K", "<c-w>J", { desc = "Move pane to down" })
map("n", "<c-w>H", "<c-w>K", { desc = "Move pane to up" })
map("n", "<c-w>J", "<c-w>H", { desc = "Move pane to left" })
-- move lines up/down using Alt + <kh>
map("n", "<A-down>", ":m .+1<CR>==")
map("n", "<A-up>", ":m .-2<CR>==")
map("i", "<A-down>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-up>", "<Esc>:m .-2<CR>==gi")
map("v", "<A-down>", ":m '>+1<CR>gv=gv")
map("v", "<A-up>", ":m '<-2<CR>gv=gv")
map("n", "<A-k>", ":m .+1<CR>==")
map("n", "<A-h>", ":m .-2<CR>==")
map("i", "<A-k>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-h>", "<Esc>:m .-2<CR>==gi")
map("v", "<A-k>", ":m '>+1<CR>gv=gv")
map("v", "<A-h>", ":m '<-2<CR>gv=gv")

map("n", "<leader>dm", "<cmd>message<cr>", { desc = "Messages" })

--- Functions ------------------------------------
-- remove whitespace
-- stylua: ignore
map("n", "<leader>rw", [[
:let _save_pos=getpos(".") <Bar>
      \ :let _s=@/ <Bar>
      \ :%s/\s\+$//e <Bar>
      \ :let @/=_s <Bar>
      \ :nohl <Bar>
      \ :unlet _s<Bar>
      \ :call setpos('.', _save_pos)<Bar>
      \ :unlet _save_pos<CR>
]])

-- unimpaired
local function add_blank_line(line)
  vim.api.nvim_buf_set_lines(0, line, line, true, { "" })
end

local function add_blank_line_above()
  add_blank_line(vim.fn.line(".") - 1)
end

local function add_blank_line_below()
  add_blank_line(vim.fn.line("."))
end

map("n", "]<Space>", add_blank_line_below, { desc = "Add line below" })
map("n", "[<Space>", add_blank_line_above, { desc = "Add line above" })

-- python 3.10+ syntax
local function future_typing()
  vim.cmd([[%s!from typing import Optional!!ge]])
  -- vim.cmd([[%s!\(\?<=from typing import \)Optional,\? \?!!e]])
  -- vim.cmd([[%s!(from typing import) Optional,+ +(\w+)*!(\1) (\2)!ge]])
  vim.cmd([[%s!Optional\[\(\w*\)\]!\1 | None!ge]])
  vim.cmd([[%s!List\[List\[\(\w*\)\]\]!list\[list\[\1\]\]!ge]])
  vim.cmd([[%s!List\[\(\w*\)\]!list\[\1\]!ge]])
end

vim.api.nvim_create_user_command("PyFutureTyping", future_typing, {})

-- local function copy_path_to_file()
-- 	local path = vim.fn.expand("%:p")
-- 	print(path)
-- 	-- TODO copy path to clipboard
-- 	-- io.popen("pbcopy", "w"):write(path):close()
-- end
