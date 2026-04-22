vim.pack.add({ "gh:kevinhwang91/nvim-hlslens" })

local lens = require("hlslens")
lens.setup({ calm_down = true })

local set = require("utils.keymap").set
set(
    "n",
    "n",
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zvzz]],
    { desc = "Next result" }
)
set(
    "n",
    "N",
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zvzz]],
    { desc = "Prev result" }
)
set(
    "n",
    "*",
    [[*<Cmd>lua require('hlslens').start()<CR>zvzz]],
    { desc = "Search next occurrence" }
)
set(
    "n",
    "#",
    [[#<Cmd>lua require('hlslens').start()<CR>zvzz]],
    { desc = "Search prev occurrence" }
)
