return {
    "nvim-lua/plenary.nvim",

    -- ui
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- General
    { "tpope/vim-abolish", event = "VeryLazy" }, -- easily search, substitute, abbr multiple variants of a word
    { "tpope/vim-repeat", event = "VeryLazy" }, -- enable repeating supported plugin maps with `.`

    -- TODO:
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
    -- mason
    -- nui
    -- https://github.com/folke/noice.nvim
    -- https://github.com/nvim-pack/nvim-spectre
}

-- NOTE: check these out
-- use { "mfussenegger/nvim-dap" } -- NOTE: Debug -> https://github.com/mfussenegger/nvim-dap
-- use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
-- use { 'ThePrimeagen/vim-be-good' }
-- use { 'kevinhwang91/nvim-bqf' } -- quickfix
-- use { 'ziontee113/icon-picker.nvim' } -- icon picker
-- use { '0styx0/abbreinder.nvim' } -- abbreviations
-- use { 'sQVe/sort.nvim' } -- smart sort
-- use { 'echasnovski/mini.align' } -- easy align, justify, merge delim
-- use { 'echasnovski/mini.trailspace' } -- remove trailing whitespaces
-- use { 'AckslD/nvim-neoclip.lua', requires = 'nvim-telescope/telescope.nvim' } -- clipboard mngr
-- use { 'TimUntersberger/neogit' } -- magit
