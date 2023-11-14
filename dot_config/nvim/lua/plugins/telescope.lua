return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- use fzf
        "nvim-telescope/telescope-symbols.nvim", -- symbol picker
        "nvim-telescope/telescope-file-browser.nvim", -- file browser
        "tsakirist/telescope-lazy.nvim", -- lazy.nvim
        "ahmedkhalf/project.nvim", -- project.nvim
    },
    cmd = { "Telescope" },
    -- stylua: ignore
    keys = {
        -- consider <leader><leader> instead of <leader>t
        -- keymaps
        { "<leader>b",  "<cmd>Telescope buffers<cr>",                desc = "Buffers (Telescope)" },
        { "<leader>f",  "<cmd>Telescope find_files<cr>",             desc = "Files (Telescope)" },
        { "<leader>F",  "<cmd>Telescope find_files hidden=true<cr>", desc = "All Files (Telescope)" },
        { "<leader>p",  "<cmd>Telescope live_grep<cr>",              desc = "Live Grep (Telescope)" },
        { "<leader>tA", "<cmd>Telescope autocommands<cr>",           desc = "Autocmd" },
        { "<leader>tB", "<cmd>Telescope builtin<cr>",                desc = "Builtin Pickers" },
        { "<leader>tc", "<cmd>Telescope commands<cr>",               desc = "Commands" },
        { "<leader>td", "<cmd>Telescope diagnostics<cr>",            desc = "Diagnostic" },
        { "<leader>th", "<cmd>Telescope help_tags<cr>",              desc = "Help" },
        { "<leader>tH", "<cmd>Telescope highlights<cr>",             desc = "Highlight" },
        { "<leader>tk", "<cmd>Telescope keymaps<cr>",                desc = "Keymaps" },
        { "<leader>tM", "<cmd>Telescope marks<cr>",                  desc = "Marks" },
        { "<leader>tm", "<cmd>Telescope man_pages<cr>",              desc = "Man Pages" },
        { "<leader>to", "<cmd>Telescope oldfiles<cr>",               desc = "Old Files" },
        { "<leader>tq", "<cmd>Telescope quickfix<cr>",               desc = "Quickfix" },
        { "<leader>tr", "<cmd>Telescope resume<cr>",                 desc = "Resume" },
        { "<leader>ts", "<cmd>Telescope spell_suggest<cr>",          desc = "Spell Suggest" },
        { "<leader>tS", "<cmd>Telescope symbols<cr>",                desc = "Symbols" },
        { "<leader>tT", "<cmd>Telescope treesitter<cr>",             desc = "Treesitter" },
        { "<leader>tO", "<cmd>Telescope vim_options<cr>",            desc = "Vim Options" },
        { "<A-s>",      "<cmd>Telescope symbols<cr>",                desc = "Symbols", mode = "i" },
        -- extensions
        { "<leader>tz", "<cmd>Telescope lazy<cr>",         desc = "Lazy" },
        { "<leader>tb", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
        { "<leader>tl", "<cmd>Telescope tldr<cr>",         desc = "Tldr" },
        -- { "<leader>tf", "<cmd>Telescope projects<cr>", desc = "Projects" },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local trouble = require("trouble.providers.telescope")
        telescope.load_extension("fzf") -- telescope-fzf-native
        telescope.load_extension("file_browser") -- telescope-file-browser
        telescope.load_extension("lazy") -- lazy.nvim
        telescope.load_extension("harpoon") -- harpoon.nvim
        telescope.load_extension("refactoring") -- refactoring.nvim
        telescope.load_extension("git_worktree") -- git-worktree.nvim
        telescope.load_extension("persisted") -- persisted.nvim
        -- telescope.load_extension("projects") -- project.nvim
        -- stylua: ignore
        telescope.setup({
            defaults = {
                layout_strategy = "center", -- horizontal, center, vertical
                layout_config = { width = 80, height = 0.25 },
                borderchars = {
                    prompt  = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                    results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                },
                results_title    = false,
                sorting_strategy = "ascending",
                prompt_prefix    = "   ", -- ' 🔭🔎 ',
                selection_caret  = "  ",
                multi_icon       = "  ",
                entry_prefix     = "   ",
                file_ignore_patterns = { "%.lock", "lock%.json" },
                mappings = {
                    i = {
                        ["?"]     = "which_key",
                        ["<ESC>"] = actions.close,
                        ["<M-q>"] = trouble.open_with_trouble,
                        ["<C-q>"] = actions.close,
                    },
                    n = {
                        ["k"]     = actions.move_selection_next,
                        ["h"]     = actions.move_selection_previous,
                        ["<M-q>"] = trouble.open_with_trouble,
                    },
                },
            },
            pickers = {
                find_files = {
                    find_command = {
                        "fd",
                        "--type", "f",
                        "--follow",
                        "--exclude", ".git",
                        "--exclude", "node_modules",
                        "--exclude", "target",
                    },
                },
                -- find_files opt.cwd ?? is not set and not being used
                -- TODO: why does telescope changing pwd on rust workspaces?
                -- TODO: config fd
                -- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#remove--from-fd-results
                -- TODO: keybinding to cd .. in file picker
            },
            extensions = {
                file_browser = { hijack_netrw = true },
                lazy = {
                    mappings = {
                        open_in_browser           = "<C-o>",
                        open_in_file_browser      = "<C-z>",
                        open_in_find_files        = "<C-f>",
                        open_in_live_grep         = "<C-p>",
                        open_plugins_picker       = "<C-g>", -- Works only after having called first another action
                        open_lazy_root_find_files = "<C-r>f",
                        open_lazy_root_live_grep  = "<C-r>g",
                    },
                },
                tldr = {},
                persisted = {
                    -- layout_config = { width = 0.55, height = 0.55 }
                },
            },
        })

        -- highlight
        -- stylua: ignore start
        local nord = require("utils.nord")
        vim.api.nvim_set_hl(0, "TelescopeTitle",          { link = "FloatTitle" })
        vim.api.nvim_set_hl(0, "TelescopeBorder",         { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder",   { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "TelescopeResultsBorder",  { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "TelescopePreviewBorder",  { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "TelescopePromptPrefix",   { link = "TelescopeTitle" })
        vim.api.nvim_set_hl(0, "TelescopeMatching",       { fg = nord.fg, bold = true })
        vim.api.nvim_set_hl(0, "TelescopeResultsNormal",  { fg = nord.c04_wht_dk })
        vim.api.nvim_set_hl(0, "TelescopeSelection",      { link = "Visual" })
        vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { link = "TelescopeSelection" })
        -- stylua: ignore end

        -- list of extensions
        -- nvim-telescope/telescope-dap.nvim
        -- nvim-telescope/telescope-frecency.nvim, -- frecency alg
        -- nvim-telescope/telescope-live-grep-args.nvim
        -- kkharji/sqlite.lua, -- req by telescope-frecency.nvim
        -- nvim-telescope/telescope-github.nvim
        -- sudormrfbin/cheatsheet.nvim
        -- danielpieper/telescope-tmuxinator.nvim

        -- barrett-ruth/telescope-http.nvim
        -- chip/telescope-software-licenses.nvim
    end,
}
