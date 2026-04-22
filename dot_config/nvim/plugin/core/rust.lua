vim.pack.add({
    { src = "gh:mrcjkb/rustaceanvim", version = vim.version.range("^9") },
    { src = "gh:Saecki/crates.nvim", version = "stable" },
    "gh:akinsho/toggleterm.nvim",
})

local executors = require("rustaceanvim.executors")
local set = require("utils.keymap").set

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
            -- stylua: ignore start
            set("n", "<leader>rr", "<cmd>RustLsp runnables<cr>",        { desc = "Runnable (RustLsp)",              buf = bufnr})
            set("n", "<leader>rt", "<cmd>RustLsp testables<cr>",        { desc = "Testables (RustLsp)",             buf = bufnr})
            set("n", "<leader>rm", "<cmd>RustLsp expandMacro<cr>",      { desc = "Expand macro (RustLsp)",          buf = bufnr})
            set("n", "<leader>rA", "<cmd>RustLsp codeAction<cr>",       { desc = "Code actions (RustLsp)",          buf = bufnr})
            set("n", "<leader>re", "<cmd>RustLsp explainError<cr>",     { desc = "Explain error (RustLsp)",         buf = bufnr})
            set("n", "<leader>rD", "<cmd>RustLsp renderDiagnostic<cr>", { desc = "Render Diagnostic (RustLsp)",     buf = bufnr})
            set("n", "<leader>og", "<cmd>RustLsp crateGraph<cr>",       { desc = "Crate graph",                     buf = bufnr})
            set("n", "<leader>od", "<cmd>RustLsp openDocs<cr>",         { desc = "Open docs.rs",                    buf = bufnr})
            set("n", "<leader>oc", "<cmd>RustLsp openCargo<cr>",        { desc = "Open Cargo.toml",                 buf = bufnr})
            set("n", "<leader>rs", "<cmd>RustLsp ssr<cr>",              { desc = "Search & Replace (rustaceanvim)", buf = bufnr})
            set("n", "<leader>rH", "<cmd>RustLsp moveItem up<cr>",      { desc = "Move item up",                    buf = bufnr})
            set("n", "<leader>rK", "<cmd>RustLsp moveItem down<cr>",    { desc = "Move item down",                  buf = bufnr})
            set("n", "gm",         "<cmd>RustLsp parentModule<cr>",     { desc = "Open parent module",              buf = bufnr})
            set("n", "J",          "<cmd>RustLsp joinlines",            { desc = "Join lines (RustLsp)",            buf = bufnr})
            -- stylua: ignore end
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

vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("Rust", { clear = true }),
    pattern = "Cargo.toml",
    callback = function(ev)
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
            completion = { blink = { enabled = true } },
        })

        -- stylua: ignore start
        set("n", "<leader>Ct", crates.toggle,                  { desc = "Toggle",                  buf = ev.buf })
        set("n", "<leader>Cr", crates.reload,                  { desc = "Reload",                  buf = ev.buf })

        set("n", "<leader>Cp", crates.show_popup,              { desc = "Show popup",              buf = ev.buf })
        set("n", "<leader>Cv", crates.show_versions_popup,     { desc = "Show versions",           buf = ev.buf })
        set("n", "<leader>Cf", crates.show_features_popup,     { desc = "Show features",           buf = ev.buf })
        set("n", "<leader>Cd", crates.show_dependencies_popup, { desc = "Show dependencies",       buf = ev.buf })

        set("n", "<leader>Cu", crates.update_crate,            { desc = "Update crate",            buf = ev.buf })
        set("v", "<leader>Cu", crates.update_crates,           { desc = "Update selected crates",  buf = ev.buf })
        set("n", "<leader>Ca", crates.update_all_crates,       { desc = "Update all crates",       buf = ev.buf })
        set("n", "<leader>CU", crates.upgrade_crate,           { desc = "Upgrade crate",           buf = ev.buf })
        set("v", "<leader>CU", crates.upgrade_crates,          { desc = "Upgrade selected crates", buf = ev.buf })
        set("n", "<leader>CA", crates.upgrade_all_crates,      { desc = "Upgrade all crates",      buf = ev.buf })

        set("n", "<leader>CH", crates.open_homepage,           { desc = "Open homepage",           buf = ev.buf })
        set("n", "<leader>CR", crates.open_repository,         { desc = "Open repository",         buf = ev.buf })
        set("n", "<leader>CD", crates.open_documentation,      { desc = "Open documentation",      buf = ev.buf })
        set("n", "<leader>CC", crates.open_crates_io,          { desc = "Open crate.io",           buf = ev.buf })
        -- stylua: ignore start
    end,
})
