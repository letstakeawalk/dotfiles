return {
    "nvim-lua/plenary.nvim",

    -- utils
    { "tpope/vim-repeat", event = "VeryLazy" }, -- enable repeating supported plugin maps with `.`

    -- ui-enhancer
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {
            override = {
                rs = { icon = "", color = "#dea584", cterm_color = "216", name = "Rs" },
            },
        },
    },

    -- debug & test
    -- https://github.com/mfussenegger/nvim-dap
    -- https://github.com/jay-babu/mason-nvim-dap.nvim
    -- https://github.com/rcarriga/nvim-dap-ui
    -- https://github.com/nvim-neotest/neotest

    -- ui
    -- https://github.com/folke/noice.nvim
    -- https://github.com/MunifTanjim/nui.nvim
    -- https://github.com/rcarriga/nvim-notify

    -- utils
    -- https://github.com/sQVe/sort.nvim -- smart sorting
    -- https://github.com/0styx0/abbreinder.nvim -- abbreviation reminder
    -- https://github.com/derektata/lorem.nvim -- lorem ipsum generator
    -- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim -- tailwindcss colorizer
    -- https://github.com/barklan/capslock.nvim -- software capslock
    -- https://github.com/vuki656/package-info.nvim -- packages.json info w/ virtual text

    -- practice
    -- https://github.com/ThePrimeagen/vim-be-good

    -- probably not needed
    -- https://github.com/kevinhwang91/nvim-bqf -- better quickfix window

    -- NOTE: some config examples
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
    -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
}
