-- search highlight with virtual texts
return {
    "kevinhwang91/nvim-hlslens",
    keys = {
        { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zvzz]], desc = "Next result" },
        { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zvzz]], desc = "Prev result" },
        { "*", [[*<Cmd>lua require('hlslens').start()<CR>zvzz]], desc = "Search next occurrence" },
        { "#", [[#<Cmd>lua require('hlslens').start()<CR>zvzz]], desc = "Search prev occurrence" },
    },
    opts = { calm_down = true },
}
