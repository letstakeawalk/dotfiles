---@diagnostic disable: redefined-local
vim.lsp.enable({
    "biome",
    "html",
    "htmx",
    "jsonls",
    "lua_ls",
    "markdown_oxide",
    "pyright",
    "ruff",
    "svelte",
    "tailwindcss",
    "taplo",
    "ts_ls",
    "yamlls",
    -- "cssls"
    -- "docker_compose_language_service"
    -- "dockerls"
})

--------------------------------------------------------------------------------
-- Keymaps ---------------------------------------------------------------------
--------------------------------------------------------------------------------
-- stylua: ignore start
vim.keymap.set("n",          "H",          vim.lsp.buf.signature_help,                                                      { desc = "Display Signature Help" })
vim.keymap.set("n",          "K",          vim.lsp.buf.hover,                                                               { desc = "Display Hover Info" })
vim.keymap.set({ "n", "v" }, "<leader>ra", vim.lsp.buf.code_action,                                                         { desc = "Code Action" })
vim.keymap.set({ "n", "v" }, "<leader>rf", function() vim.lsp.buf.format({ async = true }) end,                             { desc = "Format File" })
vim.keymap.set("n",          "<leader>rn", vim.lsp.buf.rename,                                                              { desc = "Rename" })
vim.keymap.set("n",          "<leader>dd", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,           { desc = "Diagnostic Toggle" })
vim.keymap.set("n",          "<leader>dh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end, { desc = "InlayHint Toggle" })
vim.keymap.set("n",          "E",          vim.diagnostic.open_float,                                                       { desc = "Open Float" })
vim.keymap.set("i",          "<C-k>",      require("lsp_signature").toggle_float_win,                                       { desc = "Signature Toggle" })
vim.keymap.set("i",          "<C-s>",      require("lsp_signature").toggle_float_win,                                       { desc = "Signature Toggle" })

vim.keymap.set("n", "<leader>il", "<cmd>LspInfo<cr>",    { desc = "Lsp Info" })
vim.keymap.set("n", "<leader>im", "<cmd>Mason<cr>",      { desc = "Mason Info" })
vim.keymap.set("n", "<leader>in", "<cmd>NullLsInfo<cr>", { desc = "Null-ls Info" })

local next_diag, prev_diag = require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
    function() vim.diagnostic.jump({ count = 1,  float = true }) end,
    function() vim.diagnostic.jump({ count = -1, float = true }) end
)
vim.keymap.set("n", "[d", prev_diag, { desc = "Goto previous diagnostic" })
vim.keymap.set("n", "]d", next_diag, { desc = "Goto next diagnostic" })
-- stylua: ignore end

--------------------------------------------------------------------------------
-- UI config -------------------------------------------------------------------
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        require("lsp_signature").on_attach({}, ev.buf)
    end,
})

-- globally override border of floating window
local original_open_floating_preview = vim.lsp.util.open_floating_preview
local function open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return original_open_floating_preview(contents, syntax, opts, ...)
end
vim.lsp.util.open_floating_preview = open_floating_preview

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
