return {
  "echasnovski/mini.ai", -- a/i textobjects (wellle/targets.vim alt)
  version = false,
  event = "BufReadPost",
  config = function()
    require("mini.ai").setup({})
  end,
}
