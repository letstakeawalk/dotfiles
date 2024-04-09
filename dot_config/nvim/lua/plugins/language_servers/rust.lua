return {
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        ft = { "rust" },
        config = function()
            local executors = require("rustaceanvim.executors")
            vim.g.rustaceanvim = {
                tools = {
                    executor = executors.toggleterm,
                    test_executor = executors.toggleterm,
                    crate_test_executor = executors.toggleterm,
                    hover_actions = { replace_builtin_hover = false },
                },
                server = {
                    on_attach = function(_, bufnr)
                        local bufopts = function(desc) return { noremap = true, silent = true, buffer = bufnr, desc = desc } end
                        vim.keymap.set("n", "<leader>cr", "<cmd>RustLsp runnables<cr>", bufopts("Runnable (rustaceanvim)"))
                        vim.keymap.set("n", "<leader>cm", "<cmd>expandMacro<cr>", bufopts("Expand macro (rustaceanvim)"))
                        vim.keymap.set("n", "<leader>dg", "<cmd>crateGraph<cr>", bufopts("Crate graph"))
                        vim.keymap.set("n", "go", "<cmd>RuspLsp openCargo<cr>", bufopts("Open Cargo.toml"))
                        vim.keymap.set("n", "gm", "<cmd>RustLsp parentModule<cr>", bufopts("Open parent module"))
                        vim.keymap.set("n", "<leader>rs", "<cmd>RustLsp sst<cr>", bufopts("Search & Replace (rustaceanvim)"))
                        vim.keymap.set("n", "<leader>rH", "<cmd>RustLsp moveItem up<cr>", bufopts("Move item up"))
                        vim.keymap.set("n", "<leader>rK", "<cmd>RustLsp moveItem down<cr>", bufopts("Move item down"))
                    end,
                    -- default_settings = {
                    --     ["rust-analyzer"] = {},
                    -- },
                },
                -- dap = {},
            }
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
