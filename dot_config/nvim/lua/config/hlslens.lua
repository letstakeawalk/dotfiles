-- https://github.com/kevinhwang91/nvim-hlslens
require("hlslens").setup()

local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end
local map = vim.keymap.set

map('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
  opts("Next result"))
map('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
  opts("Prev result"))
map('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], opts("Search next occurrence"))
map('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], opts("Search prev occurrence"))
map('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], opts("Search next occurrence"))
map('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], opts("Search prev occurrence"))

map('n', '<Esc>', ':noh<CR>', opts())
