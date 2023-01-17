-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Plugins are stored in
-- $XDG_DATA_HOME/nvim/site/pack/packer/

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	use({ "wbthomason/packer.nvim" }) -- Packer can manage itself

	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- Configurations for Nvim LSP
	use({ "nvim-lua/plenary.nvim" }) -- core lua functions
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- injectable language server
	use({ "ray-x/lsp_signature.nvim" }) -- func signature in insert-mode
	-- use { "mfussenegger/nvim-dap" }-- TODO: Debug -> https://github.com/mfussenegger/nvim-dap
	-- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

	-- Completion engine & snippets
	use({ "hrsh7th/nvim-cmp", requires = "L3MON4D3/LuaSnip" }) -- completion engine
	use({ "hrsh7th/cmp-nvim-lsp", requires = "hrsh7th/nvim-cmp" }) -- src for nvim LS client
	use({ "hrsh7th/cmp-buffer", requires = "hrsh7th/nvim-cmp" }) -- src for words in buffers
	use({ "hrsh7th/cmp-path", requires = "hrsh7th/nvim-cmp" }) -- src for path
	use({ "hrsh7th/cmp-cmdline", requires = "hrsh7th/nvim-cmp" }) -- src for vim's commandline
	use({ "hrsh7th/cmp-nvim-lua", requires = "hrsh7th/nvim-cmp" }) -- src for neovim lua api
	use({ "onsails/lspkind.nvim", requires = "hrsh7th/nvim-cmp" }) -- completion menu pictogram
	use({ "L3MON4D3/LuaSnip" }) -- snippet engine
	use({ "saadparwaiz1/cmp_luasnip", requires = { "L3MON4D3/LuaSnip", "hrsh7th/nvim-cmp" } }) -- src for luasnip
	-- use { 'ms-jpq/coq_nvim' } -- check out

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})
	use({ "nvim-treesitter/nvim-treesitter-context", requires = "nvim-treesitter/nvim-treesitter" }) -- code context winbar
	use({ "nvim-treesitter/nvim-treesitter-textobjects", requires = "nvim-treesitter/nvim-treesitter" }) -- treesitter module
	use({ "nvim-treesitter/playground", requires = "nvim-treesitter/nvim-treesitter" }) -- treesitter playground
	use({ "JoosepAlviste/nvim-ts-context-commentstring", requires = "nvim-treesitter/nvim-treesitter" }) -- context commentstring
	use({ "RRethy/nvim-treesitter-endwise", requires = "nvim-treesitter/nvim-treesitter" }) -- endwise lua, ruby, etc
	use({ "windwp/nvim-ts-autotag", requires = "nvim-treesitter/nvim-treesitter" }) -- auto closes tags for html, react, etc

	-- Telescope
	use({ "nvim-telescope/telescope.nvim", requires = "nvim-lua/plenary.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", requires = "nvim-telescope/telescope.nvim", run = "make" })
	use({ "nvim-telescope/telescope-symbols.nvim" }) -- symbol picker
	-- use { 'nvim-telescope/telescope-ui-select.nvim' } -- dressing.nvim

	-- UI enhancement
	use({ "arcticicestudio/nord-vim" }) -- theme
	-- use { 'shaunsingh/nord.nvim' } -- theme
	use({ "kyazdani42/nvim-web-devicons" }) -- dev icons
	use({ "nvim-lualine/lualine.nvim", requires = "kyazdani42/nvim-web-devicons" }) -- statusline
	use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" }) -- tabline
	use({ "lukas-reineke/indent-blankline.nvim", requires = "nvim-treesitter/nvim-treesitter" }) -- indentation guide
	use({ "lewis6991/gitsigns.nvim" }) -- git decoration in gutter
	use({ "j-hui/fidget.nvim" }) -- lsp progress
	-- use({ "glepnir/dashboard-nvim" }) -- dashboard -- start up page
	use({ "folke/zen-mode.nvim" }) -- focus: distraction free coding
	use({ "folke/twilight.nvim" }) -- focus: dims inactive portion of code
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }) -- pretty fold block
	use({ "stevearc/dressing.nvim" }) -- vim.ui.[input,select] interface
	use({ "RRethy/vim-illuminate" }) -- highlight word under cursor using lsp,ts or regex
  use({ "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig" }) -- code context in winbar using lsp
	-- use { 'nanozuki/tabby.nvim' } -- tabline

	-- General (lua)
	use({ "ThePrimeagen/refactoring.nvim", requires = "nvim-treesitter/nvim-treesitter" }) -- refactoring library
	use({ "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" }) -- magic
	-- use { 'ThePrimeagen/vim-be-good' }
	use({ "nvim-neorg/neorg", requires = "nvim-lua/plenary.nvim" }) -- org-mode
	use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" }) -- list of troubles
	use({ "folke/which-key.nvim" }) -- key bindings popup
	use({ "ggandor/leap.nvim" }) -- lightspeed motion/navigation
	use({ "ggandor/leap-spooky.nvim", requires = "ggandor/leap.nvim" }) -- leap extension
	use({ "ggandor/flit.nvim", requires = "ggandor/leap.nvim" }) -- fFtT motions on steroid
	use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" }) -- File Explorer
	use({ "norcalli/nvim-colorizer.lua" }) -- hex, rgb color highlighter
	use({ "kevinhwang91/nvim-hlslens" }) -- search highlight with virtual texts
	use({ "kylechui/nvim-surround" }) -- surround word with '"([ <tag>, etc
	use({ "numToStr/Comment.nvim", requires = "JoosepAlviste/nvim-ts-context-commentstring" }) -- smart commenting
	use({ "karb94/neoscroll.nvim" }) -- smooth scrolling
	use({ "max397574/better-escape.nvim" }) -- better escape mappings
  use({ "kazhala/close-buffers.nvim" }) -- preserve window layout with bdelete/bwipeout
	-- TODO: checkout below
	-- use { 'aserowy/tmux.nvim' } -- tmux integration (tmuxinator alt) -- PRIORITY:
	-- use { 'famiu/bufdelete.nvim' } -- delete buffer while preserving window layout
	-- use { 'kevinhwang91/nvim-bqf' } -- quickfix
	-- use { 'ziontee113/icon-picker.nvim' } -- icon picker
	-- use { '0styx0/abbreinder.nvim' } -- abbreviations
	-- use { 'sQVe/sort.nvim' } -- smart sort
	-- use { 'echasnovski/mini.align' } -- easy align, justify, merge delim
	-- use { 'echasnovski/mini.trailspace' } -- remove trailing whitespaces
	-- use { 'simrat39/symbols-outline.nvim' } -- lsp symbol treeview
	-- use { 'AckslD/nvim-neoclip.lua', requires = 'nvim-telescope/telescope.nvim' } -- clipboard mngr
	-- use { 'TimUntersberger/neogit' } -- magit

	-- General (vim)
	use({ "mbbill/undotree" }) -- undotree
	use({ "junegunn/vim-easy-align" }) -- alignment plugin
	use({ "junegunn/gv.vim" }) -- git commit browser
	use({ "tpope/vim-abolish" }) -- easily search, substitute, abbr multiple variants of a word
	use({ "tpope/vim-fugitive" }) -- git wrapper.
	use({ "tpope/vim-rhubarb", requires = "tpope/vim-fugitive" }) -- fugitive extension for GitHub
	use({ "tpope/vim-repeat" }) -- enable repeating supported plugin maps with `.`
	use({ "Konfekt/FastFold" }) -- update folds only when called for TODO not needed?
	use({ "airblade/vim-rooter" }) -- pwd rooter
	use({ "christoomey/vim-tmux-navigator" }) -- seamless navigation between tmux panes and vim splits
	use({ "christoomey/vim-tmux-runner" }) -- send commands to tmux pane
	use({ "wellle/targets.vim" }) -- various textobjects
	use({ "jiangmiao/auto-pairs" }) -- auto pair ""()[]{},etc -- TODO: compare with nvim-autopairs
	-- use { 'windwp/nvim-autopairs' } --auto closes parentheses (dep nvim-treesitter)

	-- Python -- XXX: maybe not needed -> treesitter
	-- use { 'Vimjas/vim-python-pep8-indent' } -- PEP8 indentation
	-- use { 'tmhedberg/SimpylFold' } -- easy code folding for Python
end)

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
