vim.pack.add({
    "gh:neovim/nvim-lspconfig",
    "gh:mason-org/mason.nvim",
    "gh:nvimtools/none-ls.nvim",
    "gh:nvimtools/none-ls-extras.nvim",
    "gh:gbprod/none-ls-shellcheck.nvim",
    "gh:ray-x/lsp_signature.nvim",
    "gh:folke/lazydev.nvim",
    "gh:nvim-lua/plenary.nvim",
})

local config = require("config")
config.language_servers = {
    "bashls",
    "biome",
    "gh_actions_ls",
    "gitlab_ci_ls",
    "html",
    "jsonls",
    "lua_ls",
    "oxfmt",
    "oxlint",
    "ruff",
    "sqlls",
    "svelte",
    "tailwindcss",
    "tombi",
    "ts_ls", -- "tsgo", "vtsls",
    "ty", -- "pyright", "basedpyright"
    "yamlls",
}
config.nonels = {
    "stylua",
    "shellharden",
    "shfmt",
    "shellcheck",
    "sqlfluff",
    "trivy",
    "gitlint",
    "gitleaks",
    "mdsf",
}
vim.lsp.enable(config.language_servers)

require("mason").setup({
    ui = {
        border = "double",
        icons = {
            package_installed = "✓",
            package_pending = "",
            package_uninstalled = "✗",
        },
    },
})

-- lazydev
vim.api.nvim_create_autocmd("FileType", {
    pattern = "lua",
    callback = function()
        require("lazydev").setup({
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        })
    end,
})

require("lsp_signature").setup({ hint_enable = false }) -- handler_opts = { border = "rounded" }

local nls = require("null-ls")
local formatting = nls.builtins.formatting
local diagnostics = nls.builtins.diagnostics
nls.setup({
    debug = false,
    border = "double",
    sources = {
        formatting.stylua, -- lua
        -- bash
        formatting.shellharden,
        formatting.shfmt,
        require("none-ls-shellcheck.diagnostics"),
        require("none-ls-shellcheck.code_actions"),
        -- sql
        formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
        diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
        diagnostics.trivy, -- misconfig & vulnerability
        diagnostics.gitlint, -- gitcommit
        diagnostics.gitleaks,
        require("none-ls.formatting.mdsf"), -- markdown code block

        -- require("none-ls.formatting.mdslw"), -- markdown line wrapper
        -- formatting.mdformat, -- markdown
        -- diagnostics.todo_comments,

        -- code_actions.gitsigns,
        -- diagnostics.buf, -- protobuf
        -- diagnostics.actionlint, -- github action
        -- diagnostics.ansiblelint, -- ansible
        -- diagnostics.hadolint, -- docker
        -- diagnostics.mypy, -- python
        -- diagnostics.bandit, -- python
        -- mdslw
        -- hadolint
    },
})

--------------------------------------------------------------------------------
-- Keymaps ---------------------------------------------------------------------
--------------------------------------------------------------------------------
local utils = require("utils")

local function async_format() vim.lsp.buf.format({ async = true }) end
local function toggle_diagnostic() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end
local function toggle_diagnostic_virtual()
    vim.diagnostic.config({ virtual_lines = not config.diagnostic.virtual_lines })
    config.diagnostic.virtual_lines = not config.diagnostic.virtual_lines
end
local function toggle_inlay_hint() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})) end
local function vim_lsp_buf_references()
    vim.lsp.buf.references({ includeDeclaration = false }, {
        --- jump to the first reference if only one
        on_list = function(opts)
            ---@diagnostic disable-next-line: param-type-mismatch
            vim.fn.setqflist({}, " ", opts)
            vim.cmd.copen()
            if #opts.items == 1 then
                vim.cmd.cfirst()
                vim.cmd.cclose()
            end
        end,
    })
end

local function diag_jump(count, severity)
    return function()
        vim.print("hi")
        local res = vim.diagnostic.jump({
            count = count,
            severity = severity,
            float = true,
        })
        if res ~= nil then utils.centerscreen() end
    end
end

