return {
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            -- stylua: ignore
            require("mason-null-ls").setup({
                ensure_installed = {
                    "prettierd", -- "rustywind", -- js
                    "mypy", "pylint", "isort", "blackd-client", -- python
                    "selene", "stylua", -- lua
                    "markdownlint", "cbfmt", -- markdown
                    "sqlfluff", "gitlint", "hadolint" -- etc
                }
            })
        end,
    },
    {
        "jose-elias-alvarez/null-ls.nvim", -- injectable language server
        dependencies = { "neovim/nvim-lspconfig" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
            local null_ls = require("null-ls")

            null_ls.setup({
                debug = false,
                sources = {
                    -- ts, js, html, css, etc
                    null_ls.builtins.formatting.prettierd.with({ disabled_filetypes = { "markdown" } }), -- js,ts,css,html,json,yaml,md,etc
                    -- null_ls.builtins.formatting.prettier,
                    -- null_ls.builtins.formatting.rustywind, -- tailwindcss

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
                        filetypes = { "telekasten", "markdown" },
                        extra_args = { "-c", vim.fn.expand("$XDG_CONFIG_HOME") .. "/runcom/markdownlint.yaml" },
                    }),
                    null_ls.builtins.diagnostics.markdownlint.with({
                        filetypes = { "telekasten", "markdown" },
                        extra_args = { "-c", vim.fn.expand("$XDG_CONFIG_HOME") .. "/runcom/markdownlint.yaml" },
                    }),
                    -- cbmfmt -- code block formatter
                    -- markdown_toc -- auto-gen toc

                    -- etc
                    null_ls.builtins.diagnostics.gitlint, -- gitcommit
                    -- null_ls.builtins.diagnostics.commitlint, -- gitcommit
                    null_ls.builtins.diagnostics.hadolint, -- docker
                    null_ls.builtins.code_actions.gitsigns, -- gitsign.nvim
                    null_ls.builtins.code_actions.refactoring, -- thePrimeagen

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
