return {
    "RRethy/vim-illuminate", -- highlight word under cursor using lsp,ts or regex
    event = "LspAttach",
    config = function()
        local illuminate = require("illuminate")
        illuminate.configure({
            -- provider used to get references in the buffer, ordered by priority
            providers = { "lsp", "treesitter" }, -- "regex",
            -- delay in milliseconds
            delay = 500,
            -- filetype specific overrides.
            -- The keys are strings to represent the filetype while the values are tables that
            -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
            filetype_overrides = {},
            -- filetypes to not illuminate, this overrides filetypes_allowlist
            filetypes_denylist = { "fugitive" },
            -- filetypes to illuminate, this is overriden by filetypes_denylist
            filetypes_allowlist = {},
            -- modes to not illuminate, this overrides modes_allowlist
            modes_denylist = {},
            -- modes to illuminate, this is overriden by modes_denylist
            modes_allowlist = { "n" },
            -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
            providers_regex_syntax_denylist = {},
            -- syntax to illuminate, this is overriden by providers_regex_syntax_denylist
            providers_regex_syntax_allowlist = {},
            -- whether or not to illuminate under the cursor
            under_cursor = true,
            -- number of lines at which to use large_file_config
            -- The `under_cursor` option is disabled when this cutoff is hit
            large_file_cutoff = nil,
            -- config to use for large files (based on large_file_cutoff).
            -- Supports the same keys passed to .configure
            -- If nil, vim-illuminate will be disabled for large files.
            large_file_overrides = nil,
            -- minimum number of matches required to perform highlighting
            min_count_to_highlight = 2,
            -- default_keymaps = false,
        })

        -- disable default keymappings
        vim.keymap.del("n", "<a-n>")
        vim.keymap.del("n", "<a-p>")
        vim.keymap.del({ "o", "x" }, "<a-i>")
        -- vim.keymap.set("n", "<C-n>", illuminate.goto_next_reference, { desc = "Goto next ref" })
        -- vim.keymap.set("n", "<C-S-n>", illuminate.goto_prev_reference, { desc = "Goto previous ref" })
        -- vim.keymap.set("o", "<s-right>", illuminate.textobj_select, { desc = "Select textobject" })
        -- vim.keymap.set("x", "<s-right>", illuminate.textobj_select, { desc = "Select textobject" })

        local nord = require("utils.nord")
        vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = nord.c02_gry })
        vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = nord.c02_gry })
        vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = nord.c02_gry })
    end,
}
