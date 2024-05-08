---@diagnostic disable: unused-local
return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "onsails/lspkind.nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local types = require("cmp.types")

        -- TODO: move to utils.
        local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            preselect = cmp.PreselectMode.Item, -- preselect entry respect to LSP
            -- automatically select first item OR preselected item from the LSP
            completion = { completeopt = "menu,menuone" }, -- default 'menu,menuone,noselect'
            ---@diagnostic disable-next-line: missing-fields
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, vim_item) -- wrapper for extra padding
                    local formatter = lspkind.cmp_format({
                        mode = "symbol_text", -- "text", "text_symbol", "symbol_text", "symbol"
                        menu = {
                            buffer = "[Bfr]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                            -- copilot = "[AI]",
                        },
                        -- symbol_map = { Copilot = "" },
                    })
                    vim_item = formatter(entry, vim_item)
                    vim_item.abbr = " " .. vim_item.abbr
                    vim_item.kind = "   " .. vim_item.kind .. " "
                    vim_item.menu = "" -- hide menu
                    return vim_item
                end,
            },
            window = {
                documentation = { border = "rounded", winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder" },
                completion = { border = "rounded", winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder" },
            },
            mapping = {
                -- Assign `cmp.config.disable` to remove the default mapping.
                ["<Down>"] = cmp.mapping.select_next_item(),
                ["<Up>"] = cmp.mapping.select_prev_item(),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                -- ["<ESC>"] = cmp.mapping.abort(),
                ["<C-Space>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                    end
                end),
                ["<Esc>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.close()
                    else
                        fallback()
                    end
                end),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    -- select or confirm suggestion if visible or fallback
                    if cmp.visible() then
                        cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Select })
                    elseif has_words_before() then
                        cmp.complete() -- open cmp menu
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            sources = cmp.config.sources({
                { name = "luasnip", max_item_count = 4 },
                {
                    name = "nvim_lsp",
                    entry_filter = function(entry, ctx) -- filter specific entries that conflict w/ snippets
                        if entry.source.source.client.name == "rust_analyzer" then
                            local filter = { "struct", "enum", "impl", "if let", "match", "is_x86_feature_detected!" }
                            if vim.tbl_contains(filter, entry:get_filter_text()) then
                                return false
                            end
                        elseif entry.source.source.client.name == "svelte" then
                            local filter = { "script" }
                            if vim.tbl_contains(filter, entry:get_filter_text()) then
                                return false
                            end
                        end
                        return true
                    end,
                },
                { name = "nvim_lua" },
                -- { name = "copilot", max_item_count = 2 },
            }, {
                { name = "buffer" },
            }),
            sorting = {
                priority_weight = 2,
                comparators = {
                    cmp.config.compare.offset,
                    cmp.config.compare.exact,
                    cmp.config.compare.score,
                    cmp.config.compare.kind,
                    cmp.config.compare.recently_used,
                    cmp.config.compare.locality,
                    cmp.config.compare.sort_text,
                    cmp.config.compare.length,
                    cmp.config.compare.order,
                },
            },
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = {
                ["<Down>"] = { c = cmp.mapping.select_next_item() },
                ["<Up>"] = { c = cmp.mapping.select_prev_item() },
                ["<Tab>"] = {
                    c = function(fallback) -- select or confirm suggestion if visible
                        if cmp.visible() then
                            cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Select })
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end,
                },
                ["<Esc>"] = {
                    c = function() -- close menu if visible, exit cmd-mode otherwise
                        if cmp.visible() then
                            cmp.close()
                        else
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "t", true)
                        end
                    end,
                },
            },
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })

        -- highlight -- TODO: catpuccine
        -- stylua: ignore start
        local nord = require("utils.nord")
        vim.api.nvim_set_hl(0, "CmpItemAbbr",           { fg = nord.c04_wht }) -- unmatched chars of completion field
        vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#808080", strikethrough = true }) -- unmatched chars of depr field
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",      { fg = "#74C0FC", bold = true }) --"#569CD6" }) -- matched chars of completion field
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" }) -- fuzzy-matched chars
        vim.api.nvim_set_hl(0, "CmpItemKind",           { fg = nord.c04_wht_dk }) -- kind of fields
        vim.api.nvim_set_hl(0, "CmpItemKindVariable",   { fg = "#9CDCFE" })
        vim.api.nvim_set_hl(0, "CmpItemKindInterface",  { link = "CmpItemKindVariable" })
        vim.api.nvim_set_hl(0, "CmpItemKindText",       { link = "CmpItemKindVariable" })
        vim.api.nvim_set_hl(0, "CmpItemKindFunction",   { fg = "#C586C0" })
        vim.api.nvim_set_hl(0, "CmpItemKindMethod",     { link = "CmpItemKindFunction" })
        vim.api.nvim_set_hl(0, "CmpItemKindClass",      { fg = "#C586C0" })
        vim.api.nvim_set_hl(0, "CmpItemKindModule",     { link = "CmpItemKindClass" })
        vim.api.nvim_set_hl(0, "CmpItemKindStruct",     { link = "CmpItemKindClass" })
        vim.api.nvim_set_hl(0, "CmpItemKindEnum",       { link = "CmpItemKindClass" })
        vim.api.nvim_set_hl(0, "CmpItemKindKeyword",    { fg = "#D4D4D4" })
        vim.api.nvim_set_hl(0, "CmpItemKindProperty",   { link = "CmpItemKindKeyword" })
        vim.api.nvim_set_hl(0, "CmpItemKindUnit",       { link = "CmpItemKindKeyword" })
        vim.api.nvim_set_hl(0, "CmpItemKindSnippet",    { fg = "#D0BFFF" })
        -- vim.api.nvim_set_hl(0, "CmpItemKindCopilot",    { fg = "#20C997" })
        vim.api.nvim_set_hl(0, "CmpItemMenu",           { link = "Comment" })
        -- stylua: ignore end

        -- vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = nord.nord14_gui }) -- menu fields
        -- https://github.com/jcha0713/cmp-tw2css
    end,
}
