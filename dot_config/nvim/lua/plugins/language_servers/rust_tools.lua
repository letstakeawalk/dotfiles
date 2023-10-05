return {
    {
        "simrat39/rust-tools.nvim",
        dependencies = "neovim/nvim-lspconfig",
        -- ft = "rust",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local rt = require("rust-tools")
            -- Add additional capabilities supported by nvim-cmp
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_, bufnr)
                local bufopts = function(desc) return { noremap = true, silent = true, buffer = bufnr, desc = desc } end
                vim.keymap.set("n", "<leader>cr", rt.runnables.runnables, bufopts("Runnable (rust-tools)"))
                vim.keymap.set("n", "<leader>cm", rt.expand_macro.expand_macro, bufopts("Expand macro (rust-tools)"))
                vim.keymap.set("n", "<leader>dg", rt.crate_graph.view_crate_graph, bufopts("Crate graph"))
                vim.keymap.set("n", "go", rt.open_cargo_toml.open_cargo_toml, bufopts("Open Cargo.toml"))
                vim.keymap.set("n", "gm", rt.parent_module.parent_module, bufopts("Open parent module"))
                vim.keymap.set("n", "<leader>rs", rt.ssr.ssr, bufopts("Search & Replace (rust-tools)"))
                vim.keymap.set("n", "<leader>rH", function() rt.move_item.move_item(true) end, bufopts("Move item up"))
                vim.keymap.set("n", "<leader>rK", function() rt.move_item.move_item(false) end, bufopts("Move item down"))
                -- vim.keymap.set("n", "K", rt.hover_actions.hover_actions, bufopts("Hover Actions"))
                -- vim.keymap.set("n", "J", rt.join_lines.join_lines, bufopts("Join lines"))
            end

            rt.setup({
                -- all the opts to send to nvim-lspconfig. these override the defaults set by rust-tools.nvim
                -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
                server = {
                    -- standalone file support: setting it to false may improve startup time
                    standalone = true,
                    on_attach = on_attach,
                    capabilities = capabilities,
                }, -- rust-analyzer options
            })
        end,
    },
    {
        "Saecki/crates.nvim",
        event = "BufRead Cargo.toml",
        config = function()
            local crates = require("crates")

            crates.setup({
                null_ls = { enabled = true },
                popup = {
                    autofocus = true,
                    border = "rounded",
                },
            })

            -- lazy load cmp source, and buffer specific keymaps
            vim.api.nvim_create_autocmd("BufReadPre", {
                group = vim.api.nvim_create_augroup("SourceCargo", { clear = true }),
                pattern = "Cargo.toml",
                callback = function(ev)
                    require("cmp").setup.buffer({ sources = { { name = "crates" } } })
                    local bufopts = function(desc) return { noremap = true, silent = true, buffer = ev.buf, desc = desc } end
                    -- vim.keymap.set("n", "<leader>ct", crates.toggle, bufopts("Toggle"))
                    vim.keymap.set("n", "<leader>cr", crates.reload, bufopts("Reload"))

                    vim.keymap.set("n", "<leader>cp", crates.show_popup, bufopts("Show popup"))
                    vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, bufopts("Show versions"))
                    vim.keymap.set("n", "<leader>cf", crates.show_features_popup, bufopts("Show features"))
                    vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, bufopts("Show dependencies"))

                    vim.keymap.set("n", "<leader>cu", crates.update_crate, bufopts("Update crate"))
                    vim.keymap.set("v", "<leader>cu", crates.update_crates, bufopts("Update selected crates"))
                    vim.keymap.set("n", "<leader>ca", crates.update_all_crates, bufopts("Update all crates"))
                    vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, bufopts("Upgrade crate"))
                    vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, bufopts("Upgrade selected crates"))
                    vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, bufopts("Upgrade all crates"))

                    vim.keymap.set("n", "<leader>cH", crates.open_homepage, bufopts("Open homepage"))
                    vim.keymap.set("n", "<leader>cR", crates.open_repository, bufopts("Open repository"))
                    vim.keymap.set("n", "<leader>cD", crates.open_documentation, bufopts("Open documentation"))
                    vim.keymap.set("n", "<leader>cC", crates.open_crates_io, bufopts("Open crate.io"))
                end,
            })
        end,
    },
}
