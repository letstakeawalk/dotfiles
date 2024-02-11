return {
    {
        "christoomey/vim-tmux-navigator",
        keys = {
            { "<C-j>", "<cmd>TmuxNavigateLeft<cr>", desc = "Tmux Navigate Left" },
            { "<C-k>", "<cmd>TmuxNavigateDown<cr>", desc = "Tmux Navigate Down" },
            { "<C-h>", "<cmd>TmuxNavigateUp<cr>", desc = "Tmux Navigate Up" },
            { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Tmux Navigate Right" },
        },
        init = function()
            vim.g.tmux_navigator_no_mappings = 1 -- custom mappings
            vim.g.tmux_navigator_disable_when_zoomed = 1 -- disable when the Vim pane is zoomed
            vim.g.tmux_navigator_preserve_zoom = 1 -- preserve zoom when navigating between panes

            -- tmux-sessionizer
            vim.keymap.set("n", "<leader>st", "<cmd>!tmux_sessionizer<cr>", { desc = "Tmux sessionizer", silent = true })

            -- tmux popup session
            -- stylua: ignore start
            vim.keymap.set("n", "<C-\\>", function() vim.fn.system("tmux popup -h 90% -w 95% -b rounded -S fg='#5E81AC' -E -d " .. vim.loop.cwd() .. " 'tmux new -As popup'") end, { desc = "Tmux Popup" })
            vim.keymap.set("n", "<C-w>n", function() vim.fn.system("tmux popup -h 90% -w 95% -b rounded -S fg='#5E81AC' -E -d " .. vim.loop.cwd()) end, { desc = "Tmux Popup" })
            vim.keymap.set("n", "<leader>gG", function() vim.fn.system("tmux popup -h 90% -w 95% -b rounded -S fg='#5E81AC' -E -d " .. vim.loop.cwd() .. " lazygit") end, { desc = "LazyGit" })
            -- stylua: ignore end
        end,
    },
}
