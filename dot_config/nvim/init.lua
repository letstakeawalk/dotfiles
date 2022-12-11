require("HRB.settings")
require("HRB.keymaps")
require("HRB.plugins")
-- lsp
require("config.lsp")
require("config.lsp_servers")
require("config.lsp_null")
require("config.lsp_signature")
require("config.treesitter")
require("config.telescope")
-- completion & snippet
require("config.cmp")
require("config.luasnip")
-- general
require("config.autopairs")
require("config.better_escape")
require("config.comment")
require("config.git")
require("config.hlslens")
require("config.leap")
require("config.neorg")
require("config.rooter")
require("config.surround")
require("config.tmux")
require("config.trouble")
require("config.whichkey")
-- ui enhancements
require("config.tree")
require("config.ufo")
require("config.dressing")
require("config.colorizer")
require("config.indent_blankline")
require("config.lualine")
require("config.bufferline")
require("config.neoscroll")
-- disabled
-- require "config.tabby"
-- require "config.navic"
-- require"config.cursorline"

vim.cmd([[source $HOME/.config/nvim/config/bclose.vim]])
vim.cmd([[source $HOME/.config/nvim/config/redir.vim]])
vim.cmd([[source $HOME/.config/nvim/config/easyalign.vim]])
vim.cmd([[source $HOME/.config/nvim/config/rooter.vim]])
-- vim.cmd [[source $HOME/.config/nvim/config/simpylfold.vim]]

-- for vscode neovim plugins uses
-- if not vim.g.vscode then
-- else
-- end
