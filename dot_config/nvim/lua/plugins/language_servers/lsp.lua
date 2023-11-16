return {
    {
        "williamboman/mason.nvim",
        dependencies = "williamboman/mason-lspconfig.nvim",
        cmd = "Mason",
        keys = { { "<leader>im", "<cmd>Mason<cr>", desc = "Mason" } },
        config = function()
            require("mason").setup({
                ui = {
                    border = "double",
                    icons = { package_installed = "✓", package_pending = "", package_uninstalled = "✗" },
                },
            })
            -- stylua: ignore
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright", "ruff_lsp", -- python
                    "tsserver", "eslint", "tailwindcss", "cssls", "html", "svelte", -- js,ts,css,html
                    "jdtls", -- java
                    "lua_ls", -- lua
                    "sqlls", -- sql
                    "marksman", -- markdown
                    "jsonls", "yamlls", "taplo", -- json, yaml, toml
                    "docker_compose_language_service", "dockerls", -- docker
                    "vimls", -- vim
                    "bufls", -- protobuf
                    "zk", -- zettelkasten
                    -- "rust_analyzer", -- rust (handled by rust-tools.nvim)
                    -- "zls" -- zig
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "folke/neodev.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            cssls = {},
            docker_compose_language_service = {},
            dockerls = {},
            eslint = { settings = { format = { enable = false } } },
            jdtls = {}, -- java
            jsonls = { init_options = { provideFormatter = false } },
            lua_ls = {
                command = { "lua-language-server" },
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        diagnostics = { globals = { "vim" } }, -- Get the language server to recognize the `vim` global
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
                            checkThirdParty = false,
                        },
                        telemetry = { enable = false }, -- Do not send telemetry data containing a randomized but unique identifier
                        format = { enable = false },
                        -- TODO: check options: format, inlay hint, codelens
                    },
                },
            },
            marksman = { filetypes = { "markdown", "telekasten" } },
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "off", -- let mypy handle type checking
                            diagnosticSeverityOverrides = { reportUndefinedVariable = "none" }, -- "error," "warning," "information," "true," "false," or "none"
                        },
                    },
                    pyright = { disableOrganizeImports = true },
                },
            },
            ruff_lsp = {
                on_attach = function(client, _)
                    client.server_capabilities.hoverProvider = false -- disable hover in favor of pyright
                end,
            },
            sqlls = {},
            tsserver = {
                handlers = {
                    -- filter Hint and Info diagnostics
                    ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
                        result.diagnostics = vim.tbl_filter(
                            function(diag) return diag.severity < vim.diagnostic.severity.INFO end,
                            result.diagnostics
                        )
                        vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
                    end,
                },
                settings = {
                    typescript = {
                        -- format = { semicolons = "insert" },
                        inlayHints = {
                            includeInlayParameterNameHints = "none", -- "none" | "literal" | "all"
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = false,
                            includeInlayVariableTypeHints = false,
                            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = false,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = false,
                        },
                    },
                    javascript = {
                        -- format = { semicolons = "insert" },
                        inlayHints = {
                            includeInlayParameterNameHints = "none",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = false,
                            includeInlayVariableTypeHints = false,
                            includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                            includeInlayPropertyDeclarationTypeHints = false,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = false,
                        },
                    },
                },
                on_attach = function(_, bufnr)
                    local organize_imports = function()
                        vim.lsp.buf.execute_command({
                            command = "_typescript.organizeImports",
                            arguments = { vim.api.nvim_buf_get_name(0) },
                            title = "",
                        })
                    end
                    vim.api.nvim_create_user_command("OrganizeImports", organize_imports, { desc = "Organize Imports" })
                    vim.keymap.set("n", "<leader>ro", "<cmd>OrganizeImports<cr>", { buffer = bufnr, desc = "Organize Imports" })
                end,
            },
            svelte = {
                handlers = {
                    ["textDocument/signatureHelp"] = function(_, result, ctx, config)
                        vim.print("svelte signature_help called")
                        return vim.lsp.handlers.signature_help(_, result, ctx, config)
                    end,
                },
                settings = {
                    svelte = {
                        plugin = {
                            svelte = {
                                defaultScriptLanguage = "ts",
                                compilerWarnings = {
                                    ["unused-export-let"] = "ignore",
                                    ["a11y-invalid-attribute"] = "ignore",
                                },
                            },
                        },
                    },
                },
            },
            tailwindcss = {},
            taplo = {},
            vimls = {},
            yamlls = {},
            -- bufls = {}, -- protobuf
            -- sourcery = {}, -- refer to sourcery from lspconfig
            -- rust_analyzer = {}, -- rust-tools.nvim
        },
        config = function(_, servers)
            require("neodev").setup() -- important to setup before lspconfig
            local lsp_config = require("lspconfig")

            -- Add additional capabilities supported by nvim-cmp
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Use a loop to conveniently call 'setup' on multiple servers and
            -- map buffer local keybindings when the language server attaches
            for server, config in pairs(servers) do
                config.capabilities = capabilities
                lsp_config[server].setup(config)
            end

            -- utility functions -----------------------------------------------------------
            local diagnostic_goto = function(next, severity)
                local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
                severity = severity and vim.diagnostic.severity[severity] or nil
                return function() go({ severity = severity }) end
            end
            -- stylua: ignore
            local toggle_diagnostic = function()
                local disabled = vim.diagnostic.is_disabled()
                if disabled then vim.diagnostic.enable() else vim.diagnostic.disable() end
            end

            -- global keymaps
            -- stylua: ignore start
            vim.keymap.set("n", "E",  vim.diagnostic.open_float,       { desc = "Open Float" })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,        { desc = "Goto previous diagnostic" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next,        { desc = "Goto next diagnostic" })
            vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"),  { desc = "Goto next error" })
            vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Goto previous error" })
            vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"),   { desc = "Goto next warning" })
            vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"),  { desc = "Goto previous warning" })
            vim.keymap.set( "n", "<leader>ro", function() vim.notify("Command not supported", vim.log.levels.WARN) end, { desc = "Organize Imports" })
            -- stylua: ignore end

            -- keymaps for LS attached buffers
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local bufopts = function(desc) return { noremap = true, silent = true, buffer = ev.buf, desc = desc } end
                    vim.keymap.set("n", "H", vim.lsp.buf.signature_help, bufopts("Display Signature Help"))
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts("Display Hover Info"))
                    vim.keymap.set({ "n", "v" }, "<leader>ra", vim.lsp.buf.code_action, bufopts("Code Action"))
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts("Rename"))
                    vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.format({ async = true }) end, bufopts("Format File"))
                    vim.keymap.set("n", "<leader>il", "<cmd>LspInfo<cr>", bufopts("Lsp Info"))
                    vim.keymap.set("n", "<leader>dd", toggle_diagnostic, bufopts("Diagnostic Toggle"))
                    vim.keymap.set("n", "<leader>dh", function() vim.lsp.inlay_hint(0) end, bufopts("InlayHint Toggle"))

                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client.server_capabilities.inlayHintProvider then
                        -- let rust-tools handle inlay hints
                        if client.name ~= "rust_analyzer" then
                            vim.lsp.inlay_hint.enable(0, true)
                        end
                    end

                    -- TODO: codelens support
                end,
            })

            --------------------------------------------------------------------------------
            -- UI customization ------------------------------------------------------------
            --------------------------------------------------------------------------------
            require("lspconfig.ui.windows").default_options.border = "double"
            -- globally override border -- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#borders
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...) ---@diagnostic disable-line: duplicate-set-field, redefined-local
                opts = opts or {}
                opts.border = opts.border or "rounded"
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            -- gutter (sign column) symbols
            local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- display the source of diagnostic
            vim.diagnostic.config({
                virtual_text = false,
                float = { -- format as `i: message (code) [src]`
                    format = function(diag) return diag.message end,
                    suffix = function(diag, _, _)
                        local source = diag.source ~= nil and " [" .. diag.source .. "]" or ""
                        local code = diag.code ~= nil and " (" .. diag.code .. ")" or ""
                        return code .. source, "Comment"
                    end,
                    -- source = "always", -- format as `i. src: message (code)`
                },
            })

            vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "FloatBorder" })

            --------------------------------------------------------------------------------
            -- DEBUG
            -- vim.lsp.set_log_level("debug") -- set this then run :LspInfo
        end,
    },
}
