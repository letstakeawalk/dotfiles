local opt = vim.opt

-- tabs and indents
opt.expandtab = true -- expand tabs into spaces
opt.shiftround = true -- Round indent to multiple of 'shiftwidth'
opt.shiftwidth = 4 -- Number of spaces to use in auto(indent)
opt.breakindent = true -- Indent wrapped lines

-- display
opt.cursorline = true -- Higlight current line
opt.colorcolumn = "99"
opt.termguicolors = true
opt.winborder = "rounded"
opt.showmode = false
opt.pumheight = 8
opt.cmdheight = 2
opt.laststatus = 3 -- always show one statusline
opt.shortmess:append("cS")

-- gutter
opt.number = true -- show line numbers
opt.relativenumber = true -- number relatively
opt.signcolumn = "yes"

-- clipboard
opt.clipboard = "unnamedplus" -- sync w/ system clipboard
if vim.env.SSH_CONNECTION then
    local function vim_paste()
        local content = vim.fn.getreg('"')
        return vim.split(content, "\n")
    end

    vim.g.clipboard = {
        name = "OSC 52",
        copy = {
            ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
            ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
        },
        paste = { ["+"] = vim_paste, ["*"] = vim_paste },
    }
end

-- text & wrapping
opt.formatoptions = "cqnlj" -- default tcqj  :help fo-table
opt.linebreak = true -- wrap text by words rather than char
opt.wrap = false

-- scrolling
opt.scrolloff = 8 -- num of line to keep above/below the of the cursor
opt.sidescrolloff = 8 -- num of cols to keep left/right of the cursor
opt.scroll = math.floor(vim.o.lines * 0.4) -- scrolling w/ <c-u>, <c-d>

-- splits
opt.splitbelow = true -- always open horizontal split below
opt.splitright = true -- always open vertical split right

-- behavior
opt.confirm = true
opt.mouse = "nv" -- enable mouse on normal and visual mode
opt.more = false
opt.timeoutlen = 300
opt.history = 2000 -- num history to cache

-- diff
opt.diffopt:append("foldcolumn:0")
opt.fillchars:append("diff: ")

-- persistence
opt.undofile = true -- persistent undo
opt.shada = { "'10", "<0", "s10", "h" }
opt.sessionoptions =
    "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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
