-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- Setup nvim-cmp.
-- https://github.com/hrsh7th/nvim-cmp
-------------------------------------------------------------------------------
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

        local has_words_before = function()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            completion = {
                completeopt = "menu,menuone", -- default 'menu,menuone,noselect'
                -- keyword_length = 2,
            },
            formatting = {
                fields = {
                    "abbr",
                    "kind",
                    "menu",
                },
                format = function(entry, vim_item) -- wrapper for extra padding
                    local formatter = lspkind.cmp_format({
                        mode = "symbol_text", -- "text", "text_symbol", "symbol_text", "symbol"
                        menu = {
                            buffer = "[Buffer]",
                            nvim_lsp = "[LSP]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                        },
                    })
                    vim_item = formatter(entry, vim_item)
                    vim_item.abbr = " " .. vim_item.abbr
                    vim_item.kind = "   " .. vim_item.kind .. " "
                    -- vim_item.menu = ""
                    return vim_item
                end,
            },
            window = {
                documentation = {
                    border = "rounded",
                    winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder", -- TODO revisit
                },
                completion = {
                    border = "rounded",
                    winhighlight = "NormalFloat:Normal,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
                },
            },
            mapping = {
                -- Assign `cmp.config.disable` to remove the default mapping.
                ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<ESC>"] = cmp.mapping.abort(),
                ["<C-y>"] = cmp.mapping.confirm({ select = false }), -- true: Accept first item. false: confirm explicitly selected items.
                -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    -- select or confirm suggestion if visible or fallback
                    if cmp.visible() then
                        local entry = cmp.get_selected_entry()
                        if not entry then
                            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                        else
                            cmp.confirm()
                        end
                    elseif has_words_before() then
                        cmp.complete() -- open cmp menu
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "nvim_lua" },
                { name = "buffer" },
                { name = "neorg" },
            }),
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            mapping = {
                ["<C-k>"] = {
                    c = function() -- select next suggestion
                        if not cmp.visible() then
                            cmp.complete()
                        end
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    end,
                },
                ["<C-h>"] = {
                    c = function() -- select prev suggestion
                        if not cmp.visible() then
                            cmp.complete()
                        end
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    end,
                },
                ["<C-n>"] = {
                    c = function() -- select next suggestion
                        if not cmp.visible() then
                            cmp.complete()
                        end
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    end,
                },
                ["<C-p>"] = {
                    c = function() -- select prev suggestion
                        if not cmp.visible() then
                            cmp.complete()
                        end
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    end,
                },
                ["<Tab>"] = {
                    c = function() -- select or confirm suggestion if visible
                        if cmp.visible() then
                            local entry = cmp.get_selected_entry()
                            if not entry then
                                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                            else
                                cmp.confirm()
                            end
                        elseif has_words_before() then
                            cmp.complete()
                        end
                    end,
                },
                -- ["<S-Tab>"] = { c = select_prev },
                -- ["<C-c>"] = { c = cmp.mapping.close() },
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

        -- TODO:
        -- make cmp float look like this
        -- https://github.com/hrsh7th/nvim-cmp/issues/426#issuecomment-953723151
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu

        -- gray
        vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { strikethrough = true, fg = "#808080" })
        -- blue
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#569CD6" })
        vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "CmpItemAbbrMatch" })
        -- light blue
        vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#9CDCFE" })
        vim.api.nvim_set_hl(0, "CmpItemKindInterface", { link = "CmpItemKindVariable" })
        vim.api.nvim_set_hl(0, "CmpItemKindText", { link = "CmpItemKindVariable" })
        -- pink
        vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#C586C0" })
        vim.api.nvim_set_hl(0, "CmpItemKindMethod", { link = "CmpItemKindFunction" })
        -- front
        vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#D4D4D4" })
        vim.api.nvim_set_hl(0, "CmpItemKindProperty", { link = "CmpItemKindKeyword" })
        vim.api.nvim_set_hl(0, "CmpItemKindUnit", { link = "CmpItemKindKeyword" })

        vim.api.nvim_set_hl(0, "CmpItemKindClass", { fg = "#C586C0" })
        vim.api.nvim_set_hl(0, "CmpItemKindModule", { fg = "#C586C0" })

        -- TODO: notable sources
        -- https://github.com/jcha0713/cmp-tw2css
    end,
}
