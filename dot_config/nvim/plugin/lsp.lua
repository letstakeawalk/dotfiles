---@diagnostic disable: redefined-local
vim.lsp.enable({
    "ast_grep",
    "biome",
    "docker_language_server",
    "html",
    "htmx", -- manually installed v0.2.0 via cargo -- 2026.01.29
    "jsonls",
    "lua_ls",
    "markdown_oxide",
    "oxlint",
    "ruff",
    "svelte",
    "tailwindcss",
    "taplo",
    "ts_ls", -- "tsgo", "vtsls",
    "ty", -- "pyright", "basedpyright"
    "yamlls",
    -- "cssls"
})
-- vim.lsp.enable({
--     "codebook",
--     "harper_ls",
-- }, false)

--------------------------------------------------------------------------------
-- UI config -------------------------------------------------------------------
--------------------------------------------------------------------------------
-- globally override border of floating window
local original_open_floating_preview = vim.lsp.util.open_floating_preview
local function open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return original_open_floating_preview(contents, syntax, opts, ...)
end
vim.lsp.util.open_floating_preview = open_floating_preview

local diagnostic_virtual_lines = false

vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = diagnostic_virtual_lines,
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

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Enable LSP Signature Float",
    callback = function(ev)
        require("lsp_signature").on_attach({}, ev.buf)
    end,
})

--------------------------------------------------------------------------------
-- Keymaps ---------------------------------------------------------------------
--------------------------------------------------------------------------------

local function async_format()
    vim.lsp.buf.format({ async = true })
end
local function toggle_diagnostic()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end
local function toggle_diagnostic_virtual()
    vim.diagnostic.config({ virtual_lines = not diagnostic_virtual_lines })
    diagnostic_virtual_lines = not diagnostic_virtual_lines
end
local function toggle_inlay_hint()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
end
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
local function toggle_signature_float()
    require("lsp_signature").toggle_float_win()
end
local function diag_jump(count, severity)
    return function()
        local res = vim.diagnostic.jump({
            count = count,
            severity = severity,
            float = true,
        })
        if res ~= nil then
            require("utils").centerscreen()
        end
    end
end
local next_diag, prev_diag = require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
    diag_jump(1, { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR }),
    diag_jump(-1, { vim.diagnostic.severity.WARN, vim.diagnostic.severity.ERROR })
)
local next_hint, prev_hint = require("nvim-treesitter.textobjects.repeatable_move").make_repeatable_move_pair(
    diag_jump(1, { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT }),
    diag_jump(-1, { vim.diagnostic.severity.INFO, vim.diagnostic.severity.HINT })
)

vim.keymap.set("n", "<leader>il", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
vim.keymap.set("n", "<leader>im", "<cmd>Mason<cr>", { desc = "Mason Info" })
vim.keymap.set("n", "<leader>in", "<cmd>NullLsInfo<cr>", { desc = "Null-ls Info" })

vim.api.nvim_create_autocmd("LspAttach", {
    desc = "Keymaps for LSP",
    -- stylua: ignore
    callback = function(args)
        vim.keymap.set("n",          "E",          vim.diagnostic.open_float,  { desc = "Display Dianostic",           buffer = args.buf })
        vim.keymap.set("n",          "H",          vim.lsp.buf.signature_help, { desc = "Display Signature Help",      buffer = args.buf })
        vim.keymap.set("n",          "K",          vim.lsp.buf.hover,          { desc = "Display Hover Info",          buffer = args.buf })
        vim.keymap.set({ "n", "v" }, "<leader>ra", vim.lsp.buf.code_action,    { desc = "Code Action",                 buffer = args.buf })
        vim.keymap.set({ "n", "v" }, "<leader>rf", async_format,               { desc = "Format File",                 buffer = args.buf })
        vim.keymap.set("n",          "<leader>rn", vim.lsp.buf.rename,         { desc = "Rename",                      buffer = args.buf })
        vim.keymap.set("n",          "<leader>dD", toggle_diagnostic,          { desc = "Diagnostic Toggle",           buffer = args.buf })
        vim.keymap.set("n",          "<leader>dd", toggle_diagnostic_virtual,  { desc = "Diagnostic (virtual) Toggle", buffer = args.buf })
        vim.keymap.set("n",          "<leader>dh", toggle_inlay_hint,          { desc = "InlayHint Toggle",            buffer = args.buf })
        vim.keymap.set("i",          "<C-k>",      toggle_signature_float,     { desc = "Signature Toggle",            buffer = args.buf })
        vim.keymap.set("i",          "<C-s>",      toggle_signature_float,     { desc = "Signature Toggle",            buffer = args.buf })

        vim.keymap.set("n", "gd", vim.lsp.buf.definition,      { desc = "Goto Definition",      buffer = args.buf })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration,     { desc = "Goto Declaration",     buffer = args.buf })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation,  { desc = "Goto Implementation",  buffer = args.buf })
        vim.keymap.set("n", "gr", vim_lsp_buf_references,      { desc = "Goto References",      buffer = args.buf })
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "Goto Type Definition", buffer = args.buf })

        vim.keymap.set("n", "[d", prev_diag, { desc = "Goto previous diagnostic", buffer = args.buf})
        vim.keymap.set("n", "]d", next_diag, { desc = "Goto next diagnostic",     buffer = args.buf})
        vim.keymap.set("n", "[h", prev_hint, { desc = "Goto previous hint/info",  buffer = args.buf})
        vim.keymap.set("n", "]h", next_hint, { desc = "Goto next hink/info",      buffer = args.buf})
    end,
})

