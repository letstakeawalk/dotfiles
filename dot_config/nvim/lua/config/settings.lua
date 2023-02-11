-- general config
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.python3_host_prog = "/opt/homebrew/bin/python3.11"

-- vim.cmd.syntax("on") -- ???
local opt = vim.opt
opt.backspace = { "indent", "eol", "start" } -- Intuitive backspacing in insert mode
opt.backup = false -- backup
opt.clipboard = "unnamedplus" -- sync w/ system clipboard
opt.cmdheight = 3 -- height of the command line
opt.colorcolumn = "88" -- Column hightlight at textwidth
opt.completeopt = { "menu", "menuone", "noselect", "preview" } -- nvim-cmp handles. no need here?
opt.conceallevel = 3 -- hide * markup for bold and itailc
opt.confirm = true -- confirm operations
opt.cursorline = true -- Higlight current line
opt.diffopt = { "filler", "iwhite" } -- Diff mode: show fillers, ignore whitepsace
opt.encoding = "utf-8" -- encoding
opt.fileencoding = "utf-8" -- encoding
opt.fileformats = { "unix", "mac", "dos" } -- Use Unix as the standard file type
opt.formatoptions = "crqnlj" -- default tcqj  :help fo-table
opt.grepformat = "%f:%l:%c:%m" --  (default "%f:%l:%m,%f:%l%m,%f  %l%m")
opt.grepprg = "rg --vimgrep"
opt.hidden = true -- hide buffers when abandoned instead of unload
opt.history = 2000 -- num history to cache
opt.iskeyword:append({ "-" }) -- treat dash separated words as a word text object
opt.laststatus = 3 -- always show statusline
opt.lazyredraw = true -- do not redraw screen in the middle of a macro. Makes them complete faster
opt.linebreak = true -- wrap text by words rather than char
opt.magic = true -- For regular expressions turn magic on
opt.mouse = { v = true, n = true } -- enable mouse
opt.number = true -- show line numbers
opt.numberwidth = 4 -- gutter size
opt.pumblend = 0 -- pum transparency
opt.pumheight = 10 -- height of popup menu
opt.relativenumber = true -- number relatively
opt.ruler = true -- display current line
opt.scrolloff = 8 -- num of line to keep above/below the of the cursor
opt.shortmess:append({ c = true, W = true, I = true, C = true }) -- short messages
opt.showcmd = true -- display incomplete commands
opt.showmode = false -- do not display vim-mode on message
opt.showtabline = 1 -- display tab-line only if there are at least two tabs
opt.sidescrolloff = 8 -- num of cols to keep left/right of the cursor
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
opt.splitbelow = true -- always open horizontal split below
opt.splitright = true -- always open vertical split right
opt.swapfile = false -- swap file
opt.termguicolors = true -- true color suppor
opt.textwidth = 88 -- textwidth
opt.timeoutlen = 300 -- used to be 500
opt.undofile = true -- persistent undo
opt.updatetime = 50 -- for CursorHold aucmd
opt.wildmode = "longest:full,full" -- commandline completion mode (default: full)
opt.winminwidth = 5 -- min window width
opt.wrap = false -- No wrap by default
-- fold
opt.foldcolumn = "0"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
-- search & substitute
opt.ignorecase = true -- Search case-insensitive
opt.incsearch = true -- Incremental search
opt.inccommand = "nosplit" -- preview increment substitute
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

-- TODO: LessInitFunc :h less
-- TODO: comment continuation -> discontinue on empty comment
