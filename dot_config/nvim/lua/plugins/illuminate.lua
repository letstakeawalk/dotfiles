return {
    "RRethy/vim-illuminate", -- highlight word under cursor using lsp,ts or regex
    event = "BufReadPost",
    config = function()
        local illuminate = require("illuminate")
        illuminate.configure({
            -- providers: provider used to get references in the buffer, ordered by priority
            providers = {
                "lsp",
                "treesitter",
                -- "regex",
            },
            -- delay: delay in milliseconds
            delay = 500,
            -- filetype_overrides: filetype specific overrides.
            -- The keys are strings to represent the filetype while the values are tables that
            -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
            filetype_overrides = {},
            -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
            filetypes_denylist = {
                "dirvish",
                "fugitive",
            },
            -- filetypes_allowlist: filetypes to illuminate, this is overriden by filetypes_denylist
            filetypes_allowlist = {},
            -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
            -- See `:help mode()` for possible values
            modes_denylist = {},
            -- modes_allowlist: modes to illuminate, this is overriden by modes_denylist
            -- See `:help mode()` for possible values
            modes_allowlist = { "n" },
            -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
            -- Only applies to the 'regex' provider
            -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
            providers_regex_syntax_denylist = {},
            -- providers_regex_syntax_allowlist: syntax to illuminate, this is overriden by providers_regex_syntax_denylist
            -- Only applies to the 'regex' provider
            -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
            providers_regex_syntax_allowlist = {},
            -- under_cursor: whether or not to illuminate under the cursor
            under_cursor = true,
            -- large_file_cutoff: number of lines at which to use large_file_config
            -- The `under_cursor` option is disabled when this cutoff is hit
            large_file_cutoff = nil,
            -- large_file_config: config to use for large files (based on large_file_cutoff).
            -- Supports the same keys passed to .configure
            -- If nil, vim-illuminate will be disabled for large files.
            large_file_overrides = nil,
            -- min_count_to_highlight: minimum number of matches required to perform highlighting
            min_count_to_highlight = 2,
            -- default_keymaps = false,
        })

        -- disable default keymappings
        vim.keymap.del("n", "<a-n>")
        vim.keymap.del("n", "<a-p>")
        vim.keymap.del({ "o", "x" }, "<a-i>")
        vim.keymap.set("n", "<s-down>", illuminate.goto_next_reference, { desc = "Move to next reference" })
        vim.keymap.set("n", "<s-up>", illuminate.goto_prev_reference, { desc = "Move to previous reference" })
        -- vim.keymap.set("o", "<s-right>", illuminate.textobj_select, { desc = "Select textobject" })
        -- vim.keymap.set("x", "<s-right>", illuminate.textobj_select, { desc = "Select textobject" })

        local nord = require("utils").nord
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = nord.c02 })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = nord.c02 })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = nord.c02 })
    end,
}
