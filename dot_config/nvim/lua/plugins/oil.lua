return {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    -- stylua: ignore
    keys = {
        { "<leader>e", "<cmd>Oil<cr>", desc = "File Explorer (Oil)" },
        { "<leader>E", function() require("oil").open_float() end, desc = "File Explorer (Oil)" },
    },
    cmd = { "Oil" },
    opts = {
        -- Window-local options to use for oil buffers
        win_options = {
            cursorline = true,
            signcolumn = "yes",
        },
        view_options = {
            sort = {
                { "type", "asc" },
                { "name", "asc" },
            },
        },
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        use_default_keymaps = false,
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-v>"] = "actions.select_vsplit",
            ["<C-x>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["<C-p>"] = "actions.preview",
            ["K"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-q>"] = "actions.close",
            ["<leader>e"] = "actions.close",
            ["<leader>o"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["<BS>"] = "actions.parent",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["+"] = false,
            ["("] = false,
            [")"] = false,
            ["="] = false,
            ['"'] = false,
        },
        -- Configuration for the floating window in oil.open_float
        float = {
            -- Padding around the floating window
            padding = 0,
            max_width = 80,
            max_height = 30,
            border = "rounded",
            win_options = {
                winblend = 0,
            },
            -- This is the config that will be passed to nvim_open_win.
            -- Change values here to customize the layout
            override = function(conf)
                conf.height = math.max(conf.height, 10)
                return conf
            end,
        },
    },
}
