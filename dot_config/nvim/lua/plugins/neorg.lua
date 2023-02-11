-- https://github.com/nvim-neorg/neorg
return {
  "nvim-neorg/neorg",
  -- dir="~/Workspace/Develoment/projects/opensrc/neorg",
  dev = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "nvim-neorg/neorg-telescope",
    "nvim-telescope/telescope.nvim",
  },
  build = ":Neorg sync-parsers",
  cmd = "Neorg",
  ft = "norg",
  init = function()
    vim.keymap.set("n", "<leader>nn", "<cmd>Neorg workspace home<cr>", { desc = "Home" })
    vim.keymap.set("n", "<leader>nw", "<cmd>Neorg workspace work<cr>", { desc = "Work" })
    vim.keymap.set("n", "<leader>no", "<cmd>Neorg journal<cr>", { desc = "Journal" })
    vim.keymap.set("n", "<leader>nt", "<cmd>Neorg toggle-concealer<cr>", { desc = "Toggle Conceal" })
  end,
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("Neorg", {}),
      pattern = "norg",
      callback = function()
        vim.opt_local.formatoptions = "tcqjn"
      end,
    })
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.keybinds"] = {
          config = {
            hook = function(keybinds)
              keybinds.remap_event("norg", "n", "<leader>na", "core.norg.dirman.new.note")
            end,
          },
        },
        ["core.norg.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },
        ["core.norg.dirman"] = {
          config = {
            workspaces = {
              home = "~/Workspace/notes/home",
              work = "~/Workspace/notes/work",
            },
            -- use_popup = false,
            use_popup = true,
          },
        },
        -- ["core.norg.journal"] = {},
        -- ["core.norg.qol.toc"] = {},
        -- ["core.presenter"] = {
        -- 	zen_mode = "zen-mode",
        -- },
        ["core.integrations.nvim-cmp"] = {},
        -- ["core.integrations.telescope"] = {},
      },
    })

    -- local neorg_callbacks = require("neorg.callbacks")
    --
    -- neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
    -- 	-- Map all the below keybinds only when the "norg" mode is active
    -- 	keybinds.map_event_to_mode("norg", {
    -- 		n = { -- Bind keys in normal mode
    -- 			{ "<C-s>", "core.integrations.telescope.find_linkable" },
    -- 		},
    --
    -- 		i = { -- Bind in insert mode
    -- 			{ "<C-l>", "core.integrations.telescope.insert_link" },
    -- 		},
    -- 	}, {
    -- 		silent = true,
    -- 		noremap = true,
    -- 	})
    -- end, function() end)
  end,
}
