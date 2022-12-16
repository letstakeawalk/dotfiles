local map = vim.keymap.set
local unmap = vim.keymap.del
local opts = function(desc)
	return { noremap = true, silent = true, desc = desc }
end

--- General ------------------------------------
-- go to normal mode
map("i", "<C-d>", "<Esc>")
map("c", "<C-d>", "<Esc>")
-- better indenting
map("n", "<", "<h")
map("n", ">", ">l")
map("v", "<", "<gv")
map("v", ">", ">gv")
-- cursor navigation
map("n", "<CR>", "<Down>A") -- start editing next line
map({ "i", "n", "c" }, "<A-Right>", "<C-Right>") -- move cursor one word to the left  -- ^[f
map({ "i", "n", "c" }, "<A-Left>", "<C-Left>") -- move cursor one word to the left -- ^[b
map("c", "<C-a>", "<Home>") -- move cursor to BOL
map("c", "<C-e>", "<End>") -- move cursor to EOL
map({ "i", "c" }, "<A-BS>", "<C-w>") -- delete word
map("n", "ge", "gi") -- go to last INSERT pos and insert
map("n", "G", "Gzz") -- jump to eof center cursor
-- buffers and tab navigation
map("n", "<Home>", ":tabnext<cr>")
map("n", "<End>", ":tabprev<cr>")
map("n", "<PageUp>", ":bnext<cr>")
map("n", "<PageDown>", ":bprev<cr>")
map("n", "<C-t>", "<C-^>") -- toggle between two files
-- buffer management
map("n", "<C-s>", ":w<cr>", opts("Write buffer")) -- save current buffer
map("n", "<C-q>", ":q<cr>", opts("Quit buffer")) -- quit current buffer
map("n", "<C-q><C-a>", ":bufdo bd<cr>", opts("Close all buffers")) -- delete all buffers
map("n", "<C-q><C-q>", ":Bclose<cr>", opts("Close buffer")) -- delete current buffer (maintains pane layout)
map("n", "<C-q><C-q><C-q>", ":Bclose<cr>:q", opts("Close buffer and pane")) -- delete current buffer (closes current buffer)
-- etc
map("n", "'", "`") -- better mark navigation
map("n", "<leader>Ss", "<cmd>so %<cr>", opts("Source buffer"))
map("n", "<leader>Sk", "<cmd>so ~/.config/nvim/lua/HRB/keymaps.lua<cr>", opts("Source keymap"))
map("s", "<BS>", "<BS>i") -- delete selection and stay in INSERT
map("n", "J", "mzJ`z", opts("Join lines")) -- join lines while preserving cursor pos
map("x", "p", '"_dP') -- "greatest remap ever" by theprimeage
map("n", "Q", "<nop>") -- disable
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts("Substitude word under cursor")) -- substitute word under cursor
map("n", "<leader>xX", "<cmd>!chmod +x %<cr>", { silent = true, desc = "chmod +x" })
-- disable warning
map("n", "<C-w><C-w>", function()
	vim.api.nvim_notify("Use <C-s> instead", 3, {})
end, opts("Write buffer")) -- save current buffer
-- map({ "i" }, "<Esc>", function()
-- 	vim.api.nvim_notify("Use <C-c> instead", 3, {})
-- end)

--- Colemak-dhm --------------------------------
-- navigate cursor
map("n", "k", "j")
map("x", "k", "j")
map("n", "h", "k")
map("x", "h", "k")
map("n", "j", "h")
map("x", "j", "h")
map("n", "gk", "gj", opts("downw"))
map("n", "gh", "gk", opts("up"))
-- navigate split panes
map("n", "<c-w>k", "<c-w>j", opts("Goto left pane"))
map("n", "<c-w>h", "<c-w>k", opts("Goto bottom pane"))
map("n", "<c-w>j", "<c-w>h", opts("Goto top pane"))
-- move/swap pane position
map("n", "<c-w>K", "<c-w>J", opts("Move pane to down"))
map("n", "<c-w>H", "<c-w>K", opts("Move pane to up"))
map("n", "<c-w>J", "<c-w>H", opts("Move pane to left"))
-- move lines up/down using Alt + <kh>
map("n", "<A-k>", ":m .+1<CR>==")
map("n", "<A-h>", ":m .-2<CR>==")
map("i", "<A-k>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-h>", "<Esc>:m .-2<CR>==gi")
map("v", "<A-k>", ":m '>+1<CR>gv=gv")
map("v", "<A-h>", ":m '<-2<CR>gv=gv")

--- Custom ---------------------------------------
map("n", "<leader>de", vim.diagnostic.enable, { silent = true, desc = "Show diagnostic" })
map("n", "<leader>dd", vim.diagnostic.disable, { silent = true, desc = "Hide diagnostic" })

--- Disable --------------------------------------

--- Functions ------------------------------------
-- remove whitespace
-- TODO redo with nvim_win_get_cursor(0)
vim.cmd([[
  nnoremap <leader>rw :let _save_pos=getpos(".") <Bar>
      \ :let _s=@/ <Bar>
      \ :%s/\s\+$//e <Bar>
      \ :let @/=_s <Bar>
      \ :nohl <Bar>
      \ :unlet _s<Bar>
      \ :call setpos('.', _save_pos)<Bar>
      \ :unlet _save_pos<CR>
]])

-- unimpaired
local function paste_blank_line(line)
	vim.api.nvim_buf_set_lines(0, line, line, true, { "" })
end

local function paste_blank_line_above()
	paste_blank_line(vim.fn.line(".") - 1)
end

local function paste_blank_line_below()
	paste_blank_line(vim.fn.line("."))
end

map("n", "]<Space>", paste_blank_line_below)
map("n", "[<Space>", paste_blank_line_above)

local function future_typing()
	vim.cmd([[%s!from typing import Optional!!ge]])
	-- vim.cmd([[%s!\(\?<=from typing import \)Optional,\? \?!!e]])
	-- vim.cmd([[%s!(from typing import) Optional,+ +(\w+)*!(\1) (\2)!ge]])
	vim.cmd([[%s!Optional\[\(\w*\)\]!\1 | None!ge]])
	vim.cmd([[%s!List\[List\[\(\w*\)\]\]!list\[list\[\1\]\]!ge]])
	vim.cmd([[%s!List\[\(\w*\)\]!list\[\1\]!ge]])
end

vim.api.nvim_create_user_command("PyFutureTyping", future_typing, {})

local function copy_path_to_file()
	local path = vim.fn.expand("%:p")
	print(path)
	-- TODO copy path to clipboard
	-- io.popen("pbcopy", "w"):write(path):close()
end
