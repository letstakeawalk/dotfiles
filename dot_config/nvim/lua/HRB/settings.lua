-- general config
local cmd = vim.cmd
local opt = vim.opt

-- disable netrw at the very start of your init.lua -- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.python3_host_prog = "/opt/homebrew/bin/python3.11"

cmd.syntax("on")
opt.ruler = true -- display current line
opt.cursorline = true -- Higlight current line
opt.number = true -- show line numbers
opt.numberwidth = 4 -- gutter size
opt.relativenumber = true -- number relatively
opt.showcmd = true -- display incomplete commands
opt.cmdheight = 3 -- height of the command line
opt.pumheight = 10 -- height of popup menu
opt.colorcolumn = "88" -- Column hightlight at textwidth
opt.textwidth = 88 -- textwidth
opt.showtabline = 1 -- display tab-line only if there are at least two tabs
opt.laststatus = 3 -- always show statusline
opt.showmode = false -- do not display vim-mode on message
opt.wrap = false -- No wrap by default
opt.diffopt = { "filler", "iwhite" } -- Diff mode: show fillers, ignore whitepsace
opt.backspace = { "indent", "eol", "start" } -- Intuitive backspacing in insert mode
opt.encoding = "utf-8" -- encoding
opt.fileencoding = "utf-8" -- encoding
opt.fileformats = { "unix", "mac", "dos" } -- Use Unix as the standard file type
opt.formatoptions = { q = true, j = true, ["1"] = true } -- default tcqj
opt.iskeyword:append({ "-" }) -- treat dash separated words as a word text object
opt.splitright = true -- always open vertical split right
opt.splitbelow = true -- always open horizontal split below
opt.lazyredraw = true -- do not redraw screen in the middle of a macro. Makes them complete faster
opt.confirm = true -- confirm operations
opt.hidden = true -- hide buffers when abandoned instead of unload
opt.magic = true -- For regular expressions turn magic on
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
opt.undofile = true -- persistent undo
opt.swapfile = false -- swap file
opt.backup = false -- backup
opt.shortmess:append({ c = true })
opt.history = 2000 -- num history to cache
opt.timeoutlen = 300 -- used to be 500
opt.updatetime = 50 -- for CursorHold aucmd 
opt.scrolloff = 8 -- no line to keep above/below the cursor
-- opt.completeopt    = { 'menu', 'menuone', 'noselect', 'preview' } -- nvim-cmp handles. no need here?

-- fold
opt.foldcolumn = "0"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99

-- search
opt.ignorecase = true -- Search case-insensitive
opt.incsearch = true -- Incremental search
opt.hlsearch = true -- highlight matching words
opt.smartcase = true -- Keep case when searching with

-- tabs and indents
opt.autoindent = true -- Use same indenting on new lines
opt.expandtab = true -- expand tabs into spaces
opt.shiftround = true -- Round indent to multiple of 'shiftwidth'
opt.shiftwidth = 2 -- Number of spaces to use in auto(indent)
opt.smartindent = true -- Smart audoindenting on new lines
opt.smarttab = true -- Tab insert blanks according to 'shiftwidth'
opt.softtabstop = 2 -- backspace remove backspace
opt.tabstop = 2 -- tabsize = 2 whitespaces

-- abbrs
vim.cmd.iabbr("NOne", "None")
vim.cmd.iabbr("STring", "String")

-- auto commands -- CHECK TJ's vid to make sure below is right
local tabsize_four = function()
	vim.api.nvim_buf_set_option(0, "tabstop", 4)
	vim.opt_local.tabstop = 4
	vim.opt_local.softtabstop = 4
	vim.opt_local.shiftwidth = 4
end
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = vim.api.nvim_create_augroup("TabsizeFour", {}),
	pattern = { "python", "rust", "c", "cpp"},
	callback = tabsize_four,
})

-- mouse support
if vim.fn.has("mouse") == 1 then
	opt.mouse = {
		v = true,
		n = true, --[[h = true,]]
	}
end
-- clipboard
if vim.fn.has("clipboard") == 1 then
	opt.clipboard = { "unnamed" }
end
if vim.fn.has("unnamedplus") == 1 then
	opt.clipboard:append({ "unnamedplus" })
end

-- chezmoi auto apply
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	group = vim.api.nvim_create_augroup("ChezmoiChange", {}),
	pattern = { vim.env.XDG_DATA_HOME .. "/chezmoi/*" },
	callback = function(args)
		if args.file:match("COMMIT_EDITMSG") == nil then
			vim.cmd([[!chezmoi apply --source-path "%"]])
		end
	end,
})

-- chezmoi respective filetype
vim.api.nvim_create_autocmd({ "BufEnter" }, {
	group = vim.api.nvim_create_augroup("ChezmoiZshrc", {}),
	pattern = "dot_zshrc",
	callback = function()
		vim.opt.filetype = "zsh"
	end,
})

-- colorschemes and themes
if vim.fn.has("termguicolors") == 1 then
	opt.termguicolors = true
end
opt.background = "dark"
cmd.colorscheme("nord")
vim.g.nord_cursor_line_number_background = 1
vim.g.nord_uniform_diff_background = 1
vim.g.nord_bold = 1
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.g.nord_underline = 1
-- hi CursorlineNr guibg=#3B4252

local nord = require("HRB.nord")
vim.api.nvim_set_hl(0, "Italic", { italic = true })
vim.api.nvim_set_hl(0, "Comment", { italic = true, default = true })
vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
vim.api.nvim_set_hl(0, "FloatTitle", { fg = nord.c09 })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = nord.c03_br })
vim.api.nvim_set_hl(0, "TabLine", { fg = nord.c04, bg = nord.c01, sp = nord.c11 })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = nord.c04, bg = nord.c11, sp = nord.c11 })
vim.api.nvim_set_hl(0, "TabLineFill", { fg = nord.c04, bg = nord.c01, sp = nord.c11 })
vim.api.nvim_set_hl(0, "Folded", { fg = nord.c03, bg = nord.c01, bold = false })

-- TODO: LessInitFunc :h less
-- TODO: comment continuation -> discontinue on empty comment
-- TODO: autocmd widh autogroup -> set spell on txt, md, tex, gitcommit ft
