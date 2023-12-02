return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context", -- code context winbar
        "nvim-treesitter/nvim-treesitter-textobjects", -- treesitter module
        "JoosepAlviste/nvim-ts-context-commentstring", -- context commentstring
        "RRethy/nvim-treesitter-endwise", -- endwise lua, ruby, etc
        "windwp/nvim-ts-autotag", -- auto closes tags for html, react, etc
    },
    event = "BufRead",
    build = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
    config = function()
        -- TODO: learn treesitter queries (https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries)
        local textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
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
        local ensure_installed = {
            "bash",
            "c", "cpp",
            "cmake",
            "diff",
            "dockerfile",
            "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
            "go",
            "html", "htmldjango", "css", "scss", -- "xml",
            "java",
            "javascript", "typescript", "svelte", "jsdoc",
            "json", "jsonc", "jq",
            "latex",
            "lua",
            "make", -- "just",
            "markdown", "markdown_inline",
            "proto", -- protocol buffers
            "python",
            "regex",
            "ruby",
            "rust", "ron", -- rust object notation
            "sql",
            "terraform",
            "toml",
            "vim", "vimdoc",
            "yaml",
            -- "c_sharp",
            -- "kotlin",
            -- "mermaid", -- diagrams & charts
            -- "ocaml",
            -- "vue",
            -- "zig",
        }

        ---@diagnostic disable: missing-fields
        require("nvim-treesitter.configs").setup({
            -- One of "all", "maintained" (parsers with maintainers), or a list of languages
            ensure_installed = ensure_installed,
            auto_install = false,
            -- Install languages synchronously (only applied to `ensure_installed`)
            sync_install = false,
            -- List of parsers to ignore installing
            ignore_install = {},
            -- highlight module
            highlight = {
                enable = true, -- `false` will disable the whole extension
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                -- additional_vim_regex_highlighting = false,
                additional_vim_regex_highlighting = { "markdown" },
            },
            -- incremental selection module
            incremental_selection = {
                enable = false,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            -- indent module
            indent = { enable = true },
            -- text objects module
            textobjects = textobjects,
            -- autotag module
            autotag = { enable = true, enable_close_on_slash = false },
            -- endwise module
            endwise = { enable = true },
        })

        -- code context of current line in winbar
        require("treesitter-context").setup({ enable = true })
        vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })

        -- context comment string
        require("ts_context_commentstring").setup({
            enable_autocmd = false, -- for Comment.nvim
        })
        vim.g.skip_ts_context_commentstring_module = true

        -- Repeat movement with ; and ,
        -- ensure ; goes forward and , goes backward regardless of the last direction
        local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

        -- Inspect
        vim.keymap.set("n", "<leader>di", "<cmd>Inspect<cr>", { desc = "Inspect TS node" })
        vim.keymap.set("n", "<leader>dI", "<cmd>InspectTree<cr>", { desc = "Inspect TS tree" })
    end,
}
