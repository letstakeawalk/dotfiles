---@diagnostic disable: missing-parameter

local function next_trouble()
    local trouble = require("trouble")
    trouble.next()
    trouble.jump_only()
end

local function prev_trouble()
    local trouble = require("trouble")
    trouble.prev()
    trouble.jump_only()
end

return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    enabled = false,
    -- stylua: ignore
    keys = {
        { "<leader>xc", function() require("trouble").close() end, desc = "Close Trouble" },
        { "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
        { "<leader>xd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Workspace Diagnostics" },
        { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
        { "<leader>xl", "<cmd>Trouble lsp toggle focus=false<cr>", desc = "LSP" },
        { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
        { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        { "gd", "<cmd>Trouble lsp_definitions focus=false<cr>", desc = "LSP Definitions" },
        { "gD", "<cmd>Trouble lsp_declarations focus=false<cr>", desc = "LSP Declarations" },
        { "gi", "<cmd>Trouble lsp_implementations focus=false<cr>", desc = "LSP Implementation" },
        { "gr", "<cmd>Trouble lsp_references focus=false<cr>", desc = "LSP References" },
        { "gt", "<cmd>Trouble lsp_type_definitions focus=false<cr>", desc = "LSP TypeDefinitions" },
        { "]x", next_trouble, desc = "Goto next trouble" },
        { "[x", prev_trouble, desc = "Goto next trouble"},
    },
    opts = {
        auto_close = false, -- auto close when there are no items
        auto_open = false, -- auto open when there are items
        auto_preview = true, -- automatically open preview when on an item
        auto_refresh = true, -- auto refresh when open
        auto_jump = true, -- auto jump to the item when there's only one
        focus = false, -- Focus the window when opened
        restore = true, -- restores the last location in the list when opening
        follow = false, -- Follow the current item under the cursor
        indent_guides = true, -- show indent guides
        max_items = 200, -- limit number of items that can be displayed per section
        multiline = true, -- render multi-line messages
        pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer
        warn_no_results = true, -- show a warning when there are no results
        open_no_results = false, -- open the trouble window when there are no results
        ---@type trouble.Window.opts
        win = {}, -- window options for the results window. Can be a split or a floating window.
        -- Window options for the preview window. Can be a split, floating window,
        -- or `main` to show the preview in the main editor window.
        ---@type trouble.Window.opts
        preview = { type = "main" },
        -- Key mappings can be set to the name of a builtin action,
        -- or you can define your own custom action.
        ---@type table<string, trouble.Action.spec|false>
        keys = {
            k = "next",
            h = "prev",
        },
        ---@type table<string, trouble.Mode>
        modes = {
            -- sources define their own modes, which you can use directly,
            -- or override like in the example below
            ---@diagnostic disable-next-line: missing-fields
            lsp_references = {
                -- some modes are configurable, see the source code for more details
                params = {
                    include_declaration = false,
                },
            },
            -- The LSP base mode for:
            -- * lsp_definitions, lsp_references, lsp_implementations
            -- * lsp_type_definitions, lsp_declarations, lsp_command
            ---@diagnostic disable-next-line: missing-fields
            lsp_base = {
                params = {
                    -- don't include the current location in the results
                    include_current = true,
                },
            },
        },
    },
}
