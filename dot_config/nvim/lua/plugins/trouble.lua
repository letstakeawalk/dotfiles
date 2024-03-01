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
        -- { "T", "<cmd>Trouble lsp_type_definitions<cr>", desc = "LSP TypeDefinition" },
    },
    init = function() vim.api.nvim_set_hl(0, "TroublePreview", { link = "Search" }) end,
    opts = {
        -- position = "right", -- position of the list can be: bottom, top, left, right
        -- widtk = 60, -- width of the list when position is left or right
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        -- severity = vim.diagnostic.severity.INFO,
        group = true,
        -- for the given modes, automatically jump if there is only a single result
        auto_jump = { "lsp_definitions", "lsp_references" },
        -- for the given modes, include the declaration of the current symbol in the results
        include_declaration = { "lsp_definitions", "lsp_implementations" },
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
} -- list of troubles
