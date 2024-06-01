return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
        "folke/neodev.nvim",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "nvimtools/none-ls.nvim",
        "ray-x/lsp_signature.nvim",
        { "j-hui/fidget.nvim", version = "*" },
    },
    config = function()
        require("neodev").setup({ -- important to setup before lspconfig
            override = function(root_dir, options)
                if root_dir == vim.fn.expand("$CHEZMOI_SOURCE/dot_config/nvim") then
                    options.plugins = true
                end
            end,
        })

        local servers = {
            bashls = {},
            -- bufls = {},
            -- cssls = {},
            -- docker_compose_language_service = {},
            -- dockerls = {},
            -- eslint = { settings = { format = { enable = false } } },
            jdtls = {},
            jsonls = { init_options = { provideFormatter = false } },
            lua_ls = {
                command = { "lua-language-server" },
                settings = {
                    Lua = {
                        -- runtime = { version = "LuaJIT" },
                        -- diagnostics = { globals = { "vim" } }, -- Get the language server to recognize the `vim` global
                        completion = { callSnippet = "Replace" },
                        -- workspace = {
                        --     library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
                        --     checkThirdParty = false,
                        -- },
                        -- telemetry = { enable = false }, -- Do not send telemetry data containing a randomized but unique identifier
                        format = { enable = false },
                        hint = {
                            enable = true,
                            arrayIndex = "Disable",
                        },
                        -- TODO: check options: format, inlay hint, codelens
                    },
                },
            },
            markdown_oxide = {
                capabilities = {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                },
            },
            pyright = {
                settings = {
                    python = {
                        analysis = {
                            ignore = { "*" }, -- let ruff_lsp handle linting
                            typeCheckingMode = "off", -- let mypy handle type-checking
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
            -- sqlls = {},
            tsserver = {
                handlers = {
                    -- filter Hint and Info diagnostics
                    ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
                        result.diagnostics = vim.tbl_filter(function(diag)
                            return diag.severity < vim.diagnostic.severity.INFO
                        end, result.diagnostics)
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
                    vim.keymap.set(
                        "n",
                        "<leader>ro",
                        "<cmd>OrganizeImports<cr>",
                        { buffer = bufnr, desc = "Organize Imports" }
                    )
                end,
            },
            svelte = {
                handlers = {
                    -- ["textDocument/signatureHelp"] = function(_, result, ctx, config)
                    --     vim.print("svelte signature_help called")
                    --     return vim.lsp.handlers.signature_help(_, result, ctx, config)
                    -- end,
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
            yamlls = {},
            -- vimls = {},
            -- marksman = { filetypes = { "markdown", "telekasten" } },
            -- sourcery = {}, -- refer to sourcery from lspconfig
        }

        local ensure_installed = {
            "stylua",
            "gitlint",
            "shellharden",
            -- "markdownlint",
            -- "mdformat",
            -- "mdslw",
            -- "cbfmt",
            -- "sqlfluff",
            -- "hadolint",
            -- "buf",
            -- "shellharden", "shfmt", "shellcheck"
            -- "prettier", "prettierd"
            -- "mypy",
        }

        vim.list_extend(ensure_installed, vim.tbl_keys(servers))
        require("mason").setup({
            ui = {
                border = "double",
                icons = { package_installed = "✓", package_pending = "", package_uninstalled = "✗" },
            },
        })
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        local lsp_config = require("lspconfig")

        -- Add additional capabilities supported by nvim-cmp
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        -- language servers
        for server, config in pairs(servers) do
            config.capabilities = vim.tbl_extend("force", capabilities, config.capabilities or {})
            lsp_config[server].setup(config)
        end

        -- linters and formatters
        local nls = require("null-ls")
        nls.setup({
            debug = false,
            border = "double",
            sources = {
                nls.builtins.formatting.stylua, -- lua
                nls.builtins.diagnostics.gitlint, -- git
                nls.builtins.formatting.shellharden, -- bash
                -- nls.builtins.formatting.jq,
                -- nls.builtins.diagnostics.actionlint, -- github action
                -- nls.builtins.diagnostics.ansiblelint, -- ansible
                -- nls.builtins.diagnostics.hadolint, -- docker
                -- nls.builtins.diagnostics.buf, -- protobuf
                -- nls.builtins.diagnostics.mypy, -- python
                -- nls.builtins.diagnostics.bandit, -- python
                -- nls.builtins.diagnostics.sqlfluff, -- sql
                -- nls.builtins.formatting.sqlfluff, -- sql

                -- nls.builtins.formatting.markdownlint.with({
                --     extra_args = { "-c", vim.fn.expand("$XDG_CONFIG_HOME") .. "/markdownlint/markdownlint.yaml" },
                -- }),

            }
        })

        -- stylua: ignore
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                vim.keymap.set("n", "H",          vim.lsp.buf.signature_help,                                                      { buffer = bufnr, desc = "Display Signature Help" })
                vim.keymap.set("n", "K",          vim.lsp.buf.hover,                                                               { buffer = bufnr, desc = "Display Hover Info" })
                vim.keymap.set("n", "<leader>ra", vim.lsp.buf.code_action,                                                         { buffer = bufnr, desc = "Code Action" })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,                                                              { buffer = bufnr, desc = "Rename" })
                vim.keymap.set("n", "<leader>rf", function() vim.lsp.buf.format({ async = true }) end,                             { buffer = bufnr, desc = "Format File"})
                vim.keymap.set("n", "<leader>dd", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,           { buffer = bufnr, desc = "Diagnostic Toggle" })
                vim.keymap.set("n", "<leader>dh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { buffer = bufnr, desc = "InlayHint Toggle" })
                require("lsp_signature").on_attach({ hint_enable = false }, bufnr)
            end,
        })
        vim.keymap.set("n", "<leader>il", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
        vim.keymap.set("n", "<leader>im", "<cmd>Mason<cr>", { desc = "Mason Info" })
        vim.keymap.set("n", "<leader>in", "<cmd>NullLsInfo<cr>", { desc = "Null-ls Info" })

        --------------------------------------------------------------------------------
        -- UI customization ------------------------------------------------------------
        --------------------------------------------------------------------------------
        require("fidget").setup({
            progress = {
                display = {
                    done_icon = "✔ ",
                    done_style = "Type",
                    icon_style = "Comment",
                },
            },
            notification = {
                override_vim_notify = false,
                window = { winblend = 0, border = "single", x_padding = 0 },
            },
        })

        require("lspconfig.ui.windows").default_options.border = "double"
        -- globally override border -- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#borders
        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        ---@diagnostic disable-next-line: duplicate-set-field
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or "rounded"
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        vim.diagnostic.config({
            virtual_text = false,
            float = { -- format as `i: message (code) [src]`
                format = function(diag)
                    return diag.message
                end,
                suffix = function(diag, _, _)
                    local code = diag.code and " (" .. diag.code .. ")" or ""
                    local source = diag.source and " [" .. diag.source .. "]" or ""
                    return code .. source, "Comment"
                end,
                -- source = "always", -- format as `i. src: message (code)`
                -- border = "rounded", -- ?? not working?
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = " ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
                linehl = {
                    [vim.diagnostic.severity.ERROR] = "DiagnosticError",
                    [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
                    [vim.diagnostic.severity.HINT] = "DiagnosticHint",
                    [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
                },
                numhl = {
                    [vim.diagnostic.severity.ERROR] = "DiagnosticError",
                    [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
                    [vim.diagnostic.severity.HINT] = "DiagnosticHint",
                    [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
                },
            },
        })
    end,
}
