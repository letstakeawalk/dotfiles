return {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "Trouble" },
    -- stylua: ignore
    keys = {
        { "<leader>xx", "<cmd>Trouble<cr>",                       desc = "Trouble" },
        { "<leader>xc", "<cmd>TroubleClose<cr>",                  desc = "Close Trouble" },
        { "<leader>xd", "<cmd>Trouble workspace_diagnostics<cr>", desc = "Workspace Diagnistics" },
        { "<leader>xD", "<cmd>Trouble document_diagnostics<cr>",  desc = "Document Diagnostics" },
        { "<leader>xl", "<cmd>Trouble loclist<cr>",               desc = "Locallist" },
        { "<leader>xq", "<cmd>Trouble quickfix<cr>",              desc = "Quickfix" },
        { "gd",         "<cmd>Trouble lsp_definitions<cr>",       desc = "LSP Definition" },
        { "gi",         "<cmd>Trouble lsp_implementations<cr>",   desc = "LSP Implementation" },
        { "gr",         "<cmd>Trouble lsp_references<cr>",        desc = "LSP References" },
        { "gt",         "<cmd>Trouble lsp_type_definitions<cr>",  desc = "LSP TypeDefinition" },
        { "]x", function() require("trouble").next({ skip_groups = true, jump = true }) end,     desc = "Goto next trouble" },
        { "[x", function() require("trouble").previous({ skip_groups = true, jump = true }) end, desc = "Goto previous trouble" },
    },
    opts = {
        -- position = "right", -- position of the list can be: bottom, top, left, right
        -- widtk = 60, -- width of the list when position is left or right
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        -- severity = vim.diagnostic.severity.INFO,
        group = true,
        -- for the given modes, automatically jump if there is only a single result
        auto_jump = { "lsp_definitions", "lsp_implementations", "lsp_references" },
        -- for the given modes, include the declaration of the current symbol in the results
        include_declaration = {},
        multiline = false,
        action_keys = { previous = "h", next = "k" },
        signs = {
            error = " ",
            warning = " ",
            hint = " ",
            information = " ",
            other = " ",
        },
    },
}

-- return {
--     "folke/trouble.nvim",
--     branch = "dev",
--     -- stylua: ignore
--     keys = {
--         { "<leader>xc", function() require("trouble").close() end, desc = "Close Trouble" },
--         { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
--         { "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
--         { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
--         { "<leader>xl", "<cmd>Trouble lsp toggle focus=false<cr>", desc = "LSP" },
--         { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
--         { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
--         { "gd", "<cmd>Trouble lsp_definitions focus=false<cr>", desc = "LSP Definitions" },
--         { "gD", "<cmd>Trouble lsp_declarations focus=false<cr>", desc = "LSP Declarations" },
--         { "gi", "<cmd>Trouble lsp_implementations focus=false<cr>", desc = "LSP Implementation" },
--         { "gr", "<cmd>Trouble lsp_references focus=false<cr>", desc = "LSP References" },
--         { "gt", "<cmd>Trouble lsp_type_definitions focus=false<cr>", desc = "LSP TypeDefinitions" },
--         ---@diagnostic disable-next-line: missing-parameter
--         { "]x", function() require("trouble").next() end, desc = "Goto next trouble" },
--         ---@diagnostic disable-next-line: missing-parameter
--         { "[x", function() require("trouble").prev() end, desc = "Goto next trouble" },
--     },
--     opts = {
--         auto_close = true,
--         auto_jump = true, -- auto jump to the item when there's only one
--         focus = false, -- Focus the window when opened
--         follow = false,
--         indent_guides = false,
--         ---@type trouble.Window.opts
--         win = {}, -- window options for the results window. Can be a split or a floating window.
--         -- Window options for the preview window. Can be a split, floating window,
--         -- or `main` to show the preview in the main editor window.
--         ---@type trouble.Window.opts
--         preview = { type = "main" },
--         -- Key mappings can be set to the name of a builtin action,
--         -- or you can define your own custom action.
--         ---@type table<string, string|trouble.Action>
--         keys = {
--             k = "next",
--             h = "prev",
--         },
--     },
-- }
