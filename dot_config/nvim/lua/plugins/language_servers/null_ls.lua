return {
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
                    "mypy", "pylint", "isort", "blackd-client", -- python
                    "selene", "stylua", -- lua
                    "markdownlint", "cbfmt", -- "markdown_toc", -- markdown
                    "sqlfluff", "gitlint", "hadolint", -- etc
                    "buf" -- protobuf
                }
            })
        end,
    },
    {
        "nvimtools/none-ls.nvim", -- injectable language server (null-ls)
        dependencies = { "neovim/nvim-lspconfig" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
            local null_ls = require("null-ls")

            null_ls.setup({
                debug = false,
                sources = {
                    -- stylua: ignore
                    -- js, ts, vue, css, html, graphql, handlebars
                    null_ls.builtins.formatting.prettierd.with({ filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss", "less", "html", "graphql", "handlebars"} }),

                    -- python
                    null_ls.builtins.diagnostics.mypy, -- type checker
                    null_ls.builtins.diagnostics.pylint, -- linter
                    null_ls.builtins.formatting.isort, -- formatter: imports
                    null_ls.builtins.formatting.black.with({ command = "blackd-client", args = {} }), -- formatter: style
                    -- null_ls.builtins.diagnostics.pydocstyle, -- linter: doc
                    -- null_ls.builtins.diagnostics.bandit,  -- check back later for PR

                    -- lua
                    null_ls.builtins.diagnostics.selene.with({
                        condition = function(utils) return utils.root_has_file({ "selene.toml" }) end,
                    }),
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

                    -- etc
                    null_ls.builtins.diagnostics.gitlint, -- gitcommit
                    null_ls.builtins.diagnostics.hadolint, -- docker
                    null_ls.builtins.code_actions.gitsigns, -- gitsign.nvim
                    null_ls.builtins.code_actions.refactoring, -- thePrimeagen

                    -- null_ls.builtins.diagnostics.commitlint, -- gitcommit
                    -- null_ls.builtins.formatting.jq, -- json
                    -- null_ls.builtins.diagnostics.shellcheck, -- bash
                    -- null_ls.builtins.formatting.shfmt, -- bash

                    -- future checkout
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
}
