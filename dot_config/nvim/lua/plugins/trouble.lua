return {
	"folke/trouble.nvim",
	dependencies = "kyazdani42/nvim-web-devicons",
	cmd = { "Trouble" },
  --stylua: ignore
  config = function()
    require("trouble").setup({
      -- position = "right", -- position of the list can be: bottom, top, left, right
      -- widtk = 60, -- width of the list when position is left or right
      mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      action_keys = {
        previous = "h", -- preview item
        next = "k", -- next item
      },
    })
    -- TODO telescope integration

    -- keymaps
    vim.keymap.set("n", "<leader>xx", "<cmd>Trouble<cr>", { desc = "Trouble toggle" })
    vim.keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Workspace Diagnistics" })
    vim.keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", { desc = "Document Diagnostics" })
    vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { desc = "Locallist" })
    vim.keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { desc = "Quickfix" })
    vim.keymap.set("n", "<leader>gd", "<cmd>Trouble lsp_definitions<cr>", { desc = "Trouble Lsp Definition" })
    vim.keymap.set("n", "<leader>gi", "<cmd>Trouble lsp_implementations<cr>", { desc = "Trouble Lsp Implementation" })
    vim.keymap.set("n", "<leader>gr", "<cmd>Trouble lsp_references<cr>", { desc = "Trouble Lsp References" })
    vim.keymap.set("n", "<leader>gt", "<cmd>Trouble lsp_type_definitions<cr>", { desc = "Trouble Lsp Type Definition" })

    local nord = require("utils").nord
    vim.api.nvim_set_hl(0, "TroublePreview", { bg = nord.c09 })
  end,
} -- list of troubles
