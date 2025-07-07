return {
    {
        "bullets-vim/bullets.vim",
        ft = { "markdown", "text", "gitcommit" },
        init = function()
            vim.g.bullets_enabled_file_types = { "markdown", "text", "gitcommit" }
            vim.g.bullets_enable_in_empty_files = 0 -- disable in empty files
            vim.g.bullets_set_mappings = 0 -- disable default mappings
            vim.g.bullets_mapping_leader = ""
            vim.g.bullets_delete_last_bullet_if_empty = 1 -- delete bullet if empty
            vim.g.bullets_auto_indent_after_colon = 1 -- default = 1

            -- Ordered list containing the heirarchical bullet levels, starting from the outer most level.
            -- Available bullet level options (cannot use the same marker more than once)
            -- ROM/rom = upper/lower case Roman numerals (e.g., I, II, III, IV)
            -- ABC/abc = upper/lower case alphabetic characters (e.g., A, B, C)
            -- std[-/*/+] = standard bullets using a hyphen (-), asterisk (*), or plus (+) as the marker.
            -- chk = checkbox (- [ ])
            vim.g.bullets_outline_levels = { "std-" }
            vim.g.bullets_checkbox_markers = " .oOx"
        end,
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("bullets", {}),
                pattern = { "markdown", "text", "gitcommit" },
                callback = function()
                    -- stylua: ignore start
                    vim.keymap.set("i", "<cr>",           "<Plug>(bullets-newline)",         { buffer = true })
                    vim.keymap.set("i", "<s-cr>",         "<cr>",                            { buffer = true, noremap = true })
                    vim.keymap.set("n", "o",              "<Plug>(bullets-newline)",         { buffer = true })
                    vim.keymap.set({ "n", "v" }, "gN",    "<Plug>(bullets-renumber)",        { buffer = true, desc = "Re-number ordered-list" })
                    vim.keymap.set("n", "<leader>nx",     "<Plug>(bullets-toggle-checkbox)", { buffer = true, desc = "Toggle checkbox"})
                    vim.keymap.set("n", ">>",             "<Plug>(bullets-demote)",          { buffer = true, desc = "Demote bullet" })
                    vim.keymap.set("n", "<<",             "<Plug>(bullets-promote)",         { buffer = true, desc = "Promote bullet" })
                    vim.keymap.set("i", "<C-v>",          "<Plug>(bullets-demote)",          { buffer = true, desc = "Demote bullet" })
                    vim.keymap.set("i", "<C-d>",          "<Plug>(bullets-promote)",         { buffer = true, desc = "Promote bullet" })
                    vim.keymap.set("v", ">",              "<Plug>(bullets-demote):normal! gv",  { buffer = true, desc = "Demote bullet" })
                    vim.keymap.set("v", "<",              "<Plug>(bullets-promote):normal! gv", { buffer = true, desc = "Promote bullet" })
                    -- stylua: ignore end
                end,
            })
        end,
    },
}
