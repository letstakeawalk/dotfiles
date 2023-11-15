-- NOTE: notable markdown plugins
-- mzlogin/vim-markdown-toc -- toc generator
-- jubnzv/mdeval.nvim -- eval codeblock
return {
    "mickael-menu/zk-nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown", "telekasten" },
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
                vim.keymap.set("n", "<leader>f", "<cmd>ZkNotes { sort = { 'modified' }, excludeHrefs = { '_templates' } }<cr>", { desc = "Find Notes", buffer = true })
                vim.keymap.set("n", "<leader>no", "<cmd>ZkOrphans<cr>", { desc = "Orphans", buffer = true })
                vim.keymap.set(
                    "n",
                    "<leader>nc",
                    "<cmd>ZkNew { title = vim.fn.input('Title: '), dir = vim.fn.expand('%:p:h'), template = 'default.md' }<cr>",
                    { desc = "New Note in CWD", buffer = true }
                )
                -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
                vim.keymap.set(
                    "v",
                    "<leader>nc",
                    ":'<,'>ZkNewFromContentSelection { title = vim.fn.input('Title: '), dir = vim.fn.expand('%:p:h'), template = 'default.md' }<CR>",
                    { desc = "New Note w/ Content", buffer = true }
                )
                vim.keymap.set(
                    "n",
                    "<leader>nv",
                    "<cmd>ZkNew { title = vim.fn.input('Title: '), dir = vim.fn.expand('$OBSIDIAN')..'/notes/dev/general', template = 'tech-term.md' }<cr>",
                    { desc = "New Dev Note", buffer = true }
                )
                vim.keymap.set("n", "<CR>", "<Cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Open Link", buffer = true })
                vim.keymap.set("n", "<leader>nb", "<Cmd>ZkBacklinks<CR>", { desc = "Backlinks", buffer = true })
                vim.keymap.set("n", "<leader>nl", "<Cmd>ZkLinks<CR>", { desc = "Outgoing Links", buffer = true })

                -- task management
                local task = require("utils.task")
                vim.keymap.set("i", "<C-x>", task.toggle_completion, { desc = "Toggle Task", buffer = true })
                vim.keymap.set("n", "<leader>nx", task.toggle_task, { desc = "Toggle List/Task", buffer = true })
                vim.keymap.set("n", "<leader>nax", task.toggle_completion, { desc = "Toggle Task", buffer = true })
                vim.keymap.set("n", "<leader>nac", task.toggle_canceled, { desc = "Set Canceled Tag", buffer = true })
                vim.keymap.set("n", "<leader>nas", task.toggle_started, { desc = "Set Started Tag", buffer = true })
                vim.keymap.set("n", "<leader>nad", task.toggle_due, { desc = "Set Due Date", buffer = true })
                vim.keymap.set("n", "<leader>naS", task.toggle_scheduled, { desc = "Set Scheduled Date", buffer = true })
                vim.keymap.set("n", "<leader>nap", task.toggle_priority, { desc = "Set Priority", buffer = true })
                vim.keymap.set("n", "<leader>nar", task.toggle_project, { desc = "Set Project", buffer = true })
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


        -- TODO: formatlistpattern for lists & tasks
        -- vim.cmd("set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|\\s*[-+*]\\(\\s\\[[^]]\\]\\)\\?\\s\\+")
        -- vim.opt_local.formatlistpat="\\"
        -- vim.cm("set formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|\\s*[-+*]\\(\\s\\[[^]]\\]\\)\\?\\s\\+")
        -- ^\\s*\\d\\+\\.\\s\\+
        -- \\|
        -- ^\\s*[-+*]\\s\\+
        -- \\|
        -- ^\\s*[-+*]\\s\\[[^]]\\]

    end,
}
