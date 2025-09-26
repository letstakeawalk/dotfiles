return {
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
        event = "VeryLazy",
        config = function()
            local nls = require("null-ls")
            nls.setup({
                debug = false,
                border = "double",
                sources = {
                    nls.builtins.formatting.stylua,
                    nls.builtins.diagnostics.gitlint,
                    nls.builtins.formatting.shellharden,
                    nls.builtins.diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
                    nls.builtins.formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),

                    -- nls.builtins.code_actions.gitsigns,
                    -- nls.builtins.formatting.yamlfmt, -- use yaml_ls
                    -- nls.builtins.diagnostics.buf, -- protobuf
                    -- nls.builtins.diagnostics.actionlint, -- github action
                    -- nls.builtins.diagnostics.ansiblelint, -- ansible
                    -- nls.builtins.diagnostics.hadolint, -- docker
                    -- nls.builtins.diagnostics.mypy, -- python
                    -- nls.builtins.diagnostics.bandit, -- python
                    -- nls.builtins.formatting.prettier.with({
                    --     filetypes = { "javascrpit", "typescript", "javascriptreact", "typescriptreact" },
                    -- }),
                    -- nls.builtins.formatting.markdownlint.with({
                    --     extra_args = { "-c", vim.fn.expand("$XDG_CONFIG_HOME") .. "/markdownlint/markdownlint.yaml" },
                    -- }),
                    -- mdformat
                    -- mdslw
                    -- cbfmt
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
    { "neovim/nvim-lspconfig" },
}
