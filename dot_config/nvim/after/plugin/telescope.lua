local telescope = require "telescope"
local actions = require "telescope.actions"

telescope.setup {
  defaults = {
    layout_strategy = 'center', -- horizontal, center, vertical
    layout_config = {
      width = 80,
      height = 0.25,
    },
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    results_title = false,
    sorting_strategy = "ascending",
    prompt_prefix = '   ', -- ' 🔭🔎 ',
    selection_caret = '  ',
    multi_icon = '  ',
    entry_prefix = '   ',
    mappings = {
      i = {
        ["<ESC>"] = actions.close,
        ["<C-h>"] = "which_key",
      },
      n = {
        ["k"] = actions.move_selection_next,
        ["h"] = actions.move_selection_previous,
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- find_files = { theme = "dropdown" },
    -- live_grep = { theme = "dropdown" },
    -- buffers = { theme = "dropdown" },
    -- help_tags = { theme = "dropdown" },
    -- marks = { theme = "dropdown" },
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

-- keymaps
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>p", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>tc", "<cmd>Telescope commands<cr>")
vim.keymap.set("n", "<leader>th", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>tk", "<cmd>Telescope keymaps<cr>")
vim.keymap.set("n", "<leader>tm", "<cmd>Telescope marks<cr>")
vim.keymap.set("n", "<leader>tq", "<cmd>Telescope quickfix<cr>")
vim.keymap.set("n", "<leader>ta", "<cmd>Telescope autocommands<cr>")
vim.keymap.set("n", "<leader>ts", "<cmd>Telescope spell_suggest<cr>")
vim.keymap.set("n", "<leader>tS", "<cmd>Telescope symbols<cr>")
-- lsp pickers
vim.keymap.set("n", "<leader>gr", "<cmd>Telescope lsp_references<cr>")
vim.keymap.set("n", "<leader>gi", "<cmd>Telescope lsp_implementations<cr>")
vim.keymap.set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>")
vim.keymap.set("n", "<leader>gt", "<cmd>Telescope lsp_type_definitions<cr>")
-- git
vim.keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>")
vim.keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>")
vim.keymap.set("n", "<leader>gC", "<cmd>Telescope git_bcommits<cr>")
vim.keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>")

-- highlight
local nord = require("HRB.nord")
vim.api.nvim_set_hl(0, "TelescopeTitle", { link = "FloatTitle" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "FloatBorder" })
vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { link = "TelescopeTitle" })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = nord.c04, bold = true })
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { fg = nord.c04_dk0 })


-- list of extensions
-- https://github.com/sudormrfbin/cheatsheet.nvim
-- https://github.com/nvim-telescope/telescope-dap.nvim
-- https://github.com/danielpieper/telescope-tmuxinator.nvim
-- https://github.com/nvim-neorg/neorg-telescope

-- https://github.com/barrett-ruth/telescope-http.nvim
-- https://github.com/chip/telescope-software-licenses.nvim
