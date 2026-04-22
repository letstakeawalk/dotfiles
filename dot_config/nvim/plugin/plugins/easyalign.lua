vim.pack.add({ "gh:junegunn/vim-easy-align" })

local set = require("utils.keymap").set
set("nx", "ga", "<Plug>(EasyAlign)", { desc = "Easy Align" })
set("v", "<Enter>", "<Plug>(EasyAlign)", { desc = "EasyAlign" })
