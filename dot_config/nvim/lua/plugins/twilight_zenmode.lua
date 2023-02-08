return {
  "folke/zen-mode.nvim",
  dependencies = "folke/twilight.nvim",
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" },
  },
  config = function()
    local zen = require("zen-mode")
    zen.setup({
      plugins = {
        -- this will change the font size on alacritty when in zen mode
        -- requires  Alacritty Version 0.10.0 or higher
        -- uses `alacritty msg` subcommand to change font size
        -- alacritty = {
        --   enabled = true,
        --   font = "14", -- font size
        -- },
        -- kitty = {}
      },
    })
  end,
}
