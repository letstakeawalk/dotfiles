return {
  "monaqa/dial.nvim",
  -- stylua: ignore
  keys = {
    { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc= "Increment"},
    { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Increment"},
    { "<C-a>", function() return require("dial.map").inc_visual() end, mode = "v" , expr = true, desc = "Increment"},
    { "<C-x>", function() return require("dial.map").dec_visual() end, mode = "v" , expr = true, desc = "Increment"},
    { "g<C-a>", function() return require("dial.map").inc_gvisual() end, mode = "v" , expr = true, desc = "Increment"},
    { "g<C-x>", function() return require("dial.map").dec_gvisual() end, mode = "v" , expr = true, desc = "Increment"},
  },
}
