return {
  "kazhala/close-buffers.nvim", -- preserve window layout with bdelete/bwipeout
  cmd = "BDelete",
  keys = {
    { "<leader>qq", "<cmd>q<cr>", desc = "Close all buffers" },
    { "<leader>qa", "<cmd>bufdo bwipe<cr>", desc = "Close all buffers" },
    { "<leader>qo", "<cmd>BWipeout other<cr>", desc = "Close other buffers" },
    { "<leader>qt", "<cmd>BWipeout this<cr>", desc = "Close this buffer" },
  },
  config = function()
    local cb = require("close_buffers")
    cb.setup({
      filetype_ignore = {}, -- Filetype to ignore when running deletions
      file_glob_ignore = {}, -- File name glob pattern to ignore when running deletions (e.g. '*.md')
      file_regex_ignore = {}, -- File name regex pattern to ignore when running deletions (e.g. '.*[.]md')
      preserve_window_layout = { "this", "nameless" }, -- Types of deletion that should preserve the window layout
      next_buffer_cmd = nil, -- Custom function to retrieve the next buffer when preserving window layout
    })
  end,
}

-- similar projects
-- use { 'famiu/bufdelete.nvim' } -- delete buffer while preserving window layout
