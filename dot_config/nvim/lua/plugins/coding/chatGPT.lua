return {
    "jackMort/ChatGPT.nvim",
    enabled = false,
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
    -- stylua: ignore
    keys = {
        { "<leader>cc", "<cmd>ChatGPT<cr>",                              desc = "ChatGPT" },
        { "<leader>cA", "<cmd>ChatGPTActAs<cr>",                         desc = "ChatGPT Act as" },
        { "<leader>ce", "<cmd>ChatGPTEditWithInstructions<cr>",          desc = "Edit with Instructions",    mode = { "n", "v" } },
        { "<leader>cg", "<cmd>ChatGPTRun grammar_correction<cr>",        desc = "Grammar Correction",        mode = { "n", "v" } },
        { "<leader>ct", "<cmd>ChatGPTRun translate<cr>",                 desc = "Translate",                 mode = { "n", "v" } },
        { "<leader>ck", "<cmd>ChatGPTRun keywords<cr>",                  desc = "Keywords",                  mode = { "n", "v" } },
        { "<leader>cd", "<cmd>ChatGPTRun docstring<cr>",                 desc = "Docstring",                 mode = { "n", "v" } },
        { "<leader>ca", "<cmd>ChatGPTRun add_tests<cr>",                 desc = "Add Tests",                 mode = { "n", "v" } },
        { "<leader>co", "<cmd>ChatGPTRun optimize_code<cr>",             desc = "Optimize Code",             mode = { "n", "v" } },
        { "<leader>cs", "<cmd>ChatGPTRun summarize<cr>",                 desc = "Summarize",                 mode = { "n", "v" } },
        { "<leader>cf", "<cmd>ChatGPTRun fix_bugs<cr>",                  desc = "Fix Bugs",                  mode = { "n", "v" } },
        { "<leader>cx", "<cmd>ChatGPTRun explain_code<cr>",              desc = "Explain Code",              mode = { "n", "v" } },
        { "<leader>cl", "<cmd>ChatGPTRun code_readability_analysis<cr>", desc = "Code Readability Analysis", mode = { "n", "v" } },
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
                submit_n = "<Enter>", -- normal mode submit -- default: <Enter>
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
    end,
}
