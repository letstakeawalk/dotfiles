-- NOTE: notable markdown plugins
-- mzlogin/vim-markdown-toc -- toc generator
-- jubnzv/mdeval.nvim -- eval codeblock
return {
    {
        "mickael-menu/zk-nvim",
        enabled = false,
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-treesitter/nvim-treesitter" },
        ft = { "markdown" },
        event = { "BufReadPre " .. vim.env.OBSIDIAN .. "/**.md" },
        keys = {
            { "<leader>nf", "<cmd>ZkNotes { sort = { 'modified' } }<cr>", desc = "Find Notes" },
            { "<leader>nf", ":'<,'>ZkMatch<CR>", mode = "v", desc = "Find Notes" },
            { "<leader>nt", "<cmd>ZkTags<cr>", desc = "Find Tags" },
            { "<leader>nn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>", desc = "New Note" },
            {
                "<leader>nd",
                "<cmd>ZkNew { title = os.date('%Y-%m-%d-%a'), dir = vim.fn.expand('$OBSIDIAN/journals/daily') }<cr>",
                desc = "Daily Note",
            },
            {
                "<leader>nw",
                "<cmd>ZkNew { title = 'Week-'..os.date('%V')..'-'..os.date('%Y'), dir = vim.fn.expand('$OBSIDIAN/journals/weekly') }<cr>",
                desc = "Weekly Note",
            },
        },
        config = function()
            local zk = require("zk")

            -- custom commands
            local zkcmd = require("zk.commands")
            local function make_edit_fn(defaults, picker_options)
                return function(options)
                    options = vim.tbl_extend("force", defaults, options or {})
                    zk.edit(options, picker_options)
                end
            end
            zkcmd.add("ZkOrphans", make_edit_fn({ orphans = true }, { title = "Zk Orphans" }))
            zkcmd.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))

            -- keymaps
            local on_attach = function()
                -- TODO: use api to set keymaps not <cmd>XXX<cr>
                if require("zk.util").notebook_root(vim.fn.expand("%:p")) ~= nil then
                    local find_notes = "<cmd>ZkNotes { sort = { 'modified' }, excludeHrefs = { '_templates' } }<cr>"
                    vim.keymap.set("n", "<leader>no", "<cmd>ZkOrphans<cr>", { desc = "Orphans", buffer = true })
                    vim.keymap.set("n", "<leader>f", find_notes, { desc = "Find Notes", buffer = true })
                    -- TODO: ask user for choice (new, dev, daily, weekly, cwd)
                    local new_note_cwd =
                        "<cmd>ZkNew { title = vim.fn.input('Title: '), dir = vim.fn.expand('%:p:h'), template = 'default.md' }<cr>"
                    vim.keymap.set("n", "<leader>nc", new_note_cwd, { desc = "New Note in CWD", buffer = true })
                    -- Create a new note in the same directory as the current buffer, using the current selection for note title.
                    local new_note_title = ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h'), template = 'default.md' }<CR>"
                    vim.keymap.set("v", "<leader>nc", new_note_title, { desc = "New Note w/ Content", buffer = true })
                    -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
                    local new_note_selection =
                        ":'<,'>ZkNewFromContentSelection { title = vim.fn.input('Title: '), dir = vim.fn.expand('%:p:h'), template = 'default.md' }<CR>"
                    vim.keymap.set("v", "<leader>nc", new_note_selection, { desc = "New Note w/ Content", buffer = true })
                    local new_note_dev =
                        "<cmd>ZkNew { title = vim.fn.input('Title: '), dir = vim.fn.expand('$OBSIDIAN')..'/Notes/dev', template = 'tech-term.md' }<cr>"
                    vim.keymap.set("n", "<leader>nv", new_note_dev, { desc = "New Dev Note", buffer = true })
                    vim.keymap.set("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Open Link", buffer = true })
                    vim.keymap.set("n", "<leader>nb", "<Cmd>ZkBacklinks<CR>", { desc = "Backlinks", buffer = true })
                    vim.keymap.set("n", "<leader>nl", "<Cmd>ZkLinks<CR>", { desc = "Outgoing Links", buffer = true })
                end
            end

            zk.setup({
                picker = "telescope",
                lsp = {
                    config = {
                        cmd = { "zk", "lsp" },
                        name = "zk",
                        on_attach = on_attach,
                    },
                    auto_attach = {
                        enabled = true,
                        filetypes = { "markdown" },
                    },
                },
            })
        end,
    },
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
                group = require("utils").create_augroup("Bullet", {}),
                pattern = { "markdown", "text", "gitcommit" },
                -- stylua: ignore
                callback = function()
                    vim.keymap.set("i", "<cr>",           "<Plug>(bullets-newline)",         { buffer = true })
                    vim.keymap.set("i", "<s-cr>",         "<cr>",                            { buffer = true, noremap = true })
                    vim.keymap.set("n", "o",              "<Plug>(bullets-newline)",         { buffer = true })
                    vim.keymap.set({ "n", "v" }, "gN",    "<Plug>(bullets-renumber)",        { buffer = true, desc = "Re-number ordered-list" })
                    vim.keymap.set("n", "<leader>nx",     "<Plug>(bullets-toggle-checkbox)", { buffer = true, desc = "Toggle checkbox"})
                    vim.keymap.set("n", ">>",             "<Plug>(bullets-demote)",          { buffer = true, desc = "Demote bullet" })
                    vim.keymap.set("n", "<<",             "<Plug>(bullets-promote)",         { buffer = true, desc = "Promote bullet" })
                    vim.keymap.set("i", "<C-v>",          "<Plug>(bullets-demote)",          { buffer = true, desc = "Demote bullet" })
                    vim.keymap.set("i", "<C-d>",          "<Plug>(bullets-promote)",         { buffer = true, desc = "Promote bullet" })
                    vim.keymap.set("v", ">",              "<Plug>(bullets-demote)",          { buffer = true, desc = "Demote bullet" })
                    vim.keymap.set("v", "<",              "<Plug>(bullets-promote)",         { buffer = true, desc = "Promote bullet" })
                end,
            })
        end,
    },
}
