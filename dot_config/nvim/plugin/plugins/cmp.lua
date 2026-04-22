vim.pack.add({
    { src = "gh:saghen/blink.cmp", version = vim.version.range("1.x") },
    { src = "gh:L3MON4D3/LuaSnip", version = vim.version.range("2.x") },
    "gh:disrupted/blink-cmp-conventional-commits",
    "gh:folke/lazydev.nvim",
    -- "gh:Kaiser-Yang/blink-cmp-git"
    -- "gh:kristijanhusak/vim-dadbod-completion",
    -- "gh:bydlw98/blink-cmp-sshconfig",
    -- "gh:barrettruth/blink-cmp-ghostty",
    -- "gh:Kaiser-Yang/blink-cmp-dictionary",
    -- "gh:barrettruth/blink-cmp-tmux",
    -- "gh:mgalliou/blink-cmp-tmux",
})

local function has_words_before()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    if col == 0 then return false end
    local line = vim.api.nvim_get_current_line()
    return line:sub(col, col):match("%s") == nil
end

local function show_if_words_before(cmp)
    if has_words_before() then return cmp.show() end
end

-- stylua: ignore
local configured_kinds = {"Module", "Class", "Function", "Method", "Keyword", "Constant", "Variable", "Value", "Property", "Field", "Enum", "EnumMember", "Struct", "Interface", "Reference", "TypeParameter", "Snippet", "Text",}

require("blink.cmp").setup({
    -- stylua: ignore
    keymap = {
        preset = "none",
        ["<Up>"]   = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-n>"]  = { "snippet_forward", "select_next", "fallback_to_mappings" },
        ["<C-p>"]  = { "snippet_backward", "select_prev", "fallback_to_mappings" },
        ["<C-u>"]  = { "scroll_documentation_up", "fallback" },
        ["<C-d>"]  = { "scroll_documentation_down", "fallback" },
        ["<C-o>"]  = { "show_documentation", "hide_documentation", "fallback" },
        ["<C-y>"]  = { "select_and_accept", "fallback_to_mappings" },
        ["<Esc>"]  = { "cancel", "fallback" },
        ["<Tab>"]  = { show_if_words_before, "select_and_accept", "fallback_to_mappings" },
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
                    { "source_name" },
                },
                components = {
                    kind = {
                        text = function(ctx)
                            if not vim.tbl_contains(configured_kinds, ctx.kind, {}) then
                                configured_kinds[#configured_kinds + 1] = ctx.kind
                                vim.notify("No highlight: " .. ctx.kind, vim.log.levels.WARN)
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
            "lazydev",
            "conventional_commits",
        },
        providers = {
            lazydev = {
                name = "LazyDev",
                module = "lazydev.integrations.blink",
                score_offset = 100, -- make lazydev completions top priority (see `:h blink.cmp`)
            },
            conventional_commits = {
                name = "ConventionalCommits",
                module = "blink-cmp-conventional-commits",
                enabled = function() return vim.bo.filetype == "gitcommit" end,
                ---@module 'blink-cmp-conventional-commits'
                ---@type blink-cmp-conventional-commits.Options
                opts = {}, -- none so far
            },
        },
    },
})
