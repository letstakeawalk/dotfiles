return {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-treesitter/nvim-treesitter" },
    enabled = true,
    event = { "BufReadPre " .. vim.env.OBSIDIAN .. "/**.md" },
    keys = {
        { "<leader>nn", function() require("telekasten").new_note() end, { "n" }, desc = "New Note" },
        { "<leader>nd", function() require("telekasten").goto_today() end, { "n" }, desc = "Daily Note" },
        { "<leader>nf", function() require("telekasten").find_notes() end, { "n" }, desc = "Find Notes" },
        { "<leader>np", function() require("telekasten").search_notes() end, desc = "Search Note" },
        { "<leader>nh", function() require("telekasten").panel() end, desc = "Telekasten" },
        { "<leader>nN", function() require("telekasten").new_templated_note() end, desc = "New Templated Note" },
    },
    config = function()
        local telekasten = require("telekasten")
        local home = vim.fn.expand("$WORKSPACE/notes")
        telekasten.setup({
            home = home,
            dailies = home .. "/daily",
            templates = home .. "/_templates",
            template_new_daily = home .. "/_templates/daily.md",
            take_over_my_home = true,
            auto_set_syntax = true,
            auto_set_filetype = true,
        })
        -- NOTE: notable markdown plugins
        -- mzlogin/vim-markdown-toc -- toc generator
        -- jubnzv/mdeval.nvim -- eval codeblock

        vim.g.calendar_no_mapping = 1 -- disbale default keymaps for calendar
        -- keymaps
        -- vim.api.nvim_create_autocmd("BufReadPost", {
        vim.api.nvim_create_autocmd("BufRead", {
            group = vim.api.nvim_create_augroup("Telekasten", {}),
            pattern = vim.env.OBSIDIAN .. "/**.md",
            callback = function()
                local task = require("utils.task")
                -- -- config
                vim.opt_local.filetype = "telekasten"
                vim.opt_local.expandtab = false
                vim.opt_local.formatoptions = "cqnlj"
                -- keymaps
                vim.keymap.set("n", "<leader>ni", telekasten.insert_link, { desc = "Insert Link" })
                vim.keymap.set("n", "<leader>no", telekasten.follow_link, { desc = "Follow Link" })
                vim.keymap.set("n", "<leader>nl", telekasten.show_backlinks, { desc = "Show Backlinks", buffer = true })
                vim.keymap.set("n", "<leader>nF", telekasten.find_friends, { desc = "Find Friends", buffer = true })
                vim.keymap.set("n", "<leader>nt", telekasten.show_tags, { desc = "Show Tags", buffer = true })
                vim.keymap.set("n", "<leader>nx", task.toggle_completion, { desc = "Toggle Task" })
                vim.keymap.set("n", "<leader>nac", task.toggle_canceled, { desc = "Set Canceled Tag" })
                vim.keymap.set("n", "<leader>nas", task.toggle_started, { desc = "Set Started Tag" })
                vim.keymap.set("n", "<leader>nad", task.toggle_due, { desc = "Set Due Date" })
                vim.keymap.set("n", "<leader>naS", task.toggle_scheduled, { desc = "Set Scheduled Date" })
                vim.keymap.set("n", "<leader>nap", task.toggle_priority, { desc = "Set Priority" })
                vim.keymap.set("n", "<leader>nar", task.toggle_project, { desc = "Set Project" })
                vim.keymap.set("i", "<C-x>", task.toggle_completion, { desc = "Toggle Todo", buffer = true })
                vim.keymap.set("i", "<C-a>", telekasten.insert_link, { desc = "Insert Link", buffer = true })
                -- go to next heading use TS
                -- refer to treesitter and neorg
                -- imap <C-t> promote
                -- imap <C-s> demote
                -- imap <S-cr> continuous new line
            end,
        })
        -- highlights
        local nord = require("utils.nord")
        vim.api.nvim_set_hl(0, "tkBrackets", { fg = nord.c09_glcr })
    end,
}
