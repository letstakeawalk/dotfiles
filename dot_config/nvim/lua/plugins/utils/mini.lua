return {
    {
        "echasnovski/mini.ai", -- a/i textobjects (wellle/targets.vim alt)
        version = false,
        event = "BufRead",
        opts = {
            -- Table with textobject id as fields, textobject specification as values.
            -- Also use this to disable builtin textobjects. See |MiniAi.config|.
            custom_textobjects = nil,
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
            -- Number of lines within which textobject is searched
            n_lines = 50,
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
                    -- Leader triggers
                    { mode = "n", keys = "<Leader>" },
                    { mode = "x", keys = "<Leader>" },
                    { mode = "n", keys = "g" },
                    { mode = "x", keys = "g" },
                    { mode = "n", keys = "<C-w>" },
                    { mode = "n", keys = "z" },
                    { mode = "x", keys = "z" },
                    { mode = "n", keys = "]" },
                    { mode = "n", keys = "[" },
                },
                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                    -- miniclue.gen_clues.g(),

                    { mode = "n", keys = "<leader>C", desc = "Commands" },
                    { mode = "n", keys = "<leader>c", desc = "Copilot & ChatGPT" },
                    { mode = "n", keys = "<leader>d", desc = "Display" },
                    { mode = "n", keys = "<leader>g", desc = "Git" },
                    { mode = "n", keys = "<leader>i", desc = "Info" },
                    { mode = "n", keys = "<leader>n", desc = "Note Taking" },
                    { mode = "n", keys = "<leader>q", desc = "Buffer Management" },
                    { mode = "n", keys = "<leader>r", desc = "Refactor" },
                    { mode = "n", keys = "<leader>S", desc = "Source/Reload" },
                    { mode = "n", keys = "<leader>s", desc = "Session" },
                    { mode = "n", keys = "<leader>t", desc = "Telescope" },
                    { mode = "n", keys = "<leader>x", desc = "Trouble" },

                    -- TODO: manually make clues for g
                    { mode = "n", keys = "gc", desc = "Comment" },
                },
                window = { delay = 300, config = { width = "auto" } },
            })

            miniclue.set_mapping_desc("n", "ga", "Align")
            miniclue.set_mapping_desc("n", "<leader>h", "Leap upward")
            miniclue.set_mapping_desc("n", "<leader>k", "Leap downward")
            local nord = require("utils.nord")
            vim.api.nvim_set_hl(0, "MiniClueFloatTitle", { fg = nord.c09_glcr, bold = true })
            vim.api.nvim_set_hl(0, "MiniClueNextKey", { fg = nord.c08_teal, bold = true })
            vim.api.nvim_set_hl(0, "MiniClueSeparator", { link = "MiniClueBorder" })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "fugitive",
                group = vim.api.nvim_create_augroup("MiniClueFugitive", { clear = true }),
                callback = function(data)
                    miniclue.set_mapping_desc("n", "g?", "Help")
                    miniclue.set_mapping_desc("n", "gu", "Jump to Untracked/Unstaged")
                    miniclue.set_mapping_desc("n", "gU", "Jump to Unstaged")
                    miniclue.set_mapping_desc("n", "gs", "Jump to Staged")
                    miniclue.set_mapping_desc("n", "gp", "Jump to Unpushed")
                    miniclue.set_mapping_desc("n", "gP", "Jump to Unpulled")
                    miniclue.set_mapping_desc("n", "gr", "Jump to Rebasing")
                end,
            })
        end,
    },

    {
        "echasnovski/mini.splitjoin",
        event = "BufRead",
        opts = {
            mappings = { toggle = "<leader>rj", split = "<leader>rs" },
            split = { hooks_pre = {}, hooks_post = {} },
            join = { hooks_pre = {}, hooks_post = {} },
        },
    },
    -- mini.operators -- Text edit operators
    -- mini.doc -- generate nvim help file
}

