-- key bindings popup
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({
      plugins = {
        -- TODO: check and disable others
        marks = false, -- shows a list of your marks on ' and `
        registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      },
      operators = {
        ga = "Easy Align",
      },
      window = {
        border = "single"
      }
    })

    wk.register({
      a = { name = "Git" },
      c = { name = "Tmux Runner" },
      d = { name = "Display" },
      g = { name = "Telescope" },
      i = { name = "Info Panels" },
      n = { name = "Neorg" },
      q = { name = "Buffer Management" },
      r = {
        name = "Refactor",
        k = "Swap Param >>", -- treesitter
        h = "Swap Param <<", -- treesitter
        w = "Trailing Whitespace",
      },
      s = { name = "Source/Reload" },
      t = { name = "Telescope" },
      x = { name = "Trouble" },
    }, { prefix = "<leader>" })
  end,
}
