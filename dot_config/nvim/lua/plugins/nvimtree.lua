return {
  "kyazdani42/nvim-tree.lua",
  dependencies = "kyazdani42/nvim-web-devicons",
  keys = { { "<leader>e", "<cmd>NvimTreeFindFileToggle<cr>", desc = "NvimTree" } },
  config = function()
    -- following options are the default
    -- each of these are documented in `:help nvim-tree.OPTION_NAME`
    require("nvim-tree").setup({
      view = {
        adaptive_size = false,
        centralize_selection = false,
        width = 30,
        hide_root_folder = false,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        mappings = {
          custom_only = false,
          list = {
            -- user mappings go here
            { key = { "<CR>", "o", "l", "<2-LeftMouse>" }, action = "edit", mode = "n" },
            { key = "j", action = "close_node" },
            { key = "<BS>", action = "parent_node" },
            { key = "<Tab>", action = "preview" },
            { key = "H", action = "first_sibling" },
            { key = "K", action = "last_sibling" },
            { key = ".", action = "toggle_dotfiles" },
            { key = "d", action = "trash" },
            { key = "D", action = "remove" },
            { key = "zr", action = "expand_all" },
            { key = "zm", action = "collapse_all" },
            { key = "?", action = "toggle_help" },
          },
        },
      },
      actions = {
        open_file = { quit_on_open = true },
      },
      diagnostics = {
        enable = true,
      },
      filters = {
        dotfiles = true,
        custom = {},
        exclude = {},
      },
      trash = {
        cmd = "trash",
        require_confirm = true,
      },
      notify = { threshold = vim.log.levels.WARN },
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true,
      },
    })
  end,
}
