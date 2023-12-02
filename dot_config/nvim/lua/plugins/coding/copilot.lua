return {
    "zbirenbaum/copilot.lua",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
    cmd = { "Copilot" },
    keys = {
        { "<leader>cE", "<cmd>Copilot enable<cr>", desc = "Copilot Enable" },
        { "<leader>cD", "<cmd>Copilot disable<cr>", desc = "Copilot Disable" },
    },
    init = function() end,
    config = function()
        local copilot = require("copilot")
        copilot.setup({
            panel = { enabled = false },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = false,
                    accept_word = false,
                    accept_line = false,
                    next = false,
                    prev = false,
                    dismiss = false,
                },
            },
            filetypes = {
                python = true,
                rust = true,
                java = true,
                javascript = true,
                typescript = true,
                svelte = true,
                c = true,
                cpp = true,
                go = true,
                lua = true,
                ruby = true,
                css = true,
                html = true,
                ["*"] = false,
            },
        })

        local suggestion = require("copilot.suggestion")
        local function toggle_auto_trigger()
            local auto_trigg = vim.b.copilot_suggestion_auto_trigger
            if auto_trigg == nil or auto_trigg == true then
                vim.notify("Copilot auto-suggestion disabled")
                suggestion.dismiss()
            else
                vim.notify("Copilot auto-suggestion enabled")
                suggestion.next()
            end
            suggestion.toggle_auto_trigger()
        end
        vim.keymap.set("n", "<leader>ct", "<cmd>Copilot toggle<cr>", { desc = "Copilot Toggle" })
        vim.keymap.set("n", "<leader>cs", toggle_auto_trigger, { desc = "Copilot Suggestion Toggle" })
        vim.keymap.set("i", "<C-e>", toggle_auto_trigger, { desc = "Copilot Suggestion Toggle" })
        vim.keymap.set("i", "<C-a>", suggestion.accept, { desc = "Copilot Suggestion Accept" })
        vim.keymap.set("i", "<C-y>", suggestion.accept, { desc = "Copilot Suggestion Accept" })
        vim.keymap.set("i", "<C-n>", suggestion.next, { desc = "Copilot Next" })
        vim.keymap.set("i", "<C-p>", suggestion.prev, { desc = "Copilot Previous" })
        vim.keymap.set("i", "<C-k>", suggestion.next, { desc = "Copilot Next" })
        vim.keymap.set("i", "<C-h>", suggestion.prev, { desc = "Copilot Previous" })

        -- local cmp = require("cmp")
        -- cmp.event:on("menu_opened", function() vim.b.copilot_suggestion_hidden = true end)
        -- cmp.event:on("menu_closed", function() vim.b.copilot_suggestion_hidden = false end)
    end,
}
