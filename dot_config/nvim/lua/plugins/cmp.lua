return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-lua/plenary.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "petertriho/cmp-git",
        "onsails/lspkind.nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "zbirenbaum/copilot.lua",
        -- https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
        -- zbirenbaum/copilot-cmp
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        local luasnip = require("luasnip")
        local copilot = require("copilot.suggestion")

        local function has_words_before()
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        ---@param fallback function
        local function confirm_complete(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Select })
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end

        ---@param fallback function
        local function confirm_or_copilot_accept(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Select })
            elseif copilot.is_visible() then
                copilot.accept()
            else
                fallback()
            end
        end

        ---Select cmp next/prev items, copilot next/prev suggestions, jump luasnips OR fallback
        ---@param forward boolean
        local function select_cmp_copilot_snip_jump(forward)
            ---@param fallback function
            return function(fallback)
                if cmp.visible() then
                    if forward then
                        cmp.select_next_item()
                    else
                        cmp.select_prev_item()
                    end
                elseif copilot.is_visible() then
                    if forward then
                        copilot.next()
                    else
                        copilot.prev()
                    end
                elseif forward and luasnip.locally_jumpable(1) then
                    luasnip.jump(1)
                elseif not forward and luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end
        end

        ---@param callback? function
        local function close_or(callback)
            ---@param fallback function
            return function(fallback)
                if cmp.visible() then
                    cmp.close()
                elseif callback ~= nil then
                    callback()
                else
                    fallback()
                end
            end
        end

        ---@param item string
        ---@param max_len number
        local function truncate(item, max_len)
            if #item > max_len then
                return string.sub(item, 1, max_len - 1) .. "…"
            else
                return item
            end
        end

        local lspkind_formatter = lspkind.cmp_format({
            mode = "symbol_text",
        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            preselect = cmp.PreselectMode.Item, -- preselect entry respect to LSP
            ---@diagnostic disable-next-line: missing-fields
            -- performance = { max_view_entries = 8 },
            -- automatically select first item OR preselected item from the LSP
            completion = { completeopt = "menu,menuone" }, -- default 'menu,menuone,noselect'
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = function(entry, vim_item)
                    vim_item.abbr = truncate(vim_item.abbr, 25)
                    vim_item.abbr = " " .. vim_item.abbr .. "  "
                    if vim_item.menu ~= nil then
                        vim_item.menu = truncate(vim_item.menu, 40)
                    end
                    return lspkind_formatter(entry, vim_item)
                end,
                expandable_indicator = true,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            mapping = {
                ["<Down>"] = cmp.mapping.select_next_item(),
                ["<Up>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping(select_cmp_copilot_snip_jump(true), { "i", "s" }),
                ["<C-p>"] = cmp.mapping(select_cmp_copilot_snip_jump(false), { "i", "s" }),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-y>"] = cmp.mapping(confirm_or_copilot_accept),
                ["<Esc>"] = close_or(nil),
                ["<Tab>"] = cmp.mapping(confirm_complete, { "i", "s" }),
            },
            sources = cmp.config.sources({
                { name = "luasnip" },
                {
                    name = "nvim_lsp",
                    option = {
                        markdown_oxide = { keyword_pattern = [[\(\k\| \|\/\|#\)\+]] },
                    },
                },
                { name = "nvim_lua" },
            }, {
                { name = "buffer" },
            }),
            -- sorting = {},
        })

        local cmdline_mapping = {
            ["<Down>"] = { c = cmp.mapping.select_next_item() },
            ["<Up>"] = { c = cmp.mapping.select_prev_item() },
            ["<Tab>"] = { c = confirm_complete },
            ["<Esc>"] = {
                c = close_or(function()
                    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "c", true)
                end),
            },
        }

        cmp.setup.cmdline(":", {
            mapping = cmdline_mapping,
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmdline_mapping,
            sources = {
                { name = "buffer" },
            },
        })

        -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
        -- Set configuration for specific filetype.
        cmp.setup.filetype("gitcommit", {
            sources = cmp.config.sources({
                { name = "git" },
            }, {
                { name = "buffer" },
            }),
        })

        ---@diagnostic disable-next-line: missing-parameter
        require("cmp_git").setup()
    end,
}
