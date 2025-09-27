return {
    { "neovim/nvim-lspconfig" },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason" },
        opts = {
            ui = {
                border = "double",
                icons = {
                    package_installed = "✓",
                    package_pending = "",
                    package_uninstalled = "✗",
                },
            },
        },
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvimtools/none-ls-extras.nvim" },
        event = "VeryLazy",
        config = function()
            local nls = require("null-ls")
            local formatting = nls.builtins.formatting
            local diagnostics = nls.builtins.diagnostics
            nls.setup({
                debug = false,
                border = "double",
                sources = {
                    require("none-ls.formatting.mdsf"), -- markdown code block
                    -- require("none-ls.formatting.mdslw"), -- markdown line wrapper
                    formatting.mdformat, -- markdown
                    formatting.stylua, -- lua
                    formatting.shellharden, -- bash
                    formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
                    diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
                    diagnostics.trivy, -- misconfig & vulnerability
                    -- diagnostics.todo_comments,
                    -- diagnostics.gitlint,

                    -- code_actions.gitsigns,
                    -- diagnostics.buf, -- protobuf
                    -- diagnostics.actionlint, -- github action
                    -- diagnostics.ansiblelint, -- ansible
                    -- diagnostics.hadolint, -- docker
                    -- diagnostics.mypy, -- python
                    -- diagnostics.bandit, -- python
                    -- mdslw
                    -- hadolint
                },
            })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        opts = { hint_enable = false },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua", -- only on `lua` files
        -- enabled = false,
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
