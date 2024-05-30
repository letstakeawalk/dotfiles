return {
    {
        "echasnovski/mini.ai",
        event = "BufRead",
        opts = {
            -- Module mappings. Use `''` (empty string) to disable one.
            mappings = {
                -- Main textobject prefixes
                around = "a", -- default: "a"
                inside = "i", -- default: "i"
                -- Next/last textobjects
                around_next = "an",
                inside_next = "in",
                around_last = "al",
                inside_last = "il",
                -- Move cursor to corresponding edge of `a` textobject
                goto_left = "", -- "[a"  default: "g["
                goto_right = "", -- "]a" default: "g]"
            },
            -- How to search for object (first inside current line, then inside
            -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
            -- 'cover_or_nearest', 'next', 'prev', 'nearest'.
            search_method = "cover_or_nearest",
        },
    },

    {
        "echasnovski/mini.clue",
        event = "VeryLazy",
        config = function()
            local miniclue = require("mini.clue")
            miniclue.setup({
                triggers = {
                    { mode = "n", keys = "<Leader>" },
                    { mode = "x", keys = "<Leader>" },
                    { mode = "n", keys = "g" },
                    { mode = "x", keys = "g" },
                    { mode = "n", keys = "<C-w>" },
                    { mode = "n", keys = "z" },
                    { mode = "x", keys = "z" },
                    { mode = "n", keys = "]" },
                    { mode = "n", keys = "[" },
                    { mode = "n", keys = "'" },
                    { mode = "n", keys = "`" },
                    { mode = "x", keys = "'" },
                    { mode = "x", keys = "`" },
                    { mode = "n", keys = '"' },
                    { mode = "x", keys = '"' },
                    -- { mode = "i", keys = "<C-r>" },
                    -- { mode = "c", keys = "<C-r>" },
                },
                clues = {
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),

                    { mode = "n", keys = "<leader>C", desc = "Commands" },
                    { mode = "n", keys = "<leader>c", desc = "Copilot & ChatGPT" },
                    { mode = "n", keys = "<leader>d", desc = "Display" },
                    { mode = "n", keys = "<leader>g", desc = "Git" },
                    { mode = "n", keys = "<leader>i", desc = "Info" },
                    { mode = "n", keys = "<leader>q", desc = "Buffer Management" },
                    { mode = "n", keys = "<leader>r", desc = "Refactor" },
                    -- { mode = "n", keys = "<leader>s", desc = "Session" },
                    { mode = "n", keys = "<leader>t", desc = "Telescope" },
                    { mode = "n", keys = "<leader>x", desc = "Trouble" },
                },
                window = { delay = 300, config = { width = "auto" } },
            })

            miniclue.set_mapping_desc("n", "ga", "Align")

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "fugitive",
                group = require("utils").augroup("MiniClueFugitive", { clear = true }),
                ---@diagnostic disable-next-line: unused-local
                callback = function(data)
                    miniclue.set_mapping_desc("n", "g?", "Help")
                    miniclue.set_mapping_desc("n", "gu", "Jump to Untracked/Unstaged")
                    miniclue.set_mapping_desc("n", "gU", "Jump to Unstaged")
                    miniclue.set_mapping_desc("n", "gs", "Jump to Staged")
                    miniclue.set_mapping_desc("n", "gp", "Jump to Unpushed")
                    miniclue.set_mapping_desc("n", "gP", "Jump to Unpulled")
                    miniclue.set_mapping_desc("n", "gr", "Jump to Rebasing")
                    miniclue.set_mapping_desc("n", "]]", "Jump to Next Section")
                    miniclue.set_mapping_desc("n", "][", "Jump to Next Section (end)")
                    miniclue.set_mapping_desc("n", "[[", "Jump to Prev Section")
                    miniclue.set_mapping_desc("n", "[]", "Jump to Prev Section (end)")
                    miniclue.set_mapping_desc("n", "]m", "Jump to Next File")
                    miniclue.set_mapping_desc("n", "[m", "Jump to Prev File")
                    miniclue.set_mapping_desc("n", "]c", "Jump to Nex Hunk")
                    miniclue.set_mapping_desc("n", "[c", "Jump to Prev Hunk")
                end,
            })
        end,
    },

    {
        "echasnovski/mini.splitjoin",
        event = "BufRead",
        opts = {
            mappings = { toggle = "<leader>rj", split = "", join = "" },
            split = { hooks_pre = {}, hooks_post = {} },
            join = { hooks_pre = {}, hooks_post = {} },
        },
    },
    -- mini.operators -- Text edit operators
    -- mini.doc -- generate nvim help file
}
