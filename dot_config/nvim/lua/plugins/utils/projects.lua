return {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    enabled = false,
    dev = true,
    opts = {
        -- Manual mode doesn't automatically change your root directory, so you have
        -- the option to manually do so using `:ProjectRoot` command.
        manual_mode = false,
        -- Methods of detecting the root directory. **"lsp"** uses the native neovim
        -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
        -- order matters: if one is not detected, the other is used as fallback. You
        -- can also delete or rearangne the detection methods.
        detection_methods = { "lsp", "pattern" },
            -- All the patterns used to detect root dir, when **"pattern"** is in
            -- detection_methods
            -- stylua: ignore
            patterns = {
                ".git",
                -- "_darcs", ".hg", ".bzr", ".svn", "Makefile",
                -- python
                -- "pyproject.toml", "requirements.txt", "Pipfile", "pyrightconfig.json",
                -- ts
                -- "package.json", "tsconfig.json", "jsconfig.json",
                -- rust
                -- "Cargo.lock", "Cargo.toml",
                -- go
                -- "go.mod",
                -- lua
                -- "init.lua",
                -- "selene.toml", "selene.yml",
                -- custom
                ".proj.root", ".project.root",
            },
        -- Table of lsp clients to ignore by name
        -- eg: { "efm", ... }
        ignore_lsp = {},
        -- Don't calculate root dir on specific directories
        -- Ex: { "~/.cargo/*", ... }
        exclude_dirs = {},
        -- Show hidden files in telescope
        show_hidden = false,
        -- When set to false, you will get a message when project.nvim changes your
        -- directory.
        silent_chdir = true,
        -- What scope to change the directory, valid options are
        -- * global (default)
        -- * tab
        -- * win
        scope_chdir = "global",
        -- Path where project.nvim will store the project history for use in
        -- telescope
        datapath = vim.fn.stdpath("data"),
        mappings = {
            n = {
                find_project_files = "f",
                browse_project_files = "b",
                delete_project = "d",
                search_in_project_files = "p",
                recent_project_files = "r",
                change_working_directory = "w",
            },
            i = {
                find_project_files = "<c-f>",
                browse_project_files = "<c-b>",
                delete_project = "<c-d>",
                search_in_project_files = "<c-p>",
                recent_project_files = "<c-r>",
                change_working_directory = "<c-g>",
            },
        },
    },
    config = function(_, opts) require("project_nvim").setup(opts) end,
}
