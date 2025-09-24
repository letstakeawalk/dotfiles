---@diagnostic disable: unused-local, unused-function
-- prefil edit window with common scenarios to avoid repeating query and submit immediately
local function prefill_edit_window(request)
    require("avante.api").edit()
    local code_bufnr = vim.api.nvim_get_current_buf()
    local code_winid = vim.api.nvim_get_current_win()
    if code_bufnr == nil or code_winid == nil then
        return
    end
    vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
    -- Optionally set the cursor position to the end of the input
    vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
    -- Simulate Ctrl+S keypress to submit
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
end

-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
local avante_commit =
    "Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block."
local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
local avante_optimize_code = "Optimize the following code"
local avante_summarize = "Summarize the following text"
local avante_explain_code = "Explain the following code"
local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
local avante_add_docstring = "Add docstring to the following codes"
local avante_fix_bugs = "Fix the bugs inside the following codes if any"
local avante_add_tests = "Implement tests for the following code"

return {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    enabled = false,
    version = false, -- Never set this value to "*"! Never!
    -- stylua: ignore start
    keys = {
        -- {"<leader>ag", function() require("avante.api").ask({ question = avante_grammar_correction }) end, desc = "Grammar Correction", mode ={ "n", "v" },},
        -- {"<leader>ak", function() require("avante.api").ask({ question = avante_keywords }) end, desc = "Keywords", mode ={ "n", "v" },},
        -- {"<leader>al", function() require("avante.api").ask({ question = avante_code_readability_analysis }) end, desc = "Code Readability Analysis", mode ={ "n", "v" },},
        -- {"<leader>ao", function() require("avante.api").ask({ question = avante_optimize_code }) end, desc = "Optimize Code", mode ={ "n", "v" },},
        -- {"<leader>am", function() require("avante.api").ask({ question = avante_summarize }) end, desc = "Summarize text", mode ={ "n", "v" },},
        -- {"<leader>ax", function() require("avante.api").ask({ question = avante_explain_code }) end, desc = "Explain Code", mode ={ "n", "v" },},
        -- {"<leader>ac", function() require("avante.api").ask({ question = avante_complete_code }) end, desc = "Complete Code", mode ={ "n", "v" },},
        -- {"<leader>ad", function() require("avante.api").ask({ question = avante_add_docstring }) end, desc = "Docstring", mode ={ "n", "v" },},
        -- {"<leader>ab", function() require("avante.api").ask({ question = avante_fix_bugs }) end, desc = "Fix Bugs", mode ={ "n", "v" },},
        -- {"<leader>au", function() require("avante.api").ask({ question = avante_add_tests }) end, desc = "Add tests", mode ={ "n", "v" },},
    },
    -- stylua: ignore end
    opts = {
        provider = "gemini", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
        mode = "agentic", -- The default mode for interaction. "agentic" uses tools to automatically generate code, "legacy" uses the old planning method to generate code.
        -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
        -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
        -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
        auto_suggestions_provider = "claude",
        providers = {
            gemini = {
                model = "gemini-2.5-flash",
            },
            -- claude = {
            --     endpoint = "https://api.anthropic.com",
            --     model = "claude-3-5-sonnet-20241022",
            --     extra_request_body = {
            --         temperature = 0.75,
            --         max_tokens = 4096,
            --     },
            -- },
        },
        behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
            enable_token_counting = true, -- Whether to enable token counting. Default to true.
            auto_approve_tool_permissions = false, -- Default: show permission prompts for all tools
            enable_fastapply = false,
            -- Examples:
            -- auto_approve_tool_permissions = true,                -- Auto-approve all tools (no prompts)
            -- auto_approve_tool_permissions = {"bash", "replace_in_file"}, -- Auto-approve specific tools only
        },
        mappings = {
            --- @class AvanteConflictMappings
            diff = {
                ours = "co",
                theirs = "ct",
                all_theirs = "ca",
                both = "cb",
                cursor = "cc",
                next = "]x",
                prev = "[x",
            },
            suggestion = {
                accept = "<M-l>",
                next = "<M-]>",
                prev = "<M-[>",
                dismiss = "<C-]>",
            },
            jump = {
                next = "]]",
                prev = "[[",
            },
            submit = {
                normal = "<CR>",
                insert = "<C-s>",
            },
            cancel = {
                normal = { "<C-c>", "<Esc>", "q" },
                insert = { "<C-c>" },
            },
            sidebar = {
                apply_all = "A",
                apply_cursor = "a",
                retry_user_request = "r",
                edit_user_request = "e",
                switch_windows = "<Tab>",
                reverse_switch_windows = "<S-Tab>",
                remove_file = "d",
                add_file = "@",
                close = { "<Esc>", "q" },
                close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
            },
        },
        hints = { enabled = false },
        suggestion = {
            debounce = 600,
            throttle = 600,
        },
        web_search_engine = {
            provider = "google",
            providers = {
                google = {
                    api_key_name = "AVANTE_GOOGLE_SEARCH_API_KEY",
                    engine_id_name = "AVANTE_GOOGLE_SEARCH_ENGINE_ID",
                },
            },
        },
        windows = {
            width = 45,
            input = {
                height = 12,
            },
            sidebar_header = {
                enabled = false,
            },
        },
        shortcuts = {
            {
                name = "document",
                description = "Create code documentation",
                details = "Automatically generate clear and accurate documentation for the provided code, including function descriptions, parameter explanations, and examples.",
                prompt = "Please add clear and comprehensive documentation for the following code. This should include descriptions for functions, explanations for parameters, what the functions return, and potential errors.",
            },
            {
                name = "explain",
                description = "Explain complex code",
                details = "Provide a clear and concise explanation of the given code, breaking down complex logic and functionality into understandable terms.",
                prompt = "Please explain the following code in a clear and concise manner, breaking down any complex logic and functionality.",
            },
            {
                name = "comments",
                description = "Add comments to code",
                details = "Insert clear and concise comments throughout the code to explain its logic and functionality, enhancing readability.",
                prompt = "Please add clear and concise comments to the following code to explain its logic and functionality, improving its readability.",
            },
            {
                name = "commit",
                description = "Write commit message",
                details = "Generates concise commit message",
                prompt = "Write me commit message for staged changes with commitzen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block. I only want the commit message. Do not attempt to run git commit command. Wrap the whole message in code block with language gitcommit.",
            },
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        -- "zbirenbaum/copilot.lua", -- for providers='copilot'
        -- {
        --     -- Make sure to set this up properly if you have lazy=true
        --     "MeanderingProgrammer/render-markdown.nvim",
        --     opts = {
        --         file_types = { "markdown", "Avante" },
        --     },
        --     ft = { "markdown", "Avante" },
        -- },
    },
}
