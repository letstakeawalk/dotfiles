return {
    "aserowy/tmux.nvim",
    keys = {
        { "<C-j>", [[<cmd>lua require("tmux").move_left()<cr>]], desc = "Tmux Navigate Left" },
        { "<C-k>", [[<cmd>lua require("tmux").move_bottom()<cr>]], desc = "Tmux Navigate Down" },
        { "<C-h>", [[<cmd>lua require("tmux").move_top()<cr>]], desc = "Tmux Navigate Up" },
        { "<C-l>", [[<cmd>lua require("tmux").move_right()<cr>]], desc = "Tmux Navigate Right" },
    },
    opts = {
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
        }
    }
}
