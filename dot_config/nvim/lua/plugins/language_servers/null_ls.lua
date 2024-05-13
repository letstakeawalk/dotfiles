return {
    {
        "nvimtools/none-ls.nvim", -- injectable language server (null-ls)
        dependencies = { "neovim/nvim-lspconfig", "jay-babu/mason-null-ls.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- https://github.com/jose-elias-alvarez/none-ls.nvim/blob/main/doc/BUILTINS.md
            local null_ls = require("null-ls")

            -- TODO: custom code actions for Rust
            --   - (https://www.reddit.com/r/neovim/comments/10h5syb/customizeadd_code_action/)
            --   - boilterplate for Builder pattern for struct under cursor
            --   - derive Debug, Clone, PartialEq, Eq, Hash for struct under cursor

            null_ls.setup({
                debug = false,
                sources = {
                    null_ls.builtins.formatting.prettierd.with({
                        disabled_filetypes = { "markdown", "yaml" },
                    }),

                    -- python
                    null_ls.builtins.diagnostics.mypy, -- type checker
                    -- null_ls.builtins.formatting.black.with({ command = "blackd-client", args = {} }), -- formatter: style
                    -- null_ls.builtins.formatting.isort, -- formatter: imports
                    -- null_ls.builtins.diagnostics.pylint, -- linter
                    -- null_ls.builtins.diagnostics.pydocstyle, -- linter: doc
                    -- null_ls.builtins.diagnostics.bandit,  -- check back later for PR

                    -- lua
                    -- null_ls.builtins.diagnostics.selene.with({ condition = function(utils) return utils.root_has_file({ "selene.toml" }) end, }),
                    null_ls.builtins.formatting.stylua,

                    -- sql
                    null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
                    null_ls.builtins.formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),

                    -- markdown
                    null_ls.builtins.formatting.markdownlint.with({
                        extra_args = { "-c", vim.fn.expand("$XDG_CONFIG_HOME") .. "/markdownlint/markdownlint.yaml" },
                    }),
                    null_ls.builtins.diagnostics.markdownlint.with({
                        extra_args = { "-c", vim.fn.expand("$XDG_CONFIG_HOME") .. "/markdownlint/markdownlint.yaml" },
                    }),
                    -- cbmfmt -- code block formatter
                    -- markdown_toc -- auto-gen toc

                    -- protobuf
                    -- null_ls.builtins.formatting.buf,
                    -- null_ls.builtins.diagnostics.buf,

                    -- bash
                    null_ls.builtins.formatting.shellharden,
                    -- null_ls.builtins.formatting.shfmt,
                    -- null_ls.builtins.diagnostics.shellcheck, -- req by bash_ls

                    -- git
                    -- null_ls.builtins.code_actions.gitsigns, -- gitsign.nvim
                    null_ls.builtins.diagnostics.gitlint, -- gitcommit
                    -- null_ls.builtins.diagnostics.commitlint, -- gitcommit

                    -- etc
                    null_ls.builtins.diagnostics.hadolint, -- docker
                    null_ls.builtins.code_actions.refactoring, -- thePrimeagen
                    -- null_ls.builtins.formatting.jq, -- json

                    -- checkout later
                    -- terrafmt
                    -- dprint
                },
                diagnostics_format = "#{m}", -- #{<m,c,s>}
                border = "double",
            })

            vim.keymap.set("n", "<leader>in", "<cmd>NullLsInfo<cr>", { desc = "Null-ls Info" })
            vim.api.nvim_set_hl(0, "NullLsInfoBorder", { link = "FloatBorder" })
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            -- stylua: ignore
            require("mason-null-ls").setup({
                ensure_installed = {
                    "prettier", "prettierd", -- js
                    "mypy", -- "pylint", "isort", "blackd-client", -- python
                    "stylua", -- "selene", -- lua
                    "markdownlint", "cbfmt", -- "markdown_toc", -- markdown
                    "sqlfluff", -- sql
                    "gitlint", -- git
                    "hadolint", -- docker
                    "buf", -- protobuf
                    "shellharden", "shfmt", "shellcheck" -- bash
                },
                automatic_installation = true,
            })
        end,
    },
}
