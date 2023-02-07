return {
	"nvim-lua/plenary.nvim",

	-- ui
	{ "kyazdani42/nvim-web-devicons", lazy = true },

	-- General
	{ "tpope/vim-abolish", event = "VeryLazy" }, -- easily search, substitute, abbr multiple variants of a word
	{ "tpope/vim-repeat", event = "VeryLazy" }, -- enable repeating supported plugin maps with `.`
	{ "wellle/targets.vim", event = "VeryLazy" }, -- various textobjects

	-- TODO:
	-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
	-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
	-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
	-- mason
	-- nui
	-- https://github.com/folke/noice.nvim
	-- https://github.com/cshuaimin/ssr.nvim
	-- https://github.com/nvim-pack/nvim-spectre
}

-- "███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
-- "████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
-- "██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
-- "██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
-- "██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
-- "╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",

-- TODO
-- use { "mfussenegger/nvim-dap" } -- NOTE: Debug -> https://github.com/mfussenegger/nvim-dap
-- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
-- use { 'ThePrimeagen/vim-be-good' }
-- use { 'aserowy/tmux.nvim' } -- tmux integration (tmuxinator alt) -- PRIORITY:
-- use { 'kevinhwang91/nvim-bqf' } -- quickfix
-- use { 'ziontee113/icon-picker.nvim' } -- icon picker
-- use { '0styx0/abbreinder.nvim' } -- abbreviations
-- use { 'sQVe/sort.nvim' } -- smart sort
-- use { 'echasnovski/mini.align' } -- easy align, justify, merge delim
-- use { 'echasnovski/mini.trailspace' } -- remove trailing whitespaces
-- use { 'simrat39/symbols-outline.nvim' } -- lsp symbol treeview
-- use { 'AckslD/nvim-neoclip.lua', requires = 'nvim-telescope/telescope.nvim' } -- clipboard mngr
-- use { 'TimUntersberger/neogit' } -- magit

-- notable but no longer used plugins
-- use { 'easymotion/vim-easymotion' } -- fast navigation in buffer -> leap.nvim
-- use { 'junegunn/vim-slash' } -- in-buffer search enhancer -> hlslens
-- use { 'junegunn/goyo.vim' } -- distraction free writing in vim -> zenmode
-- use { 'junegunn/limelight.vim' } -- hyperfocus-wiring in vim -> twilight
-- use { 'lewis6991/spaceless.nvim' } -- strip trailing white spaces on edit
-- use { 'mbbill/undotree' } -- undo histroy tree
-- use { 'mhinz/vim-startify' } -- starting screen -> dashboard-nvim
-- use { 'scrooloose/nerdcommenter' } --easy commenting -> vim-commentary -> Comment.nvim
-- use { 'tpope/vim-commentary' } -- comment stuffs out -> Comment.nvim
-- use { 'tpope/vim-surround' }, -- quoting/parenthesizing made simple --> nvim-surround
-- use { 'tpope/vim-unimpaired' } -- various useful shortcuts and keybindings
-- use { 'yuttie/comfortable-motion.vim' } -- smooth scrolling -> neoscroll
-- use { 'tmhedberg/SimpylFold' } -- easy code folding for Python
-- use { "Konfekt/FastFold" }, -- update folds only when called for
-- use { "glepnir/dashboard-nvim" } -- dashboard -- start up page
-- use { 'nanozuki/tabby.nvim' } -- tabline
-- use { 'windwp/nvim-autopairs' } --auto closes parentheses (dep nvim-treesitter)
