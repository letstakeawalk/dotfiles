return {
    "pmizio/typescript-tools.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
        local tt = require("typescript-tools")
        local api = require("typescript-tools.api")

        -- Add additional capabilities supported by nvim-cmp
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local on_attach = function(_, bufnr)
            local bufopts = function(desc) return { noremap = true, silent = true, buffer = bufnr, desc = desc } end
            vim.keymap.set("n", "<leader>ria", "<cmd>TSToolsAddMissingImports", bufopts("Add Missing Imports"))
            vim.keymap.set("n", "<leader>ris", "<cmd>TSToolsSortImports", bufopts("Sort Imports"))
            vim.keymap.set("n", "<leader>rio", "<cmd>TSToolsOrganizeImports", bufopts("Organize Imports (remove unused)"))
            -- vim.keymap.set("n", '<leader>ro', "<cmd>TSToolsRemoveUnusedImports", bufopts("Organize imports"))
        end
        local handlers = {}
        local settings = {
            -- spawn additional tsserver instance to calculate diagnostics on it
            separate_diagnostic_server = true,
            -- "change"|"insert_leave" determine when the client asks the server about diagnostic
            publish_diagnostic_on = "insert_leave",
            -- array of strings("fix_all"|"add_missing_imports"|"remove_unused")
            -- specify commands exposed as code_actions
            expose_as_code_action = { "fix_all, add_missing_imports, remove_unused" },
            -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
            -- not exists then standard path resolution strategy is applied
            tsserver_path = nil,
            -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
            -- (see 💅 `styled-components` support section)
            tsserver_plugins = {},
            -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
            -- memory limit in megabytes or "auto"(basically no limit)
            tsserver_max_memory = "auto",
            -- defaults: https://github.com/pmizio/typescript-tools.nvim/blob/master/lua/typescript-tools/config.lua#L17
            tsserver_format_options = {},
            tsserver_file_preferences = {
                includeInlayParameterNameHints = "none",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = false,
            },
            -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
            complete_function_calls = false,
        }
        tt.setup({
            on_attach = on_attach,
            handlers = handlers,
            capabilities = capabilities,
            settings = settings,
        })
        vim.notify("typescript-tools.nvim loaded")
    end,
}
