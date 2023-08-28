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
        -- TODO: incremental selection??? <<- wtf does that mean? (2023/02/12)
        local textobjects = {
            select = {
                enable = true,
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["ai"] = "@conditional.outer",
                    ["ii"] = "@conditional.inner",
                    ["ao"] = "@loop.outer",
                    ["io"] = "@loop.inner",
                    ["aM"] = "@comment.outer",
                    ["iM"] = "@comment.outer",
                    ["ak"] = "@block.outer",
                    ["ik"] = "@block.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]["] = "@function.outer",
                    ["]("] = "@class.outer",
                    ["]a"] = "@parameter.inner",
                    ["]i"] = "@conditional.inner",
                    ["]o"] = "@loop.inner",
                    -- ["]h"] = "@comment.outer",
                },
                goto_next_end = {
                    ["]]"] = "@function.outer",
                    ["])"] = "@class.outer",
                },
                goto_previous_start = {
                    ["[["] = "@function.outer",
                    ["[("] = "@class.outer",
                    ["[a"] = "@parameter.inner",
                    ["[i"] = "@conditional.inner",
                    ["[o"] = "@loop.inner",
                    -- ["[h"] = "@comment.outer",
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
        local ensure_installed = {
            "bash",
            "c",
            -- "c_sharp",
            "cmake",
            "cpp",
            "css",
            "diff",
            "dockerfile",
            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
            "go",
            "html",
            "java",
            "javascript",
            "jq",
            "json",
            "jsonc",
            "kotlin",
            "latex",
            "lua",
            "make",
            "markdown",
            "markdown_inline",
            -- "mermaid", -- diagrams & charts
            -- "ocaml",
            "python",
            "regex",
            "ron", -- rust object notation
            "ruby",
            "rust",
            "scss",
            "sql",
            "svelte",
            "terraform",
            "toml",
            "typescript",
            "vim",
            "vimdoc",
            -- "vue",
            -- "xml",
            "yaml",
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
            highlight = {
                enable = true, -- `false` will disable the whole extension
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                -- additional_vim_regex_highlighting = false,
                additional_vim_regex_highlighting = { "markdown" },
            },
            indent = { enable = false, disable = {} },
            -- text objects module
            textobjects = textobjects,
            -- nvim-ts-context-commentstring module
            context_commentstring = {
                enable = true,
                enable_autocmd = false, -- for Comment.nvim
            },
            -- autotag module
            autotag = { enable = true, enable_clote_on_slash = false },
            -- endwise module
            endwise = { enable = true },
        })
        vim.treesitter.language.register("markdown", "telekasten")
        -- vim.treesitter.language.register("markdown_inline", "telekasten")

        -- code context of current line in winbar
        require("treesitter-context").setup({ enable = true })

        vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })
        vim.keymap.set("n", "<leader>di", "<cmd>Inspect<cr>", { desc = "Inspect TS node" })
        vim.keymap.set("n", "<leader>dI", "<cmd>InspectTree<cr>", { desc = "Inspect TS tree" })
        vim.keymap.set("n", "<leader>dp", "<cmd>TSPlayground<cr>", { desc = "TS Playground" })
        vim.keymap.set("n", "<leader>dT", "<cmd>TSHighlightCapturesUnderCursor<cr>", { desc = "TS highlight" })
    end,
}
