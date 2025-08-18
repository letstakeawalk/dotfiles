local has_words_before = function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if col == 0 then
        return false
    end
    local line = vim.api.nvim_get_current_line()
    return line:sub(col, col):match("%s") == nil
end

local show_if_words_before = function(cmp)
    if has_words_before() then
        return cmp.show()
    end
end

return {
    "Saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local blink = require("blink.cmp")
        local opts = {
            keymap = {
                preset = "none",
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-n>"] = { "snippet_forward", "select_next", "fallback_to_mappings" },
                ["<C-p>"] = { "snippet_backward", "select_prev", "fallback_to_mappings" },
                ["<C-u>"] = { "scroll_documentation_up", "fallback" },
                ["<C-d>"] = { "scroll_documentation_down", "fallback" },
                ["<C-o>"] = { "show_documentation", "hide_documentation", "fallback" },
                ["<Esc>"] = { "cancel", "fallback" },
                ["<Tab>"] = { show_if_words_before, "select_and_accept", "fallback_to_mappings" },
            },
            snippets = { preset = "luasnip" },
            completion = {
                list = { selection = { auto_insert = false } },
                ghost_text = { enabled = false },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 000,
                },
                menu = {
                    draw = {
                        padding = { 2, 1 },
                        gap = 1,
                        cursorline_priority = 0,
                        columns = {
                            { "label", "label_description", gap = 1 },
                            { "kind_icon", "kind", gap = 1 },
                            -- { "source_name" },
                        },
                        components = {
                            kind = {
                                text = function(ctx)
                                    local kinds = {
                                        "Constant",
                                        "Module",
                                        "Keyword",
                                        "Class",
                                        "Function",
                                        "Variable",
                                        "Snippet",
                                        "Property",
                                        "Text",
                                        "Field",
                                        "Enum",
                                    }
                                    if not vim.tbl_contains(kinds, ctx.kind, {}) then
                                        vim.notify(
                                            "highlight group kind " .. ctx.kind .. " has not been setup yet",
                                            vim.log.levels.WARN
                                        )
                                    end
                                    return ctx.kind
                                end,
                            },
                        },
                    },
                },
            },
            signature = {},
            cmdline = {
                keymap = {
                    preset = "inherit",
                    ["<Tab>"] = { "show", "select_and_accept" },
                },
                completion = { menu = { auto_show = true } },
            },
            sources = {
                default = {
                    "lsp",
                    "path",
                    "buffer",
                    "snippets",
                    "avante",
                    "lazydev",
                    "conventional_commits",
                },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        -- make lazydev completions top priority (see `:h blink.cmp`)
                        score_offset = 100,
                    },
                    avante = {
                        module = "blink-cmp-avante",
                        name = "Avante",
                        opts = {
                            -- options for blink-cmp-avante
                        },
                    },
                    conventional_commits = {
                        name = "ConventionalCommits",
                        module = "blink-cmp-conventional-commits",
                        enabled = function()
                            return vim.bo.filetype == "gitcommit"
                        end,
                        ---@module 'blink-cmp-conventional-commits'
                        ---@type blink-cmp-conventional-commits.Options
                        opts = {}, -- none so far
                    },
                },
            },
        }
        blink.setup(opts)
    end,
    dependencies = {
        { "L3MON4D3/LuaSnip", version = "v2.*" },
        "Kaiser-Yang/blink-cmp-avante",
        "disrupted/blink-cmp-conventional-commits",
        "folke/lazydev.nvim",
        --  "Kaiser-Yang/blink-cmp-git"
        -- "archie-judd/blink-cmp-words"
        -- "bydlw98/blink-cmp-env"
    },
}
