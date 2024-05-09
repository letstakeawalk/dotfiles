---@diagnostic disable: unused-local
return {
    {
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
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "canary",
        enabled = false,
        dependencies = {
            { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
            { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
        },
        event = "VeryLazy",
        options = {
            debug = true, -- Enable debug logging
            --
            -- system_prompt = prompts.COPILOT_INSTRUCTIONS, -- System prompt to use
            -- model = "gpt-4", -- GPT model to use, 'gpt-3.5-turbo' or 'gpt-4'
            -- temperature = 0.1, -- GPT temperature
            --
            -- question_header = "## User ", -- Header to use for user questions
            -- answer_header = "## Copilot ", -- Header to use for AI answers
            -- error_header = "## Error ", -- Header to use for errors
            -- separator = "---", -- Separator to use in chat
            --
            -- show_folds = true, -- Shows folds for sections in chat
            -- show_help = true, -- Shows help message as virtual lines when waiting for user input
            -- auto_follow_cursor = true, -- Auto-follow cursor in chat
            -- auto_insert_mode = false, -- Automatically enter insert mode when opening window and if auto follow cursor is enabled on new prompt
            -- clear_chat_on_new_prompt = false, -- Clears chat on every new prompt
            --
            -- context = nil, -- Default context to use, 'buffers', 'buffer' or none (can be specified manually in prompt via @).
            -- history_path = vim.fn.stdpath("data") .. "/copilotchat_history", -- Default path to stored history
            -- callback = nil, -- Callback to use when ask response is received
            --
            -- -- default selection (visual or line)
            -- selection = function(source)
            --     return select.visual(source) or select.line(source)
            -- end,
            --
            -- -- default prompts
            -- prompts = {
            --     Explain = {
            --         prompt = "/COPILOT_EXPLAIN Write an explanation for the active selection as paragraphs of text.",
            --     },
            --     Review = {
            --         prompt = "/COPILOT_REVIEW Review the selected code.",
            --         ---@diagnostic disable-next-line: redefined-local
            --         callback = function(response, source)
            --             -- see config.lua for implementation
            --         end,
            --     },
            --     Fix = {
            --         prompt = "/COPILOT_GENERATE There is a problem in this code. Rewrite the code to show it with the bug fixed.",
            --     },
            --     Optimize = {
            --         prompt = "/COPILOT_GENERATE Optimize the selected code to improve performance and readablilty.",
            --     },
            --     Docs = {
            --         prompt = "/COPILOT_GENERATE Please add documentation comment for the selection.",
            --     },
            --     Tests = {
            --         prompt = "/COPILOT_GENERATE Please generate tests for my code.",
            --     },
            --     FixDiagnostic = {
            --         prompt = "Please assist with the following diagnostic issue in file:",
            --         selection = select.diagnostics,
            --     },
            --     Commit = {
            --         prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
            --         selection = select.gitdiff,
            --     },
            --     CommitStaged = {
            --         prompt = "Write commit message for the change with commitizen convention. Make sure the title has maximum 50 characters and message is wrapped at 72 characters. Wrap the whole message in code block with language gitcommit.",
            --         selection = function(source)
            --             return select.gitdiff(source, true)
            --         end,
            --     },
            -- },
            --
            -- -- default window options
            -- window = {
            --     layout = "vertical", -- 'vertical', 'horizontal', 'float'
            --     width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
            --     height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
            --     -- Options below only apply to floating windows
            --     relative = "editor", -- 'editor', 'win', 'cursor', 'mouse'
            --     border = "single", -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
            --     row = nil, -- row position of the window, default is centered
            --     col = nil, -- column position of the window, default is centered
            --     title = "Copilot Chat", -- title of chat window
            --     footer = nil, -- footer of chat window
            --     zindex = 1, -- determines if window is on top or below other floating windows
            -- },
            --
            -- -- default mappings
            -- mappings = {
            --     complete = {
            --         detail = "Use @<Tab> or /<Tab> for options.",
            --         insert = "<Tab>",
            --     },
            --     close = {
            --         normal = "q",
            --         insert = "<C-c>",
            --     },
            --     reset = {
            --         normal = "<C-l>",
            --         insert = "<C-l>",
            --     },
            --     submit_prompt = {
            --         normal = "<CR>",
            --         insert = "<C-m>",
            --     },
            --     accept_diff = {
            --         normal = "<C-y>",
            --         insert = "<C-y>",
            --     },
            --     yank_diff = {
            --         normal = "gy",
            --     },
            --     show_diff = {
            --         normal = "gd",
            --     },
            --     show_system_prompt = {
            --         normal = "gp",
            --     },
            --     show_user_selection = {
            --         normal = "gs",
            --     },
            -- },
        },
        -- config = function(_, opts)
        --     local chat = require("CopilotChat")
        --     local prompts = chat.prompts()
        --     local response = chat.response()
        --     local actions = require("CopilotChat.actions")
        --     local select = require("CopilotChat.select")
        --
        --     chat.setup(opts)
        -- end,
    },
}
