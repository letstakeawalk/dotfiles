-- key bindings popup
return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        -- remove unwanted presets
        local presets = require("which-key.plugins.presets")
        presets.operators["v"] = nil
        presets.objects = {
            a = { name = "around" },
            i = { name = "inside" },
            ["ab"] = [[a block from [({ to }])]],
            ["ap"] = [[a paragraph (with white space)]],
            ["as"] = [[a sentence (with white space)]],
            ["at"] = [[a tag block (with white space)]],
            ["ib"] = [[inner block from [( to ])]],
            ["ip"] = [[inner paragraph]],
            ["is"] = [[inner sentence]],
            ["it"] = [[inner tag block]],
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
        }

        wk.setup({
            plugins = {
                -- TODO: check and disable others
                marks = false, -- shows a list of your marks on ' and `
                registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
                presets = {
                    operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                    motions = true, -- adds help for motions (hjkl^$0fFtT{}G,gg)
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
            a = { name = "Git" },
            c = { name = "Tmux Runner" },
            d = { name = "Display" },
            g = { name = "Telescope" },
            i = { name = "Info Panels" },
            n = { name = "Neorg", a = "New Note" },
            q = { name = "Buffer Management" },
            r = {
                name = "Refactor",
                k = "Swap Param >>", -- treesitter
                h = "Swap Param <<", -- treesitter
                w = "Trailing Whitespace",
            },
            s = { name = "Source/Reload" },
            t = { name = "Telescope" },
            x = { name = "Trouble" },
        }, { prefix = "<leader>" })

        wk.register({
            f = "Flit f forward",
            F = "Flit f backward",
            t = "Flit t forward",
            T = "Flit t backward",
            s = "Leap forward",
            S = "Leap backward",
            ["("] = { name = "Goto Backward (Textobject)" },
            [")"] = { name = "Goto Forward (Textobject)" },
            ["<C-u>"] = "Scroll up half page",
            ["<C-d>"] = "Scroll down half page",
        })
    end,
}
