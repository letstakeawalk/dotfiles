vim.pack.add({ "gh:/aserowy/tmux.nvim" })

local set = require("utils.keymap").set
set("n", "<C-w>j", [[<cmd>lua require('tmux').move_left()<cr>]], { desc = "Tmux Navigate Left" })
set("n", "<C-w>k", [[<cmd>lua require('tmux').move_bottom()<cr>]], { desc = "Tmux Navigate Down" })
set("n", "<C-w>h", [[<cmd>lua require('tmux').move_top()<cr>]], { desc = "Tmux Navigate Up" })
set("n", "<C-w>l", [[<cmd>lua require('tmux').move_right()<cr>]], { desc = "Tmux Navigate Right" })

require("tmux").setup({
    navigation = {
        cycle_navigation = false,
        enable_default_keybindings = false,
        persist_zoom = false,
    },
    resize = {
        enable_default_keybindings = false,
        resize_step_x = 5,
        resize_step_y = 5,
    },
    copy_sync = {
        enable = false,
    },
})
