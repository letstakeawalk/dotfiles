---@diagnostic disable: missing-fields
local textobjects = {
    select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["am"] = "@function.outer",
            ["im"] = "@function.inner",
            ["af"] = "@call.outer",
            ["if"] = "@call.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["ao"] = "@loop.outer",
            ["io"] = "@loop.inner",
            ["ak"] = "@block.outer",
            ["ik"] = "@block.inner",
            ["a/"] = "@comment.outer",
            ["i/"] = "@comment.outer",
            ["a="] = "@assignment.lhs",
            ["i="] = "@assignment.rhs",
        },
    },
    move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
            ["]["] = "@function.outer",
            ["]("] = "@class.outer",
            ["]f"] = "@call.outer",
            ["]a"] = "@parameter.inner",
            ["]i"] = "@conditional.inner",
            ["]o"] = "@loop.inner",
            ["]/"] = "@comment.outer",
            -- ["]z"] = { query = "@fold", group = "@folds", desc = "Goto next @fold" },
        },
        goto_next_end = {
            ["]]"] = "@function.outer",
            ["])"] = "@class.outer",
        },
        goto_previous_start = {
            ["[["] = "@function.outer",
            ["[("] = "@class.outer",
            ["[f"] = "@call.outer",
            ["[a"] = "@parameter.inner",
            ["[i"] = "@conditional.inner",
            ["[o"] = "@loop.inner",
            ["[/"] = "@comment.outer",
            -- ["[z"] = { query = "@fold", group = "@folds", desc = "Goto previous @fold" },
        },
        goto_previous_end = {
            ["[]"] = "@function.outer",
            ["[)"] = "@class.outer",
        },
    },
    swap = {
        enable = true,
        swap_next = { ["<leader>rk"] = "@parameter.inner" },
        swap_previous = { ["<leader>rh"] = "@parameter.inner" },
    },
}

-- stylua: ignore
local parsers = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css", "scss",
    "csv",
    "diff",
    "dockerfile",
    "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
    "go",
    "html",
    "java",
    "javascript", "jsdoc",
    "jq",
    "json", "jsonc",
    "just",
    "latex",
    "lua", "luadoc", "luap",
    "make",
    "markdown", "markdown_inline",
    "mermaid",
    "proto", -- protocol buffers
    "python",
    "regex",
    "ron", -- rust object notation
    "ruby",
    "rust",
    "sql",
    "svelte",
    "terraform",
    "toml",
    "typescript", "tsx",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
    -- "c_sharp",
    -- "hcl", -- hashicorp configuration language
    -- "kotlin",
    -- "ocaml",
    -- "swift",
    -- "vue",
    -- "zig",
}

require("nvim-treesitter.configs").setup({
    ensure_installed = parsers,
    auto_install = false,
    sync_install = false,
    ignore_install = {},
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = textobjects,
    endwise = { enable = true },
})

require("nvim-ts-autotag").setup({
    opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
    },
})

vim.g.skip_ts_context_commentstring_module = true
require("ts_context_commentstring").setup({
    enable_autocmd = false, -- for Comment.nvim
})

require("treesitter-context").setup()

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

-- Inspect
vim.keymap.set("n", "<leader>di", "<cmd>Inspect<cr>", { desc = "Inspect TS node" })
vim.keymap.set("n", "<leader>dI", "<cmd>InspectTree<cr>", { desc = "Inspect TS tree" })
