return {
    {
        "aserowy/tmux.nvim",
        keys = {
            { "<C-j>", function() require("tmux").move_left() end, mode = { "n" }, desc = "Nav Left" },
            { "<C-l>", function() require("tmux").move_right() end, mode = { "n" }, desc = "Nav Right" },
            { "<C-k>", function() require("tmux").move_bottom() end, mode = { "n" }, desc = "Nav Down" },
            { "<C-h>", function() require("tmux").move_top() end, mode = { "n" }, desc = "Nav Up" },
            {
                "<C-\\>",
                function()
                    vim.fn.system("tmux popup -h 90% -w 95% -b rounded -S fg='#5E81AC' -E -d " .. vim.loop.cwd() .. " 'tmux new -As popup'")
                end,
                desc = "Tmux Popup",
            },
            {
                "<leader>gG",
                function() vim.fn.system("tmux popup -h 90% -w 95% -b rounded -S fg='#5E81AC' -E -E -d " .. vim.loop.cwd() .. " lazygit") end,
                desc = "LazyGit",
            },
        },
        opts = {
            copy_sync = { enabled = false },
            navigation = { enable_default_keybindings = false },
            resize = { enable_default_keybindings = false },
        },
    },
    {
        "christoomey/vim-tmux-runner",
        keys = {
            { "<leader>Cl", "<cmd>VtrSendLinesToRunner<cr>", desc = "Send lines" },
            { "<leader>Ca", "<cmd>VtrAttachToPane<cr>", desc = "Attache to pane" },
            { "<leader>Cc", "<cmd>VtrFlushCommand<cr><cmd>VtrSendCommandToRunner<cr>", desc = "Send command" },
            { "<leader>Cr", "<cmd>VtrSendCommandToRunner<cr>", desc = "(Re)Send command" },
            { "<leader>Cx", "<cmd>VtrSendFile!<cr>", desc = "Run file" },
            { "<leader>Cf", "<cmd>VtrFlushCommand<cr>", desc = "Flush commands" },
            { "<leader>Co", "<cmd>VtrOpenRunner<cr>", desc = "Open runner" },
            { "<leader>Ck", "<cmd>VtrKillRunner<cr>", desc = "Kill runner" },
            { "<leader>CC", "<cmd>VtrClearRunner<cr>", desc = "Clear runner" },
        },
        init = function()
            vim.g.VtrUseVtrMaps = 0
            vim.g.VtrStripLeadingWhitespace = 0
            vim.g.VtrClearEmptyLines = 0
            vim.g.VtrAppendNewline = 1
        end,
    },
}
