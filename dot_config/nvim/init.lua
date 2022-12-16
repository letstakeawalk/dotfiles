require("HRB.settings")
require("HRB.keymaps")
require("HRB.plugins")

require("config.tmux") -- NOTE: tmux nav dont work if in after/plugin
-- TODO: 
-- - learn git fugitive -- :Git g?

vim.cmd([[source $HOME/.config/nvim/config/bclose.vim]])
vim.cmd([[source $HOME/.config/nvim/config/redir.vim]])
vim.cmd([[source $HOME/.config/nvim/config/easyalign.vim]])
