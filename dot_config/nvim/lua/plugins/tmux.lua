-- TODO:
-- vim.fn.system("tmux popup -h 80% -w 70% -E 'tmux new -As popup'")
-- vim.fn.system("tmux popup -h 80% -w 70% -E")

return {
  {
    "aserowy/tmux.nvim",
    -- stylua: ignore
    keys = {
      { "<C-j>", function() require("tmux").move_left() end, mode = { "n", "i" }, desc = "Nav Left" },
      { "<C-l>", function() require("tmux").move_right() end, mode = { "n", "i" }, desc = "Nav Right" },
      { "<C-k>", function() require("tmux").move_bottom() end, mode = { "n", "i" }, desc = "Nav Down" },
      { "<C-h>", function() require("tmux").move_top() end, mode = { "n", "i" }, desc = "Nav Up" },
    },
    config = function()
      local tmux = require("tmux")
      tmux.setup({
        copy_sync = { enabled = false },
        navigation = { enable_default_keybindings = false },
        resize = { enable_default_keybindings = false },
      })
    end,
  },
  {
    "christoomey/vim-tmux-runner",
    event = "VeryLazy",
    config = function()
      vim.g.VtrUseVtrMaps = 0
      vim.g.VtrStripLeadingWhitespace = 0
      vim.g.VtrClearEmptyLines = 0
      vim.g.VtrAppendNewline = 0 -- TODO: switch back to 1

      vim.keymap.set({ "n", "x" }, "<leader>cl", "<cmd>VtrSendLinesToRunner<cr>", { desc = "Send lines to runner" })
      vim.keymap.set(
        "n",
        "<leader>cc",
        "<cmd>VtrFlushCommand<cr><cmd>VtrSendCommandToRunner<cr>",
        { desc = "Send command to runner" }
      )
      vim.keymap.set("n", "<leader>cr", "<cmd>VtrSendCommandToRunner<cr>", { desc = "(Re)Send command to runner" })
      vim.keymap.set("n", "<leader>cs", "<cmd>VtrSendFile!<cr>", { desc = "Run file" })
      vim.keymap.set("n", "<leader>cf", "<cmd>VtrFlushCommand<cr>", { desc = "Flush commands" })
      vim.keymap.set("n", "<leader>co", "<cmd>VtrOpenRunner<cr>", { desc = "Open runner" })
      vim.keymap.set("n", "<leader>ck", "<cmd>VtrKillRunner<cr>", { desc = "Kill runner" })
      vim.keymap.set("n", "<leader>cl", "<cmd>VtrClearRunner<cr>", { desc = "Clear runner" })

      -- local cmd = vim.fn.input(prompt)
      -- vim.fn.system("tmux send-key -t 2 'echo foo\n'")
      -- highlighted input https://github.com/neovim/neovim/issues/13672
      -- vim.api.nvim_input
      -- vim.api.nvim_echo({{"message", "HLgroup"}}, false, {})

      -- custom tmux command

      local current_path = function()
        return vim.loop.cwd()
      end
      vim.keymap.set("n", "<leader>gg", function()
        vim.fn.system("tmux popup -h 90% -w 80% -E -E -d " .. current_path() .. " lazygit")
      end, {
        desc = "LazyGit",
      })
      vim.keymap.set("n", "<leader>cn", function()
        vim.fn.system("tmux popup -h 90% -w 80% -E -d " .. current_path())
      end, {
        desc = "Popup (temp)",
      })
      vim.keymap.set("n", "<leader>cN", function()
        vim.fn.system("tmux popup -h 90% -w 80% -E 'tmux new -As popup'")
      end, { desc = "Popup" })
    end,
  },
}
