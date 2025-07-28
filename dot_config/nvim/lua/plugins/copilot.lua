return {
    {
        "zbirenbaum/copilot.lua",
        enabled = false,
        dependencies = { "hrsh7th/nvim-cmp" },
        event = "InsertEnter",
        cmd = { "Copilot" },
        opts = {
            panel = { enabled = false },
            suggestion = {
                enabled = true,
                auto_trigger = false,
                hide_during_completion = true,
                keymap = {
                    accept = false,
                    accept_word = false,
                    accept_line = false,
                    next = false,
                    prev = false,
                },
            },
        },
        config = function(_, opts)
            require("copilot").setup(opts)

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
            -- stylua: ignore start
            vim.keymap.set("n", "<leader>cT", "<cmd>Copilot toggle<cr>", { desc = "Copilot Toggle" })
            vim.keymap.set("n", "<leader>cs", toggle_auto_trigger,       { desc = "Copilot Suggestion Toggle" })
            vim.keymap.set("i", "<C-e>",      toggle_auto_trigger,       { desc = "Copilot Suggestion Toggle" })
            vim.keymap.set("i", "<C-a>",      suggestion.accept,         { desc = "Copilot Suggestion Accept" })
            -- check cmp keymaps
            -- vim.keymap.set("i", "<C-y>",      suggestion.accept,         { desc = "Copilot Suggestion Accept" })
            -- vim.keymap.set("i", "<C-n>",      suggestion.next,           { desc = "Copilot Next" })
            -- vim.keymap.set("i", "<C-p>",      suggestion.prev,           { desc = "Copilot Previous" })
            -- stylua: ignore end
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        enabled = false,
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        -- build = "make tiktoken",
        -- stylua: ignore
        keys = {
            { "<leader>cc", "<cmd>CopilotChatToggle<cr>",   desc = "CopilotChat toggle",   mode = {"n", "v"} },
            { "<leader>ce", "<cmd>CopilotChatExplain<cr>",  desc = "CopilotChat explain",  mode = {"n", "v"} },
            { "<leader>cr", "<cmd>CopilotChatReview<cr>",   desc = "CopilotChat review",   mode = {"n", "v"} },
            { "<leader>cf", "<cmd>CopilotChatFix<cr>",      desc = "CopilotChat fix",      mode = {"n", "v"} },
            { "<leader>co", "<cmd>CopilotChatOptimize<cr>", desc = "CopilotChat optimize", mode = {"n", "v"} },
            { "<leader>cd", "<cmd>CopilotChatDocs<cr>",     desc = "CopilotChat docs",     mode = {"n", "v"} },
            { "<leader>ct", "<cmd>CopilotChatTests<cr>",    desc = "CopilotChat tests",    mode = {"n", "v"} },
            { "<leader>cC", "<cmd>CopilotChatCommit<cr>",   desc = "CopilotChat commit" },
        },
        opts = {
            model = "gemini-2.5-pro",
            mappings = {
                close = {
                    normal = "q",
                    insert = "<C-q>",
                },
            },
        },
    },
}