local next_diag, prev_diag = utils.repeatable(
    diag_jump(1, { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR }),
    diag_jump(-1, { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR })
)
local next_hint, prev_hint = utils.repeatable(
    diag_jump(1, { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT }),
    diag_jump(-1, { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT })
)
local set = require("utils.keymap").set
vim.api.nvim_create_autocmd("LspAttach", {
    -- stylua: ignore
    callback = function(ev)
        set("n",   "E",          vim.diagnostic.open_float,  { desc = "Display Dianostic",           buf = ev.buf })
        set("n",   "H",          vim.lsp.buf.signature_help, { desc = "Display Signature Help",      buf = ev.buf })
        set("n",   "K",          vim.lsp.buf.hover,          { desc = "Display Hover Info",          buf = ev.buf })
        set("nv",  "<leader>ra", vim.lsp.buf.code_action,    { desc = "Code Action",                 buf = ev.buf })
        set("nv",  "<leader>rf", async_format,               { desc = "Format File",                 buf = ev.buf })
        set("n",   "<leader>rn", vim.lsp.buf.rename,         { desc = "Rename",                      buf = ev.buf })
        set("n",   "<leader>dD", toggle_diagnostic,          { desc = "Diagnostic Toggle",           buf = ev.buf })
        set("n",   "<leader>dd", toggle_diagnostic_virtual,  { desc = "Diagnostic (virtual) Toggle", buf = ev.buf })
        set("n",   "<leader>dh", toggle_inlay_hint,          { desc = "InlayHint Toggle",            buf = ev.buf })

        set("n", "gd", vim.lsp.buf.definition,      { desc = "Goto Definition",      buf = ev.buf })
        set("n", "gD", vim.lsp.buf.declaration,     { desc = "Goto Declaration",     buf = ev.buf })
        set("n", "gI", vim.lsp.buf.implementation,  { desc = "Goto Implementation",  buf = ev.buf })
        set("n", "gr", vim_lsp_buf_references,      { desc = "Goto References",      buf = ev.buf })
        set("n", "gt", vim.lsp.buf.type_definition, { desc = "Goto Type Definition", buf = ev.buf })
        -- grx -> vim.lsp.codelens.run()
        -- gO  -> vim.lsp.buf.document_symbol()
        -- gx  -> textDoc/documentLink

        set("n", "[d", prev_diag, { desc = "Goto previous diagnostic", buf = ev.buf})
        set("n", "]d", next_diag, { desc = "Goto next diagnostic",     buf = ev.buf})
        set("n", "[h", prev_hint, { desc = "Goto previous hint/info",  buf = ev.buf})
        set("n", "]h", next_hint, { desc = "Goto next hint/info",      buf = ev.buf})

        set("i", "<A-s>", require("lsp_signature").toggle_float_win, { desc = "Signature Toggle", buf = ev.buf })

        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client and client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})

-- Auto-Formatting
set("n", "<leader>dF", function()
    config.autoformat = not config.autoformat
    vim.notify(
        "AutoFormat " .. (config.autoformat and "Enabled" or "Disabled"),
        vim.log.levels.INFO
    )
end, { desc = "AutoFormat Toggle" })
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Auto format on save if LS is capable",
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        ---@diagnostic disable-next-line: missing-parameter, param-type-mismatch
        if client and client:supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
                desc = "Auto format on save",
                buffer = args.buf,
                callback = function()
                    if config.autoformat then
                        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, async = false })
                    end
                end,
            })
        end
    end,
})

set("n", "<leader>il", "<cmd>checkhealth lsp<cr>", { desc = "Lsp Info" })
set("n", "<leader>im", "<cmd>Mason<cr>", { desc = "Mason Info" })
set("n", "<leader>in", "<cmd>NullLsInfo<cr>", { desc = "Null-ls Info" })

--------------------------------------------------------------------------------
-- UI config -------------------------------------------------------------------
--------------------------------------------------------------------------------

--- reflow hard-wrapped markdown paragraphs so they fit the popup width
-- local function reflow_markdown_lines(lines)
--     local result = {}
--     local in_code_block = false
--     local paragraph = {}
--
--     local function flush()
--         if #paragraph > 0 then
--             result[#result + 1] = table.concat(paragraph, " ")
--             paragraph = {}
--         end
--     end
--
--     for _, line in ipairs(lines) do
--         if line:match("^%s*```") then -- code fence boundary
--             flush()
--             in_code_block = not in_code_block
--             result[#result + 1] = line
--         elseif in_code_block then -- verbatim inside code block
--             result[#result + 1] = line
--         elseif line:match("^%s*$") then -- blank line (paragraph break)
--             flush()
--             result[#result + 1] = line
--         elseif
--             line:match("^%s*#+%s") -- heading (require space after #)
--             or line:match("^%s*[%-*+]%s") -- unordered list item
--             or line:match("^%s*%d+%.%s") -- ordered list item
--             or line:match("^%s*>") -- blockquote
--             or line:match("^%s*|") -- table row
--             or line:match("^%s*%-%-%-") -- horizontal rule
--         then
--             flush()
--             result[#result + 1] = line
--         else
--             paragraph[#paragraph + 1] = vim.trim(line) -- accumulate paragraph text
--         end
--     end
--     flush()
--     return result
-- end

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = config.diagnostic.virtual_lines,
    float = { -- format as `i: message (code) [src]`
        format = function(diag) return diag.message end,
        suffix = function(diag, _, _)
            local code = diag.code and " (" .. diag.code .. ")" or ""
            local source = diag.source and " [" .. diag.source .. "]" or ""
            return code .. source, "Comment"
        end,
        -- source = "always", -- format as `i. src: message (code)`
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "E", --" ",
            [vim.diagnostic.severity.WARN] = "W", -- " ",
            [vim.diagnostic.severity.HINT] = "H", -- " ",
            [vim.diagnostic.severity.INFO] = "I", -- " ",
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