-- {
--     { keys = "g0", desc = "Go to leftmost visible column", mode = "n" },
--     { keys = "g8", desc = "Print hex value of char under cursor", mode = "n" },
--     { keys = "ga", desc = "Print ascii value", mode = "n" },
--     { keys = "gD", desc = "Go to definition in file", mode = "n" },
--     { keys = "gd", desc = "Go to definition in function", mode = "n" },
--     { keys = "gE", desc = "Go backwards to end of previous WORD", mode = "n" },
--     { keys = "ge", desc = "Go backwards to end of previous word", mode = "n" },
--     { keys = "gF", desc = "Edit file under cursor + jump line", mode = "n" },
--     { keys = "gf", desc = "Edit file under cursor", mode = "n" },
--     { keys = "gg", desc = "Go to line (def: first)", mode = "n" },
--     { keys = "gH", desc = "Start Select line mode", mode = "n" },
--     { keys = "gh", desc = "Start Select mode", mode = "n" },
--     { keys = "gI", desc = "Start Insert at column 1", mode = "n" },
--     { keys = "gi", desc = "Start Insert where it stopped", mode = "n" },
--     { keys = "gJ", desc = "Join lines without extra spaces", mode = "n" },
--     { keys = "gj", desc = "Go down by screen lines", mode = "n" },
--     { keys = "gk", desc = "Go up by screen lines", mode = "n" },
--     { keys = "gM", desc = "Go to middle of text line", mode = "n" },
--     { keys = "gm", desc = "Go to middle of screen line", mode = "n" },
--     { keys = "gN", desc = "Select previous search match", mode = "n" },
--     { keys = "gn", desc = "Select next search match", mode = "n" },
--     { keys = "go", desc = "Go to byte", mode = "n" },
--     { keys = "gP", desc = "Put text before cursor + stay after it", mode = "n" },
--     { keys = "gp", desc = "Put text after cursor + stay after it", mode = "n" },
--     { keys = "gQ", desc = 'Switch to "Ex" mode', mode = "n" },
--     { keys = "gq", desc = "Format text (operator)", mode = "n" },
--     { keys = "gR", desc = "Enter Virtual Replace mode", mode = "n" },
--     { keys = "gr", desc = "Virtual replace with character", mode = "n" },
--     { keys = "gs", desc = "Sleep", mode = "n" },
--     { keys = "gT", desc = "Go to previous tabpage", mode = "n" },
--     { keys = "gt", desc = "Go to next tabpage", mode = "n" },
--     { keys = "gU", desc = "Make uppercase (operator)", mode = "n" },
--     { keys = "gu", desc = "Make lowercase (operator)", mode = "n" },
--     { keys = "gV", desc = "Avoid reselect", mode = "n" },
--     { keys = "gv", desc = "Reselect previous Visual area", mode = "n" },
--     { keys = "gw", desc = "Format text + keep cursor (operator)", mode = "n" },
--     { keys = "gx", desc = "Execute app for file under cursor", mode = "n" },
--     { keys = "g<C-]>", desc = "`:tjump` to tag under cursor", mode = "n" },
--     { keys = "g<C-a>", desc = "Dump a memory profile", mode = "n" },
--     { keys = "g<C-g>", desc = "Show information about cursor", mode = "n" },
--     { keys = "g<C-h>", desc = "Start Select block mode", mode = "n" },
--     { keys = "g<Tab>", desc = "Go to last accessed tabpage", mode = "n" },
--     { keys = "g'", desc = "Jump to mark (don't affect jumplist)", mode = "n" },
--     { keys = "g#", desc = "Search backwards word under cursor", mode = "n" },
--     { keys = "g$", desc = "Go to rightmost visible column", mode = "n" },
--     { keys = "g%", desc = "Cycle through matching groups", mode = "n" },
--     { keys = "g&", desc = "Repeat last `:s` on all lines", mode = "n" },
--     { keys = "g*", desc = "Search word under cursor", mode = "n" },
--     { keys = "g+", desc = "Go to newer text state", mode = "n" },
--     { keys = "g,", desc = "Go to newer position in change list", mode = "n" },
--     { keys = "g-", desc = "Go to older text state", mode = "n" },
--     { keys = "g;", desc = "Go to older position in change list", mode = "n" },
--     { keys = "g<", desc = "Display previous command output", mode = "n" },
--     { keys = "g?", desc = "Rot13 encode (operator)", mode = "n" },
--     { keys = "g@", desc = "Call 'operatorfunc' (operator)", mode = "n" },
--     { keys = "g]", desc = "`:tselect` tag under cursor", mode = "n" },
--     { keys = "g^", desc = "Go to leftmost visible non-whitespace", mode = "n" },
--     { keys = "g_", desc = "Go to lower line", mode = "n" },
--     { keys = "g`", desc = "Jump to mark (don't affect jumplist)", mode = "n" },
--     { keys = "g~", desc = "Swap case (operator)", mode = "n" },
--     { keys = "gf", desc = "Edit selected file", mode = "x" },
--     { keys = "gJ", desc = "Join selected lines without extra spaces", mode = "x" },
--     { keys = "gq", desc = "Format selection", mode = "x" },
--     { keys = "gV", desc = "Avoid reselect", mode = "x" },
--     { keys = "gw", desc = "Format selection + keep cursor", mode = "x" },
--     { keys = "g<C-]>", desc = "`:tjump` to selected tag", mode = "x" },
--     { keys = "g<C-a>", desc = "Increment with compound", mode = "x" },
--     { keys = "g<C-g>", desc = "Show information about selection", mode = "x" },
--     { keys = "g<C-x>", desc = "Decrement with compound", mode = "x" },
--     { keys = "g]", desc = "`:tselect` selected tag", mode = "x" },
--     { keys = "g?", desc = "Rot13 encode selection", mode = "x" },
-- }
