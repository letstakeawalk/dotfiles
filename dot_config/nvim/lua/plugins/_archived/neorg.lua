-- https://github.com/nvim-neorg/neorg
return {
    "nvim-neorg/neorg",
    -- dir="~/Workspace/Develoment/projects/opensrc/neorg",
    -- dev = true,
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-neorg/neorg-telescope",
        "nvim-telescope/telescope.nvim",
    },
    build = ":Neorg sync-parsers",
    cmd = { "Neorg" },
    ft = "norg",
    init = function()
        vim.keymap.set("n", "<leader>nn", "<cmd>Neorg workspace home<cr>", { desc = "Home" })
        vim.keymap.set("n", "<leader>nw", "<cmd>Neorg workspace work<cr>", { desc = "Work" })
        vim.keymap.set("n", "<leader>no", "<cmd>Neorg journal<cr>", { desc = "Journal" })
        vim.keymap.set("n", "<leader>nc", "<cmd>Neorg toggle-concealer<cr>", { desc = "Conceal Toggl" })
    end,
    config = function()
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("Neorg", {}),
            pattern = "norg",
            callback = function()
                vim.opt_local.formatoptions = "qjln"
            end,
        })
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.keybinds"] = {
                    config = {
                        default_keybinds = false,
                        hook = function(keybinds)
                            -- general
                            keybinds.map_event("norg", "n", "<leader>na", "core.dirman.new.note")
                            keybinds.map_event("norg", "n", "<cr>", "core.esupports.hop.hop-link")
                            keybinds.map_event("norg", "n", ">.", "core.promo.promote")
                            keybinds.map_event("norg", "n", "<,", "core.promo.demote")
                            keybinds.map_event("norg", "n", ">>", "core.promo.promote nested")
                            keybinds.map_event("norg", "n", "<<", "core.promo.demote nested")
                            keybinds.map_event("norg", "i", "<M-CR>", "core.itero.next-iteration")
                            keybinds.map_event("norg", "i", "<C-CR>", "core.itero.next-iteration")
                            keybinds.map_event("norg", "i", "<S-CR>", "core.itero.next-iteration")
                            keybinds.map_event("norg", "i", "<C-l>", "core.integrations.telescope.insert_link") -- TODO: ?? debug
                            keybinds.map("norg", "n", "<leader>nc", "<cmd>Neorg toggle-concealer<cr>", { desc = "Toggle Conceal" })
                            keybinds.map("norg", "n", "<leader>nf", "<cmd>Telescope neorg find_norg_files<cr>", { desc = "Find notes" })
                            keybinds.map("norg", "n", "<leader>f", "<cmd>Telescope neorg find_norg_files<cr>", { desc = "Telescope Notes" })
                            -- editing
                            -- code block snippet
                            -- headers snippet
                            -- bold, italic, etc snippet
                            -- tasks
                            keybinds.map_event("norg", "n", "gtd", "core.qol.todo_items.todo.task_done", { desc = "Task Done" })
                            keybinds.map_event("norg", "n", "gtu", "core.qol.todo_items.todo.task_undone", { desc = "Task Undone" })
                            keybinds.map_event("norg", "n", "gtp", "core.qol.todo_items.todo.task_pending>", { desc = "Task Pending" })
                            keybinds.map_event("norg", "n", "gth", "core.qol.todo_items.todo.task_on_hold", { desc = "Task Hold" })
                            keybinds.map_event("norg", "n", "gtc", "core.qol.todo_items.todo.task_cancelled", { desc = "Task Cancel" })
                            keybinds.map_event("norg", "n", "gtr", "core.qol.todo_items.todo.task_recurring", { desc = "Task Recurring" })
                            keybinds.map_event("norg", "n", "gti", "core.qol.todo_items.todo.task_important", { desc = "Task Important" })
                            keybinds.map_event("norg", "n", "<C-Space>", "core.qol.todo_items.todo.task_cycle")
                            -- mode navigation
                            keybinds.map("norg", "n", "<leader>nh", "<cmd>Neorg mode traverse-heading<cr>", { desc = "Toggle HeadingTrav" })
                            keybinds.map("traverse-heading", "n", "<leader>nh", "<cmd>Neorg mode norg<cr>")
                            keybinds.map("traverse-heading", "n", "<ESC>", "<cmd>Neorg mode norg<cr>")
                            keybinds.map_event("traverse-heading", "n", "k", "core.integrations.treesitter.next.heading")
                            keybinds.map_event("traverse-heading", "n", "h", "core.integrations.treesitter.previous.heading")
                            keybinds.map_event("presenter", "n", "<cr>", "core.presenter.next_page")
                            keybinds.map_event("presenter", "n", "k", "core.presenter.next_page")
                            keybinds.map_event("presenter", "n", "h", "core.presenter.previous_page")
                            keybinds.map_event("presenter", "n", "q", "close")
                            keybinds.map_event("presenter", "n", "<esc>", "close")
                            -- toc
                            keybinds.map("norg", "n", "g0", "<cmd>Neorg toc split<cr>")
                            keybinds.map("norg", "n", "<leader>nt", "<cmd>Neorg toc split<cr>", { desc = "Table of Content" })
                            keybinds.map("presenter", "n", "g0", "<cmd>Neorg toc split<cr>")
                            keybinds.map("traverse-heading", "n", "g0", "<cmd>Neorg toc split<cr>")
                        end,
                    },
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            home = "~/Workspace/notes/home",
                            work = "~/Workspace/notes/work",
                        },
                        use_popup = false,
                        -- use_popup = true,
                    },
                },
                -- ["core.journal"] = {},
                ["core.qol.toc"] = {
                    config = {
                        close_after_use = true,
                    },
                },
                -- ["core.presenter"] = {
                -- 	zen_mode = "zen-mode",
                -- },
                ["core.integrations.nvim-cmp"] = {},
                ["core.integrations.telescope"] = {},
            },
        })

        -- TODO: hl headings
        -- TODO: see insert exit event and how auto formatting is working
    end,
}
