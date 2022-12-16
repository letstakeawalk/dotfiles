require("trouble").setup {
  -- position = "right", -- position of the list can be: bottom, top, left, right
  -- widtk = 60, -- width of the list when position is left or right
  mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
  action_keys = {
    previous = "h", -- preview item
    next = "k" -- next item
  }
}

-- TODO telescope integration


-- keymaps
local opts = function(desc)
  return { noremap = true, silent = true, desc = desc }
end
local keymap = vim.keymap.set
keymap("n", "<leader>xx", "<cmd>Trouble<cr>")
keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts("Trouble Workspace"))
keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts("Trouble Document"))
keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts("Trouble Locallist"))
keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts("Trouble Quickfix"))
keymap("n", "gd", "<cmd>Trouble lsp_definitions<cr>", opts("Trouble Lsp Definition"))
keymap("n", "gi", "<cmd>Trouble lsp_implementations<cr>", opts("Trouble Lsp Implementation"))
keymap("n", "gr", "<cmd>Trouble lsp_references<cr>", opts("Trouble Lsp References"))
keymap("n", "gt", "<cmd>Trouble lsp_type_definitions<cr>", opts("Trouble Lsp Type Definition"))