local auto_format = true
vim.keymap.set("n", "<leader>df", function()
    auto_format = not auto_format
    vim.notify("AutoFormat " .. (auto_format and "Enabled" or "Disabled"), vim.log.levels.INFO)
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
                    if auto_format then
                        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, async = false })
                    end
                end,
            })
        end
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/foldingRange") then
            local win = vim.api.nvim_get_current_win()
            vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
        end
    end,
})

-- LSP commands (from lspconfig)
local api, lsp = vim.api, vim.lsp

local complete_client = function(arg)
    return vim.iter(vim.lsp.get_clients())
        :map(function(client)
            return client.name
        end)
        :filter(function(name)
            return name:sub(1, #arg) == arg
        end)
        :totable()
end
local complete_config = function(arg)
    return vim.iter(vim.api.nvim_get_runtime_file(("lsp/%s*.lua"):format(arg), true))
        :map(function(path)
            local file_name = path:match("[^/]*.lua$")
            return file_name:sub(0, #file_name - 4)
        end)
        :totable()
end

api.nvim_create_user_command("LspInfo", "checkhealth lsp", { desc = "LspInfo" })

api.nvim_create_user_command("LspLog", function()
    vim.cmd(string.format("tabnew %s", lsp.log.get_filename()))
end, {
    desc = "Opens the Nvim LSP client log.",
})

api.nvim_create_user_command("LspStart", function(info)
    local servers = info.fargs

    -- Default to enabling all servers matching the filetype of the current buffer.
    -- This assumes that they've been explicitly configured through `vim.lsp.config`,
    -- otherwise they won't be present in the private `vim.lsp.config._configs` table.
    if #servers == 0 then
        local filetype = vim.bo.filetype
        ---@diagnostic disable-next-line: invisible
        for name, _ in pairs(vim.lsp.config._configs) do
            local filetypes = vim.lsp.config[name].filetypes
            if filetypes and vim.tbl_contains(filetypes, filetype) then
                table.insert(servers, name)
            end
        end
    end

    vim.lsp.enable(servers)
end, {
    desc = "Enable and launch a language server",
    nargs = "?",
    complete = complete_config,
})

api.nvim_create_user_command("LspRestart", function(info)
    local client_names = info.fargs

    -- Default to restarting all active servers
    if #client_names == 0 then
        client_names = vim.iter(vim.lsp.get_clients())
            :map(function(client)
                return client.name
            end)
            :totable()
    end

    for name in vim.iter(client_names) do
        if vim.lsp.config[name] == nil then
            vim.notify(("Invalid server name '%s'"):format(name))
        else
            vim.lsp.enable(name, false)
            if info.bang then
                vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
                    client:stop(true)
                end)
            end
        end
    end

    local timer = assert(vim.uv.new_timer())
    timer:start(500, 0, function()
        for name in vim.iter(client_names) do
            vim.schedule_wrap(vim.lsp.enable)(name)
        end
    end)
end, {
    desc = "Restart the given client",
    nargs = "?",
    bang = true,
    complete = complete_client,
})

api.nvim_create_user_command("LspStop", function(info)
    local client_names = info.fargs

    -- Default to disabling all servers on current buffer
    if #client_names == 0 then
        client_names = vim.iter(vim.lsp.get_clients())
            :map(function(client)
                return client.name
            end)
            :totable()
    end

    for name in vim.iter(client_names) do
        if vim.lsp.config[name] == nil then
            vim.notify(("Invalid server name '%s'"):format(name))
        else
            vim.lsp.enable(name, false)
            if info.bang then
                vim.iter(vim.lsp.get_clients({ name = name })):each(function(client)
                    client:stop(true)
                end)
            end
        end
    end
end, {
    desc = "Disable and stop the given client",
    nargs = "?",
    bang = true,
    complete = complete_client,
})

return
