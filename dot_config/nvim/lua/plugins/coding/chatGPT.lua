-- TODO: try out chatGPT
-- https://github.com/jackMort/ChatGPT.nvim
return {
    "jackMort/ChatGPT.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    cmd = {
        "ChatGPT", -- gpt-3.5-turbo
        "ChatGPTActAs", -- gpt-3.5-turbo
        "ChatGPTEditWithInstructions",
        "ChatGPTRun",
    },
    keys = {
        { "<leader>cg", "<cmd>ChatGPT<cr>", desc = "ChatGPT" },
        { "<leader>cA", "<cmd>ChatGPTActAs<cr>", desc = "ChatGPT Act as" },
        { "<leader>cR", "<cmd>ChatGPTRun<cr>", desc = "ChatGPT Run" },
        { "<leader>ce", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "ChatGPT Edit with Instructions", mode = "v" },
        -- { "<leader>cI", "<cmd>ChatGPTEditWithInstructions<cr>", desc = "ChatGPT Edit with Instructions" },
    },
    config = function()
        require("chatgpt").setup({
            api_key_cmd = "op read op://Personal/OpenAI/api_key --no-newline",
            chat = {
                question_sign = " ",
                answer_sign = "",
                keymaps = {
                    close = { "<C-c>", "<C-q>" },
                },
            },
            popup_input = {
                submit = "<C-s>", -- default: <C-Enter>
                submit_n = "<Enter>", -- default: <Enter>
            },
        })

        vim.cmd([[sign undefine chatgpt_action_start_block]])
        vim.cmd([[sign undefine chatgpt_action_middle_block]])
        vim.cmd([[sign undefine chatgpt_action_end_block]])
        vim.cmd([[sign undefine chatgpt_chat_start_block]])
        vim.cmd([[sign undefine chatgpt_chat_middle_block]])
        vim.cmd([[sign undefine chatgpt_chat_end_block]])

        local nord = require("utils.nord")
        vim.api.nvim_set_hl(0, "ChatGPTQuestion", { fg = nord.c08_teal })

        -- highlight groups
        -- ChatGPTWelcome
        -- ChatGPTQuestion
        -- ChatGPTCompletion
        -- ChatGPTTotalTokens
        -- ChatGPTMessageAction
        -- ChatGPTSelectedMessage
        -- ChatGPTTotalTokenBorder
    end,
}
