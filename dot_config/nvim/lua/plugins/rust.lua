return {
    {
        "mrcjkb/rustaceanvim",
        dependencies = { "akinsho/toggleterm.nvim" },
        version = "^6",
        ft = { "rust" },
        lazy = false, -- this plugin is already lazy
        config = function()
            local executors = require("rustaceanvim.executors")
            vim.g.rustaceanvim = {
                tools = {
                    executor = executors.toggleterm,
                    test_executor = executors.toggleterm,
                    crate_test_executor = executors.toggleterm,
                    enable_nextest = true,
                    hover_actions = { replace_builtin_hover = false },
                },
                server = {
                    on_attach = function(_, bufnr)
                        local bufopts = function(desc)
                            return { noremap = true, silent = true, buffer = bufnr, desc = desc }
                        end
                        vim.keymap.set("n", "<leader>rr", "<cmd>RustLsp runnables<cr>", bufopts("Runnable (RustLsp)"))
                        vim.keymap.set(
                            "n",
                            "<leader>rm",
                            "<cmd>RustLsp expandMacro<cr>",
                            bufopts("Expand macro (RustLsp)")
                        )
                        vim.keymap.set("n", "<leader>og", "<cmd>RustLsp crateGraph<cr>", bufopts("Crate graph"))
                        vim.keymap.set("n", "<leader>od", "<cmd>RustLsp openDocs<cr>", bufopts("Open docs.rs"))
                        vim.keymap.set("n", "<leader>oc", "<cmd>RustLsp openCargo<cr>", bufopts("Open Cargo.toml"))
                        vim.keymap.set("n", "gm", "<cmd>RustLsp parentModule<cr>", bufopts("Open parent module"))
                        vim.keymap.set(
                            "n",
                            "<leader>rs",
                            "<cmd>RustLsp ssr<cr>",
                            bufopts("Search & Replace (rustaceanvim)")
                        )
                        vim.keymap.set("n", "<leader>rH", "<cmd>RustLsp moveItem up<cr>", bufopts("Move item up"))
                        vim.keymap.set("n", "<leader>rK", "<cmd>RustLsp moveItem down<cr>", bufopts("Move item down"))
                        table.insert(
                            ---@diagnostic disable-next-line: undefined-field
                            _G.MiniClue.config.clues,
                            { desc = "Open (RustLsp)", keys = "<leader>o", mode = "n" }
                        )
                    end,
                    capabilities = {
                        offsetEncoding = { "utf-16" },
                        general = {
                            positionEncodings = { "utf-16" },
                        },
                    },
                    offset_encoding = "utf-16",
                    default_settings = {
                        ["rust-analyzer"] = {
                            inlayHints = {
                                -- parameterHints = { enable = false },
                            },
                        },
                    },
                },
                dap = {},
            }
        end,
    },
    {
        "Saecki/crates.nvim",
        tag = "stable",
        event = "BufRead Cargo.toml",
        config = function()
            local crates = require("crates")

            crates.setup({
                lsp = {
                    enabled = true,
                    actions = true,
                    completion = true,
                    hover = true,
                },
                -- null_ls = { enabled = true },
                popup = {
                    autofocus = false,
                    border = "rounded",
                },
                completion = {
                    blink = {
                        enabled = true,
                    },
                },
            })

            vim.api.nvim_create_autocmd("BufRead", {
                group = require("utils").augroup("CargoCrates", { clear = true }),
                pattern = "Cargo.toml",
                callback = function(ev)
                    local bufopts = function(desc)
                        return { noremap = true, silent = true, buffer = ev.buf, desc = desc }
                    end
                    -- vim.keymap.set("n", "<leader>ct", crates.toggle, bufopts("Toggle"))
                    vim.keymap.set("n", "<leader>Cr", crates.reload, bufopts("Reload"))

                    vim.keymap.set("n", "<leader>Cp", crates.show_popup, bufopts("Show popup"))
                    vim.keymap.set("n", "<leader>Cv", crates.show_versions_popup, bufopts("Show versions"))
                    vim.keymap.set("n", "<leader>Cf", crates.show_features_popup, bufopts("Show features"))
                    vim.keymap.set("n", "<leader>Cd", crates.show_dependencies_popup, bufopts("Show dependencies"))

                    vim.keymap.set("n", "<leader>Cu", crates.update_crate, bufopts("Update crate"))
                    vim.keymap.set("v", "<leader>Cu", crates.update_crates, bufopts("Update selected crates"))
                    vim.keymap.set("n", "<leader>Ca", crates.update_all_crates, bufopts("Update all crates"))
                    vim.keymap.set("n", "<leader>CU", crates.upgrade_crate, bufopts("Upgrade crate"))
                    vim.keymap.set("v", "<leader>CU", crates.upgrade_crates, bufopts("Upgrade selected crates"))
                    vim.keymap.set("n", "<leader>CA", crates.upgrade_all_crates, bufopts("Upgrade all crates"))

                    vim.keymap.set("n", "<leader>CH", crates.open_homepage, bufopts("Open homepage"))
                    vim.keymap.set("n", "<leader>CR", crates.open_repository, bufopts("Open repository"))
                    vim.keymap.set("n", "<leader>CD", crates.open_documentation, bufopts("Open documentation"))
                    vim.keymap.set("n", "<leader>CC", crates.open_crates_io, bufopts("Open crate.io"))
                end,
            })
        end,
    },
}
