vim.pack.add({
    "gh:nvim-mini/mini.ai",
    "gh:nvim-mini/mini.clue",
    "gh:nvim-mini/mini.splitjoin",
})

require("mini.ai").setup({
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
})

require("mini.splitjoin").setup({
    mappings = { toggle = "<leader>rj", split = "", join = "" },
    split = { hooks_pre = {}, hooks_post = {} },
    join = { hooks_pre = {}, hooks_post = {} },
})

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
        -- miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),

        { mode = "n", keys = "<leader>d", desc = "Misc" },
        { mode = "n", keys = "<leader>g", desc = "Git" },
        { mode = "x", keys = "<leader>g", desc = "Git" },
        { mode = "n", keys = "<leader>i", desc = "Info" },
        { mode = "n", keys = "<leader>q", desc = "Buffer Management" },
        { mode = "n", keys = "<leader>r", desc = "Actions" },
        { mode = "x", keys = "<leader>r", desc = "Actions" },
        { mode = "n", keys = "<leader>t", desc = "Telescope" },
        { mode = "n", keys = "<leader>w", desc = "Git Worktree" },
        { mode = "n", keys = "<leader>x", desc = "Qf" },
        { mode = "n", keys = "<leader>rj", desc = "SplitJoin" },
    },
    window = { delay = 300, config = { width = "auto" } },
})

pcall(function() miniclue.set_mapping_desc("n", "ga", "Align") end)
pcall(function() miniclue.set_mapping_desc("n", "]m", "Goto next method") end)
pcall(function() miniclue.set_mapping_desc("n", "[m", "Goto previous method") end)
pcall(function() miniclue.set_mapping_desc("n", "]M", "Goto next method") end)
pcall(function() miniclue.set_mapping_desc("n", "[M", "Goto previous method") end)
pcall(function() miniclue.set_mapping_desc("n", "]q", "Goto next qf") end)
pcall(function() miniclue.set_mapping_desc("n", "[q", "Goto previous qf") end)
pcall(function() miniclue.set_mapping_desc("n", "]Q", "Goto last qf") end)
pcall(function() miniclue.set_mapping_desc("n", "[Q", "Goto first qf") end)
pcall(function() miniclue.set_mapping_desc("n", "]l", "Goto next loclist") end)
pcall(function() miniclue.set_mapping_desc("n", "[l", "Goto previous loclist") end)
pcall(function() miniclue.set_mapping_desc("n", "]L", "Goto last loclist") end)
pcall(function() miniclue.set_mapping_desc("n", "[L", "Goto first loclist") end)
pcall(function() miniclue.set_mapping_desc("n", "]D", "Goto last diagnostic") end)
pcall(function() miniclue.set_mapping_desc("n", "[D", "Goto first diagnostic") end)
pcall(function() miniclue.set_mapping_desc("n", "]%", "Goto next unmatched group") end)
pcall(function() miniclue.set_mapping_desc("n", "[%", "Goto previous unmatched group") end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = "fugitive",
    group = vim.api.nvim_create_augroup("MiniClueFugitive", { clear = true }),
    callback = function()
        miniclue.set_mapping_desc("n", "g?", "Help")
        miniclue.set_mapping_desc("n", "gu", "Jump to Unstaged")
        miniclue.set_mapping_desc("n", "gU", "Jump to Untracked")
        miniclue.set_mapping_desc("n", "gs", "Jump to Staged")
        miniclue.set_mapping_desc("n", "gp", "Jump to Unpushed")
        miniclue.set_mapping_desc("n", "gP", "Jump to Unpulled")
        miniclue.set_mapping_desc("n", "gr", "Jump to Rebasing")
        miniclue.set_mapping_desc("n", "gi", ".git/info/exlude | .gitignore")
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
