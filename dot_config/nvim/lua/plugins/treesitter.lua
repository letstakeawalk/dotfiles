return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-context", -- code context winbar
        "nvim-treesitter/nvim-treesitter-textobjects", -- treesitter module
        "nvim-treesitter/playground", -- treesitter playground
        "JoosepAlviste/nvim-ts-context-commentstring", -- context commentstring
        "RRethy/nvim-treesitter-endwise", -- endwise lua, ruby, etc
        "windwp/nvim-ts-autotag", -- auto closes tags for html, react, etc
    },
    event = "BufReadPost",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
        -- TODO: learn treesitter queries (https://tree-sitter.github.io/tree-sitter/using-parsers#pattern-matching-with-queries)
        -- TODO: incremental selection???
        require("nvim-treesitter.configs").setup({
      -- One of "all", "maintained" (parsers with maintainers), or a list of languages
      -- stylua: ignore
      ensure_installed = {
        "bash", "c", "cpp", "c_sharp", "cmake", "css", "dockerfile",
        "gitattributes", "gitcommit", "gitignore", "git_rebase", "go",
        "html", "java", "javascript", "json", "jsonc", "kotlin",
        "latex", "lua", "markdown", "markdown_inline", "norg", "python",
        "ron", -- rust object notation "ruby", "rust", "sql", "toml",
        "typescript", "vim", "yaml", "help", "jq", "make", "regex", "scss", "vue",
      },

            -- Install languages synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- List of parsers to ignore installing
            ignore_install = {},

            highlight = {
                enable = true, -- `false` will disable the whole extension
                disable = { "markdown", "markdown_inline" },
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                -- additional_vim_regex_highlighting = false,
                additional_vim_regex_highlighting = { "markdown", "markdown_inline" },
            },

            indent = {
                enable = false,
                disable = {},
            },

            -- text objects module
            textobjects = {
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
                        ["ao"] = "@conditional.outer",
                        ["io"] = "@conditional.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["am"] = "@comment.outer",
                        -- @block.outer inner
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [")("] = "@function.outer",
                        ["]["] = "@class.outer",
                        [")a"] = "@parameter.inner",
                        [")o"] = "@conditional.inner",
                        [")l"] = "@loop.inner",
                    },
                    goto_next_end = {
                        ["))"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["(("] = "@function.outer",
                        ["[["] = "@class.outer",
                        ["(a"] = "@parameter.inner",
                        ["(o"] = "@conditional.inner",
                        ["(l"] = "@loop.inner",
                    },
                    goto_previous_end = {
                        ["()"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = { ["<leader>rk"] = "@parameter.inner" },
                    swap_previous = { ["<leader>rh"] = "@parameter.inner" },
                },
            },

            -- nvim-ts-context-commentstring module
            context_commentstring = {
                enable = true,
                enable_autocmd = false, -- for Comment.nvim
            },

            -- autotag module
            autotag = { enable = true },

            -- endwise module
            endwise = { enable = true },

            -- playground
            playground = {
                enable = true,
                disable = {},
                updatetime = 25,
                persist_queries = false,
            },
        })

        -- code context winbar
        require("treesitter-context").setup({ enable = true })

        -- Custom highlight captures
        vim.api.nvim_set_hl(0, "@text.danger", { link = "DiagnosticError" })
        vim.api.nvim_set_hl(0, "@text.warning", { link = "DiagnosticWarn" })
        vim.api.nvim_set_hl(0, "@text.note", { link = "DiagnosticWarn" })
        vim.api.nvim_set_hl(0, "@text.todo", { link = "DiagnosticWarn" })
        vim.api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })

        -- vim.opt.foldmethod     = 'expr'
        -- vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
        -- vim.opt.foldenable     = false
        ---WORKAROUND TODO: make this work only for markdown
        vim.api.nvim_create_autocmd({ "FileType" }, {
            group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
            pattern = "markdown",
            callback = function()
                vim.opt.foldmethod = "expr"
                vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
                vim.opt.foldenable = true
                -- vim.opt.foldenable = false
            end,
        })
        ---ENDWORKAROUND
    end,
}
