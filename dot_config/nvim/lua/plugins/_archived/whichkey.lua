-- TODO: remove
-- key bindings popup
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function()
        local wk = require("which-key")
        -- remove unwanted presets
        local presets = require("which-key.plugins.presets")
        presets.operators["v"] = nil
        presets.objects = {
            a = { name = "around textobject" },
            i = { name = "inside textobject" },
            ["ab"] = "a block from [({ to }])",
            ["ib"] = "inner block from [({ to }])",
            ["ap"] = "a paragraph (with white space)",
            ["ip"] = "paragraph.inner",
            ["as"] = "sentence (with white space)",
            ["is"] = "sentence.inner",
            ["at"] = "tag block (with white space)",
            ["it"] = "tag block.inner",
            -- treesitter
            ["af"] = "@function",
            ["if"] = "@function",
            ["ac"] = "@class",
            ["ic"] = "@class",
            ["aa"] = "@parameter",
            ["ia"] = "@parameter",
            ["ai"] = "@conditional",
            ["ii"] = "@conditional",
            ["ao"] = "@loop",
            ["io"] = "@loop",
            ["aM"] = "@comment",
            ["iM"] = "@comment",
            ["ak"] = "@block",
            ["ik"] = "@block",
            -- gitsign
            ["ih"] = "hunk (git)",
            -- mini.ai
            ["an"] = "next around",
            ["in"] = "next inner",
            ["al"] = "last around",
            ["il"] = "last inner",
            -- leap + spooky.nvim
            ["ar"] = "remote around",
            ["ir"] = "remote inner",
            ["am"] = "magnetic around",
            ["im"] = "magnetic inner",
            -- ["aR"] = "remote around (cross window)",
            -- ["iR"] = "remote inner (cross window)",
            -- ["aG"] = "magnetic around (cross window)",
            -- ["iG"] = "magnetic inner (cross window)",
        }
        presets.motions = {
            ["%"] = "Matching character: '()', '{}', '[]'",
            ["0"] = "Start of line",
            ["^"] = "Start of line (non-blank)",
            ["$"] = "End of line",
            ["gg"] = "First line",
            ["G"] = "Last line",
            ["{"] = "Previous empty line",
            ["}"] = "Next empty line",
            ["f"] = "to next char",
            ["F"] = "to previous char",
            ["t"] = "until next char",
            ["T"] = "until previous char",
        }

        wk.setup({
            plugins = {
                marks = false, -- shows a list of your marks on ' and `
                registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                spelling = { enabled = false },
                presets = {
                    operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                    motions = false, -- adds help for motions (hjkl^$0fFtT{}G,gg)
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true, -- default bindings on <c-w>
                    nav = false, -- misc bindings to work with windows
                    z = true, -- bindings for folds, spelling and others prefixed with z
                    g = false, -- bindings for prefixed with g
                },
            },
            operators = {
                ga = "Easy Align",
                gc = "Comment",
            },
            window = {
                border = "single",
            },
            show_help = false,
            show_keys = false,
            disable = {
                n = { "<C-j>", "<C-l>" },
            },
        })

        wk.register({
            ["<leader>a"] = { name = "Git" },
            ["<leader>c"] = { name = "Copilot & ChatGPT" },
            ["<leader>C"] = { name = "Commands" },
            ["<leader>d"] = { name = "Display" },
            ["<leader>g"] = { name = "Git" },
            ["<leader>i"] = { name = "Info Panels" },
            ["<leader>n"] = { name = "Note Taking" },
            ["<leader>q"] = { name = "Buffer Management" },
            ["<leader>S"] = { name = "Source/Reload" },
            ["<leader>t"] = { name = "Telescope" },
            ["<leader>x"] = { name = "Trouble" },
            ["<leader>k"] = "Leap linewise downward",
            ["<leader>h"] = "Leap linewise upward",
            ["<leader>r"] = {
                name = "Refactor",
                k = "Swap Param >>", -- treesitter
                h = "Swap Param <<", -- treesitter
                w = "Trailing Whitespace",
            },
        })

        wk.register({
            ["<leader>c"] = { name = "+ChatGPT" },
            ["<leader>r"] = { name = "Refactor" },
        }, { mode = "v" })

        wk.register({
            ["cr"] = { name = "Abolish coerce word" },
            ["ga"] = { "+EasyAlign" },
            ["gc"] = { name = "Comment" },
            f = "Flit f forward",
            F = "Flit f backward",
            t = "Flit t forward",
            T = "Flit t backward",
            s = "Leap forward",
            S = "Leap backward",
            ["<C-u>"] = "Scroll up half page",
            ["<C-d>"] = "Scroll down half page",
            ["]"] = "Goto next",
            ["["] = "Goto previous",
        })

        -- WhichKey
        local nord = require("utils.nord")
        vim.api.nvim_set_hl(0, "WhichKey", { fg = nord.c08_teal, bold = true })
        vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = nord.c09_glcr })
        vim.api.nvim_set_hl(0, "WhichKeySeperator", { link = "DiffAdd" })
        vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = nord.c04_wht })
        vim.api.nvim_set_hl(0, "WhichKeyFloat", { link = "NormalFloat" })
        vim.api.nvim_set_hl(0, "WhichKeyBorder", { link = "FloatBorder" })
        vim.api.nvim_set_hl(0, "WhichKeyValue", { link = "Comment" })
    end,
}
