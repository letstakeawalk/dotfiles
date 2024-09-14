return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- use fzf
        "nvim-telescope/telescope-ui-select.nvim",
        "tsakirist/telescope-lazy.nvim", -- lazy.nvim
        -- "nvim-telescope/telescope-smart-history.nvim"
    },
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
        { "<leader>b",  "<cmd>Telescope buffers<cr>",                               desc = "Buffers (Telescope)" },
        { "<leader>f",  "<cmd>Telescope find_files<cr>",                            desc = "Files (Telescope)" },
        { "<leader>F",  "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", desc = "All Files (Telescope)" },
        { "<leader>p",  "<cmd>Telescope live_grep<cr>",                             desc = "Live Grep (Telescope)" },
        { "<leader>tA", "<cmd>Telescope autocommands<cr>",                          desc = "Autocmd" },
        { "<leader>tb", "<cmd>Telescope builtin<cr>",                               desc = "Builtin Pickers" },
        { "<leader>tc", "<cmd>Telescope commands<cr>",                              desc = "Commands" },
        { "<leader>th", "<cmd>Telescope help_tags<cr>",                             desc = "Help" },
        { "<leader>tH", "<cmd>Telescope highlights<cr>",                            desc = "Highlight" },
        { "<leader>tk", "<cmd>Telescope keymaps<cr>",                               desc = "Keymaps" },
        { "<leader>tl", "<cmd>Telescope loclist<cr>",                               desc = "Location List" },
        { "<leader>tm", "<cmd>Telescope marks<cr>",                                 desc = "Marks" },
        { "<leader>to", "<cmd>Telescope oldfiles<cr>",                              desc = "Old Files" },
        { "<leader>tq", "<cmd>Telescope quickfix<cr>",                              desc = "Quickfix List" },
        { "<leader>tr", "<cmd>Telescope resume<cr>",                                desc = "Resume" },
        { "<leader>ts", "<cmd>Telescope spell_suggest<cr>",                         desc = "Spell Suggest" },
        { "<leader>tt", "<cmd>Telescope treesitter<cr>",                            desc = "Treesitter" },
        -- extensions
        { "<leader>ta", "<cmd>Telescope aerial<cr>",                                desc = "Aerial" },
        { "<leader>tz", "<cmd>Telescope lazy<cr>",                                  desc = "Lazy" },

        -- { "<leader>td", "<cmd>Telescope diagnostics<cr>",            desc = "Diagnostic" },
        -- { "<leader>tm", "<cmd>Telescope man_pages<cr>",              desc = "Man Pages" },
        -- { "<leader>tS", "<cmd>Telescope symbols<cr>",                desc = "Symbols" },
        -- { "<leader>tO", "<cmd>Telescope vim_options<cr>",            desc = "Vim Options" },
        -- { "<A-s>",      "<cmd>Telescope symbols<cr>",                desc = "Symbols", mode = "i" },

    },
    config = function()
        require("config.telescope")
    end,
}
