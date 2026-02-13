local opt = vim.opt

opt.cmdheight = 2
opt.confirm = true
opt.cursorline = true -- Higlight current line
opt.formatoptions = "cqnlj" -- default tcqj  :help fo-table
opt.history = 2000 -- num history to cache
opt.laststatus = 3 -- always show one statusline
opt.linebreak = true -- wrap text by words rather than char
opt.more = false
opt.mouse = "nv" -- enable mouse on normal and visual mode
opt.number = true -- show line numbers
opt.relativenumber = true -- number relatively
opt.scrolloff = 8 -- num of line to keep above/below the of the cursor
opt.sidescrolloff = 8 -- num of cols to keep left/right of the cursor
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time diagnostics appear/become resolved
opt.splitbelow = true -- always open horizontal split below
opt.splitright = true -- always open vertical split right
opt.timeoutlen = 300
opt.winborder = "rounded"
opt.wrap = false
opt.pumheight = 8
opt.showmode = false
opt.shortmess:append("cS")
opt.scroll = math.floor(vim.o.lines * 0.4) -- scrolling w/ <c-u>, <c-d>
opt.diffopt:append("foldcolumn:0")
opt.fillchars:append("diff: ")

opt.undofile = true -- persistent undo
opt.shada = { "'10", "<0", "s10", "h" }
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- fold
opt.foldcolumn = "0"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldtext = ""
opt.foldopen = "block,hor,mark,percent,quickfix,search,tag,undo"

-- search & substitute
opt.smartcase = true
opt.ignorecase = true
opt.inccommand = "split" -- preview increment substitute

-- tabs and indents
opt.breakindent = true -- Indent wrapped lines
opt.expandtab = true -- expand tabs into spaces
opt.shiftround = true -- Round indent to multiple of 'shiftwidth'
opt.shiftwidth = 4 -- Number of spaces to use in auto(indent)
opt.tabstop = 8

-- TODO: LessInitFunc :h less
-- TODO: comment continuation -> discontinue on empty comment
